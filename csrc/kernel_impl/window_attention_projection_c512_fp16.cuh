// Readable reconstruction of cc_split_swin_16h_proj_512; not historical source.
#pragma once
#include "window_attention_projection_c512_abi_fp16.cuh"

namespace dlssnr::reconstructed::window_attention_projection_c512_fp16
{
__global__ __maxnreg__(168) void window_attention_projection_c512_fp16(Parameters r_Parameters)
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
	bool r_bPtxPredicate49, r_bPtxPredicate50;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint32_t r_HeightBits, r_WidthBits, r_CtaY, r_CtaZ, r_PtxRegister5, r_PtxRegister6, r_PtxRegister7,
		r_HeightDiv4Bits, r_WidthDiv4Bits, r_ThreadY, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_CtaX, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4, r_WidthSignBits,
		r_WidthDiv4Bias, r_WidthBiasedForDiv4;
	uint32_t r_ThreadX, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53, r_PtxRegister54,
		r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx63R57, r_LaneIndexAtPtx80, r_LaneIndexAtPtx90,
		r_LaneIndexAtPtx101;
	uint32_t r_LaneIndexAtPtx112, r_LaneIndexAtPtx121, r_LaneIndexAtPtx130, r_LaneIndexAtPtx139,
		r_LaneIndexAtPtx148, r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69,
		r_PtxRegister70, r_PtxRegister71, r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_LaneIndexAtPtx229,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_LaneIndexAtPtx288, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_LaneIndexAtPtx348,
		r_PtxRegister119, r_PackedHalf2AtPtx65R120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_LaneIndexAtPtx400, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_LaneIndexAtPtx419, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_LaneIndexAtPtx438,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_LaneIndexAtPtx457, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_LaneIndexAtPtx482, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_LaneIndexAtPtx501,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_LaneIndexAtPtx520, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_LaneIndexAtPtx539, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_LaneIndexAtPtx550,
		r_LaneIndexAtPtx564, r_LaneIndexAtPtx578;
	uint32_t r_LaneIndexAtPtx592, r_LaneIndexAtPtx606, r_LaneIndexAtPtx620, r_LaneIndexAtPtx634,
		r_LaneIndexAtPtx651, r_LaneIndexAtPtx667, r_LaneIndexAtPtx681, r_LaneIndexAtPtx695,
		r_LaneIndexAtPtx712, r_LaneIndexAtPtx728, r_LaneIndexAtPtx742, r_LaneIndexAtPtx756;
	uint32_t r_LaneIndexAtPtx773, r_LaneIndexAtPtx789, r_LaneIndexAtPtx803, r_LaneIndexAtPtx817,
		r_LaneIndexAtPtx831, r_LaneIndexAtPtx845, r_LaneIndexAtPtx859, r_LaneIndexAtPtx873,
		r_LaneIndexAtPtx889, r_LaneIndexAtPtx905, r_LaneIndexAtPtx919, r_LaneIndexAtPtx933;
	uint32_t r_LaneIndexAtPtx949, r_LaneIndexAtPtx965, r_LaneIndexAtPtx979, r_LaneIndexAtPtx993,
		r_LaneIndexAtPtx1009, r_LaneIndexAtPtx1025, r_PtxRegister199, r_LaneIndexAtPtx1032, r_PtxRegister201,
		r_LaneIndexAtPtx1039, r_PtxRegister203, r_LaneIndexAtPtx1046;
	uint32_t r_PtxRegister205, r_LaneIndexAtPtx1053, r_PtxRegister207, r_LaneIndexAtPtx1060, r_PtxRegister209,
		r_LaneIndexAtPtx1067, r_PtxRegister211, r_LaneIndexAtPtx1074, r_PtxRegister213, r_LaneIndexAtPtx1081,
		r_PtxRegister215, r_LaneIndexAtPtx1088;
	uint32_t r_PtxRegister217, r_LaneIndexAtPtx1095, r_PtxRegister219, r_LaneIndexAtPtx1102, r_PtxRegister221,
		r_LaneIndexAtPtx1109, r_PtxRegister223, r_LaneIndexAtPtx1116, r_PtxRegister225, r_LaneIndexAtPtx1123,
		r_PtxRegister227, r_LaneIndexAtPtx1130;
	uint32_t r_PtxRegister229, r_LaneIndexAtPtx1137, r_PtxRegister231, r_LaneIndexAtPtx1144, r_PtxRegister233,
		r_LaneIndexAtPtx1151, r_PtxRegister235, r_LaneIndexAtPtx1158, r_PtxRegister237, r_LaneIndexAtPtx1165,
		r_PtxRegister239, r_LaneIndexAtPtx1172;
	uint32_t r_PtxRegister241, r_LaneIndexAtPtx1179, r_PtxRegister243, r_LaneIndexAtPtx1186, r_PtxRegister245,
		r_LaneIndexAtPtx1193, r_PtxRegister247, r_LaneIndexAtPtx1200, r_PtxRegister249, r_LaneIndexAtPtx1207,
		r_PtxRegister251, r_LaneIndexAtPtx1214;
	uint32_t r_PtxRegister253, r_LaneIndexAtPtx1221, r_PtxRegister255, r_LaneIndexAtPtx1228, r_PtxRegister257,
		r_LaneIndexAtPtx1235, r_PtxRegister259, r_LaneIndexAtPtx1242, r_PtxRegister261, r_PtxRegister262,
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
		r_PtxRegister330, r_PtxRegister331, r_PtxRegister332, r_PtxRegister333, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_PtxRegister337, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341,
		r_PtxRegister342, r_PtxRegister343, r_PtxRegister344, r_PtxRegister345, r_PtxRegister346,
		r_PtxRegister347, r_PtxRegister348;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_PtxRegister353,
		r_PtxRegister354, r_PtxRegister355, r_PtxRegister356, r_PtxRegister357, r_PtxRegister358,
		r_PtxRegister359, r_PtxRegister360;
	uint32_t r_PtxRegister361, r_PtxRegister362, r_PtxRegister363, r_PtxRegister364, r_PtxRegister365,
		r_PtxRegister366, r_PtxRegister367, r_PtxRegister368, r_PtxRegister369, r_PtxRegister370,
		r_PtxRegister371, r_PtxRegister372;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_PtxRegister375, r_PtxRegister376, r_PtxRegister377,
		r_PtxRegister378, r_PtxRegister379, r_PtxRegister380, r_PtxRegister381, r_PtxRegister382,
		r_PtxRegister383, r_PtxRegister384;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_PtxRegister387, r_PtxRegister388, r_PtxRegister389,
		r_PtxRegister390, r_PtxRegister391, r_PtxRegister392, r_PtxRegister393, r_PtxRegister394,
		r_PtxRegister395, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_PtxRegister398, r_PtxRegister399, r_PtxRegister400, r_PtxRegister401,
		r_PtxRegister402, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405, r_PtxRegister406,
		r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_PtxRegister410, r_PtxRegister411, r_PtxRegister412, r_PtxRegister413,
		r_PtxRegister414, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417, r_PtxRegister418,
		r_PtxRegister419, r_PtxRegister420;
	uint32_t r_PtxRegister421, r_PtxRegister422, r_PtxRegister423, r_PtxRegister424, r_PtxRegister425,
		r_PtxRegister426, r_PtxRegister427, r_PtxRegister428, r_PtxRegister429, r_PtxRegister430,
		r_PtxRegister431, r_PtxRegister432;
	uint32_t r_PtxRegister433, r_PtxRegister434, r_PtxRegister435, r_PtxRegister436, r_PtxRegister437,
		r_PtxRegister438, r_PtxRegister439, r_PtxRegister440, r_PtxRegister441, r_PtxRegister442,
		r_PtxRegister443, r_PtxRegister444;
	uint32_t r_PtxRegister445, r_PtxRegister446, r_PtxRegister447, r_PtxRegister448, r_PtxRegister449,
		r_PtxRegister450, r_PtxRegister451, r_PtxRegister452, r_PtxRegister453, r_PtxRegister454,
		r_PtxRegister455, r_PtxRegister456;
	uint32_t r_PtxRegister457, r_PtxRegister458, r_PtxRegister459, r_PtxRegister460, r_PtxRegister461,
		r_PtxRegister462, r_PtxRegister463, r_PtxRegister464, r_PtxRegister465, r_PtxRegister466,
		r_PtxRegister467, r_PtxRegister468;
	uint32_t r_PtxRegister469, r_PtxRegister470, r_PtxRegister471, r_PtxRegister472, r_PtxRegister473,
		r_PtxRegister474, r_PtxRegister475, r_PtxRegister476, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_PtxRegister481, r_PtxRegister482, r_PtxRegister483, r_PtxRegister484, r_PtxRegister485,
		r_PtxRegister486, r_PtxRegister487, r_PtxRegister488, r_PtxRegister489, r_PtxRegister490,
		r_PtxRegister491, r_PtxRegister492;
	uint32_t r_PtxRegister493, r_PtxRegister494, r_PtxRegister495, r_PtxRegister496, r_PtxRegister497,
		r_PtxRegister498, r_PtxRegister499, r_PtxRegister500, r_PtxRegister501, r_PtxRegister502,
		r_PtxRegister503, r_PtxRegister504;
	uint32_t r_PtxRegister505, r_PtxRegister506, r_PtxRegister507, r_PtxRegister508, r_PtxRegister509,
		r_PtxRegister510, r_PtxRegister511, r_PtxRegister512, r_PtxRegister513, r_PtxRegister514,
		r_PtxRegister515, r_PtxRegister516;
	uint32_t r_PtxRegister517, r_PtxRegister518, r_PtxRegister519, r_PtxRegister520, r_PtxRegister521,
		r_PtxRegister522, r_PtxRegister523, r_PtxRegister524, r_PtxRegister525, r_PtxRegister526,
		r_PtxRegister527, r_PtxRegister528;
	uint32_t r_PtxRegister529, r_PtxRegister530, r_PtxRegister531, r_PtxRegister532, r_PtxRegister533,
		r_PtxRegister534, r_PtxRegister535, r_PtxRegister536, r_PtxRegister537, r_PtxRegister538,
		r_PtxRegister539, r_PtxRegister540;
	uint32_t r_PtxRegister541, r_PtxRegister542, r_PtxRegister543, r_PtxRegister544, r_PtxRegister545,
		r_LaneIndexAtPtx1263, r_PtxRegister547, r_LaneIndexAtPtx1274, r_PtxRegister549, r_LaneIndexAtPtx1283,
		r_PtxRegister551, r_LaneIndexAtPtx1292;
	uint32_t r_PtxRegister553, r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555,
		r_MmaAHalf2WordAtPtx1271R556, r_MmaAHalf2WordAtPtx1271R557, r_MmaAHalf2WordAtPtx1280R558,
		r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
		r_MmaAccumulatorHalf2WordAtPtx1301R562, r_MmaAccumulatorHalf2WordAtPtx1301R563,
		r_MmaAccumulatorHalf2WordAtPtx1308R564;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1308R565, r_MmaAccumulatorHalf2WordAtPtx1329R566,
		r_MmaAccumulatorHalf2WordAtPtx1329R567, r_MmaAccumulatorHalf2WordAtPtx1336R568,
		r_MmaAccumulatorHalf2WordAtPtx1336R569, r_MmaAccumulatorHalf2WordAtPtx1357R570,
		r_MmaAccumulatorHalf2WordAtPtx1357R571, r_MmaAccumulatorHalf2WordAtPtx1364R572,
		r_MmaAccumulatorHalf2WordAtPtx1364R573, r_MmaAccumulatorHalf2WordAtPtx1385R574,
		r_MmaAccumulatorHalf2WordAtPtx1385R575, r_MmaAccumulatorHalf2WordAtPtx1392R576;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1392R577, r_MmaAHalf2WordAtPtx1289R578,
		r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580, r_MmaAHalf2WordAtPtx1289R581,
		r_MmaAHalf2WordAtPtx1298R582, r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584,
		r_MmaAHalf2WordAtPtx1298R585, r_MmaAccumulatorHalf2WordAtPtx1413R586,
		r_MmaAccumulatorHalf2WordAtPtx1413R587, r_MmaAccumulatorHalf2WordAtPtx1420R588;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1420R589, r_MmaAccumulatorHalf2WordAtPtx1441R590,
		r_MmaAccumulatorHalf2WordAtPtx1441R591, r_MmaAccumulatorHalf2WordAtPtx1448R592,
		r_MmaAccumulatorHalf2WordAtPtx1448R593, r_MmaAccumulatorHalf2WordAtPtx1469R594,
		r_MmaAccumulatorHalf2WordAtPtx1469R595, r_MmaAccumulatorHalf2WordAtPtx1476R596,
		r_MmaAccumulatorHalf2WordAtPtx1476R597, r_MmaAccumulatorHalf2WordAtPtx1497R598,
		r_MmaAccumulatorHalf2WordAtPtx1497R599, r_MmaAccumulatorHalf2WordAtPtx1504R600;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1504R601, r_PtxRegister602, r_PtxRegister603, r_PtxRegister604,
		r_PtxRegister605, r_PtxRegister606, r_PtxRegister607, r_PtxRegister608, r_PtxRegister609,
		r_PtxRegister610, r_PtxRegister611, r_PtxRegister612;
	uint32_t r_PtxRegister613, r_LaneIndexAtPtx1533, r_LaneIndexAtPtx1541, r_LaneIndexAtPtx1550,
		r_LaneIndexAtPtx1559, r_LaneIndexAtPtx1568, r_LaneIndexAtPtx1577, r_LaneIndexAtPtx1586,
		r_LaneIndexAtPtx1595, r_PtxRegister622, r_PtxRegister623, r_PtxRegister624;
	uint32_t r_PtxRegister625, r_PtxRegister626, r_PtxRegister627, r_PtxRegister628, r_PtxRegister629,
		r_PtxRegister630, r_PtxRegister631, r_PtxRegister632, r_PtxRegister633, r_PtxRegister634,
		r_PtxRegister635, r_PtxRegister636;
	uint32_t r_PtxRegister637, r_LaneIndexAtPtx1675, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_PtxRegister646,
		r_PtxRegister647, r_PtxRegister648;
	uint32_t r_PtxRegister649, r_PtxRegister650, r_PtxRegister651, r_LaneIndexAtPtx1697, r_LaneIndexAtPtx1705,
		r_LaneIndexAtPtx1714, r_LaneIndexAtPtx1723, r_LaneIndexAtPtx1736, r_LaneIndexAtPtx1745,
		r_LaneIndexAtPtx1754, r_LaneIndexAtPtx1763, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_PtxRegister662, r_PackedHalf2AtPtx389R663, r_PackedHalf2AtPtx390R664,
		r_PackedHalf2AtPtx391R665, r_PackedHalf2AtPtx392R666, r_PackedHalf2AtPtx408R667,
		r_PackedHalf2AtPtx409R668, r_PackedHalf2AtPtx410R669, r_PackedHalf2AtPtx411R670,
		r_PackedHalf2AtPtx427R671, r_PackedHalf2AtPtx428R672;
	uint32_t r_PackedHalf2AtPtx429R673, r_PackedHalf2AtPtx430R674, r_PackedHalf2AtPtx446R675,
		r_PackedHalf2AtPtx447R676, r_PackedHalf2AtPtx448R677, r_PackedHalf2AtPtx449R678,
		r_PackedHalf2AtPtx471R679, r_PackedHalf2AtPtx472R680, r_PackedHalf2AtPtx473R681,
		r_PackedHalf2AtPtx474R682, r_PackedHalf2AtPtx490R683, r_PackedHalf2AtPtx491R684;
	uint32_t r_PackedHalf2AtPtx492R685, r_PackedHalf2AtPtx493R686, r_PackedHalf2AtPtx509R687,
		r_PackedHalf2AtPtx510R688, r_PackedHalf2AtPtx511R689, r_PackedHalf2AtPtx512R690,
		r_PackedHalf2AtPtx528R691, r_PackedHalf2AtPtx529R692, r_PackedHalf2AtPtx530R693,
		r_PackedHalf2AtPtx531R694, r_PackedHalf2AtPtx1231R695, r_PackedHalf2AtPtx1224R696;
	uint32_t r_PackedHalf2AtPtx1217R697, r_PackedHalf2AtPtx1210R698, r_PackedHalf2AtPtx1203R699,
		r_PackedHalf2AtPtx1196R700, r_PackedHalf2AtPtx1189R701, r_PackedHalf2AtPtx1182R702,
		r_PackedHalf2AtPtx1175R703, r_PackedHalf2AtPtx1168R704, r_PackedHalf2AtPtx1161R705,
		r_PackedHalf2AtPtx1154R706, r_PackedHalf2AtPtx1147R707, r_PackedHalf2AtPtx1140R708;
	uint32_t r_PackedHalf2AtPtx1133R709, r_PackedHalf2AtPtx1126R710, r_PackedHalf2AtPtx1119R711,
		r_PackedHalf2AtPtx1112R712, r_PackedHalf2AtPtx1105R713, r_PackedHalf2AtPtx1098R714,
		r_PackedHalf2AtPtx1091R715, r_PackedHalf2AtPtx1084R716, r_PackedHalf2AtPtx1077R717,
		r_PackedHalf2AtPtx1070R718, r_PackedHalf2AtPtx1063R719, r_PackedHalf2AtPtx1056R720;
	uint32_t r_PackedHalf2AtPtx1049R721, r_PackedHalf2AtPtx1042R722, r_PackedHalf2AtPtx1035R723,
		r_PackedHalf2AtPtx1028R724, r_PackedHalf2AtPtx1238R725, r_PackedHalf2AtPtx1245R726, r_PtxRegister727,
		r_MmaBHalf2WordAtPtx154R728, r_MmaBHalf2WordAtPtx154R729, r_MmaBHalf2WordAtPtx154R730,
		r_MmaBHalf2WordAtPtx145R731, r_MmaBHalf2WordAtPtx145R732;
	uint32_t r_MmaBHalf2WordAtPtx145R733, r_MmaBHalf2WordAtPtx145R734, r_MmaBHalf2WordAtPtx136R735,
		r_MmaBHalf2WordAtPtx136R736, r_MmaBHalf2WordAtPtx136R737, r_MmaBHalf2WordAtPtx136R738,
		r_MmaBHalf2WordAtPtx127R739, r_MmaBHalf2WordAtPtx127R740, r_MmaBHalf2WordAtPtx127R741,
		r_MmaBHalf2WordAtPtx127R742, r_MmaBHalf2WordAtPtx118R743, r_MmaBHalf2WordAtPtx118R744;
	uint32_t r_MmaBHalf2WordAtPtx118R745, r_MmaBHalf2WordAtPtx118R746, r_MmaBHalf2WordAtPtx107R747,
		r_MmaBHalf2WordAtPtx107R748, r_MmaBHalf2WordAtPtx107R749, r_MmaBHalf2WordAtPtx107R750,
		r_MmaBHalf2WordAtPtx96R751, r_MmaBHalf2WordAtPtx96R752, r_MmaBHalf2WordAtPtx96R753,
		r_MmaBHalf2WordAtPtx96R754, r_MmaBHalf2WordAtPtx85R755, r_MmaBHalf2WordAtPtx85R756;
	uint32_t r_MmaBHalf2WordAtPtx85R757, r_MmaBHalf2WordAtPtx85R758, r_MmaBHalf2WordAtPtx154R759;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress,
		g_OutputByteAddressAtPtx1693, g_RecordByteAddressAtPtx83, g_RecordByteAddressAtPtx94,
		g_RecordByteAddressAtPtx105, g_RecordByteAddressAtPtx116, g_RecordByteAddressAtPtx125,
		g_RecordByteAddressAtPtx134, g_RecordByteAddressAtPtx143;
	uint64_t g_RecordByteAddressAtPtx152, r_PtxU64Register14, g_RecordByteAddressAtPtx78, r_PtxU64Register16,
		r_PtxU64Register17, g_RecordByteAddressAtPtx93, r_PtxU64Register19, g_RecordByteAddressAtPtx104,
		r_PtxU64Register21, g_RecordByteAddressAtPtx115, r_PtxU64Register23, g_RecordByteAddressAtPtx124;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx133, r_PtxU64Register27, g_RecordByteAddressAtPtx142,
		r_PtxU64Register29, g_RecordByteAddressAtPtx151, r_PtxU64Register31, r_PtxU64Register32,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, g_ResidualByteAddressAtPtx403, r_PtxU64Register39,
		g_ResidualByteAddressAtPtx398, r_PtxU64Register41, g_ResidualByteAddressAtPtx422, r_PtxU64Register43,
		g_ResidualByteAddressAtPtx417, r_PtxU64Register45, g_ResidualByteAddressAtPtx441, r_PtxU64Register47,
		g_ResidualByteAddressAtPtx436;
	uint64_t r_PtxU64Register49, g_ResidualByteAddressAtPtx460, r_PtxU64Register51,
		g_ResidualByteAddressAtPtx455, r_PtxU64Register53, g_ResidualByteAddressAtPtx485, r_PtxU64Register55,
		g_ResidualByteAddressAtPtx480, r_PtxU64Register57, g_ResidualByteAddressAtPtx504, r_PtxU64Register59,
		g_ResidualByteAddressAtPtx499;
	uint64_t r_PtxU64Register61, g_ResidualByteAddressAtPtx523, r_PtxU64Register63,
		g_ResidualByteAddressAtPtx518, r_PtxU64Register65, g_ResidualByteAddressAtPtx542, r_PtxU64Register67,
		g_ResidualByteAddressAtPtx537, r_PtxU64Register69, g_RecordByteAddressAtPtx548, r_PtxU64Register71,
		g_RecordByteAddressAtPtx561;
	uint64_t r_PtxU64Register73, g_RecordByteAddressAtPtx575, r_PtxU64Register75, g_RecordByteAddressAtPtx589,
		r_PtxU64Register77, g_RecordByteAddressAtPtx603, r_PtxU64Register79, g_RecordByteAddressAtPtx617,
		r_PtxU64Register81, g_RecordByteAddressAtPtx631, r_PtxU64Register83, g_RecordByteAddressAtPtx648;
	uint64_t r_PtxU64Register85, g_RecordByteAddressAtPtx664, r_PtxU64Register87, g_RecordByteAddressAtPtx678,
		r_PtxU64Register89, g_RecordByteAddressAtPtx692, r_PtxU64Register91, g_RecordByteAddressAtPtx709,
		r_PtxU64Register93, g_RecordByteAddressAtPtx725, r_PtxU64Register95, g_RecordByteAddressAtPtx739;
	uint64_t r_PtxU64Register97, g_RecordByteAddressAtPtx753, r_PtxU64Register99, g_RecordByteAddressAtPtx770,
		r_PtxU64Register101, g_RecordByteAddressAtPtx786, r_PtxU64Register103, g_RecordByteAddressAtPtx800,
		r_PtxU64Register105, g_RecordByteAddressAtPtx814, r_PtxU64Register107, g_RecordByteAddressAtPtx828;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx842, r_PtxU64Register111,
		g_RecordByteAddressAtPtx856, r_PtxU64Register113, g_RecordByteAddressAtPtx870, r_PtxU64Register115,
		g_RecordByteAddressAtPtx886, r_PtxU64Register117, g_RecordByteAddressAtPtx902, r_PtxU64Register119,
		g_RecordByteAddressAtPtx916;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx930, r_PtxU64Register123,
		g_RecordByteAddressAtPtx946, r_PtxU64Register125, g_RecordByteAddressAtPtx962, r_PtxU64Register127,
		g_RecordByteAddressAtPtx976, r_PtxU64Register129, g_RecordByteAddressAtPtx990, r_PtxU64Register131,
		g_RecordByteAddressAtPtx1006;
	uint64_t r_PtxU64Register133, g_RecordByteAddressAtPtx1022, g_RecordByteAddressAtPtx1536,
		g_RecordByteAddressAtPtx1545, g_RecordByteAddressAtPtx1554, g_RecordByteAddressAtPtx1563,
		g_RecordByteAddressAtPtx1572, g_RecordByteAddressAtPtx1581, g_RecordByteAddressAtPtx1590,
		g_RecordByteAddressAtPtx1599, r_PtxU64Register143, g_RecordByteAddressAtPtx1531;
	uint64_t r_PtxU64Register145, r_PtxU64Register146, g_RecordByteAddressAtPtx1544, r_PtxU64Register148,
		g_RecordByteAddressAtPtx1553, r_PtxU64Register150, g_RecordByteAddressAtPtx1562, r_PtxU64Register152,
		g_RecordByteAddressAtPtx1571, r_PtxU64Register154, g_RecordByteAddressAtPtx1580, r_PtxU64Register156;
	uint64_t g_RecordByteAddressAtPtx1589, r_PtxU64Register158, g_RecordByteAddressAtPtx1598,
		r_PtxU64Register160, r_PtxU64Register161, r_PtxU64Register162, r_PtxU64Register163,
		g_OutputByteAddressAtPtx1700, g_OutputByteAddressAtPtx1709, g_OutputByteAddressAtPtx1718,
		g_OutputByteAddressAtPtx1727, r_PtxU64Register168;
	uint64_t r_PtxU64Register169, g_OutputByteAddressAtPtx1708, r_PtxU64Register171,
		g_OutputByteAddressAtPtx1717, r_PtxU64Register173, g_OutputByteAddressAtPtx1726,
		g_OutputByteAddressAtPtx1740, g_OutputByteAddressAtPtx1749, g_OutputByteAddressAtPtx1758,
		g_OutputByteAddressAtPtx1767, r_PtxU64Register179, g_OutputByteAddressAtPtx1739;
	uint64_t r_PtxU64Register181, g_OutputByteAddressAtPtx1748, r_PtxU64Register183,
		g_OutputByteAddressAtPtx1757, r_PtxU64Register185, g_OutputByteAddressAtPtx1766, r_PtxU64Register187,
		r_PtxU64Register188, r_PtxU64Register189, r_PtxU64Register190, r_PtxU64Register191,
		r_PtxU64Register192;
	uint64_t r_PtxU64Register193, r_PtxU64Register194;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L14
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip); // PTX L15
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L16
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L17
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);									// PTX L18
	r_CtaX = uint32_t(blockIdx.x);												// PTX L19
	r_CtaY = uint32_t(blockIdx.y);												// PTX L20
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L21
	r_PtxRegister35 = uint32_t(r_WidthBits) + uint32_t(-1);						// PTX L22
	r_PtxRegister36 = ShiftRightSigned(int32_t(r_PtxRegister35), uint32_t(31)); // PTX L23
	r_PtxRegister37 = ShiftRight(uint32_t(r_PtxRegister36), uint32_t(29));		// PTX L24
	r_PtxRegister38 = uint32_t(r_PtxRegister35) + uint32_t(r_PtxRegister37);	// PTX L25
	r_PtxRegister39 = ShiftRightSigned(int32_t(r_PtxRegister38), uint32_t(3));	// PTX L26
	r_PtxRegister40 = uint32_t(r_PtxRegister39) + uint32_t(1);					// PTX L27
	r_PtxRegister5 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister40));		// PTX L28
	r_PtxRegister41 =
		uint32_t(r_PtxRegister5) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister5); // PTX L29
	r_PtxRegister42 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister41);						 // PTX L30
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(1));					 // PTX L31
	r_PtxRegister7 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));							 // PTX L32
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));			 // PTX L33
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));			 // PTX L34
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);		 // PTX L35
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2));	 // PTX L36
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));				 // PTX L37
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));				 // PTX L38
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);			 // PTX L39
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));		 // PTX L40
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L41
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L42
	r_PtxRegister50 = r_ThreadX | r_ThreadY;											 // PTX L43
	r_bPtxPredicate8 = uint32_t(r_PtxRegister50) != uint32_t(0);						 // PTX L44
	if (r_bPtxPredicate8)
	{
		goto L__BB26_2;
	} // PTX L45
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L46
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L47
	r_PtxRegister52 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L48
	r_PtxRegister51 = uint32_t(12288u /* exact native shared-region offset */); // PTX L49
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister51, r_PtxRegister52); // PTX L51
	r_PtxRegister53 = uint32_t(r_PtxRegister51) + uint32_t(8);		// PTX L53
	BarrierInit(s_SharedStorage, r_PtxRegister53, r_PtxRegister52); // PTX L55
	r_PtxRegister54 = uint32_t(r_PtxRegister51) + uint32_t(16);		// PTX L57
	BarrierInit(s_SharedStorage, r_PtxRegister54, r_PtxRegister52); // PTX L59
