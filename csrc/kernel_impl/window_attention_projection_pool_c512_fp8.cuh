// Readable equivalent of cc_split_swin_16h_proj_pool_512_fp8; not historical source.
#pragma once
#include "window_attention_projection_pool_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
{
__global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp8(Parameters r_Parameters)
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
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx213Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx291Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx362Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx399Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx441Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx478Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx531Rs14, r_PtxU16Register15,
		r_ConvertedE4PairAtPtx568Rs16, r_PtxU16Register17, r_ConvertedE4PairAtPtx609Rs18, r_PtxU16Register19,
		r_ConvertedE4PairAtPtx646Rs20, r_PtxU16Register21, r_PtxU16Register22, r_PtxU16Register23,
		r_PtxU16Register24;
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
		r_PtxU16Register65, r_PtxU16Register66, r_PtxU16Register67, r_PtxU16Register68, r_PtxU16Register69,
		r_PtxU16Register70, r_PtxU16Register71, r_PtxU16Register72;
	uint16_t r_PtxU16Register73, r_PtxU16Register74, r_PtxU16Register75, r_PtxU16Register76,
		r_PtxU16Register77, r_PtxU16Register78, r_PtxU16Register79, r_PtxU16Register80, r_PtxU16Register81,
		r_PtxU16Register82, r_PtxU16Register83, r_PtxU16Register84;
	uint16_t r_PtxU16Register85, r_ConvertedE4PairAtPtx2848Rs86, r_PtxU16Register87,
		r_ConvertedE4PairAtPtx2923Rs88, r_ConvertedE4PairAtPtx3551Rs89, r_ConvertedE4PairAtPtx3554Rs90,
		r_ConvertedE4PairAtPtx3557Rs91, r_ConvertedE4PairAtPtx3560Rs92, r_ConvertedE4PairAtPtx3563Rs93,
		r_ConvertedE4PairAtPtx3566Rs94, r_ConvertedE4PairAtPtx3569Rs95, r_ConvertedE4PairAtPtx3572Rs96;
	uint16_t r_ConvertedE4PairAtPtx3575Rs97, r_ConvertedE4PairAtPtx3578Rs98, r_ConvertedE4PairAtPtx3581Rs99,
		r_ConvertedE4PairAtPtx3584Rs100, r_ConvertedE4PairAtPtx3587Rs101, r_ConvertedE4PairAtPtx3590Rs102,
		r_ConvertedE4PairAtPtx3593Rs103, r_ConvertedE4PairAtPtx3596Rs104, r_ConvertedE4PairAtPtx3599Rs105,
		r_ConvertedE4PairAtPtx3602Rs106, r_ConvertedE4PairAtPtx3605Rs107, r_ConvertedE4PairAtPtx3608Rs108;
	uint16_t r_ConvertedE4PairAtPtx3611Rs109, r_ConvertedE4PairAtPtx3614Rs110,
		r_ConvertedE4PairAtPtx3617Rs111, r_ConvertedE4PairAtPtx3620Rs112, r_ConvertedE4PairAtPtx3623Rs113,
		r_ConvertedE4PairAtPtx3626Rs114, r_ConvertedE4PairAtPtx3629Rs115, r_ConvertedE4PairAtPtx3632Rs116,
		r_ConvertedE4PairAtPtx3635Rs117, r_ConvertedE4PairAtPtx3638Rs118, r_ConvertedE4PairAtPtx3641Rs119,
		r_ConvertedE4PairAtPtx3644Rs120;
	uint16_t r_ConvertedE4PairAtPtx3647Rs121, r_ConvertedE4PairAtPtx3650Rs122,
		r_ConvertedE4PairAtPtx3653Rs123, r_ConvertedE4PairAtPtx3656Rs124, r_ConvertedE4PairAtPtx3659Rs125,
		r_ConvertedE4PairAtPtx3662Rs126, r_ConvertedE4PairAtPtx3665Rs127, r_ConvertedE4PairAtPtx3668Rs128,
		r_ConvertedE4PairAtPtx3671Rs129, r_ConvertedE4PairAtPtx3674Rs130, r_ConvertedE4PairAtPtx3677Rs131,
		r_ConvertedE4PairAtPtx3680Rs132;
	uint16_t r_ConvertedE4PairAtPtx3683Rs133, r_ConvertedE4PairAtPtx3686Rs134,
		r_ConvertedE4PairAtPtx3689Rs135, r_ConvertedE4PairAtPtx3692Rs136, r_ConvertedE4PairAtPtx3695Rs137,
		r_ConvertedE4PairAtPtx3698Rs138, r_ConvertedE4PairAtPtx3701Rs139, r_ConvertedE4PairAtPtx3704Rs140,
		r_ConvertedE4PairAtPtx3707Rs141, r_ConvertedE4PairAtPtx3710Rs142, r_ConvertedE4PairAtPtx3713Rs143,
		r_ConvertedE4PairAtPtx3716Rs144;
	uint16_t r_ConvertedE4PairAtPtx3719Rs145, r_ConvertedE4PairAtPtx3722Rs146,
		r_ConvertedE4PairAtPtx3725Rs147, r_ConvertedE4PairAtPtx3728Rs148, r_ConvertedE4PairAtPtx3731Rs149,
		r_ConvertedE4PairAtPtx3734Rs150, r_ConvertedE4PairAtPtx3737Rs151, r_ConvertedE4PairAtPtx3740Rs152,
		r_PtxU16Register153, r_ConvertedE4PairAtPtx5152Rs154, r_ConvertedE4PairAtPtx5155Rs155,
		r_ConvertedE4PairAtPtx5158Rs156;
	uint16_t r_ConvertedE4PairAtPtx5161Rs157, r_ConvertedE4PairAtPtx5164Rs158,
		r_ConvertedE4PairAtPtx5167Rs159, r_ConvertedE4PairAtPtx5170Rs160, r_ConvertedE4PairAtPtx5173Rs161,
		r_ConvertedE4PairAtPtx5176Rs162, r_ConvertedE4PairAtPtx5179Rs163, r_ConvertedE4PairAtPtx5182Rs164,
		r_ConvertedE4PairAtPtx5185Rs165, r_ConvertedE4PairAtPtx5188Rs166, r_ConvertedE4PairAtPtx5191Rs167,
		r_ConvertedE4PairAtPtx5194Rs168;
	uint16_t r_ConvertedE4PairAtPtx5197Rs169;
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
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PtxRegister301, r_PtxRegister302, r_PtxRegister303, r_PtxRegister304, r_PtxRegister305,
		r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309, r_PtxRegister310,
		r_PtxRegister311, r_PtxRegister312;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316, r_PtxRegister317,
		r_PtxRegister318, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321, r_PtxRegister322,
		r_PtxRegister323, r_PtxRegister324;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PtxRegister331, r_Scalar64Bits, r_Scalar68Bits, r_Scalar72Bits, r_Scalar76Bits,
		r_CtaX;
	uint32_t r_CtaY, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341, r_PtxRegister342,
		r_PtxRegister343, r_PtxRegister344, r_PtxRegister345, r_PtxRegister346, r_PtxRegister347,
		r_PtxRegister348;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_ThreadX, r_PtxRegister352, r_PtxRegister353,
		r_PtxRegister354, r_PtxRegister355, r_BlockSizeX, r_BlockSizeY, r_LaneIndexAtPtx70,
		r_LaneIndexAtPtx78, r_LaneIndexAtPtx88;
	uint32_t r_LaneIndexAtPtx97, r_LaneIndexAtPtx106, r_LaneIndexAtPtx115, r_LaneIndexAtPtx124,
		r_LaneIndexAtPtx133, r_PtxRegister366, r_PtxRegister367, r_PtxRegister368, r_PtxRegister369,
		r_PtxRegister370, r_PtxRegister371, r_PtxRegister372;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_PtxRegister375, r_PtxRegister376, r_PtxRegister377,
		r_PtxRegister378, r_PtxRegister379, r_PtxRegister380, r_PtxRegister381, r_PtxRegister382,
		r_PtxRegister383, r_PtxRegister384;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_PackedHalf2AtPtx211R387, r_LaneIndexAtPtx217,
		r_PtxRegister389, r_PackedE4WordAtPtx215R390, r_PtxRegister391, r_PtxRegister392, r_PtxRegister393,
		r_PtxRegister394, r_PtxRegister395, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_PtxRegister398, r_PtxRegister399, r_PtxRegister400, r_PtxRegister401,
		r_PtxRegister402, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405, r_PtxRegister406,
		r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_PackedHalf2AtPtx289R410, r_LaneIndexAtPtx295, r_PtxRegister412,
		r_PackedE4WordAtPtx293R413, r_PtxRegister414, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417,
		r_PtxRegister418, r_PtxRegister419, r_PtxRegister420;
	uint32_t r_PtxRegister421, r_PtxRegister422, r_PtxRegister423, r_PackedHalf2AtPtx360R424,
		r_LaneIndexAtPtx346, r_PtxRegister426, r_PtxRegister427, r_PtxRegister428, r_PtxRegister429,
		r_PtxRegister430, r_PackedHalf2AtPtx397R431, r_LaneIndexAtPtx383;
	uint32_t r_PtxRegister433, r_PtxRegister434, r_PtxRegister435, r_PtxRegister436, r_PtxRegister437,
		r_PackedHalf2AtPtx439R438, r_LaneIndexAtPtx425, r_PtxRegister440, r_PtxRegister441, r_PtxRegister442,
		r_PtxRegister443, r_PtxRegister444;
	uint32_t r_PackedHalf2AtPtx476R445, r_LaneIndexAtPtx462, r_PtxRegister447, r_PtxRegister448,
		r_PtxRegister449, r_PtxRegister450, r_PtxRegister451, r_PtxRegister452, r_PtxRegister453,
		r_PackedHalf2AtPtx529R454, r_LaneIndexAtPtx515, r_PtxRegister456;
	uint32_t r_PtxRegister457, r_PtxRegister458, r_PtxRegister459, r_PtxRegister460,
		r_PackedHalf2AtPtx566R461, r_LaneIndexAtPtx552, r_PtxRegister463, r_PtxRegister464, r_PtxRegister465,
		r_PtxRegister466, r_PtxRegister467, r_PackedHalf2AtPtx607R468;
	uint32_t r_LaneIndexAtPtx593, r_PtxRegister470, r_PtxRegister471, r_PtxRegister472, r_PtxRegister473,
		r_PtxRegister474, r_PackedHalf2AtPtx644R475, r_LaneIndexAtPtx630, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx853, r_LaneIndexAtPtx867, r_LaneIndexAtPtx881, r_LaneIndexAtPtx895,
		r_LaneIndexAtPtx909, r_LaneIndexAtPtx923, r_LaneIndexAtPtx937, r_LaneIndexAtPtx954,
		r_LaneIndexAtPtx970, r_LaneIndexAtPtx985, r_LaneIndexAtPtx999, r_LaneIndexAtPtx1016;
	uint32_t r_LaneIndexAtPtx1032, r_LaneIndexAtPtx1047, r_LaneIndexAtPtx1061, r_LaneIndexAtPtx1078,
		r_LaneIndexAtPtx1094, r_LaneIndexAtPtx1108, r_LaneIndexAtPtx1122, r_LaneIndexAtPtx1136,
		r_LaneIndexAtPtx1150, r_LaneIndexAtPtx1164, r_LaneIndexAtPtx1178, r_LaneIndexAtPtx1194;
	uint32_t r_LaneIndexAtPtx1210, r_LaneIndexAtPtx1224, r_LaneIndexAtPtx1238, r_LaneIndexAtPtx1254,
		r_LaneIndexAtPtx1270, r_LaneIndexAtPtx1284, r_LaneIndexAtPtx1298, r_LaneIndexAtPtx1314,
		r_LaneIndexAtPtx1330, r_LaneIndexAtPtx1344, r_LaneIndexAtPtx1358, r_LaneIndexAtPtx1372;
	uint32_t r_LaneIndexAtPtx1386, r_LaneIndexAtPtx1400, r_LaneIndexAtPtx1414, r_LaneIndexAtPtx1430,
		r_LaneIndexAtPtx1446, r_LaneIndexAtPtx1460, r_LaneIndexAtPtx1474, r_LaneIndexAtPtx1490,
		r_LaneIndexAtPtx1506, r_LaneIndexAtPtx1520, r_LaneIndexAtPtx1534, r_LaneIndexAtPtx1550;
	uint32_t r_LaneIndexAtPtx1566, r_LaneIndexAtPtx1580, r_LaneIndexAtPtx1594, r_LaneIndexAtPtx1608,
		r_LaneIndexAtPtx1622, r_LaneIndexAtPtx1636, r_LaneIndexAtPtx1650, r_LaneIndexAtPtx1666,
		r_LaneIndexAtPtx1682, r_LaneIndexAtPtx1696, r_LaneIndexAtPtx1710, r_LaneIndexAtPtx1726;
	uint32_t r_LaneIndexAtPtx1742, r_LaneIndexAtPtx1756, r_LaneIndexAtPtx1770, r_LaneIndexAtPtx1786,
		r_LaneIndexAtPtx1802, r_PackedHalf2AtPtx654R546, r_PtxRegister547, r_LaneIndexAtPtx1809,
		r_PackedHalf2AtPtx660R549, r_PtxRegister550, r_LaneIndexAtPtx1816, r_PackedHalf2AtPtx657R552;
	uint32_t r_PtxRegister553, r_LaneIndexAtPtx1823, r_PackedHalf2AtPtx663R555, r_PtxRegister556,
		r_LaneIndexAtPtx1830, r_PackedHalf2AtPtx666R558, r_PtxRegister559, r_LaneIndexAtPtx1837,
		r_PackedHalf2AtPtx672R561, r_PtxRegister562, r_LaneIndexAtPtx1844, r_PackedHalf2AtPtx669R564;
	uint32_t r_PtxRegister565, r_LaneIndexAtPtx1851, r_PackedHalf2AtPtx675R567, r_PtxRegister568,
		r_LaneIndexAtPtx1858, r_PackedHalf2AtPtx678R570, r_PtxRegister571, r_LaneIndexAtPtx1865,
		r_PackedHalf2AtPtx684R573, r_PtxRegister574, r_LaneIndexAtPtx1872, r_PackedHalf2AtPtx681R576;
	uint32_t r_PtxRegister577, r_LaneIndexAtPtx1879, r_PackedHalf2AtPtx687R579, r_PtxRegister580,
		r_LaneIndexAtPtx1886, r_PackedHalf2AtPtx690R582, r_PtxRegister583, r_LaneIndexAtPtx1893,
		r_PackedHalf2AtPtx696R585, r_PtxRegister586, r_LaneIndexAtPtx1900, r_PackedHalf2AtPtx693R588;
	uint32_t r_PtxRegister589, r_LaneIndexAtPtx1907, r_PackedHalf2AtPtx699R591, r_PtxRegister592,
		r_LaneIndexAtPtx1914, r_PackedHalf2AtPtx702R594, r_PtxRegister595, r_LaneIndexAtPtx1921,
		r_PackedHalf2AtPtx708R597, r_PtxRegister598, r_LaneIndexAtPtx1928, r_PackedHalf2AtPtx705R600;
	uint32_t r_PtxRegister601, r_LaneIndexAtPtx1935, r_PackedHalf2AtPtx711R603, r_PtxRegister604,
		r_LaneIndexAtPtx1942, r_PackedHalf2AtPtx714R606, r_PtxRegister607, r_LaneIndexAtPtx1949,
		r_PackedHalf2AtPtx720R609, r_PtxRegister610, r_LaneIndexAtPtx1956, r_PackedHalf2AtPtx717R612;
	uint32_t r_PtxRegister613, r_LaneIndexAtPtx1963, r_PackedHalf2AtPtx723R615, r_PtxRegister616,
		r_LaneIndexAtPtx1970, r_PackedHalf2AtPtx726R618, r_PtxRegister619, r_LaneIndexAtPtx1977,
		r_PackedHalf2AtPtx732R621, r_PtxRegister622, r_LaneIndexAtPtx1984, r_PackedHalf2AtPtx729R624;
	uint32_t r_PtxRegister625, r_LaneIndexAtPtx1991, r_PackedHalf2AtPtx735R627, r_PtxRegister628,
		r_LaneIndexAtPtx1998, r_PackedHalf2AtPtx738R630, r_PtxRegister631, r_LaneIndexAtPtx2005,
		r_PackedHalf2AtPtx744R633, r_PtxRegister634, r_LaneIndexAtPtx2012, r_PackedHalf2AtPtx741R636;
	uint32_t r_PtxRegister637, r_LaneIndexAtPtx2019, r_PackedHalf2AtPtx747R639, r_PtxRegister640,
		r_LaneIndexAtPtx2026, r_PackedHalf2AtPtx750R642, r_PtxRegister643, r_LaneIndexAtPtx2033,
		r_PackedHalf2AtPtx756R645, r_PtxRegister646, r_LaneIndexAtPtx2040, r_PackedHalf2AtPtx753R648;
	uint32_t r_PtxRegister649, r_LaneIndexAtPtx2047, r_PackedHalf2AtPtx759R651, r_PtxRegister652,
		r_LaneIndexAtPtx2054, r_PackedHalf2AtPtx762R654, r_PtxRegister655, r_LaneIndexAtPtx2061,
		r_PackedHalf2AtPtx768R657, r_PtxRegister658, r_LaneIndexAtPtx2068, r_PackedHalf2AtPtx765R660;
	uint32_t r_PtxRegister661, r_LaneIndexAtPtx2075, r_PackedHalf2AtPtx771R663, r_PtxRegister664,
		r_LaneIndexAtPtx2082, r_PackedHalf2AtPtx774R666, r_PtxRegister667, r_LaneIndexAtPtx2089,
		r_PackedHalf2AtPtx780R669, r_PtxRegister670, r_LaneIndexAtPtx2096, r_PackedHalf2AtPtx777R672;
	uint32_t r_PtxRegister673, r_LaneIndexAtPtx2103, r_PackedHalf2AtPtx783R675, r_PtxRegister676,
		r_LaneIndexAtPtx2110, r_PackedHalf2AtPtx786R678, r_PtxRegister679, r_LaneIndexAtPtx2117,
		r_PackedHalf2AtPtx792R681, r_PtxRegister682, r_LaneIndexAtPtx2124, r_PackedHalf2AtPtx789R684;
	uint32_t r_PtxRegister685, r_LaneIndexAtPtx2131, r_PackedHalf2AtPtx795R687, r_PtxRegister688,
		r_LaneIndexAtPtx2138, r_PackedHalf2AtPtx798R690, r_PtxRegister691, r_LaneIndexAtPtx2145,
		r_PackedHalf2AtPtx804R693, r_PtxRegister694, r_LaneIndexAtPtx2152, r_PackedHalf2AtPtx801R696;
	uint32_t r_PtxRegister697, r_LaneIndexAtPtx2159, r_PackedHalf2AtPtx807R699, r_PtxRegister700,
		r_LaneIndexAtPtx2166, r_PackedHalf2AtPtx810R702, r_PtxRegister703, r_LaneIndexAtPtx2173,
		r_PackedHalf2AtPtx816R705, r_PtxRegister706, r_LaneIndexAtPtx2180, r_PackedHalf2AtPtx813R708;
	uint32_t r_PtxRegister709, r_LaneIndexAtPtx2187, r_PackedHalf2AtPtx819R711, r_PtxRegister712,
		r_LaneIndexAtPtx2194, r_PackedHalf2AtPtx823R714, r_PtxRegister715, r_LaneIndexAtPtx2201,
		r_PackedHalf2AtPtx830R717, r_PtxRegister718, r_LaneIndexAtPtx2208, r_PackedHalf2AtPtx826R720;
	uint32_t r_PtxRegister721, r_LaneIndexAtPtx2215, r_PackedHalf2AtPtx833R723, r_PtxRegister724,
		r_LaneIndexAtPtx2222, r_PackedHalf2AtPtx837R726, r_PtxRegister727, r_LaneIndexAtPtx2229,
		r_PackedHalf2AtPtx844R729, r_PtxRegister730, r_LaneIndexAtPtx2236, r_PackedHalf2AtPtx840R732;
	uint32_t r_PtxRegister733, r_LaneIndexAtPtx2243, r_PackedHalf2AtPtx847R735, r_PtxRegister736,
		r_PtxRegister737, r_PtxRegister738, r_PtxRegister739, r_PtxRegister740, r_PtxRegister741,
		r_PtxRegister742, r_PtxRegister743, r_PtxRegister744;
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
	uint32_t r_PtxRegister1177, r_PtxRegister1178, r_PtxRegister1179, r_PtxRegister1180, r_PtxRegister1181,
		r_PtxRegister1182, r_PtxRegister1183, r_PtxRegister1184, r_PtxRegister1185, r_PtxRegister1186,
		r_PtxRegister1187, r_PtxRegister1188;
	uint32_t r_PtxRegister1189, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PtxRegister1194, r_PtxRegister1195, r_PtxRegister1196, r_PtxRegister1197, r_PtxRegister1198,
		r_PtxRegister1199, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_PtxRegister1202, r_PtxRegister1203, r_PtxRegister1204, r_PtxRegister1205,
		r_PtxRegister1206, r_PtxRegister1207, r_PtxRegister1208, r_PtxRegister1209, r_PtxRegister1210,
		r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_PtxRegister1218, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_PtxRegister1231, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_PtxRegister1244, r_PtxRegister1245, r_PtxRegister1246,
		r_PtxRegister1247, r_PtxRegister1248;
	uint32_t r_PtxRegister1249, r_PtxRegister1250, r_PtxRegister1251, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_PtxRegister1257, r_PtxRegister1258,
		r_PtxRegister1259, r_PtxRegister1260;
	uint32_t r_PtxRegister1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264, r_PtxRegister1265,
		r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269, r_PtxRegister1270,
		r_PtxRegister1271, r_PtxRegister1272;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_PtxRegister1276, r_PtxRegister1277,
		r_PtxRegister1278, r_PtxRegister1279, r_PtxRegister1280, r_PtxRegister1281, r_PtxRegister1282,
		r_PtxRegister1283, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_PtxRegister1292, r_PtxRegister1293, r_PtxRegister1294,
		r_PtxRegister1295, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_LaneIndexAtPtx2269, r_PtxRegister1305, r_LaneIndexAtPtx2277,
		r_PtxRegister1307, r_LaneIndexAtPtx2286;
	uint32_t r_PtxRegister1309, r_LaneIndexAtPtx2295, r_PtxRegister1311, r_LaneIndexAtPtx2304,
		r_PtxRegister1313, r_LaneIndexAtPtx2313, r_PtxRegister1315, r_LaneIndexAtPtx2322, r_PtxRegister1317,
		r_LaneIndexAtPtx2331, r_PtxRegister1319, r_MmaAE4x4WordAtPtx2274R1320;
	uint32_t r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322, r_MmaAE4x4WordAtPtx2274R1323,
		r_MmaAE4x4WordAtPtx2283R1324, r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326,
		r_MmaAE4x4WordAtPtx2283R1327, r_MmaAccumulatorHalf2WordAtPtx2340R1328,
		r_MmaAccumulatorHalf2WordAtPtx2340R1329, r_MmaAccumulatorHalf2WordAtPtx2347R1330,
		r_MmaAccumulatorHalf2WordAtPtx2347R1331, r_MmaAccumulatorHalf2WordAtPtx2368R1332;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2368R1333, r_MmaAccumulatorHalf2WordAtPtx2375R1334,
		r_MmaAccumulatorHalf2WordAtPtx2375R1335, r_MmaAccumulatorHalf2WordAtPtx2396R1336,
		r_MmaAccumulatorHalf2WordAtPtx2396R1337, r_MmaAccumulatorHalf2WordAtPtx2403R1338,
		r_MmaAccumulatorHalf2WordAtPtx2403R1339, r_MmaAccumulatorHalf2WordAtPtx2424R1340,
		r_MmaAccumulatorHalf2WordAtPtx2424R1341, r_MmaAccumulatorHalf2WordAtPtx2431R1342,
		r_MmaAccumulatorHalf2WordAtPtx2431R1343, r_MmaAE4x4WordAtPtx2292R1344;
	uint32_t r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346, r_MmaAE4x4WordAtPtx2292R1347,
		r_MmaAE4x4WordAtPtx2301R1348, r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350,
		r_MmaAE4x4WordAtPtx2301R1351, r_MmaAccumulatorHalf2WordAtPtx2452R1352,
		r_MmaAccumulatorHalf2WordAtPtx2452R1353, r_MmaAccumulatorHalf2WordAtPtx2459R1354,
		r_MmaAccumulatorHalf2WordAtPtx2459R1355, r_MmaAccumulatorHalf2WordAtPtx2480R1356;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2480R1357, r_MmaAccumulatorHalf2WordAtPtx2487R1358,
		r_MmaAccumulatorHalf2WordAtPtx2487R1359, r_MmaAccumulatorHalf2WordAtPtx2508R1360,
		r_MmaAccumulatorHalf2WordAtPtx2508R1361, r_MmaAccumulatorHalf2WordAtPtx2515R1362,
		r_MmaAccumulatorHalf2WordAtPtx2515R1363, r_MmaAccumulatorHalf2WordAtPtx2536R1364,
		r_MmaAccumulatorHalf2WordAtPtx2536R1365, r_MmaAccumulatorHalf2WordAtPtx2543R1366,
		r_MmaAccumulatorHalf2WordAtPtx2543R1367, r_MmaAE4x4WordAtPtx2310R1368;
	uint32_t r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370, r_MmaAE4x4WordAtPtx2310R1371,
		r_MmaAE4x4WordAtPtx2319R1372, r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374,
		r_MmaAE4x4WordAtPtx2319R1375, r_MmaAccumulatorHalf2WordAtPtx2564R1376,
		r_MmaAccumulatorHalf2WordAtPtx2564R1377, r_MmaAccumulatorHalf2WordAtPtx2571R1378,
		r_MmaAccumulatorHalf2WordAtPtx2571R1379, r_MmaAccumulatorHalf2WordAtPtx2592R1380;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2592R1381, r_MmaAccumulatorHalf2WordAtPtx2599R1382,
		r_MmaAccumulatorHalf2WordAtPtx2599R1383, r_MmaAccumulatorHalf2WordAtPtx2620R1384,
		r_MmaAccumulatorHalf2WordAtPtx2620R1385, r_MmaAccumulatorHalf2WordAtPtx2627R1386,
		r_MmaAccumulatorHalf2WordAtPtx2627R1387, r_MmaAccumulatorHalf2WordAtPtx2648R1388,
		r_MmaAccumulatorHalf2WordAtPtx2648R1389, r_MmaAccumulatorHalf2WordAtPtx2655R1390,
		r_MmaAccumulatorHalf2WordAtPtx2655R1391, r_MmaAE4x4WordAtPtx2328R1392;
	uint32_t r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394, r_MmaAE4x4WordAtPtx2328R1395,
		r_MmaAE4x4WordAtPtx2337R1396, r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398,
		r_MmaAE4x4WordAtPtx2337R1399, r_MmaAccumulatorHalf2WordAtPtx2676R1400,
		r_MmaAccumulatorHalf2WordAtPtx2676R1401, r_MmaAccumulatorHalf2WordAtPtx2683R1402,
		r_MmaAccumulatorHalf2WordAtPtx2683R1403, r_MmaAccumulatorHalf2WordAtPtx2704R1404;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2704R1405, r_MmaAccumulatorHalf2WordAtPtx2711R1406,
		r_MmaAccumulatorHalf2WordAtPtx2711R1407, r_MmaAccumulatorHalf2WordAtPtx2732R1408,
		r_MmaAccumulatorHalf2WordAtPtx2732R1409, r_MmaAccumulatorHalf2WordAtPtx2739R1410,
		r_MmaAccumulatorHalf2WordAtPtx2739R1411, r_MmaAccumulatorHalf2WordAtPtx2760R1412,
		r_MmaAccumulatorHalf2WordAtPtx2760R1413, r_MmaAccumulatorHalf2WordAtPtx2767R1414,
		r_MmaAccumulatorHalf2WordAtPtx2767R1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_PtxRegister1423, r_PtxRegister1424, r_PtxRegister1425, r_PtxRegister1426,
		r_PtxRegister1427, r_PtxRegister1428;
	uint32_t r_PtxRegister1429, r_PtxRegister1430, r_PtxRegister1431, r_PtxRegister1432, r_PtxRegister1433,
		r_PtxRegister1434, r_PtxRegister1435, r_PtxRegister1436, r_PtxRegister1437, r_PtxRegister1438,
		r_PtxRegister1439, r_PtxRegister1440;
	uint32_t r_PtxRegister1441, r_PtxRegister1442, r_PtxRegister1443, r_PtxRegister1444, r_PtxRegister1445,
		r_PtxRegister1446, r_PtxRegister1447, r_PtxRegister1448, r_PtxRegister1449, r_PtxRegister1450,
		r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_PtxRegister1453, r_PackedHalf2AtPtx2846R1454, r_LaneIndexAtPtx2852, r_PtxRegister1456,
		r_PackedE4WordAtPtx2850R1457, r_PtxRegister1458, r_PtxRegister1459, r_PtxRegister1460,
		r_PtxRegister1461, r_PtxRegister1462, r_PtxRegister1463, r_PtxRegister1464;
	uint32_t r_PtxRegister1465, r_PtxRegister1466, r_PtxRegister1467, r_PtxRegister1468, r_PtxRegister1469,
		r_PtxRegister1470, r_PtxRegister1471, r_PtxRegister1472, r_PtxRegister1473, r_PtxRegister1474,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PackedHalf2AtPtx2921R1479, r_LaneIndexAtPtx2927,
		r_PtxRegister1481, r_PackedE4WordAtPtx2925R1482, r_PtxRegister1483, r_PtxRegister1484,
		r_PtxRegister1485, r_PtxRegister1486, r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_LaneIndexAtPtx2941, r_LaneIndexAtPtx2949, r_LaneIndexAtPtx2958,
		r_LaneIndexAtPtx2967, r_LaneIndexAtPtx2976, r_LaneIndexAtPtx2985, r_LaneIndexAtPtx2994,
		r_LaneIndexAtPtx3003, r_PtxRegister1498, r_PtxRegister1499, r_PtxRegister1500;
	uint32_t r_PtxRegister1501, r_LaneIndexAtPtx3030, r_PtxRegister1503, r_LaneIndexAtPtx3040,
		r_PtxRegister1505, r_LaneIndexAtPtx3049, r_PtxRegister1507, r_LaneIndexAtPtx3058, r_PtxRegister1509,
		r_LaneIndexAtPtx3067, r_PtxRegister1511, r_LaneIndexAtPtx3076;
	uint32_t r_PtxRegister1513, r_LaneIndexAtPtx3085, r_PtxRegister1515, r_LaneIndexAtPtx3094,
		r_PtxRegister1517, r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519,
		r_MmaAE4x4WordAtPtx3037R1520, r_MmaAE4x4WordAtPtx3037R1521, r_MmaAE4x4WordAtPtx3046R1522,
		r_MmaAE4x4WordAtPtx3046R1523, r_MmaAE4x4WordAtPtx3046R1524;
	uint32_t r_MmaAE4x4WordAtPtx3046R1525, r_MmaAccumulatorHalf2WordAtPtx3103R1526,
		r_MmaAccumulatorHalf2WordAtPtx3103R1527, r_MmaAccumulatorHalf2WordAtPtx3110R1528,
		r_MmaAccumulatorHalf2WordAtPtx3110R1529, r_MmaAccumulatorHalf2WordAtPtx3131R1530,
		r_MmaAccumulatorHalf2WordAtPtx3131R1531, r_MmaAccumulatorHalf2WordAtPtx3138R1532,
		r_MmaAccumulatorHalf2WordAtPtx3138R1533, r_MmaAccumulatorHalf2WordAtPtx3159R1534,
		r_MmaAccumulatorHalf2WordAtPtx3159R1535, r_MmaAccumulatorHalf2WordAtPtx3166R1536;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3166R1537, r_MmaAccumulatorHalf2WordAtPtx3187R1538,
		r_MmaAccumulatorHalf2WordAtPtx3187R1539, r_MmaAccumulatorHalf2WordAtPtx3194R1540,
		r_MmaAccumulatorHalf2WordAtPtx3194R1541, r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543,
		r_MmaAE4x4WordAtPtx3055R1544, r_MmaAE4x4WordAtPtx3055R1545, r_MmaAE4x4WordAtPtx3064R1546,
		r_MmaAE4x4WordAtPtx3064R1547, r_MmaAE4x4WordAtPtx3064R1548;
	uint32_t r_MmaAE4x4WordAtPtx3064R1549, r_MmaAccumulatorHalf2WordAtPtx3215R1550,
		r_MmaAccumulatorHalf2WordAtPtx3215R1551, r_MmaAccumulatorHalf2WordAtPtx3222R1552,
		r_MmaAccumulatorHalf2WordAtPtx3222R1553, r_MmaAccumulatorHalf2WordAtPtx3243R1554,
		r_MmaAccumulatorHalf2WordAtPtx3243R1555, r_MmaAccumulatorHalf2WordAtPtx3250R1556,
		r_MmaAccumulatorHalf2WordAtPtx3250R1557, r_MmaAccumulatorHalf2WordAtPtx3271R1558,
		r_MmaAccumulatorHalf2WordAtPtx3271R1559, r_MmaAccumulatorHalf2WordAtPtx3278R1560;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3278R1561, r_MmaAccumulatorHalf2WordAtPtx3299R1562,
		r_MmaAccumulatorHalf2WordAtPtx3299R1563, r_MmaAccumulatorHalf2WordAtPtx3306R1564,
		r_MmaAccumulatorHalf2WordAtPtx3306R1565, r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567,
		r_MmaAE4x4WordAtPtx3073R1568, r_MmaAE4x4WordAtPtx3073R1569, r_MmaAE4x4WordAtPtx3082R1570,
		r_MmaAE4x4WordAtPtx3082R1571, r_MmaAE4x4WordAtPtx3082R1572;
	uint32_t r_MmaAE4x4WordAtPtx3082R1573, r_MmaAccumulatorHalf2WordAtPtx3327R1574,
		r_MmaAccumulatorHalf2WordAtPtx3327R1575, r_MmaAccumulatorHalf2WordAtPtx3334R1576,
		r_MmaAccumulatorHalf2WordAtPtx3334R1577, r_MmaAccumulatorHalf2WordAtPtx3355R1578,
		r_MmaAccumulatorHalf2WordAtPtx3355R1579, r_MmaAccumulatorHalf2WordAtPtx3362R1580,
		r_MmaAccumulatorHalf2WordAtPtx3362R1581, r_MmaAccumulatorHalf2WordAtPtx3383R1582,
		r_MmaAccumulatorHalf2WordAtPtx3383R1583, r_MmaAccumulatorHalf2WordAtPtx3390R1584;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3390R1585, r_MmaAccumulatorHalf2WordAtPtx3411R1586,
		r_MmaAccumulatorHalf2WordAtPtx3411R1587, r_MmaAccumulatorHalf2WordAtPtx3418R1588,
		r_MmaAccumulatorHalf2WordAtPtx3418R1589, r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591,
		r_MmaAE4x4WordAtPtx3091R1592, r_MmaAE4x4WordAtPtx3091R1593, r_MmaAE4x4WordAtPtx3100R1594,
		r_MmaAE4x4WordAtPtx3100R1595, r_MmaAE4x4WordAtPtx3100R1596;
	uint32_t r_MmaAE4x4WordAtPtx3100R1597, r_MmaAccumulatorHalf2WordAtPtx3439R1598,
		r_MmaAccumulatorHalf2WordAtPtx3439R1599, r_MmaAccumulatorHalf2WordAtPtx3446R1600,
		r_MmaAccumulatorHalf2WordAtPtx3446R1601, r_MmaAccumulatorHalf2WordAtPtx3467R1602,
		r_MmaAccumulatorHalf2WordAtPtx3467R1603, r_MmaAccumulatorHalf2WordAtPtx3474R1604,
		r_MmaAccumulatorHalf2WordAtPtx3474R1605, r_MmaAccumulatorHalf2WordAtPtx3495R1606,
		r_MmaAccumulatorHalf2WordAtPtx3495R1607, r_MmaAccumulatorHalf2WordAtPtx3502R1608;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3502R1609, r_MmaAccumulatorHalf2WordAtPtx3523R1610,
		r_MmaAccumulatorHalf2WordAtPtx3523R1611, r_MmaAccumulatorHalf2WordAtPtx3530R1612,
		r_MmaAccumulatorHalf2WordAtPtx3530R1613, r_PtxRegister1614, r_PtxRegister1615, r_PtxRegister1616,
		r_PtxRegister1617, r_PtxRegister1618, r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_PtxRegister1626, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_PtxRegister1631, r_PtxRegister1632;
	uint32_t r_PtxRegister1633, r_LaneIndexAtPtx3760, r_PackedE4WordAtPtx3758R1635,
		r_PackedE4WordAtPtx3757R1636, r_PackedE4WordAtPtx3756R1637, r_PackedE4WordAtPtx3755R1638,
		r_LaneIndexAtPtx3768, r_PackedE4WordAtPtx3754R1640, r_PackedE4WordAtPtx3753R1641,
		r_PackedE4WordAtPtx3752R1642, r_PackedE4WordAtPtx3751R1643, r_LaneIndexAtPtx3783;
	uint32_t r_PackedE4WordAtPtx3791R1645, r_PackedE4WordAtPtx3790R1646, r_PackedE4WordAtPtx3789R1647,
		r_PackedE4WordAtPtx3788R1648, r_LaneIndexAtPtx3796, r_PackedE4WordAtPtx3804R1650,
		r_PackedE4WordAtPtx3803R1651, r_PackedE4WordAtPtx3802R1652, r_PackedE4WordAtPtx3801R1653,
		r_PtxRegister1654, r_PtxRegister1655, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_LaneIndexAtPtx3821, r_PackedE4WordAtPtx3828R1659,
		r_PackedE4WordAtPtx3827R1660, r_PackedE4WordAtPtx3826R1661, r_PackedE4WordAtPtx3825R1662,
		r_LaneIndexAtPtx3833, r_PackedE4WordAtPtx3841R1664, r_PackedE4WordAtPtx3840R1665,
		r_PackedE4WordAtPtx3839R1666, r_PackedE4WordAtPtx3838R1667, r_LaneIndexAtPtx3851;
	uint32_t r_PackedE4WordAtPtx3859R1669, r_PackedE4WordAtPtx3858R1670, r_PackedE4WordAtPtx3857R1671,
		r_PackedE4WordAtPtx3856R1672, r_LaneIndexAtPtx3864, r_PackedE4WordAtPtx3872R1674,
		r_PackedE4WordAtPtx3871R1675, r_PackedE4WordAtPtx3870R1676, r_PackedE4WordAtPtx3869R1677,
		r_LaneIndexAtPtx3882, r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_PtxRegister1689, r_PtxRegister1690,
		r_PtxRegister1691, r_PackedHalf2AtPtx3945R1692;
	uint32_t r_PackedHalf2AtPtx3949R1693, r_PtxRegister1694, r_PackedHalf2AtPtx3953R1695,
		r_LaneIndexAtPtx3967, r_PtxRegister1697, r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700,
		r_PtxRegister1701, r_PtxRegister1702, r_PtxRegister1703, r_PtxRegister1704;
	uint32_t r_PtxRegister1705, r_PtxRegister1706, r_PackedHalf2AtPtx4030R1707, r_PackedHalf2AtPtx4034R1708,
		r_PackedHalf2AtPtx4038R1709, r_LaneIndexAtPtx4046, r_PtxRegister1711, r_PtxRegister1712,
		r_PtxRegister1713, r_PtxRegister1714, r_PtxRegister1715, r_PtxRegister1716;
	uint32_t r_PtxRegister1717, r_PtxRegister1718, r_PtxRegister1719, r_PtxRegister1720,
		r_PackedHalf2AtPtx4109R1721, r_PackedHalf2AtPtx4113R1722, r_PackedHalf2AtPtx4117R1723,
		r_LaneIndexAtPtx4125, r_PtxRegister1725, r_PtxRegister1726, r_PtxRegister1727, r_PtxRegister1728;
	uint32_t r_PtxRegister1729, r_PtxRegister1730, r_PtxRegister1731, r_PtxRegister1732, r_PtxRegister1733,
		r_PtxRegister1734, r_PackedHalf2AtPtx4188R1735, r_PackedHalf2AtPtx4192R1736,
		r_PackedHalf2AtPtx4196R1737, r_LaneIndexAtPtx4204, r_PtxRegister1739, r_PtxRegister1740;
	uint32_t r_PtxRegister1741, r_PtxRegister1742, r_PtxRegister1743, r_PtxRegister1744, r_PtxRegister1745,
		r_PtxRegister1746, r_PtxRegister1747, r_PtxRegister1748, r_PackedHalf2AtPtx4267R1749,
		r_PackedHalf2AtPtx4271R1750, r_PackedHalf2AtPtx4275R1751, r_LaneIndexAtPtx4283;
	uint32_t r_PtxRegister1753, r_PtxRegister1754, r_PtxRegister1755, r_PtxRegister1756, r_PtxRegister1757,
		r_PtxRegister1758, r_PtxRegister1759, r_PtxRegister1760, r_PtxRegister1761, r_PtxRegister1762,
		r_PackedHalf2AtPtx4346R1763, r_PackedHalf2AtPtx4350R1764;
	uint32_t r_PackedHalf2AtPtx4354R1765, r_LaneIndexAtPtx4362, r_PtxRegister1767, r_PtxRegister1768,
		r_PtxRegister1769, r_PtxRegister1770, r_PtxRegister1771, r_PtxRegister1772, r_PtxRegister1773,
		r_PtxRegister1774, r_PtxRegister1775, r_PtxRegister1776;
	uint32_t r_PackedHalf2AtPtx4425R1777, r_PackedHalf2AtPtx4429R1778, r_PackedHalf2AtPtx4433R1779,
		r_LaneIndexAtPtx4441, r_PtxRegister1781, r_PtxRegister1782, r_PtxRegister1783, r_PtxRegister1784,
		r_PtxRegister1785, r_PtxRegister1786, r_PtxRegister1787, r_PtxRegister1788;
	uint32_t r_PtxRegister1789, r_PtxRegister1790, r_PackedHalf2AtPtx4504R1791, r_PackedHalf2AtPtx4508R1792,
		r_PackedHalf2AtPtx4512R1793, r_LaneIndexAtPtx4520, r_PtxRegister1795, r_PtxRegister1796,
		r_PtxRegister1797, r_PtxRegister1798, r_PtxRegister1799, r_PtxRegister1800;
	uint32_t r_PtxRegister1801, r_PtxRegister1802, r_PtxRegister1803, r_PtxRegister1804,
		r_PackedHalf2AtPtx4583R1805, r_PackedHalf2AtPtx4587R1806, r_PackedHalf2AtPtx4591R1807,
		r_LaneIndexAtPtx4599, r_PtxRegister1809, r_PtxRegister1810, r_PtxRegister1811, r_PtxRegister1812;
	uint32_t r_PtxRegister1813, r_PtxRegister1814, r_PtxRegister1815, r_PtxRegister1816, r_PtxRegister1817,
		r_PtxRegister1818, r_PackedHalf2AtPtx4662R1819, r_PackedHalf2AtPtx4666R1820,
		r_PackedHalf2AtPtx4670R1821, r_LaneIndexAtPtx4678, r_PtxRegister1823, r_PtxRegister1824;
	uint32_t r_PtxRegister1825, r_PtxRegister1826, r_PtxRegister1827, r_PtxRegister1828, r_PtxRegister1829,
		r_PtxRegister1830, r_PtxRegister1831, r_PtxRegister1832, r_PackedHalf2AtPtx4741R1833,
		r_PackedHalf2AtPtx4745R1834, r_PackedHalf2AtPtx4749R1835, r_LaneIndexAtPtx4757;
	uint32_t r_PtxRegister1837, r_PtxRegister1838, r_PtxRegister1839, r_PtxRegister1840, r_PtxRegister1841,
		r_PtxRegister1842, r_PtxRegister1843, r_PtxRegister1844, r_PtxRegister1845, r_PtxRegister1846,
		r_PackedHalf2AtPtx4820R1847, r_PackedHalf2AtPtx4824R1848;
	uint32_t r_PackedHalf2AtPtx4828R1849, r_LaneIndexAtPtx4836, r_PtxRegister1851, r_PtxRegister1852,
		r_PtxRegister1853, r_PtxRegister1854, r_PtxRegister1855, r_PtxRegister1856, r_PtxRegister1857,
		r_PtxRegister1858, r_PtxRegister1859, r_PtxRegister1860;
	uint32_t r_PackedHalf2AtPtx4899R1861, r_PackedHalf2AtPtx4903R1862, r_PackedHalf2AtPtx4907R1863,
		r_LaneIndexAtPtx4915, r_PtxRegister1865, r_PtxRegister1866, r_PtxRegister1867, r_PtxRegister1868,
		r_PtxRegister1869, r_PtxRegister1870, r_PtxRegister1871, r_PtxRegister1872;
	uint32_t r_PtxRegister1873, r_PtxRegister1874, r_PackedHalf2AtPtx4978R1875, r_PackedHalf2AtPtx4982R1876,
		r_PackedHalf2AtPtx4986R1877, r_LaneIndexAtPtx4994, r_PtxRegister1879, r_PtxRegister1880,
		r_PtxRegister1881, r_PtxRegister1882, r_PtxRegister1883, r_PtxRegister1884;
	uint32_t r_PtxRegister1885, r_PtxRegister1886, r_PtxRegister1887, r_PtxRegister1888,
		r_PackedHalf2AtPtx5057R1889, r_PackedHalf2AtPtx5061R1890, r_PackedHalf2AtPtx5065R1891,
		r_LaneIndexAtPtx5073, r_PtxRegister1893, r_PtxRegister1894, r_PtxRegister1895, r_PtxRegister1896;
	uint32_t r_PtxRegister1897, r_PtxRegister1898, r_PtxRegister1899, r_PtxRegister1900, r_PtxRegister1901,
		r_PtxRegister1902, r_PackedHalf2AtPtx5136R1903, r_PackedHalf2AtPtx5140R1904,
		r_PackedHalf2AtPtx5144R1905, r_PackedHalf2AtPtx3961R1906, r_PackedHalf2AtPtx3963R1907,
		r_PackedHalf2AtPtx4121R1908;
	uint32_t r_PackedHalf2AtPtx4042R1909, r_PackedHalf2AtPtx4200R1910, r_PackedHalf2AtPtx4279R1911,
		r_PackedHalf2AtPtx4437R1912, r_PackedHalf2AtPtx4358R1913, r_PackedHalf2AtPtx4516R1914,
		r_PackedHalf2AtPtx4595R1915, r_PackedHalf2AtPtx4753R1916, r_PackedHalf2AtPtx4674R1917,
		r_PackedHalf2AtPtx4832R1918, r_PackedHalf2AtPtx4911R1919, r_PackedHalf2AtPtx5069R1920;
	uint32_t r_PackedHalf2AtPtx4990R1921, r_PackedHalf2AtPtx5148R1922, r_PtxRegister1923, r_PtxRegister1924,
		r_PtxRegister1925, r_PtxRegister1926, r_LaneIndexAtPtx5221, r_PackedE4WordAtPtx5214R1928,
		r_PackedE4WordAtPtx5213R1929, r_PackedE4WordAtPtx5212R1930, r_PackedE4WordAtPtx5211R1931,
		r_LaneIndexAtPtx5229;
	uint32_t r_PackedE4WordAtPtx5210R1933, r_PackedE4WordAtPtx5209R1934, r_PackedE4WordAtPtx5208R1935,
		r_PackedE4WordAtPtx5207R1936, r_PtxRegister1937, r_PtxRegister1938, r_PtxRegister1939,
		r_PtxRegister1940, r_PtxRegister1941, r_PtxRegister1942, r_PtxRegister1943, r_PtxRegister1944;
	uint32_t r_PtxRegister1945, r_PtxRegister1946, r_PtxRegister1947, r_PtxRegister1948, r_PtxRegister1949,
		r_PtxRegister1950, r_PtxRegister1951, r_PtxRegister1952, r_PtxRegister1953, r_PtxRegister1954,
		r_PtxRegister1955, r_PtxRegister1956;
	uint32_t r_PtxRegister1957, r_PtxRegister1958, r_PtxRegister1959, r_PtxRegister1960, r_PtxRegister1961,
		r_PtxRegister1962, r_PtxRegister1963, r_PtxRegister1964, r_PtxRegister1965, r_PtxRegister1966,
		r_PtxRegister1967, r_PtxRegister1968;
	uint32_t r_PtxRegister1969, r_PtxRegister1970, r_PtxRegister1971, r_PtxRegister1972, r_PtxRegister1973,
		r_PackedHalf2AtPtx2225R1974, r_PackedHalf2AtPtx2218R1975, r_PackedHalf2AtPtx2211R1976,
		r_PackedHalf2AtPtx2204R1977, r_PackedHalf2AtPtx2197R1978, r_PackedHalf2AtPtx2190R1979,
		r_PackedHalf2AtPtx2183R1980;
	uint32_t r_PackedHalf2AtPtx2176R1981, r_PackedHalf2AtPtx2169R1982, r_PackedHalf2AtPtx2162R1983,
		r_PackedHalf2AtPtx2155R1984, r_PackedHalf2AtPtx2148R1985, r_PackedHalf2AtPtx2141R1986,
		r_PackedHalf2AtPtx2134R1987, r_PackedHalf2AtPtx2127R1988, r_PackedHalf2AtPtx2120R1989,
		r_PackedHalf2AtPtx2113R1990, r_PackedHalf2AtPtx2106R1991, r_PackedHalf2AtPtx2099R1992;
	uint32_t r_PackedHalf2AtPtx2092R1993, r_PackedHalf2AtPtx2085R1994, r_PackedHalf2AtPtx2078R1995,
		r_PackedHalf2AtPtx2071R1996, r_PackedHalf2AtPtx2064R1997, r_PackedHalf2AtPtx2057R1998,
		r_PackedHalf2AtPtx2050R1999, r_PackedHalf2AtPtx2043R2000, r_PackedHalf2AtPtx2036R2001,
		r_PackedHalf2AtPtx2029R2002, r_PackedHalf2AtPtx2022R2003, r_PackedHalf2AtPtx2015R2004;
	uint32_t r_PackedHalf2AtPtx2008R2005, r_PackedHalf2AtPtx2001R2006, r_PackedHalf2AtPtx1994R2007,
		r_PackedHalf2AtPtx1987R2008, r_PackedHalf2AtPtx1980R2009, r_PackedHalf2AtPtx1973R2010,
		r_PackedHalf2AtPtx1966R2011, r_PackedHalf2AtPtx1959R2012, r_PackedHalf2AtPtx1952R2013,
		r_PackedHalf2AtPtx1945R2014, r_PackedHalf2AtPtx1938R2015, r_PackedHalf2AtPtx1931R2016;
	uint32_t r_PackedHalf2AtPtx1924R2017, r_PackedHalf2AtPtx1917R2018, r_PackedHalf2AtPtx1910R2019,
		r_PackedHalf2AtPtx1903R2020, r_PackedHalf2AtPtx1896R2021, r_PackedHalf2AtPtx1889R2022,
		r_PackedHalf2AtPtx1882R2023, r_PackedHalf2AtPtx1875R2024, r_PackedHalf2AtPtx1868R2025,
		r_PackedHalf2AtPtx1861R2026, r_PackedHalf2AtPtx1854R2027, r_PackedHalf2AtPtx1847R2028;
	uint32_t r_PackedHalf2AtPtx1840R2029, r_PackedHalf2AtPtx1833R2030, r_PackedHalf2AtPtx1826R2031,
		r_PackedHalf2AtPtx1819R2032, r_PackedHalf2AtPtx1812R2033, r_PackedHalf2AtPtx1805R2034,
		r_PackedHalf2AtPtx2232R2035, r_PackedHalf2AtPtx2239R2036, r_PackedHalf2AtPtx2246R2037,
		r_PtxRegister2038, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040;
	uint32_t r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042, r_MmaBE4x4WordAtPtx84R2043,
		r_MmaBE4x4WordAtPtx84R2044, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048, r_MmaBE4x4WordAtPtx94R2049,
		r_MmaBE4x4WordAtPtx94R2050, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052;
	uint32_t r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054, r_MmaBE4x4WordAtPtx112R2055,
		r_MmaBE4x4WordAtPtx112R2056, r_MmaBE4x4WordAtPtx112R2057, r_MmaBE4x4WordAtPtx112R2058,
		r_MmaBE4x4WordAtPtx121R2059, r_MmaBE4x4WordAtPtx121R2060, r_MmaBE4x4WordAtPtx121R2061,
		r_MmaBE4x4WordAtPtx121R2062, r_MmaBE4x4WordAtPtx130R2063, r_MmaBE4x4WordAtPtx130R2064;
	uint32_t r_MmaBE4x4WordAtPtx130R2065, r_MmaBE4x4WordAtPtx130R2066, r_MmaBE4x4WordAtPtx139R2067,
		r_MmaBE4x4WordAtPtx139R2068, r_MmaBE4x4WordAtPtx139R2069, r_MmaBE4x4WordAtPtx139R2070,
		r_PtxRegister2071, r_PtxRegister2072, r_PtxRegister2073, r_PtxRegister2074, r_PtxRegister2075,
		r_PtxRegister2076;
	uint32_t r_PtxRegister2077, r_PtxRegister2078, r_PtxRegister2079, r_PtxRegister2080, r_PtxRegister2081,
		r_PtxRegister2082, r_PtxRegister2083, r_PtxRegister2084, r_PtxRegister2085, r_PtxRegister2086,
		r_PtxRegister2087, r_PtxRegister2088;
	uint32_t r_PtxRegister2089, r_PtxRegister2090, r_PtxRegister2091, r_PtxRegister2092, r_PtxRegister2093,
		r_PtxRegister2094, r_PtxRegister2095, r_PtxRegister2096, r_PtxRegister2097, r_PtxRegister2098,
		r_PtxRegister2099, r_PtxRegister2100;
	uint32_t r_PtxRegister2101, r_PtxRegister2102, r_PtxRegister2103, r_PtxRegister2104, r_PtxRegister2105,
		r_PtxRegister2106, r_PtxRegister2107, r_PtxRegister2108, r_PtxRegister2109, r_PtxRegister2110,
		r_PtxRegister2111, r_PtxRegister2112;
	uint32_t r_PtxRegister2113, r_PtxRegister2114, r_PtxRegister2115, r_PtxRegister2116, r_PtxRegister2117,
		r_PtxRegister2118, r_PtxRegister2119, r_PtxRegister2120, r_PtxRegister2121, r_PtxRegister2122,
		r_PtxRegister2123, r_PtxRegister2124;
	uint32_t r_PtxRegister2125, r_PtxRegister2126, r_PtxRegister2127, r_PtxRegister2128, r_PtxRegister2129,
		r_PtxRegister2130, r_PtxRegister2131, r_PtxRegister2132, r_PtxRegister2133, r_PtxRegister2134;
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
	uint64_t r_PtxU64Register265, r_PtxU64Register266;
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
	r_PtxRegister338 = uint32_t(r_Scalar68Bits) + uint32_t(-1);					  // PTX L24
	r_PtxRegister339 = ShiftRightSigned(int32_t(r_PtxRegister338), uint32_t(31)); // PTX L25
	r_PtxRegister340 = ShiftRight(uint32_t(r_PtxRegister339), uint32_t(29));	  // PTX L26
	r_PtxRegister341 = uint32_t(r_PtxRegister338) + uint32_t(r_PtxRegister340);	  // PTX L27
	r_PtxRegister342 = ShiftRightSigned(int32_t(r_PtxRegister341), uint32_t(3));  // PTX L28
	r_PtxRegister343 = uint32_t(r_PtxRegister342) + uint32_t(1);				  // PTX L29
	r_PtxRegister3 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister343));		  // PTX L30
	r_PtxRegister344 =
		uint32_t(r_PtxRegister3) * uint32_t(r_PtxRegister342) + uint32_t(r_PtxRegister3); // PTX L31
	r_PtxRegister2 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister344);						  // PTX L32
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L33
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(1));					  // PTX L34
	r_PtxRegister345 = ShiftRightSigned(int32_t(r_Scalar64Bits), uint32_t(31));			  // PTX L35
	r_PtxRegister346 = ShiftRight(uint32_t(r_PtxRegister345), uint32_t(30));			  // PTX L36
	r_PtxRegister347 = uint32_t(r_Scalar64Bits) + uint32_t(r_PtxRegister346);			  // PTX L37
	r_PtxRegister6 = ShiftRightSigned(int32_t(r_PtxRegister347), uint32_t(2));			  // PTX L38
	r_PtxRegister348 = ShiftRightSigned(int32_t(r_Scalar68Bits), uint32_t(31));			  // PTX L39
	r_PtxRegister349 = ShiftRight(uint32_t(r_PtxRegister348), uint32_t(30));			  // PTX L40
	r_PtxRegister350 = uint32_t(r_Scalar68Bits) + uint32_t(r_PtxRegister349);			  // PTX L41
	r_PtxRegister7 = ShiftRightSigned(int32_t(r_PtxRegister350), uint32_t(2));			  // PTX L42
	r_ThreadX = uint32_t(threadIdx.x);													  // PTX L43
	r_ThreadY = uint32_t(threadIdx.y);													  // PTX L44
	r_PtxRegister352 = r_ThreadX | r_ThreadY;											  // PTX L45
	r_bPtxPredicate14 = uint32_t(r_PtxRegister352) != uint32_t(0);						  // PTX L46
	if (r_bPtxPredicate14)
	{
		goto L__BB39_2;
	} // PTX L47
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L48
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L49
	r_PtxRegister354 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L50
	r_PtxRegister353 = uint32_t(8192u /* exact native shared-region offset */); // PTX L51
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister353, r_PtxRegister354); // PTX L53
	r_PtxRegister355 = uint32_t(r_PtxRegister353) + uint32_t(8);	  // PTX L55
	BarrierInit(s_SharedStorage, r_PtxRegister355, r_PtxRegister354); // PTX L57
L__BB39_2:															  // PTX L59
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L60
	r_PtxRegister366 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L61
	r_PtxRegister367 = ShiftLeft(uint32_t(r_PtxRegister3), uint32_t(8));						// PTX L62
	r_PtxRegister9 = uint32_t(r_PtxRegister366) + uint32_t(r_PtxRegister367);					// PTX L63
	r_PtxRegister368 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(16));								// PTX L64
	r_PtxRegister369 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(3));						// PTX L65
	r_PtxRegister370 = uint32_t(r_PtxRegister368) + uint32_t(r_PtxRegister369);					// PTX L66
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_PtxRegister370)) * int64_t(int32_t(4)));	// PTX L67
	r_PtxU64Register18 = uint64_t(r_Pointer32Bits) + uint64_t(r_PtxU64Register17);				// PTX L68
	r_LaneIndexAtPtx70 = uint32_t((threadIdx.x & 31u));											// PTX L70
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx70)) * int64_t(int32_t(16))); // PTX L72
	r_PtxU64Register9 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register19);			// PTX L73
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBE4x4WordAtPtx75R2039 = r_Value.x;
		r_MmaBE4x4WordAtPtx75R2040 = r_Value.y;
		r_MmaBE4x4WordAtPtx75R2041 = r_Value.z;
		r_MmaBE4x4WordAtPtx75R2042 = r_Value.w;
	} // PTX L75
	r_LaneIndexAtPtx78 = uint32_t((threadIdx.x & 31u));											// PTX L78
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx78)) * int64_t(int32_t(16))); // PTX L80
	r_PtxU64Register21 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register20);			// PTX L81
	r_PtxU64Register10 = uint64_t(r_PtxU64Register21) + uint64_t(512);							// PTX L82
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBE4x4WordAtPtx84R2043 = r_Value.x;
		r_MmaBE4x4WordAtPtx84R2044 = r_Value.y;
		r_MmaBE4x4WordAtPtx84R2045 = r_Value.z;
		r_MmaBE4x4WordAtPtx84R2046 = r_Value.w;
	} // PTX L84
	r_PtxRegister10 = r_PtxRegister9 | 32;														// PTX L86
	r_LaneIndexAtPtx88 = uint32_t((threadIdx.x & 31u));											// PTX L88
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx88)) * int64_t(int32_t(16))); // PTX L90
	r_PtxU64Register23 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register22);			// PTX L91
	r_PtxU64Register11 = uint64_t(r_PtxU64Register23) + uint64_t(1024);							// PTX L92
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBE4x4WordAtPtx94R2047 = r_Value.x;
		r_MmaBE4x4WordAtPtx94R2048 = r_Value.y;
		r_MmaBE4x4WordAtPtx94R2049 = r_Value.z;
		r_MmaBE4x4WordAtPtx94R2050 = r_Value.w;
	} // PTX L94
	r_LaneIndexAtPtx97 = uint32_t((threadIdx.x & 31u));											// PTX L97
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx97)) * int64_t(int32_t(16))); // PTX L99
	r_PtxU64Register25 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register24);			// PTX L100
	r_PtxU64Register12 = uint64_t(r_PtxU64Register25) + uint64_t(1536);							// PTX L101
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBE4x4WordAtPtx103R2051 = r_Value.x;
		r_MmaBE4x4WordAtPtx103R2052 = r_Value.y;
		r_MmaBE4x4WordAtPtx103R2053 = r_Value.z;
		r_MmaBE4x4WordAtPtx103R2054 = r_Value.w;
	} // PTX L103
	r_LaneIndexAtPtx106 = uint32_t((threadIdx.x & 31u));										 // PTX L106
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx106)) * int64_t(int32_t(16))); // PTX L108
	r_PtxU64Register27 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register26);			 // PTX L109
	r_PtxU64Register13 = uint64_t(r_PtxU64Register27) + uint64_t(16384);						 // PTX L110
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register13));
		r_MmaBE4x4WordAtPtx112R2055 = r_Value.x;
		r_MmaBE4x4WordAtPtx112R2056 = r_Value.y;
		r_MmaBE4x4WordAtPtx112R2057 = r_Value.z;
		r_MmaBE4x4WordAtPtx112R2058 = r_Value.w;
	} // PTX L112
	r_LaneIndexAtPtx115 = uint32_t((threadIdx.x & 31u));										 // PTX L115
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx115)) * int64_t(int32_t(16))); // PTX L117
	r_PtxU64Register29 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register28);			 // PTX L118
	r_PtxU64Register14 = uint64_t(r_PtxU64Register29) + uint64_t(16896);						 // PTX L119
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register14));
		r_MmaBE4x4WordAtPtx121R2059 = r_Value.x;
		r_MmaBE4x4WordAtPtx121R2060 = r_Value.y;
		r_MmaBE4x4WordAtPtx121R2061 = r_Value.z;
		r_MmaBE4x4WordAtPtx121R2062 = r_Value.w;
	} // PTX L121
	r_LaneIndexAtPtx124 = uint32_t((threadIdx.x & 31u));										 // PTX L124
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx124)) * int64_t(int32_t(16))); // PTX L126
	r_PtxU64Register31 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register30);			 // PTX L127
	r_PtxU64Register15 = uint64_t(r_PtxU64Register31) + uint64_t(17408);						 // PTX L128
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register15));
		r_MmaBE4x4WordAtPtx130R2063 = r_Value.x;
		r_MmaBE4x4WordAtPtx130R2064 = r_Value.y;
		r_MmaBE4x4WordAtPtx130R2065 = r_Value.z;
		r_MmaBE4x4WordAtPtx130R2066 = r_Value.w;
	} // PTX L130
	r_LaneIndexAtPtx133 = uint32_t((threadIdx.x & 31u));										 // PTX L133
	r_PtxU64Register32 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx133)) * int64_t(int32_t(16))); // PTX L135
	r_PtxU64Register33 = uint64_t(r_PtxU64Register18) + uint64_t(r_PtxU64Register32);			 // PTX L136
	r_PtxU64Register16 = uint64_t(r_PtxU64Register33) + uint64_t(17920);						 // PTX L137
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register16));
		r_MmaBE4x4WordAtPtx139R2067 = r_Value.x;
		r_MmaBE4x4WordAtPtx139R2068 = r_Value.y;
		r_MmaBE4x4WordAtPtx139R2069 = r_Value.z;
		r_MmaBE4x4WordAtPtx139R2070 = r_Value.w;
	} // PTX L139
	r_PtxRegister371 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));		  // PTX L141
	r_PtxRegister372 = r_PtxRegister371 & 1;								  // PTX L142
	r_PtxRegister373 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));		  // PTX L143
	r_PtxRegister374 = ShiftLeft(uint32_t(r_PtxRegister373), uint32_t(9));	  // PTX L144
	r_PtxRegister375 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L145
	r_PtxRegister11 = r_PtxRegister375 & 256;								  // PTX L146
	r_PtxRegister12 = r_PtxRegister374 | r_PtxRegister11;					  // PTX L147
	r_PtxRegister13 = r_PtxRegister375 & 128;								  // PTX L148
	r_PtxRegister376 = uint32_t(r_PtxRegister373) + uint32_t(r_PtxRegister4); // PTX L149
	r_PtxRegister14 = uint32_t(r_PtxRegister372) + uint32_t(r_PtxRegister5);  // PTX L150
	r_PtxRegister15 = r_Scalar64Bits & -4;									  // PTX L151
	r_bPtxPredicate15 = uint32_t(r_PtxRegister15) != uint32_t(4);			  // PTX L152
	r_bPtxPredicate16 = uint32_t(r_PtxRegister15) == uint32_t(4);			  // PTX L153
	r_bPtxPredicate17 = int32_t(r_PtxRegister376) >= int32_t(r_PtxRegister6); // PTX L154
	r_PtxRegister377 = uint32_t(r_PtxRegister376) * uint32_t(r_PtxRegister7); // PTX L155
	r_PtxRegister16 = r_bPtxPredicate16 ? 0 : r_PtxRegister377;				  // PTX L156
	r_bPtxPredicate539 = bool(0);											  // PTX L157
	r_bPtxPredicate18 = r_bPtxPredicate15 & r_bPtxPredicate17;				  // PTX L158
	r_PtxRegister1940 = uint32_t(r_PtxRegister14);							  // PTX L159
	if (r_bPtxPredicate18)
	{
		goto L__BB39_5;
	} // PTX L160
	r_PtxRegister378 = r_Scalar68Bits & -4;						   // PTX L161
	r_bPtxPredicate19 = uint32_t(r_PtxRegister378) == uint32_t(4); // PTX L162
	r_bPtxPredicate539 = bool(-1);								   // PTX L163
	r_PtxRegister1940 = uint32_t(0);							   // PTX L164
	if (r_bPtxPredicate19)
	{
		goto L__BB39_5;
	} // PTX L165
	r_bPtxPredicate539 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister7); // PTX L166
	r_PtxRegister1940 = uint32_t(r_PtxRegister14);							 // PTX L167
L__BB39_5:																	 // PTX L168
	r_PtxU64Register263 = uint64_t(0);										 // PTX L169
	r_bPtxPredicate20 = !r_bPtxPredicate539;								 // PTX L170
	if (r_bPtxPredicate20)
	{
		goto L__BB39_7;
	} // PTX L171
	r_PtxRegister379 = uint32_t(r_PtxRegister16) + uint32_t(r_PtxRegister1940); // PTX L172
	r_PtxRegister380 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister379);			// PTX L173
	r_PtxRegister381 = ShiftLeft(uint32_t(r_PtxRegister380), uint32_t(11));		// PTX L174
	r_PtxRegister382 = r_PtxRegister381 | r_PtxRegister13;						// PTX L175
	r_PtxU64Register263 = SignExtendWordBits(r_PtxRegister382);					// PTX L176
L__BB39_7:																		// PTX L177
	r_PtxRegister383 = uint32_t(r_PtxRegister12) + uint32_t(r_PtxRegister13);	// PTX L178
	r_PtxRegister384 = ShiftLeft(uint32_t(r_PtxRegister383), uint32_t(2));		// PTX L179
	r_PtxRegister385 = uint32_t(0u /* exact native shared-region offset */);	// PTX L180
	r_PtxRegister17 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister384);	// PTX L181
	if (r_bPtxPredicate20)
	{
		goto L__BB39_10;
	} // PTX L182
	r_PtxRegister393 = uint32_t(-1);							   // PTX L183
	r_PtxRegister392 = Elected(r_PtxRegister393);				   // PTX L185
	r_bPtxPredicate21 = uint32_t(r_PtxRegister392) == uint32_t(0); // PTX L191
	if (r_bPtxPredicate21)
	{
		goto L__BB39_11;
	} // PTX L192
	r_PtxU64Register35 = r_Pointer0Bits;											  // PTX L193
	r_PtxU64Register36 = ShiftLeft(uint64_t(r_PtxU64Register263), uint32_t(2));		  // PTX L194
	r_PtxU64Register34 = uint64_t(r_PtxU64Register35) + uint64_t(r_PtxU64Register36); // PTX L195
	r_PtxRegister395 = uint32_t(8192u /* exact native shared-region offset */);		  // PTX L196
	r_PtxRegister394 = uint32_t(512);												  // PTX L197
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister17, r_PtxU64Register34, r_PtxRegister394,
			 r_PtxRegister395);																  // PTX L199
	BarrierExpect(s_SharedStorage, r_PtxRegister395, r_PtxRegister394);						  // PTX L202
	goto L__BB39_11;																		  // PTX L204
L__BB39_10:																					  // PTX L205
	r_PtxRegister386 = uint32_t(0);															  // PTX L206
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister386))); // PTX L208
	r_PackedHalf2AtPtx211R387 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);		  // PTX L211
	r_ConvertedE4PairAtPtx213Rs2 = PublishE4(r_PackedHalf2AtPtx211R387);					  // PTX L213
	r_PackedE4WordAtPtx215R390 =
		JoinHalfwords(r_ConvertedE4PairAtPtx213Rs2, r_ConvertedE4PairAtPtx213Rs2); // PTX L215
	r_LaneIndexAtPtx217 = uint32_t((threadIdx.x & 31u));						   // PTX L217
	r_PtxRegister391 = ShiftLeft(uint32_t(r_LaneIndexAtPtx217), uint32_t(4));	   // PTX L219
	r_PtxRegister389 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister391);	   // PTX L220
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister389)) =
		make_uint4(r_PackedE4WordAtPtx215R390, r_PackedE4WordAtPtx215R390, r_PackedE4WordAtPtx215R390,
				   r_PackedE4WordAtPtx215R390);								  // PTX L222
L__BB39_11:																	  // PTX L224
	r_bPtxPredicate22 = uint32_t(r_PtxRegister15) != uint32_t(4);			  // PTX L225
	r_bPtxPredicate23 = uint32_t(r_PtxRegister15) == uint32_t(4);			  // PTX L226
	r_PtxRegister396 = uint32_t(r_ThreadY) + uint32_t(4);					  // PTX L227
	r_PtxRegister397 = ShiftRight(uint32_t(r_PtxRegister396), uint32_t(2));	  // PTX L228
	r_PtxRegister398 = ShiftLeft(uint32_t(r_PtxRegister397), uint32_t(9));	  // PTX L229
	r_PtxRegister18 = r_PtxRegister398 | r_PtxRegister11;					  // PTX L230
	r_PtxRegister399 = uint32_t(r_PtxRegister397) + uint32_t(r_PtxRegister4); // PTX L231
	r_bPtxPredicate24 = int32_t(r_PtxRegister399) >= int32_t(r_PtxRegister6); // PTX L232
	r_PtxRegister400 = uint32_t(r_PtxRegister399) * uint32_t(r_PtxRegister7); // PTX L233
	r_PtxRegister19 = r_bPtxPredicate23 ? 0 : r_PtxRegister400;				  // PTX L234
	r_bPtxPredicate540 = bool(0);											  // PTX L235
	r_bPtxPredicate25 = r_bPtxPredicate22 & r_bPtxPredicate24;				  // PTX L236
	r_PtxRegister1941 = uint32_t(r_PtxRegister14);							  // PTX L237
	if (r_bPtxPredicate25)
	{
		goto L__BB39_14;
	} // PTX L238
	r_PtxRegister401 = r_Scalar68Bits & -4;						   // PTX L239
	r_bPtxPredicate26 = uint32_t(r_PtxRegister401) == uint32_t(4); // PTX L240
	r_bPtxPredicate540 = bool(-1);								   // PTX L241
	r_PtxRegister1941 = uint32_t(0);							   // PTX L242
	if (r_bPtxPredicate26)
	{
		goto L__BB39_14;
	} // PTX L243
	r_bPtxPredicate540 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister7); // PTX L244
	r_PtxRegister1941 = uint32_t(r_PtxRegister14);							 // PTX L245
L__BB39_14:																	 // PTX L246
	r_PtxU64Register264 = uint64_t(0);										 // PTX L247
	r_bPtxPredicate27 = !r_bPtxPredicate540;								 // PTX L248
	if (r_bPtxPredicate27)
	{
		goto L__BB39_16;
	} // PTX L249
	r_PtxRegister402 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1941); // PTX L250
	r_PtxRegister403 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister402);			// PTX L251
	r_PtxRegister404 = ShiftLeft(uint32_t(r_PtxRegister403), uint32_t(11));		// PTX L252
	r_PtxRegister405 = r_PtxRegister404 | r_PtxRegister13;						// PTX L253
	r_PtxU64Register264 = SignExtendWordBits(r_PtxRegister405);					// PTX L254
L__BB39_16:																		// PTX L255
	r_PtxRegister406 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister13);	// PTX L256
	r_PtxRegister407 = ShiftLeft(uint32_t(r_PtxRegister406), uint32_t(2));		// PTX L257
	r_PtxRegister408 = uint32_t(0u /* exact native shared-region offset */);	// PTX L258
	r_PtxRegister20 = uint32_t(r_PtxRegister408) + uint32_t(r_PtxRegister407);	// PTX L259
	if (r_bPtxPredicate27)
	{
		goto L__BB39_19;
	} // PTX L260
	r_PtxRegister416 = uint32_t(-1);							   // PTX L261
	r_PtxRegister415 = Elected(r_PtxRegister416);				   // PTX L263
	r_bPtxPredicate28 = uint32_t(r_PtxRegister415) == uint32_t(0); // PTX L269
	if (r_bPtxPredicate28)
	{
		goto L__BB39_20;
	} // PTX L270
	r_PtxU64Register38 = r_Pointer0Bits;											  // PTX L271
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register264), uint32_t(2));		  // PTX L272
	r_PtxU64Register37 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register39); // PTX L273
	r_PtxRegister418 = uint32_t(8192u /* exact native shared-region offset */);		  // PTX L274
	r_PtxRegister417 = uint32_t(512);												  // PTX L275
	CopyBulk(s_SharedStorage, r_PtxRegister20, r_PtxU64Register37, r_PtxRegister417,
			 r_PtxRegister418);																  // PTX L277
	BarrierExpect(s_SharedStorage, r_PtxRegister418, r_PtxRegister417);						  // PTX L280
	goto L__BB39_20;																		  // PTX L282
L__BB39_19:																					  // PTX L283
	r_PtxRegister409 = uint32_t(0);															  // PTX L284
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister409))); // PTX L286
	r_PackedHalf2AtPtx289R410 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		  // PTX L289
	r_ConvertedE4PairAtPtx291Rs4 = PublishE4(r_PackedHalf2AtPtx289R410);					  // PTX L291
	r_PackedE4WordAtPtx293R413 =
		JoinHalfwords(r_ConvertedE4PairAtPtx291Rs4, r_ConvertedE4PairAtPtx291Rs4); // PTX L293
	r_LaneIndexAtPtx295 = uint32_t((threadIdx.x & 31u));						   // PTX L295
	r_PtxRegister414 = ShiftLeft(uint32_t(r_LaneIndexAtPtx295), uint32_t(4));	   // PTX L297
	r_PtxRegister412 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister414);	   // PTX L298
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister412)) =
		make_uint4(r_PackedE4WordAtPtx293R413, r_PackedE4WordAtPtx293R413, r_PackedE4WordAtPtx293R413,
				   r_PackedE4WordAtPtx293R413);									// PTX L300
L__BB39_20:																		// PTX L302
	r_PtxRegister419 = uint32_t(8192u /* exact native shared-region offset */); // PTX L303
	r_PtxRegister420 = uint32_t(1);												// PTX L304
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register40 = BarrierArrive(s_SharedStorage, r_PtxRegister419, r_PtxRegister420); // PTX L306
L__BB39_21:																					 // PTX L308
	r_PtxRegister422 = uint32_t(8192u /* exact native shared-region offset */);				 // PTX L309
	r_PtxRegister421 = BarrierReady(s_SharedStorage, r_PtxRegister422, r_PtxU64Register40);	 // PTX L311
	r_bPtxPredicate29 = uint32_t(r_PtxRegister421) == uint32_t(0);							 // PTX L317
	if (r_bPtxPredicate29)
	{
		goto L__BB39_21;
	} // PTX L318
	r_bPtxPredicate1 = uint32_t(r_PtxRegister15) != uint32_t(4);			// PTX L319
	r_bPtxPredicate30 = uint32_t(r_PtxRegister15) == uint32_t(4);			// PTX L320
	r_PtxRegister21 = r_Scalar68Bits & -4;									// PTX L321
	r_bPtxPredicate31 = uint32_t(r_PtxRegister21) == uint32_t(4);			// PTX L322
	r_bPtxPredicate32 = int32_t(r_PtxRegister4) < int32_t(r_PtxRegister6);	// PTX L323
	r_bPtxPredicate33 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6); // PTX L324
	r_PtxRegister22 = uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7);	// PTX L325
	r_PtxRegister23 = r_bPtxPredicate30 ? 0 : r_PtxRegister22;				// PTX L326
	r_bPtxPredicate34 = r_bPtxPredicate1 & r_bPtxPredicate33;				// PTX L327
	r_bPtxPredicate2 = r_bPtxPredicate30 | r_bPtxPredicate32;				// PTX L328
	r_bPtxPredicate3 = r_bPtxPredicate34 | r_bPtxPredicate31;				// PTX L329
	r_bPtxPredicate35 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	// PTX L330
	r_bPtxPredicate36 = !r_bPtxPredicate34;									// PTX L331
	r_bPtxPredicate4 = r_bPtxPredicate31 & r_bPtxPredicate36;				// PTX L332
	r_PtxRegister24 = r_bPtxPredicate4 ? 0 : r_PtxRegister5;				// PTX L333
	r_bPtxPredicate37 = r_bPtxPredicate3 | r_bPtxPredicate35;				// PTX L334
	r_bPtxPredicate5 = r_bPtxPredicate37 & r_bPtxPredicate2;				// PTX L335
	if (r_bPtxPredicate5)
	{
		goto L__BB39_24;
	} // PTX L336
	goto L__BB39_23;																			 // PTX L337
L__BB39_24:																						 // PTX L338
	r_PtxRegister426 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister24);					 // PTX L339
	r_PtxRegister427 = ShiftLeft(uint32_t(r_PtxRegister426), uint32_t(11));						 // PTX L340
	r_PtxRegister428 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L341
	r_PtxRegister429 = uint32_t(r_PtxRegister427) + uint32_t(r_PtxRegister428);					 // PTX L342
	r_PtxU64Register42 = uint64_t(int64_t(int32_t(r_PtxRegister429)) * int64_t(int32_t(4)));	 // PTX L343
	r_PtxU64Register43 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register42);				 // PTX L344
	r_LaneIndexAtPtx346 = uint32_t((threadIdx.x & 31u));										 // PTX L346
	r_PtxU64Register44 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx346)) * int64_t(int32_t(16))); // PTX L348
	r_PtxU64Register41 = uint64_t(r_PtxU64Register43) + uint64_t(r_PtxU64Register44);			 // PTX L349
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register41));
		r_PtxRegister1942 = r_Value.x;
		r_PtxRegister1943 = r_Value.y;
		r_PtxRegister1944 = r_Value.z;
		r_PtxRegister1945 = r_Value.w;
	} // PTX L351
	goto L__BB39_25;																			   // PTX L353
L__BB39_23:																						   // PTX L354
	r_PtxRegister423 = uint32_t(0);																   // PTX L355
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister423)));	   // PTX L357
	r_PackedHalf2AtPtx360R424 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);			   // PTX L360
	r_ConvertedE4PairAtPtx362Rs6 = PublishE4(r_PackedHalf2AtPtx360R424);						   // PTX L362
	r_PtxRegister1942 = JoinHalfwords(r_ConvertedE4PairAtPtx362Rs6, r_ConvertedE4PairAtPtx362Rs6); // PTX L364
	r_PtxRegister1943 = uint32_t(r_PtxRegister1942);											   // PTX L365
	r_PtxRegister1944 = uint32_t(r_PtxRegister1942);											   // PTX L366
	r_PtxRegister1945 = uint32_t(r_PtxRegister1942);											   // PTX L367
L__BB39_25:																						   // PTX L368
	r_PtxU16Register21 = uint16_t(r_PtxRegister1942);
	r_PtxU16Register22 = uint16_t(r_PtxRegister1942 >> 16); // PTX L369
	r_PtxU16Register27 = uint16_t(r_PtxRegister1945);
	r_PtxU16Register28 = uint16_t(r_PtxRegister1945 >> 16); // PTX L370
	r_PtxU16Register25 = uint16_t(r_PtxRegister1944);
	r_PtxU16Register26 = uint16_t(r_PtxRegister1944 >> 16); // PTX L371
	r_PtxU16Register23 = uint16_t(r_PtxRegister1943);
	r_PtxU16Register24 = uint16_t(r_PtxRegister1943 >> 16); // PTX L372
	if (r_bPtxPredicate5)
	{
		goto L__BB39_27;
	} // PTX L373
	goto L__BB39_26;																			 // PTX L374
L__BB39_27:																						 // PTX L375
	r_PtxRegister433 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister24);					 // PTX L376
	r_PtxRegister434 = ShiftLeft(uint32_t(r_PtxRegister433), uint32_t(11));						 // PTX L377
	r_PtxRegister435 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L378
	r_PtxRegister436 = uint32_t(r_PtxRegister434) + uint32_t(r_PtxRegister435);					 // PTX L379
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister436)) * int64_t(int32_t(4)));	 // PTX L380
	r_PtxU64Register47 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register46);				 // PTX L381
	r_LaneIndexAtPtx383 = uint32_t((threadIdx.x & 31u));										 // PTX L383
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx383)) * int64_t(int32_t(16))); // PTX L385
	r_PtxU64Register45 = uint64_t(r_PtxU64Register47) + uint64_t(r_PtxU64Register48);			 // PTX L386
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register45));
		r_PtxRegister1946 = r_Value.x;
		r_PtxRegister1947 = r_Value.y;
		r_PtxRegister1948 = r_Value.z;
		r_PtxRegister1949 = r_Value.w;
	} // PTX L388
	goto L__BB39_28;																			   // PTX L390
L__BB39_26:																						   // PTX L391
	r_PtxRegister430 = uint32_t(0);																   // PTX L392
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister430)));	   // PTX L394
	r_PackedHalf2AtPtx397R431 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);			   // PTX L397
	r_ConvertedE4PairAtPtx399Rs8 = PublishE4(r_PackedHalf2AtPtx397R431);						   // PTX L399
	r_PtxRegister1946 = JoinHalfwords(r_ConvertedE4PairAtPtx399Rs8, r_ConvertedE4PairAtPtx399Rs8); // PTX L401
	r_PtxRegister1947 = uint32_t(r_PtxRegister1946);											   // PTX L402
	r_PtxRegister1948 = uint32_t(r_PtxRegister1946);											   // PTX L403
	r_PtxRegister1949 = uint32_t(r_PtxRegister1946);											   // PTX L404
L__BB39_28:																						   // PTX L405
	r_PtxRegister25 = uint32_t(r_PtxRegister5) + uint32_t(1);									   // PTX L406
	r_PtxU16Register35 = uint16_t(r_PtxRegister1949);
	r_PtxU16Register36 = uint16_t(r_PtxRegister1949 >> 16); // PTX L407
	r_PtxU16Register33 = uint16_t(r_PtxRegister1948);
	r_PtxU16Register34 = uint16_t(r_PtxRegister1948 >> 16); // PTX L408
	r_PtxU16Register31 = uint16_t(r_PtxRegister1947);
	r_PtxU16Register32 = uint16_t(r_PtxRegister1947 >> 16); // PTX L409
	r_PtxU16Register29 = uint16_t(r_PtxRegister1946);
	r_PtxU16Register30 = uint16_t(r_PtxRegister1946 >> 16);					// PTX L410
	r_bPtxPredicate38 = int32_t(r_PtxRegister25) < int32_t(r_PtxRegister7); // PTX L411
	r_PtxRegister26 = r_bPtxPredicate4 ? 0 : r_PtxRegister25;				// PTX L412
	r_bPtxPredicate39 = r_bPtxPredicate3 | r_bPtxPredicate38;				// PTX L413
	r_bPtxPredicate6 = r_bPtxPredicate39 & r_bPtxPredicate2;				// PTX L414
	if (r_bPtxPredicate6)
	{
		goto L__BB39_30;
	} // PTX L415
	goto L__BB39_29;																			 // PTX L416
L__BB39_30:																						 // PTX L417
	r_PtxRegister440 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister26);					 // PTX L418
	r_PtxRegister441 = ShiftLeft(uint32_t(r_PtxRegister440), uint32_t(11));						 // PTX L419
	r_PtxRegister442 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L420
	r_PtxRegister443 = uint32_t(r_PtxRegister441) + uint32_t(r_PtxRegister442);					 // PTX L421
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister443)) * int64_t(int32_t(4)));	 // PTX L422
	r_PtxU64Register51 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register50);				 // PTX L423
	r_LaneIndexAtPtx425 = uint32_t((threadIdx.x & 31u));										 // PTX L425
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx425)) * int64_t(int32_t(16))); // PTX L427
	r_PtxU64Register49 = uint64_t(r_PtxU64Register51) + uint64_t(r_PtxU64Register52);			 // PTX L428
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register49));
		r_PtxRegister1950 = r_Value.x;
		r_PtxRegister1951 = r_Value.y;
		r_PtxRegister1952 = r_Value.z;
		r_PtxRegister1953 = r_Value.w;
	} // PTX L430
	goto L__BB39_31;																		  // PTX L432
L__BB39_29:																					  // PTX L433
	r_PtxRegister437 = uint32_t(0);															  // PTX L434
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister437))); // PTX L436
	r_PackedHalf2AtPtx439R438 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L439
	r_ConvertedE4PairAtPtx441Rs10 = PublishE4(r_PackedHalf2AtPtx439R438);					  // PTX L441
	r_PtxRegister1950 =
		JoinHalfwords(r_ConvertedE4PairAtPtx441Rs10, r_ConvertedE4PairAtPtx441Rs10); // PTX L443
	r_PtxRegister1951 = uint32_t(r_PtxRegister1950);								 // PTX L444
	r_PtxRegister1952 = uint32_t(r_PtxRegister1950);								 // PTX L445
	r_PtxRegister1953 = uint32_t(r_PtxRegister1950);								 // PTX L446
L__BB39_31:																			 // PTX L447
	r_PtxU16Register37 = uint16_t(r_PtxRegister1950);
	r_PtxU16Register38 = uint16_t(r_PtxRegister1950 >> 16); // PTX L448
	r_PtxU16Register43 = uint16_t(r_PtxRegister1953);
	r_PtxU16Register44 = uint16_t(r_PtxRegister1953 >> 16); // PTX L449
	r_PtxU16Register41 = uint16_t(r_PtxRegister1952);
	r_PtxU16Register42 = uint16_t(r_PtxRegister1952 >> 16); // PTX L450
	r_PtxU16Register39 = uint16_t(r_PtxRegister1951);
	r_PtxU16Register40 = uint16_t(r_PtxRegister1951 >> 16); // PTX L451
	if (r_bPtxPredicate6)
	{
		goto L__BB39_33;
	} // PTX L452
	goto L__BB39_32;																			 // PTX L453
L__BB39_33:																						 // PTX L454
	r_PtxRegister447 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister26);					 // PTX L455
	r_PtxRegister448 = ShiftLeft(uint32_t(r_PtxRegister447), uint32_t(11));						 // PTX L456
	r_PtxRegister449 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L457
	r_PtxRegister450 = uint32_t(r_PtxRegister448) + uint32_t(r_PtxRegister449);					 // PTX L458
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister450)) * int64_t(int32_t(4)));	 // PTX L459
	r_PtxU64Register55 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register54);				 // PTX L460
	r_LaneIndexAtPtx462 = uint32_t((threadIdx.x & 31u));										 // PTX L462
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx462)) * int64_t(int32_t(16))); // PTX L464
	r_PtxU64Register53 = uint64_t(r_PtxU64Register55) + uint64_t(r_PtxU64Register56);			 // PTX L465
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register53));
		r_PtxRegister1954 = r_Value.x;
		r_PtxRegister1955 = r_Value.y;
		r_PtxRegister1956 = r_Value.z;
		r_PtxRegister1957 = r_Value.w;
	} // PTX L467
	goto L__BB39_34;																		   // PTX L469
L__BB39_32:																					   // PTX L470
	r_PtxRegister444 = uint32_t(0);															   // PTX L471
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister444))); // PTX L473
	r_PackedHalf2AtPtx476R445 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L476
	r_ConvertedE4PairAtPtx478Rs12 = PublishE4(r_PackedHalf2AtPtx476R445);					   // PTX L478
	r_PtxRegister1954 =
		JoinHalfwords(r_ConvertedE4PairAtPtx478Rs12, r_ConvertedE4PairAtPtx478Rs12); // PTX L480
	r_PtxRegister1955 = uint32_t(r_PtxRegister1954);								 // PTX L481
	r_PtxRegister1956 = uint32_t(r_PtxRegister1954);								 // PTX L482
	r_PtxRegister1957 = uint32_t(r_PtxRegister1954);								 // PTX L483
L__BB39_34:																			 // PTX L484
	r_bPtxPredicate40 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);			 // PTX L485
	r_PtxU16Register51 = uint16_t(r_PtxRegister1957);
	r_PtxU16Register52 = uint16_t(r_PtxRegister1957 >> 16); // PTX L486
	r_PtxU16Register49 = uint16_t(r_PtxRegister1956);
	r_PtxU16Register50 = uint16_t(r_PtxRegister1956 >> 16); // PTX L487
	r_PtxU16Register47 = uint16_t(r_PtxRegister1955);
	r_PtxU16Register48 = uint16_t(r_PtxRegister1955 >> 16); // PTX L488
	r_PtxU16Register45 = uint16_t(r_PtxRegister1954);
	r_PtxU16Register46 = uint16_t(r_PtxRegister1954 >> 16);					  // PTX L489
	r_bPtxPredicate41 = uint32_t(r_PtxRegister21) == uint32_t(4);			  // PTX L490
	r_bPtxPredicate42 = uint32_t(r_PtxRegister15) == uint32_t(4);			  // PTX L491
	r_PtxRegister451 = uint32_t(r_PtxRegister4) + uint32_t(1);				  // PTX L492
	r_bPtxPredicate43 = int32_t(r_PtxRegister451) < int32_t(r_PtxRegister6);  // PTX L493
	r_bPtxPredicate44 = int32_t(r_PtxRegister451) >= int32_t(r_PtxRegister6); // PTX L494
	r_PtxRegister452 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister7);  // PTX L495
	r_PtxRegister27 = r_bPtxPredicate42 ? 0 : r_PtxRegister452;				  // PTX L496
	r_bPtxPredicate45 = r_bPtxPredicate1 & r_bPtxPredicate44;				  // PTX L497
	r_bPtxPredicate7 = r_bPtxPredicate42 | r_bPtxPredicate43;				  // PTX L498
	r_bPtxPredicate8 = r_bPtxPredicate45 | r_bPtxPredicate41;				  // PTX L499
	r_bPtxPredicate46 = !r_bPtxPredicate45;									  // PTX L500
	r_bPtxPredicate9 = r_bPtxPredicate41 & r_bPtxPredicate46;				  // PTX L501
	r_PtxRegister28 = r_bPtxPredicate9 ? 0 : r_PtxRegister5;				  // PTX L502
	r_bPtxPredicate47 = r_bPtxPredicate8 | r_bPtxPredicate40;				  // PTX L503
	r_bPtxPredicate10 = r_bPtxPredicate47 & r_bPtxPredicate7;				  // PTX L504
	if (r_bPtxPredicate10)
	{
		goto L__BB39_36;
	} // PTX L505
	goto L__BB39_35;																			 // PTX L506
L__BB39_36:																						 // PTX L507
	r_PtxRegister456 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister28);					 // PTX L508
	r_PtxRegister457 = ShiftLeft(uint32_t(r_PtxRegister456), uint32_t(11));						 // PTX L509
	r_PtxRegister458 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L510
	r_PtxRegister459 = uint32_t(r_PtxRegister457) + uint32_t(r_PtxRegister458);					 // PTX L511
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister459)) * int64_t(int32_t(4)));	 // PTX L512
	r_PtxU64Register59 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register58);				 // PTX L513
	r_LaneIndexAtPtx515 = uint32_t((threadIdx.x & 31u));										 // PTX L515
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx515)) * int64_t(int32_t(16))); // PTX L517
	r_PtxU64Register57 = uint64_t(r_PtxU64Register59) + uint64_t(r_PtxU64Register60);			 // PTX L518
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register57));
		r_PtxRegister1958 = r_Value.x;
		r_PtxRegister1959 = r_Value.y;
		r_PtxRegister1960 = r_Value.z;
		r_PtxRegister1961 = r_Value.w;
	} // PTX L520
	goto L__BB39_37;																		   // PTX L522
L__BB39_35:																					   // PTX L523
	r_PtxRegister453 = uint32_t(0);															   // PTX L524
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister453))); // PTX L526
	r_PackedHalf2AtPtx529R454 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L529
	r_ConvertedE4PairAtPtx531Rs14 = PublishE4(r_PackedHalf2AtPtx529R454);					   // PTX L531
	r_PtxRegister1958 =
		JoinHalfwords(r_ConvertedE4PairAtPtx531Rs14, r_ConvertedE4PairAtPtx531Rs14); // PTX L533
	r_PtxRegister1959 = uint32_t(r_PtxRegister1958);								 // PTX L534
	r_PtxRegister1960 = uint32_t(r_PtxRegister1958);								 // PTX L535
	r_PtxRegister1961 = uint32_t(r_PtxRegister1958);								 // PTX L536
L__BB39_37:																			 // PTX L537
	r_PtxU16Register53 = uint16_t(r_PtxRegister1958);
	r_PtxU16Register54 = uint16_t(r_PtxRegister1958 >> 16); // PTX L538
	r_PtxU16Register59 = uint16_t(r_PtxRegister1961);
	r_PtxU16Register60 = uint16_t(r_PtxRegister1961 >> 16); // PTX L539
	r_PtxU16Register57 = uint16_t(r_PtxRegister1960);
	r_PtxU16Register58 = uint16_t(r_PtxRegister1960 >> 16); // PTX L540
	r_PtxU16Register55 = uint16_t(r_PtxRegister1959);
	r_PtxU16Register56 = uint16_t(r_PtxRegister1959 >> 16); // PTX L541
	if (r_bPtxPredicate10)
	{
		goto L__BB39_39;
	} // PTX L542
	goto L__BB39_38;																			 // PTX L543
L__BB39_39:																						 // PTX L544
	r_PtxRegister463 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister28);					 // PTX L545
	r_PtxRegister464 = ShiftLeft(uint32_t(r_PtxRegister463), uint32_t(11));						 // PTX L546
	r_PtxRegister465 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L547
	r_PtxRegister466 = uint32_t(r_PtxRegister464) + uint32_t(r_PtxRegister465);					 // PTX L548
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister466)) * int64_t(int32_t(4)));	 // PTX L549
	r_PtxU64Register63 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register62);				 // PTX L550
	r_LaneIndexAtPtx552 = uint32_t((threadIdx.x & 31u));										 // PTX L552
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx552)) * int64_t(int32_t(16))); // PTX L554
	r_PtxU64Register61 = uint64_t(r_PtxU64Register63) + uint64_t(r_PtxU64Register64);			 // PTX L555
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register61));
		r_PtxRegister1962 = r_Value.x;
		r_PtxRegister1963 = r_Value.y;
		r_PtxRegister1964 = r_Value.z;
		r_PtxRegister1965 = r_Value.w;
	} // PTX L557
	goto L__BB39_40;																		   // PTX L559
L__BB39_38:																					   // PTX L560
	r_PtxRegister460 = uint32_t(0);															   // PTX L561
	r_PtxU16Register15 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister460))); // PTX L563
	r_PackedHalf2AtPtx566R461 = JoinHalfwords(r_PtxU16Register15, r_PtxU16Register15);		   // PTX L566
	r_ConvertedE4PairAtPtx568Rs16 = PublishE4(r_PackedHalf2AtPtx566R461);					   // PTX L568
	r_PtxRegister1962 =
		JoinHalfwords(r_ConvertedE4PairAtPtx568Rs16, r_ConvertedE4PairAtPtx568Rs16); // PTX L570
	r_PtxRegister1963 = uint32_t(r_PtxRegister1962);								 // PTX L571
	r_PtxRegister1964 = uint32_t(r_PtxRegister1962);								 // PTX L572
	r_PtxRegister1965 = uint32_t(r_PtxRegister1962);								 // PTX L573
L__BB39_40:																			 // PTX L574
	r_bPtxPredicate48 = int32_t(r_PtxRegister25) < int32_t(r_PtxRegister7);			 // PTX L575
	r_PtxU16Register67 = uint16_t(r_PtxRegister1965);
	r_PtxU16Register68 = uint16_t(r_PtxRegister1965 >> 16); // PTX L576
	r_PtxU16Register65 = uint16_t(r_PtxRegister1964);
	r_PtxU16Register66 = uint16_t(r_PtxRegister1964 >> 16); // PTX L577
	r_PtxU16Register63 = uint16_t(r_PtxRegister1963);
	r_PtxU16Register64 = uint16_t(r_PtxRegister1963 >> 16); // PTX L578
	r_PtxU16Register61 = uint16_t(r_PtxRegister1962);
	r_PtxU16Register62 = uint16_t(r_PtxRegister1962 >> 16);	  // PTX L579
	r_PtxRegister29 = r_bPtxPredicate9 ? 0 : r_PtxRegister25; // PTX L580
	r_bPtxPredicate49 = r_bPtxPredicate8 | r_bPtxPredicate48; // PTX L581
	r_bPtxPredicate11 = r_bPtxPredicate49 & r_bPtxPredicate7; // PTX L582
	if (r_bPtxPredicate11)
	{
		goto L__BB39_42;
	} // PTX L583
	goto L__BB39_41;																			 // PTX L584
L__BB39_42:																						 // PTX L585
	r_PtxRegister470 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister29);					 // PTX L586
	r_PtxRegister471 = ShiftLeft(uint32_t(r_PtxRegister470), uint32_t(11));						 // PTX L587
	r_PtxRegister472 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L588
	r_PtxRegister473 = uint32_t(r_PtxRegister471) + uint32_t(r_PtxRegister472);					 // PTX L589
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister473)) * int64_t(int32_t(4)));	 // PTX L590
	r_PtxU64Register67 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register66);				 // PTX L591
	r_LaneIndexAtPtx593 = uint32_t((threadIdx.x & 31u));										 // PTX L593
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx593)) * int64_t(int32_t(16))); // PTX L595
	r_PtxU64Register65 = uint64_t(r_PtxU64Register67) + uint64_t(r_PtxU64Register68);			 // PTX L596
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register65));
		r_PtxRegister1966 = r_Value.x;
		r_PtxRegister1967 = r_Value.y;
		r_PtxRegister1968 = r_Value.z;
		r_PtxRegister1969 = r_Value.w;
	} // PTX L598
	goto L__BB39_43;																		   // PTX L600
L__BB39_41:																					   // PTX L601
	r_PtxRegister467 = uint32_t(0);															   // PTX L602
	r_PtxU16Register17 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister467))); // PTX L604
	r_PackedHalf2AtPtx607R468 = JoinHalfwords(r_PtxU16Register17, r_PtxU16Register17);		   // PTX L607
	r_ConvertedE4PairAtPtx609Rs18 = PublishE4(r_PackedHalf2AtPtx607R468);					   // PTX L609
	r_PtxRegister1966 =
		JoinHalfwords(r_ConvertedE4PairAtPtx609Rs18, r_ConvertedE4PairAtPtx609Rs18); // PTX L611
	r_PtxRegister1967 = uint32_t(r_PtxRegister1966);								 // PTX L612
	r_PtxRegister1968 = uint32_t(r_PtxRegister1966);								 // PTX L613
	r_PtxRegister1969 = uint32_t(r_PtxRegister1966);								 // PTX L614
L__BB39_43:																			 // PTX L615
	r_PtxU16Register69 = uint16_t(r_PtxRegister1966);
	r_PtxU16Register70 = uint16_t(r_PtxRegister1966 >> 16); // PTX L616
	r_PtxU16Register75 = uint16_t(r_PtxRegister1969);
	r_PtxU16Register76 = uint16_t(r_PtxRegister1969 >> 16); // PTX L617
	r_PtxU16Register73 = uint16_t(r_PtxRegister1968);
	r_PtxU16Register74 = uint16_t(r_PtxRegister1968 >> 16); // PTX L618
	r_PtxU16Register71 = uint16_t(r_PtxRegister1967);
	r_PtxU16Register72 = uint16_t(r_PtxRegister1967 >> 16); // PTX L619
	if (r_bPtxPredicate11)
	{
		goto L__BB39_45;
	} // PTX L620
	goto L__BB39_44;																			 // PTX L621
L__BB39_45:																						 // PTX L622
	r_PtxRegister477 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister29);					 // PTX L623
	r_PtxRegister478 = ShiftLeft(uint32_t(r_PtxRegister477), uint32_t(11));						 // PTX L624
	r_PtxRegister479 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L625
	r_PtxRegister480 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister479);					 // PTX L626
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister480)) * int64_t(int32_t(4)));	 // PTX L627
	r_PtxU64Register71 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register70);				 // PTX L628
	r_LaneIndexAtPtx630 = uint32_t((threadIdx.x & 31u));										 // PTX L630
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx630)) * int64_t(int32_t(16))); // PTX L632
	r_PtxU64Register69 = uint64_t(r_PtxU64Register71) + uint64_t(r_PtxU64Register72);			 // PTX L633
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register69));
		r_PtxRegister1970 = r_Value.x;
		r_PtxRegister1971 = r_Value.y;
		r_PtxRegister1972 = r_Value.z;
		r_PtxRegister1973 = r_Value.w;
	} // PTX L635
	goto L__BB39_46;																		   // PTX L637
L__BB39_44:																					   // PTX L638
	r_PtxRegister474 = uint32_t(0);															   // PTX L639
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister474))); // PTX L641
	r_PackedHalf2AtPtx644R475 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L644
	r_ConvertedE4PairAtPtx646Rs20 = PublishE4(r_PackedHalf2AtPtx644R475);					   // PTX L646
	r_PtxRegister1970 =
		JoinHalfwords(r_ConvertedE4PairAtPtx646Rs20, r_ConvertedE4PairAtPtx646Rs20); // PTX L648
	r_PtxRegister1971 = uint32_t(r_PtxRegister1970);								 // PTX L649
	r_PtxRegister1972 = uint32_t(r_PtxRegister1970);								 // PTX L650
	r_PtxRegister1973 = uint32_t(r_PtxRegister1970);								 // PTX L651
L__BB39_46:																			 // PTX L652
	r_PackedHalf2AtPtx654R546 = DecodeE4(r_PtxU16Register21);						 // PTX L654
	r_PackedHalf2AtPtx657R552 = DecodeE4(r_PtxU16Register22);						 // PTX L657
	r_PackedHalf2AtPtx660R549 = DecodeE4(r_PtxU16Register23);						 // PTX L660
	r_PackedHalf2AtPtx663R555 = DecodeE4(r_PtxU16Register24);						 // PTX L663
	r_PackedHalf2AtPtx666R558 = DecodeE4(r_PtxU16Register25);						 // PTX L666
	r_PackedHalf2AtPtx669R564 = DecodeE4(r_PtxU16Register26);						 // PTX L669
	r_PackedHalf2AtPtx672R561 = DecodeE4(r_PtxU16Register27);						 // PTX L672
	r_PackedHalf2AtPtx675R567 = DecodeE4(r_PtxU16Register28);						 // PTX L675
	r_PackedHalf2AtPtx678R570 = DecodeE4(r_PtxU16Register29);						 // PTX L678
	r_PackedHalf2AtPtx681R576 = DecodeE4(r_PtxU16Register30);						 // PTX L681
	r_PackedHalf2AtPtx684R573 = DecodeE4(r_PtxU16Register31);						 // PTX L684
	r_PackedHalf2AtPtx687R579 = DecodeE4(r_PtxU16Register32);						 // PTX L687
	r_PackedHalf2AtPtx690R582 = DecodeE4(r_PtxU16Register33);						 // PTX L690
	r_PackedHalf2AtPtx693R588 = DecodeE4(r_PtxU16Register34);						 // PTX L693
	r_PackedHalf2AtPtx696R585 = DecodeE4(r_PtxU16Register35);						 // PTX L696
	r_PackedHalf2AtPtx699R591 = DecodeE4(r_PtxU16Register36);						 // PTX L699
	r_PackedHalf2AtPtx702R594 = DecodeE4(r_PtxU16Register37);						 // PTX L702
	r_PackedHalf2AtPtx705R600 = DecodeE4(r_PtxU16Register38);						 // PTX L705
	r_PackedHalf2AtPtx708R597 = DecodeE4(r_PtxU16Register39);						 // PTX L708
	r_PackedHalf2AtPtx711R603 = DecodeE4(r_PtxU16Register40);						 // PTX L711
	r_PackedHalf2AtPtx714R606 = DecodeE4(r_PtxU16Register41);						 // PTX L714
	r_PackedHalf2AtPtx717R612 = DecodeE4(r_PtxU16Register42);						 // PTX L717
	r_PackedHalf2AtPtx720R609 = DecodeE4(r_PtxU16Register43);						 // PTX L720
	r_PackedHalf2AtPtx723R615 = DecodeE4(r_PtxU16Register44);						 // PTX L723
	r_PackedHalf2AtPtx726R618 = DecodeE4(r_PtxU16Register45);						 // PTX L726
	r_PackedHalf2AtPtx729R624 = DecodeE4(r_PtxU16Register46);						 // PTX L729
	r_PackedHalf2AtPtx732R621 = DecodeE4(r_PtxU16Register47);						 // PTX L732
	r_PackedHalf2AtPtx735R627 = DecodeE4(r_PtxU16Register48);						 // PTX L735
	r_PackedHalf2AtPtx738R630 = DecodeE4(r_PtxU16Register49);						 // PTX L738
	r_PackedHalf2AtPtx741R636 = DecodeE4(r_PtxU16Register50);						 // PTX L741
	r_PackedHalf2AtPtx744R633 = DecodeE4(r_PtxU16Register51);						 // PTX L744
	r_PackedHalf2AtPtx747R639 = DecodeE4(r_PtxU16Register52);						 // PTX L747
	r_PackedHalf2AtPtx750R642 = DecodeE4(r_PtxU16Register53);						 // PTX L750
	r_PackedHalf2AtPtx753R648 = DecodeE4(r_PtxU16Register54);						 // PTX L753
	r_PackedHalf2AtPtx756R645 = DecodeE4(r_PtxU16Register55);						 // PTX L756
	r_PackedHalf2AtPtx759R651 = DecodeE4(r_PtxU16Register56);						 // PTX L759
	r_PackedHalf2AtPtx762R654 = DecodeE4(r_PtxU16Register57);						 // PTX L762
	r_PackedHalf2AtPtx765R660 = DecodeE4(r_PtxU16Register58);						 // PTX L765
	r_PackedHalf2AtPtx768R657 = DecodeE4(r_PtxU16Register59);						 // PTX L768
	r_PackedHalf2AtPtx771R663 = DecodeE4(r_PtxU16Register60);						 // PTX L771
	r_PackedHalf2AtPtx774R666 = DecodeE4(r_PtxU16Register61);						 // PTX L774
	r_PackedHalf2AtPtx777R672 = DecodeE4(r_PtxU16Register62);						 // PTX L777
	r_PackedHalf2AtPtx780R669 = DecodeE4(r_PtxU16Register63);						 // PTX L780
	r_PackedHalf2AtPtx783R675 = DecodeE4(r_PtxU16Register64);						 // PTX L783
	r_PackedHalf2AtPtx786R678 = DecodeE4(r_PtxU16Register65);						 // PTX L786
	r_PackedHalf2AtPtx789R684 = DecodeE4(r_PtxU16Register66);						 // PTX L789
	r_PackedHalf2AtPtx792R681 = DecodeE4(r_PtxU16Register67);						 // PTX L792
	r_PackedHalf2AtPtx795R687 = DecodeE4(r_PtxU16Register68);						 // PTX L795
	r_PackedHalf2AtPtx798R690 = DecodeE4(r_PtxU16Register69);						 // PTX L798
	r_PackedHalf2AtPtx801R696 = DecodeE4(r_PtxU16Register70);						 // PTX L801
	r_PackedHalf2AtPtx804R693 = DecodeE4(r_PtxU16Register71);						 // PTX L804
	r_PackedHalf2AtPtx807R699 = DecodeE4(r_PtxU16Register72);						 // PTX L807
	r_PackedHalf2AtPtx810R702 = DecodeE4(r_PtxU16Register73);						 // PTX L810
	r_PackedHalf2AtPtx813R708 = DecodeE4(r_PtxU16Register74);						 // PTX L813
	r_PackedHalf2AtPtx816R705 = DecodeE4(r_PtxU16Register75);						 // PTX L816
	r_PackedHalf2AtPtx819R711 = DecodeE4(r_PtxU16Register76);						 // PTX L819
	r_PtxU16Register77 = uint16_t(r_PtxRegister1970);
	r_PtxU16Register78 = uint16_t(r_PtxRegister1970 >> 16);	  // PTX L821
	r_PackedHalf2AtPtx823R714 = DecodeE4(r_PtxU16Register77); // PTX L823
	r_PackedHalf2AtPtx826R720 = DecodeE4(r_PtxU16Register78); // PTX L826
	r_PtxU16Register79 = uint16_t(r_PtxRegister1971);
	r_PtxU16Register80 = uint16_t(r_PtxRegister1971 >> 16);	  // PTX L828
	r_PackedHalf2AtPtx830R717 = DecodeE4(r_PtxU16Register79); // PTX L830
	r_PackedHalf2AtPtx833R723 = DecodeE4(r_PtxU16Register80); // PTX L833
	r_PtxU16Register81 = uint16_t(r_PtxRegister1972);
	r_PtxU16Register82 = uint16_t(r_PtxRegister1972 >> 16);	  // PTX L835
	r_PackedHalf2AtPtx837R726 = DecodeE4(r_PtxU16Register81); // PTX L837
	r_PackedHalf2AtPtx840R732 = DecodeE4(r_PtxU16Register82); // PTX L840
	r_PtxU16Register83 = uint16_t(r_PtxRegister1973);
	r_PtxU16Register84 = uint16_t(r_PtxRegister1973 >> 16);									   // PTX L842
	r_PackedHalf2AtPtx844R729 = DecodeE4(r_PtxU16Register83);								   // PTX L844
	r_PackedHalf2AtPtx847R735 = DecodeE4(r_PtxU16Register84);								   // PTX L847
	r_PtxU64Register73 = r_Pointer32Bits;													   // PTX L849
	r_PtxRegister737 = uint32_t(r_PtxRegister9) + uint32_t(16);								   // PTX L850
	r_PtxRegister738 = uint32_t(r_PtxRegister9) + uint32_t(8);								   // PTX L851
	r_LaneIndexAtPtx853 = uint32_t((threadIdx.x & 31u));									   // PTX L853
	r_PtxRegister739 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx853), uint32_t(31));		   // PTX L855
	r_PtxRegister740 = ShiftRight(uint32_t(r_PtxRegister739), uint32_t(30));				   // PTX L856
	r_PtxRegister741 = uint32_t(r_LaneIndexAtPtx853) + uint32_t(r_PtxRegister740);			   // PTX L857
	r_PtxRegister742 = r_PtxRegister741 & 2147483644;										   // PTX L858
	r_PtxRegister743 = uint32_t(r_LaneIndexAtPtx853) - uint32_t(r_PtxRegister742);			   // PTX L859
	r_PtxRegister744 = ShiftLeft(uint32_t(r_PtxRegister743), uint32_t(1));					   // PTX L860
	r_PtxRegister745 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister744);				   // PTX L861
	r_PtxRegister746 = ShiftRightSigned(int32_t(r_PtxRegister745), uint32_t(1));			   // PTX L862
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister746)) * int64_t(int32_t(4)));   // PTX L863
	r_PtxU64Register75 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register74);		   // PTX L864
	r_PtxRegister547 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register75 + 262144ull);	   // PTX L865
	r_LaneIndexAtPtx867 = uint32_t((threadIdx.x & 31u));									   // PTX L867
	r_PtxRegister747 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx867), uint32_t(31));		   // PTX L869
	r_PtxRegister748 = ShiftRight(uint32_t(r_PtxRegister747), uint32_t(30));				   // PTX L870
	r_PtxRegister749 = uint32_t(r_LaneIndexAtPtx867) + uint32_t(r_PtxRegister748);			   // PTX L871
	r_PtxRegister750 = r_PtxRegister749 & 2147483644;										   // PTX L872
	r_PtxRegister751 = uint32_t(r_LaneIndexAtPtx867) - uint32_t(r_PtxRegister750);			   // PTX L873
	r_PtxRegister752 = ShiftLeft(uint32_t(r_PtxRegister751), uint32_t(1));					   // PTX L874
	r_PtxRegister753 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister752);				   // PTX L875
	r_PtxRegister754 = ShiftRightSigned(int32_t(r_PtxRegister753), uint32_t(1));			   // PTX L876
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister754)) * int64_t(int32_t(4)));   // PTX L877
	r_PtxU64Register77 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register76);		   // PTX L878
	r_PtxRegister550 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register77 + 262144ull);	   // PTX L879
	r_LaneIndexAtPtx881 = uint32_t((threadIdx.x & 31u));									   // PTX L881
	r_PtxRegister755 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx881), uint32_t(31));		   // PTX L883
	r_PtxRegister756 = ShiftRight(uint32_t(r_PtxRegister755), uint32_t(30));				   // PTX L884
	r_PtxRegister757 = uint32_t(r_LaneIndexAtPtx881) + uint32_t(r_PtxRegister756);			   // PTX L885
	r_PtxRegister758 = r_PtxRegister757 & 2147483644;										   // PTX L886
	r_PtxRegister759 = uint32_t(r_LaneIndexAtPtx881) - uint32_t(r_PtxRegister758);			   // PTX L887
	r_PtxRegister760 = ShiftLeft(uint32_t(r_PtxRegister759), uint32_t(1));					   // PTX L888
	r_PtxRegister761 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister760);				   // PTX L889
	r_PtxRegister762 = ShiftRightSigned(int32_t(r_PtxRegister761), uint32_t(1));			   // PTX L890
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister762)) * int64_t(int32_t(4)));   // PTX L891
	r_PtxU64Register79 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register78);		   // PTX L892
	r_PtxRegister553 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register79 + 262144ull);	   // PTX L893
	r_LaneIndexAtPtx895 = uint32_t((threadIdx.x & 31u));									   // PTX L895
	r_PtxRegister763 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx895), uint32_t(31));		   // PTX L897
	r_PtxRegister764 = ShiftRight(uint32_t(r_PtxRegister763), uint32_t(30));				   // PTX L898
	r_PtxRegister765 = uint32_t(r_LaneIndexAtPtx895) + uint32_t(r_PtxRegister764);			   // PTX L899
	r_PtxRegister766 = r_PtxRegister765 & 2147483644;										   // PTX L900
	r_PtxRegister767 = uint32_t(r_LaneIndexAtPtx895) - uint32_t(r_PtxRegister766);			   // PTX L901
	r_PtxRegister768 = ShiftLeft(uint32_t(r_PtxRegister767), uint32_t(1));					   // PTX L902
	r_PtxRegister769 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister768);				   // PTX L903
	r_PtxRegister770 = ShiftRightSigned(int32_t(r_PtxRegister769), uint32_t(1));			   // PTX L904
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_PtxRegister770)) * int64_t(int32_t(4)));   // PTX L905
	r_PtxU64Register81 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register80);		   // PTX L906
	r_PtxRegister556 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register81 + 262144ull);	   // PTX L907
	r_LaneIndexAtPtx909 = uint32_t((threadIdx.x & 31u));									   // PTX L909
	r_PtxRegister771 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx909), uint32_t(31));		   // PTX L911
	r_PtxRegister772 = ShiftRight(uint32_t(r_PtxRegister771), uint32_t(30));				   // PTX L912
	r_PtxRegister773 = uint32_t(r_LaneIndexAtPtx909) + uint32_t(r_PtxRegister772);			   // PTX L913
	r_PtxRegister774 = r_PtxRegister773 & 2147483644;										   // PTX L914
	r_PtxRegister775 = uint32_t(r_LaneIndexAtPtx909) - uint32_t(r_PtxRegister774);			   // PTX L915
	r_PtxRegister776 = ShiftLeft(uint32_t(r_PtxRegister775), uint32_t(1));					   // PTX L916
	r_PtxRegister777 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister776);				   // PTX L917
	r_PtxRegister778 = ShiftRightSigned(int32_t(r_PtxRegister777), uint32_t(1));			   // PTX L918
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister778)) * int64_t(int32_t(4)));   // PTX L919
	r_PtxU64Register83 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register82);		   // PTX L920
	r_PtxRegister559 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register83 + 262144ull);	   // PTX L921
	r_LaneIndexAtPtx923 = uint32_t((threadIdx.x & 31u));									   // PTX L923
	r_PtxRegister779 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx923), uint32_t(31));		   // PTX L925
	r_PtxRegister780 = ShiftRight(uint32_t(r_PtxRegister779), uint32_t(30));				   // PTX L926
	r_PtxRegister781 = uint32_t(r_LaneIndexAtPtx923) + uint32_t(r_PtxRegister780);			   // PTX L927
	r_PtxRegister782 = r_PtxRegister781 & 2147483644;										   // PTX L928
	r_PtxRegister783 = uint32_t(r_LaneIndexAtPtx923) - uint32_t(r_PtxRegister782);			   // PTX L929
	r_PtxRegister784 = ShiftLeft(uint32_t(r_PtxRegister783), uint32_t(1));					   // PTX L930
	r_PtxRegister785 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister784);				   // PTX L931
	r_PtxRegister786 = ShiftRightSigned(int32_t(r_PtxRegister785), uint32_t(1));			   // PTX L932
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister786)) * int64_t(int32_t(4)));   // PTX L933
	r_PtxU64Register85 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register84);		   // PTX L934
	r_PtxRegister562 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register85 + 262144ull);	   // PTX L935
	r_LaneIndexAtPtx937 = uint32_t((threadIdx.x & 31u));									   // PTX L937
	r_PtxRegister787 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx937), uint32_t(31));		   // PTX L939
	r_PtxRegister788 = ShiftRight(uint32_t(r_PtxRegister787), uint32_t(30));				   // PTX L940
	r_PtxRegister789 = uint32_t(r_LaneIndexAtPtx937) + uint32_t(r_PtxRegister788);			   // PTX L941
	r_PtxRegister790 = r_PtxRegister789 & 2147483644;										   // PTX L942
	r_PtxRegister791 = uint32_t(r_LaneIndexAtPtx937) - uint32_t(r_PtxRegister790);			   // PTX L943
	r_PtxRegister792 = ShiftLeft(uint32_t(r_PtxRegister791), uint32_t(1));					   // PTX L944
	r_PtxRegister793 = uint32_t(r_PtxRegister9) + uint32_t(24);								   // PTX L945
	r_PtxRegister794 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister792);				   // PTX L946
	r_PtxRegister795 = ShiftRight(uint32_t(r_PtxRegister794), uint32_t(31));				   // PTX L947
	r_PtxRegister796 = uint32_t(r_PtxRegister794) + uint32_t(r_PtxRegister795);				   // PTX L948
	r_PtxRegister797 = ShiftRightSigned(int32_t(r_PtxRegister796), uint32_t(1));			   // PTX L949
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister797)) * int64_t(int32_t(4)));   // PTX L950
	r_PtxU64Register87 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register86);		   // PTX L951
	r_PtxRegister565 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register87 + 262144ull);	   // PTX L952
	r_LaneIndexAtPtx954 = uint32_t((threadIdx.x & 31u));									   // PTX L954
	r_PtxRegister798 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx954), uint32_t(31));		   // PTX L956
	r_PtxRegister799 = ShiftRight(uint32_t(r_PtxRegister798), uint32_t(30));				   // PTX L957
	r_PtxRegister800 = uint32_t(r_LaneIndexAtPtx954) + uint32_t(r_PtxRegister799);			   // PTX L958
	r_PtxRegister801 = r_PtxRegister800 & 2147483644;										   // PTX L959
	r_PtxRegister802 = uint32_t(r_LaneIndexAtPtx954) - uint32_t(r_PtxRegister801);			   // PTX L960
	r_PtxRegister803 = ShiftLeft(uint32_t(r_PtxRegister802), uint32_t(1));					   // PTX L961
	r_PtxRegister804 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister803);				   // PTX L962
	r_PtxRegister805 = ShiftRight(uint32_t(r_PtxRegister804), uint32_t(31));				   // PTX L963
	r_PtxRegister806 = uint32_t(r_PtxRegister804) + uint32_t(r_PtxRegister805);				   // PTX L964
	r_PtxRegister807 = ShiftRightSigned(int32_t(r_PtxRegister806), uint32_t(1));			   // PTX L965
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_PtxRegister807)) * int64_t(int32_t(4)));   // PTX L966
	r_PtxU64Register89 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register88);		   // PTX L967
	r_PtxRegister568 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register89 + 262144ull);	   // PTX L968
	r_LaneIndexAtPtx970 = uint32_t((threadIdx.x & 31u));									   // PTX L970
	r_PtxRegister808 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx970), uint32_t(31));		   // PTX L972
	r_PtxRegister809 = ShiftRight(uint32_t(r_PtxRegister808), uint32_t(30));				   // PTX L973
	r_PtxRegister810 = uint32_t(r_LaneIndexAtPtx970) + uint32_t(r_PtxRegister809);			   // PTX L974
	r_PtxRegister811 = r_PtxRegister810 & 2147483644;										   // PTX L975
	r_PtxRegister812 = uint32_t(r_LaneIndexAtPtx970) - uint32_t(r_PtxRegister811);			   // PTX L976
	r_PtxRegister813 = ShiftLeft(uint32_t(r_PtxRegister812), uint32_t(1));					   // PTX L977
	r_PtxRegister814 = uint32_t(r_PtxRegister9) + uint32_t(32);								   // PTX L978
	r_PtxRegister815 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister813);				   // PTX L979
	r_PtxRegister816 = ShiftRightSigned(int32_t(r_PtxRegister815), uint32_t(1));			   // PTX L980
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister816)) * int64_t(int32_t(4)));   // PTX L981
	r_PtxU64Register91 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register90);		   // PTX L982
	r_PtxRegister571 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register91 + 262144ull);	   // PTX L983
	r_LaneIndexAtPtx985 = uint32_t((threadIdx.x & 31u));									   // PTX L985
	r_PtxRegister817 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx985), uint32_t(31));		   // PTX L987
	r_PtxRegister818 = ShiftRight(uint32_t(r_PtxRegister817), uint32_t(30));				   // PTX L988
	r_PtxRegister819 = uint32_t(r_LaneIndexAtPtx985) + uint32_t(r_PtxRegister818);			   // PTX L989
	r_PtxRegister820 = r_PtxRegister819 & 2147483644;										   // PTX L990
	r_PtxRegister821 = uint32_t(r_LaneIndexAtPtx985) - uint32_t(r_PtxRegister820);			   // PTX L991
	r_PtxRegister822 = ShiftLeft(uint32_t(r_PtxRegister821), uint32_t(1));					   // PTX L992
	r_PtxRegister823 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister822);				   // PTX L993
	r_PtxRegister824 = ShiftRightSigned(int32_t(r_PtxRegister823), uint32_t(1));			   // PTX L994
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister824)) * int64_t(int32_t(4)));   // PTX L995
	r_PtxU64Register93 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register92);		   // PTX L996
	r_PtxRegister574 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register93 + 262144ull);	   // PTX L997
	r_LaneIndexAtPtx999 = uint32_t((threadIdx.x & 31u));									   // PTX L999
	r_PtxRegister825 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx999), uint32_t(31));		   // PTX L1001
	r_PtxRegister826 = ShiftRight(uint32_t(r_PtxRegister825), uint32_t(30));				   // PTX L1002
	r_PtxRegister827 = uint32_t(r_LaneIndexAtPtx999) + uint32_t(r_PtxRegister826);			   // PTX L1003
	r_PtxRegister828 = r_PtxRegister827 & 2147483644;										   // PTX L1004
	r_PtxRegister829 = uint32_t(r_LaneIndexAtPtx999) - uint32_t(r_PtxRegister828);			   // PTX L1005
	r_PtxRegister830 = ShiftLeft(uint32_t(r_PtxRegister829), uint32_t(1));					   // PTX L1006
	r_PtxRegister831 = uint32_t(r_PtxRegister9) + uint32_t(40);								   // PTX L1007
	r_PtxRegister832 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister830);				   // PTX L1008
	r_PtxRegister833 = ShiftRight(uint32_t(r_PtxRegister832), uint32_t(31));				   // PTX L1009
	r_PtxRegister834 = uint32_t(r_PtxRegister832) + uint32_t(r_PtxRegister833);				   // PTX L1010
	r_PtxRegister835 = ShiftRightSigned(int32_t(r_PtxRegister834), uint32_t(1));			   // PTX L1011
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister835)) * int64_t(int32_t(4)));   // PTX L1012
	r_PtxU64Register95 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register94);		   // PTX L1013
	r_PtxRegister577 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register95 + 262144ull);	   // PTX L1014
	r_LaneIndexAtPtx1016 = uint32_t((threadIdx.x & 31u));									   // PTX L1016
	r_PtxRegister836 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1016), uint32_t(31));		   // PTX L1018
	r_PtxRegister837 = ShiftRight(uint32_t(r_PtxRegister836), uint32_t(30));				   // PTX L1019
	r_PtxRegister838 = uint32_t(r_LaneIndexAtPtx1016) + uint32_t(r_PtxRegister837);			   // PTX L1020
	r_PtxRegister839 = r_PtxRegister838 & 2147483644;										   // PTX L1021
	r_PtxRegister840 = uint32_t(r_LaneIndexAtPtx1016) - uint32_t(r_PtxRegister839);			   // PTX L1022
	r_PtxRegister841 = ShiftLeft(uint32_t(r_PtxRegister840), uint32_t(1));					   // PTX L1023
	r_PtxRegister842 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister841);				   // PTX L1024
	r_PtxRegister843 = ShiftRight(uint32_t(r_PtxRegister842), uint32_t(31));				   // PTX L1025
	r_PtxRegister844 = uint32_t(r_PtxRegister842) + uint32_t(r_PtxRegister843);				   // PTX L1026
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_PtxRegister844), uint32_t(1));			   // PTX L1027
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_PtxRegister845)) * int64_t(int32_t(4)));   // PTX L1028
	r_PtxU64Register97 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register96);		   // PTX L1029
	r_PtxRegister580 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register97 + 262144ull);	   // PTX L1030
	r_LaneIndexAtPtx1032 = uint32_t((threadIdx.x & 31u));									   // PTX L1032
	r_PtxRegister846 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1032), uint32_t(31));		   // PTX L1034
	r_PtxRegister847 = ShiftRight(uint32_t(r_PtxRegister846), uint32_t(30));				   // PTX L1035
	r_PtxRegister848 = uint32_t(r_LaneIndexAtPtx1032) + uint32_t(r_PtxRegister847);			   // PTX L1036
	r_PtxRegister849 = r_PtxRegister848 & 2147483644;										   // PTX L1037
	r_PtxRegister850 = uint32_t(r_LaneIndexAtPtx1032) - uint32_t(r_PtxRegister849);			   // PTX L1038
	r_PtxRegister851 = ShiftLeft(uint32_t(r_PtxRegister850), uint32_t(1));					   // PTX L1039
	r_PtxRegister852 = uint32_t(r_PtxRegister9) + uint32_t(48);								   // PTX L1040
	r_PtxRegister853 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister851);				   // PTX L1041
	r_PtxRegister854 = ShiftRightSigned(int32_t(r_PtxRegister853), uint32_t(1));			   // PTX L1042
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister854)) * int64_t(int32_t(4)));   // PTX L1043
	r_PtxU64Register99 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register98);		   // PTX L1044
	r_PtxRegister583 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register99 + 262144ull);	   // PTX L1045
	r_LaneIndexAtPtx1047 = uint32_t((threadIdx.x & 31u));									   // PTX L1047
	r_PtxRegister855 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1047), uint32_t(31));		   // PTX L1049
	r_PtxRegister856 = ShiftRight(uint32_t(r_PtxRegister855), uint32_t(30));				   // PTX L1050
	r_PtxRegister857 = uint32_t(r_LaneIndexAtPtx1047) + uint32_t(r_PtxRegister856);			   // PTX L1051
	r_PtxRegister858 = r_PtxRegister857 & 2147483644;										   // PTX L1052
	r_PtxRegister859 = uint32_t(r_LaneIndexAtPtx1047) - uint32_t(r_PtxRegister858);			   // PTX L1053
	r_PtxRegister860 = ShiftLeft(uint32_t(r_PtxRegister859), uint32_t(1));					   // PTX L1054
	r_PtxRegister861 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister860);				   // PTX L1055
	r_PtxRegister862 = ShiftRightSigned(int32_t(r_PtxRegister861), uint32_t(1));			   // PTX L1056
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_PtxRegister862)) * int64_t(int32_t(4)));  // PTX L1057
	r_PtxU64Register101 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register100);		   // PTX L1058
	r_PtxRegister586 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register101 + 262144ull);	   // PTX L1059
	r_LaneIndexAtPtx1061 = uint32_t((threadIdx.x & 31u));									   // PTX L1061
	r_PtxRegister863 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1061), uint32_t(31));		   // PTX L1063
	r_PtxRegister864 = ShiftRight(uint32_t(r_PtxRegister863), uint32_t(30));				   // PTX L1064
	r_PtxRegister865 = uint32_t(r_LaneIndexAtPtx1061) + uint32_t(r_PtxRegister864);			   // PTX L1065
	r_PtxRegister866 = r_PtxRegister865 & 2147483644;										   // PTX L1066
	r_PtxRegister867 = uint32_t(r_LaneIndexAtPtx1061) - uint32_t(r_PtxRegister866);			   // PTX L1067
	r_PtxRegister868 = ShiftLeft(uint32_t(r_PtxRegister867), uint32_t(1));					   // PTX L1068
	r_PtxRegister869 = uint32_t(r_PtxRegister9) + uint32_t(56);								   // PTX L1069
	r_PtxRegister870 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister868);				   // PTX L1070
	r_PtxRegister871 = ShiftRight(uint32_t(r_PtxRegister870), uint32_t(31));				   // PTX L1071
	r_PtxRegister872 = uint32_t(r_PtxRegister870) + uint32_t(r_PtxRegister871);				   // PTX L1072
	r_PtxRegister873 = ShiftRightSigned(int32_t(r_PtxRegister872), uint32_t(1));			   // PTX L1073
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister873)) * int64_t(int32_t(4)));  // PTX L1074
	r_PtxU64Register103 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register102);		   // PTX L1075
	r_PtxRegister589 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register103 + 262144ull);	   // PTX L1076
	r_LaneIndexAtPtx1078 = uint32_t((threadIdx.x & 31u));									   // PTX L1078
	r_PtxRegister874 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1078), uint32_t(31));		   // PTX L1080
	r_PtxRegister875 = ShiftRight(uint32_t(r_PtxRegister874), uint32_t(30));				   // PTX L1081
	r_PtxRegister876 = uint32_t(r_LaneIndexAtPtx1078) + uint32_t(r_PtxRegister875);			   // PTX L1082
	r_PtxRegister877 = r_PtxRegister876 & 2147483644;										   // PTX L1083
	r_PtxRegister878 = uint32_t(r_LaneIndexAtPtx1078) - uint32_t(r_PtxRegister877);			   // PTX L1084
	r_PtxRegister879 = ShiftLeft(uint32_t(r_PtxRegister878), uint32_t(1));					   // PTX L1085
	r_PtxRegister880 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister879);				   // PTX L1086
	r_PtxRegister881 = ShiftRight(uint32_t(r_PtxRegister880), uint32_t(31));				   // PTX L1087
	r_PtxRegister882 = uint32_t(r_PtxRegister880) + uint32_t(r_PtxRegister881);				   // PTX L1088
	r_PtxRegister883 = ShiftRightSigned(int32_t(r_PtxRegister882), uint32_t(1));			   // PTX L1089
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_PtxRegister883)) * int64_t(int32_t(4)));  // PTX L1090
	r_PtxU64Register105 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register104);		   // PTX L1091
	r_PtxRegister592 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register105 + 262144ull);	   // PTX L1092
	r_LaneIndexAtPtx1094 = uint32_t((threadIdx.x & 31u));									   // PTX L1094
	r_PtxRegister884 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1094), uint32_t(31));		   // PTX L1096
	r_PtxRegister885 = ShiftRight(uint32_t(r_PtxRegister884), uint32_t(30));				   // PTX L1097
	r_PtxRegister886 = uint32_t(r_LaneIndexAtPtx1094) + uint32_t(r_PtxRegister885);			   // PTX L1098
	r_PtxRegister887 = r_PtxRegister886 & 2147483644;										   // PTX L1099
	r_PtxRegister888 = uint32_t(r_LaneIndexAtPtx1094) - uint32_t(r_PtxRegister887);			   // PTX L1100
	r_PtxRegister889 = ShiftLeft(uint32_t(r_PtxRegister888), uint32_t(1));					   // PTX L1101
	r_PtxRegister890 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister889);				   // PTX L1102
	r_PtxRegister891 = ShiftRightSigned(int32_t(r_PtxRegister890), uint32_t(1));			   // PTX L1103
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister891)) * int64_t(int32_t(4)));  // PTX L1104
	r_PtxU64Register107 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register106);		   // PTX L1105
	r_PtxRegister595 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register107 + 262144ull);	   // PTX L1106
	r_LaneIndexAtPtx1108 = uint32_t((threadIdx.x & 31u));									   // PTX L1108
	r_PtxRegister892 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1108), uint32_t(31));		   // PTX L1110
	r_PtxRegister893 = ShiftRight(uint32_t(r_PtxRegister892), uint32_t(30));				   // PTX L1111
	r_PtxRegister894 = uint32_t(r_LaneIndexAtPtx1108) + uint32_t(r_PtxRegister893);			   // PTX L1112
	r_PtxRegister895 = r_PtxRegister894 & 2147483644;										   // PTX L1113
	r_PtxRegister896 = uint32_t(r_LaneIndexAtPtx1108) - uint32_t(r_PtxRegister895);			   // PTX L1114
	r_PtxRegister897 = ShiftLeft(uint32_t(r_PtxRegister896), uint32_t(1));					   // PTX L1115
	r_PtxRegister898 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister897);				   // PTX L1116
	r_PtxRegister899 = ShiftRightSigned(int32_t(r_PtxRegister898), uint32_t(1));			   // PTX L1117
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_PtxRegister899)) * int64_t(int32_t(4)));  // PTX L1118
	r_PtxU64Register109 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register108);		   // PTX L1119
	r_PtxRegister598 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register109 + 262144ull);	   // PTX L1120
	r_LaneIndexAtPtx1122 = uint32_t((threadIdx.x & 31u));									   // PTX L1122
	r_PtxRegister900 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1122), uint32_t(31));		   // PTX L1124
	r_PtxRegister901 = ShiftRight(uint32_t(r_PtxRegister900), uint32_t(30));				   // PTX L1125
	r_PtxRegister902 = uint32_t(r_LaneIndexAtPtx1122) + uint32_t(r_PtxRegister901);			   // PTX L1126
	r_PtxRegister903 = r_PtxRegister902 & 2147483644;										   // PTX L1127
	r_PtxRegister904 = uint32_t(r_LaneIndexAtPtx1122) - uint32_t(r_PtxRegister903);			   // PTX L1128
	r_PtxRegister905 = ShiftLeft(uint32_t(r_PtxRegister904), uint32_t(1));					   // PTX L1129
	r_PtxRegister906 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister905);				   // PTX L1130
	r_PtxRegister907 = ShiftRightSigned(int32_t(r_PtxRegister906), uint32_t(1));			   // PTX L1131
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister907)) * int64_t(int32_t(4)));  // PTX L1132
	r_PtxU64Register111 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register110);		   // PTX L1133
	r_PtxRegister601 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register111 + 262144ull);	   // PTX L1134
	r_LaneIndexAtPtx1136 = uint32_t((threadIdx.x & 31u));									   // PTX L1136
	r_PtxRegister908 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1136), uint32_t(31));		   // PTX L1138
	r_PtxRegister909 = ShiftRight(uint32_t(r_PtxRegister908), uint32_t(30));				   // PTX L1139
	r_PtxRegister910 = uint32_t(r_LaneIndexAtPtx1136) + uint32_t(r_PtxRegister909);			   // PTX L1140
	r_PtxRegister911 = r_PtxRegister910 & 2147483644;										   // PTX L1141
	r_PtxRegister912 = uint32_t(r_LaneIndexAtPtx1136) - uint32_t(r_PtxRegister911);			   // PTX L1142
	r_PtxRegister913 = ShiftLeft(uint32_t(r_PtxRegister912), uint32_t(1));					   // PTX L1143
	r_PtxRegister914 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister913);				   // PTX L1144
	r_PtxRegister915 = ShiftRightSigned(int32_t(r_PtxRegister914), uint32_t(1));			   // PTX L1145
	r_PtxU64Register112 = uint64_t(int64_t(int32_t(r_PtxRegister915)) * int64_t(int32_t(4)));  // PTX L1146
	r_PtxU64Register113 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register112);		   // PTX L1147
	r_PtxRegister604 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register113 + 262144ull);	   // PTX L1148
	r_LaneIndexAtPtx1150 = uint32_t((threadIdx.x & 31u));									   // PTX L1150
	r_PtxRegister916 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1150), uint32_t(31));		   // PTX L1152
	r_PtxRegister917 = ShiftRight(uint32_t(r_PtxRegister916), uint32_t(30));				   // PTX L1153
	r_PtxRegister918 = uint32_t(r_LaneIndexAtPtx1150) + uint32_t(r_PtxRegister917);			   // PTX L1154
	r_PtxRegister919 = r_PtxRegister918 & 2147483644;										   // PTX L1155
	r_PtxRegister920 = uint32_t(r_LaneIndexAtPtx1150) - uint32_t(r_PtxRegister919);			   // PTX L1156
	r_PtxRegister921 = ShiftLeft(uint32_t(r_PtxRegister920), uint32_t(1));					   // PTX L1157
	r_PtxRegister922 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister921);				   // PTX L1158
	r_PtxRegister923 = ShiftRightSigned(int32_t(r_PtxRegister922), uint32_t(1));			   // PTX L1159
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister923)) * int64_t(int32_t(4)));  // PTX L1160
	r_PtxU64Register115 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register114);		   // PTX L1161
	r_PtxRegister607 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register115 + 262144ull);	   // PTX L1162
	r_LaneIndexAtPtx1164 = uint32_t((threadIdx.x & 31u));									   // PTX L1164
	r_PtxRegister924 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1164), uint32_t(31));		   // PTX L1166
	r_PtxRegister925 = ShiftRight(uint32_t(r_PtxRegister924), uint32_t(30));				   // PTX L1167
	r_PtxRegister926 = uint32_t(r_LaneIndexAtPtx1164) + uint32_t(r_PtxRegister925);			   // PTX L1168
	r_PtxRegister927 = r_PtxRegister926 & 2147483644;										   // PTX L1169
	r_PtxRegister928 = uint32_t(r_LaneIndexAtPtx1164) - uint32_t(r_PtxRegister927);			   // PTX L1170
	r_PtxRegister929 = ShiftLeft(uint32_t(r_PtxRegister928), uint32_t(1));					   // PTX L1171
	r_PtxRegister930 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister929);				   // PTX L1172
	r_PtxRegister931 = ShiftRightSigned(int32_t(r_PtxRegister930), uint32_t(1));			   // PTX L1173
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister931)) * int64_t(int32_t(4)));  // PTX L1174
	r_PtxU64Register117 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register116);		   // PTX L1175
	r_PtxRegister610 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register117 + 262144ull);	   // PTX L1176
	r_LaneIndexAtPtx1178 = uint32_t((threadIdx.x & 31u));									   // PTX L1178
	r_PtxRegister932 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1178), uint32_t(31));		   // PTX L1180
	r_PtxRegister933 = ShiftRight(uint32_t(r_PtxRegister932), uint32_t(30));				   // PTX L1181
	r_PtxRegister934 = uint32_t(r_LaneIndexAtPtx1178) + uint32_t(r_PtxRegister933);			   // PTX L1182
	r_PtxRegister935 = r_PtxRegister934 & 2147483644;										   // PTX L1183
	r_PtxRegister936 = uint32_t(r_LaneIndexAtPtx1178) - uint32_t(r_PtxRegister935);			   // PTX L1184
	r_PtxRegister937 = ShiftLeft(uint32_t(r_PtxRegister936), uint32_t(1));					   // PTX L1185
	r_PtxRegister938 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister937);				   // PTX L1186
	r_PtxRegister939 = ShiftRight(uint32_t(r_PtxRegister938), uint32_t(31));				   // PTX L1187
	r_PtxRegister940 = uint32_t(r_PtxRegister938) + uint32_t(r_PtxRegister939);				   // PTX L1188
	r_PtxRegister941 = ShiftRightSigned(int32_t(r_PtxRegister940), uint32_t(1));			   // PTX L1189
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister941)) * int64_t(int32_t(4)));  // PTX L1190
	r_PtxU64Register119 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register118);		   // PTX L1191
	r_PtxRegister613 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register119 + 262144ull);	   // PTX L1192
	r_LaneIndexAtPtx1194 = uint32_t((threadIdx.x & 31u));									   // PTX L1194
	r_PtxRegister942 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1194), uint32_t(31));		   // PTX L1196
	r_PtxRegister943 = ShiftRight(uint32_t(r_PtxRegister942), uint32_t(30));				   // PTX L1197
	r_PtxRegister944 = uint32_t(r_LaneIndexAtPtx1194) + uint32_t(r_PtxRegister943);			   // PTX L1198
	r_PtxRegister945 = r_PtxRegister944 & 2147483644;										   // PTX L1199
	r_PtxRegister946 = uint32_t(r_LaneIndexAtPtx1194) - uint32_t(r_PtxRegister945);			   // PTX L1200
	r_PtxRegister947 = ShiftLeft(uint32_t(r_PtxRegister946), uint32_t(1));					   // PTX L1201
	r_PtxRegister948 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister947);				   // PTX L1202
	r_PtxRegister949 = ShiftRight(uint32_t(r_PtxRegister948), uint32_t(31));				   // PTX L1203
	r_PtxRegister950 = uint32_t(r_PtxRegister948) + uint32_t(r_PtxRegister949);				   // PTX L1204
	r_PtxRegister951 = ShiftRightSigned(int32_t(r_PtxRegister950), uint32_t(1));			   // PTX L1205
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister951)) * int64_t(int32_t(4)));  // PTX L1206
	r_PtxU64Register121 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register120);		   // PTX L1207
	r_PtxRegister616 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register121 + 262144ull);	   // PTX L1208
	r_LaneIndexAtPtx1210 = uint32_t((threadIdx.x & 31u));									   // PTX L1210
	r_PtxRegister952 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1210), uint32_t(31));		   // PTX L1212
	r_PtxRegister953 = ShiftRight(uint32_t(r_PtxRegister952), uint32_t(30));				   // PTX L1213
	r_PtxRegister954 = uint32_t(r_LaneIndexAtPtx1210) + uint32_t(r_PtxRegister953);			   // PTX L1214
	r_PtxRegister955 = r_PtxRegister954 & 2147483644;										   // PTX L1215
	r_PtxRegister956 = uint32_t(r_LaneIndexAtPtx1210) - uint32_t(r_PtxRegister955);			   // PTX L1216
	r_PtxRegister957 = ShiftLeft(uint32_t(r_PtxRegister956), uint32_t(1));					   // PTX L1217
	r_PtxRegister958 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister957);				   // PTX L1218
	r_PtxRegister959 = ShiftRightSigned(int32_t(r_PtxRegister958), uint32_t(1));			   // PTX L1219
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister959)) * int64_t(int32_t(4)));  // PTX L1220
	r_PtxU64Register123 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register122);		   // PTX L1221
	r_PtxRegister619 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register123 + 262144ull);	   // PTX L1222
	r_LaneIndexAtPtx1224 = uint32_t((threadIdx.x & 31u));									   // PTX L1224
	r_PtxRegister960 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1224), uint32_t(31));		   // PTX L1226
	r_PtxRegister961 = ShiftRight(uint32_t(r_PtxRegister960), uint32_t(30));				   // PTX L1227
	r_PtxRegister962 = uint32_t(r_LaneIndexAtPtx1224) + uint32_t(r_PtxRegister961);			   // PTX L1228
	r_PtxRegister963 = r_PtxRegister962 & 2147483644;										   // PTX L1229
	r_PtxRegister964 = uint32_t(r_LaneIndexAtPtx1224) - uint32_t(r_PtxRegister963);			   // PTX L1230
	r_PtxRegister965 = ShiftLeft(uint32_t(r_PtxRegister964), uint32_t(1));					   // PTX L1231
	r_PtxRegister966 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister965);				   // PTX L1232
	r_PtxRegister967 = ShiftRightSigned(int32_t(r_PtxRegister966), uint32_t(1));			   // PTX L1233
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister967)) * int64_t(int32_t(4)));  // PTX L1234
	r_PtxU64Register125 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register124);		   // PTX L1235
	r_PtxRegister622 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register125 + 262144ull);	   // PTX L1236
	r_LaneIndexAtPtx1238 = uint32_t((threadIdx.x & 31u));									   // PTX L1238
	r_PtxRegister968 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1238), uint32_t(31));		   // PTX L1240
	r_PtxRegister969 = ShiftRight(uint32_t(r_PtxRegister968), uint32_t(30));				   // PTX L1241
	r_PtxRegister970 = uint32_t(r_LaneIndexAtPtx1238) + uint32_t(r_PtxRegister969);			   // PTX L1242
	r_PtxRegister971 = r_PtxRegister970 & 2147483644;										   // PTX L1243
	r_PtxRegister972 = uint32_t(r_LaneIndexAtPtx1238) - uint32_t(r_PtxRegister971);			   // PTX L1244
	r_PtxRegister973 = ShiftLeft(uint32_t(r_PtxRegister972), uint32_t(1));					   // PTX L1245
	r_PtxRegister974 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister973);				   // PTX L1246
	r_PtxRegister975 = ShiftRight(uint32_t(r_PtxRegister974), uint32_t(31));				   // PTX L1247
	r_PtxRegister976 = uint32_t(r_PtxRegister974) + uint32_t(r_PtxRegister975);				   // PTX L1248
	r_PtxRegister977 = ShiftRightSigned(int32_t(r_PtxRegister976), uint32_t(1));			   // PTX L1249
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister977)) * int64_t(int32_t(4)));  // PTX L1250
	r_PtxU64Register127 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register126);		   // PTX L1251
	r_PtxRegister625 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register127 + 262144ull);	   // PTX L1252
	r_LaneIndexAtPtx1254 = uint32_t((threadIdx.x & 31u));									   // PTX L1254
	r_PtxRegister978 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1254), uint32_t(31));		   // PTX L1256
	r_PtxRegister979 = ShiftRight(uint32_t(r_PtxRegister978), uint32_t(30));				   // PTX L1257
	r_PtxRegister980 = uint32_t(r_LaneIndexAtPtx1254) + uint32_t(r_PtxRegister979);			   // PTX L1258
	r_PtxRegister981 = r_PtxRegister980 & 2147483644;										   // PTX L1259
	r_PtxRegister982 = uint32_t(r_LaneIndexAtPtx1254) - uint32_t(r_PtxRegister981);			   // PTX L1260
	r_PtxRegister983 = ShiftLeft(uint32_t(r_PtxRegister982), uint32_t(1));					   // PTX L1261
	r_PtxRegister984 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister983);				   // PTX L1262
	r_PtxRegister985 = ShiftRight(uint32_t(r_PtxRegister984), uint32_t(31));				   // PTX L1263
	r_PtxRegister986 = uint32_t(r_PtxRegister984) + uint32_t(r_PtxRegister985);				   // PTX L1264
	r_PtxRegister987 = ShiftRightSigned(int32_t(r_PtxRegister986), uint32_t(1));			   // PTX L1265
	r_PtxU64Register128 = uint64_t(int64_t(int32_t(r_PtxRegister987)) * int64_t(int32_t(4)));  // PTX L1266
	r_PtxU64Register129 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register128);		   // PTX L1267
	r_PtxRegister628 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register129 + 262144ull);	   // PTX L1268
	r_LaneIndexAtPtx1270 = uint32_t((threadIdx.x & 31u));									   // PTX L1270
	r_PtxRegister988 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1270), uint32_t(31));		   // PTX L1272
	r_PtxRegister989 = ShiftRight(uint32_t(r_PtxRegister988), uint32_t(30));				   // PTX L1273
	r_PtxRegister990 = uint32_t(r_LaneIndexAtPtx1270) + uint32_t(r_PtxRegister989);			   // PTX L1274
	r_PtxRegister991 = r_PtxRegister990 & 2147483644;										   // PTX L1275
	r_PtxRegister992 = uint32_t(r_LaneIndexAtPtx1270) - uint32_t(r_PtxRegister991);			   // PTX L1276
	r_PtxRegister993 = ShiftLeft(uint32_t(r_PtxRegister992), uint32_t(1));					   // PTX L1277
	r_PtxRegister994 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister993);				   // PTX L1278
	r_PtxRegister995 = ShiftRightSigned(int32_t(r_PtxRegister994), uint32_t(1));			   // PTX L1279
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister995)) * int64_t(int32_t(4)));  // PTX L1280
	r_PtxU64Register131 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register130);		   // PTX L1281
	r_PtxRegister631 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register131 + 262144ull);	   // PTX L1282
	r_LaneIndexAtPtx1284 = uint32_t((threadIdx.x & 31u));									   // PTX L1284
	r_PtxRegister996 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1284), uint32_t(31));		   // PTX L1286
	r_PtxRegister997 = ShiftRight(uint32_t(r_PtxRegister996), uint32_t(30));				   // PTX L1287
	r_PtxRegister998 = uint32_t(r_LaneIndexAtPtx1284) + uint32_t(r_PtxRegister997);			   // PTX L1288
	r_PtxRegister999 = r_PtxRegister998 & 2147483644;										   // PTX L1289
	r_PtxRegister1000 = uint32_t(r_LaneIndexAtPtx1284) - uint32_t(r_PtxRegister999);		   // PTX L1290
	r_PtxRegister1001 = ShiftLeft(uint32_t(r_PtxRegister1000), uint32_t(1));				   // PTX L1291
	r_PtxRegister1002 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister1001);			   // PTX L1292
	r_PtxRegister1003 = ShiftRightSigned(int32_t(r_PtxRegister1002), uint32_t(1));			   // PTX L1293
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister1003)) * int64_t(int32_t(4))); // PTX L1294
	r_PtxU64Register133 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register132);		   // PTX L1295
	r_PtxRegister634 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register133 + 262144ull);	   // PTX L1296
	r_LaneIndexAtPtx1298 = uint32_t((threadIdx.x & 31u));									   // PTX L1298
	r_PtxRegister1004 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1298), uint32_t(31));		   // PTX L1300
	r_PtxRegister1005 = ShiftRight(uint32_t(r_PtxRegister1004), uint32_t(30));				   // PTX L1301
	r_PtxRegister1006 = uint32_t(r_LaneIndexAtPtx1298) + uint32_t(r_PtxRegister1005);		   // PTX L1302
	r_PtxRegister1007 = r_PtxRegister1006 & 2147483644;										   // PTX L1303
	r_PtxRegister1008 = uint32_t(r_LaneIndexAtPtx1298) - uint32_t(r_PtxRegister1007);		   // PTX L1304
	r_PtxRegister1009 = ShiftLeft(uint32_t(r_PtxRegister1008), uint32_t(1));				   // PTX L1305
	r_PtxRegister1010 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1009);			   // PTX L1306
	r_PtxRegister1011 = ShiftRight(uint32_t(r_PtxRegister1010), uint32_t(31));				   // PTX L1307
	r_PtxRegister1012 = uint32_t(r_PtxRegister1010) + uint32_t(r_PtxRegister1011);			   // PTX L1308
	r_PtxRegister1013 = ShiftRightSigned(int32_t(r_PtxRegister1012), uint32_t(1));			   // PTX L1309
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister1013)) * int64_t(int32_t(4))); // PTX L1310
	r_PtxU64Register135 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register134);		   // PTX L1311
	r_PtxRegister637 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register135 + 262144ull);	   // PTX L1312
	r_LaneIndexAtPtx1314 = uint32_t((threadIdx.x & 31u));									   // PTX L1314
	r_PtxRegister1014 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1314), uint32_t(31));		   // PTX L1316
	r_PtxRegister1015 = ShiftRight(uint32_t(r_PtxRegister1014), uint32_t(30));				   // PTX L1317
	r_PtxRegister1016 = uint32_t(r_LaneIndexAtPtx1314) + uint32_t(r_PtxRegister1015);		   // PTX L1318
	r_PtxRegister1017 = r_PtxRegister1016 & 2147483644;										   // PTX L1319
	r_PtxRegister1018 = uint32_t(r_LaneIndexAtPtx1314) - uint32_t(r_PtxRegister1017);		   // PTX L1320
	r_PtxRegister1019 = ShiftLeft(uint32_t(r_PtxRegister1018), uint32_t(1));				   // PTX L1321
	r_PtxRegister1020 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1019);			   // PTX L1322
	r_PtxRegister1021 = ShiftRight(uint32_t(r_PtxRegister1020), uint32_t(31));				   // PTX L1323
	r_PtxRegister1022 = uint32_t(r_PtxRegister1020) + uint32_t(r_PtxRegister1021);			   // PTX L1324
	r_PtxRegister1023 = ShiftRightSigned(int32_t(r_PtxRegister1022), uint32_t(1));			   // PTX L1325
	r_PtxU64Register136 = uint64_t(int64_t(int32_t(r_PtxRegister1023)) * int64_t(int32_t(4))); // PTX L1326
	r_PtxU64Register137 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register136);		   // PTX L1327
	r_PtxRegister640 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register137 + 262144ull);	   // PTX L1328
	r_LaneIndexAtPtx1330 = uint32_t((threadIdx.x & 31u));									   // PTX L1330
	r_PtxRegister1024 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1330), uint32_t(31));		   // PTX L1332
	r_PtxRegister1025 = ShiftRight(uint32_t(r_PtxRegister1024), uint32_t(30));				   // PTX L1333
	r_PtxRegister1026 = uint32_t(r_LaneIndexAtPtx1330) + uint32_t(r_PtxRegister1025);		   // PTX L1334
	r_PtxRegister1027 = r_PtxRegister1026 & 2147483644;										   // PTX L1335
	r_PtxRegister1028 = uint32_t(r_LaneIndexAtPtx1330) - uint32_t(r_PtxRegister1027);		   // PTX L1336
	r_PtxRegister1029 = ShiftLeft(uint32_t(r_PtxRegister1028), uint32_t(1));				   // PTX L1337
	r_PtxRegister1030 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1029);				   // PTX L1338
	r_PtxRegister1031 = ShiftRightSigned(int32_t(r_PtxRegister1030), uint32_t(1));			   // PTX L1339
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister1031)) * int64_t(int32_t(4))); // PTX L1340
	r_PtxU64Register139 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register138);		   // PTX L1341
	r_PtxRegister643 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register139 + 262144ull);	   // PTX L1342
	r_LaneIndexAtPtx1344 = uint32_t((threadIdx.x & 31u));									   // PTX L1344
	r_PtxRegister1032 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1344), uint32_t(31));		   // PTX L1346
	r_PtxRegister1033 = ShiftRight(uint32_t(r_PtxRegister1032), uint32_t(30));				   // PTX L1347
	r_PtxRegister1034 = uint32_t(r_LaneIndexAtPtx1344) + uint32_t(r_PtxRegister1033);		   // PTX L1348
	r_PtxRegister1035 = r_PtxRegister1034 & 2147483644;										   // PTX L1349
	r_PtxRegister1036 = uint32_t(r_LaneIndexAtPtx1344) - uint32_t(r_PtxRegister1035);		   // PTX L1350
	r_PtxRegister1037 = ShiftLeft(uint32_t(r_PtxRegister1036), uint32_t(1));				   // PTX L1351
	r_PtxRegister1038 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1037);				   // PTX L1352
	r_PtxRegister1039 = ShiftRightSigned(int32_t(r_PtxRegister1038), uint32_t(1));			   // PTX L1353
	r_PtxU64Register140 = uint64_t(int64_t(int32_t(r_PtxRegister1039)) * int64_t(int32_t(4))); // PTX L1354
	r_PtxU64Register141 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register140);		   // PTX L1355
	r_PtxRegister646 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register141 + 262144ull);	   // PTX L1356
	r_LaneIndexAtPtx1358 = uint32_t((threadIdx.x & 31u));									   // PTX L1358
	r_PtxRegister1040 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1358), uint32_t(31));		   // PTX L1360
	r_PtxRegister1041 = ShiftRight(uint32_t(r_PtxRegister1040), uint32_t(30));				   // PTX L1361
	r_PtxRegister1042 = uint32_t(r_LaneIndexAtPtx1358) + uint32_t(r_PtxRegister1041);		   // PTX L1362
	r_PtxRegister1043 = r_PtxRegister1042 & 2147483644;										   // PTX L1363
	r_PtxRegister1044 = uint32_t(r_LaneIndexAtPtx1358) - uint32_t(r_PtxRegister1043);		   // PTX L1364
	r_PtxRegister1045 = ShiftLeft(uint32_t(r_PtxRegister1044), uint32_t(1));				   // PTX L1365
	r_PtxRegister1046 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister1045);			   // PTX L1366
	r_PtxRegister1047 = ShiftRightSigned(int32_t(r_PtxRegister1046), uint32_t(1));			   // PTX L1367
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister1047)) * int64_t(int32_t(4))); // PTX L1368
	r_PtxU64Register143 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register142);		   // PTX L1369
	r_PtxRegister649 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register143 + 262144ull);	   // PTX L1370
	r_LaneIndexAtPtx1372 = uint32_t((threadIdx.x & 31u));									   // PTX L1372
	r_PtxRegister1048 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1372), uint32_t(31));		   // PTX L1374
	r_PtxRegister1049 = ShiftRight(uint32_t(r_PtxRegister1048), uint32_t(30));				   // PTX L1375
	r_PtxRegister1050 = uint32_t(r_LaneIndexAtPtx1372) + uint32_t(r_PtxRegister1049);		   // PTX L1376
	r_PtxRegister1051 = r_PtxRegister1050 & 2147483644;										   // PTX L1377
	r_PtxRegister1052 = uint32_t(r_LaneIndexAtPtx1372) - uint32_t(r_PtxRegister1051);		   // PTX L1378
	r_PtxRegister1053 = ShiftLeft(uint32_t(r_PtxRegister1052), uint32_t(1));				   // PTX L1379
	r_PtxRegister1054 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister1053);			   // PTX L1380
	r_PtxRegister1055 = ShiftRightSigned(int32_t(r_PtxRegister1054), uint32_t(1));			   // PTX L1381
	r_PtxU64Register144 = uint64_t(int64_t(int32_t(r_PtxRegister1055)) * int64_t(int32_t(4))); // PTX L1382
	r_PtxU64Register145 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register144);		   // PTX L1383
	r_PtxRegister652 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register145 + 262144ull);	   // PTX L1384
	r_LaneIndexAtPtx1386 = uint32_t((threadIdx.x & 31u));									   // PTX L1386
	r_PtxRegister1056 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1386), uint32_t(31));		   // PTX L1388
	r_PtxRegister1057 = ShiftRight(uint32_t(r_PtxRegister1056), uint32_t(30));				   // PTX L1389
	r_PtxRegister1058 = uint32_t(r_LaneIndexAtPtx1386) + uint32_t(r_PtxRegister1057);		   // PTX L1390
	r_PtxRegister1059 = r_PtxRegister1058 & 2147483644;										   // PTX L1391
	r_PtxRegister1060 = uint32_t(r_LaneIndexAtPtx1386) - uint32_t(r_PtxRegister1059);		   // PTX L1392
	r_PtxRegister1061 = ShiftLeft(uint32_t(r_PtxRegister1060), uint32_t(1));				   // PTX L1393
	r_PtxRegister1062 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister1061);			   // PTX L1394
	r_PtxRegister1063 = ShiftRightSigned(int32_t(r_PtxRegister1062), uint32_t(1));			   // PTX L1395
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister1063)) * int64_t(int32_t(4))); // PTX L1396
	r_PtxU64Register147 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register146);		   // PTX L1397
	r_PtxRegister655 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register147 + 262144ull);	   // PTX L1398
	r_LaneIndexAtPtx1400 = uint32_t((threadIdx.x & 31u));									   // PTX L1400
	r_PtxRegister1064 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1400), uint32_t(31));		   // PTX L1402
	r_PtxRegister1065 = ShiftRight(uint32_t(r_PtxRegister1064), uint32_t(30));				   // PTX L1403
	r_PtxRegister1066 = uint32_t(r_LaneIndexAtPtx1400) + uint32_t(r_PtxRegister1065);		   // PTX L1404
	r_PtxRegister1067 = r_PtxRegister1066 & 2147483644;										   // PTX L1405
	r_PtxRegister1068 = uint32_t(r_LaneIndexAtPtx1400) - uint32_t(r_PtxRegister1067);		   // PTX L1406
	r_PtxRegister1069 = ShiftLeft(uint32_t(r_PtxRegister1068), uint32_t(1));				   // PTX L1407
	r_PtxRegister1070 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister1069);			   // PTX L1408
	r_PtxRegister1071 = ShiftRightSigned(int32_t(r_PtxRegister1070), uint32_t(1));			   // PTX L1409
	r_PtxU64Register148 = uint64_t(int64_t(int32_t(r_PtxRegister1071)) * int64_t(int32_t(4))); // PTX L1410
	r_PtxU64Register149 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register148);		   // PTX L1411
	r_PtxRegister658 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register149 + 262144ull);	   // PTX L1412
	r_LaneIndexAtPtx1414 = uint32_t((threadIdx.x & 31u));									   // PTX L1414
	r_PtxRegister1072 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1414), uint32_t(31));		   // PTX L1416
	r_PtxRegister1073 = ShiftRight(uint32_t(r_PtxRegister1072), uint32_t(30));				   // PTX L1417
	r_PtxRegister1074 = uint32_t(r_LaneIndexAtPtx1414) + uint32_t(r_PtxRegister1073);		   // PTX L1418
	r_PtxRegister1075 = r_PtxRegister1074 & 2147483644;										   // PTX L1419
	r_PtxRegister1076 = uint32_t(r_LaneIndexAtPtx1414) - uint32_t(r_PtxRegister1075);		   // PTX L1420
	r_PtxRegister1077 = ShiftLeft(uint32_t(r_PtxRegister1076), uint32_t(1));				   // PTX L1421
	r_PtxRegister1078 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister1077);			   // PTX L1422
	r_PtxRegister1079 = ShiftRight(uint32_t(r_PtxRegister1078), uint32_t(31));				   // PTX L1423
	r_PtxRegister1080 = uint32_t(r_PtxRegister1078) + uint32_t(r_PtxRegister1079);			   // PTX L1424
	r_PtxRegister1081 = ShiftRightSigned(int32_t(r_PtxRegister1080), uint32_t(1));			   // PTX L1425
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister1081)) * int64_t(int32_t(4))); // PTX L1426
	r_PtxU64Register151 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register150);		   // PTX L1427
	r_PtxRegister661 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register151 + 262144ull);	   // PTX L1428
	r_LaneIndexAtPtx1430 = uint32_t((threadIdx.x & 31u));									   // PTX L1430
	r_PtxRegister1082 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1430), uint32_t(31));		   // PTX L1432
	r_PtxRegister1083 = ShiftRight(uint32_t(r_PtxRegister1082), uint32_t(30));				   // PTX L1433
	r_PtxRegister1084 = uint32_t(r_LaneIndexAtPtx1430) + uint32_t(r_PtxRegister1083);		   // PTX L1434
	r_PtxRegister1085 = r_PtxRegister1084 & 2147483644;										   // PTX L1435
	r_PtxRegister1086 = uint32_t(r_LaneIndexAtPtx1430) - uint32_t(r_PtxRegister1085);		   // PTX L1436
	r_PtxRegister1087 = ShiftLeft(uint32_t(r_PtxRegister1086), uint32_t(1));				   // PTX L1437
	r_PtxRegister1088 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister1087);			   // PTX L1438
	r_PtxRegister1089 = ShiftRight(uint32_t(r_PtxRegister1088), uint32_t(31));				   // PTX L1439
	r_PtxRegister1090 = uint32_t(r_PtxRegister1088) + uint32_t(r_PtxRegister1089);			   // PTX L1440
	r_PtxRegister1091 = ShiftRightSigned(int32_t(r_PtxRegister1090), uint32_t(1));			   // PTX L1441
	r_PtxU64Register152 = uint64_t(int64_t(int32_t(r_PtxRegister1091)) * int64_t(int32_t(4))); // PTX L1442
	r_PtxU64Register153 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register152);		   // PTX L1443
	r_PtxRegister664 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register153 + 262144ull);	   // PTX L1444
	r_LaneIndexAtPtx1446 = uint32_t((threadIdx.x & 31u));									   // PTX L1446
	r_PtxRegister1092 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1446), uint32_t(31));		   // PTX L1448
	r_PtxRegister1093 = ShiftRight(uint32_t(r_PtxRegister1092), uint32_t(30));				   // PTX L1449
	r_PtxRegister1094 = uint32_t(r_LaneIndexAtPtx1446) + uint32_t(r_PtxRegister1093);		   // PTX L1450
	r_PtxRegister1095 = r_PtxRegister1094 & 2147483644;										   // PTX L1451
	r_PtxRegister1096 = uint32_t(r_LaneIndexAtPtx1446) - uint32_t(r_PtxRegister1095);		   // PTX L1452
	r_PtxRegister1097 = ShiftLeft(uint32_t(r_PtxRegister1096), uint32_t(1));				   // PTX L1453
	r_PtxRegister1098 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister1097);			   // PTX L1454
	r_PtxRegister1099 = ShiftRightSigned(int32_t(r_PtxRegister1098), uint32_t(1));			   // PTX L1455
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister1099)) * int64_t(int32_t(4))); // PTX L1456
	r_PtxU64Register155 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register154);		   // PTX L1457
	r_PtxRegister667 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register155 + 262144ull);	   // PTX L1458
	r_LaneIndexAtPtx1460 = uint32_t((threadIdx.x & 31u));									   // PTX L1460
	r_PtxRegister1100 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1460), uint32_t(31));		   // PTX L1462
	r_PtxRegister1101 = ShiftRight(uint32_t(r_PtxRegister1100), uint32_t(30));				   // PTX L1463
	r_PtxRegister1102 = uint32_t(r_LaneIndexAtPtx1460) + uint32_t(r_PtxRegister1101);		   // PTX L1464
	r_PtxRegister1103 = r_PtxRegister1102 & 2147483644;										   // PTX L1465
	r_PtxRegister1104 = uint32_t(r_LaneIndexAtPtx1460) - uint32_t(r_PtxRegister1103);		   // PTX L1466
	r_PtxRegister1105 = ShiftLeft(uint32_t(r_PtxRegister1104), uint32_t(1));				   // PTX L1467
	r_PtxRegister1106 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister1105);			   // PTX L1468
	r_PtxRegister1107 = ShiftRightSigned(int32_t(r_PtxRegister1106), uint32_t(1));			   // PTX L1469
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister1107)) * int64_t(int32_t(4))); // PTX L1470
	r_PtxU64Register157 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register156);		   // PTX L1471
	r_PtxRegister670 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register157 + 262144ull);	   // PTX L1472
	r_LaneIndexAtPtx1474 = uint32_t((threadIdx.x & 31u));									   // PTX L1474
	r_PtxRegister1108 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1474), uint32_t(31));		   // PTX L1476
	r_PtxRegister1109 = ShiftRight(uint32_t(r_PtxRegister1108), uint32_t(30));				   // PTX L1477
	r_PtxRegister1110 = uint32_t(r_LaneIndexAtPtx1474) + uint32_t(r_PtxRegister1109);		   // PTX L1478
	r_PtxRegister1111 = r_PtxRegister1110 & 2147483644;										   // PTX L1479
	r_PtxRegister1112 = uint32_t(r_LaneIndexAtPtx1474) - uint32_t(r_PtxRegister1111);		   // PTX L1480
	r_PtxRegister1113 = ShiftLeft(uint32_t(r_PtxRegister1112), uint32_t(1));				   // PTX L1481
	r_PtxRegister1114 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister1113);			   // PTX L1482
	r_PtxRegister1115 = ShiftRight(uint32_t(r_PtxRegister1114), uint32_t(31));				   // PTX L1483
	r_PtxRegister1116 = uint32_t(r_PtxRegister1114) + uint32_t(r_PtxRegister1115);			   // PTX L1484
	r_PtxRegister1117 = ShiftRightSigned(int32_t(r_PtxRegister1116), uint32_t(1));			   // PTX L1485
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister1117)) * int64_t(int32_t(4))); // PTX L1486
	r_PtxU64Register159 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register158);		   // PTX L1487
	r_PtxRegister673 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register159 + 262144ull);	   // PTX L1488
	r_LaneIndexAtPtx1490 = uint32_t((threadIdx.x & 31u));									   // PTX L1490
	r_PtxRegister1118 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1490), uint32_t(31));		   // PTX L1492
	r_PtxRegister1119 = ShiftRight(uint32_t(r_PtxRegister1118), uint32_t(30));				   // PTX L1493
	r_PtxRegister1120 = uint32_t(r_LaneIndexAtPtx1490) + uint32_t(r_PtxRegister1119);		   // PTX L1494
	r_PtxRegister1121 = r_PtxRegister1120 & 2147483644;										   // PTX L1495
	r_PtxRegister1122 = uint32_t(r_LaneIndexAtPtx1490) - uint32_t(r_PtxRegister1121);		   // PTX L1496
	r_PtxRegister1123 = ShiftLeft(uint32_t(r_PtxRegister1122), uint32_t(1));				   // PTX L1497
	r_PtxRegister1124 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister1123);			   // PTX L1498
	r_PtxRegister1125 = ShiftRight(uint32_t(r_PtxRegister1124), uint32_t(31));				   // PTX L1499
	r_PtxRegister1126 = uint32_t(r_PtxRegister1124) + uint32_t(r_PtxRegister1125);			   // PTX L1500
	r_PtxRegister1127 = ShiftRightSigned(int32_t(r_PtxRegister1126), uint32_t(1));			   // PTX L1501
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister1127)) * int64_t(int32_t(4))); // PTX L1502
	r_PtxU64Register161 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register160);		   // PTX L1503
	r_PtxRegister676 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register161 + 262144ull);	   // PTX L1504
	r_LaneIndexAtPtx1506 = uint32_t((threadIdx.x & 31u));									   // PTX L1506
	r_PtxRegister1128 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1506), uint32_t(31));		   // PTX L1508
	r_PtxRegister1129 = ShiftRight(uint32_t(r_PtxRegister1128), uint32_t(30));				   // PTX L1509
	r_PtxRegister1130 = uint32_t(r_LaneIndexAtPtx1506) + uint32_t(r_PtxRegister1129);		   // PTX L1510
	r_PtxRegister1131 = r_PtxRegister1130 & 2147483644;										   // PTX L1511
	r_PtxRegister1132 = uint32_t(r_LaneIndexAtPtx1506) - uint32_t(r_PtxRegister1131);		   // PTX L1512
	r_PtxRegister1133 = ShiftLeft(uint32_t(r_PtxRegister1132), uint32_t(1));				   // PTX L1513
	r_PtxRegister1134 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister1133);			   // PTX L1514
	r_PtxRegister1135 = ShiftRightSigned(int32_t(r_PtxRegister1134), uint32_t(1));			   // PTX L1515
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister1135)) * int64_t(int32_t(4))); // PTX L1516
	r_PtxU64Register163 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register162);		   // PTX L1517
	r_PtxRegister679 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register163 + 262144ull);	   // PTX L1518
	r_LaneIndexAtPtx1520 = uint32_t((threadIdx.x & 31u));									   // PTX L1520
	r_PtxRegister1136 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1520), uint32_t(31));		   // PTX L1522
	r_PtxRegister1137 = ShiftRight(uint32_t(r_PtxRegister1136), uint32_t(30));				   // PTX L1523
	r_PtxRegister1138 = uint32_t(r_LaneIndexAtPtx1520) + uint32_t(r_PtxRegister1137);		   // PTX L1524
	r_PtxRegister1139 = r_PtxRegister1138 & 2147483644;										   // PTX L1525
	r_PtxRegister1140 = uint32_t(r_LaneIndexAtPtx1520) - uint32_t(r_PtxRegister1139);		   // PTX L1526
	r_PtxRegister1141 = ShiftLeft(uint32_t(r_PtxRegister1140), uint32_t(1));				   // PTX L1527
	r_PtxRegister1142 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister1141);			   // PTX L1528
	r_PtxRegister1143 = ShiftRightSigned(int32_t(r_PtxRegister1142), uint32_t(1));			   // PTX L1529
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister1143)) * int64_t(int32_t(4))); // PTX L1530
	r_PtxU64Register165 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register164);		   // PTX L1531
	r_PtxRegister682 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register165 + 262144ull);	   // PTX L1532
	r_LaneIndexAtPtx1534 = uint32_t((threadIdx.x & 31u));									   // PTX L1534
	r_PtxRegister1144 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1534), uint32_t(31));		   // PTX L1536
	r_PtxRegister1145 = ShiftRight(uint32_t(r_PtxRegister1144), uint32_t(30));				   // PTX L1537
	r_PtxRegister1146 = uint32_t(r_LaneIndexAtPtx1534) + uint32_t(r_PtxRegister1145);		   // PTX L1538
	r_PtxRegister1147 = r_PtxRegister1146 & 2147483644;										   // PTX L1539
	r_PtxRegister1148 = uint32_t(r_LaneIndexAtPtx1534) - uint32_t(r_PtxRegister1147);		   // PTX L1540
	r_PtxRegister1149 = ShiftLeft(uint32_t(r_PtxRegister1148), uint32_t(1));				   // PTX L1541
	r_PtxRegister1150 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1149);			   // PTX L1542
	r_PtxRegister1151 = ShiftRight(uint32_t(r_PtxRegister1150), uint32_t(31));				   // PTX L1543
	r_PtxRegister1152 = uint32_t(r_PtxRegister1150) + uint32_t(r_PtxRegister1151);			   // PTX L1544
	r_PtxRegister1153 = ShiftRightSigned(int32_t(r_PtxRegister1152), uint32_t(1));			   // PTX L1545
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister1153)) * int64_t(int32_t(4))); // PTX L1546
	r_PtxU64Register167 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register166);		   // PTX L1547
	r_PtxRegister685 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register167 + 262144ull);	   // PTX L1548
	r_LaneIndexAtPtx1550 = uint32_t((threadIdx.x & 31u));									   // PTX L1550
	r_PtxRegister1154 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1550), uint32_t(31));		   // PTX L1552
	r_PtxRegister1155 = ShiftRight(uint32_t(r_PtxRegister1154), uint32_t(30));				   // PTX L1553
	r_PtxRegister1156 = uint32_t(r_LaneIndexAtPtx1550) + uint32_t(r_PtxRegister1155);		   // PTX L1554
	r_PtxRegister1157 = r_PtxRegister1156 & 2147483644;										   // PTX L1555
	r_PtxRegister1158 = uint32_t(r_LaneIndexAtPtx1550) - uint32_t(r_PtxRegister1157);		   // PTX L1556
	r_PtxRegister1159 = ShiftLeft(uint32_t(r_PtxRegister1158), uint32_t(1));				   // PTX L1557
	r_PtxRegister1160 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1159);			   // PTX L1558
	r_PtxRegister1161 = ShiftRight(uint32_t(r_PtxRegister1160), uint32_t(31));				   // PTX L1559
	r_PtxRegister1162 = uint32_t(r_PtxRegister1160) + uint32_t(r_PtxRegister1161);			   // PTX L1560
	r_PtxRegister1163 = ShiftRightSigned(int32_t(r_PtxRegister1162), uint32_t(1));			   // PTX L1561
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister1163)) * int64_t(int32_t(4))); // PTX L1562
	r_PtxU64Register169 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register168);		   // PTX L1563
	r_PtxRegister688 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register169 + 262144ull);	   // PTX L1564
	r_LaneIndexAtPtx1566 = uint32_t((threadIdx.x & 31u));									   // PTX L1566
	r_PtxRegister1164 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1566), uint32_t(31));		   // PTX L1568
	r_PtxRegister1165 = ShiftRight(uint32_t(r_PtxRegister1164), uint32_t(30));				   // PTX L1569
	r_PtxRegister1166 = uint32_t(r_LaneIndexAtPtx1566) + uint32_t(r_PtxRegister1165);		   // PTX L1570
	r_PtxRegister1167 = r_PtxRegister1166 & 2147483644;										   // PTX L1571
	r_PtxRegister1168 = uint32_t(r_LaneIndexAtPtx1566) - uint32_t(r_PtxRegister1167);		   // PTX L1572
	r_PtxRegister1169 = ShiftLeft(uint32_t(r_PtxRegister1168), uint32_t(1));				   // PTX L1573
	r_PtxRegister1170 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1169);				   // PTX L1574
	r_PtxRegister1171 = ShiftRightSigned(int32_t(r_PtxRegister1170), uint32_t(1));			   // PTX L1575
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister1171)) * int64_t(int32_t(4))); // PTX L1576
	r_PtxU64Register171 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register170);		   // PTX L1577
	r_PtxRegister691 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register171 + 262144ull);	   // PTX L1578
	r_LaneIndexAtPtx1580 = uint32_t((threadIdx.x & 31u));									   // PTX L1580
	r_PtxRegister1172 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1580), uint32_t(31));		   // PTX L1582
	r_PtxRegister1173 = ShiftRight(uint32_t(r_PtxRegister1172), uint32_t(30));				   // PTX L1583
	r_PtxRegister1174 = uint32_t(r_LaneIndexAtPtx1580) + uint32_t(r_PtxRegister1173);		   // PTX L1584
	r_PtxRegister1175 = r_PtxRegister1174 & 2147483644;										   // PTX L1585
	r_PtxRegister1176 = uint32_t(r_LaneIndexAtPtx1580) - uint32_t(r_PtxRegister1175);		   // PTX L1586
	r_PtxRegister1177 = ShiftLeft(uint32_t(r_PtxRegister1176), uint32_t(1));				   // PTX L1587
	r_PtxRegister1178 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister1177);				   // PTX L1588
	r_PtxRegister1179 = ShiftRightSigned(int32_t(r_PtxRegister1178), uint32_t(1));			   // PTX L1589
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister1179)) * int64_t(int32_t(4))); // PTX L1590
	r_PtxU64Register173 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register172);		   // PTX L1591
	r_PtxRegister694 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register173 + 262144ull);	   // PTX L1592
	r_LaneIndexAtPtx1594 = uint32_t((threadIdx.x & 31u));									   // PTX L1594
	r_PtxRegister1180 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1594), uint32_t(31));		   // PTX L1596
	r_PtxRegister1181 = ShiftRight(uint32_t(r_PtxRegister1180), uint32_t(30));				   // PTX L1597
	r_PtxRegister1182 = uint32_t(r_LaneIndexAtPtx1594) + uint32_t(r_PtxRegister1181);		   // PTX L1598
	r_PtxRegister1183 = r_PtxRegister1182 & 2147483644;										   // PTX L1599
	r_PtxRegister1184 = uint32_t(r_LaneIndexAtPtx1594) - uint32_t(r_PtxRegister1183);		   // PTX L1600
	r_PtxRegister1185 = ShiftLeft(uint32_t(r_PtxRegister1184), uint32_t(1));				   // PTX L1601
	r_PtxRegister1186 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister1185);			   // PTX L1602
	r_PtxRegister1187 = ShiftRightSigned(int32_t(r_PtxRegister1186), uint32_t(1));			   // PTX L1603
	r_PtxU64Register174 = uint64_t(int64_t(int32_t(r_PtxRegister1187)) * int64_t(int32_t(4))); // PTX L1604
	r_PtxU64Register175 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register174);		   // PTX L1605
	r_PtxRegister697 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register175 + 262144ull);	   // PTX L1606
	r_LaneIndexAtPtx1608 = uint32_t((threadIdx.x & 31u));									   // PTX L1608
	r_PtxRegister1188 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1608), uint32_t(31));		   // PTX L1610
	r_PtxRegister1189 = ShiftRight(uint32_t(r_PtxRegister1188), uint32_t(30));				   // PTX L1611
	r_PtxRegister1190 = uint32_t(r_LaneIndexAtPtx1608) + uint32_t(r_PtxRegister1189);		   // PTX L1612
	r_PtxRegister1191 = r_PtxRegister1190 & 2147483644;										   // PTX L1613
	r_PtxRegister1192 = uint32_t(r_LaneIndexAtPtx1608) - uint32_t(r_PtxRegister1191);		   // PTX L1614
	r_PtxRegister1193 = ShiftLeft(uint32_t(r_PtxRegister1192), uint32_t(1));				   // PTX L1615
	r_PtxRegister1194 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister1193);			   // PTX L1616
	r_PtxRegister1195 = ShiftRightSigned(int32_t(r_PtxRegister1194), uint32_t(1));			   // PTX L1617
	r_PtxU64Register176 = uint64_t(int64_t(int32_t(r_PtxRegister1195)) * int64_t(int32_t(4))); // PTX L1618
	r_PtxU64Register177 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register176);		   // PTX L1619
	r_PtxRegister700 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register177 + 262144ull);	   // PTX L1620
	r_LaneIndexAtPtx1622 = uint32_t((threadIdx.x & 31u));									   // PTX L1622
	r_PtxRegister1196 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1622), uint32_t(31));		   // PTX L1624
	r_PtxRegister1197 = ShiftRight(uint32_t(r_PtxRegister1196), uint32_t(30));				   // PTX L1625
	r_PtxRegister1198 = uint32_t(r_LaneIndexAtPtx1622) + uint32_t(r_PtxRegister1197);		   // PTX L1626
	r_PtxRegister1199 = r_PtxRegister1198 & 2147483644;										   // PTX L1627
	r_PtxRegister1200 = uint32_t(r_LaneIndexAtPtx1622) - uint32_t(r_PtxRegister1199);		   // PTX L1628
	r_PtxRegister1201 = ShiftLeft(uint32_t(r_PtxRegister1200), uint32_t(1));				   // PTX L1629
	r_PtxRegister1202 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister1201);			   // PTX L1630
	r_PtxRegister1203 = ShiftRightSigned(int32_t(r_PtxRegister1202), uint32_t(1));			   // PTX L1631
	r_PtxU64Register178 = uint64_t(int64_t(int32_t(r_PtxRegister1203)) * int64_t(int32_t(4))); // PTX L1632
	r_PtxU64Register179 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register178);		   // PTX L1633
	r_PtxRegister703 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register179 + 262144ull);	   // PTX L1634
	r_LaneIndexAtPtx1636 = uint32_t((threadIdx.x & 31u));									   // PTX L1636
	r_PtxRegister1204 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1636), uint32_t(31));		   // PTX L1638
	r_PtxRegister1205 = ShiftRight(uint32_t(r_PtxRegister1204), uint32_t(30));				   // PTX L1639
	r_PtxRegister1206 = uint32_t(r_LaneIndexAtPtx1636) + uint32_t(r_PtxRegister1205);		   // PTX L1640
	r_PtxRegister1207 = r_PtxRegister1206 & 2147483644;										   // PTX L1641
	r_PtxRegister1208 = uint32_t(r_LaneIndexAtPtx1636) - uint32_t(r_PtxRegister1207);		   // PTX L1642
	r_PtxRegister1209 = ShiftLeft(uint32_t(r_PtxRegister1208), uint32_t(1));				   // PTX L1643
	r_PtxRegister1210 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister1209);			   // PTX L1644
	r_PtxRegister1211 = ShiftRightSigned(int32_t(r_PtxRegister1210), uint32_t(1));			   // PTX L1645
	r_PtxU64Register180 = uint64_t(int64_t(int32_t(r_PtxRegister1211)) * int64_t(int32_t(4))); // PTX L1646
	r_PtxU64Register181 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register180);		   // PTX L1647
	r_PtxRegister706 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register181 + 262144ull);	   // PTX L1648
	r_LaneIndexAtPtx1650 = uint32_t((threadIdx.x & 31u));									   // PTX L1650
	r_PtxRegister1212 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1650), uint32_t(31));		   // PTX L1652
	r_PtxRegister1213 = ShiftRight(uint32_t(r_PtxRegister1212), uint32_t(30));				   // PTX L1653
	r_PtxRegister1214 = uint32_t(r_LaneIndexAtPtx1650) + uint32_t(r_PtxRegister1213);		   // PTX L1654
	r_PtxRegister1215 = r_PtxRegister1214 & 2147483644;										   // PTX L1655
	r_PtxRegister1216 = uint32_t(r_LaneIndexAtPtx1650) - uint32_t(r_PtxRegister1215);		   // PTX L1656
	r_PtxRegister1217 = ShiftLeft(uint32_t(r_PtxRegister1216), uint32_t(1));				   // PTX L1657
	r_PtxRegister1218 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister1217);			   // PTX L1658
	r_PtxRegister1219 = ShiftRight(uint32_t(r_PtxRegister1218), uint32_t(31));				   // PTX L1659
	r_PtxRegister1220 = uint32_t(r_PtxRegister1218) + uint32_t(r_PtxRegister1219);			   // PTX L1660
	r_PtxRegister1221 = ShiftRightSigned(int32_t(r_PtxRegister1220), uint32_t(1));			   // PTX L1661
	r_PtxU64Register182 = uint64_t(int64_t(int32_t(r_PtxRegister1221)) * int64_t(int32_t(4))); // PTX L1662
	r_PtxU64Register183 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register182);		   // PTX L1663
	r_PtxRegister709 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register183 + 262144ull);	   // PTX L1664
	r_LaneIndexAtPtx1666 = uint32_t((threadIdx.x & 31u));									   // PTX L1666
	r_PtxRegister1222 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1666), uint32_t(31));		   // PTX L1668
	r_PtxRegister1223 = ShiftRight(uint32_t(r_PtxRegister1222), uint32_t(30));				   // PTX L1669
	r_PtxRegister1224 = uint32_t(r_LaneIndexAtPtx1666) + uint32_t(r_PtxRegister1223);		   // PTX L1670
	r_PtxRegister1225 = r_PtxRegister1224 & 2147483644;										   // PTX L1671
	r_PtxRegister1226 = uint32_t(r_LaneIndexAtPtx1666) - uint32_t(r_PtxRegister1225);		   // PTX L1672
	r_PtxRegister1227 = ShiftLeft(uint32_t(r_PtxRegister1226), uint32_t(1));				   // PTX L1673
	r_PtxRegister1228 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister1227);			   // PTX L1674
	r_PtxRegister1229 = ShiftRight(uint32_t(r_PtxRegister1228), uint32_t(31));				   // PTX L1675
	r_PtxRegister1230 = uint32_t(r_PtxRegister1228) + uint32_t(r_PtxRegister1229);			   // PTX L1676
	r_PtxRegister1231 = ShiftRightSigned(int32_t(r_PtxRegister1230), uint32_t(1));			   // PTX L1677
	r_PtxU64Register184 = uint64_t(int64_t(int32_t(r_PtxRegister1231)) * int64_t(int32_t(4))); // PTX L1678
	r_PtxU64Register185 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register184);		   // PTX L1679
	r_PtxRegister712 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register185 + 262144ull);	   // PTX L1680
	r_LaneIndexAtPtx1682 = uint32_t((threadIdx.x & 31u));									   // PTX L1682
	r_PtxRegister1232 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1682), uint32_t(31));		   // PTX L1684
	r_PtxRegister1233 = ShiftRight(uint32_t(r_PtxRegister1232), uint32_t(30));				   // PTX L1685
	r_PtxRegister1234 = uint32_t(r_LaneIndexAtPtx1682) + uint32_t(r_PtxRegister1233);		   // PTX L1686
	r_PtxRegister1235 = r_PtxRegister1234 & 2147483644;										   // PTX L1687
	r_PtxRegister1236 = uint32_t(r_LaneIndexAtPtx1682) - uint32_t(r_PtxRegister1235);		   // PTX L1688
	r_PtxRegister1237 = ShiftLeft(uint32_t(r_PtxRegister1236), uint32_t(1));				   // PTX L1689
	r_PtxRegister1238 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister1237);			   // PTX L1690
	r_PtxRegister1239 = ShiftRightSigned(int32_t(r_PtxRegister1238), uint32_t(1));			   // PTX L1691
	r_PtxU64Register186 = uint64_t(int64_t(int32_t(r_PtxRegister1239)) * int64_t(int32_t(4))); // PTX L1692
	r_PtxU64Register187 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register186);		   // PTX L1693
	r_PtxRegister715 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register187 + 262144ull);	   // PTX L1694
	r_LaneIndexAtPtx1696 = uint32_t((threadIdx.x & 31u));									   // PTX L1696
	r_PtxRegister1240 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1696), uint32_t(31));		   // PTX L1698
	r_PtxRegister1241 = ShiftRight(uint32_t(r_PtxRegister1240), uint32_t(30));				   // PTX L1699
	r_PtxRegister1242 = uint32_t(r_LaneIndexAtPtx1696) + uint32_t(r_PtxRegister1241);		   // PTX L1700
	r_PtxRegister1243 = r_PtxRegister1242 & 2147483644;										   // PTX L1701
	r_PtxRegister1244 = uint32_t(r_LaneIndexAtPtx1696) - uint32_t(r_PtxRegister1243);		   // PTX L1702
	r_PtxRegister1245 = ShiftLeft(uint32_t(r_PtxRegister1244), uint32_t(1));				   // PTX L1703
	r_PtxRegister1246 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister1245);			   // PTX L1704
	r_PtxRegister1247 = ShiftRightSigned(int32_t(r_PtxRegister1246), uint32_t(1));			   // PTX L1705
	r_PtxU64Register188 = uint64_t(int64_t(int32_t(r_PtxRegister1247)) * int64_t(int32_t(4))); // PTX L1706
	r_PtxU64Register189 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register188);		   // PTX L1707
	r_PtxRegister718 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register189 + 262144ull);	   // PTX L1708
	r_LaneIndexAtPtx1710 = uint32_t((threadIdx.x & 31u));									   // PTX L1710
	r_PtxRegister1248 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1710), uint32_t(31));		   // PTX L1712
	r_PtxRegister1249 = ShiftRight(uint32_t(r_PtxRegister1248), uint32_t(30));				   // PTX L1713
	r_PtxRegister1250 = uint32_t(r_LaneIndexAtPtx1710) + uint32_t(r_PtxRegister1249);		   // PTX L1714
	r_PtxRegister1251 = r_PtxRegister1250 & 2147483644;										   // PTX L1715
	r_PtxRegister1252 = uint32_t(r_LaneIndexAtPtx1710) - uint32_t(r_PtxRegister1251);		   // PTX L1716
	r_PtxRegister1253 = ShiftLeft(uint32_t(r_PtxRegister1252), uint32_t(1));				   // PTX L1717
	r_PtxRegister1254 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister1253);			   // PTX L1718
	r_PtxRegister1255 = ShiftRight(uint32_t(r_PtxRegister1254), uint32_t(31));				   // PTX L1719
	r_PtxRegister1256 = uint32_t(r_PtxRegister1254) + uint32_t(r_PtxRegister1255);			   // PTX L1720
	r_PtxRegister1257 = ShiftRightSigned(int32_t(r_PtxRegister1256), uint32_t(1));			   // PTX L1721
	r_PtxU64Register190 = uint64_t(int64_t(int32_t(r_PtxRegister1257)) * int64_t(int32_t(4))); // PTX L1722
	r_PtxU64Register191 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register190);		   // PTX L1723
	r_PtxRegister721 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register191 + 262144ull);	   // PTX L1724
	r_LaneIndexAtPtx1726 = uint32_t((threadIdx.x & 31u));									   // PTX L1726
	r_PtxRegister1258 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1726), uint32_t(31));		   // PTX L1728
	r_PtxRegister1259 = ShiftRight(uint32_t(r_PtxRegister1258), uint32_t(30));				   // PTX L1729
	r_PtxRegister1260 = uint32_t(r_LaneIndexAtPtx1726) + uint32_t(r_PtxRegister1259);		   // PTX L1730
	r_PtxRegister1261 = r_PtxRegister1260 & 2147483644;										   // PTX L1731
	r_PtxRegister1262 = uint32_t(r_LaneIndexAtPtx1726) - uint32_t(r_PtxRegister1261);		   // PTX L1732
	r_PtxRegister1263 = ShiftLeft(uint32_t(r_PtxRegister1262), uint32_t(1));				   // PTX L1733
	r_PtxRegister1264 = uint32_t(r_PtxRegister831) + uint32_t(r_PtxRegister1263);			   // PTX L1734
	r_PtxRegister1265 = ShiftRight(uint32_t(r_PtxRegister1264), uint32_t(31));				   // PTX L1735
	r_PtxRegister1266 = uint32_t(r_PtxRegister1264) + uint32_t(r_PtxRegister1265);			   // PTX L1736
	r_PtxRegister1267 = ShiftRightSigned(int32_t(r_PtxRegister1266), uint32_t(1));			   // PTX L1737
	r_PtxU64Register192 = uint64_t(int64_t(int32_t(r_PtxRegister1267)) * int64_t(int32_t(4))); // PTX L1738
	r_PtxU64Register193 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register192);		   // PTX L1739
	r_PtxRegister724 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register193 + 262144ull);	   // PTX L1740
	r_LaneIndexAtPtx1742 = uint32_t((threadIdx.x & 31u));									   // PTX L1742
	r_PtxRegister1268 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1742), uint32_t(31));		   // PTX L1744
	r_PtxRegister1269 = ShiftRight(uint32_t(r_PtxRegister1268), uint32_t(30));				   // PTX L1745
	r_PtxRegister1270 = uint32_t(r_LaneIndexAtPtx1742) + uint32_t(r_PtxRegister1269);		   // PTX L1746
	r_PtxRegister1271 = r_PtxRegister1270 & 2147483644;										   // PTX L1747
	r_PtxRegister1272 = uint32_t(r_LaneIndexAtPtx1742) - uint32_t(r_PtxRegister1271);		   // PTX L1748
	r_PtxRegister1273 = ShiftLeft(uint32_t(r_PtxRegister1272), uint32_t(1));				   // PTX L1749
	r_PtxRegister1274 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister1273);			   // PTX L1750
	r_PtxRegister1275 = ShiftRightSigned(int32_t(r_PtxRegister1274), uint32_t(1));			   // PTX L1751
	r_PtxU64Register194 = uint64_t(int64_t(int32_t(r_PtxRegister1275)) * int64_t(int32_t(4))); // PTX L1752
	r_PtxU64Register195 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register194);		   // PTX L1753
	r_PtxRegister727 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register195 + 262144ull);	   // PTX L1754
	r_LaneIndexAtPtx1756 = uint32_t((threadIdx.x & 31u));									   // PTX L1756
	r_PtxRegister1276 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1756), uint32_t(31));		   // PTX L1758
	r_PtxRegister1277 = ShiftRight(uint32_t(r_PtxRegister1276), uint32_t(30));				   // PTX L1759
	r_PtxRegister1278 = uint32_t(r_LaneIndexAtPtx1756) + uint32_t(r_PtxRegister1277);		   // PTX L1760
	r_PtxRegister1279 = r_PtxRegister1278 & 2147483644;										   // PTX L1761
	r_PtxRegister1280 = uint32_t(r_LaneIndexAtPtx1756) - uint32_t(r_PtxRegister1279);		   // PTX L1762
	r_PtxRegister1281 = ShiftLeft(uint32_t(r_PtxRegister1280), uint32_t(1));				   // PTX L1763
	r_PtxRegister1282 = uint32_t(r_PtxRegister852) + uint32_t(r_PtxRegister1281);			   // PTX L1764
	r_PtxRegister1283 = ShiftRightSigned(int32_t(r_PtxRegister1282), uint32_t(1));			   // PTX L1765
	r_PtxU64Register196 = uint64_t(int64_t(int32_t(r_PtxRegister1283)) * int64_t(int32_t(4))); // PTX L1766
	r_PtxU64Register197 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register196);		   // PTX L1767
	r_PtxRegister730 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register197 + 262144ull);	   // PTX L1768
	r_LaneIndexAtPtx1770 = uint32_t((threadIdx.x & 31u));									   // PTX L1770
	r_PtxRegister1284 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1770), uint32_t(31));		   // PTX L1772
	r_PtxRegister1285 = ShiftRight(uint32_t(r_PtxRegister1284), uint32_t(30));				   // PTX L1773
	r_PtxRegister1286 = uint32_t(r_LaneIndexAtPtx1770) + uint32_t(r_PtxRegister1285);		   // PTX L1774
	r_PtxRegister1287 = r_PtxRegister1286 & 2147483644;										   // PTX L1775
	r_PtxRegister1288 = uint32_t(r_LaneIndexAtPtx1770) - uint32_t(r_PtxRegister1287);		   // PTX L1776
	r_PtxRegister1289 = ShiftLeft(uint32_t(r_PtxRegister1288), uint32_t(1));				   // PTX L1777
	r_PtxRegister1290 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1289);			   // PTX L1778
	r_PtxRegister1291 = ShiftRight(uint32_t(r_PtxRegister1290), uint32_t(31));				   // PTX L1779
	r_PtxRegister1292 = uint32_t(r_PtxRegister1290) + uint32_t(r_PtxRegister1291);			   // PTX L1780
	r_PtxRegister1293 = ShiftRightSigned(int32_t(r_PtxRegister1292), uint32_t(1));			   // PTX L1781
	r_PtxU64Register198 = uint64_t(int64_t(int32_t(r_PtxRegister1293)) * int64_t(int32_t(4))); // PTX L1782
	r_PtxU64Register199 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register198);		   // PTX L1783
	r_PtxRegister733 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register199 + 262144ull);	   // PTX L1784
	r_LaneIndexAtPtx1786 = uint32_t((threadIdx.x & 31u));									   // PTX L1786
	r_PtxRegister1294 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1786), uint32_t(31));		   // PTX L1788
	r_PtxRegister1295 = ShiftRight(uint32_t(r_PtxRegister1294), uint32_t(30));				   // PTX L1789
	r_PtxRegister1296 = uint32_t(r_LaneIndexAtPtx1786) + uint32_t(r_PtxRegister1295);		   // PTX L1790
	r_PtxRegister1297 = r_PtxRegister1296 & 2147483644;										   // PTX L1791
	r_PtxRegister1298 = uint32_t(r_LaneIndexAtPtx1786) - uint32_t(r_PtxRegister1297);		   // PTX L1792
	r_PtxRegister1299 = ShiftLeft(uint32_t(r_PtxRegister1298), uint32_t(1));				   // PTX L1793
	r_PtxRegister1300 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister1299);			   // PTX L1794
	r_PtxRegister1301 = ShiftRight(uint32_t(r_PtxRegister1300), uint32_t(31));				   // PTX L1795
	r_PtxRegister1302 = uint32_t(r_PtxRegister1300) + uint32_t(r_PtxRegister1301);			   // PTX L1796
	r_PtxRegister1303 = ShiftRightSigned(int32_t(r_PtxRegister1302), uint32_t(1));			   // PTX L1797
	r_PtxU64Register200 = uint64_t(int64_t(int32_t(r_PtxRegister1303)) * int64_t(int32_t(4))); // PTX L1798
	r_PtxU64Register201 = uint64_t(r_PtxU64Register73) + uint64_t(r_PtxU64Register200);		   // PTX L1799
	r_PtxRegister736 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register201 + 262144ull);	   // PTX L1800
	r_LaneIndexAtPtx1802 = uint32_t((threadIdx.x & 31u));									   // PTX L1802
	r_PackedHalf2AtPtx1805R2034 = HalfMul(r_PackedHalf2AtPtx654R546, r_PtxRegister547);		   // PTX L1805
	r_LaneIndexAtPtx1809 = uint32_t((threadIdx.x & 31u));									   // PTX L1809
	r_PackedHalf2AtPtx1812R2033 = HalfMul(r_PackedHalf2AtPtx660R549, r_PtxRegister550);		   // PTX L1812
	r_LaneIndexAtPtx1816 = uint32_t((threadIdx.x & 31u));									   // PTX L1816
	r_PackedHalf2AtPtx1819R2032 = HalfMul(r_PackedHalf2AtPtx657R552, r_PtxRegister553);		   // PTX L1819
	r_LaneIndexAtPtx1823 = uint32_t((threadIdx.x & 31u));									   // PTX L1823
	r_PackedHalf2AtPtx1826R2031 = HalfMul(r_PackedHalf2AtPtx663R555, r_PtxRegister556);		   // PTX L1826
	r_LaneIndexAtPtx1830 = uint32_t((threadIdx.x & 31u));									   // PTX L1830
	r_PackedHalf2AtPtx1833R2030 = HalfMul(r_PackedHalf2AtPtx666R558, r_PtxRegister559);		   // PTX L1833
	r_LaneIndexAtPtx1837 = uint32_t((threadIdx.x & 31u));									   // PTX L1837
	r_PackedHalf2AtPtx1840R2029 = HalfMul(r_PackedHalf2AtPtx672R561, r_PtxRegister562);		   // PTX L1840
	r_LaneIndexAtPtx1844 = uint32_t((threadIdx.x & 31u));									   // PTX L1844
	r_PackedHalf2AtPtx1847R2028 = HalfMul(r_PackedHalf2AtPtx669R564, r_PtxRegister565);		   // PTX L1847
	r_LaneIndexAtPtx1851 = uint32_t((threadIdx.x & 31u));									   // PTX L1851
	r_PackedHalf2AtPtx1854R2027 = HalfMul(r_PackedHalf2AtPtx675R567, r_PtxRegister568);		   // PTX L1854
	r_LaneIndexAtPtx1858 = uint32_t((threadIdx.x & 31u));									   // PTX L1858
	r_PackedHalf2AtPtx1861R2026 = HalfMul(r_PackedHalf2AtPtx678R570, r_PtxRegister571);		   // PTX L1861
	r_LaneIndexAtPtx1865 = uint32_t((threadIdx.x & 31u));									   // PTX L1865
	r_PackedHalf2AtPtx1868R2025 = HalfMul(r_PackedHalf2AtPtx684R573, r_PtxRegister574);		   // PTX L1868
	r_LaneIndexAtPtx1872 = uint32_t((threadIdx.x & 31u));									   // PTX L1872
	r_PackedHalf2AtPtx1875R2024 = HalfMul(r_PackedHalf2AtPtx681R576, r_PtxRegister577);		   // PTX L1875
	r_LaneIndexAtPtx1879 = uint32_t((threadIdx.x & 31u));									   // PTX L1879
	r_PackedHalf2AtPtx1882R2023 = HalfMul(r_PackedHalf2AtPtx687R579, r_PtxRegister580);		   // PTX L1882
	r_LaneIndexAtPtx1886 = uint32_t((threadIdx.x & 31u));									   // PTX L1886
	r_PackedHalf2AtPtx1889R2022 = HalfMul(r_PackedHalf2AtPtx690R582, r_PtxRegister583);		   // PTX L1889
	r_LaneIndexAtPtx1893 = uint32_t((threadIdx.x & 31u));									   // PTX L1893
	r_PackedHalf2AtPtx1896R2021 = HalfMul(r_PackedHalf2AtPtx696R585, r_PtxRegister586);		   // PTX L1896
	r_LaneIndexAtPtx1900 = uint32_t((threadIdx.x & 31u));									   // PTX L1900
	r_PackedHalf2AtPtx1903R2020 = HalfMul(r_PackedHalf2AtPtx693R588, r_PtxRegister589);		   // PTX L1903
	r_LaneIndexAtPtx1907 = uint32_t((threadIdx.x & 31u));									   // PTX L1907
	r_PackedHalf2AtPtx1910R2019 = HalfMul(r_PackedHalf2AtPtx699R591, r_PtxRegister592);		   // PTX L1910
	r_LaneIndexAtPtx1914 = uint32_t((threadIdx.x & 31u));									   // PTX L1914
	r_PackedHalf2AtPtx1917R2018 = HalfMul(r_PackedHalf2AtPtx702R594, r_PtxRegister595);		   // PTX L1917
	r_LaneIndexAtPtx1921 = uint32_t((threadIdx.x & 31u));									   // PTX L1921
	r_PackedHalf2AtPtx1924R2017 = HalfMul(r_PackedHalf2AtPtx708R597, r_PtxRegister598);		   // PTX L1924
	r_LaneIndexAtPtx1928 = uint32_t((threadIdx.x & 31u));									   // PTX L1928
	r_PackedHalf2AtPtx1931R2016 = HalfMul(r_PackedHalf2AtPtx705R600, r_PtxRegister601);		   // PTX L1931
	r_LaneIndexAtPtx1935 = uint32_t((threadIdx.x & 31u));									   // PTX L1935
	r_PackedHalf2AtPtx1938R2015 = HalfMul(r_PackedHalf2AtPtx711R603, r_PtxRegister604);		   // PTX L1938
	r_LaneIndexAtPtx1942 = uint32_t((threadIdx.x & 31u));									   // PTX L1942
	r_PackedHalf2AtPtx1945R2014 = HalfMul(r_PackedHalf2AtPtx714R606, r_PtxRegister607);		   // PTX L1945
	r_LaneIndexAtPtx1949 = uint32_t((threadIdx.x & 31u));									   // PTX L1949
	r_PackedHalf2AtPtx1952R2013 = HalfMul(r_PackedHalf2AtPtx720R609, r_PtxRegister610);		   // PTX L1952
	r_LaneIndexAtPtx1956 = uint32_t((threadIdx.x & 31u));									   // PTX L1956
	r_PackedHalf2AtPtx1959R2012 = HalfMul(r_PackedHalf2AtPtx717R612, r_PtxRegister613);		   // PTX L1959
	r_LaneIndexAtPtx1963 = uint32_t((threadIdx.x & 31u));									   // PTX L1963
	r_PackedHalf2AtPtx1966R2011 = HalfMul(r_PackedHalf2AtPtx723R615, r_PtxRegister616);		   // PTX L1966
	r_LaneIndexAtPtx1970 = uint32_t((threadIdx.x & 31u));									   // PTX L1970
	r_PackedHalf2AtPtx1973R2010 = HalfMul(r_PackedHalf2AtPtx726R618, r_PtxRegister619);		   // PTX L1973
	r_LaneIndexAtPtx1977 = uint32_t((threadIdx.x & 31u));									   // PTX L1977
	r_PackedHalf2AtPtx1980R2009 = HalfMul(r_PackedHalf2AtPtx732R621, r_PtxRegister622);		   // PTX L1980
	r_LaneIndexAtPtx1984 = uint32_t((threadIdx.x & 31u));									   // PTX L1984
	r_PackedHalf2AtPtx1987R2008 = HalfMul(r_PackedHalf2AtPtx729R624, r_PtxRegister625);		   // PTX L1987
	r_LaneIndexAtPtx1991 = uint32_t((threadIdx.x & 31u));									   // PTX L1991
	r_PackedHalf2AtPtx1994R2007 = HalfMul(r_PackedHalf2AtPtx735R627, r_PtxRegister628);		   // PTX L1994
	r_LaneIndexAtPtx1998 = uint32_t((threadIdx.x & 31u));									   // PTX L1998
	r_PackedHalf2AtPtx2001R2006 = HalfMul(r_PackedHalf2AtPtx738R630, r_PtxRegister631);		   // PTX L2001
	r_LaneIndexAtPtx2005 = uint32_t((threadIdx.x & 31u));									   // PTX L2005
	r_PackedHalf2AtPtx2008R2005 = HalfMul(r_PackedHalf2AtPtx744R633, r_PtxRegister634);		   // PTX L2008
	r_LaneIndexAtPtx2012 = uint32_t((threadIdx.x & 31u));									   // PTX L2012
	r_PackedHalf2AtPtx2015R2004 = HalfMul(r_PackedHalf2AtPtx741R636, r_PtxRegister637);		   // PTX L2015
	r_LaneIndexAtPtx2019 = uint32_t((threadIdx.x & 31u));									   // PTX L2019
	r_PackedHalf2AtPtx2022R2003 = HalfMul(r_PackedHalf2AtPtx747R639, r_PtxRegister640);		   // PTX L2022
	r_LaneIndexAtPtx2026 = uint32_t((threadIdx.x & 31u));									   // PTX L2026
	r_PackedHalf2AtPtx2029R2002 = HalfMul(r_PackedHalf2AtPtx750R642, r_PtxRegister643);		   // PTX L2029
	r_LaneIndexAtPtx2033 = uint32_t((threadIdx.x & 31u));									   // PTX L2033
	r_PackedHalf2AtPtx2036R2001 = HalfMul(r_PackedHalf2AtPtx756R645, r_PtxRegister646);		   // PTX L2036
	r_LaneIndexAtPtx2040 = uint32_t((threadIdx.x & 31u));									   // PTX L2040
	r_PackedHalf2AtPtx2043R2000 = HalfMul(r_PackedHalf2AtPtx753R648, r_PtxRegister649);		   // PTX L2043
	r_LaneIndexAtPtx2047 = uint32_t((threadIdx.x & 31u));									   // PTX L2047
	r_PackedHalf2AtPtx2050R1999 = HalfMul(r_PackedHalf2AtPtx759R651, r_PtxRegister652);		   // PTX L2050
	r_LaneIndexAtPtx2054 = uint32_t((threadIdx.x & 31u));									   // PTX L2054
	r_PackedHalf2AtPtx2057R1998 = HalfMul(r_PackedHalf2AtPtx762R654, r_PtxRegister655);		   // PTX L2057
	r_LaneIndexAtPtx2061 = uint32_t((threadIdx.x & 31u));									   // PTX L2061
	r_PackedHalf2AtPtx2064R1997 = HalfMul(r_PackedHalf2AtPtx768R657, r_PtxRegister658);		   // PTX L2064
	r_LaneIndexAtPtx2068 = uint32_t((threadIdx.x & 31u));									   // PTX L2068
	r_PackedHalf2AtPtx2071R1996 = HalfMul(r_PackedHalf2AtPtx765R660, r_PtxRegister661);		   // PTX L2071
	r_LaneIndexAtPtx2075 = uint32_t((threadIdx.x & 31u));									   // PTX L2075
	r_PackedHalf2AtPtx2078R1995 = HalfMul(r_PackedHalf2AtPtx771R663, r_PtxRegister664);		   // PTX L2078
	r_LaneIndexAtPtx2082 = uint32_t((threadIdx.x & 31u));									   // PTX L2082
	r_PackedHalf2AtPtx2085R1994 = HalfMul(r_PackedHalf2AtPtx774R666, r_PtxRegister667);		   // PTX L2085
	r_LaneIndexAtPtx2089 = uint32_t((threadIdx.x & 31u));									   // PTX L2089
	r_PackedHalf2AtPtx2092R1993 = HalfMul(r_PackedHalf2AtPtx780R669, r_PtxRegister670);		   // PTX L2092
	r_LaneIndexAtPtx2096 = uint32_t((threadIdx.x & 31u));									   // PTX L2096
	r_PackedHalf2AtPtx2099R1992 = HalfMul(r_PackedHalf2AtPtx777R672, r_PtxRegister673);		   // PTX L2099
	r_LaneIndexAtPtx2103 = uint32_t((threadIdx.x & 31u));									   // PTX L2103
	r_PackedHalf2AtPtx2106R1991 = HalfMul(r_PackedHalf2AtPtx783R675, r_PtxRegister676);		   // PTX L2106
	r_LaneIndexAtPtx2110 = uint32_t((threadIdx.x & 31u));									   // PTX L2110
	r_PackedHalf2AtPtx2113R1990 = HalfMul(r_PackedHalf2AtPtx786R678, r_PtxRegister679);		   // PTX L2113
	r_LaneIndexAtPtx2117 = uint32_t((threadIdx.x & 31u));									   // PTX L2117
	r_PackedHalf2AtPtx2120R1989 = HalfMul(r_PackedHalf2AtPtx792R681, r_PtxRegister682);		   // PTX L2120
	r_LaneIndexAtPtx2124 = uint32_t((threadIdx.x & 31u));									   // PTX L2124
	r_PackedHalf2AtPtx2127R1988 = HalfMul(r_PackedHalf2AtPtx789R684, r_PtxRegister685);		   // PTX L2127
	r_LaneIndexAtPtx2131 = uint32_t((threadIdx.x & 31u));									   // PTX L2131
	r_PackedHalf2AtPtx2134R1987 = HalfMul(r_PackedHalf2AtPtx795R687, r_PtxRegister688);		   // PTX L2134
	r_LaneIndexAtPtx2138 = uint32_t((threadIdx.x & 31u));									   // PTX L2138
	r_PackedHalf2AtPtx2141R1986 = HalfMul(r_PackedHalf2AtPtx798R690, r_PtxRegister691);		   // PTX L2141
	r_LaneIndexAtPtx2145 = uint32_t((threadIdx.x & 31u));									   // PTX L2145
	r_PackedHalf2AtPtx2148R1985 = HalfMul(r_PackedHalf2AtPtx804R693, r_PtxRegister694);		   // PTX L2148
	r_LaneIndexAtPtx2152 = uint32_t((threadIdx.x & 31u));									   // PTX L2152
	r_PackedHalf2AtPtx2155R1984 = HalfMul(r_PackedHalf2AtPtx801R696, r_PtxRegister697);		   // PTX L2155
	r_LaneIndexAtPtx2159 = uint32_t((threadIdx.x & 31u));									   // PTX L2159
	r_PackedHalf2AtPtx2162R1983 = HalfMul(r_PackedHalf2AtPtx807R699, r_PtxRegister700);		   // PTX L2162
	r_LaneIndexAtPtx2166 = uint32_t((threadIdx.x & 31u));									   // PTX L2166
	r_PackedHalf2AtPtx2169R1982 = HalfMul(r_PackedHalf2AtPtx810R702, r_PtxRegister703);		   // PTX L2169
	r_LaneIndexAtPtx2173 = uint32_t((threadIdx.x & 31u));									   // PTX L2173
	r_PackedHalf2AtPtx2176R1981 = HalfMul(r_PackedHalf2AtPtx816R705, r_PtxRegister706);		   // PTX L2176
	r_LaneIndexAtPtx2180 = uint32_t((threadIdx.x & 31u));									   // PTX L2180
	r_PackedHalf2AtPtx2183R1980 = HalfMul(r_PackedHalf2AtPtx813R708, r_PtxRegister709);		   // PTX L2183
	r_LaneIndexAtPtx2187 = uint32_t((threadIdx.x & 31u));									   // PTX L2187
	r_PackedHalf2AtPtx2190R1979 = HalfMul(r_PackedHalf2AtPtx819R711, r_PtxRegister712);		   // PTX L2190
	r_LaneIndexAtPtx2194 = uint32_t((threadIdx.x & 31u));									   // PTX L2194
	r_PackedHalf2AtPtx2197R1978 = HalfMul(r_PackedHalf2AtPtx823R714, r_PtxRegister715);		   // PTX L2197
	r_LaneIndexAtPtx2201 = uint32_t((threadIdx.x & 31u));									   // PTX L2201
	r_PackedHalf2AtPtx2204R1977 = HalfMul(r_PackedHalf2AtPtx830R717, r_PtxRegister718);		   // PTX L2204
	r_LaneIndexAtPtx2208 = uint32_t((threadIdx.x & 31u));									   // PTX L2208
	r_PackedHalf2AtPtx2211R1976 = HalfMul(r_PackedHalf2AtPtx826R720, r_PtxRegister721);		   // PTX L2211
	r_LaneIndexAtPtx2215 = uint32_t((threadIdx.x & 31u));									   // PTX L2215
	r_PackedHalf2AtPtx2218R1975 = HalfMul(r_PackedHalf2AtPtx833R723, r_PtxRegister724);		   // PTX L2218
	r_LaneIndexAtPtx2222 = uint32_t((threadIdx.x & 31u));									   // PTX L2222
	r_PackedHalf2AtPtx2225R1974 = HalfMul(r_PackedHalf2AtPtx837R726, r_PtxRegister727);		   // PTX L2225
	r_LaneIndexAtPtx2229 = uint32_t((threadIdx.x & 31u));									   // PTX L2229
	r_PackedHalf2AtPtx2232R2035 = HalfMul(r_PackedHalf2AtPtx844R729, r_PtxRegister730);		   // PTX L2232
	r_LaneIndexAtPtx2236 = uint32_t((threadIdx.x & 31u));									   // PTX L2236
	r_PackedHalf2AtPtx2239R2036 = HalfMul(r_PackedHalf2AtPtx840R732, r_PtxRegister733);		   // PTX L2239
	r_LaneIndexAtPtx2243 = uint32_t((threadIdx.x & 31u));									   // PTX L2243
	r_PackedHalf2AtPtx2246R2037 = HalfMul(r_PackedHalf2AtPtx847R735, r_PtxRegister736);		   // PTX L2246
	r_PtxU64Register2 = r_Pointer0Bits;														   // PTX L2249
	r_PtxRegister30 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));								   // PTX L2250
	r_PtxRegister2038 = uint32_t(0);														   // PTX L2251
L__BB39_47:																					   // PTX L2252
	r_PtxRegister31 = r_ThreadY & 1;														   // PTX L2253
	r_PtxRegister1416 = r_PtxRegister372 | r_PtxRegister5;									   // PTX L2254
	r_bPtxPredicate50 = int32_t(r_PtxRegister1416) < int32_t(r_PtxRegister7);				   // PTX L2255
	r_bPtxPredicate51 = int32_t(r_PtxRegister376) < int32_t(r_PtxRegister6);				   // PTX L2256
	r_bPtxPredicate52 = int32_t(r_PtxRegister376) >= int32_t(r_PtxRegister6);				   // PTX L2257
	r_bPtxPredicate53 = uint32_t(r_PtxRegister21) == uint32_t(4);							   // PTX L2258
	r_bPtxPredicate54 = uint32_t(r_PtxRegister15) == uint32_t(4);							   // PTX L2259
	r_PtxRegister1417 = ShiftRight(uint32_t(r_PtxRegister2038), uint32_t(6));				   // PTX L2260
	r_PtxRegister1418 = ~uint32_t(r_PtxRegister1417);										   // PTX L2261
	r_PtxRegister32 = uint32_t(r_PtxRegister2038) + uint32_t(64);							   // PTX L2262
	r_PtxRegister33 = r_PtxRegister1418 & 1;												   // PTX L2263
	r_PtxRegister1419 = ShiftLeft(uint32_t(r_PtxRegister2038), uint32_t(6));				   // PTX L2264
	r_PtxRegister1420 = r_PtxRegister1419 & 4096;											   // PTX L2265
	r_PtxRegister1421 = uint32_t(0u /* exact native shared-region offset */);				   // PTX L2266
	r_PtxRegister1422 = uint32_t(r_PtxRegister1421) + uint32_t(r_PtxRegister1420);			   // PTX L2267
	r_LaneIndexAtPtx2269 = uint32_t((threadIdx.x & 31u));									   // PTX L2269
	r_PtxRegister1423 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2269), uint32_t(4));				   // PTX L2271
	r_PtxRegister1305 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1423);			   // PTX L2272
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1305));
		r_MmaAE4x4WordAtPtx2274R1320 = r_Value.x;
		r_MmaAE4x4WordAtPtx2274R1321 = r_Value.y;
		r_MmaAE4x4WordAtPtx2274R1322 = r_Value.z;
		r_MmaAE4x4WordAtPtx2274R1323 = r_Value.w;
	} // PTX L2274
	r_LaneIndexAtPtx2277 = uint32_t((threadIdx.x & 31u));						   // PTX L2277
	r_PtxRegister1424 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2277), uint32_t(4));	   // PTX L2279
	r_PtxRegister1425 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1424); // PTX L2280
	r_PtxRegister1307 = uint32_t(r_PtxRegister1425) + uint32_t(512);			   // PTX L2281
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1307));
		r_MmaAE4x4WordAtPtx2283R1324 = r_Value.x;
		r_MmaAE4x4WordAtPtx2283R1325 = r_Value.y;
		r_MmaAE4x4WordAtPtx2283R1326 = r_Value.z;
		r_MmaAE4x4WordAtPtx2283R1327 = r_Value.w;
	} // PTX L2283
	r_LaneIndexAtPtx2286 = uint32_t((threadIdx.x & 31u));						   // PTX L2286
	r_PtxRegister1426 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2286), uint32_t(4));	   // PTX L2288
	r_PtxRegister1427 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1426); // PTX L2289
	r_PtxRegister1309 = uint32_t(r_PtxRegister1427) + uint32_t(1024);			   // PTX L2290
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1309));
		r_MmaAE4x4WordAtPtx2292R1344 = r_Value.x;
		r_MmaAE4x4WordAtPtx2292R1345 = r_Value.y;
		r_MmaAE4x4WordAtPtx2292R1346 = r_Value.z;
		r_MmaAE4x4WordAtPtx2292R1347 = r_Value.w;
	} // PTX L2292
	r_LaneIndexAtPtx2295 = uint32_t((threadIdx.x & 31u));						   // PTX L2295
	r_PtxRegister1428 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2295), uint32_t(4));	   // PTX L2297
	r_PtxRegister1429 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1428); // PTX L2298
	r_PtxRegister1311 = uint32_t(r_PtxRegister1429) + uint32_t(1536);			   // PTX L2299
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1311));
		r_MmaAE4x4WordAtPtx2301R1348 = r_Value.x;
		r_MmaAE4x4WordAtPtx2301R1349 = r_Value.y;
		r_MmaAE4x4WordAtPtx2301R1350 = r_Value.z;
		r_MmaAE4x4WordAtPtx2301R1351 = r_Value.w;
	} // PTX L2301
	r_LaneIndexAtPtx2304 = uint32_t((threadIdx.x & 31u));						   // PTX L2304
	r_PtxRegister1430 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2304), uint32_t(4));	   // PTX L2306
	r_PtxRegister1431 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1430); // PTX L2307
	r_PtxRegister1313 = uint32_t(r_PtxRegister1431) + uint32_t(2048);			   // PTX L2308
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1313));
		r_MmaAE4x4WordAtPtx2310R1368 = r_Value.x;
		r_MmaAE4x4WordAtPtx2310R1369 = r_Value.y;
		r_MmaAE4x4WordAtPtx2310R1370 = r_Value.z;
		r_MmaAE4x4WordAtPtx2310R1371 = r_Value.w;
	} // PTX L2310
	r_LaneIndexAtPtx2313 = uint32_t((threadIdx.x & 31u));						   // PTX L2313
	r_PtxRegister1432 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2313), uint32_t(4));	   // PTX L2315
	r_PtxRegister1433 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1432); // PTX L2316
	r_PtxRegister1315 = uint32_t(r_PtxRegister1433) + uint32_t(2560);			   // PTX L2317
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1315));
		r_MmaAE4x4WordAtPtx2319R1372 = r_Value.x;
		r_MmaAE4x4WordAtPtx2319R1373 = r_Value.y;
		r_MmaAE4x4WordAtPtx2319R1374 = r_Value.z;
		r_MmaAE4x4WordAtPtx2319R1375 = r_Value.w;
	} // PTX L2319
	r_LaneIndexAtPtx2322 = uint32_t((threadIdx.x & 31u));						   // PTX L2322
	r_PtxRegister1434 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2322), uint32_t(4));	   // PTX L2324
	r_PtxRegister1435 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1434); // PTX L2325
	r_PtxRegister1317 = uint32_t(r_PtxRegister1435) + uint32_t(3072);			   // PTX L2326
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1317));
		r_MmaAE4x4WordAtPtx2328R1392 = r_Value.x;
		r_MmaAE4x4WordAtPtx2328R1393 = r_Value.y;
		r_MmaAE4x4WordAtPtx2328R1394 = r_Value.z;
		r_MmaAE4x4WordAtPtx2328R1395 = r_Value.w;
	} // PTX L2328
	r_LaneIndexAtPtx2331 = uint32_t((threadIdx.x & 31u));						   // PTX L2331
	r_PtxRegister1436 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2331), uint32_t(4));	   // PTX L2333
	r_PtxRegister1437 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1436); // PTX L2334
	r_PtxRegister1319 = uint32_t(r_PtxRegister1437) + uint32_t(3584);			   // PTX L2335
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1319));
		r_MmaAE4x4WordAtPtx2337R1396 = r_Value.x;
		r_MmaAE4x4WordAtPtx2337R1397 = r_Value.y;
		r_MmaAE4x4WordAtPtx2337R1398 = r_Value.z;
		r_MmaAE4x4WordAtPtx2337R1399 = r_Value.w;
	} // PTX L2337
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2340R1328, r_MmaAccumulatorHalf2WordAtPtx2340R1329,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx1805R2034,
		  r_PackedHalf2AtPtx1812R2033); // PTX L2340
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2347R1330, r_MmaAccumulatorHalf2WordAtPtx2347R1331,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx1819R2032,
		  r_PackedHalf2AtPtx1826R2031); // PTX L2347
	MmaE4(r_PackedHalf2AtPtx1805R2034, r_PackedHalf2AtPtx1812R2033, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx112R2055, r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx2340R1328,
		  r_MmaAccumulatorHalf2WordAtPtx2340R1329); // PTX L2354
	MmaE4(r_PackedHalf2AtPtx1819R2032, r_PackedHalf2AtPtx1826R2031, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx112R2057, r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx2347R1330,
		  r_MmaAccumulatorHalf2WordAtPtx2347R1331); // PTX L2361
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2368R1332, r_MmaAccumulatorHalf2WordAtPtx2368R1333,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx1833R2030,
		  r_PackedHalf2AtPtx1840R2029); // PTX L2368
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2375R1334, r_MmaAccumulatorHalf2WordAtPtx2375R1335,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx1847R2028,
		  r_PackedHalf2AtPtx1854R2027); // PTX L2375
	MmaE4(r_PackedHalf2AtPtx1833R2030, r_PackedHalf2AtPtx1840R2029, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx121R2059, r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx2368R1332,
		  r_MmaAccumulatorHalf2WordAtPtx2368R1333); // PTX L2382
	MmaE4(r_PackedHalf2AtPtx1847R2028, r_PackedHalf2AtPtx1854R2027, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx121R2061, r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx2375R1334,
		  r_MmaAccumulatorHalf2WordAtPtx2375R1335); // PTX L2389
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2396R1336, r_MmaAccumulatorHalf2WordAtPtx2396R1337,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx1861R2026,
		  r_PackedHalf2AtPtx1868R2025); // PTX L2396
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2403R1338, r_MmaAccumulatorHalf2WordAtPtx2403R1339,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx1875R2024,
		  r_PackedHalf2AtPtx1882R2023); // PTX L2403
	MmaE4(r_PackedHalf2AtPtx1861R2026, r_PackedHalf2AtPtx1868R2025, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx130R2063, r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx2396R1336,
		  r_MmaAccumulatorHalf2WordAtPtx2396R1337); // PTX L2410
	MmaE4(r_PackedHalf2AtPtx1875R2024, r_PackedHalf2AtPtx1882R2023, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx130R2065, r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx2403R1338,
		  r_MmaAccumulatorHalf2WordAtPtx2403R1339); // PTX L2417
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2424R1340, r_MmaAccumulatorHalf2WordAtPtx2424R1341,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx1889R2022,
		  r_PackedHalf2AtPtx1896R2021); // PTX L2424
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2431R1342, r_MmaAccumulatorHalf2WordAtPtx2431R1343,
		  r_MmaAE4x4WordAtPtx2274R1320, r_MmaAE4x4WordAtPtx2274R1321, r_MmaAE4x4WordAtPtx2274R1322,
		  r_MmaAE4x4WordAtPtx2274R1323, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx1903R2020,
		  r_PackedHalf2AtPtx1910R2019); // PTX L2431
	MmaE4(r_PackedHalf2AtPtx1889R2022, r_PackedHalf2AtPtx1896R2021, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx139R2067, r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx2424R1340,
		  r_MmaAccumulatorHalf2WordAtPtx2424R1341); // PTX L2438
	MmaE4(r_PackedHalf2AtPtx1903R2020, r_PackedHalf2AtPtx1910R2019, r_MmaAE4x4WordAtPtx2283R1324,
		  r_MmaAE4x4WordAtPtx2283R1325, r_MmaAE4x4WordAtPtx2283R1326, r_MmaAE4x4WordAtPtx2283R1327,
		  r_MmaBE4x4WordAtPtx139R2069, r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx2431R1342,
		  r_MmaAccumulatorHalf2WordAtPtx2431R1343); // PTX L2445
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2452R1352, r_MmaAccumulatorHalf2WordAtPtx2452R1353,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx1917R2018,
		  r_PackedHalf2AtPtx1924R2017); // PTX L2452
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2459R1354, r_MmaAccumulatorHalf2WordAtPtx2459R1355,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx1931R2016,
		  r_PackedHalf2AtPtx1938R2015); // PTX L2459
	MmaE4(r_PackedHalf2AtPtx1917R2018, r_PackedHalf2AtPtx1924R2017, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx112R2055, r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx2452R1352,
		  r_MmaAccumulatorHalf2WordAtPtx2452R1353); // PTX L2466
	MmaE4(r_PackedHalf2AtPtx1931R2016, r_PackedHalf2AtPtx1938R2015, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx112R2057, r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx2459R1354,
		  r_MmaAccumulatorHalf2WordAtPtx2459R1355); // PTX L2473
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2480R1356, r_MmaAccumulatorHalf2WordAtPtx2480R1357,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx1945R2014,
		  r_PackedHalf2AtPtx1952R2013); // PTX L2480
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2487R1358, r_MmaAccumulatorHalf2WordAtPtx2487R1359,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx1959R2012,
		  r_PackedHalf2AtPtx1966R2011); // PTX L2487
	MmaE4(r_PackedHalf2AtPtx1945R2014, r_PackedHalf2AtPtx1952R2013, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx121R2059, r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx2480R1356,
		  r_MmaAccumulatorHalf2WordAtPtx2480R1357); // PTX L2494
	MmaE4(r_PackedHalf2AtPtx1959R2012, r_PackedHalf2AtPtx1966R2011, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx121R2061, r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx2487R1358,
		  r_MmaAccumulatorHalf2WordAtPtx2487R1359); // PTX L2501
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2508R1360, r_MmaAccumulatorHalf2WordAtPtx2508R1361,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx1973R2010,
		  r_PackedHalf2AtPtx1980R2009); // PTX L2508
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2515R1362, r_MmaAccumulatorHalf2WordAtPtx2515R1363,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx1987R2008,
		  r_PackedHalf2AtPtx1994R2007); // PTX L2515
	MmaE4(r_PackedHalf2AtPtx1973R2010, r_PackedHalf2AtPtx1980R2009, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx130R2063, r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx2508R1360,
		  r_MmaAccumulatorHalf2WordAtPtx2508R1361); // PTX L2522
	MmaE4(r_PackedHalf2AtPtx1987R2008, r_PackedHalf2AtPtx1994R2007, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx130R2065, r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx2515R1362,
		  r_MmaAccumulatorHalf2WordAtPtx2515R1363); // PTX L2529
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2536R1364, r_MmaAccumulatorHalf2WordAtPtx2536R1365,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2001R2006,
		  r_PackedHalf2AtPtx2008R2005); // PTX L2536
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2543R1366, r_MmaAccumulatorHalf2WordAtPtx2543R1367,
		  r_MmaAE4x4WordAtPtx2292R1344, r_MmaAE4x4WordAtPtx2292R1345, r_MmaAE4x4WordAtPtx2292R1346,
		  r_MmaAE4x4WordAtPtx2292R1347, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2015R2004,
		  r_PackedHalf2AtPtx2022R2003); // PTX L2543
	MmaE4(r_PackedHalf2AtPtx2001R2006, r_PackedHalf2AtPtx2008R2005, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx139R2067, r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx2536R1364,
		  r_MmaAccumulatorHalf2WordAtPtx2536R1365); // PTX L2550
	MmaE4(r_PackedHalf2AtPtx2015R2004, r_PackedHalf2AtPtx2022R2003, r_MmaAE4x4WordAtPtx2301R1348,
		  r_MmaAE4x4WordAtPtx2301R1349, r_MmaAE4x4WordAtPtx2301R1350, r_MmaAE4x4WordAtPtx2301R1351,
		  r_MmaBE4x4WordAtPtx139R2069, r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx2543R1366,
		  r_MmaAccumulatorHalf2WordAtPtx2543R1367); // PTX L2557
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2564R1376, r_MmaAccumulatorHalf2WordAtPtx2564R1377,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx2029R2002,
		  r_PackedHalf2AtPtx2036R2001); // PTX L2564
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2571R1378, r_MmaAccumulatorHalf2WordAtPtx2571R1379,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx2043R2000,
		  r_PackedHalf2AtPtx2050R1999); // PTX L2571
	MmaE4(r_PackedHalf2AtPtx2029R2002, r_PackedHalf2AtPtx2036R2001, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx112R2055, r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx2564R1376,
		  r_MmaAccumulatorHalf2WordAtPtx2564R1377); // PTX L2578
	MmaE4(r_PackedHalf2AtPtx2043R2000, r_PackedHalf2AtPtx2050R1999, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx112R2057, r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx2571R1378,
		  r_MmaAccumulatorHalf2WordAtPtx2571R1379); // PTX L2585
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2592R1380, r_MmaAccumulatorHalf2WordAtPtx2592R1381,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx2057R1998,
		  r_PackedHalf2AtPtx2064R1997); // PTX L2592
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2599R1382, r_MmaAccumulatorHalf2WordAtPtx2599R1383,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx2071R1996,
		  r_PackedHalf2AtPtx2078R1995); // PTX L2599
	MmaE4(r_PackedHalf2AtPtx2057R1998, r_PackedHalf2AtPtx2064R1997, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx121R2059, r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx2592R1380,
		  r_MmaAccumulatorHalf2WordAtPtx2592R1381); // PTX L2606
	MmaE4(r_PackedHalf2AtPtx2071R1996, r_PackedHalf2AtPtx2078R1995, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx121R2061, r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx2599R1382,
		  r_MmaAccumulatorHalf2WordAtPtx2599R1383); // PTX L2613
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2620R1384, r_MmaAccumulatorHalf2WordAtPtx2620R1385,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx2085R1994,
		  r_PackedHalf2AtPtx2092R1993); // PTX L2620
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2627R1386, r_MmaAccumulatorHalf2WordAtPtx2627R1387,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx2099R1992,
		  r_PackedHalf2AtPtx2106R1991); // PTX L2627
	MmaE4(r_PackedHalf2AtPtx2085R1994, r_PackedHalf2AtPtx2092R1993, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx130R2063, r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx2620R1384,
		  r_MmaAccumulatorHalf2WordAtPtx2620R1385); // PTX L2634
	MmaE4(r_PackedHalf2AtPtx2099R1992, r_PackedHalf2AtPtx2106R1991, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx130R2065, r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx2627R1386,
		  r_MmaAccumulatorHalf2WordAtPtx2627R1387); // PTX L2641
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2648R1388, r_MmaAccumulatorHalf2WordAtPtx2648R1389,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2113R1990,
		  r_PackedHalf2AtPtx2120R1989); // PTX L2648
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2655R1390, r_MmaAccumulatorHalf2WordAtPtx2655R1391,
		  r_MmaAE4x4WordAtPtx2310R1368, r_MmaAE4x4WordAtPtx2310R1369, r_MmaAE4x4WordAtPtx2310R1370,
		  r_MmaAE4x4WordAtPtx2310R1371, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2127R1988,
		  r_PackedHalf2AtPtx2134R1987); // PTX L2655
	MmaE4(r_PackedHalf2AtPtx2113R1990, r_PackedHalf2AtPtx2120R1989, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx139R2067, r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx2648R1388,
		  r_MmaAccumulatorHalf2WordAtPtx2648R1389); // PTX L2662
	MmaE4(r_PackedHalf2AtPtx2127R1988, r_PackedHalf2AtPtx2134R1987, r_MmaAE4x4WordAtPtx2319R1372,
		  r_MmaAE4x4WordAtPtx2319R1373, r_MmaAE4x4WordAtPtx2319R1374, r_MmaAE4x4WordAtPtx2319R1375,
		  r_MmaBE4x4WordAtPtx139R2069, r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx2655R1390,
		  r_MmaAccumulatorHalf2WordAtPtx2655R1391); // PTX L2669
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2676R1400, r_MmaAccumulatorHalf2WordAtPtx2676R1401,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx2141R1986,
		  r_PackedHalf2AtPtx2148R1985); // PTX L2676
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2683R1402, r_MmaAccumulatorHalf2WordAtPtx2683R1403,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx2155R1984,
		  r_PackedHalf2AtPtx2162R1983); // PTX L2683
	MmaE4(r_PackedHalf2AtPtx2141R1986, r_PackedHalf2AtPtx2148R1985, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx112R2055, r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx2676R1400,
		  r_MmaAccumulatorHalf2WordAtPtx2676R1401); // PTX L2690
	MmaE4(r_PackedHalf2AtPtx2155R1984, r_PackedHalf2AtPtx2162R1983, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx112R2057, r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx2683R1402,
		  r_MmaAccumulatorHalf2WordAtPtx2683R1403); // PTX L2697
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2704R1404, r_MmaAccumulatorHalf2WordAtPtx2704R1405,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx2169R1982,
		  r_PackedHalf2AtPtx2176R1981); // PTX L2704
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2711R1406, r_MmaAccumulatorHalf2WordAtPtx2711R1407,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx2183R1980,
		  r_PackedHalf2AtPtx2190R1979); // PTX L2711
	MmaE4(r_PackedHalf2AtPtx2169R1982, r_PackedHalf2AtPtx2176R1981, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx121R2059, r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx2704R1404,
		  r_MmaAccumulatorHalf2WordAtPtx2704R1405); // PTX L2718
	MmaE4(r_PackedHalf2AtPtx2183R1980, r_PackedHalf2AtPtx2190R1979, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx121R2061, r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx2711R1406,
		  r_MmaAccumulatorHalf2WordAtPtx2711R1407); // PTX L2725
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2732R1408, r_MmaAccumulatorHalf2WordAtPtx2732R1409,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx2197R1978,
		  r_PackedHalf2AtPtx2204R1977); // PTX L2732
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2739R1410, r_MmaAccumulatorHalf2WordAtPtx2739R1411,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx2211R1976,
		  r_PackedHalf2AtPtx2218R1975); // PTX L2739
	MmaE4(r_PackedHalf2AtPtx2197R1978, r_PackedHalf2AtPtx2204R1977, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx130R2063, r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx2732R1408,
		  r_MmaAccumulatorHalf2WordAtPtx2732R1409); // PTX L2746
	MmaE4(r_PackedHalf2AtPtx2211R1976, r_PackedHalf2AtPtx2218R1975, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx130R2065, r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx2739R1410,
		  r_MmaAccumulatorHalf2WordAtPtx2739R1411); // PTX L2753
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2760R1412, r_MmaAccumulatorHalf2WordAtPtx2760R1413,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2225R1974,
		  r_PackedHalf2AtPtx2232R2035); // PTX L2760
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2767R1414, r_MmaAccumulatorHalf2WordAtPtx2767R1415,
		  r_MmaAE4x4WordAtPtx2328R1392, r_MmaAE4x4WordAtPtx2328R1393, r_MmaAE4x4WordAtPtx2328R1394,
		  r_MmaAE4x4WordAtPtx2328R1395, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2239R2036,
		  r_PackedHalf2AtPtx2246R2037); // PTX L2767
	MmaE4(r_PackedHalf2AtPtx2225R1974, r_PackedHalf2AtPtx2232R2035, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx139R2067, r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx2760R1412,
		  r_MmaAccumulatorHalf2WordAtPtx2760R1413); // PTX L2774
	MmaE4(r_PackedHalf2AtPtx2239R2036, r_PackedHalf2AtPtx2246R2037, r_MmaAE4x4WordAtPtx2337R1396,
		  r_MmaAE4x4WordAtPtx2337R1397, r_MmaAE4x4WordAtPtx2337R1398, r_MmaAE4x4WordAtPtx2337R1399,
		  r_MmaBE4x4WordAtPtx139R2069, r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx2767R1414,
		  r_MmaAccumulatorHalf2WordAtPtx2767R1415);								 // PTX L2781
	r_PtxRegister34 = r_PtxRegister1420 ^ 4096;									 // PTX L2787
	r_PtxRegister35 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister30);	 // PTX L2788
	r_bPtxPredicate55 = r_bPtxPredicate1 & r_bPtxPredicate52;					 // PTX L2789
	r_bPtxPredicate56 = r_bPtxPredicate54 | r_bPtxPredicate51;					 // PTX L2790
	r_bPtxPredicate57 = r_bPtxPredicate55 | r_bPtxPredicate53;					 // PTX L2791
	r_PtxRegister1438 = r_bPtxPredicate55 ? r_PtxRegister1416 : 0;				 // PTX L2792
	r_PtxRegister36 = r_bPtxPredicate53 ? r_PtxRegister1438 : r_PtxRegister1416; // PTX L2793
	r_bPtxPredicate58 = r_bPtxPredicate57 | r_bPtxPredicate50;					 // PTX L2794
	r_bPtxPredicate12 = r_bPtxPredicate58 & r_bPtxPredicate56;					 // PTX L2795
	r_PtxU64Register265 = uint64_t(0);											 // PTX L2796
	r_bPtxPredicate59 = !r_bPtxPredicate12;										 // PTX L2797
	if (r_bPtxPredicate59)
	{
		goto L__BB39_49;
	} // PTX L2798
	r_bPtxPredicate60 = uint32_t(r_PtxRegister15) == uint32_t(4); // PTX L2799
	r_PtxRegister1439 =
		uint32_t(r_PtxRegister376) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister36); // PTX L2800
	r_PtxRegister1440 = r_bPtxPredicate60 ? r_PtxRegister36 : r_PtxRegister1439;		   // PTX L2801
	r_PtxRegister1441 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(5));				   // PTX L2802
	r_PtxRegister1442 = uint32_t(r_PtxRegister1441) + uint32_t(r_PtxRegister31);		   // PTX L2803
	r_PtxRegister1443 = ShiftLeft(uint32_t(r_PtxRegister1440), uint32_t(11));			   // PTX L2804
	r_PtxRegister1444 = ShiftLeft(uint32_t(r_PtxRegister1442), uint32_t(7));			   // PTX L2805
	r_PtxRegister1445 = uint32_t(r_PtxRegister1443) + uint32_t(r_PtxRegister1444);		   // PTX L2806
	r_PtxU64Register265 = SignExtendWordBits(r_PtxRegister1445);						   // PTX L2807
L__BB39_49:																				   // PTX L2808
	r_PtxRegister1446 = ShiftLeft(uint32_t(r_PtxRegister31), uint32_t(9));				   // PTX L2809
	r_PtxRegister1447 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));					   // PTX L2810
	r_PtxRegister1448 = r_PtxRegister1447 & 523264;										   // PTX L2811
	r_PtxRegister1449 = r_PtxRegister1446 | r_PtxRegister1448;							   // PTX L2812
	r_PtxRegister1450 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L2813
	r_PtxRegister37 = uint32_t(r_PtxRegister1450) + uint32_t(r_PtxRegister1449);		   // PTX L2814
	r_PtxRegister1451 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(3));				   // PTX L2815
	r_PtxRegister1452 = uint32_t(8192u /* exact native shared-region offset */);		   // PTX L2816
	r_PtxRegister1489 = uint32_t(r_PtxRegister1452) + uint32_t(r_PtxRegister1451);		   // PTX L2817
	if (r_bPtxPredicate59)
	{
		goto L__BB39_52;
	} // PTX L2818
	r_PtxRegister1461 = uint32_t(-1);								// PTX L2819
	r_PtxRegister1460 = Elected(r_PtxRegister1461);					// PTX L2821
	r_bPtxPredicate61 = uint32_t(r_PtxRegister1460) == uint32_t(0); // PTX L2827
	if (r_bPtxPredicate61)
	{
		goto L__BB39_53;
	} // PTX L2828
	r_PtxRegister1462 = uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister34);		   // PTX L2829
	r_PtxU64Register203 = ShiftLeft(uint64_t(r_PtxU64Register265), uint32_t(2));	   // PTX L2830
	r_PtxU64Register202 = uint64_t(r_PtxU64Register2) + uint64_t(r_PtxU64Register203); // PTX L2831
	r_PtxRegister1463 = uint32_t(512);												   // PTX L2832
	CopyBulk(s_SharedStorage, r_PtxRegister1462, r_PtxU64Register202, r_PtxRegister1463,
			 r_PtxRegister1489);																// PTX L2834
	BarrierExpect(s_SharedStorage, r_PtxRegister1489, r_PtxRegister1463);						// PTX L2837
	goto L__BB39_53;																			// PTX L2839
L__BB39_52:																						// PTX L2840
	r_PtxRegister1453 = uint32_t(0);															// PTX L2841
	r_PtxU16Register85 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1453))); // PTX L2843
	r_PackedHalf2AtPtx2846R1454 = JoinHalfwords(r_PtxU16Register85, r_PtxU16Register85);		// PTX L2846
	r_ConvertedE4PairAtPtx2848Rs86 = PublishE4(r_PackedHalf2AtPtx2846R1454);					// PTX L2848
	r_PackedE4WordAtPtx2850R1457 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2848Rs86, r_ConvertedE4PairAtPtx2848Rs86); // PTX L2850
	r_LaneIndexAtPtx2852 = uint32_t((threadIdx.x & 31u));							   // PTX L2852
	r_PtxRegister1458 = uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister34);		   // PTX L2854
	r_PtxRegister1459 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2852), uint32_t(4));		   // PTX L2855
	r_PtxRegister1456 = uint32_t(r_PtxRegister1458) + uint32_t(r_PtxRegister1459);	   // PTX L2856
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1456)) =
		make_uint4(r_PackedE4WordAtPtx2850R1457, r_PackedE4WordAtPtx2850R1457, r_PackedE4WordAtPtx2850R1457,
				   r_PackedE4WordAtPtx2850R1457);								 // PTX L2858
L__BB39_53:																		 // PTX L2860
	r_bPtxPredicate62 = int32_t(r_PtxRegister399) < int32_t(r_PtxRegister6);	 // PTX L2861
	r_bPtxPredicate63 = int32_t(r_PtxRegister399) >= int32_t(r_PtxRegister6);	 // PTX L2862
	r_bPtxPredicate64 = int32_t(r_PtxRegister1416) < int32_t(r_PtxRegister7);	 // PTX L2863
	r_bPtxPredicate65 = uint32_t(r_PtxRegister21) == uint32_t(4);				 // PTX L2864
	r_bPtxPredicate66 = uint32_t(r_PtxRegister15) == uint32_t(4);				 // PTX L2865
	r_bPtxPredicate67 = r_bPtxPredicate1 & r_bPtxPredicate63;					 // PTX L2866
	r_bPtxPredicate68 = r_bPtxPredicate66 | r_bPtxPredicate62;					 // PTX L2867
	r_bPtxPredicate69 = r_bPtxPredicate67 | r_bPtxPredicate65;					 // PTX L2868
	r_PtxRegister1464 = r_bPtxPredicate67 ? r_PtxRegister1416 : 0;				 // PTX L2869
	r_PtxRegister38 = r_bPtxPredicate65 ? r_PtxRegister1464 : r_PtxRegister1416; // PTX L2870
	r_bPtxPredicate70 = r_bPtxPredicate69 | r_bPtxPredicate64;					 // PTX L2871
	r_bPtxPredicate13 = r_bPtxPredicate70 & r_bPtxPredicate68;					 // PTX L2872
	r_PtxU64Register266 = uint64_t(0);											 // PTX L2873
	r_bPtxPredicate71 = !r_bPtxPredicate13;										 // PTX L2874
	if (r_bPtxPredicate71)
	{
		goto L__BB39_55;
	} // PTX L2875
	r_bPtxPredicate72 = uint32_t(r_PtxRegister15) == uint32_t(4); // PTX L2876
	r_PtxRegister1465 =
		uint32_t(r_PtxRegister399) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister38); // PTX L2877
	r_PtxRegister1466 = r_bPtxPredicate72 ? r_PtxRegister38 : r_PtxRegister1465;		   // PTX L2878
	r_PtxRegister1467 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(5));				   // PTX L2879
	r_PtxRegister1468 = uint32_t(r_PtxRegister1467) + uint32_t(r_PtxRegister31);		   // PTX L2880
	r_PtxRegister1469 = ShiftLeft(uint32_t(r_PtxRegister1466), uint32_t(11));			   // PTX L2881
	r_PtxRegister1470 = ShiftLeft(uint32_t(r_PtxRegister1468), uint32_t(7));			   // PTX L2882
	r_PtxRegister1471 = uint32_t(r_PtxRegister1469) + uint32_t(r_PtxRegister1470);		   // PTX L2883
	r_PtxU64Register266 = SignExtendWordBits(r_PtxRegister1471);						   // PTX L2884
L__BB39_55:																				   // PTX L2885
	r_PtxRegister1472 = r_PtxRegister1447 & 1024;										   // PTX L2886
	r_PtxRegister1473 = uint32_t(r_PtxRegister1447) + uint32_t(2048);					   // PTX L2887
	r_PtxRegister1474 = r_PtxRegister1473 & 1046528;									   // PTX L2888
	r_PtxRegister1475 = r_PtxRegister1474 | r_PtxRegister1472;							   // PTX L2889
	r_PtxRegister1476 = r_PtxRegister1446 | r_PtxRegister1475;							   // PTX L2890
	r_PtxRegister1477 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L2891
	r_PtxRegister39 = uint32_t(r_PtxRegister1477) + uint32_t(r_PtxRegister1476);		   // PTX L2892
	if (r_bPtxPredicate71)
	{
		goto L__BB39_58;
	} // PTX L2893
	r_PtxRegister1486 = uint32_t(-1);								// PTX L2894
	r_PtxRegister1485 = Elected(r_PtxRegister1486);					// PTX L2896
	r_bPtxPredicate73 = uint32_t(r_PtxRegister1485) == uint32_t(0); // PTX L2902
	if (r_bPtxPredicate73)
	{
		goto L__BB39_59;
	} // PTX L2903
	r_PtxRegister1487 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister34);		   // PTX L2904
	r_PtxU64Register205 = ShiftLeft(uint64_t(r_PtxU64Register266), uint32_t(2));	   // PTX L2905
	r_PtxU64Register204 = uint64_t(r_PtxU64Register2) + uint64_t(r_PtxU64Register205); // PTX L2906
	r_PtxRegister1488 = uint32_t(512);												   // PTX L2907
	CopyBulk(s_SharedStorage, r_PtxRegister1487, r_PtxU64Register204, r_PtxRegister1488,
			 r_PtxRegister1489);																// PTX L2909
	BarrierExpect(s_SharedStorage, r_PtxRegister1489, r_PtxRegister1488);						// PTX L2912
	goto L__BB39_59;																			// PTX L2914
L__BB39_58:																						// PTX L2915
	r_PtxRegister1478 = uint32_t(0);															// PTX L2916
	r_PtxU16Register87 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1478))); // PTX L2918
	r_PackedHalf2AtPtx2921R1479 = JoinHalfwords(r_PtxU16Register87, r_PtxU16Register87);		// PTX L2921
	r_ConvertedE4PairAtPtx2923Rs88 = PublishE4(r_PackedHalf2AtPtx2921R1479);					// PTX L2923
	r_PackedE4WordAtPtx2925R1482 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2923Rs88, r_ConvertedE4PairAtPtx2923Rs88); // PTX L2925
	r_LaneIndexAtPtx2927 = uint32_t((threadIdx.x & 31u));							   // PTX L2927
	r_PtxRegister1483 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister34);		   // PTX L2929
	r_PtxRegister1484 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2927), uint32_t(4));		   // PTX L2930
	r_PtxRegister1481 = uint32_t(r_PtxRegister1483) + uint32_t(r_PtxRegister1484);	   // PTX L2931
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1481)) =
		make_uint4(r_PackedE4WordAtPtx2925R1482, r_PackedE4WordAtPtx2925R1482, r_PackedE4WordAtPtx2925R1482,
				   r_PackedE4WordAtPtx2925R1482);											   // PTX L2933
L__BB39_59:																					   // PTX L2935
	r_PtxRegister1499 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(7));					   // PTX L2936
	r_PtxRegister1500 = uint32_t(r_PtxRegister1499) + uint32_t(r_PtxRegister369);			   // PTX L2937
	r_PtxU64Register214 = uint64_t(int64_t(int32_t(r_PtxRegister1500)) * int64_t(int32_t(4))); // PTX L2938
	r_PtxU64Register215 = uint64_t(r_Pointer32Bits) + uint64_t(r_PtxU64Register214);		   // PTX L2939
	r_LaneIndexAtPtx2941 = uint32_t((threadIdx.x & 31u));									   // PTX L2941
	r_PtxU64Register216 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2941)) * int64_t(int32_t(16)));		 // PTX L2943
	r_PtxU64Register206 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register216); // PTX L2944
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register206));
		r_MmaBE4x4WordAtPtx75R2039 = r_Value.x;
		r_MmaBE4x4WordAtPtx75R2040 = r_Value.y;
		r_MmaBE4x4WordAtPtx75R2041 = r_Value.z;
		r_MmaBE4x4WordAtPtx75R2042 = r_Value.w;
	} // PTX L2946
	r_LaneIndexAtPtx2949 = uint32_t((threadIdx.x & 31u)); // PTX L2949
	r_PtxU64Register217 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2949)) * int64_t(int32_t(16)));		 // PTX L2951
	r_PtxU64Register218 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register217); // PTX L2952
	r_PtxU64Register207 = uint64_t(r_PtxU64Register218) + uint64_t(512);				 // PTX L2953
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register207));
		r_MmaBE4x4WordAtPtx84R2043 = r_Value.x;
		r_MmaBE4x4WordAtPtx84R2044 = r_Value.y;
		r_MmaBE4x4WordAtPtx84R2045 = r_Value.z;
		r_MmaBE4x4WordAtPtx84R2046 = r_Value.w;
	} // PTX L2955
	r_LaneIndexAtPtx2958 = uint32_t((threadIdx.x & 31u)); // PTX L2958
	r_PtxU64Register219 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2958)) * int64_t(int32_t(16)));		 // PTX L2960
	r_PtxU64Register220 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register219); // PTX L2961
	r_PtxU64Register208 = uint64_t(r_PtxU64Register220) + uint64_t(1024);				 // PTX L2962
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register208));
		r_MmaBE4x4WordAtPtx94R2047 = r_Value.x;
		r_MmaBE4x4WordAtPtx94R2048 = r_Value.y;
		r_MmaBE4x4WordAtPtx94R2049 = r_Value.z;
		r_MmaBE4x4WordAtPtx94R2050 = r_Value.w;
	} // PTX L2964
	r_LaneIndexAtPtx2967 = uint32_t((threadIdx.x & 31u)); // PTX L2967
	r_PtxU64Register221 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2967)) * int64_t(int32_t(16)));		 // PTX L2969
	r_PtxU64Register222 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register221); // PTX L2970
	r_PtxU64Register209 = uint64_t(r_PtxU64Register222) + uint64_t(1536);				 // PTX L2971
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register209));
		r_MmaBE4x4WordAtPtx103R2051 = r_Value.x;
		r_MmaBE4x4WordAtPtx103R2052 = r_Value.y;
		r_MmaBE4x4WordAtPtx103R2053 = r_Value.z;
		r_MmaBE4x4WordAtPtx103R2054 = r_Value.w;
	} // PTX L2973
	r_LaneIndexAtPtx2976 = uint32_t((threadIdx.x & 31u)); // PTX L2976
	r_PtxU64Register223 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2976)) * int64_t(int32_t(16)));		 // PTX L2978
	r_PtxU64Register224 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register223); // PTX L2979
	r_PtxU64Register210 = uint64_t(r_PtxU64Register224) + uint64_t(16384);				 // PTX L2980
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register210));
		r_MmaBE4x4WordAtPtx112R2055 = r_Value.x;
		r_MmaBE4x4WordAtPtx112R2056 = r_Value.y;
		r_MmaBE4x4WordAtPtx112R2057 = r_Value.z;
		r_MmaBE4x4WordAtPtx112R2058 = r_Value.w;
	} // PTX L2982
	r_LaneIndexAtPtx2985 = uint32_t((threadIdx.x & 31u)); // PTX L2985
	r_PtxU64Register225 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2985)) * int64_t(int32_t(16)));		 // PTX L2987
	r_PtxU64Register226 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register225); // PTX L2988
	r_PtxU64Register211 = uint64_t(r_PtxU64Register226) + uint64_t(16896);				 // PTX L2989
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register211));
		r_MmaBE4x4WordAtPtx121R2059 = r_Value.x;
		r_MmaBE4x4WordAtPtx121R2060 = r_Value.y;
		r_MmaBE4x4WordAtPtx121R2061 = r_Value.z;
		r_MmaBE4x4WordAtPtx121R2062 = r_Value.w;
	} // PTX L2991
	r_LaneIndexAtPtx2994 = uint32_t((threadIdx.x & 31u)); // PTX L2994
	r_PtxU64Register227 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2994)) * int64_t(int32_t(16)));		 // PTX L2996
	r_PtxU64Register228 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register227); // PTX L2997
	r_PtxU64Register212 = uint64_t(r_PtxU64Register228) + uint64_t(17408);				 // PTX L2998
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register212));
		r_MmaBE4x4WordAtPtx130R2063 = r_Value.x;
		r_MmaBE4x4WordAtPtx130R2064 = r_Value.y;
		r_MmaBE4x4WordAtPtx130R2065 = r_Value.z;
		r_MmaBE4x4WordAtPtx130R2066 = r_Value.w;
	} // PTX L3000
	r_LaneIndexAtPtx3003 = uint32_t((threadIdx.x & 31u)); // PTX L3003
	r_PtxU64Register229 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3003)) * int64_t(int32_t(16)));		 // PTX L3005
	r_PtxU64Register230 = uint64_t(r_PtxU64Register215) + uint64_t(r_PtxU64Register229); // PTX L3006
	r_PtxU64Register213 = uint64_t(r_PtxU64Register230) + uint64_t(17920);				 // PTX L3007
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register213));
		r_MmaBE4x4WordAtPtx139R2067 = r_Value.x;
		r_MmaBE4x4WordAtPtx139R2068 = r_Value.y;
		r_MmaBE4x4WordAtPtx139R2069 = r_Value.z;
		r_MmaBE4x4WordAtPtx139R2070 = r_Value.w;
	} // PTX L3009
	r_PtxRegister1498 = uint32_t(1);															// PTX L3011
	r_PtxU64Register231 = BarrierArrive(s_SharedStorage, r_PtxRegister1489, r_PtxRegister1498); // PTX L3013
L__BB39_60:																						// PTX L3015
	r_PtxRegister1501 = BarrierReady(s_SharedStorage, r_PtxRegister1489, r_PtxU64Register231);	// PTX L3017
	r_bPtxPredicate74 = uint32_t(r_PtxRegister1501) == uint32_t(0);								// PTX L3023
	if (r_bPtxPredicate74)
	{
		goto L__BB39_60;
	} // PTX L3024
	r_bPtxPredicate75 = uint32_t(r_PtxRegister2038) < uint32_t(384); // PTX L3025
	r_PtxRegister2038 = uint32_t(r_PtxRegister32);					 // PTX L3026
	if (r_bPtxPredicate75)
	{
		goto L__BB39_47;
	} // PTX L3027
	r_bPtxPredicate76 = int32_t(r_PtxRegister5) >= int32_t(r_PtxRegister7);		   // PTX L3028
	r_LaneIndexAtPtx3030 = uint32_t((threadIdx.x & 31u));						   // PTX L3030
	r_PtxRegister1614 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3030), uint32_t(4));	   // PTX L3032
	r_PtxRegister1615 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L3033
	r_PtxRegister1616 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1614); // PTX L3034
	r_PtxRegister1503 = uint32_t(r_PtxRegister1616) + uint32_t(4096);			   // PTX L3035
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1503));
		r_MmaAE4x4WordAtPtx3037R1518 = r_Value.x;
		r_MmaAE4x4WordAtPtx3037R1519 = r_Value.y;
		r_MmaAE4x4WordAtPtx3037R1520 = r_Value.z;
		r_MmaAE4x4WordAtPtx3037R1521 = r_Value.w;
	} // PTX L3037
	r_LaneIndexAtPtx3040 = uint32_t((threadIdx.x & 31u));						   // PTX L3040
	r_PtxRegister1617 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3040), uint32_t(4));	   // PTX L3042
	r_PtxRegister1618 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1617); // PTX L3043
	r_PtxRegister1505 = uint32_t(r_PtxRegister1618) + uint32_t(4608);			   // PTX L3044
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1505));
		r_MmaAE4x4WordAtPtx3046R1522 = r_Value.x;
		r_MmaAE4x4WordAtPtx3046R1523 = r_Value.y;
		r_MmaAE4x4WordAtPtx3046R1524 = r_Value.z;
		r_MmaAE4x4WordAtPtx3046R1525 = r_Value.w;
	} // PTX L3046
	r_LaneIndexAtPtx3049 = uint32_t((threadIdx.x & 31u));						   // PTX L3049
	r_PtxRegister1619 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3049), uint32_t(4));	   // PTX L3051
	r_PtxRegister1620 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1619); // PTX L3052
	r_PtxRegister1507 = uint32_t(r_PtxRegister1620) + uint32_t(5120);			   // PTX L3053
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1507));
		r_MmaAE4x4WordAtPtx3055R1542 = r_Value.x;
		r_MmaAE4x4WordAtPtx3055R1543 = r_Value.y;
		r_MmaAE4x4WordAtPtx3055R1544 = r_Value.z;
		r_MmaAE4x4WordAtPtx3055R1545 = r_Value.w;
	} // PTX L3055
	r_LaneIndexAtPtx3058 = uint32_t((threadIdx.x & 31u));						   // PTX L3058
	r_PtxRegister1621 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3058), uint32_t(4));	   // PTX L3060
	r_PtxRegister1622 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1621); // PTX L3061
	r_PtxRegister1509 = uint32_t(r_PtxRegister1622) + uint32_t(5632);			   // PTX L3062
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1509));
		r_MmaAE4x4WordAtPtx3064R1546 = r_Value.x;
		r_MmaAE4x4WordAtPtx3064R1547 = r_Value.y;
		r_MmaAE4x4WordAtPtx3064R1548 = r_Value.z;
		r_MmaAE4x4WordAtPtx3064R1549 = r_Value.w;
	} // PTX L3064
	r_LaneIndexAtPtx3067 = uint32_t((threadIdx.x & 31u));						   // PTX L3067
	r_PtxRegister1623 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3067), uint32_t(4));	   // PTX L3069
	r_PtxRegister1624 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1623); // PTX L3070
	r_PtxRegister1511 = uint32_t(r_PtxRegister1624) + uint32_t(6144);			   // PTX L3071
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1511));
		r_MmaAE4x4WordAtPtx3073R1566 = r_Value.x;
		r_MmaAE4x4WordAtPtx3073R1567 = r_Value.y;
		r_MmaAE4x4WordAtPtx3073R1568 = r_Value.z;
		r_MmaAE4x4WordAtPtx3073R1569 = r_Value.w;
	} // PTX L3073
	r_LaneIndexAtPtx3076 = uint32_t((threadIdx.x & 31u));						   // PTX L3076
	r_PtxRegister1625 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3076), uint32_t(4));	   // PTX L3078
	r_PtxRegister1626 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1625); // PTX L3079
	r_PtxRegister1513 = uint32_t(r_PtxRegister1626) + uint32_t(6656);			   // PTX L3080
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1513));
		r_MmaAE4x4WordAtPtx3082R1570 = r_Value.x;
		r_MmaAE4x4WordAtPtx3082R1571 = r_Value.y;
		r_MmaAE4x4WordAtPtx3082R1572 = r_Value.z;
		r_MmaAE4x4WordAtPtx3082R1573 = r_Value.w;
	} // PTX L3082
	r_LaneIndexAtPtx3085 = uint32_t((threadIdx.x & 31u));						   // PTX L3085
	r_PtxRegister1627 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3085), uint32_t(4));	   // PTX L3087
	r_PtxRegister1628 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1627); // PTX L3088
	r_PtxRegister1515 = uint32_t(r_PtxRegister1628) + uint32_t(7168);			   // PTX L3089
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1515));
		r_MmaAE4x4WordAtPtx3091R1590 = r_Value.x;
		r_MmaAE4x4WordAtPtx3091R1591 = r_Value.y;
		r_MmaAE4x4WordAtPtx3091R1592 = r_Value.z;
		r_MmaAE4x4WordAtPtx3091R1593 = r_Value.w;
	} // PTX L3091
	r_LaneIndexAtPtx3094 = uint32_t((threadIdx.x & 31u));						   // PTX L3094
	r_PtxRegister1629 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3094), uint32_t(4));	   // PTX L3096
	r_PtxRegister1630 = uint32_t(r_PtxRegister1615) + uint32_t(r_PtxRegister1629); // PTX L3097
	r_PtxRegister1517 = uint32_t(r_PtxRegister1630) + uint32_t(7680);			   // PTX L3098
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1517));
		r_MmaAE4x4WordAtPtx3100R1594 = r_Value.x;
		r_MmaAE4x4WordAtPtx3100R1595 = r_Value.y;
		r_MmaAE4x4WordAtPtx3100R1596 = r_Value.z;
		r_MmaAE4x4WordAtPtx3100R1597 = r_Value.w;
	} // PTX L3100
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3103R1526, r_MmaAccumulatorHalf2WordAtPtx3103R1527,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx1805R2034,
		  r_PackedHalf2AtPtx1812R2033); // PTX L3103
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3110R1528, r_MmaAccumulatorHalf2WordAtPtx3110R1529,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx1819R2032,
		  r_PackedHalf2AtPtx1826R2031); // PTX L3110
	MmaE4(r_PtxRegister40, r_PtxRegister41, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx112R2055,
		  r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx3103R1526,
		  r_MmaAccumulatorHalf2WordAtPtx3103R1527); // PTX L3117
	MmaE4(r_PtxRegister42, r_PtxRegister43, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx112R2057,
		  r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx3110R1528,
		  r_MmaAccumulatorHalf2WordAtPtx3110R1529); // PTX L3124
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3131R1530, r_MmaAccumulatorHalf2WordAtPtx3131R1531,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx1833R2030,
		  r_PackedHalf2AtPtx1840R2029); // PTX L3131
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3138R1532, r_MmaAccumulatorHalf2WordAtPtx3138R1533,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx1847R2028,
		  r_PackedHalf2AtPtx1854R2027); // PTX L3138
	MmaE4(r_PtxRegister44, r_PtxRegister45, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx121R2059,
		  r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx3131R1530,
		  r_MmaAccumulatorHalf2WordAtPtx3131R1531); // PTX L3145
	MmaE4(r_PtxRegister46, r_PtxRegister47, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx121R2061,
		  r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx3138R1532,
		  r_MmaAccumulatorHalf2WordAtPtx3138R1533); // PTX L3152
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3159R1534, r_MmaAccumulatorHalf2WordAtPtx3159R1535,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx1861R2026,
		  r_PackedHalf2AtPtx1868R2025); // PTX L3159
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3166R1536, r_MmaAccumulatorHalf2WordAtPtx3166R1537,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx1875R2024,
		  r_PackedHalf2AtPtx1882R2023); // PTX L3166
	MmaE4(r_PtxRegister48, r_PtxRegister49, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx130R2063,
		  r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx3159R1534,
		  r_MmaAccumulatorHalf2WordAtPtx3159R1535); // PTX L3173
	MmaE4(r_PtxRegister50, r_PtxRegister51, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx130R2065,
		  r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx3166R1536,
		  r_MmaAccumulatorHalf2WordAtPtx3166R1537); // PTX L3180
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3187R1538, r_MmaAccumulatorHalf2WordAtPtx3187R1539,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx1889R2022,
		  r_PackedHalf2AtPtx1896R2021); // PTX L3187
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3194R1540, r_MmaAccumulatorHalf2WordAtPtx3194R1541,
		  r_MmaAE4x4WordAtPtx3037R1518, r_MmaAE4x4WordAtPtx3037R1519, r_MmaAE4x4WordAtPtx3037R1520,
		  r_MmaAE4x4WordAtPtx3037R1521, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx1903R2020,
		  r_PackedHalf2AtPtx1910R2019); // PTX L3194
	MmaE4(r_PtxRegister52, r_PtxRegister53, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx139R2067,
		  r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx3187R1538,
		  r_MmaAccumulatorHalf2WordAtPtx3187R1539); // PTX L3201
	MmaE4(r_PtxRegister54, r_PtxRegister55, r_MmaAE4x4WordAtPtx3046R1522, r_MmaAE4x4WordAtPtx3046R1523,
		  r_MmaAE4x4WordAtPtx3046R1524, r_MmaAE4x4WordAtPtx3046R1525, r_MmaBE4x4WordAtPtx139R2069,
		  r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx3194R1540,
		  r_MmaAccumulatorHalf2WordAtPtx3194R1541); // PTX L3208
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3215R1550, r_MmaAccumulatorHalf2WordAtPtx3215R1551,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx1917R2018,
		  r_PackedHalf2AtPtx1924R2017); // PTX L3215
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3222R1552, r_MmaAccumulatorHalf2WordAtPtx3222R1553,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx1931R2016,
		  r_PackedHalf2AtPtx1938R2015); // PTX L3222
	MmaE4(r_PtxRegister56, r_PtxRegister57, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx112R2055,
		  r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx3215R1550,
		  r_MmaAccumulatorHalf2WordAtPtx3215R1551); // PTX L3229
	MmaE4(r_PtxRegister58, r_PtxRegister59, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx112R2057,
		  r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx3222R1552,
		  r_MmaAccumulatorHalf2WordAtPtx3222R1553); // PTX L3236
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3243R1554, r_MmaAccumulatorHalf2WordAtPtx3243R1555,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx1945R2014,
		  r_PackedHalf2AtPtx1952R2013); // PTX L3243
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3250R1556, r_MmaAccumulatorHalf2WordAtPtx3250R1557,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx1959R2012,
		  r_PackedHalf2AtPtx1966R2011); // PTX L3250
	MmaE4(r_PtxRegister60, r_PtxRegister61, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx121R2059,
		  r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx3243R1554,
		  r_MmaAccumulatorHalf2WordAtPtx3243R1555); // PTX L3257
	MmaE4(r_PtxRegister62, r_PtxRegister63, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx121R2061,
		  r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx3250R1556,
		  r_MmaAccumulatorHalf2WordAtPtx3250R1557); // PTX L3264
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3271R1558, r_MmaAccumulatorHalf2WordAtPtx3271R1559,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx1973R2010,
		  r_PackedHalf2AtPtx1980R2009); // PTX L3271
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3278R1560, r_MmaAccumulatorHalf2WordAtPtx3278R1561,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx1987R2008,
		  r_PackedHalf2AtPtx1994R2007); // PTX L3278
	MmaE4(r_PtxRegister64, r_PtxRegister65, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx130R2063,
		  r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx3271R1558,
		  r_MmaAccumulatorHalf2WordAtPtx3271R1559); // PTX L3285
	MmaE4(r_PtxRegister66, r_PtxRegister67, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx130R2065,
		  r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx3278R1560,
		  r_MmaAccumulatorHalf2WordAtPtx3278R1561); // PTX L3292
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3299R1562, r_MmaAccumulatorHalf2WordAtPtx3299R1563,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2001R2006,
		  r_PackedHalf2AtPtx2008R2005); // PTX L3299
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3306R1564, r_MmaAccumulatorHalf2WordAtPtx3306R1565,
		  r_MmaAE4x4WordAtPtx3055R1542, r_MmaAE4x4WordAtPtx3055R1543, r_MmaAE4x4WordAtPtx3055R1544,
		  r_MmaAE4x4WordAtPtx3055R1545, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2015R2004,
		  r_PackedHalf2AtPtx2022R2003); // PTX L3306
	MmaE4(r_PtxRegister68, r_PtxRegister69, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx139R2067,
		  r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx3299R1562,
		  r_MmaAccumulatorHalf2WordAtPtx3299R1563); // PTX L3313
	MmaE4(r_PtxRegister70, r_PtxRegister71, r_MmaAE4x4WordAtPtx3064R1546, r_MmaAE4x4WordAtPtx3064R1547,
		  r_MmaAE4x4WordAtPtx3064R1548, r_MmaAE4x4WordAtPtx3064R1549, r_MmaBE4x4WordAtPtx139R2069,
		  r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx3306R1564,
		  r_MmaAccumulatorHalf2WordAtPtx3306R1565); // PTX L3320
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3327R1574, r_MmaAccumulatorHalf2WordAtPtx3327R1575,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx2029R2002,
		  r_PackedHalf2AtPtx2036R2001); // PTX L3327
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3334R1576, r_MmaAccumulatorHalf2WordAtPtx3334R1577,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx2043R2000,
		  r_PackedHalf2AtPtx2050R1999); // PTX L3334
	MmaE4(r_PtxRegister72, r_PtxRegister73, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx112R2055,
		  r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx3327R1574,
		  r_MmaAccumulatorHalf2WordAtPtx3327R1575); // PTX L3341
	MmaE4(r_PtxRegister74, r_PtxRegister75, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx112R2057,
		  r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx3334R1576,
		  r_MmaAccumulatorHalf2WordAtPtx3334R1577); // PTX L3348
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3355R1578, r_MmaAccumulatorHalf2WordAtPtx3355R1579,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx2057R1998,
		  r_PackedHalf2AtPtx2064R1997); // PTX L3355
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3362R1580, r_MmaAccumulatorHalf2WordAtPtx3362R1581,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx2071R1996,
		  r_PackedHalf2AtPtx2078R1995); // PTX L3362
	MmaE4(r_PtxRegister76, r_PtxRegister77, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx121R2059,
		  r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx3355R1578,
		  r_MmaAccumulatorHalf2WordAtPtx3355R1579); // PTX L3369
	MmaE4(r_PtxRegister78, r_PtxRegister79, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx121R2061,
		  r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx3362R1580,
		  r_MmaAccumulatorHalf2WordAtPtx3362R1581); // PTX L3376
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3383R1582, r_MmaAccumulatorHalf2WordAtPtx3383R1583,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx2085R1994,
		  r_PackedHalf2AtPtx2092R1993); // PTX L3383
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3390R1584, r_MmaAccumulatorHalf2WordAtPtx3390R1585,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx2099R1992,
		  r_PackedHalf2AtPtx2106R1991); // PTX L3390
	MmaE4(r_PtxRegister80, r_PtxRegister81, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx130R2063,
		  r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx3383R1582,
		  r_MmaAccumulatorHalf2WordAtPtx3383R1583); // PTX L3397
	MmaE4(r_PtxRegister82, r_PtxRegister83, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx130R2065,
		  r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx3390R1584,
		  r_MmaAccumulatorHalf2WordAtPtx3390R1585); // PTX L3404
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3411R1586, r_MmaAccumulatorHalf2WordAtPtx3411R1587,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2113R1990,
		  r_PackedHalf2AtPtx2120R1989); // PTX L3411
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3418R1588, r_MmaAccumulatorHalf2WordAtPtx3418R1589,
		  r_MmaAE4x4WordAtPtx3073R1566, r_MmaAE4x4WordAtPtx3073R1567, r_MmaAE4x4WordAtPtx3073R1568,
		  r_MmaAE4x4WordAtPtx3073R1569, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2127R1988,
		  r_PackedHalf2AtPtx2134R1987); // PTX L3418
	MmaE4(r_PtxRegister84, r_PtxRegister85, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx139R2067,
		  r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx3411R1586,
		  r_MmaAccumulatorHalf2WordAtPtx3411R1587); // PTX L3425
	MmaE4(r_PtxRegister86, r_PtxRegister87, r_MmaAE4x4WordAtPtx3082R1570, r_MmaAE4x4WordAtPtx3082R1571,
		  r_MmaAE4x4WordAtPtx3082R1572, r_MmaAE4x4WordAtPtx3082R1573, r_MmaBE4x4WordAtPtx139R2069,
		  r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx3418R1588,
		  r_MmaAccumulatorHalf2WordAtPtx3418R1589); // PTX L3432
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3439R1598, r_MmaAccumulatorHalf2WordAtPtx3439R1599,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx75R2039, r_MmaBE4x4WordAtPtx75R2040,
		  r_PackedHalf2AtPtx2141R1986,
		  r_PackedHalf2AtPtx2148R1985); // PTX L3439
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3446R1600, r_MmaAccumulatorHalf2WordAtPtx3446R1601,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx75R2041, r_MmaBE4x4WordAtPtx75R2042,
		  r_PackedHalf2AtPtx2155R1984,
		  r_PackedHalf2AtPtx2162R1983); // PTX L3446
	MmaE4(r_PtxRegister88, r_PtxRegister89, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx112R2055,
		  r_MmaBE4x4WordAtPtx112R2056, r_MmaAccumulatorHalf2WordAtPtx3439R1598,
		  r_MmaAccumulatorHalf2WordAtPtx3439R1599); // PTX L3453
	MmaE4(r_PtxRegister90, r_PtxRegister91, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx112R2057,
		  r_MmaBE4x4WordAtPtx112R2058, r_MmaAccumulatorHalf2WordAtPtx3446R1600,
		  r_MmaAccumulatorHalf2WordAtPtx3446R1601); // PTX L3460
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3467R1602, r_MmaAccumulatorHalf2WordAtPtx3467R1603,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx84R2043, r_MmaBE4x4WordAtPtx84R2044,
		  r_PackedHalf2AtPtx2169R1982,
		  r_PackedHalf2AtPtx2176R1981); // PTX L3467
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3474R1604, r_MmaAccumulatorHalf2WordAtPtx3474R1605,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx84R2045, r_MmaBE4x4WordAtPtx84R2046,
		  r_PackedHalf2AtPtx2183R1980,
		  r_PackedHalf2AtPtx2190R1979); // PTX L3474
	MmaE4(r_PtxRegister92, r_PtxRegister93, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx121R2059,
		  r_MmaBE4x4WordAtPtx121R2060, r_MmaAccumulatorHalf2WordAtPtx3467R1602,
		  r_MmaAccumulatorHalf2WordAtPtx3467R1603); // PTX L3481
	MmaE4(r_PtxRegister94, r_PtxRegister95, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx121R2061,
		  r_MmaBE4x4WordAtPtx121R2062, r_MmaAccumulatorHalf2WordAtPtx3474R1604,
		  r_MmaAccumulatorHalf2WordAtPtx3474R1605); // PTX L3488
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3495R1606, r_MmaAccumulatorHalf2WordAtPtx3495R1607,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx94R2047, r_MmaBE4x4WordAtPtx94R2048,
		  r_PackedHalf2AtPtx2197R1978,
		  r_PackedHalf2AtPtx2204R1977); // PTX L3495
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3502R1608, r_MmaAccumulatorHalf2WordAtPtx3502R1609,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx94R2049, r_MmaBE4x4WordAtPtx94R2050,
		  r_PackedHalf2AtPtx2211R1976,
		  r_PackedHalf2AtPtx2218R1975); // PTX L3502
	MmaE4(r_PtxRegister96, r_PtxRegister97, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx130R2063,
		  r_MmaBE4x4WordAtPtx130R2064, r_MmaAccumulatorHalf2WordAtPtx3495R1606,
		  r_MmaAccumulatorHalf2WordAtPtx3495R1607); // PTX L3509
	MmaE4(r_PtxRegister98, r_PtxRegister99, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx130R2065,
		  r_MmaBE4x4WordAtPtx130R2066, r_MmaAccumulatorHalf2WordAtPtx3502R1608,
		  r_MmaAccumulatorHalf2WordAtPtx3502R1609); // PTX L3516
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3523R1610, r_MmaAccumulatorHalf2WordAtPtx3523R1611,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx103R2051, r_MmaBE4x4WordAtPtx103R2052,
		  r_PackedHalf2AtPtx2225R1974,
		  r_PackedHalf2AtPtx2232R2035); // PTX L3523
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3530R1612, r_MmaAccumulatorHalf2WordAtPtx3530R1613,
		  r_MmaAE4x4WordAtPtx3091R1590, r_MmaAE4x4WordAtPtx3091R1591, r_MmaAE4x4WordAtPtx3091R1592,
		  r_MmaAE4x4WordAtPtx3091R1593, r_MmaBE4x4WordAtPtx103R2053, r_MmaBE4x4WordAtPtx103R2054,
		  r_PackedHalf2AtPtx2239R2036,
		  r_PackedHalf2AtPtx2246R2037); // PTX L3530
	MmaE4(r_PtxRegister100, r_PtxRegister101, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx139R2067,
		  r_MmaBE4x4WordAtPtx139R2068, r_MmaAccumulatorHalf2WordAtPtx3523R1610,
		  r_MmaAccumulatorHalf2WordAtPtx3523R1611); // PTX L3537
	MmaE4(r_PtxRegister102, r_PtxRegister103, r_MmaAE4x4WordAtPtx3100R1594, r_MmaAE4x4WordAtPtx3100R1595,
		  r_MmaAE4x4WordAtPtx3100R1596, r_MmaAE4x4WordAtPtx3100R1597, r_MmaBE4x4WordAtPtx139R2069,
		  r_MmaBE4x4WordAtPtx139R2070, r_MmaAccumulatorHalf2WordAtPtx3530R1612,
		  r_MmaAccumulatorHalf2WordAtPtx3530R1613);							// PTX L3544
	r_ConvertedE4PairAtPtx3551Rs89 = PublishE4(r_PtxRegister40);			// PTX L3551
	r_ConvertedE4PairAtPtx3554Rs90 = PublishE4(r_PtxRegister42);			// PTX L3554
	r_ConvertedE4PairAtPtx3557Rs91 = PublishE4(r_PtxRegister41);			// PTX L3557
	r_ConvertedE4PairAtPtx3560Rs92 = PublishE4(r_PtxRegister43);			// PTX L3560
	r_ConvertedE4PairAtPtx3563Rs93 = PublishE4(r_PtxRegister44);			// PTX L3563
	r_ConvertedE4PairAtPtx3566Rs94 = PublishE4(r_PtxRegister46);			// PTX L3566
	r_ConvertedE4PairAtPtx3569Rs95 = PublishE4(r_PtxRegister45);			// PTX L3569
	r_ConvertedE4PairAtPtx3572Rs96 = PublishE4(r_PtxRegister47);			// PTX L3572
	r_ConvertedE4PairAtPtx3575Rs97 = PublishE4(r_PtxRegister48);			// PTX L3575
	r_ConvertedE4PairAtPtx3578Rs98 = PublishE4(r_PtxRegister50);			// PTX L3578
	r_ConvertedE4PairAtPtx3581Rs99 = PublishE4(r_PtxRegister49);			// PTX L3581
	r_ConvertedE4PairAtPtx3584Rs100 = PublishE4(r_PtxRegister51);			// PTX L3584
	r_ConvertedE4PairAtPtx3587Rs101 = PublishE4(r_PtxRegister52);			// PTX L3587
	r_ConvertedE4PairAtPtx3590Rs102 = PublishE4(r_PtxRegister54);			// PTX L3590
	r_ConvertedE4PairAtPtx3593Rs103 = PublishE4(r_PtxRegister53);			// PTX L3593
	r_ConvertedE4PairAtPtx3596Rs104 = PublishE4(r_PtxRegister55);			// PTX L3596
	r_ConvertedE4PairAtPtx3599Rs105 = PublishE4(r_PtxRegister56);			// PTX L3599
	r_ConvertedE4PairAtPtx3602Rs106 = PublishE4(r_PtxRegister58);			// PTX L3602
	r_ConvertedE4PairAtPtx3605Rs107 = PublishE4(r_PtxRegister57);			// PTX L3605
	r_ConvertedE4PairAtPtx3608Rs108 = PublishE4(r_PtxRegister59);			// PTX L3608
	r_ConvertedE4PairAtPtx3611Rs109 = PublishE4(r_PtxRegister60);			// PTX L3611
	r_ConvertedE4PairAtPtx3614Rs110 = PublishE4(r_PtxRegister62);			// PTX L3614
	r_ConvertedE4PairAtPtx3617Rs111 = PublishE4(r_PtxRegister61);			// PTX L3617
	r_ConvertedE4PairAtPtx3620Rs112 = PublishE4(r_PtxRegister63);			// PTX L3620
	r_ConvertedE4PairAtPtx3623Rs113 = PublishE4(r_PtxRegister64);			// PTX L3623
	r_ConvertedE4PairAtPtx3626Rs114 = PublishE4(r_PtxRegister66);			// PTX L3626
	r_ConvertedE4PairAtPtx3629Rs115 = PublishE4(r_PtxRegister65);			// PTX L3629
	r_ConvertedE4PairAtPtx3632Rs116 = PublishE4(r_PtxRegister67);			// PTX L3632
	r_ConvertedE4PairAtPtx3635Rs117 = PublishE4(r_PtxRegister68);			// PTX L3635
	r_ConvertedE4PairAtPtx3638Rs118 = PublishE4(r_PtxRegister70);			// PTX L3638
	r_ConvertedE4PairAtPtx3641Rs119 = PublishE4(r_PtxRegister69);			// PTX L3641
	r_ConvertedE4PairAtPtx3644Rs120 = PublishE4(r_PtxRegister71);			// PTX L3644
	r_ConvertedE4PairAtPtx3647Rs121 = PublishE4(r_PtxRegister72);			// PTX L3647
	r_ConvertedE4PairAtPtx3650Rs122 = PublishE4(r_PtxRegister74);			// PTX L3650
	r_ConvertedE4PairAtPtx3653Rs123 = PublishE4(r_PtxRegister73);			// PTX L3653
	r_ConvertedE4PairAtPtx3656Rs124 = PublishE4(r_PtxRegister75);			// PTX L3656
	r_ConvertedE4PairAtPtx3659Rs125 = PublishE4(r_PtxRegister76);			// PTX L3659
	r_ConvertedE4PairAtPtx3662Rs126 = PublishE4(r_PtxRegister78);			// PTX L3662
	r_ConvertedE4PairAtPtx3665Rs127 = PublishE4(r_PtxRegister77);			// PTX L3665
	r_ConvertedE4PairAtPtx3668Rs128 = PublishE4(r_PtxRegister79);			// PTX L3668
	r_ConvertedE4PairAtPtx3671Rs129 = PublishE4(r_PtxRegister80);			// PTX L3671
	r_ConvertedE4PairAtPtx3674Rs130 = PublishE4(r_PtxRegister82);			// PTX L3674
	r_ConvertedE4PairAtPtx3677Rs131 = PublishE4(r_PtxRegister81);			// PTX L3677
	r_ConvertedE4PairAtPtx3680Rs132 = PublishE4(r_PtxRegister83);			// PTX L3680
	r_ConvertedE4PairAtPtx3683Rs133 = PublishE4(r_PtxRegister84);			// PTX L3683
	r_ConvertedE4PairAtPtx3686Rs134 = PublishE4(r_PtxRegister86);			// PTX L3686
	r_ConvertedE4PairAtPtx3689Rs135 = PublishE4(r_PtxRegister85);			// PTX L3689
	r_ConvertedE4PairAtPtx3692Rs136 = PublishE4(r_PtxRegister87);			// PTX L3692
	r_ConvertedE4PairAtPtx3695Rs137 = PublishE4(r_PtxRegister88);			// PTX L3695
	r_ConvertedE4PairAtPtx3698Rs138 = PublishE4(r_PtxRegister90);			// PTX L3698
	r_ConvertedE4PairAtPtx3701Rs139 = PublishE4(r_PtxRegister89);			// PTX L3701
	r_ConvertedE4PairAtPtx3704Rs140 = PublishE4(r_PtxRegister91);			// PTX L3704
	r_ConvertedE4PairAtPtx3707Rs141 = PublishE4(r_PtxRegister92);			// PTX L3707
	r_ConvertedE4PairAtPtx3710Rs142 = PublishE4(r_PtxRegister94);			// PTX L3710
	r_ConvertedE4PairAtPtx3713Rs143 = PublishE4(r_PtxRegister93);			// PTX L3713
	r_ConvertedE4PairAtPtx3716Rs144 = PublishE4(r_PtxRegister95);			// PTX L3716
	r_ConvertedE4PairAtPtx3719Rs145 = PublishE4(r_PtxRegister96);			// PTX L3719
	r_ConvertedE4PairAtPtx3722Rs146 = PublishE4(r_PtxRegister98);			// PTX L3722
	r_ConvertedE4PairAtPtx3725Rs147 = PublishE4(r_PtxRegister97);			// PTX L3725
	r_ConvertedE4PairAtPtx3728Rs148 = PublishE4(r_PtxRegister99);			// PTX L3728
	r_ConvertedE4PairAtPtx3731Rs149 = PublishE4(r_PtxRegister100);			// PTX L3731
	r_ConvertedE4PairAtPtx3734Rs150 = PublishE4(r_PtxRegister102);			// PTX L3734
	r_ConvertedE4PairAtPtx3737Rs151 = PublishE4(r_PtxRegister101);			// PTX L3737
	r_ConvertedE4PairAtPtx3740Rs152 = PublishE4(r_PtxRegister103);			// PTX L3740
	r_bPtxPredicate77 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6); // PTX L3742
	r_PtxRegister1631 =
		uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister5);		   // PTX L3743
	r_PtxRegister104 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));					   // PTX L3744
	r_PtxRegister1632 = ShiftLeft(uint32_t(r_PtxRegister1631), uint32_t(11));				   // PTX L3745
	r_PtxRegister1633 = uint32_t(r_PtxRegister1632) + uint32_t(r_PtxRegister104);			   // PTX L3746
	r_PtxU64Register232 = uint64_t(int64_t(int32_t(r_PtxRegister1633)) * int64_t(int32_t(4))); // PTX L3747
	r_PtxU64Register3 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register232);			   // PTX L3748
	r_bPtxPredicate78 = r_bPtxPredicate77 | r_bPtxPredicate76;								   // PTX L3749
	if (r_bPtxPredicate78)
	{
		goto L__BB39_64;
	} // PTX L3750
	r_PackedE4WordAtPtx3751R1643 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3593Rs103, r_ConvertedE4PairAtPtx3596Rs104); // PTX L3751
	r_PackedE4WordAtPtx3752R1642 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3587Rs101, r_ConvertedE4PairAtPtx3590Rs102); // PTX L3752
	r_PackedE4WordAtPtx3753R1641 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3581Rs99, r_ConvertedE4PairAtPtx3584Rs100); // PTX L3753
	r_PackedE4WordAtPtx3754R1640 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3575Rs97, r_ConvertedE4PairAtPtx3578Rs98); // PTX L3754
	r_PackedE4WordAtPtx3755R1638 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3569Rs95, r_ConvertedE4PairAtPtx3572Rs96); // PTX L3755
	r_PackedE4WordAtPtx3756R1637 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3563Rs93, r_ConvertedE4PairAtPtx3566Rs94); // PTX L3756
	r_PackedE4WordAtPtx3757R1636 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3557Rs91, r_ConvertedE4PairAtPtx3560Rs92); // PTX L3757
	r_PackedE4WordAtPtx3758R1635 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3551Rs89, r_ConvertedE4PairAtPtx3554Rs90); // PTX L3758
	r_LaneIndexAtPtx3760 = uint32_t((threadIdx.x & 31u));							   // PTX L3760
	r_PtxU64Register235 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3760)) * int64_t(int32_t(16)));	   // PTX L3762
	r_PtxU64Register233 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register235); // PTX L3763
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(r_PtxU64Register233,
					make_uint4(r_PackedE4WordAtPtx3758R1635, r_PackedE4WordAtPtx3757R1636,
							   r_PackedE4WordAtPtx3756R1637,
							   r_PackedE4WordAtPtx3755R1638)); // PTX L3765
	r_LaneIndexAtPtx3768 = uint32_t((threadIdx.x & 31u));	   // PTX L3768
	r_PtxU64Register236 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3768)) * int64_t(int32_t(16)));	   // PTX L3770
	r_PtxU64Register237 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register236); // PTX L3771
	r_PtxU64Register234 = uint64_t(r_PtxU64Register237) + uint64_t(512);			   // PTX L3772
	StoreNoAllocate(r_PtxU64Register234,
					make_uint4(r_PackedE4WordAtPtx3754R1640, r_PackedE4WordAtPtx3753R1641,
							   r_PackedE4WordAtPtx3752R1642,
							   r_PackedE4WordAtPtx3751R1643));				  // PTX L3774
L__BB39_64:																	  // PTX L3776
	r_bPtxPredicate79 = int32_t(r_PtxRegister4) >= int32_t(r_PtxRegister6);	  // PTX L3777
	r_PtxRegister105 = r_PtxRegister5 | 1;									  // PTX L3778
	r_bPtxPredicate80 = int32_t(r_PtxRegister105) >= int32_t(r_PtxRegister7); // PTX L3779
	r_bPtxPredicate81 = r_bPtxPredicate79 | r_bPtxPredicate80;				  // PTX L3780
	if (r_bPtxPredicate81)
	{
		goto L__BB39_66;
	} // PTX L3781
	r_LaneIndexAtPtx3783 = uint32_t((threadIdx.x & 31u)); // PTX L3783
	r_PtxU64Register240 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3783)) * int64_t(int32_t(16)));	   // PTX L3785
	r_PtxU64Register241 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register240); // PTX L3786
	r_PtxU64Register238 = uint64_t(r_PtxU64Register241) + uint64_t(8192);			   // PTX L3787
	r_PackedE4WordAtPtx3788R1648 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3617Rs111, r_ConvertedE4PairAtPtx3620Rs112); // PTX L3788
	r_PackedE4WordAtPtx3789R1647 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3611Rs109, r_ConvertedE4PairAtPtx3614Rs110); // PTX L3789
	r_PackedE4WordAtPtx3790R1646 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3605Rs107, r_ConvertedE4PairAtPtx3608Rs108); // PTX L3790
	r_PackedE4WordAtPtx3791R1645 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3599Rs105, r_ConvertedE4PairAtPtx3602Rs106); // PTX L3791
	StoreNoAllocate(r_PtxU64Register238,
					make_uint4(r_PackedE4WordAtPtx3791R1645, r_PackedE4WordAtPtx3790R1646,
							   r_PackedE4WordAtPtx3789R1647,
							   r_PackedE4WordAtPtx3788R1648)); // PTX L3793
	r_LaneIndexAtPtx3796 = uint32_t((threadIdx.x & 31u));	   // PTX L3796
	r_PtxU64Register242 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3796)) * int64_t(int32_t(16)));	   // PTX L3798
	r_PtxU64Register243 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register242); // PTX L3799
	r_PtxU64Register239 = uint64_t(r_PtxU64Register243) + uint64_t(8704);			   // PTX L3800
	r_PackedE4WordAtPtx3801R1653 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3641Rs119, r_ConvertedE4PairAtPtx3644Rs120); // PTX L3801
	r_PackedE4WordAtPtx3802R1652 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3635Rs117, r_ConvertedE4PairAtPtx3638Rs118); // PTX L3802
	r_PackedE4WordAtPtx3803R1651 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3629Rs115, r_ConvertedE4PairAtPtx3632Rs116); // PTX L3803
	r_PackedE4WordAtPtx3804R1650 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3623Rs113, r_ConvertedE4PairAtPtx3626Rs114); // PTX L3804
	StoreNoAllocate(r_PtxU64Register239,
					make_uint4(r_PackedE4WordAtPtx3804R1650, r_PackedE4WordAtPtx3803R1651,
							   r_PackedE4WordAtPtx3802R1652,
							   r_PackedE4WordAtPtx3801R1653));				  // PTX L3806
L__BB39_66:																	  // PTX L3808
	r_bPtxPredicate82 = int32_t(r_PtxRegister5) >= int32_t(r_PtxRegister7);	  // PTX L3809
	r_PtxRegister106 = r_PtxRegister4 | 1;									  // PTX L3810
	r_bPtxPredicate83 = int32_t(r_PtxRegister106) >= int32_t(r_PtxRegister6); // PTX L3811
	r_PtxRegister1654 =
		uint32_t(r_PtxRegister4) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister7);		   // PTX L3812
	r_PtxRegister1655 = uint32_t(r_PtxRegister1654) + uint32_t(r_PtxRegister5);				   // PTX L3813
	r_PtxRegister1656 = ShiftLeft(uint32_t(r_PtxRegister1655), uint32_t(11));				   // PTX L3814
	r_PtxRegister1657 = uint32_t(r_PtxRegister1656) + uint32_t(r_PtxRegister104);			   // PTX L3815
	r_PtxU64Register244 = uint64_t(int64_t(int32_t(r_PtxRegister1657)) * int64_t(int32_t(4))); // PTX L3816
	r_PtxU64Register4 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register244);			   // PTX L3817
	r_bPtxPredicate84 = r_bPtxPredicate83 | r_bPtxPredicate82;								   // PTX L3818
	if (r_bPtxPredicate84)
	{
		goto L__BB39_68;
	} // PTX L3819
	r_LaneIndexAtPtx3821 = uint32_t((threadIdx.x & 31u)); // PTX L3821
	r_PtxU64Register247 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3821)) * int64_t(int32_t(16)));	   // PTX L3823
	r_PtxU64Register245 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register247); // PTX L3824
	r_PackedE4WordAtPtx3825R1662 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3665Rs127, r_ConvertedE4PairAtPtx3668Rs128); // PTX L3825
	r_PackedE4WordAtPtx3826R1661 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3659Rs125, r_ConvertedE4PairAtPtx3662Rs126); // PTX L3826
	r_PackedE4WordAtPtx3827R1660 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3653Rs123, r_ConvertedE4PairAtPtx3656Rs124); // PTX L3827
	r_PackedE4WordAtPtx3828R1659 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3647Rs121, r_ConvertedE4PairAtPtx3650Rs122); // PTX L3828
	StoreNoAllocate(r_PtxU64Register245,
					make_uint4(r_PackedE4WordAtPtx3828R1659, r_PackedE4WordAtPtx3827R1660,
							   r_PackedE4WordAtPtx3826R1661,
							   r_PackedE4WordAtPtx3825R1662)); // PTX L3830
	r_LaneIndexAtPtx3833 = uint32_t((threadIdx.x & 31u));	   // PTX L3833
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3833)) * int64_t(int32_t(16)));	   // PTX L3835
	r_PtxU64Register249 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register248); // PTX L3836
	r_PtxU64Register246 = uint64_t(r_PtxU64Register249) + uint64_t(512);			   // PTX L3837
	r_PackedE4WordAtPtx3838R1667 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3689Rs135, r_ConvertedE4PairAtPtx3692Rs136); // PTX L3838
	r_PackedE4WordAtPtx3839R1666 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3683Rs133, r_ConvertedE4PairAtPtx3686Rs134); // PTX L3839
	r_PackedE4WordAtPtx3840R1665 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3677Rs131, r_ConvertedE4PairAtPtx3680Rs132); // PTX L3840
	r_PackedE4WordAtPtx3841R1664 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3671Rs129, r_ConvertedE4PairAtPtx3674Rs130); // PTX L3841
	StoreNoAllocate(r_PtxU64Register246,
					make_uint4(r_PackedE4WordAtPtx3841R1664, r_PackedE4WordAtPtx3840R1665,
							   r_PackedE4WordAtPtx3839R1666,
							   r_PackedE4WordAtPtx3838R1667));				  // PTX L3843
L__BB39_68:																	  // PTX L3845
	r_bPtxPredicate85 = int32_t(r_PtxRegister106) >= int32_t(r_PtxRegister6); // PTX L3846
	r_bPtxPredicate86 = int32_t(r_PtxRegister105) >= int32_t(r_PtxRegister7); // PTX L3847
	r_bPtxPredicate87 = r_bPtxPredicate85 | r_bPtxPredicate86;				  // PTX L3848
	if (r_bPtxPredicate87)
	{
		goto L__BB39_70;
	} // PTX L3849
	r_LaneIndexAtPtx3851 = uint32_t((threadIdx.x & 31u)); // PTX L3851
	r_PtxU64Register252 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3851)) * int64_t(int32_t(16)));	   // PTX L3853
	r_PtxU64Register253 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register252); // PTX L3854
	r_PtxU64Register250 = uint64_t(r_PtxU64Register253) + uint64_t(8192);			   // PTX L3855
	r_PackedE4WordAtPtx3856R1672 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3713Rs143, r_ConvertedE4PairAtPtx3716Rs144); // PTX L3856
	r_PackedE4WordAtPtx3857R1671 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3707Rs141, r_ConvertedE4PairAtPtx3710Rs142); // PTX L3857
	r_PackedE4WordAtPtx3858R1670 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3701Rs139, r_ConvertedE4PairAtPtx3704Rs140); // PTX L3858
	r_PackedE4WordAtPtx3859R1669 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3695Rs137, r_ConvertedE4PairAtPtx3698Rs138); // PTX L3859
	StoreNoAllocate(r_PtxU64Register250,
					make_uint4(r_PackedE4WordAtPtx3859R1669, r_PackedE4WordAtPtx3858R1670,
							   r_PackedE4WordAtPtx3857R1671,
							   r_PackedE4WordAtPtx3856R1672)); // PTX L3861
	r_LaneIndexAtPtx3864 = uint32_t((threadIdx.x & 31u));	   // PTX L3864
	r_PtxU64Register254 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3864)) * int64_t(int32_t(16)));	   // PTX L3866
	r_PtxU64Register255 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register254); // PTX L3867
	r_PtxU64Register251 = uint64_t(r_PtxU64Register255) + uint64_t(8704);			   // PTX L3868
	r_PackedE4WordAtPtx3869R1677 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3737Rs151, r_ConvertedE4PairAtPtx3740Rs152); // PTX L3869
	r_PackedE4WordAtPtx3870R1676 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3731Rs149, r_ConvertedE4PairAtPtx3734Rs150); // PTX L3870
	r_PackedE4WordAtPtx3871R1675 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3725Rs147, r_ConvertedE4PairAtPtx3728Rs148); // PTX L3871
	r_PackedE4WordAtPtx3872R1674 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3719Rs145, r_ConvertedE4PairAtPtx3722Rs146); // PTX L3872
	StoreNoAllocate(r_PtxU64Register251,
					make_uint4(r_PackedE4WordAtPtx3872R1674, r_PackedE4WordAtPtx3871R1675,
							   r_PackedE4WordAtPtx3870R1676,
							   r_PackedE4WordAtPtx3869R1677));					  // PTX L3874
L__BB39_70:																		  // PTX L3876
	r_PtxRegister1679 = ShiftRightSigned(int32_t(r_Scalar76Bits), uint32_t(31));  // PTX L3877
	r_PtxRegister1680 = ShiftRight(uint32_t(r_PtxRegister1679), uint32_t(30));	  // PTX L3878
	r_PtxRegister1681 = uint32_t(r_Scalar76Bits) + uint32_t(r_PtxRegister1680);	  // PTX L3879
	r_PtxRegister107 = ShiftRightSigned(int32_t(r_PtxRegister1681), uint32_t(2)); // PTX L3880
	r_LaneIndexAtPtx3882 = uint32_t((threadIdx.x & 31u));						  // PTX L3882
	r_PtxRegister1682 = ShiftRight(uint32_t(r_LaneIndexAtPtx3882), uint32_t(2));  // PTX L3884
	r_PtxRegister1683 = r_PtxRegister1682 & 2;									  // PTX L3885
	r_PtxRegister1684 = ShiftRight(uint32_t(r_LaneIndexAtPtx3882), uint32_t(4));  // PTX L3886
	r_PtxRegister1685 = r_PtxRegister1684 & 1;									  // PTX L3887
	r_PtxRegister108 = r_PtxRegister1683 | r_PtxRegister1685;					  // PTX L3888
	r_PtxRegister1686 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3882), uint32_t(1));	  // PTX L3889
	r_PtxRegister1687 = r_PtxRegister1686 & 8;									  // PTX L3890
	r_PtxRegister1688 = r_LaneIndexAtPtx3882 & 3;								  // PTX L3891
	r_PtxRegister109 = r_PtxRegister1687 | r_PtxRegister1688;					  // PTX L3892
	r_PtxRegister2071 =
		ShuffleIdxPredicate(r_bPtxPredicate88, r_PtxRegister40, r_PtxRegister109, 31, -1); // PTX L3893
	r_PtxRegister110 =
		ShuffleIdxPredicate(r_bPtxPredicate89, r_PtxRegister41, r_PtxRegister109, 31, -1); // PTX L3894
	r_PtxRegister111 =
		ShuffleIdxPredicate(r_bPtxPredicate90, r_PtxRegister56, r_PtxRegister109, 31, -1); // PTX L3895
	r_PtxRegister112 =
		ShuffleIdxPredicate(r_bPtxPredicate91, r_PtxRegister57, r_PtxRegister109, 31, -1); // PTX L3896
	r_bPtxPredicate92 = uint32_t(r_PtxRegister108) == uint32_t(0);						   // PTX L3897
	if (r_bPtxPredicate92)
	{
		goto L__BB39_73;
	} // PTX L3898
	r_bPtxPredicate93 = uint32_t(r_PtxRegister108) == uint32_t(1); // PTX L3899
	r_PtxRegister2071 = uint32_t(r_PtxRegister110);				   // PTX L3900
	if (r_bPtxPredicate93)
	{
		goto L__BB39_73;
	} // PTX L3901
	r_bPtxPredicate94 = uint32_t(r_PtxRegister108) == uint32_t(2);				 // PTX L3902
	r_PtxRegister2071 = r_bPtxPredicate94 ? r_PtxRegister111 : r_PtxRegister112; // PTX L3903
L__BB39_73:																		 // PTX L3904
	r_bPtxPredicate95 = uint32_t(r_PtxRegister108) == uint32_t(0);				 // PTX L3905
	r_PtxRegister1689 = r_PtxRegister109 | 4;									 // PTX L3906
	r_PtxRegister2072 =
		ShuffleIdxPredicate(r_bPtxPredicate96, r_PtxRegister40, r_PtxRegister1689, 31, -1); // PTX L3907
	r_PtxRegister113 =
		ShuffleIdxPredicate(r_bPtxPredicate97, r_PtxRegister41, r_PtxRegister1689, 31, -1); // PTX L3908
	r_PtxRegister114 =
		ShuffleIdxPredicate(r_bPtxPredicate98, r_PtxRegister56, r_PtxRegister1689, 31, -1); // PTX L3909
	r_PtxRegister115 =
		ShuffleIdxPredicate(r_bPtxPredicate99, r_PtxRegister57, r_PtxRegister1689, 31, -1); // PTX L3910
	if (r_bPtxPredicate95)
	{
		goto L__BB39_76;
	} // PTX L3911
	r_bPtxPredicate100 = uint32_t(r_PtxRegister108) == uint32_t(1); // PTX L3912
	r_PtxRegister2072 = uint32_t(r_PtxRegister113);					// PTX L3913
	if (r_bPtxPredicate100)
	{
		goto L__BB39_76;
	} // PTX L3914
	r_bPtxPredicate101 = uint32_t(r_PtxRegister108) == uint32_t(2);				  // PTX L3915
	r_PtxRegister2072 = r_bPtxPredicate101 ? r_PtxRegister114 : r_PtxRegister115; // PTX L3916
L__BB39_76:																		  // PTX L3917
	r_bPtxPredicate102 = uint32_t(r_PtxRegister108) == uint32_t(0);				  // PTX L3918
	r_PtxRegister1690 = r_PtxRegister109 | 16;									  // PTX L3919
	r_PtxRegister2073 =
		ShuffleIdxPredicate(r_bPtxPredicate103, r_PtxRegister40, r_PtxRegister1690, 31, -1); // PTX L3920
	r_PtxRegister116 =
		ShuffleIdxPredicate(r_bPtxPredicate104, r_PtxRegister41, r_PtxRegister1690, 31, -1); // PTX L3921
	r_PtxRegister117 =
		ShuffleIdxPredicate(r_bPtxPredicate105, r_PtxRegister56, r_PtxRegister1690, 31, -1); // PTX L3922
	r_PtxRegister118 =
		ShuffleIdxPredicate(r_bPtxPredicate106, r_PtxRegister57, r_PtxRegister1690, 31, -1); // PTX L3923
	if (r_bPtxPredicate102)
	{
		goto L__BB39_79;
	} // PTX L3924
	r_bPtxPredicate107 = uint32_t(r_PtxRegister108) == uint32_t(1); // PTX L3925
	r_PtxRegister2073 = uint32_t(r_PtxRegister116);					// PTX L3926
	if (r_bPtxPredicate107)
	{
		goto L__BB39_79;
	} // PTX L3927
	r_bPtxPredicate108 = uint32_t(r_PtxRegister108) == uint32_t(2);				  // PTX L3928
	r_PtxRegister2073 = r_bPtxPredicate108 ? r_PtxRegister117 : r_PtxRegister118; // PTX L3929
L__BB39_79:																		  // PTX L3930
	r_bPtxPredicate109 = uint32_t(r_PtxRegister108) == uint32_t(0);				  // PTX L3931
	r_PtxRegister1691 = r_PtxRegister109 | 20;									  // PTX L3932
	r_PtxRegister2074 =
		ShuffleIdxPredicate(r_bPtxPredicate110, r_PtxRegister40, r_PtxRegister1691, 31, -1); // PTX L3933
	r_PtxRegister119 =
		ShuffleIdxPredicate(r_bPtxPredicate111, r_PtxRegister41, r_PtxRegister1691, 31, -1); // PTX L3934
	r_PtxRegister120 =
		ShuffleIdxPredicate(r_bPtxPredicate112, r_PtxRegister56, r_PtxRegister1691, 31, -1); // PTX L3935
	r_PtxRegister121 =
		ShuffleIdxPredicate(r_bPtxPredicate113, r_PtxRegister57, r_PtxRegister1691, 31, -1); // PTX L3936
	if (r_bPtxPredicate109)
	{
		goto L__BB39_82;
	} // PTX L3937
	r_bPtxPredicate114 = uint32_t(r_PtxRegister108) == uint32_t(1); // PTX L3938
	r_PtxRegister2074 = uint32_t(r_PtxRegister119);					// PTX L3939
	if (r_bPtxPredicate114)
	{
		goto L__BB39_82;
	} // PTX L3940
	r_bPtxPredicate115 = uint32_t(r_PtxRegister108) == uint32_t(2);				  // PTX L3941
	r_PtxRegister2074 = r_bPtxPredicate115 ? r_PtxRegister120 : r_PtxRegister121; // PTX L3942
L__BB39_82:																		  // PTX L3943
	r_PackedHalf2AtPtx3945R1692 = HalfAdd(r_PtxRegister2071, r_PtxRegister2072);  // PTX L3945
	r_PackedHalf2AtPtx3949R1693 = HalfAdd(r_PtxRegister2073, r_PtxRegister2074);  // PTX L3949
	r_PackedHalf2AtPtx3953R1695 =
		HalfAdd(r_PackedHalf2AtPtx3945R1692, r_PackedHalf2AtPtx3949R1693);						 // PTX L3953
	r_PtxRegister1694 = uint32_t(1048576000);													 // PTX L3956
	r_PtxU16Register153 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1694))); // PTX L3958
	r_PackedHalf2AtPtx3961R1906 = JoinHalfwords(r_PtxU16Register153, r_PtxU16Register153);		 // PTX L3961
	r_PackedHalf2AtPtx3963R1907 =
		HalfMul(r_PackedHalf2AtPtx3953R1695, r_PackedHalf2AtPtx3961R1906);		 // PTX L3963
	r_LaneIndexAtPtx3967 = uint32_t((threadIdx.x & 31u));						 // PTX L3967
	r_PtxRegister1697 = ShiftRight(uint32_t(r_LaneIndexAtPtx3967), uint32_t(2)); // PTX L3969
	r_PtxRegister1698 = r_PtxRegister1697 & 2;									 // PTX L3970
	r_PtxRegister1699 = ShiftRight(uint32_t(r_LaneIndexAtPtx3967), uint32_t(4)); // PTX L3971
	r_PtxRegister1700 = r_PtxRegister1699 & 1;									 // PTX L3972
	r_PtxRegister122 = r_PtxRegister1698 | r_PtxRegister1700;					 // PTX L3973
	r_PtxRegister1701 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3967), uint32_t(1));	 // PTX L3974
	r_PtxRegister1702 = r_PtxRegister1701 & 8;									 // PTX L3975
	r_PtxRegister1703 = r_LaneIndexAtPtx3967 & 3;								 // PTX L3976
	r_PtxRegister123 = r_PtxRegister1702 | r_PtxRegister1703;					 // PTX L3977
	r_PtxRegister2075 =
		ShuffleIdxPredicate(r_bPtxPredicate116, r_PtxRegister72, r_PtxRegister123, 31, -1); // PTX L3978
	r_PtxRegister124 =
		ShuffleIdxPredicate(r_bPtxPredicate117, r_PtxRegister73, r_PtxRegister123, 31, -1); // PTX L3979
	r_PtxRegister125 =
		ShuffleIdxPredicate(r_bPtxPredicate118, r_PtxRegister88, r_PtxRegister123, 31, -1); // PTX L3980
	r_PtxRegister126 =
		ShuffleIdxPredicate(r_bPtxPredicate119, r_PtxRegister89, r_PtxRegister123, 31, -1); // PTX L3981
	r_bPtxPredicate120 = uint32_t(r_PtxRegister122) == uint32_t(0);							// PTX L3982
	if (r_bPtxPredicate120)
	{
		goto L__BB39_85;
	} // PTX L3983
	r_bPtxPredicate121 = uint32_t(r_PtxRegister122) == uint32_t(1); // PTX L3984
	r_PtxRegister2075 = uint32_t(r_PtxRegister124);					// PTX L3985
	if (r_bPtxPredicate121)
	{
		goto L__BB39_85;
	} // PTX L3986
	r_bPtxPredicate122 = uint32_t(r_PtxRegister122) == uint32_t(2);				  // PTX L3987
	r_PtxRegister2075 = r_bPtxPredicate122 ? r_PtxRegister125 : r_PtxRegister126; // PTX L3988
L__BB39_85:																		  // PTX L3989
	r_bPtxPredicate123 = uint32_t(r_PtxRegister122) == uint32_t(0);				  // PTX L3990
	r_PtxRegister1704 = r_PtxRegister123 | 4;									  // PTX L3991
	r_PtxRegister2076 =
		ShuffleIdxPredicate(r_bPtxPredicate124, r_PtxRegister72, r_PtxRegister1704, 31, -1); // PTX L3992
	r_PtxRegister127 =
		ShuffleIdxPredicate(r_bPtxPredicate125, r_PtxRegister73, r_PtxRegister1704, 31, -1); // PTX L3993
	r_PtxRegister128 =
		ShuffleIdxPredicate(r_bPtxPredicate126, r_PtxRegister88, r_PtxRegister1704, 31, -1); // PTX L3994
	r_PtxRegister129 =
		ShuffleIdxPredicate(r_bPtxPredicate127, r_PtxRegister89, r_PtxRegister1704, 31, -1); // PTX L3995
	if (r_bPtxPredicate123)
	{
		goto L__BB39_88;
	} // PTX L3996
	r_bPtxPredicate128 = uint32_t(r_PtxRegister122) == uint32_t(1); // PTX L3997
	r_PtxRegister2076 = uint32_t(r_PtxRegister127);					// PTX L3998
	if (r_bPtxPredicate128)
	{
		goto L__BB39_88;
	} // PTX L3999
	r_bPtxPredicate129 = uint32_t(r_PtxRegister122) == uint32_t(2);				  // PTX L4000
	r_PtxRegister2076 = r_bPtxPredicate129 ? r_PtxRegister128 : r_PtxRegister129; // PTX L4001
L__BB39_88:																		  // PTX L4002
	r_bPtxPredicate130 = uint32_t(r_PtxRegister122) == uint32_t(0);				  // PTX L4003
	r_PtxRegister1705 = r_PtxRegister123 | 16;									  // PTX L4004
	r_PtxRegister2077 =
		ShuffleIdxPredicate(r_bPtxPredicate131, r_PtxRegister72, r_PtxRegister1705, 31, -1); // PTX L4005
	r_PtxRegister130 =
		ShuffleIdxPredicate(r_bPtxPredicate132, r_PtxRegister73, r_PtxRegister1705, 31, -1); // PTX L4006
	r_PtxRegister131 =
		ShuffleIdxPredicate(r_bPtxPredicate133, r_PtxRegister88, r_PtxRegister1705, 31, -1); // PTX L4007
	r_PtxRegister132 =
		ShuffleIdxPredicate(r_bPtxPredicate134, r_PtxRegister89, r_PtxRegister1705, 31, -1); // PTX L4008
	if (r_bPtxPredicate130)
	{
		goto L__BB39_91;
	} // PTX L4009
	r_bPtxPredicate135 = uint32_t(r_PtxRegister122) == uint32_t(1); // PTX L4010
	r_PtxRegister2077 = uint32_t(r_PtxRegister130);					// PTX L4011
	if (r_bPtxPredicate135)
	{
		goto L__BB39_91;
	} // PTX L4012
	r_bPtxPredicate136 = uint32_t(r_PtxRegister122) == uint32_t(2);				  // PTX L4013
	r_PtxRegister2077 = r_bPtxPredicate136 ? r_PtxRegister131 : r_PtxRegister132; // PTX L4014
L__BB39_91:																		  // PTX L4015
	r_bPtxPredicate137 = uint32_t(r_PtxRegister122) == uint32_t(0);				  // PTX L4016
	r_PtxRegister1706 = r_PtxRegister123 | 20;									  // PTX L4017
	r_PtxRegister2078 =
		ShuffleIdxPredicate(r_bPtxPredicate138, r_PtxRegister72, r_PtxRegister1706, 31, -1); // PTX L4018
	r_PtxRegister133 =
		ShuffleIdxPredicate(r_bPtxPredicate139, r_PtxRegister73, r_PtxRegister1706, 31, -1); // PTX L4019
	r_PtxRegister134 =
		ShuffleIdxPredicate(r_bPtxPredicate140, r_PtxRegister88, r_PtxRegister1706, 31, -1); // PTX L4020
	r_PtxRegister135 =
		ShuffleIdxPredicate(r_bPtxPredicate141, r_PtxRegister89, r_PtxRegister1706, 31, -1); // PTX L4021
	if (r_bPtxPredicate137)
	{
		goto L__BB39_94;
	} // PTX L4022
	r_bPtxPredicate142 = uint32_t(r_PtxRegister122) == uint32_t(1); // PTX L4023
	r_PtxRegister2078 = uint32_t(r_PtxRegister133);					// PTX L4024
	if (r_bPtxPredicate142)
	{
		goto L__BB39_94;
	} // PTX L4025
	r_bPtxPredicate143 = uint32_t(r_PtxRegister122) == uint32_t(2);				  // PTX L4026
	r_PtxRegister2078 = r_bPtxPredicate143 ? r_PtxRegister134 : r_PtxRegister135; // PTX L4027
L__BB39_94:																		  // PTX L4028
	r_PackedHalf2AtPtx4030R1707 = HalfAdd(r_PtxRegister2075, r_PtxRegister2076);  // PTX L4030
	r_PackedHalf2AtPtx4034R1708 = HalfAdd(r_PtxRegister2077, r_PtxRegister2078);  // PTX L4034
	r_PackedHalf2AtPtx4038R1709 =
		HalfAdd(r_PackedHalf2AtPtx4030R1707, r_PackedHalf2AtPtx4034R1708); // PTX L4038
	r_PackedHalf2AtPtx4042R1909 =
		HalfMul(r_PackedHalf2AtPtx4038R1709, r_PackedHalf2AtPtx3961R1906);		 // PTX L4042
	r_LaneIndexAtPtx4046 = uint32_t((threadIdx.x & 31u));						 // PTX L4046
	r_PtxRegister1711 = ShiftRight(uint32_t(r_LaneIndexAtPtx4046), uint32_t(2)); // PTX L4048
	r_PtxRegister1712 = r_PtxRegister1711 & 2;									 // PTX L4049
	r_PtxRegister1713 = ShiftRight(uint32_t(r_LaneIndexAtPtx4046), uint32_t(4)); // PTX L4050
	r_PtxRegister1714 = r_PtxRegister1713 & 1;									 // PTX L4051
	r_PtxRegister136 = r_PtxRegister1712 | r_PtxRegister1714;					 // PTX L4052
	r_PtxRegister1715 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4046), uint32_t(1));	 // PTX L4053
	r_PtxRegister1716 = r_PtxRegister1715 & 8;									 // PTX L4054
	r_PtxRegister1717 = r_LaneIndexAtPtx4046 & 3;								 // PTX L4055
	r_PtxRegister137 = r_PtxRegister1716 | r_PtxRegister1717;					 // PTX L4056
	r_PtxRegister2079 =
		ShuffleIdxPredicate(r_bPtxPredicate144, r_PtxRegister42, r_PtxRegister137, 31, -1); // PTX L4057
	r_PtxRegister138 =
		ShuffleIdxPredicate(r_bPtxPredicate145, r_PtxRegister43, r_PtxRegister137, 31, -1); // PTX L4058
	r_PtxRegister139 =
		ShuffleIdxPredicate(r_bPtxPredicate146, r_PtxRegister58, r_PtxRegister137, 31, -1); // PTX L4059
	r_PtxRegister140 =
		ShuffleIdxPredicate(r_bPtxPredicate147, r_PtxRegister59, r_PtxRegister137, 31, -1); // PTX L4060
	r_bPtxPredicate148 = uint32_t(r_PtxRegister136) == uint32_t(0);							// PTX L4061
	if (r_bPtxPredicate148)
	{
		goto L__BB39_97;
	} // PTX L4062
	r_bPtxPredicate149 = uint32_t(r_PtxRegister136) == uint32_t(1); // PTX L4063
	r_PtxRegister2079 = uint32_t(r_PtxRegister138);					// PTX L4064
	if (r_bPtxPredicate149)
	{
		goto L__BB39_97;
	} // PTX L4065
	r_bPtxPredicate150 = uint32_t(r_PtxRegister136) == uint32_t(2);				  // PTX L4066
	r_PtxRegister2079 = r_bPtxPredicate150 ? r_PtxRegister139 : r_PtxRegister140; // PTX L4067
L__BB39_97:																		  // PTX L4068
	r_bPtxPredicate151 = uint32_t(r_PtxRegister136) == uint32_t(0);				  // PTX L4069
	r_PtxRegister1718 = r_PtxRegister137 | 4;									  // PTX L4070
	r_PtxRegister2080 =
		ShuffleIdxPredicate(r_bPtxPredicate152, r_PtxRegister42, r_PtxRegister1718, 31, -1); // PTX L4071
	r_PtxRegister141 =
		ShuffleIdxPredicate(r_bPtxPredicate153, r_PtxRegister43, r_PtxRegister1718, 31, -1); // PTX L4072
	r_PtxRegister142 =
		ShuffleIdxPredicate(r_bPtxPredicate154, r_PtxRegister58, r_PtxRegister1718, 31, -1); // PTX L4073
	r_PtxRegister143 =
		ShuffleIdxPredicate(r_bPtxPredicate155, r_PtxRegister59, r_PtxRegister1718, 31, -1); // PTX L4074
	if (r_bPtxPredicate151)
	{
		goto L__BB39_100;
	} // PTX L4075
	r_bPtxPredicate156 = uint32_t(r_PtxRegister136) == uint32_t(1); // PTX L4076
	r_PtxRegister2080 = uint32_t(r_PtxRegister141);					// PTX L4077
	if (r_bPtxPredicate156)
	{
		goto L__BB39_100;
	} // PTX L4078
	r_bPtxPredicate157 = uint32_t(r_PtxRegister136) == uint32_t(2);				  // PTX L4079
	r_PtxRegister2080 = r_bPtxPredicate157 ? r_PtxRegister142 : r_PtxRegister143; // PTX L4080
L__BB39_100:																	  // PTX L4081
	r_bPtxPredicate158 = uint32_t(r_PtxRegister136) == uint32_t(0);				  // PTX L4082
	r_PtxRegister1719 = r_PtxRegister137 | 16;									  // PTX L4083
	r_PtxRegister2081 =
		ShuffleIdxPredicate(r_bPtxPredicate159, r_PtxRegister42, r_PtxRegister1719, 31, -1); // PTX L4084
	r_PtxRegister144 =
		ShuffleIdxPredicate(r_bPtxPredicate160, r_PtxRegister43, r_PtxRegister1719, 31, -1); // PTX L4085
	r_PtxRegister145 =
		ShuffleIdxPredicate(r_bPtxPredicate161, r_PtxRegister58, r_PtxRegister1719, 31, -1); // PTX L4086
	r_PtxRegister146 =
		ShuffleIdxPredicate(r_bPtxPredicate162, r_PtxRegister59, r_PtxRegister1719, 31, -1); // PTX L4087
	if (r_bPtxPredicate158)
	{
		goto L__BB39_103;
	} // PTX L4088
	r_bPtxPredicate163 = uint32_t(r_PtxRegister136) == uint32_t(1); // PTX L4089
	r_PtxRegister2081 = uint32_t(r_PtxRegister144);					// PTX L4090
	if (r_bPtxPredicate163)
	{
		goto L__BB39_103;
	} // PTX L4091
	r_bPtxPredicate164 = uint32_t(r_PtxRegister136) == uint32_t(2);				  // PTX L4092
	r_PtxRegister2081 = r_bPtxPredicate164 ? r_PtxRegister145 : r_PtxRegister146; // PTX L4093
L__BB39_103:																	  // PTX L4094
	r_bPtxPredicate165 = uint32_t(r_PtxRegister136) == uint32_t(0);				  // PTX L4095
	r_PtxRegister1720 = r_PtxRegister137 | 20;									  // PTX L4096
	r_PtxRegister2082 =
		ShuffleIdxPredicate(r_bPtxPredicate166, r_PtxRegister42, r_PtxRegister1720, 31, -1); // PTX L4097
	r_PtxRegister147 =
		ShuffleIdxPredicate(r_bPtxPredicate167, r_PtxRegister43, r_PtxRegister1720, 31, -1); // PTX L4098
	r_PtxRegister148 =
		ShuffleIdxPredicate(r_bPtxPredicate168, r_PtxRegister58, r_PtxRegister1720, 31, -1); // PTX L4099
	r_PtxRegister149 =
		ShuffleIdxPredicate(r_bPtxPredicate169, r_PtxRegister59, r_PtxRegister1720, 31, -1); // PTX L4100
	if (r_bPtxPredicate165)
	{
		goto L__BB39_106;
	} // PTX L4101
	r_bPtxPredicate170 = uint32_t(r_PtxRegister136) == uint32_t(1); // PTX L4102
	r_PtxRegister2082 = uint32_t(r_PtxRegister147);					// PTX L4103
	if (r_bPtxPredicate170)
	{
		goto L__BB39_106;
	} // PTX L4104
	r_bPtxPredicate171 = uint32_t(r_PtxRegister136) == uint32_t(2);				  // PTX L4105
	r_PtxRegister2082 = r_bPtxPredicate171 ? r_PtxRegister148 : r_PtxRegister149; // PTX L4106
L__BB39_106:																	  // PTX L4107
	r_PackedHalf2AtPtx4109R1721 = HalfAdd(r_PtxRegister2079, r_PtxRegister2080);  // PTX L4109
	r_PackedHalf2AtPtx4113R1722 = HalfAdd(r_PtxRegister2081, r_PtxRegister2082);  // PTX L4113
	r_PackedHalf2AtPtx4117R1723 =
		HalfAdd(r_PackedHalf2AtPtx4109R1721, r_PackedHalf2AtPtx4113R1722); // PTX L4117
	r_PackedHalf2AtPtx4121R1908 =
		HalfMul(r_PackedHalf2AtPtx4117R1723, r_PackedHalf2AtPtx3961R1906);		 // PTX L4121
	r_LaneIndexAtPtx4125 = uint32_t((threadIdx.x & 31u));						 // PTX L4125
	r_PtxRegister1725 = ShiftRight(uint32_t(r_LaneIndexAtPtx4125), uint32_t(2)); // PTX L4127
	r_PtxRegister1726 = r_PtxRegister1725 & 2;									 // PTX L4128
	r_PtxRegister1727 = ShiftRight(uint32_t(r_LaneIndexAtPtx4125), uint32_t(4)); // PTX L4129
	r_PtxRegister1728 = r_PtxRegister1727 & 1;									 // PTX L4130
	r_PtxRegister150 = r_PtxRegister1726 | r_PtxRegister1728;					 // PTX L4131
	r_PtxRegister1729 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4125), uint32_t(1));	 // PTX L4132
	r_PtxRegister1730 = r_PtxRegister1729 & 8;									 // PTX L4133
	r_PtxRegister1731 = r_LaneIndexAtPtx4125 & 3;								 // PTX L4134
	r_PtxRegister151 = r_PtxRegister1730 | r_PtxRegister1731;					 // PTX L4135
	r_PtxRegister2083 =
		ShuffleIdxPredicate(r_bPtxPredicate172, r_PtxRegister74, r_PtxRegister151, 31, -1); // PTX L4136
	r_PtxRegister152 =
		ShuffleIdxPredicate(r_bPtxPredicate173, r_PtxRegister75, r_PtxRegister151, 31, -1); // PTX L4137
	r_PtxRegister153 =
		ShuffleIdxPredicate(r_bPtxPredicate174, r_PtxRegister90, r_PtxRegister151, 31, -1); // PTX L4138
	r_PtxRegister154 =
		ShuffleIdxPredicate(r_bPtxPredicate175, r_PtxRegister91, r_PtxRegister151, 31, -1); // PTX L4139
	r_bPtxPredicate176 = uint32_t(r_PtxRegister150) == uint32_t(0);							// PTX L4140
	if (r_bPtxPredicate176)
	{
		goto L__BB39_109;
	} // PTX L4141
	r_bPtxPredicate177 = uint32_t(r_PtxRegister150) == uint32_t(1); // PTX L4142
	r_PtxRegister2083 = uint32_t(r_PtxRegister152);					// PTX L4143
	if (r_bPtxPredicate177)
	{
		goto L__BB39_109;
	} // PTX L4144
	r_bPtxPredicate178 = uint32_t(r_PtxRegister150) == uint32_t(2);				  // PTX L4145
	r_PtxRegister2083 = r_bPtxPredicate178 ? r_PtxRegister153 : r_PtxRegister154; // PTX L4146
L__BB39_109:																	  // PTX L4147
	r_bPtxPredicate179 = uint32_t(r_PtxRegister150) == uint32_t(0);				  // PTX L4148
	r_PtxRegister1732 = r_PtxRegister151 | 4;									  // PTX L4149
	r_PtxRegister2084 =
		ShuffleIdxPredicate(r_bPtxPredicate180, r_PtxRegister74, r_PtxRegister1732, 31, -1); // PTX L4150
	r_PtxRegister155 =
		ShuffleIdxPredicate(r_bPtxPredicate181, r_PtxRegister75, r_PtxRegister1732, 31, -1); // PTX L4151
	r_PtxRegister156 =
		ShuffleIdxPredicate(r_bPtxPredicate182, r_PtxRegister90, r_PtxRegister1732, 31, -1); // PTX L4152
	r_PtxRegister157 =
		ShuffleIdxPredicate(r_bPtxPredicate183, r_PtxRegister91, r_PtxRegister1732, 31, -1); // PTX L4153
	if (r_bPtxPredicate179)
	{
		goto L__BB39_112;
	} // PTX L4154
	r_bPtxPredicate184 = uint32_t(r_PtxRegister150) == uint32_t(1); // PTX L4155
	r_PtxRegister2084 = uint32_t(r_PtxRegister155);					// PTX L4156
	if (r_bPtxPredicate184)
	{
		goto L__BB39_112;
	} // PTX L4157
	r_bPtxPredicate185 = uint32_t(r_PtxRegister150) == uint32_t(2);				  // PTX L4158
	r_PtxRegister2084 = r_bPtxPredicate185 ? r_PtxRegister156 : r_PtxRegister157; // PTX L4159
L__BB39_112:																	  // PTX L4160
	r_bPtxPredicate186 = uint32_t(r_PtxRegister150) == uint32_t(0);				  // PTX L4161
	r_PtxRegister1733 = r_PtxRegister151 | 16;									  // PTX L4162
	r_PtxRegister2085 =
		ShuffleIdxPredicate(r_bPtxPredicate187, r_PtxRegister74, r_PtxRegister1733, 31, -1); // PTX L4163
	r_PtxRegister158 =
		ShuffleIdxPredicate(r_bPtxPredicate188, r_PtxRegister75, r_PtxRegister1733, 31, -1); // PTX L4164
	r_PtxRegister159 =
		ShuffleIdxPredicate(r_bPtxPredicate189, r_PtxRegister90, r_PtxRegister1733, 31, -1); // PTX L4165
	r_PtxRegister160 =
		ShuffleIdxPredicate(r_bPtxPredicate190, r_PtxRegister91, r_PtxRegister1733, 31, -1); // PTX L4166
	if (r_bPtxPredicate186)
	{
		goto L__BB39_115;
	} // PTX L4167
	r_bPtxPredicate191 = uint32_t(r_PtxRegister150) == uint32_t(1); // PTX L4168
	r_PtxRegister2085 = uint32_t(r_PtxRegister158);					// PTX L4169
	if (r_bPtxPredicate191)
	{
		goto L__BB39_115;
	} // PTX L4170
	r_bPtxPredicate192 = uint32_t(r_PtxRegister150) == uint32_t(2);				  // PTX L4171
	r_PtxRegister2085 = r_bPtxPredicate192 ? r_PtxRegister159 : r_PtxRegister160; // PTX L4172
L__BB39_115:																	  // PTX L4173
	r_bPtxPredicate193 = uint32_t(r_PtxRegister150) == uint32_t(0);				  // PTX L4174
	r_PtxRegister1734 = r_PtxRegister151 | 20;									  // PTX L4175
	r_PtxRegister2086 =
		ShuffleIdxPredicate(r_bPtxPredicate194, r_PtxRegister74, r_PtxRegister1734, 31, -1); // PTX L4176
	r_PtxRegister161 =
		ShuffleIdxPredicate(r_bPtxPredicate195, r_PtxRegister75, r_PtxRegister1734, 31, -1); // PTX L4177
	r_PtxRegister162 =
		ShuffleIdxPredicate(r_bPtxPredicate196, r_PtxRegister90, r_PtxRegister1734, 31, -1); // PTX L4178
	r_PtxRegister163 =
		ShuffleIdxPredicate(r_bPtxPredicate197, r_PtxRegister91, r_PtxRegister1734, 31, -1); // PTX L4179
	if (r_bPtxPredicate193)
	{
		goto L__BB39_118;
	} // PTX L4180
	r_bPtxPredicate198 = uint32_t(r_PtxRegister150) == uint32_t(1); // PTX L4181
	r_PtxRegister2086 = uint32_t(r_PtxRegister161);					// PTX L4182
	if (r_bPtxPredicate198)
	{
		goto L__BB39_118;
	} // PTX L4183
	r_bPtxPredicate199 = uint32_t(r_PtxRegister150) == uint32_t(2);				  // PTX L4184
	r_PtxRegister2086 = r_bPtxPredicate199 ? r_PtxRegister162 : r_PtxRegister163; // PTX L4185
L__BB39_118:																	  // PTX L4186
	r_PackedHalf2AtPtx4188R1735 = HalfAdd(r_PtxRegister2083, r_PtxRegister2084);  // PTX L4188
	r_PackedHalf2AtPtx4192R1736 = HalfAdd(r_PtxRegister2085, r_PtxRegister2086);  // PTX L4192
	r_PackedHalf2AtPtx4196R1737 =
		HalfAdd(r_PackedHalf2AtPtx4188R1735, r_PackedHalf2AtPtx4192R1736); // PTX L4196
	r_PackedHalf2AtPtx4200R1910 =
		HalfMul(r_PackedHalf2AtPtx4196R1737, r_PackedHalf2AtPtx3961R1906);		 // PTX L4200
	r_LaneIndexAtPtx4204 = uint32_t((threadIdx.x & 31u));						 // PTX L4204
	r_PtxRegister1739 = ShiftRight(uint32_t(r_LaneIndexAtPtx4204), uint32_t(2)); // PTX L4206
	r_PtxRegister1740 = r_PtxRegister1739 & 2;									 // PTX L4207
	r_PtxRegister1741 = ShiftRight(uint32_t(r_LaneIndexAtPtx4204), uint32_t(4)); // PTX L4208
	r_PtxRegister1742 = r_PtxRegister1741 & 1;									 // PTX L4209
	r_PtxRegister164 = r_PtxRegister1740 | r_PtxRegister1742;					 // PTX L4210
	r_PtxRegister1743 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4204), uint32_t(1));	 // PTX L4211
	r_PtxRegister1744 = r_PtxRegister1743 & 8;									 // PTX L4212
	r_PtxRegister1745 = r_LaneIndexAtPtx4204 & 3;								 // PTX L4213
	r_PtxRegister165 = r_PtxRegister1744 | r_PtxRegister1745;					 // PTX L4214
	r_PtxRegister2087 =
		ShuffleIdxPredicate(r_bPtxPredicate200, r_PtxRegister44, r_PtxRegister165, 31, -1); // PTX L4215
	r_PtxRegister166 =
		ShuffleIdxPredicate(r_bPtxPredicate201, r_PtxRegister45, r_PtxRegister165, 31, -1); // PTX L4216
	r_PtxRegister167 =
		ShuffleIdxPredicate(r_bPtxPredicate202, r_PtxRegister60, r_PtxRegister165, 31, -1); // PTX L4217
	r_PtxRegister168 =
		ShuffleIdxPredicate(r_bPtxPredicate203, r_PtxRegister61, r_PtxRegister165, 31, -1); // PTX L4218
	r_bPtxPredicate204 = uint32_t(r_PtxRegister164) == uint32_t(0);							// PTX L4219
	if (r_bPtxPredicate204)
	{
		goto L__BB39_121;
	} // PTX L4220
	r_bPtxPredicate205 = uint32_t(r_PtxRegister164) == uint32_t(1); // PTX L4221
	r_PtxRegister2087 = uint32_t(r_PtxRegister166);					// PTX L4222
	if (r_bPtxPredicate205)
	{
		goto L__BB39_121;
	} // PTX L4223
	r_bPtxPredicate206 = uint32_t(r_PtxRegister164) == uint32_t(2);				  // PTX L4224
	r_PtxRegister2087 = r_bPtxPredicate206 ? r_PtxRegister167 : r_PtxRegister168; // PTX L4225
L__BB39_121:																	  // PTX L4226
	r_bPtxPredicate207 = uint32_t(r_PtxRegister164) == uint32_t(0);				  // PTX L4227
	r_PtxRegister1746 = r_PtxRegister165 | 4;									  // PTX L4228
	r_PtxRegister2088 =
		ShuffleIdxPredicate(r_bPtxPredicate208, r_PtxRegister44, r_PtxRegister1746, 31, -1); // PTX L4229
	r_PtxRegister169 =
		ShuffleIdxPredicate(r_bPtxPredicate209, r_PtxRegister45, r_PtxRegister1746, 31, -1); // PTX L4230
	r_PtxRegister170 =
		ShuffleIdxPredicate(r_bPtxPredicate210, r_PtxRegister60, r_PtxRegister1746, 31, -1); // PTX L4231
	r_PtxRegister171 =
		ShuffleIdxPredicate(r_bPtxPredicate211, r_PtxRegister61, r_PtxRegister1746, 31, -1); // PTX L4232
	if (r_bPtxPredicate207)
	{
		goto L__BB39_124;
	} // PTX L4233
	r_bPtxPredicate212 = uint32_t(r_PtxRegister164) == uint32_t(1); // PTX L4234
	r_PtxRegister2088 = uint32_t(r_PtxRegister169);					// PTX L4235
	if (r_bPtxPredicate212)
	{
		goto L__BB39_124;
	} // PTX L4236
	r_bPtxPredicate213 = uint32_t(r_PtxRegister164) == uint32_t(2);				  // PTX L4237
	r_PtxRegister2088 = r_bPtxPredicate213 ? r_PtxRegister170 : r_PtxRegister171; // PTX L4238
L__BB39_124:																	  // PTX L4239
	r_bPtxPredicate214 = uint32_t(r_PtxRegister164) == uint32_t(0);				  // PTX L4240
	r_PtxRegister1747 = r_PtxRegister165 | 16;									  // PTX L4241
	r_PtxRegister2089 =
		ShuffleIdxPredicate(r_bPtxPredicate215, r_PtxRegister44, r_PtxRegister1747, 31, -1); // PTX L4242
	r_PtxRegister172 =
		ShuffleIdxPredicate(r_bPtxPredicate216, r_PtxRegister45, r_PtxRegister1747, 31, -1); // PTX L4243
	r_PtxRegister173 =
		ShuffleIdxPredicate(r_bPtxPredicate217, r_PtxRegister60, r_PtxRegister1747, 31, -1); // PTX L4244
	r_PtxRegister174 =
		ShuffleIdxPredicate(r_bPtxPredicate218, r_PtxRegister61, r_PtxRegister1747, 31, -1); // PTX L4245
	if (r_bPtxPredicate214)
	{
		goto L__BB39_127;
	} // PTX L4246
	r_bPtxPredicate219 = uint32_t(r_PtxRegister164) == uint32_t(1); // PTX L4247
	r_PtxRegister2089 = uint32_t(r_PtxRegister172);					// PTX L4248
	if (r_bPtxPredicate219)
	{
		goto L__BB39_127;
	} // PTX L4249
	r_bPtxPredicate220 = uint32_t(r_PtxRegister164) == uint32_t(2);				  // PTX L4250
	r_PtxRegister2089 = r_bPtxPredicate220 ? r_PtxRegister173 : r_PtxRegister174; // PTX L4251
L__BB39_127:																	  // PTX L4252
	r_bPtxPredicate221 = uint32_t(r_PtxRegister164) == uint32_t(0);				  // PTX L4253
	r_PtxRegister1748 = r_PtxRegister165 | 20;									  // PTX L4254
	r_PtxRegister2090 =
		ShuffleIdxPredicate(r_bPtxPredicate222, r_PtxRegister44, r_PtxRegister1748, 31, -1); // PTX L4255
	r_PtxRegister175 =
		ShuffleIdxPredicate(r_bPtxPredicate223, r_PtxRegister45, r_PtxRegister1748, 31, -1); // PTX L4256
	r_PtxRegister176 =
		ShuffleIdxPredicate(r_bPtxPredicate224, r_PtxRegister60, r_PtxRegister1748, 31, -1); // PTX L4257
	r_PtxRegister177 =
		ShuffleIdxPredicate(r_bPtxPredicate225, r_PtxRegister61, r_PtxRegister1748, 31, -1); // PTX L4258
	if (r_bPtxPredicate221)
	{
		goto L__BB39_130;
	} // PTX L4259
	r_bPtxPredicate226 = uint32_t(r_PtxRegister164) == uint32_t(1); // PTX L4260
	r_PtxRegister2090 = uint32_t(r_PtxRegister175);					// PTX L4261
	if (r_bPtxPredicate226)
	{
		goto L__BB39_130;
	} // PTX L4262
	r_bPtxPredicate227 = uint32_t(r_PtxRegister164) == uint32_t(2);				  // PTX L4263
	r_PtxRegister2090 = r_bPtxPredicate227 ? r_PtxRegister176 : r_PtxRegister177; // PTX L4264
L__BB39_130:																	  // PTX L4265
	r_PackedHalf2AtPtx4267R1749 = HalfAdd(r_PtxRegister2087, r_PtxRegister2088);  // PTX L4267
	r_PackedHalf2AtPtx4271R1750 = HalfAdd(r_PtxRegister2089, r_PtxRegister2090);  // PTX L4271
	r_PackedHalf2AtPtx4275R1751 =
		HalfAdd(r_PackedHalf2AtPtx4267R1749, r_PackedHalf2AtPtx4271R1750); // PTX L4275
	r_PackedHalf2AtPtx4279R1911 =
		HalfMul(r_PackedHalf2AtPtx4275R1751, r_PackedHalf2AtPtx3961R1906);		 // PTX L4279
	r_LaneIndexAtPtx4283 = uint32_t((threadIdx.x & 31u));						 // PTX L4283
	r_PtxRegister1753 = ShiftRight(uint32_t(r_LaneIndexAtPtx4283), uint32_t(2)); // PTX L4285
	r_PtxRegister1754 = r_PtxRegister1753 & 2;									 // PTX L4286
	r_PtxRegister1755 = ShiftRight(uint32_t(r_LaneIndexAtPtx4283), uint32_t(4)); // PTX L4287
	r_PtxRegister1756 = r_PtxRegister1755 & 1;									 // PTX L4288
	r_PtxRegister178 = r_PtxRegister1754 | r_PtxRegister1756;					 // PTX L4289
	r_PtxRegister1757 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4283), uint32_t(1));	 // PTX L4290
	r_PtxRegister1758 = r_PtxRegister1757 & 8;									 // PTX L4291
	r_PtxRegister1759 = r_LaneIndexAtPtx4283 & 3;								 // PTX L4292
	r_PtxRegister179 = r_PtxRegister1758 | r_PtxRegister1759;					 // PTX L4293
	r_PtxRegister2091 =
		ShuffleIdxPredicate(r_bPtxPredicate228, r_PtxRegister76, r_PtxRegister179, 31, -1); // PTX L4294
	r_PtxRegister180 =
		ShuffleIdxPredicate(r_bPtxPredicate229, r_PtxRegister77, r_PtxRegister179, 31, -1); // PTX L4295
	r_PtxRegister181 =
		ShuffleIdxPredicate(r_bPtxPredicate230, r_PtxRegister92, r_PtxRegister179, 31, -1); // PTX L4296
	r_PtxRegister182 =
		ShuffleIdxPredicate(r_bPtxPredicate231, r_PtxRegister93, r_PtxRegister179, 31, -1); // PTX L4297
	r_bPtxPredicate232 = uint32_t(r_PtxRegister178) == uint32_t(0);							// PTX L4298
	if (r_bPtxPredicate232)
	{
		goto L__BB39_133;
	} // PTX L4299
	r_bPtxPredicate233 = uint32_t(r_PtxRegister178) == uint32_t(1); // PTX L4300
	r_PtxRegister2091 = uint32_t(r_PtxRegister180);					// PTX L4301
	if (r_bPtxPredicate233)
	{
		goto L__BB39_133;
	} // PTX L4302
	r_bPtxPredicate234 = uint32_t(r_PtxRegister178) == uint32_t(2);				  // PTX L4303
	r_PtxRegister2091 = r_bPtxPredicate234 ? r_PtxRegister181 : r_PtxRegister182; // PTX L4304
L__BB39_133:																	  // PTX L4305
	r_bPtxPredicate235 = uint32_t(r_PtxRegister178) == uint32_t(0);				  // PTX L4306
	r_PtxRegister1760 = r_PtxRegister179 | 4;									  // PTX L4307
	r_PtxRegister2092 =
		ShuffleIdxPredicate(r_bPtxPredicate236, r_PtxRegister76, r_PtxRegister1760, 31, -1); // PTX L4308
	r_PtxRegister183 =
		ShuffleIdxPredicate(r_bPtxPredicate237, r_PtxRegister77, r_PtxRegister1760, 31, -1); // PTX L4309
	r_PtxRegister184 =
		ShuffleIdxPredicate(r_bPtxPredicate238, r_PtxRegister92, r_PtxRegister1760, 31, -1); // PTX L4310
	r_PtxRegister185 =
		ShuffleIdxPredicate(r_bPtxPredicate239, r_PtxRegister93, r_PtxRegister1760, 31, -1); // PTX L4311
	if (r_bPtxPredicate235)
	{
		goto L__BB39_136;
	} // PTX L4312
	r_bPtxPredicate240 = uint32_t(r_PtxRegister178) == uint32_t(1); // PTX L4313
	r_PtxRegister2092 = uint32_t(r_PtxRegister183);					// PTX L4314
	if (r_bPtxPredicate240)
	{
		goto L__BB39_136;
	} // PTX L4315
	r_bPtxPredicate241 = uint32_t(r_PtxRegister178) == uint32_t(2);				  // PTX L4316
	r_PtxRegister2092 = r_bPtxPredicate241 ? r_PtxRegister184 : r_PtxRegister185; // PTX L4317
L__BB39_136:																	  // PTX L4318
	r_bPtxPredicate242 = uint32_t(r_PtxRegister178) == uint32_t(0);				  // PTX L4319
	r_PtxRegister1761 = r_PtxRegister179 | 16;									  // PTX L4320
	r_PtxRegister2093 =
		ShuffleIdxPredicate(r_bPtxPredicate243, r_PtxRegister76, r_PtxRegister1761, 31, -1); // PTX L4321
	r_PtxRegister186 =
		ShuffleIdxPredicate(r_bPtxPredicate244, r_PtxRegister77, r_PtxRegister1761, 31, -1); // PTX L4322
	r_PtxRegister187 =
		ShuffleIdxPredicate(r_bPtxPredicate245, r_PtxRegister92, r_PtxRegister1761, 31, -1); // PTX L4323
	r_PtxRegister188 =
		ShuffleIdxPredicate(r_bPtxPredicate246, r_PtxRegister93, r_PtxRegister1761, 31, -1); // PTX L4324
	if (r_bPtxPredicate242)
	{
		goto L__BB39_139;
	} // PTX L4325
	r_bPtxPredicate247 = uint32_t(r_PtxRegister178) == uint32_t(1); // PTX L4326
	r_PtxRegister2093 = uint32_t(r_PtxRegister186);					// PTX L4327
	if (r_bPtxPredicate247)
	{
		goto L__BB39_139;
	} // PTX L4328
	r_bPtxPredicate248 = uint32_t(r_PtxRegister178) == uint32_t(2);				  // PTX L4329
	r_PtxRegister2093 = r_bPtxPredicate248 ? r_PtxRegister187 : r_PtxRegister188; // PTX L4330
L__BB39_139:																	  // PTX L4331
	r_bPtxPredicate249 = uint32_t(r_PtxRegister178) == uint32_t(0);				  // PTX L4332
	r_PtxRegister1762 = r_PtxRegister179 | 20;									  // PTX L4333
	r_PtxRegister2094 =
		ShuffleIdxPredicate(r_bPtxPredicate250, r_PtxRegister76, r_PtxRegister1762, 31, -1); // PTX L4334
	r_PtxRegister189 =
		ShuffleIdxPredicate(r_bPtxPredicate251, r_PtxRegister77, r_PtxRegister1762, 31, -1); // PTX L4335
	r_PtxRegister190 =
		ShuffleIdxPredicate(r_bPtxPredicate252, r_PtxRegister92, r_PtxRegister1762, 31, -1); // PTX L4336
	r_PtxRegister191 =
		ShuffleIdxPredicate(r_bPtxPredicate253, r_PtxRegister93, r_PtxRegister1762, 31, -1); // PTX L4337
	if (r_bPtxPredicate249)
	{
		goto L__BB39_142;
	} // PTX L4338
	r_bPtxPredicate254 = uint32_t(r_PtxRegister178) == uint32_t(1); // PTX L4339
	r_PtxRegister2094 = uint32_t(r_PtxRegister189);					// PTX L4340
	if (r_bPtxPredicate254)
	{
		goto L__BB39_142;
	} // PTX L4341
	r_bPtxPredicate255 = uint32_t(r_PtxRegister178) == uint32_t(2);				  // PTX L4342
	r_PtxRegister2094 = r_bPtxPredicate255 ? r_PtxRegister190 : r_PtxRegister191; // PTX L4343
L__BB39_142:																	  // PTX L4344
	r_PackedHalf2AtPtx4346R1763 = HalfAdd(r_PtxRegister2091, r_PtxRegister2092);  // PTX L4346
	r_PackedHalf2AtPtx4350R1764 = HalfAdd(r_PtxRegister2093, r_PtxRegister2094);  // PTX L4350
	r_PackedHalf2AtPtx4354R1765 =
		HalfAdd(r_PackedHalf2AtPtx4346R1763, r_PackedHalf2AtPtx4350R1764); // PTX L4354
	r_PackedHalf2AtPtx4358R1913 =
		HalfMul(r_PackedHalf2AtPtx4354R1765, r_PackedHalf2AtPtx3961R1906);		 // PTX L4358
	r_LaneIndexAtPtx4362 = uint32_t((threadIdx.x & 31u));						 // PTX L4362
	r_PtxRegister1767 = ShiftRight(uint32_t(r_LaneIndexAtPtx4362), uint32_t(2)); // PTX L4364
	r_PtxRegister1768 = r_PtxRegister1767 & 2;									 // PTX L4365
	r_PtxRegister1769 = ShiftRight(uint32_t(r_LaneIndexAtPtx4362), uint32_t(4)); // PTX L4366
	r_PtxRegister1770 = r_PtxRegister1769 & 1;									 // PTX L4367
	r_PtxRegister192 = r_PtxRegister1768 | r_PtxRegister1770;					 // PTX L4368
	r_PtxRegister1771 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4362), uint32_t(1));	 // PTX L4369
	r_PtxRegister1772 = r_PtxRegister1771 & 8;									 // PTX L4370
	r_PtxRegister1773 = r_LaneIndexAtPtx4362 & 3;								 // PTX L4371
	r_PtxRegister193 = r_PtxRegister1772 | r_PtxRegister1773;					 // PTX L4372
	r_PtxRegister2095 =
		ShuffleIdxPredicate(r_bPtxPredicate256, r_PtxRegister46, r_PtxRegister193, 31, -1); // PTX L4373
	r_PtxRegister194 =
		ShuffleIdxPredicate(r_bPtxPredicate257, r_PtxRegister47, r_PtxRegister193, 31, -1); // PTX L4374
	r_PtxRegister195 =
		ShuffleIdxPredicate(r_bPtxPredicate258, r_PtxRegister62, r_PtxRegister193, 31, -1); // PTX L4375
	r_PtxRegister196 =
		ShuffleIdxPredicate(r_bPtxPredicate259, r_PtxRegister63, r_PtxRegister193, 31, -1); // PTX L4376
	r_bPtxPredicate260 = uint32_t(r_PtxRegister192) == uint32_t(0);							// PTX L4377
	if (r_bPtxPredicate260)
	{
		goto L__BB39_145;
	} // PTX L4378
	r_bPtxPredicate261 = uint32_t(r_PtxRegister192) == uint32_t(1); // PTX L4379
	r_PtxRegister2095 = uint32_t(r_PtxRegister194);					// PTX L4380
	if (r_bPtxPredicate261)
	{
		goto L__BB39_145;
	} // PTX L4381
	r_bPtxPredicate262 = uint32_t(r_PtxRegister192) == uint32_t(2);				  // PTX L4382
	r_PtxRegister2095 = r_bPtxPredicate262 ? r_PtxRegister195 : r_PtxRegister196; // PTX L4383
L__BB39_145:																	  // PTX L4384
	r_bPtxPredicate263 = uint32_t(r_PtxRegister192) == uint32_t(0);				  // PTX L4385
	r_PtxRegister1774 = r_PtxRegister193 | 4;									  // PTX L4386
	r_PtxRegister2096 =
		ShuffleIdxPredicate(r_bPtxPredicate264, r_PtxRegister46, r_PtxRegister1774, 31, -1); // PTX L4387
	r_PtxRegister197 =
		ShuffleIdxPredicate(r_bPtxPredicate265, r_PtxRegister47, r_PtxRegister1774, 31, -1); // PTX L4388
	r_PtxRegister198 =
		ShuffleIdxPredicate(r_bPtxPredicate266, r_PtxRegister62, r_PtxRegister1774, 31, -1); // PTX L4389
	r_PtxRegister199 =
		ShuffleIdxPredicate(r_bPtxPredicate267, r_PtxRegister63, r_PtxRegister1774, 31, -1); // PTX L4390
	if (r_bPtxPredicate263)
	{
		goto L__BB39_148;
	} // PTX L4391
	r_bPtxPredicate268 = uint32_t(r_PtxRegister192) == uint32_t(1); // PTX L4392
	r_PtxRegister2096 = uint32_t(r_PtxRegister197);					// PTX L4393
	if (r_bPtxPredicate268)
	{
		goto L__BB39_148;
	} // PTX L4394
	r_bPtxPredicate269 = uint32_t(r_PtxRegister192) == uint32_t(2);				  // PTX L4395
	r_PtxRegister2096 = r_bPtxPredicate269 ? r_PtxRegister198 : r_PtxRegister199; // PTX L4396
L__BB39_148:																	  // PTX L4397
	r_bPtxPredicate270 = uint32_t(r_PtxRegister192) == uint32_t(0);				  // PTX L4398
	r_PtxRegister1775 = r_PtxRegister193 | 16;									  // PTX L4399
	r_PtxRegister2097 =
		ShuffleIdxPredicate(r_bPtxPredicate271, r_PtxRegister46, r_PtxRegister1775, 31, -1); // PTX L4400
	r_PtxRegister200 =
		ShuffleIdxPredicate(r_bPtxPredicate272, r_PtxRegister47, r_PtxRegister1775, 31, -1); // PTX L4401
	r_PtxRegister201 =
		ShuffleIdxPredicate(r_bPtxPredicate273, r_PtxRegister62, r_PtxRegister1775, 31, -1); // PTX L4402
	r_PtxRegister202 =
		ShuffleIdxPredicate(r_bPtxPredicate274, r_PtxRegister63, r_PtxRegister1775, 31, -1); // PTX L4403
	if (r_bPtxPredicate270)
	{
		goto L__BB39_151;
	} // PTX L4404
	r_bPtxPredicate275 = uint32_t(r_PtxRegister192) == uint32_t(1); // PTX L4405
	r_PtxRegister2097 = uint32_t(r_PtxRegister200);					// PTX L4406
	if (r_bPtxPredicate275)
	{
		goto L__BB39_151;
	} // PTX L4407
	r_bPtxPredicate276 = uint32_t(r_PtxRegister192) == uint32_t(2);				  // PTX L4408
	r_PtxRegister2097 = r_bPtxPredicate276 ? r_PtxRegister201 : r_PtxRegister202; // PTX L4409
L__BB39_151:																	  // PTX L4410
	r_bPtxPredicate277 = uint32_t(r_PtxRegister192) == uint32_t(0);				  // PTX L4411
	r_PtxRegister1776 = r_PtxRegister193 | 20;									  // PTX L4412
	r_PtxRegister2098 =
		ShuffleIdxPredicate(r_bPtxPredicate278, r_PtxRegister46, r_PtxRegister1776, 31, -1); // PTX L4413
	r_PtxRegister203 =
		ShuffleIdxPredicate(r_bPtxPredicate279, r_PtxRegister47, r_PtxRegister1776, 31, -1); // PTX L4414
	r_PtxRegister204 =
		ShuffleIdxPredicate(r_bPtxPredicate280, r_PtxRegister62, r_PtxRegister1776, 31, -1); // PTX L4415
	r_PtxRegister205 =
		ShuffleIdxPredicate(r_bPtxPredicate281, r_PtxRegister63, r_PtxRegister1776, 31, -1); // PTX L4416
	if (r_bPtxPredicate277)
	{
		goto L__BB39_154;
	} // PTX L4417
	r_bPtxPredicate282 = uint32_t(r_PtxRegister192) == uint32_t(1); // PTX L4418
	r_PtxRegister2098 = uint32_t(r_PtxRegister203);					// PTX L4419
	if (r_bPtxPredicate282)
	{
		goto L__BB39_154;
	} // PTX L4420
	r_bPtxPredicate283 = uint32_t(r_PtxRegister192) == uint32_t(2);				  // PTX L4421
	r_PtxRegister2098 = r_bPtxPredicate283 ? r_PtxRegister204 : r_PtxRegister205; // PTX L4422
L__BB39_154:																	  // PTX L4423
	r_PackedHalf2AtPtx4425R1777 = HalfAdd(r_PtxRegister2095, r_PtxRegister2096);  // PTX L4425
	r_PackedHalf2AtPtx4429R1778 = HalfAdd(r_PtxRegister2097, r_PtxRegister2098);  // PTX L4429
	r_PackedHalf2AtPtx4433R1779 =
		HalfAdd(r_PackedHalf2AtPtx4425R1777, r_PackedHalf2AtPtx4429R1778); // PTX L4433
	r_PackedHalf2AtPtx4437R1912 =
		HalfMul(r_PackedHalf2AtPtx4433R1779, r_PackedHalf2AtPtx3961R1906);		 // PTX L4437
	r_LaneIndexAtPtx4441 = uint32_t((threadIdx.x & 31u));						 // PTX L4441
	r_PtxRegister1781 = ShiftRight(uint32_t(r_LaneIndexAtPtx4441), uint32_t(2)); // PTX L4443
	r_PtxRegister1782 = r_PtxRegister1781 & 2;									 // PTX L4444
	r_PtxRegister1783 = ShiftRight(uint32_t(r_LaneIndexAtPtx4441), uint32_t(4)); // PTX L4445
	r_PtxRegister1784 = r_PtxRegister1783 & 1;									 // PTX L4446
	r_PtxRegister206 = r_PtxRegister1782 | r_PtxRegister1784;					 // PTX L4447
	r_PtxRegister1785 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4441), uint32_t(1));	 // PTX L4448
	r_PtxRegister1786 = r_PtxRegister1785 & 8;									 // PTX L4449
	r_PtxRegister1787 = r_LaneIndexAtPtx4441 & 3;								 // PTX L4450
	r_PtxRegister207 = r_PtxRegister1786 | r_PtxRegister1787;					 // PTX L4451
	r_PtxRegister2099 =
		ShuffleIdxPredicate(r_bPtxPredicate284, r_PtxRegister78, r_PtxRegister207, 31, -1); // PTX L4452
	r_PtxRegister208 =
		ShuffleIdxPredicate(r_bPtxPredicate285, r_PtxRegister79, r_PtxRegister207, 31, -1); // PTX L4453
	r_PtxRegister209 =
		ShuffleIdxPredicate(r_bPtxPredicate286, r_PtxRegister94, r_PtxRegister207, 31, -1); // PTX L4454
	r_PtxRegister210 =
		ShuffleIdxPredicate(r_bPtxPredicate287, r_PtxRegister95, r_PtxRegister207, 31, -1); // PTX L4455
	r_bPtxPredicate288 = uint32_t(r_PtxRegister206) == uint32_t(0);							// PTX L4456
	if (r_bPtxPredicate288)
	{
		goto L__BB39_157;
	} // PTX L4457
	r_bPtxPredicate289 = uint32_t(r_PtxRegister206) == uint32_t(1); // PTX L4458
	r_PtxRegister2099 = uint32_t(r_PtxRegister208);					// PTX L4459
	if (r_bPtxPredicate289)
	{
		goto L__BB39_157;
	} // PTX L4460
	r_bPtxPredicate290 = uint32_t(r_PtxRegister206) == uint32_t(2);				  // PTX L4461
	r_PtxRegister2099 = r_bPtxPredicate290 ? r_PtxRegister209 : r_PtxRegister210; // PTX L4462
L__BB39_157:																	  // PTX L4463
	r_bPtxPredicate291 = uint32_t(r_PtxRegister206) == uint32_t(0);				  // PTX L4464
	r_PtxRegister1788 = r_PtxRegister207 | 4;									  // PTX L4465
	r_PtxRegister2100 =
		ShuffleIdxPredicate(r_bPtxPredicate292, r_PtxRegister78, r_PtxRegister1788, 31, -1); // PTX L4466
	r_PtxRegister211 =
		ShuffleIdxPredicate(r_bPtxPredicate293, r_PtxRegister79, r_PtxRegister1788, 31, -1); // PTX L4467
	r_PtxRegister212 =
		ShuffleIdxPredicate(r_bPtxPredicate294, r_PtxRegister94, r_PtxRegister1788, 31, -1); // PTX L4468
	r_PtxRegister213 =
		ShuffleIdxPredicate(r_bPtxPredicate295, r_PtxRegister95, r_PtxRegister1788, 31, -1); // PTX L4469
	if (r_bPtxPredicate291)
	{
		goto L__BB39_160;
	} // PTX L4470
	r_bPtxPredicate296 = uint32_t(r_PtxRegister206) == uint32_t(1); // PTX L4471
	r_PtxRegister2100 = uint32_t(r_PtxRegister211);					// PTX L4472
	if (r_bPtxPredicate296)
	{
		goto L__BB39_160;
	} // PTX L4473
	r_bPtxPredicate297 = uint32_t(r_PtxRegister206) == uint32_t(2);				  // PTX L4474
	r_PtxRegister2100 = r_bPtxPredicate297 ? r_PtxRegister212 : r_PtxRegister213; // PTX L4475
L__BB39_160:																	  // PTX L4476
	r_bPtxPredicate298 = uint32_t(r_PtxRegister206) == uint32_t(0);				  // PTX L4477
	r_PtxRegister1789 = r_PtxRegister207 | 16;									  // PTX L4478
	r_PtxRegister2101 =
		ShuffleIdxPredicate(r_bPtxPredicate299, r_PtxRegister78, r_PtxRegister1789, 31, -1); // PTX L4479
	r_PtxRegister214 =
		ShuffleIdxPredicate(r_bPtxPredicate300, r_PtxRegister79, r_PtxRegister1789, 31, -1); // PTX L4480
	r_PtxRegister215 =
		ShuffleIdxPredicate(r_bPtxPredicate301, r_PtxRegister94, r_PtxRegister1789, 31, -1); // PTX L4481
	r_PtxRegister216 =
		ShuffleIdxPredicate(r_bPtxPredicate302, r_PtxRegister95, r_PtxRegister1789, 31, -1); // PTX L4482
	if (r_bPtxPredicate298)
	{
		goto L__BB39_163;
	} // PTX L4483
	r_bPtxPredicate303 = uint32_t(r_PtxRegister206) == uint32_t(1); // PTX L4484
	r_PtxRegister2101 = uint32_t(r_PtxRegister214);					// PTX L4485
	if (r_bPtxPredicate303)
	{
		goto L__BB39_163;
	} // PTX L4486
	r_bPtxPredicate304 = uint32_t(r_PtxRegister206) == uint32_t(2);				  // PTX L4487
	r_PtxRegister2101 = r_bPtxPredicate304 ? r_PtxRegister215 : r_PtxRegister216; // PTX L4488
L__BB39_163:																	  // PTX L4489
	r_bPtxPredicate305 = uint32_t(r_PtxRegister206) == uint32_t(0);				  // PTX L4490
	r_PtxRegister1790 = r_PtxRegister207 | 20;									  // PTX L4491
	r_PtxRegister2102 =
		ShuffleIdxPredicate(r_bPtxPredicate306, r_PtxRegister78, r_PtxRegister1790, 31, -1); // PTX L4492
	r_PtxRegister217 =
		ShuffleIdxPredicate(r_bPtxPredicate307, r_PtxRegister79, r_PtxRegister1790, 31, -1); // PTX L4493
	r_PtxRegister218 =
		ShuffleIdxPredicate(r_bPtxPredicate308, r_PtxRegister94, r_PtxRegister1790, 31, -1); // PTX L4494
	r_PtxRegister219 =
		ShuffleIdxPredicate(r_bPtxPredicate309, r_PtxRegister95, r_PtxRegister1790, 31, -1); // PTX L4495
	if (r_bPtxPredicate305)
	{
		goto L__BB39_166;
	} // PTX L4496
	r_bPtxPredicate310 = uint32_t(r_PtxRegister206) == uint32_t(1); // PTX L4497
	r_PtxRegister2102 = uint32_t(r_PtxRegister217);					// PTX L4498
	if (r_bPtxPredicate310)
	{
		goto L__BB39_166;
	} // PTX L4499
	r_bPtxPredicate311 = uint32_t(r_PtxRegister206) == uint32_t(2);				  // PTX L4500
	r_PtxRegister2102 = r_bPtxPredicate311 ? r_PtxRegister218 : r_PtxRegister219; // PTX L4501
L__BB39_166:																	  // PTX L4502
	r_PackedHalf2AtPtx4504R1791 = HalfAdd(r_PtxRegister2099, r_PtxRegister2100);  // PTX L4504
	r_PackedHalf2AtPtx4508R1792 = HalfAdd(r_PtxRegister2101, r_PtxRegister2102);  // PTX L4508
	r_PackedHalf2AtPtx4512R1793 =
		HalfAdd(r_PackedHalf2AtPtx4504R1791, r_PackedHalf2AtPtx4508R1792); // PTX L4512
	r_PackedHalf2AtPtx4516R1914 =
		HalfMul(r_PackedHalf2AtPtx4512R1793, r_PackedHalf2AtPtx3961R1906);		 // PTX L4516
	r_LaneIndexAtPtx4520 = uint32_t((threadIdx.x & 31u));						 // PTX L4520
	r_PtxRegister1795 = ShiftRight(uint32_t(r_LaneIndexAtPtx4520), uint32_t(2)); // PTX L4522
	r_PtxRegister1796 = r_PtxRegister1795 & 2;									 // PTX L4523
	r_PtxRegister1797 = ShiftRight(uint32_t(r_LaneIndexAtPtx4520), uint32_t(4)); // PTX L4524
	r_PtxRegister1798 = r_PtxRegister1797 & 1;									 // PTX L4525
	r_PtxRegister220 = r_PtxRegister1796 | r_PtxRegister1798;					 // PTX L4526
	r_PtxRegister1799 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4520), uint32_t(1));	 // PTX L4527
	r_PtxRegister1800 = r_PtxRegister1799 & 8;									 // PTX L4528
	r_PtxRegister1801 = r_LaneIndexAtPtx4520 & 3;								 // PTX L4529
	r_PtxRegister221 = r_PtxRegister1800 | r_PtxRegister1801;					 // PTX L4530
	r_PtxRegister2103 =
		ShuffleIdxPredicate(r_bPtxPredicate312, r_PtxRegister48, r_PtxRegister221, 31, -1); // PTX L4531
	r_PtxRegister222 =
		ShuffleIdxPredicate(r_bPtxPredicate313, r_PtxRegister49, r_PtxRegister221, 31, -1); // PTX L4532
	r_PtxRegister223 =
		ShuffleIdxPredicate(r_bPtxPredicate314, r_PtxRegister64, r_PtxRegister221, 31, -1); // PTX L4533
	r_PtxRegister224 =
		ShuffleIdxPredicate(r_bPtxPredicate315, r_PtxRegister65, r_PtxRegister221, 31, -1); // PTX L4534
	r_bPtxPredicate316 = uint32_t(r_PtxRegister220) == uint32_t(0);							// PTX L4535
	if (r_bPtxPredicate316)
	{
		goto L__BB39_169;
	} // PTX L4536
	r_bPtxPredicate317 = uint32_t(r_PtxRegister220) == uint32_t(1); // PTX L4537
	r_PtxRegister2103 = uint32_t(r_PtxRegister222);					// PTX L4538
	if (r_bPtxPredicate317)
	{
		goto L__BB39_169;
	} // PTX L4539
	r_bPtxPredicate318 = uint32_t(r_PtxRegister220) == uint32_t(2);				  // PTX L4540
	r_PtxRegister2103 = r_bPtxPredicate318 ? r_PtxRegister223 : r_PtxRegister224; // PTX L4541
L__BB39_169:																	  // PTX L4542
	r_bPtxPredicate319 = uint32_t(r_PtxRegister220) == uint32_t(0);				  // PTX L4543
	r_PtxRegister1802 = r_PtxRegister221 | 4;									  // PTX L4544
	r_PtxRegister2104 =
		ShuffleIdxPredicate(r_bPtxPredicate320, r_PtxRegister48, r_PtxRegister1802, 31, -1); // PTX L4545
	r_PtxRegister225 =
		ShuffleIdxPredicate(r_bPtxPredicate321, r_PtxRegister49, r_PtxRegister1802, 31, -1); // PTX L4546
	r_PtxRegister226 =
		ShuffleIdxPredicate(r_bPtxPredicate322, r_PtxRegister64, r_PtxRegister1802, 31, -1); // PTX L4547
	r_PtxRegister227 =
		ShuffleIdxPredicate(r_bPtxPredicate323, r_PtxRegister65, r_PtxRegister1802, 31, -1); // PTX L4548
	if (r_bPtxPredicate319)
	{
		goto L__BB39_172;
	} // PTX L4549
	r_bPtxPredicate324 = uint32_t(r_PtxRegister220) == uint32_t(1); // PTX L4550
	r_PtxRegister2104 = uint32_t(r_PtxRegister225);					// PTX L4551
	if (r_bPtxPredicate324)
	{
		goto L__BB39_172;
	} // PTX L4552
	r_bPtxPredicate325 = uint32_t(r_PtxRegister220) == uint32_t(2);				  // PTX L4553
	r_PtxRegister2104 = r_bPtxPredicate325 ? r_PtxRegister226 : r_PtxRegister227; // PTX L4554
L__BB39_172:																	  // PTX L4555
	r_bPtxPredicate326 = uint32_t(r_PtxRegister220) == uint32_t(0);				  // PTX L4556
	r_PtxRegister1803 = r_PtxRegister221 | 16;									  // PTX L4557
	r_PtxRegister2105 =
		ShuffleIdxPredicate(r_bPtxPredicate327, r_PtxRegister48, r_PtxRegister1803, 31, -1); // PTX L4558
	r_PtxRegister228 =
		ShuffleIdxPredicate(r_bPtxPredicate328, r_PtxRegister49, r_PtxRegister1803, 31, -1); // PTX L4559
	r_PtxRegister229 =
		ShuffleIdxPredicate(r_bPtxPredicate329, r_PtxRegister64, r_PtxRegister1803, 31, -1); // PTX L4560
	r_PtxRegister230 =
		ShuffleIdxPredicate(r_bPtxPredicate330, r_PtxRegister65, r_PtxRegister1803, 31, -1); // PTX L4561
	if (r_bPtxPredicate326)
	{
		goto L__BB39_175;
	} // PTX L4562
	r_bPtxPredicate331 = uint32_t(r_PtxRegister220) == uint32_t(1); // PTX L4563
	r_PtxRegister2105 = uint32_t(r_PtxRegister228);					// PTX L4564
	if (r_bPtxPredicate331)
	{
		goto L__BB39_175;
	} // PTX L4565
	r_bPtxPredicate332 = uint32_t(r_PtxRegister220) == uint32_t(2);				  // PTX L4566
	r_PtxRegister2105 = r_bPtxPredicate332 ? r_PtxRegister229 : r_PtxRegister230; // PTX L4567
L__BB39_175:																	  // PTX L4568
	r_bPtxPredicate333 = uint32_t(r_PtxRegister220) == uint32_t(0);				  // PTX L4569
	r_PtxRegister1804 = r_PtxRegister221 | 20;									  // PTX L4570
	r_PtxRegister2106 =
		ShuffleIdxPredicate(r_bPtxPredicate334, r_PtxRegister48, r_PtxRegister1804, 31, -1); // PTX L4571
	r_PtxRegister231 =
		ShuffleIdxPredicate(r_bPtxPredicate335, r_PtxRegister49, r_PtxRegister1804, 31, -1); // PTX L4572
	r_PtxRegister232 =
		ShuffleIdxPredicate(r_bPtxPredicate336, r_PtxRegister64, r_PtxRegister1804, 31, -1); // PTX L4573
	r_PtxRegister233 =
		ShuffleIdxPredicate(r_bPtxPredicate337, r_PtxRegister65, r_PtxRegister1804, 31, -1); // PTX L4574
	if (r_bPtxPredicate333)
	{
		goto L__BB39_178;
	} // PTX L4575
	r_bPtxPredicate338 = uint32_t(r_PtxRegister220) == uint32_t(1); // PTX L4576
	r_PtxRegister2106 = uint32_t(r_PtxRegister231);					// PTX L4577
	if (r_bPtxPredicate338)
	{
		goto L__BB39_178;
	} // PTX L4578
	r_bPtxPredicate339 = uint32_t(r_PtxRegister220) == uint32_t(2);				  // PTX L4579
	r_PtxRegister2106 = r_bPtxPredicate339 ? r_PtxRegister232 : r_PtxRegister233; // PTX L4580
L__BB39_178:																	  // PTX L4581
	r_PackedHalf2AtPtx4583R1805 = HalfAdd(r_PtxRegister2103, r_PtxRegister2104);  // PTX L4583
	r_PackedHalf2AtPtx4587R1806 = HalfAdd(r_PtxRegister2105, r_PtxRegister2106);  // PTX L4587
	r_PackedHalf2AtPtx4591R1807 =
		HalfAdd(r_PackedHalf2AtPtx4583R1805, r_PackedHalf2AtPtx4587R1806); // PTX L4591
	r_PackedHalf2AtPtx4595R1915 =
		HalfMul(r_PackedHalf2AtPtx4591R1807, r_PackedHalf2AtPtx3961R1906);		 // PTX L4595
	r_LaneIndexAtPtx4599 = uint32_t((threadIdx.x & 31u));						 // PTX L4599
	r_PtxRegister1809 = ShiftRight(uint32_t(r_LaneIndexAtPtx4599), uint32_t(2)); // PTX L4601
	r_PtxRegister1810 = r_PtxRegister1809 & 2;									 // PTX L4602
	r_PtxRegister1811 = ShiftRight(uint32_t(r_LaneIndexAtPtx4599), uint32_t(4)); // PTX L4603
	r_PtxRegister1812 = r_PtxRegister1811 & 1;									 // PTX L4604
	r_PtxRegister234 = r_PtxRegister1810 | r_PtxRegister1812;					 // PTX L4605
	r_PtxRegister1813 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4599), uint32_t(1));	 // PTX L4606
	r_PtxRegister1814 = r_PtxRegister1813 & 8;									 // PTX L4607
	r_PtxRegister1815 = r_LaneIndexAtPtx4599 & 3;								 // PTX L4608
	r_PtxRegister235 = r_PtxRegister1814 | r_PtxRegister1815;					 // PTX L4609
	r_PtxRegister2107 =
		ShuffleIdxPredicate(r_bPtxPredicate340, r_PtxRegister80, r_PtxRegister235, 31, -1); // PTX L4610
	r_PtxRegister236 =
		ShuffleIdxPredicate(r_bPtxPredicate341, r_PtxRegister81, r_PtxRegister235, 31, -1); // PTX L4611
	r_PtxRegister237 =
		ShuffleIdxPredicate(r_bPtxPredicate342, r_PtxRegister96, r_PtxRegister235, 31, -1); // PTX L4612
	r_PtxRegister238 =
		ShuffleIdxPredicate(r_bPtxPredicate343, r_PtxRegister97, r_PtxRegister235, 31, -1); // PTX L4613
	r_bPtxPredicate344 = uint32_t(r_PtxRegister234) == uint32_t(0);							// PTX L4614
	if (r_bPtxPredicate344)
	{
		goto L__BB39_181;
	} // PTX L4615
	r_bPtxPredicate345 = uint32_t(r_PtxRegister234) == uint32_t(1); // PTX L4616
	r_PtxRegister2107 = uint32_t(r_PtxRegister236);					// PTX L4617
	if (r_bPtxPredicate345)
	{
		goto L__BB39_181;
	} // PTX L4618
	r_bPtxPredicate346 = uint32_t(r_PtxRegister234) == uint32_t(2);				  // PTX L4619
	r_PtxRegister2107 = r_bPtxPredicate346 ? r_PtxRegister237 : r_PtxRegister238; // PTX L4620
L__BB39_181:																	  // PTX L4621
	r_bPtxPredicate347 = uint32_t(r_PtxRegister234) == uint32_t(0);				  // PTX L4622
	r_PtxRegister1816 = r_PtxRegister235 | 4;									  // PTX L4623
	r_PtxRegister2108 =
		ShuffleIdxPredicate(r_bPtxPredicate348, r_PtxRegister80, r_PtxRegister1816, 31, -1); // PTX L4624
	r_PtxRegister239 =
		ShuffleIdxPredicate(r_bPtxPredicate349, r_PtxRegister81, r_PtxRegister1816, 31, -1); // PTX L4625
	r_PtxRegister240 =
		ShuffleIdxPredicate(r_bPtxPredicate350, r_PtxRegister96, r_PtxRegister1816, 31, -1); // PTX L4626
	r_PtxRegister241 =
		ShuffleIdxPredicate(r_bPtxPredicate351, r_PtxRegister97, r_PtxRegister1816, 31, -1); // PTX L4627
	if (r_bPtxPredicate347)
	{
		goto L__BB39_184;
	} // PTX L4628
	r_bPtxPredicate352 = uint32_t(r_PtxRegister234) == uint32_t(1); // PTX L4629
	r_PtxRegister2108 = uint32_t(r_PtxRegister239);					// PTX L4630
	if (r_bPtxPredicate352)
	{
		goto L__BB39_184;
	} // PTX L4631
	r_bPtxPredicate353 = uint32_t(r_PtxRegister234) == uint32_t(2);				  // PTX L4632
	r_PtxRegister2108 = r_bPtxPredicate353 ? r_PtxRegister240 : r_PtxRegister241; // PTX L4633
L__BB39_184:																	  // PTX L4634
	r_bPtxPredicate354 = uint32_t(r_PtxRegister234) == uint32_t(0);				  // PTX L4635
	r_PtxRegister1817 = r_PtxRegister235 | 16;									  // PTX L4636
	r_PtxRegister2109 =
		ShuffleIdxPredicate(r_bPtxPredicate355, r_PtxRegister80, r_PtxRegister1817, 31, -1); // PTX L4637
	r_PtxRegister242 =
		ShuffleIdxPredicate(r_bPtxPredicate356, r_PtxRegister81, r_PtxRegister1817, 31, -1); // PTX L4638
	r_PtxRegister243 =
		ShuffleIdxPredicate(r_bPtxPredicate357, r_PtxRegister96, r_PtxRegister1817, 31, -1); // PTX L4639
	r_PtxRegister244 =
		ShuffleIdxPredicate(r_bPtxPredicate358, r_PtxRegister97, r_PtxRegister1817, 31, -1); // PTX L4640
	if (r_bPtxPredicate354)
	{
		goto L__BB39_187;
	} // PTX L4641
	r_bPtxPredicate359 = uint32_t(r_PtxRegister234) == uint32_t(1); // PTX L4642
	r_PtxRegister2109 = uint32_t(r_PtxRegister242);					// PTX L4643
	if (r_bPtxPredicate359)
	{
		goto L__BB39_187;
	} // PTX L4644
	r_bPtxPredicate360 = uint32_t(r_PtxRegister234) == uint32_t(2);				  // PTX L4645
	r_PtxRegister2109 = r_bPtxPredicate360 ? r_PtxRegister243 : r_PtxRegister244; // PTX L4646
L__BB39_187:																	  // PTX L4647
	r_bPtxPredicate361 = uint32_t(r_PtxRegister234) == uint32_t(0);				  // PTX L4648
	r_PtxRegister1818 = r_PtxRegister235 | 20;									  // PTX L4649
	r_PtxRegister2110 =
		ShuffleIdxPredicate(r_bPtxPredicate362, r_PtxRegister80, r_PtxRegister1818, 31, -1); // PTX L4650
	r_PtxRegister245 =
		ShuffleIdxPredicate(r_bPtxPredicate363, r_PtxRegister81, r_PtxRegister1818, 31, -1); // PTX L4651
	r_PtxRegister246 =
		ShuffleIdxPredicate(r_bPtxPredicate364, r_PtxRegister96, r_PtxRegister1818, 31, -1); // PTX L4652
	r_PtxRegister247 =
		ShuffleIdxPredicate(r_bPtxPredicate365, r_PtxRegister97, r_PtxRegister1818, 31, -1); // PTX L4653
	if (r_bPtxPredicate361)
	{
		goto L__BB39_190;
	} // PTX L4654
	r_bPtxPredicate366 = uint32_t(r_PtxRegister234) == uint32_t(1); // PTX L4655
	r_PtxRegister2110 = uint32_t(r_PtxRegister245);					// PTX L4656
	if (r_bPtxPredicate366)
	{
		goto L__BB39_190;
	} // PTX L4657
	r_bPtxPredicate367 = uint32_t(r_PtxRegister234) == uint32_t(2);				  // PTX L4658
	r_PtxRegister2110 = r_bPtxPredicate367 ? r_PtxRegister246 : r_PtxRegister247; // PTX L4659
L__BB39_190:																	  // PTX L4660
	r_PackedHalf2AtPtx4662R1819 = HalfAdd(r_PtxRegister2107, r_PtxRegister2108);  // PTX L4662
	r_PackedHalf2AtPtx4666R1820 = HalfAdd(r_PtxRegister2109, r_PtxRegister2110);  // PTX L4666
	r_PackedHalf2AtPtx4670R1821 =
		HalfAdd(r_PackedHalf2AtPtx4662R1819, r_PackedHalf2AtPtx4666R1820); // PTX L4670
	r_PackedHalf2AtPtx4674R1917 =
		HalfMul(r_PackedHalf2AtPtx4670R1821, r_PackedHalf2AtPtx3961R1906);		 // PTX L4674
	r_LaneIndexAtPtx4678 = uint32_t((threadIdx.x & 31u));						 // PTX L4678
	r_PtxRegister1823 = ShiftRight(uint32_t(r_LaneIndexAtPtx4678), uint32_t(2)); // PTX L4680
	r_PtxRegister1824 = r_PtxRegister1823 & 2;									 // PTX L4681
	r_PtxRegister1825 = ShiftRight(uint32_t(r_LaneIndexAtPtx4678), uint32_t(4)); // PTX L4682
	r_PtxRegister1826 = r_PtxRegister1825 & 1;									 // PTX L4683
	r_PtxRegister248 = r_PtxRegister1824 | r_PtxRegister1826;					 // PTX L4684
	r_PtxRegister1827 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4678), uint32_t(1));	 // PTX L4685
	r_PtxRegister1828 = r_PtxRegister1827 & 8;									 // PTX L4686
	r_PtxRegister1829 = r_LaneIndexAtPtx4678 & 3;								 // PTX L4687
	r_PtxRegister249 = r_PtxRegister1828 | r_PtxRegister1829;					 // PTX L4688
	r_PtxRegister2111 =
		ShuffleIdxPredicate(r_bPtxPredicate368, r_PtxRegister50, r_PtxRegister249, 31, -1); // PTX L4689
	r_PtxRegister250 =
		ShuffleIdxPredicate(r_bPtxPredicate369, r_PtxRegister51, r_PtxRegister249, 31, -1); // PTX L4690
	r_PtxRegister251 =
		ShuffleIdxPredicate(r_bPtxPredicate370, r_PtxRegister66, r_PtxRegister249, 31, -1); // PTX L4691
	r_PtxRegister252 =
		ShuffleIdxPredicate(r_bPtxPredicate371, r_PtxRegister67, r_PtxRegister249, 31, -1); // PTX L4692
	r_bPtxPredicate372 = uint32_t(r_PtxRegister248) == uint32_t(0);							// PTX L4693
	if (r_bPtxPredicate372)
	{
		goto L__BB39_193;
	} // PTX L4694
	r_bPtxPredicate373 = uint32_t(r_PtxRegister248) == uint32_t(1); // PTX L4695
	r_PtxRegister2111 = uint32_t(r_PtxRegister250);					// PTX L4696
	if (r_bPtxPredicate373)
	{
		goto L__BB39_193;
	} // PTX L4697
	r_bPtxPredicate374 = uint32_t(r_PtxRegister248) == uint32_t(2);				  // PTX L4698
	r_PtxRegister2111 = r_bPtxPredicate374 ? r_PtxRegister251 : r_PtxRegister252; // PTX L4699
L__BB39_193:																	  // PTX L4700
	r_bPtxPredicate375 = uint32_t(r_PtxRegister248) == uint32_t(0);				  // PTX L4701
	r_PtxRegister1830 = r_PtxRegister249 | 4;									  // PTX L4702
	r_PtxRegister2112 =
		ShuffleIdxPredicate(r_bPtxPredicate376, r_PtxRegister50, r_PtxRegister1830, 31, -1); // PTX L4703
	r_PtxRegister253 =
		ShuffleIdxPredicate(r_bPtxPredicate377, r_PtxRegister51, r_PtxRegister1830, 31, -1); // PTX L4704
	r_PtxRegister254 =
		ShuffleIdxPredicate(r_bPtxPredicate378, r_PtxRegister66, r_PtxRegister1830, 31, -1); // PTX L4705
	r_PtxRegister255 =
		ShuffleIdxPredicate(r_bPtxPredicate379, r_PtxRegister67, r_PtxRegister1830, 31, -1); // PTX L4706
	if (r_bPtxPredicate375)
	{
		goto L__BB39_196;
	} // PTX L4707
	r_bPtxPredicate380 = uint32_t(r_PtxRegister248) == uint32_t(1); // PTX L4708
	r_PtxRegister2112 = uint32_t(r_PtxRegister253);					// PTX L4709
	if (r_bPtxPredicate380)
	{
		goto L__BB39_196;
	} // PTX L4710
	r_bPtxPredicate381 = uint32_t(r_PtxRegister248) == uint32_t(2);				  // PTX L4711
	r_PtxRegister2112 = r_bPtxPredicate381 ? r_PtxRegister254 : r_PtxRegister255; // PTX L4712
L__BB39_196:																	  // PTX L4713
	r_bPtxPredicate382 = uint32_t(r_PtxRegister248) == uint32_t(0);				  // PTX L4714
	r_PtxRegister1831 = r_PtxRegister249 | 16;									  // PTX L4715
	r_PtxRegister2113 =
		ShuffleIdxPredicate(r_bPtxPredicate383, r_PtxRegister50, r_PtxRegister1831, 31, -1); // PTX L4716
	r_PtxRegister256 =
		ShuffleIdxPredicate(r_bPtxPredicate384, r_PtxRegister51, r_PtxRegister1831, 31, -1); // PTX L4717
	r_PtxRegister257 =
		ShuffleIdxPredicate(r_bPtxPredicate385, r_PtxRegister66, r_PtxRegister1831, 31, -1); // PTX L4718
	r_PtxRegister258 =
		ShuffleIdxPredicate(r_bPtxPredicate386, r_PtxRegister67, r_PtxRegister1831, 31, -1); // PTX L4719
	if (r_bPtxPredicate382)
	{
		goto L__BB39_199;
	} // PTX L4720
	r_bPtxPredicate387 = uint32_t(r_PtxRegister248) == uint32_t(1); // PTX L4721
	r_PtxRegister2113 = uint32_t(r_PtxRegister256);					// PTX L4722
	if (r_bPtxPredicate387)
	{
		goto L__BB39_199;
	} // PTX L4723
	r_bPtxPredicate388 = uint32_t(r_PtxRegister248) == uint32_t(2);				  // PTX L4724
	r_PtxRegister2113 = r_bPtxPredicate388 ? r_PtxRegister257 : r_PtxRegister258; // PTX L4725
L__BB39_199:																	  // PTX L4726
	r_bPtxPredicate389 = uint32_t(r_PtxRegister248) == uint32_t(0);				  // PTX L4727
	r_PtxRegister1832 = r_PtxRegister249 | 20;									  // PTX L4728
	r_PtxRegister2114 =
		ShuffleIdxPredicate(r_bPtxPredicate390, r_PtxRegister50, r_PtxRegister1832, 31, -1); // PTX L4729
	r_PtxRegister259 =
		ShuffleIdxPredicate(r_bPtxPredicate391, r_PtxRegister51, r_PtxRegister1832, 31, -1); // PTX L4730
	r_PtxRegister260 =
		ShuffleIdxPredicate(r_bPtxPredicate392, r_PtxRegister66, r_PtxRegister1832, 31, -1); // PTX L4731
	r_PtxRegister261 =
		ShuffleIdxPredicate(r_bPtxPredicate393, r_PtxRegister67, r_PtxRegister1832, 31, -1); // PTX L4732
	if (r_bPtxPredicate389)
	{
		goto L__BB39_202;
	} // PTX L4733
	r_bPtxPredicate394 = uint32_t(r_PtxRegister248) == uint32_t(1); // PTX L4734
	r_PtxRegister2114 = uint32_t(r_PtxRegister259);					// PTX L4735
	if (r_bPtxPredicate394)
	{
		goto L__BB39_202;
	} // PTX L4736
	r_bPtxPredicate395 = uint32_t(r_PtxRegister248) == uint32_t(2);				  // PTX L4737
	r_PtxRegister2114 = r_bPtxPredicate395 ? r_PtxRegister260 : r_PtxRegister261; // PTX L4738
L__BB39_202:																	  // PTX L4739
	r_PackedHalf2AtPtx4741R1833 = HalfAdd(r_PtxRegister2111, r_PtxRegister2112);  // PTX L4741
	r_PackedHalf2AtPtx4745R1834 = HalfAdd(r_PtxRegister2113, r_PtxRegister2114);  // PTX L4745
	r_PackedHalf2AtPtx4749R1835 =
		HalfAdd(r_PackedHalf2AtPtx4741R1833, r_PackedHalf2AtPtx4745R1834); // PTX L4749
	r_PackedHalf2AtPtx4753R1916 =
		HalfMul(r_PackedHalf2AtPtx4749R1835, r_PackedHalf2AtPtx3961R1906);		 // PTX L4753
	r_LaneIndexAtPtx4757 = uint32_t((threadIdx.x & 31u));						 // PTX L4757
	r_PtxRegister1837 = ShiftRight(uint32_t(r_LaneIndexAtPtx4757), uint32_t(2)); // PTX L4759
	r_PtxRegister1838 = r_PtxRegister1837 & 2;									 // PTX L4760
	r_PtxRegister1839 = ShiftRight(uint32_t(r_LaneIndexAtPtx4757), uint32_t(4)); // PTX L4761
	r_PtxRegister1840 = r_PtxRegister1839 & 1;									 // PTX L4762
	r_PtxRegister262 = r_PtxRegister1838 | r_PtxRegister1840;					 // PTX L4763
	r_PtxRegister1841 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4757), uint32_t(1));	 // PTX L4764
	r_PtxRegister1842 = r_PtxRegister1841 & 8;									 // PTX L4765
	r_PtxRegister1843 = r_LaneIndexAtPtx4757 & 3;								 // PTX L4766
	r_PtxRegister263 = r_PtxRegister1842 | r_PtxRegister1843;					 // PTX L4767
	r_PtxRegister2115 =
		ShuffleIdxPredicate(r_bPtxPredicate396, r_PtxRegister82, r_PtxRegister263, 31, -1); // PTX L4768
	r_PtxRegister264 =
		ShuffleIdxPredicate(r_bPtxPredicate397, r_PtxRegister83, r_PtxRegister263, 31, -1); // PTX L4769
	r_PtxRegister265 =
		ShuffleIdxPredicate(r_bPtxPredicate398, r_PtxRegister98, r_PtxRegister263, 31, -1); // PTX L4770
	r_PtxRegister266 =
		ShuffleIdxPredicate(r_bPtxPredicate399, r_PtxRegister99, r_PtxRegister263, 31, -1); // PTX L4771
	r_bPtxPredicate400 = uint32_t(r_PtxRegister262) == uint32_t(0);							// PTX L4772
	if (r_bPtxPredicate400)
	{
		goto L__BB39_205;
	} // PTX L4773
	r_bPtxPredicate401 = uint32_t(r_PtxRegister262) == uint32_t(1); // PTX L4774
	r_PtxRegister2115 = uint32_t(r_PtxRegister264);					// PTX L4775
	if (r_bPtxPredicate401)
	{
		goto L__BB39_205;
	} // PTX L4776
	r_bPtxPredicate402 = uint32_t(r_PtxRegister262) == uint32_t(2);				  // PTX L4777
	r_PtxRegister2115 = r_bPtxPredicate402 ? r_PtxRegister265 : r_PtxRegister266; // PTX L4778
L__BB39_205:																	  // PTX L4779
	r_bPtxPredicate403 = uint32_t(r_PtxRegister262) == uint32_t(0);				  // PTX L4780
	r_PtxRegister1844 = r_PtxRegister263 | 4;									  // PTX L4781
	r_PtxRegister2116 =
		ShuffleIdxPredicate(r_bPtxPredicate404, r_PtxRegister82, r_PtxRegister1844, 31, -1); // PTX L4782
	r_PtxRegister267 =
		ShuffleIdxPredicate(r_bPtxPredicate405, r_PtxRegister83, r_PtxRegister1844, 31, -1); // PTX L4783
	r_PtxRegister268 =
		ShuffleIdxPredicate(r_bPtxPredicate406, r_PtxRegister98, r_PtxRegister1844, 31, -1); // PTX L4784
	r_PtxRegister269 =
		ShuffleIdxPredicate(r_bPtxPredicate407, r_PtxRegister99, r_PtxRegister1844, 31, -1); // PTX L4785
	if (r_bPtxPredicate403)
	{
		goto L__BB39_208;
	} // PTX L4786
	r_bPtxPredicate408 = uint32_t(r_PtxRegister262) == uint32_t(1); // PTX L4787
	r_PtxRegister2116 = uint32_t(r_PtxRegister267);					// PTX L4788
	if (r_bPtxPredicate408)
	{
		goto L__BB39_208;
	} // PTX L4789
	r_bPtxPredicate409 = uint32_t(r_PtxRegister262) == uint32_t(2);				  // PTX L4790
	r_PtxRegister2116 = r_bPtxPredicate409 ? r_PtxRegister268 : r_PtxRegister269; // PTX L4791
L__BB39_208:																	  // PTX L4792
	r_bPtxPredicate410 = uint32_t(r_PtxRegister262) == uint32_t(0);				  // PTX L4793
	r_PtxRegister1845 = r_PtxRegister263 | 16;									  // PTX L4794
	r_PtxRegister2117 =
		ShuffleIdxPredicate(r_bPtxPredicate411, r_PtxRegister82, r_PtxRegister1845, 31, -1); // PTX L4795
	r_PtxRegister270 =
		ShuffleIdxPredicate(r_bPtxPredicate412, r_PtxRegister83, r_PtxRegister1845, 31, -1); // PTX L4796
	r_PtxRegister271 =
		ShuffleIdxPredicate(r_bPtxPredicate413, r_PtxRegister98, r_PtxRegister1845, 31, -1); // PTX L4797
	r_PtxRegister272 =
		ShuffleIdxPredicate(r_bPtxPredicate414, r_PtxRegister99, r_PtxRegister1845, 31, -1); // PTX L4798
	if (r_bPtxPredicate410)
	{
		goto L__BB39_211;
	} // PTX L4799
	r_bPtxPredicate415 = uint32_t(r_PtxRegister262) == uint32_t(1); // PTX L4800
	r_PtxRegister2117 = uint32_t(r_PtxRegister270);					// PTX L4801
	if (r_bPtxPredicate415)
	{
		goto L__BB39_211;
	} // PTX L4802
	r_bPtxPredicate416 = uint32_t(r_PtxRegister262) == uint32_t(2);				  // PTX L4803
	r_PtxRegister2117 = r_bPtxPredicate416 ? r_PtxRegister271 : r_PtxRegister272; // PTX L4804
L__BB39_211:																	  // PTX L4805
	r_bPtxPredicate417 = uint32_t(r_PtxRegister262) == uint32_t(0);				  // PTX L4806
	r_PtxRegister1846 = r_PtxRegister263 | 20;									  // PTX L4807
	r_PtxRegister2118 =
		ShuffleIdxPredicate(r_bPtxPredicate418, r_PtxRegister82, r_PtxRegister1846, 31, -1); // PTX L4808
	r_PtxRegister273 =
		ShuffleIdxPredicate(r_bPtxPredicate419, r_PtxRegister83, r_PtxRegister1846, 31, -1); // PTX L4809
	r_PtxRegister274 =
		ShuffleIdxPredicate(r_bPtxPredicate420, r_PtxRegister98, r_PtxRegister1846, 31, -1); // PTX L4810
	r_PtxRegister275 =
		ShuffleIdxPredicate(r_bPtxPredicate421, r_PtxRegister99, r_PtxRegister1846, 31, -1); // PTX L4811
	if (r_bPtxPredicate417)
	{
		goto L__BB39_214;
	} // PTX L4812
	r_bPtxPredicate422 = uint32_t(r_PtxRegister262) == uint32_t(1); // PTX L4813
	r_PtxRegister2118 = uint32_t(r_PtxRegister273);					// PTX L4814
	if (r_bPtxPredicate422)
	{
		goto L__BB39_214;
	} // PTX L4815
	r_bPtxPredicate423 = uint32_t(r_PtxRegister262) == uint32_t(2);				  // PTX L4816
	r_PtxRegister2118 = r_bPtxPredicate423 ? r_PtxRegister274 : r_PtxRegister275; // PTX L4817
L__BB39_214:																	  // PTX L4818
	r_PackedHalf2AtPtx4820R1847 = HalfAdd(r_PtxRegister2115, r_PtxRegister2116);  // PTX L4820
	r_PackedHalf2AtPtx4824R1848 = HalfAdd(r_PtxRegister2117, r_PtxRegister2118);  // PTX L4824
	r_PackedHalf2AtPtx4828R1849 =
		HalfAdd(r_PackedHalf2AtPtx4820R1847, r_PackedHalf2AtPtx4824R1848); // PTX L4828
	r_PackedHalf2AtPtx4832R1918 =
		HalfMul(r_PackedHalf2AtPtx4828R1849, r_PackedHalf2AtPtx3961R1906);		 // PTX L4832
	r_LaneIndexAtPtx4836 = uint32_t((threadIdx.x & 31u));						 // PTX L4836
	r_PtxRegister1851 = ShiftRight(uint32_t(r_LaneIndexAtPtx4836), uint32_t(2)); // PTX L4838
	r_PtxRegister1852 = r_PtxRegister1851 & 2;									 // PTX L4839
	r_PtxRegister1853 = ShiftRight(uint32_t(r_LaneIndexAtPtx4836), uint32_t(4)); // PTX L4840
	r_PtxRegister1854 = r_PtxRegister1853 & 1;									 // PTX L4841
	r_PtxRegister276 = r_PtxRegister1852 | r_PtxRegister1854;					 // PTX L4842
	r_PtxRegister1855 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4836), uint32_t(1));	 // PTX L4843
	r_PtxRegister1856 = r_PtxRegister1855 & 8;									 // PTX L4844
	r_PtxRegister1857 = r_LaneIndexAtPtx4836 & 3;								 // PTX L4845
	r_PtxRegister277 = r_PtxRegister1856 | r_PtxRegister1857;					 // PTX L4846
	r_PtxRegister2119 =
		ShuffleIdxPredicate(r_bPtxPredicate424, r_PtxRegister52, r_PtxRegister277, 31, -1); // PTX L4847
	r_PtxRegister278 =
		ShuffleIdxPredicate(r_bPtxPredicate425, r_PtxRegister53, r_PtxRegister277, 31, -1); // PTX L4848
	r_PtxRegister279 =
		ShuffleIdxPredicate(r_bPtxPredicate426, r_PtxRegister68, r_PtxRegister277, 31, -1); // PTX L4849
	r_PtxRegister280 =
		ShuffleIdxPredicate(r_bPtxPredicate427, r_PtxRegister69, r_PtxRegister277, 31, -1); // PTX L4850
	r_bPtxPredicate428 = uint32_t(r_PtxRegister276) == uint32_t(0);							// PTX L4851
	if (r_bPtxPredicate428)
	{
		goto L__BB39_217;
	} // PTX L4852
	r_bPtxPredicate429 = uint32_t(r_PtxRegister276) == uint32_t(1); // PTX L4853
	r_PtxRegister2119 = uint32_t(r_PtxRegister278);					// PTX L4854
	if (r_bPtxPredicate429)
	{
		goto L__BB39_217;
	} // PTX L4855
	r_bPtxPredicate430 = uint32_t(r_PtxRegister276) == uint32_t(2);				  // PTX L4856
	r_PtxRegister2119 = r_bPtxPredicate430 ? r_PtxRegister279 : r_PtxRegister280; // PTX L4857
L__BB39_217:																	  // PTX L4858
	r_bPtxPredicate431 = uint32_t(r_PtxRegister276) == uint32_t(0);				  // PTX L4859
	r_PtxRegister1858 = r_PtxRegister277 | 4;									  // PTX L4860
	r_PtxRegister2120 =
		ShuffleIdxPredicate(r_bPtxPredicate432, r_PtxRegister52, r_PtxRegister1858, 31, -1); // PTX L4861
	r_PtxRegister281 =
		ShuffleIdxPredicate(r_bPtxPredicate433, r_PtxRegister53, r_PtxRegister1858, 31, -1); // PTX L4862
	r_PtxRegister282 =
		ShuffleIdxPredicate(r_bPtxPredicate434, r_PtxRegister68, r_PtxRegister1858, 31, -1); // PTX L4863
	r_PtxRegister283 =
		ShuffleIdxPredicate(r_bPtxPredicate435, r_PtxRegister69, r_PtxRegister1858, 31, -1); // PTX L4864
	if (r_bPtxPredicate431)
	{
		goto L__BB39_220;
	} // PTX L4865
	r_bPtxPredicate436 = uint32_t(r_PtxRegister276) == uint32_t(1); // PTX L4866
	r_PtxRegister2120 = uint32_t(r_PtxRegister281);					// PTX L4867
	if (r_bPtxPredicate436)
	{
		goto L__BB39_220;
	} // PTX L4868
	r_bPtxPredicate437 = uint32_t(r_PtxRegister276) == uint32_t(2);				  // PTX L4869
	r_PtxRegister2120 = r_bPtxPredicate437 ? r_PtxRegister282 : r_PtxRegister283; // PTX L4870
L__BB39_220:																	  // PTX L4871
	r_bPtxPredicate438 = uint32_t(r_PtxRegister276) == uint32_t(0);				  // PTX L4872
	r_PtxRegister1859 = r_PtxRegister277 | 16;									  // PTX L4873
	r_PtxRegister2121 =
		ShuffleIdxPredicate(r_bPtxPredicate439, r_PtxRegister52, r_PtxRegister1859, 31, -1); // PTX L4874
	r_PtxRegister284 =
		ShuffleIdxPredicate(r_bPtxPredicate440, r_PtxRegister53, r_PtxRegister1859, 31, -1); // PTX L4875
	r_PtxRegister285 =
		ShuffleIdxPredicate(r_bPtxPredicate441, r_PtxRegister68, r_PtxRegister1859, 31, -1); // PTX L4876
	r_PtxRegister286 =
		ShuffleIdxPredicate(r_bPtxPredicate442, r_PtxRegister69, r_PtxRegister1859, 31, -1); // PTX L4877
	if (r_bPtxPredicate438)
	{
		goto L__BB39_223;
	} // PTX L4878
	r_bPtxPredicate443 = uint32_t(r_PtxRegister276) == uint32_t(1); // PTX L4879
	r_PtxRegister2121 = uint32_t(r_PtxRegister284);					// PTX L4880
	if (r_bPtxPredicate443)
	{
		goto L__BB39_223;
	} // PTX L4881
	r_bPtxPredicate444 = uint32_t(r_PtxRegister276) == uint32_t(2);				  // PTX L4882
	r_PtxRegister2121 = r_bPtxPredicate444 ? r_PtxRegister285 : r_PtxRegister286; // PTX L4883
L__BB39_223:																	  // PTX L4884
	r_bPtxPredicate445 = uint32_t(r_PtxRegister276) == uint32_t(0);				  // PTX L4885
	r_PtxRegister1860 = r_PtxRegister277 | 20;									  // PTX L4886
	r_PtxRegister2122 =
		ShuffleIdxPredicate(r_bPtxPredicate446, r_PtxRegister52, r_PtxRegister1860, 31, -1); // PTX L4887
	r_PtxRegister287 =
		ShuffleIdxPredicate(r_bPtxPredicate447, r_PtxRegister53, r_PtxRegister1860, 31, -1); // PTX L4888
	r_PtxRegister288 =
		ShuffleIdxPredicate(r_bPtxPredicate448, r_PtxRegister68, r_PtxRegister1860, 31, -1); // PTX L4889
	r_PtxRegister289 =
		ShuffleIdxPredicate(r_bPtxPredicate449, r_PtxRegister69, r_PtxRegister1860, 31, -1); // PTX L4890
	if (r_bPtxPredicate445)
	{
		goto L__BB39_226;
	} // PTX L4891
	r_bPtxPredicate450 = uint32_t(r_PtxRegister276) == uint32_t(1); // PTX L4892
	r_PtxRegister2122 = uint32_t(r_PtxRegister287);					// PTX L4893
	if (r_bPtxPredicate450)
	{
		goto L__BB39_226;
	} // PTX L4894
	r_bPtxPredicate451 = uint32_t(r_PtxRegister276) == uint32_t(2);				  // PTX L4895
	r_PtxRegister2122 = r_bPtxPredicate451 ? r_PtxRegister288 : r_PtxRegister289; // PTX L4896
L__BB39_226:																	  // PTX L4897
	r_PackedHalf2AtPtx4899R1861 = HalfAdd(r_PtxRegister2119, r_PtxRegister2120);  // PTX L4899
	r_PackedHalf2AtPtx4903R1862 = HalfAdd(r_PtxRegister2121, r_PtxRegister2122);  // PTX L4903
	r_PackedHalf2AtPtx4907R1863 =
		HalfAdd(r_PackedHalf2AtPtx4899R1861, r_PackedHalf2AtPtx4903R1862); // PTX L4907
	r_PackedHalf2AtPtx4911R1919 =
		HalfMul(r_PackedHalf2AtPtx4907R1863, r_PackedHalf2AtPtx3961R1906);		 // PTX L4911
	r_LaneIndexAtPtx4915 = uint32_t((threadIdx.x & 31u));						 // PTX L4915
	r_PtxRegister1865 = ShiftRight(uint32_t(r_LaneIndexAtPtx4915), uint32_t(2)); // PTX L4917
	r_PtxRegister1866 = r_PtxRegister1865 & 2;									 // PTX L4918
	r_PtxRegister1867 = ShiftRight(uint32_t(r_LaneIndexAtPtx4915), uint32_t(4)); // PTX L4919
	r_PtxRegister1868 = r_PtxRegister1867 & 1;									 // PTX L4920
	r_PtxRegister290 = r_PtxRegister1866 | r_PtxRegister1868;					 // PTX L4921
	r_PtxRegister1869 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4915), uint32_t(1));	 // PTX L4922
	r_PtxRegister1870 = r_PtxRegister1869 & 8;									 // PTX L4923
	r_PtxRegister1871 = r_LaneIndexAtPtx4915 & 3;								 // PTX L4924
	r_PtxRegister291 = r_PtxRegister1870 | r_PtxRegister1871;					 // PTX L4925
	r_PtxRegister2123 =
		ShuffleIdxPredicate(r_bPtxPredicate452, r_PtxRegister84, r_PtxRegister291, 31, -1); // PTX L4926
	r_PtxRegister292 =
		ShuffleIdxPredicate(r_bPtxPredicate453, r_PtxRegister85, r_PtxRegister291, 31, -1); // PTX L4927
	r_PtxRegister293 =
		ShuffleIdxPredicate(r_bPtxPredicate454, r_PtxRegister100, r_PtxRegister291, 31, -1); // PTX L4928
	r_PtxRegister294 =
		ShuffleIdxPredicate(r_bPtxPredicate455, r_PtxRegister101, r_PtxRegister291, 31, -1); // PTX L4929
	r_bPtxPredicate456 = uint32_t(r_PtxRegister290) == uint32_t(0);							 // PTX L4930
	if (r_bPtxPredicate456)
	{
		goto L__BB39_229;
	} // PTX L4931
	r_bPtxPredicate457 = uint32_t(r_PtxRegister290) == uint32_t(1); // PTX L4932
	r_PtxRegister2123 = uint32_t(r_PtxRegister292);					// PTX L4933
	if (r_bPtxPredicate457)
	{
		goto L__BB39_229;
	} // PTX L4934
	r_bPtxPredicate458 = uint32_t(r_PtxRegister290) == uint32_t(2);				  // PTX L4935
	r_PtxRegister2123 = r_bPtxPredicate458 ? r_PtxRegister293 : r_PtxRegister294; // PTX L4936
L__BB39_229:																	  // PTX L4937
	r_bPtxPredicate459 = uint32_t(r_PtxRegister290) == uint32_t(0);				  // PTX L4938
	r_PtxRegister1872 = r_PtxRegister291 | 4;									  // PTX L4939
	r_PtxRegister2124 =
		ShuffleIdxPredicate(r_bPtxPredicate460, r_PtxRegister84, r_PtxRegister1872, 31, -1); // PTX L4940
	r_PtxRegister295 =
		ShuffleIdxPredicate(r_bPtxPredicate461, r_PtxRegister85, r_PtxRegister1872, 31, -1); // PTX L4941
	r_PtxRegister296 =
		ShuffleIdxPredicate(r_bPtxPredicate462, r_PtxRegister100, r_PtxRegister1872, 31, -1); // PTX L4942
	r_PtxRegister297 =
		ShuffleIdxPredicate(r_bPtxPredicate463, r_PtxRegister101, r_PtxRegister1872, 31, -1); // PTX L4943
	if (r_bPtxPredicate459)
	{
		goto L__BB39_232;
	} // PTX L4944
	r_bPtxPredicate464 = uint32_t(r_PtxRegister290) == uint32_t(1); // PTX L4945
	r_PtxRegister2124 = uint32_t(r_PtxRegister295);					// PTX L4946
	if (r_bPtxPredicate464)
	{
		goto L__BB39_232;
	} // PTX L4947
	r_bPtxPredicate465 = uint32_t(r_PtxRegister290) == uint32_t(2);				  // PTX L4948
	r_PtxRegister2124 = r_bPtxPredicate465 ? r_PtxRegister296 : r_PtxRegister297; // PTX L4949
L__BB39_232:																	  // PTX L4950
	r_bPtxPredicate466 = uint32_t(r_PtxRegister290) == uint32_t(0);				  // PTX L4951
	r_PtxRegister1873 = r_PtxRegister291 | 16;									  // PTX L4952
	r_PtxRegister2125 =
		ShuffleIdxPredicate(r_bPtxPredicate467, r_PtxRegister84, r_PtxRegister1873, 31, -1); // PTX L4953
	r_PtxRegister298 =
		ShuffleIdxPredicate(r_bPtxPredicate468, r_PtxRegister85, r_PtxRegister1873, 31, -1); // PTX L4954
	r_PtxRegister299 =
		ShuffleIdxPredicate(r_bPtxPredicate469, r_PtxRegister100, r_PtxRegister1873, 31, -1); // PTX L4955
	r_PtxRegister300 =
		ShuffleIdxPredicate(r_bPtxPredicate470, r_PtxRegister101, r_PtxRegister1873, 31, -1); // PTX L4956
	if (r_bPtxPredicate466)
	{
		goto L__BB39_235;
	} // PTX L4957
	r_bPtxPredicate471 = uint32_t(r_PtxRegister290) == uint32_t(1); // PTX L4958
	r_PtxRegister2125 = uint32_t(r_PtxRegister298);					// PTX L4959
	if (r_bPtxPredicate471)
	{
		goto L__BB39_235;
	} // PTX L4960
	r_bPtxPredicate472 = uint32_t(r_PtxRegister290) == uint32_t(2);				  // PTX L4961
	r_PtxRegister2125 = r_bPtxPredicate472 ? r_PtxRegister299 : r_PtxRegister300; // PTX L4962
L__BB39_235:																	  // PTX L4963
	r_bPtxPredicate473 = uint32_t(r_PtxRegister290) == uint32_t(0);				  // PTX L4964
	r_PtxRegister1874 = r_PtxRegister291 | 20;									  // PTX L4965
	r_PtxRegister2126 =
		ShuffleIdxPredicate(r_bPtxPredicate474, r_PtxRegister84, r_PtxRegister1874, 31, -1); // PTX L4966
	r_PtxRegister301 =
		ShuffleIdxPredicate(r_bPtxPredicate475, r_PtxRegister85, r_PtxRegister1874, 31, -1); // PTX L4967
	r_PtxRegister302 =
		ShuffleIdxPredicate(r_bPtxPredicate476, r_PtxRegister100, r_PtxRegister1874, 31, -1); // PTX L4968
	r_PtxRegister303 =
		ShuffleIdxPredicate(r_bPtxPredicate477, r_PtxRegister101, r_PtxRegister1874, 31, -1); // PTX L4969
	if (r_bPtxPredicate473)
	{
		goto L__BB39_238;
	} // PTX L4970
	r_bPtxPredicate478 = uint32_t(r_PtxRegister290) == uint32_t(1); // PTX L4971
	r_PtxRegister2126 = uint32_t(r_PtxRegister301);					// PTX L4972
	if (r_bPtxPredicate478)
	{
		goto L__BB39_238;
	} // PTX L4973
	r_bPtxPredicate479 = uint32_t(r_PtxRegister290) == uint32_t(2);				  // PTX L4974
	r_PtxRegister2126 = r_bPtxPredicate479 ? r_PtxRegister302 : r_PtxRegister303; // PTX L4975
L__BB39_238:																	  // PTX L4976
	r_PackedHalf2AtPtx4978R1875 = HalfAdd(r_PtxRegister2123, r_PtxRegister2124);  // PTX L4978
	r_PackedHalf2AtPtx4982R1876 = HalfAdd(r_PtxRegister2125, r_PtxRegister2126);  // PTX L4982
	r_PackedHalf2AtPtx4986R1877 =
		HalfAdd(r_PackedHalf2AtPtx4978R1875, r_PackedHalf2AtPtx4982R1876); // PTX L4986
	r_PackedHalf2AtPtx4990R1921 =
		HalfMul(r_PackedHalf2AtPtx4986R1877, r_PackedHalf2AtPtx3961R1906);		 // PTX L4990
	r_LaneIndexAtPtx4994 = uint32_t((threadIdx.x & 31u));						 // PTX L4994
	r_PtxRegister1879 = ShiftRight(uint32_t(r_LaneIndexAtPtx4994), uint32_t(2)); // PTX L4996
	r_PtxRegister1880 = r_PtxRegister1879 & 2;									 // PTX L4997
	r_PtxRegister1881 = ShiftRight(uint32_t(r_LaneIndexAtPtx4994), uint32_t(4)); // PTX L4998
	r_PtxRegister1882 = r_PtxRegister1881 & 1;									 // PTX L4999
	r_PtxRegister304 = r_PtxRegister1880 | r_PtxRegister1882;					 // PTX L5000
	r_PtxRegister1883 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4994), uint32_t(1));	 // PTX L5001
	r_PtxRegister1884 = r_PtxRegister1883 & 8;									 // PTX L5002
	r_PtxRegister1885 = r_LaneIndexAtPtx4994 & 3;								 // PTX L5003
	r_PtxRegister305 = r_PtxRegister1884 | r_PtxRegister1885;					 // PTX L5004
	r_PtxRegister2127 =
		ShuffleIdxPredicate(r_bPtxPredicate480, r_PtxRegister54, r_PtxRegister305, 31, -1); // PTX L5005
	r_PtxRegister306 =
		ShuffleIdxPredicate(r_bPtxPredicate481, r_PtxRegister55, r_PtxRegister305, 31, -1); // PTX L5006
	r_PtxRegister307 =
		ShuffleIdxPredicate(r_bPtxPredicate482, r_PtxRegister70, r_PtxRegister305, 31, -1); // PTX L5007
	r_PtxRegister308 =
		ShuffleIdxPredicate(r_bPtxPredicate483, r_PtxRegister71, r_PtxRegister305, 31, -1); // PTX L5008
	r_bPtxPredicate484 = uint32_t(r_PtxRegister304) == uint32_t(0);							// PTX L5009
	if (r_bPtxPredicate484)
	{
		goto L__BB39_241;
	} // PTX L5010
	r_bPtxPredicate485 = uint32_t(r_PtxRegister304) == uint32_t(1); // PTX L5011
	r_PtxRegister2127 = uint32_t(r_PtxRegister306);					// PTX L5012
	if (r_bPtxPredicate485)
	{
		goto L__BB39_241;
	} // PTX L5013
	r_bPtxPredicate486 = uint32_t(r_PtxRegister304) == uint32_t(2);				  // PTX L5014
	r_PtxRegister2127 = r_bPtxPredicate486 ? r_PtxRegister307 : r_PtxRegister308; // PTX L5015
L__BB39_241:																	  // PTX L5016
	r_bPtxPredicate487 = uint32_t(r_PtxRegister304) == uint32_t(0);				  // PTX L5017
	r_PtxRegister1886 = r_PtxRegister305 | 4;									  // PTX L5018
	r_PtxRegister2128 =
		ShuffleIdxPredicate(r_bPtxPredicate488, r_PtxRegister54, r_PtxRegister1886, 31, -1); // PTX L5019
	r_PtxRegister309 =
		ShuffleIdxPredicate(r_bPtxPredicate489, r_PtxRegister55, r_PtxRegister1886, 31, -1); // PTX L5020
	r_PtxRegister310 =
		ShuffleIdxPredicate(r_bPtxPredicate490, r_PtxRegister70, r_PtxRegister1886, 31, -1); // PTX L5021
	r_PtxRegister311 =
		ShuffleIdxPredicate(r_bPtxPredicate491, r_PtxRegister71, r_PtxRegister1886, 31, -1); // PTX L5022
	if (r_bPtxPredicate487)
	{
		goto L__BB39_244;
	} // PTX L5023
	r_bPtxPredicate492 = uint32_t(r_PtxRegister304) == uint32_t(1); // PTX L5024
	r_PtxRegister2128 = uint32_t(r_PtxRegister309);					// PTX L5025
	if (r_bPtxPredicate492)
	{
		goto L__BB39_244;
	} // PTX L5026
	r_bPtxPredicate493 = uint32_t(r_PtxRegister304) == uint32_t(2);				  // PTX L5027
	r_PtxRegister2128 = r_bPtxPredicate493 ? r_PtxRegister310 : r_PtxRegister311; // PTX L5028
L__BB39_244:																	  // PTX L5029
	r_bPtxPredicate494 = uint32_t(r_PtxRegister304) == uint32_t(0);				  // PTX L5030
	r_PtxRegister1887 = r_PtxRegister305 | 16;									  // PTX L5031
	r_PtxRegister2129 =
		ShuffleIdxPredicate(r_bPtxPredicate495, r_PtxRegister54, r_PtxRegister1887, 31, -1); // PTX L5032
	r_PtxRegister312 =
		ShuffleIdxPredicate(r_bPtxPredicate496, r_PtxRegister55, r_PtxRegister1887, 31, -1); // PTX L5033
	r_PtxRegister313 =
		ShuffleIdxPredicate(r_bPtxPredicate497, r_PtxRegister70, r_PtxRegister1887, 31, -1); // PTX L5034
	r_PtxRegister314 =
		ShuffleIdxPredicate(r_bPtxPredicate498, r_PtxRegister71, r_PtxRegister1887, 31, -1); // PTX L5035
	if (r_bPtxPredicate494)
	{
		goto L__BB39_247;
	} // PTX L5036
	r_bPtxPredicate499 = uint32_t(r_PtxRegister304) == uint32_t(1); // PTX L5037
	r_PtxRegister2129 = uint32_t(r_PtxRegister312);					// PTX L5038
	if (r_bPtxPredicate499)
	{
		goto L__BB39_247;
	} // PTX L5039
	r_bPtxPredicate500 = uint32_t(r_PtxRegister304) == uint32_t(2);				  // PTX L5040
	r_PtxRegister2129 = r_bPtxPredicate500 ? r_PtxRegister313 : r_PtxRegister314; // PTX L5041
L__BB39_247:																	  // PTX L5042
	r_bPtxPredicate501 = uint32_t(r_PtxRegister304) == uint32_t(0);				  // PTX L5043
	r_PtxRegister1888 = r_PtxRegister305 | 20;									  // PTX L5044
	r_PtxRegister2130 =
		ShuffleIdxPredicate(r_bPtxPredicate502, r_PtxRegister54, r_PtxRegister1888, 31, -1); // PTX L5045
	r_PtxRegister315 =
		ShuffleIdxPredicate(r_bPtxPredicate503, r_PtxRegister55, r_PtxRegister1888, 31, -1); // PTX L5046
	r_PtxRegister316 =
		ShuffleIdxPredicate(r_bPtxPredicate504, r_PtxRegister70, r_PtxRegister1888, 31, -1); // PTX L5047
	r_PtxRegister317 =
		ShuffleIdxPredicate(r_bPtxPredicate505, r_PtxRegister71, r_PtxRegister1888, 31, -1); // PTX L5048
	if (r_bPtxPredicate501)
	{
		goto L__BB39_250;
	} // PTX L5049
	r_bPtxPredicate506 = uint32_t(r_PtxRegister304) == uint32_t(1); // PTX L5050
	r_PtxRegister2130 = uint32_t(r_PtxRegister315);					// PTX L5051
	if (r_bPtxPredicate506)
	{
		goto L__BB39_250;
	} // PTX L5052
	r_bPtxPredicate507 = uint32_t(r_PtxRegister304) == uint32_t(2);				  // PTX L5053
	r_PtxRegister2130 = r_bPtxPredicate507 ? r_PtxRegister316 : r_PtxRegister317; // PTX L5054
L__BB39_250:																	  // PTX L5055
	r_PackedHalf2AtPtx5057R1889 = HalfAdd(r_PtxRegister2127, r_PtxRegister2128);  // PTX L5057
	r_PackedHalf2AtPtx5061R1890 = HalfAdd(r_PtxRegister2129, r_PtxRegister2130);  // PTX L5061
	r_PackedHalf2AtPtx5065R1891 =
		HalfAdd(r_PackedHalf2AtPtx5057R1889, r_PackedHalf2AtPtx5061R1890); // PTX L5065
	r_PackedHalf2AtPtx5069R1920 =
		HalfMul(r_PackedHalf2AtPtx5065R1891, r_PackedHalf2AtPtx3961R1906);		 // PTX L5069
	r_LaneIndexAtPtx5073 = uint32_t((threadIdx.x & 31u));						 // PTX L5073
	r_PtxRegister1893 = ShiftRight(uint32_t(r_LaneIndexAtPtx5073), uint32_t(2)); // PTX L5075
	r_PtxRegister1894 = r_PtxRegister1893 & 2;									 // PTX L5076
	r_PtxRegister1895 = ShiftRight(uint32_t(r_LaneIndexAtPtx5073), uint32_t(4)); // PTX L5077
	r_PtxRegister1896 = r_PtxRegister1895 & 1;									 // PTX L5078
	r_PtxRegister318 = r_PtxRegister1894 | r_PtxRegister1896;					 // PTX L5079
	r_PtxRegister1897 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5073), uint32_t(1));	 // PTX L5080
	r_PtxRegister1898 = r_PtxRegister1897 & 8;									 // PTX L5081
	r_PtxRegister1899 = r_LaneIndexAtPtx5073 & 3;								 // PTX L5082
	r_PtxRegister319 = r_PtxRegister1898 | r_PtxRegister1899;					 // PTX L5083
	r_PtxRegister2131 =
		ShuffleIdxPredicate(r_bPtxPredicate508, r_PtxRegister86, r_PtxRegister319, 31, -1); // PTX L5084
	r_PtxRegister320 =
		ShuffleIdxPredicate(r_bPtxPredicate509, r_PtxRegister87, r_PtxRegister319, 31, -1); // PTX L5085
	r_PtxRegister321 =
		ShuffleIdxPredicate(r_bPtxPredicate510, r_PtxRegister102, r_PtxRegister319, 31, -1); // PTX L5086
	r_PtxRegister322 =
		ShuffleIdxPredicate(r_bPtxPredicate511, r_PtxRegister103, r_PtxRegister319, 31, -1); // PTX L5087
	r_bPtxPredicate512 = uint32_t(r_PtxRegister318) == uint32_t(0);							 // PTX L5088
	if (r_bPtxPredicate512)
	{
		goto L__BB39_253;
	} // PTX L5089
	r_bPtxPredicate513 = uint32_t(r_PtxRegister318) == uint32_t(1); // PTX L5090
	r_PtxRegister2131 = uint32_t(r_PtxRegister320);					// PTX L5091
	if (r_bPtxPredicate513)
	{
		goto L__BB39_253;
	} // PTX L5092
	r_bPtxPredicate514 = uint32_t(r_PtxRegister318) == uint32_t(2);				  // PTX L5093
	r_PtxRegister2131 = r_bPtxPredicate514 ? r_PtxRegister321 : r_PtxRegister322; // PTX L5094
L__BB39_253:																	  // PTX L5095
	r_bPtxPredicate515 = uint32_t(r_PtxRegister318) == uint32_t(0);				  // PTX L5096
	r_PtxRegister1900 = r_PtxRegister319 | 4;									  // PTX L5097
	r_PtxRegister2132 =
		ShuffleIdxPredicate(r_bPtxPredicate516, r_PtxRegister86, r_PtxRegister1900, 31, -1); // PTX L5098
	r_PtxRegister323 =
		ShuffleIdxPredicate(r_bPtxPredicate517, r_PtxRegister87, r_PtxRegister1900, 31, -1); // PTX L5099
	r_PtxRegister324 =
		ShuffleIdxPredicate(r_bPtxPredicate518, r_PtxRegister102, r_PtxRegister1900, 31, -1); // PTX L5100
	r_PtxRegister325 =
		ShuffleIdxPredicate(r_bPtxPredicate519, r_PtxRegister103, r_PtxRegister1900, 31, -1); // PTX L5101
	if (r_bPtxPredicate515)
	{
		goto L__BB39_256;
	} // PTX L5102
	r_bPtxPredicate520 = uint32_t(r_PtxRegister318) == uint32_t(1); // PTX L5103
	r_PtxRegister2132 = uint32_t(r_PtxRegister323);					// PTX L5104
	if (r_bPtxPredicate520)
	{
		goto L__BB39_256;
	} // PTX L5105
	r_bPtxPredicate521 = uint32_t(r_PtxRegister318) == uint32_t(2);				  // PTX L5106
	r_PtxRegister2132 = r_bPtxPredicate521 ? r_PtxRegister324 : r_PtxRegister325; // PTX L5107
L__BB39_256:																	  // PTX L5108
	r_bPtxPredicate522 = uint32_t(r_PtxRegister318) == uint32_t(0);				  // PTX L5109
	r_PtxRegister1901 = r_PtxRegister319 | 16;									  // PTX L5110
	r_PtxRegister2133 =
		ShuffleIdxPredicate(r_bPtxPredicate523, r_PtxRegister86, r_PtxRegister1901, 31, -1); // PTX L5111
	r_PtxRegister326 =
		ShuffleIdxPredicate(r_bPtxPredicate524, r_PtxRegister87, r_PtxRegister1901, 31, -1); // PTX L5112
	r_PtxRegister327 =
		ShuffleIdxPredicate(r_bPtxPredicate525, r_PtxRegister102, r_PtxRegister1901, 31, -1); // PTX L5113
	r_PtxRegister328 =
		ShuffleIdxPredicate(r_bPtxPredicate526, r_PtxRegister103, r_PtxRegister1901, 31, -1); // PTX L5114
	if (r_bPtxPredicate522)
	{
		goto L__BB39_259;
	} // PTX L5115
	r_bPtxPredicate527 = uint32_t(r_PtxRegister318) == uint32_t(1); // PTX L5116
	r_PtxRegister2133 = uint32_t(r_PtxRegister326);					// PTX L5117
	if (r_bPtxPredicate527)
	{
		goto L__BB39_259;
	} // PTX L5118
	r_bPtxPredicate528 = uint32_t(r_PtxRegister318) == uint32_t(2);				  // PTX L5119
	r_PtxRegister2133 = r_bPtxPredicate528 ? r_PtxRegister327 : r_PtxRegister328; // PTX L5120
L__BB39_259:																	  // PTX L5121
	r_bPtxPredicate529 = uint32_t(r_PtxRegister318) == uint32_t(0);				  // PTX L5122
	r_PtxRegister1902 = r_PtxRegister319 | 20;									  // PTX L5123
	r_PtxRegister2134 =
		ShuffleIdxPredicate(r_bPtxPredicate530, r_PtxRegister86, r_PtxRegister1902, 31, -1); // PTX L5124
	r_PtxRegister329 =
		ShuffleIdxPredicate(r_bPtxPredicate531, r_PtxRegister87, r_PtxRegister1902, 31, -1); // PTX L5125
	r_PtxRegister330 =
		ShuffleIdxPredicate(r_bPtxPredicate532, r_PtxRegister102, r_PtxRegister1902, 31, -1); // PTX L5126
	r_PtxRegister331 =
		ShuffleIdxPredicate(r_bPtxPredicate533, r_PtxRegister103, r_PtxRegister1902, 31, -1); // PTX L5127
	if (r_bPtxPredicate529)
	{
		goto L__BB39_262;
	} // PTX L5128
	r_bPtxPredicate534 = uint32_t(r_PtxRegister318) == uint32_t(1); // PTX L5129
	r_PtxRegister2134 = uint32_t(r_PtxRegister329);					// PTX L5130
	if (r_bPtxPredicate534)
	{
		goto L__BB39_262;
	} // PTX L5131
	r_bPtxPredicate535 = uint32_t(r_PtxRegister318) == uint32_t(2);				  // PTX L5132
	r_PtxRegister2134 = r_bPtxPredicate535 ? r_PtxRegister330 : r_PtxRegister331; // PTX L5133
L__BB39_262:																	  // PTX L5134
	r_PackedHalf2AtPtx5136R1903 = HalfAdd(r_PtxRegister2131, r_PtxRegister2132);  // PTX L5136
	r_PackedHalf2AtPtx5140R1904 = HalfAdd(r_PtxRegister2133, r_PtxRegister2134);  // PTX L5140
	r_PackedHalf2AtPtx5144R1905 =
		HalfAdd(r_PackedHalf2AtPtx5136R1903, r_PackedHalf2AtPtx5140R1904); // PTX L5144
	r_PackedHalf2AtPtx5148R1922 =
		HalfMul(r_PackedHalf2AtPtx5144R1905, r_PackedHalf2AtPtx3961R1906);		   // PTX L5148
	r_ConvertedE4PairAtPtx5152Rs154 = PublishE4(r_PackedHalf2AtPtx3963R1907);	   // PTX L5152
	r_ConvertedE4PairAtPtx5155Rs155 = PublishE4(r_PackedHalf2AtPtx4121R1908);	   // PTX L5155
	r_ConvertedE4PairAtPtx5158Rs156 = PublishE4(r_PackedHalf2AtPtx4042R1909);	   // PTX L5158
	r_ConvertedE4PairAtPtx5161Rs157 = PublishE4(r_PackedHalf2AtPtx4200R1910);	   // PTX L5161
	r_ConvertedE4PairAtPtx5164Rs158 = PublishE4(r_PackedHalf2AtPtx4279R1911);	   // PTX L5164
	r_ConvertedE4PairAtPtx5167Rs159 = PublishE4(r_PackedHalf2AtPtx4437R1912);	   // PTX L5167
	r_ConvertedE4PairAtPtx5170Rs160 = PublishE4(r_PackedHalf2AtPtx4358R1913);	   // PTX L5170
	r_ConvertedE4PairAtPtx5173Rs161 = PublishE4(r_PackedHalf2AtPtx4516R1914);	   // PTX L5173
	r_ConvertedE4PairAtPtx5176Rs162 = PublishE4(r_PackedHalf2AtPtx4595R1915);	   // PTX L5176
	r_ConvertedE4PairAtPtx5179Rs163 = PublishE4(r_PackedHalf2AtPtx4753R1916);	   // PTX L5179
	r_ConvertedE4PairAtPtx5182Rs164 = PublishE4(r_PackedHalf2AtPtx4674R1917);	   // PTX L5182
	r_ConvertedE4PairAtPtx5185Rs165 = PublishE4(r_PackedHalf2AtPtx4832R1918);	   // PTX L5185
	r_ConvertedE4PairAtPtx5188Rs166 = PublishE4(r_PackedHalf2AtPtx4911R1919);	   // PTX L5188
	r_ConvertedE4PairAtPtx5191Rs167 = PublishE4(r_PackedHalf2AtPtx5069R1920);	   // PTX L5191
	r_ConvertedE4PairAtPtx5194Rs168 = PublishE4(r_PackedHalf2AtPtx4990R1921);	   // PTX L5194
	r_ConvertedE4PairAtPtx5197Rs169 = PublishE4(r_PackedHalf2AtPtx5148R1922);	   // PTX L5197
	r_PtxRegister1923 = ShiftRightSigned(int32_t(r_Scalar72Bits), uint32_t(31));   // PTX L5199
	r_PtxRegister1924 = ShiftRight(uint32_t(r_PtxRegister1923), uint32_t(30));	   // PTX L5200
	r_PtxRegister1925 = uint32_t(r_Scalar72Bits) + uint32_t(r_PtxRegister1924);	   // PTX L5201
	r_PtxRegister1926 = ShiftRightSigned(int32_t(r_PtxRegister1925), uint32_t(2)); // PTX L5202
	r_bPtxPredicate536 = int32_t(r_CtaY) >= int32_t(r_PtxRegister1926);			   // PTX L5203
	r_bPtxPredicate537 = int32_t(r_PtxRegister2) >= int32_t(r_PtxRegister107);	   // PTX L5204
	r_bPtxPredicate538 = r_bPtxPredicate536 | r_bPtxPredicate537;				   // PTX L5205
	if (r_bPtxPredicate538)
	{
		goto L__BB39_264;
	} // PTX L5206
	r_PackedE4WordAtPtx5207R1936 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5194Rs168, r_ConvertedE4PairAtPtx5197Rs169); // PTX L5207
	r_PackedE4WordAtPtx5208R1935 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5188Rs166, r_ConvertedE4PairAtPtx5191Rs167); // PTX L5208
	r_PackedE4WordAtPtx5209R1934 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5182Rs164, r_ConvertedE4PairAtPtx5185Rs165); // PTX L5209
	r_PackedE4WordAtPtx5210R1933 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5176Rs162, r_ConvertedE4PairAtPtx5179Rs163); // PTX L5210
	r_PackedE4WordAtPtx5211R1931 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5170Rs160, r_ConvertedE4PairAtPtx5173Rs161); // PTX L5211
	r_PackedE4WordAtPtx5212R1930 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5164Rs158, r_ConvertedE4PairAtPtx5167Rs159); // PTX L5212
	r_PackedE4WordAtPtx5213R1929 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5158Rs156, r_ConvertedE4PairAtPtx5161Rs157); // PTX L5213
	r_PackedE4WordAtPtx5214R1928 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5152Rs154, r_ConvertedE4PairAtPtx5155Rs155);		  // PTX L5214
	r_PtxRegister1937 = uint32_t(r_CtaY) * uint32_t(r_PtxRegister107) + uint32_t(r_PtxRegister2); // PTX L5215
	r_PtxRegister1938 = ShiftLeft(uint32_t(r_PtxRegister1937), uint32_t(11));					  // PTX L5216
	r_PtxRegister1939 = uint32_t(r_PtxRegister1938) + uint32_t(r_PtxRegister104);				  // PTX L5217
	r_PtxU64Register258 = uint64_t(int64_t(int32_t(r_PtxRegister1939)) * int64_t(int32_t(4)));	  // PTX L5218
	r_PtxU64Register259 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register258);			  // PTX L5219
	r_LaneIndexAtPtx5221 = uint32_t((threadIdx.x & 31u));										  // PTX L5221
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5221)) * int64_t(int32_t(16)));		 // PTX L5223
	r_PtxU64Register256 = uint64_t(r_PtxU64Register259) + uint64_t(r_PtxU64Register260); // PTX L5224
	StoreNoAllocate(r_PtxU64Register256,
					make_uint4(r_PackedE4WordAtPtx5214R1928, r_PackedE4WordAtPtx5213R1929,
							   r_PackedE4WordAtPtx5212R1930,
							   r_PackedE4WordAtPtx5211R1931)); // PTX L5226
	r_LaneIndexAtPtx5229 = uint32_t((threadIdx.x & 31u));	   // PTX L5229
	r_PtxU64Register261 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5229)) * int64_t(int32_t(16)));		 // PTX L5231
	r_PtxU64Register262 = uint64_t(r_PtxU64Register259) + uint64_t(r_PtxU64Register261); // PTX L5232
	r_PtxU64Register257 = uint64_t(r_PtxU64Register262) + uint64_t(512);				 // PTX L5233
	StoreNoAllocate(r_PtxU64Register257,
					make_uint4(r_PackedE4WordAtPtx5210R1933, r_PackedE4WordAtPtx5209R1934,
							   r_PackedE4WordAtPtx5208R1935,
							   r_PackedE4WordAtPtx5207R1936)); // PTX L5235
L__BB39_264:												   // PTX L5237
	return;													   // PTX L5238
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
