// Readable equivalent of cc_split_swin_16h_ffwd_proj_512; not historical source.
#pragma once
#include "window_ffn_projection_c512_abi_fp16.cuh"

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16
{
__global__ __maxnreg__(128) void window_ffn_projection_c512_fp16(Parameters r_Parameters)
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
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint32_t r_CtaZAtPtx21, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_HeightDiv4Bits, r_WidthDiv4Bits,
		r_ThreadYAtPtx42, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_HeightBits, r_WidthBits, r_CtaX, r_CtaYAtPtx20, r_PtxRegister46, r_PtxRegister47, r_PtxRegister48;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53,
		r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4, r_WidthSignBits, r_WidthDiv4Bias,
		r_WidthBiasedForDiv4, r_ThreadX;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx63R68, r_LaneIndexAtPtx79, r_LaneIndexAtPtx88,
		r_LaneIndexAtPtx98, r_LaneIndexAtPtx108;
	uint32_t r_LaneIndexAtPtx117, r_LaneIndexAtPtx126, r_LaneIndexAtPtx135, r_LaneIndexAtPtx144,
		r_PtxRegister77, r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82,
		r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_LaneIndexAtPtx222;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_LaneIndexAtPtx293, r_PtxRegister117, r_PtxRegister118,
		r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_LaneIndexAtPtx355, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_LaneIndexAtPtx416, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_LaneIndexAtPtx478, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_LaneIndexAtPtx539, r_PtxRegister183, r_PackedHalf2AtPtx65R184,
		r_PtxRegister185, r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189,
		r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_LaneIndexAtPtx593,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_LaneIndexAtPtx612, r_PtxRegister202,
		r_PtxRegister203, r_PtxRegister204;
	uint32_t r_LaneIndexAtPtx631, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_LaneIndexAtPtx650,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_LaneIndexAtPtx675, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_LaneIndexAtPtx694, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_LaneIndexAtPtx713,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_LaneIndexAtPtx732, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_LaneIndexAtPtx768, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_LaneIndexAtPtx787, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_LaneIndexAtPtx806, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_LaneIndexAtPtx825, r_PtxRegister244, r_PtxRegister245,
		r_PtxRegister246, r_LaneIndexAtPtx849, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_LaneIndexAtPtx868, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_LaneIndexAtPtx887, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_LaneIndexAtPtx906, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_LaneIndexAtPtx918, r_LaneIndexAtPtx932;
	uint32_t r_LaneIndexAtPtx946, r_LaneIndexAtPtx960, r_LaneIndexAtPtx974, r_LaneIndexAtPtx988,
		r_LaneIndexAtPtx1002, r_LaneIndexAtPtx1019, r_LaneIndexAtPtx1035, r_LaneIndexAtPtx1050,
		r_LaneIndexAtPtx1064, r_LaneIndexAtPtx1081, r_LaneIndexAtPtx1097, r_LaneIndexAtPtx1112;
	uint32_t r_LaneIndexAtPtx1126, r_LaneIndexAtPtx1143, r_LaneIndexAtPtx1159, r_LaneIndexAtPtx1173,
		r_LaneIndexAtPtx1187, r_LaneIndexAtPtx1201, r_LaneIndexAtPtx1215, r_LaneIndexAtPtx1229,
		r_LaneIndexAtPtx1243, r_LaneIndexAtPtx1259, r_LaneIndexAtPtx1275, r_LaneIndexAtPtx1289;
	uint32_t r_LaneIndexAtPtx1303, r_LaneIndexAtPtx1319, r_LaneIndexAtPtx1335, r_LaneIndexAtPtx1349,
		r_LaneIndexAtPtx1363, r_LaneIndexAtPtx1379, r_LaneIndexAtPtx1395, r_LaneIndexAtPtx1409,
		r_LaneIndexAtPtx1423, r_LaneIndexAtPtx1437, r_LaneIndexAtPtx1451, r_LaneIndexAtPtx1465;
	uint32_t r_LaneIndexAtPtx1479, r_LaneIndexAtPtx1495, r_LaneIndexAtPtx1511, r_LaneIndexAtPtx1525,
		r_LaneIndexAtPtx1539, r_LaneIndexAtPtx1555, r_LaneIndexAtPtx1571, r_LaneIndexAtPtx1585,
		r_LaneIndexAtPtx1599, r_LaneIndexAtPtx1615, r_LaneIndexAtPtx1631, r_LaneIndexAtPtx1645;
	uint32_t r_LaneIndexAtPtx1659, r_LaneIndexAtPtx1673, r_LaneIndexAtPtx1687, r_LaneIndexAtPtx1701,
		r_LaneIndexAtPtx1715, r_LaneIndexAtPtx1731, r_LaneIndexAtPtx1747, r_LaneIndexAtPtx1761,
		r_LaneIndexAtPtx1775, r_LaneIndexAtPtx1791, r_LaneIndexAtPtx1807, r_LaneIndexAtPtx1821;
	uint32_t r_LaneIndexAtPtx1835, r_LaneIndexAtPtx1851, r_LaneIndexAtPtx1867, r_PtxRegister328,
		r_LaneIndexAtPtx1874, r_PtxRegister330, r_LaneIndexAtPtx1881, r_PtxRegister332, r_LaneIndexAtPtx1888,
		r_PtxRegister334, r_LaneIndexAtPtx1895, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx1902, r_PtxRegister338, r_LaneIndexAtPtx1909, r_PtxRegister340,
		r_LaneIndexAtPtx1916, r_PtxRegister342, r_LaneIndexAtPtx1923, r_PtxRegister344, r_LaneIndexAtPtx1930,
		r_PtxRegister346, r_LaneIndexAtPtx1937, r_PtxRegister348;
	uint32_t r_LaneIndexAtPtx1944, r_PtxRegister350, r_LaneIndexAtPtx1951, r_PtxRegister352,
		r_LaneIndexAtPtx1958, r_PtxRegister354, r_LaneIndexAtPtx1965, r_PtxRegister356, r_LaneIndexAtPtx1972,
		r_PtxRegister358, r_LaneIndexAtPtx1979, r_PtxRegister360;
	uint32_t r_LaneIndexAtPtx1986, r_PtxRegister362, r_LaneIndexAtPtx1993, r_PtxRegister364,
		r_LaneIndexAtPtx2000, r_PtxRegister366, r_LaneIndexAtPtx2007, r_PtxRegister368, r_LaneIndexAtPtx2014,
		r_PtxRegister370, r_LaneIndexAtPtx2021, r_PtxRegister372;
	uint32_t r_LaneIndexAtPtx2028, r_PtxRegister374, r_LaneIndexAtPtx2035, r_PtxRegister376,
		r_LaneIndexAtPtx2042, r_PtxRegister378, r_LaneIndexAtPtx2049, r_PtxRegister380, r_LaneIndexAtPtx2056,
		r_PtxRegister382, r_LaneIndexAtPtx2063, r_PtxRegister384;
	uint32_t r_LaneIndexAtPtx2070, r_PtxRegister386, r_LaneIndexAtPtx2077, r_PtxRegister388,
		r_LaneIndexAtPtx2084, r_PtxRegister390, r_LaneIndexAtPtx2091, r_PtxRegister392, r_LaneIndexAtPtx2098,
		r_PtxRegister394, r_LaneIndexAtPtx2105, r_PtxRegister396;
	uint32_t r_LaneIndexAtPtx2112, r_PtxRegister398, r_LaneIndexAtPtx2119, r_PtxRegister400,
		r_LaneIndexAtPtx2126, r_PtxRegister402, r_LaneIndexAtPtx2133, r_PtxRegister404, r_LaneIndexAtPtx2140,
		r_PtxRegister406, r_LaneIndexAtPtx2147, r_PtxRegister408;
	uint32_t r_LaneIndexAtPtx2154, r_PtxRegister410, r_LaneIndexAtPtx2161, r_PtxRegister412,
		r_LaneIndexAtPtx2168, r_PtxRegister414, r_LaneIndexAtPtx2175, r_PtxRegister416, r_LaneIndexAtPtx2182,
		r_PtxRegister418, r_LaneIndexAtPtx2189, r_PtxRegister420;
	uint32_t r_LaneIndexAtPtx2196, r_PtxRegister422, r_LaneIndexAtPtx2203, r_PtxRegister424,
		r_LaneIndexAtPtx2210, r_PtxRegister426, r_LaneIndexAtPtx2217, r_PtxRegister428, r_LaneIndexAtPtx2224,
		r_PtxRegister430, r_LaneIndexAtPtx2231, r_PtxRegister432;
	uint32_t r_LaneIndexAtPtx2238, r_PtxRegister434, r_LaneIndexAtPtx2245, r_PtxRegister436,
		r_LaneIndexAtPtx2252, r_PtxRegister438, r_LaneIndexAtPtx2259, r_PtxRegister440, r_LaneIndexAtPtx2266,
		r_PtxRegister442, r_LaneIndexAtPtx2273, r_PtxRegister444;
	uint32_t r_LaneIndexAtPtx2280, r_PtxRegister446, r_LaneIndexAtPtx2287, r_PtxRegister448,
		r_LaneIndexAtPtx2294, r_PtxRegister450, r_LaneIndexAtPtx2301, r_PtxRegister452, r_LaneIndexAtPtx2308,
		r_PtxRegister454, r_PtxRegister455, r_PtxRegister456;
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
		r_PtxRegister546, r_PtxRegister547, r_PtxRegister548, r_PtxRegister549, r_PtxRegister550,
		r_PtxRegister551, r_PtxRegister552;
	uint32_t r_PtxRegister553, r_PtxRegister554, r_PtxRegister555, r_PtxRegister556, r_PtxRegister557,
		r_PtxRegister558, r_PtxRegister559, r_PtxRegister560, r_PtxRegister561, r_PtxRegister562,
		r_PtxRegister563, r_PtxRegister564;
	uint32_t r_PtxRegister565, r_PtxRegister566, r_PtxRegister567, r_PtxRegister568, r_PtxRegister569,
		r_PtxRegister570, r_PtxRegister571, r_PtxRegister572, r_PtxRegister573, r_PtxRegister574,
		r_PtxRegister575, r_PtxRegister576;
	uint32_t r_PtxRegister577, r_PtxRegister578, r_PtxRegister579, r_PtxRegister580, r_PtxRegister581,
		r_PtxRegister582, r_PtxRegister583, r_PtxRegister584, r_PtxRegister585, r_PtxRegister586,
		r_PtxRegister587, r_PtxRegister588;
	uint32_t r_PtxRegister589, r_PtxRegister590, r_PtxRegister591, r_PtxRegister592, r_PtxRegister593,
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
	uint32_t r_PtxRegister1021, r_LaneIndexAtPtx2327, r_PtxRegister1023, r_LaneIndexAtPtx2337,
		r_PtxRegister1025, r_LaneIndexAtPtx2346, r_PtxRegister1027, r_LaneIndexAtPtx2355, r_PtxRegister1029,
		r_LaneIndexAtPtx2364, r_PtxRegister1031, r_LaneIndexAtPtx2373;
	uint32_t r_PtxRegister1033, r_LaneIndexAtPtx2382, r_PtxRegister1035, r_LaneIndexAtPtx2391,
		r_PtxRegister1037, r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039,
		r_MmaAHalf2WordAtPtx2334R1040, r_MmaAHalf2WordAtPtx2334R1041, r_MmaAHalf2WordAtPtx2343R1042,
		r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044;
	uint32_t r_MmaAHalf2WordAtPtx2343R1045, r_MmaAccumulatorHalf2WordAtPtx2400R1046,
		r_MmaAccumulatorHalf2WordAtPtx2400R1047, r_MmaAccumulatorHalf2WordAtPtx2407R1048,
		r_MmaAccumulatorHalf2WordAtPtx2407R1049, r_MmaAccumulatorHalf2WordAtPtx2428R1050,
		r_MmaAccumulatorHalf2WordAtPtx2428R1051, r_MmaAccumulatorHalf2WordAtPtx2435R1052,
		r_MmaAccumulatorHalf2WordAtPtx2435R1053, r_MmaAccumulatorHalf2WordAtPtx2456R1054,
		r_MmaAccumulatorHalf2WordAtPtx2456R1055, r_MmaAccumulatorHalf2WordAtPtx2463R1056;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2463R1057, r_MmaAccumulatorHalf2WordAtPtx2484R1058,
		r_MmaAccumulatorHalf2WordAtPtx2484R1059, r_MmaAccumulatorHalf2WordAtPtx2491R1060,
		r_MmaAccumulatorHalf2WordAtPtx2491R1061, r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063,
		r_MmaAHalf2WordAtPtx2352R1064, r_MmaAHalf2WordAtPtx2352R1065, r_MmaAHalf2WordAtPtx2361R1066,
		r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068;
	uint32_t r_MmaAHalf2WordAtPtx2361R1069, r_MmaAccumulatorHalf2WordAtPtx2512R1070,
		r_MmaAccumulatorHalf2WordAtPtx2512R1071, r_MmaAccumulatorHalf2WordAtPtx2519R1072,
		r_MmaAccumulatorHalf2WordAtPtx2519R1073, r_MmaAccumulatorHalf2WordAtPtx2540R1074,
		r_MmaAccumulatorHalf2WordAtPtx2540R1075, r_MmaAccumulatorHalf2WordAtPtx2547R1076,
		r_MmaAccumulatorHalf2WordAtPtx2547R1077, r_MmaAccumulatorHalf2WordAtPtx2568R1078,
		r_MmaAccumulatorHalf2WordAtPtx2568R1079, r_MmaAccumulatorHalf2WordAtPtx2575R1080;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2575R1081, r_MmaAccumulatorHalf2WordAtPtx2596R1082,
		r_MmaAccumulatorHalf2WordAtPtx2596R1083, r_MmaAccumulatorHalf2WordAtPtx2603R1084,
		r_MmaAccumulatorHalf2WordAtPtx2603R1085, r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087,
		r_MmaAHalf2WordAtPtx2370R1088, r_MmaAHalf2WordAtPtx2370R1089, r_MmaAHalf2WordAtPtx2379R1090,
		r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092;
	uint32_t r_MmaAHalf2WordAtPtx2379R1093, r_MmaAccumulatorHalf2WordAtPtx2624R1094,
		r_MmaAccumulatorHalf2WordAtPtx2624R1095, r_MmaAccumulatorHalf2WordAtPtx2631R1096,
		r_MmaAccumulatorHalf2WordAtPtx2631R1097, r_MmaAccumulatorHalf2WordAtPtx2652R1098,
		r_MmaAccumulatorHalf2WordAtPtx2652R1099, r_MmaAccumulatorHalf2WordAtPtx2659R1100,
		r_MmaAccumulatorHalf2WordAtPtx2659R1101, r_MmaAccumulatorHalf2WordAtPtx2680R1102,
		r_MmaAccumulatorHalf2WordAtPtx2680R1103, r_MmaAccumulatorHalf2WordAtPtx2687R1104;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2687R1105, r_MmaAccumulatorHalf2WordAtPtx2708R1106,
		r_MmaAccumulatorHalf2WordAtPtx2708R1107, r_MmaAccumulatorHalf2WordAtPtx2715R1108,
		r_MmaAccumulatorHalf2WordAtPtx2715R1109, r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111,
		r_MmaAHalf2WordAtPtx2388R1112, r_MmaAHalf2WordAtPtx2388R1113, r_MmaAHalf2WordAtPtx2397R1114,
		r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116;
	uint32_t r_MmaAHalf2WordAtPtx2397R1117, r_MmaAccumulatorHalf2WordAtPtx2736R1118,
		r_MmaAccumulatorHalf2WordAtPtx2736R1119, r_MmaAccumulatorHalf2WordAtPtx2743R1120,
		r_MmaAccumulatorHalf2WordAtPtx2743R1121, r_MmaAccumulatorHalf2WordAtPtx2764R1122,
		r_MmaAccumulatorHalf2WordAtPtx2764R1123, r_MmaAccumulatorHalf2WordAtPtx2771R1124,
		r_MmaAccumulatorHalf2WordAtPtx2771R1125, r_MmaAccumulatorHalf2WordAtPtx2792R1126,
		r_MmaAccumulatorHalf2WordAtPtx2792R1127, r_MmaAccumulatorHalf2WordAtPtx2799R1128;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2799R1129, r_MmaAccumulatorHalf2WordAtPtx2820R1130,
		r_MmaAccumulatorHalf2WordAtPtx2820R1131, r_MmaAccumulatorHalf2WordAtPtx2827R1132,
		r_MmaAccumulatorHalf2WordAtPtx2827R1133, r_PtxRegister1134, r_PtxRegister1135, r_PtxRegister1136,
		r_PtxRegister1137, r_PtxRegister1138, r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_PtxRegister1141, r_PtxRegister1142, r_PtxRegister1143, r_PtxRegister1144, r_PtxRegister1145,
		r_PtxRegister1146, r_PtxRegister1147, r_PtxRegister1148, r_PtxRegister1149, r_PtxRegister1150,
		r_PtxRegister1151, r_PtxRegister1152;
	uint32_t r_LaneIndexAtPtx2857, r_LaneIndexAtPtx2865, r_LaneIndexAtPtx2874, r_LaneIndexAtPtx2883,
		r_LaneIndexAtPtx2892, r_LaneIndexAtPtx2901, r_LaneIndexAtPtx2910, r_LaneIndexAtPtx2919,
		r_PtxRegister1161, r_PtxRegister1162, r_PtxRegister1163, r_PtxRegister1164;
	uint32_t r_PtxRegister1165, r_PtxRegister1166, r_PtxRegister1167, r_PtxRegister1168, r_PtxRegister1169,
		r_PtxRegister1170, r_PtxRegister1171, r_PtxRegister1172, r_CtaZAtPtx2961, r_PtxRegister1174,
		r_PtxRegister1175, r_PtxRegister1176;
	uint32_t r_PtxRegister1177, r_PtxRegister1178, r_PtxRegister1179, r_PtxRegister1180, r_PtxRegister1181,
		r_PtxRegister1182, r_PtxRegister1183, r_PtxRegister1184, r_PtxRegister1185, r_LaneIndexAtPtx3020,
		r_PtxRegister1187, r_ThreadYAtPtx3022;
	uint32_t r_PtxRegister1189, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PtxRegister1194, r_PtxRegister1195, r_PtxRegister1196, r_PtxRegister1197, r_PtxRegister1198,
		r_ThreadYAtPtx3003, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_PtxRegister1202, r_PtxRegister1203, r_ThreadYAtPtx3034, r_PtxRegister1205,
		r_PtxRegister1206, r_CtaYAtPtx3037, r_PtxRegister1208, r_PtxRegister1209, r_PtxRegister1210,
		r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_LaneIndexAtPtx3099, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_PtxRegister1231, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_LaneIndexAtPtx3128, r_LaneIndexAtPtx3136,
		r_LaneIndexAtPtx3145, r_LaneIndexAtPtx3154, r_LaneIndexAtPtx3168;
	uint32_t r_LaneIndexAtPtx3177, r_LaneIndexAtPtx3186, r_LaneIndexAtPtx3195, r_PtxRegister1252,
		r_PtxRegister1253, r_PtxRegister1254, r_PtxRegister1255, r_LaneIndexAtPtx3216, r_LaneIndexAtPtx3224,
		r_LaneIndexAtPtx3233, r_LaneIndexAtPtx3242, r_LaneIndexAtPtx3255;
	uint32_t r_LaneIndexAtPtx3264, r_LaneIndexAtPtx3273, r_LaneIndexAtPtx3282, r_PtxRegister1264,
		r_PtxRegister1265, r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269,
		r_PackedHalf2AtPtx582R1270, r_PackedHalf2AtPtx583R1271, r_PackedHalf2AtPtx584R1272;
	uint32_t r_PackedHalf2AtPtx585R1273, r_PackedHalf2AtPtx601R1274, r_PackedHalf2AtPtx602R1275,
		r_PackedHalf2AtPtx603R1276, r_PackedHalf2AtPtx604R1277, r_PackedHalf2AtPtx620R1278,
		r_PackedHalf2AtPtx621R1279, r_PackedHalf2AtPtx622R1280, r_PackedHalf2AtPtx623R1281,
		r_PackedHalf2AtPtx639R1282, r_PackedHalf2AtPtx640R1283, r_PackedHalf2AtPtx641R1284;
	uint32_t r_PackedHalf2AtPtx642R1285, r_PackedHalf2AtPtx664R1286, r_PackedHalf2AtPtx665R1287,
		r_PackedHalf2AtPtx666R1288, r_PackedHalf2AtPtx667R1289, r_PackedHalf2AtPtx683R1290,
		r_PackedHalf2AtPtx684R1291, r_PackedHalf2AtPtx685R1292, r_PackedHalf2AtPtx686R1293,
		r_PackedHalf2AtPtx702R1294, r_PackedHalf2AtPtx703R1295, r_PackedHalf2AtPtx704R1296;
	uint32_t r_PackedHalf2AtPtx705R1297, r_PackedHalf2AtPtx721R1298, r_PackedHalf2AtPtx722R1299,
		r_PackedHalf2AtPtx723R1300, r_PackedHalf2AtPtx724R1301, r_PackedHalf2AtPtx757R1302,
		r_PackedHalf2AtPtx758R1303, r_PackedHalf2AtPtx759R1304, r_PackedHalf2AtPtx760R1305,
		r_PackedHalf2AtPtx776R1306, r_PackedHalf2AtPtx777R1307, r_PackedHalf2AtPtx778R1308;
	uint32_t r_PackedHalf2AtPtx779R1309, r_PackedHalf2AtPtx795R1310, r_PackedHalf2AtPtx796R1311,
		r_PackedHalf2AtPtx797R1312, r_PackedHalf2AtPtx798R1313, r_PackedHalf2AtPtx814R1314,
		r_PackedHalf2AtPtx815R1315, r_PackedHalf2AtPtx816R1316, r_PackedHalf2AtPtx817R1317,
		r_PackedHalf2AtPtx838R1318, r_PackedHalf2AtPtx839R1319, r_PackedHalf2AtPtx840R1320;
	uint32_t r_PackedHalf2AtPtx841R1321, r_PackedHalf2AtPtx857R1322, r_PackedHalf2AtPtx858R1323,
		r_PackedHalf2AtPtx859R1324, r_PackedHalf2AtPtx860R1325, r_PackedHalf2AtPtx876R1326,
		r_PackedHalf2AtPtx877R1327, r_PackedHalf2AtPtx878R1328, r_PackedHalf2AtPtx879R1329,
		r_PackedHalf2AtPtx895R1330, r_PackedHalf2AtPtx896R1331, r_PackedHalf2AtPtx897R1332;
	uint32_t r_PackedHalf2AtPtx898R1333, r_PackedHalf2AtPtx2297R1334, r_PackedHalf2AtPtx2290R1335,
		r_PackedHalf2AtPtx2283R1336, r_PackedHalf2AtPtx2276R1337, r_PackedHalf2AtPtx2269R1338,
		r_PackedHalf2AtPtx2262R1339, r_PackedHalf2AtPtx2255R1340, r_PackedHalf2AtPtx2248R1341,
		r_PackedHalf2AtPtx2241R1342, r_PackedHalf2AtPtx2234R1343, r_PackedHalf2AtPtx2227R1344;
	uint32_t r_PackedHalf2AtPtx2220R1345, r_PackedHalf2AtPtx2213R1346, r_PackedHalf2AtPtx2206R1347,
		r_PackedHalf2AtPtx2199R1348, r_PackedHalf2AtPtx2192R1349, r_PackedHalf2AtPtx2185R1350,
		r_PackedHalf2AtPtx2178R1351, r_PackedHalf2AtPtx2171R1352, r_PackedHalf2AtPtx2164R1353,
		r_PackedHalf2AtPtx2157R1354, r_PackedHalf2AtPtx2150R1355, r_PackedHalf2AtPtx2143R1356;
	uint32_t r_PackedHalf2AtPtx2136R1357, r_PackedHalf2AtPtx2129R1358, r_PackedHalf2AtPtx2122R1359,
		r_PackedHalf2AtPtx2115R1360, r_PackedHalf2AtPtx2108R1361, r_PackedHalf2AtPtx2101R1362,
		r_PackedHalf2AtPtx2094R1363, r_PackedHalf2AtPtx2087R1364, r_PackedHalf2AtPtx2080R1365,
		r_PackedHalf2AtPtx2073R1366, r_PackedHalf2AtPtx2066R1367, r_PackedHalf2AtPtx2059R1368;
	uint32_t r_PackedHalf2AtPtx2052R1369, r_PackedHalf2AtPtx2045R1370, r_PackedHalf2AtPtx2038R1371,
		r_PackedHalf2AtPtx2031R1372, r_PackedHalf2AtPtx2024R1373, r_PackedHalf2AtPtx2017R1374,
		r_PackedHalf2AtPtx2010R1375, r_PackedHalf2AtPtx2003R1376, r_PackedHalf2AtPtx1996R1377,
		r_PackedHalf2AtPtx1989R1378, r_PackedHalf2AtPtx1982R1379, r_PackedHalf2AtPtx1975R1380;
	uint32_t r_PackedHalf2AtPtx1968R1381, r_PackedHalf2AtPtx1961R1382, r_PackedHalf2AtPtx1954R1383,
		r_PackedHalf2AtPtx1947R1384, r_PackedHalf2AtPtx1940R1385, r_PackedHalf2AtPtx1933R1386,
		r_PackedHalf2AtPtx1926R1387, r_PackedHalf2AtPtx1919R1388, r_PackedHalf2AtPtx1912R1389,
		r_PackedHalf2AtPtx1905R1390, r_PackedHalf2AtPtx1898R1391, r_PackedHalf2AtPtx1891R1392;
	uint32_t r_PackedHalf2AtPtx1884R1393, r_PackedHalf2AtPtx1877R1394, r_PackedHalf2AtPtx1870R1395,
		r_PackedHalf2AtPtx2304R1396, r_PackedHalf2AtPtx2311R1397, r_PtxRegister1398,
		r_MmaBHalf2WordAtPtx150R1399, r_MmaBHalf2WordAtPtx150R1400, r_MmaBHalf2WordAtPtx150R1401,
		r_MmaBHalf2WordAtPtx150R1402, r_MmaBHalf2WordAtPtx141R1403, r_MmaBHalf2WordAtPtx141R1404;
	uint32_t r_MmaBHalf2WordAtPtx141R1405, r_MmaBHalf2WordAtPtx141R1406, r_MmaBHalf2WordAtPtx132R1407,
		r_MmaBHalf2WordAtPtx132R1408, r_MmaBHalf2WordAtPtx132R1409, r_MmaBHalf2WordAtPtx132R1410,
		r_MmaBHalf2WordAtPtx123R1411, r_MmaBHalf2WordAtPtx123R1412, r_MmaBHalf2WordAtPtx123R1413,
		r_MmaBHalf2WordAtPtx123R1414, r_MmaBHalf2WordAtPtx114R1415, r_MmaBHalf2WordAtPtx114R1416;
	uint32_t r_MmaBHalf2WordAtPtx114R1417, r_MmaBHalf2WordAtPtx114R1418, r_MmaBHalf2WordAtPtx104R1419,
		r_MmaBHalf2WordAtPtx104R1420, r_MmaBHalf2WordAtPtx104R1421, r_MmaBHalf2WordAtPtx104R1422,
		r_MmaBHalf2WordAtPtx94R1423, r_MmaBHalf2WordAtPtx94R1424, r_MmaBHalf2WordAtPtx94R1425,
		r_MmaBHalf2WordAtPtx94R1426, r_MmaBHalf2WordAtPtx84R1427, r_MmaBHalf2WordAtPtx84R1428;
	uint32_t r_MmaBHalf2WordAtPtx84R1429, r_MmaBHalf2WordAtPtx84R1430;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, g_OutputByteAddressAtPtx3124,
		g_OutputByteAddressAtPtx3212, g_OutputBaseAddress, g_RecordBaseAddress, g_RecordByteAddressAtPtx82,
		g_RecordByteAddressAtPtx92, g_RecordByteAddressAtPtx102, g_RecordByteAddressAtPtx112,
		g_RecordByteAddressAtPtx121, g_RecordByteAddressAtPtx130;
	uint64_t g_RecordByteAddressAtPtx139, g_RecordByteAddressAtPtx148, r_PtxU64Register15,
		g_RecordByteAddressAtPtx77, r_PtxU64Register17, r_PtxU64Register18, g_RecordByteAddressAtPtx91,
		r_PtxU64Register20, g_RecordByteAddressAtPtx101, r_PtxU64Register22, g_RecordByteAddressAtPtx111,
		r_PtxU64Register24;
	uint64_t g_RecordByteAddressAtPtx120, r_PtxU64Register26, g_RecordByteAddressAtPtx129, r_PtxU64Register28,
		g_RecordByteAddressAtPtx138, r_PtxU64Register30, g_RecordByteAddressAtPtx147, r_PtxU64Register32,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44,
		g_ResidualByteAddressAtPtx596, r_PtxU64Register46, g_ResidualByteAddressAtPtx591, r_PtxU64Register48;
	uint64_t g_ResidualByteAddressAtPtx615, r_PtxU64Register50, g_ResidualByteAddressAtPtx610,
		r_PtxU64Register52, g_ResidualByteAddressAtPtx634, r_PtxU64Register54, g_ResidualByteAddressAtPtx629,
		r_PtxU64Register56, g_ResidualByteAddressAtPtx653, r_PtxU64Register58, g_ResidualByteAddressAtPtx648,
		r_PtxU64Register60;
	uint64_t g_ResidualByteAddressAtPtx678, r_PtxU64Register62, g_ResidualByteAddressAtPtx673,
		r_PtxU64Register64, g_ResidualByteAddressAtPtx697, r_PtxU64Register66, g_ResidualByteAddressAtPtx692,
		r_PtxU64Register68, g_ResidualByteAddressAtPtx716, r_PtxU64Register70, g_ResidualByteAddressAtPtx711,
		r_PtxU64Register72;
	uint64_t g_ResidualByteAddressAtPtx735, r_PtxU64Register74, g_ResidualByteAddressAtPtx730,
		r_PtxU64Register76, g_ResidualByteAddressAtPtx771, r_PtxU64Register78, g_ResidualByteAddressAtPtx766,
		r_PtxU64Register80, g_ResidualByteAddressAtPtx790, r_PtxU64Register82, g_ResidualByteAddressAtPtx785,
		r_PtxU64Register84;
	uint64_t g_ResidualByteAddressAtPtx809, r_PtxU64Register86, g_ResidualByteAddressAtPtx804,
		r_PtxU64Register88, g_ResidualByteAddressAtPtx828, r_PtxU64Register90, g_ResidualByteAddressAtPtx823,
		r_PtxU64Register92, g_ResidualByteAddressAtPtx852, r_PtxU64Register94, g_ResidualByteAddressAtPtx847,
		r_PtxU64Register96;
	uint64_t g_ResidualByteAddressAtPtx871, r_PtxU64Register98, g_ResidualByteAddressAtPtx866,
		r_PtxU64Register100, g_ResidualByteAddressAtPtx890, r_PtxU64Register102,
		g_ResidualByteAddressAtPtx885, r_PtxU64Register104, g_ResidualByteAddressAtPtx909,
		r_PtxU64Register106, g_ResidualByteAddressAtPtx904, r_PtxU64Register108;
	uint64_t g_RecordByteAddressAtPtx914, r_PtxU64Register110, g_RecordByteAddressAtPtx929,
		r_PtxU64Register112, g_RecordByteAddressAtPtx943, r_PtxU64Register114, g_RecordByteAddressAtPtx957,
		r_PtxU64Register116, g_RecordByteAddressAtPtx971, r_PtxU64Register118, g_RecordByteAddressAtPtx985,
		r_PtxU64Register120;
	uint64_t g_RecordByteAddressAtPtx999, r_PtxU64Register122, g_RecordByteAddressAtPtx1016,
		r_PtxU64Register124, g_RecordByteAddressAtPtx1032, r_PtxU64Register126, g_RecordByteAddressAtPtx1047,
		r_PtxU64Register128, g_RecordByteAddressAtPtx1061, r_PtxU64Register130, g_RecordByteAddressAtPtx1078,
		r_PtxU64Register132;
	uint64_t g_RecordByteAddressAtPtx1094, r_PtxU64Register134, g_RecordByteAddressAtPtx1109,
		r_PtxU64Register136, g_RecordByteAddressAtPtx1123, r_PtxU64Register138, g_RecordByteAddressAtPtx1140,
		r_PtxU64Register140, g_RecordByteAddressAtPtx1156, r_PtxU64Register142, g_RecordByteAddressAtPtx1170,
		r_PtxU64Register144;
	uint64_t g_RecordByteAddressAtPtx1184, r_PtxU64Register146, g_RecordByteAddressAtPtx1198,
		r_PtxU64Register148, g_RecordByteAddressAtPtx1212, r_PtxU64Register150, g_RecordByteAddressAtPtx1226,
		r_PtxU64Register152, g_RecordByteAddressAtPtx1240, r_PtxU64Register154, g_RecordByteAddressAtPtx1256,
		r_PtxU64Register156;
	uint64_t g_RecordByteAddressAtPtx1272, r_PtxU64Register158, g_RecordByteAddressAtPtx1286,
		r_PtxU64Register160, g_RecordByteAddressAtPtx1300, r_PtxU64Register162, g_RecordByteAddressAtPtx1316,
		r_PtxU64Register164, g_RecordByteAddressAtPtx1332, r_PtxU64Register166, g_RecordByteAddressAtPtx1346,
		r_PtxU64Register168;
	uint64_t g_RecordByteAddressAtPtx1360, r_PtxU64Register170, g_RecordByteAddressAtPtx1376,
		r_PtxU64Register172, g_RecordByteAddressAtPtx1392, r_PtxU64Register174, g_RecordByteAddressAtPtx1406,
		r_PtxU64Register176, g_RecordByteAddressAtPtx1420, r_PtxU64Register178, g_RecordByteAddressAtPtx1434,
		r_PtxU64Register180;
	uint64_t g_RecordByteAddressAtPtx1448, r_PtxU64Register182, g_RecordByteAddressAtPtx1462,
		r_PtxU64Register184, g_RecordByteAddressAtPtx1476, r_PtxU64Register186, g_RecordByteAddressAtPtx1492,
		r_PtxU64Register188, g_RecordByteAddressAtPtx1508, r_PtxU64Register190, g_RecordByteAddressAtPtx1522,
		r_PtxU64Register192;
	uint64_t g_RecordByteAddressAtPtx1536, r_PtxU64Register194, g_RecordByteAddressAtPtx1552,
		r_PtxU64Register196, g_RecordByteAddressAtPtx1568, r_PtxU64Register198, g_RecordByteAddressAtPtx1582,
		r_PtxU64Register200, g_RecordByteAddressAtPtx1596, r_PtxU64Register202, g_RecordByteAddressAtPtx1612,
		r_PtxU64Register204;
	uint64_t g_RecordByteAddressAtPtx1628, r_PtxU64Register206, g_RecordByteAddressAtPtx1642,
		r_PtxU64Register208, g_RecordByteAddressAtPtx1656, r_PtxU64Register210, g_RecordByteAddressAtPtx1670,
		r_PtxU64Register212, g_RecordByteAddressAtPtx1684, r_PtxU64Register214, g_RecordByteAddressAtPtx1698,
		r_PtxU64Register216;
	uint64_t g_RecordByteAddressAtPtx1712, r_PtxU64Register218, g_RecordByteAddressAtPtx1728,
		r_PtxU64Register220, g_RecordByteAddressAtPtx1744, r_PtxU64Register222, g_RecordByteAddressAtPtx1758,
		r_PtxU64Register224, g_RecordByteAddressAtPtx1772, r_PtxU64Register226, g_RecordByteAddressAtPtx1788,
		r_PtxU64Register228;
	uint64_t g_RecordByteAddressAtPtx1804, r_PtxU64Register230, g_RecordByteAddressAtPtx1818,
		r_PtxU64Register232, g_RecordByteAddressAtPtx1832, r_PtxU64Register234, g_RecordByteAddressAtPtx1848,
		r_PtxU64Register236, g_RecordByteAddressAtPtx1864, g_RecordByteAddressAtPtx2860,
		g_RecordByteAddressAtPtx2869, g_RecordByteAddressAtPtx2878;
	uint64_t g_RecordByteAddressAtPtx2887, g_RecordByteAddressAtPtx2896, g_RecordByteAddressAtPtx2905,
		g_RecordByteAddressAtPtx2914, g_RecordByteAddressAtPtx2923, r_PtxU64Register246,
		g_RecordByteAddressAtPtx2855, r_PtxU64Register248, r_PtxU64Register249, g_RecordByteAddressAtPtx2868,
		r_PtxU64Register251, g_RecordByteAddressAtPtx2877;
	uint64_t r_PtxU64Register253, g_RecordByteAddressAtPtx2886, r_PtxU64Register255,
		g_RecordByteAddressAtPtx2895, r_PtxU64Register257, g_RecordByteAddressAtPtx2904, r_PtxU64Register259,
		g_RecordByteAddressAtPtx2913, r_PtxU64Register261, g_RecordByteAddressAtPtx2922, r_PtxU64Register263,
		r_PtxU64Register264;
	uint64_t r_PtxU64Register265, r_PtxU64Register266, r_PtxU64Register267, r_PtxU64Register268,
		g_OutputByteAddressAtPtx3131, g_OutputByteAddressAtPtx3140, g_OutputByteAddressAtPtx3149,
		g_OutputByteAddressAtPtx3158, r_PtxU64Register273, r_PtxU64Register274, g_OutputByteAddressAtPtx3139,
		r_PtxU64Register276;
	uint64_t g_OutputByteAddressAtPtx3148, r_PtxU64Register278, g_OutputByteAddressAtPtx3157,
		g_OutputByteAddressAtPtx3172, g_OutputByteAddressAtPtx3181, g_OutputByteAddressAtPtx3190,
		g_OutputByteAddressAtPtx3199, r_PtxU64Register284, g_OutputByteAddressAtPtx3171, r_PtxU64Register286,
		g_OutputByteAddressAtPtx3180, r_PtxU64Register288;
	uint64_t g_OutputByteAddressAtPtx3189, r_PtxU64Register290, g_OutputByteAddressAtPtx3198,
		r_PtxU64Register292, g_OutputByteAddressAtPtx3219, g_OutputByteAddressAtPtx3228,
		g_OutputByteAddressAtPtx3237, g_OutputByteAddressAtPtx3246, r_PtxU64Register297, r_PtxU64Register298,
		g_OutputByteAddressAtPtx3227, r_PtxU64Register300;
	uint64_t g_OutputByteAddressAtPtx3236, r_PtxU64Register302, g_OutputByteAddressAtPtx3245,
		g_OutputByteAddressAtPtx3259, g_OutputByteAddressAtPtx3268, g_OutputByteAddressAtPtx3277,
		g_OutputByteAddressAtPtx3286, r_PtxU64Register308, g_OutputByteAddressAtPtx3258, r_PtxU64Register310,
		g_OutputByteAddressAtPtx3267, r_PtxU64Register312;
	uint64_t g_OutputByteAddressAtPtx3276, r_PtxU64Register314, g_OutputByteAddressAtPtx3285,
		r_PtxU64Register316, r_PtxU64Register317, r_PtxU64Register318, r_PtxU64Register319,
		r_PtxU64Register320, r_PtxU64Register321, r_PtxU64Register322, r_PtxU64Register323,
		r_PtxU64Register324;
	uint64_t r_PtxU64Register325, r_PtxU64Register326, r_PtxU64Register327, r_PtxU64Register328,
		r_PtxU64Register329, r_PtxU64Register330, r_PtxU64Register331;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip); // PTX L16
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L17
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);									// PTX L18
	r_CtaX = uint32_t(blockIdx.x);												// PTX L19
	r_CtaYAtPtx20 = uint32_t(blockIdx.y);										// PTX L20
	r_CtaZAtPtx21 = uint32_t(blockIdx.z);										// PTX L21
	r_PtxRegister46 = uint32_t(r_WidthBits) + uint32_t(-1);						// PTX L22
	r_PtxRegister47 = ShiftRightSigned(int32_t(r_PtxRegister46), uint32_t(31)); // PTX L23
	r_PtxRegister48 = ShiftRight(uint32_t(r_PtxRegister47), uint32_t(29));		// PTX L24
	r_PtxRegister49 = uint32_t(r_PtxRegister46) + uint32_t(r_PtxRegister48);	// PTX L25
	r_PtxRegister50 = ShiftRightSigned(int32_t(r_PtxRegister49), uint32_t(3));	// PTX L26
	r_PtxRegister51 = uint32_t(r_PtxRegister50) + uint32_t(1);					// PTX L27
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister51));		// PTX L28
	r_PtxRegister52 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister50) + uint32_t(r_PtxRegister2); // PTX L29
	r_PtxRegister53 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister52);						 // PTX L30
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaYAtPtx20), uint32_t(1));					 // PTX L31
	r_PtxRegister4 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(1));					 // PTX L32
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));			 // PTX L33
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));			 // PTX L34
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);		 // PTX L35
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2));	 // PTX L36
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));				 // PTX L37
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));				 // PTX L38
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);			 // PTX L39
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));		 // PTX L40
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L41
	r_ThreadYAtPtx42 = uint32_t(threadIdx.y);											 // PTX L42
	r_PtxRegister61 = r_ThreadX | r_ThreadYAtPtx42;										 // PTX L43
	r_bPtxPredicate16 = uint32_t(r_PtxRegister61) != uint32_t(0);						 // PTX L44
	if (r_bPtxPredicate16)
	{
		goto L__BB12_2;
	} // PTX L45
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L46
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L47
	r_PtxRegister63 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L48
	r_PtxRegister62 = uint32_t(12288u /* exact native shared-region offset */); // PTX L49
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister62, r_PtxRegister63); // PTX L51
	r_PtxRegister64 = uint32_t(r_PtxRegister62) + uint32_t(8);		// PTX L53
	BarrierInit(s_SharedStorage, r_PtxRegister64, r_PtxRegister63); // PTX L55
	r_PtxRegister65 = uint32_t(r_PtxRegister62) + uint32_t(16);		// PTX L57
	BarrierInit(s_SharedStorage, r_PtxRegister65, r_PtxRegister63); // PTX L59
