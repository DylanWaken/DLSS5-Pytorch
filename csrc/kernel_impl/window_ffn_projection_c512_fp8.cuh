// Readable equivalent of cc_split_swin_16h_ffwd_proj_512_fp8; not historical source.
#pragma once
#include "window_ffn_projection_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
{
__global__ __maxnreg__(128) void window_ffn_projection_c512_fp8(Parameters r_Parameters)
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
		r_bPtxPredicate102, r_bPtxPredicate103, r_bPtxPredicate104;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx219Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx300Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx372Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx443Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx515Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx586Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx658Rs14, r_PtxU16Register15,
		r_ConvertedE4PairAtPtx695Rs16, r_PtxU16Register17, r_ConvertedE4PairAtPtx737Rs18, r_PtxU16Register19,
		r_ConvertedE4PairAtPtx774Rs20, r_PtxU16Register21, r_ConvertedE4PairAtPtx827Rs22, r_PtxU16Register23,
		r_ConvertedE4PairAtPtx864Rs24;
	uint16_t r_PtxU16Register25, r_ConvertedE4PairAtPtx905Rs26, r_PtxU16Register27,
		r_ConvertedE4PairAtPtx942Rs28, r_PtxU16Register29, r_PtxU16Register30, r_PtxU16Register31,
		r_PtxU16Register32, r_PtxU16Register33, r_PtxU16Register34, r_PtxU16Register35, r_PtxU16Register36;
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
		r_PtxU16Register89, r_PtxU16Register90, r_PtxU16Register91, r_PtxU16Register92, r_PtxU16Register93,
		r_PtxU16Register94, r_PtxU16Register95, r_PtxU16Register96;
	uint16_t r_PtxU16Register97, r_PtxU16Register98, r_PtxU16Register99, r_PtxU16Register100,
		r_PtxU16Register101, r_PtxU16Register102, r_PtxU16Register103, r_PtxU16Register104,
		r_PtxU16Register105, r_ConvertedE4PairAtPtx3256Rs106, r_PtxU16Register107,
		r_ConvertedE4PairAtPtx3341Rs108;
	uint16_t r_ConvertedE4PairAtPtx3360Rs109, r_ConvertedE4PairAtPtx3363Rs110,
		r_ConvertedE4PairAtPtx3366Rs111, r_ConvertedE4PairAtPtx3369Rs112, r_ConvertedE4PairAtPtx3372Rs113,
		r_ConvertedE4PairAtPtx3375Rs114, r_ConvertedE4PairAtPtx3378Rs115, r_ConvertedE4PairAtPtx3381Rs116,
		r_ConvertedE4PairAtPtx3384Rs117, r_ConvertedE4PairAtPtx3387Rs118, r_ConvertedE4PairAtPtx3390Rs119,
		r_ConvertedE4PairAtPtx3393Rs120;
	uint16_t r_ConvertedE4PairAtPtx3396Rs121, r_ConvertedE4PairAtPtx3399Rs122,
		r_ConvertedE4PairAtPtx3402Rs123, r_ConvertedE4PairAtPtx3405Rs124, r_ConvertedE4PairAtPtx3408Rs125,
		r_ConvertedE4PairAtPtx3411Rs126, r_ConvertedE4PairAtPtx3414Rs127, r_ConvertedE4PairAtPtx3417Rs128,
		r_ConvertedE4PairAtPtx3420Rs129, r_ConvertedE4PairAtPtx3423Rs130, r_ConvertedE4PairAtPtx3426Rs131,
		r_ConvertedE4PairAtPtx3429Rs132;
	uint16_t r_ConvertedE4PairAtPtx3432Rs133, r_ConvertedE4PairAtPtx3435Rs134,
		r_ConvertedE4PairAtPtx3438Rs135, r_ConvertedE4PairAtPtx3441Rs136, r_ConvertedE4PairAtPtx3444Rs137,
		r_ConvertedE4PairAtPtx3447Rs138, r_ConvertedE4PairAtPtx3450Rs139, r_ConvertedE4PairAtPtx3453Rs140,
		r_ConvertedE4PairAtPtx3456Rs141, r_ConvertedE4PairAtPtx3459Rs142, r_ConvertedE4PairAtPtx3462Rs143,
		r_ConvertedE4PairAtPtx3465Rs144;
	uint16_t r_ConvertedE4PairAtPtx3468Rs145, r_ConvertedE4PairAtPtx3471Rs146,
		r_ConvertedE4PairAtPtx3474Rs147, r_ConvertedE4PairAtPtx3477Rs148, r_ConvertedE4PairAtPtx3480Rs149,
		r_ConvertedE4PairAtPtx3483Rs150, r_ConvertedE4PairAtPtx3486Rs151, r_ConvertedE4PairAtPtx3489Rs152,
		r_ConvertedE4PairAtPtx3492Rs153, r_ConvertedE4PairAtPtx3495Rs154, r_ConvertedE4PairAtPtx3498Rs155,
		r_ConvertedE4PairAtPtx3501Rs156;
	uint16_t r_ConvertedE4PairAtPtx3504Rs157, r_ConvertedE4PairAtPtx3507Rs158,
		r_ConvertedE4PairAtPtx3510Rs159, r_ConvertedE4PairAtPtx3513Rs160, r_ConvertedE4PairAtPtx3516Rs161,
		r_ConvertedE4PairAtPtx3519Rs162, r_ConvertedE4PairAtPtx3522Rs163, r_ConvertedE4PairAtPtx3525Rs164,
		r_ConvertedE4PairAtPtx3528Rs165, r_ConvertedE4PairAtPtx3531Rs166, r_ConvertedE4PairAtPtx3534Rs167,
		r_ConvertedE4PairAtPtx3537Rs168;
	uint16_t r_ConvertedE4PairAtPtx3540Rs169, r_ConvertedE4PairAtPtx3543Rs170,
		r_ConvertedE4PairAtPtx3546Rs171, r_ConvertedE4PairAtPtx3549Rs172;
	uint32_t r_CtaZAtPtx21, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_HeightDiv4Bits, r_WidthDiv4Bits,
		r_ThreadYAtPtx42, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_HeightBits, r_WidthBits, r_CtaX,
		r_CtaYAtPtx20, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47, r_PtxRegister48;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_HeightSignBits, r_HeightDiv4Bias,
		r_HeightBiasedForDiv4, r_WidthSignBits, r_WidthDiv4Bias, r_WidthBiasedForDiv4, r_ThreadX,
		r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_BlockSizeX, r_BlockSizeY,
		r_LaneIndexAtPtx72, r_LaneIndexAtPtx80, r_LaneIndexAtPtx90, r_LaneIndexAtPtx99, r_LaneIndexAtPtx108,
		r_LaneIndexAtPtx117, r_LaneIndexAtPtx126;
	uint32_t r_LaneIndexAtPtx135, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_PackedHalf2AtPtx217R95, r_LaneIndexAtPtx223;
	uint32_t r_PtxRegister97, r_PackedE4WordAtPtx221R98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PackedHalf2AtPtx298R118,
		r_LaneIndexAtPtx304, r_PtxRegister120;
	uint32_t r_PackedE4WordAtPtx302R121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124,
		r_PtxRegister125, r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129,
		r_PtxRegister130, r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PackedHalf2AtPtx370R136,
		r_LaneIndexAtPtx376, r_PtxRegister138, r_PackedE4WordAtPtx374R139, r_PtxRegister140, r_PtxRegister141,
		r_PtxRegister142, r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PackedHalf2AtPtx441R156;
	uint32_t r_LaneIndexAtPtx447, r_PtxRegister158, r_PackedE4WordAtPtx445R159, r_PtxRegister160,
		r_PtxRegister161, r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165,
		r_PtxRegister166, r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PackedHalf2AtPtx513R176, r_LaneIndexAtPtx519, r_PtxRegister178,
		r_PackedE4WordAtPtx517R179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_PtxRegister190,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PackedHalf2AtPtx584R196,
		r_LaneIndexAtPtx590, r_PtxRegister198, r_PackedE4WordAtPtx588R199, r_PtxRegister200, r_PtxRegister201,
		r_PtxRegister202, r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PackedHalf2AtPtx656R213, r_LaneIndexAtPtx642,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PackedHalf2AtPtx693R220,
		r_LaneIndexAtPtx679, r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225,
		r_PtxRegister226, r_PackedHalf2AtPtx735R227, r_LaneIndexAtPtx721;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PackedHalf2AtPtx772R234, r_LaneIndexAtPtx758, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PackedHalf2AtPtx825R243, r_LaneIndexAtPtx811,
		r_PtxRegister245, r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249,
		r_PackedHalf2AtPtx862R250, r_LaneIndexAtPtx848, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256,
		r_PackedHalf2AtPtx903R257, r_LaneIndexAtPtx889, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261,
		r_PtxRegister262, r_PtxRegister263, r_PackedHalf2AtPtx940R264;
	uint32_t r_LaneIndexAtPtx926, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_LaneIndexAtPtx1149, r_LaneIndexAtPtx1163, r_LaneIndexAtPtx1177, r_LaneIndexAtPtx1191,
		r_LaneIndexAtPtx1205, r_LaneIndexAtPtx1219, r_LaneIndexAtPtx1233;
	uint32_t r_LaneIndexAtPtx1250, r_LaneIndexAtPtx1266, r_LaneIndexAtPtx1281, r_LaneIndexAtPtx1295,
		r_LaneIndexAtPtx1312, r_LaneIndexAtPtx1328, r_LaneIndexAtPtx1343, r_LaneIndexAtPtx1357,
		r_LaneIndexAtPtx1374, r_LaneIndexAtPtx1390, r_LaneIndexAtPtx1404, r_LaneIndexAtPtx1418;
	uint32_t r_LaneIndexAtPtx1432, r_LaneIndexAtPtx1446, r_LaneIndexAtPtx1460, r_LaneIndexAtPtx1474,
		r_LaneIndexAtPtx1490, r_LaneIndexAtPtx1506, r_LaneIndexAtPtx1520, r_LaneIndexAtPtx1534,
		r_LaneIndexAtPtx1550, r_LaneIndexAtPtx1566, r_LaneIndexAtPtx1580, r_LaneIndexAtPtx1594;
	uint32_t r_LaneIndexAtPtx1610, r_LaneIndexAtPtx1626, r_LaneIndexAtPtx1640, r_LaneIndexAtPtx1654,
		r_LaneIndexAtPtx1668, r_LaneIndexAtPtx1682, r_LaneIndexAtPtx1696, r_LaneIndexAtPtx1710,
		r_LaneIndexAtPtx1726, r_LaneIndexAtPtx1742, r_LaneIndexAtPtx1756, r_LaneIndexAtPtx1770;
	uint32_t r_LaneIndexAtPtx1786, r_LaneIndexAtPtx1802, r_LaneIndexAtPtx1816, r_LaneIndexAtPtx1830,
		r_LaneIndexAtPtx1846, r_LaneIndexAtPtx1862, r_LaneIndexAtPtx1876, r_LaneIndexAtPtx1890,
		r_LaneIndexAtPtx1904, r_LaneIndexAtPtx1918, r_LaneIndexAtPtx1932, r_LaneIndexAtPtx1946;
	uint32_t r_LaneIndexAtPtx1962, r_LaneIndexAtPtx1978, r_LaneIndexAtPtx1992, r_LaneIndexAtPtx2006,
		r_LaneIndexAtPtx2022, r_LaneIndexAtPtx2038, r_LaneIndexAtPtx2052, r_LaneIndexAtPtx2066,
		r_LaneIndexAtPtx2082, r_LaneIndexAtPtx2098, r_PackedHalf2AtPtx950R335, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx2105, r_PackedHalf2AtPtx956R338, r_PtxRegister339, r_LaneIndexAtPtx2112,
		r_PackedHalf2AtPtx953R341, r_PtxRegister342, r_LaneIndexAtPtx2119, r_PackedHalf2AtPtx959R344,
		r_PtxRegister345, r_LaneIndexAtPtx2126, r_PackedHalf2AtPtx962R347, r_PtxRegister348;
	uint32_t r_LaneIndexAtPtx2133, r_PackedHalf2AtPtx968R350, r_PtxRegister351, r_LaneIndexAtPtx2140,
		r_PackedHalf2AtPtx965R353, r_PtxRegister354, r_LaneIndexAtPtx2147, r_PackedHalf2AtPtx971R356,
		r_PtxRegister357, r_LaneIndexAtPtx2154, r_PackedHalf2AtPtx974R359, r_PtxRegister360;
	uint32_t r_LaneIndexAtPtx2161, r_PackedHalf2AtPtx980R362, r_PtxRegister363, r_LaneIndexAtPtx2168,
		r_PackedHalf2AtPtx977R365, r_PtxRegister366, r_LaneIndexAtPtx2175, r_PackedHalf2AtPtx983R368,
		r_PtxRegister369, r_LaneIndexAtPtx2182, r_PackedHalf2AtPtx986R371, r_PtxRegister372;
	uint32_t r_LaneIndexAtPtx2189, r_PackedHalf2AtPtx992R374, r_PtxRegister375, r_LaneIndexAtPtx2196,
		r_PackedHalf2AtPtx989R377, r_PtxRegister378, r_LaneIndexAtPtx2203, r_PackedHalf2AtPtx995R380,
		r_PtxRegister381, r_LaneIndexAtPtx2210, r_PackedHalf2AtPtx998R383, r_PtxRegister384;
	uint32_t r_LaneIndexAtPtx2217, r_PackedHalf2AtPtx1004R386, r_PtxRegister387, r_LaneIndexAtPtx2224,
		r_PackedHalf2AtPtx1001R389, r_PtxRegister390, r_LaneIndexAtPtx2231, r_PackedHalf2AtPtx1007R392,
		r_PtxRegister393, r_LaneIndexAtPtx2238, r_PackedHalf2AtPtx1010R395, r_PtxRegister396;
	uint32_t r_LaneIndexAtPtx2245, r_PackedHalf2AtPtx1016R398, r_PtxRegister399, r_LaneIndexAtPtx2252,
		r_PackedHalf2AtPtx1013R401, r_PtxRegister402, r_LaneIndexAtPtx2259, r_PackedHalf2AtPtx1019R404,
		r_PtxRegister405, r_LaneIndexAtPtx2266, r_PackedHalf2AtPtx1022R407, r_PtxRegister408;
	uint32_t r_LaneIndexAtPtx2273, r_PackedHalf2AtPtx1028R410, r_PtxRegister411, r_LaneIndexAtPtx2280,
		r_PackedHalf2AtPtx1025R413, r_PtxRegister414, r_LaneIndexAtPtx2287, r_PackedHalf2AtPtx1031R416,
		r_PtxRegister417, r_LaneIndexAtPtx2294, r_PackedHalf2AtPtx1034R419, r_PtxRegister420;
	uint32_t r_LaneIndexAtPtx2301, r_PackedHalf2AtPtx1040R422, r_PtxRegister423, r_LaneIndexAtPtx2308,
		r_PackedHalf2AtPtx1037R425, r_PtxRegister426, r_LaneIndexAtPtx2315, r_PackedHalf2AtPtx1043R428,
		r_PtxRegister429, r_LaneIndexAtPtx2322, r_PackedHalf2AtPtx1046R431, r_PtxRegister432;
	uint32_t r_LaneIndexAtPtx2329, r_PackedHalf2AtPtx1052R434, r_PtxRegister435, r_LaneIndexAtPtx2336,
		r_PackedHalf2AtPtx1049R437, r_PtxRegister438, r_LaneIndexAtPtx2343, r_PackedHalf2AtPtx1055R440,
		r_PtxRegister441, r_LaneIndexAtPtx2350, r_PackedHalf2AtPtx1058R443, r_PtxRegister444;
	uint32_t r_LaneIndexAtPtx2357, r_PackedHalf2AtPtx1064R446, r_PtxRegister447, r_LaneIndexAtPtx2364,
		r_PackedHalf2AtPtx1061R449, r_PtxRegister450, r_LaneIndexAtPtx2371, r_PackedHalf2AtPtx1067R452,
		r_PtxRegister453, r_LaneIndexAtPtx2378, r_PackedHalf2AtPtx1070R455, r_PtxRegister456;
	uint32_t r_LaneIndexAtPtx2385, r_PackedHalf2AtPtx1076R458, r_PtxRegister459, r_LaneIndexAtPtx2392,
		r_PackedHalf2AtPtx1073R461, r_PtxRegister462, r_LaneIndexAtPtx2399, r_PackedHalf2AtPtx1079R464,
		r_PtxRegister465, r_LaneIndexAtPtx2406, r_PackedHalf2AtPtx1082R467, r_PtxRegister468;
	uint32_t r_LaneIndexAtPtx2413, r_PackedHalf2AtPtx1088R470, r_PtxRegister471, r_LaneIndexAtPtx2420,
		r_PackedHalf2AtPtx1085R473, r_PtxRegister474, r_LaneIndexAtPtx2427, r_PackedHalf2AtPtx1091R476,
		r_PtxRegister477, r_LaneIndexAtPtx2434, r_PackedHalf2AtPtx1094R479, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx2441, r_PackedHalf2AtPtx1100R482, r_PtxRegister483, r_LaneIndexAtPtx2448,
		r_PackedHalf2AtPtx1097R485, r_PtxRegister486, r_LaneIndexAtPtx2455, r_PackedHalf2AtPtx1103R488,
		r_PtxRegister489, r_LaneIndexAtPtx2462, r_PackedHalf2AtPtx1106R491, r_PtxRegister492;
	uint32_t r_LaneIndexAtPtx2469, r_PackedHalf2AtPtx1112R494, r_PtxRegister495, r_LaneIndexAtPtx2476,
		r_PackedHalf2AtPtx1109R497, r_PtxRegister498, r_LaneIndexAtPtx2483, r_PackedHalf2AtPtx1115R500,
		r_PtxRegister501, r_LaneIndexAtPtx2490, r_PackedHalf2AtPtx1119R503, r_PtxRegister504;
	uint32_t r_LaneIndexAtPtx2497, r_PackedHalf2AtPtx1126R506, r_PtxRegister507, r_LaneIndexAtPtx2504,
		r_PackedHalf2AtPtx1122R509, r_PtxRegister510, r_LaneIndexAtPtx2511, r_PackedHalf2AtPtx1129R512,
		r_PtxRegister513, r_LaneIndexAtPtx2518, r_PackedHalf2AtPtx1133R515, r_PtxRegister516;
	uint32_t r_LaneIndexAtPtx2525, r_PackedHalf2AtPtx1140R518, r_PtxRegister519, r_LaneIndexAtPtx2532,
		r_PackedHalf2AtPtx1136R521, r_PtxRegister522, r_LaneIndexAtPtx2539, r_PackedHalf2AtPtx1143R524,
		r_PtxRegister525, r_PtxRegister526, r_PtxRegister527, r_PtxRegister528;
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
	uint32_t r_LaneIndexAtPtx2558, r_PtxRegister1094, r_LaneIndexAtPtx2568, r_PtxRegister1096,
		r_LaneIndexAtPtx2577, r_PtxRegister1098, r_LaneIndexAtPtx2586, r_PtxRegister1100,
		r_LaneIndexAtPtx2595, r_PtxRegister1102, r_LaneIndexAtPtx2604, r_PtxRegister1104;
	uint32_t r_LaneIndexAtPtx2613, r_PtxRegister1106, r_LaneIndexAtPtx2622, r_PtxRegister1108,
		r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		r_MmaAE4x4WordAtPtx2565R1112, r_MmaAE4x4WordAtPtx2574R1113, r_MmaAE4x4WordAtPtx2574R1114,
		r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2631R1117, r_MmaAccumulatorHalf2WordAtPtx2631R1118,
		r_MmaAccumulatorHalf2WordAtPtx2638R1119, r_MmaAccumulatorHalf2WordAtPtx2638R1120,
		r_MmaAccumulatorHalf2WordAtPtx2659R1121, r_MmaAccumulatorHalf2WordAtPtx2659R1122,
		r_MmaAccumulatorHalf2WordAtPtx2666R1123, r_MmaAccumulatorHalf2WordAtPtx2666R1124,
		r_MmaAccumulatorHalf2WordAtPtx2687R1125, r_MmaAccumulatorHalf2WordAtPtx2687R1126,
		r_MmaAccumulatorHalf2WordAtPtx2694R1127, r_MmaAccumulatorHalf2WordAtPtx2694R1128;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2715R1129, r_MmaAccumulatorHalf2WordAtPtx2715R1130,
		r_MmaAccumulatorHalf2WordAtPtx2722R1131, r_MmaAccumulatorHalf2WordAtPtx2722R1132,
		r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		r_MmaAE4x4WordAtPtx2583R1136, r_MmaAE4x4WordAtPtx2592R1137, r_MmaAE4x4WordAtPtx2592R1138,
		r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2743R1141, r_MmaAccumulatorHalf2WordAtPtx2743R1142,
		r_MmaAccumulatorHalf2WordAtPtx2750R1143, r_MmaAccumulatorHalf2WordAtPtx2750R1144,
		r_MmaAccumulatorHalf2WordAtPtx2771R1145, r_MmaAccumulatorHalf2WordAtPtx2771R1146,
		r_MmaAccumulatorHalf2WordAtPtx2778R1147, r_MmaAccumulatorHalf2WordAtPtx2778R1148,
		r_MmaAccumulatorHalf2WordAtPtx2799R1149, r_MmaAccumulatorHalf2WordAtPtx2799R1150,
		r_MmaAccumulatorHalf2WordAtPtx2806R1151, r_MmaAccumulatorHalf2WordAtPtx2806R1152;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2827R1153, r_MmaAccumulatorHalf2WordAtPtx2827R1154,
		r_MmaAccumulatorHalf2WordAtPtx2834R1155, r_MmaAccumulatorHalf2WordAtPtx2834R1156,
		r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		r_MmaAE4x4WordAtPtx2601R1160, r_MmaAE4x4WordAtPtx2610R1161, r_MmaAE4x4WordAtPtx2610R1162,
		r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2855R1165, r_MmaAccumulatorHalf2WordAtPtx2855R1166,
		r_MmaAccumulatorHalf2WordAtPtx2862R1167, r_MmaAccumulatorHalf2WordAtPtx2862R1168,
		r_MmaAccumulatorHalf2WordAtPtx2883R1169, r_MmaAccumulatorHalf2WordAtPtx2883R1170,
		r_MmaAccumulatorHalf2WordAtPtx2890R1171, r_MmaAccumulatorHalf2WordAtPtx2890R1172,
		r_MmaAccumulatorHalf2WordAtPtx2911R1173, r_MmaAccumulatorHalf2WordAtPtx2911R1174,
		r_MmaAccumulatorHalf2WordAtPtx2918R1175, r_MmaAccumulatorHalf2WordAtPtx2918R1176;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2939R1177, r_MmaAccumulatorHalf2WordAtPtx2939R1178,
		r_MmaAccumulatorHalf2WordAtPtx2946R1179, r_MmaAccumulatorHalf2WordAtPtx2946R1180,
		r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		r_MmaAE4x4WordAtPtx2619R1184, r_MmaAE4x4WordAtPtx2628R1185, r_MmaAE4x4WordAtPtx2628R1186,
		r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2967R1189, r_MmaAccumulatorHalf2WordAtPtx2967R1190,
		r_MmaAccumulatorHalf2WordAtPtx2974R1191, r_MmaAccumulatorHalf2WordAtPtx2974R1192,
		r_MmaAccumulatorHalf2WordAtPtx2995R1193, r_MmaAccumulatorHalf2WordAtPtx2995R1194,
		r_MmaAccumulatorHalf2WordAtPtx3002R1195, r_MmaAccumulatorHalf2WordAtPtx3002R1196,
		r_MmaAccumulatorHalf2WordAtPtx3023R1197, r_MmaAccumulatorHalf2WordAtPtx3023R1198,
		r_MmaAccumulatorHalf2WordAtPtx3030R1199, r_MmaAccumulatorHalf2WordAtPtx3030R1200;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3051R1201, r_MmaAccumulatorHalf2WordAtPtx3051R1202,
		r_MmaAccumulatorHalf2WordAtPtx3058R1203, r_MmaAccumulatorHalf2WordAtPtx3058R1204, r_PtxRegister1205,
		r_PtxRegister1206, r_PtxRegister1207, r_PtxRegister1208, r_PtxRegister1209, r_PtxRegister1210,
		r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_PtxRegister1215, r_PtxRegister1216, r_PtxRegister1217,
		r_PtxRegister1218, r_PtxRegister1219, r_PtxRegister1220, r_PtxRegister1221, r_PtxRegister1222,
		r_PtxRegister1223, r_LaneIndexAtPtx3090;
	uint32_t r_LaneIndexAtPtx3098, r_LaneIndexAtPtx3107, r_LaneIndexAtPtx3116, r_LaneIndexAtPtx3125,
		r_LaneIndexAtPtx3134, r_LaneIndexAtPtx3143, r_LaneIndexAtPtx3152, r_PtxRegister1232,
		r_PtxRegister1233, r_CtaZAtPtx3081, r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_PtxRegister1241,
		r_PtxRegister1242, r_PtxRegister1243, r_PtxRegister1244, r_PtxRegister1245, r_PtxRegister1246,
		r_PtxRegister1247, r_PtxRegister1248;
	uint32_t r_PtxRegister1249, r_PtxRegister1250, r_PtxRegister1251, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_PtxRegister1257,
		r_PackedHalf2AtPtx3254R1258, r_LaneIndexAtPtx3260, r_PtxRegister1260;
	uint32_t r_PackedE4WordAtPtx3258R1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264,
		r_PtxRegister1265, r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269,
		r_PtxRegister1270, r_PtxRegister1271, r_ThreadYAtPtx3233;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_PtxRegister1276, r_CtaYAtPtx3273,
		r_PtxRegister1278, r_PtxRegister1279, r_PtxRegister1280, r_PtxRegister1281, r_PtxRegister1282,
		r_PtxRegister1283, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_PtxRegister1292, r_PtxRegister1293,
		r_PackedHalf2AtPtx3339R1294, r_LaneIndexAtPtx3345, r_PtxRegister1296;
	uint32_t r_PackedE4WordAtPtx3343R1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300,
		r_PtxRegister1301, r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305,
		r_PtxRegister1306, r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_LaneIndexAtPtx3569, r_PackedE4WordAtPtx3567R1311,
		r_PackedE4WordAtPtx3566R1312, r_PackedE4WordAtPtx3565R1313, r_PackedE4WordAtPtx3564R1314,
		r_LaneIndexAtPtx3577, r_PackedE4WordAtPtx3563R1316, r_PackedE4WordAtPtx3562R1317,
		r_PackedE4WordAtPtx3561R1318, r_PackedE4WordAtPtx3560R1319, r_LaneIndexAtPtx3591;
	uint32_t r_PackedE4WordAtPtx3599R1321, r_PackedE4WordAtPtx3598R1322, r_PackedE4WordAtPtx3597R1323,
		r_PackedE4WordAtPtx3596R1324, r_LaneIndexAtPtx3604, r_PackedE4WordAtPtx3612R1326,
		r_PackedE4WordAtPtx3611R1327, r_PackedE4WordAtPtx3610R1328, r_PackedE4WordAtPtx3609R1329,
		r_PtxRegister1330, r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_LaneIndexAtPtx3629, r_PackedE4WordAtPtx3636R1335,
		r_PackedE4WordAtPtx3635R1336, r_PackedE4WordAtPtx3634R1337, r_PackedE4WordAtPtx3633R1338,
		r_LaneIndexAtPtx3641, r_PackedE4WordAtPtx3649R1340, r_PackedE4WordAtPtx3648R1341,
		r_PackedE4WordAtPtx3647R1342, r_PackedE4WordAtPtx3646R1343, r_LaneIndexAtPtx3658;
	uint32_t r_PackedE4WordAtPtx3666R1345, r_PackedE4WordAtPtx3665R1346, r_PackedE4WordAtPtx3664R1347,
		r_PackedE4WordAtPtx3663R1348, r_LaneIndexAtPtx3671, r_PackedE4WordAtPtx3679R1350,
		r_PackedE4WordAtPtx3678R1351, r_PackedE4WordAtPtx3677R1352, r_PackedE4WordAtPtx3676R1353,
		r_PtxRegister1354, r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PackedHalf2AtPtx2528R1392;
	uint32_t r_PackedHalf2AtPtx2521R1393, r_PackedHalf2AtPtx2514R1394, r_PackedHalf2AtPtx2507R1395,
		r_PackedHalf2AtPtx2500R1396, r_PackedHalf2AtPtx2493R1397, r_PackedHalf2AtPtx2486R1398,
		r_PackedHalf2AtPtx2479R1399, r_PackedHalf2AtPtx2472R1400, r_PackedHalf2AtPtx2465R1401,
		r_PackedHalf2AtPtx2458R1402, r_PackedHalf2AtPtx2451R1403, r_PackedHalf2AtPtx2444R1404;
	uint32_t r_PackedHalf2AtPtx2437R1405, r_PackedHalf2AtPtx2430R1406, r_PackedHalf2AtPtx2423R1407,
		r_PackedHalf2AtPtx2416R1408, r_PackedHalf2AtPtx2409R1409, r_PackedHalf2AtPtx2402R1410,
		r_PackedHalf2AtPtx2395R1411, r_PackedHalf2AtPtx2388R1412, r_PackedHalf2AtPtx2381R1413,
		r_PackedHalf2AtPtx2374R1414, r_PackedHalf2AtPtx2367R1415, r_PackedHalf2AtPtx2360R1416;
	uint32_t r_PackedHalf2AtPtx2353R1417, r_PackedHalf2AtPtx2346R1418, r_PackedHalf2AtPtx2339R1419,
		r_PackedHalf2AtPtx2332R1420, r_PackedHalf2AtPtx2325R1421, r_PackedHalf2AtPtx2318R1422,
		r_PackedHalf2AtPtx2311R1423, r_PackedHalf2AtPtx2304R1424, r_PackedHalf2AtPtx2297R1425,
		r_PackedHalf2AtPtx2290R1426, r_PackedHalf2AtPtx2283R1427, r_PackedHalf2AtPtx2276R1428;
	uint32_t r_PackedHalf2AtPtx2269R1429, r_PackedHalf2AtPtx2262R1430, r_PackedHalf2AtPtx2255R1431,
		r_PackedHalf2AtPtx2248R1432, r_PackedHalf2AtPtx2241R1433, r_PackedHalf2AtPtx2234R1434,
		r_PackedHalf2AtPtx2227R1435, r_PackedHalf2AtPtx2220R1436, r_PackedHalf2AtPtx2213R1437,
		r_PackedHalf2AtPtx2206R1438, r_PackedHalf2AtPtx2199R1439, r_PackedHalf2AtPtx2192R1440;
	uint32_t r_PackedHalf2AtPtx2185R1441, r_PackedHalf2AtPtx2178R1442, r_PackedHalf2AtPtx2171R1443,
		r_PackedHalf2AtPtx2164R1444, r_PackedHalf2AtPtx2157R1445, r_PackedHalf2AtPtx2150R1446,
		r_PackedHalf2AtPtx2143R1447, r_PackedHalf2AtPtx2136R1448, r_PackedHalf2AtPtx2129R1449,
		r_PackedHalf2AtPtx2122R1450, r_PackedHalf2AtPtx2115R1451, r_PackedHalf2AtPtx2108R1452;
	uint32_t r_PackedHalf2AtPtx2101R1453, r_PackedHalf2AtPtx2535R1454, r_PackedHalf2AtPtx2542R1455,
		r_PtxRegister1456, r_MmaBE4x4WordAtPtx141R1457, r_MmaBE4x4WordAtPtx141R1458,
		r_MmaBE4x4WordAtPtx141R1459, r_MmaBE4x4WordAtPtx141R1460, r_MmaBE4x4WordAtPtx132R1461,
		r_MmaBE4x4WordAtPtx132R1462, r_MmaBE4x4WordAtPtx132R1463, r_MmaBE4x4WordAtPtx132R1464;
	uint32_t r_MmaBE4x4WordAtPtx123R1465, r_MmaBE4x4WordAtPtx123R1466, r_MmaBE4x4WordAtPtx123R1467,
		r_MmaBE4x4WordAtPtx123R1468, r_MmaBE4x4WordAtPtx114R1469, r_MmaBE4x4WordAtPtx114R1470,
		r_MmaBE4x4WordAtPtx114R1471, r_MmaBE4x4WordAtPtx114R1472, r_MmaBE4x4WordAtPtx105R1473,
		r_MmaBE4x4WordAtPtx105R1474, r_MmaBE4x4WordAtPtx105R1475, r_MmaBE4x4WordAtPtx105R1476;
	uint32_t r_MmaBE4x4WordAtPtx96R1477, r_MmaBE4x4WordAtPtx96R1478, r_MmaBE4x4WordAtPtx96R1479,
		r_MmaBE4x4WordAtPtx96R1480, r_MmaBE4x4WordAtPtx86R1481, r_MmaBE4x4WordAtPtx86R1482,
		r_MmaBE4x4WordAtPtx86R1483, r_MmaBE4x4WordAtPtx86R1484, r_MmaBE4x4WordAtPtx77R1485,
		r_MmaBE4x4WordAtPtx77R1486, r_MmaBE4x4WordAtPtx77R1487, r_MmaBE4x4WordAtPtx77R1488;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, g_OutputByteAddressAtPtx3557,
		g_OutputByteAddressAtPtx3625, g_OutputBaseAddress, g_RecordBaseAddress, g_RecordByteAddressAtPtx75,
		g_RecordByteAddressAtPtx84, g_RecordByteAddressAtPtx94, g_RecordByteAddressAtPtx103,
		g_RecordByteAddressAtPtx112, g_RecordByteAddressAtPtx121;
	uint64_t g_RecordByteAddressAtPtx130, g_RecordByteAddressAtPtx139, r_PtxU64Register15,
		g_RecordByteAddressAtPtx70, r_PtxU64Register17, r_PtxU64Register18, g_RecordByteAddressAtPtx83,
		r_PtxU64Register20, g_RecordByteAddressAtPtx93, r_PtxU64Register22, g_RecordByteAddressAtPtx102,
		r_PtxU64Register24;
	uint64_t g_RecordByteAddressAtPtx111, r_PtxU64Register26, g_RecordByteAddressAtPtx120, r_PtxU64Register28,
		g_RecordByteAddressAtPtx129, r_PtxU64Register30, g_RecordByteAddressAtPtx138, r_PtxU64Register32,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44,
		g_ResidualByteAddressAtPtx645, r_PtxU64Register46, g_ResidualByteAddressAtPtx640, r_PtxU64Register48;
	uint64_t g_ResidualByteAddressAtPtx682, r_PtxU64Register50, g_ResidualByteAddressAtPtx677,
		r_PtxU64Register52, g_ResidualByteAddressAtPtx724, r_PtxU64Register54, g_ResidualByteAddressAtPtx719,
		r_PtxU64Register56, g_ResidualByteAddressAtPtx761, r_PtxU64Register58, g_ResidualByteAddressAtPtx756,
		r_PtxU64Register60;
	uint64_t g_ResidualByteAddressAtPtx814, r_PtxU64Register62, g_ResidualByteAddressAtPtx809,
		r_PtxU64Register64, g_ResidualByteAddressAtPtx851, r_PtxU64Register66, g_ResidualByteAddressAtPtx846,
		r_PtxU64Register68, g_ResidualByteAddressAtPtx892, r_PtxU64Register70, g_ResidualByteAddressAtPtx887,
		r_PtxU64Register72;
	uint64_t g_ResidualByteAddressAtPtx929, r_PtxU64Register74, g_ResidualByteAddressAtPtx924,
		r_PtxU64Register76, g_RecordByteAddressAtPtx1145, r_PtxU64Register78, g_RecordByteAddressAtPtx1160,
		r_PtxU64Register80, g_RecordByteAddressAtPtx1174, r_PtxU64Register82, g_RecordByteAddressAtPtx1188,
		r_PtxU64Register84;
	uint64_t g_RecordByteAddressAtPtx1202, r_PtxU64Register86, g_RecordByteAddressAtPtx1216,
		r_PtxU64Register88, g_RecordByteAddressAtPtx1230, r_PtxU64Register90, g_RecordByteAddressAtPtx1247,
		r_PtxU64Register92, g_RecordByteAddressAtPtx1263, r_PtxU64Register94, g_RecordByteAddressAtPtx1278,
		r_PtxU64Register96;
	uint64_t g_RecordByteAddressAtPtx1292, r_PtxU64Register98, g_RecordByteAddressAtPtx1309,
		r_PtxU64Register100, g_RecordByteAddressAtPtx1325, r_PtxU64Register102, g_RecordByteAddressAtPtx1340,
		r_PtxU64Register104, g_RecordByteAddressAtPtx1354, r_PtxU64Register106, g_RecordByteAddressAtPtx1371,
		r_PtxU64Register108;
	uint64_t g_RecordByteAddressAtPtx1387, r_PtxU64Register110, g_RecordByteAddressAtPtx1401,
		r_PtxU64Register112, g_RecordByteAddressAtPtx1415, r_PtxU64Register114, g_RecordByteAddressAtPtx1429,
		r_PtxU64Register116, g_RecordByteAddressAtPtx1443, r_PtxU64Register118, g_RecordByteAddressAtPtx1457,
		r_PtxU64Register120;
	uint64_t g_RecordByteAddressAtPtx1471, r_PtxU64Register122, g_RecordByteAddressAtPtx1487,
		r_PtxU64Register124, g_RecordByteAddressAtPtx1503, r_PtxU64Register126, g_RecordByteAddressAtPtx1517,
		r_PtxU64Register128, g_RecordByteAddressAtPtx1531, r_PtxU64Register130, g_RecordByteAddressAtPtx1547,
		r_PtxU64Register132;
	uint64_t g_RecordByteAddressAtPtx1563, r_PtxU64Register134, g_RecordByteAddressAtPtx1577,
		r_PtxU64Register136, g_RecordByteAddressAtPtx1591, r_PtxU64Register138, g_RecordByteAddressAtPtx1607,
		r_PtxU64Register140, g_RecordByteAddressAtPtx1623, r_PtxU64Register142, g_RecordByteAddressAtPtx1637,
		r_PtxU64Register144;
	uint64_t g_RecordByteAddressAtPtx1651, r_PtxU64Register146, g_RecordByteAddressAtPtx1665,
		r_PtxU64Register148, g_RecordByteAddressAtPtx1679, r_PtxU64Register150, g_RecordByteAddressAtPtx1693,
		r_PtxU64Register152, g_RecordByteAddressAtPtx1707, r_PtxU64Register154, g_RecordByteAddressAtPtx1723,
		r_PtxU64Register156;
	uint64_t g_RecordByteAddressAtPtx1739, r_PtxU64Register158, g_RecordByteAddressAtPtx1753,
		r_PtxU64Register160, g_RecordByteAddressAtPtx1767, r_PtxU64Register162, g_RecordByteAddressAtPtx1783,
		r_PtxU64Register164, g_RecordByteAddressAtPtx1799, r_PtxU64Register166, g_RecordByteAddressAtPtx1813,
		r_PtxU64Register168;
	uint64_t g_RecordByteAddressAtPtx1827, r_PtxU64Register170, g_RecordByteAddressAtPtx1843,
		r_PtxU64Register172, g_RecordByteAddressAtPtx1859, r_PtxU64Register174, g_RecordByteAddressAtPtx1873,
		r_PtxU64Register176, g_RecordByteAddressAtPtx1887, r_PtxU64Register178, g_RecordByteAddressAtPtx1901,
		r_PtxU64Register180;
	uint64_t g_RecordByteAddressAtPtx1915, r_PtxU64Register182, g_RecordByteAddressAtPtx1929,
		r_PtxU64Register184, g_RecordByteAddressAtPtx1943, r_PtxU64Register186, g_RecordByteAddressAtPtx1959,
		r_PtxU64Register188, g_RecordByteAddressAtPtx1975, r_PtxU64Register190, g_RecordByteAddressAtPtx1989,
		r_PtxU64Register192;
	uint64_t g_RecordByteAddressAtPtx2003, r_PtxU64Register194, g_RecordByteAddressAtPtx2019,
		r_PtxU64Register196, g_RecordByteAddressAtPtx2035, r_PtxU64Register198, g_RecordByteAddressAtPtx2049,
		r_PtxU64Register200, g_RecordByteAddressAtPtx2063, r_PtxU64Register202, g_RecordByteAddressAtPtx2079,
		r_PtxU64Register204;
	uint64_t g_RecordByteAddressAtPtx2095, g_RecordByteAddressAtPtx3093, g_RecordByteAddressAtPtx3102,
		g_RecordByteAddressAtPtx3111, g_RecordByteAddressAtPtx3120, g_RecordByteAddressAtPtx3129,
		g_RecordByteAddressAtPtx3138, g_RecordByteAddressAtPtx3147, g_RecordByteAddressAtPtx3156,
		r_PtxU64Register214, g_RecordByteAddressAtPtx3088, r_PtxU64Register216;
	uint64_t r_PtxU64Register217, g_RecordByteAddressAtPtx3101, r_PtxU64Register219,
		g_RecordByteAddressAtPtx3110, r_PtxU64Register221, g_RecordByteAddressAtPtx3119, r_PtxU64Register223,
		g_RecordByteAddressAtPtx3128, r_PtxU64Register225, g_RecordByteAddressAtPtx3137, r_PtxU64Register227,
		g_RecordByteAddressAtPtx3146;
	uint64_t r_PtxU64Register229, g_RecordByteAddressAtPtx3155, r_PtxU64Register231, r_PtxU64Register232,
		r_PtxU64Register233, r_PtxU64Register234, r_PtxU64Register235, r_PtxU64Register236,
		g_OutputByteAddressAtPtx3572, g_OutputByteAddressAtPtx3581, r_PtxU64Register239, r_PtxU64Register240;
	uint64_t g_OutputByteAddressAtPtx3580, g_OutputByteAddressAtPtx3595, g_OutputByteAddressAtPtx3608,
		r_PtxU64Register244, g_OutputByteAddressAtPtx3594, r_PtxU64Register246, g_OutputByteAddressAtPtx3607,
		r_PtxU64Register248, g_OutputByteAddressAtPtx3632, g_OutputByteAddressAtPtx3645, r_PtxU64Register251,
		r_PtxU64Register252;
	uint64_t g_OutputByteAddressAtPtx3644, g_OutputByteAddressAtPtx3662, g_OutputByteAddressAtPtx3675,
		r_PtxU64Register256, g_OutputByteAddressAtPtx3661, r_PtxU64Register258, g_OutputByteAddressAtPtx3674,
		r_PtxU64Register260, r_PtxU64Register261, r_PtxU64Register262, r_PtxU64Register263,
		r_PtxU64Register264;
	uint64_t r_PtxU64Register265, r_PtxU64Register266, r_PtxU64Register267, r_PtxU64Register268,
		r_PtxU64Register269, r_PtxU64Register270, r_PtxU64Register271, r_PtxU64Register272,
		r_PtxU64Register273, r_PtxU64Register274, r_PtxU64Register275;
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
	r_PtxRegister44 = uint32_t(r_WidthBits) + uint32_t(-1);						// PTX L22
	r_PtxRegister45 = ShiftRightSigned(int32_t(r_PtxRegister44), uint32_t(31)); // PTX L23
	r_PtxRegister46 = ShiftRight(uint32_t(r_PtxRegister45), uint32_t(29));		// PTX L24
	r_PtxRegister47 = uint32_t(r_PtxRegister44) + uint32_t(r_PtxRegister46);	// PTX L25
	r_PtxRegister48 = ShiftRightSigned(int32_t(r_PtxRegister47), uint32_t(3));	// PTX L26
	r_PtxRegister49 = uint32_t(r_PtxRegister48) + uint32_t(1);					// PTX L27
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister49));		// PTX L28
	r_PtxRegister50 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister48) + uint32_t(r_PtxRegister2); // PTX L29
	r_PtxRegister51 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister50);						 // PTX L30
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaYAtPtx20), uint32_t(1));					 // PTX L31
	r_PtxRegister4 = ShiftLeft(uint32_t(r_PtxRegister51), uint32_t(1));					 // PTX L32
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
	r_PtxRegister59 = r_ThreadX | r_ThreadYAtPtx42;										 // PTX L43
	r_bPtxPredicate16 = uint32_t(r_PtxRegister59) != uint32_t(0);						 // PTX L44
	if (r_bPtxPredicate16)
	{
		goto L__BB13_2;
	} // PTX L45
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L46
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L47
	r_PtxRegister61 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L48
	r_PtxRegister60 = uint32_t(12288u /* exact native shared-region offset */); // PTX L49
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister60, r_PtxRegister61); // PTX L51
	r_PtxRegister62 = uint32_t(r_PtxRegister60) + uint32_t(8);		// PTX L53
	BarrierInit(s_SharedStorage, r_PtxRegister62, r_PtxRegister61); // PTX L55
	r_PtxRegister63 = uint32_t(r_PtxRegister60) + uint32_t(16);		// PTX L57
	BarrierInit(s_SharedStorage, r_PtxRegister63, r_PtxRegister61); // PTX L59
