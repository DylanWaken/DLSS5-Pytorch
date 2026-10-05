// Readable equivalent of cc_vit_1d_ffn_expand; not the historical C++ file.
#pragma once
#include "global_ffn_expand_c1024_abi_fp16.cuh"

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16
{
__global__ __maxnreg__(168) void global_ffn_expand_c1024_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_SharedStorage[24600];
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
	bool r_bPtxPredicate61, r_bPtxPredicate62, r_bPtxPredicate63, r_bPtxPredicate64, r_bPtxPredicate65;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint16_t r_PtxU16Register13, r_PtxU16Register14, r_PtxU16Register15, r_PtxU16Register16,
		r_PtxU16Register17, r_PtxU16Register18, r_PtxU16Register19, r_PtxU16Register20, r_PtxU16Register21,
		r_PtxU16Register22, r_PtxU16Register23, r_PtxU16Register24;
	uint16_t r_PtxU16Register25, r_PtxU16Register26, r_PtxU16Register27;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_ThreadY,
		r_PtxRegister7, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_BatchBits, r_TokensBits, r_CtaX, r_PtxRegister46, r_PtxRegister47, r_PtxRegister48;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53,
		r_PtxRegister54, r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_ThreadX, r_PtxRegister59,
		r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_BlockSizeX, r_BlockSizeY,
		r_Float32BitsAtPtx58R66, r_LaneIndexAtPtx74, r_LaneIndexAtPtx82, r_LaneIndexAtPtx91,
		r_LaneIndexAtPtx100, r_LaneIndexAtPtx109, r_LaneIndexAtPtx118;
	uint32_t r_LaneIndexAtPtx127, r_LaneIndexAtPtx136, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_LaneIndexAtPtx242, r_PtxRegister94,
		r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_LaneIndexAtPtx284,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PtxRegister119, r_LaneIndexAtPtx384;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_LaneIndexAtPtx432, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_LaneIndexAtPtx533,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_LaneIndexAtPtx577, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_PtxRegister190,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_LaneIndexAtPtx672, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_PtxRegister203, r_LaneIndexAtPtx716;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_LaneIndexAtPtx813,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_LaneIndexAtPtx857, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244, r_PtxRegister245,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_LaneIndexAtPtx952, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_LaneIndexAtPtx996,
		r_PtxRegister270, r_PackedHalf2AtPtx60R271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_LaneIndexAtPtx1109,
		r_PtxRegister287, r_LaneIndexAtPtx1118;
	uint32_t r_PtxRegister289, r_LaneIndexAtPtx1128, r_PtxRegister291, r_LaneIndexAtPtx1137, r_PtxRegister293,
		r_LaneIndexAtPtx1146, r_PtxRegister295, r_LaneIndexAtPtx1155, r_PtxRegister297, r_LaneIndexAtPtx1164,
		r_PtxRegister299, r_LaneIndexAtPtx1173;
	uint32_t r_PtxRegister301, r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303,
		r_MmaAHalf2WordAtPtx1115R304, r_MmaAHalf2WordAtPtx1115R305, r_MmaAHalf2WordAtPtx1125R306,
		r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308, r_MmaAHalf2WordAtPtx1125R309,
		r_MmaAccumulatorHalf2WordAtPtx1182R310, r_MmaAccumulatorHalf2WordAtPtx1182R311,
		r_MmaAccumulatorHalf2WordAtPtx1189R312;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1189R313, r_MmaAccumulatorHalf2WordAtPtx1210R314,
		r_MmaAccumulatorHalf2WordAtPtx1210R315, r_MmaAccumulatorHalf2WordAtPtx1217R316,
		r_MmaAccumulatorHalf2WordAtPtx1217R317, r_MmaAccumulatorHalf2WordAtPtx1238R318,
		r_MmaAccumulatorHalf2WordAtPtx1238R319, r_MmaAccumulatorHalf2WordAtPtx1245R320,
		r_MmaAccumulatorHalf2WordAtPtx1245R321, r_MmaAccumulatorHalf2WordAtPtx1266R322,
		r_MmaAccumulatorHalf2WordAtPtx1266R323, r_MmaAccumulatorHalf2WordAtPtx1273R324;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1273R325, r_MmaAHalf2WordAtPtx1134R326,
		r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328, r_MmaAHalf2WordAtPtx1134R329,
		r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
		r_MmaAHalf2WordAtPtx1143R333, r_MmaAccumulatorHalf2WordAtPtx1294R334,
		r_MmaAccumulatorHalf2WordAtPtx1294R335, r_MmaAccumulatorHalf2WordAtPtx1301R336;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1301R337, r_MmaAccumulatorHalf2WordAtPtx1322R338,
		r_MmaAccumulatorHalf2WordAtPtx1322R339, r_MmaAccumulatorHalf2WordAtPtx1329R340,
		r_MmaAccumulatorHalf2WordAtPtx1329R341, r_MmaAccumulatorHalf2WordAtPtx1350R342,
		r_MmaAccumulatorHalf2WordAtPtx1350R343, r_MmaAccumulatorHalf2WordAtPtx1357R344,
		r_MmaAccumulatorHalf2WordAtPtx1357R345, r_MmaAccumulatorHalf2WordAtPtx1378R346,
		r_MmaAccumulatorHalf2WordAtPtx1378R347, r_MmaAccumulatorHalf2WordAtPtx1385R348;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1385R349, r_MmaAHalf2WordAtPtx1152R350,
		r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352, r_MmaAHalf2WordAtPtx1152R353,
		r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
		r_MmaAHalf2WordAtPtx1161R357, r_MmaAccumulatorHalf2WordAtPtx1406R358,
		r_MmaAccumulatorHalf2WordAtPtx1406R359, r_MmaAccumulatorHalf2WordAtPtx1413R360;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1413R361, r_MmaAccumulatorHalf2WordAtPtx1434R362,
		r_MmaAccumulatorHalf2WordAtPtx1434R363, r_MmaAccumulatorHalf2WordAtPtx1441R364,
		r_MmaAccumulatorHalf2WordAtPtx1441R365, r_MmaAccumulatorHalf2WordAtPtx1462R366,
		r_MmaAccumulatorHalf2WordAtPtx1462R367, r_MmaAccumulatorHalf2WordAtPtx1469R368,
		r_MmaAccumulatorHalf2WordAtPtx1469R369, r_MmaAccumulatorHalf2WordAtPtx1490R370,
		r_MmaAccumulatorHalf2WordAtPtx1490R371, r_MmaAccumulatorHalf2WordAtPtx1497R372;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1497R373, r_MmaAHalf2WordAtPtx1170R374,
		r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376, r_MmaAHalf2WordAtPtx1170R377,
		r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
		r_MmaAHalf2WordAtPtx1179R381, r_MmaAccumulatorHalf2WordAtPtx1518R382,
		r_MmaAccumulatorHalf2WordAtPtx1518R383, r_MmaAccumulatorHalf2WordAtPtx1525R384;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1525R385, r_MmaAccumulatorHalf2WordAtPtx1546R386,
		r_MmaAccumulatorHalf2WordAtPtx1546R387, r_MmaAccumulatorHalf2WordAtPtx1553R388,
		r_MmaAccumulatorHalf2WordAtPtx1553R389, r_MmaAccumulatorHalf2WordAtPtx1574R390,
		r_MmaAccumulatorHalf2WordAtPtx1574R391, r_MmaAccumulatorHalf2WordAtPtx1581R392,
		r_MmaAccumulatorHalf2WordAtPtx1581R393, r_MmaAccumulatorHalf2WordAtPtx1602R394,
		r_MmaAccumulatorHalf2WordAtPtx1602R395, r_MmaAccumulatorHalf2WordAtPtx1609R396;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1609R397, r_PtxRegister398, r_PtxRegister399, r_PtxRegister400,
		r_PtxRegister401, r_PtxRegister402, r_PtxRegister403, r_PtxRegister404, r_PtxRegister405,
		r_PtxRegister406, r_PtxRegister407, r_PtxRegister408;
	uint32_t r_PtxRegister409, r_PtxRegister410, r_PtxRegister411, r_PtxRegister412, r_PtxRegister413,
		r_PtxRegister414, r_PtxRegister415, r_PtxRegister416, r_PtxRegister417, r_PtxRegister418,
		r_PtxRegister419, r_LaneIndexAtPtx1638;
	uint32_t r_LaneIndexAtPtx1646, r_LaneIndexAtPtx1655, r_LaneIndexAtPtx1664, r_LaneIndexAtPtx1673,
		r_LaneIndexAtPtx1682, r_LaneIndexAtPtx1691, r_LaneIndexAtPtx1700, r_PtxRegister428, r_PtxRegister429,
		r_PtxRegister430, r_PtxRegister431, r_PtxRegister432;
	uint32_t r_PtxRegister433, r_PtxRegister434, r_PtxRegister435, r_PtxRegister436, r_PtxRegister437,
		r_PtxRegister438, r_PtxRegister439, r_PtxRegister440, r_PtxRegister441, r_PtxRegister442,
		r_PtxRegister443, r_PtxRegister444;
	uint32_t r_PtxRegister445, r_PtxRegister446, r_PtxRegister447, r_PtxRegister448, r_LaneIndexAtPtx1823,
		r_PtxRegister450, r_PtxRegister451, r_PtxRegister452, r_PtxRegister453, r_PtxRegister454,
		r_PtxRegister455, r_PtxRegister456;
	uint32_t r_LaneIndexAtPtx1863, r_PtxRegister458, r_PtxRegister459, r_PtxRegister460, r_PtxRegister461,
		r_PtxRegister462, r_PtxRegister463, r_PtxRegister464, r_PtxRegister465, r_PtxRegister466,
		r_PtxRegister467, r_PtxRegister468;
	uint32_t r_PtxRegister469, r_PtxRegister470, r_PtxRegister471, r_PtxRegister472, r_LaneIndexAtPtx1946,
		r_PtxRegister474, r_PtxRegister475, r_PtxRegister476, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx1986, r_PtxRegister482, r_PtxRegister483, r_PtxRegister484, r_PtxRegister485,
		r_PtxRegister486, r_PtxRegister487, r_PtxRegister488, r_LaneIndexAtPtx1999,
		r_Float32BitsAtPtx2001R490, r_Float32BitsAtPtx2008R491, r_Float32BitsAtPtx2015R492;
	uint32_t r_Float32BitsAtPtx2022R493, r_Float32BitsAtPtx2029R494, r_PackedHalf2AtPtx2010R495,
		r_PackedHalf2AtPtx2037R496, r_PackedHalf2AtPtx2003R497, r_PackedHalf2AtPtx2041R498,
		r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2045R500, r_PackedHalf2AtPtx2024R501,
		r_PackedHalf2AtPtx2049R502, r_PackedHalf2AtPtx2017R503, r_PackedHalf2AtPtx2053R504;
	uint32_t r_LaneIndexAtPtx2061, r_PackedHalf2AtPtx2064R506, r_PackedHalf2AtPtx2068R507,
		r_PackedHalf2AtPtx2072R508, r_PackedHalf2AtPtx2076R509, r_PackedHalf2AtPtx2080R510,
		r_LaneIndexAtPtx2088, r_PackedHalf2AtPtx2091R512, r_PackedHalf2AtPtx2095R513,
		r_PackedHalf2AtPtx2099R514, r_PackedHalf2AtPtx2103R515, r_PackedHalf2AtPtx2107R516;
	uint32_t r_LaneIndexAtPtx2115, r_PackedHalf2AtPtx2118R518, r_PackedHalf2AtPtx2122R519,
		r_PackedHalf2AtPtx2126R520, r_PackedHalf2AtPtx2130R521, r_PackedHalf2AtPtx2134R522,
		r_LaneIndexAtPtx2142, r_PackedHalf2AtPtx2145R524, r_PackedHalf2AtPtx2149R525,
		r_PackedHalf2AtPtx2153R526, r_PackedHalf2AtPtx2157R527, r_PackedHalf2AtPtx2161R528;
	uint32_t r_LaneIndexAtPtx2169, r_PackedHalf2AtPtx2172R530, r_PackedHalf2AtPtx2176R531,
		r_PackedHalf2AtPtx2180R532, r_PackedHalf2AtPtx2184R533, r_PackedHalf2AtPtx2188R534,
		r_LaneIndexAtPtx2196, r_PackedHalf2AtPtx2199R536, r_PackedHalf2AtPtx2203R537,
		r_PackedHalf2AtPtx2207R538, r_PackedHalf2AtPtx2211R539, r_PackedHalf2AtPtx2215R540;
	uint32_t r_LaneIndexAtPtx2223, r_PackedHalf2AtPtx2226R542, r_PackedHalf2AtPtx2230R543,
		r_PackedHalf2AtPtx2234R544, r_PackedHalf2AtPtx2238R545, r_PackedHalf2AtPtx2242R546,
		r_LaneIndexAtPtx2250, r_PackedHalf2AtPtx2253R548, r_PackedHalf2AtPtx2257R549,
		r_PackedHalf2AtPtx2261R550, r_PackedHalf2AtPtx2265R551, r_PackedHalf2AtPtx2269R552;
	uint32_t r_LaneIndexAtPtx2277, r_PackedHalf2AtPtx2280R554, r_PackedHalf2AtPtx2284R555,
		r_PackedHalf2AtPtx2288R556, r_PackedHalf2AtPtx2292R557, r_PackedHalf2AtPtx2296R558,
		r_LaneIndexAtPtx2304, r_PackedHalf2AtPtx2307R560, r_PackedHalf2AtPtx2311R561,
		r_PackedHalf2AtPtx2315R562, r_PackedHalf2AtPtx2319R563, r_PackedHalf2AtPtx2323R564;
	uint32_t r_LaneIndexAtPtx2331, r_PackedHalf2AtPtx2334R566, r_PackedHalf2AtPtx2338R567,
		r_PackedHalf2AtPtx2342R568, r_PackedHalf2AtPtx2346R569, r_PackedHalf2AtPtx2350R570,
		r_LaneIndexAtPtx2358, r_PackedHalf2AtPtx2361R572, r_PackedHalf2AtPtx2365R573,
		r_PackedHalf2AtPtx2369R574, r_PackedHalf2AtPtx2373R575, r_PackedHalf2AtPtx2377R576;
	uint32_t r_LaneIndexAtPtx2385, r_PackedHalf2AtPtx2388R578, r_PackedHalf2AtPtx2392R579,
		r_PackedHalf2AtPtx2396R580, r_PackedHalf2AtPtx2400R581, r_PackedHalf2AtPtx2404R582,
		r_LaneIndexAtPtx2412, r_PackedHalf2AtPtx2415R584, r_PackedHalf2AtPtx2419R585,
		r_PackedHalf2AtPtx2423R586, r_PackedHalf2AtPtx2427R587, r_PackedHalf2AtPtx2431R588;
	uint32_t r_LaneIndexAtPtx2439, r_PackedHalf2AtPtx2442R590, r_PackedHalf2AtPtx2446R591,
		r_PackedHalf2AtPtx2450R592, r_PackedHalf2AtPtx2454R593, r_PackedHalf2AtPtx2458R594,
		r_LaneIndexAtPtx2466, r_PackedHalf2AtPtx2469R596, r_PackedHalf2AtPtx2473R597,
		r_PackedHalf2AtPtx2477R598, r_PackedHalf2AtPtx2481R599, r_PackedHalf2AtPtx2485R600;
	uint32_t r_LaneIndexAtPtx2493, r_PackedHalf2AtPtx2496R602, r_PackedHalf2AtPtx2500R603,
		r_PackedHalf2AtPtx2504R604, r_PackedHalf2AtPtx2508R605, r_PackedHalf2AtPtx2512R606,
		r_LaneIndexAtPtx2520, r_PackedHalf2AtPtx2523R608, r_PackedHalf2AtPtx2527R609,
		r_PackedHalf2AtPtx2531R610, r_PackedHalf2AtPtx2535R611, r_PackedHalf2AtPtx2539R612;
	uint32_t r_LaneIndexAtPtx2547, r_PackedHalf2AtPtx2550R614, r_PackedHalf2AtPtx2554R615,
		r_PackedHalf2AtPtx2558R616, r_PackedHalf2AtPtx2562R617, r_PackedHalf2AtPtx2566R618,
		r_LaneIndexAtPtx2574, r_PackedHalf2AtPtx2577R620, r_PackedHalf2AtPtx2581R621,
		r_PackedHalf2AtPtx2585R622, r_PackedHalf2AtPtx2589R623, r_PackedHalf2AtPtx2593R624;
	uint32_t r_LaneIndexAtPtx2601, r_PackedHalf2AtPtx2604R626, r_PackedHalf2AtPtx2608R627,
		r_PackedHalf2AtPtx2612R628, r_PackedHalf2AtPtx2616R629, r_PackedHalf2AtPtx2620R630,
		r_LaneIndexAtPtx2628, r_PackedHalf2AtPtx2631R632, r_PackedHalf2AtPtx2635R633,
		r_PackedHalf2AtPtx2639R634, r_PackedHalf2AtPtx2643R635, r_PackedHalf2AtPtx2647R636;
	uint32_t r_LaneIndexAtPtx2655, r_PackedHalf2AtPtx2658R638, r_PackedHalf2AtPtx2662R639,
		r_PackedHalf2AtPtx2666R640, r_PackedHalf2AtPtx2670R641, r_PackedHalf2AtPtx2674R642,
		r_LaneIndexAtPtx2682, r_PackedHalf2AtPtx2685R644, r_PackedHalf2AtPtx2689R645,
		r_PackedHalf2AtPtx2693R646, r_PackedHalf2AtPtx2697R647, r_PackedHalf2AtPtx2701R648;
	uint32_t r_LaneIndexAtPtx2709, r_PackedHalf2AtPtx2712R650, r_PackedHalf2AtPtx2716R651,
		r_PackedHalf2AtPtx2720R652, r_PackedHalf2AtPtx2724R653, r_PackedHalf2AtPtx2728R654,
		r_LaneIndexAtPtx2736, r_PackedHalf2AtPtx2739R656, r_PackedHalf2AtPtx2743R657,
		r_PackedHalf2AtPtx2747R658, r_PackedHalf2AtPtx2751R659, r_PackedHalf2AtPtx2755R660;
	uint32_t r_LaneIndexAtPtx2763, r_PackedHalf2AtPtx2766R662, r_PackedHalf2AtPtx2770R663,
		r_PackedHalf2AtPtx2774R664, r_PackedHalf2AtPtx2778R665, r_PackedHalf2AtPtx2782R666,
		r_LaneIndexAtPtx2790, r_PackedHalf2AtPtx2793R668, r_PackedHalf2AtPtx2797R669,
		r_PackedHalf2AtPtx2801R670, r_PackedHalf2AtPtx2805R671, r_PackedHalf2AtPtx2809R672;
	uint32_t r_LaneIndexAtPtx2817, r_PackedHalf2AtPtx2820R674, r_PackedHalf2AtPtx2824R675,
		r_PackedHalf2AtPtx2828R676, r_PackedHalf2AtPtx2832R677, r_PackedHalf2AtPtx2836R678,
		r_LaneIndexAtPtx2844, r_PackedHalf2AtPtx2847R680, r_PackedHalf2AtPtx2851R681,
		r_PackedHalf2AtPtx2855R682, r_PackedHalf2AtPtx2859R683, r_PackedHalf2AtPtx2863R684;
	uint32_t r_LaneIndexAtPtx2871, r_PackedHalf2AtPtx2874R686, r_PackedHalf2AtPtx2878R687,
		r_PackedHalf2AtPtx2882R688, r_PackedHalf2AtPtx2886R689, r_PackedHalf2AtPtx2890R690,
		r_LaneIndexAtPtx2898, r_PackedHalf2AtPtx2901R692, r_PackedHalf2AtPtx2905R693,
		r_PackedHalf2AtPtx2909R694, r_PackedHalf2AtPtx2913R695, r_PackedHalf2AtPtx2917R696;
	uint32_t r_LaneIndexAtPtx2925, r_PackedHalf2AtPtx2928R698, r_PackedHalf2AtPtx2932R699,
		r_PackedHalf2AtPtx2936R700, r_PackedHalf2AtPtx2940R701, r_PackedHalf2AtPtx2944R702,
		r_LaneIndexAtPtx2952, r_PackedHalf2AtPtx2955R704, r_PackedHalf2AtPtx2959R705,
		r_PackedHalf2AtPtx2963R706, r_PackedHalf2AtPtx2967R707, r_PackedHalf2AtPtx2971R708;
	uint32_t r_LaneIndexAtPtx2979, r_PackedHalf2AtPtx2982R710, r_PackedHalf2AtPtx2986R711,
		r_PackedHalf2AtPtx2990R712, r_PackedHalf2AtPtx2994R713, r_PackedHalf2AtPtx2998R714,
		r_LaneIndexAtPtx3006, r_PackedHalf2AtPtx3009R716, r_PackedHalf2AtPtx3013R717,
		r_PackedHalf2AtPtx3017R718, r_PackedHalf2AtPtx3021R719, r_PackedHalf2AtPtx3025R720;
	uint32_t r_LaneIndexAtPtx3033, r_PackedHalf2AtPtx3036R722, r_PackedHalf2AtPtx3040R723,
		r_PackedHalf2AtPtx3044R724, r_PackedHalf2AtPtx3048R725, r_PackedHalf2AtPtx3052R726,
		r_LaneIndexAtPtx3060, r_PackedHalf2AtPtx3063R728, r_PackedHalf2AtPtx3067R729,
		r_PackedHalf2AtPtx3071R730, r_PackedHalf2AtPtx3075R731, r_PackedHalf2AtPtx3079R732;
	uint32_t r_LaneIndexAtPtx3087, r_PackedHalf2AtPtx3090R734, r_PackedHalf2AtPtx3094R735,
		r_PackedHalf2AtPtx3098R736, r_PackedHalf2AtPtx3102R737, r_PackedHalf2AtPtx3106R738,
		r_LaneIndexAtPtx3114, r_PackedHalf2AtPtx3117R740, r_PackedHalf2AtPtx3121R741,
		r_PackedHalf2AtPtx3125R742, r_PackedHalf2AtPtx3129R743, r_PackedHalf2AtPtx3133R744;
	uint32_t r_LaneIndexAtPtx3141, r_PackedHalf2AtPtx3144R746, r_PackedHalf2AtPtx3148R747,
		r_PackedHalf2AtPtx3152R748, r_PackedHalf2AtPtx3156R749, r_PackedHalf2AtPtx3160R750,
		r_LaneIndexAtPtx3168, r_PackedHalf2AtPtx3171R752, r_PackedHalf2AtPtx3175R753,
		r_PackedHalf2AtPtx3179R754, r_PackedHalf2AtPtx3183R755, r_PackedHalf2AtPtx3187R756;
	uint32_t r_LaneIndexAtPtx3195, r_PackedHalf2AtPtx3198R758, r_PackedHalf2AtPtx3202R759,
		r_PackedHalf2AtPtx3206R760, r_PackedHalf2AtPtx3210R761, r_PackedHalf2AtPtx3214R762,
		r_LaneIndexAtPtx3222, r_PackedHalf2AtPtx3225R764, r_PackedHalf2AtPtx3229R765,
		r_PackedHalf2AtPtx3233R766, r_PackedHalf2AtPtx3237R767, r_PackedHalf2AtPtx3241R768;
	uint32_t r_LaneIndexAtPtx3249, r_PackedHalf2AtPtx3252R770, r_PackedHalf2AtPtx3256R771,
		r_PackedHalf2AtPtx3260R772, r_PackedHalf2AtPtx3264R773, r_PackedHalf2AtPtx3268R774,
		r_LaneIndexAtPtx3276, r_PackedHalf2AtPtx3279R776, r_PackedHalf2AtPtx3283R777,
		r_PackedHalf2AtPtx3287R778, r_PackedHalf2AtPtx3291R779, r_PackedHalf2AtPtx3295R780;
	uint32_t r_LaneIndexAtPtx3303, r_PackedHalf2AtPtx3306R782, r_PackedHalf2AtPtx3310R783,
		r_PackedHalf2AtPtx3314R784, r_PackedHalf2AtPtx3318R785, r_PackedHalf2AtPtx3322R786,
		r_LaneIndexAtPtx3330, r_PackedHalf2AtPtx3333R788, r_PackedHalf2AtPtx3337R789,
		r_PackedHalf2AtPtx3341R790, r_PackedHalf2AtPtx3345R791, r_PackedHalf2AtPtx3349R792;
	uint32_t r_LaneIndexAtPtx3357, r_PackedHalf2AtPtx3360R794, r_PackedHalf2AtPtx3364R795,
		r_PackedHalf2AtPtx3368R796, r_PackedHalf2AtPtx3372R797, r_PackedHalf2AtPtx3376R798,
		r_LaneIndexAtPtx3384, r_PackedHalf2AtPtx3387R800, r_PackedHalf2AtPtx3391R801,
		r_PackedHalf2AtPtx3395R802, r_PackedHalf2AtPtx3399R803, r_PackedHalf2AtPtx3403R804;
	uint32_t r_LaneIndexAtPtx3411, r_PackedHalf2AtPtx3414R806, r_PackedHalf2AtPtx3418R807,
		r_PackedHalf2AtPtx3422R808, r_PackedHalf2AtPtx3426R809, r_PackedHalf2AtPtx3430R810,
		r_LaneIndexAtPtx3438, r_PackedHalf2AtPtx3441R812, r_PackedHalf2AtPtx3445R813,
		r_PackedHalf2AtPtx3449R814, r_PackedHalf2AtPtx3453R815, r_PackedHalf2AtPtx3457R816;
	uint32_t r_LaneIndexAtPtx3465, r_PackedHalf2AtPtx3468R818, r_PackedHalf2AtPtx3472R819,
		r_PackedHalf2AtPtx3476R820, r_PackedHalf2AtPtx3480R821, r_PackedHalf2AtPtx3484R822,
		r_LaneIndexAtPtx3492, r_PackedHalf2AtPtx3495R824, r_PackedHalf2AtPtx3499R825,
		r_PackedHalf2AtPtx3503R826, r_PackedHalf2AtPtx3507R827, r_PackedHalf2AtPtx3511R828;
	uint32_t r_LaneIndexAtPtx3519, r_PackedHalf2AtPtx3522R830, r_PackedHalf2AtPtx3526R831,
		r_PackedHalf2AtPtx3530R832, r_PackedHalf2AtPtx3534R833, r_PackedHalf2AtPtx3538R834,
		r_LaneIndexAtPtx3546, r_PackedHalf2AtPtx3549R836, r_PackedHalf2AtPtx3553R837,
		r_PackedHalf2AtPtx3557R838, r_PackedHalf2AtPtx3561R839, r_PackedHalf2AtPtx3565R840;
	uint32_t r_LaneIndexAtPtx3573, r_PackedHalf2AtPtx3576R842, r_PackedHalf2AtPtx3580R843,
		r_PackedHalf2AtPtx3584R844, r_PackedHalf2AtPtx3588R845, r_PackedHalf2AtPtx3592R846,
		r_LaneIndexAtPtx3600, r_PackedHalf2AtPtx3603R848, r_PackedHalf2AtPtx3607R849,
		r_PackedHalf2AtPtx3611R850, r_PackedHalf2AtPtx3615R851, r_PackedHalf2AtPtx3619R852;
	uint32_t r_LaneIndexAtPtx3627, r_PackedHalf2AtPtx3630R854, r_PackedHalf2AtPtx3634R855,
		r_PackedHalf2AtPtx3638R856, r_PackedHalf2AtPtx3642R857, r_PackedHalf2AtPtx3646R858,
		r_LaneIndexAtPtx3654, r_PackedHalf2AtPtx3657R860, r_PackedHalf2AtPtx3661R861,
		r_PackedHalf2AtPtx3665R862, r_PackedHalf2AtPtx3669R863, r_PackedHalf2AtPtx3673R864;
	uint32_t r_LaneIndexAtPtx3681, r_PackedHalf2AtPtx3684R866, r_PackedHalf2AtPtx3688R867,
		r_PackedHalf2AtPtx3692R868, r_PackedHalf2AtPtx3696R869, r_PackedHalf2AtPtx3700R870,
		r_LaneIndexAtPtx3708, r_PackedHalf2AtPtx3711R872, r_PackedHalf2AtPtx3715R873,
		r_PackedHalf2AtPtx3719R874, r_PackedHalf2AtPtx3723R875, r_PackedHalf2AtPtx3727R876;
	uint32_t r_LaneIndexAtPtx3735, r_PackedHalf2AtPtx3738R878, r_PackedHalf2AtPtx3742R879,
		r_PackedHalf2AtPtx3746R880, r_PackedHalf2AtPtx3750R881, r_PackedHalf2AtPtx3754R882, r_PtxRegister883,
		r_PtxRegister884, r_LaneIndexAtPtx3769, r_PackedHalf2AtPtx2057R886, r_PackedHalf2AtPtx2084R887,
		r_PackedHalf2AtPtx2111R888;
	uint32_t r_PackedHalf2AtPtx2138R889, r_LaneIndexAtPtx3777, r_PackedHalf2AtPtx2165R891,
		r_PackedHalf2AtPtx2192R892, r_PackedHalf2AtPtx2219R893, r_PackedHalf2AtPtx2246R894,
		r_LaneIndexAtPtx3786, r_PackedHalf2AtPtx2273R896, r_PackedHalf2AtPtx2300R897,
		r_PackedHalf2AtPtx2327R898, r_PackedHalf2AtPtx2354R899, r_LaneIndexAtPtx3795;
	uint32_t r_PackedHalf2AtPtx2381R901, r_PackedHalf2AtPtx2408R902, r_PackedHalf2AtPtx2435R903,
		r_PackedHalf2AtPtx2462R904, r_PtxRegister905, r_LaneIndexAtPtx3809, r_PackedHalf2AtPtx2489R907,
		r_PackedHalf2AtPtx2516R908, r_PackedHalf2AtPtx2543R909, r_PackedHalf2AtPtx2570R910,
		r_LaneIndexAtPtx3817, r_PackedHalf2AtPtx2597R912;
	uint32_t r_PackedHalf2AtPtx2624R913, r_PackedHalf2AtPtx2651R914, r_PackedHalf2AtPtx2678R915,
		r_LaneIndexAtPtx3826, r_PackedHalf2AtPtx2705R917, r_PackedHalf2AtPtx2732R918,
		r_PackedHalf2AtPtx2759R919, r_PackedHalf2AtPtx2786R920, r_LaneIndexAtPtx3835,
		r_PackedHalf2AtPtx2813R922, r_PackedHalf2AtPtx2840R923, r_PackedHalf2AtPtx2867R924;
	uint32_t r_PackedHalf2AtPtx2894R925, r_PtxRegister926, r_LaneIndexAtPtx3849, r_PackedHalf2AtPtx2921R928,
		r_PackedHalf2AtPtx2948R929, r_PackedHalf2AtPtx2975R930, r_PackedHalf2AtPtx3002R931,
		r_LaneIndexAtPtx3857, r_PackedHalf2AtPtx3029R933, r_PackedHalf2AtPtx3056R934,
		r_PackedHalf2AtPtx3083R935, r_PackedHalf2AtPtx3110R936;
	uint32_t r_LaneIndexAtPtx3866, r_PackedHalf2AtPtx3137R938, r_PackedHalf2AtPtx3164R939,
		r_PackedHalf2AtPtx3191R940, r_PackedHalf2AtPtx3218R941, r_LaneIndexAtPtx3875,
		r_PackedHalf2AtPtx3245R943, r_PackedHalf2AtPtx3272R944, r_PackedHalf2AtPtx3299R945,
		r_PackedHalf2AtPtx3326R946, r_PtxRegister947, r_LaneIndexAtPtx3888;
	uint32_t r_PackedHalf2AtPtx3353R949, r_PackedHalf2AtPtx3380R950, r_PackedHalf2AtPtx3407R951,
		r_PackedHalf2AtPtx3434R952, r_LaneIndexAtPtx3897, r_PackedHalf2AtPtx3461R954,
		r_PackedHalf2AtPtx3488R955, r_PackedHalf2AtPtx3515R956, r_PackedHalf2AtPtx3542R957,
		r_LaneIndexAtPtx3906, r_PackedHalf2AtPtx3569R959, r_PackedHalf2AtPtx3596R960;
	uint32_t r_PackedHalf2AtPtx3623R961, r_PackedHalf2AtPtx3650R962, r_LaneIndexAtPtx3915,
		r_PackedHalf2AtPtx3677R964, r_PackedHalf2AtPtx3704R965, r_PackedHalf2AtPtx3731R966,
		r_PackedHalf2AtPtx3758R967, r_PtxRegister968, r_PtxRegister969, r_PtxRegister970, r_PtxRegister971,
		r_PtxRegister972;
	uint32_t r_PtxRegister973, r_PtxRegister974, r_PtxRegister975, r_PtxRegister976, r_PtxRegister977,
		r_PtxRegister978, r_PtxRegister979, r_MmaAccumulatorHalf2WordAtPtx1030R980,
		r_MmaAccumulatorHalf2WordAtPtx1031R981, r_MmaAccumulatorHalf2WordAtPtx1032R982,
		r_MmaAccumulatorHalf2WordAtPtx1033R983, r_MmaAccumulatorHalf2WordAtPtx1034R984;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1035R985, r_MmaAccumulatorHalf2WordAtPtx1036R986,
		r_MmaAccumulatorHalf2WordAtPtx1037R987, r_MmaAccumulatorHalf2WordAtPtx1038R988,
		r_MmaAccumulatorHalf2WordAtPtx1039R989, r_MmaAccumulatorHalf2WordAtPtx1040R990,
		r_MmaAccumulatorHalf2WordAtPtx1041R991, r_MmaAccumulatorHalf2WordAtPtx1042R992,
		r_MmaAccumulatorHalf2WordAtPtx1043R993, r_MmaAccumulatorHalf2WordAtPtx1044R994,
		r_MmaAccumulatorHalf2WordAtPtx1045R995, r_MmaAccumulatorHalf2WordAtPtx1046R996;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1047R997, r_MmaAccumulatorHalf2WordAtPtx1048R998,
		r_MmaAccumulatorHalf2WordAtPtx1049R999, r_MmaAccumulatorHalf2WordAtPtx1050R1000,
		r_MmaAccumulatorHalf2WordAtPtx1051R1001, r_MmaAccumulatorHalf2WordAtPtx1052R1002,
		r_MmaAccumulatorHalf2WordAtPtx1053R1003, r_MmaAccumulatorHalf2WordAtPtx1054R1004,
		r_MmaAccumulatorHalf2WordAtPtx1055R1005, r_MmaAccumulatorHalf2WordAtPtx1056R1006,
		r_MmaAccumulatorHalf2WordAtPtx1057R1007, r_MmaAccumulatorHalf2WordAtPtx1058R1008;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1059R1009, r_MmaAccumulatorHalf2WordAtPtx1060R1010,
		r_MmaAccumulatorHalf2WordAtPtx1061R1011, r_MmaAccumulatorHalf2WordAtPtx1062R1012,
		r_MmaAccumulatorHalf2WordAtPtx1063R1013, r_MmaAccumulatorHalf2WordAtPtx1064R1014,
		r_MmaAccumulatorHalf2WordAtPtx1065R1015, r_MmaAccumulatorHalf2WordAtPtx1066R1016,
		r_MmaAccumulatorHalf2WordAtPtx1067R1017, r_MmaAccumulatorHalf2WordAtPtx1068R1018,
		r_MmaAccumulatorHalf2WordAtPtx1069R1019, r_MmaAccumulatorHalf2WordAtPtx1070R1020;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1071R1021, r_MmaAccumulatorHalf2WordAtPtx1072R1022,
		r_MmaAccumulatorHalf2WordAtPtx1073R1023, r_MmaAccumulatorHalf2WordAtPtx1074R1024,
		r_MmaAccumulatorHalf2WordAtPtx1075R1025, r_MmaAccumulatorHalf2WordAtPtx1076R1026,
		r_MmaAccumulatorHalf2WordAtPtx1077R1027, r_MmaAccumulatorHalf2WordAtPtx1078R1028,
		r_MmaAccumulatorHalf2WordAtPtx1079R1029, r_MmaAccumulatorHalf2WordAtPtx1080R1030,
		r_MmaAccumulatorHalf2WordAtPtx1081R1031, r_MmaAccumulatorHalf2WordAtPtx1082R1032;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1083R1033, r_MmaAccumulatorHalf2WordAtPtx1084R1034,
		r_MmaAccumulatorHalf2WordAtPtx1085R1035, r_MmaAccumulatorHalf2WordAtPtx1086R1036,
		r_MmaAccumulatorHalf2WordAtPtx1087R1037, r_MmaAccumulatorHalf2WordAtPtx1088R1038,
		r_MmaAccumulatorHalf2WordAtPtx1089R1039, r_MmaAccumulatorHalf2WordAtPtx1090R1040,
		r_MmaAccumulatorHalf2WordAtPtx1091R1041, r_MmaAccumulatorHalf2WordAtPtx1092R1042,
		r_MmaAccumulatorHalf2WordAtPtx1093R1043, r_PtxRegister1044;
	uint32_t r_MmaBHalf2WordAtPtx133R1045, r_MmaBHalf2WordAtPtx133R1046, r_MmaBHalf2WordAtPtx124R1047,
		r_MmaBHalf2WordAtPtx124R1048, r_MmaBHalf2WordAtPtx124R1049, r_MmaBHalf2WordAtPtx124R1050,
		r_MmaBHalf2WordAtPtx115R1051, r_MmaBHalf2WordAtPtx115R1052, r_MmaBHalf2WordAtPtx115R1053,
		r_MmaBHalf2WordAtPtx115R1054, r_MmaBHalf2WordAtPtx106R1055, r_MmaBHalf2WordAtPtx106R1056;
	uint32_t r_MmaBHalf2WordAtPtx106R1057, r_MmaBHalf2WordAtPtx106R1058, r_MmaBHalf2WordAtPtx97R1059,
		r_MmaBHalf2WordAtPtx97R1060, r_MmaBHalf2WordAtPtx97R1061, r_MmaBHalf2WordAtPtx97R1062,
		r_MmaBHalf2WordAtPtx88R1063, r_MmaBHalf2WordAtPtx88R1064, r_MmaBHalf2WordAtPtx88R1065,
		r_MmaBHalf2WordAtPtx88R1066, r_MmaBHalf2WordAtPtx79R1067, r_MmaBHalf2WordAtPtx79R1068;
	uint32_t r_MmaBHalf2WordAtPtx79R1069, r_MmaBHalf2WordAtPtx79R1070, r_MmaBHalf2WordAtPtx133R1071,
		r_MmaBHalf2WordAtPtx133R1072, r_MmaBHalf2WordAtPtx142R1073, r_MmaBHalf2WordAtPtx142R1074,
		r_MmaBHalf2WordAtPtx142R1075, r_MmaBHalf2WordAtPtx142R1076, r_PtxRegister1077, r_PtxRegister1078,
		r_PtxRegister1079;
	uint64_t g_StateBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress, r_PtxU64Register4,
		r_PtxU64Register5, r_PtxU64Register6, r_PtxU64Register7, r_PtxU64Register8, r_PtxU64Register9,
		g_OutputByteAddressAtPtx3766, g_OutputByteAddressAtPtx3806, g_OutputByteAddressAtPtx3846;
	uint64_t g_RecordByteAddressAtPtx77, g_RecordByteAddressAtPtx86, g_RecordByteAddressAtPtx95,
		g_RecordByteAddressAtPtx104, g_RecordByteAddressAtPtx113, g_RecordByteAddressAtPtx122,
		g_RecordByteAddressAtPtx131, g_RecordByteAddressAtPtx140, r_PtxU64Register21,
		g_RecordByteAddressAtPtx72, r_PtxU64Register23, r_PtxU64Register24;
	uint64_t g_RecordByteAddressAtPtx85, r_PtxU64Register26, g_RecordByteAddressAtPtx94, r_PtxU64Register28,
		g_RecordByteAddressAtPtx103, r_PtxU64Register30, g_RecordByteAddressAtPtx112, r_PtxU64Register32,
		g_RecordByteAddressAtPtx121, r_PtxU64Register34, g_RecordByteAddressAtPtx130, r_PtxU64Register36;
	uint64_t g_RecordByteAddressAtPtx139, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
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
		r_PtxU64Register82, r_PtxU64Register83, g_RecordByteAddressAtPtx1641;
	uint64_t g_RecordByteAddressAtPtx1650, g_RecordByteAddressAtPtx1659, g_RecordByteAddressAtPtx1668,
		g_RecordByteAddressAtPtx1677, g_RecordByteAddressAtPtx1686, g_RecordByteAddressAtPtx1695,
		g_RecordByteAddressAtPtx1704, r_PtxU64Register92, g_RecordByteAddressAtPtx1636, r_PtxU64Register94,
		r_PtxU64Register95, g_RecordByteAddressAtPtx1649;
	uint64_t r_PtxU64Register97, g_RecordByteAddressAtPtx1658, r_PtxU64Register99,
		g_RecordByteAddressAtPtx1667, r_PtxU64Register101, g_RecordByteAddressAtPtx1676, r_PtxU64Register103,
		g_RecordByteAddressAtPtx1685, r_PtxU64Register105, g_RecordByteAddressAtPtx1694, r_PtxU64Register107,
		g_RecordByteAddressAtPtx1703;
	uint64_t r_PtxU64Register109, r_PtxU64Register110, r_PtxU64Register111, r_PtxU64Register112,
		r_PtxU64Register113, r_PtxU64Register114, r_PtxU64Register115, r_PtxU64Register116,
		r_PtxU64Register117, r_PtxU64Register118, r_PtxU64Register119, r_PtxU64Register120;
	uint64_t r_PtxU64Register121, r_PtxU64Register122, r_PtxU64Register123, r_PtxU64Register124,
		r_PtxU64Register125, r_PtxU64Register126, r_PtxU64Register127, r_PtxU64Register128,
		r_PtxU64Register129, r_PtxU64Register130, r_PtxU64Register131, r_PtxU64Register132;
	uint64_t g_OutputByteAddressAtPtx3772, g_OutputByteAddressAtPtx3781, g_OutputByteAddressAtPtx3790,
		g_OutputByteAddressAtPtx3799, r_PtxU64Register137, r_PtxU64Register138, g_OutputByteAddressAtPtx3780,
		r_PtxU64Register140, g_OutputByteAddressAtPtx3789, r_PtxU64Register142, g_OutputByteAddressAtPtx3798,
		g_OutputByteAddressAtPtx3812;
	uint64_t g_OutputByteAddressAtPtx3821, g_OutputByteAddressAtPtx3830, g_OutputByteAddressAtPtx3839,
		r_PtxU64Register148, r_PtxU64Register149, g_OutputByteAddressAtPtx3820, r_PtxU64Register151,
		g_OutputByteAddressAtPtx3829, r_PtxU64Register153, g_OutputByteAddressAtPtx3838,
		g_OutputByteAddressAtPtx3852, g_OutputByteAddressAtPtx3861;
	uint64_t g_OutputByteAddressAtPtx3870, g_OutputByteAddressAtPtx3879, r_PtxU64Register159,
		r_PtxU64Register160, g_OutputByteAddressAtPtx3860, r_PtxU64Register162, g_OutputByteAddressAtPtx3869,
		r_PtxU64Register164, g_OutputByteAddressAtPtx3878, g_OutputByteAddressAtPtx3892,
		g_OutputByteAddressAtPtx3901, g_OutputByteAddressAtPtx3910;
	uint64_t g_OutputByteAddressAtPtx3919, r_PtxU64Register170, g_OutputByteAddressAtPtx3891,
		r_PtxU64Register172, g_OutputByteAddressAtPtx3900, r_PtxU64Register174, g_OutputByteAddressAtPtx3909,
		r_PtxU64Register176, g_OutputByteAddressAtPtx3918, r_PtxU64Register178, r_PtxU64Register179,
		r_PtxU64Register180;
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
		r_PtxU64Register221;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L16
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);								// PTX L17
	r_CtaX = uint32_t(blockIdx.x);												// PTX L18
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L19
	r_PtxRegister2 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits);			// PTX L20
	r_PtxRegister46 = uint32_t(r_PtxRegister2) + uint32_t(-1);					// PTX L21
	r_PtxRegister47 = ShiftRightSigned(int32_t(r_PtxRegister46), uint32_t(31)); // PTX L22
	r_PtxRegister48 = ShiftRight(uint32_t(r_PtxRegister47), uint32_t(25));		// PTX L23
	r_PtxRegister49 = uint32_t(r_PtxRegister46) + uint32_t(r_PtxRegister48);	// PTX L24
	r_PtxRegister50 = ShiftRightSigned(int32_t(r_PtxRegister49), uint32_t(7));	// PTX L25
	r_PtxRegister51 = uint32_t(r_PtxRegister50) + uint32_t(1);					// PTX L26
	r_PtxRegister3 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister51));		// PTX L27
	r_PtxRegister52 =
		uint32_t(r_PtxRegister3) * uint32_t(r_PtxRegister50) + uint32_t(r_PtxRegister3); // PTX L28
	r_PtxRegister53 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister52);						 // PTX L29
	r_PtxRegister4 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(3));					 // PTX L30
	r_PtxRegister54 = ShiftRight(uint32_t(r_PtxRegister47), uint32_t(28));				 // PTX L31
	r_PtxRegister55 = uint32_t(r_PtxRegister46) + uint32_t(r_PtxRegister54);			 // PTX L32
	r_PtxRegister56 = r_PtxRegister55 & -16;											 // PTX L33
	r_PtxRegister57 = uint32_t(r_PtxRegister56) + uint32_t(16);							 // PTX L34
	r_PtxRegister5 = ShiftRightSigned(int32_t(r_PtxRegister57), uint32_t(4));			 // PTX L35
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L36
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L37
	r_PtxRegister59 = r_ThreadX | r_ThreadY;											 // PTX L38
	r_bPtxPredicate3 = uint32_t(r_PtxRegister59) != uint32_t(0);						 // PTX L39
	if (r_bPtxPredicate3)
	{
		goto L__BB38_2;
	} // PTX L40
	r_BlockSizeX = uint32_t(blockDim.x);							   // PTX L41
	r_BlockSizeY = uint32_t(blockDim.y);							   // PTX L42
	r_PtxRegister61 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY); // PTX L43
	r_PtxRegister60 = uint32_t(24576u /* native mbarriers */);		   // PTX L44
	// Original staged-copy barrier initialization.
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister60, r_PtxRegister61); // PTX L46
	r_PtxRegister62 = uint32_t(r_PtxRegister60) + uint32_t(8);		// PTX L48
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister62, r_PtxRegister61); // PTX L50
	r_PtxRegister63 = uint32_t(r_PtxRegister60) + uint32_t(16);		// PTX L52
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister63, r_PtxRegister61); // PTX L54
L__BB38_2:															// PTX L56
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L57
	r_Float32BitsAtPtx58R66 = uint32_t(0);														// PTX L58
	r_PackedHalf2AtPtx60R271 = FloatToHalf2(r_Float32BitsAtPtx58R66);							// PTX L60
	r_PtxRegister75 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(21));								// PTX L65
	r_PtxRegister76 = ShiftLeft(uint32_t(r_PtxRegister3), uint32_t(10));						// PTX L66
	r_PtxRegister77 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));								// PTX L67
	r_PtxRegister78 = r_PtxRegister77 & 512;													// PTX L68
	r_PtxRegister7 = r_PtxRegister76 | r_PtxRegister78;											// PTX L69
	r_PtxRegister79 = uint32_t(r_PtxRegister75) + uint32_t(r_PtxRegister7);						// PTX L70
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_PtxRegister79)) * int64_t(int32_t(4)));		// PTX L71
	g_RecordByteAddressAtPtx72 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register21);	// PTX L72
	r_LaneIndexAtPtx74 = uint32_t((threadIdx.x & 31u));											// PTX L74
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx74)) * int64_t(int32_t(16))); // PTX L76
	g_RecordByteAddressAtPtx77 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register23); // PTX L77
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx77));
		r_MmaBHalf2WordAtPtx79R1070 = r_Value.x;
		r_MmaBHalf2WordAtPtx79R1069 = r_Value.y;
		r_MmaBHalf2WordAtPtx79R1068 = r_Value.z;
		r_MmaBHalf2WordAtPtx79R1067 = r_Value.w;
	} // PTX L79
	r_LaneIndexAtPtx82 = uint32_t((threadIdx.x & 31u));											// PTX L82
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx82)) * int64_t(int32_t(16))); // PTX L84
	g_RecordByteAddressAtPtx85 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register24);		   // PTX L85
	g_RecordByteAddressAtPtx86 = uint64_t(g_RecordByteAddressAtPtx85) + uint64_t(512); // PTX L86
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx86));
		r_MmaBHalf2WordAtPtx88R1066 = r_Value.x;
		r_MmaBHalf2WordAtPtx88R1065 = r_Value.y;
		r_MmaBHalf2WordAtPtx88R1064 = r_Value.z;
		r_MmaBHalf2WordAtPtx88R1063 = r_Value.w;
	} // PTX L88
	r_LaneIndexAtPtx91 = uint32_t((threadIdx.x & 31u));											// PTX L91
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx91)) * int64_t(int32_t(16))); // PTX L93
	g_RecordByteAddressAtPtx94 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register26);			// PTX L94
	g_RecordByteAddressAtPtx95 = uint64_t(g_RecordByteAddressAtPtx94) + uint64_t(1024); // PTX L95
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx95));
		r_MmaBHalf2WordAtPtx97R1062 = r_Value.x;
		r_MmaBHalf2WordAtPtx97R1061 = r_Value.y;
		r_MmaBHalf2WordAtPtx97R1060 = r_Value.z;
		r_MmaBHalf2WordAtPtx97R1059 = r_Value.w;
	} // PTX L97
	r_LaneIndexAtPtx100 = uint32_t((threadIdx.x & 31u));										 // PTX L100
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx100)) * int64_t(int32_t(16))); // PTX L102
	g_RecordByteAddressAtPtx103 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register28);			  // PTX L103
	g_RecordByteAddressAtPtx104 = uint64_t(g_RecordByteAddressAtPtx103) + uint64_t(1536); // PTX L104
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx104));
		r_MmaBHalf2WordAtPtx106R1058 = r_Value.x;
		r_MmaBHalf2WordAtPtx106R1057 = r_Value.y;
		r_MmaBHalf2WordAtPtx106R1056 = r_Value.z;
		r_MmaBHalf2WordAtPtx106R1055 = r_Value.w;
	} // PTX L106
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	g_RecordByteAddressAtPtx112 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register30);				// PTX L112
	g_RecordByteAddressAtPtx113 = uint64_t(g_RecordByteAddressAtPtx112) + uint64_t(131072); // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx113));
		r_MmaBHalf2WordAtPtx115R1054 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R1053 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R1052 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R1051 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register32 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	g_RecordByteAddressAtPtx121 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register32);				// PTX L121
	g_RecordByteAddressAtPtx122 = uint64_t(g_RecordByteAddressAtPtx121) + uint64_t(131584); // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx122));
		r_MmaBHalf2WordAtPtx124R1050 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R1049 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R1048 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R1047 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register34 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	g_RecordByteAddressAtPtx130 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register34);				// PTX L130
	g_RecordByteAddressAtPtx131 = uint64_t(g_RecordByteAddressAtPtx130) + uint64_t(132096); // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx131));
		r_MmaBHalf2WordAtPtx133R1046 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R1045 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R1071 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R1072 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register36 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	g_RecordByteAddressAtPtx139 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register36);				// PTX L139
	g_RecordByteAddressAtPtx140 = uint64_t(g_RecordByteAddressAtPtx139) + uint64_t(132608); // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx140));
		r_MmaBHalf2WordAtPtx142R1073 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R1074 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R1075 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R1076 = r_Value.w;
	} // PTX L142
	r_PtxRegister8 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(8));					 // PTX L144
	r_PtxRegister80 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister4);				 // PTX L145
	r_PtxRegister9 = uint32_t(r_PtxRegister2) + uint32_t(14);						 // PTX L146
	r_bPtxPredicate4 = uint32_t(r_PtxRegister9) < uint32_t(31);						 // PTX L147
	r_bPtxPredicate5 = int32_t(r_PtxRegister80) < int32_t(r_PtxRegister5);			 // PTX L148
	r_bPtxPredicate1 = r_bPtxPredicate4 | r_bPtxPredicate5;							 // PTX L149
	r_PtxRegister10 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(13));					 // PTX L150
	r_PtxRegister81 = ShiftLeft(uint32_t(r_PtxRegister80), uint32_t(13));			 // PTX L151
	r_PtxRegister11 = r_bPtxPredicate4 ? 0 : r_PtxRegister81;						 // PTX L152
	r_PtxRegister12 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister10);		 // PTX L153
	r_PtxU64Register38 = uint64_t(uint32_t(r_PtxRegister8)) * uint64_t(uint32_t(4)); // PTX L154
	r_PtxRegister82 = uint32_t(0u /* native shared input */);						 // PTX L155
	r_PtxU64Register39 = uint64_t(r_PtxRegister82);									 // PTX L156
	r_PtxU64Register40 = SharedGeneric(s_SharedStorage, r_PtxU64Register39);		 // PTX L157
	r_PtxU64Register4 = uint64_t(r_PtxU64Register40) + uint64_t(r_PtxU64Register38); // PTX L158
	r_PtxU16Register20 = uint16_t(0);												 // PTX L159
	r_PtxU64Register178 = uint64_t(0);												 // PTX L160
	r_PtxRegister968 = uint32_t(128);												 // PTX L161
	r_bPtxPredicate6 = !r_bPtxPredicate1;											 // PTX L162
	r_PtxRegister969 = uint32_t(r_PtxRegister968);									 // PTX L163
	r_PtxU64Register179 = uint64_t(r_PtxU64Register178);							 // PTX L164
	if (r_bPtxPredicate6)
	{
		goto L__BB38_4;
	} // PTX L165
	r_PtxRegister83 = r_bPtxPredicate1 ? r_PtxRegister12 : 0;								// PTX L166
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_PtxRegister83)) * int64_t(int32_t(4))); // PTX L167
	r_PtxU64Register178 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register41);		// PTX L168
	r_PtxRegister969 = uint32_t(r_PtxRegister8) + uint32_t(128);							// PTX L169
	r_PtxRegister968 = uint32_t(r_PtxRegister83) + uint32_t(128);							// PTX L170
	r_PtxU16Register20 = uint16_t(1);														// PTX L171
	r_PtxU64Register179 = uint64_t(r_PtxU64Register4);										// PTX L172