L__BB12_2:															// PTX L61
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L62
	r_Float32BitsAtPtx63R68 = uint32_t(0);														// PTX L63
	r_PackedHalf2AtPtx65R184 = FloatToHalf2(r_Float32BitsAtPtx63R68);							// PTX L65
	r_PtxRegister77 = ShiftLeft(uint32_t(r_ThreadYAtPtx42), uint32_t(6));						// PTX L70
	r_PtxRegister78 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));							// PTX L71
	r_PtxRegister8 = uint32_t(r_PtxRegister77) + uint32_t(r_PtxRegister78);						// PTX L72
	r_PtxRegister79 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(17));							// PTX L73
	r_PtxRegister9 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(3));							// PTX L74
	r_PtxRegister80 = uint32_t(r_PtxRegister79) + uint32_t(r_PtxRegister9);						// PTX L75
	r_PtxU64Register15 = uint64_t(int64_t(int32_t(r_PtxRegister80)) * int64_t(int32_t(4)));		// PTX L76
	g_RecordByteAddressAtPtx77 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register15);	// PTX L77
	r_LaneIndexAtPtx79 = uint32_t((threadIdx.x & 31u));											// PTX L79
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx79)) * int64_t(int32_t(16))); // PTX L81
	g_RecordByteAddressAtPtx82 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register17); // PTX L82
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx82));
		r_MmaBHalf2WordAtPtx84R1430 = r_Value.x;
		r_MmaBHalf2WordAtPtx84R1429 = r_Value.y;
		r_MmaBHalf2WordAtPtx84R1428 = r_Value.z;
		r_MmaBHalf2WordAtPtx84R1427 = r_Value.w;
	} // PTX L84
	r_PtxRegister10 = r_PtxRegister9 | 128;														// PTX L86
	r_LaneIndexAtPtx88 = uint32_t((threadIdx.x & 31u));											// PTX L88
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx88)) * int64_t(int32_t(16))); // PTX L90
	g_RecordByteAddressAtPtx91 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register18);		   // PTX L91
	g_RecordByteAddressAtPtx92 = uint64_t(g_RecordByteAddressAtPtx91) + uint64_t(512); // PTX L92
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx92));
		r_MmaBHalf2WordAtPtx94R1426 = r_Value.x;
		r_MmaBHalf2WordAtPtx94R1425 = r_Value.y;
		r_MmaBHalf2WordAtPtx94R1424 = r_Value.z;
		r_MmaBHalf2WordAtPtx94R1423 = r_Value.w;
	} // PTX L94
	r_PtxRegister11 = r_PtxRegister9 | 256;														// PTX L96
	r_LaneIndexAtPtx98 = uint32_t((threadIdx.x & 31u));											// PTX L98
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx98)) * int64_t(int32_t(16))); // PTX L100
	g_RecordByteAddressAtPtx101 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register20);			  // PTX L101
	g_RecordByteAddressAtPtx102 = uint64_t(g_RecordByteAddressAtPtx101) + uint64_t(1024); // PTX L102
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx102));
		r_MmaBHalf2WordAtPtx104R1422 = r_Value.x;
		r_MmaBHalf2WordAtPtx104R1421 = r_Value.y;
		r_MmaBHalf2WordAtPtx104R1420 = r_Value.z;
		r_MmaBHalf2WordAtPtx104R1419 = r_Value.w;
	} // PTX L104
	r_PtxRegister12 = r_PtxRegister9 | 384;														 // PTX L106
	r_LaneIndexAtPtx108 = uint32_t((threadIdx.x & 31u));										 // PTX L108
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx108)) * int64_t(int32_t(16))); // PTX L110
	g_RecordByteAddressAtPtx111 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register22);			  // PTX L111
	g_RecordByteAddressAtPtx112 = uint64_t(g_RecordByteAddressAtPtx111) + uint64_t(1536); // PTX L112
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx112));
		r_MmaBHalf2WordAtPtx114R1418 = r_Value.x;
		r_MmaBHalf2WordAtPtx114R1417 = r_Value.y;
		r_MmaBHalf2WordAtPtx114R1416 = r_Value.z;
		r_MmaBHalf2WordAtPtx114R1415 = r_Value.w;
	} // PTX L114
	r_LaneIndexAtPtx117 = uint32_t((threadIdx.x & 31u));										 // PTX L117
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx117)) * int64_t(int32_t(16))); // PTX L119
	g_RecordByteAddressAtPtx120 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register24);			   // PTX L120
	g_RecordByteAddressAtPtx121 = uint64_t(g_RecordByteAddressAtPtx120) + uint64_t(16384); // PTX L121
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx121));
		r_MmaBHalf2WordAtPtx123R1414 = r_Value.x;
		r_MmaBHalf2WordAtPtx123R1413 = r_Value.y;
		r_MmaBHalf2WordAtPtx123R1412 = r_Value.z;
		r_MmaBHalf2WordAtPtx123R1411 = r_Value.w;
	} // PTX L123
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_RecordByteAddressAtPtx129 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register26);			   // PTX L129
	g_RecordByteAddressAtPtx130 = uint64_t(g_RecordByteAddressAtPtx129) + uint64_t(16896); // PTX L130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx130));
		r_MmaBHalf2WordAtPtx132R1410 = r_Value.x;
		r_MmaBHalf2WordAtPtx132R1409 = r_Value.y;
		r_MmaBHalf2WordAtPtx132R1408 = r_Value.z;
		r_MmaBHalf2WordAtPtx132R1407 = r_Value.w;
	} // PTX L132
	r_LaneIndexAtPtx135 = uint32_t((threadIdx.x & 31u));										 // PTX L135
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx135)) * int64_t(int32_t(16))); // PTX L137
	g_RecordByteAddressAtPtx138 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register28);			   // PTX L138
	g_RecordByteAddressAtPtx139 = uint64_t(g_RecordByteAddressAtPtx138) + uint64_t(17408); // PTX L139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx139));
		r_MmaBHalf2WordAtPtx141R1406 = r_Value.x;
		r_MmaBHalf2WordAtPtx141R1405 = r_Value.y;
		r_MmaBHalf2WordAtPtx141R1404 = r_Value.z;
		r_MmaBHalf2WordAtPtx141R1403 = r_Value.w;
	} // PTX L141
	r_LaneIndexAtPtx144 = uint32_t((threadIdx.x & 31u));										 // PTX L144
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx144)) * int64_t(int32_t(16))); // PTX L146
	g_RecordByteAddressAtPtx147 =
		uint64_t(g_RecordByteAddressAtPtx77) + uint64_t(r_PtxU64Register30);			   // PTX L147
	g_RecordByteAddressAtPtx148 = uint64_t(g_RecordByteAddressAtPtx147) + uint64_t(17920); // PTX L148
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx148));
		r_MmaBHalf2WordAtPtx150R1402 = r_Value.x;
		r_MmaBHalf2WordAtPtx150R1401 = r_Value.y;
		r_MmaBHalf2WordAtPtx150R1400 = r_Value.z;
		r_MmaBHalf2WordAtPtx150R1399 = r_Value.w;
	} // PTX L150
	r_PtxRegister13 = r_ThreadYAtPtx42 & 1;									  // PTX L152
	r_PtxRegister81 = ShiftRight(uint32_t(r_ThreadYAtPtx42), uint32_t(1));	  // PTX L153
	r_PtxRegister82 = r_PtxRegister81 & 1;									  // PTX L154
	r_PtxRegister83 = ShiftRight(uint32_t(r_ThreadYAtPtx42), uint32_t(2));	  // PTX L155
	r_PtxRegister84 = ShiftLeft(uint32_t(r_PtxRegister83), uint32_t(9));	  // PTX L156
	r_PtxRegister85 = ShiftLeft(uint32_t(r_ThreadYAtPtx42), uint32_t(7));	  // PTX L157
	r_PtxRegister14 = r_PtxRegister85 & 256;								  // PTX L158
	r_PtxRegister86 = r_PtxRegister84 | r_PtxRegister14;					  // PTX L159
	r_PtxRegister15 = r_PtxRegister85 & 128;								  // PTX L160
	r_PtxRegister16 = r_PtxRegister86 | r_PtxRegister15;					  // PTX L161
	r_PtxRegister87 = uint32_t(r_PtxRegister83) + uint32_t(r_PtxRegister3);	  // PTX L162
	r_PtxRegister17 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister4);	  // PTX L163
	r_PtxRegister18 = r_HeightBits & -4;									  // PTX L164
	r_bPtxPredicate17 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L165
	r_bPtxPredicate18 = int32_t(r_PtxRegister87) < int32_t(r_HeightDiv4Bits); // PTX L166
	r_PtxRegister88 = uint32_t(r_PtxRegister87) * uint32_t(r_WidthDiv4Bits);  // PTX L167
	r_PtxRegister19 = r_bPtxPredicate17 ? 0 : r_PtxRegister88;				  // PTX L168
	r_bPtxPredicate1 = r_bPtxPredicate17 | r_bPtxPredicate18;				  // PTX L169
	r_bPtxPredicate103 = bool(0);											  // PTX L170
	r_bPtxPredicate19 = !r_bPtxPredicate1;									  // PTX L171
	r_PtxRegister1264 = uint32_t(r_PtxRegister17);							  // PTX L172
	if (r_bPtxPredicate19)
	{
		goto L__BB12_5;
	} // PTX L173
	r_PtxRegister89 = r_WidthBits & -4;							  // PTX L174
	r_bPtxPredicate20 = uint32_t(r_PtxRegister89) == uint32_t(4); // PTX L175
	r_bPtxPredicate103 = bool(-1);								  // PTX L176
	r_PtxRegister1264 = uint32_t(0);							  // PTX L177
	if (r_bPtxPredicate20)
	{
		goto L__BB12_5;
	} // PTX L178
	r_bPtxPredicate103 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L179
	r_PtxRegister1264 = uint32_t(r_PtxRegister17);							  // PTX L180
L__BB12_5:																	  // PTX L181
	r_PtxU64Register316 = uint64_t(0);										  // PTX L182
	r_bPtxPredicate21 = !r_bPtxPredicate103;								  // PTX L183
	if (r_bPtxPredicate21)
	{
		goto L__BB12_7;
	} // PTX L184
	r_PtxRegister90 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1264); // PTX L185
	r_PtxRegister91 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister90);	   // PTX L186
	r_PtxRegister92 = ShiftLeft(uint32_t(r_PtxRegister91), uint32_t(12));	   // PTX L187
	r_PtxRegister93 = r_PtxRegister92 | r_PtxRegister15;					   // PTX L188
	r_PtxU64Register316 = SignExtendWordBits(r_PtxRegister93);				   // PTX L189
L__BB12_7:																	   // PTX L190
	r_PtxU64Register317 = uint64_t(0);										   // PTX L191
	if (r_bPtxPredicate21)
	{
		goto L__BB12_9;
	} // PTX L192
	r_PtxU64Register32 = ShiftLeft(uint64_t(r_PtxU64Register316), uint32_t(2));		   // PTX L193
	r_PtxU64Register317 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register32); // PTX L194
L__BB12_9:																			   // PTX L195
	r_PtxRegister94 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));			   // PTX L196
	r_PtxRegister95 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L197
	r_PtxRegister20 = uint32_t(r_PtxRegister95) + uint32_t(r_PtxRegister94);		   // PTX L198
	if (r_bPtxPredicate21)
	{
		goto L__BB12_12;
	} // PTX L199
	r_PtxRegister100 = uint32_t(-1);							  // PTX L200
	r_PtxRegister99 = Elected(r_PtxRegister100);				  // PTX L202
	r_bPtxPredicate22 = uint32_t(r_PtxRegister99) == uint32_t(0); // PTX L208
	if (r_bPtxPredicate22)
	{
		goto L__BB12_13;
	} // PTX L209
	r_PtxU64Register33 = r_PtxU64Register317;									 // PTX L210
	r_PtxRegister102 = uint32_t(12288u /* exact native shared-region offset */); // PTX L211
	r_PtxRegister101 = uint32_t(512);											 // PTX L212
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister20, r_PtxU64Register33, r_PtxRegister101,
			 r_PtxRegister102);												 // PTX L214
	BarrierExpect(s_SharedStorage, r_PtxRegister102, r_PtxRegister101);		 // PTX L217
	goto L__BB12_13;														 // PTX L219
L__BB12_12:																	 // PTX L220
	r_LaneIndexAtPtx222 = uint32_t((threadIdx.x & 31u));					 // PTX L222
	r_PtxRegister98 = ShiftLeft(uint32_t(r_LaneIndexAtPtx222), uint32_t(4)); // PTX L224
	r_PtxRegister97 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister98); // PTX L225
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister97)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);								   // PTX L227
L__BB12_13:																	   // PTX L229
	r_bPtxPredicate23 = uint32_t(r_PtxRegister18) == uint32_t(4);			   // PTX L230
	r_PtxRegister103 = uint32_t(r_ThreadYAtPtx42) + uint32_t(4);			   // PTX L231
	r_PtxRegister104 = ShiftRight(uint32_t(r_PtxRegister103), uint32_t(2));	   // PTX L232
	r_PtxRegister105 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(9));	   // PTX L233
	r_PtxRegister106 = r_PtxRegister105 | r_PtxRegister14;					   // PTX L234
	r_PtxRegister21 = uint32_t(r_PtxRegister106) + uint32_t(r_PtxRegister15);  // PTX L235
	r_PtxRegister107 = uint32_t(r_PtxRegister104) + uint32_t(r_PtxRegister3);  // PTX L236
	r_bPtxPredicate24 = int32_t(r_PtxRegister107) < int32_t(r_HeightDiv4Bits); // PTX L237
	r_PtxRegister108 = uint32_t(r_PtxRegister107) * uint32_t(r_WidthDiv4Bits); // PTX L238
	r_PtxRegister22 = r_bPtxPredicate23 ? 0 : r_PtxRegister108;				   // PTX L239
	r_bPtxPredicate2 = r_bPtxPredicate23 | r_bPtxPredicate24;				   // PTX L240
	r_bPtxPredicate104 = bool(0);											   // PTX L241
	r_bPtxPredicate25 = !r_bPtxPredicate2;									   // PTX L242
	r_PtxRegister1265 = uint32_t(r_PtxRegister17);							   // PTX L243
	if (r_bPtxPredicate25)
	{
		goto L__BB12_16;
	} // PTX L244
	r_PtxRegister109 = r_WidthBits & -4;						   // PTX L245
	r_bPtxPredicate26 = uint32_t(r_PtxRegister109) == uint32_t(4); // PTX L246
	r_bPtxPredicate104 = bool(-1);								   // PTX L247
	r_PtxRegister1265 = uint32_t(0);							   // PTX L248
	if (r_bPtxPredicate26)
	{
		goto L__BB12_16;
	} // PTX L249
	r_bPtxPredicate104 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L250
	r_PtxRegister1265 = uint32_t(r_PtxRegister17);							  // PTX L251
L__BB12_16:																	  // PTX L252
	r_PtxU64Register318 = uint64_t(0);										  // PTX L253
	r_bPtxPredicate27 = !r_bPtxPredicate104;								  // PTX L254
	if (r_bPtxPredicate27)
	{
		goto L__BB12_18;
	} // PTX L255
	r_PtxRegister110 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister1265); // PTX L256
	r_PtxRegister111 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister110);	// PTX L257
	r_PtxRegister112 = ShiftLeft(uint32_t(r_PtxRegister111), uint32_t(12));		// PTX L258
	r_PtxRegister113 = r_PtxRegister112 | r_PtxRegister15;						// PTX L259
	r_PtxU64Register318 = SignExtendWordBits(r_PtxRegister113);					// PTX L260
L__BB12_18:																		// PTX L261
	r_PtxU64Register319 = uint64_t(0);											// PTX L262
	if (r_bPtxPredicate27)
	{
		goto L__BB12_20;
	} // PTX L263
	r_PtxU64Register34 = ShiftLeft(uint64_t(r_PtxU64Register318), uint32_t(2));		   // PTX L264
	r_PtxU64Register319 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register34); // PTX L265
L__BB12_20:																			   // PTX L266
	r_PtxRegister114 = ShiftLeft(uint32_t(r_PtxRegister21), uint32_t(2));			   // PTX L267
	r_PtxRegister115 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L268
	r_PtxRegister23 = uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister114);		   // PTX L269
	if (r_bPtxPredicate27)
	{
		goto L__BB12_23;
	} // PTX L270
	r_PtxRegister120 = uint32_t(-1);							   // PTX L271
	r_PtxRegister119 = Elected(r_PtxRegister120);				   // PTX L273
	r_bPtxPredicate28 = uint32_t(r_PtxRegister119) == uint32_t(0); // PTX L279
	if (r_bPtxPredicate28)
	{
		goto L__BB12_24;
	} // PTX L280
	r_PtxU64Register35 = r_PtxU64Register319;									 // PTX L281
	r_PtxRegister122 = uint32_t(12288u /* exact native shared-region offset */); // PTX L282
	r_PtxRegister121 = uint32_t(512);											 // PTX L283
	CopyBulk(s_SharedStorage, r_PtxRegister23, r_PtxU64Register35, r_PtxRegister121,
			 r_PtxRegister122);												   // PTX L285
	BarrierExpect(s_SharedStorage, r_PtxRegister122, r_PtxRegister121);		   // PTX L288
	goto L__BB12_24;														   // PTX L290
L__BB12_23:																	   // PTX L291
	r_LaneIndexAtPtx293 = uint32_t((threadIdx.x & 31u));					   // PTX L293
	r_PtxRegister118 = ShiftLeft(uint32_t(r_LaneIndexAtPtx293), uint32_t(4));  // PTX L295
	r_PtxRegister117 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister118); // PTX L296
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister117)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);							// PTX L298
L__BB12_24:																// PTX L300
	r_PtxRegister123 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(9)); // PTX L301
	r_PtxRegister24 = r_PtxRegister123 | 32;							// PTX L302
	r_bPtxPredicate105 = bool(0);										// PTX L303
	r_PtxRegister1266 = uint32_t(r_PtxRegister17);						// PTX L304
	if (r_bPtxPredicate19)
	{
		goto L__BB12_27;
	} // PTX L305
	r_PtxRegister124 = r_WidthBits & -4;						   // PTX L306
	r_bPtxPredicate29 = uint32_t(r_PtxRegister124) == uint32_t(4); // PTX L307
	r_bPtxPredicate105 = bool(-1);								   // PTX L308
	r_PtxRegister1266 = uint32_t(0);							   // PTX L309
	if (r_bPtxPredicate29)
	{
		goto L__BB12_27;
	} // PTX L310
	r_bPtxPredicate105 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L311
	r_PtxRegister1266 = uint32_t(r_PtxRegister17);							  // PTX L312
L__BB12_27:																	  // PTX L313
	r_PtxU64Register320 = uint64_t(0);										  // PTX L314
	r_bPtxPredicate30 = !r_bPtxPredicate105;								  // PTX L315
	if (r_bPtxPredicate30)
	{
		goto L__BB12_29;
	} // PTX L316
	r_PtxRegister125 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1266); // PTX L317
	r_PtxRegister126 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L318
	r_PtxRegister127 = uint32_t(r_PtxRegister126) + uint32_t(r_PtxRegister13);	// PTX L319
	r_PtxRegister128 = ShiftLeft(uint32_t(r_PtxRegister125), uint32_t(12));		// PTX L320
	r_PtxRegister129 = ShiftLeft(uint32_t(r_PtxRegister127), uint32_t(7));		// PTX L321
	r_PtxRegister130 = uint32_t(r_PtxRegister128) + uint32_t(r_PtxRegister129); // PTX L322
	r_PtxU64Register320 = SignExtendWordBits(r_PtxRegister130);					// PTX L323
L__BB12_29:																		// PTX L324
	r_PtxU64Register321 = uint64_t(0);											// PTX L325
	if (r_bPtxPredicate30)
	{
		goto L__BB12_31;
	} // PTX L326
	r_PtxU64Register36 = ShiftLeft(uint64_t(r_PtxU64Register320), uint32_t(2));		   // PTX L327
	r_PtxU64Register321 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register36); // PTX L328
L__BB12_31:																			   // PTX L329
	if (r_bPtxPredicate30)
	{
		goto L__BB12_34;
	} // PTX L330
	r_PtxRegister136 = uint32_t(-1);							   // PTX L331
	r_PtxRegister135 = Elected(r_PtxRegister136);				   // PTX L333
	r_bPtxPredicate31 = uint32_t(r_PtxRegister135) == uint32_t(0); // PTX L339
	if (r_bPtxPredicate31)
	{
		goto L__BB12_35;
	} // PTX L340
	r_PtxRegister137 = uint32_t(r_PtxRegister20) + uint32_t(4096);				 // PTX L341
	r_PtxU64Register37 = r_PtxU64Register321;									 // PTX L342
	r_PtxRegister140 = uint32_t(12288u /* exact native shared-region offset */); // PTX L343
	r_PtxRegister139 = uint32_t(r_PtxRegister140) + uint32_t(8);				 // PTX L344
	r_PtxRegister138 = uint32_t(512);											 // PTX L345
	CopyBulk(s_SharedStorage, r_PtxRegister137, r_PtxU64Register37, r_PtxRegister138,
			 r_PtxRegister139);												   // PTX L347
	BarrierExpect(s_SharedStorage, r_PtxRegister139, r_PtxRegister138);		   // PTX L350
	goto L__BB12_35;														   // PTX L352
L__BB12_34:																	   // PTX L353
	r_LaneIndexAtPtx355 = uint32_t((threadIdx.x & 31u));					   // PTX L355
	r_PtxRegister133 = ShiftLeft(uint32_t(r_LaneIndexAtPtx355), uint32_t(4));  // PTX L357
	r_PtxRegister134 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister133); // PTX L358
	r_PtxRegister132 = uint32_t(r_PtxRegister134) + uint32_t(4096);			   // PTX L359
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister132)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);	   // PTX L361
L__BB12_35:										   // PTX L363
	r_bPtxPredicate106 = bool(0);				   // PTX L364
	r_PtxRegister1267 = uint32_t(r_PtxRegister17); // PTX L365
	if (r_bPtxPredicate25)
	{
		goto L__BB12_38;
	} // PTX L366
	r_PtxRegister141 = r_WidthBits & -4;						   // PTX L367
	r_bPtxPredicate32 = uint32_t(r_PtxRegister141) == uint32_t(4); // PTX L368
	r_bPtxPredicate106 = bool(-1);								   // PTX L369
	r_PtxRegister1267 = uint32_t(0);							   // PTX L370
	if (r_bPtxPredicate32)
	{
		goto L__BB12_38;
	} // PTX L371
	r_bPtxPredicate106 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L372
	r_PtxRegister1267 = uint32_t(r_PtxRegister17);							  // PTX L373
L__BB12_38:																	  // PTX L374
	r_PtxU64Register322 = uint64_t(0);										  // PTX L375
	r_bPtxPredicate33 = !r_bPtxPredicate106;								  // PTX L376
	if (r_bPtxPredicate33)
	{
		goto L__BB12_40;
	} // PTX L377
	r_PtxRegister142 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister1267); // PTX L378
	r_PtxRegister143 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L379
	r_PtxRegister144 = uint32_t(r_PtxRegister143) + uint32_t(r_PtxRegister13);	// PTX L380
	r_PtxRegister145 = ShiftLeft(uint32_t(r_PtxRegister142), uint32_t(12));		// PTX L381
	r_PtxRegister146 = ShiftLeft(uint32_t(r_PtxRegister144), uint32_t(7));		// PTX L382
	r_PtxRegister147 = uint32_t(r_PtxRegister145) + uint32_t(r_PtxRegister146); // PTX L383
	r_PtxU64Register322 = SignExtendWordBits(r_PtxRegister147);					// PTX L384
L__BB12_40:																		// PTX L385
	r_PtxU64Register323 = uint64_t(0);											// PTX L386
	if (r_bPtxPredicate33)
	{
		goto L__BB12_42;
	} // PTX L387
	r_PtxU64Register38 = ShiftLeft(uint64_t(r_PtxU64Register322), uint32_t(2));		   // PTX L388
	r_PtxU64Register323 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register38); // PTX L389
L__BB12_42:																			   // PTX L390
	if (r_bPtxPredicate33)
	{
		goto L__BB12_45;
	} // PTX L391
	r_PtxRegister153 = uint32_t(-1);							   // PTX L392
	r_PtxRegister152 = Elected(r_PtxRegister153);				   // PTX L394
	r_bPtxPredicate34 = uint32_t(r_PtxRegister152) == uint32_t(0); // PTX L400
	if (r_bPtxPredicate34)
	{
		goto L__BB12_46;
	} // PTX L401
	r_PtxRegister154 = uint32_t(r_PtxRegister23) + uint32_t(4096);				 // PTX L402
	r_PtxU64Register39 = r_PtxU64Register323;									 // PTX L403
	r_PtxRegister157 = uint32_t(12288u /* exact native shared-region offset */); // PTX L404
	r_PtxRegister156 = uint32_t(r_PtxRegister157) + uint32_t(8);				 // PTX L405
	r_PtxRegister155 = uint32_t(512);											 // PTX L406
	CopyBulk(s_SharedStorage, r_PtxRegister154, r_PtxU64Register39, r_PtxRegister155,
			 r_PtxRegister156);												   // PTX L408
	BarrierExpect(s_SharedStorage, r_PtxRegister156, r_PtxRegister155);		   // PTX L411
	goto L__BB12_46;														   // PTX L413
L__BB12_45:																	   // PTX L414
	r_LaneIndexAtPtx416 = uint32_t((threadIdx.x & 31u));					   // PTX L416
	r_PtxRegister150 = ShiftLeft(uint32_t(r_LaneIndexAtPtx416), uint32_t(4));  // PTX L418
	r_PtxRegister151 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister150); // PTX L419
	r_PtxRegister149 = uint32_t(r_PtxRegister151) + uint32_t(4096);			   // PTX L420
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister149)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);					// PTX L422
L__BB12_46:														// PTX L424
	r_PtxRegister25 = uint32_t(r_PtxRegister24) + uint32_t(32); // PTX L425
	r_bPtxPredicate107 = bool(0);								// PTX L426
	r_PtxRegister1268 = uint32_t(r_PtxRegister17);				// PTX L427
	if (r_bPtxPredicate19)
	{
		goto L__BB12_49;
	} // PTX L428
	r_PtxRegister158 = r_WidthBits & -4;						   // PTX L429
	r_bPtxPredicate35 = uint32_t(r_PtxRegister158) == uint32_t(4); // PTX L430
	r_bPtxPredicate107 = bool(-1);								   // PTX L431
	r_PtxRegister1268 = uint32_t(0);							   // PTX L432
	if (r_bPtxPredicate35)
	{
		goto L__BB12_49;
	} // PTX L433
	r_bPtxPredicate107 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L434
	r_PtxRegister1268 = uint32_t(r_PtxRegister17);							  // PTX L435
L__BB12_49:																	  // PTX L436
	r_PtxU64Register324 = uint64_t(0);										  // PTX L437
	r_bPtxPredicate36 = !r_bPtxPredicate107;								  // PTX L438
	if (r_bPtxPredicate36)
	{
		goto L__BB12_51;
	} // PTX L439
	r_PtxRegister159 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1268); // PTX L440
	r_PtxRegister160 = ShiftRight(uint32_t(r_PtxRegister25), uint32_t(4));		// PTX L441
	r_PtxRegister161 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister13);	// PTX L442
	r_PtxRegister162 = ShiftLeft(uint32_t(r_PtxRegister159), uint32_t(12));		// PTX L443
	r_PtxRegister163 = ShiftLeft(uint32_t(r_PtxRegister161), uint32_t(7));		// PTX L444
	r_PtxRegister164 = uint32_t(r_PtxRegister162) + uint32_t(r_PtxRegister163); // PTX L445
	r_PtxU64Register324 = SignExtendWordBits(r_PtxRegister164);					// PTX L446
L__BB12_51:																		// PTX L447
	r_PtxU64Register325 = uint64_t(0);											// PTX L448
	if (r_bPtxPredicate36)
	{
		goto L__BB12_53;
	} // PTX L449
	r_PtxU64Register40 = ShiftLeft(uint64_t(r_PtxU64Register324), uint32_t(2));		   // PTX L450
	r_PtxU64Register325 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register40); // PTX L451