L__BB13_2:															// PTX L61
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L62
	r_PtxRegister74 = ShiftLeft(uint32_t(r_ThreadYAtPtx42), uint32_t(6));						// PTX L63
	r_PtxRegister75 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));							// PTX L64
	r_PtxRegister8 = uint32_t(r_PtxRegister74) + uint32_t(r_PtxRegister75);						// PTX L65
	r_PtxRegister76 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(16));							// PTX L66
	r_PtxRegister77 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(3));							// PTX L67
	r_PtxRegister78 = uint32_t(r_PtxRegister76) + uint32_t(r_PtxRegister77);					// PTX L68
	r_PtxU64Register15 = uint64_t(int64_t(int32_t(r_PtxRegister78)) * int64_t(int32_t(4)));		// PTX L69
	g_RecordByteAddressAtPtx70 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register15);	// PTX L70
	r_LaneIndexAtPtx72 = uint32_t((threadIdx.x & 31u));											// PTX L72
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx72)) * int64_t(int32_t(16))); // PTX L74
	g_RecordByteAddressAtPtx75 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register17); // PTX L75
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx75));
		r_MmaBE4x4WordAtPtx77R1488 = r_Value.x;
		r_MmaBE4x4WordAtPtx77R1487 = r_Value.y;
		r_MmaBE4x4WordAtPtx77R1486 = r_Value.z;
		r_MmaBE4x4WordAtPtx77R1485 = r_Value.w;
	} // PTX L77
	r_LaneIndexAtPtx80 = uint32_t((threadIdx.x & 31u));											// PTX L80
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx80)) * int64_t(int32_t(16))); // PTX L82
	g_RecordByteAddressAtPtx83 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register18);		   // PTX L83
	g_RecordByteAddressAtPtx84 = uint64_t(g_RecordByteAddressAtPtx83) + uint64_t(512); // PTX L84
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx84));
		r_MmaBE4x4WordAtPtx86R1484 = r_Value.x;
		r_MmaBE4x4WordAtPtx86R1483 = r_Value.y;
		r_MmaBE4x4WordAtPtx86R1482 = r_Value.z;
		r_MmaBE4x4WordAtPtx86R1481 = r_Value.w;
	} // PTX L86
	r_PtxRegister9 = r_PtxRegister8 | 32;														// PTX L88
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register20);			// PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(1024); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBE4x4WordAtPtx96R1480 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1479 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1478 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1477 = r_Value.w;
	} // PTX L96
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	g_RecordByteAddressAtPtx102 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register22);			  // PTX L102
	g_RecordByteAddressAtPtx103 = uint64_t(g_RecordByteAddressAtPtx102) + uint64_t(1536); // PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx103));
		r_MmaBE4x4WordAtPtx105R1476 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1475 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1474 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1473 = r_Value.w;
	} // PTX L105
	r_LaneIndexAtPtx108 = uint32_t((threadIdx.x & 31u));										 // PTX L108
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx108)) * int64_t(int32_t(16))); // PTX L110
	g_RecordByteAddressAtPtx111 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register24);			   // PTX L111
	g_RecordByteAddressAtPtx112 = uint64_t(g_RecordByteAddressAtPtx111) + uint64_t(16384); // PTX L112
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx112));
		r_MmaBE4x4WordAtPtx114R1472 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R1471 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R1470 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R1469 = r_Value.w;
	} // PTX L114
	r_LaneIndexAtPtx117 = uint32_t((threadIdx.x & 31u));										 // PTX L117
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx117)) * int64_t(int32_t(16))); // PTX L119
	g_RecordByteAddressAtPtx120 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register26);			   // PTX L120
	g_RecordByteAddressAtPtx121 = uint64_t(g_RecordByteAddressAtPtx120) + uint64_t(16896); // PTX L121
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx121));
		r_MmaBE4x4WordAtPtx123R1468 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R1467 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R1466 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R1465 = r_Value.w;
	} // PTX L123
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_RecordByteAddressAtPtx129 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register28);			   // PTX L129
	g_RecordByteAddressAtPtx130 = uint64_t(g_RecordByteAddressAtPtx129) + uint64_t(17408); // PTX L130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx130));
		r_MmaBE4x4WordAtPtx132R1464 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R1463 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R1462 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R1461 = r_Value.w;
	} // PTX L132
	r_LaneIndexAtPtx135 = uint32_t((threadIdx.x & 31u));										 // PTX L135
	r_PtxU64Register30 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx135)) * int64_t(int32_t(16))); // PTX L137
	g_RecordByteAddressAtPtx138 =
		uint64_t(g_RecordByteAddressAtPtx70) + uint64_t(r_PtxU64Register30);			   // PTX L138
	g_RecordByteAddressAtPtx139 = uint64_t(g_RecordByteAddressAtPtx138) + uint64_t(17920); // PTX L139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx139));
		r_MmaBE4x4WordAtPtx141R1460 = r_Value.x;
		r_MmaBE4x4WordAtPtx141R1459 = r_Value.y;
		r_MmaBE4x4WordAtPtx141R1458 = r_Value.z;
		r_MmaBE4x4WordAtPtx141R1457 = r_Value.w;
	} // PTX L141
	r_PtxRegister10 = r_ThreadYAtPtx42 & 1;									  // PTX L143
	r_PtxRegister79 = ShiftRight(uint32_t(r_ThreadYAtPtx42), uint32_t(1));	  // PTX L144
	r_PtxRegister80 = r_PtxRegister79 & 1;									  // PTX L145
	r_PtxRegister81 = ShiftRight(uint32_t(r_ThreadYAtPtx42), uint32_t(2));	  // PTX L146
	r_PtxRegister82 = ShiftLeft(uint32_t(r_PtxRegister81), uint32_t(9));	  // PTX L147
	r_PtxRegister83 = ShiftLeft(uint32_t(r_ThreadYAtPtx42), uint32_t(7));	  // PTX L148
	r_PtxRegister11 = r_PtxRegister83 & 256;								  // PTX L149
	r_PtxRegister84 = r_PtxRegister82 | r_PtxRegister11;					  // PTX L150
	r_PtxRegister12 = r_PtxRegister83 & 128;								  // PTX L151
	r_PtxRegister13 = r_PtxRegister84 | r_PtxRegister12;					  // PTX L152
	r_PtxRegister85 = uint32_t(r_PtxRegister81) + uint32_t(r_PtxRegister3);	  // PTX L153
	r_PtxRegister14 = uint32_t(r_PtxRegister80) + uint32_t(r_PtxRegister4);	  // PTX L154
	r_PtxRegister15 = r_HeightBits & -4;									  // PTX L155
	r_bPtxPredicate17 = uint32_t(r_PtxRegister15) == uint32_t(4);			  // PTX L156
	r_bPtxPredicate18 = int32_t(r_PtxRegister85) < int32_t(r_HeightDiv4Bits); // PTX L157
	r_PtxRegister86 = uint32_t(r_PtxRegister85) * uint32_t(r_WidthDiv4Bits);  // PTX L158
	r_PtxRegister16 = r_bPtxPredicate17 ? 0 : r_PtxRegister86;				  // PTX L159
	r_bPtxPredicate1 = r_bPtxPredicate17 | r_bPtxPredicate18;				  // PTX L160
	r_bPtxPredicate99 = bool(0);											  // PTX L161
	r_bPtxPredicate19 = !r_bPtxPredicate1;									  // PTX L162
	r_PtxRegister1354 = uint32_t(r_PtxRegister14);							  // PTX L163
	if (r_bPtxPredicate19)
	{
		goto L__BB13_5;
	} // PTX L164
	r_PtxRegister87 = r_WidthBits & -4;							  // PTX L165
	r_bPtxPredicate20 = uint32_t(r_PtxRegister87) == uint32_t(4); // PTX L166
	r_bPtxPredicate99 = bool(-1);								  // PTX L167
	r_PtxRegister1354 = uint32_t(0);							  // PTX L168
	if (r_bPtxPredicate20)
	{
		goto L__BB13_5;
	} // PTX L169
	r_bPtxPredicate99 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L170
	r_PtxRegister1354 = uint32_t(r_PtxRegister14);							 // PTX L171
L__BB13_5:																	 // PTX L172
	r_PtxU64Register260 = uint64_t(0);										 // PTX L173
	r_bPtxPredicate21 = !r_bPtxPredicate99;									 // PTX L174
	if (r_bPtxPredicate21)
	{
		goto L__BB13_7;
	} // PTX L175
	r_PtxRegister88 = uint32_t(r_PtxRegister16) + uint32_t(r_PtxRegister1354); // PTX L176
	r_PtxRegister89 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister88);	   // PTX L177
	r_PtxRegister90 = ShiftLeft(uint32_t(r_PtxRegister89), uint32_t(11));	   // PTX L178
	r_PtxRegister91 = r_PtxRegister90 | r_PtxRegister12;					   // PTX L179
	r_PtxU64Register260 = SignExtendWordBits(r_PtxRegister91);				   // PTX L180
L__BB13_7:																	   // PTX L181
	r_PtxU64Register261 = uint64_t(0);										   // PTX L182
	if (r_bPtxPredicate21)
	{
		goto L__BB13_9;
	} // PTX L183
	r_PtxU64Register32 = ShiftLeft(uint64_t(r_PtxU64Register260), uint32_t(2));		   // PTX L184
	r_PtxU64Register261 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register32); // PTX L185
L__BB13_9:																			   // PTX L186
	r_PtxRegister92 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(2));			   // PTX L187
	r_PtxRegister93 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L188
	r_PtxRegister17 = uint32_t(r_PtxRegister93) + uint32_t(r_PtxRegister92);		   // PTX L189
	if (r_bPtxPredicate21)
	{
		goto L__BB13_12;
	} // PTX L190
	r_PtxRegister101 = uint32_t(-1);							   // PTX L191
	r_PtxRegister100 = Elected(r_PtxRegister101);				   // PTX L193
	r_bPtxPredicate22 = uint32_t(r_PtxRegister100) == uint32_t(0); // PTX L199
	if (r_bPtxPredicate22)
	{
		goto L__BB13_13;
	} // PTX L200
	r_PtxU64Register33 = r_PtxU64Register261;									 // PTX L201
	r_PtxRegister103 = uint32_t(12288u /* exact native shared-region offset */); // PTX L202
	r_PtxRegister102 = uint32_t(512);											 // PTX L203
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister17, r_PtxU64Register33, r_PtxRegister102,
			 r_PtxRegister103);																 // PTX L205
	BarrierExpect(s_SharedStorage, r_PtxRegister103, r_PtxRegister102);						 // PTX L208
	goto L__BB13_13;																		 // PTX L210
L__BB13_12:																					 // PTX L211
	r_PtxRegister94 = uint32_t(0);															 // PTX L212
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister94))); // PTX L214
	r_PackedHalf2AtPtx217R95 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L217
	r_ConvertedE4PairAtPtx219Rs2 = PublishE4(r_PackedHalf2AtPtx217R95);						 // PTX L219
	r_PackedE4WordAtPtx221R98 =
		JoinHalfwords(r_ConvertedE4PairAtPtx219Rs2, r_ConvertedE4PairAtPtx219Rs2); // PTX L221
	r_LaneIndexAtPtx223 = uint32_t((threadIdx.x & 31u));						   // PTX L223
	r_PtxRegister99 = ShiftLeft(uint32_t(r_LaneIndexAtPtx223), uint32_t(4));	   // PTX L225
	r_PtxRegister97 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister99);	   // PTX L226
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister97)) =
		make_uint4(r_PackedE4WordAtPtx221R98, r_PackedE4WordAtPtx221R98, r_PackedE4WordAtPtx221R98,
				   r_PackedE4WordAtPtx221R98);								   // PTX L228
L__BB13_13:																	   // PTX L230
	r_bPtxPredicate23 = uint32_t(r_PtxRegister15) == uint32_t(4);			   // PTX L231
	r_PtxRegister104 = uint32_t(r_ThreadYAtPtx42) + uint32_t(4);			   // PTX L232
	r_PtxRegister105 = ShiftRight(uint32_t(r_PtxRegister104), uint32_t(2));	   // PTX L233
	r_PtxRegister106 = ShiftLeft(uint32_t(r_PtxRegister105), uint32_t(9));	   // PTX L234
	r_PtxRegister107 = r_PtxRegister106 | r_PtxRegister11;					   // PTX L235
	r_PtxRegister18 = uint32_t(r_PtxRegister107) + uint32_t(r_PtxRegister12);  // PTX L236
	r_PtxRegister108 = uint32_t(r_PtxRegister105) + uint32_t(r_PtxRegister3);  // PTX L237
	r_bPtxPredicate24 = int32_t(r_PtxRegister108) < int32_t(r_HeightDiv4Bits); // PTX L238
	r_PtxRegister109 = uint32_t(r_PtxRegister108) * uint32_t(r_WidthDiv4Bits); // PTX L239
	r_PtxRegister19 = r_bPtxPredicate23 ? 0 : r_PtxRegister109;				   // PTX L240
	r_bPtxPredicate2 = r_bPtxPredicate23 | r_bPtxPredicate24;				   // PTX L241
	r_bPtxPredicate100 = bool(0);											   // PTX L242
	r_bPtxPredicate25 = !r_bPtxPredicate2;									   // PTX L243
	r_PtxRegister1355 = uint32_t(r_PtxRegister14);							   // PTX L244
	if (r_bPtxPredicate25)
	{
		goto L__BB13_16;
	} // PTX L245
	r_PtxRegister110 = r_WidthBits & -4;						   // PTX L246
	r_bPtxPredicate26 = uint32_t(r_PtxRegister110) == uint32_t(4); // PTX L247
	r_bPtxPredicate100 = bool(-1);								   // PTX L248
	r_PtxRegister1355 = uint32_t(0);							   // PTX L249
	if (r_bPtxPredicate26)
	{
		goto L__BB13_16;
	} // PTX L250
	r_bPtxPredicate100 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L251
	r_PtxRegister1355 = uint32_t(r_PtxRegister14);							  // PTX L252
L__BB13_16:																	  // PTX L253
	r_PtxU64Register262 = uint64_t(0);										  // PTX L254
	r_bPtxPredicate27 = !r_bPtxPredicate100;								  // PTX L255
	if (r_bPtxPredicate27)
	{
		goto L__BB13_18;
	} // PTX L256
	r_PtxRegister111 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1355); // PTX L257
	r_PtxRegister112 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister111);	// PTX L258
	r_PtxRegister113 = ShiftLeft(uint32_t(r_PtxRegister112), uint32_t(11));		// PTX L259
	r_PtxRegister114 = r_PtxRegister113 | r_PtxRegister12;						// PTX L260
	r_PtxU64Register262 = SignExtendWordBits(r_PtxRegister114);					// PTX L261
L__BB13_18:																		// PTX L262
	r_PtxU64Register263 = uint64_t(0);											// PTX L263
	if (r_bPtxPredicate27)
	{
		goto L__BB13_20;
	} // PTX L264
	r_PtxU64Register34 = ShiftLeft(uint64_t(r_PtxU64Register262), uint32_t(2));		   // PTX L265
	r_PtxU64Register263 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register34); // PTX L266
L__BB13_20:																			   // PTX L267
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister18), uint32_t(2));			   // PTX L268
	r_PtxRegister116 = uint32_t(0u /* exact native shared-region offset */);		   // PTX L269
	r_PtxRegister20 = uint32_t(r_PtxRegister116) + uint32_t(r_PtxRegister115);		   // PTX L270
	if (r_bPtxPredicate27)
	{
		goto L__BB13_23;
	} // PTX L271
	r_PtxRegister124 = uint32_t(-1);							   // PTX L272
	r_PtxRegister123 = Elected(r_PtxRegister124);				   // PTX L274
	r_bPtxPredicate28 = uint32_t(r_PtxRegister123) == uint32_t(0); // PTX L280
	if (r_bPtxPredicate28)
	{
		goto L__BB13_24;
	} // PTX L281
	r_PtxU64Register35 = r_PtxU64Register263;									 // PTX L282
	r_PtxRegister126 = uint32_t(12288u /* exact native shared-region offset */); // PTX L283
	r_PtxRegister125 = uint32_t(512);											 // PTX L284
	CopyBulk(s_SharedStorage, r_PtxRegister20, r_PtxU64Register35, r_PtxRegister125,
			 r_PtxRegister126);																  // PTX L286
	BarrierExpect(s_SharedStorage, r_PtxRegister126, r_PtxRegister125);						  // PTX L289
	goto L__BB13_24;																		  // PTX L291
L__BB13_23:																					  // PTX L292
	r_PtxRegister117 = uint32_t(0);															  // PTX L293
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister117))); // PTX L295
	r_PackedHalf2AtPtx298R118 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		  // PTX L298
	r_ConvertedE4PairAtPtx300Rs4 = PublishE4(r_PackedHalf2AtPtx298R118);					  // PTX L300
	r_PackedE4WordAtPtx302R121 =
		JoinHalfwords(r_ConvertedE4PairAtPtx300Rs4, r_ConvertedE4PairAtPtx300Rs4); // PTX L302
	r_LaneIndexAtPtx304 = uint32_t((threadIdx.x & 31u));						   // PTX L304
	r_PtxRegister122 = ShiftLeft(uint32_t(r_LaneIndexAtPtx304), uint32_t(4));	   // PTX L306
	r_PtxRegister120 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister122);	   // PTX L307
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister120)) =
		make_uint4(r_PackedE4WordAtPtx302R121, r_PackedE4WordAtPtx302R121, r_PackedE4WordAtPtx302R121,
				   r_PackedE4WordAtPtx302R121);							// PTX L309
L__BB13_24:																// PTX L311
	r_PtxRegister127 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(9)); // PTX L312
	r_PtxRegister21 = r_PtxRegister127 | 64;							// PTX L313
	r_bPtxPredicate101 = bool(0);										// PTX L314
	r_PtxRegister1356 = uint32_t(r_PtxRegister14);						// PTX L315
	if (r_bPtxPredicate19)
	{
		goto L__BB13_27;
	} // PTX L316
	r_PtxRegister128 = r_WidthBits & -4;						   // PTX L317
	r_bPtxPredicate29 = uint32_t(r_PtxRegister128) == uint32_t(4); // PTX L318
	r_bPtxPredicate101 = bool(-1);								   // PTX L319
	r_PtxRegister1356 = uint32_t(0);							   // PTX L320
	if (r_bPtxPredicate29)
	{
		goto L__BB13_27;
	} // PTX L321
	r_bPtxPredicate101 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L322
	r_PtxRegister1356 = uint32_t(r_PtxRegister14);							  // PTX L323
L__BB13_27:																	  // PTX L324
	r_PtxU64Register264 = uint64_t(0);										  // PTX L325
	r_bPtxPredicate30 = !r_bPtxPredicate101;								  // PTX L326
	if (r_bPtxPredicate30)
	{
		goto L__BB13_29;
	} // PTX L327
	r_PtxRegister129 = uint32_t(r_PtxRegister16) + uint32_t(r_PtxRegister1356); // PTX L328
	r_PtxRegister130 = ShiftRight(uint32_t(r_PtxRegister21), uint32_t(5));		// PTX L329
	r_PtxRegister131 = uint32_t(r_PtxRegister130) + uint32_t(r_PtxRegister10);	// PTX L330
	r_PtxRegister132 = ShiftLeft(uint32_t(r_PtxRegister129), uint32_t(11));		// PTX L331
	r_PtxRegister133 = ShiftLeft(uint32_t(r_PtxRegister131), uint32_t(7));		// PTX L332
	r_PtxRegister134 = uint32_t(r_PtxRegister132) + uint32_t(r_PtxRegister133); // PTX L333
	r_PtxU64Register264 = SignExtendWordBits(r_PtxRegister134);					// PTX L334
L__BB13_29:																		// PTX L335
	r_PtxU64Register265 = uint64_t(0);											// PTX L336
	if (r_bPtxPredicate30)
	{
		goto L__BB13_31;
	} // PTX L337
	r_PtxU64Register36 = ShiftLeft(uint64_t(r_PtxU64Register264), uint32_t(2));		   // PTX L338
	r_PtxU64Register265 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register36); // PTX L339
L__BB13_31:																			   // PTX L340
	if (r_bPtxPredicate30)
	{
		goto L__BB13_34;
	} // PTX L341
	r_PtxRegister143 = uint32_t(-1);							   // PTX L342
	r_PtxRegister142 = Elected(r_PtxRegister143);				   // PTX L344
	r_bPtxPredicate31 = uint32_t(r_PtxRegister142) == uint32_t(0); // PTX L350
	if (r_bPtxPredicate31)
	{
		goto L__BB13_35;
	} // PTX L351
	r_PtxRegister144 = uint32_t(r_PtxRegister17) + uint32_t(4096);				 // PTX L352
	r_PtxU64Register37 = r_PtxU64Register265;									 // PTX L353
	r_PtxRegister147 = uint32_t(12288u /* exact native shared-region offset */); // PTX L354
	r_PtxRegister146 = uint32_t(r_PtxRegister147) + uint32_t(8);				 // PTX L355
	r_PtxRegister145 = uint32_t(512);											 // PTX L356
	CopyBulk(s_SharedStorage, r_PtxRegister144, r_PtxU64Register37, r_PtxRegister145,
			 r_PtxRegister146);																  // PTX L358
	BarrierExpect(s_SharedStorage, r_PtxRegister146, r_PtxRegister145);						  // PTX L361
	goto L__BB13_35;																		  // PTX L363
L__BB13_34:																					  // PTX L364
	r_PtxRegister135 = uint32_t(0);															  // PTX L365
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister135))); // PTX L367
	r_PackedHalf2AtPtx370R136 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);		  // PTX L370
	r_ConvertedE4PairAtPtx372Rs6 = PublishE4(r_PackedHalf2AtPtx370R136);					  // PTX L372
	r_PackedE4WordAtPtx374R139 =
		JoinHalfwords(r_ConvertedE4PairAtPtx372Rs6, r_ConvertedE4PairAtPtx372Rs6); // PTX L374
	r_LaneIndexAtPtx376 = uint32_t((threadIdx.x & 31u));						   // PTX L376
	r_PtxRegister140 = ShiftLeft(uint32_t(r_LaneIndexAtPtx376), uint32_t(4));	   // PTX L378
	r_PtxRegister141 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister140);	   // PTX L379
	r_PtxRegister138 = uint32_t(r_PtxRegister141) + uint32_t(4096);				   // PTX L380
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister138)) =
		make_uint4(r_PackedE4WordAtPtx374R139, r_PackedE4WordAtPtx374R139, r_PackedE4WordAtPtx374R139,
				   r_PackedE4WordAtPtx374R139);	   // PTX L382
L__BB13_35:										   // PTX L384
	r_bPtxPredicate102 = bool(0);				   // PTX L385
	r_PtxRegister1357 = uint32_t(r_PtxRegister14); // PTX L386
	if (r_bPtxPredicate25)
	{
		goto L__BB13_38;
	} // PTX L387
	r_PtxRegister148 = r_WidthBits & -4;						   // PTX L388
	r_bPtxPredicate32 = uint32_t(r_PtxRegister148) == uint32_t(4); // PTX L389
	r_bPtxPredicate102 = bool(-1);								   // PTX L390
	r_PtxRegister1357 = uint32_t(0);							   // PTX L391
	if (r_bPtxPredicate32)
	{
		goto L__BB13_38;
	} // PTX L392
	r_bPtxPredicate102 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L393
	r_PtxRegister1357 = uint32_t(r_PtxRegister14);							  // PTX L394
L__BB13_38:																	  // PTX L395
	r_PtxU64Register266 = uint64_t(0);										  // PTX L396
	r_bPtxPredicate33 = !r_bPtxPredicate102;								  // PTX L397
	if (r_bPtxPredicate33)
	{
		goto L__BB13_40;
	} // PTX L398
	r_PtxRegister149 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1357); // PTX L399
	r_PtxRegister150 = ShiftRight(uint32_t(r_PtxRegister21), uint32_t(5));		// PTX L400
	r_PtxRegister151 = uint32_t(r_PtxRegister150) + uint32_t(r_PtxRegister10);	// PTX L401
	r_PtxRegister152 = ShiftLeft(uint32_t(r_PtxRegister149), uint32_t(11));		// PTX L402
	r_PtxRegister153 = ShiftLeft(uint32_t(r_PtxRegister151), uint32_t(7));		// PTX L403
	r_PtxRegister154 = uint32_t(r_PtxRegister152) + uint32_t(r_PtxRegister153); // PTX L404
	r_PtxU64Register266 = SignExtendWordBits(r_PtxRegister154);					// PTX L405
L__BB13_40:																		// PTX L406
	r_PtxU64Register267 = uint64_t(0);											// PTX L407
	if (r_bPtxPredicate33)
	{
		goto L__BB13_42;
	} // PTX L408
	r_PtxU64Register38 = ShiftLeft(uint64_t(r_PtxU64Register266), uint32_t(2));		   // PTX L409
	r_PtxU64Register267 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register38); // PTX L410
L__BB13_42:																			   // PTX L411
	if (r_bPtxPredicate33)
	{
		goto L__BB13_45;
	} // PTX L412
	r_PtxRegister163 = uint32_t(-1);							   // PTX L413
	r_PtxRegister162 = Elected(r_PtxRegister163);				   // PTX L415
	r_bPtxPredicate34 = uint32_t(r_PtxRegister162) == uint32_t(0); // PTX L421
	if (r_bPtxPredicate34)
	{
		goto L__BB13_46;
	} // PTX L422
	r_PtxRegister164 = uint32_t(r_PtxRegister20) + uint32_t(4096);				 // PTX L423
	r_PtxU64Register39 = r_PtxU64Register267;									 // PTX L424
	r_PtxRegister167 = uint32_t(12288u /* exact native shared-region offset */); // PTX L425
	r_PtxRegister166 = uint32_t(r_PtxRegister167) + uint32_t(8);				 // PTX L426
	r_PtxRegister165 = uint32_t(512);											 // PTX L427
	CopyBulk(s_SharedStorage, r_PtxRegister164, r_PtxU64Register39, r_PtxRegister165,
			 r_PtxRegister166);																  // PTX L429
	BarrierExpect(s_SharedStorage, r_PtxRegister166, r_PtxRegister165);						  // PTX L432
	goto L__BB13_46;																		  // PTX L434
L__BB13_45:																					  // PTX L435
	r_PtxRegister155 = uint32_t(0);															  // PTX L436
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister155))); // PTX L438
	r_PackedHalf2AtPtx441R156 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L441
	r_ConvertedE4PairAtPtx443Rs8 = PublishE4(r_PackedHalf2AtPtx441R156);					  // PTX L443
	r_PackedE4WordAtPtx445R159 =
		JoinHalfwords(r_ConvertedE4PairAtPtx443Rs8, r_ConvertedE4PairAtPtx443Rs8); // PTX L445
	r_LaneIndexAtPtx447 = uint32_t((threadIdx.x & 31u));						   // PTX L447
	r_PtxRegister160 = ShiftLeft(uint32_t(r_LaneIndexAtPtx447), uint32_t(4));	   // PTX L449
	r_PtxRegister161 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister160);	   // PTX L450
	r_PtxRegister158 = uint32_t(r_PtxRegister161) + uint32_t(4096);				   // PTX L451
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister158)) =
		make_uint4(r_PackedE4WordAtPtx445R159, r_PackedE4WordAtPtx445R159, r_PackedE4WordAtPtx445R159,
				   r_PackedE4WordAtPtx445R159);					// PTX L453
L__BB13_46:														// PTX L455
	r_PtxRegister22 = uint32_t(r_PtxRegister21) + uint32_t(64); // PTX L456
	r_bPtxPredicate103 = bool(0);								// PTX L457
	r_PtxRegister1358 = uint32_t(r_PtxRegister14);				// PTX L458
	if (r_bPtxPredicate19)
	{
		goto L__BB13_49;
	} // PTX L459
	r_PtxRegister168 = r_WidthBits & -4;						   // PTX L460
	r_bPtxPredicate35 = uint32_t(r_PtxRegister168) == uint32_t(4); // PTX L461
	r_bPtxPredicate103 = bool(-1);								   // PTX L462
	r_PtxRegister1358 = uint32_t(0);							   // PTX L463
	if (r_bPtxPredicate35)
	{
		goto L__BB13_49;
	} // PTX L464
	r_bPtxPredicate103 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L465
	r_PtxRegister1358 = uint32_t(r_PtxRegister14);							  // PTX L466
L__BB13_49:																	  // PTX L467
	r_PtxU64Register268 = uint64_t(0);										  // PTX L468
	r_bPtxPredicate36 = !r_bPtxPredicate103;								  // PTX L469
	if (r_bPtxPredicate36)
	{
		goto L__BB13_51;
	} // PTX L470
	r_PtxRegister169 = uint32_t(r_PtxRegister16) + uint32_t(r_PtxRegister1358); // PTX L471
	r_PtxRegister170 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L472
	r_PtxRegister171 = uint32_t(r_PtxRegister170) + uint32_t(r_PtxRegister10);	// PTX L473
	r_PtxRegister172 = ShiftLeft(uint32_t(r_PtxRegister169), uint32_t(11));		// PTX L474
	r_PtxRegister173 = ShiftLeft(uint32_t(r_PtxRegister171), uint32_t(7));		// PTX L475
	r_PtxRegister174 = uint32_t(r_PtxRegister172) + uint32_t(r_PtxRegister173); // PTX L476
	r_PtxU64Register268 = SignExtendWordBits(r_PtxRegister174);					// PTX L477
L__BB13_51:																		// PTX L478
	r_PtxU64Register269 = uint64_t(0);											// PTX L479
	if (r_bPtxPredicate36)
	{
		goto L__BB13_53;
	} // PTX L480
	r_PtxU64Register40 = ShiftLeft(uint64_t(r_PtxU64Register268), uint32_t(2));		   // PTX L481
	r_PtxU64Register269 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register40); // PTX L482
L__BB13_53:																			   // PTX L483
	if (r_bPtxPredicate36)
	{
		goto L__BB13_56;
	} // PTX L484
	r_PtxRegister183 = uint32_t(-1);							   // PTX L485
	r_PtxRegister182 = Elected(r_PtxRegister183);				   // PTX L487
	r_bPtxPredicate37 = uint32_t(r_PtxRegister182) == uint32_t(0); // PTX L493
	if (r_bPtxPredicate37)
	{
		goto L__BB13_57;
	} // PTX L494
	r_PtxRegister184 = uint32_t(r_PtxRegister17) + uint32_t(8192);				 // PTX L495
	r_PtxU64Register41 = r_PtxU64Register269;									 // PTX L496
	r_PtxRegister187 = uint32_t(12288u /* exact native shared-region offset */); // PTX L497
	r_PtxRegister186 = uint32_t(r_PtxRegister187) + uint32_t(16);				 // PTX L498
	r_PtxRegister185 = uint32_t(512);											 // PTX L499
	CopyBulk(s_SharedStorage, r_PtxRegister184, r_PtxU64Register41, r_PtxRegister185,
			 r_PtxRegister186);																  // PTX L501
	BarrierExpect(s_SharedStorage, r_PtxRegister186, r_PtxRegister185);						  // PTX L504
	goto L__BB13_57;																		  // PTX L506