L__BB38_4:																					// PTX L173
	if (r_bPtxPredicate6)
	{
		goto L__BB38_6;
	} // PTX L174
	r_PtxRegister84 = uint32_t(r_PtxRegister8) + uint32_t(128);					// PTX L175
	r_PtxRegister85 = uint32_t(r_PtxRegister12) + uint32_t(128);				// PTX L176
	r_bPtxPredicate7 = uint32_t(r_PtxRegister84) == uint32_t(r_PtxRegister969); // PTX L177
	r_bPtxPredicate8 = uint32_t(r_PtxRegister85) == uint32_t(r_PtxRegister968); // PTX L178
	r_PtxU16Register1 = r_bPtxPredicate8 ? r_PtxU16Register20 : 0;				// PTX L179
	r_PtxU16Register20 = r_bPtxPredicate7 ? r_PtxU16Register1 : 0;				// PTX L180
L__BB38_6:																		// PTX L181
	r_bPtxPredicate9 = uint16_t(r_PtxU16Register20) == uint16_t(0);				// PTX L182
	if (r_bPtxPredicate9)
	{
		goto L__BB38_9;
	} // PTX L183
	r_PtxRegister87 = uint32_t(-1);								  // PTX L184
	r_PtxRegister86 = Elected(r_PtxRegister87);					  // PTX L186
	r_bPtxPredicate10 = uint32_t(r_PtxRegister86) == uint32_t(0); // PTX L192
	if (r_bPtxPredicate10)
	{
		goto L__BB38_25;
	} // PTX L193
	r_PtxU64Register43 = SharedOffset(s_SharedStorage, r_PtxU64Register179); // PTX L194
	r_PtxRegister88 = uint32_t(r_PtxU64Register43);							 // PTX L195
	r_PtxU64Register42 = r_PtxU64Register178;								 // PTX L196
	r_PtxRegister90 = uint32_t(24576u /* native mbarriers */);				 // PTX L197
	r_PtxRegister89 = uint32_t(1024);										 // PTX L198
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister88, r_PtxU64Register42, r_PtxRegister89,
			 r_PtxRegister90);										  // PTX L200
	BarrierExpect(s_SharedStorage, r_PtxRegister90, r_PtxRegister89); // PTX L203
	goto L__BB38_25;												  // PTX L205
L__BB38_9:															  // PTX L206
	r_PtxU64Register180 = uint64_t(0);								  // PTX L207
	if (r_bPtxPredicate6)
	{
		goto L__BB38_11;
	} // PTX L208
	r_PtxU64Register180 = SignExtendWordBits(r_PtxRegister12); // PTX L209
L__BB38_11:													   // PTX L210
	r_PtxU64Register181 = uint64_t(0);						   // PTX L211
	if (r_bPtxPredicate6)
	{
		goto L__BB38_13;
	} // PTX L212
	r_PtxU64Register44 = ShiftLeft(uint64_t(r_PtxU64Register180), uint32_t(2));		   // PTX L213
	r_PtxU64Register181 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register44); // PTX L214
L__BB38_13:																			   // PTX L215
	r_PtxRegister91 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));				   // PTX L216
	r_PtxRegister92 = uint32_t(0u /* native shared input */);						   // PTX L217
	r_PtxRegister13 = uint32_t(r_PtxRegister92) + uint32_t(r_PtxRegister91);		   // PTX L218
	if (r_bPtxPredicate6)
	{
		goto L__BB38_16;
	} // PTX L219
	r_PtxRegister97 = uint32_t(-1);								  // PTX L220
	r_PtxRegister96 = Elected(r_PtxRegister97);					  // PTX L222
	r_bPtxPredicate11 = uint32_t(r_PtxRegister96) == uint32_t(0); // PTX L228
	if (r_bPtxPredicate11)
	{
		goto L__BB38_17;
	} // PTX L229
	r_PtxU64Register45 = r_PtxU64Register181;				   // PTX L230
	r_PtxRegister99 = uint32_t(24576u /* native mbarriers */); // PTX L231
	r_PtxRegister98 = uint32_t(512);						   // PTX L232
	CopyBulk(s_SharedStorage, r_PtxRegister13, r_PtxU64Register45, r_PtxRegister98,
			 r_PtxRegister99);												 // PTX L234
	BarrierExpect(s_SharedStorage, r_PtxRegister99, r_PtxRegister98);		 // PTX L237
	goto L__BB38_17;														 // PTX L239
L__BB38_16:																	 // PTX L240
	r_LaneIndexAtPtx242 = uint32_t((threadIdx.x & 31u));					 // PTX L242
	r_PtxRegister95 = ShiftLeft(uint32_t(r_LaneIndexAtPtx242), uint32_t(4)); // PTX L244
	r_PtxRegister94 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister95); // PTX L245
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister94)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L247
L__BB38_17:									  // PTX L249
	r_PtxU64Register182 = uint64_t(0);		  // PTX L250
	if (r_bPtxPredicate6)
	{
		goto L__BB38_19;
	} // PTX L251
	r_PtxRegister100 = uint32_t(r_PtxRegister12) + uint32_t(128); // PTX L252
	r_PtxU64Register182 = SignExtendWordBits(r_PtxRegister100);	  // PTX L253
L__BB38_19:														  // PTX L254
	r_PtxU64Register183 = uint64_t(0);							  // PTX L255
	if (r_bPtxPredicate6)
	{
		goto L__BB38_21;
	} // PTX L256
	r_PtxU64Register46 = ShiftLeft(uint64_t(r_PtxU64Register182), uint32_t(2));		   // PTX L257
	r_PtxU64Register183 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register46); // PTX L258
L__BB38_21:																			   // PTX L259
	if (r_bPtxPredicate6)
	{
		goto L__BB38_24;
	} // PTX L260
	r_PtxRegister106 = uint32_t(-1);							   // PTX L261
	r_PtxRegister105 = Elected(r_PtxRegister106);				   // PTX L263
	r_bPtxPredicate12 = uint32_t(r_PtxRegister105) == uint32_t(0); // PTX L269
	if (r_bPtxPredicate12)
	{
		goto L__BB38_25;
	} // PTX L270
	r_PtxRegister107 = uint32_t(r_PtxRegister13) + uint32_t(512); // PTX L271
	r_PtxU64Register47 = r_PtxU64Register183;					  // PTX L272
	r_PtxRegister109 = uint32_t(24576u /* native mbarriers */);	  // PTX L273
	r_PtxRegister108 = uint32_t(512);							  // PTX L274
	CopyBulk(s_SharedStorage, r_PtxRegister107, r_PtxU64Register47, r_PtxRegister108,
			 r_PtxRegister109);												   // PTX L276
	BarrierExpect(s_SharedStorage, r_PtxRegister109, r_PtxRegister108);		   // PTX L279
	goto L__BB38_25;														   // PTX L281
L__BB38_24:																	   // PTX L282
	r_LaneIndexAtPtx284 = uint32_t((threadIdx.x & 31u));					   // PTX L284
	r_PtxRegister103 = ShiftLeft(uint32_t(r_LaneIndexAtPtx284), uint32_t(4));  // PTX L286
	r_PtxRegister104 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister103); // PTX L287
	r_PtxRegister102 = uint32_t(r_PtxRegister104) + uint32_t(512);			   // PTX L288
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister102)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L290
L__BB38_25:																	 // PTX L292
	r_bPtxPredicate13 = uint32_t(r_PtxRegister9) < uint32_t(31);			 // PTX L293
	r_PtxRegister14 = uint32_t(r_PtxRegister8) + uint32_t(1024);			 // PTX L294
	r_PtxRegister110 = uint32_t(r_PtxRegister80) + uint32_t(4);				 // PTX L295
	r_bPtxPredicate14 = int32_t(r_PtxRegister110) < int32_t(r_PtxRegister5); // PTX L296
	r_bPtxPredicate2 = r_bPtxPredicate13 | r_bPtxPredicate14;				 // PTX L297
	r_PtxRegister111 = ShiftLeft(uint32_t(r_PtxRegister110), uint32_t(13));	 // PTX L298
	r_PtxRegister15 = r_bPtxPredicate13 ? 0 : r_PtxRegister111;				 // PTX L299
	r_PtxRegister16 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister10); // PTX L300
	r_PtxU16Register21 = uint16_t(0);										 // PTX L301
	r_PtxU64Register184 = uint64_t(0);										 // PTX L302
	r_PtxRegister970 = uint32_t(128);										 // PTX L303
	r_bPtxPredicate15 = !r_bPtxPredicate2;									 // PTX L304
	r_PtxRegister971 = uint32_t(r_PtxRegister970);							 // PTX L305
	r_PtxU64Register185 = uint64_t(r_PtxU64Register184);					 // PTX L306
	if (r_bPtxPredicate15)
	{
		goto L__BB38_27;
	} // PTX L307
	r_PtxRegister112 = r_bPtxPredicate2 ? r_PtxRegister16 : 0;								 // PTX L308
	r_PtxU64Register185 = uint64_t(r_PtxU64Register4) + uint64_t(4096);						 // PTX L309
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister112)) * int64_t(int32_t(4))); // PTX L310
	r_PtxU64Register184 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register48);		 // PTX L311
	r_PtxRegister971 = uint32_t(r_PtxRegister14) + uint32_t(128);							 // PTX L312
	r_PtxRegister970 = uint32_t(r_PtxRegister112) + uint32_t(128);							 // PTX L313
	r_PtxU16Register21 = uint16_t(1);														 // PTX L314
