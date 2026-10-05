// Readable equivalent of cc_vit_1d_ffn_contract; not the historical C++ file.
#pragma once
#include "global_ffn_contract_c1024_abi_fp16.cuh"

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
{
__global__ __maxnreg__(168) void global_ffn_contract_c1024_fp16(Parameters r_Parameters)
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
		r_bPtxPredicate143;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint16_t r_PtxU16Register13, r_PtxU16Register14, r_PtxU16Register15, r_PtxU16Register16,
		r_PtxU16Register17, r_PtxU16Register18, r_PtxU16Register19, r_PtxU16Register20, r_PtxU16Register21,
		r_PtxU16Register22, r_PtxU16Register23, r_PtxU16Register24;
	uint16_t r_PtxU16Register25, r_PtxU16Register26, r_PtxU16Register27;
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
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53,
		r_PtxRegister54, r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59,
		r_PtxRegister60;
	uint32_t r_BatchBits, r_TokensBits, r_CtaX, r_PtxRegister64, r_PtxRegister65, r_PtxRegister66,
		r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71, r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_ThreadX, r_PtxRegister77, r_PtxRegister78,
		r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_BlockSizeX, r_BlockSizeY,
		r_Float32BitsAtPtx60R84;
	uint32_t r_LaneIndexAtPtx76, r_LaneIndexAtPtx85, r_LaneIndexAtPtx95, r_LaneIndexAtPtx105,
		r_LaneIndexAtPtx114, r_LaneIndexAtPtx123, r_LaneIndexAtPtx132, r_LaneIndexAtPtx141, r_PtxRegister93,
		r_PtxRegister94, r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_LaneIndexAtPtx247, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_LaneIndexAtPtx289, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_LaneIndexAtPtx389, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_LaneIndexAtPtx437, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_LaneIndexAtPtx538, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_LaneIndexAtPtx582,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_LaneIndexAtPtx677, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_LaneIndexAtPtx721, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_LaneIndexAtPtx818, r_PtxRegister245,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_LaneIndexAtPtx862, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_LaneIndexAtPtx957;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PtxRegister286,
		r_LaneIndexAtPtx1001, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PtxRegister301, r_PtxRegister302, r_LaneIndexAtPtx1111, r_PtxRegister304, r_PtxRegister305,
		r_LaneIndexAtPtx1135, r_PtxRegister307, r_PtxRegister308, r_LaneIndexAtPtx1159, r_PtxRegister310,
		r_PtxRegister311, r_LaneIndexAtPtx1183;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_LaneIndexAtPtx1208, r_PtxRegister316, r_PtxRegister317,
		r_LaneIndexAtPtx1232, r_PtxRegister319, r_PtxRegister320, r_LaneIndexAtPtx1256, r_PtxRegister322,
		r_PtxRegister323, r_LaneIndexAtPtx1280;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_LaneIndexAtPtx1305, r_PtxRegister328, r_PtxRegister329,
		r_LaneIndexAtPtx1329, r_PtxRegister331, r_PtxRegister332, r_LaneIndexAtPtx1353, r_PtxRegister334,
		r_PtxRegister335, r_LaneIndexAtPtx1377;
	uint32_t r_PtxRegister337, r_PtxRegister338, r_LaneIndexAtPtx1402, r_PtxRegister340, r_PtxRegister341,
		r_LaneIndexAtPtx1426, r_PtxRegister343, r_PtxRegister344, r_LaneIndexAtPtx1450, r_PtxRegister346,
		r_PtxRegister347, r_LaneIndexAtPtx1474;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_LaneIndexAtPtx1489, r_LaneIndexAtPtx1503,
		r_LaneIndexAtPtx1517, r_LaneIndexAtPtx1531, r_LaneIndexAtPtx1545, r_LaneIndexAtPtx1560,
		r_LaneIndexAtPtx1574, r_LaneIndexAtPtx1589, r_LaneIndexAtPtx1603, r_LaneIndexAtPtx1618;
	uint32_t r_LaneIndexAtPtx1632, r_LaneIndexAtPtx1647, r_LaneIndexAtPtx1661, r_LaneIndexAtPtx1676,
		r_LaneIndexAtPtx1690, r_LaneIndexAtPtx1705, r_LaneIndexAtPtx1719, r_LaneIndexAtPtx1733,
		r_LaneIndexAtPtx1747, r_LaneIndexAtPtx1761, r_LaneIndexAtPtx1775, r_LaneIndexAtPtx1789;
	uint32_t r_LaneIndexAtPtx1803, r_LaneIndexAtPtx1817, r_LaneIndexAtPtx1831, r_LaneIndexAtPtx1845,
		r_LaneIndexAtPtx1859, r_LaneIndexAtPtx1873, r_LaneIndexAtPtx1887, r_LaneIndexAtPtx1901,
		r_LaneIndexAtPtx1915, r_LaneIndexAtPtx1929, r_LaneIndexAtPtx1943, r_LaneIndexAtPtx1957;
	uint32_t r_LaneIndexAtPtx1971, r_LaneIndexAtPtx1985, r_LaneIndexAtPtx1999, r_LaneIndexAtPtx2013,
		r_LaneIndexAtPtx2027, r_LaneIndexAtPtx2041, r_LaneIndexAtPtx2055, r_LaneIndexAtPtx2069,
		r_LaneIndexAtPtx2083, r_LaneIndexAtPtx2097, r_LaneIndexAtPtx2111, r_LaneIndexAtPtx2125;
	uint32_t r_LaneIndexAtPtx2139, r_LaneIndexAtPtx2153, r_LaneIndexAtPtx2167, r_LaneIndexAtPtx2181,
		r_LaneIndexAtPtx2195, r_LaneIndexAtPtx2209, r_LaneIndexAtPtx2223, r_LaneIndexAtPtx2237,
		r_LaneIndexAtPtx2251, r_LaneIndexAtPtx2265, r_LaneIndexAtPtx2279, r_LaneIndexAtPtx2293;
	uint32_t r_LaneIndexAtPtx2307, r_LaneIndexAtPtx2321, r_LaneIndexAtPtx2335, r_LaneIndexAtPtx2349,
		r_LaneIndexAtPtx2363, r_LaneIndexAtPtx2377, r_LaneIndexAtPtx2391, r_PtxRegister416,
		r_LaneIndexAtPtx2398, r_PtxRegister418, r_LaneIndexAtPtx2405, r_PtxRegister420;
	uint32_t r_LaneIndexAtPtx2412, r_PtxRegister422, r_LaneIndexAtPtx2419, r_PtxRegister424,
		r_LaneIndexAtPtx2426, r_PtxRegister426, r_LaneIndexAtPtx2433, r_PtxRegister428, r_LaneIndexAtPtx2440,
		r_PtxRegister430, r_LaneIndexAtPtx2447, r_PtxRegister432;
	uint32_t r_LaneIndexAtPtx2454, r_PtxRegister434, r_LaneIndexAtPtx2461, r_PtxRegister436,
		r_LaneIndexAtPtx2468, r_PtxRegister438, r_LaneIndexAtPtx2475, r_PtxRegister440, r_LaneIndexAtPtx2482,
		r_PtxRegister442, r_LaneIndexAtPtx2489, r_PtxRegister444;
	uint32_t r_LaneIndexAtPtx2496, r_PtxRegister446, r_LaneIndexAtPtx2503, r_PtxRegister448,
		r_LaneIndexAtPtx2510, r_PtxRegister450, r_LaneIndexAtPtx2517, r_PtxRegister452, r_LaneIndexAtPtx2524,
		r_PtxRegister454, r_LaneIndexAtPtx2531, r_PtxRegister456;
	uint32_t r_LaneIndexAtPtx2538, r_PtxRegister458, r_LaneIndexAtPtx2545, r_PtxRegister460,
		r_LaneIndexAtPtx2552, r_PtxRegister462, r_LaneIndexAtPtx2559, r_PtxRegister464, r_LaneIndexAtPtx2566,
		r_PtxRegister466, r_LaneIndexAtPtx2573, r_PtxRegister468;
	uint32_t r_LaneIndexAtPtx2580, r_PtxRegister470, r_LaneIndexAtPtx2587, r_PtxRegister472,
		r_LaneIndexAtPtx2594, r_PtxRegister474, r_LaneIndexAtPtx2601, r_PtxRegister476, r_LaneIndexAtPtx2608,
		r_PtxRegister478, r_LaneIndexAtPtx2615, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx2622, r_PtxRegister482, r_LaneIndexAtPtx2629, r_PtxRegister484,
		r_LaneIndexAtPtx2636, r_PtxRegister486, r_LaneIndexAtPtx2643, r_PtxRegister488, r_LaneIndexAtPtx2650,
		r_PtxRegister490, r_LaneIndexAtPtx2657, r_PtxRegister492;
	uint32_t r_LaneIndexAtPtx2664, r_PtxRegister494, r_LaneIndexAtPtx2671, r_PtxRegister496,
		r_LaneIndexAtPtx2678, r_PtxRegister498, r_LaneIndexAtPtx2685, r_PtxRegister500, r_LaneIndexAtPtx2692,
		r_PtxRegister502, r_LaneIndexAtPtx2699, r_PtxRegister504;
	uint32_t r_LaneIndexAtPtx2706, r_PtxRegister506, r_LaneIndexAtPtx2713, r_PtxRegister508,
		r_LaneIndexAtPtx2720, r_PtxRegister510, r_LaneIndexAtPtx2727, r_PtxRegister512, r_LaneIndexAtPtx2734,
		r_PtxRegister514, r_LaneIndexAtPtx2741, r_PtxRegister516;
	uint32_t r_LaneIndexAtPtx2748, r_PtxRegister518, r_LaneIndexAtPtx2755, r_PtxRegister520,
		r_LaneIndexAtPtx2762, r_PtxRegister522, r_LaneIndexAtPtx2769, r_PtxRegister524, r_LaneIndexAtPtx2776,
		r_PtxRegister526, r_LaneIndexAtPtx2783, r_PtxRegister528;
	uint32_t r_LaneIndexAtPtx2790, r_PtxRegister530, r_LaneIndexAtPtx2797, r_PtxRegister532,
		r_LaneIndexAtPtx2804, r_PtxRegister534, r_LaneIndexAtPtx2811, r_PtxRegister536, r_LaneIndexAtPtx2818,
		r_PtxRegister538, r_LaneIndexAtPtx2825, r_PtxRegister540;
	uint32_t r_LaneIndexAtPtx2832, r_PtxRegister542, r_PtxRegister543, r_PtxRegister544, r_PtxRegister545,
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
		r_PtxRegister1067, r_LaneIndexAtPtx2863;
	uint32_t r_PtxRegister1069, r_LaneIndexAtPtx2872, r_PtxRegister1071, r_LaneIndexAtPtx2882,
		r_PtxRegister1073, r_LaneIndexAtPtx2891, r_PtxRegister1075, r_LaneIndexAtPtx2900, r_PtxRegister1077,
		r_LaneIndexAtPtx2909, r_PtxRegister1079, r_LaneIndexAtPtx2918;
	uint32_t r_PtxRegister1081, r_LaneIndexAtPtx2927, r_PtxRegister1083, r_MmaAHalf2WordAtPtx2869R1084,
		r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086, r_MmaAHalf2WordAtPtx2869R1087,
		r_MmaAHalf2WordAtPtx2879R1088, r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090,
		r_MmaAHalf2WordAtPtx2879R1091, r_MmaAccumulatorHalf2WordAtPtx2936R1092;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2936R1093, r_MmaAccumulatorHalf2WordAtPtx2943R1094,
		r_MmaAccumulatorHalf2WordAtPtx2943R1095, r_MmaAccumulatorHalf2WordAtPtx2964R1096,
		r_MmaAccumulatorHalf2WordAtPtx2964R1097, r_MmaAccumulatorHalf2WordAtPtx2971R1098,
		r_MmaAccumulatorHalf2WordAtPtx2971R1099, r_MmaAccumulatorHalf2WordAtPtx2992R1100,
		r_MmaAccumulatorHalf2WordAtPtx2992R1101, r_MmaAccumulatorHalf2WordAtPtx2999R1102,
		r_MmaAccumulatorHalf2WordAtPtx2999R1103, r_MmaAccumulatorHalf2WordAtPtx3020R1104;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3020R1105, r_MmaAccumulatorHalf2WordAtPtx3027R1106,
		r_MmaAccumulatorHalf2WordAtPtx3027R1107, r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109,
		r_MmaAHalf2WordAtPtx2888R1110, r_MmaAHalf2WordAtPtx2888R1111, r_MmaAHalf2WordAtPtx2897R1112,
		r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
		r_MmaAccumulatorHalf2WordAtPtx3048R1116;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3048R1117, r_MmaAccumulatorHalf2WordAtPtx3055R1118,
		r_MmaAccumulatorHalf2WordAtPtx3055R1119, r_MmaAccumulatorHalf2WordAtPtx3076R1120,
		r_MmaAccumulatorHalf2WordAtPtx3076R1121, r_MmaAccumulatorHalf2WordAtPtx3083R1122,
		r_MmaAccumulatorHalf2WordAtPtx3083R1123, r_MmaAccumulatorHalf2WordAtPtx3104R1124,
		r_MmaAccumulatorHalf2WordAtPtx3104R1125, r_MmaAccumulatorHalf2WordAtPtx3111R1126,
		r_MmaAccumulatorHalf2WordAtPtx3111R1127, r_MmaAccumulatorHalf2WordAtPtx3132R1128;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3132R1129, r_MmaAccumulatorHalf2WordAtPtx3139R1130,
		r_MmaAccumulatorHalf2WordAtPtx3139R1131, r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133,
		r_MmaAHalf2WordAtPtx2906R1134, r_MmaAHalf2WordAtPtx2906R1135, r_MmaAHalf2WordAtPtx2915R1136,
		r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
		r_MmaAccumulatorHalf2WordAtPtx3160R1140;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3160R1141, r_MmaAccumulatorHalf2WordAtPtx3167R1142,
		r_MmaAccumulatorHalf2WordAtPtx3167R1143, r_MmaAccumulatorHalf2WordAtPtx3188R1144,
		r_MmaAccumulatorHalf2WordAtPtx3188R1145, r_MmaAccumulatorHalf2WordAtPtx3195R1146,
		r_MmaAccumulatorHalf2WordAtPtx3195R1147, r_MmaAccumulatorHalf2WordAtPtx3216R1148,
		r_MmaAccumulatorHalf2WordAtPtx3216R1149, r_MmaAccumulatorHalf2WordAtPtx3223R1150,
		r_MmaAccumulatorHalf2WordAtPtx3223R1151, r_MmaAccumulatorHalf2WordAtPtx3244R1152;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3244R1153, r_MmaAccumulatorHalf2WordAtPtx3251R1154,
		r_MmaAccumulatorHalf2WordAtPtx3251R1155, r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157,
		r_MmaAHalf2WordAtPtx2924R1158, r_MmaAHalf2WordAtPtx2924R1159, r_MmaAHalf2WordAtPtx2933R1160,
		r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
		r_MmaAccumulatorHalf2WordAtPtx3272R1164;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3272R1165, r_MmaAccumulatorHalf2WordAtPtx3279R1166,
		r_MmaAccumulatorHalf2WordAtPtx3279R1167, r_MmaAccumulatorHalf2WordAtPtx3300R1168,
		r_MmaAccumulatorHalf2WordAtPtx3300R1169, r_MmaAccumulatorHalf2WordAtPtx3307R1170,
		r_MmaAccumulatorHalf2WordAtPtx3307R1171, r_MmaAccumulatorHalf2WordAtPtx3328R1172,
		r_MmaAccumulatorHalf2WordAtPtx3328R1173, r_MmaAccumulatorHalf2WordAtPtx3335R1174,
		r_MmaAccumulatorHalf2WordAtPtx3335R1175, r_MmaAccumulatorHalf2WordAtPtx3356R1176;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3356R1177, r_MmaAccumulatorHalf2WordAtPtx3363R1178,
		r_MmaAccumulatorHalf2WordAtPtx3363R1179, r_PtxRegister1180, r_PtxRegister1181, r_PtxRegister1182,
		r_PtxRegister1183, r_PtxRegister1184, r_PtxRegister1185, r_PtxRegister1186, r_PtxRegister1187,
		r_PtxRegister1188;
	uint32_t r_PtxRegister1189, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PtxRegister1194, r_PtxRegister1195, r_PtxRegister1196, r_PtxRegister1197, r_PtxRegister1198,
		r_PtxRegister1199, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_LaneIndexAtPtx3392, r_LaneIndexAtPtx3400, r_LaneIndexAtPtx3409,
		r_LaneIndexAtPtx3418, r_LaneIndexAtPtx3427, r_LaneIndexAtPtx3436, r_LaneIndexAtPtx3445,
		r_LaneIndexAtPtx3454, r_PtxRegister1210, r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_PtxRegister1218, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_LaneIndexAtPtx3580, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_LaneIndexAtPtx3620, r_PtxRegister1240, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_PtxRegister1244, r_PtxRegister1245, r_PtxRegister1246,
		r_PtxRegister1247, r_PtxRegister1248;
	uint32_t r_PtxRegister1249, r_PtxRegister1250, r_PtxRegister1251, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_LaneIndexAtPtx3706, r_PtxRegister1258,
		r_PtxRegister1259, r_PtxRegister1260;
	uint32_t r_PtxRegister1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264, r_LaneIndexAtPtx3746,
		r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269, r_PtxRegister1270,
		r_PtxRegister1271, r_PtxRegister1272;
	uint32_t r_PtxRegister1273, r_ThreadZAtPtx3763, r_PtxRegister1275, r_PtxRegister1276,
		r_LaneIndexAtPtx4168, r_PtxRegister1278, r_PtxRegister1279, r_LaneIndexAtPtx4192, r_PtxRegister1281,
		r_PtxRegister1282, r_LaneIndexAtPtx4216, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_LaneIndexAtPtx4240, r_PtxRegister1287, r_PtxRegister1288,
		r_LaneIndexAtPtx4265, r_PtxRegister1290, r_PtxRegister1291, r_LaneIndexAtPtx4289, r_PtxRegister1293,
		r_PtxRegister1294, r_LaneIndexAtPtx4313, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_LaneIndexAtPtx4337, r_PtxRegister1299, r_PtxRegister1300,
		r_LaneIndexAtPtx4362, r_PtxRegister1302, r_PtxRegister1303, r_LaneIndexAtPtx4386, r_PtxRegister1305,
		r_PtxRegister1306, r_LaneIndexAtPtx4410, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_LaneIndexAtPtx4434, r_PtxRegister1311, r_PtxRegister1312,
		r_LaneIndexAtPtx4459, r_PtxRegister1314, r_PtxRegister1315, r_LaneIndexAtPtx4483, r_PtxRegister1317,
		r_PtxRegister1318, r_LaneIndexAtPtx4507, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_LaneIndexAtPtx4529, r_PtxRegister1323, r_PtxRegister1324,
		r_LaneIndexAtPtx4538, r_LaneIndexAtPtx4545, r_LaneIndexAtPtx4552, r_LaneIndexAtPtx4559,
		r_LaneIndexAtPtx4566, r_LaneIndexAtPtx4573, r_LaneIndexAtPtx4580, r_LaneIndexAtPtx4587;
	uint32_t r_LaneIndexAtPtx4594, r_LaneIndexAtPtx4601, r_LaneIndexAtPtx4608, r_LaneIndexAtPtx4615,
		r_LaneIndexAtPtx4622, r_LaneIndexAtPtx4629, r_LaneIndexAtPtx4636, r_LaneIndexAtPtx4643,
		r_LaneIndexAtPtx4650, r_LaneIndexAtPtx4657, r_LaneIndexAtPtx4664, r_LaneIndexAtPtx4671;
	uint32_t r_LaneIndexAtPtx4678, r_LaneIndexAtPtx4685, r_LaneIndexAtPtx4692, r_LaneIndexAtPtx4699,
		r_LaneIndexAtPtx4706, r_LaneIndexAtPtx4713, r_LaneIndexAtPtx4720, r_LaneIndexAtPtx4727,
		r_LaneIndexAtPtx4734, r_LaneIndexAtPtx4741, r_LaneIndexAtPtx4748, r_LaneIndexAtPtx4755;
	uint32_t r_LaneIndexAtPtx4762, r_LaneIndexAtPtx4769, r_LaneIndexAtPtx4776, r_LaneIndexAtPtx4783,
		r_LaneIndexAtPtx4790, r_LaneIndexAtPtx4797, r_LaneIndexAtPtx4804, r_LaneIndexAtPtx4811,
		r_LaneIndexAtPtx4818, r_LaneIndexAtPtx4825, r_LaneIndexAtPtx4832, r_LaneIndexAtPtx4839;
	uint32_t r_LaneIndexAtPtx4846, r_LaneIndexAtPtx4853, r_LaneIndexAtPtx4860, r_LaneIndexAtPtx4867,
		r_LaneIndexAtPtx4874, r_LaneIndexAtPtx4881, r_LaneIndexAtPtx4888, r_LaneIndexAtPtx4895,
		r_LaneIndexAtPtx4902, r_LaneIndexAtPtx4909, r_LaneIndexAtPtx4916, r_LaneIndexAtPtx4923;
	uint32_t r_LaneIndexAtPtx4930, r_LaneIndexAtPtx4937, r_LaneIndexAtPtx4944, r_LaneIndexAtPtx4951,
		r_LaneIndexAtPtx4958, r_LaneIndexAtPtx4965, r_LaneIndexAtPtx4972, r_LaneIndexAtPtx4979,
		r_PtxRegister1389, r_PtxRegister1390, r_LaneIndexAtPtx4992, r_PackedHalf2AtPtx4541R1392;
	uint32_t r_PackedHalf2AtPtx4548R1393, r_PackedHalf2AtPtx4555R1394, r_PackedHalf2AtPtx4562R1395,
		r_LaneIndexAtPtx5000, r_PackedHalf2AtPtx4569R1397, r_PackedHalf2AtPtx4576R1398,
		r_PackedHalf2AtPtx4583R1399, r_PackedHalf2AtPtx4590R1400, r_LaneIndexAtPtx5009,
		r_PackedHalf2AtPtx4597R1402, r_PackedHalf2AtPtx4604R1403, r_PackedHalf2AtPtx4611R1404;
	uint32_t r_PackedHalf2AtPtx4618R1405, r_LaneIndexAtPtx5018, r_PackedHalf2AtPtx4625R1407,
		r_PackedHalf2AtPtx4632R1408, r_PackedHalf2AtPtx4639R1409, r_PackedHalf2AtPtx4646R1410,
		r_LaneIndexAtPtx5031, r_PackedHalf2AtPtx4653R1412, r_PackedHalf2AtPtx4660R1413,
		r_PackedHalf2AtPtx4667R1414, r_PackedHalf2AtPtx4674R1415, r_LaneIndexAtPtx5039;
	uint32_t r_PackedHalf2AtPtx4681R1417, r_PackedHalf2AtPtx4688R1418, r_PackedHalf2AtPtx4695R1419,
		r_PackedHalf2AtPtx4702R1420, r_LaneIndexAtPtx5048, r_PackedHalf2AtPtx4709R1422,
		r_PackedHalf2AtPtx4716R1423, r_PackedHalf2AtPtx4723R1424, r_PackedHalf2AtPtx4730R1425,
		r_LaneIndexAtPtx5057, r_PackedHalf2AtPtx4737R1427, r_PackedHalf2AtPtx4744R1428;
	uint32_t r_PackedHalf2AtPtx4751R1429, r_PackedHalf2AtPtx4758R1430, r_LaneIndexAtPtx5070,
		r_PackedHalf2AtPtx4765R1432, r_PackedHalf2AtPtx4772R1433, r_PackedHalf2AtPtx4779R1434,
		r_PackedHalf2AtPtx4786R1435, r_LaneIndexAtPtx5078, r_PackedHalf2AtPtx4793R1437,
		r_PackedHalf2AtPtx4800R1438, r_PackedHalf2AtPtx4807R1439, r_PackedHalf2AtPtx4814R1440;
	uint32_t r_LaneIndexAtPtx5087, r_PackedHalf2AtPtx4821R1442, r_PackedHalf2AtPtx4828R1443,
		r_PackedHalf2AtPtx4835R1444, r_PackedHalf2AtPtx4842R1445, r_LaneIndexAtPtx5096,
		r_PackedHalf2AtPtx4849R1447, r_PackedHalf2AtPtx4856R1448, r_PackedHalf2AtPtx4863R1449,
		r_PackedHalf2AtPtx4870R1450, r_LaneIndexAtPtx5108, r_PackedHalf2AtPtx4877R1452;
	uint32_t r_PackedHalf2AtPtx4884R1453, r_PackedHalf2AtPtx4891R1454, r_PackedHalf2AtPtx4898R1455,
		r_LaneIndexAtPtx5117, r_PackedHalf2AtPtx4905R1457, r_PackedHalf2AtPtx4912R1458,
		r_PackedHalf2AtPtx4919R1459, r_PackedHalf2AtPtx4926R1460, r_LaneIndexAtPtx5126,
		r_PackedHalf2AtPtx4933R1462, r_PackedHalf2AtPtx4940R1463, r_PackedHalf2AtPtx4947R1464;
	uint32_t r_PackedHalf2AtPtx4954R1465, r_LaneIndexAtPtx5135, r_PackedHalf2AtPtx4961R1467,
		r_PackedHalf2AtPtx4968R1468, r_PackedHalf2AtPtx4975R1469, r_PackedHalf2AtPtx4982R1470,
		r_LaneIndexAtPtx3781, r_LaneIndexAtPtx3793, r_LaneIndexAtPtx3805, r_LaneIndexAtPtx3817,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PtxRegister1479, r_LaneIndexAtPtx3834,
		r_LaneIndexAtPtx3846, r_LaneIndexAtPtx3858, r_LaneIndexAtPtx3870, r_PtxRegister1484,
		r_PtxRegister1485, r_PtxRegister1486, r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_LaneIndexAtPtx3887, r_LaneIndexAtPtx3899, r_LaneIndexAtPtx3911, r_LaneIndexAtPtx3923,
		r_PtxRegister1493, r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497,
		r_LaneIndexAtPtx3940, r_LaneIndexAtPtx3952, r_LaneIndexAtPtx3964;
	uint32_t r_LaneIndexAtPtx3976, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_PtxRegister1505,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_LaneIndexAtPtx3995,
		r_LaneIndexAtPtx4003, r_LaneIndexAtPtx4012;
	uint32_t r_LaneIndexAtPtx4021, r_PtxRegister1514, r_LaneIndexAtPtx4035, r_LaneIndexAtPtx4043,
		r_LaneIndexAtPtx4052, r_LaneIndexAtPtx4061, r_PtxRegister1519, r_LaneIndexAtPtx4075,
		r_LaneIndexAtPtx4083, r_LaneIndexAtPtx4092, r_LaneIndexAtPtx4101, r_PtxRegister1524;
	uint32_t r_LaneIndexAtPtx4114, r_LaneIndexAtPtx4123, r_LaneIndexAtPtx4132, r_LaneIndexAtPtx4141,
		r_ThreadZAtPtx5145, r_PtxRegister1530, r_CtaZ, r_PtxRegister1532, r_PtxRegister1533,
		r_PtxRegister1534, r_PtxRegister1535, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_PtxRegister1538, r_PtxRegister1539, r_PtxRegister1540, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PackedHalf2AtPtx1100R1545,
		r_PackedHalf2AtPtx1101R1546, r_PackedHalf2AtPtx1102R1547, r_PackedHalf2AtPtx1103R1548;
	uint32_t r_PtxRegister1549, r_PackedHalf2AtPtx1124R1550, r_PackedHalf2AtPtx1125R1551,
		r_PackedHalf2AtPtx1126R1552, r_PackedHalf2AtPtx1127R1553, r_PtxRegister1554,
		r_PackedHalf2AtPtx1148R1555, r_PackedHalf2AtPtx1149R1556, r_PackedHalf2AtPtx1150R1557,
		r_PackedHalf2AtPtx1151R1558, r_PtxRegister1559, r_PackedHalf2AtPtx1172R1560;
	uint32_t r_PackedHalf2AtPtx1173R1561, r_PackedHalf2AtPtx1174R1562, r_PackedHalf2AtPtx1175R1563,
		r_PtxRegister1564, r_PackedHalf2AtPtx1197R1565, r_PackedHalf2AtPtx1198R1566,
		r_PackedHalf2AtPtx1199R1567, r_PackedHalf2AtPtx1200R1568, r_PtxRegister1569,
		r_PackedHalf2AtPtx1221R1570, r_PackedHalf2AtPtx1222R1571, r_PackedHalf2AtPtx1223R1572;
	uint32_t r_PackedHalf2AtPtx1224R1573, r_PtxRegister1574, r_PackedHalf2AtPtx1245R1575,
		r_PackedHalf2AtPtx1246R1576, r_PackedHalf2AtPtx1247R1577, r_PackedHalf2AtPtx1248R1578,
		r_PtxRegister1579, r_PackedHalf2AtPtx1269R1580, r_PackedHalf2AtPtx1270R1581,
		r_PackedHalf2AtPtx1271R1582, r_PackedHalf2AtPtx1272R1583, r_PtxRegister1584;
	uint32_t r_PackedHalf2AtPtx1294R1585, r_PackedHalf2AtPtx1295R1586, r_PackedHalf2AtPtx1296R1587,
		r_PackedHalf2AtPtx1297R1588, r_PtxRegister1589, r_PackedHalf2AtPtx1318R1590,
		r_PackedHalf2AtPtx1319R1591, r_PackedHalf2AtPtx1320R1592, r_PackedHalf2AtPtx1321R1593,
		r_PtxRegister1594, r_PackedHalf2AtPtx1342R1595, r_PackedHalf2AtPtx1343R1596;
	uint32_t r_PackedHalf2AtPtx1344R1597, r_PackedHalf2AtPtx1345R1598, r_PtxRegister1599,
		r_PackedHalf2AtPtx1366R1600, r_PackedHalf2AtPtx1367R1601, r_PackedHalf2AtPtx1368R1602,
		r_PackedHalf2AtPtx1369R1603, r_PtxRegister1604, r_PackedHalf2AtPtx1391R1605,
		r_PackedHalf2AtPtx1392R1606, r_PackedHalf2AtPtx1393R1607, r_PackedHalf2AtPtx1394R1608;
	uint32_t r_PtxRegister1609, r_PackedHalf2AtPtx1415R1610, r_PackedHalf2AtPtx1416R1611,
		r_PackedHalf2AtPtx1417R1612, r_PackedHalf2AtPtx1418R1613, r_PtxRegister1614,
		r_PackedHalf2AtPtx1439R1615, r_PackedHalf2AtPtx1440R1616, r_PackedHalf2AtPtx1441R1617,
		r_PackedHalf2AtPtx1442R1618, r_PtxRegister1619, r_PackedHalf2AtPtx1463R1620;
	uint32_t r_PackedHalf2AtPtx1464R1621, r_PackedHalf2AtPtx1465R1622, r_PackedHalf2AtPtx1466R1623,
		r_PackedHalf2AtPtx1027R1624, r_PackedHalf2AtPtx1028R1625, r_PackedHalf2AtPtx1029R1626,
		r_PackedHalf2AtPtx1030R1627, r_PackedHalf2AtPtx1031R1628, r_PackedHalf2AtPtx1032R1629,
		r_PackedHalf2AtPtx1033R1630, r_PackedHalf2AtPtx1034R1631, r_PackedHalf2AtPtx1035R1632;
	uint32_t r_PackedHalf2AtPtx1036R1633, r_PackedHalf2AtPtx1037R1634, r_PackedHalf2AtPtx1038R1635,
		r_PackedHalf2AtPtx1039R1636, r_PackedHalf2AtPtx1040R1637, r_PackedHalf2AtPtx1041R1638,
		r_PackedHalf2AtPtx1042R1639, r_PackedHalf2AtPtx1043R1640, r_PackedHalf2AtPtx1044R1641,
		r_PackedHalf2AtPtx1045R1642, r_PackedHalf2AtPtx1046R1643, r_PackedHalf2AtPtx1047R1644;
	uint32_t r_PackedHalf2AtPtx1048R1645, r_PackedHalf2AtPtx1049R1646, r_PackedHalf2AtPtx1050R1647,
		r_PackedHalf2AtPtx1051R1648, r_PackedHalf2AtPtx1052R1649, r_PackedHalf2AtPtx1053R1650,
		r_PackedHalf2AtPtx1054R1651, r_PackedHalf2AtPtx1055R1652, r_PackedHalf2AtPtx1056R1653,
		r_PackedHalf2AtPtx1057R1654, r_PackedHalf2AtPtx1058R1655, r_PackedHalf2AtPtx1059R1656;
	uint32_t r_PackedHalf2AtPtx1060R1657, r_PackedHalf2AtPtx1061R1658, r_PackedHalf2AtPtx1062R1659,
		r_PackedHalf2AtPtx1063R1660, r_PackedHalf2AtPtx1064R1661, r_PackedHalf2AtPtx1065R1662,
		r_PackedHalf2AtPtx1066R1663, r_PackedHalf2AtPtx1067R1664, r_PackedHalf2AtPtx1068R1665,
		r_PackedHalf2AtPtx1069R1666, r_PackedHalf2AtPtx1070R1667, r_PackedHalf2AtPtx1071R1668;
	uint32_t r_PackedHalf2AtPtx1072R1669, r_PackedHalf2AtPtx1073R1670, r_PackedHalf2AtPtx1074R1671,
		r_PackedHalf2AtPtx1075R1672, r_PackedHalf2AtPtx1076R1673, r_PackedHalf2AtPtx1077R1674,
		r_PackedHalf2AtPtx1078R1675, r_PackedHalf2AtPtx1079R1676, r_PackedHalf2AtPtx1080R1677,
		r_PackedHalf2AtPtx1081R1678, r_PackedHalf2AtPtx1082R1679, r_PackedHalf2AtPtx1083R1680;
	uint32_t r_PackedHalf2AtPtx1084R1681, r_PackedHalf2AtPtx1085R1682, r_PackedHalf2AtPtx1086R1683,
		r_PackedHalf2AtPtx1087R1684, r_PackedHalf2AtPtx1088R1685, r_PackedHalf2AtPtx1089R1686,
		r_PackedHalf2AtPtx1090R1687, r_PtxRegister1688, r_MmaBHalf2WordAtPtx147R1689,
		r_MmaBHalf2WordAtPtx138R1690, r_MmaBHalf2WordAtPtx138R1691, r_MmaBHalf2WordAtPtx138R1692;
	uint32_t r_MmaBHalf2WordAtPtx138R1693, r_MmaBHalf2WordAtPtx129R1694, r_MmaBHalf2WordAtPtx129R1695,
		r_MmaBHalf2WordAtPtx129R1696, r_MmaBHalf2WordAtPtx129R1697, r_MmaBHalf2WordAtPtx120R1698,
		r_MmaBHalf2WordAtPtx120R1699, r_MmaBHalf2WordAtPtx120R1700, r_MmaBHalf2WordAtPtx120R1701,
		r_MmaBHalf2WordAtPtx111R1702, r_MmaBHalf2WordAtPtx111R1703, r_MmaBHalf2WordAtPtx111R1704;
	uint32_t r_MmaBHalf2WordAtPtx111R1705, r_MmaBHalf2WordAtPtx101R1706, r_MmaBHalf2WordAtPtx101R1707,
		r_MmaBHalf2WordAtPtx101R1708, r_MmaBHalf2WordAtPtx101R1709, r_MmaBHalf2WordAtPtx91R1710,
		r_MmaBHalf2WordAtPtx91R1711, r_MmaBHalf2WordAtPtx91R1712, r_MmaBHalf2WordAtPtx91R1713,
		r_MmaBHalf2WordAtPtx81R1714, r_MmaBHalf2WordAtPtx81R1715, r_MmaBHalf2WordAtPtx81R1716;
	uint32_t r_MmaBHalf2WordAtPtx81R1717, r_MmaBHalf2WordAtPtx147R1718, r_MmaBHalf2WordAtPtx147R1719,
		r_MmaBHalf2WordAtPtx147R1720, r_PtxRegister1721, r_PtxRegister1722, r_PtxRegister1723,
		r_PtxRegister1724, r_PackedHalf2AtPtx4157R1725, r_PackedHalf2AtPtx4158R1726,
		r_PackedHalf2AtPtx4159R1727, r_PackedHalf2AtPtx4160R1728;
	uint32_t r_PtxRegister1729, r_PackedHalf2AtPtx4181R1730, r_PackedHalf2AtPtx4182R1731,
		r_PackedHalf2AtPtx4183R1732, r_PackedHalf2AtPtx4184R1733, r_PtxRegister1734,
		r_PackedHalf2AtPtx4205R1735, r_PackedHalf2AtPtx4206R1736, r_PackedHalf2AtPtx4207R1737,
		r_PackedHalf2AtPtx4208R1738, r_PtxRegister1739, r_PackedHalf2AtPtx4229R1740;
	uint32_t r_PackedHalf2AtPtx4230R1741, r_PackedHalf2AtPtx4231R1742, r_PackedHalf2AtPtx4232R1743,
		r_PtxRegister1744, r_PackedHalf2AtPtx4254R1745, r_PackedHalf2AtPtx4255R1746,
		r_PackedHalf2AtPtx4256R1747, r_PackedHalf2AtPtx4257R1748, r_PtxRegister1749,
		r_PackedHalf2AtPtx4278R1750, r_PackedHalf2AtPtx4279R1751, r_PackedHalf2AtPtx4280R1752;
	uint32_t r_PackedHalf2AtPtx4281R1753, r_PtxRegister1754, r_PackedHalf2AtPtx4302R1755,
		r_PackedHalf2AtPtx4303R1756, r_PackedHalf2AtPtx4304R1757, r_PackedHalf2AtPtx4305R1758,
		r_PtxRegister1759, r_PackedHalf2AtPtx4326R1760, r_PackedHalf2AtPtx4327R1761,
		r_PackedHalf2AtPtx4328R1762, r_PackedHalf2AtPtx4329R1763, r_PtxRegister1764;
	uint32_t r_PackedHalf2AtPtx4351R1765, r_PackedHalf2AtPtx4352R1766, r_PackedHalf2AtPtx4353R1767,
		r_PackedHalf2AtPtx4354R1768, r_PtxRegister1769, r_PackedHalf2AtPtx4375R1770,
		r_PackedHalf2AtPtx4376R1771, r_PackedHalf2AtPtx4377R1772, r_PackedHalf2AtPtx4378R1773,
		r_PtxRegister1774, r_PackedHalf2AtPtx4399R1775, r_PackedHalf2AtPtx4400R1776;
	uint32_t r_PackedHalf2AtPtx4401R1777, r_PackedHalf2AtPtx4402R1778, r_PtxRegister1779,
		r_PackedHalf2AtPtx4423R1780, r_PackedHalf2AtPtx4424R1781, r_PackedHalf2AtPtx4425R1782,
		r_PackedHalf2AtPtx4426R1783, r_PtxRegister1784, r_PackedHalf2AtPtx4448R1785,
		r_PackedHalf2AtPtx4449R1786, r_PackedHalf2AtPtx4450R1787, r_PackedHalf2AtPtx4451R1788;
	uint32_t r_PtxRegister1789, r_PackedHalf2AtPtx4472R1790, r_PackedHalf2AtPtx4473R1791,
		r_PackedHalf2AtPtx4474R1792, r_PackedHalf2AtPtx4475R1793, r_PtxRegister1794,
		r_PackedHalf2AtPtx4496R1795, r_PackedHalf2AtPtx4497R1796, r_PackedHalf2AtPtx4498R1797,
		r_PackedHalf2AtPtx4499R1798, r_PtxRegister1799, r_PackedHalf2AtPtx4534R1800;
	uint32_t r_PackedHalf2AtPtx4519R1801, r_PackedHalf2AtPtx4520R1802, r_PackedHalf2AtPtx4521R1803;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, r_PtxU64Register3, r_PtxU64Register4,
		r_PtxU64Register5, r_PtxU64Register6, r_PtxU64Register7, r_PtxU64Register8,
		g_OutputByteAddressAtPtx3992, g_OutputByteAddressAtPtx4032, g_OutputByteAddressAtPtx4072,
		g_OutputByteAddressAtPtx4989;
	uint64_t g_OutputByteAddressAtPtx5028, g_OutputByteAddressAtPtx5067, g_OutputBaseAddress,
		g_RecordBaseAddress, g_CounterBaseAddress, g_RecordByteAddressAtPtx79, g_RecordByteAddressAtPtx89,
		g_RecordByteAddressAtPtx99, g_RecordByteAddressAtPtx109, g_RecordByteAddressAtPtx118,
		g_RecordByteAddressAtPtx127, g_RecordByteAddressAtPtx136;
	uint64_t g_RecordByteAddressAtPtx145, r_PtxU64Register26, g_RecordByteAddressAtPtx74, r_PtxU64Register28,
		r_PtxU64Register29, g_RecordByteAddressAtPtx88, r_PtxU64Register31, g_RecordByteAddressAtPtx98,
		r_PtxU64Register33, g_RecordByteAddressAtPtx108, r_PtxU64Register35, g_RecordByteAddressAtPtx117;
	uint64_t r_PtxU64Register37, g_RecordByteAddressAtPtx126, r_PtxU64Register39, g_RecordByteAddressAtPtx135,
		r_PtxU64Register41, g_RecordByteAddressAtPtx144, r_PtxU64Register43, r_PtxU64Register44,
		r_PtxU64Register45, r_PtxU64Register46, r_PtxU64Register47, r_PtxU64Register48;
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
		g_ResidualByteAddressAtPtx1114, r_PtxU64Register90, g_ResidualByteAddressAtPtx1109,
		r_PtxU64Register92, g_ResidualByteAddressAtPtx1138, r_PtxU64Register94,
		g_ResidualByteAddressAtPtx1133, r_PtxU64Register96;
	uint64_t g_ResidualByteAddressAtPtx1162, r_PtxU64Register98, g_ResidualByteAddressAtPtx1157,
		r_PtxU64Register100, g_ResidualByteAddressAtPtx1186, r_PtxU64Register102,
		g_ResidualByteAddressAtPtx1181, r_PtxU64Register104, g_ResidualByteAddressAtPtx1211,
		r_PtxU64Register106, g_ResidualByteAddressAtPtx1206, r_PtxU64Register108;
	uint64_t g_ResidualByteAddressAtPtx1235, r_PtxU64Register110, g_ResidualByteAddressAtPtx1230,
		r_PtxU64Register112, g_ResidualByteAddressAtPtx1259, r_PtxU64Register114,
		g_ResidualByteAddressAtPtx1254, r_PtxU64Register116, g_ResidualByteAddressAtPtx1283,
		r_PtxU64Register118, g_ResidualByteAddressAtPtx1278, r_PtxU64Register120;
	uint64_t g_ResidualByteAddressAtPtx1308, r_PtxU64Register122, g_ResidualByteAddressAtPtx1303,
		r_PtxU64Register124, g_ResidualByteAddressAtPtx1332, r_PtxU64Register126,
		g_ResidualByteAddressAtPtx1327, r_PtxU64Register128, g_ResidualByteAddressAtPtx1356,
		r_PtxU64Register130, g_ResidualByteAddressAtPtx1351, r_PtxU64Register132;
	uint64_t g_ResidualByteAddressAtPtx1380, r_PtxU64Register134, g_ResidualByteAddressAtPtx1375,
		r_PtxU64Register136, g_ResidualByteAddressAtPtx1405, r_PtxU64Register138,
		g_ResidualByteAddressAtPtx1400, r_PtxU64Register140, g_ResidualByteAddressAtPtx1429,
		r_PtxU64Register142, g_ResidualByteAddressAtPtx1424, r_PtxU64Register144;
	uint64_t g_ResidualByteAddressAtPtx1453, r_PtxU64Register146, g_ResidualByteAddressAtPtx1448,
		r_PtxU64Register148, g_ResidualByteAddressAtPtx1477, r_PtxU64Register150,
		g_ResidualByteAddressAtPtx1472, r_PtxU64Register152, g_RecordByteAddressAtPtx1482,
		r_PtxU64Register154, g_RecordByteAddressAtPtx1500, r_PtxU64Register156;
	uint64_t g_RecordByteAddressAtPtx1514, r_PtxU64Register158, g_RecordByteAddressAtPtx1528,
		r_PtxU64Register160, g_RecordByteAddressAtPtx1542, r_PtxU64Register162, g_RecordByteAddressAtPtx1557,
		r_PtxU64Register164, g_RecordByteAddressAtPtx1571, r_PtxU64Register166, g_RecordByteAddressAtPtx1586,
		r_PtxU64Register168;
	uint64_t g_RecordByteAddressAtPtx1600, r_PtxU64Register170, g_RecordByteAddressAtPtx1615,
		r_PtxU64Register172, g_RecordByteAddressAtPtx1629, r_PtxU64Register174, g_RecordByteAddressAtPtx1644,
		r_PtxU64Register176, g_RecordByteAddressAtPtx1658, r_PtxU64Register178, g_RecordByteAddressAtPtx1673,
		r_PtxU64Register180;
	uint64_t g_RecordByteAddressAtPtx1687, r_PtxU64Register182, g_RecordByteAddressAtPtx1702,
		r_PtxU64Register184, g_RecordByteAddressAtPtx1716, r_PtxU64Register186, g_RecordByteAddressAtPtx1730,
		r_PtxU64Register188, g_RecordByteAddressAtPtx1744, r_PtxU64Register190, g_RecordByteAddressAtPtx1758,
		r_PtxU64Register192;
	uint64_t g_RecordByteAddressAtPtx1772, r_PtxU64Register194, g_RecordByteAddressAtPtx1786,
		r_PtxU64Register196, g_RecordByteAddressAtPtx1800, r_PtxU64Register198, g_RecordByteAddressAtPtx1814,
		r_PtxU64Register200, g_RecordByteAddressAtPtx1828, r_PtxU64Register202, g_RecordByteAddressAtPtx1842,
		r_PtxU64Register204;
	uint64_t g_RecordByteAddressAtPtx1856, r_PtxU64Register206, g_RecordByteAddressAtPtx1870,
		r_PtxU64Register208, g_RecordByteAddressAtPtx1884, r_PtxU64Register210, g_RecordByteAddressAtPtx1898,
		r_PtxU64Register212, g_RecordByteAddressAtPtx1912, r_PtxU64Register214, g_RecordByteAddressAtPtx1926,
		r_PtxU64Register216;
	uint64_t g_RecordByteAddressAtPtx1940, r_PtxU64Register218, g_RecordByteAddressAtPtx1954,
		r_PtxU64Register220, g_RecordByteAddressAtPtx1968, r_PtxU64Register222, g_RecordByteAddressAtPtx1982,
		r_PtxU64Register224, g_RecordByteAddressAtPtx1996, r_PtxU64Register226, g_RecordByteAddressAtPtx2010,
		r_PtxU64Register228;
	uint64_t g_RecordByteAddressAtPtx2024, r_PtxU64Register230, g_RecordByteAddressAtPtx2038,
		r_PtxU64Register232, g_RecordByteAddressAtPtx2052, r_PtxU64Register234, g_RecordByteAddressAtPtx2066,
		r_PtxU64Register236, g_RecordByteAddressAtPtx2080, r_PtxU64Register238, g_RecordByteAddressAtPtx2094,
		r_PtxU64Register240;
	uint64_t g_RecordByteAddressAtPtx2108, r_PtxU64Register242, g_RecordByteAddressAtPtx2122,
		r_PtxU64Register244, g_RecordByteAddressAtPtx2136, r_PtxU64Register246, g_RecordByteAddressAtPtx2150,
		r_PtxU64Register248, g_RecordByteAddressAtPtx2164, r_PtxU64Register250, g_RecordByteAddressAtPtx2178,
		r_PtxU64Register252;
	uint64_t g_RecordByteAddressAtPtx2192, r_PtxU64Register254, g_RecordByteAddressAtPtx2206,
		r_PtxU64Register256, g_RecordByteAddressAtPtx2220, r_PtxU64Register258, g_RecordByteAddressAtPtx2234,
		r_PtxU64Register260, g_RecordByteAddressAtPtx2248, r_PtxU64Register262, g_RecordByteAddressAtPtx2262,
		r_PtxU64Register264;
	uint64_t g_RecordByteAddressAtPtx2276, r_PtxU64Register266, g_RecordByteAddressAtPtx2290,
		r_PtxU64Register268, g_RecordByteAddressAtPtx2304, r_PtxU64Register270, g_RecordByteAddressAtPtx2318,
		r_PtxU64Register272, g_RecordByteAddressAtPtx2332, r_PtxU64Register274, g_RecordByteAddressAtPtx2346,
		r_PtxU64Register276;
	uint64_t g_RecordByteAddressAtPtx2360, r_PtxU64Register278, g_RecordByteAddressAtPtx2374,
		r_PtxU64Register280, g_RecordByteAddressAtPtx2388, g_RecordByteAddressAtPtx3395,
		g_RecordByteAddressAtPtx3404, g_RecordByteAddressAtPtx3413, g_RecordByteAddressAtPtx3422,
		g_RecordByteAddressAtPtx3431, g_RecordByteAddressAtPtx3440, g_RecordByteAddressAtPtx3449;
	uint64_t g_RecordByteAddressAtPtx3458, r_PtxU64Register290, g_RecordByteAddressAtPtx3390,
		r_PtxU64Register292, r_PtxU64Register293, g_RecordByteAddressAtPtx3403, r_PtxU64Register295,
		g_RecordByteAddressAtPtx3412, r_PtxU64Register297, g_RecordByteAddressAtPtx3421, r_PtxU64Register299,
		g_RecordByteAddressAtPtx3430;
	uint64_t r_PtxU64Register301, g_RecordByteAddressAtPtx3439, r_PtxU64Register303,
		g_RecordByteAddressAtPtx3448, r_PtxU64Register305, g_RecordByteAddressAtPtx3457, r_PtxU64Register307,
		r_PtxU64Register308, r_PtxU64Register309, r_PtxU64Register310, r_PtxU64Register311,
		r_PtxU64Register312;
	uint64_t r_PtxU64Register313, r_PtxU64Register314, r_PtxU64Register315, r_PtxU64Register316,
		r_PtxU64Register317, r_PtxU64Register318, r_PtxU64Register319, r_PtxU64Register320,
		r_PtxU64Register321, r_PtxU64Register322, r_PtxU64Register323, r_PtxU64Register324;
	uint64_t r_PtxU64Register325, r_PtxU64Register326, r_PtxU64Register327, r_PtxU64Register328,
		r_PtxU64Register329, r_PtxU64Register330, g_OutputByteAddressAtPtx4171, r_PtxU64Register332,
		g_OutputByteAddressAtPtx4166, r_PtxU64Register334, g_OutputByteAddressAtPtx4195, r_PtxU64Register336;
	uint64_t g_OutputByteAddressAtPtx4190, r_PtxU64Register338, g_OutputByteAddressAtPtx4219,
		r_PtxU64Register340, g_OutputByteAddressAtPtx4214, r_PtxU64Register342, g_OutputByteAddressAtPtx4243,
		r_PtxU64Register344, g_OutputByteAddressAtPtx4238, r_PtxU64Register346, g_OutputByteAddressAtPtx4268,
		r_PtxU64Register348;
	uint64_t g_OutputByteAddressAtPtx4263, r_PtxU64Register350, g_OutputByteAddressAtPtx4292,
		r_PtxU64Register352, g_OutputByteAddressAtPtx4287, r_PtxU64Register354, g_OutputByteAddressAtPtx4316,
		r_PtxU64Register356, g_OutputByteAddressAtPtx4311, r_PtxU64Register358, g_OutputByteAddressAtPtx4340,
		r_PtxU64Register360;
	uint64_t g_OutputByteAddressAtPtx4335, r_PtxU64Register362, g_OutputByteAddressAtPtx4365,
		r_PtxU64Register364, g_OutputByteAddressAtPtx4360, r_PtxU64Register366, g_OutputByteAddressAtPtx4389,
		r_PtxU64Register368, g_OutputByteAddressAtPtx4384, r_PtxU64Register370, g_OutputByteAddressAtPtx4413,
		r_PtxU64Register372;
	uint64_t g_OutputByteAddressAtPtx4408, r_PtxU64Register374, g_OutputByteAddressAtPtx4437,
		r_PtxU64Register376, g_OutputByteAddressAtPtx4432, r_PtxU64Register378, g_OutputByteAddressAtPtx4462,
		r_PtxU64Register380, g_OutputByteAddressAtPtx4457, r_PtxU64Register382, g_OutputByteAddressAtPtx4486,
		r_PtxU64Register384;
	uint64_t g_OutputByteAddressAtPtx4481, r_PtxU64Register386, g_OutputByteAddressAtPtx4510,
		r_PtxU64Register388, g_OutputByteAddressAtPtx4505, r_PtxU64Register390, g_OutputByteAddressAtPtx4532,
		r_PtxU64Register392, g_OutputByteAddressAtPtx4527, r_PtxU64Register394, r_PtxU64Register395,
		g_OutputByteAddressAtPtx4995;
	uint64_t g_OutputByteAddressAtPtx5004, g_OutputByteAddressAtPtx5013, g_OutputByteAddressAtPtx5022,
		r_PtxU64Register400, r_PtxU64Register401, g_OutputByteAddressAtPtx5003, r_PtxU64Register403,
		g_OutputByteAddressAtPtx5012, r_PtxU64Register405, g_OutputByteAddressAtPtx5021,
		g_OutputByteAddressAtPtx5034, g_OutputByteAddressAtPtx5043;
	uint64_t g_OutputByteAddressAtPtx5052, g_OutputByteAddressAtPtx5061, r_PtxU64Register411,
		r_PtxU64Register412, g_OutputByteAddressAtPtx5042, r_PtxU64Register414, g_OutputByteAddressAtPtx5051,
		r_PtxU64Register416, g_OutputByteAddressAtPtx5060, g_OutputByteAddressAtPtx5073,
		g_OutputByteAddressAtPtx5082, g_OutputByteAddressAtPtx5091;
	uint64_t g_OutputByteAddressAtPtx5100, r_PtxU64Register422, r_PtxU64Register423,
		g_OutputByteAddressAtPtx5081, r_PtxU64Register425, g_OutputByteAddressAtPtx5090, r_PtxU64Register427,
		g_OutputByteAddressAtPtx5099, g_OutputByteAddressAtPtx5112, g_OutputByteAddressAtPtx5121,
		g_OutputByteAddressAtPtx5130, g_OutputByteAddressAtPtx5139;
	uint64_t r_PtxU64Register433, g_OutputByteAddressAtPtx5111, r_PtxU64Register435,
		g_OutputByteAddressAtPtx5120, r_PtxU64Register437, g_OutputByteAddressAtPtx5129, r_PtxU64Register439,
		g_OutputByteAddressAtPtx5138, r_PtxU64Register441, r_PtxU64Register442, r_PtxU64Register443,
		r_PtxU64Register444;
	uint64_t r_PtxU64Register445, r_PtxU64Register446, r_PtxU64Register447, r_PtxU64Register448,
		r_PtxU64Register449, r_PtxU64Register450, r_PtxU64Register451, r_PtxU64Register452,
		r_PtxU64Register453, r_PtxU64Register454, r_PtxU64Register455, r_PtxU64Register456;
	uint64_t r_PtxU64Register457, r_PtxU64Register458, r_PtxU64Register459, r_PtxU64Register460,
		r_PtxU64Register461, r_PtxU64Register462, r_PtxU64Register463, r_PtxU64Register464,
		r_PtxU64Register465, r_PtxU64Register466, r_PtxU64Register467, r_PtxU64Register468;
	uint64_t r_PtxU64Register469, r_PtxU64Register470, r_PtxU64Register471, r_PtxU64Register472,
		r_PtxU64Register473, r_PtxU64Register474, r_PtxU64Register475, r_PtxU64Register476,
		r_PtxU64Register477, r_PtxU64Register478, r_PtxU64Register479, r_PtxU64Register480;
	uint64_t r_PtxU64Register481, r_PtxU64Register482, r_PtxU64Register483, r_PtxU64Register484,
		r_PtxU64Register485, r_PtxU64Register486, r_PtxU64Register487, r_PtxU64Register488,
		r_PtxU64Register489, r_PtxU64Register490, r_PtxU64Register491, r_PtxU64Register492;
	uint64_t r_PtxU64Register493, r_PtxU64Register494, r_PtxU64Register495, r_PtxU64Register496,
		r_PtxU64Register497, r_PtxU64Register498, r_PtxU64Register499, r_PtxU64Register500,
		r_PtxU64Register501, r_PtxU64Register502, r_PtxU64Register503, r_PtxU64Register504;
	uint64_t r_PtxU64Register505, r_PtxU64Register506, r_PtxU64Register507, r_PtxU64Register508,
		r_PtxU64Register509, r_PtxU64Register510, r_PtxU64Register511, r_PtxU64Register512,
		r_PtxU64Register513, r_PtxU64Register514, r_PtxU64Register515, r_PtxU64Register516;
	uint64_t r_PtxU64Register517, r_PtxU64Register518, r_PtxU64Register519, r_PtxU64Register520,
		r_PtxU64Register521, g_OutputByteAddressAtPtx3998, g_OutputByteAddressAtPtx4007,
		g_OutputByteAddressAtPtx4016, g_OutputByteAddressAtPtx4025, r_PtxU64Register526, r_PtxU64Register527,
		g_OutputByteAddressAtPtx4006;
	uint64_t r_PtxU64Register529, g_OutputByteAddressAtPtx4015, r_PtxU64Register531,
		g_OutputByteAddressAtPtx4024, g_OutputByteAddressAtPtx4038, g_OutputByteAddressAtPtx4047,
		g_OutputByteAddressAtPtx4056, g_OutputByteAddressAtPtx4065, r_PtxU64Register537, r_PtxU64Register538,
		g_OutputByteAddressAtPtx4046, r_PtxU64Register540;
	uint64_t g_OutputByteAddressAtPtx4055, r_PtxU64Register542, g_OutputByteAddressAtPtx4064,
		g_OutputByteAddressAtPtx4078, g_OutputByteAddressAtPtx4087, g_OutputByteAddressAtPtx4096,
		g_OutputByteAddressAtPtx4105, r_PtxU64Register548, r_PtxU64Register549, g_OutputByteAddressAtPtx4086,
		r_PtxU64Register551, g_OutputByteAddressAtPtx4095;
	uint64_t r_PtxU64Register553, g_OutputByteAddressAtPtx4104, g_OutputByteAddressAtPtx4118,
		g_OutputByteAddressAtPtx4127, g_OutputByteAddressAtPtx4136, g_OutputByteAddressAtPtx4145,
		r_PtxU64Register559, g_OutputByteAddressAtPtx4117, r_PtxU64Register561, g_OutputByteAddressAtPtx4126,
		r_PtxU64Register563, g_OutputByteAddressAtPtx4135;
	uint64_t r_PtxU64Register565, g_OutputByteAddressAtPtx4144, g_CounterByteAddress, r_PtxU64Register568,
		r_PtxU64Register569, r_PtxU64Register570, r_PtxU64Register571, r_PtxU64Register572,
		r_PtxU64Register573, r_PtxU64Register574, r_PtxU64Register575, r_PtxU64Register576;
	uint64_t r_PtxU64Register577, r_PtxU64Register578, r_PtxU64Register579, r_PtxU64Register580,
		r_PtxU64Register581, r_PtxU64Register582, r_PtxU64Register583, r_PtxU64Register584,
		r_PtxU64Register585, r_PtxU64Register586, r_PtxU64Register587, r_PtxU64Register588;
	uint64_t r_PtxU64Register589, r_PtxU64Register590, r_PtxU64Register591, r_PtxU64Register592,
		r_PtxU64Register593, r_PtxU64Register594, r_PtxU64Register595, r_PtxU64Register596,
		r_PtxU64Register597, r_PtxU64Register598, r_PtxU64Register599, r_PtxU64Register600;
	uint64_t r_PtxU64Register601, r_PtxU64Register602, r_PtxU64Register603, r_PtxU64Register604,
		r_PtxU64Register605, r_PtxU64Register606, r_PtxU64Register607, r_PtxU64Register608,
		r_PtxU64Register609, r_PtxU64Register610, r_PtxU64Register611;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_CounterBaseAddress = uint64_t(r_Parameters.g_Counter); // PTX L14
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);	 // PTX L15
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);	 // PTX L16
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip);	 // PTX L17
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);	 // PTX L18
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);								// PTX L19
	r_CtaX = uint32_t(blockIdx.x);												// PTX L20
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L21
	r_PtxRegister1 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits);			// PTX L22
	r_PtxRegister64 = uint32_t(r_PtxRegister1) + uint32_t(-1);					// PTX L23
	r_PtxRegister65 = ShiftRightSigned(int32_t(r_PtxRegister64), uint32_t(31)); // PTX L24
	r_PtxRegister66 = ShiftRight(uint32_t(r_PtxRegister65), uint32_t(25));		// PTX L25
	r_PtxRegister67 = uint32_t(r_PtxRegister64) + uint32_t(r_PtxRegister66);	// PTX L26
	r_PtxRegister68 = ShiftRightSigned(int32_t(r_PtxRegister67), uint32_t(7));	// PTX L27
	r_PtxRegister69 = uint32_t(r_PtxRegister68) + uint32_t(1);					// PTX L28
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister69));		// PTX L29
	r_PtxRegister70 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister68) + uint32_t(r_PtxRegister2); // PTX L30
	r_PtxRegister71 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister70);						 // PTX L31
	r_PtxRegister3 = ShiftLeft(uint32_t(r_PtxRegister71), uint32_t(3));					 // PTX L32
	r_PtxRegister72 = ShiftRight(uint32_t(r_PtxRegister65), uint32_t(28));				 // PTX L33
	r_PtxRegister73 = uint32_t(r_PtxRegister64) + uint32_t(r_PtxRegister72);			 // PTX L34
	r_PtxRegister74 = r_PtxRegister73 & -16;											 // PTX L35
	r_PtxRegister75 = uint32_t(r_PtxRegister74) + uint32_t(16);							 // PTX L36
	r_PtxRegister4 = ShiftRightSigned(int32_t(r_PtxRegister75), uint32_t(4));			 // PTX L37
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L38
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L39
	r_PtxRegister77 = r_ThreadX | r_ThreadY;											 // PTX L40
	r_bPtxPredicate3 = uint32_t(r_PtxRegister77) != uint32_t(0);						 // PTX L41
	if (r_bPtxPredicate3)
	{
		goto L__BB44_2;
	} // PTX L42
	r_BlockSizeX = uint32_t(blockDim.x);							   // PTX L43
	r_BlockSizeY = uint32_t(blockDim.y);							   // PTX L44
	r_PtxRegister79 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY); // PTX L45
	r_PtxRegister78 = uint32_t(24576u /* native mbarriers */);		   // PTX L46
	// Original staged-copy barrier initialization.
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister78, r_PtxRegister79); // PTX L48
	r_PtxRegister80 = uint32_t(r_PtxRegister78) + uint32_t(8);		// PTX L50
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister80, r_PtxRegister79); // PTX L52
	r_PtxRegister81 = uint32_t(r_PtxRegister78) + uint32_t(16);		// PTX L54
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister81, r_PtxRegister79); // PTX L56
L__BB44_2:															// PTX L58
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L59
	r_Float32BitsAtPtx60R84 = uint32_t(0);														// PTX L60
	r_PackedHalf2AtPtx4534R1800 = FloatToHalf2(r_Float32BitsAtPtx60R84);						// PTX L62
	r_PtxRegister93 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(19));								// PTX L67
	r_PtxRegister94 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(10));						// PTX L68
	r_PtxRegister95 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));								// PTX L69
	r_PtxRegister96 = r_PtxRegister95 & 512;													// PTX L70
	r_PtxRegister6 = r_PtxRegister94 | r_PtxRegister96;											// PTX L71
	r_PtxRegister97 = uint32_t(r_PtxRegister93) + uint32_t(r_PtxRegister6);						// PTX L72
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_PtxRegister97)) * int64_t(int32_t(4)));		// PTX L73
	g_RecordByteAddressAtPtx74 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register26);	// PTX L74
	r_LaneIndexAtPtx76 = uint32_t((threadIdx.x & 31u));											// PTX L76
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx76)) * int64_t(int32_t(16))); // PTX L78
	g_RecordByteAddressAtPtx79 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register28); // PTX L79
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx79));
		r_MmaBHalf2WordAtPtx81R1717 = r_Value.x;
		r_MmaBHalf2WordAtPtx81R1716 = r_Value.y;
		r_MmaBHalf2WordAtPtx81R1715 = r_Value.z;
		r_MmaBHalf2WordAtPtx81R1714 = r_Value.w;
	} // PTX L81
	r_PtxRegister7 = r_PtxRegister6 | 128;														// PTX L83
	r_LaneIndexAtPtx85 = uint32_t((threadIdx.x & 31u));											// PTX L85
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx85)) * int64_t(int32_t(16))); // PTX L87
	g_RecordByteAddressAtPtx88 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register29);		   // PTX L88
	g_RecordByteAddressAtPtx89 = uint64_t(g_RecordByteAddressAtPtx88) + uint64_t(512); // PTX L89
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx89));
		r_MmaBHalf2WordAtPtx91R1713 = r_Value.x;
		r_MmaBHalf2WordAtPtx91R1712 = r_Value.y;
		r_MmaBHalf2WordAtPtx91R1711 = r_Value.z;
		r_MmaBHalf2WordAtPtx91R1710 = r_Value.w;
	} // PTX L91
	r_PtxRegister8 = r_PtxRegister6 | 256;														// PTX L93
	r_LaneIndexAtPtx95 = uint32_t((threadIdx.x & 31u));											// PTX L95
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx95)) * int64_t(int32_t(16))); // PTX L97
	g_RecordByteAddressAtPtx98 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register31);			// PTX L98
	g_RecordByteAddressAtPtx99 = uint64_t(g_RecordByteAddressAtPtx98) + uint64_t(1024); // PTX L99
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx99));
		r_MmaBHalf2WordAtPtx101R1709 = r_Value.x;
		r_MmaBHalf2WordAtPtx101R1708 = r_Value.y;
		r_MmaBHalf2WordAtPtx101R1707 = r_Value.z;
		r_MmaBHalf2WordAtPtx101R1706 = r_Value.w;
	} // PTX L101
	r_PtxRegister9 = r_PtxRegister6 | 384;														 // PTX L103
	r_LaneIndexAtPtx105 = uint32_t((threadIdx.x & 31u));										 // PTX L105
	r_PtxU64Register33 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx105)) * int64_t(int32_t(16))); // PTX L107
	g_RecordByteAddressAtPtx108 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register33);			  // PTX L108
	g_RecordByteAddressAtPtx109 = uint64_t(g_RecordByteAddressAtPtx108) + uint64_t(1536); // PTX L109
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx109));
		r_MmaBHalf2WordAtPtx111R1705 = r_Value.x;
		r_MmaBHalf2WordAtPtx111R1704 = r_Value.y;
		r_MmaBHalf2WordAtPtx111R1703 = r_Value.z;
		r_MmaBHalf2WordAtPtx111R1702 = r_Value.w;
	} // PTX L111
	r_LaneIndexAtPtx114 = uint32_t((threadIdx.x & 31u));										 // PTX L114
	r_PtxU64Register35 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx114)) * int64_t(int32_t(16))); // PTX L116
	g_RecordByteAddressAtPtx117 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register35);			   // PTX L117
	g_RecordByteAddressAtPtx118 = uint64_t(g_RecordByteAddressAtPtx117) + uint64_t(32768); // PTX L118
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx118));
		r_MmaBHalf2WordAtPtx120R1701 = r_Value.x;
		r_MmaBHalf2WordAtPtx120R1700 = r_Value.y;
		r_MmaBHalf2WordAtPtx120R1699 = r_Value.z;
		r_MmaBHalf2WordAtPtx120R1698 = r_Value.w;
	} // PTX L120
	r_LaneIndexAtPtx123 = uint32_t((threadIdx.x & 31u));										 // PTX L123
	r_PtxU64Register37 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx123)) * int64_t(int32_t(16))); // PTX L125
	g_RecordByteAddressAtPtx126 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register37);			   // PTX L126
	g_RecordByteAddressAtPtx127 = uint64_t(g_RecordByteAddressAtPtx126) + uint64_t(33280); // PTX L127
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx127));
		r_MmaBHalf2WordAtPtx129R1697 = r_Value.x;
		r_MmaBHalf2WordAtPtx129R1696 = r_Value.y;
		r_MmaBHalf2WordAtPtx129R1695 = r_Value.z;
		r_MmaBHalf2WordAtPtx129R1694 = r_Value.w;
	} // PTX L129
	r_LaneIndexAtPtx132 = uint32_t((threadIdx.x & 31u));										 // PTX L132
	r_PtxU64Register39 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx132)) * int64_t(int32_t(16))); // PTX L134
	g_RecordByteAddressAtPtx135 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register39);			   // PTX L135
	g_RecordByteAddressAtPtx136 = uint64_t(g_RecordByteAddressAtPtx135) + uint64_t(33792); // PTX L136
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx136));
		r_MmaBHalf2WordAtPtx138R1693 = r_Value.x;
		r_MmaBHalf2WordAtPtx138R1692 = r_Value.y;
		r_MmaBHalf2WordAtPtx138R1691 = r_Value.z;
		r_MmaBHalf2WordAtPtx138R1690 = r_Value.w;
	} // PTX L138
	r_LaneIndexAtPtx141 = uint32_t((threadIdx.x & 31u));										 // PTX L141
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx141)) * int64_t(int32_t(16))); // PTX L143
	g_RecordByteAddressAtPtx144 =
		uint64_t(g_RecordByteAddressAtPtx74) + uint64_t(r_PtxU64Register41);			   // PTX L144
	g_RecordByteAddressAtPtx145 = uint64_t(g_RecordByteAddressAtPtx144) + uint64_t(34304); // PTX L145
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx145));
		r_MmaBHalf2WordAtPtx147R1689 = r_Value.x;
		r_MmaBHalf2WordAtPtx147R1718 = r_Value.y;
		r_MmaBHalf2WordAtPtx147R1719 = r_Value.z;
		r_MmaBHalf2WordAtPtx147R1720 = r_Value.w;
	} // PTX L147
	r_PtxRegister10 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(8));					  // PTX L149
	r_PtxRegister98 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister3);				  // PTX L150
	r_PtxRegister11 = uint32_t(r_PtxRegister1) + uint32_t(14);						  // PTX L151
	r_bPtxPredicate4 = uint32_t(r_PtxRegister11) < uint32_t(31);					  // PTX L152
	r_bPtxPredicate5 = int32_t(r_PtxRegister98) < int32_t(r_PtxRegister4);			  // PTX L153
	r_bPtxPredicate1 = r_bPtxPredicate4 | r_bPtxPredicate5;							  // PTX L154
	r_PtxRegister12 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(13));					  // PTX L155
	r_PtxRegister99 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(15));			  // PTX L156
	r_PtxRegister13 = r_bPtxPredicate4 ? 0 : r_PtxRegister99;						  // PTX L157
	r_PtxRegister14 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister12);		  // PTX L158
	r_PtxU64Register43 = uint64_t(uint32_t(r_PtxRegister10)) * uint64_t(uint32_t(4)); // PTX L159
	r_PtxRegister100 = uint32_t(0u /* native shared input */);						  // PTX L160
	r_PtxU64Register44 = uint64_t(r_PtxRegister100);								  // PTX L161
	r_PtxU64Register45 = SharedGeneric(s_SharedStorage, r_PtxU64Register44);		  // PTX L162
	r_PtxU64Register3 = uint64_t(r_PtxU64Register45) + uint64_t(r_PtxU64Register43);  // PTX L163
	r_PtxU16Register20 = uint16_t(0);												  // PTX L164
	r_PtxU64Register568 = uint64_t(0);												  // PTX L165
	r_PtxRegister1532 = uint32_t(128);												  // PTX L166
	r_bPtxPredicate6 = !r_bPtxPredicate1;											  // PTX L167
	r_PtxRegister1533 = uint32_t(r_PtxRegister1532);								  // PTX L168
	r_PtxU64Register569 = uint64_t(r_PtxU64Register568);							  // PTX L169
	if (r_bPtxPredicate6)
	{
		goto L__BB44_4;
	} // PTX L170
	r_PtxRegister101 = r_bPtxPredicate1 ? r_PtxRegister14 : 0;								 // PTX L171
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister101)) * int64_t(int32_t(4))); // PTX L172
	r_PtxU64Register568 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register46);		 // PTX L173
	r_PtxRegister1533 = uint32_t(r_PtxRegister10) + uint32_t(128);							 // PTX L174
	r_PtxRegister1532 = uint32_t(r_PtxRegister101) + uint32_t(128);							 // PTX L175
	r_PtxU16Register20 = uint16_t(1);														 // PTX L176
	r_PtxU64Register569 = uint64_t(r_PtxU64Register3);										 // PTX L177
L__BB44_4:																					 // PTX L178
	if (r_bPtxPredicate6)
	{
		goto L__BB44_6;
	} // PTX L179
	r_PtxRegister102 = uint32_t(r_PtxRegister10) + uint32_t(128);				  // PTX L180
	r_PtxRegister103 = uint32_t(r_PtxRegister14) + uint32_t(128);				  // PTX L181
	r_bPtxPredicate7 = uint32_t(r_PtxRegister102) == uint32_t(r_PtxRegister1533); // PTX L182
	r_bPtxPredicate8 = uint32_t(r_PtxRegister103) == uint32_t(r_PtxRegister1532); // PTX L183
	r_PtxU16Register1 = r_bPtxPredicate8 ? r_PtxU16Register20 : 0;				  // PTX L184
	r_PtxU16Register20 = r_bPtxPredicate7 ? r_PtxU16Register1 : 0;				  // PTX L185
L__BB44_6:																		  // PTX L186
	r_bPtxPredicate9 = uint16_t(r_PtxU16Register20) == uint16_t(0);				  // PTX L187
	if (r_bPtxPredicate9)
	{
		goto L__BB44_9;
	} // PTX L188
	r_PtxRegister105 = uint32_t(-1);							   // PTX L189
	r_PtxRegister104 = Elected(r_PtxRegister105);				   // PTX L191
	r_bPtxPredicate10 = uint32_t(r_PtxRegister104) == uint32_t(0); // PTX L197
	if (r_bPtxPredicate10)
	{
		goto L__BB44_25;
	} // PTX L198
	r_PtxU64Register48 = SharedOffset(s_SharedStorage, r_PtxU64Register569); // PTX L199
	r_PtxRegister106 = uint32_t(r_PtxU64Register48);						 // PTX L200
	r_PtxU64Register47 = r_PtxU64Register568;								 // PTX L201
	r_PtxRegister108 = uint32_t(24576u /* native mbarriers */);				 // PTX L202
	r_PtxRegister107 = uint32_t(1024);										 // PTX L203
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister106, r_PtxU64Register47, r_PtxRegister107,
			 r_PtxRegister108);											// PTX L205
	BarrierExpect(s_SharedStorage, r_PtxRegister108, r_PtxRegister107); // PTX L208
	goto L__BB44_25;													// PTX L210
L__BB44_9:																// PTX L211
	r_PtxU64Register570 = uint64_t(0);									// PTX L212
	if (r_bPtxPredicate6)
	{
		goto L__BB44_11;
	} // PTX L213
	r_PtxU64Register570 = SignExtendWordBits(r_PtxRegister14); // PTX L214
L__BB44_11:													   // PTX L215
	r_PtxU64Register571 = uint64_t(0);						   // PTX L216
	if (r_bPtxPredicate6)
	{
		goto L__BB44_13;
	} // PTX L217
	r_PtxU64Register49 = ShiftLeft(uint64_t(r_PtxU64Register570), uint32_t(2));		   // PTX L218
	r_PtxU64Register571 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register49); // PTX L219
L__BB44_13:																			   // PTX L220
	r_PtxRegister109 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));			   // PTX L221
	r_PtxRegister110 = uint32_t(0u /* native shared input */);						   // PTX L222
	r_PtxRegister15 = uint32_t(r_PtxRegister110) + uint32_t(r_PtxRegister109);		   // PTX L223
	if (r_bPtxPredicate6)
	{
		goto L__BB44_16;
	} // PTX L224
	r_PtxRegister115 = uint32_t(-1);							   // PTX L225
	r_PtxRegister114 = Elected(r_PtxRegister115);				   // PTX L227
	r_bPtxPredicate11 = uint32_t(r_PtxRegister114) == uint32_t(0); // PTX L233
	if (r_bPtxPredicate11)
	{
		goto L__BB44_17;
	} // PTX L234
	r_PtxU64Register50 = r_PtxU64Register571;					// PTX L235
	r_PtxRegister117 = uint32_t(24576u /* native mbarriers */); // PTX L236
	r_PtxRegister116 = uint32_t(512);							// PTX L237
	CopyBulk(s_SharedStorage, r_PtxRegister15, r_PtxU64Register50, r_PtxRegister116,
			 r_PtxRegister117);												   // PTX L239
	BarrierExpect(s_SharedStorage, r_PtxRegister117, r_PtxRegister116);		   // PTX L242
	goto L__BB44_17;														   // PTX L244
L__BB44_16:																	   // PTX L245
	r_LaneIndexAtPtx247 = uint32_t((threadIdx.x & 31u));					   // PTX L247
	r_PtxRegister113 = ShiftLeft(uint32_t(r_LaneIndexAtPtx247), uint32_t(4));  // PTX L249
	r_PtxRegister112 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister113); // PTX L250
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister112)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L252
L__BB44_17:										 // PTX L254
	r_PtxU64Register572 = uint64_t(0);			 // PTX L255
	if (r_bPtxPredicate6)
	{
		goto L__BB44_19;
	} // PTX L256
	r_PtxRegister118 = uint32_t(r_PtxRegister14) + uint32_t(128); // PTX L257
	r_PtxU64Register572 = SignExtendWordBits(r_PtxRegister118);	  // PTX L258
L__BB44_19:														  // PTX L259
	r_PtxU64Register573 = uint64_t(0);							  // PTX L260
	if (r_bPtxPredicate6)
	{
		goto L__BB44_21;
	} // PTX L261
	r_PtxU64Register51 = ShiftLeft(uint64_t(r_PtxU64Register572), uint32_t(2));		   // PTX L262
	r_PtxU64Register573 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register51); // PTX L263
L__BB44_21:																			   // PTX L264
	if (r_bPtxPredicate6)
	{
		goto L__BB44_24;
	} // PTX L265
	r_PtxRegister124 = uint32_t(-1);							   // PTX L266
	r_PtxRegister123 = Elected(r_PtxRegister124);				   // PTX L268
	r_bPtxPredicate12 = uint32_t(r_PtxRegister123) == uint32_t(0); // PTX L274
	if (r_bPtxPredicate12)
	{
		goto L__BB44_25;
	} // PTX L275
	r_PtxRegister125 = uint32_t(r_PtxRegister15) + uint32_t(512); // PTX L276
	r_PtxU64Register52 = r_PtxU64Register573;					  // PTX L277
	r_PtxRegister127 = uint32_t(24576u /* native mbarriers */);	  // PTX L278
	r_PtxRegister126 = uint32_t(512);							  // PTX L279
	CopyBulk(s_SharedStorage, r_PtxRegister125, r_PtxU64Register52, r_PtxRegister126,
			 r_PtxRegister127);												   // PTX L281
	BarrierExpect(s_SharedStorage, r_PtxRegister127, r_PtxRegister126);		   // PTX L284
	goto L__BB44_25;														   // PTX L286
L__BB44_24:																	   // PTX L287
	r_LaneIndexAtPtx289 = uint32_t((threadIdx.x & 31u));					   // PTX L289
	r_PtxRegister121 = ShiftLeft(uint32_t(r_LaneIndexAtPtx289), uint32_t(4));  // PTX L291
	r_PtxRegister122 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister121); // PTX L292
	r_PtxRegister120 = uint32_t(r_PtxRegister122) + uint32_t(512);			   // PTX L293
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister120)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L295
L__BB44_25:																	 // PTX L297
	r_bPtxPredicate13 = uint32_t(r_PtxRegister11) < uint32_t(31);			 // PTX L298
	r_PtxRegister16 = uint32_t(r_PtxRegister10) + uint32_t(1024);			 // PTX L299
	r_PtxRegister128 = uint32_t(r_PtxRegister98) + uint32_t(4);				 // PTX L300
	r_bPtxPredicate14 = int32_t(r_PtxRegister128) < int32_t(r_PtxRegister4); // PTX L301
	r_bPtxPredicate2 = r_bPtxPredicate13 | r_bPtxPredicate14;				 // PTX L302
	r_PtxRegister129 = ShiftLeft(uint32_t(r_PtxRegister128), uint32_t(15));	 // PTX L303
	r_PtxRegister17 = r_bPtxPredicate13 ? 0 : r_PtxRegister129;				 // PTX L304
	r_PtxRegister18 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister12); // PTX L305
	r_PtxU16Register21 = uint16_t(0);										 // PTX L306
	r_PtxU64Register574 = uint64_t(0);										 // PTX L307
	r_PtxRegister1534 = uint32_t(128);										 // PTX L308
	r_bPtxPredicate15 = !r_bPtxPredicate2;									 // PTX L309
	r_PtxRegister1535 = uint32_t(r_PtxRegister1534);						 // PTX L310
	r_PtxU64Register575 = uint64_t(r_PtxU64Register574);					 // PTX L311
	if (r_bPtxPredicate15)
	{
		goto L__BB44_27;
	} // PTX L312
	r_PtxRegister130 = r_bPtxPredicate2 ? r_PtxRegister18 : 0;								 // PTX L313
	r_PtxU64Register575 = uint64_t(r_PtxU64Register3) + uint64_t(4096);						 // PTX L314
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_PtxRegister130)) * int64_t(int32_t(4))); // PTX L315
	r_PtxU64Register574 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register53);		 // PTX L316
	r_PtxRegister1535 = uint32_t(r_PtxRegister16) + uint32_t(128);							 // PTX L317
	r_PtxRegister1534 = uint32_t(r_PtxRegister130) + uint32_t(128);							 // PTX L318
	r_PtxU16Register21 = uint16_t(1);														 // PTX L319
L__BB44_27:																					 // PTX L320
	if (r_bPtxPredicate15)
	{
		goto L__BB44_29;
	} // PTX L321
	r_PtxRegister131 = uint32_t(r_PtxRegister16) + uint32_t(128);				   // PTX L322
	r_PtxRegister132 = uint32_t(r_PtxRegister18) + uint32_t(128);				   // PTX L323
	r_bPtxPredicate16 = uint32_t(r_PtxRegister131) == uint32_t(r_PtxRegister1535); // PTX L324
	r_bPtxPredicate17 = uint32_t(r_PtxRegister132) == uint32_t(r_PtxRegister1534); // PTX L325
	r_PtxU16Register2 = r_bPtxPredicate17 ? r_PtxU16Register21 : 0;				   // PTX L326
	r_PtxU16Register21 = r_bPtxPredicate16 ? r_PtxU16Register2 : 0;				   // PTX L327
L__BB44_29:																		   // PTX L328
	r_bPtxPredicate18 = uint16_t(r_PtxU16Register21) == uint16_t(0);			   // PTX L329
	if (r_bPtxPredicate18)
	{
		goto L__BB44_32;
	} // PTX L330
	r_PtxRegister134 = uint32_t(-1);							   // PTX L331
	r_PtxRegister133 = Elected(r_PtxRegister134);				   // PTX L333
	r_bPtxPredicate19 = uint32_t(r_PtxRegister133) == uint32_t(0); // PTX L339
	if (r_bPtxPredicate19)
	{
		goto L__BB44_48;
	} // PTX L340
	r_PtxU64Register55 = SharedOffset(s_SharedStorage, r_PtxU64Register575); // PTX L341
	r_PtxRegister135 = uint32_t(r_PtxU64Register55);						 // PTX L342
	r_PtxU64Register54 = r_PtxU64Register574;								 // PTX L343
	r_PtxRegister137 = uint32_t(24576u /* native mbarriers */);				 // PTX L344
	r_PtxRegister136 = uint32_t(1024);										 // PTX L345
	CopyBulk(s_SharedStorage, r_PtxRegister135, r_PtxU64Register54, r_PtxRegister136,
			 r_PtxRegister137);											// PTX L347
	BarrierExpect(s_SharedStorage, r_PtxRegister137, r_PtxRegister136); // PTX L350
	goto L__BB44_48;													// PTX L352
L__BB44_32:																// PTX L353
	r_PtxU64Register576 = uint64_t(0);									// PTX L354
	if (r_bPtxPredicate15)
	{
		goto L__BB44_34;
	} // PTX L355
	r_PtxU64Register576 = SignExtendWordBits(r_PtxRegister18); // PTX L356
L__BB44_34:													   // PTX L357
	r_PtxU64Register577 = uint64_t(0);						   // PTX L358
	if (r_bPtxPredicate15)
	{
		goto L__BB44_36;
	} // PTX L359
	r_PtxU64Register56 = ShiftLeft(uint64_t(r_PtxU64Register576), uint32_t(2));		   // PTX L360
	r_PtxU64Register577 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register56); // PTX L361
L__BB44_36:																			   // PTX L362
	if (r_bPtxPredicate15)
	{
		goto L__BB44_39;
	} // PTX L363
	r_PtxRegister145 = uint32_t(-1);							   // PTX L364
	r_PtxRegister144 = Elected(r_PtxRegister145);				   // PTX L366
	r_bPtxPredicate20 = uint32_t(r_PtxRegister144) == uint32_t(0); // PTX L372
	if (r_bPtxPredicate20)
	{
		goto L__BB44_40;
	} // PTX L373
	r_PtxRegister149 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		// PTX L374
	r_PtxRegister150 = uint32_t(0u /* native shared input */);					// PTX L375
	r_PtxRegister146 = uint32_t(r_PtxRegister150) + uint32_t(r_PtxRegister149); // PTX L376
	r_PtxU64Register57 = r_PtxU64Register577;									// PTX L377
	r_PtxRegister148 = uint32_t(24576u /* native mbarriers */);					// PTX L378
	r_PtxRegister147 = uint32_t(512);											// PTX L379
	CopyBulk(s_SharedStorage, r_PtxRegister146, r_PtxU64Register57, r_PtxRegister147,
			 r_PtxRegister148);													// PTX L381
	BarrierExpect(s_SharedStorage, r_PtxRegister148, r_PtxRegister147);			// PTX L384
	goto L__BB44_40;															// PTX L386
L__BB44_39:																		// PTX L387
	r_LaneIndexAtPtx389 = uint32_t((threadIdx.x & 31u));						// PTX L389
	r_PtxRegister140 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		// PTX L391
	r_PtxRegister141 = uint32_t(0u /* native shared input */);					// PTX L392
	r_PtxRegister142 = uint32_t(r_PtxRegister141) + uint32_t(r_PtxRegister140); // PTX L393
	r_PtxRegister143 = ShiftLeft(uint32_t(r_LaneIndexAtPtx389), uint32_t(4));	// PTX L394
	r_PtxRegister139 = uint32_t(r_PtxRegister142) + uint32_t(r_PtxRegister143); // PTX L395
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister139)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L397
L__BB44_40:										 // PTX L399
	r_PtxU64Register578 = uint64_t(0);			 // PTX L400
	if (r_bPtxPredicate15)
	{
		goto L__BB44_42;
	} // PTX L401
	r_PtxRegister151 = uint32_t(r_PtxRegister18) + uint32_t(128); // PTX L402
	r_PtxU64Register578 = SignExtendWordBits(r_PtxRegister151);	  // PTX L403
L__BB44_42:														  // PTX L404
	r_PtxU64Register579 = uint64_t(0);							  // PTX L405
	if (r_bPtxPredicate15)
	{
		goto L__BB44_44;
	} // PTX L406
	r_PtxU64Register58 = ShiftLeft(uint64_t(r_PtxU64Register578), uint32_t(2));		   // PTX L407
	r_PtxU64Register579 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register58); // PTX L408
L__BB44_44:																			   // PTX L409
	if (r_bPtxPredicate15)
	{
		goto L__BB44_47;
	} // PTX L410
	r_PtxRegister160 = uint32_t(-1);							   // PTX L411
	r_PtxRegister159 = Elected(r_PtxRegister160);				   // PTX L413
	r_bPtxPredicate21 = uint32_t(r_PtxRegister159) == uint32_t(0); // PTX L419
	if (r_bPtxPredicate21)
	{
		goto L__BB44_48;
	} // PTX L420
	r_PtxRegister164 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		// PTX L421
	r_PtxRegister165 = uint32_t(0u /* native shared input */);					// PTX L422
	r_PtxRegister166 = uint32_t(r_PtxRegister165) + uint32_t(r_PtxRegister164); // PTX L423
	r_PtxRegister161 = uint32_t(r_PtxRegister166) + uint32_t(512);				// PTX L424
	r_PtxU64Register59 = r_PtxU64Register579;									// PTX L425
	r_PtxRegister163 = uint32_t(24576u /* native mbarriers */);					// PTX L426
	r_PtxRegister162 = uint32_t(512);											// PTX L427
	CopyBulk(s_SharedStorage, r_PtxRegister161, r_PtxU64Register59, r_PtxRegister162,
			 r_PtxRegister163);													// PTX L429
	BarrierExpect(s_SharedStorage, r_PtxRegister163, r_PtxRegister162);			// PTX L432
	goto L__BB44_48;															// PTX L434
L__BB44_47:																		// PTX L435
	r_LaneIndexAtPtx437 = uint32_t((threadIdx.x & 31u));						// PTX L437
	r_PtxRegister154 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		// PTX L439
	r_PtxRegister155 = uint32_t(0u /* native shared input */);					// PTX L440
	r_PtxRegister156 = uint32_t(r_PtxRegister155) + uint32_t(r_PtxRegister154); // PTX L441
	r_PtxRegister157 = ShiftLeft(uint32_t(r_LaneIndexAtPtx437), uint32_t(4));	// PTX L442
	r_PtxRegister158 = uint32_t(r_PtxRegister156) + uint32_t(r_PtxRegister157); // PTX L443
	r_PtxRegister153 = uint32_t(r_PtxRegister158) + uint32_t(512);				// PTX L444
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister153)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L446
L__BB44_48:																	 // PTX L448
	r_PtxRegister167 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(10));			 // PTX L449
	r_PtxRegister19 = r_PtxRegister167 | 32;								 // PTX L450
	r_PtxRegister20 = r_PtxRegister12 | 256;								 // PTX L451
	r_PtxRegister21 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister20); // PTX L452
	r_PtxU16Register22 = uint16_t(0);										 // PTX L453
	r_PtxU64Register580 = uint64_t(0);										 // PTX L454
	r_PtxRegister1536 = uint32_t(128);										 // PTX L455
	r_PtxRegister1537 = uint32_t(r_PtxRegister1536);						 // PTX L456
	r_PtxU64Register581 = uint64_t(r_PtxU64Register580);					 // PTX L457
	if (r_bPtxPredicate6)
	{
		goto L__BB44_50;
	} // PTX L458
	r_PtxRegister168 = r_bPtxPredicate1 ? r_PtxRegister21 : 0;								 // PTX L459
	r_PtxU64Register581 = uint64_t(r_PtxU64Register3) + uint64_t(8192);						 // PTX L460
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_PtxRegister168)) * int64_t(int32_t(4))); // PTX L461
	r_PtxU64Register580 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register60);		 // PTX L462
	r_PtxRegister1537 = uint32_t(r_PtxRegister10) + uint32_t(128);							 // PTX L463
	r_PtxRegister1536 = uint32_t(r_PtxRegister168) + uint32_t(128);							 // PTX L464
	r_PtxU16Register22 = uint16_t(1);														 // PTX L465
L__BB44_50:																					 // PTX L466
	if (r_bPtxPredicate6)
	{
		goto L__BB44_52;
	} // PTX L467
	r_PtxRegister169 = uint32_t(r_PtxRegister10) + uint32_t(128);				   // PTX L468
	r_PtxRegister170 = uint32_t(r_PtxRegister14) + uint32_t(384);				   // PTX L469
	r_bPtxPredicate22 = uint32_t(r_PtxRegister169) == uint32_t(r_PtxRegister1537); // PTX L470
	r_bPtxPredicate23 = uint32_t(r_PtxRegister170) == uint32_t(r_PtxRegister1536); // PTX L471
	r_PtxU16Register3 = r_bPtxPredicate23 ? r_PtxU16Register22 : 0;				   // PTX L472
	r_PtxU16Register22 = r_bPtxPredicate22 ? r_PtxU16Register3 : 0;				   // PTX L473
L__BB44_52:																		   // PTX L474
	r_bPtxPredicate24 = uint16_t(r_PtxU16Register22) == uint16_t(0);			   // PTX L475
	if (r_bPtxPredicate24)
	{
		goto L__BB44_55;
	} // PTX L476
	r_PtxRegister172 = uint32_t(-1);							   // PTX L477
	r_PtxRegister171 = Elected(r_PtxRegister172);				   // PTX L479
	r_bPtxPredicate25 = uint32_t(r_PtxRegister171) == uint32_t(0); // PTX L485
	if (r_bPtxPredicate25)
	{
		goto L__BB44_71;
	} // PTX L486
	r_PtxU64Register62 = SharedOffset(s_SharedStorage, r_PtxU64Register581); // PTX L487
	r_PtxRegister173 = uint32_t(r_PtxU64Register62);						 // PTX L488
	r_PtxU64Register61 = r_PtxU64Register580;								 // PTX L489
	r_PtxRegister176 = uint32_t(24576u /* native mbarriers */);				 // PTX L490
	r_PtxRegister175 = uint32_t(r_PtxRegister176) + uint32_t(8);			 // PTX L491
	r_PtxRegister174 = uint32_t(1024);										 // PTX L492
	CopyBulk(s_SharedStorage, r_PtxRegister173, r_PtxU64Register61, r_PtxRegister174,
			 r_PtxRegister175);											// PTX L494
	BarrierExpect(s_SharedStorage, r_PtxRegister175, r_PtxRegister174); // PTX L497
	goto L__BB44_71;													// PTX L499
L__BB44_55:																// PTX L500
	r_PtxU64Register582 = uint64_t(0);									// PTX L501
	if (r_bPtxPredicate6)
	{
		goto L__BB44_57;
	} // PTX L502
	r_PtxU64Register582 = SignExtendWordBits(r_PtxRegister21); // PTX L503
L__BB44_57:													   // PTX L504
	r_PtxU64Register583 = uint64_t(0);						   // PTX L505
	if (r_bPtxPredicate6)
	{
		goto L__BB44_59;
	} // PTX L506
	r_PtxU64Register63 = ShiftLeft(uint64_t(r_PtxU64Register582), uint32_t(2));		   // PTX L507
	r_PtxU64Register583 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register63); // PTX L508
L__BB44_59:																			   // PTX L509
	r_PtxRegister177 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));			   // PTX L510
	r_PtxRegister178 = uint32_t(0u /* native shared input */);						   // PTX L511
	r_PtxRegister22 = uint32_t(r_PtxRegister178) + uint32_t(r_PtxRegister177);		   // PTX L512
	if (r_bPtxPredicate6)
	{
		goto L__BB44_62;
	} // PTX L513
	r_PtxRegister184 = uint32_t(-1);							   // PTX L514
	r_PtxRegister183 = Elected(r_PtxRegister184);				   // PTX L516
	r_bPtxPredicate26 = uint32_t(r_PtxRegister183) == uint32_t(0); // PTX L522
	if (r_bPtxPredicate26)
	{
		goto L__BB44_63;
	} // PTX L523
	r_PtxRegister185 = uint32_t(r_PtxRegister22) + uint32_t(8192); // PTX L524
	r_PtxU64Register64 = r_PtxU64Register583;					   // PTX L525
	r_PtxRegister188 = uint32_t(24576u /* native mbarriers */);	   // PTX L526
	r_PtxRegister187 = uint32_t(r_PtxRegister188) + uint32_t(8);   // PTX L527
	r_PtxRegister186 = uint32_t(512);							   // PTX L528
	CopyBulk(s_SharedStorage, r_PtxRegister185, r_PtxU64Register64, r_PtxRegister186,
			 r_PtxRegister187);												   // PTX L530
	BarrierExpect(s_SharedStorage, r_PtxRegister187, r_PtxRegister186);		   // PTX L533
	goto L__BB44_63;														   // PTX L535
L__BB44_62:																	   // PTX L536
	r_LaneIndexAtPtx538 = uint32_t((threadIdx.x & 31u));					   // PTX L538
	r_PtxRegister181 = ShiftLeft(uint32_t(r_LaneIndexAtPtx538), uint32_t(4));  // PTX L540
	r_PtxRegister182 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister181); // PTX L541
	r_PtxRegister180 = uint32_t(r_PtxRegister182) + uint32_t(8192);			   // PTX L542
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister180)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L544
L__BB44_63:										 // PTX L546
	r_PtxU64Register584 = uint64_t(0);			 // PTX L547
	if (r_bPtxPredicate6)
	{
		goto L__BB44_65;
	} // PTX L548
	r_PtxRegister189 = uint32_t(r_PtxRegister14) + uint32_t(384); // PTX L549
	r_PtxU64Register584 = SignExtendWordBits(r_PtxRegister189);	  // PTX L550
L__BB44_65:														  // PTX L551
	r_PtxU64Register585 = uint64_t(0);							  // PTX L552
	if (r_bPtxPredicate6)
	{
		goto L__BB44_67;
	} // PTX L553
	r_PtxU64Register65 = ShiftLeft(uint64_t(r_PtxU64Register584), uint32_t(2));		   // PTX L554
	r_PtxU64Register585 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register65); // PTX L555
L__BB44_67:																			   // PTX L556
	if (r_bPtxPredicate6)
	{
		goto L__BB44_70;
	} // PTX L557
	r_PtxRegister195 = uint32_t(-1);							   // PTX L558
	r_PtxRegister194 = Elected(r_PtxRegister195);				   // PTX L560
	r_bPtxPredicate27 = uint32_t(r_PtxRegister194) == uint32_t(0); // PTX L566
	if (r_bPtxPredicate27)
	{
		goto L__BB44_71;
	} // PTX L567
	r_PtxRegister196 = uint32_t(r_PtxRegister22) + uint32_t(8704); // PTX L568
	r_PtxU64Register66 = r_PtxU64Register585;					   // PTX L569
	r_PtxRegister199 = uint32_t(24576u /* native mbarriers */);	   // PTX L570
	r_PtxRegister198 = uint32_t(r_PtxRegister199) + uint32_t(8);   // PTX L571
	r_PtxRegister197 = uint32_t(512);							   // PTX L572
	CopyBulk(s_SharedStorage, r_PtxRegister196, r_PtxU64Register66, r_PtxRegister197,
			 r_PtxRegister198);												   // PTX L574
	BarrierExpect(s_SharedStorage, r_PtxRegister198, r_PtxRegister197);		   // PTX L577
	goto L__BB44_71;														   // PTX L579
L__BB44_70:																	   // PTX L580
	r_LaneIndexAtPtx582 = uint32_t((threadIdx.x & 31u));					   // PTX L582
	r_PtxRegister192 = ShiftLeft(uint32_t(r_LaneIndexAtPtx582), uint32_t(4));  // PTX L584
	r_PtxRegister193 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister192); // PTX L585
	r_PtxRegister191 = uint32_t(r_PtxRegister193) + uint32_t(8704);			   // PTX L586
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister191)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L588
L__BB44_71:																	 // PTX L590
	r_PtxRegister23 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister20); // PTX L591
	r_PtxU16Register23 = uint16_t(0);										 // PTX L592
	r_PtxU64Register586 = uint64_t(0);										 // PTX L593
	r_PtxRegister1538 = uint32_t(128);										 // PTX L594
	r_PtxRegister1539 = uint32_t(r_PtxRegister1538);						 // PTX L595
	r_PtxU64Register587 = uint64_t(r_PtxU64Register586);					 // PTX L596
	if (r_bPtxPredicate15)
	{
		goto L__BB44_73;
	} // PTX L597
	r_PtxRegister200 = r_bPtxPredicate2 ? r_PtxRegister23 : 0;								 // PTX L598
	r_PtxU64Register587 = uint64_t(r_PtxU64Register3) + uint64_t(12288);					 // PTX L599
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_PtxRegister200)) * int64_t(int32_t(4))); // PTX L600
	r_PtxU64Register586 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register67);		 // PTX L601
	r_PtxRegister1539 = uint32_t(r_PtxRegister16) + uint32_t(128);							 // PTX L602
	r_PtxRegister1538 = uint32_t(r_PtxRegister200) + uint32_t(128);							 // PTX L603
	r_PtxU16Register23 = uint16_t(1);														 // PTX L604
L__BB44_73:																					 // PTX L605
	if (r_bPtxPredicate15)
	{
		goto L__BB44_75;
	} // PTX L606
	r_PtxRegister201 = uint32_t(r_PtxRegister16) + uint32_t(128);				   // PTX L607
	r_PtxRegister202 = uint32_t(r_PtxRegister18) + uint32_t(384);				   // PTX L608
	r_bPtxPredicate28 = uint32_t(r_PtxRegister201) == uint32_t(r_PtxRegister1539); // PTX L609
	r_bPtxPredicate29 = uint32_t(r_PtxRegister202) == uint32_t(r_PtxRegister1538); // PTX L610
	r_PtxU16Register4 = r_bPtxPredicate29 ? r_PtxU16Register23 : 0;				   // PTX L611
	r_PtxU16Register23 = r_bPtxPredicate28 ? r_PtxU16Register4 : 0;				   // PTX L612
L__BB44_75:																		   // PTX L613
	r_bPtxPredicate30 = uint16_t(r_PtxU16Register23) == uint16_t(0);			   // PTX L614
	if (r_bPtxPredicate30)
	{
		goto L__BB44_78;
	} // PTX L615
	r_PtxRegister204 = uint32_t(-1);							   // PTX L616
	r_PtxRegister203 = Elected(r_PtxRegister204);				   // PTX L618
	r_bPtxPredicate31 = uint32_t(r_PtxRegister203) == uint32_t(0); // PTX L624
	if (r_bPtxPredicate31)
	{
		goto L__BB44_94;
	} // PTX L625
	r_PtxU64Register69 = SharedOffset(s_SharedStorage, r_PtxU64Register587); // PTX L626
	r_PtxRegister205 = uint32_t(r_PtxU64Register69);						 // PTX L627
	r_PtxU64Register68 = r_PtxU64Register586;								 // PTX L628
	r_PtxRegister208 = uint32_t(24576u /* native mbarriers */);				 // PTX L629
	r_PtxRegister207 = uint32_t(r_PtxRegister208) + uint32_t(8);			 // PTX L630
	r_PtxRegister206 = uint32_t(1024);										 // PTX L631
	CopyBulk(s_SharedStorage, r_PtxRegister205, r_PtxU64Register68, r_PtxRegister206,
			 r_PtxRegister207);											// PTX L633
	BarrierExpect(s_SharedStorage, r_PtxRegister207, r_PtxRegister206); // PTX L636
	goto L__BB44_94;													// PTX L638
L__BB44_78:																// PTX L639
	r_PtxU64Register588 = uint64_t(0);									// PTX L640
	if (r_bPtxPredicate15)
	{
		goto L__BB44_80;
	} // PTX L641
	r_PtxU64Register588 = SignExtendWordBits(r_PtxRegister23); // PTX L642
L__BB44_80:													   // PTX L643
	r_PtxU64Register589 = uint64_t(0);						   // PTX L644
	if (r_bPtxPredicate15)
	{
		goto L__BB44_82;
	} // PTX L645
	r_PtxU64Register70 = ShiftLeft(uint64_t(r_PtxU64Register588), uint32_t(2));		   // PTX L646
	r_PtxU64Register589 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register70); // PTX L647
L__BB44_82:																			   // PTX L648
	r_PtxRegister209 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));			   // PTX L649
	r_PtxRegister210 = uint32_t(0u /* native shared input */);						   // PTX L650
	r_PtxRegister24 = uint32_t(r_PtxRegister210) + uint32_t(r_PtxRegister209);		   // PTX L651
	if (r_bPtxPredicate15)
	{
		goto L__BB44_85;
	} // PTX L652
	r_PtxRegister216 = uint32_t(-1);							   // PTX L653
	r_PtxRegister215 = Elected(r_PtxRegister216);				   // PTX L655
	r_bPtxPredicate32 = uint32_t(r_PtxRegister215) == uint32_t(0); // PTX L661
	if (r_bPtxPredicate32)
	{
		goto L__BB44_86;
	} // PTX L662
	r_PtxRegister217 = uint32_t(r_PtxRegister24) + uint32_t(8192); // PTX L663
	r_PtxU64Register71 = r_PtxU64Register589;					   // PTX L664
	r_PtxRegister220 = uint32_t(24576u /* native mbarriers */);	   // PTX L665
	r_PtxRegister219 = uint32_t(r_PtxRegister220) + uint32_t(8);   // PTX L666
	r_PtxRegister218 = uint32_t(512);							   // PTX L667
	CopyBulk(s_SharedStorage, r_PtxRegister217, r_PtxU64Register71, r_PtxRegister218,
			 r_PtxRegister219);												   // PTX L669
	BarrierExpect(s_SharedStorage, r_PtxRegister219, r_PtxRegister218);		   // PTX L672
	goto L__BB44_86;														   // PTX L674
L__BB44_85:																	   // PTX L675
	r_LaneIndexAtPtx677 = uint32_t((threadIdx.x & 31u));					   // PTX L677
	r_PtxRegister213 = ShiftLeft(uint32_t(r_LaneIndexAtPtx677), uint32_t(4));  // PTX L679
	r_PtxRegister214 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister213); // PTX L680
	r_PtxRegister212 = uint32_t(r_PtxRegister214) + uint32_t(8192);			   // PTX L681
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister212)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L683
L__BB44_86:										 // PTX L685
	r_PtxU64Register590 = uint64_t(0);			 // PTX L686
	if (r_bPtxPredicate15)
	{
		goto L__BB44_88;
	} // PTX L687
	r_PtxRegister221 = uint32_t(r_PtxRegister18) + uint32_t(384); // PTX L688
	r_PtxU64Register590 = SignExtendWordBits(r_PtxRegister221);	  // PTX L689
L__BB44_88:														  // PTX L690
	r_PtxU64Register591 = uint64_t(0);							  // PTX L691
	if (r_bPtxPredicate15)
	{
		goto L__BB44_90;
	} // PTX L692
	r_PtxU64Register72 = ShiftLeft(uint64_t(r_PtxU64Register590), uint32_t(2));		   // PTX L693
	r_PtxU64Register591 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register72); // PTX L694
L__BB44_90:																			   // PTX L695
	if (r_bPtxPredicate15)
	{
		goto L__BB44_93;
	} // PTX L696
	r_PtxRegister227 = uint32_t(-1);							   // PTX L697
	r_PtxRegister226 = Elected(r_PtxRegister227);				   // PTX L699
	r_bPtxPredicate33 = uint32_t(r_PtxRegister226) == uint32_t(0); // PTX L705
	if (r_bPtxPredicate33)
	{
		goto L__BB44_94;
	} // PTX L706
	r_PtxRegister228 = uint32_t(r_PtxRegister24) + uint32_t(8704); // PTX L707
	r_PtxU64Register73 = r_PtxU64Register591;					   // PTX L708
	r_PtxRegister231 = uint32_t(24576u /* native mbarriers */);	   // PTX L709
	r_PtxRegister230 = uint32_t(r_PtxRegister231) + uint32_t(8);   // PTX L710
	r_PtxRegister229 = uint32_t(512);							   // PTX L711
	CopyBulk(s_SharedStorage, r_PtxRegister228, r_PtxU64Register73, r_PtxRegister229,
			 r_PtxRegister230);												   // PTX L713
	BarrierExpect(s_SharedStorage, r_PtxRegister230, r_PtxRegister229);		   // PTX L716
	goto L__BB44_94;														   // PTX L718
L__BB44_93:																	   // PTX L719
	r_LaneIndexAtPtx721 = uint32_t((threadIdx.x & 31u));					   // PTX L721
	r_PtxRegister224 = ShiftLeft(uint32_t(r_LaneIndexAtPtx721), uint32_t(4));  // PTX L723
	r_PtxRegister225 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister224); // PTX L724
	r_PtxRegister223 = uint32_t(r_PtxRegister225) + uint32_t(8704);			   // PTX L725
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister223)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L727
L__BB44_94:																	 // PTX L729
	r_PtxRegister232 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(3));	 // PTX L730
	r_PtxRegister25 = uint32_t(r_PtxRegister232) + uint32_t(256);			 // PTX L731
	r_PtxRegister26 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister25); // PTX L732
	r_PtxU16Register24 = uint16_t(0);										 // PTX L733
	r_PtxU64Register592 = uint64_t(0);										 // PTX L734
	r_PtxRegister1540 = uint32_t(128);										 // PTX L735
	r_PtxRegister1541 = uint32_t(r_PtxRegister1540);						 // PTX L736
	r_PtxU64Register593 = uint64_t(r_PtxU64Register592);					 // PTX L737
	if (r_bPtxPredicate6)
	{
		goto L__BB44_96;
	} // PTX L738
	r_PtxRegister233 = r_bPtxPredicate1 ? r_PtxRegister26 : 0;								 // PTX L739
	r_PtxU64Register593 = uint64_t(r_PtxU64Register3) + uint64_t(16384);					 // PTX L740
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister233)) * int64_t(int32_t(4))); // PTX L741
	r_PtxU64Register592 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register74);		 // PTX L742
	r_PtxRegister1541 = uint32_t(r_PtxRegister10) + uint32_t(128);							 // PTX L743
	r_PtxRegister1540 = uint32_t(r_PtxRegister233) + uint32_t(128);							 // PTX L744
	r_PtxU16Register24 = uint16_t(1);														 // PTX L745
L__BB44_96:																					 // PTX L746
	if (r_bPtxPredicate6)
	{
		goto L__BB44_98;
	} // PTX L747
	r_PtxRegister234 = uint32_t(r_PtxRegister10) + uint32_t(128);				   // PTX L748
	r_PtxRegister235 = uint32_t(r_PtxRegister14) + uint32_t(640);				   // PTX L749
	r_bPtxPredicate34 = uint32_t(r_PtxRegister234) == uint32_t(r_PtxRegister1541); // PTX L750
	r_bPtxPredicate35 = uint32_t(r_PtxRegister235) == uint32_t(r_PtxRegister1540); // PTX L751
	r_PtxU16Register5 = r_bPtxPredicate35 ? r_PtxU16Register24 : 0;				   // PTX L752
	r_PtxU16Register24 = r_bPtxPredicate34 ? r_PtxU16Register5 : 0;				   // PTX L753
L__BB44_98:																		   // PTX L754
	r_bPtxPredicate36 = uint16_t(r_PtxU16Register24) == uint16_t(0);			   // PTX L755
	if (r_bPtxPredicate36)
	{
		goto L__BB44_101;
	} // PTX L756
	r_PtxRegister237 = uint32_t(-1);							   // PTX L757
	r_PtxRegister236 = Elected(r_PtxRegister237);				   // PTX L759
	r_bPtxPredicate37 = uint32_t(r_PtxRegister236) == uint32_t(0); // PTX L765
	if (r_bPtxPredicate37)
	{
		goto L__BB44_117;
	} // PTX L766
	r_PtxU64Register76 = SharedOffset(s_SharedStorage, r_PtxU64Register593); // PTX L767
	r_PtxRegister238 = uint32_t(r_PtxU64Register76);						 // PTX L768
	r_PtxU64Register75 = r_PtxU64Register592;								 // PTX L769
	r_PtxRegister241 = uint32_t(24576u /* native mbarriers */);				 // PTX L770
	r_PtxRegister240 = uint32_t(r_PtxRegister241) + uint32_t(16);			 // PTX L771
	r_PtxRegister239 = uint32_t(1024);										 // PTX L772
	CopyBulk(s_SharedStorage, r_PtxRegister238, r_PtxU64Register75, r_PtxRegister239,
			 r_PtxRegister240);											// PTX L774
	BarrierExpect(s_SharedStorage, r_PtxRegister240, r_PtxRegister239); // PTX L777
	goto L__BB44_117;													// PTX L779
L__BB44_101:															// PTX L780
	r_PtxU64Register594 = uint64_t(0);									// PTX L781
	if (r_bPtxPredicate6)
	{
		goto L__BB44_103;
	} // PTX L782
	r_PtxU64Register594 = SignExtendWordBits(r_PtxRegister26); // PTX L783
L__BB44_103:												   // PTX L784
	r_PtxU64Register595 = uint64_t(0);						   // PTX L785
	if (r_bPtxPredicate6)
	{
		goto L__BB44_105;
	} // PTX L786
	r_PtxU64Register77 = ShiftLeft(uint64_t(r_PtxU64Register594), uint32_t(2));		   // PTX L787
	r_PtxU64Register595 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register77); // PTX L788
L__BB44_105:																		   // PTX L789
	r_PtxRegister242 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));			   // PTX L790
	r_PtxRegister243 = uint32_t(0u /* native shared input */);						   // PTX L791
	r_PtxRegister27 = uint32_t(r_PtxRegister243) + uint32_t(r_PtxRegister242);		   // PTX L792
	if (r_bPtxPredicate6)
	{
		goto L__BB44_108;
	} // PTX L793
	r_PtxRegister249 = uint32_t(-1);							   // PTX L794
	r_PtxRegister248 = Elected(r_PtxRegister249);				   // PTX L796
	r_bPtxPredicate38 = uint32_t(r_PtxRegister248) == uint32_t(0); // PTX L802
	if (r_bPtxPredicate38)
	{
		goto L__BB44_109;
	} // PTX L803
	r_PtxRegister250 = uint32_t(r_PtxRegister27) + uint32_t(16384); // PTX L804
	r_PtxU64Register78 = r_PtxU64Register595;						// PTX L805
	r_PtxRegister253 = uint32_t(24576u /* native mbarriers */);		// PTX L806
	r_PtxRegister252 = uint32_t(r_PtxRegister253) + uint32_t(16);	// PTX L807
	r_PtxRegister251 = uint32_t(512);								// PTX L808
	CopyBulk(s_SharedStorage, r_PtxRegister250, r_PtxU64Register78, r_PtxRegister251,
			 r_PtxRegister252);												   // PTX L810
	BarrierExpect(s_SharedStorage, r_PtxRegister252, r_PtxRegister251);		   // PTX L813
	goto L__BB44_109;														   // PTX L815
L__BB44_108:																   // PTX L816
	r_LaneIndexAtPtx818 = uint32_t((threadIdx.x & 31u));					   // PTX L818
	r_PtxRegister246 = ShiftLeft(uint32_t(r_LaneIndexAtPtx818), uint32_t(4));  // PTX L820
	r_PtxRegister247 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister246); // PTX L821
	r_PtxRegister245 = uint32_t(r_PtxRegister247) + uint32_t(16384);		   // PTX L822
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister245)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L824
L__BB44_109:									 // PTX L826
	r_PtxU64Register596 = uint64_t(0);			 // PTX L827
	if (r_bPtxPredicate6)
	{
		goto L__BB44_111;
	} // PTX L828
	r_PtxRegister254 = uint32_t(r_PtxRegister14) + uint32_t(640); // PTX L829
	r_PtxU64Register596 = SignExtendWordBits(r_PtxRegister254);	  // PTX L830
L__BB44_111:													  // PTX L831
	r_PtxU64Register597 = uint64_t(0);							  // PTX L832
	if (r_bPtxPredicate6)
	{
		goto L__BB44_113;
	} // PTX L833
	r_PtxU64Register79 = ShiftLeft(uint64_t(r_PtxU64Register596), uint32_t(2));		   // PTX L834
	r_PtxU64Register597 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register79); // PTX L835
L__BB44_113:																		   // PTX L836
	if (r_bPtxPredicate6)
	{
		goto L__BB44_116;
	} // PTX L837
	r_PtxRegister260 = uint32_t(-1);							   // PTX L838
	r_PtxRegister259 = Elected(r_PtxRegister260);				   // PTX L840
	r_bPtxPredicate39 = uint32_t(r_PtxRegister259) == uint32_t(0); // PTX L846
	if (r_bPtxPredicate39)
	{
		goto L__BB44_117;
	} // PTX L847
	r_PtxRegister261 = uint32_t(r_PtxRegister27) + uint32_t(16896); // PTX L848
	r_PtxU64Register80 = r_PtxU64Register597;						// PTX L849
	r_PtxRegister264 = uint32_t(24576u /* native mbarriers */);		// PTX L850
	r_PtxRegister263 = uint32_t(r_PtxRegister264) + uint32_t(16);	// PTX L851
	r_PtxRegister262 = uint32_t(512);								// PTX L852
	CopyBulk(s_SharedStorage, r_PtxRegister261, r_PtxU64Register80, r_PtxRegister262,
			 r_PtxRegister263);												   // PTX L854
	BarrierExpect(s_SharedStorage, r_PtxRegister263, r_PtxRegister262);		   // PTX L857
	goto L__BB44_117;														   // PTX L859
L__BB44_116:																   // PTX L860
	r_LaneIndexAtPtx862 = uint32_t((threadIdx.x & 31u));					   // PTX L862
	r_PtxRegister257 = ShiftLeft(uint32_t(r_LaneIndexAtPtx862), uint32_t(4));  // PTX L864
	r_PtxRegister258 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister257); // PTX L865
	r_PtxRegister256 = uint32_t(r_PtxRegister258) + uint32_t(16896);		   // PTX L866
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister256)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L868
L__BB44_117:																 // PTX L870
	r_PtxRegister28 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister25); // PTX L871
	r_PtxU16Register25 = uint16_t(0);										 // PTX L872
	r_PtxU64Register598 = uint64_t(0);										 // PTX L873
	r_PtxRegister1542 = uint32_t(128);										 // PTX L874
	r_PtxRegister1543 = uint32_t(r_PtxRegister1542);						 // PTX L875
	r_PtxU64Register599 = uint64_t(r_PtxU64Register598);					 // PTX L876
	if (r_bPtxPredicate15)
	{
		goto L__BB44_119;
	} // PTX L877
	r_PtxRegister265 = r_bPtxPredicate2 ? r_PtxRegister28 : 0;								 // PTX L878
	r_PtxU64Register599 = uint64_t(r_PtxU64Register3) + uint64_t(20480);					 // PTX L879
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister265)) * int64_t(int32_t(4))); // PTX L880
	r_PtxU64Register598 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register81);		 // PTX L881
	r_PtxRegister1543 = uint32_t(r_PtxRegister16) + uint32_t(128);							 // PTX L882
	r_PtxRegister1542 = uint32_t(r_PtxRegister265) + uint32_t(128);							 // PTX L883
	r_PtxU16Register25 = uint16_t(1);														 // PTX L884
L__BB44_119:																				 // PTX L885
	if (r_bPtxPredicate15)
	{
		goto L__BB44_121;
	} // PTX L886
	r_PtxRegister266 = uint32_t(r_PtxRegister16) + uint32_t(128);				   // PTX L887
	r_PtxRegister267 = uint32_t(r_PtxRegister18) + uint32_t(640);				   // PTX L888
	r_bPtxPredicate40 = uint32_t(r_PtxRegister266) == uint32_t(r_PtxRegister1543); // PTX L889
	r_bPtxPredicate41 = uint32_t(r_PtxRegister267) == uint32_t(r_PtxRegister1542); // PTX L890
	r_PtxU16Register6 = r_bPtxPredicate41 ? r_PtxU16Register25 : 0;				   // PTX L891
	r_PtxU16Register25 = r_bPtxPredicate40 ? r_PtxU16Register6 : 0;				   // PTX L892
L__BB44_121:																	   // PTX L893
	r_bPtxPredicate42 = uint16_t(r_PtxU16Register25) == uint16_t(0);			   // PTX L894
	if (r_bPtxPredicate42)
	{
		goto L__BB44_124;
	} // PTX L895
	r_PtxRegister269 = uint32_t(-1);							   // PTX L896
	r_PtxRegister268 = Elected(r_PtxRegister269);				   // PTX L898
	r_bPtxPredicate43 = uint32_t(r_PtxRegister268) == uint32_t(0); // PTX L904
	if (r_bPtxPredicate43)
	{
		goto L__BB44_140;
	} // PTX L905
	r_PtxU64Register83 = SharedOffset(s_SharedStorage, r_PtxU64Register599); // PTX L906
	r_PtxRegister270 = uint32_t(r_PtxU64Register83);						 // PTX L907
	r_PtxU64Register82 = r_PtxU64Register598;								 // PTX L908
	r_PtxRegister273 = uint32_t(24576u /* native mbarriers */);				 // PTX L909
	r_PtxRegister272 = uint32_t(r_PtxRegister273) + uint32_t(16);			 // PTX L910
	r_PtxRegister271 = uint32_t(1024);										 // PTX L911
	CopyBulk(s_SharedStorage, r_PtxRegister270, r_PtxU64Register82, r_PtxRegister271,
			 r_PtxRegister272);											// PTX L913
	BarrierExpect(s_SharedStorage, r_PtxRegister272, r_PtxRegister271); // PTX L916
	goto L__BB44_140;													// PTX L918
L__BB44_124:															// PTX L919
	r_PtxU64Register600 = uint64_t(0);									// PTX L920
	if (r_bPtxPredicate15)
	{
		goto L__BB44_126;
	} // PTX L921
	r_PtxU64Register600 = SignExtendWordBits(r_PtxRegister28); // PTX L922
L__BB44_126:												   // PTX L923
	r_PtxU64Register601 = uint64_t(0);						   // PTX L924
	if (r_bPtxPredicate15)
	{
		goto L__BB44_128;
	} // PTX L925
	r_PtxU64Register84 = ShiftLeft(uint64_t(r_PtxU64Register600), uint32_t(2));		   // PTX L926
	r_PtxU64Register601 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register84); // PTX L927
L__BB44_128:																		   // PTX L928
	r_PtxRegister274 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));			   // PTX L929
	r_PtxRegister275 = uint32_t(0u /* native shared input */);						   // PTX L930
	r_PtxRegister29 = uint32_t(r_PtxRegister275) + uint32_t(r_PtxRegister274);		   // PTX L931
	if (r_bPtxPredicate15)
	{
		goto L__BB44_131;
	} // PTX L932
	r_PtxRegister281 = uint32_t(-1);							   // PTX L933
	r_PtxRegister280 = Elected(r_PtxRegister281);				   // PTX L935
	r_bPtxPredicate44 = uint32_t(r_PtxRegister280) == uint32_t(0); // PTX L941
	if (r_bPtxPredicate44)
	{
		goto L__BB44_132;
	} // PTX L942
	r_PtxRegister282 = uint32_t(r_PtxRegister29) + uint32_t(16384); // PTX L943
	r_PtxU64Register85 = r_PtxU64Register601;						// PTX L944
	r_PtxRegister285 = uint32_t(24576u /* native mbarriers */);		// PTX L945
	r_PtxRegister284 = uint32_t(r_PtxRegister285) + uint32_t(16);	// PTX L946
	r_PtxRegister283 = uint32_t(512);								// PTX L947
	CopyBulk(s_SharedStorage, r_PtxRegister282, r_PtxU64Register85, r_PtxRegister283,
			 r_PtxRegister284);												   // PTX L949
	BarrierExpect(s_SharedStorage, r_PtxRegister284, r_PtxRegister283);		   // PTX L952
	goto L__BB44_132;														   // PTX L954
L__BB44_131:																   // PTX L955
	r_LaneIndexAtPtx957 = uint32_t((threadIdx.x & 31u));					   // PTX L957
	r_PtxRegister278 = ShiftLeft(uint32_t(r_LaneIndexAtPtx957), uint32_t(4));  // PTX L959
	r_PtxRegister279 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister278); // PTX L960
	r_PtxRegister277 = uint32_t(r_PtxRegister279) + uint32_t(16384);		   // PTX L961
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister277)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L963
L__BB44_132:									 // PTX L965
	r_PtxU64Register602 = uint64_t(0);			 // PTX L966
	if (r_bPtxPredicate15)
	{
		goto L__BB44_134;
	} // PTX L967
	r_PtxRegister286 = uint32_t(r_PtxRegister18) + uint32_t(640); // PTX L968
	r_PtxU64Register602 = SignExtendWordBits(r_PtxRegister286);	  // PTX L969
L__BB44_134:													  // PTX L970
	r_PtxU64Register603 = uint64_t(0);							  // PTX L971
	if (r_bPtxPredicate15)
	{
		goto L__BB44_136;
	} // PTX L972
	r_PtxU64Register86 = ShiftLeft(uint64_t(r_PtxU64Register602), uint32_t(2));		   // PTX L973
	r_PtxU64Register603 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register86); // PTX L974
L__BB44_136:																		   // PTX L975
	if (r_bPtxPredicate15)
	{
		goto L__BB44_139;
	} // PTX L976
	r_PtxRegister292 = uint32_t(-1);							   // PTX L977
	r_PtxRegister291 = Elected(r_PtxRegister292);				   // PTX L979
	r_bPtxPredicate45 = uint32_t(r_PtxRegister291) == uint32_t(0); // PTX L985
	if (r_bPtxPredicate45)
	{
		goto L__BB44_140;
	} // PTX L986
	r_PtxRegister293 = uint32_t(r_PtxRegister29) + uint32_t(16896); // PTX L987
	r_PtxU64Register87 = r_PtxU64Register603;						// PTX L988
	r_PtxRegister296 = uint32_t(24576u /* native mbarriers */);		// PTX L989
	r_PtxRegister295 = uint32_t(r_PtxRegister296) + uint32_t(16);	// PTX L990
	r_PtxRegister294 = uint32_t(512);								// PTX L991
	CopyBulk(s_SharedStorage, r_PtxRegister293, r_PtxU64Register87, r_PtxRegister294,
			 r_PtxRegister295);												   // PTX L993
	BarrierExpect(s_SharedStorage, r_PtxRegister295, r_PtxRegister294);		   // PTX L996
	goto L__BB44_140;														   // PTX L998
L__BB44_139:																   // PTX L999
	r_LaneIndexAtPtx1001 = uint32_t((threadIdx.x & 31u));					   // PTX L1001
	r_PtxRegister289 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1001), uint32_t(4)); // PTX L1003
	r_PtxRegister290 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister289); // PTX L1004
	r_PtxRegister288 = uint32_t(r_PtxRegister290) + uint32_t(16896);		   // PTX L1005
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister288)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);				// PTX L1007
L__BB44_140:													// PTX L1009
	r_PtxRegister297 = uint32_t(24576u /* native mbarriers */); // PTX L1010
	r_PtxRegister298 = uint32_t(1);								// PTX L1011
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register88 = BarrierArrive(s_SharedStorage, r_PtxRegister297, r_PtxRegister298); // PTX L1013
L__BB44_141:																				 // PTX L1015
	r_PtxRegister300 = uint32_t(24576u /* native mbarriers */);								 // PTX L1016
	r_PtxRegister299 = BarrierReady(s_SharedStorage, r_PtxRegister300, r_PtxU64Register88);	 // PTX L1018
	r_bPtxPredicate46 = uint32_t(r_PtxRegister299) == uint32_t(0);							 // PTX L1024
	if (r_bPtxPredicate46)
	{
		goto L__BB44_141;
	} // PTX L1025
	r_bPtxPredicate47 = uint32_t(r_CtaZ) != uint32_t(0);				 // PTX L1026
	r_PackedHalf2AtPtx1027R1624 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1027
	r_PackedHalf2AtPtx1028R1625 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1028
	r_PackedHalf2AtPtx1029R1626 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1029
	r_PackedHalf2AtPtx1030R1627 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1030
	r_PackedHalf2AtPtx1031R1628 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1031
	r_PackedHalf2AtPtx1032R1629 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1032
	r_PackedHalf2AtPtx1033R1630 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1033
	r_PackedHalf2AtPtx1034R1631 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1034
	r_PackedHalf2AtPtx1035R1632 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1035
	r_PackedHalf2AtPtx1036R1633 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1036
	r_PackedHalf2AtPtx1037R1634 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1037
	r_PackedHalf2AtPtx1038R1635 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1038
	r_PackedHalf2AtPtx1039R1636 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1039
	r_PackedHalf2AtPtx1040R1637 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1040
	r_PackedHalf2AtPtx1041R1638 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1041
	r_PackedHalf2AtPtx1042R1639 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1042
	r_PackedHalf2AtPtx1043R1640 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1043
	r_PackedHalf2AtPtx1044R1641 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1044
	r_PackedHalf2AtPtx1045R1642 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1045
	r_PackedHalf2AtPtx1046R1643 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1046
	r_PackedHalf2AtPtx1047R1644 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1047
	r_PackedHalf2AtPtx1048R1645 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1048
	r_PackedHalf2AtPtx1049R1646 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1049
	r_PackedHalf2AtPtx1050R1647 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1050
	r_PackedHalf2AtPtx1051R1648 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1051
	r_PackedHalf2AtPtx1052R1649 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1052
	r_PackedHalf2AtPtx1053R1650 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1053
	r_PackedHalf2AtPtx1054R1651 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1054
	r_PackedHalf2AtPtx1055R1652 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1055
	r_PackedHalf2AtPtx1056R1653 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1056
	r_PackedHalf2AtPtx1057R1654 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1057
	r_PackedHalf2AtPtx1058R1655 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1058
	r_PackedHalf2AtPtx1059R1656 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1059
	r_PackedHalf2AtPtx1060R1657 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1060
	r_PackedHalf2AtPtx1061R1658 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1061
	r_PackedHalf2AtPtx1062R1659 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1062
	r_PackedHalf2AtPtx1063R1660 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1063
	r_PackedHalf2AtPtx1064R1661 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1064
	r_PackedHalf2AtPtx1065R1662 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1065
	r_PackedHalf2AtPtx1066R1663 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1066
	r_PackedHalf2AtPtx1067R1664 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1067
	r_PackedHalf2AtPtx1068R1665 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1068
	r_PackedHalf2AtPtx1069R1666 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1069
	r_PackedHalf2AtPtx1070R1667 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1070
	r_PackedHalf2AtPtx1071R1668 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1071
	r_PackedHalf2AtPtx1072R1669 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1072
	r_PackedHalf2AtPtx1073R1670 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1073
	r_PackedHalf2AtPtx1074R1671 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1074
	r_PackedHalf2AtPtx1075R1672 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1075
	r_PackedHalf2AtPtx1076R1673 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1076
	r_PackedHalf2AtPtx1077R1674 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1077
	r_PackedHalf2AtPtx1078R1675 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1078
	r_PackedHalf2AtPtx1079R1676 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1079
	r_PackedHalf2AtPtx1080R1677 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1080
	r_PackedHalf2AtPtx1081R1678 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1081
	r_PackedHalf2AtPtx1082R1679 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1082
	r_PackedHalf2AtPtx1083R1680 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1083
	r_PackedHalf2AtPtx1084R1681 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1084
	r_PackedHalf2AtPtx1085R1682 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1085
	r_PackedHalf2AtPtx1086R1683 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1086
	r_PackedHalf2AtPtx1087R1684 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1087
	r_PackedHalf2AtPtx1088R1685 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1088
	r_PackedHalf2AtPtx1089R1686 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1089
	r_PackedHalf2AtPtx1090R1687 = uint32_t(r_PackedHalf2AtPtx4534R1800); // PTX L1090
	if (r_bPtxPredicate47)
	{
		goto L__BB44_192;
	} // PTX L1091
	r_bPtxPredicate48 = uint32_t(r_PtxRegister11) < uint32_t(31);			 // PTX L1092
	r_PtxRegister301 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));			 // PTX L1093
	r_PtxRegister302 = r_PtxRegister301 & 2044;								 // PTX L1094
	r_PtxRegister30 = uint32_t(r_PtxRegister302) + uint32_t(r_PtxRegister3); // PTX L1095
	r_PtxRegister1544 = uint32_t(0);										 // PTX L1096
	if (r_bPtxPredicate48)
	{
		goto L__BB44_145;
	} // PTX L1097
	r_bPtxPredicate49 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister4); // PTX L1098
	r_PtxRegister1544 = uint32_t(r_PtxRegister30);							 // PTX L1099
	r_PackedHalf2AtPtx1100R1545 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1100
	r_PackedHalf2AtPtx1101R1546 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1101
	r_PackedHalf2AtPtx1102R1547 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1102
	r_PackedHalf2AtPtx1103R1548 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1103
	if (r_bPtxPredicate49)
	{
		goto L__BB44_146;
	} // PTX L1104
L__BB44_145:																				 // PTX L1105
	r_PtxRegister304 = ShiftLeft(uint32_t(r_PtxRegister1544), uint32_t(13));				 // PTX L1106
	r_PtxRegister305 = uint32_t(r_PtxRegister304) + uint32_t(r_PtxRegister6);				 // PTX L1107
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister305)) * int64_t(int32_t(4))); // PTX L1108
	g_ResidualByteAddressAtPtx1109 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register90);							  // PTX L1109
	r_LaneIndexAtPtx1111 = uint32_t((threadIdx.x & 31u));										  // PTX L1111
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1111)) * int64_t(int32_t(16))); // PTX L1113
	g_ResidualByteAddressAtPtx1114 =
		uint64_t(g_ResidualByteAddressAtPtx1109) + uint64_t(r_PtxU64Register92); // PTX L1114
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1114));
		r_PackedHalf2AtPtx1100R1545 = r_Value.x;
		r_PackedHalf2AtPtx1101R1546 = r_Value.y;
		r_PackedHalf2AtPtx1102R1547 = r_Value.z;
		r_PackedHalf2AtPtx1103R1548 = r_Value.w;
	} // PTX L1116
L__BB44_146:													  // PTX L1118
	r_bPtxPredicate50 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1119
	r_PtxRegister1549 = uint32_t(0);							  // PTX L1120
	if (r_bPtxPredicate50)
	{
		goto L__BB44_148;
	} // PTX L1121
	r_bPtxPredicate51 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister4); // PTX L1122
	r_PtxRegister1549 = uint32_t(r_PtxRegister30);							 // PTX L1123
	r_PackedHalf2AtPtx1124R1550 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1124
	r_PackedHalf2AtPtx1125R1551 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1125
	r_PackedHalf2AtPtx1126R1552 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1126
	r_PackedHalf2AtPtx1127R1553 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1127
	if (r_bPtxPredicate51)
	{
		goto L__BB44_149;
	} // PTX L1128
L__BB44_148:																				 // PTX L1129
	r_PtxRegister307 = ShiftLeft(uint32_t(r_PtxRegister1549), uint32_t(13));				 // PTX L1130
	r_PtxRegister308 = uint32_t(r_PtxRegister307) + uint32_t(r_PtxRegister7);				 // PTX L1131
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister308)) * int64_t(int32_t(4))); // PTX L1132
	g_ResidualByteAddressAtPtx1133 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register94);							  // PTX L1133
	r_LaneIndexAtPtx1135 = uint32_t((threadIdx.x & 31u));										  // PTX L1135
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1135)) * int64_t(int32_t(16))); // PTX L1137
	g_ResidualByteAddressAtPtx1138 =
		uint64_t(g_ResidualByteAddressAtPtx1133) + uint64_t(r_PtxU64Register96); // PTX L1138
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1138));
		r_PackedHalf2AtPtx1124R1550 = r_Value.x;
		r_PackedHalf2AtPtx1125R1551 = r_Value.y;
		r_PackedHalf2AtPtx1126R1552 = r_Value.z;
		r_PackedHalf2AtPtx1127R1553 = r_Value.w;
	} // PTX L1140
L__BB44_149:													  // PTX L1142
	r_bPtxPredicate52 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1143
	r_PtxRegister1554 = uint32_t(0);							  // PTX L1144
	if (r_bPtxPredicate52)
	{
		goto L__BB44_151;
	} // PTX L1145
	r_bPtxPredicate53 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister4); // PTX L1146
	r_PtxRegister1554 = uint32_t(r_PtxRegister30);							 // PTX L1147
	r_PackedHalf2AtPtx1148R1555 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1148
	r_PackedHalf2AtPtx1149R1556 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1149
	r_PackedHalf2AtPtx1150R1557 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1150
	r_PackedHalf2AtPtx1151R1558 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1151
	if (r_bPtxPredicate53)
	{
		goto L__BB44_152;
	} // PTX L1152
L__BB44_151:																				 // PTX L1153
	r_PtxRegister310 = ShiftLeft(uint32_t(r_PtxRegister1554), uint32_t(13));				 // PTX L1154
	r_PtxRegister311 = uint32_t(r_PtxRegister310) + uint32_t(r_PtxRegister8);				 // PTX L1155
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister311)) * int64_t(int32_t(4))); // PTX L1156
	g_ResidualByteAddressAtPtx1157 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register98); // PTX L1157
	r_LaneIndexAtPtx1159 = uint32_t((threadIdx.x & 31u));				// PTX L1159
	r_PtxU64Register100 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1159)) * int64_t(int32_t(16))); // PTX L1161
	g_ResidualByteAddressAtPtx1162 =
		uint64_t(g_ResidualByteAddressAtPtx1157) + uint64_t(r_PtxU64Register100); // PTX L1162
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1162));
		r_PackedHalf2AtPtx1148R1555 = r_Value.x;
		r_PackedHalf2AtPtx1149R1556 = r_Value.y;
		r_PackedHalf2AtPtx1150R1557 = r_Value.z;
		r_PackedHalf2AtPtx1151R1558 = r_Value.w;
	} // PTX L1164
L__BB44_152:													  // PTX L1166
	r_bPtxPredicate54 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1167
	r_PtxRegister1559 = uint32_t(0);							  // PTX L1168
	if (r_bPtxPredicate54)
	{
		goto L__BB44_154;
	} // PTX L1169
	r_bPtxPredicate55 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister4); // PTX L1170
	r_PtxRegister1559 = uint32_t(r_PtxRegister30);							 // PTX L1171
	r_PackedHalf2AtPtx1172R1560 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1172
	r_PackedHalf2AtPtx1173R1561 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1173
	r_PackedHalf2AtPtx1174R1562 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1174
	r_PackedHalf2AtPtx1175R1563 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1175
	if (r_bPtxPredicate55)
	{
		goto L__BB44_155;
	} // PTX L1176
L__BB44_154:																				  // PTX L1177
	r_PtxRegister313 = ShiftLeft(uint32_t(r_PtxRegister1559), uint32_t(13));				  // PTX L1178
	r_PtxRegister314 = uint32_t(r_PtxRegister313) + uint32_t(r_PtxRegister9);				  // PTX L1179
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister314)) * int64_t(int32_t(4))); // PTX L1180
	g_ResidualByteAddressAtPtx1181 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register102); // PTX L1181
	r_LaneIndexAtPtx1183 = uint32_t((threadIdx.x & 31u));				 // PTX L1183
	r_PtxU64Register104 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1183)) * int64_t(int32_t(16))); // PTX L1185
	g_ResidualByteAddressAtPtx1186 =
		uint64_t(g_ResidualByteAddressAtPtx1181) + uint64_t(r_PtxU64Register104); // PTX L1186
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1186));
		r_PackedHalf2AtPtx1172R1560 = r_Value.x;
		r_PackedHalf2AtPtx1173R1561 = r_Value.y;
		r_PackedHalf2AtPtx1174R1562 = r_Value.z;
		r_PackedHalf2AtPtx1175R1563 = r_Value.w;
	} // PTX L1188
L__BB44_155:													  // PTX L1190
	r_bPtxPredicate56 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1191
	r_PtxRegister31 = uint32_t(r_PtxRegister30) + uint32_t(1);	  // PTX L1192
	r_PtxRegister1564 = uint32_t(0);							  // PTX L1193
	if (r_bPtxPredicate56)
	{
		goto L__BB44_157;
	} // PTX L1194
	r_bPtxPredicate57 = int32_t(r_PtxRegister31) >= int32_t(r_PtxRegister4); // PTX L1195
	r_PtxRegister1564 = uint32_t(r_PtxRegister31);							 // PTX L1196
	r_PackedHalf2AtPtx1197R1565 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1197
	r_PackedHalf2AtPtx1198R1566 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1198
	r_PackedHalf2AtPtx1199R1567 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1199
	r_PackedHalf2AtPtx1200R1568 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1200
	if (r_bPtxPredicate57)
	{
		goto L__BB44_158;
	} // PTX L1201
L__BB44_157:																				  // PTX L1202
	r_PtxRegister316 = ShiftLeft(uint32_t(r_PtxRegister1564), uint32_t(13));				  // PTX L1203
	r_PtxRegister317 = uint32_t(r_PtxRegister316) + uint32_t(r_PtxRegister6);				  // PTX L1204
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister317)) * int64_t(int32_t(4))); // PTX L1205
	g_ResidualByteAddressAtPtx1206 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register106); // PTX L1206
	r_LaneIndexAtPtx1208 = uint32_t((threadIdx.x & 31u));				 // PTX L1208
	r_PtxU64Register108 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1208)) * int64_t(int32_t(16))); // PTX L1210
	g_ResidualByteAddressAtPtx1211 =
		uint64_t(g_ResidualByteAddressAtPtx1206) + uint64_t(r_PtxU64Register108); // PTX L1211
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1211));
		r_PackedHalf2AtPtx1197R1565 = r_Value.x;
		r_PackedHalf2AtPtx1198R1566 = r_Value.y;
		r_PackedHalf2AtPtx1199R1567 = r_Value.z;
		r_PackedHalf2AtPtx1200R1568 = r_Value.w;
	} // PTX L1213
L__BB44_158:													  // PTX L1215
	r_bPtxPredicate58 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1216
	r_PtxRegister1569 = uint32_t(0);							  // PTX L1217
	if (r_bPtxPredicate58)
	{
		goto L__BB44_160;
	} // PTX L1218
	r_bPtxPredicate59 = int32_t(r_PtxRegister31) >= int32_t(r_PtxRegister4); // PTX L1219
	r_PtxRegister1569 = uint32_t(r_PtxRegister31);							 // PTX L1220
	r_PackedHalf2AtPtx1221R1570 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1221
	r_PackedHalf2AtPtx1222R1571 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1222
	r_PackedHalf2AtPtx1223R1572 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1223
	r_PackedHalf2AtPtx1224R1573 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1224
	if (r_bPtxPredicate59)
	{
		goto L__BB44_161;
	} // PTX L1225
L__BB44_160:																				  // PTX L1226
	r_PtxRegister319 = ShiftLeft(uint32_t(r_PtxRegister1569), uint32_t(13));				  // PTX L1227
	r_PtxRegister320 = uint32_t(r_PtxRegister319) + uint32_t(r_PtxRegister7);				  // PTX L1228
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister320)) * int64_t(int32_t(4))); // PTX L1229
	g_ResidualByteAddressAtPtx1230 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register110); // PTX L1230
	r_LaneIndexAtPtx1232 = uint32_t((threadIdx.x & 31u));				 // PTX L1232
	r_PtxU64Register112 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1232)) * int64_t(int32_t(16))); // PTX L1234
	g_ResidualByteAddressAtPtx1235 =
		uint64_t(g_ResidualByteAddressAtPtx1230) + uint64_t(r_PtxU64Register112); // PTX L1235
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1235));
		r_PackedHalf2AtPtx1221R1570 = r_Value.x;
		r_PackedHalf2AtPtx1222R1571 = r_Value.y;
		r_PackedHalf2AtPtx1223R1572 = r_Value.z;
		r_PackedHalf2AtPtx1224R1573 = r_Value.w;
	} // PTX L1237
L__BB44_161:													  // PTX L1239
	r_bPtxPredicate60 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1240
	r_PtxRegister1574 = uint32_t(0);							  // PTX L1241
	if (r_bPtxPredicate60)
	{
		goto L__BB44_163;
	} // PTX L1242
	r_bPtxPredicate61 = int32_t(r_PtxRegister31) >= int32_t(r_PtxRegister4); // PTX L1243
	r_PtxRegister1574 = uint32_t(r_PtxRegister31);							 // PTX L1244
	r_PackedHalf2AtPtx1245R1575 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1245
	r_PackedHalf2AtPtx1246R1576 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1246
	r_PackedHalf2AtPtx1247R1577 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1247
	r_PackedHalf2AtPtx1248R1578 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1248
	if (r_bPtxPredicate61)
	{
		goto L__BB44_164;
	} // PTX L1249
L__BB44_163:																				  // PTX L1250
	r_PtxRegister322 = ShiftLeft(uint32_t(r_PtxRegister1574), uint32_t(13));				  // PTX L1251
	r_PtxRegister323 = uint32_t(r_PtxRegister322) + uint32_t(r_PtxRegister8);				  // PTX L1252
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister323)) * int64_t(int32_t(4))); // PTX L1253
	g_ResidualByteAddressAtPtx1254 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register114); // PTX L1254
	r_LaneIndexAtPtx1256 = uint32_t((threadIdx.x & 31u));				 // PTX L1256
	r_PtxU64Register116 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1256)) * int64_t(int32_t(16))); // PTX L1258
	g_ResidualByteAddressAtPtx1259 =
		uint64_t(g_ResidualByteAddressAtPtx1254) + uint64_t(r_PtxU64Register116); // PTX L1259
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1259));
		r_PackedHalf2AtPtx1245R1575 = r_Value.x;
		r_PackedHalf2AtPtx1246R1576 = r_Value.y;
		r_PackedHalf2AtPtx1247R1577 = r_Value.z;
		r_PackedHalf2AtPtx1248R1578 = r_Value.w;
	} // PTX L1261
L__BB44_164:													  // PTX L1263
	r_bPtxPredicate62 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1264
	r_PtxRegister1579 = uint32_t(0);							  // PTX L1265
	if (r_bPtxPredicate62)
	{
		goto L__BB44_166;
	} // PTX L1266
	r_bPtxPredicate63 = int32_t(r_PtxRegister31) >= int32_t(r_PtxRegister4); // PTX L1267
	r_PtxRegister1579 = uint32_t(r_PtxRegister31);							 // PTX L1268
	r_PackedHalf2AtPtx1269R1580 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1269
	r_PackedHalf2AtPtx1270R1581 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1270
	r_PackedHalf2AtPtx1271R1582 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1271
	r_PackedHalf2AtPtx1272R1583 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1272
	if (r_bPtxPredicate63)
	{
		goto L__BB44_167;
	} // PTX L1273
L__BB44_166:																				  // PTX L1274
	r_PtxRegister325 = ShiftLeft(uint32_t(r_PtxRegister1579), uint32_t(13));				  // PTX L1275
	r_PtxRegister326 = uint32_t(r_PtxRegister325) + uint32_t(r_PtxRegister9);				  // PTX L1276
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister326)) * int64_t(int32_t(4))); // PTX L1277
	g_ResidualByteAddressAtPtx1278 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register118); // PTX L1278
	r_LaneIndexAtPtx1280 = uint32_t((threadIdx.x & 31u));				 // PTX L1280
	r_PtxU64Register120 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1280)) * int64_t(int32_t(16))); // PTX L1282
	g_ResidualByteAddressAtPtx1283 =
		uint64_t(g_ResidualByteAddressAtPtx1278) + uint64_t(r_PtxU64Register120); // PTX L1283
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1283));
		r_PackedHalf2AtPtx1269R1580 = r_Value.x;
		r_PackedHalf2AtPtx1270R1581 = r_Value.y;
		r_PackedHalf2AtPtx1271R1582 = r_Value.z;
		r_PackedHalf2AtPtx1272R1583 = r_Value.w;
	} // PTX L1285
L__BB44_167:													  // PTX L1287
	r_bPtxPredicate64 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1288
	r_PtxRegister32 = uint32_t(r_PtxRegister30) + uint32_t(2);	  // PTX L1289
	r_PtxRegister1584 = uint32_t(0);							  // PTX L1290
	if (r_bPtxPredicate64)
	{
		goto L__BB44_169;
	} // PTX L1291
	r_bPtxPredicate65 = int32_t(r_PtxRegister32) >= int32_t(r_PtxRegister4); // PTX L1292
	r_PtxRegister1584 = uint32_t(r_PtxRegister32);							 // PTX L1293
	r_PackedHalf2AtPtx1294R1585 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1294
	r_PackedHalf2AtPtx1295R1586 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1295
	r_PackedHalf2AtPtx1296R1587 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1296
	r_PackedHalf2AtPtx1297R1588 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1297
	if (r_bPtxPredicate65)
	{
		goto L__BB44_170;
	} // PTX L1298
L__BB44_169:																				  // PTX L1299
	r_PtxRegister328 = ShiftLeft(uint32_t(r_PtxRegister1584), uint32_t(13));				  // PTX L1300
	r_PtxRegister329 = uint32_t(r_PtxRegister328) + uint32_t(r_PtxRegister6);				  // PTX L1301
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister329)) * int64_t(int32_t(4))); // PTX L1302
	g_ResidualByteAddressAtPtx1303 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register122); // PTX L1303
	r_LaneIndexAtPtx1305 = uint32_t((threadIdx.x & 31u));				 // PTX L1305
	r_PtxU64Register124 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1305)) * int64_t(int32_t(16))); // PTX L1307
	g_ResidualByteAddressAtPtx1308 =
		uint64_t(g_ResidualByteAddressAtPtx1303) + uint64_t(r_PtxU64Register124); // PTX L1308
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1308));
		r_PackedHalf2AtPtx1294R1585 = r_Value.x;
		r_PackedHalf2AtPtx1295R1586 = r_Value.y;
		r_PackedHalf2AtPtx1296R1587 = r_Value.z;
		r_PackedHalf2AtPtx1297R1588 = r_Value.w;
	} // PTX L1310
L__BB44_170:													  // PTX L1312
	r_bPtxPredicate66 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1313
	r_PtxRegister1589 = uint32_t(0);							  // PTX L1314
	if (r_bPtxPredicate66)
	{
		goto L__BB44_172;
	} // PTX L1315
	r_bPtxPredicate67 = int32_t(r_PtxRegister32) >= int32_t(r_PtxRegister4); // PTX L1316
	r_PtxRegister1589 = uint32_t(r_PtxRegister32);							 // PTX L1317
	r_PackedHalf2AtPtx1318R1590 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1318
	r_PackedHalf2AtPtx1319R1591 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1319
	r_PackedHalf2AtPtx1320R1592 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1320
	r_PackedHalf2AtPtx1321R1593 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1321
	if (r_bPtxPredicate67)
	{
		goto L__BB44_173;
	} // PTX L1322
L__BB44_172:																				  // PTX L1323
	r_PtxRegister331 = ShiftLeft(uint32_t(r_PtxRegister1589), uint32_t(13));				  // PTX L1324
	r_PtxRegister332 = uint32_t(r_PtxRegister331) + uint32_t(r_PtxRegister7);				  // PTX L1325
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister332)) * int64_t(int32_t(4))); // PTX L1326
	g_ResidualByteAddressAtPtx1327 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register126); // PTX L1327
	r_LaneIndexAtPtx1329 = uint32_t((threadIdx.x & 31u));				 // PTX L1329
	r_PtxU64Register128 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1329)) * int64_t(int32_t(16))); // PTX L1331
	g_ResidualByteAddressAtPtx1332 =
		uint64_t(g_ResidualByteAddressAtPtx1327) + uint64_t(r_PtxU64Register128); // PTX L1332
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1332));
		r_PackedHalf2AtPtx1318R1590 = r_Value.x;
		r_PackedHalf2AtPtx1319R1591 = r_Value.y;
		r_PackedHalf2AtPtx1320R1592 = r_Value.z;
		r_PackedHalf2AtPtx1321R1593 = r_Value.w;
	} // PTX L1334
L__BB44_173:													  // PTX L1336
	r_bPtxPredicate68 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1337
	r_PtxRegister1594 = uint32_t(0);							  // PTX L1338
	if (r_bPtxPredicate68)
	{
		goto L__BB44_175;
	} // PTX L1339
	r_bPtxPredicate69 = int32_t(r_PtxRegister32) >= int32_t(r_PtxRegister4); // PTX L1340
	r_PtxRegister1594 = uint32_t(r_PtxRegister32);							 // PTX L1341
	r_PackedHalf2AtPtx1342R1595 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1342
	r_PackedHalf2AtPtx1343R1596 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1343
	r_PackedHalf2AtPtx1344R1597 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1344
	r_PackedHalf2AtPtx1345R1598 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1345
	if (r_bPtxPredicate69)
	{
		goto L__BB44_176;
	} // PTX L1346
L__BB44_175:																				  // PTX L1347
	r_PtxRegister334 = ShiftLeft(uint32_t(r_PtxRegister1594), uint32_t(13));				  // PTX L1348
	r_PtxRegister335 = uint32_t(r_PtxRegister334) + uint32_t(r_PtxRegister8);				  // PTX L1349
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister335)) * int64_t(int32_t(4))); // PTX L1350
	g_ResidualByteAddressAtPtx1351 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register130); // PTX L1351
	r_LaneIndexAtPtx1353 = uint32_t((threadIdx.x & 31u));				 // PTX L1353
	r_PtxU64Register132 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1353)) * int64_t(int32_t(16))); // PTX L1355
	g_ResidualByteAddressAtPtx1356 =
		uint64_t(g_ResidualByteAddressAtPtx1351) + uint64_t(r_PtxU64Register132); // PTX L1356
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1356));
		r_PackedHalf2AtPtx1342R1595 = r_Value.x;
		r_PackedHalf2AtPtx1343R1596 = r_Value.y;
		r_PackedHalf2AtPtx1344R1597 = r_Value.z;
		r_PackedHalf2AtPtx1345R1598 = r_Value.w;
	} // PTX L1358
L__BB44_176:													  // PTX L1360
	r_bPtxPredicate70 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1361
	r_PtxRegister1599 = uint32_t(0);							  // PTX L1362
	if (r_bPtxPredicate70)
	{
		goto L__BB44_178;
	} // PTX L1363
	r_bPtxPredicate71 = int32_t(r_PtxRegister32) >= int32_t(r_PtxRegister4); // PTX L1364
	r_PtxRegister1599 = uint32_t(r_PtxRegister32);							 // PTX L1365
	r_PackedHalf2AtPtx1366R1600 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1366
	r_PackedHalf2AtPtx1367R1601 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1367
	r_PackedHalf2AtPtx1368R1602 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1368
	r_PackedHalf2AtPtx1369R1603 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1369
	if (r_bPtxPredicate71)
	{
		goto L__BB44_179;
	} // PTX L1370
L__BB44_178:																				  // PTX L1371
	r_PtxRegister337 = ShiftLeft(uint32_t(r_PtxRegister1599), uint32_t(13));				  // PTX L1372
	r_PtxRegister338 = uint32_t(r_PtxRegister337) + uint32_t(r_PtxRegister9);				  // PTX L1373
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister338)) * int64_t(int32_t(4))); // PTX L1374
	g_ResidualByteAddressAtPtx1375 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register134); // PTX L1375
	r_LaneIndexAtPtx1377 = uint32_t((threadIdx.x & 31u));				 // PTX L1377
	r_PtxU64Register136 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1377)) * int64_t(int32_t(16))); // PTX L1379
	g_ResidualByteAddressAtPtx1380 =
		uint64_t(g_ResidualByteAddressAtPtx1375) + uint64_t(r_PtxU64Register136); // PTX L1380
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1380));
		r_PackedHalf2AtPtx1366R1600 = r_Value.x;
		r_PackedHalf2AtPtx1367R1601 = r_Value.y;
		r_PackedHalf2AtPtx1368R1602 = r_Value.z;
		r_PackedHalf2AtPtx1369R1603 = r_Value.w;
	} // PTX L1382
L__BB44_179:													  // PTX L1384
	r_bPtxPredicate72 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1385
	r_PtxRegister33 = uint32_t(r_PtxRegister30) + uint32_t(3);	  // PTX L1386
	r_PtxRegister1604 = uint32_t(0);							  // PTX L1387
	if (r_bPtxPredicate72)
	{
		goto L__BB44_181;
	} // PTX L1388
	r_bPtxPredicate73 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister4); // PTX L1389
	r_PtxRegister1604 = uint32_t(r_PtxRegister33);							 // PTX L1390
	r_PackedHalf2AtPtx1391R1605 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1391
	r_PackedHalf2AtPtx1392R1606 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1392
	r_PackedHalf2AtPtx1393R1607 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1393
	r_PackedHalf2AtPtx1394R1608 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1394
	if (r_bPtxPredicate73)
	{
		goto L__BB44_182;
	} // PTX L1395
L__BB44_181:																				  // PTX L1396
	r_PtxRegister340 = ShiftLeft(uint32_t(r_PtxRegister1604), uint32_t(13));				  // PTX L1397
	r_PtxRegister341 = uint32_t(r_PtxRegister340) + uint32_t(r_PtxRegister6);				  // PTX L1398
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister341)) * int64_t(int32_t(4))); // PTX L1399
	g_ResidualByteAddressAtPtx1400 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register138); // PTX L1400
	r_LaneIndexAtPtx1402 = uint32_t((threadIdx.x & 31u));				 // PTX L1402
	r_PtxU64Register140 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1402)) * int64_t(int32_t(16))); // PTX L1404
	g_ResidualByteAddressAtPtx1405 =
		uint64_t(g_ResidualByteAddressAtPtx1400) + uint64_t(r_PtxU64Register140); // PTX L1405
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1405));
		r_PackedHalf2AtPtx1391R1605 = r_Value.x;
		r_PackedHalf2AtPtx1392R1606 = r_Value.y;
		r_PackedHalf2AtPtx1393R1607 = r_Value.z;
		r_PackedHalf2AtPtx1394R1608 = r_Value.w;
	} // PTX L1407
L__BB44_182:													  // PTX L1409
	r_bPtxPredicate74 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1410
	r_PtxRegister1609 = uint32_t(0);							  // PTX L1411
	if (r_bPtxPredicate74)
	{
		goto L__BB44_184;
	} // PTX L1412
	r_bPtxPredicate75 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister4); // PTX L1413
	r_PtxRegister1609 = uint32_t(r_PtxRegister33);							 // PTX L1414
	r_PackedHalf2AtPtx1415R1610 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1415
	r_PackedHalf2AtPtx1416R1611 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1416
	r_PackedHalf2AtPtx1417R1612 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1417
	r_PackedHalf2AtPtx1418R1613 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1418
	if (r_bPtxPredicate75)
	{
		goto L__BB44_185;
	} // PTX L1419
L__BB44_184:																				  // PTX L1420
	r_PtxRegister343 = ShiftLeft(uint32_t(r_PtxRegister1609), uint32_t(13));				  // PTX L1421
	r_PtxRegister344 = uint32_t(r_PtxRegister343) + uint32_t(r_PtxRegister7);				  // PTX L1422
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister344)) * int64_t(int32_t(4))); // PTX L1423
	g_ResidualByteAddressAtPtx1424 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register142); // PTX L1424
	r_LaneIndexAtPtx1426 = uint32_t((threadIdx.x & 31u));				 // PTX L1426
	r_PtxU64Register144 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1426)) * int64_t(int32_t(16))); // PTX L1428
	g_ResidualByteAddressAtPtx1429 =
		uint64_t(g_ResidualByteAddressAtPtx1424) + uint64_t(r_PtxU64Register144); // PTX L1429
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1429));
		r_PackedHalf2AtPtx1415R1610 = r_Value.x;
		r_PackedHalf2AtPtx1416R1611 = r_Value.y;
		r_PackedHalf2AtPtx1417R1612 = r_Value.z;
		r_PackedHalf2AtPtx1418R1613 = r_Value.w;
	} // PTX L1431
L__BB44_185:													  // PTX L1433
	r_bPtxPredicate76 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1434
	r_PtxRegister1614 = uint32_t(0);							  // PTX L1435
	if (r_bPtxPredicate76)
	{
		goto L__BB44_187;
	} // PTX L1436
	r_bPtxPredicate77 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister4); // PTX L1437
	r_PtxRegister1614 = uint32_t(r_PtxRegister33);							 // PTX L1438
	r_PackedHalf2AtPtx1439R1615 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1439
	r_PackedHalf2AtPtx1440R1616 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1440
	r_PackedHalf2AtPtx1441R1617 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1441
	r_PackedHalf2AtPtx1442R1618 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1442
	if (r_bPtxPredicate77)
	{
		goto L__BB44_188;
	} // PTX L1443
L__BB44_187:																				  // PTX L1444
	r_PtxRegister346 = ShiftLeft(uint32_t(r_PtxRegister1614), uint32_t(13));				  // PTX L1445
	r_PtxRegister347 = uint32_t(r_PtxRegister346) + uint32_t(r_PtxRegister8);				  // PTX L1446
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister347)) * int64_t(int32_t(4))); // PTX L1447
	g_ResidualByteAddressAtPtx1448 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register146); // PTX L1448
	r_LaneIndexAtPtx1450 = uint32_t((threadIdx.x & 31u));				 // PTX L1450
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1450)) * int64_t(int32_t(16))); // PTX L1452
	g_ResidualByteAddressAtPtx1453 =
		uint64_t(g_ResidualByteAddressAtPtx1448) + uint64_t(r_PtxU64Register148); // PTX L1453
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1453));
		r_PackedHalf2AtPtx1439R1615 = r_Value.x;
		r_PackedHalf2AtPtx1440R1616 = r_Value.y;
		r_PackedHalf2AtPtx1441R1617 = r_Value.z;
		r_PackedHalf2AtPtx1442R1618 = r_Value.w;
	} // PTX L1455
L__BB44_188:													  // PTX L1457
	r_bPtxPredicate78 = uint32_t(r_PtxRegister11) < uint32_t(31); // PTX L1458
	r_PtxRegister1619 = uint32_t(0);							  // PTX L1459
	if (r_bPtxPredicate78)
	{
		goto L__BB44_190;
	} // PTX L1460
	r_bPtxPredicate79 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister4); // PTX L1461
	r_PtxRegister1619 = uint32_t(r_PtxRegister33);							 // PTX L1462
	r_PackedHalf2AtPtx1463R1620 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1463
	r_PackedHalf2AtPtx1464R1621 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1464
	r_PackedHalf2AtPtx1465R1622 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1465
	r_PackedHalf2AtPtx1466R1623 = uint32_t(r_PackedHalf2AtPtx4534R1800);	 // PTX L1466
	if (r_bPtxPredicate79)
	{
		goto L__BB44_191;
	} // PTX L1467
L__BB44_190:																				  // PTX L1468
	r_PtxRegister349 = ShiftLeft(uint32_t(r_PtxRegister1619), uint32_t(13));				  // PTX L1469
	r_PtxRegister350 = uint32_t(r_PtxRegister349) + uint32_t(r_PtxRegister9);				  // PTX L1470
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister350)) * int64_t(int32_t(4))); // PTX L1471
	g_ResidualByteAddressAtPtx1472 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register150); // PTX L1472
	r_LaneIndexAtPtx1474 = uint32_t((threadIdx.x & 31u));				 // PTX L1474
	r_PtxU64Register152 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1474)) * int64_t(int32_t(16))); // PTX L1476
	g_ResidualByteAddressAtPtx1477 =
		uint64_t(g_ResidualByteAddressAtPtx1472) + uint64_t(r_PtxU64Register152); // PTX L1477
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx1477));
		r_PackedHalf2AtPtx1463R1620 = r_Value.x;
		r_PackedHalf2AtPtx1464R1621 = r_Value.y;
		r_PackedHalf2AtPtx1465R1622 = r_Value.z;
		r_PackedHalf2AtPtx1466R1623 = r_Value.w;
	} // PTX L1479
L__BB44_191:																				  // PTX L1481
	g_RecordByteAddressAtPtx1482 = g_RecordBaseAddress;										  // PTX L1482
	r_PtxRegister543 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));							  // PTX L1483
	r_PtxRegister544 = r_PtxRegister543 & 64;												  // PTX L1484
	r_PtxRegister545 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(7));					  // PTX L1485
	r_PtxRegister546 = r_PtxRegister544 | r_PtxRegister545;									  // PTX L1486
	r_PtxRegister547 = r_PtxRegister546 | 8;												  // PTX L1487
	r_LaneIndexAtPtx1489 = uint32_t((threadIdx.x & 31u));									  // PTX L1489
	r_PtxRegister548 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1489), uint32_t(31));		  // PTX L1491
	r_PtxRegister549 = ShiftRight(uint32_t(r_PtxRegister548), uint32_t(30));				  // PTX L1492
	r_PtxRegister550 = uint32_t(r_LaneIndexAtPtx1489) + uint32_t(r_PtxRegister549);			  // PTX L1493
	r_PtxRegister551 = r_PtxRegister550 & 2147483644;										  // PTX L1494
	r_PtxRegister552 = uint32_t(r_LaneIndexAtPtx1489) - uint32_t(r_PtxRegister551);			  // PTX L1495
	r_PtxRegister553 = ShiftLeft(uint32_t(r_PtxRegister552), uint32_t(1));					  // PTX L1496
	r_PtxRegister554 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister553);				  // PTX L1497
	r_PtxRegister555 = ShiftRightSigned(int32_t(r_PtxRegister554), uint32_t(1));			  // PTX L1498
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister555)) * int64_t(int32_t(4))); // PTX L1499
	g_RecordByteAddressAtPtx1500 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register154); // PTX L1500
	r_PtxRegister416 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1500 + 8388608ull);		  // PTX L1501
	r_LaneIndexAtPtx1503 = uint32_t((threadIdx.x & 31u));									  // PTX L1503
	r_PtxRegister556 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1503), uint32_t(31));		  // PTX L1505
	r_PtxRegister557 = ShiftRight(uint32_t(r_PtxRegister556), uint32_t(30));				  // PTX L1506
	r_PtxRegister558 = uint32_t(r_LaneIndexAtPtx1503) + uint32_t(r_PtxRegister557);			  // PTX L1507
	r_PtxRegister559 = r_PtxRegister558 & 2147483644;										  // PTX L1508
	r_PtxRegister560 = uint32_t(r_LaneIndexAtPtx1503) - uint32_t(r_PtxRegister559);			  // PTX L1509
	r_PtxRegister561 = ShiftLeft(uint32_t(r_PtxRegister560), uint32_t(1));					  // PTX L1510
	r_PtxRegister562 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister561);				  // PTX L1511
	r_PtxRegister563 = ShiftRightSigned(int32_t(r_PtxRegister562), uint32_t(1));			  // PTX L1512
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister563)) * int64_t(int32_t(4))); // PTX L1513
	g_RecordByteAddressAtPtx1514 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register156); // PTX L1514
	r_PtxRegister418 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1514 + 8388608ull);		  // PTX L1515
	r_LaneIndexAtPtx1517 = uint32_t((threadIdx.x & 31u));									  // PTX L1517
	r_PtxRegister564 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1517), uint32_t(31));		  // PTX L1519
	r_PtxRegister565 = ShiftRight(uint32_t(r_PtxRegister564), uint32_t(30));				  // PTX L1520
	r_PtxRegister566 = uint32_t(r_LaneIndexAtPtx1517) + uint32_t(r_PtxRegister565);			  // PTX L1521
	r_PtxRegister567 = r_PtxRegister566 & 2147483644;										  // PTX L1522
	r_PtxRegister568 = uint32_t(r_LaneIndexAtPtx1517) - uint32_t(r_PtxRegister567);			  // PTX L1523
	r_PtxRegister569 = ShiftLeft(uint32_t(r_PtxRegister568), uint32_t(1));					  // PTX L1524
	r_PtxRegister570 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister569);				  // PTX L1525
	r_PtxRegister571 = ShiftRightSigned(int32_t(r_PtxRegister570), uint32_t(1));			  // PTX L1526
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister571)) * int64_t(int32_t(4))); // PTX L1527
	g_RecordByteAddressAtPtx1528 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register158); // PTX L1528
	r_PtxRegister420 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1528 + 8388608ull);		  // PTX L1529
	r_LaneIndexAtPtx1531 = uint32_t((threadIdx.x & 31u));									  // PTX L1531
	r_PtxRegister572 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1531), uint32_t(31));		  // PTX L1533
	r_PtxRegister573 = ShiftRight(uint32_t(r_PtxRegister572), uint32_t(30));				  // PTX L1534
	r_PtxRegister574 = uint32_t(r_LaneIndexAtPtx1531) + uint32_t(r_PtxRegister573);			  // PTX L1535
	r_PtxRegister575 = r_PtxRegister574 & 2147483644;										  // PTX L1536
	r_PtxRegister576 = uint32_t(r_LaneIndexAtPtx1531) - uint32_t(r_PtxRegister575);			  // PTX L1537
	r_PtxRegister577 = ShiftLeft(uint32_t(r_PtxRegister576), uint32_t(1));					  // PTX L1538
	r_PtxRegister578 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister577);				  // PTX L1539
	r_PtxRegister579 = ShiftRightSigned(int32_t(r_PtxRegister578), uint32_t(1));			  // PTX L1540
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister579)) * int64_t(int32_t(4))); // PTX L1541
	g_RecordByteAddressAtPtx1542 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register160); // PTX L1542
	r_PtxRegister422 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1542 + 8388608ull);		  // PTX L1543
	r_LaneIndexAtPtx1545 = uint32_t((threadIdx.x & 31u));									  // PTX L1545
	r_PtxRegister580 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1545), uint32_t(31));		  // PTX L1547
	r_PtxRegister581 = ShiftRight(uint32_t(r_PtxRegister580), uint32_t(30));				  // PTX L1548
	r_PtxRegister582 = uint32_t(r_LaneIndexAtPtx1545) + uint32_t(r_PtxRegister581);			  // PTX L1549
	r_PtxRegister583 = r_PtxRegister582 & 2147483644;										  // PTX L1550
	r_PtxRegister584 = uint32_t(r_LaneIndexAtPtx1545) - uint32_t(r_PtxRegister583);			  // PTX L1551
	r_PtxRegister585 = ShiftLeft(uint32_t(r_PtxRegister584), uint32_t(1));					  // PTX L1552
	r_PtxRegister586 = r_PtxRegister546 | 16;												  // PTX L1553
	r_PtxRegister587 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister585);				  // PTX L1554
	r_PtxRegister588 = ShiftRightSigned(int32_t(r_PtxRegister587), uint32_t(1));			  // PTX L1555
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister588)) * int64_t(int32_t(4))); // PTX L1556
	g_RecordByteAddressAtPtx1557 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register162); // PTX L1557
	r_PtxRegister424 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1557 + 8388608ull);		  // PTX L1558
	r_LaneIndexAtPtx1560 = uint32_t((threadIdx.x & 31u));									  // PTX L1560
	r_PtxRegister589 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1560), uint32_t(31));		  // PTX L1562
	r_PtxRegister590 = ShiftRight(uint32_t(r_PtxRegister589), uint32_t(30));				  // PTX L1563
	r_PtxRegister591 = uint32_t(r_LaneIndexAtPtx1560) + uint32_t(r_PtxRegister590);			  // PTX L1564
	r_PtxRegister592 = r_PtxRegister591 & 2147483644;										  // PTX L1565
	r_PtxRegister593 = uint32_t(r_LaneIndexAtPtx1560) - uint32_t(r_PtxRegister592);			  // PTX L1566
	r_PtxRegister594 = ShiftLeft(uint32_t(r_PtxRegister593), uint32_t(1));					  // PTX L1567
	r_PtxRegister595 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister594);				  // PTX L1568
	r_PtxRegister596 = ShiftRightSigned(int32_t(r_PtxRegister595), uint32_t(1));			  // PTX L1569
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister596)) * int64_t(int32_t(4))); // PTX L1570
	g_RecordByteAddressAtPtx1571 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register164); // PTX L1571
	r_PtxRegister426 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1571 + 8388608ull);		  // PTX L1572
	r_LaneIndexAtPtx1574 = uint32_t((threadIdx.x & 31u));									  // PTX L1574
	r_PtxRegister597 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1574), uint32_t(31));		  // PTX L1576
	r_PtxRegister598 = ShiftRight(uint32_t(r_PtxRegister597), uint32_t(30));				  // PTX L1577
	r_PtxRegister599 = uint32_t(r_LaneIndexAtPtx1574) + uint32_t(r_PtxRegister598);			  // PTX L1578
	r_PtxRegister600 = r_PtxRegister599 & 2147483644;										  // PTX L1579
	r_PtxRegister601 = uint32_t(r_LaneIndexAtPtx1574) - uint32_t(r_PtxRegister600);			  // PTX L1580
	r_PtxRegister602 = ShiftLeft(uint32_t(r_PtxRegister601), uint32_t(1));					  // PTX L1581
	r_PtxRegister603 = r_PtxRegister546 | 24;												  // PTX L1582
	r_PtxRegister604 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister602);				  // PTX L1583
	r_PtxRegister605 = ShiftRightSigned(int32_t(r_PtxRegister604), uint32_t(1));			  // PTX L1584
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister605)) * int64_t(int32_t(4))); // PTX L1585
	g_RecordByteAddressAtPtx1586 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register166); // PTX L1586
	r_PtxRegister428 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1586 + 8388608ull);		  // PTX L1587
	r_LaneIndexAtPtx1589 = uint32_t((threadIdx.x & 31u));									  // PTX L1589
	r_PtxRegister606 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1589), uint32_t(31));		  // PTX L1591
	r_PtxRegister607 = ShiftRight(uint32_t(r_PtxRegister606), uint32_t(30));				  // PTX L1592
	r_PtxRegister608 = uint32_t(r_LaneIndexAtPtx1589) + uint32_t(r_PtxRegister607);			  // PTX L1593
	r_PtxRegister609 = r_PtxRegister608 & 2147483644;										  // PTX L1594
	r_PtxRegister610 = uint32_t(r_LaneIndexAtPtx1589) - uint32_t(r_PtxRegister609);			  // PTX L1595
	r_PtxRegister611 = ShiftLeft(uint32_t(r_PtxRegister610), uint32_t(1));					  // PTX L1596
	r_PtxRegister612 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister611);				  // PTX L1597
	r_PtxRegister613 = ShiftRightSigned(int32_t(r_PtxRegister612), uint32_t(1));			  // PTX L1598
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister613)) * int64_t(int32_t(4))); // PTX L1599
	g_RecordByteAddressAtPtx1600 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register168); // PTX L1600
	r_PtxRegister430 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1600 + 8388608ull);		  // PTX L1601
	r_LaneIndexAtPtx1603 = uint32_t((threadIdx.x & 31u));									  // PTX L1603
	r_PtxRegister614 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1603), uint32_t(31));		  // PTX L1605
	r_PtxRegister615 = ShiftRight(uint32_t(r_PtxRegister614), uint32_t(30));				  // PTX L1606
	r_PtxRegister616 = uint32_t(r_LaneIndexAtPtx1603) + uint32_t(r_PtxRegister615);			  // PTX L1607
	r_PtxRegister617 = r_PtxRegister616 & 2147483644;										  // PTX L1608
	r_PtxRegister618 = uint32_t(r_LaneIndexAtPtx1603) - uint32_t(r_PtxRegister617);			  // PTX L1609
	r_PtxRegister619 = ShiftLeft(uint32_t(r_PtxRegister618), uint32_t(1));					  // PTX L1610
	r_PtxRegister620 = r_PtxRegister546 | 32;												  // PTX L1611
	r_PtxRegister621 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister619);				  // PTX L1612
	r_PtxRegister622 = ShiftRightSigned(int32_t(r_PtxRegister621), uint32_t(1));			  // PTX L1613
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister622)) * int64_t(int32_t(4))); // PTX L1614
	g_RecordByteAddressAtPtx1615 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register170); // PTX L1615
	r_PtxRegister432 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1615 + 8388608ull);		  // PTX L1616
	r_LaneIndexAtPtx1618 = uint32_t((threadIdx.x & 31u));									  // PTX L1618
	r_PtxRegister623 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1618), uint32_t(31));		  // PTX L1620
	r_PtxRegister624 = ShiftRight(uint32_t(r_PtxRegister623), uint32_t(30));				  // PTX L1621
	r_PtxRegister625 = uint32_t(r_LaneIndexAtPtx1618) + uint32_t(r_PtxRegister624);			  // PTX L1622
	r_PtxRegister626 = r_PtxRegister625 & 2147483644;										  // PTX L1623
	r_PtxRegister627 = uint32_t(r_LaneIndexAtPtx1618) - uint32_t(r_PtxRegister626);			  // PTX L1624
	r_PtxRegister628 = ShiftLeft(uint32_t(r_PtxRegister627), uint32_t(1));					  // PTX L1625
	r_PtxRegister629 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister628);				  // PTX L1626
	r_PtxRegister630 = ShiftRightSigned(int32_t(r_PtxRegister629), uint32_t(1));			  // PTX L1627
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister630)) * int64_t(int32_t(4))); // PTX L1628
	g_RecordByteAddressAtPtx1629 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register172); // PTX L1629
	r_PtxRegister434 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1629 + 8388608ull);		  // PTX L1630
	r_LaneIndexAtPtx1632 = uint32_t((threadIdx.x & 31u));									  // PTX L1632
	r_PtxRegister631 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1632), uint32_t(31));		  // PTX L1634
	r_PtxRegister632 = ShiftRight(uint32_t(r_PtxRegister631), uint32_t(30));				  // PTX L1635
	r_PtxRegister633 = uint32_t(r_LaneIndexAtPtx1632) + uint32_t(r_PtxRegister632);			  // PTX L1636
	r_PtxRegister634 = r_PtxRegister633 & 2147483644;										  // PTX L1637
	r_PtxRegister635 = uint32_t(r_LaneIndexAtPtx1632) - uint32_t(r_PtxRegister634);			  // PTX L1638
	r_PtxRegister636 = ShiftLeft(uint32_t(r_PtxRegister635), uint32_t(1));					  // PTX L1639
	r_PtxRegister637 = r_PtxRegister546 | 40;												  // PTX L1640
	r_PtxRegister638 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister636);				  // PTX L1641
	r_PtxRegister639 = ShiftRightSigned(int32_t(r_PtxRegister638), uint32_t(1));			  // PTX L1642
	r_PtxU64Register174 = uint64_t(int64_t(int32_t(r_PtxRegister639)) * int64_t(int32_t(4))); // PTX L1643
	g_RecordByteAddressAtPtx1644 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register174); // PTX L1644
	r_PtxRegister436 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1644 + 8388608ull);		  // PTX L1645
	r_LaneIndexAtPtx1647 = uint32_t((threadIdx.x & 31u));									  // PTX L1647
	r_PtxRegister640 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1647), uint32_t(31));		  // PTX L1649
	r_PtxRegister641 = ShiftRight(uint32_t(r_PtxRegister640), uint32_t(30));				  // PTX L1650
	r_PtxRegister642 = uint32_t(r_LaneIndexAtPtx1647) + uint32_t(r_PtxRegister641);			  // PTX L1651
	r_PtxRegister643 = r_PtxRegister642 & 2147483644;										  // PTX L1652
	r_PtxRegister644 = uint32_t(r_LaneIndexAtPtx1647) - uint32_t(r_PtxRegister643);			  // PTX L1653
	r_PtxRegister645 = ShiftLeft(uint32_t(r_PtxRegister644), uint32_t(1));					  // PTX L1654
	r_PtxRegister646 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister645);				  // PTX L1655
	r_PtxRegister647 = ShiftRightSigned(int32_t(r_PtxRegister646), uint32_t(1));			  // PTX L1656
	r_PtxU64Register176 = uint64_t(int64_t(int32_t(r_PtxRegister647)) * int64_t(int32_t(4))); // PTX L1657
	g_RecordByteAddressAtPtx1658 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register176); // PTX L1658
	r_PtxRegister438 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1658 + 8388608ull);		  // PTX L1659
	r_LaneIndexAtPtx1661 = uint32_t((threadIdx.x & 31u));									  // PTX L1661
	r_PtxRegister648 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1661), uint32_t(31));		  // PTX L1663
	r_PtxRegister649 = ShiftRight(uint32_t(r_PtxRegister648), uint32_t(30));				  // PTX L1664
	r_PtxRegister650 = uint32_t(r_LaneIndexAtPtx1661) + uint32_t(r_PtxRegister649);			  // PTX L1665
	r_PtxRegister651 = r_PtxRegister650 & 2147483644;										  // PTX L1666
	r_PtxRegister652 = uint32_t(r_LaneIndexAtPtx1661) - uint32_t(r_PtxRegister651);			  // PTX L1667
	r_PtxRegister653 = ShiftLeft(uint32_t(r_PtxRegister652), uint32_t(1));					  // PTX L1668
	r_PtxRegister654 = r_PtxRegister546 | 48;												  // PTX L1669
	r_PtxRegister655 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister653);				  // PTX L1670
	r_PtxRegister656 = ShiftRightSigned(int32_t(r_PtxRegister655), uint32_t(1));			  // PTX L1671
	r_PtxU64Register178 = uint64_t(int64_t(int32_t(r_PtxRegister656)) * int64_t(int32_t(4))); // PTX L1672
	g_RecordByteAddressAtPtx1673 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register178); // PTX L1673
	r_PtxRegister440 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1673 + 8388608ull);		  // PTX L1674
	r_LaneIndexAtPtx1676 = uint32_t((threadIdx.x & 31u));									  // PTX L1676
	r_PtxRegister657 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1676), uint32_t(31));		  // PTX L1678
	r_PtxRegister658 = ShiftRight(uint32_t(r_PtxRegister657), uint32_t(30));				  // PTX L1679
	r_PtxRegister659 = uint32_t(r_LaneIndexAtPtx1676) + uint32_t(r_PtxRegister658);			  // PTX L1680
	r_PtxRegister660 = r_PtxRegister659 & 2147483644;										  // PTX L1681
	r_PtxRegister661 = uint32_t(r_LaneIndexAtPtx1676) - uint32_t(r_PtxRegister660);			  // PTX L1682
	r_PtxRegister662 = ShiftLeft(uint32_t(r_PtxRegister661), uint32_t(1));					  // PTX L1683
	r_PtxRegister663 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister662);				  // PTX L1684
	r_PtxRegister664 = ShiftRightSigned(int32_t(r_PtxRegister663), uint32_t(1));			  // PTX L1685
	r_PtxU64Register180 = uint64_t(int64_t(int32_t(r_PtxRegister664)) * int64_t(int32_t(4))); // PTX L1686
	g_RecordByteAddressAtPtx1687 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register180); // PTX L1687
	r_PtxRegister442 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1687 + 8388608ull);		  // PTX L1688
	r_LaneIndexAtPtx1690 = uint32_t((threadIdx.x & 31u));									  // PTX L1690
	r_PtxRegister665 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1690), uint32_t(31));		  // PTX L1692
	r_PtxRegister666 = ShiftRight(uint32_t(r_PtxRegister665), uint32_t(30));				  // PTX L1693
	r_PtxRegister667 = uint32_t(r_LaneIndexAtPtx1690) + uint32_t(r_PtxRegister666);			  // PTX L1694
	r_PtxRegister668 = r_PtxRegister667 & 2147483644;										  // PTX L1695
	r_PtxRegister669 = uint32_t(r_LaneIndexAtPtx1690) - uint32_t(r_PtxRegister668);			  // PTX L1696
	r_PtxRegister670 = ShiftLeft(uint32_t(r_PtxRegister669), uint32_t(1));					  // PTX L1697
	r_PtxRegister671 = r_PtxRegister546 | 56;												  // PTX L1698
	r_PtxRegister672 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister670);				  // PTX L1699
	r_PtxRegister673 = ShiftRightSigned(int32_t(r_PtxRegister672), uint32_t(1));			  // PTX L1700
	r_PtxU64Register182 = uint64_t(int64_t(int32_t(r_PtxRegister673)) * int64_t(int32_t(4))); // PTX L1701
	g_RecordByteAddressAtPtx1702 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register182); // PTX L1702
	r_PtxRegister444 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1702 + 8388608ull);		  // PTX L1703
	r_LaneIndexAtPtx1705 = uint32_t((threadIdx.x & 31u));									  // PTX L1705
	r_PtxRegister674 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1705), uint32_t(31));		  // PTX L1707
	r_PtxRegister675 = ShiftRight(uint32_t(r_PtxRegister674), uint32_t(30));				  // PTX L1708
	r_PtxRegister676 = uint32_t(r_LaneIndexAtPtx1705) + uint32_t(r_PtxRegister675);			  // PTX L1709
	r_PtxRegister677 = r_PtxRegister676 & 2147483644;										  // PTX L1710
	r_PtxRegister678 = uint32_t(r_LaneIndexAtPtx1705) - uint32_t(r_PtxRegister677);			  // PTX L1711
	r_PtxRegister679 = ShiftLeft(uint32_t(r_PtxRegister678), uint32_t(1));					  // PTX L1712
	r_PtxRegister680 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister679);				  // PTX L1713
	r_PtxRegister681 = ShiftRightSigned(int32_t(r_PtxRegister680), uint32_t(1));			  // PTX L1714
	r_PtxU64Register184 = uint64_t(int64_t(int32_t(r_PtxRegister681)) * int64_t(int32_t(4))); // PTX L1715
	g_RecordByteAddressAtPtx1716 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register184); // PTX L1716
	r_PtxRegister446 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1716 + 8388608ull);		  // PTX L1717
	r_LaneIndexAtPtx1719 = uint32_t((threadIdx.x & 31u));									  // PTX L1719
	r_PtxRegister682 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1719), uint32_t(31));		  // PTX L1721
	r_PtxRegister683 = ShiftRight(uint32_t(r_PtxRegister682), uint32_t(30));				  // PTX L1722
	r_PtxRegister684 = uint32_t(r_LaneIndexAtPtx1719) + uint32_t(r_PtxRegister683);			  // PTX L1723
	r_PtxRegister685 = r_PtxRegister684 & 2147483644;										  // PTX L1724
	r_PtxRegister686 = uint32_t(r_LaneIndexAtPtx1719) - uint32_t(r_PtxRegister685);			  // PTX L1725
	r_PtxRegister687 = ShiftLeft(uint32_t(r_PtxRegister686), uint32_t(1));					  // PTX L1726
	r_PtxRegister688 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister687);				  // PTX L1727
	r_PtxRegister689 = ShiftRightSigned(int32_t(r_PtxRegister688), uint32_t(1));			  // PTX L1728
	r_PtxU64Register186 = uint64_t(int64_t(int32_t(r_PtxRegister689)) * int64_t(int32_t(4))); // PTX L1729
	g_RecordByteAddressAtPtx1730 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register186); // PTX L1730
	r_PtxRegister448 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1730 + 8388608ull);		  // PTX L1731
	r_LaneIndexAtPtx1733 = uint32_t((threadIdx.x & 31u));									  // PTX L1733
	r_PtxRegister690 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1733), uint32_t(31));		  // PTX L1735
	r_PtxRegister691 = ShiftRight(uint32_t(r_PtxRegister690), uint32_t(30));				  // PTX L1736
	r_PtxRegister692 = uint32_t(r_LaneIndexAtPtx1733) + uint32_t(r_PtxRegister691);			  // PTX L1737
	r_PtxRegister693 = r_PtxRegister692 & 2147483644;										  // PTX L1738
	r_PtxRegister694 = uint32_t(r_LaneIndexAtPtx1733) - uint32_t(r_PtxRegister693);			  // PTX L1739
	r_PtxRegister695 = ShiftLeft(uint32_t(r_PtxRegister694), uint32_t(1));					  // PTX L1740
	r_PtxRegister696 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister695);				  // PTX L1741
	r_PtxRegister697 = ShiftRightSigned(int32_t(r_PtxRegister696), uint32_t(1));			  // PTX L1742
	r_PtxU64Register188 = uint64_t(int64_t(int32_t(r_PtxRegister697)) * int64_t(int32_t(4))); // PTX L1743
	g_RecordByteAddressAtPtx1744 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register188); // PTX L1744
	r_PtxRegister450 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1744 + 8388608ull);		  // PTX L1745
	r_LaneIndexAtPtx1747 = uint32_t((threadIdx.x & 31u));									  // PTX L1747
	r_PtxRegister698 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1747), uint32_t(31));		  // PTX L1749
	r_PtxRegister699 = ShiftRight(uint32_t(r_PtxRegister698), uint32_t(30));				  // PTX L1750
	r_PtxRegister700 = uint32_t(r_LaneIndexAtPtx1747) + uint32_t(r_PtxRegister699);			  // PTX L1751
	r_PtxRegister701 = r_PtxRegister700 & 2147483644;										  // PTX L1752
	r_PtxRegister702 = uint32_t(r_LaneIndexAtPtx1747) - uint32_t(r_PtxRegister701);			  // PTX L1753
	r_PtxRegister703 = ShiftLeft(uint32_t(r_PtxRegister702), uint32_t(1));					  // PTX L1754
	r_PtxRegister704 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister703);				  // PTX L1755
	r_PtxRegister705 = ShiftRightSigned(int32_t(r_PtxRegister704), uint32_t(1));			  // PTX L1756
	r_PtxU64Register190 = uint64_t(int64_t(int32_t(r_PtxRegister705)) * int64_t(int32_t(4))); // PTX L1757
	g_RecordByteAddressAtPtx1758 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register190); // PTX L1758
	r_PtxRegister452 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1758 + 8388608ull);		  // PTX L1759
	r_LaneIndexAtPtx1761 = uint32_t((threadIdx.x & 31u));									  // PTX L1761
	r_PtxRegister706 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1761), uint32_t(31));		  // PTX L1763
	r_PtxRegister707 = ShiftRight(uint32_t(r_PtxRegister706), uint32_t(30));				  // PTX L1764
	r_PtxRegister708 = uint32_t(r_LaneIndexAtPtx1761) + uint32_t(r_PtxRegister707);			  // PTX L1765
	r_PtxRegister709 = r_PtxRegister708 & 2147483644;										  // PTX L1766
	r_PtxRegister710 = uint32_t(r_LaneIndexAtPtx1761) - uint32_t(r_PtxRegister709);			  // PTX L1767
	r_PtxRegister711 = ShiftLeft(uint32_t(r_PtxRegister710), uint32_t(1));					  // PTX L1768
	r_PtxRegister712 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister711);				  // PTX L1769
	r_PtxRegister713 = ShiftRightSigned(int32_t(r_PtxRegister712), uint32_t(1));			  // PTX L1770
	r_PtxU64Register192 = uint64_t(int64_t(int32_t(r_PtxRegister713)) * int64_t(int32_t(4))); // PTX L1771
	g_RecordByteAddressAtPtx1772 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register192); // PTX L1772
	r_PtxRegister454 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1772 + 8388608ull);		  // PTX L1773
	r_LaneIndexAtPtx1775 = uint32_t((threadIdx.x & 31u));									  // PTX L1775
	r_PtxRegister714 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1775), uint32_t(31));		  // PTX L1777
	r_PtxRegister715 = ShiftRight(uint32_t(r_PtxRegister714), uint32_t(30));				  // PTX L1778
	r_PtxRegister716 = uint32_t(r_LaneIndexAtPtx1775) + uint32_t(r_PtxRegister715);			  // PTX L1779
	r_PtxRegister717 = r_PtxRegister716 & 2147483644;										  // PTX L1780
	r_PtxRegister718 = uint32_t(r_LaneIndexAtPtx1775) - uint32_t(r_PtxRegister717);			  // PTX L1781
	r_PtxRegister719 = ShiftLeft(uint32_t(r_PtxRegister718), uint32_t(1));					  // PTX L1782
	r_PtxRegister720 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister719);				  // PTX L1783
	r_PtxRegister721 = ShiftRightSigned(int32_t(r_PtxRegister720), uint32_t(1));			  // PTX L1784
	r_PtxU64Register194 = uint64_t(int64_t(int32_t(r_PtxRegister721)) * int64_t(int32_t(4))); // PTX L1785
	g_RecordByteAddressAtPtx1786 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register194); // PTX L1786
	r_PtxRegister456 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1786 + 8388608ull);		  // PTX L1787
	r_LaneIndexAtPtx1789 = uint32_t((threadIdx.x & 31u));									  // PTX L1789
	r_PtxRegister722 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1789), uint32_t(31));		  // PTX L1791
	r_PtxRegister723 = ShiftRight(uint32_t(r_PtxRegister722), uint32_t(30));				  // PTX L1792
	r_PtxRegister724 = uint32_t(r_LaneIndexAtPtx1789) + uint32_t(r_PtxRegister723);			  // PTX L1793
	r_PtxRegister725 = r_PtxRegister724 & 2147483644;										  // PTX L1794
	r_PtxRegister726 = uint32_t(r_LaneIndexAtPtx1789) - uint32_t(r_PtxRegister725);			  // PTX L1795
	r_PtxRegister727 = ShiftLeft(uint32_t(r_PtxRegister726), uint32_t(1));					  // PTX L1796
	r_PtxRegister728 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister727);				  // PTX L1797
	r_PtxRegister729 = ShiftRightSigned(int32_t(r_PtxRegister728), uint32_t(1));			  // PTX L1798
	r_PtxU64Register196 = uint64_t(int64_t(int32_t(r_PtxRegister729)) * int64_t(int32_t(4))); // PTX L1799
	g_RecordByteAddressAtPtx1800 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register196); // PTX L1800
	r_PtxRegister458 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1800 + 8388608ull);		  // PTX L1801
	r_LaneIndexAtPtx1803 = uint32_t((threadIdx.x & 31u));									  // PTX L1803
	r_PtxRegister730 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1803), uint32_t(31));		  // PTX L1805
	r_PtxRegister731 = ShiftRight(uint32_t(r_PtxRegister730), uint32_t(30));				  // PTX L1806
	r_PtxRegister732 = uint32_t(r_LaneIndexAtPtx1803) + uint32_t(r_PtxRegister731);			  // PTX L1807
	r_PtxRegister733 = r_PtxRegister732 & 2147483644;										  // PTX L1808
	r_PtxRegister734 = uint32_t(r_LaneIndexAtPtx1803) - uint32_t(r_PtxRegister733);			  // PTX L1809
	r_PtxRegister735 = ShiftLeft(uint32_t(r_PtxRegister734), uint32_t(1));					  // PTX L1810
	r_PtxRegister736 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister735);				  // PTX L1811
	r_PtxRegister737 = ShiftRightSigned(int32_t(r_PtxRegister736), uint32_t(1));			  // PTX L1812
	r_PtxU64Register198 = uint64_t(int64_t(int32_t(r_PtxRegister737)) * int64_t(int32_t(4))); // PTX L1813
	g_RecordByteAddressAtPtx1814 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register198); // PTX L1814
	r_PtxRegister460 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1814 + 8388608ull);		  // PTX L1815
	r_LaneIndexAtPtx1817 = uint32_t((threadIdx.x & 31u));									  // PTX L1817
	r_PtxRegister738 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1817), uint32_t(31));		  // PTX L1819
	r_PtxRegister739 = ShiftRight(uint32_t(r_PtxRegister738), uint32_t(30));				  // PTX L1820
	r_PtxRegister740 = uint32_t(r_LaneIndexAtPtx1817) + uint32_t(r_PtxRegister739);			  // PTX L1821
	r_PtxRegister741 = r_PtxRegister740 & 2147483644;										  // PTX L1822
	r_PtxRegister742 = uint32_t(r_LaneIndexAtPtx1817) - uint32_t(r_PtxRegister741);			  // PTX L1823
	r_PtxRegister743 = ShiftLeft(uint32_t(r_PtxRegister742), uint32_t(1));					  // PTX L1824
	r_PtxRegister744 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister743);				  // PTX L1825
	r_PtxRegister745 = ShiftRightSigned(int32_t(r_PtxRegister744), uint32_t(1));			  // PTX L1826
	r_PtxU64Register200 = uint64_t(int64_t(int32_t(r_PtxRegister745)) * int64_t(int32_t(4))); // PTX L1827
	g_RecordByteAddressAtPtx1828 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register200); // PTX L1828
	r_PtxRegister462 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1828 + 8388608ull);		  // PTX L1829
	r_LaneIndexAtPtx1831 = uint32_t((threadIdx.x & 31u));									  // PTX L1831
	r_PtxRegister746 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1831), uint32_t(31));		  // PTX L1833
	r_PtxRegister747 = ShiftRight(uint32_t(r_PtxRegister746), uint32_t(30));				  // PTX L1834
	r_PtxRegister748 = uint32_t(r_LaneIndexAtPtx1831) + uint32_t(r_PtxRegister747);			  // PTX L1835
	r_PtxRegister749 = r_PtxRegister748 & 2147483644;										  // PTX L1836
	r_PtxRegister750 = uint32_t(r_LaneIndexAtPtx1831) - uint32_t(r_PtxRegister749);			  // PTX L1837
	r_PtxRegister751 = ShiftLeft(uint32_t(r_PtxRegister750), uint32_t(1));					  // PTX L1838
	r_PtxRegister752 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister751);				  // PTX L1839
	r_PtxRegister753 = ShiftRightSigned(int32_t(r_PtxRegister752), uint32_t(1));			  // PTX L1840
	r_PtxU64Register202 = uint64_t(int64_t(int32_t(r_PtxRegister753)) * int64_t(int32_t(4))); // PTX L1841
	g_RecordByteAddressAtPtx1842 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register202); // PTX L1842
	r_PtxRegister464 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1842 + 8388608ull);		  // PTX L1843
	r_LaneIndexAtPtx1845 = uint32_t((threadIdx.x & 31u));									  // PTX L1845
	r_PtxRegister754 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1845), uint32_t(31));		  // PTX L1847
	r_PtxRegister755 = ShiftRight(uint32_t(r_PtxRegister754), uint32_t(30));				  // PTX L1848
	r_PtxRegister756 = uint32_t(r_LaneIndexAtPtx1845) + uint32_t(r_PtxRegister755);			  // PTX L1849
	r_PtxRegister757 = r_PtxRegister756 & 2147483644;										  // PTX L1850
	r_PtxRegister758 = uint32_t(r_LaneIndexAtPtx1845) - uint32_t(r_PtxRegister757);			  // PTX L1851
	r_PtxRegister759 = ShiftLeft(uint32_t(r_PtxRegister758), uint32_t(1));					  // PTX L1852
	r_PtxRegister760 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister759);				  // PTX L1853
	r_PtxRegister761 = ShiftRightSigned(int32_t(r_PtxRegister760), uint32_t(1));			  // PTX L1854
	r_PtxU64Register204 = uint64_t(int64_t(int32_t(r_PtxRegister761)) * int64_t(int32_t(4))); // PTX L1855
	g_RecordByteAddressAtPtx1856 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register204); // PTX L1856
	r_PtxRegister466 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1856 + 8388608ull);		  // PTX L1857
	r_LaneIndexAtPtx1859 = uint32_t((threadIdx.x & 31u));									  // PTX L1859
	r_PtxRegister762 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1859), uint32_t(31));		  // PTX L1861
	r_PtxRegister763 = ShiftRight(uint32_t(r_PtxRegister762), uint32_t(30));				  // PTX L1862
	r_PtxRegister764 = uint32_t(r_LaneIndexAtPtx1859) + uint32_t(r_PtxRegister763);			  // PTX L1863
	r_PtxRegister765 = r_PtxRegister764 & 2147483644;										  // PTX L1864
	r_PtxRegister766 = uint32_t(r_LaneIndexAtPtx1859) - uint32_t(r_PtxRegister765);			  // PTX L1865
	r_PtxRegister767 = ShiftLeft(uint32_t(r_PtxRegister766), uint32_t(1));					  // PTX L1866
	r_PtxRegister768 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister767);				  // PTX L1867
	r_PtxRegister769 = ShiftRightSigned(int32_t(r_PtxRegister768), uint32_t(1));			  // PTX L1868
	r_PtxU64Register206 = uint64_t(int64_t(int32_t(r_PtxRegister769)) * int64_t(int32_t(4))); // PTX L1869
	g_RecordByteAddressAtPtx1870 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register206); // PTX L1870
	r_PtxRegister468 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1870 + 8388608ull);		  // PTX L1871
	r_LaneIndexAtPtx1873 = uint32_t((threadIdx.x & 31u));									  // PTX L1873
	r_PtxRegister770 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1873), uint32_t(31));		  // PTX L1875
	r_PtxRegister771 = ShiftRight(uint32_t(r_PtxRegister770), uint32_t(30));				  // PTX L1876
	r_PtxRegister772 = uint32_t(r_LaneIndexAtPtx1873) + uint32_t(r_PtxRegister771);			  // PTX L1877
	r_PtxRegister773 = r_PtxRegister772 & 2147483644;										  // PTX L1878
	r_PtxRegister774 = uint32_t(r_LaneIndexAtPtx1873) - uint32_t(r_PtxRegister773);			  // PTX L1879
	r_PtxRegister775 = ShiftLeft(uint32_t(r_PtxRegister774), uint32_t(1));					  // PTX L1880
	r_PtxRegister776 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister775);				  // PTX L1881
	r_PtxRegister777 = ShiftRightSigned(int32_t(r_PtxRegister776), uint32_t(1));			  // PTX L1882
	r_PtxU64Register208 = uint64_t(int64_t(int32_t(r_PtxRegister777)) * int64_t(int32_t(4))); // PTX L1883
	g_RecordByteAddressAtPtx1884 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register208); // PTX L1884
	r_PtxRegister470 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1884 + 8388608ull);		  // PTX L1885
	r_LaneIndexAtPtx1887 = uint32_t((threadIdx.x & 31u));									  // PTX L1887
	r_PtxRegister778 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1887), uint32_t(31));		  // PTX L1889
	r_PtxRegister779 = ShiftRight(uint32_t(r_PtxRegister778), uint32_t(30));				  // PTX L1890
	r_PtxRegister780 = uint32_t(r_LaneIndexAtPtx1887) + uint32_t(r_PtxRegister779);			  // PTX L1891
	r_PtxRegister781 = r_PtxRegister780 & 2147483644;										  // PTX L1892
	r_PtxRegister782 = uint32_t(r_LaneIndexAtPtx1887) - uint32_t(r_PtxRegister781);			  // PTX L1893
	r_PtxRegister783 = ShiftLeft(uint32_t(r_PtxRegister782), uint32_t(1));					  // PTX L1894
	r_PtxRegister784 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister783);				  // PTX L1895
	r_PtxRegister785 = ShiftRightSigned(int32_t(r_PtxRegister784), uint32_t(1));			  // PTX L1896
	r_PtxU64Register210 = uint64_t(int64_t(int32_t(r_PtxRegister785)) * int64_t(int32_t(4))); // PTX L1897
	g_RecordByteAddressAtPtx1898 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register210); // PTX L1898
	r_PtxRegister472 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1898 + 8388608ull);		  // PTX L1899
	r_LaneIndexAtPtx1901 = uint32_t((threadIdx.x & 31u));									  // PTX L1901
	r_PtxRegister786 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1901), uint32_t(31));		  // PTX L1903
	r_PtxRegister787 = ShiftRight(uint32_t(r_PtxRegister786), uint32_t(30));				  // PTX L1904
	r_PtxRegister788 = uint32_t(r_LaneIndexAtPtx1901) + uint32_t(r_PtxRegister787);			  // PTX L1905
	r_PtxRegister789 = r_PtxRegister788 & 2147483644;										  // PTX L1906
	r_PtxRegister790 = uint32_t(r_LaneIndexAtPtx1901) - uint32_t(r_PtxRegister789);			  // PTX L1907
	r_PtxRegister791 = ShiftLeft(uint32_t(r_PtxRegister790), uint32_t(1));					  // PTX L1908
	r_PtxRegister792 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister791);				  // PTX L1909
	r_PtxRegister793 = ShiftRightSigned(int32_t(r_PtxRegister792), uint32_t(1));			  // PTX L1910
	r_PtxU64Register212 = uint64_t(int64_t(int32_t(r_PtxRegister793)) * int64_t(int32_t(4))); // PTX L1911
	g_RecordByteAddressAtPtx1912 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register212); // PTX L1912
	r_PtxRegister474 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1912 + 8388608ull);		  // PTX L1913
	r_LaneIndexAtPtx1915 = uint32_t((threadIdx.x & 31u));									  // PTX L1915
	r_PtxRegister794 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1915), uint32_t(31));		  // PTX L1917
	r_PtxRegister795 = ShiftRight(uint32_t(r_PtxRegister794), uint32_t(30));				  // PTX L1918
	r_PtxRegister796 = uint32_t(r_LaneIndexAtPtx1915) + uint32_t(r_PtxRegister795);			  // PTX L1919
	r_PtxRegister797 = r_PtxRegister796 & 2147483644;										  // PTX L1920
	r_PtxRegister798 = uint32_t(r_LaneIndexAtPtx1915) - uint32_t(r_PtxRegister797);			  // PTX L1921
	r_PtxRegister799 = ShiftLeft(uint32_t(r_PtxRegister798), uint32_t(1));					  // PTX L1922
	r_PtxRegister800 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister799);				  // PTX L1923
	r_PtxRegister801 = ShiftRightSigned(int32_t(r_PtxRegister800), uint32_t(1));			  // PTX L1924
	r_PtxU64Register214 = uint64_t(int64_t(int32_t(r_PtxRegister801)) * int64_t(int32_t(4))); // PTX L1925
	g_RecordByteAddressAtPtx1926 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register214); // PTX L1926
	r_PtxRegister476 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1926 + 8388608ull);		  // PTX L1927
	r_LaneIndexAtPtx1929 = uint32_t((threadIdx.x & 31u));									  // PTX L1929
	r_PtxRegister802 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1929), uint32_t(31));		  // PTX L1931
	r_PtxRegister803 = ShiftRight(uint32_t(r_PtxRegister802), uint32_t(30));				  // PTX L1932
	r_PtxRegister804 = uint32_t(r_LaneIndexAtPtx1929) + uint32_t(r_PtxRegister803);			  // PTX L1933
	r_PtxRegister805 = r_PtxRegister804 & 2147483644;										  // PTX L1934
	r_PtxRegister806 = uint32_t(r_LaneIndexAtPtx1929) - uint32_t(r_PtxRegister805);			  // PTX L1935
	r_PtxRegister807 = ShiftLeft(uint32_t(r_PtxRegister806), uint32_t(1));					  // PTX L1936
	r_PtxRegister808 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister807);				  // PTX L1937
	r_PtxRegister809 = ShiftRightSigned(int32_t(r_PtxRegister808), uint32_t(1));			  // PTX L1938
	r_PtxU64Register216 = uint64_t(int64_t(int32_t(r_PtxRegister809)) * int64_t(int32_t(4))); // PTX L1939
	g_RecordByteAddressAtPtx1940 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register216); // PTX L1940
	r_PtxRegister478 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1940 + 8388608ull);		  // PTX L1941
	r_LaneIndexAtPtx1943 = uint32_t((threadIdx.x & 31u));									  // PTX L1943
	r_PtxRegister810 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1943), uint32_t(31));		  // PTX L1945
	r_PtxRegister811 = ShiftRight(uint32_t(r_PtxRegister810), uint32_t(30));				  // PTX L1946
	r_PtxRegister812 = uint32_t(r_LaneIndexAtPtx1943) + uint32_t(r_PtxRegister811);			  // PTX L1947
	r_PtxRegister813 = r_PtxRegister812 & 2147483644;										  // PTX L1948
	r_PtxRegister814 = uint32_t(r_LaneIndexAtPtx1943) - uint32_t(r_PtxRegister813);			  // PTX L1949
	r_PtxRegister815 = ShiftLeft(uint32_t(r_PtxRegister814), uint32_t(1));					  // PTX L1950
	r_PtxRegister816 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister815);				  // PTX L1951
	r_PtxRegister817 = ShiftRightSigned(int32_t(r_PtxRegister816), uint32_t(1));			  // PTX L1952
	r_PtxU64Register218 = uint64_t(int64_t(int32_t(r_PtxRegister817)) * int64_t(int32_t(4))); // PTX L1953
	g_RecordByteAddressAtPtx1954 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register218); // PTX L1954
	r_PtxRegister480 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1954 + 8388608ull);		  // PTX L1955
	r_LaneIndexAtPtx1957 = uint32_t((threadIdx.x & 31u));									  // PTX L1957
	r_PtxRegister818 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1957), uint32_t(31));		  // PTX L1959
	r_PtxRegister819 = ShiftRight(uint32_t(r_PtxRegister818), uint32_t(30));				  // PTX L1960
	r_PtxRegister820 = uint32_t(r_LaneIndexAtPtx1957) + uint32_t(r_PtxRegister819);			  // PTX L1961
	r_PtxRegister821 = r_PtxRegister820 & 2147483644;										  // PTX L1962
	r_PtxRegister822 = uint32_t(r_LaneIndexAtPtx1957) - uint32_t(r_PtxRegister821);			  // PTX L1963
	r_PtxRegister823 = ShiftLeft(uint32_t(r_PtxRegister822), uint32_t(1));					  // PTX L1964
	r_PtxRegister824 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister823);				  // PTX L1965
	r_PtxRegister825 = ShiftRightSigned(int32_t(r_PtxRegister824), uint32_t(1));			  // PTX L1966
	r_PtxU64Register220 = uint64_t(int64_t(int32_t(r_PtxRegister825)) * int64_t(int32_t(4))); // PTX L1967
	g_RecordByteAddressAtPtx1968 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register220); // PTX L1968
	r_PtxRegister482 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1968 + 8388608ull);		  // PTX L1969
	r_LaneIndexAtPtx1971 = uint32_t((threadIdx.x & 31u));									  // PTX L1971
	r_PtxRegister826 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1971), uint32_t(31));		  // PTX L1973
	r_PtxRegister827 = ShiftRight(uint32_t(r_PtxRegister826), uint32_t(30));				  // PTX L1974
	r_PtxRegister828 = uint32_t(r_LaneIndexAtPtx1971) + uint32_t(r_PtxRegister827);			  // PTX L1975
	r_PtxRegister829 = r_PtxRegister828 & 2147483644;										  // PTX L1976
	r_PtxRegister830 = uint32_t(r_LaneIndexAtPtx1971) - uint32_t(r_PtxRegister829);			  // PTX L1977
	r_PtxRegister831 = ShiftLeft(uint32_t(r_PtxRegister830), uint32_t(1));					  // PTX L1978
	r_PtxRegister832 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister831);				  // PTX L1979
	r_PtxRegister833 = ShiftRightSigned(int32_t(r_PtxRegister832), uint32_t(1));			  // PTX L1980
	r_PtxU64Register222 = uint64_t(int64_t(int32_t(r_PtxRegister833)) * int64_t(int32_t(4))); // PTX L1981
	g_RecordByteAddressAtPtx1982 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register222); // PTX L1982
	r_PtxRegister484 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1982 + 8388608ull);		  // PTX L1983
	r_LaneIndexAtPtx1985 = uint32_t((threadIdx.x & 31u));									  // PTX L1985
	r_PtxRegister834 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1985), uint32_t(31));		  // PTX L1987
	r_PtxRegister835 = ShiftRight(uint32_t(r_PtxRegister834), uint32_t(30));				  // PTX L1988
	r_PtxRegister836 = uint32_t(r_LaneIndexAtPtx1985) + uint32_t(r_PtxRegister835);			  // PTX L1989
	r_PtxRegister837 = r_PtxRegister836 & 2147483644;										  // PTX L1990
	r_PtxRegister838 = uint32_t(r_LaneIndexAtPtx1985) - uint32_t(r_PtxRegister837);			  // PTX L1991
	r_PtxRegister839 = ShiftLeft(uint32_t(r_PtxRegister838), uint32_t(1));					  // PTX L1992
	r_PtxRegister840 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister839);				  // PTX L1993
	r_PtxRegister841 = ShiftRightSigned(int32_t(r_PtxRegister840), uint32_t(1));			  // PTX L1994
	r_PtxU64Register224 = uint64_t(int64_t(int32_t(r_PtxRegister841)) * int64_t(int32_t(4))); // PTX L1995
	g_RecordByteAddressAtPtx1996 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register224); // PTX L1996
	r_PtxRegister486 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1996 + 8388608ull);		  // PTX L1997
	r_LaneIndexAtPtx1999 = uint32_t((threadIdx.x & 31u));									  // PTX L1999
	r_PtxRegister842 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1999), uint32_t(31));		  // PTX L2001
	r_PtxRegister843 = ShiftRight(uint32_t(r_PtxRegister842), uint32_t(30));				  // PTX L2002
	r_PtxRegister844 = uint32_t(r_LaneIndexAtPtx1999) + uint32_t(r_PtxRegister843);			  // PTX L2003
	r_PtxRegister845 = r_PtxRegister844 & 2147483644;										  // PTX L2004
	r_PtxRegister846 = uint32_t(r_LaneIndexAtPtx1999) - uint32_t(r_PtxRegister845);			  // PTX L2005
	r_PtxRegister847 = ShiftLeft(uint32_t(r_PtxRegister846), uint32_t(1));					  // PTX L2006
	r_PtxRegister848 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister847);				  // PTX L2007
	r_PtxRegister849 = ShiftRightSigned(int32_t(r_PtxRegister848), uint32_t(1));			  // PTX L2008
	r_PtxU64Register226 = uint64_t(int64_t(int32_t(r_PtxRegister849)) * int64_t(int32_t(4))); // PTX L2009
	g_RecordByteAddressAtPtx2010 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register226); // PTX L2010
	r_PtxRegister488 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2010 + 8388608ull);		  // PTX L2011
	r_LaneIndexAtPtx2013 = uint32_t((threadIdx.x & 31u));									  // PTX L2013
	r_PtxRegister850 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2013), uint32_t(31));		  // PTX L2015
	r_PtxRegister851 = ShiftRight(uint32_t(r_PtxRegister850), uint32_t(30));				  // PTX L2016
	r_PtxRegister852 = uint32_t(r_LaneIndexAtPtx2013) + uint32_t(r_PtxRegister851);			  // PTX L2017
	r_PtxRegister853 = r_PtxRegister852 & 2147483644;										  // PTX L2018
	r_PtxRegister854 = uint32_t(r_LaneIndexAtPtx2013) - uint32_t(r_PtxRegister853);			  // PTX L2019
	r_PtxRegister855 = ShiftLeft(uint32_t(r_PtxRegister854), uint32_t(1));					  // PTX L2020
	r_PtxRegister856 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister855);				  // PTX L2021
	r_PtxRegister857 = ShiftRightSigned(int32_t(r_PtxRegister856), uint32_t(1));			  // PTX L2022
	r_PtxU64Register228 = uint64_t(int64_t(int32_t(r_PtxRegister857)) * int64_t(int32_t(4))); // PTX L2023
	g_RecordByteAddressAtPtx2024 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register228); // PTX L2024
	r_PtxRegister490 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2024 + 8388608ull);		  // PTX L2025
	r_LaneIndexAtPtx2027 = uint32_t((threadIdx.x & 31u));									  // PTX L2027
	r_PtxRegister858 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2027), uint32_t(31));		  // PTX L2029
	r_PtxRegister859 = ShiftRight(uint32_t(r_PtxRegister858), uint32_t(30));				  // PTX L2030
	r_PtxRegister860 = uint32_t(r_LaneIndexAtPtx2027) + uint32_t(r_PtxRegister859);			  // PTX L2031
	r_PtxRegister861 = r_PtxRegister860 & 2147483644;										  // PTX L2032
	r_PtxRegister862 = uint32_t(r_LaneIndexAtPtx2027) - uint32_t(r_PtxRegister861);			  // PTX L2033
	r_PtxRegister863 = ShiftLeft(uint32_t(r_PtxRegister862), uint32_t(1));					  // PTX L2034
	r_PtxRegister864 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister863);				  // PTX L2035
	r_PtxRegister865 = ShiftRightSigned(int32_t(r_PtxRegister864), uint32_t(1));			  // PTX L2036
	r_PtxU64Register230 = uint64_t(int64_t(int32_t(r_PtxRegister865)) * int64_t(int32_t(4))); // PTX L2037
	g_RecordByteAddressAtPtx2038 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register230); // PTX L2038
	r_PtxRegister492 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2038 + 8388608ull);		  // PTX L2039
	r_LaneIndexAtPtx2041 = uint32_t((threadIdx.x & 31u));									  // PTX L2041
	r_PtxRegister866 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2041), uint32_t(31));		  // PTX L2043
	r_PtxRegister867 = ShiftRight(uint32_t(r_PtxRegister866), uint32_t(30));				  // PTX L2044
	r_PtxRegister868 = uint32_t(r_LaneIndexAtPtx2041) + uint32_t(r_PtxRegister867);			  // PTX L2045
	r_PtxRegister869 = r_PtxRegister868 & 2147483644;										  // PTX L2046
	r_PtxRegister870 = uint32_t(r_LaneIndexAtPtx2041) - uint32_t(r_PtxRegister869);			  // PTX L2047
	r_PtxRegister871 = ShiftLeft(uint32_t(r_PtxRegister870), uint32_t(1));					  // PTX L2048
	r_PtxRegister872 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister871);				  // PTX L2049
	r_PtxRegister873 = ShiftRightSigned(int32_t(r_PtxRegister872), uint32_t(1));			  // PTX L2050
	r_PtxU64Register232 = uint64_t(int64_t(int32_t(r_PtxRegister873)) * int64_t(int32_t(4))); // PTX L2051
	g_RecordByteAddressAtPtx2052 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register232); // PTX L2052
	r_PtxRegister494 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2052 + 8388608ull);		  // PTX L2053
	r_LaneIndexAtPtx2055 = uint32_t((threadIdx.x & 31u));									  // PTX L2055
	r_PtxRegister874 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2055), uint32_t(31));		  // PTX L2057
	r_PtxRegister875 = ShiftRight(uint32_t(r_PtxRegister874), uint32_t(30));				  // PTX L2058
	r_PtxRegister876 = uint32_t(r_LaneIndexAtPtx2055) + uint32_t(r_PtxRegister875);			  // PTX L2059
	r_PtxRegister877 = r_PtxRegister876 & 2147483644;										  // PTX L2060
	r_PtxRegister878 = uint32_t(r_LaneIndexAtPtx2055) - uint32_t(r_PtxRegister877);			  // PTX L2061
	r_PtxRegister879 = ShiftLeft(uint32_t(r_PtxRegister878), uint32_t(1));					  // PTX L2062
	r_PtxRegister880 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister879);				  // PTX L2063
	r_PtxRegister881 = ShiftRightSigned(int32_t(r_PtxRegister880), uint32_t(1));			  // PTX L2064
	r_PtxU64Register234 = uint64_t(int64_t(int32_t(r_PtxRegister881)) * int64_t(int32_t(4))); // PTX L2065
	g_RecordByteAddressAtPtx2066 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register234); // PTX L2066
	r_PtxRegister496 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2066 + 8388608ull);		  // PTX L2067
	r_LaneIndexAtPtx2069 = uint32_t((threadIdx.x & 31u));									  // PTX L2069
	r_PtxRegister882 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2069), uint32_t(31));		  // PTX L2071
	r_PtxRegister883 = ShiftRight(uint32_t(r_PtxRegister882), uint32_t(30));				  // PTX L2072
	r_PtxRegister884 = uint32_t(r_LaneIndexAtPtx2069) + uint32_t(r_PtxRegister883);			  // PTX L2073
	r_PtxRegister885 = r_PtxRegister884 & 2147483644;										  // PTX L2074
	r_PtxRegister886 = uint32_t(r_LaneIndexAtPtx2069) - uint32_t(r_PtxRegister885);			  // PTX L2075
	r_PtxRegister887 = ShiftLeft(uint32_t(r_PtxRegister886), uint32_t(1));					  // PTX L2076
	r_PtxRegister888 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister887);				  // PTX L2077
	r_PtxRegister889 = ShiftRightSigned(int32_t(r_PtxRegister888), uint32_t(1));			  // PTX L2078
	r_PtxU64Register236 = uint64_t(int64_t(int32_t(r_PtxRegister889)) * int64_t(int32_t(4))); // PTX L2079
	g_RecordByteAddressAtPtx2080 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register236); // PTX L2080
	r_PtxRegister498 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2080 + 8388608ull);		  // PTX L2081
	r_LaneIndexAtPtx2083 = uint32_t((threadIdx.x & 31u));									  // PTX L2083
	r_PtxRegister890 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2083), uint32_t(31));		  // PTX L2085
	r_PtxRegister891 = ShiftRight(uint32_t(r_PtxRegister890), uint32_t(30));				  // PTX L2086
	r_PtxRegister892 = uint32_t(r_LaneIndexAtPtx2083) + uint32_t(r_PtxRegister891);			  // PTX L2087
	r_PtxRegister893 = r_PtxRegister892 & 2147483644;										  // PTX L2088
	r_PtxRegister894 = uint32_t(r_LaneIndexAtPtx2083) - uint32_t(r_PtxRegister893);			  // PTX L2089
	r_PtxRegister895 = ShiftLeft(uint32_t(r_PtxRegister894), uint32_t(1));					  // PTX L2090
	r_PtxRegister896 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister895);				  // PTX L2091
	r_PtxRegister897 = ShiftRightSigned(int32_t(r_PtxRegister896), uint32_t(1));			  // PTX L2092
	r_PtxU64Register238 = uint64_t(int64_t(int32_t(r_PtxRegister897)) * int64_t(int32_t(4))); // PTX L2093
	g_RecordByteAddressAtPtx2094 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register238); // PTX L2094
	r_PtxRegister500 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2094 + 8388608ull);		  // PTX L2095
	r_LaneIndexAtPtx2097 = uint32_t((threadIdx.x & 31u));									  // PTX L2097
	r_PtxRegister898 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2097), uint32_t(31));		  // PTX L2099
	r_PtxRegister899 = ShiftRight(uint32_t(r_PtxRegister898), uint32_t(30));				  // PTX L2100
	r_PtxRegister900 = uint32_t(r_LaneIndexAtPtx2097) + uint32_t(r_PtxRegister899);			  // PTX L2101
	r_PtxRegister901 = r_PtxRegister900 & 2147483644;										  // PTX L2102
	r_PtxRegister902 = uint32_t(r_LaneIndexAtPtx2097) - uint32_t(r_PtxRegister901);			  // PTX L2103
	r_PtxRegister903 = ShiftLeft(uint32_t(r_PtxRegister902), uint32_t(1));					  // PTX L2104
	r_PtxRegister904 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister903);				  // PTX L2105
	r_PtxRegister905 = ShiftRightSigned(int32_t(r_PtxRegister904), uint32_t(1));			  // PTX L2106
	r_PtxU64Register240 = uint64_t(int64_t(int32_t(r_PtxRegister905)) * int64_t(int32_t(4))); // PTX L2107
	g_RecordByteAddressAtPtx2108 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register240); // PTX L2108
	r_PtxRegister502 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2108 + 8388608ull);		  // PTX L2109
	r_LaneIndexAtPtx2111 = uint32_t((threadIdx.x & 31u));									  // PTX L2111
	r_PtxRegister906 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2111), uint32_t(31));		  // PTX L2113
	r_PtxRegister907 = ShiftRight(uint32_t(r_PtxRegister906), uint32_t(30));				  // PTX L2114
	r_PtxRegister908 = uint32_t(r_LaneIndexAtPtx2111) + uint32_t(r_PtxRegister907);			  // PTX L2115
	r_PtxRegister909 = r_PtxRegister908 & 2147483644;										  // PTX L2116
	r_PtxRegister910 = uint32_t(r_LaneIndexAtPtx2111) - uint32_t(r_PtxRegister909);			  // PTX L2117
	r_PtxRegister911 = ShiftLeft(uint32_t(r_PtxRegister910), uint32_t(1));					  // PTX L2118
	r_PtxRegister912 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister911);				  // PTX L2119
	r_PtxRegister913 = ShiftRightSigned(int32_t(r_PtxRegister912), uint32_t(1));			  // PTX L2120
	r_PtxU64Register242 = uint64_t(int64_t(int32_t(r_PtxRegister913)) * int64_t(int32_t(4))); // PTX L2121
	g_RecordByteAddressAtPtx2122 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register242); // PTX L2122
	r_PtxRegister504 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2122 + 8388608ull);		  // PTX L2123
	r_LaneIndexAtPtx2125 = uint32_t((threadIdx.x & 31u));									  // PTX L2125
	r_PtxRegister914 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2125), uint32_t(31));		  // PTX L2127
	r_PtxRegister915 = ShiftRight(uint32_t(r_PtxRegister914), uint32_t(30));				  // PTX L2128
	r_PtxRegister916 = uint32_t(r_LaneIndexAtPtx2125) + uint32_t(r_PtxRegister915);			  // PTX L2129
	r_PtxRegister917 = r_PtxRegister916 & 2147483644;										  // PTX L2130
	r_PtxRegister918 = uint32_t(r_LaneIndexAtPtx2125) - uint32_t(r_PtxRegister917);			  // PTX L2131
	r_PtxRegister919 = ShiftLeft(uint32_t(r_PtxRegister918), uint32_t(1));					  // PTX L2132
	r_PtxRegister920 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister919);				  // PTX L2133
	r_PtxRegister921 = ShiftRightSigned(int32_t(r_PtxRegister920), uint32_t(1));			  // PTX L2134
	r_PtxU64Register244 = uint64_t(int64_t(int32_t(r_PtxRegister921)) * int64_t(int32_t(4))); // PTX L2135
	g_RecordByteAddressAtPtx2136 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register244); // PTX L2136
	r_PtxRegister506 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2136 + 8388608ull);		  // PTX L2137
	r_LaneIndexAtPtx2139 = uint32_t((threadIdx.x & 31u));									  // PTX L2139
	r_PtxRegister922 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2139), uint32_t(31));		  // PTX L2141
	r_PtxRegister923 = ShiftRight(uint32_t(r_PtxRegister922), uint32_t(30));				  // PTX L2142
	r_PtxRegister924 = uint32_t(r_LaneIndexAtPtx2139) + uint32_t(r_PtxRegister923);			  // PTX L2143
	r_PtxRegister925 = r_PtxRegister924 & 2147483644;										  // PTX L2144
	r_PtxRegister926 = uint32_t(r_LaneIndexAtPtx2139) - uint32_t(r_PtxRegister925);			  // PTX L2145
	r_PtxRegister927 = ShiftLeft(uint32_t(r_PtxRegister926), uint32_t(1));					  // PTX L2146
	r_PtxRegister928 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister927);				  // PTX L2147
	r_PtxRegister929 = ShiftRightSigned(int32_t(r_PtxRegister928), uint32_t(1));			  // PTX L2148
	r_PtxU64Register246 = uint64_t(int64_t(int32_t(r_PtxRegister929)) * int64_t(int32_t(4))); // PTX L2149
	g_RecordByteAddressAtPtx2150 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register246); // PTX L2150
	r_PtxRegister508 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2150 + 8388608ull);		  // PTX L2151
	r_LaneIndexAtPtx2153 = uint32_t((threadIdx.x & 31u));									  // PTX L2153
	r_PtxRegister930 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2153), uint32_t(31));		  // PTX L2155
	r_PtxRegister931 = ShiftRight(uint32_t(r_PtxRegister930), uint32_t(30));				  // PTX L2156
	r_PtxRegister932 = uint32_t(r_LaneIndexAtPtx2153) + uint32_t(r_PtxRegister931);			  // PTX L2157
	r_PtxRegister933 = r_PtxRegister932 & 2147483644;										  // PTX L2158
	r_PtxRegister934 = uint32_t(r_LaneIndexAtPtx2153) - uint32_t(r_PtxRegister933);			  // PTX L2159
	r_PtxRegister935 = ShiftLeft(uint32_t(r_PtxRegister934), uint32_t(1));					  // PTX L2160
	r_PtxRegister936 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister935);				  // PTX L2161
	r_PtxRegister937 = ShiftRightSigned(int32_t(r_PtxRegister936), uint32_t(1));			  // PTX L2162
	r_PtxU64Register248 = uint64_t(int64_t(int32_t(r_PtxRegister937)) * int64_t(int32_t(4))); // PTX L2163
	g_RecordByteAddressAtPtx2164 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register248); // PTX L2164
	r_PtxRegister510 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2164 + 8388608ull);		  // PTX L2165
	r_LaneIndexAtPtx2167 = uint32_t((threadIdx.x & 31u));									  // PTX L2167
	r_PtxRegister938 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2167), uint32_t(31));		  // PTX L2169
	r_PtxRegister939 = ShiftRight(uint32_t(r_PtxRegister938), uint32_t(30));				  // PTX L2170
	r_PtxRegister940 = uint32_t(r_LaneIndexAtPtx2167) + uint32_t(r_PtxRegister939);			  // PTX L2171
	r_PtxRegister941 = r_PtxRegister940 & 2147483644;										  // PTX L2172
	r_PtxRegister942 = uint32_t(r_LaneIndexAtPtx2167) - uint32_t(r_PtxRegister941);			  // PTX L2173
	r_PtxRegister943 = ShiftLeft(uint32_t(r_PtxRegister942), uint32_t(1));					  // PTX L2174
	r_PtxRegister944 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister943);				  // PTX L2175
	r_PtxRegister945 = ShiftRightSigned(int32_t(r_PtxRegister944), uint32_t(1));			  // PTX L2176
	r_PtxU64Register250 = uint64_t(int64_t(int32_t(r_PtxRegister945)) * int64_t(int32_t(4))); // PTX L2177
	g_RecordByteAddressAtPtx2178 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register250); // PTX L2178
	r_PtxRegister512 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2178 + 8388608ull);		  // PTX L2179
	r_LaneIndexAtPtx2181 = uint32_t((threadIdx.x & 31u));									  // PTX L2181
	r_PtxRegister946 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2181), uint32_t(31));		  // PTX L2183
	r_PtxRegister947 = ShiftRight(uint32_t(r_PtxRegister946), uint32_t(30));				  // PTX L2184
	r_PtxRegister948 = uint32_t(r_LaneIndexAtPtx2181) + uint32_t(r_PtxRegister947);			  // PTX L2185
	r_PtxRegister949 = r_PtxRegister948 & 2147483644;										  // PTX L2186
	r_PtxRegister950 = uint32_t(r_LaneIndexAtPtx2181) - uint32_t(r_PtxRegister949);			  // PTX L2187
	r_PtxRegister951 = ShiftLeft(uint32_t(r_PtxRegister950), uint32_t(1));					  // PTX L2188
	r_PtxRegister952 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister951);				  // PTX L2189
	r_PtxRegister953 = ShiftRightSigned(int32_t(r_PtxRegister952), uint32_t(1));			  // PTX L2190
	r_PtxU64Register252 = uint64_t(int64_t(int32_t(r_PtxRegister953)) * int64_t(int32_t(4))); // PTX L2191
	g_RecordByteAddressAtPtx2192 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register252); // PTX L2192
	r_PtxRegister514 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2192 + 8388608ull);		  // PTX L2193
	r_LaneIndexAtPtx2195 = uint32_t((threadIdx.x & 31u));									  // PTX L2195
	r_PtxRegister954 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2195), uint32_t(31));		  // PTX L2197
	r_PtxRegister955 = ShiftRight(uint32_t(r_PtxRegister954), uint32_t(30));				  // PTX L2198
	r_PtxRegister956 = uint32_t(r_LaneIndexAtPtx2195) + uint32_t(r_PtxRegister955);			  // PTX L2199
	r_PtxRegister957 = r_PtxRegister956 & 2147483644;										  // PTX L2200
	r_PtxRegister958 = uint32_t(r_LaneIndexAtPtx2195) - uint32_t(r_PtxRegister957);			  // PTX L2201
	r_PtxRegister959 = ShiftLeft(uint32_t(r_PtxRegister958), uint32_t(1));					  // PTX L2202
	r_PtxRegister960 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister959);				  // PTX L2203
	r_PtxRegister961 = ShiftRightSigned(int32_t(r_PtxRegister960), uint32_t(1));			  // PTX L2204
	r_PtxU64Register254 = uint64_t(int64_t(int32_t(r_PtxRegister961)) * int64_t(int32_t(4))); // PTX L2205
	g_RecordByteAddressAtPtx2206 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register254); // PTX L2206
	r_PtxRegister516 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2206 + 8388608ull);		  // PTX L2207
	r_LaneIndexAtPtx2209 = uint32_t((threadIdx.x & 31u));									  // PTX L2209
	r_PtxRegister962 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2209), uint32_t(31));		  // PTX L2211
	r_PtxRegister963 = ShiftRight(uint32_t(r_PtxRegister962), uint32_t(30));				  // PTX L2212
	r_PtxRegister964 = uint32_t(r_LaneIndexAtPtx2209) + uint32_t(r_PtxRegister963);			  // PTX L2213
	r_PtxRegister965 = r_PtxRegister964 & 2147483644;										  // PTX L2214
	r_PtxRegister966 = uint32_t(r_LaneIndexAtPtx2209) - uint32_t(r_PtxRegister965);			  // PTX L2215
	r_PtxRegister967 = ShiftLeft(uint32_t(r_PtxRegister966), uint32_t(1));					  // PTX L2216
	r_PtxRegister968 = uint32_t(r_PtxRegister547) + uint32_t(r_PtxRegister967);				  // PTX L2217
	r_PtxRegister969 = ShiftRightSigned(int32_t(r_PtxRegister968), uint32_t(1));			  // PTX L2218
	r_PtxU64Register256 = uint64_t(int64_t(int32_t(r_PtxRegister969)) * int64_t(int32_t(4))); // PTX L2219
	g_RecordByteAddressAtPtx2220 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register256); // PTX L2220
	r_PtxRegister518 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2220 + 8388608ull);		  // PTX L2221
	r_LaneIndexAtPtx2223 = uint32_t((threadIdx.x & 31u));									  // PTX L2223
	r_PtxRegister970 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2223), uint32_t(31));		  // PTX L2225
	r_PtxRegister971 = ShiftRight(uint32_t(r_PtxRegister970), uint32_t(30));				  // PTX L2226
	r_PtxRegister972 = uint32_t(r_LaneIndexAtPtx2223) + uint32_t(r_PtxRegister971);			  // PTX L2227
	r_PtxRegister973 = r_PtxRegister972 & 2147483644;										  // PTX L2228
	r_PtxRegister974 = uint32_t(r_LaneIndexAtPtx2223) - uint32_t(r_PtxRegister973);			  // PTX L2229
	r_PtxRegister975 = ShiftLeft(uint32_t(r_PtxRegister974), uint32_t(1));					  // PTX L2230
	r_PtxRegister976 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister975);				  // PTX L2231
	r_PtxRegister977 = ShiftRightSigned(int32_t(r_PtxRegister976), uint32_t(1));			  // PTX L2232
	r_PtxU64Register258 = uint64_t(int64_t(int32_t(r_PtxRegister977)) * int64_t(int32_t(4))); // PTX L2233
	g_RecordByteAddressAtPtx2234 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register258); // PTX L2234
	r_PtxRegister520 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2234 + 8388608ull);		  // PTX L2235
	r_LaneIndexAtPtx2237 = uint32_t((threadIdx.x & 31u));									  // PTX L2237
	r_PtxRegister978 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2237), uint32_t(31));		  // PTX L2239
	r_PtxRegister979 = ShiftRight(uint32_t(r_PtxRegister978), uint32_t(30));				  // PTX L2240
	r_PtxRegister980 = uint32_t(r_LaneIndexAtPtx2237) + uint32_t(r_PtxRegister979);			  // PTX L2241
	r_PtxRegister981 = r_PtxRegister980 & 2147483644;										  // PTX L2242
	r_PtxRegister982 = uint32_t(r_LaneIndexAtPtx2237) - uint32_t(r_PtxRegister981);			  // PTX L2243
	r_PtxRegister983 = ShiftLeft(uint32_t(r_PtxRegister982), uint32_t(1));					  // PTX L2244
	r_PtxRegister984 = uint32_t(r_PtxRegister586) + uint32_t(r_PtxRegister983);				  // PTX L2245
	r_PtxRegister985 = ShiftRightSigned(int32_t(r_PtxRegister984), uint32_t(1));			  // PTX L2246
	r_PtxU64Register260 = uint64_t(int64_t(int32_t(r_PtxRegister985)) * int64_t(int32_t(4))); // PTX L2247
	g_RecordByteAddressAtPtx2248 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register260); // PTX L2248
	r_PtxRegister522 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2248 + 8388608ull);		  // PTX L2249
	r_LaneIndexAtPtx2251 = uint32_t((threadIdx.x & 31u));									  // PTX L2251
	r_PtxRegister986 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2251), uint32_t(31));		  // PTX L2253
	r_PtxRegister987 = ShiftRight(uint32_t(r_PtxRegister986), uint32_t(30));				  // PTX L2254
	r_PtxRegister988 = uint32_t(r_LaneIndexAtPtx2251) + uint32_t(r_PtxRegister987);			  // PTX L2255
	r_PtxRegister989 = r_PtxRegister988 & 2147483644;										  // PTX L2256
	r_PtxRegister990 = uint32_t(r_LaneIndexAtPtx2251) - uint32_t(r_PtxRegister989);			  // PTX L2257
	r_PtxRegister991 = ShiftLeft(uint32_t(r_PtxRegister990), uint32_t(1));					  // PTX L2258
	r_PtxRegister992 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister991);				  // PTX L2259
	r_PtxRegister993 = ShiftRightSigned(int32_t(r_PtxRegister992), uint32_t(1));			  // PTX L2260
	r_PtxU64Register262 = uint64_t(int64_t(int32_t(r_PtxRegister993)) * int64_t(int32_t(4))); // PTX L2261
	g_RecordByteAddressAtPtx2262 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register262); // PTX L2262
	r_PtxRegister524 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2262 + 8388608ull);		   // PTX L2263
	r_LaneIndexAtPtx2265 = uint32_t((threadIdx.x & 31u));									   // PTX L2265
	r_PtxRegister994 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2265), uint32_t(31));		   // PTX L2267
	r_PtxRegister995 = ShiftRight(uint32_t(r_PtxRegister994), uint32_t(30));				   // PTX L2268
	r_PtxRegister996 = uint32_t(r_LaneIndexAtPtx2265) + uint32_t(r_PtxRegister995);			   // PTX L2269
	r_PtxRegister997 = r_PtxRegister996 & 2147483644;										   // PTX L2270
	r_PtxRegister998 = uint32_t(r_LaneIndexAtPtx2265) - uint32_t(r_PtxRegister997);			   // PTX L2271
	r_PtxRegister999 = ShiftLeft(uint32_t(r_PtxRegister998), uint32_t(1));					   // PTX L2272
	r_PtxRegister1000 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister999);			   // PTX L2273
	r_PtxRegister1001 = ShiftRightSigned(int32_t(r_PtxRegister1000), uint32_t(1));			   // PTX L2274
	r_PtxU64Register264 = uint64_t(int64_t(int32_t(r_PtxRegister1001)) * int64_t(int32_t(4))); // PTX L2275
	g_RecordByteAddressAtPtx2276 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register264); // PTX L2276
	r_PtxRegister526 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2276 + 8388608ull);		   // PTX L2277
	r_LaneIndexAtPtx2279 = uint32_t((threadIdx.x & 31u));									   // PTX L2279
	r_PtxRegister1002 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2279), uint32_t(31));		   // PTX L2281
	r_PtxRegister1003 = ShiftRight(uint32_t(r_PtxRegister1002), uint32_t(30));				   // PTX L2282
	r_PtxRegister1004 = uint32_t(r_LaneIndexAtPtx2279) + uint32_t(r_PtxRegister1003);		   // PTX L2283
	r_PtxRegister1005 = r_PtxRegister1004 & 2147483644;										   // PTX L2284
	r_PtxRegister1006 = uint32_t(r_LaneIndexAtPtx2279) - uint32_t(r_PtxRegister1005);		   // PTX L2285
	r_PtxRegister1007 = ShiftLeft(uint32_t(r_PtxRegister1006), uint32_t(1));				   // PTX L2286
	r_PtxRegister1008 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister1007);			   // PTX L2287
	r_PtxRegister1009 = ShiftRightSigned(int32_t(r_PtxRegister1008), uint32_t(1));			   // PTX L2288
	r_PtxU64Register266 = uint64_t(int64_t(int32_t(r_PtxRegister1009)) * int64_t(int32_t(4))); // PTX L2289
	g_RecordByteAddressAtPtx2290 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register266); // PTX L2290
	r_PtxRegister528 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2290 + 8388608ull);		   // PTX L2291
	r_LaneIndexAtPtx2293 = uint32_t((threadIdx.x & 31u));									   // PTX L2293
	r_PtxRegister1010 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2293), uint32_t(31));		   // PTX L2295
	r_PtxRegister1011 = ShiftRight(uint32_t(r_PtxRegister1010), uint32_t(30));				   // PTX L2296
	r_PtxRegister1012 = uint32_t(r_LaneIndexAtPtx2293) + uint32_t(r_PtxRegister1011);		   // PTX L2297
	r_PtxRegister1013 = r_PtxRegister1012 & 2147483644;										   // PTX L2298
	r_PtxRegister1014 = uint32_t(r_LaneIndexAtPtx2293) - uint32_t(r_PtxRegister1013);		   // PTX L2299
	r_PtxRegister1015 = ShiftLeft(uint32_t(r_PtxRegister1014), uint32_t(1));				   // PTX L2300
	r_PtxRegister1016 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister1015);			   // PTX L2301
	r_PtxRegister1017 = ShiftRightSigned(int32_t(r_PtxRegister1016), uint32_t(1));			   // PTX L2302
	r_PtxU64Register268 = uint64_t(int64_t(int32_t(r_PtxRegister1017)) * int64_t(int32_t(4))); // PTX L2303
	g_RecordByteAddressAtPtx2304 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register268); // PTX L2304
	r_PtxRegister530 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2304 + 8388608ull);		   // PTX L2305
	r_LaneIndexAtPtx2307 = uint32_t((threadIdx.x & 31u));									   // PTX L2307
	r_PtxRegister1018 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2307), uint32_t(31));		   // PTX L2309
	r_PtxRegister1019 = ShiftRight(uint32_t(r_PtxRegister1018), uint32_t(30));				   // PTX L2310
	r_PtxRegister1020 = uint32_t(r_LaneIndexAtPtx2307) + uint32_t(r_PtxRegister1019);		   // PTX L2311
	r_PtxRegister1021 = r_PtxRegister1020 & 2147483644;										   // PTX L2312
	r_PtxRegister1022 = uint32_t(r_LaneIndexAtPtx2307) - uint32_t(r_PtxRegister1021);		   // PTX L2313
	r_PtxRegister1023 = ShiftLeft(uint32_t(r_PtxRegister1022), uint32_t(1));				   // PTX L2314
	r_PtxRegister1024 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister1023);			   // PTX L2315
	r_PtxRegister1025 = ShiftRightSigned(int32_t(r_PtxRegister1024), uint32_t(1));			   // PTX L2316
	r_PtxU64Register270 = uint64_t(int64_t(int32_t(r_PtxRegister1025)) * int64_t(int32_t(4))); // PTX L2317
	g_RecordByteAddressAtPtx2318 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register270); // PTX L2318
	r_PtxRegister532 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2318 + 8388608ull);		   // PTX L2319
	r_LaneIndexAtPtx2321 = uint32_t((threadIdx.x & 31u));									   // PTX L2321
	r_PtxRegister1026 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2321), uint32_t(31));		   // PTX L2323
	r_PtxRegister1027 = ShiftRight(uint32_t(r_PtxRegister1026), uint32_t(30));				   // PTX L2324
	r_PtxRegister1028 = uint32_t(r_LaneIndexAtPtx2321) + uint32_t(r_PtxRegister1027);		   // PTX L2325
	r_PtxRegister1029 = r_PtxRegister1028 & 2147483644;										   // PTX L2326
	r_PtxRegister1030 = uint32_t(r_LaneIndexAtPtx2321) - uint32_t(r_PtxRegister1029);		   // PTX L2327
	r_PtxRegister1031 = ShiftLeft(uint32_t(r_PtxRegister1030), uint32_t(1));				   // PTX L2328
	r_PtxRegister1032 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister1031);			   // PTX L2329
	r_PtxRegister1033 = ShiftRightSigned(int32_t(r_PtxRegister1032), uint32_t(1));			   // PTX L2330
	r_PtxU64Register272 = uint64_t(int64_t(int32_t(r_PtxRegister1033)) * int64_t(int32_t(4))); // PTX L2331
	g_RecordByteAddressAtPtx2332 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register272); // PTX L2332
	r_PtxRegister534 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2332 + 8388608ull);		   // PTX L2333
	r_LaneIndexAtPtx2335 = uint32_t((threadIdx.x & 31u));									   // PTX L2335
	r_PtxRegister1034 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2335), uint32_t(31));		   // PTX L2337
	r_PtxRegister1035 = ShiftRight(uint32_t(r_PtxRegister1034), uint32_t(30));				   // PTX L2338
	r_PtxRegister1036 = uint32_t(r_LaneIndexAtPtx2335) + uint32_t(r_PtxRegister1035);		   // PTX L2339
	r_PtxRegister1037 = r_PtxRegister1036 & 2147483644;										   // PTX L2340
	r_PtxRegister1038 = uint32_t(r_LaneIndexAtPtx2335) - uint32_t(r_PtxRegister1037);		   // PTX L2341
	r_PtxRegister1039 = ShiftLeft(uint32_t(r_PtxRegister1038), uint32_t(1));				   // PTX L2342
	r_PtxRegister1040 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister1039);			   // PTX L2343
	r_PtxRegister1041 = ShiftRightSigned(int32_t(r_PtxRegister1040), uint32_t(1));			   // PTX L2344
	r_PtxU64Register274 = uint64_t(int64_t(int32_t(r_PtxRegister1041)) * int64_t(int32_t(4))); // PTX L2345
	g_RecordByteAddressAtPtx2346 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register274); // PTX L2346
	r_PtxRegister536 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2346 + 8388608ull);		   // PTX L2347
	r_LaneIndexAtPtx2349 = uint32_t((threadIdx.x & 31u));									   // PTX L2349
	r_PtxRegister1042 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2349), uint32_t(31));		   // PTX L2351
	r_PtxRegister1043 = ShiftRight(uint32_t(r_PtxRegister1042), uint32_t(30));				   // PTX L2352
	r_PtxRegister1044 = uint32_t(r_LaneIndexAtPtx2349) + uint32_t(r_PtxRegister1043);		   // PTX L2353
	r_PtxRegister1045 = r_PtxRegister1044 & 2147483644;										   // PTX L2354
	r_PtxRegister1046 = uint32_t(r_LaneIndexAtPtx2349) - uint32_t(r_PtxRegister1045);		   // PTX L2355
	r_PtxRegister1047 = ShiftLeft(uint32_t(r_PtxRegister1046), uint32_t(1));				   // PTX L2356
	r_PtxRegister1048 = uint32_t(r_PtxRegister654) + uint32_t(r_PtxRegister1047);			   // PTX L2357
	r_PtxRegister1049 = ShiftRightSigned(int32_t(r_PtxRegister1048), uint32_t(1));			   // PTX L2358
	r_PtxU64Register276 = uint64_t(int64_t(int32_t(r_PtxRegister1049)) * int64_t(int32_t(4))); // PTX L2359
	g_RecordByteAddressAtPtx2360 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register276); // PTX L2360
	r_PtxRegister538 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2360 + 8388608ull);		   // PTX L2361
	r_LaneIndexAtPtx2363 = uint32_t((threadIdx.x & 31u));									   // PTX L2363
	r_PtxRegister1050 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2363), uint32_t(31));		   // PTX L2365
	r_PtxRegister1051 = ShiftRight(uint32_t(r_PtxRegister1050), uint32_t(30));				   // PTX L2366
	r_PtxRegister1052 = uint32_t(r_LaneIndexAtPtx2363) + uint32_t(r_PtxRegister1051);		   // PTX L2367
	r_PtxRegister1053 = r_PtxRegister1052 & 2147483644;										   // PTX L2368
	r_PtxRegister1054 = uint32_t(r_LaneIndexAtPtx2363) - uint32_t(r_PtxRegister1053);		   // PTX L2369
	r_PtxRegister1055 = ShiftLeft(uint32_t(r_PtxRegister1054), uint32_t(1));				   // PTX L2370
	r_PtxRegister1056 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister1055);			   // PTX L2371
	r_PtxRegister1057 = ShiftRightSigned(int32_t(r_PtxRegister1056), uint32_t(1));			   // PTX L2372
	r_PtxU64Register278 = uint64_t(int64_t(int32_t(r_PtxRegister1057)) * int64_t(int32_t(4))); // PTX L2373
	g_RecordByteAddressAtPtx2374 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register278); // PTX L2374
	r_PtxRegister540 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2374 + 8388608ull);		   // PTX L2375
	r_LaneIndexAtPtx2377 = uint32_t((threadIdx.x & 31u));									   // PTX L2377
	r_PtxRegister1058 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2377), uint32_t(31));		   // PTX L2379
	r_PtxRegister1059 = ShiftRight(uint32_t(r_PtxRegister1058), uint32_t(30));				   // PTX L2380
	r_PtxRegister1060 = uint32_t(r_LaneIndexAtPtx2377) + uint32_t(r_PtxRegister1059);		   // PTX L2381
	r_PtxRegister1061 = r_PtxRegister1060 & 2147483644;										   // PTX L2382
	r_PtxRegister1062 = uint32_t(r_LaneIndexAtPtx2377) - uint32_t(r_PtxRegister1061);		   // PTX L2383
	r_PtxRegister1063 = ShiftLeft(uint32_t(r_PtxRegister1062), uint32_t(1));				   // PTX L2384
	r_PtxRegister1064 = uint32_t(r_PtxRegister671) + uint32_t(r_PtxRegister1063);			   // PTX L2385
	r_PtxRegister1065 = ShiftRightSigned(int32_t(r_PtxRegister1064), uint32_t(1));			   // PTX L2386
	r_PtxU64Register280 = uint64_t(int64_t(int32_t(r_PtxRegister1065)) * int64_t(int32_t(4))); // PTX L2387
	g_RecordByteAddressAtPtx2388 =
		uint64_t(g_RecordByteAddressAtPtx1482) + uint64_t(r_PtxU64Register280); // PTX L2388
	r_PtxRegister542 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2388 + 8388608ull);	  // PTX L2389
	r_LaneIndexAtPtx2391 = uint32_t((threadIdx.x & 31u));								  // PTX L2391
	r_PackedHalf2AtPtx1090R1687 = HalfMul(r_PackedHalf2AtPtx1100R1545, r_PtxRegister416); // PTX L2394
	r_LaneIndexAtPtx2398 = uint32_t((threadIdx.x & 31u));								  // PTX L2398
	r_PackedHalf2AtPtx1089R1686 = HalfMul(r_PackedHalf2AtPtx1101R1546, r_PtxRegister418); // PTX L2401
	r_LaneIndexAtPtx2405 = uint32_t((threadIdx.x & 31u));								  // PTX L2405
	r_PackedHalf2AtPtx1088R1685 = HalfMul(r_PackedHalf2AtPtx1102R1547, r_PtxRegister420); // PTX L2408
	r_LaneIndexAtPtx2412 = uint32_t((threadIdx.x & 31u));								  // PTX L2412
	r_PackedHalf2AtPtx1087R1684 = HalfMul(r_PackedHalf2AtPtx1103R1548, r_PtxRegister422); // PTX L2415
	r_LaneIndexAtPtx2419 = uint32_t((threadIdx.x & 31u));								  // PTX L2419
	r_PackedHalf2AtPtx1086R1683 = HalfMul(r_PackedHalf2AtPtx1124R1550, r_PtxRegister424); // PTX L2422
	r_LaneIndexAtPtx2426 = uint32_t((threadIdx.x & 31u));								  // PTX L2426
	r_PackedHalf2AtPtx1085R1682 = HalfMul(r_PackedHalf2AtPtx1125R1551, r_PtxRegister426); // PTX L2429
	r_LaneIndexAtPtx2433 = uint32_t((threadIdx.x & 31u));								  // PTX L2433
	r_PackedHalf2AtPtx1084R1681 = HalfMul(r_PackedHalf2AtPtx1126R1552, r_PtxRegister428); // PTX L2436
	r_LaneIndexAtPtx2440 = uint32_t((threadIdx.x & 31u));								  // PTX L2440
	r_PackedHalf2AtPtx1083R1680 = HalfMul(r_PackedHalf2AtPtx1127R1553, r_PtxRegister430); // PTX L2443
	r_LaneIndexAtPtx2447 = uint32_t((threadIdx.x & 31u));								  // PTX L2447
	r_PackedHalf2AtPtx1082R1679 = HalfMul(r_PackedHalf2AtPtx1148R1555, r_PtxRegister432); // PTX L2450
	r_LaneIndexAtPtx2454 = uint32_t((threadIdx.x & 31u));								  // PTX L2454
	r_PackedHalf2AtPtx1081R1678 = HalfMul(r_PackedHalf2AtPtx1149R1556, r_PtxRegister434); // PTX L2457
	r_LaneIndexAtPtx2461 = uint32_t((threadIdx.x & 31u));								  // PTX L2461
	r_PackedHalf2AtPtx1080R1677 = HalfMul(r_PackedHalf2AtPtx1150R1557, r_PtxRegister436); // PTX L2464
	r_LaneIndexAtPtx2468 = uint32_t((threadIdx.x & 31u));								  // PTX L2468
	r_PackedHalf2AtPtx1079R1676 = HalfMul(r_PackedHalf2AtPtx1151R1558, r_PtxRegister438); // PTX L2471
	r_LaneIndexAtPtx2475 = uint32_t((threadIdx.x & 31u));								  // PTX L2475
	r_PackedHalf2AtPtx1078R1675 = HalfMul(r_PackedHalf2AtPtx1172R1560, r_PtxRegister440); // PTX L2478
	r_LaneIndexAtPtx2482 = uint32_t((threadIdx.x & 31u));								  // PTX L2482
	r_PackedHalf2AtPtx1077R1674 = HalfMul(r_PackedHalf2AtPtx1173R1561, r_PtxRegister442); // PTX L2485
	r_LaneIndexAtPtx2489 = uint32_t((threadIdx.x & 31u));								  // PTX L2489
	r_PackedHalf2AtPtx1076R1673 = HalfMul(r_PackedHalf2AtPtx1174R1562, r_PtxRegister444); // PTX L2492
	r_LaneIndexAtPtx2496 = uint32_t((threadIdx.x & 31u));								  // PTX L2496
	r_PackedHalf2AtPtx1075R1672 = HalfMul(r_PackedHalf2AtPtx1175R1563, r_PtxRegister446); // PTX L2499
	r_LaneIndexAtPtx2503 = uint32_t((threadIdx.x & 31u));								  // PTX L2503
	r_PackedHalf2AtPtx1074R1671 = HalfMul(r_PackedHalf2AtPtx1197R1565, r_PtxRegister448); // PTX L2506
	r_LaneIndexAtPtx2510 = uint32_t((threadIdx.x & 31u));								  // PTX L2510
	r_PackedHalf2AtPtx1073R1670 = HalfMul(r_PackedHalf2AtPtx1198R1566, r_PtxRegister450); // PTX L2513
	r_LaneIndexAtPtx2517 = uint32_t((threadIdx.x & 31u));								  // PTX L2517
	r_PackedHalf2AtPtx1072R1669 = HalfMul(r_PackedHalf2AtPtx1199R1567, r_PtxRegister452); // PTX L2520
	r_LaneIndexAtPtx2524 = uint32_t((threadIdx.x & 31u));								  // PTX L2524
	r_PackedHalf2AtPtx1071R1668 = HalfMul(r_PackedHalf2AtPtx1200R1568, r_PtxRegister454); // PTX L2527
	r_LaneIndexAtPtx2531 = uint32_t((threadIdx.x & 31u));								  // PTX L2531
	r_PackedHalf2AtPtx1070R1667 = HalfMul(r_PackedHalf2AtPtx1221R1570, r_PtxRegister456); // PTX L2534
	r_LaneIndexAtPtx2538 = uint32_t((threadIdx.x & 31u));								  // PTX L2538
	r_PackedHalf2AtPtx1069R1666 = HalfMul(r_PackedHalf2AtPtx1222R1571, r_PtxRegister458); // PTX L2541
	r_LaneIndexAtPtx2545 = uint32_t((threadIdx.x & 31u));								  // PTX L2545
	r_PackedHalf2AtPtx1068R1665 = HalfMul(r_PackedHalf2AtPtx1223R1572, r_PtxRegister460); // PTX L2548
	r_LaneIndexAtPtx2552 = uint32_t((threadIdx.x & 31u));								  // PTX L2552
	r_PackedHalf2AtPtx1067R1664 = HalfMul(r_PackedHalf2AtPtx1224R1573, r_PtxRegister462); // PTX L2555
	r_LaneIndexAtPtx2559 = uint32_t((threadIdx.x & 31u));								  // PTX L2559
	r_PackedHalf2AtPtx1066R1663 = HalfMul(r_PackedHalf2AtPtx1245R1575, r_PtxRegister464); // PTX L2562
	r_LaneIndexAtPtx2566 = uint32_t((threadIdx.x & 31u));								  // PTX L2566
	r_PackedHalf2AtPtx1065R1662 = HalfMul(r_PackedHalf2AtPtx1246R1576, r_PtxRegister466); // PTX L2569
	r_LaneIndexAtPtx2573 = uint32_t((threadIdx.x & 31u));								  // PTX L2573
	r_PackedHalf2AtPtx1064R1661 = HalfMul(r_PackedHalf2AtPtx1247R1577, r_PtxRegister468); // PTX L2576
	r_LaneIndexAtPtx2580 = uint32_t((threadIdx.x & 31u));								  // PTX L2580
	r_PackedHalf2AtPtx1063R1660 = HalfMul(r_PackedHalf2AtPtx1248R1578, r_PtxRegister470); // PTX L2583
	r_LaneIndexAtPtx2587 = uint32_t((threadIdx.x & 31u));								  // PTX L2587
	r_PackedHalf2AtPtx1062R1659 = HalfMul(r_PackedHalf2AtPtx1269R1580, r_PtxRegister472); // PTX L2590
	r_LaneIndexAtPtx2594 = uint32_t((threadIdx.x & 31u));								  // PTX L2594
	r_PackedHalf2AtPtx1061R1658 = HalfMul(r_PackedHalf2AtPtx1270R1581, r_PtxRegister474); // PTX L2597
	r_LaneIndexAtPtx2601 = uint32_t((threadIdx.x & 31u));								  // PTX L2601
	r_PackedHalf2AtPtx1060R1657 = HalfMul(r_PackedHalf2AtPtx1271R1582, r_PtxRegister476); // PTX L2604
	r_LaneIndexAtPtx2608 = uint32_t((threadIdx.x & 31u));								  // PTX L2608
	r_PackedHalf2AtPtx1059R1656 = HalfMul(r_PackedHalf2AtPtx1272R1583, r_PtxRegister478); // PTX L2611
	r_LaneIndexAtPtx2615 = uint32_t((threadIdx.x & 31u));								  // PTX L2615
	r_PackedHalf2AtPtx1058R1655 = HalfMul(r_PackedHalf2AtPtx1294R1585, r_PtxRegister480); // PTX L2618
	r_LaneIndexAtPtx2622 = uint32_t((threadIdx.x & 31u));								  // PTX L2622
	r_PackedHalf2AtPtx1057R1654 = HalfMul(r_PackedHalf2AtPtx1295R1586, r_PtxRegister482); // PTX L2625
	r_LaneIndexAtPtx2629 = uint32_t((threadIdx.x & 31u));								  // PTX L2629
	r_PackedHalf2AtPtx1056R1653 = HalfMul(r_PackedHalf2AtPtx1296R1587, r_PtxRegister484); // PTX L2632
	r_LaneIndexAtPtx2636 = uint32_t((threadIdx.x & 31u));								  // PTX L2636
	r_PackedHalf2AtPtx1055R1652 = HalfMul(r_PackedHalf2AtPtx1297R1588, r_PtxRegister486); // PTX L2639
	r_LaneIndexAtPtx2643 = uint32_t((threadIdx.x & 31u));								  // PTX L2643
	r_PackedHalf2AtPtx1054R1651 = HalfMul(r_PackedHalf2AtPtx1318R1590, r_PtxRegister488); // PTX L2646
	r_LaneIndexAtPtx2650 = uint32_t((threadIdx.x & 31u));								  // PTX L2650
	r_PackedHalf2AtPtx1053R1650 = HalfMul(r_PackedHalf2AtPtx1319R1591, r_PtxRegister490); // PTX L2653
	r_LaneIndexAtPtx2657 = uint32_t((threadIdx.x & 31u));								  // PTX L2657
	r_PackedHalf2AtPtx1052R1649 = HalfMul(r_PackedHalf2AtPtx1320R1592, r_PtxRegister492); // PTX L2660
	r_LaneIndexAtPtx2664 = uint32_t((threadIdx.x & 31u));								  // PTX L2664
	r_PackedHalf2AtPtx1051R1648 = HalfMul(r_PackedHalf2AtPtx1321R1593, r_PtxRegister494); // PTX L2667
	r_LaneIndexAtPtx2671 = uint32_t((threadIdx.x & 31u));								  // PTX L2671
	r_PackedHalf2AtPtx1050R1647 = HalfMul(r_PackedHalf2AtPtx1342R1595, r_PtxRegister496); // PTX L2674
	r_LaneIndexAtPtx2678 = uint32_t((threadIdx.x & 31u));								  // PTX L2678
	r_PackedHalf2AtPtx1049R1646 = HalfMul(r_PackedHalf2AtPtx1343R1596, r_PtxRegister498); // PTX L2681
	r_LaneIndexAtPtx2685 = uint32_t((threadIdx.x & 31u));								  // PTX L2685
	r_PackedHalf2AtPtx1048R1645 = HalfMul(r_PackedHalf2AtPtx1344R1597, r_PtxRegister500); // PTX L2688
	r_LaneIndexAtPtx2692 = uint32_t((threadIdx.x & 31u));								  // PTX L2692
	r_PackedHalf2AtPtx1047R1644 = HalfMul(r_PackedHalf2AtPtx1345R1598, r_PtxRegister502); // PTX L2695
	r_LaneIndexAtPtx2699 = uint32_t((threadIdx.x & 31u));								  // PTX L2699
	r_PackedHalf2AtPtx1046R1643 = HalfMul(r_PackedHalf2AtPtx1366R1600, r_PtxRegister504); // PTX L2702
	r_LaneIndexAtPtx2706 = uint32_t((threadIdx.x & 31u));								  // PTX L2706
	r_PackedHalf2AtPtx1045R1642 = HalfMul(r_PackedHalf2AtPtx1367R1601, r_PtxRegister506); // PTX L2709
	r_LaneIndexAtPtx2713 = uint32_t((threadIdx.x & 31u));								  // PTX L2713
	r_PackedHalf2AtPtx1044R1641 = HalfMul(r_PackedHalf2AtPtx1368R1602, r_PtxRegister508); // PTX L2716
	r_LaneIndexAtPtx2720 = uint32_t((threadIdx.x & 31u));								  // PTX L2720
	r_PackedHalf2AtPtx1043R1640 = HalfMul(r_PackedHalf2AtPtx1369R1603, r_PtxRegister510); // PTX L2723
	r_LaneIndexAtPtx2727 = uint32_t((threadIdx.x & 31u));								  // PTX L2727
	r_PackedHalf2AtPtx1042R1639 = HalfMul(r_PackedHalf2AtPtx1391R1605, r_PtxRegister512); // PTX L2730
	r_LaneIndexAtPtx2734 = uint32_t((threadIdx.x & 31u));								  // PTX L2734
	r_PackedHalf2AtPtx1041R1638 = HalfMul(r_PackedHalf2AtPtx1392R1606, r_PtxRegister514); // PTX L2737
	r_LaneIndexAtPtx2741 = uint32_t((threadIdx.x & 31u));								  // PTX L2741
	r_PackedHalf2AtPtx1040R1637 = HalfMul(r_PackedHalf2AtPtx1393R1607, r_PtxRegister516); // PTX L2744
	r_LaneIndexAtPtx2748 = uint32_t((threadIdx.x & 31u));								  // PTX L2748
	r_PackedHalf2AtPtx1039R1636 = HalfMul(r_PackedHalf2AtPtx1394R1608, r_PtxRegister518); // PTX L2751
	r_LaneIndexAtPtx2755 = uint32_t((threadIdx.x & 31u));								  // PTX L2755
	r_PackedHalf2AtPtx1038R1635 = HalfMul(r_PackedHalf2AtPtx1415R1610, r_PtxRegister520); // PTX L2758
	r_LaneIndexAtPtx2762 = uint32_t((threadIdx.x & 31u));								  // PTX L2762
	r_PackedHalf2AtPtx1037R1634 = HalfMul(r_PackedHalf2AtPtx1416R1611, r_PtxRegister522); // PTX L2765
	r_LaneIndexAtPtx2769 = uint32_t((threadIdx.x & 31u));								  // PTX L2769
	r_PackedHalf2AtPtx1036R1633 = HalfMul(r_PackedHalf2AtPtx1417R1612, r_PtxRegister524); // PTX L2772
	r_LaneIndexAtPtx2776 = uint32_t((threadIdx.x & 31u));								  // PTX L2776
	r_PackedHalf2AtPtx1035R1632 = HalfMul(r_PackedHalf2AtPtx1418R1613, r_PtxRegister526); // PTX L2779
	r_LaneIndexAtPtx2783 = uint32_t((threadIdx.x & 31u));								  // PTX L2783
	r_PackedHalf2AtPtx1034R1631 = HalfMul(r_PackedHalf2AtPtx1439R1615, r_PtxRegister528); // PTX L2786
	r_LaneIndexAtPtx2790 = uint32_t((threadIdx.x & 31u));								  // PTX L2790
	r_PackedHalf2AtPtx1033R1630 = HalfMul(r_PackedHalf2AtPtx1440R1616, r_PtxRegister530); // PTX L2793
	r_LaneIndexAtPtx2797 = uint32_t((threadIdx.x & 31u));								  // PTX L2797
	r_PackedHalf2AtPtx1032R1629 = HalfMul(r_PackedHalf2AtPtx1441R1617, r_PtxRegister532); // PTX L2800
	r_LaneIndexAtPtx2804 = uint32_t((threadIdx.x & 31u));								  // PTX L2804
	r_PackedHalf2AtPtx1031R1628 = HalfMul(r_PackedHalf2AtPtx1442R1618, r_PtxRegister534); // PTX L2807
	r_LaneIndexAtPtx2811 = uint32_t((threadIdx.x & 31u));								  // PTX L2811
	r_PackedHalf2AtPtx1030R1627 = HalfMul(r_PackedHalf2AtPtx1463R1620, r_PtxRegister536); // PTX L2814
	r_LaneIndexAtPtx2818 = uint32_t((threadIdx.x & 31u));								  // PTX L2818
	r_PackedHalf2AtPtx1029R1626 = HalfMul(r_PackedHalf2AtPtx1464R1621, r_PtxRegister538); // PTX L2821
	r_LaneIndexAtPtx2825 = uint32_t((threadIdx.x & 31u));								  // PTX L2825
	r_PackedHalf2AtPtx1028R1625 = HalfMul(r_PackedHalf2AtPtx1465R1622, r_PtxRegister540); // PTX L2828
	r_LaneIndexAtPtx2832 = uint32_t((threadIdx.x & 31u));								  // PTX L2832
	r_PackedHalf2AtPtx1027R1624 = HalfMul(r_PackedHalf2AtPtx1466R1623, r_PtxRegister542); // PTX L2835
L__BB44_192:																			  // PTX L2838
	r_PtxRegister1066 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));					  // PTX L2839
	r_PtxRegister34 = r_PtxRegister1066 & 2044;											  // PTX L2840
	r_PtxRegister35 = r_PtxRegister167 | 96;											  // PTX L2841
	r_PtxRegister1067 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(11));					  // PTX L2842
	r_PtxRegister36 = r_PtxRegister1067 & 2093056;										  // PTX L2843
	r_PtxRegister37 = r_PtxRegister95 & 523264;											  // PTX L2844
	r_PtxRegister38 = r_PtxRegister10 | 128;											  // PTX L2845
	r_PtxRegister1688 = uint32_t(0);													  // PTX L2846
	r_PtxRegister1186 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(2));				  // PTX L2847
L__BB44_193:																			  // PTX L2848
	r_PtxRegister1180 = ShiftRight(uint32_t(r_PtxRegister1688), uint32_t(5));			  // PTX L2849
	r_PtxU16Register7 = uint16_t(r_PtxRegister1180);									  // PTX L2850
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L2851
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L2852
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L2853
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L2854
	r_PtxRegister1181 = uint32_t(r_PtxU16Register11);											  // PTX L2855
	r_PtxRegister39 = r_PtxRegister1181 & 255;													  // PTX L2856
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L2857
	r_PtxRegister1182 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8192));		  // PTX L2858
	r_PtxU64Register4 = uint64_t(r_PtxRegister1182);											  // PTX L2859
	r_PtxRegister1183 = uint32_t(0u /* native shared input */);									  // PTX L2860
	r_PtxRegister40 = uint32_t(r_PtxRegister1183) + uint32_t(r_PtxRegister1182);				  // PTX L2861
	r_LaneIndexAtPtx2863 = uint32_t((threadIdx.x & 31u));										  // PTX L2863
	r_PtxRegister1184 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister36);					  // PTX L2865
	r_PtxRegister1185 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2863), uint32_t(4));					  // PTX L2866
	r_PtxRegister1069 = uint32_t(r_PtxRegister1184) + uint32_t(r_PtxRegister1185);				  // PTX L2867
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1069));
		r_MmaAHalf2WordAtPtx2869R1084 = r_Value.x;
		r_MmaAHalf2WordAtPtx2869R1085 = r_Value.y;
		r_MmaAHalf2WordAtPtx2869R1086 = r_Value.z;
		r_MmaAHalf2WordAtPtx2869R1087 = r_Value.w;
	} // PTX L2869
	r_LaneIndexAtPtx2872 = uint32_t((threadIdx.x & 31u));						   // PTX L2872
	r_PtxRegister1187 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister1186);   // PTX L2874
	r_PtxRegister1188 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2872), uint32_t(4));	   // PTX L2875
	r_PtxRegister1189 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1188); // PTX L2876
	r_PtxRegister1071 = uint32_t(r_PtxRegister1189) + uint32_t(512);			   // PTX L2877
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1071));
		r_MmaAHalf2WordAtPtx2879R1088 = r_Value.x;
		r_MmaAHalf2WordAtPtx2879R1089 = r_Value.y;
		r_MmaAHalf2WordAtPtx2879R1090 = r_Value.z;
		r_MmaAHalf2WordAtPtx2879R1091 = r_Value.w;
	} // PTX L2879
	r_LaneIndexAtPtx2882 = uint32_t((threadIdx.x & 31u));						   // PTX L2882
	r_PtxRegister1190 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2882), uint32_t(4));	   // PTX L2884
	r_PtxRegister1191 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1190); // PTX L2885
	r_PtxRegister1073 = uint32_t(r_PtxRegister1191) + uint32_t(1024);			   // PTX L2886
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1073));
		r_MmaAHalf2WordAtPtx2888R1108 = r_Value.x;
		r_MmaAHalf2WordAtPtx2888R1109 = r_Value.y;
		r_MmaAHalf2WordAtPtx2888R1110 = r_Value.z;
		r_MmaAHalf2WordAtPtx2888R1111 = r_Value.w;
	} // PTX L2888
	r_LaneIndexAtPtx2891 = uint32_t((threadIdx.x & 31u));						   // PTX L2891
	r_PtxRegister1192 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2891), uint32_t(4));	   // PTX L2893
	r_PtxRegister1193 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1192); // PTX L2894
	r_PtxRegister1075 = uint32_t(r_PtxRegister1193) + uint32_t(1536);			   // PTX L2895
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1075));
		r_MmaAHalf2WordAtPtx2897R1112 = r_Value.x;
		r_MmaAHalf2WordAtPtx2897R1113 = r_Value.y;
		r_MmaAHalf2WordAtPtx2897R1114 = r_Value.z;
		r_MmaAHalf2WordAtPtx2897R1115 = r_Value.w;
	} // PTX L2897
	r_LaneIndexAtPtx2900 = uint32_t((threadIdx.x & 31u));						   // PTX L2900
	r_PtxRegister1194 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2900), uint32_t(4));	   // PTX L2902
	r_PtxRegister1195 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1194); // PTX L2903
	r_PtxRegister1077 = uint32_t(r_PtxRegister1195) + uint32_t(2048);			   // PTX L2904
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1077));
		r_MmaAHalf2WordAtPtx2906R1132 = r_Value.x;
		r_MmaAHalf2WordAtPtx2906R1133 = r_Value.y;
		r_MmaAHalf2WordAtPtx2906R1134 = r_Value.z;
		r_MmaAHalf2WordAtPtx2906R1135 = r_Value.w;
	} // PTX L2906
	r_LaneIndexAtPtx2909 = uint32_t((threadIdx.x & 31u));						   // PTX L2909
	r_PtxRegister1196 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2909), uint32_t(4));	   // PTX L2911
	r_PtxRegister1197 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1196); // PTX L2912
	r_PtxRegister1079 = uint32_t(r_PtxRegister1197) + uint32_t(2560);			   // PTX L2913
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1079));
		r_MmaAHalf2WordAtPtx2915R1136 = r_Value.x;
		r_MmaAHalf2WordAtPtx2915R1137 = r_Value.y;
		r_MmaAHalf2WordAtPtx2915R1138 = r_Value.z;
		r_MmaAHalf2WordAtPtx2915R1139 = r_Value.w;
	} // PTX L2915
	r_LaneIndexAtPtx2918 = uint32_t((threadIdx.x & 31u));						   // PTX L2918
	r_PtxRegister1198 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2918), uint32_t(4));	   // PTX L2920
	r_PtxRegister1199 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1198); // PTX L2921
	r_PtxRegister1081 = uint32_t(r_PtxRegister1199) + uint32_t(3072);			   // PTX L2922
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1081));
		r_MmaAHalf2WordAtPtx2924R1156 = r_Value.x;
		r_MmaAHalf2WordAtPtx2924R1157 = r_Value.y;
		r_MmaAHalf2WordAtPtx2924R1158 = r_Value.z;
		r_MmaAHalf2WordAtPtx2924R1159 = r_Value.w;
	} // PTX L2924
	r_LaneIndexAtPtx2927 = uint32_t((threadIdx.x & 31u));						   // PTX L2927
	r_PtxRegister1200 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2927), uint32_t(4));	   // PTX L2929
	r_PtxRegister1201 = uint32_t(r_PtxRegister1187) + uint32_t(r_PtxRegister1200); // PTX L2930
	r_PtxRegister1083 = uint32_t(r_PtxRegister1201) + uint32_t(3584);			   // PTX L2931
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1083));
		r_MmaAHalf2WordAtPtx2933R1160 = r_Value.x;
		r_MmaAHalf2WordAtPtx2933R1161 = r_Value.y;
		r_MmaAHalf2WordAtPtx2933R1162 = r_Value.z;
		r_MmaAHalf2WordAtPtx2933R1163 = r_Value.w;
	} // PTX L2933
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2936R1092, r_MmaAccumulatorHalf2WordAtPtx2936R1093,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx81R1717, r_MmaBHalf2WordAtPtx81R1716,
			r_PackedHalf2AtPtx1090R1687, r_PackedHalf2AtPtx1089R1686); // PTX L2936
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2943R1094, r_MmaAccumulatorHalf2WordAtPtx2943R1095,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx81R1715, r_MmaBHalf2WordAtPtx81R1714,
			r_PackedHalf2AtPtx1088R1685, r_PackedHalf2AtPtx1087R1684); // PTX L2943
	MmaHalf(r_PackedHalf2AtPtx1090R1687, r_PackedHalf2AtPtx1089R1686, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx120R1701, r_MmaBHalf2WordAtPtx120R1700,
			r_MmaAccumulatorHalf2WordAtPtx2936R1092,
			r_MmaAccumulatorHalf2WordAtPtx2936R1093); // PTX L2950
	MmaHalf(r_PackedHalf2AtPtx1088R1685, r_PackedHalf2AtPtx1087R1684, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx120R1699, r_MmaBHalf2WordAtPtx120R1698,
			r_MmaAccumulatorHalf2WordAtPtx2943R1094,
			r_MmaAccumulatorHalf2WordAtPtx2943R1095); // PTX L2957
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2964R1096, r_MmaAccumulatorHalf2WordAtPtx2964R1097,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx91R1713, r_MmaBHalf2WordAtPtx91R1712,
			r_PackedHalf2AtPtx1086R1683, r_PackedHalf2AtPtx1085R1682); // PTX L2964
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2971R1098, r_MmaAccumulatorHalf2WordAtPtx2971R1099,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx91R1711, r_MmaBHalf2WordAtPtx91R1710,
			r_PackedHalf2AtPtx1084R1681, r_PackedHalf2AtPtx1083R1680); // PTX L2971
	MmaHalf(r_PackedHalf2AtPtx1086R1683, r_PackedHalf2AtPtx1085R1682, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx129R1697, r_MmaBHalf2WordAtPtx129R1696,
			r_MmaAccumulatorHalf2WordAtPtx2964R1096,
			r_MmaAccumulatorHalf2WordAtPtx2964R1097); // PTX L2978
	MmaHalf(r_PackedHalf2AtPtx1084R1681, r_PackedHalf2AtPtx1083R1680, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx129R1695, r_MmaBHalf2WordAtPtx129R1694,
			r_MmaAccumulatorHalf2WordAtPtx2971R1098,
			r_MmaAccumulatorHalf2WordAtPtx2971R1099); // PTX L2985
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2992R1100, r_MmaAccumulatorHalf2WordAtPtx2992R1101,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx101R1709, r_MmaBHalf2WordAtPtx101R1708,
			r_PackedHalf2AtPtx1082R1679, r_PackedHalf2AtPtx1081R1678); // PTX L2992
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2999R1102, r_MmaAccumulatorHalf2WordAtPtx2999R1103,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx101R1707, r_MmaBHalf2WordAtPtx101R1706,
			r_PackedHalf2AtPtx1080R1677, r_PackedHalf2AtPtx1079R1676); // PTX L2999
	MmaHalf(r_PackedHalf2AtPtx1082R1679, r_PackedHalf2AtPtx1081R1678, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx138R1693, r_MmaBHalf2WordAtPtx138R1692,
			r_MmaAccumulatorHalf2WordAtPtx2992R1100,
			r_MmaAccumulatorHalf2WordAtPtx2992R1101); // PTX L3006
	MmaHalf(r_PackedHalf2AtPtx1080R1677, r_PackedHalf2AtPtx1079R1676, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx138R1691, r_MmaBHalf2WordAtPtx138R1690,
			r_MmaAccumulatorHalf2WordAtPtx2999R1102,
			r_MmaAccumulatorHalf2WordAtPtx2999R1103); // PTX L3013
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3020R1104, r_MmaAccumulatorHalf2WordAtPtx3020R1105,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx111R1705, r_MmaBHalf2WordAtPtx111R1704,
			r_PackedHalf2AtPtx1078R1675, r_PackedHalf2AtPtx1077R1674); // PTX L3020
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3027R1106, r_MmaAccumulatorHalf2WordAtPtx3027R1107,
			r_MmaAHalf2WordAtPtx2869R1084, r_MmaAHalf2WordAtPtx2869R1085, r_MmaAHalf2WordAtPtx2869R1086,
			r_MmaAHalf2WordAtPtx2869R1087, r_MmaBHalf2WordAtPtx111R1703, r_MmaBHalf2WordAtPtx111R1702,
			r_PackedHalf2AtPtx1076R1673, r_PackedHalf2AtPtx1075R1672); // PTX L3027
	MmaHalf(r_PackedHalf2AtPtx1078R1675, r_PackedHalf2AtPtx1077R1674, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx147R1689, r_MmaBHalf2WordAtPtx147R1718,
			r_MmaAccumulatorHalf2WordAtPtx3020R1104,
			r_MmaAccumulatorHalf2WordAtPtx3020R1105); // PTX L3034
	MmaHalf(r_PackedHalf2AtPtx1076R1673, r_PackedHalf2AtPtx1075R1672, r_MmaAHalf2WordAtPtx2879R1088,
			r_MmaAHalf2WordAtPtx2879R1089, r_MmaAHalf2WordAtPtx2879R1090, r_MmaAHalf2WordAtPtx2879R1091,
			r_MmaBHalf2WordAtPtx147R1719, r_MmaBHalf2WordAtPtx147R1720,
			r_MmaAccumulatorHalf2WordAtPtx3027R1106,
			r_MmaAccumulatorHalf2WordAtPtx3027R1107); // PTX L3041
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3048R1116, r_MmaAccumulatorHalf2WordAtPtx3048R1117,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx81R1717, r_MmaBHalf2WordAtPtx81R1716,
			r_PackedHalf2AtPtx1074R1671, r_PackedHalf2AtPtx1073R1670); // PTX L3048
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3055R1118, r_MmaAccumulatorHalf2WordAtPtx3055R1119,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx81R1715, r_MmaBHalf2WordAtPtx81R1714,
			r_PackedHalf2AtPtx1072R1669, r_PackedHalf2AtPtx1071R1668); // PTX L3055
	MmaHalf(r_PackedHalf2AtPtx1074R1671, r_PackedHalf2AtPtx1073R1670, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx120R1701, r_MmaBHalf2WordAtPtx120R1700,
			r_MmaAccumulatorHalf2WordAtPtx3048R1116,
			r_MmaAccumulatorHalf2WordAtPtx3048R1117); // PTX L3062
	MmaHalf(r_PackedHalf2AtPtx1072R1669, r_PackedHalf2AtPtx1071R1668, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx120R1699, r_MmaBHalf2WordAtPtx120R1698,
			r_MmaAccumulatorHalf2WordAtPtx3055R1118,
			r_MmaAccumulatorHalf2WordAtPtx3055R1119); // PTX L3069
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3076R1120, r_MmaAccumulatorHalf2WordAtPtx3076R1121,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx91R1713, r_MmaBHalf2WordAtPtx91R1712,
			r_PackedHalf2AtPtx1070R1667, r_PackedHalf2AtPtx1069R1666); // PTX L3076
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3083R1122, r_MmaAccumulatorHalf2WordAtPtx3083R1123,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx91R1711, r_MmaBHalf2WordAtPtx91R1710,
			r_PackedHalf2AtPtx1068R1665, r_PackedHalf2AtPtx1067R1664); // PTX L3083
	MmaHalf(r_PackedHalf2AtPtx1070R1667, r_PackedHalf2AtPtx1069R1666, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx129R1697, r_MmaBHalf2WordAtPtx129R1696,
			r_MmaAccumulatorHalf2WordAtPtx3076R1120,
			r_MmaAccumulatorHalf2WordAtPtx3076R1121); // PTX L3090
	MmaHalf(r_PackedHalf2AtPtx1068R1665, r_PackedHalf2AtPtx1067R1664, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx129R1695, r_MmaBHalf2WordAtPtx129R1694,
			r_MmaAccumulatorHalf2WordAtPtx3083R1122,
			r_MmaAccumulatorHalf2WordAtPtx3083R1123); // PTX L3097
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3104R1124, r_MmaAccumulatorHalf2WordAtPtx3104R1125,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx101R1709, r_MmaBHalf2WordAtPtx101R1708,
			r_PackedHalf2AtPtx1066R1663, r_PackedHalf2AtPtx1065R1662); // PTX L3104
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3111R1126, r_MmaAccumulatorHalf2WordAtPtx3111R1127,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx101R1707, r_MmaBHalf2WordAtPtx101R1706,
			r_PackedHalf2AtPtx1064R1661, r_PackedHalf2AtPtx1063R1660); // PTX L3111
	MmaHalf(r_PackedHalf2AtPtx1066R1663, r_PackedHalf2AtPtx1065R1662, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx138R1693, r_MmaBHalf2WordAtPtx138R1692,
			r_MmaAccumulatorHalf2WordAtPtx3104R1124,
			r_MmaAccumulatorHalf2WordAtPtx3104R1125); // PTX L3118
	MmaHalf(r_PackedHalf2AtPtx1064R1661, r_PackedHalf2AtPtx1063R1660, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx138R1691, r_MmaBHalf2WordAtPtx138R1690,
			r_MmaAccumulatorHalf2WordAtPtx3111R1126,
			r_MmaAccumulatorHalf2WordAtPtx3111R1127); // PTX L3125
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3132R1128, r_MmaAccumulatorHalf2WordAtPtx3132R1129,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx111R1705, r_MmaBHalf2WordAtPtx111R1704,
			r_PackedHalf2AtPtx1062R1659, r_PackedHalf2AtPtx1061R1658); // PTX L3132
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3139R1130, r_MmaAccumulatorHalf2WordAtPtx3139R1131,
			r_MmaAHalf2WordAtPtx2888R1108, r_MmaAHalf2WordAtPtx2888R1109, r_MmaAHalf2WordAtPtx2888R1110,
			r_MmaAHalf2WordAtPtx2888R1111, r_MmaBHalf2WordAtPtx111R1703, r_MmaBHalf2WordAtPtx111R1702,
			r_PackedHalf2AtPtx1060R1657, r_PackedHalf2AtPtx1059R1656); // PTX L3139
	MmaHalf(r_PackedHalf2AtPtx1062R1659, r_PackedHalf2AtPtx1061R1658, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx147R1689, r_MmaBHalf2WordAtPtx147R1718,
			r_MmaAccumulatorHalf2WordAtPtx3132R1128,
			r_MmaAccumulatorHalf2WordAtPtx3132R1129); // PTX L3146
	MmaHalf(r_PackedHalf2AtPtx1060R1657, r_PackedHalf2AtPtx1059R1656, r_MmaAHalf2WordAtPtx2897R1112,
			r_MmaAHalf2WordAtPtx2897R1113, r_MmaAHalf2WordAtPtx2897R1114, r_MmaAHalf2WordAtPtx2897R1115,
			r_MmaBHalf2WordAtPtx147R1719, r_MmaBHalf2WordAtPtx147R1720,
			r_MmaAccumulatorHalf2WordAtPtx3139R1130,
			r_MmaAccumulatorHalf2WordAtPtx3139R1131); // PTX L3153
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3160R1140, r_MmaAccumulatorHalf2WordAtPtx3160R1141,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx81R1717, r_MmaBHalf2WordAtPtx81R1716,
			r_PackedHalf2AtPtx1058R1655, r_PackedHalf2AtPtx1057R1654); // PTX L3160
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3167R1142, r_MmaAccumulatorHalf2WordAtPtx3167R1143,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx81R1715, r_MmaBHalf2WordAtPtx81R1714,
			r_PackedHalf2AtPtx1056R1653, r_PackedHalf2AtPtx1055R1652); // PTX L3167
	MmaHalf(r_PackedHalf2AtPtx1058R1655, r_PackedHalf2AtPtx1057R1654, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx120R1701, r_MmaBHalf2WordAtPtx120R1700,
			r_MmaAccumulatorHalf2WordAtPtx3160R1140,
			r_MmaAccumulatorHalf2WordAtPtx3160R1141); // PTX L3174
	MmaHalf(r_PackedHalf2AtPtx1056R1653, r_PackedHalf2AtPtx1055R1652, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx120R1699, r_MmaBHalf2WordAtPtx120R1698,
			r_MmaAccumulatorHalf2WordAtPtx3167R1142,
			r_MmaAccumulatorHalf2WordAtPtx3167R1143); // PTX L3181
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3188R1144, r_MmaAccumulatorHalf2WordAtPtx3188R1145,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx91R1713, r_MmaBHalf2WordAtPtx91R1712,
			r_PackedHalf2AtPtx1054R1651, r_PackedHalf2AtPtx1053R1650); // PTX L3188
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3195R1146, r_MmaAccumulatorHalf2WordAtPtx3195R1147,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx91R1711, r_MmaBHalf2WordAtPtx91R1710,
			r_PackedHalf2AtPtx1052R1649, r_PackedHalf2AtPtx1051R1648); // PTX L3195
	MmaHalf(r_PackedHalf2AtPtx1054R1651, r_PackedHalf2AtPtx1053R1650, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx129R1697, r_MmaBHalf2WordAtPtx129R1696,
			r_MmaAccumulatorHalf2WordAtPtx3188R1144,
			r_MmaAccumulatorHalf2WordAtPtx3188R1145); // PTX L3202
	MmaHalf(r_PackedHalf2AtPtx1052R1649, r_PackedHalf2AtPtx1051R1648, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx129R1695, r_MmaBHalf2WordAtPtx129R1694,
			r_MmaAccumulatorHalf2WordAtPtx3195R1146,
			r_MmaAccumulatorHalf2WordAtPtx3195R1147); // PTX L3209
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3216R1148, r_MmaAccumulatorHalf2WordAtPtx3216R1149,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx101R1709, r_MmaBHalf2WordAtPtx101R1708,
			r_PackedHalf2AtPtx1050R1647, r_PackedHalf2AtPtx1049R1646); // PTX L3216
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3223R1150, r_MmaAccumulatorHalf2WordAtPtx3223R1151,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx101R1707, r_MmaBHalf2WordAtPtx101R1706,
			r_PackedHalf2AtPtx1048R1645, r_PackedHalf2AtPtx1047R1644); // PTX L3223
	MmaHalf(r_PackedHalf2AtPtx1050R1647, r_PackedHalf2AtPtx1049R1646, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx138R1693, r_MmaBHalf2WordAtPtx138R1692,
			r_MmaAccumulatorHalf2WordAtPtx3216R1148,
			r_MmaAccumulatorHalf2WordAtPtx3216R1149); // PTX L3230
	MmaHalf(r_PackedHalf2AtPtx1048R1645, r_PackedHalf2AtPtx1047R1644, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx138R1691, r_MmaBHalf2WordAtPtx138R1690,
			r_MmaAccumulatorHalf2WordAtPtx3223R1150,
			r_MmaAccumulatorHalf2WordAtPtx3223R1151); // PTX L3237
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3244R1152, r_MmaAccumulatorHalf2WordAtPtx3244R1153,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx111R1705, r_MmaBHalf2WordAtPtx111R1704,
			r_PackedHalf2AtPtx1046R1643, r_PackedHalf2AtPtx1045R1642); // PTX L3244
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3251R1154, r_MmaAccumulatorHalf2WordAtPtx3251R1155,
			r_MmaAHalf2WordAtPtx2906R1132, r_MmaAHalf2WordAtPtx2906R1133, r_MmaAHalf2WordAtPtx2906R1134,
			r_MmaAHalf2WordAtPtx2906R1135, r_MmaBHalf2WordAtPtx111R1703, r_MmaBHalf2WordAtPtx111R1702,
			r_PackedHalf2AtPtx1044R1641, r_PackedHalf2AtPtx1043R1640); // PTX L3251
	MmaHalf(r_PackedHalf2AtPtx1046R1643, r_PackedHalf2AtPtx1045R1642, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx147R1689, r_MmaBHalf2WordAtPtx147R1718,
			r_MmaAccumulatorHalf2WordAtPtx3244R1152,
			r_MmaAccumulatorHalf2WordAtPtx3244R1153); // PTX L3258
	MmaHalf(r_PackedHalf2AtPtx1044R1641, r_PackedHalf2AtPtx1043R1640, r_MmaAHalf2WordAtPtx2915R1136,
			r_MmaAHalf2WordAtPtx2915R1137, r_MmaAHalf2WordAtPtx2915R1138, r_MmaAHalf2WordAtPtx2915R1139,
			r_MmaBHalf2WordAtPtx147R1719, r_MmaBHalf2WordAtPtx147R1720,
			r_MmaAccumulatorHalf2WordAtPtx3251R1154,
			r_MmaAccumulatorHalf2WordAtPtx3251R1155); // PTX L3265
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3272R1164, r_MmaAccumulatorHalf2WordAtPtx3272R1165,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx81R1717, r_MmaBHalf2WordAtPtx81R1716,
			r_PackedHalf2AtPtx1042R1639, r_PackedHalf2AtPtx1041R1638); // PTX L3272
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3279R1166, r_MmaAccumulatorHalf2WordAtPtx3279R1167,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx81R1715, r_MmaBHalf2WordAtPtx81R1714,
			r_PackedHalf2AtPtx1040R1637, r_PackedHalf2AtPtx1039R1636); // PTX L3279
	MmaHalf(r_PackedHalf2AtPtx1042R1639, r_PackedHalf2AtPtx1041R1638, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx120R1701, r_MmaBHalf2WordAtPtx120R1700,
			r_MmaAccumulatorHalf2WordAtPtx3272R1164,
			r_MmaAccumulatorHalf2WordAtPtx3272R1165); // PTX L3286
	MmaHalf(r_PackedHalf2AtPtx1040R1637, r_PackedHalf2AtPtx1039R1636, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx120R1699, r_MmaBHalf2WordAtPtx120R1698,
			r_MmaAccumulatorHalf2WordAtPtx3279R1166,
			r_MmaAccumulatorHalf2WordAtPtx3279R1167); // PTX L3293
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3300R1168, r_MmaAccumulatorHalf2WordAtPtx3300R1169,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx91R1713, r_MmaBHalf2WordAtPtx91R1712,
			r_PackedHalf2AtPtx1038R1635, r_PackedHalf2AtPtx1037R1634); // PTX L3300
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3307R1170, r_MmaAccumulatorHalf2WordAtPtx3307R1171,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx91R1711, r_MmaBHalf2WordAtPtx91R1710,
			r_PackedHalf2AtPtx1036R1633, r_PackedHalf2AtPtx1035R1632); // PTX L3307
	MmaHalf(r_PackedHalf2AtPtx1038R1635, r_PackedHalf2AtPtx1037R1634, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx129R1697, r_MmaBHalf2WordAtPtx129R1696,
			r_MmaAccumulatorHalf2WordAtPtx3300R1168,
			r_MmaAccumulatorHalf2WordAtPtx3300R1169); // PTX L3314
	MmaHalf(r_PackedHalf2AtPtx1036R1633, r_PackedHalf2AtPtx1035R1632, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx129R1695, r_MmaBHalf2WordAtPtx129R1694,
			r_MmaAccumulatorHalf2WordAtPtx3307R1170,
			r_MmaAccumulatorHalf2WordAtPtx3307R1171); // PTX L3321
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3328R1172, r_MmaAccumulatorHalf2WordAtPtx3328R1173,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx101R1709, r_MmaBHalf2WordAtPtx101R1708,
			r_PackedHalf2AtPtx1034R1631, r_PackedHalf2AtPtx1033R1630); // PTX L3328
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3335R1174, r_MmaAccumulatorHalf2WordAtPtx3335R1175,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx101R1707, r_MmaBHalf2WordAtPtx101R1706,
			r_PackedHalf2AtPtx1032R1629, r_PackedHalf2AtPtx1031R1628); // PTX L3335
	MmaHalf(r_PackedHalf2AtPtx1034R1631, r_PackedHalf2AtPtx1033R1630, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx138R1693, r_MmaBHalf2WordAtPtx138R1692,
			r_MmaAccumulatorHalf2WordAtPtx3328R1172,
			r_MmaAccumulatorHalf2WordAtPtx3328R1173); // PTX L3342
	MmaHalf(r_PackedHalf2AtPtx1032R1629, r_PackedHalf2AtPtx1031R1628, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx138R1691, r_MmaBHalf2WordAtPtx138R1690,
			r_MmaAccumulatorHalf2WordAtPtx3335R1174,
			r_MmaAccumulatorHalf2WordAtPtx3335R1175); // PTX L3349
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3356R1176, r_MmaAccumulatorHalf2WordAtPtx3356R1177,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx111R1705, r_MmaBHalf2WordAtPtx111R1704,
			r_PackedHalf2AtPtx1030R1627, r_PackedHalf2AtPtx1029R1626); // PTX L3356
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx3363R1178, r_MmaAccumulatorHalf2WordAtPtx3363R1179,
			r_MmaAHalf2WordAtPtx2924R1156, r_MmaAHalf2WordAtPtx2924R1157, r_MmaAHalf2WordAtPtx2924R1158,
			r_MmaAHalf2WordAtPtx2924R1159, r_MmaBHalf2WordAtPtx111R1703, r_MmaBHalf2WordAtPtx111R1702,
			r_PackedHalf2AtPtx1028R1625, r_PackedHalf2AtPtx1027R1624); // PTX L3363
	MmaHalf(r_PackedHalf2AtPtx1030R1627, r_PackedHalf2AtPtx1029R1626, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx147R1689, r_MmaBHalf2WordAtPtx147R1718,
			r_MmaAccumulatorHalf2WordAtPtx3356R1176,
			r_MmaAccumulatorHalf2WordAtPtx3356R1177); // PTX L3370
	MmaHalf(r_PackedHalf2AtPtx1028R1625, r_PackedHalf2AtPtx1027R1624, r_MmaAHalf2WordAtPtx2933R1160,
			r_MmaAHalf2WordAtPtx2933R1161, r_MmaAHalf2WordAtPtx2933R1162, r_MmaAHalf2WordAtPtx2933R1163,
			r_MmaBHalf2WordAtPtx147R1719, r_MmaBHalf2WordAtPtx147R1720,
			r_MmaAccumulatorHalf2WordAtPtx3363R1178,
			r_MmaAccumulatorHalf2WordAtPtx3363R1179);				 // PTX L3377
	r_bPtxPredicate80 = uint32_t(r_PtxRegister1688) > uint32_t(991); // PTX L3383
	if (r_bPtxPredicate80)
	{
		goto L__BB44_196;
	} // PTX L3384
	r_PtxRegister1211 = uint32_t(r_PtxRegister1688) + uint32_t(32);								  // PTX L3385
	r_PtxRegister1212 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1688);				  // PTX L3386
	r_PtxRegister1213 = ShiftLeft(uint32_t(r_PtxRegister1212), uint32_t(9));					  // PTX L3387
	r_PtxRegister1214 = uint32_t(r_PtxRegister1213) + uint32_t(r_PtxRegister6);					  // PTX L3388
	r_PtxU64Register290 = uint64_t(int64_t(int32_t(r_PtxRegister1214)) * int64_t(int32_t(4)));	  // PTX L3389
	g_RecordByteAddressAtPtx3390 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register290); // PTX L3390
	r_LaneIndexAtPtx3392 = uint32_t((threadIdx.x & 31u));										  // PTX L3392
	r_PtxU64Register292 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3392)) * int64_t(int32_t(16))); // PTX L3394
	g_RecordByteAddressAtPtx3395 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register292); // PTX L3395
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3395));
		r_MmaBHalf2WordAtPtx81R1717 = r_Value.x;
		r_MmaBHalf2WordAtPtx81R1716 = r_Value.y;
		r_MmaBHalf2WordAtPtx81R1715 = r_Value.z;
		r_MmaBHalf2WordAtPtx81R1714 = r_Value.w;
	} // PTX L3397
	r_LaneIndexAtPtx3400 = uint32_t((threadIdx.x & 31u)); // PTX L3400
	r_PtxU64Register293 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3400)) * int64_t(int32_t(16))); // PTX L3402
	g_RecordByteAddressAtPtx3403 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register293);			   // PTX L3403
	g_RecordByteAddressAtPtx3404 = uint64_t(g_RecordByteAddressAtPtx3403) + uint64_t(512); // PTX L3404
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3404));
		r_MmaBHalf2WordAtPtx91R1713 = r_Value.x;
		r_MmaBHalf2WordAtPtx91R1712 = r_Value.y;
		r_MmaBHalf2WordAtPtx91R1711 = r_Value.z;
		r_MmaBHalf2WordAtPtx91R1710 = r_Value.w;
	} // PTX L3406
	r_LaneIndexAtPtx3409 = uint32_t((threadIdx.x & 31u)); // PTX L3409
	r_PtxU64Register295 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3409)) * int64_t(int32_t(16))); // PTX L3411
	g_RecordByteAddressAtPtx3412 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register295);				// PTX L3412
	g_RecordByteAddressAtPtx3413 = uint64_t(g_RecordByteAddressAtPtx3412) + uint64_t(1024); // PTX L3413
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3413));
		r_MmaBHalf2WordAtPtx101R1709 = r_Value.x;
		r_MmaBHalf2WordAtPtx101R1708 = r_Value.y;
		r_MmaBHalf2WordAtPtx101R1707 = r_Value.z;
		r_MmaBHalf2WordAtPtx101R1706 = r_Value.w;
	} // PTX L3415
	r_LaneIndexAtPtx3418 = uint32_t((threadIdx.x & 31u)); // PTX L3418
	r_PtxU64Register297 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3418)) * int64_t(int32_t(16))); // PTX L3420
	g_RecordByteAddressAtPtx3421 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register297);				// PTX L3421
	g_RecordByteAddressAtPtx3422 = uint64_t(g_RecordByteAddressAtPtx3421) + uint64_t(1536); // PTX L3422
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3422));
		r_MmaBHalf2WordAtPtx111R1705 = r_Value.x;
		r_MmaBHalf2WordAtPtx111R1704 = r_Value.y;
		r_MmaBHalf2WordAtPtx111R1703 = r_Value.z;
		r_MmaBHalf2WordAtPtx111R1702 = r_Value.w;
	} // PTX L3424
	r_LaneIndexAtPtx3427 = uint32_t((threadIdx.x & 31u)); // PTX L3427
	r_PtxU64Register299 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3427)) * int64_t(int32_t(16))); // PTX L3429
	g_RecordByteAddressAtPtx3430 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register299);				 // PTX L3430
	g_RecordByteAddressAtPtx3431 = uint64_t(g_RecordByteAddressAtPtx3430) + uint64_t(32768); // PTX L3431
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3431));
		r_MmaBHalf2WordAtPtx120R1701 = r_Value.x;
		r_MmaBHalf2WordAtPtx120R1700 = r_Value.y;
		r_MmaBHalf2WordAtPtx120R1699 = r_Value.z;
		r_MmaBHalf2WordAtPtx120R1698 = r_Value.w;
	} // PTX L3433
	r_LaneIndexAtPtx3436 = uint32_t((threadIdx.x & 31u)); // PTX L3436
	r_PtxU64Register301 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3436)) * int64_t(int32_t(16))); // PTX L3438
	g_RecordByteAddressAtPtx3439 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register301);				 // PTX L3439
	g_RecordByteAddressAtPtx3440 = uint64_t(g_RecordByteAddressAtPtx3439) + uint64_t(33280); // PTX L3440
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3440));
		r_MmaBHalf2WordAtPtx129R1697 = r_Value.x;
		r_MmaBHalf2WordAtPtx129R1696 = r_Value.y;
		r_MmaBHalf2WordAtPtx129R1695 = r_Value.z;
		r_MmaBHalf2WordAtPtx129R1694 = r_Value.w;
	} // PTX L3442
	r_LaneIndexAtPtx3445 = uint32_t((threadIdx.x & 31u)); // PTX L3445
	r_PtxU64Register303 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3445)) * int64_t(int32_t(16))); // PTX L3447
	g_RecordByteAddressAtPtx3448 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register303);				 // PTX L3448
	g_RecordByteAddressAtPtx3449 = uint64_t(g_RecordByteAddressAtPtx3448) + uint64_t(33792); // PTX L3449
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3449));
		r_MmaBHalf2WordAtPtx138R1693 = r_Value.x;
		r_MmaBHalf2WordAtPtx138R1692 = r_Value.y;
		r_MmaBHalf2WordAtPtx138R1691 = r_Value.z;
		r_MmaBHalf2WordAtPtx138R1690 = r_Value.w;
	} // PTX L3451
	r_LaneIndexAtPtx3454 = uint32_t((threadIdx.x & 31u)); // PTX L3454
	r_PtxU64Register305 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3454)) * int64_t(int32_t(16))); // PTX L3456
	g_RecordByteAddressAtPtx3457 =
		uint64_t(g_RecordByteAddressAtPtx3390) + uint64_t(r_PtxU64Register305);				 // PTX L3457
	g_RecordByteAddressAtPtx3458 = uint64_t(g_RecordByteAddressAtPtx3457) + uint64_t(34304); // PTX L3458
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3458));
		r_MmaBHalf2WordAtPtx147R1689 = r_Value.x;
		r_MmaBHalf2WordAtPtx147R1718 = r_Value.y;
		r_MmaBHalf2WordAtPtx147R1719 = r_Value.z;
		r_MmaBHalf2WordAtPtx147R1720 = r_Value.w;
	} // PTX L3460
	r_PtxRegister1215 = ShiftRight(uint32_t(r_PtxRegister1211), uint32_t(5)); // PTX L3462
	r_PtxU16Register13 = uint16_t(r_PtxRegister1215);						  // PTX L3463
	r_PtxU16Register14 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register13)) * uint32_t(uint16_t(171))); // PTX L3464
	r_PtxU16Register15 = ShiftRight(uint16_t(r_PtxU16Register14), uint32_t(9));		// PTX L3465
	r_PtxU16Register16 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register15)) * uint32_t(uint16_t(3)));				// PTX L3466
	r_PtxU16Register17 = uint16_t(r_PtxU16Register13) - uint16_t(r_PtxU16Register16);			// PTX L3467
	r_PtxU16Register18 = r_PtxU16Register17 & 255;												// PTX L3468
	r_PtxRegister1216 = uint32_t(uint16_t(r_PtxU16Register18)) * uint32_t(uint16_t(8));			// PTX L3469
	r_PtxRegister1217 = uint32_t(24576u /* native mbarriers */);								// PTX L3470
	r_PtxRegister1219 = uint32_t(r_PtxRegister1217) + uint32_t(r_PtxRegister1216);				// PTX L3471
	r_PtxRegister1210 = uint32_t(1);															// PTX L3472
	r_PtxU64Register307 = BarrierArrive(s_SharedStorage, r_PtxRegister1219, r_PtxRegister1210); // PTX L3474
L__BB44_195:																					// PTX L3476
	r_PtxRegister1218 = BarrierReady(s_SharedStorage, r_PtxRegister1219, r_PtxU64Register307);	// PTX L3478
	r_bPtxPredicate81 = uint32_t(r_PtxRegister1218) == uint32_t(0);								// PTX L3484
	if (r_bPtxPredicate81)
	{
		goto L__BB44_195;
	} // PTX L3485
L__BB44_196:																		 // PTX L3486
	r_PtxRegister41 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits) + uint32_t(14); // PTX L3487
	r_bPtxPredicate82 = uint32_t(r_PtxRegister1688) > uint32_t(927);				 // PTX L3488
	if (r_bPtxPredicate82)
	{
		goto L__BB44_235;
	} // PTX L3489
	r_PtxRegister42 = uint32_t(r_PtxRegister35) + uint32_t(r_PtxRegister1688);		   // PTX L3490
	r_PtxRegister43 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(3));			   // PTX L3491
	r_bPtxPredicate83 = uint32_t(r_PtxRegister41) < uint32_t(31);					   // PTX L3492
	r_PtxRegister44 = r_bPtxPredicate83 ? 0 : r_PtxRegister99;						   // PTX L3493
	r_PtxRegister45 = uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister43);		   // PTX L3494
	r_PtxRegister1220 = uint32_t(0u /* native shared input */);						   // PTX L3495
	r_PtxU64Register308 = uint64_t(r_PtxRegister1220);								   // PTX L3496
	r_PtxU64Register309 = SharedGeneric(s_SharedStorage, r_PtxU64Register308);		   // PTX L3497
	r_PtxU64Register310 = uint64_t(r_PtxU64Register309) + uint64_t(r_PtxU64Register4); // PTX L3498
	r_PtxU64Register5 = uint64_t(r_PtxU64Register310) + uint64_t(r_PtxU64Register43);  // PTX L3499
	r_PtxU16Register26 = uint16_t(0);												   // PTX L3500
	r_PtxU64Register604 = uint64_t(0);												   // PTX L3501
	r_PtxRegister1721 = uint32_t(128);												   // PTX L3502
	r_PtxRegister1722 = uint32_t(r_PtxRegister1721);								   // PTX L3503
	r_PtxU64Register605 = uint64_t(r_PtxU64Register604);							   // PTX L3504
	if (r_bPtxPredicate6)
	{
		goto L__BB44_199;
	} // PTX L3505
	r_PtxRegister1221 = r_bPtxPredicate1 ? r_PtxRegister45 : 0;								   // PTX L3506
	r_PtxU64Register311 = uint64_t(int64_t(int32_t(r_PtxRegister1221)) * int64_t(int32_t(4))); // PTX L3507
	r_PtxU64Register604 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register311);		   // PTX L3508
	r_PtxRegister1721 = uint32_t(r_PtxRegister1221) + uint32_t(128);						   // PTX L3509
	r_PtxU16Register26 = uint16_t(1);														   // PTX L3510
	r_PtxRegister1722 = uint32_t(r_PtxRegister38);											   // PTX L3511
	r_PtxU64Register605 = uint64_t(r_PtxU64Register5);										   // PTX L3512
L__BB44_199:																				   // PTX L3513
	if (r_bPtxPredicate6)
	{
		goto L__BB44_201;
	} // PTX L3514
	r_PtxRegister1222 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister44);		// PTX L3515
	r_PtxRegister1223 = uint32_t(r_PtxRegister1222) + uint32_t(128);				// PTX L3516
	r_bPtxPredicate84 = uint32_t(r_PtxRegister38) == uint32_t(r_PtxRegister1722);	// PTX L3517
	r_bPtxPredicate85 = uint32_t(r_PtxRegister1223) == uint32_t(r_PtxRegister1721); // PTX L3518
	r_PtxU16Register19 = r_bPtxPredicate85 ? r_PtxU16Register26 : 0;				// PTX L3519
	r_PtxU16Register26 = r_bPtxPredicate84 ? r_PtxU16Register19 : 0;				// PTX L3520
L__BB44_201:																		// PTX L3521
	r_bPtxPredicate86 = uint16_t(r_PtxU16Register26) == uint16_t(0);				// PTX L3522
	r_PtxRegister1224 = ShiftLeft(uint32_t(r_PtxRegister39), uint32_t(3));			// PTX L3523
	r_PtxRegister1225 = uint32_t(24576u /* native mbarriers */);					// PTX L3524
	r_PtxRegister46 = uint32_t(r_PtxRegister1225) + uint32_t(r_PtxRegister1224);	// PTX L3525
	if (r_bPtxPredicate86)
	{
		goto L__BB44_204;
	} // PTX L3526
	r_PtxRegister1227 = uint32_t(-1);								// PTX L3527
	r_PtxRegister1226 = Elected(r_PtxRegister1227);					// PTX L3529
	r_bPtxPredicate87 = uint32_t(r_PtxRegister1226) == uint32_t(0); // PTX L3535
	if (r_bPtxPredicate87)
	{
		goto L__BB44_216;
	} // PTX L3536
	r_PtxU64Register313 = SharedOffset(s_SharedStorage, r_PtxU64Register605); // PTX L3537
	r_PtxRegister1228 = uint32_t(r_PtxU64Register313);						  // PTX L3538
	r_PtxU64Register312 = r_PtxU64Register604;								  // PTX L3539
	r_PtxRegister1229 = uint32_t(1024);										  // PTX L3540
	CopyBulk(s_SharedStorage, r_PtxRegister1228, r_PtxU64Register312, r_PtxRegister1229,
			 r_PtxRegister46);											// PTX L3542
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1229); // PTX L3545
	goto L__BB44_216;													// PTX L3547
L__BB44_204:															// PTX L3548
	r_PtxU64Register6 = SignExtendWordBits(r_PtxRegister45);			// PTX L3549
	r_PtxU64Register606 = uint64_t(0);									// PTX L3550
	if (r_bPtxPredicate6)
	{
		goto L__BB44_206;
	} // PTX L3551
	r_PtxU64Register314 = r_bPtxPredicate1 ? r_PtxU64Register6 : 0;						// PTX L3552
	r_PtxU64Register315 = ShiftLeft(uint64_t(r_PtxU64Register314), uint32_t(2));		// PTX L3553
	r_PtxU64Register606 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register315); // PTX L3554
L__BB44_206:																			// PTX L3555
	r_PtxRegister1230 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));				// PTX L3556
	r_PtxRegister47 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister1230);			// PTX L3557
	if (r_bPtxPredicate6)
	{
		goto L__BB44_209;
	} // PTX L3558
	r_PtxRegister1235 = uint32_t(-1);								// PTX L3559
	r_PtxRegister1234 = Elected(r_PtxRegister1235);					// PTX L3561
	r_bPtxPredicate88 = uint32_t(r_PtxRegister1234) == uint32_t(0); // PTX L3567
	if (r_bPtxPredicate88)
	{
		goto L__BB44_210;
	} // PTX L3568
	r_PtxU64Register316 = r_PtxU64Register606; // PTX L3569
	r_PtxRegister1236 = uint32_t(512);		   // PTX L3570
	CopyBulk(s_SharedStorage, r_PtxRegister47, r_PtxU64Register316, r_PtxRegister1236,
			 r_PtxRegister46);													 // PTX L3572
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1236);			 // PTX L3575
	goto L__BB44_210;															 // PTX L3577
L__BB44_209:																	 // PTX L3578
	r_LaneIndexAtPtx3580 = uint32_t((threadIdx.x & 31u));						 // PTX L3580
	r_PtxRegister1233 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3580), uint32_t(4));	 // PTX L3582
	r_PtxRegister1232 = uint32_t(r_PtxRegister47) + uint32_t(r_PtxRegister1233); // PTX L3583
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1232)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800); // PTX L3585
L__BB44_210:									 // PTX L3587
	r_PtxU64Register607 = uint64_t(0);			 // PTX L3588
	if (r_bPtxPredicate6)
	{
		goto L__BB44_212;
	} // PTX L3589
	r_PtxRegister1237 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister44);			// PTX L3590
	r_PtxRegister1238 = uint32_t(r_PtxRegister1237) + uint32_t(128);					// PTX L3591
	r_PtxU64Register317 = SignExtendWordBits(r_PtxRegister1238);						// PTX L3592
	r_PtxU64Register318 = r_bPtxPredicate1 ? r_PtxU64Register317 : 0;					// PTX L3593
	r_PtxU64Register319 = ShiftLeft(uint64_t(r_PtxU64Register318), uint32_t(2));		// PTX L3594
	r_PtxU64Register607 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register319); // PTX L3595
L__BB44_212:																			// PTX L3596
	if (r_bPtxPredicate6)
	{
		goto L__BB44_215;
	} // PTX L3597
	r_PtxRegister1244 = uint32_t(-1);								// PTX L3598
	r_PtxRegister1243 = Elected(r_PtxRegister1244);					// PTX L3600
	r_bPtxPredicate89 = uint32_t(r_PtxRegister1243) == uint32_t(0); // PTX L3606
	if (r_bPtxPredicate89)
	{
		goto L__BB44_216;
	} // PTX L3607
	r_PtxRegister1245 = uint32_t(r_PtxRegister47) + uint32_t(512); // PTX L3608
	r_PtxU64Register320 = r_PtxU64Register607;					   // PTX L3609
	r_PtxRegister1246 = uint32_t(512);							   // PTX L3610
	CopyBulk(s_SharedStorage, r_PtxRegister1245, r_PtxU64Register320, r_PtxRegister1246,
			 r_PtxRegister46);													 // PTX L3612
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1246);			 // PTX L3615
	goto L__BB44_216;															 // PTX L3617
L__BB44_215:																	 // PTX L3618
	r_LaneIndexAtPtx3620 = uint32_t((threadIdx.x & 31u));						 // PTX L3620
	r_PtxRegister1241 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3620), uint32_t(4));	 // PTX L3622
	r_PtxRegister1242 = uint32_t(r_PtxRegister47) + uint32_t(r_PtxRegister1241); // PTX L3623
	r_PtxRegister1240 = uint32_t(r_PtxRegister1242) + uint32_t(512);			 // PTX L3624
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1240)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							 // PTX L3626
L__BB44_216:																 // PTX L3628
	r_PtxRegister1247 = uint32_t(r_PtxRegister99) + uint32_t(131072);		 // PTX L3629
	r_PtxRegister48 = r_bPtxPredicate83 ? 0 : r_PtxRegister1247;			 // PTX L3630
	r_PtxRegister49 = uint32_t(r_PtxRegister48) + uint32_t(r_PtxRegister43); // PTX L3631
	r_PtxU16Register27 = uint16_t(0);										 // PTX L3632
	r_PtxU64Register608 = uint64_t(0);										 // PTX L3633
	r_PtxRegister1723 = uint32_t(128);										 // PTX L3634
	r_PtxU64Register609 = uint64_t(r_PtxU64Register608);					 // PTX L3635
	if (r_bPtxPredicate15)
	{
		goto L__BB44_218;
	} // PTX L3636
	r_PtxRegister1248 = r_bPtxPredicate2 ? r_PtxRegister49 : 0;								   // PTX L3637
	r_PtxU64Register609 = uint64_t(r_PtxU64Register5) + uint64_t(4096);						   // PTX L3638
	r_PtxU64Register321 = uint64_t(int64_t(int32_t(r_PtxRegister1248)) * int64_t(int32_t(4))); // PTX L3639
	r_PtxU64Register608 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register321);		   // PTX L3640
	r_PtxRegister1723 = uint32_t(r_PtxRegister1248) + uint32_t(128);						   // PTX L3641
	r_PtxU16Register27 = uint16_t(1);														   // PTX L3642
L__BB44_218:																				   // PTX L3643
	if (r_bPtxPredicate15)
	{
		goto L__BB44_220;
	} // PTX L3644
	r_PtxRegister1249 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister48);		// PTX L3645
	r_PtxRegister1250 = uint32_t(r_PtxRegister1249) + uint32_t(128);				// PTX L3646
	r_bPtxPredicate90 = uint32_t(r_PtxRegister1250) == uint32_t(r_PtxRegister1723); // PTX L3647
	r_PtxU16Register27 = r_bPtxPredicate90 ? r_PtxU16Register27 : 0;				// PTX L3648
L__BB44_220:																		// PTX L3649
	r_bPtxPredicate91 = uint16_t(r_PtxU16Register27) == uint16_t(0);				// PTX L3650
	if (r_bPtxPredicate91)
	{
		goto L__BB44_223;
	} // PTX L3651
	r_PtxRegister1252 = uint32_t(-1);								// PTX L3652
	r_PtxRegister1251 = Elected(r_PtxRegister1252);					// PTX L3654
	r_bPtxPredicate92 = uint32_t(r_PtxRegister1251) == uint32_t(0); // PTX L3660
	if (r_bPtxPredicate92)
	{
		goto L__BB44_235;
	} // PTX L3661
	r_PtxU64Register323 = SharedOffset(s_SharedStorage, r_PtxU64Register609); // PTX L3662
	r_PtxRegister1253 = uint32_t(r_PtxU64Register323);						  // PTX L3663
	r_PtxU64Register322 = r_PtxU64Register608;								  // PTX L3664
	r_PtxRegister1254 = uint32_t(1024);										  // PTX L3665
	CopyBulk(s_SharedStorage, r_PtxRegister1253, r_PtxU64Register322, r_PtxRegister1254,
			 r_PtxRegister46);											// PTX L3667
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1254); // PTX L3670
	goto L__BB44_235;													// PTX L3672
L__BB44_223:															// PTX L3673
	r_PtxU64Register7 = SignExtendWordBits(r_PtxRegister49);			// PTX L3674
	r_PtxU64Register610 = uint64_t(0);									// PTX L3675
	if (r_bPtxPredicate15)
	{
		goto L__BB44_225;
	} // PTX L3676
	r_PtxU64Register324 = r_bPtxPredicate2 ? r_PtxU64Register7 : 0;						// PTX L3677
	r_PtxU64Register325 = ShiftLeft(uint64_t(r_PtxU64Register324), uint32_t(2));		// PTX L3678
	r_PtxU64Register610 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register325); // PTX L3679
L__BB44_225:																			// PTX L3680
	r_PtxRegister1255 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(10));					// PTX L3681
	r_PtxRegister1256 = uint32_t(r_PtxRegister1255) + uint32_t(r_PtxRegister40);		// PTX L3682
	r_PtxRegister50 = uint32_t(r_PtxRegister1256) + uint32_t(4096);						// PTX L3683
	if (r_bPtxPredicate15)
	{
		goto L__BB44_228;
	} // PTX L3684
	r_PtxRegister1261 = uint32_t(-1);								// PTX L3685
	r_PtxRegister1260 = Elected(r_PtxRegister1261);					// PTX L3687
	r_bPtxPredicate93 = uint32_t(r_PtxRegister1260) == uint32_t(0); // PTX L3693
	if (r_bPtxPredicate93)
	{
		goto L__BB44_229;
	} // PTX L3694
	r_PtxU64Register326 = r_PtxU64Register610; // PTX L3695
	r_PtxRegister1262 = uint32_t(512);		   // PTX L3696
	CopyBulk(s_SharedStorage, r_PtxRegister50, r_PtxU64Register326, r_PtxRegister1262,
			 r_PtxRegister46);													 // PTX L3698
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1262);			 // PTX L3701
	goto L__BB44_229;															 // PTX L3703
L__BB44_228:																	 // PTX L3704
	r_LaneIndexAtPtx3706 = uint32_t((threadIdx.x & 31u));						 // PTX L3706
	r_PtxRegister1259 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3706), uint32_t(4));	 // PTX L3708
	r_PtxRegister1258 = uint32_t(r_PtxRegister50) + uint32_t(r_PtxRegister1259); // PTX L3709
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1258)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);							   // PTX L3711
L__BB44_229:																   // PTX L3713
	r_PtxRegister1263 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister48); // PTX L3714
	r_PtxRegister1264 = uint32_t(r_PtxRegister1263) + uint32_t(128);		   // PTX L3715
	r_PtxU64Register8 = SignExtendWordBits(r_PtxRegister1264);				   // PTX L3716
	r_PtxU64Register611 = uint64_t(0);										   // PTX L3717
	if (r_bPtxPredicate15)
	{
		goto L__BB44_231;
	} // PTX L3718
	r_PtxU64Register327 = r_bPtxPredicate2 ? r_PtxU64Register8 : 0;						// PTX L3719
	r_PtxU64Register328 = ShiftLeft(uint64_t(r_PtxU64Register327), uint32_t(2));		// PTX L3720
	r_PtxU64Register611 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register328); // PTX L3721
L__BB44_231:																			// PTX L3722
	if (r_bPtxPredicate15)
	{
		goto L__BB44_234;
	} // PTX L3723
	r_PtxRegister1270 = uint32_t(-1);								// PTX L3724
	r_PtxRegister1269 = Elected(r_PtxRegister1270);					// PTX L3726
	r_bPtxPredicate94 = uint32_t(r_PtxRegister1269) == uint32_t(0); // PTX L3732
	if (r_bPtxPredicate94)
	{
		goto L__BB44_235;
	} // PTX L3733
	r_PtxRegister1271 = uint32_t(r_PtxRegister50) + uint32_t(512); // PTX L3734
	r_PtxU64Register329 = r_PtxU64Register611;					   // PTX L3735
	r_PtxRegister1272 = uint32_t(512);							   // PTX L3736
	CopyBulk(s_SharedStorage, r_PtxRegister1271, r_PtxU64Register329, r_PtxRegister1272,
			 r_PtxRegister46);													 // PTX L3738
	BarrierExpect(s_SharedStorage, r_PtxRegister46, r_PtxRegister1272);			 // PTX L3741
	goto L__BB44_235;															 // PTX L3743
L__BB44_234:																	 // PTX L3744
	r_LaneIndexAtPtx3746 = uint32_t((threadIdx.x & 31u));						 // PTX L3746
	r_PtxRegister1267 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3746), uint32_t(4));	 // PTX L3748
	r_PtxRegister1268 = uint32_t(r_PtxRegister50) + uint32_t(r_PtxRegister1267); // PTX L3749
	r_PtxRegister1266 = uint32_t(r_PtxRegister1268) + uint32_t(512);			 // PTX L3750
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1266)) =
		make_uint4(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx4534R1800,
				   r_PackedHalf2AtPtx4534R1800);					 // PTX L3752
L__BB44_235:														 // PTX L3754
	r_bPtxPredicate95 = uint32_t(r_PtxRegister1688) < uint32_t(992); // PTX L3755
	r_PtxRegister1688 = uint32_t(r_PtxRegister1688) + uint32_t(32);	 // PTX L3756
	if (r_bPtxPredicate95)
	{
		goto L__BB44_193;
	} // PTX L3757
	r_bPtxPredicate96 = uint32_t(r_CtaZ) == uint32_t(0);									   // PTX L3758
	r_PtxRegister1273 = uint32_t(r_PtxRegister3) + uint32_t(r_PtxRegister2);				   // PTX L3759
	r_PtxU64Register330 = uint64_t(int64_t(int32_t(r_PtxRegister1273)) * int64_t(int32_t(4))); // PTX L3760
	g_CounterByteAddress = uint64_t(g_CounterBaseAddress) + uint64_t(r_PtxU64Register330);	   // PTX L3761
	if (r_bPtxPredicate96)
	{
		goto L__BB44_241;
	} // PTX L3762
	r_ThreadZAtPtx3763 = uint32_t(threadIdx.z);						// PTX L3763
	r_PtxRegister1275 = r_PtxRegister77 | r_ThreadZAtPtx3763;		// PTX L3764
	r_bPtxPredicate97 = uint32_t(r_PtxRegister1275) != uint32_t(0); // PTX L3765
	if (r_bPtxPredicate97)
	{
		goto L__BB44_257;
	} // PTX L3766
	goto L__BB44_238;									// PTX L3767
L__BB44_257:											// PTX L3768
	__syncthreads();									// PTX L3769
	r_bPtxPredicate99 = uint32_t(r_CtaZ) < uint32_t(3); // PTX L3770
	if (r_bPtxPredicate99)
	{
		goto L__BB44_249;
	} // PTX L3771
	goto L__BB44_258;														  // PTX L3772
L__BB44_249:																  // PTX L3773
	r_PtxRegister53 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister3);	  // PTX L3774
	r_bPtxPredicate135 = int32_t(r_PtxRegister53) >= int32_t(r_PtxRegister4); // PTX L3775
	if (r_bPtxPredicate135)
	{
		goto L__BB44_251;
	} // PTX L3776
	r_PtxRegister1475 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(13));						  // PTX L3777
	r_PtxRegister1476 = uint32_t(r_PtxRegister1475) + uint32_t(r_PtxRegister6);					  // PTX L3778
	r_PtxU64Register445 = SignExtendWordBits(r_PtxRegister1476);								  // PTX L3779
	r_LaneIndexAtPtx3781 = uint32_t((threadIdx.x & 31u));										  // PTX L3781
	r_PtxU64Register446 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3781)) * int64_t(int32_t(4))); // PTX L3783
	r_PtxU64Register447 = uint64_t(r_PtxU64Register446) + uint64_t(r_PtxU64Register445);		  // PTX L3784
	r_PtxU64Register448 = ShiftLeft(uint64_t(r_PtxU64Register447), uint32_t(2));				  // PTX L3785
	r_PtxU64Register441 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register448);		  // PTX L3786
	ReduceHalf4(r_PtxU64Register441,
				make_uint4(r_PackedHalf2AtPtx1090R1687, r_PackedHalf2AtPtx1089R1686,
						   r_PackedHalf2AtPtx1088R1685, r_PackedHalf2AtPtx1087R1684));			  // PTX L3788
	r_PtxRegister1477 = uint32_t(r_PtxRegister1476) + uint32_t(128);							  // PTX L3790
	r_PtxU64Register449 = SignExtendWordBits(r_PtxRegister1477);								  // PTX L3791
	r_LaneIndexAtPtx3793 = uint32_t((threadIdx.x & 31u));										  // PTX L3793
	r_PtxU64Register450 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3793)) * int64_t(int32_t(4))); // PTX L3795
	r_PtxU64Register451 = uint64_t(r_PtxU64Register450) + uint64_t(r_PtxU64Register449);		  // PTX L3796
	r_PtxU64Register452 = ShiftLeft(uint64_t(r_PtxU64Register451), uint32_t(2));				  // PTX L3797
	r_PtxU64Register442 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register452);		  // PTX L3798
	ReduceHalf4(r_PtxU64Register442,
				make_uint4(r_PackedHalf2AtPtx1086R1683, r_PackedHalf2AtPtx1085R1682,
						   r_PackedHalf2AtPtx1084R1681, r_PackedHalf2AtPtx1083R1680));			  // PTX L3800
	r_PtxRegister1478 = uint32_t(r_PtxRegister1476) + uint32_t(256);							  // PTX L3802
	r_PtxU64Register453 = SignExtendWordBits(r_PtxRegister1478);								  // PTX L3803
	r_LaneIndexAtPtx3805 = uint32_t((threadIdx.x & 31u));										  // PTX L3805
	r_PtxU64Register454 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3805)) * int64_t(int32_t(4))); // PTX L3807
	r_PtxU64Register455 = uint64_t(r_PtxU64Register454) + uint64_t(r_PtxU64Register453);		  // PTX L3808
	r_PtxU64Register456 = ShiftLeft(uint64_t(r_PtxU64Register455), uint32_t(2));				  // PTX L3809
	r_PtxU64Register443 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register456);		  // PTX L3810
	ReduceHalf4(r_PtxU64Register443,
				make_uint4(r_PackedHalf2AtPtx1082R1679, r_PackedHalf2AtPtx1081R1678,
						   r_PackedHalf2AtPtx1080R1677, r_PackedHalf2AtPtx1079R1676));			  // PTX L3812
	r_PtxRegister1479 = uint32_t(r_PtxRegister1476) + uint32_t(384);							  // PTX L3814
	r_PtxU64Register457 = SignExtendWordBits(r_PtxRegister1479);								  // PTX L3815
	r_LaneIndexAtPtx3817 = uint32_t((threadIdx.x & 31u));										  // PTX L3817
	r_PtxU64Register458 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3817)) * int64_t(int32_t(4))); // PTX L3819
	r_PtxU64Register459 = uint64_t(r_PtxU64Register458) + uint64_t(r_PtxU64Register457);		  // PTX L3820
	r_PtxU64Register460 = ShiftLeft(uint64_t(r_PtxU64Register459), uint32_t(2));				  // PTX L3821
	r_PtxU64Register444 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register460);		  // PTX L3822
	ReduceHalf4(r_PtxU64Register444,
				make_uint4(r_PackedHalf2AtPtx1078R1675, r_PackedHalf2AtPtx1077R1674,
						   r_PackedHalf2AtPtx1076R1673, r_PackedHalf2AtPtx1075R1672)); // PTX L3824
L__BB44_251:																		   // PTX L3826
	r_PtxRegister54 = uint32_t(r_PtxRegister53) + uint32_t(1);						   // PTX L3827
	r_bPtxPredicate136 = int32_t(r_PtxRegister54) >= int32_t(r_PtxRegister4);		   // PTX L3828
	if (r_bPtxPredicate136)
	{
		goto L__BB44_253;
	} // PTX L3829
	r_PtxRegister1484 = ShiftLeft(uint32_t(r_PtxRegister54), uint32_t(13));						  // PTX L3830
	r_PtxRegister1485 = uint32_t(r_PtxRegister1484) + uint32_t(r_PtxRegister6);					  // PTX L3831
	r_PtxU64Register465 = SignExtendWordBits(r_PtxRegister1485);								  // PTX L3832
	r_LaneIndexAtPtx3834 = uint32_t((threadIdx.x & 31u));										  // PTX L3834
	r_PtxU64Register466 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3834)) * int64_t(int32_t(4))); // PTX L3836
	r_PtxU64Register467 = uint64_t(r_PtxU64Register466) + uint64_t(r_PtxU64Register465);		  // PTX L3837
	r_PtxU64Register468 = ShiftLeft(uint64_t(r_PtxU64Register467), uint32_t(2));				  // PTX L3838
	r_PtxU64Register461 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register468);		  // PTX L3839
	ReduceHalf4(r_PtxU64Register461,
				make_uint4(r_PackedHalf2AtPtx1074R1671, r_PackedHalf2AtPtx1073R1670,
						   r_PackedHalf2AtPtx1072R1669, r_PackedHalf2AtPtx1071R1668));			  // PTX L3841
	r_PtxRegister1486 = uint32_t(r_PtxRegister1485) + uint32_t(128);							  // PTX L3843
	r_PtxU64Register469 = SignExtendWordBits(r_PtxRegister1486);								  // PTX L3844
	r_LaneIndexAtPtx3846 = uint32_t((threadIdx.x & 31u));										  // PTX L3846
	r_PtxU64Register470 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3846)) * int64_t(int32_t(4))); // PTX L3848
	r_PtxU64Register471 = uint64_t(r_PtxU64Register470) + uint64_t(r_PtxU64Register469);		  // PTX L3849
	r_PtxU64Register472 = ShiftLeft(uint64_t(r_PtxU64Register471), uint32_t(2));				  // PTX L3850
	r_PtxU64Register462 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register472);		  // PTX L3851
	ReduceHalf4(r_PtxU64Register462,
				make_uint4(r_PackedHalf2AtPtx1070R1667, r_PackedHalf2AtPtx1069R1666,
						   r_PackedHalf2AtPtx1068R1665, r_PackedHalf2AtPtx1067R1664));			  // PTX L3853
	r_PtxRegister1487 = uint32_t(r_PtxRegister1485) + uint32_t(256);							  // PTX L3855
	r_PtxU64Register473 = SignExtendWordBits(r_PtxRegister1487);								  // PTX L3856
	r_LaneIndexAtPtx3858 = uint32_t((threadIdx.x & 31u));										  // PTX L3858
	r_PtxU64Register474 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3858)) * int64_t(int32_t(4))); // PTX L3860
	r_PtxU64Register475 = uint64_t(r_PtxU64Register474) + uint64_t(r_PtxU64Register473);		  // PTX L3861
	r_PtxU64Register476 = ShiftLeft(uint64_t(r_PtxU64Register475), uint32_t(2));				  // PTX L3862
	r_PtxU64Register463 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register476);		  // PTX L3863
	ReduceHalf4(r_PtxU64Register463,
				make_uint4(r_PackedHalf2AtPtx1066R1663, r_PackedHalf2AtPtx1065R1662,
						   r_PackedHalf2AtPtx1064R1661, r_PackedHalf2AtPtx1063R1660));			  // PTX L3865
	r_PtxRegister1488 = uint32_t(r_PtxRegister1485) + uint32_t(384);							  // PTX L3867
	r_PtxU64Register477 = SignExtendWordBits(r_PtxRegister1488);								  // PTX L3868
	r_LaneIndexAtPtx3870 = uint32_t((threadIdx.x & 31u));										  // PTX L3870
	r_PtxU64Register478 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3870)) * int64_t(int32_t(4))); // PTX L3872
	r_PtxU64Register479 = uint64_t(r_PtxU64Register478) + uint64_t(r_PtxU64Register477);		  // PTX L3873
	r_PtxU64Register480 = ShiftLeft(uint64_t(r_PtxU64Register479), uint32_t(2));				  // PTX L3874
	r_PtxU64Register464 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register480);		  // PTX L3875
	ReduceHalf4(r_PtxU64Register464,
				make_uint4(r_PackedHalf2AtPtx1062R1659, r_PackedHalf2AtPtx1061R1658,
						   r_PackedHalf2AtPtx1060R1657, r_PackedHalf2AtPtx1059R1656)); // PTX L3877
L__BB44_253:																		   // PTX L3879
	r_PtxRegister55 = uint32_t(r_PtxRegister53) + uint32_t(2);						   // PTX L3880
	r_bPtxPredicate137 = int32_t(r_PtxRegister55) >= int32_t(r_PtxRegister4);		   // PTX L3881
	if (r_bPtxPredicate137)
	{
		goto L__BB44_255;
	} // PTX L3882
	r_PtxRegister1493 = ShiftLeft(uint32_t(r_PtxRegister55), uint32_t(13));						  // PTX L3883
	r_PtxRegister1494 = uint32_t(r_PtxRegister1493) + uint32_t(r_PtxRegister6);					  // PTX L3884
	r_PtxU64Register485 = SignExtendWordBits(r_PtxRegister1494);								  // PTX L3885
	r_LaneIndexAtPtx3887 = uint32_t((threadIdx.x & 31u));										  // PTX L3887
	r_PtxU64Register486 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3887)) * int64_t(int32_t(4))); // PTX L3889
	r_PtxU64Register487 = uint64_t(r_PtxU64Register486) + uint64_t(r_PtxU64Register485);		  // PTX L3890
	r_PtxU64Register488 = ShiftLeft(uint64_t(r_PtxU64Register487), uint32_t(2));				  // PTX L3891
	r_PtxU64Register481 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register488);		  // PTX L3892
	ReduceHalf4(r_PtxU64Register481,
				make_uint4(r_PackedHalf2AtPtx1058R1655, r_PackedHalf2AtPtx1057R1654,
						   r_PackedHalf2AtPtx1056R1653, r_PackedHalf2AtPtx1055R1652));			  // PTX L3894
	r_PtxRegister1495 = uint32_t(r_PtxRegister1494) + uint32_t(128);							  // PTX L3896
	r_PtxU64Register489 = SignExtendWordBits(r_PtxRegister1495);								  // PTX L3897
	r_LaneIndexAtPtx3899 = uint32_t((threadIdx.x & 31u));										  // PTX L3899
	r_PtxU64Register490 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3899)) * int64_t(int32_t(4))); // PTX L3901
	r_PtxU64Register491 = uint64_t(r_PtxU64Register490) + uint64_t(r_PtxU64Register489);		  // PTX L3902
	r_PtxU64Register492 = ShiftLeft(uint64_t(r_PtxU64Register491), uint32_t(2));				  // PTX L3903
	r_PtxU64Register482 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register492);		  // PTX L3904
	ReduceHalf4(r_PtxU64Register482,
				make_uint4(r_PackedHalf2AtPtx1054R1651, r_PackedHalf2AtPtx1053R1650,
						   r_PackedHalf2AtPtx1052R1649, r_PackedHalf2AtPtx1051R1648));			  // PTX L3906
	r_PtxRegister1496 = uint32_t(r_PtxRegister1494) + uint32_t(256);							  // PTX L3908
	r_PtxU64Register493 = SignExtendWordBits(r_PtxRegister1496);								  // PTX L3909
	r_LaneIndexAtPtx3911 = uint32_t((threadIdx.x & 31u));										  // PTX L3911
	r_PtxU64Register494 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3911)) * int64_t(int32_t(4))); // PTX L3913
	r_PtxU64Register495 = uint64_t(r_PtxU64Register494) + uint64_t(r_PtxU64Register493);		  // PTX L3914
	r_PtxU64Register496 = ShiftLeft(uint64_t(r_PtxU64Register495), uint32_t(2));				  // PTX L3915
	r_PtxU64Register483 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register496);		  // PTX L3916
	ReduceHalf4(r_PtxU64Register483,
				make_uint4(r_PackedHalf2AtPtx1050R1647, r_PackedHalf2AtPtx1049R1646,
						   r_PackedHalf2AtPtx1048R1645, r_PackedHalf2AtPtx1047R1644));			  // PTX L3918
	r_PtxRegister1497 = uint32_t(r_PtxRegister1494) + uint32_t(384);							  // PTX L3920
	r_PtxU64Register497 = SignExtendWordBits(r_PtxRegister1497);								  // PTX L3921
	r_LaneIndexAtPtx3923 = uint32_t((threadIdx.x & 31u));										  // PTX L3923
	r_PtxU64Register498 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3923)) * int64_t(int32_t(4))); // PTX L3925
	r_PtxU64Register499 = uint64_t(r_PtxU64Register498) + uint64_t(r_PtxU64Register497);		  // PTX L3926
	r_PtxU64Register500 = ShiftLeft(uint64_t(r_PtxU64Register499), uint32_t(2));				  // PTX L3927
	r_PtxU64Register484 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register500);		  // PTX L3928
	ReduceHalf4(r_PtxU64Register484,
				make_uint4(r_PackedHalf2AtPtx1046R1643, r_PackedHalf2AtPtx1045R1642,
						   r_PackedHalf2AtPtx1044R1641, r_PackedHalf2AtPtx1043R1640)); // PTX L3930
L__BB44_255:																		   // PTX L3932
	r_PtxRegister56 = uint32_t(r_PtxRegister53) + uint32_t(3);						   // PTX L3933
	r_bPtxPredicate138 = int32_t(r_PtxRegister56) >= int32_t(r_PtxRegister4);		   // PTX L3934
	if (r_bPtxPredicate138)
	{
		goto L__BB44_314;
	} // PTX L3935
	r_PtxRegister1502 = ShiftLeft(uint32_t(r_PtxRegister56), uint32_t(13));						  // PTX L3936
	r_PtxRegister1503 = uint32_t(r_PtxRegister1502) + uint32_t(r_PtxRegister6);					  // PTX L3937
	r_PtxU64Register505 = SignExtendWordBits(r_PtxRegister1503);								  // PTX L3938
	r_LaneIndexAtPtx3940 = uint32_t((threadIdx.x & 31u));										  // PTX L3940
	r_PtxU64Register506 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3940)) * int64_t(int32_t(4))); // PTX L3942
	r_PtxU64Register507 = uint64_t(r_PtxU64Register506) + uint64_t(r_PtxU64Register505);		  // PTX L3943
	r_PtxU64Register508 = ShiftLeft(uint64_t(r_PtxU64Register507), uint32_t(2));				  // PTX L3944
	r_PtxU64Register501 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register508);		  // PTX L3945
	ReduceHalf4(r_PtxU64Register501,
				make_uint4(r_PackedHalf2AtPtx1042R1639, r_PackedHalf2AtPtx1041R1638,
						   r_PackedHalf2AtPtx1040R1637, r_PackedHalf2AtPtx1039R1636));			  // PTX L3947
	r_PtxRegister1504 = uint32_t(r_PtxRegister1503) + uint32_t(128);							  // PTX L3949
	r_PtxU64Register509 = SignExtendWordBits(r_PtxRegister1504);								  // PTX L3950
	r_LaneIndexAtPtx3952 = uint32_t((threadIdx.x & 31u));										  // PTX L3952
	r_PtxU64Register510 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3952)) * int64_t(int32_t(4))); // PTX L3954
	r_PtxU64Register511 = uint64_t(r_PtxU64Register510) + uint64_t(r_PtxU64Register509);		  // PTX L3955
	r_PtxU64Register512 = ShiftLeft(uint64_t(r_PtxU64Register511), uint32_t(2));				  // PTX L3956
	r_PtxU64Register502 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register512);		  // PTX L3957
	ReduceHalf4(r_PtxU64Register502,
				make_uint4(r_PackedHalf2AtPtx1038R1635, r_PackedHalf2AtPtx1037R1634,
						   r_PackedHalf2AtPtx1036R1633, r_PackedHalf2AtPtx1035R1632));			  // PTX L3959
	r_PtxRegister1505 = uint32_t(r_PtxRegister1503) + uint32_t(256);							  // PTX L3961
	r_PtxU64Register513 = SignExtendWordBits(r_PtxRegister1505);								  // PTX L3962
	r_LaneIndexAtPtx3964 = uint32_t((threadIdx.x & 31u));										  // PTX L3964
	r_PtxU64Register514 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3964)) * int64_t(int32_t(4))); // PTX L3966
	r_PtxU64Register515 = uint64_t(r_PtxU64Register514) + uint64_t(r_PtxU64Register513);		  // PTX L3967
	r_PtxU64Register516 = ShiftLeft(uint64_t(r_PtxU64Register515), uint32_t(2));				  // PTX L3968
	r_PtxU64Register503 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register516);		  // PTX L3969
	ReduceHalf4(r_PtxU64Register503,
				make_uint4(r_PackedHalf2AtPtx1034R1631, r_PackedHalf2AtPtx1033R1630,
						   r_PackedHalf2AtPtx1032R1629, r_PackedHalf2AtPtx1031R1628));			  // PTX L3971
	r_PtxRegister1506 = uint32_t(r_PtxRegister1503) + uint32_t(384);							  // PTX L3973
	r_PtxU64Register517 = SignExtendWordBits(r_PtxRegister1506);								  // PTX L3974
	r_LaneIndexAtPtx3976 = uint32_t((threadIdx.x & 31u));										  // PTX L3976
	r_PtxU64Register518 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3976)) * int64_t(int32_t(4))); // PTX L3978
	r_PtxU64Register519 = uint64_t(r_PtxU64Register518) + uint64_t(r_PtxU64Register517);		  // PTX L3979
	r_PtxU64Register520 = ShiftLeft(uint64_t(r_PtxU64Register519), uint32_t(2));				  // PTX L3980
	r_PtxU64Register504 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register520);		  // PTX L3981
	ReduceHalf4(r_PtxU64Register504,
				make_uint4(r_PackedHalf2AtPtx1030R1627, r_PackedHalf2AtPtx1029R1626,
						   r_PackedHalf2AtPtx1028R1625, r_PackedHalf2AtPtx1027R1624));			  // PTX L3983
	goto L__BB44_314;																			  // PTX L3985
L__BB44_241:																					  // PTX L3986
	r_PtxRegister52 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister3);						  // PTX L3987
	r_bPtxPredicate139 = int32_t(r_PtxRegister52) >= int32_t(r_PtxRegister4);					  // PTX L3988
	r_PtxRegister1508 = ShiftLeft(uint32_t(r_PtxRegister52), uint32_t(13));						  // PTX L3989
	r_PtxRegister1509 = uint32_t(r_PtxRegister1508) + uint32_t(r_PtxRegister6);					  // PTX L3990
	r_PtxU64Register521 = uint64_t(int64_t(int32_t(r_PtxRegister1509)) * int64_t(int32_t(4)));	  // PTX L3991
	g_OutputByteAddressAtPtx3992 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register521); // PTX L3992
	if (r_bPtxPredicate139)
	{
		goto L__BB44_243;
	} // PTX L3993
	r_LaneIndexAtPtx3995 = uint32_t((threadIdx.x & 31u)); // PTX L3995
	r_PtxU64Register526 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3995)) * int64_t(int32_t(16))); // PTX L3997
	g_OutputByteAddressAtPtx3998 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register526); // PTX L3998
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3998,
					make_uint4(r_PackedHalf2AtPtx1090R1687, r_PackedHalf2AtPtx1089R1686,
							   r_PackedHalf2AtPtx1088R1685,
							   r_PackedHalf2AtPtx1087R1684)); // PTX L4000
	r_LaneIndexAtPtx4003 = uint32_t((threadIdx.x & 31u));	  // PTX L4003
	r_PtxU64Register527 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4003)) * int64_t(int32_t(16))); // PTX L4005
	g_OutputByteAddressAtPtx4006 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register527);			   // PTX L4006
	g_OutputByteAddressAtPtx4007 = uint64_t(g_OutputByteAddressAtPtx4006) + uint64_t(512); // PTX L4007
	StoreNoAllocate(g_OutputByteAddressAtPtx4007,
					make_uint4(r_PackedHalf2AtPtx1086R1683, r_PackedHalf2AtPtx1085R1682,
							   r_PackedHalf2AtPtx1084R1681,
							   r_PackedHalf2AtPtx1083R1680)); // PTX L4009
	r_LaneIndexAtPtx4012 = uint32_t((threadIdx.x & 31u));	  // PTX L4012
	r_PtxU64Register529 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4012)) * int64_t(int32_t(16))); // PTX L4014
	g_OutputByteAddressAtPtx4015 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register529);				// PTX L4015
	g_OutputByteAddressAtPtx4016 = uint64_t(g_OutputByteAddressAtPtx4015) + uint64_t(1024); // PTX L4016
	StoreNoAllocate(g_OutputByteAddressAtPtx4016,
					make_uint4(r_PackedHalf2AtPtx1082R1679, r_PackedHalf2AtPtx1081R1678,
							   r_PackedHalf2AtPtx1080R1677,
							   r_PackedHalf2AtPtx1079R1676)); // PTX L4018
	r_LaneIndexAtPtx4021 = uint32_t((threadIdx.x & 31u));	  // PTX L4021
	r_PtxU64Register531 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4021)) * int64_t(int32_t(16))); // PTX L4023
	g_OutputByteAddressAtPtx4024 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register531);				// PTX L4024
	g_OutputByteAddressAtPtx4025 = uint64_t(g_OutputByteAddressAtPtx4024) + uint64_t(1536); // PTX L4025
	StoreNoAllocate(g_OutputByteAddressAtPtx4025,
					make_uint4(r_PackedHalf2AtPtx1078R1675, r_PackedHalf2AtPtx1077R1674,
							   r_PackedHalf2AtPtx1076R1673,
							   r_PackedHalf2AtPtx1075R1672));								 // PTX L4027
L__BB44_243:																				 // PTX L4029
	r_PtxRegister1514 = uint32_t(r_PtxRegister52) + uint32_t(1);							 // PTX L4030
	r_bPtxPredicate140 = int32_t(r_PtxRegister1514) >= int32_t(r_PtxRegister4);				 // PTX L4031
	g_OutputByteAddressAtPtx4032 = uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(32768); // PTX L4032
	if (r_bPtxPredicate140)
	{
		goto L__BB44_245;
	} // PTX L4033
	r_LaneIndexAtPtx4035 = uint32_t((threadIdx.x & 31u)); // PTX L4035
	r_PtxU64Register537 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4035)) * int64_t(int32_t(16))); // PTX L4037
	g_OutputByteAddressAtPtx4038 =
		uint64_t(g_OutputByteAddressAtPtx4032) + uint64_t(r_PtxU64Register537); // PTX L4038
	StoreNoAllocate(g_OutputByteAddressAtPtx4038,
					make_uint4(r_PackedHalf2AtPtx1074R1671, r_PackedHalf2AtPtx1073R1670,
							   r_PackedHalf2AtPtx1072R1669,
							   r_PackedHalf2AtPtx1071R1668)); // PTX L4040
	r_LaneIndexAtPtx4043 = uint32_t((threadIdx.x & 31u));	  // PTX L4043
	r_PtxU64Register538 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4043)) * int64_t(int32_t(16))); // PTX L4045
	g_OutputByteAddressAtPtx4046 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register538);				 // PTX L4046
	g_OutputByteAddressAtPtx4047 = uint64_t(g_OutputByteAddressAtPtx4046) + uint64_t(33280); // PTX L4047
	StoreNoAllocate(g_OutputByteAddressAtPtx4047,
					make_uint4(r_PackedHalf2AtPtx1070R1667, r_PackedHalf2AtPtx1069R1666,
							   r_PackedHalf2AtPtx1068R1665,
							   r_PackedHalf2AtPtx1067R1664)); // PTX L4049
	r_LaneIndexAtPtx4052 = uint32_t((threadIdx.x & 31u));	  // PTX L4052
	r_PtxU64Register540 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4052)) * int64_t(int32_t(16))); // PTX L4054
	g_OutputByteAddressAtPtx4055 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register540);				 // PTX L4055
	g_OutputByteAddressAtPtx4056 = uint64_t(g_OutputByteAddressAtPtx4055) + uint64_t(33792); // PTX L4056
	StoreNoAllocate(g_OutputByteAddressAtPtx4056,
					make_uint4(r_PackedHalf2AtPtx1066R1663, r_PackedHalf2AtPtx1065R1662,
							   r_PackedHalf2AtPtx1064R1661,
							   r_PackedHalf2AtPtx1063R1660)); // PTX L4058
	r_LaneIndexAtPtx4061 = uint32_t((threadIdx.x & 31u));	  // PTX L4061
	r_PtxU64Register542 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4061)) * int64_t(int32_t(16))); // PTX L4063
	g_OutputByteAddressAtPtx4064 =
		uint64_t(g_OutputByteAddressAtPtx3992) + uint64_t(r_PtxU64Register542);				 // PTX L4064
	g_OutputByteAddressAtPtx4065 = uint64_t(g_OutputByteAddressAtPtx4064) + uint64_t(34304); // PTX L4065
	StoreNoAllocate(g_OutputByteAddressAtPtx4065,
					make_uint4(r_PackedHalf2AtPtx1062R1659, r_PackedHalf2AtPtx1061R1658,
							   r_PackedHalf2AtPtx1060R1657,
							   r_PackedHalf2AtPtx1059R1656));								 // PTX L4067
L__BB44_245:																				 // PTX L4069
	r_PtxRegister1519 = uint32_t(r_PtxRegister52) + uint32_t(2);							 // PTX L4070
	r_bPtxPredicate141 = int32_t(r_PtxRegister1519) >= int32_t(r_PtxRegister4);				 // PTX L4071
	g_OutputByteAddressAtPtx4072 = uint64_t(g_OutputByteAddressAtPtx4032) + uint64_t(32768); // PTX L4072
	if (r_bPtxPredicate141)
	{
		goto L__BB44_247;
	} // PTX L4073
	r_LaneIndexAtPtx4075 = uint32_t((threadIdx.x & 31u)); // PTX L4075
	r_PtxU64Register548 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4075)) * int64_t(int32_t(16))); // PTX L4077
	g_OutputByteAddressAtPtx4078 =
		uint64_t(g_OutputByteAddressAtPtx4072) + uint64_t(r_PtxU64Register548); // PTX L4078
	StoreNoAllocate(g_OutputByteAddressAtPtx4078,
					make_uint4(r_PackedHalf2AtPtx1058R1655, r_PackedHalf2AtPtx1057R1654,
							   r_PackedHalf2AtPtx1056R1653,
							   r_PackedHalf2AtPtx1055R1652)); // PTX L4080
	r_LaneIndexAtPtx4083 = uint32_t((threadIdx.x & 31u));	  // PTX L4083
	r_PtxU64Register549 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4083)) * int64_t(int32_t(16))); // PTX L4085
	g_OutputByteAddressAtPtx4086 =
		uint64_t(g_OutputByteAddressAtPtx4032) + uint64_t(r_PtxU64Register549);				 // PTX L4086
	g_OutputByteAddressAtPtx4087 = uint64_t(g_OutputByteAddressAtPtx4086) + uint64_t(33280); // PTX L4087
	StoreNoAllocate(g_OutputByteAddressAtPtx4087,
					make_uint4(r_PackedHalf2AtPtx1054R1651, r_PackedHalf2AtPtx1053R1650,
							   r_PackedHalf2AtPtx1052R1649,
							   r_PackedHalf2AtPtx1051R1648)); // PTX L4089
	r_LaneIndexAtPtx4092 = uint32_t((threadIdx.x & 31u));	  // PTX L4092
	r_PtxU64Register551 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4092)) * int64_t(int32_t(16))); // PTX L4094
	g_OutputByteAddressAtPtx4095 =
		uint64_t(g_OutputByteAddressAtPtx4032) + uint64_t(r_PtxU64Register551);				 // PTX L4095
	g_OutputByteAddressAtPtx4096 = uint64_t(g_OutputByteAddressAtPtx4095) + uint64_t(33792); // PTX L4096
	StoreNoAllocate(g_OutputByteAddressAtPtx4096,
					make_uint4(r_PackedHalf2AtPtx1050R1647, r_PackedHalf2AtPtx1049R1646,
							   r_PackedHalf2AtPtx1048R1645,
							   r_PackedHalf2AtPtx1047R1644)); // PTX L4098
	r_LaneIndexAtPtx4101 = uint32_t((threadIdx.x & 31u));	  // PTX L4101
	r_PtxU64Register553 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4101)) * int64_t(int32_t(16))); // PTX L4103
	g_OutputByteAddressAtPtx4104 =
		uint64_t(g_OutputByteAddressAtPtx4032) + uint64_t(r_PtxU64Register553);				 // PTX L4104
	g_OutputByteAddressAtPtx4105 = uint64_t(g_OutputByteAddressAtPtx4104) + uint64_t(34304); // PTX L4105
	StoreNoAllocate(g_OutputByteAddressAtPtx4105,
					make_uint4(r_PackedHalf2AtPtx1046R1643, r_PackedHalf2AtPtx1045R1642,
							   r_PackedHalf2AtPtx1044R1641,
							   r_PackedHalf2AtPtx1043R1640));					// PTX L4107
L__BB44_247:																	// PTX L4109
	r_PtxRegister1524 = uint32_t(r_PtxRegister52) + uint32_t(3);				// PTX L4110
	r_bPtxPredicate142 = int32_t(r_PtxRegister1524) >= int32_t(r_PtxRegister4); // PTX L4111
	if (r_bPtxPredicate142)
	{
		goto L__BB44_314;
	} // PTX L4112
	r_LaneIndexAtPtx4114 = uint32_t((threadIdx.x & 31u)); // PTX L4114
	r_PtxU64Register559 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4114)) * int64_t(int32_t(16))); // PTX L4116
	g_OutputByteAddressAtPtx4117 =
		uint64_t(g_OutputByteAddressAtPtx4072) + uint64_t(r_PtxU64Register559);				 // PTX L4117
	g_OutputByteAddressAtPtx4118 = uint64_t(g_OutputByteAddressAtPtx4117) + uint64_t(32768); // PTX L4118
	StoreNoAllocate(g_OutputByteAddressAtPtx4118,
					make_uint4(r_PackedHalf2AtPtx1042R1639, r_PackedHalf2AtPtx1041R1638,
							   r_PackedHalf2AtPtx1040R1637,
							   r_PackedHalf2AtPtx1039R1636)); // PTX L4120
	r_LaneIndexAtPtx4123 = uint32_t((threadIdx.x & 31u));	  // PTX L4123
	r_PtxU64Register561 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4123)) * int64_t(int32_t(16))); // PTX L4125
	g_OutputByteAddressAtPtx4126 =
		uint64_t(g_OutputByteAddressAtPtx4072) + uint64_t(r_PtxU64Register561);				 // PTX L4126
	g_OutputByteAddressAtPtx4127 = uint64_t(g_OutputByteAddressAtPtx4126) + uint64_t(33280); // PTX L4127
	StoreNoAllocate(g_OutputByteAddressAtPtx4127,
					make_uint4(r_PackedHalf2AtPtx1038R1635, r_PackedHalf2AtPtx1037R1634,
							   r_PackedHalf2AtPtx1036R1633,
							   r_PackedHalf2AtPtx1035R1632)); // PTX L4129
	r_LaneIndexAtPtx4132 = uint32_t((threadIdx.x & 31u));	  // PTX L4132
	r_PtxU64Register563 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4132)) * int64_t(int32_t(16))); // PTX L4134
	g_OutputByteAddressAtPtx4135 =
		uint64_t(g_OutputByteAddressAtPtx4072) + uint64_t(r_PtxU64Register563);				 // PTX L4135
	g_OutputByteAddressAtPtx4136 = uint64_t(g_OutputByteAddressAtPtx4135) + uint64_t(33792); // PTX L4136
	StoreNoAllocate(g_OutputByteAddressAtPtx4136,
					make_uint4(r_PackedHalf2AtPtx1034R1631, r_PackedHalf2AtPtx1033R1630,
							   r_PackedHalf2AtPtx1032R1629,
							   r_PackedHalf2AtPtx1031R1628)); // PTX L4138
	r_LaneIndexAtPtx4141 = uint32_t((threadIdx.x & 31u));	  // PTX L4141
	r_PtxU64Register565 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4141)) * int64_t(int32_t(16))); // PTX L4143
	g_OutputByteAddressAtPtx4144 =
		uint64_t(g_OutputByteAddressAtPtx4072) + uint64_t(r_PtxU64Register565);				 // PTX L4144
	g_OutputByteAddressAtPtx4145 = uint64_t(g_OutputByteAddressAtPtx4144) + uint64_t(34304); // PTX L4145
	StoreNoAllocate(g_OutputByteAddressAtPtx4145,
					make_uint4(r_PackedHalf2AtPtx1030R1627, r_PackedHalf2AtPtx1029R1626,
							   r_PackedHalf2AtPtx1028R1625,
							   r_PackedHalf2AtPtx1027R1624));				// PTX L4147
	goto L__BB44_314;														// PTX L4149
L__BB44_258:																// PTX L4150
	r_bPtxPredicate100 = uint32_t(r_PtxRegister41) < uint32_t(31);			// PTX L4151
	r_PtxRegister57 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister3); // PTX L4152
	r_PtxRegister1724 = uint32_t(0);										// PTX L4153
	if (r_bPtxPredicate100)
	{
		goto L__BB44_260;
	} // PTX L4154
	r_bPtxPredicate101 = int32_t(r_PtxRegister57) >= int32_t(r_PtxRegister4); // PTX L4155
	r_PtxRegister1724 = uint32_t(r_PtxRegister57);							  // PTX L4156
	r_PackedHalf2AtPtx4157R1725 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4157
	r_PackedHalf2AtPtx4158R1726 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4158
	r_PackedHalf2AtPtx4159R1727 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4159
	r_PackedHalf2AtPtx4160R1728 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4160
	if (r_bPtxPredicate101)
	{
		goto L__BB44_261;
	} // PTX L4161
L__BB44_260:																					  // PTX L4162
	r_PtxRegister1278 = ShiftLeft(uint32_t(r_PtxRegister1724), uint32_t(13));					  // PTX L4163
	r_PtxRegister1279 = uint32_t(r_PtxRegister1278) + uint32_t(r_PtxRegister6);					  // PTX L4164
	r_PtxU64Register332 = uint64_t(int64_t(int32_t(r_PtxRegister1279)) * int64_t(int32_t(4)));	  // PTX L4165
	g_OutputByteAddressAtPtx4166 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register332); // PTX L4166
	r_LaneIndexAtPtx4168 = uint32_t((threadIdx.x & 31u));										  // PTX L4168
	r_PtxU64Register334 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4168)) * int64_t(int32_t(16))); // PTX L4170
	g_OutputByteAddressAtPtx4171 =
		uint64_t(g_OutputByteAddressAtPtx4166) + uint64_t(r_PtxU64Register334); // PTX L4171
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4171));
		r_PackedHalf2AtPtx4157R1725 = r_Value.x;
		r_PackedHalf2AtPtx4158R1726 = r_Value.y;
		r_PackedHalf2AtPtx4159R1727 = r_Value.z;
		r_PackedHalf2AtPtx4160R1728 = r_Value.w;
	} // PTX L4173
L__BB44_261:													   // PTX L4175
	r_bPtxPredicate102 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4176
	r_PtxRegister1729 = uint32_t(0);							   // PTX L4177
	if (r_bPtxPredicate102)
	{
		goto L__BB44_263;
	} // PTX L4178
	r_bPtxPredicate103 = int32_t(r_PtxRegister57) >= int32_t(r_PtxRegister4); // PTX L4179
	r_PtxRegister1729 = uint32_t(r_PtxRegister57);							  // PTX L4180
	r_PackedHalf2AtPtx4181R1730 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4181
	r_PackedHalf2AtPtx4182R1731 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4182
	r_PackedHalf2AtPtx4183R1732 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4183
	r_PackedHalf2AtPtx4184R1733 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4184
	if (r_bPtxPredicate103)
	{
		goto L__BB44_264;
	} // PTX L4185
L__BB44_263:																					  // PTX L4186
	r_PtxRegister1281 = ShiftLeft(uint32_t(r_PtxRegister1729), uint32_t(13));					  // PTX L4187
	r_PtxRegister1282 = uint32_t(r_PtxRegister1281) + uint32_t(r_PtxRegister7);					  // PTX L4188
	r_PtxU64Register336 = uint64_t(int64_t(int32_t(r_PtxRegister1282)) * int64_t(int32_t(4)));	  // PTX L4189
	g_OutputByteAddressAtPtx4190 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register336); // PTX L4190
	r_LaneIndexAtPtx4192 = uint32_t((threadIdx.x & 31u));										  // PTX L4192
	r_PtxU64Register338 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4192)) * int64_t(int32_t(16))); // PTX L4194
	g_OutputByteAddressAtPtx4195 =
		uint64_t(g_OutputByteAddressAtPtx4190) + uint64_t(r_PtxU64Register338); // PTX L4195
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4195));
		r_PackedHalf2AtPtx4181R1730 = r_Value.x;
		r_PackedHalf2AtPtx4182R1731 = r_Value.y;
		r_PackedHalf2AtPtx4183R1732 = r_Value.z;
		r_PackedHalf2AtPtx4184R1733 = r_Value.w;
	} // PTX L4197
L__BB44_264:													   // PTX L4199
	r_bPtxPredicate104 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4200
	r_PtxRegister1734 = uint32_t(0);							   // PTX L4201
	if (r_bPtxPredicate104)
	{
		goto L__BB44_266;
	} // PTX L4202
	r_bPtxPredicate105 = int32_t(r_PtxRegister57) >= int32_t(r_PtxRegister4); // PTX L4203
	r_PtxRegister1734 = uint32_t(r_PtxRegister57);							  // PTX L4204
	r_PackedHalf2AtPtx4205R1735 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4205
	r_PackedHalf2AtPtx4206R1736 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4206
	r_PackedHalf2AtPtx4207R1737 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4207
	r_PackedHalf2AtPtx4208R1738 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4208
	if (r_bPtxPredicate105)
	{
		goto L__BB44_267;
	} // PTX L4209
L__BB44_266:																					  // PTX L4210
	r_PtxRegister1284 = ShiftLeft(uint32_t(r_PtxRegister1734), uint32_t(13));					  // PTX L4211
	r_PtxRegister1285 = uint32_t(r_PtxRegister1284) + uint32_t(r_PtxRegister8);					  // PTX L4212
	r_PtxU64Register340 = uint64_t(int64_t(int32_t(r_PtxRegister1285)) * int64_t(int32_t(4)));	  // PTX L4213
	g_OutputByteAddressAtPtx4214 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register340); // PTX L4214
	r_LaneIndexAtPtx4216 = uint32_t((threadIdx.x & 31u));										  // PTX L4216
	r_PtxU64Register342 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4216)) * int64_t(int32_t(16))); // PTX L4218
	g_OutputByteAddressAtPtx4219 =
		uint64_t(g_OutputByteAddressAtPtx4214) + uint64_t(r_PtxU64Register342); // PTX L4219
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4219));
		r_PackedHalf2AtPtx4205R1735 = r_Value.x;
		r_PackedHalf2AtPtx4206R1736 = r_Value.y;
		r_PackedHalf2AtPtx4207R1737 = r_Value.z;
		r_PackedHalf2AtPtx4208R1738 = r_Value.w;
	} // PTX L4221
L__BB44_267:													   // PTX L4223
	r_bPtxPredicate106 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4224
	r_PtxRegister1739 = uint32_t(0);							   // PTX L4225
	if (r_bPtxPredicate106)
	{
		goto L__BB44_269;
	} // PTX L4226
	r_bPtxPredicate107 = int32_t(r_PtxRegister57) >= int32_t(r_PtxRegister4); // PTX L4227
	r_PtxRegister1739 = uint32_t(r_PtxRegister57);							  // PTX L4228
	r_PackedHalf2AtPtx4229R1740 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4229
	r_PackedHalf2AtPtx4230R1741 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4230
	r_PackedHalf2AtPtx4231R1742 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4231
	r_PackedHalf2AtPtx4232R1743 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4232
	if (r_bPtxPredicate107)
	{
		goto L__BB44_270;
	} // PTX L4233
L__BB44_269:																					  // PTX L4234
	r_PtxRegister1287 = ShiftLeft(uint32_t(r_PtxRegister1739), uint32_t(13));					  // PTX L4235
	r_PtxRegister1288 = uint32_t(r_PtxRegister1287) + uint32_t(r_PtxRegister9);					  // PTX L4236
	r_PtxU64Register344 = uint64_t(int64_t(int32_t(r_PtxRegister1288)) * int64_t(int32_t(4)));	  // PTX L4237
	g_OutputByteAddressAtPtx4238 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register344); // PTX L4238
	r_LaneIndexAtPtx4240 = uint32_t((threadIdx.x & 31u));										  // PTX L4240
	r_PtxU64Register346 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4240)) * int64_t(int32_t(16))); // PTX L4242
	g_OutputByteAddressAtPtx4243 =
		uint64_t(g_OutputByteAddressAtPtx4238) + uint64_t(r_PtxU64Register346); // PTX L4243
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4243));
		r_PackedHalf2AtPtx4229R1740 = r_Value.x;
		r_PackedHalf2AtPtx4230R1741 = r_Value.y;
		r_PackedHalf2AtPtx4231R1742 = r_Value.z;
		r_PackedHalf2AtPtx4232R1743 = r_Value.w;
	} // PTX L4245
L__BB44_270:													   // PTX L4247
	r_bPtxPredicate108 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4248
	r_PtxRegister58 = uint32_t(r_PtxRegister57) + uint32_t(1);	   // PTX L4249
	r_PtxRegister1744 = uint32_t(0);							   // PTX L4250
	if (r_bPtxPredicate108)
	{
		goto L__BB44_272;
	} // PTX L4251
	r_bPtxPredicate109 = int32_t(r_PtxRegister58) >= int32_t(r_PtxRegister4); // PTX L4252
	r_PtxRegister1744 = uint32_t(r_PtxRegister58);							  // PTX L4253
	r_PackedHalf2AtPtx4254R1745 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4254
	r_PackedHalf2AtPtx4255R1746 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4255
	r_PackedHalf2AtPtx4256R1747 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4256
	r_PackedHalf2AtPtx4257R1748 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4257
	if (r_bPtxPredicate109)
	{
		goto L__BB44_273;
	} // PTX L4258
L__BB44_272:																					  // PTX L4259
	r_PtxRegister1290 = ShiftLeft(uint32_t(r_PtxRegister1744), uint32_t(13));					  // PTX L4260
	r_PtxRegister1291 = uint32_t(r_PtxRegister1290) + uint32_t(r_PtxRegister6);					  // PTX L4261
	r_PtxU64Register348 = uint64_t(int64_t(int32_t(r_PtxRegister1291)) * int64_t(int32_t(4)));	  // PTX L4262
	g_OutputByteAddressAtPtx4263 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register348); // PTX L4263
	r_LaneIndexAtPtx4265 = uint32_t((threadIdx.x & 31u));										  // PTX L4265
	r_PtxU64Register350 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4265)) * int64_t(int32_t(16))); // PTX L4267
	g_OutputByteAddressAtPtx4268 =
		uint64_t(g_OutputByteAddressAtPtx4263) + uint64_t(r_PtxU64Register350); // PTX L4268
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4268));
		r_PackedHalf2AtPtx4254R1745 = r_Value.x;
		r_PackedHalf2AtPtx4255R1746 = r_Value.y;
		r_PackedHalf2AtPtx4256R1747 = r_Value.z;
		r_PackedHalf2AtPtx4257R1748 = r_Value.w;
	} // PTX L4270
L__BB44_273:													   // PTX L4272
	r_bPtxPredicate110 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4273
	r_PtxRegister1749 = uint32_t(0);							   // PTX L4274
	if (r_bPtxPredicate110)
	{
		goto L__BB44_275;
	} // PTX L4275
	r_bPtxPredicate111 = int32_t(r_PtxRegister58) >= int32_t(r_PtxRegister4); // PTX L4276
	r_PtxRegister1749 = uint32_t(r_PtxRegister58);							  // PTX L4277
	r_PackedHalf2AtPtx4278R1750 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4278
	r_PackedHalf2AtPtx4279R1751 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4279
	r_PackedHalf2AtPtx4280R1752 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4280
	r_PackedHalf2AtPtx4281R1753 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4281
	if (r_bPtxPredicate111)
	{
		goto L__BB44_276;
	} // PTX L4282
L__BB44_275:																					  // PTX L4283
	r_PtxRegister1293 = ShiftLeft(uint32_t(r_PtxRegister1749), uint32_t(13));					  // PTX L4284
	r_PtxRegister1294 = uint32_t(r_PtxRegister1293) + uint32_t(r_PtxRegister7);					  // PTX L4285
	r_PtxU64Register352 = uint64_t(int64_t(int32_t(r_PtxRegister1294)) * int64_t(int32_t(4)));	  // PTX L4286
	g_OutputByteAddressAtPtx4287 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register352); // PTX L4287
	r_LaneIndexAtPtx4289 = uint32_t((threadIdx.x & 31u));										  // PTX L4289
	r_PtxU64Register354 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4289)) * int64_t(int32_t(16))); // PTX L4291
	g_OutputByteAddressAtPtx4292 =
		uint64_t(g_OutputByteAddressAtPtx4287) + uint64_t(r_PtxU64Register354); // PTX L4292
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4292));
		r_PackedHalf2AtPtx4278R1750 = r_Value.x;
		r_PackedHalf2AtPtx4279R1751 = r_Value.y;
		r_PackedHalf2AtPtx4280R1752 = r_Value.z;
		r_PackedHalf2AtPtx4281R1753 = r_Value.w;
	} // PTX L4294
L__BB44_276:													   // PTX L4296
	r_bPtxPredicate112 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4297
	r_PtxRegister1754 = uint32_t(0);							   // PTX L4298
	if (r_bPtxPredicate112)
	{
		goto L__BB44_278;
	} // PTX L4299
	r_bPtxPredicate113 = int32_t(r_PtxRegister58) >= int32_t(r_PtxRegister4); // PTX L4300
	r_PtxRegister1754 = uint32_t(r_PtxRegister58);							  // PTX L4301
	r_PackedHalf2AtPtx4302R1755 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4302
	r_PackedHalf2AtPtx4303R1756 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4303
	r_PackedHalf2AtPtx4304R1757 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4304
	r_PackedHalf2AtPtx4305R1758 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4305
	if (r_bPtxPredicate113)
	{
		goto L__BB44_279;
	} // PTX L4306
L__BB44_278:																					  // PTX L4307
	r_PtxRegister1296 = ShiftLeft(uint32_t(r_PtxRegister1754), uint32_t(13));					  // PTX L4308
	r_PtxRegister1297 = uint32_t(r_PtxRegister1296) + uint32_t(r_PtxRegister8);					  // PTX L4309
	r_PtxU64Register356 = uint64_t(int64_t(int32_t(r_PtxRegister1297)) * int64_t(int32_t(4)));	  // PTX L4310
	g_OutputByteAddressAtPtx4311 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register356); // PTX L4311
	r_LaneIndexAtPtx4313 = uint32_t((threadIdx.x & 31u));										  // PTX L4313
	r_PtxU64Register358 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4313)) * int64_t(int32_t(16))); // PTX L4315
	g_OutputByteAddressAtPtx4316 =
		uint64_t(g_OutputByteAddressAtPtx4311) + uint64_t(r_PtxU64Register358); // PTX L4316
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4316));
		r_PackedHalf2AtPtx4302R1755 = r_Value.x;
		r_PackedHalf2AtPtx4303R1756 = r_Value.y;
		r_PackedHalf2AtPtx4304R1757 = r_Value.z;
		r_PackedHalf2AtPtx4305R1758 = r_Value.w;
	} // PTX L4318
L__BB44_279:													   // PTX L4320
	r_bPtxPredicate114 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4321
	r_PtxRegister1759 = uint32_t(0);							   // PTX L4322
	if (r_bPtxPredicate114)
	{
		goto L__BB44_281;
	} // PTX L4323
	r_bPtxPredicate115 = int32_t(r_PtxRegister58) >= int32_t(r_PtxRegister4); // PTX L4324
	r_PtxRegister1759 = uint32_t(r_PtxRegister58);							  // PTX L4325
	r_PackedHalf2AtPtx4326R1760 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4326
	r_PackedHalf2AtPtx4327R1761 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4327
	r_PackedHalf2AtPtx4328R1762 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4328
	r_PackedHalf2AtPtx4329R1763 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4329
	if (r_bPtxPredicate115)
	{
		goto L__BB44_282;
	} // PTX L4330
L__BB44_281:																					  // PTX L4331
	r_PtxRegister1299 = ShiftLeft(uint32_t(r_PtxRegister1759), uint32_t(13));					  // PTX L4332
	r_PtxRegister1300 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister9);					  // PTX L4333
	r_PtxU64Register360 = uint64_t(int64_t(int32_t(r_PtxRegister1300)) * int64_t(int32_t(4)));	  // PTX L4334
	g_OutputByteAddressAtPtx4335 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register360); // PTX L4335
	r_LaneIndexAtPtx4337 = uint32_t((threadIdx.x & 31u));										  // PTX L4337
	r_PtxU64Register362 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4337)) * int64_t(int32_t(16))); // PTX L4339
	g_OutputByteAddressAtPtx4340 =
		uint64_t(g_OutputByteAddressAtPtx4335) + uint64_t(r_PtxU64Register362); // PTX L4340
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4340));
		r_PackedHalf2AtPtx4326R1760 = r_Value.x;
		r_PackedHalf2AtPtx4327R1761 = r_Value.y;
		r_PackedHalf2AtPtx4328R1762 = r_Value.z;
		r_PackedHalf2AtPtx4329R1763 = r_Value.w;
	} // PTX L4342
L__BB44_282:													   // PTX L4344
	r_bPtxPredicate116 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4345
	r_PtxRegister59 = uint32_t(r_PtxRegister57) + uint32_t(2);	   // PTX L4346
	r_PtxRegister1764 = uint32_t(0);							   // PTX L4347
	if (r_bPtxPredicate116)
	{
		goto L__BB44_284;
	} // PTX L4348
	r_bPtxPredicate117 = int32_t(r_PtxRegister59) >= int32_t(r_PtxRegister4); // PTX L4349
	r_PtxRegister1764 = uint32_t(r_PtxRegister59);							  // PTX L4350
	r_PackedHalf2AtPtx4351R1765 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4351
	r_PackedHalf2AtPtx4352R1766 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4352
	r_PackedHalf2AtPtx4353R1767 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4353
	r_PackedHalf2AtPtx4354R1768 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4354
	if (r_bPtxPredicate117)
	{
		goto L__BB44_285;
	} // PTX L4355
L__BB44_284:																					  // PTX L4356
	r_PtxRegister1302 = ShiftLeft(uint32_t(r_PtxRegister1764), uint32_t(13));					  // PTX L4357
	r_PtxRegister1303 = uint32_t(r_PtxRegister1302) + uint32_t(r_PtxRegister6);					  // PTX L4358
	r_PtxU64Register364 = uint64_t(int64_t(int32_t(r_PtxRegister1303)) * int64_t(int32_t(4)));	  // PTX L4359
	g_OutputByteAddressAtPtx4360 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register364); // PTX L4360
	r_LaneIndexAtPtx4362 = uint32_t((threadIdx.x & 31u));										  // PTX L4362
	r_PtxU64Register366 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4362)) * int64_t(int32_t(16))); // PTX L4364
	g_OutputByteAddressAtPtx4365 =
		uint64_t(g_OutputByteAddressAtPtx4360) + uint64_t(r_PtxU64Register366); // PTX L4365
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4365));
		r_PackedHalf2AtPtx4351R1765 = r_Value.x;
		r_PackedHalf2AtPtx4352R1766 = r_Value.y;
		r_PackedHalf2AtPtx4353R1767 = r_Value.z;
		r_PackedHalf2AtPtx4354R1768 = r_Value.w;
	} // PTX L4367
L__BB44_285:													   // PTX L4369
	r_bPtxPredicate118 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4370
	r_PtxRegister1769 = uint32_t(0);							   // PTX L4371
	if (r_bPtxPredicate118)
	{
		goto L__BB44_287;
	} // PTX L4372
	r_bPtxPredicate119 = int32_t(r_PtxRegister59) >= int32_t(r_PtxRegister4); // PTX L4373
	r_PtxRegister1769 = uint32_t(r_PtxRegister59);							  // PTX L4374
	r_PackedHalf2AtPtx4375R1770 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4375
	r_PackedHalf2AtPtx4376R1771 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4376
	r_PackedHalf2AtPtx4377R1772 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4377
	r_PackedHalf2AtPtx4378R1773 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4378
	if (r_bPtxPredicate119)
	{
		goto L__BB44_288;
	} // PTX L4379
L__BB44_287:																					  // PTX L4380
	r_PtxRegister1305 = ShiftLeft(uint32_t(r_PtxRegister1769), uint32_t(13));					  // PTX L4381
	r_PtxRegister1306 = uint32_t(r_PtxRegister1305) + uint32_t(r_PtxRegister7);					  // PTX L4382
	r_PtxU64Register368 = uint64_t(int64_t(int32_t(r_PtxRegister1306)) * int64_t(int32_t(4)));	  // PTX L4383
	g_OutputByteAddressAtPtx4384 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register368); // PTX L4384
	r_LaneIndexAtPtx4386 = uint32_t((threadIdx.x & 31u));										  // PTX L4386
	r_PtxU64Register370 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4386)) * int64_t(int32_t(16))); // PTX L4388
	g_OutputByteAddressAtPtx4389 =
		uint64_t(g_OutputByteAddressAtPtx4384) + uint64_t(r_PtxU64Register370); // PTX L4389
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4389));
		r_PackedHalf2AtPtx4375R1770 = r_Value.x;
		r_PackedHalf2AtPtx4376R1771 = r_Value.y;
		r_PackedHalf2AtPtx4377R1772 = r_Value.z;
		r_PackedHalf2AtPtx4378R1773 = r_Value.w;
	} // PTX L4391
L__BB44_288:													   // PTX L4393
	r_bPtxPredicate120 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4394
	r_PtxRegister1774 = uint32_t(0);							   // PTX L4395
	if (r_bPtxPredicate120)
	{
		goto L__BB44_290;
	} // PTX L4396
	r_bPtxPredicate121 = int32_t(r_PtxRegister59) >= int32_t(r_PtxRegister4); // PTX L4397
	r_PtxRegister1774 = uint32_t(r_PtxRegister59);							  // PTX L4398
	r_PackedHalf2AtPtx4399R1775 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4399
	r_PackedHalf2AtPtx4400R1776 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4400
	r_PackedHalf2AtPtx4401R1777 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4401
	r_PackedHalf2AtPtx4402R1778 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4402
	if (r_bPtxPredicate121)
	{
		goto L__BB44_291;
	} // PTX L4403
L__BB44_290:																					  // PTX L4404
	r_PtxRegister1308 = ShiftLeft(uint32_t(r_PtxRegister1774), uint32_t(13));					  // PTX L4405
	r_PtxRegister1309 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister8);					  // PTX L4406
	r_PtxU64Register372 = uint64_t(int64_t(int32_t(r_PtxRegister1309)) * int64_t(int32_t(4)));	  // PTX L4407
	g_OutputByteAddressAtPtx4408 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register372); // PTX L4408
	r_LaneIndexAtPtx4410 = uint32_t((threadIdx.x & 31u));										  // PTX L4410
	r_PtxU64Register374 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4410)) * int64_t(int32_t(16))); // PTX L4412
	g_OutputByteAddressAtPtx4413 =
		uint64_t(g_OutputByteAddressAtPtx4408) + uint64_t(r_PtxU64Register374); // PTX L4413
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4413));
		r_PackedHalf2AtPtx4399R1775 = r_Value.x;
		r_PackedHalf2AtPtx4400R1776 = r_Value.y;
		r_PackedHalf2AtPtx4401R1777 = r_Value.z;
		r_PackedHalf2AtPtx4402R1778 = r_Value.w;
	} // PTX L4415
L__BB44_291:													   // PTX L4417
	r_bPtxPredicate122 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4418
	r_PtxRegister1779 = uint32_t(0);							   // PTX L4419
	if (r_bPtxPredicate122)
	{
		goto L__BB44_293;
	} // PTX L4420
	r_bPtxPredicate123 = int32_t(r_PtxRegister59) >= int32_t(r_PtxRegister4); // PTX L4421
	r_PtxRegister1779 = uint32_t(r_PtxRegister59);							  // PTX L4422
	r_PackedHalf2AtPtx4423R1780 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4423
	r_PackedHalf2AtPtx4424R1781 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4424
	r_PackedHalf2AtPtx4425R1782 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4425
	r_PackedHalf2AtPtx4426R1783 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4426
	if (r_bPtxPredicate123)
	{
		goto L__BB44_294;
	} // PTX L4427
L__BB44_293:																					  // PTX L4428
	r_PtxRegister1311 = ShiftLeft(uint32_t(r_PtxRegister1779), uint32_t(13));					  // PTX L4429
	r_PtxRegister1312 = uint32_t(r_PtxRegister1311) + uint32_t(r_PtxRegister9);					  // PTX L4430
	r_PtxU64Register376 = uint64_t(int64_t(int32_t(r_PtxRegister1312)) * int64_t(int32_t(4)));	  // PTX L4431
	g_OutputByteAddressAtPtx4432 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register376); // PTX L4432
	r_LaneIndexAtPtx4434 = uint32_t((threadIdx.x & 31u));										  // PTX L4434
	r_PtxU64Register378 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4434)) * int64_t(int32_t(16))); // PTX L4436
	g_OutputByteAddressAtPtx4437 =
		uint64_t(g_OutputByteAddressAtPtx4432) + uint64_t(r_PtxU64Register378); // PTX L4437
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4437));
		r_PackedHalf2AtPtx4423R1780 = r_Value.x;
		r_PackedHalf2AtPtx4424R1781 = r_Value.y;
		r_PackedHalf2AtPtx4425R1782 = r_Value.z;
		r_PackedHalf2AtPtx4426R1783 = r_Value.w;
	} // PTX L4439
L__BB44_294:													   // PTX L4441
	r_bPtxPredicate124 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4442
	r_PtxRegister60 = uint32_t(r_PtxRegister57) + uint32_t(3);	   // PTX L4443
	r_PtxRegister1784 = uint32_t(0);							   // PTX L4444
	if (r_bPtxPredicate124)
	{
		goto L__BB44_296;
	} // PTX L4445
	r_bPtxPredicate125 = int32_t(r_PtxRegister60) >= int32_t(r_PtxRegister4); // PTX L4446
	r_PtxRegister1784 = uint32_t(r_PtxRegister60);							  // PTX L4447
	r_PackedHalf2AtPtx4448R1785 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4448
	r_PackedHalf2AtPtx4449R1786 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4449
	r_PackedHalf2AtPtx4450R1787 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4450
	r_PackedHalf2AtPtx4451R1788 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4451
	if (r_bPtxPredicate125)
	{
		goto L__BB44_297;
	} // PTX L4452
L__BB44_296:																					  // PTX L4453
	r_PtxRegister1314 = ShiftLeft(uint32_t(r_PtxRegister1784), uint32_t(13));					  // PTX L4454
	r_PtxRegister1315 = uint32_t(r_PtxRegister1314) + uint32_t(r_PtxRegister6);					  // PTX L4455
	r_PtxU64Register380 = uint64_t(int64_t(int32_t(r_PtxRegister1315)) * int64_t(int32_t(4)));	  // PTX L4456
	g_OutputByteAddressAtPtx4457 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register380); // PTX L4457
	r_LaneIndexAtPtx4459 = uint32_t((threadIdx.x & 31u));										  // PTX L4459
	r_PtxU64Register382 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4459)) * int64_t(int32_t(16))); // PTX L4461
	g_OutputByteAddressAtPtx4462 =
		uint64_t(g_OutputByteAddressAtPtx4457) + uint64_t(r_PtxU64Register382); // PTX L4462
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4462));
		r_PackedHalf2AtPtx4448R1785 = r_Value.x;
		r_PackedHalf2AtPtx4449R1786 = r_Value.y;
		r_PackedHalf2AtPtx4450R1787 = r_Value.z;
		r_PackedHalf2AtPtx4451R1788 = r_Value.w;
	} // PTX L4464
L__BB44_297:													   // PTX L4466
	r_bPtxPredicate126 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4467
	r_PtxRegister1789 = uint32_t(0);							   // PTX L4468
	if (r_bPtxPredicate126)
	{
		goto L__BB44_299;
	} // PTX L4469
	r_bPtxPredicate127 = int32_t(r_PtxRegister60) >= int32_t(r_PtxRegister4); // PTX L4470
	r_PtxRegister1789 = uint32_t(r_PtxRegister60);							  // PTX L4471
	r_PackedHalf2AtPtx4472R1790 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4472
	r_PackedHalf2AtPtx4473R1791 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4473
	r_PackedHalf2AtPtx4474R1792 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4474
	r_PackedHalf2AtPtx4475R1793 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4475
	if (r_bPtxPredicate127)
	{
		goto L__BB44_300;
	} // PTX L4476
L__BB44_299:																					  // PTX L4477
	r_PtxRegister1317 = ShiftLeft(uint32_t(r_PtxRegister1789), uint32_t(13));					  // PTX L4478
	r_PtxRegister1318 = uint32_t(r_PtxRegister1317) + uint32_t(r_PtxRegister7);					  // PTX L4479
	r_PtxU64Register384 = uint64_t(int64_t(int32_t(r_PtxRegister1318)) * int64_t(int32_t(4)));	  // PTX L4480
	g_OutputByteAddressAtPtx4481 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register384); // PTX L4481
	r_LaneIndexAtPtx4483 = uint32_t((threadIdx.x & 31u));										  // PTX L4483
	r_PtxU64Register386 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4483)) * int64_t(int32_t(16))); // PTX L4485
	g_OutputByteAddressAtPtx4486 =
		uint64_t(g_OutputByteAddressAtPtx4481) + uint64_t(r_PtxU64Register386); // PTX L4486
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4486));
		r_PackedHalf2AtPtx4472R1790 = r_Value.x;
		r_PackedHalf2AtPtx4473R1791 = r_Value.y;
		r_PackedHalf2AtPtx4474R1792 = r_Value.z;
		r_PackedHalf2AtPtx4475R1793 = r_Value.w;
	} // PTX L4488
L__BB44_300:													   // PTX L4490
	r_bPtxPredicate128 = uint32_t(r_PtxRegister41) < uint32_t(31); // PTX L4491
	r_PtxRegister1794 = uint32_t(0);							   // PTX L4492
	if (r_bPtxPredicate128)
	{
		goto L__BB44_302;
	} // PTX L4493
	r_bPtxPredicate129 = int32_t(r_PtxRegister60) >= int32_t(r_PtxRegister4); // PTX L4494
	r_PtxRegister1794 = uint32_t(r_PtxRegister60);							  // PTX L4495
	r_PackedHalf2AtPtx4496R1795 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4496
	r_PackedHalf2AtPtx4497R1796 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4497
	r_PackedHalf2AtPtx4498R1797 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4498
	r_PackedHalf2AtPtx4499R1798 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4499
	if (r_bPtxPredicate129)
	{
		goto L__BB44_303;
	} // PTX L4500
L__BB44_302:																					  // PTX L4501
	r_PtxRegister1320 = ShiftLeft(uint32_t(r_PtxRegister1794), uint32_t(13));					  // PTX L4502
	r_PtxRegister1321 = uint32_t(r_PtxRegister1320) + uint32_t(r_PtxRegister8);					  // PTX L4503
	r_PtxU64Register388 = uint64_t(int64_t(int32_t(r_PtxRegister1321)) * int64_t(int32_t(4)));	  // PTX L4504
	g_OutputByteAddressAtPtx4505 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register388); // PTX L4505
	r_LaneIndexAtPtx4507 = uint32_t((threadIdx.x & 31u));										  // PTX L4507
	r_PtxU64Register390 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4507)) * int64_t(int32_t(16))); // PTX L4509
	g_OutputByteAddressAtPtx4510 =
		uint64_t(g_OutputByteAddressAtPtx4505) + uint64_t(r_PtxU64Register390); // PTX L4510
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4510));
		r_PackedHalf2AtPtx4496R1795 = r_Value.x;
		r_PackedHalf2AtPtx4497R1796 = r_Value.y;
		r_PackedHalf2AtPtx4498R1797 = r_Value.z;
		r_PackedHalf2AtPtx4499R1798 = r_Value.w;
	} // PTX L4512
L__BB44_303:						 // PTX L4514
	r_PtxRegister1799 = uint32_t(0); // PTX L4515
	if (r_bPtxPredicate128)
	{
		goto L__BB44_305;
	} // PTX L4516
	r_bPtxPredicate130 = int32_t(r_PtxRegister60) >= int32_t(r_PtxRegister4); // PTX L4517
	r_PtxRegister1799 = uint32_t(r_PtxRegister60);							  // PTX L4518
	r_PackedHalf2AtPtx4519R1801 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4519
	r_PackedHalf2AtPtx4520R1802 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4520
	r_PackedHalf2AtPtx4521R1803 = uint32_t(r_PackedHalf2AtPtx4534R1800);	  // PTX L4521
	if (r_bPtxPredicate130)
	{
		goto L__BB44_306;
	} // PTX L4522
L__BB44_305:																					  // PTX L4523
	r_PtxRegister1323 = ShiftLeft(uint32_t(r_PtxRegister1799), uint32_t(13));					  // PTX L4524
	r_PtxRegister1324 = uint32_t(r_PtxRegister1323) + uint32_t(r_PtxRegister9);					  // PTX L4525
	r_PtxU64Register392 = uint64_t(int64_t(int32_t(r_PtxRegister1324)) * int64_t(int32_t(4)));	  // PTX L4526
	g_OutputByteAddressAtPtx4527 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register392); // PTX L4527
	r_LaneIndexAtPtx4529 = uint32_t((threadIdx.x & 31u));										  // PTX L4529
	r_PtxU64Register394 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4529)) * int64_t(int32_t(16))); // PTX L4531
	g_OutputByteAddressAtPtx4532 =
		uint64_t(g_OutputByteAddressAtPtx4527) + uint64_t(r_PtxU64Register394); // PTX L4532
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_OutputByteAddressAtPtx4532));
		r_PackedHalf2AtPtx4534R1800 = r_Value.x;
		r_PackedHalf2AtPtx4519R1801 = r_Value.y;
		r_PackedHalf2AtPtx4520R1802 = r_Value.z;
		r_PackedHalf2AtPtx4521R1803 = r_Value.w;
	} // PTX L4534
L__BB44_306:											  // PTX L4536
	r_LaneIndexAtPtx4538 = uint32_t((threadIdx.x & 31u)); // PTX L4538
	r_PackedHalf2AtPtx4541R1392 =
		HalfAdd(r_PackedHalf2AtPtx4157R1725, r_PackedHalf2AtPtx1090R1687); // PTX L4541
	r_LaneIndexAtPtx4545 = uint32_t((threadIdx.x & 31u));				   // PTX L4545
	r_PackedHalf2AtPtx4548R1393 =
		HalfAdd(r_PackedHalf2AtPtx4158R1726, r_PackedHalf2AtPtx1089R1686); // PTX L4548
	r_LaneIndexAtPtx4552 = uint32_t((threadIdx.x & 31u));				   // PTX L4552
	r_PackedHalf2AtPtx4555R1394 =
		HalfAdd(r_PackedHalf2AtPtx4159R1727, r_PackedHalf2AtPtx1088R1685); // PTX L4555
	r_LaneIndexAtPtx4559 = uint32_t((threadIdx.x & 31u));				   // PTX L4559
	r_PackedHalf2AtPtx4562R1395 =
		HalfAdd(r_PackedHalf2AtPtx4160R1728, r_PackedHalf2AtPtx1087R1684); // PTX L4562
	r_LaneIndexAtPtx4566 = uint32_t((threadIdx.x & 31u));				   // PTX L4566
	r_PackedHalf2AtPtx4569R1397 =
		HalfAdd(r_PackedHalf2AtPtx4181R1730, r_PackedHalf2AtPtx1086R1683); // PTX L4569
	r_LaneIndexAtPtx4573 = uint32_t((threadIdx.x & 31u));				   // PTX L4573
	r_PackedHalf2AtPtx4576R1398 =
		HalfAdd(r_PackedHalf2AtPtx4182R1731, r_PackedHalf2AtPtx1085R1682); // PTX L4576
	r_LaneIndexAtPtx4580 = uint32_t((threadIdx.x & 31u));				   // PTX L4580
	r_PackedHalf2AtPtx4583R1399 =
		HalfAdd(r_PackedHalf2AtPtx4183R1732, r_PackedHalf2AtPtx1084R1681); // PTX L4583
	r_LaneIndexAtPtx4587 = uint32_t((threadIdx.x & 31u));				   // PTX L4587
	r_PackedHalf2AtPtx4590R1400 =
		HalfAdd(r_PackedHalf2AtPtx4184R1733, r_PackedHalf2AtPtx1083R1680); // PTX L4590
	r_LaneIndexAtPtx4594 = uint32_t((threadIdx.x & 31u));				   // PTX L4594
	r_PackedHalf2AtPtx4597R1402 =
		HalfAdd(r_PackedHalf2AtPtx4205R1735, r_PackedHalf2AtPtx1082R1679); // PTX L4597
	r_LaneIndexAtPtx4601 = uint32_t((threadIdx.x & 31u));				   // PTX L4601
	r_PackedHalf2AtPtx4604R1403 =
		HalfAdd(r_PackedHalf2AtPtx4206R1736, r_PackedHalf2AtPtx1081R1678); // PTX L4604
	r_LaneIndexAtPtx4608 = uint32_t((threadIdx.x & 31u));				   // PTX L4608
	r_PackedHalf2AtPtx4611R1404 =
		HalfAdd(r_PackedHalf2AtPtx4207R1737, r_PackedHalf2AtPtx1080R1677); // PTX L4611
	r_LaneIndexAtPtx4615 = uint32_t((threadIdx.x & 31u));				   // PTX L4615
	r_PackedHalf2AtPtx4618R1405 =
		HalfAdd(r_PackedHalf2AtPtx4208R1738, r_PackedHalf2AtPtx1079R1676); // PTX L4618
	r_LaneIndexAtPtx4622 = uint32_t((threadIdx.x & 31u));				   // PTX L4622
	r_PackedHalf2AtPtx4625R1407 =
		HalfAdd(r_PackedHalf2AtPtx4229R1740, r_PackedHalf2AtPtx1078R1675); // PTX L4625
	r_LaneIndexAtPtx4629 = uint32_t((threadIdx.x & 31u));				   // PTX L4629
	r_PackedHalf2AtPtx4632R1408 =
		HalfAdd(r_PackedHalf2AtPtx4230R1741, r_PackedHalf2AtPtx1077R1674); // PTX L4632
	r_LaneIndexAtPtx4636 = uint32_t((threadIdx.x & 31u));				   // PTX L4636
	r_PackedHalf2AtPtx4639R1409 =
		HalfAdd(r_PackedHalf2AtPtx4231R1742, r_PackedHalf2AtPtx1076R1673); // PTX L4639
	r_LaneIndexAtPtx4643 = uint32_t((threadIdx.x & 31u));				   // PTX L4643
	r_PackedHalf2AtPtx4646R1410 =
		HalfAdd(r_PackedHalf2AtPtx4232R1743, r_PackedHalf2AtPtx1075R1672); // PTX L4646
	r_LaneIndexAtPtx4650 = uint32_t((threadIdx.x & 31u));				   // PTX L4650
	r_PackedHalf2AtPtx4653R1412 =
		HalfAdd(r_PackedHalf2AtPtx4254R1745, r_PackedHalf2AtPtx1074R1671); // PTX L4653
	r_LaneIndexAtPtx4657 = uint32_t((threadIdx.x & 31u));				   // PTX L4657
	r_PackedHalf2AtPtx4660R1413 =
		HalfAdd(r_PackedHalf2AtPtx4255R1746, r_PackedHalf2AtPtx1073R1670); // PTX L4660
	r_LaneIndexAtPtx4664 = uint32_t((threadIdx.x & 31u));				   // PTX L4664
	r_PackedHalf2AtPtx4667R1414 =
		HalfAdd(r_PackedHalf2AtPtx4256R1747, r_PackedHalf2AtPtx1072R1669); // PTX L4667
	r_LaneIndexAtPtx4671 = uint32_t((threadIdx.x & 31u));				   // PTX L4671
	r_PackedHalf2AtPtx4674R1415 =
		HalfAdd(r_PackedHalf2AtPtx4257R1748, r_PackedHalf2AtPtx1071R1668); // PTX L4674
	r_LaneIndexAtPtx4678 = uint32_t((threadIdx.x & 31u));				   // PTX L4678
	r_PackedHalf2AtPtx4681R1417 =
		HalfAdd(r_PackedHalf2AtPtx4278R1750, r_PackedHalf2AtPtx1070R1667); // PTX L4681
	r_LaneIndexAtPtx4685 = uint32_t((threadIdx.x & 31u));				   // PTX L4685
	r_PackedHalf2AtPtx4688R1418 =
		HalfAdd(r_PackedHalf2AtPtx4279R1751, r_PackedHalf2AtPtx1069R1666); // PTX L4688
	r_LaneIndexAtPtx4692 = uint32_t((threadIdx.x & 31u));				   // PTX L4692
	r_PackedHalf2AtPtx4695R1419 =
		HalfAdd(r_PackedHalf2AtPtx4280R1752, r_PackedHalf2AtPtx1068R1665); // PTX L4695
	r_LaneIndexAtPtx4699 = uint32_t((threadIdx.x & 31u));				   // PTX L4699
	r_PackedHalf2AtPtx4702R1420 =
		HalfAdd(r_PackedHalf2AtPtx4281R1753, r_PackedHalf2AtPtx1067R1664); // PTX L4702
	r_LaneIndexAtPtx4706 = uint32_t((threadIdx.x & 31u));				   // PTX L4706
	r_PackedHalf2AtPtx4709R1422 =
		HalfAdd(r_PackedHalf2AtPtx4302R1755, r_PackedHalf2AtPtx1066R1663); // PTX L4709
	r_LaneIndexAtPtx4713 = uint32_t((threadIdx.x & 31u));				   // PTX L4713
	r_PackedHalf2AtPtx4716R1423 =
		HalfAdd(r_PackedHalf2AtPtx4303R1756, r_PackedHalf2AtPtx1065R1662); // PTX L4716
	r_LaneIndexAtPtx4720 = uint32_t((threadIdx.x & 31u));				   // PTX L4720
	r_PackedHalf2AtPtx4723R1424 =
		HalfAdd(r_PackedHalf2AtPtx4304R1757, r_PackedHalf2AtPtx1064R1661); // PTX L4723
	r_LaneIndexAtPtx4727 = uint32_t((threadIdx.x & 31u));				   // PTX L4727
	r_PackedHalf2AtPtx4730R1425 =
		HalfAdd(r_PackedHalf2AtPtx4305R1758, r_PackedHalf2AtPtx1063R1660); // PTX L4730
	r_LaneIndexAtPtx4734 = uint32_t((threadIdx.x & 31u));				   // PTX L4734
	r_PackedHalf2AtPtx4737R1427 =
		HalfAdd(r_PackedHalf2AtPtx4326R1760, r_PackedHalf2AtPtx1062R1659); // PTX L4737
	r_LaneIndexAtPtx4741 = uint32_t((threadIdx.x & 31u));				   // PTX L4741
	r_PackedHalf2AtPtx4744R1428 =
		HalfAdd(r_PackedHalf2AtPtx4327R1761, r_PackedHalf2AtPtx1061R1658); // PTX L4744
	r_LaneIndexAtPtx4748 = uint32_t((threadIdx.x & 31u));				   // PTX L4748
	r_PackedHalf2AtPtx4751R1429 =
		HalfAdd(r_PackedHalf2AtPtx4328R1762, r_PackedHalf2AtPtx1060R1657); // PTX L4751
	r_LaneIndexAtPtx4755 = uint32_t((threadIdx.x & 31u));				   // PTX L4755
	r_PackedHalf2AtPtx4758R1430 =
		HalfAdd(r_PackedHalf2AtPtx4329R1763, r_PackedHalf2AtPtx1059R1656); // PTX L4758
	r_LaneIndexAtPtx4762 = uint32_t((threadIdx.x & 31u));				   // PTX L4762
	r_PackedHalf2AtPtx4765R1432 =
		HalfAdd(r_PackedHalf2AtPtx4351R1765, r_PackedHalf2AtPtx1058R1655); // PTX L4765
	r_LaneIndexAtPtx4769 = uint32_t((threadIdx.x & 31u));				   // PTX L4769
	r_PackedHalf2AtPtx4772R1433 =
		HalfAdd(r_PackedHalf2AtPtx4352R1766, r_PackedHalf2AtPtx1057R1654); // PTX L4772
	r_LaneIndexAtPtx4776 = uint32_t((threadIdx.x & 31u));				   // PTX L4776
	r_PackedHalf2AtPtx4779R1434 =
		HalfAdd(r_PackedHalf2AtPtx4353R1767, r_PackedHalf2AtPtx1056R1653); // PTX L4779
	r_LaneIndexAtPtx4783 = uint32_t((threadIdx.x & 31u));				   // PTX L4783
	r_PackedHalf2AtPtx4786R1435 =
		HalfAdd(r_PackedHalf2AtPtx4354R1768, r_PackedHalf2AtPtx1055R1652); // PTX L4786
	r_LaneIndexAtPtx4790 = uint32_t((threadIdx.x & 31u));				   // PTX L4790
	r_PackedHalf2AtPtx4793R1437 =
		HalfAdd(r_PackedHalf2AtPtx4375R1770, r_PackedHalf2AtPtx1054R1651); // PTX L4793
	r_LaneIndexAtPtx4797 = uint32_t((threadIdx.x & 31u));				   // PTX L4797
	r_PackedHalf2AtPtx4800R1438 =
		HalfAdd(r_PackedHalf2AtPtx4376R1771, r_PackedHalf2AtPtx1053R1650); // PTX L4800
	r_LaneIndexAtPtx4804 = uint32_t((threadIdx.x & 31u));				   // PTX L4804
	r_PackedHalf2AtPtx4807R1439 =
		HalfAdd(r_PackedHalf2AtPtx4377R1772, r_PackedHalf2AtPtx1052R1649); // PTX L4807
	r_LaneIndexAtPtx4811 = uint32_t((threadIdx.x & 31u));				   // PTX L4811
	r_PackedHalf2AtPtx4814R1440 =
		HalfAdd(r_PackedHalf2AtPtx4378R1773, r_PackedHalf2AtPtx1051R1648); // PTX L4814
	r_LaneIndexAtPtx4818 = uint32_t((threadIdx.x & 31u));				   // PTX L4818
	r_PackedHalf2AtPtx4821R1442 =
		HalfAdd(r_PackedHalf2AtPtx4399R1775, r_PackedHalf2AtPtx1050R1647); // PTX L4821
	r_LaneIndexAtPtx4825 = uint32_t((threadIdx.x & 31u));				   // PTX L4825
	r_PackedHalf2AtPtx4828R1443 =
		HalfAdd(r_PackedHalf2AtPtx4400R1776, r_PackedHalf2AtPtx1049R1646); // PTX L4828
	r_LaneIndexAtPtx4832 = uint32_t((threadIdx.x & 31u));				   // PTX L4832
	r_PackedHalf2AtPtx4835R1444 =
		HalfAdd(r_PackedHalf2AtPtx4401R1777, r_PackedHalf2AtPtx1048R1645); // PTX L4835
	r_LaneIndexAtPtx4839 = uint32_t((threadIdx.x & 31u));				   // PTX L4839
	r_PackedHalf2AtPtx4842R1445 =
		HalfAdd(r_PackedHalf2AtPtx4402R1778, r_PackedHalf2AtPtx1047R1644); // PTX L4842
	r_LaneIndexAtPtx4846 = uint32_t((threadIdx.x & 31u));				   // PTX L4846
	r_PackedHalf2AtPtx4849R1447 =
		HalfAdd(r_PackedHalf2AtPtx4423R1780, r_PackedHalf2AtPtx1046R1643); // PTX L4849
	r_LaneIndexAtPtx4853 = uint32_t((threadIdx.x & 31u));				   // PTX L4853
	r_PackedHalf2AtPtx4856R1448 =
		HalfAdd(r_PackedHalf2AtPtx4424R1781, r_PackedHalf2AtPtx1045R1642); // PTX L4856
	r_LaneIndexAtPtx4860 = uint32_t((threadIdx.x & 31u));				   // PTX L4860
	r_PackedHalf2AtPtx4863R1449 =
		HalfAdd(r_PackedHalf2AtPtx4425R1782, r_PackedHalf2AtPtx1044R1641); // PTX L4863
	r_LaneIndexAtPtx4867 = uint32_t((threadIdx.x & 31u));				   // PTX L4867
	r_PackedHalf2AtPtx4870R1450 =
		HalfAdd(r_PackedHalf2AtPtx4426R1783, r_PackedHalf2AtPtx1043R1640); // PTX L4870
	r_LaneIndexAtPtx4874 = uint32_t((threadIdx.x & 31u));				   // PTX L4874
	r_PackedHalf2AtPtx4877R1452 =
		HalfAdd(r_PackedHalf2AtPtx4448R1785, r_PackedHalf2AtPtx1042R1639); // PTX L4877
	r_LaneIndexAtPtx4881 = uint32_t((threadIdx.x & 31u));				   // PTX L4881
	r_PackedHalf2AtPtx4884R1453 =
		HalfAdd(r_PackedHalf2AtPtx4449R1786, r_PackedHalf2AtPtx1041R1638); // PTX L4884
	r_LaneIndexAtPtx4888 = uint32_t((threadIdx.x & 31u));				   // PTX L4888
	r_PackedHalf2AtPtx4891R1454 =
		HalfAdd(r_PackedHalf2AtPtx4450R1787, r_PackedHalf2AtPtx1040R1637); // PTX L4891
	r_LaneIndexAtPtx4895 = uint32_t((threadIdx.x & 31u));				   // PTX L4895
	r_PackedHalf2AtPtx4898R1455 =
		HalfAdd(r_PackedHalf2AtPtx4451R1788, r_PackedHalf2AtPtx1039R1636); // PTX L4898
	r_LaneIndexAtPtx4902 = uint32_t((threadIdx.x & 31u));				   // PTX L4902
	r_PackedHalf2AtPtx4905R1457 =
		HalfAdd(r_PackedHalf2AtPtx4472R1790, r_PackedHalf2AtPtx1038R1635); // PTX L4905
	r_LaneIndexAtPtx4909 = uint32_t((threadIdx.x & 31u));				   // PTX L4909
	r_PackedHalf2AtPtx4912R1458 =
		HalfAdd(r_PackedHalf2AtPtx4473R1791, r_PackedHalf2AtPtx1037R1634); // PTX L4912
	r_LaneIndexAtPtx4916 = uint32_t((threadIdx.x & 31u));				   // PTX L4916
	r_PackedHalf2AtPtx4919R1459 =
		HalfAdd(r_PackedHalf2AtPtx4474R1792, r_PackedHalf2AtPtx1036R1633); // PTX L4919
	r_LaneIndexAtPtx4923 = uint32_t((threadIdx.x & 31u));				   // PTX L4923
	r_PackedHalf2AtPtx4926R1460 =
		HalfAdd(r_PackedHalf2AtPtx4475R1793, r_PackedHalf2AtPtx1035R1632); // PTX L4926
	r_LaneIndexAtPtx4930 = uint32_t((threadIdx.x & 31u));				   // PTX L4930
	r_PackedHalf2AtPtx4933R1462 =
		HalfAdd(r_PackedHalf2AtPtx4496R1795, r_PackedHalf2AtPtx1034R1631); // PTX L4933
	r_LaneIndexAtPtx4937 = uint32_t((threadIdx.x & 31u));				   // PTX L4937
	r_PackedHalf2AtPtx4940R1463 =
		HalfAdd(r_PackedHalf2AtPtx4497R1796, r_PackedHalf2AtPtx1033R1630); // PTX L4940
	r_LaneIndexAtPtx4944 = uint32_t((threadIdx.x & 31u));				   // PTX L4944
	r_PackedHalf2AtPtx4947R1464 =
		HalfAdd(r_PackedHalf2AtPtx4498R1797, r_PackedHalf2AtPtx1032R1629); // PTX L4947
	r_LaneIndexAtPtx4951 = uint32_t((threadIdx.x & 31u));				   // PTX L4951
	r_PackedHalf2AtPtx4954R1465 =
		HalfAdd(r_PackedHalf2AtPtx4499R1798, r_PackedHalf2AtPtx1031R1628); // PTX L4954
	r_LaneIndexAtPtx4958 = uint32_t((threadIdx.x & 31u));				   // PTX L4958
	r_PackedHalf2AtPtx4961R1467 =
		HalfAdd(r_PackedHalf2AtPtx4534R1800, r_PackedHalf2AtPtx1030R1627); // PTX L4961
	r_LaneIndexAtPtx4965 = uint32_t((threadIdx.x & 31u));				   // PTX L4965
	r_PackedHalf2AtPtx4968R1468 =
		HalfAdd(r_PackedHalf2AtPtx4519R1801, r_PackedHalf2AtPtx1029R1626); // PTX L4968
	r_LaneIndexAtPtx4972 = uint32_t((threadIdx.x & 31u));				   // PTX L4972
	r_PackedHalf2AtPtx4975R1469 =
		HalfAdd(r_PackedHalf2AtPtx4520R1802, r_PackedHalf2AtPtx1028R1625); // PTX L4975
	r_LaneIndexAtPtx4979 = uint32_t((threadIdx.x & 31u));				   // PTX L4979
	r_PackedHalf2AtPtx4982R1470 =
		HalfAdd(r_PackedHalf2AtPtx4521R1803, r_PackedHalf2AtPtx1027R1624);						  // PTX L4982
	r_bPtxPredicate131 = int32_t(r_PtxRegister57) >= int32_t(r_PtxRegister4);					  // PTX L4985
	r_PtxRegister1389 = ShiftLeft(uint32_t(r_PtxRegister57), uint32_t(13));						  // PTX L4986
	r_PtxRegister1390 = uint32_t(r_PtxRegister1389) + uint32_t(r_PtxRegister6);					  // PTX L4987
	r_PtxU64Register395 = uint64_t(int64_t(int32_t(r_PtxRegister1390)) * int64_t(int32_t(4)));	  // PTX L4988
	g_OutputByteAddressAtPtx4989 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register395); // PTX L4989
	if (r_bPtxPredicate131)
	{
		goto L__BB44_308;
	} // PTX L4990
	r_LaneIndexAtPtx4992 = uint32_t((threadIdx.x & 31u)); // PTX L4992
	r_PtxU64Register400 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4992)) * int64_t(int32_t(16))); // PTX L4994
	g_OutputByteAddressAtPtx4995 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register400); // PTX L4995
	StoreNoAllocate(g_OutputByteAddressAtPtx4995,
					make_uint4(r_PackedHalf2AtPtx4541R1392, r_PackedHalf2AtPtx4548R1393,
							   r_PackedHalf2AtPtx4555R1394,
							   r_PackedHalf2AtPtx4562R1395)); // PTX L4997
	r_LaneIndexAtPtx5000 = uint32_t((threadIdx.x & 31u));	  // PTX L5000
	r_PtxU64Register401 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5000)) * int64_t(int32_t(16))); // PTX L5002
	g_OutputByteAddressAtPtx5003 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register401);			   // PTX L5003
	g_OutputByteAddressAtPtx5004 = uint64_t(g_OutputByteAddressAtPtx5003) + uint64_t(512); // PTX L5004
	StoreNoAllocate(g_OutputByteAddressAtPtx5004,
					make_uint4(r_PackedHalf2AtPtx4569R1397, r_PackedHalf2AtPtx4576R1398,
							   r_PackedHalf2AtPtx4583R1399,
							   r_PackedHalf2AtPtx4590R1400)); // PTX L5006
	r_LaneIndexAtPtx5009 = uint32_t((threadIdx.x & 31u));	  // PTX L5009
	r_PtxU64Register403 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5009)) * int64_t(int32_t(16))); // PTX L5011
	g_OutputByteAddressAtPtx5012 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register403);				// PTX L5012
	g_OutputByteAddressAtPtx5013 = uint64_t(g_OutputByteAddressAtPtx5012) + uint64_t(1024); // PTX L5013
	StoreNoAllocate(g_OutputByteAddressAtPtx5013,
					make_uint4(r_PackedHalf2AtPtx4597R1402, r_PackedHalf2AtPtx4604R1403,
							   r_PackedHalf2AtPtx4611R1404,
							   r_PackedHalf2AtPtx4618R1405)); // PTX L5015
	r_LaneIndexAtPtx5018 = uint32_t((threadIdx.x & 31u));	  // PTX L5018
	r_PtxU64Register405 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5018)) * int64_t(int32_t(16))); // PTX L5020
	g_OutputByteAddressAtPtx5021 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register405);				// PTX L5021
	g_OutputByteAddressAtPtx5022 = uint64_t(g_OutputByteAddressAtPtx5021) + uint64_t(1536); // PTX L5022
	StoreNoAllocate(g_OutputByteAddressAtPtx5022,
					make_uint4(r_PackedHalf2AtPtx4625R1407, r_PackedHalf2AtPtx4632R1408,
							   r_PackedHalf2AtPtx4639R1409,
							   r_PackedHalf2AtPtx4646R1410));								 // PTX L5024
L__BB44_308:																				 // PTX L5026
	r_bPtxPredicate132 = int32_t(r_PtxRegister58) >= int32_t(r_PtxRegister4);				 // PTX L5027
	g_OutputByteAddressAtPtx5028 = uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(32768); // PTX L5028
	if (r_bPtxPredicate132)
	{
		goto L__BB44_310;
	} // PTX L5029
	r_LaneIndexAtPtx5031 = uint32_t((threadIdx.x & 31u)); // PTX L5031
	r_PtxU64Register411 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5031)) * int64_t(int32_t(16))); // PTX L5033
	g_OutputByteAddressAtPtx5034 =
		uint64_t(g_OutputByteAddressAtPtx5028) + uint64_t(r_PtxU64Register411); // PTX L5034
	StoreNoAllocate(g_OutputByteAddressAtPtx5034,
					make_uint4(r_PackedHalf2AtPtx4653R1412, r_PackedHalf2AtPtx4660R1413,
							   r_PackedHalf2AtPtx4667R1414,
							   r_PackedHalf2AtPtx4674R1415)); // PTX L5036
	r_LaneIndexAtPtx5039 = uint32_t((threadIdx.x & 31u));	  // PTX L5039
	r_PtxU64Register412 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5039)) * int64_t(int32_t(16))); // PTX L5041
	g_OutputByteAddressAtPtx5042 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register412);				 // PTX L5042
	g_OutputByteAddressAtPtx5043 = uint64_t(g_OutputByteAddressAtPtx5042) + uint64_t(33280); // PTX L5043
	StoreNoAllocate(g_OutputByteAddressAtPtx5043,
					make_uint4(r_PackedHalf2AtPtx4681R1417, r_PackedHalf2AtPtx4688R1418,
							   r_PackedHalf2AtPtx4695R1419,
							   r_PackedHalf2AtPtx4702R1420)); // PTX L5045
	r_LaneIndexAtPtx5048 = uint32_t((threadIdx.x & 31u));	  // PTX L5048
	r_PtxU64Register414 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5048)) * int64_t(int32_t(16))); // PTX L5050
	g_OutputByteAddressAtPtx5051 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register414);				 // PTX L5051
	g_OutputByteAddressAtPtx5052 = uint64_t(g_OutputByteAddressAtPtx5051) + uint64_t(33792); // PTX L5052
	StoreNoAllocate(g_OutputByteAddressAtPtx5052,
					make_uint4(r_PackedHalf2AtPtx4709R1422, r_PackedHalf2AtPtx4716R1423,
							   r_PackedHalf2AtPtx4723R1424,
							   r_PackedHalf2AtPtx4730R1425)); // PTX L5054
	r_LaneIndexAtPtx5057 = uint32_t((threadIdx.x & 31u));	  // PTX L5057
	r_PtxU64Register416 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5057)) * int64_t(int32_t(16))); // PTX L5059
	g_OutputByteAddressAtPtx5060 =
		uint64_t(g_OutputByteAddressAtPtx4989) + uint64_t(r_PtxU64Register416);				 // PTX L5060
	g_OutputByteAddressAtPtx5061 = uint64_t(g_OutputByteAddressAtPtx5060) + uint64_t(34304); // PTX L5061
	StoreNoAllocate(g_OutputByteAddressAtPtx5061,
					make_uint4(r_PackedHalf2AtPtx4737R1427, r_PackedHalf2AtPtx4744R1428,
							   r_PackedHalf2AtPtx4751R1429,
							   r_PackedHalf2AtPtx4758R1430));								 // PTX L5063
L__BB44_310:																				 // PTX L5065
	r_bPtxPredicate133 = int32_t(r_PtxRegister59) >= int32_t(r_PtxRegister4);				 // PTX L5066
	g_OutputByteAddressAtPtx5067 = uint64_t(g_OutputByteAddressAtPtx5028) + uint64_t(32768); // PTX L5067
	if (r_bPtxPredicate133)
	{
		goto L__BB44_312;
	} // PTX L5068
	r_LaneIndexAtPtx5070 = uint32_t((threadIdx.x & 31u)); // PTX L5070
	r_PtxU64Register422 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5070)) * int64_t(int32_t(16))); // PTX L5072
	g_OutputByteAddressAtPtx5073 =
		uint64_t(g_OutputByteAddressAtPtx5067) + uint64_t(r_PtxU64Register422); // PTX L5073
	StoreNoAllocate(g_OutputByteAddressAtPtx5073,
					make_uint4(r_PackedHalf2AtPtx4765R1432, r_PackedHalf2AtPtx4772R1433,
							   r_PackedHalf2AtPtx4779R1434,
							   r_PackedHalf2AtPtx4786R1435)); // PTX L5075
	r_LaneIndexAtPtx5078 = uint32_t((threadIdx.x & 31u));	  // PTX L5078
	r_PtxU64Register423 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5078)) * int64_t(int32_t(16))); // PTX L5080
	g_OutputByteAddressAtPtx5081 =
		uint64_t(g_OutputByteAddressAtPtx5028) + uint64_t(r_PtxU64Register423);				 // PTX L5081
	g_OutputByteAddressAtPtx5082 = uint64_t(g_OutputByteAddressAtPtx5081) + uint64_t(33280); // PTX L5082
	StoreNoAllocate(g_OutputByteAddressAtPtx5082,
					make_uint4(r_PackedHalf2AtPtx4793R1437, r_PackedHalf2AtPtx4800R1438,
							   r_PackedHalf2AtPtx4807R1439,
							   r_PackedHalf2AtPtx4814R1440)); // PTX L5084
	r_LaneIndexAtPtx5087 = uint32_t((threadIdx.x & 31u));	  // PTX L5087
	r_PtxU64Register425 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5087)) * int64_t(int32_t(16))); // PTX L5089
	g_OutputByteAddressAtPtx5090 =
		uint64_t(g_OutputByteAddressAtPtx5028) + uint64_t(r_PtxU64Register425);				 // PTX L5090
	g_OutputByteAddressAtPtx5091 = uint64_t(g_OutputByteAddressAtPtx5090) + uint64_t(33792); // PTX L5091
	StoreNoAllocate(g_OutputByteAddressAtPtx5091,
					make_uint4(r_PackedHalf2AtPtx4821R1442, r_PackedHalf2AtPtx4828R1443,
							   r_PackedHalf2AtPtx4835R1444,
							   r_PackedHalf2AtPtx4842R1445)); // PTX L5093
	r_LaneIndexAtPtx5096 = uint32_t((threadIdx.x & 31u));	  // PTX L5096
	r_PtxU64Register427 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5096)) * int64_t(int32_t(16))); // PTX L5098
	g_OutputByteAddressAtPtx5099 =
		uint64_t(g_OutputByteAddressAtPtx5028) + uint64_t(r_PtxU64Register427);				 // PTX L5099
	g_OutputByteAddressAtPtx5100 = uint64_t(g_OutputByteAddressAtPtx5099) + uint64_t(34304); // PTX L5100
	StoreNoAllocate(g_OutputByteAddressAtPtx5100,
					make_uint4(r_PackedHalf2AtPtx4849R1447, r_PackedHalf2AtPtx4856R1448,
							   r_PackedHalf2AtPtx4863R1449,
							   r_PackedHalf2AtPtx4870R1450));				  // PTX L5102
L__BB44_312:																  // PTX L5104
	r_bPtxPredicate134 = int32_t(r_PtxRegister60) >= int32_t(r_PtxRegister4); // PTX L5105
	if (r_bPtxPredicate134)
	{
		goto L__BB44_314;
	} // PTX L5106
	r_LaneIndexAtPtx5108 = uint32_t((threadIdx.x & 31u)); // PTX L5108
	r_PtxU64Register433 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5108)) * int64_t(int32_t(16))); // PTX L5110
	g_OutputByteAddressAtPtx5111 =
		uint64_t(g_OutputByteAddressAtPtx5067) + uint64_t(r_PtxU64Register433);				 // PTX L5111
	g_OutputByteAddressAtPtx5112 = uint64_t(g_OutputByteAddressAtPtx5111) + uint64_t(32768); // PTX L5112
	StoreNoAllocate(g_OutputByteAddressAtPtx5112,
					make_uint4(r_PackedHalf2AtPtx4877R1452, r_PackedHalf2AtPtx4884R1453,
							   r_PackedHalf2AtPtx4891R1454,
							   r_PackedHalf2AtPtx4898R1455)); // PTX L5114
	r_LaneIndexAtPtx5117 = uint32_t((threadIdx.x & 31u));	  // PTX L5117
	r_PtxU64Register435 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5117)) * int64_t(int32_t(16))); // PTX L5119
	g_OutputByteAddressAtPtx5120 =
		uint64_t(g_OutputByteAddressAtPtx5067) + uint64_t(r_PtxU64Register435);				 // PTX L5120
	g_OutputByteAddressAtPtx5121 = uint64_t(g_OutputByteAddressAtPtx5120) + uint64_t(33280); // PTX L5121
	StoreNoAllocate(g_OutputByteAddressAtPtx5121,
					make_uint4(r_PackedHalf2AtPtx4905R1457, r_PackedHalf2AtPtx4912R1458,
							   r_PackedHalf2AtPtx4919R1459,
							   r_PackedHalf2AtPtx4926R1460)); // PTX L5123
	r_LaneIndexAtPtx5126 = uint32_t((threadIdx.x & 31u));	  // PTX L5126
	r_PtxU64Register437 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5126)) * int64_t(int32_t(16))); // PTX L5128
	g_OutputByteAddressAtPtx5129 =
		uint64_t(g_OutputByteAddressAtPtx5067) + uint64_t(r_PtxU64Register437);				 // PTX L5129
	g_OutputByteAddressAtPtx5130 = uint64_t(g_OutputByteAddressAtPtx5129) + uint64_t(33792); // PTX L5130
	StoreNoAllocate(g_OutputByteAddressAtPtx5130,
					make_uint4(r_PackedHalf2AtPtx4933R1462, r_PackedHalf2AtPtx4940R1463,
							   r_PackedHalf2AtPtx4947R1464,
							   r_PackedHalf2AtPtx4954R1465)); // PTX L5132
	r_LaneIndexAtPtx5135 = uint32_t((threadIdx.x & 31u));	  // PTX L5135
	r_PtxU64Register439 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5135)) * int64_t(int32_t(16))); // PTX L5137
	g_OutputByteAddressAtPtx5138 =
		uint64_t(g_OutputByteAddressAtPtx5067) + uint64_t(r_PtxU64Register439);				 // PTX L5138
	g_OutputByteAddressAtPtx5139 = uint64_t(g_OutputByteAddressAtPtx5138) + uint64_t(34304); // PTX L5139
	StoreNoAllocate(g_OutputByteAddressAtPtx5139,
					make_uint4(r_PackedHalf2AtPtx4961R1467, r_PackedHalf2AtPtx4968R1468,
							   r_PackedHalf2AtPtx4975R1469,
							   r_PackedHalf2AtPtx4982R1470));		 // PTX L5141
L__BB44_314:														 // PTX L5143
	__syncthreads();												 // PTX L5144
	r_ThreadZAtPtx5145 = uint32_t(threadIdx.z);						 // PTX L5145
	r_PtxRegister1530 = r_PtxRegister77 | r_ThreadZAtPtx5145;		 // PTX L5146
	r_bPtxPredicate143 = uint32_t(r_PtxRegister1530) != uint32_t(0); // PTX L5147
	if (r_bPtxPredicate143)
	{
		goto L__BB44_316;
	} // PTX L5148
	// Original partition completion publication after the native CTA barrier.
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(g_CounterByteAddress, r_CtaZ); // PTX L5150
L__BB44_316:										   // PTX L5152
	return;											   // PTX L5153
L__BB44_238:										   // PTX L5154
	r_PtxRegister51 = uint32_t(r_CtaZ) + uint32_t(-1); // PTX L5155
L__BB44_239:										   // PTX L5156
	// Original relaxed counter poll; the native control edge and sleep remain below.
	r_PtxRegister1276 = CounterLoadRelaxed(g_CounterByteAddress);				// PTX L5158
	r_bPtxPredicate98 = int32_t(r_PtxRegister1276) >= int32_t(r_PtxRegister51); // PTX L5160
	if (r_bPtxPredicate98)
	{
		goto L__BB44_257;
	} // PTX L5161
	r_PtxRegister1507 = uint32_t(64); // PTX L5162
	PollSleep(r_PtxRegister1507);	  // PTX L5164
	goto L__BB44_239;				  // PTX L5166
#endif
}
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
