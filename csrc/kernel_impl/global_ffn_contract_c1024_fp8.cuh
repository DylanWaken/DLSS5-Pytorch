// Readable equivalent of cc_vit_1d_ffn_contract_fp8; not the historical C++ file.
#pragma once
#include "global_ffn_contract_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8
{
__global__ __maxnreg__(168) void global_ffn_contract_c1024_fp8(Parameters r_Parameters)
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
	bool r_bPtxPredicate97, r_bPtxPredicate98, r_bPtxPredicate99, r_bPtxPredicate100;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_ConvertedE4PairAtPtx242Rs3, r_PtxU16Register4,
		r_ConvertedE4PairAtPtx297Rs5, r_PtxU16Register6, r_PtxU16Register7, r_ConvertedE4PairAtPtx402Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx463Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx590Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx623Rs14, r_PtxU16Register15,
		r_ConvertedE4PairAtPtx657Rs16, r_PtxU16Register17, r_ConvertedE4PairAtPtx690Rs18, r_PtxU16Register19,
		r_ConvertedE4PairAtPtx724Rs20, r_PtxU16Register21, r_ConvertedE4PairAtPtx757Rs22, r_PtxU16Register23,
		r_ConvertedE4PairAtPtx791Rs24;
	uint16_t r_PtxU16Register25, r_ConvertedE4PairAtPtx824Rs26, r_PtxU16Register27, r_PtxU16Register28,
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
		r_PtxU16Register89, r_PtxU16Register90, r_PtxU16Register91, r_PtxU16Register92,
		r_ConvertedE4PairAtPtx3068Rs93, r_PtxU16Register94, r_ConvertedE4PairAtPtx3119Rs95,
		r_PtxU16Register96;
	uint16_t r_ConvertedE4PairAtPtx3213Rs97, r_PtxU16Register98, r_ConvertedE4PairAtPtx3264Rs99,
		r_ConvertedE4PairAtPtx4996Rs100, r_ConvertedE4PairAtPtx4999Rs101, r_ConvertedE4PairAtPtx5002Rs102,
		r_ConvertedE4PairAtPtx5005Rs103, r_ConvertedE4PairAtPtx5008Rs104, r_ConvertedE4PairAtPtx5011Rs105,
		r_ConvertedE4PairAtPtx5014Rs106, r_ConvertedE4PairAtPtx5017Rs107, r_ConvertedE4PairAtPtx5020Rs108;
	uint16_t r_ConvertedE4PairAtPtx5023Rs109, r_ConvertedE4PairAtPtx5026Rs110,
		r_ConvertedE4PairAtPtx5029Rs111, r_ConvertedE4PairAtPtx5032Rs112, r_ConvertedE4PairAtPtx5035Rs113,
		r_ConvertedE4PairAtPtx5038Rs114, r_ConvertedE4PairAtPtx5041Rs115, r_ConvertedE4PairAtPtx5044Rs116,
		r_ConvertedE4PairAtPtx5047Rs117, r_ConvertedE4PairAtPtx5050Rs118, r_ConvertedE4PairAtPtx5053Rs119,
		r_ConvertedE4PairAtPtx5056Rs120;
	uint16_t r_ConvertedE4PairAtPtx5059Rs121, r_ConvertedE4PairAtPtx5062Rs122,
		r_ConvertedE4PairAtPtx5065Rs123, r_ConvertedE4PairAtPtx5068Rs124, r_ConvertedE4PairAtPtx5071Rs125,
		r_ConvertedE4PairAtPtx5074Rs126, r_ConvertedE4PairAtPtx5077Rs127, r_ConvertedE4PairAtPtx5080Rs128,
		r_ConvertedE4PairAtPtx5083Rs129, r_ConvertedE4PairAtPtx5086Rs130, r_ConvertedE4PairAtPtx5089Rs131,
		r_ConvertedE4PairAtPtx5092Rs132;
	uint16_t r_ConvertedE4PairAtPtx5095Rs133, r_ConvertedE4PairAtPtx5098Rs134,
		r_ConvertedE4PairAtPtx5101Rs135, r_ConvertedE4PairAtPtx5104Rs136, r_ConvertedE4PairAtPtx5107Rs137,
		r_ConvertedE4PairAtPtx5110Rs138, r_ConvertedE4PairAtPtx5113Rs139, r_ConvertedE4PairAtPtx5116Rs140,
		r_ConvertedE4PairAtPtx5119Rs141, r_ConvertedE4PairAtPtx5122Rs142, r_ConvertedE4PairAtPtx5125Rs143,
		r_ConvertedE4PairAtPtx5128Rs144;
	uint16_t r_ConvertedE4PairAtPtx5131Rs145, r_ConvertedE4PairAtPtx5134Rs146,
		r_ConvertedE4PairAtPtx5137Rs147, r_ConvertedE4PairAtPtx5140Rs148, r_ConvertedE4PairAtPtx5143Rs149,
		r_ConvertedE4PairAtPtx5146Rs150, r_ConvertedE4PairAtPtx5149Rs151, r_ConvertedE4PairAtPtx5152Rs152,
		r_ConvertedE4PairAtPtx5155Rs153, r_ConvertedE4PairAtPtx5158Rs154, r_ConvertedE4PairAtPtx5161Rs155,
		r_ConvertedE4PairAtPtx5164Rs156;
	uint16_t r_ConvertedE4PairAtPtx5167Rs157, r_ConvertedE4PairAtPtx5170Rs158,
		r_ConvertedE4PairAtPtx5173Rs159, r_ConvertedE4PairAtPtx5176Rs160, r_ConvertedE4PairAtPtx5179Rs161,
		r_ConvertedE4PairAtPtx5182Rs162, r_ConvertedE4PairAtPtx5185Rs163, r_PtxU16Register164,
		r_PtxU16Register165, r_PtxU16Register166, r_PtxU16Register167;
	uint32_t r_PtxRegister1, r_PtxRegister2, r_PtxRegister3, r_ThreadY, r_PtxRegister5, r_PtxRegister6,
		r_PtxRegister7, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_BatchBits;
	uint32_t r_TokensBits, r_CtaX, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_ThreadX, r_PtxRegister64, r_PtxRegister65, r_PtxRegister66,
		r_PtxRegister67, r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx56R70, r_LaneIndexAtPtx73,
		r_LaneIndexAtPtx81;
	uint32_t r_LaneIndexAtPtx90, r_LaneIndexAtPtx99, r_LaneIndexAtPtx108, r_LaneIndexAtPtx117,
		r_LaneIndexAtPtx126, r_LaneIndexAtPtx135, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81,
		r_PtxRegister82, r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PackedHalf2AtPtx240R98, r_LaneIndexAtPtx246, r_PtxRegister100,
		r_PackedE4WordAtPtx244R101, r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105,
		r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PackedHalf2AtPtx295R109, r_LaneIndexAtPtx301, r_PtxRegister111, r_PackedE4WordAtPtx299R112,
		r_PtxRegister113, r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117,
		r_PtxRegister118, r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PackedHalf2AtPtx400R128, r_LaneIndexAtPtx406, r_PtxRegister130,
		r_PackedE4WordAtPtx404R131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PackedHalf2AtPtx461R145, r_LaneIndexAtPtx467, r_PtxRegister147, r_PackedE4WordAtPtx465R148,
		r_PtxRegister149, r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153,
		r_PtxRegister154, r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PackedHalf2AtPtx588R172,
		r_LaneIndexAtPtx574, r_PtxRegister174, r_PackedHalf2AtPtx621R175, r_LaneIndexAtPtx606,
		r_PtxRegister177, r_PackedHalf2AtPtx655R178, r_LaneIndexAtPtx640, r_PtxRegister180;
	uint32_t r_PackedHalf2AtPtx688R181, r_LaneIndexAtPtx673, r_PtxRegister183, r_PackedHalf2AtPtx722R184,
		r_LaneIndexAtPtx707, r_PtxRegister186, r_PackedHalf2AtPtx755R187, r_LaneIndexAtPtx740,
		r_PtxRegister189, r_PackedHalf2AtPtx789R190, r_LaneIndexAtPtx774, r_PtxRegister192;
	uint32_t r_PackedHalf2AtPtx822R193, r_LaneIndexAtPtx807, r_LaneIndexAtPtx1030, r_LaneIndexAtPtx1044,
		r_LaneIndexAtPtx1058, r_LaneIndexAtPtx1072, r_LaneIndexAtPtx1086, r_LaneIndexAtPtx1101,
		r_LaneIndexAtPtx1115, r_LaneIndexAtPtx1132, r_LaneIndexAtPtx1148, r_LaneIndexAtPtx1163;
	uint32_t r_LaneIndexAtPtx1177, r_LaneIndexAtPtx1194, r_LaneIndexAtPtx1210, r_LaneIndexAtPtx1225,
		r_LaneIndexAtPtx1239, r_LaneIndexAtPtx1256, r_LaneIndexAtPtx1272, r_LaneIndexAtPtx1286,
		r_LaneIndexAtPtx1300, r_LaneIndexAtPtx1314, r_LaneIndexAtPtx1328, r_LaneIndexAtPtx1342;
	uint32_t r_LaneIndexAtPtx1356, r_LaneIndexAtPtx1372, r_LaneIndexAtPtx1388, r_LaneIndexAtPtx1402,
		r_LaneIndexAtPtx1416, r_LaneIndexAtPtx1432, r_LaneIndexAtPtx1448, r_LaneIndexAtPtx1462,
		r_LaneIndexAtPtx1476, r_LaneIndexAtPtx1492, r_LaneIndexAtPtx1508, r_LaneIndexAtPtx1522;
	uint32_t r_LaneIndexAtPtx1536, r_LaneIndexAtPtx1550, r_LaneIndexAtPtx1564, r_LaneIndexAtPtx1578,
		r_LaneIndexAtPtx1592, r_LaneIndexAtPtx1608, r_LaneIndexAtPtx1624, r_LaneIndexAtPtx1638,
		r_LaneIndexAtPtx1652, r_LaneIndexAtPtx1668, r_LaneIndexAtPtx1684, r_LaneIndexAtPtx1698;
	uint32_t r_LaneIndexAtPtx1712, r_LaneIndexAtPtx1728, r_LaneIndexAtPtx1744, r_LaneIndexAtPtx1758,
		r_LaneIndexAtPtx1772, r_LaneIndexAtPtx1786, r_LaneIndexAtPtx1800, r_LaneIndexAtPtx1814,
		r_LaneIndexAtPtx1828, r_LaneIndexAtPtx1844, r_LaneIndexAtPtx1860, r_LaneIndexAtPtx1874;
	uint32_t r_LaneIndexAtPtx1888, r_LaneIndexAtPtx1904, r_LaneIndexAtPtx1920, r_LaneIndexAtPtx1934,
		r_LaneIndexAtPtx1948, r_LaneIndexAtPtx1964, r_LaneIndexAtPtx1980, r_PackedHalf2AtPtx832R260,
		r_PtxRegister261, r_LaneIndexAtPtx1987, r_PackedHalf2AtPtx838R263, r_PtxRegister264;
	uint32_t r_LaneIndexAtPtx1994, r_PackedHalf2AtPtx835R266, r_PtxRegister267, r_LaneIndexAtPtx2001,
		r_PackedHalf2AtPtx841R269, r_PtxRegister270, r_LaneIndexAtPtx2008, r_PackedHalf2AtPtx844R272,
		r_PtxRegister273, r_LaneIndexAtPtx2015, r_PackedHalf2AtPtx850R275, r_PtxRegister276;
	uint32_t r_LaneIndexAtPtx2022, r_PackedHalf2AtPtx847R278, r_PtxRegister279, r_LaneIndexAtPtx2029,
		r_PackedHalf2AtPtx853R281, r_PtxRegister282, r_LaneIndexAtPtx2036, r_PackedHalf2AtPtx856R284,
		r_PtxRegister285, r_LaneIndexAtPtx2043, r_PackedHalf2AtPtx862R287, r_PtxRegister288;
	uint32_t r_LaneIndexAtPtx2050, r_PackedHalf2AtPtx859R290, r_PtxRegister291, r_LaneIndexAtPtx2057,
		r_PackedHalf2AtPtx865R293, r_PtxRegister294, r_LaneIndexAtPtx2064, r_PackedHalf2AtPtx868R296,
		r_PtxRegister297, r_LaneIndexAtPtx2071, r_PackedHalf2AtPtx874R299, r_PtxRegister300;
	uint32_t r_LaneIndexAtPtx2078, r_PackedHalf2AtPtx871R302, r_PtxRegister303, r_LaneIndexAtPtx2085,
		r_PackedHalf2AtPtx877R305, r_PtxRegister306, r_LaneIndexAtPtx2092, r_PackedHalf2AtPtx880R308,
		r_PtxRegister309, r_LaneIndexAtPtx2099, r_PackedHalf2AtPtx886R311, r_PtxRegister312;
	uint32_t r_LaneIndexAtPtx2106, r_PackedHalf2AtPtx883R314, r_PtxRegister315, r_LaneIndexAtPtx2113,
		r_PackedHalf2AtPtx889R317, r_PtxRegister318, r_LaneIndexAtPtx2120, r_PackedHalf2AtPtx892R320,
		r_PtxRegister321, r_LaneIndexAtPtx2127, r_PackedHalf2AtPtx898R323, r_PtxRegister324;
	uint32_t r_LaneIndexAtPtx2134, r_PackedHalf2AtPtx895R326, r_PtxRegister327, r_LaneIndexAtPtx2141,
		r_PackedHalf2AtPtx901R329, r_PtxRegister330, r_LaneIndexAtPtx2148, r_PackedHalf2AtPtx904R332,
		r_PtxRegister333, r_LaneIndexAtPtx2155, r_PackedHalf2AtPtx910R335, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx2162, r_PackedHalf2AtPtx907R338, r_PtxRegister339, r_LaneIndexAtPtx2169,
		r_PackedHalf2AtPtx913R341, r_PtxRegister342, r_LaneIndexAtPtx2176, r_PackedHalf2AtPtx916R344,
		r_PtxRegister345, r_LaneIndexAtPtx2183, r_PackedHalf2AtPtx922R347, r_PtxRegister348;
	uint32_t r_LaneIndexAtPtx2190, r_PackedHalf2AtPtx919R350, r_PtxRegister351, r_LaneIndexAtPtx2197,
		r_PackedHalf2AtPtx925R353, r_PtxRegister354, r_LaneIndexAtPtx2204, r_PackedHalf2AtPtx928R356,
		r_PtxRegister357, r_LaneIndexAtPtx2211, r_PackedHalf2AtPtx934R359, r_PtxRegister360;
	uint32_t r_LaneIndexAtPtx2218, r_PackedHalf2AtPtx931R362, r_PtxRegister363, r_LaneIndexAtPtx2225,
		r_PackedHalf2AtPtx937R365, r_PtxRegister366, r_LaneIndexAtPtx2232, r_PackedHalf2AtPtx940R368,
		r_PtxRegister369, r_LaneIndexAtPtx2239, r_PackedHalf2AtPtx946R371, r_PtxRegister372;
	uint32_t r_LaneIndexAtPtx2246, r_PackedHalf2AtPtx943R374, r_PtxRegister375, r_LaneIndexAtPtx2253,
		r_PackedHalf2AtPtx949R377, r_PtxRegister378, r_LaneIndexAtPtx2260, r_PackedHalf2AtPtx952R380,
		r_PtxRegister381, r_LaneIndexAtPtx2267, r_PackedHalf2AtPtx958R383, r_PtxRegister384;
	uint32_t r_LaneIndexAtPtx2274, r_PackedHalf2AtPtx955R386, r_PtxRegister387, r_LaneIndexAtPtx2281,
		r_PackedHalf2AtPtx961R389, r_PtxRegister390, r_LaneIndexAtPtx2288, r_PackedHalf2AtPtx964R392,
		r_PtxRegister393, r_LaneIndexAtPtx2295, r_PackedHalf2AtPtx970R395, r_PtxRegister396;
	uint32_t r_LaneIndexAtPtx2302, r_PackedHalf2AtPtx967R398, r_PtxRegister399, r_LaneIndexAtPtx2309,
		r_PackedHalf2AtPtx973R401, r_PtxRegister402, r_LaneIndexAtPtx2316, r_PackedHalf2AtPtx976R404,
		r_PtxRegister405, r_LaneIndexAtPtx2323, r_PackedHalf2AtPtx982R407, r_PtxRegister408;
	uint32_t r_LaneIndexAtPtx2330, r_PackedHalf2AtPtx979R410, r_PtxRegister411, r_LaneIndexAtPtx2337,
		r_PackedHalf2AtPtx985R413, r_PtxRegister414, r_LaneIndexAtPtx2344, r_PackedHalf2AtPtx988R416,
		r_PtxRegister417, r_LaneIndexAtPtx2351, r_PackedHalf2AtPtx994R419, r_PtxRegister420;
	uint32_t r_LaneIndexAtPtx2358, r_PackedHalf2AtPtx991R422, r_PtxRegister423, r_LaneIndexAtPtx2365,
		r_PackedHalf2AtPtx997R425, r_PtxRegister426, r_LaneIndexAtPtx2372, r_PackedHalf2AtPtx1001R428,
		r_PtxRegister429, r_LaneIndexAtPtx2379, r_PackedHalf2AtPtx1008R431, r_PtxRegister432;
	uint32_t r_LaneIndexAtPtx2386, r_PackedHalf2AtPtx1004R434, r_PtxRegister435, r_LaneIndexAtPtx2393,
		r_PackedHalf2AtPtx1011R437, r_PtxRegister438, r_LaneIndexAtPtx2400, r_PackedHalf2AtPtx1015R440,
		r_PtxRegister441, r_LaneIndexAtPtx2407, r_PackedHalf2AtPtx1022R443, r_PtxRegister444;
	uint32_t r_LaneIndexAtPtx2414, r_PackedHalf2AtPtx1018R446, r_PtxRegister447, r_LaneIndexAtPtx2421,
		r_PackedHalf2AtPtx1025R449, r_PtxRegister450, r_PtxRegister451, r_PtxRegister452, r_PtxRegister453,
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
	uint32_t r_PtxRegister1021, r_PtxRegister1022, r_LaneIndexAtPtx2453, r_PtxRegister1024,
		r_LaneIndexAtPtx2462, r_PtxRegister1026, r_LaneIndexAtPtx2473, r_PtxRegister1028,
		r_LaneIndexAtPtx2482, r_PtxRegister1030, r_LaneIndexAtPtx2491, r_PtxRegister1032;
	uint32_t r_LaneIndexAtPtx2500, r_PtxRegister1034, r_LaneIndexAtPtx2509, r_PtxRegister1036,
		r_LaneIndexAtPtx2518, r_PtxRegister1038, r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040,
		r_MmaAE4x4WordAtPtx2459R1041, r_MmaAE4x4WordAtPtx2459R1042, r_MmaAE4x4WordAtPtx2470R1043,
		r_MmaAE4x4WordAtPtx2470R1044;
	uint32_t r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		r_MmaAccumulatorHalf2WordAtPtx2527R1047, r_MmaAccumulatorHalf2WordAtPtx2527R1048,
		r_MmaAccumulatorHalf2WordAtPtx2534R1049, r_MmaAccumulatorHalf2WordAtPtx2534R1050,
		r_MmaAccumulatorHalf2WordAtPtx2555R1051, r_MmaAccumulatorHalf2WordAtPtx2555R1052,
		r_MmaAccumulatorHalf2WordAtPtx2562R1053, r_MmaAccumulatorHalf2WordAtPtx2562R1054,
		r_MmaAccumulatorHalf2WordAtPtx2583R1055, r_MmaAccumulatorHalf2WordAtPtx2583R1056;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2590R1057, r_MmaAccumulatorHalf2WordAtPtx2590R1058,
		r_MmaAccumulatorHalf2WordAtPtx2611R1059, r_MmaAccumulatorHalf2WordAtPtx2611R1060,
		r_MmaAccumulatorHalf2WordAtPtx2618R1061, r_MmaAccumulatorHalf2WordAtPtx2618R1062,
		r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		r_MmaAE4x4WordAtPtx2479R1066, r_MmaAE4x4WordAtPtx2488R1067, r_MmaAE4x4WordAtPtx2488R1068;
	uint32_t r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		r_MmaAccumulatorHalf2WordAtPtx2639R1071, r_MmaAccumulatorHalf2WordAtPtx2639R1072,
		r_MmaAccumulatorHalf2WordAtPtx2646R1073, r_MmaAccumulatorHalf2WordAtPtx2646R1074,
		r_MmaAccumulatorHalf2WordAtPtx2667R1075, r_MmaAccumulatorHalf2WordAtPtx2667R1076,
		r_MmaAccumulatorHalf2WordAtPtx2674R1077, r_MmaAccumulatorHalf2WordAtPtx2674R1078,
		r_MmaAccumulatorHalf2WordAtPtx2695R1079, r_MmaAccumulatorHalf2WordAtPtx2695R1080;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2702R1081, r_MmaAccumulatorHalf2WordAtPtx2702R1082,
		r_MmaAccumulatorHalf2WordAtPtx2723R1083, r_MmaAccumulatorHalf2WordAtPtx2723R1084,
		r_MmaAccumulatorHalf2WordAtPtx2730R1085, r_MmaAccumulatorHalf2WordAtPtx2730R1086,
		r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		r_MmaAE4x4WordAtPtx2497R1090, r_MmaAE4x4WordAtPtx2506R1091, r_MmaAE4x4WordAtPtx2506R1092;
	uint32_t r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		r_MmaAccumulatorHalf2WordAtPtx2751R1095, r_MmaAccumulatorHalf2WordAtPtx2751R1096,
		r_MmaAccumulatorHalf2WordAtPtx2758R1097, r_MmaAccumulatorHalf2WordAtPtx2758R1098,
		r_MmaAccumulatorHalf2WordAtPtx2779R1099, r_MmaAccumulatorHalf2WordAtPtx2779R1100,
		r_MmaAccumulatorHalf2WordAtPtx2786R1101, r_MmaAccumulatorHalf2WordAtPtx2786R1102,
		r_MmaAccumulatorHalf2WordAtPtx2807R1103, r_MmaAccumulatorHalf2WordAtPtx2807R1104;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2814R1105, r_MmaAccumulatorHalf2WordAtPtx2814R1106,
		r_MmaAccumulatorHalf2WordAtPtx2835R1107, r_MmaAccumulatorHalf2WordAtPtx2835R1108,
		r_MmaAccumulatorHalf2WordAtPtx2842R1109, r_MmaAccumulatorHalf2WordAtPtx2842R1110,
		r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		r_MmaAE4x4WordAtPtx2515R1114, r_MmaAE4x4WordAtPtx2524R1115, r_MmaAE4x4WordAtPtx2524R1116;
	uint32_t r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		r_MmaAccumulatorHalf2WordAtPtx2863R1119, r_MmaAccumulatorHalf2WordAtPtx2863R1120,
		r_MmaAccumulatorHalf2WordAtPtx2870R1121, r_MmaAccumulatorHalf2WordAtPtx2870R1122,
		r_MmaAccumulatorHalf2WordAtPtx2891R1123, r_MmaAccumulatorHalf2WordAtPtx2891R1124,
		r_MmaAccumulatorHalf2WordAtPtx2898R1125, r_MmaAccumulatorHalf2WordAtPtx2898R1126,
		r_MmaAccumulatorHalf2WordAtPtx2919R1127, r_MmaAccumulatorHalf2WordAtPtx2919R1128;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2926R1129, r_MmaAccumulatorHalf2WordAtPtx2926R1130,
		r_MmaAccumulatorHalf2WordAtPtx2947R1131, r_MmaAccumulatorHalf2WordAtPtx2947R1132,
		r_MmaAccumulatorHalf2WordAtPtx2954R1133, r_MmaAccumulatorHalf2WordAtPtx2954R1134, r_PtxRegister1135,
		r_PtxRegister1136, r_PtxRegister1137, r_PtxRegister1138, r_PtxRegister1139, r_PtxRegister1140;
	uint32_t r_PtxRegister1141, r_PtxRegister1142, r_PtxRegister1143, r_PtxRegister1144, r_PtxRegister1145,
		r_PtxRegister1146, r_PtxRegister1147, r_PtxRegister1148, r_PtxRegister1149, r_PtxRegister1150,
		r_PtxRegister1151, r_PtxRegister1152;
	uint32_t r_PtxRegister1153, r_PtxRegister1154, r_PtxRegister1155, r_PtxRegister1156, r_PtxRegister1157,
		r_PtxRegister1158, r_PtxRegister1159, r_PtxRegister1160, r_PtxRegister1161, r_PtxRegister1162,
		r_PtxRegister1163, r_PtxRegister1164;
	uint32_t r_PtxRegister1165, r_PtxRegister1166, r_PtxRegister1167, r_PackedHalf2AtPtx3066R1168,
		r_LaneIndexAtPtx3072, r_PtxRegister1170, r_PackedE4WordAtPtx3070R1171, r_PtxRegister1172,
		r_PtxRegister1173, r_PtxRegister1174, r_PtxRegister1175, r_PtxRegister1176;
	uint32_t r_PtxRegister1177, r_PackedHalf2AtPtx3117R1178, r_LaneIndexAtPtx3123, r_PtxRegister1180,
		r_PackedE4WordAtPtx3121R1181, r_PtxRegister1182, r_PtxRegister1183, r_PtxRegister1184,
		r_PtxRegister1185, r_PtxRegister1186, r_PtxRegister1187, r_PtxRegister1188;
	uint32_t r_PtxRegister1189, r_PtxRegister1190, r_PtxRegister1191, r_PtxRegister1192, r_PtxRegister1193,
		r_PackedHalf2AtPtx3211R1194, r_LaneIndexAtPtx3217, r_PtxRegister1196, r_PackedE4WordAtPtx3215R1197,
		r_PtxRegister1198, r_PtxRegister1199, r_PtxRegister1200;
	uint32_t r_PtxRegister1201, r_PtxRegister1202, r_PtxRegister1203, r_PackedHalf2AtPtx3262R1204,
		r_LaneIndexAtPtx3268, r_PtxRegister1206, r_PackedE4WordAtPtx3266R1207, r_PtxRegister1208,
		r_PtxRegister1209, r_PtxRegister1210, r_PtxRegister1211, r_PtxRegister1212;
	uint32_t r_PtxRegister1213, r_PtxRegister1214, r_LaneIndexAtPtx3282, r_LaneIndexAtPtx3290,
		r_LaneIndexAtPtx3299, r_LaneIndexAtPtx3308, r_LaneIndexAtPtx3317, r_LaneIndexAtPtx3326,
		r_LaneIndexAtPtx3335, r_LaneIndexAtPtx3344, r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_LaneIndexAtPtx3371, r_PtxRegister1228,
		r_LaneIndexAtPtx3382, r_PtxRegister1230, r_LaneIndexAtPtx3392, r_PtxRegister1232,
		r_LaneIndexAtPtx3401, r_PtxRegister1234, r_LaneIndexAtPtx3410, r_PtxRegister1236;
	uint32_t r_LaneIndexAtPtx3419, r_PtxRegister1238, r_LaneIndexAtPtx3428, r_PtxRegister1240,
		r_LaneIndexAtPtx3437, r_PtxRegister1242, r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244,
		r_MmaAE4x4WordAtPtx3379R1245, r_MmaAE4x4WordAtPtx3379R1246, r_MmaAccumulatorHalf2WordAtPtx3460R1247,
		r_MmaAccumulatorHalf2WordAtPtx3460R1248;
	uint32_t r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		r_MmaAE4x4WordAtPtx3389R1252, r_MmaAccumulatorHalf2WordAtPtx3446R1253,
		r_MmaAccumulatorHalf2WordAtPtx3446R1254, r_MmaAccumulatorHalf2WordAtPtx3467R1255,
		r_MmaAccumulatorHalf2WordAtPtx3467R1256, r_MmaAccumulatorHalf2WordAtPtx3453R1257,
		r_MmaAccumulatorHalf2WordAtPtx3453R1258, r_MmaAccumulatorHalf2WordAtPtx3488R1259,
		r_MmaAccumulatorHalf2WordAtPtx3488R1260;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3474R1261, r_MmaAccumulatorHalf2WordAtPtx3474R1262,
		r_MmaAccumulatorHalf2WordAtPtx3495R1263, r_MmaAccumulatorHalf2WordAtPtx3495R1264,
		r_MmaAccumulatorHalf2WordAtPtx3481R1265, r_MmaAccumulatorHalf2WordAtPtx3481R1266,
		r_MmaAccumulatorHalf2WordAtPtx3516R1267, r_MmaAccumulatorHalf2WordAtPtx3516R1268,
		r_MmaAccumulatorHalf2WordAtPtx3502R1269, r_MmaAccumulatorHalf2WordAtPtx3502R1270,
		r_MmaAccumulatorHalf2WordAtPtx3523R1271, r_MmaAccumulatorHalf2WordAtPtx3523R1272;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3509R1273, r_MmaAccumulatorHalf2WordAtPtx3509R1274,
		r_MmaAccumulatorHalf2WordAtPtx3544R1275, r_MmaAccumulatorHalf2WordAtPtx3544R1276,
		r_MmaAccumulatorHalf2WordAtPtx3530R1277, r_MmaAccumulatorHalf2WordAtPtx3530R1278,
		r_MmaAccumulatorHalf2WordAtPtx3551R1279, r_MmaAccumulatorHalf2WordAtPtx3551R1280,
		r_MmaAccumulatorHalf2WordAtPtx3537R1281, r_MmaAccumulatorHalf2WordAtPtx3537R1282,
		r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284;
	uint32_t r_MmaAE4x4WordAtPtx3398R1285, r_MmaAE4x4WordAtPtx3398R1286,
		r_MmaAccumulatorHalf2WordAtPtx3572R1287, r_MmaAccumulatorHalf2WordAtPtx3572R1288,
		r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		r_MmaAE4x4WordAtPtx3407R1292, r_MmaAccumulatorHalf2WordAtPtx3558R1293,
		r_MmaAccumulatorHalf2WordAtPtx3558R1294, r_MmaAccumulatorHalf2WordAtPtx3579R1295,
		r_MmaAccumulatorHalf2WordAtPtx3579R1296;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3565R1297, r_MmaAccumulatorHalf2WordAtPtx3565R1298,
		r_MmaAccumulatorHalf2WordAtPtx3600R1299, r_MmaAccumulatorHalf2WordAtPtx3600R1300,
		r_MmaAccumulatorHalf2WordAtPtx3586R1301, r_MmaAccumulatorHalf2WordAtPtx3586R1302,
		r_MmaAccumulatorHalf2WordAtPtx3607R1303, r_MmaAccumulatorHalf2WordAtPtx3607R1304,
		r_MmaAccumulatorHalf2WordAtPtx3593R1305, r_MmaAccumulatorHalf2WordAtPtx3593R1306,
		r_MmaAccumulatorHalf2WordAtPtx3628R1307, r_MmaAccumulatorHalf2WordAtPtx3628R1308;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3614R1309, r_MmaAccumulatorHalf2WordAtPtx3614R1310,
		r_MmaAccumulatorHalf2WordAtPtx3635R1311, r_MmaAccumulatorHalf2WordAtPtx3635R1312,
		r_MmaAccumulatorHalf2WordAtPtx3621R1313, r_MmaAccumulatorHalf2WordAtPtx3621R1314,
		r_MmaAccumulatorHalf2WordAtPtx3656R1315, r_MmaAccumulatorHalf2WordAtPtx3656R1316,
		r_MmaAccumulatorHalf2WordAtPtx3642R1317, r_MmaAccumulatorHalf2WordAtPtx3642R1318,
		r_MmaAccumulatorHalf2WordAtPtx3663R1319, r_MmaAccumulatorHalf2WordAtPtx3663R1320;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3649R1321, r_MmaAccumulatorHalf2WordAtPtx3649R1322,
		r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		r_MmaAE4x4WordAtPtx3416R1326, r_MmaAccumulatorHalf2WordAtPtx3684R1327,
		r_MmaAccumulatorHalf2WordAtPtx3684R1328, r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330,
		r_MmaAE4x4WordAtPtx3425R1331, r_MmaAE4x4WordAtPtx3425R1332;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3670R1333, r_MmaAccumulatorHalf2WordAtPtx3670R1334,
		r_MmaAccumulatorHalf2WordAtPtx3691R1335, r_MmaAccumulatorHalf2WordAtPtx3691R1336,
		r_MmaAccumulatorHalf2WordAtPtx3677R1337, r_MmaAccumulatorHalf2WordAtPtx3677R1338,
		r_MmaAccumulatorHalf2WordAtPtx3712R1339, r_MmaAccumulatorHalf2WordAtPtx3712R1340,
		r_MmaAccumulatorHalf2WordAtPtx3698R1341, r_MmaAccumulatorHalf2WordAtPtx3698R1342,
		r_MmaAccumulatorHalf2WordAtPtx3719R1343, r_MmaAccumulatorHalf2WordAtPtx3719R1344;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3705R1345, r_MmaAccumulatorHalf2WordAtPtx3705R1346,
		r_MmaAccumulatorHalf2WordAtPtx3740R1347, r_MmaAccumulatorHalf2WordAtPtx3740R1348,
		r_MmaAccumulatorHalf2WordAtPtx3726R1349, r_MmaAccumulatorHalf2WordAtPtx3726R1350,
		r_MmaAccumulatorHalf2WordAtPtx3747R1351, r_MmaAccumulatorHalf2WordAtPtx3747R1352,
		r_MmaAccumulatorHalf2WordAtPtx3733R1353, r_MmaAccumulatorHalf2WordAtPtx3733R1354,
		r_MmaAccumulatorHalf2WordAtPtx3768R1355, r_MmaAccumulatorHalf2WordAtPtx3768R1356;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3754R1357, r_MmaAccumulatorHalf2WordAtPtx3754R1358,
		r_MmaAccumulatorHalf2WordAtPtx3775R1359, r_MmaAccumulatorHalf2WordAtPtx3775R1360,
		r_MmaAccumulatorHalf2WordAtPtx3761R1361, r_MmaAccumulatorHalf2WordAtPtx3761R1362,
		r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		r_MmaAE4x4WordAtPtx3434R1366, r_MmaAccumulatorHalf2WordAtPtx3796R1367,
		r_MmaAccumulatorHalf2WordAtPtx3796R1368;
	uint32_t r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		r_MmaAE4x4WordAtPtx3443R1372, r_MmaAccumulatorHalf2WordAtPtx3782R1373,
		r_MmaAccumulatorHalf2WordAtPtx3782R1374, r_MmaAccumulatorHalf2WordAtPtx3803R1375,
		r_MmaAccumulatorHalf2WordAtPtx3803R1376, r_MmaAccumulatorHalf2WordAtPtx3789R1377,
		r_MmaAccumulatorHalf2WordAtPtx3789R1378, r_MmaAccumulatorHalf2WordAtPtx3824R1379,
		r_MmaAccumulatorHalf2WordAtPtx3824R1380;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3810R1381, r_MmaAccumulatorHalf2WordAtPtx3810R1382,
		r_MmaAccumulatorHalf2WordAtPtx3831R1383, r_MmaAccumulatorHalf2WordAtPtx3831R1384,
		r_MmaAccumulatorHalf2WordAtPtx3817R1385, r_MmaAccumulatorHalf2WordAtPtx3817R1386,
		r_MmaAccumulatorHalf2WordAtPtx3852R1387, r_MmaAccumulatorHalf2WordAtPtx3852R1388,
		r_MmaAccumulatorHalf2WordAtPtx3838R1389, r_MmaAccumulatorHalf2WordAtPtx3838R1390,
		r_MmaAccumulatorHalf2WordAtPtx3859R1391, r_MmaAccumulatorHalf2WordAtPtx3859R1392;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx3845R1393, r_MmaAccumulatorHalf2WordAtPtx3845R1394,
		r_MmaAccumulatorHalf2WordAtPtx3880R1395, r_MmaAccumulatorHalf2WordAtPtx3880R1396,
		r_MmaAccumulatorHalf2WordAtPtx3866R1397, r_MmaAccumulatorHalf2WordAtPtx3866R1398,
		r_MmaAccumulatorHalf2WordAtPtx3887R1399, r_MmaAccumulatorHalf2WordAtPtx3887R1400,
		r_MmaAccumulatorHalf2WordAtPtx3873R1401, r_MmaAccumulatorHalf2WordAtPtx3873R1402, r_PtxRegister1403,
		r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408, r_PtxRegister1409,
		r_PtxRegister1410, r_PtxRegister1411, r_PtxRegister1412, r_PtxRegister1413, r_PtxRegister1414,
		r_PtxRegister1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_ThreadZAtPtx3897, r_PtxRegister1424, r_PtxRegister1425, r_PtxRegister1426,
		r_PtxRegister1427, r_LaneIndexAtPtx4297;
	uint32_t r_LaneIndexAtPtx4313, r_LaneIndexAtPtx4329, r_LaneIndexAtPtx4345, r_LaneIndexAtPtx4362,
		r_LaneIndexAtPtx4378, r_LaneIndexAtPtx4394, r_LaneIndexAtPtx4410, r_LaneIndexAtPtx4427,
		r_LaneIndexAtPtx4443, r_LaneIndexAtPtx4459, r_LaneIndexAtPtx4475, r_LaneIndexAtPtx4492;
	uint32_t r_LaneIndexAtPtx4508, r_LaneIndexAtPtx4524, r_LaneIndexAtPtx4537, r_LaneIndexAtPtx4548,
		r_LaneIndexAtPtx4555, r_LaneIndexAtPtx4562, r_LaneIndexAtPtx4569, r_LaneIndexAtPtx4576,
		r_LaneIndexAtPtx4583, r_LaneIndexAtPtx4590, r_LaneIndexAtPtx4597, r_LaneIndexAtPtx4604;
	uint32_t r_LaneIndexAtPtx4611, r_LaneIndexAtPtx4618, r_LaneIndexAtPtx4625, r_LaneIndexAtPtx4632,
		r_LaneIndexAtPtx4639, r_LaneIndexAtPtx4646, r_LaneIndexAtPtx4653, r_LaneIndexAtPtx4660,
		r_LaneIndexAtPtx4667, r_LaneIndexAtPtx4674, r_LaneIndexAtPtx4681, r_LaneIndexAtPtx4688;
	uint32_t r_LaneIndexAtPtx4695, r_LaneIndexAtPtx4702, r_LaneIndexAtPtx4709, r_LaneIndexAtPtx4716,
		r_LaneIndexAtPtx4723, r_LaneIndexAtPtx4730, r_LaneIndexAtPtx4737, r_LaneIndexAtPtx4744,
		r_LaneIndexAtPtx4751, r_LaneIndexAtPtx4758, r_LaneIndexAtPtx4765, r_LaneIndexAtPtx4772;
	uint32_t r_LaneIndexAtPtx4779, r_LaneIndexAtPtx4786, r_LaneIndexAtPtx4793, r_LaneIndexAtPtx4800,
		r_LaneIndexAtPtx4807, r_LaneIndexAtPtx4814, r_LaneIndexAtPtx4821, r_LaneIndexAtPtx4828,
		r_LaneIndexAtPtx4835, r_LaneIndexAtPtx4842, r_LaneIndexAtPtx4849, r_LaneIndexAtPtx4856;
	uint32_t r_LaneIndexAtPtx4863, r_LaneIndexAtPtx4870, r_LaneIndexAtPtx4877, r_LaneIndexAtPtx4884,
		r_LaneIndexAtPtx4891, r_LaneIndexAtPtx4898, r_LaneIndexAtPtx4905, r_LaneIndexAtPtx4912,
		r_LaneIndexAtPtx4919, r_LaneIndexAtPtx4926, r_LaneIndexAtPtx4933, r_LaneIndexAtPtx4940;
	uint32_t r_LaneIndexAtPtx4947, r_LaneIndexAtPtx4954, r_LaneIndexAtPtx4961, r_LaneIndexAtPtx4968,
		r_LaneIndexAtPtx4975, r_LaneIndexAtPtx4982, r_LaneIndexAtPtx4989, r_PackedHalf2AtPtx4551R1508,
		r_PackedHalf2AtPtx4565R1509, r_PackedHalf2AtPtx4558R1510, r_PackedHalf2AtPtx4572R1511,
		r_PackedHalf2AtPtx4579R1512;
	uint32_t r_PackedHalf2AtPtx4593R1513, r_PackedHalf2AtPtx4586R1514, r_PackedHalf2AtPtx4600R1515,
		r_PackedHalf2AtPtx4607R1516, r_PackedHalf2AtPtx4621R1517, r_PackedHalf2AtPtx4614R1518,
		r_PackedHalf2AtPtx4628R1519, r_PackedHalf2AtPtx4635R1520, r_PackedHalf2AtPtx4649R1521,
		r_PackedHalf2AtPtx4642R1522, r_PackedHalf2AtPtx4656R1523, r_PackedHalf2AtPtx4663R1524;
	uint32_t r_PackedHalf2AtPtx4677R1525, r_PackedHalf2AtPtx4670R1526, r_PackedHalf2AtPtx4684R1527,
		r_PackedHalf2AtPtx4691R1528, r_PackedHalf2AtPtx4705R1529, r_PackedHalf2AtPtx4698R1530,
		r_PackedHalf2AtPtx4712R1531, r_PackedHalf2AtPtx4719R1532, r_PackedHalf2AtPtx4733R1533,
		r_PackedHalf2AtPtx4726R1534, r_PackedHalf2AtPtx4740R1535, r_PackedHalf2AtPtx4747R1536;
	uint32_t r_PackedHalf2AtPtx4761R1537, r_PackedHalf2AtPtx4754R1538, r_PackedHalf2AtPtx4768R1539,
		r_PackedHalf2AtPtx4775R1540, r_PackedHalf2AtPtx4789R1541, r_PackedHalf2AtPtx4782R1542,
		r_PackedHalf2AtPtx4796R1543, r_PackedHalf2AtPtx4803R1544, r_PackedHalf2AtPtx4817R1545,
		r_PackedHalf2AtPtx4810R1546, r_PackedHalf2AtPtx4824R1547, r_PackedHalf2AtPtx4831R1548;
	uint32_t r_PackedHalf2AtPtx4845R1549, r_PackedHalf2AtPtx4838R1550, r_PackedHalf2AtPtx4852R1551,
		r_PackedHalf2AtPtx4859R1552, r_PackedHalf2AtPtx4873R1553, r_PackedHalf2AtPtx4866R1554,
		r_PackedHalf2AtPtx4880R1555, r_PackedHalf2AtPtx4887R1556, r_PackedHalf2AtPtx4901R1557,
		r_PackedHalf2AtPtx4894R1558, r_PackedHalf2AtPtx4908R1559, r_PackedHalf2AtPtx4915R1560;
	uint32_t r_PackedHalf2AtPtx4929R1561, r_PackedHalf2AtPtx4922R1562, r_PackedHalf2AtPtx4936R1563,
		r_PackedHalf2AtPtx4943R1564, r_PackedHalf2AtPtx4957R1565, r_PackedHalf2AtPtx4950R1566,
		r_PackedHalf2AtPtx4964R1567, r_PackedHalf2AtPtx4971R1568, r_PackedHalf2AtPtx4985R1569,
		r_PackedHalf2AtPtx4978R1570, r_PackedHalf2AtPtx4992R1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_LaneIndexAtPtx5202, r_PackedE4WordAtPtx5200R1576,
		r_PackedE4WordAtPtx5199R1577, r_PackedE4WordAtPtx5198R1578, r_PackedE4WordAtPtx5197R1579,
		r_LaneIndexAtPtx5210, r_PackedE4WordAtPtx5196R1581, r_PackedE4WordAtPtx5195R1582,
		r_PackedE4WordAtPtx5194R1583, r_PackedE4WordAtPtx5193R1584;
	uint32_t r_LaneIndexAtPtx5223, r_PackedE4WordAtPtx5230R1586, r_PackedE4WordAtPtx5229R1587,
		r_PackedE4WordAtPtx5228R1588, r_PackedE4WordAtPtx5227R1589, r_LaneIndexAtPtx5235,
		r_PackedE4WordAtPtx5243R1591, r_PackedE4WordAtPtx5242R1592, r_PackedE4WordAtPtx5241R1593,
		r_PackedE4WordAtPtx5240R1594, r_LaneIndexAtPtx5252, r_PackedE4WordAtPtx5259R1596;
	uint32_t r_PackedE4WordAtPtx5258R1597, r_PackedE4WordAtPtx5257R1598, r_PackedE4WordAtPtx5256R1599,
		r_LaneIndexAtPtx5264, r_PackedE4WordAtPtx5272R1601, r_PackedE4WordAtPtx5271R1602,
		r_PackedE4WordAtPtx5270R1603, r_PackedE4WordAtPtx5269R1604, r_LaneIndexAtPtx5280,
		r_PackedE4WordAtPtx5288R1606, r_PackedE4WordAtPtx5287R1607, r_PackedE4WordAtPtx5286R1608;
	uint32_t r_PackedE4WordAtPtx5285R1609, r_LaneIndexAtPtx5293, r_PackedE4WordAtPtx5301R1611,
		r_PackedE4WordAtPtx5300R1612, r_PackedE4WordAtPtx5299R1613, r_PackedE4WordAtPtx5298R1614,
		r_LaneIndexAtPtx3915, r_LaneIndexAtPtx3927, r_LaneIndexAtPtx3939, r_LaneIndexAtPtx3951,
		r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_LaneIndexAtPtx3968,
		r_LaneIndexAtPtx3980, r_LaneIndexAtPtx3992, r_LaneIndexAtPtx4004, r_PtxRegister1628,
		r_PtxRegister1629, r_PtxRegister1630, r_PtxRegister1631, r_PtxRegister1632;
	uint32_t r_LaneIndexAtPtx4021, r_LaneIndexAtPtx4033, r_LaneIndexAtPtx4045, r_LaneIndexAtPtx4057,
		r_PtxRegister1637, r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640, r_PtxRegister1641,
		r_LaneIndexAtPtx4074, r_LaneIndexAtPtx4086, r_LaneIndexAtPtx4098;
	uint32_t r_LaneIndexAtPtx4110, r_PtxRegister1646, r_PtxRegister1647, r_PtxRegister1648, r_PtxRegister1649,
		r_PtxRegister1650, r_PtxRegister1651, r_PtxRegister1652, r_PtxRegister1653, r_LaneIndexAtPtx4129,
		r_LaneIndexAtPtx4137, r_LaneIndexAtPtx4146;
	uint32_t r_LaneIndexAtPtx4155, r_PtxRegister1658, r_LaneIndexAtPtx4169, r_LaneIndexAtPtx4177,
		r_LaneIndexAtPtx4186, r_LaneIndexAtPtx4195, r_PtxRegister1663, r_LaneIndexAtPtx4209,
		r_LaneIndexAtPtx4217, r_LaneIndexAtPtx4226, r_LaneIndexAtPtx4235, r_PtxRegister1668;
	uint32_t r_LaneIndexAtPtx4248, r_LaneIndexAtPtx4257, r_LaneIndexAtPtx4266, r_LaneIndexAtPtx4275,
		r_ThreadZAtPtx5307, r_PtxRegister1674, r_CtaZ, r_PtxRegister1676, r_PtxRegister1677,
		r_PtxRegister1678, r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_PtxRegister1689, r_PtxRegister1690,
		r_PtxRegister1691, r_PtxRegister1692;
	uint32_t r_PtxRegister1693, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700, r_PtxRegister1701, r_PtxRegister1702,
		r_PtxRegister1703, r_PtxRegister1704;
	uint32_t r_PtxRegister1705, r_PtxRegister1706, r_PtxRegister1707, r_PtxRegister1708, r_PtxRegister1709,
		r_PtxRegister1710, r_PtxRegister1711, r_PackedHalf2AtPtx496R1712, r_PackedHalf2AtPtx497R1713,
		r_PackedHalf2AtPtx498R1714, r_PackedHalf2AtPtx499R1715, r_PackedHalf2AtPtx500R1716;
	uint32_t r_PackedHalf2AtPtx501R1717, r_PackedHalf2AtPtx502R1718, r_PackedHalf2AtPtx503R1719,
		r_PackedHalf2AtPtx504R1720, r_PackedHalf2AtPtx505R1721, r_PackedHalf2AtPtx506R1722,
		r_PackedHalf2AtPtx507R1723, r_PackedHalf2AtPtx508R1724, r_PackedHalf2AtPtx509R1725,
		r_PackedHalf2AtPtx510R1726, r_PackedHalf2AtPtx511R1727, r_PackedHalf2AtPtx512R1728;
	uint32_t r_PackedHalf2AtPtx513R1729, r_PackedHalf2AtPtx514R1730, r_PackedHalf2AtPtx515R1731,
		r_PackedHalf2AtPtx516R1732, r_PackedHalf2AtPtx517R1733, r_PackedHalf2AtPtx518R1734,
		r_PackedHalf2AtPtx519R1735, r_PackedHalf2AtPtx520R1736, r_PackedHalf2AtPtx521R1737,
		r_PackedHalf2AtPtx522R1738, r_PackedHalf2AtPtx523R1739, r_PackedHalf2AtPtx524R1740;
	uint32_t r_PackedHalf2AtPtx525R1741, r_PackedHalf2AtPtx526R1742, r_PackedHalf2AtPtx527R1743,
		r_PackedHalf2AtPtx528R1744, r_PackedHalf2AtPtx529R1745, r_PackedHalf2AtPtx530R1746,
		r_PackedHalf2AtPtx531R1747, r_PackedHalf2AtPtx532R1748, r_PackedHalf2AtPtx533R1749,
		r_PackedHalf2AtPtx534R1750, r_PackedHalf2AtPtx535R1751, r_PackedHalf2AtPtx536R1752;
	uint32_t r_PackedHalf2AtPtx537R1753, r_PackedHalf2AtPtx538R1754, r_PackedHalf2AtPtx539R1755,
		r_PackedHalf2AtPtx540R1756, r_PackedHalf2AtPtx541R1757, r_PackedHalf2AtPtx542R1758,
		r_PackedHalf2AtPtx543R1759, r_PackedHalf2AtPtx544R1760, r_PackedHalf2AtPtx545R1761,
		r_PackedHalf2AtPtx546R1762, r_PackedHalf2AtPtx547R1763, r_PackedHalf2AtPtx548R1764;
	uint32_t r_PackedHalf2AtPtx549R1765, r_PackedHalf2AtPtx550R1766, r_PackedHalf2AtPtx551R1767,
		r_PackedHalf2AtPtx552R1768, r_PackedHalf2AtPtx553R1769, r_PackedHalf2AtPtx554R1770,
		r_PackedHalf2AtPtx555R1771, r_PackedHalf2AtPtx556R1772, r_PackedHalf2AtPtx557R1773,
		r_PackedHalf2AtPtx558R1774, r_PackedHalf2AtPtx559R1775, r_PtxRegister1776;
	uint32_t r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778, r_MmaBE4x4WordAtPtx78R1779,
		r_MmaBE4x4WordAtPtx78R1780, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784, r_MmaBE4x4WordAtPtx96R1785,
		r_MmaBE4x4WordAtPtx96R1786, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788;
	uint32_t r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790, r_MmaBE4x4WordAtPtx105R1791,
		r_MmaBE4x4WordAtPtx105R1792, r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794,
		r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796, r_MmaBE4x4WordAtPtx123R1797,
		r_MmaBE4x4WordAtPtx123R1798, r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800;
	uint32_t r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802, r_MmaBE4x4WordAtPtx132R1803,
		r_MmaBE4x4WordAtPtx132R1804, r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806,
		r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808, r_PtxRegister1809, r_PtxRegister1810,
		r_PtxRegister1811, r_PackedHalf2AtPtx4291R1812;
	uint32_t r_PackedHalf2AtPtx4292R1813, r_PackedHalf2AtPtx4293R1814, r_PackedHalf2AtPtx4294R1815,
		r_PackedHalf2AtPtx4307R1816, r_PackedHalf2AtPtx4308R1817, r_PackedHalf2AtPtx4309R1818,
		r_PackedHalf2AtPtx4310R1819, r_PackedHalf2AtPtx4323R1820, r_PackedHalf2AtPtx4324R1821,
		r_PackedHalf2AtPtx4325R1822, r_PackedHalf2AtPtx4326R1823, r_PackedHalf2AtPtx4339R1824;
	uint32_t r_PackedHalf2AtPtx4340R1825, r_PackedHalf2AtPtx4341R1826, r_PackedHalf2AtPtx4342R1827,
		r_PackedHalf2AtPtx4356R1828, r_PackedHalf2AtPtx4357R1829, r_PackedHalf2AtPtx4358R1830,
		r_PackedHalf2AtPtx4359R1831, r_PackedHalf2AtPtx4372R1832, r_PackedHalf2AtPtx4373R1833,
		r_PackedHalf2AtPtx4374R1834, r_PackedHalf2AtPtx4375R1835, r_PackedHalf2AtPtx4388R1836;
	uint32_t r_PackedHalf2AtPtx4389R1837, r_PackedHalf2AtPtx4390R1838, r_PackedHalf2AtPtx4391R1839,
		r_PackedHalf2AtPtx4404R1840, r_PackedHalf2AtPtx4405R1841, r_PackedHalf2AtPtx4406R1842,
		r_PackedHalf2AtPtx4407R1843, r_PackedHalf2AtPtx4421R1844, r_PackedHalf2AtPtx4422R1845,
		r_PackedHalf2AtPtx4423R1846, r_PackedHalf2AtPtx4424R1847, r_PackedHalf2AtPtx4437R1848;
	uint32_t r_PackedHalf2AtPtx4438R1849, r_PackedHalf2AtPtx4439R1850, r_PackedHalf2AtPtx4440R1851,
		r_PackedHalf2AtPtx4453R1852, r_PackedHalf2AtPtx4454R1853, r_PackedHalf2AtPtx4455R1854,
		r_PackedHalf2AtPtx4456R1855, r_PackedHalf2AtPtx4469R1856, r_PackedHalf2AtPtx4470R1857,
		r_PackedHalf2AtPtx4471R1858, r_PackedHalf2AtPtx4472R1859, r_PackedHalf2AtPtx4486R1860;
	uint32_t r_PackedHalf2AtPtx4487R1861, r_PackedHalf2AtPtx4488R1862, r_PackedHalf2AtPtx4489R1863,
		r_PackedHalf2AtPtx4502R1864, r_PackedHalf2AtPtx4503R1865, r_PackedHalf2AtPtx4504R1866,
		r_PackedHalf2AtPtx4505R1867, r_PackedHalf2AtPtx4518R1868, r_PackedHalf2AtPtx4519R1869,
		r_PackedHalf2AtPtx4520R1870, r_PackedHalf2AtPtx4521R1871, r_PackedHalf2AtPtx4543R1872;
	uint32_t r_PackedHalf2AtPtx4532R1873, r_PackedHalf2AtPtx4533R1874, r_PackedHalf2AtPtx4534R1875;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, r_PtxU64Register3, g_ResidualByteAddressAtPtx569,
		r_PtxU64Register5, g_ScratchByteAddressAtPtx4126, g_ScratchByteAddressAtPtx4166,
		g_ScratchByteAddressAtPtx4206, g_ScratchByteAddressAtPtx4290, g_ScratchByteAddressAtPtx4306,
		g_ScratchByteAddressAtPtx4322, g_ScratchByteAddressAtPtx4338;
	uint64_t g_ScratchByteAddressAtPtx4355, g_ScratchByteAddressAtPtx4371, g_ScratchByteAddressAtPtx4387,
		g_ScratchByteAddressAtPtx4403, g_ScratchByteAddressAtPtx4420, g_ScratchByteAddressAtPtx4436,
		g_ScratchByteAddressAtPtx4452, g_ScratchByteAddressAtPtx4468, g_ScratchByteAddressAtPtx4485,
		g_ScratchByteAddressAtPtx4501, g_ScratchByteAddressAtPtx4517, g_OutputByteAddressAtPtx5191;
	uint64_t g_OutputByteAddressAtPtx5220, g_OutputByteAddressAtPtx5249, g_OutputBaseAddress,
		g_RecordBaseAddress, g_CounterBaseAddress, g_ScratchBaseAddress, g_RecordByteAddressAtPtx76,
		g_RecordByteAddressAtPtx85, g_RecordByteAddressAtPtx94, g_RecordByteAddressAtPtx103,
		g_RecordByteAddressAtPtx112, g_RecordByteAddressAtPtx121;
	uint64_t g_RecordByteAddressAtPtx130, g_RecordByteAddressAtPtx139, r_PtxU64Register39,
		g_RecordByteAddressAtPtx71, r_PtxU64Register41, r_PtxU64Register42, g_RecordByteAddressAtPtx84,
		r_PtxU64Register44, g_RecordByteAddressAtPtx93, r_PtxU64Register46, g_RecordByteAddressAtPtx102,
		r_PtxU64Register48;
	uint64_t g_RecordByteAddressAtPtx111, r_PtxU64Register50, g_RecordByteAddressAtPtx120, r_PtxU64Register52,
		g_RecordByteAddressAtPtx129, r_PtxU64Register54, g_RecordByteAddressAtPtx138, r_PtxU64Register56,
		r_PtxU64Register57, r_PtxU64Register58, r_PtxU64Register59, r_PtxU64Register60;
	uint64_t r_PtxU64Register61, r_PtxU64Register62, r_PtxU64Register63, r_PtxU64Register64,
		r_PtxU64Register65, r_PtxU64Register66, r_PtxU64Register67, r_PtxU64Register68, r_PtxU64Register69,
		r_PtxU64Register70, r_PtxU64Register71, r_PtxU64Register72;
	uint64_t r_PtxU64Register73, r_PtxU64Register74, g_ResidualByteAddressAtPtx577, r_PtxU64Register76,
		g_ResidualByteAddressAtPtx610, r_PtxU64Register78, g_ResidualByteAddressAtPtx609,
		g_ResidualByteAddressAtPtx644, r_PtxU64Register81, g_ResidualByteAddressAtPtx643,
		g_ResidualByteAddressAtPtx677, r_PtxU64Register84;
	uint64_t g_ResidualByteAddressAtPtx676, g_ResidualByteAddressAtPtx711, r_PtxU64Register87,
		g_ResidualByteAddressAtPtx710, g_ResidualByteAddressAtPtx744, r_PtxU64Register90,
		g_ResidualByteAddressAtPtx743, g_ResidualByteAddressAtPtx778, r_PtxU64Register93,
		g_ResidualByteAddressAtPtx777, g_ResidualByteAddressAtPtx811, r_PtxU64Register96;
	uint64_t g_ResidualByteAddressAtPtx810, g_RecordByteAddressAtPtx1027, r_PtxU64Register99,
		g_RecordByteAddressAtPtx1041, r_PtxU64Register101, g_RecordByteAddressAtPtx1055, r_PtxU64Register103,
		g_RecordByteAddressAtPtx1069, r_PtxU64Register105, g_RecordByteAddressAtPtx1083, r_PtxU64Register107,
		g_RecordByteAddressAtPtx1098;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx1112, r_PtxU64Register111,
		g_RecordByteAddressAtPtx1129, r_PtxU64Register113, g_RecordByteAddressAtPtx1145, r_PtxU64Register115,
		g_RecordByteAddressAtPtx1160, r_PtxU64Register117, g_RecordByteAddressAtPtx1174, r_PtxU64Register119,
		g_RecordByteAddressAtPtx1191;
	uint64_t r_PtxU64Register121, g_RecordByteAddressAtPtx1207, r_PtxU64Register123,
		g_RecordByteAddressAtPtx1222, r_PtxU64Register125, g_RecordByteAddressAtPtx1236, r_PtxU64Register127,
		g_RecordByteAddressAtPtx1253, r_PtxU64Register129, g_RecordByteAddressAtPtx1269, r_PtxU64Register131,
		g_RecordByteAddressAtPtx1283;
	uint64_t r_PtxU64Register133, g_RecordByteAddressAtPtx1297, r_PtxU64Register135,
		g_RecordByteAddressAtPtx1311, r_PtxU64Register137, g_RecordByteAddressAtPtx1325, r_PtxU64Register139,
		g_RecordByteAddressAtPtx1339, r_PtxU64Register141, g_RecordByteAddressAtPtx1353, r_PtxU64Register143,
		g_RecordByteAddressAtPtx1369;
	uint64_t r_PtxU64Register145, g_RecordByteAddressAtPtx1385, r_PtxU64Register147,
		g_RecordByteAddressAtPtx1399, r_PtxU64Register149, g_RecordByteAddressAtPtx1413, r_PtxU64Register151,
		g_RecordByteAddressAtPtx1429, r_PtxU64Register153, g_RecordByteAddressAtPtx1445, r_PtxU64Register155,
		g_RecordByteAddressAtPtx1459;
	uint64_t r_PtxU64Register157, g_RecordByteAddressAtPtx1473, r_PtxU64Register159,
		g_RecordByteAddressAtPtx1489, r_PtxU64Register161, g_RecordByteAddressAtPtx1505, r_PtxU64Register163,
		g_RecordByteAddressAtPtx1519, r_PtxU64Register165, g_RecordByteAddressAtPtx1533, r_PtxU64Register167,
		g_RecordByteAddressAtPtx1547;
	uint64_t r_PtxU64Register169, g_RecordByteAddressAtPtx1561, r_PtxU64Register171,
		g_RecordByteAddressAtPtx1575, r_PtxU64Register173, g_RecordByteAddressAtPtx1589, r_PtxU64Register175,
		g_RecordByteAddressAtPtx1605, r_PtxU64Register177, g_RecordByteAddressAtPtx1621, r_PtxU64Register179,
		g_RecordByteAddressAtPtx1635;
	uint64_t r_PtxU64Register181, g_RecordByteAddressAtPtx1649, r_PtxU64Register183,
		g_RecordByteAddressAtPtx1665, r_PtxU64Register185, g_RecordByteAddressAtPtx1681, r_PtxU64Register187,
		g_RecordByteAddressAtPtx1695, r_PtxU64Register189, g_RecordByteAddressAtPtx1709, r_PtxU64Register191,
		g_RecordByteAddressAtPtx1725;
	uint64_t r_PtxU64Register193, g_RecordByteAddressAtPtx1741, r_PtxU64Register195,
		g_RecordByteAddressAtPtx1755, r_PtxU64Register197, g_RecordByteAddressAtPtx1769, r_PtxU64Register199,
		g_RecordByteAddressAtPtx1783, r_PtxU64Register201, g_RecordByteAddressAtPtx1797, r_PtxU64Register203,
		g_RecordByteAddressAtPtx1811;
	uint64_t r_PtxU64Register205, g_RecordByteAddressAtPtx1825, r_PtxU64Register207,
		g_RecordByteAddressAtPtx1841, r_PtxU64Register209, g_RecordByteAddressAtPtx1857, r_PtxU64Register211,
		g_RecordByteAddressAtPtx1871, r_PtxU64Register213, g_RecordByteAddressAtPtx1885, r_PtxU64Register215,
		g_RecordByteAddressAtPtx1901;
	uint64_t r_PtxU64Register217, g_RecordByteAddressAtPtx1917, r_PtxU64Register219,
		g_RecordByteAddressAtPtx1931, r_PtxU64Register221, g_RecordByteAddressAtPtx1945, r_PtxU64Register223,
		g_RecordByteAddressAtPtx1961, r_PtxU64Register225, g_RecordByteAddressAtPtx1977, r_PtxU64Register227,
		r_PtxU64Register228;
	uint64_t r_PtxU64Register229, r_PtxU64Register230, r_PtxU64Register231, r_PtxU64Register232,
		r_PtxU64Register233, r_PtxU64Register234, r_PtxU64Register235, r_PtxU64Register236,
		r_PtxU64Register237, r_PtxU64Register238, r_PtxU64Register239, r_PtxU64Register240;
	uint64_t r_PtxU64Register241, r_PtxU64Register242, r_PtxU64Register243, r_PtxU64Register244,
		g_RecordByteAddressAtPtx3285, g_RecordByteAddressAtPtx3294, g_RecordByteAddressAtPtx3303,
		g_RecordByteAddressAtPtx3312, g_RecordByteAddressAtPtx3321, g_RecordByteAddressAtPtx3330,
		g_RecordByteAddressAtPtx3339, g_RecordByteAddressAtPtx3348;
	uint64_t r_PtxU64Register253, g_RecordByteAddressAtPtx3280, r_PtxU64Register255, r_PtxU64Register256,
		g_RecordByteAddressAtPtx3293, r_PtxU64Register258, g_RecordByteAddressAtPtx3302, r_PtxU64Register260,
		g_RecordByteAddressAtPtx3311, r_PtxU64Register262, g_RecordByteAddressAtPtx3320, r_PtxU64Register264;
	uint64_t g_RecordByteAddressAtPtx3329, r_PtxU64Register266, g_RecordByteAddressAtPtx3338,
		r_PtxU64Register268, g_RecordByteAddressAtPtx3347, r_PtxU64Register270, r_PtxU64Register271,
		r_PtxU64Register272, g_ScratchByteAddressAtPtx4300, r_PtxU64Register274,
		g_ScratchByteAddressAtPtx4316, r_PtxU64Register276;
	uint64_t g_ScratchByteAddressAtPtx4332, r_PtxU64Register278, g_ScratchByteAddressAtPtx4348,
		r_PtxU64Register280, g_ScratchByteAddressAtPtx4365, r_PtxU64Register282,
		g_ScratchByteAddressAtPtx4381, r_PtxU64Register284, g_ScratchByteAddressAtPtx4397,
		r_PtxU64Register286, g_ScratchByteAddressAtPtx4413, r_PtxU64Register288;
	uint64_t g_ScratchByteAddressAtPtx4430, r_PtxU64Register290, g_ScratchByteAddressAtPtx4446,
		r_PtxU64Register292, g_ScratchByteAddressAtPtx4462, r_PtxU64Register294,
		g_ScratchByteAddressAtPtx4478, r_PtxU64Register296, g_ScratchByteAddressAtPtx4495,
		r_PtxU64Register298, g_ScratchByteAddressAtPtx4511, r_PtxU64Register300;
	uint64_t g_ScratchByteAddressAtPtx4527, r_PtxU64Register302, g_ScratchByteAddressAtPtx4541,
		r_PtxU64Register304, g_ScratchByteAddressAtPtx4540, r_PtxU64Register306, g_OutputByteAddressAtPtx5205,
		g_OutputByteAddressAtPtx5214, r_PtxU64Register309, r_PtxU64Register310, g_OutputByteAddressAtPtx5213,
		g_OutputByteAddressAtPtx5226;
	uint64_t g_OutputByteAddressAtPtx5239, r_PtxU64Register314, r_PtxU64Register315,
		g_OutputByteAddressAtPtx5238, g_OutputByteAddressAtPtx5255, g_OutputByteAddressAtPtx5268,
		r_PtxU64Register319, r_PtxU64Register320, g_OutputByteAddressAtPtx5267, g_OutputByteAddressAtPtx5284,
		g_OutputByteAddressAtPtx5297, r_PtxU64Register324;
	uint64_t g_OutputByteAddressAtPtx5283, r_PtxU64Register326, g_OutputByteAddressAtPtx5296,
		r_PtxU64Register328, r_PtxU64Register329, r_PtxU64Register330, r_PtxU64Register331,
		r_PtxU64Register332, r_PtxU64Register333, r_PtxU64Register334, r_PtxU64Register335,
		r_PtxU64Register336;
	uint64_t r_PtxU64Register337, r_PtxU64Register338, r_PtxU64Register339, r_PtxU64Register340,
		r_PtxU64Register341, r_PtxU64Register342, r_PtxU64Register343, r_PtxU64Register344,
		r_PtxU64Register345, r_PtxU64Register346, r_PtxU64Register347, r_PtxU64Register348;
	uint64_t r_PtxU64Register349, r_PtxU64Register350, r_PtxU64Register351, r_PtxU64Register352,
		r_PtxU64Register353, r_PtxU64Register354, r_PtxU64Register355, r_PtxU64Register356,
		r_PtxU64Register357, r_PtxU64Register358, r_PtxU64Register359, r_PtxU64Register360;
	uint64_t r_PtxU64Register361, r_PtxU64Register362, r_PtxU64Register363, r_PtxU64Register364,
		r_PtxU64Register365, r_PtxU64Register366, r_PtxU64Register367, r_PtxU64Register368,
		r_PtxU64Register369, r_PtxU64Register370, r_PtxU64Register371, r_PtxU64Register372;
	uint64_t r_PtxU64Register373, r_PtxU64Register374, r_PtxU64Register375, r_PtxU64Register376,
		r_PtxU64Register377, r_PtxU64Register378, r_PtxU64Register379, r_PtxU64Register380,
		r_PtxU64Register381, r_PtxU64Register382, r_PtxU64Register383, r_PtxU64Register384;
	uint64_t r_PtxU64Register385, r_PtxU64Register386, r_PtxU64Register387, r_PtxU64Register388,
		r_PtxU64Register389, r_PtxU64Register390, r_PtxU64Register391, r_PtxU64Register392,
		r_PtxU64Register393, r_PtxU64Register394, r_PtxU64Register395, r_PtxU64Register396;
	uint64_t r_PtxU64Register397, r_PtxU64Register398, r_PtxU64Register399, r_PtxU64Register400,
		r_PtxU64Register401, r_PtxU64Register402, r_PtxU64Register403, r_PtxU64Register404,
		r_PtxU64Register405, r_PtxU64Register406, r_PtxU64Register407, r_PtxU64Register408;
	uint64_t g_ScratchByteAddressAtPtx4132, g_ScratchByteAddressAtPtx4141, g_ScratchByteAddressAtPtx4150,
		g_ScratchByteAddressAtPtx4159, r_PtxU64Register413, r_PtxU64Register414,
		g_ScratchByteAddressAtPtx4140, r_PtxU64Register416, g_ScratchByteAddressAtPtx4149,
		r_PtxU64Register418, g_ScratchByteAddressAtPtx4158, g_ScratchByteAddressAtPtx4172;
	uint64_t g_ScratchByteAddressAtPtx4181, g_ScratchByteAddressAtPtx4190, g_ScratchByteAddressAtPtx4199,
		r_PtxU64Register424, r_PtxU64Register425, g_ScratchByteAddressAtPtx4180, r_PtxU64Register427,
		g_ScratchByteAddressAtPtx4189, r_PtxU64Register429, g_ScratchByteAddressAtPtx4198,
		g_ScratchByteAddressAtPtx4212, g_ScratchByteAddressAtPtx4221;
	uint64_t g_ScratchByteAddressAtPtx4230, g_ScratchByteAddressAtPtx4239, r_PtxU64Register435,
		r_PtxU64Register436, g_ScratchByteAddressAtPtx4220, r_PtxU64Register438,
		g_ScratchByteAddressAtPtx4229, r_PtxU64Register440, g_ScratchByteAddressAtPtx4238,
		g_ScratchByteAddressAtPtx4252, g_ScratchByteAddressAtPtx4261, g_ScratchByteAddressAtPtx4270;
	uint64_t g_ScratchByteAddressAtPtx4279, r_PtxU64Register446, g_ScratchByteAddressAtPtx4251,
		r_PtxU64Register448, g_ScratchByteAddressAtPtx4260, r_PtxU64Register450,
		g_ScratchByteAddressAtPtx4269, r_PtxU64Register452, g_ScratchByteAddressAtPtx4278,
		g_CounterByteAddress, r_PtxU64Register455, r_PtxU64Register456;
	uint64_t r_PtxU64Register457, r_PtxU64Register458, r_PtxU64Register459, r_PtxU64Register460,
		r_PtxU64Register461, r_PtxU64Register462, r_PtxU64Register463, r_PtxU64Register464,
		r_PtxU64Register465, r_PtxU64Register466, r_PtxU64Register467, r_PtxU64Register468;
	uint64_t r_PtxU64Register469, r_PtxU64Register470, r_PtxU64Register471, r_PtxU64Register472;
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
	r_PtxRegister51 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits) + uint32_t(-1); // PTX L23
	r_PtxRegister52 = ShiftRightSigned(int32_t(r_PtxRegister51), uint32_t(31));		 // PTX L24
	r_PtxRegister53 = ShiftRight(uint32_t(r_PtxRegister52), uint32_t(25));			 // PTX L25
	r_PtxRegister54 = uint32_t(r_PtxRegister51) + uint32_t(r_PtxRegister53);		 // PTX L26
	r_PtxRegister55 = ShiftRightSigned(int32_t(r_PtxRegister54), uint32_t(7));		 // PTX L27
	r_PtxRegister56 = uint32_t(r_PtxRegister55) + uint32_t(1);						 // PTX L28
	r_PtxRegister1 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister56));			 // PTX L29
	r_PtxRegister57 =
		uint32_t(r_PtxRegister1) * uint32_t(r_PtxRegister55) + uint32_t(r_PtxRegister1); // PTX L30
	r_PtxRegister58 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister57);						 // PTX L31
	r_PtxRegister2 = ShiftLeft(uint32_t(r_PtxRegister58), uint32_t(3));					 // PTX L32
	r_PtxRegister59 = ShiftRight(uint32_t(r_PtxRegister52), uint32_t(27));				 // PTX L33
	r_PtxRegister60 = uint32_t(r_PtxRegister51) + uint32_t(r_PtxRegister59);			 // PTX L34
	r_PtxRegister61 = r_PtxRegister60 & -32;											 // PTX L35
	r_PtxRegister62 = uint32_t(r_PtxRegister61) + uint32_t(32);							 // PTX L36
	r_PtxRegister3 = ShiftRightSigned(int32_t(r_PtxRegister62), uint32_t(4));			 // PTX L37
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L38
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L39
	r_PtxRegister64 = r_ThreadX | r_ThreadY;											 // PTX L40
	r_bPtxPredicate1 = uint32_t(r_PtxRegister64) != uint32_t(0);						 // PTX L41
	if (r_bPtxPredicate1)
	{
		goto L__BB46_2;
	} // PTX L42
	r_BlockSizeX = uint32_t(blockDim.x);							   // PTX L43
	r_BlockSizeY = uint32_t(blockDim.y);							   // PTX L44
	r_PtxRegister66 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY); // PTX L45
	r_PtxRegister65 = uint32_t(16384u /* native mbarriers */);		   // PTX L46
	// Original staged-copy barrier initialization.
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister65, r_PtxRegister66); // PTX L48
	r_PtxRegister67 = uint32_t(r_PtxRegister65) + uint32_t(8);		// PTX L50
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister67, r_PtxRegister66); // PTX L52
L__BB46_2:															// PTX L54
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L55
	r_Float32BitsAtPtx56R70 = uint32_t(0);														// PTX L56
	r_PackedHalf2AtPtx4543R1872 = FloatToHalf2(r_Float32BitsAtPtx56R70);						// PTX L58
	r_PtxRegister79 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L63
	r_PtxRegister80 = r_PtxRegister79 & 64;														// PTX L64
	r_PtxRegister81 = ShiftLeft(uint32_t(r_PtxRegister1), uint32_t(7));							// PTX L65
	r_PtxRegister5 = r_PtxRegister80 | r_PtxRegister81;											// PTX L66
	r_PtxRegister82 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(18));								// PTX L67
	r_PtxRegister83 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(3));							// PTX L68
	r_PtxRegister84 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister83);					// PTX L69
	r_PtxU64Register39 = uint64_t(int64_t(int32_t(r_PtxRegister84)) * int64_t(int32_t(4)));		// PTX L70
	g_RecordByteAddressAtPtx71 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register39);	// PTX L71
	r_LaneIndexAtPtx73 = uint32_t((threadIdx.x & 31u));											// PTX L73
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx73)) * int64_t(int32_t(16))); // PTX L75
	g_RecordByteAddressAtPtx76 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register41); // PTX L76
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx76));
		r_MmaBE4x4WordAtPtx78R1777 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R1778 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R1779 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R1780 = r_Value.w;
	} // PTX L78
	r_LaneIndexAtPtx81 = uint32_t((threadIdx.x & 31u));											// PTX L81
	r_PtxU64Register42 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx81)) * int64_t(int32_t(16))); // PTX L83
	g_RecordByteAddressAtPtx84 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register42);		   // PTX L84
	g_RecordByteAddressAtPtx85 = uint64_t(g_RecordByteAddressAtPtx84) + uint64_t(512); // PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx85));
		r_MmaBE4x4WordAtPtx87R1781 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R1782 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R1783 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R1784 = r_Value.w;
	} // PTX L87
	r_LaneIndexAtPtx90 = uint32_t((threadIdx.x & 31u));											// PTX L90
	r_PtxU64Register44 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx90)) * int64_t(int32_t(16))); // PTX L92
	g_RecordByteAddressAtPtx93 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register44);			// PTX L93
	g_RecordByteAddressAtPtx94 = uint64_t(g_RecordByteAddressAtPtx93) + uint64_t(1024); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBE4x4WordAtPtx96R1785 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1786 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1787 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1788 = r_Value.w;
	} // PTX L96
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register46 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	g_RecordByteAddressAtPtx102 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register46);			  // PTX L102
	g_RecordByteAddressAtPtx103 = uint64_t(g_RecordByteAddressAtPtx102) + uint64_t(1536); // PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx103));
		r_MmaBE4x4WordAtPtx105R1789 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1790 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1791 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1792 = r_Value.w;
	} // PTX L105
	r_LaneIndexAtPtx108 = uint32_t((threadIdx.x & 31u));										 // PTX L108
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx108)) * int64_t(int32_t(16))); // PTX L110
	g_RecordByteAddressAtPtx111 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register48);			   // PTX L111
	g_RecordByteAddressAtPtx112 = uint64_t(g_RecordByteAddressAtPtx111) + uint64_t(32768); // PTX L112
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx112));
		r_MmaBE4x4WordAtPtx114R1793 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R1794 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R1795 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R1796 = r_Value.w;
	} // PTX L114
	r_LaneIndexAtPtx117 = uint32_t((threadIdx.x & 31u));										 // PTX L117
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx117)) * int64_t(int32_t(16))); // PTX L119
	g_RecordByteAddressAtPtx120 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register50);			   // PTX L120
	g_RecordByteAddressAtPtx121 = uint64_t(g_RecordByteAddressAtPtx120) + uint64_t(33280); // PTX L121
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx121));
		r_MmaBE4x4WordAtPtx123R1797 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R1798 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R1799 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R1800 = r_Value.w;
	} // PTX L123
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_RecordByteAddressAtPtx129 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register52);			   // PTX L129
	g_RecordByteAddressAtPtx130 = uint64_t(g_RecordByteAddressAtPtx129) + uint64_t(33792); // PTX L130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx130));
		r_MmaBE4x4WordAtPtx132R1801 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R1802 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R1803 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R1804 = r_Value.w;
	} // PTX L132
	r_LaneIndexAtPtx135 = uint32_t((threadIdx.x & 31u));										 // PTX L135
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx135)) * int64_t(int32_t(16))); // PTX L137
	g_RecordByteAddressAtPtx138 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register54);			   // PTX L138
	g_RecordByteAddressAtPtx139 = uint64_t(g_RecordByteAddressAtPtx138) + uint64_t(34304); // PTX L139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx139));
		r_MmaBE4x4WordAtPtx141R1805 = r_Value.x;
		r_MmaBE4x4WordAtPtx141R1806 = r_Value.y;
		r_MmaBE4x4WordAtPtx141R1807 = r_Value.z;
		r_MmaBE4x4WordAtPtx141R1808 = r_Value.w;
	} // PTX L141
	r_PtxRegister6 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(8));					 // PTX L143
	r_PtxRegister7 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister2);				 // PTX L144
	r_bPtxPredicate2 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);			 // PTX L145
	r_bPtxPredicate3 = int32_t(r_PtxRegister7) < int32_t(r_PtxRegister3);			 // PTX L146
	r_PtxRegister85 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(12));					 // PTX L147
	r_PtxRegister86 = ShiftLeft(uint32_t(r_PtxRegister7), uint32_t(14));			 // PTX L148
	r_PtxRegister8 = uint32_t(r_PtxRegister86) + uint32_t(r_PtxRegister85);			 // PTX L149
	r_PtxRegister9 = r_bPtxPredicate3 ? r_PtxRegister8 : 0;							 // PTX L150
	r_PtxU64Register56 = uint64_t(uint32_t(r_PtxRegister6)) * uint64_t(uint32_t(4)); // PTX L151
	r_PtxRegister87 = uint32_t(0u /* native shared input */);						 // PTX L152
	r_PtxU64Register57 = uint64_t(r_PtxRegister87);									 // PTX L153
	r_PtxU64Register58 = SharedGeneric(s_SharedStorage, r_PtxU64Register57);		 // PTX L154
	r_PtxU64Register3 = uint64_t(r_PtxU64Register58) + uint64_t(r_PtxU64Register56); // PTX L155
	r_PtxU16Register164 = uint16_t(0);												 // PTX L156
	r_PtxU64Register455 = uint64_t(0);												 // PTX L157
	r_PtxRegister1676 = uint32_t(128);												 // PTX L158
	r_PtxRegister1677 = uint32_t(r_PtxRegister1676);								 // PTX L159
	r_PtxU64Register456 = uint64_t(r_PtxU64Register455);							 // PTX L160
	if (r_bPtxPredicate2)
	{
		goto L__BB46_4;
	} // PTX L161
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_PtxRegister9)) * int64_t(int32_t(4))); // PTX L162
	r_PtxU64Register455 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register59);	   // PTX L163
	r_PtxRegister1677 = uint32_t(r_PtxRegister6) + uint32_t(128);						   // PTX L164
	r_PtxRegister1676 = uint32_t(r_PtxRegister9) + uint32_t(128);						   // PTX L165
	r_PtxU16Register164 = uint16_t(1);													   // PTX L166
	r_PtxU64Register456 = uint64_t(r_PtxU64Register3);									   // PTX L167
L__BB46_4:																				   // PTX L168
	r_bPtxPredicate4 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);				   // PTX L169
	if (r_bPtxPredicate4)
	{
		goto L__BB46_6;
	} // PTX L170
	r_PtxRegister88 = uint32_t(r_PtxRegister6) + uint32_t(128);					 // PTX L171
	r_PtxRegister89 = uint32_t(r_PtxRegister8) + uint32_t(128);					 // PTX L172
	r_bPtxPredicate5 = uint32_t(r_PtxRegister88) == uint32_t(r_PtxRegister1677); // PTX L173
	r_bPtxPredicate6 = uint32_t(r_PtxRegister89) == uint32_t(r_PtxRegister1676); // PTX L174
	r_PtxU16Register1 = r_bPtxPredicate6 ? r_PtxU16Register164 : 0;				 // PTX L175
	r_PtxU16Register164 = r_bPtxPredicate5 ? r_PtxU16Register1 : 0;				 // PTX L176
L__BB46_6:																		 // PTX L177
	r_bPtxPredicate7 = uint16_t(r_PtxU16Register164) == uint16_t(0);			 // PTX L178
	if (r_bPtxPredicate7)
	{
		goto L__BB46_9;
	} // PTX L179
	r_PtxRegister91 = uint32_t(-1);								 // PTX L180
	r_PtxRegister90 = Elected(r_PtxRegister91);					 // PTX L182
	r_bPtxPredicate8 = uint32_t(r_PtxRegister90) == uint32_t(0); // PTX L188
	if (r_bPtxPredicate8)
	{
		goto L__BB46_23;
	} // PTX L189
	r_PtxU64Register61 = SharedOffset(s_SharedStorage, r_PtxU64Register456); // PTX L190
	r_PtxRegister92 = uint32_t(r_PtxU64Register61);							 // PTX L191
	r_PtxU64Register60 = r_PtxU64Register455;								 // PTX L192
	r_PtxRegister94 = uint32_t(16384u /* native mbarriers */);				 // PTX L193
	r_PtxRegister93 = uint32_t(1024);										 // PTX L194
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister92, r_PtxU64Register60, r_PtxRegister93,
			 r_PtxRegister94);											   // PTX L196
	BarrierExpect(s_SharedStorage, r_PtxRegister94, r_PtxRegister93);	   // PTX L199
	goto L__BB46_23;													   // PTX L201
L__BB46_9:																   // PTX L202
	r_bPtxPredicate9 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3); // PTX L203
	r_PtxU64Register457 = uint64_t(0);									   // PTX L204
	if (r_bPtxPredicate9)
	{
		goto L__BB46_11;
	} // PTX L205
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister9)) * int64_t(int32_t(4))); // PTX L206
	r_PtxU64Register457 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register62);	   // PTX L207
L__BB46_11:																				   // PTX L208
	r_bPtxPredicate10 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);				   // PTX L209
	r_PtxRegister95 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(2));					   // PTX L210
	r_PtxRegister96 = uint32_t(0u /* native shared input */);							   // PTX L211
	r_PtxRegister10 = uint32_t(r_PtxRegister96) + uint32_t(r_PtxRegister95);			   // PTX L212
	if (r_bPtxPredicate10)
	{
		goto L__BB46_14;
	} // PTX L213
	r_PtxRegister104 = uint32_t(-1);							   // PTX L214
	r_PtxRegister103 = Elected(r_PtxRegister104);				   // PTX L216
	r_bPtxPredicate11 = uint32_t(r_PtxRegister103) == uint32_t(0); // PTX L222
	if (r_bPtxPredicate11)
	{
		goto L__BB46_15;
	} // PTX L223
	r_PtxU64Register63 = r_PtxU64Register457;					// PTX L224
	r_PtxRegister106 = uint32_t(16384u /* native mbarriers */); // PTX L225
	r_PtxRegister105 = uint32_t(512);							// PTX L226
	CopyBulk(s_SharedStorage, r_PtxRegister10, r_PtxU64Register63, r_PtxRegister105,
			 r_PtxRegister106);																 // PTX L228
	BarrierExpect(s_SharedStorage, r_PtxRegister106, r_PtxRegister105);						 // PTX L231
	goto L__BB46_15;																		 // PTX L233
L__BB46_14:																					 // PTX L234
	r_PtxRegister97 = uint32_t(0);															 // PTX L235
	r_PtxU16Register2 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister97))); // PTX L237
	r_PackedHalf2AtPtx240R98 = JoinHalfwords(r_PtxU16Register2, r_PtxU16Register2);			 // PTX L240
	r_ConvertedE4PairAtPtx242Rs3 = PublishE4(r_PackedHalf2AtPtx240R98);						 // PTX L242
	r_PackedE4WordAtPtx244R101 =
		JoinHalfwords(r_ConvertedE4PairAtPtx242Rs3, r_ConvertedE4PairAtPtx242Rs3); // PTX L244
	r_LaneIndexAtPtx246 = uint32_t((threadIdx.x & 31u));						   // PTX L246
	r_PtxRegister102 = ShiftLeft(uint32_t(r_LaneIndexAtPtx246), uint32_t(4));	   // PTX L248
	r_PtxRegister100 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister102);	   // PTX L249
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister100)) =
		make_uint4(r_PackedE4WordAtPtx244R101, r_PackedE4WordAtPtx244R101, r_PackedE4WordAtPtx244R101,
				   r_PackedE4WordAtPtx244R101);								// PTX L251
L__BB46_15:																	// PTX L253
	r_bPtxPredicate12 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3); // PTX L254
	r_PtxU64Register458 = uint64_t(0);										// PTX L255
	if (r_bPtxPredicate12)
	{
		goto L__BB46_17;
	} // PTX L256
	r_PtxRegister107 = uint32_t(r_PtxRegister8) + uint32_t(128);			// PTX L257
	r_PtxU64Register458 = SignExtendWordBits(r_PtxRegister107);				// PTX L258
L__BB46_17:																	// PTX L259
	r_bPtxPredicate13 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3); // PTX L260
	r_PtxU64Register459 = uint64_t(0);										// PTX L261
	if (r_bPtxPredicate13)
	{
		goto L__BB46_19;
	} // PTX L262
	r_PtxU64Register64 = ShiftLeft(uint64_t(r_PtxU64Register458), uint32_t(2));		   // PTX L263
	r_PtxU64Register459 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register64); // PTX L264
L__BB46_19:																			   // PTX L265
	r_bPtxPredicate14 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);			   // PTX L266
	if (r_bPtxPredicate14)
	{
		goto L__BB46_22;
	} // PTX L267
	r_PtxRegister116 = uint32_t(-1);							   // PTX L268
	r_PtxRegister115 = Elected(r_PtxRegister116);				   // PTX L270
	r_bPtxPredicate15 = uint32_t(r_PtxRegister115) == uint32_t(0); // PTX L276
	if (r_bPtxPredicate15)
	{
		goto L__BB46_23;
	} // PTX L277
	r_PtxRegister117 = uint32_t(r_PtxRegister10) + uint32_t(512); // PTX L278
	r_PtxU64Register65 = r_PtxU64Register459;					  // PTX L279
	r_PtxRegister119 = uint32_t(16384u /* native mbarriers */);	  // PTX L280
	r_PtxRegister118 = uint32_t(512);							  // PTX L281
	CopyBulk(s_SharedStorage, r_PtxRegister117, r_PtxU64Register65, r_PtxRegister118,
			 r_PtxRegister119);																  // PTX L283
	BarrierExpect(s_SharedStorage, r_PtxRegister119, r_PtxRegister118);						  // PTX L286
	goto L__BB46_23;																		  // PTX L288
L__BB46_22:																					  // PTX L289
	r_PtxRegister108 = uint32_t(0);															  // PTX L290
	r_PtxU16Register4 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister108))); // PTX L292
	r_PackedHalf2AtPtx295R109 = JoinHalfwords(r_PtxU16Register4, r_PtxU16Register4);		  // PTX L295
	r_ConvertedE4PairAtPtx297Rs5 = PublishE4(r_PackedHalf2AtPtx295R109);					  // PTX L297
	r_PackedE4WordAtPtx299R112 =
		JoinHalfwords(r_ConvertedE4PairAtPtx297Rs5, r_ConvertedE4PairAtPtx297Rs5); // PTX L299
	r_LaneIndexAtPtx301 = uint32_t((threadIdx.x & 31u));						   // PTX L301
	r_PtxRegister113 = ShiftLeft(uint32_t(r_LaneIndexAtPtx301), uint32_t(4));	   // PTX L303
	r_PtxRegister114 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister113);	   // PTX L304
	r_PtxRegister111 = uint32_t(r_PtxRegister114) + uint32_t(512);				   // PTX L305
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister111)) =
		make_uint4(r_PackedE4WordAtPtx299R112, r_PackedE4WordAtPtx299R112, r_PackedE4WordAtPtx299R112,
				   r_PackedE4WordAtPtx299R112);								 // PTX L307
L__BB46_23:																	 // PTX L309
	r_PtxRegister11 = uint32_t(r_PtxRegister6) + uint32_t(1024);			 // PTX L310
	r_PtxRegister12 = uint32_t(r_PtxRegister7) + uint32_t(4);				 // PTX L311
	r_bPtxPredicate16 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L312
	r_bPtxPredicate17 = int32_t(r_PtxRegister12) < int32_t(r_PtxRegister3);	 // PTX L313
	r_PtxRegister13 = uint32_t(r_PtxRegister8) + uint32_t(65536);			 // PTX L314
	r_PtxRegister14 = r_bPtxPredicate17 ? r_PtxRegister13 : 0;				 // PTX L315
	r_PtxU16Register165 = uint16_t(0);										 // PTX L316
	r_PtxU64Register460 = uint64_t(0);										 // PTX L317
	r_PtxRegister1678 = uint32_t(128);										 // PTX L318
	r_PtxRegister1679 = uint32_t(r_PtxRegister1678);						 // PTX L319
	r_PtxU64Register461 = uint64_t(r_PtxU64Register460);					 // PTX L320
	if (r_bPtxPredicate16)
	{
		goto L__BB46_25;
	} // PTX L321
	r_PtxU64Register461 = uint64_t(r_PtxU64Register3) + uint64_t(4096);						// PTX L322
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister14)) * int64_t(int32_t(4))); // PTX L323
	r_PtxU64Register460 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register66);		// PTX L324
	r_PtxRegister1679 = uint32_t(r_PtxRegister11) + uint32_t(128);							// PTX L325
	r_PtxRegister1678 = uint32_t(r_PtxRegister14) + uint32_t(128);							// PTX L326
	r_PtxU16Register165 = uint16_t(1);														// PTX L327
L__BB46_25:																					// PTX L328
	r_bPtxPredicate18 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);				// PTX L329
	if (r_bPtxPredicate18)
	{
		goto L__BB46_27;
	} // PTX L330
	r_PtxRegister120 = uint32_t(r_PtxRegister11) + uint32_t(128);				   // PTX L331
	r_PtxRegister121 = uint32_t(r_PtxRegister13) + uint32_t(128);				   // PTX L332
	r_bPtxPredicate19 = uint32_t(r_PtxRegister120) == uint32_t(r_PtxRegister1679); // PTX L333
	r_bPtxPredicate20 = uint32_t(r_PtxRegister121) == uint32_t(r_PtxRegister1678); // PTX L334
	r_PtxU16Register6 = r_bPtxPredicate20 ? r_PtxU16Register165 : 0;			   // PTX L335
	r_PtxU16Register165 = r_bPtxPredicate19 ? r_PtxU16Register6 : 0;			   // PTX L336
L__BB46_27:																		   // PTX L337
	r_bPtxPredicate21 = uint16_t(r_PtxU16Register165) == uint16_t(0);			   // PTX L338
	if (r_bPtxPredicate21)
	{
		goto L__BB46_30;
	} // PTX L339
	r_PtxRegister123 = uint32_t(-1);							   // PTX L340
	r_PtxRegister122 = Elected(r_PtxRegister123);				   // PTX L342
	r_bPtxPredicate22 = uint32_t(r_PtxRegister122) == uint32_t(0); // PTX L348
	if (r_bPtxPredicate22)
	{
		goto L__BB46_44;
	} // PTX L349
	r_PtxU64Register68 = SharedOffset(s_SharedStorage, r_PtxU64Register461); // PTX L350
	r_PtxRegister124 = uint32_t(r_PtxU64Register68);						 // PTX L351
	r_PtxU64Register67 = r_PtxU64Register460;								 // PTX L352
	r_PtxRegister126 = uint32_t(16384u /* native mbarriers */);				 // PTX L353
	r_PtxRegister125 = uint32_t(1024);										 // PTX L354
	CopyBulk(s_SharedStorage, r_PtxRegister124, r_PtxU64Register67, r_PtxRegister125,
			 r_PtxRegister126);												 // PTX L356
	BarrierExpect(s_SharedStorage, r_PtxRegister126, r_PtxRegister125);		 // PTX L359
	goto L__BB46_44;														 // PTX L361
L__BB46_30:																	 // PTX L362
	r_bPtxPredicate23 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L363
	r_PtxU64Register462 = uint64_t(0);										 // PTX L364
	if (r_bPtxPredicate23)
	{
		goto L__BB46_32;
	} // PTX L365
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister14)) * int64_t(int32_t(4))); // PTX L366
	r_PtxU64Register462 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register69);		// PTX L367
L__BB46_32:																					// PTX L368
	r_bPtxPredicate24 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);				// PTX L369
	if (r_bPtxPredicate24)
	{
		goto L__BB46_35;
	} // PTX L370
	r_PtxRegister137 = uint32_t(-1);							   // PTX L371
	r_PtxRegister136 = Elected(r_PtxRegister137);				   // PTX L373
	r_bPtxPredicate25 = uint32_t(r_PtxRegister136) == uint32_t(0); // PTX L379
	if (r_bPtxPredicate25)
	{
		goto L__BB46_36;
	} // PTX L380
	r_PtxRegister141 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));		// PTX L381
	r_PtxRegister142 = uint32_t(0u /* native shared input */);					// PTX L382
	r_PtxRegister138 = uint32_t(r_PtxRegister142) + uint32_t(r_PtxRegister141); // PTX L383
	r_PtxU64Register70 = r_PtxU64Register462;									// PTX L384
	r_PtxRegister140 = uint32_t(16384u /* native mbarriers */);					// PTX L385
	r_PtxRegister139 = uint32_t(512);											// PTX L386
	CopyBulk(s_SharedStorage, r_PtxRegister138, r_PtxU64Register70, r_PtxRegister139,
			 r_PtxRegister140);																  // PTX L388
	BarrierExpect(s_SharedStorage, r_PtxRegister140, r_PtxRegister139);						  // PTX L391
	goto L__BB46_36;																		  // PTX L393
L__BB46_35:																					  // PTX L394
	r_PtxRegister127 = uint32_t(0);															  // PTX L395
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister127))); // PTX L397
	r_PackedHalf2AtPtx400R128 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L400
	r_ConvertedE4PairAtPtx402Rs8 = PublishE4(r_PackedHalf2AtPtx400R128);					  // PTX L402
	r_PackedE4WordAtPtx404R131 =
		JoinHalfwords(r_ConvertedE4PairAtPtx402Rs8, r_ConvertedE4PairAtPtx402Rs8); // PTX L404
	r_LaneIndexAtPtx406 = uint32_t((threadIdx.x & 31u));						   // PTX L406
	r_PtxRegister132 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));		   // PTX L408
	r_PtxRegister133 = uint32_t(0u /* native shared input */);					   // PTX L409
	r_PtxRegister134 = uint32_t(r_PtxRegister133) + uint32_t(r_PtxRegister132);	   // PTX L410
	r_PtxRegister135 = ShiftLeft(uint32_t(r_LaneIndexAtPtx406), uint32_t(4));	   // PTX L411
	r_PtxRegister130 = uint32_t(r_PtxRegister134) + uint32_t(r_PtxRegister135);	   // PTX L412
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister130)) =
		make_uint4(r_PackedE4WordAtPtx404R131, r_PackedE4WordAtPtx404R131, r_PackedE4WordAtPtx404R131,
				   r_PackedE4WordAtPtx404R131);								 // PTX L414
L__BB46_36:																	 // PTX L416
	r_bPtxPredicate26 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L417
	r_PtxU64Register463 = uint64_t(0);										 // PTX L418
	if (r_bPtxPredicate26)
	{
		goto L__BB46_38;
	} // PTX L419
	r_PtxRegister143 = uint32_t(r_PtxRegister13) + uint32_t(128);			 // PTX L420
	r_PtxU64Register463 = SignExtendWordBits(r_PtxRegister143);				 // PTX L421
L__BB46_38:																	 // PTX L422
	r_bPtxPredicate27 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L423
	r_PtxU64Register464 = uint64_t(0);										 // PTX L424
	if (r_bPtxPredicate27)
	{
		goto L__BB46_40;
	} // PTX L425
	r_PtxU64Register71 = ShiftLeft(uint64_t(r_PtxU64Register463), uint32_t(2));		   // PTX L426
	r_PtxU64Register464 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register71); // PTX L427
L__BB46_40:																			   // PTX L428
	r_bPtxPredicate28 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);		   // PTX L429
	if (r_bPtxPredicate28)
	{
		goto L__BB46_43;
	} // PTX L430
	r_PtxRegister155 = uint32_t(-1);							   // PTX L431
	r_PtxRegister154 = Elected(r_PtxRegister155);				   // PTX L433
	r_bPtxPredicate29 = uint32_t(r_PtxRegister154) == uint32_t(0); // PTX L439
	if (r_bPtxPredicate29)
	{
		goto L__BB46_44;
	} // PTX L440
	r_PtxRegister159 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));		// PTX L441
	r_PtxRegister160 = uint32_t(0u /* native shared input */);					// PTX L442
	r_PtxRegister161 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister159); // PTX L443
	r_PtxRegister156 = uint32_t(r_PtxRegister161) + uint32_t(512);				// PTX L444
	r_PtxU64Register72 = r_PtxU64Register464;									// PTX L445
	r_PtxRegister158 = uint32_t(16384u /* native mbarriers */);					// PTX L446
	r_PtxRegister157 = uint32_t(512);											// PTX L447
	CopyBulk(s_SharedStorage, r_PtxRegister156, r_PtxU64Register72, r_PtxRegister157,
			 r_PtxRegister158);																  // PTX L449
	BarrierExpect(s_SharedStorage, r_PtxRegister158, r_PtxRegister157);						  // PTX L452
	goto L__BB46_44;																		  // PTX L454
L__BB46_43:																					  // PTX L455
	r_PtxRegister144 = uint32_t(0);															  // PTX L456
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister144))); // PTX L458
	r_PackedHalf2AtPtx461R145 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L461
	r_ConvertedE4PairAtPtx463Rs10 = PublishE4(r_PackedHalf2AtPtx461R145);					  // PTX L463
	r_PackedE4WordAtPtx465R148 =
		JoinHalfwords(r_ConvertedE4PairAtPtx463Rs10, r_ConvertedE4PairAtPtx463Rs10); // PTX L465
	r_LaneIndexAtPtx467 = uint32_t((threadIdx.x & 31u));							 // PTX L467
	r_PtxRegister149 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));			 // PTX L469
	r_PtxRegister150 = uint32_t(0u /* native shared input */);						 // PTX L470
	r_PtxRegister151 = uint32_t(r_PtxRegister150) + uint32_t(r_PtxRegister149);		 // PTX L471
	r_PtxRegister152 = ShiftLeft(uint32_t(r_LaneIndexAtPtx467), uint32_t(4));		 // PTX L472
	r_PtxRegister153 = uint32_t(r_PtxRegister151) + uint32_t(r_PtxRegister152);		 // PTX L473
	r_PtxRegister147 = uint32_t(r_PtxRegister153) + uint32_t(512);					 // PTX L474
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister147)) =
		make_uint4(r_PackedE4WordAtPtx465R148, r_PackedE4WordAtPtx465R148, r_PackedE4WordAtPtx465R148,
				   r_PackedE4WordAtPtx465R148);					// PTX L476
L__BB46_44:														// PTX L478
	r_PtxRegister162 = uint32_t(16384u /* native mbarriers */); // PTX L479
	r_PtxRegister163 = uint32_t(1);								// PTX L480
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register73 = BarrierArrive(s_SharedStorage, r_PtxRegister162, r_PtxRegister163); // PTX L482
L__BB46_45:																					 // PTX L484
	r_PtxRegister165 = uint32_t(16384u /* native mbarriers */);								 // PTX L485
	r_PtxRegister164 = BarrierReady(s_SharedStorage, r_PtxRegister165, r_PtxU64Register73);	 // PTX L487
	r_bPtxPredicate30 = uint32_t(r_PtxRegister164) == uint32_t(0);							 // PTX L493
	if (r_bPtxPredicate30)
	{
		goto L__BB46_45;
	} // PTX L494
	r_bPtxPredicate31 = uint32_t(r_CtaZ) != uint32_t(0);				// PTX L495
	r_PackedHalf2AtPtx496R1712 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L496
	r_PackedHalf2AtPtx497R1713 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L497
	r_PackedHalf2AtPtx498R1714 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L498
	r_PackedHalf2AtPtx499R1715 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L499
	r_PackedHalf2AtPtx500R1716 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L500
	r_PackedHalf2AtPtx501R1717 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L501
	r_PackedHalf2AtPtx502R1718 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L502
	r_PackedHalf2AtPtx503R1719 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L503
	r_PackedHalf2AtPtx504R1720 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L504
	r_PackedHalf2AtPtx505R1721 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L505
	r_PackedHalf2AtPtx506R1722 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L506
	r_PackedHalf2AtPtx507R1723 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L507
	r_PackedHalf2AtPtx508R1724 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L508
	r_PackedHalf2AtPtx509R1725 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L509
	r_PackedHalf2AtPtx510R1726 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L510
	r_PackedHalf2AtPtx511R1727 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L511
	r_PackedHalf2AtPtx512R1728 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L512
	r_PackedHalf2AtPtx513R1729 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L513
	r_PackedHalf2AtPtx514R1730 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L514
	r_PackedHalf2AtPtx515R1731 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L515
	r_PackedHalf2AtPtx516R1732 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L516
	r_PackedHalf2AtPtx517R1733 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L517
	r_PackedHalf2AtPtx518R1734 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L518
	r_PackedHalf2AtPtx519R1735 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L519
	r_PackedHalf2AtPtx520R1736 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L520
	r_PackedHalf2AtPtx521R1737 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L521
	r_PackedHalf2AtPtx522R1738 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L522
	r_PackedHalf2AtPtx523R1739 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L523
	r_PackedHalf2AtPtx524R1740 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L524
	r_PackedHalf2AtPtx525R1741 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L525
	r_PackedHalf2AtPtx526R1742 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L526
	r_PackedHalf2AtPtx527R1743 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L527
	r_PackedHalf2AtPtx528R1744 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L528
	r_PackedHalf2AtPtx529R1745 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L529
	r_PackedHalf2AtPtx530R1746 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L530
	r_PackedHalf2AtPtx531R1747 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L531
	r_PackedHalf2AtPtx532R1748 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L532
	r_PackedHalf2AtPtx533R1749 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L533
	r_PackedHalf2AtPtx534R1750 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L534
	r_PackedHalf2AtPtx535R1751 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L535
	r_PackedHalf2AtPtx536R1752 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L536
	r_PackedHalf2AtPtx537R1753 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L537
	r_PackedHalf2AtPtx538R1754 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L538
	r_PackedHalf2AtPtx539R1755 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L539
	r_PackedHalf2AtPtx540R1756 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L540
	r_PackedHalf2AtPtx541R1757 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L541
	r_PackedHalf2AtPtx542R1758 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L542
	r_PackedHalf2AtPtx543R1759 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L543
	r_PackedHalf2AtPtx544R1760 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L544
	r_PackedHalf2AtPtx545R1761 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L545
	r_PackedHalf2AtPtx546R1762 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L546
	r_PackedHalf2AtPtx547R1763 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L547
	r_PackedHalf2AtPtx548R1764 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L548
	r_PackedHalf2AtPtx549R1765 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L549
	r_PackedHalf2AtPtx550R1766 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L550
	r_PackedHalf2AtPtx551R1767 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L551
	r_PackedHalf2AtPtx552R1768 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L552
	r_PackedHalf2AtPtx553R1769 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L553
	r_PackedHalf2AtPtx554R1770 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L554
	r_PackedHalf2AtPtx555R1771 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L555
	r_PackedHalf2AtPtx556R1772 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L556
	r_PackedHalf2AtPtx557R1773 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L557
	r_PackedHalf2AtPtx558R1774 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L558
	r_PackedHalf2AtPtx559R1775 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L559
	if (r_bPtxPredicate31)
	{
		goto L__BB46_72;
	} // PTX L560
	r_PtxRegister166 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));							 // PTX L561
	r_PtxRegister167 = r_PtxRegister166 & 2044;												 // PTX L562
	r_PtxRegister15 = uint32_t(r_PtxRegister167) + uint32_t(r_PtxRegister2);				 // PTX L563
	r_bPtxPredicate32 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister3);					 // PTX L564
	r_PtxRegister168 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(2));					 // PTX L565
	r_PtxRegister169 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(12));					 // PTX L566
	r_PtxRegister170 = uint32_t(r_PtxRegister169) + uint32_t(r_PtxRegister168);				 // PTX L567
	r_PtxU64Register74 = uint64_t(int64_t(int32_t(r_PtxRegister170)) * int64_t(int32_t(4))); // PTX L568
	g_ResidualByteAddressAtPtx569 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register74); // PTX L569
	if (r_bPtxPredicate32)
	{
		goto L__BB46_49;
	} // PTX L570
	goto L__BB46_48;																			 // PTX L571
L__BB46_49:																						 // PTX L572
	r_LaneIndexAtPtx574 = uint32_t((threadIdx.x & 31u));										 // PTX L574
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx574)) * int64_t(int32_t(16))); // PTX L576
	g_ResidualByteAddressAtPtx577 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register76); // PTX L577
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx577));
		r_PtxRegister1680 = r_Value.x;
		r_PtxRegister1681 = r_Value.y;
		r_PtxRegister1682 = r_Value.z;
		r_PtxRegister1683 = r_Value.w;
	} // PTX L579
	goto L__BB46_50;																		   // PTX L581
L__BB46_48:																					   // PTX L582
	r_PtxRegister171 = uint32_t(0);															   // PTX L583
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister171))); // PTX L585
	r_PackedHalf2AtPtx588R172 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L588
	r_ConvertedE4PairAtPtx590Rs12 = PublishE4(r_PackedHalf2AtPtx588R172);					   // PTX L590
	r_PtxRegister1680 =
		JoinHalfwords(r_ConvertedE4PairAtPtx590Rs12, r_ConvertedE4PairAtPtx590Rs12); // PTX L592
	r_PtxRegister1681 = uint32_t(r_PtxRegister1680);								 // PTX L593
	r_PtxRegister1682 = uint32_t(r_PtxRegister1680);								 // PTX L594
	r_PtxRegister1683 = uint32_t(r_PtxRegister1680);								 // PTX L595
L__BB46_50:																			 // PTX L596
	r_bPtxPredicate33 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister3);			 // PTX L597
	r_PtxU16Register33 = uint16_t(r_PtxRegister1683);
	r_PtxU16Register34 = uint16_t(r_PtxRegister1683 >> 16); // PTX L598
	r_PtxU16Register31 = uint16_t(r_PtxRegister1682);
	r_PtxU16Register32 = uint16_t(r_PtxRegister1682 >> 16); // PTX L599
	r_PtxU16Register29 = uint16_t(r_PtxRegister1681);
	r_PtxU16Register30 = uint16_t(r_PtxRegister1681 >> 16); // PTX L600
	r_PtxU16Register27 = uint16_t(r_PtxRegister1680);
	r_PtxU16Register28 = uint16_t(r_PtxRegister1680 >> 16); // PTX L601
	if (r_bPtxPredicate33)
	{
		goto L__BB46_52;
	} // PTX L602
	goto L__BB46_51;																			 // PTX L603
L__BB46_52:																						 // PTX L604
	r_LaneIndexAtPtx606 = uint32_t((threadIdx.x & 31u));										 // PTX L606
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx606)) * int64_t(int32_t(16))); // PTX L608
	g_ResidualByteAddressAtPtx609 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register78);				 // PTX L609
	g_ResidualByteAddressAtPtx610 = uint64_t(g_ResidualByteAddressAtPtx609) + uint64_t(512); // PTX L610
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx610));
		r_PtxRegister1684 = r_Value.x;
		r_PtxRegister1685 = r_Value.y;
		r_PtxRegister1686 = r_Value.z;
		r_PtxRegister1687 = r_Value.w;
	} // PTX L612
	goto L__BB46_53;																		   // PTX L614
L__BB46_51:																					   // PTX L615
	r_PtxRegister174 = uint32_t(0);															   // PTX L616
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister174))); // PTX L618
	r_PackedHalf2AtPtx621R175 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L621
	r_ConvertedE4PairAtPtx623Rs14 = PublishE4(r_PackedHalf2AtPtx621R175);					   // PTX L623
	r_PtxRegister1684 =
		JoinHalfwords(r_ConvertedE4PairAtPtx623Rs14, r_ConvertedE4PairAtPtx623Rs14); // PTX L625
	r_PtxRegister1685 = uint32_t(r_PtxRegister1684);								 // PTX L626
	r_PtxRegister1686 = uint32_t(r_PtxRegister1684);								 // PTX L627
	r_PtxRegister1687 = uint32_t(r_PtxRegister1684);								 // PTX L628
L__BB46_53:																			 // PTX L629
	r_PtxRegister16 = uint32_t(r_PtxRegister15) + uint32_t(1);						 // PTX L630
	r_PtxU16Register41 = uint16_t(r_PtxRegister1687);
	r_PtxU16Register42 = uint16_t(r_PtxRegister1687 >> 16); // PTX L631
	r_PtxU16Register39 = uint16_t(r_PtxRegister1686);
	r_PtxU16Register40 = uint16_t(r_PtxRegister1686 >> 16); // PTX L632
	r_PtxU16Register37 = uint16_t(r_PtxRegister1685);
	r_PtxU16Register38 = uint16_t(r_PtxRegister1685 >> 16); // PTX L633
	r_PtxU16Register35 = uint16_t(r_PtxRegister1684);
	r_PtxU16Register36 = uint16_t(r_PtxRegister1684 >> 16);					// PTX L634
	r_bPtxPredicate34 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister3); // PTX L635
	if (r_bPtxPredicate34)
	{
		goto L__BB46_55;
	} // PTX L636
	goto L__BB46_54;																			 // PTX L637
L__BB46_55:																						 // PTX L638
	r_LaneIndexAtPtx640 = uint32_t((threadIdx.x & 31u));										 // PTX L640
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx640)) * int64_t(int32_t(16))); // PTX L642
	g_ResidualByteAddressAtPtx643 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register81);				   // PTX L643
	g_ResidualByteAddressAtPtx644 = uint64_t(g_ResidualByteAddressAtPtx643) + uint64_t(16384); // PTX L644
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx644));
		r_PtxRegister1688 = r_Value.x;
		r_PtxRegister1689 = r_Value.y;
		r_PtxRegister1690 = r_Value.z;
		r_PtxRegister1691 = r_Value.w;
	} // PTX L646
	goto L__BB46_56;																		   // PTX L648
L__BB46_54:																					   // PTX L649
	r_PtxRegister177 = uint32_t(0);															   // PTX L650
	r_PtxU16Register15 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister177))); // PTX L652
	r_PackedHalf2AtPtx655R178 = JoinHalfwords(r_PtxU16Register15, r_PtxU16Register15);		   // PTX L655
	r_ConvertedE4PairAtPtx657Rs16 = PublishE4(r_PackedHalf2AtPtx655R178);					   // PTX L657
	r_PtxRegister1688 =
		JoinHalfwords(r_ConvertedE4PairAtPtx657Rs16, r_ConvertedE4PairAtPtx657Rs16); // PTX L659
	r_PtxRegister1689 = uint32_t(r_PtxRegister1688);								 // PTX L660
	r_PtxRegister1690 = uint32_t(r_PtxRegister1688);								 // PTX L661
	r_PtxRegister1691 = uint32_t(r_PtxRegister1688);								 // PTX L662
L__BB46_56:																			 // PTX L663
	r_bPtxPredicate35 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister3);			 // PTX L664
	r_PtxU16Register49 = uint16_t(r_PtxRegister1691);
	r_PtxU16Register50 = uint16_t(r_PtxRegister1691 >> 16); // PTX L665
	r_PtxU16Register47 = uint16_t(r_PtxRegister1690);
	r_PtxU16Register48 = uint16_t(r_PtxRegister1690 >> 16); // PTX L666
	r_PtxU16Register45 = uint16_t(r_PtxRegister1689);
	r_PtxU16Register46 = uint16_t(r_PtxRegister1689 >> 16); // PTX L667
	r_PtxU16Register43 = uint16_t(r_PtxRegister1688);
	r_PtxU16Register44 = uint16_t(r_PtxRegister1688 >> 16); // PTX L668
	if (r_bPtxPredicate35)
	{
		goto L__BB46_58;
	} // PTX L669
	goto L__BB46_57;																			 // PTX L670
L__BB46_58:																						 // PTX L671
	r_LaneIndexAtPtx673 = uint32_t((threadIdx.x & 31u));										 // PTX L673
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx673)) * int64_t(int32_t(16))); // PTX L675
	g_ResidualByteAddressAtPtx676 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register84);				   // PTX L676
	g_ResidualByteAddressAtPtx677 = uint64_t(g_ResidualByteAddressAtPtx676) + uint64_t(16896); // PTX L677
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx677));
		r_PtxRegister1692 = r_Value.x;
		r_PtxRegister1693 = r_Value.y;
		r_PtxRegister1694 = r_Value.z;
		r_PtxRegister1695 = r_Value.w;
	} // PTX L679
	goto L__BB46_59;																		   // PTX L681
L__BB46_57:																					   // PTX L682
	r_PtxRegister180 = uint32_t(0);															   // PTX L683
	r_PtxU16Register17 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister180))); // PTX L685
	r_PackedHalf2AtPtx688R181 = JoinHalfwords(r_PtxU16Register17, r_PtxU16Register17);		   // PTX L688
	r_ConvertedE4PairAtPtx690Rs18 = PublishE4(r_PackedHalf2AtPtx688R181);					   // PTX L690
	r_PtxRegister1692 =
		JoinHalfwords(r_ConvertedE4PairAtPtx690Rs18, r_ConvertedE4PairAtPtx690Rs18); // PTX L692
	r_PtxRegister1693 = uint32_t(r_PtxRegister1692);								 // PTX L693
	r_PtxRegister1694 = uint32_t(r_PtxRegister1692);								 // PTX L694
	r_PtxRegister1695 = uint32_t(r_PtxRegister1692);								 // PTX L695
L__BB46_59:																			 // PTX L696
	r_PtxRegister17 = uint32_t(r_PtxRegister15) + uint32_t(2);						 // PTX L697
	r_PtxU16Register57 = uint16_t(r_PtxRegister1695);
	r_PtxU16Register58 = uint16_t(r_PtxRegister1695 >> 16); // PTX L698
	r_PtxU16Register55 = uint16_t(r_PtxRegister1694);
	r_PtxU16Register56 = uint16_t(r_PtxRegister1694 >> 16); // PTX L699
	r_PtxU16Register53 = uint16_t(r_PtxRegister1693);
	r_PtxU16Register54 = uint16_t(r_PtxRegister1693 >> 16); // PTX L700
	r_PtxU16Register51 = uint16_t(r_PtxRegister1692);
	r_PtxU16Register52 = uint16_t(r_PtxRegister1692 >> 16);					// PTX L701
	r_bPtxPredicate36 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister3); // PTX L702
	if (r_bPtxPredicate36)
	{
		goto L__BB46_61;
	} // PTX L703
	goto L__BB46_60;																			 // PTX L704
L__BB46_61:																						 // PTX L705
	r_LaneIndexAtPtx707 = uint32_t((threadIdx.x & 31u));										 // PTX L707
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx707)) * int64_t(int32_t(16))); // PTX L709
	g_ResidualByteAddressAtPtx710 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register87);				   // PTX L710
	g_ResidualByteAddressAtPtx711 = uint64_t(g_ResidualByteAddressAtPtx710) + uint64_t(32768); // PTX L711
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx711));
		r_PtxRegister1696 = r_Value.x;
		r_PtxRegister1697 = r_Value.y;
		r_PtxRegister1698 = r_Value.z;
		r_PtxRegister1699 = r_Value.w;
	} // PTX L713
	goto L__BB46_62;																		   // PTX L715
L__BB46_60:																					   // PTX L716
	r_PtxRegister183 = uint32_t(0);															   // PTX L717
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister183))); // PTX L719
	r_PackedHalf2AtPtx722R184 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L722
	r_ConvertedE4PairAtPtx724Rs20 = PublishE4(r_PackedHalf2AtPtx722R184);					   // PTX L724
	r_PtxRegister1696 =
		JoinHalfwords(r_ConvertedE4PairAtPtx724Rs20, r_ConvertedE4PairAtPtx724Rs20); // PTX L726
	r_PtxRegister1697 = uint32_t(r_PtxRegister1696);								 // PTX L727
	r_PtxRegister1698 = uint32_t(r_PtxRegister1696);								 // PTX L728
	r_PtxRegister1699 = uint32_t(r_PtxRegister1696);								 // PTX L729
L__BB46_62:																			 // PTX L730
	r_bPtxPredicate37 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister3);			 // PTX L731
	r_PtxU16Register65 = uint16_t(r_PtxRegister1699);
	r_PtxU16Register66 = uint16_t(r_PtxRegister1699 >> 16); // PTX L732
	r_PtxU16Register63 = uint16_t(r_PtxRegister1698);
	r_PtxU16Register64 = uint16_t(r_PtxRegister1698 >> 16); // PTX L733
	r_PtxU16Register61 = uint16_t(r_PtxRegister1697);
	r_PtxU16Register62 = uint16_t(r_PtxRegister1697 >> 16); // PTX L734
	r_PtxU16Register59 = uint16_t(r_PtxRegister1696);
	r_PtxU16Register60 = uint16_t(r_PtxRegister1696 >> 16); // PTX L735
	if (r_bPtxPredicate37)
	{
		goto L__BB46_64;
	} // PTX L736
	goto L__BB46_63;																			 // PTX L737
L__BB46_64:																						 // PTX L738
	r_LaneIndexAtPtx740 = uint32_t((threadIdx.x & 31u));										 // PTX L740
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx740)) * int64_t(int32_t(16))); // PTX L742
	g_ResidualByteAddressAtPtx743 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register90);				   // PTX L743
	g_ResidualByteAddressAtPtx744 = uint64_t(g_ResidualByteAddressAtPtx743) + uint64_t(33280); // PTX L744
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx744));
		r_PtxRegister1700 = r_Value.x;
		r_PtxRegister1701 = r_Value.y;
		r_PtxRegister1702 = r_Value.z;
		r_PtxRegister1703 = r_Value.w;
	} // PTX L746
	goto L__BB46_65;																		   // PTX L748
L__BB46_63:																					   // PTX L749
	r_PtxRegister186 = uint32_t(0);															   // PTX L750
	r_PtxU16Register21 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister186))); // PTX L752
	r_PackedHalf2AtPtx755R187 = JoinHalfwords(r_PtxU16Register21, r_PtxU16Register21);		   // PTX L755
	r_ConvertedE4PairAtPtx757Rs22 = PublishE4(r_PackedHalf2AtPtx755R187);					   // PTX L757
	r_PtxRegister1700 =
		JoinHalfwords(r_ConvertedE4PairAtPtx757Rs22, r_ConvertedE4PairAtPtx757Rs22); // PTX L759
	r_PtxRegister1701 = uint32_t(r_PtxRegister1700);								 // PTX L760
	r_PtxRegister1702 = uint32_t(r_PtxRegister1700);								 // PTX L761
	r_PtxRegister1703 = uint32_t(r_PtxRegister1700);								 // PTX L762
L__BB46_65:																			 // PTX L763
	r_PtxRegister18 = uint32_t(r_PtxRegister15) + uint32_t(3);						 // PTX L764
	r_PtxU16Register73 = uint16_t(r_PtxRegister1703);
	r_PtxU16Register74 = uint16_t(r_PtxRegister1703 >> 16); // PTX L765
	r_PtxU16Register71 = uint16_t(r_PtxRegister1702);
	r_PtxU16Register72 = uint16_t(r_PtxRegister1702 >> 16); // PTX L766
	r_PtxU16Register69 = uint16_t(r_PtxRegister1701);
	r_PtxU16Register70 = uint16_t(r_PtxRegister1701 >> 16); // PTX L767
	r_PtxU16Register67 = uint16_t(r_PtxRegister1700);
	r_PtxU16Register68 = uint16_t(r_PtxRegister1700 >> 16);					// PTX L768
	r_bPtxPredicate38 = int32_t(r_PtxRegister18) < int32_t(r_PtxRegister3); // PTX L769
	if (r_bPtxPredicate38)
	{
		goto L__BB46_67;
	} // PTX L770
	goto L__BB46_66;																			 // PTX L771
L__BB46_67:																						 // PTX L772
	r_LaneIndexAtPtx774 = uint32_t((threadIdx.x & 31u));										 // PTX L774
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx774)) * int64_t(int32_t(16))); // PTX L776
	g_ResidualByteAddressAtPtx777 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register93);				   // PTX L777
	g_ResidualByteAddressAtPtx778 = uint64_t(g_ResidualByteAddressAtPtx777) + uint64_t(49152); // PTX L778
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx778));
		r_PtxRegister1704 = r_Value.x;
		r_PtxRegister1705 = r_Value.y;
		r_PtxRegister1706 = r_Value.z;
		r_PtxRegister1707 = r_Value.w;
	} // PTX L780
	goto L__BB46_68;																		   // PTX L782
L__BB46_66:																					   // PTX L783
	r_PtxRegister189 = uint32_t(0);															   // PTX L784
	r_PtxU16Register23 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister189))); // PTX L786
	r_PackedHalf2AtPtx789R190 = JoinHalfwords(r_PtxU16Register23, r_PtxU16Register23);		   // PTX L789
	r_ConvertedE4PairAtPtx791Rs24 = PublishE4(r_PackedHalf2AtPtx789R190);					   // PTX L791
	r_PtxRegister1704 =
		JoinHalfwords(r_ConvertedE4PairAtPtx791Rs24, r_ConvertedE4PairAtPtx791Rs24); // PTX L793
	r_PtxRegister1705 = uint32_t(r_PtxRegister1704);								 // PTX L794
	r_PtxRegister1706 = uint32_t(r_PtxRegister1704);								 // PTX L795
	r_PtxRegister1707 = uint32_t(r_PtxRegister1704);								 // PTX L796
L__BB46_68:																			 // PTX L797
	r_bPtxPredicate39 = int32_t(r_PtxRegister18) < int32_t(r_PtxRegister3);			 // PTX L798
	r_PtxU16Register81 = uint16_t(r_PtxRegister1707);
	r_PtxU16Register82 = uint16_t(r_PtxRegister1707 >> 16); // PTX L799
	r_PtxU16Register79 = uint16_t(r_PtxRegister1706);
	r_PtxU16Register80 = uint16_t(r_PtxRegister1706 >> 16); // PTX L800
	r_PtxU16Register77 = uint16_t(r_PtxRegister1705);
	r_PtxU16Register78 = uint16_t(r_PtxRegister1705 >> 16); // PTX L801
	r_PtxU16Register75 = uint16_t(r_PtxRegister1704);
	r_PtxU16Register76 = uint16_t(r_PtxRegister1704 >> 16); // PTX L802
	if (r_bPtxPredicate39)
	{
		goto L__BB46_70;
	} // PTX L803
	goto L__BB46_69;																			 // PTX L804
L__BB46_70:																						 // PTX L805
	r_LaneIndexAtPtx807 = uint32_t((threadIdx.x & 31u));										 // PTX L807
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx807)) * int64_t(int32_t(16))); // PTX L809
	g_ResidualByteAddressAtPtx810 =
		uint64_t(g_ResidualByteAddressAtPtx569) + uint64_t(r_PtxU64Register96);				   // PTX L810
	g_ResidualByteAddressAtPtx811 = uint64_t(g_ResidualByteAddressAtPtx810) + uint64_t(49664); // PTX L811
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx811));
		r_PtxRegister1708 = r_Value.x;
		r_PtxRegister1709 = r_Value.y;
		r_PtxRegister1710 = r_Value.z;
		r_PtxRegister1711 = r_Value.w;
	} // PTX L813
	goto L__BB46_71;																		   // PTX L815
L__BB46_69:																					   // PTX L816
	r_PtxRegister192 = uint32_t(0);															   // PTX L817
	r_PtxU16Register25 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister192))); // PTX L819
	r_PackedHalf2AtPtx822R193 = JoinHalfwords(r_PtxU16Register25, r_PtxU16Register25);		   // PTX L822
	r_ConvertedE4PairAtPtx824Rs26 = PublishE4(r_PackedHalf2AtPtx822R193);					   // PTX L824
	r_PtxRegister1708 =
		JoinHalfwords(r_ConvertedE4PairAtPtx824Rs26, r_ConvertedE4PairAtPtx824Rs26); // PTX L826
	r_PtxRegister1709 = uint32_t(r_PtxRegister1708);								 // PTX L827
	r_PtxRegister1710 = uint32_t(r_PtxRegister1708);								 // PTX L828
	r_PtxRegister1711 = uint32_t(r_PtxRegister1708);								 // PTX L829
L__BB46_71:																			 // PTX L830
	r_PackedHalf2AtPtx832R260 = DecodeE4(r_PtxU16Register27);						 // PTX L832
	r_PackedHalf2AtPtx835R266 = DecodeE4(r_PtxU16Register28);						 // PTX L835
	r_PackedHalf2AtPtx838R263 = DecodeE4(r_PtxU16Register29);						 // PTX L838
	r_PackedHalf2AtPtx841R269 = DecodeE4(r_PtxU16Register30);						 // PTX L841
	r_PackedHalf2AtPtx844R272 = DecodeE4(r_PtxU16Register31);						 // PTX L844
	r_PackedHalf2AtPtx847R278 = DecodeE4(r_PtxU16Register32);						 // PTX L847
	r_PackedHalf2AtPtx850R275 = DecodeE4(r_PtxU16Register33);						 // PTX L850
	r_PackedHalf2AtPtx853R281 = DecodeE4(r_PtxU16Register34);						 // PTX L853
	r_PackedHalf2AtPtx856R284 = DecodeE4(r_PtxU16Register35);						 // PTX L856
	r_PackedHalf2AtPtx859R290 = DecodeE4(r_PtxU16Register36);						 // PTX L859
	r_PackedHalf2AtPtx862R287 = DecodeE4(r_PtxU16Register37);						 // PTX L862
	r_PackedHalf2AtPtx865R293 = DecodeE4(r_PtxU16Register38);						 // PTX L865
	r_PackedHalf2AtPtx868R296 = DecodeE4(r_PtxU16Register39);						 // PTX L868
	r_PackedHalf2AtPtx871R302 = DecodeE4(r_PtxU16Register40);						 // PTX L871
	r_PackedHalf2AtPtx874R299 = DecodeE4(r_PtxU16Register41);						 // PTX L874
	r_PackedHalf2AtPtx877R305 = DecodeE4(r_PtxU16Register42);						 // PTX L877
	r_PackedHalf2AtPtx880R308 = DecodeE4(r_PtxU16Register43);						 // PTX L880
	r_PackedHalf2AtPtx883R314 = DecodeE4(r_PtxU16Register44);						 // PTX L883
	r_PackedHalf2AtPtx886R311 = DecodeE4(r_PtxU16Register45);						 // PTX L886
	r_PackedHalf2AtPtx889R317 = DecodeE4(r_PtxU16Register46);						 // PTX L889
	r_PackedHalf2AtPtx892R320 = DecodeE4(r_PtxU16Register47);						 // PTX L892
	r_PackedHalf2AtPtx895R326 = DecodeE4(r_PtxU16Register48);						 // PTX L895
	r_PackedHalf2AtPtx898R323 = DecodeE4(r_PtxU16Register49);						 // PTX L898
	r_PackedHalf2AtPtx901R329 = DecodeE4(r_PtxU16Register50);						 // PTX L901
	r_PackedHalf2AtPtx904R332 = DecodeE4(r_PtxU16Register51);						 // PTX L904
	r_PackedHalf2AtPtx907R338 = DecodeE4(r_PtxU16Register52);						 // PTX L907
	r_PackedHalf2AtPtx910R335 = DecodeE4(r_PtxU16Register53);						 // PTX L910
	r_PackedHalf2AtPtx913R341 = DecodeE4(r_PtxU16Register54);						 // PTX L913
	r_PackedHalf2AtPtx916R344 = DecodeE4(r_PtxU16Register55);						 // PTX L916
	r_PackedHalf2AtPtx919R350 = DecodeE4(r_PtxU16Register56);						 // PTX L919
	r_PackedHalf2AtPtx922R347 = DecodeE4(r_PtxU16Register57);						 // PTX L922
	r_PackedHalf2AtPtx925R353 = DecodeE4(r_PtxU16Register58);						 // PTX L925
	r_PackedHalf2AtPtx928R356 = DecodeE4(r_PtxU16Register59);						 // PTX L928
	r_PackedHalf2AtPtx931R362 = DecodeE4(r_PtxU16Register60);						 // PTX L931
	r_PackedHalf2AtPtx934R359 = DecodeE4(r_PtxU16Register61);						 // PTX L934
	r_PackedHalf2AtPtx937R365 = DecodeE4(r_PtxU16Register62);						 // PTX L937
	r_PackedHalf2AtPtx940R368 = DecodeE4(r_PtxU16Register63);						 // PTX L940
	r_PackedHalf2AtPtx943R374 = DecodeE4(r_PtxU16Register64);						 // PTX L943
	r_PackedHalf2AtPtx946R371 = DecodeE4(r_PtxU16Register65);						 // PTX L946
	r_PackedHalf2AtPtx949R377 = DecodeE4(r_PtxU16Register66);						 // PTX L949
	r_PackedHalf2AtPtx952R380 = DecodeE4(r_PtxU16Register67);						 // PTX L952
	r_PackedHalf2AtPtx955R386 = DecodeE4(r_PtxU16Register68);						 // PTX L955
	r_PackedHalf2AtPtx958R383 = DecodeE4(r_PtxU16Register69);						 // PTX L958
	r_PackedHalf2AtPtx961R389 = DecodeE4(r_PtxU16Register70);						 // PTX L961
	r_PackedHalf2AtPtx964R392 = DecodeE4(r_PtxU16Register71);						 // PTX L964
	r_PackedHalf2AtPtx967R398 = DecodeE4(r_PtxU16Register72);						 // PTX L967
	r_PackedHalf2AtPtx970R395 = DecodeE4(r_PtxU16Register73);						 // PTX L970
	r_PackedHalf2AtPtx973R401 = DecodeE4(r_PtxU16Register74);						 // PTX L973
	r_PackedHalf2AtPtx976R404 = DecodeE4(r_PtxU16Register75);						 // PTX L976
	r_PackedHalf2AtPtx979R410 = DecodeE4(r_PtxU16Register76);						 // PTX L979
	r_PackedHalf2AtPtx982R407 = DecodeE4(r_PtxU16Register77);						 // PTX L982
	r_PackedHalf2AtPtx985R413 = DecodeE4(r_PtxU16Register78);						 // PTX L985
	r_PackedHalf2AtPtx988R416 = DecodeE4(r_PtxU16Register79);						 // PTX L988
	r_PackedHalf2AtPtx991R422 = DecodeE4(r_PtxU16Register80);						 // PTX L991
	r_PackedHalf2AtPtx994R419 = DecodeE4(r_PtxU16Register81);						 // PTX L994
	r_PackedHalf2AtPtx997R425 = DecodeE4(r_PtxU16Register82);						 // PTX L997
	r_PtxU16Register83 = uint16_t(r_PtxRegister1708);
	r_PtxU16Register84 = uint16_t(r_PtxRegister1708 >> 16);	   // PTX L999
	r_PackedHalf2AtPtx1001R428 = DecodeE4(r_PtxU16Register83); // PTX L1001
	r_PackedHalf2AtPtx1004R434 = DecodeE4(r_PtxU16Register84); // PTX L1004
	r_PtxU16Register85 = uint16_t(r_PtxRegister1709);
	r_PtxU16Register86 = uint16_t(r_PtxRegister1709 >> 16);	   // PTX L1006
	r_PackedHalf2AtPtx1008R431 = DecodeE4(r_PtxU16Register85); // PTX L1008
	r_PackedHalf2AtPtx1011R437 = DecodeE4(r_PtxU16Register86); // PTX L1011
	r_PtxU16Register87 = uint16_t(r_PtxRegister1710);
	r_PtxU16Register88 = uint16_t(r_PtxRegister1710 >> 16);	   // PTX L1013
	r_PackedHalf2AtPtx1015R440 = DecodeE4(r_PtxU16Register87); // PTX L1015
	r_PackedHalf2AtPtx1018R446 = DecodeE4(r_PtxU16Register88); // PTX L1018
	r_PtxU16Register89 = uint16_t(r_PtxRegister1711);
	r_PtxU16Register90 = uint16_t(r_PtxRegister1711 >> 16);									 // PTX L1020
	r_PackedHalf2AtPtx1022R443 = DecodeE4(r_PtxU16Register89);								 // PTX L1022
	r_PackedHalf2AtPtx1025R449 = DecodeE4(r_PtxU16Register90);								 // PTX L1025
	g_RecordByteAddressAtPtx1027 = g_RecordBaseAddress;										 // PTX L1027
	r_PtxRegister451 = uint32_t(r_PtxRegister5) + uint32_t(8);								 // PTX L1028
	r_LaneIndexAtPtx1030 = uint32_t((threadIdx.x & 31u));									 // PTX L1030
	r_PtxRegister452 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1030), uint32_t(31));		 // PTX L1032
	r_PtxRegister453 = ShiftRight(uint32_t(r_PtxRegister452), uint32_t(30));				 // PTX L1033
	r_PtxRegister454 = uint32_t(r_LaneIndexAtPtx1030) + uint32_t(r_PtxRegister453);			 // PTX L1034
	r_PtxRegister455 = r_PtxRegister454 & 2147483644;										 // PTX L1035
	r_PtxRegister456 = uint32_t(r_LaneIndexAtPtx1030) - uint32_t(r_PtxRegister455);			 // PTX L1036
	r_PtxRegister457 = ShiftLeft(uint32_t(r_PtxRegister456), uint32_t(1));					 // PTX L1037
	r_PtxRegister458 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister457);				 // PTX L1038
	r_PtxRegister459 = ShiftRightSigned(int32_t(r_PtxRegister458), uint32_t(1));			 // PTX L1039
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister459)) * int64_t(int32_t(4))); // PTX L1040
	g_RecordByteAddressAtPtx1041 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register99); // PTX L1041
	r_PtxRegister261 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1041 + 4194304ull);		  // PTX L1042
	r_LaneIndexAtPtx1044 = uint32_t((threadIdx.x & 31u));									  // PTX L1044
	r_PtxRegister460 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1044), uint32_t(31));		  // PTX L1046
	r_PtxRegister461 = ShiftRight(uint32_t(r_PtxRegister460), uint32_t(30));				  // PTX L1047
	r_PtxRegister462 = uint32_t(r_LaneIndexAtPtx1044) + uint32_t(r_PtxRegister461);			  // PTX L1048
	r_PtxRegister463 = r_PtxRegister462 & 2147483644;										  // PTX L1049
	r_PtxRegister464 = uint32_t(r_LaneIndexAtPtx1044) - uint32_t(r_PtxRegister463);			  // PTX L1050
	r_PtxRegister465 = ShiftLeft(uint32_t(r_PtxRegister464), uint32_t(1));					  // PTX L1051
	r_PtxRegister466 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister465);				  // PTX L1052
	r_PtxRegister467 = ShiftRightSigned(int32_t(r_PtxRegister466), uint32_t(1));			  // PTX L1053
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister467)) * int64_t(int32_t(4))); // PTX L1054
	g_RecordByteAddressAtPtx1055 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register101); // PTX L1055
	r_PtxRegister264 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1055 + 4194304ull);		  // PTX L1056
	r_LaneIndexAtPtx1058 = uint32_t((threadIdx.x & 31u));									  // PTX L1058
	r_PtxRegister468 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1058), uint32_t(31));		  // PTX L1060
	r_PtxRegister469 = ShiftRight(uint32_t(r_PtxRegister468), uint32_t(30));				  // PTX L1061
	r_PtxRegister470 = uint32_t(r_LaneIndexAtPtx1058) + uint32_t(r_PtxRegister469);			  // PTX L1062
	r_PtxRegister471 = r_PtxRegister470 & 2147483644;										  // PTX L1063
	r_PtxRegister472 = uint32_t(r_LaneIndexAtPtx1058) - uint32_t(r_PtxRegister471);			  // PTX L1064
	r_PtxRegister473 = ShiftLeft(uint32_t(r_PtxRegister472), uint32_t(1));					  // PTX L1065
	r_PtxRegister474 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister473);				  // PTX L1066
	r_PtxRegister475 = ShiftRightSigned(int32_t(r_PtxRegister474), uint32_t(1));			  // PTX L1067
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister475)) * int64_t(int32_t(4))); // PTX L1068
	g_RecordByteAddressAtPtx1069 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register103); // PTX L1069
	r_PtxRegister267 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1069 + 4194304ull);		  // PTX L1070
	r_LaneIndexAtPtx1072 = uint32_t((threadIdx.x & 31u));									  // PTX L1072
	r_PtxRegister476 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1072), uint32_t(31));		  // PTX L1074
	r_PtxRegister477 = ShiftRight(uint32_t(r_PtxRegister476), uint32_t(30));				  // PTX L1075
	r_PtxRegister478 = uint32_t(r_LaneIndexAtPtx1072) + uint32_t(r_PtxRegister477);			  // PTX L1076
	r_PtxRegister479 = r_PtxRegister478 & 2147483644;										  // PTX L1077
	r_PtxRegister480 = uint32_t(r_LaneIndexAtPtx1072) - uint32_t(r_PtxRegister479);			  // PTX L1078
	r_PtxRegister481 = ShiftLeft(uint32_t(r_PtxRegister480), uint32_t(1));					  // PTX L1079
	r_PtxRegister482 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister481);				  // PTX L1080
	r_PtxRegister483 = ShiftRightSigned(int32_t(r_PtxRegister482), uint32_t(1));			  // PTX L1081
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister483)) * int64_t(int32_t(4))); // PTX L1082
	g_RecordByteAddressAtPtx1083 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register105); // PTX L1083
	r_PtxRegister270 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1083 + 4194304ull);		  // PTX L1084
	r_LaneIndexAtPtx1086 = uint32_t((threadIdx.x & 31u));									  // PTX L1086
	r_PtxRegister484 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1086), uint32_t(31));		  // PTX L1088
	r_PtxRegister485 = ShiftRight(uint32_t(r_PtxRegister484), uint32_t(30));				  // PTX L1089
	r_PtxRegister486 = uint32_t(r_LaneIndexAtPtx1086) + uint32_t(r_PtxRegister485);			  // PTX L1090
	r_PtxRegister487 = r_PtxRegister486 & 2147483644;										  // PTX L1091
	r_PtxRegister488 = uint32_t(r_LaneIndexAtPtx1086) - uint32_t(r_PtxRegister487);			  // PTX L1092
	r_PtxRegister489 = ShiftLeft(uint32_t(r_PtxRegister488), uint32_t(1));					  // PTX L1093
	r_PtxRegister490 = uint32_t(r_PtxRegister5) + uint32_t(16);								  // PTX L1094
	r_PtxRegister491 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister489);				  // PTX L1095
	r_PtxRegister492 = ShiftRightSigned(int32_t(r_PtxRegister491), uint32_t(1));			  // PTX L1096
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister492)) * int64_t(int32_t(4))); // PTX L1097
	g_RecordByteAddressAtPtx1098 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register107); // PTX L1098
	r_PtxRegister273 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1098 + 4194304ull);		  // PTX L1099
	r_LaneIndexAtPtx1101 = uint32_t((threadIdx.x & 31u));									  // PTX L1101
	r_PtxRegister493 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1101), uint32_t(31));		  // PTX L1103
	r_PtxRegister494 = ShiftRight(uint32_t(r_PtxRegister493), uint32_t(30));				  // PTX L1104
	r_PtxRegister495 = uint32_t(r_LaneIndexAtPtx1101) + uint32_t(r_PtxRegister494);			  // PTX L1105
	r_PtxRegister496 = r_PtxRegister495 & 2147483644;										  // PTX L1106
	r_PtxRegister497 = uint32_t(r_LaneIndexAtPtx1101) - uint32_t(r_PtxRegister496);			  // PTX L1107
	r_PtxRegister498 = ShiftLeft(uint32_t(r_PtxRegister497), uint32_t(1));					  // PTX L1108
	r_PtxRegister499 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister498);				  // PTX L1109
	r_PtxRegister500 = ShiftRightSigned(int32_t(r_PtxRegister499), uint32_t(1));			  // PTX L1110
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister500)) * int64_t(int32_t(4))); // PTX L1111
	g_RecordByteAddressAtPtx1112 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register109); // PTX L1112
	r_PtxRegister276 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1112 + 4194304ull);		  // PTX L1113
	r_LaneIndexAtPtx1115 = uint32_t((threadIdx.x & 31u));									  // PTX L1115
	r_PtxRegister501 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1115), uint32_t(31));		  // PTX L1117
	r_PtxRegister502 = ShiftRight(uint32_t(r_PtxRegister501), uint32_t(30));				  // PTX L1118
	r_PtxRegister503 = uint32_t(r_LaneIndexAtPtx1115) + uint32_t(r_PtxRegister502);			  // PTX L1119
	r_PtxRegister504 = r_PtxRegister503 & 2147483644;										  // PTX L1120
	r_PtxRegister505 = uint32_t(r_LaneIndexAtPtx1115) - uint32_t(r_PtxRegister504);			  // PTX L1121
	r_PtxRegister506 = ShiftLeft(uint32_t(r_PtxRegister505), uint32_t(1));					  // PTX L1122
	r_PtxRegister507 = uint32_t(r_PtxRegister5) + uint32_t(24);								  // PTX L1123
	r_PtxRegister508 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister506);				  // PTX L1124
	r_PtxRegister509 = ShiftRight(uint32_t(r_PtxRegister508), uint32_t(31));				  // PTX L1125
	r_PtxRegister510 = uint32_t(r_PtxRegister508) + uint32_t(r_PtxRegister509);				  // PTX L1126
	r_PtxRegister511 = ShiftRightSigned(int32_t(r_PtxRegister510), uint32_t(1));			  // PTX L1127
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister511)) * int64_t(int32_t(4))); // PTX L1128
	g_RecordByteAddressAtPtx1129 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register111); // PTX L1129
	r_PtxRegister279 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1129 + 4194304ull);		  // PTX L1130
	r_LaneIndexAtPtx1132 = uint32_t((threadIdx.x & 31u));									  // PTX L1132
	r_PtxRegister512 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1132), uint32_t(31));		  // PTX L1134
	r_PtxRegister513 = ShiftRight(uint32_t(r_PtxRegister512), uint32_t(30));				  // PTX L1135
	r_PtxRegister514 = uint32_t(r_LaneIndexAtPtx1132) + uint32_t(r_PtxRegister513);			  // PTX L1136
	r_PtxRegister515 = r_PtxRegister514 & 2147483644;										  // PTX L1137
	r_PtxRegister516 = uint32_t(r_LaneIndexAtPtx1132) - uint32_t(r_PtxRegister515);			  // PTX L1138
	r_PtxRegister517 = ShiftLeft(uint32_t(r_PtxRegister516), uint32_t(1));					  // PTX L1139
	r_PtxRegister518 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister517);				  // PTX L1140
	r_PtxRegister519 = ShiftRight(uint32_t(r_PtxRegister518), uint32_t(31));				  // PTX L1141
	r_PtxRegister520 = uint32_t(r_PtxRegister518) + uint32_t(r_PtxRegister519);				  // PTX L1142
	r_PtxRegister521 = ShiftRightSigned(int32_t(r_PtxRegister520), uint32_t(1));			  // PTX L1143
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister521)) * int64_t(int32_t(4))); // PTX L1144
	g_RecordByteAddressAtPtx1145 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register113); // PTX L1145
	r_PtxRegister282 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1145 + 4194304ull);		  // PTX L1146
	r_LaneIndexAtPtx1148 = uint32_t((threadIdx.x & 31u));									  // PTX L1148
	r_PtxRegister522 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1148), uint32_t(31));		  // PTX L1150
	r_PtxRegister523 = ShiftRight(uint32_t(r_PtxRegister522), uint32_t(30));				  // PTX L1151
	r_PtxRegister524 = uint32_t(r_LaneIndexAtPtx1148) + uint32_t(r_PtxRegister523);			  // PTX L1152
	r_PtxRegister525 = r_PtxRegister524 & 2147483644;										  // PTX L1153
	r_PtxRegister526 = uint32_t(r_LaneIndexAtPtx1148) - uint32_t(r_PtxRegister525);			  // PTX L1154
	r_PtxRegister527 = ShiftLeft(uint32_t(r_PtxRegister526), uint32_t(1));					  // PTX L1155
	r_PtxRegister528 = uint32_t(r_PtxRegister5) + uint32_t(32);								  // PTX L1156
	r_PtxRegister529 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister527);				  // PTX L1157
	r_PtxRegister530 = ShiftRightSigned(int32_t(r_PtxRegister529), uint32_t(1));			  // PTX L1158
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister530)) * int64_t(int32_t(4))); // PTX L1159
	g_RecordByteAddressAtPtx1160 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register115); // PTX L1160
	r_PtxRegister285 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1160 + 4194304ull);		  // PTX L1161
	r_LaneIndexAtPtx1163 = uint32_t((threadIdx.x & 31u));									  // PTX L1163
	r_PtxRegister531 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1163), uint32_t(31));		  // PTX L1165
	r_PtxRegister532 = ShiftRight(uint32_t(r_PtxRegister531), uint32_t(30));				  // PTX L1166
	r_PtxRegister533 = uint32_t(r_LaneIndexAtPtx1163) + uint32_t(r_PtxRegister532);			  // PTX L1167
	r_PtxRegister534 = r_PtxRegister533 & 2147483644;										  // PTX L1168
	r_PtxRegister535 = uint32_t(r_LaneIndexAtPtx1163) - uint32_t(r_PtxRegister534);			  // PTX L1169
	r_PtxRegister536 = ShiftLeft(uint32_t(r_PtxRegister535), uint32_t(1));					  // PTX L1170
	r_PtxRegister537 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister536);				  // PTX L1171
	r_PtxRegister538 = ShiftRightSigned(int32_t(r_PtxRegister537), uint32_t(1));			  // PTX L1172
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister538)) * int64_t(int32_t(4))); // PTX L1173
	g_RecordByteAddressAtPtx1174 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register117); // PTX L1174
	r_PtxRegister288 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1174 + 4194304ull);		  // PTX L1175
	r_LaneIndexAtPtx1177 = uint32_t((threadIdx.x & 31u));									  // PTX L1177
	r_PtxRegister539 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1177), uint32_t(31));		  // PTX L1179
	r_PtxRegister540 = ShiftRight(uint32_t(r_PtxRegister539), uint32_t(30));				  // PTX L1180
	r_PtxRegister541 = uint32_t(r_LaneIndexAtPtx1177) + uint32_t(r_PtxRegister540);			  // PTX L1181
	r_PtxRegister542 = r_PtxRegister541 & 2147483644;										  // PTX L1182
	r_PtxRegister543 = uint32_t(r_LaneIndexAtPtx1177) - uint32_t(r_PtxRegister542);			  // PTX L1183
	r_PtxRegister544 = ShiftLeft(uint32_t(r_PtxRegister543), uint32_t(1));					  // PTX L1184
	r_PtxRegister545 = uint32_t(r_PtxRegister5) + uint32_t(40);								  // PTX L1185
	r_PtxRegister546 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister544);				  // PTX L1186
	r_PtxRegister547 = ShiftRight(uint32_t(r_PtxRegister546), uint32_t(31));				  // PTX L1187
	r_PtxRegister548 = uint32_t(r_PtxRegister546) + uint32_t(r_PtxRegister547);				  // PTX L1188
	r_PtxRegister549 = ShiftRightSigned(int32_t(r_PtxRegister548), uint32_t(1));			  // PTX L1189
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister549)) * int64_t(int32_t(4))); // PTX L1190
	g_RecordByteAddressAtPtx1191 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register119); // PTX L1191
	r_PtxRegister291 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1191 + 4194304ull);		  // PTX L1192
	r_LaneIndexAtPtx1194 = uint32_t((threadIdx.x & 31u));									  // PTX L1194
	r_PtxRegister550 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1194), uint32_t(31));		  // PTX L1196
	r_PtxRegister551 = ShiftRight(uint32_t(r_PtxRegister550), uint32_t(30));				  // PTX L1197
	r_PtxRegister552 = uint32_t(r_LaneIndexAtPtx1194) + uint32_t(r_PtxRegister551);			  // PTX L1198
	r_PtxRegister553 = r_PtxRegister552 & 2147483644;										  // PTX L1199
	r_PtxRegister554 = uint32_t(r_LaneIndexAtPtx1194) - uint32_t(r_PtxRegister553);			  // PTX L1200
	r_PtxRegister555 = ShiftLeft(uint32_t(r_PtxRegister554), uint32_t(1));					  // PTX L1201
	r_PtxRegister556 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister555);				  // PTX L1202
	r_PtxRegister557 = ShiftRight(uint32_t(r_PtxRegister556), uint32_t(31));				  // PTX L1203
	r_PtxRegister558 = uint32_t(r_PtxRegister556) + uint32_t(r_PtxRegister557);				  // PTX L1204
	r_PtxRegister559 = ShiftRightSigned(int32_t(r_PtxRegister558), uint32_t(1));			  // PTX L1205
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister559)) * int64_t(int32_t(4))); // PTX L1206
	g_RecordByteAddressAtPtx1207 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register121); // PTX L1207
	r_PtxRegister294 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1207 + 4194304ull);		  // PTX L1208
	r_LaneIndexAtPtx1210 = uint32_t((threadIdx.x & 31u));									  // PTX L1210
	r_PtxRegister560 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1210), uint32_t(31));		  // PTX L1212
	r_PtxRegister561 = ShiftRight(uint32_t(r_PtxRegister560), uint32_t(30));				  // PTX L1213
	r_PtxRegister562 = uint32_t(r_LaneIndexAtPtx1210) + uint32_t(r_PtxRegister561);			  // PTX L1214
	r_PtxRegister563 = r_PtxRegister562 & 2147483644;										  // PTX L1215
	r_PtxRegister564 = uint32_t(r_LaneIndexAtPtx1210) - uint32_t(r_PtxRegister563);			  // PTX L1216
	r_PtxRegister565 = ShiftLeft(uint32_t(r_PtxRegister564), uint32_t(1));					  // PTX L1217
	r_PtxRegister566 = uint32_t(r_PtxRegister5) + uint32_t(48);								  // PTX L1218
	r_PtxRegister567 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister565);				  // PTX L1219
	r_PtxRegister568 = ShiftRightSigned(int32_t(r_PtxRegister567), uint32_t(1));			  // PTX L1220
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister568)) * int64_t(int32_t(4))); // PTX L1221
	g_RecordByteAddressAtPtx1222 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register123); // PTX L1222
	r_PtxRegister297 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1222 + 4194304ull);		  // PTX L1223
	r_LaneIndexAtPtx1225 = uint32_t((threadIdx.x & 31u));									  // PTX L1225
	r_PtxRegister569 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1225), uint32_t(31));		  // PTX L1227
	r_PtxRegister570 = ShiftRight(uint32_t(r_PtxRegister569), uint32_t(30));				  // PTX L1228
	r_PtxRegister571 = uint32_t(r_LaneIndexAtPtx1225) + uint32_t(r_PtxRegister570);			  // PTX L1229
	r_PtxRegister572 = r_PtxRegister571 & 2147483644;										  // PTX L1230
	r_PtxRegister573 = uint32_t(r_LaneIndexAtPtx1225) - uint32_t(r_PtxRegister572);			  // PTX L1231
	r_PtxRegister574 = ShiftLeft(uint32_t(r_PtxRegister573), uint32_t(1));					  // PTX L1232
	r_PtxRegister575 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister574);				  // PTX L1233
	r_PtxRegister576 = ShiftRightSigned(int32_t(r_PtxRegister575), uint32_t(1));			  // PTX L1234
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister576)) * int64_t(int32_t(4))); // PTX L1235
	g_RecordByteAddressAtPtx1236 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register125); // PTX L1236
	r_PtxRegister300 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1236 + 4194304ull);		  // PTX L1237
	r_LaneIndexAtPtx1239 = uint32_t((threadIdx.x & 31u));									  // PTX L1239
	r_PtxRegister577 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1239), uint32_t(31));		  // PTX L1241
	r_PtxRegister578 = ShiftRight(uint32_t(r_PtxRegister577), uint32_t(30));				  // PTX L1242
	r_PtxRegister579 = uint32_t(r_LaneIndexAtPtx1239) + uint32_t(r_PtxRegister578);			  // PTX L1243
	r_PtxRegister580 = r_PtxRegister579 & 2147483644;										  // PTX L1244
	r_PtxRegister581 = uint32_t(r_LaneIndexAtPtx1239) - uint32_t(r_PtxRegister580);			  // PTX L1245
	r_PtxRegister582 = ShiftLeft(uint32_t(r_PtxRegister581), uint32_t(1));					  // PTX L1246
	r_PtxRegister583 = uint32_t(r_PtxRegister5) + uint32_t(56);								  // PTX L1247
	r_PtxRegister584 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister582);				  // PTX L1248
	r_PtxRegister585 = ShiftRight(uint32_t(r_PtxRegister584), uint32_t(31));				  // PTX L1249
	r_PtxRegister586 = uint32_t(r_PtxRegister584) + uint32_t(r_PtxRegister585);				  // PTX L1250
	r_PtxRegister587 = ShiftRightSigned(int32_t(r_PtxRegister586), uint32_t(1));			  // PTX L1251
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister587)) * int64_t(int32_t(4))); // PTX L1252
	g_RecordByteAddressAtPtx1253 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register127); // PTX L1253
	r_PtxRegister303 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1253 + 4194304ull);		  // PTX L1254
	r_LaneIndexAtPtx1256 = uint32_t((threadIdx.x & 31u));									  // PTX L1256
	r_PtxRegister588 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1256), uint32_t(31));		  // PTX L1258
	r_PtxRegister589 = ShiftRight(uint32_t(r_PtxRegister588), uint32_t(30));				  // PTX L1259
	r_PtxRegister590 = uint32_t(r_LaneIndexAtPtx1256) + uint32_t(r_PtxRegister589);			  // PTX L1260
	r_PtxRegister591 = r_PtxRegister590 & 2147483644;										  // PTX L1261
	r_PtxRegister592 = uint32_t(r_LaneIndexAtPtx1256) - uint32_t(r_PtxRegister591);			  // PTX L1262
	r_PtxRegister593 = ShiftLeft(uint32_t(r_PtxRegister592), uint32_t(1));					  // PTX L1263
	r_PtxRegister594 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister593);				  // PTX L1264
	r_PtxRegister595 = ShiftRight(uint32_t(r_PtxRegister594), uint32_t(31));				  // PTX L1265
	r_PtxRegister596 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister595);				  // PTX L1266
	r_PtxRegister597 = ShiftRightSigned(int32_t(r_PtxRegister596), uint32_t(1));			  // PTX L1267
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister597)) * int64_t(int32_t(4))); // PTX L1268
	g_RecordByteAddressAtPtx1269 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register129); // PTX L1269
	r_PtxRegister306 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1269 + 4194304ull);		  // PTX L1270
	r_LaneIndexAtPtx1272 = uint32_t((threadIdx.x & 31u));									  // PTX L1272
	r_PtxRegister598 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1272), uint32_t(31));		  // PTX L1274
	r_PtxRegister599 = ShiftRight(uint32_t(r_PtxRegister598), uint32_t(30));				  // PTX L1275
	r_PtxRegister600 = uint32_t(r_LaneIndexAtPtx1272) + uint32_t(r_PtxRegister599);			  // PTX L1276
	r_PtxRegister601 = r_PtxRegister600 & 2147483644;										  // PTX L1277
	r_PtxRegister602 = uint32_t(r_LaneIndexAtPtx1272) - uint32_t(r_PtxRegister601);			  // PTX L1278
	r_PtxRegister603 = ShiftLeft(uint32_t(r_PtxRegister602), uint32_t(1));					  // PTX L1279
	r_PtxRegister604 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister603);				  // PTX L1280
	r_PtxRegister605 = ShiftRightSigned(int32_t(r_PtxRegister604), uint32_t(1));			  // PTX L1281
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister605)) * int64_t(int32_t(4))); // PTX L1282
	g_RecordByteAddressAtPtx1283 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register131); // PTX L1283
	r_PtxRegister309 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1283 + 4194304ull);		  // PTX L1284
	r_LaneIndexAtPtx1286 = uint32_t((threadIdx.x & 31u));									  // PTX L1286
	r_PtxRegister606 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1286), uint32_t(31));		  // PTX L1288
	r_PtxRegister607 = ShiftRight(uint32_t(r_PtxRegister606), uint32_t(30));				  // PTX L1289
	r_PtxRegister608 = uint32_t(r_LaneIndexAtPtx1286) + uint32_t(r_PtxRegister607);			  // PTX L1290
	r_PtxRegister609 = r_PtxRegister608 & 2147483644;										  // PTX L1291
	r_PtxRegister610 = uint32_t(r_LaneIndexAtPtx1286) - uint32_t(r_PtxRegister609);			  // PTX L1292
	r_PtxRegister611 = ShiftLeft(uint32_t(r_PtxRegister610), uint32_t(1));					  // PTX L1293
	r_PtxRegister612 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister611);				  // PTX L1294
	r_PtxRegister613 = ShiftRightSigned(int32_t(r_PtxRegister612), uint32_t(1));			  // PTX L1295
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister613)) * int64_t(int32_t(4))); // PTX L1296
	g_RecordByteAddressAtPtx1297 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register133); // PTX L1297
	r_PtxRegister312 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1297 + 4194304ull);		  // PTX L1298
	r_LaneIndexAtPtx1300 = uint32_t((threadIdx.x & 31u));									  // PTX L1300
	r_PtxRegister614 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1300), uint32_t(31));		  // PTX L1302
	r_PtxRegister615 = ShiftRight(uint32_t(r_PtxRegister614), uint32_t(30));				  // PTX L1303
	r_PtxRegister616 = uint32_t(r_LaneIndexAtPtx1300) + uint32_t(r_PtxRegister615);			  // PTX L1304
	r_PtxRegister617 = r_PtxRegister616 & 2147483644;										  // PTX L1305
	r_PtxRegister618 = uint32_t(r_LaneIndexAtPtx1300) - uint32_t(r_PtxRegister617);			  // PTX L1306
	r_PtxRegister619 = ShiftLeft(uint32_t(r_PtxRegister618), uint32_t(1));					  // PTX L1307
	r_PtxRegister620 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister619);				  // PTX L1308
	r_PtxRegister621 = ShiftRightSigned(int32_t(r_PtxRegister620), uint32_t(1));			  // PTX L1309
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister621)) * int64_t(int32_t(4))); // PTX L1310
	g_RecordByteAddressAtPtx1311 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register135); // PTX L1311
	r_PtxRegister315 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1311 + 4194304ull);		  // PTX L1312
	r_LaneIndexAtPtx1314 = uint32_t((threadIdx.x & 31u));									  // PTX L1314
	r_PtxRegister622 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1314), uint32_t(31));		  // PTX L1316
	r_PtxRegister623 = ShiftRight(uint32_t(r_PtxRegister622), uint32_t(30));				  // PTX L1317
	r_PtxRegister624 = uint32_t(r_LaneIndexAtPtx1314) + uint32_t(r_PtxRegister623);			  // PTX L1318
	r_PtxRegister625 = r_PtxRegister624 & 2147483644;										  // PTX L1319
	r_PtxRegister626 = uint32_t(r_LaneIndexAtPtx1314) - uint32_t(r_PtxRegister625);			  // PTX L1320
	r_PtxRegister627 = ShiftLeft(uint32_t(r_PtxRegister626), uint32_t(1));					  // PTX L1321
	r_PtxRegister628 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister627);				  // PTX L1322
	r_PtxRegister629 = ShiftRightSigned(int32_t(r_PtxRegister628), uint32_t(1));			  // PTX L1323
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister629)) * int64_t(int32_t(4))); // PTX L1324
	g_RecordByteAddressAtPtx1325 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register137); // PTX L1325
	r_PtxRegister318 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1325 + 4194304ull);		  // PTX L1326
	r_LaneIndexAtPtx1328 = uint32_t((threadIdx.x & 31u));									  // PTX L1328
	r_PtxRegister630 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1328), uint32_t(31));		  // PTX L1330
	r_PtxRegister631 = ShiftRight(uint32_t(r_PtxRegister630), uint32_t(30));				  // PTX L1331
	r_PtxRegister632 = uint32_t(r_LaneIndexAtPtx1328) + uint32_t(r_PtxRegister631);			  // PTX L1332
	r_PtxRegister633 = r_PtxRegister632 & 2147483644;										  // PTX L1333
	r_PtxRegister634 = uint32_t(r_LaneIndexAtPtx1328) - uint32_t(r_PtxRegister633);			  // PTX L1334
	r_PtxRegister635 = ShiftLeft(uint32_t(r_PtxRegister634), uint32_t(1));					  // PTX L1335
	r_PtxRegister636 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister635);				  // PTX L1336
	r_PtxRegister637 = ShiftRightSigned(int32_t(r_PtxRegister636), uint32_t(1));			  // PTX L1337
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister637)) * int64_t(int32_t(4))); // PTX L1338
	g_RecordByteAddressAtPtx1339 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register139); // PTX L1339
	r_PtxRegister321 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1339 + 4194304ull);		  // PTX L1340
	r_LaneIndexAtPtx1342 = uint32_t((threadIdx.x & 31u));									  // PTX L1342
	r_PtxRegister638 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1342), uint32_t(31));		  // PTX L1344
	r_PtxRegister639 = ShiftRight(uint32_t(r_PtxRegister638), uint32_t(30));				  // PTX L1345
	r_PtxRegister640 = uint32_t(r_LaneIndexAtPtx1342) + uint32_t(r_PtxRegister639);			  // PTX L1346
	r_PtxRegister641 = r_PtxRegister640 & 2147483644;										  // PTX L1347
	r_PtxRegister642 = uint32_t(r_LaneIndexAtPtx1342) - uint32_t(r_PtxRegister641);			  // PTX L1348
	r_PtxRegister643 = ShiftLeft(uint32_t(r_PtxRegister642), uint32_t(1));					  // PTX L1349
	r_PtxRegister644 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister643);				  // PTX L1350
	r_PtxRegister645 = ShiftRightSigned(int32_t(r_PtxRegister644), uint32_t(1));			  // PTX L1351
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister645)) * int64_t(int32_t(4))); // PTX L1352
	g_RecordByteAddressAtPtx1353 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register141); // PTX L1353
	r_PtxRegister324 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1353 + 4194304ull);		  // PTX L1354
	r_LaneIndexAtPtx1356 = uint32_t((threadIdx.x & 31u));									  // PTX L1356
	r_PtxRegister646 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1356), uint32_t(31));		  // PTX L1358
	r_PtxRegister647 = ShiftRight(uint32_t(r_PtxRegister646), uint32_t(30));				  // PTX L1359
	r_PtxRegister648 = uint32_t(r_LaneIndexAtPtx1356) + uint32_t(r_PtxRegister647);			  // PTX L1360
	r_PtxRegister649 = r_PtxRegister648 & 2147483644;										  // PTX L1361
	r_PtxRegister650 = uint32_t(r_LaneIndexAtPtx1356) - uint32_t(r_PtxRegister649);			  // PTX L1362
	r_PtxRegister651 = ShiftLeft(uint32_t(r_PtxRegister650), uint32_t(1));					  // PTX L1363
	r_PtxRegister652 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister651);				  // PTX L1364
	r_PtxRegister653 = ShiftRight(uint32_t(r_PtxRegister652), uint32_t(31));				  // PTX L1365
	r_PtxRegister654 = uint32_t(r_PtxRegister652) + uint32_t(r_PtxRegister653);				  // PTX L1366
	r_PtxRegister655 = ShiftRightSigned(int32_t(r_PtxRegister654), uint32_t(1));			  // PTX L1367
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister655)) * int64_t(int32_t(4))); // PTX L1368
	g_RecordByteAddressAtPtx1369 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register143); // PTX L1369
	r_PtxRegister327 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1369 + 4194304ull);		  // PTX L1370
	r_LaneIndexAtPtx1372 = uint32_t((threadIdx.x & 31u));									  // PTX L1372
	r_PtxRegister656 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1372), uint32_t(31));		  // PTX L1374
	r_PtxRegister657 = ShiftRight(uint32_t(r_PtxRegister656), uint32_t(30));				  // PTX L1375
	r_PtxRegister658 = uint32_t(r_LaneIndexAtPtx1372) + uint32_t(r_PtxRegister657);			  // PTX L1376
	r_PtxRegister659 = r_PtxRegister658 & 2147483644;										  // PTX L1377
	r_PtxRegister660 = uint32_t(r_LaneIndexAtPtx1372) - uint32_t(r_PtxRegister659);			  // PTX L1378
	r_PtxRegister661 = ShiftLeft(uint32_t(r_PtxRegister660), uint32_t(1));					  // PTX L1379
	r_PtxRegister662 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister661);				  // PTX L1380
	r_PtxRegister663 = ShiftRight(uint32_t(r_PtxRegister662), uint32_t(31));				  // PTX L1381
	r_PtxRegister664 = uint32_t(r_PtxRegister662) + uint32_t(r_PtxRegister663);				  // PTX L1382
	r_PtxRegister665 = ShiftRightSigned(int32_t(r_PtxRegister664), uint32_t(1));			  // PTX L1383
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister665)) * int64_t(int32_t(4))); // PTX L1384
	g_RecordByteAddressAtPtx1385 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register145); // PTX L1385
	r_PtxRegister330 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1385 + 4194304ull);		  // PTX L1386
	r_LaneIndexAtPtx1388 = uint32_t((threadIdx.x & 31u));									  // PTX L1388
	r_PtxRegister666 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1388), uint32_t(31));		  // PTX L1390
	r_PtxRegister667 = ShiftRight(uint32_t(r_PtxRegister666), uint32_t(30));				  // PTX L1391
	r_PtxRegister668 = uint32_t(r_LaneIndexAtPtx1388) + uint32_t(r_PtxRegister667);			  // PTX L1392
	r_PtxRegister669 = r_PtxRegister668 & 2147483644;										  // PTX L1393
	r_PtxRegister670 = uint32_t(r_LaneIndexAtPtx1388) - uint32_t(r_PtxRegister669);			  // PTX L1394
	r_PtxRegister671 = ShiftLeft(uint32_t(r_PtxRegister670), uint32_t(1));					  // PTX L1395
	r_PtxRegister672 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister671);				  // PTX L1396
	r_PtxRegister673 = ShiftRightSigned(int32_t(r_PtxRegister672), uint32_t(1));			  // PTX L1397
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister673)) * int64_t(int32_t(4))); // PTX L1398
	g_RecordByteAddressAtPtx1399 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register147); // PTX L1399
	r_PtxRegister333 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1399 + 4194304ull);		  // PTX L1400
	r_LaneIndexAtPtx1402 = uint32_t((threadIdx.x & 31u));									  // PTX L1402
	r_PtxRegister674 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1402), uint32_t(31));		  // PTX L1404
	r_PtxRegister675 = ShiftRight(uint32_t(r_PtxRegister674), uint32_t(30));				  // PTX L1405
	r_PtxRegister676 = uint32_t(r_LaneIndexAtPtx1402) + uint32_t(r_PtxRegister675);			  // PTX L1406
	r_PtxRegister677 = r_PtxRegister676 & 2147483644;										  // PTX L1407
	r_PtxRegister678 = uint32_t(r_LaneIndexAtPtx1402) - uint32_t(r_PtxRegister677);			  // PTX L1408
	r_PtxRegister679 = ShiftLeft(uint32_t(r_PtxRegister678), uint32_t(1));					  // PTX L1409
	r_PtxRegister680 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister679);				  // PTX L1410
	r_PtxRegister681 = ShiftRightSigned(int32_t(r_PtxRegister680), uint32_t(1));			  // PTX L1411
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister681)) * int64_t(int32_t(4))); // PTX L1412
	g_RecordByteAddressAtPtx1413 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register149); // PTX L1413
	r_PtxRegister336 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1413 + 4194304ull);		  // PTX L1414
	r_LaneIndexAtPtx1416 = uint32_t((threadIdx.x & 31u));									  // PTX L1416
	r_PtxRegister682 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1416), uint32_t(31));		  // PTX L1418
	r_PtxRegister683 = ShiftRight(uint32_t(r_PtxRegister682), uint32_t(30));				  // PTX L1419
	r_PtxRegister684 = uint32_t(r_LaneIndexAtPtx1416) + uint32_t(r_PtxRegister683);			  // PTX L1420
	r_PtxRegister685 = r_PtxRegister684 & 2147483644;										  // PTX L1421
	r_PtxRegister686 = uint32_t(r_LaneIndexAtPtx1416) - uint32_t(r_PtxRegister685);			  // PTX L1422
	r_PtxRegister687 = ShiftLeft(uint32_t(r_PtxRegister686), uint32_t(1));					  // PTX L1423
	r_PtxRegister688 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister687);				  // PTX L1424
	r_PtxRegister689 = ShiftRight(uint32_t(r_PtxRegister688), uint32_t(31));				  // PTX L1425
	r_PtxRegister690 = uint32_t(r_PtxRegister688) + uint32_t(r_PtxRegister689);				  // PTX L1426
	r_PtxRegister691 = ShiftRightSigned(int32_t(r_PtxRegister690), uint32_t(1));			  // PTX L1427
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister691)) * int64_t(int32_t(4))); // PTX L1428
	g_RecordByteAddressAtPtx1429 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register151); // PTX L1429
	r_PtxRegister339 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1429 + 4194304ull);		  // PTX L1430
	r_LaneIndexAtPtx1432 = uint32_t((threadIdx.x & 31u));									  // PTX L1432
	r_PtxRegister692 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1432), uint32_t(31));		  // PTX L1434
	r_PtxRegister693 = ShiftRight(uint32_t(r_PtxRegister692), uint32_t(30));				  // PTX L1435
	r_PtxRegister694 = uint32_t(r_LaneIndexAtPtx1432) + uint32_t(r_PtxRegister693);			  // PTX L1436
	r_PtxRegister695 = r_PtxRegister694 & 2147483644;										  // PTX L1437
	r_PtxRegister696 = uint32_t(r_LaneIndexAtPtx1432) - uint32_t(r_PtxRegister695);			  // PTX L1438
	r_PtxRegister697 = ShiftLeft(uint32_t(r_PtxRegister696), uint32_t(1));					  // PTX L1439
	r_PtxRegister698 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister697);				  // PTX L1440
	r_PtxRegister699 = ShiftRight(uint32_t(r_PtxRegister698), uint32_t(31));				  // PTX L1441
	r_PtxRegister700 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister699);				  // PTX L1442
	r_PtxRegister701 = ShiftRightSigned(int32_t(r_PtxRegister700), uint32_t(1));			  // PTX L1443
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister701)) * int64_t(int32_t(4))); // PTX L1444
	g_RecordByteAddressAtPtx1445 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register153); // PTX L1445
	r_PtxRegister342 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1445 + 4194304ull);		  // PTX L1446
	r_LaneIndexAtPtx1448 = uint32_t((threadIdx.x & 31u));									  // PTX L1448
	r_PtxRegister702 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1448), uint32_t(31));		  // PTX L1450
	r_PtxRegister703 = ShiftRight(uint32_t(r_PtxRegister702), uint32_t(30));				  // PTX L1451
	r_PtxRegister704 = uint32_t(r_LaneIndexAtPtx1448) + uint32_t(r_PtxRegister703);			  // PTX L1452
	r_PtxRegister705 = r_PtxRegister704 & 2147483644;										  // PTX L1453
	r_PtxRegister706 = uint32_t(r_LaneIndexAtPtx1448) - uint32_t(r_PtxRegister705);			  // PTX L1454
	r_PtxRegister707 = ShiftLeft(uint32_t(r_PtxRegister706), uint32_t(1));					  // PTX L1455
	r_PtxRegister708 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister707);				  // PTX L1456
	r_PtxRegister709 = ShiftRightSigned(int32_t(r_PtxRegister708), uint32_t(1));			  // PTX L1457
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister709)) * int64_t(int32_t(4))); // PTX L1458
	g_RecordByteAddressAtPtx1459 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register155); // PTX L1459
	r_PtxRegister345 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1459 + 4194304ull);		  // PTX L1460
	r_LaneIndexAtPtx1462 = uint32_t((threadIdx.x & 31u));									  // PTX L1462
	r_PtxRegister710 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1462), uint32_t(31));		  // PTX L1464
	r_PtxRegister711 = ShiftRight(uint32_t(r_PtxRegister710), uint32_t(30));				  // PTX L1465
	r_PtxRegister712 = uint32_t(r_LaneIndexAtPtx1462) + uint32_t(r_PtxRegister711);			  // PTX L1466
	r_PtxRegister713 = r_PtxRegister712 & 2147483644;										  // PTX L1467
	r_PtxRegister714 = uint32_t(r_LaneIndexAtPtx1462) - uint32_t(r_PtxRegister713);			  // PTX L1468
	r_PtxRegister715 = ShiftLeft(uint32_t(r_PtxRegister714), uint32_t(1));					  // PTX L1469
	r_PtxRegister716 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister715);				  // PTX L1470
	r_PtxRegister717 = ShiftRightSigned(int32_t(r_PtxRegister716), uint32_t(1));			  // PTX L1471
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister717)) * int64_t(int32_t(4))); // PTX L1472
	g_RecordByteAddressAtPtx1473 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register157); // PTX L1473
	r_PtxRegister348 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1473 + 4194304ull);		  // PTX L1474
	r_LaneIndexAtPtx1476 = uint32_t((threadIdx.x & 31u));									  // PTX L1476
	r_PtxRegister718 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1476), uint32_t(31));		  // PTX L1478
	r_PtxRegister719 = ShiftRight(uint32_t(r_PtxRegister718), uint32_t(30));				  // PTX L1479
	r_PtxRegister720 = uint32_t(r_LaneIndexAtPtx1476) + uint32_t(r_PtxRegister719);			  // PTX L1480
	r_PtxRegister721 = r_PtxRegister720 & 2147483644;										  // PTX L1481
	r_PtxRegister722 = uint32_t(r_LaneIndexAtPtx1476) - uint32_t(r_PtxRegister721);			  // PTX L1482
	r_PtxRegister723 = ShiftLeft(uint32_t(r_PtxRegister722), uint32_t(1));					  // PTX L1483
	r_PtxRegister724 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister723);				  // PTX L1484
	r_PtxRegister725 = ShiftRight(uint32_t(r_PtxRegister724), uint32_t(31));				  // PTX L1485
	r_PtxRegister726 = uint32_t(r_PtxRegister724) + uint32_t(r_PtxRegister725);				  // PTX L1486
	r_PtxRegister727 = ShiftRightSigned(int32_t(r_PtxRegister726), uint32_t(1));			  // PTX L1487
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister727)) * int64_t(int32_t(4))); // PTX L1488
	g_RecordByteAddressAtPtx1489 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register159); // PTX L1489
	r_PtxRegister351 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1489 + 4194304ull);		  // PTX L1490
	r_LaneIndexAtPtx1492 = uint32_t((threadIdx.x & 31u));									  // PTX L1492
	r_PtxRegister728 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1492), uint32_t(31));		  // PTX L1494
	r_PtxRegister729 = ShiftRight(uint32_t(r_PtxRegister728), uint32_t(30));				  // PTX L1495
	r_PtxRegister730 = uint32_t(r_LaneIndexAtPtx1492) + uint32_t(r_PtxRegister729);			  // PTX L1496
	r_PtxRegister731 = r_PtxRegister730 & 2147483644;										  // PTX L1497
	r_PtxRegister732 = uint32_t(r_LaneIndexAtPtx1492) - uint32_t(r_PtxRegister731);			  // PTX L1498
	r_PtxRegister733 = ShiftLeft(uint32_t(r_PtxRegister732), uint32_t(1));					  // PTX L1499
	r_PtxRegister734 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister733);				  // PTX L1500
	r_PtxRegister735 = ShiftRight(uint32_t(r_PtxRegister734), uint32_t(31));				  // PTX L1501
	r_PtxRegister736 = uint32_t(r_PtxRegister734) + uint32_t(r_PtxRegister735);				  // PTX L1502
	r_PtxRegister737 = ShiftRightSigned(int32_t(r_PtxRegister736), uint32_t(1));			  // PTX L1503
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister737)) * int64_t(int32_t(4))); // PTX L1504
	g_RecordByteAddressAtPtx1505 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register161); // PTX L1505
	r_PtxRegister354 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1505 + 4194304ull);		  // PTX L1506
	r_LaneIndexAtPtx1508 = uint32_t((threadIdx.x & 31u));									  // PTX L1508
	r_PtxRegister738 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1508), uint32_t(31));		  // PTX L1510
	r_PtxRegister739 = ShiftRight(uint32_t(r_PtxRegister738), uint32_t(30));				  // PTX L1511
	r_PtxRegister740 = uint32_t(r_LaneIndexAtPtx1508) + uint32_t(r_PtxRegister739);			  // PTX L1512
	r_PtxRegister741 = r_PtxRegister740 & 2147483644;										  // PTX L1513
	r_PtxRegister742 = uint32_t(r_LaneIndexAtPtx1508) - uint32_t(r_PtxRegister741);			  // PTX L1514
	r_PtxRegister743 = ShiftLeft(uint32_t(r_PtxRegister742), uint32_t(1));					  // PTX L1515
	r_PtxRegister744 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister743);				  // PTX L1516
	r_PtxRegister745 = ShiftRightSigned(int32_t(r_PtxRegister744), uint32_t(1));			  // PTX L1517
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister745)) * int64_t(int32_t(4))); // PTX L1518
	g_RecordByteAddressAtPtx1519 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register163); // PTX L1519
	r_PtxRegister357 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1519 + 4194304ull);		  // PTX L1520
	r_LaneIndexAtPtx1522 = uint32_t((threadIdx.x & 31u));									  // PTX L1522
	r_PtxRegister746 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1522), uint32_t(31));		  // PTX L1524
	r_PtxRegister747 = ShiftRight(uint32_t(r_PtxRegister746), uint32_t(30));				  // PTX L1525
	r_PtxRegister748 = uint32_t(r_LaneIndexAtPtx1522) + uint32_t(r_PtxRegister747);			  // PTX L1526
	r_PtxRegister749 = r_PtxRegister748 & 2147483644;										  // PTX L1527
	r_PtxRegister750 = uint32_t(r_LaneIndexAtPtx1522) - uint32_t(r_PtxRegister749);			  // PTX L1528
	r_PtxRegister751 = ShiftLeft(uint32_t(r_PtxRegister750), uint32_t(1));					  // PTX L1529
	r_PtxRegister752 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister751);				  // PTX L1530
	r_PtxRegister753 = ShiftRightSigned(int32_t(r_PtxRegister752), uint32_t(1));			  // PTX L1531
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister753)) * int64_t(int32_t(4))); // PTX L1532
	g_RecordByteAddressAtPtx1533 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register165); // PTX L1533
	r_PtxRegister360 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1533 + 4194304ull);		  // PTX L1534
	r_LaneIndexAtPtx1536 = uint32_t((threadIdx.x & 31u));									  // PTX L1536
	r_PtxRegister754 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1536), uint32_t(31));		  // PTX L1538
	r_PtxRegister755 = ShiftRight(uint32_t(r_PtxRegister754), uint32_t(30));				  // PTX L1539
	r_PtxRegister756 = uint32_t(r_LaneIndexAtPtx1536) + uint32_t(r_PtxRegister755);			  // PTX L1540
	r_PtxRegister757 = r_PtxRegister756 & 2147483644;										  // PTX L1541
	r_PtxRegister758 = uint32_t(r_LaneIndexAtPtx1536) - uint32_t(r_PtxRegister757);			  // PTX L1542
	r_PtxRegister759 = ShiftLeft(uint32_t(r_PtxRegister758), uint32_t(1));					  // PTX L1543
	r_PtxRegister760 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister759);				  // PTX L1544
	r_PtxRegister761 = ShiftRightSigned(int32_t(r_PtxRegister760), uint32_t(1));			  // PTX L1545
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister761)) * int64_t(int32_t(4))); // PTX L1546
	g_RecordByteAddressAtPtx1547 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register167); // PTX L1547
	r_PtxRegister363 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1547 + 4194304ull);		  // PTX L1548
	r_LaneIndexAtPtx1550 = uint32_t((threadIdx.x & 31u));									  // PTX L1550
	r_PtxRegister762 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1550), uint32_t(31));		  // PTX L1552
	r_PtxRegister763 = ShiftRight(uint32_t(r_PtxRegister762), uint32_t(30));				  // PTX L1553
	r_PtxRegister764 = uint32_t(r_LaneIndexAtPtx1550) + uint32_t(r_PtxRegister763);			  // PTX L1554
	r_PtxRegister765 = r_PtxRegister764 & 2147483644;										  // PTX L1555
	r_PtxRegister766 = uint32_t(r_LaneIndexAtPtx1550) - uint32_t(r_PtxRegister765);			  // PTX L1556
	r_PtxRegister767 = ShiftLeft(uint32_t(r_PtxRegister766), uint32_t(1));					  // PTX L1557
	r_PtxRegister768 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister767);				  // PTX L1558
	r_PtxRegister769 = ShiftRightSigned(int32_t(r_PtxRegister768), uint32_t(1));			  // PTX L1559
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister769)) * int64_t(int32_t(4))); // PTX L1560
	g_RecordByteAddressAtPtx1561 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register169); // PTX L1561
	r_PtxRegister366 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1561 + 4194304ull);		  // PTX L1562
	r_LaneIndexAtPtx1564 = uint32_t((threadIdx.x & 31u));									  // PTX L1564
	r_PtxRegister770 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1564), uint32_t(31));		  // PTX L1566
	r_PtxRegister771 = ShiftRight(uint32_t(r_PtxRegister770), uint32_t(30));				  // PTX L1567
	r_PtxRegister772 = uint32_t(r_LaneIndexAtPtx1564) + uint32_t(r_PtxRegister771);			  // PTX L1568
	r_PtxRegister773 = r_PtxRegister772 & 2147483644;										  // PTX L1569
	r_PtxRegister774 = uint32_t(r_LaneIndexAtPtx1564) - uint32_t(r_PtxRegister773);			  // PTX L1570
	r_PtxRegister775 = ShiftLeft(uint32_t(r_PtxRegister774), uint32_t(1));					  // PTX L1571
	r_PtxRegister776 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister775);				  // PTX L1572
	r_PtxRegister777 = ShiftRightSigned(int32_t(r_PtxRegister776), uint32_t(1));			  // PTX L1573
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister777)) * int64_t(int32_t(4))); // PTX L1574
	g_RecordByteAddressAtPtx1575 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register171); // PTX L1575
	r_PtxRegister369 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1575 + 4194304ull);		  // PTX L1576
	r_LaneIndexAtPtx1578 = uint32_t((threadIdx.x & 31u));									  // PTX L1578
	r_PtxRegister778 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1578), uint32_t(31));		  // PTX L1580
	r_PtxRegister779 = ShiftRight(uint32_t(r_PtxRegister778), uint32_t(30));				  // PTX L1581
	r_PtxRegister780 = uint32_t(r_LaneIndexAtPtx1578) + uint32_t(r_PtxRegister779);			  // PTX L1582
	r_PtxRegister781 = r_PtxRegister780 & 2147483644;										  // PTX L1583
	r_PtxRegister782 = uint32_t(r_LaneIndexAtPtx1578) - uint32_t(r_PtxRegister781);			  // PTX L1584
	r_PtxRegister783 = ShiftLeft(uint32_t(r_PtxRegister782), uint32_t(1));					  // PTX L1585
	r_PtxRegister784 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister783);				  // PTX L1586
	r_PtxRegister785 = ShiftRightSigned(int32_t(r_PtxRegister784), uint32_t(1));			  // PTX L1587
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister785)) * int64_t(int32_t(4))); // PTX L1588
	g_RecordByteAddressAtPtx1589 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register173); // PTX L1589
	r_PtxRegister372 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1589 + 4194304ull);		  // PTX L1590
	r_LaneIndexAtPtx1592 = uint32_t((threadIdx.x & 31u));									  // PTX L1592
	r_PtxRegister786 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1592), uint32_t(31));		  // PTX L1594
	r_PtxRegister787 = ShiftRight(uint32_t(r_PtxRegister786), uint32_t(30));				  // PTX L1595
	r_PtxRegister788 = uint32_t(r_LaneIndexAtPtx1592) + uint32_t(r_PtxRegister787);			  // PTX L1596
	r_PtxRegister789 = r_PtxRegister788 & 2147483644;										  // PTX L1597
	r_PtxRegister790 = uint32_t(r_LaneIndexAtPtx1592) - uint32_t(r_PtxRegister789);			  // PTX L1598
	r_PtxRegister791 = ShiftLeft(uint32_t(r_PtxRegister790), uint32_t(1));					  // PTX L1599
	r_PtxRegister792 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister791);				  // PTX L1600
	r_PtxRegister793 = ShiftRight(uint32_t(r_PtxRegister792), uint32_t(31));				  // PTX L1601
	r_PtxRegister794 = uint32_t(r_PtxRegister792) + uint32_t(r_PtxRegister793);				  // PTX L1602
	r_PtxRegister795 = ShiftRightSigned(int32_t(r_PtxRegister794), uint32_t(1));			  // PTX L1603
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister795)) * int64_t(int32_t(4))); // PTX L1604
	g_RecordByteAddressAtPtx1605 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register175); // PTX L1605
	r_PtxRegister375 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1605 + 4194304ull);		  // PTX L1606
	r_LaneIndexAtPtx1608 = uint32_t((threadIdx.x & 31u));									  // PTX L1608
	r_PtxRegister796 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1608), uint32_t(31));		  // PTX L1610
	r_PtxRegister797 = ShiftRight(uint32_t(r_PtxRegister796), uint32_t(30));				  // PTX L1611
	r_PtxRegister798 = uint32_t(r_LaneIndexAtPtx1608) + uint32_t(r_PtxRegister797);			  // PTX L1612
	r_PtxRegister799 = r_PtxRegister798 & 2147483644;										  // PTX L1613
	r_PtxRegister800 = uint32_t(r_LaneIndexAtPtx1608) - uint32_t(r_PtxRegister799);			  // PTX L1614
	r_PtxRegister801 = ShiftLeft(uint32_t(r_PtxRegister800), uint32_t(1));					  // PTX L1615
	r_PtxRegister802 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister801);				  // PTX L1616
	r_PtxRegister803 = ShiftRight(uint32_t(r_PtxRegister802), uint32_t(31));				  // PTX L1617
	r_PtxRegister804 = uint32_t(r_PtxRegister802) + uint32_t(r_PtxRegister803);				  // PTX L1618
	r_PtxRegister805 = ShiftRightSigned(int32_t(r_PtxRegister804), uint32_t(1));			  // PTX L1619
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister805)) * int64_t(int32_t(4))); // PTX L1620
	g_RecordByteAddressAtPtx1621 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register177); // PTX L1621
	r_PtxRegister378 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1621 + 4194304ull);		  // PTX L1622
	r_LaneIndexAtPtx1624 = uint32_t((threadIdx.x & 31u));									  // PTX L1624
	r_PtxRegister806 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1624), uint32_t(31));		  // PTX L1626
	r_PtxRegister807 = ShiftRight(uint32_t(r_PtxRegister806), uint32_t(30));				  // PTX L1627
	r_PtxRegister808 = uint32_t(r_LaneIndexAtPtx1624) + uint32_t(r_PtxRegister807);			  // PTX L1628
	r_PtxRegister809 = r_PtxRegister808 & 2147483644;										  // PTX L1629
	r_PtxRegister810 = uint32_t(r_LaneIndexAtPtx1624) - uint32_t(r_PtxRegister809);			  // PTX L1630
	r_PtxRegister811 = ShiftLeft(uint32_t(r_PtxRegister810), uint32_t(1));					  // PTX L1631
	r_PtxRegister812 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister811);				  // PTX L1632
	r_PtxRegister813 = ShiftRightSigned(int32_t(r_PtxRegister812), uint32_t(1));			  // PTX L1633
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister813)) * int64_t(int32_t(4))); // PTX L1634
	g_RecordByteAddressAtPtx1635 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register179); // PTX L1635
	r_PtxRegister381 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1635 + 4194304ull);		  // PTX L1636
	r_LaneIndexAtPtx1638 = uint32_t((threadIdx.x & 31u));									  // PTX L1638
	r_PtxRegister814 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1638), uint32_t(31));		  // PTX L1640
	r_PtxRegister815 = ShiftRight(uint32_t(r_PtxRegister814), uint32_t(30));				  // PTX L1641
	r_PtxRegister816 = uint32_t(r_LaneIndexAtPtx1638) + uint32_t(r_PtxRegister815);			  // PTX L1642
	r_PtxRegister817 = r_PtxRegister816 & 2147483644;										  // PTX L1643
	r_PtxRegister818 = uint32_t(r_LaneIndexAtPtx1638) - uint32_t(r_PtxRegister817);			  // PTX L1644
	r_PtxRegister819 = ShiftLeft(uint32_t(r_PtxRegister818), uint32_t(1));					  // PTX L1645
	r_PtxRegister820 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister819);				  // PTX L1646
	r_PtxRegister821 = ShiftRightSigned(int32_t(r_PtxRegister820), uint32_t(1));			  // PTX L1647
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister821)) * int64_t(int32_t(4))); // PTX L1648
	g_RecordByteAddressAtPtx1649 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register181); // PTX L1649
	r_PtxRegister384 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1649 + 4194304ull);		  // PTX L1650
	r_LaneIndexAtPtx1652 = uint32_t((threadIdx.x & 31u));									  // PTX L1652
	r_PtxRegister822 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1652), uint32_t(31));		  // PTX L1654
	r_PtxRegister823 = ShiftRight(uint32_t(r_PtxRegister822), uint32_t(30));				  // PTX L1655
	r_PtxRegister824 = uint32_t(r_LaneIndexAtPtx1652) + uint32_t(r_PtxRegister823);			  // PTX L1656
	r_PtxRegister825 = r_PtxRegister824 & 2147483644;										  // PTX L1657
	r_PtxRegister826 = uint32_t(r_LaneIndexAtPtx1652) - uint32_t(r_PtxRegister825);			  // PTX L1658
	r_PtxRegister827 = ShiftLeft(uint32_t(r_PtxRegister826), uint32_t(1));					  // PTX L1659
	r_PtxRegister828 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister827);				  // PTX L1660
	r_PtxRegister829 = ShiftRight(uint32_t(r_PtxRegister828), uint32_t(31));				  // PTX L1661
	r_PtxRegister830 = uint32_t(r_PtxRegister828) + uint32_t(r_PtxRegister829);				  // PTX L1662
	r_PtxRegister831 = ShiftRightSigned(int32_t(r_PtxRegister830), uint32_t(1));			  // PTX L1663
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister831)) * int64_t(int32_t(4))); // PTX L1664
	g_RecordByteAddressAtPtx1665 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register183); // PTX L1665
	r_PtxRegister387 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1665 + 4194304ull);		  // PTX L1666
	r_LaneIndexAtPtx1668 = uint32_t((threadIdx.x & 31u));									  // PTX L1668
	r_PtxRegister832 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1668), uint32_t(31));		  // PTX L1670
	r_PtxRegister833 = ShiftRight(uint32_t(r_PtxRegister832), uint32_t(30));				  // PTX L1671
	r_PtxRegister834 = uint32_t(r_LaneIndexAtPtx1668) + uint32_t(r_PtxRegister833);			  // PTX L1672
	r_PtxRegister835 = r_PtxRegister834 & 2147483644;										  // PTX L1673
	r_PtxRegister836 = uint32_t(r_LaneIndexAtPtx1668) - uint32_t(r_PtxRegister835);			  // PTX L1674
	r_PtxRegister837 = ShiftLeft(uint32_t(r_PtxRegister836), uint32_t(1));					  // PTX L1675
	r_PtxRegister838 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister837);				  // PTX L1676
	r_PtxRegister839 = ShiftRight(uint32_t(r_PtxRegister838), uint32_t(31));				  // PTX L1677
	r_PtxRegister840 = uint32_t(r_PtxRegister838) + uint32_t(r_PtxRegister839);				  // PTX L1678
	r_PtxRegister841 = ShiftRightSigned(int32_t(r_PtxRegister840), uint32_t(1));			  // PTX L1679
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister841)) * int64_t(int32_t(4))); // PTX L1680
	g_RecordByteAddressAtPtx1681 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register185); // PTX L1681
	r_PtxRegister390 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1681 + 4194304ull);		  // PTX L1682
	r_LaneIndexAtPtx1684 = uint32_t((threadIdx.x & 31u));									  // PTX L1684
	r_PtxRegister842 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1684), uint32_t(31));		  // PTX L1686
	r_PtxRegister843 = ShiftRight(uint32_t(r_PtxRegister842), uint32_t(30));				  // PTX L1687
	r_PtxRegister844 = uint32_t(r_LaneIndexAtPtx1684) + uint32_t(r_PtxRegister843);			  // PTX L1688
	r_PtxRegister845 = r_PtxRegister844 & 2147483644;										  // PTX L1689
	r_PtxRegister846 = uint32_t(r_LaneIndexAtPtx1684) - uint32_t(r_PtxRegister845);			  // PTX L1690
	r_PtxRegister847 = ShiftLeft(uint32_t(r_PtxRegister846), uint32_t(1));					  // PTX L1691
	r_PtxRegister848 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister847);				  // PTX L1692
	r_PtxRegister849 = ShiftRightSigned(int32_t(r_PtxRegister848), uint32_t(1));			  // PTX L1693
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister849)) * int64_t(int32_t(4))); // PTX L1694
	g_RecordByteAddressAtPtx1695 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register187); // PTX L1695
	r_PtxRegister393 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1695 + 4194304ull);		  // PTX L1696
	r_LaneIndexAtPtx1698 = uint32_t((threadIdx.x & 31u));									  // PTX L1698
	r_PtxRegister850 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1698), uint32_t(31));		  // PTX L1700
	r_PtxRegister851 = ShiftRight(uint32_t(r_PtxRegister850), uint32_t(30));				  // PTX L1701
	r_PtxRegister852 = uint32_t(r_LaneIndexAtPtx1698) + uint32_t(r_PtxRegister851);			  // PTX L1702
	r_PtxRegister853 = r_PtxRegister852 & 2147483644;										  // PTX L1703
	r_PtxRegister854 = uint32_t(r_LaneIndexAtPtx1698) - uint32_t(r_PtxRegister853);			  // PTX L1704
	r_PtxRegister855 = ShiftLeft(uint32_t(r_PtxRegister854), uint32_t(1));					  // PTX L1705
	r_PtxRegister856 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister855);				  // PTX L1706
	r_PtxRegister857 = ShiftRightSigned(int32_t(r_PtxRegister856), uint32_t(1));			  // PTX L1707
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister857)) * int64_t(int32_t(4))); // PTX L1708
	g_RecordByteAddressAtPtx1709 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register189); // PTX L1709
	r_PtxRegister396 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1709 + 4194304ull);		  // PTX L1710
	r_LaneIndexAtPtx1712 = uint32_t((threadIdx.x & 31u));									  // PTX L1712
	r_PtxRegister858 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1712), uint32_t(31));		  // PTX L1714
	r_PtxRegister859 = ShiftRight(uint32_t(r_PtxRegister858), uint32_t(30));				  // PTX L1715
	r_PtxRegister860 = uint32_t(r_LaneIndexAtPtx1712) + uint32_t(r_PtxRegister859);			  // PTX L1716
	r_PtxRegister861 = r_PtxRegister860 & 2147483644;										  // PTX L1717
	r_PtxRegister862 = uint32_t(r_LaneIndexAtPtx1712) - uint32_t(r_PtxRegister861);			  // PTX L1718
	r_PtxRegister863 = ShiftLeft(uint32_t(r_PtxRegister862), uint32_t(1));					  // PTX L1719
	r_PtxRegister864 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister863);				  // PTX L1720
	r_PtxRegister865 = ShiftRight(uint32_t(r_PtxRegister864), uint32_t(31));				  // PTX L1721
	r_PtxRegister866 = uint32_t(r_PtxRegister864) + uint32_t(r_PtxRegister865);				  // PTX L1722
	r_PtxRegister867 = ShiftRightSigned(int32_t(r_PtxRegister866), uint32_t(1));			  // PTX L1723
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister867)) * int64_t(int32_t(4))); // PTX L1724
	g_RecordByteAddressAtPtx1725 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register191); // PTX L1725
	r_PtxRegister399 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1725 + 4194304ull);		  // PTX L1726
	r_LaneIndexAtPtx1728 = uint32_t((threadIdx.x & 31u));									  // PTX L1728
	r_PtxRegister868 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1728), uint32_t(31));		  // PTX L1730
	r_PtxRegister869 = ShiftRight(uint32_t(r_PtxRegister868), uint32_t(30));				  // PTX L1731
	r_PtxRegister870 = uint32_t(r_LaneIndexAtPtx1728) + uint32_t(r_PtxRegister869);			  // PTX L1732
	r_PtxRegister871 = r_PtxRegister870 & 2147483644;										  // PTX L1733
	r_PtxRegister872 = uint32_t(r_LaneIndexAtPtx1728) - uint32_t(r_PtxRegister871);			  // PTX L1734
	r_PtxRegister873 = ShiftLeft(uint32_t(r_PtxRegister872), uint32_t(1));					  // PTX L1735
	r_PtxRegister874 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister873);				  // PTX L1736
	r_PtxRegister875 = ShiftRight(uint32_t(r_PtxRegister874), uint32_t(31));				  // PTX L1737
	r_PtxRegister876 = uint32_t(r_PtxRegister874) + uint32_t(r_PtxRegister875);				  // PTX L1738
	r_PtxRegister877 = ShiftRightSigned(int32_t(r_PtxRegister876), uint32_t(1));			  // PTX L1739
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister877)) * int64_t(int32_t(4))); // PTX L1740
	g_RecordByteAddressAtPtx1741 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register193); // PTX L1741
	r_PtxRegister402 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1741 + 4194304ull);		  // PTX L1742
	r_LaneIndexAtPtx1744 = uint32_t((threadIdx.x & 31u));									  // PTX L1744
	r_PtxRegister878 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1744), uint32_t(31));		  // PTX L1746
	r_PtxRegister879 = ShiftRight(uint32_t(r_PtxRegister878), uint32_t(30));				  // PTX L1747
	r_PtxRegister880 = uint32_t(r_LaneIndexAtPtx1744) + uint32_t(r_PtxRegister879);			  // PTX L1748
	r_PtxRegister881 = r_PtxRegister880 & 2147483644;										  // PTX L1749
	r_PtxRegister882 = uint32_t(r_LaneIndexAtPtx1744) - uint32_t(r_PtxRegister881);			  // PTX L1750
	r_PtxRegister883 = ShiftLeft(uint32_t(r_PtxRegister882), uint32_t(1));					  // PTX L1751
	r_PtxRegister884 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister883);				  // PTX L1752
	r_PtxRegister885 = ShiftRightSigned(int32_t(r_PtxRegister884), uint32_t(1));			  // PTX L1753
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister885)) * int64_t(int32_t(4))); // PTX L1754
	g_RecordByteAddressAtPtx1755 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register195); // PTX L1755
	r_PtxRegister405 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1755 + 4194304ull);		  // PTX L1756
	r_LaneIndexAtPtx1758 = uint32_t((threadIdx.x & 31u));									  // PTX L1758
	r_PtxRegister886 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1758), uint32_t(31));		  // PTX L1760
	r_PtxRegister887 = ShiftRight(uint32_t(r_PtxRegister886), uint32_t(30));				  // PTX L1761
	r_PtxRegister888 = uint32_t(r_LaneIndexAtPtx1758) + uint32_t(r_PtxRegister887);			  // PTX L1762
	r_PtxRegister889 = r_PtxRegister888 & 2147483644;										  // PTX L1763
	r_PtxRegister890 = uint32_t(r_LaneIndexAtPtx1758) - uint32_t(r_PtxRegister889);			  // PTX L1764
	r_PtxRegister891 = ShiftLeft(uint32_t(r_PtxRegister890), uint32_t(1));					  // PTX L1765
	r_PtxRegister892 = uint32_t(r_PtxRegister5) + uint32_t(r_PtxRegister891);				  // PTX L1766
	r_PtxRegister893 = ShiftRightSigned(int32_t(r_PtxRegister892), uint32_t(1));			  // PTX L1767
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister893)) * int64_t(int32_t(4))); // PTX L1768
	g_RecordByteAddressAtPtx1769 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register197); // PTX L1769
	r_PtxRegister408 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1769 + 4194304ull);		  // PTX L1770
	r_LaneIndexAtPtx1772 = uint32_t((threadIdx.x & 31u));									  // PTX L1772
	r_PtxRegister894 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1772), uint32_t(31));		  // PTX L1774
	r_PtxRegister895 = ShiftRight(uint32_t(r_PtxRegister894), uint32_t(30));				  // PTX L1775
	r_PtxRegister896 = uint32_t(r_LaneIndexAtPtx1772) + uint32_t(r_PtxRegister895);			  // PTX L1776
	r_PtxRegister897 = r_PtxRegister896 & 2147483644;										  // PTX L1777
	r_PtxRegister898 = uint32_t(r_LaneIndexAtPtx1772) - uint32_t(r_PtxRegister897);			  // PTX L1778
	r_PtxRegister899 = ShiftLeft(uint32_t(r_PtxRegister898), uint32_t(1));					  // PTX L1779
	r_PtxRegister900 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister899);				  // PTX L1780
	r_PtxRegister901 = ShiftRightSigned(int32_t(r_PtxRegister900), uint32_t(1));			  // PTX L1781
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister901)) * int64_t(int32_t(4))); // PTX L1782
	g_RecordByteAddressAtPtx1783 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register199); // PTX L1783
	r_PtxRegister411 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1783 + 4194304ull);		  // PTX L1784
	r_LaneIndexAtPtx1786 = uint32_t((threadIdx.x & 31u));									  // PTX L1786
	r_PtxRegister902 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1786), uint32_t(31));		  // PTX L1788
	r_PtxRegister903 = ShiftRight(uint32_t(r_PtxRegister902), uint32_t(30));				  // PTX L1789
	r_PtxRegister904 = uint32_t(r_LaneIndexAtPtx1786) + uint32_t(r_PtxRegister903);			  // PTX L1790
	r_PtxRegister905 = r_PtxRegister904 & 2147483644;										  // PTX L1791
	r_PtxRegister906 = uint32_t(r_LaneIndexAtPtx1786) - uint32_t(r_PtxRegister905);			  // PTX L1792
	r_PtxRegister907 = ShiftLeft(uint32_t(r_PtxRegister906), uint32_t(1));					  // PTX L1793
	r_PtxRegister908 = uint32_t(r_PtxRegister451) + uint32_t(r_PtxRegister907);				  // PTX L1794
	r_PtxRegister909 = ShiftRightSigned(int32_t(r_PtxRegister908), uint32_t(1));			  // PTX L1795
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister909)) * int64_t(int32_t(4))); // PTX L1796
	g_RecordByteAddressAtPtx1797 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register201); // PTX L1797
	r_PtxRegister414 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1797 + 4194304ull);		  // PTX L1798
	r_LaneIndexAtPtx1800 = uint32_t((threadIdx.x & 31u));									  // PTX L1800
	r_PtxRegister910 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1800), uint32_t(31));		  // PTX L1802
	r_PtxRegister911 = ShiftRight(uint32_t(r_PtxRegister910), uint32_t(30));				  // PTX L1803
	r_PtxRegister912 = uint32_t(r_LaneIndexAtPtx1800) + uint32_t(r_PtxRegister911);			  // PTX L1804
	r_PtxRegister913 = r_PtxRegister912 & 2147483644;										  // PTX L1805
	r_PtxRegister914 = uint32_t(r_LaneIndexAtPtx1800) - uint32_t(r_PtxRegister913);			  // PTX L1806
	r_PtxRegister915 = ShiftLeft(uint32_t(r_PtxRegister914), uint32_t(1));					  // PTX L1807
	r_PtxRegister916 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister915);				  // PTX L1808
	r_PtxRegister917 = ShiftRightSigned(int32_t(r_PtxRegister916), uint32_t(1));			  // PTX L1809
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister917)) * int64_t(int32_t(4))); // PTX L1810
	g_RecordByteAddressAtPtx1811 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register203); // PTX L1811
	r_PtxRegister417 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1811 + 4194304ull);		  // PTX L1812
	r_LaneIndexAtPtx1814 = uint32_t((threadIdx.x & 31u));									  // PTX L1814
	r_PtxRegister918 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1814), uint32_t(31));		  // PTX L1816
	r_PtxRegister919 = ShiftRight(uint32_t(r_PtxRegister918), uint32_t(30));				  // PTX L1817
	r_PtxRegister920 = uint32_t(r_LaneIndexAtPtx1814) + uint32_t(r_PtxRegister919);			  // PTX L1818
	r_PtxRegister921 = r_PtxRegister920 & 2147483644;										  // PTX L1819
	r_PtxRegister922 = uint32_t(r_LaneIndexAtPtx1814) - uint32_t(r_PtxRegister921);			  // PTX L1820
	r_PtxRegister923 = ShiftLeft(uint32_t(r_PtxRegister922), uint32_t(1));					  // PTX L1821
	r_PtxRegister924 = uint32_t(r_PtxRegister490) + uint32_t(r_PtxRegister923);				  // PTX L1822
	r_PtxRegister925 = ShiftRightSigned(int32_t(r_PtxRegister924), uint32_t(1));			  // PTX L1823
	r_PtxU64Register205 = uint64_t(int64_t(int32_t(r_PtxRegister925)) * int64_t(int32_t(4))); // PTX L1824
	g_RecordByteAddressAtPtx1825 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register205); // PTX L1825
	r_PtxRegister420 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1825 + 4194304ull);		  // PTX L1826
	r_LaneIndexAtPtx1828 = uint32_t((threadIdx.x & 31u));									  // PTX L1828
	r_PtxRegister926 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1828), uint32_t(31));		  // PTX L1830
	r_PtxRegister927 = ShiftRight(uint32_t(r_PtxRegister926), uint32_t(30));				  // PTX L1831
	r_PtxRegister928 = uint32_t(r_LaneIndexAtPtx1828) + uint32_t(r_PtxRegister927);			  // PTX L1832
	r_PtxRegister929 = r_PtxRegister928 & 2147483644;										  // PTX L1833
	r_PtxRegister930 = uint32_t(r_LaneIndexAtPtx1828) - uint32_t(r_PtxRegister929);			  // PTX L1834
	r_PtxRegister931 = ShiftLeft(uint32_t(r_PtxRegister930), uint32_t(1));					  // PTX L1835
	r_PtxRegister932 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister931);				  // PTX L1836
	r_PtxRegister933 = ShiftRight(uint32_t(r_PtxRegister932), uint32_t(31));				  // PTX L1837
	r_PtxRegister934 = uint32_t(r_PtxRegister932) + uint32_t(r_PtxRegister933);				  // PTX L1838
	r_PtxRegister935 = ShiftRightSigned(int32_t(r_PtxRegister934), uint32_t(1));			  // PTX L1839
	r_PtxU64Register207 = uint64_t(int64_t(int32_t(r_PtxRegister935)) * int64_t(int32_t(4))); // PTX L1840
	g_RecordByteAddressAtPtx1841 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register207); // PTX L1841
	r_PtxRegister423 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1841 + 4194304ull);		  // PTX L1842
	r_LaneIndexAtPtx1844 = uint32_t((threadIdx.x & 31u));									  // PTX L1844
	r_PtxRegister936 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1844), uint32_t(31));		  // PTX L1846
	r_PtxRegister937 = ShiftRight(uint32_t(r_PtxRegister936), uint32_t(30));				  // PTX L1847
	r_PtxRegister938 = uint32_t(r_LaneIndexAtPtx1844) + uint32_t(r_PtxRegister937);			  // PTX L1848
	r_PtxRegister939 = r_PtxRegister938 & 2147483644;										  // PTX L1849
	r_PtxRegister940 = uint32_t(r_LaneIndexAtPtx1844) - uint32_t(r_PtxRegister939);			  // PTX L1850
	r_PtxRegister941 = ShiftLeft(uint32_t(r_PtxRegister940), uint32_t(1));					  // PTX L1851
	r_PtxRegister942 = uint32_t(r_PtxRegister507) + uint32_t(r_PtxRegister941);				  // PTX L1852
	r_PtxRegister943 = ShiftRight(uint32_t(r_PtxRegister942), uint32_t(31));				  // PTX L1853
	r_PtxRegister944 = uint32_t(r_PtxRegister942) + uint32_t(r_PtxRegister943);				  // PTX L1854
	r_PtxRegister945 = ShiftRightSigned(int32_t(r_PtxRegister944), uint32_t(1));			  // PTX L1855
	r_PtxU64Register209 = uint64_t(int64_t(int32_t(r_PtxRegister945)) * int64_t(int32_t(4))); // PTX L1856
	g_RecordByteAddressAtPtx1857 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register209); // PTX L1857
	r_PtxRegister426 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1857 + 4194304ull);		  // PTX L1858
	r_LaneIndexAtPtx1860 = uint32_t((threadIdx.x & 31u));									  // PTX L1860
	r_PtxRegister946 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1860), uint32_t(31));		  // PTX L1862
	r_PtxRegister947 = ShiftRight(uint32_t(r_PtxRegister946), uint32_t(30));				  // PTX L1863
	r_PtxRegister948 = uint32_t(r_LaneIndexAtPtx1860) + uint32_t(r_PtxRegister947);			  // PTX L1864
	r_PtxRegister949 = r_PtxRegister948 & 2147483644;										  // PTX L1865
	r_PtxRegister950 = uint32_t(r_LaneIndexAtPtx1860) - uint32_t(r_PtxRegister949);			  // PTX L1866
	r_PtxRegister951 = ShiftLeft(uint32_t(r_PtxRegister950), uint32_t(1));					  // PTX L1867
	r_PtxRegister952 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister951);				  // PTX L1868
	r_PtxRegister953 = ShiftRightSigned(int32_t(r_PtxRegister952), uint32_t(1));			  // PTX L1869
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister953)) * int64_t(int32_t(4))); // PTX L1870
	g_RecordByteAddressAtPtx1871 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register211); // PTX L1871
	r_PtxRegister429 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1871 + 4194304ull);		  // PTX L1872
	r_LaneIndexAtPtx1874 = uint32_t((threadIdx.x & 31u));									  // PTX L1874
	r_PtxRegister954 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1874), uint32_t(31));		  // PTX L1876
	r_PtxRegister955 = ShiftRight(uint32_t(r_PtxRegister954), uint32_t(30));				  // PTX L1877
	r_PtxRegister956 = uint32_t(r_LaneIndexAtPtx1874) + uint32_t(r_PtxRegister955);			  // PTX L1878
	r_PtxRegister957 = r_PtxRegister956 & 2147483644;										  // PTX L1879
	r_PtxRegister958 = uint32_t(r_LaneIndexAtPtx1874) - uint32_t(r_PtxRegister957);			  // PTX L1880
	r_PtxRegister959 = ShiftLeft(uint32_t(r_PtxRegister958), uint32_t(1));					  // PTX L1881
	r_PtxRegister960 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister959);				  // PTX L1882
	r_PtxRegister961 = ShiftRightSigned(int32_t(r_PtxRegister960), uint32_t(1));			  // PTX L1883
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister961)) * int64_t(int32_t(4))); // PTX L1884
	g_RecordByteAddressAtPtx1885 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register213); // PTX L1885
	r_PtxRegister432 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1885 + 4194304ull);		  // PTX L1886
	r_LaneIndexAtPtx1888 = uint32_t((threadIdx.x & 31u));									  // PTX L1888
	r_PtxRegister962 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1888), uint32_t(31));		  // PTX L1890
	r_PtxRegister963 = ShiftRight(uint32_t(r_PtxRegister962), uint32_t(30));				  // PTX L1891
	r_PtxRegister964 = uint32_t(r_LaneIndexAtPtx1888) + uint32_t(r_PtxRegister963);			  // PTX L1892
	r_PtxRegister965 = r_PtxRegister964 & 2147483644;										  // PTX L1893
	r_PtxRegister966 = uint32_t(r_LaneIndexAtPtx1888) - uint32_t(r_PtxRegister965);			  // PTX L1894
	r_PtxRegister967 = ShiftLeft(uint32_t(r_PtxRegister966), uint32_t(1));					  // PTX L1895
	r_PtxRegister968 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister967);				  // PTX L1896
	r_PtxRegister969 = ShiftRight(uint32_t(r_PtxRegister968), uint32_t(31));				  // PTX L1897
	r_PtxRegister970 = uint32_t(r_PtxRegister968) + uint32_t(r_PtxRegister969);				  // PTX L1898
	r_PtxRegister971 = ShiftRightSigned(int32_t(r_PtxRegister970), uint32_t(1));			  // PTX L1899
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister971)) * int64_t(int32_t(4))); // PTX L1900
	g_RecordByteAddressAtPtx1901 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register215); // PTX L1901
	r_PtxRegister435 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1901 + 4194304ull);		  // PTX L1902
	r_LaneIndexAtPtx1904 = uint32_t((threadIdx.x & 31u));									  // PTX L1904
	r_PtxRegister972 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1904), uint32_t(31));		  // PTX L1906
	r_PtxRegister973 = ShiftRight(uint32_t(r_PtxRegister972), uint32_t(30));				  // PTX L1907
	r_PtxRegister974 = uint32_t(r_LaneIndexAtPtx1904) + uint32_t(r_PtxRegister973);			  // PTX L1908
	r_PtxRegister975 = r_PtxRegister974 & 2147483644;										  // PTX L1909
	r_PtxRegister976 = uint32_t(r_LaneIndexAtPtx1904) - uint32_t(r_PtxRegister975);			  // PTX L1910
	r_PtxRegister977 = ShiftLeft(uint32_t(r_PtxRegister976), uint32_t(1));					  // PTX L1911
	r_PtxRegister978 = uint32_t(r_PtxRegister545) + uint32_t(r_PtxRegister977);				  // PTX L1912
	r_PtxRegister979 = ShiftRight(uint32_t(r_PtxRegister978), uint32_t(31));				  // PTX L1913
	r_PtxRegister980 = uint32_t(r_PtxRegister978) + uint32_t(r_PtxRegister979);				  // PTX L1914
	r_PtxRegister981 = ShiftRightSigned(int32_t(r_PtxRegister980), uint32_t(1));			  // PTX L1915
	r_PtxU64Register217 = uint64_t(int64_t(int32_t(r_PtxRegister981)) * int64_t(int32_t(4))); // PTX L1916
	g_RecordByteAddressAtPtx1917 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register217); // PTX L1917
	r_PtxRegister438 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1917 + 4194304ull);		  // PTX L1918
	r_LaneIndexAtPtx1920 = uint32_t((threadIdx.x & 31u));									  // PTX L1920
	r_PtxRegister982 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1920), uint32_t(31));		  // PTX L1922
	r_PtxRegister983 = ShiftRight(uint32_t(r_PtxRegister982), uint32_t(30));				  // PTX L1923
	r_PtxRegister984 = uint32_t(r_LaneIndexAtPtx1920) + uint32_t(r_PtxRegister983);			  // PTX L1924
	r_PtxRegister985 = r_PtxRegister984 & 2147483644;										  // PTX L1925
	r_PtxRegister986 = uint32_t(r_LaneIndexAtPtx1920) - uint32_t(r_PtxRegister985);			  // PTX L1926
	r_PtxRegister987 = ShiftLeft(uint32_t(r_PtxRegister986), uint32_t(1));					  // PTX L1927
	r_PtxRegister988 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister987);				  // PTX L1928
	r_PtxRegister989 = ShiftRightSigned(int32_t(r_PtxRegister988), uint32_t(1));			  // PTX L1929
	r_PtxU64Register219 = uint64_t(int64_t(int32_t(r_PtxRegister989)) * int64_t(int32_t(4))); // PTX L1930
	g_RecordByteAddressAtPtx1931 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register219); // PTX L1931
	r_PtxRegister441 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1931 + 4194304ull);		  // PTX L1932
	r_LaneIndexAtPtx1934 = uint32_t((threadIdx.x & 31u));									  // PTX L1934
	r_PtxRegister990 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1934), uint32_t(31));		  // PTX L1936
	r_PtxRegister991 = ShiftRight(uint32_t(r_PtxRegister990), uint32_t(30));				  // PTX L1937
	r_PtxRegister992 = uint32_t(r_LaneIndexAtPtx1934) + uint32_t(r_PtxRegister991);			  // PTX L1938
	r_PtxRegister993 = r_PtxRegister992 & 2147483644;										  // PTX L1939
	r_PtxRegister994 = uint32_t(r_LaneIndexAtPtx1934) - uint32_t(r_PtxRegister993);			  // PTX L1940
	r_PtxRegister995 = ShiftLeft(uint32_t(r_PtxRegister994), uint32_t(1));					  // PTX L1941
	r_PtxRegister996 = uint32_t(r_PtxRegister566) + uint32_t(r_PtxRegister995);				  // PTX L1942
	r_PtxRegister997 = ShiftRightSigned(int32_t(r_PtxRegister996), uint32_t(1));			  // PTX L1943
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister997)) * int64_t(int32_t(4))); // PTX L1944
	g_RecordByteAddressAtPtx1945 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register221); // PTX L1945
	r_PtxRegister444 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1945 + 4194304ull);		   // PTX L1946
	r_LaneIndexAtPtx1948 = uint32_t((threadIdx.x & 31u));									   // PTX L1948
	r_PtxRegister998 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1948), uint32_t(31));		   // PTX L1950
	r_PtxRegister999 = ShiftRight(uint32_t(r_PtxRegister998), uint32_t(30));				   // PTX L1951
	r_PtxRegister1000 = uint32_t(r_LaneIndexAtPtx1948) + uint32_t(r_PtxRegister999);		   // PTX L1952
	r_PtxRegister1001 = r_PtxRegister1000 & 2147483644;										   // PTX L1953
	r_PtxRegister1002 = uint32_t(r_LaneIndexAtPtx1948) - uint32_t(r_PtxRegister1001);		   // PTX L1954
	r_PtxRegister1003 = ShiftLeft(uint32_t(r_PtxRegister1002), uint32_t(1));				   // PTX L1955
	r_PtxRegister1004 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister1003);			   // PTX L1956
	r_PtxRegister1005 = ShiftRight(uint32_t(r_PtxRegister1004), uint32_t(31));				   // PTX L1957
	r_PtxRegister1006 = uint32_t(r_PtxRegister1004) + uint32_t(r_PtxRegister1005);			   // PTX L1958
	r_PtxRegister1007 = ShiftRightSigned(int32_t(r_PtxRegister1006), uint32_t(1));			   // PTX L1959
	r_PtxU64Register223 = uint64_t(int64_t(int32_t(r_PtxRegister1007)) * int64_t(int32_t(4))); // PTX L1960
	g_RecordByteAddressAtPtx1961 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register223); // PTX L1961
	r_PtxRegister447 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1961 + 4194304ull);		   // PTX L1962
	r_LaneIndexAtPtx1964 = uint32_t((threadIdx.x & 31u));									   // PTX L1964
	r_PtxRegister1008 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1964), uint32_t(31));		   // PTX L1966
	r_PtxRegister1009 = ShiftRight(uint32_t(r_PtxRegister1008), uint32_t(30));				   // PTX L1967
	r_PtxRegister1010 = uint32_t(r_LaneIndexAtPtx1964) + uint32_t(r_PtxRegister1009);		   // PTX L1968
	r_PtxRegister1011 = r_PtxRegister1010 & 2147483644;										   // PTX L1969
	r_PtxRegister1012 = uint32_t(r_LaneIndexAtPtx1964) - uint32_t(r_PtxRegister1011);		   // PTX L1970
	r_PtxRegister1013 = ShiftLeft(uint32_t(r_PtxRegister1012), uint32_t(1));				   // PTX L1971
	r_PtxRegister1014 = uint32_t(r_PtxRegister583) + uint32_t(r_PtxRegister1013);			   // PTX L1972
	r_PtxRegister1015 = ShiftRight(uint32_t(r_PtxRegister1014), uint32_t(31));				   // PTX L1973
	r_PtxRegister1016 = uint32_t(r_PtxRegister1014) + uint32_t(r_PtxRegister1015);			   // PTX L1974
	r_PtxRegister1017 = ShiftRightSigned(int32_t(r_PtxRegister1016), uint32_t(1));			   // PTX L1975
	r_PtxU64Register225 = uint64_t(int64_t(int32_t(r_PtxRegister1017)) * int64_t(int32_t(4))); // PTX L1976
	g_RecordByteAddressAtPtx1977 =
		uint64_t(g_RecordByteAddressAtPtx1027) + uint64_t(r_PtxU64Register225); // PTX L1977
	r_PtxRegister450 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1977 + 4194304ull);	// PTX L1978
	r_LaneIndexAtPtx1980 = uint32_t((threadIdx.x & 31u));								// PTX L1980
	r_PackedHalf2AtPtx559R1775 = HalfMul(r_PackedHalf2AtPtx832R260, r_PtxRegister261);	// PTX L1983
	r_LaneIndexAtPtx1987 = uint32_t((threadIdx.x & 31u));								// PTX L1987
	r_PackedHalf2AtPtx558R1774 = HalfMul(r_PackedHalf2AtPtx838R263, r_PtxRegister264);	// PTX L1990
	r_LaneIndexAtPtx1994 = uint32_t((threadIdx.x & 31u));								// PTX L1994
	r_PackedHalf2AtPtx557R1773 = HalfMul(r_PackedHalf2AtPtx835R266, r_PtxRegister267);	// PTX L1997
	r_LaneIndexAtPtx2001 = uint32_t((threadIdx.x & 31u));								// PTX L2001
	r_PackedHalf2AtPtx556R1772 = HalfMul(r_PackedHalf2AtPtx841R269, r_PtxRegister270);	// PTX L2004
	r_LaneIndexAtPtx2008 = uint32_t((threadIdx.x & 31u));								// PTX L2008
	r_PackedHalf2AtPtx555R1771 = HalfMul(r_PackedHalf2AtPtx844R272, r_PtxRegister273);	// PTX L2011
	r_LaneIndexAtPtx2015 = uint32_t((threadIdx.x & 31u));								// PTX L2015
	r_PackedHalf2AtPtx554R1770 = HalfMul(r_PackedHalf2AtPtx850R275, r_PtxRegister276);	// PTX L2018
	r_LaneIndexAtPtx2022 = uint32_t((threadIdx.x & 31u));								// PTX L2022
	r_PackedHalf2AtPtx553R1769 = HalfMul(r_PackedHalf2AtPtx847R278, r_PtxRegister279);	// PTX L2025
	r_LaneIndexAtPtx2029 = uint32_t((threadIdx.x & 31u));								// PTX L2029
	r_PackedHalf2AtPtx552R1768 = HalfMul(r_PackedHalf2AtPtx853R281, r_PtxRegister282);	// PTX L2032
	r_LaneIndexAtPtx2036 = uint32_t((threadIdx.x & 31u));								// PTX L2036
	r_PackedHalf2AtPtx551R1767 = HalfMul(r_PackedHalf2AtPtx856R284, r_PtxRegister285);	// PTX L2039
	r_LaneIndexAtPtx2043 = uint32_t((threadIdx.x & 31u));								// PTX L2043
	r_PackedHalf2AtPtx550R1766 = HalfMul(r_PackedHalf2AtPtx862R287, r_PtxRegister288);	// PTX L2046
	r_LaneIndexAtPtx2050 = uint32_t((threadIdx.x & 31u));								// PTX L2050
	r_PackedHalf2AtPtx549R1765 = HalfMul(r_PackedHalf2AtPtx859R290, r_PtxRegister291);	// PTX L2053
	r_LaneIndexAtPtx2057 = uint32_t((threadIdx.x & 31u));								// PTX L2057
	r_PackedHalf2AtPtx548R1764 = HalfMul(r_PackedHalf2AtPtx865R293, r_PtxRegister294);	// PTX L2060
	r_LaneIndexAtPtx2064 = uint32_t((threadIdx.x & 31u));								// PTX L2064
	r_PackedHalf2AtPtx547R1763 = HalfMul(r_PackedHalf2AtPtx868R296, r_PtxRegister297);	// PTX L2067
	r_LaneIndexAtPtx2071 = uint32_t((threadIdx.x & 31u));								// PTX L2071
	r_PackedHalf2AtPtx546R1762 = HalfMul(r_PackedHalf2AtPtx874R299, r_PtxRegister300);	// PTX L2074
	r_LaneIndexAtPtx2078 = uint32_t((threadIdx.x & 31u));								// PTX L2078
	r_PackedHalf2AtPtx545R1761 = HalfMul(r_PackedHalf2AtPtx871R302, r_PtxRegister303);	// PTX L2081
	r_LaneIndexAtPtx2085 = uint32_t((threadIdx.x & 31u));								// PTX L2085
	r_PackedHalf2AtPtx544R1760 = HalfMul(r_PackedHalf2AtPtx877R305, r_PtxRegister306);	// PTX L2088
	r_LaneIndexAtPtx2092 = uint32_t((threadIdx.x & 31u));								// PTX L2092
	r_PackedHalf2AtPtx543R1759 = HalfMul(r_PackedHalf2AtPtx880R308, r_PtxRegister309);	// PTX L2095
	r_LaneIndexAtPtx2099 = uint32_t((threadIdx.x & 31u));								// PTX L2099
	r_PackedHalf2AtPtx542R1758 = HalfMul(r_PackedHalf2AtPtx886R311, r_PtxRegister312);	// PTX L2102
	r_LaneIndexAtPtx2106 = uint32_t((threadIdx.x & 31u));								// PTX L2106
	r_PackedHalf2AtPtx541R1757 = HalfMul(r_PackedHalf2AtPtx883R314, r_PtxRegister315);	// PTX L2109
	r_LaneIndexAtPtx2113 = uint32_t((threadIdx.x & 31u));								// PTX L2113
	r_PackedHalf2AtPtx540R1756 = HalfMul(r_PackedHalf2AtPtx889R317, r_PtxRegister318);	// PTX L2116
	r_LaneIndexAtPtx2120 = uint32_t((threadIdx.x & 31u));								// PTX L2120
	r_PackedHalf2AtPtx539R1755 = HalfMul(r_PackedHalf2AtPtx892R320, r_PtxRegister321);	// PTX L2123
	r_LaneIndexAtPtx2127 = uint32_t((threadIdx.x & 31u));								// PTX L2127
	r_PackedHalf2AtPtx538R1754 = HalfMul(r_PackedHalf2AtPtx898R323, r_PtxRegister324);	// PTX L2130
	r_LaneIndexAtPtx2134 = uint32_t((threadIdx.x & 31u));								// PTX L2134
	r_PackedHalf2AtPtx537R1753 = HalfMul(r_PackedHalf2AtPtx895R326, r_PtxRegister327);	// PTX L2137
	r_LaneIndexAtPtx2141 = uint32_t((threadIdx.x & 31u));								// PTX L2141
	r_PackedHalf2AtPtx536R1752 = HalfMul(r_PackedHalf2AtPtx901R329, r_PtxRegister330);	// PTX L2144
	r_LaneIndexAtPtx2148 = uint32_t((threadIdx.x & 31u));								// PTX L2148
	r_PackedHalf2AtPtx535R1751 = HalfMul(r_PackedHalf2AtPtx904R332, r_PtxRegister333);	// PTX L2151
	r_LaneIndexAtPtx2155 = uint32_t((threadIdx.x & 31u));								// PTX L2155
	r_PackedHalf2AtPtx534R1750 = HalfMul(r_PackedHalf2AtPtx910R335, r_PtxRegister336);	// PTX L2158
	r_LaneIndexAtPtx2162 = uint32_t((threadIdx.x & 31u));								// PTX L2162
	r_PackedHalf2AtPtx533R1749 = HalfMul(r_PackedHalf2AtPtx907R338, r_PtxRegister339);	// PTX L2165
	r_LaneIndexAtPtx2169 = uint32_t((threadIdx.x & 31u));								// PTX L2169
	r_PackedHalf2AtPtx532R1748 = HalfMul(r_PackedHalf2AtPtx913R341, r_PtxRegister342);	// PTX L2172
	r_LaneIndexAtPtx2176 = uint32_t((threadIdx.x & 31u));								// PTX L2176
	r_PackedHalf2AtPtx531R1747 = HalfMul(r_PackedHalf2AtPtx916R344, r_PtxRegister345);	// PTX L2179
	r_LaneIndexAtPtx2183 = uint32_t((threadIdx.x & 31u));								// PTX L2183
	r_PackedHalf2AtPtx530R1746 = HalfMul(r_PackedHalf2AtPtx922R347, r_PtxRegister348);	// PTX L2186
	r_LaneIndexAtPtx2190 = uint32_t((threadIdx.x & 31u));								// PTX L2190
	r_PackedHalf2AtPtx529R1745 = HalfMul(r_PackedHalf2AtPtx919R350, r_PtxRegister351);	// PTX L2193
	r_LaneIndexAtPtx2197 = uint32_t((threadIdx.x & 31u));								// PTX L2197
	r_PackedHalf2AtPtx528R1744 = HalfMul(r_PackedHalf2AtPtx925R353, r_PtxRegister354);	// PTX L2200
	r_LaneIndexAtPtx2204 = uint32_t((threadIdx.x & 31u));								// PTX L2204
	r_PackedHalf2AtPtx527R1743 = HalfMul(r_PackedHalf2AtPtx928R356, r_PtxRegister357);	// PTX L2207
	r_LaneIndexAtPtx2211 = uint32_t((threadIdx.x & 31u));								// PTX L2211
	r_PackedHalf2AtPtx526R1742 = HalfMul(r_PackedHalf2AtPtx934R359, r_PtxRegister360);	// PTX L2214
	r_LaneIndexAtPtx2218 = uint32_t((threadIdx.x & 31u));								// PTX L2218
	r_PackedHalf2AtPtx525R1741 = HalfMul(r_PackedHalf2AtPtx931R362, r_PtxRegister363);	// PTX L2221
	r_LaneIndexAtPtx2225 = uint32_t((threadIdx.x & 31u));								// PTX L2225
	r_PackedHalf2AtPtx524R1740 = HalfMul(r_PackedHalf2AtPtx937R365, r_PtxRegister366);	// PTX L2228
	r_LaneIndexAtPtx2232 = uint32_t((threadIdx.x & 31u));								// PTX L2232
	r_PackedHalf2AtPtx523R1739 = HalfMul(r_PackedHalf2AtPtx940R368, r_PtxRegister369);	// PTX L2235
	r_LaneIndexAtPtx2239 = uint32_t((threadIdx.x & 31u));								// PTX L2239
	r_PackedHalf2AtPtx522R1738 = HalfMul(r_PackedHalf2AtPtx946R371, r_PtxRegister372);	// PTX L2242
	r_LaneIndexAtPtx2246 = uint32_t((threadIdx.x & 31u));								// PTX L2246
	r_PackedHalf2AtPtx521R1737 = HalfMul(r_PackedHalf2AtPtx943R374, r_PtxRegister375);	// PTX L2249
	r_LaneIndexAtPtx2253 = uint32_t((threadIdx.x & 31u));								// PTX L2253
	r_PackedHalf2AtPtx520R1736 = HalfMul(r_PackedHalf2AtPtx949R377, r_PtxRegister378);	// PTX L2256
	r_LaneIndexAtPtx2260 = uint32_t((threadIdx.x & 31u));								// PTX L2260
	r_PackedHalf2AtPtx519R1735 = HalfMul(r_PackedHalf2AtPtx952R380, r_PtxRegister381);	// PTX L2263
	r_LaneIndexAtPtx2267 = uint32_t((threadIdx.x & 31u));								// PTX L2267
	r_PackedHalf2AtPtx518R1734 = HalfMul(r_PackedHalf2AtPtx958R383, r_PtxRegister384);	// PTX L2270
	r_LaneIndexAtPtx2274 = uint32_t((threadIdx.x & 31u));								// PTX L2274
	r_PackedHalf2AtPtx517R1733 = HalfMul(r_PackedHalf2AtPtx955R386, r_PtxRegister387);	// PTX L2277
	r_LaneIndexAtPtx2281 = uint32_t((threadIdx.x & 31u));								// PTX L2281
	r_PackedHalf2AtPtx516R1732 = HalfMul(r_PackedHalf2AtPtx961R389, r_PtxRegister390);	// PTX L2284
	r_LaneIndexAtPtx2288 = uint32_t((threadIdx.x & 31u));								// PTX L2288
	r_PackedHalf2AtPtx515R1731 = HalfMul(r_PackedHalf2AtPtx964R392, r_PtxRegister393);	// PTX L2291
	r_LaneIndexAtPtx2295 = uint32_t((threadIdx.x & 31u));								// PTX L2295
	r_PackedHalf2AtPtx514R1730 = HalfMul(r_PackedHalf2AtPtx970R395, r_PtxRegister396);	// PTX L2298
	r_LaneIndexAtPtx2302 = uint32_t((threadIdx.x & 31u));								// PTX L2302
	r_PackedHalf2AtPtx513R1729 = HalfMul(r_PackedHalf2AtPtx967R398, r_PtxRegister399);	// PTX L2305
	r_LaneIndexAtPtx2309 = uint32_t((threadIdx.x & 31u));								// PTX L2309
	r_PackedHalf2AtPtx512R1728 = HalfMul(r_PackedHalf2AtPtx973R401, r_PtxRegister402);	// PTX L2312
	r_LaneIndexAtPtx2316 = uint32_t((threadIdx.x & 31u));								// PTX L2316
	r_PackedHalf2AtPtx511R1727 = HalfMul(r_PackedHalf2AtPtx976R404, r_PtxRegister405);	// PTX L2319
	r_LaneIndexAtPtx2323 = uint32_t((threadIdx.x & 31u));								// PTX L2323
	r_PackedHalf2AtPtx510R1726 = HalfMul(r_PackedHalf2AtPtx982R407, r_PtxRegister408);	// PTX L2326
	r_LaneIndexAtPtx2330 = uint32_t((threadIdx.x & 31u));								// PTX L2330
	r_PackedHalf2AtPtx509R1725 = HalfMul(r_PackedHalf2AtPtx979R410, r_PtxRegister411);	// PTX L2333
	r_LaneIndexAtPtx2337 = uint32_t((threadIdx.x & 31u));								// PTX L2337
	r_PackedHalf2AtPtx508R1724 = HalfMul(r_PackedHalf2AtPtx985R413, r_PtxRegister414);	// PTX L2340
	r_LaneIndexAtPtx2344 = uint32_t((threadIdx.x & 31u));								// PTX L2344
	r_PackedHalf2AtPtx507R1723 = HalfMul(r_PackedHalf2AtPtx988R416, r_PtxRegister417);	// PTX L2347
	r_LaneIndexAtPtx2351 = uint32_t((threadIdx.x & 31u));								// PTX L2351
	r_PackedHalf2AtPtx506R1722 = HalfMul(r_PackedHalf2AtPtx994R419, r_PtxRegister420);	// PTX L2354
	r_LaneIndexAtPtx2358 = uint32_t((threadIdx.x & 31u));								// PTX L2358
	r_PackedHalf2AtPtx505R1721 = HalfMul(r_PackedHalf2AtPtx991R422, r_PtxRegister423);	// PTX L2361
	r_LaneIndexAtPtx2365 = uint32_t((threadIdx.x & 31u));								// PTX L2365
	r_PackedHalf2AtPtx504R1720 = HalfMul(r_PackedHalf2AtPtx997R425, r_PtxRegister426);	// PTX L2368
	r_LaneIndexAtPtx2372 = uint32_t((threadIdx.x & 31u));								// PTX L2372
	r_PackedHalf2AtPtx503R1719 = HalfMul(r_PackedHalf2AtPtx1001R428, r_PtxRegister429); // PTX L2375
	r_LaneIndexAtPtx2379 = uint32_t((threadIdx.x & 31u));								// PTX L2379
	r_PackedHalf2AtPtx502R1718 = HalfMul(r_PackedHalf2AtPtx1008R431, r_PtxRegister432); // PTX L2382
	r_LaneIndexAtPtx2386 = uint32_t((threadIdx.x & 31u));								// PTX L2386
	r_PackedHalf2AtPtx501R1717 = HalfMul(r_PackedHalf2AtPtx1004R434, r_PtxRegister435); // PTX L2389
	r_LaneIndexAtPtx2393 = uint32_t((threadIdx.x & 31u));								// PTX L2393
	r_PackedHalf2AtPtx500R1716 = HalfMul(r_PackedHalf2AtPtx1011R437, r_PtxRegister438); // PTX L2396
	r_LaneIndexAtPtx2400 = uint32_t((threadIdx.x & 31u));								// PTX L2400
	r_PackedHalf2AtPtx499R1715 = HalfMul(r_PackedHalf2AtPtx1015R440, r_PtxRegister441); // PTX L2403
	r_LaneIndexAtPtx2407 = uint32_t((threadIdx.x & 31u));								// PTX L2407
	r_PackedHalf2AtPtx498R1714 = HalfMul(r_PackedHalf2AtPtx1022R443, r_PtxRegister444); // PTX L2410
	r_LaneIndexAtPtx2414 = uint32_t((threadIdx.x & 31u));								// PTX L2414
	r_PackedHalf2AtPtx497R1713 = HalfMul(r_PackedHalf2AtPtx1018R446, r_PtxRegister447); // PTX L2417
	r_LaneIndexAtPtx2421 = uint32_t((threadIdx.x & 31u));								// PTX L2421
	r_PackedHalf2AtPtx496R1712 = HalfMul(r_PackedHalf2AtPtx1025R449, r_PtxRegister450); // PTX L2424
L__BB46_72:																				// PTX L2427
	r_PtxRegister1018 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));					// PTX L2428
	r_PtxRegister19 = r_PtxRegister1018 & 2044;											// PTX L2429
	r_PtxRegister1019 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(11));					// PTX L2430
	r_PtxRegister20 = r_PtxRegister1019 & 2093056;										// PTX L2431
	r_PtxRegister1020 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));					// PTX L2432
	r_PtxRegister21 = r_PtxRegister1020 & 523264;										// PTX L2433
	r_PtxRegister22 = r_PtxRegister6 | 128;												// PTX L2434
	r_PtxRegister1021 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(10));					// PTX L2435
	r_PtxRegister1022 = uint32_t(0u /* native shared input */);							// PTX L2436
	r_PtxRegister23 = uint32_t(r_PtxRegister1022) + uint32_t(r_PtxRegister1021);		// PTX L2437
	r_PtxRegister24 = uint32_t(r_PtxRegister23) + uint32_t(4096);						// PTX L2438
	r_PtxRegister25 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(10));						// PTX L2439
	r_PtxRegister1776 = uint32_t(0);													// PTX L2440
L__BB46_73:																				// PTX L2441
	r_bPtxPredicate40 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);				// PTX L2442
	r_bPtxPredicate41 = int32_t(r_PtxRegister7) < int32_t(r_PtxRegister3);				// PTX L2443
	r_PtxRegister1135 = ShiftRight(uint32_t(r_PtxRegister1776), uint32_t(6));			// PTX L2444
	r_PtxRegister1136 = ~uint32_t(r_PtxRegister1135);									// PTX L2445
	r_PtxRegister26 = uint32_t(r_PtxRegister1776) + uint32_t(64);						// PTX L2446
	r_PtxRegister27 = r_PtxRegister1136 & 1;											// PTX L2447
	r_PtxRegister1137 = ShiftLeft(uint32_t(r_PtxRegister1776), uint32_t(7));			// PTX L2448
	r_PtxRegister1138 = r_PtxRegister1137 & 8192;										// PTX L2449
	r_PtxRegister1139 = uint32_t(0u /* native shared input */);							// PTX L2450
	r_PtxRegister1140 = uint32_t(r_PtxRegister1139) + uint32_t(r_PtxRegister1138);		// PTX L2451
	r_LaneIndexAtPtx2453 = uint32_t((threadIdx.x & 31u));								// PTX L2453
	r_PtxRegister1141 = uint32_t(r_PtxRegister1140) + uint32_t(r_PtxRegister20);		// PTX L2455
	r_PtxRegister1142 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2453), uint32_t(4));			// PTX L2456
	r_PtxRegister1024 = uint32_t(r_PtxRegister1141) + uint32_t(r_PtxRegister1142);		// PTX L2457
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1024));
		r_MmaAE4x4WordAtPtx2459R1039 = r_Value.x;
		r_MmaAE4x4WordAtPtx2459R1040 = r_Value.y;
		r_MmaAE4x4WordAtPtx2459R1041 = r_Value.z;
		r_MmaAE4x4WordAtPtx2459R1042 = r_Value.w;
	} // PTX L2459
	r_LaneIndexAtPtx2462 = uint32_t((threadIdx.x & 31u));						   // PTX L2462
	r_PtxRegister1143 = ShiftLeft(uint32_t(r_PtxRegister21), uint32_t(2));		   // PTX L2464
	r_PtxRegister1144 = uint32_t(r_PtxRegister1140) + uint32_t(r_PtxRegister1143); // PTX L2465
	r_PtxRegister1145 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2462), uint32_t(4));	   // PTX L2466
	r_PtxRegister1146 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1145); // PTX L2467
	r_PtxRegister1026 = uint32_t(r_PtxRegister1146) + uint32_t(512);			   // PTX L2468
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1026));
		r_MmaAE4x4WordAtPtx2470R1043 = r_Value.x;
		r_MmaAE4x4WordAtPtx2470R1044 = r_Value.y;
		r_MmaAE4x4WordAtPtx2470R1045 = r_Value.z;
		r_MmaAE4x4WordAtPtx2470R1046 = r_Value.w;
	} // PTX L2470
	r_LaneIndexAtPtx2473 = uint32_t((threadIdx.x & 31u));						   // PTX L2473
	r_PtxRegister1147 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2473), uint32_t(4));	   // PTX L2475
	r_PtxRegister1148 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1147); // PTX L2476
	r_PtxRegister1028 = uint32_t(r_PtxRegister1148) + uint32_t(1024);			   // PTX L2477
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1028));
		r_MmaAE4x4WordAtPtx2479R1063 = r_Value.x;
		r_MmaAE4x4WordAtPtx2479R1064 = r_Value.y;
		r_MmaAE4x4WordAtPtx2479R1065 = r_Value.z;
		r_MmaAE4x4WordAtPtx2479R1066 = r_Value.w;
	} // PTX L2479
	r_LaneIndexAtPtx2482 = uint32_t((threadIdx.x & 31u));						   // PTX L2482
	r_PtxRegister1149 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2482), uint32_t(4));	   // PTX L2484
	r_PtxRegister1150 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1149); // PTX L2485
	r_PtxRegister1030 = uint32_t(r_PtxRegister1150) + uint32_t(1536);			   // PTX L2486
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1030));
		r_MmaAE4x4WordAtPtx2488R1067 = r_Value.x;
		r_MmaAE4x4WordAtPtx2488R1068 = r_Value.y;
		r_MmaAE4x4WordAtPtx2488R1069 = r_Value.z;
		r_MmaAE4x4WordAtPtx2488R1070 = r_Value.w;
	} // PTX L2488
	r_LaneIndexAtPtx2491 = uint32_t((threadIdx.x & 31u));						   // PTX L2491
	r_PtxRegister1151 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2491), uint32_t(4));	   // PTX L2493
	r_PtxRegister1152 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1151); // PTX L2494
	r_PtxRegister1032 = uint32_t(r_PtxRegister1152) + uint32_t(2048);			   // PTX L2495
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1032));
		r_MmaAE4x4WordAtPtx2497R1087 = r_Value.x;
		r_MmaAE4x4WordAtPtx2497R1088 = r_Value.y;
		r_MmaAE4x4WordAtPtx2497R1089 = r_Value.z;
		r_MmaAE4x4WordAtPtx2497R1090 = r_Value.w;
	} // PTX L2497
	r_LaneIndexAtPtx2500 = uint32_t((threadIdx.x & 31u));						   // PTX L2500
	r_PtxRegister1153 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2500), uint32_t(4));	   // PTX L2502
	r_PtxRegister1154 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1153); // PTX L2503
	r_PtxRegister1034 = uint32_t(r_PtxRegister1154) + uint32_t(2560);			   // PTX L2504
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1034));
		r_MmaAE4x4WordAtPtx2506R1091 = r_Value.x;
		r_MmaAE4x4WordAtPtx2506R1092 = r_Value.y;
		r_MmaAE4x4WordAtPtx2506R1093 = r_Value.z;
		r_MmaAE4x4WordAtPtx2506R1094 = r_Value.w;
	} // PTX L2506
	r_LaneIndexAtPtx2509 = uint32_t((threadIdx.x & 31u));						   // PTX L2509
	r_PtxRegister1155 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2509), uint32_t(4));	   // PTX L2511
	r_PtxRegister1156 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1155); // PTX L2512
	r_PtxRegister1036 = uint32_t(r_PtxRegister1156) + uint32_t(3072);			   // PTX L2513
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1036));
		r_MmaAE4x4WordAtPtx2515R1111 = r_Value.x;
		r_MmaAE4x4WordAtPtx2515R1112 = r_Value.y;
		r_MmaAE4x4WordAtPtx2515R1113 = r_Value.z;
		r_MmaAE4x4WordAtPtx2515R1114 = r_Value.w;
	} // PTX L2515
	r_LaneIndexAtPtx2518 = uint32_t((threadIdx.x & 31u));						   // PTX L2518
	r_PtxRegister1157 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2518), uint32_t(4));	   // PTX L2520
	r_PtxRegister1158 = uint32_t(r_PtxRegister1144) + uint32_t(r_PtxRegister1157); // PTX L2521
	r_PtxRegister1038 = uint32_t(r_PtxRegister1158) + uint32_t(3584);			   // PTX L2522
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1038));
		r_MmaAE4x4WordAtPtx2524R1115 = r_Value.x;
		r_MmaAE4x4WordAtPtx2524R1116 = r_Value.y;
		r_MmaAE4x4WordAtPtx2524R1117 = r_Value.z;
		r_MmaAE4x4WordAtPtx2524R1118 = r_Value.w;
	} // PTX L2524
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2527R1047, r_MmaAccumulatorHalf2WordAtPtx2527R1048,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx559R1775,
		  r_PackedHalf2AtPtx558R1774); // PTX L2527
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2534R1049, r_MmaAccumulatorHalf2WordAtPtx2534R1050,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx557R1773,
		  r_PackedHalf2AtPtx556R1772); // PTX L2534
	MmaE4(r_PackedHalf2AtPtx559R1775, r_PackedHalf2AtPtx558R1774, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794, r_MmaAccumulatorHalf2WordAtPtx2527R1047,
		  r_MmaAccumulatorHalf2WordAtPtx2527R1048); // PTX L2541
	MmaE4(r_PackedHalf2AtPtx557R1773, r_PackedHalf2AtPtx556R1772, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796, r_MmaAccumulatorHalf2WordAtPtx2534R1049,
		  r_MmaAccumulatorHalf2WordAtPtx2534R1050); // PTX L2548
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2555R1051, r_MmaAccumulatorHalf2WordAtPtx2555R1052,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx555R1771,
		  r_PackedHalf2AtPtx554R1770); // PTX L2555
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2562R1053, r_MmaAccumulatorHalf2WordAtPtx2562R1054,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx553R1769,
		  r_PackedHalf2AtPtx552R1768); // PTX L2562
	MmaE4(r_PackedHalf2AtPtx555R1771, r_PackedHalf2AtPtx554R1770, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798, r_MmaAccumulatorHalf2WordAtPtx2555R1051,
		  r_MmaAccumulatorHalf2WordAtPtx2555R1052); // PTX L2569
	MmaE4(r_PackedHalf2AtPtx553R1769, r_PackedHalf2AtPtx552R1768, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800, r_MmaAccumulatorHalf2WordAtPtx2562R1053,
		  r_MmaAccumulatorHalf2WordAtPtx2562R1054); // PTX L2576
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2583R1055, r_MmaAccumulatorHalf2WordAtPtx2583R1056,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx551R1767,
		  r_PackedHalf2AtPtx550R1766); // PTX L2583
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2590R1057, r_MmaAccumulatorHalf2WordAtPtx2590R1058,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx549R1765,
		  r_PackedHalf2AtPtx548R1764); // PTX L2590
	MmaE4(r_PackedHalf2AtPtx551R1767, r_PackedHalf2AtPtx550R1766, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802, r_MmaAccumulatorHalf2WordAtPtx2583R1055,
		  r_MmaAccumulatorHalf2WordAtPtx2583R1056); // PTX L2597
	MmaE4(r_PackedHalf2AtPtx549R1765, r_PackedHalf2AtPtx548R1764, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804, r_MmaAccumulatorHalf2WordAtPtx2590R1057,
		  r_MmaAccumulatorHalf2WordAtPtx2590R1058); // PTX L2604
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2611R1059, r_MmaAccumulatorHalf2WordAtPtx2611R1060,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx547R1763,
		  r_PackedHalf2AtPtx546R1762); // PTX L2611
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2618R1061, r_MmaAccumulatorHalf2WordAtPtx2618R1062,
		  r_MmaAE4x4WordAtPtx2459R1039, r_MmaAE4x4WordAtPtx2459R1040, r_MmaAE4x4WordAtPtx2459R1041,
		  r_MmaAE4x4WordAtPtx2459R1042, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx545R1761,
		  r_PackedHalf2AtPtx544R1760); // PTX L2618
	MmaE4(r_PackedHalf2AtPtx547R1763, r_PackedHalf2AtPtx546R1762, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806, r_MmaAccumulatorHalf2WordAtPtx2611R1059,
		  r_MmaAccumulatorHalf2WordAtPtx2611R1060); // PTX L2625
	MmaE4(r_PackedHalf2AtPtx545R1761, r_PackedHalf2AtPtx544R1760, r_MmaAE4x4WordAtPtx2470R1043,
		  r_MmaAE4x4WordAtPtx2470R1044, r_MmaAE4x4WordAtPtx2470R1045, r_MmaAE4x4WordAtPtx2470R1046,
		  r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808, r_MmaAccumulatorHalf2WordAtPtx2618R1061,
		  r_MmaAccumulatorHalf2WordAtPtx2618R1062); // PTX L2632
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2639R1071, r_MmaAccumulatorHalf2WordAtPtx2639R1072,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx543R1759,
		  r_PackedHalf2AtPtx542R1758); // PTX L2639
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2646R1073, r_MmaAccumulatorHalf2WordAtPtx2646R1074,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx541R1757,
		  r_PackedHalf2AtPtx540R1756); // PTX L2646
	MmaE4(r_PackedHalf2AtPtx543R1759, r_PackedHalf2AtPtx542R1758, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794, r_MmaAccumulatorHalf2WordAtPtx2639R1071,
		  r_MmaAccumulatorHalf2WordAtPtx2639R1072); // PTX L2653
	MmaE4(r_PackedHalf2AtPtx541R1757, r_PackedHalf2AtPtx540R1756, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796, r_MmaAccumulatorHalf2WordAtPtx2646R1073,
		  r_MmaAccumulatorHalf2WordAtPtx2646R1074); // PTX L2660
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2667R1075, r_MmaAccumulatorHalf2WordAtPtx2667R1076,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx539R1755,
		  r_PackedHalf2AtPtx538R1754); // PTX L2667
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2674R1077, r_MmaAccumulatorHalf2WordAtPtx2674R1078,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx537R1753,
		  r_PackedHalf2AtPtx536R1752); // PTX L2674
	MmaE4(r_PackedHalf2AtPtx539R1755, r_PackedHalf2AtPtx538R1754, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798, r_MmaAccumulatorHalf2WordAtPtx2667R1075,
		  r_MmaAccumulatorHalf2WordAtPtx2667R1076); // PTX L2681
	MmaE4(r_PackedHalf2AtPtx537R1753, r_PackedHalf2AtPtx536R1752, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800, r_MmaAccumulatorHalf2WordAtPtx2674R1077,
		  r_MmaAccumulatorHalf2WordAtPtx2674R1078); // PTX L2688
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2695R1079, r_MmaAccumulatorHalf2WordAtPtx2695R1080,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx535R1751,
		  r_PackedHalf2AtPtx534R1750); // PTX L2695
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2702R1081, r_MmaAccumulatorHalf2WordAtPtx2702R1082,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx533R1749,
		  r_PackedHalf2AtPtx532R1748); // PTX L2702
	MmaE4(r_PackedHalf2AtPtx535R1751, r_PackedHalf2AtPtx534R1750, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802, r_MmaAccumulatorHalf2WordAtPtx2695R1079,
		  r_MmaAccumulatorHalf2WordAtPtx2695R1080); // PTX L2709
	MmaE4(r_PackedHalf2AtPtx533R1749, r_PackedHalf2AtPtx532R1748, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804, r_MmaAccumulatorHalf2WordAtPtx2702R1081,
		  r_MmaAccumulatorHalf2WordAtPtx2702R1082); // PTX L2716
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2723R1083, r_MmaAccumulatorHalf2WordAtPtx2723R1084,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx531R1747,
		  r_PackedHalf2AtPtx530R1746); // PTX L2723
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2730R1085, r_MmaAccumulatorHalf2WordAtPtx2730R1086,
		  r_MmaAE4x4WordAtPtx2479R1063, r_MmaAE4x4WordAtPtx2479R1064, r_MmaAE4x4WordAtPtx2479R1065,
		  r_MmaAE4x4WordAtPtx2479R1066, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx529R1745,
		  r_PackedHalf2AtPtx528R1744); // PTX L2730
	MmaE4(r_PackedHalf2AtPtx531R1747, r_PackedHalf2AtPtx530R1746, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806, r_MmaAccumulatorHalf2WordAtPtx2723R1083,
		  r_MmaAccumulatorHalf2WordAtPtx2723R1084); // PTX L2737
	MmaE4(r_PackedHalf2AtPtx529R1745, r_PackedHalf2AtPtx528R1744, r_MmaAE4x4WordAtPtx2488R1067,
		  r_MmaAE4x4WordAtPtx2488R1068, r_MmaAE4x4WordAtPtx2488R1069, r_MmaAE4x4WordAtPtx2488R1070,
		  r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808, r_MmaAccumulatorHalf2WordAtPtx2730R1085,
		  r_MmaAccumulatorHalf2WordAtPtx2730R1086); // PTX L2744
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2751R1095, r_MmaAccumulatorHalf2WordAtPtx2751R1096,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx527R1743,
		  r_PackedHalf2AtPtx526R1742); // PTX L2751
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2758R1097, r_MmaAccumulatorHalf2WordAtPtx2758R1098,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx525R1741,
		  r_PackedHalf2AtPtx524R1740); // PTX L2758
	MmaE4(r_PackedHalf2AtPtx527R1743, r_PackedHalf2AtPtx526R1742, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794, r_MmaAccumulatorHalf2WordAtPtx2751R1095,
		  r_MmaAccumulatorHalf2WordAtPtx2751R1096); // PTX L2765
	MmaE4(r_PackedHalf2AtPtx525R1741, r_PackedHalf2AtPtx524R1740, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796, r_MmaAccumulatorHalf2WordAtPtx2758R1097,
		  r_MmaAccumulatorHalf2WordAtPtx2758R1098); // PTX L2772
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2779R1099, r_MmaAccumulatorHalf2WordAtPtx2779R1100,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx523R1739,
		  r_PackedHalf2AtPtx522R1738); // PTX L2779
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2786R1101, r_MmaAccumulatorHalf2WordAtPtx2786R1102,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx521R1737,
		  r_PackedHalf2AtPtx520R1736); // PTX L2786
	MmaE4(r_PackedHalf2AtPtx523R1739, r_PackedHalf2AtPtx522R1738, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798, r_MmaAccumulatorHalf2WordAtPtx2779R1099,
		  r_MmaAccumulatorHalf2WordAtPtx2779R1100); // PTX L2793
	MmaE4(r_PackedHalf2AtPtx521R1737, r_PackedHalf2AtPtx520R1736, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800, r_MmaAccumulatorHalf2WordAtPtx2786R1101,
		  r_MmaAccumulatorHalf2WordAtPtx2786R1102); // PTX L2800
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2807R1103, r_MmaAccumulatorHalf2WordAtPtx2807R1104,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx519R1735,
		  r_PackedHalf2AtPtx518R1734); // PTX L2807
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2814R1105, r_MmaAccumulatorHalf2WordAtPtx2814R1106,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx517R1733,
		  r_PackedHalf2AtPtx516R1732); // PTX L2814
	MmaE4(r_PackedHalf2AtPtx519R1735, r_PackedHalf2AtPtx518R1734, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802, r_MmaAccumulatorHalf2WordAtPtx2807R1103,
		  r_MmaAccumulatorHalf2WordAtPtx2807R1104); // PTX L2821
	MmaE4(r_PackedHalf2AtPtx517R1733, r_PackedHalf2AtPtx516R1732, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804, r_MmaAccumulatorHalf2WordAtPtx2814R1105,
		  r_MmaAccumulatorHalf2WordAtPtx2814R1106); // PTX L2828
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2835R1107, r_MmaAccumulatorHalf2WordAtPtx2835R1108,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx515R1731,
		  r_PackedHalf2AtPtx514R1730); // PTX L2835
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2842R1109, r_MmaAccumulatorHalf2WordAtPtx2842R1110,
		  r_MmaAE4x4WordAtPtx2497R1087, r_MmaAE4x4WordAtPtx2497R1088, r_MmaAE4x4WordAtPtx2497R1089,
		  r_MmaAE4x4WordAtPtx2497R1090, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx513R1729,
		  r_PackedHalf2AtPtx512R1728); // PTX L2842
	MmaE4(r_PackedHalf2AtPtx515R1731, r_PackedHalf2AtPtx514R1730, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806, r_MmaAccumulatorHalf2WordAtPtx2835R1107,
		  r_MmaAccumulatorHalf2WordAtPtx2835R1108); // PTX L2849
	MmaE4(r_PackedHalf2AtPtx513R1729, r_PackedHalf2AtPtx512R1728, r_MmaAE4x4WordAtPtx2506R1091,
		  r_MmaAE4x4WordAtPtx2506R1092, r_MmaAE4x4WordAtPtx2506R1093, r_MmaAE4x4WordAtPtx2506R1094,
		  r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808, r_MmaAccumulatorHalf2WordAtPtx2842R1109,
		  r_MmaAccumulatorHalf2WordAtPtx2842R1110); // PTX L2856
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2863R1119, r_MmaAccumulatorHalf2WordAtPtx2863R1120,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx511R1727,
		  r_PackedHalf2AtPtx510R1726); // PTX L2863
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2870R1121, r_MmaAccumulatorHalf2WordAtPtx2870R1122,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx509R1725,
		  r_PackedHalf2AtPtx508R1724); // PTX L2870
	MmaE4(r_PackedHalf2AtPtx511R1727, r_PackedHalf2AtPtx510R1726, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794, r_MmaAccumulatorHalf2WordAtPtx2863R1119,
		  r_MmaAccumulatorHalf2WordAtPtx2863R1120); // PTX L2877
	MmaE4(r_PackedHalf2AtPtx509R1725, r_PackedHalf2AtPtx508R1724, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796, r_MmaAccumulatorHalf2WordAtPtx2870R1121,
		  r_MmaAccumulatorHalf2WordAtPtx2870R1122); // PTX L2884
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2891R1123, r_MmaAccumulatorHalf2WordAtPtx2891R1124,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx507R1723,
		  r_PackedHalf2AtPtx506R1722); // PTX L2891
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2898R1125, r_MmaAccumulatorHalf2WordAtPtx2898R1126,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx505R1721,
		  r_PackedHalf2AtPtx504R1720); // PTX L2898
	MmaE4(r_PackedHalf2AtPtx507R1723, r_PackedHalf2AtPtx506R1722, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798, r_MmaAccumulatorHalf2WordAtPtx2891R1123,
		  r_MmaAccumulatorHalf2WordAtPtx2891R1124); // PTX L2905
	MmaE4(r_PackedHalf2AtPtx505R1721, r_PackedHalf2AtPtx504R1720, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800, r_MmaAccumulatorHalf2WordAtPtx2898R1125,
		  r_MmaAccumulatorHalf2WordAtPtx2898R1126); // PTX L2912
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2919R1127, r_MmaAccumulatorHalf2WordAtPtx2919R1128,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx503R1719,
		  r_PackedHalf2AtPtx502R1718); // PTX L2919
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2926R1129, r_MmaAccumulatorHalf2WordAtPtx2926R1130,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx501R1717,
		  r_PackedHalf2AtPtx500R1716); // PTX L2926
	MmaE4(r_PackedHalf2AtPtx503R1719, r_PackedHalf2AtPtx502R1718, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802, r_MmaAccumulatorHalf2WordAtPtx2919R1127,
		  r_MmaAccumulatorHalf2WordAtPtx2919R1128); // PTX L2933
	MmaE4(r_PackedHalf2AtPtx501R1717, r_PackedHalf2AtPtx500R1716, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804, r_MmaAccumulatorHalf2WordAtPtx2926R1129,
		  r_MmaAccumulatorHalf2WordAtPtx2926R1130); // PTX L2940
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2947R1131, r_MmaAccumulatorHalf2WordAtPtx2947R1132,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx499R1715,
		  r_PackedHalf2AtPtx498R1714); // PTX L2947
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2954R1133, r_MmaAccumulatorHalf2WordAtPtx2954R1134,
		  r_MmaAE4x4WordAtPtx2515R1111, r_MmaAE4x4WordAtPtx2515R1112, r_MmaAE4x4WordAtPtx2515R1113,
		  r_MmaAE4x4WordAtPtx2515R1114, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx497R1713,
		  r_PackedHalf2AtPtx496R1712); // PTX L2954
	MmaE4(r_PackedHalf2AtPtx499R1715, r_PackedHalf2AtPtx498R1714, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806, r_MmaAccumulatorHalf2WordAtPtx2947R1131,
		  r_MmaAccumulatorHalf2WordAtPtx2947R1132); // PTX L2961
	MmaE4(r_PackedHalf2AtPtx497R1713, r_PackedHalf2AtPtx496R1712, r_MmaAE4x4WordAtPtx2524R1115,
		  r_MmaAE4x4WordAtPtx2524R1116, r_MmaAE4x4WordAtPtx2524R1117, r_MmaAE4x4WordAtPtx2524R1118,
		  r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808, r_MmaAccumulatorHalf2WordAtPtx2954R1133,
		  r_MmaAccumulatorHalf2WordAtPtx2954R1134);										 // PTX L2968
	r_PtxRegister28 = r_PtxRegister1138 ^ 8192;											 // PTX L2974
	r_PtxU64Register227 = uint64_t(r_PtxRegister28);									 // PTX L2975
	r_PtxU64Register228 = uint64_t(r_PtxRegister1139);									 // PTX L2976
	r_PtxU64Register229 = SharedGeneric(s_SharedStorage, r_PtxU64Register228);			 // PTX L2977
	r_PtxU64Register230 = uint64_t(r_PtxU64Register229) + uint64_t(r_PtxU64Register227); // PTX L2978
	r_PtxRegister29 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister25);			 // PTX L2979
	r_PtxRegister1159 = ShiftLeft(uint32_t(r_PtxRegister29), uint32_t(2));				 // PTX L2980
	r_PtxRegister30 = uint32_t(r_PtxRegister86) + uint32_t(r_PtxRegister1159);			 // PTX L2981
	r_PtxRegister31 = r_bPtxPredicate41 ? r_PtxRegister30 : 0;							 // PTX L2982
	r_PtxU64Register5 = uint64_t(r_PtxU64Register230) + uint64_t(r_PtxU64Register56);	 // PTX L2983
	r_PtxU16Register166 = uint16_t(0);													 // PTX L2984
	r_PtxU64Register465 = uint64_t(0);													 // PTX L2985
	r_PtxRegister1809 = uint32_t(128);													 // PTX L2986
	r_PtxRegister1810 = uint32_t(r_PtxRegister1809);									 // PTX L2987
	r_PtxU64Register466 = uint64_t(r_PtxU64Register465);								 // PTX L2988
	if (r_bPtxPredicate40)
	{
		goto L__BB46_75;
	} // PTX L2989
	r_PtxU64Register231 = uint64_t(int64_t(int32_t(r_PtxRegister31)) * int64_t(int32_t(4))); // PTX L2990
	r_PtxU64Register465 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register231);		 // PTX L2991
	r_PtxRegister1809 = uint32_t(r_PtxRegister31) + uint32_t(128);							 // PTX L2992
	r_PtxU16Register166 = uint16_t(1);														 // PTX L2993
	r_PtxRegister1810 = uint32_t(r_PtxRegister22);											 // PTX L2994
	r_PtxU64Register466 = uint64_t(r_PtxU64Register5);										 // PTX L2995
L__BB46_75:																					 // PTX L2996
	r_bPtxPredicate42 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);					 // PTX L2997
	if (r_bPtxPredicate42)
	{
		goto L__BB46_77;
	} // PTX L2998
	r_PtxRegister1160 = uint32_t(r_PtxRegister30) + uint32_t(128);					// PTX L2999
	r_bPtxPredicate43 = uint32_t(r_PtxRegister22) == uint32_t(r_PtxRegister1810);	// PTX L3000
	r_bPtxPredicate44 = uint32_t(r_PtxRegister1160) == uint32_t(r_PtxRegister1809); // PTX L3001
	r_PtxU16Register91 = r_bPtxPredicate44 ? r_PtxU16Register166 : 0;				// PTX L3002
	r_PtxU16Register166 = r_bPtxPredicate43 ? r_PtxU16Register91 : 0;				// PTX L3003
L__BB46_77:																			// PTX L3004
	r_bPtxPredicate45 = uint16_t(r_PtxU16Register166) == uint16_t(0);				// PTX L3005
	r_PtxRegister1161 = ShiftLeft(uint32_t(r_PtxRegister27), uint32_t(3));			// PTX L3006
	r_PtxRegister1162 = uint32_t(16384u /* native mbarriers */);					// PTX L3007
	r_PtxRegister1214 = uint32_t(r_PtxRegister1162) + uint32_t(r_PtxRegister1161);	// PTX L3008
	if (r_bPtxPredicate45)
	{
		goto L__BB46_80;
	} // PTX L3009
	r_PtxRegister1164 = uint32_t(-1);								// PTX L3010
	r_PtxRegister1163 = Elected(r_PtxRegister1164);					// PTX L3012
	r_bPtxPredicate46 = uint32_t(r_PtxRegister1163) == uint32_t(0); // PTX L3018
	if (r_bPtxPredicate46)
	{
		goto L__BB46_92;
	} // PTX L3019
	r_PtxU64Register233 = SharedOffset(s_SharedStorage, r_PtxU64Register466); // PTX L3020
	r_PtxRegister1165 = uint32_t(r_PtxU64Register233);						  // PTX L3021
	r_PtxU64Register232 = r_PtxU64Register465;								  // PTX L3022
	r_PtxRegister1166 = uint32_t(1024);										  // PTX L3023
	CopyBulk(s_SharedStorage, r_PtxRegister1165, r_PtxU64Register232, r_PtxRegister1166,
			 r_PtxRegister1214);											// PTX L3025
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1166);	// PTX L3028
	goto L__BB46_92;														// PTX L3030
L__BB46_80:																	// PTX L3031
	r_bPtxPredicate47 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3); // PTX L3032
	r_PtxU64Register467 = uint64_t(0);										// PTX L3033
	if (r_bPtxPredicate47)
	{
		goto L__BB46_82;
	} // PTX L3034
	r_PtxU64Register234 = uint64_t(int64_t(int32_t(r_PtxRegister31)) * int64_t(int32_t(4))); // PTX L3035
	r_PtxU64Register467 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register234);		 // PTX L3036
L__BB46_82:																					 // PTX L3037
	r_bPtxPredicate48 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);					 // PTX L3038
	r_PtxRegister32 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister28);				 // PTX L3039
	if (r_bPtxPredicate48)
	{
		goto L__BB46_85;
	} // PTX L3040
	r_PtxRegister1174 = uint32_t(-1);								// PTX L3041
	r_PtxRegister1173 = Elected(r_PtxRegister1174);					// PTX L3043
	r_bPtxPredicate49 = uint32_t(r_PtxRegister1173) == uint32_t(0); // PTX L3049
	if (r_bPtxPredicate49)
	{
		goto L__BB46_86;
	} // PTX L3050
	r_PtxU64Register235 = r_PtxU64Register467; // PTX L3051
	r_PtxRegister1175 = uint32_t(512);		   // PTX L3052
	CopyBulk(s_SharedStorage, r_PtxRegister32, r_PtxU64Register235, r_PtxRegister1175,
			 r_PtxRegister1214);																// PTX L3054
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1175);						// PTX L3057
	goto L__BB46_86;																			// PTX L3059
L__BB46_85:																						// PTX L3060
	r_PtxRegister1167 = uint32_t(0);															// PTX L3061
	r_PtxU16Register92 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1167))); // PTX L3063
	r_PackedHalf2AtPtx3066R1168 = JoinHalfwords(r_PtxU16Register92, r_PtxU16Register92);		// PTX L3066
	r_ConvertedE4PairAtPtx3068Rs93 = PublishE4(r_PackedHalf2AtPtx3066R1168);					// PTX L3068
	r_PackedE4WordAtPtx3070R1171 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3068Rs93, r_ConvertedE4PairAtPtx3068Rs93); // PTX L3070
	r_LaneIndexAtPtx3072 = uint32_t((threadIdx.x & 31u));							   // PTX L3072
	r_PtxRegister1172 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3072), uint32_t(4));		   // PTX L3074
	r_PtxRegister1170 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister1172);	   // PTX L3075
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1170)) =
		make_uint4(r_PackedE4WordAtPtx3070R1171, r_PackedE4WordAtPtx3070R1171, r_PackedE4WordAtPtx3070R1171,
				   r_PackedE4WordAtPtx3070R1171);							// PTX L3077
L__BB46_86:																	// PTX L3079
	r_bPtxPredicate50 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3); // PTX L3080
	r_bPtxPredicate51 = int32_t(r_PtxRegister7) < int32_t(r_PtxRegister3);	// PTX L3081
	r_PtxRegister1176 = uint32_t(r_PtxRegister30) + uint32_t(128);			// PTX L3082
	r_PtxRegister33 = r_bPtxPredicate51 ? r_PtxRegister1176 : 0;			// PTX L3083
	r_PtxU64Register468 = uint64_t(0);										// PTX L3084
	if (r_bPtxPredicate50)
	{
		goto L__BB46_88;
	} // PTX L3085
	r_PtxU64Register236 = uint64_t(int64_t(int32_t(r_PtxRegister33)) * int64_t(int32_t(4))); // PTX L3086
	r_PtxU64Register468 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register236);		 // PTX L3087
L__BB46_88:																					 // PTX L3088
	r_bPtxPredicate52 = int32_t(r_PtxRegister7) >= int32_t(r_PtxRegister3);					 // PTX L3089
	if (r_bPtxPredicate52)
	{
		goto L__BB46_91;
	} // PTX L3090
	r_PtxRegister1185 = uint32_t(-1);								// PTX L3091
	r_PtxRegister1184 = Elected(r_PtxRegister1185);					// PTX L3093
	r_bPtxPredicate53 = uint32_t(r_PtxRegister1184) == uint32_t(0); // PTX L3099
	if (r_bPtxPredicate53)
	{
		goto L__BB46_92;
	} // PTX L3100
	r_PtxRegister1186 = uint32_t(r_PtxRegister32) + uint32_t(512); // PTX L3101
	r_PtxU64Register237 = r_PtxU64Register468;					   // PTX L3102
	r_PtxRegister1187 = uint32_t(512);							   // PTX L3103
	CopyBulk(s_SharedStorage, r_PtxRegister1186, r_PtxU64Register237, r_PtxRegister1187,
			 r_PtxRegister1214);																// PTX L3105
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1187);						// PTX L3108
	goto L__BB46_92;																			// PTX L3110
L__BB46_91:																						// PTX L3111
	r_PtxRegister1177 = uint32_t(0);															// PTX L3112
	r_PtxU16Register94 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1177))); // PTX L3114
	r_PackedHalf2AtPtx3117R1178 = JoinHalfwords(r_PtxU16Register94, r_PtxU16Register94);		// PTX L3117
	r_ConvertedE4PairAtPtx3119Rs95 = PublishE4(r_PackedHalf2AtPtx3117R1178);					// PTX L3119
	r_PackedE4WordAtPtx3121R1181 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3119Rs95, r_ConvertedE4PairAtPtx3119Rs95); // PTX L3121
	r_LaneIndexAtPtx3123 = uint32_t((threadIdx.x & 31u));							   // PTX L3123
	r_PtxRegister1182 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3123), uint32_t(4));		   // PTX L3125
	r_PtxRegister1183 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister1182);	   // PTX L3126
	r_PtxRegister1180 = uint32_t(r_PtxRegister1183) + uint32_t(512);				   // PTX L3127
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1180)) =
		make_uint4(r_PackedE4WordAtPtx3121R1181, r_PackedE4WordAtPtx3121R1181, r_PackedE4WordAtPtx3121R1181,
				   r_PackedE4WordAtPtx3121R1181);							 // PTX L3129
L__BB46_92:																	 // PTX L3131
	r_bPtxPredicate54 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L3132
	r_bPtxPredicate55 = int32_t(r_PtxRegister12) < int32_t(r_PtxRegister3);	 // PTX L3133
	r_PtxRegister34 = uint32_t(r_PtxRegister30) + uint32_t(65536);			 // PTX L3134
	r_PtxRegister35 = r_bPtxPredicate55 ? r_PtxRegister34 : 0;				 // PTX L3135
	r_PtxU16Register167 = uint16_t(0);										 // PTX L3136
	r_PtxU64Register469 = uint64_t(0);										 // PTX L3137
	r_PtxRegister1811 = uint32_t(128);										 // PTX L3138
	r_PtxU64Register470 = uint64_t(r_PtxU64Register469);					 // PTX L3139
	if (r_bPtxPredicate54)
	{
		goto L__BB46_94;
	} // PTX L3140
	r_PtxU64Register470 = uint64_t(r_PtxU64Register5) + uint64_t(4096);						 // PTX L3141
	r_PtxU64Register238 = uint64_t(int64_t(int32_t(r_PtxRegister35)) * int64_t(int32_t(4))); // PTX L3142
	r_PtxU64Register469 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register238);		 // PTX L3143
	r_PtxRegister1811 = uint32_t(r_PtxRegister35) + uint32_t(128);							 // PTX L3144
	r_PtxU16Register167 = uint16_t(1);														 // PTX L3145
L__BB46_94:																					 // PTX L3146
	r_bPtxPredicate56 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);				 // PTX L3147
	if (r_bPtxPredicate56)
	{
		goto L__BB46_96;
	} // PTX L3148
	r_PtxRegister1188 = uint32_t(r_PtxRegister34) + uint32_t(128);					// PTX L3149
	r_bPtxPredicate57 = uint32_t(r_PtxRegister1188) == uint32_t(r_PtxRegister1811); // PTX L3150
	r_PtxU16Register167 = r_bPtxPredicate57 ? r_PtxU16Register167 : 0;				// PTX L3151
L__BB46_96:																			// PTX L3152
	r_bPtxPredicate58 = uint16_t(r_PtxU16Register167) == uint16_t(0);				// PTX L3153
	if (r_bPtxPredicate58)
	{
		goto L__BB46_99;
	} // PTX L3154
	r_PtxRegister1190 = uint32_t(-1);								// PTX L3155
	r_PtxRegister1189 = Elected(r_PtxRegister1190);					// PTX L3157
	r_bPtxPredicate59 = uint32_t(r_PtxRegister1189) == uint32_t(0); // PTX L3163
	if (r_bPtxPredicate59)
	{
		goto L__BB46_111;
	} // PTX L3164
	r_PtxU64Register240 = SharedOffset(s_SharedStorage, r_PtxU64Register470); // PTX L3165
	r_PtxRegister1191 = uint32_t(r_PtxU64Register240);						  // PTX L3166
	r_PtxU64Register239 = r_PtxU64Register469;								  // PTX L3167
	r_PtxRegister1192 = uint32_t(1024);										  // PTX L3168
	CopyBulk(s_SharedStorage, r_PtxRegister1191, r_PtxU64Register239, r_PtxRegister1192,
			 r_PtxRegister1214);											 // PTX L3170
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1192);	 // PTX L3173
	goto L__BB46_111;														 // PTX L3175
L__BB46_99:																	 // PTX L3176
	r_bPtxPredicate60 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L3177
	r_PtxU64Register471 = uint64_t(0);										 // PTX L3178
	if (r_bPtxPredicate60)
	{
		goto L__BB46_101;
	} // PTX L3179
	r_PtxU64Register241 = uint64_t(int64_t(int32_t(r_PtxRegister35)) * int64_t(int32_t(4))); // PTX L3180
	r_PtxU64Register471 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register241);		 // PTX L3181
L__BB46_101:																				 // PTX L3182
	r_bPtxPredicate61 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);				 // PTX L3183
	r_PtxRegister36 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister28);				 // PTX L3184
	if (r_bPtxPredicate61)
	{
		goto L__BB46_104;
	} // PTX L3185
	r_PtxRegister1200 = uint32_t(-1);								// PTX L3186
	r_PtxRegister1199 = Elected(r_PtxRegister1200);					// PTX L3188
	r_bPtxPredicate62 = uint32_t(r_PtxRegister1199) == uint32_t(0); // PTX L3194
	if (r_bPtxPredicate62)
	{
		goto L__BB46_105;
	} // PTX L3195
	r_PtxU64Register242 = r_PtxU64Register471; // PTX L3196
	r_PtxRegister1201 = uint32_t(512);		   // PTX L3197
	CopyBulk(s_SharedStorage, r_PtxRegister36, r_PtxU64Register242, r_PtxRegister1201,
			 r_PtxRegister1214);																// PTX L3199
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1201);						// PTX L3202
	goto L__BB46_105;																			// PTX L3204
L__BB46_104:																					// PTX L3205
	r_PtxRegister1193 = uint32_t(0);															// PTX L3206
	r_PtxU16Register96 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1193))); // PTX L3208
	r_PackedHalf2AtPtx3211R1194 = JoinHalfwords(r_PtxU16Register96, r_PtxU16Register96);		// PTX L3211
	r_ConvertedE4PairAtPtx3213Rs97 = PublishE4(r_PackedHalf2AtPtx3211R1194);					// PTX L3213
	r_PackedE4WordAtPtx3215R1197 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3213Rs97, r_ConvertedE4PairAtPtx3213Rs97); // PTX L3215
	r_LaneIndexAtPtx3217 = uint32_t((threadIdx.x & 31u));							   // PTX L3217
	r_PtxRegister1198 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3217), uint32_t(4));		   // PTX L3219
	r_PtxRegister1196 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1198);	   // PTX L3220
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1196)) =
		make_uint4(r_PackedE4WordAtPtx3215R1197, r_PackedE4WordAtPtx3215R1197, r_PackedE4WordAtPtx3215R1197,
				   r_PackedE4WordAtPtx3215R1197);							 // PTX L3222
L__BB46_105:																 // PTX L3224
	r_bPtxPredicate63 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3); // PTX L3225
	r_bPtxPredicate64 = int32_t(r_PtxRegister12) < int32_t(r_PtxRegister3);	 // PTX L3226
	r_PtxRegister1202 = uint32_t(r_PtxRegister34) + uint32_t(128);			 // PTX L3227
	r_PtxRegister37 = r_bPtxPredicate64 ? r_PtxRegister1202 : 0;			 // PTX L3228
	r_PtxU64Register472 = uint64_t(0);										 // PTX L3229
	if (r_bPtxPredicate63)
	{
		goto L__BB46_107;
	} // PTX L3230
	r_PtxU64Register243 = uint64_t(int64_t(int32_t(r_PtxRegister37)) * int64_t(int32_t(4))); // PTX L3231
	r_PtxU64Register472 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register243);		 // PTX L3232
L__BB46_107:																				 // PTX L3233
	r_bPtxPredicate65 = int32_t(r_PtxRegister12) >= int32_t(r_PtxRegister3);				 // PTX L3234
	if (r_bPtxPredicate65)
	{
		goto L__BB46_110;
	} // PTX L3235
	r_PtxRegister1211 = uint32_t(-1);								// PTX L3236
	r_PtxRegister1210 = Elected(r_PtxRegister1211);					// PTX L3238
	r_bPtxPredicate66 = uint32_t(r_PtxRegister1210) == uint32_t(0); // PTX L3244
	if (r_bPtxPredicate66)
	{
		goto L__BB46_111;
	} // PTX L3245
	r_PtxRegister1212 = uint32_t(r_PtxRegister36) + uint32_t(512); // PTX L3246
	r_PtxU64Register244 = r_PtxU64Register472;					   // PTX L3247
	r_PtxRegister1213 = uint32_t(512);							   // PTX L3248
	CopyBulk(s_SharedStorage, r_PtxRegister1212, r_PtxU64Register244, r_PtxRegister1213,
			 r_PtxRegister1214);																// PTX L3250
	BarrierExpect(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1213);						// PTX L3253
	goto L__BB46_111;																			// PTX L3255
L__BB46_110:																					// PTX L3256
	r_PtxRegister1203 = uint32_t(0);															// PTX L3257
	r_PtxU16Register98 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1203))); // PTX L3259
	r_PackedHalf2AtPtx3262R1204 = JoinHalfwords(r_PtxU16Register98, r_PtxU16Register98);		// PTX L3262
	r_ConvertedE4PairAtPtx3264Rs99 = PublishE4(r_PackedHalf2AtPtx3262R1204);					// PTX L3264
	r_PackedE4WordAtPtx3266R1207 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3264Rs99, r_ConvertedE4PairAtPtx3264Rs99); // PTX L3266
	r_LaneIndexAtPtx3268 = uint32_t((threadIdx.x & 31u));							   // PTX L3268
	r_PtxRegister1208 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3268), uint32_t(4));		   // PTX L3270
	r_PtxRegister1209 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1208);	   // PTX L3271
	r_PtxRegister1206 = uint32_t(r_PtxRegister1209) + uint32_t(512);				   // PTX L3272
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1206)) =
		make_uint4(r_PackedE4WordAtPtx3266R1207, r_PackedE4WordAtPtx3266R1207, r_PackedE4WordAtPtx3266R1207,
				   r_PackedE4WordAtPtx3266R1207);												  // PTX L3274
L__BB46_111:																					  // PTX L3276
	r_PtxRegister1224 = ShiftLeft(uint32_t(r_PtxRegister29), uint32_t(8));						  // PTX L3277
	r_PtxRegister1225 = uint32_t(r_PtxRegister1224) + uint32_t(r_PtxRegister83);				  // PTX L3278
	r_PtxU64Register253 = uint64_t(int64_t(int32_t(r_PtxRegister1225)) * int64_t(int32_t(4)));	  // PTX L3279
	g_RecordByteAddressAtPtx3280 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register253); // PTX L3280
	r_LaneIndexAtPtx3282 = uint32_t((threadIdx.x & 31u));										  // PTX L3282
	r_PtxU64Register255 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3282)) * int64_t(int32_t(16))); // PTX L3284
	g_RecordByteAddressAtPtx3285 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register255); // PTX L3285
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3285));
		r_MmaBE4x4WordAtPtx78R1777 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R1778 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R1779 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R1780 = r_Value.w;
	} // PTX L3287
	r_LaneIndexAtPtx3290 = uint32_t((threadIdx.x & 31u)); // PTX L3290
	r_PtxU64Register256 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3290)) * int64_t(int32_t(16))); // PTX L3292
	g_RecordByteAddressAtPtx3293 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register256);			   // PTX L3293
	g_RecordByteAddressAtPtx3294 = uint64_t(g_RecordByteAddressAtPtx3293) + uint64_t(512); // PTX L3294
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3294));
		r_MmaBE4x4WordAtPtx87R1781 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R1782 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R1783 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R1784 = r_Value.w;
	} // PTX L3296
	r_LaneIndexAtPtx3299 = uint32_t((threadIdx.x & 31u)); // PTX L3299
	r_PtxU64Register258 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3299)) * int64_t(int32_t(16))); // PTX L3301
	g_RecordByteAddressAtPtx3302 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register258);				// PTX L3302
	g_RecordByteAddressAtPtx3303 = uint64_t(g_RecordByteAddressAtPtx3302) + uint64_t(1024); // PTX L3303
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3303));
		r_MmaBE4x4WordAtPtx96R1785 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R1786 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R1787 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R1788 = r_Value.w;
	} // PTX L3305
	r_LaneIndexAtPtx3308 = uint32_t((threadIdx.x & 31u)); // PTX L3308
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3308)) * int64_t(int32_t(16))); // PTX L3310
	g_RecordByteAddressAtPtx3311 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register260);				// PTX L3311
	g_RecordByteAddressAtPtx3312 = uint64_t(g_RecordByteAddressAtPtx3311) + uint64_t(1536); // PTX L3312
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3312));
		r_MmaBE4x4WordAtPtx105R1789 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R1790 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R1791 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R1792 = r_Value.w;
	} // PTX L3314
	r_LaneIndexAtPtx3317 = uint32_t((threadIdx.x & 31u)); // PTX L3317
	r_PtxU64Register262 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3317)) * int64_t(int32_t(16))); // PTX L3319
	g_RecordByteAddressAtPtx3320 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register262);				 // PTX L3320
	g_RecordByteAddressAtPtx3321 = uint64_t(g_RecordByteAddressAtPtx3320) + uint64_t(32768); // PTX L3321
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3321));
		r_MmaBE4x4WordAtPtx114R1793 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R1794 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R1795 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R1796 = r_Value.w;
	} // PTX L3323
	r_LaneIndexAtPtx3326 = uint32_t((threadIdx.x & 31u)); // PTX L3326
	r_PtxU64Register264 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3326)) * int64_t(int32_t(16))); // PTX L3328
	g_RecordByteAddressAtPtx3329 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register264);				 // PTX L3329
	g_RecordByteAddressAtPtx3330 = uint64_t(g_RecordByteAddressAtPtx3329) + uint64_t(33280); // PTX L3330
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3330));
		r_MmaBE4x4WordAtPtx123R1797 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R1798 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R1799 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R1800 = r_Value.w;
	} // PTX L3332
	r_LaneIndexAtPtx3335 = uint32_t((threadIdx.x & 31u)); // PTX L3335
	r_PtxU64Register266 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3335)) * int64_t(int32_t(16))); // PTX L3337
	g_RecordByteAddressAtPtx3338 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register266);				 // PTX L3338
	g_RecordByteAddressAtPtx3339 = uint64_t(g_RecordByteAddressAtPtx3338) + uint64_t(33792); // PTX L3339
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3339));
		r_MmaBE4x4WordAtPtx132R1801 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R1802 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R1803 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R1804 = r_Value.w;
	} // PTX L3341
	r_LaneIndexAtPtx3344 = uint32_t((threadIdx.x & 31u)); // PTX L3344
	r_PtxU64Register268 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3344)) * int64_t(int32_t(16))); // PTX L3346
	g_RecordByteAddressAtPtx3347 =
		uint64_t(g_RecordByteAddressAtPtx3280) + uint64_t(r_PtxU64Register268);				 // PTX L3347
	g_RecordByteAddressAtPtx3348 = uint64_t(g_RecordByteAddressAtPtx3347) + uint64_t(34304); // PTX L3348
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx3348));
		r_MmaBE4x4WordAtPtx141R1805 = r_Value.x;
		r_MmaBE4x4WordAtPtx141R1806 = r_Value.y;
		r_MmaBE4x4WordAtPtx141R1807 = r_Value.z;
		r_MmaBE4x4WordAtPtx141R1808 = r_Value.w;
	} // PTX L3350
	r_PtxRegister1223 = uint32_t(1);															// PTX L3352
	r_PtxU64Register270 = BarrierArrive(s_SharedStorage, r_PtxRegister1214, r_PtxRegister1223); // PTX L3354
L__BB46_112:																					// PTX L3356
	r_PtxRegister1226 = BarrierReady(s_SharedStorage, r_PtxRegister1214, r_PtxU64Register270);	// PTX L3358
	r_bPtxPredicate67 = uint32_t(r_PtxRegister1226) == uint32_t(0);								// PTX L3364
	if (r_bPtxPredicate67)
	{
		goto L__BB46_112;
	} // PTX L3365
	r_bPtxPredicate68 = uint32_t(r_PtxRegister1776) < uint32_t(896); // PTX L3366
	r_PtxRegister1776 = uint32_t(r_PtxRegister26);					 // PTX L3367
	if (r_bPtxPredicate68)
	{
		goto L__BB46_73;
	} // PTX L3368
	r_bPtxPredicate69 = uint32_t(r_CtaZ) == uint32_t(0);						   // PTX L3369
	r_LaneIndexAtPtx3371 = uint32_t((threadIdx.x & 31u));						   // PTX L3371
	r_PtxRegister1403 = uint32_t(0u /* native shared input */);					   // PTX L3373
	r_PtxRegister1404 = uint32_t(r_PtxRegister1403) + uint32_t(r_PtxRegister20);   // PTX L3374
	r_PtxRegister1405 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3371), uint32_t(4));	   // PTX L3375
	r_PtxRegister1406 = uint32_t(r_PtxRegister1404) + uint32_t(r_PtxRegister1405); // PTX L3376
	r_PtxRegister1228 = uint32_t(r_PtxRegister1406) + uint32_t(8192);			   // PTX L3377
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1228));
		r_MmaAE4x4WordAtPtx3379R1243 = r_Value.x;
		r_MmaAE4x4WordAtPtx3379R1244 = r_Value.y;
		r_MmaAE4x4WordAtPtx3379R1245 = r_Value.z;
		r_MmaAE4x4WordAtPtx3379R1246 = r_Value.w;
	} // PTX L3379
	r_LaneIndexAtPtx3382 = uint32_t((threadIdx.x & 31u));						   // PTX L3382
	r_PtxRegister1407 = uint32_t(r_PtxRegister1403) + uint32_t(r_PtxRegister1143); // PTX L3384
	r_PtxRegister1408 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3382), uint32_t(4));	   // PTX L3385
	r_PtxRegister1409 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1408); // PTX L3386
	r_PtxRegister1230 = uint32_t(r_PtxRegister1409) + uint32_t(8704);			   // PTX L3387
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1230));
		r_MmaAE4x4WordAtPtx3389R1249 = r_Value.x;
		r_MmaAE4x4WordAtPtx3389R1250 = r_Value.y;
		r_MmaAE4x4WordAtPtx3389R1251 = r_Value.z;
		r_MmaAE4x4WordAtPtx3389R1252 = r_Value.w;
	} // PTX L3389
	r_LaneIndexAtPtx3392 = uint32_t((threadIdx.x & 31u));						   // PTX L3392
	r_PtxRegister1410 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3392), uint32_t(4));	   // PTX L3394
	r_PtxRegister1411 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1410); // PTX L3395
	r_PtxRegister1232 = uint32_t(r_PtxRegister1411) + uint32_t(9216);			   // PTX L3396
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1232));
		r_MmaAE4x4WordAtPtx3398R1283 = r_Value.x;
		r_MmaAE4x4WordAtPtx3398R1284 = r_Value.y;
		r_MmaAE4x4WordAtPtx3398R1285 = r_Value.z;
		r_MmaAE4x4WordAtPtx3398R1286 = r_Value.w;
	} // PTX L3398
	r_LaneIndexAtPtx3401 = uint32_t((threadIdx.x & 31u));						   // PTX L3401
	r_PtxRegister1412 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3401), uint32_t(4));	   // PTX L3403
	r_PtxRegister1413 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1412); // PTX L3404
	r_PtxRegister1234 = uint32_t(r_PtxRegister1413) + uint32_t(9728);			   // PTX L3405
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1234));
		r_MmaAE4x4WordAtPtx3407R1289 = r_Value.x;
		r_MmaAE4x4WordAtPtx3407R1290 = r_Value.y;
		r_MmaAE4x4WordAtPtx3407R1291 = r_Value.z;
		r_MmaAE4x4WordAtPtx3407R1292 = r_Value.w;
	} // PTX L3407
	r_LaneIndexAtPtx3410 = uint32_t((threadIdx.x & 31u));						   // PTX L3410
	r_PtxRegister1414 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3410), uint32_t(4));	   // PTX L3412
	r_PtxRegister1415 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1414); // PTX L3413
	r_PtxRegister1236 = uint32_t(r_PtxRegister1415) + uint32_t(10240);			   // PTX L3414
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1236));
		r_MmaAE4x4WordAtPtx3416R1323 = r_Value.x;
		r_MmaAE4x4WordAtPtx3416R1324 = r_Value.y;
		r_MmaAE4x4WordAtPtx3416R1325 = r_Value.z;
		r_MmaAE4x4WordAtPtx3416R1326 = r_Value.w;
	} // PTX L3416
	r_LaneIndexAtPtx3419 = uint32_t((threadIdx.x & 31u));						   // PTX L3419
	r_PtxRegister1416 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3419), uint32_t(4));	   // PTX L3421
	r_PtxRegister1417 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1416); // PTX L3422
	r_PtxRegister1238 = uint32_t(r_PtxRegister1417) + uint32_t(10752);			   // PTX L3423
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1238));
		r_MmaAE4x4WordAtPtx3425R1329 = r_Value.x;
		r_MmaAE4x4WordAtPtx3425R1330 = r_Value.y;
		r_MmaAE4x4WordAtPtx3425R1331 = r_Value.z;
		r_MmaAE4x4WordAtPtx3425R1332 = r_Value.w;
	} // PTX L3425
	r_LaneIndexAtPtx3428 = uint32_t((threadIdx.x & 31u));						   // PTX L3428
	r_PtxRegister1418 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3428), uint32_t(4));	   // PTX L3430
	r_PtxRegister1419 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1418); // PTX L3431
	r_PtxRegister1240 = uint32_t(r_PtxRegister1419) + uint32_t(11264);			   // PTX L3432
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1240));
		r_MmaAE4x4WordAtPtx3434R1363 = r_Value.x;
		r_MmaAE4x4WordAtPtx3434R1364 = r_Value.y;
		r_MmaAE4x4WordAtPtx3434R1365 = r_Value.z;
		r_MmaAE4x4WordAtPtx3434R1366 = r_Value.w;
	} // PTX L3434
	r_LaneIndexAtPtx3437 = uint32_t((threadIdx.x & 31u));						   // PTX L3437
	r_PtxRegister1420 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3437), uint32_t(4));	   // PTX L3439
	r_PtxRegister1421 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1420); // PTX L3440
	r_PtxRegister1242 = uint32_t(r_PtxRegister1421) + uint32_t(11776);			   // PTX L3441
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1242));
		r_MmaAE4x4WordAtPtx3443R1369 = r_Value.x;
		r_MmaAE4x4WordAtPtx3443R1370 = r_Value.y;
		r_MmaAE4x4WordAtPtx3443R1371 = r_Value.z;
		r_MmaAE4x4WordAtPtx3443R1372 = r_Value.w;
	} // PTX L3443
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3446R1253, r_MmaAccumulatorHalf2WordAtPtx3446R1254,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx559R1775,
		  r_PackedHalf2AtPtx558R1774); // PTX L3446
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3453R1257, r_MmaAccumulatorHalf2WordAtPtx3453R1258,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx557R1773,
		  r_PackedHalf2AtPtx556R1772); // PTX L3453
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3460R1247, r_MmaAccumulatorHalf2WordAtPtx3460R1248,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794,
		  r_MmaAccumulatorHalf2WordAtPtx3446R1253,
		  r_MmaAccumulatorHalf2WordAtPtx3446R1254); // PTX L3460
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3467R1255, r_MmaAccumulatorHalf2WordAtPtx3467R1256,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796,
		  r_MmaAccumulatorHalf2WordAtPtx3453R1257,
		  r_MmaAccumulatorHalf2WordAtPtx3453R1258); // PTX L3467
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3474R1261, r_MmaAccumulatorHalf2WordAtPtx3474R1262,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx555R1771,
		  r_PackedHalf2AtPtx554R1770); // PTX L3474
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3481R1265, r_MmaAccumulatorHalf2WordAtPtx3481R1266,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx553R1769,
		  r_PackedHalf2AtPtx552R1768); // PTX L3481
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3488R1259, r_MmaAccumulatorHalf2WordAtPtx3488R1260,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798,
		  r_MmaAccumulatorHalf2WordAtPtx3474R1261,
		  r_MmaAccumulatorHalf2WordAtPtx3474R1262); // PTX L3488
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3495R1263, r_MmaAccumulatorHalf2WordAtPtx3495R1264,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800,
		  r_MmaAccumulatorHalf2WordAtPtx3481R1265,
		  r_MmaAccumulatorHalf2WordAtPtx3481R1266); // PTX L3495
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3502R1269, r_MmaAccumulatorHalf2WordAtPtx3502R1270,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx551R1767,
		  r_PackedHalf2AtPtx550R1766); // PTX L3502
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3509R1273, r_MmaAccumulatorHalf2WordAtPtx3509R1274,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx549R1765,
		  r_PackedHalf2AtPtx548R1764); // PTX L3509
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3516R1267, r_MmaAccumulatorHalf2WordAtPtx3516R1268,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802,
		  r_MmaAccumulatorHalf2WordAtPtx3502R1269,
		  r_MmaAccumulatorHalf2WordAtPtx3502R1270); // PTX L3516
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3523R1271, r_MmaAccumulatorHalf2WordAtPtx3523R1272,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804,
		  r_MmaAccumulatorHalf2WordAtPtx3509R1273,
		  r_MmaAccumulatorHalf2WordAtPtx3509R1274); // PTX L3523
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3530R1277, r_MmaAccumulatorHalf2WordAtPtx3530R1278,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx547R1763,
		  r_PackedHalf2AtPtx546R1762); // PTX L3530
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3537R1281, r_MmaAccumulatorHalf2WordAtPtx3537R1282,
		  r_MmaAE4x4WordAtPtx3379R1243, r_MmaAE4x4WordAtPtx3379R1244, r_MmaAE4x4WordAtPtx3379R1245,
		  r_MmaAE4x4WordAtPtx3379R1246, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx545R1761,
		  r_PackedHalf2AtPtx544R1760); // PTX L3537
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3544R1275, r_MmaAccumulatorHalf2WordAtPtx3544R1276,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806,
		  r_MmaAccumulatorHalf2WordAtPtx3530R1277,
		  r_MmaAccumulatorHalf2WordAtPtx3530R1278); // PTX L3544
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3551R1279, r_MmaAccumulatorHalf2WordAtPtx3551R1280,
		  r_MmaAE4x4WordAtPtx3389R1249, r_MmaAE4x4WordAtPtx3389R1250, r_MmaAE4x4WordAtPtx3389R1251,
		  r_MmaAE4x4WordAtPtx3389R1252, r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808,
		  r_MmaAccumulatorHalf2WordAtPtx3537R1281,
		  r_MmaAccumulatorHalf2WordAtPtx3537R1282); // PTX L3551
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3558R1293, r_MmaAccumulatorHalf2WordAtPtx3558R1294,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx543R1759,
		  r_PackedHalf2AtPtx542R1758); // PTX L3558
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3565R1297, r_MmaAccumulatorHalf2WordAtPtx3565R1298,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx541R1757,
		  r_PackedHalf2AtPtx540R1756); // PTX L3565
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3572R1287, r_MmaAccumulatorHalf2WordAtPtx3572R1288,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794,
		  r_MmaAccumulatorHalf2WordAtPtx3558R1293,
		  r_MmaAccumulatorHalf2WordAtPtx3558R1294); // PTX L3572
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3579R1295, r_MmaAccumulatorHalf2WordAtPtx3579R1296,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796,
		  r_MmaAccumulatorHalf2WordAtPtx3565R1297,
		  r_MmaAccumulatorHalf2WordAtPtx3565R1298); // PTX L3579
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3586R1301, r_MmaAccumulatorHalf2WordAtPtx3586R1302,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx539R1755,
		  r_PackedHalf2AtPtx538R1754); // PTX L3586
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3593R1305, r_MmaAccumulatorHalf2WordAtPtx3593R1306,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx537R1753,
		  r_PackedHalf2AtPtx536R1752); // PTX L3593
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3600R1299, r_MmaAccumulatorHalf2WordAtPtx3600R1300,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798,
		  r_MmaAccumulatorHalf2WordAtPtx3586R1301,
		  r_MmaAccumulatorHalf2WordAtPtx3586R1302); // PTX L3600
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3607R1303, r_MmaAccumulatorHalf2WordAtPtx3607R1304,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800,
		  r_MmaAccumulatorHalf2WordAtPtx3593R1305,
		  r_MmaAccumulatorHalf2WordAtPtx3593R1306); // PTX L3607
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3614R1309, r_MmaAccumulatorHalf2WordAtPtx3614R1310,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx535R1751,
		  r_PackedHalf2AtPtx534R1750); // PTX L3614
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3621R1313, r_MmaAccumulatorHalf2WordAtPtx3621R1314,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx533R1749,
		  r_PackedHalf2AtPtx532R1748); // PTX L3621
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3628R1307, r_MmaAccumulatorHalf2WordAtPtx3628R1308,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802,
		  r_MmaAccumulatorHalf2WordAtPtx3614R1309,
		  r_MmaAccumulatorHalf2WordAtPtx3614R1310); // PTX L3628
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3635R1311, r_MmaAccumulatorHalf2WordAtPtx3635R1312,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804,
		  r_MmaAccumulatorHalf2WordAtPtx3621R1313,
		  r_MmaAccumulatorHalf2WordAtPtx3621R1314); // PTX L3635
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3642R1317, r_MmaAccumulatorHalf2WordAtPtx3642R1318,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx531R1747,
		  r_PackedHalf2AtPtx530R1746); // PTX L3642
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3649R1321, r_MmaAccumulatorHalf2WordAtPtx3649R1322,
		  r_MmaAE4x4WordAtPtx3398R1283, r_MmaAE4x4WordAtPtx3398R1284, r_MmaAE4x4WordAtPtx3398R1285,
		  r_MmaAE4x4WordAtPtx3398R1286, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx529R1745,
		  r_PackedHalf2AtPtx528R1744); // PTX L3649
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3656R1315, r_MmaAccumulatorHalf2WordAtPtx3656R1316,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806,
		  r_MmaAccumulatorHalf2WordAtPtx3642R1317,
		  r_MmaAccumulatorHalf2WordAtPtx3642R1318); // PTX L3656
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3663R1319, r_MmaAccumulatorHalf2WordAtPtx3663R1320,
		  r_MmaAE4x4WordAtPtx3407R1289, r_MmaAE4x4WordAtPtx3407R1290, r_MmaAE4x4WordAtPtx3407R1291,
		  r_MmaAE4x4WordAtPtx3407R1292, r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808,
		  r_MmaAccumulatorHalf2WordAtPtx3649R1321,
		  r_MmaAccumulatorHalf2WordAtPtx3649R1322); // PTX L3663
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3670R1333, r_MmaAccumulatorHalf2WordAtPtx3670R1334,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx527R1743,
		  r_PackedHalf2AtPtx526R1742); // PTX L3670
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3677R1337, r_MmaAccumulatorHalf2WordAtPtx3677R1338,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx525R1741,
		  r_PackedHalf2AtPtx524R1740); // PTX L3677
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3684R1327, r_MmaAccumulatorHalf2WordAtPtx3684R1328,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794,
		  r_MmaAccumulatorHalf2WordAtPtx3670R1333,
		  r_MmaAccumulatorHalf2WordAtPtx3670R1334); // PTX L3684
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3691R1335, r_MmaAccumulatorHalf2WordAtPtx3691R1336,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796,
		  r_MmaAccumulatorHalf2WordAtPtx3677R1337,
		  r_MmaAccumulatorHalf2WordAtPtx3677R1338); // PTX L3691
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3698R1341, r_MmaAccumulatorHalf2WordAtPtx3698R1342,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx523R1739,
		  r_PackedHalf2AtPtx522R1738); // PTX L3698
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3705R1345, r_MmaAccumulatorHalf2WordAtPtx3705R1346,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx521R1737,
		  r_PackedHalf2AtPtx520R1736); // PTX L3705
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3712R1339, r_MmaAccumulatorHalf2WordAtPtx3712R1340,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798,
		  r_MmaAccumulatorHalf2WordAtPtx3698R1341,
		  r_MmaAccumulatorHalf2WordAtPtx3698R1342); // PTX L3712
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3719R1343, r_MmaAccumulatorHalf2WordAtPtx3719R1344,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800,
		  r_MmaAccumulatorHalf2WordAtPtx3705R1345,
		  r_MmaAccumulatorHalf2WordAtPtx3705R1346); // PTX L3719
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3726R1349, r_MmaAccumulatorHalf2WordAtPtx3726R1350,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx519R1735,
		  r_PackedHalf2AtPtx518R1734); // PTX L3726
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3733R1353, r_MmaAccumulatorHalf2WordAtPtx3733R1354,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx517R1733,
		  r_PackedHalf2AtPtx516R1732); // PTX L3733
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3740R1347, r_MmaAccumulatorHalf2WordAtPtx3740R1348,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802,
		  r_MmaAccumulatorHalf2WordAtPtx3726R1349,
		  r_MmaAccumulatorHalf2WordAtPtx3726R1350); // PTX L3740
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3747R1351, r_MmaAccumulatorHalf2WordAtPtx3747R1352,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804,
		  r_MmaAccumulatorHalf2WordAtPtx3733R1353,
		  r_MmaAccumulatorHalf2WordAtPtx3733R1354); // PTX L3747
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3754R1357, r_MmaAccumulatorHalf2WordAtPtx3754R1358,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx515R1731,
		  r_PackedHalf2AtPtx514R1730); // PTX L3754
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3761R1361, r_MmaAccumulatorHalf2WordAtPtx3761R1362,
		  r_MmaAE4x4WordAtPtx3416R1323, r_MmaAE4x4WordAtPtx3416R1324, r_MmaAE4x4WordAtPtx3416R1325,
		  r_MmaAE4x4WordAtPtx3416R1326, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx513R1729,
		  r_PackedHalf2AtPtx512R1728); // PTX L3761
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3768R1355, r_MmaAccumulatorHalf2WordAtPtx3768R1356,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806,
		  r_MmaAccumulatorHalf2WordAtPtx3754R1357,
		  r_MmaAccumulatorHalf2WordAtPtx3754R1358); // PTX L3768
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3775R1359, r_MmaAccumulatorHalf2WordAtPtx3775R1360,
		  r_MmaAE4x4WordAtPtx3425R1329, r_MmaAE4x4WordAtPtx3425R1330, r_MmaAE4x4WordAtPtx3425R1331,
		  r_MmaAE4x4WordAtPtx3425R1332, r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808,
		  r_MmaAccumulatorHalf2WordAtPtx3761R1361,
		  r_MmaAccumulatorHalf2WordAtPtx3761R1362); // PTX L3775
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3782R1373, r_MmaAccumulatorHalf2WordAtPtx3782R1374,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx78R1777, r_MmaBE4x4WordAtPtx78R1778,
		  r_PackedHalf2AtPtx511R1727,
		  r_PackedHalf2AtPtx510R1726); // PTX L3782
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3789R1377, r_MmaAccumulatorHalf2WordAtPtx3789R1378,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx78R1779, r_MmaBE4x4WordAtPtx78R1780,
		  r_PackedHalf2AtPtx509R1725,
		  r_PackedHalf2AtPtx508R1724); // PTX L3789
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3796R1367, r_MmaAccumulatorHalf2WordAtPtx3796R1368,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx114R1793, r_MmaBE4x4WordAtPtx114R1794,
		  r_MmaAccumulatorHalf2WordAtPtx3782R1373,
		  r_MmaAccumulatorHalf2WordAtPtx3782R1374); // PTX L3796
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3803R1375, r_MmaAccumulatorHalf2WordAtPtx3803R1376,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx114R1795, r_MmaBE4x4WordAtPtx114R1796,
		  r_MmaAccumulatorHalf2WordAtPtx3789R1377,
		  r_MmaAccumulatorHalf2WordAtPtx3789R1378); // PTX L3803
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3810R1381, r_MmaAccumulatorHalf2WordAtPtx3810R1382,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx87R1781, r_MmaBE4x4WordAtPtx87R1782,
		  r_PackedHalf2AtPtx507R1723,
		  r_PackedHalf2AtPtx506R1722); // PTX L3810
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3817R1385, r_MmaAccumulatorHalf2WordAtPtx3817R1386,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx87R1783, r_MmaBE4x4WordAtPtx87R1784,
		  r_PackedHalf2AtPtx505R1721,
		  r_PackedHalf2AtPtx504R1720); // PTX L3817
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3824R1379, r_MmaAccumulatorHalf2WordAtPtx3824R1380,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx123R1797, r_MmaBE4x4WordAtPtx123R1798,
		  r_MmaAccumulatorHalf2WordAtPtx3810R1381,
		  r_MmaAccumulatorHalf2WordAtPtx3810R1382); // PTX L3824
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3831R1383, r_MmaAccumulatorHalf2WordAtPtx3831R1384,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx123R1799, r_MmaBE4x4WordAtPtx123R1800,
		  r_MmaAccumulatorHalf2WordAtPtx3817R1385,
		  r_MmaAccumulatorHalf2WordAtPtx3817R1386); // PTX L3831
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3838R1389, r_MmaAccumulatorHalf2WordAtPtx3838R1390,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx96R1785, r_MmaBE4x4WordAtPtx96R1786,
		  r_PackedHalf2AtPtx503R1719,
		  r_PackedHalf2AtPtx502R1718); // PTX L3838
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3845R1393, r_MmaAccumulatorHalf2WordAtPtx3845R1394,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx96R1787, r_MmaBE4x4WordAtPtx96R1788,
		  r_PackedHalf2AtPtx501R1717,
		  r_PackedHalf2AtPtx500R1716); // PTX L3845
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3852R1387, r_MmaAccumulatorHalf2WordAtPtx3852R1388,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx132R1801, r_MmaBE4x4WordAtPtx132R1802,
		  r_MmaAccumulatorHalf2WordAtPtx3838R1389,
		  r_MmaAccumulatorHalf2WordAtPtx3838R1390); // PTX L3852
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3859R1391, r_MmaAccumulatorHalf2WordAtPtx3859R1392,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx132R1803, r_MmaBE4x4WordAtPtx132R1804,
		  r_MmaAccumulatorHalf2WordAtPtx3845R1393,
		  r_MmaAccumulatorHalf2WordAtPtx3845R1394); // PTX L3859
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3866R1397, r_MmaAccumulatorHalf2WordAtPtx3866R1398,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx105R1789, r_MmaBE4x4WordAtPtx105R1790,
		  r_PackedHalf2AtPtx499R1715,
		  r_PackedHalf2AtPtx498R1714); // PTX L3866
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3873R1401, r_MmaAccumulatorHalf2WordAtPtx3873R1402,
		  r_MmaAE4x4WordAtPtx3434R1363, r_MmaAE4x4WordAtPtx3434R1364, r_MmaAE4x4WordAtPtx3434R1365,
		  r_MmaAE4x4WordAtPtx3434R1366, r_MmaBE4x4WordAtPtx105R1791, r_MmaBE4x4WordAtPtx105R1792,
		  r_PackedHalf2AtPtx497R1713,
		  r_PackedHalf2AtPtx496R1712); // PTX L3873
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3880R1395, r_MmaAccumulatorHalf2WordAtPtx3880R1396,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx141R1805, r_MmaBE4x4WordAtPtx141R1806,
		  r_MmaAccumulatorHalf2WordAtPtx3866R1397,
		  r_MmaAccumulatorHalf2WordAtPtx3866R1398); // PTX L3880
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3887R1399, r_MmaAccumulatorHalf2WordAtPtx3887R1400,
		  r_MmaAE4x4WordAtPtx3443R1369, r_MmaAE4x4WordAtPtx3443R1370, r_MmaAE4x4WordAtPtx3443R1371,
		  r_MmaAE4x4WordAtPtx3443R1372, r_MmaBE4x4WordAtPtx141R1807, r_MmaBE4x4WordAtPtx141R1808,
		  r_MmaAccumulatorHalf2WordAtPtx3873R1401,
		  r_MmaAccumulatorHalf2WordAtPtx3873R1402);											   // PTX L3887
	r_PtxRegister1422 = uint32_t(r_PtxRegister2) + uint32_t(r_PtxRegister1);				   // PTX L3893
	r_PtxU64Register271 = uint64_t(int64_t(int32_t(r_PtxRegister1422)) * int64_t(int32_t(4))); // PTX L3894
	g_CounterByteAddress = uint64_t(g_CounterBaseAddress) + uint64_t(r_PtxU64Register271);	   // PTX L3895
	if (r_bPtxPredicate69)
	{
		goto L__BB46_119;
	} // PTX L3896
	r_ThreadZAtPtx3897 = uint32_t(threadIdx.z);						// PTX L3897
	r_PtxRegister1424 = r_PtxRegister64 | r_ThreadZAtPtx3897;		// PTX L3898
	r_bPtxPredicate70 = uint32_t(r_PtxRegister1424) != uint32_t(0); // PTX L3899
	if (r_bPtxPredicate70)
	{
		goto L__BB46_135;
	} // PTX L3900
	goto L__BB46_116;									// PTX L3901
L__BB46_135:											// PTX L3902
	__syncthreads();									// PTX L3903
	r_bPtxPredicate72 = uint32_t(r_CtaZ) < uint32_t(3); // PTX L3904
	if (r_bPtxPredicate72)
	{
		goto L__BB46_127;
	} // PTX L3905
	goto L__BB46_136;														 // PTX L3906
L__BB46_127:																 // PTX L3907
	r_PtxRegister40 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2);	 // PTX L3908
	r_bPtxPredicate92 = int32_t(r_PtxRegister40) >= int32_t(r_PtxRegister3); // PTX L3909
	if (r_bPtxPredicate92)
	{
		goto L__BB46_129;
	} // PTX L3910
	r_PtxRegister1619 = ShiftLeft(uint32_t(r_PtxRegister40), uint32_t(13));						  // PTX L3911
	r_PtxRegister1620 = uint32_t(r_PtxRegister1619) + uint32_t(r_PtxRegister83);				  // PTX L3912
	r_PtxU64Register332 = SignExtendWordBits(r_PtxRegister1620);								  // PTX L3913
	r_LaneIndexAtPtx3915 = uint32_t((threadIdx.x & 31u));										  // PTX L3915
	r_PtxU64Register333 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3915)) * int64_t(int32_t(4))); // PTX L3917
	r_PtxU64Register334 = uint64_t(r_PtxU64Register333) + uint64_t(r_PtxU64Register332);		  // PTX L3918
	r_PtxU64Register335 = ShiftLeft(uint64_t(r_PtxU64Register334), uint32_t(2));				  // PTX L3919
	r_PtxU64Register328 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register335);		  // PTX L3920
	ReduceHalf4(r_PtxU64Register328,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3460R1247, r_MmaAccumulatorHalf2WordAtPtx3460R1248,
						   r_MmaAccumulatorHalf2WordAtPtx3467R1255,
						   r_MmaAccumulatorHalf2WordAtPtx3467R1256));							  // PTX L3922
	r_PtxRegister1621 = uint32_t(r_PtxRegister1620) + uint32_t(128);							  // PTX L3924
	r_PtxU64Register336 = SignExtendWordBits(r_PtxRegister1621);								  // PTX L3925
	r_LaneIndexAtPtx3927 = uint32_t((threadIdx.x & 31u));										  // PTX L3927
	r_PtxU64Register337 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3927)) * int64_t(int32_t(4))); // PTX L3929
	r_PtxU64Register338 = uint64_t(r_PtxU64Register337) + uint64_t(r_PtxU64Register336);		  // PTX L3930
	r_PtxU64Register339 = ShiftLeft(uint64_t(r_PtxU64Register338), uint32_t(2));				  // PTX L3931
	r_PtxU64Register329 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register339);		  // PTX L3932
	ReduceHalf4(r_PtxU64Register329,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3488R1259, r_MmaAccumulatorHalf2WordAtPtx3488R1260,
						   r_MmaAccumulatorHalf2WordAtPtx3495R1263,
						   r_MmaAccumulatorHalf2WordAtPtx3495R1264));							  // PTX L3934
	r_PtxRegister1622 = uint32_t(r_PtxRegister1620) + uint32_t(256);							  // PTX L3936
	r_PtxU64Register340 = SignExtendWordBits(r_PtxRegister1622);								  // PTX L3937
	r_LaneIndexAtPtx3939 = uint32_t((threadIdx.x & 31u));										  // PTX L3939
	r_PtxU64Register341 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3939)) * int64_t(int32_t(4))); // PTX L3941
	r_PtxU64Register342 = uint64_t(r_PtxU64Register341) + uint64_t(r_PtxU64Register340);		  // PTX L3942
	r_PtxU64Register343 = ShiftLeft(uint64_t(r_PtxU64Register342), uint32_t(2));				  // PTX L3943
	r_PtxU64Register330 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register343);		  // PTX L3944
	ReduceHalf4(r_PtxU64Register330,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3516R1267, r_MmaAccumulatorHalf2WordAtPtx3516R1268,
						   r_MmaAccumulatorHalf2WordAtPtx3523R1271,
						   r_MmaAccumulatorHalf2WordAtPtx3523R1272));							  // PTX L3946
	r_PtxRegister1623 = uint32_t(r_PtxRegister1620) + uint32_t(384);							  // PTX L3948
	r_PtxU64Register344 = SignExtendWordBits(r_PtxRegister1623);								  // PTX L3949
	r_LaneIndexAtPtx3951 = uint32_t((threadIdx.x & 31u));										  // PTX L3951
	r_PtxU64Register345 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3951)) * int64_t(int32_t(4))); // PTX L3953
	r_PtxU64Register346 = uint64_t(r_PtxU64Register345) + uint64_t(r_PtxU64Register344);		  // PTX L3954
	r_PtxU64Register347 = ShiftLeft(uint64_t(r_PtxU64Register346), uint32_t(2));				  // PTX L3955
	r_PtxU64Register331 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register347);		  // PTX L3956
	ReduceHalf4(r_PtxU64Register331,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3544R1275, r_MmaAccumulatorHalf2WordAtPtx3544R1276,
						   r_MmaAccumulatorHalf2WordAtPtx3551R1279,
						   r_MmaAccumulatorHalf2WordAtPtx3551R1280));		 // PTX L3958
L__BB46_129:																 // PTX L3960
	r_PtxRegister41 = uint32_t(r_PtxRegister40) + uint32_t(1);				 // PTX L3961
	r_bPtxPredicate93 = int32_t(r_PtxRegister41) >= int32_t(r_PtxRegister3); // PTX L3962
	if (r_bPtxPredicate93)
	{
		goto L__BB46_131;
	} // PTX L3963
	r_PtxRegister1628 = ShiftLeft(uint32_t(r_PtxRegister41), uint32_t(13));						  // PTX L3964
	r_PtxRegister1629 = uint32_t(r_PtxRegister1628) + uint32_t(r_PtxRegister83);				  // PTX L3965
	r_PtxU64Register352 = SignExtendWordBits(r_PtxRegister1629);								  // PTX L3966
	r_LaneIndexAtPtx3968 = uint32_t((threadIdx.x & 31u));										  // PTX L3968
	r_PtxU64Register353 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3968)) * int64_t(int32_t(4))); // PTX L3970
	r_PtxU64Register354 = uint64_t(r_PtxU64Register353) + uint64_t(r_PtxU64Register352);		  // PTX L3971
	r_PtxU64Register355 = ShiftLeft(uint64_t(r_PtxU64Register354), uint32_t(2));				  // PTX L3972
	r_PtxU64Register348 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register355);		  // PTX L3973
	ReduceHalf4(r_PtxU64Register348,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3572R1287, r_MmaAccumulatorHalf2WordAtPtx3572R1288,
						   r_MmaAccumulatorHalf2WordAtPtx3579R1295,
						   r_MmaAccumulatorHalf2WordAtPtx3579R1296));							  // PTX L3975
	r_PtxRegister1630 = uint32_t(r_PtxRegister1629) + uint32_t(128);							  // PTX L3977
	r_PtxU64Register356 = SignExtendWordBits(r_PtxRegister1630);								  // PTX L3978
	r_LaneIndexAtPtx3980 = uint32_t((threadIdx.x & 31u));										  // PTX L3980
	r_PtxU64Register357 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3980)) * int64_t(int32_t(4))); // PTX L3982
	r_PtxU64Register358 = uint64_t(r_PtxU64Register357) + uint64_t(r_PtxU64Register356);		  // PTX L3983
	r_PtxU64Register359 = ShiftLeft(uint64_t(r_PtxU64Register358), uint32_t(2));				  // PTX L3984
	r_PtxU64Register349 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register359);		  // PTX L3985
	ReduceHalf4(r_PtxU64Register349,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3600R1299, r_MmaAccumulatorHalf2WordAtPtx3600R1300,
						   r_MmaAccumulatorHalf2WordAtPtx3607R1303,
						   r_MmaAccumulatorHalf2WordAtPtx3607R1304));							  // PTX L3987
	r_PtxRegister1631 = uint32_t(r_PtxRegister1629) + uint32_t(256);							  // PTX L3989
	r_PtxU64Register360 = SignExtendWordBits(r_PtxRegister1631);								  // PTX L3990
	r_LaneIndexAtPtx3992 = uint32_t((threadIdx.x & 31u));										  // PTX L3992
	r_PtxU64Register361 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3992)) * int64_t(int32_t(4))); // PTX L3994
	r_PtxU64Register362 = uint64_t(r_PtxU64Register361) + uint64_t(r_PtxU64Register360);		  // PTX L3995
	r_PtxU64Register363 = ShiftLeft(uint64_t(r_PtxU64Register362), uint32_t(2));				  // PTX L3996
	r_PtxU64Register350 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register363);		  // PTX L3997
	ReduceHalf4(r_PtxU64Register350,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3628R1307, r_MmaAccumulatorHalf2WordAtPtx3628R1308,
						   r_MmaAccumulatorHalf2WordAtPtx3635R1311,
						   r_MmaAccumulatorHalf2WordAtPtx3635R1312));							  // PTX L3999
	r_PtxRegister1632 = uint32_t(r_PtxRegister1629) + uint32_t(384);							  // PTX L4001
	r_PtxU64Register364 = SignExtendWordBits(r_PtxRegister1632);								  // PTX L4002
	r_LaneIndexAtPtx4004 = uint32_t((threadIdx.x & 31u));										  // PTX L4004
	r_PtxU64Register365 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4004)) * int64_t(int32_t(4))); // PTX L4006
	r_PtxU64Register366 = uint64_t(r_PtxU64Register365) + uint64_t(r_PtxU64Register364);		  // PTX L4007
	r_PtxU64Register367 = ShiftLeft(uint64_t(r_PtxU64Register366), uint32_t(2));				  // PTX L4008
	r_PtxU64Register351 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register367);		  // PTX L4009
	ReduceHalf4(r_PtxU64Register351,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3656R1315, r_MmaAccumulatorHalf2WordAtPtx3656R1316,
						   r_MmaAccumulatorHalf2WordAtPtx3663R1319,
						   r_MmaAccumulatorHalf2WordAtPtx3663R1320));		 // PTX L4011
L__BB46_131:																 // PTX L4013
	r_PtxRegister42 = uint32_t(r_PtxRegister40) + uint32_t(2);				 // PTX L4014
	r_bPtxPredicate94 = int32_t(r_PtxRegister42) >= int32_t(r_PtxRegister3); // PTX L4015
	if (r_bPtxPredicate94)
	{
		goto L__BB46_133;
	} // PTX L4016
	r_PtxRegister1637 = ShiftLeft(uint32_t(r_PtxRegister42), uint32_t(13));						  // PTX L4017
	r_PtxRegister1638 = uint32_t(r_PtxRegister1637) + uint32_t(r_PtxRegister83);				  // PTX L4018
	r_PtxU64Register372 = SignExtendWordBits(r_PtxRegister1638);								  // PTX L4019
	r_LaneIndexAtPtx4021 = uint32_t((threadIdx.x & 31u));										  // PTX L4021
	r_PtxU64Register373 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4021)) * int64_t(int32_t(4))); // PTX L4023
	r_PtxU64Register374 = uint64_t(r_PtxU64Register373) + uint64_t(r_PtxU64Register372);		  // PTX L4024
	r_PtxU64Register375 = ShiftLeft(uint64_t(r_PtxU64Register374), uint32_t(2));				  // PTX L4025
	r_PtxU64Register368 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register375);		  // PTX L4026
	ReduceHalf4(r_PtxU64Register368,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3684R1327, r_MmaAccumulatorHalf2WordAtPtx3684R1328,
						   r_MmaAccumulatorHalf2WordAtPtx3691R1335,
						   r_MmaAccumulatorHalf2WordAtPtx3691R1336));							  // PTX L4028
	r_PtxRegister1639 = uint32_t(r_PtxRegister1638) + uint32_t(128);							  // PTX L4030
	r_PtxU64Register376 = SignExtendWordBits(r_PtxRegister1639);								  // PTX L4031
	r_LaneIndexAtPtx4033 = uint32_t((threadIdx.x & 31u));										  // PTX L4033
	r_PtxU64Register377 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4033)) * int64_t(int32_t(4))); // PTX L4035
	r_PtxU64Register378 = uint64_t(r_PtxU64Register377) + uint64_t(r_PtxU64Register376);		  // PTX L4036
	r_PtxU64Register379 = ShiftLeft(uint64_t(r_PtxU64Register378), uint32_t(2));				  // PTX L4037
	r_PtxU64Register369 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register379);		  // PTX L4038
	ReduceHalf4(r_PtxU64Register369,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3712R1339, r_MmaAccumulatorHalf2WordAtPtx3712R1340,
						   r_MmaAccumulatorHalf2WordAtPtx3719R1343,
						   r_MmaAccumulatorHalf2WordAtPtx3719R1344));							  // PTX L4040
	r_PtxRegister1640 = uint32_t(r_PtxRegister1638) + uint32_t(256);							  // PTX L4042
	r_PtxU64Register380 = SignExtendWordBits(r_PtxRegister1640);								  // PTX L4043
	r_LaneIndexAtPtx4045 = uint32_t((threadIdx.x & 31u));										  // PTX L4045
	r_PtxU64Register381 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4045)) * int64_t(int32_t(4))); // PTX L4047
	r_PtxU64Register382 = uint64_t(r_PtxU64Register381) + uint64_t(r_PtxU64Register380);		  // PTX L4048
	r_PtxU64Register383 = ShiftLeft(uint64_t(r_PtxU64Register382), uint32_t(2));				  // PTX L4049
	r_PtxU64Register370 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register383);		  // PTX L4050
	ReduceHalf4(r_PtxU64Register370,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3740R1347, r_MmaAccumulatorHalf2WordAtPtx3740R1348,
						   r_MmaAccumulatorHalf2WordAtPtx3747R1351,
						   r_MmaAccumulatorHalf2WordAtPtx3747R1352));							  // PTX L4052
	r_PtxRegister1641 = uint32_t(r_PtxRegister1638) + uint32_t(384);							  // PTX L4054
	r_PtxU64Register384 = SignExtendWordBits(r_PtxRegister1641);								  // PTX L4055
	r_LaneIndexAtPtx4057 = uint32_t((threadIdx.x & 31u));										  // PTX L4057
	r_PtxU64Register385 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4057)) * int64_t(int32_t(4))); // PTX L4059
	r_PtxU64Register386 = uint64_t(r_PtxU64Register385) + uint64_t(r_PtxU64Register384);		  // PTX L4060
	r_PtxU64Register387 = ShiftLeft(uint64_t(r_PtxU64Register386), uint32_t(2));				  // PTX L4061
	r_PtxU64Register371 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register387);		  // PTX L4062
	ReduceHalf4(r_PtxU64Register371,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3768R1355, r_MmaAccumulatorHalf2WordAtPtx3768R1356,
						   r_MmaAccumulatorHalf2WordAtPtx3775R1359,
						   r_MmaAccumulatorHalf2WordAtPtx3775R1360));		 // PTX L4064
L__BB46_133:																 // PTX L4066
	r_PtxRegister43 = uint32_t(r_PtxRegister40) + uint32_t(3);				 // PTX L4067
	r_bPtxPredicate95 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister3); // PTX L4068
	if (r_bPtxPredicate95)
	{
		goto L__BB46_176;
	} // PTX L4069
	r_PtxRegister1646 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(13));						  // PTX L4070
	r_PtxRegister1647 = uint32_t(r_PtxRegister1646) + uint32_t(r_PtxRegister83);				  // PTX L4071
	r_PtxU64Register392 = SignExtendWordBits(r_PtxRegister1647);								  // PTX L4072
	r_LaneIndexAtPtx4074 = uint32_t((threadIdx.x & 31u));										  // PTX L4074
	r_PtxU64Register393 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4074)) * int64_t(int32_t(4))); // PTX L4076
	r_PtxU64Register394 = uint64_t(r_PtxU64Register393) + uint64_t(r_PtxU64Register392);		  // PTX L4077
	r_PtxU64Register395 = ShiftLeft(uint64_t(r_PtxU64Register394), uint32_t(2));				  // PTX L4078
	r_PtxU64Register388 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register395);		  // PTX L4079
	ReduceHalf4(r_PtxU64Register388,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3796R1367, r_MmaAccumulatorHalf2WordAtPtx3796R1368,
						   r_MmaAccumulatorHalf2WordAtPtx3803R1375,
						   r_MmaAccumulatorHalf2WordAtPtx3803R1376));							  // PTX L4081
	r_PtxRegister1648 = uint32_t(r_PtxRegister1647) + uint32_t(128);							  // PTX L4083
	r_PtxU64Register396 = SignExtendWordBits(r_PtxRegister1648);								  // PTX L4084
	r_LaneIndexAtPtx4086 = uint32_t((threadIdx.x & 31u));										  // PTX L4086
	r_PtxU64Register397 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4086)) * int64_t(int32_t(4))); // PTX L4088
	r_PtxU64Register398 = uint64_t(r_PtxU64Register397) + uint64_t(r_PtxU64Register396);		  // PTX L4089
	r_PtxU64Register399 = ShiftLeft(uint64_t(r_PtxU64Register398), uint32_t(2));				  // PTX L4090
	r_PtxU64Register389 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register399);		  // PTX L4091
	ReduceHalf4(r_PtxU64Register389,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3824R1379, r_MmaAccumulatorHalf2WordAtPtx3824R1380,
						   r_MmaAccumulatorHalf2WordAtPtx3831R1383,
						   r_MmaAccumulatorHalf2WordAtPtx3831R1384));							  // PTX L4093
	r_PtxRegister1649 = uint32_t(r_PtxRegister1647) + uint32_t(256);							  // PTX L4095
	r_PtxU64Register400 = SignExtendWordBits(r_PtxRegister1649);								  // PTX L4096
	r_LaneIndexAtPtx4098 = uint32_t((threadIdx.x & 31u));										  // PTX L4098
	r_PtxU64Register401 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4098)) * int64_t(int32_t(4))); // PTX L4100
	r_PtxU64Register402 = uint64_t(r_PtxU64Register401) + uint64_t(r_PtxU64Register400);		  // PTX L4101
	r_PtxU64Register403 = ShiftLeft(uint64_t(r_PtxU64Register402), uint32_t(2));				  // PTX L4102
	r_PtxU64Register390 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register403);		  // PTX L4103
	ReduceHalf4(r_PtxU64Register390,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3852R1387, r_MmaAccumulatorHalf2WordAtPtx3852R1388,
						   r_MmaAccumulatorHalf2WordAtPtx3859R1391,
						   r_MmaAccumulatorHalf2WordAtPtx3859R1392));							  // PTX L4105
	r_PtxRegister1650 = uint32_t(r_PtxRegister1647) + uint32_t(384);							  // PTX L4107
	r_PtxU64Register404 = SignExtendWordBits(r_PtxRegister1650);								  // PTX L4108
	r_LaneIndexAtPtx4110 = uint32_t((threadIdx.x & 31u));										  // PTX L4110
	r_PtxU64Register405 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4110)) * int64_t(int32_t(4))); // PTX L4112
	r_PtxU64Register406 = uint64_t(r_PtxU64Register405) + uint64_t(r_PtxU64Register404);		  // PTX L4113
	r_PtxU64Register407 = ShiftLeft(uint64_t(r_PtxU64Register406), uint32_t(2));				  // PTX L4114
	r_PtxU64Register391 = uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register407);		  // PTX L4115
	ReduceHalf4(r_PtxU64Register391,
				make_uint4(r_MmaAccumulatorHalf2WordAtPtx3880R1395, r_MmaAccumulatorHalf2WordAtPtx3880R1396,
						   r_MmaAccumulatorHalf2WordAtPtx3887R1399,
						   r_MmaAccumulatorHalf2WordAtPtx3887R1400));						   // PTX L4117
	goto L__BB46_176;																		   // PTX L4119
L__BB46_119:																				   // PTX L4120
	r_PtxRegister39 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2);					   // PTX L4121
	r_bPtxPredicate96 = int32_t(r_PtxRegister39) >= int32_t(r_PtxRegister3);				   // PTX L4122
	r_PtxRegister1652 = ShiftLeft(uint32_t(r_PtxRegister39), uint32_t(13));					   // PTX L4123
	r_PtxRegister1653 = uint32_t(r_PtxRegister1652) + uint32_t(r_PtxRegister83);			   // PTX L4124
	r_PtxU64Register408 = uint64_t(int64_t(int32_t(r_PtxRegister1653)) * int64_t(int32_t(4))); // PTX L4125
	g_ScratchByteAddressAtPtx4126 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register408); // PTX L4126
	if (r_bPtxPredicate96)
	{
		goto L__BB46_121;
	} // PTX L4127
	r_LaneIndexAtPtx4129 = uint32_t((threadIdx.x & 31u)); // PTX L4129
	r_PtxU64Register413 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4129)) * int64_t(int32_t(16))); // PTX L4131
	g_ScratchByteAddressAtPtx4132 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register413); // PTX L4132
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_ScratchByteAddressAtPtx4132,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3460R1247,
							   r_MmaAccumulatorHalf2WordAtPtx3460R1248,
							   r_MmaAccumulatorHalf2WordAtPtx3467R1255,
							   r_MmaAccumulatorHalf2WordAtPtx3467R1256)); // PTX L4134
	r_LaneIndexAtPtx4137 = uint32_t((threadIdx.x & 31u));				  // PTX L4137
	r_PtxU64Register414 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4137)) * int64_t(int32_t(16))); // PTX L4139
	g_ScratchByteAddressAtPtx4140 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register414);			 // PTX L4140
	g_ScratchByteAddressAtPtx4141 = uint64_t(g_ScratchByteAddressAtPtx4140) + uint64_t(512); // PTX L4141
	StoreNoAllocate(g_ScratchByteAddressAtPtx4141,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3488R1259,
							   r_MmaAccumulatorHalf2WordAtPtx3488R1260,
							   r_MmaAccumulatorHalf2WordAtPtx3495R1263,
							   r_MmaAccumulatorHalf2WordAtPtx3495R1264)); // PTX L4143
	r_LaneIndexAtPtx4146 = uint32_t((threadIdx.x & 31u));				  // PTX L4146
	r_PtxU64Register416 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4146)) * int64_t(int32_t(16))); // PTX L4148
	g_ScratchByteAddressAtPtx4149 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register416);			  // PTX L4149
	g_ScratchByteAddressAtPtx4150 = uint64_t(g_ScratchByteAddressAtPtx4149) + uint64_t(1024); // PTX L4150
	StoreNoAllocate(g_ScratchByteAddressAtPtx4150,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3516R1267,
							   r_MmaAccumulatorHalf2WordAtPtx3516R1268,
							   r_MmaAccumulatorHalf2WordAtPtx3523R1271,
							   r_MmaAccumulatorHalf2WordAtPtx3523R1272)); // PTX L4152
	r_LaneIndexAtPtx4155 = uint32_t((threadIdx.x & 31u));				  // PTX L4155
	r_PtxU64Register418 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4155)) * int64_t(int32_t(16))); // PTX L4157
	g_ScratchByteAddressAtPtx4158 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register418);			  // PTX L4158
	g_ScratchByteAddressAtPtx4159 = uint64_t(g_ScratchByteAddressAtPtx4158) + uint64_t(1536); // PTX L4159
	StoreNoAllocate(g_ScratchByteAddressAtPtx4159,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3544R1275,
							   r_MmaAccumulatorHalf2WordAtPtx3544R1276,
							   r_MmaAccumulatorHalf2WordAtPtx3551R1279,
							   r_MmaAccumulatorHalf2WordAtPtx3551R1280));					   // PTX L4161
L__BB46_121:																				   // PTX L4163
	r_PtxRegister1658 = uint32_t(r_PtxRegister39) + uint32_t(1);							   // PTX L4164
	r_bPtxPredicate97 = int32_t(r_PtxRegister1658) >= int32_t(r_PtxRegister3);				   // PTX L4165
	g_ScratchByteAddressAtPtx4166 = uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(32768); // PTX L4166
	if (r_bPtxPredicate97)
	{
		goto L__BB46_123;
	} // PTX L4167
	r_LaneIndexAtPtx4169 = uint32_t((threadIdx.x & 31u)); // PTX L4169
	r_PtxU64Register424 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4169)) * int64_t(int32_t(16))); // PTX L4171
	g_ScratchByteAddressAtPtx4172 =
		uint64_t(g_ScratchByteAddressAtPtx4166) + uint64_t(r_PtxU64Register424); // PTX L4172
	StoreNoAllocate(g_ScratchByteAddressAtPtx4172,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3572R1287,
							   r_MmaAccumulatorHalf2WordAtPtx3572R1288,
							   r_MmaAccumulatorHalf2WordAtPtx3579R1295,
							   r_MmaAccumulatorHalf2WordAtPtx3579R1296)); // PTX L4174
	r_LaneIndexAtPtx4177 = uint32_t((threadIdx.x & 31u));				  // PTX L4177
	r_PtxU64Register425 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4177)) * int64_t(int32_t(16))); // PTX L4179
	g_ScratchByteAddressAtPtx4180 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register425);			   // PTX L4180
	g_ScratchByteAddressAtPtx4181 = uint64_t(g_ScratchByteAddressAtPtx4180) + uint64_t(33280); // PTX L4181
	StoreNoAllocate(g_ScratchByteAddressAtPtx4181,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3600R1299,
							   r_MmaAccumulatorHalf2WordAtPtx3600R1300,
							   r_MmaAccumulatorHalf2WordAtPtx3607R1303,
							   r_MmaAccumulatorHalf2WordAtPtx3607R1304)); // PTX L4183
	r_LaneIndexAtPtx4186 = uint32_t((threadIdx.x & 31u));				  // PTX L4186
	r_PtxU64Register427 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4186)) * int64_t(int32_t(16))); // PTX L4188
	g_ScratchByteAddressAtPtx4189 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register427);			   // PTX L4189
	g_ScratchByteAddressAtPtx4190 = uint64_t(g_ScratchByteAddressAtPtx4189) + uint64_t(33792); // PTX L4190
	StoreNoAllocate(g_ScratchByteAddressAtPtx4190,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3628R1307,
							   r_MmaAccumulatorHalf2WordAtPtx3628R1308,
							   r_MmaAccumulatorHalf2WordAtPtx3635R1311,
							   r_MmaAccumulatorHalf2WordAtPtx3635R1312)); // PTX L4192
	r_LaneIndexAtPtx4195 = uint32_t((threadIdx.x & 31u));				  // PTX L4195
	r_PtxU64Register429 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4195)) * int64_t(int32_t(16))); // PTX L4197
	g_ScratchByteAddressAtPtx4198 =
		uint64_t(g_ScratchByteAddressAtPtx4126) + uint64_t(r_PtxU64Register429);			   // PTX L4198
	g_ScratchByteAddressAtPtx4199 = uint64_t(g_ScratchByteAddressAtPtx4198) + uint64_t(34304); // PTX L4199
	StoreNoAllocate(g_ScratchByteAddressAtPtx4199,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3656R1315,
							   r_MmaAccumulatorHalf2WordAtPtx3656R1316,
							   r_MmaAccumulatorHalf2WordAtPtx3663R1319,
							   r_MmaAccumulatorHalf2WordAtPtx3663R1320));					   // PTX L4201
L__BB46_123:																				   // PTX L4203
	r_PtxRegister1663 = uint32_t(r_PtxRegister39) + uint32_t(2);							   // PTX L4204
	r_bPtxPredicate98 = int32_t(r_PtxRegister1663) >= int32_t(r_PtxRegister3);				   // PTX L4205
	g_ScratchByteAddressAtPtx4206 = uint64_t(g_ScratchByteAddressAtPtx4166) + uint64_t(32768); // PTX L4206
	if (r_bPtxPredicate98)
	{
		goto L__BB46_125;
	} // PTX L4207
	r_LaneIndexAtPtx4209 = uint32_t((threadIdx.x & 31u)); // PTX L4209
	r_PtxU64Register435 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4209)) * int64_t(int32_t(16))); // PTX L4211
	g_ScratchByteAddressAtPtx4212 =
		uint64_t(g_ScratchByteAddressAtPtx4206) + uint64_t(r_PtxU64Register435); // PTX L4212
	StoreNoAllocate(g_ScratchByteAddressAtPtx4212,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3684R1327,
							   r_MmaAccumulatorHalf2WordAtPtx3684R1328,
							   r_MmaAccumulatorHalf2WordAtPtx3691R1335,
							   r_MmaAccumulatorHalf2WordAtPtx3691R1336)); // PTX L4214
	r_LaneIndexAtPtx4217 = uint32_t((threadIdx.x & 31u));				  // PTX L4217
	r_PtxU64Register436 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4217)) * int64_t(int32_t(16))); // PTX L4219
	g_ScratchByteAddressAtPtx4220 =
		uint64_t(g_ScratchByteAddressAtPtx4166) + uint64_t(r_PtxU64Register436);			   // PTX L4220
	g_ScratchByteAddressAtPtx4221 = uint64_t(g_ScratchByteAddressAtPtx4220) + uint64_t(33280); // PTX L4221
	StoreNoAllocate(g_ScratchByteAddressAtPtx4221,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3712R1339,
							   r_MmaAccumulatorHalf2WordAtPtx3712R1340,
							   r_MmaAccumulatorHalf2WordAtPtx3719R1343,
							   r_MmaAccumulatorHalf2WordAtPtx3719R1344)); // PTX L4223
	r_LaneIndexAtPtx4226 = uint32_t((threadIdx.x & 31u));				  // PTX L4226
	r_PtxU64Register438 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4226)) * int64_t(int32_t(16))); // PTX L4228
	g_ScratchByteAddressAtPtx4229 =
		uint64_t(g_ScratchByteAddressAtPtx4166) + uint64_t(r_PtxU64Register438);			   // PTX L4229
	g_ScratchByteAddressAtPtx4230 = uint64_t(g_ScratchByteAddressAtPtx4229) + uint64_t(33792); // PTX L4230
	StoreNoAllocate(g_ScratchByteAddressAtPtx4230,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3740R1347,
							   r_MmaAccumulatorHalf2WordAtPtx3740R1348,
							   r_MmaAccumulatorHalf2WordAtPtx3747R1351,
							   r_MmaAccumulatorHalf2WordAtPtx3747R1352)); // PTX L4232
	r_LaneIndexAtPtx4235 = uint32_t((threadIdx.x & 31u));				  // PTX L4235
	r_PtxU64Register440 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4235)) * int64_t(int32_t(16))); // PTX L4237
	g_ScratchByteAddressAtPtx4238 =
		uint64_t(g_ScratchByteAddressAtPtx4166) + uint64_t(r_PtxU64Register440);			   // PTX L4238
	g_ScratchByteAddressAtPtx4239 = uint64_t(g_ScratchByteAddressAtPtx4238) + uint64_t(34304); // PTX L4239
	StoreNoAllocate(g_ScratchByteAddressAtPtx4239,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3768R1355,
							   r_MmaAccumulatorHalf2WordAtPtx3768R1356,
							   r_MmaAccumulatorHalf2WordAtPtx3775R1359,
							   r_MmaAccumulatorHalf2WordAtPtx3775R1360));	   // PTX L4241
L__BB46_125:																   // PTX L4243
	r_PtxRegister1668 = uint32_t(r_PtxRegister39) + uint32_t(3);			   // PTX L4244
	r_bPtxPredicate99 = int32_t(r_PtxRegister1668) >= int32_t(r_PtxRegister3); // PTX L4245
	if (r_bPtxPredicate99)
	{
		goto L__BB46_176;
	} // PTX L4246
	r_LaneIndexAtPtx4248 = uint32_t((threadIdx.x & 31u)); // PTX L4248
	r_PtxU64Register446 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4248)) * int64_t(int32_t(16))); // PTX L4250
	g_ScratchByteAddressAtPtx4251 =
		uint64_t(g_ScratchByteAddressAtPtx4206) + uint64_t(r_PtxU64Register446);			   // PTX L4251
	g_ScratchByteAddressAtPtx4252 = uint64_t(g_ScratchByteAddressAtPtx4251) + uint64_t(32768); // PTX L4252
	StoreNoAllocate(g_ScratchByteAddressAtPtx4252,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3796R1367,
							   r_MmaAccumulatorHalf2WordAtPtx3796R1368,
							   r_MmaAccumulatorHalf2WordAtPtx3803R1375,
							   r_MmaAccumulatorHalf2WordAtPtx3803R1376)); // PTX L4254
	r_LaneIndexAtPtx4257 = uint32_t((threadIdx.x & 31u));				  // PTX L4257
	r_PtxU64Register448 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4257)) * int64_t(int32_t(16))); // PTX L4259
	g_ScratchByteAddressAtPtx4260 =
		uint64_t(g_ScratchByteAddressAtPtx4206) + uint64_t(r_PtxU64Register448);			   // PTX L4260
	g_ScratchByteAddressAtPtx4261 = uint64_t(g_ScratchByteAddressAtPtx4260) + uint64_t(33280); // PTX L4261
	StoreNoAllocate(g_ScratchByteAddressAtPtx4261,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3824R1379,
							   r_MmaAccumulatorHalf2WordAtPtx3824R1380,
							   r_MmaAccumulatorHalf2WordAtPtx3831R1383,
							   r_MmaAccumulatorHalf2WordAtPtx3831R1384)); // PTX L4263
	r_LaneIndexAtPtx4266 = uint32_t((threadIdx.x & 31u));				  // PTX L4266
	r_PtxU64Register450 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4266)) * int64_t(int32_t(16))); // PTX L4268
	g_ScratchByteAddressAtPtx4269 =
		uint64_t(g_ScratchByteAddressAtPtx4206) + uint64_t(r_PtxU64Register450);			   // PTX L4269
	g_ScratchByteAddressAtPtx4270 = uint64_t(g_ScratchByteAddressAtPtx4269) + uint64_t(33792); // PTX L4270
	StoreNoAllocate(g_ScratchByteAddressAtPtx4270,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3852R1387,
							   r_MmaAccumulatorHalf2WordAtPtx3852R1388,
							   r_MmaAccumulatorHalf2WordAtPtx3859R1391,
							   r_MmaAccumulatorHalf2WordAtPtx3859R1392)); // PTX L4272
	r_LaneIndexAtPtx4275 = uint32_t((threadIdx.x & 31u));				  // PTX L4275
	r_PtxU64Register452 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4275)) * int64_t(int32_t(16))); // PTX L4277
	g_ScratchByteAddressAtPtx4278 =
		uint64_t(g_ScratchByteAddressAtPtx4206) + uint64_t(r_PtxU64Register452);			   // PTX L4278
	g_ScratchByteAddressAtPtx4279 = uint64_t(g_ScratchByteAddressAtPtx4278) + uint64_t(34304); // PTX L4279
	StoreNoAllocate(g_ScratchByteAddressAtPtx4279,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx3880R1395,
							   r_MmaAccumulatorHalf2WordAtPtx3880R1396,
							   r_MmaAccumulatorHalf2WordAtPtx3887R1399,
							   r_MmaAccumulatorHalf2WordAtPtx3887R1400));					   // PTX L4281
	goto L__BB46_176;																		   // PTX L4283
L__BB46_136:																				   // PTX L4284
	r_PtxRegister44 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2);					   // PTX L4285
	r_bPtxPredicate73 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister3);				   // PTX L4286
	r_PtxRegister1426 = ShiftLeft(uint32_t(r_PtxRegister44), uint32_t(13));					   // PTX L4287
	r_PtxRegister1427 = uint32_t(r_PtxRegister1426) + uint32_t(r_PtxRegister83);			   // PTX L4288
	r_PtxU64Register272 = uint64_t(int64_t(int32_t(r_PtxRegister1427)) * int64_t(int32_t(4))); // PTX L4289
	g_ScratchByteAddressAtPtx4290 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register272);	 // PTX L4290
	r_PackedHalf2AtPtx4291R1812 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4291
	r_PackedHalf2AtPtx4292R1813 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4292
	r_PackedHalf2AtPtx4293R1814 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4293
	r_PackedHalf2AtPtx4294R1815 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4294
	if (r_bPtxPredicate73)
	{
		goto L__BB46_138;
	} // PTX L4295
	r_LaneIndexAtPtx4297 = uint32_t((threadIdx.x & 31u)); // PTX L4297
	r_PtxU64Register274 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4297)) * int64_t(int32_t(16))); // PTX L4299
	g_ScratchByteAddressAtPtx4300 =
		uint64_t(g_ScratchByteAddressAtPtx4290) + uint64_t(r_PtxU64Register274); // PTX L4300
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4300));
		r_PackedHalf2AtPtx4291R1812 = r_Value.x;
		r_PackedHalf2AtPtx4292R1813 = r_Value.y;
		r_PackedHalf2AtPtx4293R1814 = r_Value.z;
		r_PackedHalf2AtPtx4294R1815 = r_Value.w;
	} // PTX L4302
L__BB46_138:																				 // PTX L4304
	r_bPtxPredicate74 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister3);				 // PTX L4305
	g_ScratchByteAddressAtPtx4306 = uint64_t(g_ScratchByteAddressAtPtx4290) + uint64_t(512); // PTX L4306
	r_PackedHalf2AtPtx4307R1816 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4307
	r_PackedHalf2AtPtx4308R1817 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4308
	r_PackedHalf2AtPtx4309R1818 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4309
	r_PackedHalf2AtPtx4310R1819 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4310
	if (r_bPtxPredicate74)
	{
		goto L__BB46_140;
	} // PTX L4311
	r_LaneIndexAtPtx4313 = uint32_t((threadIdx.x & 31u)); // PTX L4313
	r_PtxU64Register276 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4313)) * int64_t(int32_t(16))); // PTX L4315
	g_ScratchByteAddressAtPtx4316 =
		uint64_t(g_ScratchByteAddressAtPtx4306) + uint64_t(r_PtxU64Register276); // PTX L4316
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4316));
		r_PackedHalf2AtPtx4307R1816 = r_Value.x;
		r_PackedHalf2AtPtx4308R1817 = r_Value.y;
		r_PackedHalf2AtPtx4309R1818 = r_Value.z;
		r_PackedHalf2AtPtx4310R1819 = r_Value.w;
	} // PTX L4318
L__BB46_140:																				 // PTX L4320
	r_bPtxPredicate75 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister3);				 // PTX L4321
	g_ScratchByteAddressAtPtx4322 = uint64_t(g_ScratchByteAddressAtPtx4306) + uint64_t(512); // PTX L4322
	r_PackedHalf2AtPtx4323R1820 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4323
	r_PackedHalf2AtPtx4324R1821 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4324
	r_PackedHalf2AtPtx4325R1822 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4325
	r_PackedHalf2AtPtx4326R1823 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4326
	if (r_bPtxPredicate75)
	{
		goto L__BB46_142;
	} // PTX L4327
	r_LaneIndexAtPtx4329 = uint32_t((threadIdx.x & 31u)); // PTX L4329
	r_PtxU64Register278 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4329)) * int64_t(int32_t(16))); // PTX L4331
	g_ScratchByteAddressAtPtx4332 =
		uint64_t(g_ScratchByteAddressAtPtx4322) + uint64_t(r_PtxU64Register278); // PTX L4332
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4332));
		r_PackedHalf2AtPtx4323R1820 = r_Value.x;
		r_PackedHalf2AtPtx4324R1821 = r_Value.y;
		r_PackedHalf2AtPtx4325R1822 = r_Value.z;
		r_PackedHalf2AtPtx4326R1823 = r_Value.w;
	} // PTX L4334
L__BB46_142:																				 // PTX L4336
	r_bPtxPredicate76 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister3);				 // PTX L4337
	g_ScratchByteAddressAtPtx4338 = uint64_t(g_ScratchByteAddressAtPtx4322) + uint64_t(512); // PTX L4338
	r_PackedHalf2AtPtx4339R1824 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4339
	r_PackedHalf2AtPtx4340R1825 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4340
	r_PackedHalf2AtPtx4341R1826 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4341
	r_PackedHalf2AtPtx4342R1827 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4342
	if (r_bPtxPredicate76)
	{
		goto L__BB46_144;
	} // PTX L4343
	r_LaneIndexAtPtx4345 = uint32_t((threadIdx.x & 31u)); // PTX L4345
	r_PtxU64Register280 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4345)) * int64_t(int32_t(16))); // PTX L4347
	g_ScratchByteAddressAtPtx4348 =
		uint64_t(g_ScratchByteAddressAtPtx4338) + uint64_t(r_PtxU64Register280); // PTX L4348
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4348));
		r_PackedHalf2AtPtx4339R1824 = r_Value.x;
		r_PackedHalf2AtPtx4340R1825 = r_Value.y;
		r_PackedHalf2AtPtx4341R1826 = r_Value.z;
		r_PackedHalf2AtPtx4342R1827 = r_Value.w;
	} // PTX L4350
L__BB46_144:																				   // PTX L4352
	r_PtxRegister45 = uint32_t(r_PtxRegister44) + uint32_t(1);								   // PTX L4353
	r_bPtxPredicate77 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister3);				   // PTX L4354
	g_ScratchByteAddressAtPtx4355 = uint64_t(g_ScratchByteAddressAtPtx4338) + uint64_t(31232); // PTX L4355
	r_PackedHalf2AtPtx4356R1828 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4356
	r_PackedHalf2AtPtx4357R1829 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4357
	r_PackedHalf2AtPtx4358R1830 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4358
	r_PackedHalf2AtPtx4359R1831 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4359
	if (r_bPtxPredicate77)
	{
		goto L__BB46_146;
	} // PTX L4360
	r_LaneIndexAtPtx4362 = uint32_t((threadIdx.x & 31u)); // PTX L4362
	r_PtxU64Register282 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4362)) * int64_t(int32_t(16))); // PTX L4364
	g_ScratchByteAddressAtPtx4365 =
		uint64_t(g_ScratchByteAddressAtPtx4355) + uint64_t(r_PtxU64Register282); // PTX L4365
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4365));
		r_PackedHalf2AtPtx4356R1828 = r_Value.x;
		r_PackedHalf2AtPtx4357R1829 = r_Value.y;
		r_PackedHalf2AtPtx4358R1830 = r_Value.z;
		r_PackedHalf2AtPtx4359R1831 = r_Value.w;
	} // PTX L4367
L__BB46_146:																				 // PTX L4369
	r_bPtxPredicate78 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister3);				 // PTX L4370
	g_ScratchByteAddressAtPtx4371 = uint64_t(g_ScratchByteAddressAtPtx4355) + uint64_t(512); // PTX L4371
	r_PackedHalf2AtPtx4372R1832 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4372
	r_PackedHalf2AtPtx4373R1833 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4373
	r_PackedHalf2AtPtx4374R1834 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4374
	r_PackedHalf2AtPtx4375R1835 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4375
	if (r_bPtxPredicate78)
	{
		goto L__BB46_148;
	} // PTX L4376
	r_LaneIndexAtPtx4378 = uint32_t((threadIdx.x & 31u)); // PTX L4378
	r_PtxU64Register284 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4378)) * int64_t(int32_t(16))); // PTX L4380
	g_ScratchByteAddressAtPtx4381 =
		uint64_t(g_ScratchByteAddressAtPtx4371) + uint64_t(r_PtxU64Register284); // PTX L4381
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4381));
		r_PackedHalf2AtPtx4372R1832 = r_Value.x;
		r_PackedHalf2AtPtx4373R1833 = r_Value.y;
		r_PackedHalf2AtPtx4374R1834 = r_Value.z;
		r_PackedHalf2AtPtx4375R1835 = r_Value.w;
	} // PTX L4383
L__BB46_148:																				 // PTX L4385
	r_bPtxPredicate79 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister3);				 // PTX L4386
	g_ScratchByteAddressAtPtx4387 = uint64_t(g_ScratchByteAddressAtPtx4371) + uint64_t(512); // PTX L4387
	r_PackedHalf2AtPtx4388R1836 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4388
	r_PackedHalf2AtPtx4389R1837 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4389
	r_PackedHalf2AtPtx4390R1838 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4390
	r_PackedHalf2AtPtx4391R1839 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4391
	if (r_bPtxPredicate79)
	{
		goto L__BB46_150;
	} // PTX L4392
	r_LaneIndexAtPtx4394 = uint32_t((threadIdx.x & 31u)); // PTX L4394
	r_PtxU64Register286 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4394)) * int64_t(int32_t(16))); // PTX L4396
	g_ScratchByteAddressAtPtx4397 =
		uint64_t(g_ScratchByteAddressAtPtx4387) + uint64_t(r_PtxU64Register286); // PTX L4397
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4397));
		r_PackedHalf2AtPtx4388R1836 = r_Value.x;
		r_PackedHalf2AtPtx4389R1837 = r_Value.y;
		r_PackedHalf2AtPtx4390R1838 = r_Value.z;
		r_PackedHalf2AtPtx4391R1839 = r_Value.w;
	} // PTX L4399
L__BB46_150:																				 // PTX L4401
	r_bPtxPredicate80 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister3);				 // PTX L4402
	g_ScratchByteAddressAtPtx4403 = uint64_t(g_ScratchByteAddressAtPtx4387) + uint64_t(512); // PTX L4403
	r_PackedHalf2AtPtx4404R1840 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4404
	r_PackedHalf2AtPtx4405R1841 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4405
	r_PackedHalf2AtPtx4406R1842 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4406
	r_PackedHalf2AtPtx4407R1843 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4407
	if (r_bPtxPredicate80)
	{
		goto L__BB46_152;
	} // PTX L4408
	r_LaneIndexAtPtx4410 = uint32_t((threadIdx.x & 31u)); // PTX L4410
	r_PtxU64Register288 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4410)) * int64_t(int32_t(16))); // PTX L4412
	g_ScratchByteAddressAtPtx4413 =
		uint64_t(g_ScratchByteAddressAtPtx4403) + uint64_t(r_PtxU64Register288); // PTX L4413
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4413));
		r_PackedHalf2AtPtx4404R1840 = r_Value.x;
		r_PackedHalf2AtPtx4405R1841 = r_Value.y;
		r_PackedHalf2AtPtx4406R1842 = r_Value.z;
		r_PackedHalf2AtPtx4407R1843 = r_Value.w;
	} // PTX L4415
L__BB46_152:																				   // PTX L4417
	r_PtxRegister46 = uint32_t(r_PtxRegister44) + uint32_t(2);								   // PTX L4418
	r_bPtxPredicate81 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister3);				   // PTX L4419
	g_ScratchByteAddressAtPtx4420 = uint64_t(g_ScratchByteAddressAtPtx4403) + uint64_t(31232); // PTX L4420
	r_PackedHalf2AtPtx4421R1844 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4421
	r_PackedHalf2AtPtx4422R1845 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4422
	r_PackedHalf2AtPtx4423R1846 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4423
	r_PackedHalf2AtPtx4424R1847 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4424
	if (r_bPtxPredicate81)
	{
		goto L__BB46_154;
	} // PTX L4425
	r_LaneIndexAtPtx4427 = uint32_t((threadIdx.x & 31u)); // PTX L4427
	r_PtxU64Register290 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4427)) * int64_t(int32_t(16))); // PTX L4429
	g_ScratchByteAddressAtPtx4430 =
		uint64_t(g_ScratchByteAddressAtPtx4420) + uint64_t(r_PtxU64Register290); // PTX L4430
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4430));
		r_PackedHalf2AtPtx4421R1844 = r_Value.x;
		r_PackedHalf2AtPtx4422R1845 = r_Value.y;
		r_PackedHalf2AtPtx4423R1846 = r_Value.z;
		r_PackedHalf2AtPtx4424R1847 = r_Value.w;
	} // PTX L4432
L__BB46_154:																				 // PTX L4434
	r_bPtxPredicate82 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister3);				 // PTX L4435
	g_ScratchByteAddressAtPtx4436 = uint64_t(g_ScratchByteAddressAtPtx4420) + uint64_t(512); // PTX L4436
	r_PackedHalf2AtPtx4437R1848 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4437
	r_PackedHalf2AtPtx4438R1849 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4438
	r_PackedHalf2AtPtx4439R1850 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4439
	r_PackedHalf2AtPtx4440R1851 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4440
	if (r_bPtxPredicate82)
	{
		goto L__BB46_156;
	} // PTX L4441
	r_LaneIndexAtPtx4443 = uint32_t((threadIdx.x & 31u)); // PTX L4443
	r_PtxU64Register292 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4443)) * int64_t(int32_t(16))); // PTX L4445
	g_ScratchByteAddressAtPtx4446 =
		uint64_t(g_ScratchByteAddressAtPtx4436) + uint64_t(r_PtxU64Register292); // PTX L4446
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4446));
		r_PackedHalf2AtPtx4437R1848 = r_Value.x;
		r_PackedHalf2AtPtx4438R1849 = r_Value.y;
		r_PackedHalf2AtPtx4439R1850 = r_Value.z;
		r_PackedHalf2AtPtx4440R1851 = r_Value.w;
	} // PTX L4448
L__BB46_156:																				 // PTX L4450
	r_bPtxPredicate83 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister3);				 // PTX L4451
	g_ScratchByteAddressAtPtx4452 = uint64_t(g_ScratchByteAddressAtPtx4436) + uint64_t(512); // PTX L4452
	r_PackedHalf2AtPtx4453R1852 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4453
	r_PackedHalf2AtPtx4454R1853 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4454
	r_PackedHalf2AtPtx4455R1854 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4455
	r_PackedHalf2AtPtx4456R1855 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4456
	if (r_bPtxPredicate83)
	{
		goto L__BB46_158;
	} // PTX L4457
	r_LaneIndexAtPtx4459 = uint32_t((threadIdx.x & 31u)); // PTX L4459
	r_PtxU64Register294 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4459)) * int64_t(int32_t(16))); // PTX L4461
	g_ScratchByteAddressAtPtx4462 =
		uint64_t(g_ScratchByteAddressAtPtx4452) + uint64_t(r_PtxU64Register294); // PTX L4462
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4462));
		r_PackedHalf2AtPtx4453R1852 = r_Value.x;
		r_PackedHalf2AtPtx4454R1853 = r_Value.y;
		r_PackedHalf2AtPtx4455R1854 = r_Value.z;
		r_PackedHalf2AtPtx4456R1855 = r_Value.w;
	} // PTX L4464
L__BB46_158:																				 // PTX L4466
	r_bPtxPredicate84 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister3);				 // PTX L4467
	g_ScratchByteAddressAtPtx4468 = uint64_t(g_ScratchByteAddressAtPtx4452) + uint64_t(512); // PTX L4468
	r_PackedHalf2AtPtx4469R1856 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4469
	r_PackedHalf2AtPtx4470R1857 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4470
	r_PackedHalf2AtPtx4471R1858 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4471
	r_PackedHalf2AtPtx4472R1859 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4472
	if (r_bPtxPredicate84)
	{
		goto L__BB46_160;
	} // PTX L4473
	r_LaneIndexAtPtx4475 = uint32_t((threadIdx.x & 31u)); // PTX L4475
	r_PtxU64Register296 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4475)) * int64_t(int32_t(16))); // PTX L4477
	g_ScratchByteAddressAtPtx4478 =
		uint64_t(g_ScratchByteAddressAtPtx4468) + uint64_t(r_PtxU64Register296); // PTX L4478
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4478));
		r_PackedHalf2AtPtx4469R1856 = r_Value.x;
		r_PackedHalf2AtPtx4470R1857 = r_Value.y;
		r_PackedHalf2AtPtx4471R1858 = r_Value.z;
		r_PackedHalf2AtPtx4472R1859 = r_Value.w;
	} // PTX L4480
L__BB46_160:																				   // PTX L4482
	r_PtxRegister47 = uint32_t(r_PtxRegister44) + uint32_t(3);								   // PTX L4483
	r_bPtxPredicate85 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister3);				   // PTX L4484
	g_ScratchByteAddressAtPtx4485 = uint64_t(g_ScratchByteAddressAtPtx4468) + uint64_t(31232); // PTX L4485
	r_PackedHalf2AtPtx4486R1860 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4486
	r_PackedHalf2AtPtx4487R1861 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4487
	r_PackedHalf2AtPtx4488R1862 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4488
	r_PackedHalf2AtPtx4489R1863 = uint32_t(r_PackedHalf2AtPtx4543R1872);					   // PTX L4489
	if (r_bPtxPredicate85)
	{
		goto L__BB46_162;
	} // PTX L4490
	r_LaneIndexAtPtx4492 = uint32_t((threadIdx.x & 31u)); // PTX L4492
	r_PtxU64Register298 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4492)) * int64_t(int32_t(16))); // PTX L4494
	g_ScratchByteAddressAtPtx4495 =
		uint64_t(g_ScratchByteAddressAtPtx4485) + uint64_t(r_PtxU64Register298); // PTX L4495
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4495));
		r_PackedHalf2AtPtx4486R1860 = r_Value.x;
		r_PackedHalf2AtPtx4487R1861 = r_Value.y;
		r_PackedHalf2AtPtx4488R1862 = r_Value.z;
		r_PackedHalf2AtPtx4489R1863 = r_Value.w;
	} // PTX L4497
L__BB46_162:																				 // PTX L4499
	r_bPtxPredicate86 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister3);				 // PTX L4500
	g_ScratchByteAddressAtPtx4501 = uint64_t(g_ScratchByteAddressAtPtx4485) + uint64_t(512); // PTX L4501
	r_PackedHalf2AtPtx4502R1864 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4502
	r_PackedHalf2AtPtx4503R1865 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4503
	r_PackedHalf2AtPtx4504R1866 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4504
	r_PackedHalf2AtPtx4505R1867 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4505
	if (r_bPtxPredicate86)
	{
		goto L__BB46_164;
	} // PTX L4506
	r_LaneIndexAtPtx4508 = uint32_t((threadIdx.x & 31u)); // PTX L4508
	r_PtxU64Register300 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4508)) * int64_t(int32_t(16))); // PTX L4510
	g_ScratchByteAddressAtPtx4511 =
		uint64_t(g_ScratchByteAddressAtPtx4501) + uint64_t(r_PtxU64Register300); // PTX L4511
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4511));
		r_PackedHalf2AtPtx4502R1864 = r_Value.x;
		r_PackedHalf2AtPtx4503R1865 = r_Value.y;
		r_PackedHalf2AtPtx4504R1866 = r_Value.z;
		r_PackedHalf2AtPtx4505R1867 = r_Value.w;
	} // PTX L4513
L__BB46_164:																				 // PTX L4515
	r_bPtxPredicate87 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister3);				 // PTX L4516
	g_ScratchByteAddressAtPtx4517 = uint64_t(g_ScratchByteAddressAtPtx4501) + uint64_t(512); // PTX L4517
	r_PackedHalf2AtPtx4518R1868 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4518
	r_PackedHalf2AtPtx4519R1869 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4519
	r_PackedHalf2AtPtx4520R1870 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4520
	r_PackedHalf2AtPtx4521R1871 = uint32_t(r_PackedHalf2AtPtx4543R1872);					 // PTX L4521
	if (r_bPtxPredicate87)
	{
		goto L__BB46_166;
	} // PTX L4522
	r_LaneIndexAtPtx4524 = uint32_t((threadIdx.x & 31u)); // PTX L4524
	r_PtxU64Register302 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4524)) * int64_t(int32_t(16))); // PTX L4526
	g_ScratchByteAddressAtPtx4527 =
		uint64_t(g_ScratchByteAddressAtPtx4517) + uint64_t(r_PtxU64Register302); // PTX L4527
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4527));
		r_PackedHalf2AtPtx4518R1868 = r_Value.x;
		r_PackedHalf2AtPtx4519R1869 = r_Value.y;
		r_PackedHalf2AtPtx4520R1870 = r_Value.z;
		r_PackedHalf2AtPtx4521R1871 = r_Value.w;
	} // PTX L4529
L__BB46_166:															 // PTX L4531
	r_PackedHalf2AtPtx4532R1873 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4532
	r_PackedHalf2AtPtx4533R1874 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4533
	r_PackedHalf2AtPtx4534R1875 = uint32_t(r_PackedHalf2AtPtx4543R1872); // PTX L4534
	if (r_bPtxPredicate87)
	{
		goto L__BB46_168;
	} // PTX L4535
	r_LaneIndexAtPtx4537 = uint32_t((threadIdx.x & 31u)); // PTX L4537
	r_PtxU64Register304 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4537)) * int64_t(int32_t(16))); // PTX L4539
	g_ScratchByteAddressAtPtx4540 =
		uint64_t(g_ScratchByteAddressAtPtx4517) + uint64_t(r_PtxU64Register304);			 // PTX L4540
	g_ScratchByteAddressAtPtx4541 = uint64_t(g_ScratchByteAddressAtPtx4540) + uint64_t(512); // PTX L4541
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx4541));
		r_PackedHalf2AtPtx4543R1872 = r_Value.x;
		r_PackedHalf2AtPtx4532R1873 = r_Value.y;
		r_PackedHalf2AtPtx4533R1874 = r_Value.z;
		r_PackedHalf2AtPtx4534R1875 = r_Value.w;
	} // PTX L4543
L__BB46_168:																 // PTX L4545
	r_bPtxPredicate88 = int32_t(r_PtxRegister44) >= int32_t(r_PtxRegister3); // PTX L4546
	r_LaneIndexAtPtx4548 = uint32_t((threadIdx.x & 31u));					 // PTX L4548
	r_PackedHalf2AtPtx4551R1508 =
		HalfAdd(r_PackedHalf2AtPtx4291R1812, r_MmaAccumulatorHalf2WordAtPtx3460R1247); // PTX L4551
	r_LaneIndexAtPtx4555 = uint32_t((threadIdx.x & 31u));							   // PTX L4555
	r_PackedHalf2AtPtx4558R1510 =
		HalfAdd(r_PackedHalf2AtPtx4292R1813, r_MmaAccumulatorHalf2WordAtPtx3460R1248); // PTX L4558
	r_LaneIndexAtPtx4562 = uint32_t((threadIdx.x & 31u));							   // PTX L4562
	r_PackedHalf2AtPtx4565R1509 =
		HalfAdd(r_PackedHalf2AtPtx4293R1814, r_MmaAccumulatorHalf2WordAtPtx3467R1255); // PTX L4565
	r_LaneIndexAtPtx4569 = uint32_t((threadIdx.x & 31u));							   // PTX L4569
	r_PackedHalf2AtPtx4572R1511 =
		HalfAdd(r_PackedHalf2AtPtx4294R1815, r_MmaAccumulatorHalf2WordAtPtx3467R1256); // PTX L4572
	r_LaneIndexAtPtx4576 = uint32_t((threadIdx.x & 31u));							   // PTX L4576
	r_PackedHalf2AtPtx4579R1512 =
		HalfAdd(r_PackedHalf2AtPtx4307R1816, r_MmaAccumulatorHalf2WordAtPtx3488R1259); // PTX L4579
	r_LaneIndexAtPtx4583 = uint32_t((threadIdx.x & 31u));							   // PTX L4583
	r_PackedHalf2AtPtx4586R1514 =
		HalfAdd(r_PackedHalf2AtPtx4308R1817, r_MmaAccumulatorHalf2WordAtPtx3488R1260); // PTX L4586
	r_LaneIndexAtPtx4590 = uint32_t((threadIdx.x & 31u));							   // PTX L4590
	r_PackedHalf2AtPtx4593R1513 =
		HalfAdd(r_PackedHalf2AtPtx4309R1818, r_MmaAccumulatorHalf2WordAtPtx3495R1263); // PTX L4593
	r_LaneIndexAtPtx4597 = uint32_t((threadIdx.x & 31u));							   // PTX L4597
	r_PackedHalf2AtPtx4600R1515 =
		HalfAdd(r_PackedHalf2AtPtx4310R1819, r_MmaAccumulatorHalf2WordAtPtx3495R1264); // PTX L4600
	r_LaneIndexAtPtx4604 = uint32_t((threadIdx.x & 31u));							   // PTX L4604
	r_PackedHalf2AtPtx4607R1516 =
		HalfAdd(r_PackedHalf2AtPtx4323R1820, r_MmaAccumulatorHalf2WordAtPtx3516R1267); // PTX L4607
	r_LaneIndexAtPtx4611 = uint32_t((threadIdx.x & 31u));							   // PTX L4611
	r_PackedHalf2AtPtx4614R1518 =
		HalfAdd(r_PackedHalf2AtPtx4324R1821, r_MmaAccumulatorHalf2WordAtPtx3516R1268); // PTX L4614
	r_LaneIndexAtPtx4618 = uint32_t((threadIdx.x & 31u));							   // PTX L4618
	r_PackedHalf2AtPtx4621R1517 =
		HalfAdd(r_PackedHalf2AtPtx4325R1822, r_MmaAccumulatorHalf2WordAtPtx3523R1271); // PTX L4621
	r_LaneIndexAtPtx4625 = uint32_t((threadIdx.x & 31u));							   // PTX L4625
	r_PackedHalf2AtPtx4628R1519 =
		HalfAdd(r_PackedHalf2AtPtx4326R1823, r_MmaAccumulatorHalf2WordAtPtx3523R1272); // PTX L4628
	r_LaneIndexAtPtx4632 = uint32_t((threadIdx.x & 31u));							   // PTX L4632
	r_PackedHalf2AtPtx4635R1520 =
		HalfAdd(r_PackedHalf2AtPtx4339R1824, r_MmaAccumulatorHalf2WordAtPtx3544R1275); // PTX L4635
	r_LaneIndexAtPtx4639 = uint32_t((threadIdx.x & 31u));							   // PTX L4639
	r_PackedHalf2AtPtx4642R1522 =
		HalfAdd(r_PackedHalf2AtPtx4340R1825, r_MmaAccumulatorHalf2WordAtPtx3544R1276); // PTX L4642
	r_LaneIndexAtPtx4646 = uint32_t((threadIdx.x & 31u));							   // PTX L4646
	r_PackedHalf2AtPtx4649R1521 =
		HalfAdd(r_PackedHalf2AtPtx4341R1826, r_MmaAccumulatorHalf2WordAtPtx3551R1279); // PTX L4649
	r_LaneIndexAtPtx4653 = uint32_t((threadIdx.x & 31u));							   // PTX L4653
	r_PackedHalf2AtPtx4656R1523 =
		HalfAdd(r_PackedHalf2AtPtx4342R1827, r_MmaAccumulatorHalf2WordAtPtx3551R1280); // PTX L4656
	r_LaneIndexAtPtx4660 = uint32_t((threadIdx.x & 31u));							   // PTX L4660
	r_PackedHalf2AtPtx4663R1524 =
		HalfAdd(r_PackedHalf2AtPtx4356R1828, r_MmaAccumulatorHalf2WordAtPtx3572R1287); // PTX L4663
	r_LaneIndexAtPtx4667 = uint32_t((threadIdx.x & 31u));							   // PTX L4667
	r_PackedHalf2AtPtx4670R1526 =
		HalfAdd(r_PackedHalf2AtPtx4357R1829, r_MmaAccumulatorHalf2WordAtPtx3572R1288); // PTX L4670
	r_LaneIndexAtPtx4674 = uint32_t((threadIdx.x & 31u));							   // PTX L4674
	r_PackedHalf2AtPtx4677R1525 =
		HalfAdd(r_PackedHalf2AtPtx4358R1830, r_MmaAccumulatorHalf2WordAtPtx3579R1295); // PTX L4677
	r_LaneIndexAtPtx4681 = uint32_t((threadIdx.x & 31u));							   // PTX L4681
	r_PackedHalf2AtPtx4684R1527 =
		HalfAdd(r_PackedHalf2AtPtx4359R1831, r_MmaAccumulatorHalf2WordAtPtx3579R1296); // PTX L4684
	r_LaneIndexAtPtx4688 = uint32_t((threadIdx.x & 31u));							   // PTX L4688
	r_PackedHalf2AtPtx4691R1528 =
		HalfAdd(r_PackedHalf2AtPtx4372R1832, r_MmaAccumulatorHalf2WordAtPtx3600R1299); // PTX L4691
	r_LaneIndexAtPtx4695 = uint32_t((threadIdx.x & 31u));							   // PTX L4695
	r_PackedHalf2AtPtx4698R1530 =
		HalfAdd(r_PackedHalf2AtPtx4373R1833, r_MmaAccumulatorHalf2WordAtPtx3600R1300); // PTX L4698
	r_LaneIndexAtPtx4702 = uint32_t((threadIdx.x & 31u));							   // PTX L4702
	r_PackedHalf2AtPtx4705R1529 =
		HalfAdd(r_PackedHalf2AtPtx4374R1834, r_MmaAccumulatorHalf2WordAtPtx3607R1303); // PTX L4705
	r_LaneIndexAtPtx4709 = uint32_t((threadIdx.x & 31u));							   // PTX L4709
	r_PackedHalf2AtPtx4712R1531 =
		HalfAdd(r_PackedHalf2AtPtx4375R1835, r_MmaAccumulatorHalf2WordAtPtx3607R1304); // PTX L4712
	r_LaneIndexAtPtx4716 = uint32_t((threadIdx.x & 31u));							   // PTX L4716
	r_PackedHalf2AtPtx4719R1532 =
		HalfAdd(r_PackedHalf2AtPtx4388R1836, r_MmaAccumulatorHalf2WordAtPtx3628R1307); // PTX L4719
	r_LaneIndexAtPtx4723 = uint32_t((threadIdx.x & 31u));							   // PTX L4723
	r_PackedHalf2AtPtx4726R1534 =
		HalfAdd(r_PackedHalf2AtPtx4389R1837, r_MmaAccumulatorHalf2WordAtPtx3628R1308); // PTX L4726
	r_LaneIndexAtPtx4730 = uint32_t((threadIdx.x & 31u));							   // PTX L4730
	r_PackedHalf2AtPtx4733R1533 =
		HalfAdd(r_PackedHalf2AtPtx4390R1838, r_MmaAccumulatorHalf2WordAtPtx3635R1311); // PTX L4733
	r_LaneIndexAtPtx4737 = uint32_t((threadIdx.x & 31u));							   // PTX L4737
	r_PackedHalf2AtPtx4740R1535 =
		HalfAdd(r_PackedHalf2AtPtx4391R1839, r_MmaAccumulatorHalf2WordAtPtx3635R1312); // PTX L4740
	r_LaneIndexAtPtx4744 = uint32_t((threadIdx.x & 31u));							   // PTX L4744
	r_PackedHalf2AtPtx4747R1536 =
		HalfAdd(r_PackedHalf2AtPtx4404R1840, r_MmaAccumulatorHalf2WordAtPtx3656R1315); // PTX L4747
	r_LaneIndexAtPtx4751 = uint32_t((threadIdx.x & 31u));							   // PTX L4751
	r_PackedHalf2AtPtx4754R1538 =
		HalfAdd(r_PackedHalf2AtPtx4405R1841, r_MmaAccumulatorHalf2WordAtPtx3656R1316); // PTX L4754
	r_LaneIndexAtPtx4758 = uint32_t((threadIdx.x & 31u));							   // PTX L4758
	r_PackedHalf2AtPtx4761R1537 =
		HalfAdd(r_PackedHalf2AtPtx4406R1842, r_MmaAccumulatorHalf2WordAtPtx3663R1319); // PTX L4761
	r_LaneIndexAtPtx4765 = uint32_t((threadIdx.x & 31u));							   // PTX L4765
	r_PackedHalf2AtPtx4768R1539 =
		HalfAdd(r_PackedHalf2AtPtx4407R1843, r_MmaAccumulatorHalf2WordAtPtx3663R1320); // PTX L4768
	r_LaneIndexAtPtx4772 = uint32_t((threadIdx.x & 31u));							   // PTX L4772
	r_PackedHalf2AtPtx4775R1540 =
		HalfAdd(r_PackedHalf2AtPtx4421R1844, r_MmaAccumulatorHalf2WordAtPtx3684R1327); // PTX L4775
	r_LaneIndexAtPtx4779 = uint32_t((threadIdx.x & 31u));							   // PTX L4779
	r_PackedHalf2AtPtx4782R1542 =
		HalfAdd(r_PackedHalf2AtPtx4422R1845, r_MmaAccumulatorHalf2WordAtPtx3684R1328); // PTX L4782
	r_LaneIndexAtPtx4786 = uint32_t((threadIdx.x & 31u));							   // PTX L4786
	r_PackedHalf2AtPtx4789R1541 =
		HalfAdd(r_PackedHalf2AtPtx4423R1846, r_MmaAccumulatorHalf2WordAtPtx3691R1335); // PTX L4789
	r_LaneIndexAtPtx4793 = uint32_t((threadIdx.x & 31u));							   // PTX L4793
	r_PackedHalf2AtPtx4796R1543 =
		HalfAdd(r_PackedHalf2AtPtx4424R1847, r_MmaAccumulatorHalf2WordAtPtx3691R1336); // PTX L4796
	r_LaneIndexAtPtx4800 = uint32_t((threadIdx.x & 31u));							   // PTX L4800
	r_PackedHalf2AtPtx4803R1544 =
		HalfAdd(r_PackedHalf2AtPtx4437R1848, r_MmaAccumulatorHalf2WordAtPtx3712R1339); // PTX L4803
	r_LaneIndexAtPtx4807 = uint32_t((threadIdx.x & 31u));							   // PTX L4807
	r_PackedHalf2AtPtx4810R1546 =
		HalfAdd(r_PackedHalf2AtPtx4438R1849, r_MmaAccumulatorHalf2WordAtPtx3712R1340); // PTX L4810
	r_LaneIndexAtPtx4814 = uint32_t((threadIdx.x & 31u));							   // PTX L4814
	r_PackedHalf2AtPtx4817R1545 =
		HalfAdd(r_PackedHalf2AtPtx4439R1850, r_MmaAccumulatorHalf2WordAtPtx3719R1343); // PTX L4817
	r_LaneIndexAtPtx4821 = uint32_t((threadIdx.x & 31u));							   // PTX L4821
	r_PackedHalf2AtPtx4824R1547 =
		HalfAdd(r_PackedHalf2AtPtx4440R1851, r_MmaAccumulatorHalf2WordAtPtx3719R1344); // PTX L4824
	r_LaneIndexAtPtx4828 = uint32_t((threadIdx.x & 31u));							   // PTX L4828
	r_PackedHalf2AtPtx4831R1548 =
		HalfAdd(r_PackedHalf2AtPtx4453R1852, r_MmaAccumulatorHalf2WordAtPtx3740R1347); // PTX L4831
	r_LaneIndexAtPtx4835 = uint32_t((threadIdx.x & 31u));							   // PTX L4835
	r_PackedHalf2AtPtx4838R1550 =
		HalfAdd(r_PackedHalf2AtPtx4454R1853, r_MmaAccumulatorHalf2WordAtPtx3740R1348); // PTX L4838
	r_LaneIndexAtPtx4842 = uint32_t((threadIdx.x & 31u));							   // PTX L4842
	r_PackedHalf2AtPtx4845R1549 =
		HalfAdd(r_PackedHalf2AtPtx4455R1854, r_MmaAccumulatorHalf2WordAtPtx3747R1351); // PTX L4845
	r_LaneIndexAtPtx4849 = uint32_t((threadIdx.x & 31u));							   // PTX L4849
	r_PackedHalf2AtPtx4852R1551 =
		HalfAdd(r_PackedHalf2AtPtx4456R1855, r_MmaAccumulatorHalf2WordAtPtx3747R1352); // PTX L4852
	r_LaneIndexAtPtx4856 = uint32_t((threadIdx.x & 31u));							   // PTX L4856
	r_PackedHalf2AtPtx4859R1552 =
		HalfAdd(r_PackedHalf2AtPtx4469R1856, r_MmaAccumulatorHalf2WordAtPtx3768R1355); // PTX L4859
	r_LaneIndexAtPtx4863 = uint32_t((threadIdx.x & 31u));							   // PTX L4863
	r_PackedHalf2AtPtx4866R1554 =
		HalfAdd(r_PackedHalf2AtPtx4470R1857, r_MmaAccumulatorHalf2WordAtPtx3768R1356); // PTX L4866
	r_LaneIndexAtPtx4870 = uint32_t((threadIdx.x & 31u));							   // PTX L4870
	r_PackedHalf2AtPtx4873R1553 =
		HalfAdd(r_PackedHalf2AtPtx4471R1858, r_MmaAccumulatorHalf2WordAtPtx3775R1359); // PTX L4873
	r_LaneIndexAtPtx4877 = uint32_t((threadIdx.x & 31u));							   // PTX L4877
	r_PackedHalf2AtPtx4880R1555 =
		HalfAdd(r_PackedHalf2AtPtx4472R1859, r_MmaAccumulatorHalf2WordAtPtx3775R1360); // PTX L4880
	r_LaneIndexAtPtx4884 = uint32_t((threadIdx.x & 31u));							   // PTX L4884
	r_PackedHalf2AtPtx4887R1556 =
		HalfAdd(r_PackedHalf2AtPtx4486R1860, r_MmaAccumulatorHalf2WordAtPtx3796R1367); // PTX L4887
	r_LaneIndexAtPtx4891 = uint32_t((threadIdx.x & 31u));							   // PTX L4891
	r_PackedHalf2AtPtx4894R1558 =
		HalfAdd(r_PackedHalf2AtPtx4487R1861, r_MmaAccumulatorHalf2WordAtPtx3796R1368); // PTX L4894
	r_LaneIndexAtPtx4898 = uint32_t((threadIdx.x & 31u));							   // PTX L4898
	r_PackedHalf2AtPtx4901R1557 =
		HalfAdd(r_PackedHalf2AtPtx4488R1862, r_MmaAccumulatorHalf2WordAtPtx3803R1375); // PTX L4901
	r_LaneIndexAtPtx4905 = uint32_t((threadIdx.x & 31u));							   // PTX L4905
	r_PackedHalf2AtPtx4908R1559 =
		HalfAdd(r_PackedHalf2AtPtx4489R1863, r_MmaAccumulatorHalf2WordAtPtx3803R1376); // PTX L4908
	r_LaneIndexAtPtx4912 = uint32_t((threadIdx.x & 31u));							   // PTX L4912
	r_PackedHalf2AtPtx4915R1560 =
		HalfAdd(r_PackedHalf2AtPtx4502R1864, r_MmaAccumulatorHalf2WordAtPtx3824R1379); // PTX L4915
	r_LaneIndexAtPtx4919 = uint32_t((threadIdx.x & 31u));							   // PTX L4919
	r_PackedHalf2AtPtx4922R1562 =
		HalfAdd(r_PackedHalf2AtPtx4503R1865, r_MmaAccumulatorHalf2WordAtPtx3824R1380); // PTX L4922
	r_LaneIndexAtPtx4926 = uint32_t((threadIdx.x & 31u));							   // PTX L4926
	r_PackedHalf2AtPtx4929R1561 =
		HalfAdd(r_PackedHalf2AtPtx4504R1866, r_MmaAccumulatorHalf2WordAtPtx3831R1383); // PTX L4929
	r_LaneIndexAtPtx4933 = uint32_t((threadIdx.x & 31u));							   // PTX L4933
	r_PackedHalf2AtPtx4936R1563 =
		HalfAdd(r_PackedHalf2AtPtx4505R1867, r_MmaAccumulatorHalf2WordAtPtx3831R1384); // PTX L4936
	r_LaneIndexAtPtx4940 = uint32_t((threadIdx.x & 31u));							   // PTX L4940
	r_PackedHalf2AtPtx4943R1564 =
		HalfAdd(r_PackedHalf2AtPtx4518R1868, r_MmaAccumulatorHalf2WordAtPtx3852R1387); // PTX L4943
	r_LaneIndexAtPtx4947 = uint32_t((threadIdx.x & 31u));							   // PTX L4947
	r_PackedHalf2AtPtx4950R1566 =
		HalfAdd(r_PackedHalf2AtPtx4519R1869, r_MmaAccumulatorHalf2WordAtPtx3852R1388); // PTX L4950
	r_LaneIndexAtPtx4954 = uint32_t((threadIdx.x & 31u));							   // PTX L4954
	r_PackedHalf2AtPtx4957R1565 =
		HalfAdd(r_PackedHalf2AtPtx4520R1870, r_MmaAccumulatorHalf2WordAtPtx3859R1391); // PTX L4957
	r_LaneIndexAtPtx4961 = uint32_t((threadIdx.x & 31u));							   // PTX L4961
	r_PackedHalf2AtPtx4964R1567 =
		HalfAdd(r_PackedHalf2AtPtx4521R1871, r_MmaAccumulatorHalf2WordAtPtx3859R1392); // PTX L4964
	r_LaneIndexAtPtx4968 = uint32_t((threadIdx.x & 31u));							   // PTX L4968
	r_PackedHalf2AtPtx4971R1568 =
		HalfAdd(r_PackedHalf2AtPtx4543R1872, r_MmaAccumulatorHalf2WordAtPtx3880R1395); // PTX L4971
	r_LaneIndexAtPtx4975 = uint32_t((threadIdx.x & 31u));							   // PTX L4975
	r_PackedHalf2AtPtx4978R1570 =
		HalfAdd(r_PackedHalf2AtPtx4532R1873, r_MmaAccumulatorHalf2WordAtPtx3880R1396); // PTX L4978
	r_LaneIndexAtPtx4982 = uint32_t((threadIdx.x & 31u));							   // PTX L4982
	r_PackedHalf2AtPtx4985R1569 =
		HalfAdd(r_PackedHalf2AtPtx4533R1874, r_MmaAccumulatorHalf2WordAtPtx3887R1399); // PTX L4985
	r_LaneIndexAtPtx4989 = uint32_t((threadIdx.x & 31u));							   // PTX L4989
	r_PackedHalf2AtPtx4992R1571 =
		HalfAdd(r_PackedHalf2AtPtx4534R1875, r_MmaAccumulatorHalf2WordAtPtx3887R1400);			  // PTX L4992
	r_ConvertedE4PairAtPtx4996Rs100 = PublishE4(r_PackedHalf2AtPtx4551R1508);					  // PTX L4996
	r_ConvertedE4PairAtPtx4999Rs101 = PublishE4(r_PackedHalf2AtPtx4565R1509);					  // PTX L4999
	r_ConvertedE4PairAtPtx5002Rs102 = PublishE4(r_PackedHalf2AtPtx4558R1510);					  // PTX L5002
	r_ConvertedE4PairAtPtx5005Rs103 = PublishE4(r_PackedHalf2AtPtx4572R1511);					  // PTX L5005
	r_ConvertedE4PairAtPtx5008Rs104 = PublishE4(r_PackedHalf2AtPtx4579R1512);					  // PTX L5008
	r_ConvertedE4PairAtPtx5011Rs105 = PublishE4(r_PackedHalf2AtPtx4593R1513);					  // PTX L5011
	r_ConvertedE4PairAtPtx5014Rs106 = PublishE4(r_PackedHalf2AtPtx4586R1514);					  // PTX L5014
	r_ConvertedE4PairAtPtx5017Rs107 = PublishE4(r_PackedHalf2AtPtx4600R1515);					  // PTX L5017
	r_ConvertedE4PairAtPtx5020Rs108 = PublishE4(r_PackedHalf2AtPtx4607R1516);					  // PTX L5020
	r_ConvertedE4PairAtPtx5023Rs109 = PublishE4(r_PackedHalf2AtPtx4621R1517);					  // PTX L5023
	r_ConvertedE4PairAtPtx5026Rs110 = PublishE4(r_PackedHalf2AtPtx4614R1518);					  // PTX L5026
	r_ConvertedE4PairAtPtx5029Rs111 = PublishE4(r_PackedHalf2AtPtx4628R1519);					  // PTX L5029
	r_ConvertedE4PairAtPtx5032Rs112 = PublishE4(r_PackedHalf2AtPtx4635R1520);					  // PTX L5032
	r_ConvertedE4PairAtPtx5035Rs113 = PublishE4(r_PackedHalf2AtPtx4649R1521);					  // PTX L5035
	r_ConvertedE4PairAtPtx5038Rs114 = PublishE4(r_PackedHalf2AtPtx4642R1522);					  // PTX L5038
	r_ConvertedE4PairAtPtx5041Rs115 = PublishE4(r_PackedHalf2AtPtx4656R1523);					  // PTX L5041
	r_ConvertedE4PairAtPtx5044Rs116 = PublishE4(r_PackedHalf2AtPtx4663R1524);					  // PTX L5044
	r_ConvertedE4PairAtPtx5047Rs117 = PublishE4(r_PackedHalf2AtPtx4677R1525);					  // PTX L5047
	r_ConvertedE4PairAtPtx5050Rs118 = PublishE4(r_PackedHalf2AtPtx4670R1526);					  // PTX L5050
	r_ConvertedE4PairAtPtx5053Rs119 = PublishE4(r_PackedHalf2AtPtx4684R1527);					  // PTX L5053
	r_ConvertedE4PairAtPtx5056Rs120 = PublishE4(r_PackedHalf2AtPtx4691R1528);					  // PTX L5056
	r_ConvertedE4PairAtPtx5059Rs121 = PublishE4(r_PackedHalf2AtPtx4705R1529);					  // PTX L5059
	r_ConvertedE4PairAtPtx5062Rs122 = PublishE4(r_PackedHalf2AtPtx4698R1530);					  // PTX L5062
	r_ConvertedE4PairAtPtx5065Rs123 = PublishE4(r_PackedHalf2AtPtx4712R1531);					  // PTX L5065
	r_ConvertedE4PairAtPtx5068Rs124 = PublishE4(r_PackedHalf2AtPtx4719R1532);					  // PTX L5068
	r_ConvertedE4PairAtPtx5071Rs125 = PublishE4(r_PackedHalf2AtPtx4733R1533);					  // PTX L5071
	r_ConvertedE4PairAtPtx5074Rs126 = PublishE4(r_PackedHalf2AtPtx4726R1534);					  // PTX L5074
	r_ConvertedE4PairAtPtx5077Rs127 = PublishE4(r_PackedHalf2AtPtx4740R1535);					  // PTX L5077
	r_ConvertedE4PairAtPtx5080Rs128 = PublishE4(r_PackedHalf2AtPtx4747R1536);					  // PTX L5080
	r_ConvertedE4PairAtPtx5083Rs129 = PublishE4(r_PackedHalf2AtPtx4761R1537);					  // PTX L5083
	r_ConvertedE4PairAtPtx5086Rs130 = PublishE4(r_PackedHalf2AtPtx4754R1538);					  // PTX L5086
	r_ConvertedE4PairAtPtx5089Rs131 = PublishE4(r_PackedHalf2AtPtx4768R1539);					  // PTX L5089
	r_ConvertedE4PairAtPtx5092Rs132 = PublishE4(r_PackedHalf2AtPtx4775R1540);					  // PTX L5092
	r_ConvertedE4PairAtPtx5095Rs133 = PublishE4(r_PackedHalf2AtPtx4789R1541);					  // PTX L5095
	r_ConvertedE4PairAtPtx5098Rs134 = PublishE4(r_PackedHalf2AtPtx4782R1542);					  // PTX L5098
	r_ConvertedE4PairAtPtx5101Rs135 = PublishE4(r_PackedHalf2AtPtx4796R1543);					  // PTX L5101
	r_ConvertedE4PairAtPtx5104Rs136 = PublishE4(r_PackedHalf2AtPtx4803R1544);					  // PTX L5104
	r_ConvertedE4PairAtPtx5107Rs137 = PublishE4(r_PackedHalf2AtPtx4817R1545);					  // PTX L5107
	r_ConvertedE4PairAtPtx5110Rs138 = PublishE4(r_PackedHalf2AtPtx4810R1546);					  // PTX L5110
	r_ConvertedE4PairAtPtx5113Rs139 = PublishE4(r_PackedHalf2AtPtx4824R1547);					  // PTX L5113
	r_ConvertedE4PairAtPtx5116Rs140 = PublishE4(r_PackedHalf2AtPtx4831R1548);					  // PTX L5116
	r_ConvertedE4PairAtPtx5119Rs141 = PublishE4(r_PackedHalf2AtPtx4845R1549);					  // PTX L5119
	r_ConvertedE4PairAtPtx5122Rs142 = PublishE4(r_PackedHalf2AtPtx4838R1550);					  // PTX L5122
	r_ConvertedE4PairAtPtx5125Rs143 = PublishE4(r_PackedHalf2AtPtx4852R1551);					  // PTX L5125
	r_ConvertedE4PairAtPtx5128Rs144 = PublishE4(r_PackedHalf2AtPtx4859R1552);					  // PTX L5128
	r_ConvertedE4PairAtPtx5131Rs145 = PublishE4(r_PackedHalf2AtPtx4873R1553);					  // PTX L5131
	r_ConvertedE4PairAtPtx5134Rs146 = PublishE4(r_PackedHalf2AtPtx4866R1554);					  // PTX L5134
	r_ConvertedE4PairAtPtx5137Rs147 = PublishE4(r_PackedHalf2AtPtx4880R1555);					  // PTX L5137
	r_ConvertedE4PairAtPtx5140Rs148 = PublishE4(r_PackedHalf2AtPtx4887R1556);					  // PTX L5140
	r_ConvertedE4PairAtPtx5143Rs149 = PublishE4(r_PackedHalf2AtPtx4901R1557);					  // PTX L5143
	r_ConvertedE4PairAtPtx5146Rs150 = PublishE4(r_PackedHalf2AtPtx4894R1558);					  // PTX L5146
	r_ConvertedE4PairAtPtx5149Rs151 = PublishE4(r_PackedHalf2AtPtx4908R1559);					  // PTX L5149
	r_ConvertedE4PairAtPtx5152Rs152 = PublishE4(r_PackedHalf2AtPtx4915R1560);					  // PTX L5152
	r_ConvertedE4PairAtPtx5155Rs153 = PublishE4(r_PackedHalf2AtPtx4929R1561);					  // PTX L5155
	r_ConvertedE4PairAtPtx5158Rs154 = PublishE4(r_PackedHalf2AtPtx4922R1562);					  // PTX L5158
	r_ConvertedE4PairAtPtx5161Rs155 = PublishE4(r_PackedHalf2AtPtx4936R1563);					  // PTX L5161
	r_ConvertedE4PairAtPtx5164Rs156 = PublishE4(r_PackedHalf2AtPtx4943R1564);					  // PTX L5164
	r_ConvertedE4PairAtPtx5167Rs157 = PublishE4(r_PackedHalf2AtPtx4957R1565);					  // PTX L5167
	r_ConvertedE4PairAtPtx5170Rs158 = PublishE4(r_PackedHalf2AtPtx4950R1566);					  // PTX L5170
	r_ConvertedE4PairAtPtx5173Rs159 = PublishE4(r_PackedHalf2AtPtx4964R1567);					  // PTX L5173
	r_ConvertedE4PairAtPtx5176Rs160 = PublishE4(r_PackedHalf2AtPtx4971R1568);					  // PTX L5176
	r_ConvertedE4PairAtPtx5179Rs161 = PublishE4(r_PackedHalf2AtPtx4985R1569);					  // PTX L5179
	r_ConvertedE4PairAtPtx5182Rs162 = PublishE4(r_PackedHalf2AtPtx4978R1570);					  // PTX L5182
	r_ConvertedE4PairAtPtx5185Rs163 = PublishE4(r_PackedHalf2AtPtx4992R1571);					  // PTX L5185
	r_PtxRegister1572 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(2));						  // PTX L5187
	r_PtxRegister1573 = ShiftLeft(uint32_t(r_PtxRegister44), uint32_t(12));						  // PTX L5188
	r_PtxRegister1574 = uint32_t(r_PtxRegister1573) + uint32_t(r_PtxRegister1572);				  // PTX L5189
	r_PtxU64Register306 = uint64_t(int64_t(int32_t(r_PtxRegister1574)) * int64_t(int32_t(4)));	  // PTX L5190
	g_OutputByteAddressAtPtx5191 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register306); // PTX L5191
	if (r_bPtxPredicate88)
	{
		goto L__BB46_170;
	} // PTX L5192
	r_PackedE4WordAtPtx5193R1584 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5038Rs114, r_ConvertedE4PairAtPtx5041Rs115); // PTX L5193
	r_PackedE4WordAtPtx5194R1583 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5032Rs112, r_ConvertedE4PairAtPtx5035Rs113); // PTX L5194
	r_PackedE4WordAtPtx5195R1582 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5026Rs110, r_ConvertedE4PairAtPtx5029Rs111); // PTX L5195
	r_PackedE4WordAtPtx5196R1581 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5020Rs108, r_ConvertedE4PairAtPtx5023Rs109); // PTX L5196
	r_PackedE4WordAtPtx5197R1579 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5014Rs106, r_ConvertedE4PairAtPtx5017Rs107); // PTX L5197
	r_PackedE4WordAtPtx5198R1578 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5008Rs104, r_ConvertedE4PairAtPtx5011Rs105); // PTX L5198
	r_PackedE4WordAtPtx5199R1577 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5002Rs102, r_ConvertedE4PairAtPtx5005Rs103); // PTX L5199
	r_PackedE4WordAtPtx5200R1576 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4996Rs100, r_ConvertedE4PairAtPtx4999Rs101); // PTX L5200
	r_LaneIndexAtPtx5202 = uint32_t((threadIdx.x & 31u));								 // PTX L5202
	r_PtxU64Register309 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5202)) * int64_t(int32_t(16))); // PTX L5204
	g_OutputByteAddressAtPtx5205 =
		uint64_t(g_OutputByteAddressAtPtx5191) + uint64_t(r_PtxU64Register309); // PTX L5205
	StoreNoAllocate(g_OutputByteAddressAtPtx5205,
					make_uint4(r_PackedE4WordAtPtx5200R1576, r_PackedE4WordAtPtx5199R1577,
							   r_PackedE4WordAtPtx5198R1578,
							   r_PackedE4WordAtPtx5197R1579)); // PTX L5207
	r_LaneIndexAtPtx5210 = uint32_t((threadIdx.x & 31u));	   // PTX L5210
	r_PtxU64Register310 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5210)) * int64_t(int32_t(16))); // PTX L5212
	g_OutputByteAddressAtPtx5213 =
		uint64_t(g_OutputByteAddressAtPtx5191) + uint64_t(r_PtxU64Register310);			   // PTX L5213
	g_OutputByteAddressAtPtx5214 = uint64_t(g_OutputByteAddressAtPtx5213) + uint64_t(512); // PTX L5214
	StoreNoAllocate(g_OutputByteAddressAtPtx5214,
					make_uint4(r_PackedE4WordAtPtx5196R1581, r_PackedE4WordAtPtx5195R1582,
							   r_PackedE4WordAtPtx5194R1583,
							   r_PackedE4WordAtPtx5193R1584));								 // PTX L5216
L__BB46_170:																				 // PTX L5218
	r_bPtxPredicate89 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister3);				 // PTX L5219
	g_OutputByteAddressAtPtx5220 = uint64_t(g_OutputByteAddressAtPtx5191) + uint64_t(16384); // PTX L5220
	if (r_bPtxPredicate89)
	{
		goto L__BB46_172;
	} // PTX L5221
	r_LaneIndexAtPtx5223 = uint32_t((threadIdx.x & 31u)); // PTX L5223
	r_PtxU64Register314 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5223)) * int64_t(int32_t(16))); // PTX L5225
	g_OutputByteAddressAtPtx5226 =
		uint64_t(g_OutputByteAddressAtPtx5220) + uint64_t(r_PtxU64Register314); // PTX L5226
	r_PackedE4WordAtPtx5227R1589 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5062Rs122, r_ConvertedE4PairAtPtx5065Rs123); // PTX L5227
	r_PackedE4WordAtPtx5228R1588 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5056Rs120, r_ConvertedE4PairAtPtx5059Rs121); // PTX L5228
	r_PackedE4WordAtPtx5229R1587 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5050Rs118, r_ConvertedE4PairAtPtx5053Rs119); // PTX L5229
	r_PackedE4WordAtPtx5230R1586 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5044Rs116, r_ConvertedE4PairAtPtx5047Rs117); // PTX L5230
	StoreNoAllocate(g_OutputByteAddressAtPtx5226,
					make_uint4(r_PackedE4WordAtPtx5230R1586, r_PackedE4WordAtPtx5229R1587,
							   r_PackedE4WordAtPtx5228R1588,
							   r_PackedE4WordAtPtx5227R1589)); // PTX L5232
	r_LaneIndexAtPtx5235 = uint32_t((threadIdx.x & 31u));	   // PTX L5235
	r_PtxU64Register315 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5235)) * int64_t(int32_t(16))); // PTX L5237
	g_OutputByteAddressAtPtx5238 =
		uint64_t(g_OutputByteAddressAtPtx5191) + uint64_t(r_PtxU64Register315);				 // PTX L5238
	g_OutputByteAddressAtPtx5239 = uint64_t(g_OutputByteAddressAtPtx5238) + uint64_t(16896); // PTX L5239
	r_PackedE4WordAtPtx5240R1594 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5086Rs130, r_ConvertedE4PairAtPtx5089Rs131); // PTX L5240
	r_PackedE4WordAtPtx5241R1593 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5080Rs128, r_ConvertedE4PairAtPtx5083Rs129); // PTX L5241
	r_PackedE4WordAtPtx5242R1592 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5074Rs126, r_ConvertedE4PairAtPtx5077Rs127); // PTX L5242
	r_PackedE4WordAtPtx5243R1591 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5068Rs124, r_ConvertedE4PairAtPtx5071Rs125); // PTX L5243
	StoreNoAllocate(g_OutputByteAddressAtPtx5239,
					make_uint4(r_PackedE4WordAtPtx5243R1591, r_PackedE4WordAtPtx5242R1592,
							   r_PackedE4WordAtPtx5241R1593,
							   r_PackedE4WordAtPtx5240R1594));								 // PTX L5245
L__BB46_172:																				 // PTX L5247
	r_bPtxPredicate90 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister3);				 // PTX L5248
	g_OutputByteAddressAtPtx5249 = uint64_t(g_OutputByteAddressAtPtx5220) + uint64_t(16384); // PTX L5249
	if (r_bPtxPredicate90)
	{
		goto L__BB46_174;
	} // PTX L5250
	r_LaneIndexAtPtx5252 = uint32_t((threadIdx.x & 31u)); // PTX L5252
	r_PtxU64Register319 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5252)) * int64_t(int32_t(16))); // PTX L5254
	g_OutputByteAddressAtPtx5255 =
		uint64_t(g_OutputByteAddressAtPtx5249) + uint64_t(r_PtxU64Register319); // PTX L5255
	r_PackedE4WordAtPtx5256R1599 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5110Rs138, r_ConvertedE4PairAtPtx5113Rs139); // PTX L5256
	r_PackedE4WordAtPtx5257R1598 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5104Rs136, r_ConvertedE4PairAtPtx5107Rs137); // PTX L5257
	r_PackedE4WordAtPtx5258R1597 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5098Rs134, r_ConvertedE4PairAtPtx5101Rs135); // PTX L5258
	r_PackedE4WordAtPtx5259R1596 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5092Rs132, r_ConvertedE4PairAtPtx5095Rs133); // PTX L5259
	StoreNoAllocate(g_OutputByteAddressAtPtx5255,
					make_uint4(r_PackedE4WordAtPtx5259R1596, r_PackedE4WordAtPtx5258R1597,
							   r_PackedE4WordAtPtx5257R1598,
							   r_PackedE4WordAtPtx5256R1599)); // PTX L5261
	r_LaneIndexAtPtx5264 = uint32_t((threadIdx.x & 31u));	   // PTX L5264
	r_PtxU64Register320 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5264)) * int64_t(int32_t(16))); // PTX L5266
	g_OutputByteAddressAtPtx5267 =
		uint64_t(g_OutputByteAddressAtPtx5220) + uint64_t(r_PtxU64Register320);				 // PTX L5267
	g_OutputByteAddressAtPtx5268 = uint64_t(g_OutputByteAddressAtPtx5267) + uint64_t(16896); // PTX L5268
	r_PackedE4WordAtPtx5269R1604 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5134Rs146, r_ConvertedE4PairAtPtx5137Rs147); // PTX L5269
	r_PackedE4WordAtPtx5270R1603 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5128Rs144, r_ConvertedE4PairAtPtx5131Rs145); // PTX L5270
	r_PackedE4WordAtPtx5271R1602 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5122Rs142, r_ConvertedE4PairAtPtx5125Rs143); // PTX L5271
	r_PackedE4WordAtPtx5272R1601 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5116Rs140, r_ConvertedE4PairAtPtx5119Rs141); // PTX L5272
	StoreNoAllocate(g_OutputByteAddressAtPtx5268,
					make_uint4(r_PackedE4WordAtPtx5272R1601, r_PackedE4WordAtPtx5271R1602,
							   r_PackedE4WordAtPtx5270R1603,
							   r_PackedE4WordAtPtx5269R1604));				 // PTX L5274
L__BB46_174:																 // PTX L5276
	r_bPtxPredicate91 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister3); // PTX L5277
	if (r_bPtxPredicate91)
	{
		goto L__BB46_176;
	} // PTX L5278
	r_LaneIndexAtPtx5280 = uint32_t((threadIdx.x & 31u)); // PTX L5280
	r_PtxU64Register324 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5280)) * int64_t(int32_t(16))); // PTX L5282
	g_OutputByteAddressAtPtx5283 =
		uint64_t(g_OutputByteAddressAtPtx5249) + uint64_t(r_PtxU64Register324);				 // PTX L5283
	g_OutputByteAddressAtPtx5284 = uint64_t(g_OutputByteAddressAtPtx5283) + uint64_t(16384); // PTX L5284
	r_PackedE4WordAtPtx5285R1609 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5158Rs154, r_ConvertedE4PairAtPtx5161Rs155); // PTX L5285
	r_PackedE4WordAtPtx5286R1608 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5152Rs152, r_ConvertedE4PairAtPtx5155Rs153); // PTX L5286
	r_PackedE4WordAtPtx5287R1607 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5146Rs150, r_ConvertedE4PairAtPtx5149Rs151); // PTX L5287
	r_PackedE4WordAtPtx5288R1606 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5140Rs148, r_ConvertedE4PairAtPtx5143Rs149); // PTX L5288
	StoreNoAllocate(g_OutputByteAddressAtPtx5284,
					make_uint4(r_PackedE4WordAtPtx5288R1606, r_PackedE4WordAtPtx5287R1607,
							   r_PackedE4WordAtPtx5286R1608,
							   r_PackedE4WordAtPtx5285R1609)); // PTX L5290
	r_LaneIndexAtPtx5293 = uint32_t((threadIdx.x & 31u));	   // PTX L5293
	r_PtxU64Register326 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5293)) * int64_t(int32_t(16))); // PTX L5295
	g_OutputByteAddressAtPtx5296 =
		uint64_t(g_OutputByteAddressAtPtx5249) + uint64_t(r_PtxU64Register326);				 // PTX L5296
	g_OutputByteAddressAtPtx5297 = uint64_t(g_OutputByteAddressAtPtx5296) + uint64_t(16896); // PTX L5297
	r_PackedE4WordAtPtx5298R1614 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5182Rs162, r_ConvertedE4PairAtPtx5185Rs163); // PTX L5298
	r_PackedE4WordAtPtx5299R1613 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5176Rs160, r_ConvertedE4PairAtPtx5179Rs161); // PTX L5299
	r_PackedE4WordAtPtx5300R1612 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5170Rs158, r_ConvertedE4PairAtPtx5173Rs159); // PTX L5300
	r_PackedE4WordAtPtx5301R1611 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5164Rs156, r_ConvertedE4PairAtPtx5167Rs157); // PTX L5301
	StoreNoAllocate(g_OutputByteAddressAtPtx5297,
					make_uint4(r_PackedE4WordAtPtx5301R1611, r_PackedE4WordAtPtx5300R1612,
							   r_PackedE4WordAtPtx5299R1613,
							   r_PackedE4WordAtPtx5298R1614));		 // PTX L5303
L__BB46_176:														 // PTX L5305
	__syncthreads();												 // PTX L5306
	r_ThreadZAtPtx5307 = uint32_t(threadIdx.z);						 // PTX L5307
	r_PtxRegister1674 = r_PtxRegister64 | r_ThreadZAtPtx5307;		 // PTX L5308
	r_bPtxPredicate100 = uint32_t(r_PtxRegister1674) != uint32_t(0); // PTX L5309
	if (r_bPtxPredicate100)
	{
		goto L__BB46_178;
	} // PTX L5310
	// Original partition completion publication after the native CTA barrier.
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(g_CounterByteAddress, r_CtaZ); // PTX L5312
L__BB46_178:										   // PTX L5314
	return;											   // PTX L5315
L__BB46_116:										   // PTX L5316
	r_PtxRegister38 = uint32_t(r_CtaZ) + uint32_t(-1); // PTX L5317
L__BB46_117:										   // PTX L5318
	// Original relaxed counter poll; the native control edge and sleep remain below.
	r_PtxRegister1425 = CounterLoadRelaxed(g_CounterByteAddress);				// PTX L5320
	r_bPtxPredicate71 = int32_t(r_PtxRegister1425) >= int32_t(r_PtxRegister38); // PTX L5322
	if (r_bPtxPredicate71)
	{
		goto L__BB46_135;
	} // PTX L5323
	r_PtxRegister1651 = uint32_t(64); // PTX L5324
	PollSleep(r_PtxRegister1651);	  // PTX L5326
	goto L__BB46_117;				  // PTX L5328
#endif
}
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8