L__BB38_27:																					 // PTX L315
	if (r_bPtxPredicate15)
	{
		goto L__BB38_29;
	} // PTX L316
	r_PtxRegister113 = uint32_t(r_PtxRegister14) + uint32_t(128);				  // PTX L317
	r_PtxRegister114 = uint32_t(r_PtxRegister16) + uint32_t(128);				  // PTX L318
	r_bPtxPredicate16 = uint32_t(r_PtxRegister113) == uint32_t(r_PtxRegister971); // PTX L319
	r_bPtxPredicate17 = uint32_t(r_PtxRegister114) == uint32_t(r_PtxRegister970); // PTX L320
	r_PtxU16Register2 = r_bPtxPredicate17 ? r_PtxU16Register21 : 0;				  // PTX L321
	r_PtxU16Register21 = r_bPtxPredicate16 ? r_PtxU16Register2 : 0;				  // PTX L322
L__BB38_29:																		  // PTX L323
	r_bPtxPredicate18 = uint16_t(r_PtxU16Register21) == uint16_t(0);			  // PTX L324
	if (r_bPtxPredicate18)
	{
		goto L__BB38_32;
	} // PTX L325
	r_PtxRegister116 = uint32_t(-1);							   // PTX L326
	r_PtxRegister115 = Elected(r_PtxRegister116);				   // PTX L328
	r_bPtxPredicate19 = uint32_t(r_PtxRegister115) == uint32_t(0); // PTX L334
	if (r_bPtxPredicate19)
	{
		goto L__BB38_48;
	} // PTX L335
	r_PtxU64Register50 = SharedOffset(s_SharedStorage, r_PtxU64Register185); // PTX L336
	r_PtxRegister117 = uint32_t(r_PtxU64Register50);						 // PTX L337
	r_PtxU64Register49 = r_PtxU64Register184;								 // PTX L338
	r_PtxRegister119 = uint32_t(24576u /* native mbarriers */);				 // PTX L339
	r_PtxRegister118 = uint32_t(1024);										 // PTX L340
	CopyBulk(s_SharedStorage, r_PtxRegister117, r_PtxU64Register49, r_PtxRegister118,
			 r_PtxRegister119);											// PTX L342
	BarrierExpect(s_SharedStorage, r_PtxRegister119, r_PtxRegister118); // PTX L345
	goto L__BB38_48;													// PTX L347
L__BB38_32:																// PTX L348
	r_PtxU64Register186 = uint64_t(0);									// PTX L349
	if (r_bPtxPredicate15)
	{
		goto L__BB38_34;
	} // PTX L350
	r_PtxU64Register186 = SignExtendWordBits(r_PtxRegister16); // PTX L351
L__BB38_34:													   // PTX L352
	r_PtxU64Register187 = uint64_t(0);						   // PTX L353
	if (r_bPtxPredicate15)
	{
		goto L__BB38_36;
	} // PTX L354
	r_PtxU64Register51 = ShiftLeft(uint64_t(r_PtxU64Register186), uint32_t(2));		   // PTX L355
	r_PtxU64Register187 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register51); // PTX L356
L__BB38_36:																			   // PTX L357
	if (r_bPtxPredicate15)
	{
		goto L__BB38_39;
	} // PTX L358
	r_PtxRegister127 = uint32_t(-1);							   // PTX L359
	r_PtxRegister126 = Elected(r_PtxRegister127);				   // PTX L361
	r_bPtxPredicate20 = uint32_t(r_PtxRegister126) == uint32_t(0); // PTX L367
	if (r_bPtxPredicate20)
	{
		goto L__BB38_40;
	} // PTX L368
	r_PtxRegister131 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		// PTX L369
	r_PtxRegister132 = uint32_t(0u /* native shared input */);					// PTX L370
	r_PtxRegister128 = uint32_t(r_PtxRegister132) + uint32_t(r_PtxRegister131); // PTX L371
	r_PtxU64Register52 = r_PtxU64Register187;									// PTX L372
	r_PtxRegister130 = uint32_t(24576u /* native mbarriers */);					// PTX L373
	r_PtxRegister129 = uint32_t(512);											// PTX L374
	CopyBulk(s_SharedStorage, r_PtxRegister128, r_PtxU64Register52, r_PtxRegister129,
			 r_PtxRegister130);													// PTX L376
	BarrierExpect(s_SharedStorage, r_PtxRegister130, r_PtxRegister129);			// PTX L379
	goto L__BB38_40;															// PTX L381
L__BB38_39:																		// PTX L382
	r_LaneIndexAtPtx384 = uint32_t((threadIdx.x & 31u));						// PTX L384
	r_PtxRegister122 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		// PTX L386
	r_PtxRegister123 = uint32_t(0u /* native shared input */);					// PTX L387
	r_PtxRegister124 = uint32_t(r_PtxRegister123) + uint32_t(r_PtxRegister122); // PTX L388
	r_PtxRegister125 = ShiftLeft(uint32_t(r_LaneIndexAtPtx384), uint32_t(4));	// PTX L389
	r_PtxRegister121 = uint32_t(r_PtxRegister124) + uint32_t(r_PtxRegister125); // PTX L390
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister121)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L392
L__BB38_40:									  // PTX L394
	r_PtxU64Register188 = uint64_t(0);		  // PTX L395
	if (r_bPtxPredicate15)
	{
		goto L__BB38_42;
	} // PTX L396
	r_PtxRegister133 = uint32_t(r_PtxRegister16) + uint32_t(128); // PTX L397
	r_PtxU64Register188 = SignExtendWordBits(r_PtxRegister133);	  // PTX L398
L__BB38_42:														  // PTX L399
	r_PtxU64Register189 = uint64_t(0);							  // PTX L400
	if (r_bPtxPredicate15)
	{
		goto L__BB38_44;
	} // PTX L401
	r_PtxU64Register53 = ShiftLeft(uint64_t(r_PtxU64Register188), uint32_t(2));		   // PTX L402
	r_PtxU64Register189 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register53); // PTX L403
L__BB38_44:																			   // PTX L404
	if (r_bPtxPredicate15)
	{
		goto L__BB38_47;
	} // PTX L405
	r_PtxRegister142 = uint32_t(-1);							   // PTX L406
	r_PtxRegister141 = Elected(r_PtxRegister142);				   // PTX L408
	r_bPtxPredicate21 = uint32_t(r_PtxRegister141) == uint32_t(0); // PTX L414
	if (r_bPtxPredicate21)
	{
		goto L__BB38_48;
	} // PTX L415
	r_PtxRegister146 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		// PTX L416
	r_PtxRegister147 = uint32_t(0u /* native shared input */);					// PTX L417
	r_PtxRegister148 = uint32_t(r_PtxRegister147) + uint32_t(r_PtxRegister146); // PTX L418
	r_PtxRegister143 = uint32_t(r_PtxRegister148) + uint32_t(512);				// PTX L419
	r_PtxU64Register54 = r_PtxU64Register189;									// PTX L420
	r_PtxRegister145 = uint32_t(24576u /* native mbarriers */);					// PTX L421
	r_PtxRegister144 = uint32_t(512);											// PTX L422
	CopyBulk(s_SharedStorage, r_PtxRegister143, r_PtxU64Register54, r_PtxRegister144,
			 r_PtxRegister145);													// PTX L424
	BarrierExpect(s_SharedStorage, r_PtxRegister145, r_PtxRegister144);			// PTX L427
	goto L__BB38_48;															// PTX L429
L__BB38_47:																		// PTX L430
	r_LaneIndexAtPtx432 = uint32_t((threadIdx.x & 31u));						// PTX L432
	r_PtxRegister136 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		// PTX L434
	r_PtxRegister137 = uint32_t(0u /* native shared input */);					// PTX L435
	r_PtxRegister138 = uint32_t(r_PtxRegister137) + uint32_t(r_PtxRegister136); // PTX L436
	r_PtxRegister139 = ShiftLeft(uint32_t(r_LaneIndexAtPtx432), uint32_t(4));	// PTX L437
	r_PtxRegister140 = uint32_t(r_PtxRegister138) + uint32_t(r_PtxRegister139); // PTX L438
	r_PtxRegister135 = uint32_t(r_PtxRegister140) + uint32_t(512);				// PTX L439
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister135)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L441
L__BB38_48:																	 // PTX L443
	r_PtxRegister149 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(10));			 // PTX L444
	r_PtxRegister17 = r_PtxRegister149 | 32;								 // PTX L445
	r_PtxRegister18 = r_PtxRegister10 | 256;								 // PTX L446
	r_PtxRegister19 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister18); // PTX L447
	r_PtxU16Register22 = uint16_t(0);										 // PTX L448
	r_PtxU64Register190 = uint64_t(0);										 // PTX L449
	r_PtxRegister972 = uint32_t(128);										 // PTX L450
	r_PtxRegister973 = uint32_t(r_PtxRegister972);							 // PTX L451
	r_PtxU64Register191 = uint64_t(r_PtxU64Register190);					 // PTX L452
	if (r_bPtxPredicate6)
	{
		goto L__BB38_50;
	} // PTX L453
	r_PtxRegister150 = r_bPtxPredicate1 ? r_PtxRegister19 : 0;								 // PTX L454
	r_PtxU64Register191 = uint64_t(r_PtxU64Register4) + uint64_t(8192);						 // PTX L455
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_PtxRegister150)) * int64_t(int32_t(4))); // PTX L456
	r_PtxU64Register190 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register55);		 // PTX L457
	r_PtxRegister973 = uint32_t(r_PtxRegister8) + uint32_t(128);							 // PTX L458
	r_PtxRegister972 = uint32_t(r_PtxRegister150) + uint32_t(128);							 // PTX L459
	r_PtxU16Register22 = uint16_t(1);														 // PTX L460
L__BB38_50:																					 // PTX L461
	if (r_bPtxPredicate6)
	{
		goto L__BB38_52;
	} // PTX L462
	r_PtxRegister151 = uint32_t(r_PtxRegister8) + uint32_t(128);				  // PTX L463
	r_PtxRegister152 = uint32_t(r_PtxRegister12) + uint32_t(384);				  // PTX L464
	r_bPtxPredicate22 = uint32_t(r_PtxRegister151) == uint32_t(r_PtxRegister973); // PTX L465
	r_bPtxPredicate23 = uint32_t(r_PtxRegister152) == uint32_t(r_PtxRegister972); // PTX L466
	r_PtxU16Register3 = r_bPtxPredicate23 ? r_PtxU16Register22 : 0;				  // PTX L467
	r_PtxU16Register22 = r_bPtxPredicate22 ? r_PtxU16Register3 : 0;				  // PTX L468
L__BB38_52:																		  // PTX L469
	r_bPtxPredicate24 = uint16_t(r_PtxU16Register22) == uint16_t(0);			  // PTX L470
	if (r_bPtxPredicate24)
	{
		goto L__BB38_55;
	} // PTX L471
	r_PtxRegister154 = uint32_t(-1);							   // PTX L472
	r_PtxRegister153 = Elected(r_PtxRegister154);				   // PTX L474
	r_bPtxPredicate25 = uint32_t(r_PtxRegister153) == uint32_t(0); // PTX L480
	if (r_bPtxPredicate25)
	{
		goto L__BB38_71;
	} // PTX L481
	r_PtxU64Register57 = SharedOffset(s_SharedStorage, r_PtxU64Register191); // PTX L482
	r_PtxRegister155 = uint32_t(r_PtxU64Register57);						 // PTX L483
	r_PtxU64Register56 = r_PtxU64Register190;								 // PTX L484
	r_PtxRegister158 = uint32_t(24576u /* native mbarriers */);				 // PTX L485
	r_PtxRegister157 = uint32_t(r_PtxRegister158) + uint32_t(8);			 // PTX L486
	r_PtxRegister156 = uint32_t(1024);										 // PTX L487
	CopyBulk(s_SharedStorage, r_PtxRegister155, r_PtxU64Register56, r_PtxRegister156,
			 r_PtxRegister157);											// PTX L489
	BarrierExpect(s_SharedStorage, r_PtxRegister157, r_PtxRegister156); // PTX L492
	goto L__BB38_71;													// PTX L494
L__BB38_55:																// PTX L495
	r_PtxU64Register192 = uint64_t(0);									// PTX L496
	if (r_bPtxPredicate6)
	{
		goto L__BB38_57;
	} // PTX L497
	r_PtxU64Register192 = SignExtendWordBits(r_PtxRegister19); // PTX L498
L__BB38_57:													   // PTX L499
	r_PtxU64Register193 = uint64_t(0);						   // PTX L500
	if (r_bPtxPredicate6)
	{
		goto L__BB38_59;
	} // PTX L501
	r_PtxU64Register58 = ShiftLeft(uint64_t(r_PtxU64Register192), uint32_t(2));		   // PTX L502
	r_PtxU64Register193 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register58); // PTX L503
L__BB38_59:																			   // PTX L504
	r_PtxRegister159 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));			   // PTX L505
	r_PtxRegister160 = uint32_t(0u /* native shared input */);						   // PTX L506
	r_PtxRegister20 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister159);		   // PTX L507
	if (r_bPtxPredicate6)
	{
		goto L__BB38_62;
	} // PTX L508
	r_PtxRegister166 = uint32_t(-1);							   // PTX L509
	r_PtxRegister165 = Elected(r_PtxRegister166);				   // PTX L511
	r_bPtxPredicate26 = uint32_t(r_PtxRegister165) == uint32_t(0); // PTX L517
	if (r_bPtxPredicate26)
	{
		goto L__BB38_63;
	} // PTX L518
	r_PtxRegister167 = uint32_t(r_PtxRegister20) + uint32_t(8192); // PTX L519
	r_PtxU64Register59 = r_PtxU64Register193;					   // PTX L520
	r_PtxRegister170 = uint32_t(24576u /* native mbarriers */);	   // PTX L521
	r_PtxRegister169 = uint32_t(r_PtxRegister170) + uint32_t(8);   // PTX L522
	r_PtxRegister168 = uint32_t(512);							   // PTX L523
	CopyBulk(s_SharedStorage, r_PtxRegister167, r_PtxU64Register59, r_PtxRegister168,
			 r_PtxRegister169);												   // PTX L525
	BarrierExpect(s_SharedStorage, r_PtxRegister169, r_PtxRegister168);		   // PTX L528
	goto L__BB38_63;														   // PTX L530
L__BB38_62:																	   // PTX L531
	r_LaneIndexAtPtx533 = uint32_t((threadIdx.x & 31u));					   // PTX L533
	r_PtxRegister163 = ShiftLeft(uint32_t(r_LaneIndexAtPtx533), uint32_t(4));  // PTX L535
	r_PtxRegister164 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister163); // PTX L536
	r_PtxRegister162 = uint32_t(r_PtxRegister164) + uint32_t(8192);			   // PTX L537
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister162)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L539
L__BB38_63:									  // PTX L541
	r_PtxU64Register194 = uint64_t(0);		  // PTX L542
	if (r_bPtxPredicate6)
	{
		goto L__BB38_65;
	} // PTX L543
	r_PtxRegister171 = uint32_t(r_PtxRegister12) + uint32_t(384); // PTX L544
	r_PtxU64Register194 = SignExtendWordBits(r_PtxRegister171);	  // PTX L545
L__BB38_65:														  // PTX L546
	r_PtxU64Register195 = uint64_t(0);							  // PTX L547
	if (r_bPtxPredicate6)
	{
		goto L__BB38_67;
	} // PTX L548
	r_PtxU64Register60 = ShiftLeft(uint64_t(r_PtxU64Register194), uint32_t(2));		   // PTX L549
	r_PtxU64Register195 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register60); // PTX L550
L__BB38_67:																			   // PTX L551
	if (r_bPtxPredicate6)
	{
		goto L__BB38_70;
	} // PTX L552
	r_PtxRegister177 = uint32_t(-1);							   // PTX L553
	r_PtxRegister176 = Elected(r_PtxRegister177);				   // PTX L555
	r_bPtxPredicate27 = uint32_t(r_PtxRegister176) == uint32_t(0); // PTX L561
	if (r_bPtxPredicate27)
	{
		goto L__BB38_71;
	} // PTX L562
	r_PtxRegister178 = uint32_t(r_PtxRegister20) + uint32_t(8704); // PTX L563
	r_PtxU64Register61 = r_PtxU64Register195;					   // PTX L564
	r_PtxRegister181 = uint32_t(24576u /* native mbarriers */);	   // PTX L565
	r_PtxRegister180 = uint32_t(r_PtxRegister181) + uint32_t(8);   // PTX L566
	r_PtxRegister179 = uint32_t(512);							   // PTX L567
	CopyBulk(s_SharedStorage, r_PtxRegister178, r_PtxU64Register61, r_PtxRegister179,
			 r_PtxRegister180);												   // PTX L569
	BarrierExpect(s_SharedStorage, r_PtxRegister180, r_PtxRegister179);		   // PTX L572
	goto L__BB38_71;														   // PTX L574
L__BB38_70:																	   // PTX L575
	r_LaneIndexAtPtx577 = uint32_t((threadIdx.x & 31u));					   // PTX L577
	r_PtxRegister174 = ShiftLeft(uint32_t(r_LaneIndexAtPtx577), uint32_t(4));  // PTX L579
	r_PtxRegister175 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister174); // PTX L580
	r_PtxRegister173 = uint32_t(r_PtxRegister175) + uint32_t(8704);			   // PTX L581
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister173)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L583
L__BB38_71:																	 // PTX L585
	r_PtxRegister21 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister18); // PTX L586
	r_PtxU16Register23 = uint16_t(0);										 // PTX L587
	r_PtxU64Register196 = uint64_t(0);										 // PTX L588
	r_PtxRegister974 = uint32_t(128);										 // PTX L589
	r_PtxRegister975 = uint32_t(r_PtxRegister974);							 // PTX L590
	r_PtxU64Register197 = uint64_t(r_PtxU64Register196);					 // PTX L591
	if (r_bPtxPredicate15)
	{
		goto L__BB38_73;
	} // PTX L592
	r_PtxRegister182 = r_bPtxPredicate2 ? r_PtxRegister21 : 0;								 // PTX L593
	r_PtxU64Register197 = uint64_t(r_PtxU64Register4) + uint64_t(12288);					 // PTX L594
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister182)) * int64_t(int32_t(4))); // PTX L595
	r_PtxU64Register196 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register62);		 // PTX L596
	r_PtxRegister975 = uint32_t(r_PtxRegister14) + uint32_t(128);							 // PTX L597
	r_PtxRegister974 = uint32_t(r_PtxRegister182) + uint32_t(128);							 // PTX L598
	r_PtxU16Register23 = uint16_t(1);														 // PTX L599
L__BB38_73:																					 // PTX L600
	if (r_bPtxPredicate15)
	{
		goto L__BB38_75;
	} // PTX L601
	r_PtxRegister183 = uint32_t(r_PtxRegister14) + uint32_t(128);				  // PTX L602
	r_PtxRegister184 = uint32_t(r_PtxRegister16) + uint32_t(384);				  // PTX L603
	r_bPtxPredicate28 = uint32_t(r_PtxRegister183) == uint32_t(r_PtxRegister975); // PTX L604
	r_bPtxPredicate29 = uint32_t(r_PtxRegister184) == uint32_t(r_PtxRegister974); // PTX L605
	r_PtxU16Register4 = r_bPtxPredicate29 ? r_PtxU16Register23 : 0;				  // PTX L606
	r_PtxU16Register23 = r_bPtxPredicate28 ? r_PtxU16Register4 : 0;				  // PTX L607
L__BB38_75:																		  // PTX L608
	r_bPtxPredicate30 = uint16_t(r_PtxU16Register23) == uint16_t(0);			  // PTX L609
	if (r_bPtxPredicate30)
	{
		goto L__BB38_78;
	} // PTX L610
	r_PtxRegister186 = uint32_t(-1);							   // PTX L611
	r_PtxRegister185 = Elected(r_PtxRegister186);				   // PTX L613
	r_bPtxPredicate31 = uint32_t(r_PtxRegister185) == uint32_t(0); // PTX L619
	if (r_bPtxPredicate31)
	{
		goto L__BB38_94;
	} // PTX L620
	r_PtxU64Register64 = SharedOffset(s_SharedStorage, r_PtxU64Register197); // PTX L621
	r_PtxRegister187 = uint32_t(r_PtxU64Register64);						 // PTX L622
	r_PtxU64Register63 = r_PtxU64Register196;								 // PTX L623
	r_PtxRegister190 = uint32_t(24576u /* native mbarriers */);				 // PTX L624
	r_PtxRegister189 = uint32_t(r_PtxRegister190) + uint32_t(8);			 // PTX L625
	r_PtxRegister188 = uint32_t(1024);										 // PTX L626
	CopyBulk(s_SharedStorage, r_PtxRegister187, r_PtxU64Register63, r_PtxRegister188,
			 r_PtxRegister189);											// PTX L628
	BarrierExpect(s_SharedStorage, r_PtxRegister189, r_PtxRegister188); // PTX L631
	goto L__BB38_94;													// PTX L633
L__BB38_78:																// PTX L634
	r_PtxU64Register198 = uint64_t(0);									// PTX L635
	if (r_bPtxPredicate15)
	{
		goto L__BB38_80;
	} // PTX L636
	r_PtxU64Register198 = SignExtendWordBits(r_PtxRegister21); // PTX L637
L__BB38_80:													   // PTX L638
	r_PtxU64Register199 = uint64_t(0);						   // PTX L639
	if (r_bPtxPredicate15)
	{
		goto L__BB38_82;
	} // PTX L640
	r_PtxU64Register65 = ShiftLeft(uint64_t(r_PtxU64Register198), uint32_t(2));		   // PTX L641
	r_PtxU64Register199 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register65); // PTX L642
L__BB38_82:																			   // PTX L643
	r_PtxRegister191 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));			   // PTX L644
	r_PtxRegister192 = uint32_t(0u /* native shared input */);						   // PTX L645
	r_PtxRegister22 = uint32_t(r_PtxRegister192) + uint32_t(r_PtxRegister191);		   // PTX L646
	if (r_bPtxPredicate15)
	{
		goto L__BB38_85;
	} // PTX L647
	r_PtxRegister198 = uint32_t(-1);							   // PTX L648
	r_PtxRegister197 = Elected(r_PtxRegister198);				   // PTX L650
	r_bPtxPredicate32 = uint32_t(r_PtxRegister197) == uint32_t(0); // PTX L656
	if (r_bPtxPredicate32)
	{
		goto L__BB38_86;
	} // PTX L657
	r_PtxRegister199 = uint32_t(r_PtxRegister22) + uint32_t(8192); // PTX L658
	r_PtxU64Register66 = r_PtxU64Register199;					   // PTX L659
	r_PtxRegister202 = uint32_t(24576u /* native mbarriers */);	   // PTX L660
	r_PtxRegister201 = uint32_t(r_PtxRegister202) + uint32_t(8);   // PTX L661
	r_PtxRegister200 = uint32_t(512);							   // PTX L662
	CopyBulk(s_SharedStorage, r_PtxRegister199, r_PtxU64Register66, r_PtxRegister200,
			 r_PtxRegister201);												   // PTX L664
	BarrierExpect(s_SharedStorage, r_PtxRegister201, r_PtxRegister200);		   // PTX L667
	goto L__BB38_86;														   // PTX L669
L__BB38_85:																	   // PTX L670
	r_LaneIndexAtPtx672 = uint32_t((threadIdx.x & 31u));					   // PTX L672
	r_PtxRegister195 = ShiftLeft(uint32_t(r_LaneIndexAtPtx672), uint32_t(4));  // PTX L674
	r_PtxRegister196 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister195); // PTX L675
	r_PtxRegister194 = uint32_t(r_PtxRegister196) + uint32_t(8192);			   // PTX L676
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister194)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L678
L__BB38_86:									  // PTX L680
	r_PtxU64Register200 = uint64_t(0);		  // PTX L681
	if (r_bPtxPredicate15)
	{
		goto L__BB38_88;
	} // PTX L682
	r_PtxRegister203 = uint32_t(r_PtxRegister16) + uint32_t(384); // PTX L683
	r_PtxU64Register200 = SignExtendWordBits(r_PtxRegister203);	  // PTX L684
L__BB38_88:														  // PTX L685
	r_PtxU64Register201 = uint64_t(0);							  // PTX L686
	if (r_bPtxPredicate15)
	{
		goto L__BB38_90;
	} // PTX L687
	r_PtxU64Register67 = ShiftLeft(uint64_t(r_PtxU64Register200), uint32_t(2));		   // PTX L688
	r_PtxU64Register201 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register67); // PTX L689
L__BB38_90:																			   // PTX L690
	if (r_bPtxPredicate15)
	{
		goto L__BB38_93;
	} // PTX L691
	r_PtxRegister209 = uint32_t(-1);							   // PTX L692
	r_PtxRegister208 = Elected(r_PtxRegister209);				   // PTX L694
	r_bPtxPredicate33 = uint32_t(r_PtxRegister208) == uint32_t(0); // PTX L700
	if (r_bPtxPredicate33)
	{
		goto L__BB38_94;
	} // PTX L701
	r_PtxRegister210 = uint32_t(r_PtxRegister22) + uint32_t(8704); // PTX L702
	r_PtxU64Register68 = r_PtxU64Register201;					   // PTX L703
	r_PtxRegister213 = uint32_t(24576u /* native mbarriers */);	   // PTX L704
	r_PtxRegister212 = uint32_t(r_PtxRegister213) + uint32_t(8);   // PTX L705
	r_PtxRegister211 = uint32_t(512);							   // PTX L706
	CopyBulk(s_SharedStorage, r_PtxRegister210, r_PtxU64Register68, r_PtxRegister211,
			 r_PtxRegister212);												   // PTX L708
	BarrierExpect(s_SharedStorage, r_PtxRegister212, r_PtxRegister211);		   // PTX L711
	goto L__BB38_94;														   // PTX L713
L__BB38_93:																	   // PTX L714
	r_LaneIndexAtPtx716 = uint32_t((threadIdx.x & 31u));					   // PTX L716
	r_PtxRegister206 = ShiftLeft(uint32_t(r_LaneIndexAtPtx716), uint32_t(4));  // PTX L718
	r_PtxRegister207 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister206); // PTX L719
	r_PtxRegister205 = uint32_t(r_PtxRegister207) + uint32_t(8704);			   // PTX L720
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister205)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L722
L__BB38_94:																	 // PTX L724
	r_PtxRegister214 = ShiftLeft(uint32_t(r_PtxRegister17), uint32_t(3));	 // PTX L725
	r_PtxRegister23 = uint32_t(r_PtxRegister214) + uint32_t(256);			 // PTX L726
	r_PtxRegister24 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister23); // PTX L727
	r_PtxU16Register24 = uint16_t(0);										 // PTX L728
	r_PtxU64Register202 = uint64_t(0);										 // PTX L729
	r_PtxRegister976 = uint32_t(128);										 // PTX L730
	r_PtxRegister977 = uint32_t(r_PtxRegister976);							 // PTX L731
	r_PtxU64Register203 = uint64_t(r_PtxU64Register202);					 // PTX L732
	if (r_bPtxPredicate6)
	{
		goto L__BB38_96;
	} // PTX L733
	r_PtxRegister215 = r_bPtxPredicate1 ? r_PtxRegister24 : 0;								 // PTX L734
	r_PtxU64Register203 = uint64_t(r_PtxU64Register4) + uint64_t(16384);					 // PTX L735
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister215)) * int64_t(int32_t(4))); // PTX L736
	r_PtxU64Register202 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register69);		 // PTX L737
	r_PtxRegister977 = uint32_t(r_PtxRegister8) + uint32_t(128);							 // PTX L738
	r_PtxRegister976 = uint32_t(r_PtxRegister215) + uint32_t(128);							 // PTX L739
	r_PtxU16Register24 = uint16_t(1);														 // PTX L740
L__BB38_96:																					 // PTX L741
	if (r_bPtxPredicate6)
	{
		goto L__BB38_98;
	} // PTX L742
	r_PtxRegister216 = uint32_t(r_PtxRegister8) + uint32_t(128);				  // PTX L743
	r_PtxRegister217 = uint32_t(r_PtxRegister12) + uint32_t(640);				  // PTX L744
	r_bPtxPredicate34 = uint32_t(r_PtxRegister216) == uint32_t(r_PtxRegister977); // PTX L745
	r_bPtxPredicate35 = uint32_t(r_PtxRegister217) == uint32_t(r_PtxRegister976); // PTX L746
	r_PtxU16Register5 = r_bPtxPredicate35 ? r_PtxU16Register24 : 0;				  // PTX L747
	r_PtxU16Register24 = r_bPtxPredicate34 ? r_PtxU16Register5 : 0;				  // PTX L748
L__BB38_98:																		  // PTX L749
	r_bPtxPredicate36 = uint16_t(r_PtxU16Register24) == uint16_t(0);			  // PTX L750
	if (r_bPtxPredicate36)
	{
		goto L__BB38_101;
	} // PTX L751
	r_PtxRegister219 = uint32_t(-1);							   // PTX L752
	r_PtxRegister218 = Elected(r_PtxRegister219);				   // PTX L754
	r_bPtxPredicate37 = uint32_t(r_PtxRegister218) == uint32_t(0); // PTX L760
	if (r_bPtxPredicate37)
	{
		goto L__BB38_117;
	} // PTX L761
	r_PtxU64Register71 = SharedOffset(s_SharedStorage, r_PtxU64Register203); // PTX L762
	r_PtxRegister220 = uint32_t(r_PtxU64Register71);						 // PTX L763
	r_PtxU64Register70 = r_PtxU64Register202;								 // PTX L764
	r_PtxRegister223 = uint32_t(24576u /* native mbarriers */);				 // PTX L765
	r_PtxRegister222 = uint32_t(r_PtxRegister223) + uint32_t(16);			 // PTX L766
	r_PtxRegister221 = uint32_t(1024);										 // PTX L767
	CopyBulk(s_SharedStorage, r_PtxRegister220, r_PtxU64Register70, r_PtxRegister221,
			 r_PtxRegister222);											// PTX L769
	BarrierExpect(s_SharedStorage, r_PtxRegister222, r_PtxRegister221); // PTX L772
	goto L__BB38_117;													// PTX L774
L__BB38_101:															// PTX L775
	r_PtxU64Register204 = uint64_t(0);									// PTX L776
	if (r_bPtxPredicate6)
	{
		goto L__BB38_103;
	} // PTX L777
	r_PtxU64Register204 = SignExtendWordBits(r_PtxRegister24); // PTX L778
L__BB38_103:												   // PTX L779
	r_PtxU64Register205 = uint64_t(0);						   // PTX L780
	if (r_bPtxPredicate6)
	{
		goto L__BB38_105;
	} // PTX L781
	r_PtxU64Register72 = ShiftLeft(uint64_t(r_PtxU64Register204), uint32_t(2));		   // PTX L782
	r_PtxU64Register205 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register72); // PTX L783
