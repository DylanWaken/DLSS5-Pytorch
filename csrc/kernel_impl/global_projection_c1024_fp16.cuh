// Readable CUDA C++ reconstruction of cc_vit_1d_projection.
// Not historical source; original scalar/control identities are retained for audit.
#pragma once
#include "global_projection_c1024_abi_fp16.cuh"

namespace dlssnr::reconstructed::global_projection_c1024_fp16
{
__global__ __maxnreg__(168) void global_projection_c1024_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_SharedStorage[16400];
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
		r_bPtxPredicate114;
	uint32_t r_PtxRegister1, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_ThreadY, r_PtxRegister6,
		r_PtxRegister7, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_PtxRegister48;
	uint32_t r_PtxRegister49, r_BatchBits, r_TokensBits, r_CtaX, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_ThreadX, r_PtxRegister66,
		r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_BlockSizeX, r_BlockSizeY,
		r_Float32BitsAtPtx55R72;
	uint32_t r_LaneIndexAtPtx71, r_LaneIndexAtPtx80, r_LaneIndexAtPtx90, r_LaneIndexAtPtx100,
		r_LaneIndexAtPtx109, r_LaneIndexAtPtx118, r_LaneIndexAtPtx127, r_LaneIndexAtPtx136, r_PtxRegister81,
		r_PtxRegister82, r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_LaneIndexAtPtx193, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_LaneIndexAtPtx252,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_LaneIndexAtPtx310, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_LaneIndexAtPtx368,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_LaneIndexAtPtx477, r_PtxRegister163, r_PtxRegister164, r_LaneIndexAtPtx501, r_PtxRegister166,
		r_PtxRegister167, r_LaneIndexAtPtx525;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_LaneIndexAtPtx549, r_PtxRegister172, r_PtxRegister173,
		r_LaneIndexAtPtx574, r_PtxRegister175, r_PtxRegister176, r_LaneIndexAtPtx598, r_PtxRegister178,
		r_PtxRegister179, r_LaneIndexAtPtx622;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_LaneIndexAtPtx646, r_PtxRegister184, r_PtxRegister185,
		r_LaneIndexAtPtx671, r_PtxRegister187, r_PtxRegister188, r_LaneIndexAtPtx695, r_PtxRegister190,
		r_PtxRegister191, r_LaneIndexAtPtx719;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_LaneIndexAtPtx743, r_PtxRegister196, r_PtxRegister197,
		r_LaneIndexAtPtx768, r_PtxRegister199, r_PtxRegister200, r_LaneIndexAtPtx792, r_PtxRegister202,
		r_PtxRegister203, r_LaneIndexAtPtx816;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_LaneIndexAtPtx840, r_PtxRegister208, r_PtxRegister209,
		r_LaneIndexAtPtx855, r_LaneIndexAtPtx869, r_LaneIndexAtPtx883, r_LaneIndexAtPtx897,
		r_LaneIndexAtPtx911, r_LaneIndexAtPtx926, r_LaneIndexAtPtx940;
	uint32_t r_LaneIndexAtPtx955, r_LaneIndexAtPtx969, r_LaneIndexAtPtx984, r_LaneIndexAtPtx998,
		r_LaneIndexAtPtx1013, r_LaneIndexAtPtx1027, r_LaneIndexAtPtx1042, r_LaneIndexAtPtx1056,
		r_LaneIndexAtPtx1071, r_LaneIndexAtPtx1085, r_LaneIndexAtPtx1099, r_LaneIndexAtPtx1113;
	uint32_t r_LaneIndexAtPtx1127, r_LaneIndexAtPtx1141, r_LaneIndexAtPtx1155, r_LaneIndexAtPtx1169,
		r_LaneIndexAtPtx1183, r_LaneIndexAtPtx1197, r_LaneIndexAtPtx1211, r_LaneIndexAtPtx1225,
		r_LaneIndexAtPtx1239, r_LaneIndexAtPtx1253, r_LaneIndexAtPtx1267, r_LaneIndexAtPtx1281;
	uint32_t r_LaneIndexAtPtx1295, r_LaneIndexAtPtx1309, r_LaneIndexAtPtx1323, r_LaneIndexAtPtx1337,
		r_LaneIndexAtPtx1351, r_LaneIndexAtPtx1365, r_LaneIndexAtPtx1379, r_LaneIndexAtPtx1393,
		r_LaneIndexAtPtx1407, r_LaneIndexAtPtx1421, r_LaneIndexAtPtx1435, r_LaneIndexAtPtx1449;
	uint32_t r_LaneIndexAtPtx1463, r_LaneIndexAtPtx1477, r_LaneIndexAtPtx1491, r_LaneIndexAtPtx1505,
		r_LaneIndexAtPtx1519, r_LaneIndexAtPtx1533, r_LaneIndexAtPtx1547, r_LaneIndexAtPtx1561,
		r_LaneIndexAtPtx1575, r_LaneIndexAtPtx1589, r_LaneIndexAtPtx1603, r_LaneIndexAtPtx1617;
	uint32_t r_LaneIndexAtPtx1631, r_LaneIndexAtPtx1645, r_LaneIndexAtPtx1659, r_LaneIndexAtPtx1673,
		r_LaneIndexAtPtx1687, r_LaneIndexAtPtx1701, r_LaneIndexAtPtx1715, r_LaneIndexAtPtx1729,
		r_LaneIndexAtPtx1743, r_LaneIndexAtPtx1757, r_PtxRegister275, r_LaneIndexAtPtx1764;
	uint32_t r_PtxRegister277, r_LaneIndexAtPtx1771, r_PtxRegister279, r_LaneIndexAtPtx1778, r_PtxRegister281,
		r_LaneIndexAtPtx1785, r_PtxRegister283, r_LaneIndexAtPtx1792, r_PtxRegister285, r_LaneIndexAtPtx1799,
		r_PtxRegister287, r_LaneIndexAtPtx1806;
	uint32_t r_PtxRegister289, r_LaneIndexAtPtx1813, r_PtxRegister291, r_LaneIndexAtPtx1820, r_PtxRegister293,
		r_LaneIndexAtPtx1827, r_PtxRegister295, r_LaneIndexAtPtx1834, r_PtxRegister297, r_LaneIndexAtPtx1841,
		r_PtxRegister299, r_LaneIndexAtPtx1848;
	uint32_t r_PtxRegister301, r_LaneIndexAtPtx1855, r_PtxRegister303, r_LaneIndexAtPtx1862, r_PtxRegister305,
		r_LaneIndexAtPtx1869, r_PtxRegister307, r_LaneIndexAtPtx1876, r_PtxRegister309, r_LaneIndexAtPtx1883,
		r_PtxRegister311, r_LaneIndexAtPtx1890;
	uint32_t r_PtxRegister313, r_LaneIndexAtPtx1897, r_PtxRegister315, r_LaneIndexAtPtx1904, r_PtxRegister317,
		r_LaneIndexAtPtx1911, r_PtxRegister319, r_LaneIndexAtPtx1918, r_PtxRegister321, r_LaneIndexAtPtx1925,
		r_PtxRegister323, r_LaneIndexAtPtx1932;
	uint32_t r_PtxRegister325, r_LaneIndexAtPtx1939, r_PtxRegister327, r_LaneIndexAtPtx1946, r_PtxRegister329,
		r_LaneIndexAtPtx1953, r_PtxRegister331, r_LaneIndexAtPtx1960, r_PtxRegister333, r_LaneIndexAtPtx1967,
		r_PtxRegister335, r_LaneIndexAtPtx1974;
	uint32_t r_PtxRegister337, r_LaneIndexAtPtx1981, r_PtxRegister339, r_LaneIndexAtPtx1988, r_PtxRegister341,
		r_LaneIndexAtPtx1995, r_PtxRegister343, r_LaneIndexAtPtx2002, r_PtxRegister345, r_LaneIndexAtPtx2009,
		r_PtxRegister347, r_LaneIndexAtPtx2016;
	uint32_t r_PtxRegister349, r_LaneIndexAtPtx2023, r_PtxRegister351, r_LaneIndexAtPtx2030, r_PtxRegister353,
		r_LaneIndexAtPtx2037, r_PtxRegister355, r_LaneIndexAtPtx2044, r_PtxRegister357, r_LaneIndexAtPtx2051,
		r_PtxRegister359, r_LaneIndexAtPtx2058;
	uint32_t r_PtxRegister361, r_LaneIndexAtPtx2065, r_PtxRegister363, r_LaneIndexAtPtx2072, r_PtxRegister365,
		r_LaneIndexAtPtx2079, r_PtxRegister367, r_LaneIndexAtPtx2086, r_PtxRegister369, r_LaneIndexAtPtx2093,
		r_PtxRegister371, r_LaneIndexAtPtx2100;
	uint32_t r_PtxRegister373, r_LaneIndexAtPtx2107, r_PtxRegister375, r_LaneIndexAtPtx2114, r_PtxRegister377,
		r_LaneIndexAtPtx2121, r_PtxRegister379, r_LaneIndexAtPtx2128, r_PtxRegister381, r_LaneIndexAtPtx2135,
		r_PtxRegister383, r_LaneIndexAtPtx2142;
	uint32_t r_PtxRegister385, r_LaneIndexAtPtx2149, r_PtxRegister387, r_LaneIndexAtPtx2156, r_PtxRegister389,
		r_LaneIndexAtPtx2163, r_PtxRegister391, r_LaneIndexAtPtx2170, r_PtxRegister393, r_LaneIndexAtPtx2177,
		r_PtxRegister395, r_LaneIndexAtPtx2184;
	uint32_t r_PtxRegister397, r_LaneIndexAtPtx2191, r_PtxRegister399, r_LaneIndexAtPtx2198, r_PtxRegister401,
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
		r_PtxRegister930, r_LaneIndexAtPtx2229, r_PtxRegister932, r_LaneIndexAtPtx2240, r_PtxRegister934,
		r_LaneIndexAtPtx2249, r_PtxRegister936;
	uint32_t r_LaneIndexAtPtx2258, r_PtxRegister938, r_LaneIndexAtPtx2267, r_PtxRegister940,
		r_LaneIndexAtPtx2276, r_PtxRegister942, r_LaneIndexAtPtx2285, r_PtxRegister944, r_LaneIndexAtPtx2294,
		r_PtxRegister946, r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948;
	uint32_t r_MmaAHalf2WordAtPtx2237R949, r_MmaAHalf2WordAtPtx2237R950, r_MmaAHalf2WordAtPtx2246R951,
		r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
		r_MmaAccumulatorHalf2WordAtPtx2303R955, r_MmaAccumulatorHalf2WordAtPtx2303R956,
		r_MmaAccumulatorHalf2WordAtPtx2310R957, r_MmaAccumulatorHalf2WordAtPtx2310R958,
		r_MmaAccumulatorHalf2WordAtPtx2331R959, r_MmaAccumulatorHalf2WordAtPtx2331R960;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2338R961, r_MmaAccumulatorHalf2WordAtPtx2338R962,
		r_MmaAccumulatorHalf2WordAtPtx2359R963, r_MmaAccumulatorHalf2WordAtPtx2359R964,
		r_MmaAccumulatorHalf2WordAtPtx2366R965, r_MmaAccumulatorHalf2WordAtPtx2366R966,
		r_MmaAccumulatorHalf2WordAtPtx2387R967, r_MmaAccumulatorHalf2WordAtPtx2387R968,
		r_MmaAccumulatorHalf2WordAtPtx2394R969, r_MmaAccumulatorHalf2WordAtPtx2394R970,
		r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972;
	uint32_t r_MmaAHalf2WordAtPtx2255R973, r_MmaAHalf2WordAtPtx2255R974, r_MmaAHalf2WordAtPtx2264R975,
		r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
		r_MmaAccumulatorHalf2WordAtPtx2415R979, r_MmaAccumulatorHalf2WordAtPtx2415R980,
		r_MmaAccumulatorHalf2WordAtPtx2422R981, r_MmaAccumulatorHalf2WordAtPtx2422R982,
		r_MmaAccumulatorHalf2WordAtPtx2443R983, r_MmaAccumulatorHalf2WordAtPtx2443R984;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2450R985, r_MmaAccumulatorHalf2WordAtPtx2450R986,
		r_MmaAccumulatorHalf2WordAtPtx2471R987, r_MmaAccumulatorHalf2WordAtPtx2471R988,
		r_MmaAccumulatorHalf2WordAtPtx2478R989, r_MmaAccumulatorHalf2WordAtPtx2478R990,
		r_MmaAccumulatorHalf2WordAtPtx2499R991, r_MmaAccumulatorHalf2WordAtPtx2499R992,
		r_MmaAccumulatorHalf2WordAtPtx2506R993, r_MmaAccumulatorHalf2WordAtPtx2506R994,
		r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996;
	uint32_t r_MmaAHalf2WordAtPtx2273R997, r_MmaAHalf2WordAtPtx2273R998, r_MmaAHalf2WordAtPtx2282R999,
		r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
		r_MmaAccumulatorHalf2WordAtPtx2527R1003, r_MmaAccumulatorHalf2WordAtPtx2527R1004,
		r_MmaAccumulatorHalf2WordAtPtx2534R1005, r_MmaAccumulatorHalf2WordAtPtx2534R1006,
		r_MmaAccumulatorHalf2WordAtPtx2555R1007, r_MmaAccumulatorHalf2WordAtPtx2555R1008;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2562R1009, r_MmaAccumulatorHalf2WordAtPtx2562R1010,
		r_MmaAccumulatorHalf2WordAtPtx2583R1011, r_MmaAccumulatorHalf2WordAtPtx2583R1012,
		r_MmaAccumulatorHalf2WordAtPtx2590R1013, r_MmaAccumulatorHalf2WordAtPtx2590R1014,
		r_MmaAccumulatorHalf2WordAtPtx2611R1015, r_MmaAccumulatorHalf2WordAtPtx2611R1016,
		r_MmaAccumulatorHalf2WordAtPtx2618R1017, r_MmaAccumulatorHalf2WordAtPtx2618R1018,
		r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020;
	uint32_t r_MmaAHalf2WordAtPtx2291R1021, r_MmaAHalf2WordAtPtx2291R1022, r_MmaAHalf2WordAtPtx2300R1023,
		r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
		r_MmaAccumulatorHalf2WordAtPtx2639R1027, r_MmaAccumulatorHalf2WordAtPtx2639R1028,
		r_MmaAccumulatorHalf2WordAtPtx2646R1029, r_MmaAccumulatorHalf2WordAtPtx2646R1030,
		r_MmaAccumulatorHalf2WordAtPtx2667R1031, r_MmaAccumulatorHalf2WordAtPtx2667R1032;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2674R1033, r_MmaAccumulatorHalf2WordAtPtx2674R1034,
		r_MmaAccumulatorHalf2WordAtPtx2695R1035, r_MmaAccumulatorHalf2WordAtPtx2695R1036,
		r_MmaAccumulatorHalf2WordAtPtx2702R1037, r_MmaAccumulatorHalf2WordAtPtx2702R1038,
		r_MmaAccumulatorHalf2WordAtPtx2723R1039, r_MmaAccumulatorHalf2WordAtPtx2723R1040,
		r_MmaAccumulatorHalf2WordAtPtx2730R1041, r_MmaAccumulatorHalf2WordAtPtx2730R1042, r_PtxRegister1043,
		r_PtxRegister1044;
	uint32_t r_PtxRegister1045, r_PtxRegister1046, r_PtxRegister1047, r_PtxRegister1048, r_PtxRegister1049,
		r_PtxRegister1050, r_PtxRegister1051, r_PtxRegister1052, r_PtxRegister1053, r_PtxRegister1054,
		r_PtxRegister1055, r_PtxRegister1056;
	uint32_t r_PtxRegister1057, r_PtxRegister1058, r_PtxRegister1059, r_PtxRegister1060, r_PtxRegister1061,
		r_PtxRegister1062, r_PtxRegister1063, r_PtxRegister1064, r_PtxRegister1065, r_PtxRegister1066,
		r_PtxRegister1067, r_PtxRegister1068;
	uint32_t r_PtxRegister1069, r_PtxRegister1070, r_PtxRegister1071, r_LaneIndexAtPtx2793, r_PtxRegister1073,
		r_PtxRegister1074, r_PtxRegister1075, r_PtxRegister1076, r_PtxRegister1077, r_PtxRegister1078,
		r_PtxRegister1079, r_PtxRegister1080;
	uint32_t r_PtxRegister1081, r_PtxRegister1082, r_PtxRegister1083, r_PtxRegister1084, r_PtxRegister1085,
		r_PtxRegister1086, r_PtxRegister1087, r_LaneIndexAtPtx2843, r_PtxRegister1089, r_PtxRegister1090,
		r_PtxRegister1091, r_PtxRegister1092;
	uint32_t r_PtxRegister1093, r_PtxRegister1094, r_PtxRegister1095, r_PtxRegister1096, r_PtxRegister1097,
		r_PtxRegister1098, r_PtxRegister1099, r_PtxRegister1100, r_PtxRegister1101, r_PtxRegister1102,
		r_PtxRegister1103, r_LaneIndexAtPtx2893;
	uint32_t r_PtxRegister1105, r_PtxRegister1106, r_PtxRegister1107, r_PtxRegister1108, r_PtxRegister1109,
		r_PtxRegister1110, r_PtxRegister1111, r_PtxRegister1112, r_PtxRegister1113, r_PtxRegister1114,
		r_PtxRegister1115, r_PtxRegister1116;
	uint32_t r_PtxRegister1117, r_PtxRegister1118, r_PtxRegister1119, r_LaneIndexAtPtx2943, r_PtxRegister1121,
		r_PtxRegister1122, r_PtxRegister1123, r_PtxRegister1124, r_PtxRegister1125, r_PtxRegister1126,
		r_PtxRegister1127, r_PtxRegister1128;
	uint32_t r_LaneIndexAtPtx2957, r_LaneIndexAtPtx2965, r_LaneIndexAtPtx2974, r_LaneIndexAtPtx2983,
		r_LaneIndexAtPtx2992, r_LaneIndexAtPtx3001, r_LaneIndexAtPtx3010, r_LaneIndexAtPtx3019,
		r_PtxRegister1137, r_PtxRegister1138, r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_LaneIndexAtPtx3046, r_PtxRegister1142, r_LaneIndexAtPtx3057, r_PtxRegister1144,
		r_LaneIndexAtPtx3066, r_PtxRegister1146, r_LaneIndexAtPtx3076, r_PtxRegister1148,
		r_LaneIndexAtPtx3085, r_PtxRegister1150, r_LaneIndexAtPtx3095, r_PtxRegister1152;
	uint32_t r_LaneIndexAtPtx3104, r_PtxRegister1154, r_LaneIndexAtPtx3114, r_PtxRegister1156,
		r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
		r_MmaAHalf2WordAtPtx3054R1160, r_MmaAccumulatorHalf2WordAtPtx3137R1161,
		r_MmaAccumulatorHalf2WordAtPtx3137R1162, r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164;
	uint32_t r_MmaAHalf2WordAtPtx3063R1165, r_MmaAHalf2WordAtPtx3063R1166,
		r_MmaAccumulatorHalf2WordAtPtx3123R1167, r_MmaAccumulatorHalf2WordAtPtx3123R1168,
		r_MmaAccumulatorHalf2WordAtPtx3144R1169, r_MmaAccumulatorHalf2WordAtPtx3144R1170,
		r_MmaAccumulatorHalf2WordAtPtx3130R1171, r_MmaAccumulatorHalf2WordAtPtx3130R1172,
		r_MmaAccumulatorHalf2WordAtPtx3165R1173, r_MmaAccumulatorHalf2WordAtPtx3165R1174,
		r_MmaAccumulatorHalf2WordAtPtx3151R1175, r_MmaAccumulatorHalf2WordAtPtx3151R1176;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3172R1177, r_MmaAccumulatorHalf2WordAtPtx3172R1178,
		r_MmaAccumulatorHalf2WordAtPtx3158R1179, r_MmaAccumulatorHalf2WordAtPtx3158R1180,
		r_MmaAccumulatorHalf2WordAtPtx3193R1181, r_MmaAccumulatorHalf2WordAtPtx3193R1182,
		r_MmaAccumulatorHalf2WordAtPtx3179R1183, r_MmaAccumulatorHalf2WordAtPtx3179R1184,
		r_MmaAccumulatorHalf2WordAtPtx3200R1185, r_MmaAccumulatorHalf2WordAtPtx3200R1186,
		r_MmaAccumulatorHalf2WordAtPtx3186R1187, r_MmaAccumulatorHalf2WordAtPtx3186R1188;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3221R1189, r_MmaAccumulatorHalf2WordAtPtx3221R1190,
		r_MmaAccumulatorHalf2WordAtPtx3207R1191, r_MmaAccumulatorHalf2WordAtPtx3207R1192,
		r_MmaAccumulatorHalf2WordAtPtx3228R1193, r_MmaAccumulatorHalf2WordAtPtx3228R1194,
		r_MmaAccumulatorHalf2WordAtPtx3214R1195, r_MmaAccumulatorHalf2WordAtPtx3214R1196,
		r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
		r_MmaAHalf2WordAtPtx3073R1200;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3249R1201, r_MmaAccumulatorHalf2WordAtPtx3249R1202,
		r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
		r_MmaAHalf2WordAtPtx3082R1206, r_MmaAccumulatorHalf2WordAtPtx3235R1207,
		r_MmaAccumulatorHalf2WordAtPtx3235R1208, r_MmaAccumulatorHalf2WordAtPtx3256R1209,
		r_MmaAccumulatorHalf2WordAtPtx3256R1210, r_MmaAccumulatorHalf2WordAtPtx3242R1211,
		r_MmaAccumulatorHalf2WordAtPtx3242R1212;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3277R1213, r_MmaAccumulatorHalf2WordAtPtx3277R1214,
		r_MmaAccumulatorHalf2WordAtPtx3263R1215, r_MmaAccumulatorHalf2WordAtPtx3263R1216,
		r_MmaAccumulatorHalf2WordAtPtx3284R1217, r_MmaAccumulatorHalf2WordAtPtx3284R1218,
		r_MmaAccumulatorHalf2WordAtPtx3270R1219, r_MmaAccumulatorHalf2WordAtPtx3270R1220,
		r_MmaAccumulatorHalf2WordAtPtx3305R1221, r_MmaAccumulatorHalf2WordAtPtx3305R1222,
		r_MmaAccumulatorHalf2WordAtPtx3291R1223, r_MmaAccumulatorHalf2WordAtPtx3291R1224;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3312R1225, r_MmaAccumulatorHalf2WordAtPtx3312R1226,
		r_MmaAccumulatorHalf2WordAtPtx3298R1227, r_MmaAccumulatorHalf2WordAtPtx3298R1228,
		r_MmaAccumulatorHalf2WordAtPtx3333R1229, r_MmaAccumulatorHalf2WordAtPtx3333R1230,
		r_MmaAccumulatorHalf2WordAtPtx3319R1231, r_MmaAccumulatorHalf2WordAtPtx3319R1232,
		r_MmaAccumulatorHalf2WordAtPtx3340R1233, r_MmaAccumulatorHalf2WordAtPtx3340R1234,
		r_MmaAccumulatorHalf2WordAtPtx3326R1235, r_MmaAccumulatorHalf2WordAtPtx3326R1236;
	uint32_t r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
		r_MmaAHalf2WordAtPtx3092R1240, r_MmaAccumulatorHalf2WordAtPtx3361R1241,
		r_MmaAccumulatorHalf2WordAtPtx3361R1242, r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244,
		r_MmaAHalf2WordAtPtx3101R1245, r_MmaAHalf2WordAtPtx3101R1246, r_MmaAccumulatorHalf2WordAtPtx3347R1247,
		r_MmaAccumulatorHalf2WordAtPtx3347R1248;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3368R1249, r_MmaAccumulatorHalf2WordAtPtx3368R1250,
		r_MmaAccumulatorHalf2WordAtPtx3354R1251, r_MmaAccumulatorHalf2WordAtPtx3354R1252,
		r_MmaAccumulatorHalf2WordAtPtx3389R1253, r_MmaAccumulatorHalf2WordAtPtx3389R1254,
		r_MmaAccumulatorHalf2WordAtPtx3375R1255, r_MmaAccumulatorHalf2WordAtPtx3375R1256,
		r_MmaAccumulatorHalf2WordAtPtx3396R1257, r_MmaAccumulatorHalf2WordAtPtx3396R1258,
		r_MmaAccumulatorHalf2WordAtPtx3382R1259, r_MmaAccumulatorHalf2WordAtPtx3382R1260;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3417R1261, r_MmaAccumulatorHalf2WordAtPtx3417R1262,
		r_MmaAccumulatorHalf2WordAtPtx3403R1263, r_MmaAccumulatorHalf2WordAtPtx3403R1264,
		r_MmaAccumulatorHalf2WordAtPtx3424R1265, r_MmaAccumulatorHalf2WordAtPtx3424R1266,
		r_MmaAccumulatorHalf2WordAtPtx3410R1267, r_MmaAccumulatorHalf2WordAtPtx3410R1268,
		r_MmaAccumulatorHalf2WordAtPtx3445R1269, r_MmaAccumulatorHalf2WordAtPtx3445R1270,
		r_MmaAccumulatorHalf2WordAtPtx3431R1271, r_MmaAccumulatorHalf2WordAtPtx3431R1272;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3452R1273, r_MmaAccumulatorHalf2WordAtPtx3452R1274,
		r_MmaAccumulatorHalf2WordAtPtx3438R1275, r_MmaAccumulatorHalf2WordAtPtx3438R1276,
		r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
		r_MmaAHalf2WordAtPtx3111R1280, r_MmaAccumulatorHalf2WordAtPtx3473R1281,
		r_MmaAccumulatorHalf2WordAtPtx3473R1282, r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284;
	uint32_t r_MmaAHalf2WordAtPtx3120R1285, r_MmaAHalf2WordAtPtx3120R1286,
		r_MmaAccumulatorHalf2WordAtPtx3459R1287, r_MmaAccumulatorHalf2WordAtPtx3459R1288,
		r_MmaAccumulatorHalf2WordAtPtx3480R1289, r_MmaAccumulatorHalf2WordAtPtx3480R1290,
		r_MmaAccumulatorHalf2WordAtPtx3466R1291, r_MmaAccumulatorHalf2WordAtPtx3466R1292,
		r_MmaAccumulatorHalf2WordAtPtx3501R1293, r_MmaAccumulatorHalf2WordAtPtx3501R1294,
		r_MmaAccumulatorHalf2WordAtPtx3487R1295, r_MmaAccumulatorHalf2WordAtPtx3487R1296;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3508R1297, r_MmaAccumulatorHalf2WordAtPtx3508R1298,
		r_MmaAccumulatorHalf2WordAtPtx3494R1299, r_MmaAccumulatorHalf2WordAtPtx3494R1300,
		r_MmaAccumulatorHalf2WordAtPtx3529R1301, r_MmaAccumulatorHalf2WordAtPtx3529R1302,
		r_MmaAccumulatorHalf2WordAtPtx3515R1303, r_MmaAccumulatorHalf2WordAtPtx3515R1304,
		r_MmaAccumulatorHalf2WordAtPtx3536R1305, r_MmaAccumulatorHalf2WordAtPtx3536R1306,
		r_MmaAccumulatorHalf2WordAtPtx3522R1307, r_MmaAccumulatorHalf2WordAtPtx3522R1308;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3557R1309, r_MmaAccumulatorHalf2WordAtPtx3557R1310,
		r_MmaAccumulatorHalf2WordAtPtx3543R1311, r_MmaAccumulatorHalf2WordAtPtx3543R1312,
		r_MmaAccumulatorHalf2WordAtPtx3564R1313, r_MmaAccumulatorHalf2WordAtPtx3564R1314,
		r_MmaAccumulatorHalf2WordAtPtx3550R1315, r_MmaAccumulatorHalf2WordAtPtx3550R1316, r_PtxRegister1317,
		r_PtxRegister1318, r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_PtxRegister1330,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_ThreadZAtPtx3574, r_PtxRegister1340, r_PtxRegister1341, r_LaneIndexAtPtx3979,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_LaneIndexAtPtx4003, r_PtxRegister1346, r_PtxRegister1347, r_LaneIndexAtPtx4027,
		r_PtxRegister1349, r_PtxRegister1350, r_LaneIndexAtPtx4051, r_PtxRegister1352, r_PtxRegister1353,
		r_LaneIndexAtPtx4076, r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_LaneIndexAtPtx4100, r_PtxRegister1358, r_PtxRegister1359, r_LaneIndexAtPtx4124,
		r_PtxRegister1361, r_PtxRegister1362, r_LaneIndexAtPtx4148, r_PtxRegister1364, r_PtxRegister1365,
		r_LaneIndexAtPtx4173, r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_LaneIndexAtPtx4197, r_PtxRegister1370, r_PtxRegister1371, r_LaneIndexAtPtx4221,
		r_PtxRegister1373, r_PtxRegister1374, r_LaneIndexAtPtx4245, r_PtxRegister1376, r_PtxRegister1377,
		r_LaneIndexAtPtx4270, r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_LaneIndexAtPtx4294, r_PtxRegister1382, r_PtxRegister1383, r_LaneIndexAtPtx4318,
		r_PtxRegister1385, r_PtxRegister1386, r_LaneIndexAtPtx4340, r_PtxRegister1388, r_PtxRegister1389,
		r_LaneIndexAtPtx4349, r_LaneIndexAtPtx4356, r_LaneIndexAtPtx4363;
	uint32_t r_LaneIndexAtPtx4370, r_LaneIndexAtPtx4377, r_LaneIndexAtPtx4384, r_LaneIndexAtPtx4391,
		r_LaneIndexAtPtx4398, r_LaneIndexAtPtx4405, r_LaneIndexAtPtx4412, r_LaneIndexAtPtx4419,
		r_LaneIndexAtPtx4426, r_LaneIndexAtPtx4433, r_LaneIndexAtPtx4440, r_LaneIndexAtPtx4447;
	uint32_t r_LaneIndexAtPtx4454, r_LaneIndexAtPtx4461, r_LaneIndexAtPtx4468, r_LaneIndexAtPtx4475,
		r_LaneIndexAtPtx4482, r_LaneIndexAtPtx4489, r_LaneIndexAtPtx4496, r_LaneIndexAtPtx4503,
		r_LaneIndexAtPtx4510, r_LaneIndexAtPtx4517, r_LaneIndexAtPtx4524, r_LaneIndexAtPtx4531;
	uint32_t r_LaneIndexAtPtx4538, r_LaneIndexAtPtx4545, r_LaneIndexAtPtx4552, r_LaneIndexAtPtx4559,
		r_LaneIndexAtPtx4566, r_LaneIndexAtPtx4573, r_LaneIndexAtPtx4580, r_LaneIndexAtPtx4587,
		r_LaneIndexAtPtx4594, r_LaneIndexAtPtx4601, r_LaneIndexAtPtx4608, r_LaneIndexAtPtx4615;
	uint32_t r_LaneIndexAtPtx4622, r_LaneIndexAtPtx4629, r_LaneIndexAtPtx4636, r_LaneIndexAtPtx4643,
		r_LaneIndexAtPtx4650, r_LaneIndexAtPtx4657, r_LaneIndexAtPtx4664, r_LaneIndexAtPtx4671,
		r_LaneIndexAtPtx4678, r_LaneIndexAtPtx4685, r_LaneIndexAtPtx4692, r_LaneIndexAtPtx4699;
	uint32_t r_LaneIndexAtPtx4706, r_LaneIndexAtPtx4713, r_LaneIndexAtPtx4720, r_LaneIndexAtPtx4727,
		r_LaneIndexAtPtx4734, r_LaneIndexAtPtx4741, r_LaneIndexAtPtx4748, r_LaneIndexAtPtx4755,
		r_LaneIndexAtPtx4762, r_LaneIndexAtPtx4769, r_LaneIndexAtPtx4776, r_LaneIndexAtPtx4783;
	uint32_t r_LaneIndexAtPtx4790, r_PtxRegister1454, r_PtxRegister1455, r_LaneIndexAtPtx4803,
		r_PackedHalf2AtPtx4352R1457, r_PackedHalf2AtPtx4359R1458, r_PackedHalf2AtPtx4366R1459,
		r_PackedHalf2AtPtx4373R1460, r_LaneIndexAtPtx4811, r_PackedHalf2AtPtx4380R1462,
		r_PackedHalf2AtPtx4387R1463, r_PackedHalf2AtPtx4394R1464;
	uint32_t r_PackedHalf2AtPtx4401R1465, r_LaneIndexAtPtx4820, r_PackedHalf2AtPtx4408R1467,
		r_PackedHalf2AtPtx4415R1468, r_PackedHalf2AtPtx4422R1469, r_PackedHalf2AtPtx4429R1470,
		r_LaneIndexAtPtx4829, r_PackedHalf2AtPtx4436R1472, r_PackedHalf2AtPtx4443R1473,
		r_PackedHalf2AtPtx4450R1474, r_PackedHalf2AtPtx4457R1475, r_LaneIndexAtPtx4842;
	uint32_t r_PackedHalf2AtPtx4464R1477, r_PackedHalf2AtPtx4471R1478, r_PackedHalf2AtPtx4478R1479,
		r_PackedHalf2AtPtx4485R1480, r_LaneIndexAtPtx4850, r_PackedHalf2AtPtx4492R1482,
		r_PackedHalf2AtPtx4499R1483, r_PackedHalf2AtPtx4506R1484, r_PackedHalf2AtPtx4513R1485,
		r_LaneIndexAtPtx4859, r_PackedHalf2AtPtx4520R1487, r_PackedHalf2AtPtx4527R1488;
	uint32_t r_PackedHalf2AtPtx4534R1489, r_PackedHalf2AtPtx4541R1490, r_LaneIndexAtPtx4868,
		r_PackedHalf2AtPtx4548R1492, r_PackedHalf2AtPtx4555R1493, r_PackedHalf2AtPtx4562R1494,
		r_PackedHalf2AtPtx4569R1495, r_LaneIndexAtPtx4881, r_PackedHalf2AtPtx4576R1497,
		r_PackedHalf2AtPtx4583R1498, r_PackedHalf2AtPtx4590R1499, r_PackedHalf2AtPtx4597R1500;
	uint32_t r_LaneIndexAtPtx4889, r_PackedHalf2AtPtx4604R1502, r_PackedHalf2AtPtx4611R1503,
		r_PackedHalf2AtPtx4618R1504, r_PackedHalf2AtPtx4625R1505, r_LaneIndexAtPtx4898,
		r_PackedHalf2AtPtx4632R1507, r_PackedHalf2AtPtx4639R1508, r_PackedHalf2AtPtx4646R1509,
		r_PackedHalf2AtPtx4653R1510, r_LaneIndexAtPtx4907, r_PackedHalf2AtPtx4660R1512;
	uint32_t r_PackedHalf2AtPtx4667R1513, r_PackedHalf2AtPtx4674R1514, r_PackedHalf2AtPtx4681R1515,
		r_LaneIndexAtPtx4919, r_PackedHalf2AtPtx4688R1517, r_PackedHalf2AtPtx4695R1518,
		r_PackedHalf2AtPtx4702R1519, r_PackedHalf2AtPtx4709R1520, r_LaneIndexAtPtx4928,
		r_PackedHalf2AtPtx4716R1522, r_PackedHalf2AtPtx4723R1523, r_PackedHalf2AtPtx4730R1524;
	uint32_t r_PackedHalf2AtPtx4737R1525, r_LaneIndexAtPtx4937, r_PackedHalf2AtPtx4744R1527,
		r_PackedHalf2AtPtx4751R1528, r_PackedHalf2AtPtx4758R1529, r_PackedHalf2AtPtx4765R1530,
		r_LaneIndexAtPtx4946, r_PackedHalf2AtPtx4772R1532, r_PackedHalf2AtPtx4779R1533,
		r_PackedHalf2AtPtx4786R1534, r_PackedHalf2AtPtx4793R1535, r_LaneIndexAtPtx3592;
	uint32_t r_LaneIndexAtPtx3604, r_LaneIndexAtPtx3616, r_LaneIndexAtPtx3628, r_PtxRegister1540,
		r_PtxRegister1541, r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_LaneIndexAtPtx3645,
		r_LaneIndexAtPtx3657, r_LaneIndexAtPtx3669, r_LaneIndexAtPtx3681;
	uint32_t r_PtxRegister1549, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_LaneIndexAtPtx3698, r_LaneIndexAtPtx3710, r_LaneIndexAtPtx3722, r_LaneIndexAtPtx3734,
		r_PtxRegister1558, r_PtxRegister1559, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_LaneIndexAtPtx3751, r_LaneIndexAtPtx3763,
		r_LaneIndexAtPtx3775, r_LaneIndexAtPtx3787, r_PtxRegister1567, r_PtxRegister1568, r_PtxRegister1569,
		r_PtxRegister1570, r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_LaneIndexAtPtx3806, r_LaneIndexAtPtx3814,
		r_LaneIndexAtPtx3823, r_LaneIndexAtPtx3832, r_PtxRegister1579, r_LaneIndexAtPtx3846,
		r_LaneIndexAtPtx3854, r_LaneIndexAtPtx3863, r_LaneIndexAtPtx3872, r_PtxRegister1584;
	uint32_t r_LaneIndexAtPtx3886, r_LaneIndexAtPtx3894, r_LaneIndexAtPtx3903, r_LaneIndexAtPtx3912,
		r_PtxRegister1589, r_LaneIndexAtPtx3925, r_LaneIndexAtPtx3934, r_LaneIndexAtPtx3943,
		r_LaneIndexAtPtx3952, r_ThreadZAtPtx4956, r_PtxRegister1595, r_CtaZ;
	uint32_t r_PtxRegister1597, r_PackedHalf2AtPtx466R1598, r_PackedHalf2AtPtx467R1599,
		r_PackedHalf2AtPtx468R1600, r_PackedHalf2AtPtx469R1601, r_PtxRegister1602, r_PackedHalf2AtPtx490R1603,
		r_PackedHalf2AtPtx491R1604, r_PackedHalf2AtPtx492R1605, r_PackedHalf2AtPtx493R1606, r_PtxRegister1607,
		r_PackedHalf2AtPtx514R1608;
	uint32_t r_PackedHalf2AtPtx515R1609, r_PackedHalf2AtPtx516R1610, r_PackedHalf2AtPtx517R1611,
		r_PtxRegister1612, r_PackedHalf2AtPtx538R1613, r_PackedHalf2AtPtx539R1614, r_PackedHalf2AtPtx540R1615,
		r_PackedHalf2AtPtx541R1616, r_PtxRegister1617, r_PackedHalf2AtPtx563R1618, r_PackedHalf2AtPtx564R1619,
		r_PackedHalf2AtPtx565R1620;
	uint32_t r_PackedHalf2AtPtx566R1621, r_PtxRegister1622, r_PackedHalf2AtPtx587R1623,
		r_PackedHalf2AtPtx588R1624, r_PackedHalf2AtPtx589R1625, r_PackedHalf2AtPtx590R1626, r_PtxRegister1627,
		r_PackedHalf2AtPtx611R1628, r_PackedHalf2AtPtx612R1629, r_PackedHalf2AtPtx613R1630,
		r_PackedHalf2AtPtx614R1631, r_PtxRegister1632;
	uint32_t r_PackedHalf2AtPtx635R1633, r_PackedHalf2AtPtx636R1634, r_PackedHalf2AtPtx637R1635,
		r_PackedHalf2AtPtx638R1636, r_PtxRegister1637, r_PackedHalf2AtPtx660R1638, r_PackedHalf2AtPtx661R1639,
		r_PackedHalf2AtPtx662R1640, r_PackedHalf2AtPtx663R1641, r_PtxRegister1642, r_PackedHalf2AtPtx684R1643,
		r_PackedHalf2AtPtx685R1644;
	uint32_t r_PackedHalf2AtPtx686R1645, r_PackedHalf2AtPtx687R1646, r_PtxRegister1647,
		r_PackedHalf2AtPtx708R1648, r_PackedHalf2AtPtx709R1649, r_PackedHalf2AtPtx710R1650,
		r_PackedHalf2AtPtx711R1651, r_PtxRegister1652, r_PackedHalf2AtPtx732R1653, r_PackedHalf2AtPtx733R1654,
		r_PackedHalf2AtPtx734R1655, r_PackedHalf2AtPtx735R1656;
	uint32_t r_PtxRegister1657, r_PackedHalf2AtPtx757R1658, r_PackedHalf2AtPtx758R1659,
		r_PackedHalf2AtPtx759R1660, r_PackedHalf2AtPtx760R1661, r_PtxRegister1662, r_PackedHalf2AtPtx781R1663,
		r_PackedHalf2AtPtx782R1664, r_PackedHalf2AtPtx783R1665, r_PackedHalf2AtPtx784R1666, r_PtxRegister1667,
		r_PackedHalf2AtPtx805R1668;
	uint32_t r_PackedHalf2AtPtx806R1669, r_PackedHalf2AtPtx807R1670, r_PackedHalf2AtPtx808R1671,
		r_PtxRegister1672, r_PackedHalf2AtPtx829R1673, r_PackedHalf2AtPtx830R1674, r_PackedHalf2AtPtx831R1675,
		r_PackedHalf2AtPtx832R1676, r_PackedHalf2AtPtx393R1677, r_PackedHalf2AtPtx394R1678,
		r_PackedHalf2AtPtx395R1679, r_PackedHalf2AtPtx396R1680;
	uint32_t r_PackedHalf2AtPtx397R1681, r_PackedHalf2AtPtx398R1682, r_PackedHalf2AtPtx399R1683,
		r_PackedHalf2AtPtx400R1684, r_PackedHalf2AtPtx401R1685, r_PackedHalf2AtPtx402R1686,
		r_PackedHalf2AtPtx403R1687, r_PackedHalf2AtPtx404R1688, r_PackedHalf2AtPtx405R1689,
		r_PackedHalf2AtPtx406R1690, r_PackedHalf2AtPtx407R1691, r_PackedHalf2AtPtx408R1692;
	uint32_t r_PackedHalf2AtPtx409R1693, r_PackedHalf2AtPtx410R1694, r_PackedHalf2AtPtx411R1695,
		r_PackedHalf2AtPtx412R1696, r_PackedHalf2AtPtx413R1697, r_PackedHalf2AtPtx414R1698,
		r_PackedHalf2AtPtx415R1699, r_PackedHalf2AtPtx416R1700, r_PackedHalf2AtPtx417R1701,
		r_PackedHalf2AtPtx418R1702, r_PackedHalf2AtPtx419R1703, r_PackedHalf2AtPtx420R1704;
	uint32_t r_PackedHalf2AtPtx421R1705, r_PackedHalf2AtPtx422R1706, r_PackedHalf2AtPtx423R1707,
		r_PackedHalf2AtPtx424R1708, r_PackedHalf2AtPtx425R1709, r_PackedHalf2AtPtx426R1710,
		r_PackedHalf2AtPtx427R1711, r_PackedHalf2AtPtx428R1712, r_PackedHalf2AtPtx429R1713,
		r_PackedHalf2AtPtx430R1714, r_PackedHalf2AtPtx431R1715, r_PackedHalf2AtPtx432R1716;
	uint32_t r_PackedHalf2AtPtx433R1717, r_PackedHalf2AtPtx434R1718, r_PackedHalf2AtPtx435R1719,
		r_PackedHalf2AtPtx436R1720, r_PackedHalf2AtPtx437R1721, r_PackedHalf2AtPtx438R1722,
		r_PackedHalf2AtPtx439R1723, r_PackedHalf2AtPtx440R1724, r_PackedHalf2AtPtx441R1725,
		r_PackedHalf2AtPtx442R1726, r_PackedHalf2AtPtx443R1727, r_PackedHalf2AtPtx444R1728;
	uint32_t r_PackedHalf2AtPtx445R1729, r_PackedHalf2AtPtx446R1730, r_PackedHalf2AtPtx447R1731,
		r_PackedHalf2AtPtx448R1732, r_PackedHalf2AtPtx449R1733, r_PackedHalf2AtPtx450R1734,
		r_PackedHalf2AtPtx451R1735, r_PackedHalf2AtPtx452R1736, r_PackedHalf2AtPtx453R1737,
		r_PackedHalf2AtPtx454R1738, r_PackedHalf2AtPtx455R1739, r_PackedHalf2AtPtx456R1740;
	uint32_t r_PtxRegister1741, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
		r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745, r_MmaBHalf2WordAtPtx86R1746,
		r_MmaBHalf2WordAtPtx86R1747, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
		r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751, r_MmaBHalf2WordAtPtx96R1752;
	uint32_t r_MmaBHalf2WordAtPtx96R1753, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
		r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757, r_MmaBHalf2WordAtPtx115R1758,
		r_MmaBHalf2WordAtPtx115R1759, r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
		r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763, r_MmaBHalf2WordAtPtx124R1764;
	uint32_t r_MmaBHalf2WordAtPtx124R1765, r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
		r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769, r_MmaBHalf2WordAtPtx142R1770,
		r_MmaBHalf2WordAtPtx142R1771, r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
		r_PtxRegister1774, r_PackedHalf2AtPtx3968R1775, r_PackedHalf2AtPtx3969R1776;
	uint32_t r_PackedHalf2AtPtx3970R1777, r_PackedHalf2AtPtx3971R1778, r_PtxRegister1779,
		r_PackedHalf2AtPtx3992R1780, r_PackedHalf2AtPtx3993R1781, r_PackedHalf2AtPtx3994R1782,
		r_PackedHalf2AtPtx3995R1783, r_PtxRegister1784, r_PackedHalf2AtPtx4016R1785,
		r_PackedHalf2AtPtx4017R1786, r_PackedHalf2AtPtx4018R1787, r_PackedHalf2AtPtx4019R1788;
	uint32_t r_PtxRegister1789, r_PackedHalf2AtPtx4040R1790, r_PackedHalf2AtPtx4041R1791,
		r_PackedHalf2AtPtx4042R1792, r_PackedHalf2AtPtx4043R1793, r_PtxRegister1794,
		r_PackedHalf2AtPtx4065R1795, r_PackedHalf2AtPtx4066R1796, r_PackedHalf2AtPtx4067R1797,
		r_PackedHalf2AtPtx4068R1798, r_PtxRegister1799, r_PackedHalf2AtPtx4089R1800;
	uint32_t r_PackedHalf2AtPtx4090R1801, r_PackedHalf2AtPtx4091R1802, r_PackedHalf2AtPtx4092R1803,
		r_PtxRegister1804, r_PackedHalf2AtPtx4113R1805, r_PackedHalf2AtPtx4114R1806,
		r_PackedHalf2AtPtx4115R1807, r_PackedHalf2AtPtx4116R1808, r_PtxRegister1809,
		r_PackedHalf2AtPtx4137R1810, r_PackedHalf2AtPtx4138R1811, r_PackedHalf2AtPtx4139R1812;
	uint32_t r_PackedHalf2AtPtx4140R1813, r_PtxRegister1814, r_PackedHalf2AtPtx4162R1815,
		r_PackedHalf2AtPtx4163R1816, r_PackedHalf2AtPtx4164R1817, r_PackedHalf2AtPtx4165R1818,
		r_PtxRegister1819, r_PackedHalf2AtPtx4186R1820, r_PackedHalf2AtPtx4187R1821,
		r_PackedHalf2AtPtx4188R1822, r_PackedHalf2AtPtx4189R1823, r_PtxRegister1824;
	uint32_t r_PackedHalf2AtPtx4210R1825, r_PackedHalf2AtPtx4211R1826, r_PackedHalf2AtPtx4212R1827,
		r_PackedHalf2AtPtx4213R1828, r_PtxRegister1829, r_PackedHalf2AtPtx4234R1830,
		r_PackedHalf2AtPtx4235R1831, r_PackedHalf2AtPtx4236R1832, r_PackedHalf2AtPtx4237R1833,
		r_PtxRegister1834, r_PackedHalf2AtPtx4259R1835, r_PackedHalf2AtPtx4260R1836;
	uint32_t r_PackedHalf2AtPtx4261R1837, r_PackedHalf2AtPtx4262R1838, r_PtxRegister1839,
		r_PackedHalf2AtPtx4283R1840, r_PackedHalf2AtPtx4284R1841, r_PackedHalf2AtPtx4285R1842,
		r_PackedHalf2AtPtx4286R1843, r_PtxRegister1844, r_PackedHalf2AtPtx4307R1845,
		r_PackedHalf2AtPtx4308R1846, r_PackedHalf2AtPtx4309R1847, r_PackedHalf2AtPtx4310R1848;
	uint32_t r_PtxRegister1849, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4330R1851,
		r_PackedHalf2AtPtx4331R1852, r_PackedHalf2AtPtx4332R1853;
	uint64_t g_ResidualBaseAddress, g_OutputByteAddressAtPtx3803, g_OutputByteAddressAtPtx3843,
		g_OutputByteAddressAtPtx3883, g_OutputByteAddressAtPtx4800, g_OutputByteAddressAtPtx4839,
		g_OutputByteAddressAtPtx4878, g_StateBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress,
		g_CounterBaseAddress, g_RecordByteAddressAtPtx74;
	uint64_t g_RecordByteAddressAtPtx84, g_RecordByteAddressAtPtx94, g_RecordByteAddressAtPtx104,
		g_RecordByteAddressAtPtx113, g_RecordByteAddressAtPtx122, g_RecordByteAddressAtPtx131,
		g_RecordByteAddressAtPtx140, r_PtxU64Register20, g_RecordByteAddressAtPtx69, r_PtxU64Register22,
		r_PtxU64Register23, g_RecordByteAddressAtPtx83;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx93, r_PtxU64Register27, g_RecordByteAddressAtPtx103,
		r_PtxU64Register29, g_RecordByteAddressAtPtx112, r_PtxU64Register31, g_RecordByteAddressAtPtx121,
		r_PtxU64Register33, g_RecordByteAddressAtPtx130, r_PtxU64Register35, g_RecordByteAddressAtPtx139;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		g_ResidualByteAddressAtPtx480, r_PtxU64Register47, g_ResidualByteAddressAtPtx475;
	uint64_t r_PtxU64Register49, g_ResidualByteAddressAtPtx504, r_PtxU64Register51,
		g_ResidualByteAddressAtPtx499, r_PtxU64Register53, g_ResidualByteAddressAtPtx528, r_PtxU64Register55,
		g_ResidualByteAddressAtPtx523, r_PtxU64Register57, g_ResidualByteAddressAtPtx552, r_PtxU64Register59,
		g_ResidualByteAddressAtPtx547;
	uint64_t r_PtxU64Register61, g_ResidualByteAddressAtPtx577, r_PtxU64Register63,
		g_ResidualByteAddressAtPtx572, r_PtxU64Register65, g_ResidualByteAddressAtPtx601, r_PtxU64Register67,
		g_ResidualByteAddressAtPtx596, r_PtxU64Register69, g_ResidualByteAddressAtPtx625, r_PtxU64Register71,
		g_ResidualByteAddressAtPtx620;
	uint64_t r_PtxU64Register73, g_ResidualByteAddressAtPtx649, r_PtxU64Register75,
		g_ResidualByteAddressAtPtx644, r_PtxU64Register77, g_ResidualByteAddressAtPtx674, r_PtxU64Register79,
		g_ResidualByteAddressAtPtx669, r_PtxU64Register81, g_ResidualByteAddressAtPtx698, r_PtxU64Register83,
		g_ResidualByteAddressAtPtx693;
	uint64_t r_PtxU64Register85, g_ResidualByteAddressAtPtx722, r_PtxU64Register87,
		g_ResidualByteAddressAtPtx717, r_PtxU64Register89, g_ResidualByteAddressAtPtx746, r_PtxU64Register91,
		g_ResidualByteAddressAtPtx741, r_PtxU64Register93, g_ResidualByteAddressAtPtx771, r_PtxU64Register95,
		g_ResidualByteAddressAtPtx766;
	uint64_t r_PtxU64Register97, g_ResidualByteAddressAtPtx795, r_PtxU64Register99,
		g_ResidualByteAddressAtPtx790, r_PtxU64Register101, g_ResidualByteAddressAtPtx819,
		r_PtxU64Register103, g_ResidualByteAddressAtPtx814, r_PtxU64Register105,
		g_ResidualByteAddressAtPtx843, r_PtxU64Register107, g_ResidualByteAddressAtPtx838;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx848, r_PtxU64Register111,
		g_RecordByteAddressAtPtx866, r_PtxU64Register113, g_RecordByteAddressAtPtx880, r_PtxU64Register115,
		g_RecordByteAddressAtPtx894, r_PtxU64Register117, g_RecordByteAddressAtPtx908, r_PtxU64Register119,
		g_RecordByteAddressAtPtx923;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx937, r_PtxU64Register123,
		g_RecordByteAddressAtPtx952, r_PtxU64Register125, g_RecordByteAddressAtPtx966, r_PtxU64Register127,
		g_RecordByteAddressAtPtx981, r_PtxU64Register129, g_RecordByteAddressAtPtx995, r_PtxU64Register131,
		g_RecordByteAddressAtPtx1010;
	uint64_t r_PtxU64Register133, g_RecordByteAddressAtPtx1024, r_PtxU64Register135,
		g_RecordByteAddressAtPtx1039, r_PtxU64Register137, g_RecordByteAddressAtPtx1053, r_PtxU64Register139,
		g_RecordByteAddressAtPtx1068, r_PtxU64Register141, g_RecordByteAddressAtPtx1082, r_PtxU64Register143,
		g_RecordByteAddressAtPtx1096;
	uint64_t r_PtxU64Register145, g_RecordByteAddressAtPtx1110, r_PtxU64Register147,
		g_RecordByteAddressAtPtx1124, r_PtxU64Register149, g_RecordByteAddressAtPtx1138, r_PtxU64Register151,
		g_RecordByteAddressAtPtx1152, r_PtxU64Register153, g_RecordByteAddressAtPtx1166, r_PtxU64Register155,
		g_RecordByteAddressAtPtx1180;
	uint64_t r_PtxU64Register157, g_RecordByteAddressAtPtx1194, r_PtxU64Register159,
		g_RecordByteAddressAtPtx1208, r_PtxU64Register161, g_RecordByteAddressAtPtx1222, r_PtxU64Register163,
		g_RecordByteAddressAtPtx1236, r_PtxU64Register165, g_RecordByteAddressAtPtx1250, r_PtxU64Register167,
		g_RecordByteAddressAtPtx1264;
	uint64_t r_PtxU64Register169, g_RecordByteAddressAtPtx1278, r_PtxU64Register171,
		g_RecordByteAddressAtPtx1292, r_PtxU64Register173, g_RecordByteAddressAtPtx1306, r_PtxU64Register175,
		g_RecordByteAddressAtPtx1320, r_PtxU64Register177, g_RecordByteAddressAtPtx1334, r_PtxU64Register179,
		g_RecordByteAddressAtPtx1348;
	uint64_t r_PtxU64Register181, g_RecordByteAddressAtPtx1362, r_PtxU64Register183,
		g_RecordByteAddressAtPtx1376, r_PtxU64Register185, g_RecordByteAddressAtPtx1390, r_PtxU64Register187,
		g_RecordByteAddressAtPtx1404, r_PtxU64Register189, g_RecordByteAddressAtPtx1418, r_PtxU64Register191,
		g_RecordByteAddressAtPtx1432;
	uint64_t r_PtxU64Register193, g_RecordByteAddressAtPtx1446, r_PtxU64Register195,
		g_RecordByteAddressAtPtx1460, r_PtxU64Register197, g_RecordByteAddressAtPtx1474, r_PtxU64Register199,
		g_RecordByteAddressAtPtx1488, r_PtxU64Register201, g_RecordByteAddressAtPtx1502, r_PtxU64Register203,
		g_RecordByteAddressAtPtx1516;
	uint64_t r_PtxU64Register205, g_RecordByteAddressAtPtx1530, r_PtxU64Register207,
		g_RecordByteAddressAtPtx1544, r_PtxU64Register209, g_RecordByteAddressAtPtx1558, r_PtxU64Register211,
		g_RecordByteAddressAtPtx1572, r_PtxU64Register213, g_RecordByteAddressAtPtx1586, r_PtxU64Register215,
		g_RecordByteAddressAtPtx1600;
	uint64_t r_PtxU64Register217, g_RecordByteAddressAtPtx1614, r_PtxU64Register219,
		g_RecordByteAddressAtPtx1628, r_PtxU64Register221, g_RecordByteAddressAtPtx1642, r_PtxU64Register223,
		g_RecordByteAddressAtPtx1656, r_PtxU64Register225, g_RecordByteAddressAtPtx1670, r_PtxU64Register227,
		g_RecordByteAddressAtPtx1684;
	uint64_t r_PtxU64Register229, g_RecordByteAddressAtPtx1698, r_PtxU64Register231,
		g_RecordByteAddressAtPtx1712, r_PtxU64Register233, g_RecordByteAddressAtPtx1726, r_PtxU64Register235,
		g_RecordByteAddressAtPtx1740, r_PtxU64Register237, g_RecordByteAddressAtPtx1754, r_PtxU64Register239,
		r_PtxU64Register240;
	uint64_t r_PtxU64Register241, r_PtxU64Register242, r_PtxU64Register243, r_PtxU64Register244,
		r_PtxU64Register245, r_PtxU64Register246, g_RecordByteAddressAtPtx2960, g_RecordByteAddressAtPtx2969,
		g_RecordByteAddressAtPtx2978, g_RecordByteAddressAtPtx2987, g_RecordByteAddressAtPtx2996,
		g_RecordByteAddressAtPtx3005;
	uint64_t g_RecordByteAddressAtPtx3014, g_RecordByteAddressAtPtx3023, r_PtxU64Register255,
		g_RecordByteAddressAtPtx2955, r_PtxU64Register257, r_PtxU64Register258, g_RecordByteAddressAtPtx2968,
		r_PtxU64Register260, g_RecordByteAddressAtPtx2977, r_PtxU64Register262, g_RecordByteAddressAtPtx2986,
		r_PtxU64Register264;
	uint64_t g_RecordByteAddressAtPtx2995, r_PtxU64Register266, g_RecordByteAddressAtPtx3004,
		r_PtxU64Register268, g_RecordByteAddressAtPtx3013, r_PtxU64Register270, g_RecordByteAddressAtPtx3022,
		r_PtxU64Register272, r_PtxU64Register273, g_OutputByteAddressAtPtx3982, r_PtxU64Register275,
		g_OutputByteAddressAtPtx3977;
	uint64_t r_PtxU64Register277, g_OutputByteAddressAtPtx4006, r_PtxU64Register279,
		g_OutputByteAddressAtPtx4001, r_PtxU64Register281, g_OutputByteAddressAtPtx4030, r_PtxU64Register283,
		g_OutputByteAddressAtPtx4025, r_PtxU64Register285, g_OutputByteAddressAtPtx4054, r_PtxU64Register287,
		g_OutputByteAddressAtPtx4049;
	uint64_t r_PtxU64Register289, g_OutputByteAddressAtPtx4079, r_PtxU64Register291,
		g_OutputByteAddressAtPtx4074, r_PtxU64Register293, g_OutputByteAddressAtPtx4103, r_PtxU64Register295,
		g_OutputByteAddressAtPtx4098, r_PtxU64Register297, g_OutputByteAddressAtPtx4127, r_PtxU64Register299,
		g_OutputByteAddressAtPtx4122;
	uint64_t r_PtxU64Register301, g_OutputByteAddressAtPtx4151, r_PtxU64Register303,
		g_OutputByteAddressAtPtx4146, r_PtxU64Register305, g_OutputByteAddressAtPtx4176, r_PtxU64Register307,
		g_OutputByteAddressAtPtx4171, r_PtxU64Register309, g_OutputByteAddressAtPtx4200, r_PtxU64Register311,
		g_OutputByteAddressAtPtx4195;
	uint64_t r_PtxU64Register313, g_OutputByteAddressAtPtx4224, r_PtxU64Register315,
		g_OutputByteAddressAtPtx4219, r_PtxU64Register317, g_OutputByteAddressAtPtx4248, r_PtxU64Register319,
		g_OutputByteAddressAtPtx4243, r_PtxU64Register321, g_OutputByteAddressAtPtx4273, r_PtxU64Register323,
		g_OutputByteAddressAtPtx4268;
	uint64_t r_PtxU64Register325, g_OutputByteAddressAtPtx4297, r_PtxU64Register327,
		g_OutputByteAddressAtPtx4292, r_PtxU64Register329, g_OutputByteAddressAtPtx4321, r_PtxU64Register331,
		g_OutputByteAddressAtPtx4316, r_PtxU64Register333, g_OutputByteAddressAtPtx4343, r_PtxU64Register335,
		g_OutputByteAddressAtPtx4338;
	uint64_t r_PtxU64Register337, r_PtxU64Register338, g_OutputByteAddressAtPtx4806,
		g_OutputByteAddressAtPtx4815, g_OutputByteAddressAtPtx4824, g_OutputByteAddressAtPtx4833,
		r_PtxU64Register343, r_PtxU64Register344, g_OutputByteAddressAtPtx4814, r_PtxU64Register346,
		g_OutputByteAddressAtPtx4823, r_PtxU64Register348;
	uint64_t g_OutputByteAddressAtPtx4832, g_OutputByteAddressAtPtx4845, g_OutputByteAddressAtPtx4854,
		g_OutputByteAddressAtPtx4863, g_OutputByteAddressAtPtx4872, r_PtxU64Register354, r_PtxU64Register355,
		g_OutputByteAddressAtPtx4853, r_PtxU64Register357, g_OutputByteAddressAtPtx4862, r_PtxU64Register359,
		g_OutputByteAddressAtPtx4871;
	uint64_t g_OutputByteAddressAtPtx4884, g_OutputByteAddressAtPtx4893, g_OutputByteAddressAtPtx4902,
		g_OutputByteAddressAtPtx4911, r_PtxU64Register365, r_PtxU64Register366, g_OutputByteAddressAtPtx4892,
		r_PtxU64Register368, g_OutputByteAddressAtPtx4901, r_PtxU64Register370, g_OutputByteAddressAtPtx4910,
		g_OutputByteAddressAtPtx4923;
	uint64_t g_OutputByteAddressAtPtx4932, g_OutputByteAddressAtPtx4941, g_OutputByteAddressAtPtx4950,
		r_PtxU64Register376, g_OutputByteAddressAtPtx4922, r_PtxU64Register378, g_OutputByteAddressAtPtx4931,
		r_PtxU64Register380, g_OutputByteAddressAtPtx4940, r_PtxU64Register382, g_OutputByteAddressAtPtx4949,
		r_PtxU64Register384;
	uint64_t r_PtxU64Register385, r_PtxU64Register386, r_PtxU64Register387, r_PtxU64Register388,
		r_PtxU64Register389, r_PtxU64Register390, r_PtxU64Register391, r_PtxU64Register392,
		r_PtxU64Register393, r_PtxU64Register394, r_PtxU64Register395, r_PtxU64Register396;
	uint64_t r_PtxU64Register397, r_PtxU64Register398, r_PtxU64Register399, r_PtxU64Register400,
		r_PtxU64Register401, r_PtxU64Register402, r_PtxU64Register403, r_PtxU64Register404,
		r_PtxU64Register405, r_PtxU64Register406, r_PtxU64Register407, r_PtxU64Register408;
	uint64_t r_PtxU64Register409, r_PtxU64Register410, r_PtxU64Register411, r_PtxU64Register412,
		r_PtxU64Register413, r_PtxU64Register414, r_PtxU64Register415, r_PtxU64Register416,
		r_PtxU64Register417, r_PtxU64Register418, r_PtxU64Register419, r_PtxU64Register420;
	uint64_t r_PtxU64Register421, r_PtxU64Register422, r_PtxU64Register423, r_PtxU64Register424,
		r_PtxU64Register425, r_PtxU64Register426, r_PtxU64Register427, r_PtxU64Register428,
		r_PtxU64Register429, r_PtxU64Register430, r_PtxU64Register431, r_PtxU64Register432;
	uint64_t r_PtxU64Register433, r_PtxU64Register434, r_PtxU64Register435, r_PtxU64Register436,
		r_PtxU64Register437, r_PtxU64Register438, r_PtxU64Register439, r_PtxU64Register440,
		r_PtxU64Register441, r_PtxU64Register442, r_PtxU64Register443, r_PtxU64Register444;
	uint64_t r_PtxU64Register445, r_PtxU64Register446, r_PtxU64Register447, r_PtxU64Register448,
		r_PtxU64Register449, r_PtxU64Register450, r_PtxU64Register451, r_PtxU64Register452,
		r_PtxU64Register453, r_PtxU64Register454, r_PtxU64Register455, r_PtxU64Register456;
	uint64_t r_PtxU64Register457, r_PtxU64Register458, r_PtxU64Register459, r_PtxU64Register460,
		r_PtxU64Register461, r_PtxU64Register462, r_PtxU64Register463, r_PtxU64Register464,
		g_OutputByteAddressAtPtx3809, g_OutputByteAddressAtPtx3818, g_OutputByteAddressAtPtx3827,
		g_OutputByteAddressAtPtx3836;
	uint64_t r_PtxU64Register469, r_PtxU64Register470, g_OutputByteAddressAtPtx3817, r_PtxU64Register472,
		g_OutputByteAddressAtPtx3826, r_PtxU64Register474, g_OutputByteAddressAtPtx3835,
		g_OutputByteAddressAtPtx3849, g_OutputByteAddressAtPtx3858, g_OutputByteAddressAtPtx3867,
		g_OutputByteAddressAtPtx3876, r_PtxU64Register480;
	uint64_t r_PtxU64Register481, g_OutputByteAddressAtPtx3857, r_PtxU64Register483,
		g_OutputByteAddressAtPtx3866, r_PtxU64Register485, g_OutputByteAddressAtPtx3875,
		g_OutputByteAddressAtPtx3889, g_OutputByteAddressAtPtx3898, g_OutputByteAddressAtPtx3907,
		g_OutputByteAddressAtPtx3916, r_PtxU64Register491, r_PtxU64Register492;
	uint64_t g_OutputByteAddressAtPtx3897, r_PtxU64Register494, g_OutputByteAddressAtPtx3906,
		r_PtxU64Register496, g_OutputByteAddressAtPtx3915, g_OutputByteAddressAtPtx3929,
		g_OutputByteAddressAtPtx3938, g_OutputByteAddressAtPtx3947, g_OutputByteAddressAtPtx3956,
		r_PtxU64Register502, g_OutputByteAddressAtPtx3928, r_PtxU64Register504;
	uint64_t g_OutputByteAddressAtPtx3937, r_PtxU64Register506, g_OutputByteAddressAtPtx3946,
		r_PtxU64Register508, g_OutputByteAddressAtPtx3955, g_CounterByteAddress, r_PtxU64Register511,
		r_PtxU64Register512, r_PtxU64Register513, r_PtxU64Register514, r_PtxU64Register515,
		r_PtxU64Register516;
	uint64_t r_PtxU64Register517, r_PtxU64Register518, r_PtxU64Register519, r_PtxU64Register520,
		r_PtxU64Register521, r_PtxU64Register522, r_PtxU64Register523, r_PtxU64Register524,
		r_PtxU64Register525, r_PtxU64Register526;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_CounterBaseAddress = uint64_t(r_Parameters.g_Counter); // PTX L13
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);	 // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);	 // PTX L15
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip);	 // PTX L16
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);	 // PTX L17
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);								// PTX L18
	r_CtaX = uint32_t(blockIdx.x);												// PTX L19
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L20
	r_PtxRegister1 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits);			// PTX L21
	r_PtxRegister53 = uint32_t(r_PtxRegister1) + uint32_t(-1);					// PTX L22
	r_PtxRegister54 = ShiftRightSigned(int32_t(r_PtxRegister53), uint32_t(31)); // PTX L23
	r_PtxRegister55 = ShiftRight(uint32_t(r_PtxRegister54), uint32_t(25));		// PTX L24
	r_PtxRegister56 = uint32_t(r_PtxRegister53) + uint32_t(r_PtxRegister55);	// PTX L25
	r_PtxRegister57 = ShiftRightSigned(int32_t(r_PtxRegister56), uint32_t(7));	// PTX L26
	r_PtxRegister58 = uint32_t(r_PtxRegister57) + uint32_t(1);					// PTX L27
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister58));		// PTX L28
	r_PtxRegister59 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister57) + uint32_t(r_PtxRegister2); // PTX L29
	r_PtxRegister60 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister59);						 // PTX L30
	r_PtxRegister3 = ShiftLeft(uint32_t(r_PtxRegister60), uint32_t(3));					 // PTX L31
	r_PtxRegister61 = ShiftRight(uint32_t(r_PtxRegister54), uint32_t(28));				 // PTX L32
	r_PtxRegister62 = uint32_t(r_PtxRegister53) + uint32_t(r_PtxRegister61);			 // PTX L33
	r_PtxRegister63 = r_PtxRegister62 & -16;											 // PTX L34
	r_PtxRegister64 = uint32_t(r_PtxRegister63) + uint32_t(16);							 // PTX L35
	r_PtxRegister4 = ShiftRightSigned(int32_t(r_PtxRegister64), uint32_t(4));			 // PTX L36
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L37
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L38
	r_PtxRegister66 = r_ThreadX | r_ThreadY;											 // PTX L39
	r_bPtxPredicate5 = uint32_t(r_PtxRegister66) != uint32_t(0);						 // PTX L40
	if (r_bPtxPredicate5)
	{
		goto L__BB56_2;
	} // PTX L41
	r_BlockSizeX = uint32_t(blockDim.x);								 // PTX L42
	r_BlockSizeY = uint32_t(blockDim.y);								 // PTX L43
	r_PtxRegister68 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);	 // PTX L44
	r_PtxRegister67 = uint32_t(16384u /* original named shared base */); // PTX L45
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister67, r_PtxRegister68); // PTX L47
	r_PtxRegister69 = uint32_t(r_PtxRegister67) + uint32_t(8);		// PTX L49
	BarrierInit(s_SharedStorage, r_PtxRegister69, r_PtxRegister68); // PTX L51
L__BB56_2:															// PTX L53
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L54
	r_Float32BitsAtPtx55R72 = uint32_t(0);														// PTX L55
	r_PackedHalf2AtPtx4345R1850 = FloatToHalf2(r_Float32BitsAtPtx55R72);						// PTX L57
	r_PtxRegister81 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(17));								// PTX L62
	r_PtxRegister82 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(10));						// PTX L63
	r_PtxRegister83 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));								// PTX L64
	r_PtxRegister84 = r_PtxRegister83 & 512;													// PTX L65
	r_PtxRegister6 = r_PtxRegister82 | r_PtxRegister84;											// PTX L66
	r_PtxRegister85 = uint32_t(r_PtxRegister81) + uint32_t(r_PtxRegister6);						// PTX L67
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_PtxRegister85)) * int64_t(int32_t(4)));		// PTX L68
	g_RecordByteAddressAtPtx69 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register20);	// PTX L69
	r_LaneIndexAtPtx71 = uint32_t((threadIdx.x & 31u));											// PTX L71
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx71)) * int64_t(int32_t(16))); // PTX L73
	g_RecordByteAddressAtPtx74 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register22); // PTX L74
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx74));
		r_MmaBHalf2WordAtPtx76R1742 = r_Value.x;
		r_MmaBHalf2WordAtPtx76R1743 = r_Value.y;
		r_MmaBHalf2WordAtPtx76R1744 = r_Value.z;
		r_MmaBHalf2WordAtPtx76R1745 = r_Value.w;
	} // PTX L76
	r_PtxRegister7 = r_PtxRegister6 | 128;														// PTX L78
	r_LaneIndexAtPtx80 = uint32_t((threadIdx.x & 31u));											// PTX L80
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx80)) * int64_t(int32_t(16))); // PTX L82
	g_RecordByteAddressAtPtx83 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register23);		   // PTX L83
	g_RecordByteAddressAtPtx84 = uint64_t(g_RecordByteAddressAtPtx83) + uint64_t(512); // PTX L84
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx84));
		r_MmaBHalf2WordAtPtx86R1746 = r_Value.x;
		r_MmaBHalf2WordAtPtx86R1747 = r_Value.y;
		r_MmaBHalf2WordAtPtx86R1748 = r_Value.z;
		r_MmaBHalf2WordAtPtx86R1749 = r_Value.w;
	} // PTX L86
	r_PtxRegister8 = r_PtxRegister6 | 256;														// PTX L88
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register25);			// PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(1024); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBHalf2WordAtPtx96R1750 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R1751 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R1752 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R1753 = r_Value.w;
	} // PTX L96
	r_PtxRegister9 = r_PtxRegister6 | 384;														 // PTX L98
	r_LaneIndexAtPtx100 = uint32_t((threadIdx.x & 31u));										 // PTX L100
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx100)) * int64_t(int32_t(16))); // PTX L102
	g_RecordByteAddressAtPtx103 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register27);			  // PTX L103
	g_RecordByteAddressAtPtx104 = uint64_t(g_RecordByteAddressAtPtx103) + uint64_t(1536); // PTX L104
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx104));
		r_MmaBHalf2WordAtPtx106R1754 = r_Value.x;
		r_MmaBHalf2WordAtPtx106R1755 = r_Value.y;
		r_MmaBHalf2WordAtPtx106R1756 = r_Value.z;
		r_MmaBHalf2WordAtPtx106R1757 = r_Value.w;
	} // PTX L106
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	g_RecordByteAddressAtPtx112 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register29);			   // PTX L112
	g_RecordByteAddressAtPtx113 = uint64_t(g_RecordByteAddressAtPtx112) + uint64_t(32768); // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx113));
		r_MmaBHalf2WordAtPtx115R1758 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R1759 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R1760 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R1761 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	g_RecordByteAddressAtPtx121 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register31);			   // PTX L121
	g_RecordByteAddressAtPtx122 = uint64_t(g_RecordByteAddressAtPtx121) + uint64_t(33280); // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx122));
		r_MmaBHalf2WordAtPtx124R1762 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R1763 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R1764 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R1765 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register33 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	g_RecordByteAddressAtPtx130 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register33);			   // PTX L130
	g_RecordByteAddressAtPtx131 = uint64_t(g_RecordByteAddressAtPtx130) + uint64_t(33792); // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx131));
		r_MmaBHalf2WordAtPtx133R1766 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R1767 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R1768 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R1769 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register35 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	g_RecordByteAddressAtPtx139 =
		uint64_t(g_RecordByteAddressAtPtx69) + uint64_t(r_PtxU64Register35);			   // PTX L139
	g_RecordByteAddressAtPtx140 = uint64_t(g_RecordByteAddressAtPtx139) + uint64_t(34304); // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx140));
		r_MmaBHalf2WordAtPtx142R1770 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R1771 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R1772 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R1773 = r_Value.w;
	} // PTX L142
	r_PtxRegister10 = r_ThreadY & 1;										// PTX L144
	r_PtxRegister86 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			// PTX L145
	r_PtxRegister87 = uint32_t(r_PtxRegister86) + uint32_t(r_PtxRegister3); // PTX L146
	r_PtxRegister11 = uint32_t(r_PtxRegister1) + uint32_t(14);				// PTX L147
	r_bPtxPredicate6 = uint32_t(r_PtxRegister11) < uint32_t(31);			// PTX L148
	r_bPtxPredicate7 = int32_t(r_PtxRegister87) < int32_t(r_PtxRegister4);	// PTX L149
	r_bPtxPredicate1 = r_bPtxPredicate6 | r_bPtxPredicate7;					// PTX L150
	r_PtxU64Register511 = uint64_t(0);										// PTX L151
	r_bPtxPredicate8 = !r_bPtxPredicate1;									// PTX L152
	if (r_bPtxPredicate8)
	{
		goto L__BB56_4;
	} // PTX L153
	r_bPtxPredicate9 = uint32_t(r_PtxRegister11) < uint32_t(31);			 // PTX L154
	r_PtxRegister88 = ShiftLeft(uint32_t(r_PtxRegister87), uint32_t(13));	 // PTX L155
	r_PtxRegister89 = r_bPtxPredicate9 ? 0 : r_PtxRegister88;				 // PTX L156
	r_PtxRegister90 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(11));			 // PTX L157
	r_PtxRegister91 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(7));	 // PTX L158
	r_PtxRegister92 = r_PtxRegister90 | r_PtxRegister91;					 // PTX L159
	r_PtxRegister93 = uint32_t(r_PtxRegister89) + uint32_t(r_PtxRegister92); // PTX L160
	r_PtxU64Register511 = SignExtendWordBits(r_PtxRegister93);				 // PTX L161
L__BB56_4:																	 // PTX L162
	r_PtxU64Register512 = uint64_t(0);										 // PTX L163
	if (r_bPtxPredicate8)
	{
		goto L__BB56_6;
	} // PTX L164
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register511), uint32_t(2));		   // PTX L165
	r_PtxU64Register512 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register37); // PTX L166
L__BB56_6:																			   // PTX L167
	r_PtxRegister94 = uint32_t(0u /* original named shared base */);				   // PTX L168
	r_PtxRegister12 = uint32_t(r_PtxRegister94) + uint32_t(r_PtxRegister83);		   // PTX L169
	if (r_bPtxPredicate8)
	{
		goto L__BB56_9;
	} // PTX L170
	r_PtxRegister99 = uint32_t(-1);								  // PTX L171
	r_PtxRegister98 = Elected(r_PtxRegister99);					  // PTX L173
	r_bPtxPredicate10 = uint32_t(r_PtxRegister98) == uint32_t(0); // PTX L179
	if (r_bPtxPredicate10)
	{
		goto L__BB56_10;
	} // PTX L180
	r_PtxU64Register38 = r_PtxU64Register512;							  // PTX L181
	r_PtxRegister101 = uint32_t(16384u /* original named shared base */); // PTX L182
	r_PtxRegister100 = uint32_t(512);									  // PTX L183
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister12, r_PtxU64Register38, r_PtxRegister100,
			 r_PtxRegister101);												 // PTX L185
	BarrierExpect(s_SharedStorage, r_PtxRegister101, r_PtxRegister100);		 // PTX L188
	goto L__BB56_10;														 // PTX L190
L__BB56_9:																	 // PTX L191
	r_LaneIndexAtPtx193 = uint32_t((threadIdx.x & 31u));					 // PTX L193
	r_PtxRegister97 = ShiftLeft(uint32_t(r_LaneIndexAtPtx193), uint32_t(4)); // PTX L195
	r_PtxRegister96 = uint32_t(r_PtxRegister12) + uint32_t(r_PtxRegister97); // PTX L196
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister96)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850);							  // PTX L198
L__BB56_10:																	  // PTX L200
	r_bPtxPredicate11 = uint32_t(r_PtxRegister11) < uint32_t(31);			  // PTX L201
	r_PtxRegister102 = uint32_t(r_ThreadY) + uint32_t(4);					  // PTX L202
	r_PtxRegister103 = ShiftRight(uint32_t(r_PtxRegister102), uint32_t(1));	  // PTX L203
	r_PtxRegister13 = ShiftLeft(uint32_t(r_PtxRegister103), uint32_t(8));	  // PTX L204
	r_PtxRegister14 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(7));	  // PTX L205
	r_PtxRegister104 = uint32_t(r_PtxRegister103) + uint32_t(r_PtxRegister3); // PTX L206
	r_bPtxPredicate12 = int32_t(r_PtxRegister104) < int32_t(r_PtxRegister4);  // PTX L207
	r_bPtxPredicate2 = r_bPtxPredicate11 | r_bPtxPredicate12;				  // PTX L208
	r_PtxU64Register513 = uint64_t(0);										  // PTX L209
	r_bPtxPredicate13 = !r_bPtxPredicate2;									  // PTX L210
	if (r_bPtxPredicate13)
	{
		goto L__BB56_12;
	} // PTX L211
	r_bPtxPredicate14 = uint32_t(r_PtxRegister11) < uint32_t(31);				// PTX L212
	r_PtxRegister105 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(13));		// PTX L213
	r_PtxRegister106 = r_bPtxPredicate14 ? 0 : r_PtxRegister105;				// PTX L214
	r_PtxRegister107 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(11));				// PTX L215
	r_PtxRegister108 = r_PtxRegister107 | r_PtxRegister14;						// PTX L216
	r_PtxRegister109 = uint32_t(r_PtxRegister106) + uint32_t(r_PtxRegister108); // PTX L217
	r_PtxU64Register513 = SignExtendWordBits(r_PtxRegister109);					// PTX L218
L__BB56_12:																		// PTX L219
	r_PtxU64Register514 = uint64_t(0);											// PTX L220
	if (r_bPtxPredicate13)
	{
		goto L__BB56_14;
	} // PTX L221
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register513), uint32_t(2));		   // PTX L222
	r_PtxU64Register514 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register39); // PTX L223
L__BB56_14:																			   // PTX L224
	r_PtxRegister110 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister14);		   // PTX L225
	r_PtxRegister111 = ShiftLeft(uint32_t(r_PtxRegister110), uint32_t(2));			   // PTX L226
	r_PtxRegister112 = uint32_t(0u /* original named shared base */);				   // PTX L227
	r_PtxRegister15 = uint32_t(r_PtxRegister112) + uint32_t(r_PtxRegister111);		   // PTX L228
	if (r_bPtxPredicate13)
	{
		goto L__BB56_17;
	} // PTX L229
	r_PtxRegister117 = uint32_t(-1);							   // PTX L230
	r_PtxRegister116 = Elected(r_PtxRegister117);				   // PTX L232
	r_bPtxPredicate15 = uint32_t(r_PtxRegister116) == uint32_t(0); // PTX L238
	if (r_bPtxPredicate15)
	{
		goto L__BB56_18;
	} // PTX L239
	r_PtxU64Register40 = r_PtxU64Register514;							  // PTX L240
	r_PtxRegister119 = uint32_t(16384u /* original named shared base */); // PTX L241
	r_PtxRegister118 = uint32_t(512);									  // PTX L242
	CopyBulk(s_SharedStorage, r_PtxRegister15, r_PtxU64Register40, r_PtxRegister118,
			 r_PtxRegister119);												   // PTX L244
	BarrierExpect(s_SharedStorage, r_PtxRegister119, r_PtxRegister118);		   // PTX L247
	goto L__BB56_18;														   // PTX L249
L__BB56_17:																	   // PTX L250
	r_LaneIndexAtPtx252 = uint32_t((threadIdx.x & 31u));					   // PTX L252
	r_PtxRegister115 = ShiftLeft(uint32_t(r_LaneIndexAtPtx252), uint32_t(4));  // PTX L254
	r_PtxRegister114 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister115); // PTX L255
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister114)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850);							  // PTX L257
L__BB56_18:																	  // PTX L259
	r_bPtxPredicate16 = uint32_t(r_PtxRegister11) < uint32_t(31);			  // PTX L260
	r_PtxRegister120 = uint32_t(r_ThreadY) + uint32_t(8);					  // PTX L261
	r_PtxRegister121 = ShiftRight(uint32_t(r_PtxRegister120), uint32_t(1));	  // PTX L262
	r_PtxRegister16 = ShiftLeft(uint32_t(r_PtxRegister121), uint32_t(8));	  // PTX L263
	r_PtxRegister122 = uint32_t(r_PtxRegister121) + uint32_t(r_PtxRegister3); // PTX L264
	r_bPtxPredicate17 = int32_t(r_PtxRegister122) < int32_t(r_PtxRegister4);  // PTX L265
	r_bPtxPredicate3 = r_bPtxPredicate16 | r_bPtxPredicate17;				  // PTX L266
	r_PtxU64Register515 = uint64_t(0);										  // PTX L267
	r_bPtxPredicate18 = !r_bPtxPredicate3;									  // PTX L268
	if (r_bPtxPredicate18)
	{
		goto L__BB56_20;
	} // PTX L269
	r_bPtxPredicate19 = uint32_t(r_PtxRegister11) < uint32_t(31);				// PTX L270
	r_PtxRegister123 = ShiftLeft(uint32_t(r_PtxRegister122), uint32_t(13));		// PTX L271
	r_PtxRegister124 = r_bPtxPredicate19 ? 0 : r_PtxRegister123;				// PTX L272
	r_PtxRegister125 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(11));				// PTX L273
	r_PtxRegister126 = r_PtxRegister125 | r_PtxRegister14;						// PTX L274
	r_PtxRegister127 = uint32_t(r_PtxRegister124) + uint32_t(r_PtxRegister126); // PTX L275
	r_PtxU64Register515 = SignExtendWordBits(r_PtxRegister127);					// PTX L276
L__BB56_20:																		// PTX L277
	r_PtxU64Register516 = uint64_t(0);											// PTX L278
	if (r_bPtxPredicate18)
	{
		goto L__BB56_22;
	} // PTX L279
	r_PtxU64Register41 = ShiftLeft(uint64_t(r_PtxU64Register515), uint32_t(2));		   // PTX L280
	r_PtxU64Register516 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register41); // PTX L281
L__BB56_22:																			   // PTX L282
	r_PtxRegister128 = uint32_t(r_PtxRegister16) + uint32_t(r_PtxRegister14);		   // PTX L283
	r_PtxRegister129 = ShiftLeft(uint32_t(r_PtxRegister128), uint32_t(2));			   // PTX L284
	r_PtxRegister130 = uint32_t(0u /* original named shared base */);				   // PTX L285
	r_PtxRegister17 = uint32_t(r_PtxRegister130) + uint32_t(r_PtxRegister129);		   // PTX L286
	if (r_bPtxPredicate18)
	{
		goto L__BB56_25;
	} // PTX L287
	r_PtxRegister135 = uint32_t(-1);							   // PTX L288
	r_PtxRegister134 = Elected(r_PtxRegister135);				   // PTX L290
	r_bPtxPredicate20 = uint32_t(r_PtxRegister134) == uint32_t(0); // PTX L296
	if (r_bPtxPredicate20)
	{
		goto L__BB56_26;
	} // PTX L297
	r_PtxU64Register42 = r_PtxU64Register516;							  // PTX L298
	r_PtxRegister137 = uint32_t(16384u /* original named shared base */); // PTX L299
	r_PtxRegister136 = uint32_t(512);									  // PTX L300
	CopyBulk(s_SharedStorage, r_PtxRegister17, r_PtxU64Register42, r_PtxRegister136,
			 r_PtxRegister137);												   // PTX L302
	BarrierExpect(s_SharedStorage, r_PtxRegister137, r_PtxRegister136);		   // PTX L305
	goto L__BB56_26;														   // PTX L307
L__BB56_25:																	   // PTX L308
	r_LaneIndexAtPtx310 = uint32_t((threadIdx.x & 31u));					   // PTX L310
	r_PtxRegister133 = ShiftLeft(uint32_t(r_LaneIndexAtPtx310), uint32_t(4));  // PTX L312
	r_PtxRegister132 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister133); // PTX L313
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister132)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850);							  // PTX L315
L__BB56_26:																	  // PTX L317
	r_bPtxPredicate21 = uint32_t(r_PtxRegister11) < uint32_t(31);			  // PTX L318
	r_PtxRegister138 = uint32_t(r_ThreadY) + uint32_t(12);					  // PTX L319
	r_PtxRegister139 = ShiftRight(uint32_t(r_PtxRegister138), uint32_t(1));	  // PTX L320
	r_PtxRegister18 = ShiftLeft(uint32_t(r_PtxRegister139), uint32_t(8));	  // PTX L321
	r_PtxRegister140 = uint32_t(r_PtxRegister139) + uint32_t(r_PtxRegister3); // PTX L322
	r_bPtxPredicate22 = int32_t(r_PtxRegister140) < int32_t(r_PtxRegister4);  // PTX L323
	r_bPtxPredicate4 = r_bPtxPredicate21 | r_bPtxPredicate22;				  // PTX L324
	r_PtxU64Register517 = uint64_t(0);										  // PTX L325
	r_bPtxPredicate23 = !r_bPtxPredicate4;									  // PTX L326
	if (r_bPtxPredicate23)
	{
		goto L__BB56_28;
	} // PTX L327
	r_bPtxPredicate24 = uint32_t(r_PtxRegister11) < uint32_t(31);				// PTX L328
	r_PtxRegister141 = ShiftLeft(uint32_t(r_PtxRegister140), uint32_t(13));		// PTX L329
	r_PtxRegister142 = r_bPtxPredicate24 ? 0 : r_PtxRegister141;				// PTX L330
	r_PtxRegister143 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(11));				// PTX L331
	r_PtxRegister144 = r_PtxRegister143 | r_PtxRegister14;						// PTX L332
	r_PtxRegister145 = uint32_t(r_PtxRegister142) + uint32_t(r_PtxRegister144); // PTX L333
	r_PtxU64Register517 = SignExtendWordBits(r_PtxRegister145);					// PTX L334
L__BB56_28:																		// PTX L335
	r_PtxU64Register518 = uint64_t(0);											// PTX L336
	if (r_bPtxPredicate23)
	{
		goto L__BB56_30;
	} // PTX L337
	r_PtxU64Register43 = ShiftLeft(uint64_t(r_PtxU64Register517), uint32_t(2));		   // PTX L338
	r_PtxU64Register518 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register43); // PTX L339
L__BB56_30:																			   // PTX L340
	r_PtxRegister146 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister14);		   // PTX L341
	r_PtxRegister147 = ShiftLeft(uint32_t(r_PtxRegister146), uint32_t(2));			   // PTX L342
	r_PtxRegister148 = uint32_t(0u /* original named shared base */);				   // PTX L343
	r_PtxRegister19 = uint32_t(r_PtxRegister148) + uint32_t(r_PtxRegister147);		   // PTX L344
	if (r_bPtxPredicate23)
	{
		goto L__BB56_33;
	} // PTX L345
	r_PtxRegister153 = uint32_t(-1);							   // PTX L346
	r_PtxRegister152 = Elected(r_PtxRegister153);				   // PTX L348
	r_bPtxPredicate25 = uint32_t(r_PtxRegister152) == uint32_t(0); // PTX L354
	if (r_bPtxPredicate25)
	{
		goto L__BB56_34;
	} // PTX L355
	r_PtxU64Register44 = r_PtxU64Register518;							  // PTX L356
	r_PtxRegister155 = uint32_t(16384u /* original named shared base */); // PTX L357
	r_PtxRegister154 = uint32_t(512);									  // PTX L358
	CopyBulk(s_SharedStorage, r_PtxRegister19, r_PtxU64Register44, r_PtxRegister154,
			 r_PtxRegister155);												   // PTX L360
	BarrierExpect(s_SharedStorage, r_PtxRegister155, r_PtxRegister154);		   // PTX L363
	goto L__BB56_34;														   // PTX L365
L__BB56_33:																	   // PTX L366
	r_LaneIndexAtPtx368 = uint32_t((threadIdx.x & 31u));					   // PTX L368
	r_PtxRegister151 = ShiftLeft(uint32_t(r_LaneIndexAtPtx368), uint32_t(4));  // PTX L370
	r_PtxRegister150 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister151); // PTX L371
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister150)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850);						  // PTX L373
L__BB56_34:																  // PTX L375
	r_PtxRegister156 = uint32_t(16384u /* original named shared base */); // PTX L376
	r_PtxRegister157 = uint32_t(1);										  // PTX L377
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register45 = BarrierArrive(s_SharedStorage, r_PtxRegister156, r_PtxRegister157); // PTX L379
L__BB56_35:																					 // PTX L381
	r_PtxRegister159 = uint32_t(16384u /* original named shared base */);					 // PTX L382
	r_PtxRegister158 = BarrierReady(s_SharedStorage, r_PtxRegister159, r_PtxU64Register45);	 // PTX L384
	r_bPtxPredicate26 = uint32_t(r_PtxRegister158) == uint32_t(0);							 // PTX L390
	if (r_bPtxPredicate26)
	{
		goto L__BB56_35;
	} // PTX L391
	r_bPtxPredicate27 = uint32_t(r_CtaZ) != uint32_t(0);				// PTX L392
	r_PackedHalf2AtPtx393R1677 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L393
	r_PackedHalf2AtPtx394R1678 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L394
	r_PackedHalf2AtPtx395R1679 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L395
	r_PackedHalf2AtPtx396R1680 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L396
	r_PackedHalf2AtPtx397R1681 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L397
	r_PackedHalf2AtPtx398R1682 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L398
	r_PackedHalf2AtPtx399R1683 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L399
	r_PackedHalf2AtPtx400R1684 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L400
	r_PackedHalf2AtPtx401R1685 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L401
	r_PackedHalf2AtPtx402R1686 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L402
	r_PackedHalf2AtPtx403R1687 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L403
	r_PackedHalf2AtPtx404R1688 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L404
	r_PackedHalf2AtPtx405R1689 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L405
	r_PackedHalf2AtPtx406R1690 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L406
	r_PackedHalf2AtPtx407R1691 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L407
	r_PackedHalf2AtPtx408R1692 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L408
	r_PackedHalf2AtPtx409R1693 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L409
	r_PackedHalf2AtPtx410R1694 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L410
	r_PackedHalf2AtPtx411R1695 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L411
	r_PackedHalf2AtPtx412R1696 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L412
	r_PackedHalf2AtPtx413R1697 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L413
	r_PackedHalf2AtPtx414R1698 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L414
	r_PackedHalf2AtPtx415R1699 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L415
	r_PackedHalf2AtPtx416R1700 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L416
	r_PackedHalf2AtPtx417R1701 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L417
	r_PackedHalf2AtPtx418R1702 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L418
	r_PackedHalf2AtPtx419R1703 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L419
	r_PackedHalf2AtPtx420R1704 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L420
	r_PackedHalf2AtPtx421R1705 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L421
	r_PackedHalf2AtPtx422R1706 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L422
	r_PackedHalf2AtPtx423R1707 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L423
	r_PackedHalf2AtPtx424R1708 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L424
	r_PackedHalf2AtPtx425R1709 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L425
	r_PackedHalf2AtPtx426R1710 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L426
	r_PackedHalf2AtPtx427R1711 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L427
	r_PackedHalf2AtPtx428R1712 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L428
	r_PackedHalf2AtPtx429R1713 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L429
	r_PackedHalf2AtPtx430R1714 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L430
	r_PackedHalf2AtPtx431R1715 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L431
	r_PackedHalf2AtPtx432R1716 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L432
	r_PackedHalf2AtPtx433R1717 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L433
	r_PackedHalf2AtPtx434R1718 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L434
	r_PackedHalf2AtPtx435R1719 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L435
	r_PackedHalf2AtPtx436R1720 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L436
	r_PackedHalf2AtPtx437R1721 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L437
	r_PackedHalf2AtPtx438R1722 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L438
	r_PackedHalf2AtPtx439R1723 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L439
	r_PackedHalf2AtPtx440R1724 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L440
	r_PackedHalf2AtPtx441R1725 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L441
	r_PackedHalf2AtPtx442R1726 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L442
	r_PackedHalf2AtPtx443R1727 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L443
	r_PackedHalf2AtPtx444R1728 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L444
	r_PackedHalf2AtPtx445R1729 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L445
	r_PackedHalf2AtPtx446R1730 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L446
	r_PackedHalf2AtPtx447R1731 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L447
	r_PackedHalf2AtPtx448R1732 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L448
	r_PackedHalf2AtPtx449R1733 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L449
	r_PackedHalf2AtPtx450R1734 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L450
	r_PackedHalf2AtPtx451R1735 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L451
	r_PackedHalf2AtPtx452R1736 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L452
	r_PackedHalf2AtPtx453R1737 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L453
	r_PackedHalf2AtPtx454R1738 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L454
	r_PackedHalf2AtPtx455R1739 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L455
	r_PackedHalf2AtPtx456R1740 = uint32_t(r_PackedHalf2AtPtx4345R1850); // PTX L456
	if (r_bPtxPredicate27)
	{
		goto L__BB56_86;
	} // PTX L457
	r_bPtxPredicate28 = uint32_t(r_PtxRegister11) < uint32_t(31);			 // PTX L458
	r_PtxRegister160 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));			 // PTX L459
	r_PtxRegister161 = r_PtxRegister160 & 2044;								 // PTX L460
	r_PtxRegister20 = uint32_t(r_PtxRegister161) + uint32_t(r_PtxRegister3); // PTX L461
	r_PtxRegister1597 = uint32_t(0);										 // PTX L462
	if (r_bPtxPredicate28)
	{
		goto L__BB56_39;
	} // PTX L463
	r_bPtxPredicate29 = int32_t(r_PtxRegister20) >= int32_t(r_PtxRegister4); // PTX L464
	r_PtxRegister1597 = uint32_t(r_PtxRegister20);							 // PTX L465
	r_PackedHalf2AtPtx466R1598 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L466
	r_PackedHalf2AtPtx467R1599 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L467
	r_PackedHalf2AtPtx468R1600 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L468
	r_PackedHalf2AtPtx469R1601 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L469
	if (r_bPtxPredicate29)
	{
		goto L__BB56_40;
	} // PTX L470
L__BB56_39:																					 // PTX L471
	r_PtxRegister163 = ShiftLeft(uint32_t(r_PtxRegister1597), uint32_t(13));				 // PTX L472
	r_PtxRegister164 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister6);				 // PTX L473
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_PtxRegister164)) * int64_t(int32_t(4))); // PTX L474
	g_ResidualByteAddressAtPtx475 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register47);							 // PTX L475
	r_LaneIndexAtPtx477 = uint32_t((threadIdx.x & 31u));										 // PTX L477
	r_PtxU64Register49 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx477)) * int64_t(int32_t(16))); // PTX L479
	g_ResidualByteAddressAtPtx480 =
		uint64_t(g_ResidualByteAddressAtPtx475) + uint64_t(r_PtxU64Register49); // PTX L480
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx480));
		r_PackedHalf2AtPtx466R1598 = r_Value.x;
		r_PackedHalf2AtPtx467R1599 = r_Value.y;
		r_PackedHalf2AtPtx468R1600 = r_Value.z;
		r_PackedHalf2AtPtx469R1601 = r_Value.w;
	} // PTX L482
L__BB56_40:														  // PTX L484
	r_bPtxPredicate30 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L485
	r_PtxRegister1602 = uint32_t(0);							  // PTX L486
	if (r_bPtxPredicate30)
	{
		goto L__BB56_42;
	} // PTX L487
	r_bPtxPredicate31 = int32_t(r_PtxRegister20) >= int32_t(r_PtxRegister4); // PTX L488
	r_PtxRegister1602 = uint32_t(r_PtxRegister20);							 // PTX L489
	r_PackedHalf2AtPtx490R1603 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L490
	r_PackedHalf2AtPtx491R1604 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L491
	r_PackedHalf2AtPtx492R1605 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L492
	r_PackedHalf2AtPtx493R1606 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L493
	if (r_bPtxPredicate31)
	{
		goto L__BB56_43;
	} // PTX L494
L__BB56_42:																					 // PTX L495
	r_PtxRegister166 = ShiftLeft(uint32_t(r_PtxRegister1602), uint32_t(13));				 // PTX L496
	r_PtxRegister167 = uint32_t(r_PtxRegister166) + uint32_t(r_PtxRegister7);				 // PTX L497
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_PtxRegister167)) * int64_t(int32_t(4))); // PTX L498
	g_ResidualByteAddressAtPtx499 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register51);							 // PTX L499
	r_LaneIndexAtPtx501 = uint32_t((threadIdx.x & 31u));										 // PTX L501
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx501)) * int64_t(int32_t(16))); // PTX L503
	g_ResidualByteAddressAtPtx504 =
		uint64_t(g_ResidualByteAddressAtPtx499) + uint64_t(r_PtxU64Register53); // PTX L504
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx504));
		r_PackedHalf2AtPtx490R1603 = r_Value.x;
		r_PackedHalf2AtPtx491R1604 = r_Value.y;
		r_PackedHalf2AtPtx492R1605 = r_Value.z;
		r_PackedHalf2AtPtx493R1606 = r_Value.w;
	} // PTX L506
L__BB56_43:														  // PTX L508
	r_bPtxPredicate32 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L509
	r_PtxRegister1607 = uint32_t(0);							  // PTX L510
	if (r_bPtxPredicate32)
	{
		goto L__BB56_45;
	} // PTX L511
	r_bPtxPredicate33 = int32_t(r_PtxRegister20) >= int32_t(r_PtxRegister4); // PTX L512
	r_PtxRegister1607 = uint32_t(r_PtxRegister20);							 // PTX L513
	r_PackedHalf2AtPtx514R1608 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L514
	r_PackedHalf2AtPtx515R1609 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L515
	r_PackedHalf2AtPtx516R1610 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L516
	r_PackedHalf2AtPtx517R1611 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L517
	if (r_bPtxPredicate33)
	{
		goto L__BB56_46;
	} // PTX L518
L__BB56_45:																					 // PTX L519
	r_PtxRegister169 = ShiftLeft(uint32_t(r_PtxRegister1607), uint32_t(13));				 // PTX L520
	r_PtxRegister170 = uint32_t(r_PtxRegister169) + uint32_t(r_PtxRegister8);				 // PTX L521
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_PtxRegister170)) * int64_t(int32_t(4))); // PTX L522
	g_ResidualByteAddressAtPtx523 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register55);							 // PTX L523
	r_LaneIndexAtPtx525 = uint32_t((threadIdx.x & 31u));										 // PTX L525
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx525)) * int64_t(int32_t(16))); // PTX L527
	g_ResidualByteAddressAtPtx528 =
		uint64_t(g_ResidualByteAddressAtPtx523) + uint64_t(r_PtxU64Register57); // PTX L528
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx528));
		r_PackedHalf2AtPtx514R1608 = r_Value.x;
		r_PackedHalf2AtPtx515R1609 = r_Value.y;
		r_PackedHalf2AtPtx516R1610 = r_Value.z;
		r_PackedHalf2AtPtx517R1611 = r_Value.w;
	} // PTX L530
L__BB56_46:														  // PTX L532
	r_bPtxPredicate34 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L533
	r_PtxRegister1612 = uint32_t(0);							  // PTX L534
	if (r_bPtxPredicate34)
	{
		goto L__BB56_48;
	} // PTX L535
	r_bPtxPredicate35 = int32_t(r_PtxRegister20) >= int32_t(r_PtxRegister4); // PTX L536
	r_PtxRegister1612 = uint32_t(r_PtxRegister20);							 // PTX L537
	r_PackedHalf2AtPtx538R1613 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L538
	r_PackedHalf2AtPtx539R1614 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L539
	r_PackedHalf2AtPtx540R1615 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L540
	r_PackedHalf2AtPtx541R1616 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L541
	if (r_bPtxPredicate35)
	{
		goto L__BB56_49;
	} // PTX L542
L__BB56_48:																					 // PTX L543
	r_PtxRegister172 = ShiftLeft(uint32_t(r_PtxRegister1612), uint32_t(13));				 // PTX L544
	r_PtxRegister173 = uint32_t(r_PtxRegister172) + uint32_t(r_PtxRegister9);				 // PTX L545
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_PtxRegister173)) * int64_t(int32_t(4))); // PTX L546
	g_ResidualByteAddressAtPtx547 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register59);							 // PTX L547
	r_LaneIndexAtPtx549 = uint32_t((threadIdx.x & 31u));										 // PTX L549
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx549)) * int64_t(int32_t(16))); // PTX L551
	g_ResidualByteAddressAtPtx552 =
		uint64_t(g_ResidualByteAddressAtPtx547) + uint64_t(r_PtxU64Register61); // PTX L552
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx552));
		r_PackedHalf2AtPtx538R1613 = r_Value.x;
		r_PackedHalf2AtPtx539R1614 = r_Value.y;
		r_PackedHalf2AtPtx540R1615 = r_Value.z;
		r_PackedHalf2AtPtx541R1616 = r_Value.w;
	} // PTX L554
L__BB56_49:														  // PTX L556
	r_bPtxPredicate36 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L557
	r_PtxRegister21 = uint32_t(r_PtxRegister20) + uint32_t(1);	  // PTX L558
	r_PtxRegister1617 = uint32_t(0);							  // PTX L559
	if (r_bPtxPredicate36)
	{
		goto L__BB56_51;
	} // PTX L560
	r_bPtxPredicate37 = int32_t(r_PtxRegister21) >= int32_t(r_PtxRegister4); // PTX L561
	r_PtxRegister1617 = uint32_t(r_PtxRegister21);							 // PTX L562
	r_PackedHalf2AtPtx563R1618 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L563
	r_PackedHalf2AtPtx564R1619 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L564
	r_PackedHalf2AtPtx565R1620 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L565
	r_PackedHalf2AtPtx566R1621 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L566
	if (r_bPtxPredicate37)
	{
		goto L__BB56_52;
	} // PTX L567
L__BB56_51:																					 // PTX L568
	r_PtxRegister175 = ShiftLeft(uint32_t(r_PtxRegister1617), uint32_t(13));				 // PTX L569
	r_PtxRegister176 = uint32_t(r_PtxRegister175) + uint32_t(r_PtxRegister6);				 // PTX L570
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_PtxRegister176)) * int64_t(int32_t(4))); // PTX L571
	g_ResidualByteAddressAtPtx572 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register63);							 // PTX L572
	r_LaneIndexAtPtx574 = uint32_t((threadIdx.x & 31u));										 // PTX L574
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx574)) * int64_t(int32_t(16))); // PTX L576
	g_ResidualByteAddressAtPtx577 =
		uint64_t(g_ResidualByteAddressAtPtx572) + uint64_t(r_PtxU64Register65); // PTX L577
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx577));
		r_PackedHalf2AtPtx563R1618 = r_Value.x;
		r_PackedHalf2AtPtx564R1619 = r_Value.y;
		r_PackedHalf2AtPtx565R1620 = r_Value.z;
		r_PackedHalf2AtPtx566R1621 = r_Value.w;
	} // PTX L579
L__BB56_52:														  // PTX L581
	r_bPtxPredicate38 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L582
	r_PtxRegister1622 = uint32_t(0);							  // PTX L583
	if (r_bPtxPredicate38)
	{
		goto L__BB56_54;
	} // PTX L584
	r_bPtxPredicate39 = int32_t(r_PtxRegister21) >= int32_t(r_PtxRegister4); // PTX L585
	r_PtxRegister1622 = uint32_t(r_PtxRegister21);							 // PTX L586
	r_PackedHalf2AtPtx587R1623 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L587
	r_PackedHalf2AtPtx588R1624 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L588
	r_PackedHalf2AtPtx589R1625 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L589
	r_PackedHalf2AtPtx590R1626 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L590
	if (r_bPtxPredicate39)
	{
		goto L__BB56_55;
	} // PTX L591
L__BB56_54:																					 // PTX L592
	r_PtxRegister178 = ShiftLeft(uint32_t(r_PtxRegister1622), uint32_t(13));				 // PTX L593
	r_PtxRegister179 = uint32_t(r_PtxRegister178) + uint32_t(r_PtxRegister7);				 // PTX L594
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_PtxRegister179)) * int64_t(int32_t(4))); // PTX L595
	g_ResidualByteAddressAtPtx596 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register67);							 // PTX L596
	r_LaneIndexAtPtx598 = uint32_t((threadIdx.x & 31u));										 // PTX L598
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx598)) * int64_t(int32_t(16))); // PTX L600
	g_ResidualByteAddressAtPtx601 =
		uint64_t(g_ResidualByteAddressAtPtx596) + uint64_t(r_PtxU64Register69); // PTX L601
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx601));
		r_PackedHalf2AtPtx587R1623 = r_Value.x;
		r_PackedHalf2AtPtx588R1624 = r_Value.y;
		r_PackedHalf2AtPtx589R1625 = r_Value.z;
		r_PackedHalf2AtPtx590R1626 = r_Value.w;
	} // PTX L603
L__BB56_55:														  // PTX L605
	r_bPtxPredicate40 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L606
	r_PtxRegister1627 = uint32_t(0);							  // PTX L607
	if (r_bPtxPredicate40)
	{
		goto L__BB56_57;
	} // PTX L608
	r_bPtxPredicate41 = int32_t(r_PtxRegister21) >= int32_t(r_PtxRegister4); // PTX L609
	r_PtxRegister1627 = uint32_t(r_PtxRegister21);							 // PTX L610
	r_PackedHalf2AtPtx611R1628 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L611
	r_PackedHalf2AtPtx612R1629 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L612
	r_PackedHalf2AtPtx613R1630 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L613
	r_PackedHalf2AtPtx614R1631 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L614
	if (r_bPtxPredicate41)
	{
		goto L__BB56_58;
	} // PTX L615
L__BB56_57:																					 // PTX L616
	r_PtxRegister181 = ShiftLeft(uint32_t(r_PtxRegister1627), uint32_t(13));				 // PTX L617
	r_PtxRegister182 = uint32_t(r_PtxRegister181) + uint32_t(r_PtxRegister8);				 // PTX L618
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_PtxRegister182)) * int64_t(int32_t(4))); // PTX L619
	g_ResidualByteAddressAtPtx620 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register71);							 // PTX L620
	r_LaneIndexAtPtx622 = uint32_t((threadIdx.x & 31u));										 // PTX L622
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx622)) * int64_t(int32_t(16))); // PTX L624
	g_ResidualByteAddressAtPtx625 =
		uint64_t(g_ResidualByteAddressAtPtx620) + uint64_t(r_PtxU64Register73); // PTX L625
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx625));
		r_PackedHalf2AtPtx611R1628 = r_Value.x;
		r_PackedHalf2AtPtx612R1629 = r_Value.y;
		r_PackedHalf2AtPtx613R1630 = r_Value.z;
		r_PackedHalf2AtPtx614R1631 = r_Value.w;
	} // PTX L627
L__BB56_58:														  // PTX L629
	r_bPtxPredicate42 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L630
	r_PtxRegister1632 = uint32_t(0);							  // PTX L631
	if (r_bPtxPredicate42)
	{
		goto L__BB56_60;
	} // PTX L632
	r_bPtxPredicate43 = int32_t(r_PtxRegister21) >= int32_t(r_PtxRegister4); // PTX L633
	r_PtxRegister1632 = uint32_t(r_PtxRegister21);							 // PTX L634
	r_PackedHalf2AtPtx635R1633 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L635
	r_PackedHalf2AtPtx636R1634 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L636
	r_PackedHalf2AtPtx637R1635 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L637
	r_PackedHalf2AtPtx638R1636 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L638
	if (r_bPtxPredicate43)
	{
		goto L__BB56_61;
	} // PTX L639
L__BB56_60:																					 // PTX L640
	r_PtxRegister184 = ShiftLeft(uint32_t(r_PtxRegister1632), uint32_t(13));				 // PTX L641
	r_PtxRegister185 = uint32_t(r_PtxRegister184) + uint32_t(r_PtxRegister9);				 // PTX L642
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_PtxRegister185)) * int64_t(int32_t(4))); // PTX L643
	g_ResidualByteAddressAtPtx644 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register75);							 // PTX L644
	r_LaneIndexAtPtx646 = uint32_t((threadIdx.x & 31u));										 // PTX L646
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx646)) * int64_t(int32_t(16))); // PTX L648
	g_ResidualByteAddressAtPtx649 =
		uint64_t(g_ResidualByteAddressAtPtx644) + uint64_t(r_PtxU64Register77); // PTX L649
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx649));
		r_PackedHalf2AtPtx635R1633 = r_Value.x;
		r_PackedHalf2AtPtx636R1634 = r_Value.y;
		r_PackedHalf2AtPtx637R1635 = r_Value.z;
		r_PackedHalf2AtPtx638R1636 = r_Value.w;
	} // PTX L651
L__BB56_61:														  // PTX L653
	r_bPtxPredicate44 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L654
	r_PtxRegister22 = uint32_t(r_PtxRegister20) + uint32_t(2);	  // PTX L655
	r_PtxRegister1637 = uint32_t(0);							  // PTX L656
	if (r_bPtxPredicate44)
	{
		goto L__BB56_63;
	} // PTX L657
	r_bPtxPredicate45 = int32_t(r_PtxRegister22) >= int32_t(r_PtxRegister4); // PTX L658
	r_PtxRegister1637 = uint32_t(r_PtxRegister22);							 // PTX L659
	r_PackedHalf2AtPtx660R1638 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L660
	r_PackedHalf2AtPtx661R1639 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L661
	r_PackedHalf2AtPtx662R1640 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L662
	r_PackedHalf2AtPtx663R1641 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L663
	if (r_bPtxPredicate45)
	{
		goto L__BB56_64;
	} // PTX L664
L__BB56_63:																					 // PTX L665
	r_PtxRegister187 = ShiftLeft(uint32_t(r_PtxRegister1637), uint32_t(13));				 // PTX L666
	r_PtxRegister188 = uint32_t(r_PtxRegister187) + uint32_t(r_PtxRegister6);				 // PTX L667
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister188)) * int64_t(int32_t(4))); // PTX L668
	g_ResidualByteAddressAtPtx669 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register79);							 // PTX L669
	r_LaneIndexAtPtx671 = uint32_t((threadIdx.x & 31u));										 // PTX L671
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx671)) * int64_t(int32_t(16))); // PTX L673
	g_ResidualByteAddressAtPtx674 =
		uint64_t(g_ResidualByteAddressAtPtx669) + uint64_t(r_PtxU64Register81); // PTX L674
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx674));
		r_PackedHalf2AtPtx660R1638 = r_Value.x;
		r_PackedHalf2AtPtx661R1639 = r_Value.y;
		r_PackedHalf2AtPtx662R1640 = r_Value.z;
		r_PackedHalf2AtPtx663R1641 = r_Value.w;
	} // PTX L676
L__BB56_64:														  // PTX L678
	r_bPtxPredicate46 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L679
	r_PtxRegister1642 = uint32_t(0);							  // PTX L680
	if (r_bPtxPredicate46)
	{
		goto L__BB56_66;
	} // PTX L681
	r_bPtxPredicate47 = int32_t(r_PtxRegister22) >= int32_t(r_PtxRegister4); // PTX L682
	r_PtxRegister1642 = uint32_t(r_PtxRegister22);							 // PTX L683
	r_PackedHalf2AtPtx684R1643 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L684
	r_PackedHalf2AtPtx685R1644 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L685
	r_PackedHalf2AtPtx686R1645 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L686
	r_PackedHalf2AtPtx687R1646 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L687
	if (r_bPtxPredicate47)
	{
		goto L__BB56_67;
	} // PTX L688
L__BB56_66:																					 // PTX L689
	r_PtxRegister190 = ShiftLeft(uint32_t(r_PtxRegister1642), uint32_t(13));				 // PTX L690
	r_PtxRegister191 = uint32_t(r_PtxRegister190) + uint32_t(r_PtxRegister7);				 // PTX L691
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_PtxRegister191)) * int64_t(int32_t(4))); // PTX L692
	g_ResidualByteAddressAtPtx693 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register83);							 // PTX L693
	r_LaneIndexAtPtx695 = uint32_t((threadIdx.x & 31u));										 // PTX L695
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx695)) * int64_t(int32_t(16))); // PTX L697
	g_ResidualByteAddressAtPtx698 =
		uint64_t(g_ResidualByteAddressAtPtx693) + uint64_t(r_PtxU64Register85); // PTX L698
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx698));
		r_PackedHalf2AtPtx684R1643 = r_Value.x;
		r_PackedHalf2AtPtx685R1644 = r_Value.y;
		r_PackedHalf2AtPtx686R1645 = r_Value.z;
		r_PackedHalf2AtPtx687R1646 = r_Value.w;
	} // PTX L700
L__BB56_67:														  // PTX L702
	r_bPtxPredicate48 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L703
	r_PtxRegister1647 = uint32_t(0);							  // PTX L704
	if (r_bPtxPredicate48)
	{
		goto L__BB56_69;
	} // PTX L705
	r_bPtxPredicate49 = int32_t(r_PtxRegister22) >= int32_t(r_PtxRegister4); // PTX L706
	r_PtxRegister1647 = uint32_t(r_PtxRegister22);							 // PTX L707
	r_PackedHalf2AtPtx708R1648 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L708
	r_PackedHalf2AtPtx709R1649 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L709
	r_PackedHalf2AtPtx710R1650 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L710
	r_PackedHalf2AtPtx711R1651 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L711
	if (r_bPtxPredicate49)
	{
		goto L__BB56_70;
	} // PTX L712
L__BB56_69:																					 // PTX L713
	r_PtxRegister193 = ShiftLeft(uint32_t(r_PtxRegister1647), uint32_t(13));				 // PTX L714
	r_PtxRegister194 = uint32_t(r_PtxRegister193) + uint32_t(r_PtxRegister8);				 // PTX L715
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_PtxRegister194)) * int64_t(int32_t(4))); // PTX L716
	g_ResidualByteAddressAtPtx717 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register87);							 // PTX L717
	r_LaneIndexAtPtx719 = uint32_t((threadIdx.x & 31u));										 // PTX L719
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx719)) * int64_t(int32_t(16))); // PTX L721
	g_ResidualByteAddressAtPtx722 =
		uint64_t(g_ResidualByteAddressAtPtx717) + uint64_t(r_PtxU64Register89); // PTX L722
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx722));
		r_PackedHalf2AtPtx708R1648 = r_Value.x;
		r_PackedHalf2AtPtx709R1649 = r_Value.y;
		r_PackedHalf2AtPtx710R1650 = r_Value.z;
		r_PackedHalf2AtPtx711R1651 = r_Value.w;
	} // PTX L724
L__BB56_70:														  // PTX L726
	r_bPtxPredicate50 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L727
	r_PtxRegister1652 = uint32_t(0);							  // PTX L728
	if (r_bPtxPredicate50)
	{
		goto L__BB56_72;
	} // PTX L729
	r_bPtxPredicate51 = int32_t(r_PtxRegister22) >= int32_t(r_PtxRegister4); // PTX L730
	r_PtxRegister1652 = uint32_t(r_PtxRegister22);							 // PTX L731
	r_PackedHalf2AtPtx732R1653 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L732
	r_PackedHalf2AtPtx733R1654 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L733
	r_PackedHalf2AtPtx734R1655 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L734
	r_PackedHalf2AtPtx735R1656 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L735
	if (r_bPtxPredicate51)
	{
		goto L__BB56_73;
	} // PTX L736
L__BB56_72:																					 // PTX L737
	r_PtxRegister196 = ShiftLeft(uint32_t(r_PtxRegister1652), uint32_t(13));				 // PTX L738
	r_PtxRegister197 = uint32_t(r_PtxRegister196) + uint32_t(r_PtxRegister9);				 // PTX L739
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister197)) * int64_t(int32_t(4))); // PTX L740
	g_ResidualByteAddressAtPtx741 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register91);							 // PTX L741
	r_LaneIndexAtPtx743 = uint32_t((threadIdx.x & 31u));										 // PTX L743
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx743)) * int64_t(int32_t(16))); // PTX L745
	g_ResidualByteAddressAtPtx746 =
		uint64_t(g_ResidualByteAddressAtPtx741) + uint64_t(r_PtxU64Register93); // PTX L746
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx746));
		r_PackedHalf2AtPtx732R1653 = r_Value.x;
		r_PackedHalf2AtPtx733R1654 = r_Value.y;
		r_PackedHalf2AtPtx734R1655 = r_Value.z;
		r_PackedHalf2AtPtx735R1656 = r_Value.w;
	} // PTX L748
L__BB56_73:														  // PTX L750
	r_bPtxPredicate52 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L751
	r_PtxRegister23 = uint32_t(r_PtxRegister20) + uint32_t(3);	  // PTX L752
	r_PtxRegister1657 = uint32_t(0);							  // PTX L753
	if (r_bPtxPredicate52)
	{
		goto L__BB56_75;
	} // PTX L754
	r_bPtxPredicate53 = int32_t(r_PtxRegister23) >= int32_t(r_PtxRegister4); // PTX L755
	r_PtxRegister1657 = uint32_t(r_PtxRegister23);							 // PTX L756
	r_PackedHalf2AtPtx757R1658 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L757
	r_PackedHalf2AtPtx758R1659 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L758
	r_PackedHalf2AtPtx759R1660 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L759
	r_PackedHalf2AtPtx760R1661 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L760
	if (r_bPtxPredicate53)
	{
		goto L__BB56_76;
	} // PTX L761
L__BB56_75:																					 // PTX L762
	r_PtxRegister199 = ShiftLeft(uint32_t(r_PtxRegister1657), uint32_t(13));				 // PTX L763
	r_PtxRegister200 = uint32_t(r_PtxRegister199) + uint32_t(r_PtxRegister6);				 // PTX L764
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister200)) * int64_t(int32_t(4))); // PTX L765
	g_ResidualByteAddressAtPtx766 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register95);							 // PTX L766
	r_LaneIndexAtPtx768 = uint32_t((threadIdx.x & 31u));										 // PTX L768
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx768)) * int64_t(int32_t(16))); // PTX L770
	g_ResidualByteAddressAtPtx771 =
		uint64_t(g_ResidualByteAddressAtPtx766) + uint64_t(r_PtxU64Register97); // PTX L771
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx771));
		r_PackedHalf2AtPtx757R1658 = r_Value.x;
		r_PackedHalf2AtPtx758R1659 = r_Value.y;
		r_PackedHalf2AtPtx759R1660 = r_Value.z;
		r_PackedHalf2AtPtx760R1661 = r_Value.w;
	} // PTX L773
L__BB56_76:														  // PTX L775
	r_bPtxPredicate54 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L776
	r_PtxRegister1662 = uint32_t(0);							  // PTX L777
	if (r_bPtxPredicate54)
	{
		goto L__BB56_78;
	} // PTX L778
	r_bPtxPredicate55 = int32_t(r_PtxRegister23) >= int32_t(r_PtxRegister4); // PTX L779
	r_PtxRegister1662 = uint32_t(r_PtxRegister23);							 // PTX L780
	r_PackedHalf2AtPtx781R1663 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L781
	r_PackedHalf2AtPtx782R1664 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L782
	r_PackedHalf2AtPtx783R1665 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L783
	r_PackedHalf2AtPtx784R1666 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L784
	if (r_bPtxPredicate55)
	{
		goto L__BB56_79;
	} // PTX L785
L__BB56_78:																					 // PTX L786
	r_PtxRegister202 = ShiftLeft(uint32_t(r_PtxRegister1662), uint32_t(13));				 // PTX L787
	r_PtxRegister203 = uint32_t(r_PtxRegister202) + uint32_t(r_PtxRegister7);				 // PTX L788
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister203)) * int64_t(int32_t(4))); // PTX L789
	g_ResidualByteAddressAtPtx790 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register99);							  // PTX L790
	r_LaneIndexAtPtx792 = uint32_t((threadIdx.x & 31u));										  // PTX L792
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx792)) * int64_t(int32_t(16))); // PTX L794
	g_ResidualByteAddressAtPtx795 =
		uint64_t(g_ResidualByteAddressAtPtx790) + uint64_t(r_PtxU64Register101); // PTX L795
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx795));
		r_PackedHalf2AtPtx781R1663 = r_Value.x;
		r_PackedHalf2AtPtx782R1664 = r_Value.y;
		r_PackedHalf2AtPtx783R1665 = r_Value.z;
		r_PackedHalf2AtPtx784R1666 = r_Value.w;
	} // PTX L797
L__BB56_79:														  // PTX L799
	r_bPtxPredicate56 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L800
	r_PtxRegister1667 = uint32_t(0);							  // PTX L801
	if (r_bPtxPredicate56)
	{
		goto L__BB56_81;
	} // PTX L802
	r_bPtxPredicate57 = int32_t(r_PtxRegister23) >= int32_t(r_PtxRegister4); // PTX L803
	r_PtxRegister1667 = uint32_t(r_PtxRegister23);							 // PTX L804
	r_PackedHalf2AtPtx805R1668 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L805
	r_PackedHalf2AtPtx806R1669 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L806
	r_PackedHalf2AtPtx807R1670 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L807
	r_PackedHalf2AtPtx808R1671 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L808
	if (r_bPtxPredicate57)
	{
		goto L__BB56_82;
	} // PTX L809
L__BB56_81:																					  // PTX L810
	r_PtxRegister205 = ShiftLeft(uint32_t(r_PtxRegister1667), uint32_t(13));				  // PTX L811
	r_PtxRegister206 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister8);				  // PTX L812
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister206)) * int64_t(int32_t(4))); // PTX L813
	g_ResidualByteAddressAtPtx814 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register103);						  // PTX L814
	r_LaneIndexAtPtx816 = uint32_t((threadIdx.x & 31u));										  // PTX L816
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx816)) * int64_t(int32_t(16))); // PTX L818
	g_ResidualByteAddressAtPtx819 =
		uint64_t(g_ResidualByteAddressAtPtx814) + uint64_t(r_PtxU64Register105); // PTX L819
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx819));
		r_PackedHalf2AtPtx805R1668 = r_Value.x;
		r_PackedHalf2AtPtx806R1669 = r_Value.y;
		r_PackedHalf2AtPtx807R1670 = r_Value.z;
		r_PackedHalf2AtPtx808R1671 = r_Value.w;
	} // PTX L821
L__BB56_82:														  // PTX L823
	r_bPtxPredicate58 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L824
	r_PtxRegister1672 = uint32_t(0);							  // PTX L825
	if (r_bPtxPredicate58)
	{
		goto L__BB56_84;
	} // PTX L826
	r_bPtxPredicate59 = int32_t(r_PtxRegister23) >= int32_t(r_PtxRegister4); // PTX L827
	r_PtxRegister1672 = uint32_t(r_PtxRegister23);							 // PTX L828
	r_PackedHalf2AtPtx829R1673 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L829
	r_PackedHalf2AtPtx830R1674 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L830
	r_PackedHalf2AtPtx831R1675 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L831
	r_PackedHalf2AtPtx832R1676 = uint32_t(r_PackedHalf2AtPtx4345R1850);		 // PTX L832
	if (r_bPtxPredicate59)
	{
		goto L__BB56_85;
	} // PTX L833
L__BB56_84:																					  // PTX L834
	r_PtxRegister208 = ShiftLeft(uint32_t(r_PtxRegister1672), uint32_t(13));				  // PTX L835
	r_PtxRegister209 = uint32_t(r_PtxRegister208) + uint32_t(r_PtxRegister9);				  // PTX L836
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister209)) * int64_t(int32_t(4))); // PTX L837
	g_ResidualByteAddressAtPtx838 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register107);						  // PTX L838
	r_LaneIndexAtPtx840 = uint32_t((threadIdx.x & 31u));										  // PTX L840
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx840)) * int64_t(int32_t(16))); // PTX L842
	g_ResidualByteAddressAtPtx843 =
		uint64_t(g_ResidualByteAddressAtPtx838) + uint64_t(r_PtxU64Register109); // PTX L843
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx843));
		r_PackedHalf2AtPtx829R1673 = r_Value.x;
		r_PackedHalf2AtPtx830R1674 = r_Value.y;
		r_PackedHalf2AtPtx831R1675 = r_Value.z;
		r_PackedHalf2AtPtx832R1676 = r_Value.w;
	} // PTX L845
L__BB56_85:																					  // PTX L847
	g_RecordByteAddressAtPtx848 = g_RecordBaseAddress;										  // PTX L848
	r_PtxRegister402 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));							  // PTX L849
	r_PtxRegister403 = r_PtxRegister402 & 64;												  // PTX L850
	r_PtxRegister404 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(7));					  // PTX L851
	r_PtxRegister405 = r_PtxRegister403 | r_PtxRegister404;									  // PTX L852
	r_PtxRegister406 = r_PtxRegister405 | 8;												  // PTX L853
	r_LaneIndexAtPtx855 = uint32_t((threadIdx.x & 31u));									  // PTX L855
	r_PtxRegister407 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx855), uint32_t(31));		  // PTX L857
	r_PtxRegister408 = ShiftRight(uint32_t(r_PtxRegister407), uint32_t(30));				  // PTX L858
	r_PtxRegister409 = uint32_t(r_LaneIndexAtPtx855) + uint32_t(r_PtxRegister408);			  // PTX L859
	r_PtxRegister410 = r_PtxRegister409 & 2147483644;										  // PTX L860
	r_PtxRegister411 = uint32_t(r_LaneIndexAtPtx855) - uint32_t(r_PtxRegister410);			  // PTX L861
	r_PtxRegister412 = ShiftLeft(uint32_t(r_PtxRegister411), uint32_t(1));					  // PTX L862
	r_PtxRegister413 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister412);				  // PTX L863
	r_PtxRegister414 = ShiftRightSigned(int32_t(r_PtxRegister413), uint32_t(1));			  // PTX L864
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister414)) * int64_t(int32_t(4))); // PTX L865
	g_RecordByteAddressAtPtx866 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register111); // PTX L866
	r_PtxRegister275 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx866 + 2097152ull);		  // PTX L867
	r_LaneIndexAtPtx869 = uint32_t((threadIdx.x & 31u));									  // PTX L869
	r_PtxRegister415 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx869), uint32_t(31));		  // PTX L871
	r_PtxRegister416 = ShiftRight(uint32_t(r_PtxRegister415), uint32_t(30));				  // PTX L872
	r_PtxRegister417 = uint32_t(r_LaneIndexAtPtx869) + uint32_t(r_PtxRegister416);			  // PTX L873
	r_PtxRegister418 = r_PtxRegister417 & 2147483644;										  // PTX L874
	r_PtxRegister419 = uint32_t(r_LaneIndexAtPtx869) - uint32_t(r_PtxRegister418);			  // PTX L875
	r_PtxRegister420 = ShiftLeft(uint32_t(r_PtxRegister419), uint32_t(1));					  // PTX L876
	r_PtxRegister421 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister420);				  // PTX L877
	r_PtxRegister422 = ShiftRightSigned(int32_t(r_PtxRegister421), uint32_t(1));			  // PTX L878
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister422)) * int64_t(int32_t(4))); // PTX L879
	g_RecordByteAddressAtPtx880 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register113); // PTX L880
	r_PtxRegister277 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx880 + 2097152ull);		  // PTX L881
	r_LaneIndexAtPtx883 = uint32_t((threadIdx.x & 31u));									  // PTX L883
	r_PtxRegister423 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx883), uint32_t(31));		  // PTX L885
	r_PtxRegister424 = ShiftRight(uint32_t(r_PtxRegister423), uint32_t(30));				  // PTX L886
	r_PtxRegister425 = uint32_t(r_LaneIndexAtPtx883) + uint32_t(r_PtxRegister424);			  // PTX L887
	r_PtxRegister426 = r_PtxRegister425 & 2147483644;										  // PTX L888
	r_PtxRegister427 = uint32_t(r_LaneIndexAtPtx883) - uint32_t(r_PtxRegister426);			  // PTX L889
	r_PtxRegister428 = ShiftLeft(uint32_t(r_PtxRegister427), uint32_t(1));					  // PTX L890
	r_PtxRegister429 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister428);				  // PTX L891
	r_PtxRegister430 = ShiftRightSigned(int32_t(r_PtxRegister429), uint32_t(1));			  // PTX L892
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister430)) * int64_t(int32_t(4))); // PTX L893
	g_RecordByteAddressAtPtx894 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register115); // PTX L894
	r_PtxRegister279 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx894 + 2097152ull);		  // PTX L895
	r_LaneIndexAtPtx897 = uint32_t((threadIdx.x & 31u));									  // PTX L897
	r_PtxRegister431 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx897), uint32_t(31));		  // PTX L899
	r_PtxRegister432 = ShiftRight(uint32_t(r_PtxRegister431), uint32_t(30));				  // PTX L900
	r_PtxRegister433 = uint32_t(r_LaneIndexAtPtx897) + uint32_t(r_PtxRegister432);			  // PTX L901
	r_PtxRegister434 = r_PtxRegister433 & 2147483644;										  // PTX L902
	r_PtxRegister435 = uint32_t(r_LaneIndexAtPtx897) - uint32_t(r_PtxRegister434);			  // PTX L903
	r_PtxRegister436 = ShiftLeft(uint32_t(r_PtxRegister435), uint32_t(1));					  // PTX L904
	r_PtxRegister437 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister436);				  // PTX L905
	r_PtxRegister438 = ShiftRightSigned(int32_t(r_PtxRegister437), uint32_t(1));			  // PTX L906
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister438)) * int64_t(int32_t(4))); // PTX L907
	g_RecordByteAddressAtPtx908 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register117); // PTX L908
	r_PtxRegister281 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx908 + 2097152ull);		  // PTX L909
	r_LaneIndexAtPtx911 = uint32_t((threadIdx.x & 31u));									  // PTX L911
	r_PtxRegister439 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx911), uint32_t(31));		  // PTX L913
	r_PtxRegister440 = ShiftRight(uint32_t(r_PtxRegister439), uint32_t(30));				  // PTX L914
	r_PtxRegister441 = uint32_t(r_LaneIndexAtPtx911) + uint32_t(r_PtxRegister440);			  // PTX L915
	r_PtxRegister442 = r_PtxRegister441 & 2147483644;										  // PTX L916
	r_PtxRegister443 = uint32_t(r_LaneIndexAtPtx911) - uint32_t(r_PtxRegister442);			  // PTX L917
	r_PtxRegister444 = ShiftLeft(uint32_t(r_PtxRegister443), uint32_t(1));					  // PTX L918
	r_PtxRegister445 = r_PtxRegister405 | 16;												  // PTX L919
	r_PtxRegister446 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister444);				  // PTX L920
	r_PtxRegister447 = ShiftRightSigned(int32_t(r_PtxRegister446), uint32_t(1));			  // PTX L921
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister447)) * int64_t(int32_t(4))); // PTX L922
	g_RecordByteAddressAtPtx923 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register119); // PTX L923
	r_PtxRegister283 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx923 + 2097152ull);		  // PTX L924
	r_LaneIndexAtPtx926 = uint32_t((threadIdx.x & 31u));									  // PTX L926
	r_PtxRegister448 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx926), uint32_t(31));		  // PTX L928
	r_PtxRegister449 = ShiftRight(uint32_t(r_PtxRegister448), uint32_t(30));				  // PTX L929
	r_PtxRegister450 = uint32_t(r_LaneIndexAtPtx926) + uint32_t(r_PtxRegister449);			  // PTX L930
	r_PtxRegister451 = r_PtxRegister450 & 2147483644;										  // PTX L931
	r_PtxRegister452 = uint32_t(r_LaneIndexAtPtx926) - uint32_t(r_PtxRegister451);			  // PTX L932
	r_PtxRegister453 = ShiftLeft(uint32_t(r_PtxRegister452), uint32_t(1));					  // PTX L933
	r_PtxRegister454 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister453);				  // PTX L934
	r_PtxRegister455 = ShiftRightSigned(int32_t(r_PtxRegister454), uint32_t(1));			  // PTX L935
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister455)) * int64_t(int32_t(4))); // PTX L936
	g_RecordByteAddressAtPtx937 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register121); // PTX L937
	r_PtxRegister285 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx937 + 2097152ull);		  // PTX L938
	r_LaneIndexAtPtx940 = uint32_t((threadIdx.x & 31u));									  // PTX L940
	r_PtxRegister456 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx940), uint32_t(31));		  // PTX L942
	r_PtxRegister457 = ShiftRight(uint32_t(r_PtxRegister456), uint32_t(30));				  // PTX L943
	r_PtxRegister458 = uint32_t(r_LaneIndexAtPtx940) + uint32_t(r_PtxRegister457);			  // PTX L944
	r_PtxRegister459 = r_PtxRegister458 & 2147483644;										  // PTX L945
	r_PtxRegister460 = uint32_t(r_LaneIndexAtPtx940) - uint32_t(r_PtxRegister459);			  // PTX L946
	r_PtxRegister461 = ShiftLeft(uint32_t(r_PtxRegister460), uint32_t(1));					  // PTX L947
	r_PtxRegister462 = r_PtxRegister405 | 24;												  // PTX L948
	r_PtxRegister463 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister461);				  // PTX L949
	r_PtxRegister464 = ShiftRightSigned(int32_t(r_PtxRegister463), uint32_t(1));			  // PTX L950
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister464)) * int64_t(int32_t(4))); // PTX L951
	g_RecordByteAddressAtPtx952 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register123); // PTX L952
	r_PtxRegister287 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx952 + 2097152ull);		  // PTX L953
	r_LaneIndexAtPtx955 = uint32_t((threadIdx.x & 31u));									  // PTX L955
	r_PtxRegister465 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx955), uint32_t(31));		  // PTX L957
	r_PtxRegister466 = ShiftRight(uint32_t(r_PtxRegister465), uint32_t(30));				  // PTX L958
	r_PtxRegister467 = uint32_t(r_LaneIndexAtPtx955) + uint32_t(r_PtxRegister466);			  // PTX L959
	r_PtxRegister468 = r_PtxRegister467 & 2147483644;										  // PTX L960
	r_PtxRegister469 = uint32_t(r_LaneIndexAtPtx955) - uint32_t(r_PtxRegister468);			  // PTX L961
	r_PtxRegister470 = ShiftLeft(uint32_t(r_PtxRegister469), uint32_t(1));					  // PTX L962
	r_PtxRegister471 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister470);				  // PTX L963
	r_PtxRegister472 = ShiftRightSigned(int32_t(r_PtxRegister471), uint32_t(1));			  // PTX L964
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister472)) * int64_t(int32_t(4))); // PTX L965
	g_RecordByteAddressAtPtx966 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register125); // PTX L966
	r_PtxRegister289 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx966 + 2097152ull);		  // PTX L967
	r_LaneIndexAtPtx969 = uint32_t((threadIdx.x & 31u));									  // PTX L969
	r_PtxRegister473 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx969), uint32_t(31));		  // PTX L971
	r_PtxRegister474 = ShiftRight(uint32_t(r_PtxRegister473), uint32_t(30));				  // PTX L972
	r_PtxRegister475 = uint32_t(r_LaneIndexAtPtx969) + uint32_t(r_PtxRegister474);			  // PTX L973
	r_PtxRegister476 = r_PtxRegister475 & 2147483644;										  // PTX L974
	r_PtxRegister477 = uint32_t(r_LaneIndexAtPtx969) - uint32_t(r_PtxRegister476);			  // PTX L975
	r_PtxRegister478 = ShiftLeft(uint32_t(r_PtxRegister477), uint32_t(1));					  // PTX L976
	r_PtxRegister479 = r_PtxRegister405 | 32;												  // PTX L977
	r_PtxRegister480 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister478);				  // PTX L978
	r_PtxRegister481 = ShiftRightSigned(int32_t(r_PtxRegister480), uint32_t(1));			  // PTX L979
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister481)) * int64_t(int32_t(4))); // PTX L980
	g_RecordByteAddressAtPtx981 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register127); // PTX L981
	r_PtxRegister291 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx981 + 2097152ull);		  // PTX L982
	r_LaneIndexAtPtx984 = uint32_t((threadIdx.x & 31u));									  // PTX L984
	r_PtxRegister482 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx984), uint32_t(31));		  // PTX L986
	r_PtxRegister483 = ShiftRight(uint32_t(r_PtxRegister482), uint32_t(30));				  // PTX L987
	r_PtxRegister484 = uint32_t(r_LaneIndexAtPtx984) + uint32_t(r_PtxRegister483);			  // PTX L988
	r_PtxRegister485 = r_PtxRegister484 & 2147483644;										  // PTX L989
	r_PtxRegister486 = uint32_t(r_LaneIndexAtPtx984) - uint32_t(r_PtxRegister485);			  // PTX L990
	r_PtxRegister487 = ShiftLeft(uint32_t(r_PtxRegister486), uint32_t(1));					  // PTX L991
	r_PtxRegister488 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister487);				  // PTX L992
	r_PtxRegister489 = ShiftRightSigned(int32_t(r_PtxRegister488), uint32_t(1));			  // PTX L993
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister489)) * int64_t(int32_t(4))); // PTX L994
	g_RecordByteAddressAtPtx995 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register129); // PTX L995
	r_PtxRegister293 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx995 + 2097152ull);		  // PTX L996
	r_LaneIndexAtPtx998 = uint32_t((threadIdx.x & 31u));									  // PTX L998
	r_PtxRegister490 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx998), uint32_t(31));		  // PTX L1000
	r_PtxRegister491 = ShiftRight(uint32_t(r_PtxRegister490), uint32_t(30));				  // PTX L1001
	r_PtxRegister492 = uint32_t(r_LaneIndexAtPtx998) + uint32_t(r_PtxRegister491);			  // PTX L1002
	r_PtxRegister493 = r_PtxRegister492 & 2147483644;										  // PTX L1003
	r_PtxRegister494 = uint32_t(r_LaneIndexAtPtx998) - uint32_t(r_PtxRegister493);			  // PTX L1004
	r_PtxRegister495 = ShiftLeft(uint32_t(r_PtxRegister494), uint32_t(1));					  // PTX L1005
	r_PtxRegister496 = r_PtxRegister405 | 40;												  // PTX L1006
	r_PtxRegister497 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister495);				  // PTX L1007
	r_PtxRegister498 = ShiftRightSigned(int32_t(r_PtxRegister497), uint32_t(1));			  // PTX L1008
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister498)) * int64_t(int32_t(4))); // PTX L1009
	g_RecordByteAddressAtPtx1010 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register131); // PTX L1010
	r_PtxRegister295 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1010 + 2097152ull);		  // PTX L1011
	r_LaneIndexAtPtx1013 = uint32_t((threadIdx.x & 31u));									  // PTX L1013
	r_PtxRegister499 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1013), uint32_t(31));		  // PTX L1015
	r_PtxRegister500 = ShiftRight(uint32_t(r_PtxRegister499), uint32_t(30));				  // PTX L1016
	r_PtxRegister501 = uint32_t(r_LaneIndexAtPtx1013) + uint32_t(r_PtxRegister500);			  // PTX L1017
	r_PtxRegister502 = r_PtxRegister501 & 2147483644;										  // PTX L1018
	r_PtxRegister503 = uint32_t(r_LaneIndexAtPtx1013) - uint32_t(r_PtxRegister502);			  // PTX L1019
	r_PtxRegister504 = ShiftLeft(uint32_t(r_PtxRegister503), uint32_t(1));					  // PTX L1020
	r_PtxRegister505 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister504);				  // PTX L1021
	r_PtxRegister506 = ShiftRightSigned(int32_t(r_PtxRegister505), uint32_t(1));			  // PTX L1022
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister506)) * int64_t(int32_t(4))); // PTX L1023
	g_RecordByteAddressAtPtx1024 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register133); // PTX L1024
	r_PtxRegister297 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1024 + 2097152ull);		  // PTX L1025
	r_LaneIndexAtPtx1027 = uint32_t((threadIdx.x & 31u));									  // PTX L1027
	r_PtxRegister507 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1027), uint32_t(31));		  // PTX L1029
	r_PtxRegister508 = ShiftRight(uint32_t(r_PtxRegister507), uint32_t(30));				  // PTX L1030
	r_PtxRegister509 = uint32_t(r_LaneIndexAtPtx1027) + uint32_t(r_PtxRegister508);			  // PTX L1031
	r_PtxRegister510 = r_PtxRegister509 & 2147483644;										  // PTX L1032
	r_PtxRegister511 = uint32_t(r_LaneIndexAtPtx1027) - uint32_t(r_PtxRegister510);			  // PTX L1033
	r_PtxRegister512 = ShiftLeft(uint32_t(r_PtxRegister511), uint32_t(1));					  // PTX L1034
	r_PtxRegister513 = r_PtxRegister405 | 48;												  // PTX L1035
	r_PtxRegister514 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister512);				  // PTX L1036
	r_PtxRegister515 = ShiftRightSigned(int32_t(r_PtxRegister514), uint32_t(1));			  // PTX L1037
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister515)) * int64_t(int32_t(4))); // PTX L1038
	g_RecordByteAddressAtPtx1039 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register135); // PTX L1039
	r_PtxRegister299 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1039 + 2097152ull);		  // PTX L1040
	r_LaneIndexAtPtx1042 = uint32_t((threadIdx.x & 31u));									  // PTX L1042
	r_PtxRegister516 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1042), uint32_t(31));		  // PTX L1044
	r_PtxRegister517 = ShiftRight(uint32_t(r_PtxRegister516), uint32_t(30));				  // PTX L1045
	r_PtxRegister518 = uint32_t(r_LaneIndexAtPtx1042) + uint32_t(r_PtxRegister517);			  // PTX L1046
	r_PtxRegister519 = r_PtxRegister518 & 2147483644;										  // PTX L1047
	r_PtxRegister520 = uint32_t(r_LaneIndexAtPtx1042) - uint32_t(r_PtxRegister519);			  // PTX L1048
	r_PtxRegister521 = ShiftLeft(uint32_t(r_PtxRegister520), uint32_t(1));					  // PTX L1049
	r_PtxRegister522 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister521);				  // PTX L1050
	r_PtxRegister523 = ShiftRightSigned(int32_t(r_PtxRegister522), uint32_t(1));			  // PTX L1051
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister523)) * int64_t(int32_t(4))); // PTX L1052
	g_RecordByteAddressAtPtx1053 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register137); // PTX L1053
	r_PtxRegister301 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1053 + 2097152ull);		  // PTX L1054
	r_LaneIndexAtPtx1056 = uint32_t((threadIdx.x & 31u));									  // PTX L1056
	r_PtxRegister524 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1056), uint32_t(31));		  // PTX L1058
	r_PtxRegister525 = ShiftRight(uint32_t(r_PtxRegister524), uint32_t(30));				  // PTX L1059
	r_PtxRegister526 = uint32_t(r_LaneIndexAtPtx1056) + uint32_t(r_PtxRegister525);			  // PTX L1060
	r_PtxRegister527 = r_PtxRegister526 & 2147483644;										  // PTX L1061
	r_PtxRegister528 = uint32_t(r_LaneIndexAtPtx1056) - uint32_t(r_PtxRegister527);			  // PTX L1062
	r_PtxRegister529 = ShiftLeft(uint32_t(r_PtxRegister528), uint32_t(1));					  // PTX L1063
	r_PtxRegister530 = r_PtxRegister405 | 56;												  // PTX L1064
	r_PtxRegister531 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister529);				  // PTX L1065
	r_PtxRegister532 = ShiftRightSigned(int32_t(r_PtxRegister531), uint32_t(1));			  // PTX L1066
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister532)) * int64_t(int32_t(4))); // PTX L1067
	g_RecordByteAddressAtPtx1068 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register139); // PTX L1068
	r_PtxRegister303 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1068 + 2097152ull);		  // PTX L1069
	r_LaneIndexAtPtx1071 = uint32_t((threadIdx.x & 31u));									  // PTX L1071
	r_PtxRegister533 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1071), uint32_t(31));		  // PTX L1073
	r_PtxRegister534 = ShiftRight(uint32_t(r_PtxRegister533), uint32_t(30));				  // PTX L1074
	r_PtxRegister535 = uint32_t(r_LaneIndexAtPtx1071) + uint32_t(r_PtxRegister534);			  // PTX L1075
	r_PtxRegister536 = r_PtxRegister535 & 2147483644;										  // PTX L1076
	r_PtxRegister537 = uint32_t(r_LaneIndexAtPtx1071) - uint32_t(r_PtxRegister536);			  // PTX L1077
	r_PtxRegister538 = ShiftLeft(uint32_t(r_PtxRegister537), uint32_t(1));					  // PTX L1078
	r_PtxRegister539 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister538);				  // PTX L1079
	r_PtxRegister540 = ShiftRightSigned(int32_t(r_PtxRegister539), uint32_t(1));			  // PTX L1080
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister540)) * int64_t(int32_t(4))); // PTX L1081
	g_RecordByteAddressAtPtx1082 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register141); // PTX L1082
	r_PtxRegister305 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1082 + 2097152ull);		  // PTX L1083
	r_LaneIndexAtPtx1085 = uint32_t((threadIdx.x & 31u));									  // PTX L1085
	r_PtxRegister541 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1085), uint32_t(31));		  // PTX L1087
	r_PtxRegister542 = ShiftRight(uint32_t(r_PtxRegister541), uint32_t(30));				  // PTX L1088
	r_PtxRegister543 = uint32_t(r_LaneIndexAtPtx1085) + uint32_t(r_PtxRegister542);			  // PTX L1089
	r_PtxRegister544 = r_PtxRegister543 & 2147483644;										  // PTX L1090
	r_PtxRegister545 = uint32_t(r_LaneIndexAtPtx1085) - uint32_t(r_PtxRegister544);			  // PTX L1091
	r_PtxRegister546 = ShiftLeft(uint32_t(r_PtxRegister545), uint32_t(1));					  // PTX L1092
	r_PtxRegister547 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister546);				  // PTX L1093
	r_PtxRegister548 = ShiftRightSigned(int32_t(r_PtxRegister547), uint32_t(1));			  // PTX L1094
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister548)) * int64_t(int32_t(4))); // PTX L1095
	g_RecordByteAddressAtPtx1096 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register143); // PTX L1096
	r_PtxRegister307 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1096 + 2097152ull);		  // PTX L1097
	r_LaneIndexAtPtx1099 = uint32_t((threadIdx.x & 31u));									  // PTX L1099
	r_PtxRegister549 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1099), uint32_t(31));		  // PTX L1101
	r_PtxRegister550 = ShiftRight(uint32_t(r_PtxRegister549), uint32_t(30));				  // PTX L1102
	r_PtxRegister551 = uint32_t(r_LaneIndexAtPtx1099) + uint32_t(r_PtxRegister550);			  // PTX L1103
	r_PtxRegister552 = r_PtxRegister551 & 2147483644;										  // PTX L1104
	r_PtxRegister553 = uint32_t(r_LaneIndexAtPtx1099) - uint32_t(r_PtxRegister552);			  // PTX L1105
	r_PtxRegister554 = ShiftLeft(uint32_t(r_PtxRegister553), uint32_t(1));					  // PTX L1106
	r_PtxRegister555 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister554);				  // PTX L1107
	r_PtxRegister556 = ShiftRightSigned(int32_t(r_PtxRegister555), uint32_t(1));			  // PTX L1108
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister556)) * int64_t(int32_t(4))); // PTX L1109
	g_RecordByteAddressAtPtx1110 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register145); // PTX L1110
	r_PtxRegister309 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1110 + 2097152ull);		  // PTX L1111
	r_LaneIndexAtPtx1113 = uint32_t((threadIdx.x & 31u));									  // PTX L1113
	r_PtxRegister557 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1113), uint32_t(31));		  // PTX L1115
	r_PtxRegister558 = ShiftRight(uint32_t(r_PtxRegister557), uint32_t(30));				  // PTX L1116
	r_PtxRegister559 = uint32_t(r_LaneIndexAtPtx1113) + uint32_t(r_PtxRegister558);			  // PTX L1117
	r_PtxRegister560 = r_PtxRegister559 & 2147483644;										  // PTX L1118
	r_PtxRegister561 = uint32_t(r_LaneIndexAtPtx1113) - uint32_t(r_PtxRegister560);			  // PTX L1119
	r_PtxRegister562 = ShiftLeft(uint32_t(r_PtxRegister561), uint32_t(1));					  // PTX L1120
	r_PtxRegister563 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister562);				  // PTX L1121
	r_PtxRegister564 = ShiftRightSigned(int32_t(r_PtxRegister563), uint32_t(1));			  // PTX L1122
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister564)) * int64_t(int32_t(4))); // PTX L1123
	g_RecordByteAddressAtPtx1124 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register147); // PTX L1124
	r_PtxRegister311 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1124 + 2097152ull);		  // PTX L1125
	r_LaneIndexAtPtx1127 = uint32_t((threadIdx.x & 31u));									  // PTX L1127
	r_PtxRegister565 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1127), uint32_t(31));		  // PTX L1129
	r_PtxRegister566 = ShiftRight(uint32_t(r_PtxRegister565), uint32_t(30));				  // PTX L1130
	r_PtxRegister567 = uint32_t(r_LaneIndexAtPtx1127) + uint32_t(r_PtxRegister566);			  // PTX L1131
	r_PtxRegister568 = r_PtxRegister567 & 2147483644;										  // PTX L1132
	r_PtxRegister569 = uint32_t(r_LaneIndexAtPtx1127) - uint32_t(r_PtxRegister568);			  // PTX L1133
	r_PtxRegister570 = ShiftLeft(uint32_t(r_PtxRegister569), uint32_t(1));					  // PTX L1134
	r_PtxRegister571 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister570);				  // PTX L1135
	r_PtxRegister572 = ShiftRightSigned(int32_t(r_PtxRegister571), uint32_t(1));			  // PTX L1136
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister572)) * int64_t(int32_t(4))); // PTX L1137
	g_RecordByteAddressAtPtx1138 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register149); // PTX L1138
	r_PtxRegister313 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1138 + 2097152ull);		  // PTX L1139
	r_LaneIndexAtPtx1141 = uint32_t((threadIdx.x & 31u));									  // PTX L1141
	r_PtxRegister573 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1141), uint32_t(31));		  // PTX L1143
	r_PtxRegister574 = ShiftRight(uint32_t(r_PtxRegister573), uint32_t(30));				  // PTX L1144
	r_PtxRegister575 = uint32_t(r_LaneIndexAtPtx1141) + uint32_t(r_PtxRegister574);			  // PTX L1145
	r_PtxRegister576 = r_PtxRegister575 & 2147483644;										  // PTX L1146
	r_PtxRegister577 = uint32_t(r_LaneIndexAtPtx1141) - uint32_t(r_PtxRegister576);			  // PTX L1147
	r_PtxRegister578 = ShiftLeft(uint32_t(r_PtxRegister577), uint32_t(1));					  // PTX L1148
	r_PtxRegister579 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister578);				  // PTX L1149
	r_PtxRegister580 = ShiftRightSigned(int32_t(r_PtxRegister579), uint32_t(1));			  // PTX L1150
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister580)) * int64_t(int32_t(4))); // PTX L1151
	g_RecordByteAddressAtPtx1152 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register151); // PTX L1152
	r_PtxRegister315 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1152 + 2097152ull);		  // PTX L1153
	r_LaneIndexAtPtx1155 = uint32_t((threadIdx.x & 31u));									  // PTX L1155
	r_PtxRegister581 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1155), uint32_t(31));		  // PTX L1157
	r_PtxRegister582 = ShiftRight(uint32_t(r_PtxRegister581), uint32_t(30));				  // PTX L1158
	r_PtxRegister583 = uint32_t(r_LaneIndexAtPtx1155) + uint32_t(r_PtxRegister582);			  // PTX L1159
	r_PtxRegister584 = r_PtxRegister583 & 2147483644;										  // PTX L1160
	r_PtxRegister585 = uint32_t(r_LaneIndexAtPtx1155) - uint32_t(r_PtxRegister584);			  // PTX L1161
	r_PtxRegister586 = ShiftLeft(uint32_t(r_PtxRegister585), uint32_t(1));					  // PTX L1162
	r_PtxRegister587 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister586);				  // PTX L1163
	r_PtxRegister588 = ShiftRightSigned(int32_t(r_PtxRegister587), uint32_t(1));			  // PTX L1164
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister588)) * int64_t(int32_t(4))); // PTX L1165
	g_RecordByteAddressAtPtx1166 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register153); // PTX L1166
	r_PtxRegister317 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1166 + 2097152ull);		  // PTX L1167
	r_LaneIndexAtPtx1169 = uint32_t((threadIdx.x & 31u));									  // PTX L1169
	r_PtxRegister589 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1169), uint32_t(31));		  // PTX L1171
	r_PtxRegister590 = ShiftRight(uint32_t(r_PtxRegister589), uint32_t(30));				  // PTX L1172
	r_PtxRegister591 = uint32_t(r_LaneIndexAtPtx1169) + uint32_t(r_PtxRegister590);			  // PTX L1173
	r_PtxRegister592 = r_PtxRegister591 & 2147483644;										  // PTX L1174
	r_PtxRegister593 = uint32_t(r_LaneIndexAtPtx1169) - uint32_t(r_PtxRegister592);			  // PTX L1175
	r_PtxRegister594 = ShiftLeft(uint32_t(r_PtxRegister593), uint32_t(1));					  // PTX L1176
	r_PtxRegister595 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister594);				  // PTX L1177
	r_PtxRegister596 = ShiftRightSigned(int32_t(r_PtxRegister595), uint32_t(1));			  // PTX L1178
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister596)) * int64_t(int32_t(4))); // PTX L1179
	g_RecordByteAddressAtPtx1180 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register155); // PTX L1180
	r_PtxRegister319 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1180 + 2097152ull);		  // PTX L1181
	r_LaneIndexAtPtx1183 = uint32_t((threadIdx.x & 31u));									  // PTX L1183
	r_PtxRegister597 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1183), uint32_t(31));		  // PTX L1185
	r_PtxRegister598 = ShiftRight(uint32_t(r_PtxRegister597), uint32_t(30));				  // PTX L1186
	r_PtxRegister599 = uint32_t(r_LaneIndexAtPtx1183) + uint32_t(r_PtxRegister598);			  // PTX L1187
	r_PtxRegister600 = r_PtxRegister599 & 2147483644;										  // PTX L1188
	r_PtxRegister601 = uint32_t(r_LaneIndexAtPtx1183) - uint32_t(r_PtxRegister600);			  // PTX L1189
	r_PtxRegister602 = ShiftLeft(uint32_t(r_PtxRegister601), uint32_t(1));					  // PTX L1190
	r_PtxRegister603 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister602);				  // PTX L1191
	r_PtxRegister604 = ShiftRightSigned(int32_t(r_PtxRegister603), uint32_t(1));			  // PTX L1192
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister604)) * int64_t(int32_t(4))); // PTX L1193
	g_RecordByteAddressAtPtx1194 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register157); // PTX L1194
	r_PtxRegister321 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1194 + 2097152ull);		  // PTX L1195
	r_LaneIndexAtPtx1197 = uint32_t((threadIdx.x & 31u));									  // PTX L1197
	r_PtxRegister605 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1197), uint32_t(31));		  // PTX L1199
	r_PtxRegister606 = ShiftRight(uint32_t(r_PtxRegister605), uint32_t(30));				  // PTX L1200
	r_PtxRegister607 = uint32_t(r_LaneIndexAtPtx1197) + uint32_t(r_PtxRegister606);			  // PTX L1201
	r_PtxRegister608 = r_PtxRegister607 & 2147483644;										  // PTX L1202
	r_PtxRegister609 = uint32_t(r_LaneIndexAtPtx1197) - uint32_t(r_PtxRegister608);			  // PTX L1203
	r_PtxRegister610 = ShiftLeft(uint32_t(r_PtxRegister609), uint32_t(1));					  // PTX L1204
	r_PtxRegister611 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister610);				  // PTX L1205
	r_PtxRegister612 = ShiftRightSigned(int32_t(r_PtxRegister611), uint32_t(1));			  // PTX L1206
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister612)) * int64_t(int32_t(4))); // PTX L1207
	g_RecordByteAddressAtPtx1208 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register159); // PTX L1208
	r_PtxRegister323 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1208 + 2097152ull);		  // PTX L1209
	r_LaneIndexAtPtx1211 = uint32_t((threadIdx.x & 31u));									  // PTX L1211
	r_PtxRegister613 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1211), uint32_t(31));		  // PTX L1213
	r_PtxRegister614 = ShiftRight(uint32_t(r_PtxRegister613), uint32_t(30));				  // PTX L1214
	r_PtxRegister615 = uint32_t(r_LaneIndexAtPtx1211) + uint32_t(r_PtxRegister614);			  // PTX L1215
	r_PtxRegister616 = r_PtxRegister615 & 2147483644;										  // PTX L1216
	r_PtxRegister617 = uint32_t(r_LaneIndexAtPtx1211) - uint32_t(r_PtxRegister616);			  // PTX L1217
	r_PtxRegister618 = ShiftLeft(uint32_t(r_PtxRegister617), uint32_t(1));					  // PTX L1218
	r_PtxRegister619 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister618);				  // PTX L1219
	r_PtxRegister620 = ShiftRightSigned(int32_t(r_PtxRegister619), uint32_t(1));			  // PTX L1220
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister620)) * int64_t(int32_t(4))); // PTX L1221
	g_RecordByteAddressAtPtx1222 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register161); // PTX L1222
	r_PtxRegister325 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1222 + 2097152ull);		  // PTX L1223
	r_LaneIndexAtPtx1225 = uint32_t((threadIdx.x & 31u));									  // PTX L1225
	r_PtxRegister621 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1225), uint32_t(31));		  // PTX L1227
	r_PtxRegister622 = ShiftRight(uint32_t(r_PtxRegister621), uint32_t(30));				  // PTX L1228
	r_PtxRegister623 = uint32_t(r_LaneIndexAtPtx1225) + uint32_t(r_PtxRegister622);			  // PTX L1229
	r_PtxRegister624 = r_PtxRegister623 & 2147483644;										  // PTX L1230
	r_PtxRegister625 = uint32_t(r_LaneIndexAtPtx1225) - uint32_t(r_PtxRegister624);			  // PTX L1231
	r_PtxRegister626 = ShiftLeft(uint32_t(r_PtxRegister625), uint32_t(1));					  // PTX L1232
	r_PtxRegister627 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister626);				  // PTX L1233
	r_PtxRegister628 = ShiftRightSigned(int32_t(r_PtxRegister627), uint32_t(1));			  // PTX L1234
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister628)) * int64_t(int32_t(4))); // PTX L1235
	g_RecordByteAddressAtPtx1236 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register163); // PTX L1236
	r_PtxRegister327 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1236 + 2097152ull);		  // PTX L1237
	r_LaneIndexAtPtx1239 = uint32_t((threadIdx.x & 31u));									  // PTX L1239
	r_PtxRegister629 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1239), uint32_t(31));		  // PTX L1241
	r_PtxRegister630 = ShiftRight(uint32_t(r_PtxRegister629), uint32_t(30));				  // PTX L1242
	r_PtxRegister631 = uint32_t(r_LaneIndexAtPtx1239) + uint32_t(r_PtxRegister630);			  // PTX L1243
	r_PtxRegister632 = r_PtxRegister631 & 2147483644;										  // PTX L1244
	r_PtxRegister633 = uint32_t(r_LaneIndexAtPtx1239) - uint32_t(r_PtxRegister632);			  // PTX L1245
	r_PtxRegister634 = ShiftLeft(uint32_t(r_PtxRegister633), uint32_t(1));					  // PTX L1246
	r_PtxRegister635 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister634);				  // PTX L1247
	r_PtxRegister636 = ShiftRightSigned(int32_t(r_PtxRegister635), uint32_t(1));			  // PTX L1248
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister636)) * int64_t(int32_t(4))); // PTX L1249
	g_RecordByteAddressAtPtx1250 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register165); // PTX L1250
	r_PtxRegister329 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1250 + 2097152ull);		  // PTX L1251
	r_LaneIndexAtPtx1253 = uint32_t((threadIdx.x & 31u));									  // PTX L1253
	r_PtxRegister637 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1253), uint32_t(31));		  // PTX L1255
	r_PtxRegister638 = ShiftRight(uint32_t(r_PtxRegister637), uint32_t(30));				  // PTX L1256
	r_PtxRegister639 = uint32_t(r_LaneIndexAtPtx1253) + uint32_t(r_PtxRegister638);			  // PTX L1257
	r_PtxRegister640 = r_PtxRegister639 & 2147483644;										  // PTX L1258
	r_PtxRegister641 = uint32_t(r_LaneIndexAtPtx1253) - uint32_t(r_PtxRegister640);			  // PTX L1259
	r_PtxRegister642 = ShiftLeft(uint32_t(r_PtxRegister641), uint32_t(1));					  // PTX L1260
	r_PtxRegister643 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister642);				  // PTX L1261
	r_PtxRegister644 = ShiftRightSigned(int32_t(r_PtxRegister643), uint32_t(1));			  // PTX L1262
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister644)) * int64_t(int32_t(4))); // PTX L1263
	g_RecordByteAddressAtPtx1264 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register167); // PTX L1264
	r_PtxRegister331 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1264 + 2097152ull);		  // PTX L1265
	r_LaneIndexAtPtx1267 = uint32_t((threadIdx.x & 31u));									  // PTX L1267
	r_PtxRegister645 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1267), uint32_t(31));		  // PTX L1269
	r_PtxRegister646 = ShiftRight(uint32_t(r_PtxRegister645), uint32_t(30));				  // PTX L1270
	r_PtxRegister647 = uint32_t(r_LaneIndexAtPtx1267) + uint32_t(r_PtxRegister646);			  // PTX L1271
	r_PtxRegister648 = r_PtxRegister647 & 2147483644;										  // PTX L1272
	r_PtxRegister649 = uint32_t(r_LaneIndexAtPtx1267) - uint32_t(r_PtxRegister648);			  // PTX L1273
	r_PtxRegister650 = ShiftLeft(uint32_t(r_PtxRegister649), uint32_t(1));					  // PTX L1274
	r_PtxRegister651 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister650);				  // PTX L1275
	r_PtxRegister652 = ShiftRightSigned(int32_t(r_PtxRegister651), uint32_t(1));			  // PTX L1276
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister652)) * int64_t(int32_t(4))); // PTX L1277
	g_RecordByteAddressAtPtx1278 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register169); // PTX L1278
	r_PtxRegister333 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1278 + 2097152ull);		  // PTX L1279
	r_LaneIndexAtPtx1281 = uint32_t((threadIdx.x & 31u));									  // PTX L1281
	r_PtxRegister653 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1281), uint32_t(31));		  // PTX L1283
	r_PtxRegister654 = ShiftRight(uint32_t(r_PtxRegister653), uint32_t(30));				  // PTX L1284
	r_PtxRegister655 = uint32_t(r_LaneIndexAtPtx1281) + uint32_t(r_PtxRegister654);			  // PTX L1285
	r_PtxRegister656 = r_PtxRegister655 & 2147483644;										  // PTX L1286
	r_PtxRegister657 = uint32_t(r_LaneIndexAtPtx1281) - uint32_t(r_PtxRegister656);			  // PTX L1287
	r_PtxRegister658 = ShiftLeft(uint32_t(r_PtxRegister657), uint32_t(1));					  // PTX L1288
	r_PtxRegister659 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister658);				  // PTX L1289
	r_PtxRegister660 = ShiftRightSigned(int32_t(r_PtxRegister659), uint32_t(1));			  // PTX L1290
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister660)) * int64_t(int32_t(4))); // PTX L1291
	g_RecordByteAddressAtPtx1292 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register171); // PTX L1292
	r_PtxRegister335 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1292 + 2097152ull);		  // PTX L1293
	r_LaneIndexAtPtx1295 = uint32_t((threadIdx.x & 31u));									  // PTX L1295
	r_PtxRegister661 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1295), uint32_t(31));		  // PTX L1297
	r_PtxRegister662 = ShiftRight(uint32_t(r_PtxRegister661), uint32_t(30));				  // PTX L1298
	r_PtxRegister663 = uint32_t(r_LaneIndexAtPtx1295) + uint32_t(r_PtxRegister662);			  // PTX L1299
	r_PtxRegister664 = r_PtxRegister663 & 2147483644;										  // PTX L1300
	r_PtxRegister665 = uint32_t(r_LaneIndexAtPtx1295) - uint32_t(r_PtxRegister664);			  // PTX L1301
	r_PtxRegister666 = ShiftLeft(uint32_t(r_PtxRegister665), uint32_t(1));					  // PTX L1302
	r_PtxRegister667 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister666);				  // PTX L1303
	r_PtxRegister668 = ShiftRightSigned(int32_t(r_PtxRegister667), uint32_t(1));			  // PTX L1304
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister668)) * int64_t(int32_t(4))); // PTX L1305
	g_RecordByteAddressAtPtx1306 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register173); // PTX L1306
	r_PtxRegister337 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1306 + 2097152ull);		  // PTX L1307
	r_LaneIndexAtPtx1309 = uint32_t((threadIdx.x & 31u));									  // PTX L1309
	r_PtxRegister669 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1309), uint32_t(31));		  // PTX L1311
	r_PtxRegister670 = ShiftRight(uint32_t(r_PtxRegister669), uint32_t(30));				  // PTX L1312
	r_PtxRegister671 = uint32_t(r_LaneIndexAtPtx1309) + uint32_t(r_PtxRegister670);			  // PTX L1313
	r_PtxRegister672 = r_PtxRegister671 & 2147483644;										  // PTX L1314
	r_PtxRegister673 = uint32_t(r_LaneIndexAtPtx1309) - uint32_t(r_PtxRegister672);			  // PTX L1315
	r_PtxRegister674 = ShiftLeft(uint32_t(r_PtxRegister673), uint32_t(1));					  // PTX L1316
	r_PtxRegister675 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister674);				  // PTX L1317
	r_PtxRegister676 = ShiftRightSigned(int32_t(r_PtxRegister675), uint32_t(1));			  // PTX L1318
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister676)) * int64_t(int32_t(4))); // PTX L1319
	g_RecordByteAddressAtPtx1320 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register175); // PTX L1320
	r_PtxRegister339 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1320 + 2097152ull);		  // PTX L1321
	r_LaneIndexAtPtx1323 = uint32_t((threadIdx.x & 31u));									  // PTX L1323
	r_PtxRegister677 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1323), uint32_t(31));		  // PTX L1325
	r_PtxRegister678 = ShiftRight(uint32_t(r_PtxRegister677), uint32_t(30));				  // PTX L1326
	r_PtxRegister679 = uint32_t(r_LaneIndexAtPtx1323) + uint32_t(r_PtxRegister678);			  // PTX L1327
	r_PtxRegister680 = r_PtxRegister679 & 2147483644;										  // PTX L1328
	r_PtxRegister681 = uint32_t(r_LaneIndexAtPtx1323) - uint32_t(r_PtxRegister680);			  // PTX L1329
	r_PtxRegister682 = ShiftLeft(uint32_t(r_PtxRegister681), uint32_t(1));					  // PTX L1330
	r_PtxRegister683 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister682);				  // PTX L1331
	r_PtxRegister684 = ShiftRightSigned(int32_t(r_PtxRegister683), uint32_t(1));			  // PTX L1332
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister684)) * int64_t(int32_t(4))); // PTX L1333
	g_RecordByteAddressAtPtx1334 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register177); // PTX L1334
	r_PtxRegister341 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1334 + 2097152ull);		  // PTX L1335
	r_LaneIndexAtPtx1337 = uint32_t((threadIdx.x & 31u));									  // PTX L1337
	r_PtxRegister685 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1337), uint32_t(31));		  // PTX L1339
	r_PtxRegister686 = ShiftRight(uint32_t(r_PtxRegister685), uint32_t(30));				  // PTX L1340
	r_PtxRegister687 = uint32_t(r_LaneIndexAtPtx1337) + uint32_t(r_PtxRegister686);			  // PTX L1341
	r_PtxRegister688 = r_PtxRegister687 & 2147483644;										  // PTX L1342
	r_PtxRegister689 = uint32_t(r_LaneIndexAtPtx1337) - uint32_t(r_PtxRegister688);			  // PTX L1343
	r_PtxRegister690 = ShiftLeft(uint32_t(r_PtxRegister689), uint32_t(1));					  // PTX L1344
	r_PtxRegister691 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister690);				  // PTX L1345
	r_PtxRegister692 = ShiftRightSigned(int32_t(r_PtxRegister691), uint32_t(1));			  // PTX L1346
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister692)) * int64_t(int32_t(4))); // PTX L1347
	g_RecordByteAddressAtPtx1348 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register179); // PTX L1348
	r_PtxRegister343 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1348 + 2097152ull);		  // PTX L1349
	r_LaneIndexAtPtx1351 = uint32_t((threadIdx.x & 31u));									  // PTX L1351
	r_PtxRegister693 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1351), uint32_t(31));		  // PTX L1353
	r_PtxRegister694 = ShiftRight(uint32_t(r_PtxRegister693), uint32_t(30));				  // PTX L1354
	r_PtxRegister695 = uint32_t(r_LaneIndexAtPtx1351) + uint32_t(r_PtxRegister694);			  // PTX L1355
	r_PtxRegister696 = r_PtxRegister695 & 2147483644;										  // PTX L1356
	r_PtxRegister697 = uint32_t(r_LaneIndexAtPtx1351) - uint32_t(r_PtxRegister696);			  // PTX L1357
	r_PtxRegister698 = ShiftLeft(uint32_t(r_PtxRegister697), uint32_t(1));					  // PTX L1358
	r_PtxRegister699 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister698);				  // PTX L1359
	r_PtxRegister700 = ShiftRightSigned(int32_t(r_PtxRegister699), uint32_t(1));			  // PTX L1360
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister700)) * int64_t(int32_t(4))); // PTX L1361
	g_RecordByteAddressAtPtx1362 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register181); // PTX L1362
	r_PtxRegister345 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1362 + 2097152ull);		  // PTX L1363
	r_LaneIndexAtPtx1365 = uint32_t((threadIdx.x & 31u));									  // PTX L1365
	r_PtxRegister701 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1365), uint32_t(31));		  // PTX L1367
	r_PtxRegister702 = ShiftRight(uint32_t(r_PtxRegister701), uint32_t(30));				  // PTX L1368
	r_PtxRegister703 = uint32_t(r_LaneIndexAtPtx1365) + uint32_t(r_PtxRegister702);			  // PTX L1369
	r_PtxRegister704 = r_PtxRegister703 & 2147483644;										  // PTX L1370
	r_PtxRegister705 = uint32_t(r_LaneIndexAtPtx1365) - uint32_t(r_PtxRegister704);			  // PTX L1371
	r_PtxRegister706 = ShiftLeft(uint32_t(r_PtxRegister705), uint32_t(1));					  // PTX L1372
	r_PtxRegister707 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister706);				  // PTX L1373
	r_PtxRegister708 = ShiftRightSigned(int32_t(r_PtxRegister707), uint32_t(1));			  // PTX L1374
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister708)) * int64_t(int32_t(4))); // PTX L1375
	g_RecordByteAddressAtPtx1376 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register183); // PTX L1376
	r_PtxRegister347 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1376 + 2097152ull);		  // PTX L1377
	r_LaneIndexAtPtx1379 = uint32_t((threadIdx.x & 31u));									  // PTX L1379
	r_PtxRegister709 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1379), uint32_t(31));		  // PTX L1381
	r_PtxRegister710 = ShiftRight(uint32_t(r_PtxRegister709), uint32_t(30));				  // PTX L1382
	r_PtxRegister711 = uint32_t(r_LaneIndexAtPtx1379) + uint32_t(r_PtxRegister710);			  // PTX L1383
	r_PtxRegister712 = r_PtxRegister711 & 2147483644;										  // PTX L1384
	r_PtxRegister713 = uint32_t(r_LaneIndexAtPtx1379) - uint32_t(r_PtxRegister712);			  // PTX L1385
	r_PtxRegister714 = ShiftLeft(uint32_t(r_PtxRegister713), uint32_t(1));					  // PTX L1386
	r_PtxRegister715 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister714);				  // PTX L1387
	r_PtxRegister716 = ShiftRightSigned(int32_t(r_PtxRegister715), uint32_t(1));			  // PTX L1388
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister716)) * int64_t(int32_t(4))); // PTX L1389
	g_RecordByteAddressAtPtx1390 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register185); // PTX L1390
	r_PtxRegister349 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1390 + 2097152ull);		  // PTX L1391
	r_LaneIndexAtPtx1393 = uint32_t((threadIdx.x & 31u));									  // PTX L1393
	r_PtxRegister717 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1393), uint32_t(31));		  // PTX L1395
	r_PtxRegister718 = ShiftRight(uint32_t(r_PtxRegister717), uint32_t(30));				  // PTX L1396
	r_PtxRegister719 = uint32_t(r_LaneIndexAtPtx1393) + uint32_t(r_PtxRegister718);			  // PTX L1397
	r_PtxRegister720 = r_PtxRegister719 & 2147483644;										  // PTX L1398
	r_PtxRegister721 = uint32_t(r_LaneIndexAtPtx1393) - uint32_t(r_PtxRegister720);			  // PTX L1399
	r_PtxRegister722 = ShiftLeft(uint32_t(r_PtxRegister721), uint32_t(1));					  // PTX L1400
	r_PtxRegister723 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister722);				  // PTX L1401
	r_PtxRegister724 = ShiftRightSigned(int32_t(r_PtxRegister723), uint32_t(1));			  // PTX L1402
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister724)) * int64_t(int32_t(4))); // PTX L1403
	g_RecordByteAddressAtPtx1404 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register187); // PTX L1404
	r_PtxRegister351 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1404 + 2097152ull);		  // PTX L1405
	r_LaneIndexAtPtx1407 = uint32_t((threadIdx.x & 31u));									  // PTX L1407
	r_PtxRegister725 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1407), uint32_t(31));		  // PTX L1409
	r_PtxRegister726 = ShiftRight(uint32_t(r_PtxRegister725), uint32_t(30));				  // PTX L1410
	r_PtxRegister727 = uint32_t(r_LaneIndexAtPtx1407) + uint32_t(r_PtxRegister726);			  // PTX L1411
	r_PtxRegister728 = r_PtxRegister727 & 2147483644;										  // PTX L1412
	r_PtxRegister729 = uint32_t(r_LaneIndexAtPtx1407) - uint32_t(r_PtxRegister728);			  // PTX L1413
	r_PtxRegister730 = ShiftLeft(uint32_t(r_PtxRegister729), uint32_t(1));					  // PTX L1414
	r_PtxRegister731 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister730);				  // PTX L1415
	r_PtxRegister732 = ShiftRightSigned(int32_t(r_PtxRegister731), uint32_t(1));			  // PTX L1416
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister732)) * int64_t(int32_t(4))); // PTX L1417
	g_RecordByteAddressAtPtx1418 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register189); // PTX L1418
	r_PtxRegister353 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1418 + 2097152ull);		  // PTX L1419
	r_LaneIndexAtPtx1421 = uint32_t((threadIdx.x & 31u));									  // PTX L1421
	r_PtxRegister733 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1421), uint32_t(31));		  // PTX L1423
	r_PtxRegister734 = ShiftRight(uint32_t(r_PtxRegister733), uint32_t(30));				  // PTX L1424
	r_PtxRegister735 = uint32_t(r_LaneIndexAtPtx1421) + uint32_t(r_PtxRegister734);			  // PTX L1425
	r_PtxRegister736 = r_PtxRegister735 & 2147483644;										  // PTX L1426
	r_PtxRegister737 = uint32_t(r_LaneIndexAtPtx1421) - uint32_t(r_PtxRegister736);			  // PTX L1427
	r_PtxRegister738 = ShiftLeft(uint32_t(r_PtxRegister737), uint32_t(1));					  // PTX L1428
	r_PtxRegister739 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister738);				  // PTX L1429
	r_PtxRegister740 = ShiftRightSigned(int32_t(r_PtxRegister739), uint32_t(1));			  // PTX L1430
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister740)) * int64_t(int32_t(4))); // PTX L1431
	g_RecordByteAddressAtPtx1432 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register191); // PTX L1432
	r_PtxRegister355 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1432 + 2097152ull);		  // PTX L1433
	r_LaneIndexAtPtx1435 = uint32_t((threadIdx.x & 31u));									  // PTX L1435
	r_PtxRegister741 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1435), uint32_t(31));		  // PTX L1437
	r_PtxRegister742 = ShiftRight(uint32_t(r_PtxRegister741), uint32_t(30));				  // PTX L1438
	r_PtxRegister743 = uint32_t(r_LaneIndexAtPtx1435) + uint32_t(r_PtxRegister742);			  // PTX L1439
	r_PtxRegister744 = r_PtxRegister743 & 2147483644;										  // PTX L1440
	r_PtxRegister745 = uint32_t(r_LaneIndexAtPtx1435) - uint32_t(r_PtxRegister744);			  // PTX L1441
	r_PtxRegister746 = ShiftLeft(uint32_t(r_PtxRegister745), uint32_t(1));					  // PTX L1442
	r_PtxRegister747 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister746);				  // PTX L1443
	r_PtxRegister748 = ShiftRightSigned(int32_t(r_PtxRegister747), uint32_t(1));			  // PTX L1444
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister748)) * int64_t(int32_t(4))); // PTX L1445
	g_RecordByteAddressAtPtx1446 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register193); // PTX L1446
	r_PtxRegister357 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1446 + 2097152ull);		  // PTX L1447
	r_LaneIndexAtPtx1449 = uint32_t((threadIdx.x & 31u));									  // PTX L1449
	r_PtxRegister749 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1449), uint32_t(31));		  // PTX L1451
	r_PtxRegister750 = ShiftRight(uint32_t(r_PtxRegister749), uint32_t(30));				  // PTX L1452
	r_PtxRegister751 = uint32_t(r_LaneIndexAtPtx1449) + uint32_t(r_PtxRegister750);			  // PTX L1453
	r_PtxRegister752 = r_PtxRegister751 & 2147483644;										  // PTX L1454
	r_PtxRegister753 = uint32_t(r_LaneIndexAtPtx1449) - uint32_t(r_PtxRegister752);			  // PTX L1455
	r_PtxRegister754 = ShiftLeft(uint32_t(r_PtxRegister753), uint32_t(1));					  // PTX L1456
	r_PtxRegister755 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister754);				  // PTX L1457
	r_PtxRegister756 = ShiftRightSigned(int32_t(r_PtxRegister755), uint32_t(1));			  // PTX L1458
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister756)) * int64_t(int32_t(4))); // PTX L1459
	g_RecordByteAddressAtPtx1460 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register195); // PTX L1460
	r_PtxRegister359 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1460 + 2097152ull);		  // PTX L1461
	r_LaneIndexAtPtx1463 = uint32_t((threadIdx.x & 31u));									  // PTX L1463
	r_PtxRegister757 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1463), uint32_t(31));		  // PTX L1465
	r_PtxRegister758 = ShiftRight(uint32_t(r_PtxRegister757), uint32_t(30));				  // PTX L1466
	r_PtxRegister759 = uint32_t(r_LaneIndexAtPtx1463) + uint32_t(r_PtxRegister758);			  // PTX L1467
	r_PtxRegister760 = r_PtxRegister759 & 2147483644;										  // PTX L1468
	r_PtxRegister761 = uint32_t(r_LaneIndexAtPtx1463) - uint32_t(r_PtxRegister760);			  // PTX L1469
	r_PtxRegister762 = ShiftLeft(uint32_t(r_PtxRegister761), uint32_t(1));					  // PTX L1470
	r_PtxRegister763 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister762);				  // PTX L1471
	r_PtxRegister764 = ShiftRightSigned(int32_t(r_PtxRegister763), uint32_t(1));			  // PTX L1472
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister764)) * int64_t(int32_t(4))); // PTX L1473
	g_RecordByteAddressAtPtx1474 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register197); // PTX L1474
	r_PtxRegister361 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1474 + 2097152ull);		  // PTX L1475
	r_LaneIndexAtPtx1477 = uint32_t((threadIdx.x & 31u));									  // PTX L1477
	r_PtxRegister765 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1477), uint32_t(31));		  // PTX L1479
	r_PtxRegister766 = ShiftRight(uint32_t(r_PtxRegister765), uint32_t(30));				  // PTX L1480
	r_PtxRegister767 = uint32_t(r_LaneIndexAtPtx1477) + uint32_t(r_PtxRegister766);			  // PTX L1481
	r_PtxRegister768 = r_PtxRegister767 & 2147483644;										  // PTX L1482
	r_PtxRegister769 = uint32_t(r_LaneIndexAtPtx1477) - uint32_t(r_PtxRegister768);			  // PTX L1483
	r_PtxRegister770 = ShiftLeft(uint32_t(r_PtxRegister769), uint32_t(1));					  // PTX L1484
	r_PtxRegister771 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister770);				  // PTX L1485
	r_PtxRegister772 = ShiftRightSigned(int32_t(r_PtxRegister771), uint32_t(1));			  // PTX L1486
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister772)) * int64_t(int32_t(4))); // PTX L1487
	g_RecordByteAddressAtPtx1488 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register199); // PTX L1488
	r_PtxRegister363 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1488 + 2097152ull);		  // PTX L1489
	r_LaneIndexAtPtx1491 = uint32_t((threadIdx.x & 31u));									  // PTX L1491
	r_PtxRegister773 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1491), uint32_t(31));		  // PTX L1493
	r_PtxRegister774 = ShiftRight(uint32_t(r_PtxRegister773), uint32_t(30));				  // PTX L1494
	r_PtxRegister775 = uint32_t(r_LaneIndexAtPtx1491) + uint32_t(r_PtxRegister774);			  // PTX L1495
	r_PtxRegister776 = r_PtxRegister775 & 2147483644;										  // PTX L1496
	r_PtxRegister777 = uint32_t(r_LaneIndexAtPtx1491) - uint32_t(r_PtxRegister776);			  // PTX L1497
	r_PtxRegister778 = ShiftLeft(uint32_t(r_PtxRegister777), uint32_t(1));					  // PTX L1498
	r_PtxRegister779 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister778);				  // PTX L1499
	r_PtxRegister780 = ShiftRightSigned(int32_t(r_PtxRegister779), uint32_t(1));			  // PTX L1500
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister780)) * int64_t(int32_t(4))); // PTX L1501
	g_RecordByteAddressAtPtx1502 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register201); // PTX L1502
	r_PtxRegister365 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1502 + 2097152ull);		  // PTX L1503
	r_LaneIndexAtPtx1505 = uint32_t((threadIdx.x & 31u));									  // PTX L1505
	r_PtxRegister781 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1505), uint32_t(31));		  // PTX L1507
	r_PtxRegister782 = ShiftRight(uint32_t(r_PtxRegister781), uint32_t(30));				  // PTX L1508
	r_PtxRegister783 = uint32_t(r_LaneIndexAtPtx1505) + uint32_t(r_PtxRegister782);			  // PTX L1509
	r_PtxRegister784 = r_PtxRegister783 & 2147483644;										  // PTX L1510
	r_PtxRegister785 = uint32_t(r_LaneIndexAtPtx1505) - uint32_t(r_PtxRegister784);			  // PTX L1511
	r_PtxRegister786 = ShiftLeft(uint32_t(r_PtxRegister785), uint32_t(1));					  // PTX L1512
	r_PtxRegister787 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister786);				  // PTX L1513
	r_PtxRegister788 = ShiftRightSigned(int32_t(r_PtxRegister787), uint32_t(1));			  // PTX L1514
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister788)) * int64_t(int32_t(4))); // PTX L1515
	g_RecordByteAddressAtPtx1516 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register203); // PTX L1516
	r_PtxRegister367 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1516 + 2097152ull);		  // PTX L1517
	r_LaneIndexAtPtx1519 = uint32_t((threadIdx.x & 31u));									  // PTX L1519
	r_PtxRegister789 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1519), uint32_t(31));		  // PTX L1521
	r_PtxRegister790 = ShiftRight(uint32_t(r_PtxRegister789), uint32_t(30));				  // PTX L1522
	r_PtxRegister791 = uint32_t(r_LaneIndexAtPtx1519) + uint32_t(r_PtxRegister790);			  // PTX L1523
	r_PtxRegister792 = r_PtxRegister791 & 2147483644;										  // PTX L1524
	r_PtxRegister793 = uint32_t(r_LaneIndexAtPtx1519) - uint32_t(r_PtxRegister792);			  // PTX L1525
	r_PtxRegister794 = ShiftLeft(uint32_t(r_PtxRegister793), uint32_t(1));					  // PTX L1526
	r_PtxRegister795 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister794);				  // PTX L1527
	r_PtxRegister796 = ShiftRightSigned(int32_t(r_PtxRegister795), uint32_t(1));			  // PTX L1528
	r_PtxU64Register205 = uint64_t(int64_t(int32_t(r_PtxRegister796)) * int64_t(int32_t(4))); // PTX L1529
	g_RecordByteAddressAtPtx1530 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register205); // PTX L1530
	r_PtxRegister369 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1530 + 2097152ull);		  // PTX L1531
	r_LaneIndexAtPtx1533 = uint32_t((threadIdx.x & 31u));									  // PTX L1533
	r_PtxRegister797 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1533), uint32_t(31));		  // PTX L1535
	r_PtxRegister798 = ShiftRight(uint32_t(r_PtxRegister797), uint32_t(30));				  // PTX L1536
	r_PtxRegister799 = uint32_t(r_LaneIndexAtPtx1533) + uint32_t(r_PtxRegister798);			  // PTX L1537
	r_PtxRegister800 = r_PtxRegister799 & 2147483644;										  // PTX L1538
	r_PtxRegister801 = uint32_t(r_LaneIndexAtPtx1533) - uint32_t(r_PtxRegister800);			  // PTX L1539
	r_PtxRegister802 = ShiftLeft(uint32_t(r_PtxRegister801), uint32_t(1));					  // PTX L1540
	r_PtxRegister803 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister802);				  // PTX L1541
	r_PtxRegister804 = ShiftRightSigned(int32_t(r_PtxRegister803), uint32_t(1));			  // PTX L1542
	r_PtxU64Register207 = uint64_t(int64_t(int32_t(r_PtxRegister804)) * int64_t(int32_t(4))); // PTX L1543
	g_RecordByteAddressAtPtx1544 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register207); // PTX L1544
	r_PtxRegister371 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1544 + 2097152ull);		  // PTX L1545
	r_LaneIndexAtPtx1547 = uint32_t((threadIdx.x & 31u));									  // PTX L1547
	r_PtxRegister805 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1547), uint32_t(31));		  // PTX L1549
	r_PtxRegister806 = ShiftRight(uint32_t(r_PtxRegister805), uint32_t(30));				  // PTX L1550
	r_PtxRegister807 = uint32_t(r_LaneIndexAtPtx1547) + uint32_t(r_PtxRegister806);			  // PTX L1551
	r_PtxRegister808 = r_PtxRegister807 & 2147483644;										  // PTX L1552
	r_PtxRegister809 = uint32_t(r_LaneIndexAtPtx1547) - uint32_t(r_PtxRegister808);			  // PTX L1553
	r_PtxRegister810 = ShiftLeft(uint32_t(r_PtxRegister809), uint32_t(1));					  // PTX L1554
	r_PtxRegister811 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister810);				  // PTX L1555
	r_PtxRegister812 = ShiftRightSigned(int32_t(r_PtxRegister811), uint32_t(1));			  // PTX L1556
	r_PtxU64Register209 = uint64_t(int64_t(int32_t(r_PtxRegister812)) * int64_t(int32_t(4))); // PTX L1557
	g_RecordByteAddressAtPtx1558 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register209); // PTX L1558
	r_PtxRegister373 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1558 + 2097152ull);		  // PTX L1559
	r_LaneIndexAtPtx1561 = uint32_t((threadIdx.x & 31u));									  // PTX L1561
	r_PtxRegister813 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1561), uint32_t(31));		  // PTX L1563
	r_PtxRegister814 = ShiftRight(uint32_t(r_PtxRegister813), uint32_t(30));				  // PTX L1564
	r_PtxRegister815 = uint32_t(r_LaneIndexAtPtx1561) + uint32_t(r_PtxRegister814);			  // PTX L1565
	r_PtxRegister816 = r_PtxRegister815 & 2147483644;										  // PTX L1566
	r_PtxRegister817 = uint32_t(r_LaneIndexAtPtx1561) - uint32_t(r_PtxRegister816);			  // PTX L1567
	r_PtxRegister818 = ShiftLeft(uint32_t(r_PtxRegister817), uint32_t(1));					  // PTX L1568
	r_PtxRegister819 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister818);				  // PTX L1569
	r_PtxRegister820 = ShiftRightSigned(int32_t(r_PtxRegister819), uint32_t(1));			  // PTX L1570
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister820)) * int64_t(int32_t(4))); // PTX L1571
	g_RecordByteAddressAtPtx1572 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register211); // PTX L1572
	r_PtxRegister375 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1572 + 2097152ull);		  // PTX L1573
	r_LaneIndexAtPtx1575 = uint32_t((threadIdx.x & 31u));									  // PTX L1575
	r_PtxRegister821 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1575), uint32_t(31));		  // PTX L1577
	r_PtxRegister822 = ShiftRight(uint32_t(r_PtxRegister821), uint32_t(30));				  // PTX L1578
	r_PtxRegister823 = uint32_t(r_LaneIndexAtPtx1575) + uint32_t(r_PtxRegister822);			  // PTX L1579
	r_PtxRegister824 = r_PtxRegister823 & 2147483644;										  // PTX L1580
	r_PtxRegister825 = uint32_t(r_LaneIndexAtPtx1575) - uint32_t(r_PtxRegister824);			  // PTX L1581
	r_PtxRegister826 = ShiftLeft(uint32_t(r_PtxRegister825), uint32_t(1));					  // PTX L1582
	r_PtxRegister827 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister826);				  // PTX L1583
	r_PtxRegister828 = ShiftRightSigned(int32_t(r_PtxRegister827), uint32_t(1));			  // PTX L1584
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister828)) * int64_t(int32_t(4))); // PTX L1585
	g_RecordByteAddressAtPtx1586 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register213); // PTX L1586
	r_PtxRegister377 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1586 + 2097152ull);		  // PTX L1587
	r_LaneIndexAtPtx1589 = uint32_t((threadIdx.x & 31u));									  // PTX L1589
	r_PtxRegister829 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1589), uint32_t(31));		  // PTX L1591
	r_PtxRegister830 = ShiftRight(uint32_t(r_PtxRegister829), uint32_t(30));				  // PTX L1592
	r_PtxRegister831 = uint32_t(r_LaneIndexAtPtx1589) + uint32_t(r_PtxRegister830);			  // PTX L1593
	r_PtxRegister832 = r_PtxRegister831 & 2147483644;										  // PTX L1594
	r_PtxRegister833 = uint32_t(r_LaneIndexAtPtx1589) - uint32_t(r_PtxRegister832);			  // PTX L1595
	r_PtxRegister834 = ShiftLeft(uint32_t(r_PtxRegister833), uint32_t(1));					  // PTX L1596
	r_PtxRegister835 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister834);				  // PTX L1597
	r_PtxRegister836 = ShiftRightSigned(int32_t(r_PtxRegister835), uint32_t(1));			  // PTX L1598
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister836)) * int64_t(int32_t(4))); // PTX L1599
	g_RecordByteAddressAtPtx1600 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register215); // PTX L1600
	r_PtxRegister379 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1600 + 2097152ull);		  // PTX L1601
	r_LaneIndexAtPtx1603 = uint32_t((threadIdx.x & 31u));									  // PTX L1603
	r_PtxRegister837 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1603), uint32_t(31));		  // PTX L1605
	r_PtxRegister838 = ShiftRight(uint32_t(r_PtxRegister837), uint32_t(30));				  // PTX L1606
	r_PtxRegister839 = uint32_t(r_LaneIndexAtPtx1603) + uint32_t(r_PtxRegister838);			  // PTX L1607
	r_PtxRegister840 = r_PtxRegister839 & 2147483644;										  // PTX L1608
	r_PtxRegister841 = uint32_t(r_LaneIndexAtPtx1603) - uint32_t(r_PtxRegister840);			  // PTX L1609
	r_PtxRegister842 = ShiftLeft(uint32_t(r_PtxRegister841), uint32_t(1));					  // PTX L1610
	r_PtxRegister843 = uint32_t(r_PtxRegister445) + uint32_t(r_PtxRegister842);				  // PTX L1611
	r_PtxRegister844 = ShiftRightSigned(int32_t(r_PtxRegister843), uint32_t(1));			  // PTX L1612
	r_PtxU64Register217 = uint64_t(int64_t(int32_t(r_PtxRegister844)) * int64_t(int32_t(4))); // PTX L1613
	g_RecordByteAddressAtPtx1614 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register217); // PTX L1614
	r_PtxRegister381 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1614 + 2097152ull);		  // PTX L1615
	r_LaneIndexAtPtx1617 = uint32_t((threadIdx.x & 31u));									  // PTX L1617
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1617), uint32_t(31));		  // PTX L1619
	r_PtxRegister846 = ShiftRight(uint32_t(r_PtxRegister845), uint32_t(30));				  // PTX L1620
	r_PtxRegister847 = uint32_t(r_LaneIndexAtPtx1617) + uint32_t(r_PtxRegister846);			  // PTX L1621
	r_PtxRegister848 = r_PtxRegister847 & 2147483644;										  // PTX L1622
	r_PtxRegister849 = uint32_t(r_LaneIndexAtPtx1617) - uint32_t(r_PtxRegister848);			  // PTX L1623
	r_PtxRegister850 = ShiftLeft(uint32_t(r_PtxRegister849), uint32_t(1));					  // PTX L1624
	r_PtxRegister851 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister850);				  // PTX L1625
	r_PtxRegister852 = ShiftRightSigned(int32_t(r_PtxRegister851), uint32_t(1));			  // PTX L1626
	r_PtxU64Register219 = uint64_t(int64_t(int32_t(r_PtxRegister852)) * int64_t(int32_t(4))); // PTX L1627
	g_RecordByteAddressAtPtx1628 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register219); // PTX L1628
	r_PtxRegister383 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1628 + 2097152ull);		  // PTX L1629
	r_LaneIndexAtPtx1631 = uint32_t((threadIdx.x & 31u));									  // PTX L1631
	r_PtxRegister853 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1631), uint32_t(31));		  // PTX L1633
	r_PtxRegister854 = ShiftRight(uint32_t(r_PtxRegister853), uint32_t(30));				  // PTX L1634
	r_PtxRegister855 = uint32_t(r_LaneIndexAtPtx1631) + uint32_t(r_PtxRegister854);			  // PTX L1635
	r_PtxRegister856 = r_PtxRegister855 & 2147483644;										  // PTX L1636
	r_PtxRegister857 = uint32_t(r_LaneIndexAtPtx1631) - uint32_t(r_PtxRegister856);			  // PTX L1637
	r_PtxRegister858 = ShiftLeft(uint32_t(r_PtxRegister857), uint32_t(1));					  // PTX L1638
	r_PtxRegister859 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister858);				  // PTX L1639
	r_PtxRegister860 = ShiftRightSigned(int32_t(r_PtxRegister859), uint32_t(1));			  // PTX L1640
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister860)) * int64_t(int32_t(4))); // PTX L1641
	g_RecordByteAddressAtPtx1642 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register221); // PTX L1642
	r_PtxRegister385 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1642 + 2097152ull);		  // PTX L1643
	r_LaneIndexAtPtx1645 = uint32_t((threadIdx.x & 31u));									  // PTX L1645
	r_PtxRegister861 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1645), uint32_t(31));		  // PTX L1647
	r_PtxRegister862 = ShiftRight(uint32_t(r_PtxRegister861), uint32_t(30));				  // PTX L1648
	r_PtxRegister863 = uint32_t(r_LaneIndexAtPtx1645) + uint32_t(r_PtxRegister862);			  // PTX L1649
	r_PtxRegister864 = r_PtxRegister863 & 2147483644;										  // PTX L1650
	r_PtxRegister865 = uint32_t(r_LaneIndexAtPtx1645) - uint32_t(r_PtxRegister864);			  // PTX L1651
	r_PtxRegister866 = ShiftLeft(uint32_t(r_PtxRegister865), uint32_t(1));					  // PTX L1652
	r_PtxRegister867 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister866);				  // PTX L1653
	r_PtxRegister868 = ShiftRightSigned(int32_t(r_PtxRegister867), uint32_t(1));			  // PTX L1654
	r_PtxU64Register223 = uint64_t(int64_t(int32_t(r_PtxRegister868)) * int64_t(int32_t(4))); // PTX L1655
	g_RecordByteAddressAtPtx1656 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register223); // PTX L1656
	r_PtxRegister387 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1656 + 2097152ull);		  // PTX L1657
	r_LaneIndexAtPtx1659 = uint32_t((threadIdx.x & 31u));									  // PTX L1659
	r_PtxRegister869 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1659), uint32_t(31));		  // PTX L1661
	r_PtxRegister870 = ShiftRight(uint32_t(r_PtxRegister869), uint32_t(30));				  // PTX L1662
	r_PtxRegister871 = uint32_t(r_LaneIndexAtPtx1659) + uint32_t(r_PtxRegister870);			  // PTX L1663
	r_PtxRegister872 = r_PtxRegister871 & 2147483644;										  // PTX L1664
	r_PtxRegister873 = uint32_t(r_LaneIndexAtPtx1659) - uint32_t(r_PtxRegister872);			  // PTX L1665
	r_PtxRegister874 = ShiftLeft(uint32_t(r_PtxRegister873), uint32_t(1));					  // PTX L1666
	r_PtxRegister875 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister874);				  // PTX L1667
	r_PtxRegister876 = ShiftRightSigned(int32_t(r_PtxRegister875), uint32_t(1));			  // PTX L1668
	r_PtxU64Register225 = uint64_t(int64_t(int32_t(r_PtxRegister876)) * int64_t(int32_t(4))); // PTX L1669
	g_RecordByteAddressAtPtx1670 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register225); // PTX L1670
	r_PtxRegister389 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1670 + 2097152ull);		  // PTX L1671
	r_LaneIndexAtPtx1673 = uint32_t((threadIdx.x & 31u));									  // PTX L1673
	r_PtxRegister877 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1673), uint32_t(31));		  // PTX L1675
	r_PtxRegister878 = ShiftRight(uint32_t(r_PtxRegister877), uint32_t(30));				  // PTX L1676
	r_PtxRegister879 = uint32_t(r_LaneIndexAtPtx1673) + uint32_t(r_PtxRegister878);			  // PTX L1677
	r_PtxRegister880 = r_PtxRegister879 & 2147483644;										  // PTX L1678
	r_PtxRegister881 = uint32_t(r_LaneIndexAtPtx1673) - uint32_t(r_PtxRegister880);			  // PTX L1679
	r_PtxRegister882 = ShiftLeft(uint32_t(r_PtxRegister881), uint32_t(1));					  // PTX L1680
	r_PtxRegister883 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister882);				  // PTX L1681
	r_PtxRegister884 = ShiftRightSigned(int32_t(r_PtxRegister883), uint32_t(1));			  // PTX L1682
	r_PtxU64Register227 = uint64_t(int64_t(int32_t(r_PtxRegister884)) * int64_t(int32_t(4))); // PTX L1683
	g_RecordByteAddressAtPtx1684 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register227); // PTX L1684
	r_PtxRegister391 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1684 + 2097152ull);		  // PTX L1685
	r_LaneIndexAtPtx1687 = uint32_t((threadIdx.x & 31u));									  // PTX L1687
	r_PtxRegister885 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1687), uint32_t(31));		  // PTX L1689
	r_PtxRegister886 = ShiftRight(uint32_t(r_PtxRegister885), uint32_t(30));				  // PTX L1690
	r_PtxRegister887 = uint32_t(r_LaneIndexAtPtx1687) + uint32_t(r_PtxRegister886);			  // PTX L1691
	r_PtxRegister888 = r_PtxRegister887 & 2147483644;										  // PTX L1692
	r_PtxRegister889 = uint32_t(r_LaneIndexAtPtx1687) - uint32_t(r_PtxRegister888);			  // PTX L1693
	r_PtxRegister890 = ShiftLeft(uint32_t(r_PtxRegister889), uint32_t(1));					  // PTX L1694
	r_PtxRegister891 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister890);				  // PTX L1695
	r_PtxRegister892 = ShiftRightSigned(int32_t(r_PtxRegister891), uint32_t(1));			  // PTX L1696
	r_PtxU64Register229 = uint64_t(int64_t(int32_t(r_PtxRegister892)) * int64_t(int32_t(4))); // PTX L1697
	g_RecordByteAddressAtPtx1698 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register229); // PTX L1698
	r_PtxRegister393 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1698 + 2097152ull);		  // PTX L1699
	r_LaneIndexAtPtx1701 = uint32_t((threadIdx.x & 31u));									  // PTX L1701
	r_PtxRegister893 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1701), uint32_t(31));		  // PTX L1703
	r_PtxRegister894 = ShiftRight(uint32_t(r_PtxRegister893), uint32_t(30));				  // PTX L1704
	r_PtxRegister895 = uint32_t(r_LaneIndexAtPtx1701) + uint32_t(r_PtxRegister894);			  // PTX L1705
	r_PtxRegister896 = r_PtxRegister895 & 2147483644;										  // PTX L1706
	r_PtxRegister897 = uint32_t(r_LaneIndexAtPtx1701) - uint32_t(r_PtxRegister896);			  // PTX L1707
	r_PtxRegister898 = ShiftLeft(uint32_t(r_PtxRegister897), uint32_t(1));					  // PTX L1708
	r_PtxRegister899 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister898);				  // PTX L1709
	r_PtxRegister900 = ShiftRightSigned(int32_t(r_PtxRegister899), uint32_t(1));			  // PTX L1710
	r_PtxU64Register231 = uint64_t(int64_t(int32_t(r_PtxRegister900)) * int64_t(int32_t(4))); // PTX L1711
	g_RecordByteAddressAtPtx1712 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register231); // PTX L1712
	r_PtxRegister395 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1712 + 2097152ull);		  // PTX L1713
	r_LaneIndexAtPtx1715 = uint32_t((threadIdx.x & 31u));									  // PTX L1715
	r_PtxRegister901 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1715), uint32_t(31));		  // PTX L1717
	r_PtxRegister902 = ShiftRight(uint32_t(r_PtxRegister901), uint32_t(30));				  // PTX L1718
	r_PtxRegister903 = uint32_t(r_LaneIndexAtPtx1715) + uint32_t(r_PtxRegister902);			  // PTX L1719
	r_PtxRegister904 = r_PtxRegister903 & 2147483644;										  // PTX L1720
	r_PtxRegister905 = uint32_t(r_LaneIndexAtPtx1715) - uint32_t(r_PtxRegister904);			  // PTX L1721
	r_PtxRegister906 = ShiftLeft(uint32_t(r_PtxRegister905), uint32_t(1));					  // PTX L1722
	r_PtxRegister907 = uint32_t(r_PtxRegister513) + uint32_t(r_PtxRegister906);				  // PTX L1723
	r_PtxRegister908 = ShiftRightSigned(int32_t(r_PtxRegister907), uint32_t(1));			  // PTX L1724
	r_PtxU64Register233 = uint64_t(int64_t(int32_t(r_PtxRegister908)) * int64_t(int32_t(4))); // PTX L1725
	g_RecordByteAddressAtPtx1726 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register233); // PTX L1726
	r_PtxRegister397 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1726 + 2097152ull);		  // PTX L1727
	r_LaneIndexAtPtx1729 = uint32_t((threadIdx.x & 31u));									  // PTX L1729
	r_PtxRegister909 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1729), uint32_t(31));		  // PTX L1731
	r_PtxRegister910 = ShiftRight(uint32_t(r_PtxRegister909), uint32_t(30));				  // PTX L1732
	r_PtxRegister911 = uint32_t(r_LaneIndexAtPtx1729) + uint32_t(r_PtxRegister910);			  // PTX L1733
	r_PtxRegister912 = r_PtxRegister911 & 2147483644;										  // PTX L1734
	r_PtxRegister913 = uint32_t(r_LaneIndexAtPtx1729) - uint32_t(r_PtxRegister912);			  // PTX L1735
	r_PtxRegister914 = ShiftLeft(uint32_t(r_PtxRegister913), uint32_t(1));					  // PTX L1736
	r_PtxRegister915 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister914);				  // PTX L1737
	r_PtxRegister916 = ShiftRightSigned(int32_t(r_PtxRegister915), uint32_t(1));			  // PTX L1738
	r_PtxU64Register235 = uint64_t(int64_t(int32_t(r_PtxRegister916)) * int64_t(int32_t(4))); // PTX L1739
	g_RecordByteAddressAtPtx1740 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register235); // PTX L1740
	r_PtxRegister399 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1740 + 2097152ull);		  // PTX L1741
	r_LaneIndexAtPtx1743 = uint32_t((threadIdx.x & 31u));									  // PTX L1743
	r_PtxRegister917 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1743), uint32_t(31));		  // PTX L1745
	r_PtxRegister918 = ShiftRight(uint32_t(r_PtxRegister917), uint32_t(30));				  // PTX L1746
	r_PtxRegister919 = uint32_t(r_LaneIndexAtPtx1743) + uint32_t(r_PtxRegister918);			  // PTX L1747
	r_PtxRegister920 = r_PtxRegister919 & 2147483644;										  // PTX L1748
	r_PtxRegister921 = uint32_t(r_LaneIndexAtPtx1743) - uint32_t(r_PtxRegister920);			  // PTX L1749
	r_PtxRegister922 = ShiftLeft(uint32_t(r_PtxRegister921), uint32_t(1));					  // PTX L1750
	r_PtxRegister923 = uint32_t(r_PtxRegister530) + uint32_t(r_PtxRegister922);				  // PTX L1751
	r_PtxRegister924 = ShiftRightSigned(int32_t(r_PtxRegister923), uint32_t(1));			  // PTX L1752
	r_PtxU64Register237 = uint64_t(int64_t(int32_t(r_PtxRegister924)) * int64_t(int32_t(4))); // PTX L1753
	g_RecordByteAddressAtPtx1754 =
		uint64_t(g_RecordByteAddressAtPtx848) + uint64_t(r_PtxU64Register237); // PTX L1754
	r_PtxRegister401 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1754 + 2097152ull);	// PTX L1755
	r_LaneIndexAtPtx1757 = uint32_t((threadIdx.x & 31u));								// PTX L1757
	r_PackedHalf2AtPtx456R1740 = HalfMul(r_PackedHalf2AtPtx466R1598, r_PtxRegister275); // PTX L1760
	r_LaneIndexAtPtx1764 = uint32_t((threadIdx.x & 31u));								// PTX L1764
	r_PackedHalf2AtPtx455R1739 = HalfMul(r_PackedHalf2AtPtx467R1599, r_PtxRegister277); // PTX L1767
	r_LaneIndexAtPtx1771 = uint32_t((threadIdx.x & 31u));								// PTX L1771
	r_PackedHalf2AtPtx454R1738 = HalfMul(r_PackedHalf2AtPtx468R1600, r_PtxRegister279); // PTX L1774
	r_LaneIndexAtPtx1778 = uint32_t((threadIdx.x & 31u));								// PTX L1778
	r_PackedHalf2AtPtx453R1737 = HalfMul(r_PackedHalf2AtPtx469R1601, r_PtxRegister281); // PTX L1781
	r_LaneIndexAtPtx1785 = uint32_t((threadIdx.x & 31u));								// PTX L1785
	r_PackedHalf2AtPtx452R1736 = HalfMul(r_PackedHalf2AtPtx490R1603, r_PtxRegister283); // PTX L1788
	r_LaneIndexAtPtx1792 = uint32_t((threadIdx.x & 31u));								// PTX L1792
	r_PackedHalf2AtPtx451R1735 = HalfMul(r_PackedHalf2AtPtx491R1604, r_PtxRegister285); // PTX L1795
	r_LaneIndexAtPtx1799 = uint32_t((threadIdx.x & 31u));								// PTX L1799
	r_PackedHalf2AtPtx450R1734 = HalfMul(r_PackedHalf2AtPtx492R1605, r_PtxRegister287); // PTX L1802
	r_LaneIndexAtPtx1806 = uint32_t((threadIdx.x & 31u));								// PTX L1806
	r_PackedHalf2AtPtx449R1733 = HalfMul(r_PackedHalf2AtPtx493R1606, r_PtxRegister289); // PTX L1809
	r_LaneIndexAtPtx1813 = uint32_t((threadIdx.x & 31u));								// PTX L1813
	r_PackedHalf2AtPtx448R1732 = HalfMul(r_PackedHalf2AtPtx514R1608, r_PtxRegister291); // PTX L1816
	r_LaneIndexAtPtx1820 = uint32_t((threadIdx.x & 31u));								// PTX L1820
	r_PackedHalf2AtPtx447R1731 = HalfMul(r_PackedHalf2AtPtx515R1609, r_PtxRegister293); // PTX L1823
	r_LaneIndexAtPtx1827 = uint32_t((threadIdx.x & 31u));								// PTX L1827
	r_PackedHalf2AtPtx446R1730 = HalfMul(r_PackedHalf2AtPtx516R1610, r_PtxRegister295); // PTX L1830
	r_LaneIndexAtPtx1834 = uint32_t((threadIdx.x & 31u));								// PTX L1834
	r_PackedHalf2AtPtx445R1729 = HalfMul(r_PackedHalf2AtPtx517R1611, r_PtxRegister297); // PTX L1837
	r_LaneIndexAtPtx1841 = uint32_t((threadIdx.x & 31u));								// PTX L1841
	r_PackedHalf2AtPtx444R1728 = HalfMul(r_PackedHalf2AtPtx538R1613, r_PtxRegister299); // PTX L1844
	r_LaneIndexAtPtx1848 = uint32_t((threadIdx.x & 31u));								// PTX L1848
	r_PackedHalf2AtPtx443R1727 = HalfMul(r_PackedHalf2AtPtx539R1614, r_PtxRegister301); // PTX L1851
	r_LaneIndexAtPtx1855 = uint32_t((threadIdx.x & 31u));								// PTX L1855
	r_PackedHalf2AtPtx442R1726 = HalfMul(r_PackedHalf2AtPtx540R1615, r_PtxRegister303); // PTX L1858
	r_LaneIndexAtPtx1862 = uint32_t((threadIdx.x & 31u));								// PTX L1862
	r_PackedHalf2AtPtx441R1725 = HalfMul(r_PackedHalf2AtPtx541R1616, r_PtxRegister305); // PTX L1865
	r_LaneIndexAtPtx1869 = uint32_t((threadIdx.x & 31u));								// PTX L1869
	r_PackedHalf2AtPtx440R1724 = HalfMul(r_PackedHalf2AtPtx563R1618, r_PtxRegister307); // PTX L1872
	r_LaneIndexAtPtx1876 = uint32_t((threadIdx.x & 31u));								// PTX L1876
	r_PackedHalf2AtPtx439R1723 = HalfMul(r_PackedHalf2AtPtx564R1619, r_PtxRegister309); // PTX L1879
	r_LaneIndexAtPtx1883 = uint32_t((threadIdx.x & 31u));								// PTX L1883
	r_PackedHalf2AtPtx438R1722 = HalfMul(r_PackedHalf2AtPtx565R1620, r_PtxRegister311); // PTX L1886
	r_LaneIndexAtPtx1890 = uint32_t((threadIdx.x & 31u));								// PTX L1890
	r_PackedHalf2AtPtx437R1721 = HalfMul(r_PackedHalf2AtPtx566R1621, r_PtxRegister313); // PTX L1893
	r_LaneIndexAtPtx1897 = uint32_t((threadIdx.x & 31u));								// PTX L1897
	r_PackedHalf2AtPtx436R1720 = HalfMul(r_PackedHalf2AtPtx587R1623, r_PtxRegister315); // PTX L1900
	r_LaneIndexAtPtx1904 = uint32_t((threadIdx.x & 31u));								// PTX L1904
	r_PackedHalf2AtPtx435R1719 = HalfMul(r_PackedHalf2AtPtx588R1624, r_PtxRegister317); // PTX L1907
	r_LaneIndexAtPtx1911 = uint32_t((threadIdx.x & 31u));								// PTX L1911
	r_PackedHalf2AtPtx434R1718 = HalfMul(r_PackedHalf2AtPtx589R1625, r_PtxRegister319); // PTX L1914
	r_LaneIndexAtPtx1918 = uint32_t((threadIdx.x & 31u));								// PTX L1918
	r_PackedHalf2AtPtx433R1717 = HalfMul(r_PackedHalf2AtPtx590R1626, r_PtxRegister321); // PTX L1921
	r_LaneIndexAtPtx1925 = uint32_t((threadIdx.x & 31u));								// PTX L1925
	r_PackedHalf2AtPtx432R1716 = HalfMul(r_PackedHalf2AtPtx611R1628, r_PtxRegister323); // PTX L1928
	r_LaneIndexAtPtx1932 = uint32_t((threadIdx.x & 31u));								// PTX L1932
	r_PackedHalf2AtPtx431R1715 = HalfMul(r_PackedHalf2AtPtx612R1629, r_PtxRegister325); // PTX L1935
	r_LaneIndexAtPtx1939 = uint32_t((threadIdx.x & 31u));								// PTX L1939
	r_PackedHalf2AtPtx430R1714 = HalfMul(r_PackedHalf2AtPtx613R1630, r_PtxRegister327); // PTX L1942
	r_LaneIndexAtPtx1946 = uint32_t((threadIdx.x & 31u));								// PTX L1946
	r_PackedHalf2AtPtx429R1713 = HalfMul(r_PackedHalf2AtPtx614R1631, r_PtxRegister329); // PTX L1949
	r_LaneIndexAtPtx1953 = uint32_t((threadIdx.x & 31u));								// PTX L1953
	r_PackedHalf2AtPtx428R1712 = HalfMul(r_PackedHalf2AtPtx635R1633, r_PtxRegister331); // PTX L1956
	r_LaneIndexAtPtx1960 = uint32_t((threadIdx.x & 31u));								// PTX L1960
	r_PackedHalf2AtPtx427R1711 = HalfMul(r_PackedHalf2AtPtx636R1634, r_PtxRegister333); // PTX L1963
	r_LaneIndexAtPtx1967 = uint32_t((threadIdx.x & 31u));								// PTX L1967
	r_PackedHalf2AtPtx426R1710 = HalfMul(r_PackedHalf2AtPtx637R1635, r_PtxRegister335); // PTX L1970
	r_LaneIndexAtPtx1974 = uint32_t((threadIdx.x & 31u));								// PTX L1974
	r_PackedHalf2AtPtx425R1709 = HalfMul(r_PackedHalf2AtPtx638R1636, r_PtxRegister337); // PTX L1977
	r_LaneIndexAtPtx1981 = uint32_t((threadIdx.x & 31u));								// PTX L1981
	r_PackedHalf2AtPtx424R1708 = HalfMul(r_PackedHalf2AtPtx660R1638, r_PtxRegister339); // PTX L1984
	r_LaneIndexAtPtx1988 = uint32_t((threadIdx.x & 31u));								// PTX L1988
	r_PackedHalf2AtPtx423R1707 = HalfMul(r_PackedHalf2AtPtx661R1639, r_PtxRegister341); // PTX L1991
	r_LaneIndexAtPtx1995 = uint32_t((threadIdx.x & 31u));								// PTX L1995
	r_PackedHalf2AtPtx422R1706 = HalfMul(r_PackedHalf2AtPtx662R1640, r_PtxRegister343); // PTX L1998
	r_LaneIndexAtPtx2002 = uint32_t((threadIdx.x & 31u));								// PTX L2002
	r_PackedHalf2AtPtx421R1705 = HalfMul(r_PackedHalf2AtPtx663R1641, r_PtxRegister345); // PTX L2005
	r_LaneIndexAtPtx2009 = uint32_t((threadIdx.x & 31u));								// PTX L2009
	r_PackedHalf2AtPtx420R1704 = HalfMul(r_PackedHalf2AtPtx684R1643, r_PtxRegister347); // PTX L2012
	r_LaneIndexAtPtx2016 = uint32_t((threadIdx.x & 31u));								// PTX L2016
	r_PackedHalf2AtPtx419R1703 = HalfMul(r_PackedHalf2AtPtx685R1644, r_PtxRegister349); // PTX L2019
	r_LaneIndexAtPtx2023 = uint32_t((threadIdx.x & 31u));								// PTX L2023
	r_PackedHalf2AtPtx418R1702 = HalfMul(r_PackedHalf2AtPtx686R1645, r_PtxRegister351); // PTX L2026
	r_LaneIndexAtPtx2030 = uint32_t((threadIdx.x & 31u));								// PTX L2030
	r_PackedHalf2AtPtx417R1701 = HalfMul(r_PackedHalf2AtPtx687R1646, r_PtxRegister353); // PTX L2033
	r_LaneIndexAtPtx2037 = uint32_t((threadIdx.x & 31u));								// PTX L2037
	r_PackedHalf2AtPtx416R1700 = HalfMul(r_PackedHalf2AtPtx708R1648, r_PtxRegister355); // PTX L2040
	r_LaneIndexAtPtx2044 = uint32_t((threadIdx.x & 31u));								// PTX L2044
	r_PackedHalf2AtPtx415R1699 = HalfMul(r_PackedHalf2AtPtx709R1649, r_PtxRegister357); // PTX L2047
	r_LaneIndexAtPtx2051 = uint32_t((threadIdx.x & 31u));								// PTX L2051
	r_PackedHalf2AtPtx414R1698 = HalfMul(r_PackedHalf2AtPtx710R1650, r_PtxRegister359); // PTX L2054
	r_LaneIndexAtPtx2058 = uint32_t((threadIdx.x & 31u));								// PTX L2058
	r_PackedHalf2AtPtx413R1697 = HalfMul(r_PackedHalf2AtPtx711R1651, r_PtxRegister361); // PTX L2061
	r_LaneIndexAtPtx2065 = uint32_t((threadIdx.x & 31u));								// PTX L2065
	r_PackedHalf2AtPtx412R1696 = HalfMul(r_PackedHalf2AtPtx732R1653, r_PtxRegister363); // PTX L2068
	r_LaneIndexAtPtx2072 = uint32_t((threadIdx.x & 31u));								// PTX L2072
	r_PackedHalf2AtPtx411R1695 = HalfMul(r_PackedHalf2AtPtx733R1654, r_PtxRegister365); // PTX L2075
	r_LaneIndexAtPtx2079 = uint32_t((threadIdx.x & 31u));								// PTX L2079
	r_PackedHalf2AtPtx410R1694 = HalfMul(r_PackedHalf2AtPtx734R1655, r_PtxRegister367); // PTX L2082
	r_LaneIndexAtPtx2086 = uint32_t((threadIdx.x & 31u));								// PTX L2086
	r_PackedHalf2AtPtx409R1693 = HalfMul(r_PackedHalf2AtPtx735R1656, r_PtxRegister369); // PTX L2089
	r_LaneIndexAtPtx2093 = uint32_t((threadIdx.x & 31u));								// PTX L2093
	r_PackedHalf2AtPtx408R1692 = HalfMul(r_PackedHalf2AtPtx757R1658, r_PtxRegister371); // PTX L2096
	r_LaneIndexAtPtx2100 = uint32_t((threadIdx.x & 31u));								// PTX L2100
	r_PackedHalf2AtPtx407R1691 = HalfMul(r_PackedHalf2AtPtx758R1659, r_PtxRegister373); // PTX L2103
	r_LaneIndexAtPtx2107 = uint32_t((threadIdx.x & 31u));								// PTX L2107
	r_PackedHalf2AtPtx406R1690 = HalfMul(r_PackedHalf2AtPtx759R1660, r_PtxRegister375); // PTX L2110
	r_LaneIndexAtPtx2114 = uint32_t((threadIdx.x & 31u));								// PTX L2114
	r_PackedHalf2AtPtx405R1689 = HalfMul(r_PackedHalf2AtPtx760R1661, r_PtxRegister377); // PTX L2117
	r_LaneIndexAtPtx2121 = uint32_t((threadIdx.x & 31u));								// PTX L2121
	r_PackedHalf2AtPtx404R1688 = HalfMul(r_PackedHalf2AtPtx781R1663, r_PtxRegister379); // PTX L2124
	r_LaneIndexAtPtx2128 = uint32_t((threadIdx.x & 31u));								// PTX L2128
	r_PackedHalf2AtPtx403R1687 = HalfMul(r_PackedHalf2AtPtx782R1664, r_PtxRegister381); // PTX L2131
	r_LaneIndexAtPtx2135 = uint32_t((threadIdx.x & 31u));								// PTX L2135
	r_PackedHalf2AtPtx402R1686 = HalfMul(r_PackedHalf2AtPtx783R1665, r_PtxRegister383); // PTX L2138
	r_LaneIndexAtPtx2142 = uint32_t((threadIdx.x & 31u));								// PTX L2142
	r_PackedHalf2AtPtx401R1685 = HalfMul(r_PackedHalf2AtPtx784R1666, r_PtxRegister385); // PTX L2145
	r_LaneIndexAtPtx2149 = uint32_t((threadIdx.x & 31u));								// PTX L2149
	r_PackedHalf2AtPtx400R1684 = HalfMul(r_PackedHalf2AtPtx805R1668, r_PtxRegister387); // PTX L2152
	r_LaneIndexAtPtx2156 = uint32_t((threadIdx.x & 31u));								// PTX L2156
	r_PackedHalf2AtPtx399R1683 = HalfMul(r_PackedHalf2AtPtx806R1669, r_PtxRegister389); // PTX L2159
	r_LaneIndexAtPtx2163 = uint32_t((threadIdx.x & 31u));								// PTX L2163
	r_PackedHalf2AtPtx398R1682 = HalfMul(r_PackedHalf2AtPtx807R1670, r_PtxRegister391); // PTX L2166
	r_LaneIndexAtPtx2170 = uint32_t((threadIdx.x & 31u));								// PTX L2170
	r_PackedHalf2AtPtx397R1681 = HalfMul(r_PackedHalf2AtPtx808R1671, r_PtxRegister393); // PTX L2173
	r_LaneIndexAtPtx2177 = uint32_t((threadIdx.x & 31u));								// PTX L2177
	r_PackedHalf2AtPtx396R1680 = HalfMul(r_PackedHalf2AtPtx829R1673, r_PtxRegister395); // PTX L2180
	r_LaneIndexAtPtx2184 = uint32_t((threadIdx.x & 31u));								// PTX L2184
	r_PackedHalf2AtPtx395R1679 = HalfMul(r_PackedHalf2AtPtx830R1674, r_PtxRegister397); // PTX L2187
	r_LaneIndexAtPtx2191 = uint32_t((threadIdx.x & 31u));								// PTX L2191
	r_PackedHalf2AtPtx394R1678 = HalfMul(r_PackedHalf2AtPtx831R1675, r_PtxRegister399); // PTX L2194
	r_LaneIndexAtPtx2198 = uint32_t((threadIdx.x & 31u));								// PTX L2198
	r_PackedHalf2AtPtx393R1677 = HalfMul(r_PackedHalf2AtPtx832R1676, r_PtxRegister401); // PTX L2201
L__BB56_86:																				// PTX L2204
	r_PtxRegister24 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits) + uint32_t(14);	// PTX L2205
	r_bPtxPredicate60 = uint32_t(r_PtxRegister24) < uint32_t(31);						// PTX L2206
	r_PtxRegister925 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));						// PTX L2207
	r_PtxRegister25 = r_PtxRegister925 & 2044;											// PTX L2208
	r_PtxRegister926 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(11));					// PTX L2209
	r_PtxRegister26 = r_PtxRegister926 & 2093056;										// PTX L2210
	r_PtxRegister927 = ShiftLeft(uint32_t(r_PtxRegister87), uint32_t(13));				// PTX L2211
	r_PtxRegister27 = r_bPtxPredicate60 ? 0 : r_PtxRegister927;							// PTX L2212
	r_PtxRegister928 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(13));				// PTX L2213
	r_PtxRegister28 = r_bPtxPredicate60 ? 0 : r_PtxRegister928;							// PTX L2214
	r_PtxRegister929 = ShiftLeft(uint32_t(r_PtxRegister122), uint32_t(13));				// PTX L2215
	r_PtxRegister29 = r_bPtxPredicate60 ? 0 : r_PtxRegister929;							// PTX L2216
	r_PtxRegister930 = ShiftLeft(uint32_t(r_PtxRegister140), uint32_t(13));				// PTX L2217
	r_PtxRegister30 = r_bPtxPredicate60 ? 0 : r_PtxRegister930;							// PTX L2218
	r_PtxRegister31 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(8));							// PTX L2219
	r_PtxRegister1741 = uint32_t(0);													// PTX L2220
L__BB56_87:																				// PTX L2221
	r_PtxRegister1043 = ShiftRight(uint32_t(r_PtxRegister1741), uint32_t(5));			// PTX L2222
	r_PtxRegister1044 = ~uint32_t(r_PtxRegister1043);									// PTX L2223
	r_PtxRegister32 = uint32_t(r_PtxRegister1741) + uint32_t(32);						// PTX L2224
	r_PtxRegister33 = r_PtxRegister1044 & 1;											// PTX L2225
	r_PtxRegister1045 = ShiftLeft(uint32_t(r_PtxRegister1741), uint32_t(8));			// PTX L2226
	r_PtxRegister1046 = r_PtxRegister1045 & 8192;										// PTX L2227
	r_LaneIndexAtPtx2229 = uint32_t((threadIdx.x & 31u));								// PTX L2229
	r_PtxRegister1047 = uint32_t(r_PtxRegister1046) + uint32_t(r_PtxRegister26);		// PTX L2231
	r_PtxRegister1048 = uint32_t(0u /* original named shared base */);					// PTX L2232
	r_PtxRegister1049 = uint32_t(r_PtxRegister1048) + uint32_t(r_PtxRegister1047);		// PTX L2233
	r_PtxRegister1050 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2229), uint32_t(4));			// PTX L2234
	r_PtxRegister932 = uint32_t(r_PtxRegister1049) + uint32_t(r_PtxRegister1050);		// PTX L2235
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister932));
		r_MmaAHalf2WordAtPtx2237R947 = r_Value.x;
		r_MmaAHalf2WordAtPtx2237R948 = r_Value.y;
		r_MmaAHalf2WordAtPtx2237R949 = r_Value.z;
		r_MmaAHalf2WordAtPtx2237R950 = r_Value.w;
	} // PTX L2237
	r_LaneIndexAtPtx2240 = uint32_t((threadIdx.x & 31u));						   // PTX L2240
	r_PtxRegister1051 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2240), uint32_t(4));	   // PTX L2242
	r_PtxRegister1052 = uint32_t(r_PtxRegister1049) + uint32_t(r_PtxRegister1051); // PTX L2243
	r_PtxRegister934 = uint32_t(r_PtxRegister1052) + uint32_t(512);				   // PTX L2244
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister934));
		r_MmaAHalf2WordAtPtx2246R951 = r_Value.x;
		r_MmaAHalf2WordAtPtx2246R952 = r_Value.y;
		r_MmaAHalf2WordAtPtx2246R953 = r_Value.z;
		r_MmaAHalf2WordAtPtx2246R954 = r_Value.w;
	} // PTX L2246
	r_LaneIndexAtPtx2249 = uint32_t((threadIdx.x & 31u));						  // PTX L2249
	r_PtxRegister1053 = uint32_t(r_PtxRegister1049) + uint32_t(1024);			  // PTX L2251
	r_PtxRegister1054 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2249), uint32_t(4));	  // PTX L2252
	r_PtxRegister936 = uint32_t(r_PtxRegister1053) + uint32_t(r_PtxRegister1054); // PTX L2253
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister936));
		r_MmaAHalf2WordAtPtx2255R971 = r_Value.x;
		r_MmaAHalf2WordAtPtx2255R972 = r_Value.y;
		r_MmaAHalf2WordAtPtx2255R973 = r_Value.z;
		r_MmaAHalf2WordAtPtx2255R974 = r_Value.w;
	} // PTX L2255
	r_LaneIndexAtPtx2258 = uint32_t((threadIdx.x & 31u));						   // PTX L2258
	r_PtxRegister1055 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2258), uint32_t(4));	   // PTX L2260
	r_PtxRegister1056 = uint32_t(r_PtxRegister1053) + uint32_t(r_PtxRegister1055); // PTX L2261
	r_PtxRegister938 = uint32_t(r_PtxRegister1056) + uint32_t(512);				   // PTX L2262
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister938));
		r_MmaAHalf2WordAtPtx2264R975 = r_Value.x;
		r_MmaAHalf2WordAtPtx2264R976 = r_Value.y;
		r_MmaAHalf2WordAtPtx2264R977 = r_Value.z;
		r_MmaAHalf2WordAtPtx2264R978 = r_Value.w;
	} // PTX L2264
	r_LaneIndexAtPtx2267 = uint32_t((threadIdx.x & 31u));						  // PTX L2267
	r_PtxRegister1057 = uint32_t(r_PtxRegister1049) + uint32_t(2048);			  // PTX L2269
	r_PtxRegister1058 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2267), uint32_t(4));	  // PTX L2270
	r_PtxRegister940 = uint32_t(r_PtxRegister1057) + uint32_t(r_PtxRegister1058); // PTX L2271
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister940));
		r_MmaAHalf2WordAtPtx2273R995 = r_Value.x;
		r_MmaAHalf2WordAtPtx2273R996 = r_Value.y;
		r_MmaAHalf2WordAtPtx2273R997 = r_Value.z;
		r_MmaAHalf2WordAtPtx2273R998 = r_Value.w;
	} // PTX L2273
	r_LaneIndexAtPtx2276 = uint32_t((threadIdx.x & 31u));						   // PTX L2276
	r_PtxRegister1059 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2276), uint32_t(4));	   // PTX L2278
	r_PtxRegister1060 = uint32_t(r_PtxRegister1057) + uint32_t(r_PtxRegister1059); // PTX L2279
	r_PtxRegister942 = uint32_t(r_PtxRegister1060) + uint32_t(512);				   // PTX L2280
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister942));
		r_MmaAHalf2WordAtPtx2282R999 = r_Value.x;
		r_MmaAHalf2WordAtPtx2282R1000 = r_Value.y;
		r_MmaAHalf2WordAtPtx2282R1001 = r_Value.z;
		r_MmaAHalf2WordAtPtx2282R1002 = r_Value.w;
	} // PTX L2282
	r_LaneIndexAtPtx2285 = uint32_t((threadIdx.x & 31u));						  // PTX L2285
	r_PtxRegister1061 = uint32_t(r_PtxRegister1049) + uint32_t(3072);			  // PTX L2287
	r_PtxRegister1062 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2285), uint32_t(4));	  // PTX L2288
	r_PtxRegister944 = uint32_t(r_PtxRegister1061) + uint32_t(r_PtxRegister1062); // PTX L2289
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister944));
		r_MmaAHalf2WordAtPtx2291R1019 = r_Value.x;
		r_MmaAHalf2WordAtPtx2291R1020 = r_Value.y;
		r_MmaAHalf2WordAtPtx2291R1021 = r_Value.z;
		r_MmaAHalf2WordAtPtx2291R1022 = r_Value.w;
	} // PTX L2291
	r_LaneIndexAtPtx2294 = uint32_t((threadIdx.x & 31u));						   // PTX L2294
	r_PtxRegister1063 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2294), uint32_t(4));	   // PTX L2296
	r_PtxRegister1064 = uint32_t(r_PtxRegister1061) + uint32_t(r_PtxRegister1063); // PTX L2297
	r_PtxRegister946 = uint32_t(r_PtxRegister1064) + uint32_t(512);				   // PTX L2298
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister946));
		r_MmaAHalf2WordAtPtx2300R1023 = r_Value.x;
		r_MmaAHalf2WordAtPtx2300R1024 = r_Value.y;
		r_MmaAHalf2WordAtPtx2300R1025 = r_Value.z;
		r_MmaAHalf2WordAtPtx2300R1026 = r_Value.w;
	} // PTX L2300
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2303R955, r_MmaAccumulatorHalf2WordAtPtx2303R956,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx456R1740, r_PackedHalf2AtPtx455R1739); // PTX L2303
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2310R957, r_MmaAccumulatorHalf2WordAtPtx2310R958,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx454R1738, r_PackedHalf2AtPtx453R1737); // PTX L2310
	MmaHalf(r_PackedHalf2AtPtx456R1740, r_PackedHalf2AtPtx455R1739, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx2303R955,
			r_MmaAccumulatorHalf2WordAtPtx2303R956); // PTX L2317
	MmaHalf(r_PackedHalf2AtPtx454R1738, r_PackedHalf2AtPtx453R1737, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx2310R957,
			r_MmaAccumulatorHalf2WordAtPtx2310R958); // PTX L2324
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2331R959, r_MmaAccumulatorHalf2WordAtPtx2331R960,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx452R1736, r_PackedHalf2AtPtx451R1735); // PTX L2331
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2338R961, r_MmaAccumulatorHalf2WordAtPtx2338R962,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx450R1734, r_PackedHalf2AtPtx449R1733); // PTX L2338
	MmaHalf(r_PackedHalf2AtPtx452R1736, r_PackedHalf2AtPtx451R1735, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx2331R959,
			r_MmaAccumulatorHalf2WordAtPtx2331R960); // PTX L2345
	MmaHalf(r_PackedHalf2AtPtx450R1734, r_PackedHalf2AtPtx449R1733, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx2338R961,
			r_MmaAccumulatorHalf2WordAtPtx2338R962); // PTX L2352
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2359R963, r_MmaAccumulatorHalf2WordAtPtx2359R964,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx448R1732, r_PackedHalf2AtPtx447R1731); // PTX L2359
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2366R965, r_MmaAccumulatorHalf2WordAtPtx2366R966,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx446R1730, r_PackedHalf2AtPtx445R1729); // PTX L2366
	MmaHalf(r_PackedHalf2AtPtx448R1732, r_PackedHalf2AtPtx447R1731, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx2359R963,
			r_MmaAccumulatorHalf2WordAtPtx2359R964); // PTX L2373
	MmaHalf(r_PackedHalf2AtPtx446R1730, r_PackedHalf2AtPtx445R1729, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx2366R965,
			r_MmaAccumulatorHalf2WordAtPtx2366R966); // PTX L2380
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2387R967, r_MmaAccumulatorHalf2WordAtPtx2387R968,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx444R1728, r_PackedHalf2AtPtx443R1727); // PTX L2387
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2394R969, r_MmaAccumulatorHalf2WordAtPtx2394R970,
			r_MmaAHalf2WordAtPtx2237R947, r_MmaAHalf2WordAtPtx2237R948, r_MmaAHalf2WordAtPtx2237R949,
			r_MmaAHalf2WordAtPtx2237R950, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx442R1726, r_PackedHalf2AtPtx441R1725); // PTX L2394
	MmaHalf(r_PackedHalf2AtPtx444R1728, r_PackedHalf2AtPtx443R1727, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx2387R967,
			r_MmaAccumulatorHalf2WordAtPtx2387R968); // PTX L2401
	MmaHalf(r_PackedHalf2AtPtx442R1726, r_PackedHalf2AtPtx441R1725, r_MmaAHalf2WordAtPtx2246R951,
			r_MmaAHalf2WordAtPtx2246R952, r_MmaAHalf2WordAtPtx2246R953, r_MmaAHalf2WordAtPtx2246R954,
			r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx2394R969,
			r_MmaAccumulatorHalf2WordAtPtx2394R970); // PTX L2408
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2415R979, r_MmaAccumulatorHalf2WordAtPtx2415R980,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx440R1724, r_PackedHalf2AtPtx439R1723); // PTX L2415
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2422R981, r_MmaAccumulatorHalf2WordAtPtx2422R982,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx438R1722, r_PackedHalf2AtPtx437R1721); // PTX L2422
	MmaHalf(r_PackedHalf2AtPtx440R1724, r_PackedHalf2AtPtx439R1723, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx2415R979,
			r_MmaAccumulatorHalf2WordAtPtx2415R980); // PTX L2429
	MmaHalf(r_PackedHalf2AtPtx438R1722, r_PackedHalf2AtPtx437R1721, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx2422R981,
			r_MmaAccumulatorHalf2WordAtPtx2422R982); // PTX L2436
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2443R983, r_MmaAccumulatorHalf2WordAtPtx2443R984,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx436R1720, r_PackedHalf2AtPtx435R1719); // PTX L2443
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2450R985, r_MmaAccumulatorHalf2WordAtPtx2450R986,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx434R1718, r_PackedHalf2AtPtx433R1717); // PTX L2450
	MmaHalf(r_PackedHalf2AtPtx436R1720, r_PackedHalf2AtPtx435R1719, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx2443R983,
			r_MmaAccumulatorHalf2WordAtPtx2443R984); // PTX L2457
	MmaHalf(r_PackedHalf2AtPtx434R1718, r_PackedHalf2AtPtx433R1717, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx2450R985,
			r_MmaAccumulatorHalf2WordAtPtx2450R986); // PTX L2464
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2471R987, r_MmaAccumulatorHalf2WordAtPtx2471R988,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx432R1716, r_PackedHalf2AtPtx431R1715); // PTX L2471
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2478R989, r_MmaAccumulatorHalf2WordAtPtx2478R990,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx430R1714, r_PackedHalf2AtPtx429R1713); // PTX L2478
	MmaHalf(r_PackedHalf2AtPtx432R1716, r_PackedHalf2AtPtx431R1715, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx2471R987,
			r_MmaAccumulatorHalf2WordAtPtx2471R988); // PTX L2485
	MmaHalf(r_PackedHalf2AtPtx430R1714, r_PackedHalf2AtPtx429R1713, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx2478R989,
			r_MmaAccumulatorHalf2WordAtPtx2478R990); // PTX L2492
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2499R991, r_MmaAccumulatorHalf2WordAtPtx2499R992,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx428R1712, r_PackedHalf2AtPtx427R1711); // PTX L2499
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2506R993, r_MmaAccumulatorHalf2WordAtPtx2506R994,
			r_MmaAHalf2WordAtPtx2255R971, r_MmaAHalf2WordAtPtx2255R972, r_MmaAHalf2WordAtPtx2255R973,
			r_MmaAHalf2WordAtPtx2255R974, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx426R1710, r_PackedHalf2AtPtx425R1709); // PTX L2506
	MmaHalf(r_PackedHalf2AtPtx428R1712, r_PackedHalf2AtPtx427R1711, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx2499R991,
			r_MmaAccumulatorHalf2WordAtPtx2499R992); // PTX L2513
	MmaHalf(r_PackedHalf2AtPtx426R1710, r_PackedHalf2AtPtx425R1709, r_MmaAHalf2WordAtPtx2264R975,
			r_MmaAHalf2WordAtPtx2264R976, r_MmaAHalf2WordAtPtx2264R977, r_MmaAHalf2WordAtPtx2264R978,
			r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx2506R993,
			r_MmaAccumulatorHalf2WordAtPtx2506R994); // PTX L2520
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2527R1003, r_MmaAccumulatorHalf2WordAtPtx2527R1004,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx424R1708, r_PackedHalf2AtPtx423R1707); // PTX L2527
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2534R1005, r_MmaAccumulatorHalf2WordAtPtx2534R1006,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx422R1706, r_PackedHalf2AtPtx421R1705); // PTX L2534
	MmaHalf(r_PackedHalf2AtPtx424R1708, r_PackedHalf2AtPtx423R1707, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx2527R1003,
			r_MmaAccumulatorHalf2WordAtPtx2527R1004); // PTX L2541
	MmaHalf(r_PackedHalf2AtPtx422R1706, r_PackedHalf2AtPtx421R1705, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx2534R1005,
			r_MmaAccumulatorHalf2WordAtPtx2534R1006); // PTX L2548
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2555R1007, r_MmaAccumulatorHalf2WordAtPtx2555R1008,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx420R1704, r_PackedHalf2AtPtx419R1703); // PTX L2555
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2562R1009, r_MmaAccumulatorHalf2WordAtPtx2562R1010,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx418R1702, r_PackedHalf2AtPtx417R1701); // PTX L2562
	MmaHalf(r_PackedHalf2AtPtx420R1704, r_PackedHalf2AtPtx419R1703, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx2555R1007,
			r_MmaAccumulatorHalf2WordAtPtx2555R1008); // PTX L2569
	MmaHalf(r_PackedHalf2AtPtx418R1702, r_PackedHalf2AtPtx417R1701, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx2562R1009,
			r_MmaAccumulatorHalf2WordAtPtx2562R1010); // PTX L2576
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2583R1011, r_MmaAccumulatorHalf2WordAtPtx2583R1012,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx416R1700, r_PackedHalf2AtPtx415R1699); // PTX L2583
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2590R1013, r_MmaAccumulatorHalf2WordAtPtx2590R1014,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx414R1698, r_PackedHalf2AtPtx413R1697); // PTX L2590
	MmaHalf(r_PackedHalf2AtPtx416R1700, r_PackedHalf2AtPtx415R1699, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx2583R1011,
			r_MmaAccumulatorHalf2WordAtPtx2583R1012); // PTX L2597
	MmaHalf(r_PackedHalf2AtPtx414R1698, r_PackedHalf2AtPtx413R1697, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx2590R1013,
			r_MmaAccumulatorHalf2WordAtPtx2590R1014); // PTX L2604
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2611R1015, r_MmaAccumulatorHalf2WordAtPtx2611R1016,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx412R1696, r_PackedHalf2AtPtx411R1695); // PTX L2611
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2618R1017, r_MmaAccumulatorHalf2WordAtPtx2618R1018,
			r_MmaAHalf2WordAtPtx2273R995, r_MmaAHalf2WordAtPtx2273R996, r_MmaAHalf2WordAtPtx2273R997,
			r_MmaAHalf2WordAtPtx2273R998, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx410R1694, r_PackedHalf2AtPtx409R1693); // PTX L2618
	MmaHalf(r_PackedHalf2AtPtx412R1696, r_PackedHalf2AtPtx411R1695, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx2611R1015,
			r_MmaAccumulatorHalf2WordAtPtx2611R1016); // PTX L2625
	MmaHalf(r_PackedHalf2AtPtx410R1694, r_PackedHalf2AtPtx409R1693, r_MmaAHalf2WordAtPtx2282R999,
			r_MmaAHalf2WordAtPtx2282R1000, r_MmaAHalf2WordAtPtx2282R1001, r_MmaAHalf2WordAtPtx2282R1002,
			r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx2618R1017,
			r_MmaAccumulatorHalf2WordAtPtx2618R1018); // PTX L2632
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2639R1027, r_MmaAccumulatorHalf2WordAtPtx2639R1028,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx408R1692, r_PackedHalf2AtPtx407R1691); // PTX L2639
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2646R1029, r_MmaAccumulatorHalf2WordAtPtx2646R1030,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx406R1690, r_PackedHalf2AtPtx405R1689); // PTX L2646
	MmaHalf(r_PackedHalf2AtPtx408R1692, r_PackedHalf2AtPtx407R1691, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx2639R1027,
			r_MmaAccumulatorHalf2WordAtPtx2639R1028); // PTX L2653
	MmaHalf(r_PackedHalf2AtPtx406R1690, r_PackedHalf2AtPtx405R1689, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx2646R1029,
			r_MmaAccumulatorHalf2WordAtPtx2646R1030); // PTX L2660
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2667R1031, r_MmaAccumulatorHalf2WordAtPtx2667R1032,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx404R1688, r_PackedHalf2AtPtx403R1687); // PTX L2667
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2674R1033, r_MmaAccumulatorHalf2WordAtPtx2674R1034,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx402R1686, r_PackedHalf2AtPtx401R1685); // PTX L2674
	MmaHalf(r_PackedHalf2AtPtx404R1688, r_PackedHalf2AtPtx403R1687, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx2667R1031,
			r_MmaAccumulatorHalf2WordAtPtx2667R1032); // PTX L2681
	MmaHalf(r_PackedHalf2AtPtx402R1686, r_PackedHalf2AtPtx401R1685, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx2674R1033,
			r_MmaAccumulatorHalf2WordAtPtx2674R1034); // PTX L2688
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2695R1035, r_MmaAccumulatorHalf2WordAtPtx2695R1036,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx400R1684, r_PackedHalf2AtPtx399R1683); // PTX L2695
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2702R1037, r_MmaAccumulatorHalf2WordAtPtx2702R1038,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx398R1682, r_PackedHalf2AtPtx397R1681); // PTX L2702
	MmaHalf(r_PackedHalf2AtPtx400R1684, r_PackedHalf2AtPtx399R1683, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx2695R1035,
			r_MmaAccumulatorHalf2WordAtPtx2695R1036); // PTX L2709
	MmaHalf(r_PackedHalf2AtPtx398R1682, r_PackedHalf2AtPtx397R1681, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx2702R1037,
			r_MmaAccumulatorHalf2WordAtPtx2702R1038); // PTX L2716
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2723R1039, r_MmaAccumulatorHalf2WordAtPtx2723R1040,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx396R1680, r_PackedHalf2AtPtx395R1679); // PTX L2723
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2730R1041, r_MmaAccumulatorHalf2WordAtPtx2730R1042,
			r_MmaAHalf2WordAtPtx2291R1019, r_MmaAHalf2WordAtPtx2291R1020, r_MmaAHalf2WordAtPtx2291R1021,
			r_MmaAHalf2WordAtPtx2291R1022, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx394R1678, r_PackedHalf2AtPtx393R1677); // PTX L2730
	MmaHalf(r_PackedHalf2AtPtx396R1680, r_PackedHalf2AtPtx395R1679, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx2723R1039,
			r_MmaAccumulatorHalf2WordAtPtx2723R1040); // PTX L2737
	MmaHalf(r_PackedHalf2AtPtx394R1678, r_PackedHalf2AtPtx393R1677, r_MmaAHalf2WordAtPtx2300R1023,
			r_MmaAHalf2WordAtPtx2300R1024, r_MmaAHalf2WordAtPtx2300R1025, r_MmaAHalf2WordAtPtx2300R1026,
			r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx2730R1041,
			r_MmaAccumulatorHalf2WordAtPtx2730R1042);						 // PTX L2744
	r_PtxRegister34 = r_PtxRegister1046 ^ 8192;								 // PTX L2750
	r_PtxRegister35 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister31); // PTX L2751
	r_PtxU64Register519 = uint64_t(0);										 // PTX L2752
	if (r_bPtxPredicate8)
	{
		goto L__BB56_89;
	} // PTX L2753
	r_PtxRegister1065 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(4));		 // PTX L2754
	r_PtxRegister1066 = uint32_t(r_PtxRegister1065) + uint32_t(r_PtxRegister10); // PTX L2755
	r_PtxRegister1067 = ShiftLeft(uint32_t(r_PtxRegister1066), uint32_t(7));	 // PTX L2756
	r_PtxRegister1068 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister1067); // PTX L2757
	r_PtxU64Register519 = SignExtendWordBits(r_PtxRegister1068);				 // PTX L2758
L__BB56_89:																		 // PTX L2759
	r_PtxU64Register520 = uint64_t(0);											 // PTX L2760
	if (r_bPtxPredicate8)
	{
		goto L__BB56_91;
	} // PTX L2761
	r_PtxU64Register239 = ShiftLeft(uint64_t(r_PtxU64Register519), uint32_t(2));		// PTX L2762
	r_PtxU64Register520 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register239); // PTX L2763
L__BB56_91:																				// PTX L2764
	r_PtxRegister1069 = uint32_t(0u /* original named shared base */);					// PTX L2765
	r_PtxRegister36 = uint32_t(r_PtxRegister1069) + uint32_t(r_PtxRegister83);			// PTX L2766
	r_PtxRegister1070 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(3));				// PTX L2767
	r_PtxRegister1071 = uint32_t(16384u /* original named shared base */);				// PTX L2768
	r_PtxRegister1128 = uint32_t(r_PtxRegister1071) + uint32_t(r_PtxRegister1070);		// PTX L2769
	if (r_bPtxPredicate8)
	{
		goto L__BB56_94;
	} // PTX L2770
	r_PtxRegister1077 = uint32_t(-1);								// PTX L2771
	r_PtxRegister1076 = Elected(r_PtxRegister1077);					// PTX L2773
	r_bPtxPredicate61 = uint32_t(r_PtxRegister1076) == uint32_t(0); // PTX L2779
	if (r_bPtxPredicate61)
	{
		goto L__BB56_95;
	} // PTX L2780
	r_PtxRegister1078 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister34); // PTX L2781
	r_PtxU64Register240 = r_PtxU64Register520;								   // PTX L2782
	r_PtxRegister1079 = uint32_t(512);										   // PTX L2783
	CopyBulk(s_SharedStorage, r_PtxRegister1078, r_PtxU64Register240, r_PtxRegister1079,
			 r_PtxRegister1128);												   // PTX L2785
	BarrierExpect(s_SharedStorage, r_PtxRegister1128, r_PtxRegister1079);		   // PTX L2788
	goto L__BB56_95;															   // PTX L2790
L__BB56_94:																		   // PTX L2791
	r_LaneIndexAtPtx2793 = uint32_t((threadIdx.x & 31u));						   // PTX L2793
	r_PtxRegister1074 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister34);	   // PTX L2795
	r_PtxRegister1075 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2793), uint32_t(4));	   // PTX L2796
	r_PtxRegister1073 = uint32_t(r_PtxRegister1074) + uint32_t(r_PtxRegister1075); // PTX L2797
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1073)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850); // PTX L2799
L__BB56_95:										 // PTX L2801
	r_PtxU64Register521 = uint64_t(0);			 // PTX L2802
	if (r_bPtxPredicate13)
	{
		goto L__BB56_97;
	} // PTX L2803
	r_PtxRegister1080 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(4));		 // PTX L2804
	r_PtxRegister1081 = uint32_t(r_PtxRegister1080) + uint32_t(r_PtxRegister10); // PTX L2805
	r_PtxRegister1082 = ShiftLeft(uint32_t(r_PtxRegister1081), uint32_t(7));	 // PTX L2806
	r_PtxRegister1083 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister1082); // PTX L2807
	r_PtxU64Register521 = SignExtendWordBits(r_PtxRegister1083);				 // PTX L2808
L__BB56_97:																		 // PTX L2809
	r_PtxU64Register522 = uint64_t(0);											 // PTX L2810
	if (r_bPtxPredicate13)
	{
		goto L__BB56_99;
	} // PTX L2811
	r_PtxU64Register241 = ShiftLeft(uint64_t(r_PtxU64Register521), uint32_t(2));		// PTX L2812
	r_PtxU64Register522 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register241); // PTX L2813
L__BB56_99:																				// PTX L2814
	r_PtxRegister1084 = uint32_t(r_PtxRegister83) + uint32_t(2048);						// PTX L2815
	r_PtxRegister1085 = r_PtxRegister1084 & 1047552;									// PTX L2816
	r_PtxRegister1086 = r_PtxRegister1085 | r_PtxRegister84;							// PTX L2817
	r_PtxRegister1087 = uint32_t(0u /* original named shared base */);					// PTX L2818
	r_PtxRegister37 = uint32_t(r_PtxRegister1087) + uint32_t(r_PtxRegister1086);		// PTX L2819
	if (r_bPtxPredicate13)
	{
		goto L__BB56_102;
	} // PTX L2820
	r_PtxRegister1093 = uint32_t(-1);								// PTX L2821
	r_PtxRegister1092 = Elected(r_PtxRegister1093);					// PTX L2823
	r_bPtxPredicate62 = uint32_t(r_PtxRegister1092) == uint32_t(0); // PTX L2829
	if (r_bPtxPredicate62)
	{
		goto L__BB56_103;
	} // PTX L2830
	r_PtxRegister1094 = uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister34); // PTX L2831
	r_PtxU64Register242 = r_PtxU64Register522;								   // PTX L2832
	r_PtxRegister1095 = uint32_t(512);										   // PTX L2833
	CopyBulk(s_SharedStorage, r_PtxRegister1094, r_PtxU64Register242, r_PtxRegister1095,
			 r_PtxRegister1128);												   // PTX L2835
	BarrierExpect(s_SharedStorage, r_PtxRegister1128, r_PtxRegister1095);		   // PTX L2838
	goto L__BB56_103;															   // PTX L2840
L__BB56_102:																	   // PTX L2841
	r_LaneIndexAtPtx2843 = uint32_t((threadIdx.x & 31u));						   // PTX L2843
	r_PtxRegister1090 = uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister34);	   // PTX L2845
	r_PtxRegister1091 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2843), uint32_t(4));	   // PTX L2846
	r_PtxRegister1089 = uint32_t(r_PtxRegister1090) + uint32_t(r_PtxRegister1091); // PTX L2847
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1089)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850); // PTX L2849
L__BB56_103:									 // PTX L2851
	r_PtxU64Register523 = uint64_t(0);			 // PTX L2852
	if (r_bPtxPredicate18)
	{
		goto L__BB56_105;
	} // PTX L2853
	r_PtxRegister1096 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(4));		 // PTX L2854
	r_PtxRegister1097 = uint32_t(r_PtxRegister1096) + uint32_t(r_PtxRegister10); // PTX L2855
	r_PtxRegister1098 = ShiftLeft(uint32_t(r_PtxRegister1097), uint32_t(7));	 // PTX L2856
	r_PtxRegister1099 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister1098); // PTX L2857
	r_PtxU64Register523 = SignExtendWordBits(r_PtxRegister1099);				 // PTX L2858
L__BB56_105:																	 // PTX L2859
	r_PtxU64Register524 = uint64_t(0);											 // PTX L2860
	if (r_bPtxPredicate18)
	{
		goto L__BB56_107;
	} // PTX L2861
	r_PtxU64Register243 = ShiftLeft(uint64_t(r_PtxU64Register523), uint32_t(2));		// PTX L2862
	r_PtxU64Register524 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register243); // PTX L2863
L__BB56_107:																			// PTX L2864
	r_PtxRegister1100 = uint32_t(r_PtxRegister83) + uint32_t(4096);						// PTX L2865
	r_PtxRegister1101 = r_PtxRegister1100 & 1047552;									// PTX L2866
	r_PtxRegister1102 = r_PtxRegister1101 | r_PtxRegister84;							// PTX L2867
	r_PtxRegister1103 = uint32_t(0u /* original named shared base */);					// PTX L2868
	r_PtxRegister38 = uint32_t(r_PtxRegister1103) + uint32_t(r_PtxRegister1102);		// PTX L2869
	if (r_bPtxPredicate18)
	{
		goto L__BB56_110;
	} // PTX L2870
	r_PtxRegister1109 = uint32_t(-1);								// PTX L2871
	r_PtxRegister1108 = Elected(r_PtxRegister1109);					// PTX L2873
	r_bPtxPredicate63 = uint32_t(r_PtxRegister1108) == uint32_t(0); // PTX L2879
	if (r_bPtxPredicate63)
	{
		goto L__BB56_111;
	} // PTX L2880
	r_PtxRegister1110 = uint32_t(r_PtxRegister38) + uint32_t(r_PtxRegister34); // PTX L2881
	r_PtxU64Register244 = r_PtxU64Register524;								   // PTX L2882
	r_PtxRegister1111 = uint32_t(512);										   // PTX L2883
	CopyBulk(s_SharedStorage, r_PtxRegister1110, r_PtxU64Register244, r_PtxRegister1111,
			 r_PtxRegister1128);												   // PTX L2885
	BarrierExpect(s_SharedStorage, r_PtxRegister1128, r_PtxRegister1111);		   // PTX L2888
	goto L__BB56_111;															   // PTX L2890
L__BB56_110:																	   // PTX L2891
	r_LaneIndexAtPtx2893 = uint32_t((threadIdx.x & 31u));						   // PTX L2893
	r_PtxRegister1106 = uint32_t(r_PtxRegister38) + uint32_t(r_PtxRegister34);	   // PTX L2895
	r_PtxRegister1107 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2893), uint32_t(4));	   // PTX L2896
	r_PtxRegister1105 = uint32_t(r_PtxRegister1106) + uint32_t(r_PtxRegister1107); // PTX L2897
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1105)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850); // PTX L2899
L__BB56_111:									 // PTX L2901
	r_PtxU64Register525 = uint64_t(0);			 // PTX L2902
	if (r_bPtxPredicate23)
	{
		goto L__BB56_113;
	} // PTX L2903
	r_PtxRegister1112 = ShiftRight(uint32_t(r_PtxRegister35), uint32_t(4));		 // PTX L2904
	r_PtxRegister1113 = uint32_t(r_PtxRegister1112) + uint32_t(r_PtxRegister10); // PTX L2905
	r_PtxRegister1114 = ShiftLeft(uint32_t(r_PtxRegister1113), uint32_t(7));	 // PTX L2906
	r_PtxRegister1115 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister1114); // PTX L2907
	r_PtxU64Register525 = SignExtendWordBits(r_PtxRegister1115);				 // PTX L2908
L__BB56_113:																	 // PTX L2909
	r_PtxU64Register526 = uint64_t(0);											 // PTX L2910
	if (r_bPtxPredicate23)
	{
		goto L__BB56_115;
	} // PTX L2911
	r_PtxU64Register245 = ShiftLeft(uint64_t(r_PtxU64Register525), uint32_t(2));		// PTX L2912
	r_PtxU64Register526 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register245); // PTX L2913
L__BB56_115:																			// PTX L2914
	r_PtxRegister1116 = uint32_t(r_PtxRegister83) + uint32_t(6144);						// PTX L2915
	r_PtxRegister1117 = r_PtxRegister1116 & 1047552;									// PTX L2916
	r_PtxRegister1118 = r_PtxRegister1117 | r_PtxRegister84;							// PTX L2917
	r_PtxRegister1119 = uint32_t(0u /* original named shared base */);					// PTX L2918
	r_PtxRegister39 = uint32_t(r_PtxRegister1119) + uint32_t(r_PtxRegister1118);		// PTX L2919
	if (r_bPtxPredicate23)
	{
		goto L__BB56_118;
	} // PTX L2920
	r_PtxRegister1125 = uint32_t(-1);								// PTX L2921
	r_PtxRegister1124 = Elected(r_PtxRegister1125);					// PTX L2923
	r_bPtxPredicate64 = uint32_t(r_PtxRegister1124) == uint32_t(0); // PTX L2929
	if (r_bPtxPredicate64)
	{
		goto L__BB56_119;
	} // PTX L2930
	r_PtxRegister1126 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister34); // PTX L2931
	r_PtxU64Register246 = r_PtxU64Register526;								   // PTX L2932
	r_PtxRegister1127 = uint32_t(512);										   // PTX L2933
	CopyBulk(s_SharedStorage, r_PtxRegister1126, r_PtxU64Register246, r_PtxRegister1127,
			 r_PtxRegister1128);												   // PTX L2935
	BarrierExpect(s_SharedStorage, r_PtxRegister1128, r_PtxRegister1127);		   // PTX L2938
	goto L__BB56_119;															   // PTX L2940
L__BB56_118:																	   // PTX L2941
	r_LaneIndexAtPtx2943 = uint32_t((threadIdx.x & 31u));						   // PTX L2943
	r_PtxRegister1122 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister34);	   // PTX L2945
	r_PtxRegister1123 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2943), uint32_t(4));	   // PTX L2946
	r_PtxRegister1121 = uint32_t(r_PtxRegister1122) + uint32_t(r_PtxRegister1123); // PTX L2947
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1121)) =
		make_uint4(r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850, r_PackedHalf2AtPtx4345R1850,
				   r_PackedHalf2AtPtx4345R1850);												  // PTX L2949
L__BB56_119:																					  // PTX L2951
	r_PtxRegister1138 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(9));						  // PTX L2952
	r_PtxRegister1139 = uint32_t(r_PtxRegister1138) + uint32_t(r_PtxRegister6);					  // PTX L2953
	r_PtxU64Register255 = uint64_t(int64_t(int32_t(r_PtxRegister1139)) * int64_t(int32_t(4)));	  // PTX L2954
	g_RecordByteAddressAtPtx2955 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register255); // PTX L2955
	r_LaneIndexAtPtx2957 = uint32_t((threadIdx.x & 31u));										  // PTX L2957
	r_PtxU64Register257 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2957)) * int64_t(int32_t(16))); // PTX L2959
	g_RecordByteAddressAtPtx2960 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register257); // PTX L2960
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2960));
		r_MmaBHalf2WordAtPtx76R1742 = r_Value.x;
		r_MmaBHalf2WordAtPtx76R1743 = r_Value.y;
		r_MmaBHalf2WordAtPtx76R1744 = r_Value.z;
		r_MmaBHalf2WordAtPtx76R1745 = r_Value.w;
	} // PTX L2962
	r_LaneIndexAtPtx2965 = uint32_t((threadIdx.x & 31u)); // PTX L2965
	r_PtxU64Register258 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2965)) * int64_t(int32_t(16))); // PTX L2967
	g_RecordByteAddressAtPtx2968 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register258);			   // PTX L2968
	g_RecordByteAddressAtPtx2969 = uint64_t(g_RecordByteAddressAtPtx2968) + uint64_t(512); // PTX L2969
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2969));
		r_MmaBHalf2WordAtPtx86R1746 = r_Value.x;
		r_MmaBHalf2WordAtPtx86R1747 = r_Value.y;
		r_MmaBHalf2WordAtPtx86R1748 = r_Value.z;
		r_MmaBHalf2WordAtPtx86R1749 = r_Value.w;
	} // PTX L2971
	r_LaneIndexAtPtx2974 = uint32_t((threadIdx.x & 31u)); // PTX L2974
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2974)) * int64_t(int32_t(16))); // PTX L2976
	g_RecordByteAddressAtPtx2977 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register260);				// PTX L2977
	g_RecordByteAddressAtPtx2978 = uint64_t(g_RecordByteAddressAtPtx2977) + uint64_t(1024); // PTX L2978
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2978));
		r_MmaBHalf2WordAtPtx96R1750 = r_Value.x;
		r_MmaBHalf2WordAtPtx96R1751 = r_Value.y;
		r_MmaBHalf2WordAtPtx96R1752 = r_Value.z;
		r_MmaBHalf2WordAtPtx96R1753 = r_Value.w;
	} // PTX L2980
	r_LaneIndexAtPtx2983 = uint32_t((threadIdx.x & 31u)); // PTX L2983
	r_PtxU64Register262 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2983)) * int64_t(int32_t(16))); // PTX L2985
	g_RecordByteAddressAtPtx2986 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register262);				// PTX L2986
	g_RecordByteAddressAtPtx2987 = uint64_t(g_RecordByteAddressAtPtx2986) + uint64_t(1536); // PTX L2987
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2987));
		r_MmaBHalf2WordAtPtx106R1754 = r_Value.x;
		r_MmaBHalf2WordAtPtx106R1755 = r_Value.y;
		r_MmaBHalf2WordAtPtx106R1756 = r_Value.z;
		r_MmaBHalf2WordAtPtx106R1757 = r_Value.w;
	} // PTX L2989
	r_LaneIndexAtPtx2992 = uint32_t((threadIdx.x & 31u)); // PTX L2992
	r_PtxU64Register264 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2992)) * int64_t(int32_t(16))); // PTX L2994
	g_RecordByteAddressAtPtx2995 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register264);				 // PTX L2995
	g_RecordByteAddressAtPtx2996 = uint64_t(g_RecordByteAddressAtPtx2995) + uint64_t(32768); // PTX L2996
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2996));
		r_MmaBHalf2WordAtPtx115R1758 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R1759 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R1760 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R1761 = r_Value.w;
	} // PTX L2998
	r_LaneIndexAtPtx3001 = uint32_t((threadIdx.x & 31u)); // PTX L3001
	r_PtxU64Register266 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3001)) * int64_t(int32_t(16))); // PTX L3003
	g_RecordByteAddressAtPtx3004 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register266);				 // PTX L3004
	g_RecordByteAddressAtPtx3005 = uint64_t(g_RecordByteAddressAtPtx3004) + uint64_t(33280); // PTX L3005
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3005));
		r_MmaBHalf2WordAtPtx124R1762 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R1763 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R1764 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R1765 = r_Value.w;
	} // PTX L3007
	r_LaneIndexAtPtx3010 = uint32_t((threadIdx.x & 31u)); // PTX L3010
	r_PtxU64Register268 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3010)) * int64_t(int32_t(16))); // PTX L3012
	g_RecordByteAddressAtPtx3013 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register268);				 // PTX L3013
	g_RecordByteAddressAtPtx3014 = uint64_t(g_RecordByteAddressAtPtx3013) + uint64_t(33792); // PTX L3014
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3014));
		r_MmaBHalf2WordAtPtx133R1766 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R1767 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R1768 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R1769 = r_Value.w;
	} // PTX L3016
	r_LaneIndexAtPtx3019 = uint32_t((threadIdx.x & 31u)); // PTX L3019
	r_PtxU64Register270 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3019)) * int64_t(int32_t(16))); // PTX L3021
	g_RecordByteAddressAtPtx3022 =
		uint64_t(g_RecordByteAddressAtPtx2955) + uint64_t(r_PtxU64Register270);				 // PTX L3022
	g_RecordByteAddressAtPtx3023 = uint64_t(g_RecordByteAddressAtPtx3022) + uint64_t(34304); // PTX L3023
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3023));
		r_MmaBHalf2WordAtPtx142R1770 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R1771 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R1772 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R1773 = r_Value.w;
	} // PTX L3025
	r_PtxRegister1137 = uint32_t(1);															// PTX L3027
	r_PtxU64Register272 = BarrierArrive(s_SharedStorage, r_PtxRegister1128, r_PtxRegister1137); // PTX L3029
L__BB56_120:																					// PTX L3031
	r_PtxRegister1140 = BarrierReady(s_SharedStorage, r_PtxRegister1128, r_PtxU64Register272);	// PTX L3033
	r_bPtxPredicate65 = uint32_t(r_PtxRegister1140) == uint32_t(0);								// PTX L3039
	if (r_bPtxPredicate65)
	{
		goto L__BB56_120;
	} // PTX L3040
	r_bPtxPredicate66 = uint32_t(r_PtxRegister1741) < uint32_t(192); // PTX L3041
	r_PtxRegister1741 = uint32_t(r_PtxRegister32);					 // PTX L3042
	if (r_bPtxPredicate66)
	{
		goto L__BB56_87;
	} // PTX L3043
	r_bPtxPredicate67 = uint32_t(r_CtaZ) == uint32_t(0);						   // PTX L3044
	r_LaneIndexAtPtx3046 = uint32_t((threadIdx.x & 31u));						   // PTX L3046
	r_PtxRegister1317 = uint32_t(0u /* original named shared base */);			   // PTX L3048
	r_PtxRegister1318 = uint32_t(r_PtxRegister1317) + uint32_t(r_PtxRegister26);   // PTX L3049
	r_PtxRegister1319 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3046), uint32_t(4));	   // PTX L3050
	r_PtxRegister1320 = uint32_t(r_PtxRegister1318) + uint32_t(r_PtxRegister1319); // PTX L3051
	r_PtxRegister1142 = uint32_t(r_PtxRegister1320) + uint32_t(8192);			   // PTX L3052
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1142));
		r_MmaAHalf2WordAtPtx3054R1157 = r_Value.x;
		r_MmaAHalf2WordAtPtx3054R1158 = r_Value.y;
		r_MmaAHalf2WordAtPtx3054R1159 = r_Value.z;
		r_MmaAHalf2WordAtPtx3054R1160 = r_Value.w;
	} // PTX L3054
	r_LaneIndexAtPtx3057 = uint32_t((threadIdx.x & 31u));						   // PTX L3057
	r_PtxRegister1321 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3057), uint32_t(4));	   // PTX L3059
	r_PtxRegister1322 = uint32_t(r_PtxRegister1318) + uint32_t(r_PtxRegister1321); // PTX L3060
	r_PtxRegister1144 = uint32_t(r_PtxRegister1322) + uint32_t(8704);			   // PTX L3061
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1144));
		r_MmaAHalf2WordAtPtx3063R1163 = r_Value.x;
		r_MmaAHalf2WordAtPtx3063R1164 = r_Value.y;
		r_MmaAHalf2WordAtPtx3063R1165 = r_Value.z;
		r_MmaAHalf2WordAtPtx3063R1166 = r_Value.w;
	} // PTX L3063
	r_LaneIndexAtPtx3066 = uint32_t((threadIdx.x & 31u));						   // PTX L3066
	r_PtxRegister1323 = uint32_t(r_PtxRegister1318) + uint32_t(1024);			   // PTX L3068
	r_PtxRegister1324 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3066), uint32_t(4));	   // PTX L3069
	r_PtxRegister1325 = uint32_t(r_PtxRegister1323) + uint32_t(r_PtxRegister1324); // PTX L3070
	r_PtxRegister1146 = uint32_t(r_PtxRegister1325) + uint32_t(8192);			   // PTX L3071
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1146));
		r_MmaAHalf2WordAtPtx3073R1197 = r_Value.x;
		r_MmaAHalf2WordAtPtx3073R1198 = r_Value.y;
		r_MmaAHalf2WordAtPtx3073R1199 = r_Value.z;
		r_MmaAHalf2WordAtPtx3073R1200 = r_Value.w;
	} // PTX L3073
	r_LaneIndexAtPtx3076 = uint32_t((threadIdx.x & 31u));						   // PTX L3076
	r_PtxRegister1326 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3076), uint32_t(4));	   // PTX L3078
	r_PtxRegister1327 = uint32_t(r_PtxRegister1323) + uint32_t(r_PtxRegister1326); // PTX L3079
	r_PtxRegister1148 = uint32_t(r_PtxRegister1327) + uint32_t(8704);			   // PTX L3080
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1148));
		r_MmaAHalf2WordAtPtx3082R1203 = r_Value.x;
		r_MmaAHalf2WordAtPtx3082R1204 = r_Value.y;
		r_MmaAHalf2WordAtPtx3082R1205 = r_Value.z;
		r_MmaAHalf2WordAtPtx3082R1206 = r_Value.w;
	} // PTX L3082
	r_LaneIndexAtPtx3085 = uint32_t((threadIdx.x & 31u));						   // PTX L3085
	r_PtxRegister1328 = uint32_t(r_PtxRegister1318) + uint32_t(2048);			   // PTX L3087
	r_PtxRegister1329 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3085), uint32_t(4));	   // PTX L3088
	r_PtxRegister1330 = uint32_t(r_PtxRegister1328) + uint32_t(r_PtxRegister1329); // PTX L3089
	r_PtxRegister1150 = uint32_t(r_PtxRegister1330) + uint32_t(8192);			   // PTX L3090
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1150));
		r_MmaAHalf2WordAtPtx3092R1237 = r_Value.x;
		r_MmaAHalf2WordAtPtx3092R1238 = r_Value.y;
		r_MmaAHalf2WordAtPtx3092R1239 = r_Value.z;
		r_MmaAHalf2WordAtPtx3092R1240 = r_Value.w;
	} // PTX L3092
	r_LaneIndexAtPtx3095 = uint32_t((threadIdx.x & 31u));						   // PTX L3095
	r_PtxRegister1331 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3095), uint32_t(4));	   // PTX L3097
	r_PtxRegister1332 = uint32_t(r_PtxRegister1328) + uint32_t(r_PtxRegister1331); // PTX L3098
	r_PtxRegister1152 = uint32_t(r_PtxRegister1332) + uint32_t(8704);			   // PTX L3099
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1152));
		r_MmaAHalf2WordAtPtx3101R1243 = r_Value.x;
		r_MmaAHalf2WordAtPtx3101R1244 = r_Value.y;
		r_MmaAHalf2WordAtPtx3101R1245 = r_Value.z;
		r_MmaAHalf2WordAtPtx3101R1246 = r_Value.w;
	} // PTX L3101
	r_LaneIndexAtPtx3104 = uint32_t((threadIdx.x & 31u));						   // PTX L3104
	r_PtxRegister1333 = uint32_t(r_PtxRegister1318) + uint32_t(3072);			   // PTX L3106
	r_PtxRegister1334 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3104), uint32_t(4));	   // PTX L3107
	r_PtxRegister1335 = uint32_t(r_PtxRegister1333) + uint32_t(r_PtxRegister1334); // PTX L3108
	r_PtxRegister1154 = uint32_t(r_PtxRegister1335) + uint32_t(8192);			   // PTX L3109
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1154));
		r_MmaAHalf2WordAtPtx3111R1277 = r_Value.x;
		r_MmaAHalf2WordAtPtx3111R1278 = r_Value.y;
		r_MmaAHalf2WordAtPtx3111R1279 = r_Value.z;
		r_MmaAHalf2WordAtPtx3111R1280 = r_Value.w;
	} // PTX L3111
	r_LaneIndexAtPtx3114 = uint32_t((threadIdx.x & 31u));						   // PTX L3114
	r_PtxRegister1336 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3114), uint32_t(4));	   // PTX L3116
	r_PtxRegister1337 = uint32_t(r_PtxRegister1333) + uint32_t(r_PtxRegister1336); // PTX L3117
	r_PtxRegister1156 = uint32_t(r_PtxRegister1337) + uint32_t(8704);			   // PTX L3118
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1156));
		r_MmaAHalf2WordAtPtx3120R1283 = r_Value.x;
		r_MmaAHalf2WordAtPtx3120R1284 = r_Value.y;
		r_MmaAHalf2WordAtPtx3120R1285 = r_Value.z;
		r_MmaAHalf2WordAtPtx3120R1286 = r_Value.w;
	} // PTX L3120
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3123R1167, r_MmaAccumulatorHalf2WordAtPtx3123R1168,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx456R1740, r_PackedHalf2AtPtx455R1739); // PTX L3123
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3130R1171, r_MmaAccumulatorHalf2WordAtPtx3130R1172,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx454R1738, r_PackedHalf2AtPtx453R1737); // PTX L3130
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3137R1161, r_MmaAccumulatorHalf2WordAtPtx3137R1162,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx3123R1167,
			r_MmaAccumulatorHalf2WordAtPtx3123R1168); // PTX L3137
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3144R1169, r_MmaAccumulatorHalf2WordAtPtx3144R1170,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx3130R1171,
			r_MmaAccumulatorHalf2WordAtPtx3130R1172); // PTX L3144
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3151R1175, r_MmaAccumulatorHalf2WordAtPtx3151R1176,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx452R1736, r_PackedHalf2AtPtx451R1735); // PTX L3151
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3158R1179, r_MmaAccumulatorHalf2WordAtPtx3158R1180,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx450R1734, r_PackedHalf2AtPtx449R1733); // PTX L3158
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3165R1173, r_MmaAccumulatorHalf2WordAtPtx3165R1174,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx3151R1175,
			r_MmaAccumulatorHalf2WordAtPtx3151R1176); // PTX L3165
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3172R1177, r_MmaAccumulatorHalf2WordAtPtx3172R1178,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx3158R1179,
			r_MmaAccumulatorHalf2WordAtPtx3158R1180); // PTX L3172
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3179R1183, r_MmaAccumulatorHalf2WordAtPtx3179R1184,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx448R1732, r_PackedHalf2AtPtx447R1731); // PTX L3179
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3186R1187, r_MmaAccumulatorHalf2WordAtPtx3186R1188,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx446R1730, r_PackedHalf2AtPtx445R1729); // PTX L3186
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3193R1181, r_MmaAccumulatorHalf2WordAtPtx3193R1182,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx3179R1183,
			r_MmaAccumulatorHalf2WordAtPtx3179R1184); // PTX L3193
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3200R1185, r_MmaAccumulatorHalf2WordAtPtx3200R1186,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx3186R1187,
			r_MmaAccumulatorHalf2WordAtPtx3186R1188); // PTX L3200
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3207R1191, r_MmaAccumulatorHalf2WordAtPtx3207R1192,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx444R1728, r_PackedHalf2AtPtx443R1727); // PTX L3207
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3214R1195, r_MmaAccumulatorHalf2WordAtPtx3214R1196,
			r_MmaAHalf2WordAtPtx3054R1157, r_MmaAHalf2WordAtPtx3054R1158, r_MmaAHalf2WordAtPtx3054R1159,
			r_MmaAHalf2WordAtPtx3054R1160, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx442R1726, r_PackedHalf2AtPtx441R1725); // PTX L3214
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3221R1189, r_MmaAccumulatorHalf2WordAtPtx3221R1190,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx3207R1191,
			r_MmaAccumulatorHalf2WordAtPtx3207R1192); // PTX L3221
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3228R1193, r_MmaAccumulatorHalf2WordAtPtx3228R1194,
			r_MmaAHalf2WordAtPtx3063R1163, r_MmaAHalf2WordAtPtx3063R1164, r_MmaAHalf2WordAtPtx3063R1165,
			r_MmaAHalf2WordAtPtx3063R1166, r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx3214R1195,
			r_MmaAccumulatorHalf2WordAtPtx3214R1196); // PTX L3228
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3235R1207, r_MmaAccumulatorHalf2WordAtPtx3235R1208,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx440R1724, r_PackedHalf2AtPtx439R1723); // PTX L3235
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3242R1211, r_MmaAccumulatorHalf2WordAtPtx3242R1212,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx438R1722, r_PackedHalf2AtPtx437R1721); // PTX L3242
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3249R1201, r_MmaAccumulatorHalf2WordAtPtx3249R1202,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx3235R1207,
			r_MmaAccumulatorHalf2WordAtPtx3235R1208); // PTX L3249
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3256R1209, r_MmaAccumulatorHalf2WordAtPtx3256R1210,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx3242R1211,
			r_MmaAccumulatorHalf2WordAtPtx3242R1212); // PTX L3256
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3263R1215, r_MmaAccumulatorHalf2WordAtPtx3263R1216,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx436R1720, r_PackedHalf2AtPtx435R1719); // PTX L3263
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3270R1219, r_MmaAccumulatorHalf2WordAtPtx3270R1220,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx434R1718, r_PackedHalf2AtPtx433R1717); // PTX L3270
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3277R1213, r_MmaAccumulatorHalf2WordAtPtx3277R1214,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx3263R1215,
			r_MmaAccumulatorHalf2WordAtPtx3263R1216); // PTX L3277
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3284R1217, r_MmaAccumulatorHalf2WordAtPtx3284R1218,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx3270R1219,
			r_MmaAccumulatorHalf2WordAtPtx3270R1220); // PTX L3284
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3291R1223, r_MmaAccumulatorHalf2WordAtPtx3291R1224,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx432R1716, r_PackedHalf2AtPtx431R1715); // PTX L3291
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3298R1227, r_MmaAccumulatorHalf2WordAtPtx3298R1228,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx430R1714, r_PackedHalf2AtPtx429R1713); // PTX L3298
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3305R1221, r_MmaAccumulatorHalf2WordAtPtx3305R1222,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx3291R1223,
			r_MmaAccumulatorHalf2WordAtPtx3291R1224); // PTX L3305
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3312R1225, r_MmaAccumulatorHalf2WordAtPtx3312R1226,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx3298R1227,
			r_MmaAccumulatorHalf2WordAtPtx3298R1228); // PTX L3312
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3319R1231, r_MmaAccumulatorHalf2WordAtPtx3319R1232,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx428R1712, r_PackedHalf2AtPtx427R1711); // PTX L3319
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3326R1235, r_MmaAccumulatorHalf2WordAtPtx3326R1236,
			r_MmaAHalf2WordAtPtx3073R1197, r_MmaAHalf2WordAtPtx3073R1198, r_MmaAHalf2WordAtPtx3073R1199,
			r_MmaAHalf2WordAtPtx3073R1200, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx426R1710, r_PackedHalf2AtPtx425R1709); // PTX L3326
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3333R1229, r_MmaAccumulatorHalf2WordAtPtx3333R1230,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx3319R1231,
			r_MmaAccumulatorHalf2WordAtPtx3319R1232); // PTX L3333
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3340R1233, r_MmaAccumulatorHalf2WordAtPtx3340R1234,
			r_MmaAHalf2WordAtPtx3082R1203, r_MmaAHalf2WordAtPtx3082R1204, r_MmaAHalf2WordAtPtx3082R1205,
			r_MmaAHalf2WordAtPtx3082R1206, r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx3326R1235,
			r_MmaAccumulatorHalf2WordAtPtx3326R1236); // PTX L3340
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3347R1247, r_MmaAccumulatorHalf2WordAtPtx3347R1248,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx424R1708, r_PackedHalf2AtPtx423R1707); // PTX L3347
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3354R1251, r_MmaAccumulatorHalf2WordAtPtx3354R1252,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx422R1706, r_PackedHalf2AtPtx421R1705); // PTX L3354
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3361R1241, r_MmaAccumulatorHalf2WordAtPtx3361R1242,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx3347R1247,
			r_MmaAccumulatorHalf2WordAtPtx3347R1248); // PTX L3361
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3368R1249, r_MmaAccumulatorHalf2WordAtPtx3368R1250,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx3354R1251,
			r_MmaAccumulatorHalf2WordAtPtx3354R1252); // PTX L3368
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3375R1255, r_MmaAccumulatorHalf2WordAtPtx3375R1256,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx420R1704, r_PackedHalf2AtPtx419R1703); // PTX L3375
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3382R1259, r_MmaAccumulatorHalf2WordAtPtx3382R1260,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx418R1702, r_PackedHalf2AtPtx417R1701); // PTX L3382
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3389R1253, r_MmaAccumulatorHalf2WordAtPtx3389R1254,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx3375R1255,
			r_MmaAccumulatorHalf2WordAtPtx3375R1256); // PTX L3389
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3396R1257, r_MmaAccumulatorHalf2WordAtPtx3396R1258,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx3382R1259,
			r_MmaAccumulatorHalf2WordAtPtx3382R1260); // PTX L3396
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3403R1263, r_MmaAccumulatorHalf2WordAtPtx3403R1264,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx416R1700, r_PackedHalf2AtPtx415R1699); // PTX L3403
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3410R1267, r_MmaAccumulatorHalf2WordAtPtx3410R1268,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx414R1698, r_PackedHalf2AtPtx413R1697); // PTX L3410
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3417R1261, r_MmaAccumulatorHalf2WordAtPtx3417R1262,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx3403R1263,
			r_MmaAccumulatorHalf2WordAtPtx3403R1264); // PTX L3417
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3424R1265, r_MmaAccumulatorHalf2WordAtPtx3424R1266,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx3410R1267,
			r_MmaAccumulatorHalf2WordAtPtx3410R1268); // PTX L3424
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3431R1271, r_MmaAccumulatorHalf2WordAtPtx3431R1272,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx412R1696, r_PackedHalf2AtPtx411R1695); // PTX L3431
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3438R1275, r_MmaAccumulatorHalf2WordAtPtx3438R1276,
			r_MmaAHalf2WordAtPtx3092R1237, r_MmaAHalf2WordAtPtx3092R1238, r_MmaAHalf2WordAtPtx3092R1239,
			r_MmaAHalf2WordAtPtx3092R1240, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx410R1694, r_PackedHalf2AtPtx409R1693); // PTX L3438
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3445R1269, r_MmaAccumulatorHalf2WordAtPtx3445R1270,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx3431R1271,
			r_MmaAccumulatorHalf2WordAtPtx3431R1272); // PTX L3445
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3452R1273, r_MmaAccumulatorHalf2WordAtPtx3452R1274,
			r_MmaAHalf2WordAtPtx3101R1243, r_MmaAHalf2WordAtPtx3101R1244, r_MmaAHalf2WordAtPtx3101R1245,
			r_MmaAHalf2WordAtPtx3101R1246, r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx3438R1275,
			r_MmaAccumulatorHalf2WordAtPtx3438R1276); // PTX L3452
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3459R1287, r_MmaAccumulatorHalf2WordAtPtx3459R1288,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx76R1742, r_MmaBHalf2WordAtPtx76R1743,
			r_PackedHalf2AtPtx408R1692, r_PackedHalf2AtPtx407R1691); // PTX L3459
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3466R1291, r_MmaAccumulatorHalf2WordAtPtx3466R1292,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx76R1744, r_MmaBHalf2WordAtPtx76R1745,
			r_PackedHalf2AtPtx406R1690, r_PackedHalf2AtPtx405R1689); // PTX L3466
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3473R1281, r_MmaAccumulatorHalf2WordAtPtx3473R1282,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx115R1758, r_MmaBHalf2WordAtPtx115R1759,
			r_MmaAccumulatorHalf2WordAtPtx3459R1287,
			r_MmaAccumulatorHalf2WordAtPtx3459R1288); // PTX L3473
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3480R1289, r_MmaAccumulatorHalf2WordAtPtx3480R1290,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx115R1760, r_MmaBHalf2WordAtPtx115R1761,
			r_MmaAccumulatorHalf2WordAtPtx3466R1291,
			r_MmaAccumulatorHalf2WordAtPtx3466R1292); // PTX L3480
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3487R1295, r_MmaAccumulatorHalf2WordAtPtx3487R1296,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx86R1746, r_MmaBHalf2WordAtPtx86R1747,
			r_PackedHalf2AtPtx404R1688, r_PackedHalf2AtPtx403R1687); // PTX L3487
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3494R1299, r_MmaAccumulatorHalf2WordAtPtx3494R1300,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx86R1748, r_MmaBHalf2WordAtPtx86R1749,
			r_PackedHalf2AtPtx402R1686, r_PackedHalf2AtPtx401R1685); // PTX L3494
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3501R1293, r_MmaAccumulatorHalf2WordAtPtx3501R1294,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx124R1762, r_MmaBHalf2WordAtPtx124R1763,
			r_MmaAccumulatorHalf2WordAtPtx3487R1295,
			r_MmaAccumulatorHalf2WordAtPtx3487R1296); // PTX L3501
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3508R1297, r_MmaAccumulatorHalf2WordAtPtx3508R1298,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx124R1764, r_MmaBHalf2WordAtPtx124R1765,
			r_MmaAccumulatorHalf2WordAtPtx3494R1299,
			r_MmaAccumulatorHalf2WordAtPtx3494R1300); // PTX L3508
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3515R1303, r_MmaAccumulatorHalf2WordAtPtx3515R1304,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx96R1750, r_MmaBHalf2WordAtPtx96R1751,
			r_PackedHalf2AtPtx400R1684, r_PackedHalf2AtPtx399R1683); // PTX L3515
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3522R1307, r_MmaAccumulatorHalf2WordAtPtx3522R1308,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx96R1752, r_MmaBHalf2WordAtPtx96R1753,
			r_PackedHalf2AtPtx398R1682, r_PackedHalf2AtPtx397R1681); // PTX L3522
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3529R1301, r_MmaAccumulatorHalf2WordAtPtx3529R1302,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx133R1766, r_MmaBHalf2WordAtPtx133R1767,
			r_MmaAccumulatorHalf2WordAtPtx3515R1303,
			r_MmaAccumulatorHalf2WordAtPtx3515R1304); // PTX L3529
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3536R1305, r_MmaAccumulatorHalf2WordAtPtx3536R1306,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx133R1768, r_MmaBHalf2WordAtPtx133R1769,
			r_MmaAccumulatorHalf2WordAtPtx3522R1307,
			r_MmaAccumulatorHalf2WordAtPtx3522R1308); // PTX L3536
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3543R1311, r_MmaAccumulatorHalf2WordAtPtx3543R1312,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx106R1754, r_MmaBHalf2WordAtPtx106R1755,
			r_PackedHalf2AtPtx396R1680, r_PackedHalf2AtPtx395R1679); // PTX L3543
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3550R1315, r_MmaAccumulatorHalf2WordAtPtx3550R1316,
			r_MmaAHalf2WordAtPtx3111R1277, r_MmaAHalf2WordAtPtx3111R1278, r_MmaAHalf2WordAtPtx3111R1279,
			r_MmaAHalf2WordAtPtx3111R1280, r_MmaBHalf2WordAtPtx106R1756, r_MmaBHalf2WordAtPtx106R1757,
			r_PackedHalf2AtPtx394R1678, r_PackedHalf2AtPtx393R1677); // PTX L3550
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3557R1309, r_MmaAccumulatorHalf2WordAtPtx3557R1310,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx142R1770, r_MmaBHalf2WordAtPtx142R1771,
			r_MmaAccumulatorHalf2WordAtPtx3543R1311,
			r_MmaAccumulatorHalf2WordAtPtx3543R1312); // PTX L3557
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3564R1313, r_MmaAccumulatorHalf2WordAtPtx3564R1314,
			r_MmaAHalf2WordAtPtx3120R1283, r_MmaAHalf2WordAtPtx3120R1284, r_MmaAHalf2WordAtPtx3120R1285,
			r_MmaAHalf2WordAtPtx3120R1286, r_MmaBHalf2WordAtPtx142R1772, r_MmaBHalf2WordAtPtx142R1773,
			r_MmaAccumulatorHalf2WordAtPtx3550R1315,
			r_MmaAccumulatorHalf2WordAtPtx3550R1316);										   // PTX L3564
	r_PtxRegister1338 = uint32_t(r_PtxRegister3) + uint32_t(r_PtxRegister2);				   // PTX L3570
	r_PtxU64Register273 = uint64_t(int64_t(int32_t(r_PtxRegister1338)) * int64_t(int32_t(4))); // PTX L3571
	g_CounterByteAddress = uint64_t(g_CounterBaseAddress) + uint64_t(r_PtxU64Register273);	   // PTX L3572
	if (r_bPtxPredicate67)
	{
		goto L__BB56_127;
	} // PTX L3573
	r_ThreadZAtPtx3574 = uint32_t(threadIdx.z);						// PTX L3574
	r_PtxRegister1340 = r_PtxRegister66 | r_ThreadZAtPtx3574;		// PTX L3575
	r_bPtxPredicate68 = uint32_t(r_PtxRegister1340) != uint32_t(0); // PTX L3576
	if (r_bPtxPredicate68)
	{
		goto L__BB56_143;
	} // PTX L3577
	goto L__BB56_124;									// PTX L3578
L__BB56_143:											// PTX L3579
	__syncthreads();									// PTX L3580
	r_bPtxPredicate70 = uint32_t(r_CtaZ) < uint32_t(3); // PTX L3581
	if (r_bPtxPredicate70)
	{
		goto L__BB56_135;
	} // PTX L3582
	goto L__BB56_144;														  // PTX L3583
L__BB56_135:																  // PTX L3584
	r_PtxRegister42 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister3);	  // PTX L3585
	r_bPtxPredicate106 = int32_t(r_PtxRegister42) >= int32_t(r_PtxRegister4); // PTX L3586
	if (r_bPtxPredicate106)
	{
		goto L__BB56_137;
	} // PTX L3587
	r_PtxRegister1540 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(13));						  // PTX L3588
	r_PtxRegister1541 = uint32_t(r_PtxRegister1540) + uint32_t(r_PtxRegister6);					  // PTX L3589
	r_PtxU64Register388 = SignExtendWordBits(r_PtxRegister1541);								  // PTX L3590
	r_LaneIndexAtPtx3592 = uint32_t((threadIdx.x & 31u));										  // PTX L3592
	r_PtxU64Register389 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3592)) * int64_t(int32_t(4))); // PTX L3594
	r_PtxU64Register390 = uint64_t(r_PtxU64Register389) + uint64_t(r_PtxU64Register388);		  // PTX L3595
	r_PtxU64Register391 = ShiftLeft(uint64_t(r_PtxU64Register390), uint32_t(2));				  // PTX L3596
	r_PtxU64Register384 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register391);		  // PTX L3597
	ReduceHalf4(r_PtxU64Register384,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3137R1161, r_MmaAccumulatorHalf2WordAtPtx3137R1162,
						   r_MmaAccumulatorHalf2WordAtPtx3144R1169,
						   r_MmaAccumulatorHalf2WordAtPtx3144R1170));							  // PTX L3599
	r_PtxRegister1542 = uint32_t(r_PtxRegister1541) + uint32_t(128);							  // PTX L3601
	r_PtxU64Register392 = SignExtendWordBits(r_PtxRegister1542);								  // PTX L3602
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));										  // PTX L3604
	r_PtxU64Register393 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3604)) * int64_t(int32_t(4))); // PTX L3606
	r_PtxU64Register394 = uint64_t(r_PtxU64Register393) + uint64_t(r_PtxU64Register392);		  // PTX L3607
	r_PtxU64Register395 = ShiftLeft(uint64_t(r_PtxU64Register394), uint32_t(2));				  // PTX L3608
	r_PtxU64Register385 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register395);		  // PTX L3609
	ReduceHalf4(r_PtxU64Register385,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3165R1173, r_MmaAccumulatorHalf2WordAtPtx3165R1174,
						   r_MmaAccumulatorHalf2WordAtPtx3172R1177,
						   r_MmaAccumulatorHalf2WordAtPtx3172R1178));							  // PTX L3611
	r_PtxRegister1543 = uint32_t(r_PtxRegister1541) + uint32_t(256);							  // PTX L3613
	r_PtxU64Register396 = SignExtendWordBits(r_PtxRegister1543);								  // PTX L3614
	r_LaneIndexAtPtx3616 = uint32_t((threadIdx.x & 31u));										  // PTX L3616
	r_PtxU64Register397 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3616)) * int64_t(int32_t(4))); // PTX L3618
	r_PtxU64Register398 = uint64_t(r_PtxU64Register397) + uint64_t(r_PtxU64Register396);		  // PTX L3619
	r_PtxU64Register399 = ShiftLeft(uint64_t(r_PtxU64Register398), uint32_t(2));				  // PTX L3620
	r_PtxU64Register386 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register399);		  // PTX L3621
	ReduceHalf4(r_PtxU64Register386,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3193R1181, r_MmaAccumulatorHalf2WordAtPtx3193R1182,
						   r_MmaAccumulatorHalf2WordAtPtx3200R1185,
						   r_MmaAccumulatorHalf2WordAtPtx3200R1186));							  // PTX L3623
	r_PtxRegister1544 = uint32_t(r_PtxRegister1541) + uint32_t(384);							  // PTX L3625
	r_PtxU64Register400 = SignExtendWordBits(r_PtxRegister1544);								  // PTX L3626
	r_LaneIndexAtPtx3628 = uint32_t((threadIdx.x & 31u));										  // PTX L3628
	r_PtxU64Register401 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3628)) * int64_t(int32_t(4))); // PTX L3630
	r_PtxU64Register402 = uint64_t(r_PtxU64Register401) + uint64_t(r_PtxU64Register400);		  // PTX L3631
	r_PtxU64Register403 = ShiftLeft(uint64_t(r_PtxU64Register402), uint32_t(2));				  // PTX L3632
	r_PtxU64Register387 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register403);		  // PTX L3633
	ReduceHalf4(r_PtxU64Register387,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3221R1189, r_MmaAccumulatorHalf2WordAtPtx3221R1190,
						   r_MmaAccumulatorHalf2WordAtPtx3228R1193,
						   r_MmaAccumulatorHalf2WordAtPtx3228R1194));		  // PTX L3635
L__BB56_137:																  // PTX L3637
	r_PtxRegister43 = uint32_t(r_PtxRegister42) + uint32_t(1);				  // PTX L3638
	r_bPtxPredicate107 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister4); // PTX L3639
	if (r_bPtxPredicate107)
	{
		goto L__BB56_139;
	} // PTX L3640
	r_PtxRegister1549 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(13));						  // PTX L3641
	r_PtxRegister1550 = uint32_t(r_PtxRegister1549) + uint32_t(r_PtxRegister6);					  // PTX L3642
	r_PtxU64Register408 = SignExtendWordBits(r_PtxRegister1550);								  // PTX L3643
	r_LaneIndexAtPtx3645 = uint32_t((threadIdx.x & 31u));										  // PTX L3645
	r_PtxU64Register409 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3645)) * int64_t(int32_t(4))); // PTX L3647
	r_PtxU64Register410 = uint64_t(r_PtxU64Register409) + uint64_t(r_PtxU64Register408);		  // PTX L3648
	r_PtxU64Register411 = ShiftLeft(uint64_t(r_PtxU64Register410), uint32_t(2));				  // PTX L3649
	r_PtxU64Register404 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register411);		  // PTX L3650
	ReduceHalf4(r_PtxU64Register404,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3249R1201, r_MmaAccumulatorHalf2WordAtPtx3249R1202,
						   r_MmaAccumulatorHalf2WordAtPtx3256R1209,
						   r_MmaAccumulatorHalf2WordAtPtx3256R1210));							  // PTX L3652
	r_PtxRegister1551 = uint32_t(r_PtxRegister1550) + uint32_t(128);							  // PTX L3654
	r_PtxU64Register412 = SignExtendWordBits(r_PtxRegister1551);								  // PTX L3655
	r_LaneIndexAtPtx3657 = uint32_t((threadIdx.x & 31u));										  // PTX L3657
	r_PtxU64Register413 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3657)) * int64_t(int32_t(4))); // PTX L3659
	r_PtxU64Register414 = uint64_t(r_PtxU64Register413) + uint64_t(r_PtxU64Register412);		  // PTX L3660
	r_PtxU64Register415 = ShiftLeft(uint64_t(r_PtxU64Register414), uint32_t(2));				  // PTX L3661
	r_PtxU64Register405 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register415);		  // PTX L3662
	ReduceHalf4(r_PtxU64Register405,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3277R1213, r_MmaAccumulatorHalf2WordAtPtx3277R1214,
						   r_MmaAccumulatorHalf2WordAtPtx3284R1217,
						   r_MmaAccumulatorHalf2WordAtPtx3284R1218));							  // PTX L3664
	r_PtxRegister1552 = uint32_t(r_PtxRegister1550) + uint32_t(256);							  // PTX L3666
	r_PtxU64Register416 = SignExtendWordBits(r_PtxRegister1552);								  // PTX L3667
	r_LaneIndexAtPtx3669 = uint32_t((threadIdx.x & 31u));										  // PTX L3669
	r_PtxU64Register417 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3669)) * int64_t(int32_t(4))); // PTX L3671
	r_PtxU64Register418 = uint64_t(r_PtxU64Register417) + uint64_t(r_PtxU64Register416);		  // PTX L3672
	r_PtxU64Register419 = ShiftLeft(uint64_t(r_PtxU64Register418), uint32_t(2));				  // PTX L3673
	r_PtxU64Register406 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register419);		  // PTX L3674
	ReduceHalf4(r_PtxU64Register406,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3305R1221, r_MmaAccumulatorHalf2WordAtPtx3305R1222,
						   r_MmaAccumulatorHalf2WordAtPtx3312R1225,
						   r_MmaAccumulatorHalf2WordAtPtx3312R1226));							  // PTX L3676
	r_PtxRegister1553 = uint32_t(r_PtxRegister1550) + uint32_t(384);							  // PTX L3678
	r_PtxU64Register420 = SignExtendWordBits(r_PtxRegister1553);								  // PTX L3679
	r_LaneIndexAtPtx3681 = uint32_t((threadIdx.x & 31u));										  // PTX L3681
	r_PtxU64Register421 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3681)) * int64_t(int32_t(4))); // PTX L3683
	r_PtxU64Register422 = uint64_t(r_PtxU64Register421) + uint64_t(r_PtxU64Register420);		  // PTX L3684
	r_PtxU64Register423 = ShiftLeft(uint64_t(r_PtxU64Register422), uint32_t(2));				  // PTX L3685
	r_PtxU64Register407 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register423);		  // PTX L3686
	ReduceHalf4(r_PtxU64Register407,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3333R1229, r_MmaAccumulatorHalf2WordAtPtx3333R1230,
						   r_MmaAccumulatorHalf2WordAtPtx3340R1233,
						   r_MmaAccumulatorHalf2WordAtPtx3340R1234));		  // PTX L3688
L__BB56_139:																  // PTX L3690
	r_PtxRegister44 = uint32_t(r_PtxRegister42) + uint32_t(2);				  // PTX L3691
	r_bPtxPredicate108 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister4); // PTX L3692
	if (r_bPtxPredicate108)
	{
		goto L__BB56_141;
	} // PTX L3693
	r_PtxRegister1558 = ShiftLeft(uint32_t(r_PtxRegister44), uint32_t(13));						  // PTX L3694
	r_PtxRegister1559 = uint32_t(r_PtxRegister1558) + uint32_t(r_PtxRegister6);					  // PTX L3695
	r_PtxU64Register428 = SignExtendWordBits(r_PtxRegister1559);								  // PTX L3696
	r_LaneIndexAtPtx3698 = uint32_t((threadIdx.x & 31u));										  // PTX L3698
	r_PtxU64Register429 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3698)) * int64_t(int32_t(4))); // PTX L3700
	r_PtxU64Register430 = uint64_t(r_PtxU64Register429) + uint64_t(r_PtxU64Register428);		  // PTX L3701
	r_PtxU64Register431 = ShiftLeft(uint64_t(r_PtxU64Register430), uint32_t(2));				  // PTX L3702
	r_PtxU64Register424 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register431);		  // PTX L3703
	ReduceHalf4(r_PtxU64Register424,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3361R1241, r_MmaAccumulatorHalf2WordAtPtx3361R1242,
						   r_MmaAccumulatorHalf2WordAtPtx3368R1249,
						   r_MmaAccumulatorHalf2WordAtPtx3368R1250));							  // PTX L3705
	r_PtxRegister1560 = uint32_t(r_PtxRegister1559) + uint32_t(128);							  // PTX L3707
	r_PtxU64Register432 = SignExtendWordBits(r_PtxRegister1560);								  // PTX L3708
	r_LaneIndexAtPtx3710 = uint32_t((threadIdx.x & 31u));										  // PTX L3710
	r_PtxU64Register433 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3710)) * int64_t(int32_t(4))); // PTX L3712
	r_PtxU64Register434 = uint64_t(r_PtxU64Register433) + uint64_t(r_PtxU64Register432);		  // PTX L3713
	r_PtxU64Register435 = ShiftLeft(uint64_t(r_PtxU64Register434), uint32_t(2));				  // PTX L3714
	r_PtxU64Register425 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register435);		  // PTX L3715
	ReduceHalf4(r_PtxU64Register425,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3389R1253, r_MmaAccumulatorHalf2WordAtPtx3389R1254,
						   r_MmaAccumulatorHalf2WordAtPtx3396R1257,
						   r_MmaAccumulatorHalf2WordAtPtx3396R1258));							  // PTX L3717
	r_PtxRegister1561 = uint32_t(r_PtxRegister1559) + uint32_t(256);							  // PTX L3719
	r_PtxU64Register436 = SignExtendWordBits(r_PtxRegister1561);								  // PTX L3720
	r_LaneIndexAtPtx3722 = uint32_t((threadIdx.x & 31u));										  // PTX L3722
	r_PtxU64Register437 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3722)) * int64_t(int32_t(4))); // PTX L3724
	r_PtxU64Register438 = uint64_t(r_PtxU64Register437) + uint64_t(r_PtxU64Register436);		  // PTX L3725
	r_PtxU64Register439 = ShiftLeft(uint64_t(r_PtxU64Register438), uint32_t(2));				  // PTX L3726
	r_PtxU64Register426 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register439);		  // PTX L3727
	ReduceHalf4(r_PtxU64Register426,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3417R1261, r_MmaAccumulatorHalf2WordAtPtx3417R1262,
						   r_MmaAccumulatorHalf2WordAtPtx3424R1265,
						   r_MmaAccumulatorHalf2WordAtPtx3424R1266));							  // PTX L3729
	r_PtxRegister1562 = uint32_t(r_PtxRegister1559) + uint32_t(384);							  // PTX L3731
	r_PtxU64Register440 = SignExtendWordBits(r_PtxRegister1562);								  // PTX L3732
	r_LaneIndexAtPtx3734 = uint32_t((threadIdx.x & 31u));										  // PTX L3734
	r_PtxU64Register441 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3734)) * int64_t(int32_t(4))); // PTX L3736
	r_PtxU64Register442 = uint64_t(r_PtxU64Register441) + uint64_t(r_PtxU64Register440);		  // PTX L3737
	r_PtxU64Register443 = ShiftLeft(uint64_t(r_PtxU64Register442), uint32_t(2));				  // PTX L3738
	r_PtxU64Register427 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register443);		  // PTX L3739
	ReduceHalf4(r_PtxU64Register427,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3445R1269, r_MmaAccumulatorHalf2WordAtPtx3445R1270,
						   r_MmaAccumulatorHalf2WordAtPtx3452R1273,
						   r_MmaAccumulatorHalf2WordAtPtx3452R1274));		  // PTX L3741
L__BB56_141:																  // PTX L3743
	r_PtxRegister45 = uint32_t(r_PtxRegister42) + uint32_t(3);				  // PTX L3744
	r_bPtxPredicate109 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister4); // PTX L3745
	if (r_bPtxPredicate109)
	{
		goto L__BB56_200;
	} // PTX L3746
	r_PtxRegister1567 = ShiftLeft(uint32_t(r_PtxRegister45), uint32_t(13));						  // PTX L3747
	r_PtxRegister1568 = uint32_t(r_PtxRegister1567) + uint32_t(r_PtxRegister6);					  // PTX L3748
	r_PtxU64Register448 = SignExtendWordBits(r_PtxRegister1568);								  // PTX L3749
	r_LaneIndexAtPtx3751 = uint32_t((threadIdx.x & 31u));										  // PTX L3751
	r_PtxU64Register449 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3751)) * int64_t(int32_t(4))); // PTX L3753
	r_PtxU64Register450 = uint64_t(r_PtxU64Register449) + uint64_t(r_PtxU64Register448);		  // PTX L3754
	r_PtxU64Register451 = ShiftLeft(uint64_t(r_PtxU64Register450), uint32_t(2));				  // PTX L3755
	r_PtxU64Register444 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register451);		  // PTX L3756
	ReduceHalf4(r_PtxU64Register444,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3473R1281, r_MmaAccumulatorHalf2WordAtPtx3473R1282,
						   r_MmaAccumulatorHalf2WordAtPtx3480R1289,
						   r_MmaAccumulatorHalf2WordAtPtx3480R1290));							  // PTX L3758
	r_PtxRegister1569 = uint32_t(r_PtxRegister1568) + uint32_t(128);							  // PTX L3760
	r_PtxU64Register452 = SignExtendWordBits(r_PtxRegister1569);								  // PTX L3761
	r_LaneIndexAtPtx3763 = uint32_t((threadIdx.x & 31u));										  // PTX L3763
	r_PtxU64Register453 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3763)) * int64_t(int32_t(4))); // PTX L3765
	r_PtxU64Register454 = uint64_t(r_PtxU64Register453) + uint64_t(r_PtxU64Register452);		  // PTX L3766
	r_PtxU64Register455 = ShiftLeft(uint64_t(r_PtxU64Register454), uint32_t(2));				  // PTX L3767
	r_PtxU64Register445 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register455);		  // PTX L3768
	ReduceHalf4(r_PtxU64Register445,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3501R1293, r_MmaAccumulatorHalf2WordAtPtx3501R1294,
						   r_MmaAccumulatorHalf2WordAtPtx3508R1297,
						   r_MmaAccumulatorHalf2WordAtPtx3508R1298));							  // PTX L3770
	r_PtxRegister1570 = uint32_t(r_PtxRegister1568) + uint32_t(256);							  // PTX L3772
	r_PtxU64Register456 = SignExtendWordBits(r_PtxRegister1570);								  // PTX L3773
	r_LaneIndexAtPtx3775 = uint32_t((threadIdx.x & 31u));										  // PTX L3775
	r_PtxU64Register457 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3775)) * int64_t(int32_t(4))); // PTX L3777
	r_PtxU64Register458 = uint64_t(r_PtxU64Register457) + uint64_t(r_PtxU64Register456);		  // PTX L3778
	r_PtxU64Register459 = ShiftLeft(uint64_t(r_PtxU64Register458), uint32_t(2));				  // PTX L3779
	r_PtxU64Register446 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register459);		  // PTX L3780
	ReduceHalf4(r_PtxU64Register446,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3529R1301, r_MmaAccumulatorHalf2WordAtPtx3529R1302,
						   r_MmaAccumulatorHalf2WordAtPtx3536R1305,
						   r_MmaAccumulatorHalf2WordAtPtx3536R1306));							  // PTX L3782
	r_PtxRegister1571 = uint32_t(r_PtxRegister1568) + uint32_t(384);							  // PTX L3784
	r_PtxU64Register460 = SignExtendWordBits(r_PtxRegister1571);								  // PTX L3785
	r_LaneIndexAtPtx3787 = uint32_t((threadIdx.x & 31u));										  // PTX L3787
	r_PtxU64Register461 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3787)) * int64_t(int32_t(4))); // PTX L3789
	r_PtxU64Register462 = uint64_t(r_PtxU64Register461) + uint64_t(r_PtxU64Register460);		  // PTX L3790
	r_PtxU64Register463 = ShiftLeft(uint64_t(r_PtxU64Register462), uint32_t(2));				  // PTX L3791
	r_PtxU64Register447 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register463);		  // PTX L3792
	ReduceHalf4(r_PtxU64Register447,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3557R1309, r_MmaAccumulatorHalf2WordAtPtx3557R1310,
						   r_MmaAccumulatorHalf2WordAtPtx3564R1313,
						   r_MmaAccumulatorHalf2WordAtPtx3564R1314));							  // PTX L3794
	goto L__BB56_200;																			  // PTX L3796
L__BB56_127:																					  // PTX L3797
	r_PtxRegister41 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister3);						  // PTX L3798
	r_bPtxPredicate110 = int32_t(r_PtxRegister41) >= int32_t(r_PtxRegister4);					  // PTX L3799
	r_PtxRegister1573 = ShiftLeft(uint32_t(r_PtxRegister41), uint32_t(13));						  // PTX L3800
	r_PtxRegister1574 = uint32_t(r_PtxRegister1573) + uint32_t(r_PtxRegister6);					  // PTX L3801
	r_PtxU64Register464 = uint64_t(int64_t(int32_t(r_PtxRegister1574)) * int64_t(int32_t(4)));	  // PTX L3802
	g_OutputByteAddressAtPtx3803 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register464); // PTX L3803
	if (r_bPtxPredicate110)
	{
		goto L__BB56_129;
	} // PTX L3804
	r_LaneIndexAtPtx3806 = uint32_t((threadIdx.x & 31u)); // PTX L3806
	r_PtxU64Register469 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3806)) * int64_t(int32_t(16))); // PTX L3808
	g_OutputByteAddressAtPtx3809 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register469); // PTX L3809
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3809,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3137R1161,
							   r_MmaAccumulatorHalf2WordAtPtx3137R1162,
							   r_MmaAccumulatorHalf2WordAtPtx3144R1169,
							   r_MmaAccumulatorHalf2WordAtPtx3144R1170)); // PTX L3811
	r_LaneIndexAtPtx3814 = uint32_t((threadIdx.x & 31u));				  // PTX L3814
	r_PtxU64Register470 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3814)) * int64_t(int32_t(16))); // PTX L3816
	g_OutputByteAddressAtPtx3817 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register470);			   // PTX L3817
	g_OutputByteAddressAtPtx3818 = uint64_t(g_OutputByteAddressAtPtx3817) + uint64_t(512); // PTX L3818
	StoreNoAllocate(g_OutputByteAddressAtPtx3818,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3165R1173,
							   r_MmaAccumulatorHalf2WordAtPtx3165R1174,
							   r_MmaAccumulatorHalf2WordAtPtx3172R1177,
							   r_MmaAccumulatorHalf2WordAtPtx3172R1178)); // PTX L3820
	r_LaneIndexAtPtx3823 = uint32_t((threadIdx.x & 31u));				  // PTX L3823
	r_PtxU64Register472 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3823)) * int64_t(int32_t(16))); // PTX L3825
	g_OutputByteAddressAtPtx3826 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register472);				// PTX L3826
	g_OutputByteAddressAtPtx3827 = uint64_t(g_OutputByteAddressAtPtx3826) + uint64_t(1024); // PTX L3827
	StoreNoAllocate(g_OutputByteAddressAtPtx3827,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3193R1181,
							   r_MmaAccumulatorHalf2WordAtPtx3193R1182,
							   r_MmaAccumulatorHalf2WordAtPtx3200R1185,
							   r_MmaAccumulatorHalf2WordAtPtx3200R1186)); // PTX L3829
	r_LaneIndexAtPtx3832 = uint32_t((threadIdx.x & 31u));				  // PTX L3832
	r_PtxU64Register474 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3832)) * int64_t(int32_t(16))); // PTX L3834
	g_OutputByteAddressAtPtx3835 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register474);				// PTX L3835
	g_OutputByteAddressAtPtx3836 = uint64_t(g_OutputByteAddressAtPtx3835) + uint64_t(1536); // PTX L3836
	StoreNoAllocate(g_OutputByteAddressAtPtx3836,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3221R1189,
							   r_MmaAccumulatorHalf2WordAtPtx3221R1190,
							   r_MmaAccumulatorHalf2WordAtPtx3228R1193,
							   r_MmaAccumulatorHalf2WordAtPtx3228R1194));					 // PTX L3838
L__BB56_129:																				 // PTX L3840
	r_PtxRegister1579 = uint32_t(r_PtxRegister41) + uint32_t(1);							 // PTX L3841
	r_bPtxPredicate111 = int32_t(r_PtxRegister1579) >= int32_t(r_PtxRegister4);				 // PTX L3842
	g_OutputByteAddressAtPtx3843 = uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(32768); // PTX L3843
	if (r_bPtxPredicate111)
	{
		goto L__BB56_131;
	} // PTX L3844
	r_LaneIndexAtPtx3846 = uint32_t((threadIdx.x & 31u)); // PTX L3846
	r_PtxU64Register480 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3846)) * int64_t(int32_t(16))); // PTX L3848
	g_OutputByteAddressAtPtx3849 =
		uint64_t(g_OutputByteAddressAtPtx3843) + uint64_t(r_PtxU64Register480); // PTX L3849
	StoreNoAllocate(g_OutputByteAddressAtPtx3849,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3249R1201,
							   r_MmaAccumulatorHalf2WordAtPtx3249R1202,
							   r_MmaAccumulatorHalf2WordAtPtx3256R1209,
							   r_MmaAccumulatorHalf2WordAtPtx3256R1210)); // PTX L3851
	r_LaneIndexAtPtx3854 = uint32_t((threadIdx.x & 31u));				  // PTX L3854
	r_PtxU64Register481 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3854)) * int64_t(int32_t(16))); // PTX L3856
	g_OutputByteAddressAtPtx3857 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register481);				 // PTX L3857
	g_OutputByteAddressAtPtx3858 = uint64_t(g_OutputByteAddressAtPtx3857) + uint64_t(33280); // PTX L3858
	StoreNoAllocate(g_OutputByteAddressAtPtx3858,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3277R1213,
							   r_MmaAccumulatorHalf2WordAtPtx3277R1214,
							   r_MmaAccumulatorHalf2WordAtPtx3284R1217,
							   r_MmaAccumulatorHalf2WordAtPtx3284R1218)); // PTX L3860
	r_LaneIndexAtPtx3863 = uint32_t((threadIdx.x & 31u));				  // PTX L3863
	r_PtxU64Register483 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3863)) * int64_t(int32_t(16))); // PTX L3865
	g_OutputByteAddressAtPtx3866 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register483);				 // PTX L3866
	g_OutputByteAddressAtPtx3867 = uint64_t(g_OutputByteAddressAtPtx3866) + uint64_t(33792); // PTX L3867
	StoreNoAllocate(g_OutputByteAddressAtPtx3867,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3305R1221,
							   r_MmaAccumulatorHalf2WordAtPtx3305R1222,
							   r_MmaAccumulatorHalf2WordAtPtx3312R1225,
							   r_MmaAccumulatorHalf2WordAtPtx3312R1226)); // PTX L3869
	r_LaneIndexAtPtx3872 = uint32_t((threadIdx.x & 31u));				  // PTX L3872
	r_PtxU64Register485 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3872)) * int64_t(int32_t(16))); // PTX L3874
	g_OutputByteAddressAtPtx3875 =
		uint64_t(g_OutputByteAddressAtPtx3803) + uint64_t(r_PtxU64Register485);				 // PTX L3875
	g_OutputByteAddressAtPtx3876 = uint64_t(g_OutputByteAddressAtPtx3875) + uint64_t(34304); // PTX L3876
	StoreNoAllocate(g_OutputByteAddressAtPtx3876,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3333R1229,
							   r_MmaAccumulatorHalf2WordAtPtx3333R1230,
							   r_MmaAccumulatorHalf2WordAtPtx3340R1233,
							   r_MmaAccumulatorHalf2WordAtPtx3340R1234));					 // PTX L3878
L__BB56_131:																				 // PTX L3880
	r_PtxRegister1584 = uint32_t(r_PtxRegister41) + uint32_t(2);							 // PTX L3881
	r_bPtxPredicate112 = int32_t(r_PtxRegister1584) >= int32_t(r_PtxRegister4);				 // PTX L3882
	g_OutputByteAddressAtPtx3883 = uint64_t(g_OutputByteAddressAtPtx3843) + uint64_t(32768); // PTX L3883
	if (r_bPtxPredicate112)
	{
		goto L__BB56_133;
	} // PTX L3884
	r_LaneIndexAtPtx3886 = uint32_t((threadIdx.x & 31u)); // PTX L3886
	r_PtxU64Register491 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3886)) * int64_t(int32_t(16))); // PTX L3888
	g_OutputByteAddressAtPtx3889 =
		uint64_t(g_OutputByteAddressAtPtx3883) + uint64_t(r_PtxU64Register491); // PTX L3889
	StoreNoAllocate(g_OutputByteAddressAtPtx3889,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3361R1241,
							   r_MmaAccumulatorHalf2WordAtPtx3361R1242,
							   r_MmaAccumulatorHalf2WordAtPtx3368R1249,
							   r_MmaAccumulatorHalf2WordAtPtx3368R1250)); // PTX L3891
	r_LaneIndexAtPtx3894 = uint32_t((threadIdx.x & 31u));				  // PTX L3894
	r_PtxU64Register492 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3894)) * int64_t(int32_t(16))); // PTX L3896
	g_OutputByteAddressAtPtx3897 =
		uint64_t(g_OutputByteAddressAtPtx3843) + uint64_t(r_PtxU64Register492);				 // PTX L3897
	g_OutputByteAddressAtPtx3898 = uint64_t(g_OutputByteAddressAtPtx3897) + uint64_t(33280); // PTX L3898
	StoreNoAllocate(g_OutputByteAddressAtPtx3898,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3389R1253,
							   r_MmaAccumulatorHalf2WordAtPtx3389R1254,
							   r_MmaAccumulatorHalf2WordAtPtx3396R1257,
							   r_MmaAccumulatorHalf2WordAtPtx3396R1258)); // PTX L3900
	r_LaneIndexAtPtx3903 = uint32_t((threadIdx.x & 31u));				  // PTX L3903
	r_PtxU64Register494 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3903)) * int64_t(int32_t(16))); // PTX L3905
	g_OutputByteAddressAtPtx3906 =
		uint64_t(g_OutputByteAddressAtPtx3843) + uint64_t(r_PtxU64Register494);				 // PTX L3906
	g_OutputByteAddressAtPtx3907 = uint64_t(g_OutputByteAddressAtPtx3906) + uint64_t(33792); // PTX L3907
	StoreNoAllocate(g_OutputByteAddressAtPtx3907,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3417R1261,
							   r_MmaAccumulatorHalf2WordAtPtx3417R1262,
							   r_MmaAccumulatorHalf2WordAtPtx3424R1265,
							   r_MmaAccumulatorHalf2WordAtPtx3424R1266)); // PTX L3909
	r_LaneIndexAtPtx3912 = uint32_t((threadIdx.x & 31u));				  // PTX L3912
	r_PtxU64Register496 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3912)) * int64_t(int32_t(16))); // PTX L3914
	g_OutputByteAddressAtPtx3915 =
		uint64_t(g_OutputByteAddressAtPtx3843) + uint64_t(r_PtxU64Register496);				 // PTX L3915
	g_OutputByteAddressAtPtx3916 = uint64_t(g_OutputByteAddressAtPtx3915) + uint64_t(34304); // PTX L3916
	StoreNoAllocate(g_OutputByteAddressAtPtx3916,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3445R1269,
							   r_MmaAccumulatorHalf2WordAtPtx3445R1270,
							   r_MmaAccumulatorHalf2WordAtPtx3452R1273,
							   r_MmaAccumulatorHalf2WordAtPtx3452R1274));		// PTX L3918
L__BB56_133:																	// PTX L3920
	r_PtxRegister1589 = uint32_t(r_PtxRegister41) + uint32_t(3);				// PTX L3921
	r_bPtxPredicate113 = int32_t(r_PtxRegister1589) >= int32_t(r_PtxRegister4); // PTX L3922
	if (r_bPtxPredicate113)
	{
		goto L__BB56_200;
	} // PTX L3923
	r_LaneIndexAtPtx3925 = uint32_t((threadIdx.x & 31u)); // PTX L3925
	r_PtxU64Register502 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3925)) * int64_t(int32_t(16))); // PTX L3927
	g_OutputByteAddressAtPtx3928 =
		uint64_t(g_OutputByteAddressAtPtx3883) + uint64_t(r_PtxU64Register502);				 // PTX L3928
	g_OutputByteAddressAtPtx3929 = uint64_t(g_OutputByteAddressAtPtx3928) + uint64_t(32768); // PTX L3929
	StoreNoAllocate(g_OutputByteAddressAtPtx3929,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3473R1281,
							   r_MmaAccumulatorHalf2WordAtPtx3473R1282,
							   r_MmaAccumulatorHalf2WordAtPtx3480R1289,
							   r_MmaAccumulatorHalf2WordAtPtx3480R1290)); // PTX L3931
	r_LaneIndexAtPtx3934 = uint32_t((threadIdx.x & 31u));				  // PTX L3934
	r_PtxU64Register504 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3934)) * int64_t(int32_t(16))); // PTX L3936
	g_OutputByteAddressAtPtx3937 =
		uint64_t(g_OutputByteAddressAtPtx3883) + uint64_t(r_PtxU64Register504);				 // PTX L3937
	g_OutputByteAddressAtPtx3938 = uint64_t(g_OutputByteAddressAtPtx3937) + uint64_t(33280); // PTX L3938
	StoreNoAllocate(g_OutputByteAddressAtPtx3938,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3501R1293,
							   r_MmaAccumulatorHalf2WordAtPtx3501R1294,
							   r_MmaAccumulatorHalf2WordAtPtx3508R1297,
							   r_MmaAccumulatorHalf2WordAtPtx3508R1298)); // PTX L3940
	r_LaneIndexAtPtx3943 = uint32_t((threadIdx.x & 31u));				  // PTX L3943
	r_PtxU64Register506 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3943)) * int64_t(int32_t(16))); // PTX L3945
	g_OutputByteAddressAtPtx3946 =
		uint64_t(g_OutputByteAddressAtPtx3883) + uint64_t(r_PtxU64Register506);				 // PTX L3946
	g_OutputByteAddressAtPtx3947 = uint64_t(g_OutputByteAddressAtPtx3946) + uint64_t(33792); // PTX L3947
	StoreNoAllocate(g_OutputByteAddressAtPtx3947,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3529R1301,
							   r_MmaAccumulatorHalf2WordAtPtx3529R1302,
							   r_MmaAccumulatorHalf2WordAtPtx3536R1305,
							   r_MmaAccumulatorHalf2WordAtPtx3536R1306)); // PTX L3949
	r_LaneIndexAtPtx3952 = uint32_t((threadIdx.x & 31u));				  // PTX L3952
	r_PtxU64Register508 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3952)) * int64_t(int32_t(16))); // PTX L3954
	g_OutputByteAddressAtPtx3955 =
		uint64_t(g_OutputByteAddressAtPtx3883) + uint64_t(r_PtxU64Register508);				 // PTX L3955
	g_OutputByteAddressAtPtx3956 = uint64_t(g_OutputByteAddressAtPtx3955) + uint64_t(34304); // PTX L3956
	StoreNoAllocate(g_OutputByteAddressAtPtx3956,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3557R1309,
							   r_MmaAccumulatorHalf2WordAtPtx3557R1310,
							   r_MmaAccumulatorHalf2WordAtPtx3564R1313,
							   r_MmaAccumulatorHalf2WordAtPtx3564R1314));	// PTX L3958
	goto L__BB56_200;														// PTX L3960
L__BB56_144:																// PTX L3961
	r_bPtxPredicate71 = uint32_t(r_PtxRegister24) < uint32_t(31);			// PTX L3962
	r_PtxRegister46 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister3); // PTX L3963
	r_PtxRegister1774 = uint32_t(0);										// PTX L3964
	if (r_bPtxPredicate71)
	{
		goto L__BB56_146;
	} // PTX L3965
	r_bPtxPredicate72 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister4); // PTX L3966
	r_PtxRegister1774 = uint32_t(r_PtxRegister46);							 // PTX L3967
	r_PackedHalf2AtPtx3968R1775 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3968
	r_PackedHalf2AtPtx3969R1776 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3969
	r_PackedHalf2AtPtx3970R1777 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3970
	r_PackedHalf2AtPtx3971R1778 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3971
	if (r_bPtxPredicate72)
	{
		goto L__BB56_147;
	} // PTX L3972
L__BB56_146:																					  // PTX L3973
	r_PtxRegister1343 = ShiftLeft(uint32_t(r_PtxRegister1774), uint32_t(13));					  // PTX L3974
	r_PtxRegister1344 = uint32_t(r_PtxRegister1343) + uint32_t(r_PtxRegister6);					  // PTX L3975
	r_PtxU64Register275 = uint64_t(int64_t(int32_t(r_PtxRegister1344)) * int64_t(int32_t(4)));	  // PTX L3976
	g_OutputByteAddressAtPtx3977 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register275); // PTX L3977
	r_LaneIndexAtPtx3979 = uint32_t((threadIdx.x & 31u));										  // PTX L3979
	r_PtxU64Register277 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3979)) * int64_t(int32_t(16))); // PTX L3981
	g_OutputByteAddressAtPtx3982 =
		uint64_t(g_OutputByteAddressAtPtx3977) + uint64_t(r_PtxU64Register277); // PTX L3982
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx3982));
		r_PackedHalf2AtPtx3968R1775 = r_Value.x;
		r_PackedHalf2AtPtx3969R1776 = r_Value.y;
		r_PackedHalf2AtPtx3970R1777 = r_Value.z;
		r_PackedHalf2AtPtx3971R1778 = r_Value.w;
	} // PTX L3984
L__BB56_147:													  // PTX L3986
	r_bPtxPredicate73 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L3987
	r_PtxRegister1779 = uint32_t(0);							  // PTX L3988
	if (r_bPtxPredicate73)
	{
		goto L__BB56_149;
	} // PTX L3989
	r_bPtxPredicate74 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister4); // PTX L3990
	r_PtxRegister1779 = uint32_t(r_PtxRegister46);							 // PTX L3991
	r_PackedHalf2AtPtx3992R1780 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3992
	r_PackedHalf2AtPtx3993R1781 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3993
	r_PackedHalf2AtPtx3994R1782 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3994
	r_PackedHalf2AtPtx3995R1783 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L3995
	if (r_bPtxPredicate74)
	{
		goto L__BB56_150;
	} // PTX L3996
L__BB56_149:																					  // PTX L3997
	r_PtxRegister1346 = ShiftLeft(uint32_t(r_PtxRegister1779), uint32_t(13));					  // PTX L3998
	r_PtxRegister1347 = uint32_t(r_PtxRegister1346) + uint32_t(r_PtxRegister7);					  // PTX L3999
	r_PtxU64Register279 = uint64_t(int64_t(int32_t(r_PtxRegister1347)) * int64_t(int32_t(4)));	  // PTX L4000
	g_OutputByteAddressAtPtx4001 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register279); // PTX L4001
	r_LaneIndexAtPtx4003 = uint32_t((threadIdx.x & 31u));										  // PTX L4003
	r_PtxU64Register281 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4003)) * int64_t(int32_t(16))); // PTX L4005
	g_OutputByteAddressAtPtx4006 =
		uint64_t(g_OutputByteAddressAtPtx4001) + uint64_t(r_PtxU64Register281); // PTX L4006
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4006));
		r_PackedHalf2AtPtx3992R1780 = r_Value.x;
		r_PackedHalf2AtPtx3993R1781 = r_Value.y;
		r_PackedHalf2AtPtx3994R1782 = r_Value.z;
		r_PackedHalf2AtPtx3995R1783 = r_Value.w;
	} // PTX L4008
L__BB56_150:													  // PTX L4010
	r_bPtxPredicate75 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4011
	r_PtxRegister1784 = uint32_t(0);							  // PTX L4012
	if (r_bPtxPredicate75)
	{
		goto L__BB56_152;
	} // PTX L4013
	r_bPtxPredicate76 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister4); // PTX L4014
	r_PtxRegister1784 = uint32_t(r_PtxRegister46);							 // PTX L4015
	r_PackedHalf2AtPtx4016R1785 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4016
	r_PackedHalf2AtPtx4017R1786 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4017
	r_PackedHalf2AtPtx4018R1787 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4018
	r_PackedHalf2AtPtx4019R1788 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4019
	if (r_bPtxPredicate76)
	{
		goto L__BB56_153;
	} // PTX L4020
L__BB56_152:																					  // PTX L4021
	r_PtxRegister1349 = ShiftLeft(uint32_t(r_PtxRegister1784), uint32_t(13));					  // PTX L4022
	r_PtxRegister1350 = uint32_t(r_PtxRegister1349) + uint32_t(r_PtxRegister8);					  // PTX L4023
	r_PtxU64Register283 = uint64_t(int64_t(int32_t(r_PtxRegister1350)) * int64_t(int32_t(4)));	  // PTX L4024
	g_OutputByteAddressAtPtx4025 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register283); // PTX L4025
	r_LaneIndexAtPtx4027 = uint32_t((threadIdx.x & 31u));										  // PTX L4027
	r_PtxU64Register285 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4027)) * int64_t(int32_t(16))); // PTX L4029
	g_OutputByteAddressAtPtx4030 =
		uint64_t(g_OutputByteAddressAtPtx4025) + uint64_t(r_PtxU64Register285); // PTX L4030
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4030));
		r_PackedHalf2AtPtx4016R1785 = r_Value.x;
		r_PackedHalf2AtPtx4017R1786 = r_Value.y;
		r_PackedHalf2AtPtx4018R1787 = r_Value.z;
		r_PackedHalf2AtPtx4019R1788 = r_Value.w;
	} // PTX L4032
L__BB56_153:													  // PTX L4034
	r_bPtxPredicate77 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4035
	r_PtxRegister1789 = uint32_t(0);							  // PTX L4036
	if (r_bPtxPredicate77)
	{
		goto L__BB56_155;
	} // PTX L4037
	r_bPtxPredicate78 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister4); // PTX L4038
	r_PtxRegister1789 = uint32_t(r_PtxRegister46);							 // PTX L4039
	r_PackedHalf2AtPtx4040R1790 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4040
	r_PackedHalf2AtPtx4041R1791 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4041
	r_PackedHalf2AtPtx4042R1792 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4042
	r_PackedHalf2AtPtx4043R1793 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4043
	if (r_bPtxPredicate78)
	{
		goto L__BB56_156;
	} // PTX L4044
L__BB56_155:																					  // PTX L4045
	r_PtxRegister1352 = ShiftLeft(uint32_t(r_PtxRegister1789), uint32_t(13));					  // PTX L4046
	r_PtxRegister1353 = uint32_t(r_PtxRegister1352) + uint32_t(r_PtxRegister9);					  // PTX L4047
	r_PtxU64Register287 = uint64_t(int64_t(int32_t(r_PtxRegister1353)) * int64_t(int32_t(4)));	  // PTX L4048
	g_OutputByteAddressAtPtx4049 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register287); // PTX L4049
	r_LaneIndexAtPtx4051 = uint32_t((threadIdx.x & 31u));										  // PTX L4051
	r_PtxU64Register289 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4051)) * int64_t(int32_t(16))); // PTX L4053
	g_OutputByteAddressAtPtx4054 =
		uint64_t(g_OutputByteAddressAtPtx4049) + uint64_t(r_PtxU64Register289); // PTX L4054
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4054));
		r_PackedHalf2AtPtx4040R1790 = r_Value.x;
		r_PackedHalf2AtPtx4041R1791 = r_Value.y;
		r_PackedHalf2AtPtx4042R1792 = r_Value.z;
		r_PackedHalf2AtPtx4043R1793 = r_Value.w;
	} // PTX L4056
L__BB56_156:													  // PTX L4058
	r_bPtxPredicate79 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4059
	r_PtxRegister47 = uint32_t(r_PtxRegister46) + uint32_t(1);	  // PTX L4060
	r_PtxRegister1794 = uint32_t(0);							  // PTX L4061
	if (r_bPtxPredicate79)
	{
		goto L__BB56_158;
	} // PTX L4062
	r_bPtxPredicate80 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister4); // PTX L4063
	r_PtxRegister1794 = uint32_t(r_PtxRegister47);							 // PTX L4064
	r_PackedHalf2AtPtx4065R1795 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4065
	r_PackedHalf2AtPtx4066R1796 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4066
	r_PackedHalf2AtPtx4067R1797 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4067
	r_PackedHalf2AtPtx4068R1798 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4068
	if (r_bPtxPredicate80)
	{
		goto L__BB56_159;
	} // PTX L4069
L__BB56_158:																					  // PTX L4070
	r_PtxRegister1355 = ShiftLeft(uint32_t(r_PtxRegister1794), uint32_t(13));					  // PTX L4071
	r_PtxRegister1356 = uint32_t(r_PtxRegister1355) + uint32_t(r_PtxRegister6);					  // PTX L4072
	r_PtxU64Register291 = uint64_t(int64_t(int32_t(r_PtxRegister1356)) * int64_t(int32_t(4)));	  // PTX L4073
	g_OutputByteAddressAtPtx4074 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register291); // PTX L4074
	r_LaneIndexAtPtx4076 = uint32_t((threadIdx.x & 31u));										  // PTX L4076
	r_PtxU64Register293 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4076)) * int64_t(int32_t(16))); // PTX L4078
	g_OutputByteAddressAtPtx4079 =
		uint64_t(g_OutputByteAddressAtPtx4074) + uint64_t(r_PtxU64Register293); // PTX L4079
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4079));
		r_PackedHalf2AtPtx4065R1795 = r_Value.x;
		r_PackedHalf2AtPtx4066R1796 = r_Value.y;
		r_PackedHalf2AtPtx4067R1797 = r_Value.z;
		r_PackedHalf2AtPtx4068R1798 = r_Value.w;
	} // PTX L4081
L__BB56_159:													  // PTX L4083
	r_bPtxPredicate81 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4084
	r_PtxRegister1799 = uint32_t(0);							  // PTX L4085
	if (r_bPtxPredicate81)
	{
		goto L__BB56_161;
	} // PTX L4086
	r_bPtxPredicate82 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister4); // PTX L4087
	r_PtxRegister1799 = uint32_t(r_PtxRegister47);							 // PTX L4088
	r_PackedHalf2AtPtx4089R1800 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4089
	r_PackedHalf2AtPtx4090R1801 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4090
	r_PackedHalf2AtPtx4091R1802 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4091
	r_PackedHalf2AtPtx4092R1803 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4092
	if (r_bPtxPredicate82)
	{
		goto L__BB56_162;
	} // PTX L4093
L__BB56_161:																					  // PTX L4094
	r_PtxRegister1358 = ShiftLeft(uint32_t(r_PtxRegister1799), uint32_t(13));					  // PTX L4095
	r_PtxRegister1359 = uint32_t(r_PtxRegister1358) + uint32_t(r_PtxRegister7);					  // PTX L4096
	r_PtxU64Register295 = uint64_t(int64_t(int32_t(r_PtxRegister1359)) * int64_t(int32_t(4)));	  // PTX L4097
	g_OutputByteAddressAtPtx4098 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register295); // PTX L4098
	r_LaneIndexAtPtx4100 = uint32_t((threadIdx.x & 31u));										  // PTX L4100
	r_PtxU64Register297 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4100)) * int64_t(int32_t(16))); // PTX L4102
	g_OutputByteAddressAtPtx4103 =
		uint64_t(g_OutputByteAddressAtPtx4098) + uint64_t(r_PtxU64Register297); // PTX L4103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4103));
		r_PackedHalf2AtPtx4089R1800 = r_Value.x;
		r_PackedHalf2AtPtx4090R1801 = r_Value.y;
		r_PackedHalf2AtPtx4091R1802 = r_Value.z;
		r_PackedHalf2AtPtx4092R1803 = r_Value.w;
	} // PTX L4105
L__BB56_162:													  // PTX L4107
	r_bPtxPredicate83 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4108
	r_PtxRegister1804 = uint32_t(0);							  // PTX L4109
	if (r_bPtxPredicate83)
	{
		goto L__BB56_164;
	} // PTX L4110
	r_bPtxPredicate84 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister4); // PTX L4111
	r_PtxRegister1804 = uint32_t(r_PtxRegister47);							 // PTX L4112
	r_PackedHalf2AtPtx4113R1805 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4113
	r_PackedHalf2AtPtx4114R1806 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4114
	r_PackedHalf2AtPtx4115R1807 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4115
	r_PackedHalf2AtPtx4116R1808 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4116
	if (r_bPtxPredicate84)
	{
		goto L__BB56_165;
	} // PTX L4117
L__BB56_164:																					  // PTX L4118
	r_PtxRegister1361 = ShiftLeft(uint32_t(r_PtxRegister1804), uint32_t(13));					  // PTX L4119
	r_PtxRegister1362 = uint32_t(r_PtxRegister1361) + uint32_t(r_PtxRegister8);					  // PTX L4120
	r_PtxU64Register299 = uint64_t(int64_t(int32_t(r_PtxRegister1362)) * int64_t(int32_t(4)));	  // PTX L4121
	g_OutputByteAddressAtPtx4122 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register299); // PTX L4122
	r_LaneIndexAtPtx4124 = uint32_t((threadIdx.x & 31u));										  // PTX L4124
	r_PtxU64Register301 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4124)) * int64_t(int32_t(16))); // PTX L4126
	g_OutputByteAddressAtPtx4127 =
		uint64_t(g_OutputByteAddressAtPtx4122) + uint64_t(r_PtxU64Register301); // PTX L4127
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4127));
		r_PackedHalf2AtPtx4113R1805 = r_Value.x;
		r_PackedHalf2AtPtx4114R1806 = r_Value.y;
		r_PackedHalf2AtPtx4115R1807 = r_Value.z;
		r_PackedHalf2AtPtx4116R1808 = r_Value.w;
	} // PTX L4129
L__BB56_165:													  // PTX L4131
	r_bPtxPredicate85 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4132
	r_PtxRegister1809 = uint32_t(0);							  // PTX L4133
	if (r_bPtxPredicate85)
	{
		goto L__BB56_167;
	} // PTX L4134
	r_bPtxPredicate86 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister4); // PTX L4135
	r_PtxRegister1809 = uint32_t(r_PtxRegister47);							 // PTX L4136
	r_PackedHalf2AtPtx4137R1810 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4137
	r_PackedHalf2AtPtx4138R1811 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4138
	r_PackedHalf2AtPtx4139R1812 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4139
	r_PackedHalf2AtPtx4140R1813 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4140
	if (r_bPtxPredicate86)
	{
		goto L__BB56_168;
	} // PTX L4141
L__BB56_167:																					  // PTX L4142
	r_PtxRegister1364 = ShiftLeft(uint32_t(r_PtxRegister1809), uint32_t(13));					  // PTX L4143
	r_PtxRegister1365 = uint32_t(r_PtxRegister1364) + uint32_t(r_PtxRegister9);					  // PTX L4144
	r_PtxU64Register303 = uint64_t(int64_t(int32_t(r_PtxRegister1365)) * int64_t(int32_t(4)));	  // PTX L4145
	g_OutputByteAddressAtPtx4146 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register303); // PTX L4146
	r_LaneIndexAtPtx4148 = uint32_t((threadIdx.x & 31u));										  // PTX L4148
	r_PtxU64Register305 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4148)) * int64_t(int32_t(16))); // PTX L4150
	g_OutputByteAddressAtPtx4151 =
		uint64_t(g_OutputByteAddressAtPtx4146) + uint64_t(r_PtxU64Register305); // PTX L4151
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4151));
		r_PackedHalf2AtPtx4137R1810 = r_Value.x;
		r_PackedHalf2AtPtx4138R1811 = r_Value.y;
		r_PackedHalf2AtPtx4139R1812 = r_Value.z;
		r_PackedHalf2AtPtx4140R1813 = r_Value.w;
	} // PTX L4153
L__BB56_168:													  // PTX L4155
	r_bPtxPredicate87 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4156
	r_PtxRegister48 = uint32_t(r_PtxRegister46) + uint32_t(2);	  // PTX L4157
	r_PtxRegister1814 = uint32_t(0);							  // PTX L4158
	if (r_bPtxPredicate87)
	{
		goto L__BB56_170;
	} // PTX L4159
	r_bPtxPredicate88 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister4); // PTX L4160
	r_PtxRegister1814 = uint32_t(r_PtxRegister48);							 // PTX L4161
	r_PackedHalf2AtPtx4162R1815 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4162
	r_PackedHalf2AtPtx4163R1816 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4163
	r_PackedHalf2AtPtx4164R1817 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4164
	r_PackedHalf2AtPtx4165R1818 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4165
	if (r_bPtxPredicate88)
	{
		goto L__BB56_171;
	} // PTX L4166
L__BB56_170:																					  // PTX L4167
	r_PtxRegister1367 = ShiftLeft(uint32_t(r_PtxRegister1814), uint32_t(13));					  // PTX L4168
	r_PtxRegister1368 = uint32_t(r_PtxRegister1367) + uint32_t(r_PtxRegister6);					  // PTX L4169
	r_PtxU64Register307 = uint64_t(int64_t(int32_t(r_PtxRegister1368)) * int64_t(int32_t(4)));	  // PTX L4170
	g_OutputByteAddressAtPtx4171 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register307); // PTX L4171
	r_LaneIndexAtPtx4173 = uint32_t((threadIdx.x & 31u));										  // PTX L4173
	r_PtxU64Register309 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4173)) * int64_t(int32_t(16))); // PTX L4175
	g_OutputByteAddressAtPtx4176 =
		uint64_t(g_OutputByteAddressAtPtx4171) + uint64_t(r_PtxU64Register309); // PTX L4176
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4176));
		r_PackedHalf2AtPtx4162R1815 = r_Value.x;
		r_PackedHalf2AtPtx4163R1816 = r_Value.y;
		r_PackedHalf2AtPtx4164R1817 = r_Value.z;
		r_PackedHalf2AtPtx4165R1818 = r_Value.w;
	} // PTX L4178
L__BB56_171:													  // PTX L4180
	r_bPtxPredicate89 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4181
	r_PtxRegister1819 = uint32_t(0);							  // PTX L4182
	if (r_bPtxPredicate89)
	{
		goto L__BB56_173;
	} // PTX L4183
	r_bPtxPredicate90 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister4); // PTX L4184
	r_PtxRegister1819 = uint32_t(r_PtxRegister48);							 // PTX L4185
	r_PackedHalf2AtPtx4186R1820 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4186
	r_PackedHalf2AtPtx4187R1821 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4187
	r_PackedHalf2AtPtx4188R1822 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4188
	r_PackedHalf2AtPtx4189R1823 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4189
	if (r_bPtxPredicate90)
	{
		goto L__BB56_174;
	} // PTX L4190
L__BB56_173:																					  // PTX L4191
	r_PtxRegister1370 = ShiftLeft(uint32_t(r_PtxRegister1819), uint32_t(13));					  // PTX L4192
	r_PtxRegister1371 = uint32_t(r_PtxRegister1370) + uint32_t(r_PtxRegister7);					  // PTX L4193
	r_PtxU64Register311 = uint64_t(int64_t(int32_t(r_PtxRegister1371)) * int64_t(int32_t(4)));	  // PTX L4194
	g_OutputByteAddressAtPtx4195 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register311); // PTX L4195
	r_LaneIndexAtPtx4197 = uint32_t((threadIdx.x & 31u));										  // PTX L4197
	r_PtxU64Register313 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4197)) * int64_t(int32_t(16))); // PTX L4199
	g_OutputByteAddressAtPtx4200 =
		uint64_t(g_OutputByteAddressAtPtx4195) + uint64_t(r_PtxU64Register313); // PTX L4200
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4200));
		r_PackedHalf2AtPtx4186R1820 = r_Value.x;
		r_PackedHalf2AtPtx4187R1821 = r_Value.y;
		r_PackedHalf2AtPtx4188R1822 = r_Value.z;
		r_PackedHalf2AtPtx4189R1823 = r_Value.w;
	} // PTX L4202
L__BB56_174:													  // PTX L4204
	r_bPtxPredicate91 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4205
	r_PtxRegister1824 = uint32_t(0);							  // PTX L4206
	if (r_bPtxPredicate91)
	{
		goto L__BB56_176;
	} // PTX L4207
	r_bPtxPredicate92 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister4); // PTX L4208
	r_PtxRegister1824 = uint32_t(r_PtxRegister48);							 // PTX L4209
	r_PackedHalf2AtPtx4210R1825 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4210
	r_PackedHalf2AtPtx4211R1826 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4211
	r_PackedHalf2AtPtx4212R1827 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4212
	r_PackedHalf2AtPtx4213R1828 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4213
	if (r_bPtxPredicate92)
	{
		goto L__BB56_177;
	} // PTX L4214
L__BB56_176:																					  // PTX L4215
	r_PtxRegister1373 = ShiftLeft(uint32_t(r_PtxRegister1824), uint32_t(13));					  // PTX L4216
	r_PtxRegister1374 = uint32_t(r_PtxRegister1373) + uint32_t(r_PtxRegister8);					  // PTX L4217
	r_PtxU64Register315 = uint64_t(int64_t(int32_t(r_PtxRegister1374)) * int64_t(int32_t(4)));	  // PTX L4218
	g_OutputByteAddressAtPtx4219 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register315); // PTX L4219
	r_LaneIndexAtPtx4221 = uint32_t((threadIdx.x & 31u));										  // PTX L4221
	r_PtxU64Register317 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4221)) * int64_t(int32_t(16))); // PTX L4223
	g_OutputByteAddressAtPtx4224 =
		uint64_t(g_OutputByteAddressAtPtx4219) + uint64_t(r_PtxU64Register317); // PTX L4224
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4224));
		r_PackedHalf2AtPtx4210R1825 = r_Value.x;
		r_PackedHalf2AtPtx4211R1826 = r_Value.y;
		r_PackedHalf2AtPtx4212R1827 = r_Value.z;
		r_PackedHalf2AtPtx4213R1828 = r_Value.w;
	} // PTX L4226
L__BB56_177:													  // PTX L4228
	r_bPtxPredicate93 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4229
	r_PtxRegister1829 = uint32_t(0);							  // PTX L4230
	if (r_bPtxPredicate93)
	{
		goto L__BB56_179;
	} // PTX L4231
	r_bPtxPredicate94 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister4); // PTX L4232
	r_PtxRegister1829 = uint32_t(r_PtxRegister48);							 // PTX L4233
	r_PackedHalf2AtPtx4234R1830 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4234
	r_PackedHalf2AtPtx4235R1831 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4235
	r_PackedHalf2AtPtx4236R1832 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4236
	r_PackedHalf2AtPtx4237R1833 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4237
	if (r_bPtxPredicate94)
	{
		goto L__BB56_180;
	} // PTX L4238
L__BB56_179:																					  // PTX L4239
	r_PtxRegister1376 = ShiftLeft(uint32_t(r_PtxRegister1829), uint32_t(13));					  // PTX L4240
	r_PtxRegister1377 = uint32_t(r_PtxRegister1376) + uint32_t(r_PtxRegister9);					  // PTX L4241
	r_PtxU64Register319 = uint64_t(int64_t(int32_t(r_PtxRegister1377)) * int64_t(int32_t(4)));	  // PTX L4242
	g_OutputByteAddressAtPtx4243 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register319); // PTX L4243
	r_LaneIndexAtPtx4245 = uint32_t((threadIdx.x & 31u));										  // PTX L4245
	r_PtxU64Register321 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4245)) * int64_t(int32_t(16))); // PTX L4247
	g_OutputByteAddressAtPtx4248 =
		uint64_t(g_OutputByteAddressAtPtx4243) + uint64_t(r_PtxU64Register321); // PTX L4248
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4248));
		r_PackedHalf2AtPtx4234R1830 = r_Value.x;
		r_PackedHalf2AtPtx4235R1831 = r_Value.y;
		r_PackedHalf2AtPtx4236R1832 = r_Value.z;
		r_PackedHalf2AtPtx4237R1833 = r_Value.w;
	} // PTX L4250
L__BB56_180:													  // PTX L4252
	r_bPtxPredicate95 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4253
	r_PtxRegister49 = uint32_t(r_PtxRegister46) + uint32_t(3);	  // PTX L4254
	r_PtxRegister1834 = uint32_t(0);							  // PTX L4255
	if (r_bPtxPredicate95)
	{
		goto L__BB56_182;
	} // PTX L4256
	r_bPtxPredicate96 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4); // PTX L4257
	r_PtxRegister1834 = uint32_t(r_PtxRegister49);							 // PTX L4258
	r_PackedHalf2AtPtx4259R1835 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4259
	r_PackedHalf2AtPtx4260R1836 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4260
	r_PackedHalf2AtPtx4261R1837 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4261
	r_PackedHalf2AtPtx4262R1838 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4262
	if (r_bPtxPredicate96)
	{
		goto L__BB56_183;
	} // PTX L4263
L__BB56_182:																					  // PTX L4264
	r_PtxRegister1379 = ShiftLeft(uint32_t(r_PtxRegister1834), uint32_t(13));					  // PTX L4265
	r_PtxRegister1380 = uint32_t(r_PtxRegister1379) + uint32_t(r_PtxRegister6);					  // PTX L4266
	r_PtxU64Register323 = uint64_t(int64_t(int32_t(r_PtxRegister1380)) * int64_t(int32_t(4)));	  // PTX L4267
	g_OutputByteAddressAtPtx4268 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register323); // PTX L4268
	r_LaneIndexAtPtx4270 = uint32_t((threadIdx.x & 31u));										  // PTX L4270
	r_PtxU64Register325 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4270)) * int64_t(int32_t(16))); // PTX L4272
	g_OutputByteAddressAtPtx4273 =
		uint64_t(g_OutputByteAddressAtPtx4268) + uint64_t(r_PtxU64Register325); // PTX L4273
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4273));
		r_PackedHalf2AtPtx4259R1835 = r_Value.x;
		r_PackedHalf2AtPtx4260R1836 = r_Value.y;
		r_PackedHalf2AtPtx4261R1837 = r_Value.z;
		r_PackedHalf2AtPtx4262R1838 = r_Value.w;
	} // PTX L4275
L__BB56_183:													  // PTX L4277
	r_bPtxPredicate97 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4278
	r_PtxRegister1839 = uint32_t(0);							  // PTX L4279
	if (r_bPtxPredicate97)
	{
		goto L__BB56_185;
	} // PTX L4280
	r_bPtxPredicate98 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4); // PTX L4281
	r_PtxRegister1839 = uint32_t(r_PtxRegister49);							 // PTX L4282
	r_PackedHalf2AtPtx4283R1840 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4283
	r_PackedHalf2AtPtx4284R1841 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4284
	r_PackedHalf2AtPtx4285R1842 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4285
	r_PackedHalf2AtPtx4286R1843 = uint32_t(r_PackedHalf2AtPtx4345R1850);	 // PTX L4286
	if (r_bPtxPredicate98)
	{
		goto L__BB56_186;
	} // PTX L4287
L__BB56_185:																					  // PTX L4288
	r_PtxRegister1382 = ShiftLeft(uint32_t(r_PtxRegister1839), uint32_t(13));					  // PTX L4289
	r_PtxRegister1383 = uint32_t(r_PtxRegister1382) + uint32_t(r_PtxRegister7);					  // PTX L4290
	r_PtxU64Register327 = uint64_t(int64_t(int32_t(r_PtxRegister1383)) * int64_t(int32_t(4)));	  // PTX L4291
	g_OutputByteAddressAtPtx4292 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register327); // PTX L4292
	r_LaneIndexAtPtx4294 = uint32_t((threadIdx.x & 31u));										  // PTX L4294
	r_PtxU64Register329 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4294)) * int64_t(int32_t(16))); // PTX L4296
	g_OutputByteAddressAtPtx4297 =
		uint64_t(g_OutputByteAddressAtPtx4292) + uint64_t(r_PtxU64Register329); // PTX L4297
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4297));
		r_PackedHalf2AtPtx4283R1840 = r_Value.x;
		r_PackedHalf2AtPtx4284R1841 = r_Value.y;
		r_PackedHalf2AtPtx4285R1842 = r_Value.z;
		r_PackedHalf2AtPtx4286R1843 = r_Value.w;
	} // PTX L4299
L__BB56_186:													  // PTX L4301
	r_bPtxPredicate99 = uint32_t(r_PtxRegister24) < uint32_t(31); // PTX L4302
	r_PtxRegister1844 = uint32_t(0);							  // PTX L4303
	if (r_bPtxPredicate99)
	{
		goto L__BB56_188;
	} // PTX L4304
	r_bPtxPredicate100 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4); // PTX L4305
	r_PtxRegister1844 = uint32_t(r_PtxRegister49);							  // PTX L4306
	r_PackedHalf2AtPtx4307R1845 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4307
	r_PackedHalf2AtPtx4308R1846 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4308
	r_PackedHalf2AtPtx4309R1847 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4309
	r_PackedHalf2AtPtx4310R1848 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4310
	if (r_bPtxPredicate100)
	{
		goto L__BB56_189;
	} // PTX L4311
L__BB56_188:																					  // PTX L4312
	r_PtxRegister1385 = ShiftLeft(uint32_t(r_PtxRegister1844), uint32_t(13));					  // PTX L4313
	r_PtxRegister1386 = uint32_t(r_PtxRegister1385) + uint32_t(r_PtxRegister8);					  // PTX L4314
	r_PtxU64Register331 = uint64_t(int64_t(int32_t(r_PtxRegister1386)) * int64_t(int32_t(4)));	  // PTX L4315
	g_OutputByteAddressAtPtx4316 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register331); // PTX L4316
	r_LaneIndexAtPtx4318 = uint32_t((threadIdx.x & 31u));										  // PTX L4318
	r_PtxU64Register333 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4318)) * int64_t(int32_t(16))); // PTX L4320
	g_OutputByteAddressAtPtx4321 =
		uint64_t(g_OutputByteAddressAtPtx4316) + uint64_t(r_PtxU64Register333); // PTX L4321
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4321));
		r_PackedHalf2AtPtx4307R1845 = r_Value.x;
		r_PackedHalf2AtPtx4308R1846 = r_Value.y;
		r_PackedHalf2AtPtx4309R1847 = r_Value.z;
		r_PackedHalf2AtPtx4310R1848 = r_Value.w;
	} // PTX L4323
L__BB56_189:						 // PTX L4325
	r_PtxRegister1849 = uint32_t(0); // PTX L4326
	if (r_bPtxPredicate99)
	{
		goto L__BB56_191;
	} // PTX L4327
	r_bPtxPredicate101 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4); // PTX L4328
	r_PtxRegister1849 = uint32_t(r_PtxRegister49);							  // PTX L4329
	r_PackedHalf2AtPtx4330R1851 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4330
	r_PackedHalf2AtPtx4331R1852 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4331
	r_PackedHalf2AtPtx4332R1853 = uint32_t(r_PackedHalf2AtPtx4345R1850);	  // PTX L4332
	if (r_bPtxPredicate101)
	{
		goto L__BB56_192;
	} // PTX L4333
L__BB56_191:																					  // PTX L4334
	r_PtxRegister1388 = ShiftLeft(uint32_t(r_PtxRegister1849), uint32_t(13));					  // PTX L4335
	r_PtxRegister1389 = uint32_t(r_PtxRegister1388) + uint32_t(r_PtxRegister9);					  // PTX L4336
	r_PtxU64Register335 = uint64_t(int64_t(int32_t(r_PtxRegister1389)) * int64_t(int32_t(4)));	  // PTX L4337
	g_OutputByteAddressAtPtx4338 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register335); // PTX L4338
	r_LaneIndexAtPtx4340 = uint32_t((threadIdx.x & 31u));										  // PTX L4340
	r_PtxU64Register337 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4340)) * int64_t(int32_t(16))); // PTX L4342
	g_OutputByteAddressAtPtx4343 =
		uint64_t(g_OutputByteAddressAtPtx4338) + uint64_t(r_PtxU64Register337); // PTX L4343
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4343));
		r_PackedHalf2AtPtx4345R1850 = r_Value.x;
		r_PackedHalf2AtPtx4330R1851 = r_Value.y;
		r_PackedHalf2AtPtx4331R1852 = r_Value.z;
		r_PackedHalf2AtPtx4332R1853 = r_Value.w;
	} // PTX L4345
L__BB56_192:											  // PTX L4347
	r_LaneIndexAtPtx4349 = uint32_t((threadIdx.x & 31u)); // PTX L4349
	r_PackedHalf2AtPtx4352R1457 =
		HalfAdd(r_PackedHalf2AtPtx3968R1775, r_MmaAccumulatorHalf2WordAtPtx3137R1161); // PTX L4352
	r_LaneIndexAtPtx4356 = uint32_t((threadIdx.x & 31u));							   // PTX L4356
	r_PackedHalf2AtPtx4359R1458 =
		HalfAdd(r_PackedHalf2AtPtx3969R1776, r_MmaAccumulatorHalf2WordAtPtx3137R1162); // PTX L4359
	r_LaneIndexAtPtx4363 = uint32_t((threadIdx.x & 31u));							   // PTX L4363
	r_PackedHalf2AtPtx4366R1459 =
		HalfAdd(r_PackedHalf2AtPtx3970R1777, r_MmaAccumulatorHalf2WordAtPtx3144R1169); // PTX L4366
	r_LaneIndexAtPtx4370 = uint32_t((threadIdx.x & 31u));							   // PTX L4370
	r_PackedHalf2AtPtx4373R1460 =
		HalfAdd(r_PackedHalf2AtPtx3971R1778, r_MmaAccumulatorHalf2WordAtPtx3144R1170); // PTX L4373
	r_LaneIndexAtPtx4377 = uint32_t((threadIdx.x & 31u));							   // PTX L4377
	r_PackedHalf2AtPtx4380R1462 =
		HalfAdd(r_PackedHalf2AtPtx3992R1780, r_MmaAccumulatorHalf2WordAtPtx3165R1173); // PTX L4380
	r_LaneIndexAtPtx4384 = uint32_t((threadIdx.x & 31u));							   // PTX L4384
	r_PackedHalf2AtPtx4387R1463 =
		HalfAdd(r_PackedHalf2AtPtx3993R1781, r_MmaAccumulatorHalf2WordAtPtx3165R1174); // PTX L4387
	r_LaneIndexAtPtx4391 = uint32_t((threadIdx.x & 31u));							   // PTX L4391
	r_PackedHalf2AtPtx4394R1464 =
		HalfAdd(r_PackedHalf2AtPtx3994R1782, r_MmaAccumulatorHalf2WordAtPtx3172R1177); // PTX L4394
	r_LaneIndexAtPtx4398 = uint32_t((threadIdx.x & 31u));							   // PTX L4398
	r_PackedHalf2AtPtx4401R1465 =
		HalfAdd(r_PackedHalf2AtPtx3995R1783, r_MmaAccumulatorHalf2WordAtPtx3172R1178); // PTX L4401
	r_LaneIndexAtPtx4405 = uint32_t((threadIdx.x & 31u));							   // PTX L4405
	r_PackedHalf2AtPtx4408R1467 =
		HalfAdd(r_PackedHalf2AtPtx4016R1785, r_MmaAccumulatorHalf2WordAtPtx3193R1181); // PTX L4408
	r_LaneIndexAtPtx4412 = uint32_t((threadIdx.x & 31u));							   // PTX L4412
	r_PackedHalf2AtPtx4415R1468 =
		HalfAdd(r_PackedHalf2AtPtx4017R1786, r_MmaAccumulatorHalf2WordAtPtx3193R1182); // PTX L4415
	r_LaneIndexAtPtx4419 = uint32_t((threadIdx.x & 31u));							   // PTX L4419
	r_PackedHalf2AtPtx4422R1469 =
		HalfAdd(r_PackedHalf2AtPtx4018R1787, r_MmaAccumulatorHalf2WordAtPtx3200R1185); // PTX L4422
	r_LaneIndexAtPtx4426 = uint32_t((threadIdx.x & 31u));							   // PTX L4426
	r_PackedHalf2AtPtx4429R1470 =
		HalfAdd(r_PackedHalf2AtPtx4019R1788, r_MmaAccumulatorHalf2WordAtPtx3200R1186); // PTX L4429
	r_LaneIndexAtPtx4433 = uint32_t((threadIdx.x & 31u));							   // PTX L4433
	r_PackedHalf2AtPtx4436R1472 =
		HalfAdd(r_PackedHalf2AtPtx4040R1790, r_MmaAccumulatorHalf2WordAtPtx3221R1189); // PTX L4436
	r_LaneIndexAtPtx4440 = uint32_t((threadIdx.x & 31u));							   // PTX L4440
	r_PackedHalf2AtPtx4443R1473 =
		HalfAdd(r_PackedHalf2AtPtx4041R1791, r_MmaAccumulatorHalf2WordAtPtx3221R1190); // PTX L4443
	r_LaneIndexAtPtx4447 = uint32_t((threadIdx.x & 31u));							   // PTX L4447
	r_PackedHalf2AtPtx4450R1474 =
		HalfAdd(r_PackedHalf2AtPtx4042R1792, r_MmaAccumulatorHalf2WordAtPtx3228R1193); // PTX L4450
	r_LaneIndexAtPtx4454 = uint32_t((threadIdx.x & 31u));							   // PTX L4454
	r_PackedHalf2AtPtx4457R1475 =
		HalfAdd(r_PackedHalf2AtPtx4043R1793, r_MmaAccumulatorHalf2WordAtPtx3228R1194); // PTX L4457
	r_LaneIndexAtPtx4461 = uint32_t((threadIdx.x & 31u));							   // PTX L4461
	r_PackedHalf2AtPtx4464R1477 =
		HalfAdd(r_PackedHalf2AtPtx4065R1795, r_MmaAccumulatorHalf2WordAtPtx3249R1201); // PTX L4464
	r_LaneIndexAtPtx4468 = uint32_t((threadIdx.x & 31u));							   // PTX L4468
	r_PackedHalf2AtPtx4471R1478 =
		HalfAdd(r_PackedHalf2AtPtx4066R1796, r_MmaAccumulatorHalf2WordAtPtx3249R1202); // PTX L4471
	r_LaneIndexAtPtx4475 = uint32_t((threadIdx.x & 31u));							   // PTX L4475
	r_PackedHalf2AtPtx4478R1479 =
		HalfAdd(r_PackedHalf2AtPtx4067R1797, r_MmaAccumulatorHalf2WordAtPtx3256R1209); // PTX L4478
	r_LaneIndexAtPtx4482 = uint32_t((threadIdx.x & 31u));							   // PTX L4482
	r_PackedHalf2AtPtx4485R1480 =
		HalfAdd(r_PackedHalf2AtPtx4068R1798, r_MmaAccumulatorHalf2WordAtPtx3256R1210); // PTX L4485
	r_LaneIndexAtPtx4489 = uint32_t((threadIdx.x & 31u));							   // PTX L4489
	r_PackedHalf2AtPtx4492R1482 =
		HalfAdd(r_PackedHalf2AtPtx4089R1800, r_MmaAccumulatorHalf2WordAtPtx3277R1213); // PTX L4492
	r_LaneIndexAtPtx4496 = uint32_t((threadIdx.x & 31u));							   // PTX L4496
	r_PackedHalf2AtPtx4499R1483 =
		HalfAdd(r_PackedHalf2AtPtx4090R1801, r_MmaAccumulatorHalf2WordAtPtx3277R1214); // PTX L4499
	r_LaneIndexAtPtx4503 = uint32_t((threadIdx.x & 31u));							   // PTX L4503
	r_PackedHalf2AtPtx4506R1484 =
		HalfAdd(r_PackedHalf2AtPtx4091R1802, r_MmaAccumulatorHalf2WordAtPtx3284R1217); // PTX L4506
	r_LaneIndexAtPtx4510 = uint32_t((threadIdx.x & 31u));							   // PTX L4510
	r_PackedHalf2AtPtx4513R1485 =
		HalfAdd(r_PackedHalf2AtPtx4092R1803, r_MmaAccumulatorHalf2WordAtPtx3284R1218); // PTX L4513
	r_LaneIndexAtPtx4517 = uint32_t((threadIdx.x & 31u));							   // PTX L4517
	r_PackedHalf2AtPtx4520R1487 =
		HalfAdd(r_PackedHalf2AtPtx4113R1805, r_MmaAccumulatorHalf2WordAtPtx3305R1221); // PTX L4520
	r_LaneIndexAtPtx4524 = uint32_t((threadIdx.x & 31u));							   // PTX L4524
	r_PackedHalf2AtPtx4527R1488 =
		HalfAdd(r_PackedHalf2AtPtx4114R1806, r_MmaAccumulatorHalf2WordAtPtx3305R1222); // PTX L4527
	r_LaneIndexAtPtx4531 = uint32_t((threadIdx.x & 31u));							   // PTX L4531
	r_PackedHalf2AtPtx4534R1489 =
		HalfAdd(r_PackedHalf2AtPtx4115R1807, r_MmaAccumulatorHalf2WordAtPtx3312R1225); // PTX L4534
	r_LaneIndexAtPtx4538 = uint32_t((threadIdx.x & 31u));							   // PTX L4538
	r_PackedHalf2AtPtx4541R1490 =
		HalfAdd(r_PackedHalf2AtPtx4116R1808, r_MmaAccumulatorHalf2WordAtPtx3312R1226); // PTX L4541
	r_LaneIndexAtPtx4545 = uint32_t((threadIdx.x & 31u));							   // PTX L4545
	r_PackedHalf2AtPtx4548R1492 =
		HalfAdd(r_PackedHalf2AtPtx4137R1810, r_MmaAccumulatorHalf2WordAtPtx3333R1229); // PTX L4548
	r_LaneIndexAtPtx4552 = uint32_t((threadIdx.x & 31u));							   // PTX L4552
	r_PackedHalf2AtPtx4555R1493 =
		HalfAdd(r_PackedHalf2AtPtx4138R1811, r_MmaAccumulatorHalf2WordAtPtx3333R1230); // PTX L4555
	r_LaneIndexAtPtx4559 = uint32_t((threadIdx.x & 31u));							   // PTX L4559
	r_PackedHalf2AtPtx4562R1494 =
		HalfAdd(r_PackedHalf2AtPtx4139R1812, r_MmaAccumulatorHalf2WordAtPtx3340R1233); // PTX L4562
	r_LaneIndexAtPtx4566 = uint32_t((threadIdx.x & 31u));							   // PTX L4566
	r_PackedHalf2AtPtx4569R1495 =
		HalfAdd(r_PackedHalf2AtPtx4140R1813, r_MmaAccumulatorHalf2WordAtPtx3340R1234); // PTX L4569
	r_LaneIndexAtPtx4573 = uint32_t((threadIdx.x & 31u));							   // PTX L4573
	r_PackedHalf2AtPtx4576R1497 =
		HalfAdd(r_PackedHalf2AtPtx4162R1815, r_MmaAccumulatorHalf2WordAtPtx3361R1241); // PTX L4576
	r_LaneIndexAtPtx4580 = uint32_t((threadIdx.x & 31u));							   // PTX L4580
	r_PackedHalf2AtPtx4583R1498 =
		HalfAdd(r_PackedHalf2AtPtx4163R1816, r_MmaAccumulatorHalf2WordAtPtx3361R1242); // PTX L4583
	r_LaneIndexAtPtx4587 = uint32_t((threadIdx.x & 31u));							   // PTX L4587
	r_PackedHalf2AtPtx4590R1499 =
		HalfAdd(r_PackedHalf2AtPtx4164R1817, r_MmaAccumulatorHalf2WordAtPtx3368R1249); // PTX L4590
	r_LaneIndexAtPtx4594 = uint32_t((threadIdx.x & 31u));							   // PTX L4594
	r_PackedHalf2AtPtx4597R1500 =
		HalfAdd(r_PackedHalf2AtPtx4165R1818, r_MmaAccumulatorHalf2WordAtPtx3368R1250); // PTX L4597
	r_LaneIndexAtPtx4601 = uint32_t((threadIdx.x & 31u));							   // PTX L4601
	r_PackedHalf2AtPtx4604R1502 =
		HalfAdd(r_PackedHalf2AtPtx4186R1820, r_MmaAccumulatorHalf2WordAtPtx3389R1253); // PTX L4604
	r_LaneIndexAtPtx4608 = uint32_t((threadIdx.x & 31u));							   // PTX L4608
	r_PackedHalf2AtPtx4611R1503 =
		HalfAdd(r_PackedHalf2AtPtx4187R1821, r_MmaAccumulatorHalf2WordAtPtx3389R1254); // PTX L4611
	r_LaneIndexAtPtx4615 = uint32_t((threadIdx.x & 31u));							   // PTX L4615
	r_PackedHalf2AtPtx4618R1504 =
		HalfAdd(r_PackedHalf2AtPtx4188R1822, r_MmaAccumulatorHalf2WordAtPtx3396R1257); // PTX L4618
	r_LaneIndexAtPtx4622 = uint32_t((threadIdx.x & 31u));							   // PTX L4622
	r_PackedHalf2AtPtx4625R1505 =
		HalfAdd(r_PackedHalf2AtPtx4189R1823, r_MmaAccumulatorHalf2WordAtPtx3396R1258); // PTX L4625
	r_LaneIndexAtPtx4629 = uint32_t((threadIdx.x & 31u));							   // PTX L4629
	r_PackedHalf2AtPtx4632R1507 =
		HalfAdd(r_PackedHalf2AtPtx4210R1825, r_MmaAccumulatorHalf2WordAtPtx3417R1261); // PTX L4632
	r_LaneIndexAtPtx4636 = uint32_t((threadIdx.x & 31u));							   // PTX L4636
	r_PackedHalf2AtPtx4639R1508 =
		HalfAdd(r_PackedHalf2AtPtx4211R1826, r_MmaAccumulatorHalf2WordAtPtx3417R1262); // PTX L4639
	r_LaneIndexAtPtx4643 = uint32_t((threadIdx.x & 31u));							   // PTX L4643
	r_PackedHalf2AtPtx4646R1509 =
		HalfAdd(r_PackedHalf2AtPtx4212R1827, r_MmaAccumulatorHalf2WordAtPtx3424R1265); // PTX L4646
	r_LaneIndexAtPtx4650 = uint32_t((threadIdx.x & 31u));							   // PTX L4650
	r_PackedHalf2AtPtx4653R1510 =
		HalfAdd(r_PackedHalf2AtPtx4213R1828, r_MmaAccumulatorHalf2WordAtPtx3424R1266); // PTX L4653
	r_LaneIndexAtPtx4657 = uint32_t((threadIdx.x & 31u));							   // PTX L4657
	r_PackedHalf2AtPtx4660R1512 =
		HalfAdd(r_PackedHalf2AtPtx4234R1830, r_MmaAccumulatorHalf2WordAtPtx3445R1269); // PTX L4660
	r_LaneIndexAtPtx4664 = uint32_t((threadIdx.x & 31u));							   // PTX L4664
	r_PackedHalf2AtPtx4667R1513 =
		HalfAdd(r_PackedHalf2AtPtx4235R1831, r_MmaAccumulatorHalf2WordAtPtx3445R1270); // PTX L4667
	r_LaneIndexAtPtx4671 = uint32_t((threadIdx.x & 31u));							   // PTX L4671
	r_PackedHalf2AtPtx4674R1514 =
		HalfAdd(r_PackedHalf2AtPtx4236R1832, r_MmaAccumulatorHalf2WordAtPtx3452R1273); // PTX L4674
	r_LaneIndexAtPtx4678 = uint32_t((threadIdx.x & 31u));							   // PTX L4678
	r_PackedHalf2AtPtx4681R1515 =
		HalfAdd(r_PackedHalf2AtPtx4237R1833, r_MmaAccumulatorHalf2WordAtPtx3452R1274); // PTX L4681
	r_LaneIndexAtPtx4685 = uint32_t((threadIdx.x & 31u));							   // PTX L4685
	r_PackedHalf2AtPtx4688R1517 =
		HalfAdd(r_PackedHalf2AtPtx4259R1835, r_MmaAccumulatorHalf2WordAtPtx3473R1281); // PTX L4688
	r_LaneIndexAtPtx4692 = uint32_t((threadIdx.x & 31u));							   // PTX L4692
	r_PackedHalf2AtPtx4695R1518 =
		HalfAdd(r_PackedHalf2AtPtx4260R1836, r_MmaAccumulatorHalf2WordAtPtx3473R1282); // PTX L4695
	r_LaneIndexAtPtx4699 = uint32_t((threadIdx.x & 31u));							   // PTX L4699
	r_PackedHalf2AtPtx4702R1519 =
		HalfAdd(r_PackedHalf2AtPtx4261R1837, r_MmaAccumulatorHalf2WordAtPtx3480R1289); // PTX L4702
	r_LaneIndexAtPtx4706 = uint32_t((threadIdx.x & 31u));							   // PTX L4706
	r_PackedHalf2AtPtx4709R1520 =
		HalfAdd(r_PackedHalf2AtPtx4262R1838, r_MmaAccumulatorHalf2WordAtPtx3480R1290); // PTX L4709
	r_LaneIndexAtPtx4713 = uint32_t((threadIdx.x & 31u));							   // PTX L4713
	r_PackedHalf2AtPtx4716R1522 =
		HalfAdd(r_PackedHalf2AtPtx4283R1840, r_MmaAccumulatorHalf2WordAtPtx3501R1293); // PTX L4716
	r_LaneIndexAtPtx4720 = uint32_t((threadIdx.x & 31u));							   // PTX L4720
	r_PackedHalf2AtPtx4723R1523 =
		HalfAdd(r_PackedHalf2AtPtx4284R1841, r_MmaAccumulatorHalf2WordAtPtx3501R1294); // PTX L4723
	r_LaneIndexAtPtx4727 = uint32_t((threadIdx.x & 31u));							   // PTX L4727
	r_PackedHalf2AtPtx4730R1524 =
		HalfAdd(r_PackedHalf2AtPtx4285R1842, r_MmaAccumulatorHalf2WordAtPtx3508R1297); // PTX L4730
	r_LaneIndexAtPtx4734 = uint32_t((threadIdx.x & 31u));							   // PTX L4734
	r_PackedHalf2AtPtx4737R1525 =
		HalfAdd(r_PackedHalf2AtPtx4286R1843, r_MmaAccumulatorHalf2WordAtPtx3508R1298); // PTX L4737
	r_LaneIndexAtPtx4741 = uint32_t((threadIdx.x & 31u));							   // PTX L4741
	r_PackedHalf2AtPtx4744R1527 =
		HalfAdd(r_PackedHalf2AtPtx4307R1845, r_MmaAccumulatorHalf2WordAtPtx3529R1301); // PTX L4744
	r_LaneIndexAtPtx4748 = uint32_t((threadIdx.x & 31u));							   // PTX L4748
	r_PackedHalf2AtPtx4751R1528 =
		HalfAdd(r_PackedHalf2AtPtx4308R1846, r_MmaAccumulatorHalf2WordAtPtx3529R1302); // PTX L4751
	r_LaneIndexAtPtx4755 = uint32_t((threadIdx.x & 31u));							   // PTX L4755
	r_PackedHalf2AtPtx4758R1529 =
		HalfAdd(r_PackedHalf2AtPtx4309R1847, r_MmaAccumulatorHalf2WordAtPtx3536R1305); // PTX L4758
	r_LaneIndexAtPtx4762 = uint32_t((threadIdx.x & 31u));							   // PTX L4762
	r_PackedHalf2AtPtx4765R1530 =
		HalfAdd(r_PackedHalf2AtPtx4310R1848, r_MmaAccumulatorHalf2WordAtPtx3536R1306); // PTX L4765
	r_LaneIndexAtPtx4769 = uint32_t((threadIdx.x & 31u));							   // PTX L4769
	r_PackedHalf2AtPtx4772R1532 =
		HalfAdd(r_PackedHalf2AtPtx4345R1850, r_MmaAccumulatorHalf2WordAtPtx3557R1309); // PTX L4772
	r_LaneIndexAtPtx4776 = uint32_t((threadIdx.x & 31u));							   // PTX L4776
	r_PackedHalf2AtPtx4779R1533 =
		HalfAdd(r_PackedHalf2AtPtx4330R1851, r_MmaAccumulatorHalf2WordAtPtx3557R1310); // PTX L4779
	r_LaneIndexAtPtx4783 = uint32_t((threadIdx.x & 31u));							   // PTX L4783
	r_PackedHalf2AtPtx4786R1534 =
		HalfAdd(r_PackedHalf2AtPtx4331R1852, r_MmaAccumulatorHalf2WordAtPtx3564R1313); // PTX L4786
	r_LaneIndexAtPtx4790 = uint32_t((threadIdx.x & 31u));							   // PTX L4790
	r_PackedHalf2AtPtx4793R1535 =
		HalfAdd(r_PackedHalf2AtPtx4332R1853, r_MmaAccumulatorHalf2WordAtPtx3564R1314);			  // PTX L4793
	r_bPtxPredicate102 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister4);					  // PTX L4796
	r_PtxRegister1454 = ShiftLeft(uint32_t(r_PtxRegister46), uint32_t(13));						  // PTX L4797
	r_PtxRegister1455 = uint32_t(r_PtxRegister1454) + uint32_t(r_PtxRegister6);					  // PTX L4798
	r_PtxU64Register338 = uint64_t(int64_t(int32_t(r_PtxRegister1455)) * int64_t(int32_t(4)));	  // PTX L4799
	g_OutputByteAddressAtPtx4800 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register338); // PTX L4800
	if (r_bPtxPredicate102)
	{
		goto L__BB56_194;
	} // PTX L4801
	r_LaneIndexAtPtx4803 = uint32_t((threadIdx.x & 31u)); // PTX L4803
	r_PtxU64Register343 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4803)) * int64_t(int32_t(16))); // PTX L4805
	g_OutputByteAddressAtPtx4806 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register343); // PTX L4806
	StoreNoAllocate(g_OutputByteAddressAtPtx4806,
					make_uint4(r_PackedHalf2AtPtx4352R1457, r_PackedHalf2AtPtx4359R1458,
							   r_PackedHalf2AtPtx4366R1459,
							   r_PackedHalf2AtPtx4373R1460)); // PTX L4808
	r_LaneIndexAtPtx4811 = uint32_t((threadIdx.x & 31u));	  // PTX L4811
	r_PtxU64Register344 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4811)) * int64_t(int32_t(16))); // PTX L4813
	g_OutputByteAddressAtPtx4814 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register344);			   // PTX L4814
	g_OutputByteAddressAtPtx4815 = uint64_t(g_OutputByteAddressAtPtx4814) + uint64_t(512); // PTX L4815
	StoreNoAllocate(g_OutputByteAddressAtPtx4815,
					make_uint4(r_PackedHalf2AtPtx4380R1462, r_PackedHalf2AtPtx4387R1463,
							   r_PackedHalf2AtPtx4394R1464,
							   r_PackedHalf2AtPtx4401R1465)); // PTX L4817
	r_LaneIndexAtPtx4820 = uint32_t((threadIdx.x & 31u));	  // PTX L4820
	r_PtxU64Register346 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4820)) * int64_t(int32_t(16))); // PTX L4822
	g_OutputByteAddressAtPtx4823 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register346);				// PTX L4823
	g_OutputByteAddressAtPtx4824 = uint64_t(g_OutputByteAddressAtPtx4823) + uint64_t(1024); // PTX L4824
	StoreNoAllocate(g_OutputByteAddressAtPtx4824,
					make_uint4(r_PackedHalf2AtPtx4408R1467, r_PackedHalf2AtPtx4415R1468,
							   r_PackedHalf2AtPtx4422R1469,
							   r_PackedHalf2AtPtx4429R1470)); // PTX L4826
	r_LaneIndexAtPtx4829 = uint32_t((threadIdx.x & 31u));	  // PTX L4829
	r_PtxU64Register348 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4829)) * int64_t(int32_t(16))); // PTX L4831
	g_OutputByteAddressAtPtx4832 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register348);				// PTX L4832
	g_OutputByteAddressAtPtx4833 = uint64_t(g_OutputByteAddressAtPtx4832) + uint64_t(1536); // PTX L4833
	StoreNoAllocate(g_OutputByteAddressAtPtx4833,
					make_uint4(r_PackedHalf2AtPtx4436R1472, r_PackedHalf2AtPtx4443R1473,
							   r_PackedHalf2AtPtx4450R1474,
							   r_PackedHalf2AtPtx4457R1475));								 // PTX L4835
L__BB56_194:																				 // PTX L4837
	r_bPtxPredicate103 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister4);				 // PTX L4838
	g_OutputByteAddressAtPtx4839 = uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(32768); // PTX L4839
	if (r_bPtxPredicate103)
	{
		goto L__BB56_196;
	} // PTX L4840
	r_LaneIndexAtPtx4842 = uint32_t((threadIdx.x & 31u)); // PTX L4842
	r_PtxU64Register354 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4842)) * int64_t(int32_t(16))); // PTX L4844
	g_OutputByteAddressAtPtx4845 =
		uint64_t(g_OutputByteAddressAtPtx4839) + uint64_t(r_PtxU64Register354); // PTX L4845
	StoreNoAllocate(g_OutputByteAddressAtPtx4845,
					make_uint4(r_PackedHalf2AtPtx4464R1477, r_PackedHalf2AtPtx4471R1478,
							   r_PackedHalf2AtPtx4478R1479,
							   r_PackedHalf2AtPtx4485R1480)); // PTX L4847
	r_LaneIndexAtPtx4850 = uint32_t((threadIdx.x & 31u));	  // PTX L4850
	r_PtxU64Register355 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4850)) * int64_t(int32_t(16))); // PTX L4852
	g_OutputByteAddressAtPtx4853 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register355);				 // PTX L4853
	g_OutputByteAddressAtPtx4854 = uint64_t(g_OutputByteAddressAtPtx4853) + uint64_t(33280); // PTX L4854
	StoreNoAllocate(g_OutputByteAddressAtPtx4854,
					make_uint4(r_PackedHalf2AtPtx4492R1482, r_PackedHalf2AtPtx4499R1483,
							   r_PackedHalf2AtPtx4506R1484,
							   r_PackedHalf2AtPtx4513R1485)); // PTX L4856
	r_LaneIndexAtPtx4859 = uint32_t((threadIdx.x & 31u));	  // PTX L4859
	r_PtxU64Register357 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4859)) * int64_t(int32_t(16))); // PTX L4861
	g_OutputByteAddressAtPtx4862 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register357);				 // PTX L4862
	g_OutputByteAddressAtPtx4863 = uint64_t(g_OutputByteAddressAtPtx4862) + uint64_t(33792); // PTX L4863
	StoreNoAllocate(g_OutputByteAddressAtPtx4863,
					make_uint4(r_PackedHalf2AtPtx4520R1487, r_PackedHalf2AtPtx4527R1488,
							   r_PackedHalf2AtPtx4534R1489,
							   r_PackedHalf2AtPtx4541R1490)); // PTX L4865
	r_LaneIndexAtPtx4868 = uint32_t((threadIdx.x & 31u));	  // PTX L4868
	r_PtxU64Register359 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4868)) * int64_t(int32_t(16))); // PTX L4870
	g_OutputByteAddressAtPtx4871 =
		uint64_t(g_OutputByteAddressAtPtx4800) + uint64_t(r_PtxU64Register359);				 // PTX L4871
	g_OutputByteAddressAtPtx4872 = uint64_t(g_OutputByteAddressAtPtx4871) + uint64_t(34304); // PTX L4872
	StoreNoAllocate(g_OutputByteAddressAtPtx4872,
					make_uint4(r_PackedHalf2AtPtx4548R1492, r_PackedHalf2AtPtx4555R1493,
							   r_PackedHalf2AtPtx4562R1494,
							   r_PackedHalf2AtPtx4569R1495));								 // PTX L4874
L__BB56_196:																				 // PTX L4876
	r_bPtxPredicate104 = int32_t(r_PtxRegister48) >= int32_t(r_PtxRegister4);				 // PTX L4877
	g_OutputByteAddressAtPtx4878 = uint64_t(g_OutputByteAddressAtPtx4839) + uint64_t(32768); // PTX L4878
	if (r_bPtxPredicate104)
	{
		goto L__BB56_198;
	} // PTX L4879
	r_LaneIndexAtPtx4881 = uint32_t((threadIdx.x & 31u)); // PTX L4881
	r_PtxU64Register365 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4881)) * int64_t(int32_t(16))); // PTX L4883
	g_OutputByteAddressAtPtx4884 =
		uint64_t(g_OutputByteAddressAtPtx4878) + uint64_t(r_PtxU64Register365); // PTX L4884
	StoreNoAllocate(g_OutputByteAddressAtPtx4884,
					make_uint4(r_PackedHalf2AtPtx4576R1497, r_PackedHalf2AtPtx4583R1498,
							   r_PackedHalf2AtPtx4590R1499,
							   r_PackedHalf2AtPtx4597R1500)); // PTX L4886
	r_LaneIndexAtPtx4889 = uint32_t((threadIdx.x & 31u));	  // PTX L4889
	r_PtxU64Register366 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4889)) * int64_t(int32_t(16))); // PTX L4891
	g_OutputByteAddressAtPtx4892 =
		uint64_t(g_OutputByteAddressAtPtx4839) + uint64_t(r_PtxU64Register366);				 // PTX L4892
	g_OutputByteAddressAtPtx4893 = uint64_t(g_OutputByteAddressAtPtx4892) + uint64_t(33280); // PTX L4893
	StoreNoAllocate(g_OutputByteAddressAtPtx4893,
					make_uint4(r_PackedHalf2AtPtx4604R1502, r_PackedHalf2AtPtx4611R1503,
							   r_PackedHalf2AtPtx4618R1504,
							   r_PackedHalf2AtPtx4625R1505)); // PTX L4895
	r_LaneIndexAtPtx4898 = uint32_t((threadIdx.x & 31u));	  // PTX L4898
	r_PtxU64Register368 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4898)) * int64_t(int32_t(16))); // PTX L4900
	g_OutputByteAddressAtPtx4901 =
		uint64_t(g_OutputByteAddressAtPtx4839) + uint64_t(r_PtxU64Register368);				 // PTX L4901
	g_OutputByteAddressAtPtx4902 = uint64_t(g_OutputByteAddressAtPtx4901) + uint64_t(33792); // PTX L4902
	StoreNoAllocate(g_OutputByteAddressAtPtx4902,
					make_uint4(r_PackedHalf2AtPtx4632R1507, r_PackedHalf2AtPtx4639R1508,
							   r_PackedHalf2AtPtx4646R1509,
							   r_PackedHalf2AtPtx4653R1510)); // PTX L4904
	r_LaneIndexAtPtx4907 = uint32_t((threadIdx.x & 31u));	  // PTX L4907
	r_PtxU64Register370 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4907)) * int64_t(int32_t(16))); // PTX L4909
	g_OutputByteAddressAtPtx4910 =
		uint64_t(g_OutputByteAddressAtPtx4839) + uint64_t(r_PtxU64Register370);				 // PTX L4910
	g_OutputByteAddressAtPtx4911 = uint64_t(g_OutputByteAddressAtPtx4910) + uint64_t(34304); // PTX L4911
	StoreNoAllocate(g_OutputByteAddressAtPtx4911,
					make_uint4(r_PackedHalf2AtPtx4660R1512, r_PackedHalf2AtPtx4667R1513,
							   r_PackedHalf2AtPtx4674R1514,
							   r_PackedHalf2AtPtx4681R1515));				  // PTX L4913
L__BB56_198:																  // PTX L4915
	r_bPtxPredicate105 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4); // PTX L4916
	if (r_bPtxPredicate105)
	{
		goto L__BB56_200;
	} // PTX L4917
	r_LaneIndexAtPtx4919 = uint32_t((threadIdx.x & 31u)); // PTX L4919
	r_PtxU64Register376 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4919)) * int64_t(int32_t(16))); // PTX L4921
	g_OutputByteAddressAtPtx4922 =
		uint64_t(g_OutputByteAddressAtPtx4878) + uint64_t(r_PtxU64Register376);				 // PTX L4922
	g_OutputByteAddressAtPtx4923 = uint64_t(g_OutputByteAddressAtPtx4922) + uint64_t(32768); // PTX L4923
	StoreNoAllocate(g_OutputByteAddressAtPtx4923,
					make_uint4(r_PackedHalf2AtPtx4688R1517, r_PackedHalf2AtPtx4695R1518,
							   r_PackedHalf2AtPtx4702R1519,
							   r_PackedHalf2AtPtx4709R1520)); // PTX L4925
	r_LaneIndexAtPtx4928 = uint32_t((threadIdx.x & 31u));	  // PTX L4928
	r_PtxU64Register378 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4928)) * int64_t(int32_t(16))); // PTX L4930
	g_OutputByteAddressAtPtx4931 =
		uint64_t(g_OutputByteAddressAtPtx4878) + uint64_t(r_PtxU64Register378);				 // PTX L4931
	g_OutputByteAddressAtPtx4932 = uint64_t(g_OutputByteAddressAtPtx4931) + uint64_t(33280); // PTX L4932
	StoreNoAllocate(g_OutputByteAddressAtPtx4932,
					make_uint4(r_PackedHalf2AtPtx4716R1522, r_PackedHalf2AtPtx4723R1523,
							   r_PackedHalf2AtPtx4730R1524,
							   r_PackedHalf2AtPtx4737R1525)); // PTX L4934
	r_LaneIndexAtPtx4937 = uint32_t((threadIdx.x & 31u));	  // PTX L4937
	r_PtxU64Register380 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4937)) * int64_t(int32_t(16))); // PTX L4939
	g_OutputByteAddressAtPtx4940 =
		uint64_t(g_OutputByteAddressAtPtx4878) + uint64_t(r_PtxU64Register380);				 // PTX L4940
	g_OutputByteAddressAtPtx4941 = uint64_t(g_OutputByteAddressAtPtx4940) + uint64_t(33792); // PTX L4941
	StoreNoAllocate(g_OutputByteAddressAtPtx4941,
					make_uint4(r_PackedHalf2AtPtx4744R1527, r_PackedHalf2AtPtx4751R1528,
							   r_PackedHalf2AtPtx4758R1529,
							   r_PackedHalf2AtPtx4765R1530)); // PTX L4943
	r_LaneIndexAtPtx4946 = uint32_t((threadIdx.x & 31u));	  // PTX L4946
	r_PtxU64Register382 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4946)) * int64_t(int32_t(16))); // PTX L4948
	g_OutputByteAddressAtPtx4949 =
		uint64_t(g_OutputByteAddressAtPtx4878) + uint64_t(r_PtxU64Register382);				 // PTX L4949
	g_OutputByteAddressAtPtx4950 = uint64_t(g_OutputByteAddressAtPtx4949) + uint64_t(34304); // PTX L4950
	StoreNoAllocate(g_OutputByteAddressAtPtx4950,
					make_uint4(r_PackedHalf2AtPtx4772R1532, r_PackedHalf2AtPtx4779R1533,
							   r_PackedHalf2AtPtx4786R1534,
							   r_PackedHalf2AtPtx4793R1535));		 // PTX L4952
L__BB56_200:														 // PTX L4954
	__syncthreads();												 // PTX L4955
	r_ThreadZAtPtx4956 = uint32_t(threadIdx.z);						 // PTX L4956
	r_PtxRegister1595 = r_PtxRegister66 | r_ThreadZAtPtx4956;		 // PTX L4957
	r_bPtxPredicate114 = uint32_t(r_PtxRegister1595) != uint32_t(0); // PTX L4958
	if (r_bPtxPredicate114)
	{
		goto L__BB56_202;
	} // PTX L4959
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(g_CounterByteAddress, r_CtaZ);							// PTX L4961
L__BB56_202:																	// PTX L4963
	return;																		// PTX L4964
L__BB56_124:																	// PTX L4965
	r_PtxRegister40 = uint32_t(r_CtaZ) + uint32_t(-1);							// PTX L4966
L__BB56_125:																	// PTX L4967
	r_PtxRegister1341 = CounterLoadRelaxed(g_CounterByteAddress);				// PTX L4969
	r_bPtxPredicate69 = int32_t(r_PtxRegister1341) >= int32_t(r_PtxRegister40); // PTX L4971
	if (r_bPtxPredicate69)
	{
		goto L__BB56_143;
	} // PTX L4972
	r_PtxRegister1572 = uint32_t(64); // PTX L4973
	PollSleep(r_PtxRegister1572);	  // PTX L4975
	goto L__BB56_125;				  // PTX L4977
#endif
}
} // namespace dlssnr::reconstructed::global_projection_c1024_fp16