L__BB13_56:																					  // PTX L507
	r_PtxRegister175 = uint32_t(0);															  // PTX L508
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister175))); // PTX L510
	r_PackedHalf2AtPtx513R176 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L513
	r_ConvertedE4PairAtPtx515Rs10 = PublishE4(r_PackedHalf2AtPtx513R176);					  // PTX L515
	r_PackedE4WordAtPtx517R179 =
		JoinHalfwords(r_ConvertedE4PairAtPtx515Rs10, r_ConvertedE4PairAtPtx515Rs10); // PTX L517
	r_LaneIndexAtPtx519 = uint32_t((threadIdx.x & 31u));							 // PTX L519
	r_PtxRegister180 = ShiftLeft(uint32_t(r_LaneIndexAtPtx519), uint32_t(4));		 // PTX L521
	r_PtxRegister181 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister180);		 // PTX L522
	r_PtxRegister178 = uint32_t(r_PtxRegister181) + uint32_t(8192);					 // PTX L523
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister178)) =
		make_uint4(r_PackedE4WordAtPtx517R179, r_PackedE4WordAtPtx517R179, r_PackedE4WordAtPtx517R179,
				   r_PackedE4WordAtPtx517R179);	   // PTX L525
L__BB13_57:										   // PTX L527
	r_bPtxPredicate104 = bool(0);				   // PTX L528
	r_PtxRegister1359 = uint32_t(r_PtxRegister14); // PTX L529
	if (r_bPtxPredicate25)
	{
		goto L__BB13_60;
	} // PTX L530
	r_PtxRegister188 = r_WidthBits & -4;						   // PTX L531
	r_bPtxPredicate38 = uint32_t(r_PtxRegister188) == uint32_t(4); // PTX L532
	r_bPtxPredicate104 = bool(-1);								   // PTX L533
	r_PtxRegister1359 = uint32_t(0);							   // PTX L534
	if (r_bPtxPredicate38)
	{
		goto L__BB13_60;
	} // PTX L535
	r_bPtxPredicate104 = int32_t(r_PtxRegister14) < int32_t(r_WidthDiv4Bits); // PTX L536
	r_PtxRegister1359 = uint32_t(r_PtxRegister14);							  // PTX L537
L__BB13_60:																	  // PTX L538
	r_PtxU64Register270 = uint64_t(0);										  // PTX L539
	r_bPtxPredicate39 = !r_bPtxPredicate104;								  // PTX L540
	if (r_bPtxPredicate39)
	{
		goto L__BB13_62;
	} // PTX L541
	r_PtxRegister189 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister1359); // PTX L542
	r_PtxRegister190 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L543
	r_PtxRegister191 = uint32_t(r_PtxRegister190) + uint32_t(r_PtxRegister10);	// PTX L544
	r_PtxRegister192 = ShiftLeft(uint32_t(r_PtxRegister189), uint32_t(11));		// PTX L545
	r_PtxRegister193 = ShiftLeft(uint32_t(r_PtxRegister191), uint32_t(7));		// PTX L546
	r_PtxRegister194 = uint32_t(r_PtxRegister192) + uint32_t(r_PtxRegister193); // PTX L547
	r_PtxU64Register270 = SignExtendWordBits(r_PtxRegister194);					// PTX L548
L__BB13_62:																		// PTX L549
	r_PtxU64Register271 = uint64_t(0);											// PTX L550
	if (r_bPtxPredicate39)
	{
		goto L__BB13_64;
	} // PTX L551
	r_PtxU64Register42 = ShiftLeft(uint64_t(r_PtxU64Register270), uint32_t(2));		   // PTX L552
	r_PtxU64Register271 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register42); // PTX L553
L__BB13_64:																			   // PTX L554
	if (r_bPtxPredicate39)
	{
		goto L__BB13_67;
	} // PTX L555
	r_PtxRegister203 = uint32_t(-1);							   // PTX L556
	r_PtxRegister202 = Elected(r_PtxRegister203);				   // PTX L558
	r_bPtxPredicate40 = uint32_t(r_PtxRegister202) == uint32_t(0); // PTX L564
	if (r_bPtxPredicate40)
	{
		goto L__BB13_68;
	} // PTX L565
	r_PtxRegister204 = uint32_t(r_PtxRegister20) + uint32_t(8192);				 // PTX L566
	r_PtxU64Register43 = r_PtxU64Register271;									 // PTX L567
	r_PtxRegister207 = uint32_t(12288u /* exact native shared-region offset */); // PTX L568
	r_PtxRegister206 = uint32_t(r_PtxRegister207) + uint32_t(16);				 // PTX L569
	r_PtxRegister205 = uint32_t(512);											 // PTX L570
	CopyBulk(s_SharedStorage, r_PtxRegister204, r_PtxU64Register43, r_PtxRegister205,
			 r_PtxRegister206);																   // PTX L572
	BarrierExpect(s_SharedStorage, r_PtxRegister206, r_PtxRegister205);						   // PTX L575
	goto L__BB13_68;																		   // PTX L577
L__BB13_67:																					   // PTX L578
	r_PtxRegister195 = uint32_t(0);															   // PTX L579
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister195))); // PTX L581
	r_PackedHalf2AtPtx584R196 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L584
	r_ConvertedE4PairAtPtx586Rs12 = PublishE4(r_PackedHalf2AtPtx584R196);					   // PTX L586
	r_PackedE4WordAtPtx588R199 =
		JoinHalfwords(r_ConvertedE4PairAtPtx586Rs12, r_ConvertedE4PairAtPtx586Rs12); // PTX L588
	r_LaneIndexAtPtx590 = uint32_t((threadIdx.x & 31u));							 // PTX L590
	r_PtxRegister200 = ShiftLeft(uint32_t(r_LaneIndexAtPtx590), uint32_t(4));		 // PTX L592
	r_PtxRegister201 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister200);		 // PTX L593
	r_PtxRegister198 = uint32_t(r_PtxRegister201) + uint32_t(8192);					 // PTX L594
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister198)) =
		make_uint4(r_PackedE4WordAtPtx588R199, r_PackedE4WordAtPtx588R199, r_PackedE4WordAtPtx588R199,
				   r_PackedE4WordAtPtx588R199);									 // PTX L596
L__BB13_68:																		 // PTX L598
	r_PtxRegister208 = uint32_t(12288u /* exact native shared-region offset */); // PTX L599
	r_PtxRegister209 = uint32_t(1);												 // PTX L600
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register44 = BarrierArrive(s_SharedStorage, r_PtxRegister208, r_PtxRegister209); // PTX L602
L__BB13_69:																					 // PTX L604
	r_PtxRegister211 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L605
	r_PtxRegister210 = BarrierReady(s_SharedStorage, r_PtxRegister211, r_PtxU64Register44);	 // PTX L607
	r_bPtxPredicate41 = uint32_t(r_PtxRegister210) == uint32_t(0);							 // PTX L613
	if (r_bPtxPredicate41)
	{
		goto L__BB13_69;
	} // PTX L614
	r_bPtxPredicate3 = uint32_t(r_PtxRegister15) != uint32_t(4);			  // PTX L615
	r_bPtxPredicate42 = uint32_t(r_PtxRegister15) == uint32_t(4);			  // PTX L616
	r_PtxRegister23 = r_WidthBits & -4;										  // PTX L617
	r_bPtxPredicate43 = uint32_t(r_PtxRegister23) == uint32_t(4);			  // PTX L618
	r_bPtxPredicate44 = int32_t(r_PtxRegister3) < int32_t(r_HeightDiv4Bits);  // PTX L619
	r_bPtxPredicate45 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L620
	r_PtxRegister24 = uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits);	  // PTX L621
	r_PtxRegister25 = r_bPtxPredicate42 ? 0 : r_PtxRegister24;				  // PTX L622
	r_bPtxPredicate46 = r_bPtxPredicate3 & r_bPtxPredicate45;				  // PTX L623
	r_bPtxPredicate4 = r_bPtxPredicate42 | r_bPtxPredicate44;				  // PTX L624
	r_bPtxPredicate5 = r_bPtxPredicate46 | r_bPtxPredicate43;				  // PTX L625
	r_bPtxPredicate47 = int32_t(r_PtxRegister4) < int32_t(r_WidthDiv4Bits);	  // PTX L626
	r_bPtxPredicate48 = !r_bPtxPredicate46;									  // PTX L627
	r_bPtxPredicate6 = r_bPtxPredicate43 & r_bPtxPredicate48;				  // PTX L628
	r_PtxRegister26 = r_bPtxPredicate6 ? 0 : r_PtxRegister4;				  // PTX L629
	r_bPtxPredicate49 = r_bPtxPredicate5 | r_bPtxPredicate47;				  // PTX L630
	r_bPtxPredicate7 = r_bPtxPredicate49 & r_bPtxPredicate4;				  // PTX L631
	if (r_bPtxPredicate7)
	{
		goto L__BB13_72;
	} // PTX L632
	goto L__BB13_71;																		 // PTX L633
L__BB13_72:																					 // PTX L634
	r_PtxRegister215 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister26);				 // PTX L635
	r_PtxRegister216 = ShiftLeft(uint32_t(r_PtxRegister215), uint32_t(11));					 // PTX L636
	r_PtxRegister217 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					 // PTX L637
	r_PtxRegister218 = uint32_t(r_PtxRegister216) + uint32_t(r_PtxRegister217);				 // PTX L638
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_PtxRegister218)) * int64_t(int32_t(4))); // PTX L639
	g_ResidualByteAddressAtPtx640 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register46);							 // PTX L640
	r_LaneIndexAtPtx642 = uint32_t((threadIdx.x & 31u));										 // PTX L642
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx642)) * int64_t(int32_t(16))); // PTX L644
	g_ResidualByteAddressAtPtx645 =
		uint64_t(g_ResidualByteAddressAtPtx640) + uint64_t(r_PtxU64Register48); // PTX L645
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx645));
		r_PtxRegister1360 = r_Value.x;
		r_PtxRegister1361 = r_Value.y;
		r_PtxRegister1362 = r_Value.z;
		r_PtxRegister1363 = r_Value.w;
	} // PTX L647
	goto L__BB13_73;																		   // PTX L649
L__BB13_71:																					   // PTX L650
	r_PtxRegister212 = uint32_t(0);															   // PTX L651
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister212))); // PTX L653
	r_PackedHalf2AtPtx656R213 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L656
	r_ConvertedE4PairAtPtx658Rs14 = PublishE4(r_PackedHalf2AtPtx656R213);					   // PTX L658
	r_PtxRegister1360 =
		JoinHalfwords(r_ConvertedE4PairAtPtx658Rs14, r_ConvertedE4PairAtPtx658Rs14); // PTX L660
	r_PtxRegister1361 = uint32_t(r_PtxRegister1360);								 // PTX L661
	r_PtxRegister1362 = uint32_t(r_PtxRegister1360);								 // PTX L662
	r_PtxRegister1363 = uint32_t(r_PtxRegister1360);								 // PTX L663
L__BB13_73:																			 // PTX L664
	r_PtxU16Register29 = uint16_t(r_PtxRegister1360);
	r_PtxU16Register30 = uint16_t(r_PtxRegister1360 >> 16); // PTX L665
	r_PtxU16Register35 = uint16_t(r_PtxRegister1363);
	r_PtxU16Register36 = uint16_t(r_PtxRegister1363 >> 16); // PTX L666
	r_PtxU16Register33 = uint16_t(r_PtxRegister1362);
	r_PtxU16Register34 = uint16_t(r_PtxRegister1362 >> 16); // PTX L667
	r_PtxU16Register31 = uint16_t(r_PtxRegister1361);
	r_PtxU16Register32 = uint16_t(r_PtxRegister1361 >> 16); // PTX L668
	if (r_bPtxPredicate7)
	{
		goto L__BB13_75;
	} // PTX L669
	goto L__BB13_74;																		 // PTX L670
L__BB13_75:																					 // PTX L671
	r_PtxRegister222 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister26);				 // PTX L672
	r_PtxRegister223 = ShiftLeft(uint32_t(r_PtxRegister222), uint32_t(11));					 // PTX L673
	r_PtxRegister224 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));					 // PTX L674
	r_PtxRegister225 = uint32_t(r_PtxRegister223) + uint32_t(r_PtxRegister224);				 // PTX L675
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister225)) * int64_t(int32_t(4))); // PTX L676
	g_ResidualByteAddressAtPtx677 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register50);							 // PTX L677
	r_LaneIndexAtPtx679 = uint32_t((threadIdx.x & 31u));										 // PTX L679
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx679)) * int64_t(int32_t(16))); // PTX L681
	g_ResidualByteAddressAtPtx682 =
		uint64_t(g_ResidualByteAddressAtPtx677) + uint64_t(r_PtxU64Register52); // PTX L682
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx682));
		r_PtxRegister1364 = r_Value.x;
		r_PtxRegister1365 = r_Value.y;
		r_PtxRegister1366 = r_Value.z;
		r_PtxRegister1367 = r_Value.w;
	} // PTX L684
	goto L__BB13_76;																		   // PTX L686
L__BB13_74:																					   // PTX L687
	r_PtxRegister219 = uint32_t(0);															   // PTX L688
	r_PtxU16Register15 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister219))); // PTX L690
	r_PackedHalf2AtPtx693R220 = JoinHalfwords(r_PtxU16Register15, r_PtxU16Register15);		   // PTX L693
	r_ConvertedE4PairAtPtx695Rs16 = PublishE4(r_PackedHalf2AtPtx693R220);					   // PTX L695
	r_PtxRegister1364 =
		JoinHalfwords(r_ConvertedE4PairAtPtx695Rs16, r_ConvertedE4PairAtPtx695Rs16); // PTX L697
	r_PtxRegister1365 = uint32_t(r_PtxRegister1364);								 // PTX L698
	r_PtxRegister1366 = uint32_t(r_PtxRegister1364);								 // PTX L699
	r_PtxRegister1367 = uint32_t(r_PtxRegister1364);								 // PTX L700
L__BB13_76:																			 // PTX L701
	r_PtxRegister27 = uint32_t(r_PtxRegister4) + uint32_t(1);						 // PTX L702
	r_PtxU16Register43 = uint16_t(r_PtxRegister1367);
	r_PtxU16Register44 = uint16_t(r_PtxRegister1367 >> 16); // PTX L703
	r_PtxU16Register41 = uint16_t(r_PtxRegister1366);
	r_PtxU16Register42 = uint16_t(r_PtxRegister1366 >> 16); // PTX L704
	r_PtxU16Register39 = uint16_t(r_PtxRegister1365);
	r_PtxU16Register40 = uint16_t(r_PtxRegister1365 >> 16); // PTX L705
	r_PtxU16Register37 = uint16_t(r_PtxRegister1364);
	r_PtxU16Register38 = uint16_t(r_PtxRegister1364 >> 16);					 // PTX L706
	r_bPtxPredicate50 = int32_t(r_PtxRegister27) < int32_t(r_WidthDiv4Bits); // PTX L707
	r_PtxRegister28 = r_bPtxPredicate6 ? 0 : r_PtxRegister27;				 // PTX L708
	r_bPtxPredicate51 = r_bPtxPredicate5 | r_bPtxPredicate50;				 // PTX L709
	r_bPtxPredicate8 = r_bPtxPredicate51 & r_bPtxPredicate4;				 // PTX L710
	if (r_bPtxPredicate8)
	{
		goto L__BB13_78;
	} // PTX L711
	goto L__BB13_77;																		 // PTX L712
L__BB13_78:																					 // PTX L713
	r_PtxRegister229 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister28);				 // PTX L714
	r_PtxRegister230 = ShiftLeft(uint32_t(r_PtxRegister229), uint32_t(11));					 // PTX L715
	r_PtxRegister231 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					 // PTX L716
	r_PtxRegister232 = uint32_t(r_PtxRegister230) + uint32_t(r_PtxRegister231);				 // PTX L717
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister232)) * int64_t(int32_t(4))); // PTX L718
	g_ResidualByteAddressAtPtx719 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register54);							 // PTX L719
	r_LaneIndexAtPtx721 = uint32_t((threadIdx.x & 31u));										 // PTX L721
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx721)) * int64_t(int32_t(16))); // PTX L723
	g_ResidualByteAddressAtPtx724 =
		uint64_t(g_ResidualByteAddressAtPtx719) + uint64_t(r_PtxU64Register56); // PTX L724
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx724));
		r_PtxRegister1368 = r_Value.x;
		r_PtxRegister1369 = r_Value.y;
		r_PtxRegister1370 = r_Value.z;
		r_PtxRegister1371 = r_Value.w;
	} // PTX L726
	goto L__BB13_79;																		   // PTX L728
L__BB13_77:																					   // PTX L729
	r_PtxRegister226 = uint32_t(0);															   // PTX L730
	r_PtxU16Register17 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister226))); // PTX L732
	r_PackedHalf2AtPtx735R227 = JoinHalfwords(r_PtxU16Register17, r_PtxU16Register17);		   // PTX L735
	r_ConvertedE4PairAtPtx737Rs18 = PublishE4(r_PackedHalf2AtPtx735R227);					   // PTX L737
	r_PtxRegister1368 =
		JoinHalfwords(r_ConvertedE4PairAtPtx737Rs18, r_ConvertedE4PairAtPtx737Rs18); // PTX L739
	r_PtxRegister1369 = uint32_t(r_PtxRegister1368);								 // PTX L740
	r_PtxRegister1370 = uint32_t(r_PtxRegister1368);								 // PTX L741
	r_PtxRegister1371 = uint32_t(r_PtxRegister1368);								 // PTX L742
L__BB13_79:																			 // PTX L743
	r_PtxU16Register45 = uint16_t(r_PtxRegister1368);
	r_PtxU16Register46 = uint16_t(r_PtxRegister1368 >> 16); // PTX L744
	r_PtxU16Register51 = uint16_t(r_PtxRegister1371);
	r_PtxU16Register52 = uint16_t(r_PtxRegister1371 >> 16); // PTX L745
	r_PtxU16Register49 = uint16_t(r_PtxRegister1370);
	r_PtxU16Register50 = uint16_t(r_PtxRegister1370 >> 16); // PTX L746
	r_PtxU16Register47 = uint16_t(r_PtxRegister1369);
	r_PtxU16Register48 = uint16_t(r_PtxRegister1369 >> 16); // PTX L747
	if (r_bPtxPredicate8)
	{
		goto L__BB13_81;
	} // PTX L748
	goto L__BB13_80;																		 // PTX L749
L__BB13_81:																					 // PTX L750
	r_PtxRegister236 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister28);				 // PTX L751
	r_PtxRegister237 = ShiftLeft(uint32_t(r_PtxRegister236), uint32_t(11));					 // PTX L752
	r_PtxRegister238 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));					 // PTX L753
	r_PtxRegister239 = uint32_t(r_PtxRegister237) + uint32_t(r_PtxRegister238);				 // PTX L754
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister239)) * int64_t(int32_t(4))); // PTX L755
	g_ResidualByteAddressAtPtx756 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register58);							 // PTX L756
	r_LaneIndexAtPtx758 = uint32_t((threadIdx.x & 31u));										 // PTX L758
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx758)) * int64_t(int32_t(16))); // PTX L760
	g_ResidualByteAddressAtPtx761 =
		uint64_t(g_ResidualByteAddressAtPtx756) + uint64_t(r_PtxU64Register60); // PTX L761
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx761));
		r_PtxRegister1372 = r_Value.x;
		r_PtxRegister1373 = r_Value.y;
		r_PtxRegister1374 = r_Value.z;
		r_PtxRegister1375 = r_Value.w;
	} // PTX L763
	goto L__BB13_82;																		   // PTX L765
L__BB13_80:																					   // PTX L766
	r_PtxRegister233 = uint32_t(0);															   // PTX L767
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister233))); // PTX L769
	r_PackedHalf2AtPtx772R234 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L772
	r_ConvertedE4PairAtPtx774Rs20 = PublishE4(r_PackedHalf2AtPtx772R234);					   // PTX L774
	r_PtxRegister1372 =
		JoinHalfwords(r_ConvertedE4PairAtPtx774Rs20, r_ConvertedE4PairAtPtx774Rs20); // PTX L776
	r_PtxRegister1373 = uint32_t(r_PtxRegister1372);								 // PTX L777
	r_PtxRegister1374 = uint32_t(r_PtxRegister1372);								 // PTX L778
	r_PtxRegister1375 = uint32_t(r_PtxRegister1372);								 // PTX L779
L__BB13_82:																			 // PTX L780
	r_bPtxPredicate52 = int32_t(r_PtxRegister4) < int32_t(r_WidthDiv4Bits);			 // PTX L781
	r_PtxU16Register59 = uint16_t(r_PtxRegister1375);
	r_PtxU16Register60 = uint16_t(r_PtxRegister1375 >> 16); // PTX L782
	r_PtxU16Register57 = uint16_t(r_PtxRegister1374);
	r_PtxU16Register58 = uint16_t(r_PtxRegister1374 >> 16); // PTX L783
	r_PtxU16Register55 = uint16_t(r_PtxRegister1373);
	r_PtxU16Register56 = uint16_t(r_PtxRegister1373 >> 16); // PTX L784
	r_PtxU16Register53 = uint16_t(r_PtxRegister1372);
	r_PtxU16Register54 = uint16_t(r_PtxRegister1372 >> 16);						// PTX L785
	r_bPtxPredicate53 = uint32_t(r_PtxRegister23) == uint32_t(4);				// PTX L786
	r_bPtxPredicate54 = uint32_t(r_PtxRegister15) == uint32_t(4);				// PTX L787
	r_PtxRegister240 = uint32_t(r_PtxRegister3) + uint32_t(1);					// PTX L788
	r_bPtxPredicate55 = int32_t(r_PtxRegister240) < int32_t(r_HeightDiv4Bits);	// PTX L789
	r_bPtxPredicate56 = int32_t(r_PtxRegister240) >= int32_t(r_HeightDiv4Bits); // PTX L790
	r_PtxRegister241 = uint32_t(r_PtxRegister24) + uint32_t(r_WidthDiv4Bits);	// PTX L791
	r_PtxRegister29 = r_bPtxPredicate54 ? 0 : r_PtxRegister241;					// PTX L792
	r_bPtxPredicate57 = r_bPtxPredicate3 & r_bPtxPredicate56;					// PTX L793
	r_bPtxPredicate9 = r_bPtxPredicate54 | r_bPtxPredicate55;					// PTX L794
	r_bPtxPredicate10 = r_bPtxPredicate57 | r_bPtxPredicate53;					// PTX L795
	r_bPtxPredicate58 = !r_bPtxPredicate57;										// PTX L796
	r_bPtxPredicate11 = r_bPtxPredicate53 & r_bPtxPredicate58;					// PTX L797
	r_PtxRegister30 = r_bPtxPredicate11 ? 0 : r_PtxRegister4;					// PTX L798
	r_bPtxPredicate59 = r_bPtxPredicate10 | r_bPtxPredicate52;					// PTX L799
	r_bPtxPredicate12 = r_bPtxPredicate59 & r_bPtxPredicate9;					// PTX L800
	if (r_bPtxPredicate12)
	{
		goto L__BB13_84;
	} // PTX L801
	goto L__BB13_83;																		 // PTX L802
L__BB13_84:																					 // PTX L803
	r_PtxRegister245 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister30);				 // PTX L804
	r_PtxRegister246 = ShiftLeft(uint32_t(r_PtxRegister245), uint32_t(11));					 // PTX L805
	r_PtxRegister247 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					 // PTX L806
	r_PtxRegister248 = uint32_t(r_PtxRegister246) + uint32_t(r_PtxRegister247);				 // PTX L807
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister248)) * int64_t(int32_t(4))); // PTX L808
	g_ResidualByteAddressAtPtx809 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register62);							 // PTX L809
	r_LaneIndexAtPtx811 = uint32_t((threadIdx.x & 31u));										 // PTX L811
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx811)) * int64_t(int32_t(16))); // PTX L813
	g_ResidualByteAddressAtPtx814 =
		uint64_t(g_ResidualByteAddressAtPtx809) + uint64_t(r_PtxU64Register64); // PTX L814
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx814));
		r_PtxRegister1376 = r_Value.x;
		r_PtxRegister1377 = r_Value.y;
		r_PtxRegister1378 = r_Value.z;
		r_PtxRegister1379 = r_Value.w;
	} // PTX L816
	goto L__BB13_85;																		   // PTX L818
L__BB13_83:																					   // PTX L819
	r_PtxRegister242 = uint32_t(0);															   // PTX L820
	r_PtxU16Register21 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister242))); // PTX L822
	r_PackedHalf2AtPtx825R243 = JoinHalfwords(r_PtxU16Register21, r_PtxU16Register21);		   // PTX L825
	r_ConvertedE4PairAtPtx827Rs22 = PublishE4(r_PackedHalf2AtPtx825R243);					   // PTX L827
	r_PtxRegister1376 =
		JoinHalfwords(r_ConvertedE4PairAtPtx827Rs22, r_ConvertedE4PairAtPtx827Rs22); // PTX L829
	r_PtxRegister1377 = uint32_t(r_PtxRegister1376);								 // PTX L830
	r_PtxRegister1378 = uint32_t(r_PtxRegister1376);								 // PTX L831
	r_PtxRegister1379 = uint32_t(r_PtxRegister1376);								 // PTX L832
L__BB13_85:																			 // PTX L833
	r_PtxU16Register61 = uint16_t(r_PtxRegister1376);
	r_PtxU16Register62 = uint16_t(r_PtxRegister1376 >> 16); // PTX L834
	r_PtxU16Register67 = uint16_t(r_PtxRegister1379);
	r_PtxU16Register68 = uint16_t(r_PtxRegister1379 >> 16); // PTX L835
	r_PtxU16Register65 = uint16_t(r_PtxRegister1378);
	r_PtxU16Register66 = uint16_t(r_PtxRegister1378 >> 16); // PTX L836
	r_PtxU16Register63 = uint16_t(r_PtxRegister1377);
	r_PtxU16Register64 = uint16_t(r_PtxRegister1377 >> 16); // PTX L837
	if (r_bPtxPredicate12)
	{
		goto L__BB13_87;
	} // PTX L838
	goto L__BB13_86;																		 // PTX L839
L__BB13_87:																					 // PTX L840
	r_PtxRegister252 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister30);				 // PTX L841
	r_PtxRegister253 = ShiftLeft(uint32_t(r_PtxRegister252), uint32_t(11));					 // PTX L842
	r_PtxRegister254 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));					 // PTX L843
	r_PtxRegister255 = uint32_t(r_PtxRegister253) + uint32_t(r_PtxRegister254);				 // PTX L844
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister255)) * int64_t(int32_t(4))); // PTX L845
	g_ResidualByteAddressAtPtx846 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register66);							 // PTX L846
	r_LaneIndexAtPtx848 = uint32_t((threadIdx.x & 31u));										 // PTX L848
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx848)) * int64_t(int32_t(16))); // PTX L850
	g_ResidualByteAddressAtPtx851 =
		uint64_t(g_ResidualByteAddressAtPtx846) + uint64_t(r_PtxU64Register68); // PTX L851
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx851));
		r_PtxRegister1380 = r_Value.x;
		r_PtxRegister1381 = r_Value.y;
		r_PtxRegister1382 = r_Value.z;
		r_PtxRegister1383 = r_Value.w;
	} // PTX L853
	goto L__BB13_88;																		   // PTX L855
L__BB13_86:																					   // PTX L856
	r_PtxRegister249 = uint32_t(0);															   // PTX L857
	r_PtxU16Register23 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister249))); // PTX L859
	r_PackedHalf2AtPtx862R250 = JoinHalfwords(r_PtxU16Register23, r_PtxU16Register23);		   // PTX L862
	r_ConvertedE4PairAtPtx864Rs24 = PublishE4(r_PackedHalf2AtPtx862R250);					   // PTX L864
	r_PtxRegister1380 =
		JoinHalfwords(r_ConvertedE4PairAtPtx864Rs24, r_ConvertedE4PairAtPtx864Rs24); // PTX L866
	r_PtxRegister1381 = uint32_t(r_PtxRegister1380);								 // PTX L867
	r_PtxRegister1382 = uint32_t(r_PtxRegister1380);								 // PTX L868
	r_PtxRegister1383 = uint32_t(r_PtxRegister1380);								 // PTX L869
L__BB13_88:																			 // PTX L870
	r_bPtxPredicate60 = int32_t(r_PtxRegister27) < int32_t(r_WidthDiv4Bits);		 // PTX L871
	r_PtxU16Register75 = uint16_t(r_PtxRegister1383);
	r_PtxU16Register76 = uint16_t(r_PtxRegister1383 >> 16); // PTX L872
	r_PtxU16Register73 = uint16_t(r_PtxRegister1382);
	r_PtxU16Register74 = uint16_t(r_PtxRegister1382 >> 16); // PTX L873
	r_PtxU16Register71 = uint16_t(r_PtxRegister1381);
	r_PtxU16Register72 = uint16_t(r_PtxRegister1381 >> 16); // PTX L874
	r_PtxU16Register69 = uint16_t(r_PtxRegister1380);
	r_PtxU16Register70 = uint16_t(r_PtxRegister1380 >> 16);	   // PTX L875
	r_PtxRegister31 = r_bPtxPredicate11 ? 0 : r_PtxRegister27; // PTX L876
	r_bPtxPredicate61 = r_bPtxPredicate10 | r_bPtxPredicate60; // PTX L877
	r_bPtxPredicate13 = r_bPtxPredicate61 & r_bPtxPredicate9;  // PTX L878
	if (r_bPtxPredicate13)
	{
		goto L__BB13_90;
	} // PTX L879
	goto L__BB13_89;																		 // PTX L880
L__BB13_90:																					 // PTX L881
	r_PtxRegister259 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister31);				 // PTX L882
	r_PtxRegister260 = ShiftLeft(uint32_t(r_PtxRegister259), uint32_t(11));					 // PTX L883
	r_PtxRegister261 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					 // PTX L884
	r_PtxRegister262 = uint32_t(r_PtxRegister260) + uint32_t(r_PtxRegister261);				 // PTX L885
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister262)) * int64_t(int32_t(4))); // PTX L886
	g_ResidualByteAddressAtPtx887 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register70);							 // PTX L887
	r_LaneIndexAtPtx889 = uint32_t((threadIdx.x & 31u));										 // PTX L889
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx889)) * int64_t(int32_t(16))); // PTX L891
	g_ResidualByteAddressAtPtx892 =
		uint64_t(g_ResidualByteAddressAtPtx887) + uint64_t(r_PtxU64Register72); // PTX L892
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx892));
		r_PtxRegister1384 = r_Value.x;
		r_PtxRegister1385 = r_Value.y;
		r_PtxRegister1386 = r_Value.z;
		r_PtxRegister1387 = r_Value.w;
	} // PTX L894
	goto L__BB13_91;																		   // PTX L896
L__BB13_89:																					   // PTX L897
	r_PtxRegister256 = uint32_t(0);															   // PTX L898
	r_PtxU16Register25 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister256))); // PTX L900
	r_PackedHalf2AtPtx903R257 = JoinHalfwords(r_PtxU16Register25, r_PtxU16Register25);		   // PTX L903
	r_ConvertedE4PairAtPtx905Rs26 = PublishE4(r_PackedHalf2AtPtx903R257);					   // PTX L905
	r_PtxRegister1384 =
		JoinHalfwords(r_ConvertedE4PairAtPtx905Rs26, r_ConvertedE4PairAtPtx905Rs26); // PTX L907
	r_PtxRegister1385 = uint32_t(r_PtxRegister1384);								 // PTX L908
	r_PtxRegister1386 = uint32_t(r_PtxRegister1384);								 // PTX L909
	r_PtxRegister1387 = uint32_t(r_PtxRegister1384);								 // PTX L910
L__BB13_91:																			 // PTX L911
	r_PtxU16Register77 = uint16_t(r_PtxRegister1384);
	r_PtxU16Register78 = uint16_t(r_PtxRegister1384 >> 16); // PTX L912
	r_PtxU16Register83 = uint16_t(r_PtxRegister1387);
	r_PtxU16Register84 = uint16_t(r_PtxRegister1387 >> 16); // PTX L913
	r_PtxU16Register81 = uint16_t(r_PtxRegister1386);
	r_PtxU16Register82 = uint16_t(r_PtxRegister1386 >> 16); // PTX L914
	r_PtxU16Register79 = uint16_t(r_PtxRegister1385);
	r_PtxU16Register80 = uint16_t(r_PtxRegister1385 >> 16); // PTX L915
	if (r_bPtxPredicate13)
	{
		goto L__BB13_93;
	} // PTX L916
	goto L__BB13_92;																		 // PTX L917
L__BB13_93:																					 // PTX L918
	r_PtxRegister266 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister31);				 // PTX L919
	r_PtxRegister267 = ShiftLeft(uint32_t(r_PtxRegister266), uint32_t(11));					 // PTX L920
	r_PtxRegister268 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));					 // PTX L921
	r_PtxRegister269 = uint32_t(r_PtxRegister267) + uint32_t(r_PtxRegister268);				 // PTX L922
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister269)) * int64_t(int32_t(4))); // PTX L923
	g_ResidualByteAddressAtPtx924 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register74);							 // PTX L924
	r_LaneIndexAtPtx926 = uint32_t((threadIdx.x & 31u));										 // PTX L926
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx926)) * int64_t(int32_t(16))); // PTX L928
	g_ResidualByteAddressAtPtx929 =
		uint64_t(g_ResidualByteAddressAtPtx924) + uint64_t(r_PtxU64Register76); // PTX L929
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx929));
		r_PtxRegister1388 = r_Value.x;
		r_PtxRegister1389 = r_Value.y;
		r_PtxRegister1390 = r_Value.z;
		r_PtxRegister1391 = r_Value.w;
	} // PTX L931
	goto L__BB13_94;																		   // PTX L933
L__BB13_92:																					   // PTX L934
	r_PtxRegister263 = uint32_t(0);															   // PTX L935
	r_PtxU16Register27 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister263))); // PTX L937
	r_PackedHalf2AtPtx940R264 = JoinHalfwords(r_PtxU16Register27, r_PtxU16Register27);		   // PTX L940
	r_ConvertedE4PairAtPtx942Rs28 = PublishE4(r_PackedHalf2AtPtx940R264);					   // PTX L942
	r_PtxRegister1388 =
		JoinHalfwords(r_ConvertedE4PairAtPtx942Rs28, r_ConvertedE4PairAtPtx942Rs28); // PTX L944
	r_PtxRegister1389 = uint32_t(r_PtxRegister1388);								 // PTX L945
	r_PtxRegister1390 = uint32_t(r_PtxRegister1388);								 // PTX L946
	r_PtxRegister1391 = uint32_t(r_PtxRegister1388);								 // PTX L947