L__BB12_53:																			   // PTX L452
	if (r_bPtxPredicate36)
	{
		goto L__BB12_56;
	} // PTX L453
	r_PtxRegister170 = uint32_t(-1);							   // PTX L454
	r_PtxRegister169 = Elected(r_PtxRegister170);				   // PTX L456
	r_bPtxPredicate37 = uint32_t(r_PtxRegister169) == uint32_t(0); // PTX L462
	if (r_bPtxPredicate37)
	{
		goto L__BB12_57;
	} // PTX L463
	r_PtxRegister171 = uint32_t(r_PtxRegister20) + uint32_t(8192);				 // PTX L464
	r_PtxU64Register41 = r_PtxU64Register325;									 // PTX L465
	r_PtxRegister174 = uint32_t(12288u /* exact native shared-region offset */); // PTX L466
	r_PtxRegister173 = uint32_t(r_PtxRegister174) + uint32_t(16);				 // PTX L467
	r_PtxRegister172 = uint32_t(512);											 // PTX L468
	CopyBulk(s_SharedStorage, r_PtxRegister171, r_PtxU64Register41, r_PtxRegister172,
			 r_PtxRegister173);												   // PTX L470
	BarrierExpect(s_SharedStorage, r_PtxRegister173, r_PtxRegister172);		   // PTX L473
	goto L__BB12_57;														   // PTX L475
L__BB12_56:																	   // PTX L476
	r_LaneIndexAtPtx478 = uint32_t((threadIdx.x & 31u));					   // PTX L478
	r_PtxRegister167 = ShiftLeft(uint32_t(r_LaneIndexAtPtx478), uint32_t(4));  // PTX L480
	r_PtxRegister168 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister167); // PTX L481
	r_PtxRegister166 = uint32_t(r_PtxRegister168) + uint32_t(8192);			   // PTX L482
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister166)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);	   // PTX L484
L__BB12_57:										   // PTX L486
	r_bPtxPredicate108 = bool(0);				   // PTX L487
	r_PtxRegister1269 = uint32_t(r_PtxRegister17); // PTX L488
	if (r_bPtxPredicate25)
	{
		goto L__BB12_60;
	} // PTX L489
	r_PtxRegister175 = r_WidthBits & -4;						   // PTX L490
	r_bPtxPredicate38 = uint32_t(r_PtxRegister175) == uint32_t(4); // PTX L491
	r_bPtxPredicate108 = bool(-1);								   // PTX L492
	r_PtxRegister1269 = uint32_t(0);							   // PTX L493
	if (r_bPtxPredicate38)
	{
		goto L__BB12_60;
	} // PTX L494
	r_bPtxPredicate108 = int32_t(r_PtxRegister17) < int32_t(r_WidthDiv4Bits); // PTX L495
	r_PtxRegister1269 = uint32_t(r_PtxRegister17);							  // PTX L496
L__BB12_60:																	  // PTX L497
	r_PtxU64Register326 = uint64_t(0);										  // PTX L498
	r_bPtxPredicate39 = !r_bPtxPredicate108;								  // PTX L499
	if (r_bPtxPredicate39)
	{
		goto L__BB12_62;
	} // PTX L500
	r_PtxRegister176 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister1269); // PTX L501
	r_PtxRegister177 = ShiftRight(uint32_t(r_PtxRegister25), uint32_t(4));		// PTX L502
	r_PtxRegister178 = uint32_t(r_PtxRegister177) + uint32_t(r_PtxRegister13);	// PTX L503
	r_PtxRegister179 = ShiftLeft(uint32_t(r_PtxRegister176), uint32_t(12));		// PTX L504
	r_PtxRegister180 = ShiftLeft(uint32_t(r_PtxRegister178), uint32_t(7));		// PTX L505
	r_PtxRegister181 = uint32_t(r_PtxRegister179) + uint32_t(r_PtxRegister180); // PTX L506
	r_PtxU64Register326 = SignExtendWordBits(r_PtxRegister181);					// PTX L507
L__BB12_62:																		// PTX L508
	r_PtxU64Register327 = uint64_t(0);											// PTX L509
	if (r_bPtxPredicate39)
	{
		goto L__BB12_64;
	} // PTX L510
	r_PtxU64Register42 = ShiftLeft(uint64_t(r_PtxU64Register326), uint32_t(2));		   // PTX L511
	r_PtxU64Register327 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register42); // PTX L512
L__BB12_64:																			   // PTX L513
	if (r_bPtxPredicate39)
	{
		goto L__BB12_67;
	} // PTX L514
	r_PtxRegister188 = uint32_t(-1);							   // PTX L515
	r_PtxRegister187 = Elected(r_PtxRegister188);				   // PTX L517
	r_bPtxPredicate40 = uint32_t(r_PtxRegister187) == uint32_t(0); // PTX L523
	if (r_bPtxPredicate40)
	{
		goto L__BB12_68;
	} // PTX L524
	r_PtxRegister189 = uint32_t(r_PtxRegister23) + uint32_t(8192);				 // PTX L525
	r_PtxU64Register43 = r_PtxU64Register327;									 // PTX L526
	r_PtxRegister192 = uint32_t(12288u /* exact native shared-region offset */); // PTX L527
	r_PtxRegister191 = uint32_t(r_PtxRegister192) + uint32_t(16);				 // PTX L528
	r_PtxRegister190 = uint32_t(512);											 // PTX L529
	CopyBulk(s_SharedStorage, r_PtxRegister189, r_PtxU64Register43, r_PtxRegister190,
			 r_PtxRegister191);												   // PTX L531
	BarrierExpect(s_SharedStorage, r_PtxRegister191, r_PtxRegister190);		   // PTX L534
	goto L__BB12_68;														   // PTX L536
L__BB12_67:																	   // PTX L537
	r_LaneIndexAtPtx539 = uint32_t((threadIdx.x & 31u));					   // PTX L539
	r_PtxRegister185 = ShiftLeft(uint32_t(r_LaneIndexAtPtx539), uint32_t(4));  // PTX L541
	r_PtxRegister186 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister185); // PTX L542
	r_PtxRegister183 = uint32_t(r_PtxRegister186) + uint32_t(8192);			   // PTX L543
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister183)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);									 // PTX L545
L__BB12_68:																		 // PTX L547
	r_PtxRegister193 = uint32_t(12288u /* exact native shared-region offset */); // PTX L548
	r_PtxRegister194 = uint32_t(1);												 // PTX L549
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register44 = BarrierArrive(s_SharedStorage, r_PtxRegister193, r_PtxRegister194); // PTX L551
L__BB12_69:																					 // PTX L553
	r_PtxRegister196 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L554
	r_PtxRegister195 = BarrierReady(s_SharedStorage, r_PtxRegister196, r_PtxU64Register44);	 // PTX L556
	r_bPtxPredicate41 = uint32_t(r_PtxRegister195) == uint32_t(0);							 // PTX L562
	if (r_bPtxPredicate41)
	{
		goto L__BB12_69;
	} // PTX L563
	r_bPtxPredicate3 = uint32_t(r_PtxRegister18) != uint32_t(4);			  // PTX L564
	r_bPtxPredicate42 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L565
	r_PtxRegister26 = r_WidthBits & -4;										  // PTX L566
	r_bPtxPredicate43 = uint32_t(r_PtxRegister26) == uint32_t(4);			  // PTX L567
	r_bPtxPredicate44 = int32_t(r_PtxRegister3) < int32_t(r_HeightDiv4Bits);  // PTX L568
	r_bPtxPredicate45 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L569
	r_PtxRegister27 = uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits);	  // PTX L570
	r_PtxRegister28 = r_bPtxPredicate42 ? 0 : r_PtxRegister27;				  // PTX L571
	r_bPtxPredicate46 = r_bPtxPredicate3 & r_bPtxPredicate45;				  // PTX L572
	r_bPtxPredicate4 = r_bPtxPredicate42 | r_bPtxPredicate44;				  // PTX L573
	r_bPtxPredicate5 = r_bPtxPredicate46 | r_bPtxPredicate43;				  // PTX L574
	r_bPtxPredicate47 = int32_t(r_PtxRegister4) < int32_t(r_WidthDiv4Bits);	  // PTX L575
	r_bPtxPredicate48 = !r_bPtxPredicate46;									  // PTX L576
	r_bPtxPredicate6 = r_bPtxPredicate43 & r_bPtxPredicate48;				  // PTX L577
	r_PtxRegister29 = r_bPtxPredicate6 ? 0 : r_PtxRegister4;				  // PTX L578
	r_bPtxPredicate49 = r_bPtxPredicate5 | r_bPtxPredicate47;				  // PTX L579
	r_bPtxPredicate7 = r_bPtxPredicate49 & r_bPtxPredicate4;				  // PTX L580
	r_bPtxPredicate50 = !r_bPtxPredicate7;									  // PTX L581
	r_PackedHalf2AtPtx582R1270 = uint32_t(r_PackedHalf2AtPtx65R184);		  // PTX L582
	r_PackedHalf2AtPtx583R1271 = uint32_t(r_PackedHalf2AtPtx65R184);		  // PTX L583
	r_PackedHalf2AtPtx584R1272 = uint32_t(r_PackedHalf2AtPtx65R184);		  // PTX L584
	r_PackedHalf2AtPtx585R1273 = uint32_t(r_PackedHalf2AtPtx65R184);		  // PTX L585
	if (r_bPtxPredicate50)
	{
		goto L__BB12_72;
	} // PTX L586
	r_PtxRegister198 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);				 // PTX L587
	r_PtxRegister199 = ShiftLeft(uint32_t(r_PtxRegister198), uint32_t(12));					 // PTX L588
	r_PtxRegister200 = uint32_t(r_PtxRegister199) + uint32_t(r_PtxRegister9);				 // PTX L589
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister200)) * int64_t(int32_t(4))); // PTX L590
	g_ResidualByteAddressAtPtx591 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register46);							 // PTX L591
	r_LaneIndexAtPtx593 = uint32_t((threadIdx.x & 31u));										 // PTX L593
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx593)) * int64_t(int32_t(16))); // PTX L595
	g_ResidualByteAddressAtPtx596 =
		uint64_t(g_ResidualByteAddressAtPtx591) + uint64_t(r_PtxU64Register48); // PTX L596
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx596));
		r_PackedHalf2AtPtx582R1270 = r_Value.x;
		r_PackedHalf2AtPtx583R1271 = r_Value.y;
		r_PackedHalf2AtPtx584R1272 = r_Value.z;
		r_PackedHalf2AtPtx585R1273 = r_Value.w;
	} // PTX L598
L__BB12_72:															 // PTX L600
	r_PackedHalf2AtPtx601R1274 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L601
	r_PackedHalf2AtPtx602R1275 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L602
	r_PackedHalf2AtPtx603R1276 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L603
	r_PackedHalf2AtPtx604R1277 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L604
	if (r_bPtxPredicate50)
	{
		goto L__BB12_74;
	} // PTX L605
	r_PtxRegister202 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);				 // PTX L606
	r_PtxRegister203 = ShiftLeft(uint32_t(r_PtxRegister202), uint32_t(12));					 // PTX L607
	r_PtxRegister204 = uint32_t(r_PtxRegister203) + uint32_t(r_PtxRegister10);				 // PTX L608
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister204)) * int64_t(int32_t(4))); // PTX L609
	g_ResidualByteAddressAtPtx610 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register50);							 // PTX L610
	r_LaneIndexAtPtx612 = uint32_t((threadIdx.x & 31u));										 // PTX L612
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx612)) * int64_t(int32_t(16))); // PTX L614
	g_ResidualByteAddressAtPtx615 =
		uint64_t(g_ResidualByteAddressAtPtx610) + uint64_t(r_PtxU64Register52); // PTX L615
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx615));
		r_PackedHalf2AtPtx601R1274 = r_Value.x;
		r_PackedHalf2AtPtx602R1275 = r_Value.y;
		r_PackedHalf2AtPtx603R1276 = r_Value.z;
		r_PackedHalf2AtPtx604R1277 = r_Value.w;
	} // PTX L617
L__BB12_74:															 // PTX L619
	r_PackedHalf2AtPtx620R1278 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L620
	r_PackedHalf2AtPtx621R1279 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L621
	r_PackedHalf2AtPtx622R1280 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L622
	r_PackedHalf2AtPtx623R1281 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L623
	if (r_bPtxPredicate50)
	{
		goto L__BB12_76;
	} // PTX L624
	r_PtxRegister206 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);				 // PTX L625
	r_PtxRegister207 = ShiftLeft(uint32_t(r_PtxRegister206), uint32_t(12));					 // PTX L626
	r_PtxRegister208 = uint32_t(r_PtxRegister207) + uint32_t(r_PtxRegister11);				 // PTX L627
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister208)) * int64_t(int32_t(4))); // PTX L628
	g_ResidualByteAddressAtPtx629 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register54);							 // PTX L629
	r_LaneIndexAtPtx631 = uint32_t((threadIdx.x & 31u));										 // PTX L631
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx631)) * int64_t(int32_t(16))); // PTX L633
	g_ResidualByteAddressAtPtx634 =
		uint64_t(g_ResidualByteAddressAtPtx629) + uint64_t(r_PtxU64Register56); // PTX L634
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx634));
		r_PackedHalf2AtPtx620R1278 = r_Value.x;
		r_PackedHalf2AtPtx621R1279 = r_Value.y;
		r_PackedHalf2AtPtx622R1280 = r_Value.z;
		r_PackedHalf2AtPtx623R1281 = r_Value.w;
	} // PTX L636
L__BB12_76:															 // PTX L638
	r_PackedHalf2AtPtx639R1282 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L639
	r_PackedHalf2AtPtx640R1283 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L640
	r_PackedHalf2AtPtx641R1284 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L641
	r_PackedHalf2AtPtx642R1285 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L642
	if (r_bPtxPredicate50)
	{
		goto L__BB12_78;
	} // PTX L643
	r_PtxRegister210 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);				 // PTX L644
	r_PtxRegister211 = ShiftLeft(uint32_t(r_PtxRegister210), uint32_t(12));					 // PTX L645
	r_PtxRegister212 = uint32_t(r_PtxRegister211) + uint32_t(r_PtxRegister12);				 // PTX L646
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister212)) * int64_t(int32_t(4))); // PTX L647
	g_ResidualByteAddressAtPtx648 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register58);							 // PTX L648
	r_LaneIndexAtPtx650 = uint32_t((threadIdx.x & 31u));										 // PTX L650
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx650)) * int64_t(int32_t(16))); // PTX L652
	g_ResidualByteAddressAtPtx653 =
		uint64_t(g_ResidualByteAddressAtPtx648) + uint64_t(r_PtxU64Register60); // PTX L653
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx653));
		r_PackedHalf2AtPtx639R1282 = r_Value.x;
		r_PackedHalf2AtPtx640R1283 = r_Value.y;
		r_PackedHalf2AtPtx641R1284 = r_Value.z;
		r_PackedHalf2AtPtx642R1285 = r_Value.w;
	} // PTX L655
L__BB12_78:																	 // PTX L657
	r_PtxRegister30 = uint32_t(r_PtxRegister4) + uint32_t(1);				 // PTX L658
	r_bPtxPredicate51 = int32_t(r_PtxRegister30) < int32_t(r_WidthDiv4Bits); // PTX L659
	r_PtxRegister31 = r_bPtxPredicate6 ? 0 : r_PtxRegister30;				 // PTX L660
	r_bPtxPredicate52 = r_bPtxPredicate5 | r_bPtxPredicate51;				 // PTX L661
	r_bPtxPredicate8 = r_bPtxPredicate52 & r_bPtxPredicate4;				 // PTX L662
	r_bPtxPredicate53 = !r_bPtxPredicate8;									 // PTX L663
	r_PackedHalf2AtPtx664R1286 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L664
	r_PackedHalf2AtPtx665R1287 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L665
	r_PackedHalf2AtPtx666R1288 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L666
	r_PackedHalf2AtPtx667R1289 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L667
	if (r_bPtxPredicate53)
	{
		goto L__BB12_80;
	} // PTX L668
	r_PtxRegister214 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);				 // PTX L669
	r_PtxRegister215 = ShiftLeft(uint32_t(r_PtxRegister214), uint32_t(12));					 // PTX L670
	r_PtxRegister216 = uint32_t(r_PtxRegister215) + uint32_t(r_PtxRegister9);				 // PTX L671
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister216)) * int64_t(int32_t(4))); // PTX L672
	g_ResidualByteAddressAtPtx673 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register62);							 // PTX L673
	r_LaneIndexAtPtx675 = uint32_t((threadIdx.x & 31u));										 // PTX L675
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx675)) * int64_t(int32_t(16))); // PTX L677
	g_ResidualByteAddressAtPtx678 =
		uint64_t(g_ResidualByteAddressAtPtx673) + uint64_t(r_PtxU64Register64); // PTX L678
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx678));
		r_PackedHalf2AtPtx664R1286 = r_Value.x;
		r_PackedHalf2AtPtx665R1287 = r_Value.y;
		r_PackedHalf2AtPtx666R1288 = r_Value.z;
		r_PackedHalf2AtPtx667R1289 = r_Value.w;
	} // PTX L680
L__BB12_80:															 // PTX L682
	r_PackedHalf2AtPtx683R1290 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L683
	r_PackedHalf2AtPtx684R1291 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L684
	r_PackedHalf2AtPtx685R1292 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L685
	r_PackedHalf2AtPtx686R1293 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L686
	if (r_bPtxPredicate53)
	{
		goto L__BB12_82;
	} // PTX L687
	r_PtxRegister218 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);				 // PTX L688
	r_PtxRegister219 = ShiftLeft(uint32_t(r_PtxRegister218), uint32_t(12));					 // PTX L689
	r_PtxRegister220 = uint32_t(r_PtxRegister219) + uint32_t(r_PtxRegister10);				 // PTX L690
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister220)) * int64_t(int32_t(4))); // PTX L691
	g_ResidualByteAddressAtPtx692 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register66);							 // PTX L692
	r_LaneIndexAtPtx694 = uint32_t((threadIdx.x & 31u));										 // PTX L694
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx694)) * int64_t(int32_t(16))); // PTX L696
	g_ResidualByteAddressAtPtx697 =
		uint64_t(g_ResidualByteAddressAtPtx692) + uint64_t(r_PtxU64Register68); // PTX L697
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx697));
		r_PackedHalf2AtPtx683R1290 = r_Value.x;
		r_PackedHalf2AtPtx684R1291 = r_Value.y;
		r_PackedHalf2AtPtx685R1292 = r_Value.z;
		r_PackedHalf2AtPtx686R1293 = r_Value.w;
	} // PTX L699
L__BB12_82:															 // PTX L701
	r_PackedHalf2AtPtx702R1294 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L702
	r_PackedHalf2AtPtx703R1295 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L703
	r_PackedHalf2AtPtx704R1296 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L704
	r_PackedHalf2AtPtx705R1297 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L705
	if (r_bPtxPredicate53)
	{
		goto L__BB12_84;
	} // PTX L706
	r_PtxRegister222 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);				 // PTX L707
	r_PtxRegister223 = ShiftLeft(uint32_t(r_PtxRegister222), uint32_t(12));					 // PTX L708
	r_PtxRegister224 = uint32_t(r_PtxRegister223) + uint32_t(r_PtxRegister11);				 // PTX L709
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister224)) * int64_t(int32_t(4))); // PTX L710
	g_ResidualByteAddressAtPtx711 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register70);							 // PTX L711
	r_LaneIndexAtPtx713 = uint32_t((threadIdx.x & 31u));										 // PTX L713
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx713)) * int64_t(int32_t(16))); // PTX L715
	g_ResidualByteAddressAtPtx716 =
		uint64_t(g_ResidualByteAddressAtPtx711) + uint64_t(r_PtxU64Register72); // PTX L716
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx716));
		r_PackedHalf2AtPtx702R1294 = r_Value.x;
		r_PackedHalf2AtPtx703R1295 = r_Value.y;
		r_PackedHalf2AtPtx704R1296 = r_Value.z;
		r_PackedHalf2AtPtx705R1297 = r_Value.w;
	} // PTX L718
L__BB12_84:															 // PTX L720
	r_PackedHalf2AtPtx721R1298 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L721
	r_PackedHalf2AtPtx722R1299 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L722
	r_PackedHalf2AtPtx723R1300 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L723
	r_PackedHalf2AtPtx724R1301 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L724
	if (r_bPtxPredicate53)
	{
		goto L__BB12_86;
	} // PTX L725
	r_PtxRegister226 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);				 // PTX L726
	r_PtxRegister227 = ShiftLeft(uint32_t(r_PtxRegister226), uint32_t(12));					 // PTX L727
	r_PtxRegister228 = uint32_t(r_PtxRegister227) + uint32_t(r_PtxRegister12);				 // PTX L728
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister228)) * int64_t(int32_t(4))); // PTX L729
	g_ResidualByteAddressAtPtx730 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register74);							 // PTX L730
	r_LaneIndexAtPtx732 = uint32_t((threadIdx.x & 31u));										 // PTX L732
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx732)) * int64_t(int32_t(16))); // PTX L734
	g_ResidualByteAddressAtPtx735 =
		uint64_t(g_ResidualByteAddressAtPtx730) + uint64_t(r_PtxU64Register76); // PTX L735
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx735));
		r_PackedHalf2AtPtx721R1298 = r_Value.x;
		r_PackedHalf2AtPtx722R1299 = r_Value.y;
		r_PackedHalf2AtPtx723R1300 = r_Value.z;
		r_PackedHalf2AtPtx724R1301 = r_Value.w;
	} // PTX L737
L__BB12_86:																		// PTX L739
	r_bPtxPredicate54 = int32_t(r_PtxRegister4) < int32_t(r_WidthDiv4Bits);		// PTX L740
	r_bPtxPredicate55 = uint32_t(r_PtxRegister26) == uint32_t(4);				// PTX L741
	r_bPtxPredicate56 = uint32_t(r_PtxRegister18) == uint32_t(4);				// PTX L742
	r_PtxRegister229 = uint32_t(r_PtxRegister3) + uint32_t(1);					// PTX L743
	r_bPtxPredicate57 = int32_t(r_PtxRegister229) < int32_t(r_HeightDiv4Bits);	// PTX L744
	r_bPtxPredicate58 = int32_t(r_PtxRegister229) >= int32_t(r_HeightDiv4Bits); // PTX L745
	r_PtxRegister230 = uint32_t(r_PtxRegister27) + uint32_t(r_WidthDiv4Bits);	// PTX L746
	r_PtxRegister32 = r_bPtxPredicate56 ? 0 : r_PtxRegister230;					// PTX L747
	r_bPtxPredicate59 = r_bPtxPredicate3 & r_bPtxPredicate58;					// PTX L748
	r_bPtxPredicate9 = r_bPtxPredicate56 | r_bPtxPredicate57;					// PTX L749
	r_bPtxPredicate10 = r_bPtxPredicate59 | r_bPtxPredicate55;					// PTX L750
	r_bPtxPredicate60 = !r_bPtxPredicate59;										// PTX L751
	r_bPtxPredicate11 = r_bPtxPredicate55 & r_bPtxPredicate60;					// PTX L752
	r_PtxRegister33 = r_bPtxPredicate11 ? 0 : r_PtxRegister4;					// PTX L753
	r_bPtxPredicate61 = r_bPtxPredicate10 | r_bPtxPredicate54;					// PTX L754
	r_bPtxPredicate12 = r_bPtxPredicate61 & r_bPtxPredicate9;					// PTX L755
	r_bPtxPredicate62 = !r_bPtxPredicate12;										// PTX L756
	r_PackedHalf2AtPtx757R1302 = uint32_t(r_PackedHalf2AtPtx65R184);			// PTX L757
	r_PackedHalf2AtPtx758R1303 = uint32_t(r_PackedHalf2AtPtx65R184);			// PTX L758
	r_PackedHalf2AtPtx759R1304 = uint32_t(r_PackedHalf2AtPtx65R184);			// PTX L759
	r_PackedHalf2AtPtx760R1305 = uint32_t(r_PackedHalf2AtPtx65R184);			// PTX L760
	if (r_bPtxPredicate62)
	{
		goto L__BB12_88;
	} // PTX L761
	r_PtxRegister232 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);				 // PTX L762
	r_PtxRegister233 = ShiftLeft(uint32_t(r_PtxRegister232), uint32_t(12));					 // PTX L763
	r_PtxRegister234 = uint32_t(r_PtxRegister233) + uint32_t(r_PtxRegister9);				 // PTX L764
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister234)) * int64_t(int32_t(4))); // PTX L765
	g_ResidualByteAddressAtPtx766 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register78);							 // PTX L766
	r_LaneIndexAtPtx768 = uint32_t((threadIdx.x & 31u));										 // PTX L768
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx768)) * int64_t(int32_t(16))); // PTX L770
	g_ResidualByteAddressAtPtx771 =
		uint64_t(g_ResidualByteAddressAtPtx766) + uint64_t(r_PtxU64Register80); // PTX L771
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx771));
		r_PackedHalf2AtPtx757R1302 = r_Value.x;
		r_PackedHalf2AtPtx758R1303 = r_Value.y;
		r_PackedHalf2AtPtx759R1304 = r_Value.z;
		r_PackedHalf2AtPtx760R1305 = r_Value.w;
	} // PTX L773
L__BB12_88:															 // PTX L775
	r_PackedHalf2AtPtx776R1306 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L776
	r_PackedHalf2AtPtx777R1307 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L777
	r_PackedHalf2AtPtx778R1308 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L778
	r_PackedHalf2AtPtx779R1309 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L779
	if (r_bPtxPredicate62)
	{
		goto L__BB12_90;
	} // PTX L780
	r_PtxRegister236 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);				 // PTX L781
	r_PtxRegister237 = ShiftLeft(uint32_t(r_PtxRegister236), uint32_t(12));					 // PTX L782
	r_PtxRegister238 = uint32_t(r_PtxRegister237) + uint32_t(r_PtxRegister10);				 // PTX L783
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister238)) * int64_t(int32_t(4))); // PTX L784
	g_ResidualByteAddressAtPtx785 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register82);							 // PTX L785
	r_LaneIndexAtPtx787 = uint32_t((threadIdx.x & 31u));										 // PTX L787
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx787)) * int64_t(int32_t(16))); // PTX L789
	g_ResidualByteAddressAtPtx790 =
		uint64_t(g_ResidualByteAddressAtPtx785) + uint64_t(r_PtxU64Register84); // PTX L790
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx790));
		r_PackedHalf2AtPtx776R1306 = r_Value.x;
		r_PackedHalf2AtPtx777R1307 = r_Value.y;
		r_PackedHalf2AtPtx778R1308 = r_Value.z;
		r_PackedHalf2AtPtx779R1309 = r_Value.w;
	} // PTX L792
L__BB12_90:															 // PTX L794
	r_PackedHalf2AtPtx795R1310 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L795
	r_PackedHalf2AtPtx796R1311 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L796
	r_PackedHalf2AtPtx797R1312 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L797
	r_PackedHalf2AtPtx798R1313 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L798
	if (r_bPtxPredicate62)
	{
		goto L__BB12_92;
	} // PTX L799
	r_PtxRegister240 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);				 // PTX L800
	r_PtxRegister241 = ShiftLeft(uint32_t(r_PtxRegister240), uint32_t(12));					 // PTX L801
	r_PtxRegister242 = uint32_t(r_PtxRegister241) + uint32_t(r_PtxRegister11);				 // PTX L802
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister242)) * int64_t(int32_t(4))); // PTX L803
	g_ResidualByteAddressAtPtx804 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register86);							 // PTX L804
	r_LaneIndexAtPtx806 = uint32_t((threadIdx.x & 31u));										 // PTX L806
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx806)) * int64_t(int32_t(16))); // PTX L808
	g_ResidualByteAddressAtPtx809 =
		uint64_t(g_ResidualByteAddressAtPtx804) + uint64_t(r_PtxU64Register88); // PTX L809
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx809));
		r_PackedHalf2AtPtx795R1310 = r_Value.x;
		r_PackedHalf2AtPtx796R1311 = r_Value.y;
		r_PackedHalf2AtPtx797R1312 = r_Value.z;
		r_PackedHalf2AtPtx798R1313 = r_Value.w;
	} // PTX L811
L__BB12_92:															 // PTX L813
	r_PackedHalf2AtPtx814R1314 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L814
	r_PackedHalf2AtPtx815R1315 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L815
	r_PackedHalf2AtPtx816R1316 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L816
	r_PackedHalf2AtPtx817R1317 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L817
	if (r_bPtxPredicate62)
	{
		goto L__BB12_94;
	} // PTX L818
	r_PtxRegister244 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);				 // PTX L819
	r_PtxRegister245 = ShiftLeft(uint32_t(r_PtxRegister244), uint32_t(12));					 // PTX L820
	r_PtxRegister246 = uint32_t(r_PtxRegister245) + uint32_t(r_PtxRegister12);				 // PTX L821
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister246)) * int64_t(int32_t(4))); // PTX L822
	g_ResidualByteAddressAtPtx823 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register90);							 // PTX L823
	r_LaneIndexAtPtx825 = uint32_t((threadIdx.x & 31u));										 // PTX L825
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx825)) * int64_t(int32_t(16))); // PTX L827
	g_ResidualByteAddressAtPtx828 =
		uint64_t(g_ResidualByteAddressAtPtx823) + uint64_t(r_PtxU64Register92); // PTX L828
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx828));
		r_PackedHalf2AtPtx814R1314 = r_Value.x;
		r_PackedHalf2AtPtx815R1315 = r_Value.y;
		r_PackedHalf2AtPtx816R1316 = r_Value.z;
		r_PackedHalf2AtPtx817R1317 = r_Value.w;
	} // PTX L830
L__BB12_94:																	 // PTX L832
	r_bPtxPredicate63 = int32_t(r_PtxRegister30) < int32_t(r_WidthDiv4Bits); // PTX L833
	r_PtxRegister34 = r_bPtxPredicate11 ? 0 : r_PtxRegister30;				 // PTX L834
	r_bPtxPredicate64 = r_bPtxPredicate10 | r_bPtxPredicate63;				 // PTX L835
	r_bPtxPredicate13 = r_bPtxPredicate64 & r_bPtxPredicate9;				 // PTX L836
	r_bPtxPredicate65 = !r_bPtxPredicate13;									 // PTX L837
	r_PackedHalf2AtPtx838R1318 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L838
	r_PackedHalf2AtPtx839R1319 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L839
	r_PackedHalf2AtPtx840R1320 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L840
	r_PackedHalf2AtPtx841R1321 = uint32_t(r_PackedHalf2AtPtx65R184);		 // PTX L841
	if (r_bPtxPredicate65)
	{
		goto L__BB12_96;
	} // PTX L842
	r_PtxRegister248 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);				 // PTX L843
	r_PtxRegister249 = ShiftLeft(uint32_t(r_PtxRegister248), uint32_t(12));					 // PTX L844
	r_PtxRegister250 = uint32_t(r_PtxRegister249) + uint32_t(r_PtxRegister9);				 // PTX L845
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister250)) * int64_t(int32_t(4))); // PTX L846
	g_ResidualByteAddressAtPtx847 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register94);							 // PTX L847
	r_LaneIndexAtPtx849 = uint32_t((threadIdx.x & 31u));										 // PTX L849
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx849)) * int64_t(int32_t(16))); // PTX L851
	g_ResidualByteAddressAtPtx852 =
		uint64_t(g_ResidualByteAddressAtPtx847) + uint64_t(r_PtxU64Register96); // PTX L852
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx852));
		r_PackedHalf2AtPtx838R1318 = r_Value.x;
		r_PackedHalf2AtPtx839R1319 = r_Value.y;
		r_PackedHalf2AtPtx840R1320 = r_Value.z;
		r_PackedHalf2AtPtx841R1321 = r_Value.w;
	} // PTX L854
L__BB12_96:															 // PTX L856
	r_PackedHalf2AtPtx857R1322 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L857
	r_PackedHalf2AtPtx858R1323 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L858
	r_PackedHalf2AtPtx859R1324 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L859
	r_PackedHalf2AtPtx860R1325 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L860
	if (r_bPtxPredicate65)
	{
		goto L__BB12_98;
	} // PTX L861
	r_PtxRegister252 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);				 // PTX L862
	r_PtxRegister253 = ShiftLeft(uint32_t(r_PtxRegister252), uint32_t(12));					 // PTX L863
	r_PtxRegister254 = uint32_t(r_PtxRegister253) + uint32_t(r_PtxRegister10);				 // PTX L864
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister254)) * int64_t(int32_t(4))); // PTX L865
	g_ResidualByteAddressAtPtx866 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register98);							  // PTX L866
	r_LaneIndexAtPtx868 = uint32_t((threadIdx.x & 31u));										  // PTX L868
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx868)) * int64_t(int32_t(16))); // PTX L870
	g_ResidualByteAddressAtPtx871 =
		uint64_t(g_ResidualByteAddressAtPtx866) + uint64_t(r_PtxU64Register100); // PTX L871
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx871));
		r_PackedHalf2AtPtx857R1322 = r_Value.x;
		r_PackedHalf2AtPtx858R1323 = r_Value.y;
		r_PackedHalf2AtPtx859R1324 = r_Value.z;
		r_PackedHalf2AtPtx860R1325 = r_Value.w;
	} // PTX L873
L__BB12_98:															 // PTX L875
	r_PackedHalf2AtPtx876R1326 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L876
	r_PackedHalf2AtPtx877R1327 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L877
	r_PackedHalf2AtPtx878R1328 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L878
	r_PackedHalf2AtPtx879R1329 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L879
	if (r_bPtxPredicate65)
	{
		goto L__BB12_100;
	} // PTX L880
	r_PtxRegister256 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);				  // PTX L881
	r_PtxRegister257 = ShiftLeft(uint32_t(r_PtxRegister256), uint32_t(12));					  // PTX L882
	r_PtxRegister258 = uint32_t(r_PtxRegister257) + uint32_t(r_PtxRegister11);				  // PTX L883
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister258)) * int64_t(int32_t(4))); // PTX L884
	g_ResidualByteAddressAtPtx885 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register102);						  // PTX L885
	r_LaneIndexAtPtx887 = uint32_t((threadIdx.x & 31u));										  // PTX L887
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx887)) * int64_t(int32_t(16))); // PTX L889
	g_ResidualByteAddressAtPtx890 =
		uint64_t(g_ResidualByteAddressAtPtx885) + uint64_t(r_PtxU64Register104); // PTX L890
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx890));
		r_PackedHalf2AtPtx876R1326 = r_Value.x;
		r_PackedHalf2AtPtx877R1327 = r_Value.y;
		r_PackedHalf2AtPtx878R1328 = r_Value.z;
		r_PackedHalf2AtPtx879R1329 = r_Value.w;
	} // PTX L892
L__BB12_100:														 // PTX L894
	r_PackedHalf2AtPtx895R1330 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L895
	r_PackedHalf2AtPtx896R1331 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L896
	r_PackedHalf2AtPtx897R1332 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L897
	r_PackedHalf2AtPtx898R1333 = uint32_t(r_PackedHalf2AtPtx65R184); // PTX L898
	if (r_bPtxPredicate65)
	{
		goto L__BB12_102;
	} // PTX L899
	r_PtxRegister260 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);				  // PTX L900
	r_PtxRegister261 = ShiftLeft(uint32_t(r_PtxRegister260), uint32_t(12));					  // PTX L901
	r_PtxRegister262 = uint32_t(r_PtxRegister261) + uint32_t(r_PtxRegister12);				  // PTX L902
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister262)) * int64_t(int32_t(4))); // PTX L903
	g_ResidualByteAddressAtPtx904 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register106);						  // PTX L904
	r_LaneIndexAtPtx906 = uint32_t((threadIdx.x & 31u));										  // PTX L906
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx906)) * int64_t(int32_t(16))); // PTX L908
	g_ResidualByteAddressAtPtx909 =
		uint64_t(g_ResidualByteAddressAtPtx904) + uint64_t(r_PtxU64Register108); // PTX L909
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx909));
		r_PackedHalf2AtPtx895R1330 = r_Value.x;
		r_PackedHalf2AtPtx896R1331 = r_Value.y;
		r_PackedHalf2AtPtx897R1332 = r_Value.z;
		r_PackedHalf2AtPtx898R1333 = r_Value.w;
	} // PTX L911
