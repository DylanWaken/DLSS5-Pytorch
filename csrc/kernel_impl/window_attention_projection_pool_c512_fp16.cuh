// Readable equivalent of cc_split_swin_16h_proj_pool_512; not historical source.
#pragma once
#include "window_attention_projection_pool_c512_abi_fp16.cuh"

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
__global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_SharedStorage[8208];
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
	bool r_bPtxPredicate481, r_bPtxPredicate482, r_bPtxPredicate483, r_bPtxPredicate484, r_bPtxPredicate485,
		r_bPtxPredicate486, r_bPtxPredicate487, r_bPtxPredicate488, r_bPtxPredicate489, r_bPtxPredicate490,
		r_bPtxPredicate491, r_bPtxPredicate492;
	bool r_bPtxPredicate493, r_bPtxPredicate494, r_bPtxPredicate495, r_bPtxPredicate496, r_bPtxPredicate497,
		r_bPtxPredicate498, r_bPtxPredicate499, r_bPtxPredicate500, r_bPtxPredicate501, r_bPtxPredicate502,
		r_bPtxPredicate503, r_bPtxPredicate504;
	bool r_bPtxPredicate505, r_bPtxPredicate506, r_bPtxPredicate507, r_bPtxPredicate508, r_bPtxPredicate509,
		r_bPtxPredicate510, r_bPtxPredicate511, r_bPtxPredicate512, r_bPtxPredicate513, r_bPtxPredicate514,
		r_bPtxPredicate515, r_bPtxPredicate516;
	bool r_bPtxPredicate517, r_bPtxPredicate518, r_bPtxPredicate519, r_bPtxPredicate520, r_bPtxPredicate521,
		r_bPtxPredicate522, r_bPtxPredicate523, r_bPtxPredicate524, r_bPtxPredicate525, r_bPtxPredicate526,
		r_bPtxPredicate527, r_bPtxPredicate528;
	bool r_bPtxPredicate529, r_bPtxPredicate530, r_bPtxPredicate531, r_bPtxPredicate532, r_bPtxPredicate533,
		r_bPtxPredicate534, r_bPtxPredicate535, r_bPtxPredicate536, r_bPtxPredicate537, r_bPtxPredicate538,
		r_bPtxPredicate539, r_bPtxPredicate540;
	bool r_bPtxPredicate541, r_bPtxPredicate542, r_bPtxPredicate543, r_bPtxPredicate544;
	uint16_t r_PtxU16Register1;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
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
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_PtxRegister190,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244, r_PtxRegister245,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_Scalar64Bits, r_Scalar68Bits, r_Scalar72Bits, r_Scalar76Bits, r_CtaX, r_CtaY, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_ThreadX, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293, r_BlockSizeX,
		r_BlockSizeY, r_Float32BitsAtPtx61R296, r_LaneIndexAtPtx77, r_LaneIndexAtPtx86, r_LaneIndexAtPtx96,
		r_LaneIndexAtPtx106;
	uint32_t r_LaneIndexAtPtx115, r_LaneIndexAtPtx124, r_LaneIndexAtPtx133, r_LaneIndexAtPtx142,
		r_PtxRegister305, r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309,
		r_PtxRegister310, r_PtxRegister311, r_PtxRegister312;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316, r_PtxRegister317,
		r_PtxRegister318, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321, r_PtxRegister322,
		r_PtxRegister323, r_LaneIndexAtPtx216;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PtxRegister331, r_PtxRegister332, r_PtxRegister333, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_PtxRegister337, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341,
		r_PtxRegister342, r_PtxRegister343, r_LaneIndexAtPtx284, r_PtxRegister345, r_PackedHalf2AtPtx63R346,
		r_PtxRegister347, r_PtxRegister348;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_PtxRegister353,
		r_PtxRegister354, r_PtxRegister355, r_LaneIndexAtPtx337, r_PtxRegister357, r_PtxRegister358,
		r_PtxRegister359, r_LaneIndexAtPtx356;
	uint32_t r_PtxRegister361, r_PtxRegister362, r_PtxRegister363, r_LaneIndexAtPtx375, r_PtxRegister365,
		r_PtxRegister366, r_PtxRegister367, r_LaneIndexAtPtx394, r_PtxRegister369, r_PtxRegister370,
		r_PtxRegister371, r_LaneIndexAtPtx419;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_PtxRegister375, r_LaneIndexAtPtx438, r_PtxRegister377,
		r_PtxRegister378, r_PtxRegister379, r_LaneIndexAtPtx457, r_PtxRegister381, r_PtxRegister382,
		r_PtxRegister383, r_LaneIndexAtPtx476;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_PtxRegister387, r_PtxRegister388, r_PtxRegister389,
		r_LaneIndexAtPtx512, r_PtxRegister391, r_PtxRegister392, r_PtxRegister393, r_LaneIndexAtPtx531,
		r_PtxRegister395, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_LaneIndexAtPtx550, r_PtxRegister399, r_PtxRegister400, r_PtxRegister401,
		r_LaneIndexAtPtx569, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405, r_LaneIndexAtPtx593,
		r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_LaneIndexAtPtx612, r_PtxRegister411, r_PtxRegister412, r_PtxRegister413,
		r_LaneIndexAtPtx631, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417, r_LaneIndexAtPtx650,
		r_PtxRegister419, r_PtxRegister420;
	uint32_t r_PtxRegister421, r_LaneIndexAtPtx662, r_LaneIndexAtPtx676, r_LaneIndexAtPtx690,
		r_LaneIndexAtPtx704, r_LaneIndexAtPtx718, r_LaneIndexAtPtx732, r_LaneIndexAtPtx746,
		r_LaneIndexAtPtx763, r_LaneIndexAtPtx779, r_LaneIndexAtPtx794, r_LaneIndexAtPtx808;
	uint32_t r_LaneIndexAtPtx825, r_LaneIndexAtPtx841, r_LaneIndexAtPtx856, r_LaneIndexAtPtx870,
		r_LaneIndexAtPtx887, r_LaneIndexAtPtx903, r_LaneIndexAtPtx917, r_LaneIndexAtPtx931,
		r_LaneIndexAtPtx945, r_LaneIndexAtPtx959, r_LaneIndexAtPtx973, r_LaneIndexAtPtx987;
	uint32_t r_LaneIndexAtPtx1003, r_LaneIndexAtPtx1019, r_LaneIndexAtPtx1033, r_LaneIndexAtPtx1047,
		r_LaneIndexAtPtx1063, r_LaneIndexAtPtx1079, r_LaneIndexAtPtx1093, r_LaneIndexAtPtx1107,
		r_LaneIndexAtPtx1123, r_LaneIndexAtPtx1139, r_LaneIndexAtPtx1153, r_LaneIndexAtPtx1167;
	uint32_t r_LaneIndexAtPtx1181, r_LaneIndexAtPtx1195, r_LaneIndexAtPtx1209, r_LaneIndexAtPtx1223,
		r_LaneIndexAtPtx1239, r_LaneIndexAtPtx1255, r_LaneIndexAtPtx1269, r_LaneIndexAtPtx1283,
		r_LaneIndexAtPtx1299, r_LaneIndexAtPtx1315, r_LaneIndexAtPtx1329, r_LaneIndexAtPtx1343;
	uint32_t r_LaneIndexAtPtx1359, r_LaneIndexAtPtx1375, r_LaneIndexAtPtx1389, r_LaneIndexAtPtx1403,
		r_LaneIndexAtPtx1417, r_LaneIndexAtPtx1431, r_LaneIndexAtPtx1445, r_LaneIndexAtPtx1459,
		r_LaneIndexAtPtx1475, r_LaneIndexAtPtx1491, r_LaneIndexAtPtx1505, r_LaneIndexAtPtx1519;
	uint32_t r_LaneIndexAtPtx1535, r_LaneIndexAtPtx1551, r_LaneIndexAtPtx1565, r_LaneIndexAtPtx1579,
		r_LaneIndexAtPtx1595, r_LaneIndexAtPtx1611, r_PtxRegister487, r_LaneIndexAtPtx1618, r_PtxRegister489,
		r_LaneIndexAtPtx1625, r_PtxRegister491, r_LaneIndexAtPtx1632;
	uint32_t r_PtxRegister493, r_LaneIndexAtPtx1639, r_PtxRegister495, r_LaneIndexAtPtx1646, r_PtxRegister497,
		r_LaneIndexAtPtx1653, r_PtxRegister499, r_LaneIndexAtPtx1660, r_PtxRegister501, r_LaneIndexAtPtx1667,
		r_PtxRegister503, r_LaneIndexAtPtx1674;
	uint32_t r_PtxRegister505, r_LaneIndexAtPtx1681, r_PtxRegister507, r_LaneIndexAtPtx1688, r_PtxRegister509,
		r_LaneIndexAtPtx1695, r_PtxRegister511, r_LaneIndexAtPtx1702, r_PtxRegister513, r_LaneIndexAtPtx1709,
		r_PtxRegister515, r_LaneIndexAtPtx1716;
	uint32_t r_PtxRegister517, r_LaneIndexAtPtx1723, r_PtxRegister519, r_LaneIndexAtPtx1730, r_PtxRegister521,
		r_LaneIndexAtPtx1737, r_PtxRegister523, r_LaneIndexAtPtx1744, r_PtxRegister525, r_LaneIndexAtPtx1751,
		r_PtxRegister527, r_LaneIndexAtPtx1758;
	uint32_t r_PtxRegister529, r_LaneIndexAtPtx1765, r_PtxRegister531, r_LaneIndexAtPtx1772, r_PtxRegister533,
		r_LaneIndexAtPtx1779, r_PtxRegister535, r_LaneIndexAtPtx1786, r_PtxRegister537, r_LaneIndexAtPtx1793,
		r_PtxRegister539, r_LaneIndexAtPtx1800;
	uint32_t r_PtxRegister541, r_LaneIndexAtPtx1807, r_PtxRegister543, r_LaneIndexAtPtx1814, r_PtxRegister545,
		r_LaneIndexAtPtx1821, r_PtxRegister547, r_LaneIndexAtPtx1828, r_PtxRegister549, r_LaneIndexAtPtx1835,
		r_PtxRegister551, r_LaneIndexAtPtx1842;
	uint32_t r_PtxRegister553, r_LaneIndexAtPtx1849, r_PtxRegister555, r_LaneIndexAtPtx1856, r_PtxRegister557,
		r_LaneIndexAtPtx1863, r_PtxRegister559, r_LaneIndexAtPtx1870, r_PtxRegister561, r_LaneIndexAtPtx1877,
		r_PtxRegister563, r_LaneIndexAtPtx1884;
	uint32_t r_PtxRegister565, r_LaneIndexAtPtx1891, r_PtxRegister567, r_LaneIndexAtPtx1898, r_PtxRegister569,
		r_LaneIndexAtPtx1905, r_PtxRegister571, r_LaneIndexAtPtx1912, r_PtxRegister573, r_LaneIndexAtPtx1919,
		r_PtxRegister575, r_LaneIndexAtPtx1926;
	uint32_t r_PtxRegister577, r_LaneIndexAtPtx1933, r_PtxRegister579, r_LaneIndexAtPtx1940, r_PtxRegister581,
		r_LaneIndexAtPtx1947, r_PtxRegister583, r_LaneIndexAtPtx1954, r_PtxRegister585, r_LaneIndexAtPtx1961,
		r_PtxRegister587, r_LaneIndexAtPtx1968;
	uint32_t r_PtxRegister589, r_LaneIndexAtPtx1975, r_PtxRegister591, r_LaneIndexAtPtx1982, r_PtxRegister593,
		r_LaneIndexAtPtx1989, r_PtxRegister595, r_LaneIndexAtPtx1996, r_PtxRegister597, r_LaneIndexAtPtx2003,
		r_PtxRegister599, r_LaneIndexAtPtx2010;
	uint32_t r_PtxRegister601, r_LaneIndexAtPtx2017, r_PtxRegister603, r_LaneIndexAtPtx2024, r_PtxRegister605,
		r_LaneIndexAtPtx2031, r_PtxRegister607, r_LaneIndexAtPtx2038, r_PtxRegister609, r_LaneIndexAtPtx2045,
		r_PtxRegister611, r_LaneIndexAtPtx2052;
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
		r_PtxRegister1110, r_PtxRegister1111, r_PtxRegister1112, r_PtxRegister1113, r_PtxRegister1114,
		r_PtxRegister1115, r_PtxRegister1116;
	uint32_t r_PtxRegister1117, r_PtxRegister1118, r_PtxRegister1119, r_PtxRegister1120, r_PtxRegister1121,
		r_PtxRegister1122, r_PtxRegister1123, r_PtxRegister1124, r_PtxRegister1125, r_PtxRegister1126,
		r_PtxRegister1127, r_PtxRegister1128;
	uint32_t r_PtxRegister1129, r_PtxRegister1130, r_PtxRegister1131, r_PtxRegister1132, r_PtxRegister1133,
		r_PtxRegister1134, r_PtxRegister1135, r_PtxRegister1136, r_PtxRegister1137, r_PtxRegister1138,
		r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_PtxRegister1141, r_PtxRegister1142, r_PtxRegister1143, r_PtxRegister1144, r_PtxRegister1145,
		r_PtxRegister1146, r_PtxRegister1147, r_PtxRegister1148, r_PtxRegister1149, r_PtxRegister1150,
		r_PtxRegister1151, r_PtxRegister1152;
	uint32_t r_PtxRegister1153, r_PtxRegister1154, r_PtxRegister1155, r_PtxRegister1156, r_PtxRegister1157,
		r_PtxRegister1158, r_PtxRegister1159, r_PtxRegister1160, r_PtxRegister1161, r_PtxRegister1162,
		r_PtxRegister1163, r_PtxRegister1164;
	uint32_t r_PtxRegister1165, r_PtxRegister1166, r_PtxRegister1167, r_PtxRegister1168, r_PtxRegister1169,
		r_PtxRegister1170, r_PtxRegister1171, r_PtxRegister1172, r_PtxRegister1173, r_PtxRegister1174,
		r_PtxRegister1175, r_PtxRegister1176;
	uint32_t r_PtxRegister1177, r_PtxRegister1178, r_PtxRegister1179, r_PtxRegister1180, r_LaneIndexAtPtx2078,
		r_PtxRegister1182, r_LaneIndexAtPtx2086, r_PtxRegister1184, r_LaneIndexAtPtx2095, r_PtxRegister1186,
		r_LaneIndexAtPtx2104, r_PtxRegister1188;
	uint32_t r_LaneIndexAtPtx2113, r_PtxRegister1190, r_LaneIndexAtPtx2122, r_PtxRegister1192,
		r_LaneIndexAtPtx2131, r_PtxRegister1194, r_LaneIndexAtPtx2140, r_PtxRegister1196,
		r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
		r_MmaAHalf2WordAtPtx2083R1200;
	uint32_t r_MmaAHalf2WordAtPtx2092R1201, r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203,
		r_MmaAHalf2WordAtPtx2092R1204, r_MmaAccumulatorHalf2WordAtPtx2149R1205,
		r_MmaAccumulatorHalf2WordAtPtx2149R1206, r_MmaAccumulatorHalf2WordAtPtx2156R1207,
		r_MmaAccumulatorHalf2WordAtPtx2156R1208, r_MmaAccumulatorHalf2WordAtPtx2177R1209,
		r_MmaAccumulatorHalf2WordAtPtx2177R1210, r_MmaAccumulatorHalf2WordAtPtx2184R1211,
		r_MmaAccumulatorHalf2WordAtPtx2184R1212;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2205R1213, r_MmaAccumulatorHalf2WordAtPtx2205R1214,
		r_MmaAccumulatorHalf2WordAtPtx2212R1215, r_MmaAccumulatorHalf2WordAtPtx2212R1216,
		r_MmaAccumulatorHalf2WordAtPtx2233R1217, r_MmaAccumulatorHalf2WordAtPtx2233R1218,
		r_MmaAccumulatorHalf2WordAtPtx2240R1219, r_MmaAccumulatorHalf2WordAtPtx2240R1220,
		r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
		r_MmaAHalf2WordAtPtx2101R1224;
	uint32_t r_MmaAHalf2WordAtPtx2110R1225, r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227,
		r_MmaAHalf2WordAtPtx2110R1228, r_MmaAccumulatorHalf2WordAtPtx2261R1229,
		r_MmaAccumulatorHalf2WordAtPtx2261R1230, r_MmaAccumulatorHalf2WordAtPtx2268R1231,
		r_MmaAccumulatorHalf2WordAtPtx2268R1232, r_MmaAccumulatorHalf2WordAtPtx2289R1233,
		r_MmaAccumulatorHalf2WordAtPtx2289R1234, r_MmaAccumulatorHalf2WordAtPtx2296R1235,
		r_MmaAccumulatorHalf2WordAtPtx2296R1236;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2317R1237, r_MmaAccumulatorHalf2WordAtPtx2317R1238,
		r_MmaAccumulatorHalf2WordAtPtx2324R1239, r_MmaAccumulatorHalf2WordAtPtx2324R1240,
		r_MmaAccumulatorHalf2WordAtPtx2345R1241, r_MmaAccumulatorHalf2WordAtPtx2345R1242,
		r_MmaAccumulatorHalf2WordAtPtx2352R1243, r_MmaAccumulatorHalf2WordAtPtx2352R1244,
		r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
		r_MmaAHalf2WordAtPtx2119R1248;
	uint32_t r_MmaAHalf2WordAtPtx2128R1249, r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251,
		r_MmaAHalf2WordAtPtx2128R1252, r_MmaAccumulatorHalf2WordAtPtx2373R1253,
		r_MmaAccumulatorHalf2WordAtPtx2373R1254, r_MmaAccumulatorHalf2WordAtPtx2380R1255,
		r_MmaAccumulatorHalf2WordAtPtx2380R1256, r_MmaAccumulatorHalf2WordAtPtx2401R1257,
		r_MmaAccumulatorHalf2WordAtPtx2401R1258, r_MmaAccumulatorHalf2WordAtPtx2408R1259,
		r_MmaAccumulatorHalf2WordAtPtx2408R1260;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2429R1261, r_MmaAccumulatorHalf2WordAtPtx2429R1262,
		r_MmaAccumulatorHalf2WordAtPtx2436R1263, r_MmaAccumulatorHalf2WordAtPtx2436R1264,
		r_MmaAccumulatorHalf2WordAtPtx2457R1265, r_MmaAccumulatorHalf2WordAtPtx2457R1266,
		r_MmaAccumulatorHalf2WordAtPtx2464R1267, r_MmaAccumulatorHalf2WordAtPtx2464R1268,
		r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
		r_MmaAHalf2WordAtPtx2137R1272;
	uint32_t r_MmaAHalf2WordAtPtx2146R1273, r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275,
		r_MmaAHalf2WordAtPtx2146R1276, r_MmaAccumulatorHalf2WordAtPtx2485R1277,
		r_MmaAccumulatorHalf2WordAtPtx2485R1278, r_MmaAccumulatorHalf2WordAtPtx2492R1279,
		r_MmaAccumulatorHalf2WordAtPtx2492R1280, r_MmaAccumulatorHalf2WordAtPtx2513R1281,
		r_MmaAccumulatorHalf2WordAtPtx2513R1282, r_MmaAccumulatorHalf2WordAtPtx2520R1283,
		r_MmaAccumulatorHalf2WordAtPtx2520R1284;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2541R1285, r_MmaAccumulatorHalf2WordAtPtx2541R1286,
		r_MmaAccumulatorHalf2WordAtPtx2548R1287, r_MmaAccumulatorHalf2WordAtPtx2548R1288,
		r_MmaAccumulatorHalf2WordAtPtx2569R1289, r_MmaAccumulatorHalf2WordAtPtx2569R1290,
		r_MmaAccumulatorHalf2WordAtPtx2576R1291, r_MmaAccumulatorHalf2WordAtPtx2576R1292, r_PtxRegister1293,
		r_PtxRegister1294, r_PtxRegister1295, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305, r_PtxRegister1306,
		r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_PtxRegister1310, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_PtxRegister1315, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_LaneIndexAtPtx2651,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_LaneIndexAtPtx2716, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_LaneIndexAtPtx2730,
		r_LaneIndexAtPtx2738, r_LaneIndexAtPtx2747, r_LaneIndexAtPtx2756, r_LaneIndexAtPtx2765,
		r_LaneIndexAtPtx2774, r_LaneIndexAtPtx2783, r_LaneIndexAtPtx2792;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_LaneIndexAtPtx2819,
		r_PtxRegister1374, r_LaneIndexAtPtx2829, r_PtxRegister1376, r_LaneIndexAtPtx2838, r_PtxRegister1378,
		r_LaneIndexAtPtx2847, r_PtxRegister1380;
	uint32_t r_LaneIndexAtPtx2856, r_PtxRegister1382, r_LaneIndexAtPtx2865, r_PtxRegister1384,
		r_LaneIndexAtPtx2874, r_PtxRegister1386, r_LaneIndexAtPtx2883, r_PtxRegister1388,
		r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
		r_MmaAHalf2WordAtPtx2826R1392;
	uint32_t r_MmaAHalf2WordAtPtx2835R1393, r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395,
		r_MmaAHalf2WordAtPtx2835R1396, r_MmaAccumulatorHalf2WordAtPtx2892R1397,
		r_MmaAccumulatorHalf2WordAtPtx2892R1398, r_MmaAccumulatorHalf2WordAtPtx2899R1399,
		r_MmaAccumulatorHalf2WordAtPtx2899R1400, r_MmaAccumulatorHalf2WordAtPtx2920R1401,
		r_MmaAccumulatorHalf2WordAtPtx2920R1402, r_MmaAccumulatorHalf2WordAtPtx2927R1403,
		r_MmaAccumulatorHalf2WordAtPtx2927R1404;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2948R1405, r_MmaAccumulatorHalf2WordAtPtx2948R1406,
		r_MmaAccumulatorHalf2WordAtPtx2955R1407, r_MmaAccumulatorHalf2WordAtPtx2955R1408,
		r_MmaAccumulatorHalf2WordAtPtx2976R1409, r_MmaAccumulatorHalf2WordAtPtx2976R1410,
		r_MmaAccumulatorHalf2WordAtPtx2983R1411, r_MmaAccumulatorHalf2WordAtPtx2983R1412,
		r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
		r_MmaAHalf2WordAtPtx2844R1416;
	uint32_t r_MmaAHalf2WordAtPtx2853R1417, r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419,
		r_MmaAHalf2WordAtPtx2853R1420, r_MmaAccumulatorHalf2WordAtPtx3004R1421,
		r_MmaAccumulatorHalf2WordAtPtx3004R1422, r_MmaAccumulatorHalf2WordAtPtx3011R1423,
		r_MmaAccumulatorHalf2WordAtPtx3011R1424, r_MmaAccumulatorHalf2WordAtPtx3032R1425,
		r_MmaAccumulatorHalf2WordAtPtx3032R1426, r_MmaAccumulatorHalf2WordAtPtx3039R1427,
		r_MmaAccumulatorHalf2WordAtPtx3039R1428;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3060R1429, r_MmaAccumulatorHalf2WordAtPtx3060R1430,
		r_MmaAccumulatorHalf2WordAtPtx3067R1431, r_MmaAccumulatorHalf2WordAtPtx3067R1432,
		r_MmaAccumulatorHalf2WordAtPtx3088R1433, r_MmaAccumulatorHalf2WordAtPtx3088R1434,
		r_MmaAccumulatorHalf2WordAtPtx3095R1435, r_MmaAccumulatorHalf2WordAtPtx3095R1436,
		r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
		r_MmaAHalf2WordAtPtx2862R1440;
	uint32_t r_MmaAHalf2WordAtPtx2871R1441, r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443,
		r_MmaAHalf2WordAtPtx2871R1444, r_MmaAccumulatorHalf2WordAtPtx3116R1445,
		r_MmaAccumulatorHalf2WordAtPtx3116R1446, r_MmaAccumulatorHalf2WordAtPtx3123R1447,
		r_MmaAccumulatorHalf2WordAtPtx3123R1448, r_MmaAccumulatorHalf2WordAtPtx3144R1449,
		r_MmaAccumulatorHalf2WordAtPtx3144R1450, r_MmaAccumulatorHalf2WordAtPtx3151R1451,
		r_MmaAccumulatorHalf2WordAtPtx3151R1452;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3172R1453, r_MmaAccumulatorHalf2WordAtPtx3172R1454,
		r_MmaAccumulatorHalf2WordAtPtx3179R1455, r_MmaAccumulatorHalf2WordAtPtx3179R1456,
		r_MmaAccumulatorHalf2WordAtPtx3200R1457, r_MmaAccumulatorHalf2WordAtPtx3200R1458,
		r_MmaAccumulatorHalf2WordAtPtx3207R1459, r_MmaAccumulatorHalf2WordAtPtx3207R1460,
		r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
		r_MmaAHalf2WordAtPtx2880R1464;
	uint32_t r_MmaAHalf2WordAtPtx2889R1465, r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467,
		r_MmaAHalf2WordAtPtx2889R1468, r_MmaAccumulatorHalf2WordAtPtx3228R1469,
		r_MmaAccumulatorHalf2WordAtPtx3228R1470, r_MmaAccumulatorHalf2WordAtPtx3235R1471,
		r_MmaAccumulatorHalf2WordAtPtx3235R1472, r_MmaAccumulatorHalf2WordAtPtx3256R1473,
		r_MmaAccumulatorHalf2WordAtPtx3256R1474, r_MmaAccumulatorHalf2WordAtPtx3263R1475,
		r_MmaAccumulatorHalf2WordAtPtx3263R1476;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3284R1477, r_MmaAccumulatorHalf2WordAtPtx3284R1478,
		r_MmaAccumulatorHalf2WordAtPtx3291R1479, r_MmaAccumulatorHalf2WordAtPtx3291R1480,
		r_MmaAccumulatorHalf2WordAtPtx3312R1481, r_MmaAccumulatorHalf2WordAtPtx3312R1482,
		r_MmaAccumulatorHalf2WordAtPtx3319R1483, r_MmaAccumulatorHalf2WordAtPtx3319R1484, r_PtxRegister1485,
		r_PtxRegister1486, r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_PtxRegister1490, r_PtxRegister1491, r_PtxRegister1492, r_PtxRegister1493,
		r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497, r_PtxRegister1498,
		r_PtxRegister1499, r_PtxRegister1500;
	uint32_t r_PtxRegister1501, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_LaneIndexAtPtx3348,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_LaneIndexAtPtx3356,
		r_PtxRegister1511, r_PtxRegister1512;
	uint32_t r_PtxRegister1513, r_PtxRegister1514, r_LaneIndexAtPtx3365, r_PtxRegister1516, r_PtxRegister1517,
		r_PtxRegister1518, r_PtxRegister1519, r_LaneIndexAtPtx3374, r_PtxRegister1521, r_PtxRegister1522,
		r_PtxRegister1523, r_PtxRegister1524;
	uint32_t r_LaneIndexAtPtx3389, r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528, r_PtxRegister1529,
		r_LaneIndexAtPtx3398, r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533, r_PtxRegister1534,
		r_LaneIndexAtPtx3407, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_PtxRegister1538, r_PtxRegister1539, r_LaneIndexAtPtx3416, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PtxRegister1545, r_PtxRegister1546,
		r_PtxRegister1547, r_PtxRegister1548;
	uint32_t r_LaneIndexAtPtx3437, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_LaneIndexAtPtx3445, r_PtxRegister1555, r_PtxRegister1556, r_PtxRegister1557, r_PtxRegister1558,
		r_LaneIndexAtPtx3454, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_PtxRegister1563, r_LaneIndexAtPtx3463, r_PtxRegister1565,
		r_PtxRegister1566, r_PtxRegister1567, r_PtxRegister1568, r_LaneIndexAtPtx3477, r_PtxRegister1570,
		r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_LaneIndexAtPtx3486, r_PtxRegister1575, r_PtxRegister1576, r_PtxRegister1577,
		r_PtxRegister1578, r_LaneIndexAtPtx3495, r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
		r_PtxRegister1583, r_LaneIndexAtPtx3504;
	uint32_t r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587, r_PtxRegister1588, r_LaneIndexAtPtx3518,
		r_PtxRegister1590, r_PtxRegister1591, r_PtxRegister1592, r_PtxRegister1593, r_PtxRegister1594,
		r_PtxRegister1595, r_PtxRegister1596;
	uint32_t r_PtxRegister1597, r_PtxRegister1598, r_PtxRegister1599, r_PtxRegister1600, r_PtxRegister1601,
		r_PtxRegister1602, r_PackedHalf2AtPtx3581R1603, r_PackedHalf2AtPtx3585R1604, r_PtxRegister1605,
		r_PackedHalf2AtPtx3589R1606, r_LaneIndexAtPtx3603, r_PtxRegister1608;
	uint32_t r_PtxRegister1609, r_PtxRegister1610, r_PtxRegister1611, r_PtxRegister1612, r_PtxRegister1613,
		r_PtxRegister1614, r_PtxRegister1615, r_PtxRegister1616, r_PtxRegister1617,
		r_PackedHalf2AtPtx3666R1618, r_PackedHalf2AtPtx3670R1619, r_PackedHalf2AtPtx3674R1620;
	uint32_t r_LaneIndexAtPtx3682, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_PtxRegister1626, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_PtxRegister1631, r_PackedHalf2AtPtx3745R1632;
	uint32_t r_PackedHalf2AtPtx3749R1633, r_PackedHalf2AtPtx3753R1634, r_LaneIndexAtPtx3761,
		r_PtxRegister1636, r_PtxRegister1637, r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640,
		r_PtxRegister1641, r_PtxRegister1642, r_PtxRegister1643, r_PtxRegister1644;
	uint32_t r_PtxRegister1645, r_PackedHalf2AtPtx3824R1646, r_PackedHalf2AtPtx3828R1647,
		r_PackedHalf2AtPtx3832R1648, r_LaneIndexAtPtx3840, r_PtxRegister1650, r_PtxRegister1651,
		r_PtxRegister1652, r_PtxRegister1653, r_PtxRegister1654, r_PtxRegister1655, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_PtxRegister1658, r_PtxRegister1659, r_PackedHalf2AtPtx3903R1660,
		r_PackedHalf2AtPtx3907R1661, r_PackedHalf2AtPtx3911R1662, r_LaneIndexAtPtx3919, r_PtxRegister1664,
		r_PtxRegister1665, r_PtxRegister1666, r_PtxRegister1667, r_PtxRegister1668;
	uint32_t r_PtxRegister1669, r_PtxRegister1670, r_PtxRegister1671, r_PtxRegister1672, r_PtxRegister1673,
		r_PackedHalf2AtPtx3982R1674, r_PackedHalf2AtPtx3986R1675, r_PackedHalf2AtPtx3990R1676,
		r_LaneIndexAtPtx3998, r_PtxRegister1678, r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PackedHalf2AtPtx4061R1688, r_PackedHalf2AtPtx4065R1689,
		r_PackedHalf2AtPtx4069R1690, r_LaneIndexAtPtx4077, r_PtxRegister1692;
	uint32_t r_PtxRegister1693, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700, r_PtxRegister1701,
		r_PackedHalf2AtPtx4140R1702, r_PackedHalf2AtPtx4144R1703, r_PackedHalf2AtPtx4148R1704;
	uint32_t r_LaneIndexAtPtx4156, r_PtxRegister1706, r_PtxRegister1707, r_PtxRegister1708, r_PtxRegister1709,
		r_PtxRegister1710, r_PtxRegister1711, r_PtxRegister1712, r_PtxRegister1713, r_PtxRegister1714,
		r_PtxRegister1715, r_PackedHalf2AtPtx4219R1716;
	uint32_t r_PackedHalf2AtPtx4223R1717, r_PackedHalf2AtPtx4227R1718, r_LaneIndexAtPtx4235,
		r_PtxRegister1720, r_PtxRegister1721, r_PtxRegister1722, r_PtxRegister1723, r_PtxRegister1724,
		r_PtxRegister1725, r_PtxRegister1726, r_PtxRegister1727, r_PtxRegister1728;
	uint32_t r_PtxRegister1729, r_PackedHalf2AtPtx4298R1730, r_PackedHalf2AtPtx4302R1731,
		r_PackedHalf2AtPtx4306R1732, r_LaneIndexAtPtx4314, r_PtxRegister1734, r_PtxRegister1735,
		r_PtxRegister1736, r_PtxRegister1737, r_PtxRegister1738, r_PtxRegister1739, r_PtxRegister1740;
	uint32_t r_PtxRegister1741, r_PtxRegister1742, r_PtxRegister1743, r_PackedHalf2AtPtx4377R1744,
		r_PackedHalf2AtPtx4381R1745, r_PackedHalf2AtPtx4385R1746, r_LaneIndexAtPtx4393, r_PtxRegister1748,
		r_PtxRegister1749, r_PtxRegister1750, r_PtxRegister1751, r_PtxRegister1752;
	uint32_t r_PtxRegister1753, r_PtxRegister1754, r_PtxRegister1755, r_PtxRegister1756, r_PtxRegister1757,
		r_PackedHalf2AtPtx4456R1758, r_PackedHalf2AtPtx4460R1759, r_PackedHalf2AtPtx4464R1760,
		r_LaneIndexAtPtx4472, r_PtxRegister1762, r_PtxRegister1763, r_PtxRegister1764;
	uint32_t r_PtxRegister1765, r_PtxRegister1766, r_PtxRegister1767, r_PtxRegister1768, r_PtxRegister1769,
		r_PtxRegister1770, r_PtxRegister1771, r_PackedHalf2AtPtx4535R1772, r_PackedHalf2AtPtx4539R1773,
		r_PackedHalf2AtPtx4543R1774, r_LaneIndexAtPtx4551, r_PtxRegister1776;
	uint32_t r_PtxRegister1777, r_PtxRegister1778, r_PtxRegister1779, r_PtxRegister1780, r_PtxRegister1781,
		r_PtxRegister1782, r_PtxRegister1783, r_PtxRegister1784, r_PtxRegister1785,
		r_PackedHalf2AtPtx4614R1786, r_PackedHalf2AtPtx4618R1787, r_PackedHalf2AtPtx4622R1788;
	uint32_t r_LaneIndexAtPtx4630, r_PtxRegister1790, r_PtxRegister1791, r_PtxRegister1792, r_PtxRegister1793,
		r_PtxRegister1794, r_PtxRegister1795, r_PtxRegister1796, r_PtxRegister1797, r_PtxRegister1798,
		r_PtxRegister1799, r_PackedHalf2AtPtx4693R1800;
	uint32_t r_PackedHalf2AtPtx4697R1801, r_PackedHalf2AtPtx4701R1802, r_LaneIndexAtPtx4709,
		r_PtxRegister1804, r_PtxRegister1805, r_PtxRegister1806, r_PtxRegister1807, r_PtxRegister1808,
		r_PtxRegister1809, r_PtxRegister1810, r_PtxRegister1811, r_PtxRegister1812;
	uint32_t r_PtxRegister1813, r_PackedHalf2AtPtx4772R1814, r_PackedHalf2AtPtx4776R1815,
		r_PackedHalf2AtPtx4780R1816, r_PackedHalf2AtPtx3597R1817, r_PtxRegister1818, r_PtxRegister1819,
		r_PtxRegister1820, r_PtxRegister1821, r_LaneIndexAtPtx4801, r_PackedHalf2AtPtx3599R1823,
		r_PackedHalf2AtPtx3678R1824;
	uint32_t r_PackedHalf2AtPtx3757R1825, r_PackedHalf2AtPtx3836R1826, r_LaneIndexAtPtx4809,
		r_PackedHalf2AtPtx3915R1828, r_PackedHalf2AtPtx3994R1829, r_PackedHalf2AtPtx4073R1830,
		r_PackedHalf2AtPtx4152R1831, r_LaneIndexAtPtx4818, r_PackedHalf2AtPtx4231R1833,
		r_PackedHalf2AtPtx4310R1834, r_PackedHalf2AtPtx4389R1835, r_PackedHalf2AtPtx4468R1836;
	uint32_t r_LaneIndexAtPtx4827, r_PackedHalf2AtPtx4547R1838, r_PackedHalf2AtPtx4626R1839,
		r_PackedHalf2AtPtx4705R1840, r_PackedHalf2AtPtx4784R1841, r_PtxRegister1842, r_PtxRegister1843,
		r_PtxRegister1844, r_PtxRegister1845, r_PtxRegister1846, r_PackedHalf2AtPtx326R1847,
		r_PackedHalf2AtPtx327R1848;
	uint32_t r_PackedHalf2AtPtx328R1849, r_PackedHalf2AtPtx329R1850, r_PackedHalf2AtPtx345R1851,
		r_PackedHalf2AtPtx346R1852, r_PackedHalf2AtPtx347R1853, r_PackedHalf2AtPtx348R1854,
		r_PackedHalf2AtPtx364R1855, r_PackedHalf2AtPtx365R1856, r_PackedHalf2AtPtx366R1857,
		r_PackedHalf2AtPtx367R1858, r_PackedHalf2AtPtx383R1859, r_PackedHalf2AtPtx384R1860;
	uint32_t r_PackedHalf2AtPtx385R1861, r_PackedHalf2AtPtx386R1862, r_PackedHalf2AtPtx408R1863,
		r_PackedHalf2AtPtx409R1864, r_PackedHalf2AtPtx410R1865, r_PackedHalf2AtPtx411R1866,
		r_PackedHalf2AtPtx427R1867, r_PackedHalf2AtPtx428R1868, r_PackedHalf2AtPtx429R1869,
		r_PackedHalf2AtPtx430R1870, r_PackedHalf2AtPtx446R1871, r_PackedHalf2AtPtx447R1872;
	uint32_t r_PackedHalf2AtPtx448R1873, r_PackedHalf2AtPtx449R1874, r_PackedHalf2AtPtx465R1875,
		r_PackedHalf2AtPtx466R1876, r_PackedHalf2AtPtx467R1877, r_PackedHalf2AtPtx468R1878,
		r_PackedHalf2AtPtx501R1879, r_PackedHalf2AtPtx502R1880, r_PackedHalf2AtPtx503R1881,
		r_PackedHalf2AtPtx504R1882, r_PackedHalf2AtPtx520R1883, r_PackedHalf2AtPtx521R1884;
	uint32_t r_PackedHalf2AtPtx522R1885, r_PackedHalf2AtPtx523R1886, r_PackedHalf2AtPtx539R1887,
		r_PackedHalf2AtPtx540R1888, r_PackedHalf2AtPtx541R1889, r_PackedHalf2AtPtx542R1890,
		r_PackedHalf2AtPtx558R1891, r_PackedHalf2AtPtx559R1892, r_PackedHalf2AtPtx560R1893,
		r_PackedHalf2AtPtx561R1894, r_PackedHalf2AtPtx582R1895, r_PackedHalf2AtPtx583R1896;
	uint32_t r_PackedHalf2AtPtx584R1897, r_PackedHalf2AtPtx585R1898, r_PackedHalf2AtPtx601R1899,
		r_PackedHalf2AtPtx602R1900, r_PackedHalf2AtPtx603R1901, r_PackedHalf2AtPtx604R1902,
		r_PackedHalf2AtPtx620R1903, r_PackedHalf2AtPtx621R1904, r_PackedHalf2AtPtx622R1905,
		r_PackedHalf2AtPtx623R1906, r_PackedHalf2AtPtx639R1907, r_PackedHalf2AtPtx640R1908;
	uint32_t r_PackedHalf2AtPtx641R1909, r_PackedHalf2AtPtx642R1910, r_PackedHalf2AtPtx2034R1911,
		r_PackedHalf2AtPtx2027R1912, r_PackedHalf2AtPtx2020R1913, r_PackedHalf2AtPtx2013R1914,
		r_PackedHalf2AtPtx2006R1915, r_PackedHalf2AtPtx1999R1916, r_PackedHalf2AtPtx1992R1917,
		r_PackedHalf2AtPtx1985R1918, r_PackedHalf2AtPtx1978R1919, r_PackedHalf2AtPtx1971R1920;
	uint32_t r_PackedHalf2AtPtx1964R1921, r_PackedHalf2AtPtx1957R1922, r_PackedHalf2AtPtx1950R1923,
		r_PackedHalf2AtPtx1943R1924, r_PackedHalf2AtPtx1936R1925, r_PackedHalf2AtPtx1929R1926,
		r_PackedHalf2AtPtx1922R1927, r_PackedHalf2AtPtx1915R1928, r_PackedHalf2AtPtx1908R1929,
		r_PackedHalf2AtPtx1901R1930, r_PackedHalf2AtPtx1894R1931, r_PackedHalf2AtPtx1887R1932;
	uint32_t r_PackedHalf2AtPtx1880R1933, r_PackedHalf2AtPtx1873R1934, r_PackedHalf2AtPtx1866R1935,
		r_PackedHalf2AtPtx1859R1936, r_PackedHalf2AtPtx1852R1937, r_PackedHalf2AtPtx1845R1938,
		r_PackedHalf2AtPtx1838R1939, r_PackedHalf2AtPtx1831R1940, r_PackedHalf2AtPtx1824R1941,
		r_PackedHalf2AtPtx1817R1942, r_PackedHalf2AtPtx1810R1943, r_PackedHalf2AtPtx1803R1944;
	uint32_t r_PackedHalf2AtPtx1796R1945, r_PackedHalf2AtPtx1789R1946, r_PackedHalf2AtPtx1782R1947,
		r_PackedHalf2AtPtx1775R1948, r_PackedHalf2AtPtx1768R1949, r_PackedHalf2AtPtx1761R1950,
		r_PackedHalf2AtPtx1754R1951, r_PackedHalf2AtPtx1747R1952, r_PackedHalf2AtPtx1740R1953,
		r_PackedHalf2AtPtx1733R1954, r_PackedHalf2AtPtx1726R1955, r_PackedHalf2AtPtx1719R1956;
	uint32_t r_PackedHalf2AtPtx1712R1957, r_PackedHalf2AtPtx1705R1958, r_PackedHalf2AtPtx1698R1959,
		r_PackedHalf2AtPtx1691R1960, r_PackedHalf2AtPtx1684R1961, r_PackedHalf2AtPtx1677R1962,
		r_PackedHalf2AtPtx1670R1963, r_PackedHalf2AtPtx1663R1964, r_PackedHalf2AtPtx1656R1965,
		r_PackedHalf2AtPtx1649R1966, r_PackedHalf2AtPtx1642R1967, r_PackedHalf2AtPtx1635R1968;
	uint32_t r_PackedHalf2AtPtx1628R1969, r_PackedHalf2AtPtx1621R1970, r_PackedHalf2AtPtx1614R1971,
		r_PackedHalf2AtPtx2041R1972, r_PackedHalf2AtPtx2048R1973, r_PackedHalf2AtPtx2055R1974,
		r_PtxRegister1975, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
		r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979, r_MmaBHalf2WordAtPtx92R1980;
	uint32_t r_MmaBHalf2WordAtPtx92R1981, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
		r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985, r_MmaBHalf2WordAtPtx102R1986,
		r_MmaBHalf2WordAtPtx102R1987, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
		r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991, r_MmaBHalf2WordAtPtx121R1992;
	uint32_t r_MmaBHalf2WordAtPtx121R1993, r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
		r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997, r_MmaBHalf2WordAtPtx130R1998,
		r_MmaBHalf2WordAtPtx130R1999, r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
		r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003, r_MmaBHalf2WordAtPtx148R2004;
	uint32_t r_MmaBHalf2WordAtPtx148R2005, r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
		r_PtxRegister2008, r_PtxRegister2009, r_PtxRegister2010, r_PtxRegister2011, r_PtxRegister2012,
		r_PtxRegister2013, r_PtxRegister2014, r_PtxRegister2015, r_PtxRegister2016;
	uint32_t r_PtxRegister2017, r_PtxRegister2018, r_PtxRegister2019, r_PtxRegister2020, r_PtxRegister2021,
		r_PtxRegister2022, r_PtxRegister2023, r_PtxRegister2024, r_PtxRegister2025, r_PtxRegister2026,
		r_PtxRegister2027, r_PtxRegister2028;
	uint32_t r_PtxRegister2029, r_PtxRegister2030, r_PtxRegister2031, r_PtxRegister2032, r_PtxRegister2033,
		r_PtxRegister2034, r_PtxRegister2035, r_PtxRegister2036, r_PtxRegister2037, r_PtxRegister2038,
		r_PtxRegister2039, r_PtxRegister2040;
	uint32_t r_PtxRegister2041, r_PtxRegister2042, r_PtxRegister2043, r_PtxRegister2044, r_PtxRegister2045,
		r_PtxRegister2046, r_PtxRegister2047, r_PtxRegister2048, r_PtxRegister2049, r_PtxRegister2050,
		r_PtxRegister2051, r_PtxRegister2052;
	uint32_t r_PtxRegister2053, r_PtxRegister2054, r_PtxRegister2055, r_PtxRegister2056, r_PtxRegister2057,
		r_PtxRegister2058, r_PtxRegister2059, r_PtxRegister2060, r_PtxRegister2061, r_PtxRegister2062,
		r_PtxRegister2063, r_PtxRegister2064;
	uint32_t r_PtxRegister2065, r_PtxRegister2066, r_PtxRegister2067, r_PtxRegister2068, r_PtxRegister2069,
		r_PtxRegister2070, r_PtxRegister2071;
	uint64_t r_Pointer8Bits, r_PtxU64Register2, r_PtxU64Register3, r_PtxU64Register4, r_Pointer0Bits,
		r_Pointer16Bits, r_Pointer24Bits, r_Pointer32Bits, r_PtxU64Register9, r_PtxU64Register10,
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
	uint64_t r_PtxU64Register325, r_PtxU64Register326, r_PtxU64Register327, r_PtxU64Register328;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_Scalar72Bits = uint32_t(r_Parameters.Scalar72);
	r_Scalar76Bits = uint32_t(r_Parameters.Scalar76);	  // PTX L14
	r_Pointer32Bits = uint64_t(r_Parameters.g_Pointer32); // PTX L15
	r_Pointer24Bits = uint64_t(r_Parameters.g_Pointer24); // PTX L16
	r_Pointer16Bits = uint64_t(r_Parameters.g_Pointer16); // PTX L17
	r_Pointer8Bits = uint64_t(r_Parameters.g_Pointer8);	  // PTX L18
	r_Pointer0Bits = uint64_t(r_Parameters.g_Pointer0);	  // PTX L19
	r_Scalar64Bits = uint32_t(r_Parameters.Scalar64);
	r_Scalar68Bits = uint32_t(r_Parameters.Scalar68);							  // PTX L20
	r_CtaX = uint32_t(blockIdx.x);												  // PTX L21
	r_CtaY = uint32_t(blockIdx.y);												  // PTX L22
	r_CtaZ = uint32_t(blockIdx.z);												  // PTX L23
	r_PtxRegister276 = uint32_t(r_Scalar68Bits) + uint32_t(-1);					  // PTX L24
	r_PtxRegister277 = ShiftRightSigned(int32_t(r_PtxRegister276), uint32_t(31)); // PTX L25
	r_PtxRegister278 = ShiftRight(uint32_t(r_PtxRegister277), uint32_t(29));	  // PTX L26
	r_PtxRegister279 = uint32_t(r_PtxRegister276) + uint32_t(r_PtxRegister278);	  // PTX L27
	r_PtxRegister280 = ShiftRightSigned(int32_t(r_PtxRegister279), uint32_t(3));  // PTX L28
	r_PtxRegister281 = uint32_t(r_PtxRegister280) + uint32_t(1);				  // PTX L29
	r_PtxRegister3 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister281));		  // PTX L30
	r_PtxRegister282 =
		uint32_t(r_PtxRegister3) * uint32_t(r_PtxRegister280) + uint32_t(r_PtxRegister3); // PTX L31
	r_PtxRegister2 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister282);						  // PTX L32
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L33
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(1));					  // PTX L34
	r_PtxRegister283 = ShiftRightSigned(int32_t(r_Scalar64Bits), uint32_t(31));			  // PTX L35
	r_PtxRegister284 = ShiftRight(uint32_t(r_PtxRegister283), uint32_t(30));			  // PTX L36
	r_PtxRegister285 = uint32_t(r_Scalar64Bits) + uint32_t(r_PtxRegister284);			  // PTX L37
	r_PtxRegister6 = ShiftRightSigned(int32_t(r_PtxRegister285), uint32_t(2));			  // PTX L38
	r_PtxRegister286 = ShiftRightSigned(int32_t(r_Scalar68Bits), uint32_t(31));			  // PTX L39
	r_PtxRegister287 = ShiftRight(uint32_t(r_PtxRegister286), uint32_t(30));			  // PTX L40
	r_PtxRegister288 = uint32_t(r_Scalar68Bits) + uint32_t(r_PtxRegister287);			  // PTX L41
	r_PtxRegister7 = ShiftRightSigned(int32_t(r_PtxRegister288), uint32_t(2));			  // PTX L42
	r_ThreadX = uint32_t(threadIdx.x);													  // PTX L43
	r_ThreadY = uint32_t(threadIdx.y);													  // PTX L44
	r_PtxRegister290 = r_ThreadX | r_ThreadY;											  // PTX L45
	r_bPtxPredicate14 = uint32_t(r_PtxRegister290) != uint32_t(0);						  // PTX L46
	if (r_bPtxPredicate14)
	{
		goto L__BB38_2;
	} // PTX L47
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L48
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L49
	r_PtxRegister292 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L50
	r_PtxRegister291 = uint32_t(8192u /* exact native shared-region offset */); // PTX L51
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister291, r_PtxRegister292); // PTX L53
	r_PtxRegister293 = uint32_t(r_PtxRegister291) + uint32_t(8);	  // PTX L55
	BarrierInit(s_SharedStorage, r_PtxRegister293, r_PtxRegister292); // PTX L57
L__BB38_2:															  // PTX L59
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L60
	r_Float32BitsAtPtx61R296 = uint32_t(0);														// PTX L61
	r_PackedHalf2AtPtx63R346 = FloatToHalf2(r_Float32BitsAtPtx61R296);							// PTX L63
	r_PtxRegister305 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L68
	r_PtxRegister306 = ShiftLeft(uint32_t(r_PtxRegister3), uint32_t(8));						// PTX L69
	r_PtxRegister9 = uint32_t(r_PtxRegister305) + uint32_t(r_PtxRegister306);					// PTX L70
	r_PtxRegister307 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(17));								// PTX L71
	r_PtxRegister10 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(3));							// PTX L72
	r_PtxRegister308 = uint32_t(r_PtxRegister307) + uint32_t(r_PtxRegister10);					// PTX L73
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_PtxRegister308)) * int64_t(int32_t(4)));	// PTX L74
	r_PtxU64Register18 = uint64_t(r_Pointer32Bits) + uint64_t(r_PtxU64Register17);				// PTX L75
	r_LaneIndexAtPtx77 = uint32_t((threadIdx.x & 31u));											// PTX L77
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx77)) * int64_t(int32_t(16))); // PTX L79
	r_PtxU64Register9 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register19);			// PTX L80
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBHalf2WordAtPtx82R1976 = r_Value.x;
		r_MmaBHalf2WordAtPtx82R1977 = r_Value.y;
		r_MmaBHalf2WordAtPtx82R1978 = r_Value.z;
		r_MmaBHalf2WordAtPtx82R1979 = r_Value.w;
	} // PTX L82
	r_PtxRegister11 = r_PtxRegister10 | 128;													// PTX L84
	r_LaneIndexAtPtx86 = uint32_t((threadIdx.x & 31u));											// PTX L86
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx86)) * int64_t(int32_t(16))); // PTX L88
	r_PtxU64Register21 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register20);			// PTX L89
	r_PtxU64Register10 = uint64_t(r_PtxU64Register21) + uint64_t(512);							// PTX L90
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBHalf2WordAtPtx92R1980 = r_Value.x;
		r_MmaBHalf2WordAtPtx92R1981 = r_Value.y;
		r_MmaBHalf2WordAtPtx92R1982 = r_Value.z;
		r_MmaBHalf2WordAtPtx92R1983 = r_Value.w;
	} // PTX L92
	r_PtxRegister12 = r_PtxRegister10 | 256;													// PTX L94
	r_LaneIndexAtPtx96 = uint32_t((threadIdx.x & 31u));											// PTX L96
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx96)) * int64_t(int32_t(16))); // PTX L98
	r_PtxU64Register23 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register22);			// PTX L99
	r_PtxU64Register11 = uint64_t(r_PtxU64Register23) + uint64_t(1024);							// PTX L100
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBHalf2WordAtPtx102R1984 = r_Value.x;
		r_MmaBHalf2WordAtPtx102R1985 = r_Value.y;
		r_MmaBHalf2WordAtPtx102R1986 = r_Value.z;
		r_MmaBHalf2WordAtPtx102R1987 = r_Value.w;
	} // PTX L102
	r_PtxRegister13 = r_PtxRegister10 | 384;													 // PTX L104
	r_LaneIndexAtPtx106 = uint32_t((threadIdx.x & 31u));										 // PTX L106
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx106)) * int64_t(int32_t(16))); // PTX L108
	r_PtxU64Register25 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register24);			 // PTX L109
	r_PtxU64Register12 = uint64_t(r_PtxU64Register25) + uint64_t(1536);							 // PTX L110
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBHalf2WordAtPtx112R1988 = r_Value.x;
		r_MmaBHalf2WordAtPtx112R1989 = r_Value.y;
		r_MmaBHalf2WordAtPtx112R1990 = r_Value.z;
		r_MmaBHalf2WordAtPtx112R1991 = r_Value.w;
	} // PTX L112
	r_LaneIndexAtPtx115 = uint32_t((threadIdx.x & 31u));										 // PTX L115
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx115)) * int64_t(int32_t(16))); // PTX L117
	r_PtxU64Register27 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register26);			 // PTX L118
	r_PtxU64Register13 = uint64_t(r_PtxU64Register27) + uint64_t(16384);						 // PTX L119
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register13));
		r_MmaBHalf2WordAtPtx121R1992 = r_Value.x;
		r_MmaBHalf2WordAtPtx121R1993 = r_Value.y;
		r_MmaBHalf2WordAtPtx121R1994 = r_Value.z;
		r_MmaBHalf2WordAtPtx121R1995 = r_Value.w;
	} // PTX L121
	r_LaneIndexAtPtx124 = uint32_t((threadIdx.x & 31u));										 // PTX L124
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx124)) * int64_t(int32_t(16))); // PTX L126
	r_PtxU64Register29 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register28);			 // PTX L127
	r_PtxU64Register14 = uint64_t(r_PtxU64Register29) + uint64_t(16896);						 // PTX L128
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register14));
		r_MmaBHalf2WordAtPtx130R1996 = r_Value.x;
		r_MmaBHalf2WordAtPtx130R1997 = r_Value.y;
		r_MmaBHalf2WordAtPtx130R1998 = r_Value.z;
		r_MmaBHalf2WordAtPtx130R1999 = r_Value.w;
	} // PTX L130
	r_LaneIndexAtPtx133 = uint32_t((threadIdx.x & 31u));										 // PTX L133
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx133)) * int64_t(int32_t(16))); // PTX L135
	r_PtxU64Register31 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register30);			 // PTX L136
	r_PtxU64Register15 = uint64_t(r_PtxU64Register31) + uint64_t(17408);						 // PTX L137
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register15));
		r_MmaBHalf2WordAtPtx139R2000 = r_Value.x;
		r_MmaBHalf2WordAtPtx139R2001 = r_Value.y;
		r_MmaBHalf2WordAtPtx139R2002 = r_Value.z;
		r_MmaBHalf2WordAtPtx139R2003 = r_Value.w;
	} // PTX L139
	r_LaneIndexAtPtx142 = uint32_t((threadIdx.x & 31u));										 // PTX L142
	r_PtxU64Register32 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx142)) * int64_t(int32_t(16))); // PTX L144
	r_PtxU64Register33 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register32);			 // PTX L145
	r_PtxU64Register16 = uint64_t(r_PtxU64Register33) + uint64_t(17920);						 // PTX L146
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register16));
		r_MmaBHalf2WordAtPtx148R2004 = r_Value.x;
		r_MmaBHalf2WordAtPtx148R2005 = r_Value.y;
		r_MmaBHalf2WordAtPtx148R2006 = r_Value.z;
		r_MmaBHalf2WordAtPtx148R2007 = r_Value.w;
	} // PTX L148
	r_PtxRegister309 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));		  // PTX L150
	r_PtxRegister310 = r_PtxRegister309 & 1;								  // PTX L151
	r_PtxRegister311 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));		  // PTX L152
	r_PtxRegister312 = ShiftLeft(uint32_t(r_PtxRegister311), uint32_t(9));	  // PTX L153
	r_PtxRegister313 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L154
	r_PtxRegister14 = r_PtxRegister313 & 256;								  // PTX L155
	r_PtxRegister15 = r_PtxRegister312 | r_PtxRegister14;					  // PTX L156
	r_PtxRegister16 = r_PtxRegister313 & 128;								  // PTX L157
	r_PtxRegister314 = uint32_t(r_PtxRegister311) + uint32_t(r_PtxRegister4); // PTX L158
	r_PtxRegister17 = uint32_t(r_PtxRegister310) + uint32_t(r_PtxRegister5);  // PTX L159
	r_PtxRegister18 = r_Scalar64Bits & -4;									  // PTX L160
	r_bPtxPredicate15 = uint32_t(r_PtxRegister18) != uint32_t(4);			  // PTX L161
	r_bPtxPredicate16 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L162
	r_bPtxPredicate17 = int32_t(r_PtxRegister314) >= int32_t(r_PtxRegister6); // PTX L163
	r_PtxRegister315 = uint32_t(r_PtxRegister314) * uint32_t(r_PtxRegister7); // PTX L164
	r_PtxRegister19 = r_bPtxPredicate16 ? 0 : r_PtxRegister315;				  // PTX L165
	r_bPtxPredicate543 = bool(0);											  // PTX L166
	r_bPtxPredicate18 = r_bPtxPredicate15 & r_bPtxPredicate17;				  // PTX L167
	r_PtxRegister1845 = uint32_t(r_PtxRegister17);							  // PTX L168
	if (r_bPtxPredicate18)
	{
		goto L__BB38_5;
	} // PTX L169
	r_PtxRegister316 = r_Scalar68Bits & -4;						   // PTX L170
	r_bPtxPredicate19 = uint32_t(r_PtxRegister316) == uint32_t(4); // PTX L171
	r_bPtxPredicate543 = bool(-1);								   // PTX L172
	r_PtxRegister1845 = uint32_t(0);							   // PTX L173
	if (r_bPtxPredicate19)
	{
		goto L__BB38_5;
	} // PTX L174
	r_bPtxPredicate543 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L175
	r_PtxRegister1845 = uint32_t(r_PtxRegister17);							 // PTX L176
L__BB38_5:																	 // PTX L177
	r_PtxU64Register325 = uint64_t(0);										 // PTX L178
	r_bPtxPredicate20 = !r_bPtxPredicate543;								 // PTX L179
	if (r_bPtxPredicate20)
	{
		goto L__BB38_7;
	} // PTX L180
	r_PtxRegister317 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1845); // PTX L181
	r_PtxRegister318 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister317);			// PTX L182
	r_PtxRegister319 = ShiftLeft(uint32_t(r_PtxRegister318), uint32_t(12));		// PTX L183
	r_PtxRegister320 = r_PtxRegister319 | r_PtxRegister16;						// PTX L184
	r_PtxU64Register325 = SignExtendWordBits(r_PtxRegister320);					// PTX L185
L__BB38_7:																		// PTX L186
	r_PtxRegister321 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister16);	// PTX L187
	r_PtxRegister322 = ShiftLeft(uint32_t(r_PtxRegister321), uint32_t(2));		// PTX L188
	r_PtxRegister323 = uint32_t(0u /* exact native shared-region offset */);	// PTX L189
	r_PtxRegister20 = uint32_t(r_PtxRegister323) + uint32_t(r_PtxRegister322);	// PTX L190
	if (r_bPtxPredicate20)
	{
		goto L__BB38_10;
	} // PTX L191
	r_PtxRegister328 = uint32_t(-1);							   // PTX L192
	r_PtxRegister327 = Elected(r_PtxRegister328);				   // PTX L194
	r_bPtxPredicate21 = uint32_t(r_PtxRegister327) == uint32_t(0); // PTX L200
	if (r_bPtxPredicate21)
	{
		goto L__BB38_11;
	} // PTX L201
	r_PtxU64Register35 = r_Pointer0Bits;											  // PTX L202
	r_PtxU64Register36 = ShiftLeft(uint64_t(r_PtxU64Register325), uint32_t(2));		  // PTX L203
	r_PtxU64Register34 = uint64_t(r_PtxU64Register35) + uint64_t(r_PtxU64Register36); // PTX L204
	r_PtxRegister330 = uint32_t(8192u /* exact native shared-region offset */);		  // PTX L205
	r_PtxRegister329 = uint32_t(512);												  // PTX L206
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister20, r_PtxU64Register34, r_PtxRegister329,
			 r_PtxRegister330);												   // PTX L208
	BarrierExpect(s_SharedStorage, r_PtxRegister330, r_PtxRegister329);		   // PTX L211
	goto L__BB38_11;														   // PTX L213
L__BB38_10:																	   // PTX L214
	r_LaneIndexAtPtx216 = uint32_t((threadIdx.x & 31u));					   // PTX L216
	r_PtxRegister326 = ShiftLeft(uint32_t(r_LaneIndexAtPtx216), uint32_t(4));  // PTX L218
	r_PtxRegister325 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister326); // PTX L219
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister325)) =
		make_uint4(r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346,
				   r_PackedHalf2AtPtx63R346);								  // PTX L221
L__BB38_11:																	  // PTX L223
	r_bPtxPredicate22 = uint32_t(r_PtxRegister18) != uint32_t(4);			  // PTX L224
	r_bPtxPredicate23 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L225
	r_PtxRegister331 = uint32_t(r_ThreadY) + uint32_t(4);					  // PTX L226
	r_PtxRegister332 = ShiftRight(uint32_t(r_PtxRegister331), uint32_t(2));	  // PTX L227
	r_PtxRegister333 = ShiftLeft(uint32_t(r_PtxRegister332), uint32_t(9));	  // PTX L228
	r_PtxRegister21 = r_PtxRegister333 | r_PtxRegister14;					  // PTX L229
	r_PtxRegister334 = uint32_t(r_PtxRegister332) + uint32_t(r_PtxRegister4); // PTX L230
	r_bPtxPredicate24 = int32_t(r_PtxRegister334) >= int32_t(r_PtxRegister6); // PTX L231
	r_PtxRegister335 = uint32_t(r_PtxRegister334) * uint32_t(r_PtxRegister7); // PTX L232
	r_PtxRegister22 = r_bPtxPredicate23 ? 0 : r_PtxRegister335;				  // PTX L233
	r_bPtxPredicate544 = bool(0);											  // PTX L234
	r_bPtxPredicate25 = r_bPtxPredicate22 & r_bPtxPredicate24;				  // PTX L235
	r_PtxRegister1846 = uint32_t(r_PtxRegister17);							  // PTX L236
	if (r_bPtxPredicate25)
	{
		goto L__BB38_14;
	} // PTX L237
	r_PtxRegister336 = r_Scalar68Bits & -4;						   // PTX L238
	r_bPtxPredicate26 = uint32_t(r_PtxRegister336) == uint32_t(4); // PTX L239
	r_bPtxPredicate544 = bool(-1);								   // PTX L240
	r_PtxRegister1846 = uint32_t(0);							   // PTX L241
	if (r_bPtxPredicate26)
	{
		goto L__BB38_14;
	} // PTX L242
	r_bPtxPredicate544 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L243
	r_PtxRegister1846 = uint32_t(r_PtxRegister17);							 // PTX L244
L__BB38_14:																	 // PTX L245
	r_PtxU64Register326 = uint64_t(0);										 // PTX L246
	r_bPtxPredicate27 = !r_bPtxPredicate544;								 // PTX L247
	if (r_bPtxPredicate27)
	{
		goto L__BB38_16;
	} // PTX L248
	r_PtxRegister337 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister1846); // PTX L249
	r_PtxRegister338 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister337);			// PTX L250
	r_PtxRegister339 = ShiftLeft(uint32_t(r_PtxRegister338), uint32_t(12));		// PTX L251
	r_PtxRegister340 = r_PtxRegister339 | r_PtxRegister16;						// PTX L252
	r_PtxU64Register326 = SignExtendWordBits(r_PtxRegister340);					// PTX L253
L__BB38_16:																		// PTX L254
	r_PtxRegister341 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister16);	// PTX L255
	r_PtxRegister342 = ShiftLeft(uint32_t(r_PtxRegister341), uint32_t(2));		// PTX L256
	r_PtxRegister343 = uint32_t(0u /* exact native shared-region offset */);	// PTX L257
	r_PtxRegister23 = uint32_t(r_PtxRegister343) + uint32_t(r_PtxRegister342);	// PTX L258
	if (r_bPtxPredicate27)
	{
		goto L__BB38_19;
	} // PTX L259
	r_PtxRegister349 = uint32_t(-1);							   // PTX L260
	r_PtxRegister348 = Elected(r_PtxRegister349);				   // PTX L262
	r_bPtxPredicate28 = uint32_t(r_PtxRegister348) == uint32_t(0); // PTX L268
	if (r_bPtxPredicate28)
	{
		goto L__BB38_20;
	} // PTX L269
	r_PtxU64Register38 = r_Pointer0Bits;											  // PTX L270
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register326), uint32_t(2));		  // PTX L271
	r_PtxU64Register37 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register39); // PTX L272
	r_PtxRegister351 = uint32_t(8192u /* exact native shared-region offset */);		  // PTX L273
	r_PtxRegister350 = uint32_t(512);												  // PTX L274
	CopyBulk(s_SharedStorage, r_PtxRegister23, r_PtxU64Register37, r_PtxRegister350,
			 r_PtxRegister351);												   // PTX L276
	BarrierExpect(s_SharedStorage, r_PtxRegister351, r_PtxRegister350);		   // PTX L279
	goto L__BB38_20;														   // PTX L281
L__BB38_19:																	   // PTX L282
	r_LaneIndexAtPtx284 = uint32_t((threadIdx.x & 31u));					   // PTX L284
	r_PtxRegister347 = ShiftLeft(uint32_t(r_LaneIndexAtPtx284), uint32_t(4));  // PTX L286
	r_PtxRegister345 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister347); // PTX L287
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister345)) =
		make_uint4(r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346,
				   r_PackedHalf2AtPtx63R346);									// PTX L289
L__BB38_20:																		// PTX L291
	r_PtxRegister352 = uint32_t(8192u /* exact native shared-region offset */); // PTX L292
	r_PtxRegister353 = uint32_t(1);												// PTX L293
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register40 = BarrierArrive(s_SharedStorage, r_PtxRegister352, r_PtxRegister353); // PTX L295
L__BB38_21:																					 // PTX L297
	r_PtxRegister355 = uint32_t(8192u /* exact native shared-region offset */);				 // PTX L298
	r_PtxRegister354 = BarrierReady(s_SharedStorage, r_PtxRegister355, r_PtxU64Register40);	 // PTX L300
	r_bPtxPredicate29 = uint32_t(r_PtxRegister354) == uint32_t(0);							 // PTX L306
	if (r_bPtxPredicate29)
	{
		goto L__BB38_21;
	} // PTX L307
	r_bPtxPredicate1 = uint32_t(r_PtxRegister18) != uint32_t(4);			// PTX L308
	r_bPtxPredicate30 = uint32_t(r_PtxRegister18) == uint32_t(4);			// PTX L309
	r_PtxRegister24 = r_Scalar68Bits & -4;									// PTX L310
	r_bPtxPredicate31 = uint32_t(r_PtxRegister24) == uint32_t(4);			// PTX L311
	r_bPtxPredicate32 = int32_t(r_PtxRegister4) < int32_t(r_PtxRegister6);	// PTX L312
	r_bPtxPredicate33 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6); // PTX L313
	r_PtxRegister25 = uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7);	// PTX L314
	r_PtxRegister26 = r_bPtxPredicate30 ? 0 : r_PtxRegister25;				// PTX L315
	r_bPtxPredicate34 = r_bPtxPredicate1 & r_bPtxPredicate33;				// PTX L316
	r_bPtxPredicate2 = r_bPtxPredicate30 | r_bPtxPredicate32;				// PTX L317
	r_bPtxPredicate3 = r_bPtxPredicate34 | r_bPtxPredicate31;				// PTX L318
	r_bPtxPredicate35 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	// PTX L319
	r_bPtxPredicate36 = !r_bPtxPredicate34;									// PTX L320
	r_bPtxPredicate4 = r_bPtxPredicate31 & r_bPtxPredicate36;				// PTX L321
	r_PtxRegister27 = r_bPtxPredicate4 ? 0 : r_PtxRegister5;				// PTX L322
	r_bPtxPredicate37 = r_bPtxPredicate3 | r_bPtxPredicate35;				// PTX L323
	r_bPtxPredicate5 = r_bPtxPredicate37 & r_bPtxPredicate2;				// PTX L324
	r_bPtxPredicate38 = !r_bPtxPredicate5;									// PTX L325
	r_PackedHalf2AtPtx326R1847 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L326
	r_PackedHalf2AtPtx327R1848 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L327
	r_PackedHalf2AtPtx328R1849 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L328
	r_PackedHalf2AtPtx329R1850 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L329
	if (r_bPtxPredicate38)
	{
		goto L__BB38_24;
	} // PTX L330
	r_PtxRegister357 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L331
	r_PtxRegister358 = ShiftLeft(uint32_t(r_PtxRegister357), uint32_t(12));						 // PTX L332
	r_PtxRegister359 = uint32_t(r_PtxRegister358) + uint32_t(r_PtxRegister10);					 // PTX L333
	r_PtxU64Register42 = uint64_t(int64_t(int32_t(r_PtxRegister359)) * int64_t(int32_t(4)));	 // PTX L334
	r_PtxU64Register43 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register42);				 // PTX L335
	r_LaneIndexAtPtx337 = uint32_t((threadIdx.x & 31u));										 // PTX L337
	r_PtxU64Register44 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx337)) * int64_t(int32_t(16))); // PTX L339
	r_PtxU64Register41 = uint64_t(r_PtxU64Register43) + uint64_t(r_PtxU64Register44);			 // PTX L340
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register41));
		r_PackedHalf2AtPtx326R1847 = r_Value.x;
		r_PackedHalf2AtPtx327R1848 = r_Value.y;
		r_PackedHalf2AtPtx328R1849 = r_Value.z;
		r_PackedHalf2AtPtx329R1850 = r_Value.w;
	} // PTX L342
L__BB38_24:															 // PTX L344
	r_PackedHalf2AtPtx345R1851 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L345
	r_PackedHalf2AtPtx346R1852 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L346
	r_PackedHalf2AtPtx347R1853 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L347
	r_PackedHalf2AtPtx348R1854 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L348
	if (r_bPtxPredicate38)
	{
		goto L__BB38_26;
	} // PTX L349
	r_PtxRegister361 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L350
	r_PtxRegister362 = ShiftLeft(uint32_t(r_PtxRegister361), uint32_t(12));						 // PTX L351
	r_PtxRegister363 = uint32_t(r_PtxRegister362) + uint32_t(r_PtxRegister11);					 // PTX L352
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister363)) * int64_t(int32_t(4)));	 // PTX L353
	r_PtxU64Register47 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register46);				 // PTX L354
	r_LaneIndexAtPtx356 = uint32_t((threadIdx.x & 31u));										 // PTX L356
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx356)) * int64_t(int32_t(16))); // PTX L358
	r_PtxU64Register45 = uint64_t(r_PtxU64Register47) + uint64_t(r_PtxU64Register48);			 // PTX L359
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register45));
		r_PackedHalf2AtPtx345R1851 = r_Value.x;
		r_PackedHalf2AtPtx346R1852 = r_Value.y;
		r_PackedHalf2AtPtx347R1853 = r_Value.z;
		r_PackedHalf2AtPtx348R1854 = r_Value.w;
	} // PTX L361
L__BB38_26:															 // PTX L363
	r_PackedHalf2AtPtx364R1855 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L364
	r_PackedHalf2AtPtx365R1856 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L365
	r_PackedHalf2AtPtx366R1857 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L366
	r_PackedHalf2AtPtx367R1858 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L367
	if (r_bPtxPredicate38)
	{
		goto L__BB38_28;
	} // PTX L368
	r_PtxRegister365 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L369
	r_PtxRegister366 = ShiftLeft(uint32_t(r_PtxRegister365), uint32_t(12));						 // PTX L370
	r_PtxRegister367 = uint32_t(r_PtxRegister366) + uint32_t(r_PtxRegister12);					 // PTX L371
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister367)) * int64_t(int32_t(4)));	 // PTX L372
	r_PtxU64Register51 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register50);				 // PTX L373
	r_LaneIndexAtPtx375 = uint32_t((threadIdx.x & 31u));										 // PTX L375
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx375)) * int64_t(int32_t(16))); // PTX L377
	r_PtxU64Register49 = uint64_t(r_PtxU64Register51) + uint64_t(r_PtxU64Register52);			 // PTX L378
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register49));
		r_PackedHalf2AtPtx364R1855 = r_Value.x;
		r_PackedHalf2AtPtx365R1856 = r_Value.y;
		r_PackedHalf2AtPtx366R1857 = r_Value.z;
		r_PackedHalf2AtPtx367R1858 = r_Value.w;
	} // PTX L380
L__BB38_28:															 // PTX L382
	r_PackedHalf2AtPtx383R1859 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L383
	r_PackedHalf2AtPtx384R1860 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L384
	r_PackedHalf2AtPtx385R1861 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L385
	r_PackedHalf2AtPtx386R1862 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L386
	if (r_bPtxPredicate38)
	{
		goto L__BB38_30;
	} // PTX L387
	r_PtxRegister369 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L388
	r_PtxRegister370 = ShiftLeft(uint32_t(r_PtxRegister369), uint32_t(12));						 // PTX L389
	r_PtxRegister371 = uint32_t(r_PtxRegister370) + uint32_t(r_PtxRegister13);					 // PTX L390
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister371)) * int64_t(int32_t(4)));	 // PTX L391
	r_PtxU64Register55 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register54);				 // PTX L392
	r_LaneIndexAtPtx394 = uint32_t((threadIdx.x & 31u));										 // PTX L394
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx394)) * int64_t(int32_t(16))); // PTX L396
	r_PtxU64Register53 = uint64_t(r_PtxU64Register55) + uint64_t(r_PtxU64Register56);			 // PTX L397
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register53));
		r_PackedHalf2AtPtx383R1859 = r_Value.x;
		r_PackedHalf2AtPtx384R1860 = r_Value.y;
		r_PackedHalf2AtPtx385R1861 = r_Value.z;
		r_PackedHalf2AtPtx386R1862 = r_Value.w;
	} // PTX L399
L__BB38_30:																	// PTX L401
	r_PtxRegister28 = uint32_t(r_PtxRegister5) + uint32_t(1);				// PTX L402
	r_bPtxPredicate39 = int32_t(r_PtxRegister28) < int32_t(r_PtxRegister7); // PTX L403
	r_PtxRegister29 = r_bPtxPredicate4 ? 0 : r_PtxRegister28;				// PTX L404
	r_bPtxPredicate40 = r_bPtxPredicate3 | r_bPtxPredicate39;				// PTX L405
	r_bPtxPredicate6 = r_bPtxPredicate40 & r_bPtxPredicate2;				// PTX L406
	r_bPtxPredicate41 = !r_bPtxPredicate6;									// PTX L407
	r_PackedHalf2AtPtx408R1863 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L408
	r_PackedHalf2AtPtx409R1864 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L409
	r_PackedHalf2AtPtx410R1865 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L410
	r_PackedHalf2AtPtx411R1866 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L411
	if (r_bPtxPredicate41)
	{
		goto L__BB38_32;
	} // PTX L412
	r_PtxRegister373 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L413
	r_PtxRegister374 = ShiftLeft(uint32_t(r_PtxRegister373), uint32_t(12));						 // PTX L414
	r_PtxRegister375 = uint32_t(r_PtxRegister374) + uint32_t(r_PtxRegister10);					 // PTX L415
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister375)) * int64_t(int32_t(4)));	 // PTX L416
	r_PtxU64Register59 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register58);				 // PTX L417
	r_LaneIndexAtPtx419 = uint32_t((threadIdx.x & 31u));										 // PTX L419
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx419)) * int64_t(int32_t(16))); // PTX L421
	r_PtxU64Register57 = uint64_t(r_PtxU64Register59) + uint64_t(r_PtxU64Register60);			 // PTX L422
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register57));
		r_PackedHalf2AtPtx408R1863 = r_Value.x;
		r_PackedHalf2AtPtx409R1864 = r_Value.y;
		r_PackedHalf2AtPtx410R1865 = r_Value.z;
		r_PackedHalf2AtPtx411R1866 = r_Value.w;
	} // PTX L424
L__BB38_32:															 // PTX L426
	r_PackedHalf2AtPtx427R1867 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L427
	r_PackedHalf2AtPtx428R1868 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L428
	r_PackedHalf2AtPtx429R1869 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L429
	r_PackedHalf2AtPtx430R1870 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L430
	if (r_bPtxPredicate41)
	{
		goto L__BB38_34;
	} // PTX L431
	r_PtxRegister377 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L432
	r_PtxRegister378 = ShiftLeft(uint32_t(r_PtxRegister377), uint32_t(12));						 // PTX L433
	r_PtxRegister379 = uint32_t(r_PtxRegister378) + uint32_t(r_PtxRegister11);					 // PTX L434
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister379)) * int64_t(int32_t(4)));	 // PTX L435
	r_PtxU64Register63 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register62);				 // PTX L436
	r_LaneIndexAtPtx438 = uint32_t((threadIdx.x & 31u));										 // PTX L438
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx438)) * int64_t(int32_t(16))); // PTX L440
	r_PtxU64Register61 = uint64_t(r_PtxU64Register63) + uint64_t(r_PtxU64Register64);			 // PTX L441
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register61));
		r_PackedHalf2AtPtx427R1867 = r_Value.x;
		r_PackedHalf2AtPtx428R1868 = r_Value.y;
		r_PackedHalf2AtPtx429R1869 = r_Value.z;
		r_PackedHalf2AtPtx430R1870 = r_Value.w;
	} // PTX L443
L__BB38_34:															 // PTX L445
	r_PackedHalf2AtPtx446R1871 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L446
	r_PackedHalf2AtPtx447R1872 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L447
	r_PackedHalf2AtPtx448R1873 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L448
	r_PackedHalf2AtPtx449R1874 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L449
	if (r_bPtxPredicate41)
	{
		goto L__BB38_36;
	} // PTX L450
	r_PtxRegister381 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L451
	r_PtxRegister382 = ShiftLeft(uint32_t(r_PtxRegister381), uint32_t(12));						 // PTX L452
	r_PtxRegister383 = uint32_t(r_PtxRegister382) + uint32_t(r_PtxRegister12);					 // PTX L453
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister383)) * int64_t(int32_t(4)));	 // PTX L454
	r_PtxU64Register67 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register66);				 // PTX L455
	r_LaneIndexAtPtx457 = uint32_t((threadIdx.x & 31u));										 // PTX L457
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx457)) * int64_t(int32_t(16))); // PTX L459
	r_PtxU64Register65 = uint64_t(r_PtxU64Register67) + uint64_t(r_PtxU64Register68);			 // PTX L460
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register65));
		r_PackedHalf2AtPtx446R1871 = r_Value.x;
		r_PackedHalf2AtPtx447R1872 = r_Value.y;
		r_PackedHalf2AtPtx448R1873 = r_Value.z;
		r_PackedHalf2AtPtx449R1874 = r_Value.w;
	} // PTX L462
L__BB38_36:															 // PTX L464
	r_PackedHalf2AtPtx465R1875 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L465
	r_PackedHalf2AtPtx466R1876 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L466
	r_PackedHalf2AtPtx467R1877 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L467
	r_PackedHalf2AtPtx468R1878 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L468
	if (r_bPtxPredicate41)
	{
		goto L__BB38_38;
	} // PTX L469
	r_PtxRegister385 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L470
	r_PtxRegister386 = ShiftLeft(uint32_t(r_PtxRegister385), uint32_t(12));						 // PTX L471
	r_PtxRegister387 = uint32_t(r_PtxRegister386) + uint32_t(r_PtxRegister13);					 // PTX L472
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister387)) * int64_t(int32_t(4)));	 // PTX L473
	r_PtxU64Register71 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register70);				 // PTX L474
	r_LaneIndexAtPtx476 = uint32_t((threadIdx.x & 31u));										 // PTX L476
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx476)) * int64_t(int32_t(16))); // PTX L478
	r_PtxU64Register69 = uint64_t(r_PtxU64Register71) + uint64_t(r_PtxU64Register72);			 // PTX L479
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register69));
		r_PackedHalf2AtPtx465R1875 = r_Value.x;
		r_PackedHalf2AtPtx466R1876 = r_Value.y;
		r_PackedHalf2AtPtx467R1877 = r_Value.z;
		r_PackedHalf2AtPtx468R1878 = r_Value.w;
	} // PTX L481
L__BB38_38:																	  // PTX L483
	r_bPtxPredicate42 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	  // PTX L484
	r_bPtxPredicate43 = uint32_t(r_PtxRegister24) == uint32_t(4);			  // PTX L485
	r_bPtxPredicate44 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L486
	r_PtxRegister388 = uint32_t(r_PtxRegister4) + uint32_t(1);				  // PTX L487
	r_bPtxPredicate45 = int32_t(r_PtxRegister388) < int32_t(r_PtxRegister6);  // PTX L488
	r_bPtxPredicate46 = int32_t(r_PtxRegister388) >= int32_t(r_PtxRegister6); // PTX L489
	r_PtxRegister389 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister7);  // PTX L490
	r_PtxRegister30 = r_bPtxPredicate44 ? 0 : r_PtxRegister389;				  // PTX L491
	r_bPtxPredicate47 = r_bPtxPredicate1 & r_bPtxPredicate46;				  // PTX L492
	r_bPtxPredicate7 = r_bPtxPredicate44 | r_bPtxPredicate45;				  // PTX L493
	r_bPtxPredicate8 = r_bPtxPredicate47 | r_bPtxPredicate43;				  // PTX L494
	r_bPtxPredicate48 = !r_bPtxPredicate47;									  // PTX L495
	r_bPtxPredicate9 = r_bPtxPredicate43 & r_bPtxPredicate48;				  // PTX L496
	r_PtxRegister31 = r_bPtxPredicate9 ? 0 : r_PtxRegister5;				  // PTX L497
	r_bPtxPredicate49 = r_bPtxPredicate8 | r_bPtxPredicate42;				  // PTX L498
	r_bPtxPredicate10 = r_bPtxPredicate49 & r_bPtxPredicate7;				  // PTX L499
	r_bPtxPredicate50 = !r_bPtxPredicate10;									  // PTX L500
	r_PackedHalf2AtPtx501R1879 = uint32_t(r_PackedHalf2AtPtx63R346);		  // PTX L501
	r_PackedHalf2AtPtx502R1880 = uint32_t(r_PackedHalf2AtPtx63R346);		  // PTX L502
	r_PackedHalf2AtPtx503R1881 = uint32_t(r_PackedHalf2AtPtx63R346);		  // PTX L503
	r_PackedHalf2AtPtx504R1882 = uint32_t(r_PackedHalf2AtPtx63R346);		  // PTX L504
	if (r_bPtxPredicate50)
	{
		goto L__BB38_40;
	} // PTX L505
	r_PtxRegister391 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L506
	r_PtxRegister392 = ShiftLeft(uint32_t(r_PtxRegister391), uint32_t(12));						 // PTX L507
	r_PtxRegister393 = uint32_t(r_PtxRegister392) + uint32_t(r_PtxRegister10);					 // PTX L508
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister393)) * int64_t(int32_t(4)));	 // PTX L509
	r_PtxU64Register75 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register74);				 // PTX L510
	r_LaneIndexAtPtx512 = uint32_t((threadIdx.x & 31u));										 // PTX L512
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx512)) * int64_t(int32_t(16))); // PTX L514
	r_PtxU64Register73 = uint64_t(r_PtxU64Register75) + uint64_t(r_PtxU64Register76);			 // PTX L515
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register73));
		r_PackedHalf2AtPtx501R1879 = r_Value.x;
		r_PackedHalf2AtPtx502R1880 = r_Value.y;
		r_PackedHalf2AtPtx503R1881 = r_Value.z;
		r_PackedHalf2AtPtx504R1882 = r_Value.w;
	} // PTX L517
L__BB38_40:															 // PTX L519
	r_PackedHalf2AtPtx520R1883 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L520
	r_PackedHalf2AtPtx521R1884 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L521
	r_PackedHalf2AtPtx522R1885 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L522
	r_PackedHalf2AtPtx523R1886 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L523
	if (r_bPtxPredicate50)
	{
		goto L__BB38_42;
	} // PTX L524
	r_PtxRegister395 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L525
	r_PtxRegister396 = ShiftLeft(uint32_t(r_PtxRegister395), uint32_t(12));						 // PTX L526
	r_PtxRegister397 = uint32_t(r_PtxRegister396) + uint32_t(r_PtxRegister11);					 // PTX L527
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister397)) * int64_t(int32_t(4)));	 // PTX L528
	r_PtxU64Register79 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register78);				 // PTX L529
	r_LaneIndexAtPtx531 = uint32_t((threadIdx.x & 31u));										 // PTX L531
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx531)) * int64_t(int32_t(16))); // PTX L533
	r_PtxU64Register77 = uint64_t(r_PtxU64Register79) + uint64_t(r_PtxU64Register80);			 // PTX L534
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register77));
		r_PackedHalf2AtPtx520R1883 = r_Value.x;
		r_PackedHalf2AtPtx521R1884 = r_Value.y;
		r_PackedHalf2AtPtx522R1885 = r_Value.z;
		r_PackedHalf2AtPtx523R1886 = r_Value.w;
	} // PTX L536
L__BB38_42:															 // PTX L538
	r_PackedHalf2AtPtx539R1887 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L539
	r_PackedHalf2AtPtx540R1888 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L540
	r_PackedHalf2AtPtx541R1889 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L541
	r_PackedHalf2AtPtx542R1890 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L542
	if (r_bPtxPredicate50)
	{
		goto L__BB38_44;
	} // PTX L543
	r_PtxRegister399 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L544
	r_PtxRegister400 = ShiftLeft(uint32_t(r_PtxRegister399), uint32_t(12));						 // PTX L545
	r_PtxRegister401 = uint32_t(r_PtxRegister400) + uint32_t(r_PtxRegister12);					 // PTX L546
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister401)) * int64_t(int32_t(4)));	 // PTX L547
	r_PtxU64Register83 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register82);				 // PTX L548
	r_LaneIndexAtPtx550 = uint32_t((threadIdx.x & 31u));										 // PTX L550
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx550)) * int64_t(int32_t(16))); // PTX L552
	r_PtxU64Register81 = uint64_t(r_PtxU64Register83) + uint64_t(r_PtxU64Register84);			 // PTX L553
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register81));
		r_PackedHalf2AtPtx539R1887 = r_Value.x;
		r_PackedHalf2AtPtx540R1888 = r_Value.y;
		r_PackedHalf2AtPtx541R1889 = r_Value.z;
		r_PackedHalf2AtPtx542R1890 = r_Value.w;
	} // PTX L555
L__BB38_44:															 // PTX L557
	r_PackedHalf2AtPtx558R1891 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L558
	r_PackedHalf2AtPtx559R1892 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L559
	r_PackedHalf2AtPtx560R1893 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L560
	r_PackedHalf2AtPtx561R1894 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L561
	if (r_bPtxPredicate50)
	{
		goto L__BB38_46;
	} // PTX L562
	r_PtxRegister403 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L563
	r_PtxRegister404 = ShiftLeft(uint32_t(r_PtxRegister403), uint32_t(12));						 // PTX L564
	r_PtxRegister405 = uint32_t(r_PtxRegister404) + uint32_t(r_PtxRegister13);					 // PTX L565
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister405)) * int64_t(int32_t(4)));	 // PTX L566
	r_PtxU64Register87 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register86);				 // PTX L567
	r_LaneIndexAtPtx569 = uint32_t((threadIdx.x & 31u));										 // PTX L569
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx569)) * int64_t(int32_t(16))); // PTX L571
	r_PtxU64Register85 = uint64_t(r_PtxU64Register87) + uint64_t(r_PtxU64Register88);			 // PTX L572
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register85));
		r_PackedHalf2AtPtx558R1891 = r_Value.x;
		r_PackedHalf2AtPtx559R1892 = r_Value.y;
		r_PackedHalf2AtPtx560R1893 = r_Value.z;
		r_PackedHalf2AtPtx561R1894 = r_Value.w;
	} // PTX L574
L__BB38_46:																	// PTX L576
	r_bPtxPredicate51 = int32_t(r_PtxRegister28) < int32_t(r_PtxRegister7); // PTX L577
	r_PtxRegister32 = r_bPtxPredicate9 ? 0 : r_PtxRegister28;				// PTX L578
	r_bPtxPredicate52 = r_bPtxPredicate8 | r_bPtxPredicate51;				// PTX L579
	r_bPtxPredicate11 = r_bPtxPredicate52 & r_bPtxPredicate7;				// PTX L580
	r_bPtxPredicate53 = !r_bPtxPredicate11;									// PTX L581
	r_PackedHalf2AtPtx582R1895 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L582
	r_PackedHalf2AtPtx583R1896 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L583
	r_PackedHalf2AtPtx584R1897 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L584
	r_PackedHalf2AtPtx585R1898 = uint32_t(r_PackedHalf2AtPtx63R346);		// PTX L585
	if (r_bPtxPredicate53)
	{
		goto L__BB38_48;
	} // PTX L586
	r_PtxRegister407 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					 // PTX L587
	r_PtxRegister408 = ShiftLeft(uint32_t(r_PtxRegister407), uint32_t(12));						 // PTX L588
	r_PtxRegister409 = uint32_t(r_PtxRegister408) + uint32_t(r_PtxRegister10);					 // PTX L589
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister409)) * int64_t(int32_t(4)));	 // PTX L590
	r_PtxU64Register91 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register90);				 // PTX L591
	r_LaneIndexAtPtx593 = uint32_t((threadIdx.x & 31u));										 // PTX L593
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx593)) * int64_t(int32_t(16))); // PTX L595
	r_PtxU64Register89 = uint64_t(r_PtxU64Register91) + uint64_t(r_PtxU64Register92);			 // PTX L596
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register89));
		r_PackedHalf2AtPtx582R1895 = r_Value.x;
		r_PackedHalf2AtPtx583R1896 = r_Value.y;
		r_PackedHalf2AtPtx584R1897 = r_Value.z;
		r_PackedHalf2AtPtx585R1898 = r_Value.w;
	} // PTX L598
L__BB38_48:															 // PTX L600
	r_PackedHalf2AtPtx601R1899 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L601
	r_PackedHalf2AtPtx602R1900 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L602
	r_PackedHalf2AtPtx603R1901 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L603
	r_PackedHalf2AtPtx604R1902 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L604
	if (r_bPtxPredicate53)
	{
		goto L__BB38_50;
	} // PTX L605
	r_PtxRegister411 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					 // PTX L606
	r_PtxRegister412 = ShiftLeft(uint32_t(r_PtxRegister411), uint32_t(12));						 // PTX L607
	r_PtxRegister413 = uint32_t(r_PtxRegister412) + uint32_t(r_PtxRegister11);					 // PTX L608
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister413)) * int64_t(int32_t(4)));	 // PTX L609
	r_PtxU64Register95 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register94);				 // PTX L610
	r_LaneIndexAtPtx612 = uint32_t((threadIdx.x & 31u));										 // PTX L612
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx612)) * int64_t(int32_t(16))); // PTX L614
	r_PtxU64Register93 = uint64_t(r_PtxU64Register95) + uint64_t(r_PtxU64Register96);			 // PTX L615
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register93));
		r_PackedHalf2AtPtx601R1899 = r_Value.x;
		r_PackedHalf2AtPtx602R1900 = r_Value.y;
		r_PackedHalf2AtPtx603R1901 = r_Value.z;
		r_PackedHalf2AtPtx604R1902 = r_Value.w;
	} // PTX L617
L__BB38_50:															 // PTX L619
	r_PackedHalf2AtPtx620R1903 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L620
	r_PackedHalf2AtPtx621R1904 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L621
	r_PackedHalf2AtPtx622R1905 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L622
	r_PackedHalf2AtPtx623R1906 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L623
	if (r_bPtxPredicate53)
	{
		goto L__BB38_52;
	} // PTX L624
	r_PtxRegister415 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					  // PTX L625
	r_PtxRegister416 = ShiftLeft(uint32_t(r_PtxRegister415), uint32_t(12));						  // PTX L626
	r_PtxRegister417 = uint32_t(r_PtxRegister416) + uint32_t(r_PtxRegister12);					  // PTX L627
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister417)) * int64_t(int32_t(4)));	  // PTX L628
	r_PtxU64Register99 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register98);				  // PTX L629
	r_LaneIndexAtPtx631 = uint32_t((threadIdx.x & 31u));										  // PTX L631
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx631)) * int64_t(int32_t(16))); // PTX L633
	r_PtxU64Register97 = uint64_t(r_PtxU64Register99) + uint64_t(r_PtxU64Register100);			  // PTX L634
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register97));
		r_PackedHalf2AtPtx620R1903 = r_Value.x;
		r_PackedHalf2AtPtx621R1904 = r_Value.y;
		r_PackedHalf2AtPtx622R1905 = r_Value.z;
		r_PackedHalf2AtPtx623R1906 = r_Value.w;
	} // PTX L636
L__BB38_52:															 // PTX L638
	r_PackedHalf2AtPtx639R1907 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L639
	r_PackedHalf2AtPtx640R1908 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L640
	r_PackedHalf2AtPtx641R1909 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L641
	r_PackedHalf2AtPtx642R1910 = uint32_t(r_PackedHalf2AtPtx63R346); // PTX L642
	if (r_bPtxPredicate53)
	{
		goto L__BB38_54;
	} // PTX L643
	r_PtxRegister419 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					  // PTX L644
	r_PtxRegister420 = ShiftLeft(uint32_t(r_PtxRegister419), uint32_t(12));						  // PTX L645
	r_PtxRegister421 = uint32_t(r_PtxRegister420) + uint32_t(r_PtxRegister13);					  // PTX L646
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister421)) * int64_t(int32_t(4)));	  // PTX L647
	r_PtxU64Register103 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register102);				  // PTX L648
	r_LaneIndexAtPtx650 = uint32_t((threadIdx.x & 31u));										  // PTX L650
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx650)) * int64_t(int32_t(16))); // PTX L652
	r_PtxU64Register101 = uint64_t(r_PtxU64Register103) + uint64_t(r_PtxU64Register104);		  // PTX L653
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register101));
		r_PackedHalf2AtPtx639R1907 = r_Value.x;
		r_PackedHalf2AtPtx640R1908 = r_Value.y;
		r_PackedHalf2AtPtx641R1909 = r_Value.z;
		r_PackedHalf2AtPtx642R1910 = r_Value.w;
	} // PTX L655
L__BB38_54:																					   // PTX L657
	r_PtxU64Register105 = r_Pointer32Bits;													   // PTX L658
	r_PtxRegister614 = uint32_t(r_PtxRegister9) + uint32_t(16);								   // PTX L659
	r_PtxRegister615 = uint32_t(r_PtxRegister9) + uint32_t(8);								   // PTX L660
	r_LaneIndexAtPtx662 = uint32_t((threadIdx.x & 31u));									   // PTX L662
	r_PtxRegister616 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx662), uint32_t(31));		   // PTX L664
	r_PtxRegister617 = ShiftRight(uint32_t(r_PtxRegister616), uint32_t(30));				   // PTX L665
	r_PtxRegister618 = uint32_t(r_LaneIndexAtPtx662) + uint32_t(r_PtxRegister617);			   // PTX L666
	r_PtxRegister619 = r_PtxRegister618 & 2147483644;										   // PTX L667
	r_PtxRegister620 = uint32_t(r_LaneIndexAtPtx662) - uint32_t(r_PtxRegister619);			   // PTX L668
	r_PtxRegister621 = ShiftLeft(uint32_t(r_PtxRegister620), uint32_t(1));					   // PTX L669
	r_PtxRegister622 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister621);				   // PTX L670
	r_PtxRegister623 = ShiftRightSigned(int32_t(r_PtxRegister622), uint32_t(1));			   // PTX L671
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister623)) * int64_t(int32_t(4)));  // PTX L672
	r_PtxU64Register107 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register106);	   // PTX L673
	r_PtxRegister487 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register107 + 524288ull);	   // PTX L674
	r_LaneIndexAtPtx676 = uint32_t((threadIdx.x & 31u));									   // PTX L676
	r_PtxRegister624 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx676), uint32_t(31));		   // PTX L678
	r_PtxRegister625 = ShiftRight(uint32_t(r_PtxRegister624), uint32_t(30));				   // PTX L679
	r_PtxRegister626 = uint32_t(r_LaneIndexAtPtx676) + uint32_t(r_PtxRegister625);			   // PTX L680
	r_PtxRegister627 = r_PtxRegister626 & 2147483644;										   // PTX L681
	r_PtxRegister628 = uint32_t(r_LaneIndexAtPtx676) - uint32_t(r_PtxRegister627);			   // PTX L682
	r_PtxRegister629 = ShiftLeft(uint32_t(r_PtxRegister628), uint32_t(1));					   // PTX L683
	r_PtxRegister630 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister629);				   // PTX L684
	r_PtxRegister631 = ShiftRightSigned(int32_t(r_PtxRegister630), uint32_t(1));			   // PTX L685
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_PtxRegister631)) * int64_t(int32_t(4)));  // PTX L686
	r_PtxU64Register109 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register108);	   // PTX L687
	r_PtxRegister489 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register109 + 524288ull);	   // PTX L688
	r_LaneIndexAtPtx690 = uint32_t((threadIdx.x & 31u));									   // PTX L690
	r_PtxRegister632 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx690), uint32_t(31));		   // PTX L692
	r_PtxRegister633 = ShiftRight(uint32_t(r_PtxRegister632), uint32_t(30));				   // PTX L693
	r_PtxRegister634 = uint32_t(r_LaneIndexAtPtx690) + uint32_t(r_PtxRegister633);			   // PTX L694
	r_PtxRegister635 = r_PtxRegister634 & 2147483644;										   // PTX L695
	r_PtxRegister636 = uint32_t(r_LaneIndexAtPtx690) - uint32_t(r_PtxRegister635);			   // PTX L696
	r_PtxRegister637 = ShiftLeft(uint32_t(r_PtxRegister636), uint32_t(1));					   // PTX L697
	r_PtxRegister638 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister637);				   // PTX L698
	r_PtxRegister639 = ShiftRightSigned(int32_t(r_PtxRegister638), uint32_t(1));			   // PTX L699
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister639)) * int64_t(int32_t(4)));  // PTX L700
	r_PtxU64Register111 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register110);	   // PTX L701
	r_PtxRegister491 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register111 + 524288ull);	   // PTX L702
	r_LaneIndexAtPtx704 = uint32_t((threadIdx.x & 31u));									   // PTX L704
	r_PtxRegister640 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx704), uint32_t(31));		   // PTX L706
	r_PtxRegister641 = ShiftRight(uint32_t(r_PtxRegister640), uint32_t(30));				   // PTX L707
	r_PtxRegister642 = uint32_t(r_LaneIndexAtPtx704) + uint32_t(r_PtxRegister641);			   // PTX L708
	r_PtxRegister643 = r_PtxRegister642 & 2147483644;										   // PTX L709
	r_PtxRegister644 = uint32_t(r_LaneIndexAtPtx704) - uint32_t(r_PtxRegister643);			   // PTX L710
	r_PtxRegister645 = ShiftLeft(uint32_t(r_PtxRegister644), uint32_t(1));					   // PTX L711
	r_PtxRegister646 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister645);				   // PTX L712
	r_PtxRegister647 = ShiftRightSigned(int32_t(r_PtxRegister646), uint32_t(1));			   // PTX L713
	r_PtxU64Register112 = uint64_t(int64_t(int32_t(r_PtxRegister647)) * int64_t(int32_t(4)));  // PTX L714
	r_PtxU64Register113 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register112);	   // PTX L715
	r_PtxRegister493 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register113 + 524288ull);	   // PTX L716
	r_LaneIndexAtPtx718 = uint32_t((threadIdx.x & 31u));									   // PTX L718
	r_PtxRegister648 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx718), uint32_t(31));		   // PTX L720
	r_PtxRegister649 = ShiftRight(uint32_t(r_PtxRegister648), uint32_t(30));				   // PTX L721
	r_PtxRegister650 = uint32_t(r_LaneIndexAtPtx718) + uint32_t(r_PtxRegister649);			   // PTX L722
	r_PtxRegister651 = r_PtxRegister650 & 2147483644;										   // PTX L723
	r_PtxRegister652 = uint32_t(r_LaneIndexAtPtx718) - uint32_t(r_PtxRegister651);			   // PTX L724
	r_PtxRegister653 = ShiftLeft(uint32_t(r_PtxRegister652), uint32_t(1));					   // PTX L725
	r_PtxRegister654 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister653);				   // PTX L726
	r_PtxRegister655 = ShiftRightSigned(int32_t(r_PtxRegister654), uint32_t(1));			   // PTX L727
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister655)) * int64_t(int32_t(4)));  // PTX L728
	r_PtxU64Register115 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register114);	   // PTX L729
	r_PtxRegister495 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register115 + 524288ull);	   // PTX L730
	r_LaneIndexAtPtx732 = uint32_t((threadIdx.x & 31u));									   // PTX L732
	r_PtxRegister656 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx732), uint32_t(31));		   // PTX L734
	r_PtxRegister657 = ShiftRight(uint32_t(r_PtxRegister656), uint32_t(30));				   // PTX L735
	r_PtxRegister658 = uint32_t(r_LaneIndexAtPtx732) + uint32_t(r_PtxRegister657);			   // PTX L736
	r_PtxRegister659 = r_PtxRegister658 & 2147483644;										   // PTX L737
	r_PtxRegister660 = uint32_t(r_LaneIndexAtPtx732) - uint32_t(r_PtxRegister659);			   // PTX L738
	r_PtxRegister661 = ShiftLeft(uint32_t(r_PtxRegister660), uint32_t(1));					   // PTX L739
	r_PtxRegister662 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister661);				   // PTX L740
	r_PtxRegister663 = ShiftRightSigned(int32_t(r_PtxRegister662), uint32_t(1));			   // PTX L741
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister663)) * int64_t(int32_t(4)));  // PTX L742
	r_PtxU64Register117 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register116);	   // PTX L743
	r_PtxRegister497 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register117 + 524288ull);	   // PTX L744
	r_LaneIndexAtPtx746 = uint32_t((threadIdx.x & 31u));									   // PTX L746
	r_PtxRegister664 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx746), uint32_t(31));		   // PTX L748
	r_PtxRegister665 = ShiftRight(uint32_t(r_PtxRegister664), uint32_t(30));				   // PTX L749
	r_PtxRegister666 = uint32_t(r_LaneIndexAtPtx746) + uint32_t(r_PtxRegister665);			   // PTX L750
	r_PtxRegister667 = r_PtxRegister666 & 2147483644;										   // PTX L751
	r_PtxRegister668 = uint32_t(r_LaneIndexAtPtx746) - uint32_t(r_PtxRegister667);			   // PTX L752
	r_PtxRegister669 = ShiftLeft(uint32_t(r_PtxRegister668), uint32_t(1));					   // PTX L753
	r_PtxRegister670 = uint32_t(r_PtxRegister9) + uint32_t(24);								   // PTX L754
	r_PtxRegister671 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister669);				   // PTX L755
	r_PtxRegister672 = ShiftRight(uint32_t(r_PtxRegister671), uint32_t(31));				   // PTX L756
	r_PtxRegister673 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister672);				   // PTX L757
	r_PtxRegister674 = ShiftRightSigned(int32_t(r_PtxRegister673), uint32_t(1));			   // PTX L758
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister674)) * int64_t(int32_t(4)));  // PTX L759
	r_PtxU64Register119 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register118);	   // PTX L760
	r_PtxRegister499 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register119 + 524288ull);	   // PTX L761
	r_LaneIndexAtPtx763 = uint32_t((threadIdx.x & 31u));									   // PTX L763
	r_PtxRegister675 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx763), uint32_t(31));		   // PTX L765
	r_PtxRegister676 = ShiftRight(uint32_t(r_PtxRegister675), uint32_t(30));				   // PTX L766
	r_PtxRegister677 = uint32_t(r_LaneIndexAtPtx763) + uint32_t(r_PtxRegister676);			   // PTX L767
	r_PtxRegister678 = r_PtxRegister677 & 2147483644;										   // PTX L768
	r_PtxRegister679 = uint32_t(r_LaneIndexAtPtx763) - uint32_t(r_PtxRegister678);			   // PTX L769
	r_PtxRegister680 = ShiftLeft(uint32_t(r_PtxRegister679), uint32_t(1));					   // PTX L770
	r_PtxRegister681 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister680);				   // PTX L771
	r_PtxRegister682 = ShiftRight(uint32_t(r_PtxRegister681), uint32_t(31));				   // PTX L772
	r_PtxRegister683 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister682);				   // PTX L773
	r_PtxRegister684 = ShiftRightSigned(int32_t(r_PtxRegister683), uint32_t(1));			   // PTX L774
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister684)) * int64_t(int32_t(4)));  // PTX L775
	r_PtxU64Register121 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register120);	   // PTX L776
	r_PtxRegister501 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register121 + 524288ull);	   // PTX L777
	r_LaneIndexAtPtx779 = uint32_t((threadIdx.x & 31u));									   // PTX L779
	r_PtxRegister685 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx779), uint32_t(31));		   // PTX L781
	r_PtxRegister686 = ShiftRight(uint32_t(r_PtxRegister685), uint32_t(30));				   // PTX L782
	r_PtxRegister687 = uint32_t(r_LaneIndexAtPtx779) + uint32_t(r_PtxRegister686);			   // PTX L783
	r_PtxRegister688 = r_PtxRegister687 & 2147483644;										   // PTX L784
	r_PtxRegister689 = uint32_t(r_LaneIndexAtPtx779) - uint32_t(r_PtxRegister688);			   // PTX L785
	r_PtxRegister690 = ShiftLeft(uint32_t(r_PtxRegister689), uint32_t(1));					   // PTX L786
	r_PtxRegister691 = uint32_t(r_PtxRegister9) + uint32_t(32);								   // PTX L787
	r_PtxRegister692 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister690);				   // PTX L788
	r_PtxRegister693 = ShiftRightSigned(int32_t(r_PtxRegister692), uint32_t(1));			   // PTX L789
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister693)) * int64_t(int32_t(4)));  // PTX L790
	r_PtxU64Register123 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register122);	   // PTX L791
	r_PtxRegister503 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register123 + 524288ull);	   // PTX L792
	r_LaneIndexAtPtx794 = uint32_t((threadIdx.x & 31u));									   // PTX L794
	r_PtxRegister694 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx794), uint32_t(31));		   // PTX L796
	r_PtxRegister695 = ShiftRight(uint32_t(r_PtxRegister694), uint32_t(30));				   // PTX L797
	r_PtxRegister696 = uint32_t(r_LaneIndexAtPtx794) + uint32_t(r_PtxRegister695);			   // PTX L798
	r_PtxRegister697 = r_PtxRegister696 & 2147483644;										   // PTX L799
	r_PtxRegister698 = uint32_t(r_LaneIndexAtPtx794) - uint32_t(r_PtxRegister697);			   // PTX L800
	r_PtxRegister699 = ShiftLeft(uint32_t(r_PtxRegister698), uint32_t(1));					   // PTX L801
	r_PtxRegister700 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister699);				   // PTX L802
	r_PtxRegister701 = ShiftRightSigned(int32_t(r_PtxRegister700), uint32_t(1));			   // PTX L803
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister701)) * int64_t(int32_t(4)));  // PTX L804
	r_PtxU64Register125 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register124);	   // PTX L805
	r_PtxRegister505 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register125 + 524288ull);	   // PTX L806
	r_LaneIndexAtPtx808 = uint32_t((threadIdx.x & 31u));									   // PTX L808
	r_PtxRegister702 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx808), uint32_t(31));		   // PTX L810
	r_PtxRegister703 = ShiftRight(uint32_t(r_PtxRegister702), uint32_t(30));				   // PTX L811
	r_PtxRegister704 = uint32_t(r_LaneIndexAtPtx808) + uint32_t(r_PtxRegister703);			   // PTX L812
	r_PtxRegister705 = r_PtxRegister704 & 2147483644;										   // PTX L813
	r_PtxRegister706 = uint32_t(r_LaneIndexAtPtx808) - uint32_t(r_PtxRegister705);			   // PTX L814
	r_PtxRegister707 = ShiftLeft(uint32_t(r_PtxRegister706), uint32_t(1));					   // PTX L815
	r_PtxRegister708 = uint32_t(r_PtxRegister9) + uint32_t(40);								   // PTX L816
	r_PtxRegister709 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister707);				   // PTX L817
	r_PtxRegister710 = ShiftRight(uint32_t(r_PtxRegister709), uint32_t(31));				   // PTX L818
	r_PtxRegister711 = uint32_t(r_PtxRegister709) + uint32_t(r_PtxRegister710);				   // PTX L819
	r_PtxRegister712 = ShiftRightSigned(int32_t(r_PtxRegister711), uint32_t(1));			   // PTX L820
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister712)) * int64_t(int32_t(4)));  // PTX L821
	r_PtxU64Register127 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register126);	   // PTX L822
	r_PtxRegister507 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register127 + 524288ull);	   // PTX L823
	r_LaneIndexAtPtx825 = uint32_t((threadIdx.x & 31u));									   // PTX L825
	r_PtxRegister713 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx825), uint32_t(31));		   // PTX L827
	r_PtxRegister714 = ShiftRight(uint32_t(r_PtxRegister713), uint32_t(30));				   // PTX L828
	r_PtxRegister715 = uint32_t(r_LaneIndexAtPtx825) + uint32_t(r_PtxRegister714);			   // PTX L829
	r_PtxRegister716 = r_PtxRegister715 & 2147483644;										   // PTX L830
	r_PtxRegister717 = uint32_t(r_LaneIndexAtPtx825) - uint32_t(r_PtxRegister716);			   // PTX L831
	r_PtxRegister718 = ShiftLeft(uint32_t(r_PtxRegister717), uint32_t(1));					   // PTX L832
	r_PtxRegister719 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister718);				   // PTX L833
	r_PtxRegister720 = ShiftRight(uint32_t(r_PtxRegister719), uint32_t(31));				   // PTX L834
	r_PtxRegister721 = uint32_t(r_PtxRegister719) + uint32_t(r_PtxRegister720);				   // PTX L835
	r_PtxRegister722 = ShiftRightSigned(int32_t(r_PtxRegister721), uint32_t(1));			   // PTX L836
	r_PtxU64Register128 = uint64_t(int64_t(int32_t(r_PtxRegister722)) * int64_t(int32_t(4)));  // PTX L837
	r_PtxU64Register129 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register128);	   // PTX L838
	r_PtxRegister509 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register129 + 524288ull);	   // PTX L839
	r_LaneIndexAtPtx841 = uint32_t((threadIdx.x & 31u));									   // PTX L841
	r_PtxRegister723 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx841), uint32_t(31));		   // PTX L843
	r_PtxRegister724 = ShiftRight(uint32_t(r_PtxRegister723), uint32_t(30));				   // PTX L844
	r_PtxRegister725 = uint32_t(r_LaneIndexAtPtx841) + uint32_t(r_PtxRegister724);			   // PTX L845
	r_PtxRegister726 = r_PtxRegister725 & 2147483644;										   // PTX L846
	r_PtxRegister727 = uint32_t(r_LaneIndexAtPtx841) - uint32_t(r_PtxRegister726);			   // PTX L847
	r_PtxRegister728 = ShiftLeft(uint32_t(r_PtxRegister727), uint32_t(1));					   // PTX L848
	r_PtxRegister729 = uint32_t(r_PtxRegister9) + uint32_t(48);								   // PTX L849
	r_PtxRegister730 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister728);				   // PTX L850
	r_PtxRegister731 = ShiftRightSigned(int32_t(r_PtxRegister730), uint32_t(1));			   // PTX L851
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister731)) * int64_t(int32_t(4)));  // PTX L852
	r_PtxU64Register131 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register130);	   // PTX L853
	r_PtxRegister511 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register131 + 524288ull);	   // PTX L854
	r_LaneIndexAtPtx856 = uint32_t((threadIdx.x & 31u));									   // PTX L856
	r_PtxRegister732 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx856), uint32_t(31));		   // PTX L858
	r_PtxRegister733 = ShiftRight(uint32_t(r_PtxRegister732), uint32_t(30));				   // PTX L859
	r_PtxRegister734 = uint32_t(r_LaneIndexAtPtx856) + uint32_t(r_PtxRegister733);			   // PTX L860
	r_PtxRegister735 = r_PtxRegister734 & 2147483644;										   // PTX L861
	r_PtxRegister736 = uint32_t(r_LaneIndexAtPtx856) - uint32_t(r_PtxRegister735);			   // PTX L862
	r_PtxRegister737 = ShiftLeft(uint32_t(r_PtxRegister736), uint32_t(1));					   // PTX L863
	r_PtxRegister738 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister737);				   // PTX L864
	r_PtxRegister739 = ShiftRightSigned(int32_t(r_PtxRegister738), uint32_t(1));			   // PTX L865
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister739)) * int64_t(int32_t(4)));  // PTX L866
	r_PtxU64Register133 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register132);	   // PTX L867
	r_PtxRegister513 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register133 + 524288ull);	   // PTX L868
	r_LaneIndexAtPtx870 = uint32_t((threadIdx.x & 31u));									   // PTX L870
	r_PtxRegister740 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx870), uint32_t(31));		   // PTX L872
	r_PtxRegister741 = ShiftRight(uint32_t(r_PtxRegister740), uint32_t(30));				   // PTX L873
	r_PtxRegister742 = uint32_t(r_LaneIndexAtPtx870) + uint32_t(r_PtxRegister741);			   // PTX L874
	r_PtxRegister743 = r_PtxRegister742 & 2147483644;										   // PTX L875
	r_PtxRegister744 = uint32_t(r_LaneIndexAtPtx870) - uint32_t(r_PtxRegister743);			   // PTX L876
	r_PtxRegister745 = ShiftLeft(uint32_t(r_PtxRegister744), uint32_t(1));					   // PTX L877
	r_PtxRegister746 = uint32_t(r_PtxRegister9) + uint32_t(56);								   // PTX L878
	r_PtxRegister747 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister745);				   // PTX L879
	r_PtxRegister748 = ShiftRight(uint32_t(r_PtxRegister747), uint32_t(31));				   // PTX L880
	r_PtxRegister749 = uint32_t(r_PtxRegister747) + uint32_t(r_PtxRegister748);				   // PTX L881
	r_PtxRegister750 = ShiftRightSigned(int32_t(r_PtxRegister749), uint32_t(1));			   // PTX L882
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister750)) * int64_t(int32_t(4)));  // PTX L883
	r_PtxU64Register135 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register134);	   // PTX L884
	r_PtxRegister515 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register135 + 524288ull);	   // PTX L885
	r_LaneIndexAtPtx887 = uint32_t((threadIdx.x & 31u));									   // PTX L887
	r_PtxRegister751 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx887), uint32_t(31));		   // PTX L889
	r_PtxRegister752 = ShiftRight(uint32_t(r_PtxRegister751), uint32_t(30));				   // PTX L890
	r_PtxRegister753 = uint32_t(r_LaneIndexAtPtx887) + uint32_t(r_PtxRegister752);			   // PTX L891
	r_PtxRegister754 = r_PtxRegister753 & 2147483644;										   // PTX L892
	r_PtxRegister755 = uint32_t(r_LaneIndexAtPtx887) - uint32_t(r_PtxRegister754);			   // PTX L893
	r_PtxRegister756 = ShiftLeft(uint32_t(r_PtxRegister755), uint32_t(1));					   // PTX L894
	r_PtxRegister757 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister756);				   // PTX L895
	r_PtxRegister758 = ShiftRight(uint32_t(r_PtxRegister757), uint32_t(31));				   // PTX L896
	r_PtxRegister759 = uint32_t(r_PtxRegister757) + uint32_t(r_PtxRegister758);				   // PTX L897
	r_PtxRegister760 = ShiftRightSigned(int32_t(r_PtxRegister759), uint32_t(1));			   // PTX L898
	r_PtxU64Register136 = uint64_t(int64_t(int32_t(r_PtxRegister760)) * int64_t(int32_t(4)));  // PTX L899
	r_PtxU64Register137 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register136);	   // PTX L900
	r_PtxRegister517 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register137 + 524288ull);	   // PTX L901
	r_LaneIndexAtPtx903 = uint32_t((threadIdx.x & 31u));									   // PTX L903
	r_PtxRegister761 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx903), uint32_t(31));		   // PTX L905
	r_PtxRegister762 = ShiftRight(uint32_t(r_PtxRegister761), uint32_t(30));				   // PTX L906
	r_PtxRegister763 = uint32_t(r_LaneIndexAtPtx903) + uint32_t(r_PtxRegister762);			   // PTX L907
	r_PtxRegister764 = r_PtxRegister763 & 2147483644;										   // PTX L908
	r_PtxRegister765 = uint32_t(r_LaneIndexAtPtx903) - uint32_t(r_PtxRegister764);			   // PTX L909
	r_PtxRegister766 = ShiftLeft(uint32_t(r_PtxRegister765), uint32_t(1));					   // PTX L910
	r_PtxRegister767 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister766);				   // PTX L911
	r_PtxRegister768 = ShiftRightSigned(int32_t(r_PtxRegister767), uint32_t(1));			   // PTX L912
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister768)) * int64_t(int32_t(4)));  // PTX L913
	r_PtxU64Register139 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register138);	   // PTX L914
	r_PtxRegister519 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register139 + 524288ull);	   // PTX L915
	r_LaneIndexAtPtx917 = uint32_t((threadIdx.x & 31u));									   // PTX L917
	r_PtxRegister769 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx917), uint32_t(31));		   // PTX L919
	r_PtxRegister770 = ShiftRight(uint32_t(r_PtxRegister769), uint32_t(30));				   // PTX L920
	r_PtxRegister771 = uint32_t(r_LaneIndexAtPtx917) + uint32_t(r_PtxRegister770);			   // PTX L921
	r_PtxRegister772 = r_PtxRegister771 & 2147483644;										   // PTX L922
	r_PtxRegister773 = uint32_t(r_LaneIndexAtPtx917) - uint32_t(r_PtxRegister772);			   // PTX L923
	r_PtxRegister774 = ShiftLeft(uint32_t(r_PtxRegister773), uint32_t(1));					   // PTX L924
	r_PtxRegister775 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister774);				   // PTX L925
	r_PtxRegister776 = ShiftRightSigned(int32_t(r_PtxRegister775), uint32_t(1));			   // PTX L926
	r_PtxU64Register140 = uint64_t(int64_t(int32_t(r_PtxRegister776)) * int64_t(int32_t(4)));  // PTX L927
	r_PtxU64Register141 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register140);	   // PTX L928
	r_PtxRegister521 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register141 + 524288ull);	   // PTX L929
	r_LaneIndexAtPtx931 = uint32_t((threadIdx.x & 31u));									   // PTX L931
	r_PtxRegister777 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx931), uint32_t(31));		   // PTX L933
	r_PtxRegister778 = ShiftRight(uint32_t(r_PtxRegister777), uint32_t(30));				   // PTX L934
	r_PtxRegister779 = uint32_t(r_LaneIndexAtPtx931) + uint32_t(r_PtxRegister778);			   // PTX L935
	r_PtxRegister780 = r_PtxRegister779 & 2147483644;										   // PTX L936
	r_PtxRegister781 = uint32_t(r_LaneIndexAtPtx931) - uint32_t(r_PtxRegister780);			   // PTX L937
	r_PtxRegister782 = ShiftLeft(uint32_t(r_PtxRegister781), uint32_t(1));					   // PTX L938
	r_PtxRegister783 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister782);				   // PTX L939
	r_PtxRegister784 = ShiftRightSigned(int32_t(r_PtxRegister783), uint32_t(1));			   // PTX L940
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister784)) * int64_t(int32_t(4)));  // PTX L941
	r_PtxU64Register143 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register142);	   // PTX L942
	r_PtxRegister523 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register143 + 524288ull);	   // PTX L943
	r_LaneIndexAtPtx945 = uint32_t((threadIdx.x & 31u));									   // PTX L945
	r_PtxRegister785 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx945), uint32_t(31));		   // PTX L947
	r_PtxRegister786 = ShiftRight(uint32_t(r_PtxRegister785), uint32_t(30));				   // PTX L948
	r_PtxRegister787 = uint32_t(r_LaneIndexAtPtx945) + uint32_t(r_PtxRegister786);			   // PTX L949
	r_PtxRegister788 = r_PtxRegister787 & 2147483644;										   // PTX L950
	r_PtxRegister789 = uint32_t(r_LaneIndexAtPtx945) - uint32_t(r_PtxRegister788);			   // PTX L951
	r_PtxRegister790 = ShiftLeft(uint32_t(r_PtxRegister789), uint32_t(1));					   // PTX L952
	r_PtxRegister791 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister790);				   // PTX L953
	r_PtxRegister792 = ShiftRightSigned(int32_t(r_PtxRegister791), uint32_t(1));			   // PTX L954
	r_PtxU64Register144 = uint64_t(int64_t(int32_t(r_PtxRegister792)) * int64_t(int32_t(4)));  // PTX L955
	r_PtxU64Register145 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register144);	   // PTX L956
	r_PtxRegister525 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register145 + 524288ull);	   // PTX L957
	r_LaneIndexAtPtx959 = uint32_t((threadIdx.x & 31u));									   // PTX L959
	r_PtxRegister793 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx959), uint32_t(31));		   // PTX L961
	r_PtxRegister794 = ShiftRight(uint32_t(r_PtxRegister793), uint32_t(30));				   // PTX L962
	r_PtxRegister795 = uint32_t(r_LaneIndexAtPtx959) + uint32_t(r_PtxRegister794);			   // PTX L963
	r_PtxRegister796 = r_PtxRegister795 & 2147483644;										   // PTX L964
	r_PtxRegister797 = uint32_t(r_LaneIndexAtPtx959) - uint32_t(r_PtxRegister796);			   // PTX L965
	r_PtxRegister798 = ShiftLeft(uint32_t(r_PtxRegister797), uint32_t(1));					   // PTX L966
	r_PtxRegister799 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister798);				   // PTX L967
	r_PtxRegister800 = ShiftRightSigned(int32_t(r_PtxRegister799), uint32_t(1));			   // PTX L968
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister800)) * int64_t(int32_t(4)));  // PTX L969
	r_PtxU64Register147 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register146);	   // PTX L970
	r_PtxRegister527 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register147 + 524288ull);	   // PTX L971
	r_LaneIndexAtPtx973 = uint32_t((threadIdx.x & 31u));									   // PTX L973
	r_PtxRegister801 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx973), uint32_t(31));		   // PTX L975
	r_PtxRegister802 = ShiftRight(uint32_t(r_PtxRegister801), uint32_t(30));				   // PTX L976
	r_PtxRegister803 = uint32_t(r_LaneIndexAtPtx973) + uint32_t(r_PtxRegister802);			   // PTX L977
	r_PtxRegister804 = r_PtxRegister803 & 2147483644;										   // PTX L978
	r_PtxRegister805 = uint32_t(r_LaneIndexAtPtx973) - uint32_t(r_PtxRegister804);			   // PTX L979
	r_PtxRegister806 = ShiftLeft(uint32_t(r_PtxRegister805), uint32_t(1));					   // PTX L980
	r_PtxRegister807 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister806);				   // PTX L981
	r_PtxRegister808 = ShiftRightSigned(int32_t(r_PtxRegister807), uint32_t(1));			   // PTX L982
	r_PtxU64Register148 = uint64_t(int64_t(int32_t(r_PtxRegister808)) * int64_t(int32_t(4)));  // PTX L983
	r_PtxU64Register149 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register148);	   // PTX L984
	r_PtxRegister529 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register149 + 524288ull);	   // PTX L985
	r_LaneIndexAtPtx987 = uint32_t((threadIdx.x & 31u));									   // PTX L987
	r_PtxRegister809 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx987), uint32_t(31));		   // PTX L989
	r_PtxRegister810 = ShiftRight(uint32_t(r_PtxRegister809), uint32_t(30));				   // PTX L990
	r_PtxRegister811 = uint32_t(r_LaneIndexAtPtx987) + uint32_t(r_PtxRegister810);			   // PTX L991
	r_PtxRegister812 = r_PtxRegister811 & 2147483644;										   // PTX L992
	r_PtxRegister813 = uint32_t(r_LaneIndexAtPtx987) - uint32_t(r_PtxRegister812);			   // PTX L993
	r_PtxRegister814 = ShiftLeft(uint32_t(r_PtxRegister813), uint32_t(1));					   // PTX L994
	r_PtxRegister815 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister814);				   // PTX L995
	r_PtxRegister816 = ShiftRight(uint32_t(r_PtxRegister815), uint32_t(31));				   // PTX L996
	r_PtxRegister817 = uint32_t(r_PtxRegister815) + uint32_t(r_PtxRegister816);				   // PTX L997
	r_PtxRegister818 = ShiftRightSigned(int32_t(r_PtxRegister817), uint32_t(1));			   // PTX L998
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister818)) * int64_t(int32_t(4)));  // PTX L999
	r_PtxU64Register151 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register150);	   // PTX L1000
	r_PtxRegister531 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register151 + 524288ull);	   // PTX L1001
	r_LaneIndexAtPtx1003 = uint32_t((threadIdx.x & 31u));									   // PTX L1003
	r_PtxRegister819 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1003), uint32_t(31));		   // PTX L1005
	r_PtxRegister820 = ShiftRight(uint32_t(r_PtxRegister819), uint32_t(30));				   // PTX L1006
	r_PtxRegister821 = uint32_t(r_LaneIndexAtPtx1003) + uint32_t(r_PtxRegister820);			   // PTX L1007
	r_PtxRegister822 = r_PtxRegister821 & 2147483644;										   // PTX L1008
	r_PtxRegister823 = uint32_t(r_LaneIndexAtPtx1003) - uint32_t(r_PtxRegister822);			   // PTX L1009
	r_PtxRegister824 = ShiftLeft(uint32_t(r_PtxRegister823), uint32_t(1));					   // PTX L1010
	r_PtxRegister825 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister824);				   // PTX L1011
	r_PtxRegister826 = ShiftRight(uint32_t(r_PtxRegister825), uint32_t(31));				   // PTX L1012
	r_PtxRegister827 = uint32_t(r_PtxRegister825) + uint32_t(r_PtxRegister826);				   // PTX L1013
	r_PtxRegister828 = ShiftRightSigned(int32_t(r_PtxRegister827), uint32_t(1));			   // PTX L1014
	r_PtxU64Register152 = uint64_t(int64_t(int32_t(r_PtxRegister828)) * int64_t(int32_t(4)));  // PTX L1015
	r_PtxU64Register153 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register152);	   // PTX L1016
	r_PtxRegister533 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register153 + 524288ull);	   // PTX L1017
	r_LaneIndexAtPtx1019 = uint32_t((threadIdx.x & 31u));									   // PTX L1019
	r_PtxRegister829 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1019), uint32_t(31));		   // PTX L1021
	r_PtxRegister830 = ShiftRight(uint32_t(r_PtxRegister829), uint32_t(30));				   // PTX L1022
	r_PtxRegister831 = uint32_t(r_LaneIndexAtPtx1019) + uint32_t(r_PtxRegister830);			   // PTX L1023
	r_PtxRegister832 = r_PtxRegister831 & 2147483644;										   // PTX L1024
	r_PtxRegister833 = uint32_t(r_LaneIndexAtPtx1019) - uint32_t(r_PtxRegister832);			   // PTX L1025
	r_PtxRegister834 = ShiftLeft(uint32_t(r_PtxRegister833), uint32_t(1));					   // PTX L1026
	r_PtxRegister835 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister834);				   // PTX L1027
	r_PtxRegister836 = ShiftRightSigned(int32_t(r_PtxRegister835), uint32_t(1));			   // PTX L1028
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister836)) * int64_t(int32_t(4)));  // PTX L1029
	r_PtxU64Register155 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register154);	   // PTX L1030
	r_PtxRegister535 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register155 + 524288ull);	   // PTX L1031
	r_LaneIndexAtPtx1033 = uint32_t((threadIdx.x & 31u));									   // PTX L1033
	r_PtxRegister837 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1033), uint32_t(31));		   // PTX L1035
	r_PtxRegister838 = ShiftRight(uint32_t(r_PtxRegister837), uint32_t(30));				   // PTX L1036
	r_PtxRegister839 = uint32_t(r_LaneIndexAtPtx1033) + uint32_t(r_PtxRegister838);			   // PTX L1037
	r_PtxRegister840 = r_PtxRegister839 & 2147483644;										   // PTX L1038
	r_PtxRegister841 = uint32_t(r_LaneIndexAtPtx1033) - uint32_t(r_PtxRegister840);			   // PTX L1039
	r_PtxRegister842 = ShiftLeft(uint32_t(r_PtxRegister841), uint32_t(1));					   // PTX L1040
	r_PtxRegister843 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister842);				   // PTX L1041
	r_PtxRegister844 = ShiftRightSigned(int32_t(r_PtxRegister843), uint32_t(1));			   // PTX L1042
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister844)) * int64_t(int32_t(4)));  // PTX L1043
	r_PtxU64Register157 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register156);	   // PTX L1044
	r_PtxRegister537 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register157 + 524288ull);	   // PTX L1045
	r_LaneIndexAtPtx1047 = uint32_t((threadIdx.x & 31u));									   // PTX L1047
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1047), uint32_t(31));		   // PTX L1049
	r_PtxRegister846 = ShiftRight(uint32_t(r_PtxRegister845), uint32_t(30));				   // PTX L1050
	r_PtxRegister847 = uint32_t(r_LaneIndexAtPtx1047) + uint32_t(r_PtxRegister846);			   // PTX L1051
	r_PtxRegister848 = r_PtxRegister847 & 2147483644;										   // PTX L1052
	r_PtxRegister849 = uint32_t(r_LaneIndexAtPtx1047) - uint32_t(r_PtxRegister848);			   // PTX L1053
	r_PtxRegister850 = ShiftLeft(uint32_t(r_PtxRegister849), uint32_t(1));					   // PTX L1054
	r_PtxRegister851 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister850);				   // PTX L1055
	r_PtxRegister852 = ShiftRight(uint32_t(r_PtxRegister851), uint32_t(31));				   // PTX L1056
	r_PtxRegister853 = uint32_t(r_PtxRegister851) + uint32_t(r_PtxRegister852);				   // PTX L1057
	r_PtxRegister854 = ShiftRightSigned(int32_t(r_PtxRegister853), uint32_t(1));			   // PTX L1058
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister854)) * int64_t(int32_t(4)));  // PTX L1059
	r_PtxU64Register159 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register158);	   // PTX L1060
	r_PtxRegister539 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register159 + 524288ull);	   // PTX L1061
	r_LaneIndexAtPtx1063 = uint32_t((threadIdx.x & 31u));									   // PTX L1063
	r_PtxRegister855 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1063), uint32_t(31));		   // PTX L1065
	r_PtxRegister856 = ShiftRight(uint32_t(r_PtxRegister855), uint32_t(30));				   // PTX L1066
	r_PtxRegister857 = uint32_t(r_LaneIndexAtPtx1063) + uint32_t(r_PtxRegister856);			   // PTX L1067
	r_PtxRegister858 = r_PtxRegister857 & 2147483644;										   // PTX L1068
	r_PtxRegister859 = uint32_t(r_LaneIndexAtPtx1063) - uint32_t(r_PtxRegister858);			   // PTX L1069
	r_PtxRegister860 = ShiftLeft(uint32_t(r_PtxRegister859), uint32_t(1));					   // PTX L1070
	r_PtxRegister861 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister860);				   // PTX L1071
	r_PtxRegister862 = ShiftRight(uint32_t(r_PtxRegister861), uint32_t(31));				   // PTX L1072
	r_PtxRegister863 = uint32_t(r_PtxRegister861) + uint32_t(r_PtxRegister862);				   // PTX L1073
	r_PtxRegister864 = ShiftRightSigned(int32_t(r_PtxRegister863), uint32_t(1));			   // PTX L1074
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister864)) * int64_t(int32_t(4)));  // PTX L1075
	r_PtxU64Register161 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register160);	   // PTX L1076
	r_PtxRegister541 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register161 + 524288ull);	   // PTX L1077
	r_LaneIndexAtPtx1079 = uint32_t((threadIdx.x & 31u));									   // PTX L1079
	r_PtxRegister865 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1079), uint32_t(31));		   // PTX L1081
	r_PtxRegister866 = ShiftRight(uint32_t(r_PtxRegister865), uint32_t(30));				   // PTX L1082
	r_PtxRegister867 = uint32_t(r_LaneIndexAtPtx1079) + uint32_t(r_PtxRegister866);			   // PTX L1083
	r_PtxRegister868 = r_PtxRegister867 & 2147483644;										   // PTX L1084
	r_PtxRegister869 = uint32_t(r_LaneIndexAtPtx1079) - uint32_t(r_PtxRegister868);			   // PTX L1085
	r_PtxRegister870 = ShiftLeft(uint32_t(r_PtxRegister869), uint32_t(1));					   // PTX L1086
	r_PtxRegister871 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister870);				   // PTX L1087
	r_PtxRegister872 = ShiftRightSigned(int32_t(r_PtxRegister871), uint32_t(1));			   // PTX L1088
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister872)) * int64_t(int32_t(4)));  // PTX L1089
	r_PtxU64Register163 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register162);	   // PTX L1090
	r_PtxRegister543 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register163 + 524288ull);	   // PTX L1091
	r_LaneIndexAtPtx1093 = uint32_t((threadIdx.x & 31u));									   // PTX L1093
	r_PtxRegister873 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1093), uint32_t(31));		   // PTX L1095
	r_PtxRegister874 = ShiftRight(uint32_t(r_PtxRegister873), uint32_t(30));				   // PTX L1096
	r_PtxRegister875 = uint32_t(r_LaneIndexAtPtx1093) + uint32_t(r_PtxRegister874);			   // PTX L1097
	r_PtxRegister876 = r_PtxRegister875 & 2147483644;										   // PTX L1098
	r_PtxRegister877 = uint32_t(r_LaneIndexAtPtx1093) - uint32_t(r_PtxRegister876);			   // PTX L1099
	r_PtxRegister878 = ShiftLeft(uint32_t(r_PtxRegister877), uint32_t(1));					   // PTX L1100
	r_PtxRegister879 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister878);				   // PTX L1101
	r_PtxRegister880 = ShiftRightSigned(int32_t(r_PtxRegister879), uint32_t(1));			   // PTX L1102
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister880)) * int64_t(int32_t(4)));  // PTX L1103
	r_PtxU64Register165 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register164);	   // PTX L1104
	r_PtxRegister545 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register165 + 524288ull);	   // PTX L1105
	r_LaneIndexAtPtx1107 = uint32_t((threadIdx.x & 31u));									   // PTX L1107
	r_PtxRegister881 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1107), uint32_t(31));		   // PTX L1109
	r_PtxRegister882 = ShiftRight(uint32_t(r_PtxRegister881), uint32_t(30));				   // PTX L1110
	r_PtxRegister883 = uint32_t(r_LaneIndexAtPtx1107) + uint32_t(r_PtxRegister882);			   // PTX L1111
	r_PtxRegister884 = r_PtxRegister883 & 2147483644;										   // PTX L1112
	r_PtxRegister885 = uint32_t(r_LaneIndexAtPtx1107) - uint32_t(r_PtxRegister884);			   // PTX L1113
	r_PtxRegister886 = ShiftLeft(uint32_t(r_PtxRegister885), uint32_t(1));					   // PTX L1114
	r_PtxRegister887 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister886);				   // PTX L1115
	r_PtxRegister888 = ShiftRight(uint32_t(r_PtxRegister887), uint32_t(31));				   // PTX L1116
	r_PtxRegister889 = uint32_t(r_PtxRegister887) + uint32_t(r_PtxRegister888);				   // PTX L1117
	r_PtxRegister890 = ShiftRightSigned(int32_t(r_PtxRegister889), uint32_t(1));			   // PTX L1118
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister890)) * int64_t(int32_t(4)));  // PTX L1119
	r_PtxU64Register167 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register166);	   // PTX L1120
	r_PtxRegister547 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register167 + 524288ull);	   // PTX L1121
	r_LaneIndexAtPtx1123 = uint32_t((threadIdx.x & 31u));									   // PTX L1123
	r_PtxRegister891 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1123), uint32_t(31));		   // PTX L1125
	r_PtxRegister892 = ShiftRight(uint32_t(r_PtxRegister891), uint32_t(30));				   // PTX L1126
	r_PtxRegister893 = uint32_t(r_LaneIndexAtPtx1123) + uint32_t(r_PtxRegister892);			   // PTX L1127
	r_PtxRegister894 = r_PtxRegister893 & 2147483644;										   // PTX L1128
	r_PtxRegister895 = uint32_t(r_LaneIndexAtPtx1123) - uint32_t(r_PtxRegister894);			   // PTX L1129
	r_PtxRegister896 = ShiftLeft(uint32_t(r_PtxRegister895), uint32_t(1));					   // PTX L1130
	r_PtxRegister897 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister896);				   // PTX L1131
	r_PtxRegister898 = ShiftRight(uint32_t(r_PtxRegister897), uint32_t(31));				   // PTX L1132
	r_PtxRegister899 = uint32_t(r_PtxRegister897) + uint32_t(r_PtxRegister898);				   // PTX L1133
	r_PtxRegister900 = ShiftRightSigned(int32_t(r_PtxRegister899), uint32_t(1));			   // PTX L1134
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister900)) * int64_t(int32_t(4)));  // PTX L1135
	r_PtxU64Register169 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register168);	   // PTX L1136
	r_PtxRegister549 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register169 + 524288ull);	   // PTX L1137
	r_LaneIndexAtPtx1139 = uint32_t((threadIdx.x & 31u));									   // PTX L1139
	r_PtxRegister901 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1139), uint32_t(31));		   // PTX L1141
	r_PtxRegister902 = ShiftRight(uint32_t(r_PtxRegister901), uint32_t(30));				   // PTX L1142
	r_PtxRegister903 = uint32_t(r_LaneIndexAtPtx1139) + uint32_t(r_PtxRegister902);			   // PTX L1143
	r_PtxRegister904 = r_PtxRegister903 & 2147483644;										   // PTX L1144
	r_PtxRegister905 = uint32_t(r_LaneIndexAtPtx1139) - uint32_t(r_PtxRegister904);			   // PTX L1145
	r_PtxRegister906 = ShiftLeft(uint32_t(r_PtxRegister905), uint32_t(1));					   // PTX L1146
	r_PtxRegister907 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister906);				   // PTX L1147
	r_PtxRegister908 = ShiftRightSigned(int32_t(r_PtxRegister907), uint32_t(1));			   // PTX L1148
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister908)) * int64_t(int32_t(4)));  // PTX L1149
	r_PtxU64Register171 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register170);	   // PTX L1150
	r_PtxRegister551 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register171 + 524288ull);	   // PTX L1151
	r_LaneIndexAtPtx1153 = uint32_t((threadIdx.x & 31u));									   // PTX L1153
	r_PtxRegister909 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1153), uint32_t(31));		   // PTX L1155
	r_PtxRegister910 = ShiftRight(uint32_t(r_PtxRegister909), uint32_t(30));				   // PTX L1156
	r_PtxRegister911 = uint32_t(r_LaneIndexAtPtx1153) + uint32_t(r_PtxRegister910);			   // PTX L1157
	r_PtxRegister912 = r_PtxRegister911 & 2147483644;										   // PTX L1158
	r_PtxRegister913 = uint32_t(r_LaneIndexAtPtx1153) - uint32_t(r_PtxRegister912);			   // PTX L1159
	r_PtxRegister914 = ShiftLeft(uint32_t(r_PtxRegister913), uint32_t(1));					   // PTX L1160
	r_PtxRegister915 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister914);				   // PTX L1161
	r_PtxRegister916 = ShiftRightSigned(int32_t(r_PtxRegister915), uint32_t(1));			   // PTX L1162
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister916)) * int64_t(int32_t(4)));  // PTX L1163
	r_PtxU64Register173 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register172);	   // PTX L1164
	r_PtxRegister553 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register173 + 524288ull);	   // PTX L1165
	r_LaneIndexAtPtx1167 = uint32_t((threadIdx.x & 31u));									   // PTX L1167
	r_PtxRegister917 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1167), uint32_t(31));		   // PTX L1169
	r_PtxRegister918 = ShiftRight(uint32_t(r_PtxRegister917), uint32_t(30));				   // PTX L1170
	r_PtxRegister919 = uint32_t(r_LaneIndexAtPtx1167) + uint32_t(r_PtxRegister918);			   // PTX L1171
	r_PtxRegister920 = r_PtxRegister919 & 2147483644;										   // PTX L1172
	r_PtxRegister921 = uint32_t(r_LaneIndexAtPtx1167) - uint32_t(r_PtxRegister920);			   // PTX L1173
	r_PtxRegister922 = ShiftLeft(uint32_t(r_PtxRegister921), uint32_t(1));					   // PTX L1174
	r_PtxRegister923 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister922);				   // PTX L1175
	r_PtxRegister924 = ShiftRightSigned(int32_t(r_PtxRegister923), uint32_t(1));			   // PTX L1176
	r_PtxU64Register174 = uint64_t(int64_t(int32_t(r_PtxRegister924)) * int64_t(int32_t(4)));  // PTX L1177
	r_PtxU64Register175 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register174);	   // PTX L1178
	r_PtxRegister555 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register175 + 524288ull);	   // PTX L1179
	r_LaneIndexAtPtx1181 = uint32_t((threadIdx.x & 31u));									   // PTX L1181
	r_PtxRegister925 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1181), uint32_t(31));		   // PTX L1183
	r_PtxRegister926 = ShiftRight(uint32_t(r_PtxRegister925), uint32_t(30));				   // PTX L1184
	r_PtxRegister927 = uint32_t(r_LaneIndexAtPtx1181) + uint32_t(r_PtxRegister926);			   // PTX L1185
	r_PtxRegister928 = r_PtxRegister927 & 2147483644;										   // PTX L1186
	r_PtxRegister929 = uint32_t(r_LaneIndexAtPtx1181) - uint32_t(r_PtxRegister928);			   // PTX L1187
	r_PtxRegister930 = ShiftLeft(uint32_t(r_PtxRegister929), uint32_t(1));					   // PTX L1188
	r_PtxRegister931 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister930);				   // PTX L1189
	r_PtxRegister932 = ShiftRightSigned(int32_t(r_PtxRegister931), uint32_t(1));			   // PTX L1190
	r_PtxU64Register176 = uint64_t(int64_t(int32_t(r_PtxRegister932)) * int64_t(int32_t(4)));  // PTX L1191
	r_PtxU64Register177 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register176);	   // PTX L1192
	r_PtxRegister557 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register177 + 524288ull);	   // PTX L1193
	r_LaneIndexAtPtx1195 = uint32_t((threadIdx.x & 31u));									   // PTX L1195
	r_PtxRegister933 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1195), uint32_t(31));		   // PTX L1197
	r_PtxRegister934 = ShiftRight(uint32_t(r_PtxRegister933), uint32_t(30));				   // PTX L1198
	r_PtxRegister935 = uint32_t(r_LaneIndexAtPtx1195) + uint32_t(r_PtxRegister934);			   // PTX L1199
	r_PtxRegister936 = r_PtxRegister935 & 2147483644;										   // PTX L1200
	r_PtxRegister937 = uint32_t(r_LaneIndexAtPtx1195) - uint32_t(r_PtxRegister936);			   // PTX L1201
	r_PtxRegister938 = ShiftLeft(uint32_t(r_PtxRegister937), uint32_t(1));					   // PTX L1202
	r_PtxRegister939 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister938);				   // PTX L1203
	r_PtxRegister940 = ShiftRightSigned(int32_t(r_PtxRegister939), uint32_t(1));			   // PTX L1204
	r_PtxU64Register178 = uint64_t(int64_t(int32_t(r_PtxRegister940)) * int64_t(int32_t(4)));  // PTX L1205
	r_PtxU64Register179 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register178);	   // PTX L1206
	r_PtxRegister559 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register179 + 524288ull);	   // PTX L1207
	r_LaneIndexAtPtx1209 = uint32_t((threadIdx.x & 31u));									   // PTX L1209
	r_PtxRegister941 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1209), uint32_t(31));		   // PTX L1211
	r_PtxRegister942 = ShiftRight(uint32_t(r_PtxRegister941), uint32_t(30));				   // PTX L1212
	r_PtxRegister943 = uint32_t(r_LaneIndexAtPtx1209) + uint32_t(r_PtxRegister942);			   // PTX L1213
	r_PtxRegister944 = r_PtxRegister943 & 2147483644;										   // PTX L1214
	r_PtxRegister945 = uint32_t(r_LaneIndexAtPtx1209) - uint32_t(r_PtxRegister944);			   // PTX L1215
	r_PtxRegister946 = ShiftLeft(uint32_t(r_PtxRegister945), uint32_t(1));					   // PTX L1216
	r_PtxRegister947 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister946);				   // PTX L1217
	r_PtxRegister948 = ShiftRightSigned(int32_t(r_PtxRegister947), uint32_t(1));			   // PTX L1218
	r_PtxU64Register180 = uint64_t(int64_t(int32_t(r_PtxRegister948)) * int64_t(int32_t(4)));  // PTX L1219
	r_PtxU64Register181 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register180);	   // PTX L1220
	r_PtxRegister561 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register181 + 524288ull);	   // PTX L1221
	r_LaneIndexAtPtx1223 = uint32_t((threadIdx.x & 31u));									   // PTX L1223
	r_PtxRegister949 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1223), uint32_t(31));		   // PTX L1225
	r_PtxRegister950 = ShiftRight(uint32_t(r_PtxRegister949), uint32_t(30));				   // PTX L1226
	r_PtxRegister951 = uint32_t(r_LaneIndexAtPtx1223) + uint32_t(r_PtxRegister950);			   // PTX L1227
	r_PtxRegister952 = r_PtxRegister951 & 2147483644;										   // PTX L1228
	r_PtxRegister953 = uint32_t(r_LaneIndexAtPtx1223) - uint32_t(r_PtxRegister952);			   // PTX L1229
	r_PtxRegister954 = ShiftLeft(uint32_t(r_PtxRegister953), uint32_t(1));					   // PTX L1230
	r_PtxRegister955 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister954);				   // PTX L1231
	r_PtxRegister956 = ShiftRight(uint32_t(r_PtxRegister955), uint32_t(31));				   // PTX L1232
	r_PtxRegister957 = uint32_t(r_PtxRegister955) + uint32_t(r_PtxRegister956);				   // PTX L1233
	r_PtxRegister958 = ShiftRightSigned(int32_t(r_PtxRegister957), uint32_t(1));			   // PTX L1234
	r_PtxU64Register182 = uint64_t(int64_t(int32_t(r_PtxRegister958)) * int64_t(int32_t(4)));  // PTX L1235
	r_PtxU64Register183 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register182);	   // PTX L1236
	r_PtxRegister563 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register183 + 524288ull);	   // PTX L1237
	r_LaneIndexAtPtx1239 = uint32_t((threadIdx.x & 31u));									   // PTX L1239
	r_PtxRegister959 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1239), uint32_t(31));		   // PTX L1241
	r_PtxRegister960 = ShiftRight(uint32_t(r_PtxRegister959), uint32_t(30));				   // PTX L1242
	r_PtxRegister961 = uint32_t(r_LaneIndexAtPtx1239) + uint32_t(r_PtxRegister960);			   // PTX L1243
	r_PtxRegister962 = r_PtxRegister961 & 2147483644;										   // PTX L1244
	r_PtxRegister963 = uint32_t(r_LaneIndexAtPtx1239) - uint32_t(r_PtxRegister962);			   // PTX L1245
	r_PtxRegister964 = ShiftLeft(uint32_t(r_PtxRegister963), uint32_t(1));					   // PTX L1246
	r_PtxRegister965 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister964);				   // PTX L1247
	r_PtxRegister966 = ShiftRight(uint32_t(r_PtxRegister965), uint32_t(31));				   // PTX L1248
	r_PtxRegister967 = uint32_t(r_PtxRegister965) + uint32_t(r_PtxRegister966);				   // PTX L1249
	r_PtxRegister968 = ShiftRightSigned(int32_t(r_PtxRegister967), uint32_t(1));			   // PTX L1250
	r_PtxU64Register184 = uint64_t(int64_t(int32_t(r_PtxRegister968)) * int64_t(int32_t(4)));  // PTX L1251
	r_PtxU64Register185 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register184);	   // PTX L1252
	r_PtxRegister565 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register185 + 524288ull);	   // PTX L1253
	r_LaneIndexAtPtx1255 = uint32_t((threadIdx.x & 31u));									   // PTX L1255
	r_PtxRegister969 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1255), uint32_t(31));		   // PTX L1257
	r_PtxRegister970 = ShiftRight(uint32_t(r_PtxRegister969), uint32_t(30));				   // PTX L1258
	r_PtxRegister971 = uint32_t(r_LaneIndexAtPtx1255) + uint32_t(r_PtxRegister970);			   // PTX L1259
	r_PtxRegister972 = r_PtxRegister971 & 2147483644;										   // PTX L1260
	r_PtxRegister973 = uint32_t(r_LaneIndexAtPtx1255) - uint32_t(r_PtxRegister972);			   // PTX L1261
	r_PtxRegister974 = ShiftLeft(uint32_t(r_PtxRegister973), uint32_t(1));					   // PTX L1262
	r_PtxRegister975 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister974);				   // PTX L1263
	r_PtxRegister976 = ShiftRightSigned(int32_t(r_PtxRegister975), uint32_t(1));			   // PTX L1264
	r_PtxU64Register186 = uint64_t(int64_t(int32_t(r_PtxRegister976)) * int64_t(int32_t(4)));  // PTX L1265
	r_PtxU64Register187 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register186);	   // PTX L1266
	r_PtxRegister567 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register187 + 524288ull);	   // PTX L1267
	r_LaneIndexAtPtx1269 = uint32_t((threadIdx.x & 31u));									   // PTX L1269
	r_PtxRegister977 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1269), uint32_t(31));		   // PTX L1271
	r_PtxRegister978 = ShiftRight(uint32_t(r_PtxRegister977), uint32_t(30));				   // PTX L1272
	r_PtxRegister979 = uint32_t(r_LaneIndexAtPtx1269) + uint32_t(r_PtxRegister978);			   // PTX L1273
	r_PtxRegister980 = r_PtxRegister979 & 2147483644;										   // PTX L1274
	r_PtxRegister981 = uint32_t(r_LaneIndexAtPtx1269) - uint32_t(r_PtxRegister980);			   // PTX L1275
	r_PtxRegister982 = ShiftLeft(uint32_t(r_PtxRegister981), uint32_t(1));					   // PTX L1276
	r_PtxRegister983 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister982);				   // PTX L1277
	r_PtxRegister984 = ShiftRightSigned(int32_t(r_PtxRegister983), uint32_t(1));			   // PTX L1278
	r_PtxU64Register188 = uint64_t(int64_t(int32_t(r_PtxRegister984)) * int64_t(int32_t(4)));  // PTX L1279
	r_PtxU64Register189 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register188);	   // PTX L1280
	r_PtxRegister569 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register189 + 524288ull);	   // PTX L1281
	r_LaneIndexAtPtx1283 = uint32_t((threadIdx.x & 31u));									   // PTX L1283
	r_PtxRegister985 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1283), uint32_t(31));		   // PTX L1285
	r_PtxRegister986 = ShiftRight(uint32_t(r_PtxRegister985), uint32_t(30));				   // PTX L1286
	r_PtxRegister987 = uint32_t(r_LaneIndexAtPtx1283) + uint32_t(r_PtxRegister986);			   // PTX L1287
	r_PtxRegister988 = r_PtxRegister987 & 2147483644;										   // PTX L1288
	r_PtxRegister989 = uint32_t(r_LaneIndexAtPtx1283) - uint32_t(r_PtxRegister988);			   // PTX L1289
	r_PtxRegister990 = ShiftLeft(uint32_t(r_PtxRegister989), uint32_t(1));					   // PTX L1290
	r_PtxRegister991 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister990);				   // PTX L1291
	r_PtxRegister992 = ShiftRight(uint32_t(r_PtxRegister991), uint32_t(31));				   // PTX L1292
	r_PtxRegister993 = uint32_t(r_PtxRegister991) + uint32_t(r_PtxRegister992);				   // PTX L1293
	r_PtxRegister994 = ShiftRightSigned(int32_t(r_PtxRegister993), uint32_t(1));			   // PTX L1294
	r_PtxU64Register190 = uint64_t(int64_t(int32_t(r_PtxRegister994)) * int64_t(int32_t(4)));  // PTX L1295
	r_PtxU64Register191 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register190);	   // PTX L1296
	r_PtxRegister571 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register191 + 524288ull);	   // PTX L1297
	r_LaneIndexAtPtx1299 = uint32_t((threadIdx.x & 31u));									   // PTX L1299
	r_PtxRegister995 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1299), uint32_t(31));		   // PTX L1301
	r_PtxRegister996 = ShiftRight(uint32_t(r_PtxRegister995), uint32_t(30));				   // PTX L1302
	r_PtxRegister997 = uint32_t(r_LaneIndexAtPtx1299) + uint32_t(r_PtxRegister996);			   // PTX L1303
	r_PtxRegister998 = r_PtxRegister997 & 2147483644;										   // PTX L1304
	r_PtxRegister999 = uint32_t(r_LaneIndexAtPtx1299) - uint32_t(r_PtxRegister998);			   // PTX L1305
	r_PtxRegister1000 = ShiftLeft(uint32_t(r_PtxRegister999), uint32_t(1));					   // PTX L1306
	r_PtxRegister1001 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister1000);			   // PTX L1307
	r_PtxRegister1002 = ShiftRight(uint32_t(r_PtxRegister1001), uint32_t(31));				   // PTX L1308
	r_PtxRegister1003 = uint32_t(r_PtxRegister1001) + uint32_t(r_PtxRegister1002);			   // PTX L1309
	r_PtxRegister1004 = ShiftRightSigned(int32_t(r_PtxRegister1003), uint32_t(1));			   // PTX L1310
	r_PtxU64Register192 = uint64_t(int64_t(int32_t(r_PtxRegister1004)) * int64_t(int32_t(4))); // PTX L1311
	r_PtxU64Register193 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register192);	   // PTX L1312
	r_PtxRegister573 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register193 + 524288ull);	   // PTX L1313
	r_LaneIndexAtPtx1315 = uint32_t((threadIdx.x & 31u));									   // PTX L1315
	r_PtxRegister1005 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1315), uint32_t(31));		   // PTX L1317
	r_PtxRegister1006 = ShiftRight(uint32_t(r_PtxRegister1005), uint32_t(30));				   // PTX L1318
	r_PtxRegister1007 = uint32_t(r_LaneIndexAtPtx1315) + uint32_t(r_PtxRegister1006);		   // PTX L1319
	r_PtxRegister1008 = r_PtxRegister1007 & 2147483644;										   // PTX L1320
	r_PtxRegister1009 = uint32_t(r_LaneIndexAtPtx1315) - uint32_t(r_PtxRegister1008);		   // PTX L1321
	r_PtxRegister1010 = ShiftLeft(uint32_t(r_PtxRegister1009), uint32_t(1));				   // PTX L1322
	r_PtxRegister1011 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister1010);			   // PTX L1323
	r_PtxRegister1012 = ShiftRightSigned(int32_t(r_PtxRegister1011), uint32_t(1));			   // PTX L1324
	r_PtxU64Register194 = uint64_t(int64_t(int32_t(r_PtxRegister1012)) * int64_t(int32_t(4))); // PTX L1325
	r_PtxU64Register195 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register194);	   // PTX L1326
	r_PtxRegister575 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register195 + 524288ull);	   // PTX L1327
	r_LaneIndexAtPtx1329 = uint32_t((threadIdx.x & 31u));									   // PTX L1329
	r_PtxRegister1013 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1329), uint32_t(31));		   // PTX L1331
	r_PtxRegister1014 = ShiftRight(uint32_t(r_PtxRegister1013), uint32_t(30));				   // PTX L1332
	r_PtxRegister1015 = uint32_t(r_LaneIndexAtPtx1329) + uint32_t(r_PtxRegister1014);		   // PTX L1333
	r_PtxRegister1016 = r_PtxRegister1015 & 2147483644;										   // PTX L1334
	r_PtxRegister1017 = uint32_t(r_LaneIndexAtPtx1329) - uint32_t(r_PtxRegister1016);		   // PTX L1335
	r_PtxRegister1018 = ShiftLeft(uint32_t(r_PtxRegister1017), uint32_t(1));				   // PTX L1336
	r_PtxRegister1019 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister1018);			   // PTX L1337
	r_PtxRegister1020 = ShiftRightSigned(int32_t(r_PtxRegister1019), uint32_t(1));			   // PTX L1338
	r_PtxU64Register196 = uint64_t(int64_t(int32_t(r_PtxRegister1020)) * int64_t(int32_t(4))); // PTX L1339
	r_PtxU64Register197 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register196);	   // PTX L1340
	r_PtxRegister577 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register197 + 524288ull);	   // PTX L1341
	r_LaneIndexAtPtx1343 = uint32_t((threadIdx.x & 31u));									   // PTX L1343
	r_PtxRegister1021 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1343), uint32_t(31));		   // PTX L1345
	r_PtxRegister1022 = ShiftRight(uint32_t(r_PtxRegister1021), uint32_t(30));				   // PTX L1346
	r_PtxRegister1023 = uint32_t(r_LaneIndexAtPtx1343) + uint32_t(r_PtxRegister1022);		   // PTX L1347
	r_PtxRegister1024 = r_PtxRegister1023 & 2147483644;										   // PTX L1348
	r_PtxRegister1025 = uint32_t(r_LaneIndexAtPtx1343) - uint32_t(r_PtxRegister1024);		   // PTX L1349
	r_PtxRegister1026 = ShiftLeft(uint32_t(r_PtxRegister1025), uint32_t(1));				   // PTX L1350
	r_PtxRegister1027 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister1026);			   // PTX L1351
	r_PtxRegister1028 = ShiftRight(uint32_t(r_PtxRegister1027), uint32_t(31));				   // PTX L1352
	r_PtxRegister1029 = uint32_t(r_PtxRegister1027) + uint32_t(r_PtxRegister1028);			   // PTX L1353
	r_PtxRegister1030 = ShiftRightSigned(int32_t(r_PtxRegister1029), uint32_t(1));			   // PTX L1354
	r_PtxU64Register198 = uint64_t(int64_t(int32_t(r_PtxRegister1030)) * int64_t(int32_t(4))); // PTX L1355
	r_PtxU64Register199 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register198);	   // PTX L1356
	r_PtxRegister579 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register199 + 524288ull);	   // PTX L1357
	r_LaneIndexAtPtx1359 = uint32_t((threadIdx.x & 31u));									   // PTX L1359
	r_PtxRegister1031 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1359), uint32_t(31));		   // PTX L1361
	r_PtxRegister1032 = ShiftRight(uint32_t(r_PtxRegister1031), uint32_t(30));				   // PTX L1362
	r_PtxRegister1033 = uint32_t(r_LaneIndexAtPtx1359) + uint32_t(r_PtxRegister1032);		   // PTX L1363
	r_PtxRegister1034 = r_PtxRegister1033 & 2147483644;										   // PTX L1364
	r_PtxRegister1035 = uint32_t(r_LaneIndexAtPtx1359) - uint32_t(r_PtxRegister1034);		   // PTX L1365
	r_PtxRegister1036 = ShiftLeft(uint32_t(r_PtxRegister1035), uint32_t(1));				   // PTX L1366
	r_PtxRegister1037 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister1036);			   // PTX L1367
	r_PtxRegister1038 = ShiftRight(uint32_t(r_PtxRegister1037), uint32_t(31));				   // PTX L1368
	r_PtxRegister1039 = uint32_t(r_PtxRegister1037) + uint32_t(r_PtxRegister1038);			   // PTX L1369
	r_PtxRegister1040 = ShiftRightSigned(int32_t(r_PtxRegister1039), uint32_t(1));			   // PTX L1370
	r_PtxU64Register200 = uint64_t(int64_t(int32_t(r_PtxRegister1040)) * int64_t(int32_t(4))); // PTX L1371
	r_PtxU64Register201 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register200);	   // PTX L1372
	r_PtxRegister581 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register201 + 524288ull);	   // PTX L1373
	r_LaneIndexAtPtx1375 = uint32_t((threadIdx.x & 31u));									   // PTX L1375
	r_PtxRegister1041 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1375), uint32_t(31));		   // PTX L1377
	r_PtxRegister1042 = ShiftRight(uint32_t(r_PtxRegister1041), uint32_t(30));				   // PTX L1378
	r_PtxRegister1043 = uint32_t(r_LaneIndexAtPtx1375) + uint32_t(r_PtxRegister1042);		   // PTX L1379
	r_PtxRegister1044 = r_PtxRegister1043 & 2147483644;										   // PTX L1380
	r_PtxRegister1045 = uint32_t(r_LaneIndexAtPtx1375) - uint32_t(r_PtxRegister1044);		   // PTX L1381
	r_PtxRegister1046 = ShiftLeft(uint32_t(r_PtxRegister1045), uint32_t(1));				   // PTX L1382
	r_PtxRegister1047 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1046);				   // PTX L1383
	r_PtxRegister1048 = ShiftRightSigned(int32_t(r_PtxRegister1047), uint32_t(1));			   // PTX L1384
	r_PtxU64Register202 = uint64_t(int64_t(int32_t(r_PtxRegister1048)) * int64_t(int32_t(4))); // PTX L1385
	r_PtxU64Register203 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register202);	   // PTX L1386
	r_PtxRegister583 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register203 + 524288ull);	   // PTX L1387
	r_LaneIndexAtPtx1389 = uint32_t((threadIdx.x & 31u));									   // PTX L1389
	r_PtxRegister1049 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1389), uint32_t(31));		   // PTX L1391
	r_PtxRegister1050 = ShiftRight(uint32_t(r_PtxRegister1049), uint32_t(30));				   // PTX L1392
	r_PtxRegister1051 = uint32_t(r_LaneIndexAtPtx1389) + uint32_t(r_PtxRegister1050);		   // PTX L1393
	r_PtxRegister1052 = r_PtxRegister1051 & 2147483644;										   // PTX L1394
	r_PtxRegister1053 = uint32_t(r_LaneIndexAtPtx1389) - uint32_t(r_PtxRegister1052);		   // PTX L1395
	r_PtxRegister1054 = ShiftLeft(uint32_t(r_PtxRegister1053), uint32_t(1));				   // PTX L1396
	r_PtxRegister1055 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1054);				   // PTX L1397
	r_PtxRegister1056 = ShiftRightSigned(int32_t(r_PtxRegister1055), uint32_t(1));			   // PTX L1398
	r_PtxU64Register204 = uint64_t(int64_t(int32_t(r_PtxRegister1056)) * int64_t(int32_t(4))); // PTX L1399
	r_PtxU64Register205 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register204);	   // PTX L1400
	r_PtxRegister585 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register205 + 524288ull);	   // PTX L1401
	r_LaneIndexAtPtx1403 = uint32_t((threadIdx.x & 31u));									   // PTX L1403
	r_PtxRegister1057 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1403), uint32_t(31));		   // PTX L1405
	r_PtxRegister1058 = ShiftRight(uint32_t(r_PtxRegister1057), uint32_t(30));				   // PTX L1406
	r_PtxRegister1059 = uint32_t(r_LaneIndexAtPtx1403) + uint32_t(r_PtxRegister1058);		   // PTX L1407
	r_PtxRegister1060 = r_PtxRegister1059 & 2147483644;										   // PTX L1408
	r_PtxRegister1061 = uint32_t(r_LaneIndexAtPtx1403) - uint32_t(r_PtxRegister1060);		   // PTX L1409
	r_PtxRegister1062 = ShiftLeft(uint32_t(r_PtxRegister1061), uint32_t(1));				   // PTX L1410
	r_PtxRegister1063 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister1062);			   // PTX L1411
	r_PtxRegister1064 = ShiftRightSigned(int32_t(r_PtxRegister1063), uint32_t(1));			   // PTX L1412
	r_PtxU64Register206 = uint64_t(int64_t(int32_t(r_PtxRegister1064)) * int64_t(int32_t(4))); // PTX L1413
	r_PtxU64Register207 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register206);	   // PTX L1414
	r_PtxRegister587 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register207 + 524288ull);	   // PTX L1415
	r_LaneIndexAtPtx1417 = uint32_t((threadIdx.x & 31u));									   // PTX L1417
	r_PtxRegister1065 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1417), uint32_t(31));		   // PTX L1419
	r_PtxRegister1066 = ShiftRight(uint32_t(r_PtxRegister1065), uint32_t(30));				   // PTX L1420
	r_PtxRegister1067 = uint32_t(r_LaneIndexAtPtx1417) + uint32_t(r_PtxRegister1066);		   // PTX L1421
	r_PtxRegister1068 = r_PtxRegister1067 & 2147483644;										   // PTX L1422
	r_PtxRegister1069 = uint32_t(r_LaneIndexAtPtx1417) - uint32_t(r_PtxRegister1068);		   // PTX L1423
	r_PtxRegister1070 = ShiftLeft(uint32_t(r_PtxRegister1069), uint32_t(1));				   // PTX L1424
	r_PtxRegister1071 = uint32_t(r_PtxRegister615) + uint32_t(r_PtxRegister1070);			   // PTX L1425
	r_PtxRegister1072 = ShiftRightSigned(int32_t(r_PtxRegister1071), uint32_t(1));			   // PTX L1426
	r_PtxU64Register208 = uint64_t(int64_t(int32_t(r_PtxRegister1072)) * int64_t(int32_t(4))); // PTX L1427
	r_PtxU64Register209 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register208);	   // PTX L1428
	r_PtxRegister589 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register209 + 524288ull);	   // PTX L1429
	r_LaneIndexAtPtx1431 = uint32_t((threadIdx.x & 31u));									   // PTX L1431
	r_PtxRegister1073 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1431), uint32_t(31));		   // PTX L1433
	r_PtxRegister1074 = ShiftRight(uint32_t(r_PtxRegister1073), uint32_t(30));				   // PTX L1434
	r_PtxRegister1075 = uint32_t(r_LaneIndexAtPtx1431) + uint32_t(r_PtxRegister1074);		   // PTX L1435
	r_PtxRegister1076 = r_PtxRegister1075 & 2147483644;										   // PTX L1436
	r_PtxRegister1077 = uint32_t(r_LaneIndexAtPtx1431) - uint32_t(r_PtxRegister1076);		   // PTX L1437
	r_PtxRegister1078 = ShiftLeft(uint32_t(r_PtxRegister1077), uint32_t(1));				   // PTX L1438
	r_PtxRegister1079 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister1078);			   // PTX L1439
	r_PtxRegister1080 = ShiftRightSigned(int32_t(r_PtxRegister1079), uint32_t(1));			   // PTX L1440
	r_PtxU64Register210 = uint64_t(int64_t(int32_t(r_PtxRegister1080)) * int64_t(int32_t(4))); // PTX L1441
	r_PtxU64Register211 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register210);	   // PTX L1442
	r_PtxRegister591 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register211 + 524288ull);	   // PTX L1443
	r_LaneIndexAtPtx1445 = uint32_t((threadIdx.x & 31u));									   // PTX L1445
	r_PtxRegister1081 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1445), uint32_t(31));		   // PTX L1447
	r_PtxRegister1082 = ShiftRight(uint32_t(r_PtxRegister1081), uint32_t(30));				   // PTX L1448
	r_PtxRegister1083 = uint32_t(r_LaneIndexAtPtx1445) + uint32_t(r_PtxRegister1082);		   // PTX L1449
	r_PtxRegister1084 = r_PtxRegister1083 & 2147483644;										   // PTX L1450
	r_PtxRegister1085 = uint32_t(r_LaneIndexAtPtx1445) - uint32_t(r_PtxRegister1084);		   // PTX L1451
	r_PtxRegister1086 = ShiftLeft(uint32_t(r_PtxRegister1085), uint32_t(1));				   // PTX L1452
	r_PtxRegister1087 = uint32_t(r_PtxRegister614) + uint32_t(r_PtxRegister1086);			   // PTX L1453
	r_PtxRegister1088 = ShiftRightSigned(int32_t(r_PtxRegister1087), uint32_t(1));			   // PTX L1454
	r_PtxU64Register212 = uint64_t(int64_t(int32_t(r_PtxRegister1088)) * int64_t(int32_t(4))); // PTX L1455
	r_PtxU64Register213 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register212);	   // PTX L1456
	r_PtxRegister593 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register213 + 524288ull);	   // PTX L1457
	r_LaneIndexAtPtx1459 = uint32_t((threadIdx.x & 31u));									   // PTX L1459
	r_PtxRegister1089 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1459), uint32_t(31));		   // PTX L1461
	r_PtxRegister1090 = ShiftRight(uint32_t(r_PtxRegister1089), uint32_t(30));				   // PTX L1462
	r_PtxRegister1091 = uint32_t(r_LaneIndexAtPtx1459) + uint32_t(r_PtxRegister1090);		   // PTX L1463
	r_PtxRegister1092 = r_PtxRegister1091 & 2147483644;										   // PTX L1464
	r_PtxRegister1093 = uint32_t(r_LaneIndexAtPtx1459) - uint32_t(r_PtxRegister1092);		   // PTX L1465
	r_PtxRegister1094 = ShiftLeft(uint32_t(r_PtxRegister1093), uint32_t(1));				   // PTX L1466
	r_PtxRegister1095 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister1094);			   // PTX L1467
	r_PtxRegister1096 = ShiftRight(uint32_t(r_PtxRegister1095), uint32_t(31));				   // PTX L1468
	r_PtxRegister1097 = uint32_t(r_PtxRegister1095) + uint32_t(r_PtxRegister1096);			   // PTX L1469
	r_PtxRegister1098 = ShiftRightSigned(int32_t(r_PtxRegister1097), uint32_t(1));			   // PTX L1470
	r_PtxU64Register214 = uint64_t(int64_t(int32_t(r_PtxRegister1098)) * int64_t(int32_t(4))); // PTX L1471
	r_PtxU64Register215 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register214);	   // PTX L1472
	r_PtxRegister595 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register215 + 524288ull);	   // PTX L1473
	r_LaneIndexAtPtx1475 = uint32_t((threadIdx.x & 31u));									   // PTX L1475
	r_PtxRegister1099 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1475), uint32_t(31));		   // PTX L1477
	r_PtxRegister1100 = ShiftRight(uint32_t(r_PtxRegister1099), uint32_t(30));				   // PTX L1478
	r_PtxRegister1101 = uint32_t(r_LaneIndexAtPtx1475) + uint32_t(r_PtxRegister1100);		   // PTX L1479
	r_PtxRegister1102 = r_PtxRegister1101 & 2147483644;										   // PTX L1480
	r_PtxRegister1103 = uint32_t(r_LaneIndexAtPtx1475) - uint32_t(r_PtxRegister1102);		   // PTX L1481
	r_PtxRegister1104 = ShiftLeft(uint32_t(r_PtxRegister1103), uint32_t(1));				   // PTX L1482
	r_PtxRegister1105 = uint32_t(r_PtxRegister670) + uint32_t(r_PtxRegister1104);			   // PTX L1483
	r_PtxRegister1106 = ShiftRight(uint32_t(r_PtxRegister1105), uint32_t(31));				   // PTX L1484
	r_PtxRegister1107 = uint32_t(r_PtxRegister1105) + uint32_t(r_PtxRegister1106);			   // PTX L1485
	r_PtxRegister1108 = ShiftRightSigned(int32_t(r_PtxRegister1107), uint32_t(1));			   // PTX L1486
	r_PtxU64Register216 = uint64_t(int64_t(int32_t(r_PtxRegister1108)) * int64_t(int32_t(4))); // PTX L1487
	r_PtxU64Register217 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register216);	   // PTX L1488
	r_PtxRegister597 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register217 + 524288ull);	   // PTX L1489
	r_LaneIndexAtPtx1491 = uint32_t((threadIdx.x & 31u));									   // PTX L1491
	r_PtxRegister1109 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1491), uint32_t(31));		   // PTX L1493
	r_PtxRegister1110 = ShiftRight(uint32_t(r_PtxRegister1109), uint32_t(30));				   // PTX L1494
	r_PtxRegister1111 = uint32_t(r_LaneIndexAtPtx1491) + uint32_t(r_PtxRegister1110);		   // PTX L1495
	r_PtxRegister1112 = r_PtxRegister1111 & 2147483644;										   // PTX L1496
	r_PtxRegister1113 = uint32_t(r_LaneIndexAtPtx1491) - uint32_t(r_PtxRegister1112);		   // PTX L1497
	r_PtxRegister1114 = ShiftLeft(uint32_t(r_PtxRegister1113), uint32_t(1));				   // PTX L1498
	r_PtxRegister1115 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister1114);			   // PTX L1499
	r_PtxRegister1116 = ShiftRightSigned(int32_t(r_PtxRegister1115), uint32_t(1));			   // PTX L1500
	r_PtxU64Register218 = uint64_t(int64_t(int32_t(r_PtxRegister1116)) * int64_t(int32_t(4))); // PTX L1501
	r_PtxU64Register219 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register218);	   // PTX L1502
	r_PtxRegister599 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register219 + 524288ull);	   // PTX L1503
	r_LaneIndexAtPtx1505 = uint32_t((threadIdx.x & 31u));									   // PTX L1505
	r_PtxRegister1117 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1505), uint32_t(31));		   // PTX L1507
	r_PtxRegister1118 = ShiftRight(uint32_t(r_PtxRegister1117), uint32_t(30));				   // PTX L1508
	r_PtxRegister1119 = uint32_t(r_LaneIndexAtPtx1505) + uint32_t(r_PtxRegister1118);		   // PTX L1509
	r_PtxRegister1120 = r_PtxRegister1119 & 2147483644;										   // PTX L1510
	r_PtxRegister1121 = uint32_t(r_LaneIndexAtPtx1505) - uint32_t(r_PtxRegister1120);		   // PTX L1511
	r_PtxRegister1122 = ShiftLeft(uint32_t(r_PtxRegister1121), uint32_t(1));				   // PTX L1512
	r_PtxRegister1123 = uint32_t(r_PtxRegister691) + uint32_t(r_PtxRegister1122);			   // PTX L1513
	r_PtxRegister1124 = ShiftRightSigned(int32_t(r_PtxRegister1123), uint32_t(1));			   // PTX L1514
	r_PtxU64Register220 = uint64_t(int64_t(int32_t(r_PtxRegister1124)) * int64_t(int32_t(4))); // PTX L1515
	r_PtxU64Register221 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register220);	   // PTX L1516
	r_PtxRegister601 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register221 + 524288ull);	   // PTX L1517
	r_LaneIndexAtPtx1519 = uint32_t((threadIdx.x & 31u));									   // PTX L1519
	r_PtxRegister1125 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1519), uint32_t(31));		   // PTX L1521
	r_PtxRegister1126 = ShiftRight(uint32_t(r_PtxRegister1125), uint32_t(30));				   // PTX L1522
	r_PtxRegister1127 = uint32_t(r_LaneIndexAtPtx1519) + uint32_t(r_PtxRegister1126);		   // PTX L1523
	r_PtxRegister1128 = r_PtxRegister1127 & 2147483644;										   // PTX L1524
	r_PtxRegister1129 = uint32_t(r_LaneIndexAtPtx1519) - uint32_t(r_PtxRegister1128);		   // PTX L1525
	r_PtxRegister1130 = ShiftLeft(uint32_t(r_PtxRegister1129), uint32_t(1));				   // PTX L1526
	r_PtxRegister1131 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister1130);			   // PTX L1527
	r_PtxRegister1132 = ShiftRight(uint32_t(r_PtxRegister1131), uint32_t(31));				   // PTX L1528
	r_PtxRegister1133 = uint32_t(r_PtxRegister1131) + uint32_t(r_PtxRegister1132);			   // PTX L1529
	r_PtxRegister1134 = ShiftRightSigned(int32_t(r_PtxRegister1133), uint32_t(1));			   // PTX L1530
	r_PtxU64Register222 = uint64_t(int64_t(int32_t(r_PtxRegister1134)) * int64_t(int32_t(4))); // PTX L1531
	r_PtxU64Register223 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register222);	   // PTX L1532
	r_PtxRegister603 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register223 + 524288ull);	   // PTX L1533
	r_LaneIndexAtPtx1535 = uint32_t((threadIdx.x & 31u));									   // PTX L1535
	r_PtxRegister1135 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1535), uint32_t(31));		   // PTX L1537
	r_PtxRegister1136 = ShiftRight(uint32_t(r_PtxRegister1135), uint32_t(30));				   // PTX L1538
	r_PtxRegister1137 = uint32_t(r_LaneIndexAtPtx1535) + uint32_t(r_PtxRegister1136);		   // PTX L1539
	r_PtxRegister1138 = r_PtxRegister1137 & 2147483644;										   // PTX L1540
	r_PtxRegister1139 = uint32_t(r_LaneIndexAtPtx1535) - uint32_t(r_PtxRegister1138);		   // PTX L1541
	r_PtxRegister1140 = ShiftLeft(uint32_t(r_PtxRegister1139), uint32_t(1));				   // PTX L1542
	r_PtxRegister1141 = uint32_t(r_PtxRegister708) + uint32_t(r_PtxRegister1140);			   // PTX L1543
	r_PtxRegister1142 = ShiftRight(uint32_t(r_PtxRegister1141), uint32_t(31));				   // PTX L1544
	r_PtxRegister1143 = uint32_t(r_PtxRegister1141) + uint32_t(r_PtxRegister1142);			   // PTX L1545
	r_PtxRegister1144 = ShiftRightSigned(int32_t(r_PtxRegister1143), uint32_t(1));			   // PTX L1546
	r_PtxU64Register224 = uint64_t(int64_t(int32_t(r_PtxRegister1144)) * int64_t(int32_t(4))); // PTX L1547
	r_PtxU64Register225 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register224);	   // PTX L1548
	r_PtxRegister605 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register225 + 524288ull);	   // PTX L1549
	r_LaneIndexAtPtx1551 = uint32_t((threadIdx.x & 31u));									   // PTX L1551
	r_PtxRegister1145 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1551), uint32_t(31));		   // PTX L1553
	r_PtxRegister1146 = ShiftRight(uint32_t(r_PtxRegister1145), uint32_t(30));				   // PTX L1554
	r_PtxRegister1147 = uint32_t(r_LaneIndexAtPtx1551) + uint32_t(r_PtxRegister1146);		   // PTX L1555
	r_PtxRegister1148 = r_PtxRegister1147 & 2147483644;										   // PTX L1556
	r_PtxRegister1149 = uint32_t(r_LaneIndexAtPtx1551) - uint32_t(r_PtxRegister1148);		   // PTX L1557
	r_PtxRegister1150 = ShiftLeft(uint32_t(r_PtxRegister1149), uint32_t(1));				   // PTX L1558
	r_PtxRegister1151 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister1150);			   // PTX L1559
	r_PtxRegister1152 = ShiftRightSigned(int32_t(r_PtxRegister1151), uint32_t(1));			   // PTX L1560
	r_PtxU64Register226 = uint64_t(int64_t(int32_t(r_PtxRegister1152)) * int64_t(int32_t(4))); // PTX L1561
	r_PtxU64Register227 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register226);	   // PTX L1562
	r_PtxRegister607 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register227 + 524288ull);	   // PTX L1563
	r_LaneIndexAtPtx1565 = uint32_t((threadIdx.x & 31u));									   // PTX L1565
	r_PtxRegister1153 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1565), uint32_t(31));		   // PTX L1567
	r_PtxRegister1154 = ShiftRight(uint32_t(r_PtxRegister1153), uint32_t(30));				   // PTX L1568
	r_PtxRegister1155 = uint32_t(r_LaneIndexAtPtx1565) + uint32_t(r_PtxRegister1154);		   // PTX L1569
	r_PtxRegister1156 = r_PtxRegister1155 & 2147483644;										   // PTX L1570
	r_PtxRegister1157 = uint32_t(r_LaneIndexAtPtx1565) - uint32_t(r_PtxRegister1156);		   // PTX L1571
	r_PtxRegister1158 = ShiftLeft(uint32_t(r_PtxRegister1157), uint32_t(1));				   // PTX L1572
	r_PtxRegister1159 = uint32_t(r_PtxRegister729) + uint32_t(r_PtxRegister1158);			   // PTX L1573
	r_PtxRegister1160 = ShiftRightSigned(int32_t(r_PtxRegister1159), uint32_t(1));			   // PTX L1574
	r_PtxU64Register228 = uint64_t(int64_t(int32_t(r_PtxRegister1160)) * int64_t(int32_t(4))); // PTX L1575
	r_PtxU64Register229 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register228);	   // PTX L1576
	r_PtxRegister609 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register229 + 524288ull);	   // PTX L1577
	r_LaneIndexAtPtx1579 = uint32_t((threadIdx.x & 31u));									   // PTX L1579
	r_PtxRegister1161 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1579), uint32_t(31));		   // PTX L1581
	r_PtxRegister1162 = ShiftRight(uint32_t(r_PtxRegister1161), uint32_t(30));				   // PTX L1582
	r_PtxRegister1163 = uint32_t(r_LaneIndexAtPtx1579) + uint32_t(r_PtxRegister1162);		   // PTX L1583
	r_PtxRegister1164 = r_PtxRegister1163 & 2147483644;										   // PTX L1584
	r_PtxRegister1165 = uint32_t(r_LaneIndexAtPtx1579) - uint32_t(r_PtxRegister1164);		   // PTX L1585
	r_PtxRegister1166 = ShiftLeft(uint32_t(r_PtxRegister1165), uint32_t(1));				   // PTX L1586
	r_PtxRegister1167 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister1166);			   // PTX L1587
	r_PtxRegister1168 = ShiftRight(uint32_t(r_PtxRegister1167), uint32_t(31));				   // PTX L1588
	r_PtxRegister1169 = uint32_t(r_PtxRegister1167) + uint32_t(r_PtxRegister1168);			   // PTX L1589
	r_PtxRegister1170 = ShiftRightSigned(int32_t(r_PtxRegister1169), uint32_t(1));			   // PTX L1590
	r_PtxU64Register230 = uint64_t(int64_t(int32_t(r_PtxRegister1170)) * int64_t(int32_t(4))); // PTX L1591
	r_PtxU64Register231 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register230);	   // PTX L1592
	r_PtxRegister611 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register231 + 524288ull);	   // PTX L1593
	r_LaneIndexAtPtx1595 = uint32_t((threadIdx.x & 31u));									   // PTX L1595
	r_PtxRegister1171 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1595), uint32_t(31));		   // PTX L1597
	r_PtxRegister1172 = ShiftRight(uint32_t(r_PtxRegister1171), uint32_t(30));				   // PTX L1598
	r_PtxRegister1173 = uint32_t(r_LaneIndexAtPtx1595) + uint32_t(r_PtxRegister1172);		   // PTX L1599
	r_PtxRegister1174 = r_PtxRegister1173 & 2147483644;										   // PTX L1600
	r_PtxRegister1175 = uint32_t(r_LaneIndexAtPtx1595) - uint32_t(r_PtxRegister1174);		   // PTX L1601
	r_PtxRegister1176 = ShiftLeft(uint32_t(r_PtxRegister1175), uint32_t(1));				   // PTX L1602
	r_PtxRegister1177 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister1176);			   // PTX L1603
	r_PtxRegister1178 = ShiftRight(uint32_t(r_PtxRegister1177), uint32_t(31));				   // PTX L1604
	r_PtxRegister1179 = uint32_t(r_PtxRegister1177) + uint32_t(r_PtxRegister1178);			   // PTX L1605
	r_PtxRegister1180 = ShiftRightSigned(int32_t(r_PtxRegister1179), uint32_t(1));			   // PTX L1606
	r_PtxU64Register232 = uint64_t(int64_t(int32_t(r_PtxRegister1180)) * int64_t(int32_t(4))); // PTX L1607
	r_PtxU64Register233 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register232);	   // PTX L1608
	r_PtxRegister613 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register233 + 524288ull);	   // PTX L1609
	r_LaneIndexAtPtx1611 = uint32_t((threadIdx.x & 31u));									   // PTX L1611
	r_PackedHalf2AtPtx1614R1971 = HalfMul(r_PackedHalf2AtPtx326R1847, r_PtxRegister487);	   // PTX L1614
	r_LaneIndexAtPtx1618 = uint32_t((threadIdx.x & 31u));									   // PTX L1618
	r_PackedHalf2AtPtx1621R1970 = HalfMul(r_PackedHalf2AtPtx327R1848, r_PtxRegister489);	   // PTX L1621
	r_LaneIndexAtPtx1625 = uint32_t((threadIdx.x & 31u));									   // PTX L1625
	r_PackedHalf2AtPtx1628R1969 = HalfMul(r_PackedHalf2AtPtx328R1849, r_PtxRegister491);	   // PTX L1628
	r_LaneIndexAtPtx1632 = uint32_t((threadIdx.x & 31u));									   // PTX L1632
	r_PackedHalf2AtPtx1635R1968 = HalfMul(r_PackedHalf2AtPtx329R1850, r_PtxRegister493);	   // PTX L1635
	r_LaneIndexAtPtx1639 = uint32_t((threadIdx.x & 31u));									   // PTX L1639
	r_PackedHalf2AtPtx1642R1967 = HalfMul(r_PackedHalf2AtPtx345R1851, r_PtxRegister495);	   // PTX L1642
	r_LaneIndexAtPtx1646 = uint32_t((threadIdx.x & 31u));									   // PTX L1646
	r_PackedHalf2AtPtx1649R1966 = HalfMul(r_PackedHalf2AtPtx346R1852, r_PtxRegister497);	   // PTX L1649
	r_LaneIndexAtPtx1653 = uint32_t((threadIdx.x & 31u));									   // PTX L1653
	r_PackedHalf2AtPtx1656R1965 = HalfMul(r_PackedHalf2AtPtx347R1853, r_PtxRegister499);	   // PTX L1656
	r_LaneIndexAtPtx1660 = uint32_t((threadIdx.x & 31u));									   // PTX L1660
	r_PackedHalf2AtPtx1663R1964 = HalfMul(r_PackedHalf2AtPtx348R1854, r_PtxRegister501);	   // PTX L1663
	r_LaneIndexAtPtx1667 = uint32_t((threadIdx.x & 31u));									   // PTX L1667
	r_PackedHalf2AtPtx1670R1963 = HalfMul(r_PackedHalf2AtPtx364R1855, r_PtxRegister503);	   // PTX L1670
	r_LaneIndexAtPtx1674 = uint32_t((threadIdx.x & 31u));									   // PTX L1674
	r_PackedHalf2AtPtx1677R1962 = HalfMul(r_PackedHalf2AtPtx365R1856, r_PtxRegister505);	   // PTX L1677
	r_LaneIndexAtPtx1681 = uint32_t((threadIdx.x & 31u));									   // PTX L1681
	r_PackedHalf2AtPtx1684R1961 = HalfMul(r_PackedHalf2AtPtx366R1857, r_PtxRegister507);	   // PTX L1684
	r_LaneIndexAtPtx1688 = uint32_t((threadIdx.x & 31u));									   // PTX L1688
	r_PackedHalf2AtPtx1691R1960 = HalfMul(r_PackedHalf2AtPtx367R1858, r_PtxRegister509);	   // PTX L1691
	r_LaneIndexAtPtx1695 = uint32_t((threadIdx.x & 31u));									   // PTX L1695
	r_PackedHalf2AtPtx1698R1959 = HalfMul(r_PackedHalf2AtPtx383R1859, r_PtxRegister511);	   // PTX L1698
	r_LaneIndexAtPtx1702 = uint32_t((threadIdx.x & 31u));									   // PTX L1702
	r_PackedHalf2AtPtx1705R1958 = HalfMul(r_PackedHalf2AtPtx384R1860, r_PtxRegister513);	   // PTX L1705
	r_LaneIndexAtPtx1709 = uint32_t((threadIdx.x & 31u));									   // PTX L1709
	r_PackedHalf2AtPtx1712R1957 = HalfMul(r_PackedHalf2AtPtx385R1861, r_PtxRegister515);	   // PTX L1712
	r_LaneIndexAtPtx1716 = uint32_t((threadIdx.x & 31u));									   // PTX L1716
	r_PackedHalf2AtPtx1719R1956 = HalfMul(r_PackedHalf2AtPtx386R1862, r_PtxRegister517);	   // PTX L1719
	r_LaneIndexAtPtx1723 = uint32_t((threadIdx.x & 31u));									   // PTX L1723
	r_PackedHalf2AtPtx1726R1955 = HalfMul(r_PackedHalf2AtPtx408R1863, r_PtxRegister519);	   // PTX L1726
	r_LaneIndexAtPtx1730 = uint32_t((threadIdx.x & 31u));									   // PTX L1730
	r_PackedHalf2AtPtx1733R1954 = HalfMul(r_PackedHalf2AtPtx409R1864, r_PtxRegister521);	   // PTX L1733
	r_LaneIndexAtPtx1737 = uint32_t((threadIdx.x & 31u));									   // PTX L1737
	r_PackedHalf2AtPtx1740R1953 = HalfMul(r_PackedHalf2AtPtx410R1865, r_PtxRegister523);	   // PTX L1740
	r_LaneIndexAtPtx1744 = uint32_t((threadIdx.x & 31u));									   // PTX L1744
	r_PackedHalf2AtPtx1747R1952 = HalfMul(r_PackedHalf2AtPtx411R1866, r_PtxRegister525);	   // PTX L1747
	r_LaneIndexAtPtx1751 = uint32_t((threadIdx.x & 31u));									   // PTX L1751
	r_PackedHalf2AtPtx1754R1951 = HalfMul(r_PackedHalf2AtPtx427R1867, r_PtxRegister527);	   // PTX L1754
	r_LaneIndexAtPtx1758 = uint32_t((threadIdx.x & 31u));									   // PTX L1758
	r_PackedHalf2AtPtx1761R1950 = HalfMul(r_PackedHalf2AtPtx428R1868, r_PtxRegister529);	   // PTX L1761
	r_LaneIndexAtPtx1765 = uint32_t((threadIdx.x & 31u));									   // PTX L1765
	r_PackedHalf2AtPtx1768R1949 = HalfMul(r_PackedHalf2AtPtx429R1869, r_PtxRegister531);	   // PTX L1768
	r_LaneIndexAtPtx1772 = uint32_t((threadIdx.x & 31u));									   // PTX L1772
	r_PackedHalf2AtPtx1775R1948 = HalfMul(r_PackedHalf2AtPtx430R1870, r_PtxRegister533);	   // PTX L1775
	r_LaneIndexAtPtx1779 = uint32_t((threadIdx.x & 31u));									   // PTX L1779
	r_PackedHalf2AtPtx1782R1947 = HalfMul(r_PackedHalf2AtPtx446R1871, r_PtxRegister535);	   // PTX L1782
	r_LaneIndexAtPtx1786 = uint32_t((threadIdx.x & 31u));									   // PTX L1786
	r_PackedHalf2AtPtx1789R1946 = HalfMul(r_PackedHalf2AtPtx447R1872, r_PtxRegister537);	   // PTX L1789
	r_LaneIndexAtPtx1793 = uint32_t((threadIdx.x & 31u));									   // PTX L1793
	r_PackedHalf2AtPtx1796R1945 = HalfMul(r_PackedHalf2AtPtx448R1873, r_PtxRegister539);	   // PTX L1796
	r_LaneIndexAtPtx1800 = uint32_t((threadIdx.x & 31u));									   // PTX L1800
	r_PackedHalf2AtPtx1803R1944 = HalfMul(r_PackedHalf2AtPtx449R1874, r_PtxRegister541);	   // PTX L1803
	r_LaneIndexAtPtx1807 = uint32_t((threadIdx.x & 31u));									   // PTX L1807
	r_PackedHalf2AtPtx1810R1943 = HalfMul(r_PackedHalf2AtPtx465R1875, r_PtxRegister543);	   // PTX L1810
	r_LaneIndexAtPtx1814 = uint32_t((threadIdx.x & 31u));									   // PTX L1814
	r_PackedHalf2AtPtx1817R1942 = HalfMul(r_PackedHalf2AtPtx466R1876, r_PtxRegister545);	   // PTX L1817
	r_LaneIndexAtPtx1821 = uint32_t((threadIdx.x & 31u));									   // PTX L1821
	r_PackedHalf2AtPtx1824R1941 = HalfMul(r_PackedHalf2AtPtx467R1877, r_PtxRegister547);	   // PTX L1824
	r_LaneIndexAtPtx1828 = uint32_t((threadIdx.x & 31u));									   // PTX L1828
	r_PackedHalf2AtPtx1831R1940 = HalfMul(r_PackedHalf2AtPtx468R1878, r_PtxRegister549);	   // PTX L1831
	r_LaneIndexAtPtx1835 = uint32_t((threadIdx.x & 31u));									   // PTX L1835
	r_PackedHalf2AtPtx1838R1939 = HalfMul(r_PackedHalf2AtPtx501R1879, r_PtxRegister551);	   // PTX L1838
	r_LaneIndexAtPtx1842 = uint32_t((threadIdx.x & 31u));									   // PTX L1842
	r_PackedHalf2AtPtx1845R1938 = HalfMul(r_PackedHalf2AtPtx502R1880, r_PtxRegister553);	   // PTX L1845
	r_LaneIndexAtPtx1849 = uint32_t((threadIdx.x & 31u));									   // PTX L1849
	r_PackedHalf2AtPtx1852R1937 = HalfMul(r_PackedHalf2AtPtx503R1881, r_PtxRegister555);	   // PTX L1852
	r_LaneIndexAtPtx1856 = uint32_t((threadIdx.x & 31u));									   // PTX L1856
	r_PackedHalf2AtPtx1859R1936 = HalfMul(r_PackedHalf2AtPtx504R1882, r_PtxRegister557);	   // PTX L1859
	r_LaneIndexAtPtx1863 = uint32_t((threadIdx.x & 31u));									   // PTX L1863
	r_PackedHalf2AtPtx1866R1935 = HalfMul(r_PackedHalf2AtPtx520R1883, r_PtxRegister559);	   // PTX L1866
	r_LaneIndexAtPtx1870 = uint32_t((threadIdx.x & 31u));									   // PTX L1870
	r_PackedHalf2AtPtx1873R1934 = HalfMul(r_PackedHalf2AtPtx521R1884, r_PtxRegister561);	   // PTX L1873
	r_LaneIndexAtPtx1877 = uint32_t((threadIdx.x & 31u));									   // PTX L1877
	r_PackedHalf2AtPtx1880R1933 = HalfMul(r_PackedHalf2AtPtx522R1885, r_PtxRegister563);	   // PTX L1880
	r_LaneIndexAtPtx1884 = uint32_t((threadIdx.x & 31u));									   // PTX L1884
	r_PackedHalf2AtPtx1887R1932 = HalfMul(r_PackedHalf2AtPtx523R1886, r_PtxRegister565);	   // PTX L1887
	r_LaneIndexAtPtx1891 = uint32_t((threadIdx.x & 31u));									   // PTX L1891
	r_PackedHalf2AtPtx1894R1931 = HalfMul(r_PackedHalf2AtPtx539R1887, r_PtxRegister567);	   // PTX L1894
	r_LaneIndexAtPtx1898 = uint32_t((threadIdx.x & 31u));									   // PTX L1898
	r_PackedHalf2AtPtx1901R1930 = HalfMul(r_PackedHalf2AtPtx540R1888, r_PtxRegister569);	   // PTX L1901
	r_LaneIndexAtPtx1905 = uint32_t((threadIdx.x & 31u));									   // PTX L1905
	r_PackedHalf2AtPtx1908R1929 = HalfMul(r_PackedHalf2AtPtx541R1889, r_PtxRegister571);	   // PTX L1908
	r_LaneIndexAtPtx1912 = uint32_t((threadIdx.x & 31u));									   // PTX L1912
	r_PackedHalf2AtPtx1915R1928 = HalfMul(r_PackedHalf2AtPtx542R1890, r_PtxRegister573);	   // PTX L1915
	r_LaneIndexAtPtx1919 = uint32_t((threadIdx.x & 31u));									   // PTX L1919
	r_PackedHalf2AtPtx1922R1927 = HalfMul(r_PackedHalf2AtPtx558R1891, r_PtxRegister575);	   // PTX L1922
	r_LaneIndexAtPtx1926 = uint32_t((threadIdx.x & 31u));									   // PTX L1926
	r_PackedHalf2AtPtx1929R1926 = HalfMul(r_PackedHalf2AtPtx559R1892, r_PtxRegister577);	   // PTX L1929
	r_LaneIndexAtPtx1933 = uint32_t((threadIdx.x & 31u));									   // PTX L1933
	r_PackedHalf2AtPtx1936R1925 = HalfMul(r_PackedHalf2AtPtx560R1893, r_PtxRegister579);	   // PTX L1936
	r_LaneIndexAtPtx1940 = uint32_t((threadIdx.x & 31u));									   // PTX L1940
	r_PackedHalf2AtPtx1943R1924 = HalfMul(r_PackedHalf2AtPtx561R1894, r_PtxRegister581);	   // PTX L1943
	r_LaneIndexAtPtx1947 = uint32_t((threadIdx.x & 31u));									   // PTX L1947
	r_PackedHalf2AtPtx1950R1923 = HalfMul(r_PackedHalf2AtPtx582R1895, r_PtxRegister583);	   // PTX L1950
	r_LaneIndexAtPtx1954 = uint32_t((threadIdx.x & 31u));									   // PTX L1954
	r_PackedHalf2AtPtx1957R1922 = HalfMul(r_PackedHalf2AtPtx583R1896, r_PtxRegister585);	   // PTX L1957
	r_LaneIndexAtPtx1961 = uint32_t((threadIdx.x & 31u));									   // PTX L1961
	r_PackedHalf2AtPtx1964R1921 = HalfMul(r_PackedHalf2AtPtx584R1897, r_PtxRegister587);	   // PTX L1964
	r_LaneIndexAtPtx1968 = uint32_t((threadIdx.x & 31u));									   // PTX L1968
	r_PackedHalf2AtPtx1971R1920 = HalfMul(r_PackedHalf2AtPtx585R1898, r_PtxRegister589);	   // PTX L1971
	r_LaneIndexAtPtx1975 = uint32_t((threadIdx.x & 31u));									   // PTX L1975
	r_PackedHalf2AtPtx1978R1919 = HalfMul(r_PackedHalf2AtPtx601R1899, r_PtxRegister591);	   // PTX L1978
	r_LaneIndexAtPtx1982 = uint32_t((threadIdx.x & 31u));									   // PTX L1982
	r_PackedHalf2AtPtx1985R1918 = HalfMul(r_PackedHalf2AtPtx602R1900, r_PtxRegister593);	   // PTX L1985
	r_LaneIndexAtPtx1989 = uint32_t((threadIdx.x & 31u));									   // PTX L1989
	r_PackedHalf2AtPtx1992R1917 = HalfMul(r_PackedHalf2AtPtx603R1901, r_PtxRegister595);	   // PTX L1992
	r_LaneIndexAtPtx1996 = uint32_t((threadIdx.x & 31u));									   // PTX L1996
	r_PackedHalf2AtPtx1999R1916 = HalfMul(r_PackedHalf2AtPtx604R1902, r_PtxRegister597);	   // PTX L1999
	r_LaneIndexAtPtx2003 = uint32_t((threadIdx.x & 31u));									   // PTX L2003
	r_PackedHalf2AtPtx2006R1915 = HalfMul(r_PackedHalf2AtPtx620R1903, r_PtxRegister599);	   // PTX L2006
	r_LaneIndexAtPtx2010 = uint32_t((threadIdx.x & 31u));									   // PTX L2010
	r_PackedHalf2AtPtx2013R1914 = HalfMul(r_PackedHalf2AtPtx621R1904, r_PtxRegister601);	   // PTX L2013
	r_LaneIndexAtPtx2017 = uint32_t((threadIdx.x & 31u));									   // PTX L2017
	r_PackedHalf2AtPtx2020R1913 = HalfMul(r_PackedHalf2AtPtx622R1905, r_PtxRegister603);	   // PTX L2020
	r_LaneIndexAtPtx2024 = uint32_t((threadIdx.x & 31u));									   // PTX L2024
	r_PackedHalf2AtPtx2027R1912 = HalfMul(r_PackedHalf2AtPtx623R1906, r_PtxRegister605);	   // PTX L2027
	r_LaneIndexAtPtx2031 = uint32_t((threadIdx.x & 31u));									   // PTX L2031
	r_PackedHalf2AtPtx2034R1911 = HalfMul(r_PackedHalf2AtPtx639R1907, r_PtxRegister607);	   // PTX L2034
	r_LaneIndexAtPtx2038 = uint32_t((threadIdx.x & 31u));									   // PTX L2038
	r_PackedHalf2AtPtx2041R1972 = HalfMul(r_PackedHalf2AtPtx640R1908, r_PtxRegister609);	   // PTX L2041
	r_LaneIndexAtPtx2045 = uint32_t((threadIdx.x & 31u));									   // PTX L2045
	r_PackedHalf2AtPtx2048R1973 = HalfMul(r_PackedHalf2AtPtx641R1909, r_PtxRegister611);	   // PTX L2048
	r_LaneIndexAtPtx2052 = uint32_t((threadIdx.x & 31u));									   // PTX L2052
	r_PackedHalf2AtPtx2055R1974 = HalfMul(r_PackedHalf2AtPtx642R1910, r_PtxRegister613);	   // PTX L2055
	r_PtxU64Register2 = r_Pointer0Bits;														   // PTX L2058
	r_PtxRegister33 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));								   // PTX L2059
	r_PtxRegister1975 = uint32_t(0);														   // PTX L2060
L__BB38_55:																					   // PTX L2061
	r_PtxRegister34 = r_ThreadY & 1;														   // PTX L2062
	r_PtxRegister1293 = r_PtxRegister310 | r_PtxRegister5;									   // PTX L2063
	r_bPtxPredicate54 = int32_t(r_PtxRegister1293) < int32_t(r_PtxRegister7);				   // PTX L2064
	r_bPtxPredicate55 = int32_t(r_PtxRegister314) < int32_t(r_PtxRegister6);				   // PTX L2065
	r_bPtxPredicate56 = int32_t(r_PtxRegister314) >= int32_t(r_PtxRegister6);				   // PTX L2066
	r_bPtxPredicate57 = uint32_t(r_PtxRegister24) == uint32_t(4);							   // PTX L2067
	r_bPtxPredicate58 = uint32_t(r_PtxRegister18) == uint32_t(4);							   // PTX L2068
	r_PtxRegister1294 = ShiftRight(uint32_t(r_PtxRegister1975), uint32_t(5));				   // PTX L2069
	r_PtxRegister1295 = ~uint32_t(r_PtxRegister1294);										   // PTX L2070
	r_PtxRegister35 = uint32_t(r_PtxRegister1975) + uint32_t(32);							   // PTX L2071
	r_PtxRegister36 = r_PtxRegister1295 & 1;												   // PTX L2072
	r_PtxRegister1296 = ShiftLeft(uint32_t(r_PtxRegister1975), uint32_t(7));				   // PTX L2073
	r_PtxRegister1297 = r_PtxRegister1296 & 4096;											   // PTX L2074
	r_PtxRegister1298 = uint32_t(0u /* exact native shared-region offset */);				   // PTX L2075
	r_PtxRegister1299 = uint32_t(r_PtxRegister1298) + uint32_t(r_PtxRegister1297);			   // PTX L2076
	r_LaneIndexAtPtx2078 = uint32_t((threadIdx.x & 31u));									   // PTX L2078
	r_PtxRegister1300 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2078), uint32_t(4));				   // PTX L2080
	r_PtxRegister1182 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1300);			   // PTX L2081
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1182));
		r_MmaAHalf2WordAtPtx2083R1197 = r_Value.x;
		r_MmaAHalf2WordAtPtx2083R1198 = r_Value.y;
		r_MmaAHalf2WordAtPtx2083R1199 = r_Value.z;
		r_MmaAHalf2WordAtPtx2083R1200 = r_Value.w;
	} // PTX L2083
	r_LaneIndexAtPtx2086 = uint32_t((threadIdx.x & 31u));						   // PTX L2086
	r_PtxRegister1301 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2086), uint32_t(4));	   // PTX L2088
	r_PtxRegister1302 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1301); // PTX L2089
	r_PtxRegister1184 = uint32_t(r_PtxRegister1302) + uint32_t(512);			   // PTX L2090
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1184));
		r_MmaAHalf2WordAtPtx2092R1201 = r_Value.x;
		r_MmaAHalf2WordAtPtx2092R1202 = r_Value.y;
		r_MmaAHalf2WordAtPtx2092R1203 = r_Value.z;
		r_MmaAHalf2WordAtPtx2092R1204 = r_Value.w;
	} // PTX L2092
	r_LaneIndexAtPtx2095 = uint32_t((threadIdx.x & 31u));						   // PTX L2095
	r_PtxRegister1303 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2095), uint32_t(4));	   // PTX L2097
	r_PtxRegister1304 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1303); // PTX L2098
	r_PtxRegister1186 = uint32_t(r_PtxRegister1304) + uint32_t(1024);			   // PTX L2099
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1186));
		r_MmaAHalf2WordAtPtx2101R1221 = r_Value.x;
		r_MmaAHalf2WordAtPtx2101R1222 = r_Value.y;
		r_MmaAHalf2WordAtPtx2101R1223 = r_Value.z;
		r_MmaAHalf2WordAtPtx2101R1224 = r_Value.w;
	} // PTX L2101
	r_LaneIndexAtPtx2104 = uint32_t((threadIdx.x & 31u));						   // PTX L2104
	r_PtxRegister1305 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2104), uint32_t(4));	   // PTX L2106
	r_PtxRegister1306 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1305); // PTX L2107
	r_PtxRegister1188 = uint32_t(r_PtxRegister1306) + uint32_t(1536);			   // PTX L2108
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1188));
		r_MmaAHalf2WordAtPtx2110R1225 = r_Value.x;
		r_MmaAHalf2WordAtPtx2110R1226 = r_Value.y;
		r_MmaAHalf2WordAtPtx2110R1227 = r_Value.z;
		r_MmaAHalf2WordAtPtx2110R1228 = r_Value.w;
	} // PTX L2110
	r_LaneIndexAtPtx2113 = uint32_t((threadIdx.x & 31u));						   // PTX L2113
	r_PtxRegister1307 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2113), uint32_t(4));	   // PTX L2115
	r_PtxRegister1308 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1307); // PTX L2116
	r_PtxRegister1190 = uint32_t(r_PtxRegister1308) + uint32_t(2048);			   // PTX L2117
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1190));
		r_MmaAHalf2WordAtPtx2119R1245 = r_Value.x;
		r_MmaAHalf2WordAtPtx2119R1246 = r_Value.y;
		r_MmaAHalf2WordAtPtx2119R1247 = r_Value.z;
		r_MmaAHalf2WordAtPtx2119R1248 = r_Value.w;
	} // PTX L2119
	r_LaneIndexAtPtx2122 = uint32_t((threadIdx.x & 31u));						   // PTX L2122
	r_PtxRegister1309 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2122), uint32_t(4));	   // PTX L2124
	r_PtxRegister1310 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1309); // PTX L2125
	r_PtxRegister1192 = uint32_t(r_PtxRegister1310) + uint32_t(2560);			   // PTX L2126
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1192));
		r_MmaAHalf2WordAtPtx2128R1249 = r_Value.x;
		r_MmaAHalf2WordAtPtx2128R1250 = r_Value.y;
		r_MmaAHalf2WordAtPtx2128R1251 = r_Value.z;
		r_MmaAHalf2WordAtPtx2128R1252 = r_Value.w;
	} // PTX L2128
	r_LaneIndexAtPtx2131 = uint32_t((threadIdx.x & 31u));						   // PTX L2131
	r_PtxRegister1311 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2131), uint32_t(4));	   // PTX L2133
	r_PtxRegister1312 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1311); // PTX L2134
	r_PtxRegister1194 = uint32_t(r_PtxRegister1312) + uint32_t(3072);			   // PTX L2135
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1194));
		r_MmaAHalf2WordAtPtx2137R1269 = r_Value.x;
		r_MmaAHalf2WordAtPtx2137R1270 = r_Value.y;
		r_MmaAHalf2WordAtPtx2137R1271 = r_Value.z;
		r_MmaAHalf2WordAtPtx2137R1272 = r_Value.w;
	} // PTX L2137
	r_LaneIndexAtPtx2140 = uint32_t((threadIdx.x & 31u));						   // PTX L2140
	r_PtxRegister1313 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2140), uint32_t(4));	   // PTX L2142
	r_PtxRegister1314 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1313); // PTX L2143
	r_PtxRegister1196 = uint32_t(r_PtxRegister1314) + uint32_t(3584);			   // PTX L2144
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1196));
		r_MmaAHalf2WordAtPtx2146R1273 = r_Value.x;
		r_MmaAHalf2WordAtPtx2146R1274 = r_Value.y;
		r_MmaAHalf2WordAtPtx2146R1275 = r_Value.z;
		r_MmaAHalf2WordAtPtx2146R1276 = r_Value.w;
	} // PTX L2146
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2149R1205, r_MmaAccumulatorHalf2WordAtPtx2149R1206,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1614R1971, r_PackedHalf2AtPtx1621R1970); // PTX L2149
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2156R1207, r_MmaAccumulatorHalf2WordAtPtx2156R1208,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1628R1969, r_PackedHalf2AtPtx1635R1968); // PTX L2156
	MmaHalf(r_PackedHalf2AtPtx1614R1971, r_PackedHalf2AtPtx1621R1970, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx2149R1205,
			r_MmaAccumulatorHalf2WordAtPtx2149R1206); // PTX L2163
	MmaHalf(r_PackedHalf2AtPtx1628R1969, r_PackedHalf2AtPtx1635R1968, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx2156R1207,
			r_MmaAccumulatorHalf2WordAtPtx2156R1208); // PTX L2170
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2177R1209, r_MmaAccumulatorHalf2WordAtPtx2177R1210,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1642R1967, r_PackedHalf2AtPtx1649R1966); // PTX L2177
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2184R1211, r_MmaAccumulatorHalf2WordAtPtx2184R1212,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1656R1965, r_PackedHalf2AtPtx1663R1964); // PTX L2184
	MmaHalf(r_PackedHalf2AtPtx1642R1967, r_PackedHalf2AtPtx1649R1966, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx2177R1209,
			r_MmaAccumulatorHalf2WordAtPtx2177R1210); // PTX L2191
	MmaHalf(r_PackedHalf2AtPtx1656R1965, r_PackedHalf2AtPtx1663R1964, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx2184R1211,
			r_MmaAccumulatorHalf2WordAtPtx2184R1212); // PTX L2198
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2205R1213, r_MmaAccumulatorHalf2WordAtPtx2205R1214,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1670R1963, r_PackedHalf2AtPtx1677R1962); // PTX L2205
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2212R1215, r_MmaAccumulatorHalf2WordAtPtx2212R1216,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1684R1961, r_PackedHalf2AtPtx1691R1960); // PTX L2212
	MmaHalf(r_PackedHalf2AtPtx1670R1963, r_PackedHalf2AtPtx1677R1962, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx2205R1213,
			r_MmaAccumulatorHalf2WordAtPtx2205R1214); // PTX L2219
	MmaHalf(r_PackedHalf2AtPtx1684R1961, r_PackedHalf2AtPtx1691R1960, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx2212R1215,
			r_MmaAccumulatorHalf2WordAtPtx2212R1216); // PTX L2226
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2233R1217, r_MmaAccumulatorHalf2WordAtPtx2233R1218,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1698R1959, r_PackedHalf2AtPtx1705R1958); // PTX L2233
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2240R1219, r_MmaAccumulatorHalf2WordAtPtx2240R1220,
			r_MmaAHalf2WordAtPtx2083R1197, r_MmaAHalf2WordAtPtx2083R1198, r_MmaAHalf2WordAtPtx2083R1199,
			r_MmaAHalf2WordAtPtx2083R1200, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1712R1957, r_PackedHalf2AtPtx1719R1956); // PTX L2240
	MmaHalf(r_PackedHalf2AtPtx1698R1959, r_PackedHalf2AtPtx1705R1958, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx2233R1217,
			r_MmaAccumulatorHalf2WordAtPtx2233R1218); // PTX L2247
	MmaHalf(r_PackedHalf2AtPtx1712R1957, r_PackedHalf2AtPtx1719R1956, r_MmaAHalf2WordAtPtx2092R1201,
			r_MmaAHalf2WordAtPtx2092R1202, r_MmaAHalf2WordAtPtx2092R1203, r_MmaAHalf2WordAtPtx2092R1204,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx2240R1219,
			r_MmaAccumulatorHalf2WordAtPtx2240R1220); // PTX L2254
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2261R1229, r_MmaAccumulatorHalf2WordAtPtx2261R1230,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1726R1955, r_PackedHalf2AtPtx1733R1954); // PTX L2261
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2268R1231, r_MmaAccumulatorHalf2WordAtPtx2268R1232,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1740R1953, r_PackedHalf2AtPtx1747R1952); // PTX L2268
	MmaHalf(r_PackedHalf2AtPtx1726R1955, r_PackedHalf2AtPtx1733R1954, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx2261R1229,
			r_MmaAccumulatorHalf2WordAtPtx2261R1230); // PTX L2275
	MmaHalf(r_PackedHalf2AtPtx1740R1953, r_PackedHalf2AtPtx1747R1952, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx2268R1231,
			r_MmaAccumulatorHalf2WordAtPtx2268R1232); // PTX L2282
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2289R1233, r_MmaAccumulatorHalf2WordAtPtx2289R1234,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1754R1951, r_PackedHalf2AtPtx1761R1950); // PTX L2289
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2296R1235, r_MmaAccumulatorHalf2WordAtPtx2296R1236,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1768R1949, r_PackedHalf2AtPtx1775R1948); // PTX L2296
	MmaHalf(r_PackedHalf2AtPtx1754R1951, r_PackedHalf2AtPtx1761R1950, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx2289R1233,
			r_MmaAccumulatorHalf2WordAtPtx2289R1234); // PTX L2303
	MmaHalf(r_PackedHalf2AtPtx1768R1949, r_PackedHalf2AtPtx1775R1948, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx2296R1235,
			r_MmaAccumulatorHalf2WordAtPtx2296R1236); // PTX L2310
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2317R1237, r_MmaAccumulatorHalf2WordAtPtx2317R1238,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1782R1947, r_PackedHalf2AtPtx1789R1946); // PTX L2317
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2324R1239, r_MmaAccumulatorHalf2WordAtPtx2324R1240,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1796R1945, r_PackedHalf2AtPtx1803R1944); // PTX L2324
	MmaHalf(r_PackedHalf2AtPtx1782R1947, r_PackedHalf2AtPtx1789R1946, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx2317R1237,
			r_MmaAccumulatorHalf2WordAtPtx2317R1238); // PTX L2331
	MmaHalf(r_PackedHalf2AtPtx1796R1945, r_PackedHalf2AtPtx1803R1944, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx2324R1239,
			r_MmaAccumulatorHalf2WordAtPtx2324R1240); // PTX L2338
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2345R1241, r_MmaAccumulatorHalf2WordAtPtx2345R1242,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1810R1943, r_PackedHalf2AtPtx1817R1942); // PTX L2345
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2352R1243, r_MmaAccumulatorHalf2WordAtPtx2352R1244,
			r_MmaAHalf2WordAtPtx2101R1221, r_MmaAHalf2WordAtPtx2101R1222, r_MmaAHalf2WordAtPtx2101R1223,
			r_MmaAHalf2WordAtPtx2101R1224, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1824R1941, r_PackedHalf2AtPtx1831R1940); // PTX L2352
	MmaHalf(r_PackedHalf2AtPtx1810R1943, r_PackedHalf2AtPtx1817R1942, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx2345R1241,
			r_MmaAccumulatorHalf2WordAtPtx2345R1242); // PTX L2359
	MmaHalf(r_PackedHalf2AtPtx1824R1941, r_PackedHalf2AtPtx1831R1940, r_MmaAHalf2WordAtPtx2110R1225,
			r_MmaAHalf2WordAtPtx2110R1226, r_MmaAHalf2WordAtPtx2110R1227, r_MmaAHalf2WordAtPtx2110R1228,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx2352R1243,
			r_MmaAccumulatorHalf2WordAtPtx2352R1244); // PTX L2366
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2373R1253, r_MmaAccumulatorHalf2WordAtPtx2373R1254,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1838R1939, r_PackedHalf2AtPtx1845R1938); // PTX L2373
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2380R1255, r_MmaAccumulatorHalf2WordAtPtx2380R1256,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1852R1937, r_PackedHalf2AtPtx1859R1936); // PTX L2380
	MmaHalf(r_PackedHalf2AtPtx1838R1939, r_PackedHalf2AtPtx1845R1938, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx2373R1253,
			r_MmaAccumulatorHalf2WordAtPtx2373R1254); // PTX L2387
	MmaHalf(r_PackedHalf2AtPtx1852R1937, r_PackedHalf2AtPtx1859R1936, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx2380R1255,
			r_MmaAccumulatorHalf2WordAtPtx2380R1256); // PTX L2394
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2401R1257, r_MmaAccumulatorHalf2WordAtPtx2401R1258,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1866R1935, r_PackedHalf2AtPtx1873R1934); // PTX L2401
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2408R1259, r_MmaAccumulatorHalf2WordAtPtx2408R1260,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1880R1933, r_PackedHalf2AtPtx1887R1932); // PTX L2408
	MmaHalf(r_PackedHalf2AtPtx1866R1935, r_PackedHalf2AtPtx1873R1934, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx2401R1257,
			r_MmaAccumulatorHalf2WordAtPtx2401R1258); // PTX L2415
	MmaHalf(r_PackedHalf2AtPtx1880R1933, r_PackedHalf2AtPtx1887R1932, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx2408R1259,
			r_MmaAccumulatorHalf2WordAtPtx2408R1260); // PTX L2422
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2429R1261, r_MmaAccumulatorHalf2WordAtPtx2429R1262,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1894R1931, r_PackedHalf2AtPtx1901R1930); // PTX L2429
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2436R1263, r_MmaAccumulatorHalf2WordAtPtx2436R1264,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1908R1929, r_PackedHalf2AtPtx1915R1928); // PTX L2436
	MmaHalf(r_PackedHalf2AtPtx1894R1931, r_PackedHalf2AtPtx1901R1930, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx2429R1261,
			r_MmaAccumulatorHalf2WordAtPtx2429R1262); // PTX L2443
	MmaHalf(r_PackedHalf2AtPtx1908R1929, r_PackedHalf2AtPtx1915R1928, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx2436R1263,
			r_MmaAccumulatorHalf2WordAtPtx2436R1264); // PTX L2450
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2457R1265, r_MmaAccumulatorHalf2WordAtPtx2457R1266,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1922R1927, r_PackedHalf2AtPtx1929R1926); // PTX L2457
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2464R1267, r_MmaAccumulatorHalf2WordAtPtx2464R1268,
			r_MmaAHalf2WordAtPtx2119R1245, r_MmaAHalf2WordAtPtx2119R1246, r_MmaAHalf2WordAtPtx2119R1247,
			r_MmaAHalf2WordAtPtx2119R1248, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1936R1925, r_PackedHalf2AtPtx1943R1924); // PTX L2464
	MmaHalf(r_PackedHalf2AtPtx1922R1927, r_PackedHalf2AtPtx1929R1926, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx2457R1265,
			r_MmaAccumulatorHalf2WordAtPtx2457R1266); // PTX L2471
	MmaHalf(r_PackedHalf2AtPtx1936R1925, r_PackedHalf2AtPtx1943R1924, r_MmaAHalf2WordAtPtx2128R1249,
			r_MmaAHalf2WordAtPtx2128R1250, r_MmaAHalf2WordAtPtx2128R1251, r_MmaAHalf2WordAtPtx2128R1252,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx2464R1267,
			r_MmaAccumulatorHalf2WordAtPtx2464R1268); // PTX L2478
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2485R1277, r_MmaAccumulatorHalf2WordAtPtx2485R1278,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1950R1923, r_PackedHalf2AtPtx1957R1922); // PTX L2485
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2492R1279, r_MmaAccumulatorHalf2WordAtPtx2492R1280,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1964R1921, r_PackedHalf2AtPtx1971R1920); // PTX L2492
	MmaHalf(r_PackedHalf2AtPtx1950R1923, r_PackedHalf2AtPtx1957R1922, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx2485R1277,
			r_MmaAccumulatorHalf2WordAtPtx2485R1278); // PTX L2499
	MmaHalf(r_PackedHalf2AtPtx1964R1921, r_PackedHalf2AtPtx1971R1920, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx2492R1279,
			r_MmaAccumulatorHalf2WordAtPtx2492R1280); // PTX L2506
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2513R1281, r_MmaAccumulatorHalf2WordAtPtx2513R1282,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1978R1919, r_PackedHalf2AtPtx1985R1918); // PTX L2513
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2520R1283, r_MmaAccumulatorHalf2WordAtPtx2520R1284,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1992R1917, r_PackedHalf2AtPtx1999R1916); // PTX L2520
	MmaHalf(r_PackedHalf2AtPtx1978R1919, r_PackedHalf2AtPtx1985R1918, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx2513R1281,
			r_MmaAccumulatorHalf2WordAtPtx2513R1282); // PTX L2527
	MmaHalf(r_PackedHalf2AtPtx1992R1917, r_PackedHalf2AtPtx1999R1916, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx2520R1283,
			r_MmaAccumulatorHalf2WordAtPtx2520R1284); // PTX L2534
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2541R1285, r_MmaAccumulatorHalf2WordAtPtx2541R1286,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx2006R1915, r_PackedHalf2AtPtx2013R1914); // PTX L2541
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2548R1287, r_MmaAccumulatorHalf2WordAtPtx2548R1288,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx2020R1913, r_PackedHalf2AtPtx2027R1912); // PTX L2548
	MmaHalf(r_PackedHalf2AtPtx2006R1915, r_PackedHalf2AtPtx2013R1914, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx2541R1285,
			r_MmaAccumulatorHalf2WordAtPtx2541R1286); // PTX L2555
	MmaHalf(r_PackedHalf2AtPtx2020R1913, r_PackedHalf2AtPtx2027R1912, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx2548R1287,
			r_MmaAccumulatorHalf2WordAtPtx2548R1288); // PTX L2562
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2569R1289, r_MmaAccumulatorHalf2WordAtPtx2569R1290,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx2034R1911, r_PackedHalf2AtPtx2041R1972); // PTX L2569
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2576R1291, r_MmaAccumulatorHalf2WordAtPtx2576R1292,
			r_MmaAHalf2WordAtPtx2137R1269, r_MmaAHalf2WordAtPtx2137R1270, r_MmaAHalf2WordAtPtx2137R1271,
			r_MmaAHalf2WordAtPtx2137R1272, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx2048R1973, r_PackedHalf2AtPtx2055R1974); // PTX L2576
	MmaHalf(r_PackedHalf2AtPtx2034R1911, r_PackedHalf2AtPtx2041R1972, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx2569R1289,
			r_MmaAccumulatorHalf2WordAtPtx2569R1290); // PTX L2583
	MmaHalf(r_PackedHalf2AtPtx2048R1973, r_PackedHalf2AtPtx2055R1974, r_MmaAHalf2WordAtPtx2146R1273,
			r_MmaAHalf2WordAtPtx2146R1274, r_MmaAHalf2WordAtPtx2146R1275, r_MmaAHalf2WordAtPtx2146R1276,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx2576R1291,
			r_MmaAccumulatorHalf2WordAtPtx2576R1292);							 // PTX L2590
	r_PtxRegister37 = r_PtxRegister1297 ^ 4096;									 // PTX L2596
	r_PtxRegister38 = uint32_t(r_PtxRegister35) + uint32_t(r_PtxRegister33);	 // PTX L2597
	r_bPtxPredicate59 = r_bPtxPredicate1 & r_bPtxPredicate56;					 // PTX L2598
	r_bPtxPredicate60 = r_bPtxPredicate58 | r_bPtxPredicate55;					 // PTX L2599
	r_bPtxPredicate61 = r_bPtxPredicate59 | r_bPtxPredicate57;					 // PTX L2600
	r_PtxRegister1315 = r_bPtxPredicate59 ? r_PtxRegister1293 : 0;				 // PTX L2601
	r_PtxRegister39 = r_bPtxPredicate57 ? r_PtxRegister1315 : r_PtxRegister1293; // PTX L2602
	r_bPtxPredicate62 = r_bPtxPredicate61 | r_bPtxPredicate54;					 // PTX L2603
	r_bPtxPredicate12 = r_bPtxPredicate62 & r_bPtxPredicate60;					 // PTX L2604
	r_PtxU64Register327 = uint64_t(0);											 // PTX L2605
	r_bPtxPredicate63 = !r_bPtxPredicate12;										 // PTX L2606
	if (r_bPtxPredicate63)
	{
		goto L__BB38_57;
	} // PTX L2607
	r_bPtxPredicate64 = uint32_t(r_PtxRegister18) == uint32_t(4); // PTX L2608
	r_PtxRegister1316 =
		uint32_t(r_PtxRegister314) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister39); // PTX L2609
	r_PtxRegister1317 = r_bPtxPredicate64 ? r_PtxRegister39 : r_PtxRegister1316;		   // PTX L2610
	r_PtxRegister1318 = ShiftRight(uint32_t(r_PtxRegister38), uint32_t(4));				   // PTX L2611
	r_PtxRegister1319 = uint32_t(r_PtxRegister1318) + uint32_t(r_PtxRegister34);		   // PTX L2612
	r_PtxRegister1320 = ShiftLeft(uint32_t(r_PtxRegister1317), uint32_t(12));			   // PTX L2613
	r_PtxRegister1321 = ShiftLeft(uint32_t(r_PtxRegister1319), uint32_t(7));			   // PTX L2614
	r_PtxRegister1322 = uint32_t(r_PtxRegister1320) + uint32_t(r_PtxRegister1321);		   // PTX L2615
	r_PtxU64Register327 = SignExtendWordBits(r_PtxRegister1322);						   // PTX L2616
L__BB38_57:																				   // PTX L2617
	r_PtxRegister1323 = ShiftLeft(uint32_t(r_PtxRegister34), uint32_t(9));				   // PTX L2618
	r_PtxRegister1324 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));					   // PTX L2619
	r_PtxRegister1325 = r_PtxRegister1324 & 523264;										   // PTX L2620
	r_PtxRegister1326 = r_PtxRegister1323 | r_PtxRegister1325;							   // PTX L2621
	r_PtxRegister1327 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L2622
	r_PtxRegister40 = uint32_t(r_PtxRegister1327) + uint32_t(r_PtxRegister1326);		   // PTX L2623
	r_PtxRegister1328 = ShiftLeft(uint32_t(r_PtxRegister36), uint32_t(3));				   // PTX L2624
	r_PtxRegister1329 = uint32_t(8192u /* exact native shared-region offset */);		   // PTX L2625
	r_PtxRegister1360 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1328);		   // PTX L2626
	if (r_bPtxPredicate63)
	{
		goto L__BB38_60;
	} // PTX L2627
	r_PtxRegister1335 = uint32_t(-1);								// PTX L2628
	r_PtxRegister1334 = Elected(r_PtxRegister1335);					// PTX L2630
	r_bPtxPredicate65 = uint32_t(r_PtxRegister1334) == uint32_t(0); // PTX L2636
	if (r_bPtxPredicate65)
	{
		goto L__BB38_61;
	} // PTX L2637
	r_PtxRegister1336 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister37);		   // PTX L2638
	r_PtxU64Register235 = ShiftLeft(uint64_t(r_PtxU64Register327), uint32_t(2));	   // PTX L2639
	r_PtxU64Register234 = uint64_t(r_PtxU64Register2) + uint64_t(r_PtxU64Register235); // PTX L2640
	r_PtxRegister1337 = uint32_t(512);												   // PTX L2641
	CopyBulk(s_SharedStorage, r_PtxRegister1336, r_PtxU64Register234, r_PtxRegister1337,
			 r_PtxRegister1360);												   // PTX L2643
	BarrierExpect(s_SharedStorage, r_PtxRegister1360, r_PtxRegister1337);		   // PTX L2646
	goto L__BB38_61;															   // PTX L2648
L__BB38_60:																		   // PTX L2649
	r_LaneIndexAtPtx2651 = uint32_t((threadIdx.x & 31u));						   // PTX L2651
	r_PtxRegister1332 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister37);	   // PTX L2653
	r_PtxRegister1333 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2651), uint32_t(4));	   // PTX L2654
	r_PtxRegister1331 = uint32_t(r_PtxRegister1332) + uint32_t(r_PtxRegister1333); // PTX L2655
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1331)) =
		make_uint4(r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346,
				   r_PackedHalf2AtPtx63R346);									 // PTX L2657
L__BB38_61:																		 // PTX L2659
	r_bPtxPredicate66 = int32_t(r_PtxRegister334) < int32_t(r_PtxRegister6);	 // PTX L2660
	r_bPtxPredicate67 = int32_t(r_PtxRegister334) >= int32_t(r_PtxRegister6);	 // PTX L2661
	r_bPtxPredicate68 = int32_t(r_PtxRegister1293) < int32_t(r_PtxRegister7);	 // PTX L2662
	r_bPtxPredicate69 = uint32_t(r_PtxRegister24) == uint32_t(4);				 // PTX L2663
	r_bPtxPredicate70 = uint32_t(r_PtxRegister18) == uint32_t(4);				 // PTX L2664
	r_bPtxPredicate71 = r_bPtxPredicate1 & r_bPtxPredicate67;					 // PTX L2665
	r_bPtxPredicate72 = r_bPtxPredicate70 | r_bPtxPredicate66;					 // PTX L2666
	r_bPtxPredicate73 = r_bPtxPredicate71 | r_bPtxPredicate69;					 // PTX L2667
	r_PtxRegister1338 = r_bPtxPredicate71 ? r_PtxRegister1293 : 0;				 // PTX L2668
	r_PtxRegister41 = r_bPtxPredicate69 ? r_PtxRegister1338 : r_PtxRegister1293; // PTX L2669
	r_bPtxPredicate74 = r_bPtxPredicate73 | r_bPtxPredicate68;					 // PTX L2670
	r_bPtxPredicate13 = r_bPtxPredicate74 & r_bPtxPredicate72;					 // PTX L2671
	r_PtxU64Register328 = uint64_t(0);											 // PTX L2672
	r_bPtxPredicate75 = !r_bPtxPredicate13;										 // PTX L2673
	if (r_bPtxPredicate75)
	{
		goto L__BB38_63;
	} // PTX L2674
	r_bPtxPredicate76 = uint32_t(r_PtxRegister18) == uint32_t(4); // PTX L2675
	r_PtxRegister1339 =
		uint32_t(r_PtxRegister334) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister41); // PTX L2676
	r_PtxRegister1340 = r_bPtxPredicate76 ? r_PtxRegister41 : r_PtxRegister1339;		   // PTX L2677
	r_PtxRegister1341 = ShiftRight(uint32_t(r_PtxRegister38), uint32_t(4));				   // PTX L2678
	r_PtxRegister1342 = uint32_t(r_PtxRegister1341) + uint32_t(r_PtxRegister34);		   // PTX L2679
	r_PtxRegister1343 = ShiftLeft(uint32_t(r_PtxRegister1340), uint32_t(12));			   // PTX L2680
	r_PtxRegister1344 = ShiftLeft(uint32_t(r_PtxRegister1342), uint32_t(7));			   // PTX L2681
	r_PtxRegister1345 = uint32_t(r_PtxRegister1343) + uint32_t(r_PtxRegister1344);		   // PTX L2682
	r_PtxU64Register328 = SignExtendWordBits(r_PtxRegister1345);						   // PTX L2683
L__BB38_63:																				   // PTX L2684
	r_PtxRegister1346 = r_PtxRegister1324 & 1024;										   // PTX L2685
	r_PtxRegister1347 = uint32_t(r_PtxRegister1324) + uint32_t(2048);					   // PTX L2686
	r_PtxRegister1348 = r_PtxRegister1347 & 1046528;									   // PTX L2687
	r_PtxRegister1349 = r_PtxRegister1348 | r_PtxRegister1346;							   // PTX L2688
	r_PtxRegister1350 = r_PtxRegister1323 | r_PtxRegister1349;							   // PTX L2689
	r_PtxRegister1351 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L2690
	r_PtxRegister42 = uint32_t(r_PtxRegister1351) + uint32_t(r_PtxRegister1350);		   // PTX L2691
	if (r_bPtxPredicate75)
	{
		goto L__BB38_66;
	} // PTX L2692
	r_PtxRegister1357 = uint32_t(-1);								// PTX L2693
	r_PtxRegister1356 = Elected(r_PtxRegister1357);					// PTX L2695
	r_bPtxPredicate77 = uint32_t(r_PtxRegister1356) == uint32_t(0); // PTX L2701
	if (r_bPtxPredicate77)
	{
		goto L__BB38_67;
	} // PTX L2702
	r_PtxRegister1358 = uint32_t(r_PtxRegister42) + uint32_t(r_PtxRegister37);		   // PTX L2703
	r_PtxU64Register237 = ShiftLeft(uint64_t(r_PtxU64Register328), uint32_t(2));	   // PTX L2704
	r_PtxU64Register236 = uint64_t(r_PtxU64Register2) + uint64_t(r_PtxU64Register237); // PTX L2705
	r_PtxRegister1359 = uint32_t(512);												   // PTX L2706
	CopyBulk(s_SharedStorage, r_PtxRegister1358, r_PtxU64Register236, r_PtxRegister1359,
			 r_PtxRegister1360);												   // PTX L2708
	BarrierExpect(s_SharedStorage, r_PtxRegister1360, r_PtxRegister1359);		   // PTX L2711
	goto L__BB38_67;															   // PTX L2713
L__BB38_66:																		   // PTX L2714
	r_LaneIndexAtPtx2716 = uint32_t((threadIdx.x & 31u));						   // PTX L2716
	r_PtxRegister1354 = uint32_t(r_PtxRegister42) + uint32_t(r_PtxRegister37);	   // PTX L2718
	r_PtxRegister1355 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2716), uint32_t(4));	   // PTX L2719
	r_PtxRegister1353 = uint32_t(r_PtxRegister1354) + uint32_t(r_PtxRegister1355); // PTX L2720
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1353)) =
		make_uint4(r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346, r_PackedHalf2AtPtx63R346,
				   r_PackedHalf2AtPtx63R346);												   // PTX L2722
L__BB38_67:																					   // PTX L2724
	r_PtxRegister1370 = ShiftLeft(uint32_t(r_PtxRegister38), uint32_t(8));					   // PTX L2725
	r_PtxRegister1371 = uint32_t(r_PtxRegister1370) + uint32_t(r_PtxRegister10);			   // PTX L2726
	r_PtxU64Register246 = uint64_t(int64_t(int32_t(r_PtxRegister1371)) * int64_t(int32_t(4))); // PTX L2727
	r_PtxU64Register247 = uint64_t(r_Pointer32Bits) + uint64_t(r_PtxU64Register246);		   // PTX L2728
	r_LaneIndexAtPtx2730 = uint32_t((threadIdx.x & 31u));									   // PTX L2730
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2730)) * int64_t(int32_t(16)));		 // PTX L2732
	r_PtxU64Register238 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register248); // PTX L2733
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register238));
		r_MmaBHalf2WordAtPtx82R1976 = r_Value.x;
		r_MmaBHalf2WordAtPtx82R1977 = r_Value.y;
		r_MmaBHalf2WordAtPtx82R1978 = r_Value.z;
		r_MmaBHalf2WordAtPtx82R1979 = r_Value.w;
	} // PTX L2735
	r_LaneIndexAtPtx2738 = uint32_t((threadIdx.x & 31u)); // PTX L2738
	r_PtxU64Register249 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2738)) * int64_t(int32_t(16)));		 // PTX L2740
	r_PtxU64Register250 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register249); // PTX L2741
	r_PtxU64Register239 = uint64_t(r_PtxU64Register250) + uint64_t(512);				 // PTX L2742
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register239));
		r_MmaBHalf2WordAtPtx92R1980 = r_Value.x;
		r_MmaBHalf2WordAtPtx92R1981 = r_Value.y;
		r_MmaBHalf2WordAtPtx92R1982 = r_Value.z;
		r_MmaBHalf2WordAtPtx92R1983 = r_Value.w;
	} // PTX L2744
	r_LaneIndexAtPtx2747 = uint32_t((threadIdx.x & 31u)); // PTX L2747
	r_PtxU64Register251 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2747)) * int64_t(int32_t(16)));		 // PTX L2749
	r_PtxU64Register252 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register251); // PTX L2750
	r_PtxU64Register240 = uint64_t(r_PtxU64Register252) + uint64_t(1024);				 // PTX L2751
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register240));
		r_MmaBHalf2WordAtPtx102R1984 = r_Value.x;
		r_MmaBHalf2WordAtPtx102R1985 = r_Value.y;
		r_MmaBHalf2WordAtPtx102R1986 = r_Value.z;
		r_MmaBHalf2WordAtPtx102R1987 = r_Value.w;
	} // PTX L2753
	r_LaneIndexAtPtx2756 = uint32_t((threadIdx.x & 31u)); // PTX L2756
	r_PtxU64Register253 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2756)) * int64_t(int32_t(16)));		 // PTX L2758
	r_PtxU64Register254 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register253); // PTX L2759
	r_PtxU64Register241 = uint64_t(r_PtxU64Register254) + uint64_t(1536);				 // PTX L2760
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register241));
		r_MmaBHalf2WordAtPtx112R1988 = r_Value.x;
		r_MmaBHalf2WordAtPtx112R1989 = r_Value.y;
		r_MmaBHalf2WordAtPtx112R1990 = r_Value.z;
		r_MmaBHalf2WordAtPtx112R1991 = r_Value.w;
	} // PTX L2762
	r_LaneIndexAtPtx2765 = uint32_t((threadIdx.x & 31u)); // PTX L2765
	r_PtxU64Register255 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2765)) * int64_t(int32_t(16)));		 // PTX L2767
	r_PtxU64Register256 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register255); // PTX L2768
	r_PtxU64Register242 = uint64_t(r_PtxU64Register256) + uint64_t(16384);				 // PTX L2769
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register242));
		r_MmaBHalf2WordAtPtx121R1992 = r_Value.x;
		r_MmaBHalf2WordAtPtx121R1993 = r_Value.y;
		r_MmaBHalf2WordAtPtx121R1994 = r_Value.z;
		r_MmaBHalf2WordAtPtx121R1995 = r_Value.w;
	} // PTX L2771
	r_LaneIndexAtPtx2774 = uint32_t((threadIdx.x & 31u)); // PTX L2774
	r_PtxU64Register257 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2774)) * int64_t(int32_t(16)));		 // PTX L2776
	r_PtxU64Register258 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register257); // PTX L2777
	r_PtxU64Register243 = uint64_t(r_PtxU64Register258) + uint64_t(16896);				 // PTX L2778
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register243));
		r_MmaBHalf2WordAtPtx130R1996 = r_Value.x;
		r_MmaBHalf2WordAtPtx130R1997 = r_Value.y;
		r_MmaBHalf2WordAtPtx130R1998 = r_Value.z;
		r_MmaBHalf2WordAtPtx130R1999 = r_Value.w;
	} // PTX L2780
	r_LaneIndexAtPtx2783 = uint32_t((threadIdx.x & 31u)); // PTX L2783
	r_PtxU64Register259 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2783)) * int64_t(int32_t(16)));		 // PTX L2785
	r_PtxU64Register260 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register259); // PTX L2786
	r_PtxU64Register244 = uint64_t(r_PtxU64Register260) + uint64_t(17408);				 // PTX L2787
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register244));
		r_MmaBHalf2WordAtPtx139R2000 = r_Value.x;
		r_MmaBHalf2WordAtPtx139R2001 = r_Value.y;
		r_MmaBHalf2WordAtPtx139R2002 = r_Value.z;
		r_MmaBHalf2WordAtPtx139R2003 = r_Value.w;
	} // PTX L2789
	r_LaneIndexAtPtx2792 = uint32_t((threadIdx.x & 31u)); // PTX L2792
	r_PtxU64Register261 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2792)) * int64_t(int32_t(16)));		 // PTX L2794
	r_PtxU64Register262 = uint64_t(r_PtxU64Register247) + uint64_t(r_PtxU64Register261); // PTX L2795
	r_PtxU64Register245 = uint64_t(r_PtxU64Register262) + uint64_t(17920);				 // PTX L2796
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register245));
		r_MmaBHalf2WordAtPtx148R2004 = r_Value.x;
		r_MmaBHalf2WordAtPtx148R2005 = r_Value.y;
		r_MmaBHalf2WordAtPtx148R2006 = r_Value.z;
		r_MmaBHalf2WordAtPtx148R2007 = r_Value.w;
	} // PTX L2798
	r_PtxRegister1369 = uint32_t(1);															// PTX L2800
	r_PtxU64Register263 = BarrierArrive(s_SharedStorage, r_PtxRegister1360, r_PtxRegister1369); // PTX L2802
L__BB38_68:																						// PTX L2804
	r_PtxRegister1372 = BarrierReady(s_SharedStorage, r_PtxRegister1360, r_PtxU64Register263);	// PTX L2806
	r_bPtxPredicate78 = uint32_t(r_PtxRegister1372) == uint32_t(0);								// PTX L2812
	if (r_bPtxPredicate78)
	{
		goto L__BB38_68;
	} // PTX L2813
	r_bPtxPredicate79 = uint32_t(r_PtxRegister1975) < uint32_t(448); // PTX L2814
	r_PtxRegister1975 = uint32_t(r_PtxRegister35);					 // PTX L2815
	if (r_bPtxPredicate79)
	{
		goto L__BB38_55;
	} // PTX L2816
	r_bPtxPredicate80 = int32_t(r_PtxRegister5) >= int32_t(r_PtxRegister7);		   // PTX L2817
	r_LaneIndexAtPtx2819 = uint32_t((threadIdx.x & 31u));						   // PTX L2819
	r_PtxRegister1485 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2819), uint32_t(4));	   // PTX L2821
	r_PtxRegister1486 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L2822
	r_PtxRegister1487 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1485); // PTX L2823
	r_PtxRegister1374 = uint32_t(r_PtxRegister1487) + uint32_t(4096);			   // PTX L2824
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1374));
		r_MmaAHalf2WordAtPtx2826R1389 = r_Value.x;
		r_MmaAHalf2WordAtPtx2826R1390 = r_Value.y;
		r_MmaAHalf2WordAtPtx2826R1391 = r_Value.z;
		r_MmaAHalf2WordAtPtx2826R1392 = r_Value.w;
	} // PTX L2826
	r_LaneIndexAtPtx2829 = uint32_t((threadIdx.x & 31u));						   // PTX L2829
	r_PtxRegister1488 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2829), uint32_t(4));	   // PTX L2831
	r_PtxRegister1489 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1488); // PTX L2832
	r_PtxRegister1376 = uint32_t(r_PtxRegister1489) + uint32_t(4608);			   // PTX L2833
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1376));
		r_MmaAHalf2WordAtPtx2835R1393 = r_Value.x;
		r_MmaAHalf2WordAtPtx2835R1394 = r_Value.y;
		r_MmaAHalf2WordAtPtx2835R1395 = r_Value.z;
		r_MmaAHalf2WordAtPtx2835R1396 = r_Value.w;
	} // PTX L2835
	r_LaneIndexAtPtx2838 = uint32_t((threadIdx.x & 31u));						   // PTX L2838
	r_PtxRegister1490 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2838), uint32_t(4));	   // PTX L2840
	r_PtxRegister1491 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1490); // PTX L2841
	r_PtxRegister1378 = uint32_t(r_PtxRegister1491) + uint32_t(5120);			   // PTX L2842
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1378));
		r_MmaAHalf2WordAtPtx2844R1413 = r_Value.x;
		r_MmaAHalf2WordAtPtx2844R1414 = r_Value.y;
		r_MmaAHalf2WordAtPtx2844R1415 = r_Value.z;
		r_MmaAHalf2WordAtPtx2844R1416 = r_Value.w;
	} // PTX L2844
	r_LaneIndexAtPtx2847 = uint32_t((threadIdx.x & 31u));						   // PTX L2847
	r_PtxRegister1492 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2847), uint32_t(4));	   // PTX L2849
	r_PtxRegister1493 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1492); // PTX L2850
	r_PtxRegister1380 = uint32_t(r_PtxRegister1493) + uint32_t(5632);			   // PTX L2851
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1380));
		r_MmaAHalf2WordAtPtx2853R1417 = r_Value.x;
		r_MmaAHalf2WordAtPtx2853R1418 = r_Value.y;
		r_MmaAHalf2WordAtPtx2853R1419 = r_Value.z;
		r_MmaAHalf2WordAtPtx2853R1420 = r_Value.w;
	} // PTX L2853
	r_LaneIndexAtPtx2856 = uint32_t((threadIdx.x & 31u));						   // PTX L2856
	r_PtxRegister1494 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2856), uint32_t(4));	   // PTX L2858
	r_PtxRegister1495 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1494); // PTX L2859
	r_PtxRegister1382 = uint32_t(r_PtxRegister1495) + uint32_t(6144);			   // PTX L2860
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1382));
		r_MmaAHalf2WordAtPtx2862R1437 = r_Value.x;
		r_MmaAHalf2WordAtPtx2862R1438 = r_Value.y;
		r_MmaAHalf2WordAtPtx2862R1439 = r_Value.z;
		r_MmaAHalf2WordAtPtx2862R1440 = r_Value.w;
	} // PTX L2862
	r_LaneIndexAtPtx2865 = uint32_t((threadIdx.x & 31u));						   // PTX L2865
	r_PtxRegister1496 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2865), uint32_t(4));	   // PTX L2867
	r_PtxRegister1497 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1496); // PTX L2868
	r_PtxRegister1384 = uint32_t(r_PtxRegister1497) + uint32_t(6656);			   // PTX L2869
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1384));
		r_MmaAHalf2WordAtPtx2871R1441 = r_Value.x;
		r_MmaAHalf2WordAtPtx2871R1442 = r_Value.y;
		r_MmaAHalf2WordAtPtx2871R1443 = r_Value.z;
		r_MmaAHalf2WordAtPtx2871R1444 = r_Value.w;
	} // PTX L2871
	r_LaneIndexAtPtx2874 = uint32_t((threadIdx.x & 31u));						   // PTX L2874
	r_PtxRegister1498 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2874), uint32_t(4));	   // PTX L2876
	r_PtxRegister1499 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1498); // PTX L2877
	r_PtxRegister1386 = uint32_t(r_PtxRegister1499) + uint32_t(7168);			   // PTX L2878
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1386));
		r_MmaAHalf2WordAtPtx2880R1461 = r_Value.x;
		r_MmaAHalf2WordAtPtx2880R1462 = r_Value.y;
		r_MmaAHalf2WordAtPtx2880R1463 = r_Value.z;
		r_MmaAHalf2WordAtPtx2880R1464 = r_Value.w;
	} // PTX L2880
	r_LaneIndexAtPtx2883 = uint32_t((threadIdx.x & 31u));						   // PTX L2883
	r_PtxRegister1500 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2883), uint32_t(4));	   // PTX L2885
	r_PtxRegister1501 = uint32_t(r_PtxRegister1486) + uint32_t(r_PtxRegister1500); // PTX L2886
	r_PtxRegister1388 = uint32_t(r_PtxRegister1501) + uint32_t(7680);			   // PTX L2887
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1388));
		r_MmaAHalf2WordAtPtx2889R1465 = r_Value.x;
		r_MmaAHalf2WordAtPtx2889R1466 = r_Value.y;
		r_MmaAHalf2WordAtPtx2889R1467 = r_Value.z;
		r_MmaAHalf2WordAtPtx2889R1468 = r_Value.w;
	} // PTX L2889
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2892R1397, r_MmaAccumulatorHalf2WordAtPtx2892R1398,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1614R1971, r_PackedHalf2AtPtx1621R1970); // PTX L2892
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2899R1399, r_MmaAccumulatorHalf2WordAtPtx2899R1400,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1628R1969, r_PackedHalf2AtPtx1635R1968); // PTX L2899
	MmaHalf(r_PtxRegister1506, r_PtxRegister1507, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx2892R1397,
			r_MmaAccumulatorHalf2WordAtPtx2892R1398); // PTX L2906
	MmaHalf(r_PtxRegister1508, r_PtxRegister1509, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx2899R1399,
			r_MmaAccumulatorHalf2WordAtPtx2899R1400); // PTX L2913
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2920R1401, r_MmaAccumulatorHalf2WordAtPtx2920R1402,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1642R1967, r_PackedHalf2AtPtx1649R1966); // PTX L2920
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2927R1403, r_MmaAccumulatorHalf2WordAtPtx2927R1404,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1656R1965, r_PackedHalf2AtPtx1663R1964); // PTX L2927
	MmaHalf(r_PtxRegister1511, r_PtxRegister1512, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx2920R1401,
			r_MmaAccumulatorHalf2WordAtPtx2920R1402); // PTX L2934
	MmaHalf(r_PtxRegister1513, r_PtxRegister1514, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx2927R1403,
			r_MmaAccumulatorHalf2WordAtPtx2927R1404); // PTX L2941
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2948R1405, r_MmaAccumulatorHalf2WordAtPtx2948R1406,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1670R1963, r_PackedHalf2AtPtx1677R1962); // PTX L2948
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2955R1407, r_MmaAccumulatorHalf2WordAtPtx2955R1408,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1684R1961, r_PackedHalf2AtPtx1691R1960); // PTX L2955
	MmaHalf(r_PtxRegister1516, r_PtxRegister1517, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx2948R1405,
			r_MmaAccumulatorHalf2WordAtPtx2948R1406); // PTX L2962
	MmaHalf(r_PtxRegister1518, r_PtxRegister1519, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx2955R1407,
			r_MmaAccumulatorHalf2WordAtPtx2955R1408); // PTX L2969
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2976R1409, r_MmaAccumulatorHalf2WordAtPtx2976R1410,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1698R1959, r_PackedHalf2AtPtx1705R1958); // PTX L2976
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2983R1411, r_MmaAccumulatorHalf2WordAtPtx2983R1412,
			r_MmaAHalf2WordAtPtx2826R1389, r_MmaAHalf2WordAtPtx2826R1390, r_MmaAHalf2WordAtPtx2826R1391,
			r_MmaAHalf2WordAtPtx2826R1392, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1712R1957, r_PackedHalf2AtPtx1719R1956); // PTX L2983
	MmaHalf(r_PtxRegister1521, r_PtxRegister1522, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx2976R1409,
			r_MmaAccumulatorHalf2WordAtPtx2976R1410); // PTX L2990
	MmaHalf(r_PtxRegister1523, r_PtxRegister1524, r_MmaAHalf2WordAtPtx2835R1393,
			r_MmaAHalf2WordAtPtx2835R1394, r_MmaAHalf2WordAtPtx2835R1395, r_MmaAHalf2WordAtPtx2835R1396,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx2983R1411,
			r_MmaAccumulatorHalf2WordAtPtx2983R1412); // PTX L2997
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3004R1421, r_MmaAccumulatorHalf2WordAtPtx3004R1422,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1726R1955, r_PackedHalf2AtPtx1733R1954); // PTX L3004
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3011R1423, r_MmaAccumulatorHalf2WordAtPtx3011R1424,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1740R1953, r_PackedHalf2AtPtx1747R1952); // PTX L3011
	MmaHalf(r_PtxRegister1526, r_PtxRegister1527, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx3004R1421,
			r_MmaAccumulatorHalf2WordAtPtx3004R1422); // PTX L3018
	MmaHalf(r_PtxRegister1528, r_PtxRegister1529, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx3011R1423,
			r_MmaAccumulatorHalf2WordAtPtx3011R1424); // PTX L3025
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3032R1425, r_MmaAccumulatorHalf2WordAtPtx3032R1426,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1754R1951, r_PackedHalf2AtPtx1761R1950); // PTX L3032
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3039R1427, r_MmaAccumulatorHalf2WordAtPtx3039R1428,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1768R1949, r_PackedHalf2AtPtx1775R1948); // PTX L3039
	MmaHalf(r_PtxRegister1531, r_PtxRegister1532, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx3032R1425,
			r_MmaAccumulatorHalf2WordAtPtx3032R1426); // PTX L3046
	MmaHalf(r_PtxRegister1533, r_PtxRegister1534, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx3039R1427,
			r_MmaAccumulatorHalf2WordAtPtx3039R1428); // PTX L3053
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3060R1429, r_MmaAccumulatorHalf2WordAtPtx3060R1430,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1782R1947, r_PackedHalf2AtPtx1789R1946); // PTX L3060
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3067R1431, r_MmaAccumulatorHalf2WordAtPtx3067R1432,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1796R1945, r_PackedHalf2AtPtx1803R1944); // PTX L3067
	MmaHalf(r_PtxRegister1536, r_PtxRegister1537, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx3060R1429,
			r_MmaAccumulatorHalf2WordAtPtx3060R1430); // PTX L3074
	MmaHalf(r_PtxRegister1538, r_PtxRegister1539, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx3067R1431,
			r_MmaAccumulatorHalf2WordAtPtx3067R1432); // PTX L3081
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3088R1433, r_MmaAccumulatorHalf2WordAtPtx3088R1434,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1810R1943, r_PackedHalf2AtPtx1817R1942); // PTX L3088
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3095R1435, r_MmaAccumulatorHalf2WordAtPtx3095R1436,
			r_MmaAHalf2WordAtPtx2844R1413, r_MmaAHalf2WordAtPtx2844R1414, r_MmaAHalf2WordAtPtx2844R1415,
			r_MmaAHalf2WordAtPtx2844R1416, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1824R1941, r_PackedHalf2AtPtx1831R1940); // PTX L3095
	MmaHalf(r_PtxRegister1541, r_PtxRegister1542, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx3088R1433,
			r_MmaAccumulatorHalf2WordAtPtx3088R1434); // PTX L3102
	MmaHalf(r_PtxRegister1543, r_PtxRegister1544, r_MmaAHalf2WordAtPtx2853R1417,
			r_MmaAHalf2WordAtPtx2853R1418, r_MmaAHalf2WordAtPtx2853R1419, r_MmaAHalf2WordAtPtx2853R1420,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx3095R1435,
			r_MmaAccumulatorHalf2WordAtPtx3095R1436); // PTX L3109
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3116R1445, r_MmaAccumulatorHalf2WordAtPtx3116R1446,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1838R1939, r_PackedHalf2AtPtx1845R1938); // PTX L3116
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3123R1447, r_MmaAccumulatorHalf2WordAtPtx3123R1448,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1852R1937, r_PackedHalf2AtPtx1859R1936); // PTX L3123
	MmaHalf(r_PtxRegister1550, r_PtxRegister1551, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx3116R1445,
			r_MmaAccumulatorHalf2WordAtPtx3116R1446); // PTX L3130
	MmaHalf(r_PtxRegister1552, r_PtxRegister1553, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx3123R1447,
			r_MmaAccumulatorHalf2WordAtPtx3123R1448); // PTX L3137
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3144R1449, r_MmaAccumulatorHalf2WordAtPtx3144R1450,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1866R1935, r_PackedHalf2AtPtx1873R1934); // PTX L3144
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3151R1451, r_MmaAccumulatorHalf2WordAtPtx3151R1452,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1880R1933, r_PackedHalf2AtPtx1887R1932); // PTX L3151
	MmaHalf(r_PtxRegister1555, r_PtxRegister1556, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx3144R1449,
			r_MmaAccumulatorHalf2WordAtPtx3144R1450); // PTX L3158
	MmaHalf(r_PtxRegister1557, r_PtxRegister1558, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx3151R1451,
			r_MmaAccumulatorHalf2WordAtPtx3151R1452); // PTX L3165
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3172R1453, r_MmaAccumulatorHalf2WordAtPtx3172R1454,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx1894R1931, r_PackedHalf2AtPtx1901R1930); // PTX L3172
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3179R1455, r_MmaAccumulatorHalf2WordAtPtx3179R1456,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx1908R1929, r_PackedHalf2AtPtx1915R1928); // PTX L3179
	MmaHalf(r_PtxRegister1560, r_PtxRegister1561, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx3172R1453,
			r_MmaAccumulatorHalf2WordAtPtx3172R1454); // PTX L3186
	MmaHalf(r_PtxRegister1562, r_PtxRegister1563, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx3179R1455,
			r_MmaAccumulatorHalf2WordAtPtx3179R1456); // PTX L3193
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3200R1457, r_MmaAccumulatorHalf2WordAtPtx3200R1458,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx1922R1927, r_PackedHalf2AtPtx1929R1926); // PTX L3200
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3207R1459, r_MmaAccumulatorHalf2WordAtPtx3207R1460,
			r_MmaAHalf2WordAtPtx2862R1437, r_MmaAHalf2WordAtPtx2862R1438, r_MmaAHalf2WordAtPtx2862R1439,
			r_MmaAHalf2WordAtPtx2862R1440, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx1936R1925, r_PackedHalf2AtPtx1943R1924); // PTX L3207
	MmaHalf(r_PtxRegister1565, r_PtxRegister1566, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx3200R1457,
			r_MmaAccumulatorHalf2WordAtPtx3200R1458); // PTX L3214
	MmaHalf(r_PtxRegister1567, r_PtxRegister1568, r_MmaAHalf2WordAtPtx2871R1441,
			r_MmaAHalf2WordAtPtx2871R1442, r_MmaAHalf2WordAtPtx2871R1443, r_MmaAHalf2WordAtPtx2871R1444,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx3207R1459,
			r_MmaAccumulatorHalf2WordAtPtx3207R1460); // PTX L3221
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3228R1469, r_MmaAccumulatorHalf2WordAtPtx3228R1470,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx82R1976, r_MmaBHalf2WordAtPtx82R1977,
			r_PackedHalf2AtPtx1950R1923, r_PackedHalf2AtPtx1957R1922); // PTX L3228
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3235R1471, r_MmaAccumulatorHalf2WordAtPtx3235R1472,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx82R1978, r_MmaBHalf2WordAtPtx82R1979,
			r_PackedHalf2AtPtx1964R1921, r_PackedHalf2AtPtx1971R1920); // PTX L3235
	MmaHalf(r_PtxRegister1570, r_PtxRegister1571, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx121R1992, r_MmaBHalf2WordAtPtx121R1993,
			r_MmaAccumulatorHalf2WordAtPtx3228R1469,
			r_MmaAccumulatorHalf2WordAtPtx3228R1470); // PTX L3242
	MmaHalf(r_PtxRegister1572, r_PtxRegister1573, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx121R1994, r_MmaBHalf2WordAtPtx121R1995,
			r_MmaAccumulatorHalf2WordAtPtx3235R1471,
			r_MmaAccumulatorHalf2WordAtPtx3235R1472); // PTX L3249
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3256R1473, r_MmaAccumulatorHalf2WordAtPtx3256R1474,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx92R1980, r_MmaBHalf2WordAtPtx92R1981,
			r_PackedHalf2AtPtx1978R1919, r_PackedHalf2AtPtx1985R1918); // PTX L3256
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3263R1475, r_MmaAccumulatorHalf2WordAtPtx3263R1476,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx92R1982, r_MmaBHalf2WordAtPtx92R1983,
			r_PackedHalf2AtPtx1992R1917, r_PackedHalf2AtPtx1999R1916); // PTX L3263
	MmaHalf(r_PtxRegister1575, r_PtxRegister1576, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx130R1996, r_MmaBHalf2WordAtPtx130R1997,
			r_MmaAccumulatorHalf2WordAtPtx3256R1473,
			r_MmaAccumulatorHalf2WordAtPtx3256R1474); // PTX L3270
	MmaHalf(r_PtxRegister1577, r_PtxRegister1578, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx130R1998, r_MmaBHalf2WordAtPtx130R1999,
			r_MmaAccumulatorHalf2WordAtPtx3263R1475,
			r_MmaAccumulatorHalf2WordAtPtx3263R1476); // PTX L3277
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3284R1477, r_MmaAccumulatorHalf2WordAtPtx3284R1478,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx102R1984, r_MmaBHalf2WordAtPtx102R1985,
			r_PackedHalf2AtPtx2006R1915, r_PackedHalf2AtPtx2013R1914); // PTX L3284
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3291R1479, r_MmaAccumulatorHalf2WordAtPtx3291R1480,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx102R1986, r_MmaBHalf2WordAtPtx102R1987,
			r_PackedHalf2AtPtx2020R1913, r_PackedHalf2AtPtx2027R1912); // PTX L3291
	MmaHalf(r_PtxRegister1580, r_PtxRegister1581, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx139R2000, r_MmaBHalf2WordAtPtx139R2001,
			r_MmaAccumulatorHalf2WordAtPtx3284R1477,
			r_MmaAccumulatorHalf2WordAtPtx3284R1478); // PTX L3298
	MmaHalf(r_PtxRegister1582, r_PtxRegister1583, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx139R2002, r_MmaBHalf2WordAtPtx139R2003,
			r_MmaAccumulatorHalf2WordAtPtx3291R1479,
			r_MmaAccumulatorHalf2WordAtPtx3291R1480); // PTX L3305
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3312R1481, r_MmaAccumulatorHalf2WordAtPtx3312R1482,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx112R1988, r_MmaBHalf2WordAtPtx112R1989,
			r_PackedHalf2AtPtx2034R1911, r_PackedHalf2AtPtx2041R1972); // PTX L3312
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3319R1483, r_MmaAccumulatorHalf2WordAtPtx3319R1484,
			r_MmaAHalf2WordAtPtx2880R1461, r_MmaAHalf2WordAtPtx2880R1462, r_MmaAHalf2WordAtPtx2880R1463,
			r_MmaAHalf2WordAtPtx2880R1464, r_MmaBHalf2WordAtPtx112R1990, r_MmaBHalf2WordAtPtx112R1991,
			r_PackedHalf2AtPtx2048R1973, r_PackedHalf2AtPtx2055R1974); // PTX L3319
	MmaHalf(r_PtxRegister1585, r_PtxRegister1586, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx148R2004, r_MmaBHalf2WordAtPtx148R2005,
			r_MmaAccumulatorHalf2WordAtPtx3312R1481,
			r_MmaAccumulatorHalf2WordAtPtx3312R1482); // PTX L3326
	MmaHalf(r_PtxRegister1587, r_PtxRegister1588, r_MmaAHalf2WordAtPtx2889R1465,
			r_MmaAHalf2WordAtPtx2889R1466, r_MmaAHalf2WordAtPtx2889R1467, r_MmaAHalf2WordAtPtx2889R1468,
			r_MmaBHalf2WordAtPtx148R2006, r_MmaBHalf2WordAtPtx148R2007,
			r_MmaAccumulatorHalf2WordAtPtx3319R1483,
			r_MmaAccumulatorHalf2WordAtPtx3319R1484);						// PTX L3333
	r_bPtxPredicate81 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6); // PTX L3339
	r_PtxRegister1502 =
		uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister5);		   // PTX L3340
	r_PtxRegister1503 = ShiftLeft(uint32_t(r_PtxRegister1502), uint32_t(12));				   // PTX L3341
	r_PtxRegister1504 = uint32_t(r_PtxRegister1503) + uint32_t(r_PtxRegister10);			   // PTX L3342
	r_PtxU64Register264 = uint64_t(int64_t(int32_t(r_PtxRegister1504)) * int64_t(int32_t(4))); // PTX L3343
	r_PtxU64Register3 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register264);			   // PTX L3344
	r_bPtxPredicate82 = r_bPtxPredicate81 | r_bPtxPredicate80;								   // PTX L3345
	if (r_bPtxPredicate82)
	{
		goto L__BB38_72;
	} // PTX L3346
	r_LaneIndexAtPtx3348 = uint32_t((threadIdx.x & 31u)); // PTX L3348
	r_PtxU64Register269 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3348)) * int64_t(int32_t(16)));	   // PTX L3350
	r_PtxU64Register265 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register269); // PTX L3351
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(r_PtxU64Register265, make_uint4(r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508,
													r_PtxRegister1509)); // PTX L3353
	r_LaneIndexAtPtx3356 = uint32_t((threadIdx.x & 31u));				 // PTX L3356
	r_PtxU64Register270 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3356)) * int64_t(int32_t(16)));	   // PTX L3358
	r_PtxU64Register271 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register270); // PTX L3359
	r_PtxU64Register266 = uint64_t(r_PtxU64Register271) + uint64_t(512);			   // PTX L3360
	StoreNoAllocate(r_PtxU64Register266, make_uint4(r_PtxRegister1511, r_PtxRegister1512, r_PtxRegister1513,
													r_PtxRegister1514)); // PTX L3362
	r_LaneIndexAtPtx3365 = uint32_t((threadIdx.x & 31u));				 // PTX L3365
	r_PtxU64Register272 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3365)) * int64_t(int32_t(16)));	   // PTX L3367
	r_PtxU64Register273 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register272); // PTX L3368
	r_PtxU64Register267 = uint64_t(r_PtxU64Register273) + uint64_t(1024);			   // PTX L3369
	StoreNoAllocate(r_PtxU64Register267, make_uint4(r_PtxRegister1516, r_PtxRegister1517, r_PtxRegister1518,
													r_PtxRegister1519)); // PTX L3371
	r_LaneIndexAtPtx3374 = uint32_t((threadIdx.x & 31u));				 // PTX L3374
	r_PtxU64Register274 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3374)) * int64_t(int32_t(16)));	   // PTX L3376
	r_PtxU64Register275 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register274); // PTX L3377
	r_PtxU64Register268 = uint64_t(r_PtxU64Register275) + uint64_t(1536);			   // PTX L3378
	StoreNoAllocate(r_PtxU64Register268, make_uint4(r_PtxRegister1521, r_PtxRegister1522, r_PtxRegister1523,
													r_PtxRegister1524));	 // PTX L3380
L__BB38_72:																	 // PTX L3382
	r_bPtxPredicate83 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6);	 // PTX L3383
	r_PtxRegister43 = r_PtxRegister5 | 1;									 // PTX L3384
	r_bPtxPredicate84 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister7); // PTX L3385
	r_bPtxPredicate85 = r_bPtxPredicate83 | r_bPtxPredicate84;				 // PTX L3386
	if (r_bPtxPredicate85)
	{
		goto L__BB38_74;
	} // PTX L3387
	r_LaneIndexAtPtx3389 = uint32_t((threadIdx.x & 31u)); // PTX L3389
	r_PtxU64Register280 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3389)) * int64_t(int32_t(16)));	   // PTX L3391
	r_PtxU64Register281 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register280); // PTX L3392
	r_PtxU64Register276 = uint64_t(r_PtxU64Register281) + uint64_t(16384);			   // PTX L3393
	StoreNoAllocate(r_PtxU64Register276, make_uint4(r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528,
													r_PtxRegister1529)); // PTX L3395
	r_LaneIndexAtPtx3398 = uint32_t((threadIdx.x & 31u));				 // PTX L3398
	r_PtxU64Register282 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3398)) * int64_t(int32_t(16)));	   // PTX L3400
	r_PtxU64Register283 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register282); // PTX L3401
	r_PtxU64Register277 = uint64_t(r_PtxU64Register283) + uint64_t(16896);			   // PTX L3402
	StoreNoAllocate(r_PtxU64Register277, make_uint4(r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533,
													r_PtxRegister1534)); // PTX L3404
	r_LaneIndexAtPtx3407 = uint32_t((threadIdx.x & 31u));				 // PTX L3407
	r_PtxU64Register284 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3407)) * int64_t(int32_t(16)));	   // PTX L3409
	r_PtxU64Register285 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register284); // PTX L3410
	r_PtxU64Register278 = uint64_t(r_PtxU64Register285) + uint64_t(17408);			   // PTX L3411
	StoreNoAllocate(r_PtxU64Register278, make_uint4(r_PtxRegister1536, r_PtxRegister1537, r_PtxRegister1538,
													r_PtxRegister1539)); // PTX L3413
	r_LaneIndexAtPtx3416 = uint32_t((threadIdx.x & 31u));				 // PTX L3416
	r_PtxU64Register286 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3416)) * int64_t(int32_t(16)));	   // PTX L3418
	r_PtxU64Register287 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register286); // PTX L3419
	r_PtxU64Register279 = uint64_t(r_PtxU64Register287) + uint64_t(17920);			   // PTX L3420
	StoreNoAllocate(r_PtxU64Register279, make_uint4(r_PtxRegister1541, r_PtxRegister1542, r_PtxRegister1543,
													r_PtxRegister1544));	 // PTX L3422
L__BB38_74:																	 // PTX L3424
	r_bPtxPredicate86 = int32_t(r_PtxRegister5) >= int32_t(r_PtxRegister7);	 // PTX L3425
	r_PtxRegister44 = r_PtxRegister4 | 1;									 // PTX L3426
	r_bPtxPredicate87 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister6); // PTX L3427
	r_PtxRegister1545 =
		uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister7);		   // PTX L3428
	r_PtxRegister1546 = uint32_t(r_PtxRegister1545) + uint32_t(r_PtxRegister5);				   // PTX L3429
	r_PtxRegister1547 = ShiftLeft(uint32_t(r_PtxRegister1546), uint32_t(12));				   // PTX L3430
	r_PtxRegister1548 = uint32_t(r_PtxRegister1547) + uint32_t(r_PtxRegister10);			   // PTX L3431
	r_PtxU64Register288 = uint64_t(int64_t(int32_t(r_PtxRegister1548)) * int64_t(int32_t(4))); // PTX L3432
	r_PtxU64Register4 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register288);			   // PTX L3433
	r_bPtxPredicate88 = r_bPtxPredicate87 | r_bPtxPredicate86;								   // PTX L3434
	if (r_bPtxPredicate88)
	{
		goto L__BB38_76;
	} // PTX L3435
	r_LaneIndexAtPtx3437 = uint32_t((threadIdx.x & 31u)); // PTX L3437
	r_PtxU64Register293 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3437)) * int64_t(int32_t(16)));	   // PTX L3439
	r_PtxU64Register289 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register293); // PTX L3440
	StoreNoAllocate(r_PtxU64Register289, make_uint4(r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552,
													r_PtxRegister1553)); // PTX L3442
	r_LaneIndexAtPtx3445 = uint32_t((threadIdx.x & 31u));				 // PTX L3445
	r_PtxU64Register294 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3445)) * int64_t(int32_t(16)));	   // PTX L3447
	r_PtxU64Register295 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register294); // PTX L3448
	r_PtxU64Register290 = uint64_t(r_PtxU64Register295) + uint64_t(512);			   // PTX L3449
	StoreNoAllocate(r_PtxU64Register290, make_uint4(r_PtxRegister1555, r_PtxRegister1556, r_PtxRegister1557,
													r_PtxRegister1558)); // PTX L3451
	r_LaneIndexAtPtx3454 = uint32_t((threadIdx.x & 31u));				 // PTX L3454
	r_PtxU64Register296 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3454)) * int64_t(int32_t(16)));	   // PTX L3456
	r_PtxU64Register297 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register296); // PTX L3457
	r_PtxU64Register291 = uint64_t(r_PtxU64Register297) + uint64_t(1024);			   // PTX L3458
	StoreNoAllocate(r_PtxU64Register291, make_uint4(r_PtxRegister1560, r_PtxRegister1561, r_PtxRegister1562,
													r_PtxRegister1563)); // PTX L3460
	r_LaneIndexAtPtx3463 = uint32_t((threadIdx.x & 31u));				 // PTX L3463
	r_PtxU64Register298 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3463)) * int64_t(int32_t(16)));	   // PTX L3465
	r_PtxU64Register299 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register298); // PTX L3466
	r_PtxU64Register292 = uint64_t(r_PtxU64Register299) + uint64_t(1536);			   // PTX L3467
	StoreNoAllocate(r_PtxU64Register292, make_uint4(r_PtxRegister1565, r_PtxRegister1566, r_PtxRegister1567,
													r_PtxRegister1568));	 // PTX L3469
L__BB38_76:																	 // PTX L3471
	r_bPtxPredicate89 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister6); // PTX L3472
	r_bPtxPredicate90 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister7); // PTX L3473
	r_bPtxPredicate91 = r_bPtxPredicate89 | r_bPtxPredicate90;				 // PTX L3474
	if (r_bPtxPredicate91)
	{
		goto L__BB38_78;
	} // PTX L3475
	r_LaneIndexAtPtx3477 = uint32_t((threadIdx.x & 31u)); // PTX L3477
	r_PtxU64Register304 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3477)) * int64_t(int32_t(16)));	   // PTX L3479
	r_PtxU64Register305 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register304); // PTX L3480
	r_PtxU64Register300 = uint64_t(r_PtxU64Register305) + uint64_t(16384);			   // PTX L3481
	StoreNoAllocate(r_PtxU64Register300, make_uint4(r_PtxRegister1570, r_PtxRegister1571, r_PtxRegister1572,
													r_PtxRegister1573)); // PTX L3483
	r_LaneIndexAtPtx3486 = uint32_t((threadIdx.x & 31u));				 // PTX L3486
	r_PtxU64Register306 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3486)) * int64_t(int32_t(16)));	   // PTX L3488
	r_PtxU64Register307 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register306); // PTX L3489
	r_PtxU64Register301 = uint64_t(r_PtxU64Register307) + uint64_t(16896);			   // PTX L3490
	StoreNoAllocate(r_PtxU64Register301, make_uint4(r_PtxRegister1575, r_PtxRegister1576, r_PtxRegister1577,
													r_PtxRegister1578)); // PTX L3492
	r_LaneIndexAtPtx3495 = uint32_t((threadIdx.x & 31u));				 // PTX L3495
	r_PtxU64Register308 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3495)) * int64_t(int32_t(16)));	   // PTX L3497
	r_PtxU64Register309 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register308); // PTX L3498
	r_PtxU64Register302 = uint64_t(r_PtxU64Register309) + uint64_t(17408);			   // PTX L3499
	StoreNoAllocate(r_PtxU64Register302, make_uint4(r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
													r_PtxRegister1583)); // PTX L3501
	r_LaneIndexAtPtx3504 = uint32_t((threadIdx.x & 31u));				 // PTX L3504
	r_PtxU64Register310 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3504)) * int64_t(int32_t(16)));	   // PTX L3506
	r_PtxU64Register311 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register310); // PTX L3507
	r_PtxU64Register303 = uint64_t(r_PtxU64Register311) + uint64_t(17920);			   // PTX L3508
	StoreNoAllocate(r_PtxU64Register303, make_uint4(r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587,
													r_PtxRegister1588));		 // PTX L3510
L__BB38_78:																		 // PTX L3512
	r_PtxRegister1590 = ShiftRightSigned(int32_t(r_Scalar76Bits), uint32_t(31)); // PTX L3513
	r_PtxRegister1591 = ShiftRight(uint32_t(r_PtxRegister1590), uint32_t(30));	 // PTX L3514
	r_PtxRegister1592 = uint32_t(r_Scalar76Bits) + uint32_t(r_PtxRegister1591);	 // PTX L3515
	r_PtxRegister45 = ShiftRightSigned(int32_t(r_PtxRegister1592), uint32_t(2)); // PTX L3516
	r_LaneIndexAtPtx3518 = uint32_t((threadIdx.x & 31u));						 // PTX L3518
	r_PtxRegister1593 = ShiftRight(uint32_t(r_LaneIndexAtPtx3518), uint32_t(2)); // PTX L3520
	r_PtxRegister1594 = r_PtxRegister1593 & 2;									 // PTX L3521
	r_PtxRegister1595 = ShiftRight(uint32_t(r_LaneIndexAtPtx3518), uint32_t(4)); // PTX L3522
	r_PtxRegister1596 = r_PtxRegister1595 & 1;									 // PTX L3523
	r_PtxRegister46 = r_PtxRegister1594 | r_PtxRegister1596;					 // PTX L3524
	r_PtxRegister1597 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3518), uint32_t(1));	 // PTX L3525
	r_PtxRegister1598 = r_PtxRegister1597 & 8;									 // PTX L3526
	r_PtxRegister1599 = r_LaneIndexAtPtx3518 & 3;								 // PTX L3527
	r_PtxRegister47 = r_PtxRegister1598 | r_PtxRegister1599;					 // PTX L3528
	r_PtxRegister2008 =
		ShuffleIdxPredicate(r_bPtxPredicate92, r_PtxRegister1506, r_PtxRegister47, 31, -1); // PTX L3529
	r_PtxRegister48 =
		ShuffleIdxPredicate(r_bPtxPredicate93, r_PtxRegister1507, r_PtxRegister47, 31, -1); // PTX L3530
	r_PtxRegister49 =
		ShuffleIdxPredicate(r_bPtxPredicate94, r_PtxRegister1526, r_PtxRegister47, 31, -1); // PTX L3531
	r_PtxRegister50 =
		ShuffleIdxPredicate(r_bPtxPredicate95, r_PtxRegister1527, r_PtxRegister47, 31, -1); // PTX L3532
	r_bPtxPredicate96 = uint32_t(r_PtxRegister46) == uint32_t(0);							// PTX L3533
	if (r_bPtxPredicate96)
	{
		goto L__BB38_81;
	} // PTX L3534
	r_bPtxPredicate97 = uint32_t(r_PtxRegister46) == uint32_t(1); // PTX L3535
	r_PtxRegister2008 = uint32_t(r_PtxRegister48);				  // PTX L3536
	if (r_bPtxPredicate97)
	{
		goto L__BB38_81;
	} // PTX L3537
	r_bPtxPredicate98 = uint32_t(r_PtxRegister46) == uint32_t(2);			   // PTX L3538
	r_PtxRegister2008 = r_bPtxPredicate98 ? r_PtxRegister49 : r_PtxRegister50; // PTX L3539
L__BB38_81:																	   // PTX L3540
	r_bPtxPredicate99 = uint32_t(r_PtxRegister46) == uint32_t(0);			   // PTX L3541
	r_PtxRegister1600 = r_PtxRegister47 | 4;								   // PTX L3542
	r_PtxRegister2009 =
		ShuffleIdxPredicate(r_bPtxPredicate100, r_PtxRegister1506, r_PtxRegister1600, 31, -1); // PTX L3543
	r_PtxRegister51 =
		ShuffleIdxPredicate(r_bPtxPredicate101, r_PtxRegister1507, r_PtxRegister1600, 31, -1); // PTX L3544
	r_PtxRegister52 =
		ShuffleIdxPredicate(r_bPtxPredicate102, r_PtxRegister1526, r_PtxRegister1600, 31, -1); // PTX L3545
	r_PtxRegister53 =
		ShuffleIdxPredicate(r_bPtxPredicate103, r_PtxRegister1527, r_PtxRegister1600, 31, -1); // PTX L3546
	if (r_bPtxPredicate99)
	{
		goto L__BB38_84;
	} // PTX L3547
	r_bPtxPredicate104 = uint32_t(r_PtxRegister46) == uint32_t(1); // PTX L3548
	r_PtxRegister2009 = uint32_t(r_PtxRegister51);				   // PTX L3549
	if (r_bPtxPredicate104)
	{
		goto L__BB38_84;
	} // PTX L3550
	r_bPtxPredicate105 = uint32_t(r_PtxRegister46) == uint32_t(2);				// PTX L3551
	r_PtxRegister2009 = r_bPtxPredicate105 ? r_PtxRegister52 : r_PtxRegister53; // PTX L3552
L__BB38_84:																		// PTX L3553
	r_bPtxPredicate106 = uint32_t(r_PtxRegister46) == uint32_t(0);				// PTX L3554
	r_PtxRegister1601 = r_PtxRegister47 | 16;									// PTX L3555
	r_PtxRegister2010 =
		ShuffleIdxPredicate(r_bPtxPredicate107, r_PtxRegister1506, r_PtxRegister1601, 31, -1); // PTX L3556
	r_PtxRegister54 =
		ShuffleIdxPredicate(r_bPtxPredicate108, r_PtxRegister1507, r_PtxRegister1601, 31, -1); // PTX L3557
	r_PtxRegister55 =
		ShuffleIdxPredicate(r_bPtxPredicate109, r_PtxRegister1526, r_PtxRegister1601, 31, -1); // PTX L3558
	r_PtxRegister56 =
		ShuffleIdxPredicate(r_bPtxPredicate110, r_PtxRegister1527, r_PtxRegister1601, 31, -1); // PTX L3559
	if (r_bPtxPredicate106)
	{
		goto L__BB38_87;
	} // PTX L3560
	r_bPtxPredicate111 = uint32_t(r_PtxRegister46) == uint32_t(1); // PTX L3561
	r_PtxRegister2010 = uint32_t(r_PtxRegister54);				   // PTX L3562
	if (r_bPtxPredicate111)
	{
		goto L__BB38_87;
	} // PTX L3563
	r_bPtxPredicate112 = uint32_t(r_PtxRegister46) == uint32_t(2);				// PTX L3564
	r_PtxRegister2010 = r_bPtxPredicate112 ? r_PtxRegister55 : r_PtxRegister56; // PTX L3565
L__BB38_87:																		// PTX L3566
	r_bPtxPredicate113 = uint32_t(r_PtxRegister46) == uint32_t(0);				// PTX L3567
	r_PtxRegister1602 = r_PtxRegister47 | 20;									// PTX L3568
	r_PtxRegister2011 =
		ShuffleIdxPredicate(r_bPtxPredicate114, r_PtxRegister1506, r_PtxRegister1602, 31, -1); // PTX L3569
	r_PtxRegister57 =
		ShuffleIdxPredicate(r_bPtxPredicate115, r_PtxRegister1507, r_PtxRegister1602, 31, -1); // PTX L3570
	r_PtxRegister58 =
		ShuffleIdxPredicate(r_bPtxPredicate116, r_PtxRegister1526, r_PtxRegister1602, 31, -1); // PTX L3571
	r_PtxRegister59 =
		ShuffleIdxPredicate(r_bPtxPredicate117, r_PtxRegister1527, r_PtxRegister1602, 31, -1); // PTX L3572
	if (r_bPtxPredicate113)
	{
		goto L__BB38_90;
	} // PTX L3573
	r_bPtxPredicate118 = uint32_t(r_PtxRegister46) == uint32_t(1); // PTX L3574
	r_PtxRegister2011 = uint32_t(r_PtxRegister57);				   // PTX L3575
	if (r_bPtxPredicate118)
	{
		goto L__BB38_90;
	} // PTX L3576
	r_bPtxPredicate119 = uint32_t(r_PtxRegister46) == uint32_t(2);				 // PTX L3577
	r_PtxRegister2011 = r_bPtxPredicate119 ? r_PtxRegister58 : r_PtxRegister59;	 // PTX L3578
L__BB38_90:																		 // PTX L3579
	r_PackedHalf2AtPtx3581R1603 = HalfAdd(r_PtxRegister2008, r_PtxRegister2009); // PTX L3581
	r_PackedHalf2AtPtx3585R1604 = HalfAdd(r_PtxRegister2010, r_PtxRegister2011); // PTX L3585
	r_PackedHalf2AtPtx3589R1606 =
		HalfAdd(r_PackedHalf2AtPtx3581R1603, r_PackedHalf2AtPtx3585R1604);					   // PTX L3589
	r_PtxRegister1605 = uint32_t(1048576000);												   // PTX L3592
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1605))); // PTX L3594
	r_PackedHalf2AtPtx3597R1817 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);		   // PTX L3597
	r_PackedHalf2AtPtx3599R1823 =
		HalfMul(r_PackedHalf2AtPtx3589R1606, r_PackedHalf2AtPtx3597R1817);		 // PTX L3599
	r_LaneIndexAtPtx3603 = uint32_t((threadIdx.x & 31u));						 // PTX L3603
	r_PtxRegister1608 = ShiftRight(uint32_t(r_LaneIndexAtPtx3603), uint32_t(2)); // PTX L3605
	r_PtxRegister1609 = r_PtxRegister1608 & 2;									 // PTX L3606
	r_PtxRegister1610 = ShiftRight(uint32_t(r_LaneIndexAtPtx3603), uint32_t(4)); // PTX L3607
	r_PtxRegister1611 = r_PtxRegister1610 & 1;									 // PTX L3608
	r_PtxRegister60 = r_PtxRegister1609 | r_PtxRegister1611;					 // PTX L3609
	r_PtxRegister1612 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3603), uint32_t(1));	 // PTX L3610
	r_PtxRegister1613 = r_PtxRegister1612 & 8;									 // PTX L3611
	r_PtxRegister1614 = r_LaneIndexAtPtx3603 & 3;								 // PTX L3612
	r_PtxRegister61 = r_PtxRegister1613 | r_PtxRegister1614;					 // PTX L3613
	r_PtxRegister2012 =
		ShuffleIdxPredicate(r_bPtxPredicate120, r_PtxRegister1550, r_PtxRegister61, 31, -1); // PTX L3614
	r_PtxRegister62 =
		ShuffleIdxPredicate(r_bPtxPredicate121, r_PtxRegister1551, r_PtxRegister61, 31, -1); // PTX L3615
	r_PtxRegister63 =
		ShuffleIdxPredicate(r_bPtxPredicate122, r_PtxRegister1570, r_PtxRegister61, 31, -1); // PTX L3616
	r_PtxRegister64 =
		ShuffleIdxPredicate(r_bPtxPredicate123, r_PtxRegister1571, r_PtxRegister61, 31, -1); // PTX L3617
	r_bPtxPredicate124 = uint32_t(r_PtxRegister60) == uint32_t(0);							 // PTX L3618
	if (r_bPtxPredicate124)
	{
		goto L__BB38_93;
	} // PTX L3619
	r_bPtxPredicate125 = uint32_t(r_PtxRegister60) == uint32_t(1); // PTX L3620
	r_PtxRegister2012 = uint32_t(r_PtxRegister62);				   // PTX L3621
	if (r_bPtxPredicate125)
	{
		goto L__BB38_93;
	} // PTX L3622
	r_bPtxPredicate126 = uint32_t(r_PtxRegister60) == uint32_t(2);				// PTX L3623
	r_PtxRegister2012 = r_bPtxPredicate126 ? r_PtxRegister63 : r_PtxRegister64; // PTX L3624
L__BB38_93:																		// PTX L3625
	r_bPtxPredicate127 = uint32_t(r_PtxRegister60) == uint32_t(0);				// PTX L3626
	r_PtxRegister1615 = r_PtxRegister61 | 4;									// PTX L3627
	r_PtxRegister2013 =
		ShuffleIdxPredicate(r_bPtxPredicate128, r_PtxRegister1550, r_PtxRegister1615, 31, -1); // PTX L3628
	r_PtxRegister65 =
		ShuffleIdxPredicate(r_bPtxPredicate129, r_PtxRegister1551, r_PtxRegister1615, 31, -1); // PTX L3629
	r_PtxRegister66 =
		ShuffleIdxPredicate(r_bPtxPredicate130, r_PtxRegister1570, r_PtxRegister1615, 31, -1); // PTX L3630
	r_PtxRegister67 =
		ShuffleIdxPredicate(r_bPtxPredicate131, r_PtxRegister1571, r_PtxRegister1615, 31, -1); // PTX L3631
	if (r_bPtxPredicate127)
	{
		goto L__BB38_96;
	} // PTX L3632
	r_bPtxPredicate132 = uint32_t(r_PtxRegister60) == uint32_t(1); // PTX L3633
	r_PtxRegister2013 = uint32_t(r_PtxRegister65);				   // PTX L3634
	if (r_bPtxPredicate132)
	{
		goto L__BB38_96;
	} // PTX L3635
	r_bPtxPredicate133 = uint32_t(r_PtxRegister60) == uint32_t(2);				// PTX L3636
	r_PtxRegister2013 = r_bPtxPredicate133 ? r_PtxRegister66 : r_PtxRegister67; // PTX L3637
L__BB38_96:																		// PTX L3638
	r_bPtxPredicate134 = uint32_t(r_PtxRegister60) == uint32_t(0);				// PTX L3639
	r_PtxRegister1616 = r_PtxRegister61 | 16;									// PTX L3640
	r_PtxRegister2014 =
		ShuffleIdxPredicate(r_bPtxPredicate135, r_PtxRegister1550, r_PtxRegister1616, 31, -1); // PTX L3641
	r_PtxRegister68 =
		ShuffleIdxPredicate(r_bPtxPredicate136, r_PtxRegister1551, r_PtxRegister1616, 31, -1); // PTX L3642
	r_PtxRegister69 =
		ShuffleIdxPredicate(r_bPtxPredicate137, r_PtxRegister1570, r_PtxRegister1616, 31, -1); // PTX L3643
	r_PtxRegister70 =
		ShuffleIdxPredicate(r_bPtxPredicate138, r_PtxRegister1571, r_PtxRegister1616, 31, -1); // PTX L3644
	if (r_bPtxPredicate134)
	{
		goto L__BB38_99;
	} // PTX L3645
	r_bPtxPredicate139 = uint32_t(r_PtxRegister60) == uint32_t(1); // PTX L3646
	r_PtxRegister2014 = uint32_t(r_PtxRegister68);				   // PTX L3647
	if (r_bPtxPredicate139)
	{
		goto L__BB38_99;
	} // PTX L3648
	r_bPtxPredicate140 = uint32_t(r_PtxRegister60) == uint32_t(2);				// PTX L3649
	r_PtxRegister2014 = r_bPtxPredicate140 ? r_PtxRegister69 : r_PtxRegister70; // PTX L3650
L__BB38_99:																		// PTX L3651
	r_bPtxPredicate141 = uint32_t(r_PtxRegister60) == uint32_t(0);				// PTX L3652
	r_PtxRegister1617 = r_PtxRegister61 | 20;									// PTX L3653
	r_PtxRegister2015 =
		ShuffleIdxPredicate(r_bPtxPredicate142, r_PtxRegister1550, r_PtxRegister1617, 31, -1); // PTX L3654
	r_PtxRegister71 =
		ShuffleIdxPredicate(r_bPtxPredicate143, r_PtxRegister1551, r_PtxRegister1617, 31, -1); // PTX L3655
	r_PtxRegister72 =
		ShuffleIdxPredicate(r_bPtxPredicate144, r_PtxRegister1570, r_PtxRegister1617, 31, -1); // PTX L3656
	r_PtxRegister73 =
		ShuffleIdxPredicate(r_bPtxPredicate145, r_PtxRegister1571, r_PtxRegister1617, 31, -1); // PTX L3657
	if (r_bPtxPredicate141)
	{
		goto L__BB38_102;
	} // PTX L3658
	r_bPtxPredicate146 = uint32_t(r_PtxRegister60) == uint32_t(1); // PTX L3659
	r_PtxRegister2015 = uint32_t(r_PtxRegister71);				   // PTX L3660
	if (r_bPtxPredicate146)
	{
		goto L__BB38_102;
	} // PTX L3661
	r_bPtxPredicate147 = uint32_t(r_PtxRegister60) == uint32_t(2);				 // PTX L3662
	r_PtxRegister2015 = r_bPtxPredicate147 ? r_PtxRegister72 : r_PtxRegister73;	 // PTX L3663
L__BB38_102:																	 // PTX L3664
	r_PackedHalf2AtPtx3666R1618 = HalfAdd(r_PtxRegister2012, r_PtxRegister2013); // PTX L3666
	r_PackedHalf2AtPtx3670R1619 = HalfAdd(r_PtxRegister2014, r_PtxRegister2015); // PTX L3670
	r_PackedHalf2AtPtx3674R1620 =
		HalfAdd(r_PackedHalf2AtPtx3666R1618, r_PackedHalf2AtPtx3670R1619); // PTX L3674
	r_PackedHalf2AtPtx3678R1824 =
		HalfMul(r_PackedHalf2AtPtx3674R1620, r_PackedHalf2AtPtx3597R1817);		 // PTX L3678
	r_LaneIndexAtPtx3682 = uint32_t((threadIdx.x & 31u));						 // PTX L3682
	r_PtxRegister1622 = ShiftRight(uint32_t(r_LaneIndexAtPtx3682), uint32_t(2)); // PTX L3684
	r_PtxRegister1623 = r_PtxRegister1622 & 2;									 // PTX L3685
	r_PtxRegister1624 = ShiftRight(uint32_t(r_LaneIndexAtPtx3682), uint32_t(4)); // PTX L3686
	r_PtxRegister1625 = r_PtxRegister1624 & 1;									 // PTX L3687
	r_PtxRegister74 = r_PtxRegister1623 | r_PtxRegister1625;					 // PTX L3688
	r_PtxRegister1626 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3682), uint32_t(1));	 // PTX L3689
	r_PtxRegister1627 = r_PtxRegister1626 & 8;									 // PTX L3690
	r_PtxRegister1628 = r_LaneIndexAtPtx3682 & 3;								 // PTX L3691
	r_PtxRegister75 = r_PtxRegister1627 | r_PtxRegister1628;					 // PTX L3692
	r_PtxRegister2016 =
		ShuffleIdxPredicate(r_bPtxPredicate148, r_PtxRegister1508, r_PtxRegister75, 31, -1); // PTX L3693
	r_PtxRegister76 =
		ShuffleIdxPredicate(r_bPtxPredicate149, r_PtxRegister1509, r_PtxRegister75, 31, -1); // PTX L3694
	r_PtxRegister77 =
		ShuffleIdxPredicate(r_bPtxPredicate150, r_PtxRegister1528, r_PtxRegister75, 31, -1); // PTX L3695
	r_PtxRegister78 =
		ShuffleIdxPredicate(r_bPtxPredicate151, r_PtxRegister1529, r_PtxRegister75, 31, -1); // PTX L3696
	r_bPtxPredicate152 = uint32_t(r_PtxRegister74) == uint32_t(0);							 // PTX L3697
	if (r_bPtxPredicate152)
	{
		goto L__BB38_105;
	} // PTX L3698
	r_bPtxPredicate153 = uint32_t(r_PtxRegister74) == uint32_t(1); // PTX L3699
	r_PtxRegister2016 = uint32_t(r_PtxRegister76);				   // PTX L3700
	if (r_bPtxPredicate153)
	{
		goto L__BB38_105;
	} // PTX L3701
	r_bPtxPredicate154 = uint32_t(r_PtxRegister74) == uint32_t(2);				// PTX L3702
	r_PtxRegister2016 = r_bPtxPredicate154 ? r_PtxRegister77 : r_PtxRegister78; // PTX L3703
L__BB38_105:																	// PTX L3704
	r_bPtxPredicate155 = uint32_t(r_PtxRegister74) == uint32_t(0);				// PTX L3705
	r_PtxRegister1629 = r_PtxRegister75 | 4;									// PTX L3706
	r_PtxRegister2017 =
		ShuffleIdxPredicate(r_bPtxPredicate156, r_PtxRegister1508, r_PtxRegister1629, 31, -1); // PTX L3707
	r_PtxRegister79 =
		ShuffleIdxPredicate(r_bPtxPredicate157, r_PtxRegister1509, r_PtxRegister1629, 31, -1); // PTX L3708
	r_PtxRegister80 =
		ShuffleIdxPredicate(r_bPtxPredicate158, r_PtxRegister1528, r_PtxRegister1629, 31, -1); // PTX L3709
	r_PtxRegister81 =
		ShuffleIdxPredicate(r_bPtxPredicate159, r_PtxRegister1529, r_PtxRegister1629, 31, -1); // PTX L3710
	if (r_bPtxPredicate155)
	{
		goto L__BB38_108;
	} // PTX L3711
	r_bPtxPredicate160 = uint32_t(r_PtxRegister74) == uint32_t(1); // PTX L3712
	r_PtxRegister2017 = uint32_t(r_PtxRegister79);				   // PTX L3713
	if (r_bPtxPredicate160)
	{
		goto L__BB38_108;
	} // PTX L3714
	r_bPtxPredicate161 = uint32_t(r_PtxRegister74) == uint32_t(2);				// PTX L3715
	r_PtxRegister2017 = r_bPtxPredicate161 ? r_PtxRegister80 : r_PtxRegister81; // PTX L3716
L__BB38_108:																	// PTX L3717
	r_bPtxPredicate162 = uint32_t(r_PtxRegister74) == uint32_t(0);				// PTX L3718
	r_PtxRegister1630 = r_PtxRegister75 | 16;									// PTX L3719
	r_PtxRegister2018 =
		ShuffleIdxPredicate(r_bPtxPredicate163, r_PtxRegister1508, r_PtxRegister1630, 31, -1); // PTX L3720
	r_PtxRegister82 =
		ShuffleIdxPredicate(r_bPtxPredicate164, r_PtxRegister1509, r_PtxRegister1630, 31, -1); // PTX L3721
	r_PtxRegister83 =
		ShuffleIdxPredicate(r_bPtxPredicate165, r_PtxRegister1528, r_PtxRegister1630, 31, -1); // PTX L3722
	r_PtxRegister84 =
		ShuffleIdxPredicate(r_bPtxPredicate166, r_PtxRegister1529, r_PtxRegister1630, 31, -1); // PTX L3723
	if (r_bPtxPredicate162)
	{
		goto L__BB38_111;
	} // PTX L3724
	r_bPtxPredicate167 = uint32_t(r_PtxRegister74) == uint32_t(1); // PTX L3725
	r_PtxRegister2018 = uint32_t(r_PtxRegister82);				   // PTX L3726
	if (r_bPtxPredicate167)
	{
		goto L__BB38_111;
	} // PTX L3727
	r_bPtxPredicate168 = uint32_t(r_PtxRegister74) == uint32_t(2);				// PTX L3728
	r_PtxRegister2018 = r_bPtxPredicate168 ? r_PtxRegister83 : r_PtxRegister84; // PTX L3729
L__BB38_111:																	// PTX L3730
	r_bPtxPredicate169 = uint32_t(r_PtxRegister74) == uint32_t(0);				// PTX L3731
	r_PtxRegister1631 = r_PtxRegister75 | 20;									// PTX L3732
	r_PtxRegister2019 =
		ShuffleIdxPredicate(r_bPtxPredicate170, r_PtxRegister1508, r_PtxRegister1631, 31, -1); // PTX L3733
	r_PtxRegister85 =
		ShuffleIdxPredicate(r_bPtxPredicate171, r_PtxRegister1509, r_PtxRegister1631, 31, -1); // PTX L3734
	r_PtxRegister86 =
		ShuffleIdxPredicate(r_bPtxPredicate172, r_PtxRegister1528, r_PtxRegister1631, 31, -1); // PTX L3735
	r_PtxRegister87 =
		ShuffleIdxPredicate(r_bPtxPredicate173, r_PtxRegister1529, r_PtxRegister1631, 31, -1); // PTX L3736
	if (r_bPtxPredicate169)
	{
		goto L__BB38_114;
	} // PTX L3737
	r_bPtxPredicate174 = uint32_t(r_PtxRegister74) == uint32_t(1); // PTX L3738
	r_PtxRegister2019 = uint32_t(r_PtxRegister85);				   // PTX L3739
	if (r_bPtxPredicate174)
	{
		goto L__BB38_114;
	} // PTX L3740
	r_bPtxPredicate175 = uint32_t(r_PtxRegister74) == uint32_t(2);				 // PTX L3741
	r_PtxRegister2019 = r_bPtxPredicate175 ? r_PtxRegister86 : r_PtxRegister87;	 // PTX L3742
L__BB38_114:																	 // PTX L3743
	r_PackedHalf2AtPtx3745R1632 = HalfAdd(r_PtxRegister2016, r_PtxRegister2017); // PTX L3745
	r_PackedHalf2AtPtx3749R1633 = HalfAdd(r_PtxRegister2018, r_PtxRegister2019); // PTX L3749
	r_PackedHalf2AtPtx3753R1634 =
		HalfAdd(r_PackedHalf2AtPtx3745R1632, r_PackedHalf2AtPtx3749R1633); // PTX L3753
	r_PackedHalf2AtPtx3757R1825 =
		HalfMul(r_PackedHalf2AtPtx3753R1634, r_PackedHalf2AtPtx3597R1817);		 // PTX L3757
	r_LaneIndexAtPtx3761 = uint32_t((threadIdx.x & 31u));						 // PTX L3761
	r_PtxRegister1636 = ShiftRight(uint32_t(r_LaneIndexAtPtx3761), uint32_t(2)); // PTX L3763
	r_PtxRegister1637 = r_PtxRegister1636 & 2;									 // PTX L3764
	r_PtxRegister1638 = ShiftRight(uint32_t(r_LaneIndexAtPtx3761), uint32_t(4)); // PTX L3765
	r_PtxRegister1639 = r_PtxRegister1638 & 1;									 // PTX L3766
	r_PtxRegister88 = r_PtxRegister1637 | r_PtxRegister1639;					 // PTX L3767
	r_PtxRegister1640 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3761), uint32_t(1));	 // PTX L3768
	r_PtxRegister1641 = r_PtxRegister1640 & 8;									 // PTX L3769
	r_PtxRegister1642 = r_LaneIndexAtPtx3761 & 3;								 // PTX L3770
	r_PtxRegister89 = r_PtxRegister1641 | r_PtxRegister1642;					 // PTX L3771
	r_PtxRegister2020 =
		ShuffleIdxPredicate(r_bPtxPredicate176, r_PtxRegister1552, r_PtxRegister89, 31, -1); // PTX L3772
	r_PtxRegister90 =
		ShuffleIdxPredicate(r_bPtxPredicate177, r_PtxRegister1553, r_PtxRegister89, 31, -1); // PTX L3773
	r_PtxRegister91 =
		ShuffleIdxPredicate(r_bPtxPredicate178, r_PtxRegister1572, r_PtxRegister89, 31, -1); // PTX L3774
	r_PtxRegister92 =
		ShuffleIdxPredicate(r_bPtxPredicate179, r_PtxRegister1573, r_PtxRegister89, 31, -1); // PTX L3775
	r_bPtxPredicate180 = uint32_t(r_PtxRegister88) == uint32_t(0);							 // PTX L3776
	if (r_bPtxPredicate180)
	{
		goto L__BB38_117;
	} // PTX L3777
	r_bPtxPredicate181 = uint32_t(r_PtxRegister88) == uint32_t(1); // PTX L3778
	r_PtxRegister2020 = uint32_t(r_PtxRegister90);				   // PTX L3779
	if (r_bPtxPredicate181)
	{
		goto L__BB38_117;
	} // PTX L3780
	r_bPtxPredicate182 = uint32_t(r_PtxRegister88) == uint32_t(2);				// PTX L3781
	r_PtxRegister2020 = r_bPtxPredicate182 ? r_PtxRegister91 : r_PtxRegister92; // PTX L3782
L__BB38_117:																	// PTX L3783
	r_bPtxPredicate183 = uint32_t(r_PtxRegister88) == uint32_t(0);				// PTX L3784
	r_PtxRegister1643 = r_PtxRegister89 | 4;									// PTX L3785
	r_PtxRegister2021 =
		ShuffleIdxPredicate(r_bPtxPredicate184, r_PtxRegister1552, r_PtxRegister1643, 31, -1); // PTX L3786
	r_PtxRegister93 =
		ShuffleIdxPredicate(r_bPtxPredicate185, r_PtxRegister1553, r_PtxRegister1643, 31, -1); // PTX L3787
	r_PtxRegister94 =
		ShuffleIdxPredicate(r_bPtxPredicate186, r_PtxRegister1572, r_PtxRegister1643, 31, -1); // PTX L3788
	r_PtxRegister95 =
		ShuffleIdxPredicate(r_bPtxPredicate187, r_PtxRegister1573, r_PtxRegister1643, 31, -1); // PTX L3789
	if (r_bPtxPredicate183)
	{
		goto L__BB38_120;
	} // PTX L3790
	r_bPtxPredicate188 = uint32_t(r_PtxRegister88) == uint32_t(1); // PTX L3791
	r_PtxRegister2021 = uint32_t(r_PtxRegister93);				   // PTX L3792
	if (r_bPtxPredicate188)
	{
		goto L__BB38_120;
	} // PTX L3793
	r_bPtxPredicate189 = uint32_t(r_PtxRegister88) == uint32_t(2);				// PTX L3794
	r_PtxRegister2021 = r_bPtxPredicate189 ? r_PtxRegister94 : r_PtxRegister95; // PTX L3795
L__BB38_120:																	// PTX L3796
	r_bPtxPredicate190 = uint32_t(r_PtxRegister88) == uint32_t(0);				// PTX L3797
	r_PtxRegister1644 = r_PtxRegister89 | 16;									// PTX L3798
	r_PtxRegister2022 =
		ShuffleIdxPredicate(r_bPtxPredicate191, r_PtxRegister1552, r_PtxRegister1644, 31, -1); // PTX L3799
	r_PtxRegister96 =
		ShuffleIdxPredicate(r_bPtxPredicate192, r_PtxRegister1553, r_PtxRegister1644, 31, -1); // PTX L3800
	r_PtxRegister97 =
		ShuffleIdxPredicate(r_bPtxPredicate193, r_PtxRegister1572, r_PtxRegister1644, 31, -1); // PTX L3801
	r_PtxRegister98 =
		ShuffleIdxPredicate(r_bPtxPredicate194, r_PtxRegister1573, r_PtxRegister1644, 31, -1); // PTX L3802
	if (r_bPtxPredicate190)
	{
		goto L__BB38_123;
	} // PTX L3803
	r_bPtxPredicate195 = uint32_t(r_PtxRegister88) == uint32_t(1); // PTX L3804
	r_PtxRegister2022 = uint32_t(r_PtxRegister96);				   // PTX L3805
	if (r_bPtxPredicate195)
	{
		goto L__BB38_123;
	} // PTX L3806
	r_bPtxPredicate196 = uint32_t(r_PtxRegister88) == uint32_t(2);				// PTX L3807
	r_PtxRegister2022 = r_bPtxPredicate196 ? r_PtxRegister97 : r_PtxRegister98; // PTX L3808
L__BB38_123:																	// PTX L3809
	r_bPtxPredicate197 = uint32_t(r_PtxRegister88) == uint32_t(0);				// PTX L3810
	r_PtxRegister1645 = r_PtxRegister89 | 20;									// PTX L3811
	r_PtxRegister2023 =
		ShuffleIdxPredicate(r_bPtxPredicate198, r_PtxRegister1552, r_PtxRegister1645, 31, -1); // PTX L3812
	r_PtxRegister99 =
		ShuffleIdxPredicate(r_bPtxPredicate199, r_PtxRegister1553, r_PtxRegister1645, 31, -1); // PTX L3813
	r_PtxRegister100 =
		ShuffleIdxPredicate(r_bPtxPredicate200, r_PtxRegister1572, r_PtxRegister1645, 31, -1); // PTX L3814
	r_PtxRegister101 =
		ShuffleIdxPredicate(r_bPtxPredicate201, r_PtxRegister1573, r_PtxRegister1645, 31, -1); // PTX L3815
	if (r_bPtxPredicate197)
	{
		goto L__BB38_126;
	} // PTX L3816
	r_bPtxPredicate202 = uint32_t(r_PtxRegister88) == uint32_t(1); // PTX L3817
	r_PtxRegister2023 = uint32_t(r_PtxRegister99);				   // PTX L3818
	if (r_bPtxPredicate202)
	{
		goto L__BB38_126;
	} // PTX L3819
	r_bPtxPredicate203 = uint32_t(r_PtxRegister88) == uint32_t(2);				  // PTX L3820
	r_PtxRegister2023 = r_bPtxPredicate203 ? r_PtxRegister100 : r_PtxRegister101; // PTX L3821
L__BB38_126:																	  // PTX L3822
	r_PackedHalf2AtPtx3824R1646 = HalfAdd(r_PtxRegister2020, r_PtxRegister2021);  // PTX L3824
	r_PackedHalf2AtPtx3828R1647 = HalfAdd(r_PtxRegister2022, r_PtxRegister2023);  // PTX L3828
	r_PackedHalf2AtPtx3832R1648 =
		HalfAdd(r_PackedHalf2AtPtx3824R1646, r_PackedHalf2AtPtx3828R1647); // PTX L3832
	r_PackedHalf2AtPtx3836R1826 =
		HalfMul(r_PackedHalf2AtPtx3832R1648, r_PackedHalf2AtPtx3597R1817);		 // PTX L3836
	r_LaneIndexAtPtx3840 = uint32_t((threadIdx.x & 31u));						 // PTX L3840
	r_PtxRegister1650 = ShiftRight(uint32_t(r_LaneIndexAtPtx3840), uint32_t(2)); // PTX L3842
	r_PtxRegister1651 = r_PtxRegister1650 & 2;									 // PTX L3843
	r_PtxRegister1652 = ShiftRight(uint32_t(r_LaneIndexAtPtx3840), uint32_t(4)); // PTX L3844
	r_PtxRegister1653 = r_PtxRegister1652 & 1;									 // PTX L3845
	r_PtxRegister102 = r_PtxRegister1651 | r_PtxRegister1653;					 // PTX L3846
	r_PtxRegister1654 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3840), uint32_t(1));	 // PTX L3847
	r_PtxRegister1655 = r_PtxRegister1654 & 8;									 // PTX L3848
	r_PtxRegister1656 = r_LaneIndexAtPtx3840 & 3;								 // PTX L3849
	r_PtxRegister103 = r_PtxRegister1655 | r_PtxRegister1656;					 // PTX L3850
	r_PtxRegister2024 =
		ShuffleIdxPredicate(r_bPtxPredicate204, r_PtxRegister1511, r_PtxRegister103, 31, -1); // PTX L3851
	r_PtxRegister104 =
		ShuffleIdxPredicate(r_bPtxPredicate205, r_PtxRegister1512, r_PtxRegister103, 31, -1); // PTX L3852
	r_PtxRegister105 =
		ShuffleIdxPredicate(r_bPtxPredicate206, r_PtxRegister1531, r_PtxRegister103, 31, -1); // PTX L3853
	r_PtxRegister106 =
		ShuffleIdxPredicate(r_bPtxPredicate207, r_PtxRegister1532, r_PtxRegister103, 31, -1); // PTX L3854
	r_bPtxPredicate208 = uint32_t(r_PtxRegister102) == uint32_t(0);							  // PTX L3855
	if (r_bPtxPredicate208)
	{
		goto L__BB38_129;
	} // PTX L3856
	r_bPtxPredicate209 = uint32_t(r_PtxRegister102) == uint32_t(1); // PTX L3857
	r_PtxRegister2024 = uint32_t(r_PtxRegister104);					// PTX L3858
	if (r_bPtxPredicate209)
	{
		goto L__BB38_129;
	} // PTX L3859
	r_bPtxPredicate210 = uint32_t(r_PtxRegister102) == uint32_t(2);				  // PTX L3860
	r_PtxRegister2024 = r_bPtxPredicate210 ? r_PtxRegister105 : r_PtxRegister106; // PTX L3861
L__BB38_129:																	  // PTX L3862
	r_bPtxPredicate211 = uint32_t(r_PtxRegister102) == uint32_t(0);				  // PTX L3863
	r_PtxRegister1657 = r_PtxRegister103 | 4;									  // PTX L3864
	r_PtxRegister2025 =
		ShuffleIdxPredicate(r_bPtxPredicate212, r_PtxRegister1511, r_PtxRegister1657, 31, -1); // PTX L3865
	r_PtxRegister107 =
		ShuffleIdxPredicate(r_bPtxPredicate213, r_PtxRegister1512, r_PtxRegister1657, 31, -1); // PTX L3866
	r_PtxRegister108 =
		ShuffleIdxPredicate(r_bPtxPredicate214, r_PtxRegister1531, r_PtxRegister1657, 31, -1); // PTX L3867
	r_PtxRegister109 =
		ShuffleIdxPredicate(r_bPtxPredicate215, r_PtxRegister1532, r_PtxRegister1657, 31, -1); // PTX L3868
	if (r_bPtxPredicate211)
	{
		goto L__BB38_132;
	} // PTX L3869
	r_bPtxPredicate216 = uint32_t(r_PtxRegister102) == uint32_t(1); // PTX L3870
	r_PtxRegister2025 = uint32_t(r_PtxRegister107);					// PTX L3871
	if (r_bPtxPredicate216)
	{
		goto L__BB38_132;
	} // PTX L3872
	r_bPtxPredicate217 = uint32_t(r_PtxRegister102) == uint32_t(2);				  // PTX L3873
	r_PtxRegister2025 = r_bPtxPredicate217 ? r_PtxRegister108 : r_PtxRegister109; // PTX L3874
L__BB38_132:																	  // PTX L3875
	r_bPtxPredicate218 = uint32_t(r_PtxRegister102) == uint32_t(0);				  // PTX L3876
	r_PtxRegister1658 = r_PtxRegister103 | 16;									  // PTX L3877
	r_PtxRegister2026 =
		ShuffleIdxPredicate(r_bPtxPredicate219, r_PtxRegister1511, r_PtxRegister1658, 31, -1); // PTX L3878
	r_PtxRegister110 =
		ShuffleIdxPredicate(r_bPtxPredicate220, r_PtxRegister1512, r_PtxRegister1658, 31, -1); // PTX L3879
	r_PtxRegister111 =
		ShuffleIdxPredicate(r_bPtxPredicate221, r_PtxRegister1531, r_PtxRegister1658, 31, -1); // PTX L3880
	r_PtxRegister112 =
		ShuffleIdxPredicate(r_bPtxPredicate222, r_PtxRegister1532, r_PtxRegister1658, 31, -1); // PTX L3881
	if (r_bPtxPredicate218)
	{
		goto L__BB38_135;
	} // PTX L3882
	r_bPtxPredicate223 = uint32_t(r_PtxRegister102) == uint32_t(1); // PTX L3883
	r_PtxRegister2026 = uint32_t(r_PtxRegister110);					// PTX L3884
	if (r_bPtxPredicate223)
	{
		goto L__BB38_135;
	} // PTX L3885
	r_bPtxPredicate224 = uint32_t(r_PtxRegister102) == uint32_t(2);				  // PTX L3886
	r_PtxRegister2026 = r_bPtxPredicate224 ? r_PtxRegister111 : r_PtxRegister112; // PTX L3887
L__BB38_135:																	  // PTX L3888
	r_bPtxPredicate225 = uint32_t(r_PtxRegister102) == uint32_t(0);				  // PTX L3889
	r_PtxRegister1659 = r_PtxRegister103 | 20;									  // PTX L3890
	r_PtxRegister2027 =
		ShuffleIdxPredicate(r_bPtxPredicate226, r_PtxRegister1511, r_PtxRegister1659, 31, -1); // PTX L3891
	r_PtxRegister113 =
		ShuffleIdxPredicate(r_bPtxPredicate227, r_PtxRegister1512, r_PtxRegister1659, 31, -1); // PTX L3892
	r_PtxRegister114 =
		ShuffleIdxPredicate(r_bPtxPredicate228, r_PtxRegister1531, r_PtxRegister1659, 31, -1); // PTX L3893
	r_PtxRegister115 =
		ShuffleIdxPredicate(r_bPtxPredicate229, r_PtxRegister1532, r_PtxRegister1659, 31, -1); // PTX L3894
	if (r_bPtxPredicate225)
	{
		goto L__BB38_138;
	} // PTX L3895
	r_bPtxPredicate230 = uint32_t(r_PtxRegister102) == uint32_t(1); // PTX L3896
	r_PtxRegister2027 = uint32_t(r_PtxRegister113);					// PTX L3897
	if (r_bPtxPredicate230)
	{
		goto L__BB38_138;
	} // PTX L3898
	r_bPtxPredicate231 = uint32_t(r_PtxRegister102) == uint32_t(2);				  // PTX L3899
	r_PtxRegister2027 = r_bPtxPredicate231 ? r_PtxRegister114 : r_PtxRegister115; // PTX L3900
L__BB38_138:																	  // PTX L3901
	r_PackedHalf2AtPtx3903R1660 = HalfAdd(r_PtxRegister2024, r_PtxRegister2025);  // PTX L3903
	r_PackedHalf2AtPtx3907R1661 = HalfAdd(r_PtxRegister2026, r_PtxRegister2027);  // PTX L3907
	r_PackedHalf2AtPtx3911R1662 =
		HalfAdd(r_PackedHalf2AtPtx3903R1660, r_PackedHalf2AtPtx3907R1661); // PTX L3911
	r_PackedHalf2AtPtx3915R1828 =
		HalfMul(r_PackedHalf2AtPtx3911R1662, r_PackedHalf2AtPtx3597R1817);		 // PTX L3915
	r_LaneIndexAtPtx3919 = uint32_t((threadIdx.x & 31u));						 // PTX L3919
	r_PtxRegister1664 = ShiftRight(uint32_t(r_LaneIndexAtPtx3919), uint32_t(2)); // PTX L3921
	r_PtxRegister1665 = r_PtxRegister1664 & 2;									 // PTX L3922
	r_PtxRegister1666 = ShiftRight(uint32_t(r_LaneIndexAtPtx3919), uint32_t(4)); // PTX L3923
	r_PtxRegister1667 = r_PtxRegister1666 & 1;									 // PTX L3924
	r_PtxRegister116 = r_PtxRegister1665 | r_PtxRegister1667;					 // PTX L3925
	r_PtxRegister1668 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3919), uint32_t(1));	 // PTX L3926
	r_PtxRegister1669 = r_PtxRegister1668 & 8;									 // PTX L3927
	r_PtxRegister1670 = r_LaneIndexAtPtx3919 & 3;								 // PTX L3928
	r_PtxRegister117 = r_PtxRegister1669 | r_PtxRegister1670;					 // PTX L3929
	r_PtxRegister2028 =
		ShuffleIdxPredicate(r_bPtxPredicate232, r_PtxRegister1555, r_PtxRegister117, 31, -1); // PTX L3930
	r_PtxRegister118 =
		ShuffleIdxPredicate(r_bPtxPredicate233, r_PtxRegister1556, r_PtxRegister117, 31, -1); // PTX L3931
	r_PtxRegister119 =
		ShuffleIdxPredicate(r_bPtxPredicate234, r_PtxRegister1575, r_PtxRegister117, 31, -1); // PTX L3932
	r_PtxRegister120 =
		ShuffleIdxPredicate(r_bPtxPredicate235, r_PtxRegister1576, r_PtxRegister117, 31, -1); // PTX L3933
	r_bPtxPredicate236 = uint32_t(r_PtxRegister116) == uint32_t(0);							  // PTX L3934
	if (r_bPtxPredicate236)
	{
		goto L__BB38_141;
	} // PTX L3935
	r_bPtxPredicate237 = uint32_t(r_PtxRegister116) == uint32_t(1); // PTX L3936
	r_PtxRegister2028 = uint32_t(r_PtxRegister118);					// PTX L3937
	if (r_bPtxPredicate237)
	{
		goto L__BB38_141;
	} // PTX L3938
	r_bPtxPredicate238 = uint32_t(r_PtxRegister116) == uint32_t(2);				  // PTX L3939
	r_PtxRegister2028 = r_bPtxPredicate238 ? r_PtxRegister119 : r_PtxRegister120; // PTX L3940
L__BB38_141:																	  // PTX L3941
	r_bPtxPredicate239 = uint32_t(r_PtxRegister116) == uint32_t(0);				  // PTX L3942
	r_PtxRegister1671 = r_PtxRegister117 | 4;									  // PTX L3943
	r_PtxRegister2029 =
		ShuffleIdxPredicate(r_bPtxPredicate240, r_PtxRegister1555, r_PtxRegister1671, 31, -1); // PTX L3944
	r_PtxRegister121 =
		ShuffleIdxPredicate(r_bPtxPredicate241, r_PtxRegister1556, r_PtxRegister1671, 31, -1); // PTX L3945
	r_PtxRegister122 =
		ShuffleIdxPredicate(r_bPtxPredicate242, r_PtxRegister1575, r_PtxRegister1671, 31, -1); // PTX L3946
	r_PtxRegister123 =
		ShuffleIdxPredicate(r_bPtxPredicate243, r_PtxRegister1576, r_PtxRegister1671, 31, -1); // PTX L3947
	if (r_bPtxPredicate239)
	{
		goto L__BB38_144;
	} // PTX L3948
	r_bPtxPredicate244 = uint32_t(r_PtxRegister116) == uint32_t(1); // PTX L3949
	r_PtxRegister2029 = uint32_t(r_PtxRegister121);					// PTX L3950
	if (r_bPtxPredicate244)
	{
		goto L__BB38_144;
	} // PTX L3951
	r_bPtxPredicate245 = uint32_t(r_PtxRegister116) == uint32_t(2);				  // PTX L3952
	r_PtxRegister2029 = r_bPtxPredicate245 ? r_PtxRegister122 : r_PtxRegister123; // PTX L3953
L__BB38_144:																	  // PTX L3954
	r_bPtxPredicate246 = uint32_t(r_PtxRegister116) == uint32_t(0);				  // PTX L3955
	r_PtxRegister1672 = r_PtxRegister117 | 16;									  // PTX L3956
	r_PtxRegister2030 =
		ShuffleIdxPredicate(r_bPtxPredicate247, r_PtxRegister1555, r_PtxRegister1672, 31, -1); // PTX L3957
	r_PtxRegister124 =
		ShuffleIdxPredicate(r_bPtxPredicate248, r_PtxRegister1556, r_PtxRegister1672, 31, -1); // PTX L3958
	r_PtxRegister125 =
		ShuffleIdxPredicate(r_bPtxPredicate249, r_PtxRegister1575, r_PtxRegister1672, 31, -1); // PTX L3959
	r_PtxRegister126 =
		ShuffleIdxPredicate(r_bPtxPredicate250, r_PtxRegister1576, r_PtxRegister1672, 31, -1); // PTX L3960
	if (r_bPtxPredicate246)
	{
		goto L__BB38_147;
	} // PTX L3961
	r_bPtxPredicate251 = uint32_t(r_PtxRegister116) == uint32_t(1); // PTX L3962
	r_PtxRegister2030 = uint32_t(r_PtxRegister124);					// PTX L3963
	if (r_bPtxPredicate251)
	{
		goto L__BB38_147;
	} // PTX L3964
	r_bPtxPredicate252 = uint32_t(r_PtxRegister116) == uint32_t(2);				  // PTX L3965
	r_PtxRegister2030 = r_bPtxPredicate252 ? r_PtxRegister125 : r_PtxRegister126; // PTX L3966
L__BB38_147:																	  // PTX L3967
	r_bPtxPredicate253 = uint32_t(r_PtxRegister116) == uint32_t(0);				  // PTX L3968
	r_PtxRegister1673 = r_PtxRegister117 | 20;									  // PTX L3969
	r_PtxRegister2031 =
		ShuffleIdxPredicate(r_bPtxPredicate254, r_PtxRegister1555, r_PtxRegister1673, 31, -1); // PTX L3970
	r_PtxRegister127 =
		ShuffleIdxPredicate(r_bPtxPredicate255, r_PtxRegister1556, r_PtxRegister1673, 31, -1); // PTX L3971
	r_PtxRegister128 =
		ShuffleIdxPredicate(r_bPtxPredicate256, r_PtxRegister1575, r_PtxRegister1673, 31, -1); // PTX L3972
	r_PtxRegister129 =
		ShuffleIdxPredicate(r_bPtxPredicate257, r_PtxRegister1576, r_PtxRegister1673, 31, -1); // PTX L3973
	if (r_bPtxPredicate253)
	{
		goto L__BB38_150;
	} // PTX L3974
	r_bPtxPredicate258 = uint32_t(r_PtxRegister116) == uint32_t(1); // PTX L3975
	r_PtxRegister2031 = uint32_t(r_PtxRegister127);					// PTX L3976
	if (r_bPtxPredicate258)
	{
		goto L__BB38_150;
	} // PTX L3977
	r_bPtxPredicate259 = uint32_t(r_PtxRegister116) == uint32_t(2);				  // PTX L3978
	r_PtxRegister2031 = r_bPtxPredicate259 ? r_PtxRegister128 : r_PtxRegister129; // PTX L3979
L__BB38_150:																	  // PTX L3980
	r_PackedHalf2AtPtx3982R1674 = HalfAdd(r_PtxRegister2028, r_PtxRegister2029);  // PTX L3982
	r_PackedHalf2AtPtx3986R1675 = HalfAdd(r_PtxRegister2030, r_PtxRegister2031);  // PTX L3986
	r_PackedHalf2AtPtx3990R1676 =
		HalfAdd(r_PackedHalf2AtPtx3982R1674, r_PackedHalf2AtPtx3986R1675); // PTX L3990
	r_PackedHalf2AtPtx3994R1829 =
		HalfMul(r_PackedHalf2AtPtx3990R1676, r_PackedHalf2AtPtx3597R1817);		 // PTX L3994
	r_LaneIndexAtPtx3998 = uint32_t((threadIdx.x & 31u));						 // PTX L3998
	r_PtxRegister1678 = ShiftRight(uint32_t(r_LaneIndexAtPtx3998), uint32_t(2)); // PTX L4000
	r_PtxRegister1679 = r_PtxRegister1678 & 2;									 // PTX L4001
	r_PtxRegister1680 = ShiftRight(uint32_t(r_LaneIndexAtPtx3998), uint32_t(4)); // PTX L4002
	r_PtxRegister1681 = r_PtxRegister1680 & 1;									 // PTX L4003
	r_PtxRegister130 = r_PtxRegister1679 | r_PtxRegister1681;					 // PTX L4004
	r_PtxRegister1682 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3998), uint32_t(1));	 // PTX L4005
	r_PtxRegister1683 = r_PtxRegister1682 & 8;									 // PTX L4006
	r_PtxRegister1684 = r_LaneIndexAtPtx3998 & 3;								 // PTX L4007
	r_PtxRegister131 = r_PtxRegister1683 | r_PtxRegister1684;					 // PTX L4008
	r_PtxRegister2032 =
		ShuffleIdxPredicate(r_bPtxPredicate260, r_PtxRegister1513, r_PtxRegister131, 31, -1); // PTX L4009
	r_PtxRegister132 =
		ShuffleIdxPredicate(r_bPtxPredicate261, r_PtxRegister1514, r_PtxRegister131, 31, -1); // PTX L4010
	r_PtxRegister133 =
		ShuffleIdxPredicate(r_bPtxPredicate262, r_PtxRegister1533, r_PtxRegister131, 31, -1); // PTX L4011
	r_PtxRegister134 =
		ShuffleIdxPredicate(r_bPtxPredicate263, r_PtxRegister1534, r_PtxRegister131, 31, -1); // PTX L4012
	r_bPtxPredicate264 = uint32_t(r_PtxRegister130) == uint32_t(0);							  // PTX L4013
	if (r_bPtxPredicate264)
	{
		goto L__BB38_153;
	} // PTX L4014
	r_bPtxPredicate265 = uint32_t(r_PtxRegister130) == uint32_t(1); // PTX L4015
	r_PtxRegister2032 = uint32_t(r_PtxRegister132);					// PTX L4016
	if (r_bPtxPredicate265)
	{
		goto L__BB38_153;
	} // PTX L4017
	r_bPtxPredicate266 = uint32_t(r_PtxRegister130) == uint32_t(2);				  // PTX L4018
	r_PtxRegister2032 = r_bPtxPredicate266 ? r_PtxRegister133 : r_PtxRegister134; // PTX L4019
L__BB38_153:																	  // PTX L4020
	r_bPtxPredicate267 = uint32_t(r_PtxRegister130) == uint32_t(0);				  // PTX L4021
	r_PtxRegister1685 = r_PtxRegister131 | 4;									  // PTX L4022
	r_PtxRegister2033 =
		ShuffleIdxPredicate(r_bPtxPredicate268, r_PtxRegister1513, r_PtxRegister1685, 31, -1); // PTX L4023
	r_PtxRegister135 =
		ShuffleIdxPredicate(r_bPtxPredicate269, r_PtxRegister1514, r_PtxRegister1685, 31, -1); // PTX L4024
	r_PtxRegister136 =
		ShuffleIdxPredicate(r_bPtxPredicate270, r_PtxRegister1533, r_PtxRegister1685, 31, -1); // PTX L4025
	r_PtxRegister137 =
		ShuffleIdxPredicate(r_bPtxPredicate271, r_PtxRegister1534, r_PtxRegister1685, 31, -1); // PTX L4026
	if (r_bPtxPredicate267)
	{
		goto L__BB38_156;
	} // PTX L4027
	r_bPtxPredicate272 = uint32_t(r_PtxRegister130) == uint32_t(1); // PTX L4028
	r_PtxRegister2033 = uint32_t(r_PtxRegister135);					// PTX L4029
	if (r_bPtxPredicate272)
	{
		goto L__BB38_156;
	} // PTX L4030
	r_bPtxPredicate273 = uint32_t(r_PtxRegister130) == uint32_t(2);				  // PTX L4031
	r_PtxRegister2033 = r_bPtxPredicate273 ? r_PtxRegister136 : r_PtxRegister137; // PTX L4032
L__BB38_156:																	  // PTX L4033
	r_bPtxPredicate274 = uint32_t(r_PtxRegister130) == uint32_t(0);				  // PTX L4034
	r_PtxRegister1686 = r_PtxRegister131 | 16;									  // PTX L4035
	r_PtxRegister2034 =
		ShuffleIdxPredicate(r_bPtxPredicate275, r_PtxRegister1513, r_PtxRegister1686, 31, -1); // PTX L4036
	r_PtxRegister138 =
		ShuffleIdxPredicate(r_bPtxPredicate276, r_PtxRegister1514, r_PtxRegister1686, 31, -1); // PTX L4037
	r_PtxRegister139 =
		ShuffleIdxPredicate(r_bPtxPredicate277, r_PtxRegister1533, r_PtxRegister1686, 31, -1); // PTX L4038
	r_PtxRegister140 =
		ShuffleIdxPredicate(r_bPtxPredicate278, r_PtxRegister1534, r_PtxRegister1686, 31, -1); // PTX L4039
	if (r_bPtxPredicate274)
	{
		goto L__BB38_159;
	} // PTX L4040
	r_bPtxPredicate279 = uint32_t(r_PtxRegister130) == uint32_t(1); // PTX L4041
	r_PtxRegister2034 = uint32_t(r_PtxRegister138);					// PTX L4042
	if (r_bPtxPredicate279)
	{
		goto L__BB38_159;
	} // PTX L4043
	r_bPtxPredicate280 = uint32_t(r_PtxRegister130) == uint32_t(2);				  // PTX L4044
	r_PtxRegister2034 = r_bPtxPredicate280 ? r_PtxRegister139 : r_PtxRegister140; // PTX L4045
L__BB38_159:																	  // PTX L4046
	r_bPtxPredicate281 = uint32_t(r_PtxRegister130) == uint32_t(0);				  // PTX L4047
	r_PtxRegister1687 = r_PtxRegister131 | 20;									  // PTX L4048
	r_PtxRegister2035 =
		ShuffleIdxPredicate(r_bPtxPredicate282, r_PtxRegister1513, r_PtxRegister1687, 31, -1); // PTX L4049
	r_PtxRegister141 =
		ShuffleIdxPredicate(r_bPtxPredicate283, r_PtxRegister1514, r_PtxRegister1687, 31, -1); // PTX L4050
	r_PtxRegister142 =
		ShuffleIdxPredicate(r_bPtxPredicate284, r_PtxRegister1533, r_PtxRegister1687, 31, -1); // PTX L4051
	r_PtxRegister143 =
		ShuffleIdxPredicate(r_bPtxPredicate285, r_PtxRegister1534, r_PtxRegister1687, 31, -1); // PTX L4052
	if (r_bPtxPredicate281)
	{
		goto L__BB38_162;
	} // PTX L4053
	r_bPtxPredicate286 = uint32_t(r_PtxRegister130) == uint32_t(1); // PTX L4054
	r_PtxRegister2035 = uint32_t(r_PtxRegister141);					// PTX L4055
	if (r_bPtxPredicate286)
	{
		goto L__BB38_162;
	} // PTX L4056
	r_bPtxPredicate287 = uint32_t(r_PtxRegister130) == uint32_t(2);				  // PTX L4057
	r_PtxRegister2035 = r_bPtxPredicate287 ? r_PtxRegister142 : r_PtxRegister143; // PTX L4058
L__BB38_162:																	  // PTX L4059
	r_PackedHalf2AtPtx4061R1688 = HalfAdd(r_PtxRegister2032, r_PtxRegister2033);  // PTX L4061
	r_PackedHalf2AtPtx4065R1689 = HalfAdd(r_PtxRegister2034, r_PtxRegister2035);  // PTX L4065
	r_PackedHalf2AtPtx4069R1690 =
		HalfAdd(r_PackedHalf2AtPtx4061R1688, r_PackedHalf2AtPtx4065R1689); // PTX L4069
	r_PackedHalf2AtPtx4073R1830 =
		HalfMul(r_PackedHalf2AtPtx4069R1690, r_PackedHalf2AtPtx3597R1817);		 // PTX L4073
	r_LaneIndexAtPtx4077 = uint32_t((threadIdx.x & 31u));						 // PTX L4077
	r_PtxRegister1692 = ShiftRight(uint32_t(r_LaneIndexAtPtx4077), uint32_t(2)); // PTX L4079
	r_PtxRegister1693 = r_PtxRegister1692 & 2;									 // PTX L4080
	r_PtxRegister1694 = ShiftRight(uint32_t(r_LaneIndexAtPtx4077), uint32_t(4)); // PTX L4081
	r_PtxRegister1695 = r_PtxRegister1694 & 1;									 // PTX L4082
	r_PtxRegister144 = r_PtxRegister1693 | r_PtxRegister1695;					 // PTX L4083
	r_PtxRegister1696 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4077), uint32_t(1));	 // PTX L4084
	r_PtxRegister1697 = r_PtxRegister1696 & 8;									 // PTX L4085
	r_PtxRegister1698 = r_LaneIndexAtPtx4077 & 3;								 // PTX L4086
	r_PtxRegister145 = r_PtxRegister1697 | r_PtxRegister1698;					 // PTX L4087
	r_PtxRegister2036 =
		ShuffleIdxPredicate(r_bPtxPredicate288, r_PtxRegister1557, r_PtxRegister145, 31, -1); // PTX L4088
	r_PtxRegister146 =
		ShuffleIdxPredicate(r_bPtxPredicate289, r_PtxRegister1558, r_PtxRegister145, 31, -1); // PTX L4089
	r_PtxRegister147 =
		ShuffleIdxPredicate(r_bPtxPredicate290, r_PtxRegister1577, r_PtxRegister145, 31, -1); // PTX L4090
	r_PtxRegister148 =
		ShuffleIdxPredicate(r_bPtxPredicate291, r_PtxRegister1578, r_PtxRegister145, 31, -1); // PTX L4091
	r_bPtxPredicate292 = uint32_t(r_PtxRegister144) == uint32_t(0);							  // PTX L4092
	if (r_bPtxPredicate292)
	{
		goto L__BB38_165;
	} // PTX L4093
	r_bPtxPredicate293 = uint32_t(r_PtxRegister144) == uint32_t(1); // PTX L4094
	r_PtxRegister2036 = uint32_t(r_PtxRegister146);					// PTX L4095
	if (r_bPtxPredicate293)
	{
		goto L__BB38_165;
	} // PTX L4096
	r_bPtxPredicate294 = uint32_t(r_PtxRegister144) == uint32_t(2);				  // PTX L4097
	r_PtxRegister2036 = r_bPtxPredicate294 ? r_PtxRegister147 : r_PtxRegister148; // PTX L4098
L__BB38_165:																	  // PTX L4099
	r_bPtxPredicate295 = uint32_t(r_PtxRegister144) == uint32_t(0);				  // PTX L4100
	r_PtxRegister1699 = r_PtxRegister145 | 4;									  // PTX L4101
	r_PtxRegister2037 =
		ShuffleIdxPredicate(r_bPtxPredicate296, r_PtxRegister1557, r_PtxRegister1699, 31, -1); // PTX L4102
	r_PtxRegister149 =
		ShuffleIdxPredicate(r_bPtxPredicate297, r_PtxRegister1558, r_PtxRegister1699, 31, -1); // PTX L4103
	r_PtxRegister150 =
		ShuffleIdxPredicate(r_bPtxPredicate298, r_PtxRegister1577, r_PtxRegister1699, 31, -1); // PTX L4104
	r_PtxRegister151 =
		ShuffleIdxPredicate(r_bPtxPredicate299, r_PtxRegister1578, r_PtxRegister1699, 31, -1); // PTX L4105
	if (r_bPtxPredicate295)
	{
		goto L__BB38_168;
	} // PTX L4106
	r_bPtxPredicate300 = uint32_t(r_PtxRegister144) == uint32_t(1); // PTX L4107
	r_PtxRegister2037 = uint32_t(r_PtxRegister149);					// PTX L4108
	if (r_bPtxPredicate300)
	{
		goto L__BB38_168;
	} // PTX L4109
	r_bPtxPredicate301 = uint32_t(r_PtxRegister144) == uint32_t(2);				  // PTX L4110
	r_PtxRegister2037 = r_bPtxPredicate301 ? r_PtxRegister150 : r_PtxRegister151; // PTX L4111
L__BB38_168:																	  // PTX L4112
	r_bPtxPredicate302 = uint32_t(r_PtxRegister144) == uint32_t(0);				  // PTX L4113
	r_PtxRegister1700 = r_PtxRegister145 | 16;									  // PTX L4114
	r_PtxRegister2038 =
		ShuffleIdxPredicate(r_bPtxPredicate303, r_PtxRegister1557, r_PtxRegister1700, 31, -1); // PTX L4115
	r_PtxRegister152 =
		ShuffleIdxPredicate(r_bPtxPredicate304, r_PtxRegister1558, r_PtxRegister1700, 31, -1); // PTX L4116
	r_PtxRegister153 =
		ShuffleIdxPredicate(r_bPtxPredicate305, r_PtxRegister1577, r_PtxRegister1700, 31, -1); // PTX L4117
	r_PtxRegister154 =
		ShuffleIdxPredicate(r_bPtxPredicate306, r_PtxRegister1578, r_PtxRegister1700, 31, -1); // PTX L4118
	if (r_bPtxPredicate302)
	{
		goto L__BB38_171;
	} // PTX L4119
	r_bPtxPredicate307 = uint32_t(r_PtxRegister144) == uint32_t(1); // PTX L4120
	r_PtxRegister2038 = uint32_t(r_PtxRegister152);					// PTX L4121
	if (r_bPtxPredicate307)
	{
		goto L__BB38_171;
	} // PTX L4122
	r_bPtxPredicate308 = uint32_t(r_PtxRegister144) == uint32_t(2);				  // PTX L4123
	r_PtxRegister2038 = r_bPtxPredicate308 ? r_PtxRegister153 : r_PtxRegister154; // PTX L4124
L__BB38_171:																	  // PTX L4125
	r_bPtxPredicate309 = uint32_t(r_PtxRegister144) == uint32_t(0);				  // PTX L4126
	r_PtxRegister1701 = r_PtxRegister145 | 20;									  // PTX L4127
	r_PtxRegister2039 =
		ShuffleIdxPredicate(r_bPtxPredicate310, r_PtxRegister1557, r_PtxRegister1701, 31, -1); // PTX L4128
	r_PtxRegister155 =
		ShuffleIdxPredicate(r_bPtxPredicate311, r_PtxRegister1558, r_PtxRegister1701, 31, -1); // PTX L4129
	r_PtxRegister156 =
		ShuffleIdxPredicate(r_bPtxPredicate312, r_PtxRegister1577, r_PtxRegister1701, 31, -1); // PTX L4130
	r_PtxRegister157 =
		ShuffleIdxPredicate(r_bPtxPredicate313, r_PtxRegister1578, r_PtxRegister1701, 31, -1); // PTX L4131
	if (r_bPtxPredicate309)
	{
		goto L__BB38_174;
	} // PTX L4132
	r_bPtxPredicate314 = uint32_t(r_PtxRegister144) == uint32_t(1); // PTX L4133
	r_PtxRegister2039 = uint32_t(r_PtxRegister155);					// PTX L4134
	if (r_bPtxPredicate314)
	{
		goto L__BB38_174;
	} // PTX L4135
	r_bPtxPredicate315 = uint32_t(r_PtxRegister144) == uint32_t(2);				  // PTX L4136
	r_PtxRegister2039 = r_bPtxPredicate315 ? r_PtxRegister156 : r_PtxRegister157; // PTX L4137
L__BB38_174:																	  // PTX L4138
	r_PackedHalf2AtPtx4140R1702 = HalfAdd(r_PtxRegister2036, r_PtxRegister2037);  // PTX L4140
	r_PackedHalf2AtPtx4144R1703 = HalfAdd(r_PtxRegister2038, r_PtxRegister2039);  // PTX L4144
	r_PackedHalf2AtPtx4148R1704 =
		HalfAdd(r_PackedHalf2AtPtx4140R1702, r_PackedHalf2AtPtx4144R1703); // PTX L4148
	r_PackedHalf2AtPtx4152R1831 =
		HalfMul(r_PackedHalf2AtPtx4148R1704, r_PackedHalf2AtPtx3597R1817);		 // PTX L4152
	r_LaneIndexAtPtx4156 = uint32_t((threadIdx.x & 31u));						 // PTX L4156
	r_PtxRegister1706 = ShiftRight(uint32_t(r_LaneIndexAtPtx4156), uint32_t(2)); // PTX L4158
	r_PtxRegister1707 = r_PtxRegister1706 & 2;									 // PTX L4159
	r_PtxRegister1708 = ShiftRight(uint32_t(r_LaneIndexAtPtx4156), uint32_t(4)); // PTX L4160
	r_PtxRegister1709 = r_PtxRegister1708 & 1;									 // PTX L4161
	r_PtxRegister158 = r_PtxRegister1707 | r_PtxRegister1709;					 // PTX L4162
	r_PtxRegister1710 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4156), uint32_t(1));	 // PTX L4163
	r_PtxRegister1711 = r_PtxRegister1710 & 8;									 // PTX L4164
	r_PtxRegister1712 = r_LaneIndexAtPtx4156 & 3;								 // PTX L4165
	r_PtxRegister159 = r_PtxRegister1711 | r_PtxRegister1712;					 // PTX L4166
	r_PtxRegister2040 =
		ShuffleIdxPredicate(r_bPtxPredicate316, r_PtxRegister1516, r_PtxRegister159, 31, -1); // PTX L4167
	r_PtxRegister160 =
		ShuffleIdxPredicate(r_bPtxPredicate317, r_PtxRegister1517, r_PtxRegister159, 31, -1); // PTX L4168
	r_PtxRegister161 =
		ShuffleIdxPredicate(r_bPtxPredicate318, r_PtxRegister1536, r_PtxRegister159, 31, -1); // PTX L4169
	r_PtxRegister162 =
		ShuffleIdxPredicate(r_bPtxPredicate319, r_PtxRegister1537, r_PtxRegister159, 31, -1); // PTX L4170
	r_bPtxPredicate320 = uint32_t(r_PtxRegister158) == uint32_t(0);							  // PTX L4171
	if (r_bPtxPredicate320)
	{
		goto L__BB38_177;
	} // PTX L4172
	r_bPtxPredicate321 = uint32_t(r_PtxRegister158) == uint32_t(1); // PTX L4173
	r_PtxRegister2040 = uint32_t(r_PtxRegister160);					// PTX L4174
	if (r_bPtxPredicate321)
	{
		goto L__BB38_177;
	} // PTX L4175
	r_bPtxPredicate322 = uint32_t(r_PtxRegister158) == uint32_t(2);				  // PTX L4176
	r_PtxRegister2040 = r_bPtxPredicate322 ? r_PtxRegister161 : r_PtxRegister162; // PTX L4177
L__BB38_177:																	  // PTX L4178
	r_bPtxPredicate323 = uint32_t(r_PtxRegister158) == uint32_t(0);				  // PTX L4179
	r_PtxRegister1713 = r_PtxRegister159 | 4;									  // PTX L4180
	r_PtxRegister2041 =
		ShuffleIdxPredicate(r_bPtxPredicate324, r_PtxRegister1516, r_PtxRegister1713, 31, -1); // PTX L4181
	r_PtxRegister163 =
		ShuffleIdxPredicate(r_bPtxPredicate325, r_PtxRegister1517, r_PtxRegister1713, 31, -1); // PTX L4182
	r_PtxRegister164 =
		ShuffleIdxPredicate(r_bPtxPredicate326, r_PtxRegister1536, r_PtxRegister1713, 31, -1); // PTX L4183
	r_PtxRegister165 =
		ShuffleIdxPredicate(r_bPtxPredicate327, r_PtxRegister1537, r_PtxRegister1713, 31, -1); // PTX L4184
	if (r_bPtxPredicate323)
	{
		goto L__BB38_180;
	} // PTX L4185
	r_bPtxPredicate328 = uint32_t(r_PtxRegister158) == uint32_t(1); // PTX L4186
	r_PtxRegister2041 = uint32_t(r_PtxRegister163);					// PTX L4187
	if (r_bPtxPredicate328)
	{
		goto L__BB38_180;
	} // PTX L4188
	r_bPtxPredicate329 = uint32_t(r_PtxRegister158) == uint32_t(2);				  // PTX L4189
	r_PtxRegister2041 = r_bPtxPredicate329 ? r_PtxRegister164 : r_PtxRegister165; // PTX L4190
L__BB38_180:																	  // PTX L4191
	r_bPtxPredicate330 = uint32_t(r_PtxRegister158) == uint32_t(0);				  // PTX L4192
	r_PtxRegister1714 = r_PtxRegister159 | 16;									  // PTX L4193
	r_PtxRegister2042 =
		ShuffleIdxPredicate(r_bPtxPredicate331, r_PtxRegister1516, r_PtxRegister1714, 31, -1); // PTX L4194
	r_PtxRegister166 =
		ShuffleIdxPredicate(r_bPtxPredicate332, r_PtxRegister1517, r_PtxRegister1714, 31, -1); // PTX L4195
	r_PtxRegister167 =
		ShuffleIdxPredicate(r_bPtxPredicate333, r_PtxRegister1536, r_PtxRegister1714, 31, -1); // PTX L4196
	r_PtxRegister168 =
		ShuffleIdxPredicate(r_bPtxPredicate334, r_PtxRegister1537, r_PtxRegister1714, 31, -1); // PTX L4197
	if (r_bPtxPredicate330)
	{
		goto L__BB38_183;
	} // PTX L4198
	r_bPtxPredicate335 = uint32_t(r_PtxRegister158) == uint32_t(1); // PTX L4199
	r_PtxRegister2042 = uint32_t(r_PtxRegister166);					// PTX L4200
	if (r_bPtxPredicate335)
	{
		goto L__BB38_183;
	} // PTX L4201
	r_bPtxPredicate336 = uint32_t(r_PtxRegister158) == uint32_t(2);				  // PTX L4202
	r_PtxRegister2042 = r_bPtxPredicate336 ? r_PtxRegister167 : r_PtxRegister168; // PTX L4203
L__BB38_183:																	  // PTX L4204
	r_bPtxPredicate337 = uint32_t(r_PtxRegister158) == uint32_t(0);				  // PTX L4205
	r_PtxRegister1715 = r_PtxRegister159 | 20;									  // PTX L4206
	r_PtxRegister2043 =
		ShuffleIdxPredicate(r_bPtxPredicate338, r_PtxRegister1516, r_PtxRegister1715, 31, -1); // PTX L4207
	r_PtxRegister169 =
		ShuffleIdxPredicate(r_bPtxPredicate339, r_PtxRegister1517, r_PtxRegister1715, 31, -1); // PTX L4208
	r_PtxRegister170 =
		ShuffleIdxPredicate(r_bPtxPredicate340, r_PtxRegister1536, r_PtxRegister1715, 31, -1); // PTX L4209
	r_PtxRegister171 =
		ShuffleIdxPredicate(r_bPtxPredicate341, r_PtxRegister1537, r_PtxRegister1715, 31, -1); // PTX L4210
	if (r_bPtxPredicate337)
	{
		goto L__BB38_186;
	} // PTX L4211
	r_bPtxPredicate342 = uint32_t(r_PtxRegister158) == uint32_t(1); // PTX L4212
	r_PtxRegister2043 = uint32_t(r_PtxRegister169);					// PTX L4213
	if (r_bPtxPredicate342)
	{
		goto L__BB38_186;
	} // PTX L4214
	r_bPtxPredicate343 = uint32_t(r_PtxRegister158) == uint32_t(2);				  // PTX L4215
	r_PtxRegister2043 = r_bPtxPredicate343 ? r_PtxRegister170 : r_PtxRegister171; // PTX L4216
L__BB38_186:																	  // PTX L4217
	r_PackedHalf2AtPtx4219R1716 = HalfAdd(r_PtxRegister2040, r_PtxRegister2041);  // PTX L4219
	r_PackedHalf2AtPtx4223R1717 = HalfAdd(r_PtxRegister2042, r_PtxRegister2043);  // PTX L4223
	r_PackedHalf2AtPtx4227R1718 =
		HalfAdd(r_PackedHalf2AtPtx4219R1716, r_PackedHalf2AtPtx4223R1717); // PTX L4227
	r_PackedHalf2AtPtx4231R1833 =
		HalfMul(r_PackedHalf2AtPtx4227R1718, r_PackedHalf2AtPtx3597R1817);		 // PTX L4231
	r_LaneIndexAtPtx4235 = uint32_t((threadIdx.x & 31u));						 // PTX L4235
	r_PtxRegister1720 = ShiftRight(uint32_t(r_LaneIndexAtPtx4235), uint32_t(2)); // PTX L4237
	r_PtxRegister1721 = r_PtxRegister1720 & 2;									 // PTX L4238
	r_PtxRegister1722 = ShiftRight(uint32_t(r_LaneIndexAtPtx4235), uint32_t(4)); // PTX L4239
	r_PtxRegister1723 = r_PtxRegister1722 & 1;									 // PTX L4240
	r_PtxRegister172 = r_PtxRegister1721 | r_PtxRegister1723;					 // PTX L4241
	r_PtxRegister1724 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4235), uint32_t(1));	 // PTX L4242
	r_PtxRegister1725 = r_PtxRegister1724 & 8;									 // PTX L4243
	r_PtxRegister1726 = r_LaneIndexAtPtx4235 & 3;								 // PTX L4244
	r_PtxRegister173 = r_PtxRegister1725 | r_PtxRegister1726;					 // PTX L4245
	r_PtxRegister2044 =
		ShuffleIdxPredicate(r_bPtxPredicate344, r_PtxRegister1560, r_PtxRegister173, 31, -1); // PTX L4246
	r_PtxRegister174 =
		ShuffleIdxPredicate(r_bPtxPredicate345, r_PtxRegister1561, r_PtxRegister173, 31, -1); // PTX L4247
	r_PtxRegister175 =
		ShuffleIdxPredicate(r_bPtxPredicate346, r_PtxRegister1580, r_PtxRegister173, 31, -1); // PTX L4248
	r_PtxRegister176 =
		ShuffleIdxPredicate(r_bPtxPredicate347, r_PtxRegister1581, r_PtxRegister173, 31, -1); // PTX L4249
	r_bPtxPredicate348 = uint32_t(r_PtxRegister172) == uint32_t(0);							  // PTX L4250
	if (r_bPtxPredicate348)
	{
		goto L__BB38_189;
	} // PTX L4251
	r_bPtxPredicate349 = uint32_t(r_PtxRegister172) == uint32_t(1); // PTX L4252
	r_PtxRegister2044 = uint32_t(r_PtxRegister174);					// PTX L4253
	if (r_bPtxPredicate349)
	{
		goto L__BB38_189;
	} // PTX L4254
	r_bPtxPredicate350 = uint32_t(r_PtxRegister172) == uint32_t(2);				  // PTX L4255
	r_PtxRegister2044 = r_bPtxPredicate350 ? r_PtxRegister175 : r_PtxRegister176; // PTX L4256
L__BB38_189:																	  // PTX L4257
	r_bPtxPredicate351 = uint32_t(r_PtxRegister172) == uint32_t(0);				  // PTX L4258
	r_PtxRegister1727 = r_PtxRegister173 | 4;									  // PTX L4259
	r_PtxRegister2045 =
		ShuffleIdxPredicate(r_bPtxPredicate352, r_PtxRegister1560, r_PtxRegister1727, 31, -1); // PTX L4260
	r_PtxRegister177 =
		ShuffleIdxPredicate(r_bPtxPredicate353, r_PtxRegister1561, r_PtxRegister1727, 31, -1); // PTX L4261
	r_PtxRegister178 =
		ShuffleIdxPredicate(r_bPtxPredicate354, r_PtxRegister1580, r_PtxRegister1727, 31, -1); // PTX L4262
	r_PtxRegister179 =
		ShuffleIdxPredicate(r_bPtxPredicate355, r_PtxRegister1581, r_PtxRegister1727, 31, -1); // PTX L4263
	if (r_bPtxPredicate351)
	{
		goto L__BB38_192;
	} // PTX L4264
	r_bPtxPredicate356 = uint32_t(r_PtxRegister172) == uint32_t(1); // PTX L4265
	r_PtxRegister2045 = uint32_t(r_PtxRegister177);					// PTX L4266
	if (r_bPtxPredicate356)
	{
		goto L__BB38_192;
	} // PTX L4267
	r_bPtxPredicate357 = uint32_t(r_PtxRegister172) == uint32_t(2);				  // PTX L4268
	r_PtxRegister2045 = r_bPtxPredicate357 ? r_PtxRegister178 : r_PtxRegister179; // PTX L4269
L__BB38_192:																	  // PTX L4270
	r_bPtxPredicate358 = uint32_t(r_PtxRegister172) == uint32_t(0);				  // PTX L4271
	r_PtxRegister1728 = r_PtxRegister173 | 16;									  // PTX L4272
	r_PtxRegister2046 =
		ShuffleIdxPredicate(r_bPtxPredicate359, r_PtxRegister1560, r_PtxRegister1728, 31, -1); // PTX L4273
	r_PtxRegister180 =
		ShuffleIdxPredicate(r_bPtxPredicate360, r_PtxRegister1561, r_PtxRegister1728, 31, -1); // PTX L4274
	r_PtxRegister181 =
		ShuffleIdxPredicate(r_bPtxPredicate361, r_PtxRegister1580, r_PtxRegister1728, 31, -1); // PTX L4275
	r_PtxRegister182 =
		ShuffleIdxPredicate(r_bPtxPredicate362, r_PtxRegister1581, r_PtxRegister1728, 31, -1); // PTX L4276
	if (r_bPtxPredicate358)
	{
		goto L__BB38_195;
	} // PTX L4277
	r_bPtxPredicate363 = uint32_t(r_PtxRegister172) == uint32_t(1); // PTX L4278
	r_PtxRegister2046 = uint32_t(r_PtxRegister180);					// PTX L4279
	if (r_bPtxPredicate363)
	{
		goto L__BB38_195;
	} // PTX L4280
	r_bPtxPredicate364 = uint32_t(r_PtxRegister172) == uint32_t(2);				  // PTX L4281
	r_PtxRegister2046 = r_bPtxPredicate364 ? r_PtxRegister181 : r_PtxRegister182; // PTX L4282
L__BB38_195:																	  // PTX L4283
	r_bPtxPredicate365 = uint32_t(r_PtxRegister172) == uint32_t(0);				  // PTX L4284
	r_PtxRegister1729 = r_PtxRegister173 | 20;									  // PTX L4285
	r_PtxRegister2047 =
		ShuffleIdxPredicate(r_bPtxPredicate366, r_PtxRegister1560, r_PtxRegister1729, 31, -1); // PTX L4286
	r_PtxRegister183 =
		ShuffleIdxPredicate(r_bPtxPredicate367, r_PtxRegister1561, r_PtxRegister1729, 31, -1); // PTX L4287
	r_PtxRegister184 =
		ShuffleIdxPredicate(r_bPtxPredicate368, r_PtxRegister1580, r_PtxRegister1729, 31, -1); // PTX L4288
	r_PtxRegister185 =
		ShuffleIdxPredicate(r_bPtxPredicate369, r_PtxRegister1581, r_PtxRegister1729, 31, -1); // PTX L4289
	if (r_bPtxPredicate365)
	{
		goto L__BB38_198;
	} // PTX L4290
	r_bPtxPredicate370 = uint32_t(r_PtxRegister172) == uint32_t(1); // PTX L4291
	r_PtxRegister2047 = uint32_t(r_PtxRegister183);					// PTX L4292
	if (r_bPtxPredicate370)
	{
		goto L__BB38_198;
	} // PTX L4293
	r_bPtxPredicate371 = uint32_t(r_PtxRegister172) == uint32_t(2);				  // PTX L4294
	r_PtxRegister2047 = r_bPtxPredicate371 ? r_PtxRegister184 : r_PtxRegister185; // PTX L4295
L__BB38_198:																	  // PTX L4296
	r_PackedHalf2AtPtx4298R1730 = HalfAdd(r_PtxRegister2044, r_PtxRegister2045);  // PTX L4298
	r_PackedHalf2AtPtx4302R1731 = HalfAdd(r_PtxRegister2046, r_PtxRegister2047);  // PTX L4302
	r_PackedHalf2AtPtx4306R1732 =
		HalfAdd(r_PackedHalf2AtPtx4298R1730, r_PackedHalf2AtPtx4302R1731); // PTX L4306
	r_PackedHalf2AtPtx4310R1834 =
		HalfMul(r_PackedHalf2AtPtx4306R1732, r_PackedHalf2AtPtx3597R1817);		 // PTX L4310
	r_LaneIndexAtPtx4314 = uint32_t((threadIdx.x & 31u));						 // PTX L4314
	r_PtxRegister1734 = ShiftRight(uint32_t(r_LaneIndexAtPtx4314), uint32_t(2)); // PTX L4316
	r_PtxRegister1735 = r_PtxRegister1734 & 2;									 // PTX L4317
	r_PtxRegister1736 = ShiftRight(uint32_t(r_LaneIndexAtPtx4314), uint32_t(4)); // PTX L4318
	r_PtxRegister1737 = r_PtxRegister1736 & 1;									 // PTX L4319
	r_PtxRegister186 = r_PtxRegister1735 | r_PtxRegister1737;					 // PTX L4320
	r_PtxRegister1738 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4314), uint32_t(1));	 // PTX L4321
	r_PtxRegister1739 = r_PtxRegister1738 & 8;									 // PTX L4322
	r_PtxRegister1740 = r_LaneIndexAtPtx4314 & 3;								 // PTX L4323
	r_PtxRegister187 = r_PtxRegister1739 | r_PtxRegister1740;					 // PTX L4324
	r_PtxRegister2048 =
		ShuffleIdxPredicate(r_bPtxPredicate372, r_PtxRegister1518, r_PtxRegister187, 31, -1); // PTX L4325
	r_PtxRegister188 =
		ShuffleIdxPredicate(r_bPtxPredicate373, r_PtxRegister1519, r_PtxRegister187, 31, -1); // PTX L4326
	r_PtxRegister189 =
		ShuffleIdxPredicate(r_bPtxPredicate374, r_PtxRegister1538, r_PtxRegister187, 31, -1); // PTX L4327
	r_PtxRegister190 =
		ShuffleIdxPredicate(r_bPtxPredicate375, r_PtxRegister1539, r_PtxRegister187, 31, -1); // PTX L4328
	r_bPtxPredicate376 = uint32_t(r_PtxRegister186) == uint32_t(0);							  // PTX L4329
	if (r_bPtxPredicate376)
	{
		goto L__BB38_201;
	} // PTX L4330
	r_bPtxPredicate377 = uint32_t(r_PtxRegister186) == uint32_t(1); // PTX L4331
	r_PtxRegister2048 = uint32_t(r_PtxRegister188);					// PTX L4332
	if (r_bPtxPredicate377)
	{
		goto L__BB38_201;
	} // PTX L4333
	r_bPtxPredicate378 = uint32_t(r_PtxRegister186) == uint32_t(2);				  // PTX L4334
	r_PtxRegister2048 = r_bPtxPredicate378 ? r_PtxRegister189 : r_PtxRegister190; // PTX L4335
L__BB38_201:																	  // PTX L4336
	r_bPtxPredicate379 = uint32_t(r_PtxRegister186) == uint32_t(0);				  // PTX L4337
	r_PtxRegister1741 = r_PtxRegister187 | 4;									  // PTX L4338
	r_PtxRegister2049 =
		ShuffleIdxPredicate(r_bPtxPredicate380, r_PtxRegister1518, r_PtxRegister1741, 31, -1); // PTX L4339
	r_PtxRegister191 =
		ShuffleIdxPredicate(r_bPtxPredicate381, r_PtxRegister1519, r_PtxRegister1741, 31, -1); // PTX L4340
	r_PtxRegister192 =
		ShuffleIdxPredicate(r_bPtxPredicate382, r_PtxRegister1538, r_PtxRegister1741, 31, -1); // PTX L4341
	r_PtxRegister193 =
		ShuffleIdxPredicate(r_bPtxPredicate383, r_PtxRegister1539, r_PtxRegister1741, 31, -1); // PTX L4342
	if (r_bPtxPredicate379)
	{
		goto L__BB38_204;
	} // PTX L4343
	r_bPtxPredicate384 = uint32_t(r_PtxRegister186) == uint32_t(1); // PTX L4344
	r_PtxRegister2049 = uint32_t(r_PtxRegister191);					// PTX L4345
	if (r_bPtxPredicate384)
	{
		goto L__BB38_204;
	} // PTX L4346
	r_bPtxPredicate385 = uint32_t(r_PtxRegister186) == uint32_t(2);				  // PTX L4347
	r_PtxRegister2049 = r_bPtxPredicate385 ? r_PtxRegister192 : r_PtxRegister193; // PTX L4348
L__BB38_204:																	  // PTX L4349
	r_bPtxPredicate386 = uint32_t(r_PtxRegister186) == uint32_t(0);				  // PTX L4350
	r_PtxRegister1742 = r_PtxRegister187 | 16;									  // PTX L4351
	r_PtxRegister2050 =
		ShuffleIdxPredicate(r_bPtxPredicate387, r_PtxRegister1518, r_PtxRegister1742, 31, -1); // PTX L4352
	r_PtxRegister194 =
		ShuffleIdxPredicate(r_bPtxPredicate388, r_PtxRegister1519, r_PtxRegister1742, 31, -1); // PTX L4353
	r_PtxRegister195 =
		ShuffleIdxPredicate(r_bPtxPredicate389, r_PtxRegister1538, r_PtxRegister1742, 31, -1); // PTX L4354
	r_PtxRegister196 =
		ShuffleIdxPredicate(r_bPtxPredicate390, r_PtxRegister1539, r_PtxRegister1742, 31, -1); // PTX L4355
	if (r_bPtxPredicate386)
	{
		goto L__BB38_207;
	} // PTX L4356
	r_bPtxPredicate391 = uint32_t(r_PtxRegister186) == uint32_t(1); // PTX L4357
	r_PtxRegister2050 = uint32_t(r_PtxRegister194);					// PTX L4358
	if (r_bPtxPredicate391)
	{
		goto L__BB38_207;
	} // PTX L4359
	r_bPtxPredicate392 = uint32_t(r_PtxRegister186) == uint32_t(2);				  // PTX L4360
	r_PtxRegister2050 = r_bPtxPredicate392 ? r_PtxRegister195 : r_PtxRegister196; // PTX L4361
L__BB38_207:																	  // PTX L4362
	r_bPtxPredicate393 = uint32_t(r_PtxRegister186) == uint32_t(0);				  // PTX L4363
	r_PtxRegister1743 = r_PtxRegister187 | 20;									  // PTX L4364
	r_PtxRegister2051 =
		ShuffleIdxPredicate(r_bPtxPredicate394, r_PtxRegister1518, r_PtxRegister1743, 31, -1); // PTX L4365
	r_PtxRegister197 =
		ShuffleIdxPredicate(r_bPtxPredicate395, r_PtxRegister1519, r_PtxRegister1743, 31, -1); // PTX L4366
	r_PtxRegister198 =
		ShuffleIdxPredicate(r_bPtxPredicate396, r_PtxRegister1538, r_PtxRegister1743, 31, -1); // PTX L4367
	r_PtxRegister199 =
		ShuffleIdxPredicate(r_bPtxPredicate397, r_PtxRegister1539, r_PtxRegister1743, 31, -1); // PTX L4368
	if (r_bPtxPredicate393)
	{
		goto L__BB38_210;
	} // PTX L4369
	r_bPtxPredicate398 = uint32_t(r_PtxRegister186) == uint32_t(1); // PTX L4370
	r_PtxRegister2051 = uint32_t(r_PtxRegister197);					// PTX L4371
	if (r_bPtxPredicate398)
	{
		goto L__BB38_210;
	} // PTX L4372
	r_bPtxPredicate399 = uint32_t(r_PtxRegister186) == uint32_t(2);				  // PTX L4373
	r_PtxRegister2051 = r_bPtxPredicate399 ? r_PtxRegister198 : r_PtxRegister199; // PTX L4374
L__BB38_210:																	  // PTX L4375
	r_PackedHalf2AtPtx4377R1744 = HalfAdd(r_PtxRegister2048, r_PtxRegister2049);  // PTX L4377
	r_PackedHalf2AtPtx4381R1745 = HalfAdd(r_PtxRegister2050, r_PtxRegister2051);  // PTX L4381
	r_PackedHalf2AtPtx4385R1746 =
		HalfAdd(r_PackedHalf2AtPtx4377R1744, r_PackedHalf2AtPtx4381R1745); // PTX L4385
	r_PackedHalf2AtPtx4389R1835 =
		HalfMul(r_PackedHalf2AtPtx4385R1746, r_PackedHalf2AtPtx3597R1817);		 // PTX L4389
	r_LaneIndexAtPtx4393 = uint32_t((threadIdx.x & 31u));						 // PTX L4393
	r_PtxRegister1748 = ShiftRight(uint32_t(r_LaneIndexAtPtx4393), uint32_t(2)); // PTX L4395
	r_PtxRegister1749 = r_PtxRegister1748 & 2;									 // PTX L4396
	r_PtxRegister1750 = ShiftRight(uint32_t(r_LaneIndexAtPtx4393), uint32_t(4)); // PTX L4397
	r_PtxRegister1751 = r_PtxRegister1750 & 1;									 // PTX L4398
	r_PtxRegister200 = r_PtxRegister1749 | r_PtxRegister1751;					 // PTX L4399
	r_PtxRegister1752 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4393), uint32_t(1));	 // PTX L4400
	r_PtxRegister1753 = r_PtxRegister1752 & 8;									 // PTX L4401
	r_PtxRegister1754 = r_LaneIndexAtPtx4393 & 3;								 // PTX L4402
	r_PtxRegister201 = r_PtxRegister1753 | r_PtxRegister1754;					 // PTX L4403
	r_PtxRegister2052 =
		ShuffleIdxPredicate(r_bPtxPredicate400, r_PtxRegister1562, r_PtxRegister201, 31, -1); // PTX L4404
	r_PtxRegister202 =
		ShuffleIdxPredicate(r_bPtxPredicate401, r_PtxRegister1563, r_PtxRegister201, 31, -1); // PTX L4405
	r_PtxRegister203 =
		ShuffleIdxPredicate(r_bPtxPredicate402, r_PtxRegister1582, r_PtxRegister201, 31, -1); // PTX L4406
	r_PtxRegister204 =
		ShuffleIdxPredicate(r_bPtxPredicate403, r_PtxRegister1583, r_PtxRegister201, 31, -1); // PTX L4407
	r_bPtxPredicate404 = uint32_t(r_PtxRegister200) == uint32_t(0);							  // PTX L4408
	if (r_bPtxPredicate404)
	{
		goto L__BB38_213;
	} // PTX L4409
	r_bPtxPredicate405 = uint32_t(r_PtxRegister200) == uint32_t(1); // PTX L4410
	r_PtxRegister2052 = uint32_t(r_PtxRegister202);					// PTX L4411
	if (r_bPtxPredicate405)
	{
		goto L__BB38_213;
	} // PTX L4412
	r_bPtxPredicate406 = uint32_t(r_PtxRegister200) == uint32_t(2);				  // PTX L4413
	r_PtxRegister2052 = r_bPtxPredicate406 ? r_PtxRegister203 : r_PtxRegister204; // PTX L4414
L__BB38_213:																	  // PTX L4415
	r_bPtxPredicate407 = uint32_t(r_PtxRegister200) == uint32_t(0);				  // PTX L4416
	r_PtxRegister1755 = r_PtxRegister201 | 4;									  // PTX L4417
	r_PtxRegister2053 =
		ShuffleIdxPredicate(r_bPtxPredicate408, r_PtxRegister1562, r_PtxRegister1755, 31, -1); // PTX L4418
	r_PtxRegister205 =
		ShuffleIdxPredicate(r_bPtxPredicate409, r_PtxRegister1563, r_PtxRegister1755, 31, -1); // PTX L4419
	r_PtxRegister206 =
		ShuffleIdxPredicate(r_bPtxPredicate410, r_PtxRegister1582, r_PtxRegister1755, 31, -1); // PTX L4420
	r_PtxRegister207 =
		ShuffleIdxPredicate(r_bPtxPredicate411, r_PtxRegister1583, r_PtxRegister1755, 31, -1); // PTX L4421
	if (r_bPtxPredicate407)
	{
		goto L__BB38_216;
	} // PTX L4422
	r_bPtxPredicate412 = uint32_t(r_PtxRegister200) == uint32_t(1); // PTX L4423
	r_PtxRegister2053 = uint32_t(r_PtxRegister205);					// PTX L4424
	if (r_bPtxPredicate412)
	{
		goto L__BB38_216;
	} // PTX L4425
	r_bPtxPredicate413 = uint32_t(r_PtxRegister200) == uint32_t(2);				  // PTX L4426
	r_PtxRegister2053 = r_bPtxPredicate413 ? r_PtxRegister206 : r_PtxRegister207; // PTX L4427
L__BB38_216:																	  // PTX L4428
	r_bPtxPredicate414 = uint32_t(r_PtxRegister200) == uint32_t(0);				  // PTX L4429
	r_PtxRegister1756 = r_PtxRegister201 | 16;									  // PTX L4430
	r_PtxRegister2054 =
		ShuffleIdxPredicate(r_bPtxPredicate415, r_PtxRegister1562, r_PtxRegister1756, 31, -1); // PTX L4431
	r_PtxRegister208 =
		ShuffleIdxPredicate(r_bPtxPredicate416, r_PtxRegister1563, r_PtxRegister1756, 31, -1); // PTX L4432
	r_PtxRegister209 =
		ShuffleIdxPredicate(r_bPtxPredicate417, r_PtxRegister1582, r_PtxRegister1756, 31, -1); // PTX L4433
	r_PtxRegister210 =
		ShuffleIdxPredicate(r_bPtxPredicate418, r_PtxRegister1583, r_PtxRegister1756, 31, -1); // PTX L4434
	if (r_bPtxPredicate414)
	{
		goto L__BB38_219;
	} // PTX L4435
	r_bPtxPredicate419 = uint32_t(r_PtxRegister200) == uint32_t(1); // PTX L4436
	r_PtxRegister2054 = uint32_t(r_PtxRegister208);					// PTX L4437
	if (r_bPtxPredicate419)
	{
		goto L__BB38_219;
	} // PTX L4438
	r_bPtxPredicate420 = uint32_t(r_PtxRegister200) == uint32_t(2);				  // PTX L4439
	r_PtxRegister2054 = r_bPtxPredicate420 ? r_PtxRegister209 : r_PtxRegister210; // PTX L4440
L__BB38_219:																	  // PTX L4441
	r_bPtxPredicate421 = uint32_t(r_PtxRegister200) == uint32_t(0);				  // PTX L4442
	r_PtxRegister1757 = r_PtxRegister201 | 20;									  // PTX L4443
	r_PtxRegister2055 =
		ShuffleIdxPredicate(r_bPtxPredicate422, r_PtxRegister1562, r_PtxRegister1757, 31, -1); // PTX L4444
	r_PtxRegister211 =
		ShuffleIdxPredicate(r_bPtxPredicate423, r_PtxRegister1563, r_PtxRegister1757, 31, -1); // PTX L4445
	r_PtxRegister212 =
		ShuffleIdxPredicate(r_bPtxPredicate424, r_PtxRegister1582, r_PtxRegister1757, 31, -1); // PTX L4446
	r_PtxRegister213 =
		ShuffleIdxPredicate(r_bPtxPredicate425, r_PtxRegister1583, r_PtxRegister1757, 31, -1); // PTX L4447
	if (r_bPtxPredicate421)
	{
		goto L__BB38_222;
	} // PTX L4448
	r_bPtxPredicate426 = uint32_t(r_PtxRegister200) == uint32_t(1); // PTX L4449
	r_PtxRegister2055 = uint32_t(r_PtxRegister211);					// PTX L4450
	if (r_bPtxPredicate426)
	{
		goto L__BB38_222;
	} // PTX L4451
	r_bPtxPredicate427 = uint32_t(r_PtxRegister200) == uint32_t(2);				  // PTX L4452
	r_PtxRegister2055 = r_bPtxPredicate427 ? r_PtxRegister212 : r_PtxRegister213; // PTX L4453
L__BB38_222:																	  // PTX L4454
	r_PackedHalf2AtPtx4456R1758 = HalfAdd(r_PtxRegister2052, r_PtxRegister2053);  // PTX L4456
	r_PackedHalf2AtPtx4460R1759 = HalfAdd(r_PtxRegister2054, r_PtxRegister2055);  // PTX L4460
	r_PackedHalf2AtPtx4464R1760 =
		HalfAdd(r_PackedHalf2AtPtx4456R1758, r_PackedHalf2AtPtx4460R1759); // PTX L4464
	r_PackedHalf2AtPtx4468R1836 =
		HalfMul(r_PackedHalf2AtPtx4464R1760, r_PackedHalf2AtPtx3597R1817);		 // PTX L4468
	r_LaneIndexAtPtx4472 = uint32_t((threadIdx.x & 31u));						 // PTX L4472
	r_PtxRegister1762 = ShiftRight(uint32_t(r_LaneIndexAtPtx4472), uint32_t(2)); // PTX L4474
	r_PtxRegister1763 = r_PtxRegister1762 & 2;									 // PTX L4475
	r_PtxRegister1764 = ShiftRight(uint32_t(r_LaneIndexAtPtx4472), uint32_t(4)); // PTX L4476
	r_PtxRegister1765 = r_PtxRegister1764 & 1;									 // PTX L4477
	r_PtxRegister214 = r_PtxRegister1763 | r_PtxRegister1765;					 // PTX L4478
	r_PtxRegister1766 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4472), uint32_t(1));	 // PTX L4479
	r_PtxRegister1767 = r_PtxRegister1766 & 8;									 // PTX L4480
	r_PtxRegister1768 = r_LaneIndexAtPtx4472 & 3;								 // PTX L4481
	r_PtxRegister215 = r_PtxRegister1767 | r_PtxRegister1768;					 // PTX L4482
	r_PtxRegister2056 =
		ShuffleIdxPredicate(r_bPtxPredicate428, r_PtxRegister1521, r_PtxRegister215, 31, -1); // PTX L4483
	r_PtxRegister216 =
		ShuffleIdxPredicate(r_bPtxPredicate429, r_PtxRegister1522, r_PtxRegister215, 31, -1); // PTX L4484
	r_PtxRegister217 =
		ShuffleIdxPredicate(r_bPtxPredicate430, r_PtxRegister1541, r_PtxRegister215, 31, -1); // PTX L4485
	r_PtxRegister218 =
		ShuffleIdxPredicate(r_bPtxPredicate431, r_PtxRegister1542, r_PtxRegister215, 31, -1); // PTX L4486
	r_bPtxPredicate432 = uint32_t(r_PtxRegister214) == uint32_t(0);							  // PTX L4487
	if (r_bPtxPredicate432)
	{
		goto L__BB38_225;
	} // PTX L4488
	r_bPtxPredicate433 = uint32_t(r_PtxRegister214) == uint32_t(1); // PTX L4489
	r_PtxRegister2056 = uint32_t(r_PtxRegister216);					// PTX L4490
	if (r_bPtxPredicate433)
	{
		goto L__BB38_225;
	} // PTX L4491
	r_bPtxPredicate434 = uint32_t(r_PtxRegister214) == uint32_t(2);				  // PTX L4492
	r_PtxRegister2056 = r_bPtxPredicate434 ? r_PtxRegister217 : r_PtxRegister218; // PTX L4493
L__BB38_225:																	  // PTX L4494
	r_bPtxPredicate435 = uint32_t(r_PtxRegister214) == uint32_t(0);				  // PTX L4495
	r_PtxRegister1769 = r_PtxRegister215 | 4;									  // PTX L4496
	r_PtxRegister2057 =
		ShuffleIdxPredicate(r_bPtxPredicate436, r_PtxRegister1521, r_PtxRegister1769, 31, -1); // PTX L4497
	r_PtxRegister219 =
		ShuffleIdxPredicate(r_bPtxPredicate437, r_PtxRegister1522, r_PtxRegister1769, 31, -1); // PTX L4498
	r_PtxRegister220 =
		ShuffleIdxPredicate(r_bPtxPredicate438, r_PtxRegister1541, r_PtxRegister1769, 31, -1); // PTX L4499
	r_PtxRegister221 =
		ShuffleIdxPredicate(r_bPtxPredicate439, r_PtxRegister1542, r_PtxRegister1769, 31, -1); // PTX L4500
	if (r_bPtxPredicate435)
	{
		goto L__BB38_228;
	} // PTX L4501
	r_bPtxPredicate440 = uint32_t(r_PtxRegister214) == uint32_t(1); // PTX L4502
	r_PtxRegister2057 = uint32_t(r_PtxRegister219);					// PTX L4503
	if (r_bPtxPredicate440)
	{
		goto L__BB38_228;
	} // PTX L4504
	r_bPtxPredicate441 = uint32_t(r_PtxRegister214) == uint32_t(2);				  // PTX L4505
	r_PtxRegister2057 = r_bPtxPredicate441 ? r_PtxRegister220 : r_PtxRegister221; // PTX L4506
L__BB38_228:																	  // PTX L4507
	r_bPtxPredicate442 = uint32_t(r_PtxRegister214) == uint32_t(0);				  // PTX L4508
	r_PtxRegister1770 = r_PtxRegister215 | 16;									  // PTX L4509
	r_PtxRegister2058 =
		ShuffleIdxPredicate(r_bPtxPredicate443, r_PtxRegister1521, r_PtxRegister1770, 31, -1); // PTX L4510
	r_PtxRegister222 =
		ShuffleIdxPredicate(r_bPtxPredicate444, r_PtxRegister1522, r_PtxRegister1770, 31, -1); // PTX L4511
	r_PtxRegister223 =
		ShuffleIdxPredicate(r_bPtxPredicate445, r_PtxRegister1541, r_PtxRegister1770, 31, -1); // PTX L4512
	r_PtxRegister224 =
		ShuffleIdxPredicate(r_bPtxPredicate446, r_PtxRegister1542, r_PtxRegister1770, 31, -1); // PTX L4513
	if (r_bPtxPredicate442)
	{
		goto L__BB38_231;
	} // PTX L4514
	r_bPtxPredicate447 = uint32_t(r_PtxRegister214) == uint32_t(1); // PTX L4515
	r_PtxRegister2058 = uint32_t(r_PtxRegister222);					// PTX L4516
	if (r_bPtxPredicate447)
	{
		goto L__BB38_231;
	} // PTX L4517
	r_bPtxPredicate448 = uint32_t(r_PtxRegister214) == uint32_t(2);				  // PTX L4518
	r_PtxRegister2058 = r_bPtxPredicate448 ? r_PtxRegister223 : r_PtxRegister224; // PTX L4519
L__BB38_231:																	  // PTX L4520
	r_bPtxPredicate449 = uint32_t(r_PtxRegister214) == uint32_t(0);				  // PTX L4521
	r_PtxRegister1771 = r_PtxRegister215 | 20;									  // PTX L4522
	r_PtxRegister2059 =
		ShuffleIdxPredicate(r_bPtxPredicate450, r_PtxRegister1521, r_PtxRegister1771, 31, -1); // PTX L4523
	r_PtxRegister225 =
		ShuffleIdxPredicate(r_bPtxPredicate451, r_PtxRegister1522, r_PtxRegister1771, 31, -1); // PTX L4524
	r_PtxRegister226 =
		ShuffleIdxPredicate(r_bPtxPredicate452, r_PtxRegister1541, r_PtxRegister1771, 31, -1); // PTX L4525
	r_PtxRegister227 =
		ShuffleIdxPredicate(r_bPtxPredicate453, r_PtxRegister1542, r_PtxRegister1771, 31, -1); // PTX L4526
	if (r_bPtxPredicate449)
	{
		goto L__BB38_234;
	} // PTX L4527
	r_bPtxPredicate454 = uint32_t(r_PtxRegister214) == uint32_t(1); // PTX L4528
	r_PtxRegister2059 = uint32_t(r_PtxRegister225);					// PTX L4529
	if (r_bPtxPredicate454)
	{
		goto L__BB38_234;
	} // PTX L4530
	r_bPtxPredicate455 = uint32_t(r_PtxRegister214) == uint32_t(2);				  // PTX L4531
	r_PtxRegister2059 = r_bPtxPredicate455 ? r_PtxRegister226 : r_PtxRegister227; // PTX L4532
L__BB38_234:																	  // PTX L4533
	r_PackedHalf2AtPtx4535R1772 = HalfAdd(r_PtxRegister2056, r_PtxRegister2057);  // PTX L4535
	r_PackedHalf2AtPtx4539R1773 = HalfAdd(r_PtxRegister2058, r_PtxRegister2059);  // PTX L4539
	r_PackedHalf2AtPtx4543R1774 =
		HalfAdd(r_PackedHalf2AtPtx4535R1772, r_PackedHalf2AtPtx4539R1773); // PTX L4543
	r_PackedHalf2AtPtx4547R1838 =
		HalfMul(r_PackedHalf2AtPtx4543R1774, r_PackedHalf2AtPtx3597R1817);		 // PTX L4547
	r_LaneIndexAtPtx4551 = uint32_t((threadIdx.x & 31u));						 // PTX L4551
	r_PtxRegister1776 = ShiftRight(uint32_t(r_LaneIndexAtPtx4551), uint32_t(2)); // PTX L4553
	r_PtxRegister1777 = r_PtxRegister1776 & 2;									 // PTX L4554
	r_PtxRegister1778 = ShiftRight(uint32_t(r_LaneIndexAtPtx4551), uint32_t(4)); // PTX L4555
	r_PtxRegister1779 = r_PtxRegister1778 & 1;									 // PTX L4556
	r_PtxRegister228 = r_PtxRegister1777 | r_PtxRegister1779;					 // PTX L4557
	r_PtxRegister1780 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4551), uint32_t(1));	 // PTX L4558
	r_PtxRegister1781 = r_PtxRegister1780 & 8;									 // PTX L4559
	r_PtxRegister1782 = r_LaneIndexAtPtx4551 & 3;								 // PTX L4560
	r_PtxRegister229 = r_PtxRegister1781 | r_PtxRegister1782;					 // PTX L4561
	r_PtxRegister2060 =
		ShuffleIdxPredicate(r_bPtxPredicate456, r_PtxRegister1565, r_PtxRegister229, 31, -1); // PTX L4562
	r_PtxRegister230 =
		ShuffleIdxPredicate(r_bPtxPredicate457, r_PtxRegister1566, r_PtxRegister229, 31, -1); // PTX L4563
	r_PtxRegister231 =
		ShuffleIdxPredicate(r_bPtxPredicate458, r_PtxRegister1585, r_PtxRegister229, 31, -1); // PTX L4564
	r_PtxRegister232 =
		ShuffleIdxPredicate(r_bPtxPredicate459, r_PtxRegister1586, r_PtxRegister229, 31, -1); // PTX L4565
	r_bPtxPredicate460 = uint32_t(r_PtxRegister228) == uint32_t(0);							  // PTX L4566
	if (r_bPtxPredicate460)
	{
		goto L__BB38_237;
	} // PTX L4567
	r_bPtxPredicate461 = uint32_t(r_PtxRegister228) == uint32_t(1); // PTX L4568
	r_PtxRegister2060 = uint32_t(r_PtxRegister230);					// PTX L4569
	if (r_bPtxPredicate461)
	{
		goto L__BB38_237;
	} // PTX L4570
	r_bPtxPredicate462 = uint32_t(r_PtxRegister228) == uint32_t(2);				  // PTX L4571
	r_PtxRegister2060 = r_bPtxPredicate462 ? r_PtxRegister231 : r_PtxRegister232; // PTX L4572
L__BB38_237:																	  // PTX L4573
	r_bPtxPredicate463 = uint32_t(r_PtxRegister228) == uint32_t(0);				  // PTX L4574
	r_PtxRegister1783 = r_PtxRegister229 | 4;									  // PTX L4575
	r_PtxRegister2061 =
		ShuffleIdxPredicate(r_bPtxPredicate464, r_PtxRegister1565, r_PtxRegister1783, 31, -1); // PTX L4576
	r_PtxRegister233 =
		ShuffleIdxPredicate(r_bPtxPredicate465, r_PtxRegister1566, r_PtxRegister1783, 31, -1); // PTX L4577
	r_PtxRegister234 =
		ShuffleIdxPredicate(r_bPtxPredicate466, r_PtxRegister1585, r_PtxRegister1783, 31, -1); // PTX L4578
	r_PtxRegister235 =
		ShuffleIdxPredicate(r_bPtxPredicate467, r_PtxRegister1586, r_PtxRegister1783, 31, -1); // PTX L4579
	if (r_bPtxPredicate463)
	{
		goto L__BB38_240;
	} // PTX L4580
	r_bPtxPredicate468 = uint32_t(r_PtxRegister228) == uint32_t(1); // PTX L4581
	r_PtxRegister2061 = uint32_t(r_PtxRegister233);					// PTX L4582
	if (r_bPtxPredicate468)
	{
		goto L__BB38_240;
	} // PTX L4583
	r_bPtxPredicate469 = uint32_t(r_PtxRegister228) == uint32_t(2);				  // PTX L4584
	r_PtxRegister2061 = r_bPtxPredicate469 ? r_PtxRegister234 : r_PtxRegister235; // PTX L4585
L__BB38_240:																	  // PTX L4586
	r_bPtxPredicate470 = uint32_t(r_PtxRegister228) == uint32_t(0);				  // PTX L4587
	r_PtxRegister1784 = r_PtxRegister229 | 16;									  // PTX L4588
	r_PtxRegister2062 =
		ShuffleIdxPredicate(r_bPtxPredicate471, r_PtxRegister1565, r_PtxRegister1784, 31, -1); // PTX L4589
	r_PtxRegister236 =
		ShuffleIdxPredicate(r_bPtxPredicate472, r_PtxRegister1566, r_PtxRegister1784, 31, -1); // PTX L4590
	r_PtxRegister237 =
		ShuffleIdxPredicate(r_bPtxPredicate473, r_PtxRegister1585, r_PtxRegister1784, 31, -1); // PTX L4591
	r_PtxRegister238 =
		ShuffleIdxPredicate(r_bPtxPredicate474, r_PtxRegister1586, r_PtxRegister1784, 31, -1); // PTX L4592
	if (r_bPtxPredicate470)
	{
		goto L__BB38_243;
	} // PTX L4593
	r_bPtxPredicate475 = uint32_t(r_PtxRegister228) == uint32_t(1); // PTX L4594
	r_PtxRegister2062 = uint32_t(r_PtxRegister236);					// PTX L4595
	if (r_bPtxPredicate475)
	{
		goto L__BB38_243;
	} // PTX L4596
	r_bPtxPredicate476 = uint32_t(r_PtxRegister228) == uint32_t(2);				  // PTX L4597
	r_PtxRegister2062 = r_bPtxPredicate476 ? r_PtxRegister237 : r_PtxRegister238; // PTX L4598
L__BB38_243:																	  // PTX L4599
	r_bPtxPredicate477 = uint32_t(r_PtxRegister228) == uint32_t(0);				  // PTX L4600
	r_PtxRegister1785 = r_PtxRegister229 | 20;									  // PTX L4601
	r_PtxRegister2063 =
		ShuffleIdxPredicate(r_bPtxPredicate478, r_PtxRegister1565, r_PtxRegister1785, 31, -1); // PTX L4602
	r_PtxRegister239 =
		ShuffleIdxPredicate(r_bPtxPredicate479, r_PtxRegister1566, r_PtxRegister1785, 31, -1); // PTX L4603
	r_PtxRegister240 =
		ShuffleIdxPredicate(r_bPtxPredicate480, r_PtxRegister1585, r_PtxRegister1785, 31, -1); // PTX L4604
	r_PtxRegister241 =
		ShuffleIdxPredicate(r_bPtxPredicate481, r_PtxRegister1586, r_PtxRegister1785, 31, -1); // PTX L4605
	if (r_bPtxPredicate477)
	{
		goto L__BB38_246;
	} // PTX L4606
	r_bPtxPredicate482 = uint32_t(r_PtxRegister228) == uint32_t(1); // PTX L4607
	r_PtxRegister2063 = uint32_t(r_PtxRegister239);					// PTX L4608
	if (r_bPtxPredicate482)
	{
		goto L__BB38_246;
	} // PTX L4609
	r_bPtxPredicate483 = uint32_t(r_PtxRegister228) == uint32_t(2);				  // PTX L4610
	r_PtxRegister2063 = r_bPtxPredicate483 ? r_PtxRegister240 : r_PtxRegister241; // PTX L4611
L__BB38_246:																	  // PTX L4612
	r_PackedHalf2AtPtx4614R1786 = HalfAdd(r_PtxRegister2060, r_PtxRegister2061);  // PTX L4614
	r_PackedHalf2AtPtx4618R1787 = HalfAdd(r_PtxRegister2062, r_PtxRegister2063);  // PTX L4618
	r_PackedHalf2AtPtx4622R1788 =
		HalfAdd(r_PackedHalf2AtPtx4614R1786, r_PackedHalf2AtPtx4618R1787); // PTX L4622
	r_PackedHalf2AtPtx4626R1839 =
		HalfMul(r_PackedHalf2AtPtx4622R1788, r_PackedHalf2AtPtx3597R1817);		 // PTX L4626
	r_LaneIndexAtPtx4630 = uint32_t((threadIdx.x & 31u));						 // PTX L4630
	r_PtxRegister1790 = ShiftRight(uint32_t(r_LaneIndexAtPtx4630), uint32_t(2)); // PTX L4632
	r_PtxRegister1791 = r_PtxRegister1790 & 2;									 // PTX L4633
	r_PtxRegister1792 = ShiftRight(uint32_t(r_LaneIndexAtPtx4630), uint32_t(4)); // PTX L4634
	r_PtxRegister1793 = r_PtxRegister1792 & 1;									 // PTX L4635
	r_PtxRegister242 = r_PtxRegister1791 | r_PtxRegister1793;					 // PTX L4636
	r_PtxRegister1794 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4630), uint32_t(1));	 // PTX L4637
	r_PtxRegister1795 = r_PtxRegister1794 & 8;									 // PTX L4638
	r_PtxRegister1796 = r_LaneIndexAtPtx4630 & 3;								 // PTX L4639
	r_PtxRegister243 = r_PtxRegister1795 | r_PtxRegister1796;					 // PTX L4640
	r_PtxRegister2064 =
		ShuffleIdxPredicate(r_bPtxPredicate484, r_PtxRegister1523, r_PtxRegister243, 31, -1); // PTX L4641
	r_PtxRegister244 =
		ShuffleIdxPredicate(r_bPtxPredicate485, r_PtxRegister1524, r_PtxRegister243, 31, -1); // PTX L4642
	r_PtxRegister245 =
		ShuffleIdxPredicate(r_bPtxPredicate486, r_PtxRegister1543, r_PtxRegister243, 31, -1); // PTX L4643
	r_PtxRegister246 =
		ShuffleIdxPredicate(r_bPtxPredicate487, r_PtxRegister1544, r_PtxRegister243, 31, -1); // PTX L4644
	r_bPtxPredicate488 = uint32_t(r_PtxRegister242) == uint32_t(0);							  // PTX L4645
	if (r_bPtxPredicate488)
	{
		goto L__BB38_249;
	} // PTX L4646
	r_bPtxPredicate489 = uint32_t(r_PtxRegister242) == uint32_t(1); // PTX L4647
	r_PtxRegister2064 = uint32_t(r_PtxRegister244);					// PTX L4648
	if (r_bPtxPredicate489)
	{
		goto L__BB38_249;
	} // PTX L4649
	r_bPtxPredicate490 = uint32_t(r_PtxRegister242) == uint32_t(2);				  // PTX L4650
	r_PtxRegister2064 = r_bPtxPredicate490 ? r_PtxRegister245 : r_PtxRegister246; // PTX L4651
L__BB38_249:																	  // PTX L4652
	r_bPtxPredicate491 = uint32_t(r_PtxRegister242) == uint32_t(0);				  // PTX L4653
	r_PtxRegister1797 = r_PtxRegister243 | 4;									  // PTX L4654
	r_PtxRegister2065 =
		ShuffleIdxPredicate(r_bPtxPredicate492, r_PtxRegister1523, r_PtxRegister1797, 31, -1); // PTX L4655
	r_PtxRegister247 =
		ShuffleIdxPredicate(r_bPtxPredicate493, r_PtxRegister1524, r_PtxRegister1797, 31, -1); // PTX L4656
	r_PtxRegister248 =
		ShuffleIdxPredicate(r_bPtxPredicate494, r_PtxRegister1543, r_PtxRegister1797, 31, -1); // PTX L4657
	r_PtxRegister249 =
		ShuffleIdxPredicate(r_bPtxPredicate495, r_PtxRegister1544, r_PtxRegister1797, 31, -1); // PTX L4658
	if (r_bPtxPredicate491)
	{
		goto L__BB38_252;
	} // PTX L4659
	r_bPtxPredicate496 = uint32_t(r_PtxRegister242) == uint32_t(1); // PTX L4660
	r_PtxRegister2065 = uint32_t(r_PtxRegister247);					// PTX L4661
	if (r_bPtxPredicate496)
	{
		goto L__BB38_252;
	} // PTX L4662
	r_bPtxPredicate497 = uint32_t(r_PtxRegister242) == uint32_t(2);				  // PTX L4663
	r_PtxRegister2065 = r_bPtxPredicate497 ? r_PtxRegister248 : r_PtxRegister249; // PTX L4664
L__BB38_252:																	  // PTX L4665
	r_bPtxPredicate498 = uint32_t(r_PtxRegister242) == uint32_t(0);				  // PTX L4666
	r_PtxRegister1798 = r_PtxRegister243 | 16;									  // PTX L4667
	r_PtxRegister2066 =
		ShuffleIdxPredicate(r_bPtxPredicate499, r_PtxRegister1523, r_PtxRegister1798, 31, -1); // PTX L4668
	r_PtxRegister250 =
		ShuffleIdxPredicate(r_bPtxPredicate500, r_PtxRegister1524, r_PtxRegister1798, 31, -1); // PTX L4669
	r_PtxRegister251 =
		ShuffleIdxPredicate(r_bPtxPredicate501, r_PtxRegister1543, r_PtxRegister1798, 31, -1); // PTX L4670
	r_PtxRegister252 =
		ShuffleIdxPredicate(r_bPtxPredicate502, r_PtxRegister1544, r_PtxRegister1798, 31, -1); // PTX L4671
	if (r_bPtxPredicate498)
	{
		goto L__BB38_255;
	} // PTX L4672
	r_bPtxPredicate503 = uint32_t(r_PtxRegister242) == uint32_t(1); // PTX L4673
	r_PtxRegister2066 = uint32_t(r_PtxRegister250);					// PTX L4674
	if (r_bPtxPredicate503)
	{
		goto L__BB38_255;
	} // PTX L4675
	r_bPtxPredicate504 = uint32_t(r_PtxRegister242) == uint32_t(2);				  // PTX L4676
	r_PtxRegister2066 = r_bPtxPredicate504 ? r_PtxRegister251 : r_PtxRegister252; // PTX L4677
L__BB38_255:																	  // PTX L4678
	r_bPtxPredicate505 = uint32_t(r_PtxRegister242) == uint32_t(0);				  // PTX L4679
	r_PtxRegister1799 = r_PtxRegister243 | 20;									  // PTX L4680
	r_PtxRegister2067 =
		ShuffleIdxPredicate(r_bPtxPredicate506, r_PtxRegister1523, r_PtxRegister1799, 31, -1); // PTX L4681
	r_PtxRegister253 =
		ShuffleIdxPredicate(r_bPtxPredicate507, r_PtxRegister1524, r_PtxRegister1799, 31, -1); // PTX L4682
	r_PtxRegister254 =
		ShuffleIdxPredicate(r_bPtxPredicate508, r_PtxRegister1543, r_PtxRegister1799, 31, -1); // PTX L4683
	r_PtxRegister255 =
		ShuffleIdxPredicate(r_bPtxPredicate509, r_PtxRegister1544, r_PtxRegister1799, 31, -1); // PTX L4684
	if (r_bPtxPredicate505)
	{
		goto L__BB38_258;
	} // PTX L4685
	r_bPtxPredicate510 = uint32_t(r_PtxRegister242) == uint32_t(1); // PTX L4686
	r_PtxRegister2067 = uint32_t(r_PtxRegister253);					// PTX L4687
	if (r_bPtxPredicate510)
	{
		goto L__BB38_258;
	} // PTX L4688
	r_bPtxPredicate511 = uint32_t(r_PtxRegister242) == uint32_t(2);				  // PTX L4689
	r_PtxRegister2067 = r_bPtxPredicate511 ? r_PtxRegister254 : r_PtxRegister255; // PTX L4690
L__BB38_258:																	  // PTX L4691
	r_PackedHalf2AtPtx4693R1800 = HalfAdd(r_PtxRegister2064, r_PtxRegister2065);  // PTX L4693
	r_PackedHalf2AtPtx4697R1801 = HalfAdd(r_PtxRegister2066, r_PtxRegister2067);  // PTX L4697
	r_PackedHalf2AtPtx4701R1802 =
		HalfAdd(r_PackedHalf2AtPtx4693R1800, r_PackedHalf2AtPtx4697R1801); // PTX L4701
	r_PackedHalf2AtPtx4705R1840 =
		HalfMul(r_PackedHalf2AtPtx4701R1802, r_PackedHalf2AtPtx3597R1817);		 // PTX L4705
	r_LaneIndexAtPtx4709 = uint32_t((threadIdx.x & 31u));						 // PTX L4709
	r_PtxRegister1804 = ShiftRight(uint32_t(r_LaneIndexAtPtx4709), uint32_t(2)); // PTX L4711
	r_PtxRegister1805 = r_PtxRegister1804 & 2;									 // PTX L4712
	r_PtxRegister1806 = ShiftRight(uint32_t(r_LaneIndexAtPtx4709), uint32_t(4)); // PTX L4713
	r_PtxRegister1807 = r_PtxRegister1806 & 1;									 // PTX L4714
	r_PtxRegister256 = r_PtxRegister1805 | r_PtxRegister1807;					 // PTX L4715
	r_PtxRegister1808 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4709), uint32_t(1));	 // PTX L4716
	r_PtxRegister1809 = r_PtxRegister1808 & 8;									 // PTX L4717
	r_PtxRegister1810 = r_LaneIndexAtPtx4709 & 3;								 // PTX L4718
	r_PtxRegister257 = r_PtxRegister1809 | r_PtxRegister1810;					 // PTX L4719
	r_PtxRegister2068 =
		ShuffleIdxPredicate(r_bPtxPredicate512, r_PtxRegister1567, r_PtxRegister257, 31, -1); // PTX L4720
	r_PtxRegister258 =
		ShuffleIdxPredicate(r_bPtxPredicate513, r_PtxRegister1568, r_PtxRegister257, 31, -1); // PTX L4721
	r_PtxRegister259 =
		ShuffleIdxPredicate(r_bPtxPredicate514, r_PtxRegister1587, r_PtxRegister257, 31, -1); // PTX L4722
	r_PtxRegister260 =
		ShuffleIdxPredicate(r_bPtxPredicate515, r_PtxRegister1588, r_PtxRegister257, 31, -1); // PTX L4723
	r_bPtxPredicate516 = uint32_t(r_PtxRegister256) == uint32_t(0);							  // PTX L4724
	if (r_bPtxPredicate516)
	{
		goto L__BB38_261;
	} // PTX L4725
	r_bPtxPredicate517 = uint32_t(r_PtxRegister256) == uint32_t(1); // PTX L4726
	r_PtxRegister2068 = uint32_t(r_PtxRegister258);					// PTX L4727
	if (r_bPtxPredicate517)
	{
		goto L__BB38_261;
	} // PTX L4728
	r_bPtxPredicate518 = uint32_t(r_PtxRegister256) == uint32_t(2);				  // PTX L4729
	r_PtxRegister2068 = r_bPtxPredicate518 ? r_PtxRegister259 : r_PtxRegister260; // PTX L4730
L__BB38_261:																	  // PTX L4731
	r_bPtxPredicate519 = uint32_t(r_PtxRegister256) == uint32_t(0);				  // PTX L4732
	r_PtxRegister1811 = r_PtxRegister257 | 4;									  // PTX L4733
	r_PtxRegister2069 =
		ShuffleIdxPredicate(r_bPtxPredicate520, r_PtxRegister1567, r_PtxRegister1811, 31, -1); // PTX L4734
	r_PtxRegister261 =
		ShuffleIdxPredicate(r_bPtxPredicate521, r_PtxRegister1568, r_PtxRegister1811, 31, -1); // PTX L4735
	r_PtxRegister262 =
		ShuffleIdxPredicate(r_bPtxPredicate522, r_PtxRegister1587, r_PtxRegister1811, 31, -1); // PTX L4736
	r_PtxRegister263 =
		ShuffleIdxPredicate(r_bPtxPredicate523, r_PtxRegister1588, r_PtxRegister1811, 31, -1); // PTX L4737
	if (r_bPtxPredicate519)
	{
		goto L__BB38_264;
	} // PTX L4738
	r_bPtxPredicate524 = uint32_t(r_PtxRegister256) == uint32_t(1); // PTX L4739
	r_PtxRegister2069 = uint32_t(r_PtxRegister261);					// PTX L4740
	if (r_bPtxPredicate524)
	{
		goto L__BB38_264;
	} // PTX L4741
	r_bPtxPredicate525 = uint32_t(r_PtxRegister256) == uint32_t(2);				  // PTX L4742
	r_PtxRegister2069 = r_bPtxPredicate525 ? r_PtxRegister262 : r_PtxRegister263; // PTX L4743
L__BB38_264:																	  // PTX L4744
	r_bPtxPredicate526 = uint32_t(r_PtxRegister256) == uint32_t(0);				  // PTX L4745
	r_PtxRegister1812 = r_PtxRegister257 | 16;									  // PTX L4746
	r_PtxRegister2070 =
		ShuffleIdxPredicate(r_bPtxPredicate527, r_PtxRegister1567, r_PtxRegister1812, 31, -1); // PTX L4747
	r_PtxRegister264 =
		ShuffleIdxPredicate(r_bPtxPredicate528, r_PtxRegister1568, r_PtxRegister1812, 31, -1); // PTX L4748
	r_PtxRegister265 =
		ShuffleIdxPredicate(r_bPtxPredicate529, r_PtxRegister1587, r_PtxRegister1812, 31, -1); // PTX L4749
	r_PtxRegister266 =
		ShuffleIdxPredicate(r_bPtxPredicate530, r_PtxRegister1588, r_PtxRegister1812, 31, -1); // PTX L4750
	if (r_bPtxPredicate526)
	{
		goto L__BB38_267;
	} // PTX L4751
	r_bPtxPredicate531 = uint32_t(r_PtxRegister256) == uint32_t(1); // PTX L4752
	r_PtxRegister2070 = uint32_t(r_PtxRegister264);					// PTX L4753
	if (r_bPtxPredicate531)
	{
		goto L__BB38_267;
	} // PTX L4754
	r_bPtxPredicate532 = uint32_t(r_PtxRegister256) == uint32_t(2);				  // PTX L4755
	r_PtxRegister2070 = r_bPtxPredicate532 ? r_PtxRegister265 : r_PtxRegister266; // PTX L4756
L__BB38_267:																	  // PTX L4757
	r_bPtxPredicate533 = uint32_t(r_PtxRegister256) == uint32_t(0);				  // PTX L4758
	r_PtxRegister1813 = r_PtxRegister257 | 20;									  // PTX L4759
	r_PtxRegister2071 =
		ShuffleIdxPredicate(r_bPtxPredicate534, r_PtxRegister1567, r_PtxRegister1813, 31, -1); // PTX L4760
	r_PtxRegister267 =
		ShuffleIdxPredicate(r_bPtxPredicate535, r_PtxRegister1568, r_PtxRegister1813, 31, -1); // PTX L4761
	r_PtxRegister268 =
		ShuffleIdxPredicate(r_bPtxPredicate536, r_PtxRegister1587, r_PtxRegister1813, 31, -1); // PTX L4762
	r_PtxRegister269 =
		ShuffleIdxPredicate(r_bPtxPredicate537, r_PtxRegister1588, r_PtxRegister1813, 31, -1); // PTX L4763
	if (r_bPtxPredicate533)
	{
		goto L__BB38_270;
	} // PTX L4764
	r_bPtxPredicate538 = uint32_t(r_PtxRegister256) == uint32_t(1); // PTX L4765
	r_PtxRegister2071 = uint32_t(r_PtxRegister267);					// PTX L4766
	if (r_bPtxPredicate538)
	{
		goto L__BB38_270;
	} // PTX L4767
	r_bPtxPredicate539 = uint32_t(r_PtxRegister256) == uint32_t(2);				  // PTX L4768
	r_PtxRegister2071 = r_bPtxPredicate539 ? r_PtxRegister268 : r_PtxRegister269; // PTX L4769
L__BB38_270:																	  // PTX L4770
	r_PackedHalf2AtPtx4772R1814 = HalfAdd(r_PtxRegister2068, r_PtxRegister2069);  // PTX L4772
	r_PackedHalf2AtPtx4776R1815 = HalfAdd(r_PtxRegister2070, r_PtxRegister2071);  // PTX L4776
	r_PackedHalf2AtPtx4780R1816 =
		HalfAdd(r_PackedHalf2AtPtx4772R1814, r_PackedHalf2AtPtx4776R1815); // PTX L4780
	r_PackedHalf2AtPtx4784R1841 =
		HalfMul(r_PackedHalf2AtPtx4780R1816, r_PackedHalf2AtPtx3597R1817);		   // PTX L4784
	r_PtxRegister1818 = ShiftRightSigned(int32_t(r_Scalar72Bits), uint32_t(31));   // PTX L4787
	r_PtxRegister1819 = ShiftRight(uint32_t(r_PtxRegister1818), uint32_t(30));	   // PTX L4788
	r_PtxRegister1820 = uint32_t(r_Scalar72Bits) + uint32_t(r_PtxRegister1819);	   // PTX L4789
	r_PtxRegister1821 = ShiftRightSigned(int32_t(r_PtxRegister1820), uint32_t(2)); // PTX L4790
	r_bPtxPredicate540 = int32_t(r_CtaY) >= int32_t(r_PtxRegister1821);			   // PTX L4791
	r_bPtxPredicate541 = int32_t(r_PtxRegister2) >= int32_t(r_PtxRegister45);	   // PTX L4792
	r_bPtxPredicate542 = r_bPtxPredicate540 | r_bPtxPredicate541;				   // PTX L4793
	if (r_bPtxPredicate542)
	{
		goto L__BB38_272;
	} // PTX L4794
	r_PtxRegister1842 = uint32_t(r_CtaY) * uint32_t(r_PtxRegister45) + uint32_t(r_PtxRegister2); // PTX L4795
	r_PtxRegister1843 = ShiftLeft(uint32_t(r_PtxRegister1842), uint32_t(12));					 // PTX L4796
	r_PtxRegister1844 = uint32_t(r_PtxRegister1843) + uint32_t(r_PtxRegister10);				 // PTX L4797
	r_PtxU64Register316 = uint64_t(int64_t(int32_t(r_PtxRegister1844)) * int64_t(int32_t(4)));	 // PTX L4798
	r_PtxU64Register317 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register316);			 // PTX L4799
	r_LaneIndexAtPtx4801 = uint32_t((threadIdx.x & 31u));										 // PTX L4801
	r_PtxU64Register318 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4801)) * int64_t(int32_t(16)));		 // PTX L4803
	r_PtxU64Register312 = uint64_t(r_PtxU64Register317) + uint64_t(r_PtxU64Register318); // PTX L4804
	StoreNoAllocate(r_PtxU64Register312, make_uint4(r_PackedHalf2AtPtx3599R1823, r_PackedHalf2AtPtx3678R1824,
													r_PackedHalf2AtPtx3757R1825,
													r_PackedHalf2AtPtx3836R1826)); // PTX L4806
	r_LaneIndexAtPtx4809 = uint32_t((threadIdx.x & 31u));						   // PTX L4809
	r_PtxU64Register319 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4809)) * int64_t(int32_t(16)));		 // PTX L4811
	r_PtxU64Register320 = uint64_t(r_PtxU64Register317) + uint64_t(r_PtxU64Register319); // PTX L4812
	r_PtxU64Register313 = uint64_t(r_PtxU64Register320) + uint64_t(512);				 // PTX L4813
	StoreNoAllocate(r_PtxU64Register313, make_uint4(r_PackedHalf2AtPtx3915R1828, r_PackedHalf2AtPtx3994R1829,
													r_PackedHalf2AtPtx4073R1830,
													r_PackedHalf2AtPtx4152R1831)); // PTX L4815
	r_LaneIndexAtPtx4818 = uint32_t((threadIdx.x & 31u));						   // PTX L4818
	r_PtxU64Register321 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4818)) * int64_t(int32_t(16)));		 // PTX L4820
	r_PtxU64Register322 = uint64_t(r_PtxU64Register317) + uint64_t(r_PtxU64Register321); // PTX L4821
	r_PtxU64Register314 = uint64_t(r_PtxU64Register322) + uint64_t(1024);				 // PTX L4822
	StoreNoAllocate(r_PtxU64Register314, make_uint4(r_PackedHalf2AtPtx4231R1833, r_PackedHalf2AtPtx4310R1834,
													r_PackedHalf2AtPtx4389R1835,
													r_PackedHalf2AtPtx4468R1836)); // PTX L4824
	r_LaneIndexAtPtx4827 = uint32_t((threadIdx.x & 31u));						   // PTX L4827
	r_PtxU64Register323 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4827)) * int64_t(int32_t(16)));		 // PTX L4829
	r_PtxU64Register324 = uint64_t(r_PtxU64Register317) + uint64_t(r_PtxU64Register323); // PTX L4830
	r_PtxU64Register315 = uint64_t(r_PtxU64Register324) + uint64_t(1536);				 // PTX L4831
	StoreNoAllocate(r_PtxU64Register315, make_uint4(r_PackedHalf2AtPtx4547R1838, r_PackedHalf2AtPtx4626R1839,
													r_PackedHalf2AtPtx4705R1840,
													r_PackedHalf2AtPtx4784R1841)); // PTX L4833
L__BB38_272:																	   // PTX L4835
	return;																		   // PTX L4836
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