L__BB13_94:																			 // PTX L948
	r_PackedHalf2AtPtx950R335 = DecodeE4(r_PtxU16Register29);						 // PTX L950
	r_PackedHalf2AtPtx953R341 = DecodeE4(r_PtxU16Register30);						 // PTX L953
	r_PackedHalf2AtPtx956R338 = DecodeE4(r_PtxU16Register31);						 // PTX L956
	r_PackedHalf2AtPtx959R344 = DecodeE4(r_PtxU16Register32);						 // PTX L959
	r_PackedHalf2AtPtx962R347 = DecodeE4(r_PtxU16Register33);						 // PTX L962
	r_PackedHalf2AtPtx965R353 = DecodeE4(r_PtxU16Register34);						 // PTX L965
	r_PackedHalf2AtPtx968R350 = DecodeE4(r_PtxU16Register35);						 // PTX L968
	r_PackedHalf2AtPtx971R356 = DecodeE4(r_PtxU16Register36);						 // PTX L971
	r_PackedHalf2AtPtx974R359 = DecodeE4(r_PtxU16Register37);						 // PTX L974
	r_PackedHalf2AtPtx977R365 = DecodeE4(r_PtxU16Register38);						 // PTX L977
	r_PackedHalf2AtPtx980R362 = DecodeE4(r_PtxU16Register39);						 // PTX L980
	r_PackedHalf2AtPtx983R368 = DecodeE4(r_PtxU16Register40);						 // PTX L983
	r_PackedHalf2AtPtx986R371 = DecodeE4(r_PtxU16Register41);						 // PTX L986
	r_PackedHalf2AtPtx989R377 = DecodeE4(r_PtxU16Register42);						 // PTX L989
	r_PackedHalf2AtPtx992R374 = DecodeE4(r_PtxU16Register43);						 // PTX L992
	r_PackedHalf2AtPtx995R380 = DecodeE4(r_PtxU16Register44);						 // PTX L995
	r_PackedHalf2AtPtx998R383 = DecodeE4(r_PtxU16Register45);						 // PTX L998
	r_PackedHalf2AtPtx1001R389 = DecodeE4(r_PtxU16Register46);						 // PTX L1001
	r_PackedHalf2AtPtx1004R386 = DecodeE4(r_PtxU16Register47);						 // PTX L1004
	r_PackedHalf2AtPtx1007R392 = DecodeE4(r_PtxU16Register48);						 // PTX L1007
	r_PackedHalf2AtPtx1010R395 = DecodeE4(r_PtxU16Register49);						 // PTX L1010
	r_PackedHalf2AtPtx1013R401 = DecodeE4(r_PtxU16Register50);						 // PTX L1013
	r_PackedHalf2AtPtx1016R398 = DecodeE4(r_PtxU16Register51);						 // PTX L1016
	r_PackedHalf2AtPtx1019R404 = DecodeE4(r_PtxU16Register52);						 // PTX L1019
	r_PackedHalf2AtPtx1022R407 = DecodeE4(r_PtxU16Register53);						 // PTX L1022
	r_PackedHalf2AtPtx1025R413 = DecodeE4(r_PtxU16Register54);						 // PTX L1025
	r_PackedHalf2AtPtx1028R410 = DecodeE4(r_PtxU16Register55);						 // PTX L1028
	r_PackedHalf2AtPtx1031R416 = DecodeE4(r_PtxU16Register56);						 // PTX L1031
	r_PackedHalf2AtPtx1034R419 = DecodeE4(r_PtxU16Register57);						 // PTX L1034
	r_PackedHalf2AtPtx1037R425 = DecodeE4(r_PtxU16Register58);						 // PTX L1037
	r_PackedHalf2AtPtx1040R422 = DecodeE4(r_PtxU16Register59);						 // PTX L1040
	r_PackedHalf2AtPtx1043R428 = DecodeE4(r_PtxU16Register60);						 // PTX L1043
	r_PackedHalf2AtPtx1046R431 = DecodeE4(r_PtxU16Register61);						 // PTX L1046
	r_PackedHalf2AtPtx1049R437 = DecodeE4(r_PtxU16Register62);						 // PTX L1049
	r_PackedHalf2AtPtx1052R434 = DecodeE4(r_PtxU16Register63);						 // PTX L1052
	r_PackedHalf2AtPtx1055R440 = DecodeE4(r_PtxU16Register64);						 // PTX L1055
	r_PackedHalf2AtPtx1058R443 = DecodeE4(r_PtxU16Register65);						 // PTX L1058
	r_PackedHalf2AtPtx1061R449 = DecodeE4(r_PtxU16Register66);						 // PTX L1061
	r_PackedHalf2AtPtx1064R446 = DecodeE4(r_PtxU16Register67);						 // PTX L1064
	r_PackedHalf2AtPtx1067R452 = DecodeE4(r_PtxU16Register68);						 // PTX L1067
	r_PackedHalf2AtPtx1070R455 = DecodeE4(r_PtxU16Register69);						 // PTX L1070
	r_PackedHalf2AtPtx1073R461 = DecodeE4(r_PtxU16Register70);						 // PTX L1073
	r_PackedHalf2AtPtx1076R458 = DecodeE4(r_PtxU16Register71);						 // PTX L1076
	r_PackedHalf2AtPtx1079R464 = DecodeE4(r_PtxU16Register72);						 // PTX L1079
	r_PackedHalf2AtPtx1082R467 = DecodeE4(r_PtxU16Register73);						 // PTX L1082
	r_PackedHalf2AtPtx1085R473 = DecodeE4(r_PtxU16Register74);						 // PTX L1085
	r_PackedHalf2AtPtx1088R470 = DecodeE4(r_PtxU16Register75);						 // PTX L1088
	r_PackedHalf2AtPtx1091R476 = DecodeE4(r_PtxU16Register76);						 // PTX L1091
	r_PackedHalf2AtPtx1094R479 = DecodeE4(r_PtxU16Register77);						 // PTX L1094
	r_PackedHalf2AtPtx1097R485 = DecodeE4(r_PtxU16Register78);						 // PTX L1097
	r_PackedHalf2AtPtx1100R482 = DecodeE4(r_PtxU16Register79);						 // PTX L1100
	r_PackedHalf2AtPtx1103R488 = DecodeE4(r_PtxU16Register80);						 // PTX L1103
	r_PackedHalf2AtPtx1106R491 = DecodeE4(r_PtxU16Register81);						 // PTX L1106
	r_PackedHalf2AtPtx1109R497 = DecodeE4(r_PtxU16Register82);						 // PTX L1109
	r_PackedHalf2AtPtx1112R494 = DecodeE4(r_PtxU16Register83);						 // PTX L1112
	r_PackedHalf2AtPtx1115R500 = DecodeE4(r_PtxU16Register84);						 // PTX L1115
	r_PtxU16Register85 = uint16_t(r_PtxRegister1388);
	r_PtxU16Register86 = uint16_t(r_PtxRegister1388 >> 16);	   // PTX L1117
	r_PackedHalf2AtPtx1119R503 = DecodeE4(r_PtxU16Register85); // PTX L1119
	r_PackedHalf2AtPtx1122R509 = DecodeE4(r_PtxU16Register86); // PTX L1122
	r_PtxU16Register87 = uint16_t(r_PtxRegister1389);
	r_PtxU16Register88 = uint16_t(r_PtxRegister1389 >> 16);	   // PTX L1124
	r_PackedHalf2AtPtx1126R506 = DecodeE4(r_PtxU16Register87); // PTX L1126
	r_PackedHalf2AtPtx1129R512 = DecodeE4(r_PtxU16Register88); // PTX L1129
	r_PtxU16Register89 = uint16_t(r_PtxRegister1390);
	r_PtxU16Register90 = uint16_t(r_PtxRegister1390 >> 16);	   // PTX L1131
	r_PackedHalf2AtPtx1133R515 = DecodeE4(r_PtxU16Register89); // PTX L1133
	r_PackedHalf2AtPtx1136R521 = DecodeE4(r_PtxU16Register90); // PTX L1136
	r_PtxU16Register91 = uint16_t(r_PtxRegister1391);
	r_PtxU16Register92 = uint16_t(r_PtxRegister1391 >> 16);									 // PTX L1138
	r_PackedHalf2AtPtx1140R518 = DecodeE4(r_PtxU16Register91);								 // PTX L1140
	r_PackedHalf2AtPtx1143R524 = DecodeE4(r_PtxU16Register92);								 // PTX L1143
	g_RecordByteAddressAtPtx1145 = g_RecordBaseAddress;										 // PTX L1145
	r_PtxRegister526 = uint32_t(r_PtxRegister8) + uint32_t(16);								 // PTX L1146
	r_PtxRegister527 = uint32_t(r_PtxRegister8) + uint32_t(8);								 // PTX L1147
	r_LaneIndexAtPtx1149 = uint32_t((threadIdx.x & 31u));									 // PTX L1149
	r_PtxRegister528 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1149), uint32_t(31));		 // PTX L1151
	r_PtxRegister529 = ShiftRight(uint32_t(r_PtxRegister528), uint32_t(30));				 // PTX L1152
	r_PtxRegister530 = uint32_t(r_LaneIndexAtPtx1149) + uint32_t(r_PtxRegister529);			 // PTX L1153
	r_PtxRegister531 = r_PtxRegister530 & 2147483644;										 // PTX L1154
	r_PtxRegister532 = uint32_t(r_LaneIndexAtPtx1149) - uint32_t(r_PtxRegister531);			 // PTX L1155
	r_PtxRegister533 = ShiftLeft(uint32_t(r_PtxRegister532), uint32_t(1));					 // PTX L1156
	r_PtxRegister534 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister533);				 // PTX L1157
	r_PtxRegister535 = ShiftRightSigned(int32_t(r_PtxRegister534), uint32_t(1));			 // PTX L1158
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister535)) * int64_t(int32_t(4))); // PTX L1159
	g_RecordByteAddressAtPtx1160 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register78); // PTX L1160
	r_PtxRegister336 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1160 + 262144ull);		 // PTX L1161
	r_LaneIndexAtPtx1163 = uint32_t((threadIdx.x & 31u));									 // PTX L1163
	r_PtxRegister536 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1163), uint32_t(31));		 // PTX L1165
	r_PtxRegister537 = ShiftRight(uint32_t(r_PtxRegister536), uint32_t(30));				 // PTX L1166
	r_PtxRegister538 = uint32_t(r_LaneIndexAtPtx1163) + uint32_t(r_PtxRegister537);			 // PTX L1167
	r_PtxRegister539 = r_PtxRegister538 & 2147483644;										 // PTX L1168
	r_PtxRegister540 = uint32_t(r_LaneIndexAtPtx1163) - uint32_t(r_PtxRegister539);			 // PTX L1169
	r_PtxRegister541 = ShiftLeft(uint32_t(r_PtxRegister540), uint32_t(1));					 // PTX L1170
	r_PtxRegister542 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister541);				 // PTX L1171
	r_PtxRegister543 = ShiftRightSigned(int32_t(r_PtxRegister542), uint32_t(1));			 // PTX L1172
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_PtxRegister543)) * int64_t(int32_t(4))); // PTX L1173
	g_RecordByteAddressAtPtx1174 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register80); // PTX L1174
	r_PtxRegister339 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1174 + 262144ull);		 // PTX L1175
	r_LaneIndexAtPtx1177 = uint32_t((threadIdx.x & 31u));									 // PTX L1177
	r_PtxRegister544 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1177), uint32_t(31));		 // PTX L1179
	r_PtxRegister545 = ShiftRight(uint32_t(r_PtxRegister544), uint32_t(30));				 // PTX L1180
	r_PtxRegister546 = uint32_t(r_LaneIndexAtPtx1177) + uint32_t(r_PtxRegister545);			 // PTX L1181
	r_PtxRegister547 = r_PtxRegister546 & 2147483644;										 // PTX L1182
	r_PtxRegister548 = uint32_t(r_LaneIndexAtPtx1177) - uint32_t(r_PtxRegister547);			 // PTX L1183
	r_PtxRegister549 = ShiftLeft(uint32_t(r_PtxRegister548), uint32_t(1));					 // PTX L1184
	r_PtxRegister550 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister549);				 // PTX L1185
	r_PtxRegister551 = ShiftRightSigned(int32_t(r_PtxRegister550), uint32_t(1));			 // PTX L1186
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister551)) * int64_t(int32_t(4))); // PTX L1187
	g_RecordByteAddressAtPtx1188 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register82); // PTX L1188
	r_PtxRegister342 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1188 + 262144ull);		 // PTX L1189
	r_LaneIndexAtPtx1191 = uint32_t((threadIdx.x & 31u));									 // PTX L1191
	r_PtxRegister552 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1191), uint32_t(31));		 // PTX L1193
	r_PtxRegister553 = ShiftRight(uint32_t(r_PtxRegister552), uint32_t(30));				 // PTX L1194
	r_PtxRegister554 = uint32_t(r_LaneIndexAtPtx1191) + uint32_t(r_PtxRegister553);			 // PTX L1195
	r_PtxRegister555 = r_PtxRegister554 & 2147483644;										 // PTX L1196
	r_PtxRegister556 = uint32_t(r_LaneIndexAtPtx1191) - uint32_t(r_PtxRegister555);			 // PTX L1197
	r_PtxRegister557 = ShiftLeft(uint32_t(r_PtxRegister556), uint32_t(1));					 // PTX L1198
	r_PtxRegister558 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister557);				 // PTX L1199
	r_PtxRegister559 = ShiftRightSigned(int32_t(r_PtxRegister558), uint32_t(1));			 // PTX L1200
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister559)) * int64_t(int32_t(4))); // PTX L1201
	g_RecordByteAddressAtPtx1202 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register84); // PTX L1202
	r_PtxRegister345 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1202 + 262144ull);		 // PTX L1203
	r_LaneIndexAtPtx1205 = uint32_t((threadIdx.x & 31u));									 // PTX L1205
	r_PtxRegister560 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1205), uint32_t(31));		 // PTX L1207
	r_PtxRegister561 = ShiftRight(uint32_t(r_PtxRegister560), uint32_t(30));				 // PTX L1208
	r_PtxRegister562 = uint32_t(r_LaneIndexAtPtx1205) + uint32_t(r_PtxRegister561);			 // PTX L1209
	r_PtxRegister563 = r_PtxRegister562 & 2147483644;										 // PTX L1210
	r_PtxRegister564 = uint32_t(r_LaneIndexAtPtx1205) - uint32_t(r_PtxRegister563);			 // PTX L1211
	r_PtxRegister565 = ShiftLeft(uint32_t(r_PtxRegister564), uint32_t(1));					 // PTX L1212
	r_PtxRegister566 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister565);				 // PTX L1213
	r_PtxRegister567 = ShiftRightSigned(int32_t(r_PtxRegister566), uint32_t(1));			 // PTX L1214
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_PtxRegister567)) * int64_t(int32_t(4))); // PTX L1215
	g_RecordByteAddressAtPtx1216 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register86); // PTX L1216
	r_PtxRegister348 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1216 + 262144ull);		 // PTX L1217
	r_LaneIndexAtPtx1219 = uint32_t((threadIdx.x & 31u));									 // PTX L1219
	r_PtxRegister568 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1219), uint32_t(31));		 // PTX L1221
	r_PtxRegister569 = ShiftRight(uint32_t(r_PtxRegister568), uint32_t(30));				 // PTX L1222
	r_PtxRegister570 = uint32_t(r_LaneIndexAtPtx1219) + uint32_t(r_PtxRegister569);			 // PTX L1223
	r_PtxRegister571 = r_PtxRegister570 & 2147483644;										 // PTX L1224
	r_PtxRegister572 = uint32_t(r_LaneIndexAtPtx1219) - uint32_t(r_PtxRegister571);			 // PTX L1225
	r_PtxRegister573 = ShiftLeft(uint32_t(r_PtxRegister572), uint32_t(1));					 // PTX L1226
	r_PtxRegister574 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister573);				 // PTX L1227
	r_PtxRegister575 = ShiftRightSigned(int32_t(r_PtxRegister574), uint32_t(1));			 // PTX L1228
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_PtxRegister575)) * int64_t(int32_t(4))); // PTX L1229
	g_RecordByteAddressAtPtx1230 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register88); // PTX L1230
	r_PtxRegister351 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1230 + 262144ull);		 // PTX L1231
	r_LaneIndexAtPtx1233 = uint32_t((threadIdx.x & 31u));									 // PTX L1233
	r_PtxRegister576 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1233), uint32_t(31));		 // PTX L1235
	r_PtxRegister577 = ShiftRight(uint32_t(r_PtxRegister576), uint32_t(30));				 // PTX L1236
	r_PtxRegister578 = uint32_t(r_LaneIndexAtPtx1233) + uint32_t(r_PtxRegister577);			 // PTX L1237
	r_PtxRegister579 = r_PtxRegister578 & 2147483644;										 // PTX L1238
	r_PtxRegister580 = uint32_t(r_LaneIndexAtPtx1233) - uint32_t(r_PtxRegister579);			 // PTX L1239
	r_PtxRegister581 = ShiftLeft(uint32_t(r_PtxRegister580), uint32_t(1));					 // PTX L1240
	r_PtxRegister582 = uint32_t(r_PtxRegister8) + uint32_t(24);								 // PTX L1241
	r_PtxRegister583 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister581);				 // PTX L1242
	r_PtxRegister584 = ShiftRight(uint32_t(r_PtxRegister583), uint32_t(31));				 // PTX L1243
	r_PtxRegister585 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister584);				 // PTX L1244
	r_PtxRegister586 = ShiftRightSigned(int32_t(r_PtxRegister585), uint32_t(1));			 // PTX L1245
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_PtxRegister586)) * int64_t(int32_t(4))); // PTX L1246
	g_RecordByteAddressAtPtx1247 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register90); // PTX L1247
	r_PtxRegister354 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1247 + 262144ull);		 // PTX L1248
	r_LaneIndexAtPtx1250 = uint32_t((threadIdx.x & 31u));									 // PTX L1250
	r_PtxRegister587 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1250), uint32_t(31));		 // PTX L1252
	r_PtxRegister588 = ShiftRight(uint32_t(r_PtxRegister587), uint32_t(30));				 // PTX L1253
	r_PtxRegister589 = uint32_t(r_LaneIndexAtPtx1250) + uint32_t(r_PtxRegister588);			 // PTX L1254
	r_PtxRegister590 = r_PtxRegister589 & 2147483644;										 // PTX L1255
	r_PtxRegister591 = uint32_t(r_LaneIndexAtPtx1250) - uint32_t(r_PtxRegister590);			 // PTX L1256
	r_PtxRegister592 = ShiftLeft(uint32_t(r_PtxRegister591), uint32_t(1));					 // PTX L1257
	r_PtxRegister593 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister592);				 // PTX L1258
	r_PtxRegister594 = ShiftRight(uint32_t(r_PtxRegister593), uint32_t(31));				 // PTX L1259
	r_PtxRegister595 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister594);				 // PTX L1260
	r_PtxRegister596 = ShiftRightSigned(int32_t(r_PtxRegister595), uint32_t(1));			 // PTX L1261
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_PtxRegister596)) * int64_t(int32_t(4))); // PTX L1262
	g_RecordByteAddressAtPtx1263 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register92); // PTX L1263
	r_PtxRegister357 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1263 + 262144ull);		 // PTX L1264
	r_LaneIndexAtPtx1266 = uint32_t((threadIdx.x & 31u));									 // PTX L1266
	r_PtxRegister597 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1266), uint32_t(31));		 // PTX L1268
	r_PtxRegister598 = ShiftRight(uint32_t(r_PtxRegister597), uint32_t(30));				 // PTX L1269
	r_PtxRegister599 = uint32_t(r_LaneIndexAtPtx1266) + uint32_t(r_PtxRegister598);			 // PTX L1270
	r_PtxRegister600 = r_PtxRegister599 & 2147483644;										 // PTX L1271
	r_PtxRegister601 = uint32_t(r_LaneIndexAtPtx1266) - uint32_t(r_PtxRegister600);			 // PTX L1272
	r_PtxRegister602 = ShiftLeft(uint32_t(r_PtxRegister601), uint32_t(1));					 // PTX L1273
	r_PtxRegister603 = uint32_t(r_PtxRegister8) + uint32_t(32);								 // PTX L1274
	r_PtxRegister604 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister602);				 // PTX L1275
	r_PtxRegister605 = ShiftRightSigned(int32_t(r_PtxRegister604), uint32_t(1));			 // PTX L1276
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_PtxRegister605)) * int64_t(int32_t(4))); // PTX L1277
	g_RecordByteAddressAtPtx1278 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register94); // PTX L1278
	r_PtxRegister360 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1278 + 262144ull);		 // PTX L1279
	r_LaneIndexAtPtx1281 = uint32_t((threadIdx.x & 31u));									 // PTX L1281
	r_PtxRegister606 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1281), uint32_t(31));		 // PTX L1283
	r_PtxRegister607 = ShiftRight(uint32_t(r_PtxRegister606), uint32_t(30));				 // PTX L1284
	r_PtxRegister608 = uint32_t(r_LaneIndexAtPtx1281) + uint32_t(r_PtxRegister607);			 // PTX L1285
	r_PtxRegister609 = r_PtxRegister608 & 2147483644;										 // PTX L1286
	r_PtxRegister610 = uint32_t(r_LaneIndexAtPtx1281) - uint32_t(r_PtxRegister609);			 // PTX L1287
	r_PtxRegister611 = ShiftLeft(uint32_t(r_PtxRegister610), uint32_t(1));					 // PTX L1288
	r_PtxRegister612 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister611);				 // PTX L1289
	r_PtxRegister613 = ShiftRightSigned(int32_t(r_PtxRegister612), uint32_t(1));			 // PTX L1290
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_PtxRegister613)) * int64_t(int32_t(4))); // PTX L1291
	g_RecordByteAddressAtPtx1292 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register96); // PTX L1292
	r_PtxRegister363 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1292 + 262144ull);		 // PTX L1293
	r_LaneIndexAtPtx1295 = uint32_t((threadIdx.x & 31u));									 // PTX L1295
	r_PtxRegister614 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1295), uint32_t(31));		 // PTX L1297
	r_PtxRegister615 = ShiftRight(uint32_t(r_PtxRegister614), uint32_t(30));				 // PTX L1298
	r_PtxRegister616 = uint32_t(r_LaneIndexAtPtx1295) + uint32_t(r_PtxRegister615);			 // PTX L1299
	r_PtxRegister617 = r_PtxRegister616 & 2147483644;										 // PTX L1300
	r_PtxRegister618 = uint32_t(r_LaneIndexAtPtx1295) - uint32_t(r_PtxRegister617);			 // PTX L1301
	r_PtxRegister619 = ShiftLeft(uint32_t(r_PtxRegister618), uint32_t(1));					 // PTX L1302
	r_PtxRegister620 = uint32_t(r_PtxRegister8) + uint32_t(40);								 // PTX L1303
	r_PtxRegister621 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister619);				 // PTX L1304
	r_PtxRegister622 = ShiftRight(uint32_t(r_PtxRegister621), uint32_t(31));				 // PTX L1305
	r_PtxRegister623 = uint32_t(r_PtxRegister621) + uint32_t(r_PtxRegister622);				 // PTX L1306
	r_PtxRegister624 = ShiftRightSigned(int32_t(r_PtxRegister623), uint32_t(1));			 // PTX L1307
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_PtxRegister624)) * int64_t(int32_t(4))); // PTX L1308
	g_RecordByteAddressAtPtx1309 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register98); // PTX L1309
	r_PtxRegister366 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1309 + 262144ull);		  // PTX L1310
	r_LaneIndexAtPtx1312 = uint32_t((threadIdx.x & 31u));									  // PTX L1312
	r_PtxRegister625 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1312), uint32_t(31));		  // PTX L1314
	r_PtxRegister626 = ShiftRight(uint32_t(r_PtxRegister625), uint32_t(30));				  // PTX L1315
	r_PtxRegister627 = uint32_t(r_LaneIndexAtPtx1312) + uint32_t(r_PtxRegister626);			  // PTX L1316
	r_PtxRegister628 = r_PtxRegister627 & 2147483644;										  // PTX L1317
	r_PtxRegister629 = uint32_t(r_LaneIndexAtPtx1312) - uint32_t(r_PtxRegister628);			  // PTX L1318
	r_PtxRegister630 = ShiftLeft(uint32_t(r_PtxRegister629), uint32_t(1));					  // PTX L1319
	r_PtxRegister631 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister630);				  // PTX L1320
	r_PtxRegister632 = ShiftRight(uint32_t(r_PtxRegister631), uint32_t(31));				  // PTX L1321
	r_PtxRegister633 = uint32_t(r_PtxRegister631) + uint32_t(r_PtxRegister632);				  // PTX L1322
	r_PtxRegister634 = ShiftRightSigned(int32_t(r_PtxRegister633), uint32_t(1));			  // PTX L1323
	r_PtxU64Register100 = uint64_t(int64_t(int32_t(r_PtxRegister634)) * int64_t(int32_t(4))); // PTX L1324
	g_RecordByteAddressAtPtx1325 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register100); // PTX L1325
	r_PtxRegister369 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1325 + 262144ull);		  // PTX L1326
	r_LaneIndexAtPtx1328 = uint32_t((threadIdx.x & 31u));									  // PTX L1328
	r_PtxRegister635 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1328), uint32_t(31));		  // PTX L1330
	r_PtxRegister636 = ShiftRight(uint32_t(r_PtxRegister635), uint32_t(30));				  // PTX L1331
	r_PtxRegister637 = uint32_t(r_LaneIndexAtPtx1328) + uint32_t(r_PtxRegister636);			  // PTX L1332
	r_PtxRegister638 = r_PtxRegister637 & 2147483644;										  // PTX L1333
	r_PtxRegister639 = uint32_t(r_LaneIndexAtPtx1328) - uint32_t(r_PtxRegister638);			  // PTX L1334
	r_PtxRegister640 = ShiftLeft(uint32_t(r_PtxRegister639), uint32_t(1));					  // PTX L1335
	r_PtxRegister641 = uint32_t(r_PtxRegister8) + uint32_t(48);								  // PTX L1336
	r_PtxRegister642 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister640);				  // PTX L1337
	r_PtxRegister643 = ShiftRightSigned(int32_t(r_PtxRegister642), uint32_t(1));			  // PTX L1338
	r_PtxU64Register102 = uint64_t(int64_t(int32_t(r_PtxRegister643)) * int64_t(int32_t(4))); // PTX L1339
	g_RecordByteAddressAtPtx1340 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register102); // PTX L1340
	r_PtxRegister372 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1340 + 262144ull);		  // PTX L1341
	r_LaneIndexAtPtx1343 = uint32_t((threadIdx.x & 31u));									  // PTX L1343
	r_PtxRegister644 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1343), uint32_t(31));		  // PTX L1345
	r_PtxRegister645 = ShiftRight(uint32_t(r_PtxRegister644), uint32_t(30));				  // PTX L1346
	r_PtxRegister646 = uint32_t(r_LaneIndexAtPtx1343) + uint32_t(r_PtxRegister645);			  // PTX L1347
	r_PtxRegister647 = r_PtxRegister646 & 2147483644;										  // PTX L1348
	r_PtxRegister648 = uint32_t(r_LaneIndexAtPtx1343) - uint32_t(r_PtxRegister647);			  // PTX L1349
	r_PtxRegister649 = ShiftLeft(uint32_t(r_PtxRegister648), uint32_t(1));					  // PTX L1350
	r_PtxRegister650 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister649);				  // PTX L1351
	r_PtxRegister651 = ShiftRightSigned(int32_t(r_PtxRegister650), uint32_t(1));			  // PTX L1352
	r_PtxU64Register104 = uint64_t(int64_t(int32_t(r_PtxRegister651)) * int64_t(int32_t(4))); // PTX L1353
	g_RecordByteAddressAtPtx1354 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register104); // PTX L1354
	r_PtxRegister375 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1354 + 262144ull);		  // PTX L1355
	r_LaneIndexAtPtx1357 = uint32_t((threadIdx.x & 31u));									  // PTX L1357
	r_PtxRegister652 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1357), uint32_t(31));		  // PTX L1359
	r_PtxRegister653 = ShiftRight(uint32_t(r_PtxRegister652), uint32_t(30));				  // PTX L1360
	r_PtxRegister654 = uint32_t(r_LaneIndexAtPtx1357) + uint32_t(r_PtxRegister653);			  // PTX L1361
	r_PtxRegister655 = r_PtxRegister654 & 2147483644;										  // PTX L1362
	r_PtxRegister656 = uint32_t(r_LaneIndexAtPtx1357) - uint32_t(r_PtxRegister655);			  // PTX L1363
	r_PtxRegister657 = ShiftLeft(uint32_t(r_PtxRegister656), uint32_t(1));					  // PTX L1364
	r_PtxRegister658 = uint32_t(r_PtxRegister8) + uint32_t(56);								  // PTX L1365
	r_PtxRegister659 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister657);				  // PTX L1366
	r_PtxRegister660 = ShiftRight(uint32_t(r_PtxRegister659), uint32_t(31));				  // PTX L1367
	r_PtxRegister661 = uint32_t(r_PtxRegister659) + uint32_t(r_PtxRegister660);				  // PTX L1368
	r_PtxRegister662 = ShiftRightSigned(int32_t(r_PtxRegister661), uint32_t(1));			  // PTX L1369
	r_PtxU64Register106 = uint64_t(int64_t(int32_t(r_PtxRegister662)) * int64_t(int32_t(4))); // PTX L1370
	g_RecordByteAddressAtPtx1371 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register106); // PTX L1371
	r_PtxRegister378 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1371 + 262144ull);		  // PTX L1372
	r_LaneIndexAtPtx1374 = uint32_t((threadIdx.x & 31u));									  // PTX L1374
	r_PtxRegister663 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1374), uint32_t(31));		  // PTX L1376
	r_PtxRegister664 = ShiftRight(uint32_t(r_PtxRegister663), uint32_t(30));				  // PTX L1377
	r_PtxRegister665 = uint32_t(r_LaneIndexAtPtx1374) + uint32_t(r_PtxRegister664);			  // PTX L1378
	r_PtxRegister666 = r_PtxRegister665 & 2147483644;										  // PTX L1379
	r_PtxRegister667 = uint32_t(r_LaneIndexAtPtx1374) - uint32_t(r_PtxRegister666);			  // PTX L1380
	r_PtxRegister668 = ShiftLeft(uint32_t(r_PtxRegister667), uint32_t(1));					  // PTX L1381
	r_PtxRegister669 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister668);				  // PTX L1382
	r_PtxRegister670 = ShiftRight(uint32_t(r_PtxRegister669), uint32_t(31));				  // PTX L1383
	r_PtxRegister671 = uint32_t(r_PtxRegister669) + uint32_t(r_PtxRegister670);				  // PTX L1384
	r_PtxRegister672 = ShiftRightSigned(int32_t(r_PtxRegister671), uint32_t(1));			  // PTX L1385
	r_PtxU64Register108 = uint64_t(int64_t(int32_t(r_PtxRegister672)) * int64_t(int32_t(4))); // PTX L1386
	g_RecordByteAddressAtPtx1387 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register108); // PTX L1387
	r_PtxRegister381 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1387 + 262144ull);		  // PTX L1388
	r_LaneIndexAtPtx1390 = uint32_t((threadIdx.x & 31u));									  // PTX L1390
	r_PtxRegister673 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1390), uint32_t(31));		  // PTX L1392
	r_PtxRegister674 = ShiftRight(uint32_t(r_PtxRegister673), uint32_t(30));				  // PTX L1393
	r_PtxRegister675 = uint32_t(r_LaneIndexAtPtx1390) + uint32_t(r_PtxRegister674);			  // PTX L1394
	r_PtxRegister676 = r_PtxRegister675 & 2147483644;										  // PTX L1395
	r_PtxRegister677 = uint32_t(r_LaneIndexAtPtx1390) - uint32_t(r_PtxRegister676);			  // PTX L1396
	r_PtxRegister678 = ShiftLeft(uint32_t(r_PtxRegister677), uint32_t(1));					  // PTX L1397
	r_PtxRegister679 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister678);				  // PTX L1398
	r_PtxRegister680 = ShiftRightSigned(int32_t(r_PtxRegister679), uint32_t(1));			  // PTX L1399
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister680)) * int64_t(int32_t(4))); // PTX L1400
	g_RecordByteAddressAtPtx1401 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register110); // PTX L1401
	r_PtxRegister384 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1401 + 262144ull);		  // PTX L1402
	r_LaneIndexAtPtx1404 = uint32_t((threadIdx.x & 31u));									  // PTX L1404
	r_PtxRegister681 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1404), uint32_t(31));		  // PTX L1406
	r_PtxRegister682 = ShiftRight(uint32_t(r_PtxRegister681), uint32_t(30));				  // PTX L1407
	r_PtxRegister683 = uint32_t(r_LaneIndexAtPtx1404) + uint32_t(r_PtxRegister682);			  // PTX L1408
	r_PtxRegister684 = r_PtxRegister683 & 2147483644;										  // PTX L1409
	r_PtxRegister685 = uint32_t(r_LaneIndexAtPtx1404) - uint32_t(r_PtxRegister684);			  // PTX L1410
	r_PtxRegister686 = ShiftLeft(uint32_t(r_PtxRegister685), uint32_t(1));					  // PTX L1411
	r_PtxRegister687 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister686);				  // PTX L1412
	r_PtxRegister688 = ShiftRightSigned(int32_t(r_PtxRegister687), uint32_t(1));			  // PTX L1413
	r_PtxU64Register112 = uint64_t(int64_t(int32_t(r_PtxRegister688)) * int64_t(int32_t(4))); // PTX L1414
	g_RecordByteAddressAtPtx1415 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register112); // PTX L1415
	r_PtxRegister387 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1415 + 262144ull);		  // PTX L1416
	r_LaneIndexAtPtx1418 = uint32_t((threadIdx.x & 31u));									  // PTX L1418
	r_PtxRegister689 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1418), uint32_t(31));		  // PTX L1420
	r_PtxRegister690 = ShiftRight(uint32_t(r_PtxRegister689), uint32_t(30));				  // PTX L1421
	r_PtxRegister691 = uint32_t(r_LaneIndexAtPtx1418) + uint32_t(r_PtxRegister690);			  // PTX L1422
	r_PtxRegister692 = r_PtxRegister691 & 2147483644;										  // PTX L1423
	r_PtxRegister693 = uint32_t(r_LaneIndexAtPtx1418) - uint32_t(r_PtxRegister692);			  // PTX L1424
	r_PtxRegister694 = ShiftLeft(uint32_t(r_PtxRegister693), uint32_t(1));					  // PTX L1425
	r_PtxRegister695 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister694);				  // PTX L1426
	r_PtxRegister696 = ShiftRightSigned(int32_t(r_PtxRegister695), uint32_t(1));			  // PTX L1427
	r_PtxU64Register114 = uint64_t(int64_t(int32_t(r_PtxRegister696)) * int64_t(int32_t(4))); // PTX L1428
	g_RecordByteAddressAtPtx1429 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register114); // PTX L1429
	r_PtxRegister390 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1429 + 262144ull);		  // PTX L1430
	r_LaneIndexAtPtx1432 = uint32_t((threadIdx.x & 31u));									  // PTX L1432
	r_PtxRegister697 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1432), uint32_t(31));		  // PTX L1434
	r_PtxRegister698 = ShiftRight(uint32_t(r_PtxRegister697), uint32_t(30));				  // PTX L1435
	r_PtxRegister699 = uint32_t(r_LaneIndexAtPtx1432) + uint32_t(r_PtxRegister698);			  // PTX L1436
	r_PtxRegister700 = r_PtxRegister699 & 2147483644;										  // PTX L1437
	r_PtxRegister701 = uint32_t(r_LaneIndexAtPtx1432) - uint32_t(r_PtxRegister700);			  // PTX L1438
	r_PtxRegister702 = ShiftLeft(uint32_t(r_PtxRegister701), uint32_t(1));					  // PTX L1439
	r_PtxRegister703 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister702);				  // PTX L1440
	r_PtxRegister704 = ShiftRightSigned(int32_t(r_PtxRegister703), uint32_t(1));			  // PTX L1441
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister704)) * int64_t(int32_t(4))); // PTX L1442
	g_RecordByteAddressAtPtx1443 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register116); // PTX L1443
	r_PtxRegister393 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1443 + 262144ull);		  // PTX L1444
	r_LaneIndexAtPtx1446 = uint32_t((threadIdx.x & 31u));									  // PTX L1446
	r_PtxRegister705 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1446), uint32_t(31));		  // PTX L1448
	r_PtxRegister706 = ShiftRight(uint32_t(r_PtxRegister705), uint32_t(30));				  // PTX L1449
	r_PtxRegister707 = uint32_t(r_LaneIndexAtPtx1446) + uint32_t(r_PtxRegister706);			  // PTX L1450
	r_PtxRegister708 = r_PtxRegister707 & 2147483644;										  // PTX L1451
	r_PtxRegister709 = uint32_t(r_LaneIndexAtPtx1446) - uint32_t(r_PtxRegister708);			  // PTX L1452
	r_PtxRegister710 = ShiftLeft(uint32_t(r_PtxRegister709), uint32_t(1));					  // PTX L1453
	r_PtxRegister711 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister710);				  // PTX L1454
	r_PtxRegister712 = ShiftRightSigned(int32_t(r_PtxRegister711), uint32_t(1));			  // PTX L1455
	r_PtxU64Register118 = uint64_t(int64_t(int32_t(r_PtxRegister712)) * int64_t(int32_t(4))); // PTX L1456
	g_RecordByteAddressAtPtx1457 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register118); // PTX L1457
	r_PtxRegister396 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1457 + 262144ull);		  // PTX L1458
	r_LaneIndexAtPtx1460 = uint32_t((threadIdx.x & 31u));									  // PTX L1460
	r_PtxRegister713 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1460), uint32_t(31));		  // PTX L1462
	r_PtxRegister714 = ShiftRight(uint32_t(r_PtxRegister713), uint32_t(30));				  // PTX L1463
	r_PtxRegister715 = uint32_t(r_LaneIndexAtPtx1460) + uint32_t(r_PtxRegister714);			  // PTX L1464
	r_PtxRegister716 = r_PtxRegister715 & 2147483644;										  // PTX L1465
	r_PtxRegister717 = uint32_t(r_LaneIndexAtPtx1460) - uint32_t(r_PtxRegister716);			  // PTX L1466
	r_PtxRegister718 = ShiftLeft(uint32_t(r_PtxRegister717), uint32_t(1));					  // PTX L1467
	r_PtxRegister719 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister718);				  // PTX L1468
	r_PtxRegister720 = ShiftRightSigned(int32_t(r_PtxRegister719), uint32_t(1));			  // PTX L1469
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister720)) * int64_t(int32_t(4))); // PTX L1470
	g_RecordByteAddressAtPtx1471 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register120); // PTX L1471
	r_PtxRegister399 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1471 + 262144ull);		  // PTX L1472
	r_LaneIndexAtPtx1474 = uint32_t((threadIdx.x & 31u));									  // PTX L1474
	r_PtxRegister721 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1474), uint32_t(31));		  // PTX L1476
	r_PtxRegister722 = ShiftRight(uint32_t(r_PtxRegister721), uint32_t(30));				  // PTX L1477
	r_PtxRegister723 = uint32_t(r_LaneIndexAtPtx1474) + uint32_t(r_PtxRegister722);			  // PTX L1478
	r_PtxRegister724 = r_PtxRegister723 & 2147483644;										  // PTX L1479
	r_PtxRegister725 = uint32_t(r_LaneIndexAtPtx1474) - uint32_t(r_PtxRegister724);			  // PTX L1480
	r_PtxRegister726 = ShiftLeft(uint32_t(r_PtxRegister725), uint32_t(1));					  // PTX L1481
	r_PtxRegister727 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister726);				  // PTX L1482
	r_PtxRegister728 = ShiftRight(uint32_t(r_PtxRegister727), uint32_t(31));				  // PTX L1483
	r_PtxRegister729 = uint32_t(r_PtxRegister727) + uint32_t(r_PtxRegister728);				  // PTX L1484
	r_PtxRegister730 = ShiftRightSigned(int32_t(r_PtxRegister729), uint32_t(1));			  // PTX L1485
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister730)) * int64_t(int32_t(4))); // PTX L1486
	g_RecordByteAddressAtPtx1487 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register122); // PTX L1487
	r_PtxRegister402 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1487 + 262144ull);		  // PTX L1488
	r_LaneIndexAtPtx1490 = uint32_t((threadIdx.x & 31u));									  // PTX L1490
	r_PtxRegister731 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1490), uint32_t(31));		  // PTX L1492
	r_PtxRegister732 = ShiftRight(uint32_t(r_PtxRegister731), uint32_t(30));				  // PTX L1493
	r_PtxRegister733 = uint32_t(r_LaneIndexAtPtx1490) + uint32_t(r_PtxRegister732);			  // PTX L1494
	r_PtxRegister734 = r_PtxRegister733 & 2147483644;										  // PTX L1495
	r_PtxRegister735 = uint32_t(r_LaneIndexAtPtx1490) - uint32_t(r_PtxRegister734);			  // PTX L1496
	r_PtxRegister736 = ShiftLeft(uint32_t(r_PtxRegister735), uint32_t(1));					  // PTX L1497
	r_PtxRegister737 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister736);				  // PTX L1498
	r_PtxRegister738 = ShiftRight(uint32_t(r_PtxRegister737), uint32_t(31));				  // PTX L1499
	r_PtxRegister739 = uint32_t(r_PtxRegister737) + uint32_t(r_PtxRegister738);				  // PTX L1500
	r_PtxRegister740 = ShiftRightSigned(int32_t(r_PtxRegister739), uint32_t(1));			  // PTX L1501
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister740)) * int64_t(int32_t(4))); // PTX L1502
	g_RecordByteAddressAtPtx1503 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register124); // PTX L1503
	r_PtxRegister405 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1503 + 262144ull);		  // PTX L1504
	r_LaneIndexAtPtx1506 = uint32_t((threadIdx.x & 31u));									  // PTX L1506
	r_PtxRegister741 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1506), uint32_t(31));		  // PTX L1508
	r_PtxRegister742 = ShiftRight(uint32_t(r_PtxRegister741), uint32_t(30));				  // PTX L1509
	r_PtxRegister743 = uint32_t(r_LaneIndexAtPtx1506) + uint32_t(r_PtxRegister742);			  // PTX L1510
	r_PtxRegister744 = r_PtxRegister743 & 2147483644;										  // PTX L1511
	r_PtxRegister745 = uint32_t(r_LaneIndexAtPtx1506) - uint32_t(r_PtxRegister744);			  // PTX L1512
	r_PtxRegister746 = ShiftLeft(uint32_t(r_PtxRegister745), uint32_t(1));					  // PTX L1513
	r_PtxRegister747 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister746);				  // PTX L1514
	r_PtxRegister748 = ShiftRightSigned(int32_t(r_PtxRegister747), uint32_t(1));			  // PTX L1515
	r_PtxU64Register126 = uint64_t(int64_t(int32_t(r_PtxRegister748)) * int64_t(int32_t(4))); // PTX L1516
	g_RecordByteAddressAtPtx1517 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register126); // PTX L1517
	r_PtxRegister408 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1517 + 262144ull);		  // PTX L1518
	r_LaneIndexAtPtx1520 = uint32_t((threadIdx.x & 31u));									  // PTX L1520
	r_PtxRegister749 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1520), uint32_t(31));		  // PTX L1522
	r_PtxRegister750 = ShiftRight(uint32_t(r_PtxRegister749), uint32_t(30));				  // PTX L1523
	r_PtxRegister751 = uint32_t(r_LaneIndexAtPtx1520) + uint32_t(r_PtxRegister750);			  // PTX L1524
	r_PtxRegister752 = r_PtxRegister751 & 2147483644;										  // PTX L1525
	r_PtxRegister753 = uint32_t(r_LaneIndexAtPtx1520) - uint32_t(r_PtxRegister752);			  // PTX L1526
	r_PtxRegister754 = ShiftLeft(uint32_t(r_PtxRegister753), uint32_t(1));					  // PTX L1527
	r_PtxRegister755 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister754);				  // PTX L1528
	r_PtxRegister756 = ShiftRightSigned(int32_t(r_PtxRegister755), uint32_t(1));			  // PTX L1529
	r_PtxU64Register128 = uint64_t(int64_t(int32_t(r_PtxRegister756)) * int64_t(int32_t(4))); // PTX L1530
	g_RecordByteAddressAtPtx1531 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register128); // PTX L1531
	r_PtxRegister411 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1531 + 262144ull);		  // PTX L1532
	r_LaneIndexAtPtx1534 = uint32_t((threadIdx.x & 31u));									  // PTX L1534
	r_PtxRegister757 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1534), uint32_t(31));		  // PTX L1536
	r_PtxRegister758 = ShiftRight(uint32_t(r_PtxRegister757), uint32_t(30));				  // PTX L1537
	r_PtxRegister759 = uint32_t(r_LaneIndexAtPtx1534) + uint32_t(r_PtxRegister758);			  // PTX L1538
	r_PtxRegister760 = r_PtxRegister759 & 2147483644;										  // PTX L1539
	r_PtxRegister761 = uint32_t(r_LaneIndexAtPtx1534) - uint32_t(r_PtxRegister760);			  // PTX L1540
	r_PtxRegister762 = ShiftLeft(uint32_t(r_PtxRegister761), uint32_t(1));					  // PTX L1541
	r_PtxRegister763 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister762);				  // PTX L1542
	r_PtxRegister764 = ShiftRight(uint32_t(r_PtxRegister763), uint32_t(31));				  // PTX L1543
	r_PtxRegister765 = uint32_t(r_PtxRegister763) + uint32_t(r_PtxRegister764);				  // PTX L1544
	r_PtxRegister766 = ShiftRightSigned(int32_t(r_PtxRegister765), uint32_t(1));			  // PTX L1545
	r_PtxU64Register130 = uint64_t(int64_t(int32_t(r_PtxRegister766)) * int64_t(int32_t(4))); // PTX L1546
	g_RecordByteAddressAtPtx1547 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register130); // PTX L1547
	r_PtxRegister414 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1547 + 262144ull);		  // PTX L1548
	r_LaneIndexAtPtx1550 = uint32_t((threadIdx.x & 31u));									  // PTX L1550
	r_PtxRegister767 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1550), uint32_t(31));		  // PTX L1552
	r_PtxRegister768 = ShiftRight(uint32_t(r_PtxRegister767), uint32_t(30));				  // PTX L1553
	r_PtxRegister769 = uint32_t(r_LaneIndexAtPtx1550) + uint32_t(r_PtxRegister768);			  // PTX L1554
	r_PtxRegister770 = r_PtxRegister769 & 2147483644;										  // PTX L1555
	r_PtxRegister771 = uint32_t(r_LaneIndexAtPtx1550) - uint32_t(r_PtxRegister770);			  // PTX L1556
	r_PtxRegister772 = ShiftLeft(uint32_t(r_PtxRegister771), uint32_t(1));					  // PTX L1557
	r_PtxRegister773 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister772);				  // PTX L1558
	r_PtxRegister774 = ShiftRight(uint32_t(r_PtxRegister773), uint32_t(31));				  // PTX L1559
	r_PtxRegister775 = uint32_t(r_PtxRegister773) + uint32_t(r_PtxRegister774);				  // PTX L1560
	r_PtxRegister776 = ShiftRightSigned(int32_t(r_PtxRegister775), uint32_t(1));			  // PTX L1561
	r_PtxU64Register132 = uint64_t(int64_t(int32_t(r_PtxRegister776)) * int64_t(int32_t(4))); // PTX L1562
	g_RecordByteAddressAtPtx1563 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register132); // PTX L1563
	r_PtxRegister417 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1563 + 262144ull);		  // PTX L1564
	r_LaneIndexAtPtx1566 = uint32_t((threadIdx.x & 31u));									  // PTX L1566
	r_PtxRegister777 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1566), uint32_t(31));		  // PTX L1568
	r_PtxRegister778 = ShiftRight(uint32_t(r_PtxRegister777), uint32_t(30));				  // PTX L1569
	r_PtxRegister779 = uint32_t(r_LaneIndexAtPtx1566) + uint32_t(r_PtxRegister778);			  // PTX L1570
	r_PtxRegister780 = r_PtxRegister779 & 2147483644;										  // PTX L1571
	r_PtxRegister781 = uint32_t(r_LaneIndexAtPtx1566) - uint32_t(r_PtxRegister780);			  // PTX L1572
	r_PtxRegister782 = ShiftLeft(uint32_t(r_PtxRegister781), uint32_t(1));					  // PTX L1573
	r_PtxRegister783 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister782);				  // PTX L1574
	r_PtxRegister784 = ShiftRightSigned(int32_t(r_PtxRegister783), uint32_t(1));			  // PTX L1575
	r_PtxU64Register134 = uint64_t(int64_t(int32_t(r_PtxRegister784)) * int64_t(int32_t(4))); // PTX L1576
	g_RecordByteAddressAtPtx1577 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register134); // PTX L1577
	r_PtxRegister420 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1577 + 262144ull);		  // PTX L1578
	r_LaneIndexAtPtx1580 = uint32_t((threadIdx.x & 31u));									  // PTX L1580
	r_PtxRegister785 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1580), uint32_t(31));		  // PTX L1582
	r_PtxRegister786 = ShiftRight(uint32_t(r_PtxRegister785), uint32_t(30));				  // PTX L1583
	r_PtxRegister787 = uint32_t(r_LaneIndexAtPtx1580) + uint32_t(r_PtxRegister786);			  // PTX L1584
	r_PtxRegister788 = r_PtxRegister787 & 2147483644;										  // PTX L1585
	r_PtxRegister789 = uint32_t(r_LaneIndexAtPtx1580) - uint32_t(r_PtxRegister788);			  // PTX L1586
	r_PtxRegister790 = ShiftLeft(uint32_t(r_PtxRegister789), uint32_t(1));					  // PTX L1587
	r_PtxRegister791 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister790);				  // PTX L1588
	r_PtxRegister792 = ShiftRightSigned(int32_t(r_PtxRegister791), uint32_t(1));			  // PTX L1589
	r_PtxU64Register136 = uint64_t(int64_t(int32_t(r_PtxRegister792)) * int64_t(int32_t(4))); // PTX L1590
	g_RecordByteAddressAtPtx1591 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register136); // PTX L1591
	r_PtxRegister423 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1591 + 262144ull);		  // PTX L1592
	r_LaneIndexAtPtx1594 = uint32_t((threadIdx.x & 31u));									  // PTX L1594
	r_PtxRegister793 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1594), uint32_t(31));		  // PTX L1596
	r_PtxRegister794 = ShiftRight(uint32_t(r_PtxRegister793), uint32_t(30));				  // PTX L1597
	r_PtxRegister795 = uint32_t(r_LaneIndexAtPtx1594) + uint32_t(r_PtxRegister794);			  // PTX L1598
	r_PtxRegister796 = r_PtxRegister795 & 2147483644;										  // PTX L1599
	r_PtxRegister797 = uint32_t(r_LaneIndexAtPtx1594) - uint32_t(r_PtxRegister796);			  // PTX L1600
	r_PtxRegister798 = ShiftLeft(uint32_t(r_PtxRegister797), uint32_t(1));					  // PTX L1601
	r_PtxRegister799 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister798);				  // PTX L1602
	r_PtxRegister800 = ShiftRight(uint32_t(r_PtxRegister799), uint32_t(31));				  // PTX L1603
	r_PtxRegister801 = uint32_t(r_PtxRegister799) + uint32_t(r_PtxRegister800);				  // PTX L1604
	r_PtxRegister802 = ShiftRightSigned(int32_t(r_PtxRegister801), uint32_t(1));			  // PTX L1605
	r_PtxU64Register138 = uint64_t(int64_t(int32_t(r_PtxRegister802)) * int64_t(int32_t(4))); // PTX L1606
	g_RecordByteAddressAtPtx1607 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register138); // PTX L1607
	r_PtxRegister426 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1607 + 262144ull);		  // PTX L1608
	r_LaneIndexAtPtx1610 = uint32_t((threadIdx.x & 31u));									  // PTX L1610
	r_PtxRegister803 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1610), uint32_t(31));		  // PTX L1612
	r_PtxRegister804 = ShiftRight(uint32_t(r_PtxRegister803), uint32_t(30));				  // PTX L1613
	r_PtxRegister805 = uint32_t(r_LaneIndexAtPtx1610) + uint32_t(r_PtxRegister804);			  // PTX L1614
	r_PtxRegister806 = r_PtxRegister805 & 2147483644;										  // PTX L1615
	r_PtxRegister807 = uint32_t(r_LaneIndexAtPtx1610) - uint32_t(r_PtxRegister806);			  // PTX L1616
	r_PtxRegister808 = ShiftLeft(uint32_t(r_PtxRegister807), uint32_t(1));					  // PTX L1617
	r_PtxRegister809 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister808);				  // PTX L1618
	r_PtxRegister810 = ShiftRight(uint32_t(r_PtxRegister809), uint32_t(31));				  // PTX L1619
	r_PtxRegister811 = uint32_t(r_PtxRegister809) + uint32_t(r_PtxRegister810);				  // PTX L1620
	r_PtxRegister812 = ShiftRightSigned(int32_t(r_PtxRegister811), uint32_t(1));			  // PTX L1621
	r_PtxU64Register140 = uint64_t(int64_t(int32_t(r_PtxRegister812)) * int64_t(int32_t(4))); // PTX L1622
	g_RecordByteAddressAtPtx1623 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register140); // PTX L1623
	r_PtxRegister429 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1623 + 262144ull);		  // PTX L1624
	r_LaneIndexAtPtx1626 = uint32_t((threadIdx.x & 31u));									  // PTX L1626
	r_PtxRegister813 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1626), uint32_t(31));		  // PTX L1628
	r_PtxRegister814 = ShiftRight(uint32_t(r_PtxRegister813), uint32_t(30));				  // PTX L1629
	r_PtxRegister815 = uint32_t(r_LaneIndexAtPtx1626) + uint32_t(r_PtxRegister814);			  // PTX L1630
	r_PtxRegister816 = r_PtxRegister815 & 2147483644;										  // PTX L1631
	r_PtxRegister817 = uint32_t(r_LaneIndexAtPtx1626) - uint32_t(r_PtxRegister816);			  // PTX L1632
	r_PtxRegister818 = ShiftLeft(uint32_t(r_PtxRegister817), uint32_t(1));					  // PTX L1633
	r_PtxRegister819 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister818);				  // PTX L1634
	r_PtxRegister820 = ShiftRightSigned(int32_t(r_PtxRegister819), uint32_t(1));			  // PTX L1635
	r_PtxU64Register142 = uint64_t(int64_t(int32_t(r_PtxRegister820)) * int64_t(int32_t(4))); // PTX L1636
	g_RecordByteAddressAtPtx1637 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register142); // PTX L1637
	r_PtxRegister432 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1637 + 262144ull);		  // PTX L1638
	r_LaneIndexAtPtx1640 = uint32_t((threadIdx.x & 31u));									  // PTX L1640
	r_PtxRegister821 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1640), uint32_t(31));		  // PTX L1642
	r_PtxRegister822 = ShiftRight(uint32_t(r_PtxRegister821), uint32_t(30));				  // PTX L1643
	r_PtxRegister823 = uint32_t(r_LaneIndexAtPtx1640) + uint32_t(r_PtxRegister822);			  // PTX L1644
	r_PtxRegister824 = r_PtxRegister823 & 2147483644;										  // PTX L1645
	r_PtxRegister825 = uint32_t(r_LaneIndexAtPtx1640) - uint32_t(r_PtxRegister824);			  // PTX L1646
	r_PtxRegister826 = ShiftLeft(uint32_t(r_PtxRegister825), uint32_t(1));					  // PTX L1647
	r_PtxRegister827 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister826);				  // PTX L1648
	r_PtxRegister828 = ShiftRightSigned(int32_t(r_PtxRegister827), uint32_t(1));			  // PTX L1649
	r_PtxU64Register144 = uint64_t(int64_t(int32_t(r_PtxRegister828)) * int64_t(int32_t(4))); // PTX L1650
	g_RecordByteAddressAtPtx1651 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register144); // PTX L1651
	r_PtxRegister435 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1651 + 262144ull);		  // PTX L1652
	r_LaneIndexAtPtx1654 = uint32_t((threadIdx.x & 31u));									  // PTX L1654
	r_PtxRegister829 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1654), uint32_t(31));		  // PTX L1656
	r_PtxRegister830 = ShiftRight(uint32_t(r_PtxRegister829), uint32_t(30));				  // PTX L1657
	r_PtxRegister831 = uint32_t(r_LaneIndexAtPtx1654) + uint32_t(r_PtxRegister830);			  // PTX L1658
	r_PtxRegister832 = r_PtxRegister831 & 2147483644;										  // PTX L1659
	r_PtxRegister833 = uint32_t(r_LaneIndexAtPtx1654) - uint32_t(r_PtxRegister832);			  // PTX L1660
	r_PtxRegister834 = ShiftLeft(uint32_t(r_PtxRegister833), uint32_t(1));					  // PTX L1661
	r_PtxRegister835 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister834);				  // PTX L1662
	r_PtxRegister836 = ShiftRightSigned(int32_t(r_PtxRegister835), uint32_t(1));			  // PTX L1663
	r_PtxU64Register146 = uint64_t(int64_t(int32_t(r_PtxRegister836)) * int64_t(int32_t(4))); // PTX L1664
	g_RecordByteAddressAtPtx1665 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register146); // PTX L1665
	r_PtxRegister438 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1665 + 262144ull);		  // PTX L1666
	r_LaneIndexAtPtx1668 = uint32_t((threadIdx.x & 31u));									  // PTX L1668
	r_PtxRegister837 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1668), uint32_t(31));		  // PTX L1670
	r_PtxRegister838 = ShiftRight(uint32_t(r_PtxRegister837), uint32_t(30));				  // PTX L1671
	r_PtxRegister839 = uint32_t(r_LaneIndexAtPtx1668) + uint32_t(r_PtxRegister838);			  // PTX L1672
	r_PtxRegister840 = r_PtxRegister839 & 2147483644;										  // PTX L1673
	r_PtxRegister841 = uint32_t(r_LaneIndexAtPtx1668) - uint32_t(r_PtxRegister840);			  // PTX L1674
	r_PtxRegister842 = ShiftLeft(uint32_t(r_PtxRegister841), uint32_t(1));					  // PTX L1675
	r_PtxRegister843 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister842);				  // PTX L1676
	r_PtxRegister844 = ShiftRightSigned(int32_t(r_PtxRegister843), uint32_t(1));			  // PTX L1677
	r_PtxU64Register148 = uint64_t(int64_t(int32_t(r_PtxRegister844)) * int64_t(int32_t(4))); // PTX L1678
	g_RecordByteAddressAtPtx1679 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register148); // PTX L1679
	r_PtxRegister441 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1679 + 262144ull);		  // PTX L1680
	r_LaneIndexAtPtx1682 = uint32_t((threadIdx.x & 31u));									  // PTX L1682
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1682), uint32_t(31));		  // PTX L1684
	r_PtxRegister846 = ShiftRight(uint32_t(r_PtxRegister845), uint32_t(30));				  // PTX L1685
	r_PtxRegister847 = uint32_t(r_LaneIndexAtPtx1682) + uint32_t(r_PtxRegister846);			  // PTX L1686
	r_PtxRegister848 = r_PtxRegister847 & 2147483644;										  // PTX L1687
	r_PtxRegister849 = uint32_t(r_LaneIndexAtPtx1682) - uint32_t(r_PtxRegister848);			  // PTX L1688
	r_PtxRegister850 = ShiftLeft(uint32_t(r_PtxRegister849), uint32_t(1));					  // PTX L1689
	r_PtxRegister851 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister850);				  // PTX L1690
	r_PtxRegister852 = ShiftRightSigned(int32_t(r_PtxRegister851), uint32_t(1));			  // PTX L1691
	r_PtxU64Register150 = uint64_t(int64_t(int32_t(r_PtxRegister852)) * int64_t(int32_t(4))); // PTX L1692
	g_RecordByteAddressAtPtx1693 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register150); // PTX L1693
	r_PtxRegister444 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1693 + 262144ull);		  // PTX L1694
	r_LaneIndexAtPtx1696 = uint32_t((threadIdx.x & 31u));									  // PTX L1696
	r_PtxRegister853 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1696), uint32_t(31));		  // PTX L1698
	r_PtxRegister854 = ShiftRight(uint32_t(r_PtxRegister853), uint32_t(30));				  // PTX L1699
	r_PtxRegister855 = uint32_t(r_LaneIndexAtPtx1696) + uint32_t(r_PtxRegister854);			  // PTX L1700
	r_PtxRegister856 = r_PtxRegister855 & 2147483644;										  // PTX L1701
	r_PtxRegister857 = uint32_t(r_LaneIndexAtPtx1696) - uint32_t(r_PtxRegister856);			  // PTX L1702
	r_PtxRegister858 = ShiftLeft(uint32_t(r_PtxRegister857), uint32_t(1));					  // PTX L1703
	r_PtxRegister859 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister858);				  // PTX L1704
	r_PtxRegister860 = ShiftRightSigned(int32_t(r_PtxRegister859), uint32_t(1));			  // PTX L1705
	r_PtxU64Register152 = uint64_t(int64_t(int32_t(r_PtxRegister860)) * int64_t(int32_t(4))); // PTX L1706
	g_RecordByteAddressAtPtx1707 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register152); // PTX L1707
	r_PtxRegister447 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1707 + 262144ull);		  // PTX L1708
	r_LaneIndexAtPtx1710 = uint32_t((threadIdx.x & 31u));									  // PTX L1710
	r_PtxRegister861 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1710), uint32_t(31));		  // PTX L1712
	r_PtxRegister862 = ShiftRight(uint32_t(r_PtxRegister861), uint32_t(30));				  // PTX L1713
	r_PtxRegister863 = uint32_t(r_LaneIndexAtPtx1710) + uint32_t(r_PtxRegister862);			  // PTX L1714
	r_PtxRegister864 = r_PtxRegister863 & 2147483644;										  // PTX L1715
	r_PtxRegister865 = uint32_t(r_LaneIndexAtPtx1710) - uint32_t(r_PtxRegister864);			  // PTX L1716
	r_PtxRegister866 = ShiftLeft(uint32_t(r_PtxRegister865), uint32_t(1));					  // PTX L1717
	r_PtxRegister867 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister866);				  // PTX L1718
	r_PtxRegister868 = ShiftRight(uint32_t(r_PtxRegister867), uint32_t(31));				  // PTX L1719
	r_PtxRegister869 = uint32_t(r_PtxRegister867) + uint32_t(r_PtxRegister868);				  // PTX L1720
	r_PtxRegister870 = ShiftRightSigned(int32_t(r_PtxRegister869), uint32_t(1));			  // PTX L1721
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister870)) * int64_t(int32_t(4))); // PTX L1722
	g_RecordByteAddressAtPtx1723 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register154); // PTX L1723
	r_PtxRegister450 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1723 + 262144ull);		  // PTX L1724
	r_LaneIndexAtPtx1726 = uint32_t((threadIdx.x & 31u));									  // PTX L1726
	r_PtxRegister871 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1726), uint32_t(31));		  // PTX L1728
	r_PtxRegister872 = ShiftRight(uint32_t(r_PtxRegister871), uint32_t(30));				  // PTX L1729
	r_PtxRegister873 = uint32_t(r_LaneIndexAtPtx1726) + uint32_t(r_PtxRegister872);			  // PTX L1730
	r_PtxRegister874 = r_PtxRegister873 & 2147483644;										  // PTX L1731
	r_PtxRegister875 = uint32_t(r_LaneIndexAtPtx1726) - uint32_t(r_PtxRegister874);			  // PTX L1732
	r_PtxRegister876 = ShiftLeft(uint32_t(r_PtxRegister875), uint32_t(1));					  // PTX L1733
	r_PtxRegister877 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister876);				  // PTX L1734
	r_PtxRegister878 = ShiftRight(uint32_t(r_PtxRegister877), uint32_t(31));				  // PTX L1735
	r_PtxRegister879 = uint32_t(r_PtxRegister877) + uint32_t(r_PtxRegister878);				  // PTX L1736
	r_PtxRegister880 = ShiftRightSigned(int32_t(r_PtxRegister879), uint32_t(1));			  // PTX L1737
	r_PtxU64Register156 = uint64_t(int64_t(int32_t(r_PtxRegister880)) * int64_t(int32_t(4))); // PTX L1738
	g_RecordByteAddressAtPtx1739 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register156); // PTX L1739
	r_PtxRegister453 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1739 + 262144ull);		  // PTX L1740
	r_LaneIndexAtPtx1742 = uint32_t((threadIdx.x & 31u));									  // PTX L1742
	r_PtxRegister881 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1742), uint32_t(31));		  // PTX L1744
	r_PtxRegister882 = ShiftRight(uint32_t(r_PtxRegister881), uint32_t(30));				  // PTX L1745
	r_PtxRegister883 = uint32_t(r_LaneIndexAtPtx1742) + uint32_t(r_PtxRegister882);			  // PTX L1746
	r_PtxRegister884 = r_PtxRegister883 & 2147483644;										  // PTX L1747
	r_PtxRegister885 = uint32_t(r_LaneIndexAtPtx1742) - uint32_t(r_PtxRegister884);			  // PTX L1748
	r_PtxRegister886 = ShiftLeft(uint32_t(r_PtxRegister885), uint32_t(1));					  // PTX L1749
	r_PtxRegister887 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister886);				  // PTX L1750
	r_PtxRegister888 = ShiftRightSigned(int32_t(r_PtxRegister887), uint32_t(1));			  // PTX L1751
	r_PtxU64Register158 = uint64_t(int64_t(int32_t(r_PtxRegister888)) * int64_t(int32_t(4))); // PTX L1752
	g_RecordByteAddressAtPtx1753 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register158); // PTX L1753
	r_PtxRegister456 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1753 + 262144ull);		  // PTX L1754
	r_LaneIndexAtPtx1756 = uint32_t((threadIdx.x & 31u));									  // PTX L1756
	r_PtxRegister889 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1756), uint32_t(31));		  // PTX L1758
	r_PtxRegister890 = ShiftRight(uint32_t(r_PtxRegister889), uint32_t(30));				  // PTX L1759
	r_PtxRegister891 = uint32_t(r_LaneIndexAtPtx1756) + uint32_t(r_PtxRegister890);			  // PTX L1760
	r_PtxRegister892 = r_PtxRegister891 & 2147483644;										  // PTX L1761
	r_PtxRegister893 = uint32_t(r_LaneIndexAtPtx1756) - uint32_t(r_PtxRegister892);			  // PTX L1762
	r_PtxRegister894 = ShiftLeft(uint32_t(r_PtxRegister893), uint32_t(1));					  // PTX L1763
	r_PtxRegister895 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister894);				  // PTX L1764
	r_PtxRegister896 = ShiftRightSigned(int32_t(r_PtxRegister895), uint32_t(1));			  // PTX L1765
	r_PtxU64Register160 = uint64_t(int64_t(int32_t(r_PtxRegister896)) * int64_t(int32_t(4))); // PTX L1766
	g_RecordByteAddressAtPtx1767 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register160); // PTX L1767
	r_PtxRegister459 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1767 + 262144ull);		  // PTX L1768
	r_LaneIndexAtPtx1770 = uint32_t((threadIdx.x & 31u));									  // PTX L1770
	r_PtxRegister897 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1770), uint32_t(31));		  // PTX L1772
	r_PtxRegister898 = ShiftRight(uint32_t(r_PtxRegister897), uint32_t(30));				  // PTX L1773
	r_PtxRegister899 = uint32_t(r_LaneIndexAtPtx1770) + uint32_t(r_PtxRegister898);			  // PTX L1774
	r_PtxRegister900 = r_PtxRegister899 & 2147483644;										  // PTX L1775
	r_PtxRegister901 = uint32_t(r_LaneIndexAtPtx1770) - uint32_t(r_PtxRegister900);			  // PTX L1776
	r_PtxRegister902 = ShiftLeft(uint32_t(r_PtxRegister901), uint32_t(1));					  // PTX L1777
	r_PtxRegister903 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister902);				  // PTX L1778
	r_PtxRegister904 = ShiftRight(uint32_t(r_PtxRegister903), uint32_t(31));				  // PTX L1779
	r_PtxRegister905 = uint32_t(r_PtxRegister903) + uint32_t(r_PtxRegister904);				  // PTX L1780
	r_PtxRegister906 = ShiftRightSigned(int32_t(r_PtxRegister905), uint32_t(1));			  // PTX L1781
	r_PtxU64Register162 = uint64_t(int64_t(int32_t(r_PtxRegister906)) * int64_t(int32_t(4))); // PTX L1782
	g_RecordByteAddressAtPtx1783 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register162); // PTX L1783
	r_PtxRegister462 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1783 + 262144ull);		  // PTX L1784
	r_LaneIndexAtPtx1786 = uint32_t((threadIdx.x & 31u));									  // PTX L1786
	r_PtxRegister907 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1786), uint32_t(31));		  // PTX L1788
	r_PtxRegister908 = ShiftRight(uint32_t(r_PtxRegister907), uint32_t(30));				  // PTX L1789
	r_PtxRegister909 = uint32_t(r_LaneIndexAtPtx1786) + uint32_t(r_PtxRegister908);			  // PTX L1790
	r_PtxRegister910 = r_PtxRegister909 & 2147483644;										  // PTX L1791
	r_PtxRegister911 = uint32_t(r_LaneIndexAtPtx1786) - uint32_t(r_PtxRegister910);			  // PTX L1792
	r_PtxRegister912 = ShiftLeft(uint32_t(r_PtxRegister911), uint32_t(1));					  // PTX L1793
	r_PtxRegister913 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister912);				  // PTX L1794
	r_PtxRegister914 = ShiftRight(uint32_t(r_PtxRegister913), uint32_t(31));				  // PTX L1795
	r_PtxRegister915 = uint32_t(r_PtxRegister913) + uint32_t(r_PtxRegister914);				  // PTX L1796
	r_PtxRegister916 = ShiftRightSigned(int32_t(r_PtxRegister915), uint32_t(1));			  // PTX L1797
	r_PtxU64Register164 = uint64_t(int64_t(int32_t(r_PtxRegister916)) * int64_t(int32_t(4))); // PTX L1798
	g_RecordByteAddressAtPtx1799 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register164); // PTX L1799
	r_PtxRegister465 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1799 + 262144ull);		  // PTX L1800
	r_LaneIndexAtPtx1802 = uint32_t((threadIdx.x & 31u));									  // PTX L1802
	r_PtxRegister917 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1802), uint32_t(31));		  // PTX L1804
	r_PtxRegister918 = ShiftRight(uint32_t(r_PtxRegister917), uint32_t(30));				  // PTX L1805
	r_PtxRegister919 = uint32_t(r_LaneIndexAtPtx1802) + uint32_t(r_PtxRegister918);			  // PTX L1806
	r_PtxRegister920 = r_PtxRegister919 & 2147483644;										  // PTX L1807
	r_PtxRegister921 = uint32_t(r_LaneIndexAtPtx1802) - uint32_t(r_PtxRegister920);			  // PTX L1808
	r_PtxRegister922 = ShiftLeft(uint32_t(r_PtxRegister921), uint32_t(1));					  // PTX L1809
	r_PtxRegister923 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister922);				  // PTX L1810
	r_PtxRegister924 = ShiftRightSigned(int32_t(r_PtxRegister923), uint32_t(1));			  // PTX L1811
	r_PtxU64Register166 = uint64_t(int64_t(int32_t(r_PtxRegister924)) * int64_t(int32_t(4))); // PTX L1812
	g_RecordByteAddressAtPtx1813 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register166); // PTX L1813
	r_PtxRegister468 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1813 + 262144ull);		  // PTX L1814
	r_LaneIndexAtPtx1816 = uint32_t((threadIdx.x & 31u));									  // PTX L1816
	r_PtxRegister925 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1816), uint32_t(31));		  // PTX L1818
	r_PtxRegister926 = ShiftRight(uint32_t(r_PtxRegister925), uint32_t(30));				  // PTX L1819
	r_PtxRegister927 = uint32_t(r_LaneIndexAtPtx1816) + uint32_t(r_PtxRegister926);			  // PTX L1820
	r_PtxRegister928 = r_PtxRegister927 & 2147483644;										  // PTX L1821
	r_PtxRegister929 = uint32_t(r_LaneIndexAtPtx1816) - uint32_t(r_PtxRegister928);			  // PTX L1822
	r_PtxRegister930 = ShiftLeft(uint32_t(r_PtxRegister929), uint32_t(1));					  // PTX L1823
	r_PtxRegister931 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister930);				  // PTX L1824
	r_PtxRegister932 = ShiftRightSigned(int32_t(r_PtxRegister931), uint32_t(1));			  // PTX L1825
	r_PtxU64Register168 = uint64_t(int64_t(int32_t(r_PtxRegister932)) * int64_t(int32_t(4))); // PTX L1826
	g_RecordByteAddressAtPtx1827 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register168); // PTX L1827
	r_PtxRegister471 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1827 + 262144ull);		  // PTX L1828
	r_LaneIndexAtPtx1830 = uint32_t((threadIdx.x & 31u));									  // PTX L1830
	r_PtxRegister933 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1830), uint32_t(31));		  // PTX L1832
	r_PtxRegister934 = ShiftRight(uint32_t(r_PtxRegister933), uint32_t(30));				  // PTX L1833
	r_PtxRegister935 = uint32_t(r_LaneIndexAtPtx1830) + uint32_t(r_PtxRegister934);			  // PTX L1834
	r_PtxRegister936 = r_PtxRegister935 & 2147483644;										  // PTX L1835
	r_PtxRegister937 = uint32_t(r_LaneIndexAtPtx1830) - uint32_t(r_PtxRegister936);			  // PTX L1836
	r_PtxRegister938 = ShiftLeft(uint32_t(r_PtxRegister937), uint32_t(1));					  // PTX L1837
	r_PtxRegister939 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister938);				  // PTX L1838
	r_PtxRegister940 = ShiftRight(uint32_t(r_PtxRegister939), uint32_t(31));				  // PTX L1839
	r_PtxRegister941 = uint32_t(r_PtxRegister939) + uint32_t(r_PtxRegister940);				  // PTX L1840
	r_PtxRegister942 = ShiftRightSigned(int32_t(r_PtxRegister941), uint32_t(1));			  // PTX L1841
	r_PtxU64Register170 = uint64_t(int64_t(int32_t(r_PtxRegister942)) * int64_t(int32_t(4))); // PTX L1842
	g_RecordByteAddressAtPtx1843 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register170); // PTX L1843
	r_PtxRegister474 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1843 + 262144ull);		  // PTX L1844
	r_LaneIndexAtPtx1846 = uint32_t((threadIdx.x & 31u));									  // PTX L1846
	r_PtxRegister943 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1846), uint32_t(31));		  // PTX L1848
	r_PtxRegister944 = ShiftRight(uint32_t(r_PtxRegister943), uint32_t(30));				  // PTX L1849
	r_PtxRegister945 = uint32_t(r_LaneIndexAtPtx1846) + uint32_t(r_PtxRegister944);			  // PTX L1850
	r_PtxRegister946 = r_PtxRegister945 & 2147483644;										  // PTX L1851
	r_PtxRegister947 = uint32_t(r_LaneIndexAtPtx1846) - uint32_t(r_PtxRegister946);			  // PTX L1852
	r_PtxRegister948 = ShiftLeft(uint32_t(r_PtxRegister947), uint32_t(1));					  // PTX L1853
	r_PtxRegister949 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister948);				  // PTX L1854
	r_PtxRegister950 = ShiftRight(uint32_t(r_PtxRegister949), uint32_t(31));				  // PTX L1855
	r_PtxRegister951 = uint32_t(r_PtxRegister949) + uint32_t(r_PtxRegister950);				  // PTX L1856
	r_PtxRegister952 = ShiftRightSigned(int32_t(r_PtxRegister951), uint32_t(1));			  // PTX L1857
	r_PtxU64Register172 = uint64_t(int64_t(int32_t(r_PtxRegister952)) * int64_t(int32_t(4))); // PTX L1858
	g_RecordByteAddressAtPtx1859 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register172); // PTX L1859
	r_PtxRegister477 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1859 + 262144ull);		  // PTX L1860
	r_LaneIndexAtPtx1862 = uint32_t((threadIdx.x & 31u));									  // PTX L1862
	r_PtxRegister953 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1862), uint32_t(31));		  // PTX L1864
	r_PtxRegister954 = ShiftRight(uint32_t(r_PtxRegister953), uint32_t(30));				  // PTX L1865
	r_PtxRegister955 = uint32_t(r_LaneIndexAtPtx1862) + uint32_t(r_PtxRegister954);			  // PTX L1866
	r_PtxRegister956 = r_PtxRegister955 & 2147483644;										  // PTX L1867
	r_PtxRegister957 = uint32_t(r_LaneIndexAtPtx1862) - uint32_t(r_PtxRegister956);			  // PTX L1868
	r_PtxRegister958 = ShiftLeft(uint32_t(r_PtxRegister957), uint32_t(1));					  // PTX L1869
	r_PtxRegister959 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister958);				  // PTX L1870
	r_PtxRegister960 = ShiftRightSigned(int32_t(r_PtxRegister959), uint32_t(1));			  // PTX L1871
	r_PtxU64Register174 = uint64_t(int64_t(int32_t(r_PtxRegister960)) * int64_t(int32_t(4))); // PTX L1872
	g_RecordByteAddressAtPtx1873 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register174); // PTX L1873
	r_PtxRegister480 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1873 + 262144ull);		  // PTX L1874
	r_LaneIndexAtPtx1876 = uint32_t((threadIdx.x & 31u));									  // PTX L1876
	r_PtxRegister961 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1876), uint32_t(31));		  // PTX L1878
	r_PtxRegister962 = ShiftRight(uint32_t(r_PtxRegister961), uint32_t(30));				  // PTX L1879
	r_PtxRegister963 = uint32_t(r_LaneIndexAtPtx1876) + uint32_t(r_PtxRegister962);			  // PTX L1880
	r_PtxRegister964 = r_PtxRegister963 & 2147483644;										  // PTX L1881
	r_PtxRegister965 = uint32_t(r_LaneIndexAtPtx1876) - uint32_t(r_PtxRegister964);			  // PTX L1882
	r_PtxRegister966 = ShiftLeft(uint32_t(r_PtxRegister965), uint32_t(1));					  // PTX L1883
	r_PtxRegister967 = uint32_t(r_PtxRegister8) + uint32_t(r_PtxRegister966);				  // PTX L1884
	r_PtxRegister968 = ShiftRightSigned(int32_t(r_PtxRegister967), uint32_t(1));			  // PTX L1885
	r_PtxU64Register176 = uint64_t(int64_t(int32_t(r_PtxRegister968)) * int64_t(int32_t(4))); // PTX L1886
	g_RecordByteAddressAtPtx1887 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register176); // PTX L1887
	r_PtxRegister483 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1887 + 262144ull);		  // PTX L1888
	r_LaneIndexAtPtx1890 = uint32_t((threadIdx.x & 31u));									  // PTX L1890
	r_PtxRegister969 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1890), uint32_t(31));		  // PTX L1892
	r_PtxRegister970 = ShiftRight(uint32_t(r_PtxRegister969), uint32_t(30));				  // PTX L1893
	r_PtxRegister971 = uint32_t(r_LaneIndexAtPtx1890) + uint32_t(r_PtxRegister970);			  // PTX L1894
	r_PtxRegister972 = r_PtxRegister971 & 2147483644;										  // PTX L1895
	r_PtxRegister973 = uint32_t(r_LaneIndexAtPtx1890) - uint32_t(r_PtxRegister972);			  // PTX L1896
	r_PtxRegister974 = ShiftLeft(uint32_t(r_PtxRegister973), uint32_t(1));					  // PTX L1897
	r_PtxRegister975 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister974);				  // PTX L1898
	r_PtxRegister976 = ShiftRightSigned(int32_t(r_PtxRegister975), uint32_t(1));			  // PTX L1899
	r_PtxU64Register178 = uint64_t(int64_t(int32_t(r_PtxRegister976)) * int64_t(int32_t(4))); // PTX L1900
	g_RecordByteAddressAtPtx1901 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register178); // PTX L1901
	r_PtxRegister486 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1901 + 262144ull);		  // PTX L1902
	r_LaneIndexAtPtx1904 = uint32_t((threadIdx.x & 31u));									  // PTX L1904
	r_PtxRegister977 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1904), uint32_t(31));		  // PTX L1906
	r_PtxRegister978 = ShiftRight(uint32_t(r_PtxRegister977), uint32_t(30));				  // PTX L1907
	r_PtxRegister979 = uint32_t(r_LaneIndexAtPtx1904) + uint32_t(r_PtxRegister978);			  // PTX L1908
	r_PtxRegister980 = r_PtxRegister979 & 2147483644;										  // PTX L1909
	r_PtxRegister981 = uint32_t(r_LaneIndexAtPtx1904) - uint32_t(r_PtxRegister980);			  // PTX L1910
	r_PtxRegister982 = ShiftLeft(uint32_t(r_PtxRegister981), uint32_t(1));					  // PTX L1911
	r_PtxRegister983 = uint32_t(r_PtxRegister527) + uint32_t(r_PtxRegister982);				  // PTX L1912
	r_PtxRegister984 = ShiftRightSigned(int32_t(r_PtxRegister983), uint32_t(1));			  // PTX L1913
	r_PtxU64Register180 = uint64_t(int64_t(int32_t(r_PtxRegister984)) * int64_t(int32_t(4))); // PTX L1914
	g_RecordByteAddressAtPtx1915 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register180); // PTX L1915
	r_PtxRegister489 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1915 + 262144ull);		  // PTX L1916
	r_LaneIndexAtPtx1918 = uint32_t((threadIdx.x & 31u));									  // PTX L1918
	r_PtxRegister985 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1918), uint32_t(31));		  // PTX L1920
	r_PtxRegister986 = ShiftRight(uint32_t(r_PtxRegister985), uint32_t(30));				  // PTX L1921
	r_PtxRegister987 = uint32_t(r_LaneIndexAtPtx1918) + uint32_t(r_PtxRegister986);			  // PTX L1922
	r_PtxRegister988 = r_PtxRegister987 & 2147483644;										  // PTX L1923
	r_PtxRegister989 = uint32_t(r_LaneIndexAtPtx1918) - uint32_t(r_PtxRegister988);			  // PTX L1924
	r_PtxRegister990 = ShiftLeft(uint32_t(r_PtxRegister989), uint32_t(1));					  // PTX L1925
	r_PtxRegister991 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister990);				  // PTX L1926
	r_PtxRegister992 = ShiftRightSigned(int32_t(r_PtxRegister991), uint32_t(1));			  // PTX L1927
	r_PtxU64Register182 = uint64_t(int64_t(int32_t(r_PtxRegister992)) * int64_t(int32_t(4))); // PTX L1928
	g_RecordByteAddressAtPtx1929 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register182); // PTX L1929
	r_PtxRegister492 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1929 + 262144ull);		   // PTX L1930
	r_LaneIndexAtPtx1932 = uint32_t((threadIdx.x & 31u));									   // PTX L1932
	r_PtxRegister993 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1932), uint32_t(31));		   // PTX L1934
	r_PtxRegister994 = ShiftRight(uint32_t(r_PtxRegister993), uint32_t(30));				   // PTX L1935
	r_PtxRegister995 = uint32_t(r_LaneIndexAtPtx1932) + uint32_t(r_PtxRegister994);			   // PTX L1936
	r_PtxRegister996 = r_PtxRegister995 & 2147483644;										   // PTX L1937
	r_PtxRegister997 = uint32_t(r_LaneIndexAtPtx1932) - uint32_t(r_PtxRegister996);			   // PTX L1938
	r_PtxRegister998 = ShiftLeft(uint32_t(r_PtxRegister997), uint32_t(1));					   // PTX L1939
	r_PtxRegister999 = uint32_t(r_PtxRegister526) + uint32_t(r_PtxRegister998);				   // PTX L1940
	r_PtxRegister1000 = ShiftRightSigned(int32_t(r_PtxRegister999), uint32_t(1));			   // PTX L1941
	r_PtxU64Register184 = uint64_t(int64_t(int32_t(r_PtxRegister1000)) * int64_t(int32_t(4))); // PTX L1942
	g_RecordByteAddressAtPtx1943 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register184); // PTX L1943
	r_PtxRegister495 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1943 + 262144ull);		   // PTX L1944
	r_LaneIndexAtPtx1946 = uint32_t((threadIdx.x & 31u));									   // PTX L1946
	r_PtxRegister1001 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1946), uint32_t(31));		   // PTX L1948
	r_PtxRegister1002 = ShiftRight(uint32_t(r_PtxRegister1001), uint32_t(30));				   // PTX L1949
	r_PtxRegister1003 = uint32_t(r_LaneIndexAtPtx1946) + uint32_t(r_PtxRegister1002);		   // PTX L1950
	r_PtxRegister1004 = r_PtxRegister1003 & 2147483644;										   // PTX L1951
	r_PtxRegister1005 = uint32_t(r_LaneIndexAtPtx1946) - uint32_t(r_PtxRegister1004);		   // PTX L1952
	r_PtxRegister1006 = ShiftLeft(uint32_t(r_PtxRegister1005), uint32_t(1));				   // PTX L1953
	r_PtxRegister1007 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister1006);			   // PTX L1954
	r_PtxRegister1008 = ShiftRight(uint32_t(r_PtxRegister1007), uint32_t(31));				   // PTX L1955
	r_PtxRegister1009 = uint32_t(r_PtxRegister1007) + uint32_t(r_PtxRegister1008);			   // PTX L1956
	r_PtxRegister1010 = ShiftRightSigned(int32_t(r_PtxRegister1009), uint32_t(1));			   // PTX L1957
	r_PtxU64Register186 = uint64_t(int64_t(int32_t(r_PtxRegister1010)) * int64_t(int32_t(4))); // PTX L1958
	g_RecordByteAddressAtPtx1959 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register186); // PTX L1959
	r_PtxRegister498 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1959 + 262144ull);		   // PTX L1960
	r_LaneIndexAtPtx1962 = uint32_t((threadIdx.x & 31u));									   // PTX L1962
	r_PtxRegister1011 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1962), uint32_t(31));		   // PTX L1964
	r_PtxRegister1012 = ShiftRight(uint32_t(r_PtxRegister1011), uint32_t(30));				   // PTX L1965
	r_PtxRegister1013 = uint32_t(r_LaneIndexAtPtx1962) + uint32_t(r_PtxRegister1012);		   // PTX L1966
	r_PtxRegister1014 = r_PtxRegister1013 & 2147483644;										   // PTX L1967
	r_PtxRegister1015 = uint32_t(r_LaneIndexAtPtx1962) - uint32_t(r_PtxRegister1014);		   // PTX L1968
	r_PtxRegister1016 = ShiftLeft(uint32_t(r_PtxRegister1015), uint32_t(1));				   // PTX L1969
	r_PtxRegister1017 = uint32_t(r_PtxRegister582) + uint32_t(r_PtxRegister1016);			   // PTX L1970
	r_PtxRegister1018 = ShiftRight(uint32_t(r_PtxRegister1017), uint32_t(31));				   // PTX L1971
	r_PtxRegister1019 = uint32_t(r_PtxRegister1017) + uint32_t(r_PtxRegister1018);			   // PTX L1972
	r_PtxRegister1020 = ShiftRightSigned(int32_t(r_PtxRegister1019), uint32_t(1));			   // PTX L1973
	r_PtxU64Register188 = uint64_t(int64_t(int32_t(r_PtxRegister1020)) * int64_t(int32_t(4))); // PTX L1974
	g_RecordByteAddressAtPtx1975 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register188); // PTX L1975
	r_PtxRegister501 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1975 + 262144ull);		   // PTX L1976
	r_LaneIndexAtPtx1978 = uint32_t((threadIdx.x & 31u));									   // PTX L1978
	r_PtxRegister1021 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1978), uint32_t(31));		   // PTX L1980
	r_PtxRegister1022 = ShiftRight(uint32_t(r_PtxRegister1021), uint32_t(30));				   // PTX L1981
	r_PtxRegister1023 = uint32_t(r_LaneIndexAtPtx1978) + uint32_t(r_PtxRegister1022);		   // PTX L1982
	r_PtxRegister1024 = r_PtxRegister1023 & 2147483644;										   // PTX L1983
	r_PtxRegister1025 = uint32_t(r_LaneIndexAtPtx1978) - uint32_t(r_PtxRegister1024);		   // PTX L1984
	r_PtxRegister1026 = ShiftLeft(uint32_t(r_PtxRegister1025), uint32_t(1));				   // PTX L1985
	r_PtxRegister1027 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister1026);			   // PTX L1986
	r_PtxRegister1028 = ShiftRightSigned(int32_t(r_PtxRegister1027), uint32_t(1));			   // PTX L1987
	r_PtxU64Register190 = uint64_t(int64_t(int32_t(r_PtxRegister1028)) * int64_t(int32_t(4))); // PTX L1988
	g_RecordByteAddressAtPtx1989 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register190); // PTX L1989
	r_PtxRegister504 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1989 + 262144ull);		   // PTX L1990
	r_LaneIndexAtPtx1992 = uint32_t((threadIdx.x & 31u));									   // PTX L1992
	r_PtxRegister1029 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1992), uint32_t(31));		   // PTX L1994
	r_PtxRegister1030 = ShiftRight(uint32_t(r_PtxRegister1029), uint32_t(30));				   // PTX L1995
	r_PtxRegister1031 = uint32_t(r_LaneIndexAtPtx1992) + uint32_t(r_PtxRegister1030);		   // PTX L1996
	r_PtxRegister1032 = r_PtxRegister1031 & 2147483644;										   // PTX L1997
	r_PtxRegister1033 = uint32_t(r_LaneIndexAtPtx1992) - uint32_t(r_PtxRegister1032);		   // PTX L1998
	r_PtxRegister1034 = ShiftLeft(uint32_t(r_PtxRegister1033), uint32_t(1));				   // PTX L1999
	r_PtxRegister1035 = uint32_t(r_PtxRegister603) + uint32_t(r_PtxRegister1034);			   // PTX L2000
	r_PtxRegister1036 = ShiftRightSigned(int32_t(r_PtxRegister1035), uint32_t(1));			   // PTX L2001
	r_PtxU64Register192 = uint64_t(int64_t(int32_t(r_PtxRegister1036)) * int64_t(int32_t(4))); // PTX L2002
	g_RecordByteAddressAtPtx2003 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register192); // PTX L2003
	r_PtxRegister507 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2003 + 262144ull);		   // PTX L2004
	r_LaneIndexAtPtx2006 = uint32_t((threadIdx.x & 31u));									   // PTX L2006
	r_PtxRegister1037 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2006), uint32_t(31));		   // PTX L2008
	r_PtxRegister1038 = ShiftRight(uint32_t(r_PtxRegister1037), uint32_t(30));				   // PTX L2009
	r_PtxRegister1039 = uint32_t(r_LaneIndexAtPtx2006) + uint32_t(r_PtxRegister1038);		   // PTX L2010
	r_PtxRegister1040 = r_PtxRegister1039 & 2147483644;										   // PTX L2011
	r_PtxRegister1041 = uint32_t(r_LaneIndexAtPtx2006) - uint32_t(r_PtxRegister1040);		   // PTX L2012
	r_PtxRegister1042 = ShiftLeft(uint32_t(r_PtxRegister1041), uint32_t(1));				   // PTX L2013
	r_PtxRegister1043 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister1042);			   // PTX L2014
	r_PtxRegister1044 = ShiftRight(uint32_t(r_PtxRegister1043), uint32_t(31));				   // PTX L2015
	r_PtxRegister1045 = uint32_t(r_PtxRegister1043) + uint32_t(r_PtxRegister1044);			   // PTX L2016
	r_PtxRegister1046 = ShiftRightSigned(int32_t(r_PtxRegister1045), uint32_t(1));			   // PTX L2017
	r_PtxU64Register194 = uint64_t(int64_t(int32_t(r_PtxRegister1046)) * int64_t(int32_t(4))); // PTX L2018
	g_RecordByteAddressAtPtx2019 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register194); // PTX L2019
	r_PtxRegister510 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2019 + 262144ull);		   // PTX L2020
	r_LaneIndexAtPtx2022 = uint32_t((threadIdx.x & 31u));									   // PTX L2022
	r_PtxRegister1047 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2022), uint32_t(31));		   // PTX L2024
	r_PtxRegister1048 = ShiftRight(uint32_t(r_PtxRegister1047), uint32_t(30));				   // PTX L2025
	r_PtxRegister1049 = uint32_t(r_LaneIndexAtPtx2022) + uint32_t(r_PtxRegister1048);		   // PTX L2026
	r_PtxRegister1050 = r_PtxRegister1049 & 2147483644;										   // PTX L2027
	r_PtxRegister1051 = uint32_t(r_LaneIndexAtPtx2022) - uint32_t(r_PtxRegister1050);		   // PTX L2028
	r_PtxRegister1052 = ShiftLeft(uint32_t(r_PtxRegister1051), uint32_t(1));				   // PTX L2029
	r_PtxRegister1053 = uint32_t(r_PtxRegister620) + uint32_t(r_PtxRegister1052);			   // PTX L2030
	r_PtxRegister1054 = ShiftRight(uint32_t(r_PtxRegister1053), uint32_t(31));				   // PTX L2031
	r_PtxRegister1055 = uint32_t(r_PtxRegister1053) + uint32_t(r_PtxRegister1054);			   // PTX L2032
	r_PtxRegister1056 = ShiftRightSigned(int32_t(r_PtxRegister1055), uint32_t(1));			   // PTX L2033
	r_PtxU64Register196 = uint64_t(int64_t(int32_t(r_PtxRegister1056)) * int64_t(int32_t(4))); // PTX L2034
	g_RecordByteAddressAtPtx2035 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register196); // PTX L2035
	r_PtxRegister513 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2035 + 262144ull);		   // PTX L2036
	r_LaneIndexAtPtx2038 = uint32_t((threadIdx.x & 31u));									   // PTX L2038
	r_PtxRegister1057 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2038), uint32_t(31));		   // PTX L2040
	r_PtxRegister1058 = ShiftRight(uint32_t(r_PtxRegister1057), uint32_t(30));				   // PTX L2041
	r_PtxRegister1059 = uint32_t(r_LaneIndexAtPtx2038) + uint32_t(r_PtxRegister1058);		   // PTX L2042
	r_PtxRegister1060 = r_PtxRegister1059 & 2147483644;										   // PTX L2043
	r_PtxRegister1061 = uint32_t(r_LaneIndexAtPtx2038) - uint32_t(r_PtxRegister1060);		   // PTX L2044
	r_PtxRegister1062 = ShiftLeft(uint32_t(r_PtxRegister1061), uint32_t(1));				   // PTX L2045
	r_PtxRegister1063 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister1062);			   // PTX L2046
	r_PtxRegister1064 = ShiftRightSigned(int32_t(r_PtxRegister1063), uint32_t(1));			   // PTX L2047
	r_PtxU64Register198 = uint64_t(int64_t(int32_t(r_PtxRegister1064)) * int64_t(int32_t(4))); // PTX L2048
	g_RecordByteAddressAtPtx2049 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register198); // PTX L2049
	r_PtxRegister516 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2049 + 262144ull);		   // PTX L2050
	r_LaneIndexAtPtx2052 = uint32_t((threadIdx.x & 31u));									   // PTX L2052
	r_PtxRegister1065 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2052), uint32_t(31));		   // PTX L2054
	r_PtxRegister1066 = ShiftRight(uint32_t(r_PtxRegister1065), uint32_t(30));				   // PTX L2055
	r_PtxRegister1067 = uint32_t(r_LaneIndexAtPtx2052) + uint32_t(r_PtxRegister1066);		   // PTX L2056
	r_PtxRegister1068 = r_PtxRegister1067 & 2147483644;										   // PTX L2057
	r_PtxRegister1069 = uint32_t(r_LaneIndexAtPtx2052) - uint32_t(r_PtxRegister1068);		   // PTX L2058
	r_PtxRegister1070 = ShiftLeft(uint32_t(r_PtxRegister1069), uint32_t(1));				   // PTX L2059
	r_PtxRegister1071 = uint32_t(r_PtxRegister641) + uint32_t(r_PtxRegister1070);			   // PTX L2060
	r_PtxRegister1072 = ShiftRightSigned(int32_t(r_PtxRegister1071), uint32_t(1));			   // PTX L2061
	r_PtxU64Register200 = uint64_t(int64_t(int32_t(r_PtxRegister1072)) * int64_t(int32_t(4))); // PTX L2062
	g_RecordByteAddressAtPtx2063 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register200); // PTX L2063
	r_PtxRegister519 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2063 + 262144ull);		   // PTX L2064
	r_LaneIndexAtPtx2066 = uint32_t((threadIdx.x & 31u));									   // PTX L2066
	r_PtxRegister1073 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2066), uint32_t(31));		   // PTX L2068
	r_PtxRegister1074 = ShiftRight(uint32_t(r_PtxRegister1073), uint32_t(30));				   // PTX L2069
	r_PtxRegister1075 = uint32_t(r_LaneIndexAtPtx2066) + uint32_t(r_PtxRegister1074);		   // PTX L2070
	r_PtxRegister1076 = r_PtxRegister1075 & 2147483644;										   // PTX L2071
	r_PtxRegister1077 = uint32_t(r_LaneIndexAtPtx2066) - uint32_t(r_PtxRegister1076);		   // PTX L2072
	r_PtxRegister1078 = ShiftLeft(uint32_t(r_PtxRegister1077), uint32_t(1));				   // PTX L2073
	r_PtxRegister1079 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister1078);			   // PTX L2074
	r_PtxRegister1080 = ShiftRight(uint32_t(r_PtxRegister1079), uint32_t(31));				   // PTX L2075
	r_PtxRegister1081 = uint32_t(r_PtxRegister1079) + uint32_t(r_PtxRegister1080);			   // PTX L2076
	r_PtxRegister1082 = ShiftRightSigned(int32_t(r_PtxRegister1081), uint32_t(1));			   // PTX L2077
	r_PtxU64Register202 = uint64_t(int64_t(int32_t(r_PtxRegister1082)) * int64_t(int32_t(4))); // PTX L2078
	g_RecordByteAddressAtPtx2079 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register202); // PTX L2079
	r_PtxRegister522 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2079 + 262144ull);		   // PTX L2080
	r_LaneIndexAtPtx2082 = uint32_t((threadIdx.x & 31u));									   // PTX L2082
	r_PtxRegister1083 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2082), uint32_t(31));		   // PTX L2084
	r_PtxRegister1084 = ShiftRight(uint32_t(r_PtxRegister1083), uint32_t(30));				   // PTX L2085
	r_PtxRegister1085 = uint32_t(r_LaneIndexAtPtx2082) + uint32_t(r_PtxRegister1084);		   // PTX L2086
	r_PtxRegister1086 = r_PtxRegister1085 & 2147483644;										   // PTX L2087
	r_PtxRegister1087 = uint32_t(r_LaneIndexAtPtx2082) - uint32_t(r_PtxRegister1086);		   // PTX L2088
	r_PtxRegister1088 = ShiftLeft(uint32_t(r_PtxRegister1087), uint32_t(1));				   // PTX L2089
	r_PtxRegister1089 = uint32_t(r_PtxRegister658) + uint32_t(r_PtxRegister1088);			   // PTX L2090
	r_PtxRegister1090 = ShiftRight(uint32_t(r_PtxRegister1089), uint32_t(31));				   // PTX L2091
	r_PtxRegister1091 = uint32_t(r_PtxRegister1089) + uint32_t(r_PtxRegister1090);			   // PTX L2092
	r_PtxRegister1092 = ShiftRightSigned(int32_t(r_PtxRegister1091), uint32_t(1));			   // PTX L2093
	r_PtxU64Register204 = uint64_t(int64_t(int32_t(r_PtxRegister1092)) * int64_t(int32_t(4))); // PTX L2094
	g_RecordByteAddressAtPtx2095 =
		uint64_t(g_RecordByteAddressAtPtx1145) + uint64_t(r_PtxU64Register204); // PTX L2095
	r_PtxRegister525 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx2095 + 262144ull);	 // PTX L2096
	r_LaneIndexAtPtx2098 = uint32_t((threadIdx.x & 31u));								 // PTX L2098
	r_PackedHalf2AtPtx2101R1453 = HalfMul(r_PackedHalf2AtPtx950R335, r_PtxRegister336);	 // PTX L2101
	r_LaneIndexAtPtx2105 = uint32_t((threadIdx.x & 31u));								 // PTX L2105
	r_PackedHalf2AtPtx2108R1452 = HalfMul(r_PackedHalf2AtPtx956R338, r_PtxRegister339);	 // PTX L2108
	r_LaneIndexAtPtx2112 = uint32_t((threadIdx.x & 31u));								 // PTX L2112
	r_PackedHalf2AtPtx2115R1451 = HalfMul(r_PackedHalf2AtPtx953R341, r_PtxRegister342);	 // PTX L2115
	r_LaneIndexAtPtx2119 = uint32_t((threadIdx.x & 31u));								 // PTX L2119
	r_PackedHalf2AtPtx2122R1450 = HalfMul(r_PackedHalf2AtPtx959R344, r_PtxRegister345);	 // PTX L2122
	r_LaneIndexAtPtx2126 = uint32_t((threadIdx.x & 31u));								 // PTX L2126
	r_PackedHalf2AtPtx2129R1449 = HalfMul(r_PackedHalf2AtPtx962R347, r_PtxRegister348);	 // PTX L2129
	r_LaneIndexAtPtx2133 = uint32_t((threadIdx.x & 31u));								 // PTX L2133
	r_PackedHalf2AtPtx2136R1448 = HalfMul(r_PackedHalf2AtPtx968R350, r_PtxRegister351);	 // PTX L2136
	r_LaneIndexAtPtx2140 = uint32_t((threadIdx.x & 31u));								 // PTX L2140
	r_PackedHalf2AtPtx2143R1447 = HalfMul(r_PackedHalf2AtPtx965R353, r_PtxRegister354);	 // PTX L2143
	r_LaneIndexAtPtx2147 = uint32_t((threadIdx.x & 31u));								 // PTX L2147
	r_PackedHalf2AtPtx2150R1446 = HalfMul(r_PackedHalf2AtPtx971R356, r_PtxRegister357);	 // PTX L2150
	r_LaneIndexAtPtx2154 = uint32_t((threadIdx.x & 31u));								 // PTX L2154
	r_PackedHalf2AtPtx2157R1445 = HalfMul(r_PackedHalf2AtPtx974R359, r_PtxRegister360);	 // PTX L2157
	r_LaneIndexAtPtx2161 = uint32_t((threadIdx.x & 31u));								 // PTX L2161
	r_PackedHalf2AtPtx2164R1444 = HalfMul(r_PackedHalf2AtPtx980R362, r_PtxRegister363);	 // PTX L2164
	r_LaneIndexAtPtx2168 = uint32_t((threadIdx.x & 31u));								 // PTX L2168
	r_PackedHalf2AtPtx2171R1443 = HalfMul(r_PackedHalf2AtPtx977R365, r_PtxRegister366);	 // PTX L2171
	r_LaneIndexAtPtx2175 = uint32_t((threadIdx.x & 31u));								 // PTX L2175
	r_PackedHalf2AtPtx2178R1442 = HalfMul(r_PackedHalf2AtPtx983R368, r_PtxRegister369);	 // PTX L2178
	r_LaneIndexAtPtx2182 = uint32_t((threadIdx.x & 31u));								 // PTX L2182
	r_PackedHalf2AtPtx2185R1441 = HalfMul(r_PackedHalf2AtPtx986R371, r_PtxRegister372);	 // PTX L2185
	r_LaneIndexAtPtx2189 = uint32_t((threadIdx.x & 31u));								 // PTX L2189
	r_PackedHalf2AtPtx2192R1440 = HalfMul(r_PackedHalf2AtPtx992R374, r_PtxRegister375);	 // PTX L2192
	r_LaneIndexAtPtx2196 = uint32_t((threadIdx.x & 31u));								 // PTX L2196
	r_PackedHalf2AtPtx2199R1439 = HalfMul(r_PackedHalf2AtPtx989R377, r_PtxRegister378);	 // PTX L2199
	r_LaneIndexAtPtx2203 = uint32_t((threadIdx.x & 31u));								 // PTX L2203
	r_PackedHalf2AtPtx2206R1438 = HalfMul(r_PackedHalf2AtPtx995R380, r_PtxRegister381);	 // PTX L2206
	r_LaneIndexAtPtx2210 = uint32_t((threadIdx.x & 31u));								 // PTX L2210
	r_PackedHalf2AtPtx2213R1437 = HalfMul(r_PackedHalf2AtPtx998R383, r_PtxRegister384);	 // PTX L2213
	r_LaneIndexAtPtx2217 = uint32_t((threadIdx.x & 31u));								 // PTX L2217
	r_PackedHalf2AtPtx2220R1436 = HalfMul(r_PackedHalf2AtPtx1004R386, r_PtxRegister387); // PTX L2220
	r_LaneIndexAtPtx2224 = uint32_t((threadIdx.x & 31u));								 // PTX L2224
	r_PackedHalf2AtPtx2227R1435 = HalfMul(r_PackedHalf2AtPtx1001R389, r_PtxRegister390); // PTX L2227
	r_LaneIndexAtPtx2231 = uint32_t((threadIdx.x & 31u));								 // PTX L2231
	r_PackedHalf2AtPtx2234R1434 = HalfMul(r_PackedHalf2AtPtx1007R392, r_PtxRegister393); // PTX L2234
	r_LaneIndexAtPtx2238 = uint32_t((threadIdx.x & 31u));								 // PTX L2238
	r_PackedHalf2AtPtx2241R1433 = HalfMul(r_PackedHalf2AtPtx1010R395, r_PtxRegister396); // PTX L2241
	r_LaneIndexAtPtx2245 = uint32_t((threadIdx.x & 31u));								 // PTX L2245
	r_PackedHalf2AtPtx2248R1432 = HalfMul(r_PackedHalf2AtPtx1016R398, r_PtxRegister399); // PTX L2248
	r_LaneIndexAtPtx2252 = uint32_t((threadIdx.x & 31u));								 // PTX L2252
	r_PackedHalf2AtPtx2255R1431 = HalfMul(r_PackedHalf2AtPtx1013R401, r_PtxRegister402); // PTX L2255
	r_LaneIndexAtPtx2259 = uint32_t((threadIdx.x & 31u));								 // PTX L2259
	r_PackedHalf2AtPtx2262R1430 = HalfMul(r_PackedHalf2AtPtx1019R404, r_PtxRegister405); // PTX L2262
	r_LaneIndexAtPtx2266 = uint32_t((threadIdx.x & 31u));								 // PTX L2266
	r_PackedHalf2AtPtx2269R1429 = HalfMul(r_PackedHalf2AtPtx1022R407, r_PtxRegister408); // PTX L2269
	r_LaneIndexAtPtx2273 = uint32_t((threadIdx.x & 31u));								 // PTX L2273
	r_PackedHalf2AtPtx2276R1428 = HalfMul(r_PackedHalf2AtPtx1028R410, r_PtxRegister411); // PTX L2276
	r_LaneIndexAtPtx2280 = uint32_t((threadIdx.x & 31u));								 // PTX L2280
	r_PackedHalf2AtPtx2283R1427 = HalfMul(r_PackedHalf2AtPtx1025R413, r_PtxRegister414); // PTX L2283
	r_LaneIndexAtPtx2287 = uint32_t((threadIdx.x & 31u));								 // PTX L2287
	r_PackedHalf2AtPtx2290R1426 = HalfMul(r_PackedHalf2AtPtx1031R416, r_PtxRegister417); // PTX L2290
	r_LaneIndexAtPtx2294 = uint32_t((threadIdx.x & 31u));								 // PTX L2294
	r_PackedHalf2AtPtx2297R1425 = HalfMul(r_PackedHalf2AtPtx1034R419, r_PtxRegister420); // PTX L2297
	r_LaneIndexAtPtx2301 = uint32_t((threadIdx.x & 31u));								 // PTX L2301
	r_PackedHalf2AtPtx2304R1424 = HalfMul(r_PackedHalf2AtPtx1040R422, r_PtxRegister423); // PTX L2304
	r_LaneIndexAtPtx2308 = uint32_t((threadIdx.x & 31u));								 // PTX L2308
	r_PackedHalf2AtPtx2311R1423 = HalfMul(r_PackedHalf2AtPtx1037R425, r_PtxRegister426); // PTX L2311
	r_LaneIndexAtPtx2315 = uint32_t((threadIdx.x & 31u));								 // PTX L2315
	r_PackedHalf2AtPtx2318R1422 = HalfMul(r_PackedHalf2AtPtx1043R428, r_PtxRegister429); // PTX L2318
	r_LaneIndexAtPtx2322 = uint32_t((threadIdx.x & 31u));								 // PTX L2322
	r_PackedHalf2AtPtx2325R1421 = HalfMul(r_PackedHalf2AtPtx1046R431, r_PtxRegister432); // PTX L2325
	r_LaneIndexAtPtx2329 = uint32_t((threadIdx.x & 31u));								 // PTX L2329
	r_PackedHalf2AtPtx2332R1420 = HalfMul(r_PackedHalf2AtPtx1052R434, r_PtxRegister435); // PTX L2332
	r_LaneIndexAtPtx2336 = uint32_t((threadIdx.x & 31u));								 // PTX L2336
	r_PackedHalf2AtPtx2339R1419 = HalfMul(r_PackedHalf2AtPtx1049R437, r_PtxRegister438); // PTX L2339
	r_LaneIndexAtPtx2343 = uint32_t((threadIdx.x & 31u));								 // PTX L2343
	r_PackedHalf2AtPtx2346R1418 = HalfMul(r_PackedHalf2AtPtx1055R440, r_PtxRegister441); // PTX L2346
	r_LaneIndexAtPtx2350 = uint32_t((threadIdx.x & 31u));								 // PTX L2350
	r_PackedHalf2AtPtx2353R1417 = HalfMul(r_PackedHalf2AtPtx1058R443, r_PtxRegister444); // PTX L2353
	r_LaneIndexAtPtx2357 = uint32_t((threadIdx.x & 31u));								 // PTX L2357
	r_PackedHalf2AtPtx2360R1416 = HalfMul(r_PackedHalf2AtPtx1064R446, r_PtxRegister447); // PTX L2360
	r_LaneIndexAtPtx2364 = uint32_t((threadIdx.x & 31u));								 // PTX L2364
	r_PackedHalf2AtPtx2367R1415 = HalfMul(r_PackedHalf2AtPtx1061R449, r_PtxRegister450); // PTX L2367
	r_LaneIndexAtPtx2371 = uint32_t((threadIdx.x & 31u));								 // PTX L2371
	r_PackedHalf2AtPtx2374R1414 = HalfMul(r_PackedHalf2AtPtx1067R452, r_PtxRegister453); // PTX L2374
	r_LaneIndexAtPtx2378 = uint32_t((threadIdx.x & 31u));								 // PTX L2378
	r_PackedHalf2AtPtx2381R1413 = HalfMul(r_PackedHalf2AtPtx1070R455, r_PtxRegister456); // PTX L2381
	r_LaneIndexAtPtx2385 = uint32_t((threadIdx.x & 31u));								 // PTX L2385
	r_PackedHalf2AtPtx2388R1412 = HalfMul(r_PackedHalf2AtPtx1076R458, r_PtxRegister459); // PTX L2388
	r_LaneIndexAtPtx2392 = uint32_t((threadIdx.x & 31u));								 // PTX L2392
	r_PackedHalf2AtPtx2395R1411 = HalfMul(r_PackedHalf2AtPtx1073R461, r_PtxRegister462); // PTX L2395
	r_LaneIndexAtPtx2399 = uint32_t((threadIdx.x & 31u));								 // PTX L2399
	r_PackedHalf2AtPtx2402R1410 = HalfMul(r_PackedHalf2AtPtx1079R464, r_PtxRegister465); // PTX L2402
	r_LaneIndexAtPtx2406 = uint32_t((threadIdx.x & 31u));								 // PTX L2406
	r_PackedHalf2AtPtx2409R1409 = HalfMul(r_PackedHalf2AtPtx1082R467, r_PtxRegister468); // PTX L2409
	r_LaneIndexAtPtx2413 = uint32_t((threadIdx.x & 31u));								 // PTX L2413
	r_PackedHalf2AtPtx2416R1408 = HalfMul(r_PackedHalf2AtPtx1088R470, r_PtxRegister471); // PTX L2416
	r_LaneIndexAtPtx2420 = uint32_t((threadIdx.x & 31u));								 // PTX L2420
	r_PackedHalf2AtPtx2423R1407 = HalfMul(r_PackedHalf2AtPtx1085R473, r_PtxRegister474); // PTX L2423
	r_LaneIndexAtPtx2427 = uint32_t((threadIdx.x & 31u));								 // PTX L2427
	r_PackedHalf2AtPtx2430R1406 = HalfMul(r_PackedHalf2AtPtx1091R476, r_PtxRegister477); // PTX L2430
	r_LaneIndexAtPtx2434 = uint32_t((threadIdx.x & 31u));								 // PTX L2434
	r_PackedHalf2AtPtx2437R1405 = HalfMul(r_PackedHalf2AtPtx1094R479, r_PtxRegister480); // PTX L2437
	r_LaneIndexAtPtx2441 = uint32_t((threadIdx.x & 31u));								 // PTX L2441
	r_PackedHalf2AtPtx2444R1404 = HalfMul(r_PackedHalf2AtPtx1100R482, r_PtxRegister483); // PTX L2444
	r_LaneIndexAtPtx2448 = uint32_t((threadIdx.x & 31u));								 // PTX L2448
	r_PackedHalf2AtPtx2451R1403 = HalfMul(r_PackedHalf2AtPtx1097R485, r_PtxRegister486); // PTX L2451
	r_LaneIndexAtPtx2455 = uint32_t((threadIdx.x & 31u));								 // PTX L2455
	r_PackedHalf2AtPtx2458R1402 = HalfMul(r_PackedHalf2AtPtx1103R488, r_PtxRegister489); // PTX L2458
	r_LaneIndexAtPtx2462 = uint32_t((threadIdx.x & 31u));								 // PTX L2462
	r_PackedHalf2AtPtx2465R1401 = HalfMul(r_PackedHalf2AtPtx1106R491, r_PtxRegister492); // PTX L2465
	r_LaneIndexAtPtx2469 = uint32_t((threadIdx.x & 31u));								 // PTX L2469
	r_PackedHalf2AtPtx2472R1400 = HalfMul(r_PackedHalf2AtPtx1112R494, r_PtxRegister495); // PTX L2472
	r_LaneIndexAtPtx2476 = uint32_t((threadIdx.x & 31u));								 // PTX L2476
	r_PackedHalf2AtPtx2479R1399 = HalfMul(r_PackedHalf2AtPtx1109R497, r_PtxRegister498); // PTX L2479
	r_LaneIndexAtPtx2483 = uint32_t((threadIdx.x & 31u));								 // PTX L2483
	r_PackedHalf2AtPtx2486R1398 = HalfMul(r_PackedHalf2AtPtx1115R500, r_PtxRegister501); // PTX L2486
	r_LaneIndexAtPtx2490 = uint32_t((threadIdx.x & 31u));								 // PTX L2490
	r_PackedHalf2AtPtx2493R1397 = HalfMul(r_PackedHalf2AtPtx1119R503, r_PtxRegister504); // PTX L2493
	r_LaneIndexAtPtx2497 = uint32_t((threadIdx.x & 31u));								 // PTX L2497
	r_PackedHalf2AtPtx2500R1396 = HalfMul(r_PackedHalf2AtPtx1126R506, r_PtxRegister507); // PTX L2500
	r_LaneIndexAtPtx2504 = uint32_t((threadIdx.x & 31u));								 // PTX L2504
	r_PackedHalf2AtPtx2507R1395 = HalfMul(r_PackedHalf2AtPtx1122R509, r_PtxRegister510); // PTX L2507
	r_LaneIndexAtPtx2511 = uint32_t((threadIdx.x & 31u));								 // PTX L2511
	r_PackedHalf2AtPtx2514R1394 = HalfMul(r_PackedHalf2AtPtx1129R512, r_PtxRegister513); // PTX L2514
	r_LaneIndexAtPtx2518 = uint32_t((threadIdx.x & 31u));								 // PTX L2518
	r_PackedHalf2AtPtx2521R1393 = HalfMul(r_PackedHalf2AtPtx1133R515, r_PtxRegister516); // PTX L2521
	r_LaneIndexAtPtx2525 = uint32_t((threadIdx.x & 31u));								 // PTX L2525
	r_PackedHalf2AtPtx2528R1392 = HalfMul(r_PackedHalf2AtPtx1140R518, r_PtxRegister519); // PTX L2528
	r_LaneIndexAtPtx2532 = uint32_t((threadIdx.x & 31u));								 // PTX L2532
	r_PackedHalf2AtPtx2535R1454 = HalfMul(r_PackedHalf2AtPtx1136R521, r_PtxRegister522); // PTX L2535
	r_LaneIndexAtPtx2539 = uint32_t((threadIdx.x & 31u));								 // PTX L2539
	r_PackedHalf2AtPtx2542R1455 = HalfMul(r_PackedHalf2AtPtx1143R524, r_PtxRegister525); // PTX L2542
	r_PtxRegister1456 = uint32_t(0);													 // PTX L2545
