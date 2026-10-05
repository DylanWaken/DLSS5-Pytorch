// Readable reconstruction of cc_split_swin_16h_proj_512_fp8; not historical source.
#pragma once
#include "window_attention_projection_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
{
__global__ __maxnreg__(168) void window_attention_projection_c512_fp8(Parameters r_Parameters)
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
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx223Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx292Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx362Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx432Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx469Rs10, r_PtxU16Register11, r_ConvertedE4PairAtPtx511Rs12;
	uint16_t r_PtxU16Register13, r_ConvertedE4PairAtPtx548Rs14, r_PtxU16Register15, r_PtxU16Register16,
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
		r_PtxU16Register58, r_PtxU16Register59, r_ConvertedE4PairAtPtx1791Rs60;
	uint16_t r_ConvertedE4PairAtPtx1810Rs61, r_ConvertedE4PairAtPtx1813Rs62, r_ConvertedE4PairAtPtx1816Rs63,
		r_ConvertedE4PairAtPtx1819Rs64, r_ConvertedE4PairAtPtx1822Rs65, r_ConvertedE4PairAtPtx1825Rs66,
		r_ConvertedE4PairAtPtx1828Rs67, r_ConvertedE4PairAtPtx1831Rs68, r_ConvertedE4PairAtPtx1834Rs69,
		r_ConvertedE4PairAtPtx1837Rs70, r_ConvertedE4PairAtPtx1840Rs71, r_ConvertedE4PairAtPtx1843Rs72;
	uint16_t r_ConvertedE4PairAtPtx1846Rs73, r_ConvertedE4PairAtPtx1849Rs74, r_ConvertedE4PairAtPtx1852Rs75,
		r_ConvertedE4PairAtPtx1855Rs76, r_ConvertedE4PairAtPtx1858Rs77, r_ConvertedE4PairAtPtx1861Rs78,
		r_ConvertedE4PairAtPtx1864Rs79, r_ConvertedE4PairAtPtx1867Rs80, r_ConvertedE4PairAtPtx1870Rs81,
		r_ConvertedE4PairAtPtx1873Rs82, r_ConvertedE4PairAtPtx1876Rs83, r_ConvertedE4PairAtPtx1879Rs84;
	uint16_t r_ConvertedE4PairAtPtx1882Rs85, r_ConvertedE4PairAtPtx1885Rs86, r_ConvertedE4PairAtPtx1888Rs87,
		r_ConvertedE4PairAtPtx1891Rs88, r_ConvertedE4PairAtPtx1894Rs89, r_ConvertedE4PairAtPtx1897Rs90,
		r_ConvertedE4PairAtPtx1900Rs91, r_ConvertedE4PairAtPtx1903Rs92;
	uint32_t r_HeightBits, r_WidthBits, r_CtaY, r_CtaZ, r_PtxRegister5, r_PtxRegister6, r_PtxRegister7,
		r_HeightDiv4Bits, r_WidthDiv4Bits, r_ThreadY, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_CtaX, r_PtxRegister30,
		r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35, r_PtxRegister36;
	uint32_t r_PtxRegister37, r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4, r_WidthSignBits,
		r_WidthDiv4Bias, r_WidthBiasedForDiv4, r_ThreadX, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_PtxRegister48;
	uint32_t r_PtxRegister49, r_BlockSizeX, r_BlockSizeY, r_LaneIndexAtPtx73, r_LaneIndexAtPtx81,
		r_LaneIndexAtPtx91, r_LaneIndexAtPtx100, r_LaneIndexAtPtx109, r_LaneIndexAtPtx118,
		r_LaneIndexAtPtx127, r_LaneIndexAtPtx136, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PackedHalf2AtPtx221R84;
	uint32_t r_LaneIndexAtPtx227, r_PtxRegister86, r_PackedE4WordAtPtx225R87, r_PtxRegister88,
		r_PtxRegister89, r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PackedHalf2AtPtx290R100,
		r_LaneIndexAtPtx296, r_PtxRegister102, r_PackedE4WordAtPtx294R103, r_PtxRegister104, r_PtxRegister105,
		r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PackedHalf2AtPtx360R119, r_LaneIndexAtPtx366;
	uint32_t r_PtxRegister121, r_PackedE4WordAtPtx364R122, r_PtxRegister123, r_PtxRegister124,
		r_PtxRegister125, r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129,
		r_PtxRegister130, r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136,
		r_PackedHalf2AtPtx430R137, r_LaneIndexAtPtx416, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141,
		r_PtxRegister142, r_PtxRegister143, r_PackedHalf2AtPtx467R144;
	uint32_t r_LaneIndexAtPtx453, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PackedHalf2AtPtx509R151, r_LaneIndexAtPtx495, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PackedHalf2AtPtx546R158, r_LaneIndexAtPtx532, r_PtxRegister160,
		r_PtxRegister161, r_PtxRegister162, r_PtxRegister163, r_LaneIndexAtPtx658, r_LaneIndexAtPtx672,
		r_LaneIndexAtPtx686, r_LaneIndexAtPtx700, r_LaneIndexAtPtx714;
	uint32_t r_LaneIndexAtPtx729, r_LaneIndexAtPtx743, r_LaneIndexAtPtx760, r_LaneIndexAtPtx776,
		r_LaneIndexAtPtx790, r_LaneIndexAtPtx804, r_LaneIndexAtPtx821, r_LaneIndexAtPtx837,
		r_LaneIndexAtPtx852, r_LaneIndexAtPtx866, r_LaneIndexAtPtx883, r_LaneIndexAtPtx899;
	uint32_t r_LaneIndexAtPtx913, r_LaneIndexAtPtx927, r_LaneIndexAtPtx941, r_LaneIndexAtPtx955,
		r_LaneIndexAtPtx969, r_LaneIndexAtPtx983, r_LaneIndexAtPtx999, r_LaneIndexAtPtx1015,
		r_LaneIndexAtPtx1029, r_LaneIndexAtPtx1043, r_LaneIndexAtPtx1059, r_LaneIndexAtPtx1075;
	uint32_t r_LaneIndexAtPtx1089, r_LaneIndexAtPtx1103, r_LaneIndexAtPtx1119, r_LaneIndexAtPtx1135,
		r_PackedHalf2AtPtx556R197, r_PtxRegister198, r_LaneIndexAtPtx1142, r_PackedHalf2AtPtx562R200,
		r_PtxRegister201, r_LaneIndexAtPtx1149, r_PackedHalf2AtPtx559R203, r_PtxRegister204;
	uint32_t r_LaneIndexAtPtx1156, r_PackedHalf2AtPtx565R206, r_PtxRegister207, r_LaneIndexAtPtx1163,
		r_PackedHalf2AtPtx568R209, r_PtxRegister210, r_LaneIndexAtPtx1170, r_PackedHalf2AtPtx574R212,
		r_PtxRegister213, r_LaneIndexAtPtx1177, r_PackedHalf2AtPtx571R215, r_PtxRegister216;
	uint32_t r_LaneIndexAtPtx1184, r_PackedHalf2AtPtx577R218, r_PtxRegister219, r_LaneIndexAtPtx1191,
		r_PackedHalf2AtPtx580R221, r_PtxRegister222, r_LaneIndexAtPtx1198, r_PackedHalf2AtPtx586R224,
		r_PtxRegister225, r_LaneIndexAtPtx1205, r_PackedHalf2AtPtx583R227, r_PtxRegister228;
	uint32_t r_LaneIndexAtPtx1212, r_PackedHalf2AtPtx589R230, r_PtxRegister231, r_LaneIndexAtPtx1219,
		r_PackedHalf2AtPtx592R233, r_PtxRegister234, r_LaneIndexAtPtx1226, r_PackedHalf2AtPtx598R236,
		r_PtxRegister237, r_LaneIndexAtPtx1233, r_PackedHalf2AtPtx595R239, r_PtxRegister240;
	uint32_t r_LaneIndexAtPtx1240, r_PackedHalf2AtPtx601R242, r_PtxRegister243, r_LaneIndexAtPtx1247,
		r_PackedHalf2AtPtx604R245, r_PtxRegister246, r_LaneIndexAtPtx1254, r_PackedHalf2AtPtx610R248,
		r_PtxRegister249, r_LaneIndexAtPtx1261, r_PackedHalf2AtPtx607R251, r_PtxRegister252;
	uint32_t r_LaneIndexAtPtx1268, r_PackedHalf2AtPtx613R254, r_PtxRegister255, r_LaneIndexAtPtx1275,
		r_PackedHalf2AtPtx616R257, r_PtxRegister258, r_LaneIndexAtPtx1282, r_PackedHalf2AtPtx622R260,
		r_PtxRegister261, r_LaneIndexAtPtx1289, r_PackedHalf2AtPtx619R263, r_PtxRegister264;
	uint32_t r_LaneIndexAtPtx1296, r_PackedHalf2AtPtx625R266, r_PtxRegister267, r_LaneIndexAtPtx1303,
		r_PackedHalf2AtPtx629R269, r_PtxRegister270, r_LaneIndexAtPtx1310, r_PackedHalf2AtPtx636R272,
		r_PtxRegister273, r_LaneIndexAtPtx1317, r_PackedHalf2AtPtx632R275, r_PtxRegister276;
	uint32_t r_LaneIndexAtPtx1324, r_PackedHalf2AtPtx639R278, r_PtxRegister279, r_LaneIndexAtPtx1331,
		r_PackedHalf2AtPtx643R281, r_PtxRegister282, r_LaneIndexAtPtx1338, r_PackedHalf2AtPtx650R284,
		r_PtxRegister285, r_LaneIndexAtPtx1345, r_PackedHalf2AtPtx646R287, r_PtxRegister288;
	uint32_t r_LaneIndexAtPtx1352, r_PackedHalf2AtPtx653R290, r_PtxRegister291, r_PtxRegister292,
		r_PtxRegister293, r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297,
		r_PtxRegister298, r_PtxRegister299, r_PtxRegister300;
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
		r_PtxRegister546, r_PtxRegister547, r_PtxRegister548, r_PtxRegister549, r_PtxRegister550,
		r_PtxRegister551, r_PtxRegister552;
	uint32_t r_PtxRegister553, r_PtxRegister554, r_PtxRegister555, r_PtxRegister556, r_PtxRegister557,
		r_PtxRegister558, r_PtxRegister559, r_PtxRegister560, r_PtxRegister561, r_PtxRegister562,
		r_PtxRegister563, r_PtxRegister564;
	uint32_t r_PtxRegister565, r_PtxRegister566, r_PtxRegister567, r_PtxRegister568, r_PtxRegister569,
		r_PtxRegister570, r_PtxRegister571, r_PtxRegister572, r_PtxRegister573, r_PtxRegister574,
		r_PtxRegister575, r_PtxRegister576;
	uint32_t r_PtxRegister577, r_LaneIndexAtPtx1373, r_PtxRegister579, r_LaneIndexAtPtx1384, r_PtxRegister581,
		r_LaneIndexAtPtx1393, r_PtxRegister583, r_LaneIndexAtPtx1402, r_PtxRegister585,
		r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588;
	uint32_t r_MmaAE4x4WordAtPtx1381R589, r_MmaAE4x4WordAtPtx1390R590, r_MmaAE4x4WordAtPtx1390R591,
		r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593, r_MmaAccumulatorHalf2WordAtPtx1411R594,
		r_MmaAccumulatorHalf2WordAtPtx1411R595, r_MmaAccumulatorHalf2WordAtPtx1418R596,
		r_MmaAccumulatorHalf2WordAtPtx1418R597, r_MmaAccumulatorHalf2WordAtPtx1439R598,
		r_MmaAccumulatorHalf2WordAtPtx1439R599, r_MmaAccumulatorHalf2WordAtPtx1446R600;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1446R601, r_MmaAccumulatorHalf2WordAtPtx1467R602,
		r_MmaAccumulatorHalf2WordAtPtx1467R603, r_MmaAccumulatorHalf2WordAtPtx1474R604,
		r_MmaAccumulatorHalf2WordAtPtx1474R605, r_MmaAccumulatorHalf2WordAtPtx1495R606,
		r_MmaAccumulatorHalf2WordAtPtx1495R607, r_MmaAccumulatorHalf2WordAtPtx1502R608,
		r_MmaAccumulatorHalf2WordAtPtx1502R609, r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611,
		r_MmaAE4x4WordAtPtx1399R612;
	uint32_t r_MmaAE4x4WordAtPtx1399R613, r_MmaAE4x4WordAtPtx1408R614, r_MmaAE4x4WordAtPtx1408R615,
		r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617, r_MmaAccumulatorHalf2WordAtPtx1523R618,
		r_MmaAccumulatorHalf2WordAtPtx1523R619, r_MmaAccumulatorHalf2WordAtPtx1530R620,
		r_MmaAccumulatorHalf2WordAtPtx1530R621, r_MmaAccumulatorHalf2WordAtPtx1551R622,
		r_MmaAccumulatorHalf2WordAtPtx1551R623, r_MmaAccumulatorHalf2WordAtPtx1558R624;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1558R625, r_MmaAccumulatorHalf2WordAtPtx1579R626,
		r_MmaAccumulatorHalf2WordAtPtx1579R627, r_MmaAccumulatorHalf2WordAtPtx1586R628,
		r_MmaAccumulatorHalf2WordAtPtx1586R629, r_MmaAccumulatorHalf2WordAtPtx1607R630,
		r_MmaAccumulatorHalf2WordAtPtx1607R631, r_MmaAccumulatorHalf2WordAtPtx1614R632,
		r_MmaAccumulatorHalf2WordAtPtx1614R633, r_PtxRegister634, r_PtxRegister635, r_PtxRegister636;
	uint32_t r_PtxRegister637, r_PtxRegister638, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_LaneIndexAtPtx1643,
		r_LaneIndexAtPtx1651, r_LaneIndexAtPtx1660;
	uint32_t r_LaneIndexAtPtx1669, r_LaneIndexAtPtx1678, r_LaneIndexAtPtx1687, r_LaneIndexAtPtx1696,
		r_LaneIndexAtPtx1705, r_PtxRegister654, r_PtxRegister655, r_PtxRegister656, r_PtxRegister657,
		r_PtxRegister658, r_PtxRegister659, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_PtxRegister662, r_PtxRegister663, r_PtxRegister664, r_PtxRegister665,
		r_PtxRegister666, r_PtxRegister667, r_PtxRegister668, r_PtxRegister669, r_PtxRegister670,
		r_PackedHalf2AtPtx1789R671, r_LaneIndexAtPtx1795;
	uint32_t r_PtxRegister673, r_PackedE4WordAtPtx1793R674, r_PtxRegister675, r_PtxRegister676,
		r_PtxRegister677, r_PtxRegister678, r_PtxRegister679, r_PtxRegister680, r_PtxRegister681,
		r_PtxRegister682, r_PtxRegister683, r_PtxRegister684;
	uint32_t r_PtxRegister685, r_PtxRegister686, r_PtxRegister687, r_LaneIndexAtPtx1922,
		r_PackedE4WordAtPtx1920R689, r_PackedE4WordAtPtx1919R690, r_PackedE4WordAtPtx1918R691,
		r_PackedE4WordAtPtx1917R692, r_LaneIndexAtPtx1930, r_PackedE4WordAtPtx1916R694,
		r_PackedE4WordAtPtx1915R695, r_PackedE4WordAtPtx1914R696;
	uint32_t r_PackedE4WordAtPtx1913R697, r_LaneIndexAtPtx1943, r_PackedE4WordAtPtx1951R699,
		r_PackedE4WordAtPtx1950R700, r_PackedE4WordAtPtx1949R701, r_PackedE4WordAtPtx1948R702,
		r_LaneIndexAtPtx1956, r_PackedE4WordAtPtx1964R704, r_PackedE4WordAtPtx1963R705,
		r_PackedE4WordAtPtx1962R706, r_PackedE4WordAtPtx1961R707, r_PtxRegister708;
	uint32_t r_PtxRegister709, r_PtxRegister710, r_PtxRegister711, r_PtxRegister712, r_PtxRegister713,
		r_PtxRegister714, r_PtxRegister715, r_PtxRegister716, r_PtxRegister717, r_PtxRegister718,
		r_PtxRegister719, r_PtxRegister720;
	uint32_t r_PtxRegister721, r_PtxRegister722, r_PtxRegister723, r_PtxRegister724, r_PtxRegister725,
		r_PtxRegister726, r_PackedHalf2AtPtx1341R727, r_PackedHalf2AtPtx1334R728, r_PackedHalf2AtPtx1327R729,
		r_PackedHalf2AtPtx1320R730, r_PackedHalf2AtPtx1313R731, r_PackedHalf2AtPtx1306R732;
	uint32_t r_PackedHalf2AtPtx1299R733, r_PackedHalf2AtPtx1292R734, r_PackedHalf2AtPtx1285R735,
		r_PackedHalf2AtPtx1278R736, r_PackedHalf2AtPtx1271R737, r_PackedHalf2AtPtx1264R738,
		r_PackedHalf2AtPtx1257R739, r_PackedHalf2AtPtx1250R740, r_PackedHalf2AtPtx1243R741,
		r_PackedHalf2AtPtx1236R742, r_PackedHalf2AtPtx1229R743, r_PackedHalf2AtPtx1222R744;
	uint32_t r_PackedHalf2AtPtx1215R745, r_PackedHalf2AtPtx1208R746, r_PackedHalf2AtPtx1201R747,
		r_PackedHalf2AtPtx1194R748, r_PackedHalf2AtPtx1187R749, r_PackedHalf2AtPtx1180R750,
		r_PackedHalf2AtPtx1173R751, r_PackedHalf2AtPtx1166R752, r_PackedHalf2AtPtx1159R753,
		r_PackedHalf2AtPtx1152R754, r_PackedHalf2AtPtx1145R755, r_PackedHalf2AtPtx1138R756;
	uint32_t r_PackedHalf2AtPtx1348R757, r_PackedHalf2AtPtx1355R758, r_PtxRegister759,
		r_MmaBE4x4WordAtPtx142R760, r_MmaBE4x4WordAtPtx142R761, r_MmaBE4x4WordAtPtx142R762,
		r_MmaBE4x4WordAtPtx133R763, r_MmaBE4x4WordAtPtx133R764, r_MmaBE4x4WordAtPtx133R765,
		r_MmaBE4x4WordAtPtx133R766, r_MmaBE4x4WordAtPtx124R767, r_MmaBE4x4WordAtPtx124R768;
	uint32_t r_MmaBE4x4WordAtPtx124R769, r_MmaBE4x4WordAtPtx124R770, r_MmaBE4x4WordAtPtx115R771,
		r_MmaBE4x4WordAtPtx115R772, r_MmaBE4x4WordAtPtx115R773, r_MmaBE4x4WordAtPtx115R774,
		r_MmaBE4x4WordAtPtx106R775, r_MmaBE4x4WordAtPtx106R776, r_MmaBE4x4WordAtPtx106R777,
		r_MmaBE4x4WordAtPtx106R778, r_MmaBE4x4WordAtPtx97R779, r_MmaBE4x4WordAtPtx97R780;
	uint32_t r_MmaBE4x4WordAtPtx97R781, r_MmaBE4x4WordAtPtx97R782, r_MmaBE4x4WordAtPtx87R783,
		r_MmaBE4x4WordAtPtx87R784, r_MmaBE4x4WordAtPtx87R785, r_MmaBE4x4WordAtPtx87R786,
		r_MmaBE4x4WordAtPtx78R787, r_MmaBE4x4WordAtPtx78R788, r_MmaBE4x4WordAtPtx78R789,
		r_MmaBE4x4WordAtPtx78R790, r_MmaBE4x4WordAtPtx142R791;
	uint64_t g_StateBaseAddress, g_ResidualBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress,
		g_OutputByteAddressAtPtx1910, g_RecordByteAddressAtPtx76, g_RecordByteAddressAtPtx85,
		g_RecordByteAddressAtPtx95, g_RecordByteAddressAtPtx104, g_RecordByteAddressAtPtx113,
		g_RecordByteAddressAtPtx122, g_RecordByteAddressAtPtx131;
	uint64_t g_RecordByteAddressAtPtx140, r_PtxU64Register14, g_RecordByteAddressAtPtx71, r_PtxU64Register16,
		r_PtxU64Register17, g_RecordByteAddressAtPtx84, r_PtxU64Register19, g_RecordByteAddressAtPtx94,
		r_PtxU64Register21, g_RecordByteAddressAtPtx103, r_PtxU64Register23, g_RecordByteAddressAtPtx112;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx121, r_PtxU64Register27, g_RecordByteAddressAtPtx130,
		r_PtxU64Register29, g_RecordByteAddressAtPtx139, r_PtxU64Register31, r_PtxU64Register32,
		r_PtxU64Register33, r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, g_ResidualByteAddressAtPtx419, r_PtxU64Register39,
		g_ResidualByteAddressAtPtx414, r_PtxU64Register41, g_ResidualByteAddressAtPtx456, r_PtxU64Register43,
		g_ResidualByteAddressAtPtx451, r_PtxU64Register45, g_ResidualByteAddressAtPtx498, r_PtxU64Register47,
		g_ResidualByteAddressAtPtx493;
	uint64_t r_PtxU64Register49, g_ResidualByteAddressAtPtx535, r_PtxU64Register51,
		g_ResidualByteAddressAtPtx530, r_PtxU64Register53, g_RecordByteAddressAtPtx656, r_PtxU64Register55,
		g_RecordByteAddressAtPtx669, r_PtxU64Register57, g_RecordByteAddressAtPtx683, r_PtxU64Register59,
		g_RecordByteAddressAtPtx697;
	uint64_t r_PtxU64Register61, g_RecordByteAddressAtPtx711, r_PtxU64Register63, g_RecordByteAddressAtPtx726,
		r_PtxU64Register65, g_RecordByteAddressAtPtx740, r_PtxU64Register67, g_RecordByteAddressAtPtx757,
		r_PtxU64Register69, g_RecordByteAddressAtPtx773, r_PtxU64Register71, g_RecordByteAddressAtPtx787;
	uint64_t r_PtxU64Register73, g_RecordByteAddressAtPtx801, r_PtxU64Register75, g_RecordByteAddressAtPtx818,
		r_PtxU64Register77, g_RecordByteAddressAtPtx834, r_PtxU64Register79, g_RecordByteAddressAtPtx849,
		r_PtxU64Register81, g_RecordByteAddressAtPtx863, r_PtxU64Register83, g_RecordByteAddressAtPtx880;
	uint64_t r_PtxU64Register85, g_RecordByteAddressAtPtx896, r_PtxU64Register87, g_RecordByteAddressAtPtx910,
		r_PtxU64Register89, g_RecordByteAddressAtPtx924, r_PtxU64Register91, g_RecordByteAddressAtPtx938,
		r_PtxU64Register93, g_RecordByteAddressAtPtx952, r_PtxU64Register95, g_RecordByteAddressAtPtx966;
	uint64_t r_PtxU64Register97, g_RecordByteAddressAtPtx980, r_PtxU64Register99, g_RecordByteAddressAtPtx996,
		r_PtxU64Register101, g_RecordByteAddressAtPtx1012, r_PtxU64Register103, g_RecordByteAddressAtPtx1026,
		r_PtxU64Register105, g_RecordByteAddressAtPtx1040, r_PtxU64Register107, g_RecordByteAddressAtPtx1056;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx1072, r_PtxU64Register111,
		g_RecordByteAddressAtPtx1086, r_PtxU64Register113, g_RecordByteAddressAtPtx1100, r_PtxU64Register115,
		g_RecordByteAddressAtPtx1116, r_PtxU64Register117, g_RecordByteAddressAtPtx1132,
		g_RecordByteAddressAtPtx1646, g_RecordByteAddressAtPtx1655;
	uint64_t g_RecordByteAddressAtPtx1664, g_RecordByteAddressAtPtx1673, g_RecordByteAddressAtPtx1682,
		g_RecordByteAddressAtPtx1691, g_RecordByteAddressAtPtx1700, g_RecordByteAddressAtPtx1709,
		r_PtxU64Register127, g_RecordByteAddressAtPtx1641, r_PtxU64Register129, r_PtxU64Register130,
		g_RecordByteAddressAtPtx1654, r_PtxU64Register132;
	uint64_t g_RecordByteAddressAtPtx1663, r_PtxU64Register134, g_RecordByteAddressAtPtx1672,
		r_PtxU64Register136, g_RecordByteAddressAtPtx1681, r_PtxU64Register138, g_RecordByteAddressAtPtx1690,
		r_PtxU64Register140, g_RecordByteAddressAtPtx1699, r_PtxU64Register142, g_RecordByteAddressAtPtx1708,
		r_PtxU64Register144;
	uint64_t r_PtxU64Register145, r_PtxU64Register146, r_PtxU64Register147, g_OutputByteAddressAtPtx1925,
		g_OutputByteAddressAtPtx1934, r_PtxU64Register150, r_PtxU64Register151, g_OutputByteAddressAtPtx1933,
		g_OutputByteAddressAtPtx1947, g_OutputByteAddressAtPtx1960, r_PtxU64Register155,
		g_OutputByteAddressAtPtx1946;
	uint64_t r_PtxU64Register157, g_OutputByteAddressAtPtx1959, r_PtxU64Register159, r_PtxU64Register160,
		r_PtxU64Register161, r_PtxU64Register162, r_PtxU64Register163, r_PtxU64Register164,
		r_PtxU64Register165, r_PtxU64Register166;
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
	r_PtxRegister30 = uint32_t(r_WidthBits) + uint32_t(-1);						// PTX L22
	r_PtxRegister31 = ShiftRightSigned(int32_t(r_PtxRegister30), uint32_t(31)); // PTX L23
	r_PtxRegister32 = ShiftRight(uint32_t(r_PtxRegister31), uint32_t(29));		// PTX L24
	r_PtxRegister33 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);	// PTX L25
	r_PtxRegister34 = ShiftRightSigned(int32_t(r_PtxRegister33), uint32_t(3));	// PTX L26
	r_PtxRegister35 = uint32_t(r_PtxRegister34) + uint32_t(1);					// PTX L27
	r_PtxRegister5 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister35));		// PTX L28
	r_PtxRegister36 =
		uint32_t(r_PtxRegister5) * uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister5); // PTX L29
	r_PtxRegister37 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister36);						 // PTX L30
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister37), uint32_t(1));					 // PTX L31
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
	r_PtxRegister45 = r_ThreadX | r_ThreadY;											 // PTX L43
	r_bPtxPredicate8 = uint32_t(r_PtxRegister45) != uint32_t(0);						 // PTX L44
	if (r_bPtxPredicate8)
	{
		goto L__BB27_2;
	} // PTX L45
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L46
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L47
	r_PtxRegister47 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L48
	r_PtxRegister46 = uint32_t(12288u /* exact native shared-region offset */); // PTX L49
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister46, r_PtxRegister47); // PTX L51
	r_PtxRegister48 = uint32_t(r_PtxRegister46) + uint32_t(8);		// PTX L53
	BarrierInit(s_SharedStorage, r_PtxRegister48, r_PtxRegister47); // PTX L55
	r_PtxRegister49 = uint32_t(r_PtxRegister46) + uint32_t(16);		// PTX L57
	BarrierInit(s_SharedStorage, r_PtxRegister49, r_PtxRegister47); // PTX L59
