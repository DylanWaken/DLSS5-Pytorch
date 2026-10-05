// Readable CUDA C++ reconstruction of cc_vit_1d_projection_fp8.
// Not historical source; original scalar/control identities are retained for audit.
#pragma once
#include "global_projection_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
__global__ __maxnreg__(168) void global_projection_c1024_fp8(Parameters r_Parameters)
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
		r_bPtxPredicate54, r_bPtxPredicate55, r_bPtxPredicate56;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx148Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx197Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx321Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx353Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx387Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx420Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx454Rs14, r_PtxU16Register15,
		r_ConvertedE4PairAtPtx487Rs16, r_PtxU16Register17, r_ConvertedE4PairAtPtx521Rs18, r_PtxU16Register19,
		r_ConvertedE4PairAtPtx554Rs20, r_PtxU16Register21, r_PtxU16Register22, r_PtxU16Register23,
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
	uint16_t r_PtxU16Register85, r_ConvertedE4PairAtPtx2473Rs86, r_PtxU16Register87,
		r_ConvertedE4PairAtPtx2519Rs88, r_ConvertedE4PairAtPtx3954Rs89, r_ConvertedE4PairAtPtx3957Rs90,
		r_ConvertedE4PairAtPtx3960Rs91, r_ConvertedE4PairAtPtx3963Rs92, r_ConvertedE4PairAtPtx3966Rs93,
		r_ConvertedE4PairAtPtx3969Rs94, r_ConvertedE4PairAtPtx3972Rs95, r_ConvertedE4PairAtPtx3975Rs96;
	uint16_t r_ConvertedE4PairAtPtx3978Rs97, r_ConvertedE4PairAtPtx3981Rs98, r_ConvertedE4PairAtPtx3984Rs99,
		r_ConvertedE4PairAtPtx3987Rs100, r_ConvertedE4PairAtPtx3990Rs101, r_ConvertedE4PairAtPtx3993Rs102,
		r_ConvertedE4PairAtPtx3996Rs103, r_ConvertedE4PairAtPtx3999Rs104, r_ConvertedE4PairAtPtx4002Rs105,
		r_ConvertedE4PairAtPtx4005Rs106, r_ConvertedE4PairAtPtx4008Rs107, r_ConvertedE4PairAtPtx4011Rs108;
	uint16_t r_ConvertedE4PairAtPtx4014Rs109, r_ConvertedE4PairAtPtx4017Rs110,
		r_ConvertedE4PairAtPtx4020Rs111, r_ConvertedE4PairAtPtx4023Rs112, r_ConvertedE4PairAtPtx4026Rs113,
		r_ConvertedE4PairAtPtx4029Rs114, r_ConvertedE4PairAtPtx4032Rs115, r_ConvertedE4PairAtPtx4035Rs116,
		r_ConvertedE4PairAtPtx4038Rs117, r_ConvertedE4PairAtPtx4041Rs118, r_ConvertedE4PairAtPtx4044Rs119,
		r_ConvertedE4PairAtPtx4047Rs120;
	uint16_t r_ConvertedE4PairAtPtx4050Rs121, r_ConvertedE4PairAtPtx4053Rs122,
		r_ConvertedE4PairAtPtx4056Rs123, r_ConvertedE4PairAtPtx4059Rs124, r_ConvertedE4PairAtPtx4062Rs125,
		r_ConvertedE4PairAtPtx4065Rs126, r_ConvertedE4PairAtPtx4068Rs127, r_ConvertedE4PairAtPtx4071Rs128,
		r_ConvertedE4PairAtPtx4074Rs129, r_ConvertedE4PairAtPtx4077Rs130, r_ConvertedE4PairAtPtx4080Rs131,
		r_ConvertedE4PairAtPtx4083Rs132;
	uint16_t r_ConvertedE4PairAtPtx4086Rs133, r_ConvertedE4PairAtPtx4089Rs134,
		r_ConvertedE4PairAtPtx4092Rs135, r_ConvertedE4PairAtPtx4095Rs136, r_ConvertedE4PairAtPtx4098Rs137,
		r_ConvertedE4PairAtPtx4101Rs138, r_ConvertedE4PairAtPtx4104Rs139, r_ConvertedE4PairAtPtx4107Rs140,
		r_ConvertedE4PairAtPtx4110Rs141, r_ConvertedE4PairAtPtx4113Rs142, r_ConvertedE4PairAtPtx4116Rs143,
		r_ConvertedE4PairAtPtx4119Rs144;
	uint16_t r_ConvertedE4PairAtPtx4122Rs145, r_ConvertedE4PairAtPtx4125Rs146,
		r_ConvertedE4PairAtPtx4128Rs147, r_ConvertedE4PairAtPtx4131Rs148, r_ConvertedE4PairAtPtx4134Rs149,
		r_ConvertedE4PairAtPtx4137Rs150, r_ConvertedE4PairAtPtx4140Rs151, r_ConvertedE4PairAtPtx4143Rs152;
	uint32_t r_PtxRegister1, r_PtxRegister2, r_PtxRegister3, r_ThreadY, r_PtxRegister5, r_PtxRegister6,
		r_PtxRegister7, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_BatchBits, r_TokensBits, r_CtaX, r_PtxRegister40, r_PtxRegister41, r_PtxRegister42,
		r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47, r_PtxRegister48;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_ThreadX, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx56R58, r_LaneIndexAtPtx73,
		r_LaneIndexAtPtx81;
	uint32_t r_LaneIndexAtPtx90, r_LaneIndexAtPtx99, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PackedHalf2AtPtx146R72;
	uint32_t r_LaneIndexAtPtx152, r_PtxRegister74, r_PackedE4WordAtPtx150R75, r_PtxRegister76,
		r_PtxRegister77, r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82,
		r_PtxRegister83, r_PackedHalf2AtPtx195R84;
	uint32_t r_LaneIndexAtPtx201, r_PtxRegister86, r_PackedE4WordAtPtx199R87, r_PtxRegister88,
		r_PtxRegister89, r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PackedHalf2AtPtx319R105, r_LaneIndexAtPtx305,
		r_PtxRegister107, r_PackedHalf2AtPtx351R108;
	uint32_t r_LaneIndexAtPtx336, r_PtxRegister110, r_PackedHalf2AtPtx385R111, r_LaneIndexAtPtx370,
		r_PtxRegister113, r_PackedHalf2AtPtx418R114, r_LaneIndexAtPtx403, r_PtxRegister116,
		r_PackedHalf2AtPtx452R117, r_LaneIndexAtPtx437, r_PtxRegister119, r_PackedHalf2AtPtx485R120;
	uint32_t r_LaneIndexAtPtx470, r_PtxRegister122, r_PackedHalf2AtPtx519R123, r_LaneIndexAtPtx504,
		r_PtxRegister125, r_PackedHalf2AtPtx552R126, r_LaneIndexAtPtx537, r_LaneIndexAtPtx760,
		r_LaneIndexAtPtx774, r_LaneIndexAtPtx788, r_LaneIndexAtPtx802, r_LaneIndexAtPtx816;
	uint32_t r_LaneIndexAtPtx831, r_LaneIndexAtPtx845, r_LaneIndexAtPtx862, r_LaneIndexAtPtx878,
		r_LaneIndexAtPtx893, r_LaneIndexAtPtx907, r_LaneIndexAtPtx924, r_LaneIndexAtPtx940,
		r_LaneIndexAtPtx955, r_LaneIndexAtPtx969, r_LaneIndexAtPtx986, r_LaneIndexAtPtx1002;
	uint32_t r_LaneIndexAtPtx1016, r_LaneIndexAtPtx1030, r_LaneIndexAtPtx1044, r_LaneIndexAtPtx1058,
		r_LaneIndexAtPtx1072, r_LaneIndexAtPtx1086, r_LaneIndexAtPtx1102, r_LaneIndexAtPtx1118,
		r_LaneIndexAtPtx1132, r_LaneIndexAtPtx1146, r_LaneIndexAtPtx1162, r_LaneIndexAtPtx1178;
	uint32_t r_LaneIndexAtPtx1192, r_LaneIndexAtPtx1206, r_LaneIndexAtPtx1222, r_LaneIndexAtPtx1238,
		r_LaneIndexAtPtx1252, r_LaneIndexAtPtx1266, r_LaneIndexAtPtx1280, r_LaneIndexAtPtx1294,
		r_LaneIndexAtPtx1308, r_LaneIndexAtPtx1322, r_LaneIndexAtPtx1338, r_LaneIndexAtPtx1354;
	uint32_t r_LaneIndexAtPtx1368, r_LaneIndexAtPtx1382, r_LaneIndexAtPtx1398, r_LaneIndexAtPtx1414,
		r_LaneIndexAtPtx1428, r_LaneIndexAtPtx1442, r_LaneIndexAtPtx1458, r_LaneIndexAtPtx1474,
		r_LaneIndexAtPtx1488, r_LaneIndexAtPtx1502, r_LaneIndexAtPtx1516, r_LaneIndexAtPtx1530;
	uint32_t r_LaneIndexAtPtx1544, r_LaneIndexAtPtx1558, r_LaneIndexAtPtx1574, r_LaneIndexAtPtx1590,
		r_LaneIndexAtPtx1604, r_LaneIndexAtPtx1618, r_LaneIndexAtPtx1634, r_LaneIndexAtPtx1650,
		r_LaneIndexAtPtx1664, r_LaneIndexAtPtx1678, r_LaneIndexAtPtx1694, r_LaneIndexAtPtx1710;
	uint32_t r_PackedHalf2AtPtx562R193, r_PtxRegister194, r_LaneIndexAtPtx1717, r_PackedHalf2AtPtx568R196,
		r_PtxRegister197, r_LaneIndexAtPtx1724, r_PackedHalf2AtPtx565R199, r_PtxRegister200,
		r_LaneIndexAtPtx1731, r_PackedHalf2AtPtx571R202, r_PtxRegister203, r_LaneIndexAtPtx1738;
	uint32_t r_PackedHalf2AtPtx574R205, r_PtxRegister206, r_LaneIndexAtPtx1745, r_PackedHalf2AtPtx580R208,
		r_PtxRegister209, r_LaneIndexAtPtx1752, r_PackedHalf2AtPtx577R211, r_PtxRegister212,
		r_LaneIndexAtPtx1759, r_PackedHalf2AtPtx583R214, r_PtxRegister215, r_LaneIndexAtPtx1766;
	uint32_t r_PackedHalf2AtPtx586R217, r_PtxRegister218, r_LaneIndexAtPtx1773, r_PackedHalf2AtPtx592R220,
		r_PtxRegister221, r_LaneIndexAtPtx1780, r_PackedHalf2AtPtx589R223, r_PtxRegister224,
		r_LaneIndexAtPtx1787, r_PackedHalf2AtPtx595R226, r_PtxRegister227, r_LaneIndexAtPtx1794;
	uint32_t r_PackedHalf2AtPtx598R229, r_PtxRegister230, r_LaneIndexAtPtx1801, r_PackedHalf2AtPtx604R232,
		r_PtxRegister233, r_LaneIndexAtPtx1808, r_PackedHalf2AtPtx601R235, r_PtxRegister236,
		r_LaneIndexAtPtx1815, r_PackedHalf2AtPtx607R238, r_PtxRegister239, r_LaneIndexAtPtx1822;
	uint32_t r_PackedHalf2AtPtx610R241, r_PtxRegister242, r_LaneIndexAtPtx1829, r_PackedHalf2AtPtx616R244,
		r_PtxRegister245, r_LaneIndexAtPtx1836, r_PackedHalf2AtPtx613R247, r_PtxRegister248,
		r_LaneIndexAtPtx1843, r_PackedHalf2AtPtx619R250, r_PtxRegister251, r_LaneIndexAtPtx1850;
	uint32_t r_PackedHalf2AtPtx622R253, r_PtxRegister254, r_LaneIndexAtPtx1857, r_PackedHalf2AtPtx628R256,
		r_PtxRegister257, r_LaneIndexAtPtx1864, r_PackedHalf2AtPtx625R259, r_PtxRegister260,
		r_LaneIndexAtPtx1871, r_PackedHalf2AtPtx631R262, r_PtxRegister263, r_LaneIndexAtPtx1878;
	uint32_t r_PackedHalf2AtPtx634R265, r_PtxRegister266, r_LaneIndexAtPtx1885, r_PackedHalf2AtPtx640R268,
		r_PtxRegister269, r_LaneIndexAtPtx1892, r_PackedHalf2AtPtx637R271, r_PtxRegister272,
		r_LaneIndexAtPtx1899, r_PackedHalf2AtPtx643R274, r_PtxRegister275, r_LaneIndexAtPtx1906;
	uint32_t r_PackedHalf2AtPtx646R277, r_PtxRegister278, r_LaneIndexAtPtx1913, r_PackedHalf2AtPtx652R280,
		r_PtxRegister281, r_LaneIndexAtPtx1920, r_PackedHalf2AtPtx649R283, r_PtxRegister284,
		r_LaneIndexAtPtx1927, r_PackedHalf2AtPtx655R286, r_PtxRegister287, r_LaneIndexAtPtx1934;
	uint32_t r_PackedHalf2AtPtx658R289, r_PtxRegister290, r_LaneIndexAtPtx1941, r_PackedHalf2AtPtx664R292,
		r_PtxRegister293, r_LaneIndexAtPtx1948, r_PackedHalf2AtPtx661R295, r_PtxRegister296,
		r_LaneIndexAtPtx1955, r_PackedHalf2AtPtx667R298, r_PtxRegister299, r_LaneIndexAtPtx1962;
	uint32_t r_PackedHalf2AtPtx670R301, r_PtxRegister302, r_LaneIndexAtPtx1969, r_PackedHalf2AtPtx676R304,
		r_PtxRegister305, r_LaneIndexAtPtx1976, r_PackedHalf2AtPtx673R307, r_PtxRegister308,
		r_LaneIndexAtPtx1983, r_PackedHalf2AtPtx679R310, r_PtxRegister311, r_LaneIndexAtPtx1990;
	uint32_t r_PackedHalf2AtPtx682R313, r_PtxRegister314, r_LaneIndexAtPtx1997, r_PackedHalf2AtPtx688R316,
		r_PtxRegister317, r_LaneIndexAtPtx2004, r_PackedHalf2AtPtx685R319, r_PtxRegister320,
		r_LaneIndexAtPtx2011, r_PackedHalf2AtPtx691R322, r_PtxRegister323, r_LaneIndexAtPtx2018;
	uint32_t r_PackedHalf2AtPtx694R325, r_PtxRegister326, r_LaneIndexAtPtx2025, r_PackedHalf2AtPtx700R328,
		r_PtxRegister329, r_LaneIndexAtPtx2032, r_PackedHalf2AtPtx697R331, r_PtxRegister332,
		r_LaneIndexAtPtx2039, r_PackedHalf2AtPtx703R334, r_PtxRegister335, r_LaneIndexAtPtx2046;
	uint32_t r_PackedHalf2AtPtx706R337, r_PtxRegister338, r_LaneIndexAtPtx2053, r_PackedHalf2AtPtx712R340,
		r_PtxRegister341, r_LaneIndexAtPtx2060, r_PackedHalf2AtPtx709R343, r_PtxRegister344,
		r_LaneIndexAtPtx2067, r_PackedHalf2AtPtx715R346, r_PtxRegister347, r_LaneIndexAtPtx2074;
	uint32_t r_PackedHalf2AtPtx718R349, r_PtxRegister350, r_LaneIndexAtPtx2081, r_PackedHalf2AtPtx724R352,
		r_PtxRegister353, r_LaneIndexAtPtx2088, r_PackedHalf2AtPtx721R355, r_PtxRegister356,
		r_LaneIndexAtPtx2095, r_PackedHalf2AtPtx727R358, r_PtxRegister359, r_LaneIndexAtPtx2102;
	uint32_t r_PackedHalf2AtPtx731R361, r_PtxRegister362, r_LaneIndexAtPtx2109, r_PackedHalf2AtPtx738R364,
		r_PtxRegister365, r_LaneIndexAtPtx2116, r_PackedHalf2AtPtx734R367, r_PtxRegister368,
		r_LaneIndexAtPtx2123, r_PackedHalf2AtPtx741R370, r_PtxRegister371, r_LaneIndexAtPtx2130;
	uint32_t r_PackedHalf2AtPtx745R373, r_PtxRegister374, r_LaneIndexAtPtx2137, r_PackedHalf2AtPtx752R376,
		r_PtxRegister377, r_LaneIndexAtPtx2144, r_PackedHalf2AtPtx748R379, r_PtxRegister380,
		r_LaneIndexAtPtx2151, r_PackedHalf2AtPtx755R382, r_PtxRegister383, r_PtxRegister384;
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
	uint32_t r_PtxRegister949, r_PtxRegister950, r_PtxRegister951, r_PtxRegister952, r_LaneIndexAtPtx2172,
		r_PtxRegister954, r_LaneIndexAtPtx2183, r_PtxRegister956, r_LaneIndexAtPtx2192, r_PtxRegister958,
		r_LaneIndexAtPtx2201, r_PtxRegister960;
	uint32_t r_MmaAE4x4WordAtPtx2180R961, r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963,
		r_MmaAE4x4WordAtPtx2180R964, r_MmaAE4x4WordAtPtx2189R965, r_MmaAE4x4WordAtPtx2189R966,
		r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968, r_MmaAE4x4WordAtPtx2198R969,
		r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972;
	uint32_t r_MmaAE4x4WordAtPtx2207R973, r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975,
		r_MmaAE4x4WordAtPtx2207R976, r_PtxRegister977, r_PtxRegister978, r_PtxRegister979, r_PtxRegister980,
		r_PtxRegister981, r_PtxRegister982, r_PtxRegister983, r_PtxRegister984;
	uint32_t r_PtxRegister985, r_PtxRegister986, r_PtxRegister987, r_PtxRegister988, r_PtxRegister989,
		r_PtxRegister990, r_PtxRegister991, r_PtxRegister992, r_PtxRegister993, r_PtxRegister994,
		r_PtxRegister995, r_PackedHalf2AtPtx2471R996;
	uint32_t r_LaneIndexAtPtx2477, r_PtxRegister998, r_PackedE4WordAtPtx2475R999, r_PtxRegister1000,
		r_PtxRegister1001, r_PtxRegister1002, r_PtxRegister1003, r_PtxRegister1004, r_PtxRegister1005,
		r_PackedHalf2AtPtx2517R1006, r_LaneIndexAtPtx2523, r_PtxRegister1008;
	uint32_t r_PackedE4WordAtPtx2521R1009, r_PtxRegister1010, r_PtxRegister1011, r_PtxRegister1012,
		r_PtxRegister1013, r_PtxRegister1014, r_PtxRegister1015, r_PtxRegister1016, r_LaneIndexAtPtx2537,
		r_LaneIndexAtPtx2545, r_LaneIndexAtPtx2554, r_LaneIndexAtPtx2563;
	uint32_t r_PtxRegister1021, r_PtxRegister1022, r_PtxRegister1023, r_PtxRegister1024, r_LaneIndexAtPtx2590,
		r_PtxRegister1026, r_LaneIndexAtPtx2601, r_PtxRegister1028, r_LaneIndexAtPtx2610, r_PtxRegister1030,
		r_LaneIndexAtPtx2619, r_PtxRegister1032;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2628R1033, r_MmaAccumulatorHalf2WordAtPtx2628R1034,
		r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		r_MmaAE4x4WordAtPtx2598R1038, r_MmaAccumulatorHalf2WordAtPtx2635R1039,
		r_MmaAccumulatorHalf2WordAtPtx2635R1040, r_MmaAccumulatorHalf2WordAtPtx2642R1041,
		r_MmaAccumulatorHalf2WordAtPtx2642R1042, r_MmaAccumulatorHalf2WordAtPtx2649R1043,
		r_MmaAccumulatorHalf2WordAtPtx2649R1044;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2656R1045, r_MmaAccumulatorHalf2WordAtPtx2656R1046,
		r_MmaAccumulatorHalf2WordAtPtx2663R1047, r_MmaAccumulatorHalf2WordAtPtx2663R1048,
		r_MmaAccumulatorHalf2WordAtPtx2670R1049, r_MmaAccumulatorHalf2WordAtPtx2670R1050,
		r_MmaAccumulatorHalf2WordAtPtx2677R1051, r_MmaAccumulatorHalf2WordAtPtx2677R1052,
		r_MmaAccumulatorHalf2WordAtPtx2684R1053, r_MmaAccumulatorHalf2WordAtPtx2684R1054,
		r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056;
	uint32_t r_MmaAE4x4WordAtPtx2607R1057, r_MmaAE4x4WordAtPtx2607R1058,
		r_MmaAccumulatorHalf2WordAtPtx2691R1059, r_MmaAccumulatorHalf2WordAtPtx2691R1060,
		r_MmaAccumulatorHalf2WordAtPtx2698R1061, r_MmaAccumulatorHalf2WordAtPtx2698R1062,
		r_MmaAccumulatorHalf2WordAtPtx2705R1063, r_MmaAccumulatorHalf2WordAtPtx2705R1064,
		r_MmaAccumulatorHalf2WordAtPtx2712R1065, r_MmaAccumulatorHalf2WordAtPtx2712R1066,
		r_MmaAccumulatorHalf2WordAtPtx2719R1067, r_MmaAccumulatorHalf2WordAtPtx2719R1068;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2726R1069, r_MmaAccumulatorHalf2WordAtPtx2726R1070,
		r_MmaAccumulatorHalf2WordAtPtx2733R1071, r_MmaAccumulatorHalf2WordAtPtx2733R1072,
		r_MmaAccumulatorHalf2WordAtPtx2740R1073, r_MmaAccumulatorHalf2WordAtPtx2740R1074,
		r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		r_MmaAE4x4WordAtPtx2616R1078, r_MmaAccumulatorHalf2WordAtPtx2747R1079,
		r_MmaAccumulatorHalf2WordAtPtx2747R1080;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2754R1081, r_MmaAccumulatorHalf2WordAtPtx2754R1082,
		r_MmaAccumulatorHalf2WordAtPtx2761R1083, r_MmaAccumulatorHalf2WordAtPtx2761R1084,
		r_MmaAccumulatorHalf2WordAtPtx2768R1085, r_MmaAccumulatorHalf2WordAtPtx2768R1086,
		r_MmaAccumulatorHalf2WordAtPtx2775R1087, r_MmaAccumulatorHalf2WordAtPtx2775R1088,
		r_MmaAccumulatorHalf2WordAtPtx2782R1089, r_MmaAccumulatorHalf2WordAtPtx2782R1090,
		r_MmaAccumulatorHalf2WordAtPtx2789R1091, r_MmaAccumulatorHalf2WordAtPtx2789R1092;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2796R1093, r_MmaAccumulatorHalf2WordAtPtx2796R1094,
		r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		r_MmaAE4x4WordAtPtx2625R1098, r_MmaAccumulatorHalf2WordAtPtx2803R1099,
		r_MmaAccumulatorHalf2WordAtPtx2803R1100, r_MmaAccumulatorHalf2WordAtPtx2810R1101,
		r_MmaAccumulatorHalf2WordAtPtx2810R1102, r_MmaAccumulatorHalf2WordAtPtx2817R1103,
		r_MmaAccumulatorHalf2WordAtPtx2817R1104;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2824R1105, r_MmaAccumulatorHalf2WordAtPtx2824R1106,
		r_MmaAccumulatorHalf2WordAtPtx2831R1107, r_MmaAccumulatorHalf2WordAtPtx2831R1108,
		r_MmaAccumulatorHalf2WordAtPtx2838R1109, r_MmaAccumulatorHalf2WordAtPtx2838R1110,
		r_MmaAccumulatorHalf2WordAtPtx2845R1111, r_MmaAccumulatorHalf2WordAtPtx2845R1112, r_PtxRegister1113,
		r_PtxRegister1114, r_PtxRegister1115, r_PtxRegister1116;
	uint32_t r_PtxRegister1117, r_PtxRegister1118, r_PtxRegister1119, r_PtxRegister1120, r_PtxRegister1121,
		r_PtxRegister1122, r_PtxRegister1123, r_ThreadZAtPtx2855, r_PtxRegister1125, r_PtxRegister1126,
		r_PtxRegister1127, r_PtxRegister1128;
	uint32_t r_LaneIndexAtPtx3255, r_LaneIndexAtPtx3271, r_LaneIndexAtPtx3287, r_LaneIndexAtPtx3303,
		r_LaneIndexAtPtx3320, r_LaneIndexAtPtx3336, r_LaneIndexAtPtx3352, r_LaneIndexAtPtx3368,
		r_LaneIndexAtPtx3385, r_LaneIndexAtPtx3401, r_LaneIndexAtPtx3417, r_LaneIndexAtPtx3433;
	uint32_t r_LaneIndexAtPtx3450, r_LaneIndexAtPtx3466, r_LaneIndexAtPtx3482, r_LaneIndexAtPtx3495,
		r_LaneIndexAtPtx3506, r_LaneIndexAtPtx3513, r_LaneIndexAtPtx3520, r_LaneIndexAtPtx3527,
		r_LaneIndexAtPtx3534, r_LaneIndexAtPtx3541, r_LaneIndexAtPtx3548, r_LaneIndexAtPtx3555;
	uint32_t r_LaneIndexAtPtx3562, r_LaneIndexAtPtx3569, r_LaneIndexAtPtx3576, r_LaneIndexAtPtx3583,
		r_LaneIndexAtPtx3590, r_LaneIndexAtPtx3597, r_LaneIndexAtPtx3604, r_LaneIndexAtPtx3611,
		r_LaneIndexAtPtx3618, r_LaneIndexAtPtx3625, r_LaneIndexAtPtx3632, r_LaneIndexAtPtx3639;
	uint32_t r_LaneIndexAtPtx3646, r_LaneIndexAtPtx3653, r_LaneIndexAtPtx3660, r_LaneIndexAtPtx3667,
		r_LaneIndexAtPtx3674, r_LaneIndexAtPtx3681, r_LaneIndexAtPtx3688, r_LaneIndexAtPtx3695,
		r_LaneIndexAtPtx3702, r_LaneIndexAtPtx3709, r_LaneIndexAtPtx3716, r_LaneIndexAtPtx3723;
	uint32_t r_LaneIndexAtPtx3730, r_LaneIndexAtPtx3737, r_LaneIndexAtPtx3744, r_LaneIndexAtPtx3751,
		r_LaneIndexAtPtx3758, r_LaneIndexAtPtx3765, r_LaneIndexAtPtx3772, r_LaneIndexAtPtx3779,
		r_LaneIndexAtPtx3786, r_LaneIndexAtPtx3793, r_LaneIndexAtPtx3800, r_LaneIndexAtPtx3807;
	uint32_t r_LaneIndexAtPtx3814, r_LaneIndexAtPtx3821, r_LaneIndexAtPtx3828, r_LaneIndexAtPtx3835,
		r_LaneIndexAtPtx3842, r_LaneIndexAtPtx3849, r_LaneIndexAtPtx3856, r_LaneIndexAtPtx3863,
		r_LaneIndexAtPtx3870, r_LaneIndexAtPtx3877, r_LaneIndexAtPtx3884, r_LaneIndexAtPtx3891;
	uint32_t r_LaneIndexAtPtx3898, r_LaneIndexAtPtx3905, r_LaneIndexAtPtx3912, r_LaneIndexAtPtx3919,
		r_LaneIndexAtPtx3926, r_LaneIndexAtPtx3933, r_LaneIndexAtPtx3940, r_LaneIndexAtPtx3947,
		r_PackedHalf2AtPtx3509R1209, r_PackedHalf2AtPtx3523R1210, r_PackedHalf2AtPtx3516R1211,
		r_PackedHalf2AtPtx3530R1212;
	uint32_t r_PackedHalf2AtPtx3537R1213, r_PackedHalf2AtPtx3551R1214, r_PackedHalf2AtPtx3544R1215,
		r_PackedHalf2AtPtx3558R1216, r_PackedHalf2AtPtx3565R1217, r_PackedHalf2AtPtx3579R1218,
		r_PackedHalf2AtPtx3572R1219, r_PackedHalf2AtPtx3586R1220, r_PackedHalf2AtPtx3593R1221,
		r_PackedHalf2AtPtx3607R1222, r_PackedHalf2AtPtx3600R1223, r_PackedHalf2AtPtx3614R1224;
	uint32_t r_PackedHalf2AtPtx3621R1225, r_PackedHalf2AtPtx3635R1226, r_PackedHalf2AtPtx3628R1227,
		r_PackedHalf2AtPtx3642R1228, r_PackedHalf2AtPtx3649R1229, r_PackedHalf2AtPtx3663R1230,
		r_PackedHalf2AtPtx3656R1231, r_PackedHalf2AtPtx3670R1232, r_PackedHalf2AtPtx3677R1233,
		r_PackedHalf2AtPtx3691R1234, r_PackedHalf2AtPtx3684R1235, r_PackedHalf2AtPtx3698R1236;
	uint32_t r_PackedHalf2AtPtx3705R1237, r_PackedHalf2AtPtx3719R1238, r_PackedHalf2AtPtx3712R1239,
		r_PackedHalf2AtPtx3726R1240, r_PackedHalf2AtPtx3733R1241, r_PackedHalf2AtPtx3747R1242,
		r_PackedHalf2AtPtx3740R1243, r_PackedHalf2AtPtx3754R1244, r_PackedHalf2AtPtx3761R1245,
		r_PackedHalf2AtPtx3775R1246, r_PackedHalf2AtPtx3768R1247, r_PackedHalf2AtPtx3782R1248;
	uint32_t r_PackedHalf2AtPtx3789R1249, r_PackedHalf2AtPtx3803R1250, r_PackedHalf2AtPtx3796R1251,
		r_PackedHalf2AtPtx3810R1252, r_PackedHalf2AtPtx3817R1253, r_PackedHalf2AtPtx3831R1254,
		r_PackedHalf2AtPtx3824R1255, r_PackedHalf2AtPtx3838R1256, r_PackedHalf2AtPtx3845R1257,
		r_PackedHalf2AtPtx3859R1258, r_PackedHalf2AtPtx3852R1259, r_PackedHalf2AtPtx3866R1260;
	uint32_t r_PackedHalf2AtPtx3873R1261, r_PackedHalf2AtPtx3887R1262, r_PackedHalf2AtPtx3880R1263,
		r_PackedHalf2AtPtx3894R1264, r_PackedHalf2AtPtx3901R1265, r_PackedHalf2AtPtx3915R1266,
		r_PackedHalf2AtPtx3908R1267, r_PackedHalf2AtPtx3922R1268, r_PackedHalf2AtPtx3929R1269,
		r_PackedHalf2AtPtx3943R1270, r_PackedHalf2AtPtx3936R1271, r_PackedHalf2AtPtx3950R1272;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_LaneIndexAtPtx4160,
		r_PackedE4WordAtPtx4158R1277, r_PackedE4WordAtPtx4157R1278, r_PackedE4WordAtPtx4156R1279,
		r_PackedE4WordAtPtx4155R1280, r_LaneIndexAtPtx4168, r_PackedE4WordAtPtx4154R1282,
		r_PackedE4WordAtPtx4153R1283, r_PackedE4WordAtPtx4152R1284;
	uint32_t r_PackedE4WordAtPtx4151R1285, r_LaneIndexAtPtx4181, r_PackedE4WordAtPtx4188R1287,
		r_PackedE4WordAtPtx4187R1288, r_PackedE4WordAtPtx4186R1289, r_PackedE4WordAtPtx4185R1290,
		r_LaneIndexAtPtx4193, r_PackedE4WordAtPtx4201R1292, r_PackedE4WordAtPtx4200R1293,
		r_PackedE4WordAtPtx4199R1294, r_PackedE4WordAtPtx4198R1295, r_LaneIndexAtPtx4210;
	uint32_t r_PackedE4WordAtPtx4217R1297, r_PackedE4WordAtPtx4216R1298, r_PackedE4WordAtPtx4215R1299,
		r_PackedE4WordAtPtx4214R1300, r_LaneIndexAtPtx4222, r_PackedE4WordAtPtx4230R1302,
		r_PackedE4WordAtPtx4229R1303, r_PackedE4WordAtPtx4228R1304, r_PackedE4WordAtPtx4227R1305,
		r_LaneIndexAtPtx4238, r_PackedE4WordAtPtx4246R1307, r_PackedE4WordAtPtx4245R1308;
	uint32_t r_PackedE4WordAtPtx4244R1309, r_PackedE4WordAtPtx4243R1310, r_LaneIndexAtPtx4251,
		r_PackedE4WordAtPtx4259R1312, r_PackedE4WordAtPtx4258R1313, r_PackedE4WordAtPtx4257R1314,
		r_PackedE4WordAtPtx4256R1315, r_LaneIndexAtPtx2873, r_LaneIndexAtPtx2885, r_LaneIndexAtPtx2897,
		r_LaneIndexAtPtx2909, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_LaneIndexAtPtx2926,
		r_LaneIndexAtPtx2938, r_LaneIndexAtPtx2950, r_LaneIndexAtPtx2962, r_PtxRegister1329,
		r_PtxRegister1330, r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_LaneIndexAtPtx2979, r_LaneIndexAtPtx2991, r_LaneIndexAtPtx3003,
		r_LaneIndexAtPtx3015, r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341,
		r_PtxRegister1342, r_LaneIndexAtPtx3032, r_LaneIndexAtPtx3044;
	uint32_t r_LaneIndexAtPtx3056, r_LaneIndexAtPtx3068, r_PtxRegister1347, r_PtxRegister1348,
		r_PtxRegister1349, r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353,
		r_PtxRegister1354, r_LaneIndexAtPtx3087, r_LaneIndexAtPtx3095;
	uint32_t r_LaneIndexAtPtx3104, r_LaneIndexAtPtx3113, r_PtxRegister1359, r_LaneIndexAtPtx3127,
		r_LaneIndexAtPtx3135, r_LaneIndexAtPtx3144, r_LaneIndexAtPtx3153, r_PtxRegister1364,
		r_LaneIndexAtPtx3167, r_LaneIndexAtPtx3175, r_LaneIndexAtPtx3184, r_LaneIndexAtPtx3193;
	uint32_t r_PtxRegister1369, r_LaneIndexAtPtx3206, r_LaneIndexAtPtx3215, r_LaneIndexAtPtx3224,
		r_LaneIndexAtPtx3233, r_ThreadZAtPtx4265, r_PtxRegister1375, r_CtaZ, r_PtxRegister1377,
		r_PtxRegister1378, r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_PtxRegister1399, r_PtxRegister1400, r_PtxRegister1401, r_PtxRegister1402,
		r_PtxRegister1403, r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408,
		r_PackedHalf2AtPtx227R1409, r_PackedHalf2AtPtx228R1410, r_PackedHalf2AtPtx229R1411,
		r_PackedHalf2AtPtx230R1412, r_PackedHalf2AtPtx231R1413, r_PackedHalf2AtPtx232R1414,
		r_PackedHalf2AtPtx233R1415, r_PackedHalf2AtPtx234R1416;
	uint32_t r_PackedHalf2AtPtx235R1417, r_PackedHalf2AtPtx236R1418, r_PackedHalf2AtPtx237R1419,
		r_PackedHalf2AtPtx238R1420, r_PackedHalf2AtPtx239R1421, r_PackedHalf2AtPtx240R1422,
		r_PackedHalf2AtPtx241R1423, r_PackedHalf2AtPtx242R1424, r_PackedHalf2AtPtx243R1425,
		r_PackedHalf2AtPtx244R1426, r_PackedHalf2AtPtx245R1427, r_PackedHalf2AtPtx246R1428;
	uint32_t r_PackedHalf2AtPtx247R1429, r_PackedHalf2AtPtx248R1430, r_PackedHalf2AtPtx249R1431,
		r_PackedHalf2AtPtx250R1432, r_PackedHalf2AtPtx251R1433, r_PackedHalf2AtPtx252R1434,
		r_PackedHalf2AtPtx253R1435, r_PackedHalf2AtPtx254R1436, r_PackedHalf2AtPtx255R1437,
		r_PackedHalf2AtPtx256R1438, r_PackedHalf2AtPtx257R1439, r_PackedHalf2AtPtx258R1440;
	uint32_t r_PackedHalf2AtPtx259R1441, r_PackedHalf2AtPtx260R1442, r_PackedHalf2AtPtx261R1443,
		r_PackedHalf2AtPtx262R1444, r_PackedHalf2AtPtx263R1445, r_PackedHalf2AtPtx264R1446,
		r_PackedHalf2AtPtx265R1447, r_PackedHalf2AtPtx266R1448, r_PackedHalf2AtPtx267R1449,
		r_PackedHalf2AtPtx268R1450, r_PackedHalf2AtPtx269R1451, r_PackedHalf2AtPtx270R1452;
	uint32_t r_PackedHalf2AtPtx271R1453, r_PackedHalf2AtPtx272R1454, r_PackedHalf2AtPtx273R1455,
		r_PackedHalf2AtPtx274R1456, r_PackedHalf2AtPtx275R1457, r_PackedHalf2AtPtx276R1458,
		r_PackedHalf2AtPtx277R1459, r_PackedHalf2AtPtx278R1460, r_PackedHalf2AtPtx279R1461,
		r_PackedHalf2AtPtx280R1462, r_PackedHalf2AtPtx281R1463, r_PackedHalf2AtPtx282R1464;
	uint32_t r_PackedHalf2AtPtx283R1465, r_PackedHalf2AtPtx284R1466, r_PackedHalf2AtPtx285R1467,
		r_PackedHalf2AtPtx286R1468, r_PackedHalf2AtPtx287R1469, r_PackedHalf2AtPtx288R1470,
		r_PackedHalf2AtPtx289R1471, r_PackedHalf2AtPtx290R1472, r_PtxRegister1473, r_MmaBE4x4WordAtPtx78R1474,
		r_MmaBE4x4WordAtPtx78R1475, r_MmaBE4x4WordAtPtx78R1476;
	uint32_t r_MmaBE4x4WordAtPtx78R1477, r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479,
		r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481, r_MmaBE4x4WordAtPtx96R1482,
		r_MmaBE4x4WordAtPtx96R1483, r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485,
		r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487, r_MmaBE4x4WordAtPtx105R1488;
	uint32_t r_MmaBE4x4WordAtPtx105R1489, r_PackedHalf2AtPtx3249R1490, r_PackedHalf2AtPtx3250R1491,
		r_PackedHalf2AtPtx3251R1492, r_PackedHalf2AtPtx3252R1493, r_PackedHalf2AtPtx3265R1494,
		r_PackedHalf2AtPtx3266R1495, r_PackedHalf2AtPtx3267R1496, r_PackedHalf2AtPtx3268R1497,
		r_PackedHalf2AtPtx3281R1498, r_PackedHalf2AtPtx3282R1499, r_PackedHalf2AtPtx3283R1500;
	uint32_t r_PackedHalf2AtPtx3284R1501, r_PackedHalf2AtPtx3297R1502, r_PackedHalf2AtPtx3298R1503,
		r_PackedHalf2AtPtx3299R1504, r_PackedHalf2AtPtx3300R1505, r_PackedHalf2AtPtx3314R1506,
		r_PackedHalf2AtPtx3315R1507, r_PackedHalf2AtPtx3316R1508, r_PackedHalf2AtPtx3317R1509,
		r_PackedHalf2AtPtx3330R1510, r_PackedHalf2AtPtx3331R1511, r_PackedHalf2AtPtx3332R1512;
	uint32_t r_PackedHalf2AtPtx3333R1513, r_PackedHalf2AtPtx3346R1514, r_PackedHalf2AtPtx3347R1515,
		r_PackedHalf2AtPtx3348R1516, r_PackedHalf2AtPtx3349R1517, r_PackedHalf2AtPtx3362R1518,
		r_PackedHalf2AtPtx3363R1519, r_PackedHalf2AtPtx3364R1520, r_PackedHalf2AtPtx3365R1521,
		r_PackedHalf2AtPtx3379R1522, r_PackedHalf2AtPtx3380R1523, r_PackedHalf2AtPtx3381R1524;
	uint32_t r_PackedHalf2AtPtx3382R1525, r_PackedHalf2AtPtx3395R1526, r_PackedHalf2AtPtx3396R1527,
		r_PackedHalf2AtPtx3397R1528, r_PackedHalf2AtPtx3398R1529, r_PackedHalf2AtPtx3411R1530,
		r_PackedHalf2AtPtx3412R1531, r_PackedHalf2AtPtx3413R1532, r_PackedHalf2AtPtx3414R1533,
		r_PackedHalf2AtPtx3427R1534, r_PackedHalf2AtPtx3428R1535, r_PackedHalf2AtPtx3429R1536;
	uint32_t r_PackedHalf2AtPtx3430R1537, r_PackedHalf2AtPtx3444R1538, r_PackedHalf2AtPtx3445R1539,
		r_PackedHalf2AtPtx3446R1540, r_PackedHalf2AtPtx3447R1541, r_PackedHalf2AtPtx3460R1542,
		r_PackedHalf2AtPtx3461R1543, r_PackedHalf2AtPtx3462R1544, r_PackedHalf2AtPtx3463R1545,
		r_PackedHalf2AtPtx3476R1546, r_PackedHalf2AtPtx3477R1547, r_PackedHalf2AtPtx3478R1548;
	uint32_t r_PackedHalf2AtPtx3479R1549, r_PackedHalf2AtPtx3501R1550, r_PackedHalf2AtPtx3490R1551,
		r_PackedHalf2AtPtx3491R1552, r_PackedHalf2AtPtx3492R1553;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, g_RecordBaseAddress, g_ScratchBaseAddress,
		g_ResidualByteAddressAtPtx300, g_StateByteAddressAtPtx2160, g_ScratchByteAddressAtPtx3084,
		g_ScratchByteAddressAtPtx3124, g_ScratchByteAddressAtPtx3164, g_ScratchByteAddressAtPtx3248,
		g_ScratchByteAddressAtPtx3264, g_ScratchByteAddressAtPtx3280;
	uint64_t g_ScratchByteAddressAtPtx3296, g_ScratchByteAddressAtPtx3313, g_ScratchByteAddressAtPtx3329,
		g_ScratchByteAddressAtPtx3345, g_ScratchByteAddressAtPtx3361, g_ScratchByteAddressAtPtx3378,
		g_ScratchByteAddressAtPtx3394, g_ScratchByteAddressAtPtx3410, g_ScratchByteAddressAtPtx3426,
		g_ScratchByteAddressAtPtx3443, g_ScratchByteAddressAtPtx3459, g_ScratchByteAddressAtPtx3475;
	uint64_t g_OutputByteAddressAtPtx4149, g_OutputByteAddressAtPtx4178, g_OutputByteAddressAtPtx4207,
		g_OutputBaseAddress, g_CounterBaseAddress, g_RecordByteAddressAtPtx76, g_RecordByteAddressAtPtx85,
		g_RecordByteAddressAtPtx94, g_RecordByteAddressAtPtx103, r_PtxU64Register34,
		g_RecordByteAddressAtPtx71, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, g_RecordByteAddressAtPtx84, r_PtxU64Register39, g_RecordByteAddressAtPtx93,
		r_PtxU64Register41, g_RecordByteAddressAtPtx102, g_StateByteAddressAtPtx130,
		g_StateByteAddressAtPtx128, r_PtxU64Register45, g_StateByteAddressAtPtx179,
		g_StateByteAddressAtPtx177, r_PtxU64Register48;
	uint64_t r_PtxU64Register49, r_PtxU64Register50, g_ResidualByteAddressAtPtx308, r_PtxU64Register52,
		g_ResidualByteAddressAtPtx340, r_PtxU64Register54, g_ResidualByteAddressAtPtx339,
		g_ResidualByteAddressAtPtx374, r_PtxU64Register57, g_ResidualByteAddressAtPtx373,
		g_ResidualByteAddressAtPtx407, r_PtxU64Register60;
	uint64_t g_ResidualByteAddressAtPtx406, g_ResidualByteAddressAtPtx441, r_PtxU64Register63,
		g_ResidualByteAddressAtPtx440, g_ResidualByteAddressAtPtx474, r_PtxU64Register66,
		g_ResidualByteAddressAtPtx473, g_ResidualByteAddressAtPtx508, r_PtxU64Register69,
		g_ResidualByteAddressAtPtx507, g_ResidualByteAddressAtPtx541, r_PtxU64Register72;
	uint64_t g_ResidualByteAddressAtPtx540, g_RecordByteAddressAtPtx757, r_PtxU64Register75,
		g_RecordByteAddressAtPtx771, r_PtxU64Register77, g_RecordByteAddressAtPtx785, r_PtxU64Register79,
		g_RecordByteAddressAtPtx799, r_PtxU64Register81, g_RecordByteAddressAtPtx813, r_PtxU64Register83,
		g_RecordByteAddressAtPtx828;
	uint64_t r_PtxU64Register85, g_RecordByteAddressAtPtx842, r_PtxU64Register87, g_RecordByteAddressAtPtx859,
		r_PtxU64Register89, g_RecordByteAddressAtPtx875, r_PtxU64Register91, g_RecordByteAddressAtPtx890,
		r_PtxU64Register93, g_RecordByteAddressAtPtx904, r_PtxU64Register95, g_RecordByteAddressAtPtx921;
	uint64_t r_PtxU64Register97, g_RecordByteAddressAtPtx937, r_PtxU64Register99, g_RecordByteAddressAtPtx952,
		r_PtxU64Register101, g_RecordByteAddressAtPtx966, r_PtxU64Register103, g_RecordByteAddressAtPtx983,
		r_PtxU64Register105, g_RecordByteAddressAtPtx999, r_PtxU64Register107, g_RecordByteAddressAtPtx1013;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx1027, r_PtxU64Register111,
		g_RecordByteAddressAtPtx1041, r_PtxU64Register113, g_RecordByteAddressAtPtx1055, r_PtxU64Register115,
		g_RecordByteAddressAtPtx1069, r_PtxU64Register117, g_RecordByteAddressAtPtx1083, r_PtxU64Register119,
		g_RecordByteAddressAtPtx1099;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx1115, r_PtxU64Register123,
		g_RecordByteAddressAtPtx1129, r_PtxU64Register125, g_RecordByteAddressAtPtx1143, r_PtxU64Register127,
		g_RecordByteAddressAtPtx1159, r_PtxU64Register129, g_RecordByteAddressAtPtx1175, r_PtxU64Register131,
		g_RecordByteAddressAtPtx1189;
	uint64_t r_PtxU64Register133, g_RecordByteAddressAtPtx1203, r_PtxU64Register135,
		g_RecordByteAddressAtPtx1219, r_PtxU64Register137, g_RecordByteAddressAtPtx1235, r_PtxU64Register139,
		g_RecordByteAddressAtPtx1249, r_PtxU64Register141, g_RecordByteAddressAtPtx1263, r_PtxU64Register143,
		g_RecordByteAddressAtPtx1277;
	uint64_t r_PtxU64Register145, g_RecordByteAddressAtPtx1291, r_PtxU64Register147,
		g_RecordByteAddressAtPtx1305, r_PtxU64Register149, g_RecordByteAddressAtPtx1319, r_PtxU64Register151,
		g_RecordByteAddressAtPtx1335, r_PtxU64Register153, g_RecordByteAddressAtPtx1351, r_PtxU64Register155,
		g_RecordByteAddressAtPtx1365;
	uint64_t r_PtxU64Register157, g_RecordByteAddressAtPtx1379, r_PtxU64Register159,
		g_RecordByteAddressAtPtx1395, r_PtxU64Register161, g_RecordByteAddressAtPtx1411, r_PtxU64Register163,
		g_RecordByteAddressAtPtx1425, r_PtxU64Register165, g_RecordByteAddressAtPtx1439, r_PtxU64Register167,
		g_RecordByteAddressAtPtx1455;
	uint64_t r_PtxU64Register169, g_RecordByteAddressAtPtx1471, r_PtxU64Register171,
		g_RecordByteAddressAtPtx1485, r_PtxU64Register173, g_RecordByteAddressAtPtx1499, r_PtxU64Register175,
		g_RecordByteAddressAtPtx1513, r_PtxU64Register177, g_RecordByteAddressAtPtx1527, r_PtxU64Register179,
		g_RecordByteAddressAtPtx1541;
	uint64_t r_PtxU64Register181, g_RecordByteAddressAtPtx1555, r_PtxU64Register183,
		g_RecordByteAddressAtPtx1571, r_PtxU64Register185, g_RecordByteAddressAtPtx1587, r_PtxU64Register187,
		g_RecordByteAddressAtPtx1601, r_PtxU64Register189, g_RecordByteAddressAtPtx1615, r_PtxU64Register191,
		g_RecordByteAddressAtPtx1631;
	uint64_t r_PtxU64Register193, g_RecordByteAddressAtPtx1647, r_PtxU64Register195,
		g_RecordByteAddressAtPtx1661, r_PtxU64Register197, g_RecordByteAddressAtPtx1675, r_PtxU64Register199,
		g_RecordByteAddressAtPtx1691, r_PtxU64Register201, g_RecordByteAddressAtPtx1707,
		g_StateByteAddressAtPtx2456, r_PtxU64Register204;
	uint64_t g_StateByteAddressAtPtx2502, r_PtxU64Register206, g_RecordByteAddressAtPtx2540,
		g_RecordByteAddressAtPtx2549, g_RecordByteAddressAtPtx2558, g_RecordByteAddressAtPtx2567,
		r_PtxU64Register211, g_RecordByteAddressAtPtx2535, r_PtxU64Register213, r_PtxU64Register214,
		g_RecordByteAddressAtPtx2548, r_PtxU64Register216;
	uint64_t g_RecordByteAddressAtPtx2557, r_PtxU64Register218, g_RecordByteAddressAtPtx2566,
		r_PtxU64Register220, r_PtxU64Register221, r_PtxU64Register222, g_ScratchByteAddressAtPtx3258,
		r_PtxU64Register224, g_ScratchByteAddressAtPtx3274, r_PtxU64Register226,
		g_ScratchByteAddressAtPtx3290, r_PtxU64Register228;
	uint64_t g_ScratchByteAddressAtPtx3306, r_PtxU64Register230, g_ScratchByteAddressAtPtx3323,
		r_PtxU64Register232, g_ScratchByteAddressAtPtx3339, r_PtxU64Register234,
		g_ScratchByteAddressAtPtx3355, r_PtxU64Register236, g_ScratchByteAddressAtPtx3371,
		r_PtxU64Register238, g_ScratchByteAddressAtPtx3388, r_PtxU64Register240;
	uint64_t g_ScratchByteAddressAtPtx3404, r_PtxU64Register242, g_ScratchByteAddressAtPtx3420,
		r_PtxU64Register244, g_ScratchByteAddressAtPtx3436, r_PtxU64Register246,
		g_ScratchByteAddressAtPtx3453, r_PtxU64Register248, g_ScratchByteAddressAtPtx3469,
		r_PtxU64Register250, g_ScratchByteAddressAtPtx3485, r_PtxU64Register252;
	uint64_t g_ScratchByteAddressAtPtx3499, r_PtxU64Register254, g_ScratchByteAddressAtPtx3498,
		r_PtxU64Register256, g_OutputByteAddressAtPtx4163, g_OutputByteAddressAtPtx4172, r_PtxU64Register259,
		r_PtxU64Register260, g_OutputByteAddressAtPtx4171, g_OutputByteAddressAtPtx4184,
		g_OutputByteAddressAtPtx4197, r_PtxU64Register264;
	uint64_t r_PtxU64Register265, g_OutputByteAddressAtPtx4196, g_OutputByteAddressAtPtx4213,
		g_OutputByteAddressAtPtx4226, r_PtxU64Register269, r_PtxU64Register270, g_OutputByteAddressAtPtx4225,
		g_OutputByteAddressAtPtx4242, g_OutputByteAddressAtPtx4255, r_PtxU64Register274,
		g_OutputByteAddressAtPtx4241, r_PtxU64Register276;
	uint64_t g_OutputByteAddressAtPtx4254, r_PtxU64Register278, r_PtxU64Register279, r_PtxU64Register280,
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
		r_PtxU64Register357, r_PtxU64Register358, g_ScratchByteAddressAtPtx3090,
		g_ScratchByteAddressAtPtx3099;
	uint64_t g_ScratchByteAddressAtPtx3108, g_ScratchByteAddressAtPtx3117, r_PtxU64Register363,
		r_PtxU64Register364, g_ScratchByteAddressAtPtx3098, r_PtxU64Register366,
		g_ScratchByteAddressAtPtx3107, r_PtxU64Register368, g_ScratchByteAddressAtPtx3116,
		g_ScratchByteAddressAtPtx3130, g_ScratchByteAddressAtPtx3139, g_ScratchByteAddressAtPtx3148;
	uint64_t g_ScratchByteAddressAtPtx3157, r_PtxU64Register374, r_PtxU64Register375,
		g_ScratchByteAddressAtPtx3138, r_PtxU64Register377, g_ScratchByteAddressAtPtx3147,
		r_PtxU64Register379, g_ScratchByteAddressAtPtx3156, g_ScratchByteAddressAtPtx3170,
		g_ScratchByteAddressAtPtx3179, g_ScratchByteAddressAtPtx3188, g_ScratchByteAddressAtPtx3197;
	uint64_t r_PtxU64Register385, r_PtxU64Register386, g_ScratchByteAddressAtPtx3178, r_PtxU64Register388,
		g_ScratchByteAddressAtPtx3187, r_PtxU64Register390, g_ScratchByteAddressAtPtx3196,
		g_ScratchByteAddressAtPtx3210, g_ScratchByteAddressAtPtx3219, g_ScratchByteAddressAtPtx3228,
		g_ScratchByteAddressAtPtx3237, r_PtxU64Register396;
	uint64_t g_ScratchByteAddressAtPtx3209, r_PtxU64Register398, g_ScratchByteAddressAtPtx3218,
		r_PtxU64Register400, g_ScratchByteAddressAtPtx3227, r_PtxU64Register402,
		g_ScratchByteAddressAtPtx3236, g_CounterByteAddress;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_ScratchBaseAddress = uint64_t(r_Parameters.g_Scratch); // PTX L14
	g_CounterBaseAddress = uint64_t(r_Parameters.g_Counter); // PTX L15
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);	 // PTX L16
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);	 // PTX L17
	g_ResidualBaseAddress = uint64_t(r_Parameters.g_Skip);	 // PTX L18
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);	 // PTX L19
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);									 // PTX L20
	r_CtaX = uint32_t(blockIdx.x);													 // PTX L21
	r_CtaZ = uint32_t(blockIdx.z);													 // PTX L22
	r_PtxRegister40 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits) + uint32_t(-1); // PTX L23
	r_PtxRegister41 = ShiftRightSigned(int32_t(r_PtxRegister40), uint32_t(31));		 // PTX L24
	r_PtxRegister42 = ShiftRight(uint32_t(r_PtxRegister41), uint32_t(25));			 // PTX L25
	r_PtxRegister43 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister42);		 // PTX L26
	r_PtxRegister44 = ShiftRightSigned(int32_t(r_PtxRegister43), uint32_t(7));		 // PTX L27
	r_PtxRegister45 = uint32_t(r_PtxRegister44) + uint32_t(1);						 // PTX L28
	r_PtxRegister1 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister45));			 // PTX L29
	r_PtxRegister46 =
		uint32_t(r_PtxRegister1) * uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister1); // PTX L30
	r_PtxRegister47 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister46);						 // PTX L31
	r_PtxRegister2 = ShiftLeft(uint32_t(r_PtxRegister47), uint32_t(3));					 // PTX L32
	r_PtxRegister48 = ShiftRight(uint32_t(r_PtxRegister41), uint32_t(27));				 // PTX L33
	r_PtxRegister49 = uint32_t(r_PtxRegister40) + uint32_t(r_PtxRegister48);			 // PTX L34
	r_PtxRegister50 = r_PtxRegister49 & -32;											 // PTX L35
	r_PtxRegister51 = uint32_t(r_PtxRegister50) + uint32_t(32);							 // PTX L36
	r_PtxRegister3 = ShiftRightSigned(int32_t(r_PtxRegister51), uint32_t(4));			 // PTX L37
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L38
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L39
	r_PtxRegister5 = r_ThreadX | r_ThreadY;												 // PTX L40
	r_bPtxPredicate1 = uint32_t(r_PtxRegister5) != uint32_t(0);							 // PTX L41
	if (r_bPtxPredicate1)
	{
		goto L__BB59_2;
	} // PTX L42
	r_BlockSizeX = uint32_t(blockDim.x);								// PTX L43
	r_BlockSizeY = uint32_t(blockDim.y);								// PTX L44
	r_PtxRegister54 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);	// PTX L45
	r_PtxRegister53 = uint32_t(8192u /* original named shared base */); // PTX L46
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister53, r_PtxRegister54); // PTX L48
	r_PtxRegister55 = uint32_t(r_PtxRegister53) + uint32_t(8);		// PTX L50
	BarrierInit(s_SharedStorage, r_PtxRegister55, r_PtxRegister54); // PTX L52
L__BB59_2:															// PTX L54
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L55
	r_Float32BitsAtPtx56R58 = uint32_t(0);														// PTX L56
	r_PackedHalf2AtPtx3501R1550 = FloatToHalf2(r_Float32BitsAtPtx56R58);						// PTX L58
	r_PtxRegister63 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L63
	r_PtxRegister64 = r_PtxRegister63 & 64;														// PTX L64
	r_PtxRegister65 = ShiftLeft(uint32_t(r_PtxRegister1), uint32_t(7));							// PTX L65
	r_PtxRegister6 = r_PtxRegister64 | r_PtxRegister65;											// PTX L66
	r_PtxRegister66 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(16));								// PTX L67
	r_PtxRegister7 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(3));							// PTX L68
	r_PtxRegister67 = uint32_t(r_PtxRegister66) + uint32_t(r_PtxRegister7);						// PTX L69
	r_PtxU64Register34 = uint64_t(int64_t(int32_t(r_PtxRegister67)) * int64_t(int32_t(4)));		// PTX L70
	g_RecordByteAddressAtPtx71 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register34);	// PTX L71
	r_LaneIndexAtPtx73 = uint32_t((threadIdx.x & 31u));											// PTX L73
	r_PtxU64Register36 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx73)) * int64_t(int32_t(16))); // PTX L75
	g_RecordByteAddressAtPtx76 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register36); // PTX L76
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx76));
		r_MmaBE4x4WordAtPtx78R1474 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R1475 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R1476 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R1477 = r_Value.w;
	} // PTX L78
	r_LaneIndexAtPtx81 = uint32_t((threadIdx.x & 31u));											// PTX L81
	r_PtxU64Register37 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx81)) * int64_t(int32_t(16))); // PTX L83
	g_RecordByteAddressAtPtx84 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register37);		   // PTX L84
	g_RecordByteAddressAtPtx85 = uint64_t(g_RecordByteAddressAtPtx84) + uint64_t(512); // PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx85));
		r_MmaBE4x4WordAtPtx87R1478 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R1479 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R1480 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R1481 = r_Value.w;
	} // PTX L87
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register39 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register39);			// PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(1024); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBE4x4WordAtPtx96R1482 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1483 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1484 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1485 = r_Value.w;
	} // PTX L96
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	g_RecordByteAddressAtPtx102 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register41);			  // PTX L102
	g_RecordByteAddressAtPtx103 = uint64_t(g_RecordByteAddressAtPtx102) + uint64_t(1536); // PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx103));
		r_MmaBE4x4WordAtPtx105R1486 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1487 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1488 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1489 = r_Value.w;
	} // PTX L105
	r_PtxRegister8 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister2);		 // PTX L107
	r_bPtxPredicate2 = int32_t(r_PtxRegister8) >= int32_t(r_PtxRegister3);	 // PTX L108
	r_bPtxPredicate3 = int32_t(r_PtxRegister8) < int32_t(r_PtxRegister3);	 // PTX L109
	r_PtxRegister68 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(10));			 // PTX L110
	r_PtxRegister9 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(12));		 // PTX L111
	r_PtxRegister10 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister68);	 // PTX L112
	r_PtxRegister11 = r_bPtxPredicate3 ? r_PtxRegister10 : 0;				 // PTX L113
	r_PtxRegister69 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));			 // PTX L114
	r_PtxRegister70 = uint32_t(0u /* original named shared base */);		 // PTX L115
	r_PtxRegister79 = uint32_t(r_PtxRegister70) + uint32_t(r_PtxRegister69); // PTX L116
	if (r_bPtxPredicate2)
	{
		goto L__BB59_5;
	} // PTX L117
	r_PtxRegister78 = uint32_t(-1);								 // PTX L118
	r_PtxRegister77 = Elected(r_PtxRegister78);					 // PTX L120
	r_bPtxPredicate4 = uint32_t(r_PtxRegister77) == uint32_t(0); // PTX L126
	if (r_bPtxPredicate4)
	{
		goto L__BB59_6;
	} // PTX L127
	g_StateByteAddressAtPtx128 = g_StateBaseAddress;										// PTX L128
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister11)) * int64_t(int32_t(4))); // PTX L129
	g_StateByteAddressAtPtx130 =
		uint64_t(g_StateByteAddressAtPtx128) + uint64_t(r_PtxU64Register45); // PTX L130
	r_PtxRegister81 = uint32_t(8192u /* original named shared base */);		 // PTX L131
	r_PtxRegister80 = uint32_t(512);										 // PTX L132
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister79, g_StateByteAddressAtPtx130, r_PtxRegister80,
			 r_PtxRegister81);																 // PTX L134
	BarrierExpect(s_SharedStorage, r_PtxRegister81, r_PtxRegister80);						 // PTX L137
	goto L__BB59_6;																			 // PTX L139
L__BB59_5:																					 // PTX L140
	r_PtxRegister71 = uint32_t(0);															 // PTX L141
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister71))); // PTX L143
	r_PackedHalf2AtPtx146R72 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L146
	r_ConvertedE4PairAtPtx148Rs2 = PublishE4(r_PackedHalf2AtPtx146R72);						 // PTX L148
	r_PackedE4WordAtPtx150R75 =
		JoinHalfwords(r_ConvertedE4PairAtPtx148Rs2, r_ConvertedE4PairAtPtx148Rs2); // PTX L150
	r_LaneIndexAtPtx152 = uint32_t((threadIdx.x & 31u));						   // PTX L152
	r_PtxRegister76 = ShiftLeft(uint32_t(r_LaneIndexAtPtx152), uint32_t(4));	   // PTX L154
	r_PtxRegister74 = uint32_t(r_PtxRegister79) + uint32_t(r_PtxRegister76);	   // PTX L155
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister74)) =
		make_uint4(r_PackedE4WordAtPtx150R75, r_PackedE4WordAtPtx150R75, r_PackedE4WordAtPtx150R75,
				   r_PackedE4WordAtPtx150R75);								// PTX L157
L__BB59_6:																	// PTX L159
	r_PtxRegister12 = uint32_t(r_PtxRegister8) + uint32_t(4);				// PTX L160
	r_bPtxPredicate5 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L161
	r_bPtxPredicate6 = int32_t(r_PtxRegister12) < int32_t(r_PtxRegister3);	// PTX L162
	r_PtxRegister82 = uint32_t(r_PtxRegister10) + uint32_t(16384);			// PTX L163
	r_PtxRegister13 = r_bPtxPredicate6 ? r_PtxRegister82 : 0;				// PTX L164
	if (r_bPtxPredicate5)
	{
		goto L__BB59_9;
	} // PTX L165
	r_PtxRegister91 = uint32_t(-1);								 // PTX L166
	r_PtxRegister90 = Elected(r_PtxRegister91);					 // PTX L168
	r_bPtxPredicate7 = uint32_t(r_PtxRegister90) == uint32_t(0); // PTX L174
	if (r_bPtxPredicate7)
	{
		goto L__BB59_10;
	} // PTX L175
	r_PtxRegister92 = uint32_t(r_PtxRegister79) + uint32_t(2048);							// PTX L176
	g_StateByteAddressAtPtx177 = g_StateBaseAddress;										// PTX L177
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister13)) * int64_t(int32_t(4))); // PTX L178
	g_StateByteAddressAtPtx179 =
		uint64_t(g_StateByteAddressAtPtx177) + uint64_t(r_PtxU64Register48); // PTX L179
	r_PtxRegister94 = uint32_t(8192u /* original named shared base */);		 // PTX L180
	r_PtxRegister93 = uint32_t(512);										 // PTX L181
	CopyBulk(s_SharedStorage, r_PtxRegister92, g_StateByteAddressAtPtx179, r_PtxRegister93,
			 r_PtxRegister94);																 // PTX L183
	BarrierExpect(s_SharedStorage, r_PtxRegister94, r_PtxRegister93);						 // PTX L186
	goto L__BB59_10;																		 // PTX L188
L__BB59_9:																					 // PTX L189
	r_PtxRegister83 = uint32_t(0);															 // PTX L190
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister83))); // PTX L192
	r_PackedHalf2AtPtx195R84 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);			 // PTX L195
	r_ConvertedE4PairAtPtx197Rs4 = PublishE4(r_PackedHalf2AtPtx195R84);						 // PTX L197
	r_PackedE4WordAtPtx199R87 =
		JoinHalfwords(r_ConvertedE4PairAtPtx197Rs4, r_ConvertedE4PairAtPtx197Rs4); // PTX L199
	r_LaneIndexAtPtx201 = uint32_t((threadIdx.x & 31u));						   // PTX L201
	r_PtxRegister88 = ShiftLeft(uint32_t(r_LaneIndexAtPtx201), uint32_t(4));	   // PTX L203
	r_PtxRegister89 = uint32_t(r_PtxRegister79) + uint32_t(r_PtxRegister88);	   // PTX L204
	r_PtxRegister86 = uint32_t(r_PtxRegister89) + uint32_t(2048);				   // PTX L205
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister86)) =
		make_uint4(r_PackedE4WordAtPtx199R87, r_PackedE4WordAtPtx199R87, r_PackedE4WordAtPtx199R87,
				   r_PackedE4WordAtPtx199R87);							// PTX L207
L__BB59_10:																// PTX L209
	r_PtxRegister95 = uint32_t(8192u /* original named shared base */); // PTX L210
	r_PtxRegister96 = uint32_t(1);										// PTX L211
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register49 = BarrierArrive(s_SharedStorage, r_PtxRegister95, r_PtxRegister96); // PTX L213
L__BB59_11:																				   // PTX L215
	r_PtxRegister98 = uint32_t(8192u /* original named shared base */);					   // PTX L216
	r_PtxRegister97 = BarrierReady(s_SharedStorage, r_PtxRegister98, r_PtxU64Register49);  // PTX L218
	r_bPtxPredicate8 = uint32_t(r_PtxRegister97) == uint32_t(0);						   // PTX L224
	if (r_bPtxPredicate8)
	{
		goto L__BB59_11;
	} // PTX L225
	r_bPtxPredicate9 = uint32_t(r_CtaZ) != uint32_t(0);					// PTX L226
	r_PackedHalf2AtPtx227R1409 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L227
	r_PackedHalf2AtPtx228R1410 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L228
	r_PackedHalf2AtPtx229R1411 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L229
	r_PackedHalf2AtPtx230R1412 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L230
	r_PackedHalf2AtPtx231R1413 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L231
	r_PackedHalf2AtPtx232R1414 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L232
	r_PackedHalf2AtPtx233R1415 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L233
	r_PackedHalf2AtPtx234R1416 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L234
	r_PackedHalf2AtPtx235R1417 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L235
	r_PackedHalf2AtPtx236R1418 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L236
	r_PackedHalf2AtPtx237R1419 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L237
	r_PackedHalf2AtPtx238R1420 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L238
	r_PackedHalf2AtPtx239R1421 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L239
	r_PackedHalf2AtPtx240R1422 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L240
	r_PackedHalf2AtPtx241R1423 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L241
	r_PackedHalf2AtPtx242R1424 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L242
	r_PackedHalf2AtPtx243R1425 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L243
	r_PackedHalf2AtPtx244R1426 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L244
	r_PackedHalf2AtPtx245R1427 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L245
	r_PackedHalf2AtPtx246R1428 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L246
	r_PackedHalf2AtPtx247R1429 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L247
	r_PackedHalf2AtPtx248R1430 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L248
	r_PackedHalf2AtPtx249R1431 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L249
	r_PackedHalf2AtPtx250R1432 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L250
	r_PackedHalf2AtPtx251R1433 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L251
	r_PackedHalf2AtPtx252R1434 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L252
	r_PackedHalf2AtPtx253R1435 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L253
	r_PackedHalf2AtPtx254R1436 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L254
	r_PackedHalf2AtPtx255R1437 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L255
	r_PackedHalf2AtPtx256R1438 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L256
	r_PackedHalf2AtPtx257R1439 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L257
	r_PackedHalf2AtPtx258R1440 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L258
	r_PackedHalf2AtPtx259R1441 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L259
	r_PackedHalf2AtPtx260R1442 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L260
	r_PackedHalf2AtPtx261R1443 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L261
	r_PackedHalf2AtPtx262R1444 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L262
	r_PackedHalf2AtPtx263R1445 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L263
	r_PackedHalf2AtPtx264R1446 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L264
	r_PackedHalf2AtPtx265R1447 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L265
	r_PackedHalf2AtPtx266R1448 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L266
	r_PackedHalf2AtPtx267R1449 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L267
	r_PackedHalf2AtPtx268R1450 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L268
	r_PackedHalf2AtPtx269R1451 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L269
	r_PackedHalf2AtPtx270R1452 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L270
	r_PackedHalf2AtPtx271R1453 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L271
	r_PackedHalf2AtPtx272R1454 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L272
	r_PackedHalf2AtPtx273R1455 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L273
	r_PackedHalf2AtPtx274R1456 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L274
	r_PackedHalf2AtPtx275R1457 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L275
	r_PackedHalf2AtPtx276R1458 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L276
	r_PackedHalf2AtPtx277R1459 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L277
	r_PackedHalf2AtPtx278R1460 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L278
	r_PackedHalf2AtPtx279R1461 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L279
	r_PackedHalf2AtPtx280R1462 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L280
	r_PackedHalf2AtPtx281R1463 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L281
	r_PackedHalf2AtPtx282R1464 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L282
	r_PackedHalf2AtPtx283R1465 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L283
	r_PackedHalf2AtPtx284R1466 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L284
	r_PackedHalf2AtPtx285R1467 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L285
	r_PackedHalf2AtPtx286R1468 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L286
	r_PackedHalf2AtPtx287R1469 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L287
	r_PackedHalf2AtPtx288R1470 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L288
	r_PackedHalf2AtPtx289R1471 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L289
	r_PackedHalf2AtPtx290R1472 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L290
	if (r_bPtxPredicate9)
	{
		goto L__BB59_38;
	} // PTX L291
	r_PtxRegister99 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));							 // PTX L292
	r_PtxRegister100 = r_PtxRegister99 & 2044;												 // PTX L293
	r_PtxRegister14 = uint32_t(r_PtxRegister100) + uint32_t(r_PtxRegister2);				 // PTX L294
	r_bPtxPredicate10 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister3);					 // PTX L295
	r_PtxRegister101 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(2));					 // PTX L296
	r_PtxRegister102 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(12));					 // PTX L297
	r_PtxRegister103 = uint32_t(r_PtxRegister102) + uint32_t(r_PtxRegister101);				 // PTX L298
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister103)) * int64_t(int32_t(4))); // PTX L299
	g_ResidualByteAddressAtPtx300 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register50); // PTX L300
	if (r_bPtxPredicate10)
	{
		goto L__BB59_15;
	} // PTX L301
	goto L__BB59_14;																			 // PTX L302
L__BB59_15:																						 // PTX L303
	r_LaneIndexAtPtx305 = uint32_t((threadIdx.x & 31u));										 // PTX L305
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx305)) * int64_t(int32_t(16))); // PTX L307
	g_ResidualByteAddressAtPtx308 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register52); // PTX L308
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx308));
		r_PtxRegister1377 = r_Value.x;
		r_PtxRegister1378 = r_Value.y;
		r_PtxRegister1379 = r_Value.z;
		r_PtxRegister1380 = r_Value.w;
	} // PTX L310
	goto L__BB59_16;																			   // PTX L312
L__BB59_14:																						   // PTX L313
	r_PtxRegister104 = uint32_t(0);																   // PTX L314
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister104)));	   // PTX L316
	r_PackedHalf2AtPtx319R105 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);			   // PTX L319
	r_ConvertedE4PairAtPtx321Rs6 = PublishE4(r_PackedHalf2AtPtx319R105);						   // PTX L321
	r_PtxRegister1377 = JoinHalfwords(r_ConvertedE4PairAtPtx321Rs6, r_ConvertedE4PairAtPtx321Rs6); // PTX L323
	r_PtxRegister1378 = uint32_t(r_PtxRegister1377);											   // PTX L324
	r_PtxRegister1379 = uint32_t(r_PtxRegister1377);											   // PTX L325
	r_PtxRegister1380 = uint32_t(r_PtxRegister1377);											   // PTX L326
L__BB59_16:																						   // PTX L327
	r_PtxU16Register27 = uint16_t(r_PtxRegister1380);
	r_PtxU16Register28 = uint16_t(r_PtxRegister1380 >> 16); // PTX L328
	r_PtxU16Register25 = uint16_t(r_PtxRegister1379);
	r_PtxU16Register26 = uint16_t(r_PtxRegister1379 >> 16); // PTX L329
	r_PtxU16Register23 = uint16_t(r_PtxRegister1378);
	r_PtxU16Register24 = uint16_t(r_PtxRegister1378 >> 16); // PTX L330
	r_PtxU16Register21 = uint16_t(r_PtxRegister1377);
	r_PtxU16Register22 = uint16_t(r_PtxRegister1377 >> 16); // PTX L331
	if (r_bPtxPredicate10)
	{
		goto L__BB59_18;
	} // PTX L332
	goto L__BB59_17;																			 // PTX L333
L__BB59_18:																						 // PTX L334
	r_LaneIndexAtPtx336 = uint32_t((threadIdx.x & 31u));										 // PTX L336
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx336)) * int64_t(int32_t(16))); // PTX L338
	g_ResidualByteAddressAtPtx339 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register54);				 // PTX L339
	g_ResidualByteAddressAtPtx340 = uint64_t(g_ResidualByteAddressAtPtx339) + uint64_t(512); // PTX L340
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx340));
		r_PtxRegister1381 = r_Value.x;
		r_PtxRegister1382 = r_Value.y;
		r_PtxRegister1383 = r_Value.z;
		r_PtxRegister1384 = r_Value.w;
	} // PTX L342
	goto L__BB59_19;																			   // PTX L344
L__BB59_17:																						   // PTX L345
	r_PtxRegister107 = uint32_t(0);																   // PTX L346
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister107)));	   // PTX L348
	r_PackedHalf2AtPtx351R108 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);			   // PTX L351
	r_ConvertedE4PairAtPtx353Rs8 = PublishE4(r_PackedHalf2AtPtx351R108);						   // PTX L353
	r_PtxRegister1381 = JoinHalfwords(r_ConvertedE4PairAtPtx353Rs8, r_ConvertedE4PairAtPtx353Rs8); // PTX L355
	r_PtxRegister1382 = uint32_t(r_PtxRegister1381);											   // PTX L356
	r_PtxRegister1383 = uint32_t(r_PtxRegister1381);											   // PTX L357
	r_PtxRegister1384 = uint32_t(r_PtxRegister1381);											   // PTX L358
L__BB59_19:																						   // PTX L359
	r_PtxRegister15 = uint32_t(r_PtxRegister14) + uint32_t(1);									   // PTX L360
	r_PtxU16Register35 = uint16_t(r_PtxRegister1384);
	r_PtxU16Register36 = uint16_t(r_PtxRegister1384 >> 16); // PTX L361
	r_PtxU16Register33 = uint16_t(r_PtxRegister1383);
	r_PtxU16Register34 = uint16_t(r_PtxRegister1383 >> 16); // PTX L362
	r_PtxU16Register31 = uint16_t(r_PtxRegister1382);
	r_PtxU16Register32 = uint16_t(r_PtxRegister1382 >> 16); // PTX L363
	r_PtxU16Register29 = uint16_t(r_PtxRegister1381);
	r_PtxU16Register30 = uint16_t(r_PtxRegister1381 >> 16);					// PTX L364
	r_bPtxPredicate11 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister3); // PTX L365
	if (r_bPtxPredicate11)
	{
		goto L__BB59_21;
	} // PTX L366
	goto L__BB59_20;																			 // PTX L367
L__BB59_21:																						 // PTX L368
	r_LaneIndexAtPtx370 = uint32_t((threadIdx.x & 31u));										 // PTX L370
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx370)) * int64_t(int32_t(16))); // PTX L372
	g_ResidualByteAddressAtPtx373 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register57);				   // PTX L373
	g_ResidualByteAddressAtPtx374 = uint64_t(g_ResidualByteAddressAtPtx373) + uint64_t(16384); // PTX L374
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx374));
		r_PtxRegister1385 = r_Value.x;
		r_PtxRegister1386 = r_Value.y;
		r_PtxRegister1387 = r_Value.z;
		r_PtxRegister1388 = r_Value.w;
	} // PTX L376
	goto L__BB59_22;																		  // PTX L378
L__BB59_20:																					  // PTX L379
	r_PtxRegister110 = uint32_t(0);															  // PTX L380
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister110))); // PTX L382
	r_PackedHalf2AtPtx385R111 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L385
	r_ConvertedE4PairAtPtx387Rs10 = PublishE4(r_PackedHalf2AtPtx385R111);					  // PTX L387
	r_PtxRegister1385 =
		JoinHalfwords(r_ConvertedE4PairAtPtx387Rs10, r_ConvertedE4PairAtPtx387Rs10); // PTX L389
	r_PtxRegister1386 = uint32_t(r_PtxRegister1385);								 // PTX L390
	r_PtxRegister1387 = uint32_t(r_PtxRegister1385);								 // PTX L391
	r_PtxRegister1388 = uint32_t(r_PtxRegister1385);								 // PTX L392
L__BB59_22:																			 // PTX L393
	r_bPtxPredicate12 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister3);			 // PTX L394
	r_PtxU16Register43 = uint16_t(r_PtxRegister1388);
	r_PtxU16Register44 = uint16_t(r_PtxRegister1388 >> 16); // PTX L395
	r_PtxU16Register41 = uint16_t(r_PtxRegister1387);
	r_PtxU16Register42 = uint16_t(r_PtxRegister1387 >> 16); // PTX L396
	r_PtxU16Register39 = uint16_t(r_PtxRegister1386);
	r_PtxU16Register40 = uint16_t(r_PtxRegister1386 >> 16); // PTX L397
	r_PtxU16Register37 = uint16_t(r_PtxRegister1385);
	r_PtxU16Register38 = uint16_t(r_PtxRegister1385 >> 16); // PTX L398
	if (r_bPtxPredicate12)
	{
		goto L__BB59_24;
	} // PTX L399
	goto L__BB59_23;																			 // PTX L400
L__BB59_24:																						 // PTX L401
	r_LaneIndexAtPtx403 = uint32_t((threadIdx.x & 31u));										 // PTX L403
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx403)) * int64_t(int32_t(16))); // PTX L405
	g_ResidualByteAddressAtPtx406 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register60);				   // PTX L406
	g_ResidualByteAddressAtPtx407 = uint64_t(g_ResidualByteAddressAtPtx406) + uint64_t(16896); // PTX L407
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx407));
		r_PtxRegister1389 = r_Value.x;
		r_PtxRegister1390 = r_Value.y;
		r_PtxRegister1391 = r_Value.z;
		r_PtxRegister1392 = r_Value.w;
	} // PTX L409
	goto L__BB59_25;																		   // PTX L411
L__BB59_23:																					   // PTX L412
	r_PtxRegister113 = uint32_t(0);															   // PTX L413
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister113))); // PTX L415
	r_PackedHalf2AtPtx418R114 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L418
	r_ConvertedE4PairAtPtx420Rs12 = PublishE4(r_PackedHalf2AtPtx418R114);					   // PTX L420
	r_PtxRegister1389 =
		JoinHalfwords(r_ConvertedE4PairAtPtx420Rs12, r_ConvertedE4PairAtPtx420Rs12); // PTX L422
	r_PtxRegister1390 = uint32_t(r_PtxRegister1389);								 // PTX L423
	r_PtxRegister1391 = uint32_t(r_PtxRegister1389);								 // PTX L424
	r_PtxRegister1392 = uint32_t(r_PtxRegister1389);								 // PTX L425
L__BB59_25:																			 // PTX L426
	r_PtxRegister16 = uint32_t(r_PtxRegister14) + uint32_t(2);						 // PTX L427
	r_PtxU16Register51 = uint16_t(r_PtxRegister1392);
	r_PtxU16Register52 = uint16_t(r_PtxRegister1392 >> 16); // PTX L428
	r_PtxU16Register49 = uint16_t(r_PtxRegister1391);
	r_PtxU16Register50 = uint16_t(r_PtxRegister1391 >> 16); // PTX L429
	r_PtxU16Register47 = uint16_t(r_PtxRegister1390);
	r_PtxU16Register48 = uint16_t(r_PtxRegister1390 >> 16); // PTX L430
	r_PtxU16Register45 = uint16_t(r_PtxRegister1389);
	r_PtxU16Register46 = uint16_t(r_PtxRegister1389 >> 16);					// PTX L431
	r_bPtxPredicate13 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister3); // PTX L432
	if (r_bPtxPredicate13)
	{
		goto L__BB59_27;
	} // PTX L433
	goto L__BB59_26;																			 // PTX L434
L__BB59_27:																						 // PTX L435
	r_LaneIndexAtPtx437 = uint32_t((threadIdx.x & 31u));										 // PTX L437
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx437)) * int64_t(int32_t(16))); // PTX L439
	g_ResidualByteAddressAtPtx440 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register63);				   // PTX L440
	g_ResidualByteAddressAtPtx441 = uint64_t(g_ResidualByteAddressAtPtx440) + uint64_t(32768); // PTX L441
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx441));
		r_PtxRegister1393 = r_Value.x;
		r_PtxRegister1394 = r_Value.y;
		r_PtxRegister1395 = r_Value.z;
		r_PtxRegister1396 = r_Value.w;
	} // PTX L443
	goto L__BB59_28;																		   // PTX L445
L__BB59_26:																					   // PTX L446
	r_PtxRegister116 = uint32_t(0);															   // PTX L447
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister116))); // PTX L449
	r_PackedHalf2AtPtx452R117 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L452
	r_ConvertedE4PairAtPtx454Rs14 = PublishE4(r_PackedHalf2AtPtx452R117);					   // PTX L454
	r_PtxRegister1393 =
		JoinHalfwords(r_ConvertedE4PairAtPtx454Rs14, r_ConvertedE4PairAtPtx454Rs14); // PTX L456
	r_PtxRegister1394 = uint32_t(r_PtxRegister1393);								 // PTX L457
	r_PtxRegister1395 = uint32_t(r_PtxRegister1393);								 // PTX L458
	r_PtxRegister1396 = uint32_t(r_PtxRegister1393);								 // PTX L459
L__BB59_28:																			 // PTX L460
	r_bPtxPredicate14 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister3);			 // PTX L461
	r_PtxU16Register59 = uint16_t(r_PtxRegister1396);
	r_PtxU16Register60 = uint16_t(r_PtxRegister1396 >> 16); // PTX L462
	r_PtxU16Register57 = uint16_t(r_PtxRegister1395);
	r_PtxU16Register58 = uint16_t(r_PtxRegister1395 >> 16); // PTX L463
	r_PtxU16Register55 = uint16_t(r_PtxRegister1394);
	r_PtxU16Register56 = uint16_t(r_PtxRegister1394 >> 16); // PTX L464
	r_PtxU16Register53 = uint16_t(r_PtxRegister1393);
	r_PtxU16Register54 = uint16_t(r_PtxRegister1393 >> 16); // PTX L465
	if (r_bPtxPredicate14)
	{
		goto L__BB59_30;
	} // PTX L466
	goto L__BB59_29;																			 // PTX L467
L__BB59_30:																						 // PTX L468
	r_LaneIndexAtPtx470 = uint32_t((threadIdx.x & 31u));										 // PTX L470
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx470)) * int64_t(int32_t(16))); // PTX L472
	g_ResidualByteAddressAtPtx473 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register66);				   // PTX L473
	g_ResidualByteAddressAtPtx474 = uint64_t(g_ResidualByteAddressAtPtx473) + uint64_t(33280); // PTX L474
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx474));
		r_PtxRegister1397 = r_Value.x;
		r_PtxRegister1398 = r_Value.y;
		r_PtxRegister1399 = r_Value.z;
		r_PtxRegister1400 = r_Value.w;
	} // PTX L476
	goto L__BB59_31;																		   // PTX L478
L__BB59_29:																					   // PTX L479
	r_PtxRegister119 = uint32_t(0);															   // PTX L480
	r_PtxU16Register15 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister119))); // PTX L482
	r_PackedHalf2AtPtx485R120 = JoinHalfwords(r_PtxU16Register15, r_PtxU16Register15);		   // PTX L485
	r_ConvertedE4PairAtPtx487Rs16 = PublishE4(r_PackedHalf2AtPtx485R120);					   // PTX L487
	r_PtxRegister1397 =
		JoinHalfwords(r_ConvertedE4PairAtPtx487Rs16, r_ConvertedE4PairAtPtx487Rs16); // PTX L489
	r_PtxRegister1398 = uint32_t(r_PtxRegister1397);								 // PTX L490
	r_PtxRegister1399 = uint32_t(r_PtxRegister1397);								 // PTX L491
	r_PtxRegister1400 = uint32_t(r_PtxRegister1397);								 // PTX L492
L__BB59_31:																			 // PTX L493
	r_PtxRegister17 = uint32_t(r_PtxRegister14) + uint32_t(3);						 // PTX L494
	r_PtxU16Register67 = uint16_t(r_PtxRegister1400);
	r_PtxU16Register68 = uint16_t(r_PtxRegister1400 >> 16); // PTX L495
	r_PtxU16Register65 = uint16_t(r_PtxRegister1399);
	r_PtxU16Register66 = uint16_t(r_PtxRegister1399 >> 16); // PTX L496
	r_PtxU16Register63 = uint16_t(r_PtxRegister1398);
	r_PtxU16Register64 = uint16_t(r_PtxRegister1398 >> 16); // PTX L497
	r_PtxU16Register61 = uint16_t(r_PtxRegister1397);
	r_PtxU16Register62 = uint16_t(r_PtxRegister1397 >> 16);					// PTX L498
	r_bPtxPredicate15 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister3); // PTX L499
	if (r_bPtxPredicate15)
	{
		goto L__BB59_33;
	} // PTX L500
	goto L__BB59_32;																			 // PTX L501
L__BB59_33:																						 // PTX L502
	r_LaneIndexAtPtx504 = uint32_t((threadIdx.x & 31u));										 // PTX L504
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx504)) * int64_t(int32_t(16))); // PTX L506
	g_ResidualByteAddressAtPtx507 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register69);				   // PTX L507
	g_ResidualByteAddressAtPtx508 = uint64_t(g_ResidualByteAddressAtPtx507) + uint64_t(49152); // PTX L508
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx508));
		r_PtxRegister1401 = r_Value.x;
		r_PtxRegister1402 = r_Value.y;
		r_PtxRegister1403 = r_Value.z;
		r_PtxRegister1404 = r_Value.w;
	} // PTX L510
	goto L__BB59_34;																		   // PTX L512
L__BB59_32:																					   // PTX L513
	r_PtxRegister122 = uint32_t(0);															   // PTX L514
	r_PtxU16Register17 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister122))); // PTX L516
	r_PackedHalf2AtPtx519R123 = JoinHalfwords(r_PtxU16Register17, r_PtxU16Register17);		   // PTX L519
	r_ConvertedE4PairAtPtx521Rs18 = PublishE4(r_PackedHalf2AtPtx519R123);					   // PTX L521
	r_PtxRegister1401 =
		JoinHalfwords(r_ConvertedE4PairAtPtx521Rs18, r_ConvertedE4PairAtPtx521Rs18); // PTX L523
	r_PtxRegister1402 = uint32_t(r_PtxRegister1401);								 // PTX L524
	r_PtxRegister1403 = uint32_t(r_PtxRegister1401);								 // PTX L525
	r_PtxRegister1404 = uint32_t(r_PtxRegister1401);								 // PTX L526
L__BB59_34:																			 // PTX L527
	r_bPtxPredicate16 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister3);			 // PTX L528
	r_PtxU16Register75 = uint16_t(r_PtxRegister1404);
	r_PtxU16Register76 = uint16_t(r_PtxRegister1404 >> 16); // PTX L529
	r_PtxU16Register73 = uint16_t(r_PtxRegister1403);
	r_PtxU16Register74 = uint16_t(r_PtxRegister1403 >> 16); // PTX L530
	r_PtxU16Register71 = uint16_t(r_PtxRegister1402);
	r_PtxU16Register72 = uint16_t(r_PtxRegister1402 >> 16); // PTX L531
	r_PtxU16Register69 = uint16_t(r_PtxRegister1401);
	r_PtxU16Register70 = uint16_t(r_PtxRegister1401 >> 16); // PTX L532
	if (r_bPtxPredicate16)
	{
		goto L__BB59_36;
	} // PTX L533
	goto L__BB59_35;																			 // PTX L534
L__BB59_36:																						 // PTX L535
	r_LaneIndexAtPtx537 = uint32_t((threadIdx.x & 31u));										 // PTX L537
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx537)) * int64_t(int32_t(16))); // PTX L539
	g_ResidualByteAddressAtPtx540 =
		uint64_t(g_ResidualByteAddressAtPtx300) + uint64_t(r_PtxU64Register72);				   // PTX L540
	g_ResidualByteAddressAtPtx541 = uint64_t(g_ResidualByteAddressAtPtx540) + uint64_t(49664); // PTX L541
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx541));
		r_PtxRegister1405 = r_Value.x;
		r_PtxRegister1406 = r_Value.y;
		r_PtxRegister1407 = r_Value.z;
		r_PtxRegister1408 = r_Value.w;
	} // PTX L543
	goto L__BB59_37;																		   // PTX L545
L__BB59_35:																					   // PTX L546
	r_PtxRegister125 = uint32_t(0);															   // PTX L547
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister125))); // PTX L549
	r_PackedHalf2AtPtx552R126 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L552
	r_ConvertedE4PairAtPtx554Rs20 = PublishE4(r_PackedHalf2AtPtx552R126);					   // PTX L554
	r_PtxRegister1405 =
		JoinHalfwords(r_ConvertedE4PairAtPtx554Rs20, r_ConvertedE4PairAtPtx554Rs20); // PTX L556
	r_PtxRegister1406 = uint32_t(r_PtxRegister1405);								 // PTX L557
	r_PtxRegister1407 = uint32_t(r_PtxRegister1405);								 // PTX L558
	r_PtxRegister1408 = uint32_t(r_PtxRegister1405);								 // PTX L559
L__BB59_37:																			 // PTX L560
	r_PackedHalf2AtPtx562R193 = DecodeE4(r_PtxU16Register21);						 // PTX L562
	r_PackedHalf2AtPtx565R199 = DecodeE4(r_PtxU16Register22);						 // PTX L565
	r_PackedHalf2AtPtx568R196 = DecodeE4(r_PtxU16Register23);						 // PTX L568
	r_PackedHalf2AtPtx571R202 = DecodeE4(r_PtxU16Register24);						 // PTX L571
	r_PackedHalf2AtPtx574R205 = DecodeE4(r_PtxU16Register25);						 // PTX L574
	r_PackedHalf2AtPtx577R211 = DecodeE4(r_PtxU16Register26);						 // PTX L577
	r_PackedHalf2AtPtx580R208 = DecodeE4(r_PtxU16Register27);						 // PTX L580
	r_PackedHalf2AtPtx583R214 = DecodeE4(r_PtxU16Register28);						 // PTX L583
	r_PackedHalf2AtPtx586R217 = DecodeE4(r_PtxU16Register29);						 // PTX L586
	r_PackedHalf2AtPtx589R223 = DecodeE4(r_PtxU16Register30);						 // PTX L589
	r_PackedHalf2AtPtx592R220 = DecodeE4(r_PtxU16Register31);						 // PTX L592
	r_PackedHalf2AtPtx595R226 = DecodeE4(r_PtxU16Register32);						 // PTX L595
	r_PackedHalf2AtPtx598R229 = DecodeE4(r_PtxU16Register33);						 // PTX L598
	r_PackedHalf2AtPtx601R235 = DecodeE4(r_PtxU16Register34);						 // PTX L601
	r_PackedHalf2AtPtx604R232 = DecodeE4(r_PtxU16Register35);						 // PTX L604
	r_PackedHalf2AtPtx607R238 = DecodeE4(r_PtxU16Register36);						 // PTX L607
	r_PackedHalf2AtPtx610R241 = DecodeE4(r_PtxU16Register37);						 // PTX L610
	r_PackedHalf2AtPtx613R247 = DecodeE4(r_PtxU16Register38);						 // PTX L613
	r_PackedHalf2AtPtx616R244 = DecodeE4(r_PtxU16Register39);						 // PTX L616
	r_PackedHalf2AtPtx619R250 = DecodeE4(r_PtxU16Register40);						 // PTX L619
	r_PackedHalf2AtPtx622R253 = DecodeE4(r_PtxU16Register41);						 // PTX L622
	r_PackedHalf2AtPtx625R259 = DecodeE4(r_PtxU16Register42);						 // PTX L625
	r_PackedHalf2AtPtx628R256 = DecodeE4(r_PtxU16Register43);						 // PTX L628
	r_PackedHalf2AtPtx631R262 = DecodeE4(r_PtxU16Register44);						 // PTX L631
	r_PackedHalf2AtPtx634R265 = DecodeE4(r_PtxU16Register45);						 // PTX L634
	r_PackedHalf2AtPtx637R271 = DecodeE4(r_PtxU16Register46);						 // PTX L637
	r_PackedHalf2AtPtx640R268 = DecodeE4(r_PtxU16Register47);						 // PTX L640
	r_PackedHalf2AtPtx643R274 = DecodeE4(r_PtxU16Register48);						 // PTX L643
	r_PackedHalf2AtPtx646R277 = DecodeE4(r_PtxU16Register49);						 // PTX L646
	r_PackedHalf2AtPtx649R283 = DecodeE4(r_PtxU16Register50);						 // PTX L649
	r_PackedHalf2AtPtx652R280 = DecodeE4(r_PtxU16Register51);						 // PTX L652
	r_PackedHalf2AtPtx655R286 = DecodeE4(r_PtxU16Register52);						 // PTX L655
	r_PackedHalf2AtPtx658R289 = DecodeE4(r_PtxU16Register53);						 // PTX L658
	r_PackedHalf2AtPtx661R295 = DecodeE4(r_PtxU16Register54);						 // PTX L661
	r_PackedHalf2AtPtx664R292 = DecodeE4(r_PtxU16Register55);						 // PTX L664
	r_PackedHalf2AtPtx667R298 = DecodeE4(r_PtxU16Register56);						 // PTX L667
	r_PackedHalf2AtPtx670R301 = DecodeE4(r_PtxU16Register57);						 // PTX L670
	r_PackedHalf2AtPtx673R307 = DecodeE4(r_PtxU16Register58);						 // PTX L673
	r_PackedHalf2AtPtx676R304 = DecodeE4(r_PtxU16Register59);						 // PTX L676
	r_PackedHalf2AtPtx679R310 = DecodeE4(r_PtxU16Register60);						 // PTX L679
	r_PackedHalf2AtPtx682R313 = DecodeE4(r_PtxU16Register61);						 // PTX L682
	r_PackedHalf2AtPtx685R319 = DecodeE4(r_PtxU16Register62);						 // PTX L685
	r_PackedHalf2AtPtx688R316 = DecodeE4(r_PtxU16Register63);						 // PTX L688
	r_PackedHalf2AtPtx691R322 = DecodeE4(r_PtxU16Register64);						 // PTX L691
	r_PackedHalf2AtPtx694R325 = DecodeE4(r_PtxU16Register65);						 // PTX L694
	r_PackedHalf2AtPtx697R331 = DecodeE4(r_PtxU16Register66);						 // PTX L697
	r_PackedHalf2AtPtx700R328 = DecodeE4(r_PtxU16Register67);						 // PTX L700
	r_PackedHalf2AtPtx703R334 = DecodeE4(r_PtxU16Register68);						 // PTX L703
	r_PackedHalf2AtPtx706R337 = DecodeE4(r_PtxU16Register69);						 // PTX L706
	r_PackedHalf2AtPtx709R343 = DecodeE4(r_PtxU16Register70);						 // PTX L709
	r_PackedHalf2AtPtx712R340 = DecodeE4(r_PtxU16Register71);						 // PTX L712
	r_PackedHalf2AtPtx715R346 = DecodeE4(r_PtxU16Register72);						 // PTX L715
	r_PackedHalf2AtPtx718R349 = DecodeE4(r_PtxU16Register73);						 // PTX L718
	r_PackedHalf2AtPtx721R355 = DecodeE4(r_PtxU16Register74);						 // PTX L721
	r_PackedHalf2AtPtx724R352 = DecodeE4(r_PtxU16Register75);						 // PTX L724
	r_PackedHalf2AtPtx727R358 = DecodeE4(r_PtxU16Register76);						 // PTX L727
	r_PtxU16Register77 = uint16_t(r_PtxRegister1405);
	r_PtxU16Register78 = uint16_t(r_PtxRegister1405 >> 16);	  // PTX L729
	r_PackedHalf2AtPtx731R361 = DecodeE4(r_PtxU16Register77); // PTX L731
	r_PackedHalf2AtPtx734R367 = DecodeE4(r_PtxU16Register78); // PTX L734
	r_PtxU16Register79 = uint16_t(r_PtxRegister1406);
	r_PtxU16Register80 = uint16_t(r_PtxRegister1406 >> 16);	  // PTX L736
	r_PackedHalf2AtPtx738R364 = DecodeE4(r_PtxU16Register79); // PTX L738
	r_PackedHalf2AtPtx741R370 = DecodeE4(r_PtxU16Register80); // PTX L741
	r_PtxU16Register81 = uint16_t(r_PtxRegister1407);
	r_PtxU16Register82 = uint16_t(r_PtxRegister1407 >> 16);	  // PTX L743
	r_PackedHalf2AtPtx745R373 = DecodeE4(r_PtxU16Register81); // PTX L745
	r_PackedHalf2AtPtx748R379 = DecodeE4(r_PtxU16Register82); // PTX L748
	r_PtxU16Register83 = uint16_t(r_PtxRegister1408);
	r_PtxU16Register84 = uint16_t(r_PtxRegister1408 >> 16);									 // PTX L750
	r_PackedHalf2AtPtx752R376 = DecodeE4(r_PtxU16Register83);								 // PTX L752
	r_PackedHalf2AtPtx755R382 = DecodeE4(r_PtxU16Register84);								 // PTX L755
	g_RecordByteAddressAtPtx757 = g_RecordBaseAddress;										 // PTX L757
	r_PtxRegister384 = uint32_t(r_PtxRegister6) + uint32_t(8);								 // PTX L758
	r_LaneIndexAtPtx760 = uint32_t((threadIdx.x & 31u));									 // PTX L760
	r_PtxRegister385 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx760), uint32_t(31));		 // PTX L762
	r_PtxRegister386 = ShiftRight(uint32_t(r_PtxRegister385), uint32_t(30));				 // PTX L763
	r_PtxRegister387 = uint32_t(r_LaneIndexAtPtx760) + uint32_t(r_PtxRegister386);			 // PTX L764
	r_PtxRegister388 = r_PtxRegister387 & 2147483644;										 // PTX L765
	r_PtxRegister389 = uint32_t(r_LaneIndexAtPtx760) - uint32_t(r_PtxRegister388);			 // PTX L766
	r_PtxRegister390 = ShiftLeft(uint32_t(r_PtxRegister389), uint32_t(1));					 // PTX L767
	r_PtxRegister391 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister390);				 // PTX L768
	r_PtxRegister392 = ShiftRightSigned(int32_t(r_PtxRegister391), uint32_t(1));			 // PTX L769
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_PtxRegister392)) * int64_t(int32_t(4))); // PTX L770
	g_RecordByteAddressAtPtx771 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register75); // PTX L771
	r_PtxRegister194 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx771 + 1048576ull);		 // PTX L772
	r_LaneIndexAtPtx774 = uint32_t((threadIdx.x & 31u));									 // PTX L774
	r_PtxRegister393 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx774), uint32_t(31));		 // PTX L776
	r_PtxRegister394 = ShiftRight(uint32_t(r_PtxRegister393), uint32_t(30));				 // PTX L777
	r_PtxRegister395 = uint32_t(r_LaneIndexAtPtx774) + uint32_t(r_PtxRegister394);			 // PTX L778
	r_PtxRegister396 = r_PtxRegister395 & 2147483644;										 // PTX L779
	r_PtxRegister397 = uint32_t(r_LaneIndexAtPtx774) - uint32_t(r_PtxRegister396);			 // PTX L780
	r_PtxRegister398 = ShiftLeft(uint32_t(r_PtxRegister397), uint32_t(1));					 // PTX L781
	r_PtxRegister399 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister398);				 // PTX L782
	r_PtxRegister400 = ShiftRightSigned(int32_t(r_PtxRegister399), uint32_t(1));			 // PTX L783
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_PtxRegister400)) * int64_t(int32_t(4))); // PTX L784
	g_RecordByteAddressAtPtx785 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register77); // PTX L785
	r_PtxRegister197 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx785 + 1048576ull);		 // PTX L786
	r_LaneIndexAtPtx788 = uint32_t((threadIdx.x & 31u));									 // PTX L788
	r_PtxRegister401 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx788), uint32_t(31));		 // PTX L790
	r_PtxRegister402 = ShiftRight(uint32_t(r_PtxRegister401), uint32_t(30));				 // PTX L791
	r_PtxRegister403 = uint32_t(r_LaneIndexAtPtx788) + uint32_t(r_PtxRegister402);			 // PTX L792
	r_PtxRegister404 = r_PtxRegister403 & 2147483644;										 // PTX L793
	r_PtxRegister405 = uint32_t(r_LaneIndexAtPtx788) - uint32_t(r_PtxRegister404);			 // PTX L794
	r_PtxRegister406 = ShiftLeft(uint32_t(r_PtxRegister405), uint32_t(1));					 // PTX L795
	r_PtxRegister407 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister406);				 // PTX L796
	r_PtxRegister408 = ShiftRightSigned(int32_t(r_PtxRegister407), uint32_t(1));			 // PTX L797
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister408)) * int64_t(int32_t(4))); // PTX L798
	g_RecordByteAddressAtPtx799 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register79); // PTX L799
	r_PtxRegister200 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx799 + 1048576ull);		 // PTX L800
	r_LaneIndexAtPtx802 = uint32_t((threadIdx.x & 31u));									 // PTX L802
	r_PtxRegister409 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx802), uint32_t(31));		 // PTX L804
	r_PtxRegister410 = ShiftRight(uint32_t(r_PtxRegister409), uint32_t(30));				 // PTX L805
	r_PtxRegister411 = uint32_t(r_LaneIndexAtPtx802) + uint32_t(r_PtxRegister410);			 // PTX L806
	r_PtxRegister412 = r_PtxRegister411 & 2147483644;										 // PTX L807
	r_PtxRegister413 = uint32_t(r_LaneIndexAtPtx802) - uint32_t(r_PtxRegister412);			 // PTX L808
	r_PtxRegister414 = ShiftLeft(uint32_t(r_PtxRegister413), uint32_t(1));					 // PTX L809
	r_PtxRegister415 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister414);				 // PTX L810
	r_PtxRegister416 = ShiftRightSigned(int32_t(r_PtxRegister415), uint32_t(1));			 // PTX L811
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister416)) * int64_t(int32_t(4))); // PTX L812
	g_RecordByteAddressAtPtx813 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register81); // PTX L813
	r_PtxRegister203 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx813 + 1048576ull);		 // PTX L814
	r_LaneIndexAtPtx816 = uint32_t((threadIdx.x & 31u));									 // PTX L816
	r_PtxRegister417 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx816), uint32_t(31));		 // PTX L818
	r_PtxRegister418 = ShiftRight(uint32_t(r_PtxRegister417), uint32_t(30));				 // PTX L819
	r_PtxRegister419 = uint32_t(r_LaneIndexAtPtx816) + uint32_t(r_PtxRegister418);			 // PTX L820
	r_PtxRegister420 = r_PtxRegister419 & 2147483644;										 // PTX L821
	r_PtxRegister421 = uint32_t(r_LaneIndexAtPtx816) - uint32_t(r_PtxRegister420);			 // PTX L822
	r_PtxRegister422 = ShiftLeft(uint32_t(r_PtxRegister421), uint32_t(1));					 // PTX L823
	r_PtxRegister423 = uint32_t(r_PtxRegister6) + uint32_t(16);								 // PTX L824
	r_PtxRegister424 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister422);				 // PTX L825
	r_PtxRegister425 = ShiftRightSigned(int32_t(r_PtxRegister424), uint32_t(1));			 // PTX L826
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_PtxRegister425)) * int64_t(int32_t(4))); // PTX L827
	g_RecordByteAddressAtPtx828 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register83); // PTX L828
	r_PtxRegister206 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx828 + 1048576ull);		 // PTX L829
	r_LaneIndexAtPtx831 = uint32_t((threadIdx.x & 31u));									 // PTX L831
	r_PtxRegister426 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx831), uint32_t(31));		 // PTX L833
	r_PtxRegister427 = ShiftRight(uint32_t(r_PtxRegister426), uint32_t(30));				 // PTX L834
	r_PtxRegister428 = uint32_t(r_LaneIndexAtPtx831) + uint32_t(r_PtxRegister427);			 // PTX L835
	r_PtxRegister429 = r_PtxRegister428 & 2147483644;										 // PTX L836
	r_PtxRegister430 = uint32_t(r_LaneIndexAtPtx831) - uint32_t(r_PtxRegister429);			 // PTX L837
	r_PtxRegister431 = ShiftLeft(uint32_t(r_PtxRegister430), uint32_t(1));					 // PTX L838
	r_PtxRegister432 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister431);				 // PTX L839
	r_PtxRegister433 = ShiftRightSigned(int32_t(r_PtxRegister432), uint32_t(1));			 // PTX L840
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_PtxRegister433)) * int64_t(int32_t(4))); // PTX L841
	g_RecordByteAddressAtPtx842 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register85); // PTX L842
	r_PtxRegister209 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx842 + 1048576ull);		 // PTX L843
	r_LaneIndexAtPtx845 = uint32_t((threadIdx.x & 31u));									 // PTX L845
	r_PtxRegister434 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx845), uint32_t(31));		 // PTX L847
	r_PtxRegister435 = ShiftRight(uint32_t(r_PtxRegister434), uint32_t(30));				 // PTX L848
	r_PtxRegister436 = uint32_t(r_LaneIndexAtPtx845) + uint32_t(r_PtxRegister435);			 // PTX L849
	r_PtxRegister437 = r_PtxRegister436 & 2147483644;										 // PTX L850
	r_PtxRegister438 = uint32_t(r_LaneIndexAtPtx845) - uint32_t(r_PtxRegister437);			 // PTX L851
	r_PtxRegister439 = ShiftLeft(uint32_t(r_PtxRegister438), uint32_t(1));					 // PTX L852
	r_PtxRegister440 = uint32_t(r_PtxRegister6) + uint32_t(24);								 // PTX L853
	r_PtxRegister441 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister439);				 // PTX L854
	r_PtxRegister442 = ShiftRight(uint32_t(r_PtxRegister441), uint32_t(31));				 // PTX L855
	r_PtxRegister443 = uint32_t(r_PtxRegister441) + uint32_t(r_PtxRegister442);				 // PTX L856
	r_PtxRegister444 = ShiftRightSigned(int32_t(r_PtxRegister443), uint32_t(1));			 // PTX L857
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_PtxRegister444)) * int64_t(int32_t(4))); // PTX L858
	g_RecordByteAddressAtPtx859 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register87); // PTX L859
	r_PtxRegister212 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx859 + 1048576ull);		 // PTX L860
	r_LaneIndexAtPtx862 = uint32_t((threadIdx.x & 31u));									 // PTX L862
	r_PtxRegister445 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx862), uint32_t(31));		 // PTX L864
	r_PtxRegister446 = ShiftRight(uint32_t(r_PtxRegister445), uint32_t(30));				 // PTX L865
	r_PtxRegister447 = uint32_t(r_LaneIndexAtPtx862) + uint32_t(r_PtxRegister446);			 // PTX L866
	r_PtxRegister448 = r_PtxRegister447 & 2147483644;										 // PTX L867
	r_PtxRegister449 = uint32_t(r_LaneIndexAtPtx862) - uint32_t(r_PtxRegister448);			 // PTX L868
	r_PtxRegister450 = ShiftLeft(uint32_t(r_PtxRegister449), uint32_t(1));					 // PTX L869
	r_PtxRegister451 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister450);				 // PTX L870
	r_PtxRegister452 = ShiftRight(uint32_t(r_PtxRegister451), uint32_t(31));				 // PTX L871
	r_PtxRegister453 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister452);				 // PTX L872
	r_PtxRegister454 = ShiftRightSigned(int32_t(r_PtxRegister453), uint32_t(1));			 // PTX L873
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister454)) * int64_t(int32_t(4))); // PTX L874
	g_RecordByteAddressAtPtx875 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register89); // PTX L875
	r_PtxRegister215 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx875 + 1048576ull);		 // PTX L876
	r_LaneIndexAtPtx878 = uint32_t((threadIdx.x & 31u));									 // PTX L878
	r_PtxRegister455 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx878), uint32_t(31));		 // PTX L880
	r_PtxRegister456 = ShiftRight(uint32_t(r_PtxRegister455), uint32_t(30));				 // PTX L881
	r_PtxRegister457 = uint32_t(r_LaneIndexAtPtx878) + uint32_t(r_PtxRegister456);			 // PTX L882
	r_PtxRegister458 = r_PtxRegister457 & 2147483644;										 // PTX L883
	r_PtxRegister459 = uint32_t(r_LaneIndexAtPtx878) - uint32_t(r_PtxRegister458);			 // PTX L884
	r_PtxRegister460 = ShiftLeft(uint32_t(r_PtxRegister459), uint32_t(1));					 // PTX L885
	r_PtxRegister461 = uint32_t(r_PtxRegister6) + uint32_t(32);								 // PTX L886
	r_PtxRegister462 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister460);				 // PTX L887
	r_PtxRegister463 = ShiftRightSigned(int32_t(r_PtxRegister462), uint32_t(1));			 // PTX L888
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister463)) * int64_t(int32_t(4))); // PTX L889
	g_RecordByteAddressAtPtx890 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register91); // PTX L890
	r_PtxRegister218 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx890 + 1048576ull);		 // PTX L891
	r_LaneIndexAtPtx893 = uint32_t((threadIdx.x & 31u));									 // PTX L893
	r_PtxRegister464 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx893), uint32_t(31));		 // PTX L895
	r_PtxRegister465 = ShiftRight(uint32_t(r_PtxRegister464), uint32_t(30));				 // PTX L896
	r_PtxRegister466 = uint32_t(r_LaneIndexAtPtx893) + uint32_t(r_PtxRegister465);			 // PTX L897
	r_PtxRegister467 = r_PtxRegister466 & 2147483644;										 // PTX L898
	r_PtxRegister468 = uint32_t(r_LaneIndexAtPtx893) - uint32_t(r_PtxRegister467);			 // PTX L899
	r_PtxRegister469 = ShiftLeft(uint32_t(r_PtxRegister468), uint32_t(1));					 // PTX L900
	r_PtxRegister470 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister469);				 // PTX L901
	r_PtxRegister471 = ShiftRightSigned(int32_t(r_PtxRegister470), uint32_t(1));			 // PTX L902
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_PtxRegister471)) * int64_t(int32_t(4))); // PTX L903
	g_RecordByteAddressAtPtx904 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register93); // PTX L904
	r_PtxRegister221 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx904 + 1048576ull);		 // PTX L905
	r_LaneIndexAtPtx907 = uint32_t((threadIdx.x & 31u));									 // PTX L907
	r_PtxRegister472 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx907), uint32_t(31));		 // PTX L909
	r_PtxRegister473 = ShiftRight(uint32_t(r_PtxRegister472), uint32_t(30));				 // PTX L910
	r_PtxRegister474 = uint32_t(r_LaneIndexAtPtx907) + uint32_t(r_PtxRegister473);			 // PTX L911
	r_PtxRegister475 = r_PtxRegister474 & 2147483644;										 // PTX L912
	r_PtxRegister476 = uint32_t(r_LaneIndexAtPtx907) - uint32_t(r_PtxRegister475);			 // PTX L913
	r_PtxRegister477 = ShiftLeft(uint32_t(r_PtxRegister476), uint32_t(1));					 // PTX L914
	r_PtxRegister478 = uint32_t(r_PtxRegister6) + uint32_t(40);								 // PTX L915
	r_PtxRegister479 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister477);				 // PTX L916
	r_PtxRegister480 = ShiftRight(uint32_t(r_PtxRegister479), uint32_t(31));				 // PTX L917
	r_PtxRegister481 = uint32_t(r_PtxRegister479) + uint32_t(r_PtxRegister480);				 // PTX L918
	r_PtxRegister482 = ShiftRightSigned(int32_t(r_PtxRegister481), uint32_t(1));			 // PTX L919
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister482)) * int64_t(int32_t(4))); // PTX L920
	g_RecordByteAddressAtPtx921 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register95); // PTX L921
	r_PtxRegister224 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx921 + 1048576ull);		 // PTX L922
	r_LaneIndexAtPtx924 = uint32_t((threadIdx.x & 31u));									 // PTX L924
	r_PtxRegister483 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx924), uint32_t(31));		 // PTX L926
	r_PtxRegister484 = ShiftRight(uint32_t(r_PtxRegister483), uint32_t(30));				 // PTX L927
	r_PtxRegister485 = uint32_t(r_LaneIndexAtPtx924) + uint32_t(r_PtxRegister484);			 // PTX L928
	r_PtxRegister486 = r_PtxRegister485 & 2147483644;										 // PTX L929
	r_PtxRegister487 = uint32_t(r_LaneIndexAtPtx924) - uint32_t(r_PtxRegister486);			 // PTX L930
	r_PtxRegister488 = ShiftLeft(uint32_t(r_PtxRegister487), uint32_t(1));					 // PTX L931
	r_PtxRegister489 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister488);				 // PTX L932
	r_PtxRegister490 = ShiftRight(uint32_t(r_PtxRegister489), uint32_t(31));				 // PTX L933
	r_PtxRegister491 = uint32_t(r_PtxRegister489) + uint32_t(r_PtxRegister490);				 // PTX L934
	r_PtxRegister492 = ShiftRightSigned(int32_t(r_PtxRegister491), uint32_t(1));			 // PTX L935
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_PtxRegister492)) * int64_t(int32_t(4))); // PTX L936
	g_RecordByteAddressAtPtx937 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register97); // PTX L937
	r_PtxRegister227 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx937 + 1048576ull);		 // PTX L938
	r_LaneIndexAtPtx940 = uint32_t((threadIdx.x & 31u));									 // PTX L940
	r_PtxRegister493 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx940), uint32_t(31));		 // PTX L942
	r_PtxRegister494 = ShiftRight(uint32_t(r_PtxRegister493), uint32_t(30));				 // PTX L943
	r_PtxRegister495 = uint32_t(r_LaneIndexAtPtx940) + uint32_t(r_PtxRegister494);			 // PTX L944
	r_PtxRegister496 = r_PtxRegister495 & 2147483644;										 // PTX L945
	r_PtxRegister497 = uint32_t(r_LaneIndexAtPtx940) - uint32_t(r_PtxRegister496);			 // PTX L946
	r_PtxRegister498 = ShiftLeft(uint32_t(r_PtxRegister497), uint32_t(1));					 // PTX L947
	r_PtxRegister499 = uint32_t(r_PtxRegister6) + uint32_t(48);								 // PTX L948
	r_PtxRegister500 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister498);				 // PTX L949
	r_PtxRegister501 = ShiftRightSigned(int32_t(r_PtxRegister500), uint32_t(1));			 // PTX L950
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister501)) * int64_t(int32_t(4))); // PTX L951
	g_RecordByteAddressAtPtx952 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register99); // PTX L952
	r_PtxRegister230 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx952 + 1048576ull);		  // PTX L953
	r_LaneIndexAtPtx955 = uint32_t((threadIdx.x & 31u));									  // PTX L955
	r_PtxRegister502 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx955), uint32_t(31));		  // PTX L957
	r_PtxRegister503 = ShiftRight(uint32_t(r_PtxRegister502), uint32_t(30));				  // PTX L958
	r_PtxRegister504 = uint32_t(r_LaneIndexAtPtx955) + uint32_t(r_PtxRegister503);			  // PTX L959
	r_PtxRegister505 = r_PtxRegister504 & 2147483644;										  // PTX L960
	r_PtxRegister506 = uint32_t(r_LaneIndexAtPtx955) - uint32_t(r_PtxRegister505);			  // PTX L961
	r_PtxRegister507 = ShiftLeft(uint32_t(r_PtxRegister506), uint32_t(1));					  // PTX L962
	r_PtxRegister508 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister507);				  // PTX L963
	r_PtxRegister509 = ShiftRightSigned(int32_t(r_PtxRegister508), uint32_t(1));			  // PTX L964
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister509)) * int64_t(int32_t(4))); // PTX L965
	g_RecordByteAddressAtPtx966 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register101); // PTX L966
	r_PtxRegister233 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx966 + 1048576ull);		  // PTX L967
	r_LaneIndexAtPtx969 = uint32_t((threadIdx.x & 31u));									  // PTX L969
	r_PtxRegister510 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx969), uint32_t(31));		  // PTX L971
	r_PtxRegister511 = ShiftRight(uint32_t(r_PtxRegister510), uint32_t(30));				  // PTX L972
	r_PtxRegister512 = uint32_t(r_LaneIndexAtPtx969) + uint32_t(r_PtxRegister511);			  // PTX L973
	r_PtxRegister513 = r_PtxRegister512 & 2147483644;										  // PTX L974
	r_PtxRegister514 = uint32_t(r_LaneIndexAtPtx969) - uint32_t(r_PtxRegister513);			  // PTX L975
	r_PtxRegister515 = ShiftLeft(uint32_t(r_PtxRegister514), uint32_t(1));					  // PTX L976
	r_PtxRegister516 = uint32_t(r_PtxRegister6) + uint32_t(56);								  // PTX L977
	r_PtxRegister517 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister515);				  // PTX L978
	r_PtxRegister518 = ShiftRight(uint32_t(r_PtxRegister517), uint32_t(31));				  // PTX L979
	r_PtxRegister519 = uint32_t(r_PtxRegister517) + uint32_t(r_PtxRegister518);				  // PTX L980
	r_PtxRegister520 = ShiftRightSigned(int32_t(r_PtxRegister519), uint32_t(1));			  // PTX L981
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister520)) * int64_t(int32_t(4))); // PTX L982
	g_RecordByteAddressAtPtx983 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register103); // PTX L983
	r_PtxRegister236 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx983 + 1048576ull);		  // PTX L984
	r_LaneIndexAtPtx986 = uint32_t((threadIdx.x & 31u));									  // PTX L986
	r_PtxRegister521 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx986), uint32_t(31));		  // PTX L988
	r_PtxRegister522 = ShiftRight(uint32_t(r_PtxRegister521), uint32_t(30));				  // PTX L989
	r_PtxRegister523 = uint32_t(r_LaneIndexAtPtx986) + uint32_t(r_PtxRegister522);			  // PTX L990
	r_PtxRegister524 = r_PtxRegister523 & 2147483644;										  // PTX L991
	r_PtxRegister525 = uint32_t(r_LaneIndexAtPtx986) - uint32_t(r_PtxRegister524);			  // PTX L992
	r_PtxRegister526 = ShiftLeft(uint32_t(r_PtxRegister525), uint32_t(1));					  // PTX L993
	r_PtxRegister527 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister526);				  // PTX L994
	r_PtxRegister528 = ShiftRight(uint32_t(r_PtxRegister527), uint32_t(31));				  // PTX L995
	r_PtxRegister529 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister528);				  // PTX L996
	r_PtxRegister530 = ShiftRightSigned(int32_t(r_PtxRegister529), uint32_t(1));			  // PTX L997
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister530)) * int64_t(int32_t(4))); // PTX L998
	g_RecordByteAddressAtPtx999 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register105); // PTX L999
	r_PtxRegister239 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx999 + 1048576ull);		  // PTX L1000
	r_LaneIndexAtPtx1002 = uint32_t((threadIdx.x & 31u));									  // PTX L1002
	r_PtxRegister531 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1002), uint32_t(31));		  // PTX L1004
	r_PtxRegister532 = ShiftRight(uint32_t(r_PtxRegister531), uint32_t(30));				  // PTX L1005
	r_PtxRegister533 = uint32_t(r_LaneIndexAtPtx1002) + uint32_t(r_PtxRegister532);			  // PTX L1006
	r_PtxRegister534 = r_PtxRegister533 & 2147483644;										  // PTX L1007
	r_PtxRegister535 = uint32_t(r_LaneIndexAtPtx1002) - uint32_t(r_PtxRegister534);			  // PTX L1008
	r_PtxRegister536 = ShiftLeft(uint32_t(r_PtxRegister535), uint32_t(1));					  // PTX L1009
	r_PtxRegister537 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister536);				  // PTX L1010
	r_PtxRegister538 = ShiftRightSigned(int32_t(r_PtxRegister537), uint32_t(1));			  // PTX L1011
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister538)) * int64_t(int32_t(4))); // PTX L1012
	g_RecordByteAddressAtPtx1013 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register107); // PTX L1013
	r_PtxRegister242 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1013 + 1048576ull);		  // PTX L1014
	r_LaneIndexAtPtx1016 = uint32_t((threadIdx.x & 31u));									  // PTX L1016
	r_PtxRegister539 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1016), uint32_t(31));		  // PTX L1018
	r_PtxRegister540 = ShiftRight(uint32_t(r_PtxRegister539), uint32_t(30));				  // PTX L1019
	r_PtxRegister541 = uint32_t(r_LaneIndexAtPtx1016) + uint32_t(r_PtxRegister540);			  // PTX L1020
	r_PtxRegister542 = r_PtxRegister541 & 2147483644;										  // PTX L1021
	r_PtxRegister543 = uint32_t(r_LaneIndexAtPtx1016) - uint32_t(r_PtxRegister542);			  // PTX L1022
	r_PtxRegister544 = ShiftLeft(uint32_t(r_PtxRegister543), uint32_t(1));					  // PTX L1023
	r_PtxRegister545 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister544);				  // PTX L1024
	r_PtxRegister546 = ShiftRightSigned(int32_t(r_PtxRegister545), uint32_t(1));			  // PTX L1025
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister546)) * int64_t(int32_t(4))); // PTX L1026
	g_RecordByteAddressAtPtx1027 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register109); // PTX L1027
	r_PtxRegister245 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1027 + 1048576ull);		  // PTX L1028
	r_LaneIndexAtPtx1030 = uint32_t((threadIdx.x & 31u));									  // PTX L1030
	r_PtxRegister547 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1030), uint32_t(31));		  // PTX L1032
	r_PtxRegister548 = ShiftRight(uint32_t(r_PtxRegister547), uint32_t(30));				  // PTX L1033
	r_PtxRegister549 = uint32_t(r_LaneIndexAtPtx1030) + uint32_t(r_PtxRegister548);			  // PTX L1034
	r_PtxRegister550 = r_PtxRegister549 & 2147483644;										  // PTX L1035
	r_PtxRegister551 = uint32_t(r_LaneIndexAtPtx1030) - uint32_t(r_PtxRegister550);			  // PTX L1036
	r_PtxRegister552 = ShiftLeft(uint32_t(r_PtxRegister551), uint32_t(1));					  // PTX L1037
	r_PtxRegister553 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister552);				  // PTX L1038
	r_PtxRegister554 = ShiftRightSigned(int32_t(r_PtxRegister553), uint32_t(1));			  // PTX L1039
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister554)) * int64_t(int32_t(4))); // PTX L1040
	g_RecordByteAddressAtPtx1041 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register111); // PTX L1041
	r_PtxRegister248 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1041 + 1048576ull);		  // PTX L1042
	r_LaneIndexAtPtx1044 = uint32_t((threadIdx.x & 31u));									  // PTX L1044
	r_PtxRegister555 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1044), uint32_t(31));		  // PTX L1046
	r_PtxRegister556 = ShiftRight(uint32_t(r_PtxRegister555), uint32_t(30));				  // PTX L1047
	r_PtxRegister557 = uint32_t(r_LaneIndexAtPtx1044) + uint32_t(r_PtxRegister556);			  // PTX L1048
	r_PtxRegister558 = r_PtxRegister557 & 2147483644;										  // PTX L1049
	r_PtxRegister559 = uint32_t(r_LaneIndexAtPtx1044) - uint32_t(r_PtxRegister558);			  // PTX L1050
	r_PtxRegister560 = ShiftLeft(uint32_t(r_PtxRegister559), uint32_t(1));					  // PTX L1051
	r_PtxRegister561 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister560);				  // PTX L1052
	r_PtxRegister562 = ShiftRightSigned(int32_t(r_PtxRegister561), uint32_t(1));			  // PTX L1053
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister562)) * int64_t(int32_t(4))); // PTX L1054
	g_RecordByteAddressAtPtx1055 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register113); // PTX L1055
	r_PtxRegister251 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1055 + 1048576ull);		  // PTX L1056
	r_LaneIndexAtPtx1058 = uint32_t((threadIdx.x & 31u));									  // PTX L1058
	r_PtxRegister563 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1058), uint32_t(31));		  // PTX L1060
	r_PtxRegister564 = ShiftRight(uint32_t(r_PtxRegister563), uint32_t(30));				  // PTX L1061
	r_PtxRegister565 = uint32_t(r_LaneIndexAtPtx1058) + uint32_t(r_PtxRegister564);			  // PTX L1062
	r_PtxRegister566 = r_PtxRegister565 & 2147483644;										  // PTX L1063
	r_PtxRegister567 = uint32_t(r_LaneIndexAtPtx1058) - uint32_t(r_PtxRegister566);			  // PTX L1064
	r_PtxRegister568 = ShiftLeft(uint32_t(r_PtxRegister567), uint32_t(1));					  // PTX L1065
	r_PtxRegister569 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister568);				  // PTX L1066
	r_PtxRegister570 = ShiftRightSigned(int32_t(r_PtxRegister569), uint32_t(1));			  // PTX L1067
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister570)) * int64_t(int32_t(4))); // PTX L1068
	g_RecordByteAddressAtPtx1069 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register115); // PTX L1069
	r_PtxRegister254 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1069 + 1048576ull);		  // PTX L1070
	r_LaneIndexAtPtx1072 = uint32_t((threadIdx.x & 31u));									  // PTX L1072
	r_PtxRegister571 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1072), uint32_t(31));		  // PTX L1074
	r_PtxRegister572 = ShiftRight(uint32_t(r_PtxRegister571), uint32_t(30));				  // PTX L1075
	r_PtxRegister573 = uint32_t(r_LaneIndexAtPtx1072) + uint32_t(r_PtxRegister572);			  // PTX L1076
	r_PtxRegister574 = r_PtxRegister573 & 2147483644;										  // PTX L1077
	r_PtxRegister575 = uint32_t(r_LaneIndexAtPtx1072) - uint32_t(r_PtxRegister574);			  // PTX L1078
	r_PtxRegister576 = ShiftLeft(uint32_t(r_PtxRegister575), uint32_t(1));					  // PTX L1079
	r_PtxRegister577 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister576);				  // PTX L1080
	r_PtxRegister578 = ShiftRightSigned(int32_t(r_PtxRegister577), uint32_t(1));			  // PTX L1081
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister578)) * int64_t(int32_t(4))); // PTX L1082
	g_RecordByteAddressAtPtx1083 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register117); // PTX L1083
	r_PtxRegister257 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1083 + 1048576ull);		  // PTX L1084
	r_LaneIndexAtPtx1086 = uint32_t((threadIdx.x & 31u));									  // PTX L1086
	r_PtxRegister579 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1086), uint32_t(31));		  // PTX L1088
	r_PtxRegister580 = ShiftRight(uint32_t(r_PtxRegister579), uint32_t(30));				  // PTX L1089
	r_PtxRegister581 = uint32_t(r_LaneIndexAtPtx1086) + uint32_t(r_PtxRegister580);			  // PTX L1090
	r_PtxRegister582 = r_PtxRegister581 & 2147483644;										  // PTX L1091
	r_PtxRegister583 = uint32_t(r_LaneIndexAtPtx1086) - uint32_t(r_PtxRegister582);			  // PTX L1092
	r_PtxRegister584 = ShiftLeft(uint32_t(r_PtxRegister583), uint32_t(1));					  // PTX L1093
	r_PtxRegister585 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister584);				  // PTX L1094
	r_PtxRegister586 = ShiftRight(uint32_t(r_PtxRegister585), uint32_t(31));				  // PTX L1095
	r_PtxRegister587 = uint32_t(r_PtxRegister585) + uint32_t(r_PtxRegister586);				  // PTX L1096
	r_PtxRegister588 = ShiftRightSigned(int32_t(r_PtxRegister587), uint32_t(1));			  // PTX L1097
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister588)) * int64_t(int32_t(4))); // PTX L1098
	g_RecordByteAddressAtPtx1099 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register119); // PTX L1099
	r_PtxRegister260 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1099 + 1048576ull);		  // PTX L1100
	r_LaneIndexAtPtx1102 = uint32_t((threadIdx.x & 31u));									  // PTX L1102
	r_PtxRegister589 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1102), uint32_t(31));		  // PTX L1104
	r_PtxRegister590 = ShiftRight(uint32_t(r_PtxRegister589), uint32_t(30));				  // PTX L1105
	r_PtxRegister591 = uint32_t(r_LaneIndexAtPtx1102) + uint32_t(r_PtxRegister590);			  // PTX L1106
	r_PtxRegister592 = r_PtxRegister591 & 2147483644;										  // PTX L1107
	r_PtxRegister593 = uint32_t(r_LaneIndexAtPtx1102) - uint32_t(r_PtxRegister592);			  // PTX L1108
	r_PtxRegister594 = ShiftLeft(uint32_t(r_PtxRegister593), uint32_t(1));					  // PTX L1109
	r_PtxRegister595 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister594);				  // PTX L1110
	r_PtxRegister596 = ShiftRight(uint32_t(r_PtxRegister595), uint32_t(31));				  // PTX L1111
	r_PtxRegister597 = uint32_t(r_PtxRegister595) + uint32_t(r_PtxRegister596);				  // PTX L1112
	r_PtxRegister598 = ShiftRightSigned(int32_t(r_PtxRegister597), uint32_t(1));			  // PTX L1113
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister598)) * int64_t(int32_t(4))); // PTX L1114
	g_RecordByteAddressAtPtx1115 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register121); // PTX L1115
	r_PtxRegister263 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1115 + 1048576ull);		  // PTX L1116
	r_LaneIndexAtPtx1118 = uint32_t((threadIdx.x & 31u));									  // PTX L1118
	r_PtxRegister599 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1118), uint32_t(31));		  // PTX L1120
	r_PtxRegister600 = ShiftRight(uint32_t(r_PtxRegister599), uint32_t(30));				  // PTX L1121
	r_PtxRegister601 = uint32_t(r_LaneIndexAtPtx1118) + uint32_t(r_PtxRegister600);			  // PTX L1122
	r_PtxRegister602 = r_PtxRegister601 & 2147483644;										  // PTX L1123
	r_PtxRegister603 = uint32_t(r_LaneIndexAtPtx1118) - uint32_t(r_PtxRegister602);			  // PTX L1124
	r_PtxRegister604 = ShiftLeft(uint32_t(r_PtxRegister603), uint32_t(1));					  // PTX L1125
	r_PtxRegister605 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister604);				  // PTX L1126
	r_PtxRegister606 = ShiftRightSigned(int32_t(r_PtxRegister605), uint32_t(1));			  // PTX L1127
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister606)) * int64_t(int32_t(4))); // PTX L1128
	g_RecordByteAddressAtPtx1129 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register123); // PTX L1129
	r_PtxRegister266 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1129 + 1048576ull);		  // PTX L1130
	r_LaneIndexAtPtx1132 = uint32_t((threadIdx.x & 31u));									  // PTX L1132
	r_PtxRegister607 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1132), uint32_t(31));		  // PTX L1134
	r_PtxRegister608 = ShiftRight(uint32_t(r_PtxRegister607), uint32_t(30));				  // PTX L1135
	r_PtxRegister609 = uint32_t(r_LaneIndexAtPtx1132) + uint32_t(r_PtxRegister608);			  // PTX L1136
	r_PtxRegister610 = r_PtxRegister609 & 2147483644;										  // PTX L1137
	r_PtxRegister611 = uint32_t(r_LaneIndexAtPtx1132) - uint32_t(r_PtxRegister610);			  // PTX L1138
	r_PtxRegister612 = ShiftLeft(uint32_t(r_PtxRegister611), uint32_t(1));					  // PTX L1139
	r_PtxRegister613 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister612);				  // PTX L1140
	r_PtxRegister614 = ShiftRightSigned(int32_t(r_PtxRegister613), uint32_t(1));			  // PTX L1141
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister614)) * int64_t(int32_t(4))); // PTX L1142
	g_RecordByteAddressAtPtx1143 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register125); // PTX L1143
	r_PtxRegister269 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1143 + 1048576ull);		  // PTX L1144
	r_LaneIndexAtPtx1146 = uint32_t((threadIdx.x & 31u));									  // PTX L1146
	r_PtxRegister615 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1146), uint32_t(31));		  // PTX L1148
	r_PtxRegister616 = ShiftRight(uint32_t(r_PtxRegister615), uint32_t(30));				  // PTX L1149
	r_PtxRegister617 = uint32_t(r_LaneIndexAtPtx1146) + uint32_t(r_PtxRegister616);			  // PTX L1150
	r_PtxRegister618 = r_PtxRegister617 & 2147483644;										  // PTX L1151
	r_PtxRegister619 = uint32_t(r_LaneIndexAtPtx1146) - uint32_t(r_PtxRegister618);			  // PTX L1152
	r_PtxRegister620 = ShiftLeft(uint32_t(r_PtxRegister619), uint32_t(1));					  // PTX L1153
	r_PtxRegister621 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister620);				  // PTX L1154
	r_PtxRegister622 = ShiftRight(uint32_t(r_PtxRegister621), uint32_t(31));				  // PTX L1155
	r_PtxRegister623 = uint32_t(r_PtxRegister621) + uint32_t(r_PtxRegister622);				  // PTX L1156
	r_PtxRegister624 = ShiftRightSigned(int32_t(r_PtxRegister623), uint32_t(1));			  // PTX L1157
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister624)) * int64_t(int32_t(4))); // PTX L1158
	g_RecordByteAddressAtPtx1159 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register127); // PTX L1159
	r_PtxRegister272 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1159 + 1048576ull);		  // PTX L1160
	r_LaneIndexAtPtx1162 = uint32_t((threadIdx.x & 31u));									  // PTX L1162
	r_PtxRegister625 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1162), uint32_t(31));		  // PTX L1164
	r_PtxRegister626 = ShiftRight(uint32_t(r_PtxRegister625), uint32_t(30));				  // PTX L1165
	r_PtxRegister627 = uint32_t(r_LaneIndexAtPtx1162) + uint32_t(r_PtxRegister626);			  // PTX L1166
	r_PtxRegister628 = r_PtxRegister627 & 2147483644;										  // PTX L1167
	r_PtxRegister629 = uint32_t(r_LaneIndexAtPtx1162) - uint32_t(r_PtxRegister628);			  // PTX L1168
	r_PtxRegister630 = ShiftLeft(uint32_t(r_PtxRegister629), uint32_t(1));					  // PTX L1169
	r_PtxRegister631 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister630);				  // PTX L1170
	r_PtxRegister632 = ShiftRight(uint32_t(r_PtxRegister631), uint32_t(31));				  // PTX L1171
	r_PtxRegister633 = uint32_t(r_PtxRegister631) + uint32_t(r_PtxRegister632);				  // PTX L1172
	r_PtxRegister634 = ShiftRightSigned(int32_t(r_PtxRegister633), uint32_t(1));			  // PTX L1173
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister634)) * int64_t(int32_t(4))); // PTX L1174
	g_RecordByteAddressAtPtx1175 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register129); // PTX L1175
	r_PtxRegister275 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1175 + 1048576ull);		  // PTX L1176
	r_LaneIndexAtPtx1178 = uint32_t((threadIdx.x & 31u));									  // PTX L1178
	r_PtxRegister635 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1178), uint32_t(31));		  // PTX L1180
	r_PtxRegister636 = ShiftRight(uint32_t(r_PtxRegister635), uint32_t(30));				  // PTX L1181
	r_PtxRegister637 = uint32_t(r_LaneIndexAtPtx1178) + uint32_t(r_PtxRegister636);			  // PTX L1182
	r_PtxRegister638 = r_PtxRegister637 & 2147483644;										  // PTX L1183
	r_PtxRegister639 = uint32_t(r_LaneIndexAtPtx1178) - uint32_t(r_PtxRegister638);			  // PTX L1184
	r_PtxRegister640 = ShiftLeft(uint32_t(r_PtxRegister639), uint32_t(1));					  // PTX L1185
	r_PtxRegister641 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister640);				  // PTX L1186
	r_PtxRegister642 = ShiftRightSigned(int32_t(r_PtxRegister641), uint32_t(1));			  // PTX L1187
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister642)) * int64_t(int32_t(4))); // PTX L1188
	g_RecordByteAddressAtPtx1189 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register131); // PTX L1189
	r_PtxRegister278 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1189 + 1048576ull);		  // PTX L1190
	r_LaneIndexAtPtx1192 = uint32_t((threadIdx.x & 31u));									  // PTX L1192
	r_PtxRegister643 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1192), uint32_t(31));		  // PTX L1194
	r_PtxRegister644 = ShiftRight(uint32_t(r_PtxRegister643), uint32_t(30));				  // PTX L1195
	r_PtxRegister645 = uint32_t(r_LaneIndexAtPtx1192) + uint32_t(r_PtxRegister644);			  // PTX L1196
	r_PtxRegister646 = r_PtxRegister645 & 2147483644;										  // PTX L1197
	r_PtxRegister647 = uint32_t(r_LaneIndexAtPtx1192) - uint32_t(r_PtxRegister646);			  // PTX L1198
	r_PtxRegister648 = ShiftLeft(uint32_t(r_PtxRegister647), uint32_t(1));					  // PTX L1199
	r_PtxRegister649 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister648);				  // PTX L1200
	r_PtxRegister650 = ShiftRightSigned(int32_t(r_PtxRegister649), uint32_t(1));			  // PTX L1201
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister650)) * int64_t(int32_t(4))); // PTX L1202
	g_RecordByteAddressAtPtx1203 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register133); // PTX L1203
	r_PtxRegister281 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1203 + 1048576ull);		  // PTX L1204
	r_LaneIndexAtPtx1206 = uint32_t((threadIdx.x & 31u));									  // PTX L1206
	r_PtxRegister651 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1206), uint32_t(31));		  // PTX L1208
	r_PtxRegister652 = ShiftRight(uint32_t(r_PtxRegister651), uint32_t(30));				  // PTX L1209
	r_PtxRegister653 = uint32_t(r_LaneIndexAtPtx1206) + uint32_t(r_PtxRegister652);			  // PTX L1210
	r_PtxRegister654 = r_PtxRegister653 & 2147483644;										  // PTX L1211
	r_PtxRegister655 = uint32_t(r_LaneIndexAtPtx1206) - uint32_t(r_PtxRegister654);			  // PTX L1212
	r_PtxRegister656 = ShiftLeft(uint32_t(r_PtxRegister655), uint32_t(1));					  // PTX L1213
	r_PtxRegister657 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister656);				  // PTX L1214
	r_PtxRegister658 = ShiftRight(uint32_t(r_PtxRegister657), uint32_t(31));				  // PTX L1215
	r_PtxRegister659 = uint32_t(r_PtxRegister657) + uint32_t(r_PtxRegister658);				  // PTX L1216
	r_PtxRegister660 = ShiftRightSigned(int32_t(r_PtxRegister659), uint32_t(1));			  // PTX L1217
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister660)) * int64_t(int32_t(4))); // PTX L1218
	g_RecordByteAddressAtPtx1219 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register135); // PTX L1219
	r_PtxRegister284 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1219 + 1048576ull);		  // PTX L1220
	r_LaneIndexAtPtx1222 = uint32_t((threadIdx.x & 31u));									  // PTX L1222
	r_PtxRegister661 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1222), uint32_t(31));		  // PTX L1224
	r_PtxRegister662 = ShiftRight(uint32_t(r_PtxRegister661), uint32_t(30));				  // PTX L1225
	r_PtxRegister663 = uint32_t(r_LaneIndexAtPtx1222) + uint32_t(r_PtxRegister662);			  // PTX L1226
	r_PtxRegister664 = r_PtxRegister663 & 2147483644;										  // PTX L1227
	r_PtxRegister665 = uint32_t(r_LaneIndexAtPtx1222) - uint32_t(r_PtxRegister664);			  // PTX L1228
	r_PtxRegister666 = ShiftLeft(uint32_t(r_PtxRegister665), uint32_t(1));					  // PTX L1229
	r_PtxRegister667 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister666);				  // PTX L1230
	r_PtxRegister668 = ShiftRight(uint32_t(r_PtxRegister667), uint32_t(31));				  // PTX L1231
	r_PtxRegister669 = uint32_t(r_PtxRegister667) + uint32_t(r_PtxRegister668);				  // PTX L1232
	r_PtxRegister670 = ShiftRightSigned(int32_t(r_PtxRegister669), uint32_t(1));			  // PTX L1233
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister670)) * int64_t(int32_t(4))); // PTX L1234
	g_RecordByteAddressAtPtx1235 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register137); // PTX L1235
	r_PtxRegister287 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1235 + 1048576ull);		  // PTX L1236
	r_LaneIndexAtPtx1238 = uint32_t((threadIdx.x & 31u));									  // PTX L1238
	r_PtxRegister671 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1238), uint32_t(31));		  // PTX L1240
	r_PtxRegister672 = ShiftRight(uint32_t(r_PtxRegister671), uint32_t(30));				  // PTX L1241
	r_PtxRegister673 = uint32_t(r_LaneIndexAtPtx1238) + uint32_t(r_PtxRegister672);			  // PTX L1242
	r_PtxRegister674 = r_PtxRegister673 & 2147483644;										  // PTX L1243
	r_PtxRegister675 = uint32_t(r_LaneIndexAtPtx1238) - uint32_t(r_PtxRegister674);			  // PTX L1244
	r_PtxRegister676 = ShiftLeft(uint32_t(r_PtxRegister675), uint32_t(1));					  // PTX L1245
	r_PtxRegister677 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister676);				  // PTX L1246
	r_PtxRegister678 = ShiftRightSigned(int32_t(r_PtxRegister677), uint32_t(1));			  // PTX L1247
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister678)) * int64_t(int32_t(4))); // PTX L1248
	g_RecordByteAddressAtPtx1249 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register139); // PTX L1249
	r_PtxRegister290 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1249 + 1048576ull);		  // PTX L1250
	r_LaneIndexAtPtx1252 = uint32_t((threadIdx.x & 31u));									  // PTX L1252
	r_PtxRegister679 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1252), uint32_t(31));		  // PTX L1254
	r_PtxRegister680 = ShiftRight(uint32_t(r_PtxRegister679), uint32_t(30));				  // PTX L1255
	r_PtxRegister681 = uint32_t(r_LaneIndexAtPtx1252) + uint32_t(r_PtxRegister680);			  // PTX L1256
	r_PtxRegister682 = r_PtxRegister681 & 2147483644;										  // PTX L1257
	r_PtxRegister683 = uint32_t(r_LaneIndexAtPtx1252) - uint32_t(r_PtxRegister682);			  // PTX L1258
	r_PtxRegister684 = ShiftLeft(uint32_t(r_PtxRegister683), uint32_t(1));					  // PTX L1259
	r_PtxRegister685 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister684);				  // PTX L1260
	r_PtxRegister686 = ShiftRightSigned(int32_t(r_PtxRegister685), uint32_t(1));			  // PTX L1261
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister686)) * int64_t(int32_t(4))); // PTX L1262
	g_RecordByteAddressAtPtx1263 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register141); // PTX L1263
	r_PtxRegister293 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1263 + 1048576ull);		  // PTX L1264
	r_LaneIndexAtPtx1266 = uint32_t((threadIdx.x & 31u));									  // PTX L1266
	r_PtxRegister687 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1266), uint32_t(31));		  // PTX L1268
	r_PtxRegister688 = ShiftRight(uint32_t(r_PtxRegister687), uint32_t(30));				  // PTX L1269
	r_PtxRegister689 = uint32_t(r_LaneIndexAtPtx1266) + uint32_t(r_PtxRegister688);			  // PTX L1270
	r_PtxRegister690 = r_PtxRegister689 & 2147483644;										  // PTX L1271
	r_PtxRegister691 = uint32_t(r_LaneIndexAtPtx1266) - uint32_t(r_PtxRegister690);			  // PTX L1272
	r_PtxRegister692 = ShiftLeft(uint32_t(r_PtxRegister691), uint32_t(1));					  // PTX L1273
	r_PtxRegister693 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister692);				  // PTX L1274
	r_PtxRegister694 = ShiftRightSigned(int32_t(r_PtxRegister693), uint32_t(1));			  // PTX L1275
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister694)) * int64_t(int32_t(4))); // PTX L1276
	g_RecordByteAddressAtPtx1277 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register143); // PTX L1277
	r_PtxRegister296 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1277 + 1048576ull);		  // PTX L1278
	r_LaneIndexAtPtx1280 = uint32_t((threadIdx.x & 31u));									  // PTX L1280
	r_PtxRegister695 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1280), uint32_t(31));		  // PTX L1282
	r_PtxRegister696 = ShiftRight(uint32_t(r_PtxRegister695), uint32_t(30));				  // PTX L1283
	r_PtxRegister697 = uint32_t(r_LaneIndexAtPtx1280) + uint32_t(r_PtxRegister696);			  // PTX L1284
	r_PtxRegister698 = r_PtxRegister697 & 2147483644;										  // PTX L1285
	r_PtxRegister699 = uint32_t(r_LaneIndexAtPtx1280) - uint32_t(r_PtxRegister698);			  // PTX L1286
	r_PtxRegister700 = ShiftLeft(uint32_t(r_PtxRegister699), uint32_t(1));					  // PTX L1287
	r_PtxRegister701 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister700);				  // PTX L1288
	r_PtxRegister702 = ShiftRightSigned(int32_t(r_PtxRegister701), uint32_t(1));			  // PTX L1289
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister702)) * int64_t(int32_t(4))); // PTX L1290
	g_RecordByteAddressAtPtx1291 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register145); // PTX L1291
	r_PtxRegister299 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1291 + 1048576ull);		  // PTX L1292
	r_LaneIndexAtPtx1294 = uint32_t((threadIdx.x & 31u));									  // PTX L1294
	r_PtxRegister703 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1294), uint32_t(31));		  // PTX L1296
	r_PtxRegister704 = ShiftRight(uint32_t(r_PtxRegister703), uint32_t(30));				  // PTX L1297
	r_PtxRegister705 = uint32_t(r_LaneIndexAtPtx1294) + uint32_t(r_PtxRegister704);			  // PTX L1298
	r_PtxRegister706 = r_PtxRegister705 & 2147483644;										  // PTX L1299
	r_PtxRegister707 = uint32_t(r_LaneIndexAtPtx1294) - uint32_t(r_PtxRegister706);			  // PTX L1300
	r_PtxRegister708 = ShiftLeft(uint32_t(r_PtxRegister707), uint32_t(1));					  // PTX L1301
	r_PtxRegister709 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister708);				  // PTX L1302
	r_PtxRegister710 = ShiftRightSigned(int32_t(r_PtxRegister709), uint32_t(1));			  // PTX L1303
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister710)) * int64_t(int32_t(4))); // PTX L1304
	g_RecordByteAddressAtPtx1305 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register147); // PTX L1305
	r_PtxRegister302 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1305 + 1048576ull);		  // PTX L1306
	r_LaneIndexAtPtx1308 = uint32_t((threadIdx.x & 31u));									  // PTX L1308
	r_PtxRegister711 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1308), uint32_t(31));		  // PTX L1310
	r_PtxRegister712 = ShiftRight(uint32_t(r_PtxRegister711), uint32_t(30));				  // PTX L1311
	r_PtxRegister713 = uint32_t(r_LaneIndexAtPtx1308) + uint32_t(r_PtxRegister712);			  // PTX L1312
	r_PtxRegister714 = r_PtxRegister713 & 2147483644;										  // PTX L1313
	r_PtxRegister715 = uint32_t(r_LaneIndexAtPtx1308) - uint32_t(r_PtxRegister714);			  // PTX L1314
	r_PtxRegister716 = ShiftLeft(uint32_t(r_PtxRegister715), uint32_t(1));					  // PTX L1315
	r_PtxRegister717 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister716);				  // PTX L1316
	r_PtxRegister718 = ShiftRightSigned(int32_t(r_PtxRegister717), uint32_t(1));			  // PTX L1317
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister718)) * int64_t(int32_t(4))); // PTX L1318
	g_RecordByteAddressAtPtx1319 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register149); // PTX L1319
	r_PtxRegister305 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1319 + 1048576ull);		  // PTX L1320
	r_LaneIndexAtPtx1322 = uint32_t((threadIdx.x & 31u));									  // PTX L1322
	r_PtxRegister719 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1322), uint32_t(31));		  // PTX L1324
	r_PtxRegister720 = ShiftRight(uint32_t(r_PtxRegister719), uint32_t(30));				  // PTX L1325
	r_PtxRegister721 = uint32_t(r_LaneIndexAtPtx1322) + uint32_t(r_PtxRegister720);			  // PTX L1326
	r_PtxRegister722 = r_PtxRegister721 & 2147483644;										  // PTX L1327
	r_PtxRegister723 = uint32_t(r_LaneIndexAtPtx1322) - uint32_t(r_PtxRegister722);			  // PTX L1328
	r_PtxRegister724 = ShiftLeft(uint32_t(r_PtxRegister723), uint32_t(1));					  // PTX L1329
	r_PtxRegister725 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister724);				  // PTX L1330
	r_PtxRegister726 = ShiftRight(uint32_t(r_PtxRegister725), uint32_t(31));				  // PTX L1331
	r_PtxRegister727 = uint32_t(r_PtxRegister725) + uint32_t(r_PtxRegister726);				  // PTX L1332
	r_PtxRegister728 = ShiftRightSigned(int32_t(r_PtxRegister727), uint32_t(1));			  // PTX L1333
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister728)) * int64_t(int32_t(4))); // PTX L1334
	g_RecordByteAddressAtPtx1335 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register151); // PTX L1335
	r_PtxRegister308 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1335 + 1048576ull);		  // PTX L1336
	r_LaneIndexAtPtx1338 = uint32_t((threadIdx.x & 31u));									  // PTX L1338
	r_PtxRegister729 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1338), uint32_t(31));		  // PTX L1340
	r_PtxRegister730 = ShiftRight(uint32_t(r_PtxRegister729), uint32_t(30));				  // PTX L1341
	r_PtxRegister731 = uint32_t(r_LaneIndexAtPtx1338) + uint32_t(r_PtxRegister730);			  // PTX L1342
	r_PtxRegister732 = r_PtxRegister731 & 2147483644;										  // PTX L1343
	r_PtxRegister733 = uint32_t(r_LaneIndexAtPtx1338) - uint32_t(r_PtxRegister732);			  // PTX L1344
	r_PtxRegister734 = ShiftLeft(uint32_t(r_PtxRegister733), uint32_t(1));					  // PTX L1345
	r_PtxRegister735 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister734);				  // PTX L1346
	r_PtxRegister736 = ShiftRight(uint32_t(r_PtxRegister735), uint32_t(31));				  // PTX L1347
	r_PtxRegister737 = uint32_t(r_PtxRegister735) + uint32_t(r_PtxRegister736);				  // PTX L1348
	r_PtxRegister738 = ShiftRightSigned(int32_t(r_PtxRegister737), uint32_t(1));			  // PTX L1349
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister738)) * int64_t(int32_t(4))); // PTX L1350
	g_RecordByteAddressAtPtx1351 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register153); // PTX L1351
	r_PtxRegister311 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1351 + 1048576ull);		  // PTX L1352
	r_LaneIndexAtPtx1354 = uint32_t((threadIdx.x & 31u));									  // PTX L1354
	r_PtxRegister739 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1354), uint32_t(31));		  // PTX L1356
	r_PtxRegister740 = ShiftRight(uint32_t(r_PtxRegister739), uint32_t(30));				  // PTX L1357
	r_PtxRegister741 = uint32_t(r_LaneIndexAtPtx1354) + uint32_t(r_PtxRegister740);			  // PTX L1358
	r_PtxRegister742 = r_PtxRegister741 & 2147483644;										  // PTX L1359
	r_PtxRegister743 = uint32_t(r_LaneIndexAtPtx1354) - uint32_t(r_PtxRegister742);			  // PTX L1360
	r_PtxRegister744 = ShiftLeft(uint32_t(r_PtxRegister743), uint32_t(1));					  // PTX L1361
	r_PtxRegister745 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister744);				  // PTX L1362
	r_PtxRegister746 = ShiftRightSigned(int32_t(r_PtxRegister745), uint32_t(1));			  // PTX L1363
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister746)) * int64_t(int32_t(4))); // PTX L1364
	g_RecordByteAddressAtPtx1365 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register155); // PTX L1365
	r_PtxRegister314 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1365 + 1048576ull);		  // PTX L1366
	r_LaneIndexAtPtx1368 = uint32_t((threadIdx.x & 31u));									  // PTX L1368
	r_PtxRegister747 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1368), uint32_t(31));		  // PTX L1370
	r_PtxRegister748 = ShiftRight(uint32_t(r_PtxRegister747), uint32_t(30));				  // PTX L1371
	r_PtxRegister749 = uint32_t(r_LaneIndexAtPtx1368) + uint32_t(r_PtxRegister748);			  // PTX L1372
	r_PtxRegister750 = r_PtxRegister749 & 2147483644;										  // PTX L1373
	r_PtxRegister751 = uint32_t(r_LaneIndexAtPtx1368) - uint32_t(r_PtxRegister750);			  // PTX L1374
	r_PtxRegister752 = ShiftLeft(uint32_t(r_PtxRegister751), uint32_t(1));					  // PTX L1375
	r_PtxRegister753 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister752);				  // PTX L1376
	r_PtxRegister754 = ShiftRightSigned(int32_t(r_PtxRegister753), uint32_t(1));			  // PTX L1377
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister754)) * int64_t(int32_t(4))); // PTX L1378
	g_RecordByteAddressAtPtx1379 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register157); // PTX L1379
	r_PtxRegister317 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1379 + 1048576ull);		  // PTX L1380
	r_LaneIndexAtPtx1382 = uint32_t((threadIdx.x & 31u));									  // PTX L1382
	r_PtxRegister755 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1382), uint32_t(31));		  // PTX L1384
	r_PtxRegister756 = ShiftRight(uint32_t(r_PtxRegister755), uint32_t(30));				  // PTX L1385
	r_PtxRegister757 = uint32_t(r_LaneIndexAtPtx1382) + uint32_t(r_PtxRegister756);			  // PTX L1386
	r_PtxRegister758 = r_PtxRegister757 & 2147483644;										  // PTX L1387
	r_PtxRegister759 = uint32_t(r_LaneIndexAtPtx1382) - uint32_t(r_PtxRegister758);			  // PTX L1388
	r_PtxRegister760 = ShiftLeft(uint32_t(r_PtxRegister759), uint32_t(1));					  // PTX L1389
	r_PtxRegister761 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister760);				  // PTX L1390
	r_PtxRegister762 = ShiftRight(uint32_t(r_PtxRegister761), uint32_t(31));				  // PTX L1391
	r_PtxRegister763 = uint32_t(r_PtxRegister761) + uint32_t(r_PtxRegister762);				  // PTX L1392
	r_PtxRegister764 = ShiftRightSigned(int32_t(r_PtxRegister763), uint32_t(1));			  // PTX L1393
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister764)) * int64_t(int32_t(4))); // PTX L1394
	g_RecordByteAddressAtPtx1395 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register159); // PTX L1395
	r_PtxRegister320 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1395 + 1048576ull);		  // PTX L1396
	r_LaneIndexAtPtx1398 = uint32_t((threadIdx.x & 31u));									  // PTX L1398
	r_PtxRegister765 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1398), uint32_t(31));		  // PTX L1400
	r_PtxRegister766 = ShiftRight(uint32_t(r_PtxRegister765), uint32_t(30));				  // PTX L1401
	r_PtxRegister767 = uint32_t(r_LaneIndexAtPtx1398) + uint32_t(r_PtxRegister766);			  // PTX L1402
	r_PtxRegister768 = r_PtxRegister767 & 2147483644;										  // PTX L1403
	r_PtxRegister769 = uint32_t(r_LaneIndexAtPtx1398) - uint32_t(r_PtxRegister768);			  // PTX L1404
	r_PtxRegister770 = ShiftLeft(uint32_t(r_PtxRegister769), uint32_t(1));					  // PTX L1405
	r_PtxRegister771 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister770);				  // PTX L1406
	r_PtxRegister772 = ShiftRight(uint32_t(r_PtxRegister771), uint32_t(31));				  // PTX L1407
	r_PtxRegister773 = uint32_t(r_PtxRegister771) + uint32_t(r_PtxRegister772);				  // PTX L1408
	r_PtxRegister774 = ShiftRightSigned(int32_t(r_PtxRegister773), uint32_t(1));			  // PTX L1409
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister774)) * int64_t(int32_t(4))); // PTX L1410
	g_RecordByteAddressAtPtx1411 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register161); // PTX L1411
	r_PtxRegister323 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1411 + 1048576ull);		  // PTX L1412
	r_LaneIndexAtPtx1414 = uint32_t((threadIdx.x & 31u));									  // PTX L1414
	r_PtxRegister775 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1414), uint32_t(31));		  // PTX L1416
	r_PtxRegister776 = ShiftRight(uint32_t(r_PtxRegister775), uint32_t(30));				  // PTX L1417
	r_PtxRegister777 = uint32_t(r_LaneIndexAtPtx1414) + uint32_t(r_PtxRegister776);			  // PTX L1418
	r_PtxRegister778 = r_PtxRegister777 & 2147483644;										  // PTX L1419
	r_PtxRegister779 = uint32_t(r_LaneIndexAtPtx1414) - uint32_t(r_PtxRegister778);			  // PTX L1420
	r_PtxRegister780 = ShiftLeft(uint32_t(r_PtxRegister779), uint32_t(1));					  // PTX L1421
	r_PtxRegister781 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister780);				  // PTX L1422
	r_PtxRegister782 = ShiftRightSigned(int32_t(r_PtxRegister781), uint32_t(1));			  // PTX L1423
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister782)) * int64_t(int32_t(4))); // PTX L1424
	g_RecordByteAddressAtPtx1425 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register163); // PTX L1425
	r_PtxRegister326 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1425 + 1048576ull);		  // PTX L1426
	r_LaneIndexAtPtx1428 = uint32_t((threadIdx.x & 31u));									  // PTX L1428
	r_PtxRegister783 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1428), uint32_t(31));		  // PTX L1430
	r_PtxRegister784 = ShiftRight(uint32_t(r_PtxRegister783), uint32_t(30));				  // PTX L1431
	r_PtxRegister785 = uint32_t(r_LaneIndexAtPtx1428) + uint32_t(r_PtxRegister784);			  // PTX L1432
	r_PtxRegister786 = r_PtxRegister785 & 2147483644;										  // PTX L1433
	r_PtxRegister787 = uint32_t(r_LaneIndexAtPtx1428) - uint32_t(r_PtxRegister786);			  // PTX L1434
	r_PtxRegister788 = ShiftLeft(uint32_t(r_PtxRegister787), uint32_t(1));					  // PTX L1435
	r_PtxRegister789 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister788);				  // PTX L1436
	r_PtxRegister790 = ShiftRightSigned(int32_t(r_PtxRegister789), uint32_t(1));			  // PTX L1437
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister790)) * int64_t(int32_t(4))); // PTX L1438
	g_RecordByteAddressAtPtx1439 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register165); // PTX L1439
	r_PtxRegister329 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1439 + 1048576ull);		  // PTX L1440
	r_LaneIndexAtPtx1442 = uint32_t((threadIdx.x & 31u));									  // PTX L1442
	r_PtxRegister791 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1442), uint32_t(31));		  // PTX L1444
	r_PtxRegister792 = ShiftRight(uint32_t(r_PtxRegister791), uint32_t(30));				  // PTX L1445
	r_PtxRegister793 = uint32_t(r_LaneIndexAtPtx1442) + uint32_t(r_PtxRegister792);			  // PTX L1446
	r_PtxRegister794 = r_PtxRegister793 & 2147483644;										  // PTX L1447
	r_PtxRegister795 = uint32_t(r_LaneIndexAtPtx1442) - uint32_t(r_PtxRegister794);			  // PTX L1448
	r_PtxRegister796 = ShiftLeft(uint32_t(r_PtxRegister795), uint32_t(1));					  // PTX L1449
	r_PtxRegister797 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister796);				  // PTX L1450
	r_PtxRegister798 = ShiftRight(uint32_t(r_PtxRegister797), uint32_t(31));				  // PTX L1451
	r_PtxRegister799 = uint32_t(r_PtxRegister797) + uint32_t(r_PtxRegister798);				  // PTX L1452
	r_PtxRegister800 = ShiftRightSigned(int32_t(r_PtxRegister799), uint32_t(1));			  // PTX L1453
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister800)) * int64_t(int32_t(4))); // PTX L1454
	g_RecordByteAddressAtPtx1455 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register167); // PTX L1455
	r_PtxRegister332 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1455 + 1048576ull);		  // PTX L1456
	r_LaneIndexAtPtx1458 = uint32_t((threadIdx.x & 31u));									  // PTX L1458
	r_PtxRegister801 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1458), uint32_t(31));		  // PTX L1460
	r_PtxRegister802 = ShiftRight(uint32_t(r_PtxRegister801), uint32_t(30));				  // PTX L1461
	r_PtxRegister803 = uint32_t(r_LaneIndexAtPtx1458) + uint32_t(r_PtxRegister802);			  // PTX L1462
	r_PtxRegister804 = r_PtxRegister803 & 2147483644;										  // PTX L1463
	r_PtxRegister805 = uint32_t(r_LaneIndexAtPtx1458) - uint32_t(r_PtxRegister804);			  // PTX L1464
	r_PtxRegister806 = ShiftLeft(uint32_t(r_PtxRegister805), uint32_t(1));					  // PTX L1465
	r_PtxRegister807 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister806);				  // PTX L1466
	r_PtxRegister808 = ShiftRight(uint32_t(r_PtxRegister807), uint32_t(31));				  // PTX L1467
	r_PtxRegister809 = uint32_t(r_PtxRegister807) + uint32_t(r_PtxRegister808);				  // PTX L1468
	r_PtxRegister810 = ShiftRightSigned(int32_t(r_PtxRegister809), uint32_t(1));			  // PTX L1469
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister810)) * int64_t(int32_t(4))); // PTX L1470
	g_RecordByteAddressAtPtx1471 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register169); // PTX L1471
	r_PtxRegister335 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1471 + 1048576ull);		  // PTX L1472
	r_LaneIndexAtPtx1474 = uint32_t((threadIdx.x & 31u));									  // PTX L1474
	r_PtxRegister811 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1474), uint32_t(31));		  // PTX L1476
	r_PtxRegister812 = ShiftRight(uint32_t(r_PtxRegister811), uint32_t(30));				  // PTX L1477
	r_PtxRegister813 = uint32_t(r_LaneIndexAtPtx1474) + uint32_t(r_PtxRegister812);			  // PTX L1478
	r_PtxRegister814 = r_PtxRegister813 & 2147483644;										  // PTX L1479
	r_PtxRegister815 = uint32_t(r_LaneIndexAtPtx1474) - uint32_t(r_PtxRegister814);			  // PTX L1480
	r_PtxRegister816 = ShiftLeft(uint32_t(r_PtxRegister815), uint32_t(1));					  // PTX L1481
	r_PtxRegister817 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister816);				  // PTX L1482
	r_PtxRegister818 = ShiftRightSigned(int32_t(r_PtxRegister817), uint32_t(1));			  // PTX L1483
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister818)) * int64_t(int32_t(4))); // PTX L1484
	g_RecordByteAddressAtPtx1485 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register171); // PTX L1485
	r_PtxRegister338 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1485 + 1048576ull);		  // PTX L1486
	r_LaneIndexAtPtx1488 = uint32_t((threadIdx.x & 31u));									  // PTX L1488
	r_PtxRegister819 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1488), uint32_t(31));		  // PTX L1490
	r_PtxRegister820 = ShiftRight(uint32_t(r_PtxRegister819), uint32_t(30));				  // PTX L1491
	r_PtxRegister821 = uint32_t(r_LaneIndexAtPtx1488) + uint32_t(r_PtxRegister820);			  // PTX L1492
	r_PtxRegister822 = r_PtxRegister821 & 2147483644;										  // PTX L1493
	r_PtxRegister823 = uint32_t(r_LaneIndexAtPtx1488) - uint32_t(r_PtxRegister822);			  // PTX L1494
	r_PtxRegister824 = ShiftLeft(uint32_t(r_PtxRegister823), uint32_t(1));					  // PTX L1495
	r_PtxRegister825 = uint32_t(r_PtxRegister6) + uint32_t(r_PtxRegister824);				  // PTX L1496
	r_PtxRegister826 = ShiftRightSigned(int32_t(r_PtxRegister825), uint32_t(1));			  // PTX L1497
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister826)) * int64_t(int32_t(4))); // PTX L1498
	g_RecordByteAddressAtPtx1499 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register173); // PTX L1499
	r_PtxRegister341 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1499 + 1048576ull);		  // PTX L1500
	r_LaneIndexAtPtx1502 = uint32_t((threadIdx.x & 31u));									  // PTX L1502
	r_PtxRegister827 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1502), uint32_t(31));		  // PTX L1504
	r_PtxRegister828 = ShiftRight(uint32_t(r_PtxRegister827), uint32_t(30));				  // PTX L1505
	r_PtxRegister829 = uint32_t(r_LaneIndexAtPtx1502) + uint32_t(r_PtxRegister828);			  // PTX L1506
	r_PtxRegister830 = r_PtxRegister829 & 2147483644;										  // PTX L1507
	r_PtxRegister831 = uint32_t(r_LaneIndexAtPtx1502) - uint32_t(r_PtxRegister830);			  // PTX L1508
	r_PtxRegister832 = ShiftLeft(uint32_t(r_PtxRegister831), uint32_t(1));					  // PTX L1509
	r_PtxRegister833 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister832);				  // PTX L1510
	r_PtxRegister834 = ShiftRightSigned(int32_t(r_PtxRegister833), uint32_t(1));			  // PTX L1511
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister834)) * int64_t(int32_t(4))); // PTX L1512
	g_RecordByteAddressAtPtx1513 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register175); // PTX L1513
	r_PtxRegister344 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1513 + 1048576ull);		  // PTX L1514
	r_LaneIndexAtPtx1516 = uint32_t((threadIdx.x & 31u));									  // PTX L1516
	r_PtxRegister835 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1516), uint32_t(31));		  // PTX L1518
	r_PtxRegister836 = ShiftRight(uint32_t(r_PtxRegister835), uint32_t(30));				  // PTX L1519
	r_PtxRegister837 = uint32_t(r_LaneIndexAtPtx1516) + uint32_t(r_PtxRegister836);			  // PTX L1520
	r_PtxRegister838 = r_PtxRegister837 & 2147483644;										  // PTX L1521
	r_PtxRegister839 = uint32_t(r_LaneIndexAtPtx1516) - uint32_t(r_PtxRegister838);			  // PTX L1522
	r_PtxRegister840 = ShiftLeft(uint32_t(r_PtxRegister839), uint32_t(1));					  // PTX L1523
	r_PtxRegister841 = uint32_t(r_PtxRegister384) + uint32_t(r_PtxRegister840);				  // PTX L1524
	r_PtxRegister842 = ShiftRightSigned(int32_t(r_PtxRegister841), uint32_t(1));			  // PTX L1525
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister842)) * int64_t(int32_t(4))); // PTX L1526
	g_RecordByteAddressAtPtx1527 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register177); // PTX L1527
	r_PtxRegister347 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1527 + 1048576ull);		  // PTX L1528
	r_LaneIndexAtPtx1530 = uint32_t((threadIdx.x & 31u));									  // PTX L1530
	r_PtxRegister843 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1530), uint32_t(31));		  // PTX L1532
	r_PtxRegister844 = ShiftRight(uint32_t(r_PtxRegister843), uint32_t(30));				  // PTX L1533
	r_PtxRegister845 = uint32_t(r_LaneIndexAtPtx1530) + uint32_t(r_PtxRegister844);			  // PTX L1534
	r_PtxRegister846 = r_PtxRegister845 & 2147483644;										  // PTX L1535
	r_PtxRegister847 = uint32_t(r_LaneIndexAtPtx1530) - uint32_t(r_PtxRegister846);			  // PTX L1536
	r_PtxRegister848 = ShiftLeft(uint32_t(r_PtxRegister847), uint32_t(1));					  // PTX L1537
	r_PtxRegister849 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister848);				  // PTX L1538
	r_PtxRegister850 = ShiftRightSigned(int32_t(r_PtxRegister849), uint32_t(1));			  // PTX L1539
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister850)) * int64_t(int32_t(4))); // PTX L1540
	g_RecordByteAddressAtPtx1541 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register179); // PTX L1541
	r_PtxRegister350 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1541 + 1048576ull);		  // PTX L1542
	r_LaneIndexAtPtx1544 = uint32_t((threadIdx.x & 31u));									  // PTX L1544
	r_PtxRegister851 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1544), uint32_t(31));		  // PTX L1546
	r_PtxRegister852 = ShiftRight(uint32_t(r_PtxRegister851), uint32_t(30));				  // PTX L1547
	r_PtxRegister853 = uint32_t(r_LaneIndexAtPtx1544) + uint32_t(r_PtxRegister852);			  // PTX L1548
	r_PtxRegister854 = r_PtxRegister853 & 2147483644;										  // PTX L1549
	r_PtxRegister855 = uint32_t(r_LaneIndexAtPtx1544) - uint32_t(r_PtxRegister854);			  // PTX L1550
	r_PtxRegister856 = ShiftLeft(uint32_t(r_PtxRegister855), uint32_t(1));					  // PTX L1551
	r_PtxRegister857 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister856);				  // PTX L1552
	r_PtxRegister858 = ShiftRightSigned(int32_t(r_PtxRegister857), uint32_t(1));			  // PTX L1553
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister858)) * int64_t(int32_t(4))); // PTX L1554
	g_RecordByteAddressAtPtx1555 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register181); // PTX L1555
	r_PtxRegister353 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1555 + 1048576ull);		  // PTX L1556
	r_LaneIndexAtPtx1558 = uint32_t((threadIdx.x & 31u));									  // PTX L1558
	r_PtxRegister859 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1558), uint32_t(31));		  // PTX L1560
	r_PtxRegister860 = ShiftRight(uint32_t(r_PtxRegister859), uint32_t(30));				  // PTX L1561
	r_PtxRegister861 = uint32_t(r_LaneIndexAtPtx1558) + uint32_t(r_PtxRegister860);			  // PTX L1562
	r_PtxRegister862 = r_PtxRegister861 & 2147483644;										  // PTX L1563
	r_PtxRegister863 = uint32_t(r_LaneIndexAtPtx1558) - uint32_t(r_PtxRegister862);			  // PTX L1564
	r_PtxRegister864 = ShiftLeft(uint32_t(r_PtxRegister863), uint32_t(1));					  // PTX L1565
	r_PtxRegister865 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister864);				  // PTX L1566
	r_PtxRegister866 = ShiftRight(uint32_t(r_PtxRegister865), uint32_t(31));				  // PTX L1567
	r_PtxRegister867 = uint32_t(r_PtxRegister865) + uint32_t(r_PtxRegister866);				  // PTX L1568
	r_PtxRegister868 = ShiftRightSigned(int32_t(r_PtxRegister867), uint32_t(1));			  // PTX L1569
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister868)) * int64_t(int32_t(4))); // PTX L1570
	g_RecordByteAddressAtPtx1571 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register183); // PTX L1571
	r_PtxRegister356 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1571 + 1048576ull);		  // PTX L1572
	r_LaneIndexAtPtx1574 = uint32_t((threadIdx.x & 31u));									  // PTX L1574
	r_PtxRegister869 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1574), uint32_t(31));		  // PTX L1576
	r_PtxRegister870 = ShiftRight(uint32_t(r_PtxRegister869), uint32_t(30));				  // PTX L1577
	r_PtxRegister871 = uint32_t(r_LaneIndexAtPtx1574) + uint32_t(r_PtxRegister870);			  // PTX L1578
	r_PtxRegister872 = r_PtxRegister871 & 2147483644;										  // PTX L1579
	r_PtxRegister873 = uint32_t(r_LaneIndexAtPtx1574) - uint32_t(r_PtxRegister872);			  // PTX L1580
	r_PtxRegister874 = ShiftLeft(uint32_t(r_PtxRegister873), uint32_t(1));					  // PTX L1581
	r_PtxRegister875 = uint32_t(r_PtxRegister440) + uint32_t(r_PtxRegister874);				  // PTX L1582
	r_PtxRegister876 = ShiftRight(uint32_t(r_PtxRegister875), uint32_t(31));				  // PTX L1583
	r_PtxRegister877 = uint32_t(r_PtxRegister875) + uint32_t(r_PtxRegister876);				  // PTX L1584
	r_PtxRegister878 = ShiftRightSigned(int32_t(r_PtxRegister877), uint32_t(1));			  // PTX L1585
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister878)) * int64_t(int32_t(4))); // PTX L1586
	g_RecordByteAddressAtPtx1587 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register185); // PTX L1587
	r_PtxRegister359 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1587 + 1048576ull);		  // PTX L1588
	r_LaneIndexAtPtx1590 = uint32_t((threadIdx.x & 31u));									  // PTX L1590
	r_PtxRegister879 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1590), uint32_t(31));		  // PTX L1592
	r_PtxRegister880 = ShiftRight(uint32_t(r_PtxRegister879), uint32_t(30));				  // PTX L1593
	r_PtxRegister881 = uint32_t(r_LaneIndexAtPtx1590) + uint32_t(r_PtxRegister880);			  // PTX L1594
	r_PtxRegister882 = r_PtxRegister881 & 2147483644;										  // PTX L1595
	r_PtxRegister883 = uint32_t(r_LaneIndexAtPtx1590) - uint32_t(r_PtxRegister882);			  // PTX L1596
	r_PtxRegister884 = ShiftLeft(uint32_t(r_PtxRegister883), uint32_t(1));					  // PTX L1597
	r_PtxRegister885 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister884);				  // PTX L1598
	r_PtxRegister886 = ShiftRightSigned(int32_t(r_PtxRegister885), uint32_t(1));			  // PTX L1599
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister886)) * int64_t(int32_t(4))); // PTX L1600
	g_RecordByteAddressAtPtx1601 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register187); // PTX L1601
	r_PtxRegister362 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1601 + 1048576ull);		  // PTX L1602
	r_LaneIndexAtPtx1604 = uint32_t((threadIdx.x & 31u));									  // PTX L1604
	r_PtxRegister887 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1604), uint32_t(31));		  // PTX L1606
	r_PtxRegister888 = ShiftRight(uint32_t(r_PtxRegister887), uint32_t(30));				  // PTX L1607
	r_PtxRegister889 = uint32_t(r_LaneIndexAtPtx1604) + uint32_t(r_PtxRegister888);			  // PTX L1608
	r_PtxRegister890 = r_PtxRegister889 & 2147483644;										  // PTX L1609
	r_PtxRegister891 = uint32_t(r_LaneIndexAtPtx1604) - uint32_t(r_PtxRegister890);			  // PTX L1610
	r_PtxRegister892 = ShiftLeft(uint32_t(r_PtxRegister891), uint32_t(1));					  // PTX L1611
	r_PtxRegister893 = uint32_t(r_PtxRegister461) + uint32_t(r_PtxRegister892);				  // PTX L1612
	r_PtxRegister894 = ShiftRightSigned(int32_t(r_PtxRegister893), uint32_t(1));			  // PTX L1613
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister894)) * int64_t(int32_t(4))); // PTX L1614
	g_RecordByteAddressAtPtx1615 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register189); // PTX L1615
	r_PtxRegister365 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1615 + 1048576ull);		  // PTX L1616
	r_LaneIndexAtPtx1618 = uint32_t((threadIdx.x & 31u));									  // PTX L1618
	r_PtxRegister895 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1618), uint32_t(31));		  // PTX L1620
	r_PtxRegister896 = ShiftRight(uint32_t(r_PtxRegister895), uint32_t(30));				  // PTX L1621
	r_PtxRegister897 = uint32_t(r_LaneIndexAtPtx1618) + uint32_t(r_PtxRegister896);			  // PTX L1622
	r_PtxRegister898 = r_PtxRegister897 & 2147483644;										  // PTX L1623
	r_PtxRegister899 = uint32_t(r_LaneIndexAtPtx1618) - uint32_t(r_PtxRegister898);			  // PTX L1624
	r_PtxRegister900 = ShiftLeft(uint32_t(r_PtxRegister899), uint32_t(1));					  // PTX L1625
	r_PtxRegister901 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister900);				  // PTX L1626
	r_PtxRegister902 = ShiftRight(uint32_t(r_PtxRegister901), uint32_t(31));				  // PTX L1627
	r_PtxRegister903 = uint32_t(r_PtxRegister901) + uint32_t(r_PtxRegister902);				  // PTX L1628
	r_PtxRegister904 = ShiftRightSigned(int32_t(r_PtxRegister903), uint32_t(1));			  // PTX L1629
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister904)) * int64_t(int32_t(4))); // PTX L1630
	g_RecordByteAddressAtPtx1631 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register191); // PTX L1631
	r_PtxRegister368 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1631 + 1048576ull);		  // PTX L1632
	r_LaneIndexAtPtx1634 = uint32_t((threadIdx.x & 31u));									  // PTX L1634
	r_PtxRegister905 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1634), uint32_t(31));		  // PTX L1636
	r_PtxRegister906 = ShiftRight(uint32_t(r_PtxRegister905), uint32_t(30));				  // PTX L1637
	r_PtxRegister907 = uint32_t(r_LaneIndexAtPtx1634) + uint32_t(r_PtxRegister906);			  // PTX L1638
	r_PtxRegister908 = r_PtxRegister907 & 2147483644;										  // PTX L1639
	r_PtxRegister909 = uint32_t(r_LaneIndexAtPtx1634) - uint32_t(r_PtxRegister908);			  // PTX L1640
	r_PtxRegister910 = ShiftLeft(uint32_t(r_PtxRegister909), uint32_t(1));					  // PTX L1641
	r_PtxRegister911 = uint32_t(r_PtxRegister478) + uint32_t(r_PtxRegister910);				  // PTX L1642
	r_PtxRegister912 = ShiftRight(uint32_t(r_PtxRegister911), uint32_t(31));				  // PTX L1643
	r_PtxRegister913 = uint32_t(r_PtxRegister911) + uint32_t(r_PtxRegister912);				  // PTX L1644
	r_PtxRegister914 = ShiftRightSigned(int32_t(r_PtxRegister913), uint32_t(1));			  // PTX L1645
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister914)) * int64_t(int32_t(4))); // PTX L1646
	g_RecordByteAddressAtPtx1647 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register193); // PTX L1647
	r_PtxRegister371 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1647 + 1048576ull);		  // PTX L1648
	r_LaneIndexAtPtx1650 = uint32_t((threadIdx.x & 31u));									  // PTX L1650
	r_PtxRegister915 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1650), uint32_t(31));		  // PTX L1652
	r_PtxRegister916 = ShiftRight(uint32_t(r_PtxRegister915), uint32_t(30));				  // PTX L1653
	r_PtxRegister917 = uint32_t(r_LaneIndexAtPtx1650) + uint32_t(r_PtxRegister916);			  // PTX L1654
	r_PtxRegister918 = r_PtxRegister917 & 2147483644;										  // PTX L1655
	r_PtxRegister919 = uint32_t(r_LaneIndexAtPtx1650) - uint32_t(r_PtxRegister918);			  // PTX L1656
	r_PtxRegister920 = ShiftLeft(uint32_t(r_PtxRegister919), uint32_t(1));					  // PTX L1657
	r_PtxRegister921 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister920);				  // PTX L1658
	r_PtxRegister922 = ShiftRightSigned(int32_t(r_PtxRegister921), uint32_t(1));			  // PTX L1659
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister922)) * int64_t(int32_t(4))); // PTX L1660
	g_RecordByteAddressAtPtx1661 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register195); // PTX L1661
	r_PtxRegister374 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1661 + 1048576ull);		  // PTX L1662
	r_LaneIndexAtPtx1664 = uint32_t((threadIdx.x & 31u));									  // PTX L1664
	r_PtxRegister923 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1664), uint32_t(31));		  // PTX L1666
	r_PtxRegister924 = ShiftRight(uint32_t(r_PtxRegister923), uint32_t(30));				  // PTX L1667
	r_PtxRegister925 = uint32_t(r_LaneIndexAtPtx1664) + uint32_t(r_PtxRegister924);			  // PTX L1668
	r_PtxRegister926 = r_PtxRegister925 & 2147483644;										  // PTX L1669
	r_PtxRegister927 = uint32_t(r_LaneIndexAtPtx1664) - uint32_t(r_PtxRegister926);			  // PTX L1670
	r_PtxRegister928 = ShiftLeft(uint32_t(r_PtxRegister927), uint32_t(1));					  // PTX L1671
	r_PtxRegister929 = uint32_t(r_PtxRegister499) + uint32_t(r_PtxRegister928);				  // PTX L1672
	r_PtxRegister930 = ShiftRightSigned(int32_t(r_PtxRegister929), uint32_t(1));			  // PTX L1673
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister930)) * int64_t(int32_t(4))); // PTX L1674
	g_RecordByteAddressAtPtx1675 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register197); // PTX L1675
	r_PtxRegister377 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1675 + 1048576ull);		  // PTX L1676
	r_LaneIndexAtPtx1678 = uint32_t((threadIdx.x & 31u));									  // PTX L1678
	r_PtxRegister931 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1678), uint32_t(31));		  // PTX L1680
	r_PtxRegister932 = ShiftRight(uint32_t(r_PtxRegister931), uint32_t(30));				  // PTX L1681
	r_PtxRegister933 = uint32_t(r_LaneIndexAtPtx1678) + uint32_t(r_PtxRegister932);			  // PTX L1682
	r_PtxRegister934 = r_PtxRegister933 & 2147483644;										  // PTX L1683
	r_PtxRegister935 = uint32_t(r_LaneIndexAtPtx1678) - uint32_t(r_PtxRegister934);			  // PTX L1684
	r_PtxRegister936 = ShiftLeft(uint32_t(r_PtxRegister935), uint32_t(1));					  // PTX L1685
	r_PtxRegister937 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister936);				  // PTX L1686
	r_PtxRegister938 = ShiftRight(uint32_t(r_PtxRegister937), uint32_t(31));				  // PTX L1687
	r_PtxRegister939 = uint32_t(r_PtxRegister937) + uint32_t(r_PtxRegister938);				  // PTX L1688
	r_PtxRegister940 = ShiftRightSigned(int32_t(r_PtxRegister939), uint32_t(1));			  // PTX L1689
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister940)) * int64_t(int32_t(4))); // PTX L1690
	g_RecordByteAddressAtPtx1691 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register199); // PTX L1691
	r_PtxRegister380 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1691 + 1048576ull);		  // PTX L1692
	r_LaneIndexAtPtx1694 = uint32_t((threadIdx.x & 31u));									  // PTX L1694
	r_PtxRegister941 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1694), uint32_t(31));		  // PTX L1696
	r_PtxRegister942 = ShiftRight(uint32_t(r_PtxRegister941), uint32_t(30));				  // PTX L1697
	r_PtxRegister943 = uint32_t(r_LaneIndexAtPtx1694) + uint32_t(r_PtxRegister942);			  // PTX L1698
	r_PtxRegister944 = r_PtxRegister943 & 2147483644;										  // PTX L1699
	r_PtxRegister945 = uint32_t(r_LaneIndexAtPtx1694) - uint32_t(r_PtxRegister944);			  // PTX L1700
	r_PtxRegister946 = ShiftLeft(uint32_t(r_PtxRegister945), uint32_t(1));					  // PTX L1701
	r_PtxRegister947 = uint32_t(r_PtxRegister516) + uint32_t(r_PtxRegister946);				  // PTX L1702
	r_PtxRegister948 = ShiftRight(uint32_t(r_PtxRegister947), uint32_t(31));				  // PTX L1703
	r_PtxRegister949 = uint32_t(r_PtxRegister947) + uint32_t(r_PtxRegister948);				  // PTX L1704
	r_PtxRegister950 = ShiftRightSigned(int32_t(r_PtxRegister949), uint32_t(1));			  // PTX L1705
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister950)) * int64_t(int32_t(4))); // PTX L1706
	g_RecordByteAddressAtPtx1707 =
		uint64_t(g_RecordByteAddressAtPtx757) + uint64_t(r_PtxU64Register201); // PTX L1707
	r_PtxRegister383 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1707 + 1048576ull); // PTX L1708
	r_LaneIndexAtPtx1710 = uint32_t((threadIdx.x & 31u));							   // PTX L1710
	r_PackedHalf2AtPtx290R1472 = HalfMul(r_PackedHalf2AtPtx562R193, r_PtxRegister194); // PTX L1713
	r_LaneIndexAtPtx1717 = uint32_t((threadIdx.x & 31u));							   // PTX L1717
	r_PackedHalf2AtPtx289R1471 = HalfMul(r_PackedHalf2AtPtx568R196, r_PtxRegister197); // PTX L1720
	r_LaneIndexAtPtx1724 = uint32_t((threadIdx.x & 31u));							   // PTX L1724
	r_PackedHalf2AtPtx288R1470 = HalfMul(r_PackedHalf2AtPtx565R199, r_PtxRegister200); // PTX L1727
	r_LaneIndexAtPtx1731 = uint32_t((threadIdx.x & 31u));							   // PTX L1731
	r_PackedHalf2AtPtx287R1469 = HalfMul(r_PackedHalf2AtPtx571R202, r_PtxRegister203); // PTX L1734
	r_LaneIndexAtPtx1738 = uint32_t((threadIdx.x & 31u));							   // PTX L1738
	r_PackedHalf2AtPtx286R1468 = HalfMul(r_PackedHalf2AtPtx574R205, r_PtxRegister206); // PTX L1741
	r_LaneIndexAtPtx1745 = uint32_t((threadIdx.x & 31u));							   // PTX L1745
	r_PackedHalf2AtPtx285R1467 = HalfMul(r_PackedHalf2AtPtx580R208, r_PtxRegister209); // PTX L1748
	r_LaneIndexAtPtx1752 = uint32_t((threadIdx.x & 31u));							   // PTX L1752
	r_PackedHalf2AtPtx284R1466 = HalfMul(r_PackedHalf2AtPtx577R211, r_PtxRegister212); // PTX L1755
	r_LaneIndexAtPtx1759 = uint32_t((threadIdx.x & 31u));							   // PTX L1759
	r_PackedHalf2AtPtx283R1465 = HalfMul(r_PackedHalf2AtPtx583R214, r_PtxRegister215); // PTX L1762
	r_LaneIndexAtPtx1766 = uint32_t((threadIdx.x & 31u));							   // PTX L1766
	r_PackedHalf2AtPtx282R1464 = HalfMul(r_PackedHalf2AtPtx586R217, r_PtxRegister218); // PTX L1769
	r_LaneIndexAtPtx1773 = uint32_t((threadIdx.x & 31u));							   // PTX L1773
	r_PackedHalf2AtPtx281R1463 = HalfMul(r_PackedHalf2AtPtx592R220, r_PtxRegister221); // PTX L1776
	r_LaneIndexAtPtx1780 = uint32_t((threadIdx.x & 31u));							   // PTX L1780
	r_PackedHalf2AtPtx280R1462 = HalfMul(r_PackedHalf2AtPtx589R223, r_PtxRegister224); // PTX L1783
	r_LaneIndexAtPtx1787 = uint32_t((threadIdx.x & 31u));							   // PTX L1787
	r_PackedHalf2AtPtx279R1461 = HalfMul(r_PackedHalf2AtPtx595R226, r_PtxRegister227); // PTX L1790
	r_LaneIndexAtPtx1794 = uint32_t((threadIdx.x & 31u));							   // PTX L1794
	r_PackedHalf2AtPtx278R1460 = HalfMul(r_PackedHalf2AtPtx598R229, r_PtxRegister230); // PTX L1797
	r_LaneIndexAtPtx1801 = uint32_t((threadIdx.x & 31u));							   // PTX L1801
	r_PackedHalf2AtPtx277R1459 = HalfMul(r_PackedHalf2AtPtx604R232, r_PtxRegister233); // PTX L1804
	r_LaneIndexAtPtx1808 = uint32_t((threadIdx.x & 31u));							   // PTX L1808
	r_PackedHalf2AtPtx276R1458 = HalfMul(r_PackedHalf2AtPtx601R235, r_PtxRegister236); // PTX L1811
	r_LaneIndexAtPtx1815 = uint32_t((threadIdx.x & 31u));							   // PTX L1815
	r_PackedHalf2AtPtx275R1457 = HalfMul(r_PackedHalf2AtPtx607R238, r_PtxRegister239); // PTX L1818
	r_LaneIndexAtPtx1822 = uint32_t((threadIdx.x & 31u));							   // PTX L1822
	r_PackedHalf2AtPtx274R1456 = HalfMul(r_PackedHalf2AtPtx610R241, r_PtxRegister242); // PTX L1825
	r_LaneIndexAtPtx1829 = uint32_t((threadIdx.x & 31u));							   // PTX L1829
	r_PackedHalf2AtPtx273R1455 = HalfMul(r_PackedHalf2AtPtx616R244, r_PtxRegister245); // PTX L1832
	r_LaneIndexAtPtx1836 = uint32_t((threadIdx.x & 31u));							   // PTX L1836
	r_PackedHalf2AtPtx272R1454 = HalfMul(r_PackedHalf2AtPtx613R247, r_PtxRegister248); // PTX L1839
	r_LaneIndexAtPtx1843 = uint32_t((threadIdx.x & 31u));							   // PTX L1843
	r_PackedHalf2AtPtx271R1453 = HalfMul(r_PackedHalf2AtPtx619R250, r_PtxRegister251); // PTX L1846
	r_LaneIndexAtPtx1850 = uint32_t((threadIdx.x & 31u));							   // PTX L1850
	r_PackedHalf2AtPtx270R1452 = HalfMul(r_PackedHalf2AtPtx622R253, r_PtxRegister254); // PTX L1853
	r_LaneIndexAtPtx1857 = uint32_t((threadIdx.x & 31u));							   // PTX L1857
	r_PackedHalf2AtPtx269R1451 = HalfMul(r_PackedHalf2AtPtx628R256, r_PtxRegister257); // PTX L1860
	r_LaneIndexAtPtx1864 = uint32_t((threadIdx.x & 31u));							   // PTX L1864
	r_PackedHalf2AtPtx268R1450 = HalfMul(r_PackedHalf2AtPtx625R259, r_PtxRegister260); // PTX L1867
	r_LaneIndexAtPtx1871 = uint32_t((threadIdx.x & 31u));							   // PTX L1871
	r_PackedHalf2AtPtx267R1449 = HalfMul(r_PackedHalf2AtPtx631R262, r_PtxRegister263); // PTX L1874
	r_LaneIndexAtPtx1878 = uint32_t((threadIdx.x & 31u));							   // PTX L1878
	r_PackedHalf2AtPtx266R1448 = HalfMul(r_PackedHalf2AtPtx634R265, r_PtxRegister266); // PTX L1881
	r_LaneIndexAtPtx1885 = uint32_t((threadIdx.x & 31u));							   // PTX L1885
	r_PackedHalf2AtPtx265R1447 = HalfMul(r_PackedHalf2AtPtx640R268, r_PtxRegister269); // PTX L1888
	r_LaneIndexAtPtx1892 = uint32_t((threadIdx.x & 31u));							   // PTX L1892
	r_PackedHalf2AtPtx264R1446 = HalfMul(r_PackedHalf2AtPtx637R271, r_PtxRegister272); // PTX L1895
	r_LaneIndexAtPtx1899 = uint32_t((threadIdx.x & 31u));							   // PTX L1899
	r_PackedHalf2AtPtx263R1445 = HalfMul(r_PackedHalf2AtPtx643R274, r_PtxRegister275); // PTX L1902
	r_LaneIndexAtPtx1906 = uint32_t((threadIdx.x & 31u));							   // PTX L1906
	r_PackedHalf2AtPtx262R1444 = HalfMul(r_PackedHalf2AtPtx646R277, r_PtxRegister278); // PTX L1909
	r_LaneIndexAtPtx1913 = uint32_t((threadIdx.x & 31u));							   // PTX L1913
	r_PackedHalf2AtPtx261R1443 = HalfMul(r_PackedHalf2AtPtx652R280, r_PtxRegister281); // PTX L1916
	r_LaneIndexAtPtx1920 = uint32_t((threadIdx.x & 31u));							   // PTX L1920
	r_PackedHalf2AtPtx260R1442 = HalfMul(r_PackedHalf2AtPtx649R283, r_PtxRegister284); // PTX L1923
	r_LaneIndexAtPtx1927 = uint32_t((threadIdx.x & 31u));							   // PTX L1927
	r_PackedHalf2AtPtx259R1441 = HalfMul(r_PackedHalf2AtPtx655R286, r_PtxRegister287); // PTX L1930
	r_LaneIndexAtPtx1934 = uint32_t((threadIdx.x & 31u));							   // PTX L1934
	r_PackedHalf2AtPtx258R1440 = HalfMul(r_PackedHalf2AtPtx658R289, r_PtxRegister290); // PTX L1937
	r_LaneIndexAtPtx1941 = uint32_t((threadIdx.x & 31u));							   // PTX L1941
	r_PackedHalf2AtPtx257R1439 = HalfMul(r_PackedHalf2AtPtx664R292, r_PtxRegister293); // PTX L1944
	r_LaneIndexAtPtx1948 = uint32_t((threadIdx.x & 31u));							   // PTX L1948
	r_PackedHalf2AtPtx256R1438 = HalfMul(r_PackedHalf2AtPtx661R295, r_PtxRegister296); // PTX L1951
	r_LaneIndexAtPtx1955 = uint32_t((threadIdx.x & 31u));							   // PTX L1955
	r_PackedHalf2AtPtx255R1437 = HalfMul(r_PackedHalf2AtPtx667R298, r_PtxRegister299); // PTX L1958
	r_LaneIndexAtPtx1962 = uint32_t((threadIdx.x & 31u));							   // PTX L1962
	r_PackedHalf2AtPtx254R1436 = HalfMul(r_PackedHalf2AtPtx670R301, r_PtxRegister302); // PTX L1965
	r_LaneIndexAtPtx1969 = uint32_t((threadIdx.x & 31u));							   // PTX L1969
	r_PackedHalf2AtPtx253R1435 = HalfMul(r_PackedHalf2AtPtx676R304, r_PtxRegister305); // PTX L1972
	r_LaneIndexAtPtx1976 = uint32_t((threadIdx.x & 31u));							   // PTX L1976
	r_PackedHalf2AtPtx252R1434 = HalfMul(r_PackedHalf2AtPtx673R307, r_PtxRegister308); // PTX L1979
	r_LaneIndexAtPtx1983 = uint32_t((threadIdx.x & 31u));							   // PTX L1983
	r_PackedHalf2AtPtx251R1433 = HalfMul(r_PackedHalf2AtPtx679R310, r_PtxRegister311); // PTX L1986
	r_LaneIndexAtPtx1990 = uint32_t((threadIdx.x & 31u));							   // PTX L1990
	r_PackedHalf2AtPtx250R1432 = HalfMul(r_PackedHalf2AtPtx682R313, r_PtxRegister314); // PTX L1993
	r_LaneIndexAtPtx1997 = uint32_t((threadIdx.x & 31u));							   // PTX L1997
	r_PackedHalf2AtPtx249R1431 = HalfMul(r_PackedHalf2AtPtx688R316, r_PtxRegister317); // PTX L2000
	r_LaneIndexAtPtx2004 = uint32_t((threadIdx.x & 31u));							   // PTX L2004
	r_PackedHalf2AtPtx248R1430 = HalfMul(r_PackedHalf2AtPtx685R319, r_PtxRegister320); // PTX L2007
	r_LaneIndexAtPtx2011 = uint32_t((threadIdx.x & 31u));							   // PTX L2011
	r_PackedHalf2AtPtx247R1429 = HalfMul(r_PackedHalf2AtPtx691R322, r_PtxRegister323); // PTX L2014
	r_LaneIndexAtPtx2018 = uint32_t((threadIdx.x & 31u));							   // PTX L2018
	r_PackedHalf2AtPtx246R1428 = HalfMul(r_PackedHalf2AtPtx694R325, r_PtxRegister326); // PTX L2021
	r_LaneIndexAtPtx2025 = uint32_t((threadIdx.x & 31u));							   // PTX L2025
	r_PackedHalf2AtPtx245R1427 = HalfMul(r_PackedHalf2AtPtx700R328, r_PtxRegister329); // PTX L2028
	r_LaneIndexAtPtx2032 = uint32_t((threadIdx.x & 31u));							   // PTX L2032
	r_PackedHalf2AtPtx244R1426 = HalfMul(r_PackedHalf2AtPtx697R331, r_PtxRegister332); // PTX L2035
	r_LaneIndexAtPtx2039 = uint32_t((threadIdx.x & 31u));							   // PTX L2039
	r_PackedHalf2AtPtx243R1425 = HalfMul(r_PackedHalf2AtPtx703R334, r_PtxRegister335); // PTX L2042
	r_LaneIndexAtPtx2046 = uint32_t((threadIdx.x & 31u));							   // PTX L2046
	r_PackedHalf2AtPtx242R1424 = HalfMul(r_PackedHalf2AtPtx706R337, r_PtxRegister338); // PTX L2049
	r_LaneIndexAtPtx2053 = uint32_t((threadIdx.x & 31u));							   // PTX L2053
	r_PackedHalf2AtPtx241R1423 = HalfMul(r_PackedHalf2AtPtx712R340, r_PtxRegister341); // PTX L2056
	r_LaneIndexAtPtx2060 = uint32_t((threadIdx.x & 31u));							   // PTX L2060
	r_PackedHalf2AtPtx240R1422 = HalfMul(r_PackedHalf2AtPtx709R343, r_PtxRegister344); // PTX L2063
	r_LaneIndexAtPtx2067 = uint32_t((threadIdx.x & 31u));							   // PTX L2067
	r_PackedHalf2AtPtx239R1421 = HalfMul(r_PackedHalf2AtPtx715R346, r_PtxRegister347); // PTX L2070
	r_LaneIndexAtPtx2074 = uint32_t((threadIdx.x & 31u));							   // PTX L2074
	r_PackedHalf2AtPtx238R1420 = HalfMul(r_PackedHalf2AtPtx718R349, r_PtxRegister350); // PTX L2077
	r_LaneIndexAtPtx2081 = uint32_t((threadIdx.x & 31u));							   // PTX L2081
	r_PackedHalf2AtPtx237R1419 = HalfMul(r_PackedHalf2AtPtx724R352, r_PtxRegister353); // PTX L2084
	r_LaneIndexAtPtx2088 = uint32_t((threadIdx.x & 31u));							   // PTX L2088
	r_PackedHalf2AtPtx236R1418 = HalfMul(r_PackedHalf2AtPtx721R355, r_PtxRegister356); // PTX L2091
	r_LaneIndexAtPtx2095 = uint32_t((threadIdx.x & 31u));							   // PTX L2095
	r_PackedHalf2AtPtx235R1417 = HalfMul(r_PackedHalf2AtPtx727R358, r_PtxRegister359); // PTX L2098
	r_LaneIndexAtPtx2102 = uint32_t((threadIdx.x & 31u));							   // PTX L2102
	r_PackedHalf2AtPtx234R1416 = HalfMul(r_PackedHalf2AtPtx731R361, r_PtxRegister362); // PTX L2105
	r_LaneIndexAtPtx2109 = uint32_t((threadIdx.x & 31u));							   // PTX L2109
	r_PackedHalf2AtPtx233R1415 = HalfMul(r_PackedHalf2AtPtx738R364, r_PtxRegister365); // PTX L2112
	r_LaneIndexAtPtx2116 = uint32_t((threadIdx.x & 31u));							   // PTX L2116
	r_PackedHalf2AtPtx232R1414 = HalfMul(r_PackedHalf2AtPtx734R367, r_PtxRegister368); // PTX L2119
	r_LaneIndexAtPtx2123 = uint32_t((threadIdx.x & 31u));							   // PTX L2123
	r_PackedHalf2AtPtx231R1413 = HalfMul(r_PackedHalf2AtPtx741R370, r_PtxRegister371); // PTX L2126
	r_LaneIndexAtPtx2130 = uint32_t((threadIdx.x & 31u));							   // PTX L2130
	r_PackedHalf2AtPtx230R1412 = HalfMul(r_PackedHalf2AtPtx745R373, r_PtxRegister374); // PTX L2133
	r_LaneIndexAtPtx2137 = uint32_t((threadIdx.x & 31u));							   // PTX L2137
	r_PackedHalf2AtPtx229R1411 = HalfMul(r_PackedHalf2AtPtx752R376, r_PtxRegister377); // PTX L2140
	r_LaneIndexAtPtx2144 = uint32_t((threadIdx.x & 31u));							   // PTX L2144
	r_PackedHalf2AtPtx228R1410 = HalfMul(r_PackedHalf2AtPtx748R379, r_PtxRegister380); // PTX L2147
	r_LaneIndexAtPtx2151 = uint32_t((threadIdx.x & 31u));							   // PTX L2151
	r_PackedHalf2AtPtx227R1409 = HalfMul(r_PackedHalf2AtPtx755R382, r_PtxRegister383); // PTX L2154
L__BB59_38:																			   // PTX L2157
	r_PtxRegister951 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));					   // PTX L2158
	r_PtxRegister18 = r_PtxRegister951 & 2044;										   // PTX L2159
	g_StateByteAddressAtPtx2160 = g_StateBaseAddress;								   // PTX L2160
	r_PtxRegister952 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(10));				   // PTX L2161
	r_PtxRegister19 = r_PtxRegister952 & 1046528;									   // PTX L2162
	r_PtxRegister20 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(8));						   // PTX L2163
	r_PtxRegister1473 = uint32_t(0);												   // PTX L2164
L__BB59_39:																			   // PTX L2165
	r_bPtxPredicate17 = int32_t(r_PtxRegister8) >= int32_t(r_PtxRegister3);			   // PTX L2166
	r_bPtxPredicate18 = int32_t(r_PtxRegister8) < int32_t(r_PtxRegister3);			   // PTX L2167
	r_PtxRegister21 = uint32_t(r_PtxRegister1473) + uint32_t(32);					   // PTX L2168
	r_PtxRegister977 = ShiftLeft(uint32_t(r_PtxRegister1473), uint32_t(7));			   // PTX L2169
	r_PtxRegister978 = r_PtxRegister977 & 4096;										   // PTX L2170
	r_LaneIndexAtPtx2172 = uint32_t((threadIdx.x & 31u));							   // PTX L2172
	r_PtxRegister979 = uint32_t(r_PtxRegister978) + uint32_t(r_PtxRegister19);		   // PTX L2174
	r_PtxRegister980 = uint32_t(0u /* original named shared base */);				   // PTX L2175
	r_PtxRegister981 = uint32_t(r_PtxRegister980) + uint32_t(r_PtxRegister979);		   // PTX L2176
	r_PtxRegister982 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2172), uint32_t(4));		   // PTX L2177
	r_PtxRegister954 = uint32_t(r_PtxRegister981) + uint32_t(r_PtxRegister982);		   // PTX L2178
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister954));
		r_MmaAE4x4WordAtPtx2180R961 = r_Value.x;
		r_MmaAE4x4WordAtPtx2180R962 = r_Value.y;
		r_MmaAE4x4WordAtPtx2180R963 = r_Value.z;
		r_MmaAE4x4WordAtPtx2180R964 = r_Value.w;
	} // PTX L2180
	r_LaneIndexAtPtx2183 = uint32_t((threadIdx.x & 31u));						// PTX L2183
	r_PtxRegister983 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2183), uint32_t(4));	// PTX L2185
	r_PtxRegister984 = uint32_t(r_PtxRegister981) + uint32_t(r_PtxRegister983); // PTX L2186
	r_PtxRegister956 = uint32_t(r_PtxRegister984) + uint32_t(512);				// PTX L2187
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister956));
		r_MmaAE4x4WordAtPtx2189R965 = r_Value.x;
		r_MmaAE4x4WordAtPtx2189R966 = r_Value.y;
		r_MmaAE4x4WordAtPtx2189R967 = r_Value.z;
		r_MmaAE4x4WordAtPtx2189R968 = r_Value.w;
	} // PTX L2189
	r_LaneIndexAtPtx2192 = uint32_t((threadIdx.x & 31u));						// PTX L2192
	r_PtxRegister985 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2192), uint32_t(4));	// PTX L2194
	r_PtxRegister986 = uint32_t(r_PtxRegister981) + uint32_t(r_PtxRegister985); // PTX L2195
	r_PtxRegister958 = uint32_t(r_PtxRegister986) + uint32_t(1024);				// PTX L2196
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister958));
		r_MmaAE4x4WordAtPtx2198R969 = r_Value.x;
		r_MmaAE4x4WordAtPtx2198R970 = r_Value.y;
		r_MmaAE4x4WordAtPtx2198R971 = r_Value.z;
		r_MmaAE4x4WordAtPtx2198R972 = r_Value.w;
	} // PTX L2198
	r_LaneIndexAtPtx2201 = uint32_t((threadIdx.x & 31u));						// PTX L2201
	r_PtxRegister987 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2201), uint32_t(4));	// PTX L2203
	r_PtxRegister988 = uint32_t(r_PtxRegister981) + uint32_t(r_PtxRegister987); // PTX L2204
	r_PtxRegister960 = uint32_t(r_PtxRegister988) + uint32_t(1536);				// PTX L2205
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister960));
		r_MmaAE4x4WordAtPtx2207R973 = r_Value.x;
		r_MmaAE4x4WordAtPtx2207R974 = r_Value.y;
		r_MmaAE4x4WordAtPtx2207R975 = r_Value.z;
		r_MmaAE4x4WordAtPtx2207R976 = r_Value.w;
	} // PTX L2207
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_PackedHalf2AtPtx290R1472, r_PackedHalf2AtPtx289R1471, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475, r_PackedHalf2AtPtx290R1472,
		  r_PackedHalf2AtPtx289R1471); // PTX L2210
	MmaE4(r_PackedHalf2AtPtx288R1470, r_PackedHalf2AtPtx287R1469, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477, r_PackedHalf2AtPtx288R1470,
		  r_PackedHalf2AtPtx287R1469); // PTX L2217
	MmaE4(r_PackedHalf2AtPtx286R1468, r_PackedHalf2AtPtx285R1467, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479, r_PackedHalf2AtPtx286R1468,
		  r_PackedHalf2AtPtx285R1467); // PTX L2224
	MmaE4(r_PackedHalf2AtPtx284R1466, r_PackedHalf2AtPtx283R1465, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481, r_PackedHalf2AtPtx284R1466,
		  r_PackedHalf2AtPtx283R1465); // PTX L2231
	MmaE4(r_PackedHalf2AtPtx282R1464, r_PackedHalf2AtPtx281R1463, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483, r_PackedHalf2AtPtx282R1464,
		  r_PackedHalf2AtPtx281R1463); // PTX L2238
	MmaE4(r_PackedHalf2AtPtx280R1462, r_PackedHalf2AtPtx279R1461, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485, r_PackedHalf2AtPtx280R1462,
		  r_PackedHalf2AtPtx279R1461); // PTX L2245
	MmaE4(r_PackedHalf2AtPtx278R1460, r_PackedHalf2AtPtx277R1459, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487, r_PackedHalf2AtPtx278R1460,
		  r_PackedHalf2AtPtx277R1459); // PTX L2252
	MmaE4(r_PackedHalf2AtPtx276R1458, r_PackedHalf2AtPtx275R1457, r_MmaAE4x4WordAtPtx2180R961,
		  r_MmaAE4x4WordAtPtx2180R962, r_MmaAE4x4WordAtPtx2180R963, r_MmaAE4x4WordAtPtx2180R964,
		  r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489, r_PackedHalf2AtPtx276R1458,
		  r_PackedHalf2AtPtx275R1457); // PTX L2259
	MmaE4(r_PackedHalf2AtPtx274R1456, r_PackedHalf2AtPtx273R1455, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475, r_PackedHalf2AtPtx274R1456,
		  r_PackedHalf2AtPtx273R1455); // PTX L2266
	MmaE4(r_PackedHalf2AtPtx272R1454, r_PackedHalf2AtPtx271R1453, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477, r_PackedHalf2AtPtx272R1454,
		  r_PackedHalf2AtPtx271R1453); // PTX L2273
	MmaE4(r_PackedHalf2AtPtx270R1452, r_PackedHalf2AtPtx269R1451, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479, r_PackedHalf2AtPtx270R1452,
		  r_PackedHalf2AtPtx269R1451); // PTX L2280
	MmaE4(r_PackedHalf2AtPtx268R1450, r_PackedHalf2AtPtx267R1449, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481, r_PackedHalf2AtPtx268R1450,
		  r_PackedHalf2AtPtx267R1449); // PTX L2287
	MmaE4(r_PackedHalf2AtPtx266R1448, r_PackedHalf2AtPtx265R1447, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483, r_PackedHalf2AtPtx266R1448,
		  r_PackedHalf2AtPtx265R1447); // PTX L2294
	MmaE4(r_PackedHalf2AtPtx264R1446, r_PackedHalf2AtPtx263R1445, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485, r_PackedHalf2AtPtx264R1446,
		  r_PackedHalf2AtPtx263R1445); // PTX L2301
	MmaE4(r_PackedHalf2AtPtx262R1444, r_PackedHalf2AtPtx261R1443, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487, r_PackedHalf2AtPtx262R1444,
		  r_PackedHalf2AtPtx261R1443); // PTX L2308
	MmaE4(r_PackedHalf2AtPtx260R1442, r_PackedHalf2AtPtx259R1441, r_MmaAE4x4WordAtPtx2189R965,
		  r_MmaAE4x4WordAtPtx2189R966, r_MmaAE4x4WordAtPtx2189R967, r_MmaAE4x4WordAtPtx2189R968,
		  r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489, r_PackedHalf2AtPtx260R1442,
		  r_PackedHalf2AtPtx259R1441); // PTX L2315
	MmaE4(r_PackedHalf2AtPtx258R1440, r_PackedHalf2AtPtx257R1439, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475, r_PackedHalf2AtPtx258R1440,
		  r_PackedHalf2AtPtx257R1439); // PTX L2322
	MmaE4(r_PackedHalf2AtPtx256R1438, r_PackedHalf2AtPtx255R1437, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477, r_PackedHalf2AtPtx256R1438,
		  r_PackedHalf2AtPtx255R1437); // PTX L2329
	MmaE4(r_PackedHalf2AtPtx254R1436, r_PackedHalf2AtPtx253R1435, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479, r_PackedHalf2AtPtx254R1436,
		  r_PackedHalf2AtPtx253R1435); // PTX L2336
	MmaE4(r_PackedHalf2AtPtx252R1434, r_PackedHalf2AtPtx251R1433, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481, r_PackedHalf2AtPtx252R1434,
		  r_PackedHalf2AtPtx251R1433); // PTX L2343
	MmaE4(r_PackedHalf2AtPtx250R1432, r_PackedHalf2AtPtx249R1431, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483, r_PackedHalf2AtPtx250R1432,
		  r_PackedHalf2AtPtx249R1431); // PTX L2350
	MmaE4(r_PackedHalf2AtPtx248R1430, r_PackedHalf2AtPtx247R1429, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485, r_PackedHalf2AtPtx248R1430,
		  r_PackedHalf2AtPtx247R1429); // PTX L2357
	MmaE4(r_PackedHalf2AtPtx246R1428, r_PackedHalf2AtPtx245R1427, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487, r_PackedHalf2AtPtx246R1428,
		  r_PackedHalf2AtPtx245R1427); // PTX L2364
	MmaE4(r_PackedHalf2AtPtx244R1426, r_PackedHalf2AtPtx243R1425, r_MmaAE4x4WordAtPtx2198R969,
		  r_MmaAE4x4WordAtPtx2198R970, r_MmaAE4x4WordAtPtx2198R971, r_MmaAE4x4WordAtPtx2198R972,
		  r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489, r_PackedHalf2AtPtx244R1426,
		  r_PackedHalf2AtPtx243R1425); // PTX L2371
	MmaE4(r_PackedHalf2AtPtx242R1424, r_PackedHalf2AtPtx241R1423, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475, r_PackedHalf2AtPtx242R1424,
		  r_PackedHalf2AtPtx241R1423); // PTX L2378
	MmaE4(r_PackedHalf2AtPtx240R1422, r_PackedHalf2AtPtx239R1421, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477, r_PackedHalf2AtPtx240R1422,
		  r_PackedHalf2AtPtx239R1421); // PTX L2385
	MmaE4(r_PackedHalf2AtPtx238R1420, r_PackedHalf2AtPtx237R1419, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479, r_PackedHalf2AtPtx238R1420,
		  r_PackedHalf2AtPtx237R1419); // PTX L2392
	MmaE4(r_PackedHalf2AtPtx236R1418, r_PackedHalf2AtPtx235R1417, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481, r_PackedHalf2AtPtx236R1418,
		  r_PackedHalf2AtPtx235R1417); // PTX L2399
	MmaE4(r_PackedHalf2AtPtx234R1416, r_PackedHalf2AtPtx233R1415, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483, r_PackedHalf2AtPtx234R1416,
		  r_PackedHalf2AtPtx233R1415); // PTX L2406
	MmaE4(r_PackedHalf2AtPtx232R1414, r_PackedHalf2AtPtx231R1413, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485, r_PackedHalf2AtPtx232R1414,
		  r_PackedHalf2AtPtx231R1413); // PTX L2413
	MmaE4(r_PackedHalf2AtPtx230R1412, r_PackedHalf2AtPtx229R1411, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487, r_PackedHalf2AtPtx230R1412,
		  r_PackedHalf2AtPtx229R1411); // PTX L2420
	MmaE4(r_PackedHalf2AtPtx228R1410, r_PackedHalf2AtPtx227R1409, r_MmaAE4x4WordAtPtx2207R973,
		  r_MmaAE4x4WordAtPtx2207R974, r_MmaAE4x4WordAtPtx2207R975, r_MmaAE4x4WordAtPtx2207R976,
		  r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489, r_PackedHalf2AtPtx228R1410,
		  r_PackedHalf2AtPtx227R1409);											 // PTX L2427
	r_PtxRegister989 = r_PtxRegister978 ^ 4096;									 // PTX L2433
	r_PtxRegister22 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister20);	 // PTX L2434
	r_PtxRegister990 = ShiftLeft(uint32_t(r_PtxRegister22), uint32_t(2));		 // PTX L2435
	r_PtxRegister23 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister990);	 // PTX L2436
	r_PtxRegister24 = r_bPtxPredicate18 ? r_PtxRegister23 : 0;					 // PTX L2437
	r_PtxRegister991 = ShiftRight(uint32_t(r_PtxRegister1473), uint32_t(2));	 // PTX L2438
	r_PtxRegister992 = ~uint32_t(r_PtxRegister991);								 // PTX L2439
	r_PtxRegister993 = r_PtxRegister992 & 8;									 // PTX L2440
	r_PtxRegister994 = uint32_t(8192u /* original named shared base */);		 // PTX L2441
	r_PtxRegister1016 = uint32_t(r_PtxRegister994) + uint32_t(r_PtxRegister993); // PTX L2442
	r_PtxRegister25 = uint32_t(r_PtxRegister79) + uint32_t(r_PtxRegister989);	 // PTX L2443
	if (r_bPtxPredicate17)
	{
		goto L__BB59_42;
	} // PTX L2444
	r_PtxRegister1002 = uint32_t(-1);								// PTX L2445
	r_PtxRegister1001 = Elected(r_PtxRegister1002);					// PTX L2447
	r_bPtxPredicate19 = uint32_t(r_PtxRegister1001) == uint32_t(0); // PTX L2453
	if (r_bPtxPredicate19)
	{
		goto L__BB59_43;
	} // PTX L2454
	r_PtxU64Register204 = uint64_t(int64_t(int32_t(r_PtxRegister24)) * int64_t(int32_t(4))); // PTX L2455
	g_StateByteAddressAtPtx2456 =
		uint64_t(g_StateByteAddressAtPtx2160) + uint64_t(r_PtxU64Register204); // PTX L2456
	r_PtxRegister1003 = uint32_t(512);										   // PTX L2457
	CopyBulk(s_SharedStorage, r_PtxRegister25, g_StateByteAddressAtPtx2456, r_PtxRegister1003,
			 r_PtxRegister1016);															   // PTX L2459
	BarrierExpect(s_SharedStorage, r_PtxRegister1016, r_PtxRegister1003);					   // PTX L2462
	goto L__BB59_43;																		   // PTX L2464
L__BB59_42:																					   // PTX L2465
	r_PtxRegister995 = uint32_t(0);															   // PTX L2466
	r_PtxU16Register85 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister995))); // PTX L2468
	r_PackedHalf2AtPtx2471R996 = JoinHalfwords(r_PtxU16Register85, r_PtxU16Register85);		   // PTX L2471
	r_ConvertedE4PairAtPtx2473Rs86 = PublishE4(r_PackedHalf2AtPtx2471R996);					   // PTX L2473
	r_PackedE4WordAtPtx2475R999 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2473Rs86, r_ConvertedE4PairAtPtx2473Rs86); // PTX L2475
	r_LaneIndexAtPtx2477 = uint32_t((threadIdx.x & 31u));							   // PTX L2477
	r_PtxRegister1000 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2477), uint32_t(4));		   // PTX L2479
	r_PtxRegister998 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1000);		   // PTX L2480
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister998)) =
		make_uint4(r_PackedE4WordAtPtx2475R999, r_PackedE4WordAtPtx2475R999, r_PackedE4WordAtPtx2475R999,
				   r_PackedE4WordAtPtx2475R999);							 // PTX L2482
L__BB59_43:																	 // PTX L2484
	r_bPtxPredicate20 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L2485
	r_bPtxPredicate21 = int32_t(r_PtxRegister12) < int32_t(r_PtxRegister3);	 // PTX L2486
	r_PtxRegister1004 = uint32_t(r_PtxRegister23) + uint32_t(16384);		 // PTX L2487
	r_PtxRegister26 = r_bPtxPredicate21 ? r_PtxRegister1004 : 0;			 // PTX L2488
	if (r_bPtxPredicate20)
	{
		goto L__BB59_46;
	} // PTX L2489
	r_PtxRegister1013 = uint32_t(-1);								// PTX L2490
	r_PtxRegister1012 = Elected(r_PtxRegister1013);					// PTX L2492
	r_bPtxPredicate22 = uint32_t(r_PtxRegister1012) == uint32_t(0); // PTX L2498
	if (r_bPtxPredicate22)
	{
		goto L__BB59_47;
	} // PTX L2499
	r_PtxRegister1014 = uint32_t(r_PtxRegister25) + uint32_t(2048);							 // PTX L2500
	r_PtxU64Register206 = uint64_t(int64_t(int32_t(r_PtxRegister26)) * int64_t(int32_t(4))); // PTX L2501
	g_StateByteAddressAtPtx2502 =
		uint64_t(g_StateByteAddressAtPtx2160) + uint64_t(r_PtxU64Register206); // PTX L2502
	r_PtxRegister1015 = uint32_t(512);										   // PTX L2503
	CopyBulk(s_SharedStorage, r_PtxRegister1014, g_StateByteAddressAtPtx2502, r_PtxRegister1015,
			 r_PtxRegister1016);																// PTX L2505
	BarrierExpect(s_SharedStorage, r_PtxRegister1016, r_PtxRegister1015);						// PTX L2508
	goto L__BB59_47;																			// PTX L2510
L__BB59_46:																						// PTX L2511
	r_PtxRegister1005 = uint32_t(0);															// PTX L2512
	r_PtxU16Register87 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1005))); // PTX L2514
	r_PackedHalf2AtPtx2517R1006 = JoinHalfwords(r_PtxU16Register87, r_PtxU16Register87);		// PTX L2517
	r_ConvertedE4PairAtPtx2519Rs88 = PublishE4(r_PackedHalf2AtPtx2517R1006);					// PTX L2519
	r_PackedE4WordAtPtx2521R1009 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2519Rs88, r_ConvertedE4PairAtPtx2519Rs88); // PTX L2521
	r_LaneIndexAtPtx2523 = uint32_t((threadIdx.x & 31u));							   // PTX L2523
	r_PtxRegister1010 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2523), uint32_t(4));		   // PTX L2525
	r_PtxRegister1011 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister1010);	   // PTX L2526
	r_PtxRegister1008 = uint32_t(r_PtxRegister1011) + uint32_t(2048);				   // PTX L2527
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1008)) =
		make_uint4(r_PackedE4WordAtPtx2521R1009, r_PackedE4WordAtPtx2521R1009, r_PackedE4WordAtPtx2521R1009,
				   r_PackedE4WordAtPtx2521R1009);												  // PTX L2529
L__BB59_47:																						  // PTX L2531
	r_PtxRegister1022 = ShiftLeft(uint32_t(r_PtxRegister22), uint32_t(8));						  // PTX L2532
	r_PtxRegister1023 = uint32_t(r_PtxRegister1022) + uint32_t(r_PtxRegister7);					  // PTX L2533
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister1023)) * int64_t(int32_t(4)));	  // PTX L2534
	g_RecordByteAddressAtPtx2535 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register211); // PTX L2535
	r_LaneIndexAtPtx2537 = uint32_t((threadIdx.x & 31u));										  // PTX L2537
	r_PtxU64Register213 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2537)) * int64_t(int32_t(16))); // PTX L2539
	g_RecordByteAddressAtPtx2540 =
		uint64_t(g_RecordByteAddressAtPtx2535) + uint64_t(r_PtxU64Register213); // PTX L2540
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2540));
		r_MmaBE4x4WordAtPtx78R1474 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R1475 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R1476 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R1477 = r_Value.w;
	} // PTX L2542
	r_LaneIndexAtPtx2545 = uint32_t((threadIdx.x & 31u)); // PTX L2545
	r_PtxU64Register214 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2545)) * int64_t(int32_t(16))); // PTX L2547
	g_RecordByteAddressAtPtx2548 =
		uint64_t(g_RecordByteAddressAtPtx2535) + uint64_t(r_PtxU64Register214);			   // PTX L2548
	g_RecordByteAddressAtPtx2549 = uint64_t(g_RecordByteAddressAtPtx2548) + uint64_t(512); // PTX L2549
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2549));
		r_MmaBE4x4WordAtPtx87R1478 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R1479 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R1480 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R1481 = r_Value.w;
	} // PTX L2551
	r_LaneIndexAtPtx2554 = uint32_t((threadIdx.x & 31u)); // PTX L2554
	r_PtxU64Register216 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2554)) * int64_t(int32_t(16))); // PTX L2556
	g_RecordByteAddressAtPtx2557 =
		uint64_t(g_RecordByteAddressAtPtx2535) + uint64_t(r_PtxU64Register216);				// PTX L2557
	g_RecordByteAddressAtPtx2558 = uint64_t(g_RecordByteAddressAtPtx2557) + uint64_t(1024); // PTX L2558
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2558));
		r_MmaBE4x4WordAtPtx96R1482 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1483 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1484 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1485 = r_Value.w;
	} // PTX L2560
	r_LaneIndexAtPtx2563 = uint32_t((threadIdx.x & 31u)); // PTX L2563
	r_PtxU64Register218 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2563)) * int64_t(int32_t(16))); // PTX L2565
	g_RecordByteAddressAtPtx2566 =
		uint64_t(g_RecordByteAddressAtPtx2535) + uint64_t(r_PtxU64Register218);				// PTX L2566
	g_RecordByteAddressAtPtx2567 = uint64_t(g_RecordByteAddressAtPtx2566) + uint64_t(1536); // PTX L2567
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx2567));
		r_MmaBE4x4WordAtPtx105R1486 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1487 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1488 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1489 = r_Value.w;
	} // PTX L2569
	r_PtxRegister1021 = uint32_t(1);															// PTX L2571
	r_PtxU64Register220 = BarrierArrive(s_SharedStorage, r_PtxRegister1016, r_PtxRegister1021); // PTX L2573
L__BB59_48:																						// PTX L2575
	r_PtxRegister1024 = BarrierReady(s_SharedStorage, r_PtxRegister1016, r_PtxU64Register220);	// PTX L2577
	r_bPtxPredicate23 = uint32_t(r_PtxRegister1024) == uint32_t(0);								// PTX L2583
	if (r_bPtxPredicate23)
	{
		goto L__BB59_48;
	} // PTX L2584
	r_bPtxPredicate24 = uint32_t(r_PtxRegister1473) < uint32_t(192); // PTX L2585
	r_PtxRegister1473 = uint32_t(r_PtxRegister21);					 // PTX L2586
	if (r_bPtxPredicate24)
	{
		goto L__BB59_39;
	} // PTX L2587
	r_bPtxPredicate25 = uint32_t(r_CtaZ) == uint32_t(0);						   // PTX L2588
	r_LaneIndexAtPtx2590 = uint32_t((threadIdx.x & 31u));						   // PTX L2590
	r_PtxRegister1113 = uint32_t(0u /* original named shared base */);			   // PTX L2592
	r_PtxRegister1114 = uint32_t(r_PtxRegister1113) + uint32_t(r_PtxRegister19);   // PTX L2593
	r_PtxRegister1115 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2590), uint32_t(4));	   // PTX L2594
	r_PtxRegister1116 = uint32_t(r_PtxRegister1114) + uint32_t(r_PtxRegister1115); // PTX L2595
	r_PtxRegister1026 = uint32_t(r_PtxRegister1116) + uint32_t(4096);			   // PTX L2596
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1026));
		r_MmaAE4x4WordAtPtx2598R1035 = r_Value.x;
		r_MmaAE4x4WordAtPtx2598R1036 = r_Value.y;
		r_MmaAE4x4WordAtPtx2598R1037 = r_Value.z;
		r_MmaAE4x4WordAtPtx2598R1038 = r_Value.w;
	} // PTX L2598
	r_LaneIndexAtPtx2601 = uint32_t((threadIdx.x & 31u));						   // PTX L2601
	r_PtxRegister1117 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2601), uint32_t(4));	   // PTX L2603
	r_PtxRegister1118 = uint32_t(r_PtxRegister1114) + uint32_t(r_PtxRegister1117); // PTX L2604
	r_PtxRegister1028 = uint32_t(r_PtxRegister1118) + uint32_t(4608);			   // PTX L2605
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1028));
		r_MmaAE4x4WordAtPtx2607R1055 = r_Value.x;
		r_MmaAE4x4WordAtPtx2607R1056 = r_Value.y;
		r_MmaAE4x4WordAtPtx2607R1057 = r_Value.z;
		r_MmaAE4x4WordAtPtx2607R1058 = r_Value.w;
	} // PTX L2607
	r_LaneIndexAtPtx2610 = uint32_t((threadIdx.x & 31u));						   // PTX L2610
	r_PtxRegister1119 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2610), uint32_t(4));	   // PTX L2612
	r_PtxRegister1120 = uint32_t(r_PtxRegister1114) + uint32_t(r_PtxRegister1119); // PTX L2613
	r_PtxRegister1030 = uint32_t(r_PtxRegister1120) + uint32_t(5120);			   // PTX L2614
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1030));
		r_MmaAE4x4WordAtPtx2616R1075 = r_Value.x;
		r_MmaAE4x4WordAtPtx2616R1076 = r_Value.y;
		r_MmaAE4x4WordAtPtx2616R1077 = r_Value.z;
		r_MmaAE4x4WordAtPtx2616R1078 = r_Value.w;
	} // PTX L2616
	r_LaneIndexAtPtx2619 = uint32_t((threadIdx.x & 31u));						   // PTX L2619
	r_PtxRegister1121 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2619), uint32_t(4));	   // PTX L2621
	r_PtxRegister1122 = uint32_t(r_PtxRegister1114) + uint32_t(r_PtxRegister1121); // PTX L2622
	r_PtxRegister1032 = uint32_t(r_PtxRegister1122) + uint32_t(5632);			   // PTX L2623
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1032));
		r_MmaAE4x4WordAtPtx2625R1095 = r_Value.x;
		r_MmaAE4x4WordAtPtx2625R1096 = r_Value.y;
		r_MmaAE4x4WordAtPtx2625R1097 = r_Value.z;
		r_MmaAE4x4WordAtPtx2625R1098 = r_Value.w;
	} // PTX L2625
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2628R1033, r_MmaAccumulatorHalf2WordAtPtx2628R1034,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475,
		  r_PackedHalf2AtPtx290R1472,
		  r_PackedHalf2AtPtx289R1471); // PTX L2628
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2635R1039, r_MmaAccumulatorHalf2WordAtPtx2635R1040,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477,
		  r_PackedHalf2AtPtx288R1470,
		  r_PackedHalf2AtPtx287R1469); // PTX L2635
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2642R1041, r_MmaAccumulatorHalf2WordAtPtx2642R1042,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479,
		  r_PackedHalf2AtPtx286R1468,
		  r_PackedHalf2AtPtx285R1467); // PTX L2642
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2649R1043, r_MmaAccumulatorHalf2WordAtPtx2649R1044,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481,
		  r_PackedHalf2AtPtx284R1466,
		  r_PackedHalf2AtPtx283R1465); // PTX L2649
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2656R1045, r_MmaAccumulatorHalf2WordAtPtx2656R1046,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483,
		  r_PackedHalf2AtPtx282R1464,
		  r_PackedHalf2AtPtx281R1463); // PTX L2656
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2663R1047, r_MmaAccumulatorHalf2WordAtPtx2663R1048,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485,
		  r_PackedHalf2AtPtx280R1462,
		  r_PackedHalf2AtPtx279R1461); // PTX L2663
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2670R1049, r_MmaAccumulatorHalf2WordAtPtx2670R1050,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487,
		  r_PackedHalf2AtPtx278R1460,
		  r_PackedHalf2AtPtx277R1459); // PTX L2670
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2677R1051, r_MmaAccumulatorHalf2WordAtPtx2677R1052,
		  r_MmaAE4x4WordAtPtx2598R1035, r_MmaAE4x4WordAtPtx2598R1036, r_MmaAE4x4WordAtPtx2598R1037,
		  r_MmaAE4x4WordAtPtx2598R1038, r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489,
		  r_PackedHalf2AtPtx276R1458,
		  r_PackedHalf2AtPtx275R1457); // PTX L2677
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2684R1053, r_MmaAccumulatorHalf2WordAtPtx2684R1054,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475,
		  r_PackedHalf2AtPtx274R1456,
		  r_PackedHalf2AtPtx273R1455); // PTX L2684
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2691R1059, r_MmaAccumulatorHalf2WordAtPtx2691R1060,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477,
		  r_PackedHalf2AtPtx272R1454,
		  r_PackedHalf2AtPtx271R1453); // PTX L2691
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2698R1061, r_MmaAccumulatorHalf2WordAtPtx2698R1062,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479,
		  r_PackedHalf2AtPtx270R1452,
		  r_PackedHalf2AtPtx269R1451); // PTX L2698
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2705R1063, r_MmaAccumulatorHalf2WordAtPtx2705R1064,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481,
		  r_PackedHalf2AtPtx268R1450,
		  r_PackedHalf2AtPtx267R1449); // PTX L2705
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2712R1065, r_MmaAccumulatorHalf2WordAtPtx2712R1066,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483,
		  r_PackedHalf2AtPtx266R1448,
		  r_PackedHalf2AtPtx265R1447); // PTX L2712
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2719R1067, r_MmaAccumulatorHalf2WordAtPtx2719R1068,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485,
		  r_PackedHalf2AtPtx264R1446,
		  r_PackedHalf2AtPtx263R1445); // PTX L2719
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2726R1069, r_MmaAccumulatorHalf2WordAtPtx2726R1070,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487,
		  r_PackedHalf2AtPtx262R1444,
		  r_PackedHalf2AtPtx261R1443); // PTX L2726
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2733R1071, r_MmaAccumulatorHalf2WordAtPtx2733R1072,
		  r_MmaAE4x4WordAtPtx2607R1055, r_MmaAE4x4WordAtPtx2607R1056, r_MmaAE4x4WordAtPtx2607R1057,
		  r_MmaAE4x4WordAtPtx2607R1058, r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489,
		  r_PackedHalf2AtPtx260R1442,
		  r_PackedHalf2AtPtx259R1441); // PTX L2733
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2740R1073, r_MmaAccumulatorHalf2WordAtPtx2740R1074,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475,
		  r_PackedHalf2AtPtx258R1440,
		  r_PackedHalf2AtPtx257R1439); // PTX L2740
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2747R1079, r_MmaAccumulatorHalf2WordAtPtx2747R1080,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477,
		  r_PackedHalf2AtPtx256R1438,
		  r_PackedHalf2AtPtx255R1437); // PTX L2747
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2754R1081, r_MmaAccumulatorHalf2WordAtPtx2754R1082,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479,
		  r_PackedHalf2AtPtx254R1436,
		  r_PackedHalf2AtPtx253R1435); // PTX L2754
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2761R1083, r_MmaAccumulatorHalf2WordAtPtx2761R1084,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481,
		  r_PackedHalf2AtPtx252R1434,
		  r_PackedHalf2AtPtx251R1433); // PTX L2761
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2768R1085, r_MmaAccumulatorHalf2WordAtPtx2768R1086,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483,
		  r_PackedHalf2AtPtx250R1432,
		  r_PackedHalf2AtPtx249R1431); // PTX L2768
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2775R1087, r_MmaAccumulatorHalf2WordAtPtx2775R1088,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485,
		  r_PackedHalf2AtPtx248R1430,
		  r_PackedHalf2AtPtx247R1429); // PTX L2775
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2782R1089, r_MmaAccumulatorHalf2WordAtPtx2782R1090,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487,
		  r_PackedHalf2AtPtx246R1428,
		  r_PackedHalf2AtPtx245R1427); // PTX L2782
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2789R1091, r_MmaAccumulatorHalf2WordAtPtx2789R1092,
		  r_MmaAE4x4WordAtPtx2616R1075, r_MmaAE4x4WordAtPtx2616R1076, r_MmaAE4x4WordAtPtx2616R1077,
		  r_MmaAE4x4WordAtPtx2616R1078, r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489,
		  r_PackedHalf2AtPtx244R1426,
		  r_PackedHalf2AtPtx243R1425); // PTX L2789
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2796R1093, r_MmaAccumulatorHalf2WordAtPtx2796R1094,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx78R1474, r_MmaBE4x4WordAtPtx78R1475,
		  r_PackedHalf2AtPtx242R1424,
		  r_PackedHalf2AtPtx241R1423); // PTX L2796
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2803R1099, r_MmaAccumulatorHalf2WordAtPtx2803R1100,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx78R1476, r_MmaBE4x4WordAtPtx78R1477,
		  r_PackedHalf2AtPtx240R1422,
		  r_PackedHalf2AtPtx239R1421); // PTX L2803
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2810R1101, r_MmaAccumulatorHalf2WordAtPtx2810R1102,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx87R1478, r_MmaBE4x4WordAtPtx87R1479,
		  r_PackedHalf2AtPtx238R1420,
		  r_PackedHalf2AtPtx237R1419); // PTX L2810
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2817R1103, r_MmaAccumulatorHalf2WordAtPtx2817R1104,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx87R1480, r_MmaBE4x4WordAtPtx87R1481,
		  r_PackedHalf2AtPtx236R1418,
		  r_PackedHalf2AtPtx235R1417); // PTX L2817
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2824R1105, r_MmaAccumulatorHalf2WordAtPtx2824R1106,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx96R1482, r_MmaBE4x4WordAtPtx96R1483,
		  r_PackedHalf2AtPtx234R1416,
		  r_PackedHalf2AtPtx233R1415); // PTX L2824
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2831R1107, r_MmaAccumulatorHalf2WordAtPtx2831R1108,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx96R1484, r_MmaBE4x4WordAtPtx96R1485,
		  r_PackedHalf2AtPtx232R1414,
		  r_PackedHalf2AtPtx231R1413); // PTX L2831
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2838R1109, r_MmaAccumulatorHalf2WordAtPtx2838R1110,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx105R1486, r_MmaBE4x4WordAtPtx105R1487,
		  r_PackedHalf2AtPtx230R1412,
		  r_PackedHalf2AtPtx229R1411); // PTX L2838
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2845R1111, r_MmaAccumulatorHalf2WordAtPtx2845R1112,
		  r_MmaAE4x4WordAtPtx2625R1095, r_MmaAE4x4WordAtPtx2625R1096, r_MmaAE4x4WordAtPtx2625R1097,
		  r_MmaAE4x4WordAtPtx2625R1098, r_MmaBE4x4WordAtPtx105R1488, r_MmaBE4x4WordAtPtx105R1489,
		  r_PackedHalf2AtPtx228R1410,
		  r_PackedHalf2AtPtx227R1409);														   // PTX L2845
	r_PtxRegister1123 = uint32_t(r_PtxRegister2) + uint32_t(r_PtxRegister1);				   // PTX L2851
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister1123)) * int64_t(int32_t(4))); // PTX L2852
	g_CounterByteAddress = uint64_t(g_CounterBaseAddress) + uint64_t(r_PtxU64Register221);	   // PTX L2853
	if (r_bPtxPredicate25)
	{
		goto L__BB59_55;
	} // PTX L2854
	r_ThreadZAtPtx2855 = uint32_t(threadIdx.z);						// PTX L2855
	r_PtxRegister1125 = r_PtxRegister5 | r_ThreadZAtPtx2855;		// PTX L2856
	r_bPtxPredicate26 = uint32_t(r_PtxRegister1125) != uint32_t(0); // PTX L2857
	if (r_bPtxPredicate26)
	{
		goto L__BB59_71;
	} // PTX L2858
	goto L__BB59_52;									// PTX L2859
L__BB59_71:												// PTX L2860
	__syncthreads();									// PTX L2861
	r_bPtxPredicate28 = uint32_t(r_CtaZ) < uint32_t(3); // PTX L2862
	if (r_bPtxPredicate28)
	{
		goto L__BB59_63;
	} // PTX L2863
	goto L__BB59_72;														 // PTX L2864
L__BB59_63:																	 // PTX L2865
	r_PtxRegister29 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2);	 // PTX L2866
	r_bPtxPredicate48 = int32_t(r_PtxRegister29) >= int32_t(r_PtxRegister3); // PTX L2867
	if (r_bPtxPredicate48)
	{
		goto L__BB59_65;
	} // PTX L2868
	r_PtxRegister1320 = ShiftLeft(uint32_t(r_PtxRegister29), uint32_t(13));						  // PTX L2869
	r_PtxRegister1321 = uint32_t(r_PtxRegister1320) + uint32_t(r_PtxRegister7);					  // PTX L2870
	r_PtxU64Register282 = SignExtendWordBits(r_PtxRegister1321);								  // PTX L2871
	r_LaneIndexAtPtx2873 = uint32_t((threadIdx.x & 31u));										  // PTX L2873
	r_PtxU64Register283 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2873)) * int64_t(int32_t(4))); // PTX L2875
	r_PtxU64Register284 = uint64_t(r_PtxU64Register283) + uint64_t(r_PtxU64Register282);		  // PTX L2876
	r_PtxU64Register285 = ShiftLeft(uint64_t(r_PtxU64Register284), uint32_t(2));				  // PTX L2877
	r_PtxU64Register278 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register285);		  // PTX L2878
	ReduceHalf4(r_PtxU64Register278,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2628R1033, r_MmaAccumulatorHalf2WordAtPtx2628R1034,
						   r_MmaAccumulatorHalf2WordAtPtx2635R1039,
						   r_MmaAccumulatorHalf2WordAtPtx2635R1040));							  // PTX L2880
	r_PtxRegister1322 = uint32_t(r_PtxRegister1321) + uint32_t(128);							  // PTX L2882
	r_PtxU64Register286 = SignExtendWordBits(r_PtxRegister1322);								  // PTX L2883
	r_LaneIndexAtPtx2885 = uint32_t((threadIdx.x & 31u));										  // PTX L2885
	r_PtxU64Register287 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2885)) * int64_t(int32_t(4))); // PTX L2887
	r_PtxU64Register288 = uint64_t(r_PtxU64Register287) + uint64_t(r_PtxU64Register286);		  // PTX L2888
	r_PtxU64Register289 = ShiftLeft(uint64_t(r_PtxU64Register288), uint32_t(2));				  // PTX L2889
	r_PtxU64Register279 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register289);		  // PTX L2890
	ReduceHalf4(r_PtxU64Register279,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2642R1041, r_MmaAccumulatorHalf2WordAtPtx2642R1042,
						   r_MmaAccumulatorHalf2WordAtPtx2649R1043,
						   r_MmaAccumulatorHalf2WordAtPtx2649R1044));							  // PTX L2892
	r_PtxRegister1323 = uint32_t(r_PtxRegister1321) + uint32_t(256);							  // PTX L2894
	r_PtxU64Register290 = SignExtendWordBits(r_PtxRegister1323);								  // PTX L2895
	r_LaneIndexAtPtx2897 = uint32_t((threadIdx.x & 31u));										  // PTX L2897
	r_PtxU64Register291 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2897)) * int64_t(int32_t(4))); // PTX L2899
	r_PtxU64Register292 = uint64_t(r_PtxU64Register291) + uint64_t(r_PtxU64Register290);		  // PTX L2900
	r_PtxU64Register293 = ShiftLeft(uint64_t(r_PtxU64Register292), uint32_t(2));				  // PTX L2901
	r_PtxU64Register280 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register293);		  // PTX L2902
	ReduceHalf4(r_PtxU64Register280,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2656R1045, r_MmaAccumulatorHalf2WordAtPtx2656R1046,
						   r_MmaAccumulatorHalf2WordAtPtx2663R1047,
						   r_MmaAccumulatorHalf2WordAtPtx2663R1048));							  // PTX L2904
	r_PtxRegister1324 = uint32_t(r_PtxRegister1321) + uint32_t(384);							  // PTX L2906
	r_PtxU64Register294 = SignExtendWordBits(r_PtxRegister1324);								  // PTX L2907
	r_LaneIndexAtPtx2909 = uint32_t((threadIdx.x & 31u));										  // PTX L2909
	r_PtxU64Register295 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2909)) * int64_t(int32_t(4))); // PTX L2911
	r_PtxU64Register296 = uint64_t(r_PtxU64Register295) + uint64_t(r_PtxU64Register294);		  // PTX L2912
	r_PtxU64Register297 = ShiftLeft(uint64_t(r_PtxU64Register296), uint32_t(2));				  // PTX L2913
	r_PtxU64Register281 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register297);		  // PTX L2914
	ReduceHalf4(r_PtxU64Register281,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2670R1049, r_MmaAccumulatorHalf2WordAtPtx2670R1050,
						   r_MmaAccumulatorHalf2WordAtPtx2677R1051,
						   r_MmaAccumulatorHalf2WordAtPtx2677R1052));		 // PTX L2916
L__BB59_65:																	 // PTX L2918
	r_PtxRegister30 = uint32_t(r_PtxRegister29) + uint32_t(1);				 // PTX L2919
	r_bPtxPredicate49 = int32_t(r_PtxRegister30) >= int32_t(r_PtxRegister3); // PTX L2920
	if (r_bPtxPredicate49)
	{
		goto L__BB59_67;
	} // PTX L2921
	r_PtxRegister1329 = ShiftLeft(uint32_t(r_PtxRegister30), uint32_t(13));						  // PTX L2922
	r_PtxRegister1330 = uint32_t(r_PtxRegister1329) + uint32_t(r_PtxRegister7);					  // PTX L2923
	r_PtxU64Register302 = SignExtendWordBits(r_PtxRegister1330);								  // PTX L2924
	r_LaneIndexAtPtx2926 = uint32_t((threadIdx.x & 31u));										  // PTX L2926
	r_PtxU64Register303 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2926)) * int64_t(int32_t(4))); // PTX L2928
	r_PtxU64Register304 = uint64_t(r_PtxU64Register303) + uint64_t(r_PtxU64Register302);		  // PTX L2929
	r_PtxU64Register305 = ShiftLeft(uint64_t(r_PtxU64Register304), uint32_t(2));				  // PTX L2930
	r_PtxU64Register298 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register305);		  // PTX L2931
	ReduceHalf4(r_PtxU64Register298,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2684R1053, r_MmaAccumulatorHalf2WordAtPtx2684R1054,
						   r_MmaAccumulatorHalf2WordAtPtx2691R1059,
						   r_MmaAccumulatorHalf2WordAtPtx2691R1060));							  // PTX L2933
	r_PtxRegister1331 = uint32_t(r_PtxRegister1330) + uint32_t(128);							  // PTX L2935
	r_PtxU64Register306 = SignExtendWordBits(r_PtxRegister1331);								  // PTX L2936
	r_LaneIndexAtPtx2938 = uint32_t((threadIdx.x & 31u));										  // PTX L2938
	r_PtxU64Register307 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2938)) * int64_t(int32_t(4))); // PTX L2940
	r_PtxU64Register308 = uint64_t(r_PtxU64Register307) + uint64_t(r_PtxU64Register306);		  // PTX L2941
	r_PtxU64Register309 = ShiftLeft(uint64_t(r_PtxU64Register308), uint32_t(2));				  // PTX L2942
	r_PtxU64Register299 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register309);		  // PTX L2943
	ReduceHalf4(r_PtxU64Register299,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2698R1061, r_MmaAccumulatorHalf2WordAtPtx2698R1062,
						   r_MmaAccumulatorHalf2WordAtPtx2705R1063,
						   r_MmaAccumulatorHalf2WordAtPtx2705R1064));							  // PTX L2945
	r_PtxRegister1332 = uint32_t(r_PtxRegister1330) + uint32_t(256);							  // PTX L2947
	r_PtxU64Register310 = SignExtendWordBits(r_PtxRegister1332);								  // PTX L2948
	r_LaneIndexAtPtx2950 = uint32_t((threadIdx.x & 31u));										  // PTX L2950
	r_PtxU64Register311 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2950)) * int64_t(int32_t(4))); // PTX L2952
	r_PtxU64Register312 = uint64_t(r_PtxU64Register311) + uint64_t(r_PtxU64Register310);		  // PTX L2953
	r_PtxU64Register313 = ShiftLeft(uint64_t(r_PtxU64Register312), uint32_t(2));				  // PTX L2954
	r_PtxU64Register300 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register313);		  // PTX L2955
	ReduceHalf4(r_PtxU64Register300,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2712R1065, r_MmaAccumulatorHalf2WordAtPtx2712R1066,
						   r_MmaAccumulatorHalf2WordAtPtx2719R1067,
						   r_MmaAccumulatorHalf2WordAtPtx2719R1068));							  // PTX L2957
	r_PtxRegister1333 = uint32_t(r_PtxRegister1330) + uint32_t(384);							  // PTX L2959
	r_PtxU64Register314 = SignExtendWordBits(r_PtxRegister1333);								  // PTX L2960
	r_LaneIndexAtPtx2962 = uint32_t((threadIdx.x & 31u));										  // PTX L2962
	r_PtxU64Register315 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2962)) * int64_t(int32_t(4))); // PTX L2964
	r_PtxU64Register316 = uint64_t(r_PtxU64Register315) + uint64_t(r_PtxU64Register314);		  // PTX L2965
	r_PtxU64Register317 = ShiftLeft(uint64_t(r_PtxU64Register316), uint32_t(2));				  // PTX L2966
	r_PtxU64Register301 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register317);		  // PTX L2967
	ReduceHalf4(r_PtxU64Register301,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2726R1069, r_MmaAccumulatorHalf2WordAtPtx2726R1070,
						   r_MmaAccumulatorHalf2WordAtPtx2733R1071,
						   r_MmaAccumulatorHalf2WordAtPtx2733R1072));		 // PTX L2969
L__BB59_67:																	 // PTX L2971
	r_PtxRegister31 = uint32_t(r_PtxRegister29) + uint32_t(2);				 // PTX L2972
	r_bPtxPredicate50 = int32_t(r_PtxRegister31) >= int32_t(r_PtxRegister3); // PTX L2973
	if (r_bPtxPredicate50)
	{
		goto L__BB59_69;
	} // PTX L2974
	r_PtxRegister1338 = ShiftLeft(uint32_t(r_PtxRegister31), uint32_t(13));						  // PTX L2975
	r_PtxRegister1339 = uint32_t(r_PtxRegister1338) + uint32_t(r_PtxRegister7);					  // PTX L2976
	r_PtxU64Register322 = SignExtendWordBits(r_PtxRegister1339);								  // PTX L2977
	r_LaneIndexAtPtx2979 = uint32_t((threadIdx.x & 31u));										  // PTX L2979
	r_PtxU64Register323 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2979)) * int64_t(int32_t(4))); // PTX L2981
	r_PtxU64Register324 = uint64_t(r_PtxU64Register323) + uint64_t(r_PtxU64Register322);		  // PTX L2982
	r_PtxU64Register325 = ShiftLeft(uint64_t(r_PtxU64Register324), uint32_t(2));				  // PTX L2983
	r_PtxU64Register318 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register325);		  // PTX L2984
	ReduceHalf4(r_PtxU64Register318,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2740R1073, r_MmaAccumulatorHalf2WordAtPtx2740R1074,
						   r_MmaAccumulatorHalf2WordAtPtx2747R1079,
						   r_MmaAccumulatorHalf2WordAtPtx2747R1080));							  // PTX L2986
	r_PtxRegister1340 = uint32_t(r_PtxRegister1339) + uint32_t(128);							  // PTX L2988
	r_PtxU64Register326 = SignExtendWordBits(r_PtxRegister1340);								  // PTX L2989
	r_LaneIndexAtPtx2991 = uint32_t((threadIdx.x & 31u));										  // PTX L2991
	r_PtxU64Register327 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2991)) * int64_t(int32_t(4))); // PTX L2993
	r_PtxU64Register328 = uint64_t(r_PtxU64Register327) + uint64_t(r_PtxU64Register326);		  // PTX L2994
	r_PtxU64Register329 = ShiftLeft(uint64_t(r_PtxU64Register328), uint32_t(2));				  // PTX L2995
	r_PtxU64Register319 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register329);		  // PTX L2996
	ReduceHalf4(r_PtxU64Register319,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2754R1081, r_MmaAccumulatorHalf2WordAtPtx2754R1082,
						   r_MmaAccumulatorHalf2WordAtPtx2761R1083,
						   r_MmaAccumulatorHalf2WordAtPtx2761R1084));							  // PTX L2998
	r_PtxRegister1341 = uint32_t(r_PtxRegister1339) + uint32_t(256);							  // PTX L3000
	r_PtxU64Register330 = SignExtendWordBits(r_PtxRegister1341);								  // PTX L3001
	r_LaneIndexAtPtx3003 = uint32_t((threadIdx.x & 31u));										  // PTX L3003
	r_PtxU64Register331 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3003)) * int64_t(int32_t(4))); // PTX L3005
	r_PtxU64Register332 = uint64_t(r_PtxU64Register331) + uint64_t(r_PtxU64Register330);		  // PTX L3006
	r_PtxU64Register333 = ShiftLeft(uint64_t(r_PtxU64Register332), uint32_t(2));				  // PTX L3007
	r_PtxU64Register320 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register333);		  // PTX L3008
	ReduceHalf4(r_PtxU64Register320,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2768R1085, r_MmaAccumulatorHalf2WordAtPtx2768R1086,
						   r_MmaAccumulatorHalf2WordAtPtx2775R1087,
						   r_MmaAccumulatorHalf2WordAtPtx2775R1088));							  // PTX L3010
	r_PtxRegister1342 = uint32_t(r_PtxRegister1339) + uint32_t(384);							  // PTX L3012
	r_PtxU64Register334 = SignExtendWordBits(r_PtxRegister1342);								  // PTX L3013
	r_LaneIndexAtPtx3015 = uint32_t((threadIdx.x & 31u));										  // PTX L3015
	r_PtxU64Register335 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3015)) * int64_t(int32_t(4))); // PTX L3017
	r_PtxU64Register336 = uint64_t(r_PtxU64Register335) + uint64_t(r_PtxU64Register334);		  // PTX L3018
	r_PtxU64Register337 = ShiftLeft(uint64_t(r_PtxU64Register336), uint32_t(2));				  // PTX L3019
	r_PtxU64Register321 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register337);		  // PTX L3020
	ReduceHalf4(r_PtxU64Register321,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2782R1089, r_MmaAccumulatorHalf2WordAtPtx2782R1090,
						   r_MmaAccumulatorHalf2WordAtPtx2789R1091,
						   r_MmaAccumulatorHalf2WordAtPtx2789R1092));		 // PTX L3022
L__BB59_69:																	 // PTX L3024
	r_PtxRegister32 = uint32_t(r_PtxRegister29) + uint32_t(3);				 // PTX L3025
	r_bPtxPredicate51 = int32_t(r_PtxRegister32) >= int32_t(r_PtxRegister3); // PTX L3026
	if (r_bPtxPredicate51)
	{
		goto L__BB59_112;
	} // PTX L3027
	r_PtxRegister1347 = ShiftLeft(uint32_t(r_PtxRegister32), uint32_t(13));						  // PTX L3028
	r_PtxRegister1348 = uint32_t(r_PtxRegister1347) + uint32_t(r_PtxRegister7);					  // PTX L3029
	r_PtxU64Register342 = SignExtendWordBits(r_PtxRegister1348);								  // PTX L3030
	r_LaneIndexAtPtx3032 = uint32_t((threadIdx.x & 31u));										  // PTX L3032
	r_PtxU64Register343 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3032)) * int64_t(int32_t(4))); // PTX L3034
	r_PtxU64Register344 = uint64_t(r_PtxU64Register343) + uint64_t(r_PtxU64Register342);		  // PTX L3035
	r_PtxU64Register345 = ShiftLeft(uint64_t(r_PtxU64Register344), uint32_t(2));				  // PTX L3036
	r_PtxU64Register338 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register345);		  // PTX L3037
	ReduceHalf4(r_PtxU64Register338,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2796R1093, r_MmaAccumulatorHalf2WordAtPtx2796R1094,
						   r_MmaAccumulatorHalf2WordAtPtx2803R1099,
						   r_MmaAccumulatorHalf2WordAtPtx2803R1100));							  // PTX L3039
	r_PtxRegister1349 = uint32_t(r_PtxRegister1348) + uint32_t(128);							  // PTX L3041
	r_PtxU64Register346 = SignExtendWordBits(r_PtxRegister1349);								  // PTX L3042
	r_LaneIndexAtPtx3044 = uint32_t((threadIdx.x & 31u));										  // PTX L3044
	r_PtxU64Register347 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3044)) * int64_t(int32_t(4))); // PTX L3046
	r_PtxU64Register348 = uint64_t(r_PtxU64Register347) + uint64_t(r_PtxU64Register346);		  // PTX L3047
	r_PtxU64Register349 = ShiftLeft(uint64_t(r_PtxU64Register348), uint32_t(2));				  // PTX L3048
	r_PtxU64Register339 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register349);		  // PTX L3049
	ReduceHalf4(r_PtxU64Register339,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2810R1101, r_MmaAccumulatorHalf2WordAtPtx2810R1102,
						   r_MmaAccumulatorHalf2WordAtPtx2817R1103,
						   r_MmaAccumulatorHalf2WordAtPtx2817R1104));							  // PTX L3051
	r_PtxRegister1350 = uint32_t(r_PtxRegister1348) + uint32_t(256);							  // PTX L3053
	r_PtxU64Register350 = SignExtendWordBits(r_PtxRegister1350);								  // PTX L3054
	r_LaneIndexAtPtx3056 = uint32_t((threadIdx.x & 31u));										  // PTX L3056
	r_PtxU64Register351 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3056)) * int64_t(int32_t(4))); // PTX L3058
	r_PtxU64Register352 = uint64_t(r_PtxU64Register351) + uint64_t(r_PtxU64Register350);		  // PTX L3059
	r_PtxU64Register353 = ShiftLeft(uint64_t(r_PtxU64Register352), uint32_t(2));				  // PTX L3060
	r_PtxU64Register340 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register353);		  // PTX L3061
	ReduceHalf4(r_PtxU64Register340,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2824R1105, r_MmaAccumulatorHalf2WordAtPtx2824R1106,
						   r_MmaAccumulatorHalf2WordAtPtx2831R1107,
						   r_MmaAccumulatorHalf2WordAtPtx2831R1108));							  // PTX L3063
	r_PtxRegister1351 = uint32_t(r_PtxRegister1348) + uint32_t(384);							  // PTX L3065
	r_PtxU64Register354 = SignExtendWordBits(r_PtxRegister1351);								  // PTX L3066
	r_LaneIndexAtPtx3068 = uint32_t((threadIdx.x & 31u));										  // PTX L3068
	r_PtxU64Register355 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3068)) * int64_t(int32_t(4))); // PTX L3070
	r_PtxU64Register356 = uint64_t(r_PtxU64Register355) + uint64_t(r_PtxU64Register354);		  // PTX L3071
	r_PtxU64Register357 = ShiftLeft(uint64_t(r_PtxU64Register356), uint32_t(2));				  // PTX L3072
	r_PtxU64Register341 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register357);		  // PTX L3073
	ReduceHalf4(r_PtxU64Register341,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx2838R1109, r_MmaAccumulatorHalf2WordAtPtx2838R1110,
						   r_MmaAccumulatorHalf2WordAtPtx2845R1111,
						   r_MmaAccumulatorHalf2WordAtPtx2845R1112));						   // PTX L3075
	goto L__BB59_112;																		   // PTX L3077
L__BB59_55:																					   // PTX L3078
	r_PtxRegister28 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2);					   // PTX L3079
	r_bPtxPredicate52 = int32_t(r_PtxRegister28) >= int32_t(r_PtxRegister3);				   // PTX L3080
	r_PtxRegister1353 = ShiftLeft(uint32_t(r_PtxRegister28), uint32_t(13));					   // PTX L3081
	r_PtxRegister1354 = uint32_t(r_PtxRegister1353) + uint32_t(r_PtxRegister7);				   // PTX L3082
	r_PtxU64Register358 = uint64_t(int64_t(int32_t(r_PtxRegister1354)) * int64_t(int32_t(4))); // PTX L3083
	g_ScratchByteAddressAtPtx3084 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register358); // PTX L3084
	if (r_bPtxPredicate52)
	{
		goto L__BB59_57;
	} // PTX L3085
	r_LaneIndexAtPtx3087 = uint32_t((threadIdx.x & 31u)); // PTX L3087
	r_PtxU64Register363 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3087)) * int64_t(int32_t(16))); // PTX L3089
	g_ScratchByteAddressAtPtx3090 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register363); // PTX L3090
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_ScratchByteAddressAtPtx3090,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2628R1033,
							   r_MmaAccumulatorHalf2WordAtPtx2628R1034,
							   r_MmaAccumulatorHalf2WordAtPtx2635R1039,
							   r_MmaAccumulatorHalf2WordAtPtx2635R1040)); // PTX L3092
	r_LaneIndexAtPtx3095 = uint32_t((threadIdx.x & 31u));				  // PTX L3095
	r_PtxU64Register364 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3095)) * int64_t(int32_t(16))); // PTX L3097
	g_ScratchByteAddressAtPtx3098 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register364);			 // PTX L3098
	g_ScratchByteAddressAtPtx3099 = uint64_t(g_ScratchByteAddressAtPtx3098) + uint64_t(512); // PTX L3099
	StoreNoAllocate(g_ScratchByteAddressAtPtx3099,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2642R1041,
							   r_MmaAccumulatorHalf2WordAtPtx2642R1042,
							   r_MmaAccumulatorHalf2WordAtPtx2649R1043,
							   r_MmaAccumulatorHalf2WordAtPtx2649R1044)); // PTX L3101
	r_LaneIndexAtPtx3104 = uint32_t((threadIdx.x & 31u));				  // PTX L3104
	r_PtxU64Register366 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3104)) * int64_t(int32_t(16))); // PTX L3106
	g_ScratchByteAddressAtPtx3107 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register366);			  // PTX L3107
	g_ScratchByteAddressAtPtx3108 = uint64_t(g_ScratchByteAddressAtPtx3107) + uint64_t(1024); // PTX L3108
	StoreNoAllocate(g_ScratchByteAddressAtPtx3108,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2656R1045,
							   r_MmaAccumulatorHalf2WordAtPtx2656R1046,
							   r_MmaAccumulatorHalf2WordAtPtx2663R1047,
							   r_MmaAccumulatorHalf2WordAtPtx2663R1048)); // PTX L3110
	r_LaneIndexAtPtx3113 = uint32_t((threadIdx.x & 31u));				  // PTX L3113
	r_PtxU64Register368 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3113)) * int64_t(int32_t(16))); // PTX L3115
	g_ScratchByteAddressAtPtx3116 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register368);			  // PTX L3116
	g_ScratchByteAddressAtPtx3117 = uint64_t(g_ScratchByteAddressAtPtx3116) + uint64_t(1536); // PTX L3117
	StoreNoAllocate(g_ScratchByteAddressAtPtx3117,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2670R1049,
							   r_MmaAccumulatorHalf2WordAtPtx2670R1050,
							   r_MmaAccumulatorHalf2WordAtPtx2677R1051,
							   r_MmaAccumulatorHalf2WordAtPtx2677R1052));					   // PTX L3119
L__BB59_57:																					   // PTX L3121
	r_PtxRegister1359 = uint32_t(r_PtxRegister28) + uint32_t(1);							   // PTX L3122
	r_bPtxPredicate53 = int32_t(r_PtxRegister1359) >= int32_t(r_PtxRegister3);				   // PTX L3123
	g_ScratchByteAddressAtPtx3124 = uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(32768); // PTX L3124
	if (r_bPtxPredicate53)
	{
		goto L__BB59_59;
	} // PTX L3125
	r_LaneIndexAtPtx3127 = uint32_t((threadIdx.x & 31u)); // PTX L3127
	r_PtxU64Register374 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3127)) * int64_t(int32_t(16))); // PTX L3129
	g_ScratchByteAddressAtPtx3130 =
		uint64_t(g_ScratchByteAddressAtPtx3124) + uint64_t(r_PtxU64Register374); // PTX L3130
	StoreNoAllocate(g_ScratchByteAddressAtPtx3130,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2684R1053,
							   r_MmaAccumulatorHalf2WordAtPtx2684R1054,
							   r_MmaAccumulatorHalf2WordAtPtx2691R1059,
							   r_MmaAccumulatorHalf2WordAtPtx2691R1060)); // PTX L3132
	r_LaneIndexAtPtx3135 = uint32_t((threadIdx.x & 31u));				  // PTX L3135
	r_PtxU64Register375 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3135)) * int64_t(int32_t(16))); // PTX L3137
	g_ScratchByteAddressAtPtx3138 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register375);			   // PTX L3138
	g_ScratchByteAddressAtPtx3139 = uint64_t(g_ScratchByteAddressAtPtx3138) + uint64_t(33280); // PTX L3139
	StoreNoAllocate(g_ScratchByteAddressAtPtx3139,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2698R1061,
							   r_MmaAccumulatorHalf2WordAtPtx2698R1062,
							   r_MmaAccumulatorHalf2WordAtPtx2705R1063,
							   r_MmaAccumulatorHalf2WordAtPtx2705R1064)); // PTX L3141
	r_LaneIndexAtPtx3144 = uint32_t((threadIdx.x & 31u));				  // PTX L3144
	r_PtxU64Register377 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3144)) * int64_t(int32_t(16))); // PTX L3146
	g_ScratchByteAddressAtPtx3147 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register377);			   // PTX L3147
	g_ScratchByteAddressAtPtx3148 = uint64_t(g_ScratchByteAddressAtPtx3147) + uint64_t(33792); // PTX L3148
	StoreNoAllocate(g_ScratchByteAddressAtPtx3148,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2712R1065,
							   r_MmaAccumulatorHalf2WordAtPtx2712R1066,
							   r_MmaAccumulatorHalf2WordAtPtx2719R1067,
							   r_MmaAccumulatorHalf2WordAtPtx2719R1068)); // PTX L3150
	r_LaneIndexAtPtx3153 = uint32_t((threadIdx.x & 31u));				  // PTX L3153
	r_PtxU64Register379 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3153)) * int64_t(int32_t(16))); // PTX L3155
	g_ScratchByteAddressAtPtx3156 =
		uint64_t(g_ScratchByteAddressAtPtx3084) + uint64_t(r_PtxU64Register379);			   // PTX L3156
	g_ScratchByteAddressAtPtx3157 = uint64_t(g_ScratchByteAddressAtPtx3156) + uint64_t(34304); // PTX L3157
	StoreNoAllocate(g_ScratchByteAddressAtPtx3157,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2726R1069,
							   r_MmaAccumulatorHalf2WordAtPtx2726R1070,
							   r_MmaAccumulatorHalf2WordAtPtx2733R1071,
							   r_MmaAccumulatorHalf2WordAtPtx2733R1072));					   // PTX L3159
L__BB59_59:																					   // PTX L3161
	r_PtxRegister1364 = uint32_t(r_PtxRegister28) + uint32_t(2);							   // PTX L3162
	r_bPtxPredicate54 = int32_t(r_PtxRegister1364) >= int32_t(r_PtxRegister3);				   // PTX L3163
	g_ScratchByteAddressAtPtx3164 = uint64_t(g_ScratchByteAddressAtPtx3124) + uint64_t(32768); // PTX L3164
	if (r_bPtxPredicate54)
	{
		goto L__BB59_61;
	} // PTX L3165
	r_LaneIndexAtPtx3167 = uint32_t((threadIdx.x & 31u)); // PTX L3167
	r_PtxU64Register385 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3167)) * int64_t(int32_t(16))); // PTX L3169
	g_ScratchByteAddressAtPtx3170 =
		uint64_t(g_ScratchByteAddressAtPtx3164) + uint64_t(r_PtxU64Register385); // PTX L3170
	StoreNoAllocate(g_ScratchByteAddressAtPtx3170,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2740R1073,
							   r_MmaAccumulatorHalf2WordAtPtx2740R1074,
							   r_MmaAccumulatorHalf2WordAtPtx2747R1079,
							   r_MmaAccumulatorHalf2WordAtPtx2747R1080)); // PTX L3172
	r_LaneIndexAtPtx3175 = uint32_t((threadIdx.x & 31u));				  // PTX L3175
	r_PtxU64Register386 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3175)) * int64_t(int32_t(16))); // PTX L3177
	g_ScratchByteAddressAtPtx3178 =
		uint64_t(g_ScratchByteAddressAtPtx3124) + uint64_t(r_PtxU64Register386);			   // PTX L3178
	g_ScratchByteAddressAtPtx3179 = uint64_t(g_ScratchByteAddressAtPtx3178) + uint64_t(33280); // PTX L3179
	StoreNoAllocate(g_ScratchByteAddressAtPtx3179,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2754R1081,
							   r_MmaAccumulatorHalf2WordAtPtx2754R1082,
							   r_MmaAccumulatorHalf2WordAtPtx2761R1083,
							   r_MmaAccumulatorHalf2WordAtPtx2761R1084)); // PTX L3181
	r_LaneIndexAtPtx3184 = uint32_t((threadIdx.x & 31u));				  // PTX L3184
	r_PtxU64Register388 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3184)) * int64_t(int32_t(16))); // PTX L3186
	g_ScratchByteAddressAtPtx3187 =
		uint64_t(g_ScratchByteAddressAtPtx3124) + uint64_t(r_PtxU64Register388);			   // PTX L3187
	g_ScratchByteAddressAtPtx3188 = uint64_t(g_ScratchByteAddressAtPtx3187) + uint64_t(33792); // PTX L3188
	StoreNoAllocate(g_ScratchByteAddressAtPtx3188,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2768R1085,
							   r_MmaAccumulatorHalf2WordAtPtx2768R1086,
							   r_MmaAccumulatorHalf2WordAtPtx2775R1087,
							   r_MmaAccumulatorHalf2WordAtPtx2775R1088)); // PTX L3190
	r_LaneIndexAtPtx3193 = uint32_t((threadIdx.x & 31u));				  // PTX L3193
	r_PtxU64Register390 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3193)) * int64_t(int32_t(16))); // PTX L3195
	g_ScratchByteAddressAtPtx3196 =
		uint64_t(g_ScratchByteAddressAtPtx3124) + uint64_t(r_PtxU64Register390);			   // PTX L3196
	g_ScratchByteAddressAtPtx3197 = uint64_t(g_ScratchByteAddressAtPtx3196) + uint64_t(34304); // PTX L3197
	StoreNoAllocate(g_ScratchByteAddressAtPtx3197,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2782R1089,
							   r_MmaAccumulatorHalf2WordAtPtx2782R1090,
							   r_MmaAccumulatorHalf2WordAtPtx2789R1091,
							   r_MmaAccumulatorHalf2WordAtPtx2789R1092));	   // PTX L3199
L__BB59_61:																	   // PTX L3201
	r_PtxRegister1369 = uint32_t(r_PtxRegister28) + uint32_t(3);			   // PTX L3202
	r_bPtxPredicate55 = int32_t(r_PtxRegister1369) >= int32_t(r_PtxRegister3); // PTX L3203
	if (r_bPtxPredicate55)
	{
		goto L__BB59_112;
	} // PTX L3204
	r_LaneIndexAtPtx3206 = uint32_t((threadIdx.x & 31u)); // PTX L3206
	r_PtxU64Register396 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3206)) * int64_t(int32_t(16))); // PTX L3208
	g_ScratchByteAddressAtPtx3209 =
		uint64_t(g_ScratchByteAddressAtPtx3164) + uint64_t(r_PtxU64Register396);			   // PTX L3209
	g_ScratchByteAddressAtPtx3210 = uint64_t(g_ScratchByteAddressAtPtx3209) + uint64_t(32768); // PTX L3210
	StoreNoAllocate(g_ScratchByteAddressAtPtx3210,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2796R1093,
							   r_MmaAccumulatorHalf2WordAtPtx2796R1094,
							   r_MmaAccumulatorHalf2WordAtPtx2803R1099,
							   r_MmaAccumulatorHalf2WordAtPtx2803R1100)); // PTX L3212
	r_LaneIndexAtPtx3215 = uint32_t((threadIdx.x & 31u));				  // PTX L3215
	r_PtxU64Register398 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3215)) * int64_t(int32_t(16))); // PTX L3217
	g_ScratchByteAddressAtPtx3218 =
		uint64_t(g_ScratchByteAddressAtPtx3164) + uint64_t(r_PtxU64Register398);			   // PTX L3218
	g_ScratchByteAddressAtPtx3219 = uint64_t(g_ScratchByteAddressAtPtx3218) + uint64_t(33280); // PTX L3219
	StoreNoAllocate(g_ScratchByteAddressAtPtx3219,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2810R1101,
							   r_MmaAccumulatorHalf2WordAtPtx2810R1102,
							   r_MmaAccumulatorHalf2WordAtPtx2817R1103,
							   r_MmaAccumulatorHalf2WordAtPtx2817R1104)); // PTX L3221
	r_LaneIndexAtPtx3224 = uint32_t((threadIdx.x & 31u));				  // PTX L3224
	r_PtxU64Register400 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3224)) * int64_t(int32_t(16))); // PTX L3226
	g_ScratchByteAddressAtPtx3227 =
		uint64_t(g_ScratchByteAddressAtPtx3164) + uint64_t(r_PtxU64Register400);			   // PTX L3227
	g_ScratchByteAddressAtPtx3228 = uint64_t(g_ScratchByteAddressAtPtx3227) + uint64_t(33792); // PTX L3228
	StoreNoAllocate(g_ScratchByteAddressAtPtx3228,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2824R1105,
							   r_MmaAccumulatorHalf2WordAtPtx2824R1106,
							   r_MmaAccumulatorHalf2WordAtPtx2831R1107,
							   r_MmaAccumulatorHalf2WordAtPtx2831R1108)); // PTX L3230
	r_LaneIndexAtPtx3233 = uint32_t((threadIdx.x & 31u));				  // PTX L3233
	r_PtxU64Register402 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3233)) * int64_t(int32_t(16))); // PTX L3235
	g_ScratchByteAddressAtPtx3236 =
		uint64_t(g_ScratchByteAddressAtPtx3164) + uint64_t(r_PtxU64Register402);			   // PTX L3236
	g_ScratchByteAddressAtPtx3237 = uint64_t(g_ScratchByteAddressAtPtx3236) + uint64_t(34304); // PTX L3237
	StoreNoAllocate(g_ScratchByteAddressAtPtx3237,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx2838R1109,
							   r_MmaAccumulatorHalf2WordAtPtx2838R1110,
							   r_MmaAccumulatorHalf2WordAtPtx2845R1111,
							   r_MmaAccumulatorHalf2WordAtPtx2845R1112));					   // PTX L3239
	goto L__BB59_112;																		   // PTX L3241
L__BB59_72:																					   // PTX L3242
	r_PtxRegister33 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister2);					   // PTX L3243
	r_bPtxPredicate29 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister3);				   // PTX L3244
	r_PtxRegister1127 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(13));					   // PTX L3245
	r_PtxRegister1128 = uint32_t(r_PtxRegister1127) + uint32_t(r_PtxRegister7);				   // PTX L3246
	r_PtxU64Register222 = uint64_t(int64_t(int32_t(r_PtxRegister1128)) * int64_t(int32_t(4))); // PTX L3247
	g_ScratchByteAddressAtPtx3248 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register222);	 // PTX L3248
	r_PackedHalf2AtPtx3249R1490 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3249
	r_PackedHalf2AtPtx3250R1491 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3250
	r_PackedHalf2AtPtx3251R1492 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3251
	r_PackedHalf2AtPtx3252R1493 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3252
	if (r_bPtxPredicate29)
	{
		goto L__BB59_74;
	} // PTX L3253
	r_LaneIndexAtPtx3255 = uint32_t((threadIdx.x & 31u)); // PTX L3255
	r_PtxU64Register224 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3255)) * int64_t(int32_t(16))); // PTX L3257
	g_ScratchByteAddressAtPtx3258 =
		uint64_t(g_ScratchByteAddressAtPtx3248) + uint64_t(r_PtxU64Register224); // PTX L3258
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3258));
		r_PackedHalf2AtPtx3249R1490 = r_Value.x;
		r_PackedHalf2AtPtx3250R1491 = r_Value.y;
		r_PackedHalf2AtPtx3251R1492 = r_Value.z;
		r_PackedHalf2AtPtx3252R1493 = r_Value.w;
	} // PTX L3260
L__BB59_74:																					 // PTX L3262
	r_bPtxPredicate30 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister3);				 // PTX L3263
	g_ScratchByteAddressAtPtx3264 = uint64_t(g_ScratchByteAddressAtPtx3248) + uint64_t(512); // PTX L3264
	r_PackedHalf2AtPtx3265R1494 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3265
	r_PackedHalf2AtPtx3266R1495 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3266
	r_PackedHalf2AtPtx3267R1496 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3267
	r_PackedHalf2AtPtx3268R1497 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3268
	if (r_bPtxPredicate30)
	{
		goto L__BB59_76;
	} // PTX L3269
	r_LaneIndexAtPtx3271 = uint32_t((threadIdx.x & 31u)); // PTX L3271
	r_PtxU64Register226 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3271)) * int64_t(int32_t(16))); // PTX L3273
	g_ScratchByteAddressAtPtx3274 =
		uint64_t(g_ScratchByteAddressAtPtx3264) + uint64_t(r_PtxU64Register226); // PTX L3274
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3274));
		r_PackedHalf2AtPtx3265R1494 = r_Value.x;
		r_PackedHalf2AtPtx3266R1495 = r_Value.y;
		r_PackedHalf2AtPtx3267R1496 = r_Value.z;
		r_PackedHalf2AtPtx3268R1497 = r_Value.w;
	} // PTX L3276
L__BB59_76:																					 // PTX L3278
	r_bPtxPredicate31 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister3);				 // PTX L3279
	g_ScratchByteAddressAtPtx3280 = uint64_t(g_ScratchByteAddressAtPtx3264) + uint64_t(512); // PTX L3280
	r_PackedHalf2AtPtx3281R1498 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3281
	r_PackedHalf2AtPtx3282R1499 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3282
	r_PackedHalf2AtPtx3283R1500 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3283
	r_PackedHalf2AtPtx3284R1501 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3284
	if (r_bPtxPredicate31)
	{
		goto L__BB59_78;
	} // PTX L3285
	r_LaneIndexAtPtx3287 = uint32_t((threadIdx.x & 31u)); // PTX L3287
	r_PtxU64Register228 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3287)) * int64_t(int32_t(16))); // PTX L3289
	g_ScratchByteAddressAtPtx3290 =
		uint64_t(g_ScratchByteAddressAtPtx3280) + uint64_t(r_PtxU64Register228); // PTX L3290
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3290));
		r_PackedHalf2AtPtx3281R1498 = r_Value.x;
		r_PackedHalf2AtPtx3282R1499 = r_Value.y;
		r_PackedHalf2AtPtx3283R1500 = r_Value.z;
		r_PackedHalf2AtPtx3284R1501 = r_Value.w;
	} // PTX L3292
L__BB59_78:																					 // PTX L3294
	r_bPtxPredicate32 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister3);				 // PTX L3295
	g_ScratchByteAddressAtPtx3296 = uint64_t(g_ScratchByteAddressAtPtx3280) + uint64_t(512); // PTX L3296
	r_PackedHalf2AtPtx3297R1502 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3297
	r_PackedHalf2AtPtx3298R1503 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3298
	r_PackedHalf2AtPtx3299R1504 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3299
	r_PackedHalf2AtPtx3300R1505 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3300
	if (r_bPtxPredicate32)
	{
		goto L__BB59_80;
	} // PTX L3301
	r_LaneIndexAtPtx3303 = uint32_t((threadIdx.x & 31u)); // PTX L3303
	r_PtxU64Register230 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3303)) * int64_t(int32_t(16))); // PTX L3305
	g_ScratchByteAddressAtPtx3306 =
		uint64_t(g_ScratchByteAddressAtPtx3296) + uint64_t(r_PtxU64Register230); // PTX L3306
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3306));
		r_PackedHalf2AtPtx3297R1502 = r_Value.x;
		r_PackedHalf2AtPtx3298R1503 = r_Value.y;
		r_PackedHalf2AtPtx3299R1504 = r_Value.z;
		r_PackedHalf2AtPtx3300R1505 = r_Value.w;
	} // PTX L3308
L__BB59_80:																					   // PTX L3310
	r_PtxRegister34 = uint32_t(r_PtxRegister33) + uint32_t(1);								   // PTX L3311
	r_bPtxPredicate33 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister3);				   // PTX L3312
	g_ScratchByteAddressAtPtx3313 = uint64_t(g_ScratchByteAddressAtPtx3296) + uint64_t(31232); // PTX L3313
	r_PackedHalf2AtPtx3314R1506 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3314
	r_PackedHalf2AtPtx3315R1507 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3315
	r_PackedHalf2AtPtx3316R1508 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3316
	r_PackedHalf2AtPtx3317R1509 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3317
	if (r_bPtxPredicate33)
	{
		goto L__BB59_82;
	} // PTX L3318
	r_LaneIndexAtPtx3320 = uint32_t((threadIdx.x & 31u)); // PTX L3320
	r_PtxU64Register232 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3320)) * int64_t(int32_t(16))); // PTX L3322
	g_ScratchByteAddressAtPtx3323 =
		uint64_t(g_ScratchByteAddressAtPtx3313) + uint64_t(r_PtxU64Register232); // PTX L3323
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3323));
		r_PackedHalf2AtPtx3314R1506 = r_Value.x;
		r_PackedHalf2AtPtx3315R1507 = r_Value.y;
		r_PackedHalf2AtPtx3316R1508 = r_Value.z;
		r_PackedHalf2AtPtx3317R1509 = r_Value.w;
	} // PTX L3325
L__BB59_82:																					 // PTX L3327
	r_bPtxPredicate34 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister3);				 // PTX L3328
	g_ScratchByteAddressAtPtx3329 = uint64_t(g_ScratchByteAddressAtPtx3313) + uint64_t(512); // PTX L3329
	r_PackedHalf2AtPtx3330R1510 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3330
	r_PackedHalf2AtPtx3331R1511 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3331
	r_PackedHalf2AtPtx3332R1512 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3332
	r_PackedHalf2AtPtx3333R1513 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3333
	if (r_bPtxPredicate34)
	{
		goto L__BB59_84;
	} // PTX L3334
	r_LaneIndexAtPtx3336 = uint32_t((threadIdx.x & 31u)); // PTX L3336
	r_PtxU64Register234 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3336)) * int64_t(int32_t(16))); // PTX L3338
	g_ScratchByteAddressAtPtx3339 =
		uint64_t(g_ScratchByteAddressAtPtx3329) + uint64_t(r_PtxU64Register234); // PTX L3339
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3339));
		r_PackedHalf2AtPtx3330R1510 = r_Value.x;
		r_PackedHalf2AtPtx3331R1511 = r_Value.y;
		r_PackedHalf2AtPtx3332R1512 = r_Value.z;
		r_PackedHalf2AtPtx3333R1513 = r_Value.w;
	} // PTX L3341
L__BB59_84:																					 // PTX L3343
	r_bPtxPredicate35 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister3);				 // PTX L3344
	g_ScratchByteAddressAtPtx3345 = uint64_t(g_ScratchByteAddressAtPtx3329) + uint64_t(512); // PTX L3345
	r_PackedHalf2AtPtx3346R1514 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3346
	r_PackedHalf2AtPtx3347R1515 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3347
	r_PackedHalf2AtPtx3348R1516 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3348
	r_PackedHalf2AtPtx3349R1517 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3349
	if (r_bPtxPredicate35)
	{
		goto L__BB59_86;
	} // PTX L3350
	r_LaneIndexAtPtx3352 = uint32_t((threadIdx.x & 31u)); // PTX L3352
	r_PtxU64Register236 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3352)) * int64_t(int32_t(16))); // PTX L3354
	g_ScratchByteAddressAtPtx3355 =
		uint64_t(g_ScratchByteAddressAtPtx3345) + uint64_t(r_PtxU64Register236); // PTX L3355
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3355));
		r_PackedHalf2AtPtx3346R1514 = r_Value.x;
		r_PackedHalf2AtPtx3347R1515 = r_Value.y;
		r_PackedHalf2AtPtx3348R1516 = r_Value.z;
		r_PackedHalf2AtPtx3349R1517 = r_Value.w;
	} // PTX L3357
L__BB59_86:																					 // PTX L3359
	r_bPtxPredicate36 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister3);				 // PTX L3360
	g_ScratchByteAddressAtPtx3361 = uint64_t(g_ScratchByteAddressAtPtx3345) + uint64_t(512); // PTX L3361
	r_PackedHalf2AtPtx3362R1518 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3362
	r_PackedHalf2AtPtx3363R1519 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3363
	r_PackedHalf2AtPtx3364R1520 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3364
	r_PackedHalf2AtPtx3365R1521 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3365
	if (r_bPtxPredicate36)
	{
		goto L__BB59_88;
	} // PTX L3366
	r_LaneIndexAtPtx3368 = uint32_t((threadIdx.x & 31u)); // PTX L3368
	r_PtxU64Register238 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3368)) * int64_t(int32_t(16))); // PTX L3370
	g_ScratchByteAddressAtPtx3371 =
		uint64_t(g_ScratchByteAddressAtPtx3361) + uint64_t(r_PtxU64Register238); // PTX L3371
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3371));
		r_PackedHalf2AtPtx3362R1518 = r_Value.x;
		r_PackedHalf2AtPtx3363R1519 = r_Value.y;
		r_PackedHalf2AtPtx3364R1520 = r_Value.z;
		r_PackedHalf2AtPtx3365R1521 = r_Value.w;
	} // PTX L3373
L__BB59_88:																					   // PTX L3375
	r_PtxRegister35 = uint32_t(r_PtxRegister33) + uint32_t(2);								   // PTX L3376
	r_bPtxPredicate37 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister3);				   // PTX L3377
	g_ScratchByteAddressAtPtx3378 = uint64_t(g_ScratchByteAddressAtPtx3361) + uint64_t(31232); // PTX L3378
	r_PackedHalf2AtPtx3379R1522 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3379
	r_PackedHalf2AtPtx3380R1523 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3380
	r_PackedHalf2AtPtx3381R1524 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3381
	r_PackedHalf2AtPtx3382R1525 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3382
	if (r_bPtxPredicate37)
	{
		goto L__BB59_90;
	} // PTX L3383
	r_LaneIndexAtPtx3385 = uint32_t((threadIdx.x & 31u)); // PTX L3385
	r_PtxU64Register240 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3385)) * int64_t(int32_t(16))); // PTX L3387
	g_ScratchByteAddressAtPtx3388 =
		uint64_t(g_ScratchByteAddressAtPtx3378) + uint64_t(r_PtxU64Register240); // PTX L3388
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3388));
		r_PackedHalf2AtPtx3379R1522 = r_Value.x;
		r_PackedHalf2AtPtx3380R1523 = r_Value.y;
		r_PackedHalf2AtPtx3381R1524 = r_Value.z;
		r_PackedHalf2AtPtx3382R1525 = r_Value.w;
	} // PTX L3390
L__BB59_90:																					 // PTX L3392
	r_bPtxPredicate38 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister3);				 // PTX L3393
	g_ScratchByteAddressAtPtx3394 = uint64_t(g_ScratchByteAddressAtPtx3378) + uint64_t(512); // PTX L3394
	r_PackedHalf2AtPtx3395R1526 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3395
	r_PackedHalf2AtPtx3396R1527 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3396
	r_PackedHalf2AtPtx3397R1528 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3397
	r_PackedHalf2AtPtx3398R1529 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3398
	if (r_bPtxPredicate38)
	{
		goto L__BB59_92;
	} // PTX L3399
	r_LaneIndexAtPtx3401 = uint32_t((threadIdx.x & 31u)); // PTX L3401
	r_PtxU64Register242 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3401)) * int64_t(int32_t(16))); // PTX L3403
	g_ScratchByteAddressAtPtx3404 =
		uint64_t(g_ScratchByteAddressAtPtx3394) + uint64_t(r_PtxU64Register242); // PTX L3404
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3404));
		r_PackedHalf2AtPtx3395R1526 = r_Value.x;
		r_PackedHalf2AtPtx3396R1527 = r_Value.y;
		r_PackedHalf2AtPtx3397R1528 = r_Value.z;
		r_PackedHalf2AtPtx3398R1529 = r_Value.w;
	} // PTX L3406
L__BB59_92:																					 // PTX L3408
	r_bPtxPredicate39 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister3);				 // PTX L3409
	g_ScratchByteAddressAtPtx3410 = uint64_t(g_ScratchByteAddressAtPtx3394) + uint64_t(512); // PTX L3410
	r_PackedHalf2AtPtx3411R1530 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3411
	r_PackedHalf2AtPtx3412R1531 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3412
	r_PackedHalf2AtPtx3413R1532 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3413
	r_PackedHalf2AtPtx3414R1533 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3414
	if (r_bPtxPredicate39)
	{
		goto L__BB59_94;
	} // PTX L3415
	r_LaneIndexAtPtx3417 = uint32_t((threadIdx.x & 31u)); // PTX L3417
	r_PtxU64Register244 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3417)) * int64_t(int32_t(16))); // PTX L3419
	g_ScratchByteAddressAtPtx3420 =
		uint64_t(g_ScratchByteAddressAtPtx3410) + uint64_t(r_PtxU64Register244); // PTX L3420
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3420));
		r_PackedHalf2AtPtx3411R1530 = r_Value.x;
		r_PackedHalf2AtPtx3412R1531 = r_Value.y;
		r_PackedHalf2AtPtx3413R1532 = r_Value.z;
		r_PackedHalf2AtPtx3414R1533 = r_Value.w;
	} // PTX L3422
L__BB59_94:																					 // PTX L3424
	r_bPtxPredicate40 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister3);				 // PTX L3425
	g_ScratchByteAddressAtPtx3426 = uint64_t(g_ScratchByteAddressAtPtx3410) + uint64_t(512); // PTX L3426
	r_PackedHalf2AtPtx3427R1534 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3427
	r_PackedHalf2AtPtx3428R1535 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3428
	r_PackedHalf2AtPtx3429R1536 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3429
	r_PackedHalf2AtPtx3430R1537 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3430
	if (r_bPtxPredicate40)
	{
		goto L__BB59_96;
	} // PTX L3431
	r_LaneIndexAtPtx3433 = uint32_t((threadIdx.x & 31u)); // PTX L3433
	r_PtxU64Register246 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3433)) * int64_t(int32_t(16))); // PTX L3435
	g_ScratchByteAddressAtPtx3436 =
		uint64_t(g_ScratchByteAddressAtPtx3426) + uint64_t(r_PtxU64Register246); // PTX L3436
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3436));
		r_PackedHalf2AtPtx3427R1534 = r_Value.x;
		r_PackedHalf2AtPtx3428R1535 = r_Value.y;
		r_PackedHalf2AtPtx3429R1536 = r_Value.z;
		r_PackedHalf2AtPtx3430R1537 = r_Value.w;
	} // PTX L3438
L__BB59_96:																					   // PTX L3440
	r_PtxRegister36 = uint32_t(r_PtxRegister33) + uint32_t(3);								   // PTX L3441
	r_bPtxPredicate41 = int32_t(r_PtxRegister36) >= int32_t(r_PtxRegister3);				   // PTX L3442
	g_ScratchByteAddressAtPtx3443 = uint64_t(g_ScratchByteAddressAtPtx3426) + uint64_t(31232); // PTX L3443
	r_PackedHalf2AtPtx3444R1538 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3444
	r_PackedHalf2AtPtx3445R1539 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3445
	r_PackedHalf2AtPtx3446R1540 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3446
	r_PackedHalf2AtPtx3447R1541 = uint32_t(r_PackedHalf2AtPtx3501R1550);					   // PTX L3447
	if (r_bPtxPredicate41)
	{
		goto L__BB59_98;
	} // PTX L3448
	r_LaneIndexAtPtx3450 = uint32_t((threadIdx.x & 31u)); // PTX L3450
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3450)) * int64_t(int32_t(16))); // PTX L3452
	g_ScratchByteAddressAtPtx3453 =
		uint64_t(g_ScratchByteAddressAtPtx3443) + uint64_t(r_PtxU64Register248); // PTX L3453
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3453));
		r_PackedHalf2AtPtx3444R1538 = r_Value.x;
		r_PackedHalf2AtPtx3445R1539 = r_Value.y;
		r_PackedHalf2AtPtx3446R1540 = r_Value.z;
		r_PackedHalf2AtPtx3447R1541 = r_Value.w;
	} // PTX L3455
L__BB59_98:																					 // PTX L3457
	r_bPtxPredicate42 = int32_t(r_PtxRegister36) >= int32_t(r_PtxRegister3);				 // PTX L3458
	g_ScratchByteAddressAtPtx3459 = uint64_t(g_ScratchByteAddressAtPtx3443) + uint64_t(512); // PTX L3459
	r_PackedHalf2AtPtx3460R1542 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3460
	r_PackedHalf2AtPtx3461R1543 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3461
	r_PackedHalf2AtPtx3462R1544 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3462
	r_PackedHalf2AtPtx3463R1545 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3463
	if (r_bPtxPredicate42)
	{
		goto L__BB59_100;
	} // PTX L3464
	r_LaneIndexAtPtx3466 = uint32_t((threadIdx.x & 31u)); // PTX L3466
	r_PtxU64Register250 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3466)) * int64_t(int32_t(16))); // PTX L3468
	g_ScratchByteAddressAtPtx3469 =
		uint64_t(g_ScratchByteAddressAtPtx3459) + uint64_t(r_PtxU64Register250); // PTX L3469
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3469));
		r_PackedHalf2AtPtx3460R1542 = r_Value.x;
		r_PackedHalf2AtPtx3461R1543 = r_Value.y;
		r_PackedHalf2AtPtx3462R1544 = r_Value.z;
		r_PackedHalf2AtPtx3463R1545 = r_Value.w;
	} // PTX L3471
L__BB59_100:																				 // PTX L3473
	r_bPtxPredicate43 = int32_t(r_PtxRegister36) >= int32_t(r_PtxRegister3);				 // PTX L3474
	g_ScratchByteAddressAtPtx3475 = uint64_t(g_ScratchByteAddressAtPtx3459) + uint64_t(512); // PTX L3475
	r_PackedHalf2AtPtx3476R1546 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3476
	r_PackedHalf2AtPtx3477R1547 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3477
	r_PackedHalf2AtPtx3478R1548 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3478
	r_PackedHalf2AtPtx3479R1549 = uint32_t(r_PackedHalf2AtPtx3501R1550);					 // PTX L3479
	if (r_bPtxPredicate43)
	{
		goto L__BB59_102;
	} // PTX L3480
	r_LaneIndexAtPtx3482 = uint32_t((threadIdx.x & 31u)); // PTX L3482
	r_PtxU64Register252 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3482)) * int64_t(int32_t(16))); // PTX L3484
	g_ScratchByteAddressAtPtx3485 =
		uint64_t(g_ScratchByteAddressAtPtx3475) + uint64_t(r_PtxU64Register252); // PTX L3485
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3485));
		r_PackedHalf2AtPtx3476R1546 = r_Value.x;
		r_PackedHalf2AtPtx3477R1547 = r_Value.y;
		r_PackedHalf2AtPtx3478R1548 = r_Value.z;
		r_PackedHalf2AtPtx3479R1549 = r_Value.w;
	} // PTX L3487
L__BB59_102:															 // PTX L3489
	r_PackedHalf2AtPtx3490R1551 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3490
	r_PackedHalf2AtPtx3491R1552 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3491
	r_PackedHalf2AtPtx3492R1553 = uint32_t(r_PackedHalf2AtPtx3501R1550); // PTX L3492
	if (r_bPtxPredicate43)
	{
		goto L__BB59_104;
	} // PTX L3493
	r_LaneIndexAtPtx3495 = uint32_t((threadIdx.x & 31u)); // PTX L3495
	r_PtxU64Register254 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3495)) * int64_t(int32_t(16))); // PTX L3497
	g_ScratchByteAddressAtPtx3498 =
		uint64_t(g_ScratchByteAddressAtPtx3475) + uint64_t(r_PtxU64Register254);			 // PTX L3498
	g_ScratchByteAddressAtPtx3499 = uint64_t(g_ScratchByteAddressAtPtx3498) + uint64_t(512); // PTX L3499
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx3499));
		r_PackedHalf2AtPtx3501R1550 = r_Value.x;
		r_PackedHalf2AtPtx3490R1551 = r_Value.y;
		r_PackedHalf2AtPtx3491R1552 = r_Value.z;
		r_PackedHalf2AtPtx3492R1553 = r_Value.w;
	} // PTX L3501
L__BB59_104:																 // PTX L3503
	r_bPtxPredicate44 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister3); // PTX L3504
	r_LaneIndexAtPtx3506 = uint32_t((threadIdx.x & 31u));					 // PTX L3506
	r_PackedHalf2AtPtx3509R1209 =
		HalfAdd(r_PackedHalf2AtPtx3249R1490, r_MmaAccumulatorHalf2WordAtPtx2628R1033); // PTX L3509
	r_LaneIndexAtPtx3513 = uint32_t((threadIdx.x & 31u));							   // PTX L3513
	r_PackedHalf2AtPtx3516R1211 =
		HalfAdd(r_PackedHalf2AtPtx3250R1491, r_MmaAccumulatorHalf2WordAtPtx2628R1034); // PTX L3516
	r_LaneIndexAtPtx3520 = uint32_t((threadIdx.x & 31u));							   // PTX L3520
	r_PackedHalf2AtPtx3523R1210 =
		HalfAdd(r_PackedHalf2AtPtx3251R1492, r_MmaAccumulatorHalf2WordAtPtx2635R1039); // PTX L3523
	r_LaneIndexAtPtx3527 = uint32_t((threadIdx.x & 31u));							   // PTX L3527
	r_PackedHalf2AtPtx3530R1212 =
		HalfAdd(r_PackedHalf2AtPtx3252R1493, r_MmaAccumulatorHalf2WordAtPtx2635R1040); // PTX L3530
	r_LaneIndexAtPtx3534 = uint32_t((threadIdx.x & 31u));							   // PTX L3534
	r_PackedHalf2AtPtx3537R1213 =
		HalfAdd(r_PackedHalf2AtPtx3265R1494, r_MmaAccumulatorHalf2WordAtPtx2642R1041); // PTX L3537
	r_LaneIndexAtPtx3541 = uint32_t((threadIdx.x & 31u));							   // PTX L3541
	r_PackedHalf2AtPtx3544R1215 =
		HalfAdd(r_PackedHalf2AtPtx3266R1495, r_MmaAccumulatorHalf2WordAtPtx2642R1042); // PTX L3544
	r_LaneIndexAtPtx3548 = uint32_t((threadIdx.x & 31u));							   // PTX L3548
	r_PackedHalf2AtPtx3551R1214 =
		HalfAdd(r_PackedHalf2AtPtx3267R1496, r_MmaAccumulatorHalf2WordAtPtx2649R1043); // PTX L3551
	r_LaneIndexAtPtx3555 = uint32_t((threadIdx.x & 31u));							   // PTX L3555
	r_PackedHalf2AtPtx3558R1216 =
		HalfAdd(r_PackedHalf2AtPtx3268R1497, r_MmaAccumulatorHalf2WordAtPtx2649R1044); // PTX L3558
	r_LaneIndexAtPtx3562 = uint32_t((threadIdx.x & 31u));							   // PTX L3562
	r_PackedHalf2AtPtx3565R1217 =
		HalfAdd(r_PackedHalf2AtPtx3281R1498, r_MmaAccumulatorHalf2WordAtPtx2656R1045); // PTX L3565
	r_LaneIndexAtPtx3569 = uint32_t((threadIdx.x & 31u));							   // PTX L3569
	r_PackedHalf2AtPtx3572R1219 =
		HalfAdd(r_PackedHalf2AtPtx3282R1499, r_MmaAccumulatorHalf2WordAtPtx2656R1046); // PTX L3572
	r_LaneIndexAtPtx3576 = uint32_t((threadIdx.x & 31u));							   // PTX L3576
	r_PackedHalf2AtPtx3579R1218 =
		HalfAdd(r_PackedHalf2AtPtx3283R1500, r_MmaAccumulatorHalf2WordAtPtx2663R1047); // PTX L3579
	r_LaneIndexAtPtx3583 = uint32_t((threadIdx.x & 31u));							   // PTX L3583
	r_PackedHalf2AtPtx3586R1220 =
		HalfAdd(r_PackedHalf2AtPtx3284R1501, r_MmaAccumulatorHalf2WordAtPtx2663R1048); // PTX L3586
	r_LaneIndexAtPtx3590 = uint32_t((threadIdx.x & 31u));							   // PTX L3590
	r_PackedHalf2AtPtx3593R1221 =
		HalfAdd(r_PackedHalf2AtPtx3297R1502, r_MmaAccumulatorHalf2WordAtPtx2670R1049); // PTX L3593
	r_LaneIndexAtPtx3597 = uint32_t((threadIdx.x & 31u));							   // PTX L3597
	r_PackedHalf2AtPtx3600R1223 =
		HalfAdd(r_PackedHalf2AtPtx3298R1503, r_MmaAccumulatorHalf2WordAtPtx2670R1050); // PTX L3600
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));							   // PTX L3604
	r_PackedHalf2AtPtx3607R1222 =
		HalfAdd(r_PackedHalf2AtPtx3299R1504, r_MmaAccumulatorHalf2WordAtPtx2677R1051); // PTX L3607
	r_LaneIndexAtPtx3611 = uint32_t((threadIdx.x & 31u));							   // PTX L3611
	r_PackedHalf2AtPtx3614R1224 =
		HalfAdd(r_PackedHalf2AtPtx3300R1505, r_MmaAccumulatorHalf2WordAtPtx2677R1052); // PTX L3614
	r_LaneIndexAtPtx3618 = uint32_t((threadIdx.x & 31u));							   // PTX L3618
	r_PackedHalf2AtPtx3621R1225 =
		HalfAdd(r_PackedHalf2AtPtx3314R1506, r_MmaAccumulatorHalf2WordAtPtx2684R1053); // PTX L3621
	r_LaneIndexAtPtx3625 = uint32_t((threadIdx.x & 31u));							   // PTX L3625
	r_PackedHalf2AtPtx3628R1227 =
		HalfAdd(r_PackedHalf2AtPtx3315R1507, r_MmaAccumulatorHalf2WordAtPtx2684R1054); // PTX L3628
	r_LaneIndexAtPtx3632 = uint32_t((threadIdx.x & 31u));							   // PTX L3632
	r_PackedHalf2AtPtx3635R1226 =
		HalfAdd(r_PackedHalf2AtPtx3316R1508, r_MmaAccumulatorHalf2WordAtPtx2691R1059); // PTX L3635
	r_LaneIndexAtPtx3639 = uint32_t((threadIdx.x & 31u));							   // PTX L3639
	r_PackedHalf2AtPtx3642R1228 =
		HalfAdd(r_PackedHalf2AtPtx3317R1509, r_MmaAccumulatorHalf2WordAtPtx2691R1060); // PTX L3642
	r_LaneIndexAtPtx3646 = uint32_t((threadIdx.x & 31u));							   // PTX L3646
	r_PackedHalf2AtPtx3649R1229 =
		HalfAdd(r_PackedHalf2AtPtx3330R1510, r_MmaAccumulatorHalf2WordAtPtx2698R1061); // PTX L3649
	r_LaneIndexAtPtx3653 = uint32_t((threadIdx.x & 31u));							   // PTX L3653
	r_PackedHalf2AtPtx3656R1231 =
		HalfAdd(r_PackedHalf2AtPtx3331R1511, r_MmaAccumulatorHalf2WordAtPtx2698R1062); // PTX L3656
	r_LaneIndexAtPtx3660 = uint32_t((threadIdx.x & 31u));							   // PTX L3660
	r_PackedHalf2AtPtx3663R1230 =
		HalfAdd(r_PackedHalf2AtPtx3332R1512, r_MmaAccumulatorHalf2WordAtPtx2705R1063); // PTX L3663
	r_LaneIndexAtPtx3667 = uint32_t((threadIdx.x & 31u));							   // PTX L3667
	r_PackedHalf2AtPtx3670R1232 =
		HalfAdd(r_PackedHalf2AtPtx3333R1513, r_MmaAccumulatorHalf2WordAtPtx2705R1064); // PTX L3670
	r_LaneIndexAtPtx3674 = uint32_t((threadIdx.x & 31u));							   // PTX L3674
	r_PackedHalf2AtPtx3677R1233 =
		HalfAdd(r_PackedHalf2AtPtx3346R1514, r_MmaAccumulatorHalf2WordAtPtx2712R1065); // PTX L3677
	r_LaneIndexAtPtx3681 = uint32_t((threadIdx.x & 31u));							   // PTX L3681
	r_PackedHalf2AtPtx3684R1235 =
		HalfAdd(r_PackedHalf2AtPtx3347R1515, r_MmaAccumulatorHalf2WordAtPtx2712R1066); // PTX L3684
	r_LaneIndexAtPtx3688 = uint32_t((threadIdx.x & 31u));							   // PTX L3688
	r_PackedHalf2AtPtx3691R1234 =
		HalfAdd(r_PackedHalf2AtPtx3348R1516, r_MmaAccumulatorHalf2WordAtPtx2719R1067); // PTX L3691
	r_LaneIndexAtPtx3695 = uint32_t((threadIdx.x & 31u));							   // PTX L3695
	r_PackedHalf2AtPtx3698R1236 =
		HalfAdd(r_PackedHalf2AtPtx3349R1517, r_MmaAccumulatorHalf2WordAtPtx2719R1068); // PTX L3698
	r_LaneIndexAtPtx3702 = uint32_t((threadIdx.x & 31u));							   // PTX L3702
	r_PackedHalf2AtPtx3705R1237 =
		HalfAdd(r_PackedHalf2AtPtx3362R1518, r_MmaAccumulatorHalf2WordAtPtx2726R1069); // PTX L3705
	r_LaneIndexAtPtx3709 = uint32_t((threadIdx.x & 31u));							   // PTX L3709
	r_PackedHalf2AtPtx3712R1239 =
		HalfAdd(r_PackedHalf2AtPtx3363R1519, r_MmaAccumulatorHalf2WordAtPtx2726R1070); // PTX L3712
	r_LaneIndexAtPtx3716 = uint32_t((threadIdx.x & 31u));							   // PTX L3716
	r_PackedHalf2AtPtx3719R1238 =
		HalfAdd(r_PackedHalf2AtPtx3364R1520, r_MmaAccumulatorHalf2WordAtPtx2733R1071); // PTX L3719
	r_LaneIndexAtPtx3723 = uint32_t((threadIdx.x & 31u));							   // PTX L3723
	r_PackedHalf2AtPtx3726R1240 =
		HalfAdd(r_PackedHalf2AtPtx3365R1521, r_MmaAccumulatorHalf2WordAtPtx2733R1072); // PTX L3726
	r_LaneIndexAtPtx3730 = uint32_t((threadIdx.x & 31u));							   // PTX L3730
	r_PackedHalf2AtPtx3733R1241 =
		HalfAdd(r_PackedHalf2AtPtx3379R1522, r_MmaAccumulatorHalf2WordAtPtx2740R1073); // PTX L3733
	r_LaneIndexAtPtx3737 = uint32_t((threadIdx.x & 31u));							   // PTX L3737
	r_PackedHalf2AtPtx3740R1243 =
		HalfAdd(r_PackedHalf2AtPtx3380R1523, r_MmaAccumulatorHalf2WordAtPtx2740R1074); // PTX L3740
	r_LaneIndexAtPtx3744 = uint32_t((threadIdx.x & 31u));							   // PTX L3744
	r_PackedHalf2AtPtx3747R1242 =
		HalfAdd(r_PackedHalf2AtPtx3381R1524, r_MmaAccumulatorHalf2WordAtPtx2747R1079); // PTX L3747
	r_LaneIndexAtPtx3751 = uint32_t((threadIdx.x & 31u));							   // PTX L3751
	r_PackedHalf2AtPtx3754R1244 =
		HalfAdd(r_PackedHalf2AtPtx3382R1525, r_MmaAccumulatorHalf2WordAtPtx2747R1080); // PTX L3754
	r_LaneIndexAtPtx3758 = uint32_t((threadIdx.x & 31u));							   // PTX L3758
	r_PackedHalf2AtPtx3761R1245 =
		HalfAdd(r_PackedHalf2AtPtx3395R1526, r_MmaAccumulatorHalf2WordAtPtx2754R1081); // PTX L3761
	r_LaneIndexAtPtx3765 = uint32_t((threadIdx.x & 31u));							   // PTX L3765
	r_PackedHalf2AtPtx3768R1247 =
		HalfAdd(r_PackedHalf2AtPtx3396R1527, r_MmaAccumulatorHalf2WordAtPtx2754R1082); // PTX L3768
	r_LaneIndexAtPtx3772 = uint32_t((threadIdx.x & 31u));							   // PTX L3772
	r_PackedHalf2AtPtx3775R1246 =
		HalfAdd(r_PackedHalf2AtPtx3397R1528, r_MmaAccumulatorHalf2WordAtPtx2761R1083); // PTX L3775
	r_LaneIndexAtPtx3779 = uint32_t((threadIdx.x & 31u));							   // PTX L3779
	r_PackedHalf2AtPtx3782R1248 =
		HalfAdd(r_PackedHalf2AtPtx3398R1529, r_MmaAccumulatorHalf2WordAtPtx2761R1084); // PTX L3782
	r_LaneIndexAtPtx3786 = uint32_t((threadIdx.x & 31u));							   // PTX L3786
	r_PackedHalf2AtPtx3789R1249 =
		HalfAdd(r_PackedHalf2AtPtx3411R1530, r_MmaAccumulatorHalf2WordAtPtx2768R1085); // PTX L3789
	r_LaneIndexAtPtx3793 = uint32_t((threadIdx.x & 31u));							   // PTX L3793
	r_PackedHalf2AtPtx3796R1251 =
		HalfAdd(r_PackedHalf2AtPtx3412R1531, r_MmaAccumulatorHalf2WordAtPtx2768R1086); // PTX L3796
	r_LaneIndexAtPtx3800 = uint32_t((threadIdx.x & 31u));							   // PTX L3800
	r_PackedHalf2AtPtx3803R1250 =
		HalfAdd(r_PackedHalf2AtPtx3413R1532, r_MmaAccumulatorHalf2WordAtPtx2775R1087); // PTX L3803
	r_LaneIndexAtPtx3807 = uint32_t((threadIdx.x & 31u));							   // PTX L3807
	r_PackedHalf2AtPtx3810R1252 =
		HalfAdd(r_PackedHalf2AtPtx3414R1533, r_MmaAccumulatorHalf2WordAtPtx2775R1088); // PTX L3810
	r_LaneIndexAtPtx3814 = uint32_t((threadIdx.x & 31u));							   // PTX L3814
	r_PackedHalf2AtPtx3817R1253 =
		HalfAdd(r_PackedHalf2AtPtx3427R1534, r_MmaAccumulatorHalf2WordAtPtx2782R1089); // PTX L3817
	r_LaneIndexAtPtx3821 = uint32_t((threadIdx.x & 31u));							   // PTX L3821
	r_PackedHalf2AtPtx3824R1255 =
		HalfAdd(r_PackedHalf2AtPtx3428R1535, r_MmaAccumulatorHalf2WordAtPtx2782R1090); // PTX L3824
	r_LaneIndexAtPtx3828 = uint32_t((threadIdx.x & 31u));							   // PTX L3828
	r_PackedHalf2AtPtx3831R1254 =
		HalfAdd(r_PackedHalf2AtPtx3429R1536, r_MmaAccumulatorHalf2WordAtPtx2789R1091); // PTX L3831
	r_LaneIndexAtPtx3835 = uint32_t((threadIdx.x & 31u));							   // PTX L3835
	r_PackedHalf2AtPtx3838R1256 =
		HalfAdd(r_PackedHalf2AtPtx3430R1537, r_MmaAccumulatorHalf2WordAtPtx2789R1092); // PTX L3838
	r_LaneIndexAtPtx3842 = uint32_t((threadIdx.x & 31u));							   // PTX L3842
	r_PackedHalf2AtPtx3845R1257 =
		HalfAdd(r_PackedHalf2AtPtx3444R1538, r_MmaAccumulatorHalf2WordAtPtx2796R1093); // PTX L3845
	r_LaneIndexAtPtx3849 = uint32_t((threadIdx.x & 31u));							   // PTX L3849
	r_PackedHalf2AtPtx3852R1259 =
		HalfAdd(r_PackedHalf2AtPtx3445R1539, r_MmaAccumulatorHalf2WordAtPtx2796R1094); // PTX L3852
	r_LaneIndexAtPtx3856 = uint32_t((threadIdx.x & 31u));							   // PTX L3856
	r_PackedHalf2AtPtx3859R1258 =
		HalfAdd(r_PackedHalf2AtPtx3446R1540, r_MmaAccumulatorHalf2WordAtPtx2803R1099); // PTX L3859
	r_LaneIndexAtPtx3863 = uint32_t((threadIdx.x & 31u));							   // PTX L3863
	r_PackedHalf2AtPtx3866R1260 =
		HalfAdd(r_PackedHalf2AtPtx3447R1541, r_MmaAccumulatorHalf2WordAtPtx2803R1100); // PTX L3866
	r_LaneIndexAtPtx3870 = uint32_t((threadIdx.x & 31u));							   // PTX L3870
	r_PackedHalf2AtPtx3873R1261 =
		HalfAdd(r_PackedHalf2AtPtx3460R1542, r_MmaAccumulatorHalf2WordAtPtx2810R1101); // PTX L3873
	r_LaneIndexAtPtx3877 = uint32_t((threadIdx.x & 31u));							   // PTX L3877
	r_PackedHalf2AtPtx3880R1263 =
		HalfAdd(r_PackedHalf2AtPtx3461R1543, r_MmaAccumulatorHalf2WordAtPtx2810R1102); // PTX L3880
	r_LaneIndexAtPtx3884 = uint32_t((threadIdx.x & 31u));							   // PTX L3884
	r_PackedHalf2AtPtx3887R1262 =
		HalfAdd(r_PackedHalf2AtPtx3462R1544, r_MmaAccumulatorHalf2WordAtPtx2817R1103); // PTX L3887
	r_LaneIndexAtPtx3891 = uint32_t((threadIdx.x & 31u));							   // PTX L3891
	r_PackedHalf2AtPtx3894R1264 =
		HalfAdd(r_PackedHalf2AtPtx3463R1545, r_MmaAccumulatorHalf2WordAtPtx2817R1104); // PTX L3894
	r_LaneIndexAtPtx3898 = uint32_t((threadIdx.x & 31u));							   // PTX L3898
	r_PackedHalf2AtPtx3901R1265 =
		HalfAdd(r_PackedHalf2AtPtx3476R1546, r_MmaAccumulatorHalf2WordAtPtx2824R1105); // PTX L3901
	r_LaneIndexAtPtx3905 = uint32_t((threadIdx.x & 31u));							   // PTX L3905
	r_PackedHalf2AtPtx3908R1267 =
		HalfAdd(r_PackedHalf2AtPtx3477R1547, r_MmaAccumulatorHalf2WordAtPtx2824R1106); // PTX L3908
	r_LaneIndexAtPtx3912 = uint32_t((threadIdx.x & 31u));							   // PTX L3912
	r_PackedHalf2AtPtx3915R1266 =
		HalfAdd(r_PackedHalf2AtPtx3478R1548, r_MmaAccumulatorHalf2WordAtPtx2831R1107); // PTX L3915
	r_LaneIndexAtPtx3919 = uint32_t((threadIdx.x & 31u));							   // PTX L3919
	r_PackedHalf2AtPtx3922R1268 =
		HalfAdd(r_PackedHalf2AtPtx3479R1549, r_MmaAccumulatorHalf2WordAtPtx2831R1108); // PTX L3922
	r_LaneIndexAtPtx3926 = uint32_t((threadIdx.x & 31u));							   // PTX L3926
	r_PackedHalf2AtPtx3929R1269 =
		HalfAdd(r_PackedHalf2AtPtx3501R1550, r_MmaAccumulatorHalf2WordAtPtx2838R1109); // PTX L3929
	r_LaneIndexAtPtx3933 = uint32_t((threadIdx.x & 31u));							   // PTX L3933
	r_PackedHalf2AtPtx3936R1271 =
		HalfAdd(r_PackedHalf2AtPtx3490R1551, r_MmaAccumulatorHalf2WordAtPtx2838R1110); // PTX L3936
	r_LaneIndexAtPtx3940 = uint32_t((threadIdx.x & 31u));							   // PTX L3940
	r_PackedHalf2AtPtx3943R1270 =
		HalfAdd(r_PackedHalf2AtPtx3491R1552, r_MmaAccumulatorHalf2WordAtPtx2845R1111); // PTX L3943
	r_LaneIndexAtPtx3947 = uint32_t((threadIdx.x & 31u));							   // PTX L3947
	r_PackedHalf2AtPtx3950R1272 =
		HalfAdd(r_PackedHalf2AtPtx3492R1553, r_MmaAccumulatorHalf2WordAtPtx2845R1112);			  // PTX L3950
	r_ConvertedE4PairAtPtx3954Rs89 = PublishE4(r_PackedHalf2AtPtx3509R1209);					  // PTX L3954
	r_ConvertedE4PairAtPtx3957Rs90 = PublishE4(r_PackedHalf2AtPtx3523R1210);					  // PTX L3957
	r_ConvertedE4PairAtPtx3960Rs91 = PublishE4(r_PackedHalf2AtPtx3516R1211);					  // PTX L3960
	r_ConvertedE4PairAtPtx3963Rs92 = PublishE4(r_PackedHalf2AtPtx3530R1212);					  // PTX L3963
	r_ConvertedE4PairAtPtx3966Rs93 = PublishE4(r_PackedHalf2AtPtx3537R1213);					  // PTX L3966
	r_ConvertedE4PairAtPtx3969Rs94 = PublishE4(r_PackedHalf2AtPtx3551R1214);					  // PTX L3969
	r_ConvertedE4PairAtPtx3972Rs95 = PublishE4(r_PackedHalf2AtPtx3544R1215);					  // PTX L3972
	r_ConvertedE4PairAtPtx3975Rs96 = PublishE4(r_PackedHalf2AtPtx3558R1216);					  // PTX L3975
	r_ConvertedE4PairAtPtx3978Rs97 = PublishE4(r_PackedHalf2AtPtx3565R1217);					  // PTX L3978
	r_ConvertedE4PairAtPtx3981Rs98 = PublishE4(r_PackedHalf2AtPtx3579R1218);					  // PTX L3981
	r_ConvertedE4PairAtPtx3984Rs99 = PublishE4(r_PackedHalf2AtPtx3572R1219);					  // PTX L3984
	r_ConvertedE4PairAtPtx3987Rs100 = PublishE4(r_PackedHalf2AtPtx3586R1220);					  // PTX L3987
	r_ConvertedE4PairAtPtx3990Rs101 = PublishE4(r_PackedHalf2AtPtx3593R1221);					  // PTX L3990
	r_ConvertedE4PairAtPtx3993Rs102 = PublishE4(r_PackedHalf2AtPtx3607R1222);					  // PTX L3993
	r_ConvertedE4PairAtPtx3996Rs103 = PublishE4(r_PackedHalf2AtPtx3600R1223);					  // PTX L3996
	r_ConvertedE4PairAtPtx3999Rs104 = PublishE4(r_PackedHalf2AtPtx3614R1224);					  // PTX L3999
	r_ConvertedE4PairAtPtx4002Rs105 = PublishE4(r_PackedHalf2AtPtx3621R1225);					  // PTX L4002
	r_ConvertedE4PairAtPtx4005Rs106 = PublishE4(r_PackedHalf2AtPtx3635R1226);					  // PTX L4005
	r_ConvertedE4PairAtPtx4008Rs107 = PublishE4(r_PackedHalf2AtPtx3628R1227);					  // PTX L4008
	r_ConvertedE4PairAtPtx4011Rs108 = PublishE4(r_PackedHalf2AtPtx3642R1228);					  // PTX L4011
	r_ConvertedE4PairAtPtx4014Rs109 = PublishE4(r_PackedHalf2AtPtx3649R1229);					  // PTX L4014
	r_ConvertedE4PairAtPtx4017Rs110 = PublishE4(r_PackedHalf2AtPtx3663R1230);					  // PTX L4017
	r_ConvertedE4PairAtPtx4020Rs111 = PublishE4(r_PackedHalf2AtPtx3656R1231);					  // PTX L4020
	r_ConvertedE4PairAtPtx4023Rs112 = PublishE4(r_PackedHalf2AtPtx3670R1232);					  // PTX L4023
	r_ConvertedE4PairAtPtx4026Rs113 = PublishE4(r_PackedHalf2AtPtx3677R1233);					  // PTX L4026
	r_ConvertedE4PairAtPtx4029Rs114 = PublishE4(r_PackedHalf2AtPtx3691R1234);					  // PTX L4029
	r_ConvertedE4PairAtPtx4032Rs115 = PublishE4(r_PackedHalf2AtPtx3684R1235);					  // PTX L4032
	r_ConvertedE4PairAtPtx4035Rs116 = PublishE4(r_PackedHalf2AtPtx3698R1236);					  // PTX L4035
	r_ConvertedE4PairAtPtx4038Rs117 = PublishE4(r_PackedHalf2AtPtx3705R1237);					  // PTX L4038
	r_ConvertedE4PairAtPtx4041Rs118 = PublishE4(r_PackedHalf2AtPtx3719R1238);					  // PTX L4041
	r_ConvertedE4PairAtPtx4044Rs119 = PublishE4(r_PackedHalf2AtPtx3712R1239);					  // PTX L4044
	r_ConvertedE4PairAtPtx4047Rs120 = PublishE4(r_PackedHalf2AtPtx3726R1240);					  // PTX L4047
	r_ConvertedE4PairAtPtx4050Rs121 = PublishE4(r_PackedHalf2AtPtx3733R1241);					  // PTX L4050
	r_ConvertedE4PairAtPtx4053Rs122 = PublishE4(r_PackedHalf2AtPtx3747R1242);					  // PTX L4053
	r_ConvertedE4PairAtPtx4056Rs123 = PublishE4(r_PackedHalf2AtPtx3740R1243);					  // PTX L4056
	r_ConvertedE4PairAtPtx4059Rs124 = PublishE4(r_PackedHalf2AtPtx3754R1244);					  // PTX L4059
	r_ConvertedE4PairAtPtx4062Rs125 = PublishE4(r_PackedHalf2AtPtx3761R1245);					  // PTX L4062
	r_ConvertedE4PairAtPtx4065Rs126 = PublishE4(r_PackedHalf2AtPtx3775R1246);					  // PTX L4065
	r_ConvertedE4PairAtPtx4068Rs127 = PublishE4(r_PackedHalf2AtPtx3768R1247);					  // PTX L4068
	r_ConvertedE4PairAtPtx4071Rs128 = PublishE4(r_PackedHalf2AtPtx3782R1248);					  // PTX L4071
	r_ConvertedE4PairAtPtx4074Rs129 = PublishE4(r_PackedHalf2AtPtx3789R1249);					  // PTX L4074
	r_ConvertedE4PairAtPtx4077Rs130 = PublishE4(r_PackedHalf2AtPtx3803R1250);					  // PTX L4077
	r_ConvertedE4PairAtPtx4080Rs131 = PublishE4(r_PackedHalf2AtPtx3796R1251);					  // PTX L4080
	r_ConvertedE4PairAtPtx4083Rs132 = PublishE4(r_PackedHalf2AtPtx3810R1252);					  // PTX L4083
	r_ConvertedE4PairAtPtx4086Rs133 = PublishE4(r_PackedHalf2AtPtx3817R1253);					  // PTX L4086
	r_ConvertedE4PairAtPtx4089Rs134 = PublishE4(r_PackedHalf2AtPtx3831R1254);					  // PTX L4089
	r_ConvertedE4PairAtPtx4092Rs135 = PublishE4(r_PackedHalf2AtPtx3824R1255);					  // PTX L4092
	r_ConvertedE4PairAtPtx4095Rs136 = PublishE4(r_PackedHalf2AtPtx3838R1256);					  // PTX L4095
	r_ConvertedE4PairAtPtx4098Rs137 = PublishE4(r_PackedHalf2AtPtx3845R1257);					  // PTX L4098
	r_ConvertedE4PairAtPtx4101Rs138 = PublishE4(r_PackedHalf2AtPtx3859R1258);					  // PTX L4101
	r_ConvertedE4PairAtPtx4104Rs139 = PublishE4(r_PackedHalf2AtPtx3852R1259);					  // PTX L4104
	r_ConvertedE4PairAtPtx4107Rs140 = PublishE4(r_PackedHalf2AtPtx3866R1260);					  // PTX L4107
	r_ConvertedE4PairAtPtx4110Rs141 = PublishE4(r_PackedHalf2AtPtx3873R1261);					  // PTX L4110
	r_ConvertedE4PairAtPtx4113Rs142 = PublishE4(r_PackedHalf2AtPtx3887R1262);					  // PTX L4113
	r_ConvertedE4PairAtPtx4116Rs143 = PublishE4(r_PackedHalf2AtPtx3880R1263);					  // PTX L4116
	r_ConvertedE4PairAtPtx4119Rs144 = PublishE4(r_PackedHalf2AtPtx3894R1264);					  // PTX L4119
	r_ConvertedE4PairAtPtx4122Rs145 = PublishE4(r_PackedHalf2AtPtx3901R1265);					  // PTX L4122
	r_ConvertedE4PairAtPtx4125Rs146 = PublishE4(r_PackedHalf2AtPtx3915R1266);					  // PTX L4125
	r_ConvertedE4PairAtPtx4128Rs147 = PublishE4(r_PackedHalf2AtPtx3908R1267);					  // PTX L4128
	r_ConvertedE4PairAtPtx4131Rs148 = PublishE4(r_PackedHalf2AtPtx3922R1268);					  // PTX L4131
	r_ConvertedE4PairAtPtx4134Rs149 = PublishE4(r_PackedHalf2AtPtx3929R1269);					  // PTX L4134
	r_ConvertedE4PairAtPtx4137Rs150 = PublishE4(r_PackedHalf2AtPtx3943R1270);					  // PTX L4137
	r_ConvertedE4PairAtPtx4140Rs151 = PublishE4(r_PackedHalf2AtPtx3936R1271);					  // PTX L4140
	r_ConvertedE4PairAtPtx4143Rs152 = PublishE4(r_PackedHalf2AtPtx3950R1272);					  // PTX L4143
	r_PtxRegister1273 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(2));						  // PTX L4145
	r_PtxRegister1274 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(12));						  // PTX L4146
	r_PtxRegister1275 = uint32_t(r_PtxRegister1274) + uint32_t(r_PtxRegister1273);				  // PTX L4147
	r_PtxU64Register256 = uint64_t(int64_t(int32_t(r_PtxRegister1275)) * int64_t(int32_t(4)));	  // PTX L4148
	g_OutputByteAddressAtPtx4149 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register256); // PTX L4149
	if (r_bPtxPredicate44)
	{
		goto L__BB59_106;
	} // PTX L4150
	r_PackedE4WordAtPtx4151R1285 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3996Rs103, r_ConvertedE4PairAtPtx3999Rs104); // PTX L4151
	r_PackedE4WordAtPtx4152R1284 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3990Rs101, r_ConvertedE4PairAtPtx3993Rs102); // PTX L4152
	r_PackedE4WordAtPtx4153R1283 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3984Rs99, r_ConvertedE4PairAtPtx3987Rs100); // PTX L4153
	r_PackedE4WordAtPtx4154R1282 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3978Rs97, r_ConvertedE4PairAtPtx3981Rs98); // PTX L4154
	r_PackedE4WordAtPtx4155R1280 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3972Rs95, r_ConvertedE4PairAtPtx3975Rs96); // PTX L4155
	r_PackedE4WordAtPtx4156R1279 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3966Rs93, r_ConvertedE4PairAtPtx3969Rs94); // PTX L4156
	r_PackedE4WordAtPtx4157R1278 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3960Rs91, r_ConvertedE4PairAtPtx3963Rs92); // PTX L4157
	r_PackedE4WordAtPtx4158R1277 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3954Rs89, r_ConvertedE4PairAtPtx3957Rs90); // PTX L4158
	r_LaneIndexAtPtx4160 = uint32_t((threadIdx.x & 31u));							   // PTX L4160
	r_PtxU64Register259 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4160)) * int64_t(int32_t(16))); // PTX L4162
	g_OutputByteAddressAtPtx4163 =
		uint64_t(g_OutputByteAddressAtPtx4149) + uint64_t(r_PtxU64Register259); // PTX L4163
	StoreNoAllocate(g_OutputByteAddressAtPtx4163,
					make_uint4(r_PackedE4WordAtPtx4158R1277, r_PackedE4WordAtPtx4157R1278,
							   r_PackedE4WordAtPtx4156R1279,
							   r_PackedE4WordAtPtx4155R1280)); // PTX L4165
	r_LaneIndexAtPtx4168 = uint32_t((threadIdx.x & 31u));	   // PTX L4168
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4168)) * int64_t(int32_t(16))); // PTX L4170
	g_OutputByteAddressAtPtx4171 =
		uint64_t(g_OutputByteAddressAtPtx4149) + uint64_t(r_PtxU64Register260);			   // PTX L4171
	g_OutputByteAddressAtPtx4172 = uint64_t(g_OutputByteAddressAtPtx4171) + uint64_t(512); // PTX L4172
	StoreNoAllocate(g_OutputByteAddressAtPtx4172,
					make_uint4(r_PackedE4WordAtPtx4154R1282, r_PackedE4WordAtPtx4153R1283,
							   r_PackedE4WordAtPtx4152R1284,
							   r_PackedE4WordAtPtx4151R1285));								 // PTX L4174
L__BB59_106:																				 // PTX L4176
	r_bPtxPredicate45 = int32_t(r_PtxRegister34) >= int32_t(r_PtxRegister3);				 // PTX L4177
	g_OutputByteAddressAtPtx4178 = uint64_t(g_OutputByteAddressAtPtx4149) + uint64_t(16384); // PTX L4178
	if (r_bPtxPredicate45)
	{
		goto L__BB59_108;
	} // PTX L4179
	r_LaneIndexAtPtx4181 = uint32_t((threadIdx.x & 31u)); // PTX L4181
	r_PtxU64Register264 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4181)) * int64_t(int32_t(16))); // PTX L4183
	g_OutputByteAddressAtPtx4184 =
		uint64_t(g_OutputByteAddressAtPtx4178) + uint64_t(r_PtxU64Register264); // PTX L4184
	r_PackedE4WordAtPtx4185R1290 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4020Rs111, r_ConvertedE4PairAtPtx4023Rs112); // PTX L4185
	r_PackedE4WordAtPtx4186R1289 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4014Rs109, r_ConvertedE4PairAtPtx4017Rs110); // PTX L4186
	r_PackedE4WordAtPtx4187R1288 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4008Rs107, r_ConvertedE4PairAtPtx4011Rs108); // PTX L4187
	r_PackedE4WordAtPtx4188R1287 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4002Rs105, r_ConvertedE4PairAtPtx4005Rs106); // PTX L4188
	StoreNoAllocate(g_OutputByteAddressAtPtx4184,
					make_uint4(r_PackedE4WordAtPtx4188R1287, r_PackedE4WordAtPtx4187R1288,
							   r_PackedE4WordAtPtx4186R1289,
							   r_PackedE4WordAtPtx4185R1290)); // PTX L4190
	r_LaneIndexAtPtx4193 = uint32_t((threadIdx.x & 31u));	   // PTX L4193
	r_PtxU64Register265 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4193)) * int64_t(int32_t(16))); // PTX L4195
	g_OutputByteAddressAtPtx4196 =
		uint64_t(g_OutputByteAddressAtPtx4149) + uint64_t(r_PtxU64Register265);				 // PTX L4196
	g_OutputByteAddressAtPtx4197 = uint64_t(g_OutputByteAddressAtPtx4196) + uint64_t(16896); // PTX L4197
	r_PackedE4WordAtPtx4198R1295 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4044Rs119, r_ConvertedE4PairAtPtx4047Rs120); // PTX L4198
	r_PackedE4WordAtPtx4199R1294 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4038Rs117, r_ConvertedE4PairAtPtx4041Rs118); // PTX L4199
	r_PackedE4WordAtPtx4200R1293 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4032Rs115, r_ConvertedE4PairAtPtx4035Rs116); // PTX L4200
	r_PackedE4WordAtPtx4201R1292 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4026Rs113, r_ConvertedE4PairAtPtx4029Rs114); // PTX L4201
	StoreNoAllocate(g_OutputByteAddressAtPtx4197,
					make_uint4(r_PackedE4WordAtPtx4201R1292, r_PackedE4WordAtPtx4200R1293,
							   r_PackedE4WordAtPtx4199R1294,
							   r_PackedE4WordAtPtx4198R1295));								 // PTX L4203
L__BB59_108:																				 // PTX L4205
	r_bPtxPredicate46 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister3);				 // PTX L4206
	g_OutputByteAddressAtPtx4207 = uint64_t(g_OutputByteAddressAtPtx4178) + uint64_t(16384); // PTX L4207
	if (r_bPtxPredicate46)
	{
		goto L__BB59_110;
	} // PTX L4208
	r_LaneIndexAtPtx4210 = uint32_t((threadIdx.x & 31u)); // PTX L4210
	r_PtxU64Register269 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4210)) * int64_t(int32_t(16))); // PTX L4212
	g_OutputByteAddressAtPtx4213 =
		uint64_t(g_OutputByteAddressAtPtx4207) + uint64_t(r_PtxU64Register269); // PTX L4213
	r_PackedE4WordAtPtx4214R1300 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4068Rs127, r_ConvertedE4PairAtPtx4071Rs128); // PTX L4214
	r_PackedE4WordAtPtx4215R1299 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4062Rs125, r_ConvertedE4PairAtPtx4065Rs126); // PTX L4215
	r_PackedE4WordAtPtx4216R1298 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4056Rs123, r_ConvertedE4PairAtPtx4059Rs124); // PTX L4216
	r_PackedE4WordAtPtx4217R1297 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4050Rs121, r_ConvertedE4PairAtPtx4053Rs122); // PTX L4217
	StoreNoAllocate(g_OutputByteAddressAtPtx4213,
					make_uint4(r_PackedE4WordAtPtx4217R1297, r_PackedE4WordAtPtx4216R1298,
							   r_PackedE4WordAtPtx4215R1299,
							   r_PackedE4WordAtPtx4214R1300)); // PTX L4219
	r_LaneIndexAtPtx4222 = uint32_t((threadIdx.x & 31u));	   // PTX L4222
	r_PtxU64Register270 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4222)) * int64_t(int32_t(16))); // PTX L4224
	g_OutputByteAddressAtPtx4225 =
		uint64_t(g_OutputByteAddressAtPtx4178) + uint64_t(r_PtxU64Register270);				 // PTX L4225
	g_OutputByteAddressAtPtx4226 = uint64_t(g_OutputByteAddressAtPtx4225) + uint64_t(16896); // PTX L4226
	r_PackedE4WordAtPtx4227R1305 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4092Rs135, r_ConvertedE4PairAtPtx4095Rs136); // PTX L4227
	r_PackedE4WordAtPtx4228R1304 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4086Rs133, r_ConvertedE4PairAtPtx4089Rs134); // PTX L4228
	r_PackedE4WordAtPtx4229R1303 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4080Rs131, r_ConvertedE4PairAtPtx4083Rs132); // PTX L4229
	r_PackedE4WordAtPtx4230R1302 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4074Rs129, r_ConvertedE4PairAtPtx4077Rs130); // PTX L4230
	StoreNoAllocate(g_OutputByteAddressAtPtx4226,
					make_uint4(r_PackedE4WordAtPtx4230R1302, r_PackedE4WordAtPtx4229R1303,
							   r_PackedE4WordAtPtx4228R1304,
							   r_PackedE4WordAtPtx4227R1305));				 // PTX L4232
L__BB59_110:																 // PTX L4234
	r_bPtxPredicate47 = int32_t(r_PtxRegister36) >= int32_t(r_PtxRegister3); // PTX L4235
	if (r_bPtxPredicate47)
	{
		goto L__BB59_112;
	} // PTX L4236
	r_LaneIndexAtPtx4238 = uint32_t((threadIdx.x & 31u)); // PTX L4238
	r_PtxU64Register274 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4238)) * int64_t(int32_t(16))); // PTX L4240
	g_OutputByteAddressAtPtx4241 =
		uint64_t(g_OutputByteAddressAtPtx4207) + uint64_t(r_PtxU64Register274);				 // PTX L4241
	g_OutputByteAddressAtPtx4242 = uint64_t(g_OutputByteAddressAtPtx4241) + uint64_t(16384); // PTX L4242
	r_PackedE4WordAtPtx4243R1310 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4116Rs143, r_ConvertedE4PairAtPtx4119Rs144); // PTX L4243
	r_PackedE4WordAtPtx4244R1309 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4110Rs141, r_ConvertedE4PairAtPtx4113Rs142); // PTX L4244
	r_PackedE4WordAtPtx4245R1308 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4104Rs139, r_ConvertedE4PairAtPtx4107Rs140); // PTX L4245
	r_PackedE4WordAtPtx4246R1307 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4098Rs137, r_ConvertedE4PairAtPtx4101Rs138); // PTX L4246
	StoreNoAllocate(g_OutputByteAddressAtPtx4242,
					make_uint4(r_PackedE4WordAtPtx4246R1307, r_PackedE4WordAtPtx4245R1308,
							   r_PackedE4WordAtPtx4244R1309,
							   r_PackedE4WordAtPtx4243R1310)); // PTX L4248
	r_LaneIndexAtPtx4251 = uint32_t((threadIdx.x & 31u));	   // PTX L4251
	r_PtxU64Register276 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4251)) * int64_t(int32_t(16))); // PTX L4253
	g_OutputByteAddressAtPtx4254 =
		uint64_t(g_OutputByteAddressAtPtx4207) + uint64_t(r_PtxU64Register276);				 // PTX L4254
	g_OutputByteAddressAtPtx4255 = uint64_t(g_OutputByteAddressAtPtx4254) + uint64_t(16896); // PTX L4255
	r_PackedE4WordAtPtx4256R1315 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4140Rs151, r_ConvertedE4PairAtPtx4143Rs152); // PTX L4256
	r_PackedE4WordAtPtx4257R1314 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4134Rs149, r_ConvertedE4PairAtPtx4137Rs150); // PTX L4257
	r_PackedE4WordAtPtx4258R1313 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4128Rs147, r_ConvertedE4PairAtPtx4131Rs148); // PTX L4258
	r_PackedE4WordAtPtx4259R1312 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4122Rs145, r_ConvertedE4PairAtPtx4125Rs146); // PTX L4259
	StoreNoAllocate(g_OutputByteAddressAtPtx4255,
					make_uint4(r_PackedE4WordAtPtx4259R1312, r_PackedE4WordAtPtx4258R1313,
							   r_PackedE4WordAtPtx4257R1314,
							   r_PackedE4WordAtPtx4256R1315));		// PTX L4261
L__BB59_112:														// PTX L4263
	__syncthreads();												// PTX L4264
	r_ThreadZAtPtx4265 = uint32_t(threadIdx.z);						// PTX L4265
	r_PtxRegister1375 = r_PtxRegister5 | r_ThreadZAtPtx4265;		// PTX L4266
	r_bPtxPredicate56 = uint32_t(r_PtxRegister1375) != uint32_t(0); // PTX L4267
	if (r_bPtxPredicate56)
	{
		goto L__BB59_114;
	} // PTX L4268
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(g_CounterByteAddress, r_CtaZ);							// PTX L4270
L__BB59_114:																	// PTX L4272
	return;																		// PTX L4273
L__BB59_52:																		// PTX L4274
	r_PtxRegister27 = uint32_t(r_CtaZ) + uint32_t(-1);							// PTX L4275
L__BB59_53:																		// PTX L4276
	r_PtxRegister1126 = CounterLoadRelaxed(g_CounterByteAddress);				// PTX L4278
	r_bPtxPredicate27 = int32_t(r_PtxRegister1126) >= int32_t(r_PtxRegister27); // PTX L4280
	if (r_bPtxPredicate27)
	{
		goto L__BB59_71;
	} // PTX L4281
	r_PtxRegister1352 = uint32_t(64); // PTX L4282
	PollSleep(r_PtxRegister1352);	  // PTX L4284
	goto L__BB59_53;				  // PTX L4286
#endif
}
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8