L__BB38_105:																		   // PTX L784
	r_PtxRegister224 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));			   // PTX L785
	r_PtxRegister225 = uint32_t(0u /* native shared input */);						   // PTX L786
	r_PtxRegister25 = uint32_t(r_PtxRegister225) + uint32_t(r_PtxRegister224);		   // PTX L787
	if (r_bPtxPredicate6)
	{
		goto L__BB38_108;
	} // PTX L788
	r_PtxRegister231 = uint32_t(-1);							   // PTX L789
	r_PtxRegister230 = Elected(r_PtxRegister231);				   // PTX L791
	r_bPtxPredicate38 = uint32_t(r_PtxRegister230) == uint32_t(0); // PTX L797
	if (r_bPtxPredicate38)
	{
		goto L__BB38_109;
	} // PTX L798
	r_PtxRegister232 = uint32_t(r_PtxRegister25) + uint32_t(16384); // PTX L799
	r_PtxU64Register73 = r_PtxU64Register205;						// PTX L800
	r_PtxRegister235 = uint32_t(24576u /* native mbarriers */);		// PTX L801
	r_PtxRegister234 = uint32_t(r_PtxRegister235) + uint32_t(16);	// PTX L802
	r_PtxRegister233 = uint32_t(512);								// PTX L803
	CopyBulk(s_SharedStorage, r_PtxRegister232, r_PtxU64Register73, r_PtxRegister233,
			 r_PtxRegister234);												   // PTX L805
	BarrierExpect(s_SharedStorage, r_PtxRegister234, r_PtxRegister233);		   // PTX L808
	goto L__BB38_109;														   // PTX L810
L__BB38_108:																   // PTX L811
	r_LaneIndexAtPtx813 = uint32_t((threadIdx.x & 31u));					   // PTX L813
	r_PtxRegister228 = ShiftLeft(uint32_t(r_LaneIndexAtPtx813), uint32_t(4));  // PTX L815
	r_PtxRegister229 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister228); // PTX L816
	r_PtxRegister227 = uint32_t(r_PtxRegister229) + uint32_t(16384);		   // PTX L817
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister227)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L819
L__BB38_109:								  // PTX L821
	r_PtxU64Register206 = uint64_t(0);		  // PTX L822
	if (r_bPtxPredicate6)
	{
		goto L__BB38_111;
	} // PTX L823
	r_PtxRegister236 = uint32_t(r_PtxRegister12) + uint32_t(640); // PTX L824
	r_PtxU64Register206 = SignExtendWordBits(r_PtxRegister236);	  // PTX L825
L__BB38_111:													  // PTX L826
	r_PtxU64Register207 = uint64_t(0);							  // PTX L827
	if (r_bPtxPredicate6)
	{
		goto L__BB38_113;
	} // PTX L828
	r_PtxU64Register74 = ShiftLeft(uint64_t(r_PtxU64Register206), uint32_t(2));		   // PTX L829
	r_PtxU64Register207 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register74); // PTX L830
L__BB38_113:																		   // PTX L831
	if (r_bPtxPredicate6)
	{
		goto L__BB38_116;
	} // PTX L832
	r_PtxRegister242 = uint32_t(-1);							   // PTX L833
	r_PtxRegister241 = Elected(r_PtxRegister242);				   // PTX L835
	r_bPtxPredicate39 = uint32_t(r_PtxRegister241) == uint32_t(0); // PTX L841
	if (r_bPtxPredicate39)
	{
		goto L__BB38_117;
	} // PTX L842
	r_PtxRegister243 = uint32_t(r_PtxRegister25) + uint32_t(16896); // PTX L843
	r_PtxU64Register75 = r_PtxU64Register207;						// PTX L844
	r_PtxRegister246 = uint32_t(24576u /* native mbarriers */);		// PTX L845
	r_PtxRegister245 = uint32_t(r_PtxRegister246) + uint32_t(16);	// PTX L846
	r_PtxRegister244 = uint32_t(512);								// PTX L847
	CopyBulk(s_SharedStorage, r_PtxRegister243, r_PtxU64Register75, r_PtxRegister244,
			 r_PtxRegister245);												   // PTX L849
	BarrierExpect(s_SharedStorage, r_PtxRegister245, r_PtxRegister244);		   // PTX L852
	goto L__BB38_117;														   // PTX L854
L__BB38_116:																   // PTX L855
	r_LaneIndexAtPtx857 = uint32_t((threadIdx.x & 31u));					   // PTX L857
	r_PtxRegister239 = ShiftLeft(uint32_t(r_LaneIndexAtPtx857), uint32_t(4));  // PTX L859
	r_PtxRegister240 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister239); // PTX L860
	r_PtxRegister238 = uint32_t(r_PtxRegister240) + uint32_t(16896);		   // PTX L861
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister238)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L863
L__BB38_117:																 // PTX L865
	r_PtxRegister26 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister23); // PTX L866
	r_PtxU16Register25 = uint16_t(0);										 // PTX L867
	r_PtxU64Register208 = uint64_t(0);										 // PTX L868
	r_PtxRegister978 = uint32_t(128);										 // PTX L869
	r_PtxRegister979 = uint32_t(r_PtxRegister978);							 // PTX L870
	r_PtxU64Register209 = uint64_t(r_PtxU64Register208);					 // PTX L871
	if (r_bPtxPredicate15)
	{
		goto L__BB38_119;
	} // PTX L872
	r_PtxRegister247 = r_bPtxPredicate2 ? r_PtxRegister26 : 0;								 // PTX L873
	r_PtxU64Register209 = uint64_t(r_PtxU64Register4) + uint64_t(20480);					 // PTX L874
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister247)) * int64_t(int32_t(4))); // PTX L875
	r_PtxU64Register208 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register76);		 // PTX L876
	r_PtxRegister979 = uint32_t(r_PtxRegister14) + uint32_t(128);							 // PTX L877
	r_PtxRegister978 = uint32_t(r_PtxRegister247) + uint32_t(128);							 // PTX L878
	r_PtxU16Register25 = uint16_t(1);														 // PTX L879
L__BB38_119:																				 // PTX L880
	if (r_bPtxPredicate15)
	{
		goto L__BB38_121;
	} // PTX L881
	r_PtxRegister248 = uint32_t(r_PtxRegister14) + uint32_t(128);				  // PTX L882
	r_PtxRegister249 = uint32_t(r_PtxRegister16) + uint32_t(640);				  // PTX L883
	r_bPtxPredicate40 = uint32_t(r_PtxRegister248) == uint32_t(r_PtxRegister979); // PTX L884
	r_bPtxPredicate41 = uint32_t(r_PtxRegister249) == uint32_t(r_PtxRegister978); // PTX L885
	r_PtxU16Register6 = r_bPtxPredicate41 ? r_PtxU16Register25 : 0;				  // PTX L886
	r_PtxU16Register25 = r_bPtxPredicate40 ? r_PtxU16Register6 : 0;				  // PTX L887
L__BB38_121:																	  // PTX L888
	r_bPtxPredicate42 = uint16_t(r_PtxU16Register25) == uint16_t(0);			  // PTX L889
	if (r_bPtxPredicate42)
	{
		goto L__BB38_124;
	} // PTX L890
	r_PtxRegister251 = uint32_t(-1);							   // PTX L891
	r_PtxRegister250 = Elected(r_PtxRegister251);				   // PTX L893
	r_bPtxPredicate43 = uint32_t(r_PtxRegister250) == uint32_t(0); // PTX L899
	if (r_bPtxPredicate43)
	{
		goto L__BB38_140;
	} // PTX L900
	r_PtxU64Register78 = SharedOffset(s_SharedStorage, r_PtxU64Register209); // PTX L901
	r_PtxRegister252 = uint32_t(r_PtxU64Register78);						 // PTX L902
	r_PtxU64Register77 = r_PtxU64Register208;								 // PTX L903
	r_PtxRegister255 = uint32_t(24576u /* native mbarriers */);				 // PTX L904
	r_PtxRegister254 = uint32_t(r_PtxRegister255) + uint32_t(16);			 // PTX L905
	r_PtxRegister253 = uint32_t(1024);										 // PTX L906
	CopyBulk(s_SharedStorage, r_PtxRegister252, r_PtxU64Register77, r_PtxRegister253,
			 r_PtxRegister254);											// PTX L908
	BarrierExpect(s_SharedStorage, r_PtxRegister254, r_PtxRegister253); // PTX L911
	goto L__BB38_140;													// PTX L913
L__BB38_124:															// PTX L914
	r_PtxU64Register210 = uint64_t(0);									// PTX L915
	if (r_bPtxPredicate15)
	{
		goto L__BB38_126;
	} // PTX L916
	r_PtxU64Register210 = SignExtendWordBits(r_PtxRegister26); // PTX L917
L__BB38_126:												   // PTX L918
	r_PtxU64Register211 = uint64_t(0);						   // PTX L919
	if (r_bPtxPredicate15)
	{
		goto L__BB38_128;
	} // PTX L920
	r_PtxU64Register79 = ShiftLeft(uint64_t(r_PtxU64Register210), uint32_t(2));		   // PTX L921
	r_PtxU64Register211 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register79); // PTX L922
L__BB38_128:																		   // PTX L923
	r_PtxRegister256 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));			   // PTX L924
	r_PtxRegister257 = uint32_t(0u /* native shared input */);						   // PTX L925
	r_PtxRegister27 = uint32_t(r_PtxRegister257) + uint32_t(r_PtxRegister256);		   // PTX L926
	if (r_bPtxPredicate15)
	{
		goto L__BB38_131;
	} // PTX L927
	r_PtxRegister263 = uint32_t(-1);							   // PTX L928
	r_PtxRegister262 = Elected(r_PtxRegister263);				   // PTX L930
	r_bPtxPredicate44 = uint32_t(r_PtxRegister262) == uint32_t(0); // PTX L936
	if (r_bPtxPredicate44)
	{
		goto L__BB38_132;
	} // PTX L937
	r_PtxRegister264 = uint32_t(r_PtxRegister27) + uint32_t(16384); // PTX L938
	r_PtxU64Register80 = r_PtxU64Register211;						// PTX L939
	r_PtxRegister267 = uint32_t(24576u /* native mbarriers */);		// PTX L940
	r_PtxRegister266 = uint32_t(r_PtxRegister267) + uint32_t(16);	// PTX L941
	r_PtxRegister265 = uint32_t(512);								// PTX L942
	CopyBulk(s_SharedStorage, r_PtxRegister264, r_PtxU64Register80, r_PtxRegister265,
			 r_PtxRegister266);												   // PTX L944
	BarrierExpect(s_SharedStorage, r_PtxRegister266, r_PtxRegister265);		   // PTX L947
	goto L__BB38_132;														   // PTX L949
L__BB38_131:																   // PTX L950
	r_LaneIndexAtPtx952 = uint32_t((threadIdx.x & 31u));					   // PTX L952
	r_PtxRegister260 = ShiftLeft(uint32_t(r_LaneIndexAtPtx952), uint32_t(4));  // PTX L954
	r_PtxRegister261 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister260); // PTX L955
	r_PtxRegister259 = uint32_t(r_PtxRegister261) + uint32_t(16384);		   // PTX L956
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister259)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L958
L__BB38_132:								  // PTX L960
	r_PtxU64Register212 = uint64_t(0);		  // PTX L961
	if (r_bPtxPredicate15)
	{
		goto L__BB38_134;
	} // PTX L962
	r_PtxRegister268 = uint32_t(r_PtxRegister16) + uint32_t(640); // PTX L963
	r_PtxU64Register212 = SignExtendWordBits(r_PtxRegister268);	  // PTX L964
L__BB38_134:													  // PTX L965
	r_PtxU64Register213 = uint64_t(0);							  // PTX L966
	if (r_bPtxPredicate15)
	{
		goto L__BB38_136;
	} // PTX L967
	r_PtxU64Register81 = ShiftLeft(uint64_t(r_PtxU64Register212), uint32_t(2));		   // PTX L968
	r_PtxU64Register213 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register81); // PTX L969
L__BB38_136:																		   // PTX L970
	if (r_bPtxPredicate15)
	{
		goto L__BB38_139;
	} // PTX L971
	r_PtxRegister275 = uint32_t(-1);							   // PTX L972
	r_PtxRegister274 = Elected(r_PtxRegister275);				   // PTX L974
	r_bPtxPredicate45 = uint32_t(r_PtxRegister274) == uint32_t(0); // PTX L980
	if (r_bPtxPredicate45)
	{
		goto L__BB38_140;
	} // PTX L981
	r_PtxRegister276 = uint32_t(r_PtxRegister27) + uint32_t(16896); // PTX L982
	r_PtxU64Register82 = r_PtxU64Register213;						// PTX L983
	r_PtxRegister279 = uint32_t(24576u /* native mbarriers */);		// PTX L984
	r_PtxRegister278 = uint32_t(r_PtxRegister279) + uint32_t(16);	// PTX L985
	r_PtxRegister277 = uint32_t(512);								// PTX L986
	CopyBulk(s_SharedStorage, r_PtxRegister276, r_PtxU64Register82, r_PtxRegister277,
			 r_PtxRegister278);												   // PTX L988
	BarrierExpect(s_SharedStorage, r_PtxRegister278, r_PtxRegister277);		   // PTX L991
	goto L__BB38_140;														   // PTX L993
L__BB38_139:																   // PTX L994
	r_LaneIndexAtPtx996 = uint32_t((threadIdx.x & 31u));					   // PTX L996
	r_PtxRegister272 = ShiftLeft(uint32_t(r_LaneIndexAtPtx996), uint32_t(4));  // PTX L998
	r_PtxRegister273 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister272); // PTX L999
	r_PtxRegister270 = uint32_t(r_PtxRegister273) + uint32_t(16896);		   // PTX L1000
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister270)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);					// PTX L1002
L__BB38_140:													// PTX L1004
	r_PtxRegister280 = uint32_t(24576u /* native mbarriers */); // PTX L1005
	r_PtxRegister281 = uint32_t(1);								// PTX L1006
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register83 = BarrierArrive(s_SharedStorage, r_PtxRegister280, r_PtxRegister281); // PTX L1008
L__BB38_141:																				 // PTX L1010
	r_PtxRegister283 = uint32_t(24576u /* native mbarriers */);								 // PTX L1011
	r_PtxRegister282 = BarrierReady(s_SharedStorage, r_PtxRegister283, r_PtxU64Register83);	 // PTX L1013
	r_bPtxPredicate46 = uint32_t(r_PtxRegister282) == uint32_t(0);							 // PTX L1019
	if (r_bPtxPredicate46)
	{
		goto L__BB38_141;
	} // PTX L1020
	r_PtxRegister284 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));				  // PTX L1021
	r_PtxRegister28 = r_PtxRegister284 & 2044;									  // PTX L1022
	r_PtxRegister29 = uint32_t(r_PtxRegister17) + uint32_t(64);					  // PTX L1023
	r_PtxRegister285 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(11));			  // PTX L1024
	r_PtxRegister30 = r_PtxRegister285 & 2093056;								  // PTX L1025
	r_PtxRegister31 = r_PtxRegister77 & 523264;									  // PTX L1026
	r_PtxRegister32 = uint32_t(r_PtxRegister8) + uint32_t(128);					  // PTX L1027
	r_PtxRegister1044 = uint32_t(0);											  // PTX L1028
	r_PtxRegister404 = ShiftLeft(uint32_t(r_PtxRegister31), uint32_t(2));		  // PTX L1029
	r_MmaAccumulatorHalf2WordAtPtx1030R980 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1030
	r_MmaAccumulatorHalf2WordAtPtx1031R981 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1031
	r_MmaAccumulatorHalf2WordAtPtx1032R982 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1032
	r_MmaAccumulatorHalf2WordAtPtx1033R983 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1033
	r_MmaAccumulatorHalf2WordAtPtx1034R984 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1034
	r_MmaAccumulatorHalf2WordAtPtx1035R985 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1035
	r_MmaAccumulatorHalf2WordAtPtx1036R986 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1036
	r_MmaAccumulatorHalf2WordAtPtx1037R987 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1037
	r_MmaAccumulatorHalf2WordAtPtx1038R988 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1038
	r_MmaAccumulatorHalf2WordAtPtx1039R989 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1039
	r_MmaAccumulatorHalf2WordAtPtx1040R990 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1040
	r_MmaAccumulatorHalf2WordAtPtx1041R991 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1041
	r_MmaAccumulatorHalf2WordAtPtx1042R992 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1042
	r_MmaAccumulatorHalf2WordAtPtx1043R993 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1043
	r_MmaAccumulatorHalf2WordAtPtx1044R994 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1044
	r_MmaAccumulatorHalf2WordAtPtx1045R995 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1045
	r_MmaAccumulatorHalf2WordAtPtx1046R996 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1046
	r_MmaAccumulatorHalf2WordAtPtx1047R997 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1047
	r_MmaAccumulatorHalf2WordAtPtx1048R998 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1048
	r_MmaAccumulatorHalf2WordAtPtx1049R999 = uint32_t(r_PackedHalf2AtPtx60R271);  // PTX L1049
	r_MmaAccumulatorHalf2WordAtPtx1050R1000 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1050
	r_MmaAccumulatorHalf2WordAtPtx1051R1001 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1051
	r_MmaAccumulatorHalf2WordAtPtx1052R1002 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1052
	r_MmaAccumulatorHalf2WordAtPtx1053R1003 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1053
	r_MmaAccumulatorHalf2WordAtPtx1054R1004 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1054
	r_MmaAccumulatorHalf2WordAtPtx1055R1005 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1055
	r_MmaAccumulatorHalf2WordAtPtx1056R1006 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1056
	r_MmaAccumulatorHalf2WordAtPtx1057R1007 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1057
	r_MmaAccumulatorHalf2WordAtPtx1058R1008 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1058
	r_MmaAccumulatorHalf2WordAtPtx1059R1009 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1059
	r_MmaAccumulatorHalf2WordAtPtx1060R1010 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1060
	r_MmaAccumulatorHalf2WordAtPtx1061R1011 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1061
	r_MmaAccumulatorHalf2WordAtPtx1062R1012 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1062
	r_MmaAccumulatorHalf2WordAtPtx1063R1013 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1063
	r_MmaAccumulatorHalf2WordAtPtx1064R1014 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1064
	r_MmaAccumulatorHalf2WordAtPtx1065R1015 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1065
	r_MmaAccumulatorHalf2WordAtPtx1066R1016 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1066
	r_MmaAccumulatorHalf2WordAtPtx1067R1017 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1067
	r_MmaAccumulatorHalf2WordAtPtx1068R1018 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1068
	r_MmaAccumulatorHalf2WordAtPtx1069R1019 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1069
	r_MmaAccumulatorHalf2WordAtPtx1070R1020 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1070
	r_MmaAccumulatorHalf2WordAtPtx1071R1021 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1071
	r_MmaAccumulatorHalf2WordAtPtx1072R1022 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1072
	r_MmaAccumulatorHalf2WordAtPtx1073R1023 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1073
	r_MmaAccumulatorHalf2WordAtPtx1074R1024 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1074
	r_MmaAccumulatorHalf2WordAtPtx1075R1025 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1075
	r_MmaAccumulatorHalf2WordAtPtx1076R1026 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1076
	r_MmaAccumulatorHalf2WordAtPtx1077R1027 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1077
	r_MmaAccumulatorHalf2WordAtPtx1078R1028 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1078
	r_MmaAccumulatorHalf2WordAtPtx1079R1029 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1079
	r_MmaAccumulatorHalf2WordAtPtx1080R1030 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1080
	r_MmaAccumulatorHalf2WordAtPtx1081R1031 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1081
	r_MmaAccumulatorHalf2WordAtPtx1082R1032 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1082
	r_MmaAccumulatorHalf2WordAtPtx1083R1033 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1083
	r_MmaAccumulatorHalf2WordAtPtx1084R1034 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1084
	r_MmaAccumulatorHalf2WordAtPtx1085R1035 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1085
	r_MmaAccumulatorHalf2WordAtPtx1086R1036 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1086
	r_MmaAccumulatorHalf2WordAtPtx1087R1037 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1087
	r_MmaAccumulatorHalf2WordAtPtx1088R1038 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1088
	r_MmaAccumulatorHalf2WordAtPtx1089R1039 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1089
	r_MmaAccumulatorHalf2WordAtPtx1090R1040 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1090
	r_MmaAccumulatorHalf2WordAtPtx1091R1041 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1091
	r_MmaAccumulatorHalf2WordAtPtx1092R1042 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1092
	r_MmaAccumulatorHalf2WordAtPtx1093R1043 = uint32_t(r_PackedHalf2AtPtx60R271); // PTX L1093