L__BB27_2:															// PTX L61
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L62
	r_PtxRegister60 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L63
	r_PtxRegister61 = r_PtxRegister60 & 192;													// PTX L64
	r_PtxRegister62 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(8));							// PTX L65
	r_PtxRegister11 = r_PtxRegister61 | r_PtxRegister62;										// PTX L66
	r_PtxRegister63 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(16));								// PTX L67
	r_PtxRegister12 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(3));						// PTX L68
	r_PtxRegister64 = uint32_t(r_PtxRegister63) + uint32_t(r_PtxRegister12);					// PTX L69
	r_PtxU64Register14 = uint64_t(int64_t(int32_t(r_PtxRegister64)) * int64_t(int32_t(4)));		// PTX L70
	g_RecordByteAddressAtPtx71 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register14);	// PTX L71
	r_LaneIndexAtPtx73 = uint32_t((threadIdx.x & 31u));											// PTX L73
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx73)) * int64_t(int32_t(16))); // PTX L75
	g_RecordByteAddressAtPtx76 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register16); // PTX L76
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx76));
		r_MmaBE4x4WordAtPtx78R790 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R789 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R788 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R787 = r_Value.w;
	} // PTX L78
	r_LaneIndexAtPtx81 = uint32_t((threadIdx.x & 31u));											// PTX L81
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx81)) * int64_t(int32_t(16))); // PTX L83
	g_RecordByteAddressAtPtx84 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register17);		   // PTX L84
	g_RecordByteAddressAtPtx85 = uint64_t(g_RecordByteAddressAtPtx84) + uint64_t(512); // PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx85));
		r_MmaBE4x4WordAtPtx87R786 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R785 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R784 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R783 = r_Value.w;
	} // PTX L87
	r_PtxRegister13 = r_PtxRegister11 | 32;														// PTX L89
	r_LaneIndexAtPtx91 = uint32_t((threadIdx.x & 31u));											// PTX L91
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx91)) * int64_t(int32_t(16))); // PTX L93
	g_RecordByteAddressAtPtx94 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register19);			// PTX L94
	g_RecordByteAddressAtPtx95 = uint64_t(g_RecordByteAddressAtPtx94) + uint64_t(1024); // PTX L95
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx95));
		r_MmaBE4x4WordAtPtx97R782 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R781 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R780 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R779 = r_Value.w;
	} // PTX L97
	r_LaneIndexAtPtx100 = uint32_t((threadIdx.x & 31u));										 // PTX L100
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx100)) * int64_t(int32_t(16))); // PTX L102
	g_RecordByteAddressAtPtx103 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register21);			  // PTX L103
	g_RecordByteAddressAtPtx104 = uint64_t(g_RecordByteAddressAtPtx103) + uint64_t(1536); // PTX L104
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx104));
		r_MmaBE4x4WordAtPtx106R778 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R777 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R776 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R775 = r_Value.w;
	} // PTX L106
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	g_RecordByteAddressAtPtx112 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register23);			   // PTX L112
	g_RecordByteAddressAtPtx113 = uint64_t(g_RecordByteAddressAtPtx112) + uint64_t(16384); // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx113));
		r_MmaBE4x4WordAtPtx115R774 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R773 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R772 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R771 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	g_RecordByteAddressAtPtx121 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register25);			   // PTX L121
	g_RecordByteAddressAtPtx122 = uint64_t(g_RecordByteAddressAtPtx121) + uint64_t(16896); // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx122));
		r_MmaBE4x4WordAtPtx124R770 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R769 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R768 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R767 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	g_RecordByteAddressAtPtx130 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register27);			   // PTX L130
	g_RecordByteAddressAtPtx131 = uint64_t(g_RecordByteAddressAtPtx130) + uint64_t(17408); // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx131));
		r_MmaBE4x4WordAtPtx133R766 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R765 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R764 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R763 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	g_RecordByteAddressAtPtx139 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register29);			   // PTX L139
	g_RecordByteAddressAtPtx140 = uint64_t(g_RecordByteAddressAtPtx139) + uint64_t(17920); // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx140));
		r_MmaBE4x4WordAtPtx142R762 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R761 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R760 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R791 = r_Value.w;
	} // PTX L142
	r_PtxRegister65 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			  // PTX L144
	r_PtxRegister66 = r_PtxRegister65 & 1;									  // PTX L145
	r_PtxRegister14 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));			  // PTX L146
	r_PtxRegister67 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(5));			  // PTX L147
	r_PtxRegister68 = r_PtxRegister67 & 32;									  // PTX L148
	r_PtxRegister69 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(9));	  // PTX L149
	r_PtxRegister70 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L150
	r_PtxRegister71 = r_PtxRegister70 & 256;								  // PTX L151
	r_PtxRegister72 = r_PtxRegister69 | r_PtxRegister71;					  // PTX L152
	r_PtxRegister73 = r_PtxRegister70 & 128;								  // PTX L153
	r_PtxRegister15 = r_PtxRegister72 | r_PtxRegister73;					  // PTX L154
	r_PtxRegister74 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));				  // PTX L155
	r_PtxRegister75 = uint32_t(r_PtxRegister14) + uint32_t(r_PtxRegister74);  // PTX L156
	r_PtxRegister16 = uint32_t(r_PtxRegister66) + uint32_t(r_PtxRegister6);	  // PTX L157
	r_PtxRegister17 = uint32_t(r_PtxRegister68) + uint32_t(r_PtxRegister7);	  // PTX L158
	r_PtxRegister18 = r_HeightBits & -4;									  // PTX L159
	r_bPtxPredicate9 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L160
	r_bPtxPredicate10 = int32_t(r_PtxRegister75) < int32_t(r_HeightDiv4Bits); // PTX L161
	r_PtxRegister19 = uint32_t(r_PtxRegister75) * uint32_t(r_WidthDiv4Bits);  // PTX L162
	r_PtxRegister20 = r_bPtxPredicate9 ? 0 : r_PtxRegister19;				  // PTX L163
	r_bPtxPredicate1 = r_bPtxPredicate9 | r_bPtxPredicate10;				  // PTX L164
	r_bPtxPredicate46 = bool(0);											  // PTX L165
	r_bPtxPredicate11 = !r_bPtxPredicate1;									  // PTX L166
	r_PtxRegister708 = uint32_t(r_PtxRegister16);							  // PTX L167
	if (r_bPtxPredicate11)
	{
		goto L__BB27_5;
	} // PTX L168
	r_PtxRegister76 = r_WidthBits & -4;							  // PTX L169
	r_bPtxPredicate12 = uint32_t(r_PtxRegister76) == uint32_t(4); // PTX L170
	r_bPtxPredicate46 = bool(-1);								  // PTX L171
	r_PtxRegister708 = uint32_t(0);								  // PTX L172
	if (r_bPtxPredicate12)
	{
		goto L__BB27_5;
	} // PTX L173
	r_bPtxPredicate46 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L174
	r_PtxRegister708 = uint32_t(r_PtxRegister16);							 // PTX L175
L__BB27_5:																	 // PTX L176
	r_PtxU64Register159 = uint64_t(0);										 // PTX L177
	r_bPtxPredicate13 = !r_bPtxPredicate46;									 // PTX L178
	if (r_bPtxPredicate13)
	{
		goto L__BB27_7;
	} // PTX L179
	r_PtxRegister77 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister708); // PTX L180
	r_PtxRegister78 = ShiftLeft(uint32_t(r_PtxRegister77), uint32_t(11));	  // PTX L181
	r_PtxRegister79 = ShiftLeft(uint32_t(r_PtxRegister17), uint32_t(2));	  // PTX L182
	r_PtxRegister80 = uint32_t(r_PtxRegister78) + uint32_t(r_PtxRegister79);  // PTX L183
	r_PtxU64Register159 = SignExtendWordBits(r_PtxRegister80);				  // PTX L184
L__BB27_7:																	  // PTX L185
	r_PtxU64Register160 = uint64_t(0);										  // PTX L186
	if (r_bPtxPredicate13)
	{
		goto L__BB27_9;
	} // PTX L187
	r_PtxU64Register31 = ShiftLeft(uint64_t(r_PtxU64Register159), uint32_t(2));		   // PTX L188
	r_PtxU64Register160 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register31); // PTX L189
L__BB27_9:																			   // PTX L190
	r_PtxRegister81 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));			   // PTX L191
	r_PtxRegister82 = uint32_t(0u /* exact native shared-region offset */);			   // PTX L192
	r_PtxRegister91 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister81);		   // PTX L193
	if (r_bPtxPredicate13)
	{
		goto L__BB27_12;
	} // PTX L194
	r_PtxRegister90 = uint32_t(-1);								  // PTX L195
	r_PtxRegister89 = Elected(r_PtxRegister90);					  // PTX L197
	r_bPtxPredicate14 = uint32_t(r_PtxRegister89) == uint32_t(0); // PTX L203
	if (r_bPtxPredicate14)
	{
		goto L__BB27_13;
	} // PTX L204
	r_PtxU64Register32 = r_PtxU64Register160;									// PTX L205
	r_PtxRegister93 = uint32_t(12288u /* exact native shared-region offset */); // PTX L206
	r_PtxRegister92 = uint32_t(512);											// PTX L207
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister91, r_PtxU64Register32, r_PtxRegister92,
			 r_PtxRegister93);																 // PTX L209
	BarrierExpect(s_SharedStorage, r_PtxRegister93, r_PtxRegister92);						 // PTX L212
	goto L__BB27_13;																		 // PTX L214
L__BB27_12:																					 // PTX L215
	r_PtxRegister83 = uint32_t(0);															 // PTX L216
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister83))); // PTX L218
	r_PackedHalf2AtPtx221R84 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L221
	r_ConvertedE4PairAtPtx223Rs2 = PublishE4(r_PackedHalf2AtPtx221R84);						 // PTX L223
	r_PackedE4WordAtPtx225R87 =
		JoinHalfwords(r_ConvertedE4PairAtPtx223Rs2, r_ConvertedE4PairAtPtx223Rs2); // PTX L225
	r_LaneIndexAtPtx227 = uint32_t((threadIdx.x & 31u));						   // PTX L227
	r_PtxRegister88 = ShiftLeft(uint32_t(r_LaneIndexAtPtx227), uint32_t(4));	   // PTX L229
	r_PtxRegister86 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister88);	   // PTX L230
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister86)) =
		make_uint4(r_PackedE4WordAtPtx225R87, r_PackedE4WordAtPtx225R87, r_PackedE4WordAtPtx225R87,
				   r_PackedE4WordAtPtx225R87);					// PTX L232
L__BB27_13:														// PTX L234
	r_PtxRegister21 = uint32_t(r_PtxRegister17) + uint32_t(64); // PTX L235
	r_bPtxPredicate47 = bool(0);								// PTX L236
	r_PtxRegister709 = uint32_t(r_PtxRegister16);				// PTX L237
	if (r_bPtxPredicate11)
	{
		goto L__BB27_16;
	} // PTX L238
	r_PtxRegister94 = r_WidthBits & -4;							  // PTX L239
	r_bPtxPredicate15 = uint32_t(r_PtxRegister94) == uint32_t(4); // PTX L240
	r_bPtxPredicate47 = bool(-1);								  // PTX L241
	r_PtxRegister709 = uint32_t(0);								  // PTX L242
	if (r_bPtxPredicate15)
	{
		goto L__BB27_16;
	} // PTX L243
	r_bPtxPredicate47 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L244
	r_PtxRegister709 = uint32_t(r_PtxRegister16);							 // PTX L245
L__BB27_16:																	 // PTX L246
	r_PtxU64Register161 = uint64_t(0);										 // PTX L247
	r_bPtxPredicate16 = !r_bPtxPredicate47;									 // PTX L248
	if (r_bPtxPredicate16)
	{
		goto L__BB27_18;
	} // PTX L249
	r_PtxRegister95 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister709); // PTX L250
	r_PtxRegister96 = ShiftLeft(uint32_t(r_PtxRegister95), uint32_t(11));	  // PTX L251
	r_PtxRegister97 = ShiftLeft(uint32_t(r_PtxRegister21), uint32_t(2));	  // PTX L252
	r_PtxRegister98 = uint32_t(r_PtxRegister96) + uint32_t(r_PtxRegister97);  // PTX L253
	r_PtxU64Register161 = SignExtendWordBits(r_PtxRegister98);				  // PTX L254
