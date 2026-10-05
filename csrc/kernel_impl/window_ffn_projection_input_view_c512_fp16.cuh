// Readable equivalent of cc_split_swin_16h_ffwd_proj_inpview_512; not historical source.
#pragma once
#include "window_ffn_projection_input_view_c512_abi_fp16.cuh"

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16
{
__global__ __maxnreg__(128) void window_ffn_projection_input_view_c512_fp16(Parameters r_Parameters)
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
		r_bPtxPredicate606, r_bPtxPredicate607, r_bPtxPredicate608, r_bPtxPredicate609, r_bPtxPredicate610,
		r_bPtxPredicate611, r_bPtxPredicate612;
	bool r_bPtxPredicate613, r_bPtxPredicate614, r_bPtxPredicate615, r_bPtxPredicate616, r_bPtxPredicate617,
		r_bPtxPredicate618, r_bPtxPredicate619, r_bPtxPredicate620, r_bPtxPredicate621, r_bPtxPredicate622,
		r_bPtxPredicate623, r_bPtxPredicate624;
	bool r_bPtxPredicate625, r_bPtxPredicate626, r_bPtxPredicate627, r_bPtxPredicate628, r_bPtxPredicate629,
		r_bPtxPredicate630, r_bPtxPredicate631, r_bPtxPredicate632, r_bPtxPredicate633, r_bPtxPredicate634,
		r_bPtxPredicate635, r_bPtxPredicate636;
	bool r_bPtxPredicate637, r_bPtxPredicate638, r_bPtxPredicate639, r_bPtxPredicate640, r_bPtxPredicate641,
		r_bPtxPredicate642, r_bPtxPredicate643, r_bPtxPredicate644, r_bPtxPredicate645, r_bPtxPredicate646,
		r_bPtxPredicate647, r_bPtxPredicate648;
	bool r_bPtxPredicate649, r_bPtxPredicate650, r_bPtxPredicate651, r_bPtxPredicate652, r_bPtxPredicate653,
		r_bPtxPredicate654, r_bPtxPredicate655, r_bPtxPredicate656, r_bPtxPredicate657, r_bPtxPredicate658,
		r_bPtxPredicate659, r_bPtxPredicate660;
	bool r_bPtxPredicate661, r_bPtxPredicate662, r_bPtxPredicate663, r_bPtxPredicate664, r_bPtxPredicate665,
		r_bPtxPredicate666, r_bPtxPredicate667, r_bPtxPredicate668, r_bPtxPredicate669, r_bPtxPredicate670,
		r_bPtxPredicate671, r_bPtxPredicate672;
	bool r_bPtxPredicate673, r_bPtxPredicate674, r_bPtxPredicate675, r_bPtxPredicate676, r_bPtxPredicate677,
		r_bPtxPredicate678, r_bPtxPredicate679, r_bPtxPredicate680, r_bPtxPredicate681, r_bPtxPredicate682,
		r_bPtxPredicate683, r_bPtxPredicate684;
	bool r_bPtxPredicate685, r_bPtxPredicate686, r_bPtxPredicate687, r_bPtxPredicate688, r_bPtxPredicate689,
		r_bPtxPredicate690, r_bPtxPredicate691, r_bPtxPredicate692, r_bPtxPredicate693, r_bPtxPredicate694,
		r_bPtxPredicate695, r_bPtxPredicate696;
	bool r_bPtxPredicate697, r_bPtxPredicate698, r_bPtxPredicate699, r_bPtxPredicate700, r_bPtxPredicate701,
		r_bPtxPredicate702, r_bPtxPredicate703, r_bPtxPredicate704, r_bPtxPredicate705, r_bPtxPredicate706,
		r_bPtxPredicate707, r_bPtxPredicate708;
	bool r_bPtxPredicate709, r_bPtxPredicate710, r_bPtxPredicate711, r_bPtxPredicate712, r_bPtxPredicate713,
		r_bPtxPredicate714, r_bPtxPredicate715, r_bPtxPredicate716, r_bPtxPredicate717, r_bPtxPredicate718,
		r_bPtxPredicate719, r_bPtxPredicate720;
	bool r_bPtxPredicate721, r_bPtxPredicate722, r_bPtxPredicate723, r_bPtxPredicate724, r_bPtxPredicate725,
		r_bPtxPredicate726, r_bPtxPredicate727, r_bPtxPredicate728, r_bPtxPredicate729, r_bPtxPredicate730,
		r_bPtxPredicate731, r_bPtxPredicate732;
	bool r_bPtxPredicate733, r_bPtxPredicate734, r_bPtxPredicate735, r_bPtxPredicate736, r_bPtxPredicate737,
		r_bPtxPredicate738, r_bPtxPredicate739, r_bPtxPredicate740, r_bPtxPredicate741, r_bPtxPredicate742,
		r_bPtxPredicate743, r_bPtxPredicate744;
	bool r_bPtxPredicate745, r_bPtxPredicate746, r_bPtxPredicate747, r_bPtxPredicate748, r_bPtxPredicate749,
		r_bPtxPredicate750, r_bPtxPredicate751, r_bPtxPredicate752, r_bPtxPredicate753, r_bPtxPredicate754,
		r_bPtxPredicate755, r_bPtxPredicate756;
	bool r_bPtxPredicate757, r_bPtxPredicate758, r_bPtxPredicate759, r_bPtxPredicate760, r_bPtxPredicate761,
		r_bPtxPredicate762, r_bPtxPredicate763, r_bPtxPredicate764, r_bPtxPredicate765, r_bPtxPredicate766,
		r_bPtxPredicate767, r_bPtxPredicate768;
	bool r_bPtxPredicate769, r_bPtxPredicate770, r_bPtxPredicate771, r_bPtxPredicate772, r_bPtxPredicate773,
		r_bPtxPredicate774, r_bPtxPredicate775, r_bPtxPredicate776, r_bPtxPredicate777, r_bPtxPredicate778,
		r_bPtxPredicate779, r_bPtxPredicate780;
	bool r_bPtxPredicate781, r_bPtxPredicate782, r_bPtxPredicate783, r_bPtxPredicate784, r_bPtxPredicate785,
		r_bPtxPredicate786, r_bPtxPredicate787, r_bPtxPredicate788, r_bPtxPredicate789, r_bPtxPredicate790,
		r_bPtxPredicate791, r_bPtxPredicate792;
	bool r_bPtxPredicate793, r_bPtxPredicate794, r_bPtxPredicate795, r_bPtxPredicate796, r_bPtxPredicate797,
		r_bPtxPredicate798, r_bPtxPredicate799, r_bPtxPredicate800, r_bPtxPredicate801, r_bPtxPredicate802,
		r_bPtxPredicate803, r_bPtxPredicate804;
	bool r_bPtxPredicate805, r_bPtxPredicate806, r_bPtxPredicate807, r_bPtxPredicate808, r_bPtxPredicate809,
		r_bPtxPredicate810, r_bPtxPredicate811, r_bPtxPredicate812, r_bPtxPredicate813, r_bPtxPredicate814,
		r_bPtxPredicate815, r_bPtxPredicate816;
	bool r_bPtxPredicate817, r_bPtxPredicate818, r_bPtxPredicate819, r_bPtxPredicate820, r_bPtxPredicate821,
		r_bPtxPredicate822, r_bPtxPredicate823, r_bPtxPredicate824, r_bPtxPredicate825, r_bPtxPredicate826,
		r_bPtxPredicate827, r_bPtxPredicate828;
	bool r_bPtxPredicate829, r_bPtxPredicate830, r_bPtxPredicate831, r_bPtxPredicate832, r_bPtxPredicate833,
		r_bPtxPredicate834, r_bPtxPredicate835, r_bPtxPredicate836, r_bPtxPredicate837, r_bPtxPredicate838,
		r_bPtxPredicate839, r_bPtxPredicate840;
	bool r_bPtxPredicate841, r_bPtxPredicate842, r_bPtxPredicate843, r_bPtxPredicate844, r_bPtxPredicate845,
		r_bPtxPredicate846, r_bPtxPredicate847, r_bPtxPredicate848, r_bPtxPredicate849, r_bPtxPredicate850,
		r_bPtxPredicate851, r_bPtxPredicate852;
	bool r_bPtxPredicate853, r_bPtxPredicate854, r_bPtxPredicate855, r_bPtxPredicate856, r_bPtxPredicate857,
		r_bPtxPredicate858, r_bPtxPredicate859, r_bPtxPredicate860, r_bPtxPredicate861, r_bPtxPredicate862,
		r_bPtxPredicate863, r_bPtxPredicate864;
	bool r_bPtxPredicate865, r_bPtxPredicate866, r_bPtxPredicate867, r_bPtxPredicate868, r_bPtxPredicate869,
		r_bPtxPredicate870, r_bPtxPredicate871, r_bPtxPredicate872, r_bPtxPredicate873, r_bPtxPredicate874,
		r_bPtxPredicate875, r_bPtxPredicate876;
	bool r_bPtxPredicate877, r_bPtxPredicate878, r_bPtxPredicate879, r_bPtxPredicate880, r_bPtxPredicate881,
		r_bPtxPredicate882, r_bPtxPredicate883, r_bPtxPredicate884, r_bPtxPredicate885, r_bPtxPredicate886,
		r_bPtxPredicate887, r_bPtxPredicate888;
	bool r_bPtxPredicate889, r_bPtxPredicate890, r_bPtxPredicate891, r_bPtxPredicate892, r_bPtxPredicate893,
		r_bPtxPredicate894, r_bPtxPredicate895, r_bPtxPredicate896, r_bPtxPredicate897, r_bPtxPredicate898,
		r_bPtxPredicate899, r_bPtxPredicate900;
	bool r_bPtxPredicate901, r_bPtxPredicate902, r_bPtxPredicate903, r_bPtxPredicate904, r_bPtxPredicate905,
		r_bPtxPredicate906, r_bPtxPredicate907, r_bPtxPredicate908, r_bPtxPredicate909, r_bPtxPredicate910,
		r_bPtxPredicate911, r_bPtxPredicate912;
	bool r_bPtxPredicate913, r_bPtxPredicate914, r_bPtxPredicate915, r_bPtxPredicate916, r_bPtxPredicate917,
		r_bPtxPredicate918, r_bPtxPredicate919, r_bPtxPredicate920, r_bPtxPredicate921, r_bPtxPredicate922,
		r_bPtxPredicate923, r_bPtxPredicate924;
	bool r_bPtxPredicate925, r_bPtxPredicate926, r_bPtxPredicate927, r_bPtxPredicate928, r_bPtxPredicate929,
		r_bPtxPredicate930, r_bPtxPredicate931, r_bPtxPredicate932, r_bPtxPredicate933, r_bPtxPredicate934,
		r_bPtxPredicate935, r_bPtxPredicate936;
	bool r_bPtxPredicate937, r_bPtxPredicate938, r_bPtxPredicate939, r_bPtxPredicate940, r_bPtxPredicate941,
		r_bPtxPredicate942, r_bPtxPredicate943, r_bPtxPredicate944, r_bPtxPredicate945, r_bPtxPredicate946,
		r_bPtxPredicate947, r_bPtxPredicate948;
	bool r_bPtxPredicate949, r_bPtxPredicate950, r_bPtxPredicate951, r_bPtxPredicate952, r_bPtxPredicate953,
		r_bPtxPredicate954, r_bPtxPredicate955, r_bPtxPredicate956, r_bPtxPredicate957, r_bPtxPredicate958,
		r_bPtxPredicate959, r_bPtxPredicate960;
	bool r_bPtxPredicate961, r_bPtxPredicate962, r_bPtxPredicate963, r_bPtxPredicate964, r_bPtxPredicate965,
		r_bPtxPredicate966, r_bPtxPredicate967, r_bPtxPredicate968, r_bPtxPredicate969, r_bPtxPredicate970,
		r_bPtxPredicate971, r_bPtxPredicate972;
	bool r_bPtxPredicate973, r_bPtxPredicate974, r_bPtxPredicate975, r_bPtxPredicate976, r_bPtxPredicate977,
		r_bPtxPredicate978, r_bPtxPredicate979, r_bPtxPredicate980, r_bPtxPredicate981, r_bPtxPredicate982,
		r_bPtxPredicate983, r_bPtxPredicate984;
	bool r_bPtxPredicate985, r_bPtxPredicate986, r_bPtxPredicate987, r_bPtxPredicate988, r_bPtxPredicate989,
		r_bPtxPredicate990, r_bPtxPredicate991, r_bPtxPredicate992, r_bPtxPredicate993, r_bPtxPredicate994,
		r_bPtxPredicate995, r_bPtxPredicate996;
	bool r_bPtxPredicate997, r_bPtxPredicate998, r_bPtxPredicate999, r_bPtxPredicate1000, r_bPtxPredicate1001,
		r_bPtxPredicate1002, r_bPtxPredicate1003, r_bPtxPredicate1004, r_bPtxPredicate1005,
		r_bPtxPredicate1006, r_bPtxPredicate1007, r_bPtxPredicate1008;
	bool r_bPtxPredicate1009, r_bPtxPredicate1010, r_bPtxPredicate1011, r_bPtxPredicate1012,
		r_bPtxPredicate1013, r_bPtxPredicate1014, r_bPtxPredicate1015, r_bPtxPredicate1016,
		r_bPtxPredicate1017, r_bPtxPredicate1018, r_bPtxPredicate1019, r_bPtxPredicate1020;
	bool r_bPtxPredicate1021, r_bPtxPredicate1022, r_bPtxPredicate1023, r_bPtxPredicate1024,
		r_bPtxPredicate1025, r_bPtxPredicate1026, r_bPtxPredicate1027, r_bPtxPredicate1028,
		r_bPtxPredicate1029, r_bPtxPredicate1030, r_bPtxPredicate1031, r_bPtxPredicate1032;
	bool r_bPtxPredicate1033, r_bPtxPredicate1034, r_bPtxPredicate1035, r_bPtxPredicate1036,
		r_bPtxPredicate1037, r_bPtxPredicate1038, r_bPtxPredicate1039, r_bPtxPredicate1040,
		r_bPtxPredicate1041, r_bPtxPredicate1042, r_bPtxPredicate1043, r_bPtxPredicate1044;
	bool r_bPtxPredicate1045, r_bPtxPredicate1046, r_bPtxPredicate1047, r_bPtxPredicate1048,
		r_bPtxPredicate1049, r_bPtxPredicate1050, r_bPtxPredicate1051, r_bPtxPredicate1052,
		r_bPtxPredicate1053, r_bPtxPredicate1054, r_bPtxPredicate1055, r_bPtxPredicate1056;
	bool r_bPtxPredicate1057, r_bPtxPredicate1058, r_bPtxPredicate1059, r_bPtxPredicate1060,
		r_bPtxPredicate1061, r_bPtxPredicate1062, r_bPtxPredicate1063, r_bPtxPredicate1064,
		r_bPtxPredicate1065, r_bPtxPredicate1066, r_bPtxPredicate1067, r_bPtxPredicate1068;
	bool r_bPtxPredicate1069, r_bPtxPredicate1070, r_bPtxPredicate1071, r_bPtxPredicate1072,
		r_bPtxPredicate1073, r_bPtxPredicate1074, r_bPtxPredicate1075, r_bPtxPredicate1076,
		r_bPtxPredicate1077, r_bPtxPredicate1078, r_bPtxPredicate1079, r_bPtxPredicate1080;
	bool r_bPtxPredicate1081, r_bPtxPredicate1082, r_bPtxPredicate1083, r_bPtxPredicate1084,
		r_bPtxPredicate1085, r_bPtxPredicate1086, r_bPtxPredicate1087, r_bPtxPredicate1088,
		r_bPtxPredicate1089, r_bPtxPredicate1090, r_bPtxPredicate1091, r_bPtxPredicate1092;
	bool r_bPtxPredicate1093, r_bPtxPredicate1094, r_bPtxPredicate1095, r_bPtxPredicate1096,
		r_bPtxPredicate1097, r_bPtxPredicate1098, r_bPtxPredicate1099, r_bPtxPredicate1100,
		r_bPtxPredicate1101, r_bPtxPredicate1102, r_bPtxPredicate1103, r_bPtxPredicate1104;
	bool r_bPtxPredicate1105, r_bPtxPredicate1106, r_bPtxPredicate1107, r_bPtxPredicate1108,
		r_bPtxPredicate1109, r_bPtxPredicate1110, r_bPtxPredicate1111, r_bPtxPredicate1112,
		r_bPtxPredicate1113, r_bPtxPredicate1114, r_bPtxPredicate1115, r_bPtxPredicate1116;
	bool r_bPtxPredicate1117, r_bPtxPredicate1118, r_bPtxPredicate1119, r_bPtxPredicate1120,
		r_bPtxPredicate1121, r_bPtxPredicate1122, r_bPtxPredicate1123, r_bPtxPredicate1124,
		r_bPtxPredicate1125, r_bPtxPredicate1126, r_bPtxPredicate1127, r_bPtxPredicate1128;
	bool r_bPtxPredicate1129, r_bPtxPredicate1130, r_bPtxPredicate1131, r_bPtxPredicate1132,
		r_bPtxPredicate1133, r_bPtxPredicate1134, r_bPtxPredicate1135, r_bPtxPredicate1136,
		r_bPtxPredicate1137, r_bPtxPredicate1138, r_bPtxPredicate1139, r_bPtxPredicate1140;
	bool r_bPtxPredicate1141, r_bPtxPredicate1142, r_bPtxPredicate1143, r_bPtxPredicate1144,
		r_bPtxPredicate1145;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
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
	uint32_t r_PtxRegister169, r_PtxRegister170, r_HeightBits, r_WidthBits, r_CtaX, r_CtaYAtPtx21,
		r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178, r_PtxRegister179,
		r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4,
		r_WidthSignBits, r_WidthDiv4Bias, r_WidthBiasedForDiv4, r_ThreadX, r_PtxRegister190, r_PtxRegister191,
		r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx66R197,
		r_LaneIndexAtPtx82, r_LaneIndexAtPtx90, r_LaneIndexAtPtx99, r_LaneIndexAtPtx108, r_LaneIndexAtPtx117,
		r_LaneIndexAtPtx126, r_LaneIndexAtPtx135;
	uint32_t r_LaneIndexAtPtx144, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_LaneIndexAtPtx222, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244, r_LaneIndexAtPtx293,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_LaneIndexAtPtx355, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_LaneIndexAtPtx416, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_LaneIndexAtPtx478, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PtxRegister301, r_PtxRegister302, r_PtxRegister303, r_PtxRegister304, r_PtxRegister305,
		r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309, r_PtxRegister310,
		r_LaneIndexAtPtx539, r_PtxRegister312;
	uint32_t r_PackedHalf2AtPtx68R313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316, r_PtxRegister317,
		r_PtxRegister318, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321, r_PtxRegister322,
		r_PtxRegister323, r_PtxRegister324;
	uint32_t r_PtxRegister325, r_LaneIndexAtPtx571, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PtxRegister331, r_PtxRegister332, r_PtxRegister333, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_PtxRegister337, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341,
		r_PtxRegister342, r_PtxRegister343, r_PtxRegister344, r_PtxRegister345, r_PtxRegister346,
		r_PtxRegister347, r_LaneIndexAtPtx620;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_PtxRegister353,
		r_PtxRegister354, r_PtxRegister355, r_PtxRegister356, r_PtxRegister357, r_PtxRegister358,
		r_PtxRegister359, r_PtxRegister360;
	uint32_t r_PtxRegister361, r_PtxRegister362, r_PtxRegister363, r_PtxRegister364, r_PtxRegister365,
		r_PtxRegister366, r_PtxRegister367, r_PtxRegister368, r_LaneIndexAtPtx669, r_PtxRegister370,
		r_PtxRegister371, r_PtxRegister372;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_PtxRegister375, r_PtxRegister376, r_PtxRegister377,
		r_PtxRegister378, r_PtxRegister379, r_PtxRegister380, r_PtxRegister381, r_PtxRegister382,
		r_PtxRegister383, r_PtxRegister384;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_PtxRegister387, r_PtxRegister388, r_LaneIndexAtPtx718,
		r_PtxRegister390, r_PtxRegister391, r_PtxRegister392, r_PtxRegister393, r_PtxRegister394,
		r_PtxRegister395, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_PtxRegister398, r_PtxRegister399, r_PtxRegister400, r_PtxRegister401,
		r_PtxRegister402, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405, r_PtxRegister406,
		r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_LaneIndexAtPtx767, r_PtxRegister411, r_PtxRegister412, r_PtxRegister413,
		r_PtxRegister414, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417, r_PtxRegister418,
		r_PtxRegister419, r_PtxRegister420;
	uint32_t r_PtxRegister421, r_PtxRegister422, r_PtxRegister423, r_PtxRegister424, r_PtxRegister425,
		r_PtxRegister426, r_PtxRegister427, r_PtxRegister428, r_PtxRegister429, r_LaneIndexAtPtx816,
		r_PtxRegister431, r_PtxRegister432;
	uint32_t r_PtxRegister433, r_PtxRegister434, r_PtxRegister435, r_PtxRegister436, r_PtxRegister437,
		r_PtxRegister438, r_PtxRegister439, r_PtxRegister440, r_PtxRegister441, r_PtxRegister442,
		r_PtxRegister443, r_PtxRegister444;
	uint32_t r_PtxRegister445, r_PtxRegister446, r_PtxRegister447, r_PtxRegister448, r_PtxRegister449,
		r_PtxRegister450, r_LaneIndexAtPtx865, r_PtxRegister452, r_PtxRegister453, r_PtxRegister454,
		r_PtxRegister455, r_PtxRegister456;
	uint32_t r_PtxRegister457, r_PtxRegister458, r_PtxRegister459, r_PtxRegister460, r_PtxRegister461,
		r_PtxRegister462, r_PtxRegister463, r_PtxRegister464, r_PtxRegister465, r_PtxRegister466,
		r_PtxRegister467, r_PtxRegister468;
	uint32_t r_PtxRegister469, r_PtxRegister470, r_LaneIndexAtPtx914, r_PtxRegister472, r_PtxRegister473,
		r_PtxRegister474, r_PtxRegister475, r_PtxRegister476, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_PtxRegister481, r_PtxRegister482, r_PtxRegister483, r_PtxRegister484, r_PtxRegister485,
		r_PtxRegister486, r_PtxRegister487, r_PtxRegister488, r_PtxRegister489, r_PtxRegister490,
		r_PtxRegister491, r_LaneIndexAtPtx963;
	uint32_t r_PtxRegister493, r_PtxRegister494, r_PtxRegister495, r_PtxRegister496, r_PtxRegister497,
		r_PtxRegister498, r_PtxRegister499, r_PtxRegister500, r_PtxRegister501, r_PtxRegister502,
		r_PtxRegister503, r_PtxRegister504;
	uint32_t r_PtxRegister505, r_PtxRegister506, r_PtxRegister507, r_PtxRegister508, r_PtxRegister509,
		r_PtxRegister510, r_PtxRegister511, r_LaneIndexAtPtx1012, r_PtxRegister513, r_PtxRegister514,
		r_PtxRegister515, r_PtxRegister516;
	uint32_t r_PtxRegister517, r_PtxRegister518, r_PtxRegister519, r_PtxRegister520, r_PtxRegister521,
		r_PtxRegister522, r_PtxRegister523, r_PtxRegister524, r_PtxRegister525, r_PtxRegister526,
		r_PtxRegister527, r_PtxRegister528;
	uint32_t r_PtxRegister529, r_PtxRegister530, r_PtxRegister531, r_PtxRegister532, r_LaneIndexAtPtx1061,
		r_PtxRegister534, r_PtxRegister535, r_PtxRegister536, r_PtxRegister537, r_PtxRegister538,
		r_PtxRegister539, r_PtxRegister540;
	uint32_t r_PtxRegister541, r_PtxRegister542, r_PtxRegister543, r_PtxRegister544, r_PtxRegister545,
		r_PtxRegister546, r_PtxRegister547, r_PtxRegister548, r_PtxRegister549, r_PtxRegister550,
		r_PtxRegister551, r_PtxRegister552;
	uint32_t r_LaneIndexAtPtx1110, r_PtxRegister554, r_PtxRegister555, r_PtxRegister556, r_PtxRegister557,
		r_PtxRegister558, r_PtxRegister559, r_PtxRegister560, r_PtxRegister561, r_PtxRegister562,
		r_PtxRegister563, r_PtxRegister564;
	uint32_t r_PtxRegister565, r_PtxRegister566, r_PtxRegister567, r_PtxRegister568, r_PtxRegister569,
		r_PtxRegister570, r_PtxRegister571, r_PtxRegister572, r_PtxRegister573, r_LaneIndexAtPtx1159,
		r_PtxRegister575, r_PtxRegister576;
	uint32_t r_PtxRegister577, r_PtxRegister578, r_PtxRegister579, r_PtxRegister580, r_PtxRegister581,
		r_PtxRegister582, r_PtxRegister583, r_PtxRegister584, r_PtxRegister585, r_PtxRegister586,
		r_PtxRegister587, r_PtxRegister588;
	uint32_t r_PtxRegister589, r_PtxRegister590, r_PtxRegister591, r_PtxRegister592, r_PtxRegister593,
		r_LaneIndexAtPtx1208, r_PtxRegister595, r_PtxRegister596, r_PtxRegister597, r_PtxRegister598,
		r_PtxRegister599, r_PtxRegister600;
	uint32_t r_PtxRegister601, r_PtxRegister602, r_PtxRegister603, r_PtxRegister604, r_PtxRegister605,
		r_PtxRegister606, r_PtxRegister607, r_PtxRegister608, r_PtxRegister609, r_PtxRegister610,
		r_PtxRegister611, r_PtxRegister612;
	uint32_t r_PtxRegister613, r_PtxRegister614, r_LaneIndexAtPtx1257, r_PtxRegister616, r_PtxRegister617,
		r_PtxRegister618, r_PtxRegister619, r_PtxRegister620, r_PtxRegister621, r_PtxRegister622,
		r_PtxRegister623, r_PtxRegister624;
	uint32_t r_PtxRegister625, r_PtxRegister626, r_PtxRegister627, r_PtxRegister628, r_PtxRegister629,
		r_PtxRegister630, r_PtxRegister631, r_PtxRegister632, r_PtxRegister633, r_PtxRegister634,
		r_LaneIndexAtPtx1306, r_PtxRegister636;
	uint32_t r_PtxRegister637, r_PtxRegister638, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_PtxRegister646,
		r_PtxRegister647, r_PtxRegister648;
	uint32_t r_PtxRegister649, r_PtxRegister650, r_PtxRegister651, r_PtxRegister652, r_PtxRegister653,
		r_PtxRegister654, r_PtxRegister655, r_LaneIndexAtPtx1355, r_PtxRegister657, r_PtxRegister658,
		r_PtxRegister659, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_PtxRegister662, r_PtxRegister663, r_PtxRegister664, r_PtxRegister665,
		r_PtxRegister666, r_PtxRegister667, r_PtxRegister668, r_PtxRegister669, r_PtxRegister670,
		r_PtxRegister671, r_PtxRegister672;
	uint32_t r_PtxRegister673, r_PtxRegister674, r_PtxRegister675, r_PtxRegister676, r_LaneIndexAtPtx1402,
		r_PtxRegister678, r_PtxRegister679, r_PtxRegister680, r_PtxRegister681, r_PtxRegister682,
		r_PtxRegister683, r_PtxRegister684;
	uint32_t r_PtxRegister685, r_PtxRegister686, r_PtxRegister687, r_PtxRegister688, r_PtxRegister689,
		r_PtxRegister690, r_PtxRegister691, r_PtxRegister692, r_PtxRegister693, r_PtxRegister694,
		r_PtxRegister695, r_PtxRegister696;
	uint32_t r_PtxRegister697, r_PtxRegister698, r_LaneIndexAtPtx1450, r_PtxRegister700, r_PtxRegister701,
		r_PtxRegister702, r_PtxRegister703, r_PtxRegister704, r_PtxRegister705, r_PtxRegister706,
		r_PtxRegister707, r_PtxRegister708;
	uint32_t r_PtxRegister709, r_PtxRegister710, r_PtxRegister711, r_PtxRegister712, r_PtxRegister713,
		r_PtxRegister714, r_PtxRegister715, r_PtxRegister716, r_PtxRegister717, r_PtxRegister718,
		r_PtxRegister719, r_LaneIndexAtPtx1497;
	uint32_t r_PtxRegister721, r_PtxRegister722, r_PtxRegister723, r_PtxRegister724, r_PtxRegister725,
		r_PtxRegister726, r_PtxRegister727, r_PtxRegister728, r_PtxRegister729, r_PtxRegister730,
		r_PtxRegister731, r_PtxRegister732;
	uint32_t r_PtxRegister733, r_PtxRegister734, r_PtxRegister735, r_PtxRegister736, r_PtxRegister737,
		r_PtxRegister738, r_PtxRegister739, r_PtxRegister740, r_PtxRegister741, r_LaneIndexAtPtx1545,
		r_PtxRegister743, r_PtxRegister744;
	uint32_t r_PtxRegister745, r_PtxRegister746, r_PtxRegister747, r_PtxRegister748, r_PtxRegister749,
		r_PtxRegister750, r_PtxRegister751, r_PtxRegister752, r_PtxRegister753, r_PtxRegister754,
		r_PtxRegister755, r_PtxRegister756;
	uint32_t r_PtxRegister757, r_PtxRegister758, r_PtxRegister759, r_PtxRegister760, r_PtxRegister761,
		r_PtxRegister762, r_LaneIndexAtPtx1592, r_PtxRegister764, r_PtxRegister765, r_PtxRegister766,
		r_PtxRegister767, r_PtxRegister768;
	uint32_t r_PtxRegister769, r_PtxRegister770, r_PtxRegister771, r_PtxRegister772, r_PtxRegister773,
		r_PtxRegister774, r_PtxRegister775, r_PtxRegister776, r_PtxRegister777, r_PtxRegister778,
		r_PtxRegister779, r_PtxRegister780;
	uint32_t r_PtxRegister781, r_PtxRegister782, r_PtxRegister783, r_PtxRegister784, r_LaneIndexAtPtx1640,
		r_PtxRegister786, r_PtxRegister787, r_PtxRegister788, r_PtxRegister789, r_PtxRegister790,
		r_PtxRegister791, r_PtxRegister792;
	uint32_t r_PtxRegister793, r_PtxRegister794, r_PtxRegister795, r_PtxRegister796, r_PtxRegister797,
		r_PtxRegister798, r_PtxRegister799, r_PtxRegister800, r_PtxRegister801, r_PtxRegister802,
		r_PtxRegister803, r_PtxRegister804;
	uint32_t r_PtxRegister805, r_LaneIndexAtPtx1687, r_PtxRegister807, r_PtxRegister808, r_PtxRegister809,
		r_PtxRegister810, r_PtxRegister811, r_PtxRegister812, r_PtxRegister813, r_PtxRegister814,
		r_PtxRegister815, r_PtxRegister816;
	uint32_t r_PtxRegister817, r_PtxRegister818, r_PtxRegister819, r_PtxRegister820, r_PtxRegister821,
		r_PtxRegister822, r_PtxRegister823, r_PtxRegister824, r_PtxRegister825, r_PtxRegister826,
		r_PtxRegister827, r_LaneIndexAtPtx1735;
	uint32_t r_PtxRegister829, r_PtxRegister830, r_PtxRegister831, r_PtxRegister832, r_PtxRegister833,
		r_PtxRegister834, r_PtxRegister835, r_PtxRegister836, r_PtxRegister837, r_PtxRegister838,
		r_PtxRegister839, r_PtxRegister840;
	uint32_t r_PtxRegister841, r_PtxRegister842, r_PtxRegister843, r_PtxRegister844, r_PtxRegister845,
		r_PtxRegister846, r_PtxRegister847, r_PtxRegister848, r_LaneIndexAtPtx1782, r_PtxRegister850,
		r_PtxRegister851, r_PtxRegister852;
	uint32_t r_PtxRegister853, r_PtxRegister854, r_PtxRegister855, r_PtxRegister856, r_PtxRegister857,
		r_PtxRegister858, r_PtxRegister859, r_PtxRegister860, r_PtxRegister861, r_PtxRegister862,
		r_PtxRegister863, r_PtxRegister864;
	uint32_t r_PtxRegister865, r_PtxRegister866, r_PtxRegister867, r_PtxRegister868, r_PtxRegister869,
		r_PtxRegister870, r_LaneIndexAtPtx1830, r_PtxRegister872, r_PtxRegister873, r_PtxRegister874,
		r_PtxRegister875, r_PtxRegister876;
	uint32_t r_PtxRegister877, r_PtxRegister878, r_PtxRegister879, r_PtxRegister880, r_PtxRegister881,
		r_PtxRegister882, r_PtxRegister883, r_PtxRegister884, r_PtxRegister885, r_PtxRegister886,
		r_PtxRegister887, r_PtxRegister888;
	uint32_t r_PtxRegister889, r_PtxRegister890, r_PtxRegister891, r_LaneIndexAtPtx1877, r_PtxRegister893,
		r_PtxRegister894, r_PtxRegister895, r_PtxRegister896, r_PtxRegister897, r_PtxRegister898,
		r_PtxRegister899, r_PtxRegister900;
	uint32_t r_PtxRegister901, r_PtxRegister902, r_PtxRegister903, r_PtxRegister904, r_PtxRegister905,
		r_PtxRegister906, r_PtxRegister907, r_PtxRegister908, r_PtxRegister909, r_PtxRegister910,
		r_PtxRegister911, r_PtxRegister912;
	uint32_t r_PtxRegister913, r_LaneIndexAtPtx1925, r_PtxRegister915, r_PtxRegister916, r_PtxRegister917,
		r_PtxRegister918, r_PtxRegister919, r_PtxRegister920, r_PtxRegister921, r_PtxRegister922,
		r_PtxRegister923, r_PtxRegister924;
	uint32_t r_PtxRegister925, r_PtxRegister926, r_PtxRegister927, r_PtxRegister928, r_PtxRegister929,
		r_PtxRegister930, r_PtxRegister931, r_PtxRegister932, r_PtxRegister933, r_PtxRegister934,
		r_LaneIndexAtPtx1972, r_PtxRegister936;
	uint32_t r_PtxRegister937, r_PtxRegister938, r_PtxRegister939, r_PtxRegister940, r_PtxRegister941,
		r_PtxRegister942, r_PtxRegister943, r_PtxRegister944, r_PtxRegister945, r_PtxRegister946,
		r_PtxRegister947, r_PtxRegister948;
	uint32_t r_PtxRegister949, r_PtxRegister950, r_PtxRegister951, r_PtxRegister952, r_PtxRegister953,
		r_PtxRegister954, r_PtxRegister955, r_PtxRegister956, r_LaneIndexAtPtx2020, r_PtxRegister958,
		r_PtxRegister959, r_PtxRegister960;
	uint32_t r_PtxRegister961, r_PtxRegister962, r_PtxRegister963, r_PtxRegister964, r_PtxRegister965,
		r_PtxRegister966, r_PtxRegister967, r_PtxRegister968, r_PtxRegister969, r_PtxRegister970,
		r_PtxRegister971, r_PtxRegister972;
	uint32_t r_PtxRegister973, r_PtxRegister974, r_PtxRegister975, r_PtxRegister976, r_PtxRegister977,
		r_LaneIndexAtPtx2067, r_PtxRegister979, r_PtxRegister980, r_PtxRegister981, r_PtxRegister982,
		r_PtxRegister983, r_PtxRegister984;
	uint32_t r_PtxRegister985, r_PtxRegister986, r_PtxRegister987, r_PtxRegister988, r_PtxRegister989,
		r_PtxRegister990, r_PtxRegister991, r_PtxRegister992, r_PtxRegister993, r_PtxRegister994,
		r_PtxRegister995, r_PtxRegister996;
	uint32_t r_PtxRegister997, r_PtxRegister998, r_PtxRegister999, r_LaneIndexAtPtx2115, r_PtxRegister1001,
		r_PtxRegister1002, r_PtxRegister1003, r_PtxRegister1004, r_PtxRegister1005, r_PtxRegister1006,
		r_PtxRegister1007, r_PtxRegister1008;
	uint32_t r_PtxRegister1009, r_PtxRegister1010, r_PtxRegister1011, r_PtxRegister1012, r_PtxRegister1013,
		r_PtxRegister1014, r_PtxRegister1015, r_PtxRegister1016, r_PtxRegister1017, r_PtxRegister1018,
		r_PtxRegister1019, r_PtxRegister1020;
	uint32_t r_LaneIndexAtPtx2164, r_PtxRegister1022, r_PtxRegister1023, r_PtxRegister1024, r_PtxRegister1025,
		r_PtxRegister1026, r_PtxRegister1027, r_PtxRegister1028, r_PtxRegister1029, r_PtxRegister1030,
		r_PtxRegister1031, r_PtxRegister1032;
	uint32_t r_PtxRegister1033, r_PtxRegister1034, r_PtxRegister1035, r_PtxRegister1036, r_PtxRegister1037,
		r_PtxRegister1038, r_PtxRegister1039, r_PtxRegister1040, r_PtxRegister1041, r_LaneIndexAtPtx2213,
		r_PtxRegister1043, r_PtxRegister1044;
	uint32_t r_PtxRegister1045, r_PtxRegister1046, r_PtxRegister1047, r_PtxRegister1048, r_PtxRegister1049,
		r_PtxRegister1050, r_PtxRegister1051, r_PtxRegister1052, r_PtxRegister1053, r_PtxRegister1054,
		r_PtxRegister1055, r_PtxRegister1056;
	uint32_t r_PtxRegister1057, r_PtxRegister1058, r_PtxRegister1059, r_PtxRegister1060, r_PtxRegister1061,
		r_PtxRegister1062, r_LaneIndexAtPtx2262, r_PtxRegister1064, r_PtxRegister1065, r_PtxRegister1066,
		r_PtxRegister1067, r_PtxRegister1068;
	uint32_t r_PtxRegister1069, r_PtxRegister1070, r_PtxRegister1071, r_PtxRegister1072, r_PtxRegister1073,
		r_PtxRegister1074, r_PtxRegister1075, r_PtxRegister1076, r_PtxRegister1077, r_PtxRegister1078,
		r_PtxRegister1079, r_PtxRegister1080;
	uint32_t r_PtxRegister1081, r_PtxRegister1082, r_PtxRegister1083, r_LaneIndexAtPtx2311, r_PtxRegister1085,
		r_PtxRegister1086, r_PtxRegister1087, r_PtxRegister1088, r_PtxRegister1089, r_PtxRegister1090,
		r_PtxRegister1091, r_PtxRegister1092;
	uint32_t r_PtxRegister1093, r_PtxRegister1094, r_PtxRegister1095, r_PtxRegister1096, r_PtxRegister1097,
		r_PtxRegister1098, r_PtxRegister1099, r_PtxRegister1100, r_PtxRegister1101, r_PtxRegister1102,
		r_PtxRegister1103, r_PtxRegister1104;
	uint32_t r_LaneIndexAtPtx2360, r_PtxRegister1106, r_PtxRegister1107, r_PtxRegister1108, r_PtxRegister1109,
		r_PtxRegister1110, r_PtxRegister1111, r_PtxRegister1112, r_PtxRegister1113, r_PtxRegister1114,
		r_PtxRegister1115, r_PtxRegister1116;
	uint32_t r_PtxRegister1117, r_PtxRegister1118, r_PtxRegister1119, r_PtxRegister1120, r_PtxRegister1121,
		r_PtxRegister1122, r_PtxRegister1123, r_PtxRegister1124, r_PtxRegister1125, r_LaneIndexAtPtx2409,
		r_PtxRegister1127, r_PtxRegister1128;
	uint32_t r_PtxRegister1129, r_PtxRegister1130, r_PtxRegister1131, r_PtxRegister1132, r_PtxRegister1133,
		r_PtxRegister1134, r_PtxRegister1135, r_PtxRegister1136, r_PtxRegister1137, r_PtxRegister1138,
		r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_PtxRegister1141, r_PtxRegister1142, r_PtxRegister1143, r_PtxRegister1144, r_PtxRegister1145,
		r_PtxRegister1146, r_LaneIndexAtPtx2458, r_PtxRegister1148, r_PtxRegister1149, r_PtxRegister1150,
		r_PtxRegister1151, r_PtxRegister1152;
	uint32_t r_PtxRegister1153, r_PtxRegister1154, r_PtxRegister1155, r_PtxRegister1156, r_PtxRegister1157,
		r_PtxRegister1158, r_PtxRegister1159, r_PtxRegister1160, r_PtxRegister1161, r_PtxRegister1162,
		r_PtxRegister1163, r_PtxRegister1164;
	uint32_t r_PtxRegister1165, r_PtxRegister1166, r_PtxRegister1167, r_LaneIndexAtPtx2507, r_PtxRegister1169,
		r_PtxRegister1170, r_PtxRegister1171, r_PtxRegister1172, r_PtxRegister1173, r_PtxRegister1174,
		r_PtxRegister1175, r_PtxRegister1176;
	uint32_t r_PtxRegister1177, r_PtxRegister1178, r_PtxRegister1179, r_PtxRegister1180, r_PtxRegister1181,
		r_PtxRegister1182, r_PtxRegister1183, r_PtxRegister1184, r_PtxRegister1185, r_PtxRegister1186,
		r_PtxRegister1187, r_PtxRegister1188;
	uint32_t r_LaneIndexAtPtx2556, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PtxRegister1194, r_PtxRegister1195, r_PtxRegister1196, r_PtxRegister1197, r_PtxRegister1198,
		r_PtxRegister1199, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_PtxRegister1202, r_PtxRegister1203, r_PtxRegister1204, r_PtxRegister1205,
		r_PtxRegister1206, r_PtxRegister1207, r_PtxRegister1208, r_PtxRegister1209, r_LaneIndexAtPtx2605,
		r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_PtxRegister1218, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_LaneIndexAtPtx2654, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_PtxRegister1244, r_PtxRegister1245, r_PtxRegister1246,
		r_PtxRegister1247, r_PtxRegister1248;
	uint32_t r_PtxRegister1249, r_PtxRegister1250, r_PtxRegister1251, r_LaneIndexAtPtx2703, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_PtxRegister1257, r_PtxRegister1258,
		r_PtxRegister1259, r_PtxRegister1260;
	uint32_t r_PtxRegister1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264, r_PtxRegister1265,
		r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269, r_PtxRegister1270,
		r_PtxRegister1271, r_PtxRegister1272;
	uint32_t r_LaneIndexAtPtx2752, r_PtxRegister1274, r_PtxRegister1275, r_PtxRegister1276, r_PtxRegister1277,
		r_PtxRegister1278, r_PtxRegister1279, r_PtxRegister1280, r_PtxRegister1281, r_PtxRegister1282,
		r_PtxRegister1283, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_PtxRegister1292, r_PtxRegister1293, r_LaneIndexAtPtx2801,
		r_PtxRegister1295, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305, r_PtxRegister1306,
		r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_PtxRegister1310, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_LaneIndexAtPtx2850, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_PtxRegister1330,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_LaneIndexAtPtx2898, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_LaneIndexAtPtx2945, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_LaneIndexAtPtx2992;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_PtxRegister1399, r_PtxRegister1400, r_PtxRegister1401, r_LaneIndexAtPtx3039,
		r_PtxRegister1403, r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408, r_PtxRegister1409,
		r_PtxRegister1410, r_PtxRegister1411, r_PtxRegister1412, r_PtxRegister1413, r_PtxRegister1414,
		r_PtxRegister1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_PtxRegister1423, r_LaneIndexAtPtx3086, r_PtxRegister1425, r_PtxRegister1426,
		r_PtxRegister1427, r_PtxRegister1428;
	uint32_t r_PtxRegister1429, r_PtxRegister1430, r_PtxRegister1431, r_PtxRegister1432, r_PtxRegister1433,
		r_PtxRegister1434, r_PtxRegister1435, r_PtxRegister1436, r_PtxRegister1437, r_PtxRegister1438,
		r_PtxRegister1439, r_PtxRegister1440;
	uint32_t r_PtxRegister1441, r_PtxRegister1442, r_PtxRegister1443, r_PtxRegister1444, r_PtxRegister1445,
		r_LaneIndexAtPtx3133, r_PtxRegister1447, r_PtxRegister1448, r_PtxRegister1449, r_PtxRegister1450,
		r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_PtxRegister1453, r_PtxRegister1454, r_PtxRegister1455, r_PtxRegister1456, r_PtxRegister1457,
		r_PtxRegister1458, r_PtxRegister1459, r_PtxRegister1460, r_PtxRegister1461, r_PtxRegister1462,
		r_PtxRegister1463, r_PtxRegister1464;
	uint32_t r_PtxRegister1465, r_PtxRegister1466, r_PtxRegister1467, r_LaneIndexAtPtx3180, r_PtxRegister1469,
		r_PtxRegister1470, r_PtxRegister1471, r_PtxRegister1472, r_PtxRegister1473, r_PtxRegister1474,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PtxRegister1479, r_PtxRegister1480, r_PtxRegister1481,
		r_PtxRegister1482, r_PtxRegister1483, r_PtxRegister1484, r_PtxRegister1485, r_PtxRegister1486,
		r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_LaneIndexAtPtx3227, r_PtxRegister1491, r_PtxRegister1492, r_PtxRegister1493,
		r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497, r_PtxRegister1498,
		r_PtxRegister1499, r_PtxRegister1500;
	uint32_t r_PtxRegister1501, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_PtxRegister1505,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_PtxRegister1510,
		r_PtxRegister1511, r_LaneIndexAtPtx3274;
	uint32_t r_PtxRegister1513, r_PtxRegister1514, r_PtxRegister1515, r_PtxRegister1516, r_PtxRegister1517,
		r_PtxRegister1518, r_PtxRegister1519, r_PtxRegister1520, r_PtxRegister1521, r_PtxRegister1522,
		r_PtxRegister1523, r_PtxRegister1524;
	uint32_t r_PtxRegister1525, r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528, r_PtxRegister1529,
		r_PtxRegister1530, r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533, r_LaneIndexAtPtx3321,
		r_PtxRegister1535, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_PtxRegister1538, r_PtxRegister1539, r_PtxRegister1540, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PtxRegister1545, r_PtxRegister1546,
		r_PtxRegister1547, r_PtxRegister1548;
	uint32_t r_PtxRegister1549, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_PtxRegister1554, r_PtxRegister1555, r_LaneIndexAtPtx3368, r_PtxRegister1557, r_PtxRegister1558,
		r_PtxRegister1559, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_PtxRegister1563, r_PtxRegister1564, r_PtxRegister1565,
		r_PtxRegister1566, r_PtxRegister1567, r_PtxRegister1568, r_PtxRegister1569, r_PtxRegister1570,
		r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_PtxRegister1575, r_PtxRegister1576, r_PtxRegister1577,
		r_LaneIndexAtPtx3415, r_PtxRegister1579, r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
		r_PtxRegister1583, r_PtxRegister1584;
	uint32_t r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587, r_PtxRegister1588, r_PtxRegister1589,
		r_PtxRegister1590, r_PtxRegister1591, r_PtxRegister1592, r_PtxRegister1593, r_PtxRegister1594,
		r_PtxRegister1595, r_PtxRegister1596;
	uint32_t r_PtxRegister1597, r_PtxRegister1598, r_PtxRegister1599, r_PtxRegister1600, r_PtxRegister1601,
		r_LaneIndexAtPtx3464, r_PtxRegister1603, r_PtxRegister1604, r_PtxRegister1605, r_PtxRegister1606,
		r_PtxRegister1607, r_PtxRegister1608;
	uint32_t r_PtxRegister1609, r_PtxRegister1610, r_PtxRegister1611, r_PtxRegister1612, r_PtxRegister1613,
		r_PtxRegister1614, r_PtxRegister1615, r_PtxRegister1616, r_PtxRegister1617, r_PtxRegister1618,
		r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_LaneIndexAtPtx3513, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_PtxRegister1631, r_PtxRegister1632;
	uint32_t r_PtxRegister1633, r_PtxRegister1634, r_PtxRegister1635, r_PtxRegister1636, r_PtxRegister1637,
		r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640, r_PtxRegister1641, r_PtxRegister1642,
		r_PtxRegister1643, r_PtxRegister1644;
	uint32_t r_PtxRegister1645, r_PtxRegister1646, r_PtxRegister1647, r_PtxRegister1648, r_PtxRegister1649,
		r_PtxRegister1650, r_LaneIndexAtPtx3563, r_PtxRegister1652, r_PtxRegister1653, r_PtxRegister1654,
		r_PtxRegister1655, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_PtxRegister1658, r_PtxRegister1659, r_PtxRegister1660, r_PtxRegister1661,
		r_PtxRegister1662, r_PtxRegister1663, r_PtxRegister1664, r_PtxRegister1665, r_PtxRegister1666,
		r_PtxRegister1667, r_PtxRegister1668;
	uint32_t r_PtxRegister1669, r_PtxRegister1670, r_PtxRegister1671, r_PtxRegister1672, r_PtxRegister1673,
		r_PtxRegister1674, r_PtxRegister1675, r_LaneIndexAtPtx3612, r_PtxRegister1677, r_PtxRegister1678,
		r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_PtxRegister1689, r_PtxRegister1690,
		r_PtxRegister1691, r_PtxRegister1692;
	uint32_t r_PtxRegister1693, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_LaneIndexAtPtx3662, r_LaneIndexAtPtx3676,
		r_LaneIndexAtPtx3690, r_LaneIndexAtPtx3704, r_LaneIndexAtPtx3718;
	uint32_t r_LaneIndexAtPtx3732, r_LaneIndexAtPtx3746, r_LaneIndexAtPtx3763, r_LaneIndexAtPtx3779,
		r_LaneIndexAtPtx3794, r_LaneIndexAtPtx3808, r_LaneIndexAtPtx3825, r_LaneIndexAtPtx3841,
		r_LaneIndexAtPtx3856, r_LaneIndexAtPtx3870, r_LaneIndexAtPtx3887, r_LaneIndexAtPtx3903;
	uint32_t r_LaneIndexAtPtx3917, r_LaneIndexAtPtx3931, r_LaneIndexAtPtx3945, r_LaneIndexAtPtx3959,
		r_LaneIndexAtPtx3973, r_LaneIndexAtPtx3987, r_LaneIndexAtPtx4003, r_LaneIndexAtPtx4019,
		r_LaneIndexAtPtx4033, r_LaneIndexAtPtx4047, r_LaneIndexAtPtx4063, r_LaneIndexAtPtx4079;
	uint32_t r_LaneIndexAtPtx4093, r_LaneIndexAtPtx4107, r_LaneIndexAtPtx4123, r_LaneIndexAtPtx4139,
		r_LaneIndexAtPtx4153, r_LaneIndexAtPtx4167, r_LaneIndexAtPtx4181, r_LaneIndexAtPtx4195,
		r_LaneIndexAtPtx4209, r_LaneIndexAtPtx4223, r_LaneIndexAtPtx4239, r_LaneIndexAtPtx4255;
	uint32_t r_LaneIndexAtPtx4269, r_LaneIndexAtPtx4283, r_LaneIndexAtPtx4299, r_LaneIndexAtPtx4315,
		r_LaneIndexAtPtx4329, r_LaneIndexAtPtx4343, r_LaneIndexAtPtx4359, r_LaneIndexAtPtx4375,
		r_LaneIndexAtPtx4389, r_LaneIndexAtPtx4403, r_LaneIndexAtPtx4417, r_LaneIndexAtPtx4431;
	uint32_t r_LaneIndexAtPtx4445, r_LaneIndexAtPtx4459, r_LaneIndexAtPtx4475, r_LaneIndexAtPtx4491,
		r_LaneIndexAtPtx4505, r_LaneIndexAtPtx4519, r_LaneIndexAtPtx4535, r_LaneIndexAtPtx4551,
		r_LaneIndexAtPtx4565, r_LaneIndexAtPtx4579, r_LaneIndexAtPtx4595, r_LaneIndexAtPtx4611;
	uint32_t r_PtxRegister1765, r_LaneIndexAtPtx4618, r_PtxRegister1767, r_LaneIndexAtPtx4625,
		r_PtxRegister1769, r_LaneIndexAtPtx4632, r_PtxRegister1771, r_LaneIndexAtPtx4639, r_PtxRegister1773,
		r_LaneIndexAtPtx4646, r_PtxRegister1775, r_LaneIndexAtPtx4653;
	uint32_t r_PtxRegister1777, r_LaneIndexAtPtx4660, r_PtxRegister1779, r_LaneIndexAtPtx4667,
		r_PtxRegister1781, r_LaneIndexAtPtx4674, r_PtxRegister1783, r_LaneIndexAtPtx4681, r_PtxRegister1785,
		r_LaneIndexAtPtx4688, r_PtxRegister1787, r_LaneIndexAtPtx4695;
	uint32_t r_PtxRegister1789, r_LaneIndexAtPtx4702, r_PtxRegister1791, r_LaneIndexAtPtx4709,
		r_PtxRegister1793, r_LaneIndexAtPtx4716, r_PtxRegister1795, r_LaneIndexAtPtx4723, r_PtxRegister1797,
		r_LaneIndexAtPtx4730, r_PtxRegister1799, r_LaneIndexAtPtx4737;
	uint32_t r_PtxRegister1801, r_LaneIndexAtPtx4744, r_PtxRegister1803, r_LaneIndexAtPtx4751,
		r_PtxRegister1805, r_LaneIndexAtPtx4758, r_PtxRegister1807, r_LaneIndexAtPtx4765, r_PtxRegister1809,
		r_LaneIndexAtPtx4772, r_PtxRegister1811, r_LaneIndexAtPtx4779;
	uint32_t r_PtxRegister1813, r_LaneIndexAtPtx4786, r_PtxRegister1815, r_LaneIndexAtPtx4793,
		r_PtxRegister1817, r_LaneIndexAtPtx4800, r_PtxRegister1819, r_LaneIndexAtPtx4807, r_PtxRegister1821,
		r_LaneIndexAtPtx4814, r_PtxRegister1823, r_LaneIndexAtPtx4821;
	uint32_t r_PtxRegister1825, r_LaneIndexAtPtx4828, r_PtxRegister1827, r_LaneIndexAtPtx4835,
		r_PtxRegister1829, r_LaneIndexAtPtx4842, r_PtxRegister1831, r_LaneIndexAtPtx4849, r_PtxRegister1833,
		r_LaneIndexAtPtx4856, r_PtxRegister1835, r_LaneIndexAtPtx4863;
	uint32_t r_PtxRegister1837, r_LaneIndexAtPtx4870, r_PtxRegister1839, r_LaneIndexAtPtx4877,
		r_PtxRegister1841, r_LaneIndexAtPtx4884, r_PtxRegister1843, r_LaneIndexAtPtx4891, r_PtxRegister1845,
		r_LaneIndexAtPtx4898, r_PtxRegister1847, r_LaneIndexAtPtx4905;
	uint32_t r_PtxRegister1849, r_LaneIndexAtPtx4912, r_PtxRegister1851, r_LaneIndexAtPtx4919,
		r_PtxRegister1853, r_LaneIndexAtPtx4926, r_PtxRegister1855, r_LaneIndexAtPtx4933, r_PtxRegister1857,
		r_LaneIndexAtPtx4940, r_PtxRegister1859, r_LaneIndexAtPtx4947;
	uint32_t r_PtxRegister1861, r_LaneIndexAtPtx4954, r_PtxRegister1863, r_LaneIndexAtPtx4961,
		r_PtxRegister1865, r_LaneIndexAtPtx4968, r_PtxRegister1867, r_LaneIndexAtPtx4975, r_PtxRegister1869,
		r_LaneIndexAtPtx4982, r_PtxRegister1871, r_LaneIndexAtPtx4989;
	uint32_t r_PtxRegister1873, r_LaneIndexAtPtx4996, r_PtxRegister1875, r_LaneIndexAtPtx5003,
		r_PtxRegister1877, r_LaneIndexAtPtx5010, r_PtxRegister1879, r_LaneIndexAtPtx5017, r_PtxRegister1881,
		r_LaneIndexAtPtx5024, r_PtxRegister1883, r_LaneIndexAtPtx5031;
	uint32_t r_PtxRegister1885, r_LaneIndexAtPtx5038, r_PtxRegister1887, r_LaneIndexAtPtx5045,
		r_PtxRegister1889, r_LaneIndexAtPtx5052, r_PtxRegister1891, r_PtxRegister1892, r_PtxRegister1893,
		r_PtxRegister1894, r_PtxRegister1895, r_PtxRegister1896;
	uint32_t r_PtxRegister1897, r_PtxRegister1898, r_PtxRegister1899, r_PtxRegister1900, r_PtxRegister1901,
		r_PtxRegister1902, r_PtxRegister1903, r_PtxRegister1904, r_PtxRegister1905, r_PtxRegister1906,
		r_PtxRegister1907, r_PtxRegister1908;
	uint32_t r_PtxRegister1909, r_PtxRegister1910, r_PtxRegister1911, r_PtxRegister1912, r_PtxRegister1913,
		r_PtxRegister1914, r_PtxRegister1915, r_PtxRegister1916, r_PtxRegister1917, r_PtxRegister1918,
		r_PtxRegister1919, r_PtxRegister1920;
	uint32_t r_PtxRegister1921, r_PtxRegister1922, r_PtxRegister1923, r_PtxRegister1924, r_PtxRegister1925,
		r_PtxRegister1926, r_PtxRegister1927, r_PtxRegister1928, r_PtxRegister1929, r_PtxRegister1930,
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
		r_PtxRegister1986, r_PtxRegister1987, r_PtxRegister1988, r_PtxRegister1989, r_PtxRegister1990,
		r_PtxRegister1991, r_PtxRegister1992;
	uint32_t r_PtxRegister1993, r_PtxRegister1994, r_PtxRegister1995, r_PtxRegister1996, r_PtxRegister1997,
		r_PtxRegister1998, r_PtxRegister1999, r_PtxRegister2000, r_PtxRegister2001, r_PtxRegister2002,
		r_PtxRegister2003, r_PtxRegister2004;
	uint32_t r_PtxRegister2005, r_PtxRegister2006, r_PtxRegister2007, r_PtxRegister2008, r_PtxRegister2009,
		r_PtxRegister2010, r_PtxRegister2011, r_PtxRegister2012, r_PtxRegister2013, r_PtxRegister2014,
		r_PtxRegister2015, r_PtxRegister2016;
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
		r_PtxRegister2070, r_PtxRegister2071, r_PtxRegister2072, r_PtxRegister2073, r_PtxRegister2074,
		r_PtxRegister2075, r_PtxRegister2076;
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
		r_PtxRegister2130, r_PtxRegister2131, r_PtxRegister2132, r_PtxRegister2133, r_PtxRegister2134,
		r_PtxRegister2135, r_PtxRegister2136;
	uint32_t r_PtxRegister2137, r_PtxRegister2138, r_PtxRegister2139, r_PtxRegister2140, r_PtxRegister2141,
		r_PtxRegister2142, r_PtxRegister2143, r_PtxRegister2144, r_PtxRegister2145, r_PtxRegister2146,
		r_PtxRegister2147, r_PtxRegister2148;
	uint32_t r_PtxRegister2149, r_PtxRegister2150, r_PtxRegister2151, r_PtxRegister2152, r_PtxRegister2153,
		r_PtxRegister2154, r_PtxRegister2155, r_PtxRegister2156, r_PtxRegister2157, r_PtxRegister2158,
		r_PtxRegister2159, r_PtxRegister2160;
	uint32_t r_PtxRegister2161, r_PtxRegister2162, r_PtxRegister2163, r_PtxRegister2164, r_PtxRegister2165,
		r_PtxRegister2166, r_PtxRegister2167, r_PtxRegister2168, r_PtxRegister2169, r_PtxRegister2170,
		r_PtxRegister2171, r_PtxRegister2172;
	uint32_t r_PtxRegister2173, r_PtxRegister2174, r_PtxRegister2175, r_PtxRegister2176, r_PtxRegister2177,
		r_PtxRegister2178, r_PtxRegister2179, r_PtxRegister2180, r_PtxRegister2181, r_PtxRegister2182,
		r_PtxRegister2183, r_PtxRegister2184;
	uint32_t r_PtxRegister2185, r_PtxRegister2186, r_PtxRegister2187, r_PtxRegister2188, r_PtxRegister2189,
		r_PtxRegister2190, r_PtxRegister2191, r_PtxRegister2192, r_PtxRegister2193, r_PtxRegister2194,
		r_PtxRegister2195, r_PtxRegister2196;
	uint32_t r_PtxRegister2197, r_PtxRegister2198, r_PtxRegister2199, r_PtxRegister2200, r_PtxRegister2201,
		r_PtxRegister2202, r_PtxRegister2203, r_PtxRegister2204, r_PtxRegister2205, r_PtxRegister2206,
		r_PtxRegister2207, r_PtxRegister2208;
	uint32_t r_PtxRegister2209, r_PtxRegister2210, r_PtxRegister2211, r_PtxRegister2212, r_PtxRegister2213,
		r_PtxRegister2214, r_PtxRegister2215, r_PtxRegister2216, r_PtxRegister2217, r_PtxRegister2218,
		r_PtxRegister2219, r_PtxRegister2220;
	uint32_t r_PtxRegister2221, r_PtxRegister2222, r_PtxRegister2223, r_PtxRegister2224, r_PtxRegister2225,
		r_PtxRegister2226, r_PtxRegister2227, r_PtxRegister2228, r_PtxRegister2229, r_PtxRegister2230,
		r_PtxRegister2231, r_PtxRegister2232;
	uint32_t r_PtxRegister2233, r_PtxRegister2234, r_PtxRegister2235, r_PtxRegister2236, r_PtxRegister2237,
		r_PtxRegister2238, r_PtxRegister2239, r_PtxRegister2240, r_PtxRegister2241, r_PtxRegister2242,
		r_PtxRegister2243, r_PtxRegister2244;
	uint32_t r_PtxRegister2245, r_PtxRegister2246, r_PtxRegister2247, r_PtxRegister2248, r_PtxRegister2249,
		r_PtxRegister2250, r_PtxRegister2251, r_PtxRegister2252, r_PtxRegister2253, r_PtxRegister2254,
		r_PtxRegister2255, r_PtxRegister2256;
	uint32_t r_PtxRegister2257, r_PtxRegister2258, r_PtxRegister2259, r_PtxRegister2260, r_PtxRegister2261,
		r_PtxRegister2262, r_PtxRegister2263, r_PtxRegister2264, r_PtxRegister2265, r_PtxRegister2266,
		r_PtxRegister2267, r_PtxRegister2268;
	uint32_t r_PtxRegister2269, r_PtxRegister2270, r_PtxRegister2271, r_PtxRegister2272, r_PtxRegister2273,
		r_PtxRegister2274, r_PtxRegister2275, r_PtxRegister2276, r_PtxRegister2277, r_PtxRegister2278,
		r_PtxRegister2279, r_PtxRegister2280;
	uint32_t r_PtxRegister2281, r_PtxRegister2282, r_PtxRegister2283, r_PtxRegister2284, r_PtxRegister2285,
		r_PtxRegister2286, r_PtxRegister2287, r_PtxRegister2288, r_PtxRegister2289, r_PtxRegister2290,
		r_PtxRegister2291, r_PtxRegister2292;
	uint32_t r_PtxRegister2293, r_PtxRegister2294, r_PtxRegister2295, r_PtxRegister2296, r_PtxRegister2297,
		r_PtxRegister2298, r_PtxRegister2299, r_PtxRegister2300, r_PtxRegister2301, r_PtxRegister2302,
		r_PtxRegister2303, r_PtxRegister2304;
	uint32_t r_PtxRegister2305, r_PtxRegister2306, r_PtxRegister2307, r_PtxRegister2308, r_PtxRegister2309,
		r_PtxRegister2310, r_PtxRegister2311, r_PtxRegister2312, r_PtxRegister2313, r_PtxRegister2314,
		r_PtxRegister2315, r_PtxRegister2316;
	uint32_t r_PtxRegister2317, r_PtxRegister2318, r_PtxRegister2319, r_PtxRegister2320, r_PtxRegister2321,
		r_PtxRegister2322, r_PtxRegister2323, r_PtxRegister2324, r_PtxRegister2325, r_PtxRegister2326,
		r_PtxRegister2327, r_PtxRegister2328;
	uint32_t r_PtxRegister2329, r_PtxRegister2330, r_PtxRegister2331, r_PtxRegister2332, r_PtxRegister2333,
		r_PtxRegister2334, r_PtxRegister2335, r_PtxRegister2336, r_PtxRegister2337, r_PtxRegister2338,
		r_PtxRegister2339, r_PtxRegister2340;
	uint32_t r_PtxRegister2341, r_PtxRegister2342, r_PtxRegister2343, r_PtxRegister2344, r_PtxRegister2345,
		r_PtxRegister2346, r_PtxRegister2347, r_PtxRegister2348, r_PtxRegister2349, r_PtxRegister2350,
		r_PtxRegister2351, r_PtxRegister2352;
	uint32_t r_PtxRegister2353, r_PtxRegister2354, r_PtxRegister2355, r_PtxRegister2356, r_PtxRegister2357,
		r_PtxRegister2358, r_PtxRegister2359, r_PtxRegister2360, r_PtxRegister2361, r_PtxRegister2362,
		r_PtxRegister2363, r_PtxRegister2364;
	uint32_t r_PtxRegister2365, r_PtxRegister2366, r_PtxRegister2367, r_PtxRegister2368, r_PtxRegister2369,
		r_PtxRegister2370, r_PtxRegister2371, r_PtxRegister2372, r_PtxRegister2373, r_PtxRegister2374,
		r_PtxRegister2375, r_PtxRegister2376;
	uint32_t r_PtxRegister2377, r_PtxRegister2378, r_PtxRegister2379, r_PtxRegister2380, r_PtxRegister2381,
		r_PtxRegister2382, r_PtxRegister2383, r_PtxRegister2384, r_PtxRegister2385, r_PtxRegister2386,
		r_PtxRegister2387, r_PtxRegister2388;
	uint32_t r_PtxRegister2389, r_PtxRegister2390, r_PtxRegister2391, r_PtxRegister2392, r_PtxRegister2393,
		r_PtxRegister2394, r_PtxRegister2395, r_PtxRegister2396, r_PtxRegister2397, r_PtxRegister2398,
		r_PtxRegister2399, r_PtxRegister2400;
	uint32_t r_PtxRegister2401, r_PtxRegister2402, r_PtxRegister2403, r_PtxRegister2404, r_PtxRegister2405,
		r_PtxRegister2406, r_PtxRegister2407, r_PtxRegister2408, r_PtxRegister2409, r_PtxRegister2410,
		r_PtxRegister2411, r_PtxRegister2412;
	uint32_t r_PtxRegister2413, r_PtxRegister2414, r_PtxRegister2415, r_PtxRegister2416, r_PtxRegister2417,
		r_PtxRegister2418, r_PtxRegister2419, r_PtxRegister2420, r_PtxRegister2421, r_PtxRegister2422,
		r_PtxRegister2423, r_PtxRegister2424;
	uint32_t r_PtxRegister2425, r_PtxRegister2426, r_PtxRegister2427, r_PtxRegister2428, r_PtxRegister2429,
		r_PtxRegister2430, r_PtxRegister2431, r_PtxRegister2432, r_PtxRegister2433, r_PtxRegister2434,
		r_PtxRegister2435, r_PtxRegister2436;
	uint32_t r_PtxRegister2437, r_PtxRegister2438, r_PtxRegister2439, r_PtxRegister2440, r_PtxRegister2441,
		r_PtxRegister2442, r_PtxRegister2443, r_PtxRegister2444, r_PtxRegister2445, r_PtxRegister2446,
		r_PtxRegister2447, r_PtxRegister2448;
	uint32_t r_PtxRegister2449, r_PtxRegister2450, r_PtxRegister2451, r_PtxRegister2452, r_PtxRegister2453,
		r_PtxRegister2454, r_PtxRegister2455, r_PtxRegister2456, r_PtxRegister2457, r_PtxRegister2458,
		r_LaneIndexAtPtx5072, r_PtxRegister2460;
	uint32_t r_LaneIndexAtPtx5082, r_PtxRegister2462, r_LaneIndexAtPtx5091, r_PtxRegister2464,
		r_LaneIndexAtPtx5100, r_PtxRegister2466, r_LaneIndexAtPtx5109, r_PtxRegister2468,
		r_LaneIndexAtPtx5118, r_PtxRegister2470, r_LaneIndexAtPtx5127, r_PtxRegister2472;
	uint32_t r_LaneIndexAtPtx5136, r_PtxRegister2474, r_MmaAHalf2WordAtPtx5079R2475,
		r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477, r_MmaAHalf2WordAtPtx5079R2478,
		r_MmaAHalf2WordAtPtx5088R2479, r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481,
		r_MmaAHalf2WordAtPtx5088R2482, r_MmaAccumulatorHalf2WordAtPtx5145R2483,
		r_MmaAccumulatorHalf2WordAtPtx5145R2484;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5152R2485, r_MmaAccumulatorHalf2WordAtPtx5152R2486,
		r_MmaAccumulatorHalf2WordAtPtx5173R2487, r_MmaAccumulatorHalf2WordAtPtx5173R2488,
		r_MmaAccumulatorHalf2WordAtPtx5180R2489, r_MmaAccumulatorHalf2WordAtPtx5180R2490,
		r_MmaAccumulatorHalf2WordAtPtx5201R2491, r_MmaAccumulatorHalf2WordAtPtx5201R2492,
		r_MmaAccumulatorHalf2WordAtPtx5208R2493, r_MmaAccumulatorHalf2WordAtPtx5208R2494,
		r_MmaAccumulatorHalf2WordAtPtx5229R2495, r_MmaAccumulatorHalf2WordAtPtx5229R2496;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5236R2497, r_MmaAccumulatorHalf2WordAtPtx5236R2498,
		r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
		r_MmaAHalf2WordAtPtx5097R2502, r_MmaAHalf2WordAtPtx5106R2503, r_MmaAHalf2WordAtPtx5106R2504,
		r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506, r_MmaAccumulatorHalf2WordAtPtx5257R2507,
		r_MmaAccumulatorHalf2WordAtPtx5257R2508;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5264R2509, r_MmaAccumulatorHalf2WordAtPtx5264R2510,
		r_MmaAccumulatorHalf2WordAtPtx5285R2511, r_MmaAccumulatorHalf2WordAtPtx5285R2512,
		r_MmaAccumulatorHalf2WordAtPtx5292R2513, r_MmaAccumulatorHalf2WordAtPtx5292R2514,
		r_MmaAccumulatorHalf2WordAtPtx5313R2515, r_MmaAccumulatorHalf2WordAtPtx5313R2516,
		r_MmaAccumulatorHalf2WordAtPtx5320R2517, r_MmaAccumulatorHalf2WordAtPtx5320R2518,
		r_MmaAccumulatorHalf2WordAtPtx5341R2519, r_MmaAccumulatorHalf2WordAtPtx5341R2520;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5348R2521, r_MmaAccumulatorHalf2WordAtPtx5348R2522,
		r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
		r_MmaAHalf2WordAtPtx5115R2526, r_MmaAHalf2WordAtPtx5124R2527, r_MmaAHalf2WordAtPtx5124R2528,
		r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530, r_MmaAccumulatorHalf2WordAtPtx5369R2531,
		r_MmaAccumulatorHalf2WordAtPtx5369R2532;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5376R2533, r_MmaAccumulatorHalf2WordAtPtx5376R2534,
		r_MmaAccumulatorHalf2WordAtPtx5397R2535, r_MmaAccumulatorHalf2WordAtPtx5397R2536,
		r_MmaAccumulatorHalf2WordAtPtx5404R2537, r_MmaAccumulatorHalf2WordAtPtx5404R2538,
		r_MmaAccumulatorHalf2WordAtPtx5425R2539, r_MmaAccumulatorHalf2WordAtPtx5425R2540,
		r_MmaAccumulatorHalf2WordAtPtx5432R2541, r_MmaAccumulatorHalf2WordAtPtx5432R2542,
		r_MmaAccumulatorHalf2WordAtPtx5453R2543, r_MmaAccumulatorHalf2WordAtPtx5453R2544;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5460R2545, r_MmaAccumulatorHalf2WordAtPtx5460R2546,
		r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
		r_MmaAHalf2WordAtPtx5133R2550, r_MmaAHalf2WordAtPtx5142R2551, r_MmaAHalf2WordAtPtx5142R2552,
		r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554, r_MmaAccumulatorHalf2WordAtPtx5481R2555,
		r_MmaAccumulatorHalf2WordAtPtx5481R2556;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5488R2557, r_MmaAccumulatorHalf2WordAtPtx5488R2558,
		r_MmaAccumulatorHalf2WordAtPtx5509R2559, r_MmaAccumulatorHalf2WordAtPtx5509R2560,
		r_MmaAccumulatorHalf2WordAtPtx5516R2561, r_MmaAccumulatorHalf2WordAtPtx5516R2562,
		r_MmaAccumulatorHalf2WordAtPtx5537R2563, r_MmaAccumulatorHalf2WordAtPtx5537R2564,
		r_MmaAccumulatorHalf2WordAtPtx5544R2565, r_MmaAccumulatorHalf2WordAtPtx5544R2566,
		r_MmaAccumulatorHalf2WordAtPtx5565R2567, r_MmaAccumulatorHalf2WordAtPtx5565R2568;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx5572R2569, r_MmaAccumulatorHalf2WordAtPtx5572R2570,
		r_PtxRegister2571, r_PtxRegister2572, r_PtxRegister2573, r_PtxRegister2574, r_PtxRegister2575,
		r_PtxRegister2576, r_PtxRegister2577, r_PtxRegister2578, r_PtxRegister2579, r_PtxRegister2580;
	uint32_t r_PtxRegister2581, r_PtxRegister2582, r_PtxRegister2583, r_PtxRegister2584, r_PtxRegister2585,
		r_PtxRegister2586, r_PtxRegister2587, r_PtxRegister2588, r_PtxRegister2589, r_LaneIndexAtPtx5601,
		r_LaneIndexAtPtx5609, r_LaneIndexAtPtx5618;
	uint32_t r_LaneIndexAtPtx5627, r_LaneIndexAtPtx5636, r_LaneIndexAtPtx5645, r_LaneIndexAtPtx5654,
		r_LaneIndexAtPtx5663, r_PtxRegister2598, r_PtxRegister2599, r_PtxRegister2600, r_PtxRegister2601,
		r_PtxRegister2602, r_PtxRegister2603, r_PtxRegister2604;
	uint32_t r_PtxRegister2605, r_PtxRegister2606, r_PtxRegister2607, r_PtxRegister2608, r_PtxRegister2609,
		r_CtaYAtPtx5701, r_PtxRegister2611, r_PtxRegister2612, r_PtxRegister2613, r_PtxRegister2614,
		r_PtxRegister2615, r_PtxRegister2616;
	uint32_t r_PtxRegister2617, r_PtxRegister2618, r_PtxRegister2619, r_PtxRegister2620, r_PtxRegister2621,
		r_PtxRegister2622, r_PtxRegister2623, r_PtxRegister2624, r_LaneIndexAtPtx5768, r_PtxRegister2626,
		r_PtxRegister2627, r_PtxRegister2628;
	uint32_t r_PtxRegister2629, r_PtxRegister2630, r_PtxRegister2631, r_PtxRegister2632, r_PtxRegister2633,
		r_PtxRegister2634, r_PtxRegister2635, r_PtxRegister2636, r_ThreadYAtPtx5751, r_PtxRegister2638,
		r_PtxRegister2639, r_PtxRegister2640;
	uint32_t r_PtxRegister2641, r_PtxRegister2642, r_PtxRegister2643, r_PtxRegister2644, r_PtxRegister2645,
		r_PtxRegister2646, r_PtxRegister2647, r_PtxRegister2648, r_PtxRegister2649, r_PtxRegister2650,
		r_PtxRegister2651, r_PtxRegister2652;
	uint32_t r_PtxRegister2653, r_PtxRegister2654, r_PtxRegister2655, r_PtxRegister2656, r_PtxRegister2657,
		r_PtxRegister2658, r_LaneIndexAtPtx5843, r_PtxRegister2660, r_PtxRegister2661, r_PtxRegister2662,
		r_PtxRegister2663, r_PtxRegister2664;
	uint32_t r_PtxRegister2665, r_PtxRegister2666, r_PtxRegister2667, r_PtxRegister2668, r_PtxRegister2669,
		r_PtxRegister2670, r_PtxRegister2671, r_PtxRegister2672, r_LaneIndexAtPtx5866, r_LaneIndexAtPtx5874,
		r_LaneIndexAtPtx5883, r_LaneIndexAtPtx5892;
	uint32_t r_LaneIndexAtPtx5907, r_LaneIndexAtPtx5916, r_LaneIndexAtPtx5925, r_LaneIndexAtPtx5934,
		r_PtxRegister2681, r_PtxRegister2682, r_PtxRegister2683, r_PtxRegister2684, r_LaneIndexAtPtx5955,
		r_LaneIndexAtPtx5963, r_LaneIndexAtPtx5972, r_LaneIndexAtPtx5981;
	uint32_t r_LaneIndexAtPtx5994, r_LaneIndexAtPtx6003, r_LaneIndexAtPtx6012, r_LaneIndexAtPtx6021,
		r_PtxRegister2693, r_PtxRegister2694, r_PtxRegister2695, r_PtxRegister2696, r_PtxRegister2697,
		r_PtxRegister2698, r_PtxRegister2699, r_PtxRegister2700;
	uint32_t r_PtxRegister2701, r_PtxRegister2702, r_PtxRegister2703, r_PtxRegister2704, r_PtxRegister2705,
		r_PtxRegister2706, r_PtxRegister2707, r_PtxRegister2708, r_PtxRegister2709, r_PtxRegister2710,
		r_PtxRegister2711, r_PtxRegister2712;
	uint32_t r_PtxRegister2713, r_PtxRegister2714, r_PtxRegister2715, r_PtxRegister2716, r_PtxRegister2717,
		r_PtxRegister2718, r_PtxRegister2719, r_PtxRegister2720, r_PtxRegister2721, r_PtxRegister2722,
		r_PtxRegister2723, r_PtxRegister2724;
	uint32_t r_PtxRegister2725, r_PtxRegister2726, r_PtxRegister2727, r_PtxRegister2728, r_PtxRegister2729,
		r_PtxRegister2730, r_PtxRegister2731, r_PtxRegister2732, r_PtxRegister2733, r_PtxRegister2734,
		r_PtxRegister2735, r_PtxRegister2736;
	uint32_t r_PtxRegister2737, r_PtxRegister2738, r_PtxRegister2739, r_PtxRegister2740, r_PtxRegister2741,
		r_PtxRegister2742, r_PtxRegister2743, r_PtxRegister2744, r_PtxRegister2745, r_PtxRegister2746,
		r_PtxRegister2747, r_PtxRegister2748;
	uint32_t r_PtxRegister2749, r_PtxRegister2750, r_PtxRegister2751, r_PtxRegister2752, r_PtxRegister2753,
		r_PtxRegister2754, r_PtxRegister2755, r_PtxRegister2756, r_PtxRegister2757, r_PtxRegister2758,
		r_PtxRegister2759, r_PtxRegister2760;
	uint32_t r_PtxRegister2761, r_PtxRegister2762, r_PackedHalf2AtPtx5055R2763, r_PackedHalf2AtPtx5048R2764,
		r_PackedHalf2AtPtx5041R2765, r_PackedHalf2AtPtx5034R2766, r_PackedHalf2AtPtx5027R2767,
		r_PackedHalf2AtPtx5020R2768, r_PackedHalf2AtPtx5013R2769, r_PackedHalf2AtPtx5006R2770,
		r_PackedHalf2AtPtx4999R2771, r_PackedHalf2AtPtx4992R2772;
	uint32_t r_PackedHalf2AtPtx4985R2773, r_PackedHalf2AtPtx4978R2774, r_PackedHalf2AtPtx4971R2775,
		r_PackedHalf2AtPtx4964R2776, r_PackedHalf2AtPtx4957R2777, r_PackedHalf2AtPtx4950R2778,
		r_PackedHalf2AtPtx4943R2779, r_PackedHalf2AtPtx4936R2780, r_PackedHalf2AtPtx4929R2781,
		r_PackedHalf2AtPtx4922R2782, r_PackedHalf2AtPtx4915R2783, r_PackedHalf2AtPtx4908R2784;
	uint32_t r_PackedHalf2AtPtx4901R2785, r_PackedHalf2AtPtx4894R2786, r_PackedHalf2AtPtx4887R2787,
		r_PackedHalf2AtPtx4880R2788, r_PackedHalf2AtPtx4873R2789, r_PackedHalf2AtPtx4866R2790,
		r_PackedHalf2AtPtx4859R2791, r_PackedHalf2AtPtx4852R2792, r_PackedHalf2AtPtx4845R2793,
		r_PackedHalf2AtPtx4838R2794, r_PackedHalf2AtPtx4831R2795, r_PackedHalf2AtPtx4824R2796;
	uint32_t r_PackedHalf2AtPtx4817R2797, r_PackedHalf2AtPtx4810R2798, r_PackedHalf2AtPtx4803R2799,
		r_PackedHalf2AtPtx4796R2800, r_PackedHalf2AtPtx4789R2801, r_PackedHalf2AtPtx4782R2802,
		r_PackedHalf2AtPtx4775R2803, r_PackedHalf2AtPtx4768R2804, r_PackedHalf2AtPtx4761R2805,
		r_PackedHalf2AtPtx4754R2806, r_PackedHalf2AtPtx4747R2807, r_PackedHalf2AtPtx4740R2808;
	uint32_t r_PackedHalf2AtPtx4733R2809, r_PackedHalf2AtPtx4726R2810, r_PackedHalf2AtPtx4719R2811,
		r_PackedHalf2AtPtx4712R2812, r_PackedHalf2AtPtx4705R2813, r_PackedHalf2AtPtx4698R2814,
		r_PackedHalf2AtPtx4691R2815, r_PackedHalf2AtPtx4684R2816, r_PackedHalf2AtPtx4677R2817,
		r_PackedHalf2AtPtx4670R2818, r_PackedHalf2AtPtx4663R2819, r_PackedHalf2AtPtx4656R2820;
	uint32_t r_PackedHalf2AtPtx4649R2821, r_PackedHalf2AtPtx4642R2822, r_PackedHalf2AtPtx4635R2823,
		r_PackedHalf2AtPtx4628R2824, r_PackedHalf2AtPtx4621R2825, r_PackedHalf2AtPtx4614R2826,
		r_PtxRegister2827, r_MmaBHalf2WordAtPtx150R2828, r_MmaBHalf2WordAtPtx150R2829,
		r_MmaBHalf2WordAtPtx141R2830, r_MmaBHalf2WordAtPtx141R2831, r_MmaBHalf2WordAtPtx141R2832;
	uint32_t r_MmaBHalf2WordAtPtx141R2833, r_MmaBHalf2WordAtPtx132R2834, r_MmaBHalf2WordAtPtx132R2835,
		r_MmaBHalf2WordAtPtx132R2836, r_MmaBHalf2WordAtPtx132R2837, r_MmaBHalf2WordAtPtx123R2838,
		r_MmaBHalf2WordAtPtx123R2839, r_MmaBHalf2WordAtPtx123R2840, r_MmaBHalf2WordAtPtx123R2841,
		r_MmaBHalf2WordAtPtx114R2842, r_MmaBHalf2WordAtPtx114R2843, r_MmaBHalf2WordAtPtx114R2844;
	uint32_t r_MmaBHalf2WordAtPtx114R2845, r_MmaBHalf2WordAtPtx105R2846, r_MmaBHalf2WordAtPtx105R2847,
		r_MmaBHalf2WordAtPtx105R2848, r_MmaBHalf2WordAtPtx105R2849, r_MmaBHalf2WordAtPtx96R2850,
		r_MmaBHalf2WordAtPtx96R2851, r_MmaBHalf2WordAtPtx96R2852, r_MmaBHalf2WordAtPtx96R2853,
		r_MmaBHalf2WordAtPtx87R2854, r_MmaBHalf2WordAtPtx87R2855, r_MmaBHalf2WordAtPtx87R2856;
	uint32_t r_MmaBHalf2WordAtPtx87R2857, r_MmaBHalf2WordAtPtx150R2858, r_MmaBHalf2WordAtPtx150R2859;
	uint64_t g_StateBaseAddress, g_ResidualByteAddressAtPtx19, g_OutputByteAddressAtPtx5862,
		g_OutputByteAddressAtPtx5951, g_ResidualBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress,
		g_RecordByteAddressAtPtx85, g_RecordByteAddressAtPtx94, g_RecordByteAddressAtPtx103,
		g_RecordByteAddressAtPtx112, g_RecordByteAddressAtPtx121;
	uint64_t g_RecordByteAddressAtPtx130, g_RecordByteAddressAtPtx139, g_RecordByteAddressAtPtx148,
		r_PtxU64Register16, g_RecordByteAddressAtPtx80, r_PtxU64Register18, r_PtxU64Register19,
		g_RecordByteAddressAtPtx93, r_PtxU64Register21, g_RecordByteAddressAtPtx102, r_PtxU64Register23,
		g_RecordByteAddressAtPtx111;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx120, r_PtxU64Register27, g_RecordByteAddressAtPtx129,
		r_PtxU64Register29, g_RecordByteAddressAtPtx138, r_PtxU64Register31, g_RecordByteAddressAtPtx147,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		r_PtxU64Register46, g_ResidualByteAddressAtPtx613, r_PtxU64Register48;
	uint64_t g_ResidualByteAddressAtPtx662, r_PtxU64Register50, g_ResidualByteAddressAtPtx711,
		r_PtxU64Register52, g_ResidualByteAddressAtPtx760, r_PtxU64Register54, g_ResidualByteAddressAtPtx809,
		r_PtxU64Register56, g_ResidualByteAddressAtPtx858, r_PtxU64Register58, g_ResidualByteAddressAtPtx907,
		r_PtxU64Register60;
	uint64_t g_ResidualByteAddressAtPtx956, r_PtxU64Register62, g_ResidualByteAddressAtPtx1005,
		r_PtxU64Register64, g_ResidualByteAddressAtPtx1054, r_PtxU64Register66,
		g_ResidualByteAddressAtPtx1103, r_PtxU64Register68, g_ResidualByteAddressAtPtx1152,
		r_PtxU64Register70, g_ResidualByteAddressAtPtx1201, r_PtxU64Register72;
	uint64_t g_ResidualByteAddressAtPtx1250, r_PtxU64Register74, g_ResidualByteAddressAtPtx1299,
		r_PtxU64Register76, g_ResidualByteAddressAtPtx1348, r_PtxU64Register78,
		g_ResidualByteAddressAtPtx1395, r_PtxU64Register80, g_ResidualByteAddressAtPtx1443,
		r_PtxU64Register82, g_ResidualByteAddressAtPtx1490, r_PtxU64Register84;
	uint64_t g_ResidualByteAddressAtPtx1538, r_PtxU64Register86, g_ResidualByteAddressAtPtx1585,
		r_PtxU64Register88, g_ResidualByteAddressAtPtx1633, r_PtxU64Register90,
		g_ResidualByteAddressAtPtx1680, r_PtxU64Register92, g_ResidualByteAddressAtPtx1728,
		r_PtxU64Register94, g_ResidualByteAddressAtPtx1775, r_PtxU64Register96;
	uint64_t g_ResidualByteAddressAtPtx1823, r_PtxU64Register98, g_ResidualByteAddressAtPtx1870,
		r_PtxU64Register100, g_ResidualByteAddressAtPtx1918, r_PtxU64Register102,
		g_ResidualByteAddressAtPtx1965, r_PtxU64Register104, g_ResidualByteAddressAtPtx2013,
		r_PtxU64Register106, g_ResidualByteAddressAtPtx2060, r_PtxU64Register108;
	uint64_t g_ResidualByteAddressAtPtx2108, r_PtxU64Register110, g_ResidualByteAddressAtPtx2157,
		r_PtxU64Register112, g_ResidualByteAddressAtPtx2206, r_PtxU64Register114,
		g_ResidualByteAddressAtPtx2255, r_PtxU64Register116, g_ResidualByteAddressAtPtx2304,
		r_PtxU64Register118, g_ResidualByteAddressAtPtx2353, r_PtxU64Register120;
	uint64_t g_ResidualByteAddressAtPtx2402, r_PtxU64Register122, g_ResidualByteAddressAtPtx2451,
		r_PtxU64Register124, g_ResidualByteAddressAtPtx2500, r_PtxU64Register126,
		g_ResidualByteAddressAtPtx2549, r_PtxU64Register128, g_ResidualByteAddressAtPtx2598,
		r_PtxU64Register130, g_ResidualByteAddressAtPtx2647, r_PtxU64Register132;
	uint64_t g_ResidualByteAddressAtPtx2696, r_PtxU64Register134, g_ResidualByteAddressAtPtx2745,
		r_PtxU64Register136, g_ResidualByteAddressAtPtx2794, r_PtxU64Register138,
		g_ResidualByteAddressAtPtx2843, r_PtxU64Register140, g_ResidualByteAddressAtPtx2892,
		r_PtxU64Register142, g_ResidualByteAddressAtPtx2939, r_PtxU64Register144;
	uint64_t g_ResidualByteAddressAtPtx2986, r_PtxU64Register146, g_ResidualByteAddressAtPtx3033,
		r_PtxU64Register148, g_ResidualByteAddressAtPtx3080, r_PtxU64Register150,
		g_ResidualByteAddressAtPtx3127, r_PtxU64Register152, g_ResidualByteAddressAtPtx3174,
		r_PtxU64Register154, g_ResidualByteAddressAtPtx3221, r_PtxU64Register156;
	uint64_t g_ResidualByteAddressAtPtx3268, r_PtxU64Register158, g_ResidualByteAddressAtPtx3315,
		r_PtxU64Register160, g_ResidualByteAddressAtPtx3362, r_PtxU64Register162,
		g_ResidualByteAddressAtPtx3409, r_PtxU64Register164, g_ResidualByteAddressAtPtx3458,
		r_PtxU64Register166, g_ResidualByteAddressAtPtx3507, r_PtxU64Register168;
	uint64_t g_ResidualByteAddressAtPtx3557, r_PtxU64Register170, g_ResidualByteAddressAtPtx3607,
		r_PtxU64Register172, g_ResidualByteAddressAtPtx3655, g_RecordByteAddressAtPtx3659,
		r_PtxU64Register175, g_RecordByteAddressAtPtx3673, r_PtxU64Register177, g_RecordByteAddressAtPtx3687,
		r_PtxU64Register179, g_RecordByteAddressAtPtx3701;
	uint64_t r_PtxU64Register181, g_RecordByteAddressAtPtx3715, r_PtxU64Register183,
		g_RecordByteAddressAtPtx3729, r_PtxU64Register185, g_RecordByteAddressAtPtx3743, r_PtxU64Register187,
		g_RecordByteAddressAtPtx3760, r_PtxU64Register189, g_RecordByteAddressAtPtx3776, r_PtxU64Register191,
		g_RecordByteAddressAtPtx3791;
	uint64_t r_PtxU64Register193, g_RecordByteAddressAtPtx3805, r_PtxU64Register195,
		g_RecordByteAddressAtPtx3822, r_PtxU64Register197, g_RecordByteAddressAtPtx3838, r_PtxU64Register199,
		g_RecordByteAddressAtPtx3853, r_PtxU64Register201, g_RecordByteAddressAtPtx3867, r_PtxU64Register203,
		g_RecordByteAddressAtPtx3884;
	uint64_t r_PtxU64Register205, g_RecordByteAddressAtPtx3900, r_PtxU64Register207,
		g_RecordByteAddressAtPtx3914, r_PtxU64Register209, g_RecordByteAddressAtPtx3928, r_PtxU64Register211,
		g_RecordByteAddressAtPtx3942, r_PtxU64Register213, g_RecordByteAddressAtPtx3956, r_PtxU64Register215,
		g_RecordByteAddressAtPtx3970;
	uint64_t r_PtxU64Register217, g_RecordByteAddressAtPtx3984, r_PtxU64Register219,
		g_RecordByteAddressAtPtx4000, r_PtxU64Register221, g_RecordByteAddressAtPtx4016, r_PtxU64Register223,
		g_RecordByteAddressAtPtx4030, r_PtxU64Register225, g_RecordByteAddressAtPtx4044, r_PtxU64Register227,
		g_RecordByteAddressAtPtx4060;
	uint64_t r_PtxU64Register229, g_RecordByteAddressAtPtx4076, r_PtxU64Register231,
		g_RecordByteAddressAtPtx4090, r_PtxU64Register233, g_RecordByteAddressAtPtx4104, r_PtxU64Register235,
		g_RecordByteAddressAtPtx4120, r_PtxU64Register237, g_RecordByteAddressAtPtx4136, r_PtxU64Register239,
		g_RecordByteAddressAtPtx4150;
	uint64_t r_PtxU64Register241, g_RecordByteAddressAtPtx4164, r_PtxU64Register243,
		g_RecordByteAddressAtPtx4178, r_PtxU64Register245, g_RecordByteAddressAtPtx4192, r_PtxU64Register247,
		g_RecordByteAddressAtPtx4206, r_PtxU64Register249, g_RecordByteAddressAtPtx4220, r_PtxU64Register251,
		g_RecordByteAddressAtPtx4236;
	uint64_t r_PtxU64Register253, g_RecordByteAddressAtPtx4252, r_PtxU64Register255,
		g_RecordByteAddressAtPtx4266, r_PtxU64Register257, g_RecordByteAddressAtPtx4280, r_PtxU64Register259,
		g_RecordByteAddressAtPtx4296, r_PtxU64Register261, g_RecordByteAddressAtPtx4312, r_PtxU64Register263,
		g_RecordByteAddressAtPtx4326;
	uint64_t r_PtxU64Register265, g_RecordByteAddressAtPtx4340, r_PtxU64Register267,
		g_RecordByteAddressAtPtx4356, r_PtxU64Register269, g_RecordByteAddressAtPtx4372, r_PtxU64Register271,
		g_RecordByteAddressAtPtx4386, r_PtxU64Register273, g_RecordByteAddressAtPtx4400, r_PtxU64Register275,
		g_RecordByteAddressAtPtx4414;
	uint64_t r_PtxU64Register277, g_RecordByteAddressAtPtx4428, r_PtxU64Register279,
		g_RecordByteAddressAtPtx4442, r_PtxU64Register281, g_RecordByteAddressAtPtx4456, r_PtxU64Register283,
		g_RecordByteAddressAtPtx4472, r_PtxU64Register285, g_RecordByteAddressAtPtx4488, r_PtxU64Register287,
		g_RecordByteAddressAtPtx4502;
	uint64_t r_PtxU64Register289, g_RecordByteAddressAtPtx4516, r_PtxU64Register291,
		g_RecordByteAddressAtPtx4532, r_PtxU64Register293, g_RecordByteAddressAtPtx4548, r_PtxU64Register295,
		g_RecordByteAddressAtPtx4562, r_PtxU64Register297, g_RecordByteAddressAtPtx4576, r_PtxU64Register299,
		g_RecordByteAddressAtPtx4592;
	uint64_t r_PtxU64Register301, g_RecordByteAddressAtPtx4608, g_RecordByteAddressAtPtx5604,
		g_RecordByteAddressAtPtx5613, g_RecordByteAddressAtPtx5622, g_RecordByteAddressAtPtx5631,
		g_RecordByteAddressAtPtx5640, g_RecordByteAddressAtPtx5649, g_RecordByteAddressAtPtx5658,
		g_RecordByteAddressAtPtx5667, r_PtxU64Register311, g_RecordByteAddressAtPtx5599;
	uint64_t r_PtxU64Register313, r_PtxU64Register314, g_RecordByteAddressAtPtx5612, r_PtxU64Register316,
		g_RecordByteAddressAtPtx5621, r_PtxU64Register318, g_RecordByteAddressAtPtx5630, r_PtxU64Register320,
		g_RecordByteAddressAtPtx5639, r_PtxU64Register322, g_RecordByteAddressAtPtx5648, r_PtxU64Register324;
	uint64_t g_RecordByteAddressAtPtx5657, r_PtxU64Register326, g_RecordByteAddressAtPtx5666,
		r_PtxU64Register328, r_PtxU64Register329, r_PtxU64Register330, r_PtxU64Register331,
		r_PtxU64Register332, r_PtxU64Register333, g_OutputByteAddressAtPtx5869, g_OutputByteAddressAtPtx5878,
		g_OutputByteAddressAtPtx5887;
	uint64_t g_OutputByteAddressAtPtx5896, r_PtxU64Register338, r_PtxU64Register339,
		g_OutputByteAddressAtPtx5877, r_PtxU64Register341, g_OutputByteAddressAtPtx5886, r_PtxU64Register343,
		g_OutputByteAddressAtPtx5895, g_OutputByteAddressAtPtx5911, g_OutputByteAddressAtPtx5920,
		g_OutputByteAddressAtPtx5929, g_OutputByteAddressAtPtx5938;
	uint64_t r_PtxU64Register349, g_OutputByteAddressAtPtx5910, r_PtxU64Register351,
		g_OutputByteAddressAtPtx5919, r_PtxU64Register353, g_OutputByteAddressAtPtx5928, r_PtxU64Register355,
		g_OutputByteAddressAtPtx5937, r_PtxU64Register357, g_OutputByteAddressAtPtx5958,
		g_OutputByteAddressAtPtx5967, g_OutputByteAddressAtPtx5976;
	uint64_t g_OutputByteAddressAtPtx5985, r_PtxU64Register362, r_PtxU64Register363,
		g_OutputByteAddressAtPtx5966, r_PtxU64Register365, g_OutputByteAddressAtPtx5975, r_PtxU64Register367,
		g_OutputByteAddressAtPtx5984, g_OutputByteAddressAtPtx5998, g_OutputByteAddressAtPtx6007,
		g_OutputByteAddressAtPtx6016, g_OutputByteAddressAtPtx6025;
	uint64_t r_PtxU64Register373, g_OutputByteAddressAtPtx5997, r_PtxU64Register375,
		g_OutputByteAddressAtPtx6006, r_PtxU64Register377, g_OutputByteAddressAtPtx6015, r_PtxU64Register379,
		g_OutputByteAddressAtPtx6024, r_PtxU64Register381, r_PtxU64Register382, r_PtxU64Register383,
		r_PtxU64Register384;
	uint64_t r_PtxU64Register385, r_PtxU64Register386, r_PtxU64Register387, r_PtxU64Register388,
		r_PtxU64Register389, r_PtxU64Register390, r_PtxU64Register391, r_PtxU64Register392,
		r_PtxU64Register393, r_PtxU64Register394, r_PtxU64Register395, r_PtxU64Register396;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L16
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);									  // PTX L17
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip);						  // PTX L18
	g_ResidualByteAddressAtPtx19 = g_ResidualBaseAddress;						  // PTX L19
	r_CtaX = uint32_t(blockIdx.x);												  // PTX L20
	r_CtaYAtPtx21 = uint32_t(blockIdx.y);										  // PTX L21
	r_CtaZ = uint32_t(blockIdx.z);												  // PTX L22
	r_PtxRegister175 = uint32_t(r_WidthBits) + uint32_t(-1);					  // PTX L23
	r_PtxRegister176 = ShiftRightSigned(int32_t(r_PtxRegister175), uint32_t(31)); // PTX L24
	r_PtxRegister177 = ShiftRight(uint32_t(r_PtxRegister176), uint32_t(29));	  // PTX L25
	r_PtxRegister178 = uint32_t(r_PtxRegister175) + uint32_t(r_PtxRegister177);	  // PTX L26
	r_PtxRegister179 = ShiftRightSigned(int32_t(r_PtxRegister178), uint32_t(3));  // PTX L27
	r_PtxRegister180 = uint32_t(r_PtxRegister179) + uint32_t(1);				  // PTX L28
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister180));		  // PTX L29
	r_PtxRegister181 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister179) + uint32_t(r_PtxRegister2); // PTX L30
	r_PtxRegister182 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister181);					  // PTX L31
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaYAtPtx21), uint32_t(1));					  // PTX L32
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaYAtPtx21), uint32_t(3));					  // PTX L33
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister182), uint32_t(3));				  // PTX L34
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister182), uint32_t(1));				  // PTX L35
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
	r_PtxRegister190 = r_ThreadX | r_ThreadYAtPtx45;									  // PTX L46
	r_bPtxPredicate72 = uint32_t(r_PtxRegister190) != uint32_t(0);						  // PTX L47
	if (r_bPtxPredicate72)
	{
		goto L__BB18_2;
	} // PTX L48
	r_BlockSizeX = uint32_t(blockDim.x);										 // PTX L49
	r_BlockSizeY = uint32_t(blockDim.y);										 // PTX L50
	r_PtxRegister192 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			 // PTX L51
	r_PtxRegister191 = uint32_t(12288u /* exact native shared-region offset */); // PTX L52
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister191, r_PtxRegister192); // PTX L54
	r_PtxRegister193 = uint32_t(r_PtxRegister191) + uint32_t(8);	  // PTX L56
	BarrierInit(s_SharedStorage, r_PtxRegister193, r_PtxRegister192); // PTX L58
	r_PtxRegister194 = uint32_t(r_PtxRegister191) + uint32_t(16);	  // PTX L60
	BarrierInit(s_SharedStorage, r_PtxRegister194, r_PtxRegister192); // PTX L62
L__BB18_2:															  // PTX L64
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L65
	r_Float32BitsAtPtx66R197 = uint32_t(0);														// PTX L66
	r_PackedHalf2AtPtx68R313 = FloatToHalf2(r_Float32BitsAtPtx66R197);							// PTX L68
	r_PtxRegister206 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(6));						// PTX L73
	r_PtxRegister207 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));						// PTX L74
	r_PtxRegister10 = uint32_t(r_PtxRegister206) + uint32_t(r_PtxRegister207);					// PTX L75
	r_PtxRegister208 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(17));								// PTX L76
	r_PtxRegister11 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(3));						// PTX L77
	r_PtxRegister209 = uint32_t(r_PtxRegister208) + uint32_t(r_PtxRegister11);					// PTX L78
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_PtxRegister209)) * int64_t(int32_t(4)));	// PTX L79
	g_RecordByteAddressAtPtx80 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register16);	// PTX L80
	r_LaneIndexAtPtx82 = uint32_t((threadIdx.x & 31u));											// PTX L82
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx82)) * int64_t(int32_t(16))); // PTX L84
	g_RecordByteAddressAtPtx85 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register18); // PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx85));
		r_MmaBHalf2WordAtPtx87R2857 = r_Value.x;
		r_MmaBHalf2WordAtPtx87R2856 = r_Value.y;
		r_MmaBHalf2WordAtPtx87R2855 = r_Value.z;
		r_MmaBHalf2WordAtPtx87R2854 = r_Value.w;
	} // PTX L87
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register19);		   // PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(512); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBHalf2WordAtPtx96R2853 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R2852 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R2851 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R2850 = r_Value.w;
	} // PTX L96
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	g_RecordByteAddressAtPtx102 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register21);			  // PTX L102
	g_RecordByteAddressAtPtx103 = uint64_t(g_RecordByteAddressAtPtx102) + uint64_t(1024); // PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx103));
		r_MmaBHalf2WordAtPtx105R2849 = r_Value.x;
		r_MmaBHalf2WordAtPtx105R2848 = r_Value.y;
		r_MmaBHalf2WordAtPtx105R2847 = r_Value.z;
		r_MmaBHalf2WordAtPtx105R2846 = r_Value.w;
	} // PTX L105
	r_LaneIndexAtPtx108 = uint32_t((threadIdx.x & 31u));										 // PTX L108
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx108)) * int64_t(int32_t(16))); // PTX L110
	g_RecordByteAddressAtPtx111 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register23);			  // PTX L111
	g_RecordByteAddressAtPtx112 = uint64_t(g_RecordByteAddressAtPtx111) + uint64_t(1536); // PTX L112
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx112));
		r_MmaBHalf2WordAtPtx114R2845 = r_Value.x;
		r_MmaBHalf2WordAtPtx114R2844 = r_Value.y;
		r_MmaBHalf2WordAtPtx114R2843 = r_Value.z;
		r_MmaBHalf2WordAtPtx114R2842 = r_Value.w;
	} // PTX L114
	r_LaneIndexAtPtx117 = uint32_t((threadIdx.x & 31u));										 // PTX L117
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx117)) * int64_t(int32_t(16))); // PTX L119
	g_RecordByteAddressAtPtx120 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register25);			   // PTX L120
	g_RecordByteAddressAtPtx121 = uint64_t(g_RecordByteAddressAtPtx120) + uint64_t(16384); // PTX L121
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx121));
		r_MmaBHalf2WordAtPtx123R2841 = r_Value.x;
		r_MmaBHalf2WordAtPtx123R2840 = r_Value.y;
		r_MmaBHalf2WordAtPtx123R2839 = r_Value.z;
		r_MmaBHalf2WordAtPtx123R2838 = r_Value.w;
	} // PTX L123
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_RecordByteAddressAtPtx129 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register27);			   // PTX L129
	g_RecordByteAddressAtPtx130 = uint64_t(g_RecordByteAddressAtPtx129) + uint64_t(16896); // PTX L130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx130));
		r_MmaBHalf2WordAtPtx132R2837 = r_Value.x;
		r_MmaBHalf2WordAtPtx132R2836 = r_Value.y;
		r_MmaBHalf2WordAtPtx132R2835 = r_Value.z;
		r_MmaBHalf2WordAtPtx132R2834 = r_Value.w;
	} // PTX L132
	r_LaneIndexAtPtx135 = uint32_t((threadIdx.x & 31u));										 // PTX L135
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx135)) * int64_t(int32_t(16))); // PTX L137
	g_RecordByteAddressAtPtx138 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register29);			   // PTX L138
	g_RecordByteAddressAtPtx139 = uint64_t(g_RecordByteAddressAtPtx138) + uint64_t(17408); // PTX L139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx139));
		r_MmaBHalf2WordAtPtx141R2833 = r_Value.x;
		r_MmaBHalf2WordAtPtx141R2832 = r_Value.y;
		r_MmaBHalf2WordAtPtx141R2831 = r_Value.z;
		r_MmaBHalf2WordAtPtx141R2830 = r_Value.w;
	} // PTX L141
	r_LaneIndexAtPtx144 = uint32_t((threadIdx.x & 31u));										 // PTX L144
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx144)) * int64_t(int32_t(16))); // PTX L146
	g_RecordByteAddressAtPtx147 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register31);			   // PTX L147
	g_RecordByteAddressAtPtx148 = uint64_t(g_RecordByteAddressAtPtx147) + uint64_t(17920); // PTX L148
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx148));
		r_MmaBHalf2WordAtPtx150R2829 = r_Value.x;
		r_MmaBHalf2WordAtPtx150R2828 = r_Value.y;
		r_MmaBHalf2WordAtPtx150R2858 = r_Value.z;
		r_MmaBHalf2WordAtPtx150R2859 = r_Value.w;
	} // PTX L150
	r_PtxRegister12 = r_ThreadYAtPtx45 & 1;									   // PTX L152
	r_PtxRegister210 = ShiftRight(uint32_t(r_ThreadYAtPtx45), uint32_t(1));	   // PTX L153
	r_PtxRegister211 = r_PtxRegister210 & 1;								   // PTX L154
	r_PtxRegister212 = ShiftRight(uint32_t(r_ThreadYAtPtx45), uint32_t(2));	   // PTX L155
	r_PtxRegister213 = ShiftLeft(uint32_t(r_PtxRegister212), uint32_t(9));	   // PTX L156
	r_PtxRegister214 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(7));	   // PTX L157
	r_PtxRegister13 = r_PtxRegister214 & 256;								   // PTX L158
	r_PtxRegister215 = r_PtxRegister213 | r_PtxRegister13;					   // PTX L159
	r_PtxRegister14 = r_PtxRegister214 & 128;								   // PTX L160
	r_PtxRegister15 = r_PtxRegister215 | r_PtxRegister14;					   // PTX L161
	r_PtxRegister216 = uint32_t(r_PtxRegister212) + uint32_t(r_PtxRegister3);  // PTX L162
	r_PtxRegister16 = uint32_t(r_PtxRegister211) + uint32_t(r_PtxRegister6);   // PTX L163
	r_PtxRegister17 = r_HeightBits & -4;									   // PTX L164
	r_bPtxPredicate73 = uint32_t(r_PtxRegister17) == uint32_t(4);			   // PTX L165
	r_bPtxPredicate74 = int32_t(r_PtxRegister216) < int32_t(r_HeightDiv4Bits); // PTX L166
	r_PtxRegister217 = uint32_t(r_PtxRegister216) * uint32_t(r_WidthDiv4Bits); // PTX L167
	r_PtxRegister18 = r_bPtxPredicate73 ? 0 : r_PtxRegister217;				   // PTX L168
	r_bPtxPredicate1 = r_bPtxPredicate73 | r_bPtxPredicate74;				   // PTX L169
	r_bPtxPredicate1140 = bool(0);											   // PTX L170
	r_bPtxPredicate75 = !r_bPtxPredicate1;									   // PTX L171
	r_PtxRegister2693 = uint32_t(r_PtxRegister16);							   // PTX L172
	if (r_bPtxPredicate75)
	{
		goto L__BB18_5;
	} // PTX L173
	r_PtxRegister218 = r_WidthBits & -4;						   // PTX L174
	r_bPtxPredicate76 = uint32_t(r_PtxRegister218) == uint32_t(4); // PTX L175
	r_bPtxPredicate1140 = bool(-1);								   // PTX L176
	r_PtxRegister2693 = uint32_t(0);							   // PTX L177
	if (r_bPtxPredicate76)
	{
		goto L__BB18_5;
	} // PTX L178
	r_bPtxPredicate1140 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L179
	r_PtxRegister2693 = uint32_t(r_PtxRegister16);							   // PTX L180
L__BB18_5:																	   // PTX L181
	r_PtxU64Register381 = uint64_t(0);										   // PTX L182
	r_bPtxPredicate77 = !r_bPtxPredicate1140;								   // PTX L183
	if (r_bPtxPredicate77)
	{
		goto L__BB18_7;
	} // PTX L184
	r_PtxRegister219 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2693); // PTX L185
	r_PtxRegister220 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister219);			// PTX L186
	r_PtxRegister221 = ShiftLeft(uint32_t(r_PtxRegister220), uint32_t(12));		// PTX L187
	r_PtxRegister222 = r_PtxRegister221 | r_PtxRegister14;						// PTX L188
	r_PtxU64Register381 = SignExtendWordBits(r_PtxRegister222);					// PTX L189
L__BB18_7:																		// PTX L190
	r_PtxU64Register382 = uint64_t(0);											// PTX L191
	if (r_bPtxPredicate77)
	{
		goto L__BB18_9;
	} // PTX L192
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register381), uint32_t(2));		   // PTX L193
	r_PtxU64Register382 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register33); // PTX L194
L__BB18_9:																			   // PTX L195
	r_PtxRegister223 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));			   // PTX L196
	r_PtxRegister224 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L197
	r_PtxRegister19 = uint32_t(r_PtxRegister224) + uint32_t(r_PtxRegister223);		   // PTX L198
	if (r_bPtxPredicate77)
	{
		goto L__BB18_12;
	} // PTX L199
	r_PtxRegister229 = uint32_t(-1);							   // PTX L200
	r_PtxRegister228 = Elected(r_PtxRegister229);				   // PTX L202
	r_bPtxPredicate78 = uint32_t(r_PtxRegister228) == uint32_t(0); // PTX L208
	if (r_bPtxPredicate78)
	{
		goto L__BB18_13;
	} // PTX L209
	r_PtxU64Register34 = r_PtxU64Register382;									 // PTX L210
	r_PtxRegister231 = uint32_t(12288u /* exact native shared-region offset */); // PTX L211
	r_PtxRegister230 = uint32_t(512);											 // PTX L212
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister19, r_PtxU64Register34, r_PtxRegister230,
			 r_PtxRegister231);												   // PTX L214
	BarrierExpect(s_SharedStorage, r_PtxRegister231, r_PtxRegister230);		   // PTX L217
	goto L__BB18_13;														   // PTX L219
L__BB18_12:																	   // PTX L220
	r_LaneIndexAtPtx222 = uint32_t((threadIdx.x & 31u));					   // PTX L222
	r_PtxRegister227 = ShiftLeft(uint32_t(r_LaneIndexAtPtx222), uint32_t(4));  // PTX L224
	r_PtxRegister226 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister227); // PTX L225
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister226)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);								   // PTX L227
L__BB18_13:																	   // PTX L229
	r_bPtxPredicate79 = uint32_t(r_PtxRegister17) == uint32_t(4);			   // PTX L230
	r_PtxRegister232 = uint32_t(r_ThreadYAtPtx45) + uint32_t(4);			   // PTX L231
	r_PtxRegister233 = ShiftRight(uint32_t(r_PtxRegister232), uint32_t(2));	   // PTX L232
	r_PtxRegister234 = ShiftLeft(uint32_t(r_PtxRegister233), uint32_t(9));	   // PTX L233
	r_PtxRegister235 = r_PtxRegister234 | r_PtxRegister13;					   // PTX L234
	r_PtxRegister20 = uint32_t(r_PtxRegister235) + uint32_t(r_PtxRegister14);  // PTX L235
	r_PtxRegister236 = uint32_t(r_PtxRegister233) + uint32_t(r_PtxRegister3);  // PTX L236
	r_bPtxPredicate80 = int32_t(r_PtxRegister236) < int32_t(r_HeightDiv4Bits); // PTX L237
	r_PtxRegister237 = uint32_t(r_PtxRegister236) * uint32_t(r_WidthDiv4Bits); // PTX L238
	r_PtxRegister21 = r_bPtxPredicate79 ? 0 : r_PtxRegister237;				   // PTX L239
	r_bPtxPredicate2 = r_bPtxPredicate79 | r_bPtxPredicate80;				   // PTX L240
	r_bPtxPredicate1141 = bool(0);											   // PTX L241
	r_bPtxPredicate81 = !r_bPtxPredicate2;									   // PTX L242
	r_PtxRegister2694 = uint32_t(r_PtxRegister16);							   // PTX L243
	if (r_bPtxPredicate81)
	{
		goto L__BB18_16;
	} // PTX L244
	r_PtxRegister238 = r_WidthBits & -4;						   // PTX L245
	r_bPtxPredicate82 = uint32_t(r_PtxRegister238) == uint32_t(4); // PTX L246
	r_bPtxPredicate1141 = bool(-1);								   // PTX L247
	r_PtxRegister2694 = uint32_t(0);							   // PTX L248
	if (r_bPtxPredicate82)
	{
		goto L__BB18_16;
	} // PTX L249
	r_bPtxPredicate1141 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L250
	r_PtxRegister2694 = uint32_t(r_PtxRegister16);							   // PTX L251
L__BB18_16:																	   // PTX L252
	r_PtxU64Register383 = uint64_t(0);										   // PTX L253
	r_bPtxPredicate83 = !r_bPtxPredicate1141;								   // PTX L254
	if (r_bPtxPredicate83)
	{
		goto L__BB18_18;
	} // PTX L255
	r_PtxRegister239 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister2694); // PTX L256
	r_PtxRegister240 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister239);			// PTX L257
	r_PtxRegister241 = ShiftLeft(uint32_t(r_PtxRegister240), uint32_t(12));		// PTX L258
	r_PtxRegister242 = r_PtxRegister241 | r_PtxRegister14;						// PTX L259
	r_PtxU64Register383 = SignExtendWordBits(r_PtxRegister242);					// PTX L260
L__BB18_18:																		// PTX L261
	r_PtxU64Register384 = uint64_t(0);											// PTX L262
	if (r_bPtxPredicate83)
	{
		goto L__BB18_20;
	} // PTX L263
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register383), uint32_t(2));		   // PTX L264
	r_PtxU64Register384 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register35); // PTX L265
L__BB18_20:																			   // PTX L266
	r_PtxRegister243 = ShiftLeft(uint32_t(r_PtxRegister20), uint32_t(2));			   // PTX L267
	r_PtxRegister244 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L268
	r_PtxRegister22 = uint32_t(r_PtxRegister244) + uint32_t(r_PtxRegister243);		   // PTX L269
	if (r_bPtxPredicate83)
	{
		goto L__BB18_23;
	} // PTX L270
	r_PtxRegister249 = uint32_t(-1);							   // PTX L271
	r_PtxRegister248 = Elected(r_PtxRegister249);				   // PTX L273
	r_bPtxPredicate84 = uint32_t(r_PtxRegister248) == uint32_t(0); // PTX L279
	if (r_bPtxPredicate84)
	{
		goto L__BB18_24;
	} // PTX L280
	r_PtxU64Register36 = r_PtxU64Register384;									 // PTX L281
	r_PtxRegister251 = uint32_t(12288u /* exact native shared-region offset */); // PTX L282
	r_PtxRegister250 = uint32_t(512);											 // PTX L283
	CopyBulk(s_SharedStorage, r_PtxRegister22, r_PtxU64Register36, r_PtxRegister250,
			 r_PtxRegister251);												   // PTX L285
	BarrierExpect(s_SharedStorage, r_PtxRegister251, r_PtxRegister250);		   // PTX L288
	goto L__BB18_24;														   // PTX L290
L__BB18_23:																	   // PTX L291
	r_LaneIndexAtPtx293 = uint32_t((threadIdx.x & 31u));					   // PTX L293
	r_PtxRegister247 = ShiftLeft(uint32_t(r_LaneIndexAtPtx293), uint32_t(4));  // PTX L295
	r_PtxRegister246 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister247); // PTX L296
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister246)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);					 // PTX L298
L__BB18_24:														 // PTX L300
	r_PtxRegister252 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9)); // PTX L301
	r_PtxRegister23 = r_PtxRegister252 | 32;					 // PTX L302
	r_bPtxPredicate1142 = bool(0);								 // PTX L303
	r_PtxRegister2695 = uint32_t(r_PtxRegister16);				 // PTX L304
	if (r_bPtxPredicate75)
	{
		goto L__BB18_27;
	} // PTX L305
	r_PtxRegister253 = r_WidthBits & -4;						   // PTX L306
	r_bPtxPredicate85 = uint32_t(r_PtxRegister253) == uint32_t(4); // PTX L307
	r_bPtxPredicate1142 = bool(-1);								   // PTX L308
	r_PtxRegister2695 = uint32_t(0);							   // PTX L309
	if (r_bPtxPredicate85)
	{
		goto L__BB18_27;
	} // PTX L310
	r_bPtxPredicate1142 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L311
	r_PtxRegister2695 = uint32_t(r_PtxRegister16);							   // PTX L312
L__BB18_27:																	   // PTX L313
	r_PtxU64Register385 = uint64_t(0);										   // PTX L314
	r_bPtxPredicate86 = !r_bPtxPredicate1142;								   // PTX L315
	if (r_bPtxPredicate86)
	{
		goto L__BB18_29;
	} // PTX L316
	r_PtxRegister254 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2695); // PTX L317
	r_PtxRegister255 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(4));		// PTX L318
	r_PtxRegister256 = uint32_t(r_PtxRegister255) + uint32_t(r_PtxRegister12);	// PTX L319
	r_PtxRegister257 = ShiftLeft(uint32_t(r_PtxRegister254), uint32_t(12));		// PTX L320
	r_PtxRegister258 = ShiftLeft(uint32_t(r_PtxRegister256), uint32_t(7));		// PTX L321
	r_PtxRegister259 = uint32_t(r_PtxRegister257) + uint32_t(r_PtxRegister258); // PTX L322
	r_PtxU64Register385 = SignExtendWordBits(r_PtxRegister259);					// PTX L323
L__BB18_29:																		// PTX L324
	r_PtxU64Register386 = uint64_t(0);											// PTX L325
	if (r_bPtxPredicate86)
	{
		goto L__BB18_31;
	} // PTX L326
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register385), uint32_t(2));		   // PTX L327
	r_PtxU64Register386 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register37); // PTX L328
L__BB18_31:																			   // PTX L329
	if (r_bPtxPredicate86)
	{
		goto L__BB18_34;
	} // PTX L330
	r_PtxRegister265 = uint32_t(-1);							   // PTX L331
	r_PtxRegister264 = Elected(r_PtxRegister265);				   // PTX L333
	r_bPtxPredicate87 = uint32_t(r_PtxRegister264) == uint32_t(0); // PTX L339
	if (r_bPtxPredicate87)
	{
		goto L__BB18_35;
	} // PTX L340
	r_PtxRegister266 = uint32_t(r_PtxRegister19) + uint32_t(4096);				 // PTX L341
	r_PtxU64Register38 = r_PtxU64Register386;									 // PTX L342
	r_PtxRegister269 = uint32_t(12288u /* exact native shared-region offset */); // PTX L343
	r_PtxRegister268 = uint32_t(r_PtxRegister269) + uint32_t(8);				 // PTX L344
	r_PtxRegister267 = uint32_t(512);											 // PTX L345
	CopyBulk(s_SharedStorage, r_PtxRegister266, r_PtxU64Register38, r_PtxRegister267,
			 r_PtxRegister268);												   // PTX L347
	BarrierExpect(s_SharedStorage, r_PtxRegister268, r_PtxRegister267);		   // PTX L350
	goto L__BB18_35;														   // PTX L352
L__BB18_34:																	   // PTX L353
	r_LaneIndexAtPtx355 = uint32_t((threadIdx.x & 31u));					   // PTX L355
	r_PtxRegister262 = ShiftLeft(uint32_t(r_LaneIndexAtPtx355), uint32_t(4));  // PTX L357
	r_PtxRegister263 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister262); // PTX L358
	r_PtxRegister261 = uint32_t(r_PtxRegister263) + uint32_t(4096);			   // PTX L359
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister261)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);	   // PTX L361
L__BB18_35:										   // PTX L363
	r_bPtxPredicate1143 = bool(0);				   // PTX L364
	r_PtxRegister2696 = uint32_t(r_PtxRegister16); // PTX L365
	if (r_bPtxPredicate81)
	{
		goto L__BB18_38;
	} // PTX L366
	r_PtxRegister270 = r_WidthBits & -4;						   // PTX L367
	r_bPtxPredicate88 = uint32_t(r_PtxRegister270) == uint32_t(4); // PTX L368
	r_bPtxPredicate1143 = bool(-1);								   // PTX L369
	r_PtxRegister2696 = uint32_t(0);							   // PTX L370
	if (r_bPtxPredicate88)
	{
		goto L__BB18_38;
	} // PTX L371
	r_bPtxPredicate1143 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L372
	r_PtxRegister2696 = uint32_t(r_PtxRegister16);							   // PTX L373
L__BB18_38:																	   // PTX L374
	r_PtxU64Register387 = uint64_t(0);										   // PTX L375
	r_bPtxPredicate89 = !r_bPtxPredicate1143;								   // PTX L376
	if (r_bPtxPredicate89)
	{
		goto L__BB18_40;
	} // PTX L377
	r_PtxRegister271 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister2696); // PTX L378
	r_PtxRegister272 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(4));		// PTX L379
	r_PtxRegister273 = uint32_t(r_PtxRegister272) + uint32_t(r_PtxRegister12);	// PTX L380
	r_PtxRegister274 = ShiftLeft(uint32_t(r_PtxRegister271), uint32_t(12));		// PTX L381
	r_PtxRegister275 = ShiftLeft(uint32_t(r_PtxRegister273), uint32_t(7));		// PTX L382
	r_PtxRegister276 = uint32_t(r_PtxRegister274) + uint32_t(r_PtxRegister275); // PTX L383
	r_PtxU64Register387 = SignExtendWordBits(r_PtxRegister276);					// PTX L384
L__BB18_40:																		// PTX L385
	r_PtxU64Register388 = uint64_t(0);											// PTX L386
	if (r_bPtxPredicate89)
	{
		goto L__BB18_42;
	} // PTX L387
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register387), uint32_t(2));		   // PTX L388
	r_PtxU64Register388 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register39); // PTX L389
L__BB18_42:																			   // PTX L390
	if (r_bPtxPredicate89)
	{
		goto L__BB18_45;
	} // PTX L391
	r_PtxRegister282 = uint32_t(-1);							   // PTX L392
	r_PtxRegister281 = Elected(r_PtxRegister282);				   // PTX L394
	r_bPtxPredicate90 = uint32_t(r_PtxRegister281) == uint32_t(0); // PTX L400
	if (r_bPtxPredicate90)
	{
		goto L__BB18_46;
	} // PTX L401
	r_PtxRegister283 = uint32_t(r_PtxRegister22) + uint32_t(4096);				 // PTX L402
	r_PtxU64Register40 = r_PtxU64Register388;									 // PTX L403
	r_PtxRegister286 = uint32_t(12288u /* exact native shared-region offset */); // PTX L404
	r_PtxRegister285 = uint32_t(r_PtxRegister286) + uint32_t(8);				 // PTX L405
	r_PtxRegister284 = uint32_t(512);											 // PTX L406
	CopyBulk(s_SharedStorage, r_PtxRegister283, r_PtxU64Register40, r_PtxRegister284,
			 r_PtxRegister285);												   // PTX L408
	BarrierExpect(s_SharedStorage, r_PtxRegister285, r_PtxRegister284);		   // PTX L411
	goto L__BB18_46;														   // PTX L413
L__BB18_45:																	   // PTX L414
	r_LaneIndexAtPtx416 = uint32_t((threadIdx.x & 31u));					   // PTX L416
	r_PtxRegister279 = ShiftLeft(uint32_t(r_LaneIndexAtPtx416), uint32_t(4));  // PTX L418
	r_PtxRegister280 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister279); // PTX L419
	r_PtxRegister278 = uint32_t(r_PtxRegister280) + uint32_t(4096);			   // PTX L420
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister278)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);					// PTX L422
L__BB18_46:														// PTX L424
	r_PtxRegister24 = uint32_t(r_PtxRegister23) + uint32_t(32); // PTX L425
	r_bPtxPredicate1144 = bool(0);								// PTX L426
	r_PtxRegister2697 = uint32_t(r_PtxRegister16);				// PTX L427
	if (r_bPtxPredicate75)
	{
		goto L__BB18_49;
	} // PTX L428
	r_PtxRegister287 = r_WidthBits & -4;						   // PTX L429
	r_bPtxPredicate91 = uint32_t(r_PtxRegister287) == uint32_t(4); // PTX L430
	r_bPtxPredicate1144 = bool(-1);								   // PTX L431
	r_PtxRegister2697 = uint32_t(0);							   // PTX L432
	if (r_bPtxPredicate91)
	{
		goto L__BB18_49;
	} // PTX L433
	r_bPtxPredicate1144 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L434
	r_PtxRegister2697 = uint32_t(r_PtxRegister16);							   // PTX L435
L__BB18_49:																	   // PTX L436
	r_PtxU64Register389 = uint64_t(0);										   // PTX L437
	r_bPtxPredicate92 = !r_bPtxPredicate1144;								   // PTX L438
	if (r_bPtxPredicate92)
	{
		goto L__BB18_51;
	} // PTX L439
	r_PtxRegister288 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2697); // PTX L440
	r_PtxRegister289 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L441
	r_PtxRegister290 = uint32_t(r_PtxRegister289) + uint32_t(r_PtxRegister12);	// PTX L442
	r_PtxRegister291 = ShiftLeft(uint32_t(r_PtxRegister288), uint32_t(12));		// PTX L443
	r_PtxRegister292 = ShiftLeft(uint32_t(r_PtxRegister290), uint32_t(7));		// PTX L444
	r_PtxRegister293 = uint32_t(r_PtxRegister291) + uint32_t(r_PtxRegister292); // PTX L445
	r_PtxU64Register389 = SignExtendWordBits(r_PtxRegister293);					// PTX L446
L__BB18_51:																		// PTX L447
	r_PtxU64Register390 = uint64_t(0);											// PTX L448
	if (r_bPtxPredicate92)
	{
		goto L__BB18_53;
	} // PTX L449
	r_PtxU64Register41 = ShiftLeft(uint64_t(r_PtxU64Register389), uint32_t(2));		   // PTX L450
	r_PtxU64Register390 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register41); // PTX L451
L__BB18_53:																			   // PTX L452
	if (r_bPtxPredicate92)
	{
		goto L__BB18_56;
	} // PTX L453
	r_PtxRegister299 = uint32_t(-1);							   // PTX L454
	r_PtxRegister298 = Elected(r_PtxRegister299);				   // PTX L456
	r_bPtxPredicate93 = uint32_t(r_PtxRegister298) == uint32_t(0); // PTX L462
	if (r_bPtxPredicate93)
	{
		goto L__BB18_57;
	} // PTX L463
	r_PtxRegister300 = uint32_t(r_PtxRegister19) + uint32_t(8192);				 // PTX L464
	r_PtxU64Register42 = r_PtxU64Register390;									 // PTX L465
	r_PtxRegister303 = uint32_t(12288u /* exact native shared-region offset */); // PTX L466
	r_PtxRegister302 = uint32_t(r_PtxRegister303) + uint32_t(16);				 // PTX L467
	r_PtxRegister301 = uint32_t(512);											 // PTX L468
	CopyBulk(s_SharedStorage, r_PtxRegister300, r_PtxU64Register42, r_PtxRegister301,
			 r_PtxRegister302);												   // PTX L470
	BarrierExpect(s_SharedStorage, r_PtxRegister302, r_PtxRegister301);		   // PTX L473
	goto L__BB18_57;														   // PTX L475
L__BB18_56:																	   // PTX L476
	r_LaneIndexAtPtx478 = uint32_t((threadIdx.x & 31u));					   // PTX L478
	r_PtxRegister296 = ShiftLeft(uint32_t(r_LaneIndexAtPtx478), uint32_t(4));  // PTX L480
	r_PtxRegister297 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister296); // PTX L481
	r_PtxRegister295 = uint32_t(r_PtxRegister297) + uint32_t(8192);			   // PTX L482
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister295)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);	   // PTX L484
L__BB18_57:										   // PTX L486
	r_bPtxPredicate1145 = bool(0);				   // PTX L487
	r_PtxRegister2698 = uint32_t(r_PtxRegister16); // PTX L488
	if (r_bPtxPredicate81)
	{
		goto L__BB18_60;
	} // PTX L489
	r_PtxRegister304 = r_WidthBits & -4;						   // PTX L490
	r_bPtxPredicate94 = uint32_t(r_PtxRegister304) == uint32_t(4); // PTX L491
	r_bPtxPredicate1145 = bool(-1);								   // PTX L492
	r_PtxRegister2698 = uint32_t(0);							   // PTX L493
	if (r_bPtxPredicate94)
	{
		goto L__BB18_60;
	} // PTX L494
	r_bPtxPredicate1145 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L495
	r_PtxRegister2698 = uint32_t(r_PtxRegister16);							   // PTX L496
L__BB18_60:																	   // PTX L497
	r_PtxU64Register391 = uint64_t(0);										   // PTX L498
	r_bPtxPredicate95 = !r_bPtxPredicate1145;								   // PTX L499
	if (r_bPtxPredicate95)
	{
		goto L__BB18_62;
	} // PTX L500
	r_PtxRegister305 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister2698); // PTX L501
	r_PtxRegister306 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L502
	r_PtxRegister307 = uint32_t(r_PtxRegister306) + uint32_t(r_PtxRegister12);	// PTX L503
	r_PtxRegister308 = ShiftLeft(uint32_t(r_PtxRegister305), uint32_t(12));		// PTX L504
	r_PtxRegister309 = ShiftLeft(uint32_t(r_PtxRegister307), uint32_t(7));		// PTX L505
	r_PtxRegister310 = uint32_t(r_PtxRegister308) + uint32_t(r_PtxRegister309); // PTX L506
	r_PtxU64Register391 = SignExtendWordBits(r_PtxRegister310);					// PTX L507
L__BB18_62:																		// PTX L508
	r_PtxU64Register392 = uint64_t(0);											// PTX L509
	if (r_bPtxPredicate95)
	{
		goto L__BB18_64;
	} // PTX L510
	r_PtxU64Register43 = ShiftLeft(uint64_t(r_PtxU64Register391), uint32_t(2));		   // PTX L511
	r_PtxU64Register392 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register43); // PTX L512
L__BB18_64:																			   // PTX L513
	if (r_bPtxPredicate95)
	{
		goto L__BB18_67;
	} // PTX L514
	r_PtxRegister317 = uint32_t(-1);							   // PTX L515
	r_PtxRegister316 = Elected(r_PtxRegister317);				   // PTX L517
	r_bPtxPredicate96 = uint32_t(r_PtxRegister316) == uint32_t(0); // PTX L523
	if (r_bPtxPredicate96)
	{
		goto L__BB18_68;
	} // PTX L524
	r_PtxRegister318 = uint32_t(r_PtxRegister22) + uint32_t(8192);				 // PTX L525
	r_PtxU64Register44 = r_PtxU64Register392;									 // PTX L526
	r_PtxRegister321 = uint32_t(12288u /* exact native shared-region offset */); // PTX L527
	r_PtxRegister320 = uint32_t(r_PtxRegister321) + uint32_t(16);				 // PTX L528
	r_PtxRegister319 = uint32_t(512);											 // PTX L529
	CopyBulk(s_SharedStorage, r_PtxRegister318, r_PtxU64Register44, r_PtxRegister319,
			 r_PtxRegister320);												   // PTX L531
	BarrierExpect(s_SharedStorage, r_PtxRegister320, r_PtxRegister319);		   // PTX L534
	goto L__BB18_68;														   // PTX L536
L__BB18_67:																	   // PTX L537
	r_LaneIndexAtPtx539 = uint32_t((threadIdx.x & 31u));					   // PTX L539
	r_PtxRegister314 = ShiftLeft(uint32_t(r_LaneIndexAtPtx539), uint32_t(4));  // PTX L541
	r_PtxRegister315 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister314); // PTX L542
	r_PtxRegister312 = uint32_t(r_PtxRegister315) + uint32_t(8192);			   // PTX L543
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister312)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);									 // PTX L545
L__BB18_68:																		 // PTX L547
	r_PtxRegister322 = uint32_t(12288u /* exact native shared-region offset */); // PTX L548
	r_PtxRegister323 = uint32_t(1);												 // PTX L549
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register45 = BarrierArrive(s_SharedStorage, r_PtxRegister322, r_PtxRegister323); // PTX L551
L__BB18_69:																					 // PTX L553
	r_PtxRegister325 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L554
	r_PtxRegister324 = BarrierReady(s_SharedStorage, r_PtxRegister325, r_PtxU64Register45);	 // PTX L556
	r_bPtxPredicate97 = uint32_t(r_PtxRegister324) == uint32_t(0);							 // PTX L562
	if (r_bPtxPredicate97)
	{
		goto L__BB18_69;
	} // PTX L563
	r_PtxRegister327 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(5));			 // PTX L564
	r_PtxRegister328 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(3));			 // PTX L565
	r_bPtxPredicate98 = uint32_t(r_HeightBits) != uint32_t(1);						 // PTX L566
	r_bPtxPredicate99 = uint32_t(r_HeightBits) == uint32_t(1);						 // PTX L567
	r_bPtxPredicate100 = uint32_t(r_WidthBits) == uint32_t(1);						 // PTX L568
	r_PtxRegister25 = ShiftLeft(uint32_t(r_WidthBits), uint32_t(2));				 // PTX L569
	r_LaneIndexAtPtx571 = uint32_t((threadIdx.x & 31u));							 // PTX L571
	r_PtxRegister329 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx571), uint32_t(31)); // PTX L573
	r_PtxRegister330 = ShiftRight(uint32_t(r_PtxRegister329), uint32_t(30));		 // PTX L574
	r_PtxRegister331 = uint32_t(r_LaneIndexAtPtx571) + uint32_t(r_PtxRegister330);	 // PTX L575
	r_PtxRegister332 = ShiftRightSigned(int32_t(r_PtxRegister331), uint32_t(2));	 // PTX L576
	r_PtxRegister333 = ShiftRight(uint32_t(r_PtxRegister332), uint32_t(30));		 // PTX L577
	r_PtxRegister334 = uint32_t(r_PtxRegister332) + uint32_t(r_PtxRegister333);		 // PTX L578
	r_PtxRegister335 = r_PtxRegister334 & -4;										 // PTX L579
	r_PtxRegister336 = uint32_t(r_PtxRegister332) - uint32_t(r_PtxRegister335);		 // PTX L580
	r_PtxRegister337 = ShiftRight(uint32_t(r_PtxRegister329), uint32_t(28));		 // PTX L581
	r_PtxRegister338 = uint32_t(r_LaneIndexAtPtx571) + uint32_t(r_PtxRegister337);	 // PTX L582
	r_PtxRegister339 = ShiftRightSigned(int32_t(r_PtxRegister338), uint32_t(4));	 // PTX L583
	r_PtxRegister26 = uint32_t(r_PtxRegister327) + uint32_t(r_PtxRegister328);		 // PTX L584
	r_PtxRegister340 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister339);		 // PTX L585
	r_PtxRegister27 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister336);		 // PTX L586
	r_bPtxPredicate101 = int32_t(r_PtxRegister340) < int32_t(0);					 // PTX L587
	r_bPtxPredicate102 = int32_t(r_PtxRegister340) >= int32_t(r_HeightBits);		 // PTX L588
	r_bPtxPredicate103 = r_bPtxPredicate101 | r_bPtxPredicate102;					 // PTX L589
	r_bPtxPredicate104 = !r_bPtxPredicate103;										 // PTX L590
	r_PtxRegister28 = r_bPtxPredicate99 ? 0 : r_PtxRegister340;						 // PTX L591
	r_bPtxPredicate105 = r_bPtxPredicate98 & r_bPtxPredicate103;					 // PTX L592
	r_bPtxPredicate106 = r_bPtxPredicate99 | r_bPtxPredicate104;					 // PTX L593
	r_bPtxPredicate107 = r_bPtxPredicate105 | r_bPtxPredicate100;					 // PTX L594
	r_bPtxPredicate108 = int32_t(r_PtxRegister27) > int32_t(-1);					 // PTX L595
	r_bPtxPredicate109 = int32_t(r_PtxRegister27) < int32_t(r_WidthBits);			 // PTX L596
	r_bPtxPredicate110 = r_bPtxPredicate108 & r_bPtxPredicate109;					 // PTX L597
	r_bPtxPredicate111 = !r_bPtxPredicate105;										 // PTX L598
	r_bPtxPredicate3 = r_bPtxPredicate100 & r_bPtxPredicate111;						 // PTX L599
	r_bPtxPredicate112 = r_bPtxPredicate107 | r_bPtxPredicate110;					 // PTX L600
	r_bPtxPredicate113 = r_bPtxPredicate112 & r_bPtxPredicate106;					 // PTX L601
	r_PtxRegister2699 = uint32_t(0);												 // PTX L602
	r_bPtxPredicate114 = !r_bPtxPredicate113;										 // PTX L603
	if (r_bPtxPredicate114)
	{
		goto L__BB18_72;
	} // PTX L604
	r_PtxRegister341 = r_PtxRegister331 & -4;									   // PTX L605
	r_PtxRegister342 = uint32_t(r_LaneIndexAtPtx571) - uint32_t(r_PtxRegister341); // PTX L606
	r_PtxRegister343 = ShiftLeft(uint32_t(r_PtxRegister27), uint32_t(2));		   // PTX L607
	r_PtxRegister344 = r_bPtxPredicate3 ? 0 : r_PtxRegister343;					   // PTX L608
	r_PtxRegister345 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister28); // PTX L609
	r_PtxRegister346 =
		uint32_t(r_PtxRegister345) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister342); // PTX L610
	r_PtxRegister347 = uint32_t(r_PtxRegister346) + uint32_t(r_PtxRegister344);				 // PTX L611
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister347)) * int64_t(int32_t(4))); // PTX L612
	g_ResidualByteAddressAtPtx613 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register46);			   // PTX L613
	r_PtxRegister2699 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx613); // PTX L614
L__BB18_72:																				   // PTX L615
	r_bPtxPredicate115 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L616
	r_bPtxPredicate116 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L617
	r_bPtxPredicate117 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L618
	r_LaneIndexAtPtx620 = uint32_t((threadIdx.x & 31u));								   // PTX L620
	r_PtxRegister349 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx620), uint32_t(31));	   // PTX L622
	r_PtxRegister350 = ShiftRight(uint32_t(r_PtxRegister349), uint32_t(30));			   // PTX L623
	r_PtxRegister351 = uint32_t(r_LaneIndexAtPtx620) + uint32_t(r_PtxRegister350);		   // PTX L624
	r_PtxRegister352 = ShiftRightSigned(int32_t(r_PtxRegister351), uint32_t(2));		   // PTX L625
	r_PtxRegister353 = ShiftRight(uint32_t(r_PtxRegister352), uint32_t(30));			   // PTX L626
	r_PtxRegister354 = uint32_t(r_PtxRegister352) + uint32_t(r_PtxRegister353);			   // PTX L627
	r_PtxRegister355 = r_PtxRegister354 & -4;											   // PTX L628
	r_PtxRegister356 = uint32_t(r_PtxRegister352) - uint32_t(r_PtxRegister355);			   // PTX L629
	r_PtxRegister357 = ShiftRight(uint32_t(r_PtxRegister349), uint32_t(28));			   // PTX L630
	r_PtxRegister358 = uint32_t(r_LaneIndexAtPtx620) + uint32_t(r_PtxRegister357);		   // PTX L631
	r_PtxRegister359 = ShiftRightSigned(int32_t(r_PtxRegister358), uint32_t(4));		   // PTX L632
	r_PtxRegister360 = uint32_t(r_PtxRegister359) + uint32_t(r_PtxRegister4);			   // PTX L633
	r_PtxRegister361 = uint32_t(r_PtxRegister360) + uint32_t(2);						   // PTX L634
	r_PtxRegister29 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister356);			   // PTX L635
	r_bPtxPredicate118 = int32_t(r_PtxRegister361) < int32_t(0);						   // PTX L636
	r_bPtxPredicate119 = int32_t(r_PtxRegister361) >= int32_t(r_HeightBits);			   // PTX L637
	r_bPtxPredicate120 = r_bPtxPredicate118 | r_bPtxPredicate119;						   // PTX L638
	r_bPtxPredicate121 = !r_bPtxPredicate120;											   // PTX L639
	r_PtxRegister30 = r_bPtxPredicate117 ? 0 : r_PtxRegister361;						   // PTX L640
	r_bPtxPredicate122 = r_bPtxPredicate116 & r_bPtxPredicate120;						   // PTX L641
	r_bPtxPredicate123 = r_bPtxPredicate117 | r_bPtxPredicate121;						   // PTX L642
	r_bPtxPredicate124 = r_bPtxPredicate122 | r_bPtxPredicate115;						   // PTX L643
	r_bPtxPredicate125 = int32_t(r_PtxRegister29) > int32_t(-1);						   // PTX L644
	r_bPtxPredicate126 = int32_t(r_PtxRegister29) < int32_t(r_WidthBits);				   // PTX L645
	r_bPtxPredicate127 = r_bPtxPredicate125 & r_bPtxPredicate126;						   // PTX L646
	r_bPtxPredicate128 = !r_bPtxPredicate122;											   // PTX L647
	r_bPtxPredicate4 = r_bPtxPredicate115 & r_bPtxPredicate128;							   // PTX L648
	r_bPtxPredicate129 = r_bPtxPredicate124 | r_bPtxPredicate127;						   // PTX L649
	r_bPtxPredicate130 = r_bPtxPredicate129 & r_bPtxPredicate123;						   // PTX L650
	r_PtxRegister2700 = uint32_t(0);													   // PTX L651
	r_bPtxPredicate131 = !r_bPtxPredicate130;											   // PTX L652
	if (r_bPtxPredicate131)
	{
		goto L__BB18_74;
	} // PTX L653
	r_PtxRegister362 = r_PtxRegister351 & -4;									   // PTX L654
	r_PtxRegister363 = uint32_t(r_LaneIndexAtPtx620) - uint32_t(r_PtxRegister362); // PTX L655
	r_PtxRegister364 = ShiftLeft(uint32_t(r_PtxRegister29), uint32_t(2));		   // PTX L656
	r_PtxRegister365 = r_bPtxPredicate4 ? 0 : r_PtxRegister364;					   // PTX L657
	r_PtxRegister366 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister30); // PTX L658
	r_PtxRegister367 =
		uint32_t(r_PtxRegister366) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister363); // PTX L659
	r_PtxRegister368 = uint32_t(r_PtxRegister367) + uint32_t(r_PtxRegister365);				 // PTX L660
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister368)) * int64_t(int32_t(4))); // PTX L661
	g_ResidualByteAddressAtPtx662 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register48);			   // PTX L662
	r_PtxRegister2700 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx662); // PTX L663
L__BB18_74:																				   // PTX L664
	r_bPtxPredicate132 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L665
	r_bPtxPredicate133 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L666
	r_bPtxPredicate134 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L667
	r_LaneIndexAtPtx669 = uint32_t((threadIdx.x & 31u));								   // PTX L669
	r_PtxRegister370 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx669), uint32_t(31));	   // PTX L671
	r_PtxRegister371 = ShiftRight(uint32_t(r_PtxRegister370), uint32_t(30));			   // PTX L672
	r_PtxRegister372 = uint32_t(r_LaneIndexAtPtx669) + uint32_t(r_PtxRegister371);		   // PTX L673
	r_PtxRegister373 = ShiftRightSigned(int32_t(r_PtxRegister372), uint32_t(2));		   // PTX L674
	r_PtxRegister374 = ShiftRight(uint32_t(r_PtxRegister373), uint32_t(30));			   // PTX L675
	r_PtxRegister375 = uint32_t(r_PtxRegister373) + uint32_t(r_PtxRegister374);			   // PTX L676
	r_PtxRegister376 = r_PtxRegister375 & -4;											   // PTX L677
	r_PtxRegister377 = uint32_t(r_PtxRegister373) - uint32_t(r_PtxRegister376);			   // PTX L678
	r_PtxRegister378 = ShiftRight(uint32_t(r_PtxRegister370), uint32_t(28));			   // PTX L679
	r_PtxRegister379 = uint32_t(r_LaneIndexAtPtx669) + uint32_t(r_PtxRegister378);		   // PTX L680
	r_PtxRegister380 = ShiftRightSigned(int32_t(r_PtxRegister379), uint32_t(4));		   // PTX L681
	r_PtxRegister31 = uint32_t(r_PtxRegister26) + uint32_t(1);							   // PTX L682
	r_PtxRegister381 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister380);			   // PTX L683
	r_PtxRegister32 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister377);			   // PTX L684
	r_bPtxPredicate135 = int32_t(r_PtxRegister381) < int32_t(0);						   // PTX L685
	r_bPtxPredicate136 = int32_t(r_PtxRegister381) >= int32_t(r_HeightBits);			   // PTX L686
	r_bPtxPredicate137 = r_bPtxPredicate135 | r_bPtxPredicate136;						   // PTX L687
	r_bPtxPredicate138 = !r_bPtxPredicate137;											   // PTX L688
	r_PtxRegister33 = r_bPtxPredicate134 ? 0 : r_PtxRegister381;						   // PTX L689
	r_bPtxPredicate139 = r_bPtxPredicate133 & r_bPtxPredicate137;						   // PTX L690
	r_bPtxPredicate140 = r_bPtxPredicate134 | r_bPtxPredicate138;						   // PTX L691
	r_bPtxPredicate141 = r_bPtxPredicate139 | r_bPtxPredicate132;						   // PTX L692
	r_bPtxPredicate142 = int32_t(r_PtxRegister32) > int32_t(-1);						   // PTX L693
	r_bPtxPredicate143 = int32_t(r_PtxRegister32) < int32_t(r_WidthBits);				   // PTX L694
	r_bPtxPredicate144 = r_bPtxPredicate142 & r_bPtxPredicate143;						   // PTX L695
	r_bPtxPredicate145 = !r_bPtxPredicate139;											   // PTX L696
	r_bPtxPredicate5 = r_bPtxPredicate132 & r_bPtxPredicate145;							   // PTX L697
	r_bPtxPredicate146 = r_bPtxPredicate141 | r_bPtxPredicate144;						   // PTX L698
	r_bPtxPredicate147 = r_bPtxPredicate146 & r_bPtxPredicate140;						   // PTX L699
	r_PtxRegister2701 = uint32_t(0);													   // PTX L700
	r_bPtxPredicate148 = !r_bPtxPredicate147;											   // PTX L701
	if (r_bPtxPredicate148)
	{
		goto L__BB18_76;
	} // PTX L702
	r_PtxRegister382 = r_PtxRegister372 & -4;									   // PTX L703
	r_PtxRegister383 = uint32_t(r_LaneIndexAtPtx669) - uint32_t(r_PtxRegister382); // PTX L704
	r_PtxRegister384 = ShiftLeft(uint32_t(r_PtxRegister32), uint32_t(2));		   // PTX L705
	r_PtxRegister385 = r_bPtxPredicate5 ? 0 : r_PtxRegister384;					   // PTX L706
	r_PtxRegister386 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister33); // PTX L707
	r_PtxRegister387 =
		uint32_t(r_PtxRegister386) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister383); // PTX L708
	r_PtxRegister388 = uint32_t(r_PtxRegister387) + uint32_t(r_PtxRegister385);				 // PTX L709
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister388)) * int64_t(int32_t(4))); // PTX L710
	g_ResidualByteAddressAtPtx711 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register50);			   // PTX L711
	r_PtxRegister2701 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx711); // PTX L712
L__BB18_76:																				   // PTX L713
	r_bPtxPredicate149 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L714
	r_bPtxPredicate150 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L715
	r_bPtxPredicate151 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L716
	r_LaneIndexAtPtx718 = uint32_t((threadIdx.x & 31u));								   // PTX L718
	r_PtxRegister390 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx718), uint32_t(31));	   // PTX L720
	r_PtxRegister391 = ShiftRight(uint32_t(r_PtxRegister390), uint32_t(30));			   // PTX L721
	r_PtxRegister392 = uint32_t(r_LaneIndexAtPtx718) + uint32_t(r_PtxRegister391);		   // PTX L722
	r_PtxRegister393 = ShiftRightSigned(int32_t(r_PtxRegister392), uint32_t(2));		   // PTX L723
	r_PtxRegister394 = ShiftRight(uint32_t(r_PtxRegister393), uint32_t(30));			   // PTX L724
	r_PtxRegister395 = uint32_t(r_PtxRegister393) + uint32_t(r_PtxRegister394);			   // PTX L725
	r_PtxRegister396 = r_PtxRegister395 & -4;											   // PTX L726
	r_PtxRegister397 = uint32_t(r_PtxRegister393) - uint32_t(r_PtxRegister396);			   // PTX L727
	r_PtxRegister398 = ShiftRight(uint32_t(r_PtxRegister390), uint32_t(28));			   // PTX L728
	r_PtxRegister399 = uint32_t(r_LaneIndexAtPtx718) + uint32_t(r_PtxRegister398);		   // PTX L729
	r_PtxRegister400 = ShiftRightSigned(int32_t(r_PtxRegister399), uint32_t(4));		   // PTX L730
	r_PtxRegister401 = uint32_t(r_PtxRegister400) + uint32_t(r_PtxRegister4);			   // PTX L731
	r_PtxRegister402 = uint32_t(r_PtxRegister401) + uint32_t(2);						   // PTX L732
	r_PtxRegister34 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister397);			   // PTX L733
	r_bPtxPredicate152 = int32_t(r_PtxRegister402) < int32_t(0);						   // PTX L734
	r_bPtxPredicate153 = int32_t(r_PtxRegister402) >= int32_t(r_HeightBits);			   // PTX L735
	r_bPtxPredicate154 = r_bPtxPredicate152 | r_bPtxPredicate153;						   // PTX L736
	r_bPtxPredicate155 = !r_bPtxPredicate154;											   // PTX L737
	r_PtxRegister35 = r_bPtxPredicate151 ? 0 : r_PtxRegister402;						   // PTX L738
	r_bPtxPredicate156 = r_bPtxPredicate150 & r_bPtxPredicate154;						   // PTX L739
	r_bPtxPredicate157 = r_bPtxPredicate151 | r_bPtxPredicate155;						   // PTX L740
	r_bPtxPredicate158 = r_bPtxPredicate156 | r_bPtxPredicate149;						   // PTX L741
	r_bPtxPredicate159 = int32_t(r_PtxRegister34) > int32_t(-1);						   // PTX L742
	r_bPtxPredicate160 = int32_t(r_PtxRegister34) < int32_t(r_WidthBits);				   // PTX L743
	r_bPtxPredicate161 = r_bPtxPredicate159 & r_bPtxPredicate160;						   // PTX L744
	r_bPtxPredicate162 = !r_bPtxPredicate156;											   // PTX L745
	r_bPtxPredicate6 = r_bPtxPredicate149 & r_bPtxPredicate162;							   // PTX L746
	r_bPtxPredicate163 = r_bPtxPredicate158 | r_bPtxPredicate161;						   // PTX L747
	r_bPtxPredicate164 = r_bPtxPredicate163 & r_bPtxPredicate157;						   // PTX L748
	r_PtxRegister2702 = uint32_t(0);													   // PTX L749
	r_bPtxPredicate165 = !r_bPtxPredicate164;											   // PTX L750
	if (r_bPtxPredicate165)
	{
		goto L__BB18_78;
	} // PTX L751
	r_PtxRegister403 = r_PtxRegister392 & -4;									   // PTX L752
	r_PtxRegister404 = uint32_t(r_LaneIndexAtPtx718) - uint32_t(r_PtxRegister403); // PTX L753
	r_PtxRegister405 = ShiftLeft(uint32_t(r_PtxRegister34), uint32_t(2));		   // PTX L754
	r_PtxRegister406 = r_bPtxPredicate6 ? 0 : r_PtxRegister405;					   // PTX L755
	r_PtxRegister407 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister35); // PTX L756
	r_PtxRegister408 =
		uint32_t(r_PtxRegister407) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister404); // PTX L757
	r_PtxRegister409 = uint32_t(r_PtxRegister408) + uint32_t(r_PtxRegister406);				 // PTX L758
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_PtxRegister409)) * int64_t(int32_t(4))); // PTX L759
	g_ResidualByteAddressAtPtx760 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register52);			   // PTX L760
	r_PtxRegister2702 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx760); // PTX L761
L__BB18_78:																				   // PTX L762
	r_bPtxPredicate166 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L763
	r_bPtxPredicate167 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L764
	r_bPtxPredicate168 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L765
	r_LaneIndexAtPtx767 = uint32_t((threadIdx.x & 31u));								   // PTX L767
	r_PtxRegister411 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx767), uint32_t(31));	   // PTX L769
	r_PtxRegister412 = ShiftRight(uint32_t(r_PtxRegister411), uint32_t(30));			   // PTX L770
	r_PtxRegister413 = uint32_t(r_LaneIndexAtPtx767) + uint32_t(r_PtxRegister412);		   // PTX L771
	r_PtxRegister414 = ShiftRightSigned(int32_t(r_PtxRegister413), uint32_t(2));		   // PTX L772
	r_PtxRegister415 = ShiftRight(uint32_t(r_PtxRegister414), uint32_t(30));			   // PTX L773
	r_PtxRegister416 = uint32_t(r_PtxRegister414) + uint32_t(r_PtxRegister415);			   // PTX L774
	r_PtxRegister417 = r_PtxRegister416 & -4;											   // PTX L775
	r_PtxRegister418 = uint32_t(r_PtxRegister414) - uint32_t(r_PtxRegister417);			   // PTX L776
	r_PtxRegister419 = ShiftRight(uint32_t(r_PtxRegister411), uint32_t(28));			   // PTX L777
	r_PtxRegister420 = uint32_t(r_LaneIndexAtPtx767) + uint32_t(r_PtxRegister419);		   // PTX L778
	r_PtxRegister421 = ShiftRightSigned(int32_t(r_PtxRegister420), uint32_t(4));		   // PTX L779
	r_PtxRegister36 = uint32_t(r_PtxRegister26) + uint32_t(2);							   // PTX L780
	r_PtxRegister422 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister421);			   // PTX L781
	r_PtxRegister37 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister418);			   // PTX L782
	r_bPtxPredicate169 = int32_t(r_PtxRegister422) < int32_t(0);						   // PTX L783
	r_bPtxPredicate170 = int32_t(r_PtxRegister422) >= int32_t(r_HeightBits);			   // PTX L784
	r_bPtxPredicate171 = r_bPtxPredicate169 | r_bPtxPredicate170;						   // PTX L785
	r_bPtxPredicate172 = !r_bPtxPredicate171;											   // PTX L786
	r_PtxRegister38 = r_bPtxPredicate168 ? 0 : r_PtxRegister422;						   // PTX L787
	r_bPtxPredicate173 = r_bPtxPredicate167 & r_bPtxPredicate171;						   // PTX L788
	r_bPtxPredicate174 = r_bPtxPredicate168 | r_bPtxPredicate172;						   // PTX L789
	r_bPtxPredicate175 = r_bPtxPredicate173 | r_bPtxPredicate166;						   // PTX L790
	r_bPtxPredicate176 = int32_t(r_PtxRegister37) > int32_t(-1);						   // PTX L791
	r_bPtxPredicate177 = int32_t(r_PtxRegister37) < int32_t(r_WidthBits);				   // PTX L792
	r_bPtxPredicate178 = r_bPtxPredicate176 & r_bPtxPredicate177;						   // PTX L793
	r_bPtxPredicate179 = !r_bPtxPredicate173;											   // PTX L794
	r_bPtxPredicate7 = r_bPtxPredicate166 & r_bPtxPredicate179;							   // PTX L795
	r_bPtxPredicate180 = r_bPtxPredicate175 | r_bPtxPredicate178;						   // PTX L796
	r_bPtxPredicate181 = r_bPtxPredicate180 & r_bPtxPredicate174;						   // PTX L797
	r_PtxRegister2703 = uint32_t(0);													   // PTX L798
	r_bPtxPredicate182 = !r_bPtxPredicate181;											   // PTX L799
	if (r_bPtxPredicate182)
	{
		goto L__BB18_80;
	} // PTX L800
	r_PtxRegister423 = r_PtxRegister413 & -4;									   // PTX L801
	r_PtxRegister424 = uint32_t(r_LaneIndexAtPtx767) - uint32_t(r_PtxRegister423); // PTX L802
	r_PtxRegister425 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(2));		   // PTX L803
	r_PtxRegister426 = r_bPtxPredicate7 ? 0 : r_PtxRegister425;					   // PTX L804
	r_PtxRegister427 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister38); // PTX L805
	r_PtxRegister428 =
		uint32_t(r_PtxRegister427) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister424); // PTX L806
	r_PtxRegister429 = uint32_t(r_PtxRegister428) + uint32_t(r_PtxRegister426);				 // PTX L807
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister429)) * int64_t(int32_t(4))); // PTX L808
	g_ResidualByteAddressAtPtx809 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register54);			   // PTX L809
	r_PtxRegister2703 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx809); // PTX L810
L__BB18_80:																				   // PTX L811
	r_bPtxPredicate183 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L812
	r_bPtxPredicate184 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L813
	r_bPtxPredicate185 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L814
	r_LaneIndexAtPtx816 = uint32_t((threadIdx.x & 31u));								   // PTX L816
	r_PtxRegister431 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx816), uint32_t(31));	   // PTX L818
	r_PtxRegister432 = ShiftRight(uint32_t(r_PtxRegister431), uint32_t(30));			   // PTX L819
	r_PtxRegister433 = uint32_t(r_LaneIndexAtPtx816) + uint32_t(r_PtxRegister432);		   // PTX L820
	r_PtxRegister434 = ShiftRightSigned(int32_t(r_PtxRegister433), uint32_t(2));		   // PTX L821
	r_PtxRegister435 = ShiftRight(uint32_t(r_PtxRegister434), uint32_t(30));			   // PTX L822
	r_PtxRegister436 = uint32_t(r_PtxRegister434) + uint32_t(r_PtxRegister435);			   // PTX L823
	r_PtxRegister437 = r_PtxRegister436 & -4;											   // PTX L824
	r_PtxRegister438 = uint32_t(r_PtxRegister434) - uint32_t(r_PtxRegister437);			   // PTX L825
	r_PtxRegister439 = ShiftRight(uint32_t(r_PtxRegister431), uint32_t(28));			   // PTX L826
	r_PtxRegister440 = uint32_t(r_LaneIndexAtPtx816) + uint32_t(r_PtxRegister439);		   // PTX L827
	r_PtxRegister441 = ShiftRightSigned(int32_t(r_PtxRegister440), uint32_t(4));		   // PTX L828
	r_PtxRegister442 = uint32_t(r_PtxRegister441) + uint32_t(r_PtxRegister4);			   // PTX L829
	r_PtxRegister443 = uint32_t(r_PtxRegister442) + uint32_t(2);						   // PTX L830
	r_PtxRegister39 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister438);			   // PTX L831
	r_bPtxPredicate186 = int32_t(r_PtxRegister443) < int32_t(0);						   // PTX L832
	r_bPtxPredicate187 = int32_t(r_PtxRegister443) >= int32_t(r_HeightBits);			   // PTX L833
	r_bPtxPredicate188 = r_bPtxPredicate186 | r_bPtxPredicate187;						   // PTX L834
	r_bPtxPredicate189 = !r_bPtxPredicate188;											   // PTX L835
	r_PtxRegister40 = r_bPtxPredicate185 ? 0 : r_PtxRegister443;						   // PTX L836
	r_bPtxPredicate190 = r_bPtxPredicate184 & r_bPtxPredicate188;						   // PTX L837
	r_bPtxPredicate191 = r_bPtxPredicate185 | r_bPtxPredicate189;						   // PTX L838
	r_bPtxPredicate192 = r_bPtxPredicate190 | r_bPtxPredicate183;						   // PTX L839
	r_bPtxPredicate193 = int32_t(r_PtxRegister39) > int32_t(-1);						   // PTX L840
	r_bPtxPredicate194 = int32_t(r_PtxRegister39) < int32_t(r_WidthBits);				   // PTX L841
	r_bPtxPredicate195 = r_bPtxPredicate193 & r_bPtxPredicate194;						   // PTX L842
	r_bPtxPredicate196 = !r_bPtxPredicate190;											   // PTX L843
	r_bPtxPredicate8 = r_bPtxPredicate183 & r_bPtxPredicate196;							   // PTX L844
	r_bPtxPredicate197 = r_bPtxPredicate192 | r_bPtxPredicate195;						   // PTX L845
	r_bPtxPredicate198 = r_bPtxPredicate197 & r_bPtxPredicate191;						   // PTX L846
	r_PtxRegister2704 = uint32_t(0);													   // PTX L847
	r_bPtxPredicate199 = !r_bPtxPredicate198;											   // PTX L848
	if (r_bPtxPredicate199)
	{
		goto L__BB18_82;
	} // PTX L849
	r_PtxRegister444 = r_PtxRegister433 & -4;									   // PTX L850
	r_PtxRegister445 = uint32_t(r_LaneIndexAtPtx816) - uint32_t(r_PtxRegister444); // PTX L851
	r_PtxRegister446 = ShiftLeft(uint32_t(r_PtxRegister39), uint32_t(2));		   // PTX L852
	r_PtxRegister447 = r_bPtxPredicate8 ? 0 : r_PtxRegister446;					   // PTX L853
	r_PtxRegister448 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister40); // PTX L854
	r_PtxRegister449 =
		uint32_t(r_PtxRegister448) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister445); // PTX L855
	r_PtxRegister450 = uint32_t(r_PtxRegister449) + uint32_t(r_PtxRegister447);				 // PTX L856
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_PtxRegister450)) * int64_t(int32_t(4))); // PTX L857
	g_ResidualByteAddressAtPtx858 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register56);			   // PTX L858
	r_PtxRegister2704 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx858); // PTX L859
L__BB18_82:																				   // PTX L860
	r_bPtxPredicate200 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L861
	r_bPtxPredicate201 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L862
	r_bPtxPredicate202 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L863
	r_LaneIndexAtPtx865 = uint32_t((threadIdx.x & 31u));								   // PTX L865
	r_PtxRegister452 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx865), uint32_t(31));	   // PTX L867
	r_PtxRegister453 = ShiftRight(uint32_t(r_PtxRegister452), uint32_t(30));			   // PTX L868
	r_PtxRegister454 = uint32_t(r_LaneIndexAtPtx865) + uint32_t(r_PtxRegister453);		   // PTX L869
	r_PtxRegister455 = ShiftRightSigned(int32_t(r_PtxRegister454), uint32_t(2));		   // PTX L870
	r_PtxRegister456 = ShiftRight(uint32_t(r_PtxRegister455), uint32_t(30));			   // PTX L871
	r_PtxRegister457 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister456);			   // PTX L872
	r_PtxRegister458 = r_PtxRegister457 & -4;											   // PTX L873
	r_PtxRegister459 = uint32_t(r_PtxRegister455) - uint32_t(r_PtxRegister458);			   // PTX L874
	r_PtxRegister460 = ShiftRight(uint32_t(r_PtxRegister452), uint32_t(28));			   // PTX L875
	r_PtxRegister461 = uint32_t(r_LaneIndexAtPtx865) + uint32_t(r_PtxRegister460);		   // PTX L876
	r_PtxRegister462 = ShiftRightSigned(int32_t(r_PtxRegister461), uint32_t(4));		   // PTX L877
	r_PtxRegister41 = uint32_t(r_PtxRegister26) + uint32_t(3);							   // PTX L878
	r_PtxRegister463 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister462);			   // PTX L879
	r_PtxRegister42 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister459);			   // PTX L880
	r_bPtxPredicate203 = int32_t(r_PtxRegister463) < int32_t(0);						   // PTX L881
	r_bPtxPredicate204 = int32_t(r_PtxRegister463) >= int32_t(r_HeightBits);			   // PTX L882
	r_bPtxPredicate205 = r_bPtxPredicate203 | r_bPtxPredicate204;						   // PTX L883
	r_bPtxPredicate206 = !r_bPtxPredicate205;											   // PTX L884
	r_PtxRegister43 = r_bPtxPredicate202 ? 0 : r_PtxRegister463;						   // PTX L885
	r_bPtxPredicate207 = r_bPtxPredicate201 & r_bPtxPredicate205;						   // PTX L886
	r_bPtxPredicate208 = r_bPtxPredicate202 | r_bPtxPredicate206;						   // PTX L887
	r_bPtxPredicate209 = r_bPtxPredicate207 | r_bPtxPredicate200;						   // PTX L888
	r_bPtxPredicate210 = int32_t(r_PtxRegister42) > int32_t(-1);						   // PTX L889
	r_bPtxPredicate211 = int32_t(r_PtxRegister42) < int32_t(r_WidthBits);				   // PTX L890
	r_bPtxPredicate212 = r_bPtxPredicate210 & r_bPtxPredicate211;						   // PTX L891
	r_bPtxPredicate213 = !r_bPtxPredicate207;											   // PTX L892
	r_bPtxPredicate9 = r_bPtxPredicate200 & r_bPtxPredicate213;							   // PTX L893
	r_bPtxPredicate214 = r_bPtxPredicate209 | r_bPtxPredicate212;						   // PTX L894
	r_bPtxPredicate215 = r_bPtxPredicate214 & r_bPtxPredicate208;						   // PTX L895
	r_PtxRegister2705 = uint32_t(0);													   // PTX L896
	r_bPtxPredicate216 = !r_bPtxPredicate215;											   // PTX L897
	if (r_bPtxPredicate216)
	{
		goto L__BB18_84;
	} // PTX L898
	r_PtxRegister464 = r_PtxRegister454 & -4;									   // PTX L899
	r_PtxRegister465 = uint32_t(r_LaneIndexAtPtx865) - uint32_t(r_PtxRegister464); // PTX L900
	r_PtxRegister466 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(2));		   // PTX L901
	r_PtxRegister467 = r_bPtxPredicate9 ? 0 : r_PtxRegister466;					   // PTX L902
	r_PtxRegister468 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister43); // PTX L903
	r_PtxRegister469 =
		uint32_t(r_PtxRegister468) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister465); // PTX L904
	r_PtxRegister470 = uint32_t(r_PtxRegister469) + uint32_t(r_PtxRegister467);				 // PTX L905
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister470)) * int64_t(int32_t(4))); // PTX L906
	g_ResidualByteAddressAtPtx907 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register58);			   // PTX L907
	r_PtxRegister2705 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx907); // PTX L908
L__BB18_84:																				   // PTX L909
	r_bPtxPredicate217 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L910
	r_bPtxPredicate218 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L911
	r_bPtxPredicate219 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L912
	r_LaneIndexAtPtx914 = uint32_t((threadIdx.x & 31u));								   // PTX L914
	r_PtxRegister472 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx914), uint32_t(31));	   // PTX L916
	r_PtxRegister473 = ShiftRight(uint32_t(r_PtxRegister472), uint32_t(30));			   // PTX L917
	r_PtxRegister474 = uint32_t(r_LaneIndexAtPtx914) + uint32_t(r_PtxRegister473);		   // PTX L918
	r_PtxRegister475 = ShiftRightSigned(int32_t(r_PtxRegister474), uint32_t(2));		   // PTX L919
	r_PtxRegister476 = ShiftRight(uint32_t(r_PtxRegister475), uint32_t(30));			   // PTX L920
	r_PtxRegister477 = uint32_t(r_PtxRegister475) + uint32_t(r_PtxRegister476);			   // PTX L921
	r_PtxRegister478 = r_PtxRegister477 & -4;											   // PTX L922
	r_PtxRegister479 = uint32_t(r_PtxRegister475) - uint32_t(r_PtxRegister478);			   // PTX L923
	r_PtxRegister480 = ShiftRight(uint32_t(r_PtxRegister472), uint32_t(28));			   // PTX L924
	r_PtxRegister481 = uint32_t(r_LaneIndexAtPtx914) + uint32_t(r_PtxRegister480);		   // PTX L925
	r_PtxRegister482 = ShiftRightSigned(int32_t(r_PtxRegister481), uint32_t(4));		   // PTX L926
	r_PtxRegister483 = uint32_t(r_PtxRegister482) + uint32_t(r_PtxRegister4);			   // PTX L927
	r_PtxRegister484 = uint32_t(r_PtxRegister483) + uint32_t(2);						   // PTX L928
	r_PtxRegister44 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister479);			   // PTX L929
	r_bPtxPredicate220 = int32_t(r_PtxRegister484) < int32_t(0);						   // PTX L930
	r_bPtxPredicate221 = int32_t(r_PtxRegister484) >= int32_t(r_HeightBits);			   // PTX L931
	r_bPtxPredicate222 = r_bPtxPredicate220 | r_bPtxPredicate221;						   // PTX L932
	r_bPtxPredicate223 = !r_bPtxPredicate222;											   // PTX L933
	r_PtxRegister45 = r_bPtxPredicate219 ? 0 : r_PtxRegister484;						   // PTX L934
	r_bPtxPredicate224 = r_bPtxPredicate218 & r_bPtxPredicate222;						   // PTX L935
	r_bPtxPredicate225 = r_bPtxPredicate219 | r_bPtxPredicate223;						   // PTX L936
	r_bPtxPredicate226 = r_bPtxPredicate224 | r_bPtxPredicate217;						   // PTX L937
	r_bPtxPredicate227 = int32_t(r_PtxRegister44) > int32_t(-1);						   // PTX L938
	r_bPtxPredicate228 = int32_t(r_PtxRegister44) < int32_t(r_WidthBits);				   // PTX L939
	r_bPtxPredicate229 = r_bPtxPredicate227 & r_bPtxPredicate228;						   // PTX L940
	r_bPtxPredicate230 = !r_bPtxPredicate224;											   // PTX L941
	r_bPtxPredicate10 = r_bPtxPredicate217 & r_bPtxPredicate230;						   // PTX L942
	r_bPtxPredicate231 = r_bPtxPredicate226 | r_bPtxPredicate229;						   // PTX L943
	r_bPtxPredicate232 = r_bPtxPredicate231 & r_bPtxPredicate225;						   // PTX L944
	r_PtxRegister2706 = uint32_t(0);													   // PTX L945
	r_bPtxPredicate233 = !r_bPtxPredicate232;											   // PTX L946
	if (r_bPtxPredicate233)
	{
		goto L__BB18_86;
	} // PTX L947
	r_PtxRegister485 = r_PtxRegister474 & -4;									   // PTX L948
	r_PtxRegister486 = uint32_t(r_LaneIndexAtPtx914) - uint32_t(r_PtxRegister485); // PTX L949
	r_PtxRegister487 = ShiftLeft(uint32_t(r_PtxRegister44), uint32_t(2));		   // PTX L950
	r_PtxRegister488 = r_bPtxPredicate10 ? 0 : r_PtxRegister487;				   // PTX L951
	r_PtxRegister489 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister45); // PTX L952
	r_PtxRegister490 =
		uint32_t(r_PtxRegister489) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister486); // PTX L953
	r_PtxRegister491 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister488);				 // PTX L954
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_PtxRegister491)) * int64_t(int32_t(4))); // PTX L955
	g_ResidualByteAddressAtPtx956 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register60);			   // PTX L956
	r_PtxRegister2706 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx956); // PTX L957
L__BB18_86:																				   // PTX L958
	r_bPtxPredicate234 = uint32_t(r_WidthBits) == uint32_t(1);							   // PTX L959
	r_bPtxPredicate235 = uint32_t(r_HeightBits) != uint32_t(1);							   // PTX L960
	r_bPtxPredicate236 = uint32_t(r_HeightBits) == uint32_t(1);							   // PTX L961
	r_LaneIndexAtPtx963 = uint32_t((threadIdx.x & 31u));								   // PTX L963
	r_PtxRegister493 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx963), uint32_t(31));	   // PTX L965
	r_PtxRegister494 = ShiftRight(uint32_t(r_PtxRegister493), uint32_t(30));			   // PTX L966
	r_PtxRegister495 = uint32_t(r_LaneIndexAtPtx963) + uint32_t(r_PtxRegister494);		   // PTX L967
	r_PtxRegister496 = ShiftRightSigned(int32_t(r_PtxRegister495), uint32_t(2));		   // PTX L968
	r_PtxRegister497 = ShiftRight(uint32_t(r_PtxRegister496), uint32_t(30));			   // PTX L969
	r_PtxRegister498 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister497);			   // PTX L970
	r_PtxRegister499 = r_PtxRegister498 & -4;											   // PTX L971
	r_PtxRegister500 = uint32_t(r_PtxRegister496) - uint32_t(r_PtxRegister499);			   // PTX L972
	r_PtxRegister501 = ShiftRight(uint32_t(r_PtxRegister493), uint32_t(28));			   // PTX L973
	r_PtxRegister502 = uint32_t(r_LaneIndexAtPtx963) + uint32_t(r_PtxRegister501);		   // PTX L974
	r_PtxRegister503 = ShiftRightSigned(int32_t(r_PtxRegister502), uint32_t(4));		   // PTX L975
	r_PtxRegister46 = uint32_t(r_PtxRegister26) + uint32_t(4);							   // PTX L976
	r_PtxRegister504 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister503);			   // PTX L977
	r_PtxRegister47 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister500);			   // PTX L978
	r_bPtxPredicate237 = int32_t(r_PtxRegister504) < int32_t(0);						   // PTX L979
	r_bPtxPredicate238 = int32_t(r_PtxRegister504) >= int32_t(r_HeightBits);			   // PTX L980
	r_bPtxPredicate239 = r_bPtxPredicate237 | r_bPtxPredicate238;						   // PTX L981
	r_bPtxPredicate240 = !r_bPtxPredicate239;											   // PTX L982
	r_PtxRegister48 = r_bPtxPredicate236 ? 0 : r_PtxRegister504;						   // PTX L983
	r_bPtxPredicate241 = r_bPtxPredicate235 & r_bPtxPredicate239;						   // PTX L984
	r_bPtxPredicate242 = r_bPtxPredicate236 | r_bPtxPredicate240;						   // PTX L985
	r_bPtxPredicate243 = r_bPtxPredicate241 | r_bPtxPredicate234;						   // PTX L986
	r_bPtxPredicate244 = int32_t(r_PtxRegister47) > int32_t(-1);						   // PTX L987
	r_bPtxPredicate245 = int32_t(r_PtxRegister47) < int32_t(r_WidthBits);				   // PTX L988
	r_bPtxPredicate246 = r_bPtxPredicate244 & r_bPtxPredicate245;						   // PTX L989
	r_bPtxPredicate247 = !r_bPtxPredicate241;											   // PTX L990
	r_bPtxPredicate11 = r_bPtxPredicate234 & r_bPtxPredicate247;						   // PTX L991
	r_bPtxPredicate248 = r_bPtxPredicate243 | r_bPtxPredicate246;						   // PTX L992
	r_bPtxPredicate249 = r_bPtxPredicate248 & r_bPtxPredicate242;						   // PTX L993
	r_PtxRegister2707 = uint32_t(0);													   // PTX L994
	r_bPtxPredicate250 = !r_bPtxPredicate249;											   // PTX L995
	if (r_bPtxPredicate250)
	{
		goto L__BB18_88;
	} // PTX L996
	r_PtxRegister505 = r_PtxRegister495 & -4;									   // PTX L997
	r_PtxRegister506 = uint32_t(r_LaneIndexAtPtx963) - uint32_t(r_PtxRegister505); // PTX L998
	r_PtxRegister507 = ShiftLeft(uint32_t(r_PtxRegister47), uint32_t(2));		   // PTX L999
	r_PtxRegister508 = r_bPtxPredicate11 ? 0 : r_PtxRegister507;				   // PTX L1000
	r_PtxRegister509 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister48); // PTX L1001
	r_PtxRegister510 =
		uint32_t(r_PtxRegister509) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister506); // PTX L1002
	r_PtxRegister511 = uint32_t(r_PtxRegister510) + uint32_t(r_PtxRegister508);				 // PTX L1003
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister511)) * int64_t(int32_t(4))); // PTX L1004
	g_ResidualByteAddressAtPtx1005 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register62);				// PTX L1005
	r_PtxRegister2707 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1005); // PTX L1006
L__BB18_88:																					// PTX L1007
	r_bPtxPredicate251 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1008
	r_bPtxPredicate252 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1009
	r_bPtxPredicate253 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1010
	r_LaneIndexAtPtx1012 = uint32_t((threadIdx.x & 31u));									// PTX L1012
	r_PtxRegister513 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1012), uint32_t(31));		// PTX L1014
	r_PtxRegister514 = ShiftRight(uint32_t(r_PtxRegister513), uint32_t(30));				// PTX L1015
	r_PtxRegister515 = uint32_t(r_LaneIndexAtPtx1012) + uint32_t(r_PtxRegister514);			// PTX L1016
	r_PtxRegister516 = ShiftRightSigned(int32_t(r_PtxRegister515), uint32_t(2));			// PTX L1017
	r_PtxRegister517 = ShiftRight(uint32_t(r_PtxRegister516), uint32_t(30));				// PTX L1018
	r_PtxRegister518 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister517);				// PTX L1019
	r_PtxRegister519 = r_PtxRegister518 & -4;												// PTX L1020
	r_PtxRegister520 = uint32_t(r_PtxRegister516) - uint32_t(r_PtxRegister519);				// PTX L1021
	r_PtxRegister521 = ShiftRight(uint32_t(r_PtxRegister513), uint32_t(28));				// PTX L1022
	r_PtxRegister522 = uint32_t(r_LaneIndexAtPtx1012) + uint32_t(r_PtxRegister521);			// PTX L1023
	r_PtxRegister523 = ShiftRightSigned(int32_t(r_PtxRegister522), uint32_t(4));			// PTX L1024
	r_PtxRegister524 = uint32_t(r_PtxRegister523) + uint32_t(r_PtxRegister4);				// PTX L1025
	r_PtxRegister525 = uint32_t(r_PtxRegister524) + uint32_t(2);							// PTX L1026
	r_PtxRegister49 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister520);				// PTX L1027
	r_bPtxPredicate254 = int32_t(r_PtxRegister525) < int32_t(0);							// PTX L1028
	r_bPtxPredicate255 = int32_t(r_PtxRegister525) >= int32_t(r_HeightBits);				// PTX L1029
	r_bPtxPredicate256 = r_bPtxPredicate254 | r_bPtxPredicate255;							// PTX L1030
	r_bPtxPredicate257 = !r_bPtxPredicate256;												// PTX L1031
	r_PtxRegister50 = r_bPtxPredicate253 ? 0 : r_PtxRegister525;							// PTX L1032
	r_bPtxPredicate258 = r_bPtxPredicate252 & r_bPtxPredicate256;							// PTX L1033
	r_bPtxPredicate259 = r_bPtxPredicate253 | r_bPtxPredicate257;							// PTX L1034
	r_bPtxPredicate260 = r_bPtxPredicate258 | r_bPtxPredicate251;							// PTX L1035
	r_bPtxPredicate261 = int32_t(r_PtxRegister49) > int32_t(-1);							// PTX L1036
	r_bPtxPredicate262 = int32_t(r_PtxRegister49) < int32_t(r_WidthBits);					// PTX L1037
	r_bPtxPredicate263 = r_bPtxPredicate261 & r_bPtxPredicate262;							// PTX L1038
	r_bPtxPredicate264 = !r_bPtxPredicate258;												// PTX L1039
	r_bPtxPredicate12 = r_bPtxPredicate251 & r_bPtxPredicate264;							// PTX L1040
	r_bPtxPredicate265 = r_bPtxPredicate260 | r_bPtxPredicate263;							// PTX L1041
	r_bPtxPredicate266 = r_bPtxPredicate265 & r_bPtxPredicate259;							// PTX L1042
	r_PtxRegister2708 = uint32_t(0);														// PTX L1043
	r_bPtxPredicate267 = !r_bPtxPredicate266;												// PTX L1044
	if (r_bPtxPredicate267)
	{
		goto L__BB18_90;
	} // PTX L1045
	r_PtxRegister526 = r_PtxRegister515 & -4;										// PTX L1046
	r_PtxRegister527 = uint32_t(r_LaneIndexAtPtx1012) - uint32_t(r_PtxRegister526); // PTX L1047
	r_PtxRegister528 = ShiftLeft(uint32_t(r_PtxRegister49), uint32_t(2));			// PTX L1048
	r_PtxRegister529 = r_bPtxPredicate12 ? 0 : r_PtxRegister528;					// PTX L1049
	r_PtxRegister530 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister50); // PTX L1050
	r_PtxRegister531 =
		uint32_t(r_PtxRegister530) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister527); // PTX L1051
	r_PtxRegister532 = uint32_t(r_PtxRegister531) + uint32_t(r_PtxRegister529);				 // PTX L1052
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_PtxRegister532)) * int64_t(int32_t(4))); // PTX L1053
	g_ResidualByteAddressAtPtx1054 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register64);				// PTX L1054
	r_PtxRegister2708 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1054); // PTX L1055
L__BB18_90:																					// PTX L1056
	r_bPtxPredicate268 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1057
	r_bPtxPredicate269 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1058
	r_bPtxPredicate270 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1059
	r_LaneIndexAtPtx1061 = uint32_t((threadIdx.x & 31u));									// PTX L1061
	r_PtxRegister534 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1061), uint32_t(31));		// PTX L1063
	r_PtxRegister535 = ShiftRight(uint32_t(r_PtxRegister534), uint32_t(30));				// PTX L1064
	r_PtxRegister536 = uint32_t(r_LaneIndexAtPtx1061) + uint32_t(r_PtxRegister535);			// PTX L1065
	r_PtxRegister537 = ShiftRightSigned(int32_t(r_PtxRegister536), uint32_t(2));			// PTX L1066
	r_PtxRegister538 = ShiftRight(uint32_t(r_PtxRegister537), uint32_t(30));				// PTX L1067
	r_PtxRegister539 = uint32_t(r_PtxRegister537) + uint32_t(r_PtxRegister538);				// PTX L1068
	r_PtxRegister540 = r_PtxRegister539 & -4;												// PTX L1069
	r_PtxRegister541 = uint32_t(r_PtxRegister537) - uint32_t(r_PtxRegister540);				// PTX L1070
	r_PtxRegister542 = ShiftRight(uint32_t(r_PtxRegister534), uint32_t(28));				// PTX L1071
	r_PtxRegister543 = uint32_t(r_LaneIndexAtPtx1061) + uint32_t(r_PtxRegister542);			// PTX L1072
	r_PtxRegister544 = ShiftRightSigned(int32_t(r_PtxRegister543), uint32_t(4));			// PTX L1073
	r_PtxRegister51 = uint32_t(r_PtxRegister26) + uint32_t(5);								// PTX L1074
	r_PtxRegister545 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister544);				// PTX L1075
	r_PtxRegister52 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister541);				// PTX L1076
	r_bPtxPredicate271 = int32_t(r_PtxRegister545) < int32_t(0);							// PTX L1077
	r_bPtxPredicate272 = int32_t(r_PtxRegister545) >= int32_t(r_HeightBits);				// PTX L1078
	r_bPtxPredicate273 = r_bPtxPredicate271 | r_bPtxPredicate272;							// PTX L1079
	r_bPtxPredicate274 = !r_bPtxPredicate273;												// PTX L1080
	r_PtxRegister53 = r_bPtxPredicate270 ? 0 : r_PtxRegister545;							// PTX L1081
	r_bPtxPredicate275 = r_bPtxPredicate269 & r_bPtxPredicate273;							// PTX L1082
	r_bPtxPredicate276 = r_bPtxPredicate270 | r_bPtxPredicate274;							// PTX L1083
	r_bPtxPredicate277 = r_bPtxPredicate275 | r_bPtxPredicate268;							// PTX L1084
	r_bPtxPredicate278 = int32_t(r_PtxRegister52) > int32_t(-1);							// PTX L1085
	r_bPtxPredicate279 = int32_t(r_PtxRegister52) < int32_t(r_WidthBits);					// PTX L1086
	r_bPtxPredicate280 = r_bPtxPredicate278 & r_bPtxPredicate279;							// PTX L1087
	r_bPtxPredicate281 = !r_bPtxPredicate275;												// PTX L1088
	r_bPtxPredicate13 = r_bPtxPredicate268 & r_bPtxPredicate281;							// PTX L1089
	r_bPtxPredicate282 = r_bPtxPredicate277 | r_bPtxPredicate280;							// PTX L1090
	r_bPtxPredicate283 = r_bPtxPredicate282 & r_bPtxPredicate276;							// PTX L1091
	r_PtxRegister2709 = uint32_t(0);														// PTX L1092
	r_bPtxPredicate284 = !r_bPtxPredicate283;												// PTX L1093
	if (r_bPtxPredicate284)
	{
		goto L__BB18_92;
	} // PTX L1094
	r_PtxRegister546 = r_PtxRegister536 & -4;										// PTX L1095
	r_PtxRegister547 = uint32_t(r_LaneIndexAtPtx1061) - uint32_t(r_PtxRegister546); // PTX L1096
	r_PtxRegister548 = ShiftLeft(uint32_t(r_PtxRegister52), uint32_t(2));			// PTX L1097
	r_PtxRegister549 = r_bPtxPredicate13 ? 0 : r_PtxRegister548;					// PTX L1098
	r_PtxRegister550 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister53); // PTX L1099
	r_PtxRegister551 =
		uint32_t(r_PtxRegister550) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister547); // PTX L1100
	r_PtxRegister552 = uint32_t(r_PtxRegister551) + uint32_t(r_PtxRegister549);				 // PTX L1101
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister552)) * int64_t(int32_t(4))); // PTX L1102
	g_ResidualByteAddressAtPtx1103 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register66);				// PTX L1103
	r_PtxRegister2709 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1103); // PTX L1104
L__BB18_92:																					// PTX L1105
	r_bPtxPredicate285 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1106
	r_bPtxPredicate286 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1107
	r_bPtxPredicate287 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1108
	r_LaneIndexAtPtx1110 = uint32_t((threadIdx.x & 31u));									// PTX L1110
	r_PtxRegister554 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1110), uint32_t(31));		// PTX L1112
	r_PtxRegister555 = ShiftRight(uint32_t(r_PtxRegister554), uint32_t(30));				// PTX L1113
	r_PtxRegister556 = uint32_t(r_LaneIndexAtPtx1110) + uint32_t(r_PtxRegister555);			// PTX L1114
	r_PtxRegister557 = ShiftRightSigned(int32_t(r_PtxRegister556), uint32_t(2));			// PTX L1115
	r_PtxRegister558 = ShiftRight(uint32_t(r_PtxRegister557), uint32_t(30));				// PTX L1116
	r_PtxRegister559 = uint32_t(r_PtxRegister557) + uint32_t(r_PtxRegister558);				// PTX L1117
	r_PtxRegister560 = r_PtxRegister559 & -4;												// PTX L1118
	r_PtxRegister561 = uint32_t(r_PtxRegister557) - uint32_t(r_PtxRegister560);				// PTX L1119
	r_PtxRegister562 = ShiftRight(uint32_t(r_PtxRegister554), uint32_t(28));				// PTX L1120
	r_PtxRegister563 = uint32_t(r_LaneIndexAtPtx1110) + uint32_t(r_PtxRegister562);			// PTX L1121
	r_PtxRegister564 = ShiftRightSigned(int32_t(r_PtxRegister563), uint32_t(4));			// PTX L1122
	r_PtxRegister565 = uint32_t(r_PtxRegister564) + uint32_t(r_PtxRegister4);				// PTX L1123
	r_PtxRegister566 = uint32_t(r_PtxRegister565) + uint32_t(2);							// PTX L1124
	r_PtxRegister54 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister561);				// PTX L1125
	r_bPtxPredicate288 = int32_t(r_PtxRegister566) < int32_t(0);							// PTX L1126
	r_bPtxPredicate289 = int32_t(r_PtxRegister566) >= int32_t(r_HeightBits);				// PTX L1127
	r_bPtxPredicate290 = r_bPtxPredicate288 | r_bPtxPredicate289;							// PTX L1128
	r_bPtxPredicate291 = !r_bPtxPredicate290;												// PTX L1129
	r_PtxRegister55 = r_bPtxPredicate287 ? 0 : r_PtxRegister566;							// PTX L1130
	r_bPtxPredicate292 = r_bPtxPredicate286 & r_bPtxPredicate290;							// PTX L1131
	r_bPtxPredicate293 = r_bPtxPredicate287 | r_bPtxPredicate291;							// PTX L1132
	r_bPtxPredicate294 = r_bPtxPredicate292 | r_bPtxPredicate285;							// PTX L1133
	r_bPtxPredicate295 = int32_t(r_PtxRegister54) > int32_t(-1);							// PTX L1134
	r_bPtxPredicate296 = int32_t(r_PtxRegister54) < int32_t(r_WidthBits);					// PTX L1135
	r_bPtxPredicate297 = r_bPtxPredicate295 & r_bPtxPredicate296;							// PTX L1136
	r_bPtxPredicate298 = !r_bPtxPredicate292;												// PTX L1137
	r_bPtxPredicate14 = r_bPtxPredicate285 & r_bPtxPredicate298;							// PTX L1138
	r_bPtxPredicate299 = r_bPtxPredicate294 | r_bPtxPredicate297;							// PTX L1139
	r_bPtxPredicate300 = r_bPtxPredicate299 & r_bPtxPredicate293;							// PTX L1140
	r_PtxRegister2710 = uint32_t(0);														// PTX L1141
	r_bPtxPredicate301 = !r_bPtxPredicate300;												// PTX L1142
	if (r_bPtxPredicate301)
	{
		goto L__BB18_94;
	} // PTX L1143
	r_PtxRegister567 = r_PtxRegister556 & -4;										// PTX L1144
	r_PtxRegister568 = uint32_t(r_LaneIndexAtPtx1110) - uint32_t(r_PtxRegister567); // PTX L1145
	r_PtxRegister569 = ShiftLeft(uint32_t(r_PtxRegister54), uint32_t(2));			// PTX L1146
	r_PtxRegister570 = r_bPtxPredicate14 ? 0 : r_PtxRegister569;					// PTX L1147
	r_PtxRegister571 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister55); // PTX L1148
	r_PtxRegister572 =
		uint32_t(r_PtxRegister571) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister568); // PTX L1149
	r_PtxRegister573 = uint32_t(r_PtxRegister572) + uint32_t(r_PtxRegister570);				 // PTX L1150
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_PtxRegister573)) * int64_t(int32_t(4))); // PTX L1151
	g_ResidualByteAddressAtPtx1152 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register68);				// PTX L1152
	r_PtxRegister2710 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1152); // PTX L1153
L__BB18_94:																					// PTX L1154
	r_bPtxPredicate302 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1155
	r_bPtxPredicate303 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1156
	r_bPtxPredicate304 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1157
	r_LaneIndexAtPtx1159 = uint32_t((threadIdx.x & 31u));									// PTX L1159
	r_PtxRegister575 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1159), uint32_t(31));		// PTX L1161
	r_PtxRegister576 = ShiftRight(uint32_t(r_PtxRegister575), uint32_t(30));				// PTX L1162
	r_PtxRegister577 = uint32_t(r_LaneIndexAtPtx1159) + uint32_t(r_PtxRegister576);			// PTX L1163
	r_PtxRegister578 = ShiftRightSigned(int32_t(r_PtxRegister577), uint32_t(2));			// PTX L1164
	r_PtxRegister579 = ShiftRight(uint32_t(r_PtxRegister578), uint32_t(30));				// PTX L1165
	r_PtxRegister580 = uint32_t(r_PtxRegister578) + uint32_t(r_PtxRegister579);				// PTX L1166
	r_PtxRegister581 = r_PtxRegister580 & -4;												// PTX L1167
	r_PtxRegister582 = uint32_t(r_PtxRegister578) - uint32_t(r_PtxRegister581);				// PTX L1168
	r_PtxRegister583 = ShiftRight(uint32_t(r_PtxRegister575), uint32_t(28));				// PTX L1169
	r_PtxRegister584 = uint32_t(r_LaneIndexAtPtx1159) + uint32_t(r_PtxRegister583);			// PTX L1170
	r_PtxRegister585 = ShiftRightSigned(int32_t(r_PtxRegister584), uint32_t(4));			// PTX L1171
	r_PtxRegister56 = uint32_t(r_PtxRegister26) + uint32_t(6);								// PTX L1172
	r_PtxRegister586 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister585);				// PTX L1173
	r_PtxRegister57 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister582);				// PTX L1174
	r_bPtxPredicate305 = int32_t(r_PtxRegister586) < int32_t(0);							// PTX L1175
	r_bPtxPredicate306 = int32_t(r_PtxRegister586) >= int32_t(r_HeightBits);				// PTX L1176
	r_bPtxPredicate307 = r_bPtxPredicate305 | r_bPtxPredicate306;							// PTX L1177
	r_bPtxPredicate308 = !r_bPtxPredicate307;												// PTX L1178
	r_PtxRegister58 = r_bPtxPredicate304 ? 0 : r_PtxRegister586;							// PTX L1179
	r_bPtxPredicate309 = r_bPtxPredicate303 & r_bPtxPredicate307;							// PTX L1180
	r_bPtxPredicate310 = r_bPtxPredicate304 | r_bPtxPredicate308;							// PTX L1181
	r_bPtxPredicate311 = r_bPtxPredicate309 | r_bPtxPredicate302;							// PTX L1182
	r_bPtxPredicate312 = int32_t(r_PtxRegister57) > int32_t(-1);							// PTX L1183
	r_bPtxPredicate313 = int32_t(r_PtxRegister57) < int32_t(r_WidthBits);					// PTX L1184
	r_bPtxPredicate314 = r_bPtxPredicate312 & r_bPtxPredicate313;							// PTX L1185
	r_bPtxPredicate315 = !r_bPtxPredicate309;												// PTX L1186
	r_bPtxPredicate15 = r_bPtxPredicate302 & r_bPtxPredicate315;							// PTX L1187
	r_bPtxPredicate316 = r_bPtxPredicate311 | r_bPtxPredicate314;							// PTX L1188
	r_bPtxPredicate317 = r_bPtxPredicate316 & r_bPtxPredicate310;							// PTX L1189
	r_PtxRegister2711 = uint32_t(0);														// PTX L1190
	r_bPtxPredicate318 = !r_bPtxPredicate317;												// PTX L1191
	if (r_bPtxPredicate318)
	{
		goto L__BB18_96;
	} // PTX L1192
	r_PtxRegister587 = r_PtxRegister577 & -4;										// PTX L1193
	r_PtxRegister588 = uint32_t(r_LaneIndexAtPtx1159) - uint32_t(r_PtxRegister587); // PTX L1194
	r_PtxRegister589 = ShiftLeft(uint32_t(r_PtxRegister57), uint32_t(2));			// PTX L1195
	r_PtxRegister590 = r_bPtxPredicate15 ? 0 : r_PtxRegister589;					// PTX L1196
	r_PtxRegister591 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister58); // PTX L1197
	r_PtxRegister592 =
		uint32_t(r_PtxRegister591) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister588); // PTX L1198
	r_PtxRegister593 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister590);				 // PTX L1199
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister593)) * int64_t(int32_t(4))); // PTX L1200
	g_ResidualByteAddressAtPtx1201 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register70);				// PTX L1201
	r_PtxRegister2711 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1201); // PTX L1202
L__BB18_96:																					// PTX L1203
	r_bPtxPredicate319 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1204
	r_bPtxPredicate320 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1205
	r_bPtxPredicate321 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1206
	r_LaneIndexAtPtx1208 = uint32_t((threadIdx.x & 31u));									// PTX L1208
	r_PtxRegister595 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1208), uint32_t(31));		// PTX L1210
	r_PtxRegister596 = ShiftRight(uint32_t(r_PtxRegister595), uint32_t(30));				// PTX L1211
	r_PtxRegister597 = uint32_t(r_LaneIndexAtPtx1208) + uint32_t(r_PtxRegister596);			// PTX L1212
	r_PtxRegister598 = ShiftRightSigned(int32_t(r_PtxRegister597), uint32_t(2));			// PTX L1213
	r_PtxRegister599 = ShiftRight(uint32_t(r_PtxRegister598), uint32_t(30));				// PTX L1214
	r_PtxRegister600 = uint32_t(r_PtxRegister598) + uint32_t(r_PtxRegister599);				// PTX L1215
	r_PtxRegister601 = r_PtxRegister600 & -4;												// PTX L1216
	r_PtxRegister602 = uint32_t(r_PtxRegister598) - uint32_t(r_PtxRegister601);				// PTX L1217
	r_PtxRegister603 = ShiftRight(uint32_t(r_PtxRegister595), uint32_t(28));				// PTX L1218
	r_PtxRegister604 = uint32_t(r_LaneIndexAtPtx1208) + uint32_t(r_PtxRegister603);			// PTX L1219
	r_PtxRegister605 = ShiftRightSigned(int32_t(r_PtxRegister604), uint32_t(4));			// PTX L1220
	r_PtxRegister606 = uint32_t(r_PtxRegister605) + uint32_t(r_PtxRegister4);				// PTX L1221
	r_PtxRegister607 = uint32_t(r_PtxRegister606) + uint32_t(2);							// PTX L1222
	r_PtxRegister59 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister602);				// PTX L1223
	r_bPtxPredicate322 = int32_t(r_PtxRegister607) < int32_t(0);							// PTX L1224
	r_bPtxPredicate323 = int32_t(r_PtxRegister607) >= int32_t(r_HeightBits);				// PTX L1225
	r_bPtxPredicate324 = r_bPtxPredicate322 | r_bPtxPredicate323;							// PTX L1226
	r_bPtxPredicate325 = !r_bPtxPredicate324;												// PTX L1227
	r_PtxRegister60 = r_bPtxPredicate321 ? 0 : r_PtxRegister607;							// PTX L1228
	r_bPtxPredicate326 = r_bPtxPredicate320 & r_bPtxPredicate324;							// PTX L1229
	r_bPtxPredicate327 = r_bPtxPredicate321 | r_bPtxPredicate325;							// PTX L1230
	r_bPtxPredicate328 = r_bPtxPredicate326 | r_bPtxPredicate319;							// PTX L1231
	r_bPtxPredicate329 = int32_t(r_PtxRegister59) > int32_t(-1);							// PTX L1232
	r_bPtxPredicate330 = int32_t(r_PtxRegister59) < int32_t(r_WidthBits);					// PTX L1233
	r_bPtxPredicate331 = r_bPtxPredicate329 & r_bPtxPredicate330;							// PTX L1234
	r_bPtxPredicate332 = !r_bPtxPredicate326;												// PTX L1235
	r_bPtxPredicate16 = r_bPtxPredicate319 & r_bPtxPredicate332;							// PTX L1236
	r_bPtxPredicate333 = r_bPtxPredicate328 | r_bPtxPredicate331;							// PTX L1237
	r_bPtxPredicate334 = r_bPtxPredicate333 & r_bPtxPredicate327;							// PTX L1238
	r_PtxRegister2712 = uint32_t(0);														// PTX L1239
	r_bPtxPredicate335 = !r_bPtxPredicate334;												// PTX L1240
	if (r_bPtxPredicate335)
	{
		goto L__BB18_98;
	} // PTX L1241
	r_PtxRegister608 = r_PtxRegister597 & -4;										// PTX L1242
	r_PtxRegister609 = uint32_t(r_LaneIndexAtPtx1208) - uint32_t(r_PtxRegister608); // PTX L1243
	r_PtxRegister610 = ShiftLeft(uint32_t(r_PtxRegister59), uint32_t(2));			// PTX L1244
	r_PtxRegister611 = r_bPtxPredicate16 ? 0 : r_PtxRegister610;					// PTX L1245
	r_PtxRegister612 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister60); // PTX L1246
	r_PtxRegister613 =
		uint32_t(r_PtxRegister612) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister609); // PTX L1247
	r_PtxRegister614 = uint32_t(r_PtxRegister613) + uint32_t(r_PtxRegister611);				 // PTX L1248
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_PtxRegister614)) * int64_t(int32_t(4))); // PTX L1249
	g_ResidualByteAddressAtPtx1250 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register72);				// PTX L1250
	r_PtxRegister2712 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1250); // PTX L1251
L__BB18_98:																					// PTX L1252
	r_bPtxPredicate336 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1253
	r_bPtxPredicate337 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1254
	r_bPtxPredicate338 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1255
	r_LaneIndexAtPtx1257 = uint32_t((threadIdx.x & 31u));									// PTX L1257
	r_PtxRegister616 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1257), uint32_t(31));		// PTX L1259
	r_PtxRegister617 = ShiftRight(uint32_t(r_PtxRegister616), uint32_t(30));				// PTX L1260
	r_PtxRegister618 = uint32_t(r_LaneIndexAtPtx1257) + uint32_t(r_PtxRegister617);			// PTX L1261
	r_PtxRegister619 = ShiftRightSigned(int32_t(r_PtxRegister618), uint32_t(2));			// PTX L1262
	r_PtxRegister620 = ShiftRight(uint32_t(r_PtxRegister619), uint32_t(30));				// PTX L1263
	r_PtxRegister621 = uint32_t(r_PtxRegister619) + uint32_t(r_PtxRegister620);				// PTX L1264
	r_PtxRegister622 = r_PtxRegister621 & -4;												// PTX L1265
	r_PtxRegister623 = uint32_t(r_PtxRegister619) - uint32_t(r_PtxRegister622);				// PTX L1266
	r_PtxRegister624 = ShiftRight(uint32_t(r_PtxRegister616), uint32_t(28));				// PTX L1267
	r_PtxRegister625 = uint32_t(r_LaneIndexAtPtx1257) + uint32_t(r_PtxRegister624);			// PTX L1268
	r_PtxRegister626 = ShiftRightSigned(int32_t(r_PtxRegister625), uint32_t(4));			// PTX L1269
	r_PtxRegister61 = uint32_t(r_PtxRegister26) + uint32_t(7);								// PTX L1270
	r_PtxRegister627 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister626);				// PTX L1271
	r_PtxRegister62 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister623);				// PTX L1272
	r_bPtxPredicate339 = int32_t(r_PtxRegister627) < int32_t(0);							// PTX L1273
	r_bPtxPredicate340 = int32_t(r_PtxRegister627) >= int32_t(r_HeightBits);				// PTX L1274
	r_bPtxPredicate341 = r_bPtxPredicate339 | r_bPtxPredicate340;							// PTX L1275
	r_bPtxPredicate342 = !r_bPtxPredicate341;												// PTX L1276
	r_PtxRegister63 = r_bPtxPredicate338 ? 0 : r_PtxRegister627;							// PTX L1277
	r_bPtxPredicate343 = r_bPtxPredicate337 & r_bPtxPredicate341;							// PTX L1278
	r_bPtxPredicate344 = r_bPtxPredicate338 | r_bPtxPredicate342;							// PTX L1279
	r_bPtxPredicate345 = r_bPtxPredicate343 | r_bPtxPredicate336;							// PTX L1280
	r_bPtxPredicate346 = int32_t(r_PtxRegister62) > int32_t(-1);							// PTX L1281
	r_bPtxPredicate347 = int32_t(r_PtxRegister62) < int32_t(r_WidthBits);					// PTX L1282
	r_bPtxPredicate348 = r_bPtxPredicate346 & r_bPtxPredicate347;							// PTX L1283
	r_bPtxPredicate349 = !r_bPtxPredicate343;												// PTX L1284
	r_bPtxPredicate17 = r_bPtxPredicate336 & r_bPtxPredicate349;							// PTX L1285
	r_bPtxPredicate350 = r_bPtxPredicate345 | r_bPtxPredicate348;							// PTX L1286
	r_bPtxPredicate351 = r_bPtxPredicate350 & r_bPtxPredicate344;							// PTX L1287
	r_PtxRegister2713 = uint32_t(0);														// PTX L1288
	r_bPtxPredicate352 = !r_bPtxPredicate351;												// PTX L1289
	if (r_bPtxPredicate352)
	{
		goto L__BB18_100;
	} // PTX L1290
	r_PtxRegister628 = r_PtxRegister618 & -4;										// PTX L1291
	r_PtxRegister629 = uint32_t(r_LaneIndexAtPtx1257) - uint32_t(r_PtxRegister628); // PTX L1292
	r_PtxRegister630 = ShiftLeft(uint32_t(r_PtxRegister62), uint32_t(2));			// PTX L1293
	r_PtxRegister631 = r_bPtxPredicate17 ? 0 : r_PtxRegister630;					// PTX L1294
	r_PtxRegister632 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister63); // PTX L1295
	r_PtxRegister633 =
		uint32_t(r_PtxRegister632) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister629); // PTX L1296
	r_PtxRegister634 = uint32_t(r_PtxRegister633) + uint32_t(r_PtxRegister631);				 // PTX L1297
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister634)) * int64_t(int32_t(4))); // PTX L1298
	g_ResidualByteAddressAtPtx1299 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register74);				// PTX L1299
	r_PtxRegister2713 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1299); // PTX L1300
L__BB18_100:																				// PTX L1301
	r_bPtxPredicate353 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1302
	r_bPtxPredicate354 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1303
	r_bPtxPredicate355 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1304
	r_LaneIndexAtPtx1306 = uint32_t((threadIdx.x & 31u));									// PTX L1306
	r_PtxRegister636 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1306), uint32_t(31));		// PTX L1308
	r_PtxRegister637 = ShiftRight(uint32_t(r_PtxRegister636), uint32_t(30));				// PTX L1309
	r_PtxRegister638 = uint32_t(r_LaneIndexAtPtx1306) + uint32_t(r_PtxRegister637);			// PTX L1310
	r_PtxRegister639 = ShiftRightSigned(int32_t(r_PtxRegister638), uint32_t(2));			// PTX L1311
	r_PtxRegister640 = ShiftRight(uint32_t(r_PtxRegister639), uint32_t(30));				// PTX L1312
	r_PtxRegister641 = uint32_t(r_PtxRegister639) + uint32_t(r_PtxRegister640);				// PTX L1313
	r_PtxRegister642 = r_PtxRegister641 & -4;												// PTX L1314
	r_PtxRegister643 = uint32_t(r_PtxRegister639) - uint32_t(r_PtxRegister642);				// PTX L1315
	r_PtxRegister644 = ShiftRight(uint32_t(r_PtxRegister636), uint32_t(28));				// PTX L1316
	r_PtxRegister645 = uint32_t(r_LaneIndexAtPtx1306) + uint32_t(r_PtxRegister644);			// PTX L1317
	r_PtxRegister646 = ShiftRightSigned(int32_t(r_PtxRegister645), uint32_t(4));			// PTX L1318
	r_PtxRegister647 = uint32_t(r_PtxRegister646) + uint32_t(r_PtxRegister4);				// PTX L1319
	r_PtxRegister648 = uint32_t(r_PtxRegister647) + uint32_t(2);							// PTX L1320
	r_PtxRegister64 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister643);				// PTX L1321
	r_bPtxPredicate356 = int32_t(r_PtxRegister648) < int32_t(0);							// PTX L1322
	r_bPtxPredicate357 = int32_t(r_PtxRegister648) >= int32_t(r_HeightBits);				// PTX L1323
	r_bPtxPredicate358 = r_bPtxPredicate356 | r_bPtxPredicate357;							// PTX L1324
	r_bPtxPredicate359 = !r_bPtxPredicate358;												// PTX L1325
	r_PtxRegister65 = r_bPtxPredicate355 ? 0 : r_PtxRegister648;							// PTX L1326
	r_bPtxPredicate360 = r_bPtxPredicate354 & r_bPtxPredicate358;							// PTX L1327
	r_bPtxPredicate361 = r_bPtxPredicate355 | r_bPtxPredicate359;							// PTX L1328
	r_bPtxPredicate362 = r_bPtxPredicate360 | r_bPtxPredicate353;							// PTX L1329
	r_bPtxPredicate363 = int32_t(r_PtxRegister64) > int32_t(-1);							// PTX L1330
	r_bPtxPredicate364 = int32_t(r_PtxRegister64) < int32_t(r_WidthBits);					// PTX L1331
	r_bPtxPredicate365 = r_bPtxPredicate363 & r_bPtxPredicate364;							// PTX L1332
	r_bPtxPredicate366 = !r_bPtxPredicate360;												// PTX L1333
	r_bPtxPredicate18 = r_bPtxPredicate353 & r_bPtxPredicate366;							// PTX L1334
	r_bPtxPredicate367 = r_bPtxPredicate362 | r_bPtxPredicate365;							// PTX L1335
	r_bPtxPredicate368 = r_bPtxPredicate367 & r_bPtxPredicate361;							// PTX L1336
	r_PtxRegister2714 = uint32_t(0);														// PTX L1337
	r_bPtxPredicate369 = !r_bPtxPredicate368;												// PTX L1338
	if (r_bPtxPredicate369)
	{
		goto L__BB18_102;
	} // PTX L1339
	r_PtxRegister649 = r_PtxRegister638 & -4;										// PTX L1340
	r_PtxRegister650 = uint32_t(r_LaneIndexAtPtx1306) - uint32_t(r_PtxRegister649); // PTX L1341
	r_PtxRegister651 = ShiftLeft(uint32_t(r_PtxRegister64), uint32_t(2));			// PTX L1342
	r_PtxRegister652 = r_bPtxPredicate18 ? 0 : r_PtxRegister651;					// PTX L1343
	r_PtxRegister653 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister65); // PTX L1344
	r_PtxRegister654 =
		uint32_t(r_PtxRegister653) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister650); // PTX L1345
	r_PtxRegister655 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister652);				 // PTX L1346
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister655)) * int64_t(int32_t(4))); // PTX L1347
	g_ResidualByteAddressAtPtx1348 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register76);				// PTX L1348
	r_PtxRegister2714 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1348); // PTX L1349
L__BB18_102:																				// PTX L1350
	r_bPtxPredicate370 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1351
	r_bPtxPredicate371 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1352
	r_bPtxPredicate372 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1353
	r_LaneIndexAtPtx1355 = uint32_t((threadIdx.x & 31u));									// PTX L1355
	r_PtxRegister657 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1355), uint32_t(31));		// PTX L1357
	r_PtxRegister658 = ShiftRight(uint32_t(r_PtxRegister657), uint32_t(30));				// PTX L1358
	r_PtxRegister659 = uint32_t(r_LaneIndexAtPtx1355) + uint32_t(r_PtxRegister658);			// PTX L1359
	r_PtxRegister660 = ShiftRightSigned(int32_t(r_PtxRegister659), uint32_t(2));			// PTX L1360
	r_PtxRegister661 = ShiftRight(uint32_t(r_PtxRegister660), uint32_t(30));				// PTX L1361
	r_PtxRegister662 = uint32_t(r_PtxRegister660) + uint32_t(r_PtxRegister661);				// PTX L1362
	r_PtxRegister663 = r_PtxRegister662 & -4;												// PTX L1363
	r_PtxRegister664 = uint32_t(r_PtxRegister660) - uint32_t(r_PtxRegister663);				// PTX L1364
	r_PtxRegister665 = ShiftRight(uint32_t(r_PtxRegister657), uint32_t(28));				// PTX L1365
	r_PtxRegister666 = uint32_t(r_LaneIndexAtPtx1355) + uint32_t(r_PtxRegister665);			// PTX L1366
	r_PtxRegister667 = ShiftRightSigned(int32_t(r_PtxRegister666), uint32_t(4));			// PTX L1367
	r_PtxRegister668 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister5);				// PTX L1368
	r_PtxRegister669 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister667);				// PTX L1369
	r_PtxRegister66 = uint32_t(r_PtxRegister668) + uint32_t(4);								// PTX L1370
	r_bPtxPredicate373 = int32_t(r_PtxRegister669) < int32_t(0);							// PTX L1371
	r_bPtxPredicate374 = int32_t(r_PtxRegister669) >= int32_t(r_HeightBits);				// PTX L1372
	r_bPtxPredicate375 = r_bPtxPredicate373 | r_bPtxPredicate374;							// PTX L1373
	r_bPtxPredicate376 = !r_bPtxPredicate375;												// PTX L1374
	r_PtxRegister67 = r_bPtxPredicate372 ? 0 : r_PtxRegister669;							// PTX L1375
	r_bPtxPredicate377 = r_bPtxPredicate371 & r_bPtxPredicate375;							// PTX L1376
	r_bPtxPredicate378 = r_bPtxPredicate372 | r_bPtxPredicate376;							// PTX L1377
	r_bPtxPredicate379 = r_bPtxPredicate377 | r_bPtxPredicate370;							// PTX L1378
	r_bPtxPredicate380 = int32_t(r_PtxRegister66) < int32_t(r_WidthBits);					// PTX L1379
	r_bPtxPredicate381 = !r_bPtxPredicate377;												// PTX L1380
	r_bPtxPredicate19 = r_bPtxPredicate370 & r_bPtxPredicate381;							// PTX L1381
	r_bPtxPredicate382 = r_bPtxPredicate379 | r_bPtxPredicate380;							// PTX L1382
	r_bPtxPredicate383 = r_bPtxPredicate382 & r_bPtxPredicate378;							// PTX L1383
	r_PtxRegister2715 = uint32_t(0);														// PTX L1384
	r_bPtxPredicate384 = !r_bPtxPredicate383;												// PTX L1385
	if (r_bPtxPredicate384)
	{
		goto L__BB18_104;
	} // PTX L1386
	r_PtxRegister670 = r_PtxRegister659 & -4;										// PTX L1387
	r_PtxRegister671 = uint32_t(r_LaneIndexAtPtx1355) - uint32_t(r_PtxRegister670); // PTX L1388
	r_PtxRegister672 = ShiftLeft(uint32_t(r_PtxRegister66), uint32_t(2));			// PTX L1389
	r_PtxRegister673 = r_bPtxPredicate19 ? 0 : r_PtxRegister672;					// PTX L1390
	r_PtxRegister674 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister67); // PTX L1391
	r_PtxRegister675 =
		uint32_t(r_PtxRegister674) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister671); // PTX L1392
	r_PtxRegister676 = uint32_t(r_PtxRegister675) + uint32_t(r_PtxRegister673);				 // PTX L1393
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister676)) * int64_t(int32_t(4))); // PTX L1394
	g_ResidualByteAddressAtPtx1395 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register78);				// PTX L1395
	r_PtxRegister2715 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1395); // PTX L1396
L__BB18_104:																				// PTX L1397
	r_bPtxPredicate385 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1398
	r_bPtxPredicate386 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1399
	r_bPtxPredicate387 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1400
	r_LaneIndexAtPtx1402 = uint32_t((threadIdx.x & 31u));									// PTX L1402
	r_PtxRegister678 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1402), uint32_t(31));		// PTX L1404
	r_PtxRegister679 = ShiftRight(uint32_t(r_PtxRegister678), uint32_t(30));				// PTX L1405
	r_PtxRegister680 = uint32_t(r_LaneIndexAtPtx1402) + uint32_t(r_PtxRegister679);			// PTX L1406
	r_PtxRegister681 = ShiftRightSigned(int32_t(r_PtxRegister680), uint32_t(2));			// PTX L1407
	r_PtxRegister682 = ShiftRight(uint32_t(r_PtxRegister681), uint32_t(30));				// PTX L1408
	r_PtxRegister683 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister682);				// PTX L1409
	r_PtxRegister684 = r_PtxRegister683 & -4;												// PTX L1410
	r_PtxRegister685 = uint32_t(r_PtxRegister681) - uint32_t(r_PtxRegister684);				// PTX L1411
	r_PtxRegister686 = ShiftRight(uint32_t(r_PtxRegister678), uint32_t(28));				// PTX L1412
	r_PtxRegister687 = uint32_t(r_LaneIndexAtPtx1402) + uint32_t(r_PtxRegister686);			// PTX L1413
	r_PtxRegister688 = ShiftRightSigned(int32_t(r_PtxRegister687), uint32_t(4));			// PTX L1414
	r_PtxRegister689 = uint32_t(r_PtxRegister688) + uint32_t(r_PtxRegister4);				// PTX L1415
	r_PtxRegister690 = uint32_t(r_PtxRegister685) + uint32_t(r_PtxRegister5);				// PTX L1416
	r_PtxRegister691 = uint32_t(r_PtxRegister689) + uint32_t(2);							// PTX L1417
	r_PtxRegister68 = uint32_t(r_PtxRegister690) + uint32_t(4);								// PTX L1418
	r_bPtxPredicate388 = int32_t(r_PtxRegister691) < int32_t(0);							// PTX L1419
	r_bPtxPredicate389 = int32_t(r_PtxRegister691) >= int32_t(r_HeightBits);				// PTX L1420
	r_bPtxPredicate390 = r_bPtxPredicate388 | r_bPtxPredicate389;							// PTX L1421
	r_bPtxPredicate391 = !r_bPtxPredicate390;												// PTX L1422
	r_PtxRegister69 = r_bPtxPredicate387 ? 0 : r_PtxRegister691;							// PTX L1423
	r_bPtxPredicate392 = r_bPtxPredicate386 & r_bPtxPredicate390;							// PTX L1424
	r_bPtxPredicate393 = r_bPtxPredicate387 | r_bPtxPredicate391;							// PTX L1425
	r_bPtxPredicate394 = r_bPtxPredicate392 | r_bPtxPredicate385;							// PTX L1426
	r_bPtxPredicate395 = int32_t(r_PtxRegister68) < int32_t(r_WidthBits);					// PTX L1427
	r_bPtxPredicate396 = !r_bPtxPredicate392;												// PTX L1428
	r_bPtxPredicate20 = r_bPtxPredicate385 & r_bPtxPredicate396;							// PTX L1429
	r_bPtxPredicate397 = r_bPtxPredicate394 | r_bPtxPredicate395;							// PTX L1430
	r_bPtxPredicate398 = r_bPtxPredicate397 & r_bPtxPredicate393;							// PTX L1431
	r_PtxRegister2716 = uint32_t(0);														// PTX L1432
	r_bPtxPredicate399 = !r_bPtxPredicate398;												// PTX L1433
	if (r_bPtxPredicate399)
	{
		goto L__BB18_106;
	} // PTX L1434
	r_PtxRegister692 = r_PtxRegister680 & -4;										// PTX L1435
	r_PtxRegister693 = uint32_t(r_LaneIndexAtPtx1402) - uint32_t(r_PtxRegister692); // PTX L1436
	r_PtxRegister694 = ShiftLeft(uint32_t(r_PtxRegister68), uint32_t(2));			// PTX L1437
	r_PtxRegister695 = r_bPtxPredicate20 ? 0 : r_PtxRegister694;					// PTX L1438
	r_PtxRegister696 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister69); // PTX L1439
	r_PtxRegister697 =
		uint32_t(r_PtxRegister696) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister693); // PTX L1440
	r_PtxRegister698 = uint32_t(r_PtxRegister697) + uint32_t(r_PtxRegister695);				 // PTX L1441
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_PtxRegister698)) * int64_t(int32_t(4))); // PTX L1442
	g_ResidualByteAddressAtPtx1443 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register80);				// PTX L1443
	r_PtxRegister2716 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1443); // PTX L1444
L__BB18_106:																				// PTX L1445
	r_bPtxPredicate400 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1446
	r_bPtxPredicate401 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1447
	r_bPtxPredicate402 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1448
	r_LaneIndexAtPtx1450 = uint32_t((threadIdx.x & 31u));									// PTX L1450
	r_PtxRegister700 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1450), uint32_t(31));		// PTX L1452
	r_PtxRegister701 = ShiftRight(uint32_t(r_PtxRegister700), uint32_t(30));				// PTX L1453
	r_PtxRegister702 = uint32_t(r_LaneIndexAtPtx1450) + uint32_t(r_PtxRegister701);			// PTX L1454
	r_PtxRegister703 = ShiftRightSigned(int32_t(r_PtxRegister702), uint32_t(2));			// PTX L1455
	r_PtxRegister704 = ShiftRight(uint32_t(r_PtxRegister703), uint32_t(30));				// PTX L1456
	r_PtxRegister705 = uint32_t(r_PtxRegister703) + uint32_t(r_PtxRegister704);				// PTX L1457
	r_PtxRegister706 = r_PtxRegister705 & -4;												// PTX L1458
	r_PtxRegister707 = uint32_t(r_PtxRegister703) - uint32_t(r_PtxRegister706);				// PTX L1459
	r_PtxRegister708 = ShiftRight(uint32_t(r_PtxRegister700), uint32_t(28));				// PTX L1460
	r_PtxRegister709 = uint32_t(r_LaneIndexAtPtx1450) + uint32_t(r_PtxRegister708);			// PTX L1461
	r_PtxRegister710 = ShiftRightSigned(int32_t(r_PtxRegister709), uint32_t(4));			// PTX L1462
	r_PtxRegister711 = uint32_t(r_PtxRegister707) + uint32_t(r_PtxRegister5);				// PTX L1463
	r_PtxRegister712 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister710);				// PTX L1464
	r_PtxRegister70 = uint32_t(r_PtxRegister711) + uint32_t(4);								// PTX L1465
	r_bPtxPredicate403 = int32_t(r_PtxRegister712) < int32_t(0);							// PTX L1466
	r_bPtxPredicate404 = int32_t(r_PtxRegister712) >= int32_t(r_HeightBits);				// PTX L1467
	r_bPtxPredicate405 = r_bPtxPredicate403 | r_bPtxPredicate404;							// PTX L1468
	r_bPtxPredicate406 = !r_bPtxPredicate405;												// PTX L1469
	r_PtxRegister71 = r_bPtxPredicate402 ? 0 : r_PtxRegister712;							// PTX L1470
	r_bPtxPredicate407 = r_bPtxPredicate401 & r_bPtxPredicate405;							// PTX L1471
	r_bPtxPredicate408 = r_bPtxPredicate402 | r_bPtxPredicate406;							// PTX L1472
	r_bPtxPredicate409 = r_bPtxPredicate407 | r_bPtxPredicate400;							// PTX L1473
	r_bPtxPredicate410 = int32_t(r_PtxRegister70) < int32_t(r_WidthBits);					// PTX L1474
	r_bPtxPredicate411 = !r_bPtxPredicate407;												// PTX L1475
	r_bPtxPredicate21 = r_bPtxPredicate400 & r_bPtxPredicate411;							// PTX L1476
	r_bPtxPredicate412 = r_bPtxPredicate409 | r_bPtxPredicate410;							// PTX L1477
	r_bPtxPredicate413 = r_bPtxPredicate412 & r_bPtxPredicate408;							// PTX L1478
	r_PtxRegister2717 = uint32_t(0);														// PTX L1479
	r_bPtxPredicate414 = !r_bPtxPredicate413;												// PTX L1480
	if (r_bPtxPredicate414)
	{
		goto L__BB18_108;
	} // PTX L1481
	r_PtxRegister713 = r_PtxRegister702 & -4;										// PTX L1482
	r_PtxRegister714 = uint32_t(r_LaneIndexAtPtx1450) - uint32_t(r_PtxRegister713); // PTX L1483
	r_PtxRegister715 = ShiftLeft(uint32_t(r_PtxRegister70), uint32_t(2));			// PTX L1484
	r_PtxRegister716 = r_bPtxPredicate21 ? 0 : r_PtxRegister715;					// PTX L1485
	r_PtxRegister717 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister71); // PTX L1486
	r_PtxRegister718 =
		uint32_t(r_PtxRegister717) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister714); // PTX L1487
	r_PtxRegister719 = uint32_t(r_PtxRegister718) + uint32_t(r_PtxRegister716);				 // PTX L1488
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister719)) * int64_t(int32_t(4))); // PTX L1489
	g_ResidualByteAddressAtPtx1490 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register82);				// PTX L1490
	r_PtxRegister2717 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1490); // PTX L1491
L__BB18_108:																				// PTX L1492
	r_bPtxPredicate415 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1493
	r_bPtxPredicate416 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1494
	r_bPtxPredicate417 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1495
	r_LaneIndexAtPtx1497 = uint32_t((threadIdx.x & 31u));									// PTX L1497
	r_PtxRegister721 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1497), uint32_t(31));		// PTX L1499
	r_PtxRegister722 = ShiftRight(uint32_t(r_PtxRegister721), uint32_t(30));				// PTX L1500
	r_PtxRegister723 = uint32_t(r_LaneIndexAtPtx1497) + uint32_t(r_PtxRegister722);			// PTX L1501
	r_PtxRegister724 = ShiftRightSigned(int32_t(r_PtxRegister723), uint32_t(2));			// PTX L1502
	r_PtxRegister725 = ShiftRight(uint32_t(r_PtxRegister724), uint32_t(30));				// PTX L1503
	r_PtxRegister726 = uint32_t(r_PtxRegister724) + uint32_t(r_PtxRegister725);				// PTX L1504
	r_PtxRegister727 = r_PtxRegister726 & -4;												// PTX L1505
	r_PtxRegister728 = uint32_t(r_PtxRegister724) - uint32_t(r_PtxRegister727);				// PTX L1506
	r_PtxRegister729 = ShiftRight(uint32_t(r_PtxRegister721), uint32_t(28));				// PTX L1507
	r_PtxRegister730 = uint32_t(r_LaneIndexAtPtx1497) + uint32_t(r_PtxRegister729);			// PTX L1508
	r_PtxRegister731 = ShiftRightSigned(int32_t(r_PtxRegister730), uint32_t(4));			// PTX L1509
	r_PtxRegister732 = uint32_t(r_PtxRegister731) + uint32_t(r_PtxRegister4);				// PTX L1510
	r_PtxRegister733 = uint32_t(r_PtxRegister728) + uint32_t(r_PtxRegister5);				// PTX L1511
	r_PtxRegister734 = uint32_t(r_PtxRegister732) + uint32_t(2);							// PTX L1512
	r_PtxRegister72 = uint32_t(r_PtxRegister733) + uint32_t(4);								// PTX L1513
	r_bPtxPredicate418 = int32_t(r_PtxRegister734) < int32_t(0);							// PTX L1514
	r_bPtxPredicate419 = int32_t(r_PtxRegister734) >= int32_t(r_HeightBits);				// PTX L1515
	r_bPtxPredicate420 = r_bPtxPredicate418 | r_bPtxPredicate419;							// PTX L1516
	r_bPtxPredicate421 = !r_bPtxPredicate420;												// PTX L1517
	r_PtxRegister73 = r_bPtxPredicate417 ? 0 : r_PtxRegister734;							// PTX L1518
	r_bPtxPredicate422 = r_bPtxPredicate416 & r_bPtxPredicate420;							// PTX L1519
	r_bPtxPredicate423 = r_bPtxPredicate417 | r_bPtxPredicate421;							// PTX L1520
	r_bPtxPredicate424 = r_bPtxPredicate422 | r_bPtxPredicate415;							// PTX L1521
	r_bPtxPredicate425 = int32_t(r_PtxRegister72) < int32_t(r_WidthBits);					// PTX L1522
	r_bPtxPredicate426 = !r_bPtxPredicate422;												// PTX L1523
	r_bPtxPredicate22 = r_bPtxPredicate415 & r_bPtxPredicate426;							// PTX L1524
	r_bPtxPredicate427 = r_bPtxPredicate424 | r_bPtxPredicate425;							// PTX L1525
	r_bPtxPredicate428 = r_bPtxPredicate427 & r_bPtxPredicate423;							// PTX L1526
	r_PtxRegister2718 = uint32_t(0);														// PTX L1527
	r_bPtxPredicate429 = !r_bPtxPredicate428;												// PTX L1528
	if (r_bPtxPredicate429)
	{
		goto L__BB18_110;
	} // PTX L1529
	r_PtxRegister735 = r_PtxRegister723 & -4;										// PTX L1530
	r_PtxRegister736 = uint32_t(r_LaneIndexAtPtx1497) - uint32_t(r_PtxRegister735); // PTX L1531
	r_PtxRegister737 = ShiftLeft(uint32_t(r_PtxRegister72), uint32_t(2));			// PTX L1532
	r_PtxRegister738 = r_bPtxPredicate22 ? 0 : r_PtxRegister737;					// PTX L1533
	r_PtxRegister739 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister73); // PTX L1534
	r_PtxRegister740 =
		uint32_t(r_PtxRegister739) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister736); // PTX L1535
	r_PtxRegister741 = uint32_t(r_PtxRegister740) + uint32_t(r_PtxRegister738);				 // PTX L1536
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister741)) * int64_t(int32_t(4))); // PTX L1537
	g_ResidualByteAddressAtPtx1538 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register84);				// PTX L1538
	r_PtxRegister2718 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1538); // PTX L1539
L__BB18_110:																				// PTX L1540
	r_bPtxPredicate430 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1541
	r_bPtxPredicate431 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1542
	r_bPtxPredicate432 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1543
	r_LaneIndexAtPtx1545 = uint32_t((threadIdx.x & 31u));									// PTX L1545
	r_PtxRegister743 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1545), uint32_t(31));		// PTX L1547
	r_PtxRegister744 = ShiftRight(uint32_t(r_PtxRegister743), uint32_t(30));				// PTX L1548
	r_PtxRegister745 = uint32_t(r_LaneIndexAtPtx1545) + uint32_t(r_PtxRegister744);			// PTX L1549
	r_PtxRegister746 = ShiftRightSigned(int32_t(r_PtxRegister745), uint32_t(2));			// PTX L1550
	r_PtxRegister747 = ShiftRight(uint32_t(r_PtxRegister746), uint32_t(30));				// PTX L1551
	r_PtxRegister748 = uint32_t(r_PtxRegister746) + uint32_t(r_PtxRegister747);				// PTX L1552
	r_PtxRegister749 = r_PtxRegister748 & -4;												// PTX L1553
	r_PtxRegister750 = uint32_t(r_PtxRegister746) - uint32_t(r_PtxRegister749);				// PTX L1554
	r_PtxRegister751 = ShiftRight(uint32_t(r_PtxRegister743), uint32_t(28));				// PTX L1555
	r_PtxRegister752 = uint32_t(r_LaneIndexAtPtx1545) + uint32_t(r_PtxRegister751);			// PTX L1556
	r_PtxRegister753 = ShiftRightSigned(int32_t(r_PtxRegister752), uint32_t(4));			// PTX L1557
	r_PtxRegister754 = uint32_t(r_PtxRegister750) + uint32_t(r_PtxRegister5);				// PTX L1558
	r_PtxRegister755 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister753);				// PTX L1559
	r_PtxRegister74 = uint32_t(r_PtxRegister754) + uint32_t(4);								// PTX L1560
	r_bPtxPredicate433 = int32_t(r_PtxRegister755) < int32_t(0);							// PTX L1561
	r_bPtxPredicate434 = int32_t(r_PtxRegister755) >= int32_t(r_HeightBits);				// PTX L1562
	r_bPtxPredicate435 = r_bPtxPredicate433 | r_bPtxPredicate434;							// PTX L1563
	r_bPtxPredicate436 = !r_bPtxPredicate435;												// PTX L1564
	r_PtxRegister75 = r_bPtxPredicate432 ? 0 : r_PtxRegister755;							// PTX L1565
	r_bPtxPredicate437 = r_bPtxPredicate431 & r_bPtxPredicate435;							// PTX L1566
	r_bPtxPredicate438 = r_bPtxPredicate432 | r_bPtxPredicate436;							// PTX L1567
	r_bPtxPredicate439 = r_bPtxPredicate437 | r_bPtxPredicate430;							// PTX L1568
	r_bPtxPredicate440 = int32_t(r_PtxRegister74) < int32_t(r_WidthBits);					// PTX L1569
	r_bPtxPredicate441 = !r_bPtxPredicate437;												// PTX L1570
	r_bPtxPredicate23 = r_bPtxPredicate430 & r_bPtxPredicate441;							// PTX L1571
	r_bPtxPredicate442 = r_bPtxPredicate439 | r_bPtxPredicate440;							// PTX L1572
	r_bPtxPredicate443 = r_bPtxPredicate442 & r_bPtxPredicate438;							// PTX L1573
	r_PtxRegister2719 = uint32_t(0);														// PTX L1574
	r_bPtxPredicate444 = !r_bPtxPredicate443;												// PTX L1575
	if (r_bPtxPredicate444)
	{
		goto L__BB18_112;
	} // PTX L1576
	r_PtxRegister756 = r_PtxRegister745 & -4;										// PTX L1577
	r_PtxRegister757 = uint32_t(r_LaneIndexAtPtx1545) - uint32_t(r_PtxRegister756); // PTX L1578
	r_PtxRegister758 = ShiftLeft(uint32_t(r_PtxRegister74), uint32_t(2));			// PTX L1579
	r_PtxRegister759 = r_bPtxPredicate23 ? 0 : r_PtxRegister758;					// PTX L1580
	r_PtxRegister760 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister75); // PTX L1581
	r_PtxRegister761 =
		uint32_t(r_PtxRegister760) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister757); // PTX L1582
	r_PtxRegister762 = uint32_t(r_PtxRegister761) + uint32_t(r_PtxRegister759);				 // PTX L1583
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister762)) * int64_t(int32_t(4))); // PTX L1584
	g_ResidualByteAddressAtPtx1585 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register86);				// PTX L1585
	r_PtxRegister2719 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1585); // PTX L1586
L__BB18_112:																				// PTX L1587
	r_bPtxPredicate445 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1588
	r_bPtxPredicate446 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1589
	r_bPtxPredicate447 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1590
	r_LaneIndexAtPtx1592 = uint32_t((threadIdx.x & 31u));									// PTX L1592
	r_PtxRegister764 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1592), uint32_t(31));		// PTX L1594
	r_PtxRegister765 = ShiftRight(uint32_t(r_PtxRegister764), uint32_t(30));				// PTX L1595
	r_PtxRegister766 = uint32_t(r_LaneIndexAtPtx1592) + uint32_t(r_PtxRegister765);			// PTX L1596
	r_PtxRegister767 = ShiftRightSigned(int32_t(r_PtxRegister766), uint32_t(2));			// PTX L1597
	r_PtxRegister768 = ShiftRight(uint32_t(r_PtxRegister767), uint32_t(30));				// PTX L1598
	r_PtxRegister769 = uint32_t(r_PtxRegister767) + uint32_t(r_PtxRegister768);				// PTX L1599
	r_PtxRegister770 = r_PtxRegister769 & -4;												// PTX L1600
	r_PtxRegister771 = uint32_t(r_PtxRegister767) - uint32_t(r_PtxRegister770);				// PTX L1601
	r_PtxRegister772 = ShiftRight(uint32_t(r_PtxRegister764), uint32_t(28));				// PTX L1602
	r_PtxRegister773 = uint32_t(r_LaneIndexAtPtx1592) + uint32_t(r_PtxRegister772);			// PTX L1603
	r_PtxRegister774 = ShiftRightSigned(int32_t(r_PtxRegister773), uint32_t(4));			// PTX L1604
	r_PtxRegister775 = uint32_t(r_PtxRegister774) + uint32_t(r_PtxRegister4);				// PTX L1605
	r_PtxRegister776 = uint32_t(r_PtxRegister771) + uint32_t(r_PtxRegister5);				// PTX L1606
	r_PtxRegister777 = uint32_t(r_PtxRegister775) + uint32_t(2);							// PTX L1607
	r_PtxRegister76 = uint32_t(r_PtxRegister776) + uint32_t(4);								// PTX L1608
	r_bPtxPredicate448 = int32_t(r_PtxRegister777) < int32_t(0);							// PTX L1609
	r_bPtxPredicate449 = int32_t(r_PtxRegister777) >= int32_t(r_HeightBits);				// PTX L1610
	r_bPtxPredicate450 = r_bPtxPredicate448 | r_bPtxPredicate449;							// PTX L1611
	r_bPtxPredicate451 = !r_bPtxPredicate450;												// PTX L1612
	r_PtxRegister77 = r_bPtxPredicate447 ? 0 : r_PtxRegister777;							// PTX L1613
	r_bPtxPredicate452 = r_bPtxPredicate446 & r_bPtxPredicate450;							// PTX L1614
	r_bPtxPredicate453 = r_bPtxPredicate447 | r_bPtxPredicate451;							// PTX L1615
	r_bPtxPredicate454 = r_bPtxPredicate452 | r_bPtxPredicate445;							// PTX L1616
	r_bPtxPredicate455 = int32_t(r_PtxRegister76) < int32_t(r_WidthBits);					// PTX L1617
	r_bPtxPredicate456 = !r_bPtxPredicate452;												// PTX L1618
	r_bPtxPredicate24 = r_bPtxPredicate445 & r_bPtxPredicate456;							// PTX L1619
	r_bPtxPredicate457 = r_bPtxPredicate454 | r_bPtxPredicate455;							// PTX L1620
	r_bPtxPredicate458 = r_bPtxPredicate457 & r_bPtxPredicate453;							// PTX L1621
	r_PtxRegister2720 = uint32_t(0);														// PTX L1622
	r_bPtxPredicate459 = !r_bPtxPredicate458;												// PTX L1623
	if (r_bPtxPredicate459)
	{
		goto L__BB18_114;
	} // PTX L1624
	r_PtxRegister778 = r_PtxRegister766 & -4;										// PTX L1625
	r_PtxRegister779 = uint32_t(r_LaneIndexAtPtx1592) - uint32_t(r_PtxRegister778); // PTX L1626
	r_PtxRegister780 = ShiftLeft(uint32_t(r_PtxRegister76), uint32_t(2));			// PTX L1627
	r_PtxRegister781 = r_bPtxPredicate24 ? 0 : r_PtxRegister780;					// PTX L1628
	r_PtxRegister782 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister77); // PTX L1629
	r_PtxRegister783 =
		uint32_t(r_PtxRegister782) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister779); // PTX L1630
	r_PtxRegister784 = uint32_t(r_PtxRegister783) + uint32_t(r_PtxRegister781);				 // PTX L1631
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_PtxRegister784)) * int64_t(int32_t(4))); // PTX L1632
	g_ResidualByteAddressAtPtx1633 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register88);				// PTX L1633
	r_PtxRegister2720 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1633); // PTX L1634
L__BB18_114:																				// PTX L1635
	r_bPtxPredicate460 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1636
	r_bPtxPredicate461 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1637
	r_bPtxPredicate462 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1638
	r_LaneIndexAtPtx1640 = uint32_t((threadIdx.x & 31u));									// PTX L1640
	r_PtxRegister786 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1640), uint32_t(31));		// PTX L1642
	r_PtxRegister787 = ShiftRight(uint32_t(r_PtxRegister786), uint32_t(30));				// PTX L1643
	r_PtxRegister788 = uint32_t(r_LaneIndexAtPtx1640) + uint32_t(r_PtxRegister787);			// PTX L1644
	r_PtxRegister789 = ShiftRightSigned(int32_t(r_PtxRegister788), uint32_t(2));			// PTX L1645
	r_PtxRegister790 = ShiftRight(uint32_t(r_PtxRegister789), uint32_t(30));				// PTX L1646
	r_PtxRegister791 = uint32_t(r_PtxRegister789) + uint32_t(r_PtxRegister790);				// PTX L1647
	r_PtxRegister792 = r_PtxRegister791 & -4;												// PTX L1648
	r_PtxRegister793 = uint32_t(r_PtxRegister789) - uint32_t(r_PtxRegister792);				// PTX L1649
	r_PtxRegister794 = ShiftRight(uint32_t(r_PtxRegister786), uint32_t(28));				// PTX L1650
	r_PtxRegister795 = uint32_t(r_LaneIndexAtPtx1640) + uint32_t(r_PtxRegister794);			// PTX L1651
	r_PtxRegister796 = ShiftRightSigned(int32_t(r_PtxRegister795), uint32_t(4));			// PTX L1652
	r_PtxRegister797 = uint32_t(r_PtxRegister793) + uint32_t(r_PtxRegister5);				// PTX L1653
	r_PtxRegister798 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister796);				// PTX L1654
	r_PtxRegister78 = uint32_t(r_PtxRegister797) + uint32_t(4);								// PTX L1655
	r_bPtxPredicate463 = int32_t(r_PtxRegister798) < int32_t(0);							// PTX L1656
	r_bPtxPredicate464 = int32_t(r_PtxRegister798) >= int32_t(r_HeightBits);				// PTX L1657
	r_bPtxPredicate465 = r_bPtxPredicate463 | r_bPtxPredicate464;							// PTX L1658
	r_bPtxPredicate466 = !r_bPtxPredicate465;												// PTX L1659
	r_PtxRegister79 = r_bPtxPredicate462 ? 0 : r_PtxRegister798;							// PTX L1660
	r_bPtxPredicate467 = r_bPtxPredicate461 & r_bPtxPredicate465;							// PTX L1661
	r_bPtxPredicate468 = r_bPtxPredicate462 | r_bPtxPredicate466;							// PTX L1662
	r_bPtxPredicate469 = r_bPtxPredicate467 | r_bPtxPredicate460;							// PTX L1663
	r_bPtxPredicate470 = int32_t(r_PtxRegister78) < int32_t(r_WidthBits);					// PTX L1664
	r_bPtxPredicate471 = !r_bPtxPredicate467;												// PTX L1665
	r_bPtxPredicate25 = r_bPtxPredicate460 & r_bPtxPredicate471;							// PTX L1666
	r_bPtxPredicate472 = r_bPtxPredicate469 | r_bPtxPredicate470;							// PTX L1667
	r_bPtxPredicate473 = r_bPtxPredicate472 & r_bPtxPredicate468;							// PTX L1668
	r_PtxRegister2721 = uint32_t(0);														// PTX L1669
	r_bPtxPredicate474 = !r_bPtxPredicate473;												// PTX L1670
	if (r_bPtxPredicate474)
	{
		goto L__BB18_116;
	} // PTX L1671
	r_PtxRegister799 = r_PtxRegister788 & -4;										// PTX L1672
	r_PtxRegister800 = uint32_t(r_LaneIndexAtPtx1640) - uint32_t(r_PtxRegister799); // PTX L1673
	r_PtxRegister801 = ShiftLeft(uint32_t(r_PtxRegister78), uint32_t(2));			// PTX L1674
	r_PtxRegister802 = r_bPtxPredicate25 ? 0 : r_PtxRegister801;					// PTX L1675
	r_PtxRegister803 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister79); // PTX L1676
	r_PtxRegister804 =
		uint32_t(r_PtxRegister803) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister800); // PTX L1677
	r_PtxRegister805 = uint32_t(r_PtxRegister804) + uint32_t(r_PtxRegister802);				 // PTX L1678
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister805)) * int64_t(int32_t(4))); // PTX L1679
	g_ResidualByteAddressAtPtx1680 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register90);				// PTX L1680
	r_PtxRegister2721 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1680); // PTX L1681
L__BB18_116:																				// PTX L1682
	r_bPtxPredicate475 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1683
	r_bPtxPredicate476 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1684
	r_bPtxPredicate477 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1685
	r_LaneIndexAtPtx1687 = uint32_t((threadIdx.x & 31u));									// PTX L1687
	r_PtxRegister807 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1687), uint32_t(31));		// PTX L1689
	r_PtxRegister808 = ShiftRight(uint32_t(r_PtxRegister807), uint32_t(30));				// PTX L1690
	r_PtxRegister809 = uint32_t(r_LaneIndexAtPtx1687) + uint32_t(r_PtxRegister808);			// PTX L1691
	r_PtxRegister810 = ShiftRightSigned(int32_t(r_PtxRegister809), uint32_t(2));			// PTX L1692
	r_PtxRegister811 = ShiftRight(uint32_t(r_PtxRegister810), uint32_t(30));				// PTX L1693
	r_PtxRegister812 = uint32_t(r_PtxRegister810) + uint32_t(r_PtxRegister811);				// PTX L1694
	r_PtxRegister813 = r_PtxRegister812 & -4;												// PTX L1695
	r_PtxRegister814 = uint32_t(r_PtxRegister810) - uint32_t(r_PtxRegister813);				// PTX L1696
	r_PtxRegister815 = ShiftRight(uint32_t(r_PtxRegister807), uint32_t(28));				// PTX L1697
	r_PtxRegister816 = uint32_t(r_LaneIndexAtPtx1687) + uint32_t(r_PtxRegister815);			// PTX L1698
	r_PtxRegister817 = ShiftRightSigned(int32_t(r_PtxRegister816), uint32_t(4));			// PTX L1699
	r_PtxRegister818 = uint32_t(r_PtxRegister817) + uint32_t(r_PtxRegister4);				// PTX L1700
	r_PtxRegister819 = uint32_t(r_PtxRegister814) + uint32_t(r_PtxRegister5);				// PTX L1701
	r_PtxRegister820 = uint32_t(r_PtxRegister818) + uint32_t(2);							// PTX L1702
	r_PtxRegister80 = uint32_t(r_PtxRegister819) + uint32_t(4);								// PTX L1703
	r_bPtxPredicate478 = int32_t(r_PtxRegister820) < int32_t(0);							// PTX L1704
	r_bPtxPredicate479 = int32_t(r_PtxRegister820) >= int32_t(r_HeightBits);				// PTX L1705
	r_bPtxPredicate480 = r_bPtxPredicate478 | r_bPtxPredicate479;							// PTX L1706
	r_bPtxPredicate481 = !r_bPtxPredicate480;												// PTX L1707
	r_PtxRegister81 = r_bPtxPredicate477 ? 0 : r_PtxRegister820;							// PTX L1708
	r_bPtxPredicate482 = r_bPtxPredicate476 & r_bPtxPredicate480;							// PTX L1709
	r_bPtxPredicate483 = r_bPtxPredicate477 | r_bPtxPredicate481;							// PTX L1710
	r_bPtxPredicate484 = r_bPtxPredicate482 | r_bPtxPredicate475;							// PTX L1711
	r_bPtxPredicate485 = int32_t(r_PtxRegister80) < int32_t(r_WidthBits);					// PTX L1712
	r_bPtxPredicate486 = !r_bPtxPredicate482;												// PTX L1713
	r_bPtxPredicate26 = r_bPtxPredicate475 & r_bPtxPredicate486;							// PTX L1714
	r_bPtxPredicate487 = r_bPtxPredicate484 | r_bPtxPredicate485;							// PTX L1715
	r_bPtxPredicate488 = r_bPtxPredicate487 & r_bPtxPredicate483;							// PTX L1716
	r_PtxRegister2722 = uint32_t(0);														// PTX L1717
	r_bPtxPredicate489 = !r_bPtxPredicate488;												// PTX L1718
	if (r_bPtxPredicate489)
	{
		goto L__BB18_118;
	} // PTX L1719
	r_PtxRegister821 = r_PtxRegister809 & -4;										// PTX L1720
	r_PtxRegister822 = uint32_t(r_LaneIndexAtPtx1687) - uint32_t(r_PtxRegister821); // PTX L1721
	r_PtxRegister823 = ShiftLeft(uint32_t(r_PtxRegister80), uint32_t(2));			// PTX L1722
	r_PtxRegister824 = r_bPtxPredicate26 ? 0 : r_PtxRegister823;					// PTX L1723
	r_PtxRegister825 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister81); // PTX L1724
	r_PtxRegister826 =
		uint32_t(r_PtxRegister825) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister822); // PTX L1725
	r_PtxRegister827 = uint32_t(r_PtxRegister826) + uint32_t(r_PtxRegister824);				 // PTX L1726
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister827)) * int64_t(int32_t(4))); // PTX L1727
	g_ResidualByteAddressAtPtx1728 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register92);				// PTX L1728
	r_PtxRegister2722 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1728); // PTX L1729
L__BB18_118:																				// PTX L1730
	r_bPtxPredicate490 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1731
	r_bPtxPredicate491 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1732
	r_bPtxPredicate492 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1733
	r_LaneIndexAtPtx1735 = uint32_t((threadIdx.x & 31u));									// PTX L1735
	r_PtxRegister829 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1735), uint32_t(31));		// PTX L1737
	r_PtxRegister830 = ShiftRight(uint32_t(r_PtxRegister829), uint32_t(30));				// PTX L1738
	r_PtxRegister831 = uint32_t(r_LaneIndexAtPtx1735) + uint32_t(r_PtxRegister830);			// PTX L1739
	r_PtxRegister832 = ShiftRightSigned(int32_t(r_PtxRegister831), uint32_t(2));			// PTX L1740
	r_PtxRegister833 = ShiftRight(uint32_t(r_PtxRegister832), uint32_t(30));				// PTX L1741
	r_PtxRegister834 = uint32_t(r_PtxRegister832) + uint32_t(r_PtxRegister833);				// PTX L1742
	r_PtxRegister835 = r_PtxRegister834 & -4;												// PTX L1743
	r_PtxRegister836 = uint32_t(r_PtxRegister832) - uint32_t(r_PtxRegister835);				// PTX L1744
	r_PtxRegister837 = ShiftRight(uint32_t(r_PtxRegister829), uint32_t(28));				// PTX L1745
	r_PtxRegister838 = uint32_t(r_LaneIndexAtPtx1735) + uint32_t(r_PtxRegister837);			// PTX L1746
	r_PtxRegister839 = ShiftRightSigned(int32_t(r_PtxRegister838), uint32_t(4));			// PTX L1747
	r_PtxRegister840 = uint32_t(r_PtxRegister836) + uint32_t(r_PtxRegister5);				// PTX L1748
	r_PtxRegister841 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister839);				// PTX L1749
	r_PtxRegister82 = uint32_t(r_PtxRegister840) + uint32_t(4);								// PTX L1750
	r_bPtxPredicate493 = int32_t(r_PtxRegister841) < int32_t(0);							// PTX L1751
	r_bPtxPredicate494 = int32_t(r_PtxRegister841) >= int32_t(r_HeightBits);				// PTX L1752
	r_bPtxPredicate495 = r_bPtxPredicate493 | r_bPtxPredicate494;							// PTX L1753
	r_bPtxPredicate496 = !r_bPtxPredicate495;												// PTX L1754
	r_PtxRegister83 = r_bPtxPredicate492 ? 0 : r_PtxRegister841;							// PTX L1755
	r_bPtxPredicate497 = r_bPtxPredicate491 & r_bPtxPredicate495;							// PTX L1756
	r_bPtxPredicate498 = r_bPtxPredicate492 | r_bPtxPredicate496;							// PTX L1757
	r_bPtxPredicate499 = r_bPtxPredicate497 | r_bPtxPredicate490;							// PTX L1758
	r_bPtxPredicate500 = int32_t(r_PtxRegister82) < int32_t(r_WidthBits);					// PTX L1759
	r_bPtxPredicate501 = !r_bPtxPredicate497;												// PTX L1760
	r_bPtxPredicate27 = r_bPtxPredicate490 & r_bPtxPredicate501;							// PTX L1761
	r_bPtxPredicate502 = r_bPtxPredicate499 | r_bPtxPredicate500;							// PTX L1762
	r_bPtxPredicate503 = r_bPtxPredicate502 & r_bPtxPredicate498;							// PTX L1763
	r_PtxRegister2723 = uint32_t(0);														// PTX L1764
	r_bPtxPredicate504 = !r_bPtxPredicate503;												// PTX L1765
	if (r_bPtxPredicate504)
	{
		goto L__BB18_120;
	} // PTX L1766
	r_PtxRegister842 = r_PtxRegister831 & -4;										// PTX L1767
	r_PtxRegister843 = uint32_t(r_LaneIndexAtPtx1735) - uint32_t(r_PtxRegister842); // PTX L1768
	r_PtxRegister844 = ShiftLeft(uint32_t(r_PtxRegister82), uint32_t(2));			// PTX L1769
	r_PtxRegister845 = r_bPtxPredicate27 ? 0 : r_PtxRegister844;					// PTX L1770
	r_PtxRegister846 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister83); // PTX L1771
	r_PtxRegister847 =
		uint32_t(r_PtxRegister846) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister843); // PTX L1772
	r_PtxRegister848 = uint32_t(r_PtxRegister847) + uint32_t(r_PtxRegister845);				 // PTX L1773
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister848)) * int64_t(int32_t(4))); // PTX L1774
	g_ResidualByteAddressAtPtx1775 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register94);				// PTX L1775
	r_PtxRegister2723 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1775); // PTX L1776
L__BB18_120:																				// PTX L1777
	r_bPtxPredicate505 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1778
	r_bPtxPredicate506 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1779
	r_bPtxPredicate507 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1780
	r_LaneIndexAtPtx1782 = uint32_t((threadIdx.x & 31u));									// PTX L1782
	r_PtxRegister850 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1782), uint32_t(31));		// PTX L1784
	r_PtxRegister851 = ShiftRight(uint32_t(r_PtxRegister850), uint32_t(30));				// PTX L1785
	r_PtxRegister852 = uint32_t(r_LaneIndexAtPtx1782) + uint32_t(r_PtxRegister851);			// PTX L1786
	r_PtxRegister853 = ShiftRightSigned(int32_t(r_PtxRegister852), uint32_t(2));			// PTX L1787
	r_PtxRegister854 = ShiftRight(uint32_t(r_PtxRegister853), uint32_t(30));				// PTX L1788
	r_PtxRegister855 = uint32_t(r_PtxRegister853) + uint32_t(r_PtxRegister854);				// PTX L1789
	r_PtxRegister856 = r_PtxRegister855 & -4;												// PTX L1790
	r_PtxRegister857 = uint32_t(r_PtxRegister853) - uint32_t(r_PtxRegister856);				// PTX L1791
	r_PtxRegister858 = ShiftRight(uint32_t(r_PtxRegister850), uint32_t(28));				// PTX L1792
	r_PtxRegister859 = uint32_t(r_LaneIndexAtPtx1782) + uint32_t(r_PtxRegister858);			// PTX L1793
	r_PtxRegister860 = ShiftRightSigned(int32_t(r_PtxRegister859), uint32_t(4));			// PTX L1794
	r_PtxRegister861 = uint32_t(r_PtxRegister860) + uint32_t(r_PtxRegister4);				// PTX L1795
	r_PtxRegister862 = uint32_t(r_PtxRegister857) + uint32_t(r_PtxRegister5);				// PTX L1796
	r_PtxRegister863 = uint32_t(r_PtxRegister861) + uint32_t(2);							// PTX L1797
	r_PtxRegister84 = uint32_t(r_PtxRegister862) + uint32_t(4);								// PTX L1798
	r_bPtxPredicate508 = int32_t(r_PtxRegister863) < int32_t(0);							// PTX L1799
	r_bPtxPredicate509 = int32_t(r_PtxRegister863) >= int32_t(r_HeightBits);				// PTX L1800
	r_bPtxPredicate510 = r_bPtxPredicate508 | r_bPtxPredicate509;							// PTX L1801
	r_bPtxPredicate511 = !r_bPtxPredicate510;												// PTX L1802
	r_PtxRegister85 = r_bPtxPredicate507 ? 0 : r_PtxRegister863;							// PTX L1803
	r_bPtxPredicate512 = r_bPtxPredicate506 & r_bPtxPredicate510;							// PTX L1804
	r_bPtxPredicate513 = r_bPtxPredicate507 | r_bPtxPredicate511;							// PTX L1805
	r_bPtxPredicate514 = r_bPtxPredicate512 | r_bPtxPredicate505;							// PTX L1806
	r_bPtxPredicate515 = int32_t(r_PtxRegister84) < int32_t(r_WidthBits);					// PTX L1807
	r_bPtxPredicate516 = !r_bPtxPredicate512;												// PTX L1808
	r_bPtxPredicate28 = r_bPtxPredicate505 & r_bPtxPredicate516;							// PTX L1809
	r_bPtxPredicate517 = r_bPtxPredicate514 | r_bPtxPredicate515;							// PTX L1810
	r_bPtxPredicate518 = r_bPtxPredicate517 & r_bPtxPredicate513;							// PTX L1811
	r_PtxRegister2724 = uint32_t(0);														// PTX L1812
	r_bPtxPredicate519 = !r_bPtxPredicate518;												// PTX L1813
	if (r_bPtxPredicate519)
	{
		goto L__BB18_122;
	} // PTX L1814
	r_PtxRegister864 = r_PtxRegister852 & -4;										// PTX L1815
	r_PtxRegister865 = uint32_t(r_LaneIndexAtPtx1782) - uint32_t(r_PtxRegister864); // PTX L1816
	r_PtxRegister866 = ShiftLeft(uint32_t(r_PtxRegister84), uint32_t(2));			// PTX L1817
	r_PtxRegister867 = r_bPtxPredicate28 ? 0 : r_PtxRegister866;					// PTX L1818
	r_PtxRegister868 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister85); // PTX L1819
	r_PtxRegister869 =
		uint32_t(r_PtxRegister868) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister865); // PTX L1820
	r_PtxRegister870 = uint32_t(r_PtxRegister869) + uint32_t(r_PtxRegister867);				 // PTX L1821
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_PtxRegister870)) * int64_t(int32_t(4))); // PTX L1822
	g_ResidualByteAddressAtPtx1823 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register96);				// PTX L1823
	r_PtxRegister2724 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1823); // PTX L1824
L__BB18_122:																				// PTX L1825
	r_bPtxPredicate520 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1826
	r_bPtxPredicate521 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1827
	r_bPtxPredicate522 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1828
	r_LaneIndexAtPtx1830 = uint32_t((threadIdx.x & 31u));									// PTX L1830
	r_PtxRegister872 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1830), uint32_t(31));		// PTX L1832
	r_PtxRegister873 = ShiftRight(uint32_t(r_PtxRegister872), uint32_t(30));				// PTX L1833
	r_PtxRegister874 = uint32_t(r_LaneIndexAtPtx1830) + uint32_t(r_PtxRegister873);			// PTX L1834
	r_PtxRegister875 = ShiftRightSigned(int32_t(r_PtxRegister874), uint32_t(2));			// PTX L1835
	r_PtxRegister876 = ShiftRight(uint32_t(r_PtxRegister875), uint32_t(30));				// PTX L1836
	r_PtxRegister877 = uint32_t(r_PtxRegister875) + uint32_t(r_PtxRegister876);				// PTX L1837
	r_PtxRegister878 = r_PtxRegister877 & -4;												// PTX L1838
	r_PtxRegister879 = uint32_t(r_PtxRegister875) - uint32_t(r_PtxRegister878);				// PTX L1839
	r_PtxRegister880 = ShiftRight(uint32_t(r_PtxRegister872), uint32_t(28));				// PTX L1840
	r_PtxRegister881 = uint32_t(r_LaneIndexAtPtx1830) + uint32_t(r_PtxRegister880);			// PTX L1841
	r_PtxRegister882 = ShiftRightSigned(int32_t(r_PtxRegister881), uint32_t(4));			// PTX L1842
	r_PtxRegister883 = uint32_t(r_PtxRegister879) + uint32_t(r_PtxRegister5);				// PTX L1843
	r_PtxRegister884 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister882);				// PTX L1844
	r_PtxRegister86 = uint32_t(r_PtxRegister883) + uint32_t(4);								// PTX L1845
	r_bPtxPredicate523 = int32_t(r_PtxRegister884) < int32_t(0);							// PTX L1846
	r_bPtxPredicate524 = int32_t(r_PtxRegister884) >= int32_t(r_HeightBits);				// PTX L1847
	r_bPtxPredicate525 = r_bPtxPredicate523 | r_bPtxPredicate524;							// PTX L1848
	r_bPtxPredicate526 = !r_bPtxPredicate525;												// PTX L1849
	r_PtxRegister87 = r_bPtxPredicate522 ? 0 : r_PtxRegister884;							// PTX L1850
	r_bPtxPredicate527 = r_bPtxPredicate521 & r_bPtxPredicate525;							// PTX L1851
	r_bPtxPredicate528 = r_bPtxPredicate522 | r_bPtxPredicate526;							// PTX L1852
	r_bPtxPredicate529 = r_bPtxPredicate527 | r_bPtxPredicate520;							// PTX L1853
	r_bPtxPredicate530 = int32_t(r_PtxRegister86) < int32_t(r_WidthBits);					// PTX L1854
	r_bPtxPredicate531 = !r_bPtxPredicate527;												// PTX L1855
	r_bPtxPredicate29 = r_bPtxPredicate520 & r_bPtxPredicate531;							// PTX L1856
	r_bPtxPredicate532 = r_bPtxPredicate529 | r_bPtxPredicate530;							// PTX L1857
	r_bPtxPredicate533 = r_bPtxPredicate532 & r_bPtxPredicate528;							// PTX L1858
	r_PtxRegister2725 = uint32_t(0);														// PTX L1859
	r_bPtxPredicate534 = !r_bPtxPredicate533;												// PTX L1860
	if (r_bPtxPredicate534)
	{
		goto L__BB18_124;
	} // PTX L1861
	r_PtxRegister885 = r_PtxRegister874 & -4;										// PTX L1862
	r_PtxRegister886 = uint32_t(r_LaneIndexAtPtx1830) - uint32_t(r_PtxRegister885); // PTX L1863
	r_PtxRegister887 = ShiftLeft(uint32_t(r_PtxRegister86), uint32_t(2));			// PTX L1864
	r_PtxRegister888 = r_bPtxPredicate29 ? 0 : r_PtxRegister887;					// PTX L1865
	r_PtxRegister889 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister87); // PTX L1866
	r_PtxRegister890 =
		uint32_t(r_PtxRegister889) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister886); // PTX L1867
	r_PtxRegister891 = uint32_t(r_PtxRegister890) + uint32_t(r_PtxRegister888);				 // PTX L1868
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister891)) * int64_t(int32_t(4))); // PTX L1869
	g_ResidualByteAddressAtPtx1870 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register98);				// PTX L1870
	r_PtxRegister2725 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1870); // PTX L1871
L__BB18_124:																				// PTX L1872
	r_bPtxPredicate535 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1873
	r_bPtxPredicate536 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1874
	r_bPtxPredicate537 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1875
	r_LaneIndexAtPtx1877 = uint32_t((threadIdx.x & 31u));									// PTX L1877
	r_PtxRegister893 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1877), uint32_t(31));		// PTX L1879
	r_PtxRegister894 = ShiftRight(uint32_t(r_PtxRegister893), uint32_t(30));				// PTX L1880
	r_PtxRegister895 = uint32_t(r_LaneIndexAtPtx1877) + uint32_t(r_PtxRegister894);			// PTX L1881
	r_PtxRegister896 = ShiftRightSigned(int32_t(r_PtxRegister895), uint32_t(2));			// PTX L1882
	r_PtxRegister897 = ShiftRight(uint32_t(r_PtxRegister896), uint32_t(30));				// PTX L1883
	r_PtxRegister898 = uint32_t(r_PtxRegister896) + uint32_t(r_PtxRegister897);				// PTX L1884
	r_PtxRegister899 = r_PtxRegister898 & -4;												// PTX L1885
	r_PtxRegister900 = uint32_t(r_PtxRegister896) - uint32_t(r_PtxRegister899);				// PTX L1886
	r_PtxRegister901 = ShiftRight(uint32_t(r_PtxRegister893), uint32_t(28));				// PTX L1887
	r_PtxRegister902 = uint32_t(r_LaneIndexAtPtx1877) + uint32_t(r_PtxRegister901);			// PTX L1888
	r_PtxRegister903 = ShiftRightSigned(int32_t(r_PtxRegister902), uint32_t(4));			// PTX L1889
	r_PtxRegister904 = uint32_t(r_PtxRegister903) + uint32_t(r_PtxRegister4);				// PTX L1890
	r_PtxRegister905 = uint32_t(r_PtxRegister900) + uint32_t(r_PtxRegister5);				// PTX L1891
	r_PtxRegister906 = uint32_t(r_PtxRegister904) + uint32_t(2);							// PTX L1892
	r_PtxRegister88 = uint32_t(r_PtxRegister905) + uint32_t(4);								// PTX L1893
	r_bPtxPredicate538 = int32_t(r_PtxRegister906) < int32_t(0);							// PTX L1894
	r_bPtxPredicate539 = int32_t(r_PtxRegister906) >= int32_t(r_HeightBits);				// PTX L1895
	r_bPtxPredicate540 = r_bPtxPredicate538 | r_bPtxPredicate539;							// PTX L1896
	r_bPtxPredicate541 = !r_bPtxPredicate540;												// PTX L1897
	r_PtxRegister89 = r_bPtxPredicate537 ? 0 : r_PtxRegister906;							// PTX L1898
	r_bPtxPredicate542 = r_bPtxPredicate536 & r_bPtxPredicate540;							// PTX L1899
	r_bPtxPredicate543 = r_bPtxPredicate537 | r_bPtxPredicate541;							// PTX L1900
	r_bPtxPredicate544 = r_bPtxPredicate542 | r_bPtxPredicate535;							// PTX L1901
	r_bPtxPredicate545 = int32_t(r_PtxRegister88) < int32_t(r_WidthBits);					// PTX L1902
	r_bPtxPredicate546 = !r_bPtxPredicate542;												// PTX L1903
	r_bPtxPredicate30 = r_bPtxPredicate535 & r_bPtxPredicate546;							// PTX L1904
	r_bPtxPredicate547 = r_bPtxPredicate544 | r_bPtxPredicate545;							// PTX L1905
	r_bPtxPredicate548 = r_bPtxPredicate547 & r_bPtxPredicate543;							// PTX L1906
	r_PtxRegister2726 = uint32_t(0);														// PTX L1907
	r_bPtxPredicate549 = !r_bPtxPredicate548;												// PTX L1908
	if (r_bPtxPredicate549)
	{
		goto L__BB18_126;
	} // PTX L1909
	r_PtxRegister907 = r_PtxRegister895 & -4;										// PTX L1910
	r_PtxRegister908 = uint32_t(r_LaneIndexAtPtx1877) - uint32_t(r_PtxRegister907); // PTX L1911
	r_PtxRegister909 = ShiftLeft(uint32_t(r_PtxRegister88), uint32_t(2));			// PTX L1912
	r_PtxRegister910 = r_bPtxPredicate30 ? 0 : r_PtxRegister909;					// PTX L1913
	r_PtxRegister911 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister89); // PTX L1914
	r_PtxRegister912 =
		uint32_t(r_PtxRegister911) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister908);  // PTX L1915
	r_PtxRegister913 = uint32_t(r_PtxRegister912) + uint32_t(r_PtxRegister910);				  // PTX L1916
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_PtxRegister913)) * int64_t(int32_t(4))); // PTX L1917
	g_ResidualByteAddressAtPtx1918 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register100);				// PTX L1918
	r_PtxRegister2726 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1918); // PTX L1919
L__BB18_126:																				// PTX L1920
	r_bPtxPredicate550 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1921
	r_bPtxPredicate551 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1922
	r_bPtxPredicate552 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1923
	r_LaneIndexAtPtx1925 = uint32_t((threadIdx.x & 31u));									// PTX L1925
	r_PtxRegister915 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1925), uint32_t(31));		// PTX L1927
	r_PtxRegister916 = ShiftRight(uint32_t(r_PtxRegister915), uint32_t(30));				// PTX L1928
	r_PtxRegister917 = uint32_t(r_LaneIndexAtPtx1925) + uint32_t(r_PtxRegister916);			// PTX L1929
	r_PtxRegister918 = ShiftRightSigned(int32_t(r_PtxRegister917), uint32_t(2));			// PTX L1930
	r_PtxRegister919 = ShiftRight(uint32_t(r_PtxRegister918), uint32_t(30));				// PTX L1931
	r_PtxRegister920 = uint32_t(r_PtxRegister918) + uint32_t(r_PtxRegister919);				// PTX L1932
	r_PtxRegister921 = r_PtxRegister920 & -4;												// PTX L1933
	r_PtxRegister922 = uint32_t(r_PtxRegister918) - uint32_t(r_PtxRegister921);				// PTX L1934
	r_PtxRegister923 = ShiftRight(uint32_t(r_PtxRegister915), uint32_t(28));				// PTX L1935
	r_PtxRegister924 = uint32_t(r_LaneIndexAtPtx1925) + uint32_t(r_PtxRegister923);			// PTX L1936
	r_PtxRegister925 = ShiftRightSigned(int32_t(r_PtxRegister924), uint32_t(4));			// PTX L1937
	r_PtxRegister926 = uint32_t(r_PtxRegister922) + uint32_t(r_PtxRegister5);				// PTX L1938
	r_PtxRegister927 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister925);				// PTX L1939
	r_PtxRegister90 = uint32_t(r_PtxRegister926) + uint32_t(4);								// PTX L1940
	r_bPtxPredicate553 = int32_t(r_PtxRegister927) < int32_t(0);							// PTX L1941
	r_bPtxPredicate554 = int32_t(r_PtxRegister927) >= int32_t(r_HeightBits);				// PTX L1942
	r_bPtxPredicate555 = r_bPtxPredicate553 | r_bPtxPredicate554;							// PTX L1943
	r_bPtxPredicate556 = !r_bPtxPredicate555;												// PTX L1944
	r_PtxRegister91 = r_bPtxPredicate552 ? 0 : r_PtxRegister927;							// PTX L1945
	r_bPtxPredicate557 = r_bPtxPredicate551 & r_bPtxPredicate555;							// PTX L1946
	r_bPtxPredicate558 = r_bPtxPredicate552 | r_bPtxPredicate556;							// PTX L1947
	r_bPtxPredicate559 = r_bPtxPredicate557 | r_bPtxPredicate550;							// PTX L1948
	r_bPtxPredicate560 = int32_t(r_PtxRegister90) < int32_t(r_WidthBits);					// PTX L1949
	r_bPtxPredicate561 = !r_bPtxPredicate557;												// PTX L1950
	r_bPtxPredicate31 = r_bPtxPredicate550 & r_bPtxPredicate561;							// PTX L1951
	r_bPtxPredicate562 = r_bPtxPredicate559 | r_bPtxPredicate560;							// PTX L1952
	r_bPtxPredicate563 = r_bPtxPredicate562 & r_bPtxPredicate558;							// PTX L1953
	r_PtxRegister2727 = uint32_t(0);														// PTX L1954
	r_bPtxPredicate564 = !r_bPtxPredicate563;												// PTX L1955
	if (r_bPtxPredicate564)
	{
		goto L__BB18_128;
	} // PTX L1956
	r_PtxRegister928 = r_PtxRegister917 & -4;										// PTX L1957
	r_PtxRegister929 = uint32_t(r_LaneIndexAtPtx1925) - uint32_t(r_PtxRegister928); // PTX L1958
	r_PtxRegister930 = ShiftLeft(uint32_t(r_PtxRegister90), uint32_t(2));			// PTX L1959
	r_PtxRegister931 = r_bPtxPredicate31 ? 0 : r_PtxRegister930;					// PTX L1960
	r_PtxRegister932 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister91); // PTX L1961
	r_PtxRegister933 =
		uint32_t(r_PtxRegister932) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister929);  // PTX L1962
	r_PtxRegister934 = uint32_t(r_PtxRegister933) + uint32_t(r_PtxRegister931);				  // PTX L1963
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister934)) * int64_t(int32_t(4))); // PTX L1964
	g_ResidualByteAddressAtPtx1965 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register102);				// PTX L1965
	r_PtxRegister2727 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx1965); // PTX L1966
L__BB18_128:																				// PTX L1967
	r_bPtxPredicate565 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L1968
	r_bPtxPredicate566 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L1969
	r_bPtxPredicate567 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L1970
	r_LaneIndexAtPtx1972 = uint32_t((threadIdx.x & 31u));									// PTX L1972
	r_PtxRegister936 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1972), uint32_t(31));		// PTX L1974
	r_PtxRegister937 = ShiftRight(uint32_t(r_PtxRegister936), uint32_t(30));				// PTX L1975
	r_PtxRegister938 = uint32_t(r_LaneIndexAtPtx1972) + uint32_t(r_PtxRegister937);			// PTX L1976
	r_PtxRegister939 = ShiftRightSigned(int32_t(r_PtxRegister938), uint32_t(2));			// PTX L1977
	r_PtxRegister940 = ShiftRight(uint32_t(r_PtxRegister939), uint32_t(30));				// PTX L1978
	r_PtxRegister941 = uint32_t(r_PtxRegister939) + uint32_t(r_PtxRegister940);				// PTX L1979
	r_PtxRegister942 = r_PtxRegister941 & -4;												// PTX L1980
	r_PtxRegister943 = uint32_t(r_PtxRegister939) - uint32_t(r_PtxRegister942);				// PTX L1981
	r_PtxRegister944 = ShiftRight(uint32_t(r_PtxRegister936), uint32_t(28));				// PTX L1982
	r_PtxRegister945 = uint32_t(r_LaneIndexAtPtx1972) + uint32_t(r_PtxRegister944);			// PTX L1983
	r_PtxRegister946 = ShiftRightSigned(int32_t(r_PtxRegister945), uint32_t(4));			// PTX L1984
	r_PtxRegister947 = uint32_t(r_PtxRegister946) + uint32_t(r_PtxRegister4);				// PTX L1985
	r_PtxRegister948 = uint32_t(r_PtxRegister943) + uint32_t(r_PtxRegister5);				// PTX L1986
	r_PtxRegister949 = uint32_t(r_PtxRegister947) + uint32_t(2);							// PTX L1987
	r_PtxRegister92 = uint32_t(r_PtxRegister948) + uint32_t(4);								// PTX L1988
	r_bPtxPredicate568 = int32_t(r_PtxRegister949) < int32_t(0);							// PTX L1989
	r_bPtxPredicate569 = int32_t(r_PtxRegister949) >= int32_t(r_HeightBits);				// PTX L1990
	r_bPtxPredicate570 = r_bPtxPredicate568 | r_bPtxPredicate569;							// PTX L1991
	r_bPtxPredicate571 = !r_bPtxPredicate570;												// PTX L1992
	r_PtxRegister93 = r_bPtxPredicate567 ? 0 : r_PtxRegister949;							// PTX L1993
	r_bPtxPredicate572 = r_bPtxPredicate566 & r_bPtxPredicate570;							// PTX L1994
	r_bPtxPredicate573 = r_bPtxPredicate567 | r_bPtxPredicate571;							// PTX L1995
	r_bPtxPredicate574 = r_bPtxPredicate572 | r_bPtxPredicate565;							// PTX L1996
	r_bPtxPredicate575 = int32_t(r_PtxRegister92) < int32_t(r_WidthBits);					// PTX L1997
	r_bPtxPredicate576 = !r_bPtxPredicate572;												// PTX L1998
	r_bPtxPredicate32 = r_bPtxPredicate565 & r_bPtxPredicate576;							// PTX L1999
	r_bPtxPredicate577 = r_bPtxPredicate574 | r_bPtxPredicate575;							// PTX L2000
	r_bPtxPredicate578 = r_bPtxPredicate577 & r_bPtxPredicate573;							// PTX L2001
	r_PtxRegister2728 = uint32_t(0);														// PTX L2002
	r_bPtxPredicate579 = !r_bPtxPredicate578;												// PTX L2003
	if (r_bPtxPredicate579)
	{
		goto L__BB18_130;
	} // PTX L2004
	r_PtxRegister950 = r_PtxRegister938 & -4;										// PTX L2005
	r_PtxRegister951 = uint32_t(r_LaneIndexAtPtx1972) - uint32_t(r_PtxRegister950); // PTX L2006
	r_PtxRegister952 = ShiftLeft(uint32_t(r_PtxRegister92), uint32_t(2));			// PTX L2007
	r_PtxRegister953 = r_bPtxPredicate32 ? 0 : r_PtxRegister952;					// PTX L2008
	r_PtxRegister954 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister93); // PTX L2009
	r_PtxRegister955 =
		uint32_t(r_PtxRegister954) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister951);  // PTX L2010
	r_PtxRegister956 = uint32_t(r_PtxRegister955) + uint32_t(r_PtxRegister953);				  // PTX L2011
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_PtxRegister956)) * int64_t(int32_t(4))); // PTX L2012
	g_ResidualByteAddressAtPtx2013 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register104);				// PTX L2013
	r_PtxRegister2728 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2013); // PTX L2014
L__BB18_130:																				// PTX L2015
	r_bPtxPredicate580 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2016
	r_bPtxPredicate581 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2017
	r_bPtxPredicate582 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2018
	r_LaneIndexAtPtx2020 = uint32_t((threadIdx.x & 31u));									// PTX L2020
	r_PtxRegister958 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2020), uint32_t(31));		// PTX L2022
	r_PtxRegister959 = ShiftRight(uint32_t(r_PtxRegister958), uint32_t(30));				// PTX L2023
	r_PtxRegister960 = uint32_t(r_LaneIndexAtPtx2020) + uint32_t(r_PtxRegister959);			// PTX L2024
	r_PtxRegister961 = ShiftRightSigned(int32_t(r_PtxRegister960), uint32_t(2));			// PTX L2025
	r_PtxRegister962 = ShiftRight(uint32_t(r_PtxRegister961), uint32_t(30));				// PTX L2026
	r_PtxRegister963 = uint32_t(r_PtxRegister961) + uint32_t(r_PtxRegister962);				// PTX L2027
	r_PtxRegister964 = r_PtxRegister963 & -4;												// PTX L2028
	r_PtxRegister965 = uint32_t(r_PtxRegister961) - uint32_t(r_PtxRegister964);				// PTX L2029
	r_PtxRegister966 = ShiftRight(uint32_t(r_PtxRegister958), uint32_t(28));				// PTX L2030
	r_PtxRegister967 = uint32_t(r_LaneIndexAtPtx2020) + uint32_t(r_PtxRegister966);			// PTX L2031
	r_PtxRegister968 = ShiftRightSigned(int32_t(r_PtxRegister967), uint32_t(4));			// PTX L2032
	r_PtxRegister969 = uint32_t(r_PtxRegister965) + uint32_t(r_PtxRegister5);				// PTX L2033
	r_PtxRegister970 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister968);				// PTX L2034
	r_PtxRegister94 = uint32_t(r_PtxRegister969) + uint32_t(4);								// PTX L2035
	r_bPtxPredicate583 = int32_t(r_PtxRegister970) < int32_t(0);							// PTX L2036
	r_bPtxPredicate584 = int32_t(r_PtxRegister970) >= int32_t(r_HeightBits);				// PTX L2037
	r_bPtxPredicate585 = r_bPtxPredicate583 | r_bPtxPredicate584;							// PTX L2038
	r_bPtxPredicate586 = !r_bPtxPredicate585;												// PTX L2039
	r_PtxRegister95 = r_bPtxPredicate582 ? 0 : r_PtxRegister970;							// PTX L2040
	r_bPtxPredicate587 = r_bPtxPredicate581 & r_bPtxPredicate585;							// PTX L2041
	r_bPtxPredicate588 = r_bPtxPredicate582 | r_bPtxPredicate586;							// PTX L2042
	r_bPtxPredicate589 = r_bPtxPredicate587 | r_bPtxPredicate580;							// PTX L2043
	r_bPtxPredicate590 = int32_t(r_PtxRegister94) < int32_t(r_WidthBits);					// PTX L2044
	r_bPtxPredicate591 = !r_bPtxPredicate587;												// PTX L2045
	r_bPtxPredicate33 = r_bPtxPredicate580 & r_bPtxPredicate591;							// PTX L2046
	r_bPtxPredicate592 = r_bPtxPredicate589 | r_bPtxPredicate590;							// PTX L2047
	r_bPtxPredicate593 = r_bPtxPredicate592 & r_bPtxPredicate588;							// PTX L2048
	r_PtxRegister2729 = uint32_t(0);														// PTX L2049
	r_bPtxPredicate594 = !r_bPtxPredicate593;												// PTX L2050
	if (r_bPtxPredicate594)
	{
		goto L__BB18_132;
	} // PTX L2051
	r_PtxRegister971 = r_PtxRegister960 & -4;										// PTX L2052
	r_PtxRegister972 = uint32_t(r_LaneIndexAtPtx2020) - uint32_t(r_PtxRegister971); // PTX L2053
	r_PtxRegister973 = ShiftLeft(uint32_t(r_PtxRegister94), uint32_t(2));			// PTX L2054
	r_PtxRegister974 = r_bPtxPredicate33 ? 0 : r_PtxRegister973;					// PTX L2055
	r_PtxRegister975 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister95); // PTX L2056
	r_PtxRegister976 =
		uint32_t(r_PtxRegister975) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister972);  // PTX L2057
	r_PtxRegister977 = uint32_t(r_PtxRegister976) + uint32_t(r_PtxRegister974);				  // PTX L2058
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister977)) * int64_t(int32_t(4))); // PTX L2059
	g_ResidualByteAddressAtPtx2060 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register106);				// PTX L2060
	r_PtxRegister2729 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2060); // PTX L2061
L__BB18_132:																				// PTX L2062
	r_bPtxPredicate595 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2063
	r_bPtxPredicate596 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2064
	r_bPtxPredicate597 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2065
	r_LaneIndexAtPtx2067 = uint32_t((threadIdx.x & 31u));									// PTX L2067
	r_PtxRegister979 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2067), uint32_t(31));		// PTX L2069
	r_PtxRegister980 = ShiftRight(uint32_t(r_PtxRegister979), uint32_t(30));				// PTX L2070
	r_PtxRegister981 = uint32_t(r_LaneIndexAtPtx2067) + uint32_t(r_PtxRegister980);			// PTX L2071
	r_PtxRegister982 = ShiftRightSigned(int32_t(r_PtxRegister981), uint32_t(2));			// PTX L2072
	r_PtxRegister983 = ShiftRight(uint32_t(r_PtxRegister982), uint32_t(30));				// PTX L2073
	r_PtxRegister984 = uint32_t(r_PtxRegister982) + uint32_t(r_PtxRegister983);				// PTX L2074
	r_PtxRegister985 = r_PtxRegister984 & -4;												// PTX L2075
	r_PtxRegister986 = uint32_t(r_PtxRegister982) - uint32_t(r_PtxRegister985);				// PTX L2076
	r_PtxRegister987 = ShiftRight(uint32_t(r_PtxRegister979), uint32_t(28));				// PTX L2077
	r_PtxRegister988 = uint32_t(r_LaneIndexAtPtx2067) + uint32_t(r_PtxRegister987);			// PTX L2078
	r_PtxRegister989 = ShiftRightSigned(int32_t(r_PtxRegister988), uint32_t(4));			// PTX L2079
	r_PtxRegister990 = uint32_t(r_PtxRegister989) + uint32_t(r_PtxRegister4);				// PTX L2080
	r_PtxRegister991 = uint32_t(r_PtxRegister986) + uint32_t(r_PtxRegister5);				// PTX L2081
	r_PtxRegister992 = uint32_t(r_PtxRegister990) + uint32_t(2);							// PTX L2082
	r_PtxRegister96 = uint32_t(r_PtxRegister991) + uint32_t(4);								// PTX L2083
	r_bPtxPredicate598 = int32_t(r_PtxRegister992) < int32_t(0);							// PTX L2084
	r_bPtxPredicate599 = int32_t(r_PtxRegister992) >= int32_t(r_HeightBits);				// PTX L2085
	r_bPtxPredicate600 = r_bPtxPredicate598 | r_bPtxPredicate599;							// PTX L2086
	r_bPtxPredicate601 = !r_bPtxPredicate600;												// PTX L2087
	r_PtxRegister97 = r_bPtxPredicate597 ? 0 : r_PtxRegister992;							// PTX L2088
	r_bPtxPredicate602 = r_bPtxPredicate596 & r_bPtxPredicate600;							// PTX L2089
	r_bPtxPredicate603 = r_bPtxPredicate597 | r_bPtxPredicate601;							// PTX L2090
	r_bPtxPredicate604 = r_bPtxPredicate602 | r_bPtxPredicate595;							// PTX L2091
	r_bPtxPredicate605 = int32_t(r_PtxRegister96) < int32_t(r_WidthBits);					// PTX L2092
	r_bPtxPredicate606 = !r_bPtxPredicate602;												// PTX L2093
	r_bPtxPredicate34 = r_bPtxPredicate595 & r_bPtxPredicate606;							// PTX L2094
	r_bPtxPredicate607 = r_bPtxPredicate604 | r_bPtxPredicate605;							// PTX L2095
	r_bPtxPredicate608 = r_bPtxPredicate607 & r_bPtxPredicate603;							// PTX L2096
	r_PtxRegister2730 = uint32_t(0);														// PTX L2097
	r_bPtxPredicate609 = !r_bPtxPredicate608;												// PTX L2098
	if (r_bPtxPredicate609)
	{
		goto L__BB18_134;
	} // PTX L2099
	r_PtxRegister993 = r_PtxRegister981 & -4;										// PTX L2100
	r_PtxRegister994 = uint32_t(r_LaneIndexAtPtx2067) - uint32_t(r_PtxRegister993); // PTX L2101
	r_PtxRegister995 = ShiftLeft(uint32_t(r_PtxRegister96), uint32_t(2));			// PTX L2102
	r_PtxRegister996 = r_bPtxPredicate34 ? 0 : r_PtxRegister995;					// PTX L2103
	r_PtxRegister997 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister97); // PTX L2104
	r_PtxRegister998 =
		uint32_t(r_PtxRegister997) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister994);  // PTX L2105
	r_PtxRegister999 = uint32_t(r_PtxRegister998) + uint32_t(r_PtxRegister996);				  // PTX L2106
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_PtxRegister999)) * int64_t(int32_t(4))); // PTX L2107
	g_ResidualByteAddressAtPtx2108 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register108);				// PTX L2108
	r_PtxRegister2730 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2108); // PTX L2109
L__BB18_134:																				// PTX L2110
	r_bPtxPredicate610 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2111
	r_bPtxPredicate611 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2112
	r_bPtxPredicate612 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2113
	r_LaneIndexAtPtx2115 = uint32_t((threadIdx.x & 31u));									// PTX L2115
	r_PtxRegister1001 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2115), uint32_t(31));		// PTX L2117
	r_PtxRegister1002 = ShiftRight(uint32_t(r_PtxRegister1001), uint32_t(30));				// PTX L2118
	r_PtxRegister1003 = uint32_t(r_LaneIndexAtPtx2115) + uint32_t(r_PtxRegister1002);		// PTX L2119
	r_PtxRegister1004 = ShiftRightSigned(int32_t(r_PtxRegister1003), uint32_t(2));			// PTX L2120
	r_PtxRegister1005 = ShiftRight(uint32_t(r_PtxRegister1004), uint32_t(30));				// PTX L2121
	r_PtxRegister1006 = uint32_t(r_PtxRegister1004) + uint32_t(r_PtxRegister1005);			// PTX L2122
	r_PtxRegister1007 = r_PtxRegister1006 & -4;												// PTX L2123
	r_PtxRegister1008 = uint32_t(r_PtxRegister1004) - uint32_t(r_PtxRegister1007);			// PTX L2124
	r_PtxRegister1009 = ShiftRight(uint32_t(r_PtxRegister1001), uint32_t(28));				// PTX L2125
	r_PtxRegister1010 = uint32_t(r_LaneIndexAtPtx2115) + uint32_t(r_PtxRegister1009);		// PTX L2126
	r_PtxRegister1011 = ShiftRightSigned(int32_t(r_PtxRegister1010), uint32_t(4));			// PTX L2127
	r_PtxRegister1012 = uint32_t(r_PtxRegister1011) + uint32_t(r_PtxRegister4);				// PTX L2128
	r_PtxRegister1013 = uint32_t(r_PtxRegister1012) + uint32_t(4);							// PTX L2129
	r_PtxRegister98 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1008);				// PTX L2130
	r_bPtxPredicate613 = int32_t(r_PtxRegister1013) < int32_t(0);							// PTX L2131
	r_bPtxPredicate614 = int32_t(r_PtxRegister1013) >= int32_t(r_HeightBits);				// PTX L2132
	r_bPtxPredicate615 = r_bPtxPredicate613 | r_bPtxPredicate614;							// PTX L2133
	r_bPtxPredicate616 = !r_bPtxPredicate615;												// PTX L2134
	r_PtxRegister99 = r_bPtxPredicate612 ? 0 : r_PtxRegister1013;							// PTX L2135
	r_bPtxPredicate617 = r_bPtxPredicate611 & r_bPtxPredicate615;							// PTX L2136
	r_bPtxPredicate618 = r_bPtxPredicate612 | r_bPtxPredicate616;							// PTX L2137
	r_bPtxPredicate619 = r_bPtxPredicate617 | r_bPtxPredicate610;							// PTX L2138
	r_bPtxPredicate620 = int32_t(r_PtxRegister98) > int32_t(-1);							// PTX L2139
	r_bPtxPredicate621 = int32_t(r_PtxRegister98) < int32_t(r_WidthBits);					// PTX L2140
	r_bPtxPredicate622 = r_bPtxPredicate620 & r_bPtxPredicate621;							// PTX L2141
	r_bPtxPredicate623 = !r_bPtxPredicate617;												// PTX L2142
	r_bPtxPredicate35 = r_bPtxPredicate610 & r_bPtxPredicate623;							// PTX L2143
	r_bPtxPredicate624 = r_bPtxPredicate619 | r_bPtxPredicate622;							// PTX L2144
	r_bPtxPredicate625 = r_bPtxPredicate624 & r_bPtxPredicate618;							// PTX L2145
	r_PtxRegister2731 = uint32_t(0);														// PTX L2146
	r_bPtxPredicate626 = !r_bPtxPredicate625;												// PTX L2147
	if (r_bPtxPredicate626)
	{
		goto L__BB18_136;
	} // PTX L2148
	r_PtxRegister1014 = r_PtxRegister1003 & -4;										  // PTX L2149
	r_PtxRegister1015 = uint32_t(r_LaneIndexAtPtx2115) - uint32_t(r_PtxRegister1014); // PTX L2150
	r_PtxRegister1016 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(2));			  // PTX L2151
	r_PtxRegister1017 = r_bPtxPredicate35 ? 0 : r_PtxRegister1016;					  // PTX L2152
	r_PtxRegister1018 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister99); // PTX L2153
	r_PtxRegister1019 =
		uint32_t(r_PtxRegister1018) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1015); // PTX L2154
	r_PtxRegister1020 = uint32_t(r_PtxRegister1019) + uint32_t(r_PtxRegister1017);			   // PTX L2155
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister1020)) * int64_t(int32_t(4))); // PTX L2156
	g_ResidualByteAddressAtPtx2157 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register110);				// PTX L2157
	r_PtxRegister2731 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2157); // PTX L2158
L__BB18_136:																				// PTX L2159
	r_bPtxPredicate627 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2160
	r_bPtxPredicate628 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2161
	r_bPtxPredicate629 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2162
	r_LaneIndexAtPtx2164 = uint32_t((threadIdx.x & 31u));									// PTX L2164
	r_PtxRegister1022 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2164), uint32_t(31));		// PTX L2166
	r_PtxRegister1023 = ShiftRight(uint32_t(r_PtxRegister1022), uint32_t(30));				// PTX L2167
	r_PtxRegister1024 = uint32_t(r_LaneIndexAtPtx2164) + uint32_t(r_PtxRegister1023);		// PTX L2168
	r_PtxRegister1025 = ShiftRightSigned(int32_t(r_PtxRegister1024), uint32_t(2));			// PTX L2169
	r_PtxRegister1026 = ShiftRight(uint32_t(r_PtxRegister1025), uint32_t(30));				// PTX L2170
	r_PtxRegister1027 = uint32_t(r_PtxRegister1025) + uint32_t(r_PtxRegister1026);			// PTX L2171
	r_PtxRegister1028 = r_PtxRegister1027 & -4;												// PTX L2172
	r_PtxRegister1029 = uint32_t(r_PtxRegister1025) - uint32_t(r_PtxRegister1028);			// PTX L2173
	r_PtxRegister1030 = ShiftRight(uint32_t(r_PtxRegister1022), uint32_t(28));				// PTX L2174
	r_PtxRegister1031 = uint32_t(r_LaneIndexAtPtx2164) + uint32_t(r_PtxRegister1030);		// PTX L2175
	r_PtxRegister1032 = ShiftRightSigned(int32_t(r_PtxRegister1031), uint32_t(4));			// PTX L2176
	r_PtxRegister1033 = uint32_t(r_PtxRegister1032) + uint32_t(r_PtxRegister4);				// PTX L2177
	r_PtxRegister1034 = uint32_t(r_PtxRegister1033) + uint32_t(6);							// PTX L2178
	r_PtxRegister100 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1029);				// PTX L2179
	r_bPtxPredicate630 = int32_t(r_PtxRegister1034) < int32_t(0);							// PTX L2180
	r_bPtxPredicate631 = int32_t(r_PtxRegister1034) >= int32_t(r_HeightBits);				// PTX L2181
	r_bPtxPredicate632 = r_bPtxPredicate630 | r_bPtxPredicate631;							// PTX L2182
	r_bPtxPredicate633 = !r_bPtxPredicate632;												// PTX L2183
	r_PtxRegister101 = r_bPtxPredicate629 ? 0 : r_PtxRegister1034;							// PTX L2184
	r_bPtxPredicate634 = r_bPtxPredicate628 & r_bPtxPredicate632;							// PTX L2185
	r_bPtxPredicate635 = r_bPtxPredicate629 | r_bPtxPredicate633;							// PTX L2186
	r_bPtxPredicate636 = r_bPtxPredicate634 | r_bPtxPredicate627;							// PTX L2187
	r_bPtxPredicate637 = int32_t(r_PtxRegister100) > int32_t(-1);							// PTX L2188
	r_bPtxPredicate638 = int32_t(r_PtxRegister100) < int32_t(r_WidthBits);					// PTX L2189
	r_bPtxPredicate639 = r_bPtxPredicate637 & r_bPtxPredicate638;							// PTX L2190
	r_bPtxPredicate640 = !r_bPtxPredicate634;												// PTX L2191
	r_bPtxPredicate36 = r_bPtxPredicate627 & r_bPtxPredicate640;							// PTX L2192
	r_bPtxPredicate641 = r_bPtxPredicate636 | r_bPtxPredicate639;							// PTX L2193
	r_bPtxPredicate642 = r_bPtxPredicate641 & r_bPtxPredicate635;							// PTX L2194
	r_PtxRegister2732 = uint32_t(0);														// PTX L2195
	r_bPtxPredicate643 = !r_bPtxPredicate642;												// PTX L2196
	if (r_bPtxPredicate643)
	{
		goto L__BB18_138;
	} // PTX L2197
	r_PtxRegister1035 = r_PtxRegister1024 & -4;										  // PTX L2198
	r_PtxRegister1036 = uint32_t(r_LaneIndexAtPtx2164) - uint32_t(r_PtxRegister1035); // PTX L2199
	r_PtxRegister1037 = ShiftLeft(uint32_t(r_PtxRegister100), uint32_t(2));			  // PTX L2200
	r_PtxRegister1038 = r_bPtxPredicate36 ? 0 : r_PtxRegister1037;					  // PTX L2201
	r_PtxRegister1039 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister101); // PTX L2202
	r_PtxRegister1040 =
		uint32_t(r_PtxRegister1039) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1036); // PTX L2203
	r_PtxRegister1041 = uint32_t(r_PtxRegister1040) + uint32_t(r_PtxRegister1038);			   // PTX L2204
	r_PtxU64Register112 = uint64_t(int64_t(int32_t(r_PtxRegister1041)) * int64_t(int32_t(4))); // PTX L2205
	g_ResidualByteAddressAtPtx2206 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register112);				// PTX L2206
	r_PtxRegister2732 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2206); // PTX L2207
L__BB18_138:																				// PTX L2208
	r_bPtxPredicate644 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2209
	r_bPtxPredicate645 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2210
	r_bPtxPredicate646 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2211
	r_LaneIndexAtPtx2213 = uint32_t((threadIdx.x & 31u));									// PTX L2213
	r_PtxRegister1043 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2213), uint32_t(31));		// PTX L2215
	r_PtxRegister1044 = ShiftRight(uint32_t(r_PtxRegister1043), uint32_t(30));				// PTX L2216
	r_PtxRegister1045 = uint32_t(r_LaneIndexAtPtx2213) + uint32_t(r_PtxRegister1044);		// PTX L2217
	r_PtxRegister1046 = ShiftRightSigned(int32_t(r_PtxRegister1045), uint32_t(2));			// PTX L2218
	r_PtxRegister1047 = ShiftRight(uint32_t(r_PtxRegister1046), uint32_t(30));				// PTX L2219
	r_PtxRegister1048 = uint32_t(r_PtxRegister1046) + uint32_t(r_PtxRegister1047);			// PTX L2220
	r_PtxRegister1049 = r_PtxRegister1048 & -4;												// PTX L2221
	r_PtxRegister1050 = uint32_t(r_PtxRegister1046) - uint32_t(r_PtxRegister1049);			// PTX L2222
	r_PtxRegister1051 = ShiftRight(uint32_t(r_PtxRegister1043), uint32_t(28));				// PTX L2223
	r_PtxRegister1052 = uint32_t(r_LaneIndexAtPtx2213) + uint32_t(r_PtxRegister1051);		// PTX L2224
	r_PtxRegister1053 = ShiftRightSigned(int32_t(r_PtxRegister1052), uint32_t(4));			// PTX L2225
	r_PtxRegister1054 = uint32_t(r_PtxRegister1053) + uint32_t(r_PtxRegister4);				// PTX L2226
	r_PtxRegister1055 = uint32_t(r_PtxRegister1054) + uint32_t(4);							// PTX L2227
	r_PtxRegister102 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1050);				// PTX L2228
	r_bPtxPredicate647 = int32_t(r_PtxRegister1055) < int32_t(0);							// PTX L2229
	r_bPtxPredicate648 = int32_t(r_PtxRegister1055) >= int32_t(r_HeightBits);				// PTX L2230
	r_bPtxPredicate649 = r_bPtxPredicate647 | r_bPtxPredicate648;							// PTX L2231
	r_bPtxPredicate650 = !r_bPtxPredicate649;												// PTX L2232
	r_PtxRegister103 = r_bPtxPredicate646 ? 0 : r_PtxRegister1055;							// PTX L2233
	r_bPtxPredicate651 = r_bPtxPredicate645 & r_bPtxPredicate649;							// PTX L2234
	r_bPtxPredicate652 = r_bPtxPredicate646 | r_bPtxPredicate650;							// PTX L2235
	r_bPtxPredicate653 = r_bPtxPredicate651 | r_bPtxPredicate644;							// PTX L2236
	r_bPtxPredicate654 = int32_t(r_PtxRegister102) > int32_t(-1);							// PTX L2237
	r_bPtxPredicate655 = int32_t(r_PtxRegister102) < int32_t(r_WidthBits);					// PTX L2238
	r_bPtxPredicate656 = r_bPtxPredicate654 & r_bPtxPredicate655;							// PTX L2239
	r_bPtxPredicate657 = !r_bPtxPredicate651;												// PTX L2240
	r_bPtxPredicate37 = r_bPtxPredicate644 & r_bPtxPredicate657;							// PTX L2241
	r_bPtxPredicate658 = r_bPtxPredicate653 | r_bPtxPredicate656;							// PTX L2242
	r_bPtxPredicate659 = r_bPtxPredicate658 & r_bPtxPredicate652;							// PTX L2243
	r_PtxRegister2733 = uint32_t(0);														// PTX L2244
	r_bPtxPredicate660 = !r_bPtxPredicate659;												// PTX L2245
	if (r_bPtxPredicate660)
	{
		goto L__BB18_140;
	} // PTX L2246
	r_PtxRegister1056 = r_PtxRegister1045 & -4;										  // PTX L2247
	r_PtxRegister1057 = uint32_t(r_LaneIndexAtPtx2213) - uint32_t(r_PtxRegister1056); // PTX L2248
	r_PtxRegister1058 = ShiftLeft(uint32_t(r_PtxRegister102), uint32_t(2));			  // PTX L2249
	r_PtxRegister1059 = r_bPtxPredicate37 ? 0 : r_PtxRegister1058;					  // PTX L2250
	r_PtxRegister1060 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister103); // PTX L2251
	r_PtxRegister1061 =
		uint32_t(r_PtxRegister1060) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1057); // PTX L2252
	r_PtxRegister1062 = uint32_t(r_PtxRegister1061) + uint32_t(r_PtxRegister1059);			   // PTX L2253
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister1062)) * int64_t(int32_t(4))); // PTX L2254
	g_ResidualByteAddressAtPtx2255 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register114);				// PTX L2255
	r_PtxRegister2733 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2255); // PTX L2256
L__BB18_140:																				// PTX L2257
	r_bPtxPredicate661 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2258
	r_bPtxPredicate662 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2259
	r_bPtxPredicate663 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2260
	r_LaneIndexAtPtx2262 = uint32_t((threadIdx.x & 31u));									// PTX L2262
	r_PtxRegister1064 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2262), uint32_t(31));		// PTX L2264
	r_PtxRegister1065 = ShiftRight(uint32_t(r_PtxRegister1064), uint32_t(30));				// PTX L2265
	r_PtxRegister1066 = uint32_t(r_LaneIndexAtPtx2262) + uint32_t(r_PtxRegister1065);		// PTX L2266
	r_PtxRegister1067 = ShiftRightSigned(int32_t(r_PtxRegister1066), uint32_t(2));			// PTX L2267
	r_PtxRegister1068 = ShiftRight(uint32_t(r_PtxRegister1067), uint32_t(30));				// PTX L2268
	r_PtxRegister1069 = uint32_t(r_PtxRegister1067) + uint32_t(r_PtxRegister1068);			// PTX L2269
	r_PtxRegister1070 = r_PtxRegister1069 & -4;												// PTX L2270
	r_PtxRegister1071 = uint32_t(r_PtxRegister1067) - uint32_t(r_PtxRegister1070);			// PTX L2271
	r_PtxRegister1072 = ShiftRight(uint32_t(r_PtxRegister1064), uint32_t(28));				// PTX L2272
	r_PtxRegister1073 = uint32_t(r_LaneIndexAtPtx2262) + uint32_t(r_PtxRegister1072);		// PTX L2273
	r_PtxRegister1074 = ShiftRightSigned(int32_t(r_PtxRegister1073), uint32_t(4));			// PTX L2274
	r_PtxRegister1075 = uint32_t(r_PtxRegister1074) + uint32_t(r_PtxRegister4);				// PTX L2275
	r_PtxRegister1076 = uint32_t(r_PtxRegister1075) + uint32_t(6);							// PTX L2276
	r_PtxRegister104 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1071);				// PTX L2277
	r_bPtxPredicate664 = int32_t(r_PtxRegister1076) < int32_t(0);							// PTX L2278
	r_bPtxPredicate665 = int32_t(r_PtxRegister1076) >= int32_t(r_HeightBits);				// PTX L2279
	r_bPtxPredicate666 = r_bPtxPredicate664 | r_bPtxPredicate665;							// PTX L2280
	r_bPtxPredicate667 = !r_bPtxPredicate666;												// PTX L2281
	r_PtxRegister105 = r_bPtxPredicate663 ? 0 : r_PtxRegister1076;							// PTX L2282
	r_bPtxPredicate668 = r_bPtxPredicate662 & r_bPtxPredicate666;							// PTX L2283
	r_bPtxPredicate669 = r_bPtxPredicate663 | r_bPtxPredicate667;							// PTX L2284
	r_bPtxPredicate670 = r_bPtxPredicate668 | r_bPtxPredicate661;							// PTX L2285
	r_bPtxPredicate671 = int32_t(r_PtxRegister104) > int32_t(-1);							// PTX L2286
	r_bPtxPredicate672 = int32_t(r_PtxRegister104) < int32_t(r_WidthBits);					// PTX L2287
	r_bPtxPredicate673 = r_bPtxPredicate671 & r_bPtxPredicate672;							// PTX L2288
	r_bPtxPredicate674 = !r_bPtxPredicate668;												// PTX L2289
	r_bPtxPredicate38 = r_bPtxPredicate661 & r_bPtxPredicate674;							// PTX L2290
	r_bPtxPredicate675 = r_bPtxPredicate670 | r_bPtxPredicate673;							// PTX L2291
	r_bPtxPredicate676 = r_bPtxPredicate675 & r_bPtxPredicate669;							// PTX L2292
	r_PtxRegister2734 = uint32_t(0);														// PTX L2293
	r_bPtxPredicate677 = !r_bPtxPredicate676;												// PTX L2294
	if (r_bPtxPredicate677)
	{
		goto L__BB18_142;
	} // PTX L2295
	r_PtxRegister1077 = r_PtxRegister1066 & -4;										  // PTX L2296
	r_PtxRegister1078 = uint32_t(r_LaneIndexAtPtx2262) - uint32_t(r_PtxRegister1077); // PTX L2297
	r_PtxRegister1079 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(2));			  // PTX L2298
	r_PtxRegister1080 = r_bPtxPredicate38 ? 0 : r_PtxRegister1079;					  // PTX L2299
	r_PtxRegister1081 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister105); // PTX L2300
	r_PtxRegister1082 =
		uint32_t(r_PtxRegister1081) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1078); // PTX L2301
	r_PtxRegister1083 = uint32_t(r_PtxRegister1082) + uint32_t(r_PtxRegister1080);			   // PTX L2302
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister1083)) * int64_t(int32_t(4))); // PTX L2303
	g_ResidualByteAddressAtPtx2304 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register116);				// PTX L2304
	r_PtxRegister2734 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2304); // PTX L2305
L__BB18_142:																				// PTX L2306
	r_bPtxPredicate678 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2307
	r_bPtxPredicate679 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2308
	r_bPtxPredicate680 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2309
	r_LaneIndexAtPtx2311 = uint32_t((threadIdx.x & 31u));									// PTX L2311
	r_PtxRegister1085 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2311), uint32_t(31));		// PTX L2313
	r_PtxRegister1086 = ShiftRight(uint32_t(r_PtxRegister1085), uint32_t(30));				// PTX L2314
	r_PtxRegister1087 = uint32_t(r_LaneIndexAtPtx2311) + uint32_t(r_PtxRegister1086);		// PTX L2315
	r_PtxRegister1088 = ShiftRightSigned(int32_t(r_PtxRegister1087), uint32_t(2));			// PTX L2316
	r_PtxRegister1089 = ShiftRight(uint32_t(r_PtxRegister1088), uint32_t(30));				// PTX L2317
	r_PtxRegister1090 = uint32_t(r_PtxRegister1088) + uint32_t(r_PtxRegister1089);			// PTX L2318
	r_PtxRegister1091 = r_PtxRegister1090 & -4;												// PTX L2319
	r_PtxRegister1092 = uint32_t(r_PtxRegister1088) - uint32_t(r_PtxRegister1091);			// PTX L2320
	r_PtxRegister1093 = ShiftRight(uint32_t(r_PtxRegister1085), uint32_t(28));				// PTX L2321
	r_PtxRegister1094 = uint32_t(r_LaneIndexAtPtx2311) + uint32_t(r_PtxRegister1093);		// PTX L2322
	r_PtxRegister1095 = ShiftRightSigned(int32_t(r_PtxRegister1094), uint32_t(4));			// PTX L2323
	r_PtxRegister1096 = uint32_t(r_PtxRegister1095) + uint32_t(r_PtxRegister4);				// PTX L2324
	r_PtxRegister1097 = uint32_t(r_PtxRegister1096) + uint32_t(4);							// PTX L2325
	r_PtxRegister106 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1092);				// PTX L2326
	r_bPtxPredicate681 = int32_t(r_PtxRegister1097) < int32_t(0);							// PTX L2327
	r_bPtxPredicate682 = int32_t(r_PtxRegister1097) >= int32_t(r_HeightBits);				// PTX L2328
	r_bPtxPredicate683 = r_bPtxPredicate681 | r_bPtxPredicate682;							// PTX L2329
	r_bPtxPredicate684 = !r_bPtxPredicate683;												// PTX L2330
	r_PtxRegister107 = r_bPtxPredicate680 ? 0 : r_PtxRegister1097;							// PTX L2331
	r_bPtxPredicate685 = r_bPtxPredicate679 & r_bPtxPredicate683;							// PTX L2332
	r_bPtxPredicate686 = r_bPtxPredicate680 | r_bPtxPredicate684;							// PTX L2333
	r_bPtxPredicate687 = r_bPtxPredicate685 | r_bPtxPredicate678;							// PTX L2334
	r_bPtxPredicate688 = int32_t(r_PtxRegister106) > int32_t(-1);							// PTX L2335
	r_bPtxPredicate689 = int32_t(r_PtxRegister106) < int32_t(r_WidthBits);					// PTX L2336
	r_bPtxPredicate690 = r_bPtxPredicate688 & r_bPtxPredicate689;							// PTX L2337
	r_bPtxPredicate691 = !r_bPtxPredicate685;												// PTX L2338
	r_bPtxPredicate39 = r_bPtxPredicate678 & r_bPtxPredicate691;							// PTX L2339
	r_bPtxPredicate692 = r_bPtxPredicate687 | r_bPtxPredicate690;							// PTX L2340
	r_bPtxPredicate693 = r_bPtxPredicate692 & r_bPtxPredicate686;							// PTX L2341
	r_PtxRegister2735 = uint32_t(0);														// PTX L2342
	r_bPtxPredicate694 = !r_bPtxPredicate693;												// PTX L2343
	if (r_bPtxPredicate694)
	{
		goto L__BB18_144;
	} // PTX L2344
	r_PtxRegister1098 = r_PtxRegister1087 & -4;										  // PTX L2345
	r_PtxRegister1099 = uint32_t(r_LaneIndexAtPtx2311) - uint32_t(r_PtxRegister1098); // PTX L2346
	r_PtxRegister1100 = ShiftLeft(uint32_t(r_PtxRegister106), uint32_t(2));			  // PTX L2347
	r_PtxRegister1101 = r_bPtxPredicate39 ? 0 : r_PtxRegister1100;					  // PTX L2348
	r_PtxRegister1102 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister107); // PTX L2349
	r_PtxRegister1103 =
		uint32_t(r_PtxRegister1102) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1099); // PTX L2350
	r_PtxRegister1104 = uint32_t(r_PtxRegister1103) + uint32_t(r_PtxRegister1101);			   // PTX L2351
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister1104)) * int64_t(int32_t(4))); // PTX L2352
	g_ResidualByteAddressAtPtx2353 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register118);				// PTX L2353
	r_PtxRegister2735 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2353); // PTX L2354
L__BB18_144:																				// PTX L2355
	r_bPtxPredicate695 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2356
	r_bPtxPredicate696 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2357
	r_bPtxPredicate697 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2358
	r_LaneIndexAtPtx2360 = uint32_t((threadIdx.x & 31u));									// PTX L2360
	r_PtxRegister1106 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2360), uint32_t(31));		// PTX L2362
	r_PtxRegister1107 = ShiftRight(uint32_t(r_PtxRegister1106), uint32_t(30));				// PTX L2363
	r_PtxRegister1108 = uint32_t(r_LaneIndexAtPtx2360) + uint32_t(r_PtxRegister1107);		// PTX L2364
	r_PtxRegister1109 = ShiftRightSigned(int32_t(r_PtxRegister1108), uint32_t(2));			// PTX L2365
	r_PtxRegister1110 = ShiftRight(uint32_t(r_PtxRegister1109), uint32_t(30));				// PTX L2366
	r_PtxRegister1111 = uint32_t(r_PtxRegister1109) + uint32_t(r_PtxRegister1110);			// PTX L2367
	r_PtxRegister1112 = r_PtxRegister1111 & -4;												// PTX L2368
	r_PtxRegister1113 = uint32_t(r_PtxRegister1109) - uint32_t(r_PtxRegister1112);			// PTX L2369
	r_PtxRegister1114 = ShiftRight(uint32_t(r_PtxRegister1106), uint32_t(28));				// PTX L2370
	r_PtxRegister1115 = uint32_t(r_LaneIndexAtPtx2360) + uint32_t(r_PtxRegister1114);		// PTX L2371
	r_PtxRegister1116 = ShiftRightSigned(int32_t(r_PtxRegister1115), uint32_t(4));			// PTX L2372
	r_PtxRegister1117 = uint32_t(r_PtxRegister1116) + uint32_t(r_PtxRegister4);				// PTX L2373
	r_PtxRegister1118 = uint32_t(r_PtxRegister1117) + uint32_t(6);							// PTX L2374
	r_PtxRegister108 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1113);				// PTX L2375
	r_bPtxPredicate698 = int32_t(r_PtxRegister1118) < int32_t(0);							// PTX L2376
	r_bPtxPredicate699 = int32_t(r_PtxRegister1118) >= int32_t(r_HeightBits);				// PTX L2377
	r_bPtxPredicate700 = r_bPtxPredicate698 | r_bPtxPredicate699;							// PTX L2378
	r_bPtxPredicate701 = !r_bPtxPredicate700;												// PTX L2379
	r_PtxRegister109 = r_bPtxPredicate697 ? 0 : r_PtxRegister1118;							// PTX L2380
	r_bPtxPredicate702 = r_bPtxPredicate696 & r_bPtxPredicate700;							// PTX L2381
	r_bPtxPredicate703 = r_bPtxPredicate697 | r_bPtxPredicate701;							// PTX L2382
	r_bPtxPredicate704 = r_bPtxPredicate702 | r_bPtxPredicate695;							// PTX L2383
	r_bPtxPredicate705 = int32_t(r_PtxRegister108) > int32_t(-1);							// PTX L2384
	r_bPtxPredicate706 = int32_t(r_PtxRegister108) < int32_t(r_WidthBits);					// PTX L2385
	r_bPtxPredicate707 = r_bPtxPredicate705 & r_bPtxPredicate706;							// PTX L2386
	r_bPtxPredicate708 = !r_bPtxPredicate702;												// PTX L2387
	r_bPtxPredicate40 = r_bPtxPredicate695 & r_bPtxPredicate708;							// PTX L2388
	r_bPtxPredicate709 = r_bPtxPredicate704 | r_bPtxPredicate707;							// PTX L2389
	r_bPtxPredicate710 = r_bPtxPredicate709 & r_bPtxPredicate703;							// PTX L2390
	r_PtxRegister2736 = uint32_t(0);														// PTX L2391
	r_bPtxPredicate711 = !r_bPtxPredicate710;												// PTX L2392
	if (r_bPtxPredicate711)
	{
		goto L__BB18_146;
	} // PTX L2393
	r_PtxRegister1119 = r_PtxRegister1108 & -4;										  // PTX L2394
	r_PtxRegister1120 = uint32_t(r_LaneIndexAtPtx2360) - uint32_t(r_PtxRegister1119); // PTX L2395
	r_PtxRegister1121 = ShiftLeft(uint32_t(r_PtxRegister108), uint32_t(2));			  // PTX L2396
	r_PtxRegister1122 = r_bPtxPredicate40 ? 0 : r_PtxRegister1121;					  // PTX L2397
	r_PtxRegister1123 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister109); // PTX L2398
	r_PtxRegister1124 =
		uint32_t(r_PtxRegister1123) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1120); // PTX L2399
	r_PtxRegister1125 = uint32_t(r_PtxRegister1124) + uint32_t(r_PtxRegister1122);			   // PTX L2400
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister1125)) * int64_t(int32_t(4))); // PTX L2401
	g_ResidualByteAddressAtPtx2402 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register120);				// PTX L2402
	r_PtxRegister2736 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2402); // PTX L2403
L__BB18_146:																				// PTX L2404
	r_bPtxPredicate712 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2405
	r_bPtxPredicate713 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2406
	r_bPtxPredicate714 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2407
	r_LaneIndexAtPtx2409 = uint32_t((threadIdx.x & 31u));									// PTX L2409
	r_PtxRegister1127 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2409), uint32_t(31));		// PTX L2411
	r_PtxRegister1128 = ShiftRight(uint32_t(r_PtxRegister1127), uint32_t(30));				// PTX L2412
	r_PtxRegister1129 = uint32_t(r_LaneIndexAtPtx2409) + uint32_t(r_PtxRegister1128);		// PTX L2413
	r_PtxRegister1130 = ShiftRightSigned(int32_t(r_PtxRegister1129), uint32_t(2));			// PTX L2414
	r_PtxRegister1131 = ShiftRight(uint32_t(r_PtxRegister1130), uint32_t(30));				// PTX L2415
	r_PtxRegister1132 = uint32_t(r_PtxRegister1130) + uint32_t(r_PtxRegister1131);			// PTX L2416
	r_PtxRegister1133 = r_PtxRegister1132 & -4;												// PTX L2417
	r_PtxRegister1134 = uint32_t(r_PtxRegister1130) - uint32_t(r_PtxRegister1133);			// PTX L2418
	r_PtxRegister1135 = ShiftRight(uint32_t(r_PtxRegister1127), uint32_t(28));				// PTX L2419
	r_PtxRegister1136 = uint32_t(r_LaneIndexAtPtx2409) + uint32_t(r_PtxRegister1135);		// PTX L2420
	r_PtxRegister1137 = ShiftRightSigned(int32_t(r_PtxRegister1136), uint32_t(4));			// PTX L2421
	r_PtxRegister1138 = uint32_t(r_PtxRegister1137) + uint32_t(r_PtxRegister4);				// PTX L2422
	r_PtxRegister1139 = uint32_t(r_PtxRegister1138) + uint32_t(4);							// PTX L2423
	r_PtxRegister110 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1134);				// PTX L2424
	r_bPtxPredicate715 = int32_t(r_PtxRegister1139) < int32_t(0);							// PTX L2425
	r_bPtxPredicate716 = int32_t(r_PtxRegister1139) >= int32_t(r_HeightBits);				// PTX L2426
	r_bPtxPredicate717 = r_bPtxPredicate715 | r_bPtxPredicate716;							// PTX L2427
	r_bPtxPredicate718 = !r_bPtxPredicate717;												// PTX L2428
	r_PtxRegister111 = r_bPtxPredicate714 ? 0 : r_PtxRegister1139;							// PTX L2429
	r_bPtxPredicate719 = r_bPtxPredicate713 & r_bPtxPredicate717;							// PTX L2430
	r_bPtxPredicate720 = r_bPtxPredicate714 | r_bPtxPredicate718;							// PTX L2431
	r_bPtxPredicate721 = r_bPtxPredicate719 | r_bPtxPredicate712;							// PTX L2432
	r_bPtxPredicate722 = int32_t(r_PtxRegister110) > int32_t(-1);							// PTX L2433
	r_bPtxPredicate723 = int32_t(r_PtxRegister110) < int32_t(r_WidthBits);					// PTX L2434
	r_bPtxPredicate724 = r_bPtxPredicate722 & r_bPtxPredicate723;							// PTX L2435
	r_bPtxPredicate725 = !r_bPtxPredicate719;												// PTX L2436
	r_bPtxPredicate41 = r_bPtxPredicate712 & r_bPtxPredicate725;							// PTX L2437
	r_bPtxPredicate726 = r_bPtxPredicate721 | r_bPtxPredicate724;							// PTX L2438
	r_bPtxPredicate727 = r_bPtxPredicate726 & r_bPtxPredicate720;							// PTX L2439
	r_PtxRegister2737 = uint32_t(0);														// PTX L2440
	r_bPtxPredicate728 = !r_bPtxPredicate727;												// PTX L2441
	if (r_bPtxPredicate728)
	{
		goto L__BB18_148;
	} // PTX L2442
	r_PtxRegister1140 = r_PtxRegister1129 & -4;										  // PTX L2443
	r_PtxRegister1141 = uint32_t(r_LaneIndexAtPtx2409) - uint32_t(r_PtxRegister1140); // PTX L2444
	r_PtxRegister1142 = ShiftLeft(uint32_t(r_PtxRegister110), uint32_t(2));			  // PTX L2445
	r_PtxRegister1143 = r_bPtxPredicate41 ? 0 : r_PtxRegister1142;					  // PTX L2446
	r_PtxRegister1144 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister111); // PTX L2447
	r_PtxRegister1145 =
		uint32_t(r_PtxRegister1144) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1141); // PTX L2448
	r_PtxRegister1146 = uint32_t(r_PtxRegister1145) + uint32_t(r_PtxRegister1143);			   // PTX L2449
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister1146)) * int64_t(int32_t(4))); // PTX L2450
	g_ResidualByteAddressAtPtx2451 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register122);				// PTX L2451
	r_PtxRegister2737 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2451); // PTX L2452
L__BB18_148:																				// PTX L2453
	r_bPtxPredicate729 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2454
	r_bPtxPredicate730 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2455
	r_bPtxPredicate731 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2456
	r_LaneIndexAtPtx2458 = uint32_t((threadIdx.x & 31u));									// PTX L2458
	r_PtxRegister1148 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2458), uint32_t(31));		// PTX L2460
	r_PtxRegister1149 = ShiftRight(uint32_t(r_PtxRegister1148), uint32_t(30));				// PTX L2461
	r_PtxRegister1150 = uint32_t(r_LaneIndexAtPtx2458) + uint32_t(r_PtxRegister1149);		// PTX L2462
	r_PtxRegister1151 = ShiftRightSigned(int32_t(r_PtxRegister1150), uint32_t(2));			// PTX L2463
	r_PtxRegister1152 = ShiftRight(uint32_t(r_PtxRegister1151), uint32_t(30));				// PTX L2464
	r_PtxRegister1153 = uint32_t(r_PtxRegister1151) + uint32_t(r_PtxRegister1152);			// PTX L2465
	r_PtxRegister1154 = r_PtxRegister1153 & -4;												// PTX L2466
	r_PtxRegister1155 = uint32_t(r_PtxRegister1151) - uint32_t(r_PtxRegister1154);			// PTX L2467
	r_PtxRegister1156 = ShiftRight(uint32_t(r_PtxRegister1148), uint32_t(28));				// PTX L2468
	r_PtxRegister1157 = uint32_t(r_LaneIndexAtPtx2458) + uint32_t(r_PtxRegister1156);		// PTX L2469
	r_PtxRegister1158 = ShiftRightSigned(int32_t(r_PtxRegister1157), uint32_t(4));			// PTX L2470
	r_PtxRegister1159 = uint32_t(r_PtxRegister1158) + uint32_t(r_PtxRegister4);				// PTX L2471
	r_PtxRegister1160 = uint32_t(r_PtxRegister1159) + uint32_t(6);							// PTX L2472
	r_PtxRegister112 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1155);				// PTX L2473
	r_bPtxPredicate732 = int32_t(r_PtxRegister1160) < int32_t(0);							// PTX L2474
	r_bPtxPredicate733 = int32_t(r_PtxRegister1160) >= int32_t(r_HeightBits);				// PTX L2475
	r_bPtxPredicate734 = r_bPtxPredicate732 | r_bPtxPredicate733;							// PTX L2476
	r_bPtxPredicate735 = !r_bPtxPredicate734;												// PTX L2477
	r_PtxRegister113 = r_bPtxPredicate731 ? 0 : r_PtxRegister1160;							// PTX L2478
	r_bPtxPredicate736 = r_bPtxPredicate730 & r_bPtxPredicate734;							// PTX L2479
	r_bPtxPredicate737 = r_bPtxPredicate731 | r_bPtxPredicate735;							// PTX L2480
	r_bPtxPredicate738 = r_bPtxPredicate736 | r_bPtxPredicate729;							// PTX L2481
	r_bPtxPredicate739 = int32_t(r_PtxRegister112) > int32_t(-1);							// PTX L2482
	r_bPtxPredicate740 = int32_t(r_PtxRegister112) < int32_t(r_WidthBits);					// PTX L2483
	r_bPtxPredicate741 = r_bPtxPredicate739 & r_bPtxPredicate740;							// PTX L2484
	r_bPtxPredicate742 = !r_bPtxPredicate736;												// PTX L2485
	r_bPtxPredicate42 = r_bPtxPredicate729 & r_bPtxPredicate742;							// PTX L2486
	r_bPtxPredicate743 = r_bPtxPredicate738 | r_bPtxPredicate741;							// PTX L2487
	r_bPtxPredicate744 = r_bPtxPredicate743 & r_bPtxPredicate737;							// PTX L2488
	r_PtxRegister2738 = uint32_t(0);														// PTX L2489
	r_bPtxPredicate745 = !r_bPtxPredicate744;												// PTX L2490
	if (r_bPtxPredicate745)
	{
		goto L__BB18_150;
	} // PTX L2491
	r_PtxRegister1161 = r_PtxRegister1150 & -4;										  // PTX L2492
	r_PtxRegister1162 = uint32_t(r_LaneIndexAtPtx2458) - uint32_t(r_PtxRegister1161); // PTX L2493
	r_PtxRegister1163 = ShiftLeft(uint32_t(r_PtxRegister112), uint32_t(2));			  // PTX L2494
	r_PtxRegister1164 = r_bPtxPredicate42 ? 0 : r_PtxRegister1163;					  // PTX L2495
	r_PtxRegister1165 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister113); // PTX L2496
	r_PtxRegister1166 =
		uint32_t(r_PtxRegister1165) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1162); // PTX L2497
	r_PtxRegister1167 = uint32_t(r_PtxRegister1166) + uint32_t(r_PtxRegister1164);			   // PTX L2498
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister1167)) * int64_t(int32_t(4))); // PTX L2499
	g_ResidualByteAddressAtPtx2500 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register124);				// PTX L2500
	r_PtxRegister2738 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2500); // PTX L2501
L__BB18_150:																				// PTX L2502
	r_bPtxPredicate746 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2503
	r_bPtxPredicate747 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2504
	r_bPtxPredicate748 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2505
	r_LaneIndexAtPtx2507 = uint32_t((threadIdx.x & 31u));									// PTX L2507
	r_PtxRegister1169 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2507), uint32_t(31));		// PTX L2509
	r_PtxRegister1170 = ShiftRight(uint32_t(r_PtxRegister1169), uint32_t(30));				// PTX L2510
	r_PtxRegister1171 = uint32_t(r_LaneIndexAtPtx2507) + uint32_t(r_PtxRegister1170);		// PTX L2511
	r_PtxRegister1172 = ShiftRightSigned(int32_t(r_PtxRegister1171), uint32_t(2));			// PTX L2512
	r_PtxRegister1173 = ShiftRight(uint32_t(r_PtxRegister1172), uint32_t(30));				// PTX L2513
	r_PtxRegister1174 = uint32_t(r_PtxRegister1172) + uint32_t(r_PtxRegister1173);			// PTX L2514
	r_PtxRegister1175 = r_PtxRegister1174 & -4;												// PTX L2515
	r_PtxRegister1176 = uint32_t(r_PtxRegister1172) - uint32_t(r_PtxRegister1175);			// PTX L2516
	r_PtxRegister1177 = ShiftRight(uint32_t(r_PtxRegister1169), uint32_t(28));				// PTX L2517
	r_PtxRegister1178 = uint32_t(r_LaneIndexAtPtx2507) + uint32_t(r_PtxRegister1177);		// PTX L2518
	r_PtxRegister1179 = ShiftRightSigned(int32_t(r_PtxRegister1178), uint32_t(4));			// PTX L2519
	r_PtxRegister1180 = uint32_t(r_PtxRegister1179) + uint32_t(r_PtxRegister4);				// PTX L2520
	r_PtxRegister1181 = uint32_t(r_PtxRegister1180) + uint32_t(4);							// PTX L2521
	r_PtxRegister114 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1176);				// PTX L2522
	r_bPtxPredicate749 = int32_t(r_PtxRegister1181) < int32_t(0);							// PTX L2523
	r_bPtxPredicate750 = int32_t(r_PtxRegister1181) >= int32_t(r_HeightBits);				// PTX L2524
	r_bPtxPredicate751 = r_bPtxPredicate749 | r_bPtxPredicate750;							// PTX L2525
	r_bPtxPredicate752 = !r_bPtxPredicate751;												// PTX L2526
	r_PtxRegister115 = r_bPtxPredicate748 ? 0 : r_PtxRegister1181;							// PTX L2527
	r_bPtxPredicate753 = r_bPtxPredicate747 & r_bPtxPredicate751;							// PTX L2528
	r_bPtxPredicate754 = r_bPtxPredicate748 | r_bPtxPredicate752;							// PTX L2529
	r_bPtxPredicate755 = r_bPtxPredicate753 | r_bPtxPredicate746;							// PTX L2530
	r_bPtxPredicate756 = int32_t(r_PtxRegister114) > int32_t(-1);							// PTX L2531
	r_bPtxPredicate757 = int32_t(r_PtxRegister114) < int32_t(r_WidthBits);					// PTX L2532
	r_bPtxPredicate758 = r_bPtxPredicate756 & r_bPtxPredicate757;							// PTX L2533
	r_bPtxPredicate759 = !r_bPtxPredicate753;												// PTX L2534
	r_bPtxPredicate43 = r_bPtxPredicate746 & r_bPtxPredicate759;							// PTX L2535
	r_bPtxPredicate760 = r_bPtxPredicate755 | r_bPtxPredicate758;							// PTX L2536
	r_bPtxPredicate761 = r_bPtxPredicate760 & r_bPtxPredicate754;							// PTX L2537
	r_PtxRegister2739 = uint32_t(0);														// PTX L2538
	r_bPtxPredicate762 = !r_bPtxPredicate761;												// PTX L2539
	if (r_bPtxPredicate762)
	{
		goto L__BB18_152;
	} // PTX L2540
	r_PtxRegister1182 = r_PtxRegister1171 & -4;										  // PTX L2541
	r_PtxRegister1183 = uint32_t(r_LaneIndexAtPtx2507) - uint32_t(r_PtxRegister1182); // PTX L2542
	r_PtxRegister1184 = ShiftLeft(uint32_t(r_PtxRegister114), uint32_t(2));			  // PTX L2543
	r_PtxRegister1185 = r_bPtxPredicate43 ? 0 : r_PtxRegister1184;					  // PTX L2544
	r_PtxRegister1186 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister115); // PTX L2545
	r_PtxRegister1187 =
		uint32_t(r_PtxRegister1186) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1183); // PTX L2546
	r_PtxRegister1188 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1185);			   // PTX L2547
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister1188)) * int64_t(int32_t(4))); // PTX L2548
	g_ResidualByteAddressAtPtx2549 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register126);				// PTX L2549
	r_PtxRegister2739 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2549); // PTX L2550
L__BB18_152:																				// PTX L2551
	r_bPtxPredicate763 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2552
	r_bPtxPredicate764 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2553
	r_bPtxPredicate765 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2554
	r_LaneIndexAtPtx2556 = uint32_t((threadIdx.x & 31u));									// PTX L2556
	r_PtxRegister1190 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2556), uint32_t(31));		// PTX L2558
	r_PtxRegister1191 = ShiftRight(uint32_t(r_PtxRegister1190), uint32_t(30));				// PTX L2559
	r_PtxRegister1192 = uint32_t(r_LaneIndexAtPtx2556) + uint32_t(r_PtxRegister1191);		// PTX L2560
	r_PtxRegister1193 = ShiftRightSigned(int32_t(r_PtxRegister1192), uint32_t(2));			// PTX L2561
	r_PtxRegister1194 = ShiftRight(uint32_t(r_PtxRegister1193), uint32_t(30));				// PTX L2562
	r_PtxRegister1195 = uint32_t(r_PtxRegister1193) + uint32_t(r_PtxRegister1194);			// PTX L2563
	r_PtxRegister1196 = r_PtxRegister1195 & -4;												// PTX L2564
	r_PtxRegister1197 = uint32_t(r_PtxRegister1193) - uint32_t(r_PtxRegister1196);			// PTX L2565
	r_PtxRegister1198 = ShiftRight(uint32_t(r_PtxRegister1190), uint32_t(28));				// PTX L2566
	r_PtxRegister1199 = uint32_t(r_LaneIndexAtPtx2556) + uint32_t(r_PtxRegister1198);		// PTX L2567
	r_PtxRegister1200 = ShiftRightSigned(int32_t(r_PtxRegister1199), uint32_t(4));			// PTX L2568
	r_PtxRegister1201 = uint32_t(r_PtxRegister1200) + uint32_t(r_PtxRegister4);				// PTX L2569
	r_PtxRegister1202 = uint32_t(r_PtxRegister1201) + uint32_t(6);							// PTX L2570
	r_PtxRegister116 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1197);				// PTX L2571
	r_bPtxPredicate766 = int32_t(r_PtxRegister1202) < int32_t(0);							// PTX L2572
	r_bPtxPredicate767 = int32_t(r_PtxRegister1202) >= int32_t(r_HeightBits);				// PTX L2573
	r_bPtxPredicate768 = r_bPtxPredicate766 | r_bPtxPredicate767;							// PTX L2574
	r_bPtxPredicate769 = !r_bPtxPredicate768;												// PTX L2575
	r_PtxRegister117 = r_bPtxPredicate765 ? 0 : r_PtxRegister1202;							// PTX L2576
	r_bPtxPredicate770 = r_bPtxPredicate764 & r_bPtxPredicate768;							// PTX L2577
	r_bPtxPredicate771 = r_bPtxPredicate765 | r_bPtxPredicate769;							// PTX L2578
	r_bPtxPredicate772 = r_bPtxPredicate770 | r_bPtxPredicate763;							// PTX L2579
	r_bPtxPredicate773 = int32_t(r_PtxRegister116) > int32_t(-1);							// PTX L2580
	r_bPtxPredicate774 = int32_t(r_PtxRegister116) < int32_t(r_WidthBits);					// PTX L2581
	r_bPtxPredicate775 = r_bPtxPredicate773 & r_bPtxPredicate774;							// PTX L2582
	r_bPtxPredicate776 = !r_bPtxPredicate770;												// PTX L2583
	r_bPtxPredicate44 = r_bPtxPredicate763 & r_bPtxPredicate776;							// PTX L2584
	r_bPtxPredicate777 = r_bPtxPredicate772 | r_bPtxPredicate775;							// PTX L2585
	r_bPtxPredicate778 = r_bPtxPredicate777 & r_bPtxPredicate771;							// PTX L2586
	r_PtxRegister2740 = uint32_t(0);														// PTX L2587
	r_bPtxPredicate779 = !r_bPtxPredicate778;												// PTX L2588
	if (r_bPtxPredicate779)
	{
		goto L__BB18_154;
	} // PTX L2589
	r_PtxRegister1203 = r_PtxRegister1192 & -4;										  // PTX L2590
	r_PtxRegister1204 = uint32_t(r_LaneIndexAtPtx2556) - uint32_t(r_PtxRegister1203); // PTX L2591
	r_PtxRegister1205 = ShiftLeft(uint32_t(r_PtxRegister116), uint32_t(2));			  // PTX L2592
	r_PtxRegister1206 = r_bPtxPredicate44 ? 0 : r_PtxRegister1205;					  // PTX L2593
	r_PtxRegister1207 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister117); // PTX L2594
	r_PtxRegister1208 =
		uint32_t(r_PtxRegister1207) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1204); // PTX L2595
	r_PtxRegister1209 = uint32_t(r_PtxRegister1208) + uint32_t(r_PtxRegister1206);			   // PTX L2596
	r_PtxU64Register128 = uint64_t(int64_t(int32_t(r_PtxRegister1209)) * int64_t(int32_t(4))); // PTX L2597
	g_ResidualByteAddressAtPtx2598 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register128);				// PTX L2598
	r_PtxRegister2740 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2598); // PTX L2599
L__BB18_154:																				// PTX L2600
	r_bPtxPredicate780 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2601
	r_bPtxPredicate781 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2602
	r_bPtxPredicate782 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2603
	r_LaneIndexAtPtx2605 = uint32_t((threadIdx.x & 31u));									// PTX L2605
	r_PtxRegister1211 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2605), uint32_t(31));		// PTX L2607
	r_PtxRegister1212 = ShiftRight(uint32_t(r_PtxRegister1211), uint32_t(30));				// PTX L2608
	r_PtxRegister1213 = uint32_t(r_LaneIndexAtPtx2605) + uint32_t(r_PtxRegister1212);		// PTX L2609
	r_PtxRegister1214 = ShiftRightSigned(int32_t(r_PtxRegister1213), uint32_t(2));			// PTX L2610
	r_PtxRegister1215 = ShiftRight(uint32_t(r_PtxRegister1214), uint32_t(30));				// PTX L2611
	r_PtxRegister1216 = uint32_t(r_PtxRegister1214) + uint32_t(r_PtxRegister1215);			// PTX L2612
	r_PtxRegister1217 = r_PtxRegister1216 & -4;												// PTX L2613
	r_PtxRegister1218 = uint32_t(r_PtxRegister1214) - uint32_t(r_PtxRegister1217);			// PTX L2614
	r_PtxRegister1219 = ShiftRight(uint32_t(r_PtxRegister1211), uint32_t(28));				// PTX L2615
	r_PtxRegister1220 = uint32_t(r_LaneIndexAtPtx2605) + uint32_t(r_PtxRegister1219);		// PTX L2616
	r_PtxRegister1221 = ShiftRightSigned(int32_t(r_PtxRegister1220), uint32_t(4));			// PTX L2617
	r_PtxRegister1222 = uint32_t(r_PtxRegister1221) + uint32_t(r_PtxRegister4);				// PTX L2618
	r_PtxRegister1223 = uint32_t(r_PtxRegister1222) + uint32_t(4);							// PTX L2619
	r_PtxRegister118 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1218);				// PTX L2620
	r_bPtxPredicate783 = int32_t(r_PtxRegister1223) < int32_t(0);							// PTX L2621
	r_bPtxPredicate784 = int32_t(r_PtxRegister1223) >= int32_t(r_HeightBits);				// PTX L2622
	r_bPtxPredicate785 = r_bPtxPredicate783 | r_bPtxPredicate784;							// PTX L2623
	r_bPtxPredicate786 = !r_bPtxPredicate785;												// PTX L2624
	r_PtxRegister119 = r_bPtxPredicate782 ? 0 : r_PtxRegister1223;							// PTX L2625
	r_bPtxPredicate787 = r_bPtxPredicate781 & r_bPtxPredicate785;							// PTX L2626
	r_bPtxPredicate788 = r_bPtxPredicate782 | r_bPtxPredicate786;							// PTX L2627
	r_bPtxPredicate789 = r_bPtxPredicate787 | r_bPtxPredicate780;							// PTX L2628
	r_bPtxPredicate790 = int32_t(r_PtxRegister118) > int32_t(-1);							// PTX L2629
	r_bPtxPredicate791 = int32_t(r_PtxRegister118) < int32_t(r_WidthBits);					// PTX L2630
	r_bPtxPredicate792 = r_bPtxPredicate790 & r_bPtxPredicate791;							// PTX L2631
	r_bPtxPredicate793 = !r_bPtxPredicate787;												// PTX L2632
	r_bPtxPredicate45 = r_bPtxPredicate780 & r_bPtxPredicate793;							// PTX L2633
	r_bPtxPredicate794 = r_bPtxPredicate789 | r_bPtxPredicate792;							// PTX L2634
	r_bPtxPredicate795 = r_bPtxPredicate794 & r_bPtxPredicate788;							// PTX L2635
	r_PtxRegister2741 = uint32_t(0);														// PTX L2636
	r_bPtxPredicate796 = !r_bPtxPredicate795;												// PTX L2637
	if (r_bPtxPredicate796)
	{
		goto L__BB18_156;
	} // PTX L2638
	r_PtxRegister1224 = r_PtxRegister1213 & -4;										  // PTX L2639
	r_PtxRegister1225 = uint32_t(r_LaneIndexAtPtx2605) - uint32_t(r_PtxRegister1224); // PTX L2640
	r_PtxRegister1226 = ShiftLeft(uint32_t(r_PtxRegister118), uint32_t(2));			  // PTX L2641
	r_PtxRegister1227 = r_bPtxPredicate45 ? 0 : r_PtxRegister1226;					  // PTX L2642
	r_PtxRegister1228 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister119); // PTX L2643
	r_PtxRegister1229 =
		uint32_t(r_PtxRegister1228) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1225); // PTX L2644
	r_PtxRegister1230 = uint32_t(r_PtxRegister1229) + uint32_t(r_PtxRegister1227);			   // PTX L2645
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister1230)) * int64_t(int32_t(4))); // PTX L2646
	g_ResidualByteAddressAtPtx2647 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register130);				// PTX L2647
	r_PtxRegister2741 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2647); // PTX L2648
L__BB18_156:																				// PTX L2649
	r_bPtxPredicate797 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2650
	r_bPtxPredicate798 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2651
	r_bPtxPredicate799 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2652
	r_LaneIndexAtPtx2654 = uint32_t((threadIdx.x & 31u));									// PTX L2654
	r_PtxRegister1232 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2654), uint32_t(31));		// PTX L2656
	r_PtxRegister1233 = ShiftRight(uint32_t(r_PtxRegister1232), uint32_t(30));				// PTX L2657
	r_PtxRegister1234 = uint32_t(r_LaneIndexAtPtx2654) + uint32_t(r_PtxRegister1233);		// PTX L2658
	r_PtxRegister1235 = ShiftRightSigned(int32_t(r_PtxRegister1234), uint32_t(2));			// PTX L2659
	r_PtxRegister1236 = ShiftRight(uint32_t(r_PtxRegister1235), uint32_t(30));				// PTX L2660
	r_PtxRegister1237 = uint32_t(r_PtxRegister1235) + uint32_t(r_PtxRegister1236);			// PTX L2661
	r_PtxRegister1238 = r_PtxRegister1237 & -4;												// PTX L2662
	r_PtxRegister1239 = uint32_t(r_PtxRegister1235) - uint32_t(r_PtxRegister1238);			// PTX L2663
	r_PtxRegister1240 = ShiftRight(uint32_t(r_PtxRegister1232), uint32_t(28));				// PTX L2664
	r_PtxRegister1241 = uint32_t(r_LaneIndexAtPtx2654) + uint32_t(r_PtxRegister1240);		// PTX L2665
	r_PtxRegister1242 = ShiftRightSigned(int32_t(r_PtxRegister1241), uint32_t(4));			// PTX L2666
	r_PtxRegister1243 = uint32_t(r_PtxRegister1242) + uint32_t(r_PtxRegister4);				// PTX L2667
	r_PtxRegister1244 = uint32_t(r_PtxRegister1243) + uint32_t(6);							// PTX L2668
	r_PtxRegister120 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1239);				// PTX L2669
	r_bPtxPredicate800 = int32_t(r_PtxRegister1244) < int32_t(0);							// PTX L2670
	r_bPtxPredicate801 = int32_t(r_PtxRegister1244) >= int32_t(r_HeightBits);				// PTX L2671
	r_bPtxPredicate802 = r_bPtxPredicate800 | r_bPtxPredicate801;							// PTX L2672
	r_bPtxPredicate803 = !r_bPtxPredicate802;												// PTX L2673
	r_PtxRegister121 = r_bPtxPredicate799 ? 0 : r_PtxRegister1244;							// PTX L2674
	r_bPtxPredicate804 = r_bPtxPredicate798 & r_bPtxPredicate802;							// PTX L2675
	r_bPtxPredicate805 = r_bPtxPredicate799 | r_bPtxPredicate803;							// PTX L2676
	r_bPtxPredicate806 = r_bPtxPredicate804 | r_bPtxPredicate797;							// PTX L2677
	r_bPtxPredicate807 = int32_t(r_PtxRegister120) > int32_t(-1);							// PTX L2678
	r_bPtxPredicate808 = int32_t(r_PtxRegister120) < int32_t(r_WidthBits);					// PTX L2679
	r_bPtxPredicate809 = r_bPtxPredicate807 & r_bPtxPredicate808;							// PTX L2680
	r_bPtxPredicate810 = !r_bPtxPredicate804;												// PTX L2681
	r_bPtxPredicate46 = r_bPtxPredicate797 & r_bPtxPredicate810;							// PTX L2682
	r_bPtxPredicate811 = r_bPtxPredicate806 | r_bPtxPredicate809;							// PTX L2683
	r_bPtxPredicate812 = r_bPtxPredicate811 & r_bPtxPredicate805;							// PTX L2684
	r_PtxRegister2742 = uint32_t(0);														// PTX L2685
	r_bPtxPredicate813 = !r_bPtxPredicate812;												// PTX L2686
	if (r_bPtxPredicate813)
	{
		goto L__BB18_158;
	} // PTX L2687
	r_PtxRegister1245 = r_PtxRegister1234 & -4;										  // PTX L2688
	r_PtxRegister1246 = uint32_t(r_LaneIndexAtPtx2654) - uint32_t(r_PtxRegister1245); // PTX L2689
	r_PtxRegister1247 = ShiftLeft(uint32_t(r_PtxRegister120), uint32_t(2));			  // PTX L2690
	r_PtxRegister1248 = r_bPtxPredicate46 ? 0 : r_PtxRegister1247;					  // PTX L2691
	r_PtxRegister1249 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister121); // PTX L2692
	r_PtxRegister1250 =
		uint32_t(r_PtxRegister1249) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1246); // PTX L2693
	r_PtxRegister1251 = uint32_t(r_PtxRegister1250) + uint32_t(r_PtxRegister1248);			   // PTX L2694
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister1251)) * int64_t(int32_t(4))); // PTX L2695
	g_ResidualByteAddressAtPtx2696 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register132);				// PTX L2696
	r_PtxRegister2742 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2696); // PTX L2697
L__BB18_158:																				// PTX L2698
	r_bPtxPredicate814 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2699
	r_bPtxPredicate815 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2700
	r_bPtxPredicate816 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2701
	r_LaneIndexAtPtx2703 = uint32_t((threadIdx.x & 31u));									// PTX L2703
	r_PtxRegister1253 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2703), uint32_t(31));		// PTX L2705
	r_PtxRegister1254 = ShiftRight(uint32_t(r_PtxRegister1253), uint32_t(30));				// PTX L2706
	r_PtxRegister1255 = uint32_t(r_LaneIndexAtPtx2703) + uint32_t(r_PtxRegister1254);		// PTX L2707
	r_PtxRegister1256 = ShiftRightSigned(int32_t(r_PtxRegister1255), uint32_t(2));			// PTX L2708
	r_PtxRegister1257 = ShiftRight(uint32_t(r_PtxRegister1256), uint32_t(30));				// PTX L2709
	r_PtxRegister1258 = uint32_t(r_PtxRegister1256) + uint32_t(r_PtxRegister1257);			// PTX L2710
	r_PtxRegister1259 = r_PtxRegister1258 & -4;												// PTX L2711
	r_PtxRegister1260 = uint32_t(r_PtxRegister1256) - uint32_t(r_PtxRegister1259);			// PTX L2712
	r_PtxRegister1261 = ShiftRight(uint32_t(r_PtxRegister1253), uint32_t(28));				// PTX L2713
	r_PtxRegister1262 = uint32_t(r_LaneIndexAtPtx2703) + uint32_t(r_PtxRegister1261);		// PTX L2714
	r_PtxRegister1263 = ShiftRightSigned(int32_t(r_PtxRegister1262), uint32_t(4));			// PTX L2715
	r_PtxRegister1264 = uint32_t(r_PtxRegister1263) + uint32_t(r_PtxRegister4);				// PTX L2716
	r_PtxRegister1265 = uint32_t(r_PtxRegister1264) + uint32_t(4);							// PTX L2717
	r_PtxRegister122 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1260);				// PTX L2718
	r_bPtxPredicate817 = int32_t(r_PtxRegister1265) < int32_t(0);							// PTX L2719
	r_bPtxPredicate818 = int32_t(r_PtxRegister1265) >= int32_t(r_HeightBits);				// PTX L2720
	r_bPtxPredicate819 = r_bPtxPredicate817 | r_bPtxPredicate818;							// PTX L2721
	r_bPtxPredicate820 = !r_bPtxPredicate819;												// PTX L2722
	r_PtxRegister123 = r_bPtxPredicate816 ? 0 : r_PtxRegister1265;							// PTX L2723
	r_bPtxPredicate821 = r_bPtxPredicate815 & r_bPtxPredicate819;							// PTX L2724
	r_bPtxPredicate822 = r_bPtxPredicate816 | r_bPtxPredicate820;							// PTX L2725
	r_bPtxPredicate823 = r_bPtxPredicate821 | r_bPtxPredicate814;							// PTX L2726
	r_bPtxPredicate824 = int32_t(r_PtxRegister122) > int32_t(-1);							// PTX L2727
	r_bPtxPredicate825 = int32_t(r_PtxRegister122) < int32_t(r_WidthBits);					// PTX L2728
	r_bPtxPredicate826 = r_bPtxPredicate824 & r_bPtxPredicate825;							// PTX L2729
	r_bPtxPredicate827 = !r_bPtxPredicate821;												// PTX L2730
	r_bPtxPredicate47 = r_bPtxPredicate814 & r_bPtxPredicate827;							// PTX L2731
	r_bPtxPredicate828 = r_bPtxPredicate823 | r_bPtxPredicate826;							// PTX L2732
	r_bPtxPredicate829 = r_bPtxPredicate828 & r_bPtxPredicate822;							// PTX L2733
	r_PtxRegister2743 = uint32_t(0);														// PTX L2734
	r_bPtxPredicate830 = !r_bPtxPredicate829;												// PTX L2735
	if (r_bPtxPredicate830)
	{
		goto L__BB18_160;
	} // PTX L2736
	r_PtxRegister1266 = r_PtxRegister1255 & -4;										  // PTX L2737
	r_PtxRegister1267 = uint32_t(r_LaneIndexAtPtx2703) - uint32_t(r_PtxRegister1266); // PTX L2738
	r_PtxRegister1268 = ShiftLeft(uint32_t(r_PtxRegister122), uint32_t(2));			  // PTX L2739
	r_PtxRegister1269 = r_bPtxPredicate47 ? 0 : r_PtxRegister1268;					  // PTX L2740
	r_PtxRegister1270 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister123); // PTX L2741
	r_PtxRegister1271 =
		uint32_t(r_PtxRegister1270) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1267); // PTX L2742
	r_PtxRegister1272 = uint32_t(r_PtxRegister1271) + uint32_t(r_PtxRegister1269);			   // PTX L2743
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister1272)) * int64_t(int32_t(4))); // PTX L2744
	g_ResidualByteAddressAtPtx2745 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register134);				// PTX L2745
	r_PtxRegister2743 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2745); // PTX L2746
L__BB18_160:																				// PTX L2747
	r_bPtxPredicate831 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2748
	r_bPtxPredicate832 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2749
	r_bPtxPredicate833 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2750
	r_LaneIndexAtPtx2752 = uint32_t((threadIdx.x & 31u));									// PTX L2752
	r_PtxRegister1274 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2752), uint32_t(31));		// PTX L2754
	r_PtxRegister1275 = ShiftRight(uint32_t(r_PtxRegister1274), uint32_t(30));				// PTX L2755
	r_PtxRegister1276 = uint32_t(r_LaneIndexAtPtx2752) + uint32_t(r_PtxRegister1275);		// PTX L2756
	r_PtxRegister1277 = ShiftRightSigned(int32_t(r_PtxRegister1276), uint32_t(2));			// PTX L2757
	r_PtxRegister1278 = ShiftRight(uint32_t(r_PtxRegister1277), uint32_t(30));				// PTX L2758
	r_PtxRegister1279 = uint32_t(r_PtxRegister1277) + uint32_t(r_PtxRegister1278);			// PTX L2759
	r_PtxRegister1280 = r_PtxRegister1279 & -4;												// PTX L2760
	r_PtxRegister1281 = uint32_t(r_PtxRegister1277) - uint32_t(r_PtxRegister1280);			// PTX L2761
	r_PtxRegister1282 = ShiftRight(uint32_t(r_PtxRegister1274), uint32_t(28));				// PTX L2762
	r_PtxRegister1283 = uint32_t(r_LaneIndexAtPtx2752) + uint32_t(r_PtxRegister1282);		// PTX L2763
	r_PtxRegister1284 = ShiftRightSigned(int32_t(r_PtxRegister1283), uint32_t(4));			// PTX L2764
	r_PtxRegister1285 = uint32_t(r_PtxRegister1284) + uint32_t(r_PtxRegister4);				// PTX L2765
	r_PtxRegister1286 = uint32_t(r_PtxRegister1285) + uint32_t(6);							// PTX L2766
	r_PtxRegister124 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1281);				// PTX L2767
	r_bPtxPredicate834 = int32_t(r_PtxRegister1286) < int32_t(0);							// PTX L2768
	r_bPtxPredicate835 = int32_t(r_PtxRegister1286) >= int32_t(r_HeightBits);				// PTX L2769
	r_bPtxPredicate836 = r_bPtxPredicate834 | r_bPtxPredicate835;							// PTX L2770
	r_bPtxPredicate837 = !r_bPtxPredicate836;												// PTX L2771
	r_PtxRegister125 = r_bPtxPredicate833 ? 0 : r_PtxRegister1286;							// PTX L2772
	r_bPtxPredicate838 = r_bPtxPredicate832 & r_bPtxPredicate836;							// PTX L2773
	r_bPtxPredicate839 = r_bPtxPredicate833 | r_bPtxPredicate837;							// PTX L2774
	r_bPtxPredicate840 = r_bPtxPredicate838 | r_bPtxPredicate831;							// PTX L2775
	r_bPtxPredicate841 = int32_t(r_PtxRegister124) > int32_t(-1);							// PTX L2776
	r_bPtxPredicate842 = int32_t(r_PtxRegister124) < int32_t(r_WidthBits);					// PTX L2777
	r_bPtxPredicate843 = r_bPtxPredicate841 & r_bPtxPredicate842;							// PTX L2778
	r_bPtxPredicate844 = !r_bPtxPredicate838;												// PTX L2779
	r_bPtxPredicate48 = r_bPtxPredicate831 & r_bPtxPredicate844;							// PTX L2780
	r_bPtxPredicate845 = r_bPtxPredicate840 | r_bPtxPredicate843;							// PTX L2781
	r_bPtxPredicate846 = r_bPtxPredicate845 & r_bPtxPredicate839;							// PTX L2782
	r_PtxRegister2744 = uint32_t(0);														// PTX L2783
	r_bPtxPredicate847 = !r_bPtxPredicate846;												// PTX L2784
	if (r_bPtxPredicate847)
	{
		goto L__BB18_162;
	} // PTX L2785
	r_PtxRegister1287 = r_PtxRegister1276 & -4;										  // PTX L2786
	r_PtxRegister1288 = uint32_t(r_LaneIndexAtPtx2752) - uint32_t(r_PtxRegister1287); // PTX L2787
	r_PtxRegister1289 = ShiftLeft(uint32_t(r_PtxRegister124), uint32_t(2));			  // PTX L2788
	r_PtxRegister1290 = r_bPtxPredicate48 ? 0 : r_PtxRegister1289;					  // PTX L2789
	r_PtxRegister1291 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister125); // PTX L2790
	r_PtxRegister1292 =
		uint32_t(r_PtxRegister1291) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1288); // PTX L2791
	r_PtxRegister1293 = uint32_t(r_PtxRegister1292) + uint32_t(r_PtxRegister1290);			   // PTX L2792
	r_PtxU64Register136 = uint64_t(int64_t(int32_t(r_PtxRegister1293)) * int64_t(int32_t(4))); // PTX L2793
	g_ResidualByteAddressAtPtx2794 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register136);				// PTX L2794
	r_PtxRegister2744 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2794); // PTX L2795
L__BB18_162:																				// PTX L2796
	r_bPtxPredicate848 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2797
	r_bPtxPredicate849 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2798
	r_bPtxPredicate850 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2799
	r_LaneIndexAtPtx2801 = uint32_t((threadIdx.x & 31u));									// PTX L2801
	r_PtxRegister1295 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2801), uint32_t(31));		// PTX L2803
	r_PtxRegister1296 = ShiftRight(uint32_t(r_PtxRegister1295), uint32_t(30));				// PTX L2804
	r_PtxRegister1297 = uint32_t(r_LaneIndexAtPtx2801) + uint32_t(r_PtxRegister1296);		// PTX L2805
	r_PtxRegister1298 = ShiftRightSigned(int32_t(r_PtxRegister1297), uint32_t(2));			// PTX L2806
	r_PtxRegister1299 = ShiftRight(uint32_t(r_PtxRegister1298), uint32_t(30));				// PTX L2807
	r_PtxRegister1300 = uint32_t(r_PtxRegister1298) + uint32_t(r_PtxRegister1299);			// PTX L2808
	r_PtxRegister1301 = r_PtxRegister1300 & -4;												// PTX L2809
	r_PtxRegister1302 = uint32_t(r_PtxRegister1298) - uint32_t(r_PtxRegister1301);			// PTX L2810
	r_PtxRegister1303 = ShiftRight(uint32_t(r_PtxRegister1295), uint32_t(28));				// PTX L2811
	r_PtxRegister1304 = uint32_t(r_LaneIndexAtPtx2801) + uint32_t(r_PtxRegister1303);		// PTX L2812
	r_PtxRegister1305 = ShiftRightSigned(int32_t(r_PtxRegister1304), uint32_t(4));			// PTX L2813
	r_PtxRegister1306 = uint32_t(r_PtxRegister1305) + uint32_t(r_PtxRegister4);				// PTX L2814
	r_PtxRegister1307 = uint32_t(r_PtxRegister1306) + uint32_t(4);							// PTX L2815
	r_PtxRegister126 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1302);				// PTX L2816
	r_bPtxPredicate851 = int32_t(r_PtxRegister1307) < int32_t(0);							// PTX L2817
	r_bPtxPredicate852 = int32_t(r_PtxRegister1307) >= int32_t(r_HeightBits);				// PTX L2818
	r_bPtxPredicate853 = r_bPtxPredicate851 | r_bPtxPredicate852;							// PTX L2819
	r_bPtxPredicate854 = !r_bPtxPredicate853;												// PTX L2820
	r_PtxRegister127 = r_bPtxPredicate850 ? 0 : r_PtxRegister1307;							// PTX L2821
	r_bPtxPredicate855 = r_bPtxPredicate849 & r_bPtxPredicate853;							// PTX L2822
	r_bPtxPredicate856 = r_bPtxPredicate850 | r_bPtxPredicate854;							// PTX L2823
	r_bPtxPredicate857 = r_bPtxPredicate855 | r_bPtxPredicate848;							// PTX L2824
	r_bPtxPredicate858 = int32_t(r_PtxRegister126) > int32_t(-1);							// PTX L2825
	r_bPtxPredicate859 = int32_t(r_PtxRegister126) < int32_t(r_WidthBits);					// PTX L2826
	r_bPtxPredicate860 = r_bPtxPredicate858 & r_bPtxPredicate859;							// PTX L2827
	r_bPtxPredicate861 = !r_bPtxPredicate855;												// PTX L2828
	r_bPtxPredicate49 = r_bPtxPredicate848 & r_bPtxPredicate861;							// PTX L2829
	r_bPtxPredicate862 = r_bPtxPredicate857 | r_bPtxPredicate860;							// PTX L2830
	r_bPtxPredicate863 = r_bPtxPredicate862 & r_bPtxPredicate856;							// PTX L2831
	r_PtxRegister2745 = uint32_t(0);														// PTX L2832
	r_bPtxPredicate864 = !r_bPtxPredicate863;												// PTX L2833
	if (r_bPtxPredicate864)
	{
		goto L__BB18_164;
	} // PTX L2834
	r_PtxRegister1308 = r_PtxRegister1297 & -4;										  // PTX L2835
	r_PtxRegister1309 = uint32_t(r_LaneIndexAtPtx2801) - uint32_t(r_PtxRegister1308); // PTX L2836
	r_PtxRegister1310 = ShiftLeft(uint32_t(r_PtxRegister126), uint32_t(2));			  // PTX L2837
	r_PtxRegister1311 = r_bPtxPredicate49 ? 0 : r_PtxRegister1310;					  // PTX L2838
	r_PtxRegister1312 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister127); // PTX L2839
	r_PtxRegister1313 =
		uint32_t(r_PtxRegister1312) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1309); // PTX L2840
	r_PtxRegister1314 = uint32_t(r_PtxRegister1313) + uint32_t(r_PtxRegister1311);			   // PTX L2841
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister1314)) * int64_t(int32_t(4))); // PTX L2842
	g_ResidualByteAddressAtPtx2843 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register138);				// PTX L2843
	r_PtxRegister2745 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2843); // PTX L2844
L__BB18_164:																				// PTX L2845
	r_bPtxPredicate865 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2846
	r_bPtxPredicate866 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2847
	r_bPtxPredicate867 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2848
	r_LaneIndexAtPtx2850 = uint32_t((threadIdx.x & 31u));									// PTX L2850
	r_PtxRegister1316 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2850), uint32_t(31));		// PTX L2852
	r_PtxRegister1317 = ShiftRight(uint32_t(r_PtxRegister1316), uint32_t(30));				// PTX L2853
	r_PtxRegister1318 = uint32_t(r_LaneIndexAtPtx2850) + uint32_t(r_PtxRegister1317);		// PTX L2854
	r_PtxRegister1319 = ShiftRightSigned(int32_t(r_PtxRegister1318), uint32_t(2));			// PTX L2855
	r_PtxRegister1320 = ShiftRight(uint32_t(r_PtxRegister1319), uint32_t(30));				// PTX L2856
	r_PtxRegister1321 = uint32_t(r_PtxRegister1319) + uint32_t(r_PtxRegister1320);			// PTX L2857
	r_PtxRegister1322 = r_PtxRegister1321 & -4;												// PTX L2858
	r_PtxRegister1323 = uint32_t(r_PtxRegister1319) - uint32_t(r_PtxRegister1322);			// PTX L2859
	r_PtxRegister1324 = ShiftRight(uint32_t(r_PtxRegister1316), uint32_t(28));				// PTX L2860
	r_PtxRegister1325 = uint32_t(r_LaneIndexAtPtx2850) + uint32_t(r_PtxRegister1324);		// PTX L2861
	r_PtxRegister1326 = ShiftRightSigned(int32_t(r_PtxRegister1325), uint32_t(4));			// PTX L2862
	r_PtxRegister1327 = uint32_t(r_PtxRegister1326) + uint32_t(r_PtxRegister4);				// PTX L2863
	r_PtxRegister1328 = uint32_t(r_PtxRegister1327) + uint32_t(6);							// PTX L2864
	r_PtxRegister128 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister1323);				// PTX L2865
	r_bPtxPredicate868 = int32_t(r_PtxRegister1328) < int32_t(0);							// PTX L2866
	r_bPtxPredicate869 = int32_t(r_PtxRegister1328) >= int32_t(r_HeightBits);				// PTX L2867
	r_bPtxPredicate870 = r_bPtxPredicate868 | r_bPtxPredicate869;							// PTX L2868
	r_bPtxPredicate871 = !r_bPtxPredicate870;												// PTX L2869
	r_PtxRegister129 = r_bPtxPredicate867 ? 0 : r_PtxRegister1328;							// PTX L2870
	r_bPtxPredicate872 = r_bPtxPredicate866 & r_bPtxPredicate870;							// PTX L2871
	r_bPtxPredicate873 = r_bPtxPredicate867 | r_bPtxPredicate871;							// PTX L2872
	r_bPtxPredicate874 = r_bPtxPredicate872 | r_bPtxPredicate865;							// PTX L2873
	r_bPtxPredicate875 = int32_t(r_PtxRegister128) > int32_t(-1);							// PTX L2874
	r_bPtxPredicate876 = int32_t(r_PtxRegister128) < int32_t(r_WidthBits);					// PTX L2875
	r_bPtxPredicate877 = r_bPtxPredicate875 & r_bPtxPredicate876;							// PTX L2876
	r_bPtxPredicate878 = !r_bPtxPredicate872;												// PTX L2877
	r_bPtxPredicate50 = r_bPtxPredicate865 & r_bPtxPredicate878;							// PTX L2878
	r_bPtxPredicate879 = r_bPtxPredicate874 | r_bPtxPredicate877;							// PTX L2879
	r_bPtxPredicate880 = r_bPtxPredicate879 & r_bPtxPredicate873;							// PTX L2880
	r_PtxRegister2746 = uint32_t(0);														// PTX L2881
	r_bPtxPredicate881 = !r_bPtxPredicate880;												// PTX L2882
	if (r_bPtxPredicate881)
	{
		goto L__BB18_166;
	} // PTX L2883
	r_PtxRegister1329 = r_PtxRegister1318 & -4;										  // PTX L2884
	r_PtxRegister1330 = uint32_t(r_LaneIndexAtPtx2850) - uint32_t(r_PtxRegister1329); // PTX L2885
	r_PtxRegister1331 = ShiftLeft(uint32_t(r_PtxRegister128), uint32_t(2));			  // PTX L2886
	r_PtxRegister1332 = r_bPtxPredicate50 ? 0 : r_PtxRegister1331;					  // PTX L2887
	r_PtxRegister1333 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister129); // PTX L2888
	r_PtxRegister1334 =
		uint32_t(r_PtxRegister1333) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1330); // PTX L2889
	r_PtxRegister1335 = uint32_t(r_PtxRegister1334) + uint32_t(r_PtxRegister1332);			   // PTX L2890
	r_PtxU64Register140 = uint64_t(int64_t(int32_t(r_PtxRegister1335)) * int64_t(int32_t(4))); // PTX L2891
	g_ResidualByteAddressAtPtx2892 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register140);				// PTX L2892
	r_PtxRegister2746 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2892); // PTX L2893
L__BB18_166:																				// PTX L2894
	r_bPtxPredicate882 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2895
	r_bPtxPredicate883 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2896
	r_LaneIndexAtPtx2898 = uint32_t((threadIdx.x & 31u));									// PTX L2898
	r_PtxRegister1337 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2898), uint32_t(31));		// PTX L2900
	r_PtxRegister1338 = ShiftRight(uint32_t(r_PtxRegister1337), uint32_t(30));				// PTX L2901
	r_PtxRegister1339 = uint32_t(r_LaneIndexAtPtx2898) + uint32_t(r_PtxRegister1338);		// PTX L2902
	r_PtxRegister1340 = ShiftRightSigned(int32_t(r_PtxRegister1339), uint32_t(2));			// PTX L2903
	r_PtxRegister1341 = ShiftRight(uint32_t(r_PtxRegister1340), uint32_t(30));				// PTX L2904
	r_PtxRegister1342 = uint32_t(r_PtxRegister1340) + uint32_t(r_PtxRegister1341);			// PTX L2905
	r_PtxRegister1343 = r_PtxRegister1342 & -4;												// PTX L2906
	r_PtxRegister1344 = uint32_t(r_PtxRegister1340) - uint32_t(r_PtxRegister1343);			// PTX L2907
	r_PtxRegister1345 = ShiftRight(uint32_t(r_PtxRegister1337), uint32_t(28));				// PTX L2908
	r_PtxRegister1346 = uint32_t(r_LaneIndexAtPtx2898) + uint32_t(r_PtxRegister1345);		// PTX L2909
	r_PtxRegister1347 = ShiftRightSigned(int32_t(r_PtxRegister1346), uint32_t(4));			// PTX L2910
	r_PtxRegister1348 = uint32_t(r_PtxRegister1347) + uint32_t(r_PtxRegister4);				// PTX L2911
	r_PtxRegister1349 = uint32_t(r_PtxRegister1344) + uint32_t(r_PtxRegister5);				// PTX L2912
	r_PtxRegister1350 = uint32_t(r_PtxRegister1348) + uint32_t(4);							// PTX L2913
	r_PtxRegister130 = uint32_t(r_PtxRegister1349) + uint32_t(4);							// PTX L2914
	r_bPtxPredicate884 = int32_t(r_PtxRegister1350) < int32_t(0);							// PTX L2915
	r_bPtxPredicate885 = int32_t(r_PtxRegister1350) >= int32_t(r_HeightBits);				// PTX L2916
	r_bPtxPredicate886 = r_bPtxPredicate884 | r_bPtxPredicate885;							// PTX L2917
	r_bPtxPredicate887 = !r_bPtxPredicate886;												// PTX L2918
	r_PtxRegister131 = r_bPtxPredicate883 ? 0 : r_PtxRegister1350;							// PTX L2919
	r_bPtxPredicate888 = r_bPtxPredicate882 & r_bPtxPredicate886;							// PTX L2920
	r_bPtxPredicate889 = r_bPtxPredicate883 | r_bPtxPredicate887;							// PTX L2921
	r_bPtxPredicate890 = r_bPtxPredicate888 | r_bPtxPredicate865;							// PTX L2922
	r_bPtxPredicate891 = int32_t(r_PtxRegister130) < int32_t(r_WidthBits);					// PTX L2923
	r_bPtxPredicate892 = !r_bPtxPredicate888;												// PTX L2924
	r_bPtxPredicate51 = r_bPtxPredicate865 & r_bPtxPredicate892;							// PTX L2925
	r_bPtxPredicate893 = r_bPtxPredicate890 | r_bPtxPredicate891;							// PTX L2926
	r_bPtxPredicate894 = r_bPtxPredicate893 & r_bPtxPredicate889;							// PTX L2927
	r_PtxRegister2747 = uint32_t(0);														// PTX L2928
	r_bPtxPredicate895 = !r_bPtxPredicate894;												// PTX L2929
	if (r_bPtxPredicate895)
	{
		goto L__BB18_168;
	} // PTX L2930
	r_PtxRegister1351 = r_PtxRegister1339 & -4;										  // PTX L2931
	r_PtxRegister1352 = uint32_t(r_LaneIndexAtPtx2898) - uint32_t(r_PtxRegister1351); // PTX L2932
	r_PtxRegister1353 = ShiftLeft(uint32_t(r_PtxRegister130), uint32_t(2));			  // PTX L2933
	r_PtxRegister1354 = r_bPtxPredicate51 ? 0 : r_PtxRegister1353;					  // PTX L2934
	r_PtxRegister1355 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister131); // PTX L2935
	r_PtxRegister1356 =
		uint32_t(r_PtxRegister1355) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1352); // PTX L2936
	r_PtxRegister1357 = uint32_t(r_PtxRegister1356) + uint32_t(r_PtxRegister1354);			   // PTX L2937
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister1357)) * int64_t(int32_t(4))); // PTX L2938
	g_ResidualByteAddressAtPtx2939 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register142);				// PTX L2939
	r_PtxRegister2747 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2939); // PTX L2940
L__BB18_168:																				// PTX L2941
	r_bPtxPredicate896 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L2942
	r_bPtxPredicate897 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2943
	r_LaneIndexAtPtx2945 = uint32_t((threadIdx.x & 31u));									// PTX L2945
	r_PtxRegister1359 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2945), uint32_t(31));		// PTX L2947
	r_PtxRegister1360 = ShiftRight(uint32_t(r_PtxRegister1359), uint32_t(30));				// PTX L2948
	r_PtxRegister1361 = uint32_t(r_LaneIndexAtPtx2945) + uint32_t(r_PtxRegister1360);		// PTX L2949
	r_PtxRegister1362 = ShiftRightSigned(int32_t(r_PtxRegister1361), uint32_t(2));			// PTX L2950
	r_PtxRegister1363 = ShiftRight(uint32_t(r_PtxRegister1362), uint32_t(30));				// PTX L2951
	r_PtxRegister1364 = uint32_t(r_PtxRegister1362) + uint32_t(r_PtxRegister1363);			// PTX L2952
	r_PtxRegister1365 = r_PtxRegister1364 & -4;												// PTX L2953
	r_PtxRegister1366 = uint32_t(r_PtxRegister1362) - uint32_t(r_PtxRegister1365);			// PTX L2954
	r_PtxRegister1367 = ShiftRight(uint32_t(r_PtxRegister1359), uint32_t(28));				// PTX L2955
	r_PtxRegister1368 = uint32_t(r_LaneIndexAtPtx2945) + uint32_t(r_PtxRegister1367);		// PTX L2956
	r_PtxRegister1369 = ShiftRightSigned(int32_t(r_PtxRegister1368), uint32_t(4));			// PTX L2957
	r_PtxRegister1370 = uint32_t(r_PtxRegister1369) + uint32_t(r_PtxRegister4);				// PTX L2958
	r_PtxRegister1371 = uint32_t(r_PtxRegister1366) + uint32_t(r_PtxRegister5);				// PTX L2959
	r_PtxRegister1372 = uint32_t(r_PtxRegister1370) + uint32_t(6);							// PTX L2960
	r_PtxRegister132 = uint32_t(r_PtxRegister1371) + uint32_t(4);							// PTX L2961
	r_bPtxPredicate898 = int32_t(r_PtxRegister1372) < int32_t(0);							// PTX L2962
	r_bPtxPredicate899 = int32_t(r_PtxRegister1372) >= int32_t(r_HeightBits);				// PTX L2963
	r_bPtxPredicate900 = r_bPtxPredicate898 | r_bPtxPredicate899;							// PTX L2964
	r_bPtxPredicate901 = !r_bPtxPredicate900;												// PTX L2965
	r_PtxRegister133 = r_bPtxPredicate897 ? 0 : r_PtxRegister1372;							// PTX L2966
	r_bPtxPredicate902 = r_bPtxPredicate882 & r_bPtxPredicate900;							// PTX L2967
	r_bPtxPredicate903 = r_bPtxPredicate897 | r_bPtxPredicate901;							// PTX L2968
	r_bPtxPredicate904 = r_bPtxPredicate902 | r_bPtxPredicate896;							// PTX L2969
	r_bPtxPredicate905 = int32_t(r_PtxRegister132) < int32_t(r_WidthBits);					// PTX L2970
	r_bPtxPredicate906 = !r_bPtxPredicate902;												// PTX L2971
	r_bPtxPredicate52 = r_bPtxPredicate896 & r_bPtxPredicate906;							// PTX L2972
	r_bPtxPredicate907 = r_bPtxPredicate904 | r_bPtxPredicate905;							// PTX L2973
	r_bPtxPredicate908 = r_bPtxPredicate907 & r_bPtxPredicate903;							// PTX L2974
	r_PtxRegister2748 = uint32_t(0);														// PTX L2975
	r_bPtxPredicate909 = !r_bPtxPredicate908;												// PTX L2976
	if (r_bPtxPredicate909)
	{
		goto L__BB18_170;
	} // PTX L2977
	r_PtxRegister1373 = r_PtxRegister1361 & -4;										  // PTX L2978
	r_PtxRegister1374 = uint32_t(r_LaneIndexAtPtx2945) - uint32_t(r_PtxRegister1373); // PTX L2979
	r_PtxRegister1375 = ShiftLeft(uint32_t(r_PtxRegister132), uint32_t(2));			  // PTX L2980
	r_PtxRegister1376 = r_bPtxPredicate52 ? 0 : r_PtxRegister1375;					  // PTX L2981
	r_PtxRegister1377 =
		uint32_t(r_PtxRegister26) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister133); // PTX L2982
	r_PtxRegister1378 =
		uint32_t(r_PtxRegister1377) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1374); // PTX L2983
	r_PtxRegister1379 = uint32_t(r_PtxRegister1378) + uint32_t(r_PtxRegister1376);			   // PTX L2984
	r_PtxU64Register144 = uint64_t(int64_t(int32_t(r_PtxRegister1379)) * int64_t(int32_t(4))); // PTX L2985
	g_ResidualByteAddressAtPtx2986 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register144);				// PTX L2986
	r_PtxRegister2748 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx2986); // PTX L2987
L__BB18_170:																				// PTX L2988
	r_bPtxPredicate910 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L2989
	r_bPtxPredicate911 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L2990
	r_LaneIndexAtPtx2992 = uint32_t((threadIdx.x & 31u));									// PTX L2992
	r_PtxRegister1381 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2992), uint32_t(31));		// PTX L2994
	r_PtxRegister1382 = ShiftRight(uint32_t(r_PtxRegister1381), uint32_t(30));				// PTX L2995
	r_PtxRegister1383 = uint32_t(r_LaneIndexAtPtx2992) + uint32_t(r_PtxRegister1382);		// PTX L2996
	r_PtxRegister1384 = ShiftRightSigned(int32_t(r_PtxRegister1383), uint32_t(2));			// PTX L2997
	r_PtxRegister1385 = ShiftRight(uint32_t(r_PtxRegister1384), uint32_t(30));				// PTX L2998
	r_PtxRegister1386 = uint32_t(r_PtxRegister1384) + uint32_t(r_PtxRegister1385);			// PTX L2999
	r_PtxRegister1387 = r_PtxRegister1386 & -4;												// PTX L3000
	r_PtxRegister1388 = uint32_t(r_PtxRegister1384) - uint32_t(r_PtxRegister1387);			// PTX L3001
	r_PtxRegister1389 = ShiftRight(uint32_t(r_PtxRegister1381), uint32_t(28));				// PTX L3002
	r_PtxRegister1390 = uint32_t(r_LaneIndexAtPtx2992) + uint32_t(r_PtxRegister1389);		// PTX L3003
	r_PtxRegister1391 = ShiftRightSigned(int32_t(r_PtxRegister1390), uint32_t(4));			// PTX L3004
	r_PtxRegister1392 = uint32_t(r_PtxRegister1391) + uint32_t(r_PtxRegister4);				// PTX L3005
	r_PtxRegister1393 = uint32_t(r_PtxRegister1388) + uint32_t(r_PtxRegister5);				// PTX L3006
	r_PtxRegister1394 = uint32_t(r_PtxRegister1392) + uint32_t(4);							// PTX L3007
	r_PtxRegister134 = uint32_t(r_PtxRegister1393) + uint32_t(4);							// PTX L3008
	r_bPtxPredicate912 = int32_t(r_PtxRegister1394) < int32_t(0);							// PTX L3009
	r_bPtxPredicate913 = int32_t(r_PtxRegister1394) >= int32_t(r_HeightBits);				// PTX L3010
	r_bPtxPredicate914 = r_bPtxPredicate912 | r_bPtxPredicate913;							// PTX L3011
	r_bPtxPredicate915 = !r_bPtxPredicate914;												// PTX L3012
	r_PtxRegister135 = r_bPtxPredicate911 ? 0 : r_PtxRegister1394;							// PTX L3013
	r_bPtxPredicate916 = r_bPtxPredicate910 & r_bPtxPredicate914;							// PTX L3014
	r_bPtxPredicate917 = r_bPtxPredicate911 | r_bPtxPredicate915;							// PTX L3015
	r_bPtxPredicate918 = r_bPtxPredicate916 | r_bPtxPredicate896;							// PTX L3016
	r_bPtxPredicate919 = int32_t(r_PtxRegister134) < int32_t(r_WidthBits);					// PTX L3017
	r_bPtxPredicate920 = !r_bPtxPredicate916;												// PTX L3018
	r_bPtxPredicate53 = r_bPtxPredicate896 & r_bPtxPredicate920;							// PTX L3019
	r_bPtxPredicate921 = r_bPtxPredicate918 | r_bPtxPredicate919;							// PTX L3020
	r_bPtxPredicate922 = r_bPtxPredicate921 & r_bPtxPredicate917;							// PTX L3021
	r_PtxRegister2749 = uint32_t(0);														// PTX L3022
	r_bPtxPredicate923 = !r_bPtxPredicate922;												// PTX L3023
	if (r_bPtxPredicate923)
	{
		goto L__BB18_172;
	} // PTX L3024
	r_PtxRegister1395 = r_PtxRegister1383 & -4;										  // PTX L3025
	r_PtxRegister1396 = uint32_t(r_LaneIndexAtPtx2992) - uint32_t(r_PtxRegister1395); // PTX L3026
	r_PtxRegister1397 = ShiftLeft(uint32_t(r_PtxRegister134), uint32_t(2));			  // PTX L3027
	r_PtxRegister1398 = r_bPtxPredicate53 ? 0 : r_PtxRegister1397;					  // PTX L3028
	r_PtxRegister1399 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister135); // PTX L3029
	r_PtxRegister1400 =
		uint32_t(r_PtxRegister1399) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1396); // PTX L3030
	r_PtxRegister1401 = uint32_t(r_PtxRegister1400) + uint32_t(r_PtxRegister1398);			   // PTX L3031
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister1401)) * int64_t(int32_t(4))); // PTX L3032
	g_ResidualByteAddressAtPtx3033 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register146);				// PTX L3033
	r_PtxRegister2749 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3033); // PTX L3034
L__BB18_172:																				// PTX L3035
	r_bPtxPredicate924 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3036
	r_bPtxPredicate925 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3037
	r_LaneIndexAtPtx3039 = uint32_t((threadIdx.x & 31u));									// PTX L3039
	r_PtxRegister1403 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3039), uint32_t(31));		// PTX L3041
	r_PtxRegister1404 = ShiftRight(uint32_t(r_PtxRegister1403), uint32_t(30));				// PTX L3042
	r_PtxRegister1405 = uint32_t(r_LaneIndexAtPtx3039) + uint32_t(r_PtxRegister1404);		// PTX L3043
	r_PtxRegister1406 = ShiftRightSigned(int32_t(r_PtxRegister1405), uint32_t(2));			// PTX L3044
	r_PtxRegister1407 = ShiftRight(uint32_t(r_PtxRegister1406), uint32_t(30));				// PTX L3045
	r_PtxRegister1408 = uint32_t(r_PtxRegister1406) + uint32_t(r_PtxRegister1407);			// PTX L3046
	r_PtxRegister1409 = r_PtxRegister1408 & -4;												// PTX L3047
	r_PtxRegister1410 = uint32_t(r_PtxRegister1406) - uint32_t(r_PtxRegister1409);			// PTX L3048
	r_PtxRegister1411 = ShiftRight(uint32_t(r_PtxRegister1403), uint32_t(28));				// PTX L3049
	r_PtxRegister1412 = uint32_t(r_LaneIndexAtPtx3039) + uint32_t(r_PtxRegister1411);		// PTX L3050
	r_PtxRegister1413 = ShiftRightSigned(int32_t(r_PtxRegister1412), uint32_t(4));			// PTX L3051
	r_PtxRegister1414 = uint32_t(r_PtxRegister1413) + uint32_t(r_PtxRegister4);				// PTX L3052
	r_PtxRegister1415 = uint32_t(r_PtxRegister1410) + uint32_t(r_PtxRegister5);				// PTX L3053
	r_PtxRegister1416 = uint32_t(r_PtxRegister1414) + uint32_t(6);							// PTX L3054
	r_PtxRegister136 = uint32_t(r_PtxRegister1415) + uint32_t(4);							// PTX L3055
	r_bPtxPredicate926 = int32_t(r_PtxRegister1416) < int32_t(0);							// PTX L3056
	r_bPtxPredicate927 = int32_t(r_PtxRegister1416) >= int32_t(r_HeightBits);				// PTX L3057
	r_bPtxPredicate928 = r_bPtxPredicate926 | r_bPtxPredicate927;							// PTX L3058
	r_bPtxPredicate929 = !r_bPtxPredicate928;												// PTX L3059
	r_PtxRegister137 = r_bPtxPredicate925 ? 0 : r_PtxRegister1416;							// PTX L3060
	r_bPtxPredicate930 = r_bPtxPredicate910 & r_bPtxPredicate928;							// PTX L3061
	r_bPtxPredicate931 = r_bPtxPredicate925 | r_bPtxPredicate929;							// PTX L3062
	r_bPtxPredicate932 = r_bPtxPredicate930 | r_bPtxPredicate924;							// PTX L3063
	r_bPtxPredicate933 = int32_t(r_PtxRegister136) < int32_t(r_WidthBits);					// PTX L3064
	r_bPtxPredicate934 = !r_bPtxPredicate930;												// PTX L3065
	r_bPtxPredicate54 = r_bPtxPredicate924 & r_bPtxPredicate934;							// PTX L3066
	r_bPtxPredicate935 = r_bPtxPredicate932 | r_bPtxPredicate933;							// PTX L3067
	r_bPtxPredicate936 = r_bPtxPredicate935 & r_bPtxPredicate931;							// PTX L3068
	r_PtxRegister2750 = uint32_t(0);														// PTX L3069
	r_bPtxPredicate937 = !r_bPtxPredicate936;												// PTX L3070
	if (r_bPtxPredicate937)
	{
		goto L__BB18_174;
	} // PTX L3071
	r_PtxRegister1417 = r_PtxRegister1405 & -4;										  // PTX L3072
	r_PtxRegister1418 = uint32_t(r_LaneIndexAtPtx3039) - uint32_t(r_PtxRegister1417); // PTX L3073
	r_PtxRegister1419 = ShiftLeft(uint32_t(r_PtxRegister136), uint32_t(2));			  // PTX L3074
	r_PtxRegister1420 = r_bPtxPredicate54 ? 0 : r_PtxRegister1419;					  // PTX L3075
	r_PtxRegister1421 =
		uint32_t(r_PtxRegister31) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister137); // PTX L3076
	r_PtxRegister1422 =
		uint32_t(r_PtxRegister1421) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1418); // PTX L3077
	r_PtxRegister1423 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1420);			   // PTX L3078
	r_PtxU64Register148 = uint64_t(int64_t(int32_t(r_PtxRegister1423)) * int64_t(int32_t(4))); // PTX L3079
	g_ResidualByteAddressAtPtx3080 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register148);				// PTX L3080
	r_PtxRegister2750 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3080); // PTX L3081
L__BB18_174:																				// PTX L3082
	r_bPtxPredicate938 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L3083
	r_bPtxPredicate939 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3084
	r_LaneIndexAtPtx3086 = uint32_t((threadIdx.x & 31u));									// PTX L3086
	r_PtxRegister1425 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3086), uint32_t(31));		// PTX L3088
	r_PtxRegister1426 = ShiftRight(uint32_t(r_PtxRegister1425), uint32_t(30));				// PTX L3089
	r_PtxRegister1427 = uint32_t(r_LaneIndexAtPtx3086) + uint32_t(r_PtxRegister1426);		// PTX L3090
	r_PtxRegister1428 = ShiftRightSigned(int32_t(r_PtxRegister1427), uint32_t(2));			// PTX L3091
	r_PtxRegister1429 = ShiftRight(uint32_t(r_PtxRegister1428), uint32_t(30));				// PTX L3092
	r_PtxRegister1430 = uint32_t(r_PtxRegister1428) + uint32_t(r_PtxRegister1429);			// PTX L3093
	r_PtxRegister1431 = r_PtxRegister1430 & -4;												// PTX L3094
	r_PtxRegister1432 = uint32_t(r_PtxRegister1428) - uint32_t(r_PtxRegister1431);			// PTX L3095
	r_PtxRegister1433 = ShiftRight(uint32_t(r_PtxRegister1425), uint32_t(28));				// PTX L3096
	r_PtxRegister1434 = uint32_t(r_LaneIndexAtPtx3086) + uint32_t(r_PtxRegister1433);		// PTX L3097
	r_PtxRegister1435 = ShiftRightSigned(int32_t(r_PtxRegister1434), uint32_t(4));			// PTX L3098
	r_PtxRegister1436 = uint32_t(r_PtxRegister1435) + uint32_t(r_PtxRegister4);				// PTX L3099
	r_PtxRegister1437 = uint32_t(r_PtxRegister1432) + uint32_t(r_PtxRegister5);				// PTX L3100
	r_PtxRegister1438 = uint32_t(r_PtxRegister1436) + uint32_t(4);							// PTX L3101
	r_PtxRegister138 = uint32_t(r_PtxRegister1437) + uint32_t(4);							// PTX L3102
	r_bPtxPredicate940 = int32_t(r_PtxRegister1438) < int32_t(0);							// PTX L3103
	r_bPtxPredicate941 = int32_t(r_PtxRegister1438) >= int32_t(r_HeightBits);				// PTX L3104
	r_bPtxPredicate942 = r_bPtxPredicate940 | r_bPtxPredicate941;							// PTX L3105
	r_bPtxPredicate943 = !r_bPtxPredicate942;												// PTX L3106
	r_PtxRegister139 = r_bPtxPredicate939 ? 0 : r_PtxRegister1438;							// PTX L3107
	r_bPtxPredicate944 = r_bPtxPredicate938 & r_bPtxPredicate942;							// PTX L3108
	r_bPtxPredicate945 = r_bPtxPredicate939 | r_bPtxPredicate943;							// PTX L3109
	r_bPtxPredicate946 = r_bPtxPredicate944 | r_bPtxPredicate924;							// PTX L3110
	r_bPtxPredicate947 = int32_t(r_PtxRegister138) < int32_t(r_WidthBits);					// PTX L3111
	r_bPtxPredicate948 = !r_bPtxPredicate944;												// PTX L3112
	r_bPtxPredicate55 = r_bPtxPredicate924 & r_bPtxPredicate948;							// PTX L3113
	r_bPtxPredicate949 = r_bPtxPredicate946 | r_bPtxPredicate947;							// PTX L3114
	r_bPtxPredicate950 = r_bPtxPredicate949 & r_bPtxPredicate945;							// PTX L3115
	r_PtxRegister2751 = uint32_t(0);														// PTX L3116
	r_bPtxPredicate951 = !r_bPtxPredicate950;												// PTX L3117
	if (r_bPtxPredicate951)
	{
		goto L__BB18_176;
	} // PTX L3118
	r_PtxRegister1439 = r_PtxRegister1427 & -4;										  // PTX L3119
	r_PtxRegister1440 = uint32_t(r_LaneIndexAtPtx3086) - uint32_t(r_PtxRegister1439); // PTX L3120
	r_PtxRegister1441 = ShiftLeft(uint32_t(r_PtxRegister138), uint32_t(2));			  // PTX L3121
	r_PtxRegister1442 = r_bPtxPredicate55 ? 0 : r_PtxRegister1441;					  // PTX L3122
	r_PtxRegister1443 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister139); // PTX L3123
	r_PtxRegister1444 =
		uint32_t(r_PtxRegister1443) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1440); // PTX L3124
	r_PtxRegister1445 = uint32_t(r_PtxRegister1444) + uint32_t(r_PtxRegister1442);			   // PTX L3125
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister1445)) * int64_t(int32_t(4))); // PTX L3126
	g_ResidualByteAddressAtPtx3127 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register150);				// PTX L3127
	r_PtxRegister2751 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3127); // PTX L3128
L__BB18_176:																				// PTX L3129
	r_bPtxPredicate952 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3130
	r_bPtxPredicate953 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3131
	r_LaneIndexAtPtx3133 = uint32_t((threadIdx.x & 31u));									// PTX L3133
	r_PtxRegister1447 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3133), uint32_t(31));		// PTX L3135
	r_PtxRegister1448 = ShiftRight(uint32_t(r_PtxRegister1447), uint32_t(30));				// PTX L3136
	r_PtxRegister1449 = uint32_t(r_LaneIndexAtPtx3133) + uint32_t(r_PtxRegister1448);		// PTX L3137
	r_PtxRegister1450 = ShiftRightSigned(int32_t(r_PtxRegister1449), uint32_t(2));			// PTX L3138
	r_PtxRegister1451 = ShiftRight(uint32_t(r_PtxRegister1450), uint32_t(30));				// PTX L3139
	r_PtxRegister1452 = uint32_t(r_PtxRegister1450) + uint32_t(r_PtxRegister1451);			// PTX L3140
	r_PtxRegister1453 = r_PtxRegister1452 & -4;												// PTX L3141
	r_PtxRegister1454 = uint32_t(r_PtxRegister1450) - uint32_t(r_PtxRegister1453);			// PTX L3142
	r_PtxRegister1455 = ShiftRight(uint32_t(r_PtxRegister1447), uint32_t(28));				// PTX L3143
	r_PtxRegister1456 = uint32_t(r_LaneIndexAtPtx3133) + uint32_t(r_PtxRegister1455);		// PTX L3144
	r_PtxRegister1457 = ShiftRightSigned(int32_t(r_PtxRegister1456), uint32_t(4));			// PTX L3145
	r_PtxRegister1458 = uint32_t(r_PtxRegister1457) + uint32_t(r_PtxRegister4);				// PTX L3146
	r_PtxRegister1459 = uint32_t(r_PtxRegister1454) + uint32_t(r_PtxRegister5);				// PTX L3147
	r_PtxRegister1460 = uint32_t(r_PtxRegister1458) + uint32_t(6);							// PTX L3148
	r_PtxRegister140 = uint32_t(r_PtxRegister1459) + uint32_t(4);							// PTX L3149
	r_bPtxPredicate954 = int32_t(r_PtxRegister1460) < int32_t(0);							// PTX L3150
	r_bPtxPredicate955 = int32_t(r_PtxRegister1460) >= int32_t(r_HeightBits);				// PTX L3151
	r_bPtxPredicate956 = r_bPtxPredicate954 | r_bPtxPredicate955;							// PTX L3152
	r_bPtxPredicate957 = !r_bPtxPredicate956;												// PTX L3153
	r_PtxRegister141 = r_bPtxPredicate953 ? 0 : r_PtxRegister1460;							// PTX L3154
	r_bPtxPredicate958 = r_bPtxPredicate938 & r_bPtxPredicate956;							// PTX L3155
	r_bPtxPredicate959 = r_bPtxPredicate953 | r_bPtxPredicate957;							// PTX L3156
	r_bPtxPredicate960 = r_bPtxPredicate958 | r_bPtxPredicate952;							// PTX L3157
	r_bPtxPredicate961 = int32_t(r_PtxRegister140) < int32_t(r_WidthBits);					// PTX L3158
	r_bPtxPredicate962 = !r_bPtxPredicate958;												// PTX L3159
	r_bPtxPredicate56 = r_bPtxPredicate952 & r_bPtxPredicate962;							// PTX L3160
	r_bPtxPredicate963 = r_bPtxPredicate960 | r_bPtxPredicate961;							// PTX L3161
	r_bPtxPredicate964 = r_bPtxPredicate963 & r_bPtxPredicate959;							// PTX L3162
	r_PtxRegister2752 = uint32_t(0);														// PTX L3163
	r_bPtxPredicate965 = !r_bPtxPredicate964;												// PTX L3164
	if (r_bPtxPredicate965)
	{
		goto L__BB18_178;
	} // PTX L3165
	r_PtxRegister1461 = r_PtxRegister1449 & -4;										  // PTX L3166
	r_PtxRegister1462 = uint32_t(r_LaneIndexAtPtx3133) - uint32_t(r_PtxRegister1461); // PTX L3167
	r_PtxRegister1463 = ShiftLeft(uint32_t(r_PtxRegister140), uint32_t(2));			  // PTX L3168
	r_PtxRegister1464 = r_bPtxPredicate56 ? 0 : r_PtxRegister1463;					  // PTX L3169
	r_PtxRegister1465 =
		uint32_t(r_PtxRegister36) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister141); // PTX L3170
	r_PtxRegister1466 =
		uint32_t(r_PtxRegister1465) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1462); // PTX L3171
	r_PtxRegister1467 = uint32_t(r_PtxRegister1466) + uint32_t(r_PtxRegister1464);			   // PTX L3172
	r_PtxU64Register152 = uint64_t(int64_t(int32_t(r_PtxRegister1467)) * int64_t(int32_t(4))); // PTX L3173
	g_ResidualByteAddressAtPtx3174 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register152);				// PTX L3174
	r_PtxRegister2752 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3174); // PTX L3175
L__BB18_178:																				// PTX L3176
	r_bPtxPredicate966 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L3177
	r_bPtxPredicate967 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3178
	r_LaneIndexAtPtx3180 = uint32_t((threadIdx.x & 31u));									// PTX L3180
	r_PtxRegister1469 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3180), uint32_t(31));		// PTX L3182
	r_PtxRegister1470 = ShiftRight(uint32_t(r_PtxRegister1469), uint32_t(30));				// PTX L3183
	r_PtxRegister1471 = uint32_t(r_LaneIndexAtPtx3180) + uint32_t(r_PtxRegister1470);		// PTX L3184
	r_PtxRegister1472 = ShiftRightSigned(int32_t(r_PtxRegister1471), uint32_t(2));			// PTX L3185
	r_PtxRegister1473 = ShiftRight(uint32_t(r_PtxRegister1472), uint32_t(30));				// PTX L3186
	r_PtxRegister1474 = uint32_t(r_PtxRegister1472) + uint32_t(r_PtxRegister1473);			// PTX L3187
	r_PtxRegister1475 = r_PtxRegister1474 & -4;												// PTX L3188
	r_PtxRegister1476 = uint32_t(r_PtxRegister1472) - uint32_t(r_PtxRegister1475);			// PTX L3189
	r_PtxRegister1477 = ShiftRight(uint32_t(r_PtxRegister1469), uint32_t(28));				// PTX L3190
	r_PtxRegister1478 = uint32_t(r_LaneIndexAtPtx3180) + uint32_t(r_PtxRegister1477);		// PTX L3191
	r_PtxRegister1479 = ShiftRightSigned(int32_t(r_PtxRegister1478), uint32_t(4));			// PTX L3192
	r_PtxRegister1480 = uint32_t(r_PtxRegister1479) + uint32_t(r_PtxRegister4);				// PTX L3193
	r_PtxRegister1481 = uint32_t(r_PtxRegister1476) + uint32_t(r_PtxRegister5);				// PTX L3194
	r_PtxRegister1482 = uint32_t(r_PtxRegister1480) + uint32_t(4);							// PTX L3195
	r_PtxRegister142 = uint32_t(r_PtxRegister1481) + uint32_t(4);							// PTX L3196
	r_bPtxPredicate968 = int32_t(r_PtxRegister1482) < int32_t(0);							// PTX L3197
	r_bPtxPredicate969 = int32_t(r_PtxRegister1482) >= int32_t(r_HeightBits);				// PTX L3198
	r_bPtxPredicate970 = r_bPtxPredicate968 | r_bPtxPredicate969;							// PTX L3199
	r_bPtxPredicate971 = !r_bPtxPredicate970;												// PTX L3200
	r_PtxRegister143 = r_bPtxPredicate967 ? 0 : r_PtxRegister1482;							// PTX L3201
	r_bPtxPredicate972 = r_bPtxPredicate966 & r_bPtxPredicate970;							// PTX L3202
	r_bPtxPredicate973 = r_bPtxPredicate967 | r_bPtxPredicate971;							// PTX L3203
	r_bPtxPredicate974 = r_bPtxPredicate972 | r_bPtxPredicate952;							// PTX L3204
	r_bPtxPredicate975 = int32_t(r_PtxRegister142) < int32_t(r_WidthBits);					// PTX L3205
	r_bPtxPredicate976 = !r_bPtxPredicate972;												// PTX L3206
	r_bPtxPredicate57 = r_bPtxPredicate952 & r_bPtxPredicate976;							// PTX L3207
	r_bPtxPredicate977 = r_bPtxPredicate974 | r_bPtxPredicate975;							// PTX L3208
	r_bPtxPredicate978 = r_bPtxPredicate977 & r_bPtxPredicate973;							// PTX L3209
	r_PtxRegister2753 = uint32_t(0);														// PTX L3210
	r_bPtxPredicate979 = !r_bPtxPredicate978;												// PTX L3211
	if (r_bPtxPredicate979)
	{
		goto L__BB18_180;
	} // PTX L3212
	r_PtxRegister1483 = r_PtxRegister1471 & -4;										  // PTX L3213
	r_PtxRegister1484 = uint32_t(r_LaneIndexAtPtx3180) - uint32_t(r_PtxRegister1483); // PTX L3214
	r_PtxRegister1485 = ShiftLeft(uint32_t(r_PtxRegister142), uint32_t(2));			  // PTX L3215
	r_PtxRegister1486 = r_bPtxPredicate57 ? 0 : r_PtxRegister1485;					  // PTX L3216
	r_PtxRegister1487 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister143); // PTX L3217
	r_PtxRegister1488 =
		uint32_t(r_PtxRegister1487) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1484); // PTX L3218
	r_PtxRegister1489 = uint32_t(r_PtxRegister1488) + uint32_t(r_PtxRegister1486);			   // PTX L3219
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister1489)) * int64_t(int32_t(4))); // PTX L3220
	g_ResidualByteAddressAtPtx3221 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register154);				// PTX L3221
	r_PtxRegister2753 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3221); // PTX L3222
L__BB18_180:																				// PTX L3223
	r_bPtxPredicate980 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3224
	r_bPtxPredicate981 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3225
	r_LaneIndexAtPtx3227 = uint32_t((threadIdx.x & 31u));									// PTX L3227
	r_PtxRegister1491 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3227), uint32_t(31));		// PTX L3229
	r_PtxRegister1492 = ShiftRight(uint32_t(r_PtxRegister1491), uint32_t(30));				// PTX L3230
	r_PtxRegister1493 = uint32_t(r_LaneIndexAtPtx3227) + uint32_t(r_PtxRegister1492);		// PTX L3231
	r_PtxRegister1494 = ShiftRightSigned(int32_t(r_PtxRegister1493), uint32_t(2));			// PTX L3232
	r_PtxRegister1495 = ShiftRight(uint32_t(r_PtxRegister1494), uint32_t(30));				// PTX L3233
	r_PtxRegister1496 = uint32_t(r_PtxRegister1494) + uint32_t(r_PtxRegister1495);			// PTX L3234
	r_PtxRegister1497 = r_PtxRegister1496 & -4;												// PTX L3235
	r_PtxRegister1498 = uint32_t(r_PtxRegister1494) - uint32_t(r_PtxRegister1497);			// PTX L3236
	r_PtxRegister1499 = ShiftRight(uint32_t(r_PtxRegister1491), uint32_t(28));				// PTX L3237
	r_PtxRegister1500 = uint32_t(r_LaneIndexAtPtx3227) + uint32_t(r_PtxRegister1499);		// PTX L3238
	r_PtxRegister1501 = ShiftRightSigned(int32_t(r_PtxRegister1500), uint32_t(4));			// PTX L3239
	r_PtxRegister1502 = uint32_t(r_PtxRegister1501) + uint32_t(r_PtxRegister4);				// PTX L3240
	r_PtxRegister1503 = uint32_t(r_PtxRegister1498) + uint32_t(r_PtxRegister5);				// PTX L3241
	r_PtxRegister1504 = uint32_t(r_PtxRegister1502) + uint32_t(6);							// PTX L3242
	r_PtxRegister144 = uint32_t(r_PtxRegister1503) + uint32_t(4);							// PTX L3243
	r_bPtxPredicate982 = int32_t(r_PtxRegister1504) < int32_t(0);							// PTX L3244
	r_bPtxPredicate983 = int32_t(r_PtxRegister1504) >= int32_t(r_HeightBits);				// PTX L3245
	r_bPtxPredicate984 = r_bPtxPredicate982 | r_bPtxPredicate983;							// PTX L3246
	r_bPtxPredicate985 = !r_bPtxPredicate984;												// PTX L3247
	r_PtxRegister145 = r_bPtxPredicate981 ? 0 : r_PtxRegister1504;							// PTX L3248
	r_bPtxPredicate986 = r_bPtxPredicate966 & r_bPtxPredicate984;							// PTX L3249
	r_bPtxPredicate987 = r_bPtxPredicate981 | r_bPtxPredicate985;							// PTX L3250
	r_bPtxPredicate988 = r_bPtxPredicate986 | r_bPtxPredicate980;							// PTX L3251
	r_bPtxPredicate989 = int32_t(r_PtxRegister144) < int32_t(r_WidthBits);					// PTX L3252
	r_bPtxPredicate990 = !r_bPtxPredicate986;												// PTX L3253
	r_bPtxPredicate58 = r_bPtxPredicate980 & r_bPtxPredicate990;							// PTX L3254
	r_bPtxPredicate991 = r_bPtxPredicate988 | r_bPtxPredicate989;							// PTX L3255
	r_bPtxPredicate992 = r_bPtxPredicate991 & r_bPtxPredicate987;							// PTX L3256
	r_PtxRegister2754 = uint32_t(0);														// PTX L3257
	r_bPtxPredicate993 = !r_bPtxPredicate992;												// PTX L3258
	if (r_bPtxPredicate993)
	{
		goto L__BB18_182;
	} // PTX L3259
	r_PtxRegister1505 = r_PtxRegister1493 & -4;										  // PTX L3260
	r_PtxRegister1506 = uint32_t(r_LaneIndexAtPtx3227) - uint32_t(r_PtxRegister1505); // PTX L3261
	r_PtxRegister1507 = ShiftLeft(uint32_t(r_PtxRegister144), uint32_t(2));			  // PTX L3262
	r_PtxRegister1508 = r_bPtxPredicate58 ? 0 : r_PtxRegister1507;					  // PTX L3263
	r_PtxRegister1509 =
		uint32_t(r_PtxRegister41) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister145); // PTX L3264
	r_PtxRegister1510 =
		uint32_t(r_PtxRegister1509) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1506); // PTX L3265
	r_PtxRegister1511 = uint32_t(r_PtxRegister1510) + uint32_t(r_PtxRegister1508);			   // PTX L3266
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister1511)) * int64_t(int32_t(4))); // PTX L3267
	g_ResidualByteAddressAtPtx3268 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register156);				// PTX L3268
	r_PtxRegister2754 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3268); // PTX L3269
L__BB18_182:																				// PTX L3270
	r_bPtxPredicate994 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L3271
	r_bPtxPredicate995 = uint32_t(r_HeightBits) == uint32_t(1);								// PTX L3272
	r_LaneIndexAtPtx3274 = uint32_t((threadIdx.x & 31u));									// PTX L3274
	r_PtxRegister1513 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3274), uint32_t(31));		// PTX L3276
	r_PtxRegister1514 = ShiftRight(uint32_t(r_PtxRegister1513), uint32_t(30));				// PTX L3277
	r_PtxRegister1515 = uint32_t(r_LaneIndexAtPtx3274) + uint32_t(r_PtxRegister1514);		// PTX L3278
	r_PtxRegister1516 = ShiftRightSigned(int32_t(r_PtxRegister1515), uint32_t(2));			// PTX L3279
	r_PtxRegister1517 = ShiftRight(uint32_t(r_PtxRegister1516), uint32_t(30));				// PTX L3280
	r_PtxRegister1518 = uint32_t(r_PtxRegister1516) + uint32_t(r_PtxRegister1517);			// PTX L3281
	r_PtxRegister1519 = r_PtxRegister1518 & -4;												// PTX L3282
	r_PtxRegister1520 = uint32_t(r_PtxRegister1516) - uint32_t(r_PtxRegister1519);			// PTX L3283
	r_PtxRegister1521 = ShiftRight(uint32_t(r_PtxRegister1513), uint32_t(28));				// PTX L3284
	r_PtxRegister1522 = uint32_t(r_LaneIndexAtPtx3274) + uint32_t(r_PtxRegister1521);		// PTX L3285
	r_PtxRegister1523 = ShiftRightSigned(int32_t(r_PtxRegister1522), uint32_t(4));			// PTX L3286
	r_PtxRegister1524 = uint32_t(r_PtxRegister1523) + uint32_t(r_PtxRegister4);				// PTX L3287
	r_PtxRegister1525 = uint32_t(r_PtxRegister1520) + uint32_t(r_PtxRegister5);				// PTX L3288
	r_PtxRegister1526 = uint32_t(r_PtxRegister1524) + uint32_t(4);							// PTX L3289
	r_PtxRegister146 = uint32_t(r_PtxRegister1525) + uint32_t(4);							// PTX L3290
	r_bPtxPredicate996 = int32_t(r_PtxRegister1526) < int32_t(0);							// PTX L3291
	r_bPtxPredicate997 = int32_t(r_PtxRegister1526) >= int32_t(r_HeightBits);				// PTX L3292
	r_bPtxPredicate998 = r_bPtxPredicate996 | r_bPtxPredicate997;							// PTX L3293
	r_bPtxPredicate999 = !r_bPtxPredicate998;												// PTX L3294
	r_PtxRegister147 = r_bPtxPredicate995 ? 0 : r_PtxRegister1526;							// PTX L3295
	r_bPtxPredicate1000 = r_bPtxPredicate994 & r_bPtxPredicate998;							// PTX L3296
	r_bPtxPredicate1001 = r_bPtxPredicate995 | r_bPtxPredicate999;							// PTX L3297
	r_bPtxPredicate1002 = r_bPtxPredicate1000 | r_bPtxPredicate980;							// PTX L3298
	r_bPtxPredicate1003 = int32_t(r_PtxRegister146) < int32_t(r_WidthBits);					// PTX L3299
	r_bPtxPredicate1004 = !r_bPtxPredicate1000;												// PTX L3300
	r_bPtxPredicate59 = r_bPtxPredicate980 & r_bPtxPredicate1004;							// PTX L3301
	r_bPtxPredicate1005 = r_bPtxPredicate1002 | r_bPtxPredicate1003;						// PTX L3302
	r_bPtxPredicate1006 = r_bPtxPredicate1005 & r_bPtxPredicate1001;						// PTX L3303
	r_PtxRegister2755 = uint32_t(0);														// PTX L3304
	r_bPtxPredicate1007 = !r_bPtxPredicate1006;												// PTX L3305
	if (r_bPtxPredicate1007)
	{
		goto L__BB18_184;
	} // PTX L3306
	r_PtxRegister1527 = r_PtxRegister1515 & -4;										  // PTX L3307
	r_PtxRegister1528 = uint32_t(r_LaneIndexAtPtx3274) - uint32_t(r_PtxRegister1527); // PTX L3308
	r_PtxRegister1529 = ShiftLeft(uint32_t(r_PtxRegister146), uint32_t(2));			  // PTX L3309
	r_PtxRegister1530 = r_bPtxPredicate59 ? 0 : r_PtxRegister1529;					  // PTX L3310
	r_PtxRegister1531 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister147); // PTX L3311
	r_PtxRegister1532 =
		uint32_t(r_PtxRegister1531) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1528); // PTX L3312
	r_PtxRegister1533 = uint32_t(r_PtxRegister1532) + uint32_t(r_PtxRegister1530);			   // PTX L3313
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister1533)) * int64_t(int32_t(4))); // PTX L3314
	g_ResidualByteAddressAtPtx3315 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register158);				// PTX L3315
	r_PtxRegister2755 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3315); // PTX L3316
L__BB18_184:																				// PTX L3317
	r_bPtxPredicate1008 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3318
	r_bPtxPredicate1009 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3319
	r_LaneIndexAtPtx3321 = uint32_t((threadIdx.x & 31u));									// PTX L3321
	r_PtxRegister1535 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3321), uint32_t(31));		// PTX L3323
	r_PtxRegister1536 = ShiftRight(uint32_t(r_PtxRegister1535), uint32_t(30));				// PTX L3324
	r_PtxRegister1537 = uint32_t(r_LaneIndexAtPtx3321) + uint32_t(r_PtxRegister1536);		// PTX L3325
	r_PtxRegister1538 = ShiftRightSigned(int32_t(r_PtxRegister1537), uint32_t(2));			// PTX L3326
	r_PtxRegister1539 = ShiftRight(uint32_t(r_PtxRegister1538), uint32_t(30));				// PTX L3327
	r_PtxRegister1540 = uint32_t(r_PtxRegister1538) + uint32_t(r_PtxRegister1539);			// PTX L3328
	r_PtxRegister1541 = r_PtxRegister1540 & -4;												// PTX L3329
	r_PtxRegister1542 = uint32_t(r_PtxRegister1538) - uint32_t(r_PtxRegister1541);			// PTX L3330
	r_PtxRegister1543 = ShiftRight(uint32_t(r_PtxRegister1535), uint32_t(28));				// PTX L3331
	r_PtxRegister1544 = uint32_t(r_LaneIndexAtPtx3321) + uint32_t(r_PtxRegister1543);		// PTX L3332
	r_PtxRegister1545 = ShiftRightSigned(int32_t(r_PtxRegister1544), uint32_t(4));			// PTX L3333
	r_PtxRegister1546 = uint32_t(r_PtxRegister1545) + uint32_t(r_PtxRegister4);				// PTX L3334
	r_PtxRegister1547 = uint32_t(r_PtxRegister1542) + uint32_t(r_PtxRegister5);				// PTX L3335
	r_PtxRegister1548 = uint32_t(r_PtxRegister1546) + uint32_t(6);							// PTX L3336
	r_PtxRegister148 = uint32_t(r_PtxRegister1547) + uint32_t(4);							// PTX L3337
	r_bPtxPredicate1010 = int32_t(r_PtxRegister1548) < int32_t(0);							// PTX L3338
	r_bPtxPredicate1011 = int32_t(r_PtxRegister1548) >= int32_t(r_HeightBits);				// PTX L3339
	r_bPtxPredicate1012 = r_bPtxPredicate1010 | r_bPtxPredicate1011;						// PTX L3340
	r_bPtxPredicate1013 = !r_bPtxPredicate1012;												// PTX L3341
	r_PtxRegister149 = r_bPtxPredicate1009 ? 0 : r_PtxRegister1548;							// PTX L3342
	r_bPtxPredicate1014 = r_bPtxPredicate994 & r_bPtxPredicate1012;							// PTX L3343
	r_bPtxPredicate1015 = r_bPtxPredicate1009 | r_bPtxPredicate1013;						// PTX L3344
	r_bPtxPredicate1016 = r_bPtxPredicate1014 | r_bPtxPredicate1008;						// PTX L3345
	r_bPtxPredicate1017 = int32_t(r_PtxRegister148) < int32_t(r_WidthBits);					// PTX L3346
	r_bPtxPredicate1018 = !r_bPtxPredicate1014;												// PTX L3347
	r_bPtxPredicate60 = r_bPtxPredicate1008 & r_bPtxPredicate1018;							// PTX L3348
	r_bPtxPredicate1019 = r_bPtxPredicate1016 | r_bPtxPredicate1017;						// PTX L3349
	r_bPtxPredicate1020 = r_bPtxPredicate1019 & r_bPtxPredicate1015;						// PTX L3350
	r_PtxRegister2756 = uint32_t(0);														// PTX L3351
	r_bPtxPredicate1021 = !r_bPtxPredicate1020;												// PTX L3352
	if (r_bPtxPredicate1021)
	{
		goto L__BB18_186;
	} // PTX L3353
	r_PtxRegister1549 = r_PtxRegister1537 & -4;										  // PTX L3354
	r_PtxRegister1550 = uint32_t(r_LaneIndexAtPtx3321) - uint32_t(r_PtxRegister1549); // PTX L3355
	r_PtxRegister1551 = ShiftLeft(uint32_t(r_PtxRegister148), uint32_t(2));			  // PTX L3356
	r_PtxRegister1552 = r_bPtxPredicate60 ? 0 : r_PtxRegister1551;					  // PTX L3357
	r_PtxRegister1553 =
		uint32_t(r_PtxRegister46) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister149); // PTX L3358
	r_PtxRegister1554 =
		uint32_t(r_PtxRegister1553) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1550); // PTX L3359
	r_PtxRegister1555 = uint32_t(r_PtxRegister1554) + uint32_t(r_PtxRegister1552);			   // PTX L3360
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister1555)) * int64_t(int32_t(4))); // PTX L3361
	g_ResidualByteAddressAtPtx3362 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register160);				// PTX L3362
	r_PtxRegister2756 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3362); // PTX L3363
L__BB18_186:																				// PTX L3364
	r_bPtxPredicate1022 = uint32_t(r_HeightBits) != uint32_t(1);							// PTX L3365
	r_bPtxPredicate1023 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3366
	r_LaneIndexAtPtx3368 = uint32_t((threadIdx.x & 31u));									// PTX L3368
	r_PtxRegister1557 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3368), uint32_t(31));		// PTX L3370
	r_PtxRegister1558 = ShiftRight(uint32_t(r_PtxRegister1557), uint32_t(30));				// PTX L3371
	r_PtxRegister1559 = uint32_t(r_LaneIndexAtPtx3368) + uint32_t(r_PtxRegister1558);		// PTX L3372
	r_PtxRegister1560 = ShiftRightSigned(int32_t(r_PtxRegister1559), uint32_t(2));			// PTX L3373
	r_PtxRegister1561 = ShiftRight(uint32_t(r_PtxRegister1560), uint32_t(30));				// PTX L3374
	r_PtxRegister1562 = uint32_t(r_PtxRegister1560) + uint32_t(r_PtxRegister1561);			// PTX L3375
	r_PtxRegister1563 = r_PtxRegister1562 & -4;												// PTX L3376
	r_PtxRegister1564 = uint32_t(r_PtxRegister1560) - uint32_t(r_PtxRegister1563);			// PTX L3377
	r_PtxRegister1565 = ShiftRight(uint32_t(r_PtxRegister1557), uint32_t(28));				// PTX L3378
	r_PtxRegister1566 = uint32_t(r_LaneIndexAtPtx3368) + uint32_t(r_PtxRegister1565);		// PTX L3379
	r_PtxRegister1567 = ShiftRightSigned(int32_t(r_PtxRegister1566), uint32_t(4));			// PTX L3380
	r_PtxRegister1568 = uint32_t(r_PtxRegister1567) + uint32_t(r_PtxRegister4);				// PTX L3381
	r_PtxRegister1569 = uint32_t(r_PtxRegister1564) + uint32_t(r_PtxRegister5);				// PTX L3382
	r_PtxRegister1570 = uint32_t(r_PtxRegister1568) + uint32_t(4);							// PTX L3383
	r_PtxRegister150 = uint32_t(r_PtxRegister1569) + uint32_t(4);							// PTX L3384
	r_bPtxPredicate1024 = int32_t(r_PtxRegister1570) < int32_t(0);							// PTX L3385
	r_bPtxPredicate1025 = int32_t(r_PtxRegister1570) >= int32_t(r_HeightBits);				// PTX L3386
	r_bPtxPredicate1026 = r_bPtxPredicate1024 | r_bPtxPredicate1025;						// PTX L3387
	r_bPtxPredicate1027 = !r_bPtxPredicate1026;												// PTX L3388
	r_PtxRegister151 = r_bPtxPredicate1023 ? 0 : r_PtxRegister1570;							// PTX L3389
	r_bPtxPredicate1028 = r_bPtxPredicate1022 & r_bPtxPredicate1026;						// PTX L3390
	r_bPtxPredicate1029 = r_bPtxPredicate1023 | r_bPtxPredicate1027;						// PTX L3391
	r_bPtxPredicate1030 = r_bPtxPredicate1028 | r_bPtxPredicate1008;						// PTX L3392
	r_bPtxPredicate1031 = int32_t(r_PtxRegister150) < int32_t(r_WidthBits);					// PTX L3393
	r_bPtxPredicate1032 = !r_bPtxPredicate1028;												// PTX L3394
	r_bPtxPredicate61 = r_bPtxPredicate1008 & r_bPtxPredicate1032;							// PTX L3395
	r_bPtxPredicate1033 = r_bPtxPredicate1030 | r_bPtxPredicate1031;						// PTX L3396
	r_bPtxPredicate1034 = r_bPtxPredicate1033 & r_bPtxPredicate1029;						// PTX L3397
	r_PtxRegister2757 = uint32_t(0);														// PTX L3398
	r_bPtxPredicate1035 = !r_bPtxPredicate1034;												// PTX L3399
	if (r_bPtxPredicate1035)
	{
		goto L__BB18_188;
	} // PTX L3400
	r_PtxRegister1571 = r_PtxRegister1559 & -4;										  // PTX L3401
	r_PtxRegister1572 = uint32_t(r_LaneIndexAtPtx3368) - uint32_t(r_PtxRegister1571); // PTX L3402
	r_PtxRegister1573 = ShiftLeft(uint32_t(r_PtxRegister150), uint32_t(2));			  // PTX L3403
	r_PtxRegister1574 = r_bPtxPredicate61 ? 0 : r_PtxRegister1573;					  // PTX L3404
	r_PtxRegister1575 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister151); // PTX L3405
	r_PtxRegister1576 =
		uint32_t(r_PtxRegister1575) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1572); // PTX L3406
	r_PtxRegister1577 = uint32_t(r_PtxRegister1576) + uint32_t(r_PtxRegister1574);			   // PTX L3407
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister1577)) * int64_t(int32_t(4))); // PTX L3408
	g_ResidualByteAddressAtPtx3409 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register162);				// PTX L3409
	r_PtxRegister2757 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3409); // PTX L3410
L__BB18_188:																				// PTX L3411
	r_bPtxPredicate1036 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3412
	r_bPtxPredicate1037 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3413
	r_LaneIndexAtPtx3415 = uint32_t((threadIdx.x & 31u));									// PTX L3415
	r_PtxRegister1579 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3415), uint32_t(31));		// PTX L3417
	r_PtxRegister1580 = ShiftRight(uint32_t(r_PtxRegister1579), uint32_t(30));				// PTX L3418
	r_PtxRegister1581 = uint32_t(r_LaneIndexAtPtx3415) + uint32_t(r_PtxRegister1580);		// PTX L3419
	r_PtxRegister1582 = ShiftRightSigned(int32_t(r_PtxRegister1581), uint32_t(2));			// PTX L3420
	r_PtxRegister1583 = ShiftRight(uint32_t(r_PtxRegister1582), uint32_t(30));				// PTX L3421
	r_PtxRegister1584 = uint32_t(r_PtxRegister1582) + uint32_t(r_PtxRegister1583);			// PTX L3422
	r_PtxRegister1585 = r_PtxRegister1584 & -4;												// PTX L3423
	r_PtxRegister1586 = uint32_t(r_PtxRegister1582) - uint32_t(r_PtxRegister1585);			// PTX L3424
	r_PtxRegister1587 = ShiftRight(uint32_t(r_PtxRegister1579), uint32_t(28));				// PTX L3425
	r_PtxRegister1588 = uint32_t(r_LaneIndexAtPtx3415) + uint32_t(r_PtxRegister1587);		// PTX L3426
	r_PtxRegister1589 = ShiftRightSigned(int32_t(r_PtxRegister1588), uint32_t(4));			// PTX L3427
	r_PtxRegister1590 = uint32_t(r_PtxRegister1589) + uint32_t(r_PtxRegister4);				// PTX L3428
	r_PtxRegister1591 = uint32_t(r_PtxRegister1586) + uint32_t(r_PtxRegister5);				// PTX L3429
	r_PtxRegister1592 = uint32_t(r_PtxRegister1590) + uint32_t(6);							// PTX L3430
	r_PtxRegister152 = uint32_t(r_PtxRegister1591) + uint32_t(4);							// PTX L3431
	r_bPtxPredicate1038 = int32_t(r_PtxRegister1592) < int32_t(0);							// PTX L3432
	r_bPtxPredicate1039 = int32_t(r_PtxRegister1592) >= int32_t(r_HeightBits);				// PTX L3433
	r_bPtxPredicate1040 = r_bPtxPredicate1038 | r_bPtxPredicate1039;						// PTX L3434
	r_bPtxPredicate1041 = !r_bPtxPredicate1040;												// PTX L3435
	r_PtxRegister153 = r_bPtxPredicate1037 ? 0 : r_PtxRegister1592;							// PTX L3436
	r_bPtxPredicate1042 = r_bPtxPredicate1022 & r_bPtxPredicate1040;						// PTX L3437
	r_bPtxPredicate1043 = r_bPtxPredicate1037 | r_bPtxPredicate1041;						// PTX L3438
	r_bPtxPredicate1044 = r_bPtxPredicate1042 | r_bPtxPredicate1036;						// PTX L3439
	r_bPtxPredicate1045 = int32_t(r_PtxRegister152) < int32_t(r_WidthBits);					// PTX L3440
	r_bPtxPredicate1046 = !r_bPtxPredicate1042;												// PTX L3441
	r_bPtxPredicate62 = r_bPtxPredicate1036 & r_bPtxPredicate1046;							// PTX L3442
	r_bPtxPredicate1047 = r_bPtxPredicate1044 | r_bPtxPredicate1045;						// PTX L3443
	r_bPtxPredicate1048 = r_bPtxPredicate1047 & r_bPtxPredicate1043;						// PTX L3444
	r_PtxRegister2758 = uint32_t(0);														// PTX L3445
	r_bPtxPredicate1049 = !r_bPtxPredicate1048;												// PTX L3446
	if (r_bPtxPredicate1049)
	{
		goto L__BB18_190;
	} // PTX L3447
	r_PtxRegister1593 = ShiftRight(uint32_t(r_PtxRegister1579), uint32_t(30));		  // PTX L3448
	r_PtxRegister1594 = uint32_t(r_LaneIndexAtPtx3415) + uint32_t(r_PtxRegister1593); // PTX L3449
	r_PtxRegister1595 = r_PtxRegister1594 & -4;										  // PTX L3450
	r_PtxRegister1596 = uint32_t(r_LaneIndexAtPtx3415) - uint32_t(r_PtxRegister1595); // PTX L3451
	r_PtxRegister1597 = ShiftLeft(uint32_t(r_PtxRegister152), uint32_t(2));			  // PTX L3452
	r_PtxRegister1598 = r_bPtxPredicate62 ? 0 : r_PtxRegister1597;					  // PTX L3453
	r_PtxRegister1599 =
		uint32_t(r_PtxRegister51) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister153); // PTX L3454
	r_PtxRegister1600 =
		uint32_t(r_PtxRegister1599) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1596); // PTX L3455
	r_PtxRegister1601 = uint32_t(r_PtxRegister1600) + uint32_t(r_PtxRegister1598);			   // PTX L3456
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister1601)) * int64_t(int32_t(4))); // PTX L3457
	g_ResidualByteAddressAtPtx3458 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register164);				// PTX L3458
	r_PtxRegister2758 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3458); // PTX L3459
L__BB18_190:																				// PTX L3460
	r_bPtxPredicate1050 = uint32_t(r_HeightBits) != uint32_t(1);							// PTX L3461
	r_bPtxPredicate1051 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3462
	r_LaneIndexAtPtx3464 = uint32_t((threadIdx.x & 31u));									// PTX L3464
	r_PtxRegister1603 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3464), uint32_t(31));		// PTX L3466
	r_PtxRegister1604 = ShiftRight(uint32_t(r_PtxRegister1603), uint32_t(30));				// PTX L3467
	r_PtxRegister1605 = uint32_t(r_LaneIndexAtPtx3464) + uint32_t(r_PtxRegister1604);		// PTX L3468
	r_PtxRegister1606 = ShiftRightSigned(int32_t(r_PtxRegister1605), uint32_t(2));			// PTX L3469
	r_PtxRegister1607 = ShiftRight(uint32_t(r_PtxRegister1606), uint32_t(30));				// PTX L3470
	r_PtxRegister1608 = uint32_t(r_PtxRegister1606) + uint32_t(r_PtxRegister1607);			// PTX L3471
	r_PtxRegister1609 = r_PtxRegister1608 & -4;												// PTX L3472
	r_PtxRegister1610 = uint32_t(r_PtxRegister1606) - uint32_t(r_PtxRegister1609);			// PTX L3473
	r_PtxRegister1611 = ShiftRight(uint32_t(r_PtxRegister1603), uint32_t(28));				// PTX L3474
	r_PtxRegister1612 = uint32_t(r_LaneIndexAtPtx3464) + uint32_t(r_PtxRegister1611);		// PTX L3475
	r_PtxRegister1613 = ShiftRightSigned(int32_t(r_PtxRegister1612), uint32_t(4));			// PTX L3476
	r_PtxRegister1614 = uint32_t(r_PtxRegister1613) + uint32_t(r_PtxRegister4);				// PTX L3477
	r_PtxRegister1615 = uint32_t(r_PtxRegister1610) + uint32_t(r_PtxRegister5);				// PTX L3478
	r_PtxRegister1616 = uint32_t(r_PtxRegister1614) + uint32_t(4);							// PTX L3479
	r_PtxRegister154 = uint32_t(r_PtxRegister1615) + uint32_t(4);							// PTX L3480
	r_bPtxPredicate1052 = int32_t(r_PtxRegister1616) < int32_t(0);							// PTX L3481
	r_bPtxPredicate1053 = int32_t(r_PtxRegister1616) >= int32_t(r_HeightBits);				// PTX L3482
	r_bPtxPredicate1054 = r_bPtxPredicate1052 | r_bPtxPredicate1053;						// PTX L3483
	r_bPtxPredicate1055 = !r_bPtxPredicate1054;												// PTX L3484
	r_PtxRegister155 = r_bPtxPredicate1051 ? 0 : r_PtxRegister1616;							// PTX L3485
	r_bPtxPredicate1056 = r_bPtxPredicate1050 & r_bPtxPredicate1054;						// PTX L3486
	r_bPtxPredicate1057 = r_bPtxPredicate1051 | r_bPtxPredicate1055;						// PTX L3487
	r_bPtxPredicate1058 = r_bPtxPredicate1056 | r_bPtxPredicate1036;						// PTX L3488
	r_bPtxPredicate1059 = int32_t(r_PtxRegister154) < int32_t(r_WidthBits);					// PTX L3489
	r_bPtxPredicate1060 = !r_bPtxPredicate1056;												// PTX L3490
	r_bPtxPredicate63 = r_bPtxPredicate1036 & r_bPtxPredicate1060;							// PTX L3491
	r_bPtxPredicate1061 = r_bPtxPredicate1058 | r_bPtxPredicate1059;						// PTX L3492
	r_bPtxPredicate1062 = r_bPtxPredicate1061 & r_bPtxPredicate1057;						// PTX L3493
	r_PtxRegister2759 = uint32_t(0);														// PTX L3494
	r_bPtxPredicate1063 = !r_bPtxPredicate1062;												// PTX L3495
	if (r_bPtxPredicate1063)
	{
		goto L__BB18_192;
	} // PTX L3496
	r_PtxRegister1617 = ShiftRight(uint32_t(r_PtxRegister1603), uint32_t(30));		  // PTX L3497
	r_PtxRegister1618 = uint32_t(r_LaneIndexAtPtx3464) + uint32_t(r_PtxRegister1617); // PTX L3498
	r_PtxRegister1619 = r_PtxRegister1618 & -4;										  // PTX L3499
	r_PtxRegister1620 = uint32_t(r_LaneIndexAtPtx3464) - uint32_t(r_PtxRegister1619); // PTX L3500
	r_PtxRegister1621 = ShiftLeft(uint32_t(r_PtxRegister154), uint32_t(2));			  // PTX L3501
	r_PtxRegister1622 = r_bPtxPredicate63 ? 0 : r_PtxRegister1621;					  // PTX L3502
	r_PtxRegister1623 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister155); // PTX L3503
	r_PtxRegister1624 =
		uint32_t(r_PtxRegister1623) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1620); // PTX L3504
	r_PtxRegister1625 = uint32_t(r_PtxRegister1624) + uint32_t(r_PtxRegister1622);			   // PTX L3505
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister1625)) * int64_t(int32_t(4))); // PTX L3506
	g_ResidualByteAddressAtPtx3507 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register166);				// PTX L3507
	r_PtxRegister2759 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3507); // PTX L3508
L__BB18_192:																				// PTX L3509
	r_bPtxPredicate1064 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3510
	r_bPtxPredicate1065 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3511
	r_LaneIndexAtPtx3513 = uint32_t((threadIdx.x & 31u));									// PTX L3513
	r_PtxRegister1627 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3513), uint32_t(31));		// PTX L3515
	r_PtxRegister1628 = ShiftRight(uint32_t(r_PtxRegister1627), uint32_t(30));				// PTX L3516
	r_PtxRegister1629 = uint32_t(r_LaneIndexAtPtx3513) + uint32_t(r_PtxRegister1628);		// PTX L3517
	r_PtxRegister1630 = ShiftRightSigned(int32_t(r_PtxRegister1629), uint32_t(2));			// PTX L3518
	r_PtxRegister1631 = ShiftRight(uint32_t(r_PtxRegister1630), uint32_t(30));				// PTX L3519
	r_PtxRegister1632 = uint32_t(r_PtxRegister1630) + uint32_t(r_PtxRegister1631);			// PTX L3520
	r_PtxRegister1633 = r_PtxRegister1632 & -4;												// PTX L3521
	r_PtxRegister1634 = uint32_t(r_PtxRegister1630) - uint32_t(r_PtxRegister1633);			// PTX L3522
	r_PtxRegister1635 = ShiftRight(uint32_t(r_PtxRegister1627), uint32_t(28));				// PTX L3523
	r_PtxRegister1636 = uint32_t(r_LaneIndexAtPtx3513) + uint32_t(r_PtxRegister1635);		// PTX L3524
	r_PtxRegister1637 = ShiftRightSigned(int32_t(r_PtxRegister1636), uint32_t(4));			// PTX L3525
	r_PtxRegister1638 = uint32_t(r_PtxRegister1637) + uint32_t(r_PtxRegister4);				// PTX L3526
	r_PtxRegister1639 = uint32_t(r_PtxRegister1634) + uint32_t(r_PtxRegister5);				// PTX L3527
	r_PtxRegister1640 = uint32_t(r_PtxRegister1638) + uint32_t(6);							// PTX L3528
	r_PtxRegister156 = uint32_t(r_PtxRegister1639) + uint32_t(4);							// PTX L3529
	r_bPtxPredicate1066 = int32_t(r_PtxRegister1640) < int32_t(0);							// PTX L3530
	r_bPtxPredicate1067 = int32_t(r_PtxRegister1640) >= int32_t(r_HeightBits);				// PTX L3531
	r_bPtxPredicate1068 = r_bPtxPredicate1066 | r_bPtxPredicate1067;						// PTX L3532
	r_bPtxPredicate1069 = !r_bPtxPredicate1068;												// PTX L3533
	r_PtxRegister157 = r_bPtxPredicate1065 ? 0 : r_PtxRegister1640;							// PTX L3534
	r_bPtxPredicate1070 = r_bPtxPredicate1050 & r_bPtxPredicate1068;						// PTX L3535
	r_bPtxPredicate1071 = r_bPtxPredicate1065 | r_bPtxPredicate1069;						// PTX L3536
	r_bPtxPredicate1072 = r_bPtxPredicate1070 | r_bPtxPredicate1064;						// PTX L3537
	r_bPtxPredicate1073 = int32_t(r_PtxRegister156) < int32_t(r_WidthBits);					// PTX L3538
	r_bPtxPredicate1074 = !r_bPtxPredicate1070;												// PTX L3539
	r_bPtxPredicate64 = r_bPtxPredicate1064 & r_bPtxPredicate1074;							// PTX L3540
	r_bPtxPredicate1075 = r_bPtxPredicate1072 | r_bPtxPredicate1073;						// PTX L3541
	r_bPtxPredicate1076 = r_bPtxPredicate1075 & r_bPtxPredicate1071;						// PTX L3542
	r_PtxRegister2760 = uint32_t(0);														// PTX L3543
	r_bPtxPredicate1077 = !r_bPtxPredicate1076;												// PTX L3544
	if (r_bPtxPredicate1077)
	{
		goto L__BB18_194;
	} // PTX L3545
	r_PtxRegister1641 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3513), uint32_t(31)); // PTX L3546
	r_PtxRegister1642 = ShiftRight(uint32_t(r_PtxRegister1641), uint32_t(30));		   // PTX L3547
	r_PtxRegister1643 = uint32_t(r_LaneIndexAtPtx3513) + uint32_t(r_PtxRegister1642);  // PTX L3548
	r_PtxRegister1644 = r_PtxRegister1643 & -4;										   // PTX L3549
	r_PtxRegister1645 = uint32_t(r_LaneIndexAtPtx3513) - uint32_t(r_PtxRegister1644);  // PTX L3550
	r_PtxRegister1646 = ShiftLeft(uint32_t(r_PtxRegister156), uint32_t(2));			   // PTX L3551
	r_PtxRegister1647 = r_bPtxPredicate64 ? 0 : r_PtxRegister1646;					   // PTX L3552
	r_PtxRegister1648 =
		uint32_t(r_PtxRegister56) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister157); // PTX L3553
	r_PtxRegister1649 =
		uint32_t(r_PtxRegister1648) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1645); // PTX L3554
	r_PtxRegister1650 = uint32_t(r_PtxRegister1649) + uint32_t(r_PtxRegister1647);			   // PTX L3555
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister1650)) * int64_t(int32_t(4))); // PTX L3556
	g_ResidualByteAddressAtPtx3557 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register168);				// PTX L3557
	r_PtxRegister2760 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3557); // PTX L3558
L__BB18_194:																				// PTX L3559
	r_bPtxPredicate65 = uint32_t(r_HeightBits) != uint32_t(1);								// PTX L3560
	r_bPtxPredicate1078 = uint32_t(r_HeightBits) == uint32_t(1);							// PTX L3561
	r_LaneIndexAtPtx3563 = uint32_t((threadIdx.x & 31u));									// PTX L3563
	r_PtxRegister1652 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3563), uint32_t(31));		// PTX L3565
	r_PtxRegister1653 = ShiftRight(uint32_t(r_PtxRegister1652), uint32_t(30));				// PTX L3566
	r_PtxRegister1654 = uint32_t(r_LaneIndexAtPtx3563) + uint32_t(r_PtxRegister1653);		// PTX L3567
	r_PtxRegister1655 = ShiftRightSigned(int32_t(r_PtxRegister1654), uint32_t(2));			// PTX L3568
	r_PtxRegister1656 = ShiftRight(uint32_t(r_PtxRegister1655), uint32_t(30));				// PTX L3569
	r_PtxRegister1657 = uint32_t(r_PtxRegister1655) + uint32_t(r_PtxRegister1656);			// PTX L3570
	r_PtxRegister1658 = r_PtxRegister1657 & -4;												// PTX L3571
	r_PtxRegister1659 = uint32_t(r_PtxRegister1655) - uint32_t(r_PtxRegister1658);			// PTX L3572
	r_PtxRegister1660 = ShiftRight(uint32_t(r_PtxRegister1652), uint32_t(28));				// PTX L3573
	r_PtxRegister1661 = uint32_t(r_LaneIndexAtPtx3563) + uint32_t(r_PtxRegister1660);		// PTX L3574
	r_PtxRegister1662 = ShiftRightSigned(int32_t(r_PtxRegister1661), uint32_t(4));			// PTX L3575
	r_PtxRegister1663 = uint32_t(r_PtxRegister1662) + uint32_t(r_PtxRegister4);				// PTX L3576
	r_PtxRegister1664 = uint32_t(r_PtxRegister1659) + uint32_t(r_PtxRegister5);				// PTX L3577
	r_PtxRegister1665 = uint32_t(r_PtxRegister1663) + uint32_t(4);							// PTX L3578
	r_PtxRegister158 = uint32_t(r_PtxRegister1664) + uint32_t(4);							// PTX L3579
	r_bPtxPredicate1079 = int32_t(r_PtxRegister1665) < int32_t(0);							// PTX L3580
	r_bPtxPredicate1080 = int32_t(r_PtxRegister1665) >= int32_t(r_HeightBits);				// PTX L3581
	r_bPtxPredicate1081 = r_bPtxPredicate1079 | r_bPtxPredicate1080;						// PTX L3582
	r_bPtxPredicate1082 = !r_bPtxPredicate1081;												// PTX L3583
	r_PtxRegister159 = r_bPtxPredicate1078 ? 0 : r_PtxRegister1665;							// PTX L3584
	r_bPtxPredicate1083 = r_bPtxPredicate65 & r_bPtxPredicate1081;							// PTX L3585
	r_bPtxPredicate1084 = r_bPtxPredicate1078 | r_bPtxPredicate1082;						// PTX L3586
	r_bPtxPredicate1085 = r_bPtxPredicate1083 | r_bPtxPredicate1064;						// PTX L3587
	r_bPtxPredicate1086 = int32_t(r_PtxRegister158) < int32_t(r_WidthBits);					// PTX L3588
	r_bPtxPredicate1087 = !r_bPtxPredicate1083;												// PTX L3589
	r_bPtxPredicate66 = r_bPtxPredicate1064 & r_bPtxPredicate1087;							// PTX L3590
	r_bPtxPredicate1088 = r_bPtxPredicate1085 | r_bPtxPredicate1086;						// PTX L3591
	r_bPtxPredicate1089 = r_bPtxPredicate1088 & r_bPtxPredicate1084;						// PTX L3592
	r_PtxRegister2761 = uint32_t(0);														// PTX L3593
	r_bPtxPredicate1090 = !r_bPtxPredicate1089;												// PTX L3594
	if (r_bPtxPredicate1090)
	{
		goto L__BB18_196;
	} // PTX L3595
	r_PtxRegister1666 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3563), uint32_t(31)); // PTX L3596
	r_PtxRegister1667 = ShiftRight(uint32_t(r_PtxRegister1666), uint32_t(30));		   // PTX L3597
	r_PtxRegister1668 = uint32_t(r_LaneIndexAtPtx3563) + uint32_t(r_PtxRegister1667);  // PTX L3598
	r_PtxRegister1669 = r_PtxRegister1668 & -4;										   // PTX L3599
	r_PtxRegister1670 = uint32_t(r_LaneIndexAtPtx3563) - uint32_t(r_PtxRegister1669);  // PTX L3600
	r_PtxRegister1671 = ShiftLeft(uint32_t(r_PtxRegister158), uint32_t(2));			   // PTX L3601
	r_PtxRegister1672 = r_bPtxPredicate66 ? 0 : r_PtxRegister1671;					   // PTX L3602
	r_PtxRegister1673 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister159); // PTX L3603
	r_PtxRegister1674 =
		uint32_t(r_PtxRegister1673) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1670); // PTX L3604
	r_PtxRegister1675 = uint32_t(r_PtxRegister1674) + uint32_t(r_PtxRegister1672);			   // PTX L3605
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister1675)) * int64_t(int32_t(4))); // PTX L3606
	g_ResidualByteAddressAtPtx3607 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register170);				// PTX L3607
	r_PtxRegister2761 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3607); // PTX L3608
L__BB18_196:																				// PTX L3609
	r_bPtxPredicate1091 = uint32_t(r_WidthBits) == uint32_t(1);								// PTX L3610
	r_LaneIndexAtPtx3612 = uint32_t((threadIdx.x & 31u));									// PTX L3612
	r_PtxRegister1677 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3612), uint32_t(31));		// PTX L3614
	r_PtxRegister1678 = ShiftRight(uint32_t(r_PtxRegister1677), uint32_t(30));				// PTX L3615
	r_PtxRegister1679 = uint32_t(r_LaneIndexAtPtx3612) + uint32_t(r_PtxRegister1678);		// PTX L3616
	r_PtxRegister1680 = ShiftRightSigned(int32_t(r_PtxRegister1679), uint32_t(2));			// PTX L3617
	r_PtxRegister1681 = ShiftRight(uint32_t(r_PtxRegister1680), uint32_t(30));				// PTX L3618
	r_PtxRegister1682 = uint32_t(r_PtxRegister1680) + uint32_t(r_PtxRegister1681);			// PTX L3619
	r_PtxRegister1683 = r_PtxRegister1682 & -4;												// PTX L3620
	r_PtxRegister1684 = uint32_t(r_PtxRegister1680) - uint32_t(r_PtxRegister1683);			// PTX L3621
	r_PtxRegister1685 = ShiftRight(uint32_t(r_PtxRegister1677), uint32_t(28));				// PTX L3622
	r_PtxRegister1686 = uint32_t(r_LaneIndexAtPtx3612) + uint32_t(r_PtxRegister1685);		// PTX L3623
	r_PtxRegister1687 = ShiftRightSigned(int32_t(r_PtxRegister1686), uint32_t(4));			// PTX L3624
	r_PtxRegister1688 = uint32_t(r_PtxRegister1687) + uint32_t(r_PtxRegister4);				// PTX L3625
	r_PtxRegister1689 = uint32_t(r_PtxRegister1684) + uint32_t(r_PtxRegister5);				// PTX L3626
	r_PtxRegister1690 = uint32_t(r_PtxRegister1688) + uint32_t(6);							// PTX L3627
	r_PtxRegister160 = uint32_t(r_PtxRegister1689) + uint32_t(4);							// PTX L3628
	r_bPtxPredicate1092 = int32_t(r_PtxRegister1690) < int32_t(0);							// PTX L3629
	r_bPtxPredicate1093 = int32_t(r_PtxRegister1690) >= int32_t(r_HeightBits);				// PTX L3630
	r_bPtxPredicate1094 = r_bPtxPredicate1092 | r_bPtxPredicate1093;						// PTX L3631
	r_bPtxPredicate1095 = !r_bPtxPredicate1094;												// PTX L3632
	r_PtxRegister161 = r_bPtxPredicate1078 ? 0 : r_PtxRegister1690;							// PTX L3633
	r_bPtxPredicate1096 = r_bPtxPredicate65 & r_bPtxPredicate1094;							// PTX L3634
	r_bPtxPredicate1097 = r_bPtxPredicate1078 | r_bPtxPredicate1095;						// PTX L3635
	r_bPtxPredicate1098 = r_bPtxPredicate1096 | r_bPtxPredicate1091;						// PTX L3636
	r_bPtxPredicate1099 = int32_t(r_PtxRegister160) < int32_t(r_WidthBits);					// PTX L3637
	r_bPtxPredicate1100 = !r_bPtxPredicate1096;												// PTX L3638
	r_bPtxPredicate67 = r_bPtxPredicate1091 & r_bPtxPredicate1100;							// PTX L3639
	r_bPtxPredicate1101 = r_bPtxPredicate1098 | r_bPtxPredicate1099;						// PTX L3640
	r_bPtxPredicate1102 = r_bPtxPredicate1101 & r_bPtxPredicate1097;						// PTX L3641
	r_PtxRegister2762 = uint32_t(0);														// PTX L3642
	r_bPtxPredicate1103 = !r_bPtxPredicate1102;												// PTX L3643
	if (r_bPtxPredicate1103)
	{
		goto L__BB18_198;
	} // PTX L3644
	r_PtxRegister1691 = ShiftRight(uint32_t(r_PtxRegister1677), uint32_t(30));		  // PTX L3645
	r_PtxRegister1692 = uint32_t(r_LaneIndexAtPtx3612) + uint32_t(r_PtxRegister1691); // PTX L3646
	r_PtxRegister1693 = r_PtxRegister1692 & -4;										  // PTX L3647
	r_PtxRegister1694 = uint32_t(r_LaneIndexAtPtx3612) - uint32_t(r_PtxRegister1693); // PTX L3648
	r_PtxRegister1695 = ShiftLeft(uint32_t(r_PtxRegister160), uint32_t(2));			  // PTX L3649
	r_PtxRegister1696 = r_bPtxPredicate67 ? 0 : r_PtxRegister1695;					  // PTX L3650
	r_PtxRegister1697 =
		uint32_t(r_PtxRegister61) * uint32_t(r_HeightBits) + uint32_t(r_PtxRegister161); // PTX L3651
	r_PtxRegister1698 =
		uint32_t(r_PtxRegister1697) * uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1694); // PTX L3652
	r_PtxRegister1699 = uint32_t(r_PtxRegister1698) + uint32_t(r_PtxRegister1696);			   // PTX L3653
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister1699)) * int64_t(int32_t(4))); // PTX L3654
	g_ResidualByteAddressAtPtx3655 =
		uint64_t(g_ResidualByteAddressAtPtx19) + uint64_t(r_PtxU64Register172);				   // PTX L3655
	r_PtxRegister2762 = *reinterpret_cast<const uint32_t*>(g_ResidualByteAddressAtPtx3655);	   // PTX L3656
L__BB18_198:																				   // PTX L3657
	r_PtxRegister1892 = uint32_t(r_PtxRegister10) + uint32_t(16);							   // PTX L3658
	g_RecordByteAddressAtPtx3659 = g_RecordBaseAddress;										   // PTX L3659
	r_PtxRegister1893 = uint32_t(r_PtxRegister10) + uint32_t(8);							   // PTX L3660
	r_LaneIndexAtPtx3662 = uint32_t((threadIdx.x & 31u));									   // PTX L3662
	r_PtxRegister1894 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3662), uint32_t(31));		   // PTX L3664
	r_PtxRegister1895 = ShiftRight(uint32_t(r_PtxRegister1894), uint32_t(30));				   // PTX L3665
	r_PtxRegister1896 = uint32_t(r_LaneIndexAtPtx3662) + uint32_t(r_PtxRegister1895);		   // PTX L3666
	r_PtxRegister1897 = r_PtxRegister1896 & 2147483644;										   // PTX L3667
	r_PtxRegister1898 = uint32_t(r_LaneIndexAtPtx3662) - uint32_t(r_PtxRegister1897);		   // PTX L3668
	r_PtxRegister1899 = ShiftLeft(uint32_t(r_PtxRegister1898), uint32_t(1));				   // PTX L3669
	r_PtxRegister1900 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1899);			   // PTX L3670
	r_PtxRegister1901 = ShiftRightSigned(int32_t(r_PtxRegister1900), uint32_t(1));			   // PTX L3671
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister1901)) * int64_t(int32_t(4))); // PTX L3672
	g_RecordByteAddressAtPtx3673 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register175); // PTX L3673
	r_PtxRegister1765 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3673 + 524288ull);		   // PTX L3674
	r_LaneIndexAtPtx3676 = uint32_t((threadIdx.x & 31u));									   // PTX L3676
	r_PtxRegister1902 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3676), uint32_t(31));		   // PTX L3678
	r_PtxRegister1903 = ShiftRight(uint32_t(r_PtxRegister1902), uint32_t(30));				   // PTX L3679
	r_PtxRegister1904 = uint32_t(r_LaneIndexAtPtx3676) + uint32_t(r_PtxRegister1903);		   // PTX L3680
	r_PtxRegister1905 = r_PtxRegister1904 & 2147483644;										   // PTX L3681
	r_PtxRegister1906 = uint32_t(r_LaneIndexAtPtx3676) - uint32_t(r_PtxRegister1905);		   // PTX L3682
	r_PtxRegister1907 = ShiftLeft(uint32_t(r_PtxRegister1906), uint32_t(1));				   // PTX L3683
	r_PtxRegister1908 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1907);			   // PTX L3684
	r_PtxRegister1909 = ShiftRightSigned(int32_t(r_PtxRegister1908), uint32_t(1));			   // PTX L3685
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister1909)) * int64_t(int32_t(4))); // PTX L3686
	g_RecordByteAddressAtPtx3687 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register177); // PTX L3687
	r_PtxRegister1767 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3687 + 524288ull);		   // PTX L3688
	r_LaneIndexAtPtx3690 = uint32_t((threadIdx.x & 31u));									   // PTX L3690
	r_PtxRegister1910 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3690), uint32_t(31));		   // PTX L3692
	r_PtxRegister1911 = ShiftRight(uint32_t(r_PtxRegister1910), uint32_t(30));				   // PTX L3693
	r_PtxRegister1912 = uint32_t(r_LaneIndexAtPtx3690) + uint32_t(r_PtxRegister1911);		   // PTX L3694
	r_PtxRegister1913 = r_PtxRegister1912 & 2147483644;										   // PTX L3695
	r_PtxRegister1914 = uint32_t(r_LaneIndexAtPtx3690) - uint32_t(r_PtxRegister1913);		   // PTX L3696
	r_PtxRegister1915 = ShiftLeft(uint32_t(r_PtxRegister1914), uint32_t(1));				   // PTX L3697
	r_PtxRegister1916 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister1915);			   // PTX L3698
	r_PtxRegister1917 = ShiftRightSigned(int32_t(r_PtxRegister1916), uint32_t(1));			   // PTX L3699
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister1917)) * int64_t(int32_t(4))); // PTX L3700
	g_RecordByteAddressAtPtx3701 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register179); // PTX L3701
	r_PtxRegister1769 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3701 + 524288ull);		   // PTX L3702
	r_LaneIndexAtPtx3704 = uint32_t((threadIdx.x & 31u));									   // PTX L3704
	r_PtxRegister1918 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3704), uint32_t(31));		   // PTX L3706
	r_PtxRegister1919 = ShiftRight(uint32_t(r_PtxRegister1918), uint32_t(30));				   // PTX L3707
	r_PtxRegister1920 = uint32_t(r_LaneIndexAtPtx3704) + uint32_t(r_PtxRegister1919);		   // PTX L3708
	r_PtxRegister1921 = r_PtxRegister1920 & 2147483644;										   // PTX L3709
	r_PtxRegister1922 = uint32_t(r_LaneIndexAtPtx3704) - uint32_t(r_PtxRegister1921);		   // PTX L3710
	r_PtxRegister1923 = ShiftLeft(uint32_t(r_PtxRegister1922), uint32_t(1));				   // PTX L3711
	r_PtxRegister1924 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister1923);			   // PTX L3712
	r_PtxRegister1925 = ShiftRightSigned(int32_t(r_PtxRegister1924), uint32_t(1));			   // PTX L3713
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister1925)) * int64_t(int32_t(4))); // PTX L3714
	g_RecordByteAddressAtPtx3715 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register181); // PTX L3715
	r_PtxRegister1771 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3715 + 524288ull);		   // PTX L3716
	r_LaneIndexAtPtx3718 = uint32_t((threadIdx.x & 31u));									   // PTX L3718
	r_PtxRegister1926 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3718), uint32_t(31));		   // PTX L3720
	r_PtxRegister1927 = ShiftRight(uint32_t(r_PtxRegister1926), uint32_t(30));				   // PTX L3721
	r_PtxRegister1928 = uint32_t(r_LaneIndexAtPtx3718) + uint32_t(r_PtxRegister1927);		   // PTX L3722
	r_PtxRegister1929 = r_PtxRegister1928 & 2147483644;										   // PTX L3723
	r_PtxRegister1930 = uint32_t(r_LaneIndexAtPtx3718) - uint32_t(r_PtxRegister1929);		   // PTX L3724
	r_PtxRegister1931 = ShiftLeft(uint32_t(r_PtxRegister1930), uint32_t(1));				   // PTX L3725
	r_PtxRegister1932 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister1931);			   // PTX L3726
	r_PtxRegister1933 = ShiftRightSigned(int32_t(r_PtxRegister1932), uint32_t(1));			   // PTX L3727
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister1933)) * int64_t(int32_t(4))); // PTX L3728
	g_RecordByteAddressAtPtx3729 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register183); // PTX L3729
	r_PtxRegister1773 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3729 + 524288ull);		   // PTX L3730
	r_LaneIndexAtPtx3732 = uint32_t((threadIdx.x & 31u));									   // PTX L3732
	r_PtxRegister1934 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3732), uint32_t(31));		   // PTX L3734
	r_PtxRegister1935 = ShiftRight(uint32_t(r_PtxRegister1934), uint32_t(30));				   // PTX L3735
	r_PtxRegister1936 = uint32_t(r_LaneIndexAtPtx3732) + uint32_t(r_PtxRegister1935);		   // PTX L3736
	r_PtxRegister1937 = r_PtxRegister1936 & 2147483644;										   // PTX L3737
	r_PtxRegister1938 = uint32_t(r_LaneIndexAtPtx3732) - uint32_t(r_PtxRegister1937);		   // PTX L3738
	r_PtxRegister1939 = ShiftLeft(uint32_t(r_PtxRegister1938), uint32_t(1));				   // PTX L3739
	r_PtxRegister1940 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister1939);			   // PTX L3740
	r_PtxRegister1941 = ShiftRightSigned(int32_t(r_PtxRegister1940), uint32_t(1));			   // PTX L3741
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister1941)) * int64_t(int32_t(4))); // PTX L3742
	g_RecordByteAddressAtPtx3743 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register185); // PTX L3743
	r_PtxRegister1775 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3743 + 524288ull);		   // PTX L3744
	r_LaneIndexAtPtx3746 = uint32_t((threadIdx.x & 31u));									   // PTX L3746
	r_PtxRegister1942 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3746), uint32_t(31));		   // PTX L3748
	r_PtxRegister1943 = ShiftRight(uint32_t(r_PtxRegister1942), uint32_t(30));				   // PTX L3749
	r_PtxRegister1944 = uint32_t(r_LaneIndexAtPtx3746) + uint32_t(r_PtxRegister1943);		   // PTX L3750
	r_PtxRegister1945 = r_PtxRegister1944 & 2147483644;										   // PTX L3751
	r_PtxRegister1946 = uint32_t(r_LaneIndexAtPtx3746) - uint32_t(r_PtxRegister1945);		   // PTX L3752
	r_PtxRegister1947 = ShiftLeft(uint32_t(r_PtxRegister1946), uint32_t(1));				   // PTX L3753
	r_PtxRegister1948 = uint32_t(r_PtxRegister10) + uint32_t(24);							   // PTX L3754
	r_PtxRegister1949 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister1947);			   // PTX L3755
	r_PtxRegister1950 = ShiftRight(uint32_t(r_PtxRegister1949), uint32_t(31));				   // PTX L3756
	r_PtxRegister1951 = uint32_t(r_PtxRegister1949) + uint32_t(r_PtxRegister1950);			   // PTX L3757
	r_PtxRegister1952 = ShiftRightSigned(int32_t(r_PtxRegister1951), uint32_t(1));			   // PTX L3758
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister1952)) * int64_t(int32_t(4))); // PTX L3759
	g_RecordByteAddressAtPtx3760 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register187); // PTX L3760
	r_PtxRegister1777 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3760 + 524288ull);		   // PTX L3761
	r_LaneIndexAtPtx3763 = uint32_t((threadIdx.x & 31u));									   // PTX L3763
	r_PtxRegister1953 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3763), uint32_t(31));		   // PTX L3765
	r_PtxRegister1954 = ShiftRight(uint32_t(r_PtxRegister1953), uint32_t(30));				   // PTX L3766
	r_PtxRegister1955 = uint32_t(r_LaneIndexAtPtx3763) + uint32_t(r_PtxRegister1954);		   // PTX L3767
	r_PtxRegister1956 = r_PtxRegister1955 & 2147483644;										   // PTX L3768
	r_PtxRegister1957 = uint32_t(r_LaneIndexAtPtx3763) - uint32_t(r_PtxRegister1956);		   // PTX L3769
	r_PtxRegister1958 = ShiftLeft(uint32_t(r_PtxRegister1957), uint32_t(1));				   // PTX L3770
	r_PtxRegister1959 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister1958);			   // PTX L3771
	r_PtxRegister1960 = ShiftRight(uint32_t(r_PtxRegister1959), uint32_t(31));				   // PTX L3772
	r_PtxRegister1961 = uint32_t(r_PtxRegister1959) + uint32_t(r_PtxRegister1960);			   // PTX L3773
	r_PtxRegister1962 = ShiftRightSigned(int32_t(r_PtxRegister1961), uint32_t(1));			   // PTX L3774
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister1962)) * int64_t(int32_t(4))); // PTX L3775
	g_RecordByteAddressAtPtx3776 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register189); // PTX L3776
	r_PtxRegister1779 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3776 + 524288ull);		   // PTX L3777
	r_LaneIndexAtPtx3779 = uint32_t((threadIdx.x & 31u));									   // PTX L3779
	r_PtxRegister1963 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3779), uint32_t(31));		   // PTX L3781
	r_PtxRegister1964 = ShiftRight(uint32_t(r_PtxRegister1963), uint32_t(30));				   // PTX L3782
	r_PtxRegister1965 = uint32_t(r_LaneIndexAtPtx3779) + uint32_t(r_PtxRegister1964);		   // PTX L3783
	r_PtxRegister1966 = r_PtxRegister1965 & 2147483644;										   // PTX L3784
	r_PtxRegister1967 = uint32_t(r_LaneIndexAtPtx3779) - uint32_t(r_PtxRegister1966);		   // PTX L3785
	r_PtxRegister1968 = ShiftLeft(uint32_t(r_PtxRegister1967), uint32_t(1));				   // PTX L3786
	r_PtxRegister1969 = uint32_t(r_PtxRegister10) + uint32_t(32);							   // PTX L3787
	r_PtxRegister1970 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister1968);			   // PTX L3788
	r_PtxRegister1971 = ShiftRightSigned(int32_t(r_PtxRegister1970), uint32_t(1));			   // PTX L3789
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister1971)) * int64_t(int32_t(4))); // PTX L3790
	g_RecordByteAddressAtPtx3791 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register191); // PTX L3791
	r_PtxRegister1781 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3791 + 524288ull);		   // PTX L3792
	r_LaneIndexAtPtx3794 = uint32_t((threadIdx.x & 31u));									   // PTX L3794
	r_PtxRegister1972 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3794), uint32_t(31));		   // PTX L3796
	r_PtxRegister1973 = ShiftRight(uint32_t(r_PtxRegister1972), uint32_t(30));				   // PTX L3797
	r_PtxRegister1974 = uint32_t(r_LaneIndexAtPtx3794) + uint32_t(r_PtxRegister1973);		   // PTX L3798
	r_PtxRegister1975 = r_PtxRegister1974 & 2147483644;										   // PTX L3799
	r_PtxRegister1976 = uint32_t(r_LaneIndexAtPtx3794) - uint32_t(r_PtxRegister1975);		   // PTX L3800
	r_PtxRegister1977 = ShiftLeft(uint32_t(r_PtxRegister1976), uint32_t(1));				   // PTX L3801
	r_PtxRegister1978 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister1977);			   // PTX L3802
	r_PtxRegister1979 = ShiftRightSigned(int32_t(r_PtxRegister1978), uint32_t(1));			   // PTX L3803
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister1979)) * int64_t(int32_t(4))); // PTX L3804
	g_RecordByteAddressAtPtx3805 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register193); // PTX L3805
	r_PtxRegister1783 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3805 + 524288ull);		   // PTX L3806
	r_LaneIndexAtPtx3808 = uint32_t((threadIdx.x & 31u));									   // PTX L3808
	r_PtxRegister1980 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3808), uint32_t(31));		   // PTX L3810
	r_PtxRegister1981 = ShiftRight(uint32_t(r_PtxRegister1980), uint32_t(30));				   // PTX L3811
	r_PtxRegister1982 = uint32_t(r_LaneIndexAtPtx3808) + uint32_t(r_PtxRegister1981);		   // PTX L3812
	r_PtxRegister1983 = r_PtxRegister1982 & 2147483644;										   // PTX L3813
	r_PtxRegister1984 = uint32_t(r_LaneIndexAtPtx3808) - uint32_t(r_PtxRegister1983);		   // PTX L3814
	r_PtxRegister1985 = ShiftLeft(uint32_t(r_PtxRegister1984), uint32_t(1));				   // PTX L3815
	r_PtxRegister1986 = uint32_t(r_PtxRegister10) + uint32_t(40);							   // PTX L3816
	r_PtxRegister1987 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister1985);			   // PTX L3817
	r_PtxRegister1988 = ShiftRight(uint32_t(r_PtxRegister1987), uint32_t(31));				   // PTX L3818
	r_PtxRegister1989 = uint32_t(r_PtxRegister1987) + uint32_t(r_PtxRegister1988);			   // PTX L3819
	r_PtxRegister1990 = ShiftRightSigned(int32_t(r_PtxRegister1989), uint32_t(1));			   // PTX L3820
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister1990)) * int64_t(int32_t(4))); // PTX L3821
	g_RecordByteAddressAtPtx3822 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register195); // PTX L3822
	r_PtxRegister1785 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3822 + 524288ull);		   // PTX L3823
	r_LaneIndexAtPtx3825 = uint32_t((threadIdx.x & 31u));									   // PTX L3825
	r_PtxRegister1991 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3825), uint32_t(31));		   // PTX L3827
	r_PtxRegister1992 = ShiftRight(uint32_t(r_PtxRegister1991), uint32_t(30));				   // PTX L3828
	r_PtxRegister1993 = uint32_t(r_LaneIndexAtPtx3825) + uint32_t(r_PtxRegister1992);		   // PTX L3829
	r_PtxRegister1994 = r_PtxRegister1993 & 2147483644;										   // PTX L3830
	r_PtxRegister1995 = uint32_t(r_LaneIndexAtPtx3825) - uint32_t(r_PtxRegister1994);		   // PTX L3831
	r_PtxRegister1996 = ShiftLeft(uint32_t(r_PtxRegister1995), uint32_t(1));				   // PTX L3832
	r_PtxRegister1997 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister1996);			   // PTX L3833
	r_PtxRegister1998 = ShiftRight(uint32_t(r_PtxRegister1997), uint32_t(31));				   // PTX L3834
	r_PtxRegister1999 = uint32_t(r_PtxRegister1997) + uint32_t(r_PtxRegister1998);			   // PTX L3835
	r_PtxRegister2000 = ShiftRightSigned(int32_t(r_PtxRegister1999), uint32_t(1));			   // PTX L3836
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister2000)) * int64_t(int32_t(4))); // PTX L3837
	g_RecordByteAddressAtPtx3838 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register197); // PTX L3838
	r_PtxRegister1787 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3838 + 524288ull);		   // PTX L3839
	r_LaneIndexAtPtx3841 = uint32_t((threadIdx.x & 31u));									   // PTX L3841
	r_PtxRegister2001 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3841), uint32_t(31));		   // PTX L3843
	r_PtxRegister2002 = ShiftRight(uint32_t(r_PtxRegister2001), uint32_t(30));				   // PTX L3844
	r_PtxRegister2003 = uint32_t(r_LaneIndexAtPtx3841) + uint32_t(r_PtxRegister2002);		   // PTX L3845
	r_PtxRegister2004 = r_PtxRegister2003 & 2147483644;										   // PTX L3846
	r_PtxRegister2005 = uint32_t(r_LaneIndexAtPtx3841) - uint32_t(r_PtxRegister2004);		   // PTX L3847
	r_PtxRegister2006 = ShiftLeft(uint32_t(r_PtxRegister2005), uint32_t(1));				   // PTX L3848
	r_PtxRegister2007 = uint32_t(r_PtxRegister10) + uint32_t(48);							   // PTX L3849
	r_PtxRegister2008 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2006);			   // PTX L3850
	r_PtxRegister2009 = ShiftRightSigned(int32_t(r_PtxRegister2008), uint32_t(1));			   // PTX L3851
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister2009)) * int64_t(int32_t(4))); // PTX L3852
	g_RecordByteAddressAtPtx3853 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register199); // PTX L3853
	r_PtxRegister1789 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3853 + 524288ull);		   // PTX L3854
	r_LaneIndexAtPtx3856 = uint32_t((threadIdx.x & 31u));									   // PTX L3856
	r_PtxRegister2010 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3856), uint32_t(31));		   // PTX L3858
	r_PtxRegister2011 = ShiftRight(uint32_t(r_PtxRegister2010), uint32_t(30));				   // PTX L3859
	r_PtxRegister2012 = uint32_t(r_LaneIndexAtPtx3856) + uint32_t(r_PtxRegister2011);		   // PTX L3860
	r_PtxRegister2013 = r_PtxRegister2012 & 2147483644;										   // PTX L3861
	r_PtxRegister2014 = uint32_t(r_LaneIndexAtPtx3856) - uint32_t(r_PtxRegister2013);		   // PTX L3862
	r_PtxRegister2015 = ShiftLeft(uint32_t(r_PtxRegister2014), uint32_t(1));				   // PTX L3863
	r_PtxRegister2016 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2015);			   // PTX L3864
	r_PtxRegister2017 = ShiftRightSigned(int32_t(r_PtxRegister2016), uint32_t(1));			   // PTX L3865
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister2017)) * int64_t(int32_t(4))); // PTX L3866
	g_RecordByteAddressAtPtx3867 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register201); // PTX L3867
	r_PtxRegister1791 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3867 + 524288ull);		   // PTX L3868
	r_LaneIndexAtPtx3870 = uint32_t((threadIdx.x & 31u));									   // PTX L3870
	r_PtxRegister2018 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3870), uint32_t(31));		   // PTX L3872
	r_PtxRegister2019 = ShiftRight(uint32_t(r_PtxRegister2018), uint32_t(30));				   // PTX L3873
	r_PtxRegister2020 = uint32_t(r_LaneIndexAtPtx3870) + uint32_t(r_PtxRegister2019);		   // PTX L3874
	r_PtxRegister2021 = r_PtxRegister2020 & 2147483644;										   // PTX L3875
	r_PtxRegister2022 = uint32_t(r_LaneIndexAtPtx3870) - uint32_t(r_PtxRegister2021);		   // PTX L3876
	r_PtxRegister2023 = ShiftLeft(uint32_t(r_PtxRegister2022), uint32_t(1));				   // PTX L3877
	r_PtxRegister2024 = uint32_t(r_PtxRegister10) + uint32_t(56);							   // PTX L3878
	r_PtxRegister2025 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2023);			   // PTX L3879
	r_PtxRegister2026 = ShiftRight(uint32_t(r_PtxRegister2025), uint32_t(31));				   // PTX L3880
	r_PtxRegister2027 = uint32_t(r_PtxRegister2025) + uint32_t(r_PtxRegister2026);			   // PTX L3881
	r_PtxRegister2028 = ShiftRightSigned(int32_t(r_PtxRegister2027), uint32_t(1));			   // PTX L3882
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister2028)) * int64_t(int32_t(4))); // PTX L3883
	g_RecordByteAddressAtPtx3884 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register203); // PTX L3884
	r_PtxRegister1793 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3884 + 524288ull);		   // PTX L3885
	r_LaneIndexAtPtx3887 = uint32_t((threadIdx.x & 31u));									   // PTX L3887
	r_PtxRegister2029 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3887), uint32_t(31));		   // PTX L3889
	r_PtxRegister2030 = ShiftRight(uint32_t(r_PtxRegister2029), uint32_t(30));				   // PTX L3890
	r_PtxRegister2031 = uint32_t(r_LaneIndexAtPtx3887) + uint32_t(r_PtxRegister2030);		   // PTX L3891
	r_PtxRegister2032 = r_PtxRegister2031 & 2147483644;										   // PTX L3892
	r_PtxRegister2033 = uint32_t(r_LaneIndexAtPtx3887) - uint32_t(r_PtxRegister2032);		   // PTX L3893
	r_PtxRegister2034 = ShiftLeft(uint32_t(r_PtxRegister2033), uint32_t(1));				   // PTX L3894
	r_PtxRegister2035 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2034);			   // PTX L3895
	r_PtxRegister2036 = ShiftRight(uint32_t(r_PtxRegister2035), uint32_t(31));				   // PTX L3896
	r_PtxRegister2037 = uint32_t(r_PtxRegister2035) + uint32_t(r_PtxRegister2036);			   // PTX L3897
	r_PtxRegister2038 = ShiftRightSigned(int32_t(r_PtxRegister2037), uint32_t(1));			   // PTX L3898
	r_PtxU64Register205 = uint64_t(int64_t(int32_t(r_PtxRegister2038)) * int64_t(int32_t(4))); // PTX L3899
	g_RecordByteAddressAtPtx3900 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register205); // PTX L3900
	r_PtxRegister1795 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3900 + 524288ull);		   // PTX L3901
	r_LaneIndexAtPtx3903 = uint32_t((threadIdx.x & 31u));									   // PTX L3903
	r_PtxRegister2039 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3903), uint32_t(31));		   // PTX L3905
	r_PtxRegister2040 = ShiftRight(uint32_t(r_PtxRegister2039), uint32_t(30));				   // PTX L3906
	r_PtxRegister2041 = uint32_t(r_LaneIndexAtPtx3903) + uint32_t(r_PtxRegister2040);		   // PTX L3907
	r_PtxRegister2042 = r_PtxRegister2041 & 2147483644;										   // PTX L3908
	r_PtxRegister2043 = uint32_t(r_LaneIndexAtPtx3903) - uint32_t(r_PtxRegister2042);		   // PTX L3909
	r_PtxRegister2044 = ShiftLeft(uint32_t(r_PtxRegister2043), uint32_t(1));				   // PTX L3910
	r_PtxRegister2045 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2044);			   // PTX L3911
	r_PtxRegister2046 = ShiftRightSigned(int32_t(r_PtxRegister2045), uint32_t(1));			   // PTX L3912
	r_PtxU64Register207 = uint64_t(int64_t(int32_t(r_PtxRegister2046)) * int64_t(int32_t(4))); // PTX L3913
	g_RecordByteAddressAtPtx3914 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register207); // PTX L3914
	r_PtxRegister1797 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3914 + 524288ull);		   // PTX L3915
	r_LaneIndexAtPtx3917 = uint32_t((threadIdx.x & 31u));									   // PTX L3917
	r_PtxRegister2047 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3917), uint32_t(31));		   // PTX L3919
	r_PtxRegister2048 = ShiftRight(uint32_t(r_PtxRegister2047), uint32_t(30));				   // PTX L3920
	r_PtxRegister2049 = uint32_t(r_LaneIndexAtPtx3917) + uint32_t(r_PtxRegister2048);		   // PTX L3921
	r_PtxRegister2050 = r_PtxRegister2049 & 2147483644;										   // PTX L3922
	r_PtxRegister2051 = uint32_t(r_LaneIndexAtPtx3917) - uint32_t(r_PtxRegister2050);		   // PTX L3923
	r_PtxRegister2052 = ShiftLeft(uint32_t(r_PtxRegister2051), uint32_t(1));				   // PTX L3924
	r_PtxRegister2053 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2052);			   // PTX L3925
	r_PtxRegister2054 = ShiftRightSigned(int32_t(r_PtxRegister2053), uint32_t(1));			   // PTX L3926
	r_PtxU64Register209 = uint64_t(int64_t(int32_t(r_PtxRegister2054)) * int64_t(int32_t(4))); // PTX L3927
	g_RecordByteAddressAtPtx3928 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register209); // PTX L3928
	r_PtxRegister1799 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3928 + 524288ull);		   // PTX L3929
	r_LaneIndexAtPtx3931 = uint32_t((threadIdx.x & 31u));									   // PTX L3931
	r_PtxRegister2055 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3931), uint32_t(31));		   // PTX L3933
	r_PtxRegister2056 = ShiftRight(uint32_t(r_PtxRegister2055), uint32_t(30));				   // PTX L3934
	r_PtxRegister2057 = uint32_t(r_LaneIndexAtPtx3931) + uint32_t(r_PtxRegister2056);		   // PTX L3935
	r_PtxRegister2058 = r_PtxRegister2057 & 2147483644;										   // PTX L3936
	r_PtxRegister2059 = uint32_t(r_LaneIndexAtPtx3931) - uint32_t(r_PtxRegister2058);		   // PTX L3937
	r_PtxRegister2060 = ShiftLeft(uint32_t(r_PtxRegister2059), uint32_t(1));				   // PTX L3938
	r_PtxRegister2061 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2060);			   // PTX L3939
	r_PtxRegister2062 = ShiftRightSigned(int32_t(r_PtxRegister2061), uint32_t(1));			   // PTX L3940
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister2062)) * int64_t(int32_t(4))); // PTX L3941
	g_RecordByteAddressAtPtx3942 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register211); // PTX L3942
	r_PtxRegister1801 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3942 + 524288ull);		   // PTX L3943
	r_LaneIndexAtPtx3945 = uint32_t((threadIdx.x & 31u));									   // PTX L3945
	r_PtxRegister2063 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3945), uint32_t(31));		   // PTX L3947
	r_PtxRegister2064 = ShiftRight(uint32_t(r_PtxRegister2063), uint32_t(30));				   // PTX L3948
	r_PtxRegister2065 = uint32_t(r_LaneIndexAtPtx3945) + uint32_t(r_PtxRegister2064);		   // PTX L3949
	r_PtxRegister2066 = r_PtxRegister2065 & 2147483644;										   // PTX L3950
	r_PtxRegister2067 = uint32_t(r_LaneIndexAtPtx3945) - uint32_t(r_PtxRegister2066);		   // PTX L3951
	r_PtxRegister2068 = ShiftLeft(uint32_t(r_PtxRegister2067), uint32_t(1));				   // PTX L3952
	r_PtxRegister2069 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2068);			   // PTX L3953
	r_PtxRegister2070 = ShiftRightSigned(int32_t(r_PtxRegister2069), uint32_t(1));			   // PTX L3954
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister2070)) * int64_t(int32_t(4))); // PTX L3955
	g_RecordByteAddressAtPtx3956 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register213); // PTX L3956
	r_PtxRegister1803 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3956 + 524288ull);		   // PTX L3957
	r_LaneIndexAtPtx3959 = uint32_t((threadIdx.x & 31u));									   // PTX L3959
	r_PtxRegister2071 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3959), uint32_t(31));		   // PTX L3961
	r_PtxRegister2072 = ShiftRight(uint32_t(r_PtxRegister2071), uint32_t(30));				   // PTX L3962
	r_PtxRegister2073 = uint32_t(r_LaneIndexAtPtx3959) + uint32_t(r_PtxRegister2072);		   // PTX L3963
	r_PtxRegister2074 = r_PtxRegister2073 & 2147483644;										   // PTX L3964
	r_PtxRegister2075 = uint32_t(r_LaneIndexAtPtx3959) - uint32_t(r_PtxRegister2074);		   // PTX L3965
	r_PtxRegister2076 = ShiftLeft(uint32_t(r_PtxRegister2075), uint32_t(1));				   // PTX L3966
	r_PtxRegister2077 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2076);			   // PTX L3967
	r_PtxRegister2078 = ShiftRightSigned(int32_t(r_PtxRegister2077), uint32_t(1));			   // PTX L3968
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister2078)) * int64_t(int32_t(4))); // PTX L3969
	g_RecordByteAddressAtPtx3970 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register215); // PTX L3970
	r_PtxRegister1805 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3970 + 524288ull);		   // PTX L3971
	r_LaneIndexAtPtx3973 = uint32_t((threadIdx.x & 31u));									   // PTX L3973
	r_PtxRegister2079 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3973), uint32_t(31));		   // PTX L3975
	r_PtxRegister2080 = ShiftRight(uint32_t(r_PtxRegister2079), uint32_t(30));				   // PTX L3976
	r_PtxRegister2081 = uint32_t(r_LaneIndexAtPtx3973) + uint32_t(r_PtxRegister2080);		   // PTX L3977
	r_PtxRegister2082 = r_PtxRegister2081 & 2147483644;										   // PTX L3978
	r_PtxRegister2083 = uint32_t(r_LaneIndexAtPtx3973) - uint32_t(r_PtxRegister2082);		   // PTX L3979
	r_PtxRegister2084 = ShiftLeft(uint32_t(r_PtxRegister2083), uint32_t(1));				   // PTX L3980
	r_PtxRegister2085 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2084);			   // PTX L3981
	r_PtxRegister2086 = ShiftRightSigned(int32_t(r_PtxRegister2085), uint32_t(1));			   // PTX L3982
	r_PtxU64Register217 = uint64_t(int64_t(int32_t(r_PtxRegister2086)) * int64_t(int32_t(4))); // PTX L3983
	g_RecordByteAddressAtPtx3984 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register217); // PTX L3984
	r_PtxRegister1807 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3984 + 524288ull);		   // PTX L3985
	r_LaneIndexAtPtx3987 = uint32_t((threadIdx.x & 31u));									   // PTX L3987
	r_PtxRegister2087 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3987), uint32_t(31));		   // PTX L3989
	r_PtxRegister2088 = ShiftRight(uint32_t(r_PtxRegister2087), uint32_t(30));				   // PTX L3990
	r_PtxRegister2089 = uint32_t(r_LaneIndexAtPtx3987) + uint32_t(r_PtxRegister2088);		   // PTX L3991
	r_PtxRegister2090 = r_PtxRegister2089 & 2147483644;										   // PTX L3992
	r_PtxRegister2091 = uint32_t(r_LaneIndexAtPtx3987) - uint32_t(r_PtxRegister2090);		   // PTX L3993
	r_PtxRegister2092 = ShiftLeft(uint32_t(r_PtxRegister2091), uint32_t(1));				   // PTX L3994
	r_PtxRegister2093 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2092);			   // PTX L3995
	r_PtxRegister2094 = ShiftRight(uint32_t(r_PtxRegister2093), uint32_t(31));				   // PTX L3996
	r_PtxRegister2095 = uint32_t(r_PtxRegister2093) + uint32_t(r_PtxRegister2094);			   // PTX L3997
	r_PtxRegister2096 = ShiftRightSigned(int32_t(r_PtxRegister2095), uint32_t(1));			   // PTX L3998
	r_PtxU64Register219 = uint64_t(int64_t(int32_t(r_PtxRegister2096)) * int64_t(int32_t(4))); // PTX L3999
	g_RecordByteAddressAtPtx4000 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register219); // PTX L4000
	r_PtxRegister1809 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4000 + 524288ull);		   // PTX L4001
	r_LaneIndexAtPtx4003 = uint32_t((threadIdx.x & 31u));									   // PTX L4003
	r_PtxRegister2097 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4003), uint32_t(31));		   // PTX L4005
	r_PtxRegister2098 = ShiftRight(uint32_t(r_PtxRegister2097), uint32_t(30));				   // PTX L4006
	r_PtxRegister2099 = uint32_t(r_LaneIndexAtPtx4003) + uint32_t(r_PtxRegister2098);		   // PTX L4007
	r_PtxRegister2100 = r_PtxRegister2099 & 2147483644;										   // PTX L4008
	r_PtxRegister2101 = uint32_t(r_LaneIndexAtPtx4003) - uint32_t(r_PtxRegister2100);		   // PTX L4009
	r_PtxRegister2102 = ShiftLeft(uint32_t(r_PtxRegister2101), uint32_t(1));				   // PTX L4010
	r_PtxRegister2103 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2102);			   // PTX L4011
	r_PtxRegister2104 = ShiftRight(uint32_t(r_PtxRegister2103), uint32_t(31));				   // PTX L4012
	r_PtxRegister2105 = uint32_t(r_PtxRegister2103) + uint32_t(r_PtxRegister2104);			   // PTX L4013
	r_PtxRegister2106 = ShiftRightSigned(int32_t(r_PtxRegister2105), uint32_t(1));			   // PTX L4014
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister2106)) * int64_t(int32_t(4))); // PTX L4015
	g_RecordByteAddressAtPtx4016 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register221); // PTX L4016
	r_PtxRegister1811 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4016 + 524288ull);		   // PTX L4017
	r_LaneIndexAtPtx4019 = uint32_t((threadIdx.x & 31u));									   // PTX L4019
	r_PtxRegister2107 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4019), uint32_t(31));		   // PTX L4021
	r_PtxRegister2108 = ShiftRight(uint32_t(r_PtxRegister2107), uint32_t(30));				   // PTX L4022
	r_PtxRegister2109 = uint32_t(r_LaneIndexAtPtx4019) + uint32_t(r_PtxRegister2108);		   // PTX L4023
	r_PtxRegister2110 = r_PtxRegister2109 & 2147483644;										   // PTX L4024
	r_PtxRegister2111 = uint32_t(r_LaneIndexAtPtx4019) - uint32_t(r_PtxRegister2110);		   // PTX L4025
	r_PtxRegister2112 = ShiftLeft(uint32_t(r_PtxRegister2111), uint32_t(1));				   // PTX L4026
	r_PtxRegister2113 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2112);			   // PTX L4027
	r_PtxRegister2114 = ShiftRightSigned(int32_t(r_PtxRegister2113), uint32_t(1));			   // PTX L4028
	r_PtxU64Register223 = uint64_t(int64_t(int32_t(r_PtxRegister2114)) * int64_t(int32_t(4))); // PTX L4029
	g_RecordByteAddressAtPtx4030 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register223); // PTX L4030
	r_PtxRegister1813 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4030 + 524288ull);		   // PTX L4031
	r_LaneIndexAtPtx4033 = uint32_t((threadIdx.x & 31u));									   // PTX L4033
	r_PtxRegister2115 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4033), uint32_t(31));		   // PTX L4035
	r_PtxRegister2116 = ShiftRight(uint32_t(r_PtxRegister2115), uint32_t(30));				   // PTX L4036
	r_PtxRegister2117 = uint32_t(r_LaneIndexAtPtx4033) + uint32_t(r_PtxRegister2116);		   // PTX L4037
	r_PtxRegister2118 = r_PtxRegister2117 & 2147483644;										   // PTX L4038
	r_PtxRegister2119 = uint32_t(r_LaneIndexAtPtx4033) - uint32_t(r_PtxRegister2118);		   // PTX L4039
	r_PtxRegister2120 = ShiftLeft(uint32_t(r_PtxRegister2119), uint32_t(1));				   // PTX L4040
	r_PtxRegister2121 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2120);			   // PTX L4041
	r_PtxRegister2122 = ShiftRightSigned(int32_t(r_PtxRegister2121), uint32_t(1));			   // PTX L4042
	r_PtxU64Register225 = uint64_t(int64_t(int32_t(r_PtxRegister2122)) * int64_t(int32_t(4))); // PTX L4043
	g_RecordByteAddressAtPtx4044 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register225); // PTX L4044
	r_PtxRegister1815 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4044 + 524288ull);		   // PTX L4045
	r_LaneIndexAtPtx4047 = uint32_t((threadIdx.x & 31u));									   // PTX L4047
	r_PtxRegister2123 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4047), uint32_t(31));		   // PTX L4049
	r_PtxRegister2124 = ShiftRight(uint32_t(r_PtxRegister2123), uint32_t(30));				   // PTX L4050
	r_PtxRegister2125 = uint32_t(r_LaneIndexAtPtx4047) + uint32_t(r_PtxRegister2124);		   // PTX L4051
	r_PtxRegister2126 = r_PtxRegister2125 & 2147483644;										   // PTX L4052
	r_PtxRegister2127 = uint32_t(r_LaneIndexAtPtx4047) - uint32_t(r_PtxRegister2126);		   // PTX L4053
	r_PtxRegister2128 = ShiftLeft(uint32_t(r_PtxRegister2127), uint32_t(1));				   // PTX L4054
	r_PtxRegister2129 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2128);			   // PTX L4055
	r_PtxRegister2130 = ShiftRight(uint32_t(r_PtxRegister2129), uint32_t(31));				   // PTX L4056
	r_PtxRegister2131 = uint32_t(r_PtxRegister2129) + uint32_t(r_PtxRegister2130);			   // PTX L4057
	r_PtxRegister2132 = ShiftRightSigned(int32_t(r_PtxRegister2131), uint32_t(1));			   // PTX L4058
	r_PtxU64Register227 = uint64_t(int64_t(int32_t(r_PtxRegister2132)) * int64_t(int32_t(4))); // PTX L4059
	g_RecordByteAddressAtPtx4060 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register227); // PTX L4060
	r_PtxRegister1817 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4060 + 524288ull);		   // PTX L4061
	r_LaneIndexAtPtx4063 = uint32_t((threadIdx.x & 31u));									   // PTX L4063
	r_PtxRegister2133 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4063), uint32_t(31));		   // PTX L4065
	r_PtxRegister2134 = ShiftRight(uint32_t(r_PtxRegister2133), uint32_t(30));				   // PTX L4066
	r_PtxRegister2135 = uint32_t(r_LaneIndexAtPtx4063) + uint32_t(r_PtxRegister2134);		   // PTX L4067
	r_PtxRegister2136 = r_PtxRegister2135 & 2147483644;										   // PTX L4068
	r_PtxRegister2137 = uint32_t(r_LaneIndexAtPtx4063) - uint32_t(r_PtxRegister2136);		   // PTX L4069
	r_PtxRegister2138 = ShiftLeft(uint32_t(r_PtxRegister2137), uint32_t(1));				   // PTX L4070
	r_PtxRegister2139 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2138);			   // PTX L4071
	r_PtxRegister2140 = ShiftRight(uint32_t(r_PtxRegister2139), uint32_t(31));				   // PTX L4072
	r_PtxRegister2141 = uint32_t(r_PtxRegister2139) + uint32_t(r_PtxRegister2140);			   // PTX L4073
	r_PtxRegister2142 = ShiftRightSigned(int32_t(r_PtxRegister2141), uint32_t(1));			   // PTX L4074
	r_PtxU64Register229 = uint64_t(int64_t(int32_t(r_PtxRegister2142)) * int64_t(int32_t(4))); // PTX L4075
	g_RecordByteAddressAtPtx4076 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register229); // PTX L4076
	r_PtxRegister1819 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4076 + 524288ull);		   // PTX L4077
	r_LaneIndexAtPtx4079 = uint32_t((threadIdx.x & 31u));									   // PTX L4079
	r_PtxRegister2143 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4079), uint32_t(31));		   // PTX L4081
	r_PtxRegister2144 = ShiftRight(uint32_t(r_PtxRegister2143), uint32_t(30));				   // PTX L4082
	r_PtxRegister2145 = uint32_t(r_LaneIndexAtPtx4079) + uint32_t(r_PtxRegister2144);		   // PTX L4083
	r_PtxRegister2146 = r_PtxRegister2145 & 2147483644;										   // PTX L4084
	r_PtxRegister2147 = uint32_t(r_LaneIndexAtPtx4079) - uint32_t(r_PtxRegister2146);		   // PTX L4085
	r_PtxRegister2148 = ShiftLeft(uint32_t(r_PtxRegister2147), uint32_t(1));				   // PTX L4086
	r_PtxRegister2149 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2148);			   // PTX L4087
	r_PtxRegister2150 = ShiftRightSigned(int32_t(r_PtxRegister2149), uint32_t(1));			   // PTX L4088
	r_PtxU64Register231 = uint64_t(int64_t(int32_t(r_PtxRegister2150)) * int64_t(int32_t(4))); // PTX L4089
	g_RecordByteAddressAtPtx4090 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register231); // PTX L4090
	r_PtxRegister1821 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4090 + 524288ull);		   // PTX L4091
	r_LaneIndexAtPtx4093 = uint32_t((threadIdx.x & 31u));									   // PTX L4093
	r_PtxRegister2151 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4093), uint32_t(31));		   // PTX L4095
	r_PtxRegister2152 = ShiftRight(uint32_t(r_PtxRegister2151), uint32_t(30));				   // PTX L4096
	r_PtxRegister2153 = uint32_t(r_LaneIndexAtPtx4093) + uint32_t(r_PtxRegister2152);		   // PTX L4097
	r_PtxRegister2154 = r_PtxRegister2153 & 2147483644;										   // PTX L4098
	r_PtxRegister2155 = uint32_t(r_LaneIndexAtPtx4093) - uint32_t(r_PtxRegister2154);		   // PTX L4099
	r_PtxRegister2156 = ShiftLeft(uint32_t(r_PtxRegister2155), uint32_t(1));				   // PTX L4100
	r_PtxRegister2157 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2156);			   // PTX L4101
	r_PtxRegister2158 = ShiftRightSigned(int32_t(r_PtxRegister2157), uint32_t(1));			   // PTX L4102
	r_PtxU64Register233 = uint64_t(int64_t(int32_t(r_PtxRegister2158)) * int64_t(int32_t(4))); // PTX L4103
	g_RecordByteAddressAtPtx4104 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register233); // PTX L4104
	r_PtxRegister1823 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4104 + 524288ull);		   // PTX L4105
	r_LaneIndexAtPtx4107 = uint32_t((threadIdx.x & 31u));									   // PTX L4107
	r_PtxRegister2159 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4107), uint32_t(31));		   // PTX L4109
	r_PtxRegister2160 = ShiftRight(uint32_t(r_PtxRegister2159), uint32_t(30));				   // PTX L4110
	r_PtxRegister2161 = uint32_t(r_LaneIndexAtPtx4107) + uint32_t(r_PtxRegister2160);		   // PTX L4111
	r_PtxRegister2162 = r_PtxRegister2161 & 2147483644;										   // PTX L4112
	r_PtxRegister2163 = uint32_t(r_LaneIndexAtPtx4107) - uint32_t(r_PtxRegister2162);		   // PTX L4113
	r_PtxRegister2164 = ShiftLeft(uint32_t(r_PtxRegister2163), uint32_t(1));				   // PTX L4114
	r_PtxRegister2165 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2164);			   // PTX L4115
	r_PtxRegister2166 = ShiftRight(uint32_t(r_PtxRegister2165), uint32_t(31));				   // PTX L4116
	r_PtxRegister2167 = uint32_t(r_PtxRegister2165) + uint32_t(r_PtxRegister2166);			   // PTX L4117
	r_PtxRegister2168 = ShiftRightSigned(int32_t(r_PtxRegister2167), uint32_t(1));			   // PTX L4118
	r_PtxU64Register235 = uint64_t(int64_t(int32_t(r_PtxRegister2168)) * int64_t(int32_t(4))); // PTX L4119
	g_RecordByteAddressAtPtx4120 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register235); // PTX L4120
	r_PtxRegister1825 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4120 + 524288ull);		   // PTX L4121
	r_LaneIndexAtPtx4123 = uint32_t((threadIdx.x & 31u));									   // PTX L4123
	r_PtxRegister2169 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4123), uint32_t(31));		   // PTX L4125
	r_PtxRegister2170 = ShiftRight(uint32_t(r_PtxRegister2169), uint32_t(30));				   // PTX L4126
	r_PtxRegister2171 = uint32_t(r_LaneIndexAtPtx4123) + uint32_t(r_PtxRegister2170);		   // PTX L4127
	r_PtxRegister2172 = r_PtxRegister2171 & 2147483644;										   // PTX L4128
	r_PtxRegister2173 = uint32_t(r_LaneIndexAtPtx4123) - uint32_t(r_PtxRegister2172);		   // PTX L4129
	r_PtxRegister2174 = ShiftLeft(uint32_t(r_PtxRegister2173), uint32_t(1));				   // PTX L4130
	r_PtxRegister2175 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2174);			   // PTX L4131
	r_PtxRegister2176 = ShiftRight(uint32_t(r_PtxRegister2175), uint32_t(31));				   // PTX L4132
	r_PtxRegister2177 = uint32_t(r_PtxRegister2175) + uint32_t(r_PtxRegister2176);			   // PTX L4133
	r_PtxRegister2178 = ShiftRightSigned(int32_t(r_PtxRegister2177), uint32_t(1));			   // PTX L4134
	r_PtxU64Register237 = uint64_t(int64_t(int32_t(r_PtxRegister2178)) * int64_t(int32_t(4))); // PTX L4135
	g_RecordByteAddressAtPtx4136 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register237); // PTX L4136
	r_PtxRegister1827 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4136 + 524288ull);		   // PTX L4137
	r_LaneIndexAtPtx4139 = uint32_t((threadIdx.x & 31u));									   // PTX L4139
	r_PtxRegister2179 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4139), uint32_t(31));		   // PTX L4141
	r_PtxRegister2180 = ShiftRight(uint32_t(r_PtxRegister2179), uint32_t(30));				   // PTX L4142
	r_PtxRegister2181 = uint32_t(r_LaneIndexAtPtx4139) + uint32_t(r_PtxRegister2180);		   // PTX L4143
	r_PtxRegister2182 = r_PtxRegister2181 & 2147483644;										   // PTX L4144
	r_PtxRegister2183 = uint32_t(r_LaneIndexAtPtx4139) - uint32_t(r_PtxRegister2182);		   // PTX L4145
	r_PtxRegister2184 = ShiftLeft(uint32_t(r_PtxRegister2183), uint32_t(1));				   // PTX L4146
	r_PtxRegister2185 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2184);			   // PTX L4147
	r_PtxRegister2186 = ShiftRightSigned(int32_t(r_PtxRegister2185), uint32_t(1));			   // PTX L4148
	r_PtxU64Register239 = uint64_t(int64_t(int32_t(r_PtxRegister2186)) * int64_t(int32_t(4))); // PTX L4149
	g_RecordByteAddressAtPtx4150 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register239); // PTX L4150
	r_PtxRegister1829 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4150 + 524288ull);		   // PTX L4151
	r_LaneIndexAtPtx4153 = uint32_t((threadIdx.x & 31u));									   // PTX L4153
	r_PtxRegister2187 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4153), uint32_t(31));		   // PTX L4155
	r_PtxRegister2188 = ShiftRight(uint32_t(r_PtxRegister2187), uint32_t(30));				   // PTX L4156
	r_PtxRegister2189 = uint32_t(r_LaneIndexAtPtx4153) + uint32_t(r_PtxRegister2188);		   // PTX L4157
	r_PtxRegister2190 = r_PtxRegister2189 & 2147483644;										   // PTX L4158
	r_PtxRegister2191 = uint32_t(r_LaneIndexAtPtx4153) - uint32_t(r_PtxRegister2190);		   // PTX L4159
	r_PtxRegister2192 = ShiftLeft(uint32_t(r_PtxRegister2191), uint32_t(1));				   // PTX L4160
	r_PtxRegister2193 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2192);			   // PTX L4161
	r_PtxRegister2194 = ShiftRightSigned(int32_t(r_PtxRegister2193), uint32_t(1));			   // PTX L4162
	r_PtxU64Register241 = uint64_t(int64_t(int32_t(r_PtxRegister2194)) * int64_t(int32_t(4))); // PTX L4163
	g_RecordByteAddressAtPtx4164 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register241); // PTX L4164
	r_PtxRegister1831 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4164 + 524288ull);		   // PTX L4165
	r_LaneIndexAtPtx4167 = uint32_t((threadIdx.x & 31u));									   // PTX L4167
	r_PtxRegister2195 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4167), uint32_t(31));		   // PTX L4169
	r_PtxRegister2196 = ShiftRight(uint32_t(r_PtxRegister2195), uint32_t(30));				   // PTX L4170
	r_PtxRegister2197 = uint32_t(r_LaneIndexAtPtx4167) + uint32_t(r_PtxRegister2196);		   // PTX L4171
	r_PtxRegister2198 = r_PtxRegister2197 & 2147483644;										   // PTX L4172
	r_PtxRegister2199 = uint32_t(r_LaneIndexAtPtx4167) - uint32_t(r_PtxRegister2198);		   // PTX L4173
	r_PtxRegister2200 = ShiftLeft(uint32_t(r_PtxRegister2199), uint32_t(1));				   // PTX L4174
	r_PtxRegister2201 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2200);			   // PTX L4175
	r_PtxRegister2202 = ShiftRightSigned(int32_t(r_PtxRegister2201), uint32_t(1));			   // PTX L4176
	r_PtxU64Register243 = uint64_t(int64_t(int32_t(r_PtxRegister2202)) * int64_t(int32_t(4))); // PTX L4177
	g_RecordByteAddressAtPtx4178 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register243); // PTX L4178
	r_PtxRegister1833 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4178 + 524288ull);		   // PTX L4179
	r_LaneIndexAtPtx4181 = uint32_t((threadIdx.x & 31u));									   // PTX L4181
	r_PtxRegister2203 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4181), uint32_t(31));		   // PTX L4183
	r_PtxRegister2204 = ShiftRight(uint32_t(r_PtxRegister2203), uint32_t(30));				   // PTX L4184
	r_PtxRegister2205 = uint32_t(r_LaneIndexAtPtx4181) + uint32_t(r_PtxRegister2204);		   // PTX L4185
	r_PtxRegister2206 = r_PtxRegister2205 & 2147483644;										   // PTX L4186
	r_PtxRegister2207 = uint32_t(r_LaneIndexAtPtx4181) - uint32_t(r_PtxRegister2206);		   // PTX L4187
	r_PtxRegister2208 = ShiftLeft(uint32_t(r_PtxRegister2207), uint32_t(1));				   // PTX L4188
	r_PtxRegister2209 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2208);			   // PTX L4189
	r_PtxRegister2210 = ShiftRightSigned(int32_t(r_PtxRegister2209), uint32_t(1));			   // PTX L4190
	r_PtxU64Register245 = uint64_t(int64_t(int32_t(r_PtxRegister2210)) * int64_t(int32_t(4))); // PTX L4191
	g_RecordByteAddressAtPtx4192 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register245); // PTX L4192
	r_PtxRegister1835 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4192 + 524288ull);		   // PTX L4193
	r_LaneIndexAtPtx4195 = uint32_t((threadIdx.x & 31u));									   // PTX L4195
	r_PtxRegister2211 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4195), uint32_t(31));		   // PTX L4197
	r_PtxRegister2212 = ShiftRight(uint32_t(r_PtxRegister2211), uint32_t(30));				   // PTX L4198
	r_PtxRegister2213 = uint32_t(r_LaneIndexAtPtx4195) + uint32_t(r_PtxRegister2212);		   // PTX L4199
	r_PtxRegister2214 = r_PtxRegister2213 & 2147483644;										   // PTX L4200
	r_PtxRegister2215 = uint32_t(r_LaneIndexAtPtx4195) - uint32_t(r_PtxRegister2214);		   // PTX L4201
	r_PtxRegister2216 = ShiftLeft(uint32_t(r_PtxRegister2215), uint32_t(1));				   // PTX L4202
	r_PtxRegister2217 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2216);			   // PTX L4203
	r_PtxRegister2218 = ShiftRightSigned(int32_t(r_PtxRegister2217), uint32_t(1));			   // PTX L4204
	r_PtxU64Register247 = uint64_t(int64_t(int32_t(r_PtxRegister2218)) * int64_t(int32_t(4))); // PTX L4205
	g_RecordByteAddressAtPtx4206 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register247); // PTX L4206
	r_PtxRegister1837 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4206 + 524288ull);		   // PTX L4207
	r_LaneIndexAtPtx4209 = uint32_t((threadIdx.x & 31u));									   // PTX L4209
	r_PtxRegister2219 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4209), uint32_t(31));		   // PTX L4211
	r_PtxRegister2220 = ShiftRight(uint32_t(r_PtxRegister2219), uint32_t(30));				   // PTX L4212
	r_PtxRegister2221 = uint32_t(r_LaneIndexAtPtx4209) + uint32_t(r_PtxRegister2220);		   // PTX L4213
	r_PtxRegister2222 = r_PtxRegister2221 & 2147483644;										   // PTX L4214
	r_PtxRegister2223 = uint32_t(r_LaneIndexAtPtx4209) - uint32_t(r_PtxRegister2222);		   // PTX L4215
	r_PtxRegister2224 = ShiftLeft(uint32_t(r_PtxRegister2223), uint32_t(1));				   // PTX L4216
	r_PtxRegister2225 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2224);			   // PTX L4217
	r_PtxRegister2226 = ShiftRightSigned(int32_t(r_PtxRegister2225), uint32_t(1));			   // PTX L4218
	r_PtxU64Register249 = uint64_t(int64_t(int32_t(r_PtxRegister2226)) * int64_t(int32_t(4))); // PTX L4219
	g_RecordByteAddressAtPtx4220 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register249); // PTX L4220
	r_PtxRegister1839 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4220 + 524288ull);		   // PTX L4221
	r_LaneIndexAtPtx4223 = uint32_t((threadIdx.x & 31u));									   // PTX L4223
	r_PtxRegister2227 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4223), uint32_t(31));		   // PTX L4225
	r_PtxRegister2228 = ShiftRight(uint32_t(r_PtxRegister2227), uint32_t(30));				   // PTX L4226
	r_PtxRegister2229 = uint32_t(r_LaneIndexAtPtx4223) + uint32_t(r_PtxRegister2228);		   // PTX L4227
	r_PtxRegister2230 = r_PtxRegister2229 & 2147483644;										   // PTX L4228
	r_PtxRegister2231 = uint32_t(r_LaneIndexAtPtx4223) - uint32_t(r_PtxRegister2230);		   // PTX L4229
	r_PtxRegister2232 = ShiftLeft(uint32_t(r_PtxRegister2231), uint32_t(1));				   // PTX L4230
	r_PtxRegister2233 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2232);			   // PTX L4231
	r_PtxRegister2234 = ShiftRight(uint32_t(r_PtxRegister2233), uint32_t(31));				   // PTX L4232
	r_PtxRegister2235 = uint32_t(r_PtxRegister2233) + uint32_t(r_PtxRegister2234);			   // PTX L4233
	r_PtxRegister2236 = ShiftRightSigned(int32_t(r_PtxRegister2235), uint32_t(1));			   // PTX L4234
	r_PtxU64Register251 = uint64_t(int64_t(int32_t(r_PtxRegister2236)) * int64_t(int32_t(4))); // PTX L4235
	g_RecordByteAddressAtPtx4236 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register251); // PTX L4236
	r_PtxRegister1841 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4236 + 524288ull);		   // PTX L4237
	r_LaneIndexAtPtx4239 = uint32_t((threadIdx.x & 31u));									   // PTX L4239
	r_PtxRegister2237 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4239), uint32_t(31));		   // PTX L4241
	r_PtxRegister2238 = ShiftRight(uint32_t(r_PtxRegister2237), uint32_t(30));				   // PTX L4242
	r_PtxRegister2239 = uint32_t(r_LaneIndexAtPtx4239) + uint32_t(r_PtxRegister2238);		   // PTX L4243
	r_PtxRegister2240 = r_PtxRegister2239 & 2147483644;										   // PTX L4244
	r_PtxRegister2241 = uint32_t(r_LaneIndexAtPtx4239) - uint32_t(r_PtxRegister2240);		   // PTX L4245
	r_PtxRegister2242 = ShiftLeft(uint32_t(r_PtxRegister2241), uint32_t(1));				   // PTX L4246
	r_PtxRegister2243 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2242);			   // PTX L4247
	r_PtxRegister2244 = ShiftRight(uint32_t(r_PtxRegister2243), uint32_t(31));				   // PTX L4248
	r_PtxRegister2245 = uint32_t(r_PtxRegister2243) + uint32_t(r_PtxRegister2244);			   // PTX L4249
	r_PtxRegister2246 = ShiftRightSigned(int32_t(r_PtxRegister2245), uint32_t(1));			   // PTX L4250
	r_PtxU64Register253 = uint64_t(int64_t(int32_t(r_PtxRegister2246)) * int64_t(int32_t(4))); // PTX L4251
	g_RecordByteAddressAtPtx4252 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register253); // PTX L4252
	r_PtxRegister1843 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4252 + 524288ull);		   // PTX L4253
	r_LaneIndexAtPtx4255 = uint32_t((threadIdx.x & 31u));									   // PTX L4255
	r_PtxRegister2247 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4255), uint32_t(31));		   // PTX L4257
	r_PtxRegister2248 = ShiftRight(uint32_t(r_PtxRegister2247), uint32_t(30));				   // PTX L4258
	r_PtxRegister2249 = uint32_t(r_LaneIndexAtPtx4255) + uint32_t(r_PtxRegister2248);		   // PTX L4259
	r_PtxRegister2250 = r_PtxRegister2249 & 2147483644;										   // PTX L4260
	r_PtxRegister2251 = uint32_t(r_LaneIndexAtPtx4255) - uint32_t(r_PtxRegister2250);		   // PTX L4261
	r_PtxRegister2252 = ShiftLeft(uint32_t(r_PtxRegister2251), uint32_t(1));				   // PTX L4262
	r_PtxRegister2253 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2252);			   // PTX L4263
	r_PtxRegister2254 = ShiftRightSigned(int32_t(r_PtxRegister2253), uint32_t(1));			   // PTX L4264
	r_PtxU64Register255 = uint64_t(int64_t(int32_t(r_PtxRegister2254)) * int64_t(int32_t(4))); // PTX L4265
	g_RecordByteAddressAtPtx4266 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register255); // PTX L4266
	r_PtxRegister1845 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4266 + 524288ull);		   // PTX L4267
	r_LaneIndexAtPtx4269 = uint32_t((threadIdx.x & 31u));									   // PTX L4269
	r_PtxRegister2255 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4269), uint32_t(31));		   // PTX L4271
	r_PtxRegister2256 = ShiftRight(uint32_t(r_PtxRegister2255), uint32_t(30));				   // PTX L4272
	r_PtxRegister2257 = uint32_t(r_LaneIndexAtPtx4269) + uint32_t(r_PtxRegister2256);		   // PTX L4273
	r_PtxRegister2258 = r_PtxRegister2257 & 2147483644;										   // PTX L4274
	r_PtxRegister2259 = uint32_t(r_LaneIndexAtPtx4269) - uint32_t(r_PtxRegister2258);		   // PTX L4275
	r_PtxRegister2260 = ShiftLeft(uint32_t(r_PtxRegister2259), uint32_t(1));				   // PTX L4276
	r_PtxRegister2261 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2260);			   // PTX L4277
	r_PtxRegister2262 = ShiftRightSigned(int32_t(r_PtxRegister2261), uint32_t(1));			   // PTX L4278
	r_PtxU64Register257 = uint64_t(int64_t(int32_t(r_PtxRegister2262)) * int64_t(int32_t(4))); // PTX L4279
	g_RecordByteAddressAtPtx4280 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register257); // PTX L4280
	r_PtxRegister1847 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4280 + 524288ull);		   // PTX L4281
	r_LaneIndexAtPtx4283 = uint32_t((threadIdx.x & 31u));									   // PTX L4283
	r_PtxRegister2263 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4283), uint32_t(31));		   // PTX L4285
	r_PtxRegister2264 = ShiftRight(uint32_t(r_PtxRegister2263), uint32_t(30));				   // PTX L4286
	r_PtxRegister2265 = uint32_t(r_LaneIndexAtPtx4283) + uint32_t(r_PtxRegister2264);		   // PTX L4287
	r_PtxRegister2266 = r_PtxRegister2265 & 2147483644;										   // PTX L4288
	r_PtxRegister2267 = uint32_t(r_LaneIndexAtPtx4283) - uint32_t(r_PtxRegister2266);		   // PTX L4289
	r_PtxRegister2268 = ShiftLeft(uint32_t(r_PtxRegister2267), uint32_t(1));				   // PTX L4290
	r_PtxRegister2269 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2268);			   // PTX L4291
	r_PtxRegister2270 = ShiftRight(uint32_t(r_PtxRegister2269), uint32_t(31));				   // PTX L4292
	r_PtxRegister2271 = uint32_t(r_PtxRegister2269) + uint32_t(r_PtxRegister2270);			   // PTX L4293
	r_PtxRegister2272 = ShiftRightSigned(int32_t(r_PtxRegister2271), uint32_t(1));			   // PTX L4294
	r_PtxU64Register259 = uint64_t(int64_t(int32_t(r_PtxRegister2272)) * int64_t(int32_t(4))); // PTX L4295
	g_RecordByteAddressAtPtx4296 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register259); // PTX L4296
	r_PtxRegister1849 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4296 + 524288ull);		   // PTX L4297
	r_LaneIndexAtPtx4299 = uint32_t((threadIdx.x & 31u));									   // PTX L4299
	r_PtxRegister2273 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4299), uint32_t(31));		   // PTX L4301
	r_PtxRegister2274 = ShiftRight(uint32_t(r_PtxRegister2273), uint32_t(30));				   // PTX L4302
	r_PtxRegister2275 = uint32_t(r_LaneIndexAtPtx4299) + uint32_t(r_PtxRegister2274);		   // PTX L4303
	r_PtxRegister2276 = r_PtxRegister2275 & 2147483644;										   // PTX L4304
	r_PtxRegister2277 = uint32_t(r_LaneIndexAtPtx4299) - uint32_t(r_PtxRegister2276);		   // PTX L4305
	r_PtxRegister2278 = ShiftLeft(uint32_t(r_PtxRegister2277), uint32_t(1));				   // PTX L4306
	r_PtxRegister2279 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2278);			   // PTX L4307
	r_PtxRegister2280 = ShiftRight(uint32_t(r_PtxRegister2279), uint32_t(31));				   // PTX L4308
	r_PtxRegister2281 = uint32_t(r_PtxRegister2279) + uint32_t(r_PtxRegister2280);			   // PTX L4309
	r_PtxRegister2282 = ShiftRightSigned(int32_t(r_PtxRegister2281), uint32_t(1));			   // PTX L4310
	r_PtxU64Register261 = uint64_t(int64_t(int32_t(r_PtxRegister2282)) * int64_t(int32_t(4))); // PTX L4311
	g_RecordByteAddressAtPtx4312 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register261); // PTX L4312
	r_PtxRegister1851 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4312 + 524288ull);		   // PTX L4313
	r_LaneIndexAtPtx4315 = uint32_t((threadIdx.x & 31u));									   // PTX L4315
	r_PtxRegister2283 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4315), uint32_t(31));		   // PTX L4317
	r_PtxRegister2284 = ShiftRight(uint32_t(r_PtxRegister2283), uint32_t(30));				   // PTX L4318
	r_PtxRegister2285 = uint32_t(r_LaneIndexAtPtx4315) + uint32_t(r_PtxRegister2284);		   // PTX L4319
	r_PtxRegister2286 = r_PtxRegister2285 & 2147483644;										   // PTX L4320
	r_PtxRegister2287 = uint32_t(r_LaneIndexAtPtx4315) - uint32_t(r_PtxRegister2286);		   // PTX L4321
	r_PtxRegister2288 = ShiftLeft(uint32_t(r_PtxRegister2287), uint32_t(1));				   // PTX L4322
	r_PtxRegister2289 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2288);			   // PTX L4323
	r_PtxRegister2290 = ShiftRightSigned(int32_t(r_PtxRegister2289), uint32_t(1));			   // PTX L4324
	r_PtxU64Register263 = uint64_t(int64_t(int32_t(r_PtxRegister2290)) * int64_t(int32_t(4))); // PTX L4325
	g_RecordByteAddressAtPtx4326 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register263); // PTX L4326
	r_PtxRegister1853 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4326 + 524288ull);		   // PTX L4327
	r_LaneIndexAtPtx4329 = uint32_t((threadIdx.x & 31u));									   // PTX L4329
	r_PtxRegister2291 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4329), uint32_t(31));		   // PTX L4331
	r_PtxRegister2292 = ShiftRight(uint32_t(r_PtxRegister2291), uint32_t(30));				   // PTX L4332
	r_PtxRegister2293 = uint32_t(r_LaneIndexAtPtx4329) + uint32_t(r_PtxRegister2292);		   // PTX L4333
	r_PtxRegister2294 = r_PtxRegister2293 & 2147483644;										   // PTX L4334
	r_PtxRegister2295 = uint32_t(r_LaneIndexAtPtx4329) - uint32_t(r_PtxRegister2294);		   // PTX L4335
	r_PtxRegister2296 = ShiftLeft(uint32_t(r_PtxRegister2295), uint32_t(1));				   // PTX L4336
	r_PtxRegister2297 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2296);			   // PTX L4337
	r_PtxRegister2298 = ShiftRightSigned(int32_t(r_PtxRegister2297), uint32_t(1));			   // PTX L4338
	r_PtxU64Register265 = uint64_t(int64_t(int32_t(r_PtxRegister2298)) * int64_t(int32_t(4))); // PTX L4339
	g_RecordByteAddressAtPtx4340 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register265); // PTX L4340
	r_PtxRegister1855 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4340 + 524288ull);		   // PTX L4341
	r_LaneIndexAtPtx4343 = uint32_t((threadIdx.x & 31u));									   // PTX L4343
	r_PtxRegister2299 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4343), uint32_t(31));		   // PTX L4345
	r_PtxRegister2300 = ShiftRight(uint32_t(r_PtxRegister2299), uint32_t(30));				   // PTX L4346
	r_PtxRegister2301 = uint32_t(r_LaneIndexAtPtx4343) + uint32_t(r_PtxRegister2300);		   // PTX L4347
	r_PtxRegister2302 = r_PtxRegister2301 & 2147483644;										   // PTX L4348
	r_PtxRegister2303 = uint32_t(r_LaneIndexAtPtx4343) - uint32_t(r_PtxRegister2302);		   // PTX L4349
	r_PtxRegister2304 = ShiftLeft(uint32_t(r_PtxRegister2303), uint32_t(1));				   // PTX L4350
	r_PtxRegister2305 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2304);			   // PTX L4351
	r_PtxRegister2306 = ShiftRight(uint32_t(r_PtxRegister2305), uint32_t(31));				   // PTX L4352
	r_PtxRegister2307 = uint32_t(r_PtxRegister2305) + uint32_t(r_PtxRegister2306);			   // PTX L4353
	r_PtxRegister2308 = ShiftRightSigned(int32_t(r_PtxRegister2307), uint32_t(1));			   // PTX L4354
	r_PtxU64Register267 = uint64_t(int64_t(int32_t(r_PtxRegister2308)) * int64_t(int32_t(4))); // PTX L4355
	g_RecordByteAddressAtPtx4356 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register267); // PTX L4356
	r_PtxRegister1857 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4356 + 524288ull);		   // PTX L4357
	r_LaneIndexAtPtx4359 = uint32_t((threadIdx.x & 31u));									   // PTX L4359
	r_PtxRegister2309 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4359), uint32_t(31));		   // PTX L4361
	r_PtxRegister2310 = ShiftRight(uint32_t(r_PtxRegister2309), uint32_t(30));				   // PTX L4362
	r_PtxRegister2311 = uint32_t(r_LaneIndexAtPtx4359) + uint32_t(r_PtxRegister2310);		   // PTX L4363
	r_PtxRegister2312 = r_PtxRegister2311 & 2147483644;										   // PTX L4364
	r_PtxRegister2313 = uint32_t(r_LaneIndexAtPtx4359) - uint32_t(r_PtxRegister2312);		   // PTX L4365
	r_PtxRegister2314 = ShiftLeft(uint32_t(r_PtxRegister2313), uint32_t(1));				   // PTX L4366
	r_PtxRegister2315 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2314);			   // PTX L4367
	r_PtxRegister2316 = ShiftRight(uint32_t(r_PtxRegister2315), uint32_t(31));				   // PTX L4368
	r_PtxRegister2317 = uint32_t(r_PtxRegister2315) + uint32_t(r_PtxRegister2316);			   // PTX L4369
	r_PtxRegister2318 = ShiftRightSigned(int32_t(r_PtxRegister2317), uint32_t(1));			   // PTX L4370
	r_PtxU64Register269 = uint64_t(int64_t(int32_t(r_PtxRegister2318)) * int64_t(int32_t(4))); // PTX L4371
	g_RecordByteAddressAtPtx4372 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register269); // PTX L4372
	r_PtxRegister1859 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4372 + 524288ull);		   // PTX L4373
	r_LaneIndexAtPtx4375 = uint32_t((threadIdx.x & 31u));									   // PTX L4375
	r_PtxRegister2319 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4375), uint32_t(31));		   // PTX L4377
	r_PtxRegister2320 = ShiftRight(uint32_t(r_PtxRegister2319), uint32_t(30));				   // PTX L4378
	r_PtxRegister2321 = uint32_t(r_LaneIndexAtPtx4375) + uint32_t(r_PtxRegister2320);		   // PTX L4379
	r_PtxRegister2322 = r_PtxRegister2321 & 2147483644;										   // PTX L4380
	r_PtxRegister2323 = uint32_t(r_LaneIndexAtPtx4375) - uint32_t(r_PtxRegister2322);		   // PTX L4381
	r_PtxRegister2324 = ShiftLeft(uint32_t(r_PtxRegister2323), uint32_t(1));				   // PTX L4382
	r_PtxRegister2325 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2324);			   // PTX L4383
	r_PtxRegister2326 = ShiftRightSigned(int32_t(r_PtxRegister2325), uint32_t(1));			   // PTX L4384
	r_PtxU64Register271 = uint64_t(int64_t(int32_t(r_PtxRegister2326)) * int64_t(int32_t(4))); // PTX L4385
	g_RecordByteAddressAtPtx4386 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register271); // PTX L4386
	r_PtxRegister1861 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4386 + 524288ull);		   // PTX L4387
	r_LaneIndexAtPtx4389 = uint32_t((threadIdx.x & 31u));									   // PTX L4389
	r_PtxRegister2327 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4389), uint32_t(31));		   // PTX L4391
	r_PtxRegister2328 = ShiftRight(uint32_t(r_PtxRegister2327), uint32_t(30));				   // PTX L4392
	r_PtxRegister2329 = uint32_t(r_LaneIndexAtPtx4389) + uint32_t(r_PtxRegister2328);		   // PTX L4393
	r_PtxRegister2330 = r_PtxRegister2329 & 2147483644;										   // PTX L4394
	r_PtxRegister2331 = uint32_t(r_LaneIndexAtPtx4389) - uint32_t(r_PtxRegister2330);		   // PTX L4395
	r_PtxRegister2332 = ShiftLeft(uint32_t(r_PtxRegister2331), uint32_t(1));				   // PTX L4396
	r_PtxRegister2333 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister2332);			   // PTX L4397
	r_PtxRegister2334 = ShiftRightSigned(int32_t(r_PtxRegister2333), uint32_t(1));			   // PTX L4398
	r_PtxU64Register273 = uint64_t(int64_t(int32_t(r_PtxRegister2334)) * int64_t(int32_t(4))); // PTX L4399
	g_RecordByteAddressAtPtx4400 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register273); // PTX L4400
	r_PtxRegister1863 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4400 + 524288ull);		   // PTX L4401
	r_LaneIndexAtPtx4403 = uint32_t((threadIdx.x & 31u));									   // PTX L4403
	r_PtxRegister2335 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4403), uint32_t(31));		   // PTX L4405
	r_PtxRegister2336 = ShiftRight(uint32_t(r_PtxRegister2335), uint32_t(30));				   // PTX L4406
	r_PtxRegister2337 = uint32_t(r_LaneIndexAtPtx4403) + uint32_t(r_PtxRegister2336);		   // PTX L4407
	r_PtxRegister2338 = r_PtxRegister2337 & 2147483644;										   // PTX L4408
	r_PtxRegister2339 = uint32_t(r_LaneIndexAtPtx4403) - uint32_t(r_PtxRegister2338);		   // PTX L4409
	r_PtxRegister2340 = ShiftLeft(uint32_t(r_PtxRegister2339), uint32_t(1));				   // PTX L4410
	r_PtxRegister2341 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2340);			   // PTX L4411
	r_PtxRegister2342 = ShiftRightSigned(int32_t(r_PtxRegister2341), uint32_t(1));			   // PTX L4412
	r_PtxU64Register275 = uint64_t(int64_t(int32_t(r_PtxRegister2342)) * int64_t(int32_t(4))); // PTX L4413
	g_RecordByteAddressAtPtx4414 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register275); // PTX L4414
	r_PtxRegister1865 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4414 + 524288ull);		   // PTX L4415
	r_LaneIndexAtPtx4417 = uint32_t((threadIdx.x & 31u));									   // PTX L4417
	r_PtxRegister2343 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4417), uint32_t(31));		   // PTX L4419
	r_PtxRegister2344 = ShiftRight(uint32_t(r_PtxRegister2343), uint32_t(30));				   // PTX L4420
	r_PtxRegister2345 = uint32_t(r_LaneIndexAtPtx4417) + uint32_t(r_PtxRegister2344);		   // PTX L4421
	r_PtxRegister2346 = r_PtxRegister2345 & 2147483644;										   // PTX L4422
	r_PtxRegister2347 = uint32_t(r_LaneIndexAtPtx4417) - uint32_t(r_PtxRegister2346);		   // PTX L4423
	r_PtxRegister2348 = ShiftLeft(uint32_t(r_PtxRegister2347), uint32_t(1));				   // PTX L4424
	r_PtxRegister2349 = uint32_t(r_PtxRegister1893) + uint32_t(r_PtxRegister2348);			   // PTX L4425
	r_PtxRegister2350 = ShiftRightSigned(int32_t(r_PtxRegister2349), uint32_t(1));			   // PTX L4426
	r_PtxU64Register277 = uint64_t(int64_t(int32_t(r_PtxRegister2350)) * int64_t(int32_t(4))); // PTX L4427
	g_RecordByteAddressAtPtx4428 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register277); // PTX L4428
	r_PtxRegister1867 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4428 + 524288ull);		   // PTX L4429
	r_LaneIndexAtPtx4431 = uint32_t((threadIdx.x & 31u));									   // PTX L4431
	r_PtxRegister2351 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4431), uint32_t(31));		   // PTX L4433
	r_PtxRegister2352 = ShiftRight(uint32_t(r_PtxRegister2351), uint32_t(30));				   // PTX L4434
	r_PtxRegister2353 = uint32_t(r_LaneIndexAtPtx4431) + uint32_t(r_PtxRegister2352);		   // PTX L4435
	r_PtxRegister2354 = r_PtxRegister2353 & 2147483644;										   // PTX L4436
	r_PtxRegister2355 = uint32_t(r_LaneIndexAtPtx4431) - uint32_t(r_PtxRegister2354);		   // PTX L4437
	r_PtxRegister2356 = ShiftLeft(uint32_t(r_PtxRegister2355), uint32_t(1));				   // PTX L4438
	r_PtxRegister2357 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2356);			   // PTX L4439
	r_PtxRegister2358 = ShiftRightSigned(int32_t(r_PtxRegister2357), uint32_t(1));			   // PTX L4440
	r_PtxU64Register279 = uint64_t(int64_t(int32_t(r_PtxRegister2358)) * int64_t(int32_t(4))); // PTX L4441
	g_RecordByteAddressAtPtx4442 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register279); // PTX L4442
	r_PtxRegister1869 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4442 + 524288ull);		   // PTX L4443
	r_LaneIndexAtPtx4445 = uint32_t((threadIdx.x & 31u));									   // PTX L4445
	r_PtxRegister2359 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4445), uint32_t(31));		   // PTX L4447
	r_PtxRegister2360 = ShiftRight(uint32_t(r_PtxRegister2359), uint32_t(30));				   // PTX L4448
	r_PtxRegister2361 = uint32_t(r_LaneIndexAtPtx4445) + uint32_t(r_PtxRegister2360);		   // PTX L4449
	r_PtxRegister2362 = r_PtxRegister2361 & 2147483644;										   // PTX L4450
	r_PtxRegister2363 = uint32_t(r_LaneIndexAtPtx4445) - uint32_t(r_PtxRegister2362);		   // PTX L4451
	r_PtxRegister2364 = ShiftLeft(uint32_t(r_PtxRegister2363), uint32_t(1));				   // PTX L4452
	r_PtxRegister2365 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister2364);			   // PTX L4453
	r_PtxRegister2366 = ShiftRightSigned(int32_t(r_PtxRegister2365), uint32_t(1));			   // PTX L4454
	r_PtxU64Register281 = uint64_t(int64_t(int32_t(r_PtxRegister2366)) * int64_t(int32_t(4))); // PTX L4455
	g_RecordByteAddressAtPtx4456 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register281); // PTX L4456
	r_PtxRegister1871 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4456 + 524288ull);		   // PTX L4457
	r_LaneIndexAtPtx4459 = uint32_t((threadIdx.x & 31u));									   // PTX L4459
	r_PtxRegister2367 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4459), uint32_t(31));		   // PTX L4461
	r_PtxRegister2368 = ShiftRight(uint32_t(r_PtxRegister2367), uint32_t(30));				   // PTX L4462
	r_PtxRegister2369 = uint32_t(r_LaneIndexAtPtx4459) + uint32_t(r_PtxRegister2368);		   // PTX L4463
	r_PtxRegister2370 = r_PtxRegister2369 & 2147483644;										   // PTX L4464
	r_PtxRegister2371 = uint32_t(r_LaneIndexAtPtx4459) - uint32_t(r_PtxRegister2370);		   // PTX L4465
	r_PtxRegister2372 = ShiftLeft(uint32_t(r_PtxRegister2371), uint32_t(1));				   // PTX L4466
	r_PtxRegister2373 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2372);			   // PTX L4467
	r_PtxRegister2374 = ShiftRight(uint32_t(r_PtxRegister2373), uint32_t(31));				   // PTX L4468
	r_PtxRegister2375 = uint32_t(r_PtxRegister2373) + uint32_t(r_PtxRegister2374);			   // PTX L4469
	r_PtxRegister2376 = ShiftRightSigned(int32_t(r_PtxRegister2375), uint32_t(1));			   // PTX L4470
	r_PtxU64Register283 = uint64_t(int64_t(int32_t(r_PtxRegister2376)) * int64_t(int32_t(4))); // PTX L4471
	g_RecordByteAddressAtPtx4472 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register283); // PTX L4472
	r_PtxRegister1873 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4472 + 524288ull);		   // PTX L4473
	r_LaneIndexAtPtx4475 = uint32_t((threadIdx.x & 31u));									   // PTX L4475
	r_PtxRegister2377 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4475), uint32_t(31));		   // PTX L4477
	r_PtxRegister2378 = ShiftRight(uint32_t(r_PtxRegister2377), uint32_t(30));				   // PTX L4478
	r_PtxRegister2379 = uint32_t(r_LaneIndexAtPtx4475) + uint32_t(r_PtxRegister2378);		   // PTX L4479
	r_PtxRegister2380 = r_PtxRegister2379 & 2147483644;										   // PTX L4480
	r_PtxRegister2381 = uint32_t(r_LaneIndexAtPtx4475) - uint32_t(r_PtxRegister2380);		   // PTX L4481
	r_PtxRegister2382 = ShiftLeft(uint32_t(r_PtxRegister2381), uint32_t(1));				   // PTX L4482
	r_PtxRegister2383 = uint32_t(r_PtxRegister1948) + uint32_t(r_PtxRegister2382);			   // PTX L4483
	r_PtxRegister2384 = ShiftRight(uint32_t(r_PtxRegister2383), uint32_t(31));				   // PTX L4484
	r_PtxRegister2385 = uint32_t(r_PtxRegister2383) + uint32_t(r_PtxRegister2384);			   // PTX L4485
	r_PtxRegister2386 = ShiftRightSigned(int32_t(r_PtxRegister2385), uint32_t(1));			   // PTX L4486
	r_PtxU64Register285 = uint64_t(int64_t(int32_t(r_PtxRegister2386)) * int64_t(int32_t(4))); // PTX L4487
	g_RecordByteAddressAtPtx4488 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register285); // PTX L4488
	r_PtxRegister1875 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4488 + 524288ull);		   // PTX L4489
	r_LaneIndexAtPtx4491 = uint32_t((threadIdx.x & 31u));									   // PTX L4491
	r_PtxRegister2387 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4491), uint32_t(31));		   // PTX L4493
	r_PtxRegister2388 = ShiftRight(uint32_t(r_PtxRegister2387), uint32_t(30));				   // PTX L4494
	r_PtxRegister2389 = uint32_t(r_LaneIndexAtPtx4491) + uint32_t(r_PtxRegister2388);		   // PTX L4495
	r_PtxRegister2390 = r_PtxRegister2389 & 2147483644;										   // PTX L4496
	r_PtxRegister2391 = uint32_t(r_LaneIndexAtPtx4491) - uint32_t(r_PtxRegister2390);		   // PTX L4497
	r_PtxRegister2392 = ShiftLeft(uint32_t(r_PtxRegister2391), uint32_t(1));				   // PTX L4498
	r_PtxRegister2393 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2392);			   // PTX L4499
	r_PtxRegister2394 = ShiftRightSigned(int32_t(r_PtxRegister2393), uint32_t(1));			   // PTX L4500
	r_PtxU64Register287 = uint64_t(int64_t(int32_t(r_PtxRegister2394)) * int64_t(int32_t(4))); // PTX L4501
	g_RecordByteAddressAtPtx4502 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register287); // PTX L4502
	r_PtxRegister1877 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4502 + 524288ull);		   // PTX L4503
	r_LaneIndexAtPtx4505 = uint32_t((threadIdx.x & 31u));									   // PTX L4505
	r_PtxRegister2395 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4505), uint32_t(31));		   // PTX L4507
	r_PtxRegister2396 = ShiftRight(uint32_t(r_PtxRegister2395), uint32_t(30));				   // PTX L4508
	r_PtxRegister2397 = uint32_t(r_LaneIndexAtPtx4505) + uint32_t(r_PtxRegister2396);		   // PTX L4509
	r_PtxRegister2398 = r_PtxRegister2397 & 2147483644;										   // PTX L4510
	r_PtxRegister2399 = uint32_t(r_LaneIndexAtPtx4505) - uint32_t(r_PtxRegister2398);		   // PTX L4511
	r_PtxRegister2400 = ShiftLeft(uint32_t(r_PtxRegister2399), uint32_t(1));				   // PTX L4512
	r_PtxRegister2401 = uint32_t(r_PtxRegister1969) + uint32_t(r_PtxRegister2400);			   // PTX L4513
	r_PtxRegister2402 = ShiftRightSigned(int32_t(r_PtxRegister2401), uint32_t(1));			   // PTX L4514
	r_PtxU64Register289 = uint64_t(int64_t(int32_t(r_PtxRegister2402)) * int64_t(int32_t(4))); // PTX L4515
	g_RecordByteAddressAtPtx4516 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register289); // PTX L4516
	r_PtxRegister1879 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4516 + 524288ull);		   // PTX L4517
	r_LaneIndexAtPtx4519 = uint32_t((threadIdx.x & 31u));									   // PTX L4519
	r_PtxRegister2403 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4519), uint32_t(31));		   // PTX L4521
	r_PtxRegister2404 = ShiftRight(uint32_t(r_PtxRegister2403), uint32_t(30));				   // PTX L4522
	r_PtxRegister2405 = uint32_t(r_LaneIndexAtPtx4519) + uint32_t(r_PtxRegister2404);		   // PTX L4523
	r_PtxRegister2406 = r_PtxRegister2405 & 2147483644;										   // PTX L4524
	r_PtxRegister2407 = uint32_t(r_LaneIndexAtPtx4519) - uint32_t(r_PtxRegister2406);		   // PTX L4525
	r_PtxRegister2408 = ShiftLeft(uint32_t(r_PtxRegister2407), uint32_t(1));				   // PTX L4526
	r_PtxRegister2409 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2408);			   // PTX L4527
	r_PtxRegister2410 = ShiftRight(uint32_t(r_PtxRegister2409), uint32_t(31));				   // PTX L4528
	r_PtxRegister2411 = uint32_t(r_PtxRegister2409) + uint32_t(r_PtxRegister2410);			   // PTX L4529
	r_PtxRegister2412 = ShiftRightSigned(int32_t(r_PtxRegister2411), uint32_t(1));			   // PTX L4530
	r_PtxU64Register291 = uint64_t(int64_t(int32_t(r_PtxRegister2412)) * int64_t(int32_t(4))); // PTX L4531
	g_RecordByteAddressAtPtx4532 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register291); // PTX L4532
	r_PtxRegister1881 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4532 + 524288ull);		   // PTX L4533
	r_LaneIndexAtPtx4535 = uint32_t((threadIdx.x & 31u));									   // PTX L4535
	r_PtxRegister2413 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4535), uint32_t(31));		   // PTX L4537
	r_PtxRegister2414 = ShiftRight(uint32_t(r_PtxRegister2413), uint32_t(30));				   // PTX L4538
	r_PtxRegister2415 = uint32_t(r_LaneIndexAtPtx4535) + uint32_t(r_PtxRegister2414);		   // PTX L4539
	r_PtxRegister2416 = r_PtxRegister2415 & 2147483644;										   // PTX L4540
	r_PtxRegister2417 = uint32_t(r_LaneIndexAtPtx4535) - uint32_t(r_PtxRegister2416);		   // PTX L4541
	r_PtxRegister2418 = ShiftLeft(uint32_t(r_PtxRegister2417), uint32_t(1));				   // PTX L4542
	r_PtxRegister2419 = uint32_t(r_PtxRegister1986) + uint32_t(r_PtxRegister2418);			   // PTX L4543
	r_PtxRegister2420 = ShiftRight(uint32_t(r_PtxRegister2419), uint32_t(31));				   // PTX L4544
	r_PtxRegister2421 = uint32_t(r_PtxRegister2419) + uint32_t(r_PtxRegister2420);			   // PTX L4545
	r_PtxRegister2422 = ShiftRightSigned(int32_t(r_PtxRegister2421), uint32_t(1));			   // PTX L4546
	r_PtxU64Register293 = uint64_t(int64_t(int32_t(r_PtxRegister2422)) * int64_t(int32_t(4))); // PTX L4547
	g_RecordByteAddressAtPtx4548 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register293); // PTX L4548
	r_PtxRegister1883 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4548 + 524288ull);		   // PTX L4549
	r_LaneIndexAtPtx4551 = uint32_t((threadIdx.x & 31u));									   // PTX L4551
	r_PtxRegister2423 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4551), uint32_t(31));		   // PTX L4553
	r_PtxRegister2424 = ShiftRight(uint32_t(r_PtxRegister2423), uint32_t(30));				   // PTX L4554
	r_PtxRegister2425 = uint32_t(r_LaneIndexAtPtx4551) + uint32_t(r_PtxRegister2424);		   // PTX L4555
	r_PtxRegister2426 = r_PtxRegister2425 & 2147483644;										   // PTX L4556
	r_PtxRegister2427 = uint32_t(r_LaneIndexAtPtx4551) - uint32_t(r_PtxRegister2426);		   // PTX L4557
	r_PtxRegister2428 = ShiftLeft(uint32_t(r_PtxRegister2427), uint32_t(1));				   // PTX L4558
	r_PtxRegister2429 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2428);			   // PTX L4559
	r_PtxRegister2430 = ShiftRightSigned(int32_t(r_PtxRegister2429), uint32_t(1));			   // PTX L4560
	r_PtxU64Register295 = uint64_t(int64_t(int32_t(r_PtxRegister2430)) * int64_t(int32_t(4))); // PTX L4561
	g_RecordByteAddressAtPtx4562 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register295); // PTX L4562
	r_PtxRegister1885 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4562 + 524288ull);		   // PTX L4563
	r_LaneIndexAtPtx4565 = uint32_t((threadIdx.x & 31u));									   // PTX L4565
	r_PtxRegister2431 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4565), uint32_t(31));		   // PTX L4567
	r_PtxRegister2432 = ShiftRight(uint32_t(r_PtxRegister2431), uint32_t(30));				   // PTX L4568
	r_PtxRegister2433 = uint32_t(r_LaneIndexAtPtx4565) + uint32_t(r_PtxRegister2432);		   // PTX L4569
	r_PtxRegister2434 = r_PtxRegister2433 & 2147483644;										   // PTX L4570
	r_PtxRegister2435 = uint32_t(r_LaneIndexAtPtx4565) - uint32_t(r_PtxRegister2434);		   // PTX L4571
	r_PtxRegister2436 = ShiftLeft(uint32_t(r_PtxRegister2435), uint32_t(1));				   // PTX L4572
	r_PtxRegister2437 = uint32_t(r_PtxRegister2007) + uint32_t(r_PtxRegister2436);			   // PTX L4573
	r_PtxRegister2438 = ShiftRightSigned(int32_t(r_PtxRegister2437), uint32_t(1));			   // PTX L4574
	r_PtxU64Register297 = uint64_t(int64_t(int32_t(r_PtxRegister2438)) * int64_t(int32_t(4))); // PTX L4575
	g_RecordByteAddressAtPtx4576 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register297); // PTX L4576
	r_PtxRegister1887 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4576 + 524288ull);		   // PTX L4577
	r_LaneIndexAtPtx4579 = uint32_t((threadIdx.x & 31u));									   // PTX L4579
	r_PtxRegister2439 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4579), uint32_t(31));		   // PTX L4581
	r_PtxRegister2440 = ShiftRight(uint32_t(r_PtxRegister2439), uint32_t(30));				   // PTX L4582
	r_PtxRegister2441 = uint32_t(r_LaneIndexAtPtx4579) + uint32_t(r_PtxRegister2440);		   // PTX L4583
	r_PtxRegister2442 = r_PtxRegister2441 & 2147483644;										   // PTX L4584
	r_PtxRegister2443 = uint32_t(r_LaneIndexAtPtx4579) - uint32_t(r_PtxRegister2442);		   // PTX L4585
	r_PtxRegister2444 = ShiftLeft(uint32_t(r_PtxRegister2443), uint32_t(1));				   // PTX L4586
	r_PtxRegister2445 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2444);			   // PTX L4587
	r_PtxRegister2446 = ShiftRight(uint32_t(r_PtxRegister2445), uint32_t(31));				   // PTX L4588
	r_PtxRegister2447 = uint32_t(r_PtxRegister2445) + uint32_t(r_PtxRegister2446);			   // PTX L4589
	r_PtxRegister2448 = ShiftRightSigned(int32_t(r_PtxRegister2447), uint32_t(1));			   // PTX L4590
	r_PtxU64Register299 = uint64_t(int64_t(int32_t(r_PtxRegister2448)) * int64_t(int32_t(4))); // PTX L4591
	g_RecordByteAddressAtPtx4592 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register299); // PTX L4592
	r_PtxRegister1889 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4592 + 524288ull);		   // PTX L4593
	r_LaneIndexAtPtx4595 = uint32_t((threadIdx.x & 31u));									   // PTX L4595
	r_PtxRegister2449 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4595), uint32_t(31));		   // PTX L4597
	r_PtxRegister2450 = ShiftRight(uint32_t(r_PtxRegister2449), uint32_t(30));				   // PTX L4598
	r_PtxRegister2451 = uint32_t(r_LaneIndexAtPtx4595) + uint32_t(r_PtxRegister2450);		   // PTX L4599
	r_PtxRegister2452 = r_PtxRegister2451 & 2147483644;										   // PTX L4600
	r_PtxRegister2453 = uint32_t(r_LaneIndexAtPtx4595) - uint32_t(r_PtxRegister2452);		   // PTX L4601
	r_PtxRegister2454 = ShiftLeft(uint32_t(r_PtxRegister2453), uint32_t(1));				   // PTX L4602
	r_PtxRegister2455 = uint32_t(r_PtxRegister2024) + uint32_t(r_PtxRegister2454);			   // PTX L4603
	r_PtxRegister2456 = ShiftRight(uint32_t(r_PtxRegister2455), uint32_t(31));				   // PTX L4604
	r_PtxRegister2457 = uint32_t(r_PtxRegister2455) + uint32_t(r_PtxRegister2456);			   // PTX L4605
	r_PtxRegister2458 = ShiftRightSigned(int32_t(r_PtxRegister2457), uint32_t(1));			   // PTX L4606
	r_PtxU64Register301 = uint64_t(int64_t(int32_t(r_PtxRegister2458)) * int64_t(int32_t(4))); // PTX L4607
	g_RecordByteAddressAtPtx4608 =
		uint64_t(g_RecordByteAddressAtPtx3659) + uint64_t(r_PtxU64Register301); // PTX L4608
	r_PtxRegister1891 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx4608 + 524288ull); // PTX L4609
	r_LaneIndexAtPtx4611 = uint32_t((threadIdx.x & 31u));							  // PTX L4611
	r_PackedHalf2AtPtx4614R2826 = HalfMul(r_PtxRegister2699, r_PtxRegister1765);	  // PTX L4614
	r_LaneIndexAtPtx4618 = uint32_t((threadIdx.x & 31u));							  // PTX L4618
	r_PackedHalf2AtPtx4621R2825 = HalfMul(r_PtxRegister2700, r_PtxRegister1767);	  // PTX L4621
	r_LaneIndexAtPtx4625 = uint32_t((threadIdx.x & 31u));							  // PTX L4625
	r_PackedHalf2AtPtx4628R2824 = HalfMul(r_PtxRegister2701, r_PtxRegister1769);	  // PTX L4628
	r_LaneIndexAtPtx4632 = uint32_t((threadIdx.x & 31u));							  // PTX L4632
	r_PackedHalf2AtPtx4635R2823 = HalfMul(r_PtxRegister2702, r_PtxRegister1771);	  // PTX L4635
	r_LaneIndexAtPtx4639 = uint32_t((threadIdx.x & 31u));							  // PTX L4639
	r_PackedHalf2AtPtx4642R2822 = HalfMul(r_PtxRegister2703, r_PtxRegister1773);	  // PTX L4642
	r_LaneIndexAtPtx4646 = uint32_t((threadIdx.x & 31u));							  // PTX L4646
	r_PackedHalf2AtPtx4649R2821 = HalfMul(r_PtxRegister2704, r_PtxRegister1775);	  // PTX L4649
	r_LaneIndexAtPtx4653 = uint32_t((threadIdx.x & 31u));							  // PTX L4653
	r_PackedHalf2AtPtx4656R2820 = HalfMul(r_PtxRegister2705, r_PtxRegister1777);	  // PTX L4656
	r_LaneIndexAtPtx4660 = uint32_t((threadIdx.x & 31u));							  // PTX L4660
	r_PackedHalf2AtPtx4663R2819 = HalfMul(r_PtxRegister2706, r_PtxRegister1779);	  // PTX L4663
	r_LaneIndexAtPtx4667 = uint32_t((threadIdx.x & 31u));							  // PTX L4667
	r_PackedHalf2AtPtx4670R2818 = HalfMul(r_PtxRegister2707, r_PtxRegister1781);	  // PTX L4670
	r_LaneIndexAtPtx4674 = uint32_t((threadIdx.x & 31u));							  // PTX L4674
	r_PackedHalf2AtPtx4677R2817 = HalfMul(r_PtxRegister2708, r_PtxRegister1783);	  // PTX L4677
	r_LaneIndexAtPtx4681 = uint32_t((threadIdx.x & 31u));							  // PTX L4681
	r_PackedHalf2AtPtx4684R2816 = HalfMul(r_PtxRegister2709, r_PtxRegister1785);	  // PTX L4684
	r_LaneIndexAtPtx4688 = uint32_t((threadIdx.x & 31u));							  // PTX L4688
	r_PackedHalf2AtPtx4691R2815 = HalfMul(r_PtxRegister2710, r_PtxRegister1787);	  // PTX L4691
	r_LaneIndexAtPtx4695 = uint32_t((threadIdx.x & 31u));							  // PTX L4695
	r_PackedHalf2AtPtx4698R2814 = HalfMul(r_PtxRegister2711, r_PtxRegister1789);	  // PTX L4698
	r_LaneIndexAtPtx4702 = uint32_t((threadIdx.x & 31u));							  // PTX L4702
	r_PackedHalf2AtPtx4705R2813 = HalfMul(r_PtxRegister2712, r_PtxRegister1791);	  // PTX L4705
	r_LaneIndexAtPtx4709 = uint32_t((threadIdx.x & 31u));							  // PTX L4709
	r_PackedHalf2AtPtx4712R2812 = HalfMul(r_PtxRegister2713, r_PtxRegister1793);	  // PTX L4712
	r_LaneIndexAtPtx4716 = uint32_t((threadIdx.x & 31u));							  // PTX L4716
	r_PackedHalf2AtPtx4719R2811 = HalfMul(r_PtxRegister2714, r_PtxRegister1795);	  // PTX L4719
	r_LaneIndexAtPtx4723 = uint32_t((threadIdx.x & 31u));							  // PTX L4723
	r_PackedHalf2AtPtx4726R2810 = HalfMul(r_PtxRegister2715, r_PtxRegister1797);	  // PTX L4726
	r_LaneIndexAtPtx4730 = uint32_t((threadIdx.x & 31u));							  // PTX L4730
	r_PackedHalf2AtPtx4733R2809 = HalfMul(r_PtxRegister2716, r_PtxRegister1799);	  // PTX L4733
	r_LaneIndexAtPtx4737 = uint32_t((threadIdx.x & 31u));							  // PTX L4737
	r_PackedHalf2AtPtx4740R2808 = HalfMul(r_PtxRegister2717, r_PtxRegister1801);	  // PTX L4740
	r_LaneIndexAtPtx4744 = uint32_t((threadIdx.x & 31u));							  // PTX L4744
	r_PackedHalf2AtPtx4747R2807 = HalfMul(r_PtxRegister2718, r_PtxRegister1803);	  // PTX L4747
	r_LaneIndexAtPtx4751 = uint32_t((threadIdx.x & 31u));							  // PTX L4751
	r_PackedHalf2AtPtx4754R2806 = HalfMul(r_PtxRegister2719, r_PtxRegister1805);	  // PTX L4754
	r_LaneIndexAtPtx4758 = uint32_t((threadIdx.x & 31u));							  // PTX L4758
	r_PackedHalf2AtPtx4761R2805 = HalfMul(r_PtxRegister2720, r_PtxRegister1807);	  // PTX L4761
	r_LaneIndexAtPtx4765 = uint32_t((threadIdx.x & 31u));							  // PTX L4765
	r_PackedHalf2AtPtx4768R2804 = HalfMul(r_PtxRegister2721, r_PtxRegister1809);	  // PTX L4768
	r_LaneIndexAtPtx4772 = uint32_t((threadIdx.x & 31u));							  // PTX L4772
	r_PackedHalf2AtPtx4775R2803 = HalfMul(r_PtxRegister2722, r_PtxRegister1811);	  // PTX L4775
	r_LaneIndexAtPtx4779 = uint32_t((threadIdx.x & 31u));							  // PTX L4779
	r_PackedHalf2AtPtx4782R2802 = HalfMul(r_PtxRegister2723, r_PtxRegister1813);	  // PTX L4782
	r_LaneIndexAtPtx4786 = uint32_t((threadIdx.x & 31u));							  // PTX L4786
	r_PackedHalf2AtPtx4789R2801 = HalfMul(r_PtxRegister2724, r_PtxRegister1815);	  // PTX L4789
	r_LaneIndexAtPtx4793 = uint32_t((threadIdx.x & 31u));							  // PTX L4793
	r_PackedHalf2AtPtx4796R2800 = HalfMul(r_PtxRegister2725, r_PtxRegister1817);	  // PTX L4796
	r_LaneIndexAtPtx4800 = uint32_t((threadIdx.x & 31u));							  // PTX L4800
	r_PackedHalf2AtPtx4803R2799 = HalfMul(r_PtxRegister2726, r_PtxRegister1819);	  // PTX L4803
	r_LaneIndexAtPtx4807 = uint32_t((threadIdx.x & 31u));							  // PTX L4807
	r_PackedHalf2AtPtx4810R2798 = HalfMul(r_PtxRegister2727, r_PtxRegister1821);	  // PTX L4810
	r_LaneIndexAtPtx4814 = uint32_t((threadIdx.x & 31u));							  // PTX L4814
	r_PackedHalf2AtPtx4817R2797 = HalfMul(r_PtxRegister2728, r_PtxRegister1823);	  // PTX L4817
	r_LaneIndexAtPtx4821 = uint32_t((threadIdx.x & 31u));							  // PTX L4821
	r_PackedHalf2AtPtx4824R2796 = HalfMul(r_PtxRegister2729, r_PtxRegister1825);	  // PTX L4824
	r_LaneIndexAtPtx4828 = uint32_t((threadIdx.x & 31u));							  // PTX L4828
	r_PackedHalf2AtPtx4831R2795 = HalfMul(r_PtxRegister2730, r_PtxRegister1827);	  // PTX L4831
	r_LaneIndexAtPtx4835 = uint32_t((threadIdx.x & 31u));							  // PTX L4835
	r_PackedHalf2AtPtx4838R2794 = HalfMul(r_PtxRegister2731, r_PtxRegister1829);	  // PTX L4838
	r_LaneIndexAtPtx4842 = uint32_t((threadIdx.x & 31u));							  // PTX L4842
	r_PackedHalf2AtPtx4845R2793 = HalfMul(r_PtxRegister2732, r_PtxRegister1831);	  // PTX L4845
	r_LaneIndexAtPtx4849 = uint32_t((threadIdx.x & 31u));							  // PTX L4849
	r_PackedHalf2AtPtx4852R2792 = HalfMul(r_PtxRegister2733, r_PtxRegister1833);	  // PTX L4852
	r_LaneIndexAtPtx4856 = uint32_t((threadIdx.x & 31u));							  // PTX L4856
	r_PackedHalf2AtPtx4859R2791 = HalfMul(r_PtxRegister2734, r_PtxRegister1835);	  // PTX L4859
	r_LaneIndexAtPtx4863 = uint32_t((threadIdx.x & 31u));							  // PTX L4863
	r_PackedHalf2AtPtx4866R2790 = HalfMul(r_PtxRegister2735, r_PtxRegister1837);	  // PTX L4866
	r_LaneIndexAtPtx4870 = uint32_t((threadIdx.x & 31u));							  // PTX L4870
	r_PackedHalf2AtPtx4873R2789 = HalfMul(r_PtxRegister2736, r_PtxRegister1839);	  // PTX L4873
	r_LaneIndexAtPtx4877 = uint32_t((threadIdx.x & 31u));							  // PTX L4877
	r_PackedHalf2AtPtx4880R2788 = HalfMul(r_PtxRegister2737, r_PtxRegister1841);	  // PTX L4880
	r_LaneIndexAtPtx4884 = uint32_t((threadIdx.x & 31u));							  // PTX L4884
	r_PackedHalf2AtPtx4887R2787 = HalfMul(r_PtxRegister2738, r_PtxRegister1843);	  // PTX L4887
	r_LaneIndexAtPtx4891 = uint32_t((threadIdx.x & 31u));							  // PTX L4891
	r_PackedHalf2AtPtx4894R2786 = HalfMul(r_PtxRegister2739, r_PtxRegister1845);	  // PTX L4894
	r_LaneIndexAtPtx4898 = uint32_t((threadIdx.x & 31u));							  // PTX L4898
	r_PackedHalf2AtPtx4901R2785 = HalfMul(r_PtxRegister2740, r_PtxRegister1847);	  // PTX L4901
	r_LaneIndexAtPtx4905 = uint32_t((threadIdx.x & 31u));							  // PTX L4905
	r_PackedHalf2AtPtx4908R2784 = HalfMul(r_PtxRegister2741, r_PtxRegister1849);	  // PTX L4908
	r_LaneIndexAtPtx4912 = uint32_t((threadIdx.x & 31u));							  // PTX L4912
	r_PackedHalf2AtPtx4915R2783 = HalfMul(r_PtxRegister2742, r_PtxRegister1851);	  // PTX L4915
	r_LaneIndexAtPtx4919 = uint32_t((threadIdx.x & 31u));							  // PTX L4919
	r_PackedHalf2AtPtx4922R2782 = HalfMul(r_PtxRegister2743, r_PtxRegister1853);	  // PTX L4922
	r_LaneIndexAtPtx4926 = uint32_t((threadIdx.x & 31u));							  // PTX L4926
	r_PackedHalf2AtPtx4929R2781 = HalfMul(r_PtxRegister2744, r_PtxRegister1855);	  // PTX L4929
	r_LaneIndexAtPtx4933 = uint32_t((threadIdx.x & 31u));							  // PTX L4933
	r_PackedHalf2AtPtx4936R2780 = HalfMul(r_PtxRegister2745, r_PtxRegister1857);	  // PTX L4936
	r_LaneIndexAtPtx4940 = uint32_t((threadIdx.x & 31u));							  // PTX L4940
	r_PackedHalf2AtPtx4943R2779 = HalfMul(r_PtxRegister2746, r_PtxRegister1859);	  // PTX L4943
	r_LaneIndexAtPtx4947 = uint32_t((threadIdx.x & 31u));							  // PTX L4947
	r_PackedHalf2AtPtx4950R2778 = HalfMul(r_PtxRegister2747, r_PtxRegister1861);	  // PTX L4950
	r_LaneIndexAtPtx4954 = uint32_t((threadIdx.x & 31u));							  // PTX L4954
	r_PackedHalf2AtPtx4957R2777 = HalfMul(r_PtxRegister2748, r_PtxRegister1863);	  // PTX L4957
	r_LaneIndexAtPtx4961 = uint32_t((threadIdx.x & 31u));							  // PTX L4961
	r_PackedHalf2AtPtx4964R2776 = HalfMul(r_PtxRegister2749, r_PtxRegister1865);	  // PTX L4964
	r_LaneIndexAtPtx4968 = uint32_t((threadIdx.x & 31u));							  // PTX L4968
	r_PackedHalf2AtPtx4971R2775 = HalfMul(r_PtxRegister2750, r_PtxRegister1867);	  // PTX L4971
	r_LaneIndexAtPtx4975 = uint32_t((threadIdx.x & 31u));							  // PTX L4975
	r_PackedHalf2AtPtx4978R2774 = HalfMul(r_PtxRegister2751, r_PtxRegister1869);	  // PTX L4978
	r_LaneIndexAtPtx4982 = uint32_t((threadIdx.x & 31u));							  // PTX L4982
	r_PackedHalf2AtPtx4985R2773 = HalfMul(r_PtxRegister2752, r_PtxRegister1871);	  // PTX L4985
	r_LaneIndexAtPtx4989 = uint32_t((threadIdx.x & 31u));							  // PTX L4989
	r_PackedHalf2AtPtx4992R2772 = HalfMul(r_PtxRegister2753, r_PtxRegister1873);	  // PTX L4992
	r_LaneIndexAtPtx4996 = uint32_t((threadIdx.x & 31u));							  // PTX L4996
	r_PackedHalf2AtPtx4999R2771 = HalfMul(r_PtxRegister2754, r_PtxRegister1875);	  // PTX L4999
	r_LaneIndexAtPtx5003 = uint32_t((threadIdx.x & 31u));							  // PTX L5003
	r_PackedHalf2AtPtx5006R2770 = HalfMul(r_PtxRegister2755, r_PtxRegister1877);	  // PTX L5006
	r_LaneIndexAtPtx5010 = uint32_t((threadIdx.x & 31u));							  // PTX L5010
	r_PackedHalf2AtPtx5013R2769 = HalfMul(r_PtxRegister2756, r_PtxRegister1879);	  // PTX L5013
	r_LaneIndexAtPtx5017 = uint32_t((threadIdx.x & 31u));							  // PTX L5017
	r_PackedHalf2AtPtx5020R2768 = HalfMul(r_PtxRegister2757, r_PtxRegister1881);	  // PTX L5020
	r_LaneIndexAtPtx5024 = uint32_t((threadIdx.x & 31u));							  // PTX L5024
	r_PackedHalf2AtPtx5027R2767 = HalfMul(r_PtxRegister2758, r_PtxRegister1883);	  // PTX L5027
	r_LaneIndexAtPtx5031 = uint32_t((threadIdx.x & 31u));							  // PTX L5031
	r_PackedHalf2AtPtx5034R2766 = HalfMul(r_PtxRegister2759, r_PtxRegister1885);	  // PTX L5034
	r_LaneIndexAtPtx5038 = uint32_t((threadIdx.x & 31u));							  // PTX L5038
	r_PackedHalf2AtPtx5041R2765 = HalfMul(r_PtxRegister2760, r_PtxRegister1887);	  // PTX L5041
	r_LaneIndexAtPtx5045 = uint32_t((threadIdx.x & 31u));							  // PTX L5045
	r_PackedHalf2AtPtx5048R2764 = HalfMul(r_PtxRegister2761, r_PtxRegister1889);	  // PTX L5048
	r_LaneIndexAtPtx5052 = uint32_t((threadIdx.x & 31u));							  // PTX L5052
	r_PackedHalf2AtPtx5055R2763 = HalfMul(r_PtxRegister2762, r_PtxRegister1891);	  // PTX L5055
	r_bPtxPredicate68 = int32_t(r_PtxRegister236) < int32_t(r_HeightDiv4Bits);		  // PTX L5058
	r_PtxRegister2827 = uint32_t(0);												  // PTX L5059
L__BB18_199:																		  // PTX L5060
	r_PtxRegister2571 = ShiftRight(uint32_t(r_PtxRegister2827), uint32_t(5));		  // PTX L5061
	r_PtxU16Register1 = uint16_t(r_PtxRegister2571);								  // PTX L5062
	r_PtxU16Register2 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register1)) * uint32_t(uint16_t(171)));				 // PTX L5063
	r_PtxU16Register3 = ShiftRight(uint16_t(r_PtxU16Register2), uint32_t(9));					 // PTX L5064
	r_PtxU16Register4 = uint16_t(uint32_t(uint16_t(r_PtxU16Register3)) * uint32_t(uint16_t(3))); // PTX L5065
	r_PtxU16Register5 = uint16_t(r_PtxU16Register1) - uint16_t(r_PtxU16Register4);				 // PTX L5066
	r_PtxRegister2572 = uint32_t(uint16_t(r_PtxU16Register5));									 // PTX L5067
	r_PtxRegister162 = r_PtxRegister2572 & 255;													 // PTX L5068
	r_PtxU16Register6 = r_PtxU16Register5 & 255;												 // PTX L5069
	r_PtxRegister2573 = uint32_t(uint16_t(r_PtxU16Register6)) * uint32_t(uint16_t(4096));		 // PTX L5070
	r_LaneIndexAtPtx5072 = uint32_t((threadIdx.x & 31u));										 // PTX L5072
	r_PtxRegister2574 = uint32_t(0u /* exact native shared-region offset */);					 // PTX L5074
	r_PtxRegister163 = uint32_t(r_PtxRegister2574) + uint32_t(r_PtxRegister2573);				 // PTX L5075
	r_PtxRegister2575 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5072), uint32_t(4));					 // PTX L5076
	r_PtxRegister2460 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2575);				 // PTX L5077
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2460));
		r_MmaAHalf2WordAtPtx5079R2475 = r_Value.x;
		r_MmaAHalf2WordAtPtx5079R2476 = r_Value.y;
		r_MmaAHalf2WordAtPtx5079R2477 = r_Value.z;
		r_MmaAHalf2WordAtPtx5079R2478 = r_Value.w;
	} // PTX L5079
	r_LaneIndexAtPtx5082 = uint32_t((threadIdx.x & 31u));						  // PTX L5082
	r_PtxRegister2576 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5082), uint32_t(4));	  // PTX L5084
	r_PtxRegister2577 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2576); // PTX L5085
	r_PtxRegister2462 = uint32_t(r_PtxRegister2577) + uint32_t(512);			  // PTX L5086
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2462));
		r_MmaAHalf2WordAtPtx5088R2479 = r_Value.x;
		r_MmaAHalf2WordAtPtx5088R2480 = r_Value.y;
		r_MmaAHalf2WordAtPtx5088R2481 = r_Value.z;
		r_MmaAHalf2WordAtPtx5088R2482 = r_Value.w;
	} // PTX L5088
	r_LaneIndexAtPtx5091 = uint32_t((threadIdx.x & 31u));						  // PTX L5091
	r_PtxRegister2578 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5091), uint32_t(4));	  // PTX L5093
	r_PtxRegister2579 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2578); // PTX L5094
	r_PtxRegister2464 = uint32_t(r_PtxRegister2579) + uint32_t(1024);			  // PTX L5095
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2464));
		r_MmaAHalf2WordAtPtx5097R2499 = r_Value.x;
		r_MmaAHalf2WordAtPtx5097R2500 = r_Value.y;
		r_MmaAHalf2WordAtPtx5097R2501 = r_Value.z;
		r_MmaAHalf2WordAtPtx5097R2502 = r_Value.w;
	} // PTX L5097
	r_LaneIndexAtPtx5100 = uint32_t((threadIdx.x & 31u));						  // PTX L5100
	r_PtxRegister2580 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5100), uint32_t(4));	  // PTX L5102
	r_PtxRegister2581 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2580); // PTX L5103
	r_PtxRegister2466 = uint32_t(r_PtxRegister2581) + uint32_t(1536);			  // PTX L5104
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2466));
		r_MmaAHalf2WordAtPtx5106R2503 = r_Value.x;
		r_MmaAHalf2WordAtPtx5106R2504 = r_Value.y;
		r_MmaAHalf2WordAtPtx5106R2505 = r_Value.z;
		r_MmaAHalf2WordAtPtx5106R2506 = r_Value.w;
	} // PTX L5106
	r_LaneIndexAtPtx5109 = uint32_t((threadIdx.x & 31u));						  // PTX L5109
	r_PtxRegister2582 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5109), uint32_t(4));	  // PTX L5111
	r_PtxRegister2583 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2582); // PTX L5112
	r_PtxRegister2468 = uint32_t(r_PtxRegister2583) + uint32_t(2048);			  // PTX L5113
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2468));
		r_MmaAHalf2WordAtPtx5115R2523 = r_Value.x;
		r_MmaAHalf2WordAtPtx5115R2524 = r_Value.y;
		r_MmaAHalf2WordAtPtx5115R2525 = r_Value.z;
		r_MmaAHalf2WordAtPtx5115R2526 = r_Value.w;
	} // PTX L5115
	r_LaneIndexAtPtx5118 = uint32_t((threadIdx.x & 31u));						  // PTX L5118
	r_PtxRegister2584 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5118), uint32_t(4));	  // PTX L5120
	r_PtxRegister2585 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2584); // PTX L5121
	r_PtxRegister2470 = uint32_t(r_PtxRegister2585) + uint32_t(2560);			  // PTX L5122
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2470));
		r_MmaAHalf2WordAtPtx5124R2527 = r_Value.x;
		r_MmaAHalf2WordAtPtx5124R2528 = r_Value.y;
		r_MmaAHalf2WordAtPtx5124R2529 = r_Value.z;
		r_MmaAHalf2WordAtPtx5124R2530 = r_Value.w;
	} // PTX L5124
	r_LaneIndexAtPtx5127 = uint32_t((threadIdx.x & 31u));						  // PTX L5127
	r_PtxRegister2586 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5127), uint32_t(4));	  // PTX L5129
	r_PtxRegister2587 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2586); // PTX L5130
	r_PtxRegister2472 = uint32_t(r_PtxRegister2587) + uint32_t(3072);			  // PTX L5131
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2472));
		r_MmaAHalf2WordAtPtx5133R2547 = r_Value.x;
		r_MmaAHalf2WordAtPtx5133R2548 = r_Value.y;
		r_MmaAHalf2WordAtPtx5133R2549 = r_Value.z;
		r_MmaAHalf2WordAtPtx5133R2550 = r_Value.w;
	} // PTX L5133
	r_LaneIndexAtPtx5136 = uint32_t((threadIdx.x & 31u));						  // PTX L5136
	r_PtxRegister2588 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5136), uint32_t(4));	  // PTX L5138
	r_PtxRegister2589 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2588); // PTX L5139
	r_PtxRegister2474 = uint32_t(r_PtxRegister2589) + uint32_t(3584);			  // PTX L5140
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2474));
		r_MmaAHalf2WordAtPtx5142R2551 = r_Value.x;
		r_MmaAHalf2WordAtPtx5142R2552 = r_Value.y;
		r_MmaAHalf2WordAtPtx5142R2553 = r_Value.z;
		r_MmaAHalf2WordAtPtx5142R2554 = r_Value.w;
	} // PTX L5142
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5145R2483, r_MmaAccumulatorHalf2WordAtPtx5145R2484,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx87R2857, r_MmaBHalf2WordAtPtx87R2856,
			r_PackedHalf2AtPtx4614R2826, r_PackedHalf2AtPtx4621R2825); // PTX L5145
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5152R2485, r_MmaAccumulatorHalf2WordAtPtx5152R2486,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx87R2855, r_MmaBHalf2WordAtPtx87R2854,
			r_PackedHalf2AtPtx4628R2824, r_PackedHalf2AtPtx4635R2823); // PTX L5152
	MmaHalf(r_PackedHalf2AtPtx4614R2826, r_PackedHalf2AtPtx4621R2825, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx123R2841, r_MmaBHalf2WordAtPtx123R2840,
			r_MmaAccumulatorHalf2WordAtPtx5145R2483,
			r_MmaAccumulatorHalf2WordAtPtx5145R2484); // PTX L5159
	MmaHalf(r_PackedHalf2AtPtx4628R2824, r_PackedHalf2AtPtx4635R2823, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx123R2839, r_MmaBHalf2WordAtPtx123R2838,
			r_MmaAccumulatorHalf2WordAtPtx5152R2485,
			r_MmaAccumulatorHalf2WordAtPtx5152R2486); // PTX L5166
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5173R2487, r_MmaAccumulatorHalf2WordAtPtx5173R2488,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx96R2853, r_MmaBHalf2WordAtPtx96R2852,
			r_PackedHalf2AtPtx4642R2822, r_PackedHalf2AtPtx4649R2821); // PTX L5173
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5180R2489, r_MmaAccumulatorHalf2WordAtPtx5180R2490,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx96R2851, r_MmaBHalf2WordAtPtx96R2850,
			r_PackedHalf2AtPtx4656R2820, r_PackedHalf2AtPtx4663R2819); // PTX L5180
	MmaHalf(r_PackedHalf2AtPtx4642R2822, r_PackedHalf2AtPtx4649R2821, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx132R2837, r_MmaBHalf2WordAtPtx132R2836,
			r_MmaAccumulatorHalf2WordAtPtx5173R2487,
			r_MmaAccumulatorHalf2WordAtPtx5173R2488); // PTX L5187
	MmaHalf(r_PackedHalf2AtPtx4656R2820, r_PackedHalf2AtPtx4663R2819, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx132R2835, r_MmaBHalf2WordAtPtx132R2834,
			r_MmaAccumulatorHalf2WordAtPtx5180R2489,
			r_MmaAccumulatorHalf2WordAtPtx5180R2490); // PTX L5194
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5201R2491, r_MmaAccumulatorHalf2WordAtPtx5201R2492,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx105R2849, r_MmaBHalf2WordAtPtx105R2848,
			r_PackedHalf2AtPtx4670R2818, r_PackedHalf2AtPtx4677R2817); // PTX L5201
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5208R2493, r_MmaAccumulatorHalf2WordAtPtx5208R2494,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx105R2847, r_MmaBHalf2WordAtPtx105R2846,
			r_PackedHalf2AtPtx4684R2816, r_PackedHalf2AtPtx4691R2815); // PTX L5208
	MmaHalf(r_PackedHalf2AtPtx4670R2818, r_PackedHalf2AtPtx4677R2817, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx141R2833, r_MmaBHalf2WordAtPtx141R2832,
			r_MmaAccumulatorHalf2WordAtPtx5201R2491,
			r_MmaAccumulatorHalf2WordAtPtx5201R2492); // PTX L5215
	MmaHalf(r_PackedHalf2AtPtx4684R2816, r_PackedHalf2AtPtx4691R2815, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx141R2831, r_MmaBHalf2WordAtPtx141R2830,
			r_MmaAccumulatorHalf2WordAtPtx5208R2493,
			r_MmaAccumulatorHalf2WordAtPtx5208R2494); // PTX L5222
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5229R2495, r_MmaAccumulatorHalf2WordAtPtx5229R2496,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx114R2845, r_MmaBHalf2WordAtPtx114R2844,
			r_PackedHalf2AtPtx4698R2814, r_PackedHalf2AtPtx4705R2813); // PTX L5229
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5236R2497, r_MmaAccumulatorHalf2WordAtPtx5236R2498,
			r_MmaAHalf2WordAtPtx5079R2475, r_MmaAHalf2WordAtPtx5079R2476, r_MmaAHalf2WordAtPtx5079R2477,
			r_MmaAHalf2WordAtPtx5079R2478, r_MmaBHalf2WordAtPtx114R2843, r_MmaBHalf2WordAtPtx114R2842,
			r_PackedHalf2AtPtx4712R2812, r_PackedHalf2AtPtx4719R2811); // PTX L5236
	MmaHalf(r_PackedHalf2AtPtx4698R2814, r_PackedHalf2AtPtx4705R2813, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx150R2829, r_MmaBHalf2WordAtPtx150R2828,
			r_MmaAccumulatorHalf2WordAtPtx5229R2495,
			r_MmaAccumulatorHalf2WordAtPtx5229R2496); // PTX L5243
	MmaHalf(r_PackedHalf2AtPtx4712R2812, r_PackedHalf2AtPtx4719R2811, r_MmaAHalf2WordAtPtx5088R2479,
			r_MmaAHalf2WordAtPtx5088R2480, r_MmaAHalf2WordAtPtx5088R2481, r_MmaAHalf2WordAtPtx5088R2482,
			r_MmaBHalf2WordAtPtx150R2858, r_MmaBHalf2WordAtPtx150R2859,
			r_MmaAccumulatorHalf2WordAtPtx5236R2497,
			r_MmaAccumulatorHalf2WordAtPtx5236R2498); // PTX L5250
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5257R2507, r_MmaAccumulatorHalf2WordAtPtx5257R2508,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx87R2857, r_MmaBHalf2WordAtPtx87R2856,
			r_PackedHalf2AtPtx4726R2810, r_PackedHalf2AtPtx4733R2809); // PTX L5257
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5264R2509, r_MmaAccumulatorHalf2WordAtPtx5264R2510,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx87R2855, r_MmaBHalf2WordAtPtx87R2854,
			r_PackedHalf2AtPtx4740R2808, r_PackedHalf2AtPtx4747R2807); // PTX L5264
	MmaHalf(r_PackedHalf2AtPtx4726R2810, r_PackedHalf2AtPtx4733R2809, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx123R2841, r_MmaBHalf2WordAtPtx123R2840,
			r_MmaAccumulatorHalf2WordAtPtx5257R2507,
			r_MmaAccumulatorHalf2WordAtPtx5257R2508); // PTX L5271
	MmaHalf(r_PackedHalf2AtPtx4740R2808, r_PackedHalf2AtPtx4747R2807, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx123R2839, r_MmaBHalf2WordAtPtx123R2838,
			r_MmaAccumulatorHalf2WordAtPtx5264R2509,
			r_MmaAccumulatorHalf2WordAtPtx5264R2510); // PTX L5278
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5285R2511, r_MmaAccumulatorHalf2WordAtPtx5285R2512,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx96R2853, r_MmaBHalf2WordAtPtx96R2852,
			r_PackedHalf2AtPtx4754R2806, r_PackedHalf2AtPtx4761R2805); // PTX L5285
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5292R2513, r_MmaAccumulatorHalf2WordAtPtx5292R2514,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx96R2851, r_MmaBHalf2WordAtPtx96R2850,
			r_PackedHalf2AtPtx4768R2804, r_PackedHalf2AtPtx4775R2803); // PTX L5292
	MmaHalf(r_PackedHalf2AtPtx4754R2806, r_PackedHalf2AtPtx4761R2805, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx132R2837, r_MmaBHalf2WordAtPtx132R2836,
			r_MmaAccumulatorHalf2WordAtPtx5285R2511,
			r_MmaAccumulatorHalf2WordAtPtx5285R2512); // PTX L5299
	MmaHalf(r_PackedHalf2AtPtx4768R2804, r_PackedHalf2AtPtx4775R2803, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx132R2835, r_MmaBHalf2WordAtPtx132R2834,
			r_MmaAccumulatorHalf2WordAtPtx5292R2513,
			r_MmaAccumulatorHalf2WordAtPtx5292R2514); // PTX L5306
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5313R2515, r_MmaAccumulatorHalf2WordAtPtx5313R2516,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx105R2849, r_MmaBHalf2WordAtPtx105R2848,
			r_PackedHalf2AtPtx4782R2802, r_PackedHalf2AtPtx4789R2801); // PTX L5313
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5320R2517, r_MmaAccumulatorHalf2WordAtPtx5320R2518,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx105R2847, r_MmaBHalf2WordAtPtx105R2846,
			r_PackedHalf2AtPtx4796R2800, r_PackedHalf2AtPtx4803R2799); // PTX L5320
	MmaHalf(r_PackedHalf2AtPtx4782R2802, r_PackedHalf2AtPtx4789R2801, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx141R2833, r_MmaBHalf2WordAtPtx141R2832,
			r_MmaAccumulatorHalf2WordAtPtx5313R2515,
			r_MmaAccumulatorHalf2WordAtPtx5313R2516); // PTX L5327
	MmaHalf(r_PackedHalf2AtPtx4796R2800, r_PackedHalf2AtPtx4803R2799, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx141R2831, r_MmaBHalf2WordAtPtx141R2830,
			r_MmaAccumulatorHalf2WordAtPtx5320R2517,
			r_MmaAccumulatorHalf2WordAtPtx5320R2518); // PTX L5334
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5341R2519, r_MmaAccumulatorHalf2WordAtPtx5341R2520,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx114R2845, r_MmaBHalf2WordAtPtx114R2844,
			r_PackedHalf2AtPtx4810R2798, r_PackedHalf2AtPtx4817R2797); // PTX L5341
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5348R2521, r_MmaAccumulatorHalf2WordAtPtx5348R2522,
			r_MmaAHalf2WordAtPtx5097R2499, r_MmaAHalf2WordAtPtx5097R2500, r_MmaAHalf2WordAtPtx5097R2501,
			r_MmaAHalf2WordAtPtx5097R2502, r_MmaBHalf2WordAtPtx114R2843, r_MmaBHalf2WordAtPtx114R2842,
			r_PackedHalf2AtPtx4824R2796, r_PackedHalf2AtPtx4831R2795); // PTX L5348
	MmaHalf(r_PackedHalf2AtPtx4810R2798, r_PackedHalf2AtPtx4817R2797, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx150R2829, r_MmaBHalf2WordAtPtx150R2828,
			r_MmaAccumulatorHalf2WordAtPtx5341R2519,
			r_MmaAccumulatorHalf2WordAtPtx5341R2520); // PTX L5355
	MmaHalf(r_PackedHalf2AtPtx4824R2796, r_PackedHalf2AtPtx4831R2795, r_MmaAHalf2WordAtPtx5106R2503,
			r_MmaAHalf2WordAtPtx5106R2504, r_MmaAHalf2WordAtPtx5106R2505, r_MmaAHalf2WordAtPtx5106R2506,
			r_MmaBHalf2WordAtPtx150R2858, r_MmaBHalf2WordAtPtx150R2859,
			r_MmaAccumulatorHalf2WordAtPtx5348R2521,
			r_MmaAccumulatorHalf2WordAtPtx5348R2522); // PTX L5362
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5369R2531, r_MmaAccumulatorHalf2WordAtPtx5369R2532,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx87R2857, r_MmaBHalf2WordAtPtx87R2856,
			r_PackedHalf2AtPtx4838R2794, r_PackedHalf2AtPtx4845R2793); // PTX L5369
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5376R2533, r_MmaAccumulatorHalf2WordAtPtx5376R2534,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx87R2855, r_MmaBHalf2WordAtPtx87R2854,
			r_PackedHalf2AtPtx4852R2792, r_PackedHalf2AtPtx4859R2791); // PTX L5376
	MmaHalf(r_PackedHalf2AtPtx4838R2794, r_PackedHalf2AtPtx4845R2793, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx123R2841, r_MmaBHalf2WordAtPtx123R2840,
			r_MmaAccumulatorHalf2WordAtPtx5369R2531,
			r_MmaAccumulatorHalf2WordAtPtx5369R2532); // PTX L5383
	MmaHalf(r_PackedHalf2AtPtx4852R2792, r_PackedHalf2AtPtx4859R2791, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx123R2839, r_MmaBHalf2WordAtPtx123R2838,
			r_MmaAccumulatorHalf2WordAtPtx5376R2533,
			r_MmaAccumulatorHalf2WordAtPtx5376R2534); // PTX L5390
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5397R2535, r_MmaAccumulatorHalf2WordAtPtx5397R2536,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx96R2853, r_MmaBHalf2WordAtPtx96R2852,
			r_PackedHalf2AtPtx4866R2790, r_PackedHalf2AtPtx4873R2789); // PTX L5397
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5404R2537, r_MmaAccumulatorHalf2WordAtPtx5404R2538,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx96R2851, r_MmaBHalf2WordAtPtx96R2850,
			r_PackedHalf2AtPtx4880R2788, r_PackedHalf2AtPtx4887R2787); // PTX L5404
	MmaHalf(r_PackedHalf2AtPtx4866R2790, r_PackedHalf2AtPtx4873R2789, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx132R2837, r_MmaBHalf2WordAtPtx132R2836,
			r_MmaAccumulatorHalf2WordAtPtx5397R2535,
			r_MmaAccumulatorHalf2WordAtPtx5397R2536); // PTX L5411
	MmaHalf(r_PackedHalf2AtPtx4880R2788, r_PackedHalf2AtPtx4887R2787, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx132R2835, r_MmaBHalf2WordAtPtx132R2834,
			r_MmaAccumulatorHalf2WordAtPtx5404R2537,
			r_MmaAccumulatorHalf2WordAtPtx5404R2538); // PTX L5418
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5425R2539, r_MmaAccumulatorHalf2WordAtPtx5425R2540,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx105R2849, r_MmaBHalf2WordAtPtx105R2848,
			r_PackedHalf2AtPtx4894R2786, r_PackedHalf2AtPtx4901R2785); // PTX L5425
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5432R2541, r_MmaAccumulatorHalf2WordAtPtx5432R2542,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx105R2847, r_MmaBHalf2WordAtPtx105R2846,
			r_PackedHalf2AtPtx4908R2784, r_PackedHalf2AtPtx4915R2783); // PTX L5432
	MmaHalf(r_PackedHalf2AtPtx4894R2786, r_PackedHalf2AtPtx4901R2785, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx141R2833, r_MmaBHalf2WordAtPtx141R2832,
			r_MmaAccumulatorHalf2WordAtPtx5425R2539,
			r_MmaAccumulatorHalf2WordAtPtx5425R2540); // PTX L5439
	MmaHalf(r_PackedHalf2AtPtx4908R2784, r_PackedHalf2AtPtx4915R2783, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx141R2831, r_MmaBHalf2WordAtPtx141R2830,
			r_MmaAccumulatorHalf2WordAtPtx5432R2541,
			r_MmaAccumulatorHalf2WordAtPtx5432R2542); // PTX L5446
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5453R2543, r_MmaAccumulatorHalf2WordAtPtx5453R2544,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx114R2845, r_MmaBHalf2WordAtPtx114R2844,
			r_PackedHalf2AtPtx4922R2782, r_PackedHalf2AtPtx4929R2781); // PTX L5453
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5460R2545, r_MmaAccumulatorHalf2WordAtPtx5460R2546,
			r_MmaAHalf2WordAtPtx5115R2523, r_MmaAHalf2WordAtPtx5115R2524, r_MmaAHalf2WordAtPtx5115R2525,
			r_MmaAHalf2WordAtPtx5115R2526, r_MmaBHalf2WordAtPtx114R2843, r_MmaBHalf2WordAtPtx114R2842,
			r_PackedHalf2AtPtx4936R2780, r_PackedHalf2AtPtx4943R2779); // PTX L5460
	MmaHalf(r_PackedHalf2AtPtx4922R2782, r_PackedHalf2AtPtx4929R2781, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx150R2829, r_MmaBHalf2WordAtPtx150R2828,
			r_MmaAccumulatorHalf2WordAtPtx5453R2543,
			r_MmaAccumulatorHalf2WordAtPtx5453R2544); // PTX L5467
	MmaHalf(r_PackedHalf2AtPtx4936R2780, r_PackedHalf2AtPtx4943R2779, r_MmaAHalf2WordAtPtx5124R2527,
			r_MmaAHalf2WordAtPtx5124R2528, r_MmaAHalf2WordAtPtx5124R2529, r_MmaAHalf2WordAtPtx5124R2530,
			r_MmaBHalf2WordAtPtx150R2858, r_MmaBHalf2WordAtPtx150R2859,
			r_MmaAccumulatorHalf2WordAtPtx5460R2545,
			r_MmaAccumulatorHalf2WordAtPtx5460R2546); // PTX L5474
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5481R2555, r_MmaAccumulatorHalf2WordAtPtx5481R2556,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx87R2857, r_MmaBHalf2WordAtPtx87R2856,
			r_PackedHalf2AtPtx4950R2778, r_PackedHalf2AtPtx4957R2777); // PTX L5481
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5488R2557, r_MmaAccumulatorHalf2WordAtPtx5488R2558,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx87R2855, r_MmaBHalf2WordAtPtx87R2854,
			r_PackedHalf2AtPtx4964R2776, r_PackedHalf2AtPtx4971R2775); // PTX L5488
	MmaHalf(r_PackedHalf2AtPtx4950R2778, r_PackedHalf2AtPtx4957R2777, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx123R2841, r_MmaBHalf2WordAtPtx123R2840,
			r_MmaAccumulatorHalf2WordAtPtx5481R2555,
			r_MmaAccumulatorHalf2WordAtPtx5481R2556); // PTX L5495
	MmaHalf(r_PackedHalf2AtPtx4964R2776, r_PackedHalf2AtPtx4971R2775, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx123R2839, r_MmaBHalf2WordAtPtx123R2838,
			r_MmaAccumulatorHalf2WordAtPtx5488R2557,
			r_MmaAccumulatorHalf2WordAtPtx5488R2558); // PTX L5502
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5509R2559, r_MmaAccumulatorHalf2WordAtPtx5509R2560,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx96R2853, r_MmaBHalf2WordAtPtx96R2852,
			r_PackedHalf2AtPtx4978R2774, r_PackedHalf2AtPtx4985R2773); // PTX L5509
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5516R2561, r_MmaAccumulatorHalf2WordAtPtx5516R2562,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx96R2851, r_MmaBHalf2WordAtPtx96R2850,
			r_PackedHalf2AtPtx4992R2772, r_PackedHalf2AtPtx4999R2771); // PTX L5516
	MmaHalf(r_PackedHalf2AtPtx4978R2774, r_PackedHalf2AtPtx4985R2773, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx132R2837, r_MmaBHalf2WordAtPtx132R2836,
			r_MmaAccumulatorHalf2WordAtPtx5509R2559,
			r_MmaAccumulatorHalf2WordAtPtx5509R2560); // PTX L5523
	MmaHalf(r_PackedHalf2AtPtx4992R2772, r_PackedHalf2AtPtx4999R2771, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx132R2835, r_MmaBHalf2WordAtPtx132R2834,
			r_MmaAccumulatorHalf2WordAtPtx5516R2561,
			r_MmaAccumulatorHalf2WordAtPtx5516R2562); // PTX L5530
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5537R2563, r_MmaAccumulatorHalf2WordAtPtx5537R2564,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx105R2849, r_MmaBHalf2WordAtPtx105R2848,
			r_PackedHalf2AtPtx5006R2770, r_PackedHalf2AtPtx5013R2769); // PTX L5537
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5544R2565, r_MmaAccumulatorHalf2WordAtPtx5544R2566,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx105R2847, r_MmaBHalf2WordAtPtx105R2846,
			r_PackedHalf2AtPtx5020R2768, r_PackedHalf2AtPtx5027R2767); // PTX L5544
	MmaHalf(r_PackedHalf2AtPtx5006R2770, r_PackedHalf2AtPtx5013R2769, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx141R2833, r_MmaBHalf2WordAtPtx141R2832,
			r_MmaAccumulatorHalf2WordAtPtx5537R2563,
			r_MmaAccumulatorHalf2WordAtPtx5537R2564); // PTX L5551
	MmaHalf(r_PackedHalf2AtPtx5020R2768, r_PackedHalf2AtPtx5027R2767, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx141R2831, r_MmaBHalf2WordAtPtx141R2830,
			r_MmaAccumulatorHalf2WordAtPtx5544R2565,
			r_MmaAccumulatorHalf2WordAtPtx5544R2566); // PTX L5558
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5565R2567, r_MmaAccumulatorHalf2WordAtPtx5565R2568,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx114R2845, r_MmaBHalf2WordAtPtx114R2844,
			r_PackedHalf2AtPtx5034R2766, r_PackedHalf2AtPtx5041R2765); // PTX L5565
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx5572R2569, r_MmaAccumulatorHalf2WordAtPtx5572R2570,
			r_MmaAHalf2WordAtPtx5133R2547, r_MmaAHalf2WordAtPtx5133R2548, r_MmaAHalf2WordAtPtx5133R2549,
			r_MmaAHalf2WordAtPtx5133R2550, r_MmaBHalf2WordAtPtx114R2843, r_MmaBHalf2WordAtPtx114R2842,
			r_PackedHalf2AtPtx5048R2764, r_PackedHalf2AtPtx5055R2763); // PTX L5572
	MmaHalf(r_PackedHalf2AtPtx5034R2766, r_PackedHalf2AtPtx5041R2765, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx150R2829, r_MmaBHalf2WordAtPtx150R2828,
			r_MmaAccumulatorHalf2WordAtPtx5565R2567,
			r_MmaAccumulatorHalf2WordAtPtx5565R2568); // PTX L5579
	MmaHalf(r_PackedHalf2AtPtx5048R2764, r_PackedHalf2AtPtx5055R2763, r_MmaAHalf2WordAtPtx5142R2551,
			r_MmaAHalf2WordAtPtx5142R2552, r_MmaAHalf2WordAtPtx5142R2553, r_MmaAHalf2WordAtPtx5142R2554,
			r_MmaBHalf2WordAtPtx150R2858, r_MmaBHalf2WordAtPtx150R2859,
			r_MmaAccumulatorHalf2WordAtPtx5572R2569,
			r_MmaAccumulatorHalf2WordAtPtx5572R2570);				   // PTX L5586
	r_bPtxPredicate1104 = uint32_t(r_PtxRegister2827) > uint32_t(479); // PTX L5592
	if (r_bPtxPredicate1104)
	{
		goto L__BB18_202;
	} // PTX L5593
	r_PtxRegister2599 = uint32_t(r_PtxRegister2827) + uint32_t(32);								  // PTX L5594
	r_PtxRegister2600 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister2827);				  // PTX L5595
	r_PtxRegister2601 = ShiftLeft(uint32_t(r_PtxRegister2600), uint32_t(8));					  // PTX L5596
	r_PtxRegister2602 = uint32_t(r_PtxRegister2601) + uint32_t(r_PtxRegister11);				  // PTX L5597
	r_PtxU64Register311 = uint64_t(int64_t(int32_t(r_PtxRegister2602)) * int64_t(int32_t(4)));	  // PTX L5598
	g_RecordByteAddressAtPtx5599 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register311); // PTX L5599
	r_LaneIndexAtPtx5601 = uint32_t((threadIdx.x & 31u));										  // PTX L5601
	r_PtxU64Register313 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5601)) * int64_t(int32_t(16))); // PTX L5603
	g_RecordByteAddressAtPtx5604 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register313); // PTX L5604
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5604));
		r_MmaBHalf2WordAtPtx87R2857 = r_Value.x;
		r_MmaBHalf2WordAtPtx87R2856 = r_Value.y;
		r_MmaBHalf2WordAtPtx87R2855 = r_Value.z;
		r_MmaBHalf2WordAtPtx87R2854 = r_Value.w;
	} // PTX L5606
	r_LaneIndexAtPtx5609 = uint32_t((threadIdx.x & 31u)); // PTX L5609
	r_PtxU64Register314 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5609)) * int64_t(int32_t(16))); // PTX L5611
	g_RecordByteAddressAtPtx5612 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register314);			   // PTX L5612
	g_RecordByteAddressAtPtx5613 = uint64_t(g_RecordByteAddressAtPtx5612) + uint64_t(512); // PTX L5613
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5613));
		r_MmaBHalf2WordAtPtx96R2853 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R2852 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R2851 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R2850 = r_Value.w;
	} // PTX L5615
	r_LaneIndexAtPtx5618 = uint32_t((threadIdx.x & 31u)); // PTX L5618
	r_PtxU64Register316 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5618)) * int64_t(int32_t(16))); // PTX L5620
	g_RecordByteAddressAtPtx5621 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register316);				// PTX L5621
	g_RecordByteAddressAtPtx5622 = uint64_t(g_RecordByteAddressAtPtx5621) + uint64_t(1024); // PTX L5622
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5622));
		r_MmaBHalf2WordAtPtx105R2849 = r_Value.x;
		r_MmaBHalf2WordAtPtx105R2848 = r_Value.y;
		r_MmaBHalf2WordAtPtx105R2847 = r_Value.z;
		r_MmaBHalf2WordAtPtx105R2846 = r_Value.w;
	} // PTX L5624
	r_LaneIndexAtPtx5627 = uint32_t((threadIdx.x & 31u)); // PTX L5627
	r_PtxU64Register318 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5627)) * int64_t(int32_t(16))); // PTX L5629
	g_RecordByteAddressAtPtx5630 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register318);				// PTX L5630
	g_RecordByteAddressAtPtx5631 = uint64_t(g_RecordByteAddressAtPtx5630) + uint64_t(1536); // PTX L5631
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5631));
		r_MmaBHalf2WordAtPtx114R2845 = r_Value.x;
		r_MmaBHalf2WordAtPtx114R2844 = r_Value.y;
		r_MmaBHalf2WordAtPtx114R2843 = r_Value.z;
		r_MmaBHalf2WordAtPtx114R2842 = r_Value.w;
	} // PTX L5633
	r_LaneIndexAtPtx5636 = uint32_t((threadIdx.x & 31u)); // PTX L5636
	r_PtxU64Register320 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5636)) * int64_t(int32_t(16))); // PTX L5638
	g_RecordByteAddressAtPtx5639 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register320);				 // PTX L5639
	g_RecordByteAddressAtPtx5640 = uint64_t(g_RecordByteAddressAtPtx5639) + uint64_t(16384); // PTX L5640
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5640));
		r_MmaBHalf2WordAtPtx123R2841 = r_Value.x;
		r_MmaBHalf2WordAtPtx123R2840 = r_Value.y;
		r_MmaBHalf2WordAtPtx123R2839 = r_Value.z;
		r_MmaBHalf2WordAtPtx123R2838 = r_Value.w;
	} // PTX L5642
	r_LaneIndexAtPtx5645 = uint32_t((threadIdx.x & 31u)); // PTX L5645
	r_PtxU64Register322 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5645)) * int64_t(int32_t(16))); // PTX L5647
	g_RecordByteAddressAtPtx5648 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register322);				 // PTX L5648
	g_RecordByteAddressAtPtx5649 = uint64_t(g_RecordByteAddressAtPtx5648) + uint64_t(16896); // PTX L5649
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5649));
		r_MmaBHalf2WordAtPtx132R2837 = r_Value.x;
		r_MmaBHalf2WordAtPtx132R2836 = r_Value.y;
		r_MmaBHalf2WordAtPtx132R2835 = r_Value.z;
		r_MmaBHalf2WordAtPtx132R2834 = r_Value.w;
	} // PTX L5651
	r_LaneIndexAtPtx5654 = uint32_t((threadIdx.x & 31u)); // PTX L5654
	r_PtxU64Register324 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5654)) * int64_t(int32_t(16))); // PTX L5656
	g_RecordByteAddressAtPtx5657 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register324);				 // PTX L5657
	g_RecordByteAddressAtPtx5658 = uint64_t(g_RecordByteAddressAtPtx5657) + uint64_t(17408); // PTX L5658
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5658));
		r_MmaBHalf2WordAtPtx141R2833 = r_Value.x;
		r_MmaBHalf2WordAtPtx141R2832 = r_Value.y;
		r_MmaBHalf2WordAtPtx141R2831 = r_Value.z;
		r_MmaBHalf2WordAtPtx141R2830 = r_Value.w;
	} // PTX L5660
	r_LaneIndexAtPtx5663 = uint32_t((threadIdx.x & 31u)); // PTX L5663
	r_PtxU64Register326 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5663)) * int64_t(int32_t(16))); // PTX L5665
	g_RecordByteAddressAtPtx5666 =
		uint64_t(g_RecordByteAddressAtPtx5599) + uint64_t(r_PtxU64Register326);				 // PTX L5666
	g_RecordByteAddressAtPtx5667 = uint64_t(g_RecordByteAddressAtPtx5666) + uint64_t(17920); // PTX L5667
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx5667));
		r_MmaBHalf2WordAtPtx150R2829 = r_Value.x;
		r_MmaBHalf2WordAtPtx150R2828 = r_Value.y;
		r_MmaBHalf2WordAtPtx150R2858 = r_Value.z;
		r_MmaBHalf2WordAtPtx150R2859 = r_Value.w;
	} // PTX L5669
	r_PtxRegister2603 = ShiftRight(uint32_t(r_PtxRegister2599), uint32_t(5)); // PTX L5671
	r_PtxU16Register7 = uint16_t(r_PtxRegister2603);						  // PTX L5672
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L5673
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L5674
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L5675
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L5676
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L5677
	r_PtxRegister2604 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8));			  // PTX L5678
	r_PtxRegister2605 = uint32_t(12288u /* exact native shared-region offset */);				  // PTX L5679
	r_PtxRegister2607 = uint32_t(r_PtxRegister2605) + uint32_t(r_PtxRegister2604);				  // PTX L5680
	r_PtxRegister2598 = uint32_t(1);															  // PTX L5681
	r_PtxU64Register328 = BarrierArrive(s_SharedStorage, r_PtxRegister2607, r_PtxRegister2598);	  // PTX L5683
L__BB18_201:																					  // PTX L5685
	r_PtxRegister2606 = BarrierReady(s_SharedStorage, r_PtxRegister2607, r_PtxU64Register328);	  // PTX L5687
	r_bPtxPredicate1105 = uint32_t(r_PtxRegister2606) == uint32_t(0);							  // PTX L5693
	if (r_bPtxPredicate1105)
	{
		goto L__BB18_201;
	} // PTX L5694
L__BB18_202:														   // PTX L5695
	r_bPtxPredicate1106 = uint32_t(r_PtxRegister2827) > uint32_t(415); // PTX L5696
	if (r_bPtxPredicate1106)
	{
		goto L__BB18_219;
	} // PTX L5697
	r_PtxRegister2608 = uint32_t(r_PtxRegister211) + uint32_t(r_PtxRegister6);		// PTX L5698
	r_bPtxPredicate1107 = int32_t(r_PtxRegister2608) < int32_t(r_WidthDiv4Bits);	// PTX L5699
	r_PtxRegister2609 = ShiftRight(uint32_t(r_ThreadYAtPtx45), uint32_t(2));		// PTX L5700
	r_CtaYAtPtx5701 = uint32_t(blockIdx.y);											// PTX L5701
	r_PtxRegister2611 = ShiftLeft(uint32_t(r_CtaYAtPtx5701), uint32_t(1));			// PTX L5702
	r_PtxRegister2612 = uint32_t(r_PtxRegister2609) + uint32_t(r_PtxRegister2611);	// PTX L5703
	r_bPtxPredicate1108 = int32_t(r_PtxRegister2612) < int32_t(r_HeightDiv4Bits);	// PTX L5704
	r_bPtxPredicate1109 = int32_t(r_PtxRegister2612) >= int32_t(r_HeightDiv4Bits);	// PTX L5705
	r_PtxRegister2613 = r_WidthBits & -4;											// PTX L5706
	r_bPtxPredicate1110 = uint32_t(r_PtxRegister2613) == uint32_t(4);				// PTX L5707
	r_PtxRegister164 = r_HeightBits & -4;											// PTX L5708
	r_bPtxPredicate1111 = uint32_t(r_PtxRegister164) == uint32_t(4);				// PTX L5709
	r_bPtxPredicate69 = uint32_t(r_PtxRegister164) != uint32_t(4);					// PTX L5710
	r_PtxRegister2614 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister2827);	// PTX L5711
	r_PtxRegister165 = uint32_t(r_PtxRegister2614) + uint32_t(64);					// PTX L5712
	r_bPtxPredicate1112 = r_bPtxPredicate69 & r_bPtxPredicate1109;					// PTX L5713
	r_bPtxPredicate1113 = r_bPtxPredicate1111 | r_bPtxPredicate1108;				// PTX L5714
	r_bPtxPredicate1114 = r_bPtxPredicate1112 | r_bPtxPredicate1110;				// PTX L5715
	r_PtxRegister2615 = r_bPtxPredicate1112 ? r_PtxRegister2608 : 0;				// PTX L5716
	r_PtxRegister166 = r_bPtxPredicate1110 ? r_PtxRegister2615 : r_PtxRegister2608; // PTX L5717
	r_bPtxPredicate1115 = r_bPtxPredicate1114 | r_bPtxPredicate1107;				// PTX L5718
	r_bPtxPredicate70 = r_bPtxPredicate1115 & r_bPtxPredicate1113;					// PTX L5719
	r_PtxU64Register393 = uint64_t(0);												// PTX L5720
	r_bPtxPredicate1116 = !r_bPtxPredicate70;										// PTX L5721
	if (r_bPtxPredicate1116)
	{
		goto L__BB18_205;
	} // PTX L5722
	r_PtxRegister2616 =
		uint32_t(r_PtxRegister2612) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister166); // PTX L5723
	r_PtxRegister2617 = r_bPtxPredicate1111 ? r_PtxRegister166 : r_PtxRegister2616;			  // PTX L5724
	r_PtxRegister2618 = ShiftRight(uint32_t(r_PtxRegister165), uint32_t(4));				  // PTX L5725
	r_PtxRegister2619 = uint32_t(r_PtxRegister2618) + uint32_t(r_PtxRegister12);			  // PTX L5726
	r_PtxRegister2620 = ShiftLeft(uint32_t(r_PtxRegister2617), uint32_t(12));				  // PTX L5727
	r_PtxRegister2621 = ShiftLeft(uint32_t(r_PtxRegister2619), uint32_t(7));				  // PTX L5728
	r_PtxRegister2622 = uint32_t(r_PtxRegister2620) + uint32_t(r_PtxRegister2621);			  // PTX L5729
	r_PtxU64Register393 = SignExtendWordBits(r_PtxRegister2622);							  // PTX L5730
L__BB18_205:																				  // PTX L5731
	r_PtxU64Register394 = uint64_t(0);														  // PTX L5732
	if (r_bPtxPredicate1116)
	{
		goto L__BB18_207;
	} // PTX L5733
	r_PtxU64Register329 = ShiftLeft(uint64_t(r_PtxU64Register393), uint32_t(2));		// PTX L5734
	r_PtxU64Register394 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register329); // PTX L5735
L__BB18_207:																			// PTX L5736
	r_PtxRegister2623 = ShiftLeft(uint32_t(r_PtxRegister162), uint32_t(3));				// PTX L5737
	r_PtxRegister2624 = uint32_t(12288u /* exact native shared-region offset */);		// PTX L5738
	r_PtxRegister2668 = uint32_t(r_PtxRegister2624) + uint32_t(r_PtxRegister2623);		// PTX L5739
	if (r_bPtxPredicate1116)
	{
		goto L__BB18_210;
	} // PTX L5740
	r_PtxRegister2634 = uint32_t(-1);								  // PTX L5741
	r_PtxRegister2633 = Elected(r_PtxRegister2634);					  // PTX L5743
	r_bPtxPredicate1117 = uint32_t(r_PtxRegister2633) == uint32_t(0); // PTX L5749
	if (r_bPtxPredicate1117)
	{
		goto L__BB18_211;
	} // PTX L5750
	r_ThreadYAtPtx5751 = uint32_t(threadIdx.y);									  // PTX L5751
	r_PtxRegister2638 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(9));		  // PTX L5752
	r_PtxRegister2639 = ShiftLeft(uint32_t(r_ThreadYAtPtx5751), uint32_t(9));	  // PTX L5753
	r_PtxRegister2640 = r_PtxRegister2639 & 523264;								  // PTX L5754
	r_PtxRegister2641 = r_PtxRegister2638 | r_PtxRegister2640;					  // PTX L5755
	r_PtxRegister2635 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2641); // PTX L5756
	r_PtxU64Register330 = r_PtxU64Register394;									  // PTX L5757
	r_PtxRegister2636 = uint32_t(512);											  // PTX L5758
	CopyBulk(s_SharedStorage, r_PtxRegister2635, r_PtxU64Register330, r_PtxRegister2636,
			 r_PtxRegister2668);												   // PTX L5760
	BarrierExpect(s_SharedStorage, r_PtxRegister2668, r_PtxRegister2636);		   // PTX L5763
	goto L__BB18_211;															   // PTX L5765
L__BB18_210:																	   // PTX L5766
	r_LaneIndexAtPtx5768 = uint32_t((threadIdx.x & 31u));						   // PTX L5768
	r_PtxRegister2627 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(9));		   // PTX L5770
	r_PtxRegister2628 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(9));		   // PTX L5771
	r_PtxRegister2629 = r_PtxRegister2628 & 523264;								   // PTX L5772
	r_PtxRegister2630 = r_PtxRegister2627 | r_PtxRegister2629;					   // PTX L5773
	r_PtxRegister2631 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2630);  // PTX L5774
	r_PtxRegister2632 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5768), uint32_t(4));	   // PTX L5775
	r_PtxRegister2626 = uint32_t(r_PtxRegister2631) + uint32_t(r_PtxRegister2632); // PTX L5776
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2626)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);										// PTX L5778
L__BB18_211:																		// PTX L5780
	r_PtxRegister2642 = uint32_t(r_ThreadYAtPtx45) + uint32_t(4);					// PTX L5781
	r_PtxRegister2643 = ShiftRight(uint32_t(r_PtxRegister2642), uint32_t(2));		// PTX L5782
	r_PtxRegister2644 = uint32_t(r_PtxRegister2643) + uint32_t(r_PtxRegister2611);	// PTX L5783
	r_bPtxPredicate1118 = int32_t(r_PtxRegister2644) >= int32_t(r_HeightDiv4Bits);	// PTX L5784
	r_bPtxPredicate1119 = int32_t(r_PtxRegister2608) < int32_t(r_WidthDiv4Bits);	// PTX L5785
	r_bPtxPredicate1120 = uint32_t(r_PtxRegister2613) == uint32_t(4);				// PTX L5786
	r_bPtxPredicate1121 = uint32_t(r_PtxRegister164) == uint32_t(4);				// PTX L5787
	r_bPtxPredicate1122 = r_bPtxPredicate69 & r_bPtxPredicate1118;					// PTX L5788
	r_bPtxPredicate1123 = r_bPtxPredicate1121 | r_bPtxPredicate68;					// PTX L5789
	r_bPtxPredicate1124 = r_bPtxPredicate1122 | r_bPtxPredicate1120;				// PTX L5790
	r_PtxRegister2645 = r_bPtxPredicate1122 ? r_PtxRegister2608 : 0;				// PTX L5791
	r_PtxRegister167 = r_bPtxPredicate1120 ? r_PtxRegister2645 : r_PtxRegister2608; // PTX L5792
	r_bPtxPredicate1125 = r_bPtxPredicate1124 | r_bPtxPredicate1119;				// PTX L5793
	r_bPtxPredicate71 = r_bPtxPredicate1125 & r_bPtxPredicate1123;					// PTX L5794
	r_PtxU64Register395 = uint64_t(0);												// PTX L5795
	r_bPtxPredicate1126 = !r_bPtxPredicate71;										// PTX L5796
	if (r_bPtxPredicate1126)
	{
		goto L__BB18_213;
	} // PTX L5797
	r_PtxRegister2646 =
		uint32_t(r_PtxRegister2644) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister167); // PTX L5798
	r_PtxRegister2647 = r_bPtxPredicate1121 ? r_PtxRegister167 : r_PtxRegister2646;			  // PTX L5799
	r_PtxRegister2648 = ShiftRight(uint32_t(r_PtxRegister165), uint32_t(4));				  // PTX L5800
	r_PtxRegister2649 = uint32_t(r_PtxRegister2648) + uint32_t(r_PtxRegister12);			  // PTX L5801
	r_PtxRegister2650 = ShiftLeft(uint32_t(r_PtxRegister2647), uint32_t(12));				  // PTX L5802
	r_PtxRegister2651 = ShiftLeft(uint32_t(r_PtxRegister2649), uint32_t(7));				  // PTX L5803
	r_PtxRegister2652 = uint32_t(r_PtxRegister2650) + uint32_t(r_PtxRegister2651);			  // PTX L5804
	r_PtxU64Register395 = SignExtendWordBits(r_PtxRegister2652);							  // PTX L5805
L__BB18_213:																				  // PTX L5806
	r_PtxU64Register396 = uint64_t(0);														  // PTX L5807
	if (r_bPtxPredicate1126)
	{
		goto L__BB18_215;
	} // PTX L5808
	r_PtxU64Register331 = ShiftLeft(uint64_t(r_PtxU64Register395), uint32_t(2));		// PTX L5809
	r_PtxU64Register396 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register331); // PTX L5810
L__BB18_215:																			// PTX L5811
	r_PtxRegister2653 = ShiftLeft(uint32_t(r_ThreadYAtPtx45), uint32_t(7));				// PTX L5812
	r_PtxRegister2654 = uint32_t(r_PtxRegister2653) + uint32_t(512);					// PTX L5813
	r_PtxRegister2655 = r_PtxRegister2654 & 261632;										// PTX L5814
	r_PtxRegister2656 = r_PtxRegister2653 & 256;										// PTX L5815
	r_PtxRegister2657 = r_PtxRegister2655 | r_PtxRegister2656;							// PTX L5816
	r_PtxRegister2658 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(7));				// PTX L5817
	r_PtxRegister168 = r_PtxRegister2657 | r_PtxRegister2658;							// PTX L5818
	if (r_bPtxPredicate1126)
	{
		goto L__BB18_218;
	} // PTX L5819
	r_PtxRegister2665 = uint32_t(-1);								  // PTX L5820
	r_PtxRegister2664 = Elected(r_PtxRegister2665);					  // PTX L5822
	r_bPtxPredicate1127 = uint32_t(r_PtxRegister2664) == uint32_t(0); // PTX L5828
	if (r_bPtxPredicate1127)
	{
		goto L__BB18_219;
	} // PTX L5829
	r_PtxRegister2669 = ShiftLeft(uint32_t(r_PtxRegister168), uint32_t(2));		  // PTX L5830
	r_PtxRegister2666 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2669); // PTX L5831
	r_PtxU64Register332 = r_PtxU64Register396;									  // PTX L5832
	r_PtxRegister2667 = uint32_t(512);											  // PTX L5833
	CopyBulk(s_SharedStorage, r_PtxRegister2666, r_PtxU64Register332, r_PtxRegister2667,
			 r_PtxRegister2668);												   // PTX L5835
	BarrierExpect(s_SharedStorage, r_PtxRegister2668, r_PtxRegister2667);		   // PTX L5838
	goto L__BB18_219;															   // PTX L5840
L__BB18_218:																	   // PTX L5841
	r_LaneIndexAtPtx5843 = uint32_t((threadIdx.x & 31u));						   // PTX L5843
	r_PtxRegister2661 = ShiftLeft(uint32_t(r_PtxRegister168), uint32_t(2));		   // PTX L5845
	r_PtxRegister2662 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister2661);  // PTX L5846
	r_PtxRegister2663 = ShiftLeft(uint32_t(r_LaneIndexAtPtx5843), uint32_t(4));	   // PTX L5847
	r_PtxRegister2660 = uint32_t(r_PtxRegister2662) + uint32_t(r_PtxRegister2663); // PTX L5848
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister2660)) =
		make_uint4(r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313, r_PackedHalf2AtPtx68R313,
				   r_PackedHalf2AtPtx68R313);						   // PTX L5850
L__BB18_219:														   // PTX L5852
	r_bPtxPredicate1128 = uint32_t(r_PtxRegister2827) < uint32_t(480); // PTX L5853
	r_PtxRegister2827 = uint32_t(r_PtxRegister2827) + uint32_t(32);	   // PTX L5854
	if (r_bPtxPredicate1128)
	{
		goto L__BB18_199;
	} // PTX L5855
	r_bPtxPredicate1129 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L5856
	r_bPtxPredicate1130 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);	// PTX L5857
	r_PtxRegister2670 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister6);		  // PTX L5858
	r_PtxRegister2671 = ShiftLeft(uint32_t(r_PtxRegister2670), uint32_t(12));					  // PTX L5859
	r_PtxRegister2672 = uint32_t(r_PtxRegister2671) + uint32_t(r_PtxRegister11);				  // PTX L5860
	r_PtxU64Register333 = uint64_t(int64_t(int32_t(r_PtxRegister2672)) * int64_t(int32_t(4)));	  // PTX L5861
	g_OutputByteAddressAtPtx5862 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register333); // PTX L5862
	r_bPtxPredicate1131 = r_bPtxPredicate1129 | r_bPtxPredicate1130;							  // PTX L5863
	if (r_bPtxPredicate1131)
	{
		goto L__BB18_222;
	} // PTX L5864
	r_LaneIndexAtPtx5866 = uint32_t((threadIdx.x & 31u)); // PTX L5866
	r_PtxU64Register338 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5866)) * int64_t(int32_t(16))); // PTX L5868
	g_OutputByteAddressAtPtx5869 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register338); // PTX L5869
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx5869,
					make_uint4(r_PackedHalf2AtPtx4614R2826, r_PackedHalf2AtPtx4621R2825,
							   r_PackedHalf2AtPtx4628R2824,
							   r_PackedHalf2AtPtx4635R2823)); // PTX L5871
	r_LaneIndexAtPtx5874 = uint32_t((threadIdx.x & 31u));	  // PTX L5874
	r_PtxU64Register339 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5874)) * int64_t(int32_t(16))); // PTX L5876
	g_OutputByteAddressAtPtx5877 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register339);			   // PTX L5877
	g_OutputByteAddressAtPtx5878 = uint64_t(g_OutputByteAddressAtPtx5877) + uint64_t(512); // PTX L5878
	StoreNoAllocate(g_OutputByteAddressAtPtx5878,
					make_uint4(r_PackedHalf2AtPtx4642R2822, r_PackedHalf2AtPtx4649R2821,
							   r_PackedHalf2AtPtx4656R2820,
							   r_PackedHalf2AtPtx4663R2819)); // PTX L5880
	r_LaneIndexAtPtx5883 = uint32_t((threadIdx.x & 31u));	  // PTX L5883
	r_PtxU64Register341 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5883)) * int64_t(int32_t(16))); // PTX L5885
	g_OutputByteAddressAtPtx5886 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register341);				// PTX L5886
	g_OutputByteAddressAtPtx5887 = uint64_t(g_OutputByteAddressAtPtx5886) + uint64_t(1024); // PTX L5887
	StoreNoAllocate(g_OutputByteAddressAtPtx5887,
					make_uint4(r_PackedHalf2AtPtx4670R2818, r_PackedHalf2AtPtx4677R2817,
							   r_PackedHalf2AtPtx4684R2816,
							   r_PackedHalf2AtPtx4691R2815)); // PTX L5889
	r_LaneIndexAtPtx5892 = uint32_t((threadIdx.x & 31u));	  // PTX L5892
	r_PtxU64Register343 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5892)) * int64_t(int32_t(16))); // PTX L5894
	g_OutputByteAddressAtPtx5895 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register343);				// PTX L5895
	g_OutputByteAddressAtPtx5896 = uint64_t(g_OutputByteAddressAtPtx5895) + uint64_t(1536); // PTX L5896
	StoreNoAllocate(g_OutputByteAddressAtPtx5896,
					make_uint4(r_PackedHalf2AtPtx4698R2814, r_PackedHalf2AtPtx4705R2813,
							   r_PackedHalf2AtPtx4712R2812,
							   r_PackedHalf2AtPtx4719R2811));					 // PTX L5898
L__BB18_222:																	 // PTX L5900
	r_bPtxPredicate1132 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits);	 // PTX L5901
	r_PtxRegister169 = uint32_t(r_PtxRegister6) + uint32_t(1);					 // PTX L5902
	r_bPtxPredicate1133 = int32_t(r_PtxRegister169) >= int32_t(r_WidthDiv4Bits); // PTX L5903
	r_bPtxPredicate1134 = r_bPtxPredicate1132 | r_bPtxPredicate1133;			 // PTX L5904
	if (r_bPtxPredicate1134)
	{
		goto L__BB18_224;
	} // PTX L5905
	r_LaneIndexAtPtx5907 = uint32_t((threadIdx.x & 31u)); // PTX L5907
	r_PtxU64Register349 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5907)) * int64_t(int32_t(16))); // PTX L5909
	g_OutputByteAddressAtPtx5910 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register349);				 // PTX L5910
	g_OutputByteAddressAtPtx5911 = uint64_t(g_OutputByteAddressAtPtx5910) + uint64_t(16384); // PTX L5911
	StoreNoAllocate(g_OutputByteAddressAtPtx5911,
					make_uint4(r_PackedHalf2AtPtx4726R2810, r_PackedHalf2AtPtx4733R2809,
							   r_PackedHalf2AtPtx4740R2808,
							   r_PackedHalf2AtPtx4747R2807)); // PTX L5913
	r_LaneIndexAtPtx5916 = uint32_t((threadIdx.x & 31u));	  // PTX L5916
	r_PtxU64Register351 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5916)) * int64_t(int32_t(16))); // PTX L5918
	g_OutputByteAddressAtPtx5919 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register351);				 // PTX L5919
	g_OutputByteAddressAtPtx5920 = uint64_t(g_OutputByteAddressAtPtx5919) + uint64_t(16896); // PTX L5920
	StoreNoAllocate(g_OutputByteAddressAtPtx5920,
					make_uint4(r_PackedHalf2AtPtx4754R2806, r_PackedHalf2AtPtx4761R2805,
							   r_PackedHalf2AtPtx4768R2804,
							   r_PackedHalf2AtPtx4775R2803)); // PTX L5922
	r_LaneIndexAtPtx5925 = uint32_t((threadIdx.x & 31u));	  // PTX L5925
	r_PtxU64Register353 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5925)) * int64_t(int32_t(16))); // PTX L5927
	g_OutputByteAddressAtPtx5928 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register353);				 // PTX L5928
	g_OutputByteAddressAtPtx5929 = uint64_t(g_OutputByteAddressAtPtx5928) + uint64_t(17408); // PTX L5929
	StoreNoAllocate(g_OutputByteAddressAtPtx5929,
					make_uint4(r_PackedHalf2AtPtx4782R2802, r_PackedHalf2AtPtx4789R2801,
							   r_PackedHalf2AtPtx4796R2800,
							   r_PackedHalf2AtPtx4803R2799)); // PTX L5931
	r_LaneIndexAtPtx5934 = uint32_t((threadIdx.x & 31u));	  // PTX L5934
	r_PtxU64Register355 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5934)) * int64_t(int32_t(16))); // PTX L5936
	g_OutputByteAddressAtPtx5937 =
		uint64_t(g_OutputByteAddressAtPtx5862) + uint64_t(r_PtxU64Register355);				 // PTX L5937
	g_OutputByteAddressAtPtx5938 = uint64_t(g_OutputByteAddressAtPtx5937) + uint64_t(17920); // PTX L5938
	StoreNoAllocate(g_OutputByteAddressAtPtx5938,
					make_uint4(r_PackedHalf2AtPtx4810R2798, r_PackedHalf2AtPtx4817R2797,
							   r_PackedHalf2AtPtx4824R2796,
							   r_PackedHalf2AtPtx4831R2795));					  // PTX L5940
L__BB18_224:																	  // PTX L5942
	r_bPtxPredicate1135 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);	  // PTX L5943
	r_PtxRegister170 = uint32_t(r_PtxRegister3) + uint32_t(1);					  // PTX L5944
	r_bPtxPredicate1136 = int32_t(r_PtxRegister170) >= int32_t(r_HeightDiv4Bits); // PTX L5945
	r_PtxRegister2681 =
		uint32_t(r_WidthDiv4Bits) * uint32_t(r_PtxRegister3) + uint32_t(r_WidthDiv4Bits);		  // PTX L5946
	r_PtxRegister2682 = uint32_t(r_PtxRegister2681) + uint32_t(r_PtxRegister6);					  // PTX L5947
	r_PtxRegister2683 = ShiftLeft(uint32_t(r_PtxRegister2682), uint32_t(12));					  // PTX L5948
	r_PtxRegister2684 = uint32_t(r_PtxRegister2683) + uint32_t(r_PtxRegister11);				  // PTX L5949
	r_PtxU64Register357 = uint64_t(int64_t(int32_t(r_PtxRegister2684)) * int64_t(int32_t(4)));	  // PTX L5950
	g_OutputByteAddressAtPtx5951 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register357); // PTX L5951
	r_bPtxPredicate1137 = r_bPtxPredicate1136 | r_bPtxPredicate1135;							  // PTX L5952
	if (r_bPtxPredicate1137)
	{
		goto L__BB18_226;
	} // PTX L5953
	r_LaneIndexAtPtx5955 = uint32_t((threadIdx.x & 31u)); // PTX L5955
	r_PtxU64Register362 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5955)) * int64_t(int32_t(16))); // PTX L5957
	g_OutputByteAddressAtPtx5958 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register362); // PTX L5958
	StoreNoAllocate(g_OutputByteAddressAtPtx5958,
					make_uint4(r_PackedHalf2AtPtx4838R2794, r_PackedHalf2AtPtx4845R2793,
							   r_PackedHalf2AtPtx4852R2792,
							   r_PackedHalf2AtPtx4859R2791)); // PTX L5960
	r_LaneIndexAtPtx5963 = uint32_t((threadIdx.x & 31u));	  // PTX L5963
	r_PtxU64Register363 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5963)) * int64_t(int32_t(16))); // PTX L5965
	g_OutputByteAddressAtPtx5966 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register363);			   // PTX L5966
	g_OutputByteAddressAtPtx5967 = uint64_t(g_OutputByteAddressAtPtx5966) + uint64_t(512); // PTX L5967
	StoreNoAllocate(g_OutputByteAddressAtPtx5967,
					make_uint4(r_PackedHalf2AtPtx4866R2790, r_PackedHalf2AtPtx4873R2789,
							   r_PackedHalf2AtPtx4880R2788,
							   r_PackedHalf2AtPtx4887R2787)); // PTX L5969
	r_LaneIndexAtPtx5972 = uint32_t((threadIdx.x & 31u));	  // PTX L5972
	r_PtxU64Register365 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5972)) * int64_t(int32_t(16))); // PTX L5974
	g_OutputByteAddressAtPtx5975 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register365);				// PTX L5975
	g_OutputByteAddressAtPtx5976 = uint64_t(g_OutputByteAddressAtPtx5975) + uint64_t(1024); // PTX L5976
	StoreNoAllocate(g_OutputByteAddressAtPtx5976,
					make_uint4(r_PackedHalf2AtPtx4894R2786, r_PackedHalf2AtPtx4901R2785,
							   r_PackedHalf2AtPtx4908R2784,
							   r_PackedHalf2AtPtx4915R2783)); // PTX L5978
	r_LaneIndexAtPtx5981 = uint32_t((threadIdx.x & 31u));	  // PTX L5981
	r_PtxU64Register367 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5981)) * int64_t(int32_t(16))); // PTX L5983
	g_OutputByteAddressAtPtx5984 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register367);				// PTX L5984
	g_OutputByteAddressAtPtx5985 = uint64_t(g_OutputByteAddressAtPtx5984) + uint64_t(1536); // PTX L5985
	StoreNoAllocate(g_OutputByteAddressAtPtx5985,
					make_uint4(r_PackedHalf2AtPtx4922R2782, r_PackedHalf2AtPtx4929R2781,
							   r_PackedHalf2AtPtx4936R2780,
							   r_PackedHalf2AtPtx4943R2779));					 // PTX L5987
L__BB18_226:																	 // PTX L5989
	r_bPtxPredicate1138 = int32_t(r_PtxRegister169) >= int32_t(r_WidthDiv4Bits); // PTX L5990
	r_bPtxPredicate1139 = r_bPtxPredicate1136 | r_bPtxPredicate1138;			 // PTX L5991
	if (r_bPtxPredicate1139)
	{
		goto L__BB18_228;
	} // PTX L5992
	r_LaneIndexAtPtx5994 = uint32_t((threadIdx.x & 31u)); // PTX L5994
	r_PtxU64Register373 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5994)) * int64_t(int32_t(16))); // PTX L5996
	g_OutputByteAddressAtPtx5997 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register373);				 // PTX L5997
	g_OutputByteAddressAtPtx5998 = uint64_t(g_OutputByteAddressAtPtx5997) + uint64_t(16384); // PTX L5998
	StoreNoAllocate(g_OutputByteAddressAtPtx5998,
					make_uint4(r_PackedHalf2AtPtx4950R2778, r_PackedHalf2AtPtx4957R2777,
							   r_PackedHalf2AtPtx4964R2776,
							   r_PackedHalf2AtPtx4971R2775)); // PTX L6000
	r_LaneIndexAtPtx6003 = uint32_t((threadIdx.x & 31u));	  // PTX L6003
	r_PtxU64Register375 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx6003)) * int64_t(int32_t(16))); // PTX L6005
	g_OutputByteAddressAtPtx6006 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register375);				 // PTX L6006
	g_OutputByteAddressAtPtx6007 = uint64_t(g_OutputByteAddressAtPtx6006) + uint64_t(16896); // PTX L6007
	StoreNoAllocate(g_OutputByteAddressAtPtx6007,
					make_uint4(r_PackedHalf2AtPtx4978R2774, r_PackedHalf2AtPtx4985R2773,
							   r_PackedHalf2AtPtx4992R2772,
							   r_PackedHalf2AtPtx4999R2771)); // PTX L6009
	r_LaneIndexAtPtx6012 = uint32_t((threadIdx.x & 31u));	  // PTX L6012
	r_PtxU64Register377 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx6012)) * int64_t(int32_t(16))); // PTX L6014
	g_OutputByteAddressAtPtx6015 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register377);				 // PTX L6015
	g_OutputByteAddressAtPtx6016 = uint64_t(g_OutputByteAddressAtPtx6015) + uint64_t(17408); // PTX L6016
	StoreNoAllocate(g_OutputByteAddressAtPtx6016,
					make_uint4(r_PackedHalf2AtPtx5006R2770, r_PackedHalf2AtPtx5013R2769,
							   r_PackedHalf2AtPtx5020R2768,
							   r_PackedHalf2AtPtx5027R2767)); // PTX L6018
	r_LaneIndexAtPtx6021 = uint32_t((threadIdx.x & 31u));	  // PTX L6021
	r_PtxU64Register379 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx6021)) * int64_t(int32_t(16))); // PTX L6023
	g_OutputByteAddressAtPtx6024 =
		uint64_t(g_OutputByteAddressAtPtx5951) + uint64_t(r_PtxU64Register379);				 // PTX L6024
	g_OutputByteAddressAtPtx6025 = uint64_t(g_OutputByteAddressAtPtx6024) + uint64_t(17920); // PTX L6025
	StoreNoAllocate(g_OutputByteAddressAtPtx6025,
					make_uint4(r_PackedHalf2AtPtx5034R2766, r_PackedHalf2AtPtx5041R2765,
							   r_PackedHalf2AtPtx5048R2764,
							   r_PackedHalf2AtPtx5055R2763)); // PTX L6027
L__BB18_228:												  // PTX L6029
	return;													  // PTX L6030
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16