L__BB26_2:															// PTX L61
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L62
	r_Float32BitsAtPtx63R57 = uint32_t(0);														// PTX L63
	r_PackedHalf2AtPtx65R120 = FloatToHalf2(r_Float32BitsAtPtx63R57);							// PTX L65
	r_PtxRegister66 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L70
	r_PtxRegister67 = r_PtxRegister66 & 192;													// PTX L71
	r_PtxRegister68 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(8));							// PTX L72
	r_PtxRegister11 = r_PtxRegister67 | r_PtxRegister68;										// PTX L73
	r_PtxRegister69 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(17));								// PTX L74
	r_PtxRegister12 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(3));						// PTX L75
	r_PtxRegister70 = uint32_t(r_PtxRegister69) + uint32_t(r_PtxRegister12);					// PTX L76
	r_PtxU64Register14 = uint64_t(int64_t(int32_t(r_PtxRegister70)) * int64_t(int32_t(4)));		// PTX L77
	g_RecordByteAddressAtPtx78 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register14);	// PTX L78
	r_LaneIndexAtPtx80 = uint32_t((threadIdx.x & 31u));											// PTX L80
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx80)) * int64_t(int32_t(16))); // PTX L82
	g_RecordByteAddressAtPtx83 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register16); // PTX L83
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx83));
		r_MmaBHalf2WordAtPtx85R758 = r_Value.x;
		r_MmaBHalf2WordAtPtx85R757 = r_Value.y;
		r_MmaBHalf2WordAtPtx85R756 = r_Value.z;
		r_MmaBHalf2WordAtPtx85R755 = r_Value.w;
	} // PTX L85
	r_PtxRegister13 = r_PtxRegister11 | 16;														// PTX L87
	r_PtxRegister14 = r_PtxRegister12 | 128;													// PTX L88
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register17);		   // PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(512); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBHalf2WordAtPtx96R754 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R753 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R752 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R751 = r_Value.w;
	} // PTX L96
	r_PtxRegister15 = r_PtxRegister11 | 32;														 // PTX L98
	r_PtxRegister16 = r_PtxRegister12 | 256;													 // PTX L99
	r_LaneIndexAtPtx101 = uint32_t((threadIdx.x & 31u));										 // PTX L101
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx101)) * int64_t(int32_t(16))); // PTX L103
	g_RecordByteAddressAtPtx104 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register19);			  // PTX L104
	g_RecordByteAddressAtPtx105 = uint64_t(g_RecordByteAddressAtPtx104) + uint64_t(1024); // PTX L105
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx105));
		r_MmaBHalf2WordAtPtx107R750 = r_Value.x;
		r_MmaBHalf2WordAtPtx107R749 = r_Value.y;
		r_MmaBHalf2WordAtPtx107R748 = r_Value.z;
		r_MmaBHalf2WordAtPtx107R747 = r_Value.w;
	} // PTX L107
	r_PtxRegister17 = r_PtxRegister11 | 48;														 // PTX L109
	r_PtxRegister18 = r_PtxRegister12 | 384;													 // PTX L110
	r_LaneIndexAtPtx112 = uint32_t((threadIdx.x & 31u));										 // PTX L112
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx112)) * int64_t(int32_t(16))); // PTX L114
	g_RecordByteAddressAtPtx115 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register21);			  // PTX L115
	g_RecordByteAddressAtPtx116 = uint64_t(g_RecordByteAddressAtPtx115) + uint64_t(1536); // PTX L116
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx116));
		r_MmaBHalf2WordAtPtx118R746 = r_Value.x;
		r_MmaBHalf2WordAtPtx118R745 = r_Value.y;
		r_MmaBHalf2WordAtPtx118R744 = r_Value.z;
		r_MmaBHalf2WordAtPtx118R743 = r_Value.w;
	} // PTX L118
	r_LaneIndexAtPtx121 = uint32_t((threadIdx.x & 31u));										 // PTX L121
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx121)) * int64_t(int32_t(16))); // PTX L123
	g_RecordByteAddressAtPtx124 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register23);			   // PTX L124
	g_RecordByteAddressAtPtx125 = uint64_t(g_RecordByteAddressAtPtx124) + uint64_t(16384); // PTX L125
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx125));
		r_MmaBHalf2WordAtPtx127R742 = r_Value.x;
		r_MmaBHalf2WordAtPtx127R741 = r_Value.y;
		r_MmaBHalf2WordAtPtx127R740 = r_Value.z;
		r_MmaBHalf2WordAtPtx127R739 = r_Value.w;
	} // PTX L127
	r_LaneIndexAtPtx130 = uint32_t((threadIdx.x & 31u));										 // PTX L130
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx130)) * int64_t(int32_t(16))); // PTX L132
	g_RecordByteAddressAtPtx133 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register25);			   // PTX L133
	g_RecordByteAddressAtPtx134 = uint64_t(g_RecordByteAddressAtPtx133) + uint64_t(16896); // PTX L134
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx134));
		r_MmaBHalf2WordAtPtx136R738 = r_Value.x;
		r_MmaBHalf2WordAtPtx136R737 = r_Value.y;
		r_MmaBHalf2WordAtPtx136R736 = r_Value.z;
		r_MmaBHalf2WordAtPtx136R735 = r_Value.w;
	} // PTX L136
	r_LaneIndexAtPtx139 = uint32_t((threadIdx.x & 31u));										 // PTX L139
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx139)) * int64_t(int32_t(16))); // PTX L141
	g_RecordByteAddressAtPtx142 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register27);			   // PTX L142
	g_RecordByteAddressAtPtx143 = uint64_t(g_RecordByteAddressAtPtx142) + uint64_t(17408); // PTX L143
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx143));
		r_MmaBHalf2WordAtPtx145R734 = r_Value.x;
		r_MmaBHalf2WordAtPtx145R733 = r_Value.y;
		r_MmaBHalf2WordAtPtx145R732 = r_Value.z;
		r_MmaBHalf2WordAtPtx145R731 = r_Value.w;
	} // PTX L145
	r_LaneIndexAtPtx148 = uint32_t((threadIdx.x & 31u));										 // PTX L148
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx148)) * int64_t(int32_t(16))); // PTX L150
	g_RecordByteAddressAtPtx151 =
		uint64_t(g_RecordByteAddressAtPtx78) + uint64_t(r_PtxU64Register29);			   // PTX L151
	g_RecordByteAddressAtPtx152 = uint64_t(g_RecordByteAddressAtPtx151) + uint64_t(17920); // PTX L152
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx152));
		r_MmaBHalf2WordAtPtx154R730 = r_Value.x;
		r_MmaBHalf2WordAtPtx154R729 = r_Value.y;
		r_MmaBHalf2WordAtPtx154R728 = r_Value.z;
		r_MmaBHalf2WordAtPtx154R759 = r_Value.w;
	} // PTX L154
	r_PtxRegister71 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			  // PTX L156
	r_PtxRegister72 = r_PtxRegister71 & 1;									  // PTX L157
	r_PtxRegister19 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));			  // PTX L158
	r_PtxRegister73 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(4));			  // PTX L159
	r_PtxRegister74 = r_PtxRegister73 & 16;									  // PTX L160
	r_PtxRegister75 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(9));	  // PTX L161
	r_PtxRegister76 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L162
	r_PtxRegister77 = r_PtxRegister76 & 256;								  // PTX L163
	r_PtxRegister78 = r_PtxRegister75 | r_PtxRegister77;					  // PTX L164
	r_PtxRegister79 = r_PtxRegister76 & 128;								  // PTX L165
	r_PtxRegister20 = r_PtxRegister78 | r_PtxRegister79;					  // PTX L166
	r_PtxRegister80 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));				  // PTX L167
	r_PtxRegister81 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister80);  // PTX L168
	r_PtxRegister21 = uint32_t(r_PtxRegister72) + uint32_t(r_PtxRegister6);	  // PTX L169
	r_PtxRegister22 = uint32_t(r_PtxRegister74) + uint32_t(r_PtxRegister7);	  // PTX L170
	r_PtxRegister23 = r_HeightBits & -4;									  // PTX L171
	r_bPtxPredicate9 = uint32_t(r_PtxRegister23) == uint32_t(4);			  // PTX L172
	r_bPtxPredicate10 = int32_t(r_PtxRegister81) < int32_t(r_HeightDiv4Bits); // PTX L173
	r_PtxRegister24 = uint32_t(r_PtxRegister81) * uint32_t(r_WidthDiv4Bits);  // PTX L174
	r_PtxRegister25 = r_bPtxPredicate9 ? 0 : r_PtxRegister24;				  // PTX L175
	r_bPtxPredicate1 = r_bPtxPredicate9 | r_bPtxPredicate10;				  // PTX L176
	r_bPtxPredicate48 = bool(0);											  // PTX L177
	r_bPtxPredicate11 = !r_bPtxPredicate1;									  // PTX L178
	r_PtxRegister660 = uint32_t(r_PtxRegister21);							  // PTX L179
	if (r_bPtxPredicate11)
	{
		goto L__BB26_5;
	} // PTX L180
	r_PtxRegister82 = r_WidthBits & -4;							  // PTX L181
	r_bPtxPredicate12 = uint32_t(r_PtxRegister82) == uint32_t(4); // PTX L182
	r_bPtxPredicate48 = bool(-1);								  // PTX L183
	r_PtxRegister660 = uint32_t(0);								  // PTX L184
	if (r_bPtxPredicate12)
	{
		goto L__BB26_5;
	} // PTX L185
	r_bPtxPredicate48 = int32_t(r_PtxRegister21) < int32_t(r_WidthDiv4Bits); // PTX L186
	r_PtxRegister660 = uint32_t(r_PtxRegister21);							 // PTX L187