L__BB27_18:																	  // PTX L255
	r_PtxU64Register162 = uint64_t(0);										  // PTX L256
	if (r_bPtxPredicate16)
	{
		goto L__BB27_20;
	} // PTX L257
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register161), uint32_t(2));		   // PTX L258
	r_PtxU64Register162 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register33); // PTX L259
L__BB27_20:																			   // PTX L260
	if (r_bPtxPredicate16)
	{
		goto L__BB27_23;
	} // PTX L261
	r_PtxRegister107 = uint32_t(-1);							   // PTX L262
	r_PtxRegister106 = Elected(r_PtxRegister107);				   // PTX L264
	r_bPtxPredicate17 = uint32_t(r_PtxRegister106) == uint32_t(0); // PTX L270
	if (r_bPtxPredicate17)
	{
		goto L__BB27_24;
	} // PTX L271
	r_PtxRegister108 = uint32_t(r_PtxRegister91) + uint32_t(4096);				 // PTX L272
	r_PtxU64Register34 = r_PtxU64Register162;									 // PTX L273
	r_PtxRegister111 = uint32_t(12288u /* exact native shared-region offset */); // PTX L274
	r_PtxRegister110 = uint32_t(r_PtxRegister111) + uint32_t(8);				 // PTX L275
	r_PtxRegister109 = uint32_t(512);											 // PTX L276
	CopyBulk(s_SharedStorage, r_PtxRegister108, r_PtxU64Register34, r_PtxRegister109,
			 r_PtxRegister110);																 // PTX L278
	BarrierExpect(s_SharedStorage, r_PtxRegister110, r_PtxRegister109);						 // PTX L281
	goto L__BB27_24;																		 // PTX L283
L__BB27_23:																					 // PTX L284
	r_PtxRegister99 = uint32_t(0);															 // PTX L285
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister99))); // PTX L287
	r_PackedHalf2AtPtx290R100 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		 // PTX L290
	r_ConvertedE4PairAtPtx292Rs4 = PublishE4(r_PackedHalf2AtPtx290R100);					 // PTX L292
	r_PackedE4WordAtPtx294R103 =
		JoinHalfwords(r_ConvertedE4PairAtPtx292Rs4, r_ConvertedE4PairAtPtx292Rs4); // PTX L294
	r_LaneIndexAtPtx296 = uint32_t((threadIdx.x & 31u));						   // PTX L296
	r_PtxRegister104 = ShiftLeft(uint32_t(r_LaneIndexAtPtx296), uint32_t(4));	   // PTX L298
	r_PtxRegister105 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister104);	   // PTX L299
	r_PtxRegister102 = uint32_t(r_PtxRegister105) + uint32_t(4096);				   // PTX L300
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister102)) =
		make_uint4(r_PackedE4WordAtPtx294R103, r_PackedE4WordAtPtx294R103, r_PackedE4WordAtPtx294R103,
				   r_PackedE4WordAtPtx294R103);	  // PTX L302
L__BB27_24:										  // PTX L304
	r_bPtxPredicate48 = bool(0);				  // PTX L305
	r_PtxRegister710 = uint32_t(r_PtxRegister16); // PTX L306
	if (r_bPtxPredicate11)
	{
		goto L__BB27_27;
	} // PTX L307
	r_PtxRegister112 = r_WidthBits & -4;						   // PTX L308
	r_bPtxPredicate18 = uint32_t(r_PtxRegister112) == uint32_t(4); // PTX L309
	r_bPtxPredicate48 = bool(-1);								   // PTX L310
	r_PtxRegister710 = uint32_t(0);								   // PTX L311
	if (r_bPtxPredicate18)
	{
		goto L__BB27_27;
	} // PTX L312
	r_bPtxPredicate48 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L313
	r_PtxRegister710 = uint32_t(r_PtxRegister16);							 // PTX L314
L__BB27_27:																	 // PTX L315
	r_PtxU64Register163 = uint64_t(0);										 // PTX L316
	r_bPtxPredicate19 = !r_bPtxPredicate48;									 // PTX L317
	if (r_bPtxPredicate19)
	{
		goto L__BB27_29;
	} // PTX L318
	r_PtxRegister113 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister710);	// PTX L319
	r_PtxRegister114 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(11));		// PTX L320
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister17), uint32_t(2));		// PTX L321
	r_PtxRegister116 = uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister114); // PTX L322
	r_PtxRegister117 = uint32_t(r_PtxRegister116) + uint32_t(512);				// PTX L323
	r_PtxU64Register163 = SignExtendWordBits(r_PtxRegister117);					// PTX L324
L__BB27_29:																		// PTX L325
	r_PtxU64Register164 = uint64_t(0);											// PTX L326
	if (r_bPtxPredicate19)
	{
		goto L__BB27_31;
	} // PTX L327
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register163), uint32_t(2));		   // PTX L328
	r_PtxU64Register164 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register35); // PTX L329
L__BB27_31:																			   // PTX L330
	if (r_bPtxPredicate19)
	{
		goto L__BB27_34;
	} // PTX L331
	r_PtxRegister126 = uint32_t(-1);							   // PTX L332
	r_PtxRegister125 = Elected(r_PtxRegister126);				   // PTX L334
	r_bPtxPredicate20 = uint32_t(r_PtxRegister125) == uint32_t(0); // PTX L340
	if (r_bPtxPredicate20)
	{
		goto L__BB27_35;
	} // PTX L341
	r_PtxRegister127 = uint32_t(r_PtxRegister91) + uint32_t(8192);				 // PTX L342
	r_PtxU64Register36 = r_PtxU64Register164;									 // PTX L343
	r_PtxRegister130 = uint32_t(12288u /* exact native shared-region offset */); // PTX L344
	r_PtxRegister129 = uint32_t(r_PtxRegister130) + uint32_t(16);				 // PTX L345
	r_PtxRegister128 = uint32_t(512);											 // PTX L346
	CopyBulk(s_SharedStorage, r_PtxRegister127, r_PtxU64Register36, r_PtxRegister128,
			 r_PtxRegister129);																  // PTX L348
	BarrierExpect(s_SharedStorage, r_PtxRegister129, r_PtxRegister128);						  // PTX L351
	goto L__BB27_35;																		  // PTX L353
L__BB27_34:																					  // PTX L354
	r_PtxRegister118 = uint32_t(0);															  // PTX L355
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister118))); // PTX L357
	r_PackedHalf2AtPtx360R119 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);		  // PTX L360
	r_ConvertedE4PairAtPtx362Rs6 = PublishE4(r_PackedHalf2AtPtx360R119);					  // PTX L362
	r_PackedE4WordAtPtx364R122 =
		JoinHalfwords(r_ConvertedE4PairAtPtx362Rs6, r_ConvertedE4PairAtPtx362Rs6); // PTX L364
	r_LaneIndexAtPtx366 = uint32_t((threadIdx.x & 31u));						   // PTX L366
	r_PtxRegister123 = ShiftLeft(uint32_t(r_LaneIndexAtPtx366), uint32_t(4));	   // PTX L368
	r_PtxRegister124 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister123);	   // PTX L369
	r_PtxRegister121 = uint32_t(r_PtxRegister124) + uint32_t(8192);				   // PTX L370
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister121)) =
		make_uint4(r_PackedE4WordAtPtx364R122, r_PackedE4WordAtPtx364R122, r_PackedE4WordAtPtx364R122,
				   r_PackedE4WordAtPtx364R122);									 // PTX L372
L__BB27_35:																		 // PTX L374
	r_PtxRegister131 = uint32_t(12288u /* exact native shared-region offset */); // PTX L375
	r_PtxRegister132 = uint32_t(1);												 // PTX L376
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register37 = BarrierArrive(s_SharedStorage, r_PtxRegister131, r_PtxRegister132); // PTX L378
L__BB27_36:																					 // PTX L380
	r_PtxRegister134 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L381
	r_PtxRegister133 = BarrierReady(s_SharedStorage, r_PtxRegister134, r_PtxU64Register37);	 // PTX L383
	r_bPtxPredicate21 = uint32_t(r_PtxRegister133) == uint32_t(0);							 // PTX L389
	if (r_bPtxPredicate21)
	{
		goto L__BB27_36;
	} // PTX L390
	r_bPtxPredicate22 = uint32_t(r_PtxRegister18) == uint32_t(4);			   // PTX L391
	r_bPtxPredicate23 = uint32_t(r_PtxRegister18) != uint32_t(4);			   // PTX L392
	r_PtxRegister135 = r_WidthBits & -4;									   // PTX L393
	r_bPtxPredicate24 = uint32_t(r_PtxRegister135) == uint32_t(4);			   // PTX L394
	r_bPtxPredicate25 = int32_t(r_PtxRegister75) < int32_t(r_HeightDiv4Bits);  // PTX L395
	r_bPtxPredicate26 = int32_t(r_PtxRegister75) >= int32_t(r_HeightDiv4Bits); // PTX L396
	r_bPtxPredicate27 = r_bPtxPredicate23 & r_bPtxPredicate26;				   // PTX L397
	r_bPtxPredicate2 = r_bPtxPredicate22 | r_bPtxPredicate25;				   // PTX L398
	r_bPtxPredicate3 = r_bPtxPredicate27 | r_bPtxPredicate24;				   // PTX L399
	r_bPtxPredicate28 = int32_t(r_PtxRegister6) < int32_t(r_WidthDiv4Bits);	   // PTX L400
	r_bPtxPredicate29 = !r_bPtxPredicate27;									   // PTX L401
	r_bPtxPredicate4 = r_bPtxPredicate24 & r_bPtxPredicate29;				   // PTX L402
	r_PtxRegister22 = r_bPtxPredicate4 ? 0 : r_PtxRegister6;				   // PTX L403
	r_bPtxPredicate30 = r_bPtxPredicate3 | r_bPtxPredicate28;				   // PTX L404
	r_bPtxPredicate5 = r_bPtxPredicate30 & r_bPtxPredicate2;				   // PTX L405
	if (r_bPtxPredicate5)
	{
		goto L__BB27_39;
	} // PTX L406
	goto L__BB27_38;																		 // PTX L407
L__BB27_39:																					 // PTX L408
	r_PtxRegister139 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister22);				 // PTX L409
	r_PtxRegister140 = ShiftLeft(uint32_t(r_PtxRegister139), uint32_t(11));					 // PTX L410
	r_PtxRegister141 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));					 // PTX L411
	r_PtxRegister142 = uint32_t(r_PtxRegister140) + uint32_t(r_PtxRegister141);				 // PTX L412
	r_PtxU64Register39 = uint64_t(int64_t(int32_t(r_PtxRegister142)) * int64_t(int32_t(4))); // PTX L413
	g_ResidualByteAddressAtPtx414 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register39);							 // PTX L414
	r_LaneIndexAtPtx416 = uint32_t((threadIdx.x & 31u));										 // PTX L416
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx416)) * int64_t(int32_t(16))); // PTX L418
	g_ResidualByteAddressAtPtx419 =
		uint64_t(g_ResidualByteAddressAtPtx414) + uint64_t(r_PtxU64Register41); // PTX L419
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx419));
		r_PtxRegister711 = r_Value.x;
		r_PtxRegister712 = r_Value.y;
		r_PtxRegister713 = r_Value.z;
		r_PtxRegister714 = r_Value.w;
	} // PTX L421
	goto L__BB27_40;																			  // PTX L423
L__BB27_38:																						  // PTX L424
	r_PtxRegister136 = uint32_t(0);																  // PTX L425
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister136)));	  // PTX L427
	r_PackedHalf2AtPtx430R137 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);			  // PTX L430
	r_ConvertedE4PairAtPtx432Rs8 = PublishE4(r_PackedHalf2AtPtx430R137);						  // PTX L432
	r_PtxRegister711 = JoinHalfwords(r_ConvertedE4PairAtPtx432Rs8, r_ConvertedE4PairAtPtx432Rs8); // PTX L434
	r_PtxRegister712 = uint32_t(r_PtxRegister711);												  // PTX L435
	r_PtxRegister713 = uint32_t(r_PtxRegister711);												  // PTX L436
	r_PtxRegister714 = uint32_t(r_PtxRegister711);												  // PTX L437
L__BB27_40:																						  // PTX L438
	r_PtxU16Register15 = uint16_t(r_PtxRegister711);
	r_PtxU16Register16 = uint16_t(r_PtxRegister711 >> 16); // PTX L439
	r_PtxU16Register21 = uint16_t(r_PtxRegister714);
	r_PtxU16Register22 = uint16_t(r_PtxRegister714 >> 16); // PTX L440
	r_PtxU16Register19 = uint16_t(r_PtxRegister713);
	r_PtxU16Register20 = uint16_t(r_PtxRegister713 >> 16); // PTX L441
	r_PtxU16Register17 = uint16_t(r_PtxRegister712);
	r_PtxU16Register18 = uint16_t(r_PtxRegister712 >> 16); // PTX L442
	if (r_bPtxPredicate5)
	{
		goto L__BB27_42;
	} // PTX L443
	goto L__BB27_41;																		 // PTX L444
L__BB27_42:																					 // PTX L445
	r_PtxRegister146 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister22);				 // PTX L446
	r_PtxRegister147 = ShiftLeft(uint32_t(r_PtxRegister146), uint32_t(11));					 // PTX L447
	r_PtxRegister148 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(2));					 // PTX L448
	r_PtxRegister149 = uint32_t(r_PtxRegister147) + uint32_t(r_PtxRegister148);				 // PTX L449
	r_PtxU64Register43 = uint64_t(int64_t(int32_t(r_PtxRegister149)) * int64_t(int32_t(4))); // PTX L450
	g_ResidualByteAddressAtPtx451 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register43);							 // PTX L451
	r_LaneIndexAtPtx453 = uint32_t((threadIdx.x & 31u));										 // PTX L453
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx453)) * int64_t(int32_t(16))); // PTX L455
	g_ResidualByteAddressAtPtx456 =
		uint64_t(g_ResidualByteAddressAtPtx451) + uint64_t(r_PtxU64Register45); // PTX L456
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx456));
		r_PtxRegister715 = r_Value.x;
		r_PtxRegister716 = r_Value.y;
		r_PtxRegister717 = r_Value.z;
		r_PtxRegister718 = r_Value.w;
	} // PTX L458
	goto L__BB27_43;																		  // PTX L460
L__BB27_41:																					  // PTX L461
	r_PtxRegister143 = uint32_t(0);															  // PTX L462
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister143))); // PTX L464
	r_PackedHalf2AtPtx467R144 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L467
	r_ConvertedE4PairAtPtx469Rs10 = PublishE4(r_PackedHalf2AtPtx467R144);					  // PTX L469
	r_PtxRegister715 =
		JoinHalfwords(r_ConvertedE4PairAtPtx469Rs10, r_ConvertedE4PairAtPtx469Rs10); // PTX L471
	r_PtxRegister716 = uint32_t(r_PtxRegister715);									 // PTX L472
	r_PtxRegister717 = uint32_t(r_PtxRegister715);									 // PTX L473
	r_PtxRegister718 = uint32_t(r_PtxRegister715);									 // PTX L474
L__BB27_43:																			 // PTX L475
	r_PtxRegister23 = uint32_t(r_PtxRegister6) + uint32_t(1);						 // PTX L476
	r_PtxU16Register29 = uint16_t(r_PtxRegister718);
	r_PtxU16Register30 = uint16_t(r_PtxRegister718 >> 16); // PTX L477
	r_PtxU16Register27 = uint16_t(r_PtxRegister717);
	r_PtxU16Register28 = uint16_t(r_PtxRegister717 >> 16); // PTX L478
	r_PtxU16Register25 = uint16_t(r_PtxRegister716);
	r_PtxU16Register26 = uint16_t(r_PtxRegister716 >> 16); // PTX L479
	r_PtxU16Register23 = uint16_t(r_PtxRegister715);
	r_PtxU16Register24 = uint16_t(r_PtxRegister715 >> 16);					 // PTX L480
	r_bPtxPredicate31 = int32_t(r_PtxRegister23) < int32_t(r_WidthDiv4Bits); // PTX L481
	r_PtxRegister24 = r_bPtxPredicate4 ? 0 : r_PtxRegister23;				 // PTX L482
	r_bPtxPredicate32 = r_bPtxPredicate3 | r_bPtxPredicate31;				 // PTX L483
	r_bPtxPredicate6 = r_bPtxPredicate32 & r_bPtxPredicate2;				 // PTX L484
	if (r_bPtxPredicate6)
	{
		goto L__BB27_45;
	} // PTX L485
	goto L__BB27_44;																		 // PTX L486
L__BB27_45:																					 // PTX L487
	r_PtxRegister153 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister24);				 // PTX L488
	r_PtxRegister154 = ShiftLeft(uint32_t(r_PtxRegister153), uint32_t(11));					 // PTX L489
	r_PtxRegister155 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));					 // PTX L490
	r_PtxRegister156 = uint32_t(r_PtxRegister154) + uint32_t(r_PtxRegister155);				 // PTX L491
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_PtxRegister156)) * int64_t(int32_t(4))); // PTX L492
	g_ResidualByteAddressAtPtx493 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register47);							 // PTX L493
	r_LaneIndexAtPtx495 = uint32_t((threadIdx.x & 31u));										 // PTX L495
	r_PtxU64Register49 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx495)) * int64_t(int32_t(16))); // PTX L497
	g_ResidualByteAddressAtPtx498 =
		uint64_t(g_ResidualByteAddressAtPtx493) + uint64_t(r_PtxU64Register49); // PTX L498
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx498));
		r_PtxRegister719 = r_Value.x;
		r_PtxRegister720 = r_Value.y;
		r_PtxRegister721 = r_Value.z;
		r_PtxRegister722 = r_Value.w;
	} // PTX L500
	goto L__BB27_46;																		   // PTX L502
L__BB27_44:																					   // PTX L503
	r_PtxRegister150 = uint32_t(0);															   // PTX L504
	r_PtxU16Register11 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister150))); // PTX L506
	r_PackedHalf2AtPtx509R151 = JoinHalfwords(r_PtxU16Register11, r_PtxU16Register11);		   // PTX L509
	r_ConvertedE4PairAtPtx511Rs12 = PublishE4(r_PackedHalf2AtPtx509R151);					   // PTX L511
	r_PtxRegister719 =
		JoinHalfwords(r_ConvertedE4PairAtPtx511Rs12, r_ConvertedE4PairAtPtx511Rs12); // PTX L513
	r_PtxRegister720 = uint32_t(r_PtxRegister719);									 // PTX L514
	r_PtxRegister721 = uint32_t(r_PtxRegister719);									 // PTX L515
	r_PtxRegister722 = uint32_t(r_PtxRegister719);									 // PTX L516
L__BB27_46:																			 // PTX L517
	r_PtxU16Register31 = uint16_t(r_PtxRegister719);
	r_PtxU16Register32 = uint16_t(r_PtxRegister719 >> 16); // PTX L518
	r_PtxU16Register37 = uint16_t(r_PtxRegister722);
	r_PtxU16Register38 = uint16_t(r_PtxRegister722 >> 16); // PTX L519
	r_PtxU16Register35 = uint16_t(r_PtxRegister721);
	r_PtxU16Register36 = uint16_t(r_PtxRegister721 >> 16); // PTX L520
	r_PtxU16Register33 = uint16_t(r_PtxRegister720);
	r_PtxU16Register34 = uint16_t(r_PtxRegister720 >> 16); // PTX L521
	if (r_bPtxPredicate6)
	{
		goto L__BB27_48;
	} // PTX L522
	goto L__BB27_47;																		 // PTX L523