L__BB38_143:																	  // PTX L1094
	r_PtxRegister398 = ShiftRight(uint32_t(r_PtxRegister1044), uint32_t(5));	  // PTX L1095
	r_PtxU16Register7 = uint16_t(r_PtxRegister398);								  // PTX L1096
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L1097
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L1098
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L1099
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L1100
	r_PtxRegister399 = uint32_t(r_PtxU16Register11);											  // PTX L1101
	r_PtxRegister33 = r_PtxRegister399 & 255;													  // PTX L1102
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L1103
	r_PtxRegister400 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8192));		  // PTX L1104
	r_PtxU64Register5 = uint64_t(r_PtxRegister400);												  // PTX L1105
	r_PtxRegister401 = uint32_t(0u /* native shared input */);									  // PTX L1106
	r_PtxRegister34 = uint32_t(r_PtxRegister401) + uint32_t(r_PtxRegister400);					  // PTX L1107
	r_LaneIndexAtPtx1109 = uint32_t((threadIdx.x & 31u));										  // PTX L1109
	r_PtxRegister402 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister30);					  // PTX L1111
	r_PtxRegister403 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1109), uint32_t(4));					  // PTX L1112
	r_PtxRegister287 = uint32_t(r_PtxRegister402) + uint32_t(r_PtxRegister403);					  // PTX L1113
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister287));
		r_MmaAHalf2WordAtPtx1115R302 = r_Value.x;
		r_MmaAHalf2WordAtPtx1115R303 = r_Value.y;
		r_MmaAHalf2WordAtPtx1115R304 = r_Value.z;
		r_MmaAHalf2WordAtPtx1115R305 = r_Value.w;
	} // PTX L1115
	r_LaneIndexAtPtx1118 = uint32_t((threadIdx.x & 31u));						// PTX L1118
	r_PtxRegister405 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister404);	// PTX L1120
	r_PtxRegister406 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1118), uint32_t(4));	// PTX L1121
	r_PtxRegister407 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister406); // PTX L1122
	r_PtxRegister289 = uint32_t(r_PtxRegister407) + uint32_t(512);				// PTX L1123
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister289));
		r_MmaAHalf2WordAtPtx1125R306 = r_Value.x;
		r_MmaAHalf2WordAtPtx1125R307 = r_Value.y;
		r_MmaAHalf2WordAtPtx1125R308 = r_Value.z;
		r_MmaAHalf2WordAtPtx1125R309 = r_Value.w;
	} // PTX L1125
	r_LaneIndexAtPtx1128 = uint32_t((threadIdx.x & 31u));						// PTX L1128
	r_PtxRegister408 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1128), uint32_t(4));	// PTX L1130
	r_PtxRegister409 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister408); // PTX L1131
	r_PtxRegister291 = uint32_t(r_PtxRegister409) + uint32_t(1024);				// PTX L1132
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister291));
		r_MmaAHalf2WordAtPtx1134R326 = r_Value.x;
		r_MmaAHalf2WordAtPtx1134R327 = r_Value.y;
		r_MmaAHalf2WordAtPtx1134R328 = r_Value.z;
		r_MmaAHalf2WordAtPtx1134R329 = r_Value.w;
	} // PTX L1134
	r_LaneIndexAtPtx1137 = uint32_t((threadIdx.x & 31u));						// PTX L1137
	r_PtxRegister410 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1137), uint32_t(4));	// PTX L1139
	r_PtxRegister411 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister410); // PTX L1140
	r_PtxRegister293 = uint32_t(r_PtxRegister411) + uint32_t(1536);				// PTX L1141
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister293));
		r_MmaAHalf2WordAtPtx1143R330 = r_Value.x;
		r_MmaAHalf2WordAtPtx1143R331 = r_Value.y;
		r_MmaAHalf2WordAtPtx1143R332 = r_Value.z;
		r_MmaAHalf2WordAtPtx1143R333 = r_Value.w;
	} // PTX L1143
	r_LaneIndexAtPtx1146 = uint32_t((threadIdx.x & 31u));						// PTX L1146
	r_PtxRegister412 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1146), uint32_t(4));	// PTX L1148
	r_PtxRegister413 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister412); // PTX L1149
	r_PtxRegister295 = uint32_t(r_PtxRegister413) + uint32_t(2048);				// PTX L1150
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister295));
		r_MmaAHalf2WordAtPtx1152R350 = r_Value.x;
		r_MmaAHalf2WordAtPtx1152R351 = r_Value.y;
		r_MmaAHalf2WordAtPtx1152R352 = r_Value.z;
		r_MmaAHalf2WordAtPtx1152R353 = r_Value.w;
	} // PTX L1152
	r_LaneIndexAtPtx1155 = uint32_t((threadIdx.x & 31u));						// PTX L1155
	r_PtxRegister414 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1155), uint32_t(4));	// PTX L1157
	r_PtxRegister415 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister414); // PTX L1158
	r_PtxRegister297 = uint32_t(r_PtxRegister415) + uint32_t(2560);				// PTX L1159
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister297));
		r_MmaAHalf2WordAtPtx1161R354 = r_Value.x;
		r_MmaAHalf2WordAtPtx1161R355 = r_Value.y;
		r_MmaAHalf2WordAtPtx1161R356 = r_Value.z;
		r_MmaAHalf2WordAtPtx1161R357 = r_Value.w;
	} // PTX L1161
	r_LaneIndexAtPtx1164 = uint32_t((threadIdx.x & 31u));						// PTX L1164
	r_PtxRegister416 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1164), uint32_t(4));	// PTX L1166
	r_PtxRegister417 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister416); // PTX L1167
	r_PtxRegister299 = uint32_t(r_PtxRegister417) + uint32_t(3072);				// PTX L1168
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister299));
		r_MmaAHalf2WordAtPtx1170R374 = r_Value.x;
		r_MmaAHalf2WordAtPtx1170R375 = r_Value.y;
		r_MmaAHalf2WordAtPtx1170R376 = r_Value.z;
		r_MmaAHalf2WordAtPtx1170R377 = r_Value.w;
	} // PTX L1170
	r_LaneIndexAtPtx1173 = uint32_t((threadIdx.x & 31u));						// PTX L1173
	r_PtxRegister418 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1173), uint32_t(4));	// PTX L1175
	r_PtxRegister419 = uint32_t(r_PtxRegister405) + uint32_t(r_PtxRegister418); // PTX L1176
	r_PtxRegister301 = uint32_t(r_PtxRegister419) + uint32_t(3584);				// PTX L1177
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister301));
		r_MmaAHalf2WordAtPtx1179R378 = r_Value.x;
		r_MmaAHalf2WordAtPtx1179R379 = r_Value.y;
		r_MmaAHalf2WordAtPtx1179R380 = r_Value.z;
		r_MmaAHalf2WordAtPtx1179R381 = r_Value.w;
	} // PTX L1179
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1182R310, r_MmaAccumulatorHalf2WordAtPtx1182R311,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx79R1070, r_MmaBHalf2WordAtPtx79R1069,
			r_MmaAccumulatorHalf2WordAtPtx1085R1035,
			r_MmaAccumulatorHalf2WordAtPtx1084R1034); // PTX L1182
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1189R312, r_MmaAccumulatorHalf2WordAtPtx1189R313,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx79R1068, r_MmaBHalf2WordAtPtx79R1067,
			r_MmaAccumulatorHalf2WordAtPtx1083R1033,
			r_MmaAccumulatorHalf2WordAtPtx1082R1032); // PTX L1189
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1085R1035, r_MmaAccumulatorHalf2WordAtPtx1084R1034,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx115R1054, r_MmaBHalf2WordAtPtx115R1053,
			r_MmaAccumulatorHalf2WordAtPtx1182R310,
			r_MmaAccumulatorHalf2WordAtPtx1182R311); // PTX L1196
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1083R1033, r_MmaAccumulatorHalf2WordAtPtx1082R1032,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx115R1052, r_MmaBHalf2WordAtPtx115R1051,
			r_MmaAccumulatorHalf2WordAtPtx1189R312,
			r_MmaAccumulatorHalf2WordAtPtx1189R313); // PTX L1203
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1210R314, r_MmaAccumulatorHalf2WordAtPtx1210R315,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx88R1066, r_MmaBHalf2WordAtPtx88R1065,
			r_MmaAccumulatorHalf2WordAtPtx1081R1031,
			r_MmaAccumulatorHalf2WordAtPtx1080R1030); // PTX L1210
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1217R316, r_MmaAccumulatorHalf2WordAtPtx1217R317,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx88R1064, r_MmaBHalf2WordAtPtx88R1063,
			r_MmaAccumulatorHalf2WordAtPtx1079R1029,
			r_MmaAccumulatorHalf2WordAtPtx1078R1028); // PTX L1217
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1081R1031, r_MmaAccumulatorHalf2WordAtPtx1080R1030,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx124R1050, r_MmaBHalf2WordAtPtx124R1049,
			r_MmaAccumulatorHalf2WordAtPtx1210R314,
			r_MmaAccumulatorHalf2WordAtPtx1210R315); // PTX L1224
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1079R1029, r_MmaAccumulatorHalf2WordAtPtx1078R1028,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx124R1048, r_MmaBHalf2WordAtPtx124R1047,
			r_MmaAccumulatorHalf2WordAtPtx1217R316,
			r_MmaAccumulatorHalf2WordAtPtx1217R317); // PTX L1231
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1238R318, r_MmaAccumulatorHalf2WordAtPtx1238R319,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx97R1062, r_MmaBHalf2WordAtPtx97R1061,
			r_MmaAccumulatorHalf2WordAtPtx1077R1027,
			r_MmaAccumulatorHalf2WordAtPtx1076R1026); // PTX L1238
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1245R320, r_MmaAccumulatorHalf2WordAtPtx1245R321,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx97R1060, r_MmaBHalf2WordAtPtx97R1059,
			r_MmaAccumulatorHalf2WordAtPtx1075R1025,
			r_MmaAccumulatorHalf2WordAtPtx1074R1024); // PTX L1245
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1077R1027, r_MmaAccumulatorHalf2WordAtPtx1076R1026,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx133R1046, r_MmaBHalf2WordAtPtx133R1045,
			r_MmaAccumulatorHalf2WordAtPtx1238R318,
			r_MmaAccumulatorHalf2WordAtPtx1238R319); // PTX L1252
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1075R1025, r_MmaAccumulatorHalf2WordAtPtx1074R1024,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx133R1071, r_MmaBHalf2WordAtPtx133R1072,
			r_MmaAccumulatorHalf2WordAtPtx1245R320,
			r_MmaAccumulatorHalf2WordAtPtx1245R321); // PTX L1259
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1266R322, r_MmaAccumulatorHalf2WordAtPtx1266R323,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx106R1058, r_MmaBHalf2WordAtPtx106R1057,
			r_MmaAccumulatorHalf2WordAtPtx1073R1023,
			r_MmaAccumulatorHalf2WordAtPtx1072R1022); // PTX L1266
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1273R324, r_MmaAccumulatorHalf2WordAtPtx1273R325,
			r_MmaAHalf2WordAtPtx1115R302, r_MmaAHalf2WordAtPtx1115R303, r_MmaAHalf2WordAtPtx1115R304,
			r_MmaAHalf2WordAtPtx1115R305, r_MmaBHalf2WordAtPtx106R1056, r_MmaBHalf2WordAtPtx106R1055,
			r_MmaAccumulatorHalf2WordAtPtx1071R1021,
			r_MmaAccumulatorHalf2WordAtPtx1070R1020); // PTX L1273
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1073R1023, r_MmaAccumulatorHalf2WordAtPtx1072R1022,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx142R1073, r_MmaBHalf2WordAtPtx142R1074,
			r_MmaAccumulatorHalf2WordAtPtx1266R322,
			r_MmaAccumulatorHalf2WordAtPtx1266R323); // PTX L1280
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1071R1021, r_MmaAccumulatorHalf2WordAtPtx1070R1020,
			r_MmaAHalf2WordAtPtx1125R306, r_MmaAHalf2WordAtPtx1125R307, r_MmaAHalf2WordAtPtx1125R308,
			r_MmaAHalf2WordAtPtx1125R309, r_MmaBHalf2WordAtPtx142R1075, r_MmaBHalf2WordAtPtx142R1076,
			r_MmaAccumulatorHalf2WordAtPtx1273R324,
			r_MmaAccumulatorHalf2WordAtPtx1273R325); // PTX L1287
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1294R334, r_MmaAccumulatorHalf2WordAtPtx1294R335,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx79R1070, r_MmaBHalf2WordAtPtx79R1069,
			r_MmaAccumulatorHalf2WordAtPtx1069R1019,
			r_MmaAccumulatorHalf2WordAtPtx1068R1018); // PTX L1294
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1301R336, r_MmaAccumulatorHalf2WordAtPtx1301R337,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx79R1068, r_MmaBHalf2WordAtPtx79R1067,
			r_MmaAccumulatorHalf2WordAtPtx1067R1017,
			r_MmaAccumulatorHalf2WordAtPtx1066R1016); // PTX L1301
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1069R1019, r_MmaAccumulatorHalf2WordAtPtx1068R1018,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx115R1054, r_MmaBHalf2WordAtPtx115R1053,
			r_MmaAccumulatorHalf2WordAtPtx1294R334,
			r_MmaAccumulatorHalf2WordAtPtx1294R335); // PTX L1308
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1067R1017, r_MmaAccumulatorHalf2WordAtPtx1066R1016,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx115R1052, r_MmaBHalf2WordAtPtx115R1051,
			r_MmaAccumulatorHalf2WordAtPtx1301R336,
			r_MmaAccumulatorHalf2WordAtPtx1301R337); // PTX L1315
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1322R338, r_MmaAccumulatorHalf2WordAtPtx1322R339,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx88R1066, r_MmaBHalf2WordAtPtx88R1065,
			r_MmaAccumulatorHalf2WordAtPtx1065R1015,
			r_MmaAccumulatorHalf2WordAtPtx1064R1014); // PTX L1322
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1329R340, r_MmaAccumulatorHalf2WordAtPtx1329R341,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx88R1064, r_MmaBHalf2WordAtPtx88R1063,
			r_MmaAccumulatorHalf2WordAtPtx1063R1013,
			r_MmaAccumulatorHalf2WordAtPtx1062R1012); // PTX L1329
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1065R1015, r_MmaAccumulatorHalf2WordAtPtx1064R1014,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx124R1050, r_MmaBHalf2WordAtPtx124R1049,
			r_MmaAccumulatorHalf2WordAtPtx1322R338,
			r_MmaAccumulatorHalf2WordAtPtx1322R339); // PTX L1336
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1063R1013, r_MmaAccumulatorHalf2WordAtPtx1062R1012,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx124R1048, r_MmaBHalf2WordAtPtx124R1047,
			r_MmaAccumulatorHalf2WordAtPtx1329R340,
			r_MmaAccumulatorHalf2WordAtPtx1329R341); // PTX L1343
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1350R342, r_MmaAccumulatorHalf2WordAtPtx1350R343,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx97R1062, r_MmaBHalf2WordAtPtx97R1061,
			r_MmaAccumulatorHalf2WordAtPtx1061R1011,
			r_MmaAccumulatorHalf2WordAtPtx1060R1010); // PTX L1350
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1357R344, r_MmaAccumulatorHalf2WordAtPtx1357R345,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx97R1060, r_MmaBHalf2WordAtPtx97R1059,
			r_MmaAccumulatorHalf2WordAtPtx1059R1009,
			r_MmaAccumulatorHalf2WordAtPtx1058R1008); // PTX L1357
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1061R1011, r_MmaAccumulatorHalf2WordAtPtx1060R1010,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx133R1046, r_MmaBHalf2WordAtPtx133R1045,
			r_MmaAccumulatorHalf2WordAtPtx1350R342,
			r_MmaAccumulatorHalf2WordAtPtx1350R343); // PTX L1364
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1059R1009, r_MmaAccumulatorHalf2WordAtPtx1058R1008,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx133R1071, r_MmaBHalf2WordAtPtx133R1072,
			r_MmaAccumulatorHalf2WordAtPtx1357R344,
			r_MmaAccumulatorHalf2WordAtPtx1357R345); // PTX L1371
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1378R346, r_MmaAccumulatorHalf2WordAtPtx1378R347,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx106R1058, r_MmaBHalf2WordAtPtx106R1057,
			r_MmaAccumulatorHalf2WordAtPtx1057R1007,
			r_MmaAccumulatorHalf2WordAtPtx1056R1006); // PTX L1378
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1385R348, r_MmaAccumulatorHalf2WordAtPtx1385R349,
			r_MmaAHalf2WordAtPtx1134R326, r_MmaAHalf2WordAtPtx1134R327, r_MmaAHalf2WordAtPtx1134R328,
			r_MmaAHalf2WordAtPtx1134R329, r_MmaBHalf2WordAtPtx106R1056, r_MmaBHalf2WordAtPtx106R1055,
			r_MmaAccumulatorHalf2WordAtPtx1055R1005,
			r_MmaAccumulatorHalf2WordAtPtx1054R1004); // PTX L1385
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1057R1007, r_MmaAccumulatorHalf2WordAtPtx1056R1006,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx142R1073, r_MmaBHalf2WordAtPtx142R1074,
			r_MmaAccumulatorHalf2WordAtPtx1378R346,
			r_MmaAccumulatorHalf2WordAtPtx1378R347); // PTX L1392
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1055R1005, r_MmaAccumulatorHalf2WordAtPtx1054R1004,
			r_MmaAHalf2WordAtPtx1143R330, r_MmaAHalf2WordAtPtx1143R331, r_MmaAHalf2WordAtPtx1143R332,
			r_MmaAHalf2WordAtPtx1143R333, r_MmaBHalf2WordAtPtx142R1075, r_MmaBHalf2WordAtPtx142R1076,
			r_MmaAccumulatorHalf2WordAtPtx1385R348,
			r_MmaAccumulatorHalf2WordAtPtx1385R349); // PTX L1399
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1406R358, r_MmaAccumulatorHalf2WordAtPtx1406R359,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx79R1070, r_MmaBHalf2WordAtPtx79R1069,
			r_MmaAccumulatorHalf2WordAtPtx1053R1003,
			r_MmaAccumulatorHalf2WordAtPtx1052R1002); // PTX L1406
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1413R360, r_MmaAccumulatorHalf2WordAtPtx1413R361,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx79R1068, r_MmaBHalf2WordAtPtx79R1067,
			r_MmaAccumulatorHalf2WordAtPtx1051R1001,
			r_MmaAccumulatorHalf2WordAtPtx1050R1000); // PTX L1413
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1053R1003, r_MmaAccumulatorHalf2WordAtPtx1052R1002,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx115R1054, r_MmaBHalf2WordAtPtx115R1053,
			r_MmaAccumulatorHalf2WordAtPtx1406R358,
			r_MmaAccumulatorHalf2WordAtPtx1406R359); // PTX L1420
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1051R1001, r_MmaAccumulatorHalf2WordAtPtx1050R1000,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx115R1052, r_MmaBHalf2WordAtPtx115R1051,
			r_MmaAccumulatorHalf2WordAtPtx1413R360,
			r_MmaAccumulatorHalf2WordAtPtx1413R361); // PTX L1427
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1434R362, r_MmaAccumulatorHalf2WordAtPtx1434R363,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx88R1066, r_MmaBHalf2WordAtPtx88R1065,
			r_MmaAccumulatorHalf2WordAtPtx1049R999,
			r_MmaAccumulatorHalf2WordAtPtx1048R998); // PTX L1434
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1441R364, r_MmaAccumulatorHalf2WordAtPtx1441R365,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx88R1064, r_MmaBHalf2WordAtPtx88R1063,
			r_MmaAccumulatorHalf2WordAtPtx1047R997,
			r_MmaAccumulatorHalf2WordAtPtx1046R996); // PTX L1441
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1049R999, r_MmaAccumulatorHalf2WordAtPtx1048R998,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx124R1050, r_MmaBHalf2WordAtPtx124R1049,
			r_MmaAccumulatorHalf2WordAtPtx1434R362,
			r_MmaAccumulatorHalf2WordAtPtx1434R363); // PTX L1448
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1047R997, r_MmaAccumulatorHalf2WordAtPtx1046R996,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx124R1048, r_MmaBHalf2WordAtPtx124R1047,
			r_MmaAccumulatorHalf2WordAtPtx1441R364,
			r_MmaAccumulatorHalf2WordAtPtx1441R365); // PTX L1455
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1462R366, r_MmaAccumulatorHalf2WordAtPtx1462R367,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx97R1062, r_MmaBHalf2WordAtPtx97R1061,
			r_MmaAccumulatorHalf2WordAtPtx1045R995,
			r_MmaAccumulatorHalf2WordAtPtx1044R994); // PTX L1462
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1469R368, r_MmaAccumulatorHalf2WordAtPtx1469R369,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx97R1060, r_MmaBHalf2WordAtPtx97R1059,
			r_MmaAccumulatorHalf2WordAtPtx1043R993,
			r_MmaAccumulatorHalf2WordAtPtx1042R992); // PTX L1469
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1045R995, r_MmaAccumulatorHalf2WordAtPtx1044R994,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx133R1046, r_MmaBHalf2WordAtPtx133R1045,
			r_MmaAccumulatorHalf2WordAtPtx1462R366,
			r_MmaAccumulatorHalf2WordAtPtx1462R367); // PTX L1476
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1043R993, r_MmaAccumulatorHalf2WordAtPtx1042R992,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx133R1071, r_MmaBHalf2WordAtPtx133R1072,
			r_MmaAccumulatorHalf2WordAtPtx1469R368,
			r_MmaAccumulatorHalf2WordAtPtx1469R369); // PTX L1483
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1490R370, r_MmaAccumulatorHalf2WordAtPtx1490R371,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx106R1058, r_MmaBHalf2WordAtPtx106R1057,
			r_MmaAccumulatorHalf2WordAtPtx1041R991,
			r_MmaAccumulatorHalf2WordAtPtx1040R990); // PTX L1490
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1497R372, r_MmaAccumulatorHalf2WordAtPtx1497R373,
			r_MmaAHalf2WordAtPtx1152R350, r_MmaAHalf2WordAtPtx1152R351, r_MmaAHalf2WordAtPtx1152R352,
			r_MmaAHalf2WordAtPtx1152R353, r_MmaBHalf2WordAtPtx106R1056, r_MmaBHalf2WordAtPtx106R1055,
			r_MmaAccumulatorHalf2WordAtPtx1039R989,
			r_MmaAccumulatorHalf2WordAtPtx1038R988); // PTX L1497
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1041R991, r_MmaAccumulatorHalf2WordAtPtx1040R990,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx142R1073, r_MmaBHalf2WordAtPtx142R1074,
			r_MmaAccumulatorHalf2WordAtPtx1490R370,
			r_MmaAccumulatorHalf2WordAtPtx1490R371); // PTX L1504
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1039R989, r_MmaAccumulatorHalf2WordAtPtx1038R988,
			r_MmaAHalf2WordAtPtx1161R354, r_MmaAHalf2WordAtPtx1161R355, r_MmaAHalf2WordAtPtx1161R356,
			r_MmaAHalf2WordAtPtx1161R357, r_MmaBHalf2WordAtPtx142R1075, r_MmaBHalf2WordAtPtx142R1076,
			r_MmaAccumulatorHalf2WordAtPtx1497R372,
			r_MmaAccumulatorHalf2WordAtPtx1497R373); // PTX L1511
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1518R382, r_MmaAccumulatorHalf2WordAtPtx1518R383,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx79R1070, r_MmaBHalf2WordAtPtx79R1069,
			r_MmaAccumulatorHalf2WordAtPtx1037R987,
			r_MmaAccumulatorHalf2WordAtPtx1036R986); // PTX L1518
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1525R384, r_MmaAccumulatorHalf2WordAtPtx1525R385,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx79R1068, r_MmaBHalf2WordAtPtx79R1067,
			r_MmaAccumulatorHalf2WordAtPtx1035R985,
			r_MmaAccumulatorHalf2WordAtPtx1034R984); // PTX L1525
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1037R987, r_MmaAccumulatorHalf2WordAtPtx1036R986,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx115R1054, r_MmaBHalf2WordAtPtx115R1053,
			r_MmaAccumulatorHalf2WordAtPtx1518R382,
			r_MmaAccumulatorHalf2WordAtPtx1518R383); // PTX L1532
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1035R985, r_MmaAccumulatorHalf2WordAtPtx1034R984,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx115R1052, r_MmaBHalf2WordAtPtx115R1051,
			r_MmaAccumulatorHalf2WordAtPtx1525R384,
			r_MmaAccumulatorHalf2WordAtPtx1525R385); // PTX L1539
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1546R386, r_MmaAccumulatorHalf2WordAtPtx1546R387,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx88R1066, r_MmaBHalf2WordAtPtx88R1065,
			r_MmaAccumulatorHalf2WordAtPtx1033R983,
			r_MmaAccumulatorHalf2WordAtPtx1032R982); // PTX L1546
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1553R388, r_MmaAccumulatorHalf2WordAtPtx1553R389,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx88R1064, r_MmaBHalf2WordAtPtx88R1063,
			r_MmaAccumulatorHalf2WordAtPtx1031R981,
			r_MmaAccumulatorHalf2WordAtPtx1030R980); // PTX L1553
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1033R983, r_MmaAccumulatorHalf2WordAtPtx1032R982,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx124R1050, r_MmaBHalf2WordAtPtx124R1049,
			r_MmaAccumulatorHalf2WordAtPtx1546R386,
			r_MmaAccumulatorHalf2WordAtPtx1546R387); // PTX L1560
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1031R981, r_MmaAccumulatorHalf2WordAtPtx1030R980,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx124R1048, r_MmaBHalf2WordAtPtx124R1047,
			r_MmaAccumulatorHalf2WordAtPtx1553R388,
			r_MmaAccumulatorHalf2WordAtPtx1553R389); // PTX L1567
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1574R390, r_MmaAccumulatorHalf2WordAtPtx1574R391,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx97R1062, r_MmaBHalf2WordAtPtx97R1061,
			r_MmaAccumulatorHalf2WordAtPtx1086R1036,
			r_MmaAccumulatorHalf2WordAtPtx1087R1037); // PTX L1574
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1581R392, r_MmaAccumulatorHalf2WordAtPtx1581R393,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx97R1060, r_MmaBHalf2WordAtPtx97R1059,
			r_MmaAccumulatorHalf2WordAtPtx1088R1038,
			r_MmaAccumulatorHalf2WordAtPtx1089R1039); // PTX L1581
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1086R1036, r_MmaAccumulatorHalf2WordAtPtx1087R1037,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx133R1046, r_MmaBHalf2WordAtPtx133R1045,
			r_MmaAccumulatorHalf2WordAtPtx1574R390,
			r_MmaAccumulatorHalf2WordAtPtx1574R391); // PTX L1588
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1088R1038, r_MmaAccumulatorHalf2WordAtPtx1089R1039,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx133R1071, r_MmaBHalf2WordAtPtx133R1072,
			r_MmaAccumulatorHalf2WordAtPtx1581R392,
			r_MmaAccumulatorHalf2WordAtPtx1581R393); // PTX L1595
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1602R394, r_MmaAccumulatorHalf2WordAtPtx1602R395,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx106R1058, r_MmaBHalf2WordAtPtx106R1057,
			r_MmaAccumulatorHalf2WordAtPtx1090R1040,
			r_MmaAccumulatorHalf2WordAtPtx1091R1041); // PTX L1602
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1609R396, r_MmaAccumulatorHalf2WordAtPtx1609R397,
			r_MmaAHalf2WordAtPtx1170R374, r_MmaAHalf2WordAtPtx1170R375, r_MmaAHalf2WordAtPtx1170R376,
			r_MmaAHalf2WordAtPtx1170R377, r_MmaBHalf2WordAtPtx106R1056, r_MmaBHalf2WordAtPtx106R1055,
			r_MmaAccumulatorHalf2WordAtPtx1092R1042,
			r_MmaAccumulatorHalf2WordAtPtx1093R1043); // PTX L1609
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1090R1040, r_MmaAccumulatorHalf2WordAtPtx1091R1041,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx142R1073, r_MmaBHalf2WordAtPtx142R1074,
			r_MmaAccumulatorHalf2WordAtPtx1602R394,
			r_MmaAccumulatorHalf2WordAtPtx1602R395); // PTX L1616
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx1092R1042, r_MmaAccumulatorHalf2WordAtPtx1093R1043,
			r_MmaAHalf2WordAtPtx1179R378, r_MmaAHalf2WordAtPtx1179R379, r_MmaAHalf2WordAtPtx1179R380,
			r_MmaAHalf2WordAtPtx1179R381, r_MmaBHalf2WordAtPtx142R1075, r_MmaBHalf2WordAtPtx142R1076,
			r_MmaAccumulatorHalf2WordAtPtx1609R396,
			r_MmaAccumulatorHalf2WordAtPtx1609R397);				 // PTX L1623
	r_bPtxPredicate47 = uint32_t(r_PtxRegister1044) > uint32_t(991); // PTX L1629
	if (r_bPtxPredicate47)
	{
		goto L__BB38_146;
	} // PTX L1630
	r_PtxRegister429 = uint32_t(r_PtxRegister1044) + uint32_t(32);								  // PTX L1631
	r_PtxRegister430 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister1044);					  // PTX L1632
	r_PtxRegister431 = ShiftLeft(uint32_t(r_PtxRegister430), uint32_t(11));						  // PTX L1633
	r_PtxRegister432 = uint32_t(r_PtxRegister431) + uint32_t(r_PtxRegister7);					  // PTX L1634
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister432)) * int64_t(int32_t(4)));	  // PTX L1635
	g_RecordByteAddressAtPtx1636 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register92);  // PTX L1636
	r_LaneIndexAtPtx1638 = uint32_t((threadIdx.x & 31u));										  // PTX L1638
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1638)) * int64_t(int32_t(16))); // PTX L1640
	g_RecordByteAddressAtPtx1641 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register94); // PTX L1641
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1641));
		r_MmaBHalf2WordAtPtx79R1070 = r_Value.x;
		r_MmaBHalf2WordAtPtx79R1069 = r_Value.y;
		r_MmaBHalf2WordAtPtx79R1068 = r_Value.z;
		r_MmaBHalf2WordAtPtx79R1067 = r_Value.w;
	} // PTX L1643
	r_LaneIndexAtPtx1646 = uint32_t((threadIdx.x & 31u));										  // PTX L1646
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1646)) * int64_t(int32_t(16))); // PTX L1648
	g_RecordByteAddressAtPtx1649 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register95);			   // PTX L1649
	g_RecordByteAddressAtPtx1650 = uint64_t(g_RecordByteAddressAtPtx1649) + uint64_t(512); // PTX L1650
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1650));
		r_MmaBHalf2WordAtPtx88R1066 = r_Value.x;
		r_MmaBHalf2WordAtPtx88R1065 = r_Value.y;
		r_MmaBHalf2WordAtPtx88R1064 = r_Value.z;
		r_MmaBHalf2WordAtPtx88R1063 = r_Value.w;
	} // PTX L1652
	r_LaneIndexAtPtx1655 = uint32_t((threadIdx.x & 31u));										  // PTX L1655
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1655)) * int64_t(int32_t(16))); // PTX L1657
	g_RecordByteAddressAtPtx1658 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register97);				// PTX L1658
	g_RecordByteAddressAtPtx1659 = uint64_t(g_RecordByteAddressAtPtx1658) + uint64_t(1024); // PTX L1659
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1659));
		r_MmaBHalf2WordAtPtx97R1062 = r_Value.x;
		r_MmaBHalf2WordAtPtx97R1061 = r_Value.y;
		r_MmaBHalf2WordAtPtx97R1060 = r_Value.z;
		r_MmaBHalf2WordAtPtx97R1059 = r_Value.w;
	} // PTX L1661
	r_LaneIndexAtPtx1664 = uint32_t((threadIdx.x & 31u));										  // PTX L1664
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1664)) * int64_t(int32_t(16))); // PTX L1666
	g_RecordByteAddressAtPtx1667 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register99);				// PTX L1667
	g_RecordByteAddressAtPtx1668 = uint64_t(g_RecordByteAddressAtPtx1667) + uint64_t(1536); // PTX L1668
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1668));
		r_MmaBHalf2WordAtPtx106R1058 = r_Value.x;
		r_MmaBHalf2WordAtPtx106R1057 = r_Value.y;
		r_MmaBHalf2WordAtPtx106R1056 = r_Value.z;
		r_MmaBHalf2WordAtPtx106R1055 = r_Value.w;
	} // PTX L1670
	r_LaneIndexAtPtx1673 = uint32_t((threadIdx.x & 31u)); // PTX L1673
	r_PtxU64Register101 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1673)) * int64_t(int32_t(16))); // PTX L1675
	g_RecordByteAddressAtPtx1676 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register101);				  // PTX L1676
	g_RecordByteAddressAtPtx1677 = uint64_t(g_RecordByteAddressAtPtx1676) + uint64_t(131072); // PTX L1677
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1677));
		r_MmaBHalf2WordAtPtx115R1054 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R1053 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R1052 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R1051 = r_Value.w;
	} // PTX L1679
	r_LaneIndexAtPtx1682 = uint32_t((threadIdx.x & 31u)); // PTX L1682
	r_PtxU64Register103 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1682)) * int64_t(int32_t(16))); // PTX L1684
	g_RecordByteAddressAtPtx1685 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register103);				  // PTX L1685
	g_RecordByteAddressAtPtx1686 = uint64_t(g_RecordByteAddressAtPtx1685) + uint64_t(131584); // PTX L1686
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1686));
		r_MmaBHalf2WordAtPtx124R1050 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R1049 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R1048 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R1047 = r_Value.w;
	} // PTX L1688
	r_LaneIndexAtPtx1691 = uint32_t((threadIdx.x & 31u)); // PTX L1691
	r_PtxU64Register105 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1691)) * int64_t(int32_t(16))); // PTX L1693
	g_RecordByteAddressAtPtx1694 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register105);				  // PTX L1694
	g_RecordByteAddressAtPtx1695 = uint64_t(g_RecordByteAddressAtPtx1694) + uint64_t(132096); // PTX L1695
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1695));
		r_MmaBHalf2WordAtPtx133R1046 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R1045 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R1071 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R1072 = r_Value.w;
	} // PTX L1697
	r_LaneIndexAtPtx1700 = uint32_t((threadIdx.x & 31u)); // PTX L1700
	r_PtxU64Register107 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1700)) * int64_t(int32_t(16))); // PTX L1702
	g_RecordByteAddressAtPtx1703 =
		uint64_t(g_RecordByteAddressAtPtx1636) + uint64_t(r_PtxU64Register107);				  // PTX L1703
	g_RecordByteAddressAtPtx1704 = uint64_t(g_RecordByteAddressAtPtx1703) + uint64_t(132608); // PTX L1704
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1704));
		r_MmaBHalf2WordAtPtx142R1073 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R1074 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R1075 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R1076 = r_Value.w;
	} // PTX L1706
	r_PtxRegister433 = ShiftRight(uint32_t(r_PtxRegister429), uint32_t(5)); // PTX L1708
	r_PtxU16Register13 = uint16_t(r_PtxRegister433);						// PTX L1709
	r_PtxU16Register14 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register13)) * uint32_t(uint16_t(171))); // PTX L1710
	r_PtxU16Register15 = ShiftRight(uint16_t(r_PtxU16Register14), uint32_t(9));		// PTX L1711
	r_PtxU16Register16 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register15)) * uint32_t(uint16_t(3)));			  // PTX L1712
	r_PtxU16Register17 = uint16_t(r_PtxU16Register13) - uint16_t(r_PtxU16Register16);		  // PTX L1713
	r_PtxU16Register18 = r_PtxU16Register17 & 255;											  // PTX L1714
	r_PtxRegister434 = uint32_t(uint16_t(r_PtxU16Register18)) * uint32_t(uint16_t(8));		  // PTX L1715
	r_PtxRegister435 = uint32_t(24576u /* native mbarriers */);								  // PTX L1716
	r_PtxRegister437 = uint32_t(r_PtxRegister435) + uint32_t(r_PtxRegister434);				  // PTX L1717
	r_PtxRegister428 = uint32_t(1);															  // PTX L1718
	r_PtxU64Register109 = BarrierArrive(s_SharedStorage, r_PtxRegister437, r_PtxRegister428); // PTX L1720
L__BB38_145:																				  // PTX L1722
	r_PtxRegister436 = BarrierReady(s_SharedStorage, r_PtxRegister437, r_PtxU64Register109);  // PTX L1724
	r_bPtxPredicate48 = uint32_t(r_PtxRegister436) == uint32_t(0);							  // PTX L1730
	if (r_bPtxPredicate48)
	{
		goto L__BB38_145;
	} // PTX L1731
L__BB38_146:														 // PTX L1732
	r_bPtxPredicate49 = uint32_t(r_PtxRegister1044) > uint32_t(927); // PTX L1733
	if (r_bPtxPredicate49)
	{
		goto L__BB38_185;
	} // PTX L1734
	r_PtxRegister35 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister1044);		   // PTX L1735
	r_PtxRegister36 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(3));			   // PTX L1736
	r_PtxRegister37 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister36);		   // PTX L1737
	r_PtxRegister438 = uint32_t(0u /* native shared input */);						   // PTX L1738
	r_PtxU64Register110 = uint64_t(r_PtxRegister438);								   // PTX L1739
	r_PtxU64Register111 = SharedGeneric(s_SharedStorage, r_PtxU64Register110);		   // PTX L1740
	r_PtxU64Register112 = uint64_t(r_PtxU64Register111) + uint64_t(r_PtxU64Register5); // PTX L1741
	r_PtxU64Register6 = uint64_t(r_PtxU64Register112) + uint64_t(r_PtxU64Register38);  // PTX L1742
	r_PtxU16Register26 = uint16_t(0);												   // PTX L1743
	r_PtxU64Register214 = uint64_t(0);												   // PTX L1744
	r_PtxRegister1077 = uint32_t(128);												   // PTX L1745
	r_PtxRegister1078 = uint32_t(r_PtxRegister1077);								   // PTX L1746
	r_PtxU64Register215 = uint64_t(r_PtxU64Register214);							   // PTX L1747
	if (r_bPtxPredicate6)
	{
		goto L__BB38_149;
	} // PTX L1748
	r_PtxRegister439 = r_bPtxPredicate1 ? r_PtxRegister37 : 0;								  // PTX L1749
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister439)) * int64_t(int32_t(4))); // PTX L1750
	r_PtxU64Register214 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register113);		  // PTX L1751
	r_PtxRegister1077 = uint32_t(r_PtxRegister439) + uint32_t(128);							  // PTX L1752
	r_PtxU16Register26 = uint16_t(1);														  // PTX L1753
	r_PtxRegister1078 = uint32_t(r_PtxRegister32);											  // PTX L1754
	r_PtxU64Register215 = uint64_t(r_PtxU64Register6);										  // PTX L1755
L__BB38_149:																				  // PTX L1756
	if (r_bPtxPredicate6)
	{
		goto L__BB38_151;
	} // PTX L1757
	r_PtxRegister440 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister11);	   // PTX L1758
	r_PtxRegister441 = uint32_t(r_PtxRegister440) + uint32_t(128);				   // PTX L1759
	r_bPtxPredicate50 = uint32_t(r_PtxRegister32) == uint32_t(r_PtxRegister1078);  // PTX L1760
	r_bPtxPredicate51 = uint32_t(r_PtxRegister441) == uint32_t(r_PtxRegister1077); // PTX L1761
	r_PtxU16Register19 = r_bPtxPredicate51 ? r_PtxU16Register26 : 0;			   // PTX L1762
	r_PtxU16Register26 = r_bPtxPredicate50 ? r_PtxU16Register19 : 0;			   // PTX L1763
L__BB38_151:																	   // PTX L1764
	r_bPtxPredicate52 = uint16_t(r_PtxU16Register26) == uint16_t(0);			   // PTX L1765
	r_PtxRegister442 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(3));		   // PTX L1766
	r_PtxRegister443 = uint32_t(24576u /* native mbarriers */);					   // PTX L1767
	r_PtxRegister38 = uint32_t(r_PtxRegister443) + uint32_t(r_PtxRegister442);	   // PTX L1768
	if (r_bPtxPredicate52)
	{
		goto L__BB38_154;
	} // PTX L1769
	r_PtxRegister445 = uint32_t(-1);							   // PTX L1770
	r_PtxRegister444 = Elected(r_PtxRegister445);				   // PTX L1772
	r_bPtxPredicate53 = uint32_t(r_PtxRegister444) == uint32_t(0); // PTX L1778
	if (r_bPtxPredicate53)
	{
		goto L__BB38_166;
	} // PTX L1779
	r_PtxU64Register115 = SharedOffset(s_SharedStorage, r_PtxU64Register215); // PTX L1780
	r_PtxRegister446 = uint32_t(r_PtxU64Register115);						  // PTX L1781
	r_PtxU64Register114 = r_PtxU64Register214;								  // PTX L1782
	r_PtxRegister447 = uint32_t(1024);										  // PTX L1783
	CopyBulk(s_SharedStorage, r_PtxRegister446, r_PtxU64Register114, r_PtxRegister447,
			 r_PtxRegister38);										   // PTX L1785
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister447); // PTX L1788
	goto L__BB38_166;												   // PTX L1790
L__BB38_154:														   // PTX L1791
	r_PtxU64Register7 = SignExtendWordBits(r_PtxRegister37);		   // PTX L1792
	r_PtxU64Register216 = uint64_t(0);								   // PTX L1793
	if (r_bPtxPredicate6)
	{
		goto L__BB38_156;
	} // PTX L1794
	r_PtxU64Register116 = r_bPtxPredicate1 ? r_PtxU64Register7 : 0;						// PTX L1795
	r_PtxU64Register117 = ShiftLeft(uint64_t(r_PtxU64Register116), uint32_t(2));		// PTX L1796
	r_PtxU64Register216 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register117); // PTX L1797