L__BB13_95:																				 // PTX L2546
	r_PtxRegister1205 = ShiftRight(uint32_t(r_PtxRegister1456), uint32_t(6));			 // PTX L2547
	r_PtxU16Register93 = uint16_t(r_PtxRegister1205);									 // PTX L2548
	r_PtxU16Register94 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register93)) * uint32_t(uint16_t(171))); // PTX L2549
	r_PtxU16Register95 = ShiftRight(uint16_t(r_PtxU16Register94), uint32_t(9));		// PTX L2550
	r_PtxU16Register96 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register95)) * uint32_t(uint16_t(3)));		   // PTX L2551
	r_PtxU16Register97 = uint16_t(r_PtxU16Register93) - uint16_t(r_PtxU16Register96);	   // PTX L2552
	r_PtxRegister1206 = uint32_t(uint16_t(r_PtxU16Register97));							   // PTX L2553
	r_PtxRegister32 = r_PtxRegister1206 & 255;											   // PTX L2554
	r_PtxU16Register98 = r_PtxU16Register97 & 255;										   // PTX L2555
	r_PtxRegister1207 = uint32_t(uint16_t(r_PtxU16Register98)) * uint32_t(uint16_t(4096)); // PTX L2556
	r_LaneIndexAtPtx2558 = uint32_t((threadIdx.x & 31u));								   // PTX L2558
	r_PtxRegister1208 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L2560
	r_PtxRegister33 = uint32_t(r_PtxRegister1208) + uint32_t(r_PtxRegister1207);		   // PTX L2561
	r_PtxRegister1209 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2558), uint32_t(4));			   // PTX L2562
	r_PtxRegister1094 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1209);		   // PTX L2563
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1094));
		r_MmaAE4x4WordAtPtx2565R1109 = r_Value.x;
		r_MmaAE4x4WordAtPtx2565R1110 = r_Value.y;
		r_MmaAE4x4WordAtPtx2565R1111 = r_Value.z;
		r_MmaAE4x4WordAtPtx2565R1112 = r_Value.w;
	} // PTX L2565
	r_LaneIndexAtPtx2568 = uint32_t((threadIdx.x & 31u));						 // PTX L2568
	r_PtxRegister1210 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2568), uint32_t(4));	 // PTX L2570
	r_PtxRegister1211 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1210); // PTX L2571
	r_PtxRegister1096 = uint32_t(r_PtxRegister1211) + uint32_t(512);			 // PTX L2572
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1096));
		r_MmaAE4x4WordAtPtx2574R1113 = r_Value.x;
		r_MmaAE4x4WordAtPtx2574R1114 = r_Value.y;
		r_MmaAE4x4WordAtPtx2574R1115 = r_Value.z;
		r_MmaAE4x4WordAtPtx2574R1116 = r_Value.w;
	} // PTX L2574
	r_LaneIndexAtPtx2577 = uint32_t((threadIdx.x & 31u));						 // PTX L2577
	r_PtxRegister1212 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2577), uint32_t(4));	 // PTX L2579
	r_PtxRegister1213 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1212); // PTX L2580
	r_PtxRegister1098 = uint32_t(r_PtxRegister1213) + uint32_t(1024);			 // PTX L2581
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1098));
		r_MmaAE4x4WordAtPtx2583R1133 = r_Value.x;
		r_MmaAE4x4WordAtPtx2583R1134 = r_Value.y;
		r_MmaAE4x4WordAtPtx2583R1135 = r_Value.z;
		r_MmaAE4x4WordAtPtx2583R1136 = r_Value.w;
	} // PTX L2583
	r_LaneIndexAtPtx2586 = uint32_t((threadIdx.x & 31u));						 // PTX L2586
	r_PtxRegister1214 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2586), uint32_t(4));	 // PTX L2588
	r_PtxRegister1215 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1214); // PTX L2589
	r_PtxRegister1100 = uint32_t(r_PtxRegister1215) + uint32_t(1536);			 // PTX L2590
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1100));
		r_MmaAE4x4WordAtPtx2592R1137 = r_Value.x;
		r_MmaAE4x4WordAtPtx2592R1138 = r_Value.y;
		r_MmaAE4x4WordAtPtx2592R1139 = r_Value.z;
		r_MmaAE4x4WordAtPtx2592R1140 = r_Value.w;
	} // PTX L2592
	r_LaneIndexAtPtx2595 = uint32_t((threadIdx.x & 31u));						 // PTX L2595
	r_PtxRegister1216 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2595), uint32_t(4));	 // PTX L2597
	r_PtxRegister1217 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1216); // PTX L2598
	r_PtxRegister1102 = uint32_t(r_PtxRegister1217) + uint32_t(2048);			 // PTX L2599
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1102));
		r_MmaAE4x4WordAtPtx2601R1157 = r_Value.x;
		r_MmaAE4x4WordAtPtx2601R1158 = r_Value.y;
		r_MmaAE4x4WordAtPtx2601R1159 = r_Value.z;
		r_MmaAE4x4WordAtPtx2601R1160 = r_Value.w;
	} // PTX L2601
	r_LaneIndexAtPtx2604 = uint32_t((threadIdx.x & 31u));						 // PTX L2604
	r_PtxRegister1218 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2604), uint32_t(4));	 // PTX L2606
	r_PtxRegister1219 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1218); // PTX L2607
	r_PtxRegister1104 = uint32_t(r_PtxRegister1219) + uint32_t(2560);			 // PTX L2608
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1104));
		r_MmaAE4x4WordAtPtx2610R1161 = r_Value.x;
		r_MmaAE4x4WordAtPtx2610R1162 = r_Value.y;
		r_MmaAE4x4WordAtPtx2610R1163 = r_Value.z;
		r_MmaAE4x4WordAtPtx2610R1164 = r_Value.w;
	} // PTX L2610
	r_LaneIndexAtPtx2613 = uint32_t((threadIdx.x & 31u));						 // PTX L2613
	r_PtxRegister1220 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2613), uint32_t(4));	 // PTX L2615
	r_PtxRegister1221 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1220); // PTX L2616
	r_PtxRegister1106 = uint32_t(r_PtxRegister1221) + uint32_t(3072);			 // PTX L2617
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1106));
		r_MmaAE4x4WordAtPtx2619R1181 = r_Value.x;
		r_MmaAE4x4WordAtPtx2619R1182 = r_Value.y;
		r_MmaAE4x4WordAtPtx2619R1183 = r_Value.z;
		r_MmaAE4x4WordAtPtx2619R1184 = r_Value.w;
	} // PTX L2619
	r_LaneIndexAtPtx2622 = uint32_t((threadIdx.x & 31u));						 // PTX L2622
	r_PtxRegister1222 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2622), uint32_t(4));	 // PTX L2624
	r_PtxRegister1223 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1222); // PTX L2625
	r_PtxRegister1108 = uint32_t(r_PtxRegister1223) + uint32_t(3584);			 // PTX L2626
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1108));
		r_MmaAE4x4WordAtPtx2628R1185 = r_Value.x;
		r_MmaAE4x4WordAtPtx2628R1186 = r_Value.y;
		r_MmaAE4x4WordAtPtx2628R1187 = r_Value.z;
		r_MmaAE4x4WordAtPtx2628R1188 = r_Value.w;
	} // PTX L2628
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2631R1117, r_MmaAccumulatorHalf2WordAtPtx2631R1118,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx77R1488, r_MmaBE4x4WordAtPtx77R1487,
		  r_PackedHalf2AtPtx2101R1453,
		  r_PackedHalf2AtPtx2108R1452); // PTX L2631
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2638R1119, r_MmaAccumulatorHalf2WordAtPtx2638R1120,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx77R1486, r_MmaBE4x4WordAtPtx77R1485,
		  r_PackedHalf2AtPtx2115R1451,
		  r_PackedHalf2AtPtx2122R1450); // PTX L2638
	MmaE4(r_PackedHalf2AtPtx2101R1453, r_PackedHalf2AtPtx2108R1452, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx114R1472, r_MmaBE4x4WordAtPtx114R1471, r_MmaAccumulatorHalf2WordAtPtx2631R1117,
		  r_MmaAccumulatorHalf2WordAtPtx2631R1118); // PTX L2645
	MmaE4(r_PackedHalf2AtPtx2115R1451, r_PackedHalf2AtPtx2122R1450, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx114R1470, r_MmaBE4x4WordAtPtx114R1469, r_MmaAccumulatorHalf2WordAtPtx2638R1119,
		  r_MmaAccumulatorHalf2WordAtPtx2638R1120); // PTX L2652
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2659R1121, r_MmaAccumulatorHalf2WordAtPtx2659R1122,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx86R1484, r_MmaBE4x4WordAtPtx86R1483,
		  r_PackedHalf2AtPtx2129R1449,
		  r_PackedHalf2AtPtx2136R1448); // PTX L2659
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2666R1123, r_MmaAccumulatorHalf2WordAtPtx2666R1124,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx86R1482, r_MmaBE4x4WordAtPtx86R1481,
		  r_PackedHalf2AtPtx2143R1447,
		  r_PackedHalf2AtPtx2150R1446); // PTX L2666
	MmaE4(r_PackedHalf2AtPtx2129R1449, r_PackedHalf2AtPtx2136R1448, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx123R1468, r_MmaBE4x4WordAtPtx123R1467, r_MmaAccumulatorHalf2WordAtPtx2659R1121,
		  r_MmaAccumulatorHalf2WordAtPtx2659R1122); // PTX L2673
	MmaE4(r_PackedHalf2AtPtx2143R1447, r_PackedHalf2AtPtx2150R1446, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx123R1466, r_MmaBE4x4WordAtPtx123R1465, r_MmaAccumulatorHalf2WordAtPtx2666R1123,
		  r_MmaAccumulatorHalf2WordAtPtx2666R1124); // PTX L2680
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2687R1125, r_MmaAccumulatorHalf2WordAtPtx2687R1126,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx96R1480, r_MmaBE4x4WordAtPtx96R1479,
		  r_PackedHalf2AtPtx2157R1445,
		  r_PackedHalf2AtPtx2164R1444); // PTX L2687
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2694R1127, r_MmaAccumulatorHalf2WordAtPtx2694R1128,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx96R1478, r_MmaBE4x4WordAtPtx96R1477,
		  r_PackedHalf2AtPtx2171R1443,
		  r_PackedHalf2AtPtx2178R1442); // PTX L2694
	MmaE4(r_PackedHalf2AtPtx2157R1445, r_PackedHalf2AtPtx2164R1444, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx132R1464, r_MmaBE4x4WordAtPtx132R1463, r_MmaAccumulatorHalf2WordAtPtx2687R1125,
		  r_MmaAccumulatorHalf2WordAtPtx2687R1126); // PTX L2701
	MmaE4(r_PackedHalf2AtPtx2171R1443, r_PackedHalf2AtPtx2178R1442, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx132R1462, r_MmaBE4x4WordAtPtx132R1461, r_MmaAccumulatorHalf2WordAtPtx2694R1127,
		  r_MmaAccumulatorHalf2WordAtPtx2694R1128); // PTX L2708
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2715R1129, r_MmaAccumulatorHalf2WordAtPtx2715R1130,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx105R1476, r_MmaBE4x4WordAtPtx105R1475,
		  r_PackedHalf2AtPtx2185R1441,
		  r_PackedHalf2AtPtx2192R1440); // PTX L2715
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2722R1131, r_MmaAccumulatorHalf2WordAtPtx2722R1132,
		  r_MmaAE4x4WordAtPtx2565R1109, r_MmaAE4x4WordAtPtx2565R1110, r_MmaAE4x4WordAtPtx2565R1111,
		  r_MmaAE4x4WordAtPtx2565R1112, r_MmaBE4x4WordAtPtx105R1474, r_MmaBE4x4WordAtPtx105R1473,
		  r_PackedHalf2AtPtx2199R1439,
		  r_PackedHalf2AtPtx2206R1438); // PTX L2722
	MmaE4(r_PackedHalf2AtPtx2185R1441, r_PackedHalf2AtPtx2192R1440, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx141R1460, r_MmaBE4x4WordAtPtx141R1459, r_MmaAccumulatorHalf2WordAtPtx2715R1129,
		  r_MmaAccumulatorHalf2WordAtPtx2715R1130); // PTX L2729
	MmaE4(r_PackedHalf2AtPtx2199R1439, r_PackedHalf2AtPtx2206R1438, r_MmaAE4x4WordAtPtx2574R1113,
		  r_MmaAE4x4WordAtPtx2574R1114, r_MmaAE4x4WordAtPtx2574R1115, r_MmaAE4x4WordAtPtx2574R1116,
		  r_MmaBE4x4WordAtPtx141R1458, r_MmaBE4x4WordAtPtx141R1457, r_MmaAccumulatorHalf2WordAtPtx2722R1131,
		  r_MmaAccumulatorHalf2WordAtPtx2722R1132); // PTX L2736
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2743R1141, r_MmaAccumulatorHalf2WordAtPtx2743R1142,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx77R1488, r_MmaBE4x4WordAtPtx77R1487,
		  r_PackedHalf2AtPtx2213R1437,
		  r_PackedHalf2AtPtx2220R1436); // PTX L2743
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2750R1143, r_MmaAccumulatorHalf2WordAtPtx2750R1144,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx77R1486, r_MmaBE4x4WordAtPtx77R1485,
		  r_PackedHalf2AtPtx2227R1435,
		  r_PackedHalf2AtPtx2234R1434); // PTX L2750
	MmaE4(r_PackedHalf2AtPtx2213R1437, r_PackedHalf2AtPtx2220R1436, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx114R1472, r_MmaBE4x4WordAtPtx114R1471, r_MmaAccumulatorHalf2WordAtPtx2743R1141,
		  r_MmaAccumulatorHalf2WordAtPtx2743R1142); // PTX L2757
	MmaE4(r_PackedHalf2AtPtx2227R1435, r_PackedHalf2AtPtx2234R1434, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx114R1470, r_MmaBE4x4WordAtPtx114R1469, r_MmaAccumulatorHalf2WordAtPtx2750R1143,
		  r_MmaAccumulatorHalf2WordAtPtx2750R1144); // PTX L2764
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2771R1145, r_MmaAccumulatorHalf2WordAtPtx2771R1146,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx86R1484, r_MmaBE4x4WordAtPtx86R1483,
		  r_PackedHalf2AtPtx2241R1433,
		  r_PackedHalf2AtPtx2248R1432); // PTX L2771
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2778R1147, r_MmaAccumulatorHalf2WordAtPtx2778R1148,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx86R1482, r_MmaBE4x4WordAtPtx86R1481,
		  r_PackedHalf2AtPtx2255R1431,
		  r_PackedHalf2AtPtx2262R1430); // PTX L2778
	MmaE4(r_PackedHalf2AtPtx2241R1433, r_PackedHalf2AtPtx2248R1432, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx123R1468, r_MmaBE4x4WordAtPtx123R1467, r_MmaAccumulatorHalf2WordAtPtx2771R1145,
		  r_MmaAccumulatorHalf2WordAtPtx2771R1146); // PTX L2785
	MmaE4(r_PackedHalf2AtPtx2255R1431, r_PackedHalf2AtPtx2262R1430, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx123R1466, r_MmaBE4x4WordAtPtx123R1465, r_MmaAccumulatorHalf2WordAtPtx2778R1147,
		  r_MmaAccumulatorHalf2WordAtPtx2778R1148); // PTX L2792
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2799R1149, r_MmaAccumulatorHalf2WordAtPtx2799R1150,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx96R1480, r_MmaBE4x4WordAtPtx96R1479,
		  r_PackedHalf2AtPtx2269R1429,
		  r_PackedHalf2AtPtx2276R1428); // PTX L2799
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2806R1151, r_MmaAccumulatorHalf2WordAtPtx2806R1152,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx96R1478, r_MmaBE4x4WordAtPtx96R1477,
		  r_PackedHalf2AtPtx2283R1427,
		  r_PackedHalf2AtPtx2290R1426); // PTX L2806
	MmaE4(r_PackedHalf2AtPtx2269R1429, r_PackedHalf2AtPtx2276R1428, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx132R1464, r_MmaBE4x4WordAtPtx132R1463, r_MmaAccumulatorHalf2WordAtPtx2799R1149,
		  r_MmaAccumulatorHalf2WordAtPtx2799R1150); // PTX L2813
	MmaE4(r_PackedHalf2AtPtx2283R1427, r_PackedHalf2AtPtx2290R1426, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx132R1462, r_MmaBE4x4WordAtPtx132R1461, r_MmaAccumulatorHalf2WordAtPtx2806R1151,
		  r_MmaAccumulatorHalf2WordAtPtx2806R1152); // PTX L2820
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2827R1153, r_MmaAccumulatorHalf2WordAtPtx2827R1154,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx105R1476, r_MmaBE4x4WordAtPtx105R1475,
		  r_PackedHalf2AtPtx2297R1425,
		  r_PackedHalf2AtPtx2304R1424); // PTX L2827
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2834R1155, r_MmaAccumulatorHalf2WordAtPtx2834R1156,
		  r_MmaAE4x4WordAtPtx2583R1133, r_MmaAE4x4WordAtPtx2583R1134, r_MmaAE4x4WordAtPtx2583R1135,
		  r_MmaAE4x4WordAtPtx2583R1136, r_MmaBE4x4WordAtPtx105R1474, r_MmaBE4x4WordAtPtx105R1473,
		  r_PackedHalf2AtPtx2311R1423,
		  r_PackedHalf2AtPtx2318R1422); // PTX L2834
	MmaE4(r_PackedHalf2AtPtx2297R1425, r_PackedHalf2AtPtx2304R1424, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx141R1460, r_MmaBE4x4WordAtPtx141R1459, r_MmaAccumulatorHalf2WordAtPtx2827R1153,
		  r_MmaAccumulatorHalf2WordAtPtx2827R1154); // PTX L2841
	MmaE4(r_PackedHalf2AtPtx2311R1423, r_PackedHalf2AtPtx2318R1422, r_MmaAE4x4WordAtPtx2592R1137,
		  r_MmaAE4x4WordAtPtx2592R1138, r_MmaAE4x4WordAtPtx2592R1139, r_MmaAE4x4WordAtPtx2592R1140,
		  r_MmaBE4x4WordAtPtx141R1458, r_MmaBE4x4WordAtPtx141R1457, r_MmaAccumulatorHalf2WordAtPtx2834R1155,
		  r_MmaAccumulatorHalf2WordAtPtx2834R1156); // PTX L2848
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2855R1165, r_MmaAccumulatorHalf2WordAtPtx2855R1166,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx77R1488, r_MmaBE4x4WordAtPtx77R1487,
		  r_PackedHalf2AtPtx2325R1421,
		  r_PackedHalf2AtPtx2332R1420); // PTX L2855
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2862R1167, r_MmaAccumulatorHalf2WordAtPtx2862R1168,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx77R1486, r_MmaBE4x4WordAtPtx77R1485,
		  r_PackedHalf2AtPtx2339R1419,
		  r_PackedHalf2AtPtx2346R1418); // PTX L2862
	MmaE4(r_PackedHalf2AtPtx2325R1421, r_PackedHalf2AtPtx2332R1420, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx114R1472, r_MmaBE4x4WordAtPtx114R1471, r_MmaAccumulatorHalf2WordAtPtx2855R1165,
		  r_MmaAccumulatorHalf2WordAtPtx2855R1166); // PTX L2869
	MmaE4(r_PackedHalf2AtPtx2339R1419, r_PackedHalf2AtPtx2346R1418, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx114R1470, r_MmaBE4x4WordAtPtx114R1469, r_MmaAccumulatorHalf2WordAtPtx2862R1167,
		  r_MmaAccumulatorHalf2WordAtPtx2862R1168); // PTX L2876
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2883R1169, r_MmaAccumulatorHalf2WordAtPtx2883R1170,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx86R1484, r_MmaBE4x4WordAtPtx86R1483,
		  r_PackedHalf2AtPtx2353R1417,
		  r_PackedHalf2AtPtx2360R1416); // PTX L2883
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2890R1171, r_MmaAccumulatorHalf2WordAtPtx2890R1172,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx86R1482, r_MmaBE4x4WordAtPtx86R1481,
		  r_PackedHalf2AtPtx2367R1415,
		  r_PackedHalf2AtPtx2374R1414); // PTX L2890
	MmaE4(r_PackedHalf2AtPtx2353R1417, r_PackedHalf2AtPtx2360R1416, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx123R1468, r_MmaBE4x4WordAtPtx123R1467, r_MmaAccumulatorHalf2WordAtPtx2883R1169,
		  r_MmaAccumulatorHalf2WordAtPtx2883R1170); // PTX L2897
	MmaE4(r_PackedHalf2AtPtx2367R1415, r_PackedHalf2AtPtx2374R1414, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx123R1466, r_MmaBE4x4WordAtPtx123R1465, r_MmaAccumulatorHalf2WordAtPtx2890R1171,
		  r_MmaAccumulatorHalf2WordAtPtx2890R1172); // PTX L2904
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2911R1173, r_MmaAccumulatorHalf2WordAtPtx2911R1174,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx96R1480, r_MmaBE4x4WordAtPtx96R1479,
		  r_PackedHalf2AtPtx2381R1413,
		  r_PackedHalf2AtPtx2388R1412); // PTX L2911
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2918R1175, r_MmaAccumulatorHalf2WordAtPtx2918R1176,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx96R1478, r_MmaBE4x4WordAtPtx96R1477,
		  r_PackedHalf2AtPtx2395R1411,
		  r_PackedHalf2AtPtx2402R1410); // PTX L2918
	MmaE4(r_PackedHalf2AtPtx2381R1413, r_PackedHalf2AtPtx2388R1412, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx132R1464, r_MmaBE4x4WordAtPtx132R1463, r_MmaAccumulatorHalf2WordAtPtx2911R1173,
		  r_MmaAccumulatorHalf2WordAtPtx2911R1174); // PTX L2925
	MmaE4(r_PackedHalf2AtPtx2395R1411, r_PackedHalf2AtPtx2402R1410, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx132R1462, r_MmaBE4x4WordAtPtx132R1461, r_MmaAccumulatorHalf2WordAtPtx2918R1175,
		  r_MmaAccumulatorHalf2WordAtPtx2918R1176); // PTX L2932
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2939R1177, r_MmaAccumulatorHalf2WordAtPtx2939R1178,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx105R1476, r_MmaBE4x4WordAtPtx105R1475,
		  r_PackedHalf2AtPtx2409R1409,
		  r_PackedHalf2AtPtx2416R1408); // PTX L2939
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2946R1179, r_MmaAccumulatorHalf2WordAtPtx2946R1180,
		  r_MmaAE4x4WordAtPtx2601R1157, r_MmaAE4x4WordAtPtx2601R1158, r_MmaAE4x4WordAtPtx2601R1159,
		  r_MmaAE4x4WordAtPtx2601R1160, r_MmaBE4x4WordAtPtx105R1474, r_MmaBE4x4WordAtPtx105R1473,
		  r_PackedHalf2AtPtx2423R1407,
		  r_PackedHalf2AtPtx2430R1406); // PTX L2946
	MmaE4(r_PackedHalf2AtPtx2409R1409, r_PackedHalf2AtPtx2416R1408, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx141R1460, r_MmaBE4x4WordAtPtx141R1459, r_MmaAccumulatorHalf2WordAtPtx2939R1177,
		  r_MmaAccumulatorHalf2WordAtPtx2939R1178); // PTX L2953
	MmaE4(r_PackedHalf2AtPtx2423R1407, r_PackedHalf2AtPtx2430R1406, r_MmaAE4x4WordAtPtx2610R1161,
		  r_MmaAE4x4WordAtPtx2610R1162, r_MmaAE4x4WordAtPtx2610R1163, r_MmaAE4x4WordAtPtx2610R1164,
		  r_MmaBE4x4WordAtPtx141R1458, r_MmaBE4x4WordAtPtx141R1457, r_MmaAccumulatorHalf2WordAtPtx2946R1179,
		  r_MmaAccumulatorHalf2WordAtPtx2946R1180); // PTX L2960
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2967R1189, r_MmaAccumulatorHalf2WordAtPtx2967R1190,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx77R1488, r_MmaBE4x4WordAtPtx77R1487,
		  r_PackedHalf2AtPtx2437R1405,
		  r_PackedHalf2AtPtx2444R1404); // PTX L2967
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2974R1191, r_MmaAccumulatorHalf2WordAtPtx2974R1192,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx77R1486, r_MmaBE4x4WordAtPtx77R1485,
		  r_PackedHalf2AtPtx2451R1403,
		  r_PackedHalf2AtPtx2458R1402); // PTX L2974
	MmaE4(r_PackedHalf2AtPtx2437R1405, r_PackedHalf2AtPtx2444R1404, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx114R1472, r_MmaBE4x4WordAtPtx114R1471, r_MmaAccumulatorHalf2WordAtPtx2967R1189,
		  r_MmaAccumulatorHalf2WordAtPtx2967R1190); // PTX L2981
	MmaE4(r_PackedHalf2AtPtx2451R1403, r_PackedHalf2AtPtx2458R1402, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx114R1470, r_MmaBE4x4WordAtPtx114R1469, r_MmaAccumulatorHalf2WordAtPtx2974R1191,
		  r_MmaAccumulatorHalf2WordAtPtx2974R1192); // PTX L2988
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2995R1193, r_MmaAccumulatorHalf2WordAtPtx2995R1194,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx86R1484, r_MmaBE4x4WordAtPtx86R1483,
		  r_PackedHalf2AtPtx2465R1401,
		  r_PackedHalf2AtPtx2472R1400); // PTX L2995
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3002R1195, r_MmaAccumulatorHalf2WordAtPtx3002R1196,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx86R1482, r_MmaBE4x4WordAtPtx86R1481,
		  r_PackedHalf2AtPtx2479R1399,
		  r_PackedHalf2AtPtx2486R1398); // PTX L3002
	MmaE4(r_PackedHalf2AtPtx2465R1401, r_PackedHalf2AtPtx2472R1400, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx123R1468, r_MmaBE4x4WordAtPtx123R1467, r_MmaAccumulatorHalf2WordAtPtx2995R1193,
		  r_MmaAccumulatorHalf2WordAtPtx2995R1194); // PTX L3009
	MmaE4(r_PackedHalf2AtPtx2479R1399, r_PackedHalf2AtPtx2486R1398, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx123R1466, r_MmaBE4x4WordAtPtx123R1465, r_MmaAccumulatorHalf2WordAtPtx3002R1195,
		  r_MmaAccumulatorHalf2WordAtPtx3002R1196); // PTX L3016
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3023R1197, r_MmaAccumulatorHalf2WordAtPtx3023R1198,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx96R1480, r_MmaBE4x4WordAtPtx96R1479,
		  r_PackedHalf2AtPtx2493R1397,
		  r_PackedHalf2AtPtx2500R1396); // PTX L3023
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3030R1199, r_MmaAccumulatorHalf2WordAtPtx3030R1200,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx96R1478, r_MmaBE4x4WordAtPtx96R1477,
		  r_PackedHalf2AtPtx2507R1395,
		  r_PackedHalf2AtPtx2514R1394); // PTX L3030
	MmaE4(r_PackedHalf2AtPtx2493R1397, r_PackedHalf2AtPtx2500R1396, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx132R1464, r_MmaBE4x4WordAtPtx132R1463, r_MmaAccumulatorHalf2WordAtPtx3023R1197,
		  r_MmaAccumulatorHalf2WordAtPtx3023R1198); // PTX L3037
	MmaE4(r_PackedHalf2AtPtx2507R1395, r_PackedHalf2AtPtx2514R1394, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx132R1462, r_MmaBE4x4WordAtPtx132R1461, r_MmaAccumulatorHalf2WordAtPtx3030R1199,
		  r_MmaAccumulatorHalf2WordAtPtx3030R1200); // PTX L3044
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3051R1201, r_MmaAccumulatorHalf2WordAtPtx3051R1202,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx105R1476, r_MmaBE4x4WordAtPtx105R1475,
		  r_PackedHalf2AtPtx2521R1393,
		  r_PackedHalf2AtPtx2528R1392); // PTX L3051
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3058R1203, r_MmaAccumulatorHalf2WordAtPtx3058R1204,
		  r_MmaAE4x4WordAtPtx2619R1181, r_MmaAE4x4WordAtPtx2619R1182, r_MmaAE4x4WordAtPtx2619R1183,
		  r_MmaAE4x4WordAtPtx2619R1184, r_MmaBE4x4WordAtPtx105R1474, r_MmaBE4x4WordAtPtx105R1473,
		  r_PackedHalf2AtPtx2535R1454,
		  r_PackedHalf2AtPtx2542R1455); // PTX L3058
	MmaE4(r_PackedHalf2AtPtx2521R1393, r_PackedHalf2AtPtx2528R1392, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx141R1460, r_MmaBE4x4WordAtPtx141R1459, r_MmaAccumulatorHalf2WordAtPtx3051R1201,
		  r_MmaAccumulatorHalf2WordAtPtx3051R1202); // PTX L3065
	MmaE4(r_PackedHalf2AtPtx2535R1454, r_PackedHalf2AtPtx2542R1455, r_MmaAE4x4WordAtPtx2628R1185,
		  r_MmaAE4x4WordAtPtx2628R1186, r_MmaAE4x4WordAtPtx2628R1187, r_MmaAE4x4WordAtPtx2628R1188,
		  r_MmaBE4x4WordAtPtx141R1458, r_MmaBE4x4WordAtPtx141R1457, r_MmaAccumulatorHalf2WordAtPtx3058R1203,
		  r_MmaAccumulatorHalf2WordAtPtx3058R1204);					 // PTX L3072
	r_bPtxPredicate62 = uint32_t(r_PtxRegister1456) > uint32_t(447); // PTX L3078
	if (r_bPtxPredicate62)
	{
		goto L__BB13_98;
	} // PTX L3079
	r_PtxRegister1233 = uint32_t(r_PtxRegister1456) + uint32_t(64);								  // PTX L3080
	r_CtaZAtPtx3081 = uint32_t(blockIdx.z);														  // PTX L3081
	r_PtxRegister1235 = ShiftLeft(uint32_t(r_CtaZAtPtx3081), uint32_t(9));						  // PTX L3082
	r_PtxRegister1236 = uint32_t(r_PtxRegister1233) + uint32_t(r_PtxRegister1235);				  // PTX L3083
	r_PtxRegister1237 = ShiftLeft(uint32_t(r_PtxRegister1236), uint32_t(7));					  // PTX L3084
	r_PtxRegister1238 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(3));						  // PTX L3085
	r_PtxRegister1239 = uint32_t(r_PtxRegister1237) + uint32_t(r_PtxRegister1238);				  // PTX L3086
	r_PtxU64Register214 = uint64_t(int64_t(int32_t(r_PtxRegister1239)) * int64_t(int32_t(4)));	  // PTX L3087
	g_RecordByteAddressAtPtx3088 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register214); // PTX L3088
	r_LaneIndexAtPtx3090 = uint32_t((threadIdx.x & 31u));										  // PTX L3090
	r_PtxU64Register216 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3090)) * int64_t(int32_t(16))); // PTX L3092
	g_RecordByteAddressAtPtx3093 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register216); // PTX L3093
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3093));
		r_MmaBE4x4WordAtPtx77R1488 = r_Value.x;
		r_MmaBE4x4WordAtPtx77R1487 = r_Value.y;
		r_MmaBE4x4WordAtPtx77R1486 = r_Value.z;
		r_MmaBE4x4WordAtPtx77R1485 = r_Value.w;
	} // PTX L3095
	r_LaneIndexAtPtx3098 = uint32_t((threadIdx.x & 31u)); // PTX L3098
	r_PtxU64Register217 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3098)) * int64_t(int32_t(16))); // PTX L3100
	g_RecordByteAddressAtPtx3101 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register217);			   // PTX L3101
	g_RecordByteAddressAtPtx3102 = uint64_t(g_RecordByteAddressAtPtx3101) + uint64_t(512); // PTX L3102
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3102));
		r_MmaBE4x4WordAtPtx86R1484 = r_Value.x;
		r_MmaBE4x4WordAtPtx86R1483 = r_Value.y;
		r_MmaBE4x4WordAtPtx86R1482 = r_Value.z;
		r_MmaBE4x4WordAtPtx86R1481 = r_Value.w;
	} // PTX L3104
	r_LaneIndexAtPtx3107 = uint32_t((threadIdx.x & 31u)); // PTX L3107
	r_PtxU64Register219 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3107)) * int64_t(int32_t(16))); // PTX L3109
	g_RecordByteAddressAtPtx3110 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register219);				// PTX L3110
	g_RecordByteAddressAtPtx3111 = uint64_t(g_RecordByteAddressAtPtx3110) + uint64_t(1024); // PTX L3111
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3111));
		r_MmaBE4x4WordAtPtx96R1480 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1479 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1478 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1477 = r_Value.w;
	} // PTX L3113
	r_LaneIndexAtPtx3116 = uint32_t((threadIdx.x & 31u)); // PTX L3116
	r_PtxU64Register221 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3116)) * int64_t(int32_t(16))); // PTX L3118
	g_RecordByteAddressAtPtx3119 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register221);				// PTX L3119
	g_RecordByteAddressAtPtx3120 = uint64_t(g_RecordByteAddressAtPtx3119) + uint64_t(1536); // PTX L3120
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3120));
		r_MmaBE4x4WordAtPtx105R1476 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1475 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1474 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1473 = r_Value.w;
	} // PTX L3122
	r_LaneIndexAtPtx3125 = uint32_t((threadIdx.x & 31u)); // PTX L3125
	r_PtxU64Register223 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3125)) * int64_t(int32_t(16))); // PTX L3127
	g_RecordByteAddressAtPtx3128 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register223);				 // PTX L3128
	g_RecordByteAddressAtPtx3129 = uint64_t(g_RecordByteAddressAtPtx3128) + uint64_t(16384); // PTX L3129
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3129));
		r_MmaBE4x4WordAtPtx114R1472 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R1471 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R1470 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R1469 = r_Value.w;
	} // PTX L3131
	r_LaneIndexAtPtx3134 = uint32_t((threadIdx.x & 31u)); // PTX L3134
	r_PtxU64Register225 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3134)) * int64_t(int32_t(16))); // PTX L3136
	g_RecordByteAddressAtPtx3137 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register225);				 // PTX L3137
	g_RecordByteAddressAtPtx3138 = uint64_t(g_RecordByteAddressAtPtx3137) + uint64_t(16896); // PTX L3138
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3138));
		r_MmaBE4x4WordAtPtx123R1468 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R1467 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R1466 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R1465 = r_Value.w;
	} // PTX L3140
	r_LaneIndexAtPtx3143 = uint32_t((threadIdx.x & 31u)); // PTX L3143
	r_PtxU64Register227 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3143)) * int64_t(int32_t(16))); // PTX L3145
	g_RecordByteAddressAtPtx3146 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register227);				 // PTX L3146
	g_RecordByteAddressAtPtx3147 = uint64_t(g_RecordByteAddressAtPtx3146) + uint64_t(17408); // PTX L3147
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3147));
		r_MmaBE4x4WordAtPtx132R1464 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R1463 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R1462 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R1461 = r_Value.w;
	} // PTX L3149
	r_LaneIndexAtPtx3152 = uint32_t((threadIdx.x & 31u)); // PTX L3152
	r_PtxU64Register229 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3152)) * int64_t(int32_t(16))); // PTX L3154
	g_RecordByteAddressAtPtx3155 =
		uint64_t(g_RecordByteAddressAtPtx3088) + uint64_t(r_PtxU64Register229);				 // PTX L3155
	g_RecordByteAddressAtPtx3156 = uint64_t(g_RecordByteAddressAtPtx3155) + uint64_t(17920); // PTX L3156
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3156));
		r_MmaBE4x4WordAtPtx141R1460 = r_Value.x;
		r_MmaBE4x4WordAtPtx141R1459 = r_Value.y;
		r_MmaBE4x4WordAtPtx141R1458 = r_Value.z;
		r_MmaBE4x4WordAtPtx141R1457 = r_Value.w;
	} // PTX L3158
	r_PtxRegister1240 = ShiftRight(uint32_t(r_PtxRegister1233), uint32_t(6)); // PTX L3160
	r_PtxU16Register99 = uint16_t(r_PtxRegister1240);						  // PTX L3161
	r_PtxU16Register100 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register99)) * uint32_t(uint16_t(171))); // PTX L3162
	r_PtxU16Register101 = ShiftRight(uint16_t(r_PtxU16Register100), uint32_t(9));	// PTX L3163
	r_PtxU16Register102 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register101)) * uint32_t(uint16_t(3)));				// PTX L3164
	r_PtxU16Register103 = uint16_t(r_PtxU16Register99) - uint16_t(r_PtxU16Register102);			// PTX L3165
	r_PtxU16Register104 = r_PtxU16Register103 & 255;											// PTX L3166
	r_PtxRegister1241 = uint32_t(uint16_t(r_PtxU16Register104)) * uint32_t(uint16_t(8));		// PTX L3167
	r_PtxRegister1242 = uint32_t(12288u /* exact native shared-region offset */);				// PTX L3168
	r_PtxRegister1244 = uint32_t(r_PtxRegister1242) + uint32_t(r_PtxRegister1241);				// PTX L3169
	r_PtxRegister1232 = uint32_t(1);															// PTX L3170
	r_PtxU64Register231 = BarrierArrive(s_SharedStorage, r_PtxRegister1244, r_PtxRegister1232); // PTX L3172