L__BB27_48:																					 // PTX L524
	r_PtxRegister160 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister24);				 // PTX L525
	r_PtxRegister161 = ShiftLeft(uint32_t(r_PtxRegister160), uint32_t(11));					 // PTX L526
	r_PtxRegister162 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(2));					 // PTX L527
	r_PtxRegister163 = uint32_t(r_PtxRegister161) + uint32_t(r_PtxRegister162);				 // PTX L528
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_PtxRegister163)) * int64_t(int32_t(4))); // PTX L529
	g_ResidualByteAddressAtPtx530 =
		uint64_t(g_ResidualBaseAddress) + uint64_t(r_PtxU64Register51);							 // PTX L530
	r_LaneIndexAtPtx532 = uint32_t((threadIdx.x & 31u));										 // PTX L532
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx532)) * int64_t(int32_t(16))); // PTX L534
	g_ResidualByteAddressAtPtx535 =
		uint64_t(g_ResidualByteAddressAtPtx530) + uint64_t(r_PtxU64Register53); // PTX L535
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(g_ResidualByteAddressAtPtx535));
		r_PtxRegister723 = r_Value.x;
		r_PtxRegister724 = r_Value.y;
		r_PtxRegister725 = r_Value.z;
		r_PtxRegister726 = r_Value.w;
	} // PTX L537
	goto L__BB27_49;																		   // PTX L539
L__BB27_47:																					   // PTX L540
	r_PtxRegister157 = uint32_t(0);															   // PTX L541
	r_PtxU16Register13 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister157))); // PTX L543
	r_PackedHalf2AtPtx546R158 = JoinHalfwords(r_PtxU16Register13, r_PtxU16Register13);		   // PTX L546
	r_ConvertedE4PairAtPtx548Rs14 = PublishE4(r_PackedHalf2AtPtx546R158);					   // PTX L548
	r_PtxRegister723 =
		JoinHalfwords(r_ConvertedE4PairAtPtx548Rs14, r_ConvertedE4PairAtPtx548Rs14); // PTX L550
	r_PtxRegister724 = uint32_t(r_PtxRegister723);									 // PTX L551
	r_PtxRegister725 = uint32_t(r_PtxRegister723);									 // PTX L552
	r_PtxRegister726 = uint32_t(r_PtxRegister723);									 // PTX L553