L__BB12_102:																				  // PTX L913
	g_RecordByteAddressAtPtx914 = g_RecordBaseAddress;										  // PTX L914
	r_PtxRegister455 = uint32_t(r_PtxRegister8) + uint32_t(16);								  // PTX L915
	r_PtxRegister456 = uint32_t(r_PtxRegister8) + uint32_t(8);								  // PTX L916
	r_LaneIndexAtPtx918 = uint32_t((threadIdx.x & 31u));									  // PTX L918
	r_PtxRegister457 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx918), uint32_t(31));		  // PTX L920
	r_PtxRegister458 = ShiftRight(uint32_t(r_PtxRegister457), uint32_t(30));				  // PTX L921
	r_PtxRegister459 = uint32_t(r_LaneIndexAtPtx918) + uint32_t(r_PtxRegister458);			  // PTX L922
	r_PtxRegister460 = r_PtxRegister459 & 2147483644;										  // PTX L923
	r_PtxRegister461 = uint32_t(r_LaneIndexAtPtx918) - uint32_t(r_PtxRegister460);			  // PTX L924
	r_PtxRegister462 = ShiftLeft(uint32_t(r_PtxRegister461), uint32_t(1));					  // PTX L925
	r_PtxRegister463 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister462);				  // PTX L926
	r_PtxRegister464 = ShiftRightSigned(int32_t(r_PtxRegister463), uint32_t(1));			  // PTX L927
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister464)) * int64_t(int32_t(4))); // PTX L928
	g_RecordByteAddressAtPtx929 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register110); // PTX L929
	r_PtxRegister328 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx929 + 524288ull);		  // PTX L930
	r_LaneIndexAtPtx932 = uint32_t((threadIdx.x & 31u));									  // PTX L932
	r_PtxRegister465 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx932), uint32_t(31));		  // PTX L934
	r_PtxRegister466 = ShiftRight(uint32_t(r_PtxRegister465), uint32_t(30));				  // PTX L935
	r_PtxRegister467 = uint32_t(r_LaneIndexAtPtx932) + uint32_t(r_PtxRegister466);			  // PTX L936
	r_PtxRegister468 = r_PtxRegister467 & 2147483644;										  // PTX L937
	r_PtxRegister469 = uint32_t(r_LaneIndexAtPtx932) - uint32_t(r_PtxRegister468);			  // PTX L938
	r_PtxRegister470 = ShiftLeft(uint32_t(r_PtxRegister469), uint32_t(1));					  // PTX L939
	r_PtxRegister471 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister470);				  // PTX L940
	r_PtxRegister472 = ShiftRightSigned(int32_t(r_PtxRegister471), uint32_t(1));			  // PTX L941
	r_PtxU64Register112 = uint64_t(int64_t(int32_t(r_PtxRegister472)) * int64_t(int32_t(4))); // PTX L942
	g_RecordByteAddressAtPtx943 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register112); // PTX L943
	r_PtxRegister330 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx943 + 524288ull);		  // PTX L944
	r_LaneIndexAtPtx946 = uint32_t((threadIdx.x & 31u));									  // PTX L946
	r_PtxRegister473 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx946), uint32_t(31));		  // PTX L948
	r_PtxRegister474 = ShiftRight(uint32_t(r_PtxRegister473), uint32_t(30));				  // PTX L949
	r_PtxRegister475 = uint32_t(r_LaneIndexAtPtx946) + uint32_t(r_PtxRegister474);			  // PTX L950
	r_PtxRegister476 = r_PtxRegister475 & 2147483644;										  // PTX L951
	r_PtxRegister477 = uint32_t(r_LaneIndexAtPtx946) - uint32_t(r_PtxRegister476);			  // PTX L952
	r_PtxRegister478 = ShiftLeft(uint32_t(r_PtxRegister477), uint32_t(1));					  // PTX L953
	r_PtxRegister479 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister478);				  // PTX L954
	r_PtxRegister480 = ShiftRightSigned(int32_t(r_PtxRegister479), uint32_t(1));			  // PTX L955
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister480)) * int64_t(int32_t(4))); // PTX L956
	g_RecordByteAddressAtPtx957 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register114); // PTX L957
	r_PtxRegister332 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx957 + 524288ull);		  // PTX L958
	r_LaneIndexAtPtx960 = uint32_t((threadIdx.x & 31u));									  // PTX L960
	r_PtxRegister481 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx960), uint32_t(31));		  // PTX L962
	r_PtxRegister482 = ShiftRight(uint32_t(r_PtxRegister481), uint32_t(30));				  // PTX L963
	r_PtxRegister483 = uint32_t(r_LaneIndexAtPtx960) + uint32_t(r_PtxRegister482);			  // PTX L964
	r_PtxRegister484 = r_PtxRegister483 & 2147483644;										  // PTX L965
	r_PtxRegister485 = uint32_t(r_LaneIndexAtPtx960) - uint32_t(r_PtxRegister484);			  // PTX L966
	r_PtxRegister486 = ShiftLeft(uint32_t(r_PtxRegister485), uint32_t(1));					  // PTX L967
	r_PtxRegister487 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister486);				  // PTX L968
	r_PtxRegister488 = ShiftRightSigned(int32_t(r_PtxRegister487), uint32_t(1));			  // PTX L969
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister488)) * int64_t(int32_t(4))); // PTX L970
	g_RecordByteAddressAtPtx971 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register116); // PTX L971
	r_PtxRegister334 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx971 + 524288ull);		  // PTX L972
	r_LaneIndexAtPtx974 = uint32_t((threadIdx.x & 31u));									  // PTX L974
	r_PtxRegister489 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx974), uint32_t(31));		  // PTX L976
	r_PtxRegister490 = ShiftRight(uint32_t(r_PtxRegister489), uint32_t(30));				  // PTX L977
	r_PtxRegister491 = uint32_t(r_LaneIndexAtPtx974) + uint32_t(r_PtxRegister490);			  // PTX L978
	r_PtxRegister492 = r_PtxRegister491 & 2147483644;										  // PTX L979
	r_PtxRegister493 = uint32_t(r_LaneIndexAtPtx974) - uint32_t(r_PtxRegister492);			  // PTX L980
	r_PtxRegister494 = ShiftLeft(uint32_t(r_PtxRegister493), uint32_t(1));					  // PTX L981
	r_PtxRegister495 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister494);				  // PTX L982
	r_PtxRegister496 = ShiftRightSigned(int32_t(r_PtxRegister495), uint32_t(1));			  // PTX L983
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister496)) * int64_t(int32_t(4))); // PTX L984
	g_RecordByteAddressAtPtx985 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register118); // PTX L985
	r_PtxRegister336 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx985 + 524288ull);		  // PTX L986
	r_LaneIndexAtPtx988 = uint32_t((threadIdx.x & 31u));									  // PTX L988
	r_PtxRegister497 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx988), uint32_t(31));		  // PTX L990
	r_PtxRegister498 = ShiftRight(uint32_t(r_PtxRegister497), uint32_t(30));				  // PTX L991
	r_PtxRegister499 = uint32_t(r_LaneIndexAtPtx988) + uint32_t(r_PtxRegister498);			  // PTX L992
	r_PtxRegister500 = r_PtxRegister499 & 2147483644;										  // PTX L993
	r_PtxRegister501 = uint32_t(r_LaneIndexAtPtx988) - uint32_t(r_PtxRegister500);			  // PTX L994
	r_PtxRegister502 = ShiftLeft(uint32_t(r_PtxRegister501), uint32_t(1));					  // PTX L995
	r_PtxRegister503 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister502);				  // PTX L996
	r_PtxRegister504 = ShiftRightSigned(int32_t(r_PtxRegister503), uint32_t(1));			  // PTX L997
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister504)) * int64_t(int32_t(4))); // PTX L998
	g_RecordByteAddressAtPtx999 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register120); // PTX L999
	r_PtxRegister338 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx999 + 524288ull);		  // PTX L1000
	r_LaneIndexAtPtx1002 = uint32_t((threadIdx.x & 31u));									  // PTX L1002
	r_PtxRegister505 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1002), uint32_t(31));		  // PTX L1004
	r_PtxRegister506 = ShiftRight(uint32_t(r_PtxRegister505), uint32_t(30));				  // PTX L1005
	r_PtxRegister507 = uint32_t(r_LaneIndexAtPtx1002) + uint32_t(r_PtxRegister506);			  // PTX L1006
	r_PtxRegister508 = r_PtxRegister507 & 2147483644;										  // PTX L1007
	r_PtxRegister509 = uint32_t(r_LaneIndexAtPtx1002) - uint32_t(r_PtxRegister508);			  // PTX L1008
	r_PtxRegister510 = ShiftLeft(uint32_t(r_PtxRegister509), uint32_t(1));					  // PTX L1009
	r_PtxRegister511 = uint32_t(r_PtxRegister8) + uint32_t(24);								  // PTX L1010
	r_PtxRegister512 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister510);				  // PTX L1011
	r_PtxRegister513 = ShiftRight(uint32_t(r_PtxRegister512), uint32_t(31));				  // PTX L1012
	r_PtxRegister514 = uint32_t(r_PtxRegister512) + uint32_t(r_PtxRegister513);				  // PTX L1013
	r_PtxRegister515 = ShiftRightSigned(int32_t(r_PtxRegister514), uint32_t(1));			  // PTX L1014
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister515)) * int64_t(int32_t(4))); // PTX L1015
	g_RecordByteAddressAtPtx1016 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register122); // PTX L1016
	r_PtxRegister340 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1016 + 524288ull);		  // PTX L1017
	r_LaneIndexAtPtx1019 = uint32_t((threadIdx.x & 31u));									  // PTX L1019
	r_PtxRegister516 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1019), uint32_t(31));		  // PTX L1021
	r_PtxRegister517 = ShiftRight(uint32_t(r_PtxRegister516), uint32_t(30));				  // PTX L1022
	r_PtxRegister518 = uint32_t(r_LaneIndexAtPtx1019) + uint32_t(r_PtxRegister517);			  // PTX L1023
	r_PtxRegister519 = r_PtxRegister518 & 2147483644;										  // PTX L1024
	r_PtxRegister520 = uint32_t(r_LaneIndexAtPtx1019) - uint32_t(r_PtxRegister519);			  // PTX L1025
	r_PtxRegister521 = ShiftLeft(uint32_t(r_PtxRegister520), uint32_t(1));					  // PTX L1026
	r_PtxRegister522 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister521);				  // PTX L1027
	r_PtxRegister523 = ShiftRight(uint32_t(r_PtxRegister522), uint32_t(31));				  // PTX L1028
	r_PtxRegister524 = uint32_t(r_PtxRegister522) + uint32_t(r_PtxRegister523);				  // PTX L1029
	r_PtxRegister525 = ShiftRightSigned(int32_t(r_PtxRegister524), uint32_t(1));			  // PTX L1030
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister525)) * int64_t(int32_t(4))); // PTX L1031
	g_RecordByteAddressAtPtx1032 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register124); // PTX L1032
	r_PtxRegister342 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1032 + 524288ull);		  // PTX L1033
	r_LaneIndexAtPtx1035 = uint32_t((threadIdx.x & 31u));									  // PTX L1035
	r_PtxRegister526 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1035), uint32_t(31));		  // PTX L1037
	r_PtxRegister527 = ShiftRight(uint32_t(r_PtxRegister526), uint32_t(30));				  // PTX L1038
	r_PtxRegister528 = uint32_t(r_LaneIndexAtPtx1035) + uint32_t(r_PtxRegister527);			  // PTX L1039
	r_PtxRegister529 = r_PtxRegister528 & 2147483644;										  // PTX L1040
	r_PtxRegister530 = uint32_t(r_LaneIndexAtPtx1035) - uint32_t(r_PtxRegister529);			  // PTX L1041
	r_PtxRegister531 = ShiftLeft(uint32_t(r_PtxRegister530), uint32_t(1));					  // PTX L1042
	r_PtxRegister532 = uint32_t(r_PtxRegister8) + uint32_t(32);								  // PTX L1043
	r_PtxRegister533 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister531);				  // PTX L1044
	r_PtxRegister534 = ShiftRightSigned(int32_t(r_PtxRegister533), uint32_t(1));			  // PTX L1045
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister534)) * int64_t(int32_t(4))); // PTX L1046
	g_RecordByteAddressAtPtx1047 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register126); // PTX L1047
	r_PtxRegister344 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1047 + 524288ull);		  // PTX L1048
	r_LaneIndexAtPtx1050 = uint32_t((threadIdx.x & 31u));									  // PTX L1050
	r_PtxRegister535 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1050), uint32_t(31));		  // PTX L1052
	r_PtxRegister536 = ShiftRight(uint32_t(r_PtxRegister535), uint32_t(30));				  // PTX L1053
	r_PtxRegister537 = uint32_t(r_LaneIndexAtPtx1050) + uint32_t(r_PtxRegister536);			  // PTX L1054
	r_PtxRegister538 = r_PtxRegister537 & 2147483644;										  // PTX L1055
	r_PtxRegister539 = uint32_t(r_LaneIndexAtPtx1050) - uint32_t(r_PtxRegister538);			  // PTX L1056
	r_PtxRegister540 = ShiftLeft(uint32_t(r_PtxRegister539), uint32_t(1));					  // PTX L1057
	r_PtxRegister541 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister540);				  // PTX L1058
	r_PtxRegister542 = ShiftRightSigned(int32_t(r_PtxRegister541), uint32_t(1));			  // PTX L1059
	r_PtxU64Register128 = uint64_t(int64_t(int32_t(r_PtxRegister542)) * int64_t(int32_t(4))); // PTX L1060
	g_RecordByteAddressAtPtx1061 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register128); // PTX L1061
	r_PtxRegister346 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1061 + 524288ull);		  // PTX L1062
	r_LaneIndexAtPtx1064 = uint32_t((threadIdx.x & 31u));									  // PTX L1064
	r_PtxRegister543 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1064), uint32_t(31));		  // PTX L1066
	r_PtxRegister544 = ShiftRight(uint32_t(r_PtxRegister543), uint32_t(30));				  // PTX L1067
	r_PtxRegister545 = uint32_t(r_LaneIndexAtPtx1064) + uint32_t(r_PtxRegister544);			  // PTX L1068
	r_PtxRegister546 = r_PtxRegister545 & 2147483644;										  // PTX L1069
	r_PtxRegister547 = uint32_t(r_LaneIndexAtPtx1064) - uint32_t(r_PtxRegister546);			  // PTX L1070
	r_PtxRegister548 = ShiftLeft(uint32_t(r_PtxRegister547), uint32_t(1));					  // PTX L1071
	r_PtxRegister549 = uint32_t(r_PtxRegister8) + uint32_t(40);								  // PTX L1072
	r_PtxRegister550 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister548);				  // PTX L1073
	r_PtxRegister551 = ShiftRight(uint32_t(r_PtxRegister550), uint32_t(31));				  // PTX L1074
	r_PtxRegister552 = uint32_t(r_PtxRegister550) + uint32_t(r_PtxRegister551);				  // PTX L1075
	r_PtxRegister553 = ShiftRightSigned(int32_t(r_PtxRegister552), uint32_t(1));			  // PTX L1076
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister553)) * int64_t(int32_t(4))); // PTX L1077
	g_RecordByteAddressAtPtx1078 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register130); // PTX L1078
	r_PtxRegister348 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1078 + 524288ull);		  // PTX L1079
	r_LaneIndexAtPtx1081 = uint32_t((threadIdx.x & 31u));									  // PTX L1081
	r_PtxRegister554 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1081), uint32_t(31));		  // PTX L1083
	r_PtxRegister555 = ShiftRight(uint32_t(r_PtxRegister554), uint32_t(30));				  // PTX L1084
	r_PtxRegister556 = uint32_t(r_LaneIndexAtPtx1081) + uint32_t(r_PtxRegister555);			  // PTX L1085
	r_PtxRegister557 = r_PtxRegister556 & 2147483644;										  // PTX L1086
	r_PtxRegister558 = uint32_t(r_LaneIndexAtPtx1081) - uint32_t(r_PtxRegister557);			  // PTX L1087
	r_PtxRegister559 = ShiftLeft(uint32_t(r_PtxRegister558), uint32_t(1));					  // PTX L1088
	r_PtxRegister560 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister559);				  // PTX L1089
	r_PtxRegister561 = ShiftRight(uint32_t(r_PtxRegister560), uint32_t(31));				  // PTX L1090
	r_PtxRegister562 = uint32_t(r_PtxRegister560) + uint32_t(r_PtxRegister561);				  // PTX L1091
	r_PtxRegister563 = ShiftRightSigned(int32_t(r_PtxRegister562), uint32_t(1));			  // PTX L1092
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister563)) * int64_t(int32_t(4))); // PTX L1093
	g_RecordByteAddressAtPtx1094 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register132); // PTX L1094
	r_PtxRegister350 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1094 + 524288ull);		  // PTX L1095
	r_LaneIndexAtPtx1097 = uint32_t((threadIdx.x & 31u));									  // PTX L1097
	r_PtxRegister564 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1097), uint32_t(31));		  // PTX L1099
	r_PtxRegister565 = ShiftRight(uint32_t(r_PtxRegister564), uint32_t(30));				  // PTX L1100
	r_PtxRegister566 = uint32_t(r_LaneIndexAtPtx1097) + uint32_t(r_PtxRegister565);			  // PTX L1101
	r_PtxRegister567 = r_PtxRegister566 & 2147483644;										  // PTX L1102
	r_PtxRegister568 = uint32_t(r_LaneIndexAtPtx1097) - uint32_t(r_PtxRegister567);			  // PTX L1103
	r_PtxRegister569 = ShiftLeft(uint32_t(r_PtxRegister568), uint32_t(1));					  // PTX L1104
	r_PtxRegister570 = uint32_t(r_PtxRegister8) + uint32_t(48);								  // PTX L1105
	r_PtxRegister571 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister569);				  // PTX L1106
	r_PtxRegister572 = ShiftRightSigned(int32_t(r_PtxRegister571), uint32_t(1));			  // PTX L1107
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister572)) * int64_t(int32_t(4))); // PTX L1108
	g_RecordByteAddressAtPtx1109 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register134); // PTX L1109
	r_PtxRegister352 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1109 + 524288ull);		  // PTX L1110
	r_LaneIndexAtPtx1112 = uint32_t((threadIdx.x & 31u));									  // PTX L1112
	r_PtxRegister573 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1112), uint32_t(31));		  // PTX L1114
	r_PtxRegister574 = ShiftRight(uint32_t(r_PtxRegister573), uint32_t(30));				  // PTX L1115
	r_PtxRegister575 = uint32_t(r_LaneIndexAtPtx1112) + uint32_t(r_PtxRegister574);			  // PTX L1116
	r_PtxRegister576 = r_PtxRegister575 & 2147483644;										  // PTX L1117
	r_PtxRegister577 = uint32_t(r_LaneIndexAtPtx1112) - uint32_t(r_PtxRegister576);			  // PTX L1118
	r_PtxRegister578 = ShiftLeft(uint32_t(r_PtxRegister577), uint32_t(1));					  // PTX L1119
	r_PtxRegister579 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister578);				  // PTX L1120
	r_PtxRegister580 = ShiftRightSigned(int32_t(r_PtxRegister579), uint32_t(1));			  // PTX L1121
	r_PtxU64Register136 = uint64_t(int64_t(int32_t(r_PtxRegister580)) * int64_t(int32_t(4))); // PTX L1122
	g_RecordByteAddressAtPtx1123 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register136); // PTX L1123
	r_PtxRegister354 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1123 + 524288ull);		  // PTX L1124
	r_LaneIndexAtPtx1126 = uint32_t((threadIdx.x & 31u));									  // PTX L1126
	r_PtxRegister581 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1126), uint32_t(31));		  // PTX L1128
	r_PtxRegister582 = ShiftRight(uint32_t(r_PtxRegister581), uint32_t(30));				  // PTX L1129
	r_PtxRegister583 = uint32_t(r_LaneIndexAtPtx1126) + uint32_t(r_PtxRegister582);			  // PTX L1130
	r_PtxRegister584 = r_PtxRegister583 & 2147483644;										  // PTX L1131
	r_PtxRegister585 = uint32_t(r_LaneIndexAtPtx1126) - uint32_t(r_PtxRegister584);			  // PTX L1132
	r_PtxRegister586 = ShiftLeft(uint32_t(r_PtxRegister585), uint32_t(1));					  // PTX L1133
	r_PtxRegister587 = uint32_t(r_PtxRegister8) + uint32_t(56);								  // PTX L1134
	r_PtxRegister588 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister586);				  // PTX L1135
	r_PtxRegister589 = ShiftRight(uint32_t(r_PtxRegister588), uint32_t(31));				  // PTX L1136
	r_PtxRegister590 = uint32_t(r_PtxRegister588) + uint32_t(r_PtxRegister589);				  // PTX L1137
	r_PtxRegister591 = ShiftRightSigned(int32_t(r_PtxRegister590), uint32_t(1));			  // PTX L1138
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister591)) * int64_t(int32_t(4))); // PTX L1139
	g_RecordByteAddressAtPtx1140 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register138); // PTX L1140
	r_PtxRegister356 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1140 + 524288ull);		  // PTX L1141
	r_LaneIndexAtPtx1143 = uint32_t((threadIdx.x & 31u));									  // PTX L1143
	r_PtxRegister592 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1143), uint32_t(31));		  // PTX L1145
	r_PtxRegister593 = ShiftRight(uint32_t(r_PtxRegister592), uint32_t(30));				  // PTX L1146
	r_PtxRegister594 = uint32_t(r_LaneIndexAtPtx1143) + uint32_t(r_PtxRegister593);			  // PTX L1147
	r_PtxRegister595 = r_PtxRegister594 & 2147483644;										  // PTX L1148
	r_PtxRegister596 = uint32_t(r_LaneIndexAtPtx1143) - uint32_t(r_PtxRegister595);			  // PTX L1149
	r_PtxRegister597 = ShiftLeft(uint32_t(r_PtxRegister596), uint32_t(1));					  // PTX L1150
	r_PtxRegister598 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister597);				  // PTX L1151
	r_PtxRegister599 = ShiftRight(uint32_t(r_PtxRegister598), uint32_t(31));				  // PTX L1152
	r_PtxRegister600 = uint32_t(r_PtxRegister598) + uint32_t(r_PtxRegister599);				  // PTX L1153
	r_PtxRegister601 = ShiftRightSigned(int32_t(r_PtxRegister600), uint32_t(1));			  // PTX L1154
	r_PtxU64Register140 = uint64_t(int64_t(int32_t(r_PtxRegister601)) * int64_t(int32_t(4))); // PTX L1155
	g_RecordByteAddressAtPtx1156 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register140); // PTX L1156
	r_PtxRegister358 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1156 + 524288ull);		  // PTX L1157
	r_LaneIndexAtPtx1159 = uint32_t((threadIdx.x & 31u));									  // PTX L1159
	r_PtxRegister602 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1159), uint32_t(31));		  // PTX L1161
	r_PtxRegister603 = ShiftRight(uint32_t(r_PtxRegister602), uint32_t(30));				  // PTX L1162
	r_PtxRegister604 = uint32_t(r_LaneIndexAtPtx1159) + uint32_t(r_PtxRegister603);			  // PTX L1163
	r_PtxRegister605 = r_PtxRegister604 & 2147483644;										  // PTX L1164
	r_PtxRegister606 = uint32_t(r_LaneIndexAtPtx1159) - uint32_t(r_PtxRegister605);			  // PTX L1165
	r_PtxRegister607 = ShiftLeft(uint32_t(r_PtxRegister606), uint32_t(1));					  // PTX L1166
	r_PtxRegister608 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister607);				  // PTX L1167
	r_PtxRegister609 = ShiftRightSigned(int32_t(r_PtxRegister608), uint32_t(1));			  // PTX L1168
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister609)) * int64_t(int32_t(4))); // PTX L1169
	g_RecordByteAddressAtPtx1170 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register142); // PTX L1170
	r_PtxRegister360 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1170 + 524288ull);		  // PTX L1171
	r_LaneIndexAtPtx1173 = uint32_t((threadIdx.x & 31u));									  // PTX L1173
	r_PtxRegister610 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1173), uint32_t(31));		  // PTX L1175
	r_PtxRegister611 = ShiftRight(uint32_t(r_PtxRegister610), uint32_t(30));				  // PTX L1176
	r_PtxRegister612 = uint32_t(r_LaneIndexAtPtx1173) + uint32_t(r_PtxRegister611);			  // PTX L1177
	r_PtxRegister613 = r_PtxRegister612 & 2147483644;										  // PTX L1178
	r_PtxRegister614 = uint32_t(r_LaneIndexAtPtx1173) - uint32_t(r_PtxRegister613);			  // PTX L1179
	r_PtxRegister615 = ShiftLeft(uint32_t(r_PtxRegister614), uint32_t(1));					  // PTX L1180
	r_PtxRegister616 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister615);				  // PTX L1181
	r_PtxRegister617 = ShiftRightSigned(int32_t(r_PtxRegister616), uint32_t(1));			  // PTX L1182
	r_PtxU64Register144 = uint64_t(int64_t(int32_t(r_PtxRegister617)) * int64_t(int32_t(4))); // PTX L1183
	g_RecordByteAddressAtPtx1184 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register144); // PTX L1184
	r_PtxRegister362 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1184 + 524288ull);		  // PTX L1185
	r_LaneIndexAtPtx1187 = uint32_t((threadIdx.x & 31u));									  // PTX L1187
	r_PtxRegister618 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1187), uint32_t(31));		  // PTX L1189
	r_PtxRegister619 = ShiftRight(uint32_t(r_PtxRegister618), uint32_t(30));				  // PTX L1190
	r_PtxRegister620 = uint32_t(r_LaneIndexAtPtx1187) + uint32_t(r_PtxRegister619);			  // PTX L1191
	r_PtxRegister621 = r_PtxRegister620 & 2147483644;										  // PTX L1192
	r_PtxRegister622 = uint32_t(r_LaneIndexAtPtx1187) - uint32_t(r_PtxRegister621);			  // PTX L1193
	r_PtxRegister623 = ShiftLeft(uint32_t(r_PtxRegister622), uint32_t(1));					  // PTX L1194
	r_PtxRegister624 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister623);				  // PTX L1195
	r_PtxRegister625 = ShiftRightSigned(int32_t(r_PtxRegister624), uint32_t(1));			  // PTX L1196
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister625)) * int64_t(int32_t(4))); // PTX L1197
	g_RecordByteAddressAtPtx1198 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register146); // PTX L1198
	r_PtxRegister364 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1198 + 524288ull);		  // PTX L1199
	r_LaneIndexAtPtx1201 = uint32_t((threadIdx.x & 31u));									  // PTX L1201
	r_PtxRegister626 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1201), uint32_t(31));		  // PTX L1203
	r_PtxRegister627 = ShiftRight(uint32_t(r_PtxRegister626), uint32_t(30));				  // PTX L1204
	r_PtxRegister628 = uint32_t(r_LaneIndexAtPtx1201) + uint32_t(r_PtxRegister627);			  // PTX L1205
	r_PtxRegister629 = r_PtxRegister628 & 2147483644;										  // PTX L1206
	r_PtxRegister630 = uint32_t(r_LaneIndexAtPtx1201) - uint32_t(r_PtxRegister629);			  // PTX L1207
	r_PtxRegister631 = ShiftLeft(uint32_t(r_PtxRegister630), uint32_t(1));					  // PTX L1208
	r_PtxRegister632 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister631);				  // PTX L1209
	r_PtxRegister633 = ShiftRightSigned(int32_t(r_PtxRegister632), uint32_t(1));			  // PTX L1210
	r_PtxU64Register148 = uint64_t(int64_t(int32_t(r_PtxRegister633)) * int64_t(int32_t(4))); // PTX L1211
	g_RecordByteAddressAtPtx1212 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register148); // PTX L1212
	r_PtxRegister366 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1212 + 524288ull);		  // PTX L1213
	r_LaneIndexAtPtx1215 = uint32_t((threadIdx.x & 31u));									  // PTX L1215
	r_PtxRegister634 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1215), uint32_t(31));		  // PTX L1217
	r_PtxRegister635 = ShiftRight(uint32_t(r_PtxRegister634), uint32_t(30));				  // PTX L1218
	r_PtxRegister636 = uint32_t(r_LaneIndexAtPtx1215) + uint32_t(r_PtxRegister635);			  // PTX L1219
	r_PtxRegister637 = r_PtxRegister636 & 2147483644;										  // PTX L1220
	r_PtxRegister638 = uint32_t(r_LaneIndexAtPtx1215) - uint32_t(r_PtxRegister637);			  // PTX L1221
	r_PtxRegister639 = ShiftLeft(uint32_t(r_PtxRegister638), uint32_t(1));					  // PTX L1222
	r_PtxRegister640 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister639);				  // PTX L1223
	r_PtxRegister641 = ShiftRightSigned(int32_t(r_PtxRegister640), uint32_t(1));			  // PTX L1224
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister641)) * int64_t(int32_t(4))); // PTX L1225
	g_RecordByteAddressAtPtx1226 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register150); // PTX L1226
	r_PtxRegister368 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1226 + 524288ull);		  // PTX L1227
	r_LaneIndexAtPtx1229 = uint32_t((threadIdx.x & 31u));									  // PTX L1229
	r_PtxRegister642 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1229), uint32_t(31));		  // PTX L1231
	r_PtxRegister643 = ShiftRight(uint32_t(r_PtxRegister642), uint32_t(30));				  // PTX L1232
	r_PtxRegister644 = uint32_t(r_LaneIndexAtPtx1229) + uint32_t(r_PtxRegister643);			  // PTX L1233
	r_PtxRegister645 = r_PtxRegister644 & 2147483644;										  // PTX L1234
	r_PtxRegister646 = uint32_t(r_LaneIndexAtPtx1229) - uint32_t(r_PtxRegister645);			  // PTX L1235
	r_PtxRegister647 = ShiftLeft(uint32_t(r_PtxRegister646), uint32_t(1));					  // PTX L1236
	r_PtxRegister648 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister647);				  // PTX L1237
	r_PtxRegister649 = ShiftRightSigned(int32_t(r_PtxRegister648), uint32_t(1));			  // PTX L1238
	r_PtxU64Register152 = uint64_t(int64_t(int32_t(r_PtxRegister649)) * int64_t(int32_t(4))); // PTX L1239
	g_RecordByteAddressAtPtx1240 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register152); // PTX L1240
	r_PtxRegister370 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1240 + 524288ull);		  // PTX L1241
	r_LaneIndexAtPtx1243 = uint32_t((threadIdx.x & 31u));									  // PTX L1243
	r_PtxRegister650 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1243), uint32_t(31));		  // PTX L1245
	r_PtxRegister651 = ShiftRight(uint32_t(r_PtxRegister650), uint32_t(30));				  // PTX L1246
	r_PtxRegister652 = uint32_t(r_LaneIndexAtPtx1243) + uint32_t(r_PtxRegister651);			  // PTX L1247
	r_PtxRegister653 = r_PtxRegister652 & 2147483644;										  // PTX L1248
	r_PtxRegister654 = uint32_t(r_LaneIndexAtPtx1243) - uint32_t(r_PtxRegister653);			  // PTX L1249
	r_PtxRegister655 = ShiftLeft(uint32_t(r_PtxRegister654), uint32_t(1));					  // PTX L1250
	r_PtxRegister656 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister655);				  // PTX L1251
	r_PtxRegister657 = ShiftRight(uint32_t(r_PtxRegister656), uint32_t(31));				  // PTX L1252
	r_PtxRegister658 = uint32_t(r_PtxRegister656) + uint32_t(r_PtxRegister657);				  // PTX L1253
	r_PtxRegister659 = ShiftRightSigned(int32_t(r_PtxRegister658), uint32_t(1));			  // PTX L1254
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister659)) * int64_t(int32_t(4))); // PTX L1255
	g_RecordByteAddressAtPtx1256 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register154); // PTX L1256
	r_PtxRegister372 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1256 + 524288ull);		  // PTX L1257
	r_LaneIndexAtPtx1259 = uint32_t((threadIdx.x & 31u));									  // PTX L1259
	r_PtxRegister660 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1259), uint32_t(31));		  // PTX L1261
	r_PtxRegister661 = ShiftRight(uint32_t(r_PtxRegister660), uint32_t(30));				  // PTX L1262
	r_PtxRegister662 = uint32_t(r_LaneIndexAtPtx1259) + uint32_t(r_PtxRegister661);			  // PTX L1263
	r_PtxRegister663 = r_PtxRegister662 & 2147483644;										  // PTX L1264
	r_PtxRegister664 = uint32_t(r_LaneIndexAtPtx1259) - uint32_t(r_PtxRegister663);			  // PTX L1265
	r_PtxRegister665 = ShiftLeft(uint32_t(r_PtxRegister664), uint32_t(1));					  // PTX L1266
	r_PtxRegister666 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister665);				  // PTX L1267
	r_PtxRegister667 = ShiftRight(uint32_t(r_PtxRegister666), uint32_t(31));				  // PTX L1268
	r_PtxRegister668 = uint32_t(r_PtxRegister666) + uint32_t(r_PtxRegister667);				  // PTX L1269
	r_PtxRegister669 = ShiftRightSigned(int32_t(r_PtxRegister668), uint32_t(1));			  // PTX L1270
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister669)) * int64_t(int32_t(4))); // PTX L1271
	g_RecordByteAddressAtPtx1272 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register156); // PTX L1272
	r_PtxRegister374 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1272 + 524288ull);		  // PTX L1273
	r_LaneIndexAtPtx1275 = uint32_t((threadIdx.x & 31u));									  // PTX L1275
	r_PtxRegister670 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1275), uint32_t(31));		  // PTX L1277
	r_PtxRegister671 = ShiftRight(uint32_t(r_PtxRegister670), uint32_t(30));				  // PTX L1278
	r_PtxRegister672 = uint32_t(r_LaneIndexAtPtx1275) + uint32_t(r_PtxRegister671);			  // PTX L1279
	r_PtxRegister673 = r_PtxRegister672 & 2147483644;										  // PTX L1280
	r_PtxRegister674 = uint32_t(r_LaneIndexAtPtx1275) - uint32_t(r_PtxRegister673);			  // PTX L1281
	r_PtxRegister675 = ShiftLeft(uint32_t(r_PtxRegister674), uint32_t(1));					  // PTX L1282
	r_PtxRegister676 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister675);				  // PTX L1283
	r_PtxRegister677 = ShiftRightSigned(int32_t(r_PtxRegister676), uint32_t(1));			  // PTX L1284
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister677)) * int64_t(int32_t(4))); // PTX L1285
	g_RecordByteAddressAtPtx1286 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register158); // PTX L1286
	r_PtxRegister376 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1286 + 524288ull);		  // PTX L1287
	r_LaneIndexAtPtx1289 = uint32_t((threadIdx.x & 31u));									  // PTX L1289
	r_PtxRegister678 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1289), uint32_t(31));		  // PTX L1291
	r_PtxRegister679 = ShiftRight(uint32_t(r_PtxRegister678), uint32_t(30));				  // PTX L1292
	r_PtxRegister680 = uint32_t(r_LaneIndexAtPtx1289) + uint32_t(r_PtxRegister679);			  // PTX L1293
	r_PtxRegister681 = r_PtxRegister680 & 2147483644;										  // PTX L1294
	r_PtxRegister682 = uint32_t(r_LaneIndexAtPtx1289) - uint32_t(r_PtxRegister681);			  // PTX L1295
	r_PtxRegister683 = ShiftLeft(uint32_t(r_PtxRegister682), uint32_t(1));					  // PTX L1296
	r_PtxRegister684 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister683);				  // PTX L1297
	r_PtxRegister685 = ShiftRightSigned(int32_t(r_PtxRegister684), uint32_t(1));			  // PTX L1298
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister685)) * int64_t(int32_t(4))); // PTX L1299
	g_RecordByteAddressAtPtx1300 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register160); // PTX L1300
	r_PtxRegister378 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1300 + 524288ull);		  // PTX L1301
	r_LaneIndexAtPtx1303 = uint32_t((threadIdx.x & 31u));									  // PTX L1303
	r_PtxRegister686 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1303), uint32_t(31));		  // PTX L1305
	r_PtxRegister687 = ShiftRight(uint32_t(r_PtxRegister686), uint32_t(30));				  // PTX L1306
	r_PtxRegister688 = uint32_t(r_LaneIndexAtPtx1303) + uint32_t(r_PtxRegister687);			  // PTX L1307
	r_PtxRegister689 = r_PtxRegister688 & 2147483644;										  // PTX L1308
	r_PtxRegister690 = uint32_t(r_LaneIndexAtPtx1303) - uint32_t(r_PtxRegister689);			  // PTX L1309
	r_PtxRegister691 = ShiftLeft(uint32_t(r_PtxRegister690), uint32_t(1));					  // PTX L1310
	r_PtxRegister692 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister691);				  // PTX L1311
	r_PtxRegister693 = ShiftRight(uint32_t(r_PtxRegister692), uint32_t(31));				  // PTX L1312
	r_PtxRegister694 = uint32_t(r_PtxRegister692) + uint32_t(r_PtxRegister693);				  // PTX L1313
	r_PtxRegister695 = ShiftRightSigned(int32_t(r_PtxRegister694), uint32_t(1));			  // PTX L1314
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister695)) * int64_t(int32_t(4))); // PTX L1315
	g_RecordByteAddressAtPtx1316 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register162); // PTX L1316
	r_PtxRegister380 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1316 + 524288ull);		  // PTX L1317
	r_LaneIndexAtPtx1319 = uint32_t((threadIdx.x & 31u));									  // PTX L1319
	r_PtxRegister696 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1319), uint32_t(31));		  // PTX L1321
	r_PtxRegister697 = ShiftRight(uint32_t(r_PtxRegister696), uint32_t(30));				  // PTX L1322
	r_PtxRegister698 = uint32_t(r_LaneIndexAtPtx1319) + uint32_t(r_PtxRegister697);			  // PTX L1323
	r_PtxRegister699 = r_PtxRegister698 & 2147483644;										  // PTX L1324
	r_PtxRegister700 = uint32_t(r_LaneIndexAtPtx1319) - uint32_t(r_PtxRegister699);			  // PTX L1325
	r_PtxRegister701 = ShiftLeft(uint32_t(r_PtxRegister700), uint32_t(1));					  // PTX L1326
	r_PtxRegister702 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister701);				  // PTX L1327
	r_PtxRegister703 = ShiftRight(uint32_t(r_PtxRegister702), uint32_t(31));				  // PTX L1328
	r_PtxRegister704 = uint32_t(r_PtxRegister702) + uint32_t(r_PtxRegister703);				  // PTX L1329
	r_PtxRegister705 = ShiftRightSigned(int32_t(r_PtxRegister704), uint32_t(1));			  // PTX L1330
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister705)) * int64_t(int32_t(4))); // PTX L1331
	g_RecordByteAddressAtPtx1332 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register164); // PTX L1332
	r_PtxRegister382 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1332 + 524288ull);		  // PTX L1333
	r_LaneIndexAtPtx1335 = uint32_t((threadIdx.x & 31u));									  // PTX L1335
	r_PtxRegister706 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1335), uint32_t(31));		  // PTX L1337
	r_PtxRegister707 = ShiftRight(uint32_t(r_PtxRegister706), uint32_t(30));				  // PTX L1338
	r_PtxRegister708 = uint32_t(r_LaneIndexAtPtx1335) + uint32_t(r_PtxRegister707);			  // PTX L1339
	r_PtxRegister709 = r_PtxRegister708 & 2147483644;										  // PTX L1340
	r_PtxRegister710 = uint32_t(r_LaneIndexAtPtx1335) - uint32_t(r_PtxRegister709);			  // PTX L1341
	r_PtxRegister711 = ShiftLeft(uint32_t(r_PtxRegister710), uint32_t(1));					  // PTX L1342
	r_PtxRegister712 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister711);				  // PTX L1343
	r_PtxRegister713 = ShiftRightSigned(int32_t(r_PtxRegister712), uint32_t(1));			  // PTX L1344
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister713)) * int64_t(int32_t(4))); // PTX L1345
	g_RecordByteAddressAtPtx1346 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register166); // PTX L1346
	r_PtxRegister384 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1346 + 524288ull);		  // PTX L1347
	r_LaneIndexAtPtx1349 = uint32_t((threadIdx.x & 31u));									  // PTX L1349
	r_PtxRegister714 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1349), uint32_t(31));		  // PTX L1351
	r_PtxRegister715 = ShiftRight(uint32_t(r_PtxRegister714), uint32_t(30));				  // PTX L1352
	r_PtxRegister716 = uint32_t(r_LaneIndexAtPtx1349) + uint32_t(r_PtxRegister715);			  // PTX L1353
	r_PtxRegister717 = r_PtxRegister716 & 2147483644;										  // PTX L1354
	r_PtxRegister718 = uint32_t(r_LaneIndexAtPtx1349) - uint32_t(r_PtxRegister717);			  // PTX L1355
	r_PtxRegister719 = ShiftLeft(uint32_t(r_PtxRegister718), uint32_t(1));					  // PTX L1356
	r_PtxRegister720 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister719);				  // PTX L1357
	r_PtxRegister721 = ShiftRightSigned(int32_t(r_PtxRegister720), uint32_t(1));			  // PTX L1358
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister721)) * int64_t(int32_t(4))); // PTX L1359
	g_RecordByteAddressAtPtx1360 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register168); // PTX L1360
	r_PtxRegister386 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1360 + 524288ull);		  // PTX L1361
	r_LaneIndexAtPtx1363 = uint32_t((threadIdx.x & 31u));									  // PTX L1363
	r_PtxRegister722 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1363), uint32_t(31));		  // PTX L1365
	r_PtxRegister723 = ShiftRight(uint32_t(r_PtxRegister722), uint32_t(30));				  // PTX L1366
	r_PtxRegister724 = uint32_t(r_LaneIndexAtPtx1363) + uint32_t(r_PtxRegister723);			  // PTX L1367
	r_PtxRegister725 = r_PtxRegister724 & 2147483644;										  // PTX L1368
	r_PtxRegister726 = uint32_t(r_LaneIndexAtPtx1363) - uint32_t(r_PtxRegister725);			  // PTX L1369
	r_PtxRegister727 = ShiftLeft(uint32_t(r_PtxRegister726), uint32_t(1));					  // PTX L1370
	r_PtxRegister728 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister727);				  // PTX L1371
	r_PtxRegister729 = ShiftRight(uint32_t(r_PtxRegister728), uint32_t(31));				  // PTX L1372
	r_PtxRegister730 = uint32_t(r_PtxRegister728) + uint32_t(r_PtxRegister729);				  // PTX L1373
	r_PtxRegister731 = ShiftRightSigned(int32_t(r_PtxRegister730), uint32_t(1));			  // PTX L1374
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister731)) * int64_t(int32_t(4))); // PTX L1375
	g_RecordByteAddressAtPtx1376 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register170); // PTX L1376
	r_PtxRegister388 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1376 + 524288ull);		  // PTX L1377
	r_LaneIndexAtPtx1379 = uint32_t((threadIdx.x & 31u));									  // PTX L1379
	r_PtxRegister732 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1379), uint32_t(31));		  // PTX L1381
	r_PtxRegister733 = ShiftRight(uint32_t(r_PtxRegister732), uint32_t(30));				  // PTX L1382
	r_PtxRegister734 = uint32_t(r_LaneIndexAtPtx1379) + uint32_t(r_PtxRegister733);			  // PTX L1383
	r_PtxRegister735 = r_PtxRegister734 & 2147483644;										  // PTX L1384
	r_PtxRegister736 = uint32_t(r_LaneIndexAtPtx1379) - uint32_t(r_PtxRegister735);			  // PTX L1385
	r_PtxRegister737 = ShiftLeft(uint32_t(r_PtxRegister736), uint32_t(1));					  // PTX L1386
	r_PtxRegister738 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister737);				  // PTX L1387
	r_PtxRegister739 = ShiftRight(uint32_t(r_PtxRegister738), uint32_t(31));				  // PTX L1388
	r_PtxRegister740 = uint32_t(r_PtxRegister738) + uint32_t(r_PtxRegister739);				  // PTX L1389
	r_PtxRegister741 = ShiftRightSigned(int32_t(r_PtxRegister740), uint32_t(1));			  // PTX L1390
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister741)) * int64_t(int32_t(4))); // PTX L1391
	g_RecordByteAddressAtPtx1392 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register172); // PTX L1392
	r_PtxRegister390 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1392 + 524288ull);		  // PTX L1393
	r_LaneIndexAtPtx1395 = uint32_t((threadIdx.x & 31u));									  // PTX L1395
	r_PtxRegister742 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1395), uint32_t(31));		  // PTX L1397
	r_PtxRegister743 = ShiftRight(uint32_t(r_PtxRegister742), uint32_t(30));				  // PTX L1398
	r_PtxRegister744 = uint32_t(r_LaneIndexAtPtx1395) + uint32_t(r_PtxRegister743);			  // PTX L1399
	r_PtxRegister745 = r_PtxRegister744 & 2147483644;										  // PTX L1400
	r_PtxRegister746 = uint32_t(r_LaneIndexAtPtx1395) - uint32_t(r_PtxRegister745);			  // PTX L1401
	r_PtxRegister747 = ShiftLeft(uint32_t(r_PtxRegister746), uint32_t(1));					  // PTX L1402
	r_PtxRegister748 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister747);				  // PTX L1403
	r_PtxRegister749 = ShiftRightSigned(int32_t(r_PtxRegister748), uint32_t(1));			  // PTX L1404
	r_PtxU64Register174 = uint64_t(int64_t(int32_t(r_PtxRegister749)) * int64_t(int32_t(4))); // PTX L1405
	g_RecordByteAddressAtPtx1406 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register174); // PTX L1406
	r_PtxRegister392 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1406 + 524288ull);		  // PTX L1407
	r_LaneIndexAtPtx1409 = uint32_t((threadIdx.x & 31u));									  // PTX L1409
	r_PtxRegister750 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1409), uint32_t(31));		  // PTX L1411
	r_PtxRegister751 = ShiftRight(uint32_t(r_PtxRegister750), uint32_t(30));				  // PTX L1412
	r_PtxRegister752 = uint32_t(r_LaneIndexAtPtx1409) + uint32_t(r_PtxRegister751);			  // PTX L1413
	r_PtxRegister753 = r_PtxRegister752 & 2147483644;										  // PTX L1414
	r_PtxRegister754 = uint32_t(r_LaneIndexAtPtx1409) - uint32_t(r_PtxRegister753);			  // PTX L1415
	r_PtxRegister755 = ShiftLeft(uint32_t(r_PtxRegister754), uint32_t(1));					  // PTX L1416
	r_PtxRegister756 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister755);				  // PTX L1417
	r_PtxRegister757 = ShiftRightSigned(int32_t(r_PtxRegister756), uint32_t(1));			  // PTX L1418
	r_PtxU64Register176 = uint64_t(int64_t(int32_t(r_PtxRegister757)) * int64_t(int32_t(4))); // PTX L1419
	g_RecordByteAddressAtPtx1420 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register176); // PTX L1420
	r_PtxRegister394 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1420 + 524288ull);		  // PTX L1421
	r_LaneIndexAtPtx1423 = uint32_t((threadIdx.x & 31u));									  // PTX L1423
	r_PtxRegister758 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1423), uint32_t(31));		  // PTX L1425
	r_PtxRegister759 = ShiftRight(uint32_t(r_PtxRegister758), uint32_t(30));				  // PTX L1426
	r_PtxRegister760 = uint32_t(r_LaneIndexAtPtx1423) + uint32_t(r_PtxRegister759);			  // PTX L1427
	r_PtxRegister761 = r_PtxRegister760 & 2147483644;										  // PTX L1428
	r_PtxRegister762 = uint32_t(r_LaneIndexAtPtx1423) - uint32_t(r_PtxRegister761);			  // PTX L1429
	r_PtxRegister763 = ShiftLeft(uint32_t(r_PtxRegister762), uint32_t(1));					  // PTX L1430
	r_PtxRegister764 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister763);				  // PTX L1431
	r_PtxRegister765 = ShiftRightSigned(int32_t(r_PtxRegister764), uint32_t(1));			  // PTX L1432
	r_PtxU64Register178 = uint64_t(int64_t(int32_t(r_PtxRegister765)) * int64_t(int32_t(4))); // PTX L1433
	g_RecordByteAddressAtPtx1434 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register178); // PTX L1434
	r_PtxRegister396 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1434 + 524288ull);		  // PTX L1435
	r_LaneIndexAtPtx1437 = uint32_t((threadIdx.x & 31u));									  // PTX L1437
	r_PtxRegister766 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1437), uint32_t(31));		  // PTX L1439
	r_PtxRegister767 = ShiftRight(uint32_t(r_PtxRegister766), uint32_t(30));				  // PTX L1440
	r_PtxRegister768 = uint32_t(r_LaneIndexAtPtx1437) + uint32_t(r_PtxRegister767);			  // PTX L1441
	r_PtxRegister769 = r_PtxRegister768 & 2147483644;										  // PTX L1442
	r_PtxRegister770 = uint32_t(r_LaneIndexAtPtx1437) - uint32_t(r_PtxRegister769);			  // PTX L1443
	r_PtxRegister771 = ShiftLeft(uint32_t(r_PtxRegister770), uint32_t(1));					  // PTX L1444
	r_PtxRegister772 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister771);				  // PTX L1445
	r_PtxRegister773 = ShiftRightSigned(int32_t(r_PtxRegister772), uint32_t(1));			  // PTX L1446
	r_PtxU64Register180 = uint64_t(int64_t(int32_t(r_PtxRegister773)) * int64_t(int32_t(4))); // PTX L1447
	g_RecordByteAddressAtPtx1448 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register180); // PTX L1448
	r_PtxRegister398 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1448 + 524288ull);		  // PTX L1449
	r_LaneIndexAtPtx1451 = uint32_t((threadIdx.x & 31u));									  // PTX L1451
	r_PtxRegister774 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1451), uint32_t(31));		  // PTX L1453
	r_PtxRegister775 = ShiftRight(uint32_t(r_PtxRegister774), uint32_t(30));				  // PTX L1454
	r_PtxRegister776 = uint32_t(r_LaneIndexAtPtx1451) + uint32_t(r_PtxRegister775);			  // PTX L1455
	r_PtxRegister777 = r_PtxRegister776 & 2147483644;										  // PTX L1456
	r_PtxRegister778 = uint32_t(r_LaneIndexAtPtx1451) - uint32_t(r_PtxRegister777);			  // PTX L1457
	r_PtxRegister779 = ShiftLeft(uint32_t(r_PtxRegister778), uint32_t(1));					  // PTX L1458
	r_PtxRegister780 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister779);				  // PTX L1459
	r_PtxRegister781 = ShiftRightSigned(int32_t(r_PtxRegister780), uint32_t(1));			  // PTX L1460
	r_PtxU64Register182 = uint64_t(int64_t(int32_t(r_PtxRegister781)) * int64_t(int32_t(4))); // PTX L1461
	g_RecordByteAddressAtPtx1462 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register182); // PTX L1462
	r_PtxRegister400 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1462 + 524288ull);		  // PTX L1463
	r_LaneIndexAtPtx1465 = uint32_t((threadIdx.x & 31u));									  // PTX L1465
	r_PtxRegister782 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1465), uint32_t(31));		  // PTX L1467
	r_PtxRegister783 = ShiftRight(uint32_t(r_PtxRegister782), uint32_t(30));				  // PTX L1468
	r_PtxRegister784 = uint32_t(r_LaneIndexAtPtx1465) + uint32_t(r_PtxRegister783);			  // PTX L1469
	r_PtxRegister785 = r_PtxRegister784 & 2147483644;										  // PTX L1470
	r_PtxRegister786 = uint32_t(r_LaneIndexAtPtx1465) - uint32_t(r_PtxRegister785);			  // PTX L1471
	r_PtxRegister787 = ShiftLeft(uint32_t(r_PtxRegister786), uint32_t(1));					  // PTX L1472
	r_PtxRegister788 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister787);				  // PTX L1473
	r_PtxRegister789 = ShiftRightSigned(int32_t(r_PtxRegister788), uint32_t(1));			  // PTX L1474
	r_PtxU64Register184 = uint64_t(int64_t(int32_t(r_PtxRegister789)) * int64_t(int32_t(4))); // PTX L1475
	g_RecordByteAddressAtPtx1476 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register184); // PTX L1476
	r_PtxRegister402 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1476 + 524288ull);		  // PTX L1477
	r_LaneIndexAtPtx1479 = uint32_t((threadIdx.x & 31u));									  // PTX L1479
	r_PtxRegister790 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1479), uint32_t(31));		  // PTX L1481
	r_PtxRegister791 = ShiftRight(uint32_t(r_PtxRegister790), uint32_t(30));				  // PTX L1482
	r_PtxRegister792 = uint32_t(r_LaneIndexAtPtx1479) + uint32_t(r_PtxRegister791);			  // PTX L1483
	r_PtxRegister793 = r_PtxRegister792 & 2147483644;										  // PTX L1484
	r_PtxRegister794 = uint32_t(r_LaneIndexAtPtx1479) - uint32_t(r_PtxRegister793);			  // PTX L1485
	r_PtxRegister795 = ShiftLeft(uint32_t(r_PtxRegister794), uint32_t(1));					  // PTX L1486
	r_PtxRegister796 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister795);				  // PTX L1487
	r_PtxRegister797 = ShiftRight(uint32_t(r_PtxRegister796), uint32_t(31));				  // PTX L1488
	r_PtxRegister798 = uint32_t(r_PtxRegister796) + uint32_t(r_PtxRegister797);				  // PTX L1489
	r_PtxRegister799 = ShiftRightSigned(int32_t(r_PtxRegister798), uint32_t(1));			  // PTX L1490
	r_PtxU64Register186 = uint64_t(int64_t(int32_t(r_PtxRegister799)) * int64_t(int32_t(4))); // PTX L1491
	g_RecordByteAddressAtPtx1492 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register186); // PTX L1492
	r_PtxRegister404 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1492 + 524288ull);		  // PTX L1493
	r_LaneIndexAtPtx1495 = uint32_t((threadIdx.x & 31u));									  // PTX L1495
	r_PtxRegister800 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1495), uint32_t(31));		  // PTX L1497
	r_PtxRegister801 = ShiftRight(uint32_t(r_PtxRegister800), uint32_t(30));				  // PTX L1498
	r_PtxRegister802 = uint32_t(r_LaneIndexAtPtx1495) + uint32_t(r_PtxRegister801);			  // PTX L1499
	r_PtxRegister803 = r_PtxRegister802 & 2147483644;										  // PTX L1500
	r_PtxRegister804 = uint32_t(r_LaneIndexAtPtx1495) - uint32_t(r_PtxRegister803);			  // PTX L1501
	r_PtxRegister805 = ShiftLeft(uint32_t(r_PtxRegister804), uint32_t(1));					  // PTX L1502
	r_PtxRegister806 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister805);				  // PTX L1503
	r_PtxRegister807 = ShiftRight(uint32_t(r_PtxRegister806), uint32_t(31));				  // PTX L1504
	r_PtxRegister808 = uint32_t(r_PtxRegister806) + uint32_t(r_PtxRegister807);				  // PTX L1505
	r_PtxRegister809 = ShiftRightSigned(int32_t(r_PtxRegister808), uint32_t(1));			  // PTX L1506
	r_PtxU64Register188 = uint64_t(int64_t(int32_t(r_PtxRegister809)) * int64_t(int32_t(4))); // PTX L1507
	g_RecordByteAddressAtPtx1508 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register188); // PTX L1508
	r_PtxRegister406 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1508 + 524288ull);		  // PTX L1509
	r_LaneIndexAtPtx1511 = uint32_t((threadIdx.x & 31u));									  // PTX L1511
	r_PtxRegister810 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1511), uint32_t(31));		  // PTX L1513
	r_PtxRegister811 = ShiftRight(uint32_t(r_PtxRegister810), uint32_t(30));				  // PTX L1514
	r_PtxRegister812 = uint32_t(r_LaneIndexAtPtx1511) + uint32_t(r_PtxRegister811);			  // PTX L1515
	r_PtxRegister813 = r_PtxRegister812 & 2147483644;										  // PTX L1516
	r_PtxRegister814 = uint32_t(r_LaneIndexAtPtx1511) - uint32_t(r_PtxRegister813);			  // PTX L1517
	r_PtxRegister815 = ShiftLeft(uint32_t(r_PtxRegister814), uint32_t(1));					  // PTX L1518
	r_PtxRegister816 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister815);				  // PTX L1519
	r_PtxRegister817 = ShiftRightSigned(int32_t(r_PtxRegister816), uint32_t(1));			  // PTX L1520
	r_PtxU64Register190 = uint64_t(int64_t(int32_t(r_PtxRegister817)) * int64_t(int32_t(4))); // PTX L1521
	g_RecordByteAddressAtPtx1522 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register190); // PTX L1522
	r_PtxRegister408 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1522 + 524288ull);		  // PTX L1523
	r_LaneIndexAtPtx1525 = uint32_t((threadIdx.x & 31u));									  // PTX L1525
	r_PtxRegister818 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1525), uint32_t(31));		  // PTX L1527
	r_PtxRegister819 = ShiftRight(uint32_t(r_PtxRegister818), uint32_t(30));				  // PTX L1528
	r_PtxRegister820 = uint32_t(r_LaneIndexAtPtx1525) + uint32_t(r_PtxRegister819);			  // PTX L1529
	r_PtxRegister821 = r_PtxRegister820 & 2147483644;										  // PTX L1530
	r_PtxRegister822 = uint32_t(r_LaneIndexAtPtx1525) - uint32_t(r_PtxRegister821);			  // PTX L1531
	r_PtxRegister823 = ShiftLeft(uint32_t(r_PtxRegister822), uint32_t(1));					  // PTX L1532
	r_PtxRegister824 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister823);				  // PTX L1533
	r_PtxRegister825 = ShiftRightSigned(int32_t(r_PtxRegister824), uint32_t(1));			  // PTX L1534
	r_PtxU64Register192 = uint64_t(int64_t(int32_t(r_PtxRegister825)) * int64_t(int32_t(4))); // PTX L1535
	g_RecordByteAddressAtPtx1536 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register192); // PTX L1536
	r_PtxRegister410 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1536 + 524288ull);		  // PTX L1537
	r_LaneIndexAtPtx1539 = uint32_t((threadIdx.x & 31u));									  // PTX L1539
	r_PtxRegister826 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1539), uint32_t(31));		  // PTX L1541
	r_PtxRegister827 = ShiftRight(uint32_t(r_PtxRegister826), uint32_t(30));				  // PTX L1542
	r_PtxRegister828 = uint32_t(r_LaneIndexAtPtx1539) + uint32_t(r_PtxRegister827);			  // PTX L1543
	r_PtxRegister829 = r_PtxRegister828 & 2147483644;										  // PTX L1544
	r_PtxRegister830 = uint32_t(r_LaneIndexAtPtx1539) - uint32_t(r_PtxRegister829);			  // PTX L1545
	r_PtxRegister831 = ShiftLeft(uint32_t(r_PtxRegister830), uint32_t(1));					  // PTX L1546
	r_PtxRegister832 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister831);				  // PTX L1547
	r_PtxRegister833 = ShiftRight(uint32_t(r_PtxRegister832), uint32_t(31));				  // PTX L1548
	r_PtxRegister834 = uint32_t(r_PtxRegister832) + uint32_t(r_PtxRegister833);				  // PTX L1549
	r_PtxRegister835 = ShiftRightSigned(int32_t(r_PtxRegister834), uint32_t(1));			  // PTX L1550
	r_PtxU64Register194 = uint64_t(int64_t(int32_t(r_PtxRegister835)) * int64_t(int32_t(4))); // PTX L1551
	g_RecordByteAddressAtPtx1552 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register194); // PTX L1552
	r_PtxRegister412 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1552 + 524288ull);		  // PTX L1553
	r_LaneIndexAtPtx1555 = uint32_t((threadIdx.x & 31u));									  // PTX L1555
	r_PtxRegister836 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1555), uint32_t(31));		  // PTX L1557
	r_PtxRegister837 = ShiftRight(uint32_t(r_PtxRegister836), uint32_t(30));				  // PTX L1558
	r_PtxRegister838 = uint32_t(r_LaneIndexAtPtx1555) + uint32_t(r_PtxRegister837);			  // PTX L1559
	r_PtxRegister839 = r_PtxRegister838 & 2147483644;										  // PTX L1560
	r_PtxRegister840 = uint32_t(r_LaneIndexAtPtx1555) - uint32_t(r_PtxRegister839);			  // PTX L1561
	r_PtxRegister841 = ShiftLeft(uint32_t(r_PtxRegister840), uint32_t(1));					  // PTX L1562
	r_PtxRegister842 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister841);				  // PTX L1563
	r_PtxRegister843 = ShiftRight(uint32_t(r_PtxRegister842), uint32_t(31));				  // PTX L1564
	r_PtxRegister844 = uint32_t(r_PtxRegister842) + uint32_t(r_PtxRegister843);				  // PTX L1565
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_PtxRegister844), uint32_t(1));			  // PTX L1566
	r_PtxU64Register196 = uint64_t(int64_t(int32_t(r_PtxRegister845)) * int64_t(int32_t(4))); // PTX L1567
	g_RecordByteAddressAtPtx1568 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register196); // PTX L1568
	r_PtxRegister414 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1568 + 524288ull);		  // PTX L1569
	r_LaneIndexAtPtx1571 = uint32_t((threadIdx.x & 31u));									  // PTX L1571
	r_PtxRegister846 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1571), uint32_t(31));		  // PTX L1573
	r_PtxRegister847 = ShiftRight(uint32_t(r_PtxRegister846), uint32_t(30));				  // PTX L1574
	r_PtxRegister848 = uint32_t(r_LaneIndexAtPtx1571) + uint32_t(r_PtxRegister847);			  // PTX L1575
	r_PtxRegister849 = r_PtxRegister848 & 2147483644;										  // PTX L1576
	r_PtxRegister850 = uint32_t(r_LaneIndexAtPtx1571) - uint32_t(r_PtxRegister849);			  // PTX L1577
	r_PtxRegister851 = ShiftLeft(uint32_t(r_PtxRegister850), uint32_t(1));					  // PTX L1578
	r_PtxRegister852 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister851);				  // PTX L1579
	r_PtxRegister853 = ShiftRightSigned(int32_t(r_PtxRegister852), uint32_t(1));			  // PTX L1580
	r_PtxU64Register198 = uint64_t(int64_t(int32_t(r_PtxRegister853)) * int64_t(int32_t(4))); // PTX L1581
	g_RecordByteAddressAtPtx1582 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register198); // PTX L1582
	r_PtxRegister416 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1582 + 524288ull);		  // PTX L1583
	r_LaneIndexAtPtx1585 = uint32_t((threadIdx.x & 31u));									  // PTX L1585
	r_PtxRegister854 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1585), uint32_t(31));		  // PTX L1587
	r_PtxRegister855 = ShiftRight(uint32_t(r_PtxRegister854), uint32_t(30));				  // PTX L1588
	r_PtxRegister856 = uint32_t(r_LaneIndexAtPtx1585) + uint32_t(r_PtxRegister855);			  // PTX L1589
	r_PtxRegister857 = r_PtxRegister856 & 2147483644;										  // PTX L1590
	r_PtxRegister858 = uint32_t(r_LaneIndexAtPtx1585) - uint32_t(r_PtxRegister857);			  // PTX L1591
	r_PtxRegister859 = ShiftLeft(uint32_t(r_PtxRegister858), uint32_t(1));					  // PTX L1592
	r_PtxRegister860 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister859);				  // PTX L1593
	r_PtxRegister861 = ShiftRightSigned(int32_t(r_PtxRegister860), uint32_t(1));			  // PTX L1594
	r_PtxU64Register200 = uint64_t(int64_t(int32_t(r_PtxRegister861)) * int64_t(int32_t(4))); // PTX L1595
	g_RecordByteAddressAtPtx1596 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register200); // PTX L1596
	r_PtxRegister418 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1596 + 524288ull);		  // PTX L1597
	r_LaneIndexAtPtx1599 = uint32_t((threadIdx.x & 31u));									  // PTX L1599
	r_PtxRegister862 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1599), uint32_t(31));		  // PTX L1601
	r_PtxRegister863 = ShiftRight(uint32_t(r_PtxRegister862), uint32_t(30));				  // PTX L1602
	r_PtxRegister864 = uint32_t(r_LaneIndexAtPtx1599) + uint32_t(r_PtxRegister863);			  // PTX L1603
	r_PtxRegister865 = r_PtxRegister864 & 2147483644;										  // PTX L1604
	r_PtxRegister866 = uint32_t(r_LaneIndexAtPtx1599) - uint32_t(r_PtxRegister865);			  // PTX L1605
	r_PtxRegister867 = ShiftLeft(uint32_t(r_PtxRegister866), uint32_t(1));					  // PTX L1606
	r_PtxRegister868 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister867);				  // PTX L1607
	r_PtxRegister869 = ShiftRight(uint32_t(r_PtxRegister868), uint32_t(31));				  // PTX L1608
	r_PtxRegister870 = uint32_t(r_PtxRegister868) + uint32_t(r_PtxRegister869);				  // PTX L1609
	r_PtxRegister871 = ShiftRightSigned(int32_t(r_PtxRegister870), uint32_t(1));			  // PTX L1610
	r_PtxU64Register202 = uint64_t(int64_t(int32_t(r_PtxRegister871)) * int64_t(int32_t(4))); // PTX L1611
	g_RecordByteAddressAtPtx1612 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register202); // PTX L1612
	r_PtxRegister420 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1612 + 524288ull);		  // PTX L1613
	r_LaneIndexAtPtx1615 = uint32_t((threadIdx.x & 31u));									  // PTX L1615
	r_PtxRegister872 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1615), uint32_t(31));		  // PTX L1617
	r_PtxRegister873 = ShiftRight(uint32_t(r_PtxRegister872), uint32_t(30));				  // PTX L1618
	r_PtxRegister874 = uint32_t(r_LaneIndexAtPtx1615) + uint32_t(r_PtxRegister873);			  // PTX L1619
	r_PtxRegister875 = r_PtxRegister874 & 2147483644;										  // PTX L1620
	r_PtxRegister876 = uint32_t(r_LaneIndexAtPtx1615) - uint32_t(r_PtxRegister875);			  // PTX L1621
	r_PtxRegister877 = ShiftLeft(uint32_t(r_PtxRegister876), uint32_t(1));					  // PTX L1622
	r_PtxRegister878 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister877);				  // PTX L1623
	r_PtxRegister879 = ShiftRight(uint32_t(r_PtxRegister878), uint32_t(31));				  // PTX L1624
	r_PtxRegister880 = uint32_t(r_PtxRegister878) + uint32_t(r_PtxRegister879);				  // PTX L1625
	r_PtxRegister881 = ShiftRightSigned(int32_t(r_PtxRegister880), uint32_t(1));			  // PTX L1626
	r_PtxU64Register204 = uint64_t(int64_t(int32_t(r_PtxRegister881)) * int64_t(int32_t(4))); // PTX L1627
	g_RecordByteAddressAtPtx1628 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register204); // PTX L1628
	r_PtxRegister422 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1628 + 524288ull);		  // PTX L1629
	r_LaneIndexAtPtx1631 = uint32_t((threadIdx.x & 31u));									  // PTX L1631
	r_PtxRegister882 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1631), uint32_t(31));		  // PTX L1633
	r_PtxRegister883 = ShiftRight(uint32_t(r_PtxRegister882), uint32_t(30));				  // PTX L1634
	r_PtxRegister884 = uint32_t(r_LaneIndexAtPtx1631) + uint32_t(r_PtxRegister883);			  // PTX L1635
	r_PtxRegister885 = r_PtxRegister884 & 2147483644;										  // PTX L1636
	r_PtxRegister886 = uint32_t(r_LaneIndexAtPtx1631) - uint32_t(r_PtxRegister885);			  // PTX L1637
	r_PtxRegister887 = ShiftLeft(uint32_t(r_PtxRegister886), uint32_t(1));					  // PTX L1638
	r_PtxRegister888 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister887);				  // PTX L1639
	r_PtxRegister889 = ShiftRightSigned(int32_t(r_PtxRegister888), uint32_t(1));			  // PTX L1640
	r_PtxU64Register206 = uint64_t(int64_t(int32_t(r_PtxRegister889)) * int64_t(int32_t(4))); // PTX L1641
	g_RecordByteAddressAtPtx1642 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register206); // PTX L1642
	r_PtxRegister424 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1642 + 524288ull);		  // PTX L1643
	r_LaneIndexAtPtx1645 = uint32_t((threadIdx.x & 31u));									  // PTX L1645
	r_PtxRegister890 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1645), uint32_t(31));		  // PTX L1647
	r_PtxRegister891 = ShiftRight(uint32_t(r_PtxRegister890), uint32_t(30));				  // PTX L1648
	r_PtxRegister892 = uint32_t(r_LaneIndexAtPtx1645) + uint32_t(r_PtxRegister891);			  // PTX L1649
	r_PtxRegister893 = r_PtxRegister892 & 2147483644;										  // PTX L1650
	r_PtxRegister894 = uint32_t(r_LaneIndexAtPtx1645) - uint32_t(r_PtxRegister893);			  // PTX L1651
	r_PtxRegister895 = ShiftLeft(uint32_t(r_PtxRegister894), uint32_t(1));					  // PTX L1652
	r_PtxRegister896 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister895);				  // PTX L1653
	r_PtxRegister897 = ShiftRightSigned(int32_t(r_PtxRegister896), uint32_t(1));			  // PTX L1654
	r_PtxU64Register208 = uint64_t(int64_t(int32_t(r_PtxRegister897)) * int64_t(int32_t(4))); // PTX L1655
	g_RecordByteAddressAtPtx1656 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register208); // PTX L1656
	r_PtxRegister426 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1656 + 524288ull);		  // PTX L1657
	r_LaneIndexAtPtx1659 = uint32_t((threadIdx.x & 31u));									  // PTX L1659
	r_PtxRegister898 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1659), uint32_t(31));		  // PTX L1661
	r_PtxRegister899 = ShiftRight(uint32_t(r_PtxRegister898), uint32_t(30));				  // PTX L1662
	r_PtxRegister900 = uint32_t(r_LaneIndexAtPtx1659) + uint32_t(r_PtxRegister899);			  // PTX L1663
	r_PtxRegister901 = r_PtxRegister900 & 2147483644;										  // PTX L1664
	r_PtxRegister902 = uint32_t(r_LaneIndexAtPtx1659) - uint32_t(r_PtxRegister901);			  // PTX L1665
	r_PtxRegister903 = ShiftLeft(uint32_t(r_PtxRegister902), uint32_t(1));					  // PTX L1666
	r_PtxRegister904 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister903);				  // PTX L1667
	r_PtxRegister905 = ShiftRightSigned(int32_t(r_PtxRegister904), uint32_t(1));			  // PTX L1668
	r_PtxU64Register210 = uint64_t(int64_t(int32_t(r_PtxRegister905)) * int64_t(int32_t(4))); // PTX L1669
	g_RecordByteAddressAtPtx1670 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register210); // PTX L1670
	r_PtxRegister428 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1670 + 524288ull);		  // PTX L1671
	r_LaneIndexAtPtx1673 = uint32_t((threadIdx.x & 31u));									  // PTX L1673
	r_PtxRegister906 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1673), uint32_t(31));		  // PTX L1675
	r_PtxRegister907 = ShiftRight(uint32_t(r_PtxRegister906), uint32_t(30));				  // PTX L1676
	r_PtxRegister908 = uint32_t(r_LaneIndexAtPtx1673) + uint32_t(r_PtxRegister907);			  // PTX L1677
	r_PtxRegister909 = r_PtxRegister908 & 2147483644;										  // PTX L1678
	r_PtxRegister910 = uint32_t(r_LaneIndexAtPtx1673) - uint32_t(r_PtxRegister909);			  // PTX L1679
	r_PtxRegister911 = ShiftLeft(uint32_t(r_PtxRegister910), uint32_t(1));					  // PTX L1680
	r_PtxRegister912 = uint32_t(r_PtxRegister456) + uint32_t(r_PtxRegister911);				  // PTX L1681
	r_PtxRegister913 = ShiftRightSigned(int32_t(r_PtxRegister912), uint32_t(1));			  // PTX L1682
	r_PtxU64Register212 = uint64_t(int64_t(int32_t(r_PtxRegister913)) * int64_t(int32_t(4))); // PTX L1683
	g_RecordByteAddressAtPtx1684 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register212); // PTX L1684
	r_PtxRegister430 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1684 + 524288ull);		  // PTX L1685
	r_LaneIndexAtPtx1687 = uint32_t((threadIdx.x & 31u));									  // PTX L1687
	r_PtxRegister914 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1687), uint32_t(31));		  // PTX L1689
	r_PtxRegister915 = ShiftRight(uint32_t(r_PtxRegister914), uint32_t(30));				  // PTX L1690
	r_PtxRegister916 = uint32_t(r_LaneIndexAtPtx1687) + uint32_t(r_PtxRegister915);			  // PTX L1691
	r_PtxRegister917 = r_PtxRegister916 & 2147483644;										  // PTX L1692
	r_PtxRegister918 = uint32_t(r_LaneIndexAtPtx1687) - uint32_t(r_PtxRegister917);			  // PTX L1693
	r_PtxRegister919 = ShiftLeft(uint32_t(r_PtxRegister918), uint32_t(1));					  // PTX L1694
	r_PtxRegister920 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister919);				  // PTX L1695
	r_PtxRegister921 = ShiftRightSigned(int32_t(r_PtxRegister920), uint32_t(1));			  // PTX L1696
	r_PtxU64Register214 = uint64_t(int64_t(int32_t(r_PtxRegister921)) * int64_t(int32_t(4))); // PTX L1697
	g_RecordByteAddressAtPtx1698 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register214); // PTX L1698
	r_PtxRegister432 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1698 + 524288ull);		  // PTX L1699
	r_LaneIndexAtPtx1701 = uint32_t((threadIdx.x & 31u));									  // PTX L1701
	r_PtxRegister922 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1701), uint32_t(31));		  // PTX L1703
	r_PtxRegister923 = ShiftRight(uint32_t(r_PtxRegister922), uint32_t(30));				  // PTX L1704
	r_PtxRegister924 = uint32_t(r_LaneIndexAtPtx1701) + uint32_t(r_PtxRegister923);			  // PTX L1705
	r_PtxRegister925 = r_PtxRegister924 & 2147483644;										  // PTX L1706
	r_PtxRegister926 = uint32_t(r_LaneIndexAtPtx1701) - uint32_t(r_PtxRegister925);			  // PTX L1707
	r_PtxRegister927 = ShiftLeft(uint32_t(r_PtxRegister926), uint32_t(1));					  // PTX L1708
	r_PtxRegister928 = uint32_t(r_PtxRegister455) + uint32_t(r_PtxRegister927);				  // PTX L1709
	r_PtxRegister929 = ShiftRightSigned(int32_t(r_PtxRegister928), uint32_t(1));			  // PTX L1710
	r_PtxU64Register216 = uint64_t(int64_t(int32_t(r_PtxRegister929)) * int64_t(int32_t(4))); // PTX L1711
	g_RecordByteAddressAtPtx1712 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register216); // PTX L1712
	r_PtxRegister434 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1712 + 524288ull);		  // PTX L1713
	r_LaneIndexAtPtx1715 = uint32_t((threadIdx.x & 31u));									  // PTX L1715
	r_PtxRegister930 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1715), uint32_t(31));		  // PTX L1717
	r_PtxRegister931 = ShiftRight(uint32_t(r_PtxRegister930), uint32_t(30));				  // PTX L1718
	r_PtxRegister932 = uint32_t(r_LaneIndexAtPtx1715) + uint32_t(r_PtxRegister931);			  // PTX L1719
	r_PtxRegister933 = r_PtxRegister932 & 2147483644;										  // PTX L1720
	r_PtxRegister934 = uint32_t(r_LaneIndexAtPtx1715) - uint32_t(r_PtxRegister933);			  // PTX L1721
	r_PtxRegister935 = ShiftLeft(uint32_t(r_PtxRegister934), uint32_t(1));					  // PTX L1722
	r_PtxRegister936 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister935);				  // PTX L1723
	r_PtxRegister937 = ShiftRight(uint32_t(r_PtxRegister936), uint32_t(31));				  // PTX L1724
	r_PtxRegister938 = uint32_t(r_PtxRegister936) + uint32_t(r_PtxRegister937);				  // PTX L1725
	r_PtxRegister939 = ShiftRightSigned(int32_t(r_PtxRegister938), uint32_t(1));			  // PTX L1726
	r_PtxU64Register218 = uint64_t(int64_t(int32_t(r_PtxRegister939)) * int64_t(int32_t(4))); // PTX L1727
	g_RecordByteAddressAtPtx1728 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register218); // PTX L1728
	r_PtxRegister436 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1728 + 524288ull);		  // PTX L1729
	r_LaneIndexAtPtx1731 = uint32_t((threadIdx.x & 31u));									  // PTX L1731
	r_PtxRegister940 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1731), uint32_t(31));		  // PTX L1733
	r_PtxRegister941 = ShiftRight(uint32_t(r_PtxRegister940), uint32_t(30));				  // PTX L1734
	r_PtxRegister942 = uint32_t(r_LaneIndexAtPtx1731) + uint32_t(r_PtxRegister941);			  // PTX L1735
	r_PtxRegister943 = r_PtxRegister942 & 2147483644;										  // PTX L1736
	r_PtxRegister944 = uint32_t(r_LaneIndexAtPtx1731) - uint32_t(r_PtxRegister943);			  // PTX L1737
	r_PtxRegister945 = ShiftLeft(uint32_t(r_PtxRegister944), uint32_t(1));					  // PTX L1738
	r_PtxRegister946 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister945);				  // PTX L1739
	r_PtxRegister947 = ShiftRight(uint32_t(r_PtxRegister946), uint32_t(31));				  // PTX L1740
	r_PtxRegister948 = uint32_t(r_PtxRegister946) + uint32_t(r_PtxRegister947);				  // PTX L1741
	r_PtxRegister949 = ShiftRightSigned(int32_t(r_PtxRegister948), uint32_t(1));			  // PTX L1742
	r_PtxU64Register220 = uint64_t(int64_t(int32_t(r_PtxRegister949)) * int64_t(int32_t(4))); // PTX L1743
	g_RecordByteAddressAtPtx1744 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register220); // PTX L1744
	r_PtxRegister438 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1744 + 524288ull);		  // PTX L1745
	r_LaneIndexAtPtx1747 = uint32_t((threadIdx.x & 31u));									  // PTX L1747
	r_PtxRegister950 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1747), uint32_t(31));		  // PTX L1749
	r_PtxRegister951 = ShiftRight(uint32_t(r_PtxRegister950), uint32_t(30));				  // PTX L1750
	r_PtxRegister952 = uint32_t(r_LaneIndexAtPtx1747) + uint32_t(r_PtxRegister951);			  // PTX L1751
	r_PtxRegister953 = r_PtxRegister952 & 2147483644;										  // PTX L1752
	r_PtxRegister954 = uint32_t(r_LaneIndexAtPtx1747) - uint32_t(r_PtxRegister953);			  // PTX L1753
	r_PtxRegister955 = ShiftLeft(uint32_t(r_PtxRegister954), uint32_t(1));					  // PTX L1754
	r_PtxRegister956 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister955);				  // PTX L1755
	r_PtxRegister957 = ShiftRightSigned(int32_t(r_PtxRegister956), uint32_t(1));			  // PTX L1756
	r_PtxU64Register222 = uint64_t(int64_t(int32_t(r_PtxRegister957)) * int64_t(int32_t(4))); // PTX L1757
	g_RecordByteAddressAtPtx1758 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register222); // PTX L1758
	r_PtxRegister440 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1758 + 524288ull);		  // PTX L1759
	r_LaneIndexAtPtx1761 = uint32_t((threadIdx.x & 31u));									  // PTX L1761
	r_PtxRegister958 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1761), uint32_t(31));		  // PTX L1763
	r_PtxRegister959 = ShiftRight(uint32_t(r_PtxRegister958), uint32_t(30));				  // PTX L1764
	r_PtxRegister960 = uint32_t(r_LaneIndexAtPtx1761) + uint32_t(r_PtxRegister959);			  // PTX L1765
	r_PtxRegister961 = r_PtxRegister960 & 2147483644;										  // PTX L1766
	r_PtxRegister962 = uint32_t(r_LaneIndexAtPtx1761) - uint32_t(r_PtxRegister961);			  // PTX L1767
	r_PtxRegister963 = ShiftLeft(uint32_t(r_PtxRegister962), uint32_t(1));					  // PTX L1768
	r_PtxRegister964 = uint32_t(r_PtxRegister532) + uint32_t(r_PtxRegister963);				  // PTX L1769
	r_PtxRegister965 = ShiftRightSigned(int32_t(r_PtxRegister964), uint32_t(1));			  // PTX L1770
	r_PtxU64Register224 = uint64_t(int64_t(int32_t(r_PtxRegister965)) * int64_t(int32_t(4))); // PTX L1771
	g_RecordByteAddressAtPtx1772 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register224); // PTX L1772
	r_PtxRegister442 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1772 + 524288ull);		  // PTX L1773
	r_LaneIndexAtPtx1775 = uint32_t((threadIdx.x & 31u));									  // PTX L1775
	r_PtxRegister966 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1775), uint32_t(31));		  // PTX L1777
	r_PtxRegister967 = ShiftRight(uint32_t(r_PtxRegister966), uint32_t(30));				  // PTX L1778
	r_PtxRegister968 = uint32_t(r_LaneIndexAtPtx1775) + uint32_t(r_PtxRegister967);			  // PTX L1779
	r_PtxRegister969 = r_PtxRegister968 & 2147483644;										  // PTX L1780
	r_PtxRegister970 = uint32_t(r_LaneIndexAtPtx1775) - uint32_t(r_PtxRegister969);			  // PTX L1781
	r_PtxRegister971 = ShiftLeft(uint32_t(r_PtxRegister970), uint32_t(1));					  // PTX L1782
	r_PtxRegister972 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister971);				  // PTX L1783
	r_PtxRegister973 = ShiftRight(uint32_t(r_PtxRegister972), uint32_t(31));				  // PTX L1784
	r_PtxRegister974 = uint32_t(r_PtxRegister972) + uint32_t(r_PtxRegister973);				  // PTX L1785
	r_PtxRegister975 = ShiftRightSigned(int32_t(r_PtxRegister974), uint32_t(1));			  // PTX L1786
	r_PtxU64Register226 = uint64_t(int64_t(int32_t(r_PtxRegister975)) * int64_t(int32_t(4))); // PTX L1787
	g_RecordByteAddressAtPtx1788 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register226); // PTX L1788
	r_PtxRegister444 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1788 + 524288ull);		  // PTX L1789
	r_LaneIndexAtPtx1791 = uint32_t((threadIdx.x & 31u));									  // PTX L1791
	r_PtxRegister976 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1791), uint32_t(31));		  // PTX L1793
	r_PtxRegister977 = ShiftRight(uint32_t(r_PtxRegister976), uint32_t(30));				  // PTX L1794
	r_PtxRegister978 = uint32_t(r_LaneIndexAtPtx1791) + uint32_t(r_PtxRegister977);			  // PTX L1795
	r_PtxRegister979 = r_PtxRegister978 & 2147483644;										  // PTX L1796
	r_PtxRegister980 = uint32_t(r_LaneIndexAtPtx1791) - uint32_t(r_PtxRegister979);			  // PTX L1797
	r_PtxRegister981 = ShiftLeft(uint32_t(r_PtxRegister980), uint32_t(1));					  // PTX L1798
	r_PtxRegister982 = uint32_t(r_PtxRegister549) + uint32_t(r_PtxRegister981);				  // PTX L1799
	r_PtxRegister983 = ShiftRight(uint32_t(r_PtxRegister982), uint32_t(31));				  // PTX L1800
	r_PtxRegister984 = uint32_t(r_PtxRegister982) + uint32_t(r_PtxRegister983);				  // PTX L1801
	r_PtxRegister985 = ShiftRightSigned(int32_t(r_PtxRegister984), uint32_t(1));			  // PTX L1802
	r_PtxU64Register228 = uint64_t(int64_t(int32_t(r_PtxRegister985)) * int64_t(int32_t(4))); // PTX L1803
	g_RecordByteAddressAtPtx1804 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register228); // PTX L1804
	r_PtxRegister446 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1804 + 524288ull);		  // PTX L1805
	r_LaneIndexAtPtx1807 = uint32_t((threadIdx.x & 31u));									  // PTX L1807
	r_PtxRegister986 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1807), uint32_t(31));		  // PTX L1809
	r_PtxRegister987 = ShiftRight(uint32_t(r_PtxRegister986), uint32_t(30));				  // PTX L1810
	r_PtxRegister988 = uint32_t(r_LaneIndexAtPtx1807) + uint32_t(r_PtxRegister987);			  // PTX L1811
	r_PtxRegister989 = r_PtxRegister988 & 2147483644;										  // PTX L1812
	r_PtxRegister990 = uint32_t(r_LaneIndexAtPtx1807) - uint32_t(r_PtxRegister989);			  // PTX L1813
	r_PtxRegister991 = ShiftLeft(uint32_t(r_PtxRegister990), uint32_t(1));					  // PTX L1814
	r_PtxRegister992 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister991);				  // PTX L1815
	r_PtxRegister993 = ShiftRightSigned(int32_t(r_PtxRegister992), uint32_t(1));			  // PTX L1816
	r_PtxU64Register230 = uint64_t(int64_t(int32_t(r_PtxRegister993)) * int64_t(int32_t(4))); // PTX L1817
	g_RecordByteAddressAtPtx1818 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register230); // PTX L1818
	r_PtxRegister448 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1818 + 524288ull);		   // PTX L1819
	r_LaneIndexAtPtx1821 = uint32_t((threadIdx.x & 31u));									   // PTX L1821
	r_PtxRegister994 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1821), uint32_t(31));		   // PTX L1823
	r_PtxRegister995 = ShiftRight(uint32_t(r_PtxRegister994), uint32_t(30));				   // PTX L1824
	r_PtxRegister996 = uint32_t(r_LaneIndexAtPtx1821) + uint32_t(r_PtxRegister995);			   // PTX L1825
	r_PtxRegister997 = r_PtxRegister996 & 2147483644;										   // PTX L1826
	r_PtxRegister998 = uint32_t(r_LaneIndexAtPtx1821) - uint32_t(r_PtxRegister997);			   // PTX L1827
	r_PtxRegister999 = ShiftLeft(uint32_t(r_PtxRegister998), uint32_t(1));					   // PTX L1828
	r_PtxRegister1000 = uint32_t(r_PtxRegister570) + uint32_t(r_PtxRegister999);			   // PTX L1829
	r_PtxRegister1001 = ShiftRightSigned(int32_t(r_PtxRegister1000), uint32_t(1));			   // PTX L1830
	r_PtxU64Register232 = uint64_t(int64_t(int32_t(r_PtxRegister1001)) * int64_t(int32_t(4))); // PTX L1831
	g_RecordByteAddressAtPtx1832 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register232); // PTX L1832
	r_PtxRegister450 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1832 + 524288ull);		   // PTX L1833
	r_LaneIndexAtPtx1835 = uint32_t((threadIdx.x & 31u));									   // PTX L1835
	r_PtxRegister1002 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1835), uint32_t(31));		   // PTX L1837
	r_PtxRegister1003 = ShiftRight(uint32_t(r_PtxRegister1002), uint32_t(30));				   // PTX L1838
	r_PtxRegister1004 = uint32_t(r_LaneIndexAtPtx1835) + uint32_t(r_PtxRegister1003);		   // PTX L1839
	r_PtxRegister1005 = r_PtxRegister1004 & 2147483644;										   // PTX L1840
	r_PtxRegister1006 = uint32_t(r_LaneIndexAtPtx1835) - uint32_t(r_PtxRegister1005);		   // PTX L1841
	r_PtxRegister1007 = ShiftLeft(uint32_t(r_PtxRegister1006), uint32_t(1));				   // PTX L1842
	r_PtxRegister1008 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister1007);			   // PTX L1843
	r_PtxRegister1009 = ShiftRight(uint32_t(r_PtxRegister1008), uint32_t(31));				   // PTX L1844
	r_PtxRegister1010 = uint32_t(r_PtxRegister1008) + uint32_t(r_PtxRegister1009);			   // PTX L1845
	r_PtxRegister1011 = ShiftRightSigned(int32_t(r_PtxRegister1010), uint32_t(1));			   // PTX L1846
	r_PtxU64Register234 = uint64_t(int64_t(int32_t(r_PtxRegister1011)) * int64_t(int32_t(4))); // PTX L1847
	g_RecordByteAddressAtPtx1848 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register234); // PTX L1848
	r_PtxRegister452 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1848 + 524288ull);		   // PTX L1849
	r_LaneIndexAtPtx1851 = uint32_t((threadIdx.x & 31u));									   // PTX L1851
	r_PtxRegister1012 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1851), uint32_t(31));		   // PTX L1853
	r_PtxRegister1013 = ShiftRight(uint32_t(r_PtxRegister1012), uint32_t(30));				   // PTX L1854
	r_PtxRegister1014 = uint32_t(r_LaneIndexAtPtx1851) + uint32_t(r_PtxRegister1013);		   // PTX L1855
	r_PtxRegister1015 = r_PtxRegister1014 & 2147483644;										   // PTX L1856
	r_PtxRegister1016 = uint32_t(r_LaneIndexAtPtx1851) - uint32_t(r_PtxRegister1015);		   // PTX L1857
	r_PtxRegister1017 = ShiftLeft(uint32_t(r_PtxRegister1016), uint32_t(1));				   // PTX L1858
	r_PtxRegister1018 = uint32_t(r_PtxRegister587) + uint32_t(r_PtxRegister1017);			   // PTX L1859
	r_PtxRegister1019 = ShiftRight(uint32_t(r_PtxRegister1018), uint32_t(31));				   // PTX L1860
	r_PtxRegister1020 = uint32_t(r_PtxRegister1018) + uint32_t(r_PtxRegister1019);			   // PTX L1861
	r_PtxRegister1021 = ShiftRightSigned(int32_t(r_PtxRegister1020), uint32_t(1));			   // PTX L1862
	r_PtxU64Register236 = uint64_t(int64_t(int32_t(r_PtxRegister1021)) * int64_t(int32_t(4))); // PTX L1863
	g_RecordByteAddressAtPtx1864 =
		uint64_t(g_RecordByteAddressAtPtx914) + uint64_t(r_PtxU64Register236); // PTX L1864
	r_PtxRegister454 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1864 + 524288ull);	 // PTX L1865
	r_LaneIndexAtPtx1867 = uint32_t((threadIdx.x & 31u));								 // PTX L1867
	r_PackedHalf2AtPtx1870R1395 = HalfMul(r_PackedHalf2AtPtx582R1270, r_PtxRegister328); // PTX L1870
	r_LaneIndexAtPtx1874 = uint32_t((threadIdx.x & 31u));								 // PTX L1874
	r_PackedHalf2AtPtx1877R1394 = HalfMul(r_PackedHalf2AtPtx583R1271, r_PtxRegister330); // PTX L1877
	r_LaneIndexAtPtx1881 = uint32_t((threadIdx.x & 31u));								 // PTX L1881
	r_PackedHalf2AtPtx1884R1393 = HalfMul(r_PackedHalf2AtPtx584R1272, r_PtxRegister332); // PTX L1884
	r_LaneIndexAtPtx1888 = uint32_t((threadIdx.x & 31u));								 // PTX L1888
	r_PackedHalf2AtPtx1891R1392 = HalfMul(r_PackedHalf2AtPtx585R1273, r_PtxRegister334); // PTX L1891
	r_LaneIndexAtPtx1895 = uint32_t((threadIdx.x & 31u));								 // PTX L1895
	r_PackedHalf2AtPtx1898R1391 = HalfMul(r_PackedHalf2AtPtx601R1274, r_PtxRegister336); // PTX L1898
	r_LaneIndexAtPtx1902 = uint32_t((threadIdx.x & 31u));								 // PTX L1902
	r_PackedHalf2AtPtx1905R1390 = HalfMul(r_PackedHalf2AtPtx602R1275, r_PtxRegister338); // PTX L1905
	r_LaneIndexAtPtx1909 = uint32_t((threadIdx.x & 31u));								 // PTX L1909
	r_PackedHalf2AtPtx1912R1389 = HalfMul(r_PackedHalf2AtPtx603R1276, r_PtxRegister340); // PTX L1912
	r_LaneIndexAtPtx1916 = uint32_t((threadIdx.x & 31u));								 // PTX L1916
	r_PackedHalf2AtPtx1919R1388 = HalfMul(r_PackedHalf2AtPtx604R1277, r_PtxRegister342); // PTX L1919
	r_LaneIndexAtPtx1923 = uint32_t((threadIdx.x & 31u));								 // PTX L1923
	r_PackedHalf2AtPtx1926R1387 = HalfMul(r_PackedHalf2AtPtx620R1278, r_PtxRegister344); // PTX L1926
	r_LaneIndexAtPtx1930 = uint32_t((threadIdx.x & 31u));								 // PTX L1930
	r_PackedHalf2AtPtx1933R1386 = HalfMul(r_PackedHalf2AtPtx621R1279, r_PtxRegister346); // PTX L1933
	r_LaneIndexAtPtx1937 = uint32_t((threadIdx.x & 31u));								 // PTX L1937
	r_PackedHalf2AtPtx1940R1385 = HalfMul(r_PackedHalf2AtPtx622R1280, r_PtxRegister348); // PTX L1940
	r_LaneIndexAtPtx1944 = uint32_t((threadIdx.x & 31u));								 // PTX L1944
	r_PackedHalf2AtPtx1947R1384 = HalfMul(r_PackedHalf2AtPtx623R1281, r_PtxRegister350); // PTX L1947
	r_LaneIndexAtPtx1951 = uint32_t((threadIdx.x & 31u));								 // PTX L1951
	r_PackedHalf2AtPtx1954R1383 = HalfMul(r_PackedHalf2AtPtx639R1282, r_PtxRegister352); // PTX L1954
	r_LaneIndexAtPtx1958 = uint32_t((threadIdx.x & 31u));								 // PTX L1958
	r_PackedHalf2AtPtx1961R1382 = HalfMul(r_PackedHalf2AtPtx640R1283, r_PtxRegister354); // PTX L1961
	r_LaneIndexAtPtx1965 = uint32_t((threadIdx.x & 31u));								 // PTX L1965
	r_PackedHalf2AtPtx1968R1381 = HalfMul(r_PackedHalf2AtPtx641R1284, r_PtxRegister356); // PTX L1968
	r_LaneIndexAtPtx1972 = uint32_t((threadIdx.x & 31u));								 // PTX L1972
	r_PackedHalf2AtPtx1975R1380 = HalfMul(r_PackedHalf2AtPtx642R1285, r_PtxRegister358); // PTX L1975
	r_LaneIndexAtPtx1979 = uint32_t((threadIdx.x & 31u));								 // PTX L1979
	r_PackedHalf2AtPtx1982R1379 = HalfMul(r_PackedHalf2AtPtx664R1286, r_PtxRegister360); // PTX L1982
	r_LaneIndexAtPtx1986 = uint32_t((threadIdx.x & 31u));								 // PTX L1986
	r_PackedHalf2AtPtx1989R1378 = HalfMul(r_PackedHalf2AtPtx665R1287, r_PtxRegister362); // PTX L1989
	r_LaneIndexAtPtx1993 = uint32_t((threadIdx.x & 31u));								 // PTX L1993
	r_PackedHalf2AtPtx1996R1377 = HalfMul(r_PackedHalf2AtPtx666R1288, r_PtxRegister364); // PTX L1996
	r_LaneIndexAtPtx2000 = uint32_t((threadIdx.x & 31u));								 // PTX L2000
	r_PackedHalf2AtPtx2003R1376 = HalfMul(r_PackedHalf2AtPtx667R1289, r_PtxRegister366); // PTX L2003
	r_LaneIndexAtPtx2007 = uint32_t((threadIdx.x & 31u));								 // PTX L2007
	r_PackedHalf2AtPtx2010R1375 = HalfMul(r_PackedHalf2AtPtx683R1290, r_PtxRegister368); // PTX L2010
	r_LaneIndexAtPtx2014 = uint32_t((threadIdx.x & 31u));								 // PTX L2014
	r_PackedHalf2AtPtx2017R1374 = HalfMul(r_PackedHalf2AtPtx684R1291, r_PtxRegister370); // PTX L2017
	r_LaneIndexAtPtx2021 = uint32_t((threadIdx.x & 31u));								 // PTX L2021
	r_PackedHalf2AtPtx2024R1373 = HalfMul(r_PackedHalf2AtPtx685R1292, r_PtxRegister372); // PTX L2024
	r_LaneIndexAtPtx2028 = uint32_t((threadIdx.x & 31u));								 // PTX L2028
	r_PackedHalf2AtPtx2031R1372 = HalfMul(r_PackedHalf2AtPtx686R1293, r_PtxRegister374); // PTX L2031
	r_LaneIndexAtPtx2035 = uint32_t((threadIdx.x & 31u));								 // PTX L2035
	r_PackedHalf2AtPtx2038R1371 = HalfMul(r_PackedHalf2AtPtx702R1294, r_PtxRegister376); // PTX L2038
	r_LaneIndexAtPtx2042 = uint32_t((threadIdx.x & 31u));								 // PTX L2042
	r_PackedHalf2AtPtx2045R1370 = HalfMul(r_PackedHalf2AtPtx703R1295, r_PtxRegister378); // PTX L2045
	r_LaneIndexAtPtx2049 = uint32_t((threadIdx.x & 31u));								 // PTX L2049
	r_PackedHalf2AtPtx2052R1369 = HalfMul(r_PackedHalf2AtPtx704R1296, r_PtxRegister380); // PTX L2052
	r_LaneIndexAtPtx2056 = uint32_t((threadIdx.x & 31u));								 // PTX L2056
	r_PackedHalf2AtPtx2059R1368 = HalfMul(r_PackedHalf2AtPtx705R1297, r_PtxRegister382); // PTX L2059
	r_LaneIndexAtPtx2063 = uint32_t((threadIdx.x & 31u));								 // PTX L2063
	r_PackedHalf2AtPtx2066R1367 = HalfMul(r_PackedHalf2AtPtx721R1298, r_PtxRegister384); // PTX L2066
	r_LaneIndexAtPtx2070 = uint32_t((threadIdx.x & 31u));								 // PTX L2070
	r_PackedHalf2AtPtx2073R1366 = HalfMul(r_PackedHalf2AtPtx722R1299, r_PtxRegister386); // PTX L2073
	r_LaneIndexAtPtx2077 = uint32_t((threadIdx.x & 31u));								 // PTX L2077
	r_PackedHalf2AtPtx2080R1365 = HalfMul(r_PackedHalf2AtPtx723R1300, r_PtxRegister388); // PTX L2080
	r_LaneIndexAtPtx2084 = uint32_t((threadIdx.x & 31u));								 // PTX L2084
	r_PackedHalf2AtPtx2087R1364 = HalfMul(r_PackedHalf2AtPtx724R1301, r_PtxRegister390); // PTX L2087
	r_LaneIndexAtPtx2091 = uint32_t((threadIdx.x & 31u));								 // PTX L2091
	r_PackedHalf2AtPtx2094R1363 = HalfMul(r_PackedHalf2AtPtx757R1302, r_PtxRegister392); // PTX L2094
	r_LaneIndexAtPtx2098 = uint32_t((threadIdx.x & 31u));								 // PTX L2098
	r_PackedHalf2AtPtx2101R1362 = HalfMul(r_PackedHalf2AtPtx758R1303, r_PtxRegister394); // PTX L2101
	r_LaneIndexAtPtx2105 = uint32_t((threadIdx.x & 31u));								 // PTX L2105
	r_PackedHalf2AtPtx2108R1361 = HalfMul(r_PackedHalf2AtPtx759R1304, r_PtxRegister396); // PTX L2108
	r_LaneIndexAtPtx2112 = uint32_t((threadIdx.x & 31u));								 // PTX L2112
	r_PackedHalf2AtPtx2115R1360 = HalfMul(r_PackedHalf2AtPtx760R1305, r_PtxRegister398); // PTX L2115
	r_LaneIndexAtPtx2119 = uint32_t((threadIdx.x & 31u));								 // PTX L2119
	r_PackedHalf2AtPtx2122R1359 = HalfMul(r_PackedHalf2AtPtx776R1306, r_PtxRegister400); // PTX L2122
	r_LaneIndexAtPtx2126 = uint32_t((threadIdx.x & 31u));								 // PTX L2126
	r_PackedHalf2AtPtx2129R1358 = HalfMul(r_PackedHalf2AtPtx777R1307, r_PtxRegister402); // PTX L2129
	r_LaneIndexAtPtx2133 = uint32_t((threadIdx.x & 31u));								 // PTX L2133
	r_PackedHalf2AtPtx2136R1357 = HalfMul(r_PackedHalf2AtPtx778R1308, r_PtxRegister404); // PTX L2136
	r_LaneIndexAtPtx2140 = uint32_t((threadIdx.x & 31u));								 // PTX L2140
	r_PackedHalf2AtPtx2143R1356 = HalfMul(r_PackedHalf2AtPtx779R1309, r_PtxRegister406); // PTX L2143
	r_LaneIndexAtPtx2147 = uint32_t((threadIdx.x & 31u));								 // PTX L2147
	r_PackedHalf2AtPtx2150R1355 = HalfMul(r_PackedHalf2AtPtx795R1310, r_PtxRegister408); // PTX L2150
	r_LaneIndexAtPtx2154 = uint32_t((threadIdx.x & 31u));								 // PTX L2154
	r_PackedHalf2AtPtx2157R1354 = HalfMul(r_PackedHalf2AtPtx796R1311, r_PtxRegister410); // PTX L2157
	r_LaneIndexAtPtx2161 = uint32_t((threadIdx.x & 31u));								 // PTX L2161
	r_PackedHalf2AtPtx2164R1353 = HalfMul(r_PackedHalf2AtPtx797R1312, r_PtxRegister412); // PTX L2164
	r_LaneIndexAtPtx2168 = uint32_t((threadIdx.x & 31u));								 // PTX L2168
	r_PackedHalf2AtPtx2171R1352 = HalfMul(r_PackedHalf2AtPtx798R1313, r_PtxRegister414); // PTX L2171
	r_LaneIndexAtPtx2175 = uint32_t((threadIdx.x & 31u));								 // PTX L2175
	r_PackedHalf2AtPtx2178R1351 = HalfMul(r_PackedHalf2AtPtx814R1314, r_PtxRegister416); // PTX L2178
	r_LaneIndexAtPtx2182 = uint32_t((threadIdx.x & 31u));								 // PTX L2182
	r_PackedHalf2AtPtx2185R1350 = HalfMul(r_PackedHalf2AtPtx815R1315, r_PtxRegister418); // PTX L2185
	r_LaneIndexAtPtx2189 = uint32_t((threadIdx.x & 31u));								 // PTX L2189
	r_PackedHalf2AtPtx2192R1349 = HalfMul(r_PackedHalf2AtPtx816R1316, r_PtxRegister420); // PTX L2192
	r_LaneIndexAtPtx2196 = uint32_t((threadIdx.x & 31u));								 // PTX L2196
	r_PackedHalf2AtPtx2199R1348 = HalfMul(r_PackedHalf2AtPtx817R1317, r_PtxRegister422); // PTX L2199
	r_LaneIndexAtPtx2203 = uint32_t((threadIdx.x & 31u));								 // PTX L2203
	r_PackedHalf2AtPtx2206R1347 = HalfMul(r_PackedHalf2AtPtx838R1318, r_PtxRegister424); // PTX L2206
	r_LaneIndexAtPtx2210 = uint32_t((threadIdx.x & 31u));								 // PTX L2210
	r_PackedHalf2AtPtx2213R1346 = HalfMul(r_PackedHalf2AtPtx839R1319, r_PtxRegister426); // PTX L2213
	r_LaneIndexAtPtx2217 = uint32_t((threadIdx.x & 31u));								 // PTX L2217
	r_PackedHalf2AtPtx2220R1345 = HalfMul(r_PackedHalf2AtPtx840R1320, r_PtxRegister428); // PTX L2220
	r_LaneIndexAtPtx2224 = uint32_t((threadIdx.x & 31u));								 // PTX L2224
	r_PackedHalf2AtPtx2227R1344 = HalfMul(r_PackedHalf2AtPtx841R1321, r_PtxRegister430); // PTX L2227
	r_LaneIndexAtPtx2231 = uint32_t((threadIdx.x & 31u));								 // PTX L2231
	r_PackedHalf2AtPtx2234R1343 = HalfMul(r_PackedHalf2AtPtx857R1322, r_PtxRegister432); // PTX L2234
	r_LaneIndexAtPtx2238 = uint32_t((threadIdx.x & 31u));								 // PTX L2238
	r_PackedHalf2AtPtx2241R1342 = HalfMul(r_PackedHalf2AtPtx858R1323, r_PtxRegister434); // PTX L2241
	r_LaneIndexAtPtx2245 = uint32_t((threadIdx.x & 31u));								 // PTX L2245
	r_PackedHalf2AtPtx2248R1341 = HalfMul(r_PackedHalf2AtPtx859R1324, r_PtxRegister436); // PTX L2248
	r_LaneIndexAtPtx2252 = uint32_t((threadIdx.x & 31u));								 // PTX L2252
	r_PackedHalf2AtPtx2255R1340 = HalfMul(r_PackedHalf2AtPtx860R1325, r_PtxRegister438); // PTX L2255
	r_LaneIndexAtPtx2259 = uint32_t((threadIdx.x & 31u));								 // PTX L2259
	r_PackedHalf2AtPtx2262R1339 = HalfMul(r_PackedHalf2AtPtx876R1326, r_PtxRegister440); // PTX L2262
	r_LaneIndexAtPtx2266 = uint32_t((threadIdx.x & 31u));								 // PTX L2266
	r_PackedHalf2AtPtx2269R1338 = HalfMul(r_PackedHalf2AtPtx877R1327, r_PtxRegister442); // PTX L2269
	r_LaneIndexAtPtx2273 = uint32_t((threadIdx.x & 31u));								 // PTX L2273
	r_PackedHalf2AtPtx2276R1337 = HalfMul(r_PackedHalf2AtPtx878R1328, r_PtxRegister444); // PTX L2276
	r_LaneIndexAtPtx2280 = uint32_t((threadIdx.x & 31u));								 // PTX L2280
	r_PackedHalf2AtPtx2283R1336 = HalfMul(r_PackedHalf2AtPtx879R1329, r_PtxRegister446); // PTX L2283
	r_LaneIndexAtPtx2287 = uint32_t((threadIdx.x & 31u));								 // PTX L2287
	r_PackedHalf2AtPtx2290R1335 = HalfMul(r_PackedHalf2AtPtx895R1330, r_PtxRegister448); // PTX L2290
	r_LaneIndexAtPtx2294 = uint32_t((threadIdx.x & 31u));								 // PTX L2294
	r_PackedHalf2AtPtx2297R1334 = HalfMul(r_PackedHalf2AtPtx896R1331, r_PtxRegister450); // PTX L2297
	r_LaneIndexAtPtx2301 = uint32_t((threadIdx.x & 31u));								 // PTX L2301
	r_PackedHalf2AtPtx2304R1396 = HalfMul(r_PackedHalf2AtPtx897R1332, r_PtxRegister452); // PTX L2304
	r_LaneIndexAtPtx2308 = uint32_t((threadIdx.x & 31u));								 // PTX L2308
	r_PackedHalf2AtPtx2311R1397 = HalfMul(r_PackedHalf2AtPtx898R1333, r_PtxRegister454); // PTX L2311
	r_PtxRegister1398 = uint32_t(0);													 // PTX L2314