L__BB38_156:																			// PTX L1798
	r_PtxRegister448 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));				// PTX L1799
	r_PtxRegister39 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister448);			// PTX L1800
	if (r_bPtxPredicate6)
	{
		goto L__BB38_159;
	} // PTX L1801
	r_PtxRegister453 = uint32_t(-1);							   // PTX L1802
	r_PtxRegister452 = Elected(r_PtxRegister453);				   // PTX L1804
	r_bPtxPredicate54 = uint32_t(r_PtxRegister452) == uint32_t(0); // PTX L1810
	if (r_bPtxPredicate54)
	{
		goto L__BB38_160;
	} // PTX L1811
	r_PtxU64Register118 = r_PtxU64Register216; // PTX L1812
	r_PtxRegister454 = uint32_t(512);		   // PTX L1813
	CopyBulk(s_SharedStorage, r_PtxRegister39, r_PtxU64Register118, r_PtxRegister454,
			 r_PtxRegister38);												   // PTX L1815
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister454);		   // PTX L1818
	goto L__BB38_160;														   // PTX L1820
L__BB38_159:																   // PTX L1821
	r_LaneIndexAtPtx1823 = uint32_t((threadIdx.x & 31u));					   // PTX L1823
	r_PtxRegister451 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1823), uint32_t(4)); // PTX L1825
	r_PtxRegister450 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister451); // PTX L1826
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister450)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271); // PTX L1828
L__BB38_160:								  // PTX L1830
	r_PtxU64Register217 = uint64_t(0);		  // PTX L1831
	if (r_bPtxPredicate6)
	{
		goto L__BB38_162;
	} // PTX L1832
	r_PtxRegister455 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister11);			// PTX L1833
	r_PtxRegister456 = uint32_t(r_PtxRegister455) + uint32_t(128);						// PTX L1834
	r_PtxU64Register119 = SignExtendWordBits(r_PtxRegister456);							// PTX L1835
	r_PtxU64Register120 = r_bPtxPredicate1 ? r_PtxU64Register119 : 0;					// PTX L1836
	r_PtxU64Register121 = ShiftLeft(uint64_t(r_PtxU64Register120), uint32_t(2));		// PTX L1837
	r_PtxU64Register217 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register121); // PTX L1838
L__BB38_162:																			// PTX L1839
	if (r_bPtxPredicate6)
	{
		goto L__BB38_165;
	} // PTX L1840
	r_PtxRegister462 = uint32_t(-1);							   // PTX L1841
	r_PtxRegister461 = Elected(r_PtxRegister462);				   // PTX L1843
	r_bPtxPredicate55 = uint32_t(r_PtxRegister461) == uint32_t(0); // PTX L1849
	if (r_bPtxPredicate55)
	{
		goto L__BB38_166;
	} // PTX L1850
	r_PtxRegister463 = uint32_t(r_PtxRegister39) + uint32_t(512); // PTX L1851
	r_PtxU64Register122 = r_PtxU64Register217;					  // PTX L1852
	r_PtxRegister464 = uint32_t(512);							  // PTX L1853
	CopyBulk(s_SharedStorage, r_PtxRegister463, r_PtxU64Register122, r_PtxRegister464,
			 r_PtxRegister38);												   // PTX L1855
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister464);		   // PTX L1858
	goto L__BB38_166;														   // PTX L1860
L__BB38_165:																   // PTX L1861
	r_LaneIndexAtPtx1863 = uint32_t((threadIdx.x & 31u));					   // PTX L1863
	r_PtxRegister459 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1863), uint32_t(4)); // PTX L1865
	r_PtxRegister460 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister459); // PTX L1866
	r_PtxRegister458 = uint32_t(r_PtxRegister460) + uint32_t(512);			   // PTX L1867
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister458)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								 // PTX L1869
L__BB38_166:																 // PTX L1871
	r_PtxRegister40 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister36); // PTX L1872
	r_PtxU16Register27 = uint16_t(0);										 // PTX L1873
	r_PtxU64Register218 = uint64_t(0);										 // PTX L1874
	r_PtxRegister1079 = uint32_t(128);										 // PTX L1875
	r_PtxU64Register219 = uint64_t(r_PtxU64Register218);					 // PTX L1876
	if (r_bPtxPredicate15)
	{
		goto L__BB38_168;
	} // PTX L1877
	r_PtxRegister465 = r_bPtxPredicate2 ? r_PtxRegister40 : 0;								  // PTX L1878
	r_PtxU64Register219 = uint64_t(r_PtxU64Register6) + uint64_t(4096);						  // PTX L1879
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister465)) * int64_t(int32_t(4))); // PTX L1880
	r_PtxU64Register218 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register123);		  // PTX L1881
	r_PtxRegister1079 = uint32_t(r_PtxRegister465) + uint32_t(128);							  // PTX L1882
	r_PtxU16Register27 = uint16_t(1);														  // PTX L1883
L__BB38_168:																				  // PTX L1884
	if (r_bPtxPredicate15)
	{
		goto L__BB38_170;
	} // PTX L1885
	r_PtxRegister466 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister15);	   // PTX L1886
	r_PtxRegister467 = uint32_t(r_PtxRegister466) + uint32_t(128);				   // PTX L1887
	r_bPtxPredicate56 = uint32_t(r_PtxRegister467) == uint32_t(r_PtxRegister1079); // PTX L1888
	r_PtxU16Register27 = r_bPtxPredicate56 ? r_PtxU16Register27 : 0;			   // PTX L1889
L__BB38_170:																	   // PTX L1890
	r_bPtxPredicate57 = uint16_t(r_PtxU16Register27) == uint16_t(0);			   // PTX L1891
	if (r_bPtxPredicate57)
	{
		goto L__BB38_173;
	} // PTX L1892
	r_PtxRegister469 = uint32_t(-1);							   // PTX L1893
	r_PtxRegister468 = Elected(r_PtxRegister469);				   // PTX L1895
	r_bPtxPredicate58 = uint32_t(r_PtxRegister468) == uint32_t(0); // PTX L1901
	if (r_bPtxPredicate58)
	{
		goto L__BB38_185;
	} // PTX L1902
	r_PtxU64Register125 = SharedOffset(s_SharedStorage, r_PtxU64Register219); // PTX L1903
	r_PtxRegister470 = uint32_t(r_PtxU64Register125);						  // PTX L1904
	r_PtxU64Register124 = r_PtxU64Register218;								  // PTX L1905
	r_PtxRegister471 = uint32_t(1024);										  // PTX L1906
	CopyBulk(s_SharedStorage, r_PtxRegister470, r_PtxU64Register124, r_PtxRegister471,
			 r_PtxRegister38);										   // PTX L1908
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister471); // PTX L1911
	goto L__BB38_185;												   // PTX L1913
L__BB38_173:														   // PTX L1914
	r_PtxU64Register8 = SignExtendWordBits(r_PtxRegister40);		   // PTX L1915
	r_PtxU64Register220 = uint64_t(0);								   // PTX L1916
	if (r_bPtxPredicate15)
	{
		goto L__BB38_175;
	} // PTX L1917
	r_PtxU64Register126 = r_bPtxPredicate2 ? r_PtxU64Register8 : 0;						// PTX L1918
	r_PtxU64Register127 = ShiftLeft(uint64_t(r_PtxU64Register126), uint32_t(2));		// PTX L1919
	r_PtxU64Register220 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register127); // PTX L1920
L__BB38_175:																			// PTX L1921
	r_PtxRegister472 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));				// PTX L1922
	r_PtxRegister41 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister472);			// PTX L1923
	if (r_bPtxPredicate15)
	{
		goto L__BB38_178;
	} // PTX L1924
	r_PtxRegister477 = uint32_t(-1);							   // PTX L1925
	r_PtxRegister476 = Elected(r_PtxRegister477);				   // PTX L1927
	r_bPtxPredicate59 = uint32_t(r_PtxRegister476) == uint32_t(0); // PTX L1933
	if (r_bPtxPredicate59)
	{
		goto L__BB38_179;
	} // PTX L1934
	r_PtxU64Register128 = r_PtxU64Register220; // PTX L1935
	r_PtxRegister478 = uint32_t(512);		   // PTX L1936
	CopyBulk(s_SharedStorage, r_PtxRegister41, r_PtxU64Register128, r_PtxRegister478,
			 r_PtxRegister38);												   // PTX L1938
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister478);		   // PTX L1941
	goto L__BB38_179;														   // PTX L1943
L__BB38_178:																   // PTX L1944
	r_LaneIndexAtPtx1946 = uint32_t((threadIdx.x & 31u));					   // PTX L1946
	r_PtxRegister475 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1946), uint32_t(4)); // PTX L1948
	r_PtxRegister474 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister475); // PTX L1949
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister474)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);								  // PTX L1951
L__BB38_179:																  // PTX L1953
	r_PtxRegister479 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister15); // PTX L1954
	r_PtxRegister480 = uint32_t(r_PtxRegister479) + uint32_t(128);			  // PTX L1955
	r_PtxU64Register9 = SignExtendWordBits(r_PtxRegister480);				  // PTX L1956
	r_PtxU64Register221 = uint64_t(0);										  // PTX L1957
	if (r_bPtxPredicate15)
	{
		goto L__BB38_181;
	} // PTX L1958
	r_PtxU64Register129 = r_bPtxPredicate2 ? r_PtxU64Register9 : 0;						// PTX L1959
	r_PtxU64Register130 = ShiftLeft(uint64_t(r_PtxU64Register129), uint32_t(2));		// PTX L1960
	r_PtxU64Register221 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register130); // PTX L1961
L__BB38_181:																			// PTX L1962
	if (r_bPtxPredicate15)
	{
		goto L__BB38_184;
	} // PTX L1963
	r_PtxRegister486 = uint32_t(-1);							   // PTX L1964
	r_PtxRegister485 = Elected(r_PtxRegister486);				   // PTX L1966
	r_bPtxPredicate60 = uint32_t(r_PtxRegister485) == uint32_t(0); // PTX L1972
	if (r_bPtxPredicate60)
	{
		goto L__BB38_185;
	} // PTX L1973
	r_PtxRegister487 = uint32_t(r_PtxRegister41) + uint32_t(512); // PTX L1974
	r_PtxU64Register131 = r_PtxU64Register221;					  // PTX L1975
	r_PtxRegister488 = uint32_t(512);							  // PTX L1976
	CopyBulk(s_SharedStorage, r_PtxRegister487, r_PtxU64Register131, r_PtxRegister488,
			 r_PtxRegister38);												   // PTX L1978
	BarrierExpect(s_SharedStorage, r_PtxRegister38, r_PtxRegister488);		   // PTX L1981
	goto L__BB38_185;														   // PTX L1983
L__BB38_184:																   // PTX L1984
	r_LaneIndexAtPtx1986 = uint32_t((threadIdx.x & 31u));					   // PTX L1986
	r_PtxRegister483 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1986), uint32_t(4)); // PTX L1988
	r_PtxRegister484 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister483); // PTX L1989
	r_PtxRegister482 = uint32_t(r_PtxRegister484) + uint32_t(512);			   // PTX L1990
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister482)) =
		make_uint4(r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271, r_PackedHalf2AtPtx60R271,
				   r_PackedHalf2AtPtx60R271);						 // PTX L1992