L__BB27_49:																			 // PTX L554
	r_PackedHalf2AtPtx556R197 = DecodeE4(r_PtxU16Register15);						 // PTX L556
	r_PackedHalf2AtPtx559R203 = DecodeE4(r_PtxU16Register16);						 // PTX L559
	r_PackedHalf2AtPtx562R200 = DecodeE4(r_PtxU16Register17);						 // PTX L562
	r_PackedHalf2AtPtx565R206 = DecodeE4(r_PtxU16Register18);						 // PTX L565
	r_PackedHalf2AtPtx568R209 = DecodeE4(r_PtxU16Register19);						 // PTX L568
	r_PackedHalf2AtPtx571R215 = DecodeE4(r_PtxU16Register20);						 // PTX L571
	r_PackedHalf2AtPtx574R212 = DecodeE4(r_PtxU16Register21);						 // PTX L574
	r_PackedHalf2AtPtx577R218 = DecodeE4(r_PtxU16Register22);						 // PTX L577
	r_PackedHalf2AtPtx580R221 = DecodeE4(r_PtxU16Register23);						 // PTX L580
	r_PackedHalf2AtPtx583R227 = DecodeE4(r_PtxU16Register24);						 // PTX L583
	r_PackedHalf2AtPtx586R224 = DecodeE4(r_PtxU16Register25);						 // PTX L586
	r_PackedHalf2AtPtx589R230 = DecodeE4(r_PtxU16Register26);						 // PTX L589
	r_PackedHalf2AtPtx592R233 = DecodeE4(r_PtxU16Register27);						 // PTX L592
	r_PackedHalf2AtPtx595R239 = DecodeE4(r_PtxU16Register28);						 // PTX L595
	r_PackedHalf2AtPtx598R236 = DecodeE4(r_PtxU16Register29);						 // PTX L598
	r_PackedHalf2AtPtx601R242 = DecodeE4(r_PtxU16Register30);						 // PTX L601
	r_PackedHalf2AtPtx604R245 = DecodeE4(r_PtxU16Register31);						 // PTX L604
	r_PackedHalf2AtPtx607R251 = DecodeE4(r_PtxU16Register32);						 // PTX L607
	r_PackedHalf2AtPtx610R248 = DecodeE4(r_PtxU16Register33);						 // PTX L610
	r_PackedHalf2AtPtx613R254 = DecodeE4(r_PtxU16Register34);						 // PTX L613
	r_PackedHalf2AtPtx616R257 = DecodeE4(r_PtxU16Register35);						 // PTX L616
	r_PackedHalf2AtPtx619R263 = DecodeE4(r_PtxU16Register36);						 // PTX L619
	r_PackedHalf2AtPtx622R260 = DecodeE4(r_PtxU16Register37);						 // PTX L622
	r_PackedHalf2AtPtx625R266 = DecodeE4(r_PtxU16Register38);						 // PTX L625
	r_PtxU16Register39 = uint16_t(r_PtxRegister723);
	r_PtxU16Register40 = uint16_t(r_PtxRegister723 >> 16);	  // PTX L627
	r_PackedHalf2AtPtx629R269 = DecodeE4(r_PtxU16Register39); // PTX L629
	r_PackedHalf2AtPtx632R275 = DecodeE4(r_PtxU16Register40); // PTX L632
	r_PtxU16Register41 = uint16_t(r_PtxRegister724);
	r_PtxU16Register42 = uint16_t(r_PtxRegister724 >> 16);	  // PTX L634
	r_PackedHalf2AtPtx636R272 = DecodeE4(r_PtxU16Register41); // PTX L636
	r_PackedHalf2AtPtx639R278 = DecodeE4(r_PtxU16Register42); // PTX L639
	r_PtxU16Register43 = uint16_t(r_PtxRegister725);
	r_PtxU16Register44 = uint16_t(r_PtxRegister725 >> 16);	  // PTX L641
	r_PackedHalf2AtPtx643R281 = DecodeE4(r_PtxU16Register43); // PTX L643
	r_PackedHalf2AtPtx646R287 = DecodeE4(r_PtxU16Register44); // PTX L646
	r_PtxU16Register45 = uint16_t(r_PtxRegister726);
	r_PtxU16Register46 = uint16_t(r_PtxRegister726 >> 16);									 // PTX L648
	r_PackedHalf2AtPtx650R284 = DecodeE4(r_PtxU16Register45);								 // PTX L650
	r_PackedHalf2AtPtx653R290 = DecodeE4(r_PtxU16Register46);								 // PTX L653
	r_PtxRegister292 = uint32_t(r_PtxRegister11) + uint32_t(8);								 // PTX L655
	g_RecordByteAddressAtPtx656 = g_RecordBaseAddress;										 // PTX L656
	r_LaneIndexAtPtx658 = uint32_t((threadIdx.x & 31u));									 // PTX L658
	r_PtxRegister293 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx658), uint32_t(31));		 // PTX L660
	r_PtxRegister294 = ShiftRight(uint32_t(r_PtxRegister293), uint32_t(30));				 // PTX L661
	r_PtxRegister295 = uint32_t(r_LaneIndexAtPtx658) + uint32_t(r_PtxRegister294);			 // PTX L662
	r_PtxRegister296 = r_PtxRegister295 & 2147483644;										 // PTX L663
	r_PtxRegister297 = uint32_t(r_LaneIndexAtPtx658) - uint32_t(r_PtxRegister296);			 // PTX L664
	r_PtxRegister298 = ShiftLeft(uint32_t(r_PtxRegister297), uint32_t(1));					 // PTX L665
	r_PtxRegister299 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister298);				 // PTX L666
	r_PtxRegister300 = ShiftRightSigned(int32_t(r_PtxRegister299), uint32_t(1));			 // PTX L667
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_PtxRegister300)) * int64_t(int32_t(4))); // PTX L668
	g_RecordByteAddressAtPtx669 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register55); // PTX L669
	r_PtxRegister198 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx669 + 262144ull);		 // PTX L670
	r_LaneIndexAtPtx672 = uint32_t((threadIdx.x & 31u));									 // PTX L672
	r_PtxRegister301 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx672), uint32_t(31));		 // PTX L674
	r_PtxRegister302 = ShiftRight(uint32_t(r_PtxRegister301), uint32_t(30));				 // PTX L675
	r_PtxRegister303 = uint32_t(r_LaneIndexAtPtx672) + uint32_t(r_PtxRegister302);			 // PTX L676
	r_PtxRegister304 = r_PtxRegister303 & 2147483644;										 // PTX L677
	r_PtxRegister305 = uint32_t(r_LaneIndexAtPtx672) - uint32_t(r_PtxRegister304);			 // PTX L678
	r_PtxRegister306 = ShiftLeft(uint32_t(r_PtxRegister305), uint32_t(1));					 // PTX L679
	r_PtxRegister307 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister306);				 // PTX L680
	r_PtxRegister308 = ShiftRightSigned(int32_t(r_PtxRegister307), uint32_t(1));			 // PTX L681
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_PtxRegister308)) * int64_t(int32_t(4))); // PTX L682
	g_RecordByteAddressAtPtx683 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register57); // PTX L683
	r_PtxRegister201 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx683 + 262144ull);		 // PTX L684
	r_LaneIndexAtPtx686 = uint32_t((threadIdx.x & 31u));									 // PTX L686
	r_PtxRegister309 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx686), uint32_t(31));		 // PTX L688
	r_PtxRegister310 = ShiftRight(uint32_t(r_PtxRegister309), uint32_t(30));				 // PTX L689
	r_PtxRegister311 = uint32_t(r_LaneIndexAtPtx686) + uint32_t(r_PtxRegister310);			 // PTX L690
	r_PtxRegister312 = r_PtxRegister311 & 2147483644;										 // PTX L691
	r_PtxRegister313 = uint32_t(r_LaneIndexAtPtx686) - uint32_t(r_PtxRegister312);			 // PTX L692
	r_PtxRegister314 = ShiftLeft(uint32_t(r_PtxRegister313), uint32_t(1));					 // PTX L693
	r_PtxRegister315 = uint32_t(r_PtxRegister292) + uint32_t(r_PtxRegister314);				 // PTX L694
	r_PtxRegister316 = ShiftRightSigned(int32_t(r_PtxRegister315), uint32_t(1));			 // PTX L695
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_PtxRegister316)) * int64_t(int32_t(4))); // PTX L696
	g_RecordByteAddressAtPtx697 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register59); // PTX L697
	r_PtxRegister204 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx697 + 262144ull);		 // PTX L698
	r_LaneIndexAtPtx700 = uint32_t((threadIdx.x & 31u));									 // PTX L700
	r_PtxRegister317 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx700), uint32_t(31));		 // PTX L702
	r_PtxRegister318 = ShiftRight(uint32_t(r_PtxRegister317), uint32_t(30));				 // PTX L703
	r_PtxRegister319 = uint32_t(r_LaneIndexAtPtx700) + uint32_t(r_PtxRegister318);			 // PTX L704
	r_PtxRegister320 = r_PtxRegister319 & 2147483644;										 // PTX L705
	r_PtxRegister321 = uint32_t(r_LaneIndexAtPtx700) - uint32_t(r_PtxRegister320);			 // PTX L706
	r_PtxRegister322 = ShiftLeft(uint32_t(r_PtxRegister321), uint32_t(1));					 // PTX L707
	r_PtxRegister323 = uint32_t(r_PtxRegister292) + uint32_t(r_PtxRegister322);				 // PTX L708
	r_PtxRegister324 = ShiftRightSigned(int32_t(r_PtxRegister323), uint32_t(1));			 // PTX L709
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_PtxRegister324)) * int64_t(int32_t(4))); // PTX L710
	g_RecordByteAddressAtPtx711 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register61); // PTX L711
	r_PtxRegister207 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx711 + 262144ull);		 // PTX L712
	r_LaneIndexAtPtx714 = uint32_t((threadIdx.x & 31u));									 // PTX L714
	r_PtxRegister325 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx714), uint32_t(31));		 // PTX L716
	r_PtxRegister326 = ShiftRight(uint32_t(r_PtxRegister325), uint32_t(30));				 // PTX L717
	r_PtxRegister327 = uint32_t(r_LaneIndexAtPtx714) + uint32_t(r_PtxRegister326);			 // PTX L718
	r_PtxRegister328 = r_PtxRegister327 & 2147483644;										 // PTX L719
	r_PtxRegister329 = uint32_t(r_LaneIndexAtPtx714) - uint32_t(r_PtxRegister328);			 // PTX L720
	r_PtxRegister330 = ShiftLeft(uint32_t(r_PtxRegister329), uint32_t(1));					 // PTX L721
	r_PtxRegister331 = uint32_t(r_PtxRegister11) + uint32_t(16);							 // PTX L722
	r_PtxRegister332 = uint32_t(r_PtxRegister331) + uint32_t(r_PtxRegister330);				 // PTX L723
	r_PtxRegister333 = ShiftRightSigned(int32_t(r_PtxRegister332), uint32_t(1));			 // PTX L724
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_PtxRegister333)) * int64_t(int32_t(4))); // PTX L725
	g_RecordByteAddressAtPtx726 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register63); // PTX L726
	r_PtxRegister210 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx726 + 262144ull);		 // PTX L727
	r_LaneIndexAtPtx729 = uint32_t((threadIdx.x & 31u));									 // PTX L729
	r_PtxRegister334 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx729), uint32_t(31));		 // PTX L731
	r_PtxRegister335 = ShiftRight(uint32_t(r_PtxRegister334), uint32_t(30));				 // PTX L732
	r_PtxRegister336 = uint32_t(r_LaneIndexAtPtx729) + uint32_t(r_PtxRegister335);			 // PTX L733
	r_PtxRegister337 = r_PtxRegister336 & 2147483644;										 // PTX L734
	r_PtxRegister338 = uint32_t(r_LaneIndexAtPtx729) - uint32_t(r_PtxRegister337);			 // PTX L735
	r_PtxRegister339 = ShiftLeft(uint32_t(r_PtxRegister338), uint32_t(1));					 // PTX L736
	r_PtxRegister340 = uint32_t(r_PtxRegister331) + uint32_t(r_PtxRegister339);				 // PTX L737
	r_PtxRegister341 = ShiftRightSigned(int32_t(r_PtxRegister340), uint32_t(1));			 // PTX L738
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister341)) * int64_t(int32_t(4))); // PTX L739
	g_RecordByteAddressAtPtx740 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register65); // PTX L740
	r_PtxRegister213 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx740 + 262144ull);		 // PTX L741
	r_LaneIndexAtPtx743 = uint32_t((threadIdx.x & 31u));									 // PTX L743
	r_PtxRegister342 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx743), uint32_t(31));		 // PTX L745
	r_PtxRegister343 = ShiftRight(uint32_t(r_PtxRegister342), uint32_t(30));				 // PTX L746
	r_PtxRegister344 = uint32_t(r_LaneIndexAtPtx743) + uint32_t(r_PtxRegister343);			 // PTX L747
	r_PtxRegister345 = r_PtxRegister344 & 2147483644;										 // PTX L748
	r_PtxRegister346 = uint32_t(r_LaneIndexAtPtx743) - uint32_t(r_PtxRegister345);			 // PTX L749
	r_PtxRegister347 = ShiftLeft(uint32_t(r_PtxRegister346), uint32_t(1));					 // PTX L750
	r_PtxRegister348 = uint32_t(r_PtxRegister11) + uint32_t(24);							 // PTX L751
	r_PtxRegister349 = uint32_t(r_PtxRegister348) + uint32_t(r_PtxRegister347);				 // PTX L752
	r_PtxRegister350 = ShiftRight(uint32_t(r_PtxRegister349), uint32_t(31));				 // PTX L753
	r_PtxRegister351 = uint32_t(r_PtxRegister349) + uint32_t(r_PtxRegister350);				 // PTX L754
	r_PtxRegister352 = ShiftRightSigned(int32_t(r_PtxRegister351), uint32_t(1));			 // PTX L755
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_PtxRegister352)) * int64_t(int32_t(4))); // PTX L756
	g_RecordByteAddressAtPtx757 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register67); // PTX L757
	r_PtxRegister216 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx757 + 262144ull);		 // PTX L758
	r_LaneIndexAtPtx760 = uint32_t((threadIdx.x & 31u));									 // PTX L760
	r_PtxRegister353 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx760), uint32_t(31));		 // PTX L762
	r_PtxRegister354 = ShiftRight(uint32_t(r_PtxRegister353), uint32_t(30));				 // PTX L763
	r_PtxRegister355 = uint32_t(r_LaneIndexAtPtx760) + uint32_t(r_PtxRegister354);			 // PTX L764
	r_PtxRegister356 = r_PtxRegister355 & 2147483644;										 // PTX L765
	r_PtxRegister357 = uint32_t(r_LaneIndexAtPtx760) - uint32_t(r_PtxRegister356);			 // PTX L766
	r_PtxRegister358 = ShiftLeft(uint32_t(r_PtxRegister357), uint32_t(1));					 // PTX L767
	r_PtxRegister359 = uint32_t(r_PtxRegister348) + uint32_t(r_PtxRegister358);				 // PTX L768
	r_PtxRegister360 = ShiftRight(uint32_t(r_PtxRegister359), uint32_t(31));				 // PTX L769
	r_PtxRegister361 = uint32_t(r_PtxRegister359) + uint32_t(r_PtxRegister360);				 // PTX L770
	r_PtxRegister362 = ShiftRightSigned(int32_t(r_PtxRegister361), uint32_t(1));			 // PTX L771
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister362)) * int64_t(int32_t(4))); // PTX L772
	g_RecordByteAddressAtPtx773 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register69); // PTX L773
	r_PtxRegister219 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx773 + 262144ull);		 // PTX L774
	r_LaneIndexAtPtx776 = uint32_t((threadIdx.x & 31u));									 // PTX L776
	r_PtxRegister363 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx776), uint32_t(31));		 // PTX L778
	r_PtxRegister364 = ShiftRight(uint32_t(r_PtxRegister363), uint32_t(30));				 // PTX L779
	r_PtxRegister365 = uint32_t(r_LaneIndexAtPtx776) + uint32_t(r_PtxRegister364);			 // PTX L780
	r_PtxRegister366 = r_PtxRegister365 & 2147483644;										 // PTX L781
	r_PtxRegister367 = uint32_t(r_LaneIndexAtPtx776) - uint32_t(r_PtxRegister366);			 // PTX L782
	r_PtxRegister368 = ShiftLeft(uint32_t(r_PtxRegister367), uint32_t(1));					 // PTX L783
	r_PtxRegister369 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister368);				 // PTX L784
	r_PtxRegister370 = ShiftRightSigned(int32_t(r_PtxRegister369), uint32_t(1));			 // PTX L785
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_PtxRegister370)) * int64_t(int32_t(4))); // PTX L786
	g_RecordByteAddressAtPtx787 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register71); // PTX L787
	r_PtxRegister222 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx787 + 262144ull);		 // PTX L788
	r_LaneIndexAtPtx790 = uint32_t((threadIdx.x & 31u));									 // PTX L790
	r_PtxRegister371 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx790), uint32_t(31));		 // PTX L792
	r_PtxRegister372 = ShiftRight(uint32_t(r_PtxRegister371), uint32_t(30));				 // PTX L793
	r_PtxRegister373 = uint32_t(r_LaneIndexAtPtx790) + uint32_t(r_PtxRegister372);			 // PTX L794
	r_PtxRegister374 = r_PtxRegister373 & 2147483644;										 // PTX L795
	r_PtxRegister375 = uint32_t(r_LaneIndexAtPtx790) - uint32_t(r_PtxRegister374);			 // PTX L796
	r_PtxRegister376 = ShiftLeft(uint32_t(r_PtxRegister375), uint32_t(1));					 // PTX L797
	r_PtxRegister377 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister376);				 // PTX L798
	r_PtxRegister378 = ShiftRightSigned(int32_t(r_PtxRegister377), uint32_t(1));			 // PTX L799
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister378)) * int64_t(int32_t(4))); // PTX L800
	g_RecordByteAddressAtPtx801 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register73); // PTX L801
	r_PtxRegister225 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx801 + 262144ull);		 // PTX L802
	r_LaneIndexAtPtx804 = uint32_t((threadIdx.x & 31u));									 // PTX L804
	r_PtxRegister379 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx804), uint32_t(31));		 // PTX L806
	r_PtxRegister380 = ShiftRight(uint32_t(r_PtxRegister379), uint32_t(30));				 // PTX L807
	r_PtxRegister381 = uint32_t(r_LaneIndexAtPtx804) + uint32_t(r_PtxRegister380);			 // PTX L808
	r_PtxRegister382 = r_PtxRegister381 & 2147483644;										 // PTX L809
	r_PtxRegister383 = uint32_t(r_LaneIndexAtPtx804) - uint32_t(r_PtxRegister382);			 // PTX L810
	r_PtxRegister384 = ShiftLeft(uint32_t(r_PtxRegister383), uint32_t(1));					 // PTX L811
	r_PtxRegister385 = uint32_t(r_PtxRegister11) + uint32_t(40);							 // PTX L812
	r_PtxRegister386 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister384);				 // PTX L813
	r_PtxRegister387 = ShiftRight(uint32_t(r_PtxRegister386), uint32_t(31));				 // PTX L814
	r_PtxRegister388 = uint32_t(r_PtxRegister386) + uint32_t(r_PtxRegister387);				 // PTX L815
	r_PtxRegister389 = ShiftRightSigned(int32_t(r_PtxRegister388), uint32_t(1));			 // PTX L816
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_PtxRegister389)) * int64_t(int32_t(4))); // PTX L817
	g_RecordByteAddressAtPtx818 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register75); // PTX L818
	r_PtxRegister228 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx818 + 262144ull);		 // PTX L819
	r_LaneIndexAtPtx821 = uint32_t((threadIdx.x & 31u));									 // PTX L821
	r_PtxRegister390 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx821), uint32_t(31));		 // PTX L823
	r_PtxRegister391 = ShiftRight(uint32_t(r_PtxRegister390), uint32_t(30));				 // PTX L824
	r_PtxRegister392 = uint32_t(r_LaneIndexAtPtx821) + uint32_t(r_PtxRegister391);			 // PTX L825
	r_PtxRegister393 = r_PtxRegister392 & 2147483644;										 // PTX L826
	r_PtxRegister394 = uint32_t(r_LaneIndexAtPtx821) - uint32_t(r_PtxRegister393);			 // PTX L827
	r_PtxRegister395 = ShiftLeft(uint32_t(r_PtxRegister394), uint32_t(1));					 // PTX L828
	r_PtxRegister396 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister395);				 // PTX L829
	r_PtxRegister397 = ShiftRight(uint32_t(r_PtxRegister396), uint32_t(31));				 // PTX L830
	r_PtxRegister398 = uint32_t(r_PtxRegister396) + uint32_t(r_PtxRegister397);				 // PTX L831
	r_PtxRegister399 = ShiftRightSigned(int32_t(r_PtxRegister398), uint32_t(1));			 // PTX L832
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_PtxRegister399)) * int64_t(int32_t(4))); // PTX L833
	g_RecordByteAddressAtPtx834 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register77); // PTX L834
	r_PtxRegister231 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx834 + 262144ull);		 // PTX L835
	r_LaneIndexAtPtx837 = uint32_t((threadIdx.x & 31u));									 // PTX L837
	r_PtxRegister400 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx837), uint32_t(31));		 // PTX L839
	r_PtxRegister401 = ShiftRight(uint32_t(r_PtxRegister400), uint32_t(30));				 // PTX L840
	r_PtxRegister402 = uint32_t(r_LaneIndexAtPtx837) + uint32_t(r_PtxRegister401);			 // PTX L841
	r_PtxRegister403 = r_PtxRegister402 & 2147483644;										 // PTX L842
	r_PtxRegister404 = uint32_t(r_LaneIndexAtPtx837) - uint32_t(r_PtxRegister403);			 // PTX L843
	r_PtxRegister405 = ShiftLeft(uint32_t(r_PtxRegister404), uint32_t(1));					 // PTX L844
	r_PtxRegister406 = uint32_t(r_PtxRegister11) + uint32_t(48);							 // PTX L845
	r_PtxRegister407 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister405);				 // PTX L846
	r_PtxRegister408 = ShiftRightSigned(int32_t(r_PtxRegister407), uint32_t(1));			 // PTX L847
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister408)) * int64_t(int32_t(4))); // PTX L848
	g_RecordByteAddressAtPtx849 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register79); // PTX L849
	r_PtxRegister234 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx849 + 262144ull);		 // PTX L850
	r_LaneIndexAtPtx852 = uint32_t((threadIdx.x & 31u));									 // PTX L852
	r_PtxRegister409 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx852), uint32_t(31));		 // PTX L854
	r_PtxRegister410 = ShiftRight(uint32_t(r_PtxRegister409), uint32_t(30));				 // PTX L855
	r_PtxRegister411 = uint32_t(r_LaneIndexAtPtx852) + uint32_t(r_PtxRegister410);			 // PTX L856
	r_PtxRegister412 = r_PtxRegister411 & 2147483644;										 // PTX L857
	r_PtxRegister413 = uint32_t(r_LaneIndexAtPtx852) - uint32_t(r_PtxRegister412);			 // PTX L858
	r_PtxRegister414 = ShiftLeft(uint32_t(r_PtxRegister413), uint32_t(1));					 // PTX L859
	r_PtxRegister415 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister414);				 // PTX L860
	r_PtxRegister416 = ShiftRightSigned(int32_t(r_PtxRegister415), uint32_t(1));			 // PTX L861
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister416)) * int64_t(int32_t(4))); // PTX L862
	g_RecordByteAddressAtPtx863 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register81); // PTX L863
	r_PtxRegister237 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx863 + 262144ull);		 // PTX L864
	r_LaneIndexAtPtx866 = uint32_t((threadIdx.x & 31u));									 // PTX L866
	r_PtxRegister417 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx866), uint32_t(31));		 // PTX L868
	r_PtxRegister418 = ShiftRight(uint32_t(r_PtxRegister417), uint32_t(30));				 // PTX L869
	r_PtxRegister419 = uint32_t(r_LaneIndexAtPtx866) + uint32_t(r_PtxRegister418);			 // PTX L870
	r_PtxRegister420 = r_PtxRegister419 & 2147483644;										 // PTX L871
	r_PtxRegister421 = uint32_t(r_LaneIndexAtPtx866) - uint32_t(r_PtxRegister420);			 // PTX L872
	r_PtxRegister422 = ShiftLeft(uint32_t(r_PtxRegister421), uint32_t(1));					 // PTX L873
	r_PtxRegister423 = uint32_t(r_PtxRegister11) + uint32_t(56);							 // PTX L874
	r_PtxRegister424 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister422);				 // PTX L875
	r_PtxRegister425 = ShiftRight(uint32_t(r_PtxRegister424), uint32_t(31));				 // PTX L876
	r_PtxRegister426 = uint32_t(r_PtxRegister424) + uint32_t(r_PtxRegister425);				 // PTX L877
	r_PtxRegister427 = ShiftRightSigned(int32_t(r_PtxRegister426), uint32_t(1));			 // PTX L878
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_PtxRegister427)) * int64_t(int32_t(4))); // PTX L879
	g_RecordByteAddressAtPtx880 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register83); // PTX L880
	r_PtxRegister240 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx880 + 262144ull);		 // PTX L881
	r_LaneIndexAtPtx883 = uint32_t((threadIdx.x & 31u));									 // PTX L883
	r_PtxRegister428 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx883), uint32_t(31));		 // PTX L885
	r_PtxRegister429 = ShiftRight(uint32_t(r_PtxRegister428), uint32_t(30));				 // PTX L886
	r_PtxRegister430 = uint32_t(r_LaneIndexAtPtx883) + uint32_t(r_PtxRegister429);			 // PTX L887
	r_PtxRegister431 = r_PtxRegister430 & 2147483644;										 // PTX L888
	r_PtxRegister432 = uint32_t(r_LaneIndexAtPtx883) - uint32_t(r_PtxRegister431);			 // PTX L889
	r_PtxRegister433 = ShiftLeft(uint32_t(r_PtxRegister432), uint32_t(1));					 // PTX L890
	r_PtxRegister434 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister433);				 // PTX L891
	r_PtxRegister435 = ShiftRight(uint32_t(r_PtxRegister434), uint32_t(31));				 // PTX L892
	r_PtxRegister436 = uint32_t(r_PtxRegister434) + uint32_t(r_PtxRegister435);				 // PTX L893
	r_PtxRegister437 = ShiftRightSigned(int32_t(r_PtxRegister436), uint32_t(1));			 // PTX L894
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_PtxRegister437)) * int64_t(int32_t(4))); // PTX L895
	g_RecordByteAddressAtPtx896 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register85); // PTX L896
	r_PtxRegister243 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx896 + 262144ull);		 // PTX L897
	r_LaneIndexAtPtx899 = uint32_t((threadIdx.x & 31u));									 // PTX L899
	r_PtxRegister438 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx899), uint32_t(31));		 // PTX L901
	r_PtxRegister439 = ShiftRight(uint32_t(r_PtxRegister438), uint32_t(30));				 // PTX L902
	r_PtxRegister440 = uint32_t(r_LaneIndexAtPtx899) + uint32_t(r_PtxRegister439);			 // PTX L903
	r_PtxRegister441 = r_PtxRegister440 & 2147483644;										 // PTX L904
	r_PtxRegister442 = uint32_t(r_LaneIndexAtPtx899) - uint32_t(r_PtxRegister441);			 // PTX L905
	r_PtxRegister443 = ShiftLeft(uint32_t(r_PtxRegister442), uint32_t(1));					 // PTX L906
	r_PtxRegister444 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister443);				 // PTX L907
	r_PtxRegister445 = ShiftRightSigned(int32_t(r_PtxRegister444), uint32_t(1));			 // PTX L908
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_PtxRegister445)) * int64_t(int32_t(4))); // PTX L909
	g_RecordByteAddressAtPtx910 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register87); // PTX L910
	r_PtxRegister246 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx910 + 262144ull);		 // PTX L911
	r_LaneIndexAtPtx913 = uint32_t((threadIdx.x & 31u));									 // PTX L913
	r_PtxRegister446 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx913), uint32_t(31));		 // PTX L915
	r_PtxRegister447 = ShiftRight(uint32_t(r_PtxRegister446), uint32_t(30));				 // PTX L916
	r_PtxRegister448 = uint32_t(r_LaneIndexAtPtx913) + uint32_t(r_PtxRegister447);			 // PTX L917
	r_PtxRegister449 = r_PtxRegister448 & 2147483644;										 // PTX L918
	r_PtxRegister450 = uint32_t(r_LaneIndexAtPtx913) - uint32_t(r_PtxRegister449);			 // PTX L919
	r_PtxRegister451 = ShiftLeft(uint32_t(r_PtxRegister450), uint32_t(1));					 // PTX L920
	r_PtxRegister452 = uint32_t(r_PtxRegister11) + uint32_t(r_PtxRegister451);				 // PTX L921
	r_PtxRegister453 = ShiftRightSigned(int32_t(r_PtxRegister452), uint32_t(1));			 // PTX L922
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister453)) * int64_t(int32_t(4))); // PTX L923
	g_RecordByteAddressAtPtx924 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register89); // PTX L924
	r_PtxRegister249 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx924 + 262144ull);		 // PTX L925
	r_LaneIndexAtPtx927 = uint32_t((threadIdx.x & 31u));									 // PTX L927
	r_PtxRegister454 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx927), uint32_t(31));		 // PTX L929
	r_PtxRegister455 = ShiftRight(uint32_t(r_PtxRegister454), uint32_t(30));				 // PTX L930
	r_PtxRegister456 = uint32_t(r_LaneIndexAtPtx927) + uint32_t(r_PtxRegister455);			 // PTX L931
	r_PtxRegister457 = r_PtxRegister456 & 2147483644;										 // PTX L932
	r_PtxRegister458 = uint32_t(r_LaneIndexAtPtx927) - uint32_t(r_PtxRegister457);			 // PTX L933
	r_PtxRegister459 = ShiftLeft(uint32_t(r_PtxRegister458), uint32_t(1));					 // PTX L934
	r_PtxRegister460 = uint32_t(r_PtxRegister292) + uint32_t(r_PtxRegister459);				 // PTX L935
	r_PtxRegister461 = ShiftRightSigned(int32_t(r_PtxRegister460), uint32_t(1));			 // PTX L936
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister461)) * int64_t(int32_t(4))); // PTX L937
	g_RecordByteAddressAtPtx938 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register91); // PTX L938
	r_PtxRegister252 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx938 + 262144ull);		 // PTX L939
	r_LaneIndexAtPtx941 = uint32_t((threadIdx.x & 31u));									 // PTX L941
	r_PtxRegister462 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx941), uint32_t(31));		 // PTX L943
	r_PtxRegister463 = ShiftRight(uint32_t(r_PtxRegister462), uint32_t(30));				 // PTX L944
	r_PtxRegister464 = uint32_t(r_LaneIndexAtPtx941) + uint32_t(r_PtxRegister463);			 // PTX L945
	r_PtxRegister465 = r_PtxRegister464 & 2147483644;										 // PTX L946
	r_PtxRegister466 = uint32_t(r_LaneIndexAtPtx941) - uint32_t(r_PtxRegister465);			 // PTX L947
	r_PtxRegister467 = ShiftLeft(uint32_t(r_PtxRegister466), uint32_t(1));					 // PTX L948
	r_PtxRegister468 = uint32_t(r_PtxRegister292) + uint32_t(r_PtxRegister467);				 // PTX L949
	r_PtxRegister469 = ShiftRightSigned(int32_t(r_PtxRegister468), uint32_t(1));			 // PTX L950
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_PtxRegister469)) * int64_t(int32_t(4))); // PTX L951
	g_RecordByteAddressAtPtx952 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register93); // PTX L952
	r_PtxRegister255 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx952 + 262144ull);		 // PTX L953
	r_LaneIndexAtPtx955 = uint32_t((threadIdx.x & 31u));									 // PTX L955
	r_PtxRegister470 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx955), uint32_t(31));		 // PTX L957
	r_PtxRegister471 = ShiftRight(uint32_t(r_PtxRegister470), uint32_t(30));				 // PTX L958
	r_PtxRegister472 = uint32_t(r_LaneIndexAtPtx955) + uint32_t(r_PtxRegister471);			 // PTX L959
	r_PtxRegister473 = r_PtxRegister472 & 2147483644;										 // PTX L960
	r_PtxRegister474 = uint32_t(r_LaneIndexAtPtx955) - uint32_t(r_PtxRegister473);			 // PTX L961
	r_PtxRegister475 = ShiftLeft(uint32_t(r_PtxRegister474), uint32_t(1));					 // PTX L962
	r_PtxRegister476 = uint32_t(r_PtxRegister331) + uint32_t(r_PtxRegister475);				 // PTX L963
	r_PtxRegister477 = ShiftRightSigned(int32_t(r_PtxRegister476), uint32_t(1));			 // PTX L964
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister477)) * int64_t(int32_t(4))); // PTX L965
	g_RecordByteAddressAtPtx966 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register95); // PTX L966
	r_PtxRegister258 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx966 + 262144ull);		 // PTX L967
	r_LaneIndexAtPtx969 = uint32_t((threadIdx.x & 31u));									 // PTX L969
	r_PtxRegister478 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx969), uint32_t(31));		 // PTX L971
	r_PtxRegister479 = ShiftRight(uint32_t(r_PtxRegister478), uint32_t(30));				 // PTX L972
	r_PtxRegister480 = uint32_t(r_LaneIndexAtPtx969) + uint32_t(r_PtxRegister479);			 // PTX L973
	r_PtxRegister481 = r_PtxRegister480 & 2147483644;										 // PTX L974
	r_PtxRegister482 = uint32_t(r_LaneIndexAtPtx969) - uint32_t(r_PtxRegister481);			 // PTX L975
	r_PtxRegister483 = ShiftLeft(uint32_t(r_PtxRegister482), uint32_t(1));					 // PTX L976
	r_PtxRegister484 = uint32_t(r_PtxRegister331) + uint32_t(r_PtxRegister483);				 // PTX L977
	r_PtxRegister485 = ShiftRightSigned(int32_t(r_PtxRegister484), uint32_t(1));			 // PTX L978
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_PtxRegister485)) * int64_t(int32_t(4))); // PTX L979
	g_RecordByteAddressAtPtx980 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register97); // PTX L980
	r_PtxRegister261 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx980 + 262144ull);		 // PTX L981
	r_LaneIndexAtPtx983 = uint32_t((threadIdx.x & 31u));									 // PTX L983
	r_PtxRegister486 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx983), uint32_t(31));		 // PTX L985
	r_PtxRegister487 = ShiftRight(uint32_t(r_PtxRegister486), uint32_t(30));				 // PTX L986
	r_PtxRegister488 = uint32_t(r_LaneIndexAtPtx983) + uint32_t(r_PtxRegister487);			 // PTX L987
	r_PtxRegister489 = r_PtxRegister488 & 2147483644;										 // PTX L988
	r_PtxRegister490 = uint32_t(r_LaneIndexAtPtx983) - uint32_t(r_PtxRegister489);			 // PTX L989
	r_PtxRegister491 = ShiftLeft(uint32_t(r_PtxRegister490), uint32_t(1));					 // PTX L990
	r_PtxRegister492 = uint32_t(r_PtxRegister348) + uint32_t(r_PtxRegister491);				 // PTX L991
	r_PtxRegister493 = ShiftRight(uint32_t(r_PtxRegister492), uint32_t(31));				 // PTX L992
	r_PtxRegister494 = uint32_t(r_PtxRegister492) + uint32_t(r_PtxRegister493);				 // PTX L993
	r_PtxRegister495 = ShiftRightSigned(int32_t(r_PtxRegister494), uint32_t(1));			 // PTX L994
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister495)) * int64_t(int32_t(4))); // PTX L995
	g_RecordByteAddressAtPtx996 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register99); // PTX L996
	r_PtxRegister264 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx996 + 262144ull);		  // PTX L997
	r_LaneIndexAtPtx999 = uint32_t((threadIdx.x & 31u));									  // PTX L999
	r_PtxRegister496 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx999), uint32_t(31));		  // PTX L1001
	r_PtxRegister497 = ShiftRight(uint32_t(r_PtxRegister496), uint32_t(30));				  // PTX L1002
	r_PtxRegister498 = uint32_t(r_LaneIndexAtPtx999) + uint32_t(r_PtxRegister497);			  // PTX L1003
	r_PtxRegister499 = r_PtxRegister498 & 2147483644;										  // PTX L1004
	r_PtxRegister500 = uint32_t(r_LaneIndexAtPtx999) - uint32_t(r_PtxRegister499);			  // PTX L1005
	r_PtxRegister501 = ShiftLeft(uint32_t(r_PtxRegister500), uint32_t(1));					  // PTX L1006
	r_PtxRegister502 = uint32_t(r_PtxRegister348) + uint32_t(r_PtxRegister501);				  // PTX L1007
	r_PtxRegister503 = ShiftRight(uint32_t(r_PtxRegister502), uint32_t(31));				  // PTX L1008
	r_PtxRegister504 = uint32_t(r_PtxRegister502) + uint32_t(r_PtxRegister503);				  // PTX L1009
	r_PtxRegister505 = ShiftRightSigned(int32_t(r_PtxRegister504), uint32_t(1));			  // PTX L1010
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister505)) * int64_t(int32_t(4))); // PTX L1011
	g_RecordByteAddressAtPtx1012 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register101); // PTX L1012
	r_PtxRegister267 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1012 + 262144ull);		  // PTX L1013
	r_LaneIndexAtPtx1015 = uint32_t((threadIdx.x & 31u));									  // PTX L1015
	r_PtxRegister506 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1015), uint32_t(31));		  // PTX L1017
	r_PtxRegister507 = ShiftRight(uint32_t(r_PtxRegister506), uint32_t(30));				  // PTX L1018
	r_PtxRegister508 = uint32_t(r_LaneIndexAtPtx1015) + uint32_t(r_PtxRegister507);			  // PTX L1019
	r_PtxRegister509 = r_PtxRegister508 & 2147483644;										  // PTX L1020
	r_PtxRegister510 = uint32_t(r_LaneIndexAtPtx1015) - uint32_t(r_PtxRegister509);			  // PTX L1021
	r_PtxRegister511 = ShiftLeft(uint32_t(r_PtxRegister510), uint32_t(1));					  // PTX L1022
	r_PtxRegister512 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister511);				  // PTX L1023
	r_PtxRegister513 = ShiftRightSigned(int32_t(r_PtxRegister512), uint32_t(1));			  // PTX L1024
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister513)) * int64_t(int32_t(4))); // PTX L1025
	g_RecordByteAddressAtPtx1026 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register103); // PTX L1026
	r_PtxRegister270 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1026 + 262144ull);		  // PTX L1027
	r_LaneIndexAtPtx1029 = uint32_t((threadIdx.x & 31u));									  // PTX L1029
	r_PtxRegister514 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1029), uint32_t(31));		  // PTX L1031
	r_PtxRegister515 = ShiftRight(uint32_t(r_PtxRegister514), uint32_t(30));				  // PTX L1032
	r_PtxRegister516 = uint32_t(r_LaneIndexAtPtx1029) + uint32_t(r_PtxRegister515);			  // PTX L1033
	r_PtxRegister517 = r_PtxRegister516 & 2147483644;										  // PTX L1034
	r_PtxRegister518 = uint32_t(r_LaneIndexAtPtx1029) - uint32_t(r_PtxRegister517);			  // PTX L1035
	r_PtxRegister519 = ShiftLeft(uint32_t(r_PtxRegister518), uint32_t(1));					  // PTX L1036
	r_PtxRegister520 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister519);				  // PTX L1037
	r_PtxRegister521 = ShiftRightSigned(int32_t(r_PtxRegister520), uint32_t(1));			  // PTX L1038
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister521)) * int64_t(int32_t(4))); // PTX L1039
	g_RecordByteAddressAtPtx1040 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register105); // PTX L1040
	r_PtxRegister273 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1040 + 262144ull);		  // PTX L1041
	r_LaneIndexAtPtx1043 = uint32_t((threadIdx.x & 31u));									  // PTX L1043
	r_PtxRegister522 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1043), uint32_t(31));		  // PTX L1045
	r_PtxRegister523 = ShiftRight(uint32_t(r_PtxRegister522), uint32_t(30));				  // PTX L1046
	r_PtxRegister524 = uint32_t(r_LaneIndexAtPtx1043) + uint32_t(r_PtxRegister523);			  // PTX L1047
	r_PtxRegister525 = r_PtxRegister524 & 2147483644;										  // PTX L1048
	r_PtxRegister526 = uint32_t(r_LaneIndexAtPtx1043) - uint32_t(r_PtxRegister525);			  // PTX L1049
	r_PtxRegister527 = ShiftLeft(uint32_t(r_PtxRegister526), uint32_t(1));					  // PTX L1050
	r_PtxRegister528 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister527);				  // PTX L1051
	r_PtxRegister529 = ShiftRight(uint32_t(r_PtxRegister528), uint32_t(31));				  // PTX L1052
	r_PtxRegister530 = uint32_t(r_PtxRegister528) + uint32_t(r_PtxRegister529);				  // PTX L1053
	r_PtxRegister531 = ShiftRightSigned(int32_t(r_PtxRegister530), uint32_t(1));			  // PTX L1054
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister531)) * int64_t(int32_t(4))); // PTX L1055
	g_RecordByteAddressAtPtx1056 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register107); // PTX L1056
	r_PtxRegister276 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1056 + 262144ull);		  // PTX L1057
	r_LaneIndexAtPtx1059 = uint32_t((threadIdx.x & 31u));									  // PTX L1059
	r_PtxRegister532 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1059), uint32_t(31));		  // PTX L1061
	r_PtxRegister533 = ShiftRight(uint32_t(r_PtxRegister532), uint32_t(30));				  // PTX L1062
	r_PtxRegister534 = uint32_t(r_LaneIndexAtPtx1059) + uint32_t(r_PtxRegister533);			  // PTX L1063
	r_PtxRegister535 = r_PtxRegister534 & 2147483644;										  // PTX L1064
	r_PtxRegister536 = uint32_t(r_LaneIndexAtPtx1059) - uint32_t(r_PtxRegister535);			  // PTX L1065
	r_PtxRegister537 = ShiftLeft(uint32_t(r_PtxRegister536), uint32_t(1));					  // PTX L1066
	r_PtxRegister538 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister537);				  // PTX L1067
	r_PtxRegister539 = ShiftRight(uint32_t(r_PtxRegister538), uint32_t(31));				  // PTX L1068
	r_PtxRegister540 = uint32_t(r_PtxRegister538) + uint32_t(r_PtxRegister539);				  // PTX L1069
	r_PtxRegister541 = ShiftRightSigned(int32_t(r_PtxRegister540), uint32_t(1));			  // PTX L1070
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister541)) * int64_t(int32_t(4))); // PTX L1071
	g_RecordByteAddressAtPtx1072 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register109); // PTX L1072
	r_PtxRegister279 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1072 + 262144ull);		  // PTX L1073
	r_LaneIndexAtPtx1075 = uint32_t((threadIdx.x & 31u));									  // PTX L1075
	r_PtxRegister542 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1075), uint32_t(31));		  // PTX L1077
	r_PtxRegister543 = ShiftRight(uint32_t(r_PtxRegister542), uint32_t(30));				  // PTX L1078
	r_PtxRegister544 = uint32_t(r_LaneIndexAtPtx1075) + uint32_t(r_PtxRegister543);			  // PTX L1079
	r_PtxRegister545 = r_PtxRegister544 & 2147483644;										  // PTX L1080
	r_PtxRegister546 = uint32_t(r_LaneIndexAtPtx1075) - uint32_t(r_PtxRegister545);			  // PTX L1081
	r_PtxRegister547 = ShiftLeft(uint32_t(r_PtxRegister546), uint32_t(1));					  // PTX L1082
	r_PtxRegister548 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister547);				  // PTX L1083
	r_PtxRegister549 = ShiftRightSigned(int32_t(r_PtxRegister548), uint32_t(1));			  // PTX L1084
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister549)) * int64_t(int32_t(4))); // PTX L1085
	g_RecordByteAddressAtPtx1086 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register111); // PTX L1086
	r_PtxRegister282 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1086 + 262144ull);		  // PTX L1087
	r_LaneIndexAtPtx1089 = uint32_t((threadIdx.x & 31u));									  // PTX L1089
	r_PtxRegister550 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1089), uint32_t(31));		  // PTX L1091
	r_PtxRegister551 = ShiftRight(uint32_t(r_PtxRegister550), uint32_t(30));				  // PTX L1092
	r_PtxRegister552 = uint32_t(r_LaneIndexAtPtx1089) + uint32_t(r_PtxRegister551);			  // PTX L1093
	r_PtxRegister553 = r_PtxRegister552 & 2147483644;										  // PTX L1094
	r_PtxRegister554 = uint32_t(r_LaneIndexAtPtx1089) - uint32_t(r_PtxRegister553);			  // PTX L1095
	r_PtxRegister555 = ShiftLeft(uint32_t(r_PtxRegister554), uint32_t(1));					  // PTX L1096
	r_PtxRegister556 = uint32_t(r_PtxRegister406) + uint32_t(r_PtxRegister555);				  // PTX L1097
	r_PtxRegister557 = ShiftRightSigned(int32_t(r_PtxRegister556), uint32_t(1));			  // PTX L1098
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister557)) * int64_t(int32_t(4))); // PTX L1099
	g_RecordByteAddressAtPtx1100 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register113); // PTX L1100
	r_PtxRegister285 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1100 + 262144ull);		  // PTX L1101
	r_LaneIndexAtPtx1103 = uint32_t((threadIdx.x & 31u));									  // PTX L1103
	r_PtxRegister558 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1103), uint32_t(31));		  // PTX L1105
	r_PtxRegister559 = ShiftRight(uint32_t(r_PtxRegister558), uint32_t(30));				  // PTX L1106
	r_PtxRegister560 = uint32_t(r_LaneIndexAtPtx1103) + uint32_t(r_PtxRegister559);			  // PTX L1107
	r_PtxRegister561 = r_PtxRegister560 & 2147483644;										  // PTX L1108
	r_PtxRegister562 = uint32_t(r_LaneIndexAtPtx1103) - uint32_t(r_PtxRegister561);			  // PTX L1109
	r_PtxRegister563 = ShiftLeft(uint32_t(r_PtxRegister562), uint32_t(1));					  // PTX L1110
	r_PtxRegister564 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister563);				  // PTX L1111
	r_PtxRegister565 = ShiftRight(uint32_t(r_PtxRegister564), uint32_t(31));				  // PTX L1112
	r_PtxRegister566 = uint32_t(r_PtxRegister564) + uint32_t(r_PtxRegister565);				  // PTX L1113
	r_PtxRegister567 = ShiftRightSigned(int32_t(r_PtxRegister566), uint32_t(1));			  // PTX L1114
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister567)) * int64_t(int32_t(4))); // PTX L1115
	g_RecordByteAddressAtPtx1116 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register115); // PTX L1116
	r_PtxRegister288 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1116 + 262144ull);		  // PTX L1117
	r_LaneIndexAtPtx1119 = uint32_t((threadIdx.x & 31u));									  // PTX L1119
	r_PtxRegister568 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1119), uint32_t(31));		  // PTX L1121
	r_PtxRegister569 = ShiftRight(uint32_t(r_PtxRegister568), uint32_t(30));				  // PTX L1122
	r_PtxRegister570 = uint32_t(r_LaneIndexAtPtx1119) + uint32_t(r_PtxRegister569);			  // PTX L1123
	r_PtxRegister571 = r_PtxRegister570 & 2147483644;										  // PTX L1124
	r_PtxRegister572 = uint32_t(r_LaneIndexAtPtx1119) - uint32_t(r_PtxRegister571);			  // PTX L1125
	r_PtxRegister573 = ShiftLeft(uint32_t(r_PtxRegister572), uint32_t(1));					  // PTX L1126
	r_PtxRegister574 = uint32_t(r_PtxRegister423) + uint32_t(r_PtxRegister573);				  // PTX L1127
	r_PtxRegister575 = ShiftRight(uint32_t(r_PtxRegister574), uint32_t(31));				  // PTX L1128
	r_PtxRegister576 = uint32_t(r_PtxRegister574) + uint32_t(r_PtxRegister575);				  // PTX L1129
	r_PtxRegister577 = ShiftRightSigned(int32_t(r_PtxRegister576), uint32_t(1));			  // PTX L1130
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister577)) * int64_t(int32_t(4))); // PTX L1131
	g_RecordByteAddressAtPtx1132 =
		uint64_t(g_RecordByteAddressAtPtx656) + uint64_t(r_PtxU64Register117); // PTX L1132
	r_PtxRegister291 =
		*reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx1132 + 262144ull);  // PTX L1133
	r_LaneIndexAtPtx1135 = uint32_t((threadIdx.x & 31u));							   // PTX L1135
	r_PackedHalf2AtPtx1138R756 = HalfMul(r_PackedHalf2AtPtx556R197, r_PtxRegister198); // PTX L1138
	r_LaneIndexAtPtx1142 = uint32_t((threadIdx.x & 31u));							   // PTX L1142
	r_PackedHalf2AtPtx1145R755 = HalfMul(r_PackedHalf2AtPtx562R200, r_PtxRegister201); // PTX L1145
	r_LaneIndexAtPtx1149 = uint32_t((threadIdx.x & 31u));							   // PTX L1149
	r_PackedHalf2AtPtx1152R754 = HalfMul(r_PackedHalf2AtPtx559R203, r_PtxRegister204); // PTX L1152
	r_LaneIndexAtPtx1156 = uint32_t((threadIdx.x & 31u));							   // PTX L1156
	r_PackedHalf2AtPtx1159R753 = HalfMul(r_PackedHalf2AtPtx565R206, r_PtxRegister207); // PTX L1159
	r_LaneIndexAtPtx1163 = uint32_t((threadIdx.x & 31u));							   // PTX L1163
	r_PackedHalf2AtPtx1166R752 = HalfMul(r_PackedHalf2AtPtx568R209, r_PtxRegister210); // PTX L1166
	r_LaneIndexAtPtx1170 = uint32_t((threadIdx.x & 31u));							   // PTX L1170
	r_PackedHalf2AtPtx1173R751 = HalfMul(r_PackedHalf2AtPtx574R212, r_PtxRegister213); // PTX L1173
	r_LaneIndexAtPtx1177 = uint32_t((threadIdx.x & 31u));							   // PTX L1177
	r_PackedHalf2AtPtx1180R750 = HalfMul(r_PackedHalf2AtPtx571R215, r_PtxRegister216); // PTX L1180
	r_LaneIndexAtPtx1184 = uint32_t((threadIdx.x & 31u));							   // PTX L1184
	r_PackedHalf2AtPtx1187R749 = HalfMul(r_PackedHalf2AtPtx577R218, r_PtxRegister219); // PTX L1187
	r_LaneIndexAtPtx1191 = uint32_t((threadIdx.x & 31u));							   // PTX L1191
	r_PackedHalf2AtPtx1194R748 = HalfMul(r_PackedHalf2AtPtx580R221, r_PtxRegister222); // PTX L1194
	r_LaneIndexAtPtx1198 = uint32_t((threadIdx.x & 31u));							   // PTX L1198
	r_PackedHalf2AtPtx1201R747 = HalfMul(r_PackedHalf2AtPtx586R224, r_PtxRegister225); // PTX L1201
	r_LaneIndexAtPtx1205 = uint32_t((threadIdx.x & 31u));							   // PTX L1205
	r_PackedHalf2AtPtx1208R746 = HalfMul(r_PackedHalf2AtPtx583R227, r_PtxRegister228); // PTX L1208
	r_LaneIndexAtPtx1212 = uint32_t((threadIdx.x & 31u));							   // PTX L1212
	r_PackedHalf2AtPtx1215R745 = HalfMul(r_PackedHalf2AtPtx589R230, r_PtxRegister231); // PTX L1215
	r_LaneIndexAtPtx1219 = uint32_t((threadIdx.x & 31u));							   // PTX L1219
	r_PackedHalf2AtPtx1222R744 = HalfMul(r_PackedHalf2AtPtx592R233, r_PtxRegister234); // PTX L1222
	r_LaneIndexAtPtx1226 = uint32_t((threadIdx.x & 31u));							   // PTX L1226
	r_PackedHalf2AtPtx1229R743 = HalfMul(r_PackedHalf2AtPtx598R236, r_PtxRegister237); // PTX L1229
	r_LaneIndexAtPtx1233 = uint32_t((threadIdx.x & 31u));							   // PTX L1233
	r_PackedHalf2AtPtx1236R742 = HalfMul(r_PackedHalf2AtPtx595R239, r_PtxRegister240); // PTX L1236
	r_LaneIndexAtPtx1240 = uint32_t((threadIdx.x & 31u));							   // PTX L1240
	r_PackedHalf2AtPtx1243R741 = HalfMul(r_PackedHalf2AtPtx601R242, r_PtxRegister243); // PTX L1243
	r_LaneIndexAtPtx1247 = uint32_t((threadIdx.x & 31u));							   // PTX L1247
	r_PackedHalf2AtPtx1250R740 = HalfMul(r_PackedHalf2AtPtx604R245, r_PtxRegister246); // PTX L1250
	r_LaneIndexAtPtx1254 = uint32_t((threadIdx.x & 31u));							   // PTX L1254
	r_PackedHalf2AtPtx1257R739 = HalfMul(r_PackedHalf2AtPtx610R248, r_PtxRegister249); // PTX L1257
	r_LaneIndexAtPtx1261 = uint32_t((threadIdx.x & 31u));							   // PTX L1261
	r_PackedHalf2AtPtx1264R738 = HalfMul(r_PackedHalf2AtPtx607R251, r_PtxRegister252); // PTX L1264
	r_LaneIndexAtPtx1268 = uint32_t((threadIdx.x & 31u));							   // PTX L1268
	r_PackedHalf2AtPtx1271R737 = HalfMul(r_PackedHalf2AtPtx613R254, r_PtxRegister255); // PTX L1271
	r_LaneIndexAtPtx1275 = uint32_t((threadIdx.x & 31u));							   // PTX L1275
	r_PackedHalf2AtPtx1278R736 = HalfMul(r_PackedHalf2AtPtx616R257, r_PtxRegister258); // PTX L1278
	r_LaneIndexAtPtx1282 = uint32_t((threadIdx.x & 31u));							   // PTX L1282
	r_PackedHalf2AtPtx1285R735 = HalfMul(r_PackedHalf2AtPtx622R260, r_PtxRegister261); // PTX L1285
	r_LaneIndexAtPtx1289 = uint32_t((threadIdx.x & 31u));							   // PTX L1289
	r_PackedHalf2AtPtx1292R734 = HalfMul(r_PackedHalf2AtPtx619R263, r_PtxRegister264); // PTX L1292
	r_LaneIndexAtPtx1296 = uint32_t((threadIdx.x & 31u));							   // PTX L1296
	r_PackedHalf2AtPtx1299R733 = HalfMul(r_PackedHalf2AtPtx625R266, r_PtxRegister267); // PTX L1299
	r_LaneIndexAtPtx1303 = uint32_t((threadIdx.x & 31u));							   // PTX L1303
	r_PackedHalf2AtPtx1306R732 = HalfMul(r_PackedHalf2AtPtx629R269, r_PtxRegister270); // PTX L1306
	r_LaneIndexAtPtx1310 = uint32_t((threadIdx.x & 31u));							   // PTX L1310
	r_PackedHalf2AtPtx1313R731 = HalfMul(r_PackedHalf2AtPtx636R272, r_PtxRegister273); // PTX L1313
	r_LaneIndexAtPtx1317 = uint32_t((threadIdx.x & 31u));							   // PTX L1317
	r_PackedHalf2AtPtx1320R730 = HalfMul(r_PackedHalf2AtPtx632R275, r_PtxRegister276); // PTX L1320
	r_LaneIndexAtPtx1324 = uint32_t((threadIdx.x & 31u));							   // PTX L1324
	r_PackedHalf2AtPtx1327R729 = HalfMul(r_PackedHalf2AtPtx639R278, r_PtxRegister279); // PTX L1327
	r_LaneIndexAtPtx1331 = uint32_t((threadIdx.x & 31u));							   // PTX L1331
	r_PackedHalf2AtPtx1334R728 = HalfMul(r_PackedHalf2AtPtx643R281, r_PtxRegister282); // PTX L1334
	r_LaneIndexAtPtx1338 = uint32_t((threadIdx.x & 31u));							   // PTX L1338
	r_PackedHalf2AtPtx1341R727 = HalfMul(r_PackedHalf2AtPtx650R284, r_PtxRegister285); // PTX L1341
	r_LaneIndexAtPtx1345 = uint32_t((threadIdx.x & 31u));							   // PTX L1345
	r_PackedHalf2AtPtx1348R757 = HalfMul(r_PackedHalf2AtPtx646R287, r_PtxRegister288); // PTX L1348
	r_LaneIndexAtPtx1352 = uint32_t((threadIdx.x & 31u));							   // PTX L1352
	r_PackedHalf2AtPtx1355R758 = HalfMul(r_PackedHalf2AtPtx653R290, r_PtxRegister291); // PTX L1355
	r_PtxRegister25 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(11));			   // PTX L1358
	r_PtxRegister26 = uint32_t(r_PtxRegister21) + uint32_t(128);					   // PTX L1359
	r_PtxRegister759 = uint32_t(0);													   // PTX L1360