L__BB13_97:																						// PTX L3174
	r_PtxRegister1243 = BarrierReady(s_SharedStorage, r_PtxRegister1244, r_PtxU64Register231);	// PTX L3176
	r_bPtxPredicate63 = uint32_t(r_PtxRegister1243) == uint32_t(0);								// PTX L3182
	if (r_bPtxPredicate63)
	{
		goto L__BB13_97;
	} // PTX L3183
L__BB13_98:															 // PTX L3184
	r_bPtxPredicate64 = uint32_t(r_PtxRegister1456) > uint32_t(319); // PTX L3185
	if (r_bPtxPredicate64)
	{
		goto L__BB13_115;
	} // PTX L3186
	r_PtxRegister1245 = uint32_t(r_PtxRegister80) + uint32_t(r_PtxRegister4);	  // PTX L3187
	r_bPtxPredicate65 = int32_t(r_PtxRegister1245) < int32_t(r_WidthDiv4Bits);	  // PTX L3188
	r_bPtxPredicate66 = int32_t(r_PtxRegister85) < int32_t(r_HeightDiv4Bits);	  // PTX L3189
	r_bPtxPredicate67 = int32_t(r_PtxRegister85) >= int32_t(r_HeightDiv4Bits);	  // PTX L3190
	r_bPtxPredicate68 = uint32_t(r_PtxRegister23) == uint32_t(4);				  // PTX L3191
	r_bPtxPredicate69 = uint32_t(r_PtxRegister15) == uint32_t(4);				  // PTX L3192
	r_PtxRegister1246 = uint32_t(r_PtxRegister127) + uint32_t(r_PtxRegister1456); // PTX L3193
	r_PtxRegister34 = uint32_t(r_PtxRegister1246) + uint32_t(192);				  // PTX L3194
	r_bPtxPredicate70 = r_bPtxPredicate3 & r_bPtxPredicate67;					  // PTX L3195
	r_bPtxPredicate71 = r_bPtxPredicate69 | r_bPtxPredicate66;					  // PTX L3196
	r_bPtxPredicate72 = r_bPtxPredicate70 | r_bPtxPredicate68;					  // PTX L3197
	r_PtxRegister1247 = r_bPtxPredicate70 ? r_PtxRegister1245 : 0;				  // PTX L3198
	r_PtxRegister35 = r_bPtxPredicate68 ? r_PtxRegister1247 : r_PtxRegister1245;  // PTX L3199
	r_bPtxPredicate73 = r_bPtxPredicate72 | r_bPtxPredicate65;					  // PTX L3200
	r_bPtxPredicate14 = r_bPtxPredicate73 & r_bPtxPredicate71;					  // PTX L3201
	r_PtxU64Register272 = uint64_t(0);											  // PTX L3202
	r_bPtxPredicate74 = !r_bPtxPredicate14;										  // PTX L3203
	if (r_bPtxPredicate74)
	{
		goto L__BB13_101;
	} // PTX L3204
	r_PtxRegister1248 =
		uint32_t(r_PtxRegister85) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister35); // PTX L3205
	r_PtxRegister1249 = r_bPtxPredicate69 ? r_PtxRegister35 : r_PtxRegister1248;		   // PTX L3206
	r_PtxRegister1250 = ShiftRight(uint32_t(r_PtxRegister34), uint32_t(5));				   // PTX L3207
	r_PtxRegister1251 = uint32_t(r_PtxRegister1250) + uint32_t(r_PtxRegister10);		   // PTX L3208
	r_PtxRegister1252 = ShiftLeft(uint32_t(r_PtxRegister1249), uint32_t(11));			   // PTX L3209
	r_PtxRegister1253 = ShiftLeft(uint32_t(r_PtxRegister1251), uint32_t(7));			   // PTX L3210
	r_PtxRegister1254 = uint32_t(r_PtxRegister1252) + uint32_t(r_PtxRegister1253);		   // PTX L3211
	r_PtxU64Register272 = SignExtendWordBits(r_PtxRegister1254);						   // PTX L3212