L__BB26_5:																	 // PTX L188
	r_PtxU64Register187 = uint64_t(0);										 // PTX L189
	r_bPtxPredicate13 = !r_bPtxPredicate48;									 // PTX L190
	if (r_bPtxPredicate13)
	{
		goto L__BB26_7;
	} // PTX L191
	r_PtxRegister83 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister660); // PTX L192
	r_PtxRegister84 = ShiftLeft(uint32_t(r_PtxRegister83), uint32_t(12));	  // PTX L193
	r_PtxRegister85 = ShiftLeft(uint32_t(r_PtxRegister22), uint32_t(3));	  // PTX L194
	r_PtxRegister86 = uint32_t(r_PtxRegister84) + uint32_t(r_PtxRegister85);  // PTX L195
	r_PtxU64Register187 = SignExtendWordBits(r_PtxRegister86);				  // PTX L196
L__BB26_7:																	  // PTX L197
	r_PtxU64Register188 = uint64_t(0);										  // PTX L198
	if (r_bPtxPredicate13)
	{
		goto L__BB26_9;
	} // PTX L199
	r_PtxU64Register31 = ShiftLeft(uint64_t(r_PtxU64Register187), uint32_t(2));		   // PTX L200
	r_PtxU64Register188 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register31); // PTX L201
L__BB26_9:																			   // PTX L202
	r_PtxRegister87 = ShiftLeft(uint32_t(r_PtxRegister20), uint32_t(2));			   // PTX L203
	r_PtxRegister88 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L204
	r_PtxRegister94 = uint32_t(r_PtxRegister88) + uint32_t(r_PtxRegister87);		   // PTX L205
	if (r_bPtxPredicate13)
	{
		goto L__BB26_12;
	} // PTX L206
	r_PtxRegister93 = uint32_t(-1);								  // PTX L207
	r_PtxRegister92 = Elected(r_PtxRegister93);					  // PTX L209
	r_bPtxPredicate14 = uint32_t(r_PtxRegister92) == uint32_t(0); // PTX L215
	if (r_bPtxPredicate14)
	{
		goto L__BB26_13;
	} // PTX L216
	r_PtxU64Register32 = r_PtxU64Register188;									// PTX L217
	r_PtxRegister96 = uint32_t(12288u /* exact native shared-region offset */); // PTX L218
	r_PtxRegister95 = uint32_t(512);											// PTX L219
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister94, r_PtxU64Register32, r_PtxRegister95,
			 r_PtxRegister96);												 // PTX L221
	BarrierExpect(s_SharedStorage, r_PtxRegister96, r_PtxRegister95);		 // PTX L224
	goto L__BB26_13;														 // PTX L226
L__BB26_12:																	 // PTX L227
	r_LaneIndexAtPtx229 = uint32_t((threadIdx.x & 31u));					 // PTX L229
	r_PtxRegister91 = ShiftLeft(uint32_t(r_LaneIndexAtPtx229), uint32_t(4)); // PTX L231
	r_PtxRegister90 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister91); // PTX L232
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister90)) =
		make_uint4(r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120,
				   r_PackedHalf2AtPtx65R120);					// PTX L234
L__BB26_13:														// PTX L236
	r_PtxRegister26 = uint32_t(r_PtxRegister22) + uint32_t(32); // PTX L237
	r_bPtxPredicate49 = bool(0);								// PTX L238
	r_PtxRegister661 = uint32_t(r_PtxRegister21);				// PTX L239
	if (r_bPtxPredicate11)
	{
		goto L__BB26_16;
	} // PTX L240
	r_PtxRegister97 = r_WidthBits & -4;							  // PTX L241
	r_bPtxPredicate15 = uint32_t(r_PtxRegister97) == uint32_t(4); // PTX L242
	r_bPtxPredicate49 = bool(-1);								  // PTX L243
	r_PtxRegister661 = uint32_t(0);								  // PTX L244
	if (r_bPtxPredicate15)
	{
		goto L__BB26_16;
	} // PTX L245
	r_bPtxPredicate49 = int32_t(r_PtxRegister21) < int32_t(r_WidthDiv4Bits); // PTX L246
	r_PtxRegister661 = uint32_t(r_PtxRegister21);							 // PTX L247
L__BB26_16:																	 // PTX L248
	r_PtxU64Register189 = uint64_t(0);										 // PTX L249
	r_bPtxPredicate16 = !r_bPtxPredicate49;									 // PTX L250
	if (r_bPtxPredicate16)
	{
		goto L__BB26_18;
	} // PTX L251
	r_PtxRegister98 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister661);  // PTX L252
	r_PtxRegister99 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(12));	   // PTX L253
	r_PtxRegister100 = ShiftLeft(uint32_t(r_PtxRegister26), uint32_t(3));	   // PTX L254
	r_PtxRegister101 = uint32_t(r_PtxRegister99) + uint32_t(r_PtxRegister100); // PTX L255
	r_PtxU64Register189 = SignExtendWordBits(r_PtxRegister101);				   // PTX L256
L__BB26_18:																	   // PTX L257
	r_PtxU64Register190 = uint64_t(0);										   // PTX L258
	if (r_bPtxPredicate16)
	{
		goto L__BB26_20;
	} // PTX L259
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register189), uint32_t(2));		   // PTX L260
	r_PtxU64Register190 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register33); // PTX L261
L__BB26_20:																			   // PTX L262
	if (r_bPtxPredicate16)
	{
		goto L__BB26_23;
	} // PTX L263
	r_PtxRegister107 = uint32_t(-1);							   // PTX L264
	r_PtxRegister106 = Elected(r_PtxRegister107);				   // PTX L266
	r_bPtxPredicate17 = uint32_t(r_PtxRegister106) == uint32_t(0); // PTX L272
	if (r_bPtxPredicate17)
	{
		goto L__BB26_24;
	} // PTX L273
	r_PtxRegister108 = uint32_t(r_PtxRegister94) + uint32_t(4096);				 // PTX L274
	r_PtxU64Register34 = r_PtxU64Register190;									 // PTX L275
	r_PtxRegister111 = uint32_t(12288u /* exact native shared-region offset */); // PTX L276
	r_PtxRegister110 = uint32_t(r_PtxRegister111) + uint32_t(8);				 // PTX L277
	r_PtxRegister109 = uint32_t(512);											 // PTX L278
	CopyBulk(s_SharedStorage, r_PtxRegister108, r_PtxU64Register34, r_PtxRegister109,
			 r_PtxRegister110);												   // PTX L280
	BarrierExpect(s_SharedStorage, r_PtxRegister110, r_PtxRegister109);		   // PTX L283
	goto L__BB26_24;														   // PTX L285
L__BB26_23:																	   // PTX L286
	r_LaneIndexAtPtx288 = uint32_t((threadIdx.x & 31u));					   // PTX L288
	r_PtxRegister104 = ShiftLeft(uint32_t(r_LaneIndexAtPtx288), uint32_t(4));  // PTX L290
	r_PtxRegister105 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister104); // PTX L291
	r_PtxRegister103 = uint32_t(r_PtxRegister105) + uint32_t(4096);			   // PTX L292
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister103)) =
		make_uint4(r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120,
				   r_PackedHalf2AtPtx65R120);	  // PTX L294
L__BB26_24:										  // PTX L296
	r_bPtxPredicate50 = bool(0);				  // PTX L297
	r_PtxRegister662 = uint32_t(r_PtxRegister21); // PTX L298
	if (r_bPtxPredicate11)
	{
		goto L__BB26_27;
	} // PTX L299
	r_PtxRegister112 = r_WidthBits & -4;						   // PTX L300
	r_bPtxPredicate18 = uint32_t(r_PtxRegister112) == uint32_t(4); // PTX L301
	r_bPtxPredicate50 = bool(-1);								   // PTX L302
	r_PtxRegister662 = uint32_t(0);								   // PTX L303
	if (r_bPtxPredicate18)
	{
		goto L__BB26_27;
	} // PTX L304
	r_bPtxPredicate50 = int32_t(r_PtxRegister21) < int32_t(r_WidthDiv4Bits); // PTX L305
	r_PtxRegister662 = uint32_t(r_PtxRegister21);							 // PTX L306
L__BB26_27:																	 // PTX L307
	r_PtxU64Register191 = uint64_t(0);										 // PTX L308
	r_bPtxPredicate19 = !r_bPtxPredicate50;									 // PTX L309
	if (r_bPtxPredicate19)
	{
		goto L__BB26_29;
	} // PTX L310
	r_PtxRegister113 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister662);	// PTX L311
	r_PtxRegister114 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(12));		// PTX L312
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister22), uint32_t(3));		// PTX L313
	r_PtxRegister116 = uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister114); // PTX L314
	r_PtxRegister117 = uint32_t(r_PtxRegister116) + uint32_t(512);				// PTX L315
	r_PtxU64Register191 = SignExtendWordBits(r_PtxRegister117);					// PTX L316
L__BB26_29:																		// PTX L317
	r_PtxU64Register192 = uint64_t(0);											// PTX L318
	if (r_bPtxPredicate19)
	{
		goto L__BB26_31;
	} // PTX L319
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register191), uint32_t(2));		   // PTX L320
	r_PtxU64Register192 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register35); // PTX L321
L__BB26_31:																			   // PTX L322
	if (r_bPtxPredicate19)
	{
		goto L__BB26_34;
	} // PTX L323
	r_PtxRegister124 = uint32_t(-1);							   // PTX L324
	r_PtxRegister123 = Elected(r_PtxRegister124);				   // PTX L326
	r_bPtxPredicate20 = uint32_t(r_PtxRegister123) == uint32_t(0); // PTX L332
	if (r_bPtxPredicate20)
	{
		goto L__BB26_35;
	} // PTX L333
	r_PtxRegister125 = uint32_t(r_PtxRegister94) + uint32_t(8192);				 // PTX L334
	r_PtxU64Register36 = r_PtxU64Register192;									 // PTX L335
	r_PtxRegister128 = uint32_t(12288u /* exact native shared-region offset */); // PTX L336
	r_PtxRegister127 = uint32_t(r_PtxRegister128) + uint32_t(16);				 // PTX L337
	r_PtxRegister126 = uint32_t(512);											 // PTX L338
	CopyBulk(s_SharedStorage, r_PtxRegister125, r_PtxU64Register36, r_PtxRegister126,
			 r_PtxRegister127);												   // PTX L340
	BarrierExpect(s_SharedStorage, r_PtxRegister127, r_PtxRegister126);		   // PTX L343
	goto L__BB26_35;														   // PTX L345
L__BB26_34:																	   // PTX L346
	r_LaneIndexAtPtx348 = uint32_t((threadIdx.x & 31u));					   // PTX L348
	r_PtxRegister121 = ShiftLeft(uint32_t(r_LaneIndexAtPtx348), uint32_t(4));  // PTX L350
	r_PtxRegister122 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister121); // PTX L351
	r_PtxRegister119 = uint32_t(r_PtxRegister122) + uint32_t(8192);			   // PTX L352
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister119)) =
		make_uint4(r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120,
				   r_PackedHalf2AtPtx65R120);									 // PTX L354
L__BB26_35:																		 // PTX L356
	r_PtxRegister129 = uint32_t(12288u /* exact native shared-region offset */); // PTX L357
	r_PtxRegister130 = uint32_t(1);												 // PTX L358
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register37 = BarrierArrive(s_SharedStorage, r_PtxRegister129, r_PtxRegister130); // PTX L360
L__BB26_36:																					 // PTX L362
	r_PtxRegister132 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L363
	r_PtxRegister131 = BarrierReady(s_SharedStorage, r_PtxRegister132, r_PtxU64Register37);	 // PTX L365
	r_bPtxPredicate21 = uint32_t(r_PtxRegister131) == uint32_t(0);							 // PTX L371
	if (r_bPtxPredicate21)
	{
		goto L__BB26_36;
	} // PTX L372
	r_bPtxPredicate22 = uint32_t(r_PtxRegister23) == uint32_t(4);			   // PTX L373
	r_bPtxPredicate23 = uint32_t(r_PtxRegister23) != uint32_t(4);			   // PTX L374
	r_PtxRegister133 = r_WidthBits & -4;									   // PTX L375
	r_bPtxPredicate24 = uint32_t(r_PtxRegister133) == uint32_t(4);			   // PTX L376
	r_bPtxPredicate25 = int32_t(r_PtxRegister81) < int32_t(r_HeightDiv4Bits);  // PTX L377
	r_bPtxPredicate26 = int32_t(r_PtxRegister81) >= int32_t(r_HeightDiv4Bits); // PTX L378
	r_bPtxPredicate27 = r_bPtxPredicate23 & r_bPtxPredicate26;				   // PTX L379
	r_bPtxPredicate2 = r_bPtxPredicate22 | r_bPtxPredicate25;				   // PTX L380
	r_bPtxPredicate3 = r_bPtxPredicate27 | r_bPtxPredicate24;				   // PTX L381
	r_bPtxPredicate28 = int32_t(r_PtxRegister6) < int32_t(r_WidthDiv4Bits);	   // PTX L382
	r_bPtxPredicate29 = !r_bPtxPredicate27;									   // PTX L383
	r_bPtxPredicate4 = r_bPtxPredicate24 & r_bPtxPredicate29;				   // PTX L384
	r_PtxRegister27 = r_bPtxPredicate4 ? 0 : r_PtxRegister6;				   // PTX L385
	r_bPtxPredicate30 = r_bPtxPredicate3 | r_bPtxPredicate28;				   // PTX L386
	r_bPtxPredicate5 = r_bPtxPredicate30 & r_bPtxPredicate2;				   // PTX L387
	r_bPtxPredicate31 = !r_bPtxPredicate5;									   // PTX L388
	r_PackedHalf2AtPtx389R663 = uint32_t(r_PackedHalf2AtPtx65R120);			   // PTX L389
	r_PackedHalf2AtPtx390R664 = uint32_t(r_PackedHalf2AtPtx65R120);			   // PTX L390
	r_PackedHalf2AtPtx391R665 = uint32_t(r_PackedHalf2AtPtx65R120);			   // PTX L391
	r_PackedHalf2AtPtx392R666 = uint32_t(r_PackedHalf2AtPtx65R120);			   // PTX L392
	if (r_bPtxPredicate31)
	{
		goto L__BB26_39;
	} // PTX L393
	r_PtxRegister135 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister27);				 // PTX L394
	r_PtxRegister136 = ShiftLeft(uint32_t(r_PtxRegister135), uint32_t(12));					 // PTX L395
	r_PtxRegister137 = uint32_t(r_PtxRegister136) + uint32_t(r_PtxRegister12);				 // PTX L396
	r_PtxU64Register39 = uint64_t(int64_t(int32_t(r_PtxRegister137)) * int64_t(int32_t(4))); // PTX L397
	g_ResidualByteAddressAtPtx398 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register39);							 // PTX L398
	r_LaneIndexAtPtx400 = uint32_t((threadIdx.x & 31u));										 // PTX L400
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx400)) * int64_t(int32_t(16))); // PTX L402
	g_ResidualByteAddressAtPtx403 =
		uint64_t(g_ResidualByteAddressAtPtx398) + uint64_t(r_PtxU64Register41); // PTX L403
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx403));
		r_PackedHalf2AtPtx389R663 = r_Value.x;
		r_PackedHalf2AtPtx390R664 = r_Value.y;
		r_PackedHalf2AtPtx391R665 = r_Value.z;
		r_PackedHalf2AtPtx392R666 = r_Value.w;
	} // PTX L405
L__BB26_39:															// PTX L407
	r_PackedHalf2AtPtx408R667 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L408
	r_PackedHalf2AtPtx409R668 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L409
	r_PackedHalf2AtPtx410R669 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L410
	r_PackedHalf2AtPtx411R670 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L411
	if (r_bPtxPredicate31)
	{
		goto L__BB26_41;
	} // PTX L412
	r_PtxRegister139 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister27);				 // PTX L413
	r_PtxRegister140 = ShiftLeft(uint32_t(r_PtxRegister139), uint32_t(12));					 // PTX L414
	r_PtxRegister141 = uint32_t(r_PtxRegister140) + uint32_t(r_PtxRegister14);				 // PTX L415
	r_PtxU64Register43 = uint64_t(int64_t(int32_t(r_PtxRegister141)) * int64_t(int32_t(4))); // PTX L416
	g_ResidualByteAddressAtPtx417 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register43);							 // PTX L417
	r_LaneIndexAtPtx419 = uint32_t((threadIdx.x & 31u));										 // PTX L419
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx419)) * int64_t(int32_t(16))); // PTX L421
	g_ResidualByteAddressAtPtx422 =
		uint64_t(g_ResidualByteAddressAtPtx417) + uint64_t(r_PtxU64Register45); // PTX L422
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx422));
		r_PackedHalf2AtPtx408R667 = r_Value.x;
		r_PackedHalf2AtPtx409R668 = r_Value.y;
		r_PackedHalf2AtPtx410R669 = r_Value.z;
		r_PackedHalf2AtPtx411R670 = r_Value.w;
	} // PTX L424
L__BB26_41:															// PTX L426
	r_PackedHalf2AtPtx427R671 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L427
	r_PackedHalf2AtPtx428R672 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L428
	r_PackedHalf2AtPtx429R673 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L429
	r_PackedHalf2AtPtx430R674 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L430
	if (r_bPtxPredicate31)
	{
		goto L__BB26_43;
	} // PTX L431
	r_PtxRegister143 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister27);				 // PTX L432
	r_PtxRegister144 = ShiftLeft(uint32_t(r_PtxRegister143), uint32_t(12));					 // PTX L433
	r_PtxRegister145 = uint32_t(r_PtxRegister144) + uint32_t(r_PtxRegister16);				 // PTX L434
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_PtxRegister145)) * int64_t(int32_t(4))); // PTX L435
	g_ResidualByteAddressAtPtx436 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register47);							 // PTX L436
	r_LaneIndexAtPtx438 = uint32_t((threadIdx.x & 31u));										 // PTX L438
	r_PtxU64Register49 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx438)) * int64_t(int32_t(16))); // PTX L440
	g_ResidualByteAddressAtPtx441 =
		uint64_t(g_ResidualByteAddressAtPtx436) + uint64_t(r_PtxU64Register49); // PTX L441
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx441));
		r_PackedHalf2AtPtx427R671 = r_Value.x;
		r_PackedHalf2AtPtx428R672 = r_Value.y;
		r_PackedHalf2AtPtx429R673 = r_Value.z;
		r_PackedHalf2AtPtx430R674 = r_Value.w;
	} // PTX L443
L__BB26_43:															// PTX L445
	r_PackedHalf2AtPtx446R675 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L446
	r_PackedHalf2AtPtx447R676 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L447
	r_PackedHalf2AtPtx448R677 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L448
	r_PackedHalf2AtPtx449R678 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L449
	if (r_bPtxPredicate31)
	{
		goto L__BB26_45;
	} // PTX L450
	r_PtxRegister147 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister27);				 // PTX L451
	r_PtxRegister148 = ShiftLeft(uint32_t(r_PtxRegister147), uint32_t(12));					 // PTX L452
	r_PtxRegister149 = uint32_t(r_PtxRegister148) + uint32_t(r_PtxRegister18);				 // PTX L453
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_PtxRegister149)) * int64_t(int32_t(4))); // PTX L454
	g_ResidualByteAddressAtPtx455 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register51);							 // PTX L455
	r_LaneIndexAtPtx457 = uint32_t((threadIdx.x & 31u));										 // PTX L457
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx457)) * int64_t(int32_t(16))); // PTX L459
	g_ResidualByteAddressAtPtx460 =
		uint64_t(g_ResidualByteAddressAtPtx455) + uint64_t(r_PtxU64Register53); // PTX L460
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx460));
		r_PackedHalf2AtPtx446R675 = r_Value.x;
		r_PackedHalf2AtPtx447R676 = r_Value.y;
		r_PackedHalf2AtPtx448R677 = r_Value.z;
		r_PackedHalf2AtPtx449R678 = r_Value.w;
	} // PTX L462