L__BB27_50:																			   // PTX L1361
	r_PtxRegister634 = ShiftRight(uint32_t(r_PtxRegister759), uint32_t(6));			   // PTX L1362
	r_PtxU16Register47 = uint16_t(r_PtxRegister634);								   // PTX L1363
	r_PtxU16Register48 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register47)) * uint32_t(uint16_t(171))); // PTX L1364
	r_PtxU16Register49 = ShiftRight(uint16_t(r_PtxU16Register48), uint32_t(9));		// PTX L1365
	r_PtxU16Register50 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register49)) * uint32_t(uint16_t(3)));		 // PTX L1366
	r_PtxU16Register51 = uint16_t(r_PtxU16Register47) - uint16_t(r_PtxU16Register50);	 // PTX L1367
	r_PtxRegister635 = uint32_t(uint16_t(r_PtxU16Register51));							 // PTX L1368
	r_PtxRegister27 = r_PtxRegister635 & 255;											 // PTX L1369
	r_PtxU16Register52 = r_PtxU16Register51 & 255;										 // PTX L1370
	r_PtxRegister28 = uint32_t(uint16_t(r_PtxU16Register52)) * uint32_t(uint16_t(4096)); // PTX L1371
	r_LaneIndexAtPtx1373 = uint32_t((threadIdx.x & 31u));								 // PTX L1373
	r_PtxRegister636 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister25);			 // PTX L1375
	r_PtxRegister637 = uint32_t(0u /* exact native shared-region offset */);			 // PTX L1376
	r_PtxRegister638 = uint32_t(r_PtxRegister637) + uint32_t(r_PtxRegister636);			 // PTX L1377
	r_PtxRegister639 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1373), uint32_t(4));			 // PTX L1378
	r_PtxRegister579 = uint32_t(r_PtxRegister638) + uint32_t(r_PtxRegister639);			 // PTX L1379
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister579));
		r_MmaAE4x4WordAtPtx1381R586 = r_Value.x;
		r_MmaAE4x4WordAtPtx1381R587 = r_Value.y;
		r_MmaAE4x4WordAtPtx1381R588 = r_Value.z;
		r_MmaAE4x4WordAtPtx1381R589 = r_Value.w;
	} // PTX L1381
	r_LaneIndexAtPtx1384 = uint32_t((threadIdx.x & 31u));						// PTX L1384
	r_PtxRegister640 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1384), uint32_t(4));	// PTX L1386
	r_PtxRegister641 = uint32_t(r_PtxRegister638) + uint32_t(r_PtxRegister640); // PTX L1387
	r_PtxRegister581 = uint32_t(r_PtxRegister641) + uint32_t(512);				// PTX L1388
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister581));
		r_MmaAE4x4WordAtPtx1390R590 = r_Value.x;
		r_MmaAE4x4WordAtPtx1390R591 = r_Value.y;
		r_MmaAE4x4WordAtPtx1390R592 = r_Value.z;
		r_MmaAE4x4WordAtPtx1390R593 = r_Value.w;
	} // PTX L1390
	r_LaneIndexAtPtx1393 = uint32_t((threadIdx.x & 31u));						// PTX L1393
	r_PtxRegister642 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1393), uint32_t(4));	// PTX L1395
	r_PtxRegister643 = uint32_t(r_PtxRegister638) + uint32_t(r_PtxRegister642); // PTX L1396
	r_PtxRegister583 = uint32_t(r_PtxRegister643) + uint32_t(1024);				// PTX L1397
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister583));
		r_MmaAE4x4WordAtPtx1399R610 = r_Value.x;
		r_MmaAE4x4WordAtPtx1399R611 = r_Value.y;
		r_MmaAE4x4WordAtPtx1399R612 = r_Value.z;
		r_MmaAE4x4WordAtPtx1399R613 = r_Value.w;
	} // PTX L1399
	r_LaneIndexAtPtx1402 = uint32_t((threadIdx.x & 31u));						// PTX L1402
	r_PtxRegister644 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1402), uint32_t(4));	// PTX L1404
	r_PtxRegister645 = uint32_t(r_PtxRegister638) + uint32_t(r_PtxRegister644); // PTX L1405
	r_PtxRegister585 = uint32_t(r_PtxRegister645) + uint32_t(1536);				// PTX L1406
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister585));
		r_MmaAE4x4WordAtPtx1408R614 = r_Value.x;
		r_MmaAE4x4WordAtPtx1408R615 = r_Value.y;
		r_MmaAE4x4WordAtPtx1408R616 = r_Value.z;
		r_MmaAE4x4WordAtPtx1408R617 = r_Value.w;
	} // PTX L1408
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1411R594, r_MmaAccumulatorHalf2WordAtPtx1411R595,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx78R790, r_MmaBE4x4WordAtPtx78R789,
		  r_PackedHalf2AtPtx1138R756,
		  r_PackedHalf2AtPtx1145R755); // PTX L1411
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1418R596, r_MmaAccumulatorHalf2WordAtPtx1418R597,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx78R788, r_MmaBE4x4WordAtPtx78R787,
		  r_PackedHalf2AtPtx1152R754,
		  r_PackedHalf2AtPtx1159R753); // PTX L1418
	MmaE4(r_PackedHalf2AtPtx1138R756, r_PackedHalf2AtPtx1145R755, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx115R774, r_MmaBE4x4WordAtPtx115R773, r_MmaAccumulatorHalf2WordAtPtx1411R594,
		  r_MmaAccumulatorHalf2WordAtPtx1411R595); // PTX L1425
	MmaE4(r_PackedHalf2AtPtx1152R754, r_PackedHalf2AtPtx1159R753, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx115R772, r_MmaBE4x4WordAtPtx115R771, r_MmaAccumulatorHalf2WordAtPtx1418R596,
		  r_MmaAccumulatorHalf2WordAtPtx1418R597); // PTX L1432
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1439R598, r_MmaAccumulatorHalf2WordAtPtx1439R599,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx87R786, r_MmaBE4x4WordAtPtx87R785,
		  r_PackedHalf2AtPtx1166R752,
		  r_PackedHalf2AtPtx1173R751); // PTX L1439
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1446R600, r_MmaAccumulatorHalf2WordAtPtx1446R601,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx87R784, r_MmaBE4x4WordAtPtx87R783,
		  r_PackedHalf2AtPtx1180R750,
		  r_PackedHalf2AtPtx1187R749); // PTX L1446
	MmaE4(r_PackedHalf2AtPtx1166R752, r_PackedHalf2AtPtx1173R751, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx124R770, r_MmaBE4x4WordAtPtx124R769, r_MmaAccumulatorHalf2WordAtPtx1439R598,
		  r_MmaAccumulatorHalf2WordAtPtx1439R599); // PTX L1453
	MmaE4(r_PackedHalf2AtPtx1180R750, r_PackedHalf2AtPtx1187R749, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx124R768, r_MmaBE4x4WordAtPtx124R767, r_MmaAccumulatorHalf2WordAtPtx1446R600,
		  r_MmaAccumulatorHalf2WordAtPtx1446R601); // PTX L1460
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1467R602, r_MmaAccumulatorHalf2WordAtPtx1467R603,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx97R782, r_MmaBE4x4WordAtPtx97R781,
		  r_PackedHalf2AtPtx1194R748,
		  r_PackedHalf2AtPtx1201R747); // PTX L1467
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1474R604, r_MmaAccumulatorHalf2WordAtPtx1474R605,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx97R780, r_MmaBE4x4WordAtPtx97R779,
		  r_PackedHalf2AtPtx1208R746,
		  r_PackedHalf2AtPtx1215R745); // PTX L1474
	MmaE4(r_PackedHalf2AtPtx1194R748, r_PackedHalf2AtPtx1201R747, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx133R766, r_MmaBE4x4WordAtPtx133R765, r_MmaAccumulatorHalf2WordAtPtx1467R602,
		  r_MmaAccumulatorHalf2WordAtPtx1467R603); // PTX L1481
	MmaE4(r_PackedHalf2AtPtx1208R746, r_PackedHalf2AtPtx1215R745, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx133R764, r_MmaBE4x4WordAtPtx133R763, r_MmaAccumulatorHalf2WordAtPtx1474R604,
		  r_MmaAccumulatorHalf2WordAtPtx1474R605); // PTX L1488
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1495R606, r_MmaAccumulatorHalf2WordAtPtx1495R607,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx106R778, r_MmaBE4x4WordAtPtx106R777,
		  r_PackedHalf2AtPtx1222R744,
		  r_PackedHalf2AtPtx1229R743); // PTX L1495
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1502R608, r_MmaAccumulatorHalf2WordAtPtx1502R609,
		  r_MmaAE4x4WordAtPtx1381R586, r_MmaAE4x4WordAtPtx1381R587, r_MmaAE4x4WordAtPtx1381R588,
		  r_MmaAE4x4WordAtPtx1381R589, r_MmaBE4x4WordAtPtx106R776, r_MmaBE4x4WordAtPtx106R775,
		  r_PackedHalf2AtPtx1236R742,
		  r_PackedHalf2AtPtx1243R741); // PTX L1502
	MmaE4(r_PackedHalf2AtPtx1222R744, r_PackedHalf2AtPtx1229R743, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx142R762, r_MmaBE4x4WordAtPtx142R761, r_MmaAccumulatorHalf2WordAtPtx1495R606,
		  r_MmaAccumulatorHalf2WordAtPtx1495R607); // PTX L1509
	MmaE4(r_PackedHalf2AtPtx1236R742, r_PackedHalf2AtPtx1243R741, r_MmaAE4x4WordAtPtx1390R590,
		  r_MmaAE4x4WordAtPtx1390R591, r_MmaAE4x4WordAtPtx1390R592, r_MmaAE4x4WordAtPtx1390R593,
		  r_MmaBE4x4WordAtPtx142R760, r_MmaBE4x4WordAtPtx142R791, r_MmaAccumulatorHalf2WordAtPtx1502R608,
		  r_MmaAccumulatorHalf2WordAtPtx1502R609); // PTX L1516
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1523R618, r_MmaAccumulatorHalf2WordAtPtx1523R619,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx78R790, r_MmaBE4x4WordAtPtx78R789,
		  r_PackedHalf2AtPtx1250R740,
		  r_PackedHalf2AtPtx1257R739); // PTX L1523
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1530R620, r_MmaAccumulatorHalf2WordAtPtx1530R621,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx78R788, r_MmaBE4x4WordAtPtx78R787,
		  r_PackedHalf2AtPtx1264R738,
		  r_PackedHalf2AtPtx1271R737); // PTX L1530
	MmaE4(r_PackedHalf2AtPtx1250R740, r_PackedHalf2AtPtx1257R739, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx115R774, r_MmaBE4x4WordAtPtx115R773, r_MmaAccumulatorHalf2WordAtPtx1523R618,
		  r_MmaAccumulatorHalf2WordAtPtx1523R619); // PTX L1537
	MmaE4(r_PackedHalf2AtPtx1264R738, r_PackedHalf2AtPtx1271R737, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx115R772, r_MmaBE4x4WordAtPtx115R771, r_MmaAccumulatorHalf2WordAtPtx1530R620,
		  r_MmaAccumulatorHalf2WordAtPtx1530R621); // PTX L1544
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1551R622, r_MmaAccumulatorHalf2WordAtPtx1551R623,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx87R786, r_MmaBE4x4WordAtPtx87R785,
		  r_PackedHalf2AtPtx1278R736,
		  r_PackedHalf2AtPtx1285R735); // PTX L1551
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1558R624, r_MmaAccumulatorHalf2WordAtPtx1558R625,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx87R784, r_MmaBE4x4WordAtPtx87R783,
		  r_PackedHalf2AtPtx1292R734,
		  r_PackedHalf2AtPtx1299R733); // PTX L1558
	MmaE4(r_PackedHalf2AtPtx1278R736, r_PackedHalf2AtPtx1285R735, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx124R770, r_MmaBE4x4WordAtPtx124R769, r_MmaAccumulatorHalf2WordAtPtx1551R622,
		  r_MmaAccumulatorHalf2WordAtPtx1551R623); // PTX L1565
	MmaE4(r_PackedHalf2AtPtx1292R734, r_PackedHalf2AtPtx1299R733, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx124R768, r_MmaBE4x4WordAtPtx124R767, r_MmaAccumulatorHalf2WordAtPtx1558R624,
		  r_MmaAccumulatorHalf2WordAtPtx1558R625); // PTX L1572
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1579R626, r_MmaAccumulatorHalf2WordAtPtx1579R627,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx97R782, r_MmaBE4x4WordAtPtx97R781,
		  r_PackedHalf2AtPtx1306R732,
		  r_PackedHalf2AtPtx1313R731); // PTX L1579
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1586R628, r_MmaAccumulatorHalf2WordAtPtx1586R629,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx97R780, r_MmaBE4x4WordAtPtx97R779,
		  r_PackedHalf2AtPtx1320R730,
		  r_PackedHalf2AtPtx1327R729); // PTX L1586
	MmaE4(r_PackedHalf2AtPtx1306R732, r_PackedHalf2AtPtx1313R731, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx133R766, r_MmaBE4x4WordAtPtx133R765, r_MmaAccumulatorHalf2WordAtPtx1579R626,
		  r_MmaAccumulatorHalf2WordAtPtx1579R627); // PTX L1593
	MmaE4(r_PackedHalf2AtPtx1320R730, r_PackedHalf2AtPtx1327R729, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx133R764, r_MmaBE4x4WordAtPtx133R763, r_MmaAccumulatorHalf2WordAtPtx1586R628,
		  r_MmaAccumulatorHalf2WordAtPtx1586R629); // PTX L1600
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1607R630, r_MmaAccumulatorHalf2WordAtPtx1607R631,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx106R778, r_MmaBE4x4WordAtPtx106R777,
		  r_PackedHalf2AtPtx1334R728,
		  r_PackedHalf2AtPtx1341R727); // PTX L1607
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1614R632, r_MmaAccumulatorHalf2WordAtPtx1614R633,
		  r_MmaAE4x4WordAtPtx1399R610, r_MmaAE4x4WordAtPtx1399R611, r_MmaAE4x4WordAtPtx1399R612,
		  r_MmaAE4x4WordAtPtx1399R613, r_MmaBE4x4WordAtPtx106R776, r_MmaBE4x4WordAtPtx106R775,
		  r_PackedHalf2AtPtx1348R757,
		  r_PackedHalf2AtPtx1355R758); // PTX L1614
	MmaE4(r_PackedHalf2AtPtx1334R728, r_PackedHalf2AtPtx1341R727, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx142R762, r_MmaBE4x4WordAtPtx142R761, r_MmaAccumulatorHalf2WordAtPtx1607R630,
		  r_MmaAccumulatorHalf2WordAtPtx1607R631); // PTX L1621
	MmaE4(r_PackedHalf2AtPtx1348R757, r_PackedHalf2AtPtx1355R758, r_MmaAE4x4WordAtPtx1408R614,
		  r_MmaAE4x4WordAtPtx1408R615, r_MmaAE4x4WordAtPtx1408R616, r_MmaAE4x4WordAtPtx1408R617,
		  r_MmaBE4x4WordAtPtx142R760, r_MmaBE4x4WordAtPtx142R791, r_MmaAccumulatorHalf2WordAtPtx1614R632,
		  r_MmaAccumulatorHalf2WordAtPtx1614R633);					// PTX L1628
	r_bPtxPredicate33 = uint32_t(r_PtxRegister759) > uint32_t(447); // PTX L1634
	if (r_bPtxPredicate33)
	{
		goto L__BB27_53;
	} // PTX L1635
	r_PtxRegister655 = uint32_t(r_PtxRegister759) + uint32_t(64);								  // PTX L1636
	r_PtxRegister656 = uint32_t(r_PtxRegister655) + uint32_t(r_PtxRegister7);					  // PTX L1637
	r_PtxRegister657 = ShiftLeft(uint32_t(r_PtxRegister656), uint32_t(7));						  // PTX L1638
	r_PtxRegister658 = uint32_t(r_PtxRegister657) + uint32_t(r_PtxRegister12);					  // PTX L1639
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister658)) * int64_t(int32_t(4)));	  // PTX L1640
	g_RecordByteAddressAtPtx1641 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register127); // PTX L1641
	r_LaneIndexAtPtx1643 = uint32_t((threadIdx.x & 31u));										  // PTX L1643
	r_PtxU64Register129 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1643)) * int64_t(int32_t(16))); // PTX L1645
	g_RecordByteAddressAtPtx1646 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register129); // PTX L1646
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1646));
		r_MmaBE4x4WordAtPtx78R790 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R789 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R788 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R787 = r_Value.w;
	} // PTX L1648
	r_LaneIndexAtPtx1651 = uint32_t((threadIdx.x & 31u)); // PTX L1651
	r_PtxU64Register130 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1651)) * int64_t(int32_t(16))); // PTX L1653
	g_RecordByteAddressAtPtx1654 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register130);			   // PTX L1654
	g_RecordByteAddressAtPtx1655 = uint64_t(g_RecordByteAddressAtPtx1654) + uint64_t(512); // PTX L1655
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1655));
		r_MmaBE4x4WordAtPtx87R786 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R785 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R784 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R783 = r_Value.w;
	} // PTX L1657
	r_LaneIndexAtPtx1660 = uint32_t((threadIdx.x & 31u)); // PTX L1660
	r_PtxU64Register132 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1660)) * int64_t(int32_t(16))); // PTX L1662
	g_RecordByteAddressAtPtx1663 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register132);				// PTX L1663
	g_RecordByteAddressAtPtx1664 = uint64_t(g_RecordByteAddressAtPtx1663) + uint64_t(1024); // PTX L1664
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1664));
		r_MmaBE4x4WordAtPtx97R782 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R781 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R780 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R779 = r_Value.w;
	} // PTX L1666
	r_LaneIndexAtPtx1669 = uint32_t((threadIdx.x & 31u)); // PTX L1669
	r_PtxU64Register134 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1669)) * int64_t(int32_t(16))); // PTX L1671
	g_RecordByteAddressAtPtx1672 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register134);				// PTX L1672
	g_RecordByteAddressAtPtx1673 = uint64_t(g_RecordByteAddressAtPtx1672) + uint64_t(1536); // PTX L1673
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1673));
		r_MmaBE4x4WordAtPtx106R778 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R777 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R776 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R775 = r_Value.w;
	} // PTX L1675
	r_LaneIndexAtPtx1678 = uint32_t((threadIdx.x & 31u)); // PTX L1678
	r_PtxU64Register136 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1678)) * int64_t(int32_t(16))); // PTX L1680
	g_RecordByteAddressAtPtx1681 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register136);				 // PTX L1681
	g_RecordByteAddressAtPtx1682 = uint64_t(g_RecordByteAddressAtPtx1681) + uint64_t(16384); // PTX L1682
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1682));
		r_MmaBE4x4WordAtPtx115R774 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R773 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R772 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R771 = r_Value.w;
	} // PTX L1684
	r_LaneIndexAtPtx1687 = uint32_t((threadIdx.x & 31u)); // PTX L1687
	r_PtxU64Register138 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1687)) * int64_t(int32_t(16))); // PTX L1689
	g_RecordByteAddressAtPtx1690 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register138);				 // PTX L1690
	g_RecordByteAddressAtPtx1691 = uint64_t(g_RecordByteAddressAtPtx1690) + uint64_t(16896); // PTX L1691
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1691));
		r_MmaBE4x4WordAtPtx124R770 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R769 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R768 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R767 = r_Value.w;
	} // PTX L1693
	r_LaneIndexAtPtx1696 = uint32_t((threadIdx.x & 31u)); // PTX L1696
	r_PtxU64Register140 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1696)) * int64_t(int32_t(16))); // PTX L1698
	g_RecordByteAddressAtPtx1699 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register140);				 // PTX L1699
	g_RecordByteAddressAtPtx1700 = uint64_t(g_RecordByteAddressAtPtx1699) + uint64_t(17408); // PTX L1700
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1700));
		r_MmaBE4x4WordAtPtx133R766 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R765 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R764 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R763 = r_Value.w;
	} // PTX L1702
	r_LaneIndexAtPtx1705 = uint32_t((threadIdx.x & 31u)); // PTX L1705
	r_PtxU64Register142 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1705)) * int64_t(int32_t(16))); // PTX L1707
	g_RecordByteAddressAtPtx1708 =
		uint64_t(g_RecordByteAddressAtPtx1641) + uint64_t(r_PtxU64Register142);				 // PTX L1708
	g_RecordByteAddressAtPtx1709 = uint64_t(g_RecordByteAddressAtPtx1708) + uint64_t(17920); // PTX L1709
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1709));
		r_MmaBE4x4WordAtPtx142R762 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R761 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R760 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R791 = r_Value.w;
	} // PTX L1711
	r_PtxRegister659 = ShiftRight(uint32_t(r_PtxRegister655), uint32_t(6)); // PTX L1713
	r_PtxU16Register53 = uint16_t(r_PtxRegister659);						// PTX L1714
	r_PtxU16Register54 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register53)) * uint32_t(uint16_t(171))); // PTX L1715
	r_PtxU16Register55 = ShiftRight(uint16_t(r_PtxU16Register54), uint32_t(9));		// PTX L1716
	r_PtxU16Register56 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register55)) * uint32_t(uint16_t(3)));			  // PTX L1717
	r_PtxU16Register57 = uint16_t(r_PtxU16Register53) - uint16_t(r_PtxU16Register56);		  // PTX L1718
	r_PtxU16Register58 = r_PtxU16Register57 & 255;											  // PTX L1719
	r_PtxRegister660 = uint32_t(uint16_t(r_PtxU16Register58)) * uint32_t(uint16_t(8));		  // PTX L1720
	r_PtxRegister661 = uint32_t(12288u /* exact native shared-region offset */);			  // PTX L1721
	r_PtxRegister663 = uint32_t(r_PtxRegister661) + uint32_t(r_PtxRegister660);				  // PTX L1722
	r_PtxRegister654 = uint32_t(1);															  // PTX L1723
	r_PtxU64Register144 = BarrierArrive(s_SharedStorage, r_PtxRegister663, r_PtxRegister654); // PTX L1725