L__BB13_101:																			   // PTX L3213
	r_PtxU64Register273 = uint64_t(0);													   // PTX L3214
	if (r_bPtxPredicate74)
	{
		goto L__BB13_103;
	} // PTX L3215
	r_PtxU64Register232 = ShiftLeft(uint64_t(r_PtxU64Register272), uint32_t(2));		// PTX L3216
	r_PtxU64Register273 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register232); // PTX L3217
L__BB13_103:																			// PTX L3218
	r_PtxRegister1255 = ShiftLeft(uint32_t(r_PtxRegister32), uint32_t(3));				// PTX L3219
	r_PtxRegister1256 = uint32_t(12288u /* exact native shared-region offset */);		// PTX L3220
	r_PtxRegister1305 = uint32_t(r_PtxRegister1256) + uint32_t(r_PtxRegister1255);		// PTX L3221
	if (r_bPtxPredicate74)
	{
		goto L__BB13_106;
	} // PTX L3222
	r_PtxRegister1269 = uint32_t(-1);								// PTX L3223
	r_PtxRegister1268 = Elected(r_PtxRegister1269);					// PTX L3225
	r_bPtxPredicate75 = uint32_t(r_PtxRegister1268) == uint32_t(0); // PTX L3231
	if (r_bPtxPredicate75)
	{
		goto L__BB13_107;
	} // PTX L3232
	r_ThreadYAtPtx3233 = uint32_t(threadIdx.y);									 // PTX L3233
	r_PtxRegister1273 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(9));		 // PTX L3234
	r_PtxRegister1274 = ShiftLeft(uint32_t(r_ThreadYAtPtx3233), uint32_t(9));	 // PTX L3235
	r_PtxRegister1275 = r_PtxRegister1274 & 523264;								 // PTX L3236
	r_PtxRegister1276 = r_PtxRegister1273 | r_PtxRegister1275;					 // PTX L3237
	r_PtxRegister1270 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1276); // PTX L3238
	r_PtxU64Register233 = r_PtxU64Register273;									 // PTX L3239
	r_PtxRegister1271 = uint32_t(512);											 // PTX L3240
	CopyBulk(s_SharedStorage, r_PtxRegister1270, r_PtxU64Register233, r_PtxRegister1271,
			 r_PtxRegister1305);																 // PTX L3242
	BarrierExpect(s_SharedStorage, r_PtxRegister1305, r_PtxRegister1271);						 // PTX L3245
	goto L__BB13_107;																			 // PTX L3247