L__BB26_45:																	 // PTX L464
	r_PtxRegister28 = uint32_t(r_PtxRegister6) + uint32_t(1);				 // PTX L465
	r_bPtxPredicate32 = int32_t(r_PtxRegister28) < int32_t(r_WidthDiv4Bits); // PTX L466
	r_PtxRegister29 = r_bPtxPredicate4 ? 0 : r_PtxRegister28;				 // PTX L467
	r_bPtxPredicate33 = r_bPtxPredicate3 | r_bPtxPredicate32;				 // PTX L468
	r_bPtxPredicate6 = r_bPtxPredicate33 & r_bPtxPredicate2;				 // PTX L469
	r_bPtxPredicate34 = !r_bPtxPredicate6;									 // PTX L470
	r_PackedHalf2AtPtx471R679 = uint32_t(r_PackedHalf2AtPtx65R120);			 // PTX L471
	r_PackedHalf2AtPtx472R680 = uint32_t(r_PackedHalf2AtPtx65R120);			 // PTX L472
	r_PackedHalf2AtPtx473R681 = uint32_t(r_PackedHalf2AtPtx65R120);			 // PTX L473
	r_PackedHalf2AtPtx474R682 = uint32_t(r_PackedHalf2AtPtx65R120);			 // PTX L474
	if (r_bPtxPredicate34)
	{
		goto L__BB26_47;
	} // PTX L475
	r_PtxRegister151 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister29);				 // PTX L476
	r_PtxRegister152 = ShiftLeft(uint32_t(r_PtxRegister151), uint32_t(12));					 // PTX L477
	r_PtxRegister153 = uint32_t(r_PtxRegister152) + uint32_t(r_PtxRegister12);				 // PTX L478
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_PtxRegister153)) * int64_t(int32_t(4))); // PTX L479
	g_ResidualByteAddressAtPtx480 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register55);							 // PTX L480
	r_LaneIndexAtPtx482 = uint32_t((threadIdx.x & 31u));										 // PTX L482
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx482)) * int64_t(int32_t(16))); // PTX L484
	g_ResidualByteAddressAtPtx485 =
		uint64_t(g_ResidualByteAddressAtPtx480) + uint64_t(r_PtxU64Register57); // PTX L485
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx485));
		r_PackedHalf2AtPtx471R679 = r_Value.x;
		r_PackedHalf2AtPtx472R680 = r_Value.y;
		r_PackedHalf2AtPtx473R681 = r_Value.z;
		r_PackedHalf2AtPtx474R682 = r_Value.w;
	} // PTX L487
L__BB26_47:															// PTX L489
	r_PackedHalf2AtPtx490R683 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L490
	r_PackedHalf2AtPtx491R684 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L491
	r_PackedHalf2AtPtx492R685 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L492
	r_PackedHalf2AtPtx493R686 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L493
	if (r_bPtxPredicate34)
	{
		goto L__BB26_49;
	} // PTX L494
	r_PtxRegister155 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister29);				 // PTX L495
	r_PtxRegister156 = ShiftLeft(uint32_t(r_PtxRegister155), uint32_t(12));					 // PTX L496
	r_PtxRegister157 = uint32_t(r_PtxRegister156) + uint32_t(r_PtxRegister14);				 // PTX L497
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_PtxRegister157)) * int64_t(int32_t(4))); // PTX L498
	g_ResidualByteAddressAtPtx499 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register59);							 // PTX L499
	r_LaneIndexAtPtx501 = uint32_t((threadIdx.x & 31u));										 // PTX L501
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx501)) * int64_t(int32_t(16))); // PTX L503
	g_ResidualByteAddressAtPtx504 =
		uint64_t(g_ResidualByteAddressAtPtx499) + uint64_t(r_PtxU64Register61); // PTX L504
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx504));
		r_PackedHalf2AtPtx490R683 = r_Value.x;
		r_PackedHalf2AtPtx491R684 = r_Value.y;
		r_PackedHalf2AtPtx492R685 = r_Value.z;
		r_PackedHalf2AtPtx493R686 = r_Value.w;
	} // PTX L506
L__BB26_49:															// PTX L508
	r_PackedHalf2AtPtx509R687 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L509
	r_PackedHalf2AtPtx510R688 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L510
	r_PackedHalf2AtPtx511R689 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L511
	r_PackedHalf2AtPtx512R690 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L512
	if (r_bPtxPredicate34)
	{
		goto L__BB26_51;
	} // PTX L513
	r_PtxRegister159 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister29);				 // PTX L514
	r_PtxRegister160 = ShiftLeft(uint32_t(r_PtxRegister159), uint32_t(12));					 // PTX L515
	r_PtxRegister161 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister16);				 // PTX L516
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_PtxRegister161)) * int64_t(int32_t(4))); // PTX L517
	g_ResidualByteAddressAtPtx518 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register63);							 // PTX L518
	r_LaneIndexAtPtx520 = uint32_t((threadIdx.x & 31u));										 // PTX L520
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx520)) * int64_t(int32_t(16))); // PTX L522
	g_ResidualByteAddressAtPtx523 =
		uint64_t(g_ResidualByteAddressAtPtx518) + uint64_t(r_PtxU64Register65); // PTX L523
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx523));
		r_PackedHalf2AtPtx509R687 = r_Value.x;
		r_PackedHalf2AtPtx510R688 = r_Value.y;
		r_PackedHalf2AtPtx511R689 = r_Value.z;
		r_PackedHalf2AtPtx512R690 = r_Value.w;
	} // PTX L525
L__BB26_51:															// PTX L527
	r_PackedHalf2AtPtx528R691 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L528
	r_PackedHalf2AtPtx529R692 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L529
	r_PackedHalf2AtPtx530R693 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L530
	r_PackedHalf2AtPtx531R694 = uint32_t(r_PackedHalf2AtPtx65R120); // PTX L531
	if (r_bPtxPredicate34)
	{
		goto L__BB26_53;
	} // PTX L532
	r_PtxRegister163 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister29);				 // PTX L533
	r_PtxRegister164 = ShiftLeft(uint32_t(r_PtxRegister163), uint32_t(12));					 // PTX L534
	r_PtxRegister165 = uint32_t(r_PtxRegister164) + uint32_t(r_PtxRegister18);				 // PTX L535
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_PtxRegister165)) * int64_t(int32_t(4))); // PTX L536
	g_ResidualByteAddressAtPtx537 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register67);							 // PTX L537
	r_LaneIndexAtPtx539 = uint32_t((threadIdx.x & 31u));										 // PTX L539
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx539)) * int64_t(int32_t(16))); // PTX L541
	g_ResidualByteAddressAtPtx542 =
		uint64_t(g_ResidualByteAddressAtPtx537) + uint64_t(r_PtxU64Register69); // PTX L542
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx542));
		r_PackedHalf2AtPtx528R691 = r_Value.x;
		r_PackedHalf2AtPtx529R692 = r_Value.y;
		r_PackedHalf2AtPtx530R693 = r_Value.z;
		r_PackedHalf2AtPtx531R694 = r_Value.w;
	} // PTX L544