L__BB27_52:																					  // PTX L1727
	r_PtxRegister662 = BarrierReady(s_SharedStorage, r_PtxRegister663, r_PtxU64Register144);  // PTX L1729
	r_bPtxPredicate34 = uint32_t(r_PtxRegister662) == uint32_t(0);							  // PTX L1735
	if (r_bPtxPredicate34)
	{
		goto L__BB27_52;
	} // PTX L1736
L__BB27_53:															// PTX L1737
	r_bPtxPredicate35 = uint32_t(r_PtxRegister759) > uint32_t(319); // PTX L1738
	if (r_bPtxPredicate35)
	{
		goto L__BB27_62;
	} // PTX L1739
	r_bPtxPredicate36 = int32_t(r_PtxRegister16) < int32_t(r_WidthDiv4Bits); // PTX L1740
	r_bPtxPredicate37 = r_bPtxPredicate3 | r_bPtxPredicate36;				 // PTX L1741
	r_bPtxPredicate7 = r_bPtxPredicate37 & r_bPtxPredicate2;				 // PTX L1742
	r_PtxU64Register165 = uint64_t(0);										 // PTX L1743
	r_bPtxPredicate38 = !r_bPtxPredicate7;									 // PTX L1744
	if (r_bPtxPredicate38)
	{
		goto L__BB27_56;
	} // PTX L1745
	r_PtxRegister664 = r_bPtxPredicate4 ? 0 : r_PtxRegister16;					// PTX L1746
	r_PtxRegister665 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister664);	// PTX L1747
	r_PtxRegister666 = ShiftLeft(uint32_t(r_PtxRegister665), uint32_t(11));		// PTX L1748
	r_PtxRegister667 = uint32_t(r_PtxRegister759) + uint32_t(r_PtxRegister26);	// PTX L1749
	r_PtxRegister668 = ShiftLeft(uint32_t(r_PtxRegister667), uint32_t(2));		// PTX L1750
	r_PtxRegister669 = uint32_t(r_PtxRegister666) + uint32_t(r_PtxRegister668); // PTX L1751
	r_PtxU64Register165 = SignExtendWordBits(r_PtxRegister669);					// PTX L1752