L__BB13_106:																					 // PTX L3248
	r_PtxRegister1257 = uint32_t(0);															 // PTX L3249
	r_PtxU16Register105 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1257))); // PTX L3251
	r_PackedHalf2AtPtx3254R1258 = JoinHalfwords(r_PtxU16Register105, r_PtxU16Register105);		 // PTX L3254
	r_ConvertedE4PairAtPtx3256Rs106 = PublishE4(r_PackedHalf2AtPtx3254R1258);					 // PTX L3256
	r_PackedE4WordAtPtx3258R1261 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3256Rs106, r_ConvertedE4PairAtPtx3256Rs106); // PTX L3258
	r_LaneIndexAtPtx3260 = uint32_t((threadIdx.x & 31u));								 // PTX L3260
	r_PtxRegister1262 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(9));				 // PTX L3262
	r_PtxRegister1263 = ShiftLeft(uint32_t(r_ThreadYAtPtx42), uint32_t(9));				 // PTX L3263
	r_PtxRegister1264 = r_PtxRegister1263 & 523264;										 // PTX L3264
	r_PtxRegister1265 = r_PtxRegister1262 | r_PtxRegister1264;							 // PTX L3265
	r_PtxRegister1266 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1265);		 // PTX L3266
	r_PtxRegister1267 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3260), uint32_t(4));			 // PTX L3267
	r_PtxRegister1260 = uint32_t(r_PtxRegister1266) + uint32_t(r_PtxRegister1267);		 // PTX L3268
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1260)) =
		make_uint4(r_PackedE4WordAtPtx3258R1261, r_PackedE4WordAtPtx3258R1261, r_PackedE4WordAtPtx3258R1261,
				   r_PackedE4WordAtPtx3258R1261);								  // PTX L3270
L__BB13_107:																	  // PTX L3272
	r_CtaYAtPtx3273 = uint32_t(blockIdx.y);										  // PTX L3273
	r_PtxRegister1278 = ShiftLeft(uint32_t(r_CtaYAtPtx3273), uint32_t(1));		  // PTX L3274
	r_PtxRegister1279 = uint32_t(r_PtxRegister105) + uint32_t(r_PtxRegister1278); // PTX L3275
	r_bPtxPredicate76 = int32_t(r_PtxRegister1279) < int32_t(r_HeightDiv4Bits);	  // PTX L3276
	r_bPtxPredicate77 = int32_t(r_PtxRegister1279) >= int32_t(r_HeightDiv4Bits);  // PTX L3277
	r_bPtxPredicate78 = int32_t(r_PtxRegister1245) < int32_t(r_WidthDiv4Bits);	  // PTX L3278
	r_bPtxPredicate79 = uint32_t(r_PtxRegister23) == uint32_t(4);				  // PTX L3279
	r_bPtxPredicate80 = uint32_t(r_PtxRegister15) == uint32_t(4);				  // PTX L3280
	r_bPtxPredicate81 = r_bPtxPredicate3 & r_bPtxPredicate77;					  // PTX L3281
	r_bPtxPredicate82 = r_bPtxPredicate80 | r_bPtxPredicate76;					  // PTX L3282
	r_bPtxPredicate83 = r_bPtxPredicate81 | r_bPtxPredicate79;					  // PTX L3283
	r_PtxRegister1280 = r_bPtxPredicate81 ? r_PtxRegister1245 : 0;				  // PTX L3284
	r_PtxRegister36 = r_bPtxPredicate79 ? r_PtxRegister1280 : r_PtxRegister1245;  // PTX L3285
	r_bPtxPredicate84 = r_bPtxPredicate83 | r_bPtxPredicate78;					  // PTX L3286
	r_bPtxPredicate15 = r_bPtxPredicate84 & r_bPtxPredicate82;					  // PTX L3287
	r_PtxU64Register274 = uint64_t(0);											  // PTX L3288
	r_bPtxPredicate85 = !r_bPtxPredicate15;										  // PTX L3289
	if (r_bPtxPredicate85)
	{
		goto L__BB13_109;
	} // PTX L3290
	r_PtxRegister1281 =
		uint32_t(r_PtxRegister1279) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister36); // PTX L3291
	r_PtxRegister1282 = r_bPtxPredicate80 ? r_PtxRegister36 : r_PtxRegister1281;			 // PTX L3292
	r_PtxRegister1283 = ShiftRight(uint32_t(r_PtxRegister34), uint32_t(5));					 // PTX L3293
	r_PtxRegister1284 = uint32_t(r_PtxRegister1283) + uint32_t(r_PtxRegister10);			 // PTX L3294
	r_PtxRegister1285 = ShiftLeft(uint32_t(r_PtxRegister1282), uint32_t(11));				 // PTX L3295
	r_PtxRegister1286 = ShiftLeft(uint32_t(r_PtxRegister1284), uint32_t(7));				 // PTX L3296
	r_PtxRegister1287 = uint32_t(r_PtxRegister1285) + uint32_t(r_PtxRegister1286);			 // PTX L3297
	r_PtxU64Register274 = SignExtendWordBits(r_PtxRegister1287);							 // PTX L3298
L__BB13_109:																				 // PTX L3299
	r_PtxU64Register275 = uint64_t(0);														 // PTX L3300
	if (r_bPtxPredicate85)
	{
		goto L__BB13_111;
	} // PTX L3301
	r_PtxU64Register234 = ShiftLeft(uint64_t(r_PtxU64Register274), uint32_t(2));		// PTX L3302
	r_PtxU64Register275 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register234); // PTX L3303
L__BB13_111:																			// PTX L3304
	r_PtxRegister1288 = uint32_t(r_PtxRegister83) + uint32_t(512);						// PTX L3305
	r_PtxRegister1289 = r_PtxRegister1288 & 261632;										// PTX L3306
	r_PtxRegister1290 = r_PtxRegister83 & 256;											// PTX L3307
	r_PtxRegister1291 = r_PtxRegister1289 | r_PtxRegister1290;							// PTX L3308
	r_PtxRegister1292 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(7));				// PTX L3309
	r_PtxRegister37 = r_PtxRegister1291 | r_PtxRegister1292;							// PTX L3310
	if (r_bPtxPredicate85)
	{
		goto L__BB13_114;
	} // PTX L3311
	r_PtxRegister1302 = uint32_t(-1);								// PTX L3312
	r_PtxRegister1301 = Elected(r_PtxRegister1302);					// PTX L3314
	r_bPtxPredicate86 = uint32_t(r_PtxRegister1301) == uint32_t(0); // PTX L3320
	if (r_bPtxPredicate86)
	{
		goto L__BB13_115;
	} // PTX L3321
	r_PtxRegister1306 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(2));		 // PTX L3322
	r_PtxRegister1303 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1306); // PTX L3323
	r_PtxU64Register235 = r_PtxU64Register275;									 // PTX L3324
	r_PtxRegister1304 = uint32_t(512);											 // PTX L3325
	CopyBulk(s_SharedStorage, r_PtxRegister1303, r_PtxU64Register235, r_PtxRegister1304,
			 r_PtxRegister1305);																 // PTX L3327
	BarrierExpect(s_SharedStorage, r_PtxRegister1305, r_PtxRegister1304);						 // PTX L3330
	goto L__BB13_115;																			 // PTX L3332
L__BB13_114:																					 // PTX L3333
	r_PtxRegister1293 = uint32_t(0);															 // PTX L3334
	r_PtxU16Register107 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1293))); // PTX L3336
	r_PackedHalf2AtPtx3339R1294 = JoinHalfwords(r_PtxU16Register107, r_PtxU16Register107);		 // PTX L3339
	r_ConvertedE4PairAtPtx3341Rs108 = PublishE4(r_PackedHalf2AtPtx3339R1294);					 // PTX L3341
	r_PackedE4WordAtPtx3343R1297 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3341Rs108, r_ConvertedE4PairAtPtx3341Rs108); // PTX L3343
	r_LaneIndexAtPtx3345 = uint32_t((threadIdx.x & 31u));								 // PTX L3345
	r_PtxRegister1298 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(2));				 // PTX L3347
	r_PtxRegister1299 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister1298);		 // PTX L3348
	r_PtxRegister1300 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3345), uint32_t(4));			 // PTX L3349
	r_PtxRegister1296 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister1300);		 // PTX L3350
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1296)) =
		make_uint4(r_PackedE4WordAtPtx3343R1297, r_PackedE4WordAtPtx3343R1297, r_PackedE4WordAtPtx3343R1297,
				   r_PackedE4WordAtPtx3343R1297);					 // PTX L3352
L__BB13_115:														 // PTX L3354
	r_bPtxPredicate87 = uint32_t(r_PtxRegister1456) < uint32_t(448); // PTX L3355
	r_PtxRegister1456 = uint32_t(r_PtxRegister1456) + uint32_t(64);	 // PTX L3356
	if (r_bPtxPredicate87)
	{
		goto L__BB13_95;
	} // PTX L3357
	r_bPtxPredicate88 = int32_t(r_PtxRegister4) >= int32_t(r_WidthDiv4Bits);  // PTX L3358
	r_ConvertedE4PairAtPtx3360Rs109 = PublishE4(r_PackedHalf2AtPtx2101R1453); // PTX L3360
	r_ConvertedE4PairAtPtx3363Rs110 = PublishE4(r_PackedHalf2AtPtx2115R1451); // PTX L3363
	r_ConvertedE4PairAtPtx3366Rs111 = PublishE4(r_PackedHalf2AtPtx2108R1452); // PTX L3366
	r_ConvertedE4PairAtPtx3369Rs112 = PublishE4(r_PackedHalf2AtPtx2122R1450); // PTX L3369
	r_ConvertedE4PairAtPtx3372Rs113 = PublishE4(r_PackedHalf2AtPtx2129R1449); // PTX L3372
	r_ConvertedE4PairAtPtx3375Rs114 = PublishE4(r_PackedHalf2AtPtx2143R1447); // PTX L3375
	r_ConvertedE4PairAtPtx3378Rs115 = PublishE4(r_PackedHalf2AtPtx2136R1448); // PTX L3378
	r_ConvertedE4PairAtPtx3381Rs116 = PublishE4(r_PackedHalf2AtPtx2150R1446); // PTX L3381
	r_ConvertedE4PairAtPtx3384Rs117 = PublishE4(r_PackedHalf2AtPtx2157R1445); // PTX L3384
	r_ConvertedE4PairAtPtx3387Rs118 = PublishE4(r_PackedHalf2AtPtx2171R1443); // PTX L3387
	r_ConvertedE4PairAtPtx3390Rs119 = PublishE4(r_PackedHalf2AtPtx2164R1444); // PTX L3390
	r_ConvertedE4PairAtPtx3393Rs120 = PublishE4(r_PackedHalf2AtPtx2178R1442); // PTX L3393
	r_ConvertedE4PairAtPtx3396Rs121 = PublishE4(r_PackedHalf2AtPtx2185R1441); // PTX L3396
	r_ConvertedE4PairAtPtx3399Rs122 = PublishE4(r_PackedHalf2AtPtx2199R1439); // PTX L3399
	r_ConvertedE4PairAtPtx3402Rs123 = PublishE4(r_PackedHalf2AtPtx2192R1440); // PTX L3402
	r_ConvertedE4PairAtPtx3405Rs124 = PublishE4(r_PackedHalf2AtPtx2206R1438); // PTX L3405
	r_ConvertedE4PairAtPtx3408Rs125 = PublishE4(r_PackedHalf2AtPtx2213R1437); // PTX L3408
	r_ConvertedE4PairAtPtx3411Rs126 = PublishE4(r_PackedHalf2AtPtx2227R1435); // PTX L3411
	r_ConvertedE4PairAtPtx3414Rs127 = PublishE4(r_PackedHalf2AtPtx2220R1436); // PTX L3414
	r_ConvertedE4PairAtPtx3417Rs128 = PublishE4(r_PackedHalf2AtPtx2234R1434); // PTX L3417
	r_ConvertedE4PairAtPtx3420Rs129 = PublishE4(r_PackedHalf2AtPtx2241R1433); // PTX L3420
	r_ConvertedE4PairAtPtx3423Rs130 = PublishE4(r_PackedHalf2AtPtx2255R1431); // PTX L3423
	r_ConvertedE4PairAtPtx3426Rs131 = PublishE4(r_PackedHalf2AtPtx2248R1432); // PTX L3426
	r_ConvertedE4PairAtPtx3429Rs132 = PublishE4(r_PackedHalf2AtPtx2262R1430); // PTX L3429
	r_ConvertedE4PairAtPtx3432Rs133 = PublishE4(r_PackedHalf2AtPtx2269R1429); // PTX L3432
	r_ConvertedE4PairAtPtx3435Rs134 = PublishE4(r_PackedHalf2AtPtx2283R1427); // PTX L3435
	r_ConvertedE4PairAtPtx3438Rs135 = PublishE4(r_PackedHalf2AtPtx2276R1428); // PTX L3438
	r_ConvertedE4PairAtPtx3441Rs136 = PublishE4(r_PackedHalf2AtPtx2290R1426); // PTX L3441
	r_ConvertedE4PairAtPtx3444Rs137 = PublishE4(r_PackedHalf2AtPtx2297R1425); // PTX L3444
	r_ConvertedE4PairAtPtx3447Rs138 = PublishE4(r_PackedHalf2AtPtx2311R1423); // PTX L3447
	r_ConvertedE4PairAtPtx3450Rs139 = PublishE4(r_PackedHalf2AtPtx2304R1424); // PTX L3450
	r_ConvertedE4PairAtPtx3453Rs140 = PublishE4(r_PackedHalf2AtPtx2318R1422); // PTX L3453
	r_ConvertedE4PairAtPtx3456Rs141 = PublishE4(r_PackedHalf2AtPtx2325R1421); // PTX L3456
	r_ConvertedE4PairAtPtx3459Rs142 = PublishE4(r_PackedHalf2AtPtx2339R1419); // PTX L3459
	r_ConvertedE4PairAtPtx3462Rs143 = PublishE4(r_PackedHalf2AtPtx2332R1420); // PTX L3462
	r_ConvertedE4PairAtPtx3465Rs144 = PublishE4(r_PackedHalf2AtPtx2346R1418); // PTX L3465
	r_ConvertedE4PairAtPtx3468Rs145 = PublishE4(r_PackedHalf2AtPtx2353R1417); // PTX L3468
	r_ConvertedE4PairAtPtx3471Rs146 = PublishE4(r_PackedHalf2AtPtx2367R1415); // PTX L3471
	r_ConvertedE4PairAtPtx3474Rs147 = PublishE4(r_PackedHalf2AtPtx2360R1416); // PTX L3474
	r_ConvertedE4PairAtPtx3477Rs148 = PublishE4(r_PackedHalf2AtPtx2374R1414); // PTX L3477
	r_ConvertedE4PairAtPtx3480Rs149 = PublishE4(r_PackedHalf2AtPtx2381R1413); // PTX L3480
	r_ConvertedE4PairAtPtx3483Rs150 = PublishE4(r_PackedHalf2AtPtx2395R1411); // PTX L3483
	r_ConvertedE4PairAtPtx3486Rs151 = PublishE4(r_PackedHalf2AtPtx2388R1412); // PTX L3486
	r_ConvertedE4PairAtPtx3489Rs152 = PublishE4(r_PackedHalf2AtPtx2402R1410); // PTX L3489
	r_ConvertedE4PairAtPtx3492Rs153 = PublishE4(r_PackedHalf2AtPtx2409R1409); // PTX L3492
	r_ConvertedE4PairAtPtx3495Rs154 = PublishE4(r_PackedHalf2AtPtx2423R1407); // PTX L3495
	r_ConvertedE4PairAtPtx3498Rs155 = PublishE4(r_PackedHalf2AtPtx2416R1408); // PTX L3498
	r_ConvertedE4PairAtPtx3501Rs156 = PublishE4(r_PackedHalf2AtPtx2430R1406); // PTX L3501
	r_ConvertedE4PairAtPtx3504Rs157 = PublishE4(r_PackedHalf2AtPtx2437R1405); // PTX L3504
	r_ConvertedE4PairAtPtx3507Rs158 = PublishE4(r_PackedHalf2AtPtx2451R1403); // PTX L3507
	r_ConvertedE4PairAtPtx3510Rs159 = PublishE4(r_PackedHalf2AtPtx2444R1404); // PTX L3510
	r_ConvertedE4PairAtPtx3513Rs160 = PublishE4(r_PackedHalf2AtPtx2458R1402); // PTX L3513
	r_ConvertedE4PairAtPtx3516Rs161 = PublishE4(r_PackedHalf2AtPtx2465R1401); // PTX L3516
	r_ConvertedE4PairAtPtx3519Rs162 = PublishE4(r_PackedHalf2AtPtx2479R1399); // PTX L3519
	r_ConvertedE4PairAtPtx3522Rs163 = PublishE4(r_PackedHalf2AtPtx2472R1400); // PTX L3522
	r_ConvertedE4PairAtPtx3525Rs164 = PublishE4(r_PackedHalf2AtPtx2486R1398); // PTX L3525
	r_ConvertedE4PairAtPtx3528Rs165 = PublishE4(r_PackedHalf2AtPtx2493R1397); // PTX L3528
	r_ConvertedE4PairAtPtx3531Rs166 = PublishE4(r_PackedHalf2AtPtx2507R1395); // PTX L3531
	r_ConvertedE4PairAtPtx3534Rs167 = PublishE4(r_PackedHalf2AtPtx2500R1396); // PTX L3534
	r_ConvertedE4PairAtPtx3537Rs168 = PublishE4(r_PackedHalf2AtPtx2514R1394); // PTX L3537
	r_ConvertedE4PairAtPtx3540Rs169 = PublishE4(r_PackedHalf2AtPtx2521R1393); // PTX L3540
	r_ConvertedE4PairAtPtx3543Rs170 = PublishE4(r_PackedHalf2AtPtx2535R1454); // PTX L3543
	r_ConvertedE4PairAtPtx3546Rs171 = PublishE4(r_PackedHalf2AtPtx2528R1392); // PTX L3546
	r_ConvertedE4PairAtPtx3549Rs172 = PublishE4(r_PackedHalf2AtPtx2542R1455); // PTX L3549
	r_bPtxPredicate89 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L3551
	r_PtxRegister1307 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_PtxRegister4);		  // PTX L3552
	r_PtxRegister38 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));							  // PTX L3553
	r_PtxRegister1308 = ShiftLeft(uint32_t(r_PtxRegister1307), uint32_t(11));					  // PTX L3554
	r_PtxRegister1309 = uint32_t(r_PtxRegister1308) + uint32_t(r_PtxRegister38);				  // PTX L3555
	r_PtxU64Register236 = uint64_t(int64_t(int32_t(r_PtxRegister1309)) * int64_t(int32_t(4)));	  // PTX L3556
	g_OutputByteAddressAtPtx3557 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register236); // PTX L3557
	r_bPtxPredicate90 = r_bPtxPredicate89 | r_bPtxPredicate88;									  // PTX L3558
	if (r_bPtxPredicate90)
	{
		goto L__BB13_118;
	} // PTX L3559
	r_PackedE4WordAtPtx3560R1319 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3402Rs123, r_ConvertedE4PairAtPtx3405Rs124); // PTX L3560
	r_PackedE4WordAtPtx3561R1318 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3396Rs121, r_ConvertedE4PairAtPtx3399Rs122); // PTX L3561
	r_PackedE4WordAtPtx3562R1317 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3390Rs119, r_ConvertedE4PairAtPtx3393Rs120); // PTX L3562
	r_PackedE4WordAtPtx3563R1316 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3384Rs117, r_ConvertedE4PairAtPtx3387Rs118); // PTX L3563
	r_PackedE4WordAtPtx3564R1314 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3378Rs115, r_ConvertedE4PairAtPtx3381Rs116); // PTX L3564
	r_PackedE4WordAtPtx3565R1313 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3372Rs113, r_ConvertedE4PairAtPtx3375Rs114); // PTX L3565
	r_PackedE4WordAtPtx3566R1312 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3366Rs111, r_ConvertedE4PairAtPtx3369Rs112); // PTX L3566
	r_PackedE4WordAtPtx3567R1311 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3360Rs109, r_ConvertedE4PairAtPtx3363Rs110); // PTX L3567
	r_LaneIndexAtPtx3569 = uint32_t((threadIdx.x & 31u));								 // PTX L3569
	r_PtxU64Register239 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3569)) * int64_t(int32_t(16))); // PTX L3571
	g_OutputByteAddressAtPtx3572 =
		uint64_t(g_OutputByteAddressAtPtx3557) + uint64_t(r_PtxU64Register239); // PTX L3572
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx3572,
					make_uint4(r_PackedE4WordAtPtx3567R1311, r_PackedE4WordAtPtx3566R1312,
							   r_PackedE4WordAtPtx3565R1313,
							   r_PackedE4WordAtPtx3564R1314)); // PTX L3574
	r_LaneIndexAtPtx3577 = uint32_t((threadIdx.x & 31u));	   // PTX L3577
	r_PtxU64Register240 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3577)) * int64_t(int32_t(16))); // PTX L3579
	g_OutputByteAddressAtPtx3580 =
		uint64_t(g_OutputByteAddressAtPtx3557) + uint64_t(r_PtxU64Register240);			   // PTX L3580
	g_OutputByteAddressAtPtx3581 = uint64_t(g_OutputByteAddressAtPtx3580) + uint64_t(512); // PTX L3581
	StoreNoAllocate(g_OutputByteAddressAtPtx3581,
					make_uint4(r_PackedE4WordAtPtx3563R1316, r_PackedE4WordAtPtx3562R1317,
							   r_PackedE4WordAtPtx3561R1318,
							   r_PackedE4WordAtPtx3560R1319));				  // PTX L3583
L__BB13_118:																  // PTX L3585
	r_bPtxPredicate91 = int32_t(r_PtxRegister3) >= int32_t(r_HeightDiv4Bits); // PTX L3586
	r_bPtxPredicate92 = int32_t(r_PtxRegister27) >= int32_t(r_WidthDiv4Bits); // PTX L3587
	r_bPtxPredicate93 = r_bPtxPredicate91 | r_bPtxPredicate92;				  // PTX L3588
	if (r_bPtxPredicate93)
	{
		goto L__BB13_120;
	} // PTX L3589
	r_LaneIndexAtPtx3591 = uint32_t((threadIdx.x & 31u)); // PTX L3591
	r_PtxU64Register244 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3591)) * int64_t(int32_t(16))); // PTX L3593
	g_OutputByteAddressAtPtx3594 =
		uint64_t(g_OutputByteAddressAtPtx3557) + uint64_t(r_PtxU64Register244);				// PTX L3594
	g_OutputByteAddressAtPtx3595 = uint64_t(g_OutputByteAddressAtPtx3594) + uint64_t(8192); // PTX L3595
	r_PackedE4WordAtPtx3596R1324 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3426Rs131, r_ConvertedE4PairAtPtx3429Rs132); // PTX L3596
	r_PackedE4WordAtPtx3597R1323 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3420Rs129, r_ConvertedE4PairAtPtx3423Rs130); // PTX L3597
	r_PackedE4WordAtPtx3598R1322 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3414Rs127, r_ConvertedE4PairAtPtx3417Rs128); // PTX L3598
	r_PackedE4WordAtPtx3599R1321 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3408Rs125, r_ConvertedE4PairAtPtx3411Rs126); // PTX L3599
	StoreNoAllocate(g_OutputByteAddressAtPtx3595,
					make_uint4(r_PackedE4WordAtPtx3599R1321, r_PackedE4WordAtPtx3598R1322,
							   r_PackedE4WordAtPtx3597R1323,
							   r_PackedE4WordAtPtx3596R1324)); // PTX L3601
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));	   // PTX L3604
	r_PtxU64Register246 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3604)) * int64_t(int32_t(16))); // PTX L3606
	g_OutputByteAddressAtPtx3607 =
		uint64_t(g_OutputByteAddressAtPtx3557) + uint64_t(r_PtxU64Register246);				// PTX L3607
	g_OutputByteAddressAtPtx3608 = uint64_t(g_OutputByteAddressAtPtx3607) + uint64_t(8704); // PTX L3608
	r_PackedE4WordAtPtx3609R1329 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3450Rs139, r_ConvertedE4PairAtPtx3453Rs140); // PTX L3609
	r_PackedE4WordAtPtx3610R1328 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3444Rs137, r_ConvertedE4PairAtPtx3447Rs138); // PTX L3610
	r_PackedE4WordAtPtx3611R1327 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3438Rs135, r_ConvertedE4PairAtPtx3441Rs136); // PTX L3611
	r_PackedE4WordAtPtx3612R1326 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3432Rs133, r_ConvertedE4PairAtPtx3435Rs134); // PTX L3612
	StoreNoAllocate(g_OutputByteAddressAtPtx3608,
					make_uint4(r_PackedE4WordAtPtx3612R1326, r_PackedE4WordAtPtx3611R1327,
							   r_PackedE4WordAtPtx3610R1328,
							   r_PackedE4WordAtPtx3609R1329));				   // PTX L3614
L__BB13_120:																   // PTX L3616
	r_bPtxPredicate94 = int32_t(r_PtxRegister4) >= int32_t(r_WidthDiv4Bits);   // PTX L3617
	r_PtxRegister39 = r_PtxRegister3 | 1;									   // PTX L3618
	r_bPtxPredicate95 = int32_t(r_PtxRegister39) >= int32_t(r_HeightDiv4Bits); // PTX L3619
	r_PtxRegister1330 =
		uint32_t(r_PtxRegister3) * uint32_t(r_WidthDiv4Bits) + uint32_t(r_WidthDiv4Bits);		  // PTX L3620
	r_PtxRegister1331 = uint32_t(r_PtxRegister1330) + uint32_t(r_PtxRegister4);					  // PTX L3621
	r_PtxRegister1332 = ShiftLeft(uint32_t(r_PtxRegister1331), uint32_t(11));					  // PTX L3622
	r_PtxRegister1333 = uint32_t(r_PtxRegister1332) + uint32_t(r_PtxRegister38);				  // PTX L3623
	r_PtxU64Register248 = uint64_t(int64_t(int32_t(r_PtxRegister1333)) * int64_t(int32_t(4)));	  // PTX L3624
	g_OutputByteAddressAtPtx3625 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register248); // PTX L3625
	r_bPtxPredicate96 = r_bPtxPredicate95 | r_bPtxPredicate94;									  // PTX L3626
	if (r_bPtxPredicate96)
	{
		goto L__BB13_122;
	} // PTX L3627
	r_LaneIndexAtPtx3629 = uint32_t((threadIdx.x & 31u)); // PTX L3629
	r_PtxU64Register251 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3629)) * int64_t(int32_t(16))); // PTX L3631
	g_OutputByteAddressAtPtx3632 =
		uint64_t(g_OutputByteAddressAtPtx3625) + uint64_t(r_PtxU64Register251); // PTX L3632
	r_PackedE4WordAtPtx3633R1338 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3474Rs147, r_ConvertedE4PairAtPtx3477Rs148); // PTX L3633
	r_PackedE4WordAtPtx3634R1337 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3468Rs145, r_ConvertedE4PairAtPtx3471Rs146); // PTX L3634
	r_PackedE4WordAtPtx3635R1336 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3462Rs143, r_ConvertedE4PairAtPtx3465Rs144); // PTX L3635
	r_PackedE4WordAtPtx3636R1335 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3456Rs141, r_ConvertedE4PairAtPtx3459Rs142); // PTX L3636
	StoreNoAllocate(g_OutputByteAddressAtPtx3632,
					make_uint4(r_PackedE4WordAtPtx3636R1335, r_PackedE4WordAtPtx3635R1336,
							   r_PackedE4WordAtPtx3634R1337,
							   r_PackedE4WordAtPtx3633R1338)); // PTX L3638
	r_LaneIndexAtPtx3641 = uint32_t((threadIdx.x & 31u));	   // PTX L3641
	r_PtxU64Register252 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3641)) * int64_t(int32_t(16))); // PTX L3643
	g_OutputByteAddressAtPtx3644 =
		uint64_t(g_OutputByteAddressAtPtx3625) + uint64_t(r_PtxU64Register252);			   // PTX L3644
	g_OutputByteAddressAtPtx3645 = uint64_t(g_OutputByteAddressAtPtx3644) + uint64_t(512); // PTX L3645
	r_PackedE4WordAtPtx3646R1343 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3498Rs155, r_ConvertedE4PairAtPtx3501Rs156); // PTX L3646
	r_PackedE4WordAtPtx3647R1342 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3492Rs153, r_ConvertedE4PairAtPtx3495Rs154); // PTX L3647
	r_PackedE4WordAtPtx3648R1341 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3486Rs151, r_ConvertedE4PairAtPtx3489Rs152); // PTX L3648
	r_PackedE4WordAtPtx3649R1340 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3480Rs149, r_ConvertedE4PairAtPtx3483Rs150); // PTX L3649
	StoreNoAllocate(g_OutputByteAddressAtPtx3645,
					make_uint4(r_PackedE4WordAtPtx3649R1340, r_PackedE4WordAtPtx3648R1341,
							   r_PackedE4WordAtPtx3647R1342,
							   r_PackedE4WordAtPtx3646R1343));				  // PTX L3651
L__BB13_122:																  // PTX L3653
	r_bPtxPredicate97 = int32_t(r_PtxRegister27) >= int32_t(r_WidthDiv4Bits); // PTX L3654
	r_bPtxPredicate98 = r_bPtxPredicate95 | r_bPtxPredicate97;				  // PTX L3655
	if (r_bPtxPredicate98)
	{
		goto L__BB13_124;
	} // PTX L3656
	r_LaneIndexAtPtx3658 = uint32_t((threadIdx.x & 31u)); // PTX L3658
	r_PtxU64Register256 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3658)) * int64_t(int32_t(16))); // PTX L3660
	g_OutputByteAddressAtPtx3661 =
		uint64_t(g_OutputByteAddressAtPtx3625) + uint64_t(r_PtxU64Register256);				// PTX L3661
	g_OutputByteAddressAtPtx3662 = uint64_t(g_OutputByteAddressAtPtx3661) + uint64_t(8192); // PTX L3662
	r_PackedE4WordAtPtx3663R1348 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3522Rs163, r_ConvertedE4PairAtPtx3525Rs164); // PTX L3663
	r_PackedE4WordAtPtx3664R1347 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3516Rs161, r_ConvertedE4PairAtPtx3519Rs162); // PTX L3664
	r_PackedE4WordAtPtx3665R1346 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3510Rs159, r_ConvertedE4PairAtPtx3513Rs160); // PTX L3665
	r_PackedE4WordAtPtx3666R1345 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3504Rs157, r_ConvertedE4PairAtPtx3507Rs158); // PTX L3666
	StoreNoAllocate(g_OutputByteAddressAtPtx3662,
					make_uint4(r_PackedE4WordAtPtx3666R1345, r_PackedE4WordAtPtx3665R1346,
							   r_PackedE4WordAtPtx3664R1347,
							   r_PackedE4WordAtPtx3663R1348)); // PTX L3668
	r_LaneIndexAtPtx3671 = uint32_t((threadIdx.x & 31u));	   // PTX L3671
	r_PtxU64Register258 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3671)) * int64_t(int32_t(16))); // PTX L3673
	g_OutputByteAddressAtPtx3674 =
		uint64_t(g_OutputByteAddressAtPtx3625) + uint64_t(r_PtxU64Register258);				// PTX L3674
	g_OutputByteAddressAtPtx3675 = uint64_t(g_OutputByteAddressAtPtx3674) + uint64_t(8704); // PTX L3675
	r_PackedE4WordAtPtx3676R1353 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3546Rs171, r_ConvertedE4PairAtPtx3549Rs172); // PTX L3676
	r_PackedE4WordAtPtx3677R1352 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3540Rs169, r_ConvertedE4PairAtPtx3543Rs170); // PTX L3677
	r_PackedE4WordAtPtx3678R1351 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3534Rs167, r_ConvertedE4PairAtPtx3537Rs168); // PTX L3678
	r_PackedE4WordAtPtx3679R1350 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3528Rs165, r_ConvertedE4PairAtPtx3531Rs166); // PTX L3679
	StoreNoAllocate(g_OutputByteAddressAtPtx3675,
					make_uint4(r_PackedE4WordAtPtx3679R1350, r_PackedE4WordAtPtx3678R1351,
							   r_PackedE4WordAtPtx3677R1352,
							   r_PackedE4WordAtPtx3676R1353)); // PTX L3681
L__BB13_124:												   // PTX L3683
	return;													   // PTX L3684
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