L__BB26_53:																					 // PTX L546
	r_PtxRegister262 = uint32_t(r_PtxRegister11) + uint32_t(8);								 // PTX L547
	g_RecordByteAddressAtPtx548 = g_RecordBaseAddress;										 // PTX L548
	r_LaneIndexAtPtx550 = uint32_t((threadIdx.x & 31u));									 // PTX L550
	r_PtxRegister263 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx550), uint32_t(31));		 // PTX L552
	r_PtxRegister264 = ShiftRight(uint32_t(r_PtxRegister263), uint32_t(30));				 // PTX L553
	r_PtxRegister265 = uint32_t(r_LaneIndexAtPtx550) + uint32_t(r_PtxRegister264);			 // PTX L554
	r_PtxRegister266 = r_PtxRegister265 & 2147483644;										 // PTX L555
	r_PtxRegister267 = uint32_t(r_LaneIndexAtPtx550) - uint32_t(r_PtxRegister266);			 // PTX L556
	r_PtxRegister268 = ShiftLeft(uint32_t(r_PtxRegister267), uint32_t(1));					 // PTX L557
	r_PtxRegister269 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister268);				 // PTX L558
	r_PtxRegister270 = ShiftRightSigned(int32_t(r_PtxRegister269), uint32_t(1));			 // PTX L559
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_PtxRegister270)) * int64_t(int32_t(4))); // PTX L560
	g_RecordByteAddressAtPtx561 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register71); // PTX L561
	r_PtxRegister199 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx561 + 524288ull);		 // PTX L562
	r_LaneIndexAtPtx564 = uint32_t((threadIdx.x & 31u));									 // PTX L564
	r_PtxRegister271 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx564), uint32_t(31));		 // PTX L566
	r_PtxRegister272 = ShiftRight(uint32_t(r_PtxRegister271), uint32_t(30));				 // PTX L567
	r_PtxRegister273 = uint32_t(r_LaneIndexAtPtx564) + uint32_t(r_PtxRegister272);			 // PTX L568
	r_PtxRegister274 = r_PtxRegister273 & 2147483644;										 // PTX L569
	r_PtxRegister275 = uint32_t(r_LaneIndexAtPtx564) - uint32_t(r_PtxRegister274);			 // PTX L570
	r_PtxRegister276 = ShiftLeft(uint32_t(r_PtxRegister275), uint32_t(1));					 // PTX L571
	r_PtxRegister277 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister276);				 // PTX L572
	r_PtxRegister278 = ShiftRightSigned(int32_t(r_PtxRegister277), uint32_t(1));			 // PTX L573
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister278)) * int64_t(int32_t(4))); // PTX L574
	g_RecordByteAddressAtPtx575 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register73); // PTX L575
	r_PtxRegister201 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx575 + 524288ull);		 // PTX L576
	r_LaneIndexAtPtx578 = uint32_t((threadIdx.x & 31u));									 // PTX L578
	r_PtxRegister279 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx578), uint32_t(31));		 // PTX L580
	r_PtxRegister280 = ShiftRight(uint32_t(r_PtxRegister279), uint32_t(30));				 // PTX L581
	r_PtxRegister281 = uint32_t(r_LaneIndexAtPtx578) + uint32_t(r_PtxRegister280);			 // PTX L582
	r_PtxRegister282 = r_PtxRegister281 & 2147483644;										 // PTX L583
	r_PtxRegister283 = uint32_t(r_LaneIndexAtPtx578) - uint32_t(r_PtxRegister282);			 // PTX L584
	r_PtxRegister284 = ShiftLeft(uint32_t(r_PtxRegister283), uint32_t(1));					 // PTX L585
	r_PtxRegister285 = uint32_t(r_PtxRegister262) + uint32_t(r_PtxRegister284);				 // PTX L586
	r_PtxRegister286 = ShiftRightSigned(int32_t(r_PtxRegister285), uint32_t(1));			 // PTX L587
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_PtxRegister286)) * int64_t(int32_t(4))); // PTX L588
	g_RecordByteAddressAtPtx589 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register75); // PTX L589
	r_PtxRegister203 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx589 + 524288ull);		 // PTX L590
	r_LaneIndexAtPtx592 = uint32_t((threadIdx.x & 31u));									 // PTX L592
	r_PtxRegister287 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx592), uint32_t(31));		 // PTX L594
	r_PtxRegister288 = ShiftRight(uint32_t(r_PtxRegister287), uint32_t(30));				 // PTX L595
	r_PtxRegister289 = uint32_t(r_LaneIndexAtPtx592) + uint32_t(r_PtxRegister288);			 // PTX L596
	r_PtxRegister290 = r_PtxRegister289 & 2147483644;										 // PTX L597
	r_PtxRegister291 = uint32_t(r_LaneIndexAtPtx592) - uint32_t(r_PtxRegister290);			 // PTX L598
	r_PtxRegister292 = ShiftLeft(uint32_t(r_PtxRegister291), uint32_t(1));					 // PTX L599
	r_PtxRegister293 = uint32_t(r_PtxRegister262) + uint32_t(r_PtxRegister292);				 // PTX L600
	r_PtxRegister294 = ShiftRightSigned(int32_t(r_PtxRegister293), uint32_t(1));			 // PTX L601
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_PtxRegister294)) * int64_t(int32_t(4))); // PTX L602
	g_RecordByteAddressAtPtx603 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register77); // PTX L603
	r_PtxRegister205 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx603 + 524288ull);		 // PTX L604
	r_LaneIndexAtPtx606 = uint32_t((threadIdx.x & 31u));									 // PTX L606
	r_PtxRegister295 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx606), uint32_t(31));		 // PTX L608
	r_PtxRegister296 = ShiftRight(uint32_t(r_PtxRegister295), uint32_t(30));				 // PTX L609
	r_PtxRegister297 = uint32_t(r_LaneIndexAtPtx606) + uint32_t(r_PtxRegister296);			 // PTX L610
	r_PtxRegister298 = r_PtxRegister297 & 2147483644;										 // PTX L611
	r_PtxRegister299 = uint32_t(r_LaneIndexAtPtx606) - uint32_t(r_PtxRegister298);			 // PTX L612
	r_PtxRegister300 = ShiftLeft(uint32_t(r_PtxRegister299), uint32_t(1));					 // PTX L613
	r_PtxRegister301 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister300);				 // PTX L614
	r_PtxRegister302 = ShiftRightSigned(int32_t(r_PtxRegister301), uint32_t(1));			 // PTX L615
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister302)) * int64_t(int32_t(4))); // PTX L616
	g_RecordByteAddressAtPtx617 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register79); // PTX L617
	r_PtxRegister207 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx617 + 524288ull);		 // PTX L618
	r_LaneIndexAtPtx620 = uint32_t((threadIdx.x & 31u));									 // PTX L620
	r_PtxRegister303 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx620), uint32_t(31));		 // PTX L622
	r_PtxRegister304 = ShiftRight(uint32_t(r_PtxRegister303), uint32_t(30));				 // PTX L623
	r_PtxRegister305 = uint32_t(r_LaneIndexAtPtx620) + uint32_t(r_PtxRegister304);			 // PTX L624
	r_PtxRegister306 = r_PtxRegister305 & 2147483644;										 // PTX L625
	r_PtxRegister307 = uint32_t(r_LaneIndexAtPtx620) - uint32_t(r_PtxRegister306);			 // PTX L626
	r_PtxRegister308 = ShiftLeft(uint32_t(r_PtxRegister307), uint32_t(1));					 // PTX L627
	r_PtxRegister309 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister308);				 // PTX L628
	r_PtxRegister310 = ShiftRightSigned(int32_t(r_PtxRegister309), uint32_t(1));			 // PTX L629
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister310)) * int64_t(int32_t(4))); // PTX L630
	g_RecordByteAddressAtPtx631 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register81); // PTX L631
	r_PtxRegister209 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx631 + 524288ull);		 // PTX L632
	r_LaneIndexAtPtx634 = uint32_t((threadIdx.x & 31u));									 // PTX L634
	r_PtxRegister311 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx634), uint32_t(31));		 // PTX L636
	r_PtxRegister312 = ShiftRight(uint32_t(r_PtxRegister311), uint32_t(30));				 // PTX L637
	r_PtxRegister313 = uint32_t(r_LaneIndexAtPtx634) + uint32_t(r_PtxRegister312);			 // PTX L638
	r_PtxRegister314 = r_PtxRegister313 & 2147483644;										 // PTX L639
	r_PtxRegister315 = uint32_t(r_LaneIndexAtPtx634) - uint32_t(r_PtxRegister314);			 // PTX L640
	r_PtxRegister316 = ShiftLeft(uint32_t(r_PtxRegister315), uint32_t(1));					 // PTX L641
	r_PtxRegister317 = uint32_t(r_PtxRegister11) + uint32_t(24);							 // PTX L642
	r_PtxRegister318 = uint32_t(r_PtxRegister317) + uint32_t(r_PtxRegister316);				 // PTX L643
	r_PtxRegister319 = ShiftRight(uint32_t(r_PtxRegister318), uint32_t(31));				 // PTX L644
	r_PtxRegister320 = uint32_t(r_PtxRegister318) + uint32_t(r_PtxRegister319);				 // PTX L645
	r_PtxRegister321 = ShiftRightSigned(int32_t(r_PtxRegister320), uint32_t(1));			 // PTX L646
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_PtxRegister321)) * int64_t(int32_t(4))); // PTX L647
	g_RecordByteAddressAtPtx648 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register83); // PTX L648
	r_PtxRegister211 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx648 + 524288ull);		 // PTX L649
	r_LaneIndexAtPtx651 = uint32_t((threadIdx.x & 31u));									 // PTX L651
	r_PtxRegister322 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx651), uint32_t(31));		 // PTX L653
	r_PtxRegister323 = ShiftRight(uint32_t(r_PtxRegister322), uint32_t(30));				 // PTX L654
	r_PtxRegister324 = uint32_t(r_LaneIndexAtPtx651) + uint32_t(r_PtxRegister323);			 // PTX L655
	r_PtxRegister325 = r_PtxRegister324 & 2147483644;										 // PTX L656
	r_PtxRegister326 = uint32_t(r_LaneIndexAtPtx651) - uint32_t(r_PtxRegister325);			 // PTX L657
	r_PtxRegister327 = ShiftLeft(uint32_t(r_PtxRegister326), uint32_t(1));					 // PTX L658
	r_PtxRegister328 = uint32_t(r_PtxRegister317) + uint32_t(r_PtxRegister327);				 // PTX L659
	r_PtxRegister329 = ShiftRight(uint32_t(r_PtxRegister328), uint32_t(31));				 // PTX L660
	r_PtxRegister330 = uint32_t(r_PtxRegister328) + uint32_t(r_PtxRegister329);				 // PTX L661
	r_PtxRegister331 = ShiftRightSigned(int32_t(r_PtxRegister330), uint32_t(1));			 // PTX L662
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_PtxRegister331)) * int64_t(int32_t(4))); // PTX L663
	g_RecordByteAddressAtPtx664 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register85); // PTX L664
	r_PtxRegister213 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx664 + 524288ull);		 // PTX L665
	r_LaneIndexAtPtx667 = uint32_t((threadIdx.x & 31u));									 // PTX L667
	r_PtxRegister332 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx667), uint32_t(31));		 // PTX L669
	r_PtxRegister333 = ShiftRight(uint32_t(r_PtxRegister332), uint32_t(30));				 // PTX L670
	r_PtxRegister334 = uint32_t(r_LaneIndexAtPtx667) + uint32_t(r_PtxRegister333);			 // PTX L671
	r_PtxRegister335 = r_PtxRegister334 & 2147483644;										 // PTX L672
	r_PtxRegister336 = uint32_t(r_LaneIndexAtPtx667) - uint32_t(r_PtxRegister335);			 // PTX L673
	r_PtxRegister337 = ShiftLeft(uint32_t(r_PtxRegister336), uint32_t(1));					 // PTX L674
	r_PtxRegister338 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister337);				 // PTX L675
	r_PtxRegister339 = ShiftRightSigned(int32_t(r_PtxRegister338), uint32_t(1));			 // PTX L676
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_PtxRegister339)) * int64_t(int32_t(4))); // PTX L677
	g_RecordByteAddressAtPtx678 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register87); // PTX L678
	r_PtxRegister215 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx678 + 524288ull);		 // PTX L679
	r_LaneIndexAtPtx681 = uint32_t((threadIdx.x & 31u));									 // PTX L681
	r_PtxRegister340 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx681), uint32_t(31));		 // PTX L683
	r_PtxRegister341 = ShiftRight(uint32_t(r_PtxRegister340), uint32_t(30));				 // PTX L684
	r_PtxRegister342 = uint32_t(r_LaneIndexAtPtx681) + uint32_t(r_PtxRegister341);			 // PTX L685
	r_PtxRegister343 = r_PtxRegister342 & 2147483644;										 // PTX L686
	r_PtxRegister344 = uint32_t(r_LaneIndexAtPtx681) - uint32_t(r_PtxRegister343);			 // PTX L687
	r_PtxRegister345 = ShiftLeft(uint32_t(r_PtxRegister344), uint32_t(1));					 // PTX L688
	r_PtxRegister346 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister345);				 // PTX L689
	r_PtxRegister347 = ShiftRightSigned(int32_t(r_PtxRegister346), uint32_t(1));			 // PTX L690
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister347)) * int64_t(int32_t(4))); // PTX L691
	g_RecordByteAddressAtPtx692 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register89); // PTX L692
	r_PtxRegister217 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx692 + 524288ull);		 // PTX L693
	r_LaneIndexAtPtx695 = uint32_t((threadIdx.x & 31u));									 // PTX L695
	r_PtxRegister348 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx695), uint32_t(31));		 // PTX L697
	r_PtxRegister349 = ShiftRight(uint32_t(r_PtxRegister348), uint32_t(30));				 // PTX L698
	r_PtxRegister350 = uint32_t(r_LaneIndexAtPtx695) + uint32_t(r_PtxRegister349);			 // PTX L699
	r_PtxRegister351 = r_PtxRegister350 & 2147483644;										 // PTX L700
	r_PtxRegister352 = uint32_t(r_LaneIndexAtPtx695) - uint32_t(r_PtxRegister351);			 // PTX L701
	r_PtxRegister353 = ShiftLeft(uint32_t(r_PtxRegister352), uint32_t(1));					 // PTX L702
	r_PtxRegister354 = uint32_t(r_PtxRegister11) + uint32_t(40);							 // PTX L703
	r_PtxRegister355 = uint32_t(r_PtxRegister354) + uint32_t(r_PtxRegister353);				 // PTX L704
	r_PtxRegister356 = ShiftRight(uint32_t(r_PtxRegister355), uint32_t(31));				 // PTX L705
	r_PtxRegister357 = uint32_t(r_PtxRegister355) + uint32_t(r_PtxRegister356);				 // PTX L706
	r_PtxRegister358 = ShiftRightSigned(int32_t(r_PtxRegister357), uint32_t(1));			 // PTX L707
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister358)) * int64_t(int32_t(4))); // PTX L708
	g_RecordByteAddressAtPtx709 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register91); // PTX L709
	r_PtxRegister219 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx709 + 524288ull);		 // PTX L710
	r_LaneIndexAtPtx712 = uint32_t((threadIdx.x & 31u));									 // PTX L712
	r_PtxRegister359 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx712), uint32_t(31));		 // PTX L714
	r_PtxRegister360 = ShiftRight(uint32_t(r_PtxRegister359), uint32_t(30));				 // PTX L715
	r_PtxRegister361 = uint32_t(r_LaneIndexAtPtx712) + uint32_t(r_PtxRegister360);			 // PTX L716
	r_PtxRegister362 = r_PtxRegister361 & 2147483644;										 // PTX L717
	r_PtxRegister363 = uint32_t(r_LaneIndexAtPtx712) - uint32_t(r_PtxRegister362);			 // PTX L718
	r_PtxRegister364 = ShiftLeft(uint32_t(r_PtxRegister363), uint32_t(1));					 // PTX L719
	r_PtxRegister365 = uint32_t(r_PtxRegister354) + uint32_t(r_PtxRegister364);				 // PTX L720
	r_PtxRegister366 = ShiftRight(uint32_t(r_PtxRegister365), uint32_t(31));				 // PTX L721
	r_PtxRegister367 = uint32_t(r_PtxRegister365) + uint32_t(r_PtxRegister366);				 // PTX L722
	r_PtxRegister368 = ShiftRightSigned(int32_t(r_PtxRegister367), uint32_t(1));			 // PTX L723
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_PtxRegister368)) * int64_t(int32_t(4))); // PTX L724
	g_RecordByteAddressAtPtx725 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register93); // PTX L725
	r_PtxRegister221 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx725 + 524288ull);		 // PTX L726
	r_LaneIndexAtPtx728 = uint32_t((threadIdx.x & 31u));									 // PTX L728
	r_PtxRegister369 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx728), uint32_t(31));		 // PTX L730
	r_PtxRegister370 = ShiftRight(uint32_t(r_PtxRegister369), uint32_t(30));				 // PTX L731
	r_PtxRegister371 = uint32_t(r_LaneIndexAtPtx728) + uint32_t(r_PtxRegister370);			 // PTX L732
	r_PtxRegister372 = r_PtxRegister371 & 2147483644;										 // PTX L733
	r_PtxRegister373 = uint32_t(r_LaneIndexAtPtx728) - uint32_t(r_PtxRegister372);			 // PTX L734
	r_PtxRegister374 = ShiftLeft(uint32_t(r_PtxRegister373), uint32_t(1));					 // PTX L735
	r_PtxRegister375 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister374);				 // PTX L736
	r_PtxRegister376 = ShiftRightSigned(int32_t(r_PtxRegister375), uint32_t(1));			 // PTX L737
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister376)) * int64_t(int32_t(4))); // PTX L738
	g_RecordByteAddressAtPtx739 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register95); // PTX L739
	r_PtxRegister223 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx739 + 524288ull);		 // PTX L740
	r_LaneIndexAtPtx742 = uint32_t((threadIdx.x & 31u));									 // PTX L742
	r_PtxRegister377 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx742), uint32_t(31));		 // PTX L744
	r_PtxRegister378 = ShiftRight(uint32_t(r_PtxRegister377), uint32_t(30));				 // PTX L745
	r_PtxRegister379 = uint32_t(r_LaneIndexAtPtx742) + uint32_t(r_PtxRegister378);			 // PTX L746
	r_PtxRegister380 = r_PtxRegister379 & 2147483644;										 // PTX L747
	r_PtxRegister381 = uint32_t(r_LaneIndexAtPtx742) - uint32_t(r_PtxRegister380);			 // PTX L748
	r_PtxRegister382 = ShiftLeft(uint32_t(r_PtxRegister381), uint32_t(1));					 // PTX L749
	r_PtxRegister383 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister382);				 // PTX L750
	r_PtxRegister384 = ShiftRightSigned(int32_t(r_PtxRegister383), uint32_t(1));			 // PTX L751
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_PtxRegister384)) * int64_t(int32_t(4))); // PTX L752
	g_RecordByteAddressAtPtx753 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register97); // PTX L753
	r_PtxRegister225 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx753 + 524288ull);		 // PTX L754
	r_LaneIndexAtPtx756 = uint32_t((threadIdx.x & 31u));									 // PTX L756
	r_PtxRegister385 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx756), uint32_t(31));		 // PTX L758
	r_PtxRegister386 = ShiftRight(uint32_t(r_PtxRegister385), uint32_t(30));				 // PTX L759
	r_PtxRegister387 = uint32_t(r_LaneIndexAtPtx756) + uint32_t(r_PtxRegister386);			 // PTX L760
	r_PtxRegister388 = r_PtxRegister387 & 2147483644;										 // PTX L761
	r_PtxRegister389 = uint32_t(r_LaneIndexAtPtx756) - uint32_t(r_PtxRegister388);			 // PTX L762
	r_PtxRegister390 = ShiftLeft(uint32_t(r_PtxRegister389), uint32_t(1));					 // PTX L763
	r_PtxRegister391 = uint32_t(r_PtxRegister11) + uint32_t(56);							 // PTX L764
	r_PtxRegister392 = uint32_t(r_PtxRegister391) + uint32_t(r_PtxRegister390);				 // PTX L765
	r_PtxRegister393 = ShiftRight(uint32_t(r_PtxRegister392), uint32_t(31));				 // PTX L766
	r_PtxRegister394 = uint32_t(r_PtxRegister392) + uint32_t(r_PtxRegister393);				 // PTX L767
	r_PtxRegister395 = ShiftRightSigned(int32_t(r_PtxRegister394), uint32_t(1));			 // PTX L768
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister395)) * int64_t(int32_t(4))); // PTX L769
	g_RecordByteAddressAtPtx770 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register99); // PTX L770
	r_PtxRegister227 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx770 + 524288ull);		  // PTX L771
	r_LaneIndexAtPtx773 = uint32_t((threadIdx.x & 31u));									  // PTX L773
	r_PtxRegister396 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx773), uint32_t(31));		  // PTX L775
	r_PtxRegister397 = ShiftRight(uint32_t(r_PtxRegister396), uint32_t(30));				  // PTX L776
	r_PtxRegister398 = uint32_t(r_LaneIndexAtPtx773) + uint32_t(r_PtxRegister397);			  // PTX L777
	r_PtxRegister399 = r_PtxRegister398 & 2147483644;										  // PTX L778
	r_PtxRegister400 = uint32_t(r_LaneIndexAtPtx773) - uint32_t(r_PtxRegister399);			  // PTX L779
	r_PtxRegister401 = ShiftLeft(uint32_t(r_PtxRegister400), uint32_t(1));					  // PTX L780
	r_PtxRegister402 = uint32_t(r_PtxRegister391) + uint32_t(r_PtxRegister401);				  // PTX L781
	r_PtxRegister403 = ShiftRight(uint32_t(r_PtxRegister402), uint32_t(31));				  // PTX L782
	r_PtxRegister404 = uint32_t(r_PtxRegister402) + uint32_t(r_PtxRegister403);				  // PTX L783
	r_PtxRegister405 = ShiftRightSigned(int32_t(r_PtxRegister404), uint32_t(1));			  // PTX L784
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister405)) * int64_t(int32_t(4))); // PTX L785
	g_RecordByteAddressAtPtx786 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register101); // PTX L786
	r_PtxRegister229 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx786 + 524288ull);		  // PTX L787
	r_LaneIndexAtPtx789 = uint32_t((threadIdx.x & 31u));									  // PTX L789
	r_PtxRegister406 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx789), uint32_t(31));		  // PTX L791
	r_PtxRegister407 = ShiftRight(uint32_t(r_PtxRegister406), uint32_t(30));				  // PTX L792
	r_PtxRegister408 = uint32_t(r_LaneIndexAtPtx789) + uint32_t(r_PtxRegister407);			  // PTX L793
	r_PtxRegister409 = r_PtxRegister408 & 2147483644;										  // PTX L794
	r_PtxRegister410 = uint32_t(r_LaneIndexAtPtx789) - uint32_t(r_PtxRegister409);			  // PTX L795
	r_PtxRegister411 = ShiftLeft(uint32_t(r_PtxRegister410), uint32_t(1));					  // PTX L796
	r_PtxRegister412 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister411);				  // PTX L797
	r_PtxRegister413 = ShiftRightSigned(int32_t(r_PtxRegister412), uint32_t(1));			  // PTX L798
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister413)) * int64_t(int32_t(4))); // PTX L799
	g_RecordByteAddressAtPtx800 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register103); // PTX L800
	r_PtxRegister231 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx800 + 524288ull);		  // PTX L801
	r_LaneIndexAtPtx803 = uint32_t((threadIdx.x & 31u));									  // PTX L803
	r_PtxRegister414 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx803), uint32_t(31));		  // PTX L805
	r_PtxRegister415 = ShiftRight(uint32_t(r_PtxRegister414), uint32_t(30));				  // PTX L806
	r_PtxRegister416 = uint32_t(r_LaneIndexAtPtx803) + uint32_t(r_PtxRegister415);			  // PTX L807
	r_PtxRegister417 = r_PtxRegister416 & 2147483644;										  // PTX L808
	r_PtxRegister418 = uint32_t(r_LaneIndexAtPtx803) - uint32_t(r_PtxRegister417);			  // PTX L809
	r_PtxRegister419 = ShiftLeft(uint32_t(r_PtxRegister418), uint32_t(1));					  // PTX L810
	r_PtxRegister420 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister419);				  // PTX L811
	r_PtxRegister421 = ShiftRightSigned(int32_t(r_PtxRegister420), uint32_t(1));			  // PTX L812
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister421)) * int64_t(int32_t(4))); // PTX L813
	g_RecordByteAddressAtPtx814 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register105); // PTX L814
	r_PtxRegister233 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx814 + 524288ull);		  // PTX L815
	r_LaneIndexAtPtx817 = uint32_t((threadIdx.x & 31u));									  // PTX L817
	r_PtxRegister422 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx817), uint32_t(31));		  // PTX L819
	r_PtxRegister423 = ShiftRight(uint32_t(r_PtxRegister422), uint32_t(30));				  // PTX L820
	r_PtxRegister424 = uint32_t(r_LaneIndexAtPtx817) + uint32_t(r_PtxRegister423);			  // PTX L821
	r_PtxRegister425 = r_PtxRegister424 & 2147483644;										  // PTX L822
	r_PtxRegister426 = uint32_t(r_LaneIndexAtPtx817) - uint32_t(r_PtxRegister425);			  // PTX L823
	r_PtxRegister427 = ShiftLeft(uint32_t(r_PtxRegister426), uint32_t(1));					  // PTX L824
	r_PtxRegister428 = uint32_t(r_PtxRegister262) + uint32_t(r_PtxRegister427);				  // PTX L825
	r_PtxRegister429 = ShiftRightSigned(int32_t(r_PtxRegister428), uint32_t(1));			  // PTX L826
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister429)) * int64_t(int32_t(4))); // PTX L827
	g_RecordByteAddressAtPtx828 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register107); // PTX L828
	r_PtxRegister235 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx828 + 524288ull);		  // PTX L829
	r_LaneIndexAtPtx831 = uint32_t((threadIdx.x & 31u));									  // PTX L831
	r_PtxRegister430 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx831), uint32_t(31));		  // PTX L833
	r_PtxRegister431 = ShiftRight(uint32_t(r_PtxRegister430), uint32_t(30));				  // PTX L834
	r_PtxRegister432 = uint32_t(r_LaneIndexAtPtx831) + uint32_t(r_PtxRegister431);			  // PTX L835
	r_PtxRegister433 = r_PtxRegister432 & 2147483644;										  // PTX L836
	r_PtxRegister434 = uint32_t(r_LaneIndexAtPtx831) - uint32_t(r_PtxRegister433);			  // PTX L837
	r_PtxRegister435 = ShiftLeft(uint32_t(r_PtxRegister434), uint32_t(1));					  // PTX L838
	r_PtxRegister436 = uint32_t(r_PtxRegister262) + uint32_t(r_PtxRegister435);				  // PTX L839
	r_PtxRegister437 = ShiftRightSigned(int32_t(r_PtxRegister436), uint32_t(1));			  // PTX L840
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister437)) * int64_t(int32_t(4))); // PTX L841
	g_RecordByteAddressAtPtx842 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register109); // PTX L842
	r_PtxRegister237 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx842 + 524288ull);		  // PTX L843
	r_LaneIndexAtPtx845 = uint32_t((threadIdx.x & 31u));									  // PTX L845
	r_PtxRegister438 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx845), uint32_t(31));		  // PTX L847
	r_PtxRegister439 = ShiftRight(uint32_t(r_PtxRegister438), uint32_t(30));				  // PTX L848
	r_PtxRegister440 = uint32_t(r_LaneIndexAtPtx845) + uint32_t(r_PtxRegister439);			  // PTX L849
	r_PtxRegister441 = r_PtxRegister440 & 2147483644;										  // PTX L850
	r_PtxRegister442 = uint32_t(r_LaneIndexAtPtx845) - uint32_t(r_PtxRegister441);			  // PTX L851
	r_PtxRegister443 = ShiftLeft(uint32_t(r_PtxRegister442), uint32_t(1));					  // PTX L852
	r_PtxRegister444 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister443);				  // PTX L853
	r_PtxRegister445 = ShiftRightSigned(int32_t(r_PtxRegister444), uint32_t(1));			  // PTX L854
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister445)) * int64_t(int32_t(4))); // PTX L855
	g_RecordByteAddressAtPtx856 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register111); // PTX L856
	r_PtxRegister239 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx856 + 524288ull);		  // PTX L857
	r_LaneIndexAtPtx859 = uint32_t((threadIdx.x & 31u));									  // PTX L859
	r_PtxRegister446 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx859), uint32_t(31));		  // PTX L861
	r_PtxRegister447 = ShiftRight(uint32_t(r_PtxRegister446), uint32_t(30));				  // PTX L862
	r_PtxRegister448 = uint32_t(r_LaneIndexAtPtx859) + uint32_t(r_PtxRegister447);			  // PTX L863
	r_PtxRegister449 = r_PtxRegister448 & 2147483644;										  // PTX L864
	r_PtxRegister450 = uint32_t(r_LaneIndexAtPtx859) - uint32_t(r_PtxRegister449);			  // PTX L865
	r_PtxRegister451 = ShiftLeft(uint32_t(r_PtxRegister450), uint32_t(1));					  // PTX L866
	r_PtxRegister452 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister451);				  // PTX L867
	r_PtxRegister453 = ShiftRightSigned(int32_t(r_PtxRegister452), uint32_t(1));			  // PTX L868
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister453)) * int64_t(int32_t(4))); // PTX L869
	g_RecordByteAddressAtPtx870 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register113); // PTX L870
	r_PtxRegister241 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx870 + 524288ull);		  // PTX L871
	r_LaneIndexAtPtx873 = uint32_t((threadIdx.x & 31u));									  // PTX L873
	r_PtxRegister454 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx873), uint32_t(31));		  // PTX L875
	r_PtxRegister455 = ShiftRight(uint32_t(r_PtxRegister454), uint32_t(30));				  // PTX L876
	r_PtxRegister456 = uint32_t(r_LaneIndexAtPtx873) + uint32_t(r_PtxRegister455);			  // PTX L877
	r_PtxRegister457 = r_PtxRegister456 & 2147483644;										  // PTX L878
	r_PtxRegister458 = uint32_t(r_LaneIndexAtPtx873) - uint32_t(r_PtxRegister457);			  // PTX L879
	r_PtxRegister459 = ShiftLeft(uint32_t(r_PtxRegister458), uint32_t(1));					  // PTX L880
	r_PtxRegister460 = uint32_t(r_PtxRegister317) + uint32_t(r_PtxRegister459);				  // PTX L881
	r_PtxRegister461 = ShiftRight(uint32_t(r_PtxRegister460), uint32_t(31));				  // PTX L882
	r_PtxRegister462 = uint32_t(r_PtxRegister460) + uint32_t(r_PtxRegister461);				  // PTX L883
	r_PtxRegister463 = ShiftRightSigned(int32_t(r_PtxRegister462), uint32_t(1));			  // PTX L884
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister463)) * int64_t(int32_t(4))); // PTX L885
	g_RecordByteAddressAtPtx886 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register115); // PTX L886
	r_PtxRegister243 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx886 + 524288ull);		  // PTX L887
	r_LaneIndexAtPtx889 = uint32_t((threadIdx.x & 31u));									  // PTX L889
	r_PtxRegister464 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx889), uint32_t(31));		  // PTX L891
	r_PtxRegister465 = ShiftRight(uint32_t(r_PtxRegister464), uint32_t(30));				  // PTX L892
	r_PtxRegister466 = uint32_t(r_LaneIndexAtPtx889) + uint32_t(r_PtxRegister465);			  // PTX L893
	r_PtxRegister467 = r_PtxRegister466 & 2147483644;										  // PTX L894
	r_PtxRegister468 = uint32_t(r_LaneIndexAtPtx889) - uint32_t(r_PtxRegister467);			  // PTX L895
	r_PtxRegister469 = ShiftLeft(uint32_t(r_PtxRegister468), uint32_t(1));					  // PTX L896
	r_PtxRegister470 = uint32_t(r_PtxRegister317) + uint32_t(r_PtxRegister469);				  // PTX L897
	r_PtxRegister471 = ShiftRight(uint32_t(r_PtxRegister470), uint32_t(31));				  // PTX L898
	r_PtxRegister472 = uint32_t(r_PtxRegister470) + uint32_t(r_PtxRegister471);				  // PTX L899
	r_PtxRegister473 = ShiftRightSigned(int32_t(r_PtxRegister472), uint32_t(1));			  // PTX L900
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister473)) * int64_t(int32_t(4))); // PTX L901
	g_RecordByteAddressAtPtx902 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register117); // PTX L902
	r_PtxRegister245 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx902 + 524288ull);		  // PTX L903
	r_LaneIndexAtPtx905 = uint32_t((threadIdx.x & 31u));									  // PTX L905
	r_PtxRegister474 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx905), uint32_t(31));		  // PTX L907
	r_PtxRegister475 = ShiftRight(uint32_t(r_PtxRegister474), uint32_t(30));				  // PTX L908
	r_PtxRegister476 = uint32_t(r_LaneIndexAtPtx905) + uint32_t(r_PtxRegister475);			  // PTX L909
	r_PtxRegister477 = r_PtxRegister476 & 2147483644;										  // PTX L910
	r_PtxRegister478 = uint32_t(r_LaneIndexAtPtx905) - uint32_t(r_PtxRegister477);			  // PTX L911
	r_PtxRegister479 = ShiftLeft(uint32_t(r_PtxRegister478), uint32_t(1));					  // PTX L912
	r_PtxRegister480 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister479);				  // PTX L913
	r_PtxRegister481 = ShiftRightSigned(int32_t(r_PtxRegister480), uint32_t(1));			  // PTX L914
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister481)) * int64_t(int32_t(4))); // PTX L915
	g_RecordByteAddressAtPtx916 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register119); // PTX L916
	r_PtxRegister247 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx916 + 524288ull);		  // PTX L917
	r_LaneIndexAtPtx919 = uint32_t((threadIdx.x & 31u));									  // PTX L919
	r_PtxRegister482 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx919), uint32_t(31));		  // PTX L921
	r_PtxRegister483 = ShiftRight(uint32_t(r_PtxRegister482), uint32_t(30));				  // PTX L922
	r_PtxRegister484 = uint32_t(r_LaneIndexAtPtx919) + uint32_t(r_PtxRegister483);			  // PTX L923
	r_PtxRegister485 = r_PtxRegister484 & 2147483644;										  // PTX L924
	r_PtxRegister486 = uint32_t(r_LaneIndexAtPtx919) - uint32_t(r_PtxRegister485);			  // PTX L925
	r_PtxRegister487 = ShiftLeft(uint32_t(r_PtxRegister486), uint32_t(1));					  // PTX L926
	r_PtxRegister488 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister487);				  // PTX L927
	r_PtxRegister489 = ShiftRightSigned(int32_t(r_PtxRegister488), uint32_t(1));			  // PTX L928
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister489)) * int64_t(int32_t(4))); // PTX L929
	g_RecordByteAddressAtPtx930 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register121); // PTX L930
	r_PtxRegister249 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx930 + 524288ull);		  // PTX L931
	r_LaneIndexAtPtx933 = uint32_t((threadIdx.x & 31u));									  // PTX L933
	r_PtxRegister490 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx933), uint32_t(31));		  // PTX L935
	r_PtxRegister491 = ShiftRight(uint32_t(r_PtxRegister490), uint32_t(30));				  // PTX L936
	r_PtxRegister492 = uint32_t(r_LaneIndexAtPtx933) + uint32_t(r_PtxRegister491);			  // PTX L937
	r_PtxRegister493 = r_PtxRegister492 & 2147483644;										  // PTX L938
	r_PtxRegister494 = uint32_t(r_LaneIndexAtPtx933) - uint32_t(r_PtxRegister493);			  // PTX L939
	r_PtxRegister495 = ShiftLeft(uint32_t(r_PtxRegister494), uint32_t(1));					  // PTX L940
	r_PtxRegister496 = uint32_t(r_PtxRegister354) + uint32_t(r_PtxRegister495);				  // PTX L941
	r_PtxRegister497 = ShiftRight(uint32_t(r_PtxRegister496), uint32_t(31));				  // PTX L942
	r_PtxRegister498 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister497);				  // PTX L943
	r_PtxRegister499 = ShiftRightSigned(int32_t(r_PtxRegister498), uint32_t(1));			  // PTX L944
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister499)) * int64_t(int32_t(4))); // PTX L945
	g_RecordByteAddressAtPtx946 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register123); // PTX L946
	r_PtxRegister251 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx946 + 524288ull);		  // PTX L947
	r_LaneIndexAtPtx949 = uint32_t((threadIdx.x & 31u));									  // PTX L949
	r_PtxRegister500 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx949), uint32_t(31));		  // PTX L951
	r_PtxRegister501 = ShiftRight(uint32_t(r_PtxRegister500), uint32_t(30));				  // PTX L952
	r_PtxRegister502 = uint32_t(r_LaneIndexAtPtx949) + uint32_t(r_PtxRegister501);			  // PTX L953
	r_PtxRegister503 = r_PtxRegister502 & 2147483644;										  // PTX L954
	r_PtxRegister504 = uint32_t(r_LaneIndexAtPtx949) - uint32_t(r_PtxRegister503);			  // PTX L955
	r_PtxRegister505 = ShiftLeft(uint32_t(r_PtxRegister504), uint32_t(1));					  // PTX L956
	r_PtxRegister506 = uint32_t(r_PtxRegister354) + uint32_t(r_PtxRegister505);				  // PTX L957
	r_PtxRegister507 = ShiftRight(uint32_t(r_PtxRegister506), uint32_t(31));				  // PTX L958
	r_PtxRegister508 = uint32_t(r_PtxRegister506) + uint32_t(r_PtxRegister507);				  // PTX L959
	r_PtxRegister509 = ShiftRightSigned(int32_t(r_PtxRegister508), uint32_t(1));			  // PTX L960
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister509)) * int64_t(int32_t(4))); // PTX L961
	g_RecordByteAddressAtPtx962 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register125); // PTX L962
	r_PtxRegister253 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx962 + 524288ull);		  // PTX L963
	r_LaneIndexAtPtx965 = uint32_t((threadIdx.x & 31u));									  // PTX L965
	r_PtxRegister510 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx965), uint32_t(31));		  // PTX L967
	r_PtxRegister511 = ShiftRight(uint32_t(r_PtxRegister510), uint32_t(30));				  // PTX L968
	r_PtxRegister512 = uint32_t(r_LaneIndexAtPtx965) + uint32_t(r_PtxRegister511);			  // PTX L969
	r_PtxRegister513 = r_PtxRegister512 & 2147483644;										  // PTX L970
	r_PtxRegister514 = uint32_t(r_LaneIndexAtPtx965) - uint32_t(r_PtxRegister513);			  // PTX L971
	r_PtxRegister515 = ShiftLeft(uint32_t(r_PtxRegister514), uint32_t(1));					  // PTX L972
	r_PtxRegister516 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister515);				  // PTX L973
	r_PtxRegister517 = ShiftRightSigned(int32_t(r_PtxRegister516), uint32_t(1));			  // PTX L974
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister517)) * int64_t(int32_t(4))); // PTX L975
	g_RecordByteAddressAtPtx976 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register127); // PTX L976
	r_PtxRegister255 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx976 + 524288ull);		  // PTX L977
	r_LaneIndexAtPtx979 = uint32_t((threadIdx.x & 31u));									  // PTX L979
	r_PtxRegister518 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx979), uint32_t(31));		  // PTX L981
	r_PtxRegister519 = ShiftRight(uint32_t(r_PtxRegister518), uint32_t(30));				  // PTX L982
	r_PtxRegister520 = uint32_t(r_LaneIndexAtPtx979) + uint32_t(r_PtxRegister519);			  // PTX L983
	r_PtxRegister521 = r_PtxRegister520 & 2147483644;										  // PTX L984
	r_PtxRegister522 = uint32_t(r_LaneIndexAtPtx979) - uint32_t(r_PtxRegister521);			  // PTX L985
	r_PtxRegister523 = ShiftLeft(uint32_t(r_PtxRegister522), uint32_t(1));					  // PTX L986
	r_PtxRegister524 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister523);				  // PTX L987
	r_PtxRegister525 = ShiftRightSigned(int32_t(r_PtxRegister524), uint32_t(1));			  // PTX L988
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister525)) * int64_t(int32_t(4))); // PTX L989
	g_RecordByteAddressAtPtx990 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register129); // PTX L990
	r_PtxRegister257 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx990 + 524288ull);		  // PTX L991
	r_LaneIndexAtPtx993 = uint32_t((threadIdx.x & 31u));									  // PTX L993
	r_PtxRegister526 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx993), uint32_t(31));		  // PTX L995
	r_PtxRegister527 = ShiftRight(uint32_t(r_PtxRegister526), uint32_t(30));				  // PTX L996
	r_PtxRegister528 = uint32_t(r_LaneIndexAtPtx993) + uint32_t(r_PtxRegister527);			  // PTX L997
	r_PtxRegister529 = r_PtxRegister528 & 2147483644;										  // PTX L998
	r_PtxRegister530 = uint32_t(r_LaneIndexAtPtx993) - uint32_t(r_PtxRegister529);			  // PTX L999
	r_PtxRegister531 = ShiftLeft(uint32_t(r_PtxRegister530), uint32_t(1));					  // PTX L1000
	r_PtxRegister532 = uint32_t(r_PtxRegister391) + uint32_t(r_PtxRegister531);				  // PTX L1001
	r_PtxRegister533 = ShiftRight(uint32_t(r_PtxRegister532), uint32_t(31));				  // PTX L1002
	r_PtxRegister534 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister533);				  // PTX L1003
	r_PtxRegister535 = ShiftRightSigned(int32_t(r_PtxRegister534), uint32_t(1));			  // PTX L1004
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister535)) * int64_t(int32_t(4))); // PTX L1005
	g_RecordByteAddressAtPtx1006 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register131); // PTX L1006
	r_PtxRegister259 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1006 + 524288ull);		  // PTX L1007
	r_LaneIndexAtPtx1009 = uint32_t((threadIdx.x & 31u));									  // PTX L1009
	r_PtxRegister536 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1009), uint32_t(31));		  // PTX L1011
	r_PtxRegister537 = ShiftRight(uint32_t(r_PtxRegister536), uint32_t(30));				  // PTX L1012
	r_PtxRegister538 = uint32_t(r_LaneIndexAtPtx1009) + uint32_t(r_PtxRegister537);			  // PTX L1013
	r_PtxRegister539 = r_PtxRegister538 & 2147483644;										  // PTX L1014
	r_PtxRegister540 = uint32_t(r_LaneIndexAtPtx1009) - uint32_t(r_PtxRegister539);			  // PTX L1015
	r_PtxRegister541 = ShiftLeft(uint32_t(r_PtxRegister540), uint32_t(1));					  // PTX L1016
	r_PtxRegister542 = uint32_t(r_PtxRegister391) + uint32_t(r_PtxRegister541);				  // PTX L1017
	r_PtxRegister543 = ShiftRight(uint32_t(r_PtxRegister542), uint32_t(31));				  // PTX L1018
	r_PtxRegister544 = uint32_t(r_PtxRegister542) + uint32_t(r_PtxRegister543);				  // PTX L1019
	r_PtxRegister545 = ShiftRightSigned(int32_t(r_PtxRegister544), uint32_t(1));			  // PTX L1020
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister545)) * int64_t(int32_t(4))); // PTX L1021
	g_RecordByteAddressAtPtx1022 =
		uint64_t(g_RecordByteAddressAtPtx548) + uint64_t(r_PtxU64Register133); // PTX L1022
	r_PtxRegister261 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1022 + 524288ull);  // PTX L1023
	r_LaneIndexAtPtx1025 = uint32_t((threadIdx.x & 31u));							   // PTX L1025
	r_PackedHalf2AtPtx1028R724 = HalfMul(r_PackedHalf2AtPtx389R663, r_PtxRegister199); // PTX L1028
	r_LaneIndexAtPtx1032 = uint32_t((threadIdx.x & 31u));							   // PTX L1032
	r_PackedHalf2AtPtx1035R723 = HalfMul(r_PackedHalf2AtPtx390R664, r_PtxRegister201); // PTX L1035
	r_LaneIndexAtPtx1039 = uint32_t((threadIdx.x & 31u));							   // PTX L1039
	r_PackedHalf2AtPtx1042R722 = HalfMul(r_PackedHalf2AtPtx391R665, r_PtxRegister203); // PTX L1042
	r_LaneIndexAtPtx1046 = uint32_t((threadIdx.x & 31u));							   // PTX L1046
	r_PackedHalf2AtPtx1049R721 = HalfMul(r_PackedHalf2AtPtx392R666, r_PtxRegister205); // PTX L1049
	r_LaneIndexAtPtx1053 = uint32_t((threadIdx.x & 31u));							   // PTX L1053
	r_PackedHalf2AtPtx1056R720 = HalfMul(r_PackedHalf2AtPtx408R667, r_PtxRegister207); // PTX L1056
	r_LaneIndexAtPtx1060 = uint32_t((threadIdx.x & 31u));							   // PTX L1060
	r_PackedHalf2AtPtx1063R719 = HalfMul(r_PackedHalf2AtPtx409R668, r_PtxRegister209); // PTX L1063
	r_LaneIndexAtPtx1067 = uint32_t((threadIdx.x & 31u));							   // PTX L1067
	r_PackedHalf2AtPtx1070R718 = HalfMul(r_PackedHalf2AtPtx410R669, r_PtxRegister211); // PTX L1070
	r_LaneIndexAtPtx1074 = uint32_t((threadIdx.x & 31u));							   // PTX L1074
	r_PackedHalf2AtPtx1077R717 = HalfMul(r_PackedHalf2AtPtx411R670, r_PtxRegister213); // PTX L1077
	r_LaneIndexAtPtx1081 = uint32_t((threadIdx.x & 31u));							   // PTX L1081
	r_PackedHalf2AtPtx1084R716 = HalfMul(r_PackedHalf2AtPtx427R671, r_PtxRegister215); // PTX L1084
	r_LaneIndexAtPtx1088 = uint32_t((threadIdx.x & 31u));							   // PTX L1088
	r_PackedHalf2AtPtx1091R715 = HalfMul(r_PackedHalf2AtPtx428R672, r_PtxRegister217); // PTX L1091
	r_LaneIndexAtPtx1095 = uint32_t((threadIdx.x & 31u));							   // PTX L1095
	r_PackedHalf2AtPtx1098R714 = HalfMul(r_PackedHalf2AtPtx429R673, r_PtxRegister219); // PTX L1098
	r_LaneIndexAtPtx1102 = uint32_t((threadIdx.x & 31u));							   // PTX L1102
	r_PackedHalf2AtPtx1105R713 = HalfMul(r_PackedHalf2AtPtx430R674, r_PtxRegister221); // PTX L1105
	r_LaneIndexAtPtx1109 = uint32_t((threadIdx.x & 31u));							   // PTX L1109
	r_PackedHalf2AtPtx1112R712 = HalfMul(r_PackedHalf2AtPtx446R675, r_PtxRegister223); // PTX L1112
	r_LaneIndexAtPtx1116 = uint32_t((threadIdx.x & 31u));							   // PTX L1116
	r_PackedHalf2AtPtx1119R711 = HalfMul(r_PackedHalf2AtPtx447R676, r_PtxRegister225); // PTX L1119
	r_LaneIndexAtPtx1123 = uint32_t((threadIdx.x & 31u));							   // PTX L1123
	r_PackedHalf2AtPtx1126R710 = HalfMul(r_PackedHalf2AtPtx448R677, r_PtxRegister227); // PTX L1126
	r_LaneIndexAtPtx1130 = uint32_t((threadIdx.x & 31u));							   // PTX L1130
	r_PackedHalf2AtPtx1133R709 = HalfMul(r_PackedHalf2AtPtx449R678, r_PtxRegister229); // PTX L1133
	r_LaneIndexAtPtx1137 = uint32_t((threadIdx.x & 31u));							   // PTX L1137
	r_PackedHalf2AtPtx1140R708 = HalfMul(r_PackedHalf2AtPtx471R679, r_PtxRegister231); // PTX L1140
	r_LaneIndexAtPtx1144 = uint32_t((threadIdx.x & 31u));							   // PTX L1144
	r_PackedHalf2AtPtx1147R707 = HalfMul(r_PackedHalf2AtPtx472R680, r_PtxRegister233); // PTX L1147
	r_LaneIndexAtPtx1151 = uint32_t((threadIdx.x & 31u));							   // PTX L1151
	r_PackedHalf2AtPtx1154R706 = HalfMul(r_PackedHalf2AtPtx473R681, r_PtxRegister235); // PTX L1154
	r_LaneIndexAtPtx1158 = uint32_t((threadIdx.x & 31u));							   // PTX L1158
	r_PackedHalf2AtPtx1161R705 = HalfMul(r_PackedHalf2AtPtx474R682, r_PtxRegister237); // PTX L1161
	r_LaneIndexAtPtx1165 = uint32_t((threadIdx.x & 31u));							   // PTX L1165
	r_PackedHalf2AtPtx1168R704 = HalfMul(r_PackedHalf2AtPtx490R683, r_PtxRegister239); // PTX L1168
	r_LaneIndexAtPtx1172 = uint32_t((threadIdx.x & 31u));							   // PTX L1172
	r_PackedHalf2AtPtx1175R703 = HalfMul(r_PackedHalf2AtPtx491R684, r_PtxRegister241); // PTX L1175
	r_LaneIndexAtPtx1179 = uint32_t((threadIdx.x & 31u));							   // PTX L1179
	r_PackedHalf2AtPtx1182R702 = HalfMul(r_PackedHalf2AtPtx492R685, r_PtxRegister243); // PTX L1182
	r_LaneIndexAtPtx1186 = uint32_t((threadIdx.x & 31u));							   // PTX L1186
	r_PackedHalf2AtPtx1189R701 = HalfMul(r_PackedHalf2AtPtx493R686, r_PtxRegister245); // PTX L1189
	r_LaneIndexAtPtx1193 = uint32_t((threadIdx.x & 31u));							   // PTX L1193
	r_PackedHalf2AtPtx1196R700 = HalfMul(r_PackedHalf2AtPtx509R687, r_PtxRegister247); // PTX L1196
	r_LaneIndexAtPtx1200 = uint32_t((threadIdx.x & 31u));							   // PTX L1200
	r_PackedHalf2AtPtx1203R699 = HalfMul(r_PackedHalf2AtPtx510R688, r_PtxRegister249); // PTX L1203
	r_LaneIndexAtPtx1207 = uint32_t((threadIdx.x & 31u));							   // PTX L1207
	r_PackedHalf2AtPtx1210R698 = HalfMul(r_PackedHalf2AtPtx511R689, r_PtxRegister251); // PTX L1210
	r_LaneIndexAtPtx1214 = uint32_t((threadIdx.x & 31u));							   // PTX L1214
	r_PackedHalf2AtPtx1217R697 = HalfMul(r_PackedHalf2AtPtx512R690, r_PtxRegister253); // PTX L1217
	r_LaneIndexAtPtx1221 = uint32_t((threadIdx.x & 31u));							   // PTX L1221
	r_PackedHalf2AtPtx1224R696 = HalfMul(r_PackedHalf2AtPtx528R691, r_PtxRegister255); // PTX L1224
	r_LaneIndexAtPtx1228 = uint32_t((threadIdx.x & 31u));							   // PTX L1228
	r_PackedHalf2AtPtx1231R695 = HalfMul(r_PackedHalf2AtPtx529R692, r_PtxRegister257); // PTX L1231
	r_LaneIndexAtPtx1235 = uint32_t((threadIdx.x & 31u));							   // PTX L1235
	r_PackedHalf2AtPtx1238R725 = HalfMul(r_PackedHalf2AtPtx530R693, r_PtxRegister259); // PTX L1238
	r_LaneIndexAtPtx1242 = uint32_t((threadIdx.x & 31u));							   // PTX L1242
	r_PackedHalf2AtPtx1245R726 = HalfMul(r_PackedHalf2AtPtx531R694, r_PtxRegister261); // PTX L1245
	r_PtxRegister30 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(11));			   // PTX L1248
	r_PtxRegister31 = uint32_t(r_PtxRegister26) + uint32_t(64);						   // PTX L1249
	r_PtxRegister727 = uint32_t(0);													   // PTX L1250
