// Readable equivalent of cc_split_swin_16h_ffwd_proj_inpview_512_fp8; not historical source.
#pragma once
#include "window_ffn_projection_input_view_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8
{
__global__ __maxnreg__(128) void window_ffn_projection_input_view_c512_fp8(Parameters r_Parameters)
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
	bool r_bPtxPredicate541, r_bPtxPredicate542, r_bPtxPredicate543, r_bPtxPredicate544, r_bPtxPredicate545,
		r_bPtxPredicate546, r_bPtxPredicate547, r_bPtxPredicate548, r_bPtxPredicate549, r_bPtxPredicate550,
		r_bPtxPredicate551, r_bPtxPredicate552;
	bool r_bPtxPredicate553, r_bPtxPredicate554, r_bPtxPredicate555, r_bPtxPredicate556, r_bPtxPredicate557,
		r_bPtxPredicate558, r_bPtxPredicate559, r_bPtxPredicate560, r_bPtxPredicate561, r_bPtxPredicate562,
		r_bPtxPredicate563, r_bPtxPredicate564;
	bool r_bPtxPredicate565, r_bPtxPredicate566, r_bPtxPredicate567, r_bPtxPredicate568, r_bPtxPredicate569,
		r_bPtxPredicate570, r_bPtxPredicate571, r_bPtxPredicate572, r_bPtxPredicate573, r_bPtxPredicate574,
		r_bPtxPredicate575, r_bPtxPredicate576;
	bool r_bPtxPredicate577, r_bPtxPredicate578, r_bPtxPredicate579, r_bPtxPredicate580, r_bPtxPredicate581,
		r_bPtxPredicate582, r_bPtxPredicate583, r_bPtxPredicate584, r_bPtxPredicate585, r_bPtxPredicate586,
		r_bPtxPredicate587, r_bPtxPredicate588;
	bool r_bPtxPredicate589, r_bPtxPredicate590, r_bPtxPredicate591, r_bPtxPredicate592, r_bPtxPredicate593,
		r_bPtxPredicate594, r_bPtxPredicate595, r_bPtxPredicate596, r_bPtxPredicate597, r_bPtxPredicate598,
		r_bPtxPredicate599, r_bPtxPredicate600;
	bool r_bPtxPredicate601, r_bPtxPredicate602, r_bPtxPredicate603, r_bPtxPredicate604, r_bPtxPredicate605,
		r_bPtxPredicate606, r_bPtxPredicate607, r_bPtxPredicate608, r_bPtxPredicate609;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx221Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx302Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx374Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx445Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx517Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx588Rs12;
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
		r_PtxU16Register65, r_PtxU16Register66, r_PtxU16Register67, r_PtxU16Register68, r_PtxU16Register69,
		r_PtxU16Register70, r_PtxU16Register71, r_PtxU16Register72;
	uint16_t r_PtxU16Register73, r_PtxU16Register74, r_PtxU16Register75, r_PtxU16Register76,
		r_PtxU16Register77, r_PtxU16Register78, r_PtxU16Register79, r_PtxU16Register80, r_PtxU16Register81,
		r_PtxU16Register82, r_PtxU16Register83, r_PtxU16Register84;
	uint16_t r_PtxU16Register85, r_PtxU16Register86, r_PtxU16Register87, r_PtxU16Register88,
		r_PtxU16Register89, r_ConvertedE4PairAtPtx4497Rs90, r_PtxU16Register91,
		r_ConvertedE4PairAtPtx4578Rs92, r_ConvertedE4PairAtPtx4596Rs93, r_ConvertedE4PairAtPtx4599Rs94,
		r_ConvertedE4PairAtPtx4602Rs95, r_ConvertedE4PairAtPtx4605Rs96;
	uint16_t r_ConvertedE4PairAtPtx4608Rs97, r_ConvertedE4PairAtPtx4611Rs98, r_ConvertedE4PairAtPtx4614Rs99,
		r_ConvertedE4PairAtPtx4617Rs100, r_ConvertedE4PairAtPtx4620Rs101, r_ConvertedE4PairAtPtx4623Rs102,
		r_ConvertedE4PairAtPtx4626Rs103, r_ConvertedE4PairAtPtx4629Rs104, r_ConvertedE4PairAtPtx4632Rs105,
		r_ConvertedE4PairAtPtx4635Rs106, r_ConvertedE4PairAtPtx4638Rs107, r_ConvertedE4PairAtPtx4641Rs108;
	uint16_t r_ConvertedE4PairAtPtx4644Rs109, r_ConvertedE4PairAtPtx4647Rs110,
		r_ConvertedE4PairAtPtx4650Rs111, r_ConvertedE4PairAtPtx4653Rs112, r_ConvertedE4PairAtPtx4656Rs113,
		r_ConvertedE4PairAtPtx4659Rs114, r_ConvertedE4PairAtPtx4662Rs115, r_ConvertedE4PairAtPtx4665Rs116,
		r_ConvertedE4PairAtPtx4668Rs117, r_ConvertedE4PairAtPtx4671Rs118, r_ConvertedE4PairAtPtx4674Rs119,
		r_ConvertedE4PairAtPtx4677Rs120;
	uint16_t r_ConvertedE4PairAtPtx4680Rs121, r_ConvertedE4PairAtPtx4683Rs122,
		r_ConvertedE4PairAtPtx4686Rs123, r_ConvertedE4PairAtPtx4689Rs124, r_ConvertedE4PairAtPtx4692Rs125,
		r_ConvertedE4PairAtPtx4695Rs126, r_ConvertedE4PairAtPtx4698Rs127, r_ConvertedE4PairAtPtx4701Rs128,
		r_ConvertedE4PairAtPtx4704Rs129, r_ConvertedE4PairAtPtx4707Rs130, r_ConvertedE4PairAtPtx4710Rs131,
		r_ConvertedE4PairAtPtx4713Rs132;
	uint16_t r_ConvertedE4PairAtPtx4716Rs133, r_ConvertedE4PairAtPtx4719Rs134,
		r_ConvertedE4PairAtPtx4722Rs135, r_ConvertedE4PairAtPtx4725Rs136, r_ConvertedE4PairAtPtx4728Rs137,
		r_ConvertedE4PairAtPtx4731Rs138, r_ConvertedE4PairAtPtx4734Rs139, r_ConvertedE4PairAtPtx4737Rs140,
		r_ConvertedE4PairAtPtx4740Rs141, r_ConvertedE4PairAtPtx4743Rs142, r_ConvertedE4PairAtPtx4746Rs143,
		r_ConvertedE4PairAtPtx4749Rs144;
	uint16_t r_ConvertedE4PairAtPtx4752Rs145, r_ConvertedE4PairAtPtx4755Rs146,
		r_ConvertedE4PairAtPtx4758Rs147, r_ConvertedE4PairAtPtx4761Rs148, r_ConvertedE4PairAtPtx4764Rs149,
		r_ConvertedE4PairAtPtx4767Rs150, r_ConvertedE4PairAtPtx4770Rs151, r_ConvertedE4PairAtPtx4773Rs152,
		r_ConvertedE4PairAtPtx4776Rs153, r_ConvertedE4PairAtPtx4779Rs154, r_ConvertedE4PairAtPtx4782Rs155,
		r_ConvertedE4PairAtPtx4785Rs156;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
		r_HeightDiv4Bits, r_WidthDiv4Bits, r_ThreadYAtPtx45, r_PtxRegister10, r_PtxRegister11,
		r_PtxRegister12;
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
		r_HeightBits, r_WidthBits, r_CtaX, r_CtaY, r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4, r_WidthSignBits, r_WidthDiv4Bias,
		r_WidthBiasedForDiv4, r_ThreadX;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_BlockSizeX, r_BlockSizeY, r_LaneIndexAtPtx75, r_LaneIndexAtPtx83, r_LaneIndexAtPtx92,
		r_LaneIndexAtPtx101, r_LaneIndexAtPtx110;
	uint32_t r_LaneIndexAtPtx119, r_LaneIndexAtPtx128, r_LaneIndexAtPtx137, r_PtxRegister136,
		r_PtxRegister137, r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141,
		r_PtxRegister142, r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PackedHalf2AtPtx219R157, r_LaneIndexAtPtx225, r_PtxRegister159, r_PackedE4WordAtPtx223R160,
		r_PtxRegister161, r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165,
		r_PtxRegister166, r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PackedHalf2AtPtx300R180;
	uint32_t r_LaneIndexAtPtx306, r_PtxRegister182, r_PackedE4WordAtPtx304R183, r_PtxRegister184,
		r_PtxRegister185, r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189,
		r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PackedHalf2AtPtx372R198, r_LaneIndexAtPtx378, r_PtxRegister200, r_PackedE4WordAtPtx376R201,
		r_PtxRegister202, r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PackedHalf2AtPtx443R218, r_LaneIndexAtPtx449, r_PtxRegister220,
		r_PackedE4WordAtPtx447R221, r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225,
		r_PtxRegister226, r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PackedHalf2AtPtx515R238,
		r_LaneIndexAtPtx521, r_PtxRegister240;
	uint32_t r_PackedE4WordAtPtx519R241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244,
		r_PtxRegister245, r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249,
		r_PtxRegister250, r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PackedHalf2AtPtx586R258, r_LaneIndexAtPtx592, r_PtxRegister260, r_PackedE4WordAtPtx590R261,
		r_PtxRegister262, r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_LaneIndexAtPtx624,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PtxRegister294, r_PtxRegister295, r_LaneIndexAtPtx674, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PtxRegister301, r_PtxRegister302, r_PtxRegister303, r_PtxRegister304, r_PtxRegister305,
		r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309, r_PtxRegister310,
		r_PtxRegister311, r_PtxRegister312;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316, r_LaneIndexAtPtx724,
		r_PtxRegister318, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321, r_PtxRegister322,
		r_PtxRegister323, r_PtxRegister324;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PtxRegister331, r_PtxRegister332, r_PtxRegister333, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx774, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341,
		r_PtxRegister342, r_PtxRegister343, r_PtxRegister344, r_PtxRegister345, r_PtxRegister346,
		r_PtxRegister347, r_PtxRegister348;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_PtxRegister353,
		r_PtxRegister354, r_PtxRegister355, r_PtxRegister356, r_PtxRegister357, r_LaneIndexAtPtx824,
		r_PtxRegister359, r_PtxRegister360;
	uint32_t r_PtxRegister361, r_PtxRegister362, r_PtxRegister363, r_PtxRegister364, r_PtxRegister365,
		r_PtxRegister366, r_PtxRegister367, r_PtxRegister368, r_PtxRegister369, r_PtxRegister370,
		r_PtxRegister371, r_PtxRegister372;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_PtxRegister375, r_PtxRegister376, r_PtxRegister377,
		r_LaneIndexAtPtx874, r_PtxRegister379, r_PtxRegister380, r_PtxRegister381, r_PtxRegister382,
		r_PtxRegister383, r_PtxRegister384;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_PtxRegister387, r_PtxRegister388, r_PtxRegister389,
		r_PtxRegister390, r_PtxRegister391, r_PtxRegister392, r_PtxRegister393, r_PtxRegister394,
		r_PtxRegister395, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_PtxRegister398, r_LaneIndexAtPtx924, r_PtxRegister400, r_PtxRegister401,
		r_PtxRegister402, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405, r_PtxRegister406,
		r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_PtxRegister410, r_PtxRegister411, r_PtxRegister412, r_PtxRegister413,
		r_PtxRegister414, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417, r_PtxRegister418,
		r_LaneIndexAtPtx974, r_PtxRegister420;
	uint32_t r_PtxRegister421, r_PtxRegister422, r_PtxRegister423, r_PtxRegister424, r_PtxRegister425,
		r_PtxRegister426, r_PtxRegister427, r_PtxRegister428, r_PtxRegister429, r_PtxRegister430,
		r_PtxRegister431, r_PtxRegister432;
	uint32_t r_PtxRegister433, r_PtxRegister434, r_PtxRegister435, r_PtxRegister436, r_PtxRegister437,
		r_PtxRegister438, r_PtxRegister439, r_LaneIndexAtPtx1024, r_PtxRegister441, r_PtxRegister442,
		r_PtxRegister443, r_PtxRegister444;
	uint32_t r_PtxRegister445, r_PtxRegister446, r_PtxRegister447, r_PtxRegister448, r_PtxRegister449,
		r_PtxRegister450, r_PtxRegister451, r_PtxRegister452, r_PtxRegister453, r_PtxRegister454,
		r_PtxRegister455, r_PtxRegister456;
	uint32_t r_PtxRegister457, r_PtxRegister458, r_PtxRegister459, r_PtxRegister460, r_LaneIndexAtPtx1072,
		r_PtxRegister462, r_PtxRegister463, r_PtxRegister464, r_PtxRegister465, r_PtxRegister466,
		r_PtxRegister467, r_PtxRegister468;
	uint32_t r_PtxRegister469, r_PtxRegister470, r_PtxRegister471, r_PtxRegister472, r_PtxRegister473,
		r_PtxRegister474, r_PtxRegister475, r_PtxRegister476, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_PtxRegister481, r_PtxRegister482, r_LaneIndexAtPtx1121, r_PtxRegister484, r_PtxRegister485,
		r_PtxRegister486, r_PtxRegister487, r_PtxRegister488, r_PtxRegister489, r_PtxRegister490,
		r_PtxRegister491, r_PtxRegister492;
	uint32_t r_PtxRegister493, r_PtxRegister494, r_PtxRegister495, r_PtxRegister496, r_PtxRegister497,
		r_PtxRegister498, r_PtxRegister499, r_PtxRegister500, r_PtxRegister501, r_PtxRegister502,
		r_PtxRegister503, r_LaneIndexAtPtx1169;
	uint32_t r_PtxRegister505, r_PtxRegister506, r_PtxRegister507, r_PtxRegister508, r_PtxRegister509,
		r_PtxRegister510, r_PtxRegister511, r_PtxRegister512, r_PtxRegister513, r_PtxRegister514,
		r_PtxRegister515, r_PtxRegister516;
	uint32_t r_PtxRegister517, r_PtxRegister518, r_PtxRegister519, r_PtxRegister520, r_PtxRegister521,
		r_PtxRegister522, r_PtxRegister523, r_PtxRegister524, r_PtxRegister525, r_LaneIndexAtPtx1218,
		r_PtxRegister527, r_PtxRegister528;
	uint32_t r_PtxRegister529, r_PtxRegister530, r_PtxRegister531, r_PtxRegister532, r_PtxRegister533,
		r_PtxRegister534, r_PtxRegister535, r_PtxRegister536, r_PtxRegister537, r_PtxRegister538,
		r_PtxRegister539, r_PtxRegister540;
	uint32_t r_PtxRegister541, r_PtxRegister542, r_PtxRegister543, r_PtxRegister544, r_PtxRegister545,
		r_PtxRegister546, r_LaneIndexAtPtx1266, r_PtxRegister548, r_PtxRegister549, r_PtxRegister550,
		r_PtxRegister551, r_PtxRegister552;
	uint32_t r_PtxRegister553, r_PtxRegister554, r_PtxRegister555, r_PtxRegister556, r_PtxRegister557,
		r_PtxRegister558, r_PtxRegister559, r_PtxRegister560, r_PtxRegister561, r_PtxRegister562,
		r_PtxRegister563, r_PtxRegister564;
	uint32_t r_PtxRegister565, r_PtxRegister566, r_PtxRegister567, r_PtxRegister568, r_LaneIndexAtPtx1315,
		r_PtxRegister570, r_PtxRegister571, r_PtxRegister572, r_PtxRegister573, r_PtxRegister574,
		r_PtxRegister575, r_PtxRegister576;
	uint32_t r_PtxRegister577, r_PtxRegister578, r_PtxRegister579, r_PtxRegister580, r_PtxRegister581,
		r_PtxRegister582, r_PtxRegister583, r_PtxRegister584, r_PtxRegister585, r_PtxRegister586,
		r_PtxRegister587, r_PtxRegister588;
	uint32_t r_PtxRegister589, r_LaneIndexAtPtx1363, r_PtxRegister591, r_PtxRegister592, r_PtxRegister593,
		r_PtxRegister594, r_PtxRegister595, r_PtxRegister596, r_PtxRegister597, r_PtxRegister598,
		r_PtxRegister599, r_PtxRegister600;
	uint32_t r_PtxRegister601, r_PtxRegister602, r_PtxRegister603, r_PtxRegister604, r_PtxRegister605,
		r_PtxRegister606, r_PtxRegister607, r_PtxRegister608, r_PtxRegister609, r_PtxRegister610,
		r_PtxRegister611, r_LaneIndexAtPtx1412;
	uint32_t r_PtxRegister613, r_PtxRegister614, r_PtxRegister615, r_PtxRegister616, r_PtxRegister617,
		r_PtxRegister618, r_PtxRegister619, r_PtxRegister620, r_PtxRegister621, r_PtxRegister622,
		r_PtxRegister623, r_PtxRegister624;
	uint32_t r_PtxRegister625, r_PtxRegister626, r_PtxRegister627, r_PtxRegister628, r_PtxRegister629,
		r_PtxRegister630, r_PtxRegister631, r_PtxRegister632, r_LaneIndexAtPtx1462, r_PtxRegister634,
		r_PtxRegister635, r_PtxRegister636;
	uint32_t r_PtxRegister637, r_PtxRegister638, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_PtxRegister646,
		r_PtxRegister647, r_PtxRegister648;
	uint32_t r_PtxRegister649, r_PtxRegister650, r_PtxRegister651, r_PtxRegister652, r_PtxRegister653,
		r_LaneIndexAtPtx1512, r_PtxRegister655, r_PtxRegister656, r_PtxRegister657, r_PtxRegister658,
		r_PtxRegister659, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_PtxRegister662, r_PtxRegister663, r_PtxRegister664, r_PtxRegister665,
		r_PtxRegister666, r_PtxRegister667, r_PtxRegister668, r_PtxRegister669, r_PtxRegister670,
		r_PtxRegister671, r_PtxRegister672;
	uint32_t r_PtxRegister673, r_PtxRegister674, r_LaneIndexAtPtx1562, r_PtxRegister676, r_PtxRegister677,
		r_PtxRegister678, r_PtxRegister679, r_PtxRegister680, r_PtxRegister681, r_PtxRegister682,
		r_PtxRegister683, r_PtxRegister684;
	uint32_t r_PtxRegister685, r_PtxRegister686, r_PtxRegister687, r_PtxRegister688, r_PtxRegister689,
		r_PtxRegister690, r_PtxRegister691, r_PtxRegister692, r_PtxRegister693, r_PtxRegister694,
		r_PtxRegister695, r_LaneIndexAtPtx1612;
	uint32_t r_PtxRegister697, r_PtxRegister698, r_PtxRegister699, r_PtxRegister700, r_PtxRegister701,
		r_PtxRegister702, r_PtxRegister703, r_PtxRegister704, r_PtxRegister705, r_PtxRegister706,
		r_PtxRegister707, r_PtxRegister708;
	uint32_t r_PtxRegister709, r_PtxRegister710, r_PtxRegister711, r_PtxRegister712, r_PtxRegister713,
		r_PtxRegister714, r_PtxRegister715, r_PtxRegister716, r_LaneIndexAtPtx1662, r_PtxRegister718,
		r_PtxRegister719, r_PtxRegister720;
	uint32_t r_PtxRegister721, r_PtxRegister722, r_PtxRegister723, r_PtxRegister724, r_PtxRegister725,
		r_PtxRegister726, r_PtxRegister727, r_PtxRegister728, r_PtxRegister729, r_PtxRegister730,
		r_PtxRegister731, r_PtxRegister732;
	uint32_t r_PtxRegister733, r_PtxRegister734, r_PtxRegister735, r_PtxRegister736, r_PtxRegister737,
		r_LaneIndexAtPtx1712, r_PtxRegister739, r_PtxRegister740, r_PtxRegister741, r_PtxRegister742,
		r_PtxRegister743, r_PtxRegister744;
	uint32_t r_PtxRegister745, r_PtxRegister746, r_PtxRegister747, r_PtxRegister748, r_PtxRegister749,
		r_PtxRegister750, r_PtxRegister751, r_PtxRegister752, r_PtxRegister753, r_PtxRegister754,
		r_PtxRegister755, r_PtxRegister756;
	uint32_t r_PtxRegister757, r_PtxRegister758, r_LaneIndexAtPtx1762, r_PtxRegister760, r_PtxRegister761,
		r_PtxRegister762, r_PtxRegister763, r_PtxRegister764, r_PtxRegister765, r_PtxRegister766,
		r_PtxRegister767, r_PtxRegister768;
	uint32_t r_PtxRegister769, r_PtxRegister770, r_PtxRegister771, r_PtxRegister772, r_PtxRegister773,
		r_PtxRegister774, r_PtxRegister775, r_PtxRegister776, r_PtxRegister777, r_PtxRegister778,
		r_PtxRegister779, r_LaneIndexAtPtx1811;
	uint32_t r_PtxRegister781, r_PtxRegister782, r_PtxRegister783, r_PtxRegister784, r_PtxRegister785,
		r_PtxRegister786, r_PtxRegister787, r_PtxRegister788, r_PtxRegister789, r_PtxRegister790,
		r_PtxRegister791, r_PtxRegister792;
	uint32_t r_PtxRegister793, r_PtxRegister794, r_PtxRegister795, r_PtxRegister796, r_PtxRegister797,
		r_PtxRegister798, r_PtxRegister799, r_PtxRegister800, r_PtxRegister801, r_LaneIndexAtPtx1859,
		r_PtxRegister803, r_PtxRegister804;
	uint32_t r_PtxRegister805, r_PtxRegister806, r_PtxRegister807, r_PtxRegister808, r_PtxRegister809,
		r_PtxRegister810, r_PtxRegister811, r_PtxRegister812, r_PtxRegister813, r_PtxRegister814,
		r_PtxRegister815, r_PtxRegister816;
	uint32_t r_PtxRegister817, r_PtxRegister818, r_PtxRegister819, r_PtxRegister820, r_PtxRegister821,
		r_PtxRegister822, r_PtxRegister823, r_LaneIndexAtPtx1907, r_PtxRegister825, r_PtxRegister826,
		r_PtxRegister827, r_PtxRegister828;
	uint32_t r_PtxRegister829, r_PtxRegister830, r_PtxRegister831, r_PtxRegister832, r_PtxRegister833,
		r_PtxRegister834, r_PtxRegister835, r_PtxRegister836, r_PtxRegister837, r_PtxRegister838,
		r_PtxRegister839, r_PtxRegister840;
	uint32_t r_PtxRegister841, r_PtxRegister842, r_PtxRegister843, r_PtxRegister844, r_PtxRegister845,
		r_LaneIndexAtPtx1955, r_PtxRegister847, r_PtxRegister848, r_PtxRegister849, r_PtxRegister850,
		r_PtxRegister851, r_PtxRegister852;
	uint32_t r_PtxRegister853, r_PtxRegister854, r_PtxRegister855, r_PtxRegister856, r_PtxRegister857,
		r_PtxRegister858, r_PtxRegister859, r_PtxRegister860, r_PtxRegister861, r_PtxRegister862,
		r_PtxRegister863, r_PtxRegister864;
	uint32_t r_PtxRegister865, r_PtxRegister866, r_PtxRegister867, r_LaneIndexAtPtx2003, r_PtxRegister869,
		r_PtxRegister870, r_PtxRegister871, r_PtxRegister872, r_PtxRegister873, r_PtxRegister874,
		r_PtxRegister875, r_PtxRegister876;
	uint32_t r_PtxRegister877, r_PtxRegister878, r_PtxRegister879, r_PtxRegister880, r_PtxRegister881,
		r_PtxRegister882, r_PtxRegister883, r_PtxRegister884, r_PtxRegister885, r_PtxRegister886,
		r_PtxRegister887, r_PtxRegister888;
	uint32_t r_PtxRegister889, r_LaneIndexAtPtx2051, r_PtxRegister891, r_PtxRegister892, r_PtxRegister893,
		r_PtxRegister894, r_PtxRegister895, r_PtxRegister896, r_PtxRegister897, r_PtxRegister898,
		r_PtxRegister899, r_PtxRegister900;
	uint32_t r_PtxRegister901, r_PtxRegister902, r_PtxRegister903, r_PtxRegister904, r_PtxRegister905,
		r_PtxRegister906, r_PtxRegister907, r_PtxRegister908, r_PtxRegister909, r_PtxRegister910,
		r_PtxRegister911, r_LaneIndexAtPtx2099;
	uint32_t r_PtxRegister913, r_PtxRegister914, r_PtxRegister915, r_PtxRegister916, r_PtxRegister917,
		r_PtxRegister918, r_PtxRegister919, r_PtxRegister920, r_PtxRegister921, r_PtxRegister922,
		r_PtxRegister923, r_PtxRegister924;
	uint32_t r_PtxRegister925, r_PtxRegister926, r_PtxRegister927, r_PtxRegister928, r_PtxRegister929,
		r_PtxRegister930, r_PtxRegister931, r_PtxRegister932, r_PtxRegister933, r_PtxRegister934,
		r_PtxRegister935, r_LaneIndexAtPtx2148;
	uint32_t r_PtxRegister937, r_PtxRegister938, r_PtxRegister939, r_PtxRegister940, r_PtxRegister941,
		r_PtxRegister942, r_PtxRegister943, r_PtxRegister944, r_PtxRegister945, r_PtxRegister946,
		r_PtxRegister947, r_PtxRegister948;
	uint32_t r_PtxRegister949, r_PtxRegister950, r_PtxRegister951, r_PtxRegister952, r_PtxRegister953,
		r_PtxRegister954, r_PtxRegister955, r_PtxRegister956, r_PtxRegister957, r_LaneIndexAtPtx2389,
		r_LaneIndexAtPtx2403, r_LaneIndexAtPtx2417;
	uint32_t r_LaneIndexAtPtx2431, r_LaneIndexAtPtx2445, r_LaneIndexAtPtx2459, r_LaneIndexAtPtx2473,
		r_LaneIndexAtPtx2490, r_LaneIndexAtPtx2506, r_LaneIndexAtPtx2521, r_LaneIndexAtPtx2535,
		r_LaneIndexAtPtx2552, r_LaneIndexAtPtx2568, r_LaneIndexAtPtx2583, r_LaneIndexAtPtx2597;
	uint32_t r_LaneIndexAtPtx2614, r_LaneIndexAtPtx2630, r_LaneIndexAtPtx2644, r_LaneIndexAtPtx2658,
		r_LaneIndexAtPtx2672, r_LaneIndexAtPtx2686, r_LaneIndexAtPtx2700, r_LaneIndexAtPtx2714,
		r_LaneIndexAtPtx2730, r_LaneIndexAtPtx2746, r_LaneIndexAtPtx2760, r_LaneIndexAtPtx2774;
	uint32_t r_LaneIndexAtPtx2790, r_LaneIndexAtPtx2806, r_LaneIndexAtPtx2820, r_LaneIndexAtPtx2834,
		r_LaneIndexAtPtx2850, r_LaneIndexAtPtx2866, r_LaneIndexAtPtx2880, r_LaneIndexAtPtx2894,
		r_LaneIndexAtPtx2908, r_LaneIndexAtPtx2922, r_LaneIndexAtPtx2936, r_LaneIndexAtPtx2950;
	uint32_t r_LaneIndexAtPtx2966, r_LaneIndexAtPtx2982, r_LaneIndexAtPtx2996, r_LaneIndexAtPtx3010,
		r_LaneIndexAtPtx3026, r_LaneIndexAtPtx3042, r_LaneIndexAtPtx3056, r_LaneIndexAtPtx3070,
		r_LaneIndexAtPtx3086, r_LaneIndexAtPtx3102, r_LaneIndexAtPtx3116, r_LaneIndexAtPtx3130;
	uint32_t r_LaneIndexAtPtx3144, r_LaneIndexAtPtx3158, r_LaneIndexAtPtx3172, r_LaneIndexAtPtx3186,
		r_LaneIndexAtPtx3202, r_LaneIndexAtPtx3218, r_LaneIndexAtPtx3232, r_LaneIndexAtPtx3246,
		r_LaneIndexAtPtx3262, r_LaneIndexAtPtx3278, r_LaneIndexAtPtx3292, r_LaneIndexAtPtx3306;
	uint32_t r_LaneIndexAtPtx3322, r_LaneIndexAtPtx3338, r_PackedHalf2AtPtx2194R1023, r_PtxRegister1024,
		r_LaneIndexAtPtx3345, r_PackedHalf2AtPtx2200R1026, r_PtxRegister1027, r_LaneIndexAtPtx3352,
		r_PackedHalf2AtPtx2197R1029, r_PtxRegister1030, r_LaneIndexAtPtx3359, r_PackedHalf2AtPtx2203R1032;
	uint32_t r_PtxRegister1033, r_LaneIndexAtPtx3366, r_PackedHalf2AtPtx2206R1035, r_PtxRegister1036,
		r_LaneIndexAtPtx3373, r_PackedHalf2AtPtx2212R1038, r_PtxRegister1039, r_LaneIndexAtPtx3380,
		r_PackedHalf2AtPtx2209R1041, r_PtxRegister1042, r_LaneIndexAtPtx3387, r_PackedHalf2AtPtx2215R1044;
	uint32_t r_PtxRegister1045, r_LaneIndexAtPtx3394, r_PackedHalf2AtPtx2218R1047, r_PtxRegister1048,
		r_LaneIndexAtPtx3401, r_PackedHalf2AtPtx2224R1050, r_PtxRegister1051, r_LaneIndexAtPtx3408,
		r_PackedHalf2AtPtx2221R1053, r_PtxRegister1054, r_LaneIndexAtPtx3415, r_PackedHalf2AtPtx2227R1056;
	uint32_t r_PtxRegister1057, r_LaneIndexAtPtx3422, r_PackedHalf2AtPtx2230R1059, r_PtxRegister1060,
		r_LaneIndexAtPtx3429, r_PackedHalf2AtPtx2236R1062, r_PtxRegister1063, r_LaneIndexAtPtx3436,
		r_PackedHalf2AtPtx2233R1065, r_PtxRegister1066, r_LaneIndexAtPtx3443, r_PackedHalf2AtPtx2239R1068;
	uint32_t r_PtxRegister1069, r_LaneIndexAtPtx3450, r_PackedHalf2AtPtx2242R1071, r_PtxRegister1072,
		r_LaneIndexAtPtx3457, r_PackedHalf2AtPtx2248R1074, r_PtxRegister1075, r_LaneIndexAtPtx3464,
		r_PackedHalf2AtPtx2245R1077, r_PtxRegister1078, r_LaneIndexAtPtx3471, r_PackedHalf2AtPtx2251R1080;
	uint32_t r_PtxRegister1081, r_LaneIndexAtPtx3478, r_PackedHalf2AtPtx2254R1083, r_PtxRegister1084,
		r_LaneIndexAtPtx3485, r_PackedHalf2AtPtx2260R1086, r_PtxRegister1087, r_LaneIndexAtPtx3492,
		r_PackedHalf2AtPtx2257R1089, r_PtxRegister1090, r_LaneIndexAtPtx3499, r_PackedHalf2AtPtx2263R1092;
	uint32_t r_PtxRegister1093, r_LaneIndexAtPtx3506, r_PackedHalf2AtPtx2266R1095, r_PtxRegister1096,
		r_LaneIndexAtPtx3513, r_PackedHalf2AtPtx2272R1098, r_PtxRegister1099, r_LaneIndexAtPtx3520,
		r_PackedHalf2AtPtx2269R1101, r_PtxRegister1102, r_LaneIndexAtPtx3527, r_PackedHalf2AtPtx2275R1104;
	uint32_t r_PtxRegister1105, r_LaneIndexAtPtx3534, r_PackedHalf2AtPtx2278R1107, r_PtxRegister1108,
		r_LaneIndexAtPtx3541, r_PackedHalf2AtPtx2284R1110, r_PtxRegister1111, r_LaneIndexAtPtx3548,
		r_PackedHalf2AtPtx2281R1113, r_PtxRegister1114, r_LaneIndexAtPtx3555, r_PackedHalf2AtPtx2287R1116;
	uint32_t r_PtxRegister1117, r_LaneIndexAtPtx3562, r_PackedHalf2AtPtx2290R1119, r_PtxRegister1120,
		r_LaneIndexAtPtx3569, r_PackedHalf2AtPtx2296R1122, r_PtxRegister1123, r_LaneIndexAtPtx3576,
		r_PackedHalf2AtPtx2293R1125, r_PtxRegister1126, r_LaneIndexAtPtx3583, r_PackedHalf2AtPtx2299R1128;
	uint32_t r_PtxRegister1129, r_LaneIndexAtPtx3590, r_PackedHalf2AtPtx2302R1131, r_PtxRegister1132,
		r_LaneIndexAtPtx3597, r_PackedHalf2AtPtx2308R1134, r_PtxRegister1135, r_LaneIndexAtPtx3604,
		r_PackedHalf2AtPtx2305R1137, r_PtxRegister1138, r_LaneIndexAtPtx3611, r_PackedHalf2AtPtx2311R1140;
	uint32_t r_PtxRegister1141, r_LaneIndexAtPtx3618, r_PackedHalf2AtPtx2314R1143, r_PtxRegister1144,
		r_LaneIndexAtPtx3625, r_PackedHalf2AtPtx2320R1146, r_PtxRegister1147, r_LaneIndexAtPtx3632,
		r_PackedHalf2AtPtx2317R1149, r_PtxRegister1150, r_LaneIndexAtPtx3639, r_PackedHalf2AtPtx2323R1152;
	uint32_t r_PtxRegister1153, r_LaneIndexAtPtx3646, r_PackedHalf2AtPtx2326R1155, r_PtxRegister1156,
		r_LaneIndexAtPtx3653, r_PackedHalf2AtPtx2332R1158, r_PtxRegister1159, r_LaneIndexAtPtx3660,
		r_PackedHalf2AtPtx2329R1161, r_PtxRegister1162, r_LaneIndexAtPtx3667, r_PackedHalf2AtPtx2335R1164;
	uint32_t r_PtxRegister1165, r_LaneIndexAtPtx3674, r_PackedHalf2AtPtx2338R1167, r_PtxRegister1168,
		r_LaneIndexAtPtx3681, r_PackedHalf2AtPtx2344R1170, r_PtxRegister1171, r_LaneIndexAtPtx3688,
		r_PackedHalf2AtPtx2341R1173, r_PtxRegister1174, r_LaneIndexAtPtx3695, r_PackedHalf2AtPtx2347R1176;
	uint32_t r_PtxRegister1177, r_LaneIndexAtPtx3702, r_PackedHalf2AtPtx2350R1179, r_PtxRegister1180,
		r_LaneIndexAtPtx3709, r_PackedHalf2AtPtx2356R1182, r_PtxRegister1183, r_LaneIndexAtPtx3716,
		r_PackedHalf2AtPtx2353R1185, r_PtxRegister1186, r_LaneIndexAtPtx3723, r_PackedHalf2AtPtx2359R1188;
	uint32_t r_PtxRegister1189, r_LaneIndexAtPtx3730, r_PackedHalf2AtPtx2362R1191, r_PtxRegister1192,
		r_LaneIndexAtPtx3737, r_PackedHalf2AtPtx2368R1194, r_PtxRegister1195, r_LaneIndexAtPtx3744,
		r_PackedHalf2AtPtx2365R1197, r_PtxRegister1198, r_LaneIndexAtPtx3751, r_PackedHalf2AtPtx2371R1200;
	uint32_t r_PtxRegister1201, r_LaneIndexAtPtx3758, r_PackedHalf2AtPtx2374R1203, r_PtxRegister1204,
		r_LaneIndexAtPtx3765, r_PackedHalf2AtPtx2381R1206, r_PtxRegister1207, r_LaneIndexAtPtx3772,
		r_PackedHalf2AtPtx2377R1209, r_PtxRegister1210, r_LaneIndexAtPtx3779, r_PackedHalf2AtPtx2384R1212;
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
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305, r_PtxRegister1306,
		r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_PtxRegister1310, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_PtxRegister1315, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_PtxRegister1330,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_PtxRegister1399, r_PtxRegister1400, r_PtxRegister1401, r_PtxRegister1402,
		r_PtxRegister1403, r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408, r_PtxRegister1409,
		r_PtxRegister1410, r_PtxRegister1411, r_PtxRegister1412, r_PtxRegister1413, r_PtxRegister1414,
		r_PtxRegister1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_PtxRegister1423, r_PtxRegister1424, r_PtxRegister1425, r_PtxRegister1426,
		r_PtxRegister1427, r_PtxRegister1428;
	uint32_t r_PtxRegister1429, r_PtxRegister1430, r_PtxRegister1431, r_PtxRegister1432, r_PtxRegister1433,
		r_PtxRegister1434, r_PtxRegister1435, r_PtxRegister1436, r_PtxRegister1437, r_PtxRegister1438,
		r_PtxRegister1439, r_PtxRegister1440;
	uint32_t r_PtxRegister1441, r_PtxRegister1442, r_PtxRegister1443, r_PtxRegister1444, r_PtxRegister1445,
		r_PtxRegister1446, r_PtxRegister1447, r_PtxRegister1448, r_PtxRegister1449, r_PtxRegister1450,
		r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_PtxRegister1453, r_PtxRegister1454, r_PtxRegister1455, r_PtxRegister1456, r_PtxRegister1457,
		r_PtxRegister1458, r_PtxRegister1459, r_PtxRegister1460, r_PtxRegister1461, r_PtxRegister1462,
		r_PtxRegister1463, r_PtxRegister1464;
	uint32_t r_PtxRegister1465, r_PtxRegister1466, r_PtxRegister1467, r_PtxRegister1468, r_PtxRegister1469,
		r_PtxRegister1470, r_PtxRegister1471, r_PtxRegister1472, r_PtxRegister1473, r_PtxRegister1474,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PtxRegister1479, r_PtxRegister1480, r_PtxRegister1481,
		r_PtxRegister1482, r_PtxRegister1483, r_PtxRegister1484, r_PtxRegister1485, r_PtxRegister1486,
		r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_PtxRegister1490, r_PtxRegister1491, r_PtxRegister1492, r_PtxRegister1493,
		r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497, r_PtxRegister1498,
		r_PtxRegister1499, r_PtxRegister1500;
	uint32_t r_PtxRegister1501, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_PtxRegister1505,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_PtxRegister1510,
		r_PtxRegister1511, r_PtxRegister1512;
	uint32_t r_PtxRegister1513, r_PtxRegister1514, r_PtxRegister1515, r_PtxRegister1516, r_PtxRegister1517,
		r_PtxRegister1518, r_PtxRegister1519, r_PtxRegister1520, r_PtxRegister1521, r_PtxRegister1522,
		r_PtxRegister1523, r_PtxRegister1524;
	uint32_t r_PtxRegister1525, r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528, r_PtxRegister1529,
		r_PtxRegister1530, r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533, r_PtxRegister1534,
		r_PtxRegister1535, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_PtxRegister1538, r_PtxRegister1539, r_PtxRegister1540, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PtxRegister1545, r_PtxRegister1546,
		r_PtxRegister1547, r_PtxRegister1548;
	uint32_t r_PtxRegister1549, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_PtxRegister1554, r_PtxRegister1555, r_PtxRegister1556, r_PtxRegister1557, r_PtxRegister1558,
		r_PtxRegister1559, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_PtxRegister1563, r_PtxRegister1564, r_PtxRegister1565,
		r_PtxRegister1566, r_PtxRegister1567, r_PtxRegister1568, r_PtxRegister1569, r_PtxRegister1570,
		r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_PtxRegister1575, r_PtxRegister1576, r_PtxRegister1577,
		r_PtxRegister1578, r_PtxRegister1579, r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
		r_PtxRegister1583, r_PtxRegister1584;
	uint32_t r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587, r_PtxRegister1588, r_PtxRegister1589,
		r_PtxRegister1590, r_PtxRegister1591, r_PtxRegister1592, r_PtxRegister1593, r_PtxRegister1594,
		r_PtxRegister1595, r_PtxRegister1596;
	uint32_t r_PtxRegister1597, r_PtxRegister1598, r_PtxRegister1599, r_PtxRegister1600, r_PtxRegister1601,
		r_PtxRegister1602, r_PtxRegister1603, r_PtxRegister1604, r_PtxRegister1605, r_PtxRegister1606,
		r_PtxRegister1607, r_PtxRegister1608;
	uint32_t r_PtxRegister1609, r_PtxRegister1610, r_PtxRegister1611, r_PtxRegister1612, r_PtxRegister1613,
		r_PtxRegister1614, r_PtxRegister1615, r_PtxRegister1616, r_PtxRegister1617, r_PtxRegister1618,
		r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_PtxRegister1626, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_PtxRegister1631, r_PtxRegister1632;
	uint32_t r_PtxRegister1633, r_PtxRegister1634, r_PtxRegister1635, r_PtxRegister1636, r_PtxRegister1637,
		r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640, r_PtxRegister1641, r_PtxRegister1642,
		r_PtxRegister1643, r_PtxRegister1644;
	uint32_t r_PtxRegister1645, r_PtxRegister1646, r_PtxRegister1647, r_PtxRegister1648, r_PtxRegister1649,
		r_PtxRegister1650, r_PtxRegister1651, r_PtxRegister1652, r_PtxRegister1653, r_PtxRegister1654,
		r_PtxRegister1655, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_PtxRegister1658, r_PtxRegister1659, r_PtxRegister1660, r_PtxRegister1661,
		r_PtxRegister1662, r_PtxRegister1663, r_PtxRegister1664, r_PtxRegister1665, r_PtxRegister1666,
		r_PtxRegister1667, r_PtxRegister1668;
	uint32_t r_PtxRegister1669, r_PtxRegister1670, r_PtxRegister1671, r_PtxRegister1672, r_PtxRegister1673,
		r_PtxRegister1674, r_PtxRegister1675, r_PtxRegister1676, r_PtxRegister1677, r_PtxRegister1678,
		r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_PtxRegister1689, r_PtxRegister1690,
		r_PtxRegister1691, r_PtxRegister1692;
	uint32_t r_PtxRegister1693, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700, r_PtxRegister1701, r_PtxRegister1702,
		r_PtxRegister1703, r_PtxRegister1704;
	uint32_t r_PtxRegister1705, r_PtxRegister1706, r_PtxRegister1707, r_PtxRegister1708, r_PtxRegister1709,
		r_PtxRegister1710, r_PtxRegister1711, r_PtxRegister1712, r_PtxRegister1713, r_PtxRegister1714,
		r_PtxRegister1715, r_PtxRegister1716;
	uint32_t r_PtxRegister1717, r_PtxRegister1718, r_PtxRegister1719, r_PtxRegister1720, r_PtxRegister1721,
		r_PtxRegister1722, r_PtxRegister1723, r_PtxRegister1724, r_PtxRegister1725, r_PtxRegister1726,
		r_PtxRegister1727, r_PtxRegister1728;
	uint32_t r_PtxRegister1729, r_PtxRegister1730, r_PtxRegister1731, r_PtxRegister1732, r_PtxRegister1733,
		r_PtxRegister1734, r_PtxRegister1735, r_PtxRegister1736, r_PtxRegister1737, r_PtxRegister1738,
		r_PtxRegister1739, r_PtxRegister1740;
	uint32_t r_PtxRegister1741, r_PtxRegister1742, r_PtxRegister1743, r_PtxRegister1744, r_PtxRegister1745,
		r_PtxRegister1746, r_PtxRegister1747, r_PtxRegister1748, r_PtxRegister1749, r_PtxRegister1750,
		r_PtxRegister1751, r_PtxRegister1752;
	uint32_t r_PtxRegister1753, r_PtxRegister1754, r_PtxRegister1755, r_PtxRegister1756, r_PtxRegister1757,
		r_PtxRegister1758, r_PtxRegister1759, r_PtxRegister1760, r_PtxRegister1761, r_PtxRegister1762,
		r_PtxRegister1763, r_PtxRegister1764;
	uint32_t r_PtxRegister1765, r_PtxRegister1766, r_PtxRegister1767, r_PtxRegister1768, r_PtxRegister1769,
		r_PtxRegister1770, r_PtxRegister1771, r_PtxRegister1772, r_PtxRegister1773, r_PtxRegister1774,
		r_PtxRegister1775, r_PtxRegister1776;
	uint32_t r_PtxRegister1777, r_PtxRegister1778, r_PtxRegister1779, r_PtxRegister1780, r_LaneIndexAtPtx3799,
		r_PtxRegister1782, r_LaneIndexAtPtx3809, r_PtxRegister1784, r_LaneIndexAtPtx3818, r_PtxRegister1786,
		r_LaneIndexAtPtx3827, r_PtxRegister1788;
	uint32_t r_LaneIndexAtPtx3836, r_PtxRegister1790, r_LaneIndexAtPtx3845, r_PtxRegister1792,
		r_LaneIndexAtPtx3854, r_PtxRegister1794, r_LaneIndexAtPtx3863, r_PtxRegister1796,
		r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		r_MmaAE4x4WordAtPtx3806R1800;
	uint32_t r_MmaAE4x4WordAtPtx3815R1801, r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803,
		r_MmaAE4x4WordAtPtx3815R1804, r_MmaAccumulatorHalf2WordAtPtx3872R1805,
		r_MmaAccumulatorHalf2WordAtPtx3872R1806, r_MmaAccumulatorHalf2WordAtPtx3879R1807,
		r_MmaAccumulatorHalf2WordAtPtx3879R1808, r_MmaAccumulatorHalf2WordAtPtx3900R1809,
		r_MmaAccumulatorHalf2WordAtPtx3900R1810, r_MmaAccumulatorHalf2WordAtPtx3907R1811,
		r_MmaAccumulatorHalf2WordAtPtx3907R1812;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3928R1813, r_MmaAccumulatorHalf2WordAtPtx3928R1814,
		r_MmaAccumulatorHalf2WordAtPtx3935R1815, r_MmaAccumulatorHalf2WordAtPtx3935R1816,
		r_MmaAccumulatorHalf2WordAtPtx3956R1817, r_MmaAccumulatorHalf2WordAtPtx3956R1818,
		r_MmaAccumulatorHalf2WordAtPtx3963R1819, r_MmaAccumulatorHalf2WordAtPtx3963R1820,
		r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		r_MmaAE4x4WordAtPtx3824R1824;
	uint32_t r_MmaAE4x4WordAtPtx3833R1825, r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827,
		r_MmaAE4x4WordAtPtx3833R1828, r_MmaAccumulatorHalf2WordAtPtx3984R1829,
		r_MmaAccumulatorHalf2WordAtPtx3984R1830, r_MmaAccumulatorHalf2WordAtPtx3991R1831,
		r_MmaAccumulatorHalf2WordAtPtx3991R1832, r_MmaAccumulatorHalf2WordAtPtx4012R1833,
		r_MmaAccumulatorHalf2WordAtPtx4012R1834, r_MmaAccumulatorHalf2WordAtPtx4019R1835,
		r_MmaAccumulatorHalf2WordAtPtx4019R1836;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4040R1837, r_MmaAccumulatorHalf2WordAtPtx4040R1838,
		r_MmaAccumulatorHalf2WordAtPtx4047R1839, r_MmaAccumulatorHalf2WordAtPtx4047R1840,
		r_MmaAccumulatorHalf2WordAtPtx4068R1841, r_MmaAccumulatorHalf2WordAtPtx4068R1842,
		r_MmaAccumulatorHalf2WordAtPtx4075R1843, r_MmaAccumulatorHalf2WordAtPtx4075R1844,
		r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		r_MmaAE4x4WordAtPtx3842R1848;
	uint32_t r_MmaAE4x4WordAtPtx3851R1849, r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851,
		r_MmaAE4x4WordAtPtx3851R1852, r_MmaAccumulatorHalf2WordAtPtx4096R1853,
		r_MmaAccumulatorHalf2WordAtPtx4096R1854, r_MmaAccumulatorHalf2WordAtPtx4103R1855,
		r_MmaAccumulatorHalf2WordAtPtx4103R1856, r_MmaAccumulatorHalf2WordAtPtx4124R1857,
		r_MmaAccumulatorHalf2WordAtPtx4124R1858, r_MmaAccumulatorHalf2WordAtPtx4131R1859,
		r_MmaAccumulatorHalf2WordAtPtx4131R1860;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4152R1861, r_MmaAccumulatorHalf2WordAtPtx4152R1862,
		r_MmaAccumulatorHalf2WordAtPtx4159R1863, r_MmaAccumulatorHalf2WordAtPtx4159R1864,
		r_MmaAccumulatorHalf2WordAtPtx4180R1865, r_MmaAccumulatorHalf2WordAtPtx4180R1866,
		r_MmaAccumulatorHalf2WordAtPtx4187R1867, r_MmaAccumulatorHalf2WordAtPtx4187R1868,
		r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		r_MmaAE4x4WordAtPtx3860R1872;
	uint32_t r_MmaAE4x4WordAtPtx3869R1873, r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875,
		r_MmaAE4x4WordAtPtx3869R1876, r_MmaAccumulatorHalf2WordAtPtx4208R1877,
		r_MmaAccumulatorHalf2WordAtPtx4208R1878, r_MmaAccumulatorHalf2WordAtPtx4215R1879,
		r_MmaAccumulatorHalf2WordAtPtx4215R1880, r_MmaAccumulatorHalf2WordAtPtx4236R1881,
		r_MmaAccumulatorHalf2WordAtPtx4236R1882, r_MmaAccumulatorHalf2WordAtPtx4243R1883,
		r_MmaAccumulatorHalf2WordAtPtx4243R1884;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx4264R1885, r_MmaAccumulatorHalf2WordAtPtx4264R1886,
		r_MmaAccumulatorHalf2WordAtPtx4271R1887, r_MmaAccumulatorHalf2WordAtPtx4271R1888,
		r_MmaAccumulatorHalf2WordAtPtx4292R1889, r_MmaAccumulatorHalf2WordAtPtx4292R1890,
		r_MmaAccumulatorHalf2WordAtPtx4299R1891, r_MmaAccumulatorHalf2WordAtPtx4299R1892, r_PtxRegister1893,
		r_PtxRegister1894, r_PtxRegister1895, r_PtxRegister1896;
	uint32_t r_PtxRegister1897, r_PtxRegister1898, r_PtxRegister1899, r_PtxRegister1900, r_PtxRegister1901,
		r_PtxRegister1902, r_PtxRegister1903, r_PtxRegister1904, r_PtxRegister1905, r_PtxRegister1906,
		r_PtxRegister1907, r_PtxRegister1908;
	uint32_t r_PtxRegister1909, r_PtxRegister1910, r_PtxRegister1911, r_LaneIndexAtPtx4329,
		r_LaneIndexAtPtx4337, r_LaneIndexAtPtx4346, r_LaneIndexAtPtx4355, r_LaneIndexAtPtx4364,
		r_LaneIndexAtPtx4373, r_LaneIndexAtPtx4382, r_LaneIndexAtPtx4391, r_PtxRegister1920;
	uint32_t r_PtxRegister1921, r_PtxRegister1922, r_PtxRegister1923, r_PtxRegister1924, r_PtxRegister1925,
		r_PtxRegister1926, r_PtxRegister1927, r_PtxRegister1928, r_PtxRegister1929, r_PtxRegister1930,
		r_PtxRegister1931, r_PtxRegister1932;
	uint32_t r_PtxRegister1933, r_PtxRegister1934, r_PtxRegister1935, r_PtxRegister1936, r_PtxRegister1937,
		r_PtxRegister1938, r_PtxRegister1939, r_PtxRegister1940, r_PtxRegister1941, r_PtxRegister1942,
		r_PtxRegister1943, r_PtxRegister1944;
	uint32_t r_PackedHalf2AtPtx4495R1945, r_LaneIndexAtPtx4501, r_PtxRegister1947,
		r_PackedE4WordAtPtx4499R1948, r_PtxRegister1949, r_PtxRegister1950, r_PtxRegister1951,
		r_PtxRegister1952, r_PtxRegister1953, r_PtxRegister1954, r_PtxRegister1955, r_PtxRegister1956;
	uint32_t r_PtxRegister1957, r_PtxRegister1958, r_ThreadYAtPtx4474, r_PtxRegister1960, r_PtxRegister1961,
		r_PtxRegister1962, r_PtxRegister1963, r_PtxRegister1964, r_PtxRegister1965, r_PtxRegister1966,
		r_PtxRegister1967, r_PtxRegister1968;
	uint32_t r_PtxRegister1969, r_PtxRegister1970, r_PtxRegister1971, r_PtxRegister1972, r_PtxRegister1973,
		r_PtxRegister1974, r_PtxRegister1975, r_PtxRegister1976, r_PtxRegister1977,
		r_PackedHalf2AtPtx4576R1978, r_LaneIndexAtPtx4582, r_PtxRegister1980;
	uint32_t r_PackedE4WordAtPtx4580R1981, r_PtxRegister1982, r_PtxRegister1983, r_PtxRegister1984,
		r_PtxRegister1985, r_PtxRegister1986, r_PtxRegister1987, r_PtxRegister1988, r_PtxRegister1989,
		r_PtxRegister1990, r_PtxRegister1991, r_PtxRegister1992;
	uint32_t r_PtxRegister1993, r_LaneIndexAtPtx4806, r_PackedE4WordAtPtx4804R1995,
		r_PackedE4WordAtPtx4803R1996, r_PackedE4WordAtPtx4802R1997, r_PackedE4WordAtPtx4801R1998,
		r_LaneIndexAtPtx4814, r_PackedE4WordAtPtx4800R2000, r_PackedE4WordAtPtx4799R2001,
		r_PackedE4WordAtPtx4798R2002, r_PackedE4WordAtPtx4797R2003, r_LaneIndexAtPtx4829;
	uint32_t r_PackedE4WordAtPtx4837R2005, r_PackedE4WordAtPtx4836R2006, r_PackedE4WordAtPtx4835R2007,
		r_PackedE4WordAtPtx4834R2008, r_LaneIndexAtPtx4842, r_PackedE4WordAtPtx4850R2010,
		r_PackedE4WordAtPtx4849R2011, r_PackedE4WordAtPtx4848R2012, r_PackedE4WordAtPtx4847R2013,
		r_PtxRegister2014, r_PtxRegister2015, r_PtxRegister2016;
	uint32_t r_PtxRegister2017, r_LaneIndexAtPtx4867, r_PackedE4WordAtPtx4874R2019,
		r_PackedE4WordAtPtx4873R2020, r_PackedE4WordAtPtx4872R2021, r_PackedE4WordAtPtx4871R2022,
		r_LaneIndexAtPtx4879, r_PackedE4WordAtPtx4887R2024, r_PackedE4WordAtPtx4886R2025,
		r_PackedE4WordAtPtx4885R2026, r_PackedE4WordAtPtx4884R2027, r_LaneIndexAtPtx4896;
	uint32_t r_PackedE4WordAtPtx4904R2029, r_PackedE4WordAtPtx4903R2030, r_PackedE4WordAtPtx4902R2031,
		r_PackedE4WordAtPtx4901R2032, r_LaneIndexAtPtx4909, r_PackedE4WordAtPtx4917R2034,
		r_PackedE4WordAtPtx4916R2035, r_PackedE4WordAtPtx4915R2036, r_PackedE4WordAtPtx4914R2037,
		r_PtxRegister2038, r_PtxRegister2039, r_PtxRegister2040;
	uint32_t r_PtxRegister2041, r_PtxRegister2042, r_PtxRegister2043, r_PtxRegister2044, r_PtxRegister2045,
		r_PtxRegister2046, r_PtxRegister2047, r_PtxRegister2048, r_PtxRegister2049, r_PtxRegister2050,
		r_PtxRegister2051, r_PtxRegister2052;
	uint32_t r_PtxRegister2053, r_PtxRegister2054, r_PtxRegister2055, r_PtxRegister2056, r_PtxRegister2057,
		r_PtxRegister2058, r_PtxRegister2059, r_PtxRegister2060, r_PtxRegister2061, r_PtxRegister2062,
		r_PtxRegister2063, r_PtxRegister2064;
	uint32_t r_PtxRegister2065, r_PtxRegister2066, r_PtxRegister2067, r_PtxRegister2068, r_PtxRegister2069,
		r_PtxRegister2070, r_PtxRegister2071, r_PtxRegister2072, r_PtxRegister2073, r_PtxRegister2074,
		r_PtxRegister2075, r_PackedHalf2AtPtx3782R2076;
	uint32_t r_PackedHalf2AtPtx3775R2077, r_PackedHalf2AtPtx3768R2078, r_PackedHalf2AtPtx3761R2079,
		r_PackedHalf2AtPtx3754R2080, r_PackedHalf2AtPtx3747R2081, r_PackedHalf2AtPtx3740R2082,
		r_PackedHalf2AtPtx3733R2083, r_PackedHalf2AtPtx3726R2084, r_PackedHalf2AtPtx3719R2085,
		r_PackedHalf2AtPtx3712R2086, r_PackedHalf2AtPtx3705R2087, r_PackedHalf2AtPtx3698R2088;
	uint32_t r_PackedHalf2AtPtx3691R2089, r_PackedHalf2AtPtx3684R2090, r_PackedHalf2AtPtx3677R2091,
		r_PackedHalf2AtPtx3670R2092, r_PackedHalf2AtPtx3663R2093, r_PackedHalf2AtPtx3656R2094,
		r_PackedHalf2AtPtx3649R2095, r_PackedHalf2AtPtx3642R2096, r_PackedHalf2AtPtx3635R2097,
		r_PackedHalf2AtPtx3628R2098, r_PackedHalf2AtPtx3621R2099, r_PackedHalf2AtPtx3614R2100;
	uint32_t r_PackedHalf2AtPtx3607R2101, r_PackedHalf2AtPtx3600R2102, r_PackedHalf2AtPtx3593R2103,
		r_PackedHalf2AtPtx3586R2104, r_PackedHalf2AtPtx3579R2105, r_PackedHalf2AtPtx3572R2106,
		r_PackedHalf2AtPtx3565R2107, r_PackedHalf2AtPtx3558R2108, r_PackedHalf2AtPtx3551R2109,
		r_PackedHalf2AtPtx3544R2110, r_PackedHalf2AtPtx3537R2111, r_PackedHalf2AtPtx3530R2112;
	uint32_t r_PackedHalf2AtPtx3523R2113, r_PackedHalf2AtPtx3516R2114, r_PackedHalf2AtPtx3509R2115,
		r_PackedHalf2AtPtx3502R2116, r_PackedHalf2AtPtx3495R2117, r_PackedHalf2AtPtx3488R2118,
		r_PackedHalf2AtPtx3481R2119, r_PackedHalf2AtPtx3474R2120, r_PackedHalf2AtPtx3467R2121,
		r_PackedHalf2AtPtx3460R2122, r_PackedHalf2AtPtx3453R2123, r_PackedHalf2AtPtx3446R2124;
	uint32_t r_PackedHalf2AtPtx3439R2125, r_PackedHalf2AtPtx3432R2126, r_PackedHalf2AtPtx3425R2127,
		r_PackedHalf2AtPtx3418R2128, r_PackedHalf2AtPtx3411R2129, r_PackedHalf2AtPtx3404R2130,
		r_PackedHalf2AtPtx3397R2131, r_PackedHalf2AtPtx3390R2132, r_PackedHalf2AtPtx3383R2133,
		r_PackedHalf2AtPtx3376R2134, r_PackedHalf2AtPtx3369R2135, r_PackedHalf2AtPtx3362R2136;
	uint32_t r_PackedHalf2AtPtx3355R2137, r_PackedHalf2AtPtx3348R2138, r_PackedHalf2AtPtx3341R2139,
		r_PtxRegister2140, r_MmaBE4x4WordAtPtx143R2141, r_MmaBE4x4WordAtPtx143R2142,
		r_MmaBE4x4WordAtPtx134R2143, r_MmaBE4x4WordAtPtx134R2144, r_MmaBE4x4WordAtPtx134R2145,
		r_MmaBE4x4WordAtPtx134R2146, r_MmaBE4x4WordAtPtx125R2147, r_MmaBE4x4WordAtPtx125R2148;
	uint32_t r_MmaBE4x4WordAtPtx125R2149, r_MmaBE4x4WordAtPtx125R2150, r_MmaBE4x4WordAtPtx116R2151,
		r_MmaBE4x4WordAtPtx116R2152, r_MmaBE4x4WordAtPtx116R2153, r_MmaBE4x4WordAtPtx116R2154,
		r_MmaBE4x4WordAtPtx107R2155, r_MmaBE4x4WordAtPtx107R2156, r_MmaBE4x4WordAtPtx107R2157,
		r_MmaBE4x4WordAtPtx107R2158, r_MmaBE4x4WordAtPtx98R2159, r_MmaBE4x4WordAtPtx98R2160;
	uint32_t r_MmaBE4x4WordAtPtx98R2161, r_MmaBE4x4WordAtPtx98R2162, r_MmaBE4x4WordAtPtx89R2163,
		r_MmaBE4x4WordAtPtx89R2164, r_MmaBE4x4WordAtPtx89R2165, r_MmaBE4x4WordAtPtx89R2166,
		r_MmaBE4x4WordAtPtx80R2167, r_MmaBE4x4WordAtPtx80R2168, r_MmaBE4x4WordAtPtx80R2169,
		r_MmaBE4x4WordAtPtx80R2170, r_MmaBE4x4WordAtPtx143R2171, r_MmaBE4x4WordAtPtx143R2172;
	uint64_t g_StateBaseAddress, g_ResidualByteAddressAtPtx19, g_OutputByteAddressAtPtx4794,
		g_OutputByteAddressAtPtx4863, g_ResidualBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress,
		g_RecordByteAddressAtPtx78, g_RecordByteAddressAtPtx87, g_RecordByteAddressAtPtx96,
		g_RecordByteAddressAtPtx105, g_RecordByteAddressAtPtx114;
	uint64_t g_RecordByteAddressAtPtx123, g_RecordByteAddressAtPtx132, g_RecordByteAddressAtPtx141,
		r_PtxU64Register16, g_RecordByteAddressAtPtx73, r_PtxU64Register18, r_PtxU64Register19,
		g_RecordByteAddressAtPtx86, r_PtxU64Register21, g_RecordByteAddressAtPtx95, r_PtxU64Register23,
		g_RecordByteAddressAtPtx104;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx113, r_PtxU64Register27, g_RecordByteAddressAtPtx122,
		r_PtxU64Register29, g_RecordByteAddressAtPtx131, r_PtxU64Register31, g_RecordByteAddressAtPtx140,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		r_PtxU64Register46, g_ResidualByteAddressAtPtx666, r_PtxU64Register48;
	uint64_t g_ResidualByteAddressAtPtx716, r_PtxU64Register50, g_ResidualByteAddressAtPtx766,
		r_PtxU64Register52, g_ResidualByteAddressAtPtx816, r_PtxU64Register54, g_ResidualByteAddressAtPtx866,
		r_PtxU64Register56, g_ResidualByteAddressAtPtx916, r_PtxU64Register58, g_ResidualByteAddressAtPtx966,
		r_PtxU64Register60;
	uint64_t g_ResidualByteAddressAtPtx1016, r_PtxU64Register62, g_ResidualByteAddressAtPtx1064,
		r_PtxU64Register64, g_ResidualByteAddressAtPtx1113, r_PtxU64Register66,
		g_ResidualByteAddressAtPtx1161, r_PtxU64Register68, g_ResidualByteAddressAtPtx1210,
		r_PtxU64Register70, g_ResidualByteAddressAtPtx1258, r_PtxU64Register72;
	uint64_t g_ResidualByteAddressAtPtx1307, r_PtxU64Register74, g_ResidualByteAddressAtPtx1355,
		r_PtxU64Register76, g_ResidualByteAddressAtPtx1404, r_PtxU64Register78,
		g_ResidualByteAddressAtPtx1454, r_PtxU64Register80, g_ResidualByteAddressAtPtx1504,
		r_PtxU64Register82, g_ResidualByteAddressAtPtx1554, r_PtxU64Register84;
	uint64_t g_ResidualByteAddressAtPtx1604, r_PtxU64Register86, g_ResidualByteAddressAtPtx1654,
		r_PtxU64Register88, g_ResidualByteAddressAtPtx1704, r_PtxU64Register90,
		g_ResidualByteAddressAtPtx1754, r_PtxU64Register92, g_ResidualByteAddressAtPtx1804,
		r_PtxU64Register94, g_ResidualByteAddressAtPtx1852, r_PtxU64Register96;
	uint64_t g_ResidualByteAddressAtPtx1900, r_PtxU64Register98, g_ResidualByteAddressAtPtx1948,
		r_PtxU64Register100, g_ResidualByteAddressAtPtx1996, r_PtxU64Register102,
		g_ResidualByteAddressAtPtx2044, r_PtxU64Register104, g_ResidualByteAddressAtPtx2092,
		r_PtxU64Register106, g_ResidualByteAddressAtPtx2142, r_PtxU64Register108;
	uint64_t g_ResidualByteAddressAtPtx2189, g_RecordByteAddressAtPtx2386, r_PtxU64Register111,
		g_RecordByteAddressAtPtx2400, r_PtxU64Register113, g_RecordByteAddressAtPtx2414, r_PtxU64Register115,
		g_RecordByteAddressAtPtx2428, r_PtxU64Register117, g_RecordByteAddressAtPtx2442, r_PtxU64Register119,
		g_RecordByteAddressAtPtx2456;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx2470, r_PtxU64Register123,
		g_RecordByteAddressAtPtx2487, r_PtxU64Register125, g_RecordByteAddressAtPtx2503, r_PtxU64Register127,
		g_RecordByteAddressAtPtx2518, r_PtxU64Register129, g_RecordByteAddressAtPtx2532, r_PtxU64Register131,
		g_RecordByteAddressAtPtx2549;
	uint64_t r_PtxU64Register133, g_RecordByteAddressAtPtx2565, r_PtxU64Register135,
		g_RecordByteAddressAtPtx2580, r_PtxU64Register137, g_RecordByteAddressAtPtx2594, r_PtxU64Register139,
		g_RecordByteAddressAtPtx2611, r_PtxU64Register141, g_RecordByteAddressAtPtx2627, r_PtxU64Register143,
		g_RecordByteAddressAtPtx2641;
	uint64_t r_PtxU64Register145, g_RecordByteAddressAtPtx2655, r_PtxU64Register147,
		g_RecordByteAddressAtPtx2669, r_PtxU64Register149, g_RecordByteAddressAtPtx2683, r_PtxU64Register151,
		g_RecordByteAddressAtPtx2697, r_PtxU64Register153, g_RecordByteAddressAtPtx2711, r_PtxU64Register155,
		g_RecordByteAddressAtPtx2727;
	uint64_t r_PtxU64Register157, g_RecordByteAddressAtPtx2743, r_PtxU64Register159,
		g_RecordByteAddressAtPtx2757, r_PtxU64Register161, g_RecordByteAddressAtPtx2771, r_PtxU64Register163,
		g_RecordByteAddressAtPtx2787, r_PtxU64Register165, g_RecordByteAddressAtPtx2803, r_PtxU64Register167,
		g_RecordByteAddressAtPtx2817;
	uint64_t r_PtxU64Register169, g_RecordByteAddressAtPtx2831, r_PtxU64Register171,
		g_RecordByteAddressAtPtx2847, r_PtxU64Register173, g_RecordByteAddressAtPtx2863, r_PtxU64Register175,
		g_RecordByteAddressAtPtx2877, r_PtxU64Register177, g_RecordByteAddressAtPtx2891, r_PtxU64Register179,
		g_RecordByteAddressAtPtx2905;
	uint64_t r_PtxU64Register181, g_RecordByteAddressAtPtx2919, r_PtxU64Register183,
		g_RecordByteAddressAtPtx2933, r_PtxU64Register185, g_RecordByteAddressAtPtx2947, r_PtxU64Register187,
		g_RecordByteAddressAtPtx2963, r_PtxU64Register189, g_RecordByteAddressAtPtx2979, r_PtxU64Register191,
		g_RecordByteAddressAtPtx2993;
	uint64_t r_PtxU64Register193, g_RecordByteAddressAtPtx3007, r_PtxU64Register195,
		g_RecordByteAddressAtPtx3023, r_PtxU64Register197, g_RecordByteAddressAtPtx3039, r_PtxU64Register199,
		g_RecordByteAddressAtPtx3053, r_PtxU64Register201, g_RecordByteAddressAtPtx3067, r_PtxU64Register203,
		g_RecordByteAddressAtPtx3083;
	uint64_t r_PtxU64Register205, g_RecordByteAddressAtPtx3099, r_PtxU64Register207,
		g_RecordByteAddressAtPtx3113, r_PtxU64Register209, g_RecordByteAddressAtPtx3127, r_PtxU64Register211,
		g_RecordByteAddressAtPtx3141, r_PtxU64Register213, g_RecordByteAddressAtPtx3155, r_PtxU64Register215,
		g_RecordByteAddressAtPtx3169;
	uint64_t r_PtxU64Register217, g_RecordByteAddressAtPtx3183, r_PtxU64Register219,
		g_RecordByteAddressAtPtx3199, r_PtxU64Register221, g_RecordByteAddressAtPtx3215, r_PtxU64Register223,
		g_RecordByteAddressAtPtx3229, r_PtxU64Register225, g_RecordByteAddressAtPtx3243, r_PtxU64Register227,
		g_RecordByteAddressAtPtx3259;
	uint64_t r_PtxU64Register229, g_RecordByteAddressAtPtx3275, r_PtxU64Register231,
		g_RecordByteAddressAtPtx3289, r_PtxU64Register233, g_RecordByteAddressAtPtx3303, r_PtxU64Register235,
		g_RecordByteAddressAtPtx3319, r_PtxU64Register237, g_RecordByteAddressAtPtx3335,
		g_RecordByteAddressAtPtx4332, g_RecordByteAddressAtPtx4341;
	uint64_t g_RecordByteAddressAtPtx4350, g_RecordByteAddressAtPtx4359, g_RecordByteAddressAtPtx4368,
		g_RecordByteAddressAtPtx4377, g_RecordByteAddressAtPtx4386, g_RecordByteAddressAtPtx4395,
		r_PtxU64Register247, g_RecordByteAddressAtPtx4327, r_PtxU64Register249, r_PtxU64Register250,
		g_RecordByteAddressAtPtx4340, r_PtxU64Register252;
	uint64_t g_RecordByteAddressAtPtx4349, r_PtxU64Register254, g_RecordByteAddressAtPtx4358,
		r_PtxU64Register256, g_RecordByteAddressAtPtx4367, r_PtxU64Register258, g_RecordByteAddressAtPtx4376,
		r_PtxU64Register260, g_RecordByteAddressAtPtx4385, r_PtxU64Register262, g_RecordByteAddressAtPtx4394,
		r_PtxU64Register264;
	uint64_t r_PtxU64Register265, r_PtxU64Register266, r_PtxU64Register267, r_PtxU64Register268,
		r_PtxU64Register269, g_OutputByteAddressAtPtx4809, g_OutputByteAddressAtPtx4818, r_PtxU64Register272,
		r_PtxU64Register273, g_OutputByteAddressAtPtx4817, g_OutputByteAddressAtPtx4833,
		g_OutputByteAddressAtPtx4846;
	uint64_t r_PtxU64Register277, g_OutputByteAddressAtPtx4832, r_PtxU64Register279,
		g_OutputByteAddressAtPtx4845, r_PtxU64Register281, g_OutputByteAddressAtPtx4870,
		g_OutputByteAddressAtPtx4883, r_PtxU64Register284, r_PtxU64Register285, g_OutputByteAddressAtPtx4882,
		g_OutputByteAddressAtPtx4900, g_OutputByteAddressAtPtx4913;
	uint64_t r_PtxU64Register289, g_OutputByteAddressAtPtx4899, r_PtxU64Register291,
		g_OutputByteAddressAtPtx4912, r_PtxU64Register293, r_PtxU64Register294, r_PtxU64Register295,
		r_PtxU64Register296, r_PtxU64Register297, r_PtxU64Register298, r_PtxU64Register299,
		r_PtxU64Register300;
	uint64_t r_PtxU64Register301, r_PtxU64Register302, r_PtxU64Register303, r_PtxU64Register304,
		r_PtxU64Register305, r_PtxU64Register306, r_PtxU64Register307, r_PtxU64Register308;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L16
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);									  // PTX L17
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip);						  // PTX L18
	g_ResidualByteAddressAtPtx19 = g_ResidualBaseAddress;						  // PTX L19
	r_CtaX = uint32_t(blockIdx.x);												  // PTX L20
	r_CtaY = uint32_t(blockIdx.y);												  // PTX L21
	r_CtaZ = uint32_t(blockIdx.z);												  // PTX L22
	r_PtxRegister106 = uint32_t(r_WidthBits) + uint32_t(-1);					  // PTX L23
	r_PtxRegister107 = ShiftRightSigned(int32_t(r_PtxRegister106), uint32_t(31)); // PTX L24
	r_PtxRegister108 = ShiftRight(uint32_t(r_PtxRegister107), uint32_t(29));	  // PTX L25
	r_PtxRegister109 = uint32_t(r_PtxRegister106) + uint32_t(r_PtxRegister108);	  // PTX L26
	r_PtxRegister110 = ShiftRightSigned(int32_t(r_PtxRegister109), uint32_t(3));  // PTX L27
	r_PtxRegister111 = uint32_t(r_PtxRegister110) + uint32_t(1);				  // PTX L28
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister111));		  // PTX L29
	r_PtxRegister112 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister110) + uint32_t(r_PtxRegister2); // PTX L30
	r_PtxRegister113 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister112);					  // PTX L31
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L32
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaY), uint32_t(3));							  // PTX L33
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(3));				  // PTX L34
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(1));				  // PTX L35
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));			  // PTX L36
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));			  // PTX L37
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);		  // PTX L38
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2));	  // PTX L39
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));				  // PTX L40
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));				  // PTX L41
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);			  // PTX L42
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));		  // PTX L43
	r_ThreadX = uint32_t(threadIdx.x);													  // PTX L44
	r_ThreadYAtPtx45 = uint32_t(threadIdx.y);											  // PTX L45
	r_PtxRegister121 = r_ThreadX | r_ThreadYAtPtx45;									  // PTX L46
	r_bPtxPredicate40 = uint32_t(r_PtxRegister121) != uint32_t(0);						  // PTX L47
	if (r_bPtxPredicate40)
	{
		goto L__BB19_2;
	} // PTX L48
	r_BlockSizeX = uint32_t(blockDim.x);										 // PTX L49
	r_BlockSizeY = uint32_t(blockDim.y);										 // PTX L50
	r_PtxRegister123 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			 // PTX L51
	r_PtxRegister122 = uint32_t(12288u /* exact native shared-region offset */); // PTX L52
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister122, r_PtxRegister123); // PTX L54
	r_PtxRegister124 = uint32_t(r_PtxRegister122) + uint32_t(8);	  // PTX L56
	BarrierInit(s_SharedStorage, r_PtxRegister124, r_PtxRegister123); // PTX L58
	r_PtxRegister125 = uint32_t(r_PtxRegister122) + uint32_t(16);	  // PTX L60
	BarrierInit(s_SharedStorage, r_PtxRegister125, r_PtxRegister123); // PTX L62
L__BB19_2:															  // PTX L64
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L65
	r_PtxRegister136 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(6));						// PTX L66
	r_PtxRegister137 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));						// PTX L67
	r_PtxRegister10 = uint32_t(r_PtxRegister136) + uint32_t(r_PtxRegister137);					// PTX L68
	r_PtxRegister138 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(16));								// PTX L69
	r_PtxRegister139 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(3));						// PTX L70
	r_PtxRegister140 = uint32_t(r_PtxRegister138) + uint32_t(r_PtxRegister139);					// PTX L71
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_PtxRegister140)) * int64_t(int32_t(4)));	// PTX L72
	g_RecordByteAddressAtPtx73 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register16);	// PTX L73
	r_LaneIndexAtPtx75 = uint32_t((threadIdx.x & 31u));											// PTX L75
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx75)) * int64_t(int32_t(16))); // PTX L77
	g_RecordByteAddressAtPtx78 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register18); // PTX L78
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx78));
		r_MmaBE4x4WordAtPtx80R2170 = r_Value.x;
		r_MmaBE4x4WordAtPtx80R2169 = r_Value.y;
		r_MmaBE4x4WordAtPtx80R2168 = r_Value.z;
		r_MmaBE4x4WordAtPtx80R2167 = r_Value.w;
	} // PTX L80
	r_LaneIndexAtPtx83 = uint32_t((threadIdx.x & 31u));											// PTX L83
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx83)) * int64_t(int32_t(16))); // PTX L85
	g_RecordByteAddressAtPtx86 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register19);		   // PTX L86
	g_RecordByteAddressAtPtx87 = uint64_t(g_RecordByteAddressAtPtx86) + uint64_t(512); // PTX L87
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx87));
		r_MmaBE4x4WordAtPtx89R2166 = r_Value.x;
		r_MmaBE4x4WordAtPtx89R2165 = r_Value.y;
		r_MmaBE4x4WordAtPtx89R2164 = r_Value.z;
		r_MmaBE4x4WordAtPtx89R2163 = r_Value.w;
	} // PTX L89
	r_LaneIndexAtPtx92 = uint32_t((threadIdx.x & 31u));											// PTX L92
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx92)) * int64_t(int32_t(16))); // PTX L94
	g_RecordByteAddressAtPtx95 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register21);			// PTX L95
	g_RecordByteAddressAtPtx96 = uint64_t(g_RecordByteAddressAtPtx95) + uint64_t(1024); // PTX L96
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx96));
		r_MmaBE4x4WordAtPtx98R2162 = r_Value.x;
		r_MmaBE4x4WordAtPtx98R2161 = r_Value.y;
		r_MmaBE4x4WordAtPtx98R2160 = r_Value.z;
		r_MmaBE4x4WordAtPtx98R2159 = r_Value.w;
	} // PTX L98
	r_LaneIndexAtPtx101 = uint32_t((threadIdx.x & 31u));										 // PTX L101
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx101)) * int64_t(int32_t(16))); // PTX L103
	g_RecordByteAddressAtPtx104 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register23);			  // PTX L104
	g_RecordByteAddressAtPtx105 = uint64_t(g_RecordByteAddressAtPtx104) + uint64_t(1536); // PTX L105
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx105));
		r_MmaBE4x4WordAtPtx107R2158 = r_Value.x;
		r_MmaBE4x4WordAtPtx107R2157 = r_Value.y;
		r_MmaBE4x4WordAtPtx107R2156 = r_Value.z;
		r_MmaBE4x4WordAtPtx107R2155 = r_Value.w;
	} // PTX L107
	r_LaneIndexAtPtx110 = uint32_t((threadIdx.x & 31u));										 // PTX L110
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx110)) * int64_t(int32_t(16))); // PTX L112
	g_RecordByteAddressAtPtx113 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register25);			   // PTX L113
	g_RecordByteAddressAtPtx114 = uint64_t(g_RecordByteAddressAtPtx113) + uint64_t(16384); // PTX L114
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx114));
		r_MmaBE4x4WordAtPtx116R2154 = r_Value.x;
		r_MmaBE4x4WordAtPtx116R2153 = r_Value.y;
		r_MmaBE4x4WordAtPtx116R2152 = r_Value.z;
		r_MmaBE4x4WordAtPtx116R2151 = r_Value.w;
	} // PTX L116
	r_LaneIndexAtPtx119 = uint32_t((threadIdx.x & 31u));										 // PTX L119
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx119)) * int64_t(int32_t(16))); // PTX L121
	g_RecordByteAddressAtPtx122 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register27);			   // PTX L122
	g_RecordByteAddressAtPtx123 = uint64_t(g_RecordByteAddressAtPtx122) + uint64_t(16896); // PTX L123
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx123));
		r_MmaBE4x4WordAtPtx125R2150 = r_Value.x;
		r_MmaBE4x4WordAtPtx125R2149 = r_Value.y;
		r_MmaBE4x4WordAtPtx125R2148 = r_Value.z;
		r_MmaBE4x4WordAtPtx125R2147 = r_Value.w;
	} // PTX L125
	r_LaneIndexAtPtx128 = uint32_t((threadIdx.x & 31u));										 // PTX L128
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx128)) * int64_t(int32_t(16))); // PTX L130
	g_RecordByteAddressAtPtx131 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register29);			   // PTX L131
	g_RecordByteAddressAtPtx132 = uint64_t(g_RecordByteAddressAtPtx131) + uint64_t(17408); // PTX L132
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx132));
		r_MmaBE4x4WordAtPtx134R2146 = r_Value.x;
		r_MmaBE4x4WordAtPtx134R2145 = r_Value.y;
		r_MmaBE4x4WordAtPtx134R2144 = r_Value.z;
		r_MmaBE4x4WordAtPtx134R2143 = r_Value.w;
	} // PTX L134
	r_LaneIndexAtPtx137 = uint32_t((threadIdx.x & 31u));										 // PTX L137
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx137)) * int64_t(int32_t(16))); // PTX L139
	g_RecordByteAddressAtPtx140 =
		uint64_t(g_RecordByteAddressAtPtx73) + uint64_t(r_PtxU64Register31);			   // PTX L140
	g_RecordByteAddressAtPtx141 = uint64_t(g_RecordByteAddressAtPtx140) + uint64_t(17920); // PTX L141
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx141));
		r_MmaBE4x4WordAtPtx143R2142 = r_Value.x;
		r_MmaBE4x4WordAtPtx143R2141 = r_Value.y;
		r_MmaBE4x4WordAtPtx143R2171 = r_Value.z;
		r_MmaBE4x4WordAtPtx143R2172 = r_Value.w;
	} // PTX L143
	r_PtxRegister11 = r_ThreadYAtPtx45 & 1;									   // PTX L145
	r_PtxRegister141 = ShiftRight(uint32_t(r_ThreadYAtPtx45), uint32_t(1));	   // PTX L146
	r_PtxRegister142 = r_PtxRegister141 & 1;								   // PTX L147
	r_PtxRegister143 = ShiftRight(uint32_t(r_ThreadYAtPtx45), uint32_t(2));	   // PTX L148
	r_PtxRegister144 = ShiftLeft(uint32_t(r_PtxRegister143), uint32_t(9));	   // PTX L149
	r_PtxRegister145 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(7));	   // PTX L150
	r_PtxRegister12 = r_PtxRegister145 & 256;								   // PTX L151
	r_PtxRegister146 = r_PtxRegister144 | r_PtxRegister12;					   // PTX L152
	r_PtxRegister13 = r_PtxRegister145 & 128;								   // PTX L153
	r_PtxRegister14 = r_PtxRegister146 | r_PtxRegister13;					   // PTX L154
	r_PtxRegister147 = uint32_t(r_PtxRegister143) + uint32_t(r_PtxRegister3);  // PTX L155
	r_PtxRegister15 = uint32_t(r_PtxRegister142) + uint32_t(r_PtxRegister6);   // PTX L156
	r_PtxRegister16 = r_HeightBits & -4;									   // PTX L157
	r_bPtxPredicate41 = uint32_t(r_PtxRegister16) == uint32_t(4);			   // PTX L158
	r_bPtxPredicate42 = int32_t(r_PtxRegister147) < int32_t(r_HeightDiv4Bits); // PTX L159
	r_PtxRegister148 = uint32_t(r_PtxRegister147) * uint32_t(r_WidthDiv4Bits); // PTX L160
	r_PtxRegister17 = r_bPtxPredicate41 ? 0 : r_PtxRegister148;				   // PTX L161
	r_bPtxPredicate1 = r_bPtxPredicate41 | r_bPtxPredicate42;				   // PTX L162
	r_bPtxPredicate604 = bool(0);											   // PTX L163
	r_bPtxPredicate43 = !r_bPtxPredicate1;									   // PTX L164
	r_PtxRegister2038 = uint32_t(r_PtxRegister15);							   // PTX L165
	if (r_bPtxPredicate43)
	{
		goto L__BB19_5;
	} // PTX L166
	r_PtxRegister149 = r_WidthBits & -4;						   // PTX L167
	r_bPtxPredicate44 = uint32_t(r_PtxRegister149) == uint32_t(4); // PTX L168
	r_bPtxPredicate604 = bool(-1);								   // PTX L169
	r_PtxRegister2038 = uint32_t(0);							   // PTX L170
	if (r_bPtxPredicate44)
	{
		goto L__BB19_5;
	} // PTX L171
	r_bPtxPredicate604 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L172
	r_PtxRegister2038 = uint32_t(r_PtxRegister15);							  // PTX L173
L__BB19_5:																	  // PTX L174
	r_PtxU64Register293 = uint64_t(0);										  // PTX L175
	r_bPtxPredicate45 = !r_bPtxPredicate604;								  // PTX L176
	if (r_bPtxPredicate45)
	{
		goto L__BB19_7;
	} // PTX L177
	r_PtxRegister150 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister2038); // PTX L178
	r_PtxRegister151 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister150);			// PTX L179
	r_PtxRegister152 = ShiftLeft(uint32_t(r_PtxRegister151), uint32_t(11));		// PTX L180
	r_PtxRegister153 = r_PtxRegister152 | r_PtxRegister13;						// PTX L181
	r_PtxU64Register293 = SignExtendWordBits(r_PtxRegister153);					// PTX L182
L__BB19_7:																		// PTX L183
	r_PtxU64Register294 = uint64_t(0);											// PTX L184
	if (r_bPtxPredicate45)
	{
		goto L__BB19_9;
	} // PTX L185
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register293), uint32_t(2));		   // PTX L186
	r_PtxU64Register294 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register33); // PTX L187
L__BB19_9:																			   // PTX L188
	r_PtxRegister154 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));			   // PTX L189
	r_PtxRegister155 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L190
	r_PtxRegister18 = uint32_t(r_PtxRegister155) + uint32_t(r_PtxRegister154);		   // PTX L191
	if (r_bPtxPredicate45)
	{
		goto L__BB19_12;
	} // PTX L192
	r_PtxRegister163 = uint32_t(-1);							   // PTX L193
	r_PtxRegister162 = Elected(r_PtxRegister163);				   // PTX L195
	r_bPtxPredicate46 = uint32_t(r_PtxRegister162) == uint32_t(0); // PTX L201
	if (r_bPtxPredicate46)
	{
		goto L__BB19_13;
	} // PTX L202
	r_PtxU64Register34 = r_PtxU64Register294;									 // PTX L203
	r_PtxRegister165 = uint32_t(12288u /* exact native shared-region offset */); // PTX L204
	r_PtxRegister164 = uint32_t(512);											 // PTX L205
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister18, r_PtxU64Register34, r_PtxRegister164,
			 r_PtxRegister165);																  // PTX L207
	BarrierExpect(s_SharedStorage, r_PtxRegister165, r_PtxRegister164);						  // PTX L210
	goto L__BB19_13;																		  // PTX L212
L__BB19_12:																					  // PTX L213
	r_PtxRegister156 = uint32_t(0);															  // PTX L214
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister156))); // PTX L216
	r_PackedHalf2AtPtx219R157 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);		  // PTX L219
	r_ConvertedE4PairAtPtx221Rs2 = PublishE4(r_PackedHalf2AtPtx219R157);					  // PTX L221
	r_PackedE4WordAtPtx223R160 =
		JoinHalfwords(r_ConvertedE4PairAtPtx221Rs2, r_ConvertedE4PairAtPtx221Rs2); // PTX L223
	r_LaneIndexAtPtx225 = uint32_t((threadIdx.x & 31u));						   // PTX L225
	r_PtxRegister161 = ShiftLeft(uint32_t(r_LaneIndexAtPtx225), uint32_t(4));	   // PTX L227
	r_PtxRegister159 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister161);	   // PTX L228
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister159)) =
		make_uint4(r_PackedE4WordAtPtx223R160, r_PackedE4WordAtPtx223R160, r_PackedE4WordAtPtx223R160,
				   r_PackedE4WordAtPtx223R160);								   // PTX L230
L__BB19_13:																	   // PTX L232
	r_bPtxPredicate47 = uint32_t(r_PtxRegister16) == uint32_t(4);			   // PTX L233
	r_PtxRegister166 = uint32_t(r_ThreadYAtPtx45) + uint32_t(4);			   // PTX L234
	r_PtxRegister167 = ShiftRight(uint32_t(r_PtxRegister166), uint32_t(2));	   // PTX L235
	r_PtxRegister168 = ShiftLeft(uint32_t(r_PtxRegister167), uint32_t(9));	   // PTX L236
	r_PtxRegister169 = r_PtxRegister168 | r_PtxRegister12;					   // PTX L237
	r_PtxRegister19 = uint32_t(r_PtxRegister169) + uint32_t(r_PtxRegister13);  // PTX L238
	r_PtxRegister170 = uint32_t(r_PtxRegister167) + uint32_t(r_PtxRegister3);  // PTX L239
	r_bPtxPredicate48 = int32_t(r_PtxRegister170) < int32_t(r_HeightDiv4Bits); // PTX L240
	r_PtxRegister171 = uint32_t(r_PtxRegister170) * uint32_t(r_WidthDiv4Bits); // PTX L241
	r_PtxRegister20 = r_bPtxPredicate47 ? 0 : r_PtxRegister171;				   // PTX L242
	r_bPtxPredicate2 = r_bPtxPredicate47 | r_bPtxPredicate48;				   // PTX L243
	r_bPtxPredicate605 = bool(0);											   // PTX L244
	r_bPtxPredicate49 = !r_bPtxPredicate2;									   // PTX L245
	r_PtxRegister2039 = uint32_t(r_PtxRegister15);							   // PTX L246
	if (r_bPtxPredicate49)
	{
		goto L__BB19_16;
	} // PTX L247
	r_PtxRegister172 = r_WidthBits & -4;						   // PTX L248
	r_bPtxPredicate50 = uint32_t(r_PtxRegister172) == uint32_t(4); // PTX L249
	r_bPtxPredicate605 = bool(-1);								   // PTX L250
	r_PtxRegister2039 = uint32_t(0);							   // PTX L251
	if (r_bPtxPredicate50)
	{
		goto L__BB19_16;
	} // PTX L252
	r_bPtxPredicate605 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L253
	r_PtxRegister2039 = uint32_t(r_PtxRegister15);							  // PTX L254
L__BB19_16:																	  // PTX L255
	r_PtxU64Register295 = uint64_t(0);										  // PTX L256
	r_bPtxPredicate51 = !r_bPtxPredicate605;								  // PTX L257
	if (r_bPtxPredicate51)
	{
		goto L__BB19_18;
	} // PTX L258
	r_PtxRegister173 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister2039); // PTX L259
	r_PtxRegister174 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister173);			// PTX L260
	r_PtxRegister175 = ShiftLeft(uint32_t(r_PtxRegister174), uint32_t(11));		// PTX L261
	r_PtxRegister176 = r_PtxRegister175 | r_PtxRegister13;						// PTX L262
	r_PtxU64Register295 = SignExtendWordBits(r_PtxRegister176);					// PTX L263
L__BB19_18:																		// PTX L264
	r_PtxU64Register296 = uint64_t(0);											// PTX L265
	if (r_bPtxPredicate51)
	{
		goto L__BB19_20;
	} // PTX L266
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register295), uint32_t(2));		   // PTX L267
	r_PtxU64Register296 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register35); // PTX L268
L__BB19_20:																			   // PTX L269
	r_PtxRegister177 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(2));			   // PTX L270
	r_PtxRegister178 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L271
	r_PtxRegister21 = uint32_t(r_PtxRegister178) + uint32_t(r_PtxRegister177);		   // PTX L272
	if (r_bPtxPredicate51)
	{
		goto L__BB19_23;
	} // PTX L273
	r_PtxRegister186 = uint32_t(-1);							   // PTX L274
	r_PtxRegister185 = Elected(r_PtxRegister186);				   // PTX L276
	r_bPtxPredicate52 = uint32_t(r_PtxRegister185) == uint32_t(0); // PTX L282
	if (r_bPtxPredicate52)
	{
		goto L__BB19_24;
	} // PTX L283
	r_PtxU64Register36 = r_PtxU64Register296;									 // PTX L284
	r_PtxRegister188 = uint32_t(12288u /* exact native shared-region offset */); // PTX L285
	r_PtxRegister187 = uint32_t(512);											 // PTX L286
	CopyBulk(s_SharedStorage, r_PtxRegister21, r_PtxU64Register36, r_PtxRegister187,
			 r_PtxRegister188);																  // PTX L288
	BarrierExpect(s_SharedStorage, r_PtxRegister188, r_PtxRegister187);						  // PTX L291
	goto L__BB19_24;																		  // PTX L293
L__BB19_23:																					  // PTX L294
	r_PtxRegister179 = uint32_t(0);															  // PTX L295
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister179))); // PTX L297
	r_PackedHalf2AtPtx300R180 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		  // PTX L300
	r_ConvertedE4PairAtPtx302Rs4 = PublishE4(r_PackedHalf2AtPtx300R180);					  // PTX L302
	r_PackedE4WordAtPtx304R183 =
		JoinHalfwords(r_ConvertedE4PairAtPtx302Rs4, r_ConvertedE4PairAtPtx302Rs4); // PTX L304
	r_LaneIndexAtPtx306 = uint32_t((threadIdx.x & 31u));						   // PTX L306
	r_PtxRegister184 = ShiftLeft(uint32_t(r_LaneIndexAtPtx306), uint32_t(4));	   // PTX L308
	r_PtxRegister182 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister184);	   // PTX L309
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister182)) =
		make_uint4(r_PackedE4WordAtPtx304R183, r_PackedE4WordAtPtx304R183, r_PackedE4WordAtPtx304R183,
				   r_PackedE4WordAtPtx304R183);					 // PTX L311
L__BB19_24:														 // PTX L313
	r_PtxRegister189 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9)); // PTX L314
	r_PtxRegister22 = r_PtxRegister189 | 64;					 // PTX L315
	r_bPtxPredicate606 = bool(0);								 // PTX L316
	r_PtxRegister2040 = uint32_t(r_PtxRegister15);				 // PTX L317
	if (r_bPtxPredicate43)
	{
		goto L__BB19_27;
	} // PTX L318
	r_PtxRegister190 = r_WidthBits & -4;						   // PTX L319
	r_bPtxPredicate53 = uint32_t(r_PtxRegister190) == uint32_t(4); // PTX L320
	r_bPtxPredicate606 = bool(-1);								   // PTX L321
	r_PtxRegister2040 = uint32_t(0);							   // PTX L322
	if (r_bPtxPredicate53)
	{
		goto L__BB19_27;
	} // PTX L323
	r_bPtxPredicate606 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L324
	r_PtxRegister2040 = uint32_t(r_PtxRegister15);							  // PTX L325
L__BB19_27:																	  // PTX L326
	r_PtxU64Register297 = uint64_t(0);										  // PTX L327
	r_bPtxPredicate54 = !r_bPtxPredicate606;								  // PTX L328
	if (r_bPtxPredicate54)
	{
		goto L__BB19_29;
	} // PTX L329
	r_PtxRegister191 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister2040); // PTX L330
	r_PtxRegister192 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L331
	r_PtxRegister193 = uint32_t(r_PtxRegister192) + uint32_t(r_PtxRegister11);	// PTX L332
	r_PtxRegister194 = ShiftLeft(uint32_t(r_PtxRegister191), uint32_t(11));		// PTX L333
	r_PtxRegister195 = ShiftLeft(uint32_t(r_PtxRegister193), uint32_t(7));		// PTX L334
	r_PtxRegister196 = uint32_t(r_PtxRegister194) + uint32_t(r_PtxRegister195); // PTX L335
	r_PtxU64Register297 = SignExtendWordBits(r_PtxRegister196);					// PTX L336
L__BB19_29:																		// PTX L337
	r_PtxU64Register298 = uint64_t(0);											// PTX L338
	if (r_bPtxPredicate54)
	{
		goto L__BB19_31;
	} // PTX L339
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register297), uint32_t(2));		   // PTX L340
	r_PtxU64Register298 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register37); // PTX L341
L__BB19_31:																			   // PTX L342
	if (r_bPtxPredicate54)
	{
		goto L__BB19_34;
	} // PTX L343
	r_PtxRegister205 = uint32_t(-1);							   // PTX L344
	r_PtxRegister204 = Elected(r_PtxRegister205);				   // PTX L346
	r_bPtxPredicate55 = uint32_t(r_PtxRegister204) == uint32_t(0); // PTX L352
	if (r_bPtxPredicate55)
	{
		goto L__BB19_35;
	} // PTX L353
	r_PtxRegister206 = uint32_t(r_PtxRegister18) + uint32_t(4096);				 // PTX L354
	r_PtxU64Register38 = r_PtxU64Register298;									 // PTX L355
	r_PtxRegister209 = uint32_t(12288u /* exact native shared-region offset */); // PTX L356
	r_PtxRegister208 = uint32_t(r_PtxRegister209) + uint32_t(8);				 // PTX L357
	r_PtxRegister207 = uint32_t(512);											 // PTX L358
	CopyBulk(s_SharedStorage, r_PtxRegister206, r_PtxU64Register38, r_PtxRegister207,
			 r_PtxRegister208);																  // PTX L360
	BarrierExpect(s_SharedStorage, r_PtxRegister208, r_PtxRegister207);						  // PTX L363
	goto L__BB19_35;																		  // PTX L365
L__BB19_34:																					  // PTX L366
	r_PtxRegister197 = uint32_t(0);															  // PTX L367
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister197))); // PTX L369
	r_PackedHalf2AtPtx372R198 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);		  // PTX L372
	r_ConvertedE4PairAtPtx374Rs6 = PublishE4(r_PackedHalf2AtPtx372R198);					  // PTX L374
	r_PackedE4WordAtPtx376R201 =
		JoinHalfwords(r_ConvertedE4PairAtPtx374Rs6, r_ConvertedE4PairAtPtx374Rs6); // PTX L376
	r_LaneIndexAtPtx378 = uint32_t((threadIdx.x & 31u));						   // PTX L378
	r_PtxRegister202 = ShiftLeft(uint32_t(r_LaneIndexAtPtx378), uint32_t(4));	   // PTX L380
	r_PtxRegister203 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister202);	   // PTX L381
	r_PtxRegister200 = uint32_t(r_PtxRegister203) + uint32_t(4096);				   // PTX L382
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister200)) =
		make_uint4(r_PackedE4WordAtPtx376R201, r_PackedE4WordAtPtx376R201, r_PackedE4WordAtPtx376R201,
				   r_PackedE4WordAtPtx376R201);	   // PTX L384
L__BB19_35:										   // PTX L386
	r_bPtxPredicate607 = bool(0);				   // PTX L387
	r_PtxRegister2041 = uint32_t(r_PtxRegister15); // PTX L388
	if (r_bPtxPredicate49)
	{
		goto L__BB19_38;
	} // PTX L389
	r_PtxRegister210 = r_WidthBits & -4;						   // PTX L390
	r_bPtxPredicate56 = uint32_t(r_PtxRegister210) == uint32_t(4); // PTX L391
	r_bPtxPredicate607 = bool(-1);								   // PTX L392
	r_PtxRegister2041 = uint32_t(0);							   // PTX L393
	if (r_bPtxPredicate56)
	{
		goto L__BB19_38;
	} // PTX L394
	r_bPtxPredicate607 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L395
	r_PtxRegister2041 = uint32_t(r_PtxRegister15);							  // PTX L396
L__BB19_38:																	  // PTX L397
	r_PtxU64Register299 = uint64_t(0);										  // PTX L398
	r_bPtxPredicate57 = !r_bPtxPredicate607;								  // PTX L399
	if (r_bPtxPredicate57)
	{
		goto L__BB19_40;
	} // PTX L400
	r_PtxRegister211 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister2041); // PTX L401
	r_PtxRegister212 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L402
	r_PtxRegister213 = uint32_t(r_PtxRegister212) + uint32_t(r_PtxRegister11);	// PTX L403
	r_PtxRegister214 = ShiftLeft(uint32_t(r_PtxRegister211), uint32_t(11));		// PTX L404
	r_PtxRegister215 = ShiftLeft(uint32_t(r_PtxRegister213), uint32_t(7));		// PTX L405
	r_PtxRegister216 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister215); // PTX L406
	r_PtxU64Register299 = SignExtendWordBits(r_PtxRegister216);					// PTX L407
L__BB19_40:																		// PTX L408
	r_PtxU64Register300 = uint64_t(0);											// PTX L409
	if (r_bPtxPredicate57)
	{
		goto L__BB19_42;
	} // PTX L410
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register299), uint32_t(2));		   // PTX L411
	r_PtxU64Register300 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register39); // PTX L412
L__BB19_42:																			   // PTX L413
	if (r_bPtxPredicate57)
	{
		goto L__BB19_45;
	} // PTX L414
	r_PtxRegister225 = uint32_t(-1);							   // PTX L415
	r_PtxRegister224 = Elected(r_PtxRegister225);				   // PTX L417
	r_bPtxPredicate58 = uint32_t(r_PtxRegister224) == uint32_t(0); // PTX L423
	if (r_bPtxPredicate58)
	{
		goto L__BB19_46;
	} // PTX L424
	r_PtxRegister226 = uint32_t(r_PtxRegister21) + uint32_t(4096);				 // PTX L425
	r_PtxU64Register40 = r_PtxU64Register300;									 // PTX L426
	r_PtxRegister229 = uint32_t(12288u /* exact native shared-region offset */); // PTX L427
	r_PtxRegister228 = uint32_t(r_PtxRegister229) + uint32_t(8);				 // PTX L428
	r_PtxRegister227 = uint32_t(512);											 // PTX L429
	CopyBulk(s_SharedStorage, r_PtxRegister226, r_PtxU64Register40, r_PtxRegister227,
			 r_PtxRegister228);																  // PTX L431
	BarrierExpect(s_SharedStorage, r_PtxRegister228, r_PtxRegister227);						  // PTX L434
	goto L__BB19_46;																		  // PTX L436
L__BB19_45:																					  // PTX L437
	r_PtxRegister217 = uint32_t(0);															  // PTX L438
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister217))); // PTX L440
	r_PackedHalf2AtPtx443R218 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L443
	r_ConvertedE4PairAtPtx445Rs8 = PublishE4(r_PackedHalf2AtPtx443R218);					  // PTX L445
	r_PackedE4WordAtPtx447R221 =
		JoinHalfwords(r_ConvertedE4PairAtPtx445Rs8, r_ConvertedE4PairAtPtx445Rs8); // PTX L447
	r_LaneIndexAtPtx449 = uint32_t((threadIdx.x & 31u));						   // PTX L449
	r_PtxRegister222 = ShiftLeft(uint32_t(r_LaneIndexAtPtx449), uint32_t(4));	   // PTX L451
	r_PtxRegister223 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister222);	   // PTX L452
	r_PtxRegister220 = uint32_t(r_PtxRegister223) + uint32_t(4096);				   // PTX L453
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister220)) =
		make_uint4(r_PackedE4WordAtPtx447R221, r_PackedE4WordAtPtx447R221, r_PackedE4WordAtPtx447R221,
				   r_PackedE4WordAtPtx447R221);					// PTX L455
L__BB19_46:														// PTX L457
	r_PtxRegister23 = uint32_t(r_PtxRegister22) + uint32_t(64); // PTX L458
	r_bPtxPredicate608 = bool(0);								// PTX L459
	r_PtxRegister2042 = uint32_t(r_PtxRegister15);				// PTX L460
	if (r_bPtxPredicate43)
	{
		goto L__BB19_49;
	} // PTX L461
	r_PtxRegister230 = r_WidthBits & -4;						   // PTX L462
	r_bPtxPredicate59 = uint32_t(r_PtxRegister230) == uint32_t(4); // PTX L463
	r_bPtxPredicate608 = bool(-1);								   // PTX L464
	r_PtxRegister2042 = uint32_t(0);							   // PTX L465
	if (r_bPtxPredicate59)
	{
		goto L__BB19_49;
	} // PTX L466
	r_bPtxPredicate608 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L467
	r_PtxRegister2042 = uint32_t(r_PtxRegister15);							  // PTX L468
L__BB19_49:																	  // PTX L469
	r_PtxU64Register301 = uint64_t(0);										  // PTX L470
	r_bPtxPredicate60 = !r_bPtxPredicate608;								  // PTX L471
	if (r_bPtxPredicate60)
	{
		goto L__BB19_51;
	} // PTX L472
	r_PtxRegister231 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister2042); // PTX L473
	r_PtxRegister232 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(5));		// PTX L474
	r_PtxRegister233 = uint32_t(r_PtxRegister232) + uint32_t(r_PtxRegister11);	// PTX L475
	r_PtxRegister234 = ShiftLeft(uint32_t(r_PtxRegister231), uint32_t(11));		// PTX L476
	r_PtxRegister235 = ShiftLeft(uint32_t(r_PtxRegister233), uint32_t(7));		// PTX L477
	r_PtxRegister236 = uint32_t(r_PtxRegister234) + uint32_t(r_PtxRegister235); // PTX L478
	r_PtxU64Register301 = SignExtendWordBits(r_PtxRegister236);					// PTX L479
L__BB19_51:																		// PTX L480
	r_PtxU64Register302 = uint64_t(0);											// PTX L481
	if (r_bPtxPredicate60)
	{
		goto L__BB19_53;
	} // PTX L482
	r_PtxU64Register41 = ShiftLeft(uint64_t(r_PtxU64Register301), uint32_t(2));		   // PTX L483
	r_PtxU64Register302 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register41); // PTX L484
L__BB19_53:																			   // PTX L485
	if (r_bPtxPredicate60)
	{
		goto L__BB19_56;
	} // PTX L486
	r_PtxRegister245 = uint32_t(-1);							   // PTX L487
	r_PtxRegister244 = Elected(r_PtxRegister245);				   // PTX L489
	r_bPtxPredicate61 = uint32_t(r_PtxRegister244) == uint32_t(0); // PTX L495
	if (r_bPtxPredicate61)
	{
		goto L__BB19_57;
	} // PTX L496
	r_PtxRegister246 = uint32_t(r_PtxRegister18) + uint32_t(8192);				 // PTX L497
	r_PtxU64Register42 = r_PtxU64Register302;									 // PTX L498
	r_PtxRegister249 = uint32_t(12288u /* exact native shared-region offset */); // PTX L499
	r_PtxRegister248 = uint32_t(r_PtxRegister249) + uint32_t(16);				 // PTX L500
	r_PtxRegister247 = uint32_t(512);											 // PTX L501
	CopyBulk(s_SharedStorage, r_PtxRegister246, r_PtxU64Register42, r_PtxRegister247,
			 r_PtxRegister248);																  // PTX L503
	BarrierExpect(s_SharedStorage, r_PtxRegister248, r_PtxRegister247);						  // PTX L506
	goto L__BB19_57;																		  // PTX L508
L__BB19_56:																					  // PTX L509
	r_PtxRegister237 = uint32_t(0);															  // PTX L510
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister237))); // PTX L512
	r_PackedHalf2AtPtx515R238 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L515
	r_ConvertedE4PairAtPtx517Rs10 = PublishE4(r_PackedHalf2AtPtx515R238);					  // PTX L517
	r_PackedE4WordAtPtx519R241 =
		JoinHalfwords(r_ConvertedE4PairAtPtx517Rs10, r_ConvertedE4PairAtPtx517Rs10); // PTX L519
	r_LaneIndexAtPtx521 = uint32_t((threadIdx.x & 31u));							 // PTX L521
	r_PtxRegister242 = ShiftLeft(uint32_t(r_LaneIndexAtPtx521), uint32_t(4));		 // PTX L523
	r_PtxRegister243 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister242);		 // PTX L524
	r_PtxRegister240 = uint32_t(r_PtxRegister243) + uint32_t(8192);					 // PTX L525
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister240)) =
		make_uint4(r_PackedE4WordAtPtx519R241, r_PackedE4WordAtPtx519R241, r_PackedE4WordAtPtx519R241,
				   r_PackedE4WordAtPtx519R241);	   // PTX L527
L__BB19_57:										   // PTX L529
	r_bPtxPredicate609 = bool(0);				   // PTX L530
	r_PtxRegister2043 = uint32_t(r_PtxRegister15); // PTX L531
	if (r_bPtxPredicate49)
	{
		goto L__BB19_60;
	} // PTX L532
	r_PtxRegister250 = r_WidthBits & -4;						   // PTX L533
	r_bPtxPredicate62 = uint32_t(r_PtxRegister250) == uint32_t(4); // PTX L534
	r_bPtxPredicate609 = bool(-1);								   // PTX L535
	r_PtxRegister2043 = uint32_t(0);							   // PTX L536
	if (r_bPtxPredicate62)
	{
		goto L__BB19_60;
	} // PTX L537
	r_bPtxPredicate609 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits); // PTX L538
	r_PtxRegister2043 = uint32_t(r_PtxRegister15);							  // PTX L539
L__BB19_60:																	  // PTX L540
	r_PtxU64Register303 = uint64_t(0);										  // PTX L541
	r_bPtxPredicate63 = !r_bPtxPredicate609;								  // PTX L542
	if (r_bPtxPredicate63)
	{
		goto L__BB19_62;
	} // PTX L543
	r_PtxRegister251 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister2043); // PTX L544
	r_PtxRegister252 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(5));		// PTX L545
	r_PtxRegister253 = uint32_t(r_PtxRegister252) + uint32_t(r_PtxRegister11);	// PTX L546
	r_PtxRegister254 = ShiftLeft(uint32_t(r_PtxRegister251), uint32_t(11));		// PTX L547
	r_PtxRegister255 = ShiftLeft(uint32_t(r_PtxRegister253), uint32_t(7));		// PTX L548
	r_PtxRegister256 = uint32_t(r_PtxRegister254) + uint32_t(r_PtxRegister255); // PTX L549
	r_PtxU64Register303 = SignExtendWordBits(r_PtxRegister256);					// PTX L550
L__BB19_62:																		// PTX L551
	r_PtxU64Register304 = uint64_t(0);											// PTX L552
	if (r_bPtxPredicate63)
	{
		goto L__BB19_64;
	} // PTX L553
	r_PtxU64Register43 = ShiftLeft(uint64_t(r_PtxU64Register303), uint32_t(2));		   // PTX L554
	r_PtxU64Register304 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register43); // PTX L555
L__BB19_64:																			   // PTX L556
	if (r_bPtxPredicate63)
	{
		goto L__BB19_67;
	} // PTX L557
	r_PtxRegister265 = uint32_t(-1);							   // PTX L558
	r_PtxRegister264 = Elected(r_PtxRegister265);				   // PTX L560
	r_bPtxPredicate64 = uint32_t(r_PtxRegister264) == uint32_t(0); // PTX L566
	if (r_bPtxPredicate64)
	{
		goto L__BB19_68;
	} // PTX L567
	r_PtxRegister266 = uint32_t(r_PtxRegister21) + uint32_t(8192);				 // PTX L568
	r_PtxU64Register44 = r_PtxU64Register304;									 // PTX L569
	r_PtxRegister269 = uint32_t(12288u /* exact native shared-region offset */); // PTX L570
	r_PtxRegister268 = uint32_t(r_PtxRegister269) + uint32_t(16);				 // PTX L571
	r_PtxRegister267 = uint32_t(512);											 // PTX L572
	CopyBulk(s_SharedStorage, r_PtxRegister266, r_PtxU64Register44, r_PtxRegister267,
			 r_PtxRegister268);																   // PTX L574
	BarrierExpect(s_SharedStorage, r_PtxRegister268, r_PtxRegister267);						   // PTX L577
	goto L__BB19_68;																		   // PTX L579
L__BB19_67:																					   // PTX L580
	r_PtxRegister257 = uint32_t(0);															   // PTX L581
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister257))); // PTX L583
	r_PackedHalf2AtPtx586R258 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L586
	r_ConvertedE4PairAtPtx588Rs12 = PublishE4(r_PackedHalf2AtPtx586R258);					   // PTX L588
	r_PackedE4WordAtPtx590R261 =
		JoinHalfwords(r_ConvertedE4PairAtPtx588Rs12, r_ConvertedE4PairAtPtx588Rs12); // PTX L590
	r_LaneIndexAtPtx592 = uint32_t((threadIdx.x & 31u));							 // PTX L592
	r_PtxRegister262 = ShiftLeft(uint32_t(r_LaneIndexAtPtx592), uint32_t(4));		 // PTX L594
	r_PtxRegister263 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister262);		 // PTX L595
	r_PtxRegister260 = uint32_t(r_PtxRegister263) + uint32_t(8192);					 // PTX L596
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister260)) =
		make_uint4(r_PackedE4WordAtPtx590R261, r_PackedE4WordAtPtx590R261, r_PackedE4WordAtPtx590R261,
				   r_PackedE4WordAtPtx590R261);									 // PTX L598
L__BB19_68:																		 // PTX L600
	r_PtxRegister270 = uint32_t(12288u /* exact native shared-region offset */); // PTX L601
	r_PtxRegister271 = uint32_t(1);												 // PTX L602
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register45 = BarrierArrive(s_SharedStorage, r_PtxRegister270, r_PtxRegister271); // PTX L604
L__BB19_69:																					 // PTX L606
	r_PtxRegister273 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L607
	r_PtxRegister272 = BarrierReady(s_SharedStorage, r_PtxRegister273, r_PtxU64Register45);	 // PTX L609
	r_bPtxPredicate65 = uint32_t(r_PtxRegister272) == uint32_t(0);							 // PTX L615
	if (r_bPtxPredicate65)
	{
		goto L__BB19_69;
	} // PTX L616
	r_PtxRegister275 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(4));			 // PTX L617
	r_PtxRegister276 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(2));			 // PTX L618
	r_bPtxPredicate66 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L619
	r_bPtxPredicate67 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L620
	r_bPtxPredicate68 = uint32_t(r_WidthBits) == uint32_t(1);						 // PTX L621
	r_PtxRegister24 = ShiftLeft(uint32_t(r_WidthBits), uint32_t(2));				 // PTX L622
	r_LaneIndexAtPtx624 = uint32_t((threadIdx.x & 31u));							 // PTX L624
	r_PtxRegister277 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx624), uint32_t(31)); // PTX L626
	r_PtxRegister278 = ShiftRight(uint32_t(r_PtxRegister277), uint32_t(30));		 // PTX L627
	r_PtxRegister279 = uint32_t(r_LaneIndexAtPtx624) + uint32_t(r_PtxRegister278);	 // PTX L628
	r_PtxRegister280 = ShiftRightSigned(int32_t(r_PtxRegister279), uint32_t(2));	 // PTX L629
	r_PtxRegister281 = ShiftRight(uint32_t(r_PtxRegister280), uint32_t(30));		 // PTX L630
	r_PtxRegister282 = uint32_t(r_PtxRegister280) + uint32_t(r_PtxRegister281);		 // PTX L631
	r_PtxRegister283 = r_PtxRegister282 & -4;										 // PTX L632
	r_PtxRegister284 = uint32_t(r_PtxRegister280) - uint32_t(r_PtxRegister283);		 // PTX L633
	r_PtxRegister285 = ShiftRight(uint32_t(r_PtxRegister277), uint32_t(28));		 // PTX L634
	r_PtxRegister286 = uint32_t(r_LaneIndexAtPtx624) + uint32_t(r_PtxRegister285);	 // PTX L635
	r_PtxRegister287 = ShiftRightSigned(int32_t(r_PtxRegister286), uint32_t(4));	 // PTX L636
	r_PtxRegister25 = uint32_t(r_PtxRegister275) + uint32_t(r_PtxRegister276);		 // PTX L637
	r_PtxRegister288 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister287);		 // PTX L638
	r_PtxRegister26 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister284);		 // PTX L639
	r_bPtxPredicate69 = int32_t(r_PtxRegister288) < int32_t(0);						 // PTX L640
	r_bPtxPredicate70 = int32_t(r_PtxRegister288) >= int32_t(r_HeightBits);			 // PTX L641
	r_bPtxPredicate71 = r_bPtxPredicate69 | r_bPtxPredicate70;						 // PTX L642
	r_bPtxPredicate72 = !r_bPtxPredicate71;											 // PTX L643
	r_PtxRegister27 = r_bPtxPredicate67 ? 0 : r_PtxRegister288;						 // PTX L644
	r_bPtxPredicate73 = r_bPtxPredicate66 & r_bPtxPredicate71;						 // PTX L645
	r_bPtxPredicate74 = r_bPtxPredicate67 | r_bPtxPredicate72;						 // PTX L646
	r_bPtxPredicate75 = r_bPtxPredicate73 | r_bPtxPredicate68;						 // PTX L647
	r_bPtxPredicate76 = int32_t(r_PtxRegister26) > int32_t(-1);						 // PTX L648
	r_bPtxPredicate77 = int32_t(r_PtxRegister26) < int32_t(r_WidthBits);			 // PTX L649
	r_bPtxPredicate78 = r_bPtxPredicate76 & r_bPtxPredicate77;						 // PTX L650
	r_bPtxPredicate79 = !r_bPtxPredicate73;											 // PTX L651
	r_bPtxPredicate3 = r_bPtxPredicate68 & r_bPtxPredicate79;						 // PTX L652
	r_bPtxPredicate80 = r_bPtxPredicate75 | r_bPtxPredicate78;						 // PTX L653
	r_bPtxPredicate81 = r_bPtxPredicate80 & r_bPtxPredicate74;						 // PTX L654
	r_PtxRegister2044 = uint32_t(0);												 // PTX L655
	r_bPtxPredicate82 = !r_bPtxPredicate81;											 // PTX L656
	if (r_bPtxPredicate82)
	{
		goto L__BB19_72;
	} // PTX L657
	r_PtxRegister289 = r_PtxRegister279 & -4;									   // PTX L658
	r_PtxRegister290 = uint32_t(r_LaneIndexAtPtx624) - uint32_t(r_PtxRegister289); // PTX L659
	r_PtxRegister291 = ShiftLeft(uint32_t(r_PtxRegister26), uint32_t(2));		   // PTX L660
	r_PtxRegister292 = r_bPtxPredicate3 ? 0 : r_PtxRegister291;					   // PTX L661
	r_PtxRegister293 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister27); // PTX L662
	r_PtxRegister294 =
		uint32_t(r_PtxRegister293) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister290); // PTX L663
	r_PtxRegister295 = uint32_t(r_PtxRegister294) + uint32_t(r_PtxRegister292);				 // PTX L664
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister295)) * int64_t(int32_t(4))); // PTX L665
	g_ResidualByteAddressAtPtx666 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register46);			   // PTX L666
	r_PtxRegister2044 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx666); // PTX L667
L__BB19_72:																				   // PTX L668
	r_bPtxPredicate83 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L669
	r_PtxU16Register13 = uint16_t(r_PtxRegister2044);
	r_PtxU16Register14 = uint16_t(r_PtxRegister2044 >> 16);							 // PTX L670
	r_bPtxPredicate84 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L671
	r_bPtxPredicate85 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L672
	r_LaneIndexAtPtx674 = uint32_t((threadIdx.x & 31u));							 // PTX L674
	r_PtxRegister297 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx674), uint32_t(31)); // PTX L676
	r_PtxRegister298 = ShiftRight(uint32_t(r_PtxRegister297), uint32_t(30));		 // PTX L677
	r_PtxRegister299 = uint32_t(r_LaneIndexAtPtx674) + uint32_t(r_PtxRegister298);	 // PTX L678
	r_PtxRegister300 = ShiftRightSigned(int32_t(r_PtxRegister299), uint32_t(2));	 // PTX L679
	r_PtxRegister301 = ShiftRight(uint32_t(r_PtxRegister300), uint32_t(30));		 // PTX L680
	r_PtxRegister302 = uint32_t(r_PtxRegister300) + uint32_t(r_PtxRegister301);		 // PTX L681
	r_PtxRegister303 = r_PtxRegister302 & -4;										 // PTX L682
	r_PtxRegister304 = uint32_t(r_PtxRegister300) - uint32_t(r_PtxRegister303);		 // PTX L683
	r_PtxRegister305 = ShiftRight(uint32_t(r_PtxRegister297), uint32_t(28));		 // PTX L684
	r_PtxRegister306 = uint32_t(r_LaneIndexAtPtx674) + uint32_t(r_PtxRegister305);	 // PTX L685
	r_PtxRegister307 = ShiftRightSigned(int32_t(r_PtxRegister306), uint32_t(4));	 // PTX L686
	r_PtxRegister308 = uint32_t(r_PtxRegister307) + uint32_t(r_PtxRegister4);		 // PTX L687
	r_PtxRegister309 = uint32_t(r_PtxRegister308) + uint32_t(2);					 // PTX L688
	r_PtxRegister28 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister304);		 // PTX L689
	r_bPtxPredicate86 = int32_t(r_PtxRegister309) < int32_t(0);						 // PTX L690
	r_bPtxPredicate87 = int32_t(r_PtxRegister309) >= int32_t(r_HeightBits);			 // PTX L691
	r_bPtxPredicate88 = r_bPtxPredicate86 | r_bPtxPredicate87;						 // PTX L692
	r_bPtxPredicate89 = !r_bPtxPredicate88;											 // PTX L693
	r_PtxRegister29 = r_bPtxPredicate85 ? 0 : r_PtxRegister309;						 // PTX L694
	r_bPtxPredicate90 = r_bPtxPredicate84 & r_bPtxPredicate88;						 // PTX L695
	r_bPtxPredicate91 = r_bPtxPredicate85 | r_bPtxPredicate89;						 // PTX L696
	r_bPtxPredicate92 = r_bPtxPredicate90 | r_bPtxPredicate83;						 // PTX L697
	r_bPtxPredicate93 = int32_t(r_PtxRegister28) > int32_t(-1);						 // PTX L698
	r_bPtxPredicate94 = int32_t(r_PtxRegister28) < int32_t(r_WidthBits);			 // PTX L699
	r_bPtxPredicate95 = r_bPtxPredicate93 & r_bPtxPredicate94;						 // PTX L700
	r_bPtxPredicate96 = !r_bPtxPredicate90;											 // PTX L701
	r_bPtxPredicate4 = r_bPtxPredicate83 & r_bPtxPredicate96;						 // PTX L702
	r_bPtxPredicate97 = r_bPtxPredicate92 | r_bPtxPredicate95;						 // PTX L703
	r_bPtxPredicate98 = r_bPtxPredicate97 & r_bPtxPredicate91;						 // PTX L704
	r_PtxRegister2045 = uint32_t(0);												 // PTX L705
	r_bPtxPredicate99 = !r_bPtxPredicate98;											 // PTX L706
	if (r_bPtxPredicate99)
	{
		goto L__BB19_74;
	} // PTX L707
	r_PtxRegister310 = r_PtxRegister299 & -4;									   // PTX L708
	r_PtxRegister311 = uint32_t(r_LaneIndexAtPtx674) - uint32_t(r_PtxRegister310); // PTX L709
	r_PtxRegister312 = ShiftLeft(uint32_t(r_PtxRegister28), uint32_t(2));		   // PTX L710
	r_PtxRegister313 = r_bPtxPredicate4 ? 0 : r_PtxRegister312;					   // PTX L711
	r_PtxRegister314 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister29); // PTX L712
	r_PtxRegister315 =
		uint32_t(r_PtxRegister314) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister311); // PTX L713
	r_PtxRegister316 = uint32_t(r_PtxRegister315) + uint32_t(r_PtxRegister313);				 // PTX L714
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister316)) * int64_t(int32_t(4))); // PTX L715
	g_ResidualByteAddressAtPtx716 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register48);			   // PTX L716
	r_PtxRegister2045 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx716); // PTX L717
L__BB19_74:																				   // PTX L718
	r_bPtxPredicate100 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L719
	r_PtxU16Register15 = uint16_t(r_PtxRegister2045);
	r_PtxU16Register16 = uint16_t(r_PtxRegister2045 >> 16);							 // PTX L720
	r_bPtxPredicate101 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L721
	r_bPtxPredicate102 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L722
	r_LaneIndexAtPtx724 = uint32_t((threadIdx.x & 31u));							 // PTX L724
	r_PtxRegister318 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx724), uint32_t(31)); // PTX L726
	r_PtxRegister319 = ShiftRight(uint32_t(r_PtxRegister318), uint32_t(30));		 // PTX L727
	r_PtxRegister320 = uint32_t(r_LaneIndexAtPtx724) + uint32_t(r_PtxRegister319);	 // PTX L728
	r_PtxRegister321 = ShiftRightSigned(int32_t(r_PtxRegister320), uint32_t(2));	 // PTX L729
	r_PtxRegister322 = ShiftRight(uint32_t(r_PtxRegister321), uint32_t(30));		 // PTX L730
	r_PtxRegister323 = uint32_t(r_PtxRegister321) + uint32_t(r_PtxRegister322);		 // PTX L731
	r_PtxRegister324 = r_PtxRegister323 & -4;										 // PTX L732
	r_PtxRegister325 = uint32_t(r_PtxRegister321) - uint32_t(r_PtxRegister324);		 // PTX L733
	r_PtxRegister326 = ShiftRight(uint32_t(r_PtxRegister318), uint32_t(28));		 // PTX L734
	r_PtxRegister327 = uint32_t(r_LaneIndexAtPtx724) + uint32_t(r_PtxRegister326);	 // PTX L735
	r_PtxRegister328 = ShiftRightSigned(int32_t(r_PtxRegister327), uint32_t(4));	 // PTX L736
	r_PtxRegister30 = uint32_t(r_PtxRegister25) + uint32_t(1);						 // PTX L737
	r_PtxRegister329 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister328);		 // PTX L738
	r_PtxRegister31 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister325);		 // PTX L739
	r_bPtxPredicate103 = int32_t(r_PtxRegister329) < int32_t(0);					 // PTX L740
	r_bPtxPredicate104 = int32_t(r_PtxRegister329) >= int32_t(r_HeightBits);		 // PTX L741
	r_bPtxPredicate105 = r_bPtxPredicate103 | r_bPtxPredicate104;					 // PTX L742
	r_bPtxPredicate106 = !r_bPtxPredicate105;										 // PTX L743
	r_PtxRegister32 = r_bPtxPredicate102 ? 0 : r_PtxRegister329;					 // PTX L744
	r_bPtxPredicate107 = r_bPtxPredicate101 & r_bPtxPredicate105;					 // PTX L745
	r_bPtxPredicate108 = r_bPtxPredicate102 | r_bPtxPredicate106;					 // PTX L746
	r_bPtxPredicate109 = r_bPtxPredicate107 | r_bPtxPredicate100;					 // PTX L747
	r_bPtxPredicate110 = int32_t(r_PtxRegister31) > int32_t(-1);					 // PTX L748
	r_bPtxPredicate111 = int32_t(r_PtxRegister31) < int32_t(r_WidthBits);			 // PTX L749
	r_bPtxPredicate112 = r_bPtxPredicate110 & r_bPtxPredicate111;					 // PTX L750
	r_bPtxPredicate113 = !r_bPtxPredicate107;										 // PTX L751
	r_bPtxPredicate5 = r_bPtxPredicate100 & r_bPtxPredicate113;						 // PTX L752
	r_bPtxPredicate114 = r_bPtxPredicate109 | r_bPtxPredicate112;					 // PTX L753
	r_bPtxPredicate115 = r_bPtxPredicate114 & r_bPtxPredicate108;					 // PTX L754
	r_PtxRegister2046 = uint32_t(0);												 // PTX L755
	r_bPtxPredicate116 = !r_bPtxPredicate115;										 // PTX L756
	if (r_bPtxPredicate116)
	{
		goto L__BB19_76;
	} // PTX L757
	r_PtxRegister330 = r_PtxRegister320 & -4;									   // PTX L758
	r_PtxRegister331 = uint32_t(r_LaneIndexAtPtx724) - uint32_t(r_PtxRegister330); // PTX L759
	r_PtxRegister332 = ShiftLeft(uint32_t(r_PtxRegister31), uint32_t(2));		   // PTX L760
	r_PtxRegister333 = r_bPtxPredicate5 ? 0 : r_PtxRegister332;					   // PTX L761
	r_PtxRegister334 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister32); // PTX L762
	r_PtxRegister335 =
		uint32_t(r_PtxRegister334) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister331); // PTX L763
	r_PtxRegister336 = uint32_t(r_PtxRegister335) + uint32_t(r_PtxRegister333);				 // PTX L764
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister336)) * int64_t(int32_t(4))); // PTX L765
	g_ResidualByteAddressAtPtx766 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register50);			   // PTX L766
	r_PtxRegister2046 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx766); // PTX L767
L__BB19_76:																				   // PTX L768
	r_bPtxPredicate117 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L769
	r_PtxU16Register17 = uint16_t(r_PtxRegister2046);
	r_PtxU16Register18 = uint16_t(r_PtxRegister2046 >> 16);							 // PTX L770
	r_bPtxPredicate118 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L771
	r_bPtxPredicate119 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L772
	r_LaneIndexAtPtx774 = uint32_t((threadIdx.x & 31u));							 // PTX L774
	r_PtxRegister338 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx774), uint32_t(31)); // PTX L776
	r_PtxRegister339 = ShiftRight(uint32_t(r_PtxRegister338), uint32_t(30));		 // PTX L777
	r_PtxRegister340 = uint32_t(r_LaneIndexAtPtx774) + uint32_t(r_PtxRegister339);	 // PTX L778
	r_PtxRegister341 = ShiftRightSigned(int32_t(r_PtxRegister340), uint32_t(2));	 // PTX L779
	r_PtxRegister342 = ShiftRight(uint32_t(r_PtxRegister341), uint32_t(30));		 // PTX L780
	r_PtxRegister343 = uint32_t(r_PtxRegister341) + uint32_t(r_PtxRegister342);		 // PTX L781
	r_PtxRegister344 = r_PtxRegister343 & -4;										 // PTX L782
	r_PtxRegister345 = uint32_t(r_PtxRegister341) - uint32_t(r_PtxRegister344);		 // PTX L783
	r_PtxRegister346 = ShiftRight(uint32_t(r_PtxRegister338), uint32_t(28));		 // PTX L784
	r_PtxRegister347 = uint32_t(r_LaneIndexAtPtx774) + uint32_t(r_PtxRegister346);	 // PTX L785
	r_PtxRegister348 = ShiftRightSigned(int32_t(r_PtxRegister347), uint32_t(4));	 // PTX L786
	r_PtxRegister349 = uint32_t(r_PtxRegister348) + uint32_t(r_PtxRegister4);		 // PTX L787
	r_PtxRegister350 = uint32_t(r_PtxRegister349) + uint32_t(2);					 // PTX L788
	r_PtxRegister33 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister345);		 // PTX L789
	r_bPtxPredicate120 = int32_t(r_PtxRegister350) < int32_t(0);					 // PTX L790
	r_bPtxPredicate121 = int32_t(r_PtxRegister350) >= int32_t(r_HeightBits);		 // PTX L791
	r_bPtxPredicate122 = r_bPtxPredicate120 | r_bPtxPredicate121;					 // PTX L792
	r_bPtxPredicate123 = !r_bPtxPredicate122;										 // PTX L793
	r_PtxRegister34 = r_bPtxPredicate119 ? 0 : r_PtxRegister350;					 // PTX L794
	r_bPtxPredicate124 = r_bPtxPredicate118 & r_bPtxPredicate122;					 // PTX L795
	r_bPtxPredicate125 = r_bPtxPredicate119 | r_bPtxPredicate123;					 // PTX L796
	r_bPtxPredicate126 = r_bPtxPredicate124 | r_bPtxPredicate117;					 // PTX L797
	r_bPtxPredicate127 = int32_t(r_PtxRegister33) > int32_t(-1);					 // PTX L798
	r_bPtxPredicate128 = int32_t(r_PtxRegister33) < int32_t(r_WidthBits);			 // PTX L799
	r_bPtxPredicate129 = r_bPtxPredicate127 & r_bPtxPredicate128;					 // PTX L800
	r_bPtxPredicate130 = !r_bPtxPredicate124;										 // PTX L801
	r_bPtxPredicate6 = r_bPtxPredicate117 & r_bPtxPredicate130;						 // PTX L802
	r_bPtxPredicate131 = r_bPtxPredicate126 | r_bPtxPredicate129;					 // PTX L803
	r_bPtxPredicate132 = r_bPtxPredicate131 & r_bPtxPredicate125;					 // PTX L804
	r_PtxRegister2047 = uint32_t(0);												 // PTX L805
	r_bPtxPredicate133 = !r_bPtxPredicate132;										 // PTX L806
	if (r_bPtxPredicate133)
	{
		goto L__BB19_78;
	} // PTX L807
	r_PtxRegister351 = r_PtxRegister340 & -4;									   // PTX L808
	r_PtxRegister352 = uint32_t(r_LaneIndexAtPtx774) - uint32_t(r_PtxRegister351); // PTX L809
	r_PtxRegister353 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(2));		   // PTX L810
	r_PtxRegister354 = r_bPtxPredicate6 ? 0 : r_PtxRegister353;					   // PTX L811
	r_PtxRegister355 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister34); // PTX L812
	r_PtxRegister356 =
		uint32_t(r_PtxRegister355) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister352); // PTX L813
	r_PtxRegister357 = uint32_t(r_PtxRegister356) + uint32_t(r_PtxRegister354);				 // PTX L814
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_PtxRegister357)) * int64_t(int32_t(4))); // PTX L815
	g_ResidualByteAddressAtPtx816 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register52);			   // PTX L816
	r_PtxRegister2047 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx816); // PTX L817
L__BB19_78:																				   // PTX L818
	r_bPtxPredicate134 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L819
	r_PtxU16Register19 = uint16_t(r_PtxRegister2047);
	r_PtxU16Register20 = uint16_t(r_PtxRegister2047 >> 16);							 // PTX L820
	r_bPtxPredicate135 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L821
	r_bPtxPredicate136 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L822
	r_LaneIndexAtPtx824 = uint32_t((threadIdx.x & 31u));							 // PTX L824
	r_PtxRegister359 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx824), uint32_t(31)); // PTX L826
	r_PtxRegister360 = ShiftRight(uint32_t(r_PtxRegister359), uint32_t(30));		 // PTX L827
	r_PtxRegister361 = uint32_t(r_LaneIndexAtPtx824) + uint32_t(r_PtxRegister360);	 // PTX L828
	r_PtxRegister362 = ShiftRightSigned(int32_t(r_PtxRegister361), uint32_t(2));	 // PTX L829
	r_PtxRegister363 = ShiftRight(uint32_t(r_PtxRegister362), uint32_t(30));		 // PTX L830
	r_PtxRegister364 = uint32_t(r_PtxRegister362) + uint32_t(r_PtxRegister363);		 // PTX L831
	r_PtxRegister365 = r_PtxRegister364 & -4;										 // PTX L832
	r_PtxRegister366 = uint32_t(r_PtxRegister362) - uint32_t(r_PtxRegister365);		 // PTX L833
	r_PtxRegister367 = ShiftRight(uint32_t(r_PtxRegister359), uint32_t(28));		 // PTX L834
	r_PtxRegister368 = uint32_t(r_LaneIndexAtPtx824) + uint32_t(r_PtxRegister367);	 // PTX L835
	r_PtxRegister369 = ShiftRightSigned(int32_t(r_PtxRegister368), uint32_t(4));	 // PTX L836
	r_PtxRegister35 = uint32_t(r_PtxRegister25) + uint32_t(2);						 // PTX L837
	r_PtxRegister370 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister369);		 // PTX L838
	r_PtxRegister36 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister366);		 // PTX L839
	r_bPtxPredicate137 = int32_t(r_PtxRegister370) < int32_t(0);					 // PTX L840
	r_bPtxPredicate138 = int32_t(r_PtxRegister370) >= int32_t(r_HeightBits);		 // PTX L841
	r_bPtxPredicate139 = r_bPtxPredicate137 | r_bPtxPredicate138;					 // PTX L842
	r_bPtxPredicate140 = !r_bPtxPredicate139;										 // PTX L843
	r_PtxRegister37 = r_bPtxPredicate136 ? 0 : r_PtxRegister370;					 // PTX L844
	r_bPtxPredicate141 = r_bPtxPredicate135 & r_bPtxPredicate139;					 // PTX L845
	r_bPtxPredicate142 = r_bPtxPredicate136 | r_bPtxPredicate140;					 // PTX L846
	r_bPtxPredicate143 = r_bPtxPredicate141 | r_bPtxPredicate134;					 // PTX L847
	r_bPtxPredicate144 = int32_t(r_PtxRegister36) > int32_t(-1);					 // PTX L848
	r_bPtxPredicate145 = int32_t(r_PtxRegister36) < int32_t(r_WidthBits);			 // PTX L849
	r_bPtxPredicate146 = r_bPtxPredicate144 & r_bPtxPredicate145;					 // PTX L850
	r_bPtxPredicate147 = !r_bPtxPredicate141;										 // PTX L851
	r_bPtxPredicate7 = r_bPtxPredicate134 & r_bPtxPredicate147;						 // PTX L852
	r_bPtxPredicate148 = r_bPtxPredicate143 | r_bPtxPredicate146;					 // PTX L853
	r_bPtxPredicate149 = r_bPtxPredicate148 & r_bPtxPredicate142;					 // PTX L854
	r_PtxRegister2048 = uint32_t(0);												 // PTX L855
	r_bPtxPredicate150 = !r_bPtxPredicate149;										 // PTX L856
	if (r_bPtxPredicate150)
	{
		goto L__BB19_80;
	} // PTX L857
	r_PtxRegister371 = r_PtxRegister361 & -4;									   // PTX L858
	r_PtxRegister372 = uint32_t(r_LaneIndexAtPtx824) - uint32_t(r_PtxRegister371); // PTX L859
	r_PtxRegister373 = ShiftLeft(uint32_t(r_PtxRegister36), uint32_t(2));		   // PTX L860
	r_PtxRegister374 = r_bPtxPredicate7 ? 0 : r_PtxRegister373;					   // PTX L861
	r_PtxRegister375 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister37); // PTX L862
	r_PtxRegister376 =
		uint32_t(r_PtxRegister375) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister372); // PTX L863
	r_PtxRegister377 = uint32_t(r_PtxRegister376) + uint32_t(r_PtxRegister374);				 // PTX L864
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister377)) * int64_t(int32_t(4))); // PTX L865
	g_ResidualByteAddressAtPtx866 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register54);			   // PTX L866
	r_PtxRegister2048 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx866); // PTX L867
L__BB19_80:																				   // PTX L868
	r_bPtxPredicate151 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L869
	r_PtxU16Register21 = uint16_t(r_PtxRegister2048);
	r_PtxU16Register22 = uint16_t(r_PtxRegister2048 >> 16);							 // PTX L870
	r_bPtxPredicate152 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L871
	r_bPtxPredicate153 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L872
	r_LaneIndexAtPtx874 = uint32_t((threadIdx.x & 31u));							 // PTX L874
	r_PtxRegister379 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx874), uint32_t(31)); // PTX L876
	r_PtxRegister380 = ShiftRight(uint32_t(r_PtxRegister379), uint32_t(30));		 // PTX L877
	r_PtxRegister381 = uint32_t(r_LaneIndexAtPtx874) + uint32_t(r_PtxRegister380);	 // PTX L878
	r_PtxRegister382 = ShiftRightSigned(int32_t(r_PtxRegister381), uint32_t(2));	 // PTX L879
	r_PtxRegister383 = ShiftRight(uint32_t(r_PtxRegister382), uint32_t(30));		 // PTX L880
	r_PtxRegister384 = uint32_t(r_PtxRegister382) + uint32_t(r_PtxRegister383);		 // PTX L881
	r_PtxRegister385 = r_PtxRegister384 & -4;										 // PTX L882
	r_PtxRegister386 = uint32_t(r_PtxRegister382) - uint32_t(r_PtxRegister385);		 // PTX L883
	r_PtxRegister387 = ShiftRight(uint32_t(r_PtxRegister379), uint32_t(28));		 // PTX L884
	r_PtxRegister388 = uint32_t(r_LaneIndexAtPtx874) + uint32_t(r_PtxRegister387);	 // PTX L885
	r_PtxRegister389 = ShiftRightSigned(int32_t(r_PtxRegister388), uint32_t(4));	 // PTX L886
	r_PtxRegister390 = uint32_t(r_PtxRegister389) + uint32_t(r_PtxRegister4);		 // PTX L887
	r_PtxRegister391 = uint32_t(r_PtxRegister390) + uint32_t(2);					 // PTX L888
	r_PtxRegister38 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister386);		 // PTX L889
	r_bPtxPredicate154 = int32_t(r_PtxRegister391) < int32_t(0);					 // PTX L890
	r_bPtxPredicate155 = int32_t(r_PtxRegister391) >= int32_t(r_HeightBits);		 // PTX L891
	r_bPtxPredicate156 = r_bPtxPredicate154 | r_bPtxPredicate155;					 // PTX L892
	r_bPtxPredicate157 = !r_bPtxPredicate156;										 // PTX L893
	r_PtxRegister39 = r_bPtxPredicate153 ? 0 : r_PtxRegister391;					 // PTX L894
	r_bPtxPredicate158 = r_bPtxPredicate152 & r_bPtxPredicate156;					 // PTX L895
	r_bPtxPredicate159 = r_bPtxPredicate153 | r_bPtxPredicate157;					 // PTX L896
	r_bPtxPredicate160 = r_bPtxPredicate158 | r_bPtxPredicate151;					 // PTX L897
	r_bPtxPredicate161 = int32_t(r_PtxRegister38) > int32_t(-1);					 // PTX L898
	r_bPtxPredicate162 = int32_t(r_PtxRegister38) < int32_t(r_WidthBits);			 // PTX L899
	r_bPtxPredicate163 = r_bPtxPredicate161 & r_bPtxPredicate162;					 // PTX L900
	r_bPtxPredicate164 = !r_bPtxPredicate158;										 // PTX L901
	r_bPtxPredicate8 = r_bPtxPredicate151 & r_bPtxPredicate164;						 // PTX L902
	r_bPtxPredicate165 = r_bPtxPredicate160 | r_bPtxPredicate163;					 // PTX L903
	r_bPtxPredicate166 = r_bPtxPredicate165 & r_bPtxPredicate159;					 // PTX L904
	r_PtxRegister2049 = uint32_t(0);												 // PTX L905
	r_bPtxPredicate167 = !r_bPtxPredicate166;										 // PTX L906
	if (r_bPtxPredicate167)
	{
		goto L__BB19_82;
	} // PTX L907
	r_PtxRegister392 = r_PtxRegister381 & -4;									   // PTX L908
	r_PtxRegister393 = uint32_t(r_LaneIndexAtPtx874) - uint32_t(r_PtxRegister392); // PTX L909
	r_PtxRegister394 = ShiftLeft(uint32_t(r_PtxRegister38), uint32_t(2));		   // PTX L910
	r_PtxRegister395 = r_bPtxPredicate8 ? 0 : r_PtxRegister394;					   // PTX L911
	r_PtxRegister396 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister39); // PTX L912
	r_PtxRegister397 =
		uint32_t(r_PtxRegister396) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister393); // PTX L913
	r_PtxRegister398 = uint32_t(r_PtxRegister397) + uint32_t(r_PtxRegister395);				 // PTX L914
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_PtxRegister398)) * int64_t(int32_t(4))); // PTX L915
	g_ResidualByteAddressAtPtx916 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register56);			   // PTX L916
	r_PtxRegister2049 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx916); // PTX L917
L__BB19_82:																				   // PTX L918
	r_bPtxPredicate168 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L919
	r_PtxU16Register23 = uint16_t(r_PtxRegister2049);
	r_PtxU16Register24 = uint16_t(r_PtxRegister2049 >> 16);							 // PTX L920
	r_bPtxPredicate169 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L921
	r_bPtxPredicate170 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L922
	r_LaneIndexAtPtx924 = uint32_t((threadIdx.x & 31u));							 // PTX L924
	r_PtxRegister400 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx924), uint32_t(31)); // PTX L926
	r_PtxRegister401 = ShiftRight(uint32_t(r_PtxRegister400), uint32_t(30));		 // PTX L927
	r_PtxRegister402 = uint32_t(r_LaneIndexAtPtx924) + uint32_t(r_PtxRegister401);	 // PTX L928
	r_PtxRegister403 = ShiftRightSigned(int32_t(r_PtxRegister402), uint32_t(2));	 // PTX L929
	r_PtxRegister404 = ShiftRight(uint32_t(r_PtxRegister403), uint32_t(30));		 // PTX L930
	r_PtxRegister405 = uint32_t(r_PtxRegister403) + uint32_t(r_PtxRegister404);		 // PTX L931
	r_PtxRegister406 = r_PtxRegister405 & -4;										 // PTX L932
	r_PtxRegister407 = uint32_t(r_PtxRegister403) - uint32_t(r_PtxRegister406);		 // PTX L933
	r_PtxRegister408 = ShiftRight(uint32_t(r_PtxRegister400), uint32_t(28));		 // PTX L934
	r_PtxRegister409 = uint32_t(r_LaneIndexAtPtx924) + uint32_t(r_PtxRegister408);	 // PTX L935
	r_PtxRegister410 = ShiftRightSigned(int32_t(r_PtxRegister409), uint32_t(4));	 // PTX L936
	r_PtxRegister40 = uint32_t(r_PtxRegister25) + uint32_t(3);						 // PTX L937
	r_PtxRegister411 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister410);		 // PTX L938
	r_PtxRegister41 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister407);		 // PTX L939
	r_bPtxPredicate171 = int32_t(r_PtxRegister411) < int32_t(0);					 // PTX L940
	r_bPtxPredicate172 = int32_t(r_PtxRegister411) >= int32_t(r_HeightBits);		 // PTX L941
	r_bPtxPredicate173 = r_bPtxPredicate171 | r_bPtxPredicate172;					 // PTX L942
	r_bPtxPredicate174 = !r_bPtxPredicate173;										 // PTX L943
	r_PtxRegister42 = r_bPtxPredicate170 ? 0 : r_PtxRegister411;					 // PTX L944
	r_bPtxPredicate175 = r_bPtxPredicate169 & r_bPtxPredicate173;					 // PTX L945
	r_bPtxPredicate176 = r_bPtxPredicate170 | r_bPtxPredicate174;					 // PTX L946
	r_bPtxPredicate177 = r_bPtxPredicate175 | r_bPtxPredicate168;					 // PTX L947
	r_bPtxPredicate178 = int32_t(r_PtxRegister41) > int32_t(-1);					 // PTX L948
	r_bPtxPredicate179 = int32_t(r_PtxRegister41) < int32_t(r_WidthBits);			 // PTX L949
	r_bPtxPredicate180 = r_bPtxPredicate178 & r_bPtxPredicate179;					 // PTX L950
	r_bPtxPredicate181 = !r_bPtxPredicate175;										 // PTX L951
	r_bPtxPredicate9 = r_bPtxPredicate168 & r_bPtxPredicate181;						 // PTX L952
	r_bPtxPredicate182 = r_bPtxPredicate177 | r_bPtxPredicate180;					 // PTX L953
	r_bPtxPredicate183 = r_bPtxPredicate182 & r_bPtxPredicate176;					 // PTX L954
	r_PtxRegister2050 = uint32_t(0);												 // PTX L955
	r_bPtxPredicate184 = !r_bPtxPredicate183;										 // PTX L956
	if (r_bPtxPredicate184)
	{
		goto L__BB19_84;
	} // PTX L957
	r_PtxRegister412 = r_PtxRegister402 & -4;									   // PTX L958
	r_PtxRegister413 = uint32_t(r_LaneIndexAtPtx924) - uint32_t(r_PtxRegister412); // PTX L959
	r_PtxRegister414 = ShiftLeft(uint32_t(r_PtxRegister41), uint32_t(2));		   // PTX L960
	r_PtxRegister415 = r_bPtxPredicate9 ? 0 : r_PtxRegister414;					   // PTX L961
	r_PtxRegister416 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister42); // PTX L962
	r_PtxRegister417 =
		uint32_t(r_PtxRegister416) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister413); // PTX L963
	r_PtxRegister418 = uint32_t(r_PtxRegister417) + uint32_t(r_PtxRegister415);				 // PTX L964
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister418)) * int64_t(int32_t(4))); // PTX L965
	g_ResidualByteAddressAtPtx966 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register58);			   // PTX L966
	r_PtxRegister2050 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx966); // PTX L967
L__BB19_84:																				   // PTX L968
	r_bPtxPredicate185 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L969
	r_PtxU16Register25 = uint16_t(r_PtxRegister2050);
	r_PtxU16Register26 = uint16_t(r_PtxRegister2050 >> 16);							 // PTX L970
	r_bPtxPredicate186 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L971
	r_bPtxPredicate187 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L972
	r_LaneIndexAtPtx974 = uint32_t((threadIdx.x & 31u));							 // PTX L974
	r_PtxRegister420 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx974), uint32_t(31)); // PTX L976
	r_PtxRegister421 = ShiftRight(uint32_t(r_PtxRegister420), uint32_t(30));		 // PTX L977
	r_PtxRegister422 = uint32_t(r_LaneIndexAtPtx974) + uint32_t(r_PtxRegister421);	 // PTX L978
	r_PtxRegister423 = ShiftRightSigned(int32_t(r_PtxRegister422), uint32_t(2));	 // PTX L979
	r_PtxRegister424 = ShiftRight(uint32_t(r_PtxRegister423), uint32_t(30));		 // PTX L980
	r_PtxRegister425 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister424);		 // PTX L981
	r_PtxRegister426 = r_PtxRegister425 & -4;										 // PTX L982
	r_PtxRegister427 = uint32_t(r_PtxRegister423) - uint32_t(r_PtxRegister426);		 // PTX L983
	r_PtxRegister428 = ShiftRight(uint32_t(r_PtxRegister420), uint32_t(28));		 // PTX L984
	r_PtxRegister429 = uint32_t(r_LaneIndexAtPtx974) + uint32_t(r_PtxRegister428);	 // PTX L985
	r_PtxRegister430 = ShiftRightSigned(int32_t(r_PtxRegister429), uint32_t(4));	 // PTX L986
	r_PtxRegister431 = uint32_t(r_PtxRegister430) + uint32_t(r_PtxRegister4);		 // PTX L987
	r_PtxRegister432 = uint32_t(r_PtxRegister431) + uint32_t(2);					 // PTX L988
	r_PtxRegister43 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister427);		 // PTX L989
	r_bPtxPredicate188 = int32_t(r_PtxRegister432) < int32_t(0);					 // PTX L990
	r_bPtxPredicate189 = int32_t(r_PtxRegister432) >= int32_t(r_HeightBits);		 // PTX L991
	r_bPtxPredicate190 = r_bPtxPredicate188 | r_bPtxPredicate189;					 // PTX L992
	r_bPtxPredicate191 = !r_bPtxPredicate190;										 // PTX L993
	r_PtxRegister44 = r_bPtxPredicate187 ? 0 : r_PtxRegister432;					 // PTX L994
	r_bPtxPredicate192 = r_bPtxPredicate186 & r_bPtxPredicate190;					 // PTX L995
	r_bPtxPredicate193 = r_bPtxPredicate187 | r_bPtxPredicate191;					 // PTX L996
	r_bPtxPredicate194 = r_bPtxPredicate192 | r_bPtxPredicate185;					 // PTX L997
	r_bPtxPredicate195 = int32_t(r_PtxRegister43) > int32_t(-1);					 // PTX L998
	r_bPtxPredicate196 = int32_t(r_PtxRegister43) < int32_t(r_WidthBits);			 // PTX L999
	r_bPtxPredicate197 = r_bPtxPredicate195 & r_bPtxPredicate196;					 // PTX L1000
	r_bPtxPredicate198 = !r_bPtxPredicate192;										 // PTX L1001
	r_bPtxPredicate10 = r_bPtxPredicate185 & r_bPtxPredicate198;					 // PTX L1002
	r_bPtxPredicate199 = r_bPtxPredicate194 | r_bPtxPredicate197;					 // PTX L1003
	r_bPtxPredicate200 = r_bPtxPredicate199 & r_bPtxPredicate193;					 // PTX L1004
	r_PtxRegister2051 = uint32_t(0);												 // PTX L1005
	r_bPtxPredicate201 = !r_bPtxPredicate200;										 // PTX L1006
	if (r_bPtxPredicate201)
	{
		goto L__BB19_86;
	} // PTX L1007
	r_PtxRegister433 = r_PtxRegister422 & -4;									   // PTX L1008
	r_PtxRegister434 = uint32_t(r_LaneIndexAtPtx974) - uint32_t(r_PtxRegister433); // PTX L1009
	r_PtxRegister435 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(2));		   // PTX L1010
	r_PtxRegister436 = r_bPtxPredicate10 ? 0 : r_PtxRegister435;				   // PTX L1011
	r_PtxRegister437 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister44); // PTX L1012
	r_PtxRegister438 =
		uint32_t(r_PtxRegister437) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister434); // PTX L1013
	r_PtxRegister439 = uint32_t(r_PtxRegister438) + uint32_t(r_PtxRegister436);				 // PTX L1014
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_PtxRegister439)) * int64_t(int32_t(4))); // PTX L1015
	g_ResidualByteAddressAtPtx1016 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register60);				// PTX L1016
	r_PtxRegister2051 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1016); // PTX L1017
L__BB19_86:																					// PTX L1018
	r_bPtxPredicate202 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1019
	r_PtxU16Register27 = uint16_t(r_PtxRegister2051);
	r_PtxU16Register28 = uint16_t(r_PtxRegister2051 >> 16);							  // PTX L1020
	r_bPtxPredicate203 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1021
	r_bPtxPredicate204 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1022
	r_LaneIndexAtPtx1024 = uint32_t((threadIdx.x & 31u));							  // PTX L1024
	r_PtxRegister441 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1024), uint32_t(31)); // PTX L1026
	r_PtxRegister442 = ShiftRight(uint32_t(r_PtxRegister441), uint32_t(30));		  // PTX L1027
	r_PtxRegister443 = uint32_t(r_LaneIndexAtPtx1024) + uint32_t(r_PtxRegister442);	  // PTX L1028
	r_PtxRegister444 = ShiftRightSigned(int32_t(r_PtxRegister443), uint32_t(2));	  // PTX L1029
	r_PtxRegister445 = ShiftRight(uint32_t(r_PtxRegister444), uint32_t(30));		  // PTX L1030
	r_PtxRegister446 = uint32_t(r_PtxRegister444) + uint32_t(r_PtxRegister445);		  // PTX L1031
	r_PtxRegister447 = r_PtxRegister446 & -4;										  // PTX L1032
	r_PtxRegister448 = uint32_t(r_PtxRegister444) - uint32_t(r_PtxRegister447);		  // PTX L1033
	r_PtxRegister449 = ShiftRight(uint32_t(r_PtxRegister441), uint32_t(28));		  // PTX L1034
	r_PtxRegister450 = uint32_t(r_LaneIndexAtPtx1024) + uint32_t(r_PtxRegister449);	  // PTX L1035
	r_PtxRegister451 = ShiftRightSigned(int32_t(r_PtxRegister450), uint32_t(4));	  // PTX L1036
	r_PtxRegister452 = uint32_t(r_PtxRegister448) + uint32_t(r_PtxRegister5);		  // PTX L1037
	r_PtxRegister453 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister451);		  // PTX L1038
	r_PtxRegister45 = uint32_t(r_PtxRegister452) + uint32_t(4);						  // PTX L1039
	r_bPtxPredicate205 = int32_t(r_PtxRegister453) < int32_t(0);					  // PTX L1040
	r_bPtxPredicate206 = int32_t(r_PtxRegister453) >= int32_t(r_HeightBits);		  // PTX L1041
	r_bPtxPredicate207 = r_bPtxPredicate205 | r_bPtxPredicate206;					  // PTX L1042
	r_bPtxPredicate208 = !r_bPtxPredicate207;										  // PTX L1043
	r_PtxRegister46 = r_bPtxPredicate204 ? 0 : r_PtxRegister453;					  // PTX L1044
	r_bPtxPredicate209 = r_bPtxPredicate203 & r_bPtxPredicate207;					  // PTX L1045
	r_bPtxPredicate210 = r_bPtxPredicate204 | r_bPtxPredicate208;					  // PTX L1046
	r_bPtxPredicate211 = r_bPtxPredicate209 | r_bPtxPredicate202;					  // PTX L1047
	r_bPtxPredicate212 = int32_t(r_PtxRegister45) < int32_t(r_WidthBits);			  // PTX L1048
	r_bPtxPredicate213 = !r_bPtxPredicate209;										  // PTX L1049
	r_bPtxPredicate11 = r_bPtxPredicate202 & r_bPtxPredicate213;					  // PTX L1050
	r_bPtxPredicate214 = r_bPtxPredicate211 | r_bPtxPredicate212;					  // PTX L1051
	r_bPtxPredicate215 = r_bPtxPredicate214 & r_bPtxPredicate210;					  // PTX L1052
	r_PtxRegister2052 = uint32_t(0);												  // PTX L1053
	r_bPtxPredicate216 = !r_bPtxPredicate215;										  // PTX L1054
	if (r_bPtxPredicate216)
	{
		goto L__BB19_88;
	} // PTX L1055
	r_PtxRegister454 = r_PtxRegister443 & -4;										// PTX L1056
	r_PtxRegister455 = uint32_t(r_LaneIndexAtPtx1024) - uint32_t(r_PtxRegister454); // PTX L1057
	r_PtxRegister456 = ShiftLeft(uint32_t(r_PtxRegister45), uint32_t(2));			// PTX L1058
	r_PtxRegister457 = r_bPtxPredicate11 ? 0 : r_PtxRegister456;					// PTX L1059
	r_PtxRegister458 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister46); // PTX L1060
	r_PtxRegister459 =
		uint32_t(r_PtxRegister458) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister455); // PTX L1061
	r_PtxRegister460 = uint32_t(r_PtxRegister459) + uint32_t(r_PtxRegister457);				 // PTX L1062
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister460)) * int64_t(int32_t(4))); // PTX L1063
	g_ResidualByteAddressAtPtx1064 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register62);				// PTX L1064
	r_PtxRegister2052 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1064); // PTX L1065
L__BB19_88:																					// PTX L1066
	r_bPtxPredicate217 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1067
	r_PtxU16Register29 = uint16_t(r_PtxRegister2052);
	r_PtxU16Register30 = uint16_t(r_PtxRegister2052 >> 16);							  // PTX L1068
	r_bPtxPredicate218 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1069
	r_bPtxPredicate219 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1070
	r_LaneIndexAtPtx1072 = uint32_t((threadIdx.x & 31u));							  // PTX L1072
	r_PtxRegister462 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1072), uint32_t(31)); // PTX L1074
	r_PtxRegister463 = ShiftRight(uint32_t(r_PtxRegister462), uint32_t(30));		  // PTX L1075
	r_PtxRegister464 = uint32_t(r_LaneIndexAtPtx1072) + uint32_t(r_PtxRegister463);	  // PTX L1076
	r_PtxRegister465 = ShiftRightSigned(int32_t(r_PtxRegister464), uint32_t(2));	  // PTX L1077
	r_PtxRegister466 = ShiftRight(uint32_t(r_PtxRegister465), uint32_t(30));		  // PTX L1078
	r_PtxRegister467 = uint32_t(r_PtxRegister465) + uint32_t(r_PtxRegister466);		  // PTX L1079
	r_PtxRegister468 = r_PtxRegister467 & -4;										  // PTX L1080
	r_PtxRegister469 = uint32_t(r_PtxRegister465) - uint32_t(r_PtxRegister468);		  // PTX L1081
	r_PtxRegister470 = ShiftRight(uint32_t(r_PtxRegister462), uint32_t(28));		  // PTX L1082
	r_PtxRegister471 = uint32_t(r_LaneIndexAtPtx1072) + uint32_t(r_PtxRegister470);	  // PTX L1083
	r_PtxRegister472 = ShiftRightSigned(int32_t(r_PtxRegister471), uint32_t(4));	  // PTX L1084
	r_PtxRegister473 = uint32_t(r_PtxRegister472) + uint32_t(r_PtxRegister4);		  // PTX L1085
	r_PtxRegister474 = uint32_t(r_PtxRegister469) + uint32_t(r_PtxRegister5);		  // PTX L1086
	r_PtxRegister475 = uint32_t(r_PtxRegister473) + uint32_t(2);					  // PTX L1087
	r_PtxRegister47 = uint32_t(r_PtxRegister474) + uint32_t(4);						  // PTX L1088
	r_bPtxPredicate220 = int32_t(r_PtxRegister475) < int32_t(0);					  // PTX L1089
	r_bPtxPredicate221 = int32_t(r_PtxRegister475) >= int32_t(r_HeightBits);		  // PTX L1090
	r_bPtxPredicate222 = r_bPtxPredicate220 | r_bPtxPredicate221;					  // PTX L1091
	r_bPtxPredicate223 = !r_bPtxPredicate222;										  // PTX L1092
	r_PtxRegister48 = r_bPtxPredicate219 ? 0 : r_PtxRegister475;					  // PTX L1093
	r_bPtxPredicate224 = r_bPtxPredicate218 & r_bPtxPredicate222;					  // PTX L1094
	r_bPtxPredicate225 = r_bPtxPredicate219 | r_bPtxPredicate223;					  // PTX L1095
	r_bPtxPredicate226 = r_bPtxPredicate224 | r_bPtxPredicate217;					  // PTX L1096
	r_bPtxPredicate227 = int32_t(r_PtxRegister47) < int32_t(r_WidthBits);			  // PTX L1097
	r_bPtxPredicate228 = !r_bPtxPredicate224;										  // PTX L1098
	r_bPtxPredicate12 = r_bPtxPredicate217 & r_bPtxPredicate228;					  // PTX L1099
	r_bPtxPredicate229 = r_bPtxPredicate226 | r_bPtxPredicate227;					  // PTX L1100
	r_bPtxPredicate230 = r_bPtxPredicate229 & r_bPtxPredicate225;					  // PTX L1101
	r_PtxRegister2053 = uint32_t(0);												  // PTX L1102
	r_bPtxPredicate231 = !r_bPtxPredicate230;										  // PTX L1103
	if (r_bPtxPredicate231)
	{
		goto L__BB19_90;
	} // PTX L1104
	r_PtxRegister476 = r_PtxRegister464 & -4;										// PTX L1105
	r_PtxRegister477 = uint32_t(r_LaneIndexAtPtx1072) - uint32_t(r_PtxRegister476); // PTX L1106
	r_PtxRegister478 = ShiftLeft(uint32_t(r_PtxRegister47), uint32_t(2));			// PTX L1107
	r_PtxRegister479 = r_bPtxPredicate12 ? 0 : r_PtxRegister478;					// PTX L1108
	r_PtxRegister480 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister48); // PTX L1109
	r_PtxRegister481 =
		uint32_t(r_PtxRegister480) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister477); // PTX L1110
	r_PtxRegister482 = uint32_t(r_PtxRegister481) + uint32_t(r_PtxRegister479);				 // PTX L1111
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_PtxRegister482)) * int64_t(int32_t(4))); // PTX L1112
	g_ResidualByteAddressAtPtx1113 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register64);				// PTX L1113
	r_PtxRegister2053 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1113); // PTX L1114
L__BB19_90:																					// PTX L1115
	r_bPtxPredicate232 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1116
	r_PtxU16Register31 = uint16_t(r_PtxRegister2053);
	r_PtxU16Register32 = uint16_t(r_PtxRegister2053 >> 16);							  // PTX L1117
	r_bPtxPredicate233 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1118
	r_bPtxPredicate234 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1119
	r_LaneIndexAtPtx1121 = uint32_t((threadIdx.x & 31u));							  // PTX L1121
	r_PtxRegister484 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1121), uint32_t(31)); // PTX L1123
	r_PtxRegister485 = ShiftRight(uint32_t(r_PtxRegister484), uint32_t(30));		  // PTX L1124
	r_PtxRegister486 = uint32_t(r_LaneIndexAtPtx1121) + uint32_t(r_PtxRegister485);	  // PTX L1125
	r_PtxRegister487 = ShiftRightSigned(int32_t(r_PtxRegister486), uint32_t(2));	  // PTX L1126
	r_PtxRegister488 = ShiftRight(uint32_t(r_PtxRegister487), uint32_t(30));		  // PTX L1127
	r_PtxRegister489 = uint32_t(r_PtxRegister487) + uint32_t(r_PtxRegister488);		  // PTX L1128
	r_PtxRegister490 = r_PtxRegister489 & -4;										  // PTX L1129
	r_PtxRegister491 = uint32_t(r_PtxRegister487) - uint32_t(r_PtxRegister490);		  // PTX L1130
	r_PtxRegister492 = ShiftRight(uint32_t(r_PtxRegister484), uint32_t(28));		  // PTX L1131
	r_PtxRegister493 = uint32_t(r_LaneIndexAtPtx1121) + uint32_t(r_PtxRegister492);	  // PTX L1132
	r_PtxRegister494 = ShiftRightSigned(int32_t(r_PtxRegister493), uint32_t(4));	  // PTX L1133
	r_PtxRegister495 = uint32_t(r_PtxRegister491) + uint32_t(r_PtxRegister5);		  // PTX L1134
	r_PtxRegister496 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister494);		  // PTX L1135
	r_PtxRegister49 = uint32_t(r_PtxRegister495) + uint32_t(4);						  // PTX L1136
	r_bPtxPredicate235 = int32_t(r_PtxRegister496) < int32_t(0);					  // PTX L1137
	r_bPtxPredicate236 = int32_t(r_PtxRegister496) >= int32_t(r_HeightBits);		  // PTX L1138
	r_bPtxPredicate237 = r_bPtxPredicate235 | r_bPtxPredicate236;					  // PTX L1139
	r_bPtxPredicate238 = !r_bPtxPredicate237;										  // PTX L1140
	r_PtxRegister50 = r_bPtxPredicate234 ? 0 : r_PtxRegister496;					  // PTX L1141
	r_bPtxPredicate239 = r_bPtxPredicate233 & r_bPtxPredicate237;					  // PTX L1142
	r_bPtxPredicate240 = r_bPtxPredicate234 | r_bPtxPredicate238;					  // PTX L1143
	r_bPtxPredicate241 = r_bPtxPredicate239 | r_bPtxPredicate232;					  // PTX L1144
	r_bPtxPredicate242 = int32_t(r_PtxRegister49) < int32_t(r_WidthBits);			  // PTX L1145
	r_bPtxPredicate243 = !r_bPtxPredicate239;										  // PTX L1146
	r_bPtxPredicate13 = r_bPtxPredicate232 & r_bPtxPredicate243;					  // PTX L1147
	r_bPtxPredicate244 = r_bPtxPredicate241 | r_bPtxPredicate242;					  // PTX L1148
	r_bPtxPredicate245 = r_bPtxPredicate244 & r_bPtxPredicate240;					  // PTX L1149
	r_PtxRegister2054 = uint32_t(0);												  // PTX L1150
	r_bPtxPredicate246 = !r_bPtxPredicate245;										  // PTX L1151
	if (r_bPtxPredicate246)
	{
		goto L__BB19_92;
	} // PTX L1152
	r_PtxRegister497 = r_PtxRegister486 & -4;										// PTX L1153
	r_PtxRegister498 = uint32_t(r_LaneIndexAtPtx1121) - uint32_t(r_PtxRegister497); // PTX L1154
	r_PtxRegister499 = ShiftLeft(uint32_t(r_PtxRegister49), uint32_t(2));			// PTX L1155
	r_PtxRegister500 = r_bPtxPredicate13 ? 0 : r_PtxRegister499;					// PTX L1156
	r_PtxRegister501 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister50); // PTX L1157
	r_PtxRegister502 =
		uint32_t(r_PtxRegister501) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister498); // PTX L1158
	r_PtxRegister503 = uint32_t(r_PtxRegister502) + uint32_t(r_PtxRegister500);				 // PTX L1159
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister503)) * int64_t(int32_t(4))); // PTX L1160
	g_ResidualByteAddressAtPtx1161 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register66);				// PTX L1161
	r_PtxRegister2054 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1161); // PTX L1162
L__BB19_92:																					// PTX L1163
	r_bPtxPredicate247 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1164
	r_PtxU16Register33 = uint16_t(r_PtxRegister2054);
	r_PtxU16Register34 = uint16_t(r_PtxRegister2054 >> 16);							  // PTX L1165
	r_bPtxPredicate248 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1166
	r_bPtxPredicate249 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1167
	r_LaneIndexAtPtx1169 = uint32_t((threadIdx.x & 31u));							  // PTX L1169
	r_PtxRegister505 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1169), uint32_t(31)); // PTX L1171
	r_PtxRegister506 = ShiftRight(uint32_t(r_PtxRegister505), uint32_t(30));		  // PTX L1172
	r_PtxRegister507 = uint32_t(r_LaneIndexAtPtx1169) + uint32_t(r_PtxRegister506);	  // PTX L1173
	r_PtxRegister508 = ShiftRightSigned(int32_t(r_PtxRegister507), uint32_t(2));	  // PTX L1174
	r_PtxRegister509 = ShiftRight(uint32_t(r_PtxRegister508), uint32_t(30));		  // PTX L1175
	r_PtxRegister510 = uint32_t(r_PtxRegister508) + uint32_t(r_PtxRegister509);		  // PTX L1176
	r_PtxRegister511 = r_PtxRegister510 & -4;										  // PTX L1177
	r_PtxRegister512 = uint32_t(r_PtxRegister508) - uint32_t(r_PtxRegister511);		  // PTX L1178
	r_PtxRegister513 = ShiftRight(uint32_t(r_PtxRegister505), uint32_t(28));		  // PTX L1179
	r_PtxRegister514 = uint32_t(r_LaneIndexAtPtx1169) + uint32_t(r_PtxRegister513);	  // PTX L1180
	r_PtxRegister515 = ShiftRightSigned(int32_t(r_PtxRegister514), uint32_t(4));	  // PTX L1181
	r_PtxRegister516 = uint32_t(r_PtxRegister515) + uint32_t(r_PtxRegister4);		  // PTX L1182
	r_PtxRegister517 = uint32_t(r_PtxRegister512) + uint32_t(r_PtxRegister5);		  // PTX L1183
	r_PtxRegister518 = uint32_t(r_PtxRegister516) + uint32_t(2);					  // PTX L1184
	r_PtxRegister51 = uint32_t(r_PtxRegister517) + uint32_t(4);						  // PTX L1185
	r_bPtxPredicate250 = int32_t(r_PtxRegister518) < int32_t(0);					  // PTX L1186
	r_bPtxPredicate251 = int32_t(r_PtxRegister518) >= int32_t(r_HeightBits);		  // PTX L1187
	r_bPtxPredicate252 = r_bPtxPredicate250 | r_bPtxPredicate251;					  // PTX L1188
	r_bPtxPredicate253 = !r_bPtxPredicate252;										  // PTX L1189
	r_PtxRegister52 = r_bPtxPredicate249 ? 0 : r_PtxRegister518;					  // PTX L1190
	r_bPtxPredicate254 = r_bPtxPredicate248 & r_bPtxPredicate252;					  // PTX L1191
	r_bPtxPredicate255 = r_bPtxPredicate249 | r_bPtxPredicate253;					  // PTX L1192
	r_bPtxPredicate256 = r_bPtxPredicate254 | r_bPtxPredicate247;					  // PTX L1193
	r_bPtxPredicate257 = int32_t(r_PtxRegister51) < int32_t(r_WidthBits);			  // PTX L1194
	r_bPtxPredicate258 = !r_bPtxPredicate254;										  // PTX L1195
	r_bPtxPredicate14 = r_bPtxPredicate247 & r_bPtxPredicate258;					  // PTX L1196
	r_bPtxPredicate259 = r_bPtxPredicate256 | r_bPtxPredicate257;					  // PTX L1197
	r_bPtxPredicate260 = r_bPtxPredicate259 & r_bPtxPredicate255;					  // PTX L1198
	r_PtxRegister2055 = uint32_t(0);												  // PTX L1199
	r_bPtxPredicate261 = !r_bPtxPredicate260;										  // PTX L1200
	if (r_bPtxPredicate261)
	{
		goto L__BB19_94;
	} // PTX L1201
	r_PtxRegister519 = r_PtxRegister507 & -4;										// PTX L1202
	r_PtxRegister520 = uint32_t(r_LaneIndexAtPtx1169) - uint32_t(r_PtxRegister519); // PTX L1203
	r_PtxRegister521 = ShiftLeft(uint32_t(r_PtxRegister51), uint32_t(2));			// PTX L1204
	r_PtxRegister522 = r_bPtxPredicate14 ? 0 : r_PtxRegister521;					// PTX L1205
	r_PtxRegister523 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister52); // PTX L1206
	r_PtxRegister524 =
		uint32_t(r_PtxRegister523) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister520); // PTX L1207
	r_PtxRegister525 = uint32_t(r_PtxRegister524) + uint32_t(r_PtxRegister522);				 // PTX L1208
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_PtxRegister525)) * int64_t(int32_t(4))); // PTX L1209
	g_ResidualByteAddressAtPtx1210 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register68);				// PTX L1210
	r_PtxRegister2055 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1210); // PTX L1211
L__BB19_94:																					// PTX L1212
	r_bPtxPredicate262 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1213
	r_PtxU16Register35 = uint16_t(r_PtxRegister2055);
	r_PtxU16Register36 = uint16_t(r_PtxRegister2055 >> 16);							  // PTX L1214
	r_bPtxPredicate263 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1215
	r_bPtxPredicate264 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1216
	r_LaneIndexAtPtx1218 = uint32_t((threadIdx.x & 31u));							  // PTX L1218
	r_PtxRegister527 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1218), uint32_t(31)); // PTX L1220
	r_PtxRegister528 = ShiftRight(uint32_t(r_PtxRegister527), uint32_t(30));		  // PTX L1221
	r_PtxRegister529 = uint32_t(r_LaneIndexAtPtx1218) + uint32_t(r_PtxRegister528);	  // PTX L1222
	r_PtxRegister530 = ShiftRightSigned(int32_t(r_PtxRegister529), uint32_t(2));	  // PTX L1223
	r_PtxRegister531 = ShiftRight(uint32_t(r_PtxRegister530), uint32_t(30));		  // PTX L1224
	r_PtxRegister532 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister531);		  // PTX L1225
	r_PtxRegister533 = r_PtxRegister532 & -4;										  // PTX L1226
	r_PtxRegister534 = uint32_t(r_PtxRegister530) - uint32_t(r_PtxRegister533);		  // PTX L1227
	r_PtxRegister535 = ShiftRight(uint32_t(r_PtxRegister527), uint32_t(28));		  // PTX L1228
	r_PtxRegister536 = uint32_t(r_LaneIndexAtPtx1218) + uint32_t(r_PtxRegister535);	  // PTX L1229
	r_PtxRegister537 = ShiftRightSigned(int32_t(r_PtxRegister536), uint32_t(4));	  // PTX L1230
	r_PtxRegister538 = uint32_t(r_PtxRegister534) + uint32_t(r_PtxRegister5);		  // PTX L1231
	r_PtxRegister539 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister537);		  // PTX L1232
	r_PtxRegister53 = uint32_t(r_PtxRegister538) + uint32_t(4);						  // PTX L1233
	r_bPtxPredicate265 = int32_t(r_PtxRegister539) < int32_t(0);					  // PTX L1234
	r_bPtxPredicate266 = int32_t(r_PtxRegister539) >= int32_t(r_HeightBits);		  // PTX L1235
	r_bPtxPredicate267 = r_bPtxPredicate265 | r_bPtxPredicate266;					  // PTX L1236
	r_bPtxPredicate268 = !r_bPtxPredicate267;										  // PTX L1237
	r_PtxRegister54 = r_bPtxPredicate264 ? 0 : r_PtxRegister539;					  // PTX L1238
	r_bPtxPredicate269 = r_bPtxPredicate263 & r_bPtxPredicate267;					  // PTX L1239
	r_bPtxPredicate270 = r_bPtxPredicate264 | r_bPtxPredicate268;					  // PTX L1240
	r_bPtxPredicate271 = r_bPtxPredicate269 | r_bPtxPredicate262;					  // PTX L1241
	r_bPtxPredicate272 = int32_t(r_PtxRegister53) < int32_t(r_WidthBits);			  // PTX L1242
	r_bPtxPredicate273 = !r_bPtxPredicate269;										  // PTX L1243
	r_bPtxPredicate15 = r_bPtxPredicate262 & r_bPtxPredicate273;					  // PTX L1244
	r_bPtxPredicate274 = r_bPtxPredicate271 | r_bPtxPredicate272;					  // PTX L1245
	r_bPtxPredicate275 = r_bPtxPredicate274 & r_bPtxPredicate270;					  // PTX L1246
	r_PtxRegister2056 = uint32_t(0);												  // PTX L1247
	r_bPtxPredicate276 = !r_bPtxPredicate275;										  // PTX L1248
	if (r_bPtxPredicate276)
	{
		goto L__BB19_96;
	} // PTX L1249
	r_PtxRegister540 = r_PtxRegister529 & -4;										// PTX L1250
	r_PtxRegister541 = uint32_t(r_LaneIndexAtPtx1218) - uint32_t(r_PtxRegister540); // PTX L1251
	r_PtxRegister542 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(2));			// PTX L1252
	r_PtxRegister543 = r_bPtxPredicate15 ? 0 : r_PtxRegister542;					// PTX L1253
	r_PtxRegister544 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister54); // PTX L1254
	r_PtxRegister545 =
		uint32_t(r_PtxRegister544) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister541); // PTX L1255
	r_PtxRegister546 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister543);				 // PTX L1256
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister546)) * int64_t(int32_t(4))); // PTX L1257
	g_ResidualByteAddressAtPtx1258 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register70);				// PTX L1258
	r_PtxRegister2056 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1258); // PTX L1259
L__BB19_96:																					// PTX L1260
	r_bPtxPredicate277 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1261
	r_PtxU16Register37 = uint16_t(r_PtxRegister2056);
	r_PtxU16Register38 = uint16_t(r_PtxRegister2056 >> 16);							  // PTX L1262
	r_bPtxPredicate278 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1263
	r_bPtxPredicate279 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1264
	r_LaneIndexAtPtx1266 = uint32_t((threadIdx.x & 31u));							  // PTX L1266
	r_PtxRegister548 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1266), uint32_t(31)); // PTX L1268
	r_PtxRegister549 = ShiftRight(uint32_t(r_PtxRegister548), uint32_t(30));		  // PTX L1269
	r_PtxRegister550 = uint32_t(r_LaneIndexAtPtx1266) + uint32_t(r_PtxRegister549);	  // PTX L1270
	r_PtxRegister551 = ShiftRightSigned(int32_t(r_PtxRegister550), uint32_t(2));	  // PTX L1271
	r_PtxRegister552 = ShiftRight(uint32_t(r_PtxRegister551), uint32_t(30));		  // PTX L1272
	r_PtxRegister553 = uint32_t(r_PtxRegister551) + uint32_t(r_PtxRegister552);		  // PTX L1273
	r_PtxRegister554 = r_PtxRegister553 & -4;										  // PTX L1274
	r_PtxRegister555 = uint32_t(r_PtxRegister551) - uint32_t(r_PtxRegister554);		  // PTX L1275
	r_PtxRegister556 = ShiftRight(uint32_t(r_PtxRegister548), uint32_t(28));		  // PTX L1276
	r_PtxRegister557 = uint32_t(r_LaneIndexAtPtx1266) + uint32_t(r_PtxRegister556);	  // PTX L1277
	r_PtxRegister558 = ShiftRightSigned(int32_t(r_PtxRegister557), uint32_t(4));	  // PTX L1278
	r_PtxRegister559 = uint32_t(r_PtxRegister558) + uint32_t(r_PtxRegister4);		  // PTX L1279
	r_PtxRegister560 = uint32_t(r_PtxRegister555) + uint32_t(r_PtxRegister5);		  // PTX L1280
	r_PtxRegister561 = uint32_t(r_PtxRegister559) + uint32_t(2);					  // PTX L1281
	r_PtxRegister55 = uint32_t(r_PtxRegister560) + uint32_t(4);						  // PTX L1282
	r_bPtxPredicate280 = int32_t(r_PtxRegister561) < int32_t(0);					  // PTX L1283
	r_bPtxPredicate281 = int32_t(r_PtxRegister561) >= int32_t(r_HeightBits);		  // PTX L1284
	r_bPtxPredicate282 = r_bPtxPredicate280 | r_bPtxPredicate281;					  // PTX L1285
	r_bPtxPredicate283 = !r_bPtxPredicate282;										  // PTX L1286
	r_PtxRegister56 = r_bPtxPredicate279 ? 0 : r_PtxRegister561;					  // PTX L1287
	r_bPtxPredicate284 = r_bPtxPredicate278 & r_bPtxPredicate282;					  // PTX L1288
	r_bPtxPredicate285 = r_bPtxPredicate279 | r_bPtxPredicate283;					  // PTX L1289
	r_bPtxPredicate286 = r_bPtxPredicate284 | r_bPtxPredicate277;					  // PTX L1290
	r_bPtxPredicate287 = int32_t(r_PtxRegister55) < int32_t(r_WidthBits);			  // PTX L1291
	r_bPtxPredicate288 = !r_bPtxPredicate284;										  // PTX L1292
	r_bPtxPredicate16 = r_bPtxPredicate277 & r_bPtxPredicate288;					  // PTX L1293
	r_bPtxPredicate289 = r_bPtxPredicate286 | r_bPtxPredicate287;					  // PTX L1294
	r_bPtxPredicate290 = r_bPtxPredicate289 & r_bPtxPredicate285;					  // PTX L1295
	r_PtxRegister2057 = uint32_t(0);												  // PTX L1296
	r_bPtxPredicate291 = !r_bPtxPredicate290;										  // PTX L1297
	if (r_bPtxPredicate291)
	{
		goto L__BB19_98;
	} // PTX L1298
	r_PtxRegister562 = r_PtxRegister550 & -4;										// PTX L1299
	r_PtxRegister563 = uint32_t(r_LaneIndexAtPtx1266) - uint32_t(r_PtxRegister562); // PTX L1300
	r_PtxRegister564 = ShiftLeft(uint32_t(r_PtxRegister55), uint32_t(2));			// PTX L1301
	r_PtxRegister565 = r_bPtxPredicate16 ? 0 : r_PtxRegister564;					// PTX L1302
	r_PtxRegister566 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister56); // PTX L1303
	r_PtxRegister567 =
		uint32_t(r_PtxRegister566) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister563); // PTX L1304
	r_PtxRegister568 = uint32_t(r_PtxRegister567) + uint32_t(r_PtxRegister565);				 // PTX L1305
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_PtxRegister568)) * int64_t(int32_t(4))); // PTX L1306
	g_ResidualByteAddressAtPtx1307 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register72);				// PTX L1307
	r_PtxRegister2057 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1307); // PTX L1308
L__BB19_98:																					// PTX L1309
	r_bPtxPredicate292 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1310
	r_PtxU16Register39 = uint16_t(r_PtxRegister2057);
	r_PtxU16Register40 = uint16_t(r_PtxRegister2057 >> 16);							  // PTX L1311
	r_bPtxPredicate293 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1312
	r_bPtxPredicate294 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1313
	r_LaneIndexAtPtx1315 = uint32_t((threadIdx.x & 31u));							  // PTX L1315
	r_PtxRegister570 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1315), uint32_t(31)); // PTX L1317
	r_PtxRegister571 = ShiftRight(uint32_t(r_PtxRegister570), uint32_t(30));		  // PTX L1318
	r_PtxRegister572 = uint32_t(r_LaneIndexAtPtx1315) + uint32_t(r_PtxRegister571);	  // PTX L1319
	r_PtxRegister573 = ShiftRightSigned(int32_t(r_PtxRegister572), uint32_t(2));	  // PTX L1320
	r_PtxRegister574 = ShiftRight(uint32_t(r_PtxRegister573), uint32_t(30));		  // PTX L1321
	r_PtxRegister575 = uint32_t(r_PtxRegister573) + uint32_t(r_PtxRegister574);		  // PTX L1322
	r_PtxRegister576 = r_PtxRegister575 & -4;										  // PTX L1323
	r_PtxRegister577 = uint32_t(r_PtxRegister573) - uint32_t(r_PtxRegister576);		  // PTX L1324
	r_PtxRegister578 = ShiftRight(uint32_t(r_PtxRegister570), uint32_t(28));		  // PTX L1325
	r_PtxRegister579 = uint32_t(r_LaneIndexAtPtx1315) + uint32_t(r_PtxRegister578);	  // PTX L1326
	r_PtxRegister580 = ShiftRightSigned(int32_t(r_PtxRegister579), uint32_t(4));	  // PTX L1327
	r_PtxRegister581 = uint32_t(r_PtxRegister577) + uint32_t(r_PtxRegister5);		  // PTX L1328
	r_PtxRegister582 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister580);		  // PTX L1329
	r_PtxRegister57 = uint32_t(r_PtxRegister581) + uint32_t(4);						  // PTX L1330
	r_bPtxPredicate295 = int32_t(r_PtxRegister582) < int32_t(0);					  // PTX L1331
	r_bPtxPredicate296 = int32_t(r_PtxRegister582) >= int32_t(r_HeightBits);		  // PTX L1332
	r_bPtxPredicate297 = r_bPtxPredicate295 | r_bPtxPredicate296;					  // PTX L1333
	r_bPtxPredicate298 = !r_bPtxPredicate297;										  // PTX L1334
	r_PtxRegister58 = r_bPtxPredicate294 ? 0 : r_PtxRegister582;					  // PTX L1335
	r_bPtxPredicate299 = r_bPtxPredicate293 & r_bPtxPredicate297;					  // PTX L1336
	r_bPtxPredicate300 = r_bPtxPredicate294 | r_bPtxPredicate298;					  // PTX L1337
	r_bPtxPredicate301 = r_bPtxPredicate299 | r_bPtxPredicate292;					  // PTX L1338
	r_bPtxPredicate302 = int32_t(r_PtxRegister57) < int32_t(r_WidthBits);			  // PTX L1339
	r_bPtxPredicate303 = !r_bPtxPredicate299;										  // PTX L1340
	r_bPtxPredicate17 = r_bPtxPredicate292 & r_bPtxPredicate303;					  // PTX L1341
	r_bPtxPredicate304 = r_bPtxPredicate301 | r_bPtxPredicate302;					  // PTX L1342
	r_bPtxPredicate305 = r_bPtxPredicate304 & r_bPtxPredicate300;					  // PTX L1343
	r_PtxRegister2058 = uint32_t(0);												  // PTX L1344
	r_bPtxPredicate306 = !r_bPtxPredicate305;										  // PTX L1345
	if (r_bPtxPredicate306)
	{
		goto L__BB19_100;
	} // PTX L1346
	r_PtxRegister583 = r_PtxRegister572 & -4;										// PTX L1347
	r_PtxRegister584 = uint32_t(r_LaneIndexAtPtx1315) - uint32_t(r_PtxRegister583); // PTX L1348
	r_PtxRegister585 = ShiftLeft(uint32_t(r_PtxRegister57), uint32_t(2));			// PTX L1349
	r_PtxRegister586 = r_bPtxPredicate17 ? 0 : r_PtxRegister585;					// PTX L1350
	r_PtxRegister587 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister58); // PTX L1351
	r_PtxRegister588 =
		uint32_t(r_PtxRegister587) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister584); // PTX L1352
	r_PtxRegister589 = uint32_t(r_PtxRegister588) + uint32_t(r_PtxRegister586);				 // PTX L1353
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister589)) * int64_t(int32_t(4))); // PTX L1354
	g_ResidualByteAddressAtPtx1355 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register74);				// PTX L1355
	r_PtxRegister2058 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1355); // PTX L1356
L__BB19_100:																				// PTX L1357
	r_bPtxPredicate307 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1358
	r_PtxU16Register41 = uint16_t(r_PtxRegister2058);
	r_PtxU16Register42 = uint16_t(r_PtxRegister2058 >> 16);							  // PTX L1359
	r_bPtxPredicate308 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1360
	r_bPtxPredicate309 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1361
	r_LaneIndexAtPtx1363 = uint32_t((threadIdx.x & 31u));							  // PTX L1363
	r_PtxRegister591 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1363), uint32_t(31)); // PTX L1365
	r_PtxRegister592 = ShiftRight(uint32_t(r_PtxRegister591), uint32_t(30));		  // PTX L1366
	r_PtxRegister593 = uint32_t(r_LaneIndexAtPtx1363) + uint32_t(r_PtxRegister592);	  // PTX L1367
	r_PtxRegister594 = ShiftRightSigned(int32_t(r_PtxRegister593), uint32_t(2));	  // PTX L1368
	r_PtxRegister595 = ShiftRight(uint32_t(r_PtxRegister594), uint32_t(30));		  // PTX L1369
	r_PtxRegister596 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister595);		  // PTX L1370
	r_PtxRegister597 = r_PtxRegister596 & -4;										  // PTX L1371
	r_PtxRegister598 = uint32_t(r_PtxRegister594) - uint32_t(r_PtxRegister597);		  // PTX L1372
	r_PtxRegister599 = ShiftRight(uint32_t(r_PtxRegister591), uint32_t(28));		  // PTX L1373
	r_PtxRegister600 = uint32_t(r_LaneIndexAtPtx1363) + uint32_t(r_PtxRegister599);	  // PTX L1374
	r_PtxRegister601 = ShiftRightSigned(int32_t(r_PtxRegister600), uint32_t(4));	  // PTX L1375
	r_PtxRegister602 = uint32_t(r_PtxRegister601) + uint32_t(r_PtxRegister4);		  // PTX L1376
	r_PtxRegister603 = uint32_t(r_PtxRegister598) + uint32_t(r_PtxRegister5);		  // PTX L1377
	r_PtxRegister604 = uint32_t(r_PtxRegister602) + uint32_t(2);					  // PTX L1378
	r_PtxRegister59 = uint32_t(r_PtxRegister603) + uint32_t(4);						  // PTX L1379
	r_bPtxPredicate310 = int32_t(r_PtxRegister604) < int32_t(0);					  // PTX L1380
	r_bPtxPredicate311 = int32_t(r_PtxRegister604) >= int32_t(r_HeightBits);		  // PTX L1381
	r_bPtxPredicate312 = r_bPtxPredicate310 | r_bPtxPredicate311;					  // PTX L1382
	r_bPtxPredicate313 = !r_bPtxPredicate312;										  // PTX L1383
	r_PtxRegister60 = r_bPtxPredicate309 ? 0 : r_PtxRegister604;					  // PTX L1384
	r_bPtxPredicate314 = r_bPtxPredicate308 & r_bPtxPredicate312;					  // PTX L1385
	r_bPtxPredicate315 = r_bPtxPredicate309 | r_bPtxPredicate313;					  // PTX L1386
	r_bPtxPredicate316 = r_bPtxPredicate314 | r_bPtxPredicate307;					  // PTX L1387
	r_bPtxPredicate317 = int32_t(r_PtxRegister59) < int32_t(r_WidthBits);			  // PTX L1388
	r_bPtxPredicate318 = !r_bPtxPredicate314;										  // PTX L1389
	r_bPtxPredicate18 = r_bPtxPredicate307 & r_bPtxPredicate318;					  // PTX L1390
	r_bPtxPredicate319 = r_bPtxPredicate316 | r_bPtxPredicate317;					  // PTX L1391
	r_bPtxPredicate320 = r_bPtxPredicate319 & r_bPtxPredicate315;					  // PTX L1392
	r_PtxRegister2059 = uint32_t(0);												  // PTX L1393
	r_bPtxPredicate321 = !r_bPtxPredicate320;										  // PTX L1394
	if (r_bPtxPredicate321)
	{
		goto L__BB19_102;
	} // PTX L1395
	r_PtxRegister605 = r_PtxRegister593 & -4;										// PTX L1396
	r_PtxRegister606 = uint32_t(r_LaneIndexAtPtx1363) - uint32_t(r_PtxRegister605); // PTX L1397
	r_PtxRegister607 = ShiftLeft(uint32_t(r_PtxRegister59), uint32_t(2));			// PTX L1398
	r_PtxRegister608 = r_bPtxPredicate18 ? 0 : r_PtxRegister607;					// PTX L1399
	r_PtxRegister609 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister60); // PTX L1400
	r_PtxRegister610 =
		uint32_t(r_PtxRegister609) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister606); // PTX L1401
	r_PtxRegister611 = uint32_t(r_PtxRegister610) + uint32_t(r_PtxRegister608);				 // PTX L1402
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister611)) * int64_t(int32_t(4))); // PTX L1403
	g_ResidualByteAddressAtPtx1404 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register76);				// PTX L1404
	r_PtxRegister2059 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1404); // PTX L1405
L__BB19_102:																				// PTX L1406
	r_bPtxPredicate322 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1407
	r_PtxU16Register43 = uint16_t(r_PtxRegister2059);
	r_PtxU16Register44 = uint16_t(r_PtxRegister2059 >> 16);							  // PTX L1408
	r_bPtxPredicate323 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1409
	r_bPtxPredicate324 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1410
	r_LaneIndexAtPtx1412 = uint32_t((threadIdx.x & 31u));							  // PTX L1412
	r_PtxRegister613 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1412), uint32_t(31)); // PTX L1414
	r_PtxRegister614 = ShiftRight(uint32_t(r_PtxRegister613), uint32_t(30));		  // PTX L1415
	r_PtxRegister615 = uint32_t(r_LaneIndexAtPtx1412) + uint32_t(r_PtxRegister614);	  // PTX L1416
	r_PtxRegister616 = ShiftRightSigned(int32_t(r_PtxRegister615), uint32_t(2));	  // PTX L1417
	r_PtxRegister617 = ShiftRight(uint32_t(r_PtxRegister616), uint32_t(30));		  // PTX L1418
	r_PtxRegister618 = uint32_t(r_PtxRegister616) + uint32_t(r_PtxRegister617);		  // PTX L1419
	r_PtxRegister619 = r_PtxRegister618 & -4;										  // PTX L1420
	r_PtxRegister620 = uint32_t(r_PtxRegister616) - uint32_t(r_PtxRegister619);		  // PTX L1421
	r_PtxRegister621 = ShiftRight(uint32_t(r_PtxRegister613), uint32_t(28));		  // PTX L1422
	r_PtxRegister622 = uint32_t(r_LaneIndexAtPtx1412) + uint32_t(r_PtxRegister621);	  // PTX L1423
	r_PtxRegister623 = ShiftRightSigned(int32_t(r_PtxRegister622), uint32_t(4));	  // PTX L1424
	r_PtxRegister624 = uint32_t(r_PtxRegister623) + uint32_t(r_PtxRegister4);		  // PTX L1425
	r_PtxRegister625 = uint32_t(r_PtxRegister624) + uint32_t(4);					  // PTX L1426
	r_PtxRegister61 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister620);		  // PTX L1427
	r_bPtxPredicate325 = int32_t(r_PtxRegister625) < int32_t(0);					  // PTX L1428
	r_bPtxPredicate326 = int32_t(r_PtxRegister625) >= int32_t(r_HeightBits);		  // PTX L1429
	r_bPtxPredicate327 = r_bPtxPredicate325 | r_bPtxPredicate326;					  // PTX L1430
	r_bPtxPredicate328 = !r_bPtxPredicate327;										  // PTX L1431
	r_PtxRegister62 = r_bPtxPredicate324 ? 0 : r_PtxRegister625;					  // PTX L1432
	r_bPtxPredicate329 = r_bPtxPredicate323 & r_bPtxPredicate327;					  // PTX L1433
	r_bPtxPredicate330 = r_bPtxPredicate324 | r_bPtxPredicate328;					  // PTX L1434
	r_bPtxPredicate331 = r_bPtxPredicate329 | r_bPtxPredicate322;					  // PTX L1435
	r_bPtxPredicate332 = int32_t(r_PtxRegister61) > int32_t(-1);					  // PTX L1436
	r_bPtxPredicate333 = int32_t(r_PtxRegister61) < int32_t(r_WidthBits);			  // PTX L1437
	r_bPtxPredicate334 = r_bPtxPredicate332 & r_bPtxPredicate333;					  // PTX L1438
	r_bPtxPredicate335 = !r_bPtxPredicate329;										  // PTX L1439
	r_bPtxPredicate19 = r_bPtxPredicate322 & r_bPtxPredicate335;					  // PTX L1440
	r_bPtxPredicate336 = r_bPtxPredicate331 | r_bPtxPredicate334;					  // PTX L1441
	r_bPtxPredicate337 = r_bPtxPredicate336 & r_bPtxPredicate330;					  // PTX L1442
	r_PtxRegister2060 = uint32_t(0);												  // PTX L1443
	r_bPtxPredicate338 = !r_bPtxPredicate337;										  // PTX L1444
	if (r_bPtxPredicate338)
	{
		goto L__BB19_104;
	} // PTX L1445
	r_PtxRegister626 = r_PtxRegister615 & -4;										// PTX L1446
	r_PtxRegister627 = uint32_t(r_LaneIndexAtPtx1412) - uint32_t(r_PtxRegister626); // PTX L1447
	r_PtxRegister628 = ShiftLeft(uint32_t(r_PtxRegister61), uint32_t(2));			// PTX L1448
	r_PtxRegister629 = r_bPtxPredicate19 ? 0 : r_PtxRegister628;					// PTX L1449
	r_PtxRegister630 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister62); // PTX L1450
	r_PtxRegister631 =
		uint32_t(r_PtxRegister630) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister627); // PTX L1451
	r_PtxRegister632 = uint32_t(r_PtxRegister631) + uint32_t(r_PtxRegister629);				 // PTX L1452
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister632)) * int64_t(int32_t(4))); // PTX L1453
	g_ResidualByteAddressAtPtx1454 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register78);				// PTX L1454
	r_PtxRegister2060 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1454); // PTX L1455
L__BB19_104:																				// PTX L1456
	r_bPtxPredicate339 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1457
	r_PtxU16Register45 = uint16_t(r_PtxRegister2060);
	r_PtxU16Register46 = uint16_t(r_PtxRegister2060 >> 16);							  // PTX L1458
	r_bPtxPredicate340 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1459
	r_bPtxPredicate341 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1460
	r_LaneIndexAtPtx1462 = uint32_t((threadIdx.x & 31u));							  // PTX L1462
	r_PtxRegister634 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1462), uint32_t(31)); // PTX L1464
	r_PtxRegister635 = ShiftRight(uint32_t(r_PtxRegister634), uint32_t(30));		  // PTX L1465
	r_PtxRegister636 = uint32_t(r_LaneIndexAtPtx1462) + uint32_t(r_PtxRegister635);	  // PTX L1466
	r_PtxRegister637 = ShiftRightSigned(int32_t(r_PtxRegister636), uint32_t(2));	  // PTX L1467
	r_PtxRegister638 = ShiftRight(uint32_t(r_PtxRegister637), uint32_t(30));		  // PTX L1468
	r_PtxRegister639 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister638);		  // PTX L1469
	r_PtxRegister640 = r_PtxRegister639 & -4;										  // PTX L1470
	r_PtxRegister641 = uint32_t(r_PtxRegister637) - uint32_t(r_PtxRegister640);		  // PTX L1471
	r_PtxRegister642 = ShiftRight(uint32_t(r_PtxRegister634), uint32_t(28));		  // PTX L1472
	r_PtxRegister643 = uint32_t(r_LaneIndexAtPtx1462) + uint32_t(r_PtxRegister642);	  // PTX L1473
	r_PtxRegister644 = ShiftRightSigned(int32_t(r_PtxRegister643), uint32_t(4));	  // PTX L1474
	r_PtxRegister645 = uint32_t(r_PtxRegister644) + uint32_t(r_PtxRegister4);		  // PTX L1475
	r_PtxRegister646 = uint32_t(r_PtxRegister645) + uint32_t(6);					  // PTX L1476
	r_PtxRegister63 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister641);		  // PTX L1477
	r_bPtxPredicate342 = int32_t(r_PtxRegister646) < int32_t(0);					  // PTX L1478
	r_bPtxPredicate343 = int32_t(r_PtxRegister646) >= int32_t(r_HeightBits);		  // PTX L1479
	r_bPtxPredicate344 = r_bPtxPredicate342 | r_bPtxPredicate343;					  // PTX L1480
	r_bPtxPredicate345 = !r_bPtxPredicate344;										  // PTX L1481
	r_PtxRegister64 = r_bPtxPredicate341 ? 0 : r_PtxRegister646;					  // PTX L1482
	r_bPtxPredicate346 = r_bPtxPredicate340 & r_bPtxPredicate344;					  // PTX L1483
	r_bPtxPredicate347 = r_bPtxPredicate341 | r_bPtxPredicate345;					  // PTX L1484
	r_bPtxPredicate348 = r_bPtxPredicate346 | r_bPtxPredicate339;					  // PTX L1485
	r_bPtxPredicate349 = int32_t(r_PtxRegister63) > int32_t(-1);					  // PTX L1486
	r_bPtxPredicate350 = int32_t(r_PtxRegister63) < int32_t(r_WidthBits);			  // PTX L1487
	r_bPtxPredicate351 = r_bPtxPredicate349 & r_bPtxPredicate350;					  // PTX L1488
	r_bPtxPredicate352 = !r_bPtxPredicate346;										  // PTX L1489
	r_bPtxPredicate20 = r_bPtxPredicate339 & r_bPtxPredicate352;					  // PTX L1490
	r_bPtxPredicate353 = r_bPtxPredicate348 | r_bPtxPredicate351;					  // PTX L1491
	r_bPtxPredicate354 = r_bPtxPredicate353 & r_bPtxPredicate347;					  // PTX L1492
	r_PtxRegister2061 = uint32_t(0);												  // PTX L1493
	r_bPtxPredicate355 = !r_bPtxPredicate354;										  // PTX L1494
	if (r_bPtxPredicate355)
	{
		goto L__BB19_106;
	} // PTX L1495
	r_PtxRegister647 = r_PtxRegister636 & -4;										// PTX L1496
	r_PtxRegister648 = uint32_t(r_LaneIndexAtPtx1462) - uint32_t(r_PtxRegister647); // PTX L1497
	r_PtxRegister649 = ShiftLeft(uint32_t(r_PtxRegister63), uint32_t(2));			// PTX L1498
	r_PtxRegister650 = r_bPtxPredicate20 ? 0 : r_PtxRegister649;					// PTX L1499
	r_PtxRegister651 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister64); // PTX L1500
	r_PtxRegister652 =
		uint32_t(r_PtxRegister651) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister648); // PTX L1501
	r_PtxRegister653 = uint32_t(r_PtxRegister652) + uint32_t(r_PtxRegister650);				 // PTX L1502
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_PtxRegister653)) * int64_t(int32_t(4))); // PTX L1503
	g_ResidualByteAddressAtPtx1504 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register80);				// PTX L1504
	r_PtxRegister2061 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1504); // PTX L1505
L__BB19_106:																				// PTX L1506
	r_bPtxPredicate356 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1507
	r_PtxU16Register47 = uint16_t(r_PtxRegister2061);
	r_PtxU16Register48 = uint16_t(r_PtxRegister2061 >> 16);							  // PTX L1508
	r_bPtxPredicate357 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1509
	r_bPtxPredicate358 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1510
	r_LaneIndexAtPtx1512 = uint32_t((threadIdx.x & 31u));							  // PTX L1512
	r_PtxRegister655 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1512), uint32_t(31)); // PTX L1514
	r_PtxRegister656 = ShiftRight(uint32_t(r_PtxRegister655), uint32_t(30));		  // PTX L1515
	r_PtxRegister657 = uint32_t(r_LaneIndexAtPtx1512) + uint32_t(r_PtxRegister656);	  // PTX L1516
	r_PtxRegister658 = ShiftRightSigned(int32_t(r_PtxRegister657), uint32_t(2));	  // PTX L1517
	r_PtxRegister659 = ShiftRight(uint32_t(r_PtxRegister658), uint32_t(30));		  // PTX L1518
	r_PtxRegister660 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister659);		  // PTX L1519
	r_PtxRegister661 = r_PtxRegister660 & -4;										  // PTX L1520
	r_PtxRegister662 = uint32_t(r_PtxRegister658) - uint32_t(r_PtxRegister661);		  // PTX L1521
	r_PtxRegister663 = ShiftRight(uint32_t(r_PtxRegister655), uint32_t(28));		  // PTX L1522
	r_PtxRegister664 = uint32_t(r_LaneIndexAtPtx1512) + uint32_t(r_PtxRegister663);	  // PTX L1523
	r_PtxRegister665 = ShiftRightSigned(int32_t(r_PtxRegister664), uint32_t(4));	  // PTX L1524
	r_PtxRegister666 = uint32_t(r_PtxRegister665) + uint32_t(r_PtxRegister4);		  // PTX L1525
	r_PtxRegister667 = uint32_t(r_PtxRegister666) + uint32_t(4);					  // PTX L1526
	r_PtxRegister65 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister662);		  // PTX L1527
	r_bPtxPredicate359 = int32_t(r_PtxRegister667) < int32_t(0);					  // PTX L1528
	r_bPtxPredicate360 = int32_t(r_PtxRegister667) >= int32_t(r_HeightBits);		  // PTX L1529
	r_bPtxPredicate361 = r_bPtxPredicate359 | r_bPtxPredicate360;					  // PTX L1530
	r_bPtxPredicate362 = !r_bPtxPredicate361;										  // PTX L1531
	r_PtxRegister66 = r_bPtxPredicate358 ? 0 : r_PtxRegister667;					  // PTX L1532
	r_bPtxPredicate363 = r_bPtxPredicate357 & r_bPtxPredicate361;					  // PTX L1533
	r_bPtxPredicate364 = r_bPtxPredicate358 | r_bPtxPredicate362;					  // PTX L1534
	r_bPtxPredicate365 = r_bPtxPredicate363 | r_bPtxPredicate356;					  // PTX L1535
	r_bPtxPredicate366 = int32_t(r_PtxRegister65) > int32_t(-1);					  // PTX L1536
	r_bPtxPredicate367 = int32_t(r_PtxRegister65) < int32_t(r_WidthBits);			  // PTX L1537
	r_bPtxPredicate368 = r_bPtxPredicate366 & r_bPtxPredicate367;					  // PTX L1538
	r_bPtxPredicate369 = !r_bPtxPredicate363;										  // PTX L1539
	r_bPtxPredicate21 = r_bPtxPredicate356 & r_bPtxPredicate369;					  // PTX L1540
	r_bPtxPredicate370 = r_bPtxPredicate365 | r_bPtxPredicate368;					  // PTX L1541
	r_bPtxPredicate371 = r_bPtxPredicate370 & r_bPtxPredicate364;					  // PTX L1542
	r_PtxRegister2062 = uint32_t(0);												  // PTX L1543
	r_bPtxPredicate372 = !r_bPtxPredicate371;										  // PTX L1544
	if (r_bPtxPredicate372)
	{
		goto L__BB19_108;
	} // PTX L1545
	r_PtxRegister668 = r_PtxRegister657 & -4;										// PTX L1546
	r_PtxRegister669 = uint32_t(r_LaneIndexAtPtx1512) - uint32_t(r_PtxRegister668); // PTX L1547
	r_PtxRegister670 = ShiftLeft(uint32_t(r_PtxRegister65), uint32_t(2));			// PTX L1548
	r_PtxRegister671 = r_bPtxPredicate21 ? 0 : r_PtxRegister670;					// PTX L1549
	r_PtxRegister672 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister66); // PTX L1550
	r_PtxRegister673 =
		uint32_t(r_PtxRegister672) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister669); // PTX L1551
	r_PtxRegister674 = uint32_t(r_PtxRegister673) + uint32_t(r_PtxRegister671);				 // PTX L1552
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister674)) * int64_t(int32_t(4))); // PTX L1553
	g_ResidualByteAddressAtPtx1554 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register82);				// PTX L1554
	r_PtxRegister2062 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1554); // PTX L1555
L__BB19_108:																				// PTX L1556
	r_bPtxPredicate373 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1557
	r_PtxU16Register49 = uint16_t(r_PtxRegister2062);
	r_PtxU16Register50 = uint16_t(r_PtxRegister2062 >> 16);							  // PTX L1558
	r_bPtxPredicate374 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1559
	r_bPtxPredicate375 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1560
	r_LaneIndexAtPtx1562 = uint32_t((threadIdx.x & 31u));							  // PTX L1562
	r_PtxRegister676 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1562), uint32_t(31)); // PTX L1564
	r_PtxRegister677 = ShiftRight(uint32_t(r_PtxRegister676), uint32_t(30));		  // PTX L1565
	r_PtxRegister678 = uint32_t(r_LaneIndexAtPtx1562) + uint32_t(r_PtxRegister677);	  // PTX L1566
	r_PtxRegister679 = ShiftRightSigned(int32_t(r_PtxRegister678), uint32_t(2));	  // PTX L1567
	r_PtxRegister680 = ShiftRight(uint32_t(r_PtxRegister679), uint32_t(30));		  // PTX L1568
	r_PtxRegister681 = uint32_t(r_PtxRegister679) + uint32_t(r_PtxRegister680);		  // PTX L1569
	r_PtxRegister682 = r_PtxRegister681 & -4;										  // PTX L1570
	r_PtxRegister683 = uint32_t(r_PtxRegister679) - uint32_t(r_PtxRegister682);		  // PTX L1571
	r_PtxRegister684 = ShiftRight(uint32_t(r_PtxRegister676), uint32_t(28));		  // PTX L1572
	r_PtxRegister685 = uint32_t(r_LaneIndexAtPtx1562) + uint32_t(r_PtxRegister684);	  // PTX L1573
	r_PtxRegister686 = ShiftRightSigned(int32_t(r_PtxRegister685), uint32_t(4));	  // PTX L1574
	r_PtxRegister687 = uint32_t(r_PtxRegister686) + uint32_t(r_PtxRegister4);		  // PTX L1575
	r_PtxRegister688 = uint32_t(r_PtxRegister687) + uint32_t(6);					  // PTX L1576
	r_PtxRegister67 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister683);		  // PTX L1577
	r_bPtxPredicate376 = int32_t(r_PtxRegister688) < int32_t(0);					  // PTX L1578
	r_bPtxPredicate377 = int32_t(r_PtxRegister688) >= int32_t(r_HeightBits);		  // PTX L1579
	r_bPtxPredicate378 = r_bPtxPredicate376 | r_bPtxPredicate377;					  // PTX L1580
	r_bPtxPredicate379 = !r_bPtxPredicate378;										  // PTX L1581
	r_PtxRegister68 = r_bPtxPredicate375 ? 0 : r_PtxRegister688;					  // PTX L1582
	r_bPtxPredicate380 = r_bPtxPredicate374 & r_bPtxPredicate378;					  // PTX L1583
	r_bPtxPredicate381 = r_bPtxPredicate375 | r_bPtxPredicate379;					  // PTX L1584
	r_bPtxPredicate382 = r_bPtxPredicate380 | r_bPtxPredicate373;					  // PTX L1585
	r_bPtxPredicate383 = int32_t(r_PtxRegister67) > int32_t(-1);					  // PTX L1586
	r_bPtxPredicate384 = int32_t(r_PtxRegister67) < int32_t(r_WidthBits);			  // PTX L1587
	r_bPtxPredicate385 = r_bPtxPredicate383 & r_bPtxPredicate384;					  // PTX L1588
	r_bPtxPredicate386 = !r_bPtxPredicate380;										  // PTX L1589
	r_bPtxPredicate22 = r_bPtxPredicate373 & r_bPtxPredicate386;					  // PTX L1590
	r_bPtxPredicate387 = r_bPtxPredicate382 | r_bPtxPredicate385;					  // PTX L1591
	r_bPtxPredicate388 = r_bPtxPredicate387 & r_bPtxPredicate381;					  // PTX L1592
	r_PtxRegister2063 = uint32_t(0);												  // PTX L1593
	r_bPtxPredicate389 = !r_bPtxPredicate388;										  // PTX L1594
	if (r_bPtxPredicate389)
	{
		goto L__BB19_110;
	} // PTX L1595
	r_PtxRegister689 = r_PtxRegister678 & -4;										// PTX L1596
	r_PtxRegister690 = uint32_t(r_LaneIndexAtPtx1562) - uint32_t(r_PtxRegister689); // PTX L1597
	r_PtxRegister691 = ShiftLeft(uint32_t(r_PtxRegister67), uint32_t(2));			// PTX L1598
	r_PtxRegister692 = r_bPtxPredicate22 ? 0 : r_PtxRegister691;					// PTX L1599
	r_PtxRegister693 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister68); // PTX L1600
	r_PtxRegister694 =
		uint32_t(r_PtxRegister693) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister690); // PTX L1601
	r_PtxRegister695 = uint32_t(r_PtxRegister694) + uint32_t(r_PtxRegister692);				 // PTX L1602
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister695)) * int64_t(int32_t(4))); // PTX L1603
	g_ResidualByteAddressAtPtx1604 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register84);				// PTX L1604
	r_PtxRegister2063 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1604); // PTX L1605
L__BB19_110:																				// PTX L1606
	r_bPtxPredicate390 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1607
	r_PtxU16Register51 = uint16_t(r_PtxRegister2063);
	r_PtxU16Register52 = uint16_t(r_PtxRegister2063 >> 16);							  // PTX L1608
	r_bPtxPredicate391 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1609
	r_bPtxPredicate392 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1610
	r_LaneIndexAtPtx1612 = uint32_t((threadIdx.x & 31u));							  // PTX L1612
	r_PtxRegister697 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1612), uint32_t(31)); // PTX L1614
	r_PtxRegister698 = ShiftRight(uint32_t(r_PtxRegister697), uint32_t(30));		  // PTX L1615
	r_PtxRegister699 = uint32_t(r_LaneIndexAtPtx1612) + uint32_t(r_PtxRegister698);	  // PTX L1616
	r_PtxRegister700 = ShiftRightSigned(int32_t(r_PtxRegister699), uint32_t(2));	  // PTX L1617
	r_PtxRegister701 = ShiftRight(uint32_t(r_PtxRegister700), uint32_t(30));		  // PTX L1618
	r_PtxRegister702 = uint32_t(r_PtxRegister700) + uint32_t(r_PtxRegister701);		  // PTX L1619
	r_PtxRegister703 = r_PtxRegister702 & -4;										  // PTX L1620
	r_PtxRegister704 = uint32_t(r_PtxRegister700) - uint32_t(r_PtxRegister703);		  // PTX L1621
	r_PtxRegister705 = ShiftRight(uint32_t(r_PtxRegister697), uint32_t(28));		  // PTX L1622
	r_PtxRegister706 = uint32_t(r_LaneIndexAtPtx1612) + uint32_t(r_PtxRegister705);	  // PTX L1623
	r_PtxRegister707 = ShiftRightSigned(int32_t(r_PtxRegister706), uint32_t(4));	  // PTX L1624
	r_PtxRegister708 = uint32_t(r_PtxRegister707) + uint32_t(r_PtxRegister4);		  // PTX L1625
	r_PtxRegister709 = uint32_t(r_PtxRegister708) + uint32_t(4);					  // PTX L1626
	r_PtxRegister69 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister704);		  // PTX L1627
	r_bPtxPredicate393 = int32_t(r_PtxRegister709) < int32_t(0);					  // PTX L1628
	r_bPtxPredicate394 = int32_t(r_PtxRegister709) >= int32_t(r_HeightBits);		  // PTX L1629
	r_bPtxPredicate395 = r_bPtxPredicate393 | r_bPtxPredicate394;					  // PTX L1630
	r_bPtxPredicate396 = !r_bPtxPredicate395;										  // PTX L1631
	r_PtxRegister70 = r_bPtxPredicate392 ? 0 : r_PtxRegister709;					  // PTX L1632
	r_bPtxPredicate397 = r_bPtxPredicate391 & r_bPtxPredicate395;					  // PTX L1633
	r_bPtxPredicate398 = r_bPtxPredicate392 | r_bPtxPredicate396;					  // PTX L1634
	r_bPtxPredicate399 = r_bPtxPredicate397 | r_bPtxPredicate390;					  // PTX L1635
	r_bPtxPredicate400 = int32_t(r_PtxRegister69) > int32_t(-1);					  // PTX L1636
	r_bPtxPredicate401 = int32_t(r_PtxRegister69) < int32_t(r_WidthBits);			  // PTX L1637
	r_bPtxPredicate402 = r_bPtxPredicate400 & r_bPtxPredicate401;					  // PTX L1638
	r_bPtxPredicate403 = !r_bPtxPredicate397;										  // PTX L1639
	r_bPtxPredicate23 = r_bPtxPredicate390 & r_bPtxPredicate403;					  // PTX L1640
	r_bPtxPredicate404 = r_bPtxPredicate399 | r_bPtxPredicate402;					  // PTX L1641
	r_bPtxPredicate405 = r_bPtxPredicate404 & r_bPtxPredicate398;					  // PTX L1642
	r_PtxRegister2064 = uint32_t(0);												  // PTX L1643
	r_bPtxPredicate406 = !r_bPtxPredicate405;										  // PTX L1644
	if (r_bPtxPredicate406)
	{
		goto L__BB19_112;
	} // PTX L1645
	r_PtxRegister710 = r_PtxRegister699 & -4;										// PTX L1646
	r_PtxRegister711 = uint32_t(r_LaneIndexAtPtx1612) - uint32_t(r_PtxRegister710); // PTX L1647
	r_PtxRegister712 = ShiftLeft(uint32_t(r_PtxRegister69), uint32_t(2));			// PTX L1648
	r_PtxRegister713 = r_bPtxPredicate23 ? 0 : r_PtxRegister712;					// PTX L1649
	r_PtxRegister714 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister70); // PTX L1650
	r_PtxRegister715 =
		uint32_t(r_PtxRegister714) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister711); // PTX L1651
	r_PtxRegister716 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister713);				 // PTX L1652
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister716)) * int64_t(int32_t(4))); // PTX L1653
	g_ResidualByteAddressAtPtx1654 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register86);				// PTX L1654
	r_PtxRegister2064 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1654); // PTX L1655
L__BB19_112:																				// PTX L1656
	r_bPtxPredicate407 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1657
	r_PtxU16Register53 = uint16_t(r_PtxRegister2064);
	r_PtxU16Register54 = uint16_t(r_PtxRegister2064 >> 16);							  // PTX L1658
	r_bPtxPredicate408 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1659
	r_bPtxPredicate409 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1660
	r_LaneIndexAtPtx1662 = uint32_t((threadIdx.x & 31u));							  // PTX L1662
	r_PtxRegister718 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1662), uint32_t(31)); // PTX L1664
	r_PtxRegister719 = ShiftRight(uint32_t(r_PtxRegister718), uint32_t(30));		  // PTX L1665
	r_PtxRegister720 = uint32_t(r_LaneIndexAtPtx1662) + uint32_t(r_PtxRegister719);	  // PTX L1666
	r_PtxRegister721 = ShiftRightSigned(int32_t(r_PtxRegister720), uint32_t(2));	  // PTX L1667
	r_PtxRegister722 = ShiftRight(uint32_t(r_PtxRegister721), uint32_t(30));		  // PTX L1668
	r_PtxRegister723 = uint32_t(r_PtxRegister721) + uint32_t(r_PtxRegister722);		  // PTX L1669
	r_PtxRegister724 = r_PtxRegister723 & -4;										  // PTX L1670
	r_PtxRegister725 = uint32_t(r_PtxRegister721) - uint32_t(r_PtxRegister724);		  // PTX L1671
	r_PtxRegister726 = ShiftRight(uint32_t(r_PtxRegister718), uint32_t(28));		  // PTX L1672
	r_PtxRegister727 = uint32_t(r_LaneIndexAtPtx1662) + uint32_t(r_PtxRegister726);	  // PTX L1673
	r_PtxRegister728 = ShiftRightSigned(int32_t(r_PtxRegister727), uint32_t(4));	  // PTX L1674
	r_PtxRegister729 = uint32_t(r_PtxRegister728) + uint32_t(r_PtxRegister4);		  // PTX L1675
	r_PtxRegister730 = uint32_t(r_PtxRegister729) + uint32_t(6);					  // PTX L1676
	r_PtxRegister71 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister725);		  // PTX L1677
	r_bPtxPredicate410 = int32_t(r_PtxRegister730) < int32_t(0);					  // PTX L1678
	r_bPtxPredicate411 = int32_t(r_PtxRegister730) >= int32_t(r_HeightBits);		  // PTX L1679
	r_bPtxPredicate412 = r_bPtxPredicate410 | r_bPtxPredicate411;					  // PTX L1680
	r_bPtxPredicate413 = !r_bPtxPredicate412;										  // PTX L1681
	r_PtxRegister72 = r_bPtxPredicate409 ? 0 : r_PtxRegister730;					  // PTX L1682
	r_bPtxPredicate414 = r_bPtxPredicate408 & r_bPtxPredicate412;					  // PTX L1683
	r_bPtxPredicate415 = r_bPtxPredicate409 | r_bPtxPredicate413;					  // PTX L1684
	r_bPtxPredicate416 = r_bPtxPredicate414 | r_bPtxPredicate407;					  // PTX L1685
	r_bPtxPredicate417 = int32_t(r_PtxRegister71) > int32_t(-1);					  // PTX L1686
	r_bPtxPredicate418 = int32_t(r_PtxRegister71) < int32_t(r_WidthBits);			  // PTX L1687
	r_bPtxPredicate419 = r_bPtxPredicate417 & r_bPtxPredicate418;					  // PTX L1688
	r_bPtxPredicate420 = !r_bPtxPredicate414;										  // PTX L1689
	r_bPtxPredicate24 = r_bPtxPredicate407 & r_bPtxPredicate420;					  // PTX L1690
	r_bPtxPredicate421 = r_bPtxPredicate416 | r_bPtxPredicate419;					  // PTX L1691
	r_bPtxPredicate422 = r_bPtxPredicate421 & r_bPtxPredicate415;					  // PTX L1692
	r_PtxRegister2065 = uint32_t(0);												  // PTX L1693
	r_bPtxPredicate423 = !r_bPtxPredicate422;										  // PTX L1694
	if (r_bPtxPredicate423)
	{
		goto L__BB19_114;
	} // PTX L1695
	r_PtxRegister731 = r_PtxRegister720 & -4;										// PTX L1696
	r_PtxRegister732 = uint32_t(r_LaneIndexAtPtx1662) - uint32_t(r_PtxRegister731); // PTX L1697
	r_PtxRegister733 = ShiftLeft(uint32_t(r_PtxRegister71), uint32_t(2));			// PTX L1698
	r_PtxRegister734 = r_bPtxPredicate24 ? 0 : r_PtxRegister733;					// PTX L1699
	r_PtxRegister735 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister72); // PTX L1700
	r_PtxRegister736 =
		uint32_t(r_PtxRegister735) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister732); // PTX L1701
	r_PtxRegister737 = uint32_t(r_PtxRegister736) + uint32_t(r_PtxRegister734);				 // PTX L1702
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_PtxRegister737)) * int64_t(int32_t(4))); // PTX L1703
	g_ResidualByteAddressAtPtx1704 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register88);				// PTX L1704
	r_PtxRegister2065 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1704); // PTX L1705
L__BB19_114:																				// PTX L1706
	r_bPtxPredicate424 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1707
	r_PtxU16Register55 = uint16_t(r_PtxRegister2065);
	r_PtxU16Register56 = uint16_t(r_PtxRegister2065 >> 16);							  // PTX L1708
	r_bPtxPredicate425 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1709
	r_bPtxPredicate426 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1710
	r_LaneIndexAtPtx1712 = uint32_t((threadIdx.x & 31u));							  // PTX L1712
	r_PtxRegister739 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1712), uint32_t(31)); // PTX L1714
	r_PtxRegister740 = ShiftRight(uint32_t(r_PtxRegister739), uint32_t(30));		  // PTX L1715
	r_PtxRegister741 = uint32_t(r_LaneIndexAtPtx1712) + uint32_t(r_PtxRegister740);	  // PTX L1716
	r_PtxRegister742 = ShiftRightSigned(int32_t(r_PtxRegister741), uint32_t(2));	  // PTX L1717
	r_PtxRegister743 = ShiftRight(uint32_t(r_PtxRegister742), uint32_t(30));		  // PTX L1718
	r_PtxRegister744 = uint32_t(r_PtxRegister742) + uint32_t(r_PtxRegister743);		  // PTX L1719
	r_PtxRegister745 = r_PtxRegister744 & -4;										  // PTX L1720
	r_PtxRegister746 = uint32_t(r_PtxRegister742) - uint32_t(r_PtxRegister745);		  // PTX L1721
	r_PtxRegister747 = ShiftRight(uint32_t(r_PtxRegister739), uint32_t(28));		  // PTX L1722
	r_PtxRegister748 = uint32_t(r_LaneIndexAtPtx1712) + uint32_t(r_PtxRegister747);	  // PTX L1723
	r_PtxRegister749 = ShiftRightSigned(int32_t(r_PtxRegister748), uint32_t(4));	  // PTX L1724
	r_PtxRegister750 = uint32_t(r_PtxRegister749) + uint32_t(r_PtxRegister4);		  // PTX L1725
	r_PtxRegister751 = uint32_t(r_PtxRegister750) + uint32_t(4);					  // PTX L1726
	r_PtxRegister73 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister746);		  // PTX L1727
	r_bPtxPredicate427 = int32_t(r_PtxRegister751) < int32_t(0);					  // PTX L1728
	r_bPtxPredicate428 = int32_t(r_PtxRegister751) >= int32_t(r_HeightBits);		  // PTX L1729
	r_bPtxPredicate429 = r_bPtxPredicate427 | r_bPtxPredicate428;					  // PTX L1730
	r_bPtxPredicate430 = !r_bPtxPredicate429;										  // PTX L1731
	r_PtxRegister74 = r_bPtxPredicate426 ? 0 : r_PtxRegister751;					  // PTX L1732
	r_bPtxPredicate431 = r_bPtxPredicate425 & r_bPtxPredicate429;					  // PTX L1733
	r_bPtxPredicate432 = r_bPtxPredicate426 | r_bPtxPredicate430;					  // PTX L1734
	r_bPtxPredicate433 = r_bPtxPredicate431 | r_bPtxPredicate424;					  // PTX L1735
	r_bPtxPredicate434 = int32_t(r_PtxRegister73) > int32_t(-1);					  // PTX L1736
	r_bPtxPredicate435 = int32_t(r_PtxRegister73) < int32_t(r_WidthBits);			  // PTX L1737
	r_bPtxPredicate436 = r_bPtxPredicate434 & r_bPtxPredicate435;					  // PTX L1738
	r_bPtxPredicate437 = !r_bPtxPredicate431;										  // PTX L1739
	r_bPtxPredicate25 = r_bPtxPredicate424 & r_bPtxPredicate437;					  // PTX L1740
	r_bPtxPredicate438 = r_bPtxPredicate433 | r_bPtxPredicate436;					  // PTX L1741
	r_bPtxPredicate439 = r_bPtxPredicate438 & r_bPtxPredicate432;					  // PTX L1742
	r_PtxRegister2066 = uint32_t(0);												  // PTX L1743
	r_bPtxPredicate440 = !r_bPtxPredicate439;										  // PTX L1744
	if (r_bPtxPredicate440)
	{
		goto L__BB19_116;
	} // PTX L1745
	r_PtxRegister752 = r_PtxRegister741 & -4;										// PTX L1746
	r_PtxRegister753 = uint32_t(r_LaneIndexAtPtx1712) - uint32_t(r_PtxRegister752); // PTX L1747
	r_PtxRegister754 = ShiftLeft(uint32_t(r_PtxRegister73), uint32_t(2));			// PTX L1748
	r_PtxRegister755 = r_bPtxPredicate25 ? 0 : r_PtxRegister754;					// PTX L1749
	r_PtxRegister756 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister74); // PTX L1750
	r_PtxRegister757 =
		uint32_t(r_PtxRegister756) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister753); // PTX L1751
	r_PtxRegister758 = uint32_t(r_PtxRegister757) + uint32_t(r_PtxRegister755);				 // PTX L1752
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister758)) * int64_t(int32_t(4))); // PTX L1753
	g_ResidualByteAddressAtPtx1754 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register90);				// PTX L1754
	r_PtxRegister2066 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1754); // PTX L1755
L__BB19_116:																				// PTX L1756
	r_bPtxPredicate441 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1757
	r_PtxU16Register57 = uint16_t(r_PtxRegister2066);
	r_PtxU16Register58 = uint16_t(r_PtxRegister2066 >> 16);							  // PTX L1758
	r_bPtxPredicate442 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1759
	r_bPtxPredicate443 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1760
	r_LaneIndexAtPtx1762 = uint32_t((threadIdx.x & 31u));							  // PTX L1762
	r_PtxRegister760 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1762), uint32_t(31)); // PTX L1764
	r_PtxRegister761 = ShiftRight(uint32_t(r_PtxRegister760), uint32_t(30));		  // PTX L1765
	r_PtxRegister762 = uint32_t(r_LaneIndexAtPtx1762) + uint32_t(r_PtxRegister761);	  // PTX L1766
	r_PtxRegister763 = ShiftRightSigned(int32_t(r_PtxRegister762), uint32_t(2));	  // PTX L1767
	r_PtxRegister764 = ShiftRight(uint32_t(r_PtxRegister763), uint32_t(30));		  // PTX L1768
	r_PtxRegister765 = uint32_t(r_PtxRegister763) + uint32_t(r_PtxRegister764);		  // PTX L1769
	r_PtxRegister766 = r_PtxRegister765 & -4;										  // PTX L1770
	r_PtxRegister767 = uint32_t(r_PtxRegister763) - uint32_t(r_PtxRegister766);		  // PTX L1771
	r_PtxRegister768 = ShiftRight(uint32_t(r_PtxRegister760), uint32_t(28));		  // PTX L1772
	r_PtxRegister769 = uint32_t(r_LaneIndexAtPtx1762) + uint32_t(r_PtxRegister768);	  // PTX L1773
	r_PtxRegister770 = ShiftRightSigned(int32_t(r_PtxRegister769), uint32_t(4));	  // PTX L1774
	r_PtxRegister771 = uint32_t(r_PtxRegister770) + uint32_t(r_PtxRegister4);		  // PTX L1775
	r_PtxRegister772 = uint32_t(r_PtxRegister771) + uint32_t(6);					  // PTX L1776
	r_PtxRegister75 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister767);		  // PTX L1777
	r_bPtxPredicate444 = int32_t(r_PtxRegister772) < int32_t(0);					  // PTX L1778
	r_bPtxPredicate445 = int32_t(r_PtxRegister772) >= int32_t(r_HeightBits);		  // PTX L1779
	r_bPtxPredicate446 = r_bPtxPredicate444 | r_bPtxPredicate445;					  // PTX L1780
	r_bPtxPredicate447 = !r_bPtxPredicate446;										  // PTX L1781
	r_PtxRegister76 = r_bPtxPredicate443 ? 0 : r_PtxRegister772;					  // PTX L1782
	r_bPtxPredicate448 = r_bPtxPredicate442 & r_bPtxPredicate446;					  // PTX L1783
	r_bPtxPredicate449 = r_bPtxPredicate443 | r_bPtxPredicate447;					  // PTX L1784
	r_bPtxPredicate450 = r_bPtxPredicate448 | r_bPtxPredicate441;					  // PTX L1785
	r_bPtxPredicate451 = int32_t(r_PtxRegister75) > int32_t(-1);					  // PTX L1786
	r_bPtxPredicate452 = int32_t(r_PtxRegister75) < int32_t(r_WidthBits);			  // PTX L1787
	r_bPtxPredicate453 = r_bPtxPredicate451 & r_bPtxPredicate452;					  // PTX L1788
	r_bPtxPredicate454 = !r_bPtxPredicate448;										  // PTX L1789
	r_bPtxPredicate26 = r_bPtxPredicate441 & r_bPtxPredicate454;					  // PTX L1790
	r_bPtxPredicate455 = r_bPtxPredicate450 | r_bPtxPredicate453;					  // PTX L1791
	r_bPtxPredicate456 = r_bPtxPredicate455 & r_bPtxPredicate449;					  // PTX L1792
	r_PtxRegister2067 = uint32_t(0);												  // PTX L1793
	r_bPtxPredicate457 = !r_bPtxPredicate456;										  // PTX L1794
	if (r_bPtxPredicate457)
	{
		goto L__BB19_118;
	} // PTX L1795
	r_PtxRegister773 = r_PtxRegister762 & -4;										// PTX L1796
	r_PtxRegister774 = uint32_t(r_LaneIndexAtPtx1762) - uint32_t(r_PtxRegister773); // PTX L1797
	r_PtxRegister775 = ShiftLeft(uint32_t(r_PtxRegister75), uint32_t(2));			// PTX L1798
	r_PtxRegister776 = r_bPtxPredicate26 ? 0 : r_PtxRegister775;					// PTX L1799
	r_PtxRegister777 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister76); // PTX L1800
	r_PtxRegister778 =
		uint32_t(r_PtxRegister777) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister774); // PTX L1801
	r_PtxRegister779 = uint32_t(r_PtxRegister778) + uint32_t(r_PtxRegister776);				 // PTX L1802
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister779)) * int64_t(int32_t(4))); // PTX L1803
	g_ResidualByteAddressAtPtx1804 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register92);				// PTX L1804
	r_PtxRegister2067 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1804); // PTX L1805
L__BB19_118:																				// PTX L1806
	r_PtxU16Register59 = uint16_t(r_PtxRegister2067);
	r_PtxU16Register60 = uint16_t(r_PtxRegister2067 >> 16);							  // PTX L1807
	r_bPtxPredicate458 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1808
	r_bPtxPredicate459 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1809
	r_LaneIndexAtPtx1811 = uint32_t((threadIdx.x & 31u));							  // PTX L1811
	r_PtxRegister781 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1811), uint32_t(31)); // PTX L1813
	r_PtxRegister782 = ShiftRight(uint32_t(r_PtxRegister781), uint32_t(30));		  // PTX L1814
	r_PtxRegister783 = uint32_t(r_LaneIndexAtPtx1811) + uint32_t(r_PtxRegister782);	  // PTX L1815
	r_PtxRegister784 = ShiftRightSigned(int32_t(r_PtxRegister783), uint32_t(2));	  // PTX L1816
	r_PtxRegister785 = ShiftRight(uint32_t(r_PtxRegister784), uint32_t(30));		  // PTX L1817
	r_PtxRegister786 = uint32_t(r_PtxRegister784) + uint32_t(r_PtxRegister785);		  // PTX L1818
	r_PtxRegister787 = r_PtxRegister786 & -4;										  // PTX L1819
	r_PtxRegister788 = uint32_t(r_PtxRegister784) - uint32_t(r_PtxRegister787);		  // PTX L1820
	r_PtxRegister789 = ShiftRight(uint32_t(r_PtxRegister781), uint32_t(28));		  // PTX L1821
	r_PtxRegister790 = uint32_t(r_LaneIndexAtPtx1811) + uint32_t(r_PtxRegister789);	  // PTX L1822
	r_PtxRegister791 = ShiftRightSigned(int32_t(r_PtxRegister790), uint32_t(4));	  // PTX L1823
	r_PtxRegister792 = uint32_t(r_PtxRegister791) + uint32_t(r_PtxRegister4);		  // PTX L1824
	r_PtxRegister793 = uint32_t(r_PtxRegister788) + uint32_t(r_PtxRegister5);		  // PTX L1825
	r_PtxRegister794 = uint32_t(r_PtxRegister792) + uint32_t(4);					  // PTX L1826
	r_PtxRegister77 = uint32_t(r_PtxRegister793) + uint32_t(4);						  // PTX L1827
	r_bPtxPredicate460 = int32_t(r_PtxRegister794) < int32_t(0);					  // PTX L1828
	r_bPtxPredicate461 = int32_t(r_PtxRegister794) >= int32_t(r_HeightBits);		  // PTX L1829
	r_bPtxPredicate462 = r_bPtxPredicate460 | r_bPtxPredicate461;					  // PTX L1830
	r_bPtxPredicate463 = !r_bPtxPredicate462;										  // PTX L1831
	r_PtxRegister78 = r_bPtxPredicate459 ? 0 : r_PtxRegister794;					  // PTX L1832
	r_bPtxPredicate464 = r_bPtxPredicate458 & r_bPtxPredicate462;					  // PTX L1833
	r_bPtxPredicate465 = r_bPtxPredicate459 | r_bPtxPredicate463;					  // PTX L1834
	r_bPtxPredicate466 = r_bPtxPredicate464 | r_bPtxPredicate441;					  // PTX L1835
	r_bPtxPredicate467 = int32_t(r_PtxRegister77) < int32_t(r_WidthBits);			  // PTX L1836
	r_bPtxPredicate468 = !r_bPtxPredicate464;										  // PTX L1837
	r_bPtxPredicate27 = r_bPtxPredicate441 & r_bPtxPredicate468;					  // PTX L1838
	r_bPtxPredicate469 = r_bPtxPredicate466 | r_bPtxPredicate467;					  // PTX L1839
	r_bPtxPredicate470 = r_bPtxPredicate469 & r_bPtxPredicate465;					  // PTX L1840
	r_PtxRegister2068 = uint32_t(0);												  // PTX L1841
	r_bPtxPredicate471 = !r_bPtxPredicate470;										  // PTX L1842
	if (r_bPtxPredicate471)
	{
		goto L__BB19_120;
	} // PTX L1843
	r_PtxRegister795 = r_PtxRegister783 & -4;										// PTX L1844
	r_PtxRegister796 = uint32_t(r_LaneIndexAtPtx1811) - uint32_t(r_PtxRegister795); // PTX L1845
	r_PtxRegister797 = ShiftLeft(uint32_t(r_PtxRegister77), uint32_t(2));			// PTX L1846
	r_PtxRegister798 = r_bPtxPredicate27 ? 0 : r_PtxRegister797;					// PTX L1847
	r_PtxRegister799 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister78); // PTX L1848
	r_PtxRegister800 =
		uint32_t(r_PtxRegister799) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister796); // PTX L1849
	r_PtxRegister801 = uint32_t(r_PtxRegister800) + uint32_t(r_PtxRegister798);				 // PTX L1850
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister801)) * int64_t(int32_t(4))); // PTX L1851
	g_ResidualByteAddressAtPtx1852 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register94);				// PTX L1852
	r_PtxRegister2068 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1852); // PTX L1853
L__BB19_120:																				// PTX L1854
	r_bPtxPredicate472 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1855
	r_PtxU16Register61 = uint16_t(r_PtxRegister2068);
	r_PtxU16Register62 = uint16_t(r_PtxRegister2068 >> 16);							  // PTX L1856
	r_bPtxPredicate473 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1857
	r_LaneIndexAtPtx1859 = uint32_t((threadIdx.x & 31u));							  // PTX L1859
	r_PtxRegister803 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1859), uint32_t(31)); // PTX L1861
	r_PtxRegister804 = ShiftRight(uint32_t(r_PtxRegister803), uint32_t(30));		  // PTX L1862
	r_PtxRegister805 = uint32_t(r_LaneIndexAtPtx1859) + uint32_t(r_PtxRegister804);	  // PTX L1863
	r_PtxRegister806 = ShiftRightSigned(int32_t(r_PtxRegister805), uint32_t(2));	  // PTX L1864
	r_PtxRegister807 = ShiftRight(uint32_t(r_PtxRegister806), uint32_t(30));		  // PTX L1865
	r_PtxRegister808 = uint32_t(r_PtxRegister806) + uint32_t(r_PtxRegister807);		  // PTX L1866
	r_PtxRegister809 = r_PtxRegister808 & -4;										  // PTX L1867
	r_PtxRegister810 = uint32_t(r_PtxRegister806) - uint32_t(r_PtxRegister809);		  // PTX L1868
	r_PtxRegister811 = ShiftRight(uint32_t(r_PtxRegister803), uint32_t(28));		  // PTX L1869
	r_PtxRegister812 = uint32_t(r_LaneIndexAtPtx1859) + uint32_t(r_PtxRegister811);	  // PTX L1870
	r_PtxRegister813 = ShiftRightSigned(int32_t(r_PtxRegister812), uint32_t(4));	  // PTX L1871
	r_PtxRegister814 = uint32_t(r_PtxRegister813) + uint32_t(r_PtxRegister4);		  // PTX L1872
	r_PtxRegister815 = uint32_t(r_PtxRegister810) + uint32_t(r_PtxRegister5);		  // PTX L1873
	r_PtxRegister816 = uint32_t(r_PtxRegister814) + uint32_t(6);					  // PTX L1874
	r_PtxRegister79 = uint32_t(r_PtxRegister815) + uint32_t(4);						  // PTX L1875
	r_bPtxPredicate474 = int32_t(r_PtxRegister816) < int32_t(0);					  // PTX L1876
	r_bPtxPredicate475 = int32_t(r_PtxRegister816) >= int32_t(r_HeightBits);		  // PTX L1877
	r_bPtxPredicate476 = r_bPtxPredicate474 | r_bPtxPredicate475;					  // PTX L1878
	r_bPtxPredicate477 = !r_bPtxPredicate476;										  // PTX L1879
	r_PtxRegister80 = r_bPtxPredicate473 ? 0 : r_PtxRegister816;					  // PTX L1880
	r_bPtxPredicate478 = r_bPtxPredicate458 & r_bPtxPredicate476;					  // PTX L1881
	r_bPtxPredicate479 = r_bPtxPredicate473 | r_bPtxPredicate477;					  // PTX L1882
	r_bPtxPredicate480 = r_bPtxPredicate478 | r_bPtxPredicate472;					  // PTX L1883
	r_bPtxPredicate481 = int32_t(r_PtxRegister79) < int32_t(r_WidthBits);			  // PTX L1884
	r_bPtxPredicate482 = !r_bPtxPredicate478;										  // PTX L1885
	r_bPtxPredicate28 = r_bPtxPredicate472 & r_bPtxPredicate482;					  // PTX L1886
	r_bPtxPredicate483 = r_bPtxPredicate480 | r_bPtxPredicate481;					  // PTX L1887
	r_bPtxPredicate484 = r_bPtxPredicate483 & r_bPtxPredicate479;					  // PTX L1888
	r_PtxRegister2069 = uint32_t(0);												  // PTX L1889
	r_bPtxPredicate485 = !r_bPtxPredicate484;										  // PTX L1890
	if (r_bPtxPredicate485)
	{
		goto L__BB19_122;
	} // PTX L1891
	r_PtxRegister817 = r_PtxRegister805 & -4;										// PTX L1892
	r_PtxRegister818 = uint32_t(r_LaneIndexAtPtx1859) - uint32_t(r_PtxRegister817); // PTX L1893
	r_PtxRegister819 = ShiftLeft(uint32_t(r_PtxRegister79), uint32_t(2));			// PTX L1894
	r_PtxRegister820 = r_bPtxPredicate28 ? 0 : r_PtxRegister819;					// PTX L1895
	r_PtxRegister821 =
		uint32_t(r_PtxRegister25) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister80); // PTX L1896
	r_PtxRegister822 =
		uint32_t(r_PtxRegister821) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister818); // PTX L1897
	r_PtxRegister823 = uint32_t(r_PtxRegister822) + uint32_t(r_PtxRegister820);				 // PTX L1898
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_PtxRegister823)) * int64_t(int32_t(4))); // PTX L1899
	g_ResidualByteAddressAtPtx1900 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register96);				// PTX L1900
	r_PtxRegister2069 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1900); // PTX L1901
L__BB19_122:																				// PTX L1902
	r_PtxU16Register63 = uint16_t(r_PtxRegister2069);
	r_PtxU16Register64 = uint16_t(r_PtxRegister2069 >> 16);							  // PTX L1903
	r_bPtxPredicate486 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L1904
	r_bPtxPredicate487 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1905
	r_LaneIndexAtPtx1907 = uint32_t((threadIdx.x & 31u));							  // PTX L1907
	r_PtxRegister825 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1907), uint32_t(31)); // PTX L1909
	r_PtxRegister826 = ShiftRight(uint32_t(r_PtxRegister825), uint32_t(30));		  // PTX L1910
	r_PtxRegister827 = uint32_t(r_LaneIndexAtPtx1907) + uint32_t(r_PtxRegister826);	  // PTX L1911
	r_PtxRegister828 = ShiftRightSigned(int32_t(r_PtxRegister827), uint32_t(2));	  // PTX L1912
	r_PtxRegister829 = ShiftRight(uint32_t(r_PtxRegister828), uint32_t(30));		  // PTX L1913
	r_PtxRegister830 = uint32_t(r_PtxRegister828) + uint32_t(r_PtxRegister829);		  // PTX L1914
	r_PtxRegister831 = r_PtxRegister830 & -4;										  // PTX L1915
	r_PtxRegister832 = uint32_t(r_PtxRegister828) - uint32_t(r_PtxRegister831);		  // PTX L1916
	r_PtxRegister833 = ShiftRight(uint32_t(r_PtxRegister825), uint32_t(28));		  // PTX L1917
	r_PtxRegister834 = uint32_t(r_LaneIndexAtPtx1907) + uint32_t(r_PtxRegister833);	  // PTX L1918
	r_PtxRegister835 = ShiftRightSigned(int32_t(r_PtxRegister834), uint32_t(4));	  // PTX L1919
	r_PtxRegister836 = uint32_t(r_PtxRegister835) + uint32_t(r_PtxRegister4);		  // PTX L1920
	r_PtxRegister837 = uint32_t(r_PtxRegister832) + uint32_t(r_PtxRegister5);		  // PTX L1921
	r_PtxRegister838 = uint32_t(r_PtxRegister836) + uint32_t(4);					  // PTX L1922
	r_PtxRegister81 = uint32_t(r_PtxRegister837) + uint32_t(4);						  // PTX L1923
	r_bPtxPredicate488 = int32_t(r_PtxRegister838) < int32_t(0);					  // PTX L1924
	r_bPtxPredicate489 = int32_t(r_PtxRegister838) >= int32_t(r_HeightBits);		  // PTX L1925
	r_bPtxPredicate490 = r_bPtxPredicate488 | r_bPtxPredicate489;					  // PTX L1926
	r_bPtxPredicate491 = !r_bPtxPredicate490;										  // PTX L1927
	r_PtxRegister82 = r_bPtxPredicate487 ? 0 : r_PtxRegister838;					  // PTX L1928
	r_bPtxPredicate492 = r_bPtxPredicate486 & r_bPtxPredicate490;					  // PTX L1929
	r_bPtxPredicate493 = r_bPtxPredicate487 | r_bPtxPredicate491;					  // PTX L1930
	r_bPtxPredicate494 = r_bPtxPredicate492 | r_bPtxPredicate472;					  // PTX L1931
	r_bPtxPredicate495 = int32_t(r_PtxRegister81) < int32_t(r_WidthBits);			  // PTX L1932
	r_bPtxPredicate496 = !r_bPtxPredicate492;										  // PTX L1933
	r_bPtxPredicate29 = r_bPtxPredicate472 & r_bPtxPredicate496;					  // PTX L1934
	r_bPtxPredicate497 = r_bPtxPredicate494 | r_bPtxPredicate495;					  // PTX L1935
	r_bPtxPredicate498 = r_bPtxPredicate497 & r_bPtxPredicate493;					  // PTX L1936
	r_PtxRegister2070 = uint32_t(0);												  // PTX L1937
	r_bPtxPredicate499 = !r_bPtxPredicate498;										  // PTX L1938
	if (r_bPtxPredicate499)
	{
		goto L__BB19_124;
	} // PTX L1939
	r_PtxRegister839 = r_PtxRegister827 & -4;										// PTX L1940
	r_PtxRegister840 = uint32_t(r_LaneIndexAtPtx1907) - uint32_t(r_PtxRegister839); // PTX L1941
	r_PtxRegister841 = ShiftLeft(uint32_t(r_PtxRegister81), uint32_t(2));			// PTX L1942
	r_PtxRegister842 = r_bPtxPredicate29 ? 0 : r_PtxRegister841;					// PTX L1943
	r_PtxRegister843 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister82); // PTX L1944
	r_PtxRegister844 =
		uint32_t(r_PtxRegister843) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister840); // PTX L1945
	r_PtxRegister845 = uint32_t(r_PtxRegister844) + uint32_t(r_PtxRegister842);				 // PTX L1946
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister845)) * int64_t(int32_t(4))); // PTX L1947
	g_ResidualByteAddressAtPtx1948 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register98);				// PTX L1948
	r_PtxRegister2070 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1948); // PTX L1949
L__BB19_124:																				// PTX L1950
	r_bPtxPredicate500 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1951
	r_PtxU16Register65 = uint16_t(r_PtxRegister2070);
	r_PtxU16Register66 = uint16_t(r_PtxRegister2070 >> 16);							  // PTX L1952
	r_bPtxPredicate501 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L1953
	r_LaneIndexAtPtx1955 = uint32_t((threadIdx.x & 31u));							  // PTX L1955
	r_PtxRegister847 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1955), uint32_t(31)); // PTX L1957
	r_PtxRegister848 = ShiftRight(uint32_t(r_PtxRegister847), uint32_t(30));		  // PTX L1958
	r_PtxRegister849 = uint32_t(r_LaneIndexAtPtx1955) + uint32_t(r_PtxRegister848);	  // PTX L1959
	r_PtxRegister850 = ShiftRightSigned(int32_t(r_PtxRegister849), uint32_t(2));	  // PTX L1960
	r_PtxRegister851 = ShiftRight(uint32_t(r_PtxRegister850), uint32_t(30));		  // PTX L1961
	r_PtxRegister852 = uint32_t(r_PtxRegister850) + uint32_t(r_PtxRegister851);		  // PTX L1962
	r_PtxRegister853 = r_PtxRegister852 & -4;										  // PTX L1963
	r_PtxRegister854 = uint32_t(r_PtxRegister850) - uint32_t(r_PtxRegister853);		  // PTX L1964
	r_PtxRegister855 = ShiftRight(uint32_t(r_PtxRegister847), uint32_t(28));		  // PTX L1965
	r_PtxRegister856 = uint32_t(r_LaneIndexAtPtx1955) + uint32_t(r_PtxRegister855);	  // PTX L1966
	r_PtxRegister857 = ShiftRightSigned(int32_t(r_PtxRegister856), uint32_t(4));	  // PTX L1967
	r_PtxRegister858 = uint32_t(r_PtxRegister857) + uint32_t(r_PtxRegister4);		  // PTX L1968
	r_PtxRegister859 = uint32_t(r_PtxRegister854) + uint32_t(r_PtxRegister5);		  // PTX L1969
	r_PtxRegister860 = uint32_t(r_PtxRegister858) + uint32_t(6);					  // PTX L1970
	r_PtxRegister83 = uint32_t(r_PtxRegister859) + uint32_t(4);						  // PTX L1971
	r_bPtxPredicate502 = int32_t(r_PtxRegister860) < int32_t(0);					  // PTX L1972
	r_bPtxPredicate503 = int32_t(r_PtxRegister860) >= int32_t(r_HeightBits);		  // PTX L1973
	r_bPtxPredicate504 = r_bPtxPredicate502 | r_bPtxPredicate503;					  // PTX L1974
	r_bPtxPredicate505 = !r_bPtxPredicate504;										  // PTX L1975
	r_PtxRegister84 = r_bPtxPredicate501 ? 0 : r_PtxRegister860;					  // PTX L1976
	r_bPtxPredicate506 = r_bPtxPredicate486 & r_bPtxPredicate504;					  // PTX L1977
	r_bPtxPredicate507 = r_bPtxPredicate501 | r_bPtxPredicate505;					  // PTX L1978
	r_bPtxPredicate508 = r_bPtxPredicate506 | r_bPtxPredicate500;					  // PTX L1979
	r_bPtxPredicate509 = int32_t(r_PtxRegister83) < int32_t(r_WidthBits);			  // PTX L1980
	r_bPtxPredicate510 = !r_bPtxPredicate506;										  // PTX L1981
	r_bPtxPredicate30 = r_bPtxPredicate500 & r_bPtxPredicate510;					  // PTX L1982
	r_bPtxPredicate511 = r_bPtxPredicate508 | r_bPtxPredicate509;					  // PTX L1983
	r_bPtxPredicate512 = r_bPtxPredicate511 & r_bPtxPredicate507;					  // PTX L1984
	r_PtxRegister2071 = uint32_t(0);												  // PTX L1985
	r_bPtxPredicate513 = !r_bPtxPredicate512;										  // PTX L1986
	if (r_bPtxPredicate513)
	{
		goto L__BB19_126;
	} // PTX L1987
	r_PtxRegister861 = r_PtxRegister849 & -4;										// PTX L1988
	r_PtxRegister862 = uint32_t(r_LaneIndexAtPtx1955) - uint32_t(r_PtxRegister861); // PTX L1989
	r_PtxRegister863 = ShiftLeft(uint32_t(r_PtxRegister83), uint32_t(2));			// PTX L1990
	r_PtxRegister864 = r_bPtxPredicate30 ? 0 : r_PtxRegister863;					// PTX L1991
	r_PtxRegister865 =
		uint32_t(r_PtxRegister30) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister84); // PTX L1992
	r_PtxRegister866 =
		uint32_t(r_PtxRegister865) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister862);  // PTX L1993
	r_PtxRegister867 = uint32_t(r_PtxRegister866) + uint32_t(r_PtxRegister864);				  // PTX L1994
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_PtxRegister867)) * int64_t(int32_t(4))); // PTX L1995
	g_ResidualByteAddressAtPtx1996 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register100);				// PTX L1996
	r_PtxRegister2071 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1996); // PTX L1997
L__BB19_126:																				// PTX L1998
	r_PtxU16Register67 = uint16_t(r_PtxRegister2071);
	r_PtxU16Register68 = uint16_t(r_PtxRegister2071 >> 16);							  // PTX L1999
	r_bPtxPredicate514 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L2000
	r_bPtxPredicate515 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L2001
	r_LaneIndexAtPtx2003 = uint32_t((threadIdx.x & 31u));							  // PTX L2003
	r_PtxRegister869 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2003), uint32_t(31)); // PTX L2005
	r_PtxRegister870 = ShiftRight(uint32_t(r_PtxRegister869), uint32_t(30));		  // PTX L2006
	r_PtxRegister871 = uint32_t(r_LaneIndexAtPtx2003) + uint32_t(r_PtxRegister870);	  // PTX L2007
	r_PtxRegister872 = ShiftRightSigned(int32_t(r_PtxRegister871), uint32_t(2));	  // PTX L2008
	r_PtxRegister873 = ShiftRight(uint32_t(r_PtxRegister872), uint32_t(30));		  // PTX L2009
	r_PtxRegister874 = uint32_t(r_PtxRegister872) + uint32_t(r_PtxRegister873);		  // PTX L2010
	r_PtxRegister875 = r_PtxRegister874 & -4;										  // PTX L2011
	r_PtxRegister876 = uint32_t(r_PtxRegister872) - uint32_t(r_PtxRegister875);		  // PTX L2012
	r_PtxRegister877 = ShiftRight(uint32_t(r_PtxRegister869), uint32_t(28));		  // PTX L2013
	r_PtxRegister878 = uint32_t(r_LaneIndexAtPtx2003) + uint32_t(r_PtxRegister877);	  // PTX L2014
	r_PtxRegister879 = ShiftRightSigned(int32_t(r_PtxRegister878), uint32_t(4));	  // PTX L2015
	r_PtxRegister880 = uint32_t(r_PtxRegister879) + uint32_t(r_PtxRegister4);		  // PTX L2016
	r_PtxRegister881 = uint32_t(r_PtxRegister876) + uint32_t(r_PtxRegister5);		  // PTX L2017
	r_PtxRegister882 = uint32_t(r_PtxRegister880) + uint32_t(4);					  // PTX L2018
	r_PtxRegister85 = uint32_t(r_PtxRegister881) + uint32_t(4);						  // PTX L2019
	r_bPtxPredicate516 = int32_t(r_PtxRegister882) < int32_t(0);					  // PTX L2020
	r_bPtxPredicate517 = int32_t(r_PtxRegister882) >= int32_t(r_HeightBits);		  // PTX L2021
	r_bPtxPredicate518 = r_bPtxPredicate516 | r_bPtxPredicate517;					  // PTX L2022
	r_bPtxPredicate519 = !r_bPtxPredicate518;										  // PTX L2023
	r_PtxRegister86 = r_bPtxPredicate515 ? 0 : r_PtxRegister882;					  // PTX L2024
	r_bPtxPredicate520 = r_bPtxPredicate514 & r_bPtxPredicate518;					  // PTX L2025
	r_bPtxPredicate521 = r_bPtxPredicate515 | r_bPtxPredicate519;					  // PTX L2026
	r_bPtxPredicate522 = r_bPtxPredicate520 | r_bPtxPredicate500;					  // PTX L2027
	r_bPtxPredicate523 = int32_t(r_PtxRegister85) < int32_t(r_WidthBits);			  // PTX L2028
	r_bPtxPredicate524 = !r_bPtxPredicate520;										  // PTX L2029
	r_bPtxPredicate31 = r_bPtxPredicate500 & r_bPtxPredicate524;					  // PTX L2030
	r_bPtxPredicate525 = r_bPtxPredicate522 | r_bPtxPredicate523;					  // PTX L2031
	r_bPtxPredicate526 = r_bPtxPredicate525 & r_bPtxPredicate521;					  // PTX L2032
	r_PtxRegister2072 = uint32_t(0);												  // PTX L2033
	r_bPtxPredicate527 = !r_bPtxPredicate526;										  // PTX L2034
	if (r_bPtxPredicate527)
	{
		goto L__BB19_128;
	} // PTX L2035
	r_PtxRegister883 = r_PtxRegister871 & -4;										// PTX L2036
	r_PtxRegister884 = uint32_t(r_LaneIndexAtPtx2003) - uint32_t(r_PtxRegister883); // PTX L2037
	r_PtxRegister885 = ShiftLeft(uint32_t(r_PtxRegister85), uint32_t(2));			// PTX L2038
	r_PtxRegister886 = r_bPtxPredicate31 ? 0 : r_PtxRegister885;					// PTX L2039
	r_PtxRegister887 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister86); // PTX L2040
	r_PtxRegister888 =
		uint32_t(r_PtxRegister887) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister884);  // PTX L2041
	r_PtxRegister889 = uint32_t(r_PtxRegister888) + uint32_t(r_PtxRegister886);				  // PTX L2042
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister889)) * int64_t(int32_t(4))); // PTX L2043
	g_ResidualByteAddressAtPtx2044 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register102);				// PTX L2044
	r_PtxRegister2072 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2044); // PTX L2045
L__BB19_128:																				// PTX L2046
	r_bPtxPredicate528 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2047
	r_PtxU16Register69 = uint16_t(r_PtxRegister2072);
	r_PtxU16Register70 = uint16_t(r_PtxRegister2072 >> 16);							  // PTX L2048
	r_bPtxPredicate529 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L2049
	r_LaneIndexAtPtx2051 = uint32_t((threadIdx.x & 31u));							  // PTX L2051
	r_PtxRegister891 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2051), uint32_t(31)); // PTX L2053
	r_PtxRegister892 = ShiftRight(uint32_t(r_PtxRegister891), uint32_t(30));		  // PTX L2054
	r_PtxRegister893 = uint32_t(r_LaneIndexAtPtx2051) + uint32_t(r_PtxRegister892);	  // PTX L2055
	r_PtxRegister894 = ShiftRightSigned(int32_t(r_PtxRegister893), uint32_t(2));	  // PTX L2056
	r_PtxRegister895 = ShiftRight(uint32_t(r_PtxRegister894), uint32_t(30));		  // PTX L2057
	r_PtxRegister896 = uint32_t(r_PtxRegister894) + uint32_t(r_PtxRegister895);		  // PTX L2058
	r_PtxRegister897 = r_PtxRegister896 & -4;										  // PTX L2059
	r_PtxRegister898 = uint32_t(r_PtxRegister894) - uint32_t(r_PtxRegister897);		  // PTX L2060
	r_PtxRegister899 = ShiftRight(uint32_t(r_PtxRegister891), uint32_t(28));		  // PTX L2061
	r_PtxRegister900 = uint32_t(r_LaneIndexAtPtx2051) + uint32_t(r_PtxRegister899);	  // PTX L2062
	r_PtxRegister901 = ShiftRightSigned(int32_t(r_PtxRegister900), uint32_t(4));	  // PTX L2063
	r_PtxRegister902 = uint32_t(r_PtxRegister901) + uint32_t(r_PtxRegister4);		  // PTX L2064
	r_PtxRegister903 = uint32_t(r_PtxRegister898) + uint32_t(r_PtxRegister5);		  // PTX L2065
	r_PtxRegister904 = uint32_t(r_PtxRegister902) + uint32_t(6);					  // PTX L2066
	r_PtxRegister87 = uint32_t(r_PtxRegister903) + uint32_t(4);						  // PTX L2067
	r_bPtxPredicate530 = int32_t(r_PtxRegister904) < int32_t(0);					  // PTX L2068
	r_bPtxPredicate531 = int32_t(r_PtxRegister904) >= int32_t(r_HeightBits);		  // PTX L2069
	r_bPtxPredicate532 = r_bPtxPredicate530 | r_bPtxPredicate531;					  // PTX L2070
	r_bPtxPredicate533 = !r_bPtxPredicate532;										  // PTX L2071
	r_PtxRegister88 = r_bPtxPredicate529 ? 0 : r_PtxRegister904;					  // PTX L2072
	r_bPtxPredicate534 = r_bPtxPredicate514 & r_bPtxPredicate532;					  // PTX L2073
	r_bPtxPredicate535 = r_bPtxPredicate529 | r_bPtxPredicate533;					  // PTX L2074
	r_bPtxPredicate536 = r_bPtxPredicate534 | r_bPtxPredicate528;					  // PTX L2075
	r_bPtxPredicate537 = int32_t(r_PtxRegister87) < int32_t(r_WidthBits);			  // PTX L2076
	r_bPtxPredicate538 = !r_bPtxPredicate534;										  // PTX L2077
	r_bPtxPredicate32 = r_bPtxPredicate528 & r_bPtxPredicate538;					  // PTX L2078
	r_bPtxPredicate539 = r_bPtxPredicate536 | r_bPtxPredicate537;					  // PTX L2079
	r_bPtxPredicate540 = r_bPtxPredicate539 & r_bPtxPredicate535;					  // PTX L2080
	r_PtxRegister2073 = uint32_t(0);												  // PTX L2081
	r_bPtxPredicate541 = !r_bPtxPredicate540;										  // PTX L2082
	if (r_bPtxPredicate541)
	{
		goto L__BB19_130;
	} // PTX L2083
	r_PtxRegister905 = r_PtxRegister893 & -4;										// PTX L2084
	r_PtxRegister906 = uint32_t(r_LaneIndexAtPtx2051) - uint32_t(r_PtxRegister905); // PTX L2085
	r_PtxRegister907 = ShiftLeft(uint32_t(r_PtxRegister87), uint32_t(2));			// PTX L2086
	r_PtxRegister908 = r_bPtxPredicate32 ? 0 : r_PtxRegister907;					// PTX L2087
	r_PtxRegister909 =
		uint32_t(r_PtxRegister35) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister88); // PTX L2088
	r_PtxRegister910 =
		uint32_t(r_PtxRegister909) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister906);  // PTX L2089
	r_PtxRegister911 = uint32_t(r_PtxRegister910) + uint32_t(r_PtxRegister908);				  // PTX L2090
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_PtxRegister911)) * int64_t(int32_t(4))); // PTX L2091
	g_ResidualByteAddressAtPtx2092 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register104);				// PTX L2092
	r_PtxRegister2073 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2092); // PTX L2093
L__BB19_130:																				// PTX L2094
	r_PtxU16Register71 = uint16_t(r_PtxRegister2073);
	r_PtxU16Register72 = uint16_t(r_PtxRegister2073 >> 16);							  // PTX L2095
	r_bPtxPredicate33 = uint32_t(r_HeightBits) != uint32_t(1);						  // PTX L2096
	r_bPtxPredicate542 = uint32_t(r_HeightBits) == uint32_t(1);						  // PTX L2097
	r_LaneIndexAtPtx2099 = uint32_t((threadIdx.x & 31u));							  // PTX L2099
	r_PtxRegister913 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2099), uint32_t(31)); // PTX L2101
	r_PtxRegister914 = ShiftRight(uint32_t(r_PtxRegister913), uint32_t(30));		  // PTX L2102
	r_PtxRegister915 = uint32_t(r_LaneIndexAtPtx2099) + uint32_t(r_PtxRegister914);	  // PTX L2103
	r_PtxRegister916 = ShiftRightSigned(int32_t(r_PtxRegister915), uint32_t(2));	  // PTX L2104
	r_PtxRegister917 = ShiftRight(uint32_t(r_PtxRegister916), uint32_t(30));		  // PTX L2105
	r_PtxRegister918 = uint32_t(r_PtxRegister916) + uint32_t(r_PtxRegister917);		  // PTX L2106
	r_PtxRegister919 = r_PtxRegister918 & -4;										  // PTX L2107
	r_PtxRegister920 = uint32_t(r_PtxRegister916) - uint32_t(r_PtxRegister919);		  // PTX L2108
	r_PtxRegister921 = ShiftRight(uint32_t(r_PtxRegister913), uint32_t(28));		  // PTX L2109
	r_PtxRegister922 = uint32_t(r_LaneIndexAtPtx2099) + uint32_t(r_PtxRegister921);	  // PTX L2110
	r_PtxRegister923 = ShiftRightSigned(int32_t(r_PtxRegister922), uint32_t(4));	  // PTX L2111
	r_PtxRegister924 = uint32_t(r_PtxRegister923) + uint32_t(r_PtxRegister4);		  // PTX L2112
	r_PtxRegister925 = uint32_t(r_PtxRegister920) + uint32_t(r_PtxRegister5);		  // PTX L2113
	r_PtxRegister926 = uint32_t(r_PtxRegister924) + uint32_t(4);					  // PTX L2114
	r_PtxRegister89 = uint32_t(r_PtxRegister925) + uint32_t(4);						  // PTX L2115
	r_bPtxPredicate543 = int32_t(r_PtxRegister926) < int32_t(0);					  // PTX L2116
	r_bPtxPredicate544 = int32_t(r_PtxRegister926) >= int32_t(r_HeightBits);		  // PTX L2117
	r_bPtxPredicate545 = r_bPtxPredicate543 | r_bPtxPredicate544;					  // PTX L2118
	r_bPtxPredicate546 = !r_bPtxPredicate545;										  // PTX L2119
	r_PtxRegister90 = r_bPtxPredicate542 ? 0 : r_PtxRegister926;					  // PTX L2120
	r_bPtxPredicate547 = r_bPtxPredicate33 & r_bPtxPredicate545;					  // PTX L2121
	r_bPtxPredicate548 = r_bPtxPredicate542 | r_bPtxPredicate546;					  // PTX L2122
	r_bPtxPredicate549 = r_bPtxPredicate547 | r_bPtxPredicate528;					  // PTX L2123
	r_bPtxPredicate550 = int32_t(r_PtxRegister89) < int32_t(r_WidthBits);			  // PTX L2124
	r_bPtxPredicate551 = !r_bPtxPredicate547;										  // PTX L2125
	r_bPtxPredicate34 = r_bPtxPredicate528 & r_bPtxPredicate551;					  // PTX L2126
	r_bPtxPredicate552 = r_bPtxPredicate549 | r_bPtxPredicate550;					  // PTX L2127
	r_bPtxPredicate553 = r_bPtxPredicate552 & r_bPtxPredicate548;					  // PTX L2128
	r_PtxRegister2074 = uint32_t(0);												  // PTX L2129
	r_bPtxPredicate554 = !r_bPtxPredicate553;										  // PTX L2130
	if (r_bPtxPredicate554)
	{
		goto L__BB19_132;
	} // PTX L2131
	r_PtxRegister927 = ShiftRight(uint32_t(r_PtxRegister913), uint32_t(30));		// PTX L2132
	r_PtxRegister928 = uint32_t(r_LaneIndexAtPtx2099) + uint32_t(r_PtxRegister927); // PTX L2133
	r_PtxRegister929 = r_PtxRegister928 & -4;										// PTX L2134
	r_PtxRegister930 = uint32_t(r_LaneIndexAtPtx2099) - uint32_t(r_PtxRegister929); // PTX L2135
	r_PtxRegister931 = ShiftLeft(uint32_t(r_PtxRegister89), uint32_t(2));			// PTX L2136
	r_PtxRegister932 = r_bPtxPredicate34 ? 0 : r_PtxRegister931;					// PTX L2137
	r_PtxRegister933 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister90); // PTX L2138
	r_PtxRegister934 =
		uint32_t(r_PtxRegister933) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister930);  // PTX L2139
	r_PtxRegister935 = uint32_t(r_PtxRegister934) + uint32_t(r_PtxRegister932);				  // PTX L2140
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister935)) * int64_t(int32_t(4))); // PTX L2141
	g_ResidualByteAddressAtPtx2142 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register106);				// PTX L2142
	r_PtxRegister2074 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2142); // PTX L2143
L__BB19_132:																				// PTX L2144
	r_bPtxPredicate555 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2145
	r_PtxU16Register73 = uint16_t(r_PtxRegister2074);
	r_PtxU16Register74 = uint16_t(r_PtxRegister2074 >> 16);							  // PTX L2146
	r_LaneIndexAtPtx2148 = uint32_t((threadIdx.x & 31u));							  // PTX L2148
	r_PtxRegister937 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2148), uint32_t(31)); // PTX L2150
	r_PtxRegister938 = ShiftRight(uint32_t(r_PtxRegister937), uint32_t(30));		  // PTX L2151
	r_PtxRegister939 = uint32_t(r_LaneIndexAtPtx2148) + uint32_t(r_PtxRegister938);	  // PTX L2152
	r_PtxRegister940 = ShiftRightSigned(int32_t(r_PtxRegister939), uint32_t(2));	  // PTX L2153
	r_PtxRegister941 = ShiftRight(uint32_t(r_PtxRegister940), uint32_t(30));		  // PTX L2154
	r_PtxRegister942 = uint32_t(r_PtxRegister940) + uint32_t(r_PtxRegister941);		  // PTX L2155
	r_PtxRegister943 = r_PtxRegister942 & -4;										  // PTX L2156
	r_PtxRegister944 = uint32_t(r_PtxRegister940) - uint32_t(r_PtxRegister943);		  // PTX L2157
	r_PtxRegister945 = ShiftRight(uint32_t(r_PtxRegister937), uint32_t(28));		  // PTX L2158
	r_PtxRegister946 = uint32_t(r_LaneIndexAtPtx2148) + uint32_t(r_PtxRegister945);	  // PTX L2159
	r_PtxRegister947 = ShiftRightSigned(int32_t(r_PtxRegister946), uint32_t(4));	  // PTX L2160
	r_PtxRegister948 = uint32_t(r_PtxRegister947) + uint32_t(r_PtxRegister4);		  // PTX L2161
	r_PtxRegister949 = uint32_t(r_PtxRegister944) + uint32_t(r_PtxRegister5);		  // PTX L2162
	r_PtxRegister950 = uint32_t(r_PtxRegister948) + uint32_t(6);					  // PTX L2163
	r_PtxRegister91 = uint32_t(r_PtxRegister949) + uint32_t(4);						  // PTX L2164
	r_bPtxPredicate556 = int32_t(r_PtxRegister950) < int32_t(0);					  // PTX L2165
	r_bPtxPredicate557 = int32_t(r_PtxRegister950) >= int32_t(r_HeightBits);		  // PTX L2166
	r_bPtxPredicate558 = r_bPtxPredicate556 | r_bPtxPredicate557;					  // PTX L2167
	r_bPtxPredicate559 = !r_bPtxPredicate558;										  // PTX L2168
	r_PtxRegister92 = r_bPtxPredicate542 ? 0 : r_PtxRegister950;					  // PTX L2169
	r_bPtxPredicate560 = r_bPtxPredicate33 & r_bPtxPredicate558;					  // PTX L2170
	r_bPtxPredicate561 = r_bPtxPredicate542 | r_bPtxPredicate559;					  // PTX L2171
	r_bPtxPredicate562 = r_bPtxPredicate560 | r_bPtxPredicate555;					  // PTX L2172
	r_bPtxPredicate563 = int32_t(r_PtxRegister91) < int32_t(r_WidthBits);			  // PTX L2173
	r_bPtxPredicate564 = !r_bPtxPredicate560;										  // PTX L2174
	r_bPtxPredicate35 = r_bPtxPredicate555 & r_bPtxPredicate564;					  // PTX L2175
	r_bPtxPredicate565 = r_bPtxPredicate562 | r_bPtxPredicate563;					  // PTX L2176
	r_bPtxPredicate566 = r_bPtxPredicate565 & r_bPtxPredicate561;					  // PTX L2177
	r_PtxRegister2075 = uint32_t(0);												  // PTX L2178
	r_bPtxPredicate567 = !r_bPtxPredicate566;										  // PTX L2179
	if (r_bPtxPredicate567)
	{
		goto L__BB19_134;
	} // PTX L2180
	r_PtxRegister951 = r_PtxRegister939 & -4;										// PTX L2181
	r_PtxRegister952 = uint32_t(r_LaneIndexAtPtx2148) - uint32_t(r_PtxRegister951); // PTX L2182
	r_PtxRegister953 = ShiftLeft(uint32_t(r_PtxRegister91), uint32_t(2));			// PTX L2183
	r_PtxRegister954 = r_bPtxPredicate35 ? 0 : r_PtxRegister953;					// PTX L2184
	r_PtxRegister955 =
		uint32_t(r_PtxRegister40) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister92); // PTX L2185
	r_PtxRegister956 =
		uint32_t(r_PtxRegister955) * uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister952);  // PTX L2186
	r_PtxRegister957 = uint32_t(r_PtxRegister956) + uint32_t(r_PtxRegister954);				  // PTX L2187
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_PtxRegister957)) * int64_t(int32_t(4))); // PTX L2188
	g_ResidualByteAddressAtPtx2189 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register108);				// PTX L2189
	r_PtxRegister2075 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2189); // PTX L2190
L__BB19_134:																				// PTX L2191
	r_PtxRegister1214 = uint32_t(r_PtxRegister10) + uint32_t(16);							// PTX L2192
	r_PackedHalf2AtPtx2194R1023 = DecodeE4(r_PtxU16Register13);								// PTX L2194
	r_PackedHalf2AtPtx2197R1029 = DecodeE4(r_PtxU16Register14);								// PTX L2197
	r_PackedHalf2AtPtx2200R1026 = DecodeE4(r_PtxU16Register15);								// PTX L2200
	r_PackedHalf2AtPtx2203R1032 = DecodeE4(r_PtxU16Register16);								// PTX L2203
	r_PackedHalf2AtPtx2206R1035 = DecodeE4(r_PtxU16Register17);								// PTX L2206
	r_PackedHalf2AtPtx2209R1041 = DecodeE4(r_PtxU16Register18);								// PTX L2209
	r_PackedHalf2AtPtx2212R1038 = DecodeE4(r_PtxU16Register19);								// PTX L2212
	r_PackedHalf2AtPtx2215R1044 = DecodeE4(r_PtxU16Register20);								// PTX L2215
	r_PackedHalf2AtPtx2218R1047 = DecodeE4(r_PtxU16Register21);								// PTX L2218
	r_PackedHalf2AtPtx2221R1053 = DecodeE4(r_PtxU16Register22);								// PTX L2221
	r_PackedHalf2AtPtx2224R1050 = DecodeE4(r_PtxU16Register23);								// PTX L2224
	r_PackedHalf2AtPtx2227R1056 = DecodeE4(r_PtxU16Register24);								// PTX L2227
	r_PackedHalf2AtPtx2230R1059 = DecodeE4(r_PtxU16Register25);								// PTX L2230
	r_PackedHalf2AtPtx2233R1065 = DecodeE4(r_PtxU16Register26);								// PTX L2233
	r_PackedHalf2AtPtx2236R1062 = DecodeE4(r_PtxU16Register27);								// PTX L2236
	r_PackedHalf2AtPtx2239R1068 = DecodeE4(r_PtxU16Register28);								// PTX L2239
	r_PackedHalf2AtPtx2242R1071 = DecodeE4(r_PtxU16Register29);								// PTX L2242
	r_PackedHalf2AtPtx2245R1077 = DecodeE4(r_PtxU16Register30);								// PTX L2245
	r_PackedHalf2AtPtx2248R1074 = DecodeE4(r_PtxU16Register31);								// PTX L2248
	r_PackedHalf2AtPtx2251R1080 = DecodeE4(r_PtxU16Register32);								// PTX L2251
	r_PackedHalf2AtPtx2254R1083 = DecodeE4(r_PtxU16Register33);								// PTX L2254
	r_PackedHalf2AtPtx2257R1089 = DecodeE4(r_PtxU16Register34);								// PTX L2257
	r_PackedHalf2AtPtx2260R1086 = DecodeE4(r_PtxU16Register35);								// PTX L2260
	r_PackedHalf2AtPtx2263R1092 = DecodeE4(r_PtxU16Register36);								// PTX L2263
	r_PackedHalf2AtPtx2266R1095 = DecodeE4(r_PtxU16Register37);								// PTX L2266
	r_PackedHalf2AtPtx2269R1101 = DecodeE4(r_PtxU16Register38);								// PTX L2269
	r_PackedHalf2AtPtx2272R1098 = DecodeE4(r_PtxU16Register39);								// PTX L2272
	r_PackedHalf2AtPtx2275R1104 = DecodeE4(r_PtxU16Register40);								// PTX L2275
	r_PackedHalf2AtPtx2278R1107 = DecodeE4(r_PtxU16Register41);								// PTX L2278
	r_PackedHalf2AtPtx2281R1113 = DecodeE4(r_PtxU16Register42);								// PTX L2281
	r_PackedHalf2AtPtx2284R1110 = DecodeE4(r_PtxU16Register43);								// PTX L2284
	r_PackedHalf2AtPtx2287R1116 = DecodeE4(r_PtxU16Register44);								// PTX L2287
	r_PackedHalf2AtPtx2290R1119 = DecodeE4(r_PtxU16Register45);								// PTX L2290
	r_PackedHalf2AtPtx2293R1125 = DecodeE4(r_PtxU16Register46);								// PTX L2293
	r_PackedHalf2AtPtx2296R1122 = DecodeE4(r_PtxU16Register47);								// PTX L2296
	r_PackedHalf2AtPtx2299R1128 = DecodeE4(r_PtxU16Register48);								// PTX L2299
	r_PackedHalf2AtPtx2302R1131 = DecodeE4(r_PtxU16Register49);								// PTX L2302
	r_PackedHalf2AtPtx2305R1137 = DecodeE4(r_PtxU16Register50);								// PTX L2305
	r_PackedHalf2AtPtx2308R1134 = DecodeE4(r_PtxU16Register51);								// PTX L2308
	r_PackedHalf2AtPtx2311R1140 = DecodeE4(r_PtxU16Register52);								// PTX L2311
	r_PackedHalf2AtPtx2314R1143 = DecodeE4(r_PtxU16Register53);								// PTX L2314
	r_PackedHalf2AtPtx2317R1149 = DecodeE4(r_PtxU16Register54);								// PTX L2317
	r_PackedHalf2AtPtx2320R1146 = DecodeE4(r_PtxU16Register55);								// PTX L2320
	r_PackedHalf2AtPtx2323R1152 = DecodeE4(r_PtxU16Register56);								// PTX L2323
	r_PackedHalf2AtPtx2326R1155 = DecodeE4(r_PtxU16Register57);								// PTX L2326
	r_PackedHalf2AtPtx2329R1161 = DecodeE4(r_PtxU16Register58);								// PTX L2329
	r_PackedHalf2AtPtx2332R1158 = DecodeE4(r_PtxU16Register59);								// PTX L2332
	r_PackedHalf2AtPtx2335R1164 = DecodeE4(r_PtxU16Register60);								// PTX L2335
	r_PackedHalf2AtPtx2338R1167 = DecodeE4(r_PtxU16Register61);								// PTX L2338
	r_PackedHalf2AtPtx2341R1173 = DecodeE4(r_PtxU16Register62);								// PTX L2341
	r_PackedHalf2AtPtx2344R1170 = DecodeE4(r_PtxU16Register63);								// PTX L2344
	r_PackedHalf2AtPtx2347R1176 = DecodeE4(r_PtxU16Register64);								// PTX L2347
	r_PackedHalf2AtPtx2350R1179 = DecodeE4(r_PtxU16Register65);								// PTX L2350
	r_PackedHalf2AtPtx2353R1185 = DecodeE4(r_PtxU16Register66);								// PTX L2353
	r_PackedHalf2AtPtx2356R1182 = DecodeE4(r_PtxU16Register67);								// PTX L2356
	r_PackedHalf2AtPtx2359R1188 = DecodeE4(r_PtxU16Register68);								// PTX L2359
	r_PackedHalf2AtPtx2362R1191 = DecodeE4(r_PtxU16Register69);								// PTX L2362
	r_PackedHalf2AtPtx2365R1197 = DecodeE4(r_PtxU16Register70);								// PTX L2365
	r_PackedHalf2AtPtx2368R1194 = DecodeE4(r_PtxU16Register71);								// PTX L2368
	r_PackedHalf2AtPtx2371R1200 = DecodeE4(r_PtxU16Register72);								// PTX L2371
	r_PackedHalf2AtPtx2374R1203 = DecodeE4(r_PtxU16Register73);								// PTX L2374
	r_PackedHalf2AtPtx2377R1209 = DecodeE4(r_PtxU16Register74);								// PTX L2377
	r_PtxU16Register75 = uint16_t(r_PtxRegister2075);
	r_PtxU16Register76 = uint16_t(r_PtxRegister2075 >> 16);									   // PTX L2379
	r_PackedHalf2AtPtx2381R1206 = DecodeE4(r_PtxU16Register75);								   // PTX L2381
	r_PackedHalf2AtPtx2384R1212 = DecodeE4(r_PtxU16Register76);								   // PTX L2384
	g_RecordByteAddressAtPtx2386 = g_RecordBaseAddress;										   // PTX L2386
	r_PtxRegister1215 = uint32_t(r_PtxRegister10) + uint32_t(8);							   // PTX L2387
	r_LaneIndexAtPtx2389 = uint32_t((threadIdx.x & 31u));									   // PTX L2389
	r_PtxRegister1216 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2389), uint32_t(31));		   // PTX L2391
	r_PtxRegister1217 = ShiftRight(uint32_t(r_PtxRegister1216), uint32_t(30));				   // PTX L2392
	r_PtxRegister1218 = uint32_t(r_LaneIndexAtPtx2389) + uint32_t(r_PtxRegister1217);		   // PTX L2393
	r_PtxRegister1219 = r_PtxRegister1218 & 2147483644;										   // PTX L2394
	r_PtxRegister1220 = uint32_t(r_LaneIndexAtPtx2389) - uint32_t(r_PtxRegister1219);		   // PTX L2395
	r_PtxRegister1221 = ShiftLeft(uint32_t(r_PtxRegister1220), uint32_t(1));				   // PTX L2396
	r_PtxRegister1222 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1221);			   // PTX L2397
	r_PtxRegister1223 = ShiftRightSigned(int32_t(r_PtxRegister1222), uint32_t(1));			   // PTX L2398
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister1223)) * int64_t(int32_t(4))); // PTX L2399
	g_RecordByteAddressAtPtx2400 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register111); // PTX L2400
	r_PtxRegister1024 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2400 + 262144ull);		   // PTX L2401
	r_LaneIndexAtPtx2403 = uint32_t((threadIdx.x & 31u));									   // PTX L2403
	r_PtxRegister1224 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2403), uint32_t(31));		   // PTX L2405
	r_PtxRegister1225 = ShiftRight(uint32_t(r_PtxRegister1224), uint32_t(30));				   // PTX L2406
	r_PtxRegister1226 = uint32_t(r_LaneIndexAtPtx2403) + uint32_t(r_PtxRegister1225);		   // PTX L2407
	r_PtxRegister1227 = r_PtxRegister1226 & 2147483644;										   // PTX L2408
	r_PtxRegister1228 = uint32_t(r_LaneIndexAtPtx2403) - uint32_t(r_PtxRegister1227);		   // PTX L2409
	r_PtxRegister1229 = ShiftLeft(uint32_t(r_PtxRegister1228), uint32_t(1));				   // PTX L2410
	r_PtxRegister1230 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1229);			   // PTX L2411
	r_PtxRegister1231 = ShiftRightSigned(int32_t(r_PtxRegister1230), uint32_t(1));			   // PTX L2412
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister1231)) * int64_t(int32_t(4))); // PTX L2413
	g_RecordByteAddressAtPtx2414 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register113); // PTX L2414
	r_PtxRegister1027 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2414 + 262144ull);		   // PTX L2415
	r_LaneIndexAtPtx2417 = uint32_t((threadIdx.x & 31u));									   // PTX L2417
	r_PtxRegister1232 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2417), uint32_t(31));		   // PTX L2419
	r_PtxRegister1233 = ShiftRight(uint32_t(r_PtxRegister1232), uint32_t(30));				   // PTX L2420
	r_PtxRegister1234 = uint32_t(r_LaneIndexAtPtx2417) + uint32_t(r_PtxRegister1233);		   // PTX L2421
	r_PtxRegister1235 = r_PtxRegister1234 & 2147483644;										   // PTX L2422
	r_PtxRegister1236 = uint32_t(r_LaneIndexAtPtx2417) - uint32_t(r_PtxRegister1235);		   // PTX L2423
	r_PtxRegister1237 = ShiftLeft(uint32_t(r_PtxRegister1236), uint32_t(1));				   // PTX L2424
	r_PtxRegister1238 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1237);			   // PTX L2425
	r_PtxRegister1239 = ShiftRightSigned(int32_t(r_PtxRegister1238), uint32_t(1));			   // PTX L2426
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister1239)) * int64_t(int32_t(4))); // PTX L2427
	g_RecordByteAddressAtPtx2428 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register115); // PTX L2428
	r_PtxRegister1030 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2428 + 262144ull);		   // PTX L2429
	r_LaneIndexAtPtx2431 = uint32_t((threadIdx.x & 31u));									   // PTX L2431
	r_PtxRegister1240 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2431), uint32_t(31));		   // PTX L2433
	r_PtxRegister1241 = ShiftRight(uint32_t(r_PtxRegister1240), uint32_t(30));				   // PTX L2434
	r_PtxRegister1242 = uint32_t(r_LaneIndexAtPtx2431) + uint32_t(r_PtxRegister1241);		   // PTX L2435
	r_PtxRegister1243 = r_PtxRegister1242 & 2147483644;										   // PTX L2436
	r_PtxRegister1244 = uint32_t(r_LaneIndexAtPtx2431) - uint32_t(r_PtxRegister1243);		   // PTX L2437
	r_PtxRegister1245 = ShiftLeft(uint32_t(r_PtxRegister1244), uint32_t(1));				   // PTX L2438
	r_PtxRegister1246 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1245);			   // PTX L2439
	r_PtxRegister1247 = ShiftRightSigned(int32_t(r_PtxRegister1246), uint32_t(1));			   // PTX L2440
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister1247)) * int64_t(int32_t(4))); // PTX L2441
	g_RecordByteAddressAtPtx2442 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register117); // PTX L2442
	r_PtxRegister1033 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2442 + 262144ull);		   // PTX L2443
	r_LaneIndexAtPtx2445 = uint32_t((threadIdx.x & 31u));									   // PTX L2445
	r_PtxRegister1248 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2445), uint32_t(31));		   // PTX L2447
	r_PtxRegister1249 = ShiftRight(uint32_t(r_PtxRegister1248), uint32_t(30));				   // PTX L2448
	r_PtxRegister1250 = uint32_t(r_LaneIndexAtPtx2445) + uint32_t(r_PtxRegister1249);		   // PTX L2449
	r_PtxRegister1251 = r_PtxRegister1250 & 2147483644;										   // PTX L2450
	r_PtxRegister1252 = uint32_t(r_LaneIndexAtPtx2445) - uint32_t(r_PtxRegister1251);		   // PTX L2451
	r_PtxRegister1253 = ShiftLeft(uint32_t(r_PtxRegister1252), uint32_t(1));				   // PTX L2452
	r_PtxRegister1254 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1253);			   // PTX L2453
	r_PtxRegister1255 = ShiftRightSigned(int32_t(r_PtxRegister1254), uint32_t(1));			   // PTX L2454
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister1255)) * int64_t(int32_t(4))); // PTX L2455
	g_RecordByteAddressAtPtx2456 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register119); // PTX L2456
	r_PtxRegister1036 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2456 + 262144ull);		   // PTX L2457
	r_LaneIndexAtPtx2459 = uint32_t((threadIdx.x & 31u));									   // PTX L2459
	r_PtxRegister1256 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2459), uint32_t(31));		   // PTX L2461
	r_PtxRegister1257 = ShiftRight(uint32_t(r_PtxRegister1256), uint32_t(30));				   // PTX L2462
	r_PtxRegister1258 = uint32_t(r_LaneIndexAtPtx2459) + uint32_t(r_PtxRegister1257);		   // PTX L2463
	r_PtxRegister1259 = r_PtxRegister1258 & 2147483644;										   // PTX L2464
	r_PtxRegister1260 = uint32_t(r_LaneIndexAtPtx2459) - uint32_t(r_PtxRegister1259);		   // PTX L2465
	r_PtxRegister1261 = ShiftLeft(uint32_t(r_PtxRegister1260), uint32_t(1));				   // PTX L2466
	r_PtxRegister1262 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1261);			   // PTX L2467
	r_PtxRegister1263 = ShiftRightSigned(int32_t(r_PtxRegister1262), uint32_t(1));			   // PTX L2468
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister1263)) * int64_t(int32_t(4))); // PTX L2469
	g_RecordByteAddressAtPtx2470 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register121); // PTX L2470
	r_PtxRegister1039 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2470 + 262144ull);		   // PTX L2471
	r_LaneIndexAtPtx2473 = uint32_t((threadIdx.x & 31u));									   // PTX L2473
	r_PtxRegister1264 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2473), uint32_t(31));		   // PTX L2475
	r_PtxRegister1265 = ShiftRight(uint32_t(r_PtxRegister1264), uint32_t(30));				   // PTX L2476
	r_PtxRegister1266 = uint32_t(r_LaneIndexAtPtx2473) + uint32_t(r_PtxRegister1265);		   // PTX L2477
	r_PtxRegister1267 = r_PtxRegister1266 & 2147483644;										   // PTX L2478
	r_PtxRegister1268 = uint32_t(r_LaneIndexAtPtx2473) - uint32_t(r_PtxRegister1267);		   // PTX L2479
	r_PtxRegister1269 = ShiftLeft(uint32_t(r_PtxRegister1268), uint32_t(1));				   // PTX L2480
	r_PtxRegister1270 = uint32_t(r_PtxRegister10) + uint32_t(24);							   // PTX L2481
	r_PtxRegister1271 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1269);			   // PTX L2482
	r_PtxRegister1272 = ShiftRight(uint32_t(r_PtxRegister1271), uint32_t(31));				   // PTX L2483
	r_PtxRegister1273 = uint32_t(r_PtxRegister1271) + uint32_t(r_PtxRegister1272);			   // PTX L2484
	r_PtxRegister1274 = ShiftRightSigned(int32_t(r_PtxRegister1273), uint32_t(1));			   // PTX L2485
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister1274)) * int64_t(int32_t(4))); // PTX L2486
	g_RecordByteAddressAtPtx2487 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register123); // PTX L2487
	r_PtxRegister1042 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2487 + 262144ull);		   // PTX L2488
	r_LaneIndexAtPtx2490 = uint32_t((threadIdx.x & 31u));									   // PTX L2490
	r_PtxRegister1275 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2490), uint32_t(31));		   // PTX L2492
	r_PtxRegister1276 = ShiftRight(uint32_t(r_PtxRegister1275), uint32_t(30));				   // PTX L2493
	r_PtxRegister1277 = uint32_t(r_LaneIndexAtPtx2490) + uint32_t(r_PtxRegister1276);		   // PTX L2494
	r_PtxRegister1278 = r_PtxRegister1277 & 2147483644;										   // PTX L2495
	r_PtxRegister1279 = uint32_t(r_LaneIndexAtPtx2490) - uint32_t(r_PtxRegister1278);		   // PTX L2496
	r_PtxRegister1280 = ShiftLeft(uint32_t(r_PtxRegister1279), uint32_t(1));				   // PTX L2497
	r_PtxRegister1281 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1280);			   // PTX L2498
	r_PtxRegister1282 = ShiftRight(uint32_t(r_PtxRegister1281), uint32_t(31));				   // PTX L2499
	r_PtxRegister1283 = uint32_t(r_PtxRegister1281) + uint32_t(r_PtxRegister1282);			   // PTX L2500
	r_PtxRegister1284 = ShiftRightSigned(int32_t(r_PtxRegister1283), uint32_t(1));			   // PTX L2501
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister1284)) * int64_t(int32_t(4))); // PTX L2502
	g_RecordByteAddressAtPtx2503 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register125); // PTX L2503
	r_PtxRegister1045 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2503 + 262144ull);		   // PTX L2504
	r_LaneIndexAtPtx2506 = uint32_t((threadIdx.x & 31u));									   // PTX L2506
	r_PtxRegister1285 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2506), uint32_t(31));		   // PTX L2508
	r_PtxRegister1286 = ShiftRight(uint32_t(r_PtxRegister1285), uint32_t(30));				   // PTX L2509
	r_PtxRegister1287 = uint32_t(r_LaneIndexAtPtx2506) + uint32_t(r_PtxRegister1286);		   // PTX L2510
	r_PtxRegister1288 = r_PtxRegister1287 & 2147483644;										   // PTX L2511
	r_PtxRegister1289 = uint32_t(r_LaneIndexAtPtx2506) - uint32_t(r_PtxRegister1288);		   // PTX L2512
	r_PtxRegister1290 = ShiftLeft(uint32_t(r_PtxRegister1289), uint32_t(1));				   // PTX L2513
	r_PtxRegister1291 = uint32_t(r_PtxRegister10) + uint32_t(32);							   // PTX L2514
	r_PtxRegister1292 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1290);			   // PTX L2515
	r_PtxRegister1293 = ShiftRightSigned(int32_t(r_PtxRegister1292), uint32_t(1));			   // PTX L2516
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister1293)) * int64_t(int32_t(4))); // PTX L2517
	g_RecordByteAddressAtPtx2518 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register127); // PTX L2518
	r_PtxRegister1048 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2518 + 262144ull);		   // PTX L2519
	r_LaneIndexAtPtx2521 = uint32_t((threadIdx.x & 31u));									   // PTX L2521
	r_PtxRegister1294 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2521), uint32_t(31));		   // PTX L2523
	r_PtxRegister1295 = ShiftRight(uint32_t(r_PtxRegister1294), uint32_t(30));				   // PTX L2524
	r_PtxRegister1296 = uint32_t(r_LaneIndexAtPtx2521) + uint32_t(r_PtxRegister1295);		   // PTX L2525
	r_PtxRegister1297 = r_PtxRegister1296 & 2147483644;										   // PTX L2526
	r_PtxRegister1298 = uint32_t(r_LaneIndexAtPtx2521) - uint32_t(r_PtxRegister1297);		   // PTX L2527
	r_PtxRegister1299 = ShiftLeft(uint32_t(r_PtxRegister1298), uint32_t(1));				   // PTX L2528
	r_PtxRegister1300 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1299);			   // PTX L2529
	r_PtxRegister1301 = ShiftRightSigned(int32_t(r_PtxRegister1300), uint32_t(1));			   // PTX L2530
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister1301)) * int64_t(int32_t(4))); // PTX L2531
	g_RecordByteAddressAtPtx2532 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register129); // PTX L2532
	r_PtxRegister1051 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2532 + 262144ull);		   // PTX L2533
	r_LaneIndexAtPtx2535 = uint32_t((threadIdx.x & 31u));									   // PTX L2535
	r_PtxRegister1302 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2535), uint32_t(31));		   // PTX L2537
	r_PtxRegister1303 = ShiftRight(uint32_t(r_PtxRegister1302), uint32_t(30));				   // PTX L2538
	r_PtxRegister1304 = uint32_t(r_LaneIndexAtPtx2535) + uint32_t(r_PtxRegister1303);		   // PTX L2539
	r_PtxRegister1305 = r_PtxRegister1304 & 2147483644;										   // PTX L2540
	r_PtxRegister1306 = uint32_t(r_LaneIndexAtPtx2535) - uint32_t(r_PtxRegister1305);		   // PTX L2541
	r_PtxRegister1307 = ShiftLeft(uint32_t(r_PtxRegister1306), uint32_t(1));				   // PTX L2542
	r_PtxRegister1308 = uint32_t(r_PtxRegister10) + uint32_t(40);							   // PTX L2543
	r_PtxRegister1309 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1307);			   // PTX L2544
	r_PtxRegister1310 = ShiftRight(uint32_t(r_PtxRegister1309), uint32_t(31));				   // PTX L2545
	r_PtxRegister1311 = uint32_t(r_PtxRegister1309) + uint32_t(r_PtxRegister1310);			   // PTX L2546
	r_PtxRegister1312 = ShiftRightSigned(int32_t(r_PtxRegister1311), uint32_t(1));			   // PTX L2547
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister1312)) * int64_t(int32_t(4))); // PTX L2548
	g_RecordByteAddressAtPtx2549 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register131); // PTX L2549
	r_PtxRegister1054 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2549 + 262144ull);		   // PTX L2550
	r_LaneIndexAtPtx2552 = uint32_t((threadIdx.x & 31u));									   // PTX L2552
	r_PtxRegister1313 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2552), uint32_t(31));		   // PTX L2554
	r_PtxRegister1314 = ShiftRight(uint32_t(r_PtxRegister1313), uint32_t(30));				   // PTX L2555
	r_PtxRegister1315 = uint32_t(r_LaneIndexAtPtx2552) + uint32_t(r_PtxRegister1314);		   // PTX L2556
	r_PtxRegister1316 = r_PtxRegister1315 & 2147483644;										   // PTX L2557
	r_PtxRegister1317 = uint32_t(r_LaneIndexAtPtx2552) - uint32_t(r_PtxRegister1316);		   // PTX L2558
	r_PtxRegister1318 = ShiftLeft(uint32_t(r_PtxRegister1317), uint32_t(1));				   // PTX L2559
	r_PtxRegister1319 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1318);			   // PTX L2560
	r_PtxRegister1320 = ShiftRight(uint32_t(r_PtxRegister1319), uint32_t(31));				   // PTX L2561
	r_PtxRegister1321 = uint32_t(r_PtxRegister1319) + uint32_t(r_PtxRegister1320);			   // PTX L2562
	r_PtxRegister1322 = ShiftRightSigned(int32_t(r_PtxRegister1321), uint32_t(1));			   // PTX L2563
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister1322)) * int64_t(int32_t(4))); // PTX L2564
	g_RecordByteAddressAtPtx2565 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register133); // PTX L2565
	r_PtxRegister1057 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2565 + 262144ull);		   // PTX L2566
	r_LaneIndexAtPtx2568 = uint32_t((threadIdx.x & 31u));									   // PTX L2568
	r_PtxRegister1323 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2568), uint32_t(31));		   // PTX L2570
	r_PtxRegister1324 = ShiftRight(uint32_t(r_PtxRegister1323), uint32_t(30));				   // PTX L2571
	r_PtxRegister1325 = uint32_t(r_LaneIndexAtPtx2568) + uint32_t(r_PtxRegister1324);		   // PTX L2572
	r_PtxRegister1326 = r_PtxRegister1325 & 2147483644;										   // PTX L2573
	r_PtxRegister1327 = uint32_t(r_LaneIndexAtPtx2568) - uint32_t(r_PtxRegister1326);		   // PTX L2574
	r_PtxRegister1328 = ShiftLeft(uint32_t(r_PtxRegister1327), uint32_t(1));				   // PTX L2575
	r_PtxRegister1329 = uint32_t(r_PtxRegister10) + uint32_t(48);							   // PTX L2576
	r_PtxRegister1330 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1328);			   // PTX L2577
	r_PtxRegister1331 = ShiftRightSigned(int32_t(r_PtxRegister1330), uint32_t(1));			   // PTX L2578
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister1331)) * int64_t(int32_t(4))); // PTX L2579
	g_RecordByteAddressAtPtx2580 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register135); // PTX L2580
	r_PtxRegister1060 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2580 + 262144ull);		   // PTX L2581
	r_LaneIndexAtPtx2583 = uint32_t((threadIdx.x & 31u));									   // PTX L2583
	r_PtxRegister1332 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2583), uint32_t(31));		   // PTX L2585
	r_PtxRegister1333 = ShiftRight(uint32_t(r_PtxRegister1332), uint32_t(30));				   // PTX L2586
	r_PtxRegister1334 = uint32_t(r_LaneIndexAtPtx2583) + uint32_t(r_PtxRegister1333);		   // PTX L2587
	r_PtxRegister1335 = r_PtxRegister1334 & 2147483644;										   // PTX L2588
	r_PtxRegister1336 = uint32_t(r_LaneIndexAtPtx2583) - uint32_t(r_PtxRegister1335);		   // PTX L2589
	r_PtxRegister1337 = ShiftLeft(uint32_t(r_PtxRegister1336), uint32_t(1));				   // PTX L2590
	r_PtxRegister1338 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1337);			   // PTX L2591
	r_PtxRegister1339 = ShiftRightSigned(int32_t(r_PtxRegister1338), uint32_t(1));			   // PTX L2592
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister1339)) * int64_t(int32_t(4))); // PTX L2593
	g_RecordByteAddressAtPtx2594 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register137); // PTX L2594
	r_PtxRegister1063 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2594 + 262144ull);		   // PTX L2595
	r_LaneIndexAtPtx2597 = uint32_t((threadIdx.x & 31u));									   // PTX L2597
	r_PtxRegister1340 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2597), uint32_t(31));		   // PTX L2599
	r_PtxRegister1341 = ShiftRight(uint32_t(r_PtxRegister1340), uint32_t(30));				   // PTX L2600
	r_PtxRegister1342 = uint32_t(r_LaneIndexAtPtx2597) + uint32_t(r_PtxRegister1341);		   // PTX L2601
	r_PtxRegister1343 = r_PtxRegister1342 & 2147483644;										   // PTX L2602
	r_PtxRegister1344 = uint32_t(r_LaneIndexAtPtx2597) - uint32_t(r_PtxRegister1343);		   // PTX L2603
	r_PtxRegister1345 = ShiftLeft(uint32_t(r_PtxRegister1344), uint32_t(1));				   // PTX L2604
	r_PtxRegister1346 = uint32_t(r_PtxRegister10) + uint32_t(56);							   // PTX L2605
	r_PtxRegister1347 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1345);			   // PTX L2606
	r_PtxRegister1348 = ShiftRight(uint32_t(r_PtxRegister1347), uint32_t(31));				   // PTX L2607
	r_PtxRegister1349 = uint32_t(r_PtxRegister1347) + uint32_t(r_PtxRegister1348);			   // PTX L2608
	r_PtxRegister1350 = ShiftRightSigned(int32_t(r_PtxRegister1349), uint32_t(1));			   // PTX L2609
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister1350)) * int64_t(int32_t(4))); // PTX L2610
	g_RecordByteAddressAtPtx2611 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register139); // PTX L2611
	r_PtxRegister1066 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2611 + 262144ull);		   // PTX L2612
	r_LaneIndexAtPtx2614 = uint32_t((threadIdx.x & 31u));									   // PTX L2614
	r_PtxRegister1351 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2614), uint32_t(31));		   // PTX L2616
	r_PtxRegister1352 = ShiftRight(uint32_t(r_PtxRegister1351), uint32_t(30));				   // PTX L2617
	r_PtxRegister1353 = uint32_t(r_LaneIndexAtPtx2614) + uint32_t(r_PtxRegister1352);		   // PTX L2618
	r_PtxRegister1354 = r_PtxRegister1353 & 2147483644;										   // PTX L2619
	r_PtxRegister1355 = uint32_t(r_LaneIndexAtPtx2614) - uint32_t(r_PtxRegister1354);		   // PTX L2620
	r_PtxRegister1356 = ShiftLeft(uint32_t(r_PtxRegister1355), uint32_t(1));				   // PTX L2621
	r_PtxRegister1357 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1356);			   // PTX L2622
	r_PtxRegister1358 = ShiftRight(uint32_t(r_PtxRegister1357), uint32_t(31));				   // PTX L2623
	r_PtxRegister1359 = uint32_t(r_PtxRegister1357) + uint32_t(r_PtxRegister1358);			   // PTX L2624
	r_PtxRegister1360 = ShiftRightSigned(int32_t(r_PtxRegister1359), uint32_t(1));			   // PTX L2625
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister1360)) * int64_t(int32_t(4))); // PTX L2626
	g_RecordByteAddressAtPtx2627 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register141); // PTX L2627
	r_PtxRegister1069 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2627 + 262144ull);		   // PTX L2628
	r_LaneIndexAtPtx2630 = uint32_t((threadIdx.x & 31u));									   // PTX L2630
	r_PtxRegister1361 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2630), uint32_t(31));		   // PTX L2632
	r_PtxRegister1362 = ShiftRight(uint32_t(r_PtxRegister1361), uint32_t(30));				   // PTX L2633
	r_PtxRegister1363 = uint32_t(r_LaneIndexAtPtx2630) + uint32_t(r_PtxRegister1362);		   // PTX L2634
	r_PtxRegister1364 = r_PtxRegister1363 & 2147483644;										   // PTX L2635
	r_PtxRegister1365 = uint32_t(r_LaneIndexAtPtx2630) - uint32_t(r_PtxRegister1364);		   // PTX L2636
	r_PtxRegister1366 = ShiftLeft(uint32_t(r_PtxRegister1365), uint32_t(1));				   // PTX L2637
	r_PtxRegister1367 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1366);			   // PTX L2638
	r_PtxRegister1368 = ShiftRightSigned(int32_t(r_PtxRegister1367), uint32_t(1));			   // PTX L2639
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister1368)) * int64_t(int32_t(4))); // PTX L2640
	g_RecordByteAddressAtPtx2641 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register143); // PTX L2641
	r_PtxRegister1072 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2641 + 262144ull);		   // PTX L2642
	r_LaneIndexAtPtx2644 = uint32_t((threadIdx.x & 31u));									   // PTX L2644
	r_PtxRegister1369 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2644), uint32_t(31));		   // PTX L2646
	r_PtxRegister1370 = ShiftRight(uint32_t(r_PtxRegister1369), uint32_t(30));				   // PTX L2647
	r_PtxRegister1371 = uint32_t(r_LaneIndexAtPtx2644) + uint32_t(r_PtxRegister1370);		   // PTX L2648
	r_PtxRegister1372 = r_PtxRegister1371 & 2147483644;										   // PTX L2649
	r_PtxRegister1373 = uint32_t(r_LaneIndexAtPtx2644) - uint32_t(r_PtxRegister1372);		   // PTX L2650
	r_PtxRegister1374 = ShiftLeft(uint32_t(r_PtxRegister1373), uint32_t(1));				   // PTX L2651
	r_PtxRegister1375 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1374);			   // PTX L2652
	r_PtxRegister1376 = ShiftRightSigned(int32_t(r_PtxRegister1375), uint32_t(1));			   // PTX L2653
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister1376)) * int64_t(int32_t(4))); // PTX L2654
	g_RecordByteAddressAtPtx2655 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register145); // PTX L2655
	r_PtxRegister1075 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2655 + 262144ull);		   // PTX L2656
	r_LaneIndexAtPtx2658 = uint32_t((threadIdx.x & 31u));									   // PTX L2658
	r_PtxRegister1377 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2658), uint32_t(31));		   // PTX L2660
	r_PtxRegister1378 = ShiftRight(uint32_t(r_PtxRegister1377), uint32_t(30));				   // PTX L2661
	r_PtxRegister1379 = uint32_t(r_LaneIndexAtPtx2658) + uint32_t(r_PtxRegister1378);		   // PTX L2662
	r_PtxRegister1380 = r_PtxRegister1379 & 2147483644;										   // PTX L2663
	r_PtxRegister1381 = uint32_t(r_LaneIndexAtPtx2658) - uint32_t(r_PtxRegister1380);		   // PTX L2664
	r_PtxRegister1382 = ShiftLeft(uint32_t(r_PtxRegister1381), uint32_t(1));				   // PTX L2665
	r_PtxRegister1383 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1382);			   // PTX L2666
	r_PtxRegister1384 = ShiftRightSigned(int32_t(r_PtxRegister1383), uint32_t(1));			   // PTX L2667
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister1384)) * int64_t(int32_t(4))); // PTX L2668
	g_RecordByteAddressAtPtx2669 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register147); // PTX L2669
	r_PtxRegister1078 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2669 + 262144ull);		   // PTX L2670
	r_LaneIndexAtPtx2672 = uint32_t((threadIdx.x & 31u));									   // PTX L2672
	r_PtxRegister1385 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2672), uint32_t(31));		   // PTX L2674
	r_PtxRegister1386 = ShiftRight(uint32_t(r_PtxRegister1385), uint32_t(30));				   // PTX L2675
	r_PtxRegister1387 = uint32_t(r_LaneIndexAtPtx2672) + uint32_t(r_PtxRegister1386);		   // PTX L2676
	r_PtxRegister1388 = r_PtxRegister1387 & 2147483644;										   // PTX L2677
	r_PtxRegister1389 = uint32_t(r_LaneIndexAtPtx2672) - uint32_t(r_PtxRegister1388);		   // PTX L2678
	r_PtxRegister1390 = ShiftLeft(uint32_t(r_PtxRegister1389), uint32_t(1));				   // PTX L2679
	r_PtxRegister1391 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1390);			   // PTX L2680
	r_PtxRegister1392 = ShiftRightSigned(int32_t(r_PtxRegister1391), uint32_t(1));			   // PTX L2681
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister1392)) * int64_t(int32_t(4))); // PTX L2682
	g_RecordByteAddressAtPtx2683 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register149); // PTX L2683
	r_PtxRegister1081 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2683 + 262144ull);		   // PTX L2684
	r_LaneIndexAtPtx2686 = uint32_t((threadIdx.x & 31u));									   // PTX L2686
	r_PtxRegister1393 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2686), uint32_t(31));		   // PTX L2688
	r_PtxRegister1394 = ShiftRight(uint32_t(r_PtxRegister1393), uint32_t(30));				   // PTX L2689
	r_PtxRegister1395 = uint32_t(r_LaneIndexAtPtx2686) + uint32_t(r_PtxRegister1394);		   // PTX L2690
	r_PtxRegister1396 = r_PtxRegister1395 & 2147483644;										   // PTX L2691
	r_PtxRegister1397 = uint32_t(r_LaneIndexAtPtx2686) - uint32_t(r_PtxRegister1396);		   // PTX L2692
	r_PtxRegister1398 = ShiftLeft(uint32_t(r_PtxRegister1397), uint32_t(1));				   // PTX L2693
	r_PtxRegister1399 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1398);			   // PTX L2694
	r_PtxRegister1400 = ShiftRightSigned(int32_t(r_PtxRegister1399), uint32_t(1));			   // PTX L2695
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister1400)) * int64_t(int32_t(4))); // PTX L2696
	g_RecordByteAddressAtPtx2697 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register151); // PTX L2697
	r_PtxRegister1084 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2697 + 262144ull);		   // PTX L2698
	r_LaneIndexAtPtx2700 = uint32_t((threadIdx.x & 31u));									   // PTX L2700
	r_PtxRegister1401 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2700), uint32_t(31));		   // PTX L2702
	r_PtxRegister1402 = ShiftRight(uint32_t(r_PtxRegister1401), uint32_t(30));				   // PTX L2703
	r_PtxRegister1403 = uint32_t(r_LaneIndexAtPtx2700) + uint32_t(r_PtxRegister1402);		   // PTX L2704
	r_PtxRegister1404 = r_PtxRegister1403 & 2147483644;										   // PTX L2705
	r_PtxRegister1405 = uint32_t(r_LaneIndexAtPtx2700) - uint32_t(r_PtxRegister1404);		   // PTX L2706
	r_PtxRegister1406 = ShiftLeft(uint32_t(r_PtxRegister1405), uint32_t(1));				   // PTX L2707
	r_PtxRegister1407 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1406);			   // PTX L2708
	r_PtxRegister1408 = ShiftRightSigned(int32_t(r_PtxRegister1407), uint32_t(1));			   // PTX L2709
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister1408)) * int64_t(int32_t(4))); // PTX L2710
	g_RecordByteAddressAtPtx2711 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register153); // PTX L2711
	r_PtxRegister1087 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2711 + 262144ull);		   // PTX L2712
	r_LaneIndexAtPtx2714 = uint32_t((threadIdx.x & 31u));									   // PTX L2714
	r_PtxRegister1409 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2714), uint32_t(31));		   // PTX L2716
	r_PtxRegister1410 = ShiftRight(uint32_t(r_PtxRegister1409), uint32_t(30));				   // PTX L2717
	r_PtxRegister1411 = uint32_t(r_LaneIndexAtPtx2714) + uint32_t(r_PtxRegister1410);		   // PTX L2718
	r_PtxRegister1412 = r_PtxRegister1411 & 2147483644;										   // PTX L2719
	r_PtxRegister1413 = uint32_t(r_LaneIndexAtPtx2714) - uint32_t(r_PtxRegister1412);		   // PTX L2720
	r_PtxRegister1414 = ShiftLeft(uint32_t(r_PtxRegister1413), uint32_t(1));				   // PTX L2721
	r_PtxRegister1415 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1414);			   // PTX L2722
	r_PtxRegister1416 = ShiftRight(uint32_t(r_PtxRegister1415), uint32_t(31));				   // PTX L2723
	r_PtxRegister1417 = uint32_t(r_PtxRegister1415) + uint32_t(r_PtxRegister1416);			   // PTX L2724
	r_PtxRegister1418 = ShiftRightSigned(int32_t(r_PtxRegister1417), uint32_t(1));			   // PTX L2725
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister1418)) * int64_t(int32_t(4))); // PTX L2726
	g_RecordByteAddressAtPtx2727 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register155); // PTX L2727
	r_PtxRegister1090 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2727 + 262144ull);		   // PTX L2728
	r_LaneIndexAtPtx2730 = uint32_t((threadIdx.x & 31u));									   // PTX L2730
	r_PtxRegister1419 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2730), uint32_t(31));		   // PTX L2732
	r_PtxRegister1420 = ShiftRight(uint32_t(r_PtxRegister1419), uint32_t(30));				   // PTX L2733
	r_PtxRegister1421 = uint32_t(r_LaneIndexAtPtx2730) + uint32_t(r_PtxRegister1420);		   // PTX L2734
	r_PtxRegister1422 = r_PtxRegister1421 & 2147483644;										   // PTX L2735
	r_PtxRegister1423 = uint32_t(r_LaneIndexAtPtx2730) - uint32_t(r_PtxRegister1422);		   // PTX L2736
	r_PtxRegister1424 = ShiftLeft(uint32_t(r_PtxRegister1423), uint32_t(1));				   // PTX L2737
	r_PtxRegister1425 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1424);			   // PTX L2738
	r_PtxRegister1426 = ShiftRight(uint32_t(r_PtxRegister1425), uint32_t(31));				   // PTX L2739
	r_PtxRegister1427 = uint32_t(r_PtxRegister1425) + uint32_t(r_PtxRegister1426);			   // PTX L2740
	r_PtxRegister1428 = ShiftRightSigned(int32_t(r_PtxRegister1427), uint32_t(1));			   // PTX L2741
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister1428)) * int64_t(int32_t(4))); // PTX L2742
	g_RecordByteAddressAtPtx2743 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register157); // PTX L2743
	r_PtxRegister1093 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2743 + 262144ull);		   // PTX L2744
	r_LaneIndexAtPtx2746 = uint32_t((threadIdx.x & 31u));									   // PTX L2746
	r_PtxRegister1429 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2746), uint32_t(31));		   // PTX L2748
	r_PtxRegister1430 = ShiftRight(uint32_t(r_PtxRegister1429), uint32_t(30));				   // PTX L2749
	r_PtxRegister1431 = uint32_t(r_LaneIndexAtPtx2746) + uint32_t(r_PtxRegister1430);		   // PTX L2750
	r_PtxRegister1432 = r_PtxRegister1431 & 2147483644;										   // PTX L2751
	r_PtxRegister1433 = uint32_t(r_LaneIndexAtPtx2746) - uint32_t(r_PtxRegister1432);		   // PTX L2752
	r_PtxRegister1434 = ShiftLeft(uint32_t(r_PtxRegister1433), uint32_t(1));				   // PTX L2753
	r_PtxRegister1435 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1434);			   // PTX L2754
	r_PtxRegister1436 = ShiftRightSigned(int32_t(r_PtxRegister1435), uint32_t(1));			   // PTX L2755
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister1436)) * int64_t(int32_t(4))); // PTX L2756
	g_RecordByteAddressAtPtx2757 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register159); // PTX L2757
	r_PtxRegister1096 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2757 + 262144ull);		   // PTX L2758
	r_LaneIndexAtPtx2760 = uint32_t((threadIdx.x & 31u));									   // PTX L2760
	r_PtxRegister1437 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2760), uint32_t(31));		   // PTX L2762
	r_PtxRegister1438 = ShiftRight(uint32_t(r_PtxRegister1437), uint32_t(30));				   // PTX L2763
	r_PtxRegister1439 = uint32_t(r_LaneIndexAtPtx2760) + uint32_t(r_PtxRegister1438);		   // PTX L2764
	r_PtxRegister1440 = r_PtxRegister1439 & 2147483644;										   // PTX L2765
	r_PtxRegister1441 = uint32_t(r_LaneIndexAtPtx2760) - uint32_t(r_PtxRegister1440);		   // PTX L2766
	r_PtxRegister1442 = ShiftLeft(uint32_t(r_PtxRegister1441), uint32_t(1));				   // PTX L2767
	r_PtxRegister1443 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1442);			   // PTX L2768
	r_PtxRegister1444 = ShiftRightSigned(int32_t(r_PtxRegister1443), uint32_t(1));			   // PTX L2769
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister1444)) * int64_t(int32_t(4))); // PTX L2770
	g_RecordByteAddressAtPtx2771 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register161); // PTX L2771
	r_PtxRegister1099 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2771 + 262144ull);		   // PTX L2772
	r_LaneIndexAtPtx2774 = uint32_t((threadIdx.x & 31u));									   // PTX L2774
	r_PtxRegister1445 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2774), uint32_t(31));		   // PTX L2776
	r_PtxRegister1446 = ShiftRight(uint32_t(r_PtxRegister1445), uint32_t(30));				   // PTX L2777
	r_PtxRegister1447 = uint32_t(r_LaneIndexAtPtx2774) + uint32_t(r_PtxRegister1446);		   // PTX L2778
	r_PtxRegister1448 = r_PtxRegister1447 & 2147483644;										   // PTX L2779
	r_PtxRegister1449 = uint32_t(r_LaneIndexAtPtx2774) - uint32_t(r_PtxRegister1448);		   // PTX L2780
	r_PtxRegister1450 = ShiftLeft(uint32_t(r_PtxRegister1449), uint32_t(1));				   // PTX L2781
	r_PtxRegister1451 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1450);			   // PTX L2782
	r_PtxRegister1452 = ShiftRight(uint32_t(r_PtxRegister1451), uint32_t(31));				   // PTX L2783
	r_PtxRegister1453 = uint32_t(r_PtxRegister1451) + uint32_t(r_PtxRegister1452);			   // PTX L2784
	r_PtxRegister1454 = ShiftRightSigned(int32_t(r_PtxRegister1453), uint32_t(1));			   // PTX L2785
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister1454)) * int64_t(int32_t(4))); // PTX L2786
	g_RecordByteAddressAtPtx2787 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register163); // PTX L2787
	r_PtxRegister1102 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2787 + 262144ull);		   // PTX L2788
	r_LaneIndexAtPtx2790 = uint32_t((threadIdx.x & 31u));									   // PTX L2790
	r_PtxRegister1455 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2790), uint32_t(31));		   // PTX L2792
	r_PtxRegister1456 = ShiftRight(uint32_t(r_PtxRegister1455), uint32_t(30));				   // PTX L2793
	r_PtxRegister1457 = uint32_t(r_LaneIndexAtPtx2790) + uint32_t(r_PtxRegister1456);		   // PTX L2794
	r_PtxRegister1458 = r_PtxRegister1457 & 2147483644;										   // PTX L2795
	r_PtxRegister1459 = uint32_t(r_LaneIndexAtPtx2790) - uint32_t(r_PtxRegister1458);		   // PTX L2796
	r_PtxRegister1460 = ShiftLeft(uint32_t(r_PtxRegister1459), uint32_t(1));				   // PTX L2797
	r_PtxRegister1461 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1460);			   // PTX L2798
	r_PtxRegister1462 = ShiftRight(uint32_t(r_PtxRegister1461), uint32_t(31));				   // PTX L2799
	r_PtxRegister1463 = uint32_t(r_PtxRegister1461) + uint32_t(r_PtxRegister1462);			   // PTX L2800
	r_PtxRegister1464 = ShiftRightSigned(int32_t(r_PtxRegister1463), uint32_t(1));			   // PTX L2801
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister1464)) * int64_t(int32_t(4))); // PTX L2802
	g_RecordByteAddressAtPtx2803 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register165); // PTX L2803
	r_PtxRegister1105 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2803 + 262144ull);		   // PTX L2804
	r_LaneIndexAtPtx2806 = uint32_t((threadIdx.x & 31u));									   // PTX L2806
	r_PtxRegister1465 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2806), uint32_t(31));		   // PTX L2808
	r_PtxRegister1466 = ShiftRight(uint32_t(r_PtxRegister1465), uint32_t(30));				   // PTX L2809
	r_PtxRegister1467 = uint32_t(r_LaneIndexAtPtx2806) + uint32_t(r_PtxRegister1466);		   // PTX L2810
	r_PtxRegister1468 = r_PtxRegister1467 & 2147483644;										   // PTX L2811
	r_PtxRegister1469 = uint32_t(r_LaneIndexAtPtx2806) - uint32_t(r_PtxRegister1468);		   // PTX L2812
	r_PtxRegister1470 = ShiftLeft(uint32_t(r_PtxRegister1469), uint32_t(1));				   // PTX L2813
	r_PtxRegister1471 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1470);			   // PTX L2814
	r_PtxRegister1472 = ShiftRightSigned(int32_t(r_PtxRegister1471), uint32_t(1));			   // PTX L2815
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister1472)) * int64_t(int32_t(4))); // PTX L2816
	g_RecordByteAddressAtPtx2817 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register167); // PTX L2817
	r_PtxRegister1108 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2817 + 262144ull);		   // PTX L2818
	r_LaneIndexAtPtx2820 = uint32_t((threadIdx.x & 31u));									   // PTX L2820
	r_PtxRegister1473 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2820), uint32_t(31));		   // PTX L2822
	r_PtxRegister1474 = ShiftRight(uint32_t(r_PtxRegister1473), uint32_t(30));				   // PTX L2823
	r_PtxRegister1475 = uint32_t(r_LaneIndexAtPtx2820) + uint32_t(r_PtxRegister1474);		   // PTX L2824
	r_PtxRegister1476 = r_PtxRegister1475 & 2147483644;										   // PTX L2825
	r_PtxRegister1477 = uint32_t(r_LaneIndexAtPtx2820) - uint32_t(r_PtxRegister1476);		   // PTX L2826
	r_PtxRegister1478 = ShiftLeft(uint32_t(r_PtxRegister1477), uint32_t(1));				   // PTX L2827
	r_PtxRegister1479 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1478);			   // PTX L2828
	r_PtxRegister1480 = ShiftRightSigned(int32_t(r_PtxRegister1479), uint32_t(1));			   // PTX L2829
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister1480)) * int64_t(int32_t(4))); // PTX L2830
	g_RecordByteAddressAtPtx2831 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register169); // PTX L2831
	r_PtxRegister1111 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2831 + 262144ull);		   // PTX L2832
	r_LaneIndexAtPtx2834 = uint32_t((threadIdx.x & 31u));									   // PTX L2834
	r_PtxRegister1481 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2834), uint32_t(31));		   // PTX L2836
	r_PtxRegister1482 = ShiftRight(uint32_t(r_PtxRegister1481), uint32_t(30));				   // PTX L2837
	r_PtxRegister1483 = uint32_t(r_LaneIndexAtPtx2834) + uint32_t(r_PtxRegister1482);		   // PTX L2838
	r_PtxRegister1484 = r_PtxRegister1483 & 2147483644;										   // PTX L2839
	r_PtxRegister1485 = uint32_t(r_LaneIndexAtPtx2834) - uint32_t(r_PtxRegister1484);		   // PTX L2840
	r_PtxRegister1486 = ShiftLeft(uint32_t(r_PtxRegister1485), uint32_t(1));				   // PTX L2841
	r_PtxRegister1487 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1486);			   // PTX L2842
	r_PtxRegister1488 = ShiftRight(uint32_t(r_PtxRegister1487), uint32_t(31));				   // PTX L2843
	r_PtxRegister1489 = uint32_t(r_PtxRegister1487) + uint32_t(r_PtxRegister1488);			   // PTX L2844
	r_PtxRegister1490 = ShiftRightSigned(int32_t(r_PtxRegister1489), uint32_t(1));			   // PTX L2845
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister1490)) * int64_t(int32_t(4))); // PTX L2846
	g_RecordByteAddressAtPtx2847 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register171); // PTX L2847
	r_PtxRegister1114 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2847 + 262144ull);		   // PTX L2848
	r_LaneIndexAtPtx2850 = uint32_t((threadIdx.x & 31u));									   // PTX L2850
	r_PtxRegister1491 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2850), uint32_t(31));		   // PTX L2852
	r_PtxRegister1492 = ShiftRight(uint32_t(r_PtxRegister1491), uint32_t(30));				   // PTX L2853
	r_PtxRegister1493 = uint32_t(r_LaneIndexAtPtx2850) + uint32_t(r_PtxRegister1492);		   // PTX L2854
	r_PtxRegister1494 = r_PtxRegister1493 & 2147483644;										   // PTX L2855
	r_PtxRegister1495 = uint32_t(r_LaneIndexAtPtx2850) - uint32_t(r_PtxRegister1494);		   // PTX L2856
	r_PtxRegister1496 = ShiftLeft(uint32_t(r_PtxRegister1495), uint32_t(1));				   // PTX L2857
	r_PtxRegister1497 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1496);			   // PTX L2858
	r_PtxRegister1498 = ShiftRight(uint32_t(r_PtxRegister1497), uint32_t(31));				   // PTX L2859
	r_PtxRegister1499 = uint32_t(r_PtxRegister1497) + uint32_t(r_PtxRegister1498);			   // PTX L2860
	r_PtxRegister1500 = ShiftRightSigned(int32_t(r_PtxRegister1499), uint32_t(1));			   // PTX L2861
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister1500)) * int64_t(int32_t(4))); // PTX L2862
	g_RecordByteAddressAtPtx2863 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register173); // PTX L2863
	r_PtxRegister1117 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2863 + 262144ull);		   // PTX L2864
	r_LaneIndexAtPtx2866 = uint32_t((threadIdx.x & 31u));									   // PTX L2866
	r_PtxRegister1501 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2866), uint32_t(31));		   // PTX L2868
	r_PtxRegister1502 = ShiftRight(uint32_t(r_PtxRegister1501), uint32_t(30));				   // PTX L2869
	r_PtxRegister1503 = uint32_t(r_LaneIndexAtPtx2866) + uint32_t(r_PtxRegister1502);		   // PTX L2870
	r_PtxRegister1504 = r_PtxRegister1503 & 2147483644;										   // PTX L2871
	r_PtxRegister1505 = uint32_t(r_LaneIndexAtPtx2866) - uint32_t(r_PtxRegister1504);		   // PTX L2872
	r_PtxRegister1506 = ShiftLeft(uint32_t(r_PtxRegister1505), uint32_t(1));				   // PTX L2873
	r_PtxRegister1507 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1506);			   // PTX L2874
	r_PtxRegister1508 = ShiftRightSigned(int32_t(r_PtxRegister1507), uint32_t(1));			   // PTX L2875
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister1508)) * int64_t(int32_t(4))); // PTX L2876
	g_RecordByteAddressAtPtx2877 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register175); // PTX L2877
	r_PtxRegister1120 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2877 + 262144ull);		   // PTX L2878
	r_LaneIndexAtPtx2880 = uint32_t((threadIdx.x & 31u));									   // PTX L2880
	r_PtxRegister1509 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2880), uint32_t(31));		   // PTX L2882
	r_PtxRegister1510 = ShiftRight(uint32_t(r_PtxRegister1509), uint32_t(30));				   // PTX L2883
	r_PtxRegister1511 = uint32_t(r_LaneIndexAtPtx2880) + uint32_t(r_PtxRegister1510);		   // PTX L2884
	r_PtxRegister1512 = r_PtxRegister1511 & 2147483644;										   // PTX L2885
	r_PtxRegister1513 = uint32_t(r_LaneIndexAtPtx2880) - uint32_t(r_PtxRegister1512);		   // PTX L2886
	r_PtxRegister1514 = ShiftLeft(uint32_t(r_PtxRegister1513), uint32_t(1));				   // PTX L2887
	r_PtxRegister1515 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1514);			   // PTX L2888
	r_PtxRegister1516 = ShiftRightSigned(int32_t(r_PtxRegister1515), uint32_t(1));			   // PTX L2889
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister1516)) * int64_t(int32_t(4))); // PTX L2890
	g_RecordByteAddressAtPtx2891 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register177); // PTX L2891
	r_PtxRegister1123 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2891 + 262144ull);		   // PTX L2892
	r_LaneIndexAtPtx2894 = uint32_t((threadIdx.x & 31u));									   // PTX L2894
	r_PtxRegister1517 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2894), uint32_t(31));		   // PTX L2896
	r_PtxRegister1518 = ShiftRight(uint32_t(r_PtxRegister1517), uint32_t(30));				   // PTX L2897
	r_PtxRegister1519 = uint32_t(r_LaneIndexAtPtx2894) + uint32_t(r_PtxRegister1518);		   // PTX L2898
	r_PtxRegister1520 = r_PtxRegister1519 & 2147483644;										   // PTX L2899
	r_PtxRegister1521 = uint32_t(r_LaneIndexAtPtx2894) - uint32_t(r_PtxRegister1520);		   // PTX L2900
	r_PtxRegister1522 = ShiftLeft(uint32_t(r_PtxRegister1521), uint32_t(1));				   // PTX L2901
	r_PtxRegister1523 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1522);			   // PTX L2902
	r_PtxRegister1524 = ShiftRightSigned(int32_t(r_PtxRegister1523), uint32_t(1));			   // PTX L2903
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister1524)) * int64_t(int32_t(4))); // PTX L2904
	g_RecordByteAddressAtPtx2905 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register179); // PTX L2905
	r_PtxRegister1126 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2905 + 262144ull);		   // PTX L2906
	r_LaneIndexAtPtx2908 = uint32_t((threadIdx.x & 31u));									   // PTX L2908
	r_PtxRegister1525 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2908), uint32_t(31));		   // PTX L2910
	r_PtxRegister1526 = ShiftRight(uint32_t(r_PtxRegister1525), uint32_t(30));				   // PTX L2911
	r_PtxRegister1527 = uint32_t(r_LaneIndexAtPtx2908) + uint32_t(r_PtxRegister1526);		   // PTX L2912
	r_PtxRegister1528 = r_PtxRegister1527 & 2147483644;										   // PTX L2913
	r_PtxRegister1529 = uint32_t(r_LaneIndexAtPtx2908) - uint32_t(r_PtxRegister1528);		   // PTX L2914
	r_PtxRegister1530 = ShiftLeft(uint32_t(r_PtxRegister1529), uint32_t(1));				   // PTX L2915
	r_PtxRegister1531 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1530);			   // PTX L2916
	r_PtxRegister1532 = ShiftRightSigned(int32_t(r_PtxRegister1531), uint32_t(1));			   // PTX L2917
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister1532)) * int64_t(int32_t(4))); // PTX L2918
	g_RecordByteAddressAtPtx2919 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register181); // PTX L2919
	r_PtxRegister1129 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2919 + 262144ull);		   // PTX L2920
	r_LaneIndexAtPtx2922 = uint32_t((threadIdx.x & 31u));									   // PTX L2922
	r_PtxRegister1533 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2922), uint32_t(31));		   // PTX L2924
	r_PtxRegister1534 = ShiftRight(uint32_t(r_PtxRegister1533), uint32_t(30));				   // PTX L2925
	r_PtxRegister1535 = uint32_t(r_LaneIndexAtPtx2922) + uint32_t(r_PtxRegister1534);		   // PTX L2926
	r_PtxRegister1536 = r_PtxRegister1535 & 2147483644;										   // PTX L2927
	r_PtxRegister1537 = uint32_t(r_LaneIndexAtPtx2922) - uint32_t(r_PtxRegister1536);		   // PTX L2928
	r_PtxRegister1538 = ShiftLeft(uint32_t(r_PtxRegister1537), uint32_t(1));				   // PTX L2929
	r_PtxRegister1539 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1538);			   // PTX L2930
	r_PtxRegister1540 = ShiftRightSigned(int32_t(r_PtxRegister1539), uint32_t(1));			   // PTX L2931
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister1540)) * int64_t(int32_t(4))); // PTX L2932
	g_RecordByteAddressAtPtx2933 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register183); // PTX L2933
	r_PtxRegister1132 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2933 + 262144ull);		   // PTX L2934
	r_LaneIndexAtPtx2936 = uint32_t((threadIdx.x & 31u));									   // PTX L2936
	r_PtxRegister1541 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2936), uint32_t(31));		   // PTX L2938
	r_PtxRegister1542 = ShiftRight(uint32_t(r_PtxRegister1541), uint32_t(30));				   // PTX L2939
	r_PtxRegister1543 = uint32_t(r_LaneIndexAtPtx2936) + uint32_t(r_PtxRegister1542);		   // PTX L2940
	r_PtxRegister1544 = r_PtxRegister1543 & 2147483644;										   // PTX L2941
	r_PtxRegister1545 = uint32_t(r_LaneIndexAtPtx2936) - uint32_t(r_PtxRegister1544);		   // PTX L2942
	r_PtxRegister1546 = ShiftLeft(uint32_t(r_PtxRegister1545), uint32_t(1));				   // PTX L2943
	r_PtxRegister1547 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1546);			   // PTX L2944
	r_PtxRegister1548 = ShiftRightSigned(int32_t(r_PtxRegister1547), uint32_t(1));			   // PTX L2945
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister1548)) * int64_t(int32_t(4))); // PTX L2946
	g_RecordByteAddressAtPtx2947 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register185); // PTX L2947
	r_PtxRegister1135 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2947 + 262144ull);		   // PTX L2948
	r_LaneIndexAtPtx2950 = uint32_t((threadIdx.x & 31u));									   // PTX L2950
	r_PtxRegister1549 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2950), uint32_t(31));		   // PTX L2952
	r_PtxRegister1550 = ShiftRight(uint32_t(r_PtxRegister1549), uint32_t(30));				   // PTX L2953
	r_PtxRegister1551 = uint32_t(r_LaneIndexAtPtx2950) + uint32_t(r_PtxRegister1550);		   // PTX L2954
	r_PtxRegister1552 = r_PtxRegister1551 & 2147483644;										   // PTX L2955
	r_PtxRegister1553 = uint32_t(r_LaneIndexAtPtx2950) - uint32_t(r_PtxRegister1552);		   // PTX L2956
	r_PtxRegister1554 = ShiftLeft(uint32_t(r_PtxRegister1553), uint32_t(1));				   // PTX L2957
	r_PtxRegister1555 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1554);			   // PTX L2958
	r_PtxRegister1556 = ShiftRight(uint32_t(r_PtxRegister1555), uint32_t(31));				   // PTX L2959
	r_PtxRegister1557 = uint32_t(r_PtxRegister1555) + uint32_t(r_PtxRegister1556);			   // PTX L2960
	r_PtxRegister1558 = ShiftRightSigned(int32_t(r_PtxRegister1557), uint32_t(1));			   // PTX L2961
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister1558)) * int64_t(int32_t(4))); // PTX L2962
	g_RecordByteAddressAtPtx2963 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register187); // PTX L2963
	r_PtxRegister1138 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2963 + 262144ull);		   // PTX L2964
	r_LaneIndexAtPtx2966 = uint32_t((threadIdx.x & 31u));									   // PTX L2966
	r_PtxRegister1559 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2966), uint32_t(31));		   // PTX L2968
	r_PtxRegister1560 = ShiftRight(uint32_t(r_PtxRegister1559), uint32_t(30));				   // PTX L2969
	r_PtxRegister1561 = uint32_t(r_LaneIndexAtPtx2966) + uint32_t(r_PtxRegister1560);		   // PTX L2970
	r_PtxRegister1562 = r_PtxRegister1561 & 2147483644;										   // PTX L2971
	r_PtxRegister1563 = uint32_t(r_LaneIndexAtPtx2966) - uint32_t(r_PtxRegister1562);		   // PTX L2972
	r_PtxRegister1564 = ShiftLeft(uint32_t(r_PtxRegister1563), uint32_t(1));				   // PTX L2973
	r_PtxRegister1565 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1564);			   // PTX L2974
	r_PtxRegister1566 = ShiftRight(uint32_t(r_PtxRegister1565), uint32_t(31));				   // PTX L2975
	r_PtxRegister1567 = uint32_t(r_PtxRegister1565) + uint32_t(r_PtxRegister1566);			   // PTX L2976
	r_PtxRegister1568 = ShiftRightSigned(int32_t(r_PtxRegister1567), uint32_t(1));			   // PTX L2977
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister1568)) * int64_t(int32_t(4))); // PTX L2978
	g_RecordByteAddressAtPtx2979 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register189); // PTX L2979
	r_PtxRegister1141 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2979 + 262144ull);		   // PTX L2980
	r_LaneIndexAtPtx2982 = uint32_t((threadIdx.x & 31u));									   // PTX L2982
	r_PtxRegister1569 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2982), uint32_t(31));		   // PTX L2984
	r_PtxRegister1570 = ShiftRight(uint32_t(r_PtxRegister1569), uint32_t(30));				   // PTX L2985
	r_PtxRegister1571 = uint32_t(r_LaneIndexAtPtx2982) + uint32_t(r_PtxRegister1570);		   // PTX L2986
	r_PtxRegister1572 = r_PtxRegister1571 & 2147483644;										   // PTX L2987
	r_PtxRegister1573 = uint32_t(r_LaneIndexAtPtx2982) - uint32_t(r_PtxRegister1572);		   // PTX L2988
	r_PtxRegister1574 = ShiftLeft(uint32_t(r_PtxRegister1573), uint32_t(1));				   // PTX L2989
	r_PtxRegister1575 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1574);			   // PTX L2990
	r_PtxRegister1576 = ShiftRightSigned(int32_t(r_PtxRegister1575), uint32_t(1));			   // PTX L2991
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister1576)) * int64_t(int32_t(4))); // PTX L2992
	g_RecordByteAddressAtPtx2993 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register191); // PTX L2993
	r_PtxRegister1144 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2993 + 262144ull);		   // PTX L2994
	r_LaneIndexAtPtx2996 = uint32_t((threadIdx.x & 31u));									   // PTX L2996
	r_PtxRegister1577 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2996), uint32_t(31));		   // PTX L2998
	r_PtxRegister1578 = ShiftRight(uint32_t(r_PtxRegister1577), uint32_t(30));				   // PTX L2999
	r_PtxRegister1579 = uint32_t(r_LaneIndexAtPtx2996) + uint32_t(r_PtxRegister1578);		   // PTX L3000
	r_PtxRegister1580 = r_PtxRegister1579 & 2147483644;										   // PTX L3001
	r_PtxRegister1581 = uint32_t(r_LaneIndexAtPtx2996) - uint32_t(r_PtxRegister1580);		   // PTX L3002
	r_PtxRegister1582 = ShiftLeft(uint32_t(r_PtxRegister1581), uint32_t(1));				   // PTX L3003
	r_PtxRegister1583 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1582);			   // PTX L3004
	r_PtxRegister1584 = ShiftRightSigned(int32_t(r_PtxRegister1583), uint32_t(1));			   // PTX L3005
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister1584)) * int64_t(int32_t(4))); // PTX L3006
	g_RecordByteAddressAtPtx3007 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register193); // PTX L3007
	r_PtxRegister1147 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3007 + 262144ull);		   // PTX L3008
	r_LaneIndexAtPtx3010 = uint32_t((threadIdx.x & 31u));									   // PTX L3010
	r_PtxRegister1585 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3010), uint32_t(31));		   // PTX L3012
	r_PtxRegister1586 = ShiftRight(uint32_t(r_PtxRegister1585), uint32_t(30));				   // PTX L3013
	r_PtxRegister1587 = uint32_t(r_LaneIndexAtPtx3010) + uint32_t(r_PtxRegister1586);		   // PTX L3014
	r_PtxRegister1588 = r_PtxRegister1587 & 2147483644;										   // PTX L3015
	r_PtxRegister1589 = uint32_t(r_LaneIndexAtPtx3010) - uint32_t(r_PtxRegister1588);		   // PTX L3016
	r_PtxRegister1590 = ShiftLeft(uint32_t(r_PtxRegister1589), uint32_t(1));				   // PTX L3017
	r_PtxRegister1591 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1590);			   // PTX L3018
	r_PtxRegister1592 = ShiftRight(uint32_t(r_PtxRegister1591), uint32_t(31));				   // PTX L3019
	r_PtxRegister1593 = uint32_t(r_PtxRegister1591) + uint32_t(r_PtxRegister1592);			   // PTX L3020
	r_PtxRegister1594 = ShiftRightSigned(int32_t(r_PtxRegister1593), uint32_t(1));			   // PTX L3021
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister1594)) * int64_t(int32_t(4))); // PTX L3022
	g_RecordByteAddressAtPtx3023 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register195); // PTX L3023
	r_PtxRegister1150 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3023 + 262144ull);		   // PTX L3024
	r_LaneIndexAtPtx3026 = uint32_t((threadIdx.x & 31u));									   // PTX L3026
	r_PtxRegister1595 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3026), uint32_t(31));		   // PTX L3028
	r_PtxRegister1596 = ShiftRight(uint32_t(r_PtxRegister1595), uint32_t(30));				   // PTX L3029
	r_PtxRegister1597 = uint32_t(r_LaneIndexAtPtx3026) + uint32_t(r_PtxRegister1596);		   // PTX L3030
	r_PtxRegister1598 = r_PtxRegister1597 & 2147483644;										   // PTX L3031
	r_PtxRegister1599 = uint32_t(r_LaneIndexAtPtx3026) - uint32_t(r_PtxRegister1598);		   // PTX L3032
	r_PtxRegister1600 = ShiftLeft(uint32_t(r_PtxRegister1599), uint32_t(1));				   // PTX L3033
	r_PtxRegister1601 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1600);			   // PTX L3034
	r_PtxRegister1602 = ShiftRight(uint32_t(r_PtxRegister1601), uint32_t(31));				   // PTX L3035
	r_PtxRegister1603 = uint32_t(r_PtxRegister1601) + uint32_t(r_PtxRegister1602);			   // PTX L3036
	r_PtxRegister1604 = ShiftRightSigned(int32_t(r_PtxRegister1603), uint32_t(1));			   // PTX L3037
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister1604)) * int64_t(int32_t(4))); // PTX L3038
	g_RecordByteAddressAtPtx3039 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register197); // PTX L3039
	r_PtxRegister1153 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3039 + 262144ull);		   // PTX L3040
	r_LaneIndexAtPtx3042 = uint32_t((threadIdx.x & 31u));									   // PTX L3042
	r_PtxRegister1605 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3042), uint32_t(31));		   // PTX L3044
	r_PtxRegister1606 = ShiftRight(uint32_t(r_PtxRegister1605), uint32_t(30));				   // PTX L3045
	r_PtxRegister1607 = uint32_t(r_LaneIndexAtPtx3042) + uint32_t(r_PtxRegister1606);		   // PTX L3046
	r_PtxRegister1608 = r_PtxRegister1607 & 2147483644;										   // PTX L3047
	r_PtxRegister1609 = uint32_t(r_LaneIndexAtPtx3042) - uint32_t(r_PtxRegister1608);		   // PTX L3048
	r_PtxRegister1610 = ShiftLeft(uint32_t(r_PtxRegister1609), uint32_t(1));				   // PTX L3049
	r_PtxRegister1611 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1610);			   // PTX L3050
	r_PtxRegister1612 = ShiftRightSigned(int32_t(r_PtxRegister1611), uint32_t(1));			   // PTX L3051
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister1612)) * int64_t(int32_t(4))); // PTX L3052
	g_RecordByteAddressAtPtx3053 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register199); // PTX L3053
	r_PtxRegister1156 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3053 + 262144ull);		   // PTX L3054
	r_LaneIndexAtPtx3056 = uint32_t((threadIdx.x & 31u));									   // PTX L3056
	r_PtxRegister1613 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3056), uint32_t(31));		   // PTX L3058
	r_PtxRegister1614 = ShiftRight(uint32_t(r_PtxRegister1613), uint32_t(30));				   // PTX L3059
	r_PtxRegister1615 = uint32_t(r_LaneIndexAtPtx3056) + uint32_t(r_PtxRegister1614);		   // PTX L3060
	r_PtxRegister1616 = r_PtxRegister1615 & 2147483644;										   // PTX L3061
	r_PtxRegister1617 = uint32_t(r_LaneIndexAtPtx3056) - uint32_t(r_PtxRegister1616);		   // PTX L3062
	r_PtxRegister1618 = ShiftLeft(uint32_t(r_PtxRegister1617), uint32_t(1));				   // PTX L3063
	r_PtxRegister1619 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1618);			   // PTX L3064
	r_PtxRegister1620 = ShiftRightSigned(int32_t(r_PtxRegister1619), uint32_t(1));			   // PTX L3065
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister1620)) * int64_t(int32_t(4))); // PTX L3066
	g_RecordByteAddressAtPtx3067 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register201); // PTX L3067
	r_PtxRegister1159 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3067 + 262144ull);		   // PTX L3068
	r_LaneIndexAtPtx3070 = uint32_t((threadIdx.x & 31u));									   // PTX L3070
	r_PtxRegister1621 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3070), uint32_t(31));		   // PTX L3072
	r_PtxRegister1622 = ShiftRight(uint32_t(r_PtxRegister1621), uint32_t(30));				   // PTX L3073
	r_PtxRegister1623 = uint32_t(r_LaneIndexAtPtx3070) + uint32_t(r_PtxRegister1622);		   // PTX L3074
	r_PtxRegister1624 = r_PtxRegister1623 & 2147483644;										   // PTX L3075
	r_PtxRegister1625 = uint32_t(r_LaneIndexAtPtx3070) - uint32_t(r_PtxRegister1624);		   // PTX L3076
	r_PtxRegister1626 = ShiftLeft(uint32_t(r_PtxRegister1625), uint32_t(1));				   // PTX L3077
	r_PtxRegister1627 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1626);			   // PTX L3078
	r_PtxRegister1628 = ShiftRight(uint32_t(r_PtxRegister1627), uint32_t(31));				   // PTX L3079
	r_PtxRegister1629 = uint32_t(r_PtxRegister1627) + uint32_t(r_PtxRegister1628);			   // PTX L3080
	r_PtxRegister1630 = ShiftRightSigned(int32_t(r_PtxRegister1629), uint32_t(1));			   // PTX L3081
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister1630)) * int64_t(int32_t(4))); // PTX L3082
	g_RecordByteAddressAtPtx3083 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register203); // PTX L3083
	r_PtxRegister1162 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3083 + 262144ull);		   // PTX L3084
	r_LaneIndexAtPtx3086 = uint32_t((threadIdx.x & 31u));									   // PTX L3086
	r_PtxRegister1631 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3086), uint32_t(31));		   // PTX L3088
	r_PtxRegister1632 = ShiftRight(uint32_t(r_PtxRegister1631), uint32_t(30));				   // PTX L3089
	r_PtxRegister1633 = uint32_t(r_LaneIndexAtPtx3086) + uint32_t(r_PtxRegister1632);		   // PTX L3090
	r_PtxRegister1634 = r_PtxRegister1633 & 2147483644;										   // PTX L3091
	r_PtxRegister1635 = uint32_t(r_LaneIndexAtPtx3086) - uint32_t(r_PtxRegister1634);		   // PTX L3092
	r_PtxRegister1636 = ShiftLeft(uint32_t(r_PtxRegister1635), uint32_t(1));				   // PTX L3093
	r_PtxRegister1637 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1636);			   // PTX L3094
	r_PtxRegister1638 = ShiftRight(uint32_t(r_PtxRegister1637), uint32_t(31));				   // PTX L3095
	r_PtxRegister1639 = uint32_t(r_PtxRegister1637) + uint32_t(r_PtxRegister1638);			   // PTX L3096
	r_PtxRegister1640 = ShiftRightSigned(int32_t(r_PtxRegister1639), uint32_t(1));			   // PTX L3097
	r_PtxU64Register205 = uint64_t(int64_t(int32_t(r_PtxRegister1640)) * int64_t(int32_t(4))); // PTX L3098
	g_RecordByteAddressAtPtx3099 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register205); // PTX L3099
	r_PtxRegister1165 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3099 + 262144ull);		   // PTX L3100
	r_LaneIndexAtPtx3102 = uint32_t((threadIdx.x & 31u));									   // PTX L3102
	r_PtxRegister1641 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3102), uint32_t(31));		   // PTX L3104
	r_PtxRegister1642 = ShiftRight(uint32_t(r_PtxRegister1641), uint32_t(30));				   // PTX L3105
	r_PtxRegister1643 = uint32_t(r_LaneIndexAtPtx3102) + uint32_t(r_PtxRegister1642);		   // PTX L3106
	r_PtxRegister1644 = r_PtxRegister1643 & 2147483644;										   // PTX L3107
	r_PtxRegister1645 = uint32_t(r_LaneIndexAtPtx3102) - uint32_t(r_PtxRegister1644);		   // PTX L3108
	r_PtxRegister1646 = ShiftLeft(uint32_t(r_PtxRegister1645), uint32_t(1));				   // PTX L3109
	r_PtxRegister1647 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1646);			   // PTX L3110
	r_PtxRegister1648 = ShiftRightSigned(int32_t(r_PtxRegister1647), uint32_t(1));			   // PTX L3111
	r_PtxU64Register207 = uint64_t(int64_t(int32_t(r_PtxRegister1648)) * int64_t(int32_t(4))); // PTX L3112
	g_RecordByteAddressAtPtx3113 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register207); // PTX L3113
	r_PtxRegister1168 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3113 + 262144ull);		   // PTX L3114
	r_LaneIndexAtPtx3116 = uint32_t((threadIdx.x & 31u));									   // PTX L3116
	r_PtxRegister1649 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3116), uint32_t(31));		   // PTX L3118
	r_PtxRegister1650 = ShiftRight(uint32_t(r_PtxRegister1649), uint32_t(30));				   // PTX L3119
	r_PtxRegister1651 = uint32_t(r_LaneIndexAtPtx3116) + uint32_t(r_PtxRegister1650);		   // PTX L3120
	r_PtxRegister1652 = r_PtxRegister1651 & 2147483644;										   // PTX L3121
	r_PtxRegister1653 = uint32_t(r_LaneIndexAtPtx3116) - uint32_t(r_PtxRegister1652);		   // PTX L3122
	r_PtxRegister1654 = ShiftLeft(uint32_t(r_PtxRegister1653), uint32_t(1));				   // PTX L3123
	r_PtxRegister1655 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1654);			   // PTX L3124
	r_PtxRegister1656 = ShiftRightSigned(int32_t(r_PtxRegister1655), uint32_t(1));			   // PTX L3125
	r_PtxU64Register209 = uint64_t(int64_t(int32_t(r_PtxRegister1656)) * int64_t(int32_t(4))); // PTX L3126
	g_RecordByteAddressAtPtx3127 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register209); // PTX L3127
	r_PtxRegister1171 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3127 + 262144ull);		   // PTX L3128
	r_LaneIndexAtPtx3130 = uint32_t((threadIdx.x & 31u));									   // PTX L3130
	r_PtxRegister1657 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3130), uint32_t(31));		   // PTX L3132
	r_PtxRegister1658 = ShiftRight(uint32_t(r_PtxRegister1657), uint32_t(30));				   // PTX L3133
	r_PtxRegister1659 = uint32_t(r_LaneIndexAtPtx3130) + uint32_t(r_PtxRegister1658);		   // PTX L3134
	r_PtxRegister1660 = r_PtxRegister1659 & 2147483644;										   // PTX L3135
	r_PtxRegister1661 = uint32_t(r_LaneIndexAtPtx3130) - uint32_t(r_PtxRegister1660);		   // PTX L3136
	r_PtxRegister1662 = ShiftLeft(uint32_t(r_PtxRegister1661), uint32_t(1));				   // PTX L3137
	r_PtxRegister1663 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1662);			   // PTX L3138
	r_PtxRegister1664 = ShiftRightSigned(int32_t(r_PtxRegister1663), uint32_t(1));			   // PTX L3139
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister1664)) * int64_t(int32_t(4))); // PTX L3140
	g_RecordByteAddressAtPtx3141 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register211); // PTX L3141
	r_PtxRegister1174 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3141 + 262144ull);		   // PTX L3142
	r_LaneIndexAtPtx3144 = uint32_t((threadIdx.x & 31u));									   // PTX L3144
	r_PtxRegister1665 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3144), uint32_t(31));		   // PTX L3146
	r_PtxRegister1666 = ShiftRight(uint32_t(r_PtxRegister1665), uint32_t(30));				   // PTX L3147
	r_PtxRegister1667 = uint32_t(r_LaneIndexAtPtx3144) + uint32_t(r_PtxRegister1666);		   // PTX L3148
	r_PtxRegister1668 = r_PtxRegister1667 & 2147483644;										   // PTX L3149
	r_PtxRegister1669 = uint32_t(r_LaneIndexAtPtx3144) - uint32_t(r_PtxRegister1668);		   // PTX L3150
	r_PtxRegister1670 = ShiftLeft(uint32_t(r_PtxRegister1669), uint32_t(1));				   // PTX L3151
	r_PtxRegister1671 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1670);			   // PTX L3152
	r_PtxRegister1672 = ShiftRightSigned(int32_t(r_PtxRegister1671), uint32_t(1));			   // PTX L3153
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister1672)) * int64_t(int32_t(4))); // PTX L3154
	g_RecordByteAddressAtPtx3155 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register213); // PTX L3155
	r_PtxRegister1177 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3155 + 262144ull);		   // PTX L3156
	r_LaneIndexAtPtx3158 = uint32_t((threadIdx.x & 31u));									   // PTX L3158
	r_PtxRegister1673 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3158), uint32_t(31));		   // PTX L3160
	r_PtxRegister1674 = ShiftRight(uint32_t(r_PtxRegister1673), uint32_t(30));				   // PTX L3161
	r_PtxRegister1675 = uint32_t(r_LaneIndexAtPtx3158) + uint32_t(r_PtxRegister1674);		   // PTX L3162
	r_PtxRegister1676 = r_PtxRegister1675 & 2147483644;										   // PTX L3163
	r_PtxRegister1677 = uint32_t(r_LaneIndexAtPtx3158) - uint32_t(r_PtxRegister1676);		   // PTX L3164
	r_PtxRegister1678 = ShiftLeft(uint32_t(r_PtxRegister1677), uint32_t(1));				   // PTX L3165
	r_PtxRegister1679 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1678);			   // PTX L3166
	r_PtxRegister1680 = ShiftRightSigned(int32_t(r_PtxRegister1679), uint32_t(1));			   // PTX L3167
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister1680)) * int64_t(int32_t(4))); // PTX L3168
	g_RecordByteAddressAtPtx3169 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register215); // PTX L3169
	r_PtxRegister1180 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3169 + 262144ull);		   // PTX L3170
	r_LaneIndexAtPtx3172 = uint32_t((threadIdx.x & 31u));									   // PTX L3172
	r_PtxRegister1681 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3172), uint32_t(31));		   // PTX L3174
	r_PtxRegister1682 = ShiftRight(uint32_t(r_PtxRegister1681), uint32_t(30));				   // PTX L3175
	r_PtxRegister1683 = uint32_t(r_LaneIndexAtPtx3172) + uint32_t(r_PtxRegister1682);		   // PTX L3176
	r_PtxRegister1684 = r_PtxRegister1683 & 2147483644;										   // PTX L3177
	r_PtxRegister1685 = uint32_t(r_LaneIndexAtPtx3172) - uint32_t(r_PtxRegister1684);		   // PTX L3178
	r_PtxRegister1686 = ShiftLeft(uint32_t(r_PtxRegister1685), uint32_t(1));				   // PTX L3179
	r_PtxRegister1687 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1686);			   // PTX L3180
	r_PtxRegister1688 = ShiftRightSigned(int32_t(r_PtxRegister1687), uint32_t(1));			   // PTX L3181
	r_PtxU64Register217 = uint64_t(int64_t(int32_t(r_PtxRegister1688)) * int64_t(int32_t(4))); // PTX L3182
	g_RecordByteAddressAtPtx3183 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register217); // PTX L3183
	r_PtxRegister1183 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3183 + 262144ull);		   // PTX L3184
	r_LaneIndexAtPtx3186 = uint32_t((threadIdx.x & 31u));									   // PTX L3186
	r_PtxRegister1689 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3186), uint32_t(31));		   // PTX L3188
	r_PtxRegister1690 = ShiftRight(uint32_t(r_PtxRegister1689), uint32_t(30));				   // PTX L3189
	r_PtxRegister1691 = uint32_t(r_LaneIndexAtPtx3186) + uint32_t(r_PtxRegister1690);		   // PTX L3190
	r_PtxRegister1692 = r_PtxRegister1691 & 2147483644;										   // PTX L3191
	r_PtxRegister1693 = uint32_t(r_LaneIndexAtPtx3186) - uint32_t(r_PtxRegister1692);		   // PTX L3192
	r_PtxRegister1694 = ShiftLeft(uint32_t(r_PtxRegister1693), uint32_t(1));				   // PTX L3193
	r_PtxRegister1695 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1694);			   // PTX L3194
	r_PtxRegister1696 = ShiftRight(uint32_t(r_PtxRegister1695), uint32_t(31));				   // PTX L3195
	r_PtxRegister1697 = uint32_t(r_PtxRegister1695) + uint32_t(r_PtxRegister1696);			   // PTX L3196
	r_PtxRegister1698 = ShiftRightSigned(int32_t(r_PtxRegister1697), uint32_t(1));			   // PTX L3197
	r_PtxU64Register219 = uint64_t(int64_t(int32_t(r_PtxRegister1698)) * int64_t(int32_t(4))); // PTX L3198
	g_RecordByteAddressAtPtx3199 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register219); // PTX L3199
	r_PtxRegister1186 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3199 + 262144ull);		   // PTX L3200
	r_LaneIndexAtPtx3202 = uint32_t((threadIdx.x & 31u));									   // PTX L3202
	r_PtxRegister1699 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3202), uint32_t(31));		   // PTX L3204
	r_PtxRegister1700 = ShiftRight(uint32_t(r_PtxRegister1699), uint32_t(30));				   // PTX L3205
	r_PtxRegister1701 = uint32_t(r_LaneIndexAtPtx3202) + uint32_t(r_PtxRegister1700);		   // PTX L3206
	r_PtxRegister1702 = r_PtxRegister1701 & 2147483644;										   // PTX L3207
	r_PtxRegister1703 = uint32_t(r_LaneIndexAtPtx3202) - uint32_t(r_PtxRegister1702);		   // PTX L3208
	r_PtxRegister1704 = ShiftLeft(uint32_t(r_PtxRegister1703), uint32_t(1));				   // PTX L3209
	r_PtxRegister1705 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1704);			   // PTX L3210
	r_PtxRegister1706 = ShiftRight(uint32_t(r_PtxRegister1705), uint32_t(31));				   // PTX L3211
	r_PtxRegister1707 = uint32_t(r_PtxRegister1705) + uint32_t(r_PtxRegister1706);			   // PTX L3212
	r_PtxRegister1708 = ShiftRightSigned(int32_t(r_PtxRegister1707), uint32_t(1));			   // PTX L3213
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister1708)) * int64_t(int32_t(4))); // PTX L3214
	g_RecordByteAddressAtPtx3215 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register221); // PTX L3215
	r_PtxRegister1189 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3215 + 262144ull);		   // PTX L3216
	r_LaneIndexAtPtx3218 = uint32_t((threadIdx.x & 31u));									   // PTX L3218
	r_PtxRegister1709 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3218), uint32_t(31));		   // PTX L3220
	r_PtxRegister1710 = ShiftRight(uint32_t(r_PtxRegister1709), uint32_t(30));				   // PTX L3221
	r_PtxRegister1711 = uint32_t(r_LaneIndexAtPtx3218) + uint32_t(r_PtxRegister1710);		   // PTX L3222
	r_PtxRegister1712 = r_PtxRegister1711 & 2147483644;										   // PTX L3223
	r_PtxRegister1713 = uint32_t(r_LaneIndexAtPtx3218) - uint32_t(r_PtxRegister1712);		   // PTX L3224
	r_PtxRegister1714 = ShiftLeft(uint32_t(r_PtxRegister1713), uint32_t(1));				   // PTX L3225
	r_PtxRegister1715 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1714);			   // PTX L3226
	r_PtxRegister1716 = ShiftRightSigned(int32_t(r_PtxRegister1715), uint32_t(1));			   // PTX L3227
	r_PtxU64Register223 = uint64_t(int64_t(int32_t(r_PtxRegister1716)) * int64_t(int32_t(4))); // PTX L3228
	g_RecordByteAddressAtPtx3229 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register223); // PTX L3229
	r_PtxRegister1192 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3229 + 262144ull);		   // PTX L3230
	r_LaneIndexAtPtx3232 = uint32_t((threadIdx.x & 31u));									   // PTX L3232
	r_PtxRegister1717 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3232), uint32_t(31));		   // PTX L3234
	r_PtxRegister1718 = ShiftRight(uint32_t(r_PtxRegister1717), uint32_t(30));				   // PTX L3235
	r_PtxRegister1719 = uint32_t(r_LaneIndexAtPtx3232) + uint32_t(r_PtxRegister1718);		   // PTX L3236
	r_PtxRegister1720 = r_PtxRegister1719 & 2147483644;										   // PTX L3237
	r_PtxRegister1721 = uint32_t(r_LaneIndexAtPtx3232) - uint32_t(r_PtxRegister1720);		   // PTX L3238
	r_PtxRegister1722 = ShiftLeft(uint32_t(r_PtxRegister1721), uint32_t(1));				   // PTX L3239
	r_PtxRegister1723 = uint32_t(r_PtxRegister1291) + uint32_t(r_PtxRegister1722);			   // PTX L3240
	r_PtxRegister1724 = ShiftRightSigned(int32_t(r_PtxRegister1723), uint32_t(1));			   // PTX L3241
	r_PtxU64Register225 = uint64_t(int64_t(int32_t(r_PtxRegister1724)) * int64_t(int32_t(4))); // PTX L3242
	g_RecordByteAddressAtPtx3243 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register225); // PTX L3243
	r_PtxRegister1195 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3243 + 262144ull);		   // PTX L3244
	r_LaneIndexAtPtx3246 = uint32_t((threadIdx.x & 31u));									   // PTX L3246
	r_PtxRegister1725 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3246), uint32_t(31));		   // PTX L3248
	r_PtxRegister1726 = ShiftRight(uint32_t(r_PtxRegister1725), uint32_t(30));				   // PTX L3249
	r_PtxRegister1727 = uint32_t(r_LaneIndexAtPtx3246) + uint32_t(r_PtxRegister1726);		   // PTX L3250
	r_PtxRegister1728 = r_PtxRegister1727 & 2147483644;										   // PTX L3251
	r_PtxRegister1729 = uint32_t(r_LaneIndexAtPtx3246) - uint32_t(r_PtxRegister1728);		   // PTX L3252
	r_PtxRegister1730 = ShiftLeft(uint32_t(r_PtxRegister1729), uint32_t(1));				   // PTX L3253
	r_PtxRegister1731 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1730);			   // PTX L3254
	r_PtxRegister1732 = ShiftRight(uint32_t(r_PtxRegister1731), uint32_t(31));				   // PTX L3255
	r_PtxRegister1733 = uint32_t(r_PtxRegister1731) + uint32_t(r_PtxRegister1732);			   // PTX L3256
	r_PtxRegister1734 = ShiftRightSigned(int32_t(r_PtxRegister1733), uint32_t(1));			   // PTX L3257
	r_PtxU64Register227 = uint64_t(int64_t(int32_t(r_PtxRegister1734)) * int64_t(int32_t(4))); // PTX L3258
	g_RecordByteAddressAtPtx3259 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register227); // PTX L3259
	r_PtxRegister1198 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3259 + 262144ull);		   // PTX L3260
	r_LaneIndexAtPtx3262 = uint32_t((threadIdx.x & 31u));									   // PTX L3262
	r_PtxRegister1735 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3262), uint32_t(31));		   // PTX L3264
	r_PtxRegister1736 = ShiftRight(uint32_t(r_PtxRegister1735), uint32_t(30));				   // PTX L3265
	r_PtxRegister1737 = uint32_t(r_LaneIndexAtPtx3262) + uint32_t(r_PtxRegister1736);		   // PTX L3266
	r_PtxRegister1738 = r_PtxRegister1737 & 2147483644;										   // PTX L3267
	r_PtxRegister1739 = uint32_t(r_LaneIndexAtPtx3262) - uint32_t(r_PtxRegister1738);		   // PTX L3268
	r_PtxRegister1740 = ShiftLeft(uint32_t(r_PtxRegister1739), uint32_t(1));				   // PTX L3269
	r_PtxRegister1741 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister1740);			   // PTX L3270
	r_PtxRegister1742 = ShiftRight(uint32_t(r_PtxRegister1741), uint32_t(31));				   // PTX L3271
	r_PtxRegister1743 = uint32_t(r_PtxRegister1741) + uint32_t(r_PtxRegister1742);			   // PTX L3272
	r_PtxRegister1744 = ShiftRightSigned(int32_t(r_PtxRegister1743), uint32_t(1));			   // PTX L3273
	r_PtxU64Register229 = uint64_t(int64_t(int32_t(r_PtxRegister1744)) * int64_t(int32_t(4))); // PTX L3274
	g_RecordByteAddressAtPtx3275 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register229); // PTX L3275
	r_PtxRegister1201 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3275 + 262144ull);		   // PTX L3276
	r_LaneIndexAtPtx3278 = uint32_t((threadIdx.x & 31u));									   // PTX L3278
	r_PtxRegister1745 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3278), uint32_t(31));		   // PTX L3280
	r_PtxRegister1746 = ShiftRight(uint32_t(r_PtxRegister1745), uint32_t(30));				   // PTX L3281
	r_PtxRegister1747 = uint32_t(r_LaneIndexAtPtx3278) + uint32_t(r_PtxRegister1746);		   // PTX L3282
	r_PtxRegister1748 = r_PtxRegister1747 & 2147483644;										   // PTX L3283
	r_PtxRegister1749 = uint32_t(r_LaneIndexAtPtx3278) - uint32_t(r_PtxRegister1748);		   // PTX L3284
	r_PtxRegister1750 = ShiftLeft(uint32_t(r_PtxRegister1749), uint32_t(1));				   // PTX L3285
	r_PtxRegister1751 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1750);			   // PTX L3286
	r_PtxRegister1752 = ShiftRightSigned(int32_t(r_PtxRegister1751), uint32_t(1));			   // PTX L3287
	r_PtxU64Register231 = uint64_t(int64_t(int32_t(r_PtxRegister1752)) * int64_t(int32_t(4))); // PTX L3288
	g_RecordByteAddressAtPtx3289 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register231); // PTX L3289
	r_PtxRegister1204 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3289 + 262144ull);		   // PTX L3290
	r_LaneIndexAtPtx3292 = uint32_t((threadIdx.x & 31u));									   // PTX L3292
	r_PtxRegister1753 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3292), uint32_t(31));		   // PTX L3294
	r_PtxRegister1754 = ShiftRight(uint32_t(r_PtxRegister1753), uint32_t(30));				   // PTX L3295
	r_PtxRegister1755 = uint32_t(r_LaneIndexAtPtx3292) + uint32_t(r_PtxRegister1754);		   // PTX L3296
	r_PtxRegister1756 = r_PtxRegister1755 & 2147483644;										   // PTX L3297
	r_PtxRegister1757 = uint32_t(r_LaneIndexAtPtx3292) - uint32_t(r_PtxRegister1756);		   // PTX L3298
	r_PtxRegister1758 = ShiftLeft(uint32_t(r_PtxRegister1757), uint32_t(1));				   // PTX L3299
	r_PtxRegister1759 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister1758);			   // PTX L3300
	r_PtxRegister1760 = ShiftRightSigned(int32_t(r_PtxRegister1759), uint32_t(1));			   // PTX L3301
	r_PtxU64Register233 = uint64_t(int64_t(int32_t(r_PtxRegister1760)) * int64_t(int32_t(4))); // PTX L3302
	g_RecordByteAddressAtPtx3303 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register233); // PTX L3303
	r_PtxRegister1207 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3303 + 262144ull);		   // PTX L3304
	r_LaneIndexAtPtx3306 = uint32_t((threadIdx.x & 31u));									   // PTX L3306
	r_PtxRegister1761 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3306), uint32_t(31));		   // PTX L3308
	r_PtxRegister1762 = ShiftRight(uint32_t(r_PtxRegister1761), uint32_t(30));				   // PTX L3309
	r_PtxRegister1763 = uint32_t(r_LaneIndexAtPtx3306) + uint32_t(r_PtxRegister1762);		   // PTX L3310
	r_PtxRegister1764 = r_PtxRegister1763 & 2147483644;										   // PTX L3311
	r_PtxRegister1765 = uint32_t(r_LaneIndexAtPtx3306) - uint32_t(r_PtxRegister1764);		   // PTX L3312
	r_PtxRegister1766 = ShiftLeft(uint32_t(r_PtxRegister1765), uint32_t(1));				   // PTX L3313
	r_PtxRegister1767 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1766);			   // PTX L3314
	r_PtxRegister1768 = ShiftRight(uint32_t(r_PtxRegister1767), uint32_t(31));				   // PTX L3315
	r_PtxRegister1769 = uint32_t(r_PtxRegister1767) + uint32_t(r_PtxRegister1768);			   // PTX L3316
	r_PtxRegister1770 = ShiftRightSigned(int32_t(r_PtxRegister1769), uint32_t(1));			   // PTX L3317
	r_PtxU64Register235 = uint64_t(int64_t(int32_t(r_PtxRegister1770)) * int64_t(int32_t(4))); // PTX L3318
	g_RecordByteAddressAtPtx3319 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register235); // PTX L3319
	r_PtxRegister1210 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3319 + 262144ull);		   // PTX L3320
	r_LaneIndexAtPtx3322 = uint32_t((threadIdx.x & 31u));									   // PTX L3322
	r_PtxRegister1771 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3322), uint32_t(31));		   // PTX L3324
	r_PtxRegister1772 = ShiftRight(uint32_t(r_PtxRegister1771), uint32_t(30));				   // PTX L3325
	r_PtxRegister1773 = uint32_t(r_LaneIndexAtPtx3322) + uint32_t(r_PtxRegister1772);		   // PTX L3326
	r_PtxRegister1774 = r_PtxRegister1773 & 2147483644;										   // PTX L3327
	r_PtxRegister1775 = uint32_t(r_LaneIndexAtPtx3322) - uint32_t(r_PtxRegister1774);		   // PTX L3328
	r_PtxRegister1776 = ShiftLeft(uint32_t(r_PtxRegister1775), uint32_t(1));				   // PTX L3329
	r_PtxRegister1777 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister1776);			   // PTX L3330
	r_PtxRegister1778 = ShiftRight(uint32_t(r_PtxRegister1777), uint32_t(31));				   // PTX L3331
	r_PtxRegister1779 = uint32_t(r_PtxRegister1777) + uint32_t(r_PtxRegister1778);			   // PTX L3332
	r_PtxRegister1780 = ShiftRightSigned(int32_t(r_PtxRegister1779), uint32_t(1));			   // PTX L3333
	r_PtxU64Register237 = uint64_t(int64_t(int32_t(r_PtxRegister1780)) * int64_t(int32_t(4))); // PTX L3334
	g_RecordByteAddressAtPtx3335 =
		uint64_t(g_RecordByteAddressAtPtx2386) + uint64_t(r_PtxU64Register237); // PTX L3335
	r_PtxRegister1213 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3335 + 262144ull);	   // PTX L3336
	r_LaneIndexAtPtx3338 = uint32_t((threadIdx.x & 31u));								   // PTX L3338
	r_PackedHalf2AtPtx3341R2139 = HalfMul(r_PackedHalf2AtPtx2194R1023, r_PtxRegister1024); // PTX L3341
	r_LaneIndexAtPtx3345 = uint32_t((threadIdx.x & 31u));								   // PTX L3345
	r_PackedHalf2AtPtx3348R2138 = HalfMul(r_PackedHalf2AtPtx2200R1026, r_PtxRegister1027); // PTX L3348
	r_LaneIndexAtPtx3352 = uint32_t((threadIdx.x & 31u));								   // PTX L3352
	r_PackedHalf2AtPtx3355R2137 = HalfMul(r_PackedHalf2AtPtx2197R1029, r_PtxRegister1030); // PTX L3355
	r_LaneIndexAtPtx3359 = uint32_t((threadIdx.x & 31u));								   // PTX L3359
	r_PackedHalf2AtPtx3362R2136 = HalfMul(r_PackedHalf2AtPtx2203R1032, r_PtxRegister1033); // PTX L3362
	r_LaneIndexAtPtx3366 = uint32_t((threadIdx.x & 31u));								   // PTX L3366
	r_PackedHalf2AtPtx3369R2135 = HalfMul(r_PackedHalf2AtPtx2206R1035, r_PtxRegister1036); // PTX L3369
	r_LaneIndexAtPtx3373 = uint32_t((threadIdx.x & 31u));								   // PTX L3373
	r_PackedHalf2AtPtx3376R2134 = HalfMul(r_PackedHalf2AtPtx2212R1038, r_PtxRegister1039); // PTX L3376
	r_LaneIndexAtPtx3380 = uint32_t((threadIdx.x & 31u));								   // PTX L3380
	r_PackedHalf2AtPtx3383R2133 = HalfMul(r_PackedHalf2AtPtx2209R1041, r_PtxRegister1042); // PTX L3383
	r_LaneIndexAtPtx3387 = uint32_t((threadIdx.x & 31u));								   // PTX L3387
	r_PackedHalf2AtPtx3390R2132 = HalfMul(r_PackedHalf2AtPtx2215R1044, r_PtxRegister1045); // PTX L3390
	r_LaneIndexAtPtx3394 = uint32_t((threadIdx.x & 31u));								   // PTX L3394
	r_PackedHalf2AtPtx3397R2131 = HalfMul(r_PackedHalf2AtPtx2218R1047, r_PtxRegister1048); // PTX L3397
	r_LaneIndexAtPtx3401 = uint32_t((threadIdx.x & 31u));								   // PTX L3401
	r_PackedHalf2AtPtx3404R2130 = HalfMul(r_PackedHalf2AtPtx2224R1050, r_PtxRegister1051); // PTX L3404
	r_LaneIndexAtPtx3408 = uint32_t((threadIdx.x & 31u));								   // PTX L3408
	r_PackedHalf2AtPtx3411R2129 = HalfMul(r_PackedHalf2AtPtx2221R1053, r_PtxRegister1054); // PTX L3411
	r_LaneIndexAtPtx3415 = uint32_t((threadIdx.x & 31u));								   // PTX L3415
	r_PackedHalf2AtPtx3418R2128 = HalfMul(r_PackedHalf2AtPtx2227R1056, r_PtxRegister1057); // PTX L3418
	r_LaneIndexAtPtx3422 = uint32_t((threadIdx.x & 31u));								   // PTX L3422
	r_PackedHalf2AtPtx3425R2127 = HalfMul(r_PackedHalf2AtPtx2230R1059, r_PtxRegister1060); // PTX L3425
	r_LaneIndexAtPtx3429 = uint32_t((threadIdx.x & 31u));								   // PTX L3429
	r_PackedHalf2AtPtx3432R2126 = HalfMul(r_PackedHalf2AtPtx2236R1062, r_PtxRegister1063); // PTX L3432
	r_LaneIndexAtPtx3436 = uint32_t((threadIdx.x & 31u));								   // PTX L3436
	r_PackedHalf2AtPtx3439R2125 = HalfMul(r_PackedHalf2AtPtx2233R1065, r_PtxRegister1066); // PTX L3439
	r_LaneIndexAtPtx3443 = uint32_t((threadIdx.x & 31u));								   // PTX L3443
	r_PackedHalf2AtPtx3446R2124 = HalfMul(r_PackedHalf2AtPtx2239R1068, r_PtxRegister1069); // PTX L3446
	r_LaneIndexAtPtx3450 = uint32_t((threadIdx.x & 31u));								   // PTX L3450
	r_PackedHalf2AtPtx3453R2123 = HalfMul(r_PackedHalf2AtPtx2242R1071, r_PtxRegister1072); // PTX L3453
	r_LaneIndexAtPtx3457 = uint32_t((threadIdx.x & 31u));								   // PTX L3457
	r_PackedHalf2AtPtx3460R2122 = HalfMul(r_PackedHalf2AtPtx2248R1074, r_PtxRegister1075); // PTX L3460
	r_LaneIndexAtPtx3464 = uint32_t((threadIdx.x & 31u));								   // PTX L3464
	r_PackedHalf2AtPtx3467R2121 = HalfMul(r_PackedHalf2AtPtx2245R1077, r_PtxRegister1078); // PTX L3467
	r_LaneIndexAtPtx3471 = uint32_t((threadIdx.x & 31u));								   // PTX L3471
	r_PackedHalf2AtPtx3474R2120 = HalfMul(r_PackedHalf2AtPtx2251R1080, r_PtxRegister1081); // PTX L3474
	r_LaneIndexAtPtx3478 = uint32_t((threadIdx.x & 31u));								   // PTX L3478
	r_PackedHalf2AtPtx3481R2119 = HalfMul(r_PackedHalf2AtPtx2254R1083, r_PtxRegister1084); // PTX L3481
	r_LaneIndexAtPtx3485 = uint32_t((threadIdx.x & 31u));								   // PTX L3485
	r_PackedHalf2AtPtx3488R2118 = HalfMul(r_PackedHalf2AtPtx2260R1086, r_PtxRegister1087); // PTX L3488
	r_LaneIndexAtPtx3492 = uint32_t((threadIdx.x & 31u));								   // PTX L3492
	r_PackedHalf2AtPtx3495R2117 = HalfMul(r_PackedHalf2AtPtx2257R1089, r_PtxRegister1090); // PTX L3495
	r_LaneIndexAtPtx3499 = uint32_t((threadIdx.x & 31u));								   // PTX L3499
	r_PackedHalf2AtPtx3502R2116 = HalfMul(r_PackedHalf2AtPtx2263R1092, r_PtxRegister1093); // PTX L3502
	r_LaneIndexAtPtx3506 = uint32_t((threadIdx.x & 31u));								   // PTX L3506
	r_PackedHalf2AtPtx3509R2115 = HalfMul(r_PackedHalf2AtPtx2266R1095, r_PtxRegister1096); // PTX L3509
	r_LaneIndexAtPtx3513 = uint32_t((threadIdx.x & 31u));								   // PTX L3513
	r_PackedHalf2AtPtx3516R2114 = HalfMul(r_PackedHalf2AtPtx2272R1098, r_PtxRegister1099); // PTX L3516
	r_LaneIndexAtPtx3520 = uint32_t((threadIdx.x & 31u));								   // PTX L3520
	r_PackedHalf2AtPtx3523R2113 = HalfMul(r_PackedHalf2AtPtx2269R1101, r_PtxRegister1102); // PTX L3523
	r_LaneIndexAtPtx3527 = uint32_t((threadIdx.x & 31u));								   // PTX L3527
	r_PackedHalf2AtPtx3530R2112 = HalfMul(r_PackedHalf2AtPtx2275R1104, r_PtxRegister1105); // PTX L3530
	r_LaneIndexAtPtx3534 = uint32_t((threadIdx.x & 31u));								   // PTX L3534
	r_PackedHalf2AtPtx3537R2111 = HalfMul(r_PackedHalf2AtPtx2278R1107, r_PtxRegister1108); // PTX L3537
	r_LaneIndexAtPtx3541 = uint32_t((threadIdx.x & 31u));								   // PTX L3541
	r_PackedHalf2AtPtx3544R2110 = HalfMul(r_PackedHalf2AtPtx2284R1110, r_PtxRegister1111); // PTX L3544
	r_LaneIndexAtPtx3548 = uint32_t((threadIdx.x & 31u));								   // PTX L3548
	r_PackedHalf2AtPtx3551R2109 = HalfMul(r_PackedHalf2AtPtx2281R1113, r_PtxRegister1114); // PTX L3551
	r_LaneIndexAtPtx3555 = uint32_t((threadIdx.x & 31u));								   // PTX L3555
	r_PackedHalf2AtPtx3558R2108 = HalfMul(r_PackedHalf2AtPtx2287R1116, r_PtxRegister1117); // PTX L3558
	r_LaneIndexAtPtx3562 = uint32_t((threadIdx.x & 31u));								   // PTX L3562
	r_PackedHalf2AtPtx3565R2107 = HalfMul(r_PackedHalf2AtPtx2290R1119, r_PtxRegister1120); // PTX L3565
	r_LaneIndexAtPtx3569 = uint32_t((threadIdx.x & 31u));								   // PTX L3569
	r_PackedHalf2AtPtx3572R2106 = HalfMul(r_PackedHalf2AtPtx2296R1122, r_PtxRegister1123); // PTX L3572
	r_LaneIndexAtPtx3576 = uint32_t((threadIdx.x & 31u));								   // PTX L3576
	r_PackedHalf2AtPtx3579R2105 = HalfMul(r_PackedHalf2AtPtx2293R1125, r_PtxRegister1126); // PTX L3579
	r_LaneIndexAtPtx3583 = uint32_t((threadIdx.x & 31u));								   // PTX L3583
	r_PackedHalf2AtPtx3586R2104 = HalfMul(r_PackedHalf2AtPtx2299R1128, r_PtxRegister1129); // PTX L3586
	r_LaneIndexAtPtx3590 = uint32_t((threadIdx.x & 31u));								   // PTX L3590
	r_PackedHalf2AtPtx3593R2103 = HalfMul(r_PackedHalf2AtPtx2302R1131, r_PtxRegister1132); // PTX L3593
	r_LaneIndexAtPtx3597 = uint32_t((threadIdx.x & 31u));								   // PTX L3597
	r_PackedHalf2AtPtx3600R2102 = HalfMul(r_PackedHalf2AtPtx2308R1134, r_PtxRegister1135); // PTX L3600
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));								   // PTX L3604
	r_PackedHalf2AtPtx3607R2101 = HalfMul(r_PackedHalf2AtPtx2305R1137, r_PtxRegister1138); // PTX L3607
	r_LaneIndexAtPtx3611 = uint32_t((threadIdx.x & 31u));								   // PTX L3611
	r_PackedHalf2AtPtx3614R2100 = HalfMul(r_PackedHalf2AtPtx2311R1140, r_PtxRegister1141); // PTX L3614
	r_LaneIndexAtPtx3618 = uint32_t((threadIdx.x & 31u));								   // PTX L3618
	r_PackedHalf2AtPtx3621R2099 = HalfMul(r_PackedHalf2AtPtx2314R1143, r_PtxRegister1144); // PTX L3621
	r_LaneIndexAtPtx3625 = uint32_t((threadIdx.x & 31u));								   // PTX L3625
	r_PackedHalf2AtPtx3628R2098 = HalfMul(r_PackedHalf2AtPtx2320R1146, r_PtxRegister1147); // PTX L3628
	r_LaneIndexAtPtx3632 = uint32_t((threadIdx.x & 31u));								   // PTX L3632
	r_PackedHalf2AtPtx3635R2097 = HalfMul(r_PackedHalf2AtPtx2317R1149, r_PtxRegister1150); // PTX L3635
	r_LaneIndexAtPtx3639 = uint32_t((threadIdx.x & 31u));								   // PTX L3639
	r_PackedHalf2AtPtx3642R2096 = HalfMul(r_PackedHalf2AtPtx2323R1152, r_PtxRegister1153); // PTX L3642
	r_LaneIndexAtPtx3646 = uint32_t((threadIdx.x & 31u));								   // PTX L3646
	r_PackedHalf2AtPtx3649R2095 = HalfMul(r_PackedHalf2AtPtx2326R1155, r_PtxRegister1156); // PTX L3649
	r_LaneIndexAtPtx3653 = uint32_t((threadIdx.x & 31u));								   // PTX L3653
	r_PackedHalf2AtPtx3656R2094 = HalfMul(r_PackedHalf2AtPtx2332R1158, r_PtxRegister1159); // PTX L3656
	r_LaneIndexAtPtx3660 = uint32_t((threadIdx.x & 31u));								   // PTX L3660
	r_PackedHalf2AtPtx3663R2093 = HalfMul(r_PackedHalf2AtPtx2329R1161, r_PtxRegister1162); // PTX L3663
	r_LaneIndexAtPtx3667 = uint32_t((threadIdx.x & 31u));								   // PTX L3667
	r_PackedHalf2AtPtx3670R2092 = HalfMul(r_PackedHalf2AtPtx2335R1164, r_PtxRegister1165); // PTX L3670
	r_LaneIndexAtPtx3674 = uint32_t((threadIdx.x & 31u));								   // PTX L3674
	r_PackedHalf2AtPtx3677R2091 = HalfMul(r_PackedHalf2AtPtx2338R1167, r_PtxRegister1168); // PTX L3677
	r_LaneIndexAtPtx3681 = uint32_t((threadIdx.x & 31u));								   // PTX L3681
	r_PackedHalf2AtPtx3684R2090 = HalfMul(r_PackedHalf2AtPtx2344R1170, r_PtxRegister1171); // PTX L3684
	r_LaneIndexAtPtx3688 = uint32_t((threadIdx.x & 31u));								   // PTX L3688
	r_PackedHalf2AtPtx3691R2089 = HalfMul(r_PackedHalf2AtPtx2341R1173, r_PtxRegister1174); // PTX L3691
	r_LaneIndexAtPtx3695 = uint32_t((threadIdx.x & 31u));								   // PTX L3695
	r_PackedHalf2AtPtx3698R2088 = HalfMul(r_PackedHalf2AtPtx2347R1176, r_PtxRegister1177); // PTX L3698
	r_LaneIndexAtPtx3702 = uint32_t((threadIdx.x & 31u));								   // PTX L3702
	r_PackedHalf2AtPtx3705R2087 = HalfMul(r_PackedHalf2AtPtx2350R1179, r_PtxRegister1180); // PTX L3705
	r_LaneIndexAtPtx3709 = uint32_t((threadIdx.x & 31u));								   // PTX L3709
	r_PackedHalf2AtPtx3712R2086 = HalfMul(r_PackedHalf2AtPtx2356R1182, r_PtxRegister1183); // PTX L3712
	r_LaneIndexAtPtx3716 = uint32_t((threadIdx.x & 31u));								   // PTX L3716
	r_PackedHalf2AtPtx3719R2085 = HalfMul(r_PackedHalf2AtPtx2353R1185, r_PtxRegister1186); // PTX L3719
	r_LaneIndexAtPtx3723 = uint32_t((threadIdx.x & 31u));								   // PTX L3723
	r_PackedHalf2AtPtx3726R2084 = HalfMul(r_PackedHalf2AtPtx2359R1188, r_PtxRegister1189); // PTX L3726
	r_LaneIndexAtPtx3730 = uint32_t((threadIdx.x & 31u));								   // PTX L3730
	r_PackedHalf2AtPtx3733R2083 = HalfMul(r_PackedHalf2AtPtx2362R1191, r_PtxRegister1192); // PTX L3733
	r_LaneIndexAtPtx3737 = uint32_t((threadIdx.x & 31u));								   // PTX L3737
	r_PackedHalf2AtPtx3740R2082 = HalfMul(r_PackedHalf2AtPtx2368R1194, r_PtxRegister1195); // PTX L3740
	r_LaneIndexAtPtx3744 = uint32_t((threadIdx.x & 31u));								   // PTX L3744
	r_PackedHalf2AtPtx3747R2081 = HalfMul(r_PackedHalf2AtPtx2365R1197, r_PtxRegister1198); // PTX L3747
	r_LaneIndexAtPtx3751 = uint32_t((threadIdx.x & 31u));								   // PTX L3751
	r_PackedHalf2AtPtx3754R2080 = HalfMul(r_PackedHalf2AtPtx2371R1200, r_PtxRegister1201); // PTX L3754
	r_LaneIndexAtPtx3758 = uint32_t((threadIdx.x & 31u));								   // PTX L3758
	r_PackedHalf2AtPtx3761R2079 = HalfMul(r_PackedHalf2AtPtx2374R1203, r_PtxRegister1204); // PTX L3761
	r_LaneIndexAtPtx3765 = uint32_t((threadIdx.x & 31u));								   // PTX L3765
	r_PackedHalf2AtPtx3768R2078 = HalfMul(r_PackedHalf2AtPtx2381R1206, r_PtxRegister1207); // PTX L3768
	r_LaneIndexAtPtx3772 = uint32_t((threadIdx.x & 31u));								   // PTX L3772
	r_PackedHalf2AtPtx3775R2077 = HalfMul(r_PackedHalf2AtPtx2377R1209, r_PtxRegister1210); // PTX L3775
	r_LaneIndexAtPtx3779 = uint32_t((threadIdx.x & 31u));								   // PTX L3779
	r_PackedHalf2AtPtx3782R2076 = HalfMul(r_PackedHalf2AtPtx2384R1212, r_PtxRegister1213); // PTX L3782
	r_bPtxPredicate36 = int32_t(r_PtxRegister170) < int32_t(r_HeightDiv4Bits);			   // PTX L3785
	r_PtxRegister2140 = uint32_t(0);													   // PTX L3786
L__BB19_135:																			   // PTX L3787
	r_PtxRegister1893 = ShiftRight(uint32_t(r_PtxRegister2140), uint32_t(6));			   // PTX L3788
	r_PtxU16Register77 = uint16_t(r_PtxRegister1893);									   // PTX L3789
	r_PtxU16Register78 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register77)) * uint32_t(uint16_t(171))); // PTX L3790
	r_PtxU16Register79 = ShiftRight(uint16_t(r_PtxU16Register78), uint32_t(9));		// PTX L3791
	r_PtxU16Register80 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register79)) * uint32_t(uint16_t(3)));		   // PTX L3792
	r_PtxU16Register81 = uint16_t(r_PtxU16Register77) - uint16_t(r_PtxU16Register80);	   // PTX L3793
	r_PtxRegister1894 = uint32_t(uint16_t(r_PtxU16Register81));							   // PTX L3794
	r_PtxRegister93 = r_PtxRegister1894 & 255;											   // PTX L3795
	r_PtxU16Register82 = r_PtxU16Register81 & 255;										   // PTX L3796
	r_PtxRegister1895 = uint32_t(uint16_t(r_PtxU16Register82)) * uint32_t(uint16_t(4096)); // PTX L3797
	r_LaneIndexAtPtx3799 = uint32_t((threadIdx.x & 31u));								   // PTX L3799
	r_PtxRegister1896 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L3801
	r_PtxRegister94 = uint32_t(r_PtxRegister1896) + uint32_t(r_PtxRegister1895);		   // PTX L3802
	r_PtxRegister1897 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3799), uint32_t(4));			   // PTX L3803
	r_PtxRegister1782 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1897);		   // PTX L3804
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1782));
		r_MmaAE4x4WordAtPtx3806R1797 = r_Value.x;
		r_MmaAE4x4WordAtPtx3806R1798 = r_Value.y;
		r_MmaAE4x4WordAtPtx3806R1799 = r_Value.z;
		r_MmaAE4x4WordAtPtx3806R1800 = r_Value.w;
	} // PTX L3806
	r_LaneIndexAtPtx3809 = uint32_t((threadIdx.x & 31u));						 // PTX L3809
	r_PtxRegister1898 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3809), uint32_t(4));	 // PTX L3811
	r_PtxRegister1899 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1898); // PTX L3812
	r_PtxRegister1784 = uint32_t(r_PtxRegister1899) + uint32_t(512);			 // PTX L3813
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1784));
		r_MmaAE4x4WordAtPtx3815R1801 = r_Value.x;
		r_MmaAE4x4WordAtPtx3815R1802 = r_Value.y;
		r_MmaAE4x4WordAtPtx3815R1803 = r_Value.z;
		r_MmaAE4x4WordAtPtx3815R1804 = r_Value.w;
	} // PTX L3815
	r_LaneIndexAtPtx3818 = uint32_t((threadIdx.x & 31u));						 // PTX L3818
	r_PtxRegister1900 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3818), uint32_t(4));	 // PTX L3820
	r_PtxRegister1901 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1900); // PTX L3821
	r_PtxRegister1786 = uint32_t(r_PtxRegister1901) + uint32_t(1024);			 // PTX L3822
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1786));
		r_MmaAE4x4WordAtPtx3824R1821 = r_Value.x;
		r_MmaAE4x4WordAtPtx3824R1822 = r_Value.y;
		r_MmaAE4x4WordAtPtx3824R1823 = r_Value.z;
		r_MmaAE4x4WordAtPtx3824R1824 = r_Value.w;
	} // PTX L3824
	r_LaneIndexAtPtx3827 = uint32_t((threadIdx.x & 31u));						 // PTX L3827
	r_PtxRegister1902 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3827), uint32_t(4));	 // PTX L3829
	r_PtxRegister1903 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1902); // PTX L3830
	r_PtxRegister1788 = uint32_t(r_PtxRegister1903) + uint32_t(1536);			 // PTX L3831
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1788));
		r_MmaAE4x4WordAtPtx3833R1825 = r_Value.x;
		r_MmaAE4x4WordAtPtx3833R1826 = r_Value.y;
		r_MmaAE4x4WordAtPtx3833R1827 = r_Value.z;
		r_MmaAE4x4WordAtPtx3833R1828 = r_Value.w;
	} // PTX L3833
	r_LaneIndexAtPtx3836 = uint32_t((threadIdx.x & 31u));						 // PTX L3836
	r_PtxRegister1904 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3836), uint32_t(4));	 // PTX L3838
	r_PtxRegister1905 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1904); // PTX L3839
	r_PtxRegister1790 = uint32_t(r_PtxRegister1905) + uint32_t(2048);			 // PTX L3840
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1790));
		r_MmaAE4x4WordAtPtx3842R1845 = r_Value.x;
		r_MmaAE4x4WordAtPtx3842R1846 = r_Value.y;
		r_MmaAE4x4WordAtPtx3842R1847 = r_Value.z;
		r_MmaAE4x4WordAtPtx3842R1848 = r_Value.w;
	} // PTX L3842
	r_LaneIndexAtPtx3845 = uint32_t((threadIdx.x & 31u));						 // PTX L3845
	r_PtxRegister1906 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3845), uint32_t(4));	 // PTX L3847
	r_PtxRegister1907 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1906); // PTX L3848
	r_PtxRegister1792 = uint32_t(r_PtxRegister1907) + uint32_t(2560);			 // PTX L3849
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1792));
		r_MmaAE4x4WordAtPtx3851R1849 = r_Value.x;
		r_MmaAE4x4WordAtPtx3851R1850 = r_Value.y;
		r_MmaAE4x4WordAtPtx3851R1851 = r_Value.z;
		r_MmaAE4x4WordAtPtx3851R1852 = r_Value.w;
	} // PTX L3851
	r_LaneIndexAtPtx3854 = uint32_t((threadIdx.x & 31u));						 // PTX L3854
	r_PtxRegister1908 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3854), uint32_t(4));	 // PTX L3856
	r_PtxRegister1909 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1908); // PTX L3857
	r_PtxRegister1794 = uint32_t(r_PtxRegister1909) + uint32_t(3072);			 // PTX L3858
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1794));
		r_MmaAE4x4WordAtPtx3860R1869 = r_Value.x;
		r_MmaAE4x4WordAtPtx3860R1870 = r_Value.y;
		r_MmaAE4x4WordAtPtx3860R1871 = r_Value.z;
		r_MmaAE4x4WordAtPtx3860R1872 = r_Value.w;
	} // PTX L3860
	r_LaneIndexAtPtx3863 = uint32_t((threadIdx.x & 31u));						 // PTX L3863
	r_PtxRegister1910 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3863), uint32_t(4));	 // PTX L3865
	r_PtxRegister1911 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1910); // PTX L3866
	r_PtxRegister1796 = uint32_t(r_PtxRegister1911) + uint32_t(3584);			 // PTX L3867
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1796));
		r_MmaAE4x4WordAtPtx3869R1873 = r_Value.x;
		r_MmaAE4x4WordAtPtx3869R1874 = r_Value.y;
		r_MmaAE4x4WordAtPtx3869R1875 = r_Value.z;
		r_MmaAE4x4WordAtPtx3869R1876 = r_Value.w;
	} // PTX L3869
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3872R1805, r_MmaAccumulatorHalf2WordAtPtx3872R1806,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx80R2170, r_MmaBE4x4WordAtPtx80R2169,
		  r_PackedHalf2AtPtx3341R2139,
		  r_PackedHalf2AtPtx3348R2138); // PTX L3872
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3879R1807, r_MmaAccumulatorHalf2WordAtPtx3879R1808,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx80R2168, r_MmaBE4x4WordAtPtx80R2167,
		  r_PackedHalf2AtPtx3355R2137,
		  r_PackedHalf2AtPtx3362R2136); // PTX L3879
	MmaE4(r_PackedHalf2AtPtx3341R2139, r_PackedHalf2AtPtx3348R2138, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx116R2154, r_MmaBE4x4WordAtPtx116R2153, r_MmaAccumulatorHalf2WordAtPtx3872R1805,
		  r_MmaAccumulatorHalf2WordAtPtx3872R1806); // PTX L3886
	MmaE4(r_PackedHalf2AtPtx3355R2137, r_PackedHalf2AtPtx3362R2136, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx116R2152, r_MmaBE4x4WordAtPtx116R2151, r_MmaAccumulatorHalf2WordAtPtx3879R1807,
		  r_MmaAccumulatorHalf2WordAtPtx3879R1808); // PTX L3893
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3900R1809, r_MmaAccumulatorHalf2WordAtPtx3900R1810,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx89R2166, r_MmaBE4x4WordAtPtx89R2165,
		  r_PackedHalf2AtPtx3369R2135,
		  r_PackedHalf2AtPtx3376R2134); // PTX L3900
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3907R1811, r_MmaAccumulatorHalf2WordAtPtx3907R1812,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx89R2164, r_MmaBE4x4WordAtPtx89R2163,
		  r_PackedHalf2AtPtx3383R2133,
		  r_PackedHalf2AtPtx3390R2132); // PTX L3907
	MmaE4(r_PackedHalf2AtPtx3369R2135, r_PackedHalf2AtPtx3376R2134, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx125R2150, r_MmaBE4x4WordAtPtx125R2149, r_MmaAccumulatorHalf2WordAtPtx3900R1809,
		  r_MmaAccumulatorHalf2WordAtPtx3900R1810); // PTX L3914
	MmaE4(r_PackedHalf2AtPtx3383R2133, r_PackedHalf2AtPtx3390R2132, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx125R2148, r_MmaBE4x4WordAtPtx125R2147, r_MmaAccumulatorHalf2WordAtPtx3907R1811,
		  r_MmaAccumulatorHalf2WordAtPtx3907R1812); // PTX L3921
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3928R1813, r_MmaAccumulatorHalf2WordAtPtx3928R1814,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx98R2162, r_MmaBE4x4WordAtPtx98R2161,
		  r_PackedHalf2AtPtx3397R2131,
		  r_PackedHalf2AtPtx3404R2130); // PTX L3928
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3935R1815, r_MmaAccumulatorHalf2WordAtPtx3935R1816,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx98R2160, r_MmaBE4x4WordAtPtx98R2159,
		  r_PackedHalf2AtPtx3411R2129,
		  r_PackedHalf2AtPtx3418R2128); // PTX L3935
	MmaE4(r_PackedHalf2AtPtx3397R2131, r_PackedHalf2AtPtx3404R2130, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx134R2146, r_MmaBE4x4WordAtPtx134R2145, r_MmaAccumulatorHalf2WordAtPtx3928R1813,
		  r_MmaAccumulatorHalf2WordAtPtx3928R1814); // PTX L3942
	MmaE4(r_PackedHalf2AtPtx3411R2129, r_PackedHalf2AtPtx3418R2128, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx134R2144, r_MmaBE4x4WordAtPtx134R2143, r_MmaAccumulatorHalf2WordAtPtx3935R1815,
		  r_MmaAccumulatorHalf2WordAtPtx3935R1816); // PTX L3949
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3956R1817, r_MmaAccumulatorHalf2WordAtPtx3956R1818,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx107R2158, r_MmaBE4x4WordAtPtx107R2157,
		  r_PackedHalf2AtPtx3425R2127,
		  r_PackedHalf2AtPtx3432R2126); // PTX L3956
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3963R1819, r_MmaAccumulatorHalf2WordAtPtx3963R1820,
		  r_MmaAE4x4WordAtPtx3806R1797, r_MmaAE4x4WordAtPtx3806R1798, r_MmaAE4x4WordAtPtx3806R1799,
		  r_MmaAE4x4WordAtPtx3806R1800, r_MmaBE4x4WordAtPtx107R2156, r_MmaBE4x4WordAtPtx107R2155,
		  r_PackedHalf2AtPtx3439R2125,
		  r_PackedHalf2AtPtx3446R2124); // PTX L3963
	MmaE4(r_PackedHalf2AtPtx3425R2127, r_PackedHalf2AtPtx3432R2126, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx143R2142, r_MmaBE4x4WordAtPtx143R2141, r_MmaAccumulatorHalf2WordAtPtx3956R1817,
		  r_MmaAccumulatorHalf2WordAtPtx3956R1818); // PTX L3970
	MmaE4(r_PackedHalf2AtPtx3439R2125, r_PackedHalf2AtPtx3446R2124, r_MmaAE4x4WordAtPtx3815R1801,
		  r_MmaAE4x4WordAtPtx3815R1802, r_MmaAE4x4WordAtPtx3815R1803, r_MmaAE4x4WordAtPtx3815R1804,
		  r_MmaBE4x4WordAtPtx143R2171, r_MmaBE4x4WordAtPtx143R2172, r_MmaAccumulatorHalf2WordAtPtx3963R1819,
		  r_MmaAccumulatorHalf2WordAtPtx3963R1820); // PTX L3977
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3984R1829, r_MmaAccumulatorHalf2WordAtPtx3984R1830,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx80R2170, r_MmaBE4x4WordAtPtx80R2169,
		  r_PackedHalf2AtPtx3453R2123,
		  r_PackedHalf2AtPtx3460R2122); // PTX L3984
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3991R1831, r_MmaAccumulatorHalf2WordAtPtx3991R1832,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx80R2168, r_MmaBE4x4WordAtPtx80R2167,
		  r_PackedHalf2AtPtx3467R2121,
		  r_PackedHalf2AtPtx3474R2120); // PTX L3991
	MmaE4(r_PackedHalf2AtPtx3453R2123, r_PackedHalf2AtPtx3460R2122, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx116R2154, r_MmaBE4x4WordAtPtx116R2153, r_MmaAccumulatorHalf2WordAtPtx3984R1829,
		  r_MmaAccumulatorHalf2WordAtPtx3984R1830); // PTX L3998
	MmaE4(r_PackedHalf2AtPtx3467R2121, r_PackedHalf2AtPtx3474R2120, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx116R2152, r_MmaBE4x4WordAtPtx116R2151, r_MmaAccumulatorHalf2WordAtPtx3991R1831,
		  r_MmaAccumulatorHalf2WordAtPtx3991R1832); // PTX L4005
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4012R1833, r_MmaAccumulatorHalf2WordAtPtx4012R1834,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx89R2166, r_MmaBE4x4WordAtPtx89R2165,
		  r_PackedHalf2AtPtx3481R2119,
		  r_PackedHalf2AtPtx3488R2118); // PTX L4012
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4019R1835, r_MmaAccumulatorHalf2WordAtPtx4019R1836,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx89R2164, r_MmaBE4x4WordAtPtx89R2163,
		  r_PackedHalf2AtPtx3495R2117,
		  r_PackedHalf2AtPtx3502R2116); // PTX L4019
	MmaE4(r_PackedHalf2AtPtx3481R2119, r_PackedHalf2AtPtx3488R2118, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx125R2150, r_MmaBE4x4WordAtPtx125R2149, r_MmaAccumulatorHalf2WordAtPtx4012R1833,
		  r_MmaAccumulatorHalf2WordAtPtx4012R1834); // PTX L4026
	MmaE4(r_PackedHalf2AtPtx3495R2117, r_PackedHalf2AtPtx3502R2116, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx125R2148, r_MmaBE4x4WordAtPtx125R2147, r_MmaAccumulatorHalf2WordAtPtx4019R1835,
		  r_MmaAccumulatorHalf2WordAtPtx4019R1836); // PTX L4033
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4040R1837, r_MmaAccumulatorHalf2WordAtPtx4040R1838,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx98R2162, r_MmaBE4x4WordAtPtx98R2161,
		  r_PackedHalf2AtPtx3509R2115,
		  r_PackedHalf2AtPtx3516R2114); // PTX L4040
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4047R1839, r_MmaAccumulatorHalf2WordAtPtx4047R1840,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx98R2160, r_MmaBE4x4WordAtPtx98R2159,
		  r_PackedHalf2AtPtx3523R2113,
		  r_PackedHalf2AtPtx3530R2112); // PTX L4047
	MmaE4(r_PackedHalf2AtPtx3509R2115, r_PackedHalf2AtPtx3516R2114, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx134R2146, r_MmaBE4x4WordAtPtx134R2145, r_MmaAccumulatorHalf2WordAtPtx4040R1837,
		  r_MmaAccumulatorHalf2WordAtPtx4040R1838); // PTX L4054
	MmaE4(r_PackedHalf2AtPtx3523R2113, r_PackedHalf2AtPtx3530R2112, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx134R2144, r_MmaBE4x4WordAtPtx134R2143, r_MmaAccumulatorHalf2WordAtPtx4047R1839,
		  r_MmaAccumulatorHalf2WordAtPtx4047R1840); // PTX L4061
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4068R1841, r_MmaAccumulatorHalf2WordAtPtx4068R1842,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx107R2158, r_MmaBE4x4WordAtPtx107R2157,
		  r_PackedHalf2AtPtx3537R2111,
		  r_PackedHalf2AtPtx3544R2110); // PTX L4068
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4075R1843, r_MmaAccumulatorHalf2WordAtPtx4075R1844,
		  r_MmaAE4x4WordAtPtx3824R1821, r_MmaAE4x4WordAtPtx3824R1822, r_MmaAE4x4WordAtPtx3824R1823,
		  r_MmaAE4x4WordAtPtx3824R1824, r_MmaBE4x4WordAtPtx107R2156, r_MmaBE4x4WordAtPtx107R2155,
		  r_PackedHalf2AtPtx3551R2109,
		  r_PackedHalf2AtPtx3558R2108); // PTX L4075
	MmaE4(r_PackedHalf2AtPtx3537R2111, r_PackedHalf2AtPtx3544R2110, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx143R2142, r_MmaBE4x4WordAtPtx143R2141, r_MmaAccumulatorHalf2WordAtPtx4068R1841,
		  r_MmaAccumulatorHalf2WordAtPtx4068R1842); // PTX L4082
	MmaE4(r_PackedHalf2AtPtx3551R2109, r_PackedHalf2AtPtx3558R2108, r_MmaAE4x4WordAtPtx3833R1825,
		  r_MmaAE4x4WordAtPtx3833R1826, r_MmaAE4x4WordAtPtx3833R1827, r_MmaAE4x4WordAtPtx3833R1828,
		  r_MmaBE4x4WordAtPtx143R2171, r_MmaBE4x4WordAtPtx143R2172, r_MmaAccumulatorHalf2WordAtPtx4075R1843,
		  r_MmaAccumulatorHalf2WordAtPtx4075R1844); // PTX L4089
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4096R1853, r_MmaAccumulatorHalf2WordAtPtx4096R1854,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx80R2170, r_MmaBE4x4WordAtPtx80R2169,
		  r_PackedHalf2AtPtx3565R2107,
		  r_PackedHalf2AtPtx3572R2106); // PTX L4096
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4103R1855, r_MmaAccumulatorHalf2WordAtPtx4103R1856,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx80R2168, r_MmaBE4x4WordAtPtx80R2167,
		  r_PackedHalf2AtPtx3579R2105,
		  r_PackedHalf2AtPtx3586R2104); // PTX L4103
	MmaE4(r_PackedHalf2AtPtx3565R2107, r_PackedHalf2AtPtx3572R2106, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx116R2154, r_MmaBE4x4WordAtPtx116R2153, r_MmaAccumulatorHalf2WordAtPtx4096R1853,
		  r_MmaAccumulatorHalf2WordAtPtx4096R1854); // PTX L4110
	MmaE4(r_PackedHalf2AtPtx3579R2105, r_PackedHalf2AtPtx3586R2104, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx116R2152, r_MmaBE4x4WordAtPtx116R2151, r_MmaAccumulatorHalf2WordAtPtx4103R1855,
		  r_MmaAccumulatorHalf2WordAtPtx4103R1856); // PTX L4117
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4124R1857, r_MmaAccumulatorHalf2WordAtPtx4124R1858,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx89R2166, r_MmaBE4x4WordAtPtx89R2165,
		  r_PackedHalf2AtPtx3593R2103,
		  r_PackedHalf2AtPtx3600R2102); // PTX L4124
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4131R1859, r_MmaAccumulatorHalf2WordAtPtx4131R1860,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx89R2164, r_MmaBE4x4WordAtPtx89R2163,
		  r_PackedHalf2AtPtx3607R2101,
		  r_PackedHalf2AtPtx3614R2100); // PTX L4131
	MmaE4(r_PackedHalf2AtPtx3593R2103, r_PackedHalf2AtPtx3600R2102, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx125R2150, r_MmaBE4x4WordAtPtx125R2149, r_MmaAccumulatorHalf2WordAtPtx4124R1857,
		  r_MmaAccumulatorHalf2WordAtPtx4124R1858); // PTX L4138
	MmaE4(r_PackedHalf2AtPtx3607R2101, r_PackedHalf2AtPtx3614R2100, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx125R2148, r_MmaBE4x4WordAtPtx125R2147, r_MmaAccumulatorHalf2WordAtPtx4131R1859,
		  r_MmaAccumulatorHalf2WordAtPtx4131R1860); // PTX L4145
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4152R1861, r_MmaAccumulatorHalf2WordAtPtx4152R1862,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx98R2162, r_MmaBE4x4WordAtPtx98R2161,
		  r_PackedHalf2AtPtx3621R2099,
		  r_PackedHalf2AtPtx3628R2098); // PTX L4152
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4159R1863, r_MmaAccumulatorHalf2WordAtPtx4159R1864,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx98R2160, r_MmaBE4x4WordAtPtx98R2159,
		  r_PackedHalf2AtPtx3635R2097,
		  r_PackedHalf2AtPtx3642R2096); // PTX L4159
	MmaE4(r_PackedHalf2AtPtx3621R2099, r_PackedHalf2AtPtx3628R2098, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx134R2146, r_MmaBE4x4WordAtPtx134R2145, r_MmaAccumulatorHalf2WordAtPtx4152R1861,
		  r_MmaAccumulatorHalf2WordAtPtx4152R1862); // PTX L4166
	MmaE4(r_PackedHalf2AtPtx3635R2097, r_PackedHalf2AtPtx3642R2096, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx134R2144, r_MmaBE4x4WordAtPtx134R2143, r_MmaAccumulatorHalf2WordAtPtx4159R1863,
		  r_MmaAccumulatorHalf2WordAtPtx4159R1864); // PTX L4173
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4180R1865, r_MmaAccumulatorHalf2WordAtPtx4180R1866,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx107R2158, r_MmaBE4x4WordAtPtx107R2157,
		  r_PackedHalf2AtPtx3649R2095,
		  r_PackedHalf2AtPtx3656R2094); // PTX L4180
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4187R1867, r_MmaAccumulatorHalf2WordAtPtx4187R1868,
		  r_MmaAE4x4WordAtPtx3842R1845, r_MmaAE4x4WordAtPtx3842R1846, r_MmaAE4x4WordAtPtx3842R1847,
		  r_MmaAE4x4WordAtPtx3842R1848, r_MmaBE4x4WordAtPtx107R2156, r_MmaBE4x4WordAtPtx107R2155,
		  r_PackedHalf2AtPtx3663R2093,
		  r_PackedHalf2AtPtx3670R2092); // PTX L4187
	MmaE4(r_PackedHalf2AtPtx3649R2095, r_PackedHalf2AtPtx3656R2094, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx143R2142, r_MmaBE4x4WordAtPtx143R2141, r_MmaAccumulatorHalf2WordAtPtx4180R1865,
		  r_MmaAccumulatorHalf2WordAtPtx4180R1866); // PTX L4194
	MmaE4(r_PackedHalf2AtPtx3663R2093, r_PackedHalf2AtPtx3670R2092, r_MmaAE4x4WordAtPtx3851R1849,
		  r_MmaAE4x4WordAtPtx3851R1850, r_MmaAE4x4WordAtPtx3851R1851, r_MmaAE4x4WordAtPtx3851R1852,
		  r_MmaBE4x4WordAtPtx143R2171, r_MmaBE4x4WordAtPtx143R2172, r_MmaAccumulatorHalf2WordAtPtx4187R1867,
		  r_MmaAccumulatorHalf2WordAtPtx4187R1868); // PTX L4201
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4208R1877, r_MmaAccumulatorHalf2WordAtPtx4208R1878,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx80R2170, r_MmaBE4x4WordAtPtx80R2169,
		  r_PackedHalf2AtPtx3677R2091,
		  r_PackedHalf2AtPtx3684R2090); // PTX L4208
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4215R1879, r_MmaAccumulatorHalf2WordAtPtx4215R1880,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx80R2168, r_MmaBE4x4WordAtPtx80R2167,
		  r_PackedHalf2AtPtx3691R2089,
		  r_PackedHalf2AtPtx3698R2088); // PTX L4215
	MmaE4(r_PackedHalf2AtPtx3677R2091, r_PackedHalf2AtPtx3684R2090, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx116R2154, r_MmaBE4x4WordAtPtx116R2153, r_MmaAccumulatorHalf2WordAtPtx4208R1877,
		  r_MmaAccumulatorHalf2WordAtPtx4208R1878); // PTX L4222
	MmaE4(r_PackedHalf2AtPtx3691R2089, r_PackedHalf2AtPtx3698R2088, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx116R2152, r_MmaBE4x4WordAtPtx116R2151, r_MmaAccumulatorHalf2WordAtPtx4215R1879,
		  r_MmaAccumulatorHalf2WordAtPtx4215R1880); // PTX L4229
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4236R1881, r_MmaAccumulatorHalf2WordAtPtx4236R1882,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx89R2166, r_MmaBE4x4WordAtPtx89R2165,
		  r_PackedHalf2AtPtx3705R2087,
		  r_PackedHalf2AtPtx3712R2086); // PTX L4236
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4243R1883, r_MmaAccumulatorHalf2WordAtPtx4243R1884,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx89R2164, r_MmaBE4x4WordAtPtx89R2163,
		  r_PackedHalf2AtPtx3719R2085,
		  r_PackedHalf2AtPtx3726R2084); // PTX L4243
	MmaE4(r_PackedHalf2AtPtx3705R2087, r_PackedHalf2AtPtx3712R2086, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx125R2150, r_MmaBE4x4WordAtPtx125R2149, r_MmaAccumulatorHalf2WordAtPtx4236R1881,
		  r_MmaAccumulatorHalf2WordAtPtx4236R1882); // PTX L4250
	MmaE4(r_PackedHalf2AtPtx3719R2085, r_PackedHalf2AtPtx3726R2084, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx125R2148, r_MmaBE4x4WordAtPtx125R2147, r_MmaAccumulatorHalf2WordAtPtx4243R1883,
		  r_MmaAccumulatorHalf2WordAtPtx4243R1884); // PTX L4257
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4264R1885, r_MmaAccumulatorHalf2WordAtPtx4264R1886,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx98R2162, r_MmaBE4x4WordAtPtx98R2161,
		  r_PackedHalf2AtPtx3733R2083,
		  r_PackedHalf2AtPtx3740R2082); // PTX L4264
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4271R1887, r_MmaAccumulatorHalf2WordAtPtx4271R1888,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx98R2160, r_MmaBE4x4WordAtPtx98R2159,
		  r_PackedHalf2AtPtx3747R2081,
		  r_PackedHalf2AtPtx3754R2080); // PTX L4271
	MmaE4(r_PackedHalf2AtPtx3733R2083, r_PackedHalf2AtPtx3740R2082, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx134R2146, r_MmaBE4x4WordAtPtx134R2145, r_MmaAccumulatorHalf2WordAtPtx4264R1885,
		  r_MmaAccumulatorHalf2WordAtPtx4264R1886); // PTX L4278
	MmaE4(r_PackedHalf2AtPtx3747R2081, r_PackedHalf2AtPtx3754R2080, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx134R2144, r_MmaBE4x4WordAtPtx134R2143, r_MmaAccumulatorHalf2WordAtPtx4271R1887,
		  r_MmaAccumulatorHalf2WordAtPtx4271R1888); // PTX L4285
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4292R1889, r_MmaAccumulatorHalf2WordAtPtx4292R1890,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx107R2158, r_MmaBE4x4WordAtPtx107R2157,
		  r_PackedHalf2AtPtx3761R2079,
		  r_PackedHalf2AtPtx3768R2078); // PTX L4292
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx4299R1891, r_MmaAccumulatorHalf2WordAtPtx4299R1892,
		  r_MmaAE4x4WordAtPtx3860R1869, r_MmaAE4x4WordAtPtx3860R1870, r_MmaAE4x4WordAtPtx3860R1871,
		  r_MmaAE4x4WordAtPtx3860R1872, r_MmaBE4x4WordAtPtx107R2156, r_MmaBE4x4WordAtPtx107R2155,
		  r_PackedHalf2AtPtx3775R2077,
		  r_PackedHalf2AtPtx3782R2076); // PTX L4299
	MmaE4(r_PackedHalf2AtPtx3761R2079, r_PackedHalf2AtPtx3768R2078, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx143R2142, r_MmaBE4x4WordAtPtx143R2141, r_MmaAccumulatorHalf2WordAtPtx4292R1889,
		  r_MmaAccumulatorHalf2WordAtPtx4292R1890); // PTX L4306
	MmaE4(r_PackedHalf2AtPtx3775R2077, r_PackedHalf2AtPtx3782R2076, r_MmaAE4x4WordAtPtx3869R1873,
		  r_MmaAE4x4WordAtPtx3869R1874, r_MmaAE4x4WordAtPtx3869R1875, r_MmaAE4x4WordAtPtx3869R1876,
		  r_MmaBE4x4WordAtPtx143R2171, r_MmaBE4x4WordAtPtx143R2172, r_MmaAccumulatorHalf2WordAtPtx4299R1891,
		  r_MmaAccumulatorHalf2WordAtPtx4299R1892);					  // PTX L4313
	r_bPtxPredicate568 = uint32_t(r_PtxRegister2140) > uint32_t(447); // PTX L4319
	if (r_bPtxPredicate568)
	{
		goto L__BB19_138;
	} // PTX L4320
	r_PtxRegister1921 = uint32_t(r_PtxRegister2140) + uint32_t(64);								  // PTX L4321
	r_PtxRegister1922 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister2140);				  // PTX L4322
	r_PtxRegister1923 = ShiftLeft(uint32_t(r_PtxRegister1922), uint32_t(7));					  // PTX L4323
	r_PtxRegister1924 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(3));						  // PTX L4324
	r_PtxRegister1925 = uint32_t(r_PtxRegister1923) + uint32_t(r_PtxRegister1924);				  // PTX L4325
	r_PtxU64Register247 = uint64_t(int64_t(int32_t(r_PtxRegister1925)) * int64_t(int32_t(4)));	  // PTX L4326
	g_RecordByteAddressAtPtx4327 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register247); // PTX L4327
	r_LaneIndexAtPtx4329 = uint32_t((threadIdx.x & 31u));										  // PTX L4329
	r_PtxU64Register249 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4329)) * int64_t(int32_t(16))); // PTX L4331
	g_RecordByteAddressAtPtx4332 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register249); // PTX L4332
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4332));
		r_MmaBE4x4WordAtPtx80R2170 = r_Value.x;
		r_MmaBE4x4WordAtPtx80R2169 = r_Value.y;
		r_MmaBE4x4WordAtPtx80R2168 = r_Value.z;
		r_MmaBE4x4WordAtPtx80R2167 = r_Value.w;
	} // PTX L4334
	r_LaneIndexAtPtx4337 = uint32_t((threadIdx.x & 31u)); // PTX L4337
	r_PtxU64Register250 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4337)) * int64_t(int32_t(16))); // PTX L4339
	g_RecordByteAddressAtPtx4340 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register250);			   // PTX L4340
	g_RecordByteAddressAtPtx4341 = uint64_t(g_RecordByteAddressAtPtx4340) + uint64_t(512); // PTX L4341
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4341));
		r_MmaBE4x4WordAtPtx89R2166 = r_Value.x;
		r_MmaBE4x4WordAtPtx89R2165 = r_Value.y;
		r_MmaBE4x4WordAtPtx89R2164 = r_Value.z;
		r_MmaBE4x4WordAtPtx89R2163 = r_Value.w;
	} // PTX L4343
	r_LaneIndexAtPtx4346 = uint32_t((threadIdx.x & 31u)); // PTX L4346
	r_PtxU64Register252 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4346)) * int64_t(int32_t(16))); // PTX L4348
	g_RecordByteAddressAtPtx4349 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register252);				// PTX L4349
	g_RecordByteAddressAtPtx4350 = uint64_t(g_RecordByteAddressAtPtx4349) + uint64_t(1024); // PTX L4350
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4350));
		r_MmaBE4x4WordAtPtx98R2162 = r_Value.x;
		r_MmaBE4x4WordAtPtx98R2161 = r_Value.y;
		r_MmaBE4x4WordAtPtx98R2160 = r_Value.z;
		r_MmaBE4x4WordAtPtx98R2159 = r_Value.w;
	} // PTX L4352
	r_LaneIndexAtPtx4355 = uint32_t((threadIdx.x & 31u)); // PTX L4355
	r_PtxU64Register254 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4355)) * int64_t(int32_t(16))); // PTX L4357
	g_RecordByteAddressAtPtx4358 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register254);				// PTX L4358
	g_RecordByteAddressAtPtx4359 = uint64_t(g_RecordByteAddressAtPtx4358) + uint64_t(1536); // PTX L4359
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4359));
		r_MmaBE4x4WordAtPtx107R2158 = r_Value.x;
		r_MmaBE4x4WordAtPtx107R2157 = r_Value.y;
		r_MmaBE4x4WordAtPtx107R2156 = r_Value.z;
		r_MmaBE4x4WordAtPtx107R2155 = r_Value.w;
	} // PTX L4361
	r_LaneIndexAtPtx4364 = uint32_t((threadIdx.x & 31u)); // PTX L4364
	r_PtxU64Register256 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4364)) * int64_t(int32_t(16))); // PTX L4366
	g_RecordByteAddressAtPtx4367 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register256);				 // PTX L4367
	g_RecordByteAddressAtPtx4368 = uint64_t(g_RecordByteAddressAtPtx4367) + uint64_t(16384); // PTX L4368
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4368));
		r_MmaBE4x4WordAtPtx116R2154 = r_Value.x;
		r_MmaBE4x4WordAtPtx116R2153 = r_Value.y;
		r_MmaBE4x4WordAtPtx116R2152 = r_Value.z;
		r_MmaBE4x4WordAtPtx116R2151 = r_Value.w;
	} // PTX L4370
	r_LaneIndexAtPtx4373 = uint32_t((threadIdx.x & 31u)); // PTX L4373
	r_PtxU64Register258 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4373)) * int64_t(int32_t(16))); // PTX L4375
	g_RecordByteAddressAtPtx4376 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register258);				 // PTX L4376
	g_RecordByteAddressAtPtx4377 = uint64_t(g_RecordByteAddressAtPtx4376) + uint64_t(16896); // PTX L4377
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4377));
		r_MmaBE4x4WordAtPtx125R2150 = r_Value.x;
		r_MmaBE4x4WordAtPtx125R2149 = r_Value.y;
		r_MmaBE4x4WordAtPtx125R2148 = r_Value.z;
		r_MmaBE4x4WordAtPtx125R2147 = r_Value.w;
	} // PTX L4379
	r_LaneIndexAtPtx4382 = uint32_t((threadIdx.x & 31u)); // PTX L4382
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4382)) * int64_t(int32_t(16))); // PTX L4384
	g_RecordByteAddressAtPtx4385 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register260);				 // PTX L4385
	g_RecordByteAddressAtPtx4386 = uint64_t(g_RecordByteAddressAtPtx4385) + uint64_t(17408); // PTX L4386
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4386));
		r_MmaBE4x4WordAtPtx134R2146 = r_Value.x;
		r_MmaBE4x4WordAtPtx134R2145 = r_Value.y;
		r_MmaBE4x4WordAtPtx134R2144 = r_Value.z;
		r_MmaBE4x4WordAtPtx134R2143 = r_Value.w;
	} // PTX L4388
	r_LaneIndexAtPtx4391 = uint32_t((threadIdx.x & 31u)); // PTX L4391
	r_PtxU64Register262 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4391)) * int64_t(int32_t(16))); // PTX L4393
	g_RecordByteAddressAtPtx4394 =
		uint64_t(g_RecordByteAddressAtPtx4327) + uint64_t(r_PtxU64Register262);				 // PTX L4394
	g_RecordByteAddressAtPtx4395 = uint64_t(g_RecordByteAddressAtPtx4394) + uint64_t(17920); // PTX L4395
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx4395));
		r_MmaBE4x4WordAtPtx143R2142 = r_Value.x;
		r_MmaBE4x4WordAtPtx143R2141 = r_Value.y;
		r_MmaBE4x4WordAtPtx143R2171 = r_Value.z;
		r_MmaBE4x4WordAtPtx143R2172 = r_Value.w;
	} // PTX L4397
	r_PtxRegister1926 = ShiftRight(uint32_t(r_PtxRegister1921), uint32_t(6)); // PTX L4399
	r_PtxU16Register83 = uint16_t(r_PtxRegister1926);						  // PTX L4400
	r_PtxU16Register84 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register83)) * uint32_t(uint16_t(171))); // PTX L4401
	r_PtxU16Register85 = ShiftRight(uint16_t(r_PtxU16Register84), uint32_t(9));		// PTX L4402
	r_PtxU16Register86 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register85)) * uint32_t(uint16_t(3)));				// PTX L4403
	r_PtxU16Register87 = uint16_t(r_PtxU16Register83) - uint16_t(r_PtxU16Register86);			// PTX L4404
	r_PtxU16Register88 = r_PtxU16Register87 & 255;												// PTX L4405
	r_PtxRegister1927 = uint32_t(uint16_t(r_PtxU16Register88)) * uint32_t(uint16_t(8));			// PTX L4406
	r_PtxRegister1928 = uint32_t(12288u /* exact native shared-region offset */);				// PTX L4407
	r_PtxRegister1930 = uint32_t(r_PtxRegister1928) + uint32_t(r_PtxRegister1927);				// PTX L4408
	r_PtxRegister1920 = uint32_t(1);															// PTX L4409
	r_PtxU64Register264 = BarrierArrive(s_SharedStorage, r_PtxRegister1930, r_PtxRegister1920); // PTX L4411
L__BB19_137:																					// PTX L4413
	r_PtxRegister1929 = BarrierReady(s_SharedStorage, r_PtxRegister1930, r_PtxU64Register264);	// PTX L4415
	r_bPtxPredicate569 = uint32_t(r_PtxRegister1929) == uint32_t(0);							// PTX L4421
	if (r_bPtxPredicate569)
	{
		goto L__BB19_137;
	} // PTX L4422
L__BB19_138:														  // PTX L4423
	r_bPtxPredicate570 = uint32_t(r_PtxRegister2140) > uint32_t(319); // PTX L4424
	if (r_bPtxPredicate570)
	{
		goto L__BB19_155;
	} // PTX L4425
	r_PtxRegister1931 = uint32_t(r_PtxRegister142) + uint32_t(r_PtxRegister6);	  // PTX L4426
	r_bPtxPredicate571 = int32_t(r_PtxRegister1931) < int32_t(r_WidthDiv4Bits);	  // PTX L4427
	r_bPtxPredicate572 = int32_t(r_PtxRegister147) < int32_t(r_HeightDiv4Bits);	  // PTX L4428
	r_bPtxPredicate573 = int32_t(r_PtxRegister147) >= int32_t(r_HeightDiv4Bits);  // PTX L4429
	r_PtxRegister1932 = r_WidthBits & -4;										  // PTX L4430
	r_bPtxPredicate574 = uint32_t(r_PtxRegister1932) == uint32_t(4);			  // PTX L4431
	r_bPtxPredicate575 = uint32_t(r_PtxRegister16) == uint32_t(4);				  // PTX L4432
	r_bPtxPredicate37 = uint32_t(r_PtxRegister16) != uint32_t(4);				  // PTX L4433
	r_PtxRegister1933 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister2140);  // PTX L4434
	r_PtxRegister95 = uint32_t(r_PtxRegister1933) + uint32_t(128);				  // PTX L4435
	r_bPtxPredicate576 = r_bPtxPredicate37 & r_bPtxPredicate573;				  // PTX L4436
	r_bPtxPredicate577 = r_bPtxPredicate575 | r_bPtxPredicate572;				  // PTX L4437
	r_bPtxPredicate578 = r_bPtxPredicate576 | r_bPtxPredicate574;				  // PTX L4438
	r_PtxRegister1934 = r_bPtxPredicate576 ? r_PtxRegister1931 : 0;				  // PTX L4439
	r_PtxRegister96 = r_bPtxPredicate574 ? r_PtxRegister1934 : r_PtxRegister1931; // PTX L4440
	r_bPtxPredicate579 = r_bPtxPredicate578 | r_bPtxPredicate571;				  // PTX L4441
	r_bPtxPredicate38 = r_bPtxPredicate579 & r_bPtxPredicate577;				  // PTX L4442
	r_PtxU64Register305 = uint64_t(0);											  // PTX L4443
	r_bPtxPredicate580 = !r_bPtxPredicate38;									  // PTX L4444
	if (r_bPtxPredicate580)
	{
		goto L__BB19_141;
	} // PTX L4445
	r_PtxRegister1935 =
		uint32_t(r_PtxRegister147) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister96); // PTX L4446
	r_PtxRegister1936 = r_bPtxPredicate575 ? r_PtxRegister96 : r_PtxRegister1935;			// PTX L4447
	r_PtxRegister1937 = ShiftRight(uint32_t(r_PtxRegister95), uint32_t(5));					// PTX L4448
	r_PtxRegister1938 = uint32_t(r_PtxRegister1937) + uint32_t(r_PtxRegister11);			// PTX L4449
	r_PtxRegister1939 = ShiftLeft(uint32_t(r_PtxRegister1936), uint32_t(11));				// PTX L4450
	r_PtxRegister1940 = ShiftLeft(uint32_t(r_PtxRegister1938), uint32_t(7));				// PTX L4451
	r_PtxRegister1941 = uint32_t(r_PtxRegister1939) + uint32_t(r_PtxRegister1940);			// PTX L4452
	r_PtxU64Register305 = SignExtendWordBits(r_PtxRegister1941);							// PTX L4453
L__BB19_141:																				// PTX L4454
	r_PtxU64Register306 = uint64_t(0);														// PTX L4455
	if (r_bPtxPredicate580)
	{
		goto L__BB19_143;
	} // PTX L4456
	r_PtxU64Register265 = ShiftLeft(uint64_t(r_PtxU64Register305), uint32_t(2));		// PTX L4457
	r_PtxU64Register306 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register265); // PTX L4458
L__BB19_143:																			// PTX L4459
	r_PtxRegister1942 = ShiftLeft(uint32_t(r_PtxRegister93), uint32_t(3));				// PTX L4460
	r_PtxRegister1943 = uint32_t(12288u /* exact native shared-region offset */);		// PTX L4461
	r_PtxRegister1989 = uint32_t(r_PtxRegister1943) + uint32_t(r_PtxRegister1942);		// PTX L4462
	if (r_bPtxPredicate580)
	{
		goto L__BB19_146;
	} // PTX L4463
	r_PtxRegister1956 = uint32_t(-1);								 // PTX L4464
	r_PtxRegister1955 = Elected(r_PtxRegister1956);					 // PTX L4466
	r_bPtxPredicate581 = uint32_t(r_PtxRegister1955) == uint32_t(0); // PTX L4472
	if (r_bPtxPredicate581)
	{
		goto L__BB19_147;
	} // PTX L4473
	r_ThreadYAtPtx4474 = uint32_t(threadIdx.y);									 // PTX L4474
	r_PtxRegister1960 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(9));		 // PTX L4475
	r_PtxRegister1961 = ShiftLeft(uint32_t(r_ThreadYAtPtx4474), uint32_t(9));	 // PTX L4476
	r_PtxRegister1962 = r_PtxRegister1961 & 523264;								 // PTX L4477
	r_PtxRegister1963 = r_PtxRegister1960 | r_PtxRegister1962;					 // PTX L4478
	r_PtxRegister1957 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1963); // PTX L4479
	r_PtxU64Register266 = r_PtxU64Register306;									 // PTX L4480
	r_PtxRegister1958 = uint32_t(512);											 // PTX L4481
	CopyBulk(s_SharedStorage, r_PtxRegister1957, r_PtxU64Register266, r_PtxRegister1958,
			 r_PtxRegister1989);																// PTX L4483
	BarrierExpect(s_SharedStorage, r_PtxRegister1989, r_PtxRegister1958);						// PTX L4486
	goto L__BB19_147;																			// PTX L4488
L__BB19_146:																					// PTX L4489
	r_PtxRegister1944 = uint32_t(0);															// PTX L4490
	r_PtxU16Register89 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1944))); // PTX L4492
	r_PackedHalf2AtPtx4495R1945 = JoinHalfwords(r_PtxU16Register89, r_PtxU16Register89);		// PTX L4495
	r_ConvertedE4PairAtPtx4497Rs90 = PublishE4(r_PackedHalf2AtPtx4495R1945);					// PTX L4497
	r_PackedE4WordAtPtx4499R1948 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4497Rs90, r_ConvertedE4PairAtPtx4497Rs90); // PTX L4499
	r_LaneIndexAtPtx4501 = uint32_t((threadIdx.x & 31u));							   // PTX L4501
	r_PtxRegister1949 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(9));			   // PTX L4503
	r_PtxRegister1950 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(9));			   // PTX L4504
	r_PtxRegister1951 = r_PtxRegister1950 & 523264;									   // PTX L4505
	r_PtxRegister1952 = r_PtxRegister1949 | r_PtxRegister1951;						   // PTX L4506
	r_PtxRegister1953 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1952);	   // PTX L4507
	r_PtxRegister1954 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4501), uint32_t(4));		   // PTX L4508
	r_PtxRegister1947 = uint32_t(r_PtxRegister1953) + uint32_t(r_PtxRegister1954);	   // PTX L4509
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1947)) =
		make_uint4(r_PackedE4WordAtPtx4499R1948, r_PackedE4WordAtPtx4499R1948, r_PackedE4WordAtPtx4499R1948,
				   r_PackedE4WordAtPtx4499R1948);								  // PTX L4511
L__BB19_147:																	  // PTX L4513
	r_bPtxPredicate582 = int32_t(r_PtxRegister170) >= int32_t(r_HeightDiv4Bits);  // PTX L4514
	r_bPtxPredicate583 = int32_t(r_PtxRegister1931) < int32_t(r_WidthDiv4Bits);	  // PTX L4515
	r_bPtxPredicate584 = uint32_t(r_PtxRegister1932) == uint32_t(4);			  // PTX L4516
	r_bPtxPredicate585 = uint32_t(r_PtxRegister16) == uint32_t(4);				  // PTX L4517
	r_bPtxPredicate586 = r_bPtxPredicate37 & r_bPtxPredicate582;				  // PTX L4518
	r_bPtxPredicate587 = r_bPtxPredicate585 | r_bPtxPredicate36;				  // PTX L4519
	r_bPtxPredicate588 = r_bPtxPredicate586 | r_bPtxPredicate584;				  // PTX L4520
	r_PtxRegister1964 = r_bPtxPredicate586 ? r_PtxRegister1931 : 0;				  // PTX L4521
	r_PtxRegister97 = r_bPtxPredicate584 ? r_PtxRegister1964 : r_PtxRegister1931; // PTX L4522
	r_bPtxPredicate589 = r_bPtxPredicate588 | r_bPtxPredicate583;				  // PTX L4523
	r_bPtxPredicate39 = r_bPtxPredicate589 & r_bPtxPredicate587;				  // PTX L4524
	r_PtxU64Register307 = uint64_t(0);											  // PTX L4525
	r_bPtxPredicate590 = !r_bPtxPredicate39;									  // PTX L4526
	if (r_bPtxPredicate590)
	{
		goto L__BB19_149;
	} // PTX L4527
	r_PtxRegister1965 =
		uint32_t(r_PtxRegister170) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister97); // PTX L4528
	r_PtxRegister1966 = r_bPtxPredicate585 ? r_PtxRegister97 : r_PtxRegister1965;			// PTX L4529
	r_PtxRegister1967 = ShiftRight(uint32_t(r_PtxRegister95), uint32_t(5));					// PTX L4530
	r_PtxRegister1968 = uint32_t(r_PtxRegister1967) + uint32_t(r_PtxRegister11);			// PTX L4531
	r_PtxRegister1969 = ShiftLeft(uint32_t(r_PtxRegister1966), uint32_t(11));				// PTX L4532
	r_PtxRegister1970 = ShiftLeft(uint32_t(r_PtxRegister1968), uint32_t(7));				// PTX L4533
	r_PtxRegister1971 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister1970);			// PTX L4534
	r_PtxU64Register307 = SignExtendWordBits(r_PtxRegister1971);							// PTX L4535
L__BB19_149:																				// PTX L4536
	r_PtxU64Register308 = uint64_t(0);														// PTX L4537
	if (r_bPtxPredicate590)
	{
		goto L__BB19_151;
	} // PTX L4538
	r_PtxU64Register267 = ShiftLeft(uint64_t(r_PtxU64Register307), uint32_t(2));		// PTX L4539
	r_PtxU64Register308 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register267); // PTX L4540
L__BB19_151:																			// PTX L4541
	r_PtxRegister1972 = uint32_t(r_PtxRegister145) + uint32_t(512);						// PTX L4542
	r_PtxRegister1973 = r_PtxRegister1972 & 261632;										// PTX L4543
	r_PtxRegister1974 = r_PtxRegister145 & 256;											// PTX L4544
	r_PtxRegister1975 = r_PtxRegister1973 | r_PtxRegister1974;							// PTX L4545
	r_PtxRegister1976 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(7));				// PTX L4546
	r_PtxRegister98 = r_PtxRegister1975 | r_PtxRegister1976;							// PTX L4547
	if (r_bPtxPredicate590)
	{
		goto L__BB19_154;
	} // PTX L4548
	r_PtxRegister1986 = uint32_t(-1);								 // PTX L4549
	r_PtxRegister1985 = Elected(r_PtxRegister1986);					 // PTX L4551
	r_bPtxPredicate591 = uint32_t(r_PtxRegister1985) == uint32_t(0); // PTX L4557
	if (r_bPtxPredicate591)
	{
		goto L__BB19_155;
	} // PTX L4558
	r_PtxRegister1990 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(2));		 // PTX L4559
	r_PtxRegister1987 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1990); // PTX L4560
	r_PtxU64Register268 = r_PtxU64Register308;									 // PTX L4561
	r_PtxRegister1988 = uint32_t(512);											 // PTX L4562
	CopyBulk(s_SharedStorage, r_PtxRegister1987, r_PtxU64Register268, r_PtxRegister1988,
			 r_PtxRegister1989);																// PTX L4564
	BarrierExpect(s_SharedStorage, r_PtxRegister1989, r_PtxRegister1988);						// PTX L4567
	goto L__BB19_155;																			// PTX L4569
L__BB19_154:																					// PTX L4570
	r_PtxRegister1977 = uint32_t(0);															// PTX L4571
	r_PtxU16Register91 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1977))); // PTX L4573
	r_PackedHalf2AtPtx4576R1978 = JoinHalfwords(r_PtxU16Register91, r_PtxU16Register91);		// PTX L4576
	r_ConvertedE4PairAtPtx4578Rs92 = PublishE4(r_PackedHalf2AtPtx4576R1978);					// PTX L4578
	r_PackedE4WordAtPtx4580R1981 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4578Rs92, r_ConvertedE4PairAtPtx4578Rs92); // PTX L4580
	r_LaneIndexAtPtx4582 = uint32_t((threadIdx.x & 31u));							   // PTX L4582
	r_PtxRegister1982 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(2));			   // PTX L4584
	r_PtxRegister1983 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister1982);	   // PTX L4585
	r_PtxRegister1984 = ShiftLeft(uint32_t(r_LaneIndexAtPtx4582), uint32_t(4));		   // PTX L4586
	r_PtxRegister1980 = uint32_t(r_PtxRegister1983) + uint32_t(r_PtxRegister1984);	   // PTX L4587
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1980)) =
		make_uint4(r_PackedE4WordAtPtx4580R1981, r_PackedE4WordAtPtx4580R1981, r_PackedE4WordAtPtx4580R1981,
				   r_PackedE4WordAtPtx4580R1981);					  // PTX L4589
L__BB19_155:														  // PTX L4591
	r_bPtxPredicate592 = uint32_t(r_PtxRegister2140) < uint32_t(448); // PTX L4592
	r_PtxRegister2140 = uint32_t(r_PtxRegister2140) + uint32_t(64);	  // PTX L4593
	if (r_bPtxPredicate592)
	{
		goto L__BB19_135;
	} // PTX L4594
	r_ConvertedE4PairAtPtx4596Rs93 = PublishE4(r_PackedHalf2AtPtx3341R2139);   // PTX L4596
	r_ConvertedE4PairAtPtx4599Rs94 = PublishE4(r_PackedHalf2AtPtx3355R2137);   // PTX L4599
	r_ConvertedE4PairAtPtx4602Rs95 = PublishE4(r_PackedHalf2AtPtx3348R2138);   // PTX L4602
	r_ConvertedE4PairAtPtx4605Rs96 = PublishE4(r_PackedHalf2AtPtx3362R2136);   // PTX L4605
	r_ConvertedE4PairAtPtx4608Rs97 = PublishE4(r_PackedHalf2AtPtx3369R2135);   // PTX L4608
	r_ConvertedE4PairAtPtx4611Rs98 = PublishE4(r_PackedHalf2AtPtx3383R2133);   // PTX L4611
	r_ConvertedE4PairAtPtx4614Rs99 = PublishE4(r_PackedHalf2AtPtx3376R2134);   // PTX L4614
	r_ConvertedE4PairAtPtx4617Rs100 = PublishE4(r_PackedHalf2AtPtx3390R2132);  // PTX L4617
	r_ConvertedE4PairAtPtx4620Rs101 = PublishE4(r_PackedHalf2AtPtx3397R2131);  // PTX L4620
	r_ConvertedE4PairAtPtx4623Rs102 = PublishE4(r_PackedHalf2AtPtx3411R2129);  // PTX L4623
	r_ConvertedE4PairAtPtx4626Rs103 = PublishE4(r_PackedHalf2AtPtx3404R2130);  // PTX L4626
	r_ConvertedE4PairAtPtx4629Rs104 = PublishE4(r_PackedHalf2AtPtx3418R2128);  // PTX L4629
	r_ConvertedE4PairAtPtx4632Rs105 = PublishE4(r_PackedHalf2AtPtx3425R2127);  // PTX L4632
	r_ConvertedE4PairAtPtx4635Rs106 = PublishE4(r_PackedHalf2AtPtx3439R2125);  // PTX L4635
	r_ConvertedE4PairAtPtx4638Rs107 = PublishE4(r_PackedHalf2AtPtx3432R2126);  // PTX L4638
	r_ConvertedE4PairAtPtx4641Rs108 = PublishE4(r_PackedHalf2AtPtx3446R2124);  // PTX L4641
	r_ConvertedE4PairAtPtx4644Rs109 = PublishE4(r_PackedHalf2AtPtx3453R2123);  // PTX L4644
	r_ConvertedE4PairAtPtx4647Rs110 = PublishE4(r_PackedHalf2AtPtx3467R2121);  // PTX L4647
	r_ConvertedE4PairAtPtx4650Rs111 = PublishE4(r_PackedHalf2AtPtx3460R2122);  // PTX L4650
	r_ConvertedE4PairAtPtx4653Rs112 = PublishE4(r_PackedHalf2AtPtx3474R2120);  // PTX L4653
	r_ConvertedE4PairAtPtx4656Rs113 = PublishE4(r_PackedHalf2AtPtx3481R2119);  // PTX L4656
	r_ConvertedE4PairAtPtx4659Rs114 = PublishE4(r_PackedHalf2AtPtx3495R2117);  // PTX L4659
	r_ConvertedE4PairAtPtx4662Rs115 = PublishE4(r_PackedHalf2AtPtx3488R2118);  // PTX L4662
	r_ConvertedE4PairAtPtx4665Rs116 = PublishE4(r_PackedHalf2AtPtx3502R2116);  // PTX L4665
	r_ConvertedE4PairAtPtx4668Rs117 = PublishE4(r_PackedHalf2AtPtx3509R2115);  // PTX L4668
	r_ConvertedE4PairAtPtx4671Rs118 = PublishE4(r_PackedHalf2AtPtx3523R2113);  // PTX L4671
	r_ConvertedE4PairAtPtx4674Rs119 = PublishE4(r_PackedHalf2AtPtx3516R2114);  // PTX L4674
	r_ConvertedE4PairAtPtx4677Rs120 = PublishE4(r_PackedHalf2AtPtx3530R2112);  // PTX L4677
	r_ConvertedE4PairAtPtx4680Rs121 = PublishE4(r_PackedHalf2AtPtx3537R2111);  // PTX L4680
	r_ConvertedE4PairAtPtx4683Rs122 = PublishE4(r_PackedHalf2AtPtx3551R2109);  // PTX L4683
	r_ConvertedE4PairAtPtx4686Rs123 = PublishE4(r_PackedHalf2AtPtx3544R2110);  // PTX L4686
	r_ConvertedE4PairAtPtx4689Rs124 = PublishE4(r_PackedHalf2AtPtx3558R2108);  // PTX L4689
	r_ConvertedE4PairAtPtx4692Rs125 = PublishE4(r_PackedHalf2AtPtx3565R2107);  // PTX L4692
	r_ConvertedE4PairAtPtx4695Rs126 = PublishE4(r_PackedHalf2AtPtx3579R2105);  // PTX L4695
	r_ConvertedE4PairAtPtx4698Rs127 = PublishE4(r_PackedHalf2AtPtx3572R2106);  // PTX L4698
	r_ConvertedE4PairAtPtx4701Rs128 = PublishE4(r_PackedHalf2AtPtx3586R2104);  // PTX L4701
	r_ConvertedE4PairAtPtx4704Rs129 = PublishE4(r_PackedHalf2AtPtx3593R2103);  // PTX L4704
	r_ConvertedE4PairAtPtx4707Rs130 = PublishE4(r_PackedHalf2AtPtx3607R2101);  // PTX L4707
	r_ConvertedE4PairAtPtx4710Rs131 = PublishE4(r_PackedHalf2AtPtx3600R2102);  // PTX L4710
	r_ConvertedE4PairAtPtx4713Rs132 = PublishE4(r_PackedHalf2AtPtx3614R2100);  // PTX L4713
	r_ConvertedE4PairAtPtx4716Rs133 = PublishE4(r_PackedHalf2AtPtx3621R2099);  // PTX L4716
	r_ConvertedE4PairAtPtx4719Rs134 = PublishE4(r_PackedHalf2AtPtx3635R2097);  // PTX L4719
	r_ConvertedE4PairAtPtx4722Rs135 = PublishE4(r_PackedHalf2AtPtx3628R2098);  // PTX L4722
	r_ConvertedE4PairAtPtx4725Rs136 = PublishE4(r_PackedHalf2AtPtx3642R2096);  // PTX L4725
	r_ConvertedE4PairAtPtx4728Rs137 = PublishE4(r_PackedHalf2AtPtx3649R2095);  // PTX L4728
	r_ConvertedE4PairAtPtx4731Rs138 = PublishE4(r_PackedHalf2AtPtx3663R2093);  // PTX L4731
	r_ConvertedE4PairAtPtx4734Rs139 = PublishE4(r_PackedHalf2AtPtx3656R2094);  // PTX L4734
	r_ConvertedE4PairAtPtx4737Rs140 = PublishE4(r_PackedHalf2AtPtx3670R2092);  // PTX L4737
	r_ConvertedE4PairAtPtx4740Rs141 = PublishE4(r_PackedHalf2AtPtx3677R2091);  // PTX L4740
	r_ConvertedE4PairAtPtx4743Rs142 = PublishE4(r_PackedHalf2AtPtx3691R2089);  // PTX L4743
	r_ConvertedE4PairAtPtx4746Rs143 = PublishE4(r_PackedHalf2AtPtx3684R2090);  // PTX L4746
	r_ConvertedE4PairAtPtx4749Rs144 = PublishE4(r_PackedHalf2AtPtx3698R2088);  // PTX L4749
	r_ConvertedE4PairAtPtx4752Rs145 = PublishE4(r_PackedHalf2AtPtx3705R2087);  // PTX L4752
	r_ConvertedE4PairAtPtx4755Rs146 = PublishE4(r_PackedHalf2AtPtx3719R2085);  // PTX L4755
	r_ConvertedE4PairAtPtx4758Rs147 = PublishE4(r_PackedHalf2AtPtx3712R2086);  // PTX L4758
	r_ConvertedE4PairAtPtx4761Rs148 = PublishE4(r_PackedHalf2AtPtx3726R2084);  // PTX L4761
	r_ConvertedE4PairAtPtx4764Rs149 = PublishE4(r_PackedHalf2AtPtx3733R2083);  // PTX L4764
	r_ConvertedE4PairAtPtx4767Rs150 = PublishE4(r_PackedHalf2AtPtx3747R2081);  // PTX L4767
	r_ConvertedE4PairAtPtx4770Rs151 = PublishE4(r_PackedHalf2AtPtx3740R2082);  // PTX L4770
	r_ConvertedE4PairAtPtx4773Rs152 = PublishE4(r_PackedHalf2AtPtx3754R2080);  // PTX L4773
	r_ConvertedE4PairAtPtx4776Rs153 = PublishE4(r_PackedHalf2AtPtx3761R2079);  // PTX L4776
	r_ConvertedE4PairAtPtx4779Rs154 = PublishE4(r_PackedHalf2AtPtx3775R2077);  // PTX L4779
	r_ConvertedE4PairAtPtx4782Rs155 = PublishE4(r_PackedHalf2AtPtx3768R2078);  // PTX L4782
	r_ConvertedE4PairAtPtx4785Rs156 = PublishE4(r_PackedHalf2AtPtx3782R2076);  // PTX L4785
	r_bPtxPredicate593 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L4787
	r_bPtxPredicate594 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);  // PTX L4788
	r_PtxRegister1991 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister6);		  // PTX L4789
	r_PtxRegister99 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						  // PTX L4790
	r_PtxRegister1992 = ShiftLeft(uint32_t(r_PtxRegister1991), uint32_t(11));					  // PTX L4791
	r_PtxRegister1993 = uint32_t(r_PtxRegister1992) + uint32_t(r_PtxRegister99);				  // PTX L4792
	r_PtxU64Register269 = uint64_t(int64_t(int32_t(r_PtxRegister1993)) * int64_t(int32_t(4)));	  // PTX L4793
	g_OutputByteAddressAtPtx4794 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register269); // PTX L4794
	r_bPtxPredicate595 = r_bPtxPredicate593 | r_bPtxPredicate594;								  // PTX L4795
	if (r_bPtxPredicate595)
	{
		goto L__BB19_158;
	} // PTX L4796
	r_PackedE4WordAtPtx4797R2003 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4638Rs107, r_ConvertedE4PairAtPtx4641Rs108); // PTX L4797
	r_PackedE4WordAtPtx4798R2002 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4632Rs105, r_ConvertedE4PairAtPtx4635Rs106); // PTX L4798
	r_PackedE4WordAtPtx4799R2001 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4626Rs103, r_ConvertedE4PairAtPtx4629Rs104); // PTX L4799
	r_PackedE4WordAtPtx4800R2000 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4620Rs101, r_ConvertedE4PairAtPtx4623Rs102); // PTX L4800
	r_PackedE4WordAtPtx4801R1998 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4614Rs99, r_ConvertedE4PairAtPtx4617Rs100); // PTX L4801
	r_PackedE4WordAtPtx4802R1997 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4608Rs97, r_ConvertedE4PairAtPtx4611Rs98); // PTX L4802
	r_PackedE4WordAtPtx4803R1996 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4602Rs95, r_ConvertedE4PairAtPtx4605Rs96); // PTX L4803
	r_PackedE4WordAtPtx4804R1995 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4596Rs93, r_ConvertedE4PairAtPtx4599Rs94); // PTX L4804
	r_LaneIndexAtPtx4806 = uint32_t((threadIdx.x & 31u));							   // PTX L4806
	r_PtxU64Register272 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4806)) * int64_t(int32_t(16))); // PTX L4808
	g_OutputByteAddressAtPtx4809 =
		uint64_t(g_OutputByteAddressAtPtx4794) + uint64_t(r_PtxU64Register272); // PTX L4809
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx4809,
					make_uint4(r_PackedE4WordAtPtx4804R1995, r_PackedE4WordAtPtx4803R1996,
							   r_PackedE4WordAtPtx4802R1997,
							   r_PackedE4WordAtPtx4801R1998)); // PTX L4811
	r_LaneIndexAtPtx4814 = uint32_t((threadIdx.x & 31u));	   // PTX L4814
	r_PtxU64Register273 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4814)) * int64_t(int32_t(16))); // PTX L4816
	g_OutputByteAddressAtPtx4817 =
		uint64_t(g_OutputByteAddressAtPtx4794) + uint64_t(r_PtxU64Register273);			   // PTX L4817
	g_OutputByteAddressAtPtx4818 = uint64_t(g_OutputByteAddressAtPtx4817) + uint64_t(512); // PTX L4818
	StoreNoAllocate(g_OutputByteAddressAtPtx4818,
					make_uint4(r_PackedE4WordAtPtx4800R2000, r_PackedE4WordAtPtx4799R2001,
							   r_PackedE4WordAtPtx4798R2002,
							   r_PackedE4WordAtPtx4797R2003));					// PTX L4820
L__BB19_158:																	// PTX L4822
	r_bPtxPredicate596 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits);	// PTX L4823
	r_PtxRegister100 = uint32_t(r_PtxRegister6) + uint32_t(1);					// PTX L4824
	r_bPtxPredicate597 = int32_t(r_PtxRegister100) >= int32_t(r_WidthDiv4Bits); // PTX L4825
	r_bPtxPredicate598 = r_bPtxPredicate596 | r_bPtxPredicate597;				// PTX L4826
	if (r_bPtxPredicate598)
	{
		goto L__BB19_160;
	} // PTX L4827
	r_LaneIndexAtPtx4829 = uint32_t((threadIdx.x & 31u)); // PTX L4829
	r_PtxU64Register277 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4829)) * int64_t(int32_t(16))); // PTX L4831
	g_OutputByteAddressAtPtx4832 =
		uint64_t(g_OutputByteAddressAtPtx4794) + uint64_t(r_PtxU64Register277);				// PTX L4832
	g_OutputByteAddressAtPtx4833 = uint64_t(g_OutputByteAddressAtPtx4832) + uint64_t(8192); // PTX L4833
	r_PackedE4WordAtPtx4834R2008 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4662Rs115, r_ConvertedE4PairAtPtx4665Rs116); // PTX L4834
	r_PackedE4WordAtPtx4835R2007 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4656Rs113, r_ConvertedE4PairAtPtx4659Rs114); // PTX L4835
	r_PackedE4WordAtPtx4836R2006 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4650Rs111, r_ConvertedE4PairAtPtx4653Rs112); // PTX L4836
	r_PackedE4WordAtPtx4837R2005 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4644Rs109, r_ConvertedE4PairAtPtx4647Rs110); // PTX L4837
	StoreNoAllocate(g_OutputByteAddressAtPtx4833,
					make_uint4(r_PackedE4WordAtPtx4837R2005, r_PackedE4WordAtPtx4836R2006,
							   r_PackedE4WordAtPtx4835R2007,
							   r_PackedE4WordAtPtx4834R2008)); // PTX L4839
	r_LaneIndexAtPtx4842 = uint32_t((threadIdx.x & 31u));	   // PTX L4842
	r_PtxU64Register279 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4842)) * int64_t(int32_t(16))); // PTX L4844
	g_OutputByteAddressAtPtx4845 =
		uint64_t(g_OutputByteAddressAtPtx4794) + uint64_t(r_PtxU64Register279);				// PTX L4845
	g_OutputByteAddressAtPtx4846 = uint64_t(g_OutputByteAddressAtPtx4845) + uint64_t(8704); // PTX L4846
	r_PackedE4WordAtPtx4847R2013 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4686Rs123, r_ConvertedE4PairAtPtx4689Rs124); // PTX L4847
	r_PackedE4WordAtPtx4848R2012 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4680Rs121, r_ConvertedE4PairAtPtx4683Rs122); // PTX L4848
	r_PackedE4WordAtPtx4849R2011 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4674Rs119, r_ConvertedE4PairAtPtx4677Rs120); // PTX L4849
	r_PackedE4WordAtPtx4850R2010 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4668Rs117, r_ConvertedE4PairAtPtx4671Rs118); // PTX L4850
	StoreNoAllocate(g_OutputByteAddressAtPtx4846,
					make_uint4(r_PackedE4WordAtPtx4850R2010, r_PackedE4WordAtPtx4849R2011,
							   r_PackedE4WordAtPtx4848R2012,
							   r_PackedE4WordAtPtx4847R2013));					 // PTX L4852
L__BB19_160:																	 // PTX L4854
	r_bPtxPredicate599 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);	 // PTX L4855
	r_PtxRegister101 = uint32_t(r_PtxRegister3) + uint32_t(1);					 // PTX L4856
	r_bPtxPredicate600 = int32_t(r_PtxRegister101) >= int32_t(r_HeightDiv4Bits); // PTX L4857
	r_PtxRegister2014 =
		uint32_t(r_WidthDiv4Bits) * uint32_t(r_PtxRegister3) + uint32_t(r_WidthDiv4Bits);		  // PTX L4858
	r_PtxRegister2015 = uint32_t(r_PtxRegister2014) + uint32_t(r_PtxRegister6);					  // PTX L4859
	r_PtxRegister2016 = ShiftLeft(uint32_t(r_PtxRegister2015), uint32_t(11));					  // PTX L4860
	r_PtxRegister2017 = uint32_t(r_PtxRegister2016) + uint32_t(r_PtxRegister99);				  // PTX L4861
	r_PtxU64Register281 = uint64_t(int64_t(int32_t(r_PtxRegister2017)) * int64_t(int32_t(4)));	  // PTX L4862
	g_OutputByteAddressAtPtx4863 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register281); // PTX L4863
	r_bPtxPredicate601 = r_bPtxPredicate600 | r_bPtxPredicate599;								  // PTX L4864
	if (r_bPtxPredicate601)
	{
		goto L__BB19_162;
	} // PTX L4865
	r_LaneIndexAtPtx4867 = uint32_t((threadIdx.x & 31u)); // PTX L4867
	r_PtxU64Register284 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4867)) * int64_t(int32_t(16))); // PTX L4869
	g_OutputByteAddressAtPtx4870 =
		uint64_t(g_OutputByteAddressAtPtx4863) + uint64_t(r_PtxU64Register284); // PTX L4870
	r_PackedE4WordAtPtx4871R2022 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4710Rs131, r_ConvertedE4PairAtPtx4713Rs132); // PTX L4871
	r_PackedE4WordAtPtx4872R2021 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4704Rs129, r_ConvertedE4PairAtPtx4707Rs130); // PTX L4872
	r_PackedE4WordAtPtx4873R2020 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4698Rs127, r_ConvertedE4PairAtPtx4701Rs128); // PTX L4873
	r_PackedE4WordAtPtx4874R2019 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4692Rs125, r_ConvertedE4PairAtPtx4695Rs126); // PTX L4874
	StoreNoAllocate(g_OutputByteAddressAtPtx4870,
					make_uint4(r_PackedE4WordAtPtx4874R2019, r_PackedE4WordAtPtx4873R2020,
							   r_PackedE4WordAtPtx4872R2021,
							   r_PackedE4WordAtPtx4871R2022)); // PTX L4876
	r_LaneIndexAtPtx4879 = uint32_t((threadIdx.x & 31u));	   // PTX L4879
	r_PtxU64Register285 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4879)) * int64_t(int32_t(16))); // PTX L4881
	g_OutputByteAddressAtPtx4882 =
		uint64_t(g_OutputByteAddressAtPtx4863) + uint64_t(r_PtxU64Register285);			   // PTX L4882
	g_OutputByteAddressAtPtx4883 = uint64_t(g_OutputByteAddressAtPtx4882) + uint64_t(512); // PTX L4883
	r_PackedE4WordAtPtx4884R2027 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4734Rs139, r_ConvertedE4PairAtPtx4737Rs140); // PTX L4884
	r_PackedE4WordAtPtx4885R2026 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4728Rs137, r_ConvertedE4PairAtPtx4731Rs138); // PTX L4885
	r_PackedE4WordAtPtx4886R2025 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4722Rs135, r_ConvertedE4PairAtPtx4725Rs136); // PTX L4886
	r_PackedE4WordAtPtx4887R2024 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4716Rs133, r_ConvertedE4PairAtPtx4719Rs134); // PTX L4887
	StoreNoAllocate(g_OutputByteAddressAtPtx4883,
					make_uint4(r_PackedE4WordAtPtx4887R2024, r_PackedE4WordAtPtx4886R2025,
							   r_PackedE4WordAtPtx4885R2026,
							   r_PackedE4WordAtPtx4884R2027));					// PTX L4889
L__BB19_162:																	// PTX L4891
	r_bPtxPredicate602 = int32_t(r_PtxRegister100) >= int32_t(r_WidthDiv4Bits); // PTX L4892
	r_bPtxPredicate603 = r_bPtxPredicate600 | r_bPtxPredicate602;				// PTX L4893
	if (r_bPtxPredicate603)
	{
		goto L__BB19_164;
	} // PTX L4894
	r_LaneIndexAtPtx4896 = uint32_t((threadIdx.x & 31u)); // PTX L4896
	r_PtxU64Register289 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4896)) * int64_t(int32_t(16))); // PTX L4898
	g_OutputByteAddressAtPtx4899 =
		uint64_t(g_OutputByteAddressAtPtx4863) + uint64_t(r_PtxU64Register289);				// PTX L4899
	g_OutputByteAddressAtPtx4900 = uint64_t(g_OutputByteAddressAtPtx4899) + uint64_t(8192); // PTX L4900
	r_PackedE4WordAtPtx4901R2032 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4758Rs147, r_ConvertedE4PairAtPtx4761Rs148); // PTX L4901
	r_PackedE4WordAtPtx4902R2031 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4752Rs145, r_ConvertedE4PairAtPtx4755Rs146); // PTX L4902
	r_PackedE4WordAtPtx4903R2030 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4746Rs143, r_ConvertedE4PairAtPtx4749Rs144); // PTX L4903
	r_PackedE4WordAtPtx4904R2029 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4740Rs141, r_ConvertedE4PairAtPtx4743Rs142); // PTX L4904
	StoreNoAllocate(g_OutputByteAddressAtPtx4900,
					make_uint4(r_PackedE4WordAtPtx4904R2029, r_PackedE4WordAtPtx4903R2030,
							   r_PackedE4WordAtPtx4902R2031,
							   r_PackedE4WordAtPtx4901R2032)); // PTX L4906
	r_LaneIndexAtPtx4909 = uint32_t((threadIdx.x & 31u));	   // PTX L4909
	r_PtxU64Register291 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4909)) * int64_t(int32_t(16))); // PTX L4911
	g_OutputByteAddressAtPtx4912 =
		uint64_t(g_OutputByteAddressAtPtx4863) + uint64_t(r_PtxU64Register291);				// PTX L4912
	g_OutputByteAddressAtPtx4913 = uint64_t(g_OutputByteAddressAtPtx4912) + uint64_t(8704); // PTX L4913
	r_PackedE4WordAtPtx4914R2037 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4782Rs155, r_ConvertedE4PairAtPtx4785Rs156); // PTX L4914
	r_PackedE4WordAtPtx4915R2036 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4776Rs153, r_ConvertedE4PairAtPtx4779Rs154); // PTX L4915
	r_PackedE4WordAtPtx4916R2035 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4770Rs151, r_ConvertedE4PairAtPtx4773Rs152); // PTX L4916
	r_PackedE4WordAtPtx4917R2034 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4764Rs149, r_ConvertedE4PairAtPtx4767Rs150); // PTX L4917
	StoreNoAllocate(g_OutputByteAddressAtPtx4913,
					make_uint4(r_PackedE4WordAtPtx4917R2034, r_PackedE4WordAtPtx4916R2035,
							   r_PackedE4WordAtPtx4915R2036,
							   r_PackedE4WordAtPtx4914R2037)); // PTX L4919
L__BB19_164:												   // PTX L4921
	return;													   // PTX L4922
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8