L__BB38_185:														 // PTX L1994
	r_bPtxPredicate61 = uint32_t(r_PtxRegister1044) < uint32_t(992); // PTX L1995
	r_PtxRegister1044 = uint32_t(r_PtxRegister1044) + uint32_t(32);	 // PTX L1996
	if (r_bPtxPredicate61)
	{
		goto L__BB38_143;
	} // PTX L1997
	r_LaneIndexAtPtx1999 = uint32_t((threadIdx.x & 31u));				   // PTX L1999
	r_Float32BitsAtPtx2001R490 = uint32_t(-1065353216);					   // PTX L2001
	r_PackedHalf2AtPtx2003R497 = FloatToHalf2(r_Float32BitsAtPtx2001R490); // PTX L2003
	r_Float32BitsAtPtx2008R491 = uint32_t(1082130432);					   // PTX L2008
	r_PackedHalf2AtPtx2010R495 = FloatToHalf2(r_Float32BitsAtPtx2008R491); // PTX L2010
	r_Float32BitsAtPtx2015R492 = uint32_t(1063583744);					   // PTX L2015
	r_PackedHalf2AtPtx2017R503 = FloatToHalf2(r_Float32BitsAtPtx2015R492); // PTX L2017
	r_Float32BitsAtPtx2022R493 = uint32_t(1055195136);					   // PTX L2022
	r_PackedHalf2AtPtx2024R501 = FloatToHalf2(r_Float32BitsAtPtx2022R493); // PTX L2024
	r_Float32BitsAtPtx2029R494 = uint32_t(-1117454336);					   // PTX L2029
	r_PackedHalf2AtPtx2031R499 = FloatToHalf2(r_Float32BitsAtPtx2029R494); // PTX L2031
	r_PackedHalf2AtPtx2037R496 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1085R1035, r_PackedHalf2AtPtx2010R495);			  // PTX L2037
	r_PackedHalf2AtPtx2041R498 = HalfMax(r_PackedHalf2AtPtx2037R496, r_PackedHalf2AtPtx2003R497); // PTX L2041
	r_PackedHalf2AtPtx2045R500 = HalfAbs(r_PackedHalf2AtPtx2041R498);							  // PTX L2045
	r_PackedHalf2AtPtx2049R502 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2045R500,
										 r_PackedHalf2AtPtx2024R501); // PTX L2049
	r_PackedHalf2AtPtx2053R504 = HalfFma(r_PackedHalf2AtPtx2041R498, r_PackedHalf2AtPtx2049R502,
										 r_PackedHalf2AtPtx2017R503); // PTX L2053
	r_PackedHalf2AtPtx2057R886 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1085R1035, r_PackedHalf2AtPtx2053R504); // PTX L2057
	r_LaneIndexAtPtx2061 = uint32_t((threadIdx.x & 31u));							  // PTX L2061
	r_PackedHalf2AtPtx2064R506 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1084R1034, r_PackedHalf2AtPtx2010R495);			  // PTX L2064
	r_PackedHalf2AtPtx2068R507 = HalfMax(r_PackedHalf2AtPtx2064R506, r_PackedHalf2AtPtx2003R497); // PTX L2068
	r_PackedHalf2AtPtx2072R508 = HalfAbs(r_PackedHalf2AtPtx2068R507);							  // PTX L2072
	r_PackedHalf2AtPtx2076R509 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2072R508,
										 r_PackedHalf2AtPtx2024R501); // PTX L2076
	r_PackedHalf2AtPtx2080R510 = HalfFma(r_PackedHalf2AtPtx2068R507, r_PackedHalf2AtPtx2076R509,
										 r_PackedHalf2AtPtx2017R503); // PTX L2080
	r_PackedHalf2AtPtx2084R887 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1084R1034, r_PackedHalf2AtPtx2080R510); // PTX L2084
	r_LaneIndexAtPtx2088 = uint32_t((threadIdx.x & 31u));							  // PTX L2088
	r_PackedHalf2AtPtx2091R512 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1083R1033, r_PackedHalf2AtPtx2010R495);			  // PTX L2091
	r_PackedHalf2AtPtx2095R513 = HalfMax(r_PackedHalf2AtPtx2091R512, r_PackedHalf2AtPtx2003R497); // PTX L2095
	r_PackedHalf2AtPtx2099R514 = HalfAbs(r_PackedHalf2AtPtx2095R513);							  // PTX L2099
	r_PackedHalf2AtPtx2103R515 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2099R514,
										 r_PackedHalf2AtPtx2024R501); // PTX L2103
	r_PackedHalf2AtPtx2107R516 = HalfFma(r_PackedHalf2AtPtx2095R513, r_PackedHalf2AtPtx2103R515,
										 r_PackedHalf2AtPtx2017R503); // PTX L2107
	r_PackedHalf2AtPtx2111R888 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1083R1033, r_PackedHalf2AtPtx2107R516); // PTX L2111
	r_LaneIndexAtPtx2115 = uint32_t((threadIdx.x & 31u));							  // PTX L2115
	r_PackedHalf2AtPtx2118R518 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1082R1032, r_PackedHalf2AtPtx2010R495);			  // PTX L2118
	r_PackedHalf2AtPtx2122R519 = HalfMax(r_PackedHalf2AtPtx2118R518, r_PackedHalf2AtPtx2003R497); // PTX L2122
	r_PackedHalf2AtPtx2126R520 = HalfAbs(r_PackedHalf2AtPtx2122R519);							  // PTX L2126
	r_PackedHalf2AtPtx2130R521 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2126R520,
										 r_PackedHalf2AtPtx2024R501); // PTX L2130
	r_PackedHalf2AtPtx2134R522 = HalfFma(r_PackedHalf2AtPtx2122R519, r_PackedHalf2AtPtx2130R521,
										 r_PackedHalf2AtPtx2017R503); // PTX L2134
	r_PackedHalf2AtPtx2138R889 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1082R1032, r_PackedHalf2AtPtx2134R522); // PTX L2138
	r_LaneIndexAtPtx2142 = uint32_t((threadIdx.x & 31u));							  // PTX L2142
	r_PackedHalf2AtPtx2145R524 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1081R1031, r_PackedHalf2AtPtx2010R495);			  // PTX L2145
	r_PackedHalf2AtPtx2149R525 = HalfMax(r_PackedHalf2AtPtx2145R524, r_PackedHalf2AtPtx2003R497); // PTX L2149
	r_PackedHalf2AtPtx2153R526 = HalfAbs(r_PackedHalf2AtPtx2149R525);							  // PTX L2153
	r_PackedHalf2AtPtx2157R527 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2153R526,
										 r_PackedHalf2AtPtx2024R501); // PTX L2157
	r_PackedHalf2AtPtx2161R528 = HalfFma(r_PackedHalf2AtPtx2149R525, r_PackedHalf2AtPtx2157R527,
										 r_PackedHalf2AtPtx2017R503); // PTX L2161
	r_PackedHalf2AtPtx2165R891 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1081R1031, r_PackedHalf2AtPtx2161R528); // PTX L2165
	r_LaneIndexAtPtx2169 = uint32_t((threadIdx.x & 31u));							  // PTX L2169
	r_PackedHalf2AtPtx2172R530 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1080R1030, r_PackedHalf2AtPtx2010R495);			  // PTX L2172
	r_PackedHalf2AtPtx2176R531 = HalfMax(r_PackedHalf2AtPtx2172R530, r_PackedHalf2AtPtx2003R497); // PTX L2176
	r_PackedHalf2AtPtx2180R532 = HalfAbs(r_PackedHalf2AtPtx2176R531);							  // PTX L2180
	r_PackedHalf2AtPtx2184R533 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2180R532,
										 r_PackedHalf2AtPtx2024R501); // PTX L2184
	r_PackedHalf2AtPtx2188R534 = HalfFma(r_PackedHalf2AtPtx2176R531, r_PackedHalf2AtPtx2184R533,
										 r_PackedHalf2AtPtx2017R503); // PTX L2188
	r_PackedHalf2AtPtx2192R892 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1080R1030, r_PackedHalf2AtPtx2188R534); // PTX L2192
	r_LaneIndexAtPtx2196 = uint32_t((threadIdx.x & 31u));							  // PTX L2196
	r_PackedHalf2AtPtx2199R536 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1079R1029, r_PackedHalf2AtPtx2010R495);			  // PTX L2199
	r_PackedHalf2AtPtx2203R537 = HalfMax(r_PackedHalf2AtPtx2199R536, r_PackedHalf2AtPtx2003R497); // PTX L2203
	r_PackedHalf2AtPtx2207R538 = HalfAbs(r_PackedHalf2AtPtx2203R537);							  // PTX L2207
	r_PackedHalf2AtPtx2211R539 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2207R538,
										 r_PackedHalf2AtPtx2024R501); // PTX L2211
	r_PackedHalf2AtPtx2215R540 = HalfFma(r_PackedHalf2AtPtx2203R537, r_PackedHalf2AtPtx2211R539,
										 r_PackedHalf2AtPtx2017R503); // PTX L2215
	r_PackedHalf2AtPtx2219R893 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1079R1029, r_PackedHalf2AtPtx2215R540); // PTX L2219
	r_LaneIndexAtPtx2223 = uint32_t((threadIdx.x & 31u));							  // PTX L2223
	r_PackedHalf2AtPtx2226R542 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1078R1028, r_PackedHalf2AtPtx2010R495);			  // PTX L2226
	r_PackedHalf2AtPtx2230R543 = HalfMax(r_PackedHalf2AtPtx2226R542, r_PackedHalf2AtPtx2003R497); // PTX L2230
	r_PackedHalf2AtPtx2234R544 = HalfAbs(r_PackedHalf2AtPtx2230R543);							  // PTX L2234
	r_PackedHalf2AtPtx2238R545 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2234R544,
										 r_PackedHalf2AtPtx2024R501); // PTX L2238
	r_PackedHalf2AtPtx2242R546 = HalfFma(r_PackedHalf2AtPtx2230R543, r_PackedHalf2AtPtx2238R545,
										 r_PackedHalf2AtPtx2017R503); // PTX L2242
	r_PackedHalf2AtPtx2246R894 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1078R1028, r_PackedHalf2AtPtx2242R546); // PTX L2246
	r_LaneIndexAtPtx2250 = uint32_t((threadIdx.x & 31u));							  // PTX L2250
	r_PackedHalf2AtPtx2253R548 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1077R1027, r_PackedHalf2AtPtx2010R495);			  // PTX L2253
	r_PackedHalf2AtPtx2257R549 = HalfMax(r_PackedHalf2AtPtx2253R548, r_PackedHalf2AtPtx2003R497); // PTX L2257
	r_PackedHalf2AtPtx2261R550 = HalfAbs(r_PackedHalf2AtPtx2257R549);							  // PTX L2261
	r_PackedHalf2AtPtx2265R551 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2261R550,
										 r_PackedHalf2AtPtx2024R501); // PTX L2265
	r_PackedHalf2AtPtx2269R552 = HalfFma(r_PackedHalf2AtPtx2257R549, r_PackedHalf2AtPtx2265R551,
										 r_PackedHalf2AtPtx2017R503); // PTX L2269
	r_PackedHalf2AtPtx2273R896 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1077R1027, r_PackedHalf2AtPtx2269R552); // PTX L2273
	r_LaneIndexAtPtx2277 = uint32_t((threadIdx.x & 31u));							  // PTX L2277
	r_PackedHalf2AtPtx2280R554 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1076R1026, r_PackedHalf2AtPtx2010R495);			  // PTX L2280
	r_PackedHalf2AtPtx2284R555 = HalfMax(r_PackedHalf2AtPtx2280R554, r_PackedHalf2AtPtx2003R497); // PTX L2284
	r_PackedHalf2AtPtx2288R556 = HalfAbs(r_PackedHalf2AtPtx2284R555);							  // PTX L2288
	r_PackedHalf2AtPtx2292R557 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2288R556,
										 r_PackedHalf2AtPtx2024R501); // PTX L2292
	r_PackedHalf2AtPtx2296R558 = HalfFma(r_PackedHalf2AtPtx2284R555, r_PackedHalf2AtPtx2292R557,
										 r_PackedHalf2AtPtx2017R503); // PTX L2296
	r_PackedHalf2AtPtx2300R897 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1076R1026, r_PackedHalf2AtPtx2296R558); // PTX L2300
	r_LaneIndexAtPtx2304 = uint32_t((threadIdx.x & 31u));							  // PTX L2304
	r_PackedHalf2AtPtx2307R560 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1075R1025, r_PackedHalf2AtPtx2010R495);			  // PTX L2307
	r_PackedHalf2AtPtx2311R561 = HalfMax(r_PackedHalf2AtPtx2307R560, r_PackedHalf2AtPtx2003R497); // PTX L2311
	r_PackedHalf2AtPtx2315R562 = HalfAbs(r_PackedHalf2AtPtx2311R561);							  // PTX L2315
	r_PackedHalf2AtPtx2319R563 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2315R562,
										 r_PackedHalf2AtPtx2024R501); // PTX L2319
	r_PackedHalf2AtPtx2323R564 = HalfFma(r_PackedHalf2AtPtx2311R561, r_PackedHalf2AtPtx2319R563,
										 r_PackedHalf2AtPtx2017R503); // PTX L2323
	r_PackedHalf2AtPtx2327R898 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1075R1025, r_PackedHalf2AtPtx2323R564); // PTX L2327
	r_LaneIndexAtPtx2331 = uint32_t((threadIdx.x & 31u));							  // PTX L2331
	r_PackedHalf2AtPtx2334R566 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1074R1024, r_PackedHalf2AtPtx2010R495);			  // PTX L2334
	r_PackedHalf2AtPtx2338R567 = HalfMax(r_PackedHalf2AtPtx2334R566, r_PackedHalf2AtPtx2003R497); // PTX L2338
	r_PackedHalf2AtPtx2342R568 = HalfAbs(r_PackedHalf2AtPtx2338R567);							  // PTX L2342
	r_PackedHalf2AtPtx2346R569 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2342R568,
										 r_PackedHalf2AtPtx2024R501); // PTX L2346
	r_PackedHalf2AtPtx2350R570 = HalfFma(r_PackedHalf2AtPtx2338R567, r_PackedHalf2AtPtx2346R569,
										 r_PackedHalf2AtPtx2017R503); // PTX L2350
	r_PackedHalf2AtPtx2354R899 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1074R1024, r_PackedHalf2AtPtx2350R570); // PTX L2354
	r_LaneIndexAtPtx2358 = uint32_t((threadIdx.x & 31u));							  // PTX L2358
	r_PackedHalf2AtPtx2361R572 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1073R1023, r_PackedHalf2AtPtx2010R495);			  // PTX L2361
	r_PackedHalf2AtPtx2365R573 = HalfMax(r_PackedHalf2AtPtx2361R572, r_PackedHalf2AtPtx2003R497); // PTX L2365
	r_PackedHalf2AtPtx2369R574 = HalfAbs(r_PackedHalf2AtPtx2365R573);							  // PTX L2369
	r_PackedHalf2AtPtx2373R575 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2369R574,
										 r_PackedHalf2AtPtx2024R501); // PTX L2373
	r_PackedHalf2AtPtx2377R576 = HalfFma(r_PackedHalf2AtPtx2365R573, r_PackedHalf2AtPtx2373R575,
										 r_PackedHalf2AtPtx2017R503); // PTX L2377
	r_PackedHalf2AtPtx2381R901 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1073R1023, r_PackedHalf2AtPtx2377R576); // PTX L2381
	r_LaneIndexAtPtx2385 = uint32_t((threadIdx.x & 31u));							  // PTX L2385
	r_PackedHalf2AtPtx2388R578 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1072R1022, r_PackedHalf2AtPtx2010R495);			  // PTX L2388
	r_PackedHalf2AtPtx2392R579 = HalfMax(r_PackedHalf2AtPtx2388R578, r_PackedHalf2AtPtx2003R497); // PTX L2392
	r_PackedHalf2AtPtx2396R580 = HalfAbs(r_PackedHalf2AtPtx2392R579);							  // PTX L2396
	r_PackedHalf2AtPtx2400R581 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2396R580,
										 r_PackedHalf2AtPtx2024R501); // PTX L2400
	r_PackedHalf2AtPtx2404R582 = HalfFma(r_PackedHalf2AtPtx2392R579, r_PackedHalf2AtPtx2400R581,
										 r_PackedHalf2AtPtx2017R503); // PTX L2404
	r_PackedHalf2AtPtx2408R902 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1072R1022, r_PackedHalf2AtPtx2404R582); // PTX L2408
	r_LaneIndexAtPtx2412 = uint32_t((threadIdx.x & 31u));							  // PTX L2412
	r_PackedHalf2AtPtx2415R584 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1071R1021, r_PackedHalf2AtPtx2010R495);			  // PTX L2415
	r_PackedHalf2AtPtx2419R585 = HalfMax(r_PackedHalf2AtPtx2415R584, r_PackedHalf2AtPtx2003R497); // PTX L2419
	r_PackedHalf2AtPtx2423R586 = HalfAbs(r_PackedHalf2AtPtx2419R585);							  // PTX L2423
	r_PackedHalf2AtPtx2427R587 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2423R586,
										 r_PackedHalf2AtPtx2024R501); // PTX L2427
	r_PackedHalf2AtPtx2431R588 = HalfFma(r_PackedHalf2AtPtx2419R585, r_PackedHalf2AtPtx2427R587,
										 r_PackedHalf2AtPtx2017R503); // PTX L2431
	r_PackedHalf2AtPtx2435R903 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1071R1021, r_PackedHalf2AtPtx2431R588); // PTX L2435
	r_LaneIndexAtPtx2439 = uint32_t((threadIdx.x & 31u));							  // PTX L2439
	r_PackedHalf2AtPtx2442R590 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1070R1020, r_PackedHalf2AtPtx2010R495);			  // PTX L2442
	r_PackedHalf2AtPtx2446R591 = HalfMax(r_PackedHalf2AtPtx2442R590, r_PackedHalf2AtPtx2003R497); // PTX L2446
	r_PackedHalf2AtPtx2450R592 = HalfAbs(r_PackedHalf2AtPtx2446R591);							  // PTX L2450
	r_PackedHalf2AtPtx2454R593 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2450R592,
										 r_PackedHalf2AtPtx2024R501); // PTX L2454
	r_PackedHalf2AtPtx2458R594 = HalfFma(r_PackedHalf2AtPtx2446R591, r_PackedHalf2AtPtx2454R593,
										 r_PackedHalf2AtPtx2017R503); // PTX L2458
	r_PackedHalf2AtPtx2462R904 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1070R1020, r_PackedHalf2AtPtx2458R594); // PTX L2462
	r_LaneIndexAtPtx2466 = uint32_t((threadIdx.x & 31u));							  // PTX L2466
	r_PackedHalf2AtPtx2469R596 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1069R1019, r_PackedHalf2AtPtx2010R495);			  // PTX L2469
	r_PackedHalf2AtPtx2473R597 = HalfMax(r_PackedHalf2AtPtx2469R596, r_PackedHalf2AtPtx2003R497); // PTX L2473
	r_PackedHalf2AtPtx2477R598 = HalfAbs(r_PackedHalf2AtPtx2473R597);							  // PTX L2477
	r_PackedHalf2AtPtx2481R599 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2477R598,
										 r_PackedHalf2AtPtx2024R501); // PTX L2481
	r_PackedHalf2AtPtx2485R600 = HalfFma(r_PackedHalf2AtPtx2473R597, r_PackedHalf2AtPtx2481R599,
										 r_PackedHalf2AtPtx2017R503); // PTX L2485
	r_PackedHalf2AtPtx2489R907 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1069R1019, r_PackedHalf2AtPtx2485R600); // PTX L2489
	r_LaneIndexAtPtx2493 = uint32_t((threadIdx.x & 31u));							  // PTX L2493
	r_PackedHalf2AtPtx2496R602 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1068R1018, r_PackedHalf2AtPtx2010R495);			  // PTX L2496
	r_PackedHalf2AtPtx2500R603 = HalfMax(r_PackedHalf2AtPtx2496R602, r_PackedHalf2AtPtx2003R497); // PTX L2500
	r_PackedHalf2AtPtx2504R604 = HalfAbs(r_PackedHalf2AtPtx2500R603);							  // PTX L2504
	r_PackedHalf2AtPtx2508R605 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2504R604,
										 r_PackedHalf2AtPtx2024R501); // PTX L2508
	r_PackedHalf2AtPtx2512R606 = HalfFma(r_PackedHalf2AtPtx2500R603, r_PackedHalf2AtPtx2508R605,
										 r_PackedHalf2AtPtx2017R503); // PTX L2512
	r_PackedHalf2AtPtx2516R908 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1068R1018, r_PackedHalf2AtPtx2512R606); // PTX L2516
	r_LaneIndexAtPtx2520 = uint32_t((threadIdx.x & 31u));							  // PTX L2520
	r_PackedHalf2AtPtx2523R608 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1067R1017, r_PackedHalf2AtPtx2010R495);			  // PTX L2523
	r_PackedHalf2AtPtx2527R609 = HalfMax(r_PackedHalf2AtPtx2523R608, r_PackedHalf2AtPtx2003R497); // PTX L2527
	r_PackedHalf2AtPtx2531R610 = HalfAbs(r_PackedHalf2AtPtx2527R609);							  // PTX L2531
	r_PackedHalf2AtPtx2535R611 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2531R610,
										 r_PackedHalf2AtPtx2024R501); // PTX L2535
	r_PackedHalf2AtPtx2539R612 = HalfFma(r_PackedHalf2AtPtx2527R609, r_PackedHalf2AtPtx2535R611,
										 r_PackedHalf2AtPtx2017R503); // PTX L2539
	r_PackedHalf2AtPtx2543R909 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1067R1017, r_PackedHalf2AtPtx2539R612); // PTX L2543
	r_LaneIndexAtPtx2547 = uint32_t((threadIdx.x & 31u));							  // PTX L2547
	r_PackedHalf2AtPtx2550R614 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1066R1016, r_PackedHalf2AtPtx2010R495);			  // PTX L2550
	r_PackedHalf2AtPtx2554R615 = HalfMax(r_PackedHalf2AtPtx2550R614, r_PackedHalf2AtPtx2003R497); // PTX L2554
	r_PackedHalf2AtPtx2558R616 = HalfAbs(r_PackedHalf2AtPtx2554R615);							  // PTX L2558
	r_PackedHalf2AtPtx2562R617 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2558R616,
										 r_PackedHalf2AtPtx2024R501); // PTX L2562
	r_PackedHalf2AtPtx2566R618 = HalfFma(r_PackedHalf2AtPtx2554R615, r_PackedHalf2AtPtx2562R617,
										 r_PackedHalf2AtPtx2017R503); // PTX L2566
	r_PackedHalf2AtPtx2570R910 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1066R1016, r_PackedHalf2AtPtx2566R618); // PTX L2570
	r_LaneIndexAtPtx2574 = uint32_t((threadIdx.x & 31u));							  // PTX L2574
	r_PackedHalf2AtPtx2577R620 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1065R1015, r_PackedHalf2AtPtx2010R495);			  // PTX L2577
	r_PackedHalf2AtPtx2581R621 = HalfMax(r_PackedHalf2AtPtx2577R620, r_PackedHalf2AtPtx2003R497); // PTX L2581
	r_PackedHalf2AtPtx2585R622 = HalfAbs(r_PackedHalf2AtPtx2581R621);							  // PTX L2585
	r_PackedHalf2AtPtx2589R623 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2585R622,
										 r_PackedHalf2AtPtx2024R501); // PTX L2589
	r_PackedHalf2AtPtx2593R624 = HalfFma(r_PackedHalf2AtPtx2581R621, r_PackedHalf2AtPtx2589R623,
										 r_PackedHalf2AtPtx2017R503); // PTX L2593
	r_PackedHalf2AtPtx2597R912 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1065R1015, r_PackedHalf2AtPtx2593R624); // PTX L2597
	r_LaneIndexAtPtx2601 = uint32_t((threadIdx.x & 31u));							  // PTX L2601
	r_PackedHalf2AtPtx2604R626 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1064R1014, r_PackedHalf2AtPtx2010R495);			  // PTX L2604
	r_PackedHalf2AtPtx2608R627 = HalfMax(r_PackedHalf2AtPtx2604R626, r_PackedHalf2AtPtx2003R497); // PTX L2608
	r_PackedHalf2AtPtx2612R628 = HalfAbs(r_PackedHalf2AtPtx2608R627);							  // PTX L2612
	r_PackedHalf2AtPtx2616R629 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2612R628,
										 r_PackedHalf2AtPtx2024R501); // PTX L2616
	r_PackedHalf2AtPtx2620R630 = HalfFma(r_PackedHalf2AtPtx2608R627, r_PackedHalf2AtPtx2616R629,
										 r_PackedHalf2AtPtx2017R503); // PTX L2620
	r_PackedHalf2AtPtx2624R913 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1064R1014, r_PackedHalf2AtPtx2620R630); // PTX L2624
	r_LaneIndexAtPtx2628 = uint32_t((threadIdx.x & 31u));							  // PTX L2628
	r_PackedHalf2AtPtx2631R632 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1063R1013, r_PackedHalf2AtPtx2010R495);			  // PTX L2631
	r_PackedHalf2AtPtx2635R633 = HalfMax(r_PackedHalf2AtPtx2631R632, r_PackedHalf2AtPtx2003R497); // PTX L2635
	r_PackedHalf2AtPtx2639R634 = HalfAbs(r_PackedHalf2AtPtx2635R633);							  // PTX L2639
	r_PackedHalf2AtPtx2643R635 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2639R634,
										 r_PackedHalf2AtPtx2024R501); // PTX L2643
	r_PackedHalf2AtPtx2647R636 = HalfFma(r_PackedHalf2AtPtx2635R633, r_PackedHalf2AtPtx2643R635,
										 r_PackedHalf2AtPtx2017R503); // PTX L2647
	r_PackedHalf2AtPtx2651R914 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1063R1013, r_PackedHalf2AtPtx2647R636); // PTX L2651
	r_LaneIndexAtPtx2655 = uint32_t((threadIdx.x & 31u));							  // PTX L2655
	r_PackedHalf2AtPtx2658R638 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1062R1012, r_PackedHalf2AtPtx2010R495);			  // PTX L2658
	r_PackedHalf2AtPtx2662R639 = HalfMax(r_PackedHalf2AtPtx2658R638, r_PackedHalf2AtPtx2003R497); // PTX L2662
	r_PackedHalf2AtPtx2666R640 = HalfAbs(r_PackedHalf2AtPtx2662R639);							  // PTX L2666
	r_PackedHalf2AtPtx2670R641 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2666R640,
										 r_PackedHalf2AtPtx2024R501); // PTX L2670
	r_PackedHalf2AtPtx2674R642 = HalfFma(r_PackedHalf2AtPtx2662R639, r_PackedHalf2AtPtx2670R641,
										 r_PackedHalf2AtPtx2017R503); // PTX L2674
	r_PackedHalf2AtPtx2678R915 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1062R1012, r_PackedHalf2AtPtx2674R642); // PTX L2678
	r_LaneIndexAtPtx2682 = uint32_t((threadIdx.x & 31u));							  // PTX L2682
	r_PackedHalf2AtPtx2685R644 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1061R1011, r_PackedHalf2AtPtx2010R495);			  // PTX L2685
	r_PackedHalf2AtPtx2689R645 = HalfMax(r_PackedHalf2AtPtx2685R644, r_PackedHalf2AtPtx2003R497); // PTX L2689
	r_PackedHalf2AtPtx2693R646 = HalfAbs(r_PackedHalf2AtPtx2689R645);							  // PTX L2693
	r_PackedHalf2AtPtx2697R647 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2693R646,
										 r_PackedHalf2AtPtx2024R501); // PTX L2697
	r_PackedHalf2AtPtx2701R648 = HalfFma(r_PackedHalf2AtPtx2689R645, r_PackedHalf2AtPtx2697R647,
										 r_PackedHalf2AtPtx2017R503); // PTX L2701
	r_PackedHalf2AtPtx2705R917 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1061R1011, r_PackedHalf2AtPtx2701R648); // PTX L2705
	r_LaneIndexAtPtx2709 = uint32_t((threadIdx.x & 31u));							  // PTX L2709
	r_PackedHalf2AtPtx2712R650 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1060R1010, r_PackedHalf2AtPtx2010R495);			  // PTX L2712
	r_PackedHalf2AtPtx2716R651 = HalfMax(r_PackedHalf2AtPtx2712R650, r_PackedHalf2AtPtx2003R497); // PTX L2716
	r_PackedHalf2AtPtx2720R652 = HalfAbs(r_PackedHalf2AtPtx2716R651);							  // PTX L2720
	r_PackedHalf2AtPtx2724R653 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2720R652,
										 r_PackedHalf2AtPtx2024R501); // PTX L2724
	r_PackedHalf2AtPtx2728R654 = HalfFma(r_PackedHalf2AtPtx2716R651, r_PackedHalf2AtPtx2724R653,
										 r_PackedHalf2AtPtx2017R503); // PTX L2728
	r_PackedHalf2AtPtx2732R918 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1060R1010, r_PackedHalf2AtPtx2728R654); // PTX L2732
	r_LaneIndexAtPtx2736 = uint32_t((threadIdx.x & 31u));							  // PTX L2736
	r_PackedHalf2AtPtx2739R656 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1059R1009, r_PackedHalf2AtPtx2010R495);			  // PTX L2739
	r_PackedHalf2AtPtx2743R657 = HalfMax(r_PackedHalf2AtPtx2739R656, r_PackedHalf2AtPtx2003R497); // PTX L2743
	r_PackedHalf2AtPtx2747R658 = HalfAbs(r_PackedHalf2AtPtx2743R657);							  // PTX L2747
	r_PackedHalf2AtPtx2751R659 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2747R658,
										 r_PackedHalf2AtPtx2024R501); // PTX L2751
	r_PackedHalf2AtPtx2755R660 = HalfFma(r_PackedHalf2AtPtx2743R657, r_PackedHalf2AtPtx2751R659,
										 r_PackedHalf2AtPtx2017R503); // PTX L2755
	r_PackedHalf2AtPtx2759R919 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1059R1009, r_PackedHalf2AtPtx2755R660); // PTX L2759
	r_LaneIndexAtPtx2763 = uint32_t((threadIdx.x & 31u));							  // PTX L2763
	r_PackedHalf2AtPtx2766R662 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1058R1008, r_PackedHalf2AtPtx2010R495);			  // PTX L2766
	r_PackedHalf2AtPtx2770R663 = HalfMax(r_PackedHalf2AtPtx2766R662, r_PackedHalf2AtPtx2003R497); // PTX L2770
	r_PackedHalf2AtPtx2774R664 = HalfAbs(r_PackedHalf2AtPtx2770R663);							  // PTX L2774
	r_PackedHalf2AtPtx2778R665 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2774R664,
										 r_PackedHalf2AtPtx2024R501); // PTX L2778
	r_PackedHalf2AtPtx2782R666 = HalfFma(r_PackedHalf2AtPtx2770R663, r_PackedHalf2AtPtx2778R665,
										 r_PackedHalf2AtPtx2017R503); // PTX L2782
	r_PackedHalf2AtPtx2786R920 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1058R1008, r_PackedHalf2AtPtx2782R666); // PTX L2786
	r_LaneIndexAtPtx2790 = uint32_t((threadIdx.x & 31u));							  // PTX L2790
	r_PackedHalf2AtPtx2793R668 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1057R1007, r_PackedHalf2AtPtx2010R495);			  // PTX L2793
	r_PackedHalf2AtPtx2797R669 = HalfMax(r_PackedHalf2AtPtx2793R668, r_PackedHalf2AtPtx2003R497); // PTX L2797
	r_PackedHalf2AtPtx2801R670 = HalfAbs(r_PackedHalf2AtPtx2797R669);							  // PTX L2801
	r_PackedHalf2AtPtx2805R671 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2801R670,
										 r_PackedHalf2AtPtx2024R501); // PTX L2805
	r_PackedHalf2AtPtx2809R672 = HalfFma(r_PackedHalf2AtPtx2797R669, r_PackedHalf2AtPtx2805R671,
										 r_PackedHalf2AtPtx2017R503); // PTX L2809
	r_PackedHalf2AtPtx2813R922 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1057R1007, r_PackedHalf2AtPtx2809R672); // PTX L2813
	r_LaneIndexAtPtx2817 = uint32_t((threadIdx.x & 31u));							  // PTX L2817
	r_PackedHalf2AtPtx2820R674 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1056R1006, r_PackedHalf2AtPtx2010R495);			  // PTX L2820
	r_PackedHalf2AtPtx2824R675 = HalfMax(r_PackedHalf2AtPtx2820R674, r_PackedHalf2AtPtx2003R497); // PTX L2824
	r_PackedHalf2AtPtx2828R676 = HalfAbs(r_PackedHalf2AtPtx2824R675);							  // PTX L2828
	r_PackedHalf2AtPtx2832R677 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2828R676,
										 r_PackedHalf2AtPtx2024R501); // PTX L2832
	r_PackedHalf2AtPtx2836R678 = HalfFma(r_PackedHalf2AtPtx2824R675, r_PackedHalf2AtPtx2832R677,
										 r_PackedHalf2AtPtx2017R503); // PTX L2836
	r_PackedHalf2AtPtx2840R923 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1056R1006, r_PackedHalf2AtPtx2836R678); // PTX L2840
	r_LaneIndexAtPtx2844 = uint32_t((threadIdx.x & 31u));							  // PTX L2844
	r_PackedHalf2AtPtx2847R680 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1055R1005, r_PackedHalf2AtPtx2010R495);			  // PTX L2847
	r_PackedHalf2AtPtx2851R681 = HalfMax(r_PackedHalf2AtPtx2847R680, r_PackedHalf2AtPtx2003R497); // PTX L2851
	r_PackedHalf2AtPtx2855R682 = HalfAbs(r_PackedHalf2AtPtx2851R681);							  // PTX L2855
	r_PackedHalf2AtPtx2859R683 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2855R682,
										 r_PackedHalf2AtPtx2024R501); // PTX L2859
	r_PackedHalf2AtPtx2863R684 = HalfFma(r_PackedHalf2AtPtx2851R681, r_PackedHalf2AtPtx2859R683,
										 r_PackedHalf2AtPtx2017R503); // PTX L2863
	r_PackedHalf2AtPtx2867R924 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1055R1005, r_PackedHalf2AtPtx2863R684); // PTX L2867
	r_LaneIndexAtPtx2871 = uint32_t((threadIdx.x & 31u));							  // PTX L2871
	r_PackedHalf2AtPtx2874R686 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1054R1004, r_PackedHalf2AtPtx2010R495);			  // PTX L2874
	r_PackedHalf2AtPtx2878R687 = HalfMax(r_PackedHalf2AtPtx2874R686, r_PackedHalf2AtPtx2003R497); // PTX L2878
	r_PackedHalf2AtPtx2882R688 = HalfAbs(r_PackedHalf2AtPtx2878R687);							  // PTX L2882
	r_PackedHalf2AtPtx2886R689 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2882R688,
										 r_PackedHalf2AtPtx2024R501); // PTX L2886
	r_PackedHalf2AtPtx2890R690 = HalfFma(r_PackedHalf2AtPtx2878R687, r_PackedHalf2AtPtx2886R689,
										 r_PackedHalf2AtPtx2017R503); // PTX L2890
	r_PackedHalf2AtPtx2894R925 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1054R1004, r_PackedHalf2AtPtx2890R690); // PTX L2894
	r_LaneIndexAtPtx2898 = uint32_t((threadIdx.x & 31u));							  // PTX L2898
	r_PackedHalf2AtPtx2901R692 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1053R1003, r_PackedHalf2AtPtx2010R495);			  // PTX L2901
	r_PackedHalf2AtPtx2905R693 = HalfMax(r_PackedHalf2AtPtx2901R692, r_PackedHalf2AtPtx2003R497); // PTX L2905
	r_PackedHalf2AtPtx2909R694 = HalfAbs(r_PackedHalf2AtPtx2905R693);							  // PTX L2909
	r_PackedHalf2AtPtx2913R695 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2909R694,
										 r_PackedHalf2AtPtx2024R501); // PTX L2913
	r_PackedHalf2AtPtx2917R696 = HalfFma(r_PackedHalf2AtPtx2905R693, r_PackedHalf2AtPtx2913R695,
										 r_PackedHalf2AtPtx2017R503); // PTX L2917
	r_PackedHalf2AtPtx2921R928 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1053R1003, r_PackedHalf2AtPtx2917R696); // PTX L2921
	r_LaneIndexAtPtx2925 = uint32_t((threadIdx.x & 31u));							  // PTX L2925
	r_PackedHalf2AtPtx2928R698 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1052R1002, r_PackedHalf2AtPtx2010R495);			  // PTX L2928
	r_PackedHalf2AtPtx2932R699 = HalfMax(r_PackedHalf2AtPtx2928R698, r_PackedHalf2AtPtx2003R497); // PTX L2932
	r_PackedHalf2AtPtx2936R700 = HalfAbs(r_PackedHalf2AtPtx2932R699);							  // PTX L2936
	r_PackedHalf2AtPtx2940R701 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2936R700,
										 r_PackedHalf2AtPtx2024R501); // PTX L2940
	r_PackedHalf2AtPtx2944R702 = HalfFma(r_PackedHalf2AtPtx2932R699, r_PackedHalf2AtPtx2940R701,
										 r_PackedHalf2AtPtx2017R503); // PTX L2944
	r_PackedHalf2AtPtx2948R929 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1052R1002, r_PackedHalf2AtPtx2944R702); // PTX L2948
	r_LaneIndexAtPtx2952 = uint32_t((threadIdx.x & 31u));							  // PTX L2952
	r_PackedHalf2AtPtx2955R704 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1051R1001, r_PackedHalf2AtPtx2010R495);			  // PTX L2955
	r_PackedHalf2AtPtx2959R705 = HalfMax(r_PackedHalf2AtPtx2955R704, r_PackedHalf2AtPtx2003R497); // PTX L2959
	r_PackedHalf2AtPtx2963R706 = HalfAbs(r_PackedHalf2AtPtx2959R705);							  // PTX L2963
	r_PackedHalf2AtPtx2967R707 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2963R706,
										 r_PackedHalf2AtPtx2024R501); // PTX L2967
	r_PackedHalf2AtPtx2971R708 = HalfFma(r_PackedHalf2AtPtx2959R705, r_PackedHalf2AtPtx2967R707,
										 r_PackedHalf2AtPtx2017R503); // PTX L2971
	r_PackedHalf2AtPtx2975R930 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1051R1001, r_PackedHalf2AtPtx2971R708); // PTX L2975
	r_LaneIndexAtPtx2979 = uint32_t((threadIdx.x & 31u));							  // PTX L2979
	r_PackedHalf2AtPtx2982R710 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1050R1000, r_PackedHalf2AtPtx2010R495);			  // PTX L2982
	r_PackedHalf2AtPtx2986R711 = HalfMax(r_PackedHalf2AtPtx2982R710, r_PackedHalf2AtPtx2003R497); // PTX L2986
	r_PackedHalf2AtPtx2990R712 = HalfAbs(r_PackedHalf2AtPtx2986R711);							  // PTX L2990
	r_PackedHalf2AtPtx2994R713 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx2990R712,
										 r_PackedHalf2AtPtx2024R501); // PTX L2994
	r_PackedHalf2AtPtx2998R714 = HalfFma(r_PackedHalf2AtPtx2986R711, r_PackedHalf2AtPtx2994R713,
										 r_PackedHalf2AtPtx2017R503); // PTX L2998
	r_PackedHalf2AtPtx3002R931 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1050R1000, r_PackedHalf2AtPtx2998R714); // PTX L3002
	r_LaneIndexAtPtx3006 = uint32_t((threadIdx.x & 31u));							  // PTX L3006
	r_PackedHalf2AtPtx3009R716 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1049R999, r_PackedHalf2AtPtx2010R495);			  // PTX L3009
	r_PackedHalf2AtPtx3013R717 = HalfMax(r_PackedHalf2AtPtx3009R716, r_PackedHalf2AtPtx2003R497); // PTX L3013
	r_PackedHalf2AtPtx3017R718 = HalfAbs(r_PackedHalf2AtPtx3013R717);							  // PTX L3017
	r_PackedHalf2AtPtx3021R719 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3017R718,
										 r_PackedHalf2AtPtx2024R501); // PTX L3021
	r_PackedHalf2AtPtx3025R720 = HalfFma(r_PackedHalf2AtPtx3013R717, r_PackedHalf2AtPtx3021R719,
										 r_PackedHalf2AtPtx2017R503); // PTX L3025
	r_PackedHalf2AtPtx3029R933 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1049R999, r_PackedHalf2AtPtx3025R720); // PTX L3029
	r_LaneIndexAtPtx3033 = uint32_t((threadIdx.x & 31u));							 // PTX L3033
	r_PackedHalf2AtPtx3036R722 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1048R998, r_PackedHalf2AtPtx2010R495);			  // PTX L3036
	r_PackedHalf2AtPtx3040R723 = HalfMax(r_PackedHalf2AtPtx3036R722, r_PackedHalf2AtPtx2003R497); // PTX L3040
	r_PackedHalf2AtPtx3044R724 = HalfAbs(r_PackedHalf2AtPtx3040R723);							  // PTX L3044
	r_PackedHalf2AtPtx3048R725 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3044R724,
										 r_PackedHalf2AtPtx2024R501); // PTX L3048
	r_PackedHalf2AtPtx3052R726 = HalfFma(r_PackedHalf2AtPtx3040R723, r_PackedHalf2AtPtx3048R725,
										 r_PackedHalf2AtPtx2017R503); // PTX L3052
	r_PackedHalf2AtPtx3056R934 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1048R998, r_PackedHalf2AtPtx3052R726); // PTX L3056
	r_LaneIndexAtPtx3060 = uint32_t((threadIdx.x & 31u));							 // PTX L3060
	r_PackedHalf2AtPtx3063R728 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1047R997, r_PackedHalf2AtPtx2010R495);			  // PTX L3063
	r_PackedHalf2AtPtx3067R729 = HalfMax(r_PackedHalf2AtPtx3063R728, r_PackedHalf2AtPtx2003R497); // PTX L3067
	r_PackedHalf2AtPtx3071R730 = HalfAbs(r_PackedHalf2AtPtx3067R729);							  // PTX L3071
	r_PackedHalf2AtPtx3075R731 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3071R730,
										 r_PackedHalf2AtPtx2024R501); // PTX L3075
	r_PackedHalf2AtPtx3079R732 = HalfFma(r_PackedHalf2AtPtx3067R729, r_PackedHalf2AtPtx3075R731,
										 r_PackedHalf2AtPtx2017R503); // PTX L3079
	r_PackedHalf2AtPtx3083R935 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1047R997, r_PackedHalf2AtPtx3079R732); // PTX L3083
	r_LaneIndexAtPtx3087 = uint32_t((threadIdx.x & 31u));							 // PTX L3087
	r_PackedHalf2AtPtx3090R734 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1046R996, r_PackedHalf2AtPtx2010R495);			  // PTX L3090
	r_PackedHalf2AtPtx3094R735 = HalfMax(r_PackedHalf2AtPtx3090R734, r_PackedHalf2AtPtx2003R497); // PTX L3094
	r_PackedHalf2AtPtx3098R736 = HalfAbs(r_PackedHalf2AtPtx3094R735);							  // PTX L3098
	r_PackedHalf2AtPtx3102R737 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3098R736,
										 r_PackedHalf2AtPtx2024R501); // PTX L3102
	r_PackedHalf2AtPtx3106R738 = HalfFma(r_PackedHalf2AtPtx3094R735, r_PackedHalf2AtPtx3102R737,
										 r_PackedHalf2AtPtx2017R503); // PTX L3106
	r_PackedHalf2AtPtx3110R936 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1046R996, r_PackedHalf2AtPtx3106R738); // PTX L3110
	r_LaneIndexAtPtx3114 = uint32_t((threadIdx.x & 31u));							 // PTX L3114
	r_PackedHalf2AtPtx3117R740 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1045R995, r_PackedHalf2AtPtx2010R495);			  // PTX L3117
	r_PackedHalf2AtPtx3121R741 = HalfMax(r_PackedHalf2AtPtx3117R740, r_PackedHalf2AtPtx2003R497); // PTX L3121
	r_PackedHalf2AtPtx3125R742 = HalfAbs(r_PackedHalf2AtPtx3121R741);							  // PTX L3125
	r_PackedHalf2AtPtx3129R743 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3125R742,
										 r_PackedHalf2AtPtx2024R501); // PTX L3129
	r_PackedHalf2AtPtx3133R744 = HalfFma(r_PackedHalf2AtPtx3121R741, r_PackedHalf2AtPtx3129R743,
										 r_PackedHalf2AtPtx2017R503); // PTX L3133
	r_PackedHalf2AtPtx3137R938 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1045R995, r_PackedHalf2AtPtx3133R744); // PTX L3137
	r_LaneIndexAtPtx3141 = uint32_t((threadIdx.x & 31u));							 // PTX L3141
	r_PackedHalf2AtPtx3144R746 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1044R994, r_PackedHalf2AtPtx2010R495);			  // PTX L3144
	r_PackedHalf2AtPtx3148R747 = HalfMax(r_PackedHalf2AtPtx3144R746, r_PackedHalf2AtPtx2003R497); // PTX L3148
	r_PackedHalf2AtPtx3152R748 = HalfAbs(r_PackedHalf2AtPtx3148R747);							  // PTX L3152
	r_PackedHalf2AtPtx3156R749 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3152R748,
										 r_PackedHalf2AtPtx2024R501); // PTX L3156
	r_PackedHalf2AtPtx3160R750 = HalfFma(r_PackedHalf2AtPtx3148R747, r_PackedHalf2AtPtx3156R749,
										 r_PackedHalf2AtPtx2017R503); // PTX L3160
	r_PackedHalf2AtPtx3164R939 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1044R994, r_PackedHalf2AtPtx3160R750); // PTX L3164
	r_LaneIndexAtPtx3168 = uint32_t((threadIdx.x & 31u));							 // PTX L3168
	r_PackedHalf2AtPtx3171R752 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1043R993, r_PackedHalf2AtPtx2010R495);			  // PTX L3171
	r_PackedHalf2AtPtx3175R753 = HalfMax(r_PackedHalf2AtPtx3171R752, r_PackedHalf2AtPtx2003R497); // PTX L3175
	r_PackedHalf2AtPtx3179R754 = HalfAbs(r_PackedHalf2AtPtx3175R753);							  // PTX L3179
	r_PackedHalf2AtPtx3183R755 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3179R754,
										 r_PackedHalf2AtPtx2024R501); // PTX L3183
	r_PackedHalf2AtPtx3187R756 = HalfFma(r_PackedHalf2AtPtx3175R753, r_PackedHalf2AtPtx3183R755,
										 r_PackedHalf2AtPtx2017R503); // PTX L3187
	r_PackedHalf2AtPtx3191R940 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1043R993, r_PackedHalf2AtPtx3187R756); // PTX L3191
	r_LaneIndexAtPtx3195 = uint32_t((threadIdx.x & 31u));							 // PTX L3195
	r_PackedHalf2AtPtx3198R758 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1042R992, r_PackedHalf2AtPtx2010R495);			  // PTX L3198
	r_PackedHalf2AtPtx3202R759 = HalfMax(r_PackedHalf2AtPtx3198R758, r_PackedHalf2AtPtx2003R497); // PTX L3202
	r_PackedHalf2AtPtx3206R760 = HalfAbs(r_PackedHalf2AtPtx3202R759);							  // PTX L3206
	r_PackedHalf2AtPtx3210R761 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3206R760,
										 r_PackedHalf2AtPtx2024R501); // PTX L3210
	r_PackedHalf2AtPtx3214R762 = HalfFma(r_PackedHalf2AtPtx3202R759, r_PackedHalf2AtPtx3210R761,
										 r_PackedHalf2AtPtx2017R503); // PTX L3214
	r_PackedHalf2AtPtx3218R941 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1042R992, r_PackedHalf2AtPtx3214R762); // PTX L3218
	r_LaneIndexAtPtx3222 = uint32_t((threadIdx.x & 31u));							 // PTX L3222
	r_PackedHalf2AtPtx3225R764 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1041R991, r_PackedHalf2AtPtx2010R495);			  // PTX L3225
	r_PackedHalf2AtPtx3229R765 = HalfMax(r_PackedHalf2AtPtx3225R764, r_PackedHalf2AtPtx2003R497); // PTX L3229
	r_PackedHalf2AtPtx3233R766 = HalfAbs(r_PackedHalf2AtPtx3229R765);							  // PTX L3233
	r_PackedHalf2AtPtx3237R767 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3233R766,
										 r_PackedHalf2AtPtx2024R501); // PTX L3237
	r_PackedHalf2AtPtx3241R768 = HalfFma(r_PackedHalf2AtPtx3229R765, r_PackedHalf2AtPtx3237R767,
										 r_PackedHalf2AtPtx2017R503); // PTX L3241
	r_PackedHalf2AtPtx3245R943 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1041R991, r_PackedHalf2AtPtx3241R768); // PTX L3245
	r_LaneIndexAtPtx3249 = uint32_t((threadIdx.x & 31u));							 // PTX L3249
	r_PackedHalf2AtPtx3252R770 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1040R990, r_PackedHalf2AtPtx2010R495);			  // PTX L3252
	r_PackedHalf2AtPtx3256R771 = HalfMax(r_PackedHalf2AtPtx3252R770, r_PackedHalf2AtPtx2003R497); // PTX L3256
	r_PackedHalf2AtPtx3260R772 = HalfAbs(r_PackedHalf2AtPtx3256R771);							  // PTX L3260
	r_PackedHalf2AtPtx3264R773 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3260R772,
										 r_PackedHalf2AtPtx2024R501); // PTX L3264
	r_PackedHalf2AtPtx3268R774 = HalfFma(r_PackedHalf2AtPtx3256R771, r_PackedHalf2AtPtx3264R773,
										 r_PackedHalf2AtPtx2017R503); // PTX L3268
	r_PackedHalf2AtPtx3272R944 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1040R990, r_PackedHalf2AtPtx3268R774); // PTX L3272
	r_LaneIndexAtPtx3276 = uint32_t((threadIdx.x & 31u));							 // PTX L3276
	r_PackedHalf2AtPtx3279R776 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1039R989, r_PackedHalf2AtPtx2010R495);			  // PTX L3279
	r_PackedHalf2AtPtx3283R777 = HalfMax(r_PackedHalf2AtPtx3279R776, r_PackedHalf2AtPtx2003R497); // PTX L3283
	r_PackedHalf2AtPtx3287R778 = HalfAbs(r_PackedHalf2AtPtx3283R777);							  // PTX L3287
	r_PackedHalf2AtPtx3291R779 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3287R778,
										 r_PackedHalf2AtPtx2024R501); // PTX L3291
	r_PackedHalf2AtPtx3295R780 = HalfFma(r_PackedHalf2AtPtx3283R777, r_PackedHalf2AtPtx3291R779,
										 r_PackedHalf2AtPtx2017R503); // PTX L3295
	r_PackedHalf2AtPtx3299R945 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1039R989, r_PackedHalf2AtPtx3295R780); // PTX L3299
	r_LaneIndexAtPtx3303 = uint32_t((threadIdx.x & 31u));							 // PTX L3303
	r_PackedHalf2AtPtx3306R782 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1038R988, r_PackedHalf2AtPtx2010R495);			  // PTX L3306
	r_PackedHalf2AtPtx3310R783 = HalfMax(r_PackedHalf2AtPtx3306R782, r_PackedHalf2AtPtx2003R497); // PTX L3310
	r_PackedHalf2AtPtx3314R784 = HalfAbs(r_PackedHalf2AtPtx3310R783);							  // PTX L3314
	r_PackedHalf2AtPtx3318R785 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3314R784,
										 r_PackedHalf2AtPtx2024R501); // PTX L3318
	r_PackedHalf2AtPtx3322R786 = HalfFma(r_PackedHalf2AtPtx3310R783, r_PackedHalf2AtPtx3318R785,
										 r_PackedHalf2AtPtx2017R503); // PTX L3322
	r_PackedHalf2AtPtx3326R946 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1038R988, r_PackedHalf2AtPtx3322R786); // PTX L3326
	r_LaneIndexAtPtx3330 = uint32_t((threadIdx.x & 31u));							 // PTX L3330
	r_PackedHalf2AtPtx3333R788 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1037R987, r_PackedHalf2AtPtx2010R495);			  // PTX L3333
	r_PackedHalf2AtPtx3337R789 = HalfMax(r_PackedHalf2AtPtx3333R788, r_PackedHalf2AtPtx2003R497); // PTX L3337
	r_PackedHalf2AtPtx3341R790 = HalfAbs(r_PackedHalf2AtPtx3337R789);							  // PTX L3341
	r_PackedHalf2AtPtx3345R791 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3341R790,
										 r_PackedHalf2AtPtx2024R501); // PTX L3345
	r_PackedHalf2AtPtx3349R792 = HalfFma(r_PackedHalf2AtPtx3337R789, r_PackedHalf2AtPtx3345R791,
										 r_PackedHalf2AtPtx2017R503); // PTX L3349
	r_PackedHalf2AtPtx3353R949 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1037R987, r_PackedHalf2AtPtx3349R792); // PTX L3353
	r_LaneIndexAtPtx3357 = uint32_t((threadIdx.x & 31u));							 // PTX L3357
	r_PackedHalf2AtPtx3360R794 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1036R986, r_PackedHalf2AtPtx2010R495);			  // PTX L3360
	r_PackedHalf2AtPtx3364R795 = HalfMax(r_PackedHalf2AtPtx3360R794, r_PackedHalf2AtPtx2003R497); // PTX L3364
	r_PackedHalf2AtPtx3368R796 = HalfAbs(r_PackedHalf2AtPtx3364R795);							  // PTX L3368
	r_PackedHalf2AtPtx3372R797 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3368R796,
										 r_PackedHalf2AtPtx2024R501); // PTX L3372
	r_PackedHalf2AtPtx3376R798 = HalfFma(r_PackedHalf2AtPtx3364R795, r_PackedHalf2AtPtx3372R797,
										 r_PackedHalf2AtPtx2017R503); // PTX L3376
	r_PackedHalf2AtPtx3380R950 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1036R986, r_PackedHalf2AtPtx3376R798); // PTX L3380
	r_LaneIndexAtPtx3384 = uint32_t((threadIdx.x & 31u));							 // PTX L3384
	r_PackedHalf2AtPtx3387R800 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1035R985, r_PackedHalf2AtPtx2010R495);			  // PTX L3387
	r_PackedHalf2AtPtx3391R801 = HalfMax(r_PackedHalf2AtPtx3387R800, r_PackedHalf2AtPtx2003R497); // PTX L3391
	r_PackedHalf2AtPtx3395R802 = HalfAbs(r_PackedHalf2AtPtx3391R801);							  // PTX L3395
	r_PackedHalf2AtPtx3399R803 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3395R802,
										 r_PackedHalf2AtPtx2024R501); // PTX L3399
	r_PackedHalf2AtPtx3403R804 = HalfFma(r_PackedHalf2AtPtx3391R801, r_PackedHalf2AtPtx3399R803,
										 r_PackedHalf2AtPtx2017R503); // PTX L3403
	r_PackedHalf2AtPtx3407R951 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1035R985, r_PackedHalf2AtPtx3403R804); // PTX L3407
	r_LaneIndexAtPtx3411 = uint32_t((threadIdx.x & 31u));							 // PTX L3411
	r_PackedHalf2AtPtx3414R806 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1034R984, r_PackedHalf2AtPtx2010R495);			  // PTX L3414
	r_PackedHalf2AtPtx3418R807 = HalfMax(r_PackedHalf2AtPtx3414R806, r_PackedHalf2AtPtx2003R497); // PTX L3418
	r_PackedHalf2AtPtx3422R808 = HalfAbs(r_PackedHalf2AtPtx3418R807);							  // PTX L3422
	r_PackedHalf2AtPtx3426R809 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3422R808,
										 r_PackedHalf2AtPtx2024R501); // PTX L3426
	r_PackedHalf2AtPtx3430R810 = HalfFma(r_PackedHalf2AtPtx3418R807, r_PackedHalf2AtPtx3426R809,
										 r_PackedHalf2AtPtx2017R503); // PTX L3430
	r_PackedHalf2AtPtx3434R952 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1034R984, r_PackedHalf2AtPtx3430R810); // PTX L3434
	r_LaneIndexAtPtx3438 = uint32_t((threadIdx.x & 31u));							 // PTX L3438
	r_PackedHalf2AtPtx3441R812 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1033R983, r_PackedHalf2AtPtx2010R495);			  // PTX L3441
	r_PackedHalf2AtPtx3445R813 = HalfMax(r_PackedHalf2AtPtx3441R812, r_PackedHalf2AtPtx2003R497); // PTX L3445
	r_PackedHalf2AtPtx3449R814 = HalfAbs(r_PackedHalf2AtPtx3445R813);							  // PTX L3449
	r_PackedHalf2AtPtx3453R815 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3449R814,
										 r_PackedHalf2AtPtx2024R501); // PTX L3453
	r_PackedHalf2AtPtx3457R816 = HalfFma(r_PackedHalf2AtPtx3445R813, r_PackedHalf2AtPtx3453R815,
										 r_PackedHalf2AtPtx2017R503); // PTX L3457
	r_PackedHalf2AtPtx3461R954 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1033R983, r_PackedHalf2AtPtx3457R816); // PTX L3461
	r_LaneIndexAtPtx3465 = uint32_t((threadIdx.x & 31u));							 // PTX L3465
	r_PackedHalf2AtPtx3468R818 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1032R982, r_PackedHalf2AtPtx2010R495);			  // PTX L3468
	r_PackedHalf2AtPtx3472R819 = HalfMax(r_PackedHalf2AtPtx3468R818, r_PackedHalf2AtPtx2003R497); // PTX L3472
	r_PackedHalf2AtPtx3476R820 = HalfAbs(r_PackedHalf2AtPtx3472R819);							  // PTX L3476
	r_PackedHalf2AtPtx3480R821 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3476R820,
										 r_PackedHalf2AtPtx2024R501); // PTX L3480
	r_PackedHalf2AtPtx3484R822 = HalfFma(r_PackedHalf2AtPtx3472R819, r_PackedHalf2AtPtx3480R821,
										 r_PackedHalf2AtPtx2017R503); // PTX L3484
	r_PackedHalf2AtPtx3488R955 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1032R982, r_PackedHalf2AtPtx3484R822); // PTX L3488
	r_LaneIndexAtPtx3492 = uint32_t((threadIdx.x & 31u));							 // PTX L3492
	r_PackedHalf2AtPtx3495R824 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1031R981, r_PackedHalf2AtPtx2010R495);			  // PTX L3495
	r_PackedHalf2AtPtx3499R825 = HalfMax(r_PackedHalf2AtPtx3495R824, r_PackedHalf2AtPtx2003R497); // PTX L3499
	r_PackedHalf2AtPtx3503R826 = HalfAbs(r_PackedHalf2AtPtx3499R825);							  // PTX L3503
	r_PackedHalf2AtPtx3507R827 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3503R826,
										 r_PackedHalf2AtPtx2024R501); // PTX L3507
	r_PackedHalf2AtPtx3511R828 = HalfFma(r_PackedHalf2AtPtx3499R825, r_PackedHalf2AtPtx3507R827,
										 r_PackedHalf2AtPtx2017R503); // PTX L3511
	r_PackedHalf2AtPtx3515R956 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1031R981, r_PackedHalf2AtPtx3511R828); // PTX L3515
	r_LaneIndexAtPtx3519 = uint32_t((threadIdx.x & 31u));							 // PTX L3519
	r_PackedHalf2AtPtx3522R830 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1030R980, r_PackedHalf2AtPtx2010R495);			  // PTX L3522
	r_PackedHalf2AtPtx3526R831 = HalfMax(r_PackedHalf2AtPtx3522R830, r_PackedHalf2AtPtx2003R497); // PTX L3526
	r_PackedHalf2AtPtx3530R832 = HalfAbs(r_PackedHalf2AtPtx3526R831);							  // PTX L3530
	r_PackedHalf2AtPtx3534R833 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3530R832,
										 r_PackedHalf2AtPtx2024R501); // PTX L3534
	r_PackedHalf2AtPtx3538R834 = HalfFma(r_PackedHalf2AtPtx3526R831, r_PackedHalf2AtPtx3534R833,
										 r_PackedHalf2AtPtx2017R503); // PTX L3538
	r_PackedHalf2AtPtx3542R957 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1030R980, r_PackedHalf2AtPtx3538R834); // PTX L3542
	r_LaneIndexAtPtx3546 = uint32_t((threadIdx.x & 31u));							 // PTX L3546
	r_PackedHalf2AtPtx3549R836 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1086R1036, r_PackedHalf2AtPtx2010R495);			  // PTX L3549
	r_PackedHalf2AtPtx3553R837 = HalfMax(r_PackedHalf2AtPtx3549R836, r_PackedHalf2AtPtx2003R497); // PTX L3553
	r_PackedHalf2AtPtx3557R838 = HalfAbs(r_PackedHalf2AtPtx3553R837);							  // PTX L3557
	r_PackedHalf2AtPtx3561R839 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3557R838,
										 r_PackedHalf2AtPtx2024R501); // PTX L3561
	r_PackedHalf2AtPtx3565R840 = HalfFma(r_PackedHalf2AtPtx3553R837, r_PackedHalf2AtPtx3561R839,
										 r_PackedHalf2AtPtx2017R503); // PTX L3565
	r_PackedHalf2AtPtx3569R959 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1086R1036, r_PackedHalf2AtPtx3565R840); // PTX L3569
	r_LaneIndexAtPtx3573 = uint32_t((threadIdx.x & 31u));							  // PTX L3573
	r_PackedHalf2AtPtx3576R842 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1087R1037, r_PackedHalf2AtPtx2010R495);			  // PTX L3576
	r_PackedHalf2AtPtx3580R843 = HalfMax(r_PackedHalf2AtPtx3576R842, r_PackedHalf2AtPtx2003R497); // PTX L3580
	r_PackedHalf2AtPtx3584R844 = HalfAbs(r_PackedHalf2AtPtx3580R843);							  // PTX L3584
	r_PackedHalf2AtPtx3588R845 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3584R844,
										 r_PackedHalf2AtPtx2024R501); // PTX L3588
	r_PackedHalf2AtPtx3592R846 = HalfFma(r_PackedHalf2AtPtx3580R843, r_PackedHalf2AtPtx3588R845,
										 r_PackedHalf2AtPtx2017R503); // PTX L3592
	r_PackedHalf2AtPtx3596R960 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1087R1037, r_PackedHalf2AtPtx3592R846); // PTX L3596
	r_LaneIndexAtPtx3600 = uint32_t((threadIdx.x & 31u));							  // PTX L3600
	r_PackedHalf2AtPtx3603R848 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1088R1038, r_PackedHalf2AtPtx2010R495);			  // PTX L3603
	r_PackedHalf2AtPtx3607R849 = HalfMax(r_PackedHalf2AtPtx3603R848, r_PackedHalf2AtPtx2003R497); // PTX L3607
	r_PackedHalf2AtPtx3611R850 = HalfAbs(r_PackedHalf2AtPtx3607R849);							  // PTX L3611
	r_PackedHalf2AtPtx3615R851 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3611R850,
										 r_PackedHalf2AtPtx2024R501); // PTX L3615
	r_PackedHalf2AtPtx3619R852 = HalfFma(r_PackedHalf2AtPtx3607R849, r_PackedHalf2AtPtx3615R851,
										 r_PackedHalf2AtPtx2017R503); // PTX L3619
	r_PackedHalf2AtPtx3623R961 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1088R1038, r_PackedHalf2AtPtx3619R852); // PTX L3623
	r_LaneIndexAtPtx3627 = uint32_t((threadIdx.x & 31u));							  // PTX L3627
	r_PackedHalf2AtPtx3630R854 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1089R1039, r_PackedHalf2AtPtx2010R495);			  // PTX L3630
	r_PackedHalf2AtPtx3634R855 = HalfMax(r_PackedHalf2AtPtx3630R854, r_PackedHalf2AtPtx2003R497); // PTX L3634
	r_PackedHalf2AtPtx3638R856 = HalfAbs(r_PackedHalf2AtPtx3634R855);							  // PTX L3638
	r_PackedHalf2AtPtx3642R857 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3638R856,
										 r_PackedHalf2AtPtx2024R501); // PTX L3642
	r_PackedHalf2AtPtx3646R858 = HalfFma(r_PackedHalf2AtPtx3634R855, r_PackedHalf2AtPtx3642R857,
										 r_PackedHalf2AtPtx2017R503); // PTX L3646
	r_PackedHalf2AtPtx3650R962 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1089R1039, r_PackedHalf2AtPtx3646R858); // PTX L3650
	r_LaneIndexAtPtx3654 = uint32_t((threadIdx.x & 31u));							  // PTX L3654
	r_PackedHalf2AtPtx3657R860 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1090R1040, r_PackedHalf2AtPtx2010R495);			  // PTX L3657
	r_PackedHalf2AtPtx3661R861 = HalfMax(r_PackedHalf2AtPtx3657R860, r_PackedHalf2AtPtx2003R497); // PTX L3661
	r_PackedHalf2AtPtx3665R862 = HalfAbs(r_PackedHalf2AtPtx3661R861);							  // PTX L3665
	r_PackedHalf2AtPtx3669R863 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3665R862,
										 r_PackedHalf2AtPtx2024R501); // PTX L3669
	r_PackedHalf2AtPtx3673R864 = HalfFma(r_PackedHalf2AtPtx3661R861, r_PackedHalf2AtPtx3669R863,
										 r_PackedHalf2AtPtx2017R503); // PTX L3673
	r_PackedHalf2AtPtx3677R964 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1090R1040, r_PackedHalf2AtPtx3673R864); // PTX L3677
	r_LaneIndexAtPtx3681 = uint32_t((threadIdx.x & 31u));							  // PTX L3681
	r_PackedHalf2AtPtx3684R866 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1091R1041, r_PackedHalf2AtPtx2010R495);			  // PTX L3684
	r_PackedHalf2AtPtx3688R867 = HalfMax(r_PackedHalf2AtPtx3684R866, r_PackedHalf2AtPtx2003R497); // PTX L3688
	r_PackedHalf2AtPtx3692R868 = HalfAbs(r_PackedHalf2AtPtx3688R867);							  // PTX L3692
	r_PackedHalf2AtPtx3696R869 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3692R868,
										 r_PackedHalf2AtPtx2024R501); // PTX L3696
	r_PackedHalf2AtPtx3700R870 = HalfFma(r_PackedHalf2AtPtx3688R867, r_PackedHalf2AtPtx3696R869,
										 r_PackedHalf2AtPtx2017R503); // PTX L3700
	r_PackedHalf2AtPtx3704R965 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1091R1041, r_PackedHalf2AtPtx3700R870); // PTX L3704
	r_LaneIndexAtPtx3708 = uint32_t((threadIdx.x & 31u));							  // PTX L3708
	r_PackedHalf2AtPtx3711R872 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1092R1042, r_PackedHalf2AtPtx2010R495);			  // PTX L3711
	r_PackedHalf2AtPtx3715R873 = HalfMax(r_PackedHalf2AtPtx3711R872, r_PackedHalf2AtPtx2003R497); // PTX L3715
	r_PackedHalf2AtPtx3719R874 = HalfAbs(r_PackedHalf2AtPtx3715R873);							  // PTX L3719
	r_PackedHalf2AtPtx3723R875 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3719R874,
										 r_PackedHalf2AtPtx2024R501); // PTX L3723
	r_PackedHalf2AtPtx3727R876 = HalfFma(r_PackedHalf2AtPtx3715R873, r_PackedHalf2AtPtx3723R875,
										 r_PackedHalf2AtPtx2017R503); // PTX L3727
	r_PackedHalf2AtPtx3731R966 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1092R1042, r_PackedHalf2AtPtx3727R876); // PTX L3731
	r_LaneIndexAtPtx3735 = uint32_t((threadIdx.x & 31u));							  // PTX L3735
	r_PackedHalf2AtPtx3738R878 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1093R1043, r_PackedHalf2AtPtx2010R495);			  // PTX L3738
	r_PackedHalf2AtPtx3742R879 = HalfMax(r_PackedHalf2AtPtx3738R878, r_PackedHalf2AtPtx2003R497); // PTX L3742
	r_PackedHalf2AtPtx3746R880 = HalfAbs(r_PackedHalf2AtPtx3742R879);							  // PTX L3746
	r_PackedHalf2AtPtx3750R881 = HalfFma(r_PackedHalf2AtPtx2031R499, r_PackedHalf2AtPtx3746R880,
										 r_PackedHalf2AtPtx2024R501); // PTX L3750
	r_PackedHalf2AtPtx3754R882 = HalfFma(r_PackedHalf2AtPtx3742R879, r_PackedHalf2AtPtx3750R881,
										 r_PackedHalf2AtPtx2017R503); // PTX L3754
	r_PackedHalf2AtPtx3758R967 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1093R1043, r_PackedHalf2AtPtx3754R882);			  // PTX L3758
	r_PtxRegister42 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister4);						  // PTX L3761
	r_bPtxPredicate62 = int32_t(r_PtxRegister42) >= int32_t(r_PtxRegister5);					  // PTX L3762
	r_PtxRegister883 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(15));						  // PTX L3763
	r_PtxRegister884 = uint32_t(r_PtxRegister883) + uint32_t(r_PtxRegister7);					  // PTX L3764
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister884)) * int64_t(int32_t(4)));	  // PTX L3765
	g_OutputByteAddressAtPtx3766 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register132); // PTX L3766
	if (r_bPtxPredicate62)
	{
		goto L__BB38_188;
	} // PTX L3767
	r_LaneIndexAtPtx3769 = uint32_t((threadIdx.x & 31u)); // PTX L3769
	r_PtxU64Register137 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3769)) * int64_t(int32_t(16))); // PTX L3771
	g_OutputByteAddressAtPtx3772 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register137); // PTX L3772
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3772,
					make_uint4(r_PackedHalf2AtPtx2057R886, r_PackedHalf2AtPtx2084R887,
							   r_PackedHalf2AtPtx2111R888, r_PackedHalf2AtPtx2138R889)); // PTX L3774
	r_LaneIndexAtPtx3777 = uint32_t((threadIdx.x & 31u));								 // PTX L3777
	r_PtxU64Register138 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3777)) * int64_t(int32_t(16))); // PTX L3779
	g_OutputByteAddressAtPtx3780 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register138);			   // PTX L3780
	g_OutputByteAddressAtPtx3781 = uint64_t(g_OutputByteAddressAtPtx3780) + uint64_t(512); // PTX L3781
	StoreNoAllocate(g_OutputByteAddressAtPtx3781,
					make_uint4(r_PackedHalf2AtPtx2165R891, r_PackedHalf2AtPtx2192R892,
							   r_PackedHalf2AtPtx2219R893, r_PackedHalf2AtPtx2246R894)); // PTX L3783
	r_LaneIndexAtPtx3786 = uint32_t((threadIdx.x & 31u));								 // PTX L3786
	r_PtxU64Register140 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3786)) * int64_t(int32_t(16))); // PTX L3788
	g_OutputByteAddressAtPtx3789 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register140);				// PTX L3789
	g_OutputByteAddressAtPtx3790 = uint64_t(g_OutputByteAddressAtPtx3789) + uint64_t(1024); // PTX L3790
	StoreNoAllocate(g_OutputByteAddressAtPtx3790,
					make_uint4(r_PackedHalf2AtPtx2273R896, r_PackedHalf2AtPtx2300R897,
							   r_PackedHalf2AtPtx2327R898, r_PackedHalf2AtPtx2354R899)); // PTX L3792
	r_LaneIndexAtPtx3795 = uint32_t((threadIdx.x & 31u));								 // PTX L3795
	r_PtxU64Register142 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3795)) * int64_t(int32_t(16))); // PTX L3797
	g_OutputByteAddressAtPtx3798 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register142);				// PTX L3798
	g_OutputByteAddressAtPtx3799 = uint64_t(g_OutputByteAddressAtPtx3798) + uint64_t(1536); // PTX L3799
	StoreNoAllocate(g_OutputByteAddressAtPtx3799,
					make_uint4(r_PackedHalf2AtPtx2381R901, r_PackedHalf2AtPtx2408R902,
							   r_PackedHalf2AtPtx2435R903, r_PackedHalf2AtPtx2462R904));	  // PTX L3801