L__BB26_54:																			   // PTX L1251
	r_PtxRegister602 = ShiftRight(uint32_t(r_PtxRegister727), uint32_t(5));			   // PTX L1252
	r_PtxU16Register1 = uint16_t(r_PtxRegister602);									   // PTX L1253
	r_PtxU16Register2 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register1)) * uint32_t(uint16_t(171)));				 // PTX L1254
	r_PtxU16Register3 = ShiftRight(uint16_t(r_PtxU16Register2), uint32_t(9));					 // PTX L1255
	r_PtxU16Register4 = uint16_t(uint32_t(uint16_t(r_PtxU16Register3)) * uint32_t(uint16_t(3))); // PTX L1256
	r_PtxU16Register5 = uint16_t(r_PtxU16Register1) - uint16_t(r_PtxU16Register4);				 // PTX L1257
	r_PtxRegister603 = uint32_t(uint16_t(r_PtxU16Register5));									 // PTX L1258
	r_PtxRegister32 = r_PtxRegister603 & 255;													 // PTX L1259
	r_PtxU16Register6 = r_PtxU16Register5 & 255;												 // PTX L1260
	r_PtxRegister33 = uint32_t(uint16_t(r_PtxU16Register6)) * uint32_t(uint16_t(4096));			 // PTX L1261
	r_LaneIndexAtPtx1263 = uint32_t((threadIdx.x & 31u));										 // PTX L1263
	r_PtxRegister604 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister30);					 // PTX L1265
	r_PtxRegister605 = uint32_t(0u /* exact native shared-region offset */);					 // PTX L1266
	r_PtxRegister606 = uint32_t(r_PtxRegister605) + uint32_t(r_PtxRegister604);					 // PTX L1267
	r_PtxRegister607 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1263), uint32_t(4));					 // PTX L1268
	r_PtxRegister547 = uint32_t(r_PtxRegister606) + uint32_t(r_PtxRegister607);					 // PTX L1269
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister547));
		r_MmaAHalf2WordAtPtx1271R554 = r_Value.x;
		r_MmaAHalf2WordAtPtx1271R555 = r_Value.y;
		r_MmaAHalf2WordAtPtx1271R556 = r_Value.z;
		r_MmaAHalf2WordAtPtx1271R557 = r_Value.w;
	} // PTX L1271
	r_LaneIndexAtPtx1274 = uint32_t((threadIdx.x & 31u));						// PTX L1274
	r_PtxRegister608 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1274), uint32_t(4));	// PTX L1276
	r_PtxRegister609 = uint32_t(r_PtxRegister606) + uint32_t(r_PtxRegister608); // PTX L1277
	r_PtxRegister549 = uint32_t(r_PtxRegister609) + uint32_t(512);				// PTX L1278
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister549));
		r_MmaAHalf2WordAtPtx1280R558 = r_Value.x;
		r_MmaAHalf2WordAtPtx1280R559 = r_Value.y;
		r_MmaAHalf2WordAtPtx1280R560 = r_Value.z;
		r_MmaAHalf2WordAtPtx1280R561 = r_Value.w;
	} // PTX L1280
	r_LaneIndexAtPtx1283 = uint32_t((threadIdx.x & 31u));						// PTX L1283
	r_PtxRegister610 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1283), uint32_t(4));	// PTX L1285
	r_PtxRegister611 = uint32_t(r_PtxRegister606) + uint32_t(r_PtxRegister610); // PTX L1286
	r_PtxRegister551 = uint32_t(r_PtxRegister611) + uint32_t(1024);				// PTX L1287
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister551));
		r_MmaAHalf2WordAtPtx1289R578 = r_Value.x;
		r_MmaAHalf2WordAtPtx1289R579 = r_Value.y;
		r_MmaAHalf2WordAtPtx1289R580 = r_Value.z;
		r_MmaAHalf2WordAtPtx1289R581 = r_Value.w;
	} // PTX L1289
	r_LaneIndexAtPtx1292 = uint32_t((threadIdx.x & 31u));						// PTX L1292
	r_PtxRegister612 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1292), uint32_t(4));	// PTX L1294
	r_PtxRegister613 = uint32_t(r_PtxRegister606) + uint32_t(r_PtxRegister612); // PTX L1295
	r_PtxRegister553 = uint32_t(r_PtxRegister613) + uint32_t(1536);				// PTX L1296
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister553));
		r_MmaAHalf2WordAtPtx1298R582 = r_Value.x;
		r_MmaAHalf2WordAtPtx1298R583 = r_Value.y;
		r_MmaAHalf2WordAtPtx1298R584 = r_Value.z;
		r_MmaAHalf2WordAtPtx1298R585 = r_Value.w;
	} // PTX L1298
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1301R562, r_MmaAccumulatorHalf2WordAtPtx1301R563,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx85R758, r_MmaBHalf2WordAtPtx85R757,
			r_PackedHalf2AtPtx1028R724,
			r_PackedHalf2AtPtx1035R723); // PTX L1301
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1308R564, r_MmaAccumulatorHalf2WordAtPtx1308R565,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx85R756, r_MmaBHalf2WordAtPtx85R755,
			r_PackedHalf2AtPtx1042R722,
			r_PackedHalf2AtPtx1049R721); // PTX L1308
	MmaHalf(r_PackedHalf2AtPtx1028R724, r_PackedHalf2AtPtx1035R723, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx127R742, r_MmaBHalf2WordAtPtx127R741, r_MmaAccumulatorHalf2WordAtPtx1301R562,
			r_MmaAccumulatorHalf2WordAtPtx1301R563); // PTX L1315
	MmaHalf(r_PackedHalf2AtPtx1042R722, r_PackedHalf2AtPtx1049R721, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx127R740, r_MmaBHalf2WordAtPtx127R739, r_MmaAccumulatorHalf2WordAtPtx1308R564,
			r_MmaAccumulatorHalf2WordAtPtx1308R565); // PTX L1322
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1329R566, r_MmaAccumulatorHalf2WordAtPtx1329R567,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx96R754, r_MmaBHalf2WordAtPtx96R753,
			r_PackedHalf2AtPtx1056R720,
			r_PackedHalf2AtPtx1063R719); // PTX L1329
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1336R568, r_MmaAccumulatorHalf2WordAtPtx1336R569,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx96R752, r_MmaBHalf2WordAtPtx96R751,
			r_PackedHalf2AtPtx1070R718,
			r_PackedHalf2AtPtx1077R717); // PTX L1336
	MmaHalf(r_PackedHalf2AtPtx1056R720, r_PackedHalf2AtPtx1063R719, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx136R738, r_MmaBHalf2WordAtPtx136R737, r_MmaAccumulatorHalf2WordAtPtx1329R566,
			r_MmaAccumulatorHalf2WordAtPtx1329R567); // PTX L1343
	MmaHalf(r_PackedHalf2AtPtx1070R718, r_PackedHalf2AtPtx1077R717, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx136R736, r_MmaBHalf2WordAtPtx136R735, r_MmaAccumulatorHalf2WordAtPtx1336R568,
			r_MmaAccumulatorHalf2WordAtPtx1336R569); // PTX L1350
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1357R570, r_MmaAccumulatorHalf2WordAtPtx1357R571,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx107R750, r_MmaBHalf2WordAtPtx107R749,
			r_PackedHalf2AtPtx1084R716, r_PackedHalf2AtPtx1091R715); // PTX L1357
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1364R572, r_MmaAccumulatorHalf2WordAtPtx1364R573,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx107R748, r_MmaBHalf2WordAtPtx107R747,
			r_PackedHalf2AtPtx1098R714, r_PackedHalf2AtPtx1105R713); // PTX L1364
	MmaHalf(r_PackedHalf2AtPtx1084R716, r_PackedHalf2AtPtx1091R715, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx145R734, r_MmaBHalf2WordAtPtx145R733, r_MmaAccumulatorHalf2WordAtPtx1357R570,
			r_MmaAccumulatorHalf2WordAtPtx1357R571); // PTX L1371
	MmaHalf(r_PackedHalf2AtPtx1098R714, r_PackedHalf2AtPtx1105R713, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx145R732, r_MmaBHalf2WordAtPtx145R731, r_MmaAccumulatorHalf2WordAtPtx1364R572,
			r_MmaAccumulatorHalf2WordAtPtx1364R573); // PTX L1378
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1385R574, r_MmaAccumulatorHalf2WordAtPtx1385R575,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx118R746, r_MmaBHalf2WordAtPtx118R745,
			r_PackedHalf2AtPtx1112R712, r_PackedHalf2AtPtx1119R711); // PTX L1385
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1392R576, r_MmaAccumulatorHalf2WordAtPtx1392R577,
			r_MmaAHalf2WordAtPtx1271R554, r_MmaAHalf2WordAtPtx1271R555, r_MmaAHalf2WordAtPtx1271R556,
			r_MmaAHalf2WordAtPtx1271R557, r_MmaBHalf2WordAtPtx118R744, r_MmaBHalf2WordAtPtx118R743,
			r_PackedHalf2AtPtx1126R710, r_PackedHalf2AtPtx1133R709); // PTX L1392
	MmaHalf(r_PackedHalf2AtPtx1112R712, r_PackedHalf2AtPtx1119R711, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx154R730, r_MmaBHalf2WordAtPtx154R729, r_MmaAccumulatorHalf2WordAtPtx1385R574,
			r_MmaAccumulatorHalf2WordAtPtx1385R575); // PTX L1399
	MmaHalf(r_PackedHalf2AtPtx1126R710, r_PackedHalf2AtPtx1133R709, r_MmaAHalf2WordAtPtx1280R558,
			r_MmaAHalf2WordAtPtx1280R559, r_MmaAHalf2WordAtPtx1280R560, r_MmaAHalf2WordAtPtx1280R561,
			r_MmaBHalf2WordAtPtx154R728, r_MmaBHalf2WordAtPtx154R759, r_MmaAccumulatorHalf2WordAtPtx1392R576,
			r_MmaAccumulatorHalf2WordAtPtx1392R577); // PTX L1406
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1413R586, r_MmaAccumulatorHalf2WordAtPtx1413R587,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx85R758, r_MmaBHalf2WordAtPtx85R757,
			r_PackedHalf2AtPtx1140R708,
			r_PackedHalf2AtPtx1147R707); // PTX L1413
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1420R588, r_MmaAccumulatorHalf2WordAtPtx1420R589,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx85R756, r_MmaBHalf2WordAtPtx85R755,
			r_PackedHalf2AtPtx1154R706,
			r_PackedHalf2AtPtx1161R705); // PTX L1420
	MmaHalf(r_PackedHalf2AtPtx1140R708, r_PackedHalf2AtPtx1147R707, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx127R742, r_MmaBHalf2WordAtPtx127R741, r_MmaAccumulatorHalf2WordAtPtx1413R586,
			r_MmaAccumulatorHalf2WordAtPtx1413R587); // PTX L1427
	MmaHalf(r_PackedHalf2AtPtx1154R706, r_PackedHalf2AtPtx1161R705, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx127R740, r_MmaBHalf2WordAtPtx127R739, r_MmaAccumulatorHalf2WordAtPtx1420R588,
			r_MmaAccumulatorHalf2WordAtPtx1420R589); // PTX L1434
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1441R590, r_MmaAccumulatorHalf2WordAtPtx1441R591,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx96R754, r_MmaBHalf2WordAtPtx96R753,
			r_PackedHalf2AtPtx1168R704,
			r_PackedHalf2AtPtx1175R703); // PTX L1441
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1448R592, r_MmaAccumulatorHalf2WordAtPtx1448R593,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx96R752, r_MmaBHalf2WordAtPtx96R751,
			r_PackedHalf2AtPtx1182R702,
			r_PackedHalf2AtPtx1189R701); // PTX L1448
	MmaHalf(r_PackedHalf2AtPtx1168R704, r_PackedHalf2AtPtx1175R703, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx136R738, r_MmaBHalf2WordAtPtx136R737, r_MmaAccumulatorHalf2WordAtPtx1441R590,
			r_MmaAccumulatorHalf2WordAtPtx1441R591); // PTX L1455
	MmaHalf(r_PackedHalf2AtPtx1182R702, r_PackedHalf2AtPtx1189R701, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx136R736, r_MmaBHalf2WordAtPtx136R735, r_MmaAccumulatorHalf2WordAtPtx1448R592,
			r_MmaAccumulatorHalf2WordAtPtx1448R593); // PTX L1462
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1469R594, r_MmaAccumulatorHalf2WordAtPtx1469R595,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx107R750, r_MmaBHalf2WordAtPtx107R749,
			r_PackedHalf2AtPtx1196R700, r_PackedHalf2AtPtx1203R699); // PTX L1469
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1476R596, r_MmaAccumulatorHalf2WordAtPtx1476R597,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx107R748, r_MmaBHalf2WordAtPtx107R747,
			r_PackedHalf2AtPtx1210R698, r_PackedHalf2AtPtx1217R697); // PTX L1476
	MmaHalf(r_PackedHalf2AtPtx1196R700, r_PackedHalf2AtPtx1203R699, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx145R734, r_MmaBHalf2WordAtPtx145R733, r_MmaAccumulatorHalf2WordAtPtx1469R594,
			r_MmaAccumulatorHalf2WordAtPtx1469R595); // PTX L1483
	MmaHalf(r_PackedHalf2AtPtx1210R698, r_PackedHalf2AtPtx1217R697, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx145R732, r_MmaBHalf2WordAtPtx145R731, r_MmaAccumulatorHalf2WordAtPtx1476R596,
			r_MmaAccumulatorHalf2WordAtPtx1476R597); // PTX L1490
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1497R598, r_MmaAccumulatorHalf2WordAtPtx1497R599,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx118R746, r_MmaBHalf2WordAtPtx118R745,
			r_PackedHalf2AtPtx1224R696, r_PackedHalf2AtPtx1231R695); // PTX L1497
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1504R600, r_MmaAccumulatorHalf2WordAtPtx1504R601,
			r_MmaAHalf2WordAtPtx1289R578, r_MmaAHalf2WordAtPtx1289R579, r_MmaAHalf2WordAtPtx1289R580,
			r_MmaAHalf2WordAtPtx1289R581, r_MmaBHalf2WordAtPtx118R744, r_MmaBHalf2WordAtPtx118R743,
			r_PackedHalf2AtPtx1238R725, r_PackedHalf2AtPtx1245R726); // PTX L1504
	MmaHalf(r_PackedHalf2AtPtx1224R696, r_PackedHalf2AtPtx1231R695, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx154R730, r_MmaBHalf2WordAtPtx154R729, r_MmaAccumulatorHalf2WordAtPtx1497R598,
			r_MmaAccumulatorHalf2WordAtPtx1497R599); // PTX L1511
	MmaHalf(r_PackedHalf2AtPtx1238R725, r_PackedHalf2AtPtx1245R726, r_MmaAHalf2WordAtPtx1298R582,
			r_MmaAHalf2WordAtPtx1298R583, r_MmaAHalf2WordAtPtx1298R584, r_MmaAHalf2WordAtPtx1298R585,
			r_MmaBHalf2WordAtPtx154R728, r_MmaBHalf2WordAtPtx154R759, r_MmaAccumulatorHalf2WordAtPtx1504R600,
			r_MmaAccumulatorHalf2WordAtPtx1504R601);				// PTX L1518
	r_bPtxPredicate35 = uint32_t(r_PtxRegister727) > uint32_t(479); // PTX L1524
	if (r_bPtxPredicate35)
	{
		goto L__BB26_57;
	} // PTX L1525
	r_PtxRegister623 = uint32_t(r_PtxRegister727) + uint32_t(32);								  // PTX L1526
	r_PtxRegister624 = uint32_t(r_PtxRegister623) + uint32_t(r_PtxRegister7);					  // PTX L1527
	r_PtxRegister625 = ShiftLeft(uint32_t(r_PtxRegister624), uint32_t(8));						  // PTX L1528
	r_PtxRegister626 = uint32_t(r_PtxRegister625) + uint32_t(r_PtxRegister12);					  // PTX L1529
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister626)) * int64_t(int32_t(4)));	  // PTX L1530
	g_RecordByteAddressAtPtx1531 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register143); // PTX L1531
	r_LaneIndexAtPtx1533 = uint32_t((threadIdx.x & 31u));										  // PTX L1533
	r_PtxU64Register145 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1533)) * int64_t(int32_t(16))); // PTX L1535
	g_RecordByteAddressAtPtx1536 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register145); // PTX L1536
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1536));
		r_MmaBHalf2WordAtPtx85R758 = r_Value.x;
		r_MmaBHalf2WordAtPtx85R757 = r_Value.y;
		r_MmaBHalf2WordAtPtx85R756 = r_Value.z;
		r_MmaBHalf2WordAtPtx85R755 = r_Value.w;
	} // PTX L1538
	r_LaneIndexAtPtx1541 = uint32_t((threadIdx.x & 31u)); // PTX L1541
	r_PtxU64Register146 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1541)) * int64_t(int32_t(16))); // PTX L1543
	g_RecordByteAddressAtPtx1544 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register146);			   // PTX L1544
	g_RecordByteAddressAtPtx1545 = uint64_t(g_RecordByteAddressAtPtx1544) + uint64_t(512); // PTX L1545
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1545));
		r_MmaBHalf2WordAtPtx96R754 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R753 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R752 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R751 = r_Value.w;
	} // PTX L1547
	r_LaneIndexAtPtx1550 = uint32_t((threadIdx.x & 31u)); // PTX L1550
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1550)) * int64_t(int32_t(16))); // PTX L1552
	g_RecordByteAddressAtPtx1553 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register148);				// PTX L1553
	g_RecordByteAddressAtPtx1554 = uint64_t(g_RecordByteAddressAtPtx1553) + uint64_t(1024); // PTX L1554
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1554));
		r_MmaBHalf2WordAtPtx107R750 = r_Value.x;
		r_MmaBHalf2WordAtPtx107R749 = r_Value.y;
		r_MmaBHalf2WordAtPtx107R748 = r_Value.z;
		r_MmaBHalf2WordAtPtx107R747 = r_Value.w;
	} // PTX L1556
	r_LaneIndexAtPtx1559 = uint32_t((threadIdx.x & 31u)); // PTX L1559
	r_PtxU64Register150 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1559)) * int64_t(int32_t(16))); // PTX L1561
	g_RecordByteAddressAtPtx1562 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register150);				// PTX L1562
	g_RecordByteAddressAtPtx1563 = uint64_t(g_RecordByteAddressAtPtx1562) + uint64_t(1536); // PTX L1563
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1563));
		r_MmaBHalf2WordAtPtx118R746 = r_Value.x;
		r_MmaBHalf2WordAtPtx118R745 = r_Value.y;
		r_MmaBHalf2WordAtPtx118R744 = r_Value.z;
		r_MmaBHalf2WordAtPtx118R743 = r_Value.w;
	} // PTX L1565
	r_LaneIndexAtPtx1568 = uint32_t((threadIdx.x & 31u)); // PTX L1568
	r_PtxU64Register152 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1568)) * int64_t(int32_t(16))); // PTX L1570
	g_RecordByteAddressAtPtx1571 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register152);				 // PTX L1571
	g_RecordByteAddressAtPtx1572 = uint64_t(g_RecordByteAddressAtPtx1571) + uint64_t(16384); // PTX L1572
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1572));
		r_MmaBHalf2WordAtPtx127R742 = r_Value.x;
		r_MmaBHalf2WordAtPtx127R741 = r_Value.y;
		r_MmaBHalf2WordAtPtx127R740 = r_Value.z;
		r_MmaBHalf2WordAtPtx127R739 = r_Value.w;
	} // PTX L1574
	r_LaneIndexAtPtx1577 = uint32_t((threadIdx.x & 31u)); // PTX L1577
	r_PtxU64Register154 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1577)) * int64_t(int32_t(16))); // PTX L1579
	g_RecordByteAddressAtPtx1580 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register154);				 // PTX L1580
	g_RecordByteAddressAtPtx1581 = uint64_t(g_RecordByteAddressAtPtx1580) + uint64_t(16896); // PTX L1581
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1581));
		r_MmaBHalf2WordAtPtx136R738 = r_Value.x;
		r_MmaBHalf2WordAtPtx136R737 = r_Value.y;
		r_MmaBHalf2WordAtPtx136R736 = r_Value.z;
		r_MmaBHalf2WordAtPtx136R735 = r_Value.w;
	} // PTX L1583
	r_LaneIndexAtPtx1586 = uint32_t((threadIdx.x & 31u)); // PTX L1586
	r_PtxU64Register156 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1586)) * int64_t(int32_t(16))); // PTX L1588
	g_RecordByteAddressAtPtx1589 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register156);				 // PTX L1589
	g_RecordByteAddressAtPtx1590 = uint64_t(g_RecordByteAddressAtPtx1589) + uint64_t(17408); // PTX L1590
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1590));
		r_MmaBHalf2WordAtPtx145R734 = r_Value.x;
		r_MmaBHalf2WordAtPtx145R733 = r_Value.y;
		r_MmaBHalf2WordAtPtx145R732 = r_Value.z;
		r_MmaBHalf2WordAtPtx145R731 = r_Value.w;
	} // PTX L1592
	r_LaneIndexAtPtx1595 = uint32_t((threadIdx.x & 31u)); // PTX L1595
	r_PtxU64Register158 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1595)) * int64_t(int32_t(16))); // PTX L1597
	g_RecordByteAddressAtPtx1598 =
		uint64_t(g_RecordByteAddressAtPtx1531) + uint64_t(r_PtxU64Register158);				 // PTX L1598
	g_RecordByteAddressAtPtx1599 = uint64_t(g_RecordByteAddressAtPtx1598) + uint64_t(17920); // PTX L1599
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1599));
		r_MmaBHalf2WordAtPtx154R730 = r_Value.x;
		r_MmaBHalf2WordAtPtx154R729 = r_Value.y;
		r_MmaBHalf2WordAtPtx154R728 = r_Value.z;
		r_MmaBHalf2WordAtPtx154R759 = r_Value.w;
	} // PTX L1601
	r_PtxRegister627 = ShiftRight(uint32_t(r_PtxRegister623), uint32_t(5)); // PTX L1603
	r_PtxU16Register7 = uint16_t(r_PtxRegister627);							// PTX L1604
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L1605
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L1606
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L1607
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L1608
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L1609
	r_PtxRegister628 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8));			  // PTX L1610
	r_PtxRegister629 = uint32_t(12288u /* exact native shared-region offset */);				  // PTX L1611
	r_PtxRegister631 = uint32_t(r_PtxRegister629) + uint32_t(r_PtxRegister628);					  // PTX L1612
	r_PtxRegister622 = uint32_t(1);																  // PTX L1613
	r_PtxU64Register160 = BarrierArrive(s_SharedStorage, r_PtxRegister631, r_PtxRegister622);	  // PTX L1615