L__BB12_103:																			 // PTX L2315
	r_PtxRegister1134 = ShiftRight(uint32_t(r_PtxRegister1398), uint32_t(5));			 // PTX L2316
	r_PtxU16Register1 = uint16_t(r_PtxRegister1134);									 // PTX L2317
	r_PtxU16Register2 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register1)) * uint32_t(uint16_t(171)));				 // PTX L2318
	r_PtxU16Register3 = ShiftRight(uint16_t(r_PtxU16Register2), uint32_t(9));					 // PTX L2319
	r_PtxU16Register4 = uint16_t(uint32_t(uint16_t(r_PtxU16Register3)) * uint32_t(uint16_t(3))); // PTX L2320
	r_PtxU16Register5 = uint16_t(r_PtxU16Register1) - uint16_t(r_PtxU16Register4);				 // PTX L2321
	r_PtxRegister1135 = uint32_t(uint16_t(r_PtxU16Register5));									 // PTX L2322
	r_PtxRegister35 = r_PtxRegister1135 & 255;													 // PTX L2323
	r_PtxU16Register6 = r_PtxU16Register5 & 255;												 // PTX L2324
	r_PtxRegister1136 = uint32_t(uint16_t(r_PtxU16Register6)) * uint32_t(uint16_t(4096));		 // PTX L2325
	r_LaneIndexAtPtx2327 = uint32_t((threadIdx.x & 31u));										 // PTX L2327
	r_PtxRegister1137 = uint32_t(0u /* exact native shared-region offset */);					 // PTX L2329
	r_PtxRegister36 = uint32_t(r_PtxRegister1137) + uint32_t(r_PtxRegister1136);				 // PTX L2330
	r_PtxRegister1138 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2327), uint32_t(4));					 // PTX L2331
	r_PtxRegister1023 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1138);				 // PTX L2332
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1023));
		r_MmaAHalf2WordAtPtx2334R1038 = r_Value.x;
		r_MmaAHalf2WordAtPtx2334R1039 = r_Value.y;
		r_MmaAHalf2WordAtPtx2334R1040 = r_Value.z;
		r_MmaAHalf2WordAtPtx2334R1041 = r_Value.w;
	} // PTX L2334
	r_LaneIndexAtPtx2337 = uint32_t((threadIdx.x & 31u));						 // PTX L2337
	r_PtxRegister1139 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2337), uint32_t(4));	 // PTX L2339
	r_PtxRegister1140 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1139); // PTX L2340
	r_PtxRegister1025 = uint32_t(r_PtxRegister1140) + uint32_t(512);			 // PTX L2341
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1025));
		r_MmaAHalf2WordAtPtx2343R1042 = r_Value.x;
		r_MmaAHalf2WordAtPtx2343R1043 = r_Value.y;
		r_MmaAHalf2WordAtPtx2343R1044 = r_Value.z;
		r_MmaAHalf2WordAtPtx2343R1045 = r_Value.w;
	} // PTX L2343
	r_LaneIndexAtPtx2346 = uint32_t((threadIdx.x & 31u));						 // PTX L2346
	r_PtxRegister1141 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2346), uint32_t(4));	 // PTX L2348
	r_PtxRegister1142 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1141); // PTX L2349
	r_PtxRegister1027 = uint32_t(r_PtxRegister1142) + uint32_t(1024);			 // PTX L2350
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1027));
		r_MmaAHalf2WordAtPtx2352R1062 = r_Value.x;
		r_MmaAHalf2WordAtPtx2352R1063 = r_Value.y;
		r_MmaAHalf2WordAtPtx2352R1064 = r_Value.z;
		r_MmaAHalf2WordAtPtx2352R1065 = r_Value.w;
	} // PTX L2352
	r_LaneIndexAtPtx2355 = uint32_t((threadIdx.x & 31u));						 // PTX L2355
	r_PtxRegister1143 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2355), uint32_t(4));	 // PTX L2357
	r_PtxRegister1144 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1143); // PTX L2358
	r_PtxRegister1029 = uint32_t(r_PtxRegister1144) + uint32_t(1536);			 // PTX L2359
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1029));
		r_MmaAHalf2WordAtPtx2361R1066 = r_Value.x;
		r_MmaAHalf2WordAtPtx2361R1067 = r_Value.y;
		r_MmaAHalf2WordAtPtx2361R1068 = r_Value.z;
		r_MmaAHalf2WordAtPtx2361R1069 = r_Value.w;
	} // PTX L2361
	r_LaneIndexAtPtx2364 = uint32_t((threadIdx.x & 31u));						 // PTX L2364
	r_PtxRegister1145 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2364), uint32_t(4));	 // PTX L2366
	r_PtxRegister1146 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1145); // PTX L2367
	r_PtxRegister1031 = uint32_t(r_PtxRegister1146) + uint32_t(2048);			 // PTX L2368
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1031));
		r_MmaAHalf2WordAtPtx2370R1086 = r_Value.x;
		r_MmaAHalf2WordAtPtx2370R1087 = r_Value.y;
		r_MmaAHalf2WordAtPtx2370R1088 = r_Value.z;
		r_MmaAHalf2WordAtPtx2370R1089 = r_Value.w;
	} // PTX L2370
	r_LaneIndexAtPtx2373 = uint32_t((threadIdx.x & 31u));						 // PTX L2373
	r_PtxRegister1147 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2373), uint32_t(4));	 // PTX L2375
	r_PtxRegister1148 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1147); // PTX L2376
	r_PtxRegister1033 = uint32_t(r_PtxRegister1148) + uint32_t(2560);			 // PTX L2377
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1033));
		r_MmaAHalf2WordAtPtx2379R1090 = r_Value.x;
		r_MmaAHalf2WordAtPtx2379R1091 = r_Value.y;
		r_MmaAHalf2WordAtPtx2379R1092 = r_Value.z;
		r_MmaAHalf2WordAtPtx2379R1093 = r_Value.w;
	} // PTX L2379
	r_LaneIndexAtPtx2382 = uint32_t((threadIdx.x & 31u));						 // PTX L2382
	r_PtxRegister1149 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2382), uint32_t(4));	 // PTX L2384
	r_PtxRegister1150 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1149); // PTX L2385
	r_PtxRegister1035 = uint32_t(r_PtxRegister1150) + uint32_t(3072);			 // PTX L2386
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1035));
		r_MmaAHalf2WordAtPtx2388R1110 = r_Value.x;
		r_MmaAHalf2WordAtPtx2388R1111 = r_Value.y;
		r_MmaAHalf2WordAtPtx2388R1112 = r_Value.z;
		r_MmaAHalf2WordAtPtx2388R1113 = r_Value.w;
	} // PTX L2388
	r_LaneIndexAtPtx2391 = uint32_t((threadIdx.x & 31u));						 // PTX L2391
	r_PtxRegister1151 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2391), uint32_t(4));	 // PTX L2393
	r_PtxRegister1152 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1151); // PTX L2394
	r_PtxRegister1037 = uint32_t(r_PtxRegister1152) + uint32_t(3584);			 // PTX L2395
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1037));
		r_MmaAHalf2WordAtPtx2397R1114 = r_Value.x;
		r_MmaAHalf2WordAtPtx2397R1115 = r_Value.y;
		r_MmaAHalf2WordAtPtx2397R1116 = r_Value.z;
		r_MmaAHalf2WordAtPtx2397R1117 = r_Value.w;
	} // PTX L2397
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2400R1046, r_MmaAccumulatorHalf2WordAtPtx2400R1047,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx84R1430, r_MmaBHalf2WordAtPtx84R1429,
			r_PackedHalf2AtPtx1870R1395, r_PackedHalf2AtPtx1877R1394); // PTX L2400
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2407R1048, r_MmaAccumulatorHalf2WordAtPtx2407R1049,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx84R1428, r_MmaBHalf2WordAtPtx84R1427,
			r_PackedHalf2AtPtx1884R1393, r_PackedHalf2AtPtx1891R1392); // PTX L2407
	MmaHalf(r_PackedHalf2AtPtx1870R1395, r_PackedHalf2AtPtx1877R1394, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx123R1414, r_MmaBHalf2WordAtPtx123R1413,
			r_MmaAccumulatorHalf2WordAtPtx2400R1046,
			r_MmaAccumulatorHalf2WordAtPtx2400R1047); // PTX L2414
	MmaHalf(r_PackedHalf2AtPtx1884R1393, r_PackedHalf2AtPtx1891R1392, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx123R1412, r_MmaBHalf2WordAtPtx123R1411,
			r_MmaAccumulatorHalf2WordAtPtx2407R1048,
			r_MmaAccumulatorHalf2WordAtPtx2407R1049); // PTX L2421
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2428R1050, r_MmaAccumulatorHalf2WordAtPtx2428R1051,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx94R1426, r_MmaBHalf2WordAtPtx94R1425,
			r_PackedHalf2AtPtx1898R1391, r_PackedHalf2AtPtx1905R1390); // PTX L2428
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2435R1052, r_MmaAccumulatorHalf2WordAtPtx2435R1053,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx94R1424, r_MmaBHalf2WordAtPtx94R1423,
			r_PackedHalf2AtPtx1912R1389, r_PackedHalf2AtPtx1919R1388); // PTX L2435
	MmaHalf(r_PackedHalf2AtPtx1898R1391, r_PackedHalf2AtPtx1905R1390, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx132R1410, r_MmaBHalf2WordAtPtx132R1409,
			r_MmaAccumulatorHalf2WordAtPtx2428R1050,
			r_MmaAccumulatorHalf2WordAtPtx2428R1051); // PTX L2442
	MmaHalf(r_PackedHalf2AtPtx1912R1389, r_PackedHalf2AtPtx1919R1388, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx132R1408, r_MmaBHalf2WordAtPtx132R1407,
			r_MmaAccumulatorHalf2WordAtPtx2435R1052,
			r_MmaAccumulatorHalf2WordAtPtx2435R1053); // PTX L2449
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2456R1054, r_MmaAccumulatorHalf2WordAtPtx2456R1055,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx104R1422, r_MmaBHalf2WordAtPtx104R1421,
			r_PackedHalf2AtPtx1926R1387, r_PackedHalf2AtPtx1933R1386); // PTX L2456
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2463R1056, r_MmaAccumulatorHalf2WordAtPtx2463R1057,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx104R1420, r_MmaBHalf2WordAtPtx104R1419,
			r_PackedHalf2AtPtx1940R1385, r_PackedHalf2AtPtx1947R1384); // PTX L2463
	MmaHalf(r_PackedHalf2AtPtx1926R1387, r_PackedHalf2AtPtx1933R1386, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx141R1406, r_MmaBHalf2WordAtPtx141R1405,
			r_MmaAccumulatorHalf2WordAtPtx2456R1054,
			r_MmaAccumulatorHalf2WordAtPtx2456R1055); // PTX L2470
	MmaHalf(r_PackedHalf2AtPtx1940R1385, r_PackedHalf2AtPtx1947R1384, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx141R1404, r_MmaBHalf2WordAtPtx141R1403,
			r_MmaAccumulatorHalf2WordAtPtx2463R1056,
			r_MmaAccumulatorHalf2WordAtPtx2463R1057); // PTX L2477
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2484R1058, r_MmaAccumulatorHalf2WordAtPtx2484R1059,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx114R1418, r_MmaBHalf2WordAtPtx114R1417,
			r_PackedHalf2AtPtx1954R1383, r_PackedHalf2AtPtx1961R1382); // PTX L2484
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2491R1060, r_MmaAccumulatorHalf2WordAtPtx2491R1061,
			r_MmaAHalf2WordAtPtx2334R1038, r_MmaAHalf2WordAtPtx2334R1039, r_MmaAHalf2WordAtPtx2334R1040,
			r_MmaAHalf2WordAtPtx2334R1041, r_MmaBHalf2WordAtPtx114R1416, r_MmaBHalf2WordAtPtx114R1415,
			r_PackedHalf2AtPtx1968R1381, r_PackedHalf2AtPtx1975R1380); // PTX L2491
	MmaHalf(r_PackedHalf2AtPtx1954R1383, r_PackedHalf2AtPtx1961R1382, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx150R1402, r_MmaBHalf2WordAtPtx150R1401,
			r_MmaAccumulatorHalf2WordAtPtx2484R1058,
			r_MmaAccumulatorHalf2WordAtPtx2484R1059); // PTX L2498
	MmaHalf(r_PackedHalf2AtPtx1968R1381, r_PackedHalf2AtPtx1975R1380, r_MmaAHalf2WordAtPtx2343R1042,
			r_MmaAHalf2WordAtPtx2343R1043, r_MmaAHalf2WordAtPtx2343R1044, r_MmaAHalf2WordAtPtx2343R1045,
			r_MmaBHalf2WordAtPtx150R1400, r_MmaBHalf2WordAtPtx150R1399,
			r_MmaAccumulatorHalf2WordAtPtx2491R1060,
			r_MmaAccumulatorHalf2WordAtPtx2491R1061); // PTX L2505
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2512R1070, r_MmaAccumulatorHalf2WordAtPtx2512R1071,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx84R1430, r_MmaBHalf2WordAtPtx84R1429,
			r_PackedHalf2AtPtx1982R1379, r_PackedHalf2AtPtx1989R1378); // PTX L2512
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2519R1072, r_MmaAccumulatorHalf2WordAtPtx2519R1073,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx84R1428, r_MmaBHalf2WordAtPtx84R1427,
			r_PackedHalf2AtPtx1996R1377, r_PackedHalf2AtPtx2003R1376); // PTX L2519
	MmaHalf(r_PackedHalf2AtPtx1982R1379, r_PackedHalf2AtPtx1989R1378, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx123R1414, r_MmaBHalf2WordAtPtx123R1413,
			r_MmaAccumulatorHalf2WordAtPtx2512R1070,
			r_MmaAccumulatorHalf2WordAtPtx2512R1071); // PTX L2526
	MmaHalf(r_PackedHalf2AtPtx1996R1377, r_PackedHalf2AtPtx2003R1376, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx123R1412, r_MmaBHalf2WordAtPtx123R1411,
			r_MmaAccumulatorHalf2WordAtPtx2519R1072,
			r_MmaAccumulatorHalf2WordAtPtx2519R1073); // PTX L2533
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2540R1074, r_MmaAccumulatorHalf2WordAtPtx2540R1075,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx94R1426, r_MmaBHalf2WordAtPtx94R1425,
			r_PackedHalf2AtPtx2010R1375, r_PackedHalf2AtPtx2017R1374); // PTX L2540
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2547R1076, r_MmaAccumulatorHalf2WordAtPtx2547R1077,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx94R1424, r_MmaBHalf2WordAtPtx94R1423,
			r_PackedHalf2AtPtx2024R1373, r_PackedHalf2AtPtx2031R1372); // PTX L2547
	MmaHalf(r_PackedHalf2AtPtx2010R1375, r_PackedHalf2AtPtx2017R1374, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx132R1410, r_MmaBHalf2WordAtPtx132R1409,
			r_MmaAccumulatorHalf2WordAtPtx2540R1074,
			r_MmaAccumulatorHalf2WordAtPtx2540R1075); // PTX L2554
	MmaHalf(r_PackedHalf2AtPtx2024R1373, r_PackedHalf2AtPtx2031R1372, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx132R1408, r_MmaBHalf2WordAtPtx132R1407,
			r_MmaAccumulatorHalf2WordAtPtx2547R1076,
			r_MmaAccumulatorHalf2WordAtPtx2547R1077); // PTX L2561
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2568R1078, r_MmaAccumulatorHalf2WordAtPtx2568R1079,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx104R1422, r_MmaBHalf2WordAtPtx104R1421,
			r_PackedHalf2AtPtx2038R1371, r_PackedHalf2AtPtx2045R1370); // PTX L2568
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2575R1080, r_MmaAccumulatorHalf2WordAtPtx2575R1081,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx104R1420, r_MmaBHalf2WordAtPtx104R1419,
			r_PackedHalf2AtPtx2052R1369, r_PackedHalf2AtPtx2059R1368); // PTX L2575
	MmaHalf(r_PackedHalf2AtPtx2038R1371, r_PackedHalf2AtPtx2045R1370, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx141R1406, r_MmaBHalf2WordAtPtx141R1405,
			r_MmaAccumulatorHalf2WordAtPtx2568R1078,
			r_MmaAccumulatorHalf2WordAtPtx2568R1079); // PTX L2582
	MmaHalf(r_PackedHalf2AtPtx2052R1369, r_PackedHalf2AtPtx2059R1368, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx141R1404, r_MmaBHalf2WordAtPtx141R1403,
			r_MmaAccumulatorHalf2WordAtPtx2575R1080,
			r_MmaAccumulatorHalf2WordAtPtx2575R1081); // PTX L2589
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2596R1082, r_MmaAccumulatorHalf2WordAtPtx2596R1083,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx114R1418, r_MmaBHalf2WordAtPtx114R1417,
			r_PackedHalf2AtPtx2066R1367, r_PackedHalf2AtPtx2073R1366); // PTX L2596
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2603R1084, r_MmaAccumulatorHalf2WordAtPtx2603R1085,
			r_MmaAHalf2WordAtPtx2352R1062, r_MmaAHalf2WordAtPtx2352R1063, r_MmaAHalf2WordAtPtx2352R1064,
			r_MmaAHalf2WordAtPtx2352R1065, r_MmaBHalf2WordAtPtx114R1416, r_MmaBHalf2WordAtPtx114R1415,
			r_PackedHalf2AtPtx2080R1365, r_PackedHalf2AtPtx2087R1364); // PTX L2603
	MmaHalf(r_PackedHalf2AtPtx2066R1367, r_PackedHalf2AtPtx2073R1366, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx150R1402, r_MmaBHalf2WordAtPtx150R1401,
			r_MmaAccumulatorHalf2WordAtPtx2596R1082,
			r_MmaAccumulatorHalf2WordAtPtx2596R1083); // PTX L2610
	MmaHalf(r_PackedHalf2AtPtx2080R1365, r_PackedHalf2AtPtx2087R1364, r_MmaAHalf2WordAtPtx2361R1066,
			r_MmaAHalf2WordAtPtx2361R1067, r_MmaAHalf2WordAtPtx2361R1068, r_MmaAHalf2WordAtPtx2361R1069,
			r_MmaBHalf2WordAtPtx150R1400, r_MmaBHalf2WordAtPtx150R1399,
			r_MmaAccumulatorHalf2WordAtPtx2603R1084,
			r_MmaAccumulatorHalf2WordAtPtx2603R1085); // PTX L2617
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2624R1094, r_MmaAccumulatorHalf2WordAtPtx2624R1095,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx84R1430, r_MmaBHalf2WordAtPtx84R1429,
			r_PackedHalf2AtPtx2094R1363, r_PackedHalf2AtPtx2101R1362); // PTX L2624
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2631R1096, r_MmaAccumulatorHalf2WordAtPtx2631R1097,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx84R1428, r_MmaBHalf2WordAtPtx84R1427,
			r_PackedHalf2AtPtx2108R1361, r_PackedHalf2AtPtx2115R1360); // PTX L2631
	MmaHalf(r_PackedHalf2AtPtx2094R1363, r_PackedHalf2AtPtx2101R1362, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx123R1414, r_MmaBHalf2WordAtPtx123R1413,
			r_MmaAccumulatorHalf2WordAtPtx2624R1094,
			r_MmaAccumulatorHalf2WordAtPtx2624R1095); // PTX L2638
	MmaHalf(r_PackedHalf2AtPtx2108R1361, r_PackedHalf2AtPtx2115R1360, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx123R1412, r_MmaBHalf2WordAtPtx123R1411,
			r_MmaAccumulatorHalf2WordAtPtx2631R1096,
			r_MmaAccumulatorHalf2WordAtPtx2631R1097); // PTX L2645
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2652R1098, r_MmaAccumulatorHalf2WordAtPtx2652R1099,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx94R1426, r_MmaBHalf2WordAtPtx94R1425,
			r_PackedHalf2AtPtx2122R1359, r_PackedHalf2AtPtx2129R1358); // PTX L2652
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2659R1100, r_MmaAccumulatorHalf2WordAtPtx2659R1101,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx94R1424, r_MmaBHalf2WordAtPtx94R1423,
			r_PackedHalf2AtPtx2136R1357, r_PackedHalf2AtPtx2143R1356); // PTX L2659
	MmaHalf(r_PackedHalf2AtPtx2122R1359, r_PackedHalf2AtPtx2129R1358, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx132R1410, r_MmaBHalf2WordAtPtx132R1409,
			r_MmaAccumulatorHalf2WordAtPtx2652R1098,
			r_MmaAccumulatorHalf2WordAtPtx2652R1099); // PTX L2666
	MmaHalf(r_PackedHalf2AtPtx2136R1357, r_PackedHalf2AtPtx2143R1356, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx132R1408, r_MmaBHalf2WordAtPtx132R1407,
			r_MmaAccumulatorHalf2WordAtPtx2659R1100,
			r_MmaAccumulatorHalf2WordAtPtx2659R1101); // PTX L2673
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2680R1102, r_MmaAccumulatorHalf2WordAtPtx2680R1103,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx104R1422, r_MmaBHalf2WordAtPtx104R1421,
			r_PackedHalf2AtPtx2150R1355, r_PackedHalf2AtPtx2157R1354); // PTX L2680
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2687R1104, r_MmaAccumulatorHalf2WordAtPtx2687R1105,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx104R1420, r_MmaBHalf2WordAtPtx104R1419,
			r_PackedHalf2AtPtx2164R1353, r_PackedHalf2AtPtx2171R1352); // PTX L2687
	MmaHalf(r_PackedHalf2AtPtx2150R1355, r_PackedHalf2AtPtx2157R1354, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx141R1406, r_MmaBHalf2WordAtPtx141R1405,
			r_MmaAccumulatorHalf2WordAtPtx2680R1102,
			r_MmaAccumulatorHalf2WordAtPtx2680R1103); // PTX L2694
	MmaHalf(r_PackedHalf2AtPtx2164R1353, r_PackedHalf2AtPtx2171R1352, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx141R1404, r_MmaBHalf2WordAtPtx141R1403,
			r_MmaAccumulatorHalf2WordAtPtx2687R1104,
			r_MmaAccumulatorHalf2WordAtPtx2687R1105); // PTX L2701
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2708R1106, r_MmaAccumulatorHalf2WordAtPtx2708R1107,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx114R1418, r_MmaBHalf2WordAtPtx114R1417,
			r_PackedHalf2AtPtx2178R1351, r_PackedHalf2AtPtx2185R1350); // PTX L2708
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2715R1108, r_MmaAccumulatorHalf2WordAtPtx2715R1109,
			r_MmaAHalf2WordAtPtx2370R1086, r_MmaAHalf2WordAtPtx2370R1087, r_MmaAHalf2WordAtPtx2370R1088,
			r_MmaAHalf2WordAtPtx2370R1089, r_MmaBHalf2WordAtPtx114R1416, r_MmaBHalf2WordAtPtx114R1415,
			r_PackedHalf2AtPtx2192R1349, r_PackedHalf2AtPtx2199R1348); // PTX L2715
	MmaHalf(r_PackedHalf2AtPtx2178R1351, r_PackedHalf2AtPtx2185R1350, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx150R1402, r_MmaBHalf2WordAtPtx150R1401,
			r_MmaAccumulatorHalf2WordAtPtx2708R1106,
			r_MmaAccumulatorHalf2WordAtPtx2708R1107); // PTX L2722
	MmaHalf(r_PackedHalf2AtPtx2192R1349, r_PackedHalf2AtPtx2199R1348, r_MmaAHalf2WordAtPtx2379R1090,
			r_MmaAHalf2WordAtPtx2379R1091, r_MmaAHalf2WordAtPtx2379R1092, r_MmaAHalf2WordAtPtx2379R1093,
			r_MmaBHalf2WordAtPtx150R1400, r_MmaBHalf2WordAtPtx150R1399,
			r_MmaAccumulatorHalf2WordAtPtx2715R1108,
			r_MmaAccumulatorHalf2WordAtPtx2715R1109); // PTX L2729
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2736R1118, r_MmaAccumulatorHalf2WordAtPtx2736R1119,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx84R1430, r_MmaBHalf2WordAtPtx84R1429,
			r_PackedHalf2AtPtx2206R1347, r_PackedHalf2AtPtx2213R1346); // PTX L2736
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2743R1120, r_MmaAccumulatorHalf2WordAtPtx2743R1121,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx84R1428, r_MmaBHalf2WordAtPtx84R1427,
			r_PackedHalf2AtPtx2220R1345, r_PackedHalf2AtPtx2227R1344); // PTX L2743
	MmaHalf(r_PackedHalf2AtPtx2206R1347, r_PackedHalf2AtPtx2213R1346, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx123R1414, r_MmaBHalf2WordAtPtx123R1413,
			r_MmaAccumulatorHalf2WordAtPtx2736R1118,
			r_MmaAccumulatorHalf2WordAtPtx2736R1119); // PTX L2750
	MmaHalf(r_PackedHalf2AtPtx2220R1345, r_PackedHalf2AtPtx2227R1344, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx123R1412, r_MmaBHalf2WordAtPtx123R1411,
			r_MmaAccumulatorHalf2WordAtPtx2743R1120,
			r_MmaAccumulatorHalf2WordAtPtx2743R1121); // PTX L2757
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2764R1122, r_MmaAccumulatorHalf2WordAtPtx2764R1123,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx94R1426, r_MmaBHalf2WordAtPtx94R1425,
			r_PackedHalf2AtPtx2234R1343, r_PackedHalf2AtPtx2241R1342); // PTX L2764
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2771R1124, r_MmaAccumulatorHalf2WordAtPtx2771R1125,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx94R1424, r_MmaBHalf2WordAtPtx94R1423,
			r_PackedHalf2AtPtx2248R1341, r_PackedHalf2AtPtx2255R1340); // PTX L2771
	MmaHalf(r_PackedHalf2AtPtx2234R1343, r_PackedHalf2AtPtx2241R1342, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx132R1410, r_MmaBHalf2WordAtPtx132R1409,
			r_MmaAccumulatorHalf2WordAtPtx2764R1122,
			r_MmaAccumulatorHalf2WordAtPtx2764R1123); // PTX L2778
	MmaHalf(r_PackedHalf2AtPtx2248R1341, r_PackedHalf2AtPtx2255R1340, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx132R1408, r_MmaBHalf2WordAtPtx132R1407,
			r_MmaAccumulatorHalf2WordAtPtx2771R1124,
			r_MmaAccumulatorHalf2WordAtPtx2771R1125); // PTX L2785
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2792R1126, r_MmaAccumulatorHalf2WordAtPtx2792R1127,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx104R1422, r_MmaBHalf2WordAtPtx104R1421,
			r_PackedHalf2AtPtx2262R1339, r_PackedHalf2AtPtx2269R1338); // PTX L2792
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2799R1128, r_MmaAccumulatorHalf2WordAtPtx2799R1129,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx104R1420, r_MmaBHalf2WordAtPtx104R1419,
			r_PackedHalf2AtPtx2276R1337, r_PackedHalf2AtPtx2283R1336); // PTX L2799
	MmaHalf(r_PackedHalf2AtPtx2262R1339, r_PackedHalf2AtPtx2269R1338, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx141R1406, r_MmaBHalf2WordAtPtx141R1405,
			r_MmaAccumulatorHalf2WordAtPtx2792R1126,
			r_MmaAccumulatorHalf2WordAtPtx2792R1127); // PTX L2806
	MmaHalf(r_PackedHalf2AtPtx2276R1337, r_PackedHalf2AtPtx2283R1336, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx141R1404, r_MmaBHalf2WordAtPtx141R1403,
			r_MmaAccumulatorHalf2WordAtPtx2799R1128,
			r_MmaAccumulatorHalf2WordAtPtx2799R1129); // PTX L2813
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2820R1130, r_MmaAccumulatorHalf2WordAtPtx2820R1131,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx114R1418, r_MmaBHalf2WordAtPtx114R1417,
			r_PackedHalf2AtPtx2290R1335, r_PackedHalf2AtPtx2297R1334); // PTX L2820
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2827R1132, r_MmaAccumulatorHalf2WordAtPtx2827R1133,
			r_MmaAHalf2WordAtPtx2388R1110, r_MmaAHalf2WordAtPtx2388R1111, r_MmaAHalf2WordAtPtx2388R1112,
			r_MmaAHalf2WordAtPtx2388R1113, r_MmaBHalf2WordAtPtx114R1416, r_MmaBHalf2WordAtPtx114R1415,
			r_PackedHalf2AtPtx2304R1396, r_PackedHalf2AtPtx2311R1397); // PTX L2827
	MmaHalf(r_PackedHalf2AtPtx2290R1335, r_PackedHalf2AtPtx2297R1334, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx150R1402, r_MmaBHalf2WordAtPtx150R1401,
			r_MmaAccumulatorHalf2WordAtPtx2820R1130,
			r_MmaAccumulatorHalf2WordAtPtx2820R1131); // PTX L2834
	MmaHalf(r_PackedHalf2AtPtx2304R1396, r_PackedHalf2AtPtx2311R1397, r_MmaAHalf2WordAtPtx2397R1114,
			r_MmaAHalf2WordAtPtx2397R1115, r_MmaAHalf2WordAtPtx2397R1116, r_MmaAHalf2WordAtPtx2397R1117,
			r_MmaBHalf2WordAtPtx150R1400, r_MmaBHalf2WordAtPtx150R1399,
			r_MmaAccumulatorHalf2WordAtPtx2827R1132,
			r_MmaAccumulatorHalf2WordAtPtx2827R1133);				 // PTX L2841
	r_bPtxPredicate66 = uint32_t(r_PtxRegister1398) > uint32_t(479); // PTX L2847
	if (r_bPtxPredicate66)
	{
		goto L__BB12_106;
	} // PTX L2848
	r_PtxRegister1162 = uint32_t(r_PtxRegister1398) + uint32_t(32);								  // PTX L2849
	r_PtxRegister1163 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(9));						  // PTX L2850
	r_PtxRegister1164 = uint32_t(r_PtxRegister1162) + uint32_t(r_PtxRegister1163);				  // PTX L2851
	r_PtxRegister1165 = ShiftLeft(uint32_t(r_PtxRegister1164), uint32_t(8));					  // PTX L2852
	r_PtxRegister1166 = uint32_t(r_PtxRegister1165) + uint32_t(r_PtxRegister9);					  // PTX L2853
	r_PtxU64Register246 = uint64_t(int64_t(int32_t(r_PtxRegister1166)) * int64_t(int32_t(4)));	  // PTX L2854
	g_RecordByteAddressAtPtx2855 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register246); // PTX L2855
	r_LaneIndexAtPtx2857 = uint32_t((threadIdx.x & 31u));										  // PTX L2857
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2857)) * int64_t(int32_t(16))); // PTX L2859
	g_RecordByteAddressAtPtx2860 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register248); // PTX L2860
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2860));
		r_MmaBHalf2WordAtPtx84R1430 = r_Value.x;
		r_MmaBHalf2WordAtPtx84R1429 = r_Value.y;
		r_MmaBHalf2WordAtPtx84R1428 = r_Value.z;
		r_MmaBHalf2WordAtPtx84R1427 = r_Value.w;
	} // PTX L2862
	r_LaneIndexAtPtx2865 = uint32_t((threadIdx.x & 31u)); // PTX L2865
	r_PtxU64Register249 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2865)) * int64_t(int32_t(16))); // PTX L2867
	g_RecordByteAddressAtPtx2868 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register249);			   // PTX L2868
	g_RecordByteAddressAtPtx2869 = uint64_t(g_RecordByteAddressAtPtx2868) + uint64_t(512); // PTX L2869
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2869));
		r_MmaBHalf2WordAtPtx94R1426 = r_Value.x;
		r_MmaBHalf2WordAtPtx94R1425 = r_Value.y;
		r_MmaBHalf2WordAtPtx94R1424 = r_Value.z;
		r_MmaBHalf2WordAtPtx94R1423 = r_Value.w;
	} // PTX L2871
	r_LaneIndexAtPtx2874 = uint32_t((threadIdx.x & 31u)); // PTX L2874
	r_PtxU64Register251 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2874)) * int64_t(int32_t(16))); // PTX L2876
	g_RecordByteAddressAtPtx2877 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register251);				// PTX L2877
	g_RecordByteAddressAtPtx2878 = uint64_t(g_RecordByteAddressAtPtx2877) + uint64_t(1024); // PTX L2878
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2878));
		r_MmaBHalf2WordAtPtx104R1422 = r_Value.x;
		r_MmaBHalf2WordAtPtx104R1421 = r_Value.y;
		r_MmaBHalf2WordAtPtx104R1420 = r_Value.z;
		r_MmaBHalf2WordAtPtx104R1419 = r_Value.w;
	} // PTX L2880
	r_LaneIndexAtPtx2883 = uint32_t((threadIdx.x & 31u)); // PTX L2883
	r_PtxU64Register253 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2883)) * int64_t(int32_t(16))); // PTX L2885
	g_RecordByteAddressAtPtx2886 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register253);				// PTX L2886
	g_RecordByteAddressAtPtx2887 = uint64_t(g_RecordByteAddressAtPtx2886) + uint64_t(1536); // PTX L2887
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2887));
		r_MmaBHalf2WordAtPtx114R1418 = r_Value.x;
		r_MmaBHalf2WordAtPtx114R1417 = r_Value.y;
		r_MmaBHalf2WordAtPtx114R1416 = r_Value.z;
		r_MmaBHalf2WordAtPtx114R1415 = r_Value.w;
	} // PTX L2889
	r_LaneIndexAtPtx2892 = uint32_t((threadIdx.x & 31u)); // PTX L2892
	r_PtxU64Register255 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2892)) * int64_t(int32_t(16))); // PTX L2894
	g_RecordByteAddressAtPtx2895 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register255);				 // PTX L2895
	g_RecordByteAddressAtPtx2896 = uint64_t(g_RecordByteAddressAtPtx2895) + uint64_t(16384); // PTX L2896
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2896));
		r_MmaBHalf2WordAtPtx123R1414 = r_Value.x;
		r_MmaBHalf2WordAtPtx123R1413 = r_Value.y;
		r_MmaBHalf2WordAtPtx123R1412 = r_Value.z;
		r_MmaBHalf2WordAtPtx123R1411 = r_Value.w;
	} // PTX L2898
	r_LaneIndexAtPtx2901 = uint32_t((threadIdx.x & 31u)); // PTX L2901
	r_PtxU64Register257 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2901)) * int64_t(int32_t(16))); // PTX L2903
	g_RecordByteAddressAtPtx2904 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register257);				 // PTX L2904
	g_RecordByteAddressAtPtx2905 = uint64_t(g_RecordByteAddressAtPtx2904) + uint64_t(16896); // PTX L2905
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2905));
		r_MmaBHalf2WordAtPtx132R1410 = r_Value.x;
		r_MmaBHalf2WordAtPtx132R1409 = r_Value.y;
		r_MmaBHalf2WordAtPtx132R1408 = r_Value.z;
		r_MmaBHalf2WordAtPtx132R1407 = r_Value.w;
	} // PTX L2907
	r_LaneIndexAtPtx2910 = uint32_t((threadIdx.x & 31u)); // PTX L2910
	r_PtxU64Register259 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2910)) * int64_t(int32_t(16))); // PTX L2912
	g_RecordByteAddressAtPtx2913 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register259);				 // PTX L2913
	g_RecordByteAddressAtPtx2914 = uint64_t(g_RecordByteAddressAtPtx2913) + uint64_t(17408); // PTX L2914
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2914));
		r_MmaBHalf2WordAtPtx141R1406 = r_Value.x;
		r_MmaBHalf2WordAtPtx141R1405 = r_Value.y;
		r_MmaBHalf2WordAtPtx141R1404 = r_Value.z;
		r_MmaBHalf2WordAtPtx141R1403 = r_Value.w;
	} // PTX L2916
	r_LaneIndexAtPtx2919 = uint32_t((threadIdx.x & 31u)); // PTX L2919
	r_PtxU64Register261 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2919)) * int64_t(int32_t(16))); // PTX L2921
	g_RecordByteAddressAtPtx2922 =
		uint64_t(g_RecordByteAddressAtPtx2855) + uint64_t(r_PtxU64Register261);				 // PTX L2922
	g_RecordByteAddressAtPtx2923 = uint64_t(g_RecordByteAddressAtPtx2922) + uint64_t(17920); // PTX L2923
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2923));
		r_MmaBHalf2WordAtPtx150R1402 = r_Value.x;
		r_MmaBHalf2WordAtPtx150R1401 = r_Value.y;
		r_MmaBHalf2WordAtPtx150R1400 = r_Value.z;
		r_MmaBHalf2WordAtPtx150R1399 = r_Value.w;
	} // PTX L2925
	r_PtxRegister1167 = ShiftRight(uint32_t(r_PtxRegister1162), uint32_t(5)); // PTX L2927
	r_PtxU16Register7 = uint16_t(r_PtxRegister1167);						  // PTX L2928
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L2929
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L2930
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L2931
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L2932
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L2933
	r_PtxRegister1168 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8));			  // PTX L2934
	r_PtxRegister1169 = uint32_t(12288u /* exact native shared-region offset */);				  // PTX L2935
	r_PtxRegister1171 = uint32_t(r_PtxRegister1169) + uint32_t(r_PtxRegister1168);				  // PTX L2936
	r_PtxRegister1161 = uint32_t(1);															  // PTX L2937
	r_PtxU64Register263 = BarrierArrive(s_SharedStorage, r_PtxRegister1171, r_PtxRegister1161);	  // PTX L2939