L__BB38_188:																				  // PTX L3803
	r_PtxRegister905 = uint32_t(r_PtxRegister42) + uint32_t(1);								  // PTX L3804
	r_bPtxPredicate63 = int32_t(r_PtxRegister905) >= int32_t(r_PtxRegister5);				  // PTX L3805
	g_OutputByteAddressAtPtx3806 = uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(131072); // PTX L3806
	if (r_bPtxPredicate63)
	{
		goto L__BB38_190;
	} // PTX L3807
	r_LaneIndexAtPtx3809 = uint32_t((threadIdx.x & 31u)); // PTX L3809
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3809)) * int64_t(int32_t(16))); // PTX L3811
	g_OutputByteAddressAtPtx3812 =
		uint64_t(g_OutputByteAddressAtPtx3806) + uint64_t(r_PtxU64Register148); // PTX L3812
	StoreNoAllocate(g_OutputByteAddressAtPtx3812,
					make_uint4(r_PackedHalf2AtPtx2489R907, r_PackedHalf2AtPtx2516R908,
							   r_PackedHalf2AtPtx2543R909, r_PackedHalf2AtPtx2570R910)); // PTX L3814
	r_LaneIndexAtPtx3817 = uint32_t((threadIdx.x & 31u));								 // PTX L3817
	r_PtxU64Register149 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3817)) * int64_t(int32_t(16))); // PTX L3819
	g_OutputByteAddressAtPtx3820 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register149);				  // PTX L3820
	g_OutputByteAddressAtPtx3821 = uint64_t(g_OutputByteAddressAtPtx3820) + uint64_t(131584); // PTX L3821
	StoreNoAllocate(g_OutputByteAddressAtPtx3821,
					make_uint4(r_PackedHalf2AtPtx2597R912, r_PackedHalf2AtPtx2624R913,
							   r_PackedHalf2AtPtx2651R914, r_PackedHalf2AtPtx2678R915)); // PTX L3823
	r_LaneIndexAtPtx3826 = uint32_t((threadIdx.x & 31u));								 // PTX L3826
	r_PtxU64Register151 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3826)) * int64_t(int32_t(16))); // PTX L3828
	g_OutputByteAddressAtPtx3829 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register151);				  // PTX L3829
	g_OutputByteAddressAtPtx3830 = uint64_t(g_OutputByteAddressAtPtx3829) + uint64_t(132096); // PTX L3830
	StoreNoAllocate(g_OutputByteAddressAtPtx3830,
					make_uint4(r_PackedHalf2AtPtx2705R917, r_PackedHalf2AtPtx2732R918,
							   r_PackedHalf2AtPtx2759R919, r_PackedHalf2AtPtx2786R920)); // PTX L3832
	r_LaneIndexAtPtx3835 = uint32_t((threadIdx.x & 31u));								 // PTX L3835
	r_PtxU64Register153 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3835)) * int64_t(int32_t(16))); // PTX L3837
	g_OutputByteAddressAtPtx3838 =
		uint64_t(g_OutputByteAddressAtPtx3766) + uint64_t(r_PtxU64Register153);				  // PTX L3838
	g_OutputByteAddressAtPtx3839 = uint64_t(g_OutputByteAddressAtPtx3838) + uint64_t(132608); // PTX L3839
	StoreNoAllocate(g_OutputByteAddressAtPtx3839,
					make_uint4(r_PackedHalf2AtPtx2813R922, r_PackedHalf2AtPtx2840R923,
							   r_PackedHalf2AtPtx2867R924, r_PackedHalf2AtPtx2894R925));	  // PTX L3841
L__BB38_190:																				  // PTX L3843
	r_PtxRegister926 = uint32_t(r_PtxRegister42) + uint32_t(2);								  // PTX L3844
	r_bPtxPredicate64 = int32_t(r_PtxRegister926) >= int32_t(r_PtxRegister5);				  // PTX L3845
	g_OutputByteAddressAtPtx3846 = uint64_t(g_OutputByteAddressAtPtx3806) + uint64_t(131072); // PTX L3846
	if (r_bPtxPredicate64)
	{
		goto L__BB38_192;
	} // PTX L3847
	r_LaneIndexAtPtx3849 = uint32_t((threadIdx.x & 31u)); // PTX L3849
	r_PtxU64Register159 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3849)) * int64_t(int32_t(16))); // PTX L3851
	g_OutputByteAddressAtPtx3852 =
		uint64_t(g_OutputByteAddressAtPtx3846) + uint64_t(r_PtxU64Register159); // PTX L3852
	StoreNoAllocate(g_OutputByteAddressAtPtx3852,
					make_uint4(r_PackedHalf2AtPtx2921R928, r_PackedHalf2AtPtx2948R929,
							   r_PackedHalf2AtPtx2975R930, r_PackedHalf2AtPtx3002R931)); // PTX L3854
	r_LaneIndexAtPtx3857 = uint32_t((threadIdx.x & 31u));								 // PTX L3857
	r_PtxU64Register160 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3857)) * int64_t(int32_t(16))); // PTX L3859
	g_OutputByteAddressAtPtx3860 =
		uint64_t(g_OutputByteAddressAtPtx3806) + uint64_t(r_PtxU64Register160);				  // PTX L3860
	g_OutputByteAddressAtPtx3861 = uint64_t(g_OutputByteAddressAtPtx3860) + uint64_t(131584); // PTX L3861
	StoreNoAllocate(g_OutputByteAddressAtPtx3861,
					make_uint4(r_PackedHalf2AtPtx3029R933, r_PackedHalf2AtPtx3056R934,
							   r_PackedHalf2AtPtx3083R935, r_PackedHalf2AtPtx3110R936)); // PTX L3863
	r_LaneIndexAtPtx3866 = uint32_t((threadIdx.x & 31u));								 // PTX L3866
	r_PtxU64Register162 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3866)) * int64_t(int32_t(16))); // PTX L3868
	g_OutputByteAddressAtPtx3869 =
		uint64_t(g_OutputByteAddressAtPtx3806) + uint64_t(r_PtxU64Register162);				  // PTX L3869
	g_OutputByteAddressAtPtx3870 = uint64_t(g_OutputByteAddressAtPtx3869) + uint64_t(132096); // PTX L3870
	StoreNoAllocate(g_OutputByteAddressAtPtx3870,
					make_uint4(r_PackedHalf2AtPtx3137R938, r_PackedHalf2AtPtx3164R939,
							   r_PackedHalf2AtPtx3191R940, r_PackedHalf2AtPtx3218R941)); // PTX L3872
	r_LaneIndexAtPtx3875 = uint32_t((threadIdx.x & 31u));								 // PTX L3875
	r_PtxU64Register164 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3875)) * int64_t(int32_t(16))); // PTX L3877
	g_OutputByteAddressAtPtx3878 =
		uint64_t(g_OutputByteAddressAtPtx3806) + uint64_t(r_PtxU64Register164);				  // PTX L3878
	g_OutputByteAddressAtPtx3879 = uint64_t(g_OutputByteAddressAtPtx3878) + uint64_t(132608); // PTX L3879
	StoreNoAllocate(g_OutputByteAddressAtPtx3879,
					make_uint4(r_PackedHalf2AtPtx3245R943, r_PackedHalf2AtPtx3272R944,
							   r_PackedHalf2AtPtx3299R945, r_PackedHalf2AtPtx3326R946)); // PTX L3881
L__BB38_192:																			 // PTX L3883
	r_PtxRegister947 = uint32_t(r_PtxRegister42) + uint32_t(3);							 // PTX L3884
	r_bPtxPredicate65 = int32_t(r_PtxRegister947) >= int32_t(r_PtxRegister5);			 // PTX L3885
	if (r_bPtxPredicate65)
	{
		goto L__BB38_194;
	} // PTX L3886
	r_LaneIndexAtPtx3888 = uint32_t((threadIdx.x & 31u)); // PTX L3888
	r_PtxU64Register170 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3888)) * int64_t(int32_t(16))); // PTX L3890
	g_OutputByteAddressAtPtx3891 =
		uint64_t(g_OutputByteAddressAtPtx3846) + uint64_t(r_PtxU64Register170);				  // PTX L3891
	g_OutputByteAddressAtPtx3892 = uint64_t(g_OutputByteAddressAtPtx3891) + uint64_t(131072); // PTX L3892
	StoreNoAllocate(g_OutputByteAddressAtPtx3892,
					make_uint4(r_PackedHalf2AtPtx3353R949, r_PackedHalf2AtPtx3380R950,
							   r_PackedHalf2AtPtx3407R951, r_PackedHalf2AtPtx3434R952)); // PTX L3894
	r_LaneIndexAtPtx3897 = uint32_t((threadIdx.x & 31u));								 // PTX L3897
	r_PtxU64Register172 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3897)) * int64_t(int32_t(16))); // PTX L3899
	g_OutputByteAddressAtPtx3900 =
		uint64_t(g_OutputByteAddressAtPtx3846) + uint64_t(r_PtxU64Register172);				  // PTX L3900
	g_OutputByteAddressAtPtx3901 = uint64_t(g_OutputByteAddressAtPtx3900) + uint64_t(131584); // PTX L3901
	StoreNoAllocate(g_OutputByteAddressAtPtx3901,
					make_uint4(r_PackedHalf2AtPtx3461R954, r_PackedHalf2AtPtx3488R955,
							   r_PackedHalf2AtPtx3515R956, r_PackedHalf2AtPtx3542R957)); // PTX L3903
	r_LaneIndexAtPtx3906 = uint32_t((threadIdx.x & 31u));								 // PTX L3906
	r_PtxU64Register174 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3906)) * int64_t(int32_t(16))); // PTX L3908
	g_OutputByteAddressAtPtx3909 =
		uint64_t(g_OutputByteAddressAtPtx3846) + uint64_t(r_PtxU64Register174);				  // PTX L3909
	g_OutputByteAddressAtPtx3910 = uint64_t(g_OutputByteAddressAtPtx3909) + uint64_t(132096); // PTX L3910
	StoreNoAllocate(g_OutputByteAddressAtPtx3910,
					make_uint4(r_PackedHalf2AtPtx3569R959, r_PackedHalf2AtPtx3596R960,
							   r_PackedHalf2AtPtx3623R961, r_PackedHalf2AtPtx3650R962)); // PTX L3912
	r_LaneIndexAtPtx3915 = uint32_t((threadIdx.x & 31u));								 // PTX L3915
	r_PtxU64Register176 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3915)) * int64_t(int32_t(16))); // PTX L3917
	g_OutputByteAddressAtPtx3918 =
		uint64_t(g_OutputByteAddressAtPtx3846) + uint64_t(r_PtxU64Register176);				  // PTX L3918
	g_OutputByteAddressAtPtx3919 = uint64_t(g_OutputByteAddressAtPtx3918) + uint64_t(132608); // PTX L3919
	StoreNoAllocate(g_OutputByteAddressAtPtx3919,
					make_uint4(r_PackedHalf2AtPtx3677R964, r_PackedHalf2AtPtx3704R965,
							   r_PackedHalf2AtPtx3731R966, r_PackedHalf2AtPtx3758R967)); // PTX L3921
L__BB38_194:																			 // PTX L3923
	return;																				 // PTX L3924
#endif
}
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16