L__BB26_56:																						  // PTX L1617
	r_PtxRegister630 = BarrierReady(s_SharedStorage, r_PtxRegister631, r_PtxU64Register160);	  // PTX L1619
	r_bPtxPredicate36 = uint32_t(r_PtxRegister630) == uint32_t(0);								  // PTX L1625
	if (r_bPtxPredicate36)
	{
		goto L__BB26_56;
	} // PTX L1626
L__BB26_57:															// PTX L1627
	r_bPtxPredicate37 = uint32_t(r_PtxRegister727) > uint32_t(415); // PTX L1628
	if (r_bPtxPredicate37)
	{
		goto L__BB26_66;
	} // PTX L1629
	r_bPtxPredicate38 = int32_t(r_PtxRegister21) < int32_t(r_WidthDiv4Bits); // PTX L1630
	r_bPtxPredicate39 = r_bPtxPredicate3 | r_bPtxPredicate38;				 // PTX L1631
	r_bPtxPredicate7 = r_bPtxPredicate39 & r_bPtxPredicate2;				 // PTX L1632
	r_PtxU64Register193 = uint64_t(0);										 // PTX L1633
	r_bPtxPredicate40 = !r_bPtxPredicate7;									 // PTX L1634
	if (r_bPtxPredicate40)
	{
		goto L__BB26_60;
	} // PTX L1635
	r_PtxRegister632 = r_bPtxPredicate4 ? 0 : r_PtxRegister21;					// PTX L1636
	r_PtxRegister633 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister632);	// PTX L1637
	r_PtxRegister634 = ShiftLeft(uint32_t(r_PtxRegister633), uint32_t(12));		// PTX L1638
	r_PtxRegister635 = uint32_t(r_PtxRegister727) + uint32_t(r_PtxRegister31);	// PTX L1639
	r_PtxRegister636 = ShiftLeft(uint32_t(r_PtxRegister635), uint32_t(3));		// PTX L1640
	r_PtxRegister637 = uint32_t(r_PtxRegister634) + uint32_t(r_PtxRegister636); // PTX L1641
	r_PtxU64Register193 = SignExtendWordBits(r_PtxRegister637);					// PTX L1642