L__BB12_105:																					  // PTX L2941
	r_PtxRegister1170 = BarrierReady(s_SharedStorage, r_PtxRegister1171, r_PtxU64Register263);	  // PTX L2943
	r_bPtxPredicate67 = uint32_t(r_PtxRegister1170) == uint32_t(0);								  // PTX L2949
	if (r_bPtxPredicate67)
	{
		goto L__BB12_105;
	} // PTX L2950
L__BB12_106:														 // PTX L2951
	r_bPtxPredicate68 = uint32_t(r_PtxRegister1398) > uint32_t(415); // PTX L2952
	if (r_bPtxPredicate68)
	{
		goto L__BB12_123;
	} // PTX L2953
	r_PtxRegister1172 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister4);	   // PTX L2954
	r_bPtxPredicate69 = int32_t(r_PtxRegister1172) < int32_t(r_WidthDiv4Bits);	   // PTX L2955
	r_bPtxPredicate70 = int32_t(r_PtxRegister87) < int32_t(r_HeightDiv4Bits);	   // PTX L2956
	r_bPtxPredicate71 = int32_t(r_PtxRegister87) >= int32_t(r_HeightDiv4Bits);	   // PTX L2957
	r_bPtxPredicate72 = uint32_t(r_PtxRegister26) == uint32_t(4);				   // PTX L2958
	r_PtxRegister37 = r_HeightBits & -4;										   // PTX L2959
	r_bPtxPredicate73 = uint32_t(r_PtxRegister37) == uint32_t(4);				   // PTX L2960
	r_CtaZAtPtx2961 = uint32_t(blockIdx.z);										   // PTX L2961
	r_PtxRegister1174 = ShiftLeft(uint32_t(r_CtaZAtPtx2961), uint32_t(9));		   // PTX L2962
	r_PtxRegister1175 = uint32_t(r_PtxRegister1174) + uint32_t(r_PtxRegister1398); // PTX L2963
	r_PtxRegister38 = uint32_t(r_PtxRegister1175) + uint32_t(96);				   // PTX L2964
	r_bPtxPredicate74 = r_bPtxPredicate3 & r_bPtxPredicate71;					   // PTX L2965
	r_bPtxPredicate75 = r_bPtxPredicate73 | r_bPtxPredicate70;					   // PTX L2966
	r_bPtxPredicate76 = r_bPtxPredicate74 | r_bPtxPredicate72;					   // PTX L2967
	r_PtxRegister1176 = r_bPtxPredicate74 ? r_PtxRegister1172 : 0;				   // PTX L2968
	r_PtxRegister39 = r_bPtxPredicate72 ? r_PtxRegister1176 : r_PtxRegister1172;   // PTX L2969
	r_bPtxPredicate77 = r_bPtxPredicate76 | r_bPtxPredicate69;					   // PTX L2970
	r_bPtxPredicate14 = r_bPtxPredicate77 & r_bPtxPredicate75;					   // PTX L2971
	r_PtxU64Register328 = uint64_t(0);											   // PTX L2972
	r_bPtxPredicate78 = !r_bPtxPredicate14;										   // PTX L2973
	if (r_bPtxPredicate78)
	{
		goto L__BB12_109;
	} // PTX L2974
	r_PtxRegister1177 =
		uint32_t(r_PtxRegister87) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister39); // PTX L2975
	r_PtxRegister1178 = r_bPtxPredicate73 ? r_PtxRegister39 : r_PtxRegister1177;		   // PTX L2976
	r_PtxRegister1179 = ShiftRight(uint32_t(r_PtxRegister38), uint32_t(4));				   // PTX L2977
	r_PtxRegister1180 = uint32_t(r_PtxRegister1179) + uint32_t(r_PtxRegister13);		   // PTX L2978
	r_PtxRegister1181 = ShiftLeft(uint32_t(r_PtxRegister1178), uint32_t(12));			   // PTX L2979
	r_PtxRegister1182 = ShiftLeft(uint32_t(r_PtxRegister1180), uint32_t(7));			   // PTX L2980
	r_PtxRegister1183 = uint32_t(r_PtxRegister1181) + uint32_t(r_PtxRegister1182);		   // PTX L2981
	r_PtxU64Register328 = SignExtendWordBits(r_PtxRegister1183);						   // PTX L2982