L__BB27_56:																		// PTX L1753
	r_PtxU64Register166 = uint64_t(0);											// PTX L1754
	if (r_bPtxPredicate38)
	{
		goto L__BB27_58;
	} // PTX L1755
	r_PtxU64Register145 = ShiftLeft(uint64_t(r_PtxU64Register165), uint32_t(2));		// PTX L1756
	r_PtxU64Register166 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register145); // PTX L1757
L__BB27_58:																				// PTX L1758
	if (r_bPtxPredicate38)
	{
		goto L__BB27_61;
	} // PTX L1759
	r_PtxRegister678 = uint32_t(-1);							   // PTX L1760
	r_PtxRegister677 = Elected(r_PtxRegister678);				   // PTX L1762
	r_bPtxPredicate39 = uint32_t(r_PtxRegister677) == uint32_t(0); // PTX L1768
	if (r_bPtxPredicate39)
	{
		goto L__BB27_62;
	} // PTX L1769
	r_PtxRegister679 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister28);	 // PTX L1770
	r_PtxU64Register146 = r_PtxU64Register166;									 // PTX L1771
	r_PtxRegister682 = ShiftLeft(uint32_t(r_PtxRegister27), uint32_t(3));		 // PTX L1772
	r_PtxRegister683 = uint32_t(12288u /* exact native shared-region offset */); // PTX L1773
	r_PtxRegister681 = uint32_t(r_PtxRegister683) + uint32_t(r_PtxRegister682);	 // PTX L1774
	r_PtxRegister680 = uint32_t(512);											 // PTX L1775
	CopyBulk(s_SharedStorage, r_PtxRegister679, r_PtxU64Register146, r_PtxRegister680,
			 r_PtxRegister681);																   // PTX L1777
	BarrierExpect(s_SharedStorage, r_PtxRegister681, r_PtxRegister680);						   // PTX L1780
	goto L__BB27_62;																		   // PTX L1782
L__BB27_61:																					   // PTX L1783
	r_PtxRegister670 = uint32_t(0);															   // PTX L1784
	r_PtxU16Register59 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister670))); // PTX L1786
	r_PackedHalf2AtPtx1789R671 = JoinHalfwords(r_PtxU16Register59, r_PtxU16Register59);		   // PTX L1789
	r_ConvertedE4PairAtPtx1791Rs60 = PublishE4(r_PackedHalf2AtPtx1789R671);					   // PTX L1791
	r_PackedE4WordAtPtx1793R674 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1791Rs60, r_ConvertedE4PairAtPtx1791Rs60); // PTX L1793
	r_LaneIndexAtPtx1795 = uint32_t((threadIdx.x & 31u));							   // PTX L1795
	r_PtxRegister675 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister28);		   // PTX L1797
	r_PtxRegister676 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1795), uint32_t(4));		   // PTX L1798
	r_PtxRegister673 = uint32_t(r_PtxRegister675) + uint32_t(r_PtxRegister676);		   // PTX L1799
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister673)) =
		make_uint4(r_PackedE4WordAtPtx1793R674, r_PackedE4WordAtPtx1793R674, r_PackedE4WordAtPtx1793R674,
				   r_PackedE4WordAtPtx1793R674);					// PTX L1801
L__BB27_62:															// PTX L1803
	r_bPtxPredicate40 = uint32_t(r_PtxRegister759) < uint32_t(448); // PTX L1804
	r_PtxRegister759 = uint32_t(r_PtxRegister759) + uint32_t(64);	// PTX L1805
	if (r_bPtxPredicate40)
	{
		goto L__BB27_50;
	} // PTX L1806
	r_bPtxPredicate41 = int32_t(r_PtxRegister6) >= int32_t(r_WidthDiv4Bits);					  // PTX L1807
	r_bPtxPredicate42 = int32_t(r_PtxRegister75) >= int32_t(r_HeightDiv4Bits);					  // PTX L1808
	r_ConvertedE4PairAtPtx1810Rs61 = PublishE4(r_PackedHalf2AtPtx1138R756);						  // PTX L1810
	r_ConvertedE4PairAtPtx1813Rs62 = PublishE4(r_PackedHalf2AtPtx1152R754);						  // PTX L1813
	r_ConvertedE4PairAtPtx1816Rs63 = PublishE4(r_PackedHalf2AtPtx1145R755);						  // PTX L1816
	r_ConvertedE4PairAtPtx1819Rs64 = PublishE4(r_PackedHalf2AtPtx1159R753);						  // PTX L1819
	r_ConvertedE4PairAtPtx1822Rs65 = PublishE4(r_PackedHalf2AtPtx1166R752);						  // PTX L1822
	r_ConvertedE4PairAtPtx1825Rs66 = PublishE4(r_PackedHalf2AtPtx1180R750);						  // PTX L1825
	r_ConvertedE4PairAtPtx1828Rs67 = PublishE4(r_PackedHalf2AtPtx1173R751);						  // PTX L1828
	r_ConvertedE4PairAtPtx1831Rs68 = PublishE4(r_PackedHalf2AtPtx1187R749);						  // PTX L1831
	r_ConvertedE4PairAtPtx1834Rs69 = PublishE4(r_PackedHalf2AtPtx1194R748);						  // PTX L1834
	r_ConvertedE4PairAtPtx1837Rs70 = PublishE4(r_PackedHalf2AtPtx1208R746);						  // PTX L1837
	r_ConvertedE4PairAtPtx1840Rs71 = PublishE4(r_PackedHalf2AtPtx1201R747);						  // PTX L1840
	r_ConvertedE4PairAtPtx1843Rs72 = PublishE4(r_PackedHalf2AtPtx1215R745);						  // PTX L1843
	r_ConvertedE4PairAtPtx1846Rs73 = PublishE4(r_PackedHalf2AtPtx1222R744);						  // PTX L1846
	r_ConvertedE4PairAtPtx1849Rs74 = PublishE4(r_PackedHalf2AtPtx1236R742);						  // PTX L1849
	r_ConvertedE4PairAtPtx1852Rs75 = PublishE4(r_PackedHalf2AtPtx1229R743);						  // PTX L1852
	r_ConvertedE4PairAtPtx1855Rs76 = PublishE4(r_PackedHalf2AtPtx1243R741);						  // PTX L1855
	r_ConvertedE4PairAtPtx1858Rs77 = PublishE4(r_PackedHalf2AtPtx1250R740);						  // PTX L1858
	r_ConvertedE4PairAtPtx1861Rs78 = PublishE4(r_PackedHalf2AtPtx1264R738);						  // PTX L1861
	r_ConvertedE4PairAtPtx1864Rs79 = PublishE4(r_PackedHalf2AtPtx1257R739);						  // PTX L1864
	r_ConvertedE4PairAtPtx1867Rs80 = PublishE4(r_PackedHalf2AtPtx1271R737);						  // PTX L1867
	r_ConvertedE4PairAtPtx1870Rs81 = PublishE4(r_PackedHalf2AtPtx1278R736);						  // PTX L1870
	r_ConvertedE4PairAtPtx1873Rs82 = PublishE4(r_PackedHalf2AtPtx1292R734);						  // PTX L1873
	r_ConvertedE4PairAtPtx1876Rs83 = PublishE4(r_PackedHalf2AtPtx1285R735);						  // PTX L1876
	r_ConvertedE4PairAtPtx1879Rs84 = PublishE4(r_PackedHalf2AtPtx1299R733);						  // PTX L1879
	r_ConvertedE4PairAtPtx1882Rs85 = PublishE4(r_PackedHalf2AtPtx1306R732);						  // PTX L1882
	r_ConvertedE4PairAtPtx1885Rs86 = PublishE4(r_PackedHalf2AtPtx1320R730);						  // PTX L1885
	r_ConvertedE4PairAtPtx1888Rs87 = PublishE4(r_PackedHalf2AtPtx1313R731);						  // PTX L1888
	r_ConvertedE4PairAtPtx1891Rs88 = PublishE4(r_PackedHalf2AtPtx1327R729);						  // PTX L1891
	r_ConvertedE4PairAtPtx1894Rs89 = PublishE4(r_PackedHalf2AtPtx1334R728);						  // PTX L1894
	r_ConvertedE4PairAtPtx1897Rs90 = PublishE4(r_PackedHalf2AtPtx1348R757);						  // PTX L1897
	r_ConvertedE4PairAtPtx1900Rs91 = PublishE4(r_PackedHalf2AtPtx1341R727);						  // PTX L1900
	r_ConvertedE4PairAtPtx1903Rs92 = PublishE4(r_PackedHalf2AtPtx1355R758);						  // PTX L1903
	r_PtxRegister684 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister6);					  // PTX L1905
	r_PtxRegister685 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));						  // PTX L1906
	r_PtxRegister686 = ShiftLeft(uint32_t(r_PtxRegister684), uint32_t(11));						  // PTX L1907
	r_PtxRegister687 = uint32_t(r_PtxRegister686) + uint32_t(r_PtxRegister685);					  // PTX L1908
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister687)) * int64_t(int32_t(4)));	  // PTX L1909
	g_OutputByteAddressAtPtx1910 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register147); // PTX L1910
	r_bPtxPredicate43 = r_bPtxPredicate42 | r_bPtxPredicate41;									  // PTX L1911
	if (r_bPtxPredicate43)
	{
		goto L__BB27_65;
	} // PTX L1912
	r_PackedE4WordAtPtx1913R697 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1852Rs75, r_ConvertedE4PairAtPtx1855Rs76); // PTX L1913
	r_PackedE4WordAtPtx1914R696 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1846Rs73, r_ConvertedE4PairAtPtx1849Rs74); // PTX L1914
	r_PackedE4WordAtPtx1915R695 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1840Rs71, r_ConvertedE4PairAtPtx1843Rs72); // PTX L1915
	r_PackedE4WordAtPtx1916R694 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1834Rs69, r_ConvertedE4PairAtPtx1837Rs70); // PTX L1916
	r_PackedE4WordAtPtx1917R692 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1828Rs67, r_ConvertedE4PairAtPtx1831Rs68); // PTX L1917
	r_PackedE4WordAtPtx1918R691 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1822Rs65, r_ConvertedE4PairAtPtx1825Rs66); // PTX L1918
	r_PackedE4WordAtPtx1919R690 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1816Rs63, r_ConvertedE4PairAtPtx1819Rs64); // PTX L1919
	r_PackedE4WordAtPtx1920R689 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1810Rs61, r_ConvertedE4PairAtPtx1813Rs62); // PTX L1920
	r_LaneIndexAtPtx1922 = uint32_t((threadIdx.x & 31u));							   // PTX L1922
	r_PtxU64Register150 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1922)) * int64_t(int32_t(16))); // PTX L1924
	g_OutputByteAddressAtPtx1925 =
		uint64_t(g_OutputByteAddressAtPtx1910) + uint64_t(r_PtxU64Register150); // PTX L1925
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx1925,
					make_uint4(r_PackedE4WordAtPtx1920R689, r_PackedE4WordAtPtx1919R690,
							   r_PackedE4WordAtPtx1918R691,
							   r_PackedE4WordAtPtx1917R692)); // PTX L1927
	r_LaneIndexAtPtx1930 = uint32_t((threadIdx.x & 31u));	  // PTX L1930
	r_PtxU64Register151 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1930)) * int64_t(int32_t(16))); // PTX L1932
	g_OutputByteAddressAtPtx1933 =
		uint64_t(g_OutputByteAddressAtPtx1910) + uint64_t(r_PtxU64Register151);			   // PTX L1933
	g_OutputByteAddressAtPtx1934 = uint64_t(g_OutputByteAddressAtPtx1933) + uint64_t(512); // PTX L1934
	StoreNoAllocate(g_OutputByteAddressAtPtx1934,
					make_uint4(r_PackedE4WordAtPtx1916R694, r_PackedE4WordAtPtx1915R695,
							   r_PackedE4WordAtPtx1914R696,
							   r_PackedE4WordAtPtx1913R697));				  // PTX L1936
L__BB27_65:																	  // PTX L1938
	r_bPtxPredicate44 = int32_t(r_PtxRegister23) >= int32_t(r_WidthDiv4Bits); // PTX L1939
	r_bPtxPredicate45 = r_bPtxPredicate42 | r_bPtxPredicate44;				  // PTX L1940
	if (r_bPtxPredicate45)
	{
		goto L__BB27_67;
	} // PTX L1941
	r_LaneIndexAtPtx1943 = uint32_t((threadIdx.x & 31u)); // PTX L1943
	r_PtxU64Register155 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1943)) * int64_t(int32_t(16))); // PTX L1945
	g_OutputByteAddressAtPtx1946 =
		uint64_t(g_OutputByteAddressAtPtx1910) + uint64_t(r_PtxU64Register155);				// PTX L1946
	g_OutputByteAddressAtPtx1947 = uint64_t(g_OutputByteAddressAtPtx1946) + uint64_t(8192); // PTX L1947
	r_PackedE4WordAtPtx1948R702 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1876Rs83, r_ConvertedE4PairAtPtx1879Rs84); // PTX L1948
	r_PackedE4WordAtPtx1949R701 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1870Rs81, r_ConvertedE4PairAtPtx1873Rs82); // PTX L1949
	r_PackedE4WordAtPtx1950R700 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1864Rs79, r_ConvertedE4PairAtPtx1867Rs80); // PTX L1950
	r_PackedE4WordAtPtx1951R699 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1858Rs77, r_ConvertedE4PairAtPtx1861Rs78); // PTX L1951
	StoreNoAllocate(g_OutputByteAddressAtPtx1947,
					make_uint4(r_PackedE4WordAtPtx1951R699, r_PackedE4WordAtPtx1950R700,
							   r_PackedE4WordAtPtx1949R701,
							   r_PackedE4WordAtPtx1948R702)); // PTX L1953
	r_LaneIndexAtPtx1956 = uint32_t((threadIdx.x & 31u));	  // PTX L1956
	r_PtxU64Register157 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1956)) * int64_t(int32_t(16))); // PTX L1958
	g_OutputByteAddressAtPtx1959 =
		uint64_t(g_OutputByteAddressAtPtx1910) + uint64_t(r_PtxU64Register157);				// PTX L1959
	g_OutputByteAddressAtPtx1960 = uint64_t(g_OutputByteAddressAtPtx1959) + uint64_t(8704); // PTX L1960
	r_PackedE4WordAtPtx1961R707 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1900Rs91, r_ConvertedE4PairAtPtx1903Rs92); // PTX L1961
	r_PackedE4WordAtPtx1962R706 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1894Rs89, r_ConvertedE4PairAtPtx1897Rs90); // PTX L1962
	r_PackedE4WordAtPtx1963R705 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1888Rs87, r_ConvertedE4PairAtPtx1891Rs88); // PTX L1963
	r_PackedE4WordAtPtx1964R704 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1882Rs85, r_ConvertedE4PairAtPtx1885Rs86); // PTX L1964
	StoreNoAllocate(g_OutputByteAddressAtPtx1960,
					make_uint4(r_PackedE4WordAtPtx1964R704, r_PackedE4WordAtPtx1963R705,
							   r_PackedE4WordAtPtx1962R706,
							   r_PackedE4WordAtPtx1961R707)); // PTX L1966
L__BB27_67:													  // PTX L1968
	return;													  // PTX L1969
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