L__BB26_60:																		// PTX L1643
	r_PtxU64Register194 = uint64_t(0);											// PTX L1644
	if (r_bPtxPredicate40)
	{
		goto L__BB26_62;
	} // PTX L1645
	r_PtxU64Register161 = ShiftLeft(uint64_t(r_PtxU64Register193), uint32_t(2));		// PTX L1646
	r_PtxU64Register194 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register161); // PTX L1647
L__BB26_62:																				// PTX L1648
	if (r_bPtxPredicate40)
	{
		goto L__BB26_65;
	} // PTX L1649
	r_PtxRegister643 = uint32_t(-1);							   // PTX L1650
	r_PtxRegister642 = Elected(r_PtxRegister643);				   // PTX L1652
	r_bPtxPredicate41 = uint32_t(r_PtxRegister642) == uint32_t(0); // PTX L1658
	if (r_bPtxPredicate41)
	{
		goto L__BB26_66;
	} // PTX L1659
	r_PtxRegister644 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister33);	 // PTX L1660
	r_PtxU64Register162 = r_PtxU64Register194;									 // PTX L1661
	r_PtxRegister647 = ShiftLeft(uint32_t(r_PtxRegister32), uint32_t(3));		 // PTX L1662
	r_PtxRegister648 = uint32_t(12288u /* exact native shared-region offset */); // PTX L1663
	r_PtxRegister646 = uint32_t(r_PtxRegister648) + uint32_t(r_PtxRegister647);	 // PTX L1664
	r_PtxRegister645 = uint32_t(512);											 // PTX L1665
	CopyBulk(s_SharedStorage, r_PtxRegister644, r_PtxU64Register162, r_PtxRegister645,
			 r_PtxRegister646);													// PTX L1667
	BarrierExpect(s_SharedStorage, r_PtxRegister646, r_PtxRegister645);			// PTX L1670
	goto L__BB26_66;															// PTX L1672
L__BB26_65:																		// PTX L1673
	r_LaneIndexAtPtx1675 = uint32_t((threadIdx.x & 31u));						// PTX L1675
	r_PtxRegister640 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister33);	// PTX L1677
	r_PtxRegister641 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1675), uint32_t(4));	// PTX L1678
	r_PtxRegister639 = uint32_t(r_PtxRegister640) + uint32_t(r_PtxRegister641); // PTX L1679
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister639)) =
		make_uint4(r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120, r_PackedHalf2AtPtx65R120,
				   r_PackedHalf2AtPtx65R120);						// PTX L1681
L__BB26_66:															// PTX L1683
	r_bPtxPredicate42 = uint32_t(r_PtxRegister727) < uint32_t(480); // PTX L1684
	r_PtxRegister727 = uint32_t(r_PtxRegister727) + uint32_t(32);	// PTX L1685
	if (r_bPtxPredicate42)
	{
		goto L__BB26_54;
	} // PTX L1686
	r_bPtxPredicate43 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);					  // PTX L1687
	r_bPtxPredicate44 = int32_t(r_PtxRegister81) >= int32_t(r_HeightDiv4Bits);					  // PTX L1688
	r_PtxRegister649 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister6);					  // PTX L1689
	r_PtxRegister650 = ShiftLeft(uint32_t(r_PtxRegister649), uint32_t(12));						  // PTX L1690
	r_PtxRegister651 = uint32_t(r_PtxRegister650) + uint32_t(r_PtxRegister12);					  // PTX L1691
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister651)) * int64_t(int32_t(4)));	  // PTX L1692
	g_OutputByteAddressAtPtx1693 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register163); // PTX L1693
	r_bPtxPredicate45 = r_bPtxPredicate44 | r_bPtxPredicate43;									  // PTX L1694
	if (r_bPtxPredicate45)
	{
		goto L__BB26_69;
	} // PTX L1695
	r_LaneIndexAtPtx1697 = uint32_t((threadIdx.x & 31u)); // PTX L1697
	r_PtxU64Register168 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1697)) * int64_t(int32_t(16))); // PTX L1699
	g_OutputByteAddressAtPtx1700 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register168); // PTX L1700
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx1700,
					make_uint4(r_PackedHalf2AtPtx1028R724, r_PackedHalf2AtPtx1035R723,
							   r_PackedHalf2AtPtx1042R722, r_PackedHalf2AtPtx1049R721)); // PTX L1702
	r_LaneIndexAtPtx1705 = uint32_t((threadIdx.x & 31u));								 // PTX L1705
	r_PtxU64Register169 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1705)) * int64_t(int32_t(16))); // PTX L1707
	g_OutputByteAddressAtPtx1708 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register169);			   // PTX L1708
	g_OutputByteAddressAtPtx1709 = uint64_t(g_OutputByteAddressAtPtx1708) + uint64_t(512); // PTX L1709
	StoreNoAllocate(g_OutputByteAddressAtPtx1709,
					make_uint4(r_PackedHalf2AtPtx1056R720, r_PackedHalf2AtPtx1063R719,
							   r_PackedHalf2AtPtx1070R718, r_PackedHalf2AtPtx1077R717)); // PTX L1711
	r_LaneIndexAtPtx1714 = uint32_t((threadIdx.x & 31u));								 // PTX L1714
	r_PtxU64Register171 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1714)) * int64_t(int32_t(16))); // PTX L1716
	g_OutputByteAddressAtPtx1717 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register171);				// PTX L1717
	g_OutputByteAddressAtPtx1718 = uint64_t(g_OutputByteAddressAtPtx1717) + uint64_t(1024); // PTX L1718
	StoreNoAllocate(g_OutputByteAddressAtPtx1718,
					make_uint4(r_PackedHalf2AtPtx1084R716, r_PackedHalf2AtPtx1091R715,
							   r_PackedHalf2AtPtx1098R714, r_PackedHalf2AtPtx1105R713)); // PTX L1720
	r_LaneIndexAtPtx1723 = uint32_t((threadIdx.x & 31u));								 // PTX L1723
	r_PtxU64Register173 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1723)) * int64_t(int32_t(16))); // PTX L1725
	g_OutputByteAddressAtPtx1726 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register173);				// PTX L1726
	g_OutputByteAddressAtPtx1727 = uint64_t(g_OutputByteAddressAtPtx1726) + uint64_t(1536); // PTX L1727
	StoreNoAllocate(g_OutputByteAddressAtPtx1727,
					make_uint4(r_PackedHalf2AtPtx1112R712, r_PackedHalf2AtPtx1119R711,
							   r_PackedHalf2AtPtx1126R710, r_PackedHalf2AtPtx1133R709)); // PTX L1729
L__BB26_69:																				 // PTX L1731
	r_bPtxPredicate46 = int32_t(r_PtxRegister28) >= int32_t(r_WidthDiv4Bits);			 // PTX L1732
	r_bPtxPredicate47 = r_bPtxPredicate44 | r_bPtxPredicate46;							 // PTX L1733
	if (r_bPtxPredicate47)
	{
		goto L__BB26_71;
	} // PTX L1734
	r_LaneIndexAtPtx1736 = uint32_t((threadIdx.x & 31u)); // PTX L1736
	r_PtxU64Register179 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1736)) * int64_t(int32_t(16))); // PTX L1738
	g_OutputByteAddressAtPtx1739 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register179);				 // PTX L1739
	g_OutputByteAddressAtPtx1740 = uint64_t(g_OutputByteAddressAtPtx1739) + uint64_t(16384); // PTX L1740
	StoreNoAllocate(g_OutputByteAddressAtPtx1740,
					make_uint4(r_PackedHalf2AtPtx1140R708, r_PackedHalf2AtPtx1147R707,
							   r_PackedHalf2AtPtx1154R706, r_PackedHalf2AtPtx1161R705)); // PTX L1742
	r_LaneIndexAtPtx1745 = uint32_t((threadIdx.x & 31u));								 // PTX L1745
	r_PtxU64Register181 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1745)) * int64_t(int32_t(16))); // PTX L1747
	g_OutputByteAddressAtPtx1748 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register181);				 // PTX L1748
	g_OutputByteAddressAtPtx1749 = uint64_t(g_OutputByteAddressAtPtx1748) + uint64_t(16896); // PTX L1749
	StoreNoAllocate(g_OutputByteAddressAtPtx1749,
					make_uint4(r_PackedHalf2AtPtx1168R704, r_PackedHalf2AtPtx1175R703,
							   r_PackedHalf2AtPtx1182R702, r_PackedHalf2AtPtx1189R701)); // PTX L1751
	r_LaneIndexAtPtx1754 = uint32_t((threadIdx.x & 31u));								 // PTX L1754
	r_PtxU64Register183 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1754)) * int64_t(int32_t(16))); // PTX L1756
	g_OutputByteAddressAtPtx1757 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register183);				 // PTX L1757
	g_OutputByteAddressAtPtx1758 = uint64_t(g_OutputByteAddressAtPtx1757) + uint64_t(17408); // PTX L1758
	StoreNoAllocate(g_OutputByteAddressAtPtx1758,
					make_uint4(r_PackedHalf2AtPtx1196R700, r_PackedHalf2AtPtx1203R699,
							   r_PackedHalf2AtPtx1210R698, r_PackedHalf2AtPtx1217R697)); // PTX L1760
	r_LaneIndexAtPtx1763 = uint32_t((threadIdx.x & 31u));								 // PTX L1763
	r_PtxU64Register185 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1763)) * int64_t(int32_t(16))); // PTX L1765
	g_OutputByteAddressAtPtx1766 =
		uint64_t(g_OutputByteAddressAtPtx1693) + uint64_t(r_PtxU64Register185);				 // PTX L1766
	g_OutputByteAddressAtPtx1767 = uint64_t(g_OutputByteAddressAtPtx1766) + uint64_t(17920); // PTX L1767
	StoreNoAllocate(g_OutputByteAddressAtPtx1767,
					make_uint4(r_PackedHalf2AtPtx1224R696, r_PackedHalf2AtPtx1231R695,
							   r_PackedHalf2AtPtx1238R725, r_PackedHalf2AtPtx1245R726)); // PTX L1769
L__BB26_71:																				 // PTX L1771
	return;																				 // PTX L1772
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp16