L__BB12_109:																			   // PTX L2983
	r_PtxU64Register329 = uint64_t(0);													   // PTX L2984
	if (r_bPtxPredicate78)
	{
		goto L__BB12_111;
	} // PTX L2985
	r_PtxU64Register264 = ShiftLeft(uint64_t(r_PtxU64Register328), uint32_t(2));		// PTX L2986
	r_PtxU64Register329 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register264); // PTX L2987
L__BB12_111:																			// PTX L2988
	r_PtxRegister1184 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(3));				// PTX L2989
	r_PtxRegister1185 = uint32_t(12288u /* exact native shared-region offset */);		// PTX L2990
	r_PtxRegister1233 = uint32_t(r_PtxRegister1185) + uint32_t(r_PtxRegister1184);		// PTX L2991
	if (r_bPtxPredicate78)
	{
		goto L__BB12_114;
	} // PTX L2992
	r_PtxRegister1196 = uint32_t(-1);								// PTX L2993
	r_PtxRegister1195 = Elected(r_PtxRegister1196);					// PTX L2995
	r_bPtxPredicate79 = uint32_t(r_PtxRegister1195) == uint32_t(0); // PTX L3001
	if (r_bPtxPredicate79)
	{
		goto L__BB12_115;
	} // PTX L3002
	r_ThreadYAtPtx3003 = uint32_t(threadIdx.y);									 // PTX L3003
	r_PtxRegister1200 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(9));		 // PTX L3004
	r_PtxRegister1201 = ShiftLeft(uint32_t(r_ThreadYAtPtx3003), uint32_t(9));	 // PTX L3005
	r_PtxRegister1202 = r_PtxRegister1201 & 523264;								 // PTX L3006
	r_PtxRegister1203 = r_PtxRegister1200 | r_PtxRegister1202;					 // PTX L3007
	r_PtxRegister1197 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1203); // PTX L3008
	r_PtxU64Register265 = r_PtxU64Register329;									 // PTX L3009
	r_PtxRegister1198 = uint32_t(512);											 // PTX L3010
	CopyBulk(s_SharedStorage, r_PtxRegister1197, r_PtxU64Register265, r_PtxRegister1198,
			 r_PtxRegister1233);												   // PTX L3012
	BarrierExpect(s_SharedStorage, r_PtxRegister1233, r_PtxRegister1198);		   // PTX L3015
	goto L__BB12_115;															   // PTX L3017
L__BB12_114:																	   // PTX L3018
	r_LaneIndexAtPtx3020 = uint32_t((threadIdx.x & 31u));						   // PTX L3020
	r_ThreadYAtPtx3022 = uint32_t(threadIdx.y);									   // PTX L3022
	r_PtxRegister1189 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(9));		   // PTX L3023
	r_PtxRegister1190 = ShiftLeft(uint32_t(r_ThreadYAtPtx3022), uint32_t(9));	   // PTX L3024
	r_PtxRegister1191 = r_PtxRegister1190 & 523264;								   // PTX L3025
	r_PtxRegister1192 = r_PtxRegister1189 | r_PtxRegister1191;					   // PTX L3026
	r_PtxRegister1193 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1192);   // PTX L3027
	r_PtxRegister1194 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3020), uint32_t(4));	   // PTX L3028
	r_PtxRegister1187 = uint32_t(r_PtxRegister1193) + uint32_t(r_PtxRegister1194); // PTX L3029
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1187)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);									   // PTX L3031
L__BB12_115:																	   // PTX L3033
	r_ThreadYAtPtx3034 = uint32_t(threadIdx.y);									   // PTX L3034
	r_PtxRegister1205 = uint32_t(r_ThreadYAtPtx3034) + uint32_t(4);				   // PTX L3035
	r_PtxRegister1206 = ShiftRight(uint32_t(r_PtxRegister1205), uint32_t(2));	   // PTX L3036
	r_CtaYAtPtx3037 = uint32_t(blockIdx.y);										   // PTX L3037
	r_PtxRegister1208 = ShiftLeft(uint32_t(r_CtaYAtPtx3037), uint32_t(1));		   // PTX L3038
	r_PtxRegister1209 = uint32_t(r_PtxRegister1206) + uint32_t(r_PtxRegister1208); // PTX L3039
	r_bPtxPredicate80 = int32_t(r_PtxRegister1209) < int32_t(r_HeightDiv4Bits);	   // PTX L3040
	r_bPtxPredicate81 = int32_t(r_PtxRegister1209) >= int32_t(r_HeightDiv4Bits);   // PTX L3041
	r_bPtxPredicate82 = int32_t(r_PtxRegister1172) < int32_t(r_WidthDiv4Bits);	   // PTX L3042
	r_bPtxPredicate83 = uint32_t(r_PtxRegister26) == uint32_t(4);				   // PTX L3043
	r_bPtxPredicate84 = uint32_t(r_PtxRegister37) == uint32_t(4);				   // PTX L3044
	r_bPtxPredicate85 = r_bPtxPredicate3 & r_bPtxPredicate81;					   // PTX L3045
	r_bPtxPredicate86 = r_bPtxPredicate84 | r_bPtxPredicate80;					   // PTX L3046
	r_bPtxPredicate87 = r_bPtxPredicate85 | r_bPtxPredicate83;					   // PTX L3047
	r_PtxRegister1210 = r_bPtxPredicate85 ? r_PtxRegister1172 : 0;				   // PTX L3048
	r_PtxRegister40 = r_bPtxPredicate83 ? r_PtxRegister1210 : r_PtxRegister1172;   // PTX L3049
	r_bPtxPredicate88 = r_bPtxPredicate87 | r_bPtxPredicate82;					   // PTX L3050
	r_bPtxPredicate15 = r_bPtxPredicate88 & r_bPtxPredicate86;					   // PTX L3051
	r_PtxU64Register330 = uint64_t(0);											   // PTX L3052
	r_bPtxPredicate89 = !r_bPtxPredicate15;										   // PTX L3053
	if (r_bPtxPredicate89)
	{
		goto L__BB12_117;
	} // PTX L3054
	r_PtxRegister1211 =
		uint32_t(r_PtxRegister1209) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister40); // PTX L3055
	r_PtxRegister1212 = r_bPtxPredicate84 ? r_PtxRegister40 : r_PtxRegister1211;			 // PTX L3056
	r_PtxRegister1213 = ShiftRight(uint32_t(r_PtxRegister38), uint32_t(4));					 // PTX L3057
	r_PtxRegister1214 = uint32_t(r_PtxRegister1213) + uint32_t(r_PtxRegister13);			 // PTX L3058
	r_PtxRegister1215 = ShiftLeft(uint32_t(r_PtxRegister1212), uint32_t(12));				 // PTX L3059
	r_PtxRegister1216 = ShiftLeft(uint32_t(r_PtxRegister1214), uint32_t(7));				 // PTX L3060
	r_PtxRegister1217 = uint32_t(r_PtxRegister1215) + uint32_t(r_PtxRegister1216);			 // PTX L3061
	r_PtxU64Register330 = SignExtendWordBits(r_PtxRegister1217);							 // PTX L3062
L__BB12_117:																				 // PTX L3063
	r_PtxU64Register331 = uint64_t(0);														 // PTX L3064
	if (r_bPtxPredicate89)
	{
		goto L__BB12_119;
	} // PTX L3065
	r_PtxU64Register266 = ShiftLeft(uint64_t(r_PtxU64Register330), uint32_t(2));		// PTX L3066
	r_PtxU64Register331 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register266); // PTX L3067
L__BB12_119:																			// PTX L3068
	if (r_bPtxPredicate89)
	{
		goto L__BB12_122;
	} // PTX L3069
	r_PtxRegister1230 = uint32_t(-1);								// PTX L3070
	r_PtxRegister1229 = Elected(r_PtxRegister1230);					// PTX L3072
	r_bPtxPredicate90 = uint32_t(r_PtxRegister1229) == uint32_t(0); // PTX L3078
	if (r_bPtxPredicate90)
	{
		goto L__BB12_123;
	} // PTX L3079
	r_PtxRegister1234 = ShiftLeft(uint32_t(r_ThreadYAtPtx3034), uint32_t(9));	 // PTX L3080
	r_PtxRegister1235 = r_PtxRegister1234 & 1024;								 // PTX L3081
	r_PtxRegister1236 = uint32_t(r_PtxRegister1234) + uint32_t(2048);			 // PTX L3082
	r_PtxRegister1237 = r_PtxRegister1236 & 1046528;							 // PTX L3083
	r_PtxRegister1238 = r_PtxRegister1237 | r_PtxRegister1235;					 // PTX L3084
	r_PtxRegister1239 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(9));		 // PTX L3085
	r_PtxRegister1240 = r_PtxRegister1239 | r_PtxRegister1238;					 // PTX L3086
	r_PtxRegister1231 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1240); // PTX L3087
	r_PtxU64Register267 = r_PtxU64Register331;									 // PTX L3088
	r_PtxRegister1232 = uint32_t(512);											 // PTX L3089
	CopyBulk(s_SharedStorage, r_PtxRegister1231, r_PtxU64Register267, r_PtxRegister1232,
			 r_PtxRegister1233);												   // PTX L3091
	BarrierExpect(s_SharedStorage, r_PtxRegister1233, r_PtxRegister1232);		   // PTX L3094
	goto L__BB12_123;															   // PTX L3096
L__BB12_122:																	   // PTX L3097
	r_LaneIndexAtPtx3099 = uint32_t((threadIdx.x & 31u));						   // PTX L3099
	r_PtxRegister1220 = ShiftLeft(uint32_t(r_ThreadYAtPtx3034), uint32_t(9));	   // PTX L3101
	r_PtxRegister1221 = r_PtxRegister1220 & 1024;								   // PTX L3102
	r_PtxRegister1222 = uint32_t(r_PtxRegister1220) + uint32_t(2048);			   // PTX L3103
	r_PtxRegister1223 = r_PtxRegister1222 & 1046528;							   // PTX L3104
	r_PtxRegister1224 = r_PtxRegister1223 | r_PtxRegister1221;					   // PTX L3105
	r_PtxRegister1225 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(9));		   // PTX L3106
	r_PtxRegister1226 = r_PtxRegister1225 | r_PtxRegister1224;					   // PTX L3107
	r_PtxRegister1227 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1226);   // PTX L3108
	r_PtxRegister1228 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3099), uint32_t(4));	   // PTX L3109
	r_PtxRegister1219 = uint32_t(r_PtxRegister1227) + uint32_t(r_PtxRegister1228); // PTX L3110
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1219)) =
		make_uint4(r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184, r_PackedHalf2AtPtx65R184,
				   r_PackedHalf2AtPtx65R184);						 // PTX L3112
L__BB12_123:														 // PTX L3114
	r_bPtxPredicate91 = uint32_t(r_PtxRegister1398) < uint32_t(480); // PTX L3115
	r_PtxRegister1398 = uint32_t(r_PtxRegister1398) + uint32_t(32);	 // PTX L3116
	if (r_bPtxPredicate91)
	{
		goto L__BB12_103;
	} // PTX L3117
	r_bPtxPredicate92 = int32_t(r_PtxRegister4) >= int32_t(r_WidthDiv4Bits);  // PTX L3118
	r_bPtxPredicate93 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L3119
	r_PtxRegister1241 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister4);		  // PTX L3120
	r_PtxRegister1242 = ShiftLeft(uint32_t(r_PtxRegister1241), uint32_t(12));					  // PTX L3121
	r_PtxRegister1243 = uint32_t(r_PtxRegister1242) + uint32_t(r_PtxRegister9);					  // PTX L3122
	r_PtxU64Register268 = uint64_t(int64_t(int32_t(r_PtxRegister1243)) * int64_t(int32_t(4)));	  // PTX L3123
	g_OutputByteAddressAtPtx3124 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register268); // PTX L3124
	r_bPtxPredicate94 = r_bPtxPredicate93 | r_bPtxPredicate92;									  // PTX L3125
	if (r_bPtxPredicate94)
	{
		goto L__BB12_126;
	} // PTX L3126
	r_LaneIndexAtPtx3128 = uint32_t((threadIdx.x & 31u)); // PTX L3128
	r_PtxU64Register273 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3128)) * int64_t(int32_t(16))); // PTX L3130
	g_OutputByteAddressAtPtx3131 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register273); // PTX L3131
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3131,
					make_uint4(r_PackedHalf2AtPtx1870R1395, r_PackedHalf2AtPtx1877R1394,
							   r_PackedHalf2AtPtx1884R1393,
							   r_PackedHalf2AtPtx1891R1392)); // PTX L3133
	r_LaneIndexAtPtx3136 = uint32_t((threadIdx.x & 31u));	  // PTX L3136
	r_PtxU64Register274 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3136)) * int64_t(int32_t(16))); // PTX L3138
	g_OutputByteAddressAtPtx3139 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register274);			   // PTX L3139
	g_OutputByteAddressAtPtx3140 = uint64_t(g_OutputByteAddressAtPtx3139) + uint64_t(512); // PTX L3140
	StoreNoAllocate(g_OutputByteAddressAtPtx3140,
					make_uint4(r_PackedHalf2AtPtx1898R1391, r_PackedHalf2AtPtx1905R1390,
							   r_PackedHalf2AtPtx1912R1389,
							   r_PackedHalf2AtPtx1919R1388)); // PTX L3142
	r_LaneIndexAtPtx3145 = uint32_t((threadIdx.x & 31u));	  // PTX L3145
	r_PtxU64Register276 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3145)) * int64_t(int32_t(16))); // PTX L3147
	g_OutputByteAddressAtPtx3148 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register276);				// PTX L3148
	g_OutputByteAddressAtPtx3149 = uint64_t(g_OutputByteAddressAtPtx3148) + uint64_t(1024); // PTX L3149
	StoreNoAllocate(g_OutputByteAddressAtPtx3149,
					make_uint4(r_PackedHalf2AtPtx1926R1387, r_PackedHalf2AtPtx1933R1386,
							   r_PackedHalf2AtPtx1940R1385,
							   r_PackedHalf2AtPtx1947R1384)); // PTX L3151
	r_LaneIndexAtPtx3154 = uint32_t((threadIdx.x & 31u));	  // PTX L3154
	r_PtxU64Register278 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3154)) * int64_t(int32_t(16))); // PTX L3156
	g_OutputByteAddressAtPtx3157 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register278);				// PTX L3157
	g_OutputByteAddressAtPtx3158 = uint64_t(g_OutputByteAddressAtPtx3157) + uint64_t(1536); // PTX L3158
	StoreNoAllocate(g_OutputByteAddressAtPtx3158,
					make_uint4(r_PackedHalf2AtPtx1954R1383, r_PackedHalf2AtPtx1961R1382,
							   r_PackedHalf2AtPtx1968R1381,
							   r_PackedHalf2AtPtx1975R1380));				  // PTX L3160
L__BB12_126:																  // PTX L3162
	r_bPtxPredicate95 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L3163
	r_bPtxPredicate96 = int32_t(r_PtxRegister30) >= int32_t(r_WidthDiv4Bits); // PTX L3164
	r_bPtxPredicate97 = r_bPtxPredicate95 | r_bPtxPredicate96;				  // PTX L3165
	if (r_bPtxPredicate97)
	{
		goto L__BB12_128;
	} // PTX L3166
	r_LaneIndexAtPtx3168 = uint32_t((threadIdx.x & 31u)); // PTX L3168
	r_PtxU64Register284 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3168)) * int64_t(int32_t(16))); // PTX L3170
	g_OutputByteAddressAtPtx3171 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register284);				 // PTX L3171
	g_OutputByteAddressAtPtx3172 = uint64_t(g_OutputByteAddressAtPtx3171) + uint64_t(16384); // PTX L3172
	StoreNoAllocate(g_OutputByteAddressAtPtx3172,
					make_uint4(r_PackedHalf2AtPtx1982R1379, r_PackedHalf2AtPtx1989R1378,
							   r_PackedHalf2AtPtx1996R1377,
							   r_PackedHalf2AtPtx2003R1376)); // PTX L3174
	r_LaneIndexAtPtx3177 = uint32_t((threadIdx.x & 31u));	  // PTX L3177
	r_PtxU64Register286 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3177)) * int64_t(int32_t(16))); // PTX L3179
	g_OutputByteAddressAtPtx3180 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register286);				 // PTX L3180
	g_OutputByteAddressAtPtx3181 = uint64_t(g_OutputByteAddressAtPtx3180) + uint64_t(16896); // PTX L3181
	StoreNoAllocate(g_OutputByteAddressAtPtx3181,
					make_uint4(r_PackedHalf2AtPtx2010R1375, r_PackedHalf2AtPtx2017R1374,
							   r_PackedHalf2AtPtx2024R1373,
							   r_PackedHalf2AtPtx2031R1372)); // PTX L3183
	r_LaneIndexAtPtx3186 = uint32_t((threadIdx.x & 31u));	  // PTX L3186
	r_PtxU64Register288 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3186)) * int64_t(int32_t(16))); // PTX L3188
	g_OutputByteAddressAtPtx3189 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register288);				 // PTX L3189
	g_OutputByteAddressAtPtx3190 = uint64_t(g_OutputByteAddressAtPtx3189) + uint64_t(17408); // PTX L3190
	StoreNoAllocate(g_OutputByteAddressAtPtx3190,
					make_uint4(r_PackedHalf2AtPtx2038R1371, r_PackedHalf2AtPtx2045R1370,
							   r_PackedHalf2AtPtx2052R1369,
							   r_PackedHalf2AtPtx2059R1368)); // PTX L3192
	r_LaneIndexAtPtx3195 = uint32_t((threadIdx.x & 31u));	  // PTX L3195
	r_PtxU64Register290 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3195)) * int64_t(int32_t(16))); // PTX L3197
	g_OutputByteAddressAtPtx3198 =
		uint64_t(g_OutputByteAddressAtPtx3124) + uint64_t(r_PtxU64Register290);				 // PTX L3198
	g_OutputByteAddressAtPtx3199 = uint64_t(g_OutputByteAddressAtPtx3198) + uint64_t(17920); // PTX L3199
	StoreNoAllocate(g_OutputByteAddressAtPtx3199,
					make_uint4(r_PackedHalf2AtPtx2066R1367, r_PackedHalf2AtPtx2073R1366,
							   r_PackedHalf2AtPtx2080R1365,
							   r_PackedHalf2AtPtx2087R1364));				   // PTX L3201
L__BB12_128:																   // PTX L3203
	r_bPtxPredicate98 = int32_t(r_PtxRegister4) >= int32_t(r_WidthDiv4Bits);   // PTX L3204
	r_PtxRegister41 = r_PtxRegister3 | 1;									   // PTX L3205
	r_bPtxPredicate99 = int32_t(r_PtxRegister41) >= int32_t(r_HeightDiv4Bits); // PTX L3206
	r_PtxRegister1252 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_WidthDiv4Bits);		  // PTX L3207
	r_PtxRegister1253 = uint32_t(r_PtxRegister1252) + uint32_t(r_PtxRegister4);					  // PTX L3208
	r_PtxRegister1254 = ShiftLeft(uint32_t(r_PtxRegister1253), uint32_t(12));					  // PTX L3209
	r_PtxRegister1255 = uint32_t(r_PtxRegister1254) + uint32_t(r_PtxRegister9);					  // PTX L3210
	r_PtxU64Register292 = uint64_t(int64_t(int32_t(r_PtxRegister1255)) * int64_t(int32_t(4)));	  // PTX L3211
	g_OutputByteAddressAtPtx3212 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register292); // PTX L3212
	r_bPtxPredicate100 = r_bPtxPredicate99 | r_bPtxPredicate98;									  // PTX L3213
	if (r_bPtxPredicate100)
	{
		goto L__BB12_130;
	} // PTX L3214
	r_LaneIndexAtPtx3216 = uint32_t((threadIdx.x & 31u)); // PTX L3216
	r_PtxU64Register297 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3216)) * int64_t(int32_t(16))); // PTX L3218
	g_OutputByteAddressAtPtx3219 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register297); // PTX L3219
	StoreNoAllocate(g_OutputByteAddressAtPtx3219,
					make_uint4(r_PackedHalf2AtPtx2094R1363, r_PackedHalf2AtPtx2101R1362,
							   r_PackedHalf2AtPtx2108R1361,
							   r_PackedHalf2AtPtx2115R1360)); // PTX L3221
	r_LaneIndexAtPtx3224 = uint32_t((threadIdx.x & 31u));	  // PTX L3224
	r_PtxU64Register298 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3224)) * int64_t(int32_t(16))); // PTX L3226
	g_OutputByteAddressAtPtx3227 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register298);			   // PTX L3227
	g_OutputByteAddressAtPtx3228 = uint64_t(g_OutputByteAddressAtPtx3227) + uint64_t(512); // PTX L3228
	StoreNoAllocate(g_OutputByteAddressAtPtx3228,
					make_uint4(r_PackedHalf2AtPtx2122R1359, r_PackedHalf2AtPtx2129R1358,
							   r_PackedHalf2AtPtx2136R1357,
							   r_PackedHalf2AtPtx2143R1356)); // PTX L3230
	r_LaneIndexAtPtx3233 = uint32_t((threadIdx.x & 31u));	  // PTX L3233
	r_PtxU64Register300 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3233)) * int64_t(int32_t(16))); // PTX L3235
	g_OutputByteAddressAtPtx3236 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register300);				// PTX L3236
	g_OutputByteAddressAtPtx3237 = uint64_t(g_OutputByteAddressAtPtx3236) + uint64_t(1024); // PTX L3237
	StoreNoAllocate(g_OutputByteAddressAtPtx3237,
					make_uint4(r_PackedHalf2AtPtx2150R1355, r_PackedHalf2AtPtx2157R1354,
							   r_PackedHalf2AtPtx2164R1353,
							   r_PackedHalf2AtPtx2171R1352)); // PTX L3239
	r_LaneIndexAtPtx3242 = uint32_t((threadIdx.x & 31u));	  // PTX L3242
	r_PtxU64Register302 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3242)) * int64_t(int32_t(16))); // PTX L3244
	g_OutputByteAddressAtPtx3245 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register302);				// PTX L3245
	g_OutputByteAddressAtPtx3246 = uint64_t(g_OutputByteAddressAtPtx3245) + uint64_t(1536); // PTX L3246
	StoreNoAllocate(g_OutputByteAddressAtPtx3246,
					make_uint4(r_PackedHalf2AtPtx2178R1351, r_PackedHalf2AtPtx2185R1350,
							   r_PackedHalf2AtPtx2192R1349,
							   r_PackedHalf2AtPtx2199R1348));				   // PTX L3248
L__BB12_130:																   // PTX L3250
	r_bPtxPredicate101 = int32_t(r_PtxRegister30) >= int32_t(r_WidthDiv4Bits); // PTX L3251
	r_bPtxPredicate102 = r_bPtxPredicate99 | r_bPtxPredicate101;			   // PTX L3252
	if (r_bPtxPredicate102)
	{
		goto L__BB12_132;
	} // PTX L3253
	r_LaneIndexAtPtx3255 = uint32_t((threadIdx.x & 31u)); // PTX L3255
	r_PtxU64Register308 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3255)) * int64_t(int32_t(16))); // PTX L3257
	g_OutputByteAddressAtPtx3258 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register308);				 // PTX L3258
	g_OutputByteAddressAtPtx3259 = uint64_t(g_OutputByteAddressAtPtx3258) + uint64_t(16384); // PTX L3259
	StoreNoAllocate(g_OutputByteAddressAtPtx3259,
					make_uint4(r_PackedHalf2AtPtx2206R1347, r_PackedHalf2AtPtx2213R1346,
							   r_PackedHalf2AtPtx2220R1345,
							   r_PackedHalf2AtPtx2227R1344)); // PTX L3261
	r_LaneIndexAtPtx3264 = uint32_t((threadIdx.x & 31u));	  // PTX L3264
	r_PtxU64Register310 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3264)) * int64_t(int32_t(16))); // PTX L3266
	g_OutputByteAddressAtPtx3267 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register310);				 // PTX L3267
	g_OutputByteAddressAtPtx3268 = uint64_t(g_OutputByteAddressAtPtx3267) + uint64_t(16896); // PTX L3268
	StoreNoAllocate(g_OutputByteAddressAtPtx3268,
					make_uint4(r_PackedHalf2AtPtx2234R1343, r_PackedHalf2AtPtx2241R1342,
							   r_PackedHalf2AtPtx2248R1341,
							   r_PackedHalf2AtPtx2255R1340)); // PTX L3270
	r_LaneIndexAtPtx3273 = uint32_t((threadIdx.x & 31u));	  // PTX L3273
	r_PtxU64Register312 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3273)) * int64_t(int32_t(16))); // PTX L3275
	g_OutputByteAddressAtPtx3276 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register312);				 // PTX L3276
	g_OutputByteAddressAtPtx3277 = uint64_t(g_OutputByteAddressAtPtx3276) + uint64_t(17408); // PTX L3277
	StoreNoAllocate(g_OutputByteAddressAtPtx3277,
					make_uint4(r_PackedHalf2AtPtx2262R1339, r_PackedHalf2AtPtx2269R1338,
							   r_PackedHalf2AtPtx2276R1337,
							   r_PackedHalf2AtPtx2283R1336)); // PTX L3279
	r_LaneIndexAtPtx3282 = uint32_t((threadIdx.x & 31u));	  // PTX L3282
	r_PtxU64Register314 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3282)) * int64_t(int32_t(16))); // PTX L3284
	g_OutputByteAddressAtPtx3285 =
		uint64_t(g_OutputByteAddressAtPtx3212) + uint64_t(r_PtxU64Register314);				 // PTX L3285
	g_OutputByteAddressAtPtx3286 = uint64_t(g_OutputByteAddressAtPtx3285) + uint64_t(17920); // PTX L3286
	StoreNoAllocate(g_OutputByteAddressAtPtx3286,
					make_uint4(r_PackedHalf2AtPtx2290R1335, r_PackedHalf2AtPtx2297R1334,
							   r_PackedHalf2AtPtx2304R1396,
							   r_PackedHalf2AtPtx2311R1397)); // PTX L3288
L__BB12_132:												  // PTX L3290
	return;													  // PTX L3291
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16
