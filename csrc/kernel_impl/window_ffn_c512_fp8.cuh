// Equivalent CUDA C++ reconstruction of the original C512 FFN fp8 entry.
// Original scalar/control spelling retained; this is not the historical C++ source.
#pragma once
#include "window_ffn_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_ffn_c512_fp8
{
__global__ __maxnreg__(128) void window_ffn_c512_fp8(Parameters r_Parameters)
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
		r_bPtxPredicate30, r_bPtxPredicate31, r_bPtxPredicate32;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx206Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx335Rs4,
		r_ConvertedE4PairAtPtx1031Rs5, r_ConvertedE4PairAtPtx1034Rs6, r_ConvertedE4PairAtPtx1038Rs7,
		r_ConvertedE4PairAtPtx1041Rs8, r_ConvertedE4PairAtPtx1045Rs9, r_ConvertedE4PairAtPtx1048Rs10,
		r_ConvertedE4PairAtPtx1052Rs11, r_ConvertedE4PairAtPtx1055Rs12;
	uint16_t r_ConvertedE4PairAtPtx1059Rs13, r_ConvertedE4PairAtPtx1062Rs14, r_ConvertedE4PairAtPtx1066Rs15,
		r_ConvertedE4PairAtPtx1069Rs16, r_ConvertedE4PairAtPtx1073Rs17, r_ConvertedE4PairAtPtx1076Rs18,
		r_ConvertedE4PairAtPtx1080Rs19, r_ConvertedE4PairAtPtx1083Rs20, r_ConvertedE4PairAtPtx1160Rs21,
		r_ConvertedE4PairAtPtx1163Rs22, r_ConvertedE4PairAtPtx1167Rs23, r_ConvertedE4PairAtPtx1170Rs24;
	uint16_t r_ConvertedE4PairAtPtx1174Rs25, r_ConvertedE4PairAtPtx1177Rs26, r_ConvertedE4PairAtPtx1181Rs27,
		r_ConvertedE4PairAtPtx1184Rs28, r_ConvertedE4PairAtPtx1188Rs29, r_ConvertedE4PairAtPtx1191Rs30,
		r_ConvertedE4PairAtPtx1195Rs31, r_ConvertedE4PairAtPtx1198Rs32, r_ConvertedE4PairAtPtx1202Rs33,
		r_ConvertedE4PairAtPtx1205Rs34, r_ConvertedE4PairAtPtx1209Rs35, r_ConvertedE4PairAtPtx1212Rs36;
	uint16_t r_ConvertedE4PairAtPtx1774Rs37, r_ConvertedE4PairAtPtx1777Rs38, r_ConvertedE4PairAtPtx1781Rs39,
		r_ConvertedE4PairAtPtx1784Rs40, r_ConvertedE4PairAtPtx1788Rs41, r_ConvertedE4PairAtPtx1791Rs42,
		r_ConvertedE4PairAtPtx1795Rs43, r_ConvertedE4PairAtPtx1798Rs44, r_ConvertedE4PairAtPtx1802Rs45,
		r_ConvertedE4PairAtPtx1805Rs46, r_ConvertedE4PairAtPtx1809Rs47, r_ConvertedE4PairAtPtx1812Rs48;
	uint16_t r_ConvertedE4PairAtPtx1816Rs49, r_ConvertedE4PairAtPtx1819Rs50, r_ConvertedE4PairAtPtx1823Rs51,
		r_ConvertedE4PairAtPtx1826Rs52, r_ConvertedE4PairAtPtx1950Rs53, r_ConvertedE4PairAtPtx1953Rs54,
		r_ConvertedE4PairAtPtx1956Rs55, r_ConvertedE4PairAtPtx1959Rs56, r_ConvertedE4PairAtPtx1962Rs57,
		r_ConvertedE4PairAtPtx1965Rs58, r_ConvertedE4PairAtPtx1968Rs59, r_ConvertedE4PairAtPtx1971Rs60;
	uint16_t r_ConvertedE4PairAtPtx1974Rs61, r_ConvertedE4PairAtPtx1977Rs62, r_ConvertedE4PairAtPtx1980Rs63,
		r_ConvertedE4PairAtPtx1983Rs64, r_ConvertedE4PairAtPtx1986Rs65, r_ConvertedE4PairAtPtx1989Rs66,
		r_ConvertedE4PairAtPtx1992Rs67, r_ConvertedE4PairAtPtx1995Rs68, r_ConvertedE4PairAtPtx1998Rs69,
		r_ConvertedE4PairAtPtx2001Rs70, r_ConvertedE4PairAtPtx2004Rs71, r_ConvertedE4PairAtPtx2007Rs72;
	uint16_t r_ConvertedE4PairAtPtx2010Rs73, r_ConvertedE4PairAtPtx2013Rs74, r_ConvertedE4PairAtPtx2016Rs75,
		r_ConvertedE4PairAtPtx2019Rs76, r_ConvertedE4PairAtPtx2022Rs77, r_ConvertedE4PairAtPtx2025Rs78,
		r_ConvertedE4PairAtPtx2028Rs79, r_ConvertedE4PairAtPtx2031Rs80, r_ConvertedE4PairAtPtx2034Rs81,
		r_ConvertedE4PairAtPtx2037Rs82, r_ConvertedE4PairAtPtx2040Rs83, r_ConvertedE4PairAtPtx2043Rs84;
	uint32_t r_HeightBits, r_WidthBits, r_CtaZ, r_PtxRegister4, r_HeightDiv4Bits, r_WidthDiv4Bits, r_ThreadY,
		r_PackedHalf2AtPtx49R8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_CtaX, r_HeightSignBits, r_HeightDiv4Bias, r_HeightBiasedForDiv4,
		r_WidthSignBits, r_WidthDiv4Bias, r_WidthBiasedForDiv4, r_ThreadX, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx47R40, r_LaneIndexAtPtx62,
		r_LaneIndexAtPtx73, r_LaneIndexAtPtx82, r_LaneIndexAtPtx91, r_LaneIndexAtPtx99, r_LaneIndexAtPtx108,
		r_LaneIndexAtPtx117, r_LaneIndexAtPtx126;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53,
		r_PtxRegister54, r_PtxRegister55, r_PtxRegister56, r_CtaY, r_PtxRegister58, r_PtxRegister59,
		r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PackedHalf2AtPtx204R69, r_LaneIndexAtPtx210,
		r_PtxRegister71, r_PackedE4WordAtPtx208R72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PackedHalf2AtPtx333R96;
	uint32_t r_LaneIndexAtPtx339, r_PtxRegister98, r_PackedE4WordAtPtx337R99, r_PtxRegister100,
		r_PtxRegister101, r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105,
		r_PtxRegister106, r_LaneIndexAtPtx351, r_PtxRegister108;
	uint32_t r_LaneIndexAtPtx360, r_PtxRegister110, r_LaneIndexAtPtx371, r_PtxRegister112,
		r_LaneIndexAtPtx380, r_PtxRegister114, r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116,
		r_MmaAE4x4WordAtPtx357R117, r_MmaAE4x4WordAtPtx357R118, r_MmaAE4x4WordAtPtx368R119,
		r_MmaAE4x4WordAtPtx368R120;
	uint32_t r_MmaAE4x4WordAtPtx368R121, r_MmaAE4x4WordAtPtx368R122, r_MmaAccumulatorHalf2WordAtPtx389R123,
		r_MmaAccumulatorHalf2WordAtPtx389R124, r_MmaAccumulatorHalf2WordAtPtx396R125,
		r_MmaAccumulatorHalf2WordAtPtx396R126, r_MmaAccumulatorHalf2WordAtPtx417R127,
		r_MmaAccumulatorHalf2WordAtPtx417R128, r_MmaAccumulatorHalf2WordAtPtx424R129,
		r_MmaAccumulatorHalf2WordAtPtx424R130, r_MmaAccumulatorHalf2WordAtPtx445R131,
		r_MmaAccumulatorHalf2WordAtPtx445R132;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx452R133, r_MmaAccumulatorHalf2WordAtPtx452R134,
		r_MmaAccumulatorHalf2WordAtPtx473R135, r_MmaAccumulatorHalf2WordAtPtx473R136,
		r_MmaAccumulatorHalf2WordAtPtx480R137, r_MmaAccumulatorHalf2WordAtPtx480R138,
		r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		r_MmaAE4x4WordAtPtx377R142, r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144;
	uint32_t r_MmaAE4x4WordAtPtx386R145, r_MmaAE4x4WordAtPtx386R146, r_MmaAccumulatorHalf2WordAtPtx501R147,
		r_MmaAccumulatorHalf2WordAtPtx501R148, r_MmaAccumulatorHalf2WordAtPtx508R149,
		r_MmaAccumulatorHalf2WordAtPtx508R150, r_MmaAccumulatorHalf2WordAtPtx529R151,
		r_MmaAccumulatorHalf2WordAtPtx529R152, r_MmaAccumulatorHalf2WordAtPtx536R153,
		r_MmaAccumulatorHalf2WordAtPtx536R154, r_MmaAccumulatorHalf2WordAtPtx557R155,
		r_MmaAccumulatorHalf2WordAtPtx557R156;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx564R157, r_MmaAccumulatorHalf2WordAtPtx564R158,
		r_MmaAccumulatorHalf2WordAtPtx585R159, r_MmaAccumulatorHalf2WordAtPtx585R160,
		r_MmaAccumulatorHalf2WordAtPtx592R161, r_MmaAccumulatorHalf2WordAtPtx592R162, r_LaneIndexAtPtx617,
		r_LaneIndexAtPtx625, r_LaneIndexAtPtx634, r_LaneIndexAtPtx643, r_LaneIndexAtPtx652,
		r_LaneIndexAtPtx661;
	uint32_t r_LaneIndexAtPtx670, r_LaneIndexAtPtx679, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_LaneIndexAtPtx705, r_PtxRegister188, r_LaneIndexAtPtx716, r_PtxRegister190,
		r_LaneIndexAtPtx726, r_PtxRegister192;
	uint32_t r_LaneIndexAtPtx735, r_PtxRegister194, r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196,
		r_MmaAE4x4WordAtPtx713R197, r_MmaAE4x4WordAtPtx713R198, r_MmaAE4x4WordAtPtx723R199,
		r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201, r_MmaAE4x4WordAtPtx723R202,
		r_MmaAccumulatorHalf2WordAtPtx744R203, r_MmaAccumulatorHalf2WordAtPtx744R204;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx751R205, r_MmaAccumulatorHalf2WordAtPtx751R206,
		r_MmaAccumulatorHalf2WordAtPtx772R207, r_MmaAccumulatorHalf2WordAtPtx772R208,
		r_MmaAccumulatorHalf2WordAtPtx779R209, r_MmaAccumulatorHalf2WordAtPtx779R210,
		r_MmaAccumulatorHalf2WordAtPtx800R211, r_MmaAccumulatorHalf2WordAtPtx800R212,
		r_MmaAccumulatorHalf2WordAtPtx807R213, r_MmaAccumulatorHalf2WordAtPtx807R214,
		r_MmaAccumulatorHalf2WordAtPtx828R215, r_MmaAccumulatorHalf2WordAtPtx828R216;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx835R217, r_MmaAccumulatorHalf2WordAtPtx835R218,
		r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		r_MmaAE4x4WordAtPtx732R222, r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224,
		r_MmaAE4x4WordAtPtx741R225, r_MmaAE4x4WordAtPtx741R226, r_MmaAccumulatorHalf2WordAtPtx856R227,
		r_MmaAccumulatorHalf2WordAtPtx856R228;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx863R229, r_MmaAccumulatorHalf2WordAtPtx863R230,
		r_MmaAccumulatorHalf2WordAtPtx884R231, r_MmaAccumulatorHalf2WordAtPtx884R232,
		r_MmaAccumulatorHalf2WordAtPtx891R233, r_MmaAccumulatorHalf2WordAtPtx891R234,
		r_MmaAccumulatorHalf2WordAtPtx912R235, r_MmaAccumulatorHalf2WordAtPtx912R236,
		r_MmaAccumulatorHalf2WordAtPtx919R237, r_MmaAccumulatorHalf2WordAtPtx919R238,
		r_MmaAccumulatorHalf2WordAtPtx940R239, r_MmaAccumulatorHalf2WordAtPtx940R240;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx947R241, r_MmaAccumulatorHalf2WordAtPtx947R242, r_PtxRegister243,
		r_PtxRegister244, r_PtxRegister245, r_PtxRegister246, r_PtxRegister247, r_PtxRegister248,
		r_PtxRegister249, r_PtxRegister250, r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_LaneIndexAtPtx1014, r_LaneIndexAtPtx1023, r_MmaAccumulatorHalf2WordAtPtx758R261,
		r_MmaAccumulatorHalf2WordAtPtx765R262, r_MmaAccumulatorHalf2WordAtPtx758R263,
		r_MmaAccumulatorHalf2WordAtPtx765R264;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx786R265, r_MmaAccumulatorHalf2WordAtPtx793R266,
		r_MmaAccumulatorHalf2WordAtPtx786R267, r_MmaAccumulatorHalf2WordAtPtx793R268,
		r_MmaAccumulatorHalf2WordAtPtx870R269, r_MmaAccumulatorHalf2WordAtPtx877R270,
		r_MmaAccumulatorHalf2WordAtPtx870R271, r_MmaAccumulatorHalf2WordAtPtx877R272,
		r_MmaAccumulatorHalf2WordAtPtx898R273, r_MmaAccumulatorHalf2WordAtPtx905R274,
		r_MmaAccumulatorHalf2WordAtPtx898R275, r_MmaAccumulatorHalf2WordAtPtx905R276;
	uint32_t r_MmaBE4x4WordAtPtx1020R277, r_MmaBE4x4WordAtPtx1020R278, r_MmaAE4x4WordAtPtx1036R279,
		r_MmaAE4x4WordAtPtx1043R280, r_MmaAE4x4WordAtPtx1050R281, r_MmaAE4x4WordAtPtx1057R282,
		r_MmaBE4x4WordAtPtx1020R283, r_MmaBE4x4WordAtPtx1020R284, r_MmaBE4x4WordAtPtx1028R285,
		r_MmaBE4x4WordAtPtx1028R286, r_MmaBE4x4WordAtPtx1028R287, r_MmaBE4x4WordAtPtx1028R288;
	uint32_t r_MmaAE4x4WordAtPtx1064R289, r_MmaAE4x4WordAtPtx1071R290, r_MmaAE4x4WordAtPtx1078R291,
		r_MmaAE4x4WordAtPtx1085R292, r_LaneIndexAtPtx1143, r_LaneIndexAtPtx1152,
		r_MmaAccumulatorHalf2WordAtPtx814R295, r_MmaAccumulatorHalf2WordAtPtx821R296,
		r_MmaAccumulatorHalf2WordAtPtx814R297, r_MmaAccumulatorHalf2WordAtPtx821R298,
		r_MmaAccumulatorHalf2WordAtPtx842R299, r_MmaAccumulatorHalf2WordAtPtx849R300;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx842R301, r_MmaAccumulatorHalf2WordAtPtx849R302,
		r_MmaAccumulatorHalf2WordAtPtx926R303, r_MmaAccumulatorHalf2WordAtPtx933R304,
		r_MmaAccumulatorHalf2WordAtPtx926R305, r_MmaAccumulatorHalf2WordAtPtx933R306,
		r_MmaAccumulatorHalf2WordAtPtx954R307, r_MmaAccumulatorHalf2WordAtPtx961R308,
		r_MmaAccumulatorHalf2WordAtPtx954R309, r_MmaAccumulatorHalf2WordAtPtx961R310,
		r_MmaBE4x4WordAtPtx1149R311, r_MmaBE4x4WordAtPtx1149R312;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1087R313, r_MmaAccumulatorHalf2WordAtPtx1087R314,
		r_MmaAE4x4WordAtPtx1165R315, r_MmaAE4x4WordAtPtx1172R316, r_MmaAE4x4WordAtPtx1179R317,
		r_MmaAE4x4WordAtPtx1186R318, r_MmaBE4x4WordAtPtx1149R319, r_MmaBE4x4WordAtPtx1149R320,
		r_MmaAccumulatorHalf2WordAtPtx1094R321, r_MmaAccumulatorHalf2WordAtPtx1094R322,
		r_MmaBE4x4WordAtPtx1157R323, r_MmaBE4x4WordAtPtx1157R324;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1101R325, r_MmaAccumulatorHalf2WordAtPtx1101R326,
		r_MmaBE4x4WordAtPtx1157R327, r_MmaBE4x4WordAtPtx1157R328, r_MmaAccumulatorHalf2WordAtPtx1108R329,
		r_MmaAccumulatorHalf2WordAtPtx1108R330, r_MmaAccumulatorHalf2WordAtPtx1115R331,
		r_MmaAccumulatorHalf2WordAtPtx1115R332, r_MmaAE4x4WordAtPtx1193R333, r_MmaAE4x4WordAtPtx1200R334,
		r_MmaAE4x4WordAtPtx1207R335, r_MmaAE4x4WordAtPtx1214R336;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1122R337, r_MmaAccumulatorHalf2WordAtPtx1122R338,
		r_MmaAccumulatorHalf2WordAtPtx1129R339, r_MmaAccumulatorHalf2WordAtPtx1129R340,
		r_MmaAccumulatorHalf2WordAtPtx1136R341, r_MmaAccumulatorHalf2WordAtPtx1136R342, r_LaneIndexAtPtx1272,
		r_Float32BitsAtPtx1274R344, r_Float32BitsAtPtx1281R345, r_Float32BitsAtPtx1288R346,
		r_Float32BitsAtPtx1295R347, r_Float32BitsAtPtx1302R348;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1216R349, r_PackedHalf2AtPtx1283R350, r_PackedHalf2AtPtx1310R351,
		r_PackedHalf2AtPtx1276R352, r_PackedHalf2AtPtx1314R353, r_PackedHalf2AtPtx1304R354,
		r_PackedHalf2AtPtx1318R355, r_PackedHalf2AtPtx1297R356, r_PackedHalf2AtPtx1322R357,
		r_PackedHalf2AtPtx1290R358, r_PackedHalf2AtPtx1326R359, r_LaneIndexAtPtx1334;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1216R361, r_PackedHalf2AtPtx1337R362, r_PackedHalf2AtPtx1341R363,
		r_PackedHalf2AtPtx1345R364, r_PackedHalf2AtPtx1349R365, r_PackedHalf2AtPtx1353R366,
		r_LaneIndexAtPtx1361, r_MmaAccumulatorHalf2WordAtPtx1223R368, r_PackedHalf2AtPtx1364R369,
		r_PackedHalf2AtPtx1368R370, r_PackedHalf2AtPtx1372R371, r_PackedHalf2AtPtx1376R372;
	uint32_t r_PackedHalf2AtPtx1380R373, r_LaneIndexAtPtx1388, r_MmaAccumulatorHalf2WordAtPtx1223R375,
		r_PackedHalf2AtPtx1391R376, r_PackedHalf2AtPtx1395R377, r_PackedHalf2AtPtx1399R378,
		r_PackedHalf2AtPtx1403R379, r_PackedHalf2AtPtx1407R380, r_LaneIndexAtPtx1415,
		r_MmaAccumulatorHalf2WordAtPtx1230R382, r_PackedHalf2AtPtx1418R383, r_PackedHalf2AtPtx1422R384;
	uint32_t r_PackedHalf2AtPtx1426R385, r_PackedHalf2AtPtx1430R386, r_PackedHalf2AtPtx1434R387,
		r_LaneIndexAtPtx1442, r_MmaAccumulatorHalf2WordAtPtx1230R389, r_PackedHalf2AtPtx1445R390,
		r_PackedHalf2AtPtx1449R391, r_PackedHalf2AtPtx1453R392, r_PackedHalf2AtPtx1457R393,
		r_PackedHalf2AtPtx1461R394, r_LaneIndexAtPtx1469, r_MmaAccumulatorHalf2WordAtPtx1237R396;
	uint32_t r_PackedHalf2AtPtx1472R397, r_PackedHalf2AtPtx1476R398, r_PackedHalf2AtPtx1480R399,
		r_PackedHalf2AtPtx1484R400, r_PackedHalf2AtPtx1488R401, r_LaneIndexAtPtx1496,
		r_MmaAccumulatorHalf2WordAtPtx1237R403, r_PackedHalf2AtPtx1499R404, r_PackedHalf2AtPtx1503R405,
		r_PackedHalf2AtPtx1507R406, r_PackedHalf2AtPtx1511R407, r_PackedHalf2AtPtx1515R408;
	uint32_t r_LaneIndexAtPtx1523, r_MmaAccumulatorHalf2WordAtPtx1244R410, r_PackedHalf2AtPtx1526R411,
		r_PackedHalf2AtPtx1530R412, r_PackedHalf2AtPtx1534R413, r_PackedHalf2AtPtx1538R414,
		r_PackedHalf2AtPtx1542R415, r_LaneIndexAtPtx1550, r_MmaAccumulatorHalf2WordAtPtx1244R417,
		r_PackedHalf2AtPtx1553R418, r_PackedHalf2AtPtx1557R419, r_PackedHalf2AtPtx1561R420;
	uint32_t r_PackedHalf2AtPtx1565R421, r_PackedHalf2AtPtx1569R422, r_LaneIndexAtPtx1577,
		r_MmaAccumulatorHalf2WordAtPtx1251R424, r_PackedHalf2AtPtx1580R425, r_PackedHalf2AtPtx1584R426,
		r_PackedHalf2AtPtx1588R427, r_PackedHalf2AtPtx1592R428, r_PackedHalf2AtPtx1596R429,
		r_LaneIndexAtPtx1604, r_MmaAccumulatorHalf2WordAtPtx1251R431, r_PackedHalf2AtPtx1607R432;
	uint32_t r_PackedHalf2AtPtx1611R433, r_PackedHalf2AtPtx1615R434, r_PackedHalf2AtPtx1619R435,
		r_PackedHalf2AtPtx1623R436, r_LaneIndexAtPtx1631, r_MmaAccumulatorHalf2WordAtPtx1258R438,
		r_PackedHalf2AtPtx1634R439, r_PackedHalf2AtPtx1638R440, r_PackedHalf2AtPtx1642R441,
		r_PackedHalf2AtPtx1646R442, r_PackedHalf2AtPtx1650R443, r_LaneIndexAtPtx1658;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1258R445, r_PackedHalf2AtPtx1661R446, r_PackedHalf2AtPtx1665R447,
		r_PackedHalf2AtPtx1669R448, r_PackedHalf2AtPtx1673R449, r_PackedHalf2AtPtx1677R450,
		r_LaneIndexAtPtx1685, r_MmaAccumulatorHalf2WordAtPtx1265R452, r_PackedHalf2AtPtx1688R453,
		r_PackedHalf2AtPtx1692R454, r_PackedHalf2AtPtx1696R455, r_PackedHalf2AtPtx1700R456;
	uint32_t r_PackedHalf2AtPtx1704R457, r_LaneIndexAtPtx1712, r_MmaAccumulatorHalf2WordAtPtx1265R459,
		r_PackedHalf2AtPtx1715R460, r_PackedHalf2AtPtx1719R461, r_PackedHalf2AtPtx1723R462,
		r_PackedHalf2AtPtx1727R463, r_PackedHalf2AtPtx1731R464, r_LaneIndexAtPtx1739, r_LaneIndexAtPtx1748,
		r_LaneIndexAtPtx1757, r_LaneIndexAtPtx1766;
	uint32_t r_PackedHalf2AtPtx1330R469, r_PackedHalf2AtPtx1384R470, r_PackedHalf2AtPtx1357R471,
		r_PackedHalf2AtPtx1411R472, r_PackedHalf2AtPtx1438R473, r_PackedHalf2AtPtx1492R474,
		r_PackedHalf2AtPtx1465R475, r_PackedHalf2AtPtx1519R476, r_PackedHalf2AtPtx1546R477,
		r_PackedHalf2AtPtx1600R478, r_PackedHalf2AtPtx1573R479, r_PackedHalf2AtPtx1627R480;
	uint32_t r_PackedHalf2AtPtx1654R481, r_PackedHalf2AtPtx1708R482, r_PackedHalf2AtPtx1681R483,
		r_PackedHalf2AtPtx1735R484, r_MmaBE4x4WordAtPtx1745R485, r_MmaBE4x4WordAtPtx1745R486,
		r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1745R491, r_MmaBE4x4WordAtPtx1745R492;
	uint32_t r_MmaBE4x4WordAtPtx1754R493, r_MmaBE4x4WordAtPtx1754R494, r_MmaBE4x4WordAtPtx1754R495,
		r_MmaBE4x4WordAtPtx1754R496, r_MmaBE4x4WordAtPtx1763R497, r_MmaBE4x4WordAtPtx1763R498,
		r_MmaBE4x4WordAtPtx1763R499, r_MmaBE4x4WordAtPtx1763R500, r_MmaBE4x4WordAtPtx1771R501,
		r_MmaBE4x4WordAtPtx1771R502, r_MmaBE4x4WordAtPtx1771R503, r_MmaBE4x4WordAtPtx1771R504;
	uint32_t r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		r_MmaAE4x4WordAtPtx1828R508, r_PtxRegister509, r_PtxRegister510, r_PtxRegister511, r_PtxRegister512,
		r_LaneIndexAtPtx2063, r_PackedE4WordAtPtx2061R514, r_PackedE4WordAtPtx2060R515,
		r_PackedE4WordAtPtx2059R516;
	uint32_t r_PackedE4WordAtPtx2058R517, r_LaneIndexAtPtx2071, r_PackedE4WordAtPtx2057R519,
		r_PackedE4WordAtPtx2056R520, r_PackedE4WordAtPtx2055R521, r_PackedE4WordAtPtx2054R522,
		r_PtxRegister523, r_LaneIndexAtPtx2085, r_PackedE4WordAtPtx2093R525, r_PackedE4WordAtPtx2092R526,
		r_PackedE4WordAtPtx2091R527, r_PackedE4WordAtPtx2090R528;
	uint32_t r_LaneIndexAtPtx2098, r_PackedE4WordAtPtx2106R530, r_PackedE4WordAtPtx2105R531,
		r_PackedE4WordAtPtx2104R532, r_PackedE4WordAtPtx2103R533, r_PtxRegister534,
		r_MmaAccumulatorHalf2WordAtPtx239R535, r_MmaAccumulatorHalf2WordAtPtx240R536,
		r_MmaAccumulatorHalf2WordAtPtx241R537, r_MmaAccumulatorHalf2WordAtPtx242R538,
		r_MmaAccumulatorHalf2WordAtPtx243R539, r_MmaAccumulatorHalf2WordAtPtx244R540;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx245R541, r_MmaAccumulatorHalf2WordAtPtx246R542,
		r_MmaAccumulatorHalf2WordAtPtx247R543, r_MmaAccumulatorHalf2WordAtPtx248R544,
		r_MmaAccumulatorHalf2WordAtPtx249R545, r_MmaAccumulatorHalf2WordAtPtx250R546,
		r_MmaAccumulatorHalf2WordAtPtx251R547, r_MmaAccumulatorHalf2WordAtPtx252R548,
		r_MmaAccumulatorHalf2WordAtPtx253R549, r_MmaAccumulatorHalf2WordAtPtx254R550,
		r_MmaAccumulatorHalf2WordAtPtx255R551, r_MmaAccumulatorHalf2WordAtPtx256R552;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx257R553, r_MmaAccumulatorHalf2WordAtPtx258R554,
		r_MmaAccumulatorHalf2WordAtPtx259R555, r_MmaAccumulatorHalf2WordAtPtx260R556,
		r_MmaAccumulatorHalf2WordAtPtx261R557, r_MmaAccumulatorHalf2WordAtPtx262R558,
		r_MmaAccumulatorHalf2WordAtPtx263R559, r_MmaAccumulatorHalf2WordAtPtx264R560,
		r_MmaAccumulatorHalf2WordAtPtx265R561, r_MmaAccumulatorHalf2WordAtPtx266R562,
		r_MmaAccumulatorHalf2WordAtPtx267R563, r_MmaAccumulatorHalf2WordAtPtx268R564;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx269R565, r_MmaAccumulatorHalf2WordAtPtx270R566, r_PtxRegister567,
		r_MmaBE4x4WordAtPtx67R568, r_MmaBE4x4WordAtPtx67R569, r_MmaBE4x4WordAtPtx67R570,
		r_MmaBE4x4WordAtPtx67R571, r_MmaBE4x4WordAtPtx78R572, r_MmaBE4x4WordAtPtx78R573,
		r_MmaBE4x4WordAtPtx78R574, r_MmaBE4x4WordAtPtx78R575, r_MmaBE4x4WordAtPtx87R576;
	uint32_t r_MmaBE4x4WordAtPtx87R577, r_MmaBE4x4WordAtPtx87R578, r_MmaBE4x4WordAtPtx87R579,
		r_MmaBE4x4WordAtPtx96R580, r_MmaBE4x4WordAtPtx96R581, r_MmaBE4x4WordAtPtx96R582,
		r_MmaBE4x4WordAtPtx96R583, r_MmaBE4x4WordAtPtx105R584, r_MmaBE4x4WordAtPtx105R585,
		r_MmaBE4x4WordAtPtx105R586, r_MmaBE4x4WordAtPtx105R587, r_MmaBE4x4WordAtPtx114R588;
	uint32_t r_MmaBE4x4WordAtPtx114R589, r_MmaBE4x4WordAtPtx114R590, r_MmaBE4x4WordAtPtx114R591,
		r_MmaBE4x4WordAtPtx123R592, r_MmaBE4x4WordAtPtx123R593, r_MmaBE4x4WordAtPtx123R594,
		r_MmaBE4x4WordAtPtx123R595, r_MmaBE4x4WordAtPtx132R596, r_MmaBE4x4WordAtPtx132R597,
		r_MmaBE4x4WordAtPtx132R598, r_MmaBE4x4WordAtPtx132R599, r_MmaAccumulatorHalf2WordAtPtx980R600;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx981R601, r_MmaAccumulatorHalf2WordAtPtx982R602,
		r_MmaAccumulatorHalf2WordAtPtx983R603, r_MmaAccumulatorHalf2WordAtPtx984R604,
		r_MmaAccumulatorHalf2WordAtPtx985R605, r_MmaAccumulatorHalf2WordAtPtx986R606,
		r_MmaAccumulatorHalf2WordAtPtx987R607, r_MmaAccumulatorHalf2WordAtPtx988R608,
		r_MmaAccumulatorHalf2WordAtPtx989R609, r_MmaAccumulatorHalf2WordAtPtx990R610,
		r_MmaAccumulatorHalf2WordAtPtx991R611, r_MmaAccumulatorHalf2WordAtPtx992R612;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx993R613, r_MmaAccumulatorHalf2WordAtPtx994R614,
		r_MmaAccumulatorHalf2WordAtPtx995R615, r_MmaAccumulatorHalf2WordAtPtx996R616,
		r_MmaAccumulatorHalf2WordAtPtx997R617, r_MmaAccumulatorHalf2WordAtPtx998R618,
		r_MmaAccumulatorHalf2WordAtPtx999R619, r_MmaAccumulatorHalf2WordAtPtx1000R620,
		r_MmaAccumulatorHalf2WordAtPtx1001R621, r_MmaAccumulatorHalf2WordAtPtx1002R622,
		r_MmaAccumulatorHalf2WordAtPtx1003R623, r_MmaAccumulatorHalf2WordAtPtx1004R624;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1005R625, r_MmaAccumulatorHalf2WordAtPtx1006R626,
		r_MmaAccumulatorHalf2WordAtPtx1007R627, r_MmaAccumulatorHalf2WordAtPtx1008R628,
		r_MmaAccumulatorHalf2WordAtPtx1009R629, r_MmaAccumulatorHalf2WordAtPtx1010R630,
		r_MmaAccumulatorHalf2WordAtPtx1011R631, r_PtxRegister632;
	uint64_t g_StateBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress, r_PtxU64Register4,
		g_StateByteAddressAtPtx235, g_OutputByteAddressAtPtx2051, g_RecordByteAddressAtPtx65,
		g_RecordByteAddressAtPtx76, g_RecordByteAddressAtPtx85, g_RecordByteAddressAtPtx94,
		g_RecordByteAddressAtPtx103, g_RecordByteAddressAtPtx112;
	uint64_t g_RecordByteAddressAtPtx121, g_RecordByteAddressAtPtx130, r_PtxU64Register15,
		g_RecordByteAddressAtPtx60, r_PtxU64Register17, r_PtxU64Register18, g_RecordByteAddressAtPtx71,
		r_PtxU64Register20, g_RecordByteAddressAtPtx80, r_PtxU64Register22, g_RecordByteAddressAtPtx89,
		r_PtxU64Register24;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx102, r_PtxU64Register27, g_RecordByteAddressAtPtx111,
		r_PtxU64Register29, g_RecordByteAddressAtPtx120, r_PtxU64Register31, g_RecordByteAddressAtPtx129,
		r_PtxU64Register33, r_PtxU64Register34, g_StateByteAddressAtPtx186, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, g_RecordByteAddressAtPtx620,
		g_RecordByteAddressAtPtx629, g_RecordByteAddressAtPtx638, g_RecordByteAddressAtPtx647,
		g_RecordByteAddressAtPtx656, g_RecordByteAddressAtPtx665, g_RecordByteAddressAtPtx674,
		g_RecordByteAddressAtPtx683, r_PtxU64Register48;
	uint64_t g_RecordByteAddressAtPtx615, r_PtxU64Register50, r_PtxU64Register51, g_RecordByteAddressAtPtx628,
		r_PtxU64Register53, g_RecordByteAddressAtPtx637, r_PtxU64Register55, g_RecordByteAddressAtPtx646,
		r_PtxU64Register57, g_RecordByteAddressAtPtx655, r_PtxU64Register59, g_RecordByteAddressAtPtx664;
	uint64_t r_PtxU64Register61, g_RecordByteAddressAtPtx673, r_PtxU64Register63, g_RecordByteAddressAtPtx682,
		r_PtxU64Register65, r_PtxU64Register66, g_RecordByteAddressAtPtx973, r_PtxU64Register68,
		g_RecordByteAddressAtPtx976, r_PtxU64Register70, r_PtxU64Register71, r_PtxU64Register72;
	uint64_t r_PtxU64Register73, r_PtxU64Register74, r_PtxU64Register75, r_PtxU64Register76,
		r_PtxU64Register77, r_PtxU64Register78, r_PtxU64Register79, r_PtxU64Register80, r_PtxU64Register81,
		r_PtxU64Register82, r_PtxU64Register83, r_PtxU64Register84;
	uint64_t r_PtxU64Register85, r_PtxU64Register86, r_PtxU64Register87, r_PtxU64Register88,
		r_PtxU64Register89, r_PtxU64Register90, r_PtxU64Register91, g_OutputByteAddressAtPtx2066,
		g_OutputByteAddressAtPtx2075, r_PtxU64Register94, r_PtxU64Register95, g_OutputByteAddressAtPtx2074;
	uint64_t g_OutputByteAddressAtPtx2089, g_OutputByteAddressAtPtx2102, r_PtxU64Register99,
		g_OutputByteAddressAtPtx2088, r_PtxU64Register101, g_OutputByteAddressAtPtx2101, r_PtxU64Register103,
		r_PtxU64Register104, r_PtxU64Register105, r_PtxU64Register106;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L16
	r_HeightBits = uint32_t(r_Parameters.Height);
	r_WidthBits = uint32_t(r_Parameters.Width);										  // PTX L17
	r_CtaX = uint32_t(blockIdx.x);													  // PTX L18
	r_CtaZ = uint32_t(blockIdx.z);													  // PTX L19
	r_PtxRegister4 = ShiftLeft(uint32_t(r_CtaX), uint32_t(1));						  // PTX L20
	r_HeightSignBits = ShiftRightSigned(int32_t(r_HeightBits), uint32_t(31));		  // PTX L21
	r_HeightDiv4Bias = ShiftRight(uint32_t(r_HeightSignBits), uint32_t(30));		  // PTX L22
	r_HeightBiasedForDiv4 = uint32_t(r_HeightBits) + uint32_t(r_HeightDiv4Bias);	  // PTX L23
	r_HeightDiv4Bits = ShiftRightSigned(int32_t(r_HeightBiasedForDiv4), uint32_t(2)); // PTX L24
	r_WidthSignBits = ShiftRightSigned(int32_t(r_WidthBits), uint32_t(31));			  // PTX L25
	r_WidthDiv4Bias = ShiftRight(uint32_t(r_WidthSignBits), uint32_t(30));			  // PTX L26
	r_WidthBiasedForDiv4 = uint32_t(r_WidthBits) + uint32_t(r_WidthDiv4Bias);		  // PTX L27
	r_WidthDiv4Bits = ShiftRightSigned(int32_t(r_WidthBiasedForDiv4), uint32_t(2));	  // PTX L28
	r_ThreadX = uint32_t(threadIdx.x);												  // PTX L29
	r_ThreadY = uint32_t(threadIdx.y);												  // PTX L30
	r_PtxRegister34 = r_ThreadX | r_ThreadY;										  // PTX L31
	r_bPtxPredicate3 = uint32_t(r_PtxRegister34) != uint32_t(0);					  // PTX L32
	if (r_bPtxPredicate3)
	{
		goto L__BB1_2;
	} // PTX L33
	r_BlockSizeX = uint32_t(blockDim.x);							   // PTX L34
	r_BlockSizeY = uint32_t(blockDim.y);							   // PTX L35
	r_PtxRegister36 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY); // PTX L36
	r_PtxRegister35 = uint32_t(8192u /* two native mbarriers */);	   // PTX L37
	// Native barrier initialization; one CTA synchronization follows both barriers.
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister35, r_PtxRegister36); // PTX L39
	r_PtxRegister37 = uint32_t(r_PtxRegister35) + uint32_t(8);		// PTX L41
	// Native barrier initialization; one CTA synchronization follows both barriers.
	BarrierInit(s_SharedStorage, r_PtxRegister37, r_PtxRegister36); // PTX L43
L__BB1_2:															// PTX L45
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L46
	r_Float32BitsAtPtx47R40 = uint32_t(0);														// PTX L47
	r_PackedHalf2AtPtx49R8 = FloatToHalf2(r_Float32BitsAtPtx47R40);								// PTX L49
	r_PtxRegister49 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L54
	r_PtxRegister50 = r_PtxRegister49 & 192;													// PTX L55
	r_PtxRegister51 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(8));									// PTX L56
	r_PtxRegister9 = r_PtxRegister50 | r_PtxRegister51;											// PTX L57
	r_PtxRegister10 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(3));							// PTX L58
	r_PtxU64Register15 = uint64_t(uint32_t(r_PtxRegister10)) * uint64_t(uint32_t(4));			// PTX L59
	g_RecordByteAddressAtPtx60 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register15);	// PTX L60
	r_LaneIndexAtPtx62 = uint32_t((threadIdx.x & 31u));											// PTX L62
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx62)) * int64_t(int32_t(16))); // PTX L64
	g_RecordByteAddressAtPtx65 =
		uint64_t(g_RecordByteAddressAtPtx60) + uint64_t(r_PtxU64Register17); // PTX L65
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx65));
		r_MmaBE4x4WordAtPtx67R568 = r_Value.x;
		r_MmaBE4x4WordAtPtx67R569 = r_Value.y;
		r_MmaBE4x4WordAtPtx67R570 = r_Value.z;
		r_MmaBE4x4WordAtPtx67R571 = r_Value.w;
	} // PTX L67
	r_PtxRegister52 = r_PtxRegister10 | 128;													// PTX L69
	r_PtxU64Register18 = uint64_t(uint32_t(r_PtxRegister52)) * uint64_t(uint32_t(4));			// PTX L70
	g_RecordByteAddressAtPtx71 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register18);	// PTX L71
	r_LaneIndexAtPtx73 = uint32_t((threadIdx.x & 31u));											// PTX L73
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx73)) * int64_t(int32_t(16))); // PTX L75
	g_RecordByteAddressAtPtx76 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register20); // PTX L76
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx76));
		r_MmaBE4x4WordAtPtx78R572 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R573 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R574 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R575 = r_Value.w;
	} // PTX L78
	g_RecordByteAddressAtPtx80 = uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(512);			// PTX L80
	r_LaneIndexAtPtx82 = uint32_t((threadIdx.x & 31u));											// PTX L82
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx82)) * int64_t(int32_t(16))); // PTX L84
	g_RecordByteAddressAtPtx85 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register22); // PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx85));
		r_MmaBE4x4WordAtPtx87R576 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R577 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R578 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R579 = r_Value.w;
	} // PTX L87
	g_RecordByteAddressAtPtx89 = uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(1024);			// PTX L89
	r_LaneIndexAtPtx91 = uint32_t((threadIdx.x & 31u));											// PTX L91
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx91)) * int64_t(int32_t(16))); // PTX L93
	g_RecordByteAddressAtPtx94 =
		uint64_t(g_RecordByteAddressAtPtx89) + uint64_t(r_PtxU64Register24); // PTX L94
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx94));
		r_MmaBE4x4WordAtPtx96R580 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R581 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R582 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R583 = r_Value.w;
	} // PTX L96
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	g_RecordByteAddressAtPtx102 =
		uint64_t(g_RecordByteAddressAtPtx60) + uint64_t(r_PtxU64Register25);			   // PTX L102
	g_RecordByteAddressAtPtx103 = uint64_t(g_RecordByteAddressAtPtx102) + uint64_t(16384); // PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx103));
		r_MmaBE4x4WordAtPtx105R584 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R585 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R586 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R587 = r_Value.w;
	} // PTX L105
	r_LaneIndexAtPtx108 = uint32_t((threadIdx.x & 31u));										 // PTX L108
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx108)) * int64_t(int32_t(16))); // PTX L110
	g_RecordByteAddressAtPtx111 =
		uint64_t(g_RecordByteAddressAtPtx71) + uint64_t(r_PtxU64Register27);			   // PTX L111
	g_RecordByteAddressAtPtx112 = uint64_t(g_RecordByteAddressAtPtx111) + uint64_t(16384); // PTX L112
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx112));
		r_MmaBE4x4WordAtPtx114R588 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R589 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R590 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R591 = r_Value.w;
	} // PTX L114
	r_LaneIndexAtPtx117 = uint32_t((threadIdx.x & 31u));										 // PTX L117
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx117)) * int64_t(int32_t(16))); // PTX L119
	g_RecordByteAddressAtPtx120 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register29);			   // PTX L120
	g_RecordByteAddressAtPtx121 = uint64_t(g_RecordByteAddressAtPtx120) + uint64_t(16384); // PTX L121
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx121));
		r_MmaBE4x4WordAtPtx123R592 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R593 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R594 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R595 = r_Value.w;
	} // PTX L123
	r_LaneIndexAtPtx126 = uint32_t((threadIdx.x & 31u));										 // PTX L126
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx126)) * int64_t(int32_t(16))); // PTX L128
	g_RecordByteAddressAtPtx129 =
		uint64_t(g_RecordByteAddressAtPtx89) + uint64_t(r_PtxU64Register31);			   // PTX L129
	g_RecordByteAddressAtPtx130 = uint64_t(g_RecordByteAddressAtPtx129) + uint64_t(16384); // PTX L130
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx130));
		r_MmaBE4x4WordAtPtx132R596 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R597 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R598 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R599 = r_Value.w;
	} // PTX L132
	r_PtxRegister11 = r_ThreadY & 1;										  // PTX L134
	r_PtxRegister53 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			  // PTX L135
	r_PtxRegister54 = r_PtxRegister53 & 1;									  // PTX L136
	r_PtxRegister12 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));			  // PTX L137
	r_PtxRegister13 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(9));	  // PTX L138
	r_PtxRegister55 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L139
	r_PtxRegister56 = r_PtxRegister55 & 256;								  // PTX L140
	r_PtxRegister14 = r_PtxRegister13 | r_PtxRegister56;					  // PTX L141
	r_CtaY = uint32_t(blockIdx.y);											  // PTX L142
	r_PtxRegister58 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));				  // PTX L143
	r_PtxRegister59 = uint32_t(r_PtxRegister12) + uint32_t(r_PtxRegister58);  // PTX L144
	r_PtxRegister15 = uint32_t(r_PtxRegister54) + uint32_t(r_PtxRegister4);	  // PTX L145
	r_PtxRegister16 = r_HeightBits & -4;									  // PTX L146
	r_bPtxPredicate4 = uint32_t(r_PtxRegister16) != uint32_t(4);			  // PTX L147
	r_bPtxPredicate5 = uint32_t(r_PtxRegister16) == uint32_t(4);			  // PTX L148
	r_bPtxPredicate6 = int32_t(r_PtxRegister59) >= int32_t(r_HeightDiv4Bits); // PTX L149
	r_PtxRegister17 = uint32_t(r_PtxRegister59) * uint32_t(r_WidthDiv4Bits);  // PTX L150
	r_PtxRegister18 = r_bPtxPredicate5 ? 0 : r_PtxRegister17;				  // PTX L151
	r_bPtxPredicate32 = bool(0);											  // PTX L152
	r_bPtxPredicate7 = r_bPtxPredicate4 & r_bPtxPredicate6;					  // PTX L153
	r_PtxRegister534 = uint32_t(r_PtxRegister15);							  // PTX L154
	if (r_bPtxPredicate7)
	{
		goto L__BB1_5;
	} // PTX L155
	r_PtxRegister60 = r_WidthBits & -4;							 // PTX L156
	r_bPtxPredicate8 = uint32_t(r_PtxRegister60) == uint32_t(4); // PTX L157
	r_bPtxPredicate32 = bool(-1);								 // PTX L158
	r_PtxRegister534 = uint32_t(0);								 // PTX L159
	if (r_bPtxPredicate8)
	{
		goto L__BB1_5;
	} // PTX L160
	r_bPtxPredicate32 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits);  // PTX L161
	r_PtxRegister534 = uint32_t(r_PtxRegister15);							  // PTX L162
L__BB1_5:																	  // PTX L163
	r_PtxRegister61 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(7));	  // PTX L164
	r_PtxRegister62 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister534); // PTX L165
	r_PtxRegister63 = ShiftLeft(uint32_t(r_PtxRegister62), uint32_t(11));	  // PTX L166
	r_PtxRegister64 = r_PtxRegister63 | r_PtxRegister61;					  // PTX L167
	r_PtxU64Register33 = SignExtendWordBits(r_PtxRegister64);				  // PTX L168
	r_PtxU64Register4 = r_bPtxPredicate32 ? r_PtxU64Register33 : 0;			  // PTX L169
	r_PtxRegister65 = uint32_t(r_PtxRegister14) + uint32_t(r_PtxRegister61);  // PTX L170
	r_PtxRegister66 = ShiftLeft(uint32_t(r_PtxRegister65), uint32_t(2));	  // PTX L171
	r_PtxRegister67 = uint32_t(0u /* native shared-input region */);		  // PTX L172
	r_PtxRegister76 = uint32_t(r_PtxRegister67) + uint32_t(r_PtxRegister66);  // PTX L173
	r_bPtxPredicate9 = !r_bPtxPredicate32;									  // PTX L174
	if (r_bPtxPredicate9)
	{
		goto L__BB1_8;
	} // PTX L175
	r_PtxRegister75 = uint32_t(-1);								  // PTX L176
	r_PtxRegister74 = Elected(r_PtxRegister75);					  // PTX L178
	r_bPtxPredicate10 = uint32_t(r_PtxRegister74) == uint32_t(0); // PTX L184
	if (r_bPtxPredicate10)
	{
		goto L__BB1_9;
	} // PTX L185
	g_StateByteAddressAtPtx186 = g_StateBaseAddress;										  // PTX L186
	r_PtxU64Register36 = ShiftLeft(uint64_t(r_PtxU64Register4), uint32_t(2));				  // PTX L187
	r_PtxU64Register34 = uint64_t(g_StateByteAddressAtPtx186) + uint64_t(r_PtxU64Register36); // PTX L188
	r_PtxRegister78 = uint32_t(8192u /* two native mbarriers */);							  // PTX L189
	r_PtxRegister77 = uint32_t(512);														  // PTX L190
	// Native elected-lane bulk transfer; original expect/arrive/wait order retained.
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister76, r_PtxU64Register34, r_PtxRegister77,
			 r_PtxRegister78);																 // PTX L192
	BarrierExpect(s_SharedStorage, r_PtxRegister78, r_PtxRegister77);						 // PTX L195
	goto L__BB1_9;																			 // PTX L197
L__BB1_8:																					 // PTX L198
	r_PtxRegister68 = uint32_t(0);															 // PTX L199
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister68))); // PTX L201
	r_PackedHalf2AtPtx204R69 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L204
	r_ConvertedE4PairAtPtx206Rs2 = PublishE4(r_PackedHalf2AtPtx204R69);						 // PTX L206
	r_PackedE4WordAtPtx208R72 =
		JoinHalfwords(r_ConvertedE4PairAtPtx206Rs2, r_ConvertedE4PairAtPtx206Rs2); // PTX L208
	r_LaneIndexAtPtx210 = uint32_t((threadIdx.x & 31u));						   // PTX L210
	r_PtxRegister73 = ShiftLeft(uint32_t(r_LaneIndexAtPtx210), uint32_t(4));	   // PTX L212
	r_PtxRegister71 = uint32_t(r_PtxRegister76) + uint32_t(r_PtxRegister73);	   // PTX L213
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister71)) =
		make_uint4(r_PackedE4WordAtPtx208R72, r_PackedE4WordAtPtx208R72, r_PackedE4WordAtPtx208R72,
				   r_PackedE4WordAtPtx208R72);					  // PTX L215
L__BB1_9:														  // PTX L217
	r_PtxRegister79 = uint32_t(8192u /* two native mbarriers */); // PTX L218
	r_PtxRegister80 = uint32_t(1);								  // PTX L219
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register37 = BarrierArrive(s_SharedStorage, r_PtxRegister79, r_PtxRegister80); // PTX L221
L__BB1_10:																				   // PTX L223
	r_PtxRegister82 = uint32_t(8192u /* two native mbarriers */);						   // PTX L224
	r_PtxRegister81 = BarrierReady(s_SharedStorage, r_PtxRegister82, r_PtxU64Register37);  // PTX L226
	r_bPtxPredicate11 = uint32_t(r_PtxRegister81) == uint32_t(0);						   // PTX L232
	if (r_bPtxPredicate11)
	{
		goto L__BB1_10;
	} // PTX L233
	r_PtxRegister19 = r_WidthBits & -4;										   // PTX L234
	g_StateByteAddressAtPtx235 = g_StateBaseAddress;						   // PTX L235
	r_bPtxPredicate1 = int32_t(r_PtxRegister59) < int32_t(r_HeightDiv4Bits);   // PTX L236
	r_PtxRegister20 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(11));	   // PTX L237
	r_PtxRegister567 = uint32_t(0);											   // PTX L238
	r_MmaAccumulatorHalf2WordAtPtx239R535 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L239
	r_MmaAccumulatorHalf2WordAtPtx240R536 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L240
	r_MmaAccumulatorHalf2WordAtPtx241R537 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L241
	r_MmaAccumulatorHalf2WordAtPtx242R538 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L242
	r_MmaAccumulatorHalf2WordAtPtx243R539 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L243
	r_MmaAccumulatorHalf2WordAtPtx244R540 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L244
	r_MmaAccumulatorHalf2WordAtPtx245R541 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L245
	r_MmaAccumulatorHalf2WordAtPtx246R542 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L246
	r_MmaAccumulatorHalf2WordAtPtx247R543 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L247
	r_MmaAccumulatorHalf2WordAtPtx248R544 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L248
	r_MmaAccumulatorHalf2WordAtPtx249R545 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L249
	r_MmaAccumulatorHalf2WordAtPtx250R546 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L250
	r_MmaAccumulatorHalf2WordAtPtx251R547 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L251
	r_MmaAccumulatorHalf2WordAtPtx252R548 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L252
	r_MmaAccumulatorHalf2WordAtPtx253R549 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L253
	r_MmaAccumulatorHalf2WordAtPtx254R550 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L254
	r_MmaAccumulatorHalf2WordAtPtx255R551 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L255
	r_MmaAccumulatorHalf2WordAtPtx256R552 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L256
	r_MmaAccumulatorHalf2WordAtPtx257R553 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L257
	r_MmaAccumulatorHalf2WordAtPtx258R554 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L258
	r_MmaAccumulatorHalf2WordAtPtx259R555 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L259
	r_MmaAccumulatorHalf2WordAtPtx260R556 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L260
	r_MmaAccumulatorHalf2WordAtPtx261R557 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L261
	r_MmaAccumulatorHalf2WordAtPtx262R558 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L262
	r_MmaAccumulatorHalf2WordAtPtx263R559 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L263
	r_MmaAccumulatorHalf2WordAtPtx264R560 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L264
	r_MmaAccumulatorHalf2WordAtPtx265R561 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L265
	r_MmaAccumulatorHalf2WordAtPtx266R562 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L266
	r_MmaAccumulatorHalf2WordAtPtx267R563 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L267
	r_MmaAccumulatorHalf2WordAtPtx268R564 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L268
	r_MmaAccumulatorHalf2WordAtPtx269R565 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L269
	r_MmaAccumulatorHalf2WordAtPtx270R566 = uint32_t(r_PackedHalf2AtPtx49R8);  // PTX L270
L__BB1_12:																	   // PTX L271
	r_bPtxPredicate12 = int32_t(r_PtxRegister15) < int32_t(r_WidthDiv4Bits);   // PTX L272
	r_bPtxPredicate13 = int32_t(r_PtxRegister59) >= int32_t(r_HeightDiv4Bits); // PTX L273
	r_bPtxPredicate14 = uint32_t(r_PtxRegister19) == uint32_t(4);			   // PTX L274
	r_bPtxPredicate15 = uint32_t(r_PtxRegister16) == uint32_t(4);			   // PTX L275
	r_bPtxPredicate16 = uint32_t(r_PtxRegister16) != uint32_t(4);			   // PTX L276
	r_PtxRegister83 = ShiftRight(uint32_t(r_PtxRegister567), uint32_t(6));	   // PTX L277
	r_PtxRegister84 = r_PtxRegister83 & 1;									   // PTX L278
	r_PtxRegister21 = uint32_t(r_PtxRegister567) + uint32_t(64);			   // PTX L279
	r_PtxRegister85 = ShiftLeft(uint32_t(r_PtxRegister567), uint32_t(6));	   // PTX L280
	r_PtxRegister22 = r_PtxRegister85 & 4096;								   // PTX L281
	r_PtxRegister23 = r_PtxRegister22 ^ 4096;								   // PTX L282
	r_bPtxPredicate17 = uint32_t(r_PtxRegister84) == uint32_t(0);			   // PTX L283
	r_PtxRegister86 = uint32_t(8192u /* two native mbarriers */);			   // PTX L284
	r_PtxRegister87 = uint32_t(r_PtxRegister86) + uint32_t(8);				   // PTX L285
	r_PtxRegister106 = r_bPtxPredicate17 ? r_PtxRegister87 : r_PtxRegister86;  // PTX L286
	r_bPtxPredicate18 = r_bPtxPredicate16 & r_bPtxPredicate13;				   // PTX L287
	r_bPtxPredicate19 = r_bPtxPredicate15 | r_bPtxPredicate1;				   // PTX L288
	r_bPtxPredicate20 = r_bPtxPredicate18 | r_bPtxPredicate14;				   // PTX L289
	r_PtxRegister88 = r_bPtxPredicate18 ? r_PtxRegister15 : 0;				   // PTX L290
	r_PtxRegister24 = r_bPtxPredicate14 ? r_PtxRegister88 : r_PtxRegister15;   // PTX L291
	r_bPtxPredicate21 = r_bPtxPredicate20 | r_bPtxPredicate12;				   // PTX L292
	r_bPtxPredicate2 = r_bPtxPredicate21 & r_bPtxPredicate19;				   // PTX L293
	r_PtxU64Register103 = uint64_t(0);										   // PTX L294
	r_bPtxPredicate22 = !r_bPtxPredicate2;									   // PTX L295
	if (r_bPtxPredicate22)
	{
		goto L__BB1_14;
	} // PTX L296
	r_PtxRegister89 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister24); // PTX L297
	r_PtxRegister90 = ShiftRight(uint32_t(r_PtxRegister21), uint32_t(5));	 // PTX L298
	r_PtxRegister91 = uint32_t(r_PtxRegister90) + uint32_t(r_PtxRegister11); // PTX L299
	r_PtxRegister92 = ShiftLeft(uint32_t(r_PtxRegister89), uint32_t(11));	 // PTX L300
	r_PtxRegister93 = ShiftLeft(uint32_t(r_PtxRegister91), uint32_t(7));	 // PTX L301
	r_PtxRegister94 = uint32_t(r_PtxRegister92) + uint32_t(r_PtxRegister93); // PTX L302
	r_PtxU64Register103 = SignExtendWordBits(r_PtxRegister94);				 // PTX L303
L__BB1_14:																	 // PTX L304
	if (r_bPtxPredicate22)
	{
		goto L__BB1_17;
	} // PTX L305
	r_PtxRegister103 = uint32_t(-1);							   // PTX L306
	r_PtxRegister102 = Elected(r_PtxRegister103);				   // PTX L308
	r_bPtxPredicate23 = uint32_t(r_PtxRegister102) == uint32_t(0); // PTX L314
	if (r_bPtxPredicate23)
	{
		goto L__BB1_18;
	} // PTX L315
	r_PtxRegister104 = uint32_t(r_PtxRegister76) + uint32_t(r_PtxRegister23);				  // PTX L316
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register103), uint32_t(2));				  // PTX L317
	r_PtxU64Register38 = uint64_t(g_StateByteAddressAtPtx235) + uint64_t(r_PtxU64Register39); // PTX L318
	r_PtxRegister105 = uint32_t(512);														  // PTX L319
	// Native elected-lane bulk transfer; original expect/arrive/wait order retained.
	CopyBulk(s_SharedStorage, r_PtxRegister104, r_PtxU64Register38, r_PtxRegister105,
			 r_PtxRegister106);																 // PTX L321
	BarrierExpect(s_SharedStorage, r_PtxRegister106, r_PtxRegister105);						 // PTX L324
	goto L__BB1_18;																			 // PTX L326
L__BB1_17:																					 // PTX L327
	r_PtxRegister95 = uint32_t(0);															 // PTX L328
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister95))); // PTX L330
	r_PackedHalf2AtPtx333R96 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);			 // PTX L333
	r_ConvertedE4PairAtPtx335Rs4 = PublishE4(r_PackedHalf2AtPtx333R96);						 // PTX L335
	r_PackedE4WordAtPtx337R99 =
		JoinHalfwords(r_ConvertedE4PairAtPtx335Rs4, r_ConvertedE4PairAtPtx335Rs4); // PTX L337
	r_LaneIndexAtPtx339 = uint32_t((threadIdx.x & 31u));						   // PTX L339
	r_PtxRegister100 = uint32_t(r_PtxRegister76) + uint32_t(r_PtxRegister23);	   // PTX L341
	r_PtxRegister101 = ShiftLeft(uint32_t(r_LaneIndexAtPtx339), uint32_t(4));	   // PTX L342
	r_PtxRegister98 = uint32_t(r_PtxRegister100) + uint32_t(r_PtxRegister101);	   // PTX L343
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister98)) =
		make_uint4(r_PackedE4WordAtPtx337R99, r_PackedE4WordAtPtx337R99, r_PackedE4WordAtPtx337R99,
				   r_PackedE4WordAtPtx337R99);									// PTX L345
L__BB1_18:																		// PTX L347
	r_PtxRegister172 = uint32_t(0u /* native shared-input region */);			// PTX L348
	r_PtxRegister173 = uint32_t(r_PtxRegister172) + uint32_t(r_PtxRegister22);	// PTX L349
	r_LaneIndexAtPtx351 = uint32_t((threadIdx.x & 31u));						// PTX L351
	r_PtxRegister174 = uint32_t(r_PtxRegister173) + uint32_t(r_PtxRegister20);	// PTX L353
	r_PtxRegister175 = ShiftLeft(uint32_t(r_LaneIndexAtPtx351), uint32_t(4));	// PTX L354
	r_PtxRegister108 = uint32_t(r_PtxRegister174) + uint32_t(r_PtxRegister175); // PTX L355
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister108));
		r_MmaAE4x4WordAtPtx357R115 = r_Value.x;
		r_MmaAE4x4WordAtPtx357R116 = r_Value.y;
		r_MmaAE4x4WordAtPtx357R117 = r_Value.z;
		r_MmaAE4x4WordAtPtx357R118 = r_Value.w;
	} // PTX L357
	r_LaneIndexAtPtx360 = uint32_t((threadIdx.x & 31u));						// PTX L360
	r_PtxRegister176 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(2));		// PTX L362
	r_PtxRegister177 = uint32_t(r_PtxRegister173) + uint32_t(r_PtxRegister176); // PTX L363
	r_PtxRegister178 = ShiftLeft(uint32_t(r_LaneIndexAtPtx360), uint32_t(4));	// PTX L364
	r_PtxRegister179 = uint32_t(r_PtxRegister177) + uint32_t(r_PtxRegister178); // PTX L365
	r_PtxRegister110 = uint32_t(r_PtxRegister179) + uint32_t(512);				// PTX L366
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister110));
		r_MmaAE4x4WordAtPtx368R119 = r_Value.x;
		r_MmaAE4x4WordAtPtx368R120 = r_Value.y;
		r_MmaAE4x4WordAtPtx368R121 = r_Value.z;
		r_MmaAE4x4WordAtPtx368R122 = r_Value.w;
	} // PTX L368
	r_LaneIndexAtPtx371 = uint32_t((threadIdx.x & 31u));						// PTX L371
	r_PtxRegister180 = ShiftLeft(uint32_t(r_LaneIndexAtPtx371), uint32_t(4));	// PTX L373
	r_PtxRegister181 = uint32_t(r_PtxRegister177) + uint32_t(r_PtxRegister180); // PTX L374
	r_PtxRegister112 = uint32_t(r_PtxRegister181) + uint32_t(1024);				// PTX L375
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister112));
		r_MmaAE4x4WordAtPtx377R139 = r_Value.x;
		r_MmaAE4x4WordAtPtx377R140 = r_Value.y;
		r_MmaAE4x4WordAtPtx377R141 = r_Value.z;
		r_MmaAE4x4WordAtPtx377R142 = r_Value.w;
	} // PTX L377
	r_LaneIndexAtPtx380 = uint32_t((threadIdx.x & 31u));						// PTX L380
	r_PtxRegister182 = ShiftLeft(uint32_t(r_LaneIndexAtPtx380), uint32_t(4));	// PTX L382
	r_PtxRegister183 = uint32_t(r_PtxRegister177) + uint32_t(r_PtxRegister182); // PTX L383
	r_PtxRegister114 = uint32_t(r_PtxRegister183) + uint32_t(1536);				// PTX L384
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister114));
		r_MmaAE4x4WordAtPtx386R143 = r_Value.x;
		r_MmaAE4x4WordAtPtx386R144 = r_Value.y;
		r_MmaAE4x4WordAtPtx386R145 = r_Value.z;
		r_MmaAE4x4WordAtPtx386R146 = r_Value.w;
	} // PTX L386
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx389R123, r_MmaAccumulatorHalf2WordAtPtx389R124,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx67R568, r_MmaBE4x4WordAtPtx67R569,
		  r_MmaAccumulatorHalf2WordAtPtx270R566,
		  r_MmaAccumulatorHalf2WordAtPtx269R565); // PTX L389
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx396R125, r_MmaAccumulatorHalf2WordAtPtx396R126,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx67R570, r_MmaBE4x4WordAtPtx67R571,
		  r_MmaAccumulatorHalf2WordAtPtx268R564,
		  r_MmaAccumulatorHalf2WordAtPtx267R563); // PTX L396
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx270R566, r_MmaAccumulatorHalf2WordAtPtx269R565,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx105R584, r_MmaBE4x4WordAtPtx105R585,
		  r_MmaAccumulatorHalf2WordAtPtx389R123,
		  r_MmaAccumulatorHalf2WordAtPtx389R124); // PTX L403
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx268R564, r_MmaAccumulatorHalf2WordAtPtx267R563,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx105R586, r_MmaBE4x4WordAtPtx105R587,
		  r_MmaAccumulatorHalf2WordAtPtx396R125,
		  r_MmaAccumulatorHalf2WordAtPtx396R126); // PTX L410
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx417R127, r_MmaAccumulatorHalf2WordAtPtx417R128,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx78R572, r_MmaBE4x4WordAtPtx78R573,
		  r_MmaAccumulatorHalf2WordAtPtx266R562,
		  r_MmaAccumulatorHalf2WordAtPtx265R561); // PTX L417
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx424R129, r_MmaAccumulatorHalf2WordAtPtx424R130,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx78R574, r_MmaBE4x4WordAtPtx78R575,
		  r_MmaAccumulatorHalf2WordAtPtx264R560,
		  r_MmaAccumulatorHalf2WordAtPtx263R559); // PTX L424
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx266R562, r_MmaAccumulatorHalf2WordAtPtx265R561,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx114R588, r_MmaBE4x4WordAtPtx114R589,
		  r_MmaAccumulatorHalf2WordAtPtx417R127,
		  r_MmaAccumulatorHalf2WordAtPtx417R128); // PTX L431
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx264R560, r_MmaAccumulatorHalf2WordAtPtx263R559,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx114R590, r_MmaBE4x4WordAtPtx114R591,
		  r_MmaAccumulatorHalf2WordAtPtx424R129,
		  r_MmaAccumulatorHalf2WordAtPtx424R130); // PTX L438
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx445R131, r_MmaAccumulatorHalf2WordAtPtx445R132,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx87R576, r_MmaBE4x4WordAtPtx87R577,
		  r_MmaAccumulatorHalf2WordAtPtx262R558,
		  r_MmaAccumulatorHalf2WordAtPtx261R557); // PTX L445
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx452R133, r_MmaAccumulatorHalf2WordAtPtx452R134,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx87R578, r_MmaBE4x4WordAtPtx87R579,
		  r_MmaAccumulatorHalf2WordAtPtx260R556,
		  r_MmaAccumulatorHalf2WordAtPtx259R555); // PTX L452
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx262R558, r_MmaAccumulatorHalf2WordAtPtx261R557,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx123R592, r_MmaBE4x4WordAtPtx123R593,
		  r_MmaAccumulatorHalf2WordAtPtx445R131,
		  r_MmaAccumulatorHalf2WordAtPtx445R132); // PTX L459
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx260R556, r_MmaAccumulatorHalf2WordAtPtx259R555,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx123R594, r_MmaBE4x4WordAtPtx123R595,
		  r_MmaAccumulatorHalf2WordAtPtx452R133,
		  r_MmaAccumulatorHalf2WordAtPtx452R134); // PTX L466
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx473R135, r_MmaAccumulatorHalf2WordAtPtx473R136,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx96R580, r_MmaBE4x4WordAtPtx96R581,
		  r_MmaAccumulatorHalf2WordAtPtx258R554,
		  r_MmaAccumulatorHalf2WordAtPtx257R553); // PTX L473
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx480R137, r_MmaAccumulatorHalf2WordAtPtx480R138,
		  r_MmaAE4x4WordAtPtx357R115, r_MmaAE4x4WordAtPtx357R116, r_MmaAE4x4WordAtPtx357R117,
		  r_MmaAE4x4WordAtPtx357R118, r_MmaBE4x4WordAtPtx96R582, r_MmaBE4x4WordAtPtx96R583,
		  r_MmaAccumulatorHalf2WordAtPtx256R552,
		  r_MmaAccumulatorHalf2WordAtPtx255R551); // PTX L480
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx258R554, r_MmaAccumulatorHalf2WordAtPtx257R553,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx132R596, r_MmaBE4x4WordAtPtx132R597,
		  r_MmaAccumulatorHalf2WordAtPtx473R135,
		  r_MmaAccumulatorHalf2WordAtPtx473R136); // PTX L487
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx256R552, r_MmaAccumulatorHalf2WordAtPtx255R551,
		  r_MmaAE4x4WordAtPtx368R119, r_MmaAE4x4WordAtPtx368R120, r_MmaAE4x4WordAtPtx368R121,
		  r_MmaAE4x4WordAtPtx368R122, r_MmaBE4x4WordAtPtx132R598, r_MmaBE4x4WordAtPtx132R599,
		  r_MmaAccumulatorHalf2WordAtPtx480R137,
		  r_MmaAccumulatorHalf2WordAtPtx480R138); // PTX L494
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx501R147, r_MmaAccumulatorHalf2WordAtPtx501R148,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx67R568, r_MmaBE4x4WordAtPtx67R569,
		  r_MmaAccumulatorHalf2WordAtPtx254R550,
		  r_MmaAccumulatorHalf2WordAtPtx253R549); // PTX L501
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx508R149, r_MmaAccumulatorHalf2WordAtPtx508R150,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx67R570, r_MmaBE4x4WordAtPtx67R571,
		  r_MmaAccumulatorHalf2WordAtPtx252R548,
		  r_MmaAccumulatorHalf2WordAtPtx251R547); // PTX L508
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx254R550, r_MmaAccumulatorHalf2WordAtPtx253R549,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx105R584, r_MmaBE4x4WordAtPtx105R585,
		  r_MmaAccumulatorHalf2WordAtPtx501R147,
		  r_MmaAccumulatorHalf2WordAtPtx501R148); // PTX L515
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx252R548, r_MmaAccumulatorHalf2WordAtPtx251R547,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx105R586, r_MmaBE4x4WordAtPtx105R587,
		  r_MmaAccumulatorHalf2WordAtPtx508R149,
		  r_MmaAccumulatorHalf2WordAtPtx508R150); // PTX L522
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx529R151, r_MmaAccumulatorHalf2WordAtPtx529R152,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx78R572, r_MmaBE4x4WordAtPtx78R573,
		  r_MmaAccumulatorHalf2WordAtPtx250R546,
		  r_MmaAccumulatorHalf2WordAtPtx249R545); // PTX L529
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx536R153, r_MmaAccumulatorHalf2WordAtPtx536R154,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx78R574, r_MmaBE4x4WordAtPtx78R575,
		  r_MmaAccumulatorHalf2WordAtPtx248R544,
		  r_MmaAccumulatorHalf2WordAtPtx247R543); // PTX L536
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx250R546, r_MmaAccumulatorHalf2WordAtPtx249R545,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx114R588, r_MmaBE4x4WordAtPtx114R589,
		  r_MmaAccumulatorHalf2WordAtPtx529R151,
		  r_MmaAccumulatorHalf2WordAtPtx529R152); // PTX L543
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx248R544, r_MmaAccumulatorHalf2WordAtPtx247R543,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx114R590, r_MmaBE4x4WordAtPtx114R591,
		  r_MmaAccumulatorHalf2WordAtPtx536R153,
		  r_MmaAccumulatorHalf2WordAtPtx536R154); // PTX L550
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx557R155, r_MmaAccumulatorHalf2WordAtPtx557R156,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx87R576, r_MmaBE4x4WordAtPtx87R577,
		  r_MmaAccumulatorHalf2WordAtPtx246R542,
		  r_MmaAccumulatorHalf2WordAtPtx245R541); // PTX L557
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx564R157, r_MmaAccumulatorHalf2WordAtPtx564R158,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx87R578, r_MmaBE4x4WordAtPtx87R579,
		  r_MmaAccumulatorHalf2WordAtPtx244R540,
		  r_MmaAccumulatorHalf2WordAtPtx243R539); // PTX L564
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx246R542, r_MmaAccumulatorHalf2WordAtPtx245R541,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx123R592, r_MmaBE4x4WordAtPtx123R593,
		  r_MmaAccumulatorHalf2WordAtPtx557R155,
		  r_MmaAccumulatorHalf2WordAtPtx557R156); // PTX L571
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx244R540, r_MmaAccumulatorHalf2WordAtPtx243R539,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx123R594, r_MmaBE4x4WordAtPtx123R595,
		  r_MmaAccumulatorHalf2WordAtPtx564R157,
		  r_MmaAccumulatorHalf2WordAtPtx564R158); // PTX L578
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx585R159, r_MmaAccumulatorHalf2WordAtPtx585R160,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx96R580, r_MmaBE4x4WordAtPtx96R581,
		  r_MmaAccumulatorHalf2WordAtPtx242R538,
		  r_MmaAccumulatorHalf2WordAtPtx241R537); // PTX L585
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx592R161, r_MmaAccumulatorHalf2WordAtPtx592R162,
		  r_MmaAE4x4WordAtPtx377R139, r_MmaAE4x4WordAtPtx377R140, r_MmaAE4x4WordAtPtx377R141,
		  r_MmaAE4x4WordAtPtx377R142, r_MmaBE4x4WordAtPtx96R582, r_MmaBE4x4WordAtPtx96R583,
		  r_MmaAccumulatorHalf2WordAtPtx240R536,
		  r_MmaAccumulatorHalf2WordAtPtx239R535); // PTX L592
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx242R538, r_MmaAccumulatorHalf2WordAtPtx241R537,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx132R596, r_MmaBE4x4WordAtPtx132R597,
		  r_MmaAccumulatorHalf2WordAtPtx585R159,
		  r_MmaAccumulatorHalf2WordAtPtx585R160); // PTX L599
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx240R536, r_MmaAccumulatorHalf2WordAtPtx239R535,
		  r_MmaAE4x4WordAtPtx386R143, r_MmaAE4x4WordAtPtx386R144, r_MmaAE4x4WordAtPtx386R145,
		  r_MmaAE4x4WordAtPtx386R146, r_MmaBE4x4WordAtPtx132R598, r_MmaBE4x4WordAtPtx132R599,
		  r_MmaAccumulatorHalf2WordAtPtx592R161,
		  r_MmaAccumulatorHalf2WordAtPtx592R162);												 // PTX L606
	r_PtxRegister184 = ShiftLeft(uint32_t(r_PtxRegister21), uint32_t(7));						 // PTX L612
	r_PtxRegister185 = uint32_t(r_PtxRegister184) + uint32_t(r_PtxRegister10);					 // PTX L613
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister185)) * int64_t(int32_t(4)));	 // PTX L614
	g_RecordByteAddressAtPtx615 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register48);	 // PTX L615
	r_LaneIndexAtPtx617 = uint32_t((threadIdx.x & 31u));										 // PTX L617
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx617)) * int64_t(int32_t(16))); // PTX L619
	g_RecordByteAddressAtPtx620 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register50); // PTX L620
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx620));
		r_MmaBE4x4WordAtPtx67R568 = r_Value.x;
		r_MmaBE4x4WordAtPtx67R569 = r_Value.y;
		r_MmaBE4x4WordAtPtx67R570 = r_Value.z;
		r_MmaBE4x4WordAtPtx67R571 = r_Value.w;
	} // PTX L622
	r_LaneIndexAtPtx625 = uint32_t((threadIdx.x & 31u));										 // PTX L625
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx625)) * int64_t(int32_t(16))); // PTX L627
	g_RecordByteAddressAtPtx628 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register51);			 // PTX L628
	g_RecordByteAddressAtPtx629 = uint64_t(g_RecordByteAddressAtPtx628) + uint64_t(512); // PTX L629
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx629));
		r_MmaBE4x4WordAtPtx78R572 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R573 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R574 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R575 = r_Value.w;
	} // PTX L631
	r_LaneIndexAtPtx634 = uint32_t((threadIdx.x & 31u));										 // PTX L634
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx634)) * int64_t(int32_t(16))); // PTX L636
	g_RecordByteAddressAtPtx637 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register53);			  // PTX L637
	g_RecordByteAddressAtPtx638 = uint64_t(g_RecordByteAddressAtPtx637) + uint64_t(1024); // PTX L638
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx638));
		r_MmaBE4x4WordAtPtx87R576 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R577 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R578 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R579 = r_Value.w;
	} // PTX L640
	r_LaneIndexAtPtx643 = uint32_t((threadIdx.x & 31u));										 // PTX L643
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx643)) * int64_t(int32_t(16))); // PTX L645
	g_RecordByteAddressAtPtx646 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register55);			  // PTX L646
	g_RecordByteAddressAtPtx647 = uint64_t(g_RecordByteAddressAtPtx646) + uint64_t(1536); // PTX L647
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx647));
		r_MmaBE4x4WordAtPtx96R580 = r_Value.x;
		r_MmaBE4x4WordAtPtx96R581 = r_Value.y;
		r_MmaBE4x4WordAtPtx96R582 = r_Value.z;
		r_MmaBE4x4WordAtPtx96R583 = r_Value.w;
	} // PTX L649
	r_LaneIndexAtPtx652 = uint32_t((threadIdx.x & 31u));										 // PTX L652
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx652)) * int64_t(int32_t(16))); // PTX L654
	g_RecordByteAddressAtPtx655 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register57);			   // PTX L655
	g_RecordByteAddressAtPtx656 = uint64_t(g_RecordByteAddressAtPtx655) + uint64_t(16384); // PTX L656
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx656));
		r_MmaBE4x4WordAtPtx105R584 = r_Value.x;
		r_MmaBE4x4WordAtPtx105R585 = r_Value.y;
		r_MmaBE4x4WordAtPtx105R586 = r_Value.z;
		r_MmaBE4x4WordAtPtx105R587 = r_Value.w;
	} // PTX L658
	r_LaneIndexAtPtx661 = uint32_t((threadIdx.x & 31u));										 // PTX L661
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx661)) * int64_t(int32_t(16))); // PTX L663
	g_RecordByteAddressAtPtx664 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register59);			   // PTX L664
	g_RecordByteAddressAtPtx665 = uint64_t(g_RecordByteAddressAtPtx664) + uint64_t(16896); // PTX L665
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx665));
		r_MmaBE4x4WordAtPtx114R588 = r_Value.x;
		r_MmaBE4x4WordAtPtx114R589 = r_Value.y;
		r_MmaBE4x4WordAtPtx114R590 = r_Value.z;
		r_MmaBE4x4WordAtPtx114R591 = r_Value.w;
	} // PTX L667
	r_LaneIndexAtPtx670 = uint32_t((threadIdx.x & 31u));										 // PTX L670
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx670)) * int64_t(int32_t(16))); // PTX L672
	g_RecordByteAddressAtPtx673 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register61);			   // PTX L673
	g_RecordByteAddressAtPtx674 = uint64_t(g_RecordByteAddressAtPtx673) + uint64_t(17408); // PTX L674
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx674));
		r_MmaBE4x4WordAtPtx123R592 = r_Value.x;
		r_MmaBE4x4WordAtPtx123R593 = r_Value.y;
		r_MmaBE4x4WordAtPtx123R594 = r_Value.z;
		r_MmaBE4x4WordAtPtx123R595 = r_Value.w;
	} // PTX L676
	r_LaneIndexAtPtx679 = uint32_t((threadIdx.x & 31u));										 // PTX L679
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx679)) * int64_t(int32_t(16))); // PTX L681
	g_RecordByteAddressAtPtx682 =
		uint64_t(g_RecordByteAddressAtPtx615) + uint64_t(r_PtxU64Register63);			   // PTX L682
	g_RecordByteAddressAtPtx683 = uint64_t(g_RecordByteAddressAtPtx682) + uint64_t(17920); // PTX L683
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx683));
		r_MmaBE4x4WordAtPtx132R596 = r_Value.x;
		r_MmaBE4x4WordAtPtx132R597 = r_Value.y;
		r_MmaBE4x4WordAtPtx132R598 = r_Value.z;
		r_MmaBE4x4WordAtPtx132R599 = r_Value.w;
	} // PTX L685
	r_PtxRegister171 = uint32_t(1);															 // PTX L687
	r_PtxU64Register65 = BarrierArrive(s_SharedStorage, r_PtxRegister106, r_PtxRegister171); // PTX L689
L__BB1_19:																					 // PTX L691
	r_PtxRegister186 = BarrierReady(s_SharedStorage, r_PtxRegister106, r_PtxU64Register65);	 // PTX L693
	r_bPtxPredicate24 = uint32_t(r_PtxRegister186) == uint32_t(0);							 // PTX L699
	if (r_bPtxPredicate24)
	{
		goto L__BB1_19;
	} // PTX L700
	r_bPtxPredicate25 = uint32_t(r_PtxRegister567) < uint32_t(384); // PTX L701
	r_PtxRegister567 = uint32_t(r_PtxRegister21);					// PTX L702
	if (r_bPtxPredicate25)
	{
		goto L__BB1_12;
	} // PTX L703
	r_LaneIndexAtPtx705 = uint32_t((threadIdx.x & 31u));						// PTX L705
	r_PtxRegister243 = uint32_t(0u /* native shared-input region */);			// PTX L707
	r_PtxRegister244 = uint32_t(r_PtxRegister243) + uint32_t(r_PtxRegister20);	// PTX L708
	r_PtxRegister245 = ShiftLeft(uint32_t(r_LaneIndexAtPtx705), uint32_t(4));	// PTX L709
	r_PtxRegister246 = uint32_t(r_PtxRegister244) + uint32_t(r_PtxRegister245); // PTX L710
	r_PtxRegister188 = uint32_t(r_PtxRegister246) + uint32_t(4096);				// PTX L711
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister188));
		r_MmaAE4x4WordAtPtx713R195 = r_Value.x;
		r_MmaAE4x4WordAtPtx713R196 = r_Value.y;
		r_MmaAE4x4WordAtPtx713R197 = r_Value.z;
		r_MmaAE4x4WordAtPtx713R198 = r_Value.w;
	} // PTX L713
	r_LaneIndexAtPtx716 = uint32_t((threadIdx.x & 31u));						// PTX L716
	r_PtxRegister247 = uint32_t(r_PtxRegister243) + uint32_t(r_PtxRegister176); // PTX L718
	r_PtxRegister248 = ShiftLeft(uint32_t(r_LaneIndexAtPtx716), uint32_t(4));	// PTX L719
	r_PtxRegister249 = uint32_t(r_PtxRegister247) + uint32_t(r_PtxRegister248); // PTX L720
	r_PtxRegister190 = uint32_t(r_PtxRegister249) + uint32_t(4608);				// PTX L721
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister190));
		r_MmaAE4x4WordAtPtx723R199 = r_Value.x;
		r_MmaAE4x4WordAtPtx723R200 = r_Value.y;
		r_MmaAE4x4WordAtPtx723R201 = r_Value.z;
		r_MmaAE4x4WordAtPtx723R202 = r_Value.w;
	} // PTX L723
	r_LaneIndexAtPtx726 = uint32_t((threadIdx.x & 31u));						// PTX L726
	r_PtxRegister250 = ShiftLeft(uint32_t(r_LaneIndexAtPtx726), uint32_t(4));	// PTX L728
	r_PtxRegister251 = uint32_t(r_PtxRegister247) + uint32_t(r_PtxRegister250); // PTX L729
	r_PtxRegister192 = uint32_t(r_PtxRegister251) + uint32_t(5120);				// PTX L730
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister192));
		r_MmaAE4x4WordAtPtx732R219 = r_Value.x;
		r_MmaAE4x4WordAtPtx732R220 = r_Value.y;
		r_MmaAE4x4WordAtPtx732R221 = r_Value.z;
		r_MmaAE4x4WordAtPtx732R222 = r_Value.w;
	} // PTX L732
	r_LaneIndexAtPtx735 = uint32_t((threadIdx.x & 31u));						// PTX L735
	r_PtxRegister252 = ShiftLeft(uint32_t(r_LaneIndexAtPtx735), uint32_t(4));	// PTX L737
	r_PtxRegister253 = uint32_t(r_PtxRegister247) + uint32_t(r_PtxRegister252); // PTX L738
	r_PtxRegister194 = uint32_t(r_PtxRegister253) + uint32_t(5632);				// PTX L739
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister194));
		r_MmaAE4x4WordAtPtx741R223 = r_Value.x;
		r_MmaAE4x4WordAtPtx741R224 = r_Value.y;
		r_MmaAE4x4WordAtPtx741R225 = r_Value.z;
		r_MmaAE4x4WordAtPtx741R226 = r_Value.w;
	} // PTX L741
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx744R203, r_MmaAccumulatorHalf2WordAtPtx744R204,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx67R568, r_MmaBE4x4WordAtPtx67R569,
		  r_MmaAccumulatorHalf2WordAtPtx270R566,
		  r_MmaAccumulatorHalf2WordAtPtx269R565); // PTX L744
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx751R205, r_MmaAccumulatorHalf2WordAtPtx751R206,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx67R570, r_MmaBE4x4WordAtPtx67R571,
		  r_MmaAccumulatorHalf2WordAtPtx268R564,
		  r_MmaAccumulatorHalf2WordAtPtx267R563); // PTX L751
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx758R261, r_MmaAccumulatorHalf2WordAtPtx758R263,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx105R584, r_MmaBE4x4WordAtPtx105R585,
		  r_MmaAccumulatorHalf2WordAtPtx744R203,
		  r_MmaAccumulatorHalf2WordAtPtx744R204); // PTX L758
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx765R262, r_MmaAccumulatorHalf2WordAtPtx765R264,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx105R586, r_MmaBE4x4WordAtPtx105R587,
		  r_MmaAccumulatorHalf2WordAtPtx751R205,
		  r_MmaAccumulatorHalf2WordAtPtx751R206); // PTX L765
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx772R207, r_MmaAccumulatorHalf2WordAtPtx772R208,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx78R572, r_MmaBE4x4WordAtPtx78R573,
		  r_MmaAccumulatorHalf2WordAtPtx266R562,
		  r_MmaAccumulatorHalf2WordAtPtx265R561); // PTX L772
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx779R209, r_MmaAccumulatorHalf2WordAtPtx779R210,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx78R574, r_MmaBE4x4WordAtPtx78R575,
		  r_MmaAccumulatorHalf2WordAtPtx264R560,
		  r_MmaAccumulatorHalf2WordAtPtx263R559); // PTX L779
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx786R265, r_MmaAccumulatorHalf2WordAtPtx786R267,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx114R588, r_MmaBE4x4WordAtPtx114R589,
		  r_MmaAccumulatorHalf2WordAtPtx772R207,
		  r_MmaAccumulatorHalf2WordAtPtx772R208); // PTX L786
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx793R266, r_MmaAccumulatorHalf2WordAtPtx793R268,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx114R590, r_MmaBE4x4WordAtPtx114R591,
		  r_MmaAccumulatorHalf2WordAtPtx779R209,
		  r_MmaAccumulatorHalf2WordAtPtx779R210); // PTX L793
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx800R211, r_MmaAccumulatorHalf2WordAtPtx800R212,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx87R576, r_MmaBE4x4WordAtPtx87R577,
		  r_MmaAccumulatorHalf2WordAtPtx262R558,
		  r_MmaAccumulatorHalf2WordAtPtx261R557); // PTX L800
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx807R213, r_MmaAccumulatorHalf2WordAtPtx807R214,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx87R578, r_MmaBE4x4WordAtPtx87R579,
		  r_MmaAccumulatorHalf2WordAtPtx260R556,
		  r_MmaAccumulatorHalf2WordAtPtx259R555); // PTX L807
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx814R295, r_MmaAccumulatorHalf2WordAtPtx814R297,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx123R592, r_MmaBE4x4WordAtPtx123R593,
		  r_MmaAccumulatorHalf2WordAtPtx800R211,
		  r_MmaAccumulatorHalf2WordAtPtx800R212); // PTX L814
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx821R296, r_MmaAccumulatorHalf2WordAtPtx821R298,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx123R594, r_MmaBE4x4WordAtPtx123R595,
		  r_MmaAccumulatorHalf2WordAtPtx807R213,
		  r_MmaAccumulatorHalf2WordAtPtx807R214); // PTX L821
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx828R215, r_MmaAccumulatorHalf2WordAtPtx828R216,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx96R580, r_MmaBE4x4WordAtPtx96R581,
		  r_MmaAccumulatorHalf2WordAtPtx258R554,
		  r_MmaAccumulatorHalf2WordAtPtx257R553); // PTX L828
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx835R217, r_MmaAccumulatorHalf2WordAtPtx835R218,
		  r_MmaAE4x4WordAtPtx713R195, r_MmaAE4x4WordAtPtx713R196, r_MmaAE4x4WordAtPtx713R197,
		  r_MmaAE4x4WordAtPtx713R198, r_MmaBE4x4WordAtPtx96R582, r_MmaBE4x4WordAtPtx96R583,
		  r_MmaAccumulatorHalf2WordAtPtx256R552,
		  r_MmaAccumulatorHalf2WordAtPtx255R551); // PTX L835
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx842R299, r_MmaAccumulatorHalf2WordAtPtx842R301,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx132R596, r_MmaBE4x4WordAtPtx132R597,
		  r_MmaAccumulatorHalf2WordAtPtx828R215,
		  r_MmaAccumulatorHalf2WordAtPtx828R216); // PTX L842
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx849R300, r_MmaAccumulatorHalf2WordAtPtx849R302,
		  r_MmaAE4x4WordAtPtx723R199, r_MmaAE4x4WordAtPtx723R200, r_MmaAE4x4WordAtPtx723R201,
		  r_MmaAE4x4WordAtPtx723R202, r_MmaBE4x4WordAtPtx132R598, r_MmaBE4x4WordAtPtx132R599,
		  r_MmaAccumulatorHalf2WordAtPtx835R217,
		  r_MmaAccumulatorHalf2WordAtPtx835R218); // PTX L849
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx856R227, r_MmaAccumulatorHalf2WordAtPtx856R228,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx67R568, r_MmaBE4x4WordAtPtx67R569,
		  r_MmaAccumulatorHalf2WordAtPtx254R550,
		  r_MmaAccumulatorHalf2WordAtPtx253R549); // PTX L856
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx863R229, r_MmaAccumulatorHalf2WordAtPtx863R230,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx67R570, r_MmaBE4x4WordAtPtx67R571,
		  r_MmaAccumulatorHalf2WordAtPtx252R548,
		  r_MmaAccumulatorHalf2WordAtPtx251R547); // PTX L863
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx870R269, r_MmaAccumulatorHalf2WordAtPtx870R271,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx105R584, r_MmaBE4x4WordAtPtx105R585,
		  r_MmaAccumulatorHalf2WordAtPtx856R227,
		  r_MmaAccumulatorHalf2WordAtPtx856R228); // PTX L870
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx877R270, r_MmaAccumulatorHalf2WordAtPtx877R272,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx105R586, r_MmaBE4x4WordAtPtx105R587,
		  r_MmaAccumulatorHalf2WordAtPtx863R229,
		  r_MmaAccumulatorHalf2WordAtPtx863R230); // PTX L877
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx884R231, r_MmaAccumulatorHalf2WordAtPtx884R232,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx78R572, r_MmaBE4x4WordAtPtx78R573,
		  r_MmaAccumulatorHalf2WordAtPtx250R546,
		  r_MmaAccumulatorHalf2WordAtPtx249R545); // PTX L884
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx891R233, r_MmaAccumulatorHalf2WordAtPtx891R234,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx78R574, r_MmaBE4x4WordAtPtx78R575,
		  r_MmaAccumulatorHalf2WordAtPtx248R544,
		  r_MmaAccumulatorHalf2WordAtPtx247R543); // PTX L891
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx898R273, r_MmaAccumulatorHalf2WordAtPtx898R275,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx114R588, r_MmaBE4x4WordAtPtx114R589,
		  r_MmaAccumulatorHalf2WordAtPtx884R231,
		  r_MmaAccumulatorHalf2WordAtPtx884R232); // PTX L898
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx905R274, r_MmaAccumulatorHalf2WordAtPtx905R276,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx114R590, r_MmaBE4x4WordAtPtx114R591,
		  r_MmaAccumulatorHalf2WordAtPtx891R233,
		  r_MmaAccumulatorHalf2WordAtPtx891R234); // PTX L905
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx912R235, r_MmaAccumulatorHalf2WordAtPtx912R236,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx87R576, r_MmaBE4x4WordAtPtx87R577,
		  r_MmaAccumulatorHalf2WordAtPtx246R542,
		  r_MmaAccumulatorHalf2WordAtPtx245R541); // PTX L912
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx919R237, r_MmaAccumulatorHalf2WordAtPtx919R238,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx87R578, r_MmaBE4x4WordAtPtx87R579,
		  r_MmaAccumulatorHalf2WordAtPtx244R540,
		  r_MmaAccumulatorHalf2WordAtPtx243R539); // PTX L919
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx926R303, r_MmaAccumulatorHalf2WordAtPtx926R305,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx123R592, r_MmaBE4x4WordAtPtx123R593,
		  r_MmaAccumulatorHalf2WordAtPtx912R235,
		  r_MmaAccumulatorHalf2WordAtPtx912R236); // PTX L926
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx933R304, r_MmaAccumulatorHalf2WordAtPtx933R306,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx123R594, r_MmaBE4x4WordAtPtx123R595,
		  r_MmaAccumulatorHalf2WordAtPtx919R237,
		  r_MmaAccumulatorHalf2WordAtPtx919R238); // PTX L933
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx940R239, r_MmaAccumulatorHalf2WordAtPtx940R240,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx96R580, r_MmaBE4x4WordAtPtx96R581,
		  r_MmaAccumulatorHalf2WordAtPtx242R538,
		  r_MmaAccumulatorHalf2WordAtPtx241R537); // PTX L940
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx947R241, r_MmaAccumulatorHalf2WordAtPtx947R242,
		  r_MmaAE4x4WordAtPtx732R219, r_MmaAE4x4WordAtPtx732R220, r_MmaAE4x4WordAtPtx732R221,
		  r_MmaAE4x4WordAtPtx732R222, r_MmaBE4x4WordAtPtx96R582, r_MmaBE4x4WordAtPtx96R583,
		  r_MmaAccumulatorHalf2WordAtPtx240R536,
		  r_MmaAccumulatorHalf2WordAtPtx239R535); // PTX L947
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx954R307, r_MmaAccumulatorHalf2WordAtPtx954R309,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx132R596, r_MmaBE4x4WordAtPtx132R597,
		  r_MmaAccumulatorHalf2WordAtPtx940R239,
		  r_MmaAccumulatorHalf2WordAtPtx940R240); // PTX L954
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx961R308, r_MmaAccumulatorHalf2WordAtPtx961R310,
		  r_MmaAE4x4WordAtPtx741R223, r_MmaAE4x4WordAtPtx741R224, r_MmaAE4x4WordAtPtx741R225,
		  r_MmaAE4x4WordAtPtx741R226, r_MmaBE4x4WordAtPtx132R598, r_MmaBE4x4WordAtPtx132R599,
		  r_MmaAccumulatorHalf2WordAtPtx947R241,
		  r_MmaAccumulatorHalf2WordAtPtx947R242);												  // PTX L961
	r_PtxRegister254 = r_ThreadY & 3;															  // PTX L967
	r_PtxRegister255 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(2));								  // PTX L968
	r_PtxRegister256 = r_PtxRegister254 | r_PtxRegister255;										  // PTX L969
	r_PtxRegister257 = ShiftLeft(uint32_t(r_PtxRegister256), uint32_t(12));						  // PTX L970
	r_PtxRegister258 = ShiftLeft(uint32_t(r_PtxRegister256), uint32_t(5));						  // PTX L971
	r_PtxU64Register66 = uint64_t(uint32_t(r_PtxRegister258)) * uint64_t(uint32_t(512));		  // PTX L972
	g_RecordByteAddressAtPtx973 = uint64_t(r_PtxU64Register66) + uint64_t(g_RecordBaseAddress);	  // PTX L973
	r_PtxU64Register106 = uint64_t(g_RecordByteAddressAtPtx973) + uint64_t(270848);				  // PTX L974
	r_PtxU64Register68 = uint64_t(uint32_t(r_PtxRegister257)) * uint64_t(uint32_t(4));			  // PTX L975
	g_RecordByteAddressAtPtx976 = uint64_t(r_PtxU64Register68) + uint64_t(g_RecordBaseAddress);	  // PTX L976
	r_PtxU64Register105 = uint64_t(g_RecordByteAddressAtPtx976) + uint64_t(394752);				  // PTX L977
	r_PtxU64Register104 = uint64_t(g_RecordByteAddressAtPtx976) + uint64_t(262656);				  // PTX L978
	r_PtxRegister632 = uint32_t(0);																  // PTX L979
	r_MmaAccumulatorHalf2WordAtPtx980R600 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L980
	r_MmaAccumulatorHalf2WordAtPtx981R601 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L981
	r_MmaAccumulatorHalf2WordAtPtx982R602 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L982
	r_MmaAccumulatorHalf2WordAtPtx983R603 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L983
	r_MmaAccumulatorHalf2WordAtPtx984R604 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L984
	r_MmaAccumulatorHalf2WordAtPtx985R605 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L985
	r_MmaAccumulatorHalf2WordAtPtx986R606 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L986
	r_MmaAccumulatorHalf2WordAtPtx987R607 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L987
	r_MmaAccumulatorHalf2WordAtPtx988R608 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L988
	r_MmaAccumulatorHalf2WordAtPtx989R609 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L989
	r_MmaAccumulatorHalf2WordAtPtx990R610 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L990
	r_MmaAccumulatorHalf2WordAtPtx991R611 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L991
	r_MmaAccumulatorHalf2WordAtPtx992R612 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L992
	r_MmaAccumulatorHalf2WordAtPtx993R613 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L993
	r_MmaAccumulatorHalf2WordAtPtx994R614 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L994
	r_MmaAccumulatorHalf2WordAtPtx995R615 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L995
	r_MmaAccumulatorHalf2WordAtPtx996R616 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L996
	r_MmaAccumulatorHalf2WordAtPtx997R617 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L997
	r_MmaAccumulatorHalf2WordAtPtx998R618 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L998
	r_MmaAccumulatorHalf2WordAtPtx999R619 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L999
	r_MmaAccumulatorHalf2WordAtPtx1000R620 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1000
	r_MmaAccumulatorHalf2WordAtPtx1001R621 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1001
	r_MmaAccumulatorHalf2WordAtPtx1002R622 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1002
	r_MmaAccumulatorHalf2WordAtPtx1003R623 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1003
	r_MmaAccumulatorHalf2WordAtPtx1004R624 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1004
	r_MmaAccumulatorHalf2WordAtPtx1005R625 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1005
	r_MmaAccumulatorHalf2WordAtPtx1006R626 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1006
	r_MmaAccumulatorHalf2WordAtPtx1007R627 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1007
	r_MmaAccumulatorHalf2WordAtPtx1008R628 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1008
	r_MmaAccumulatorHalf2WordAtPtx1009R629 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1009
	r_MmaAccumulatorHalf2WordAtPtx1010R630 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1010
	r_MmaAccumulatorHalf2WordAtPtx1011R631 = uint32_t(r_PackedHalf2AtPtx49R8);					  // PTX L1011
L__BB1_22:																						  // PTX L1012
	r_LaneIndexAtPtx1014 = uint32_t((threadIdx.x & 31u));										  // PTX L1014
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1014)) * int64_t(int32_t(16))); // PTX L1016
	r_PtxU64Register79 = uint64_t(r_PtxU64Register104) + uint64_t(r_PtxU64Register78);			  // PTX L1017
	r_PtxU64Register70 = uint64_t(r_PtxU64Register79) + uint64_t(-512);							  // PTX L1018
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register70));
		r_MmaBE4x4WordAtPtx1020R277 = r_Value.x;
		r_MmaBE4x4WordAtPtx1020R278 = r_Value.y;
		r_MmaBE4x4WordAtPtx1020R283 = r_Value.z;
		r_MmaBE4x4WordAtPtx1020R284 = r_Value.w;
	} // PTX L1020
	r_LaneIndexAtPtx1023 = uint32_t((threadIdx.x & 31u));										  // PTX L1023
	r_PtxU64Register80 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1023)) * int64_t(int32_t(16))); // PTX L1025
	r_PtxU64Register71 = uint64_t(r_PtxU64Register104) + uint64_t(r_PtxU64Register80);			  // PTX L1026
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register71));
		r_MmaBE4x4WordAtPtx1028R285 = r_Value.x;
		r_MmaBE4x4WordAtPtx1028R286 = r_Value.y;
		r_MmaBE4x4WordAtPtx1028R287 = r_Value.z;
		r_MmaBE4x4WordAtPtx1028R288 = r_Value.w;
	} // PTX L1028
	r_ConvertedE4PairAtPtx1031Rs5 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx758R261); // PTX L1031
	r_ConvertedE4PairAtPtx1034Rs6 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx765R262); // PTX L1034
	r_MmaAE4x4WordAtPtx1036R279 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1031Rs5, r_ConvertedE4PairAtPtx1034Rs6);  // PTX L1036
	r_ConvertedE4PairAtPtx1038Rs7 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx758R263); // PTX L1038
	r_ConvertedE4PairAtPtx1041Rs8 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx765R264); // PTX L1041
	r_MmaAE4x4WordAtPtx1043R280 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1038Rs7, r_ConvertedE4PairAtPtx1041Rs8);   // PTX L1043
	r_ConvertedE4PairAtPtx1045Rs9 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx786R265);  // PTX L1045
	r_ConvertedE4PairAtPtx1048Rs10 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx793R266); // PTX L1048
	r_MmaAE4x4WordAtPtx1050R281 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1045Rs9, r_ConvertedE4PairAtPtx1048Rs10);  // PTX L1050
	r_ConvertedE4PairAtPtx1052Rs11 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx786R267); // PTX L1052
	r_ConvertedE4PairAtPtx1055Rs12 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx793R268); // PTX L1055
	r_MmaAE4x4WordAtPtx1057R282 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1052Rs11, r_ConvertedE4PairAtPtx1055Rs12); // PTX L1057
	r_ConvertedE4PairAtPtx1059Rs13 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx870R269); // PTX L1059
	r_ConvertedE4PairAtPtx1062Rs14 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx877R270); // PTX L1062
	r_MmaAE4x4WordAtPtx1064R289 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1059Rs13, r_ConvertedE4PairAtPtx1062Rs14); // PTX L1064
	r_ConvertedE4PairAtPtx1066Rs15 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx870R271); // PTX L1066
	r_ConvertedE4PairAtPtx1069Rs16 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx877R272); // PTX L1069
	r_MmaAE4x4WordAtPtx1071R290 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1066Rs15, r_ConvertedE4PairAtPtx1069Rs16); // PTX L1071
	r_ConvertedE4PairAtPtx1073Rs17 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx898R273); // PTX L1073
	r_ConvertedE4PairAtPtx1076Rs18 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx905R274); // PTX L1076
	r_MmaAE4x4WordAtPtx1078R291 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1073Rs17, r_ConvertedE4PairAtPtx1076Rs18); // PTX L1078
	r_ConvertedE4PairAtPtx1080Rs19 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx898R275); // PTX L1080
	r_ConvertedE4PairAtPtx1083Rs20 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx905R276); // PTX L1083
	r_MmaAE4x4WordAtPtx1085R292 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1080Rs19, r_ConvertedE4PairAtPtx1083Rs20); // PTX L1085
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1087R313, r_MmaAccumulatorHalf2WordAtPtx1087R314,
		  r_MmaAE4x4WordAtPtx1036R279, r_MmaAE4x4WordAtPtx1043R280, r_MmaAE4x4WordAtPtx1050R281,
		  r_MmaAE4x4WordAtPtx1057R282, r_MmaBE4x4WordAtPtx1020R277, r_MmaBE4x4WordAtPtx1020R278,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1087
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1094R321, r_MmaAccumulatorHalf2WordAtPtx1094R322,
		  r_MmaAE4x4WordAtPtx1036R279, r_MmaAE4x4WordAtPtx1043R280, r_MmaAE4x4WordAtPtx1050R281,
		  r_MmaAE4x4WordAtPtx1057R282, r_MmaBE4x4WordAtPtx1020R283, r_MmaBE4x4WordAtPtx1020R284,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1094
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1101R325, r_MmaAccumulatorHalf2WordAtPtx1101R326,
		  r_MmaAE4x4WordAtPtx1036R279, r_MmaAE4x4WordAtPtx1043R280, r_MmaAE4x4WordAtPtx1050R281,
		  r_MmaAE4x4WordAtPtx1057R282, r_MmaBE4x4WordAtPtx1028R285, r_MmaBE4x4WordAtPtx1028R286,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1101
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1108R329, r_MmaAccumulatorHalf2WordAtPtx1108R330,
		  r_MmaAE4x4WordAtPtx1036R279, r_MmaAE4x4WordAtPtx1043R280, r_MmaAE4x4WordAtPtx1050R281,
		  r_MmaAE4x4WordAtPtx1057R282, r_MmaBE4x4WordAtPtx1028R287, r_MmaBE4x4WordAtPtx1028R288,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1108
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1115R331, r_MmaAccumulatorHalf2WordAtPtx1115R332,
		  r_MmaAE4x4WordAtPtx1064R289, r_MmaAE4x4WordAtPtx1071R290, r_MmaAE4x4WordAtPtx1078R291,
		  r_MmaAE4x4WordAtPtx1085R292, r_MmaBE4x4WordAtPtx1020R277, r_MmaBE4x4WordAtPtx1020R278,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1115
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1122R337, r_MmaAccumulatorHalf2WordAtPtx1122R338,
		  r_MmaAE4x4WordAtPtx1064R289, r_MmaAE4x4WordAtPtx1071R290, r_MmaAE4x4WordAtPtx1078R291,
		  r_MmaAE4x4WordAtPtx1085R292, r_MmaBE4x4WordAtPtx1020R283, r_MmaBE4x4WordAtPtx1020R284,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1122
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1129R339, r_MmaAccumulatorHalf2WordAtPtx1129R340,
		  r_MmaAE4x4WordAtPtx1064R289, r_MmaAE4x4WordAtPtx1071R290, r_MmaAE4x4WordAtPtx1078R291,
		  r_MmaAE4x4WordAtPtx1085R292, r_MmaBE4x4WordAtPtx1028R285, r_MmaBE4x4WordAtPtx1028R286,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8); // PTX L1129
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1136R341, r_MmaAccumulatorHalf2WordAtPtx1136R342,
		  r_MmaAE4x4WordAtPtx1064R289, r_MmaAE4x4WordAtPtx1071R290, r_MmaAE4x4WordAtPtx1078R291,
		  r_MmaAE4x4WordAtPtx1085R292, r_MmaBE4x4WordAtPtx1028R287, r_MmaBE4x4WordAtPtx1028R288,
		  r_PackedHalf2AtPtx49R8,
		  r_PackedHalf2AtPtx49R8);																  // PTX L1136
	r_LaneIndexAtPtx1143 = uint32_t((threadIdx.x & 31u));										  // PTX L1143
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1143)) * int64_t(int32_t(16))); // PTX L1145
	r_PtxU64Register82 = uint64_t(r_PtxU64Register106) + uint64_t(r_PtxU64Register81);			  // PTX L1146
	r_PtxU64Register72 = uint64_t(r_PtxU64Register82) + uint64_t(-512);							  // PTX L1147
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register72));
		r_MmaBE4x4WordAtPtx1149R311 = r_Value.x;
		r_MmaBE4x4WordAtPtx1149R312 = r_Value.y;
		r_MmaBE4x4WordAtPtx1149R319 = r_Value.z;
		r_MmaBE4x4WordAtPtx1149R320 = r_Value.w;
	} // PTX L1149
	r_LaneIndexAtPtx1152 = uint32_t((threadIdx.x & 31u));										  // PTX L1152
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1152)) * int64_t(int32_t(16))); // PTX L1154
	r_PtxU64Register73 = uint64_t(r_PtxU64Register106) + uint64_t(r_PtxU64Register83);			  // PTX L1155
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register73));
		r_MmaBE4x4WordAtPtx1157R323 = r_Value.x;
		r_MmaBE4x4WordAtPtx1157R324 = r_Value.y;
		r_MmaBE4x4WordAtPtx1157R327 = r_Value.z;
		r_MmaBE4x4WordAtPtx1157R328 = r_Value.w;
	} // PTX L1157
	r_ConvertedE4PairAtPtx1160Rs21 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx814R295); // PTX L1160
	r_ConvertedE4PairAtPtx1163Rs22 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx821R296); // PTX L1163
	r_MmaAE4x4WordAtPtx1165R315 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1160Rs21, r_ConvertedE4PairAtPtx1163Rs22); // PTX L1165
	r_ConvertedE4PairAtPtx1167Rs23 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx814R297); // PTX L1167
	r_ConvertedE4PairAtPtx1170Rs24 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx821R298); // PTX L1170
	r_MmaAE4x4WordAtPtx1172R316 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1167Rs23, r_ConvertedE4PairAtPtx1170Rs24); // PTX L1172
	r_ConvertedE4PairAtPtx1174Rs25 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx842R299); // PTX L1174
	r_ConvertedE4PairAtPtx1177Rs26 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx849R300); // PTX L1177
	r_MmaAE4x4WordAtPtx1179R317 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1174Rs25, r_ConvertedE4PairAtPtx1177Rs26); // PTX L1179
	r_ConvertedE4PairAtPtx1181Rs27 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx842R301); // PTX L1181
	r_ConvertedE4PairAtPtx1184Rs28 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx849R302); // PTX L1184
	r_MmaAE4x4WordAtPtx1186R318 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1181Rs27, r_ConvertedE4PairAtPtx1184Rs28); // PTX L1186
	r_ConvertedE4PairAtPtx1188Rs29 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx926R303); // PTX L1188
	r_ConvertedE4PairAtPtx1191Rs30 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx933R304); // PTX L1191
	r_MmaAE4x4WordAtPtx1193R333 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1188Rs29, r_ConvertedE4PairAtPtx1191Rs30); // PTX L1193
	r_ConvertedE4PairAtPtx1195Rs31 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx926R305); // PTX L1195
	r_ConvertedE4PairAtPtx1198Rs32 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx933R306); // PTX L1198
	r_MmaAE4x4WordAtPtx1200R334 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1195Rs31, r_ConvertedE4PairAtPtx1198Rs32); // PTX L1200
	r_ConvertedE4PairAtPtx1202Rs33 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx954R307); // PTX L1202
	r_ConvertedE4PairAtPtx1205Rs34 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx961R308); // PTX L1205
	r_MmaAE4x4WordAtPtx1207R335 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1202Rs33, r_ConvertedE4PairAtPtx1205Rs34); // PTX L1207
	r_ConvertedE4PairAtPtx1209Rs35 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx954R309); // PTX L1209
	r_ConvertedE4PairAtPtx1212Rs36 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx961R310); // PTX L1212
	r_MmaAE4x4WordAtPtx1214R336 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1209Rs35, r_ConvertedE4PairAtPtx1212Rs36); // PTX L1214
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1216R349, r_MmaAccumulatorHalf2WordAtPtx1216R361,
		  r_MmaAE4x4WordAtPtx1165R315, r_MmaAE4x4WordAtPtx1172R316, r_MmaAE4x4WordAtPtx1179R317,
		  r_MmaAE4x4WordAtPtx1186R318, r_MmaBE4x4WordAtPtx1149R311, r_MmaBE4x4WordAtPtx1149R312,
		  r_MmaAccumulatorHalf2WordAtPtx1087R313,
		  r_MmaAccumulatorHalf2WordAtPtx1087R314); // PTX L1216
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1223R368, r_MmaAccumulatorHalf2WordAtPtx1223R375,
		  r_MmaAE4x4WordAtPtx1165R315, r_MmaAE4x4WordAtPtx1172R316, r_MmaAE4x4WordAtPtx1179R317,
		  r_MmaAE4x4WordAtPtx1186R318, r_MmaBE4x4WordAtPtx1149R319, r_MmaBE4x4WordAtPtx1149R320,
		  r_MmaAccumulatorHalf2WordAtPtx1094R321,
		  r_MmaAccumulatorHalf2WordAtPtx1094R322); // PTX L1223
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1230R382, r_MmaAccumulatorHalf2WordAtPtx1230R389,
		  r_MmaAE4x4WordAtPtx1165R315, r_MmaAE4x4WordAtPtx1172R316, r_MmaAE4x4WordAtPtx1179R317,
		  r_MmaAE4x4WordAtPtx1186R318, r_MmaBE4x4WordAtPtx1157R323, r_MmaBE4x4WordAtPtx1157R324,
		  r_MmaAccumulatorHalf2WordAtPtx1101R325,
		  r_MmaAccumulatorHalf2WordAtPtx1101R326); // PTX L1230
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1237R396, r_MmaAccumulatorHalf2WordAtPtx1237R403,
		  r_MmaAE4x4WordAtPtx1165R315, r_MmaAE4x4WordAtPtx1172R316, r_MmaAE4x4WordAtPtx1179R317,
		  r_MmaAE4x4WordAtPtx1186R318, r_MmaBE4x4WordAtPtx1157R327, r_MmaBE4x4WordAtPtx1157R328,
		  r_MmaAccumulatorHalf2WordAtPtx1108R329,
		  r_MmaAccumulatorHalf2WordAtPtx1108R330); // PTX L1237
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1244R410, r_MmaAccumulatorHalf2WordAtPtx1244R417,
		  r_MmaAE4x4WordAtPtx1193R333, r_MmaAE4x4WordAtPtx1200R334, r_MmaAE4x4WordAtPtx1207R335,
		  r_MmaAE4x4WordAtPtx1214R336, r_MmaBE4x4WordAtPtx1149R311, r_MmaBE4x4WordAtPtx1149R312,
		  r_MmaAccumulatorHalf2WordAtPtx1115R331,
		  r_MmaAccumulatorHalf2WordAtPtx1115R332); // PTX L1244
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1251R424, r_MmaAccumulatorHalf2WordAtPtx1251R431,
		  r_MmaAE4x4WordAtPtx1193R333, r_MmaAE4x4WordAtPtx1200R334, r_MmaAE4x4WordAtPtx1207R335,
		  r_MmaAE4x4WordAtPtx1214R336, r_MmaBE4x4WordAtPtx1149R319, r_MmaBE4x4WordAtPtx1149R320,
		  r_MmaAccumulatorHalf2WordAtPtx1122R337,
		  r_MmaAccumulatorHalf2WordAtPtx1122R338); // PTX L1251
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1258R438, r_MmaAccumulatorHalf2WordAtPtx1258R445,
		  r_MmaAE4x4WordAtPtx1193R333, r_MmaAE4x4WordAtPtx1200R334, r_MmaAE4x4WordAtPtx1207R335,
		  r_MmaAE4x4WordAtPtx1214R336, r_MmaBE4x4WordAtPtx1157R323, r_MmaBE4x4WordAtPtx1157R324,
		  r_MmaAccumulatorHalf2WordAtPtx1129R339,
		  r_MmaAccumulatorHalf2WordAtPtx1129R340); // PTX L1258
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1265R452, r_MmaAccumulatorHalf2WordAtPtx1265R459,
		  r_MmaAE4x4WordAtPtx1193R333, r_MmaAE4x4WordAtPtx1200R334, r_MmaAE4x4WordAtPtx1207R335,
		  r_MmaAE4x4WordAtPtx1214R336, r_MmaBE4x4WordAtPtx1157R327, r_MmaBE4x4WordAtPtx1157R328,
		  r_MmaAccumulatorHalf2WordAtPtx1136R341,
		  r_MmaAccumulatorHalf2WordAtPtx1136R342);						   // PTX L1265
	r_LaneIndexAtPtx1272 = uint32_t((threadIdx.x & 31u));				   // PTX L1272
	r_Float32BitsAtPtx1274R344 = uint32_t(-1065353216);					   // PTX L1274
	r_PackedHalf2AtPtx1276R352 = FloatToHalf2(r_Float32BitsAtPtx1274R344); // PTX L1276
	r_Float32BitsAtPtx1281R345 = uint32_t(1082130432);					   // PTX L1281
	r_PackedHalf2AtPtx1283R350 = FloatToHalf2(r_Float32BitsAtPtx1281R345); // PTX L1283
	r_Float32BitsAtPtx1288R346 = uint32_t(1063583744);					   // PTX L1288
	r_PackedHalf2AtPtx1290R358 = FloatToHalf2(r_Float32BitsAtPtx1288R346); // PTX L1290
	r_Float32BitsAtPtx1295R347 = uint32_t(1055195136);					   // PTX L1295
	r_PackedHalf2AtPtx1297R356 = FloatToHalf2(r_Float32BitsAtPtx1295R347); // PTX L1297
	r_Float32BitsAtPtx1302R348 = uint32_t(-1117454336);					   // PTX L1302
	r_PackedHalf2AtPtx1304R354 = FloatToHalf2(r_Float32BitsAtPtx1302R348); // PTX L1304
	r_PackedHalf2AtPtx1310R351 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1216R349, r_PackedHalf2AtPtx1283R350);			  // PTX L1310
	r_PackedHalf2AtPtx1314R353 = HalfMax(r_PackedHalf2AtPtx1310R351, r_PackedHalf2AtPtx1276R352); // PTX L1314
	r_PackedHalf2AtPtx1318R355 = HalfAbs(r_PackedHalf2AtPtx1314R353);							  // PTX L1318
	r_PackedHalf2AtPtx1322R357 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1318R355,
										 r_PackedHalf2AtPtx1297R356); // PTX L1322
	r_PackedHalf2AtPtx1326R359 = HalfFma(r_PackedHalf2AtPtx1314R353, r_PackedHalf2AtPtx1322R357,
										 r_PackedHalf2AtPtx1290R358); // PTX L1326
	r_PackedHalf2AtPtx1330R469 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1216R349, r_PackedHalf2AtPtx1326R359); // PTX L1330
	r_LaneIndexAtPtx1334 = uint32_t((threadIdx.x & 31u));							 // PTX L1334
	r_PackedHalf2AtPtx1337R362 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1216R361, r_PackedHalf2AtPtx1283R350);			  // PTX L1337
	r_PackedHalf2AtPtx1341R363 = HalfMax(r_PackedHalf2AtPtx1337R362, r_PackedHalf2AtPtx1276R352); // PTX L1341
	r_PackedHalf2AtPtx1345R364 = HalfAbs(r_PackedHalf2AtPtx1341R363);							  // PTX L1345
	r_PackedHalf2AtPtx1349R365 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1345R364,
										 r_PackedHalf2AtPtx1297R356); // PTX L1349
	r_PackedHalf2AtPtx1353R366 = HalfFma(r_PackedHalf2AtPtx1341R363, r_PackedHalf2AtPtx1349R365,
										 r_PackedHalf2AtPtx1290R358); // PTX L1353
	r_PackedHalf2AtPtx1357R471 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1216R361, r_PackedHalf2AtPtx1353R366); // PTX L1357
	r_LaneIndexAtPtx1361 = uint32_t((threadIdx.x & 31u));							 // PTX L1361
	r_PackedHalf2AtPtx1364R369 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1223R368, r_PackedHalf2AtPtx1283R350);			  // PTX L1364
	r_PackedHalf2AtPtx1368R370 = HalfMax(r_PackedHalf2AtPtx1364R369, r_PackedHalf2AtPtx1276R352); // PTX L1368
	r_PackedHalf2AtPtx1372R371 = HalfAbs(r_PackedHalf2AtPtx1368R370);							  // PTX L1372
	r_PackedHalf2AtPtx1376R372 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1372R371,
										 r_PackedHalf2AtPtx1297R356); // PTX L1376
	r_PackedHalf2AtPtx1380R373 = HalfFma(r_PackedHalf2AtPtx1368R370, r_PackedHalf2AtPtx1376R372,
										 r_PackedHalf2AtPtx1290R358); // PTX L1380
	r_PackedHalf2AtPtx1384R470 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1223R368, r_PackedHalf2AtPtx1380R373); // PTX L1384
	r_LaneIndexAtPtx1388 = uint32_t((threadIdx.x & 31u));							 // PTX L1388
	r_PackedHalf2AtPtx1391R376 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1223R375, r_PackedHalf2AtPtx1283R350);			  // PTX L1391
	r_PackedHalf2AtPtx1395R377 = HalfMax(r_PackedHalf2AtPtx1391R376, r_PackedHalf2AtPtx1276R352); // PTX L1395
	r_PackedHalf2AtPtx1399R378 = HalfAbs(r_PackedHalf2AtPtx1395R377);							  // PTX L1399
	r_PackedHalf2AtPtx1403R379 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1399R378,
										 r_PackedHalf2AtPtx1297R356); // PTX L1403
	r_PackedHalf2AtPtx1407R380 = HalfFma(r_PackedHalf2AtPtx1395R377, r_PackedHalf2AtPtx1403R379,
										 r_PackedHalf2AtPtx1290R358); // PTX L1407
	r_PackedHalf2AtPtx1411R472 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1223R375, r_PackedHalf2AtPtx1407R380); // PTX L1411
	r_LaneIndexAtPtx1415 = uint32_t((threadIdx.x & 31u));							 // PTX L1415
	r_PackedHalf2AtPtx1418R383 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1230R382, r_PackedHalf2AtPtx1283R350);			  // PTX L1418
	r_PackedHalf2AtPtx1422R384 = HalfMax(r_PackedHalf2AtPtx1418R383, r_PackedHalf2AtPtx1276R352); // PTX L1422
	r_PackedHalf2AtPtx1426R385 = HalfAbs(r_PackedHalf2AtPtx1422R384);							  // PTX L1426
	r_PackedHalf2AtPtx1430R386 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1426R385,
										 r_PackedHalf2AtPtx1297R356); // PTX L1430
	r_PackedHalf2AtPtx1434R387 = HalfFma(r_PackedHalf2AtPtx1422R384, r_PackedHalf2AtPtx1430R386,
										 r_PackedHalf2AtPtx1290R358); // PTX L1434
	r_PackedHalf2AtPtx1438R473 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1230R382, r_PackedHalf2AtPtx1434R387); // PTX L1438
	r_LaneIndexAtPtx1442 = uint32_t((threadIdx.x & 31u));							 // PTX L1442
	r_PackedHalf2AtPtx1445R390 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1230R389, r_PackedHalf2AtPtx1283R350);			  // PTX L1445
	r_PackedHalf2AtPtx1449R391 = HalfMax(r_PackedHalf2AtPtx1445R390, r_PackedHalf2AtPtx1276R352); // PTX L1449
	r_PackedHalf2AtPtx1453R392 = HalfAbs(r_PackedHalf2AtPtx1449R391);							  // PTX L1453
	r_PackedHalf2AtPtx1457R393 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1453R392,
										 r_PackedHalf2AtPtx1297R356); // PTX L1457
	r_PackedHalf2AtPtx1461R394 = HalfFma(r_PackedHalf2AtPtx1449R391, r_PackedHalf2AtPtx1457R393,
										 r_PackedHalf2AtPtx1290R358); // PTX L1461
	r_PackedHalf2AtPtx1465R475 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1230R389, r_PackedHalf2AtPtx1461R394); // PTX L1465
	r_LaneIndexAtPtx1469 = uint32_t((threadIdx.x & 31u));							 // PTX L1469
	r_PackedHalf2AtPtx1472R397 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1237R396, r_PackedHalf2AtPtx1283R350);			  // PTX L1472
	r_PackedHalf2AtPtx1476R398 = HalfMax(r_PackedHalf2AtPtx1472R397, r_PackedHalf2AtPtx1276R352); // PTX L1476
	r_PackedHalf2AtPtx1480R399 = HalfAbs(r_PackedHalf2AtPtx1476R398);							  // PTX L1480
	r_PackedHalf2AtPtx1484R400 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1480R399,
										 r_PackedHalf2AtPtx1297R356); // PTX L1484
	r_PackedHalf2AtPtx1488R401 = HalfFma(r_PackedHalf2AtPtx1476R398, r_PackedHalf2AtPtx1484R400,
										 r_PackedHalf2AtPtx1290R358); // PTX L1488
	r_PackedHalf2AtPtx1492R474 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1237R396, r_PackedHalf2AtPtx1488R401); // PTX L1492
	r_LaneIndexAtPtx1496 = uint32_t((threadIdx.x & 31u));							 // PTX L1496
	r_PackedHalf2AtPtx1499R404 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1237R403, r_PackedHalf2AtPtx1283R350);			  // PTX L1499
	r_PackedHalf2AtPtx1503R405 = HalfMax(r_PackedHalf2AtPtx1499R404, r_PackedHalf2AtPtx1276R352); // PTX L1503
	r_PackedHalf2AtPtx1507R406 = HalfAbs(r_PackedHalf2AtPtx1503R405);							  // PTX L1507
	r_PackedHalf2AtPtx1511R407 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1507R406,
										 r_PackedHalf2AtPtx1297R356); // PTX L1511
	r_PackedHalf2AtPtx1515R408 = HalfFma(r_PackedHalf2AtPtx1503R405, r_PackedHalf2AtPtx1511R407,
										 r_PackedHalf2AtPtx1290R358); // PTX L1515
	r_PackedHalf2AtPtx1519R476 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1237R403, r_PackedHalf2AtPtx1515R408); // PTX L1519
	r_LaneIndexAtPtx1523 = uint32_t((threadIdx.x & 31u));							 // PTX L1523
	r_PackedHalf2AtPtx1526R411 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1244R410, r_PackedHalf2AtPtx1283R350);			  // PTX L1526
	r_PackedHalf2AtPtx1530R412 = HalfMax(r_PackedHalf2AtPtx1526R411, r_PackedHalf2AtPtx1276R352); // PTX L1530
	r_PackedHalf2AtPtx1534R413 = HalfAbs(r_PackedHalf2AtPtx1530R412);							  // PTX L1534
	r_PackedHalf2AtPtx1538R414 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1534R413,
										 r_PackedHalf2AtPtx1297R356); // PTX L1538
	r_PackedHalf2AtPtx1542R415 = HalfFma(r_PackedHalf2AtPtx1530R412, r_PackedHalf2AtPtx1538R414,
										 r_PackedHalf2AtPtx1290R358); // PTX L1542
	r_PackedHalf2AtPtx1546R477 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1244R410, r_PackedHalf2AtPtx1542R415); // PTX L1546
	r_LaneIndexAtPtx1550 = uint32_t((threadIdx.x & 31u));							 // PTX L1550
	r_PackedHalf2AtPtx1553R418 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1244R417, r_PackedHalf2AtPtx1283R350);			  // PTX L1553
	r_PackedHalf2AtPtx1557R419 = HalfMax(r_PackedHalf2AtPtx1553R418, r_PackedHalf2AtPtx1276R352); // PTX L1557
	r_PackedHalf2AtPtx1561R420 = HalfAbs(r_PackedHalf2AtPtx1557R419);							  // PTX L1561
	r_PackedHalf2AtPtx1565R421 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1561R420,
										 r_PackedHalf2AtPtx1297R356); // PTX L1565
	r_PackedHalf2AtPtx1569R422 = HalfFma(r_PackedHalf2AtPtx1557R419, r_PackedHalf2AtPtx1565R421,
										 r_PackedHalf2AtPtx1290R358); // PTX L1569
	r_PackedHalf2AtPtx1573R479 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1244R417, r_PackedHalf2AtPtx1569R422); // PTX L1573
	r_LaneIndexAtPtx1577 = uint32_t((threadIdx.x & 31u));							 // PTX L1577
	r_PackedHalf2AtPtx1580R425 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1251R424, r_PackedHalf2AtPtx1283R350);			  // PTX L1580
	r_PackedHalf2AtPtx1584R426 = HalfMax(r_PackedHalf2AtPtx1580R425, r_PackedHalf2AtPtx1276R352); // PTX L1584
	r_PackedHalf2AtPtx1588R427 = HalfAbs(r_PackedHalf2AtPtx1584R426);							  // PTX L1588
	r_PackedHalf2AtPtx1592R428 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1588R427,
										 r_PackedHalf2AtPtx1297R356); // PTX L1592
	r_PackedHalf2AtPtx1596R429 = HalfFma(r_PackedHalf2AtPtx1584R426, r_PackedHalf2AtPtx1592R428,
										 r_PackedHalf2AtPtx1290R358); // PTX L1596
	r_PackedHalf2AtPtx1600R478 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1251R424, r_PackedHalf2AtPtx1596R429); // PTX L1600
	r_LaneIndexAtPtx1604 = uint32_t((threadIdx.x & 31u));							 // PTX L1604
	r_PackedHalf2AtPtx1607R432 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1251R431, r_PackedHalf2AtPtx1283R350);			  // PTX L1607
	r_PackedHalf2AtPtx1611R433 = HalfMax(r_PackedHalf2AtPtx1607R432, r_PackedHalf2AtPtx1276R352); // PTX L1611
	r_PackedHalf2AtPtx1615R434 = HalfAbs(r_PackedHalf2AtPtx1611R433);							  // PTX L1615
	r_PackedHalf2AtPtx1619R435 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1615R434,
										 r_PackedHalf2AtPtx1297R356); // PTX L1619
	r_PackedHalf2AtPtx1623R436 = HalfFma(r_PackedHalf2AtPtx1611R433, r_PackedHalf2AtPtx1619R435,
										 r_PackedHalf2AtPtx1290R358); // PTX L1623
	r_PackedHalf2AtPtx1627R480 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1251R431, r_PackedHalf2AtPtx1623R436); // PTX L1627
	r_LaneIndexAtPtx1631 = uint32_t((threadIdx.x & 31u));							 // PTX L1631
	r_PackedHalf2AtPtx1634R439 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1258R438, r_PackedHalf2AtPtx1283R350);			  // PTX L1634
	r_PackedHalf2AtPtx1638R440 = HalfMax(r_PackedHalf2AtPtx1634R439, r_PackedHalf2AtPtx1276R352); // PTX L1638
	r_PackedHalf2AtPtx1642R441 = HalfAbs(r_PackedHalf2AtPtx1638R440);							  // PTX L1642
	r_PackedHalf2AtPtx1646R442 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1642R441,
										 r_PackedHalf2AtPtx1297R356); // PTX L1646
	r_PackedHalf2AtPtx1650R443 = HalfFma(r_PackedHalf2AtPtx1638R440, r_PackedHalf2AtPtx1646R442,
										 r_PackedHalf2AtPtx1290R358); // PTX L1650
	r_PackedHalf2AtPtx1654R481 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1258R438, r_PackedHalf2AtPtx1650R443); // PTX L1654
	r_LaneIndexAtPtx1658 = uint32_t((threadIdx.x & 31u));							 // PTX L1658
	r_PackedHalf2AtPtx1661R446 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1258R445, r_PackedHalf2AtPtx1283R350);			  // PTX L1661
	r_PackedHalf2AtPtx1665R447 = HalfMax(r_PackedHalf2AtPtx1661R446, r_PackedHalf2AtPtx1276R352); // PTX L1665
	r_PackedHalf2AtPtx1669R448 = HalfAbs(r_PackedHalf2AtPtx1665R447);							  // PTX L1669
	r_PackedHalf2AtPtx1673R449 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1669R448,
										 r_PackedHalf2AtPtx1297R356); // PTX L1673
	r_PackedHalf2AtPtx1677R450 = HalfFma(r_PackedHalf2AtPtx1665R447, r_PackedHalf2AtPtx1673R449,
										 r_PackedHalf2AtPtx1290R358); // PTX L1677
	r_PackedHalf2AtPtx1681R483 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1258R445, r_PackedHalf2AtPtx1677R450); // PTX L1681
	r_LaneIndexAtPtx1685 = uint32_t((threadIdx.x & 31u));							 // PTX L1685
	r_PackedHalf2AtPtx1688R453 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1265R452, r_PackedHalf2AtPtx1283R350);			  // PTX L1688
	r_PackedHalf2AtPtx1692R454 = HalfMax(r_PackedHalf2AtPtx1688R453, r_PackedHalf2AtPtx1276R352); // PTX L1692
	r_PackedHalf2AtPtx1696R455 = HalfAbs(r_PackedHalf2AtPtx1692R454);							  // PTX L1696
	r_PackedHalf2AtPtx1700R456 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1696R455,
										 r_PackedHalf2AtPtx1297R356); // PTX L1700
	r_PackedHalf2AtPtx1704R457 = HalfFma(r_PackedHalf2AtPtx1692R454, r_PackedHalf2AtPtx1700R456,
										 r_PackedHalf2AtPtx1290R358); // PTX L1704
	r_PackedHalf2AtPtx1708R482 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1265R452, r_PackedHalf2AtPtx1704R457); // PTX L1708
	r_LaneIndexAtPtx1712 = uint32_t((threadIdx.x & 31u));							 // PTX L1712
	r_PackedHalf2AtPtx1715R460 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1265R459, r_PackedHalf2AtPtx1283R350);			  // PTX L1715
	r_PackedHalf2AtPtx1719R461 = HalfMax(r_PackedHalf2AtPtx1715R460, r_PackedHalf2AtPtx1276R352); // PTX L1719
	r_PackedHalf2AtPtx1723R462 = HalfAbs(r_PackedHalf2AtPtx1719R461);							  // PTX L1723
	r_PackedHalf2AtPtx1727R463 = HalfFma(r_PackedHalf2AtPtx1304R354, r_PackedHalf2AtPtx1723R462,
										 r_PackedHalf2AtPtx1297R356); // PTX L1727
	r_PackedHalf2AtPtx1731R464 = HalfFma(r_PackedHalf2AtPtx1719R461, r_PackedHalf2AtPtx1727R463,
										 r_PackedHalf2AtPtx1290R358); // PTX L1731
	r_PackedHalf2AtPtx1735R484 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1265R459, r_PackedHalf2AtPtx1731R464);			  // PTX L1735
	r_LaneIndexAtPtx1739 = uint32_t((threadIdx.x & 31u));										  // PTX L1739
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1739)) * int64_t(int32_t(16))); // PTX L1741
	r_PtxU64Register85 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register84);			  // PTX L1742
	r_PtxU64Register74 = uint64_t(r_PtxU64Register85) + uint64_t(-1536);						  // PTX L1743
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register74));
		r_MmaBE4x4WordAtPtx1745R485 = r_Value.x;
		r_MmaBE4x4WordAtPtx1745R486 = r_Value.y;
		r_MmaBE4x4WordAtPtx1745R491 = r_Value.z;
		r_MmaBE4x4WordAtPtx1745R492 = r_Value.w;
	} // PTX L1745
	r_LaneIndexAtPtx1748 = uint32_t((threadIdx.x & 31u));										  // PTX L1748
	r_PtxU64Register86 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1748)) * int64_t(int32_t(16))); // PTX L1750
	r_PtxU64Register87 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register86);			  // PTX L1751
	r_PtxU64Register75 = uint64_t(r_PtxU64Register87) + uint64_t(-1024);						  // PTX L1752
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register75));
		r_MmaBE4x4WordAtPtx1754R493 = r_Value.x;
		r_MmaBE4x4WordAtPtx1754R494 = r_Value.y;
		r_MmaBE4x4WordAtPtx1754R495 = r_Value.z;
		r_MmaBE4x4WordAtPtx1754R496 = r_Value.w;
	} // PTX L1754
	r_LaneIndexAtPtx1757 = uint32_t((threadIdx.x & 31u));										  // PTX L1757
	r_PtxU64Register88 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1757)) * int64_t(int32_t(16))); // PTX L1759
	r_PtxU64Register89 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register88);			  // PTX L1760
	r_PtxU64Register76 = uint64_t(r_PtxU64Register89) + uint64_t(-512);							  // PTX L1761
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register76));
		r_MmaBE4x4WordAtPtx1763R497 = r_Value.x;
		r_MmaBE4x4WordAtPtx1763R498 = r_Value.y;
		r_MmaBE4x4WordAtPtx1763R499 = r_Value.z;
		r_MmaBE4x4WordAtPtx1763R500 = r_Value.w;
	} // PTX L1763
	r_LaneIndexAtPtx1766 = uint32_t((threadIdx.x & 31u));										  // PTX L1766
	r_PtxU64Register90 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1766)) * int64_t(int32_t(16))); // PTX L1768
	r_PtxU64Register77 = uint64_t(r_PtxU64Register105) + uint64_t(r_PtxU64Register90);			  // PTX L1769
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register77));
		r_MmaBE4x4WordAtPtx1771R501 = r_Value.x;
		r_MmaBE4x4WordAtPtx1771R502 = r_Value.y;
		r_MmaBE4x4WordAtPtx1771R503 = r_Value.z;
		r_MmaBE4x4WordAtPtx1771R504 = r_Value.w;
	} // PTX L1771
	r_ConvertedE4PairAtPtx1774Rs37 = PublishE4(r_PackedHalf2AtPtx1330R469); // PTX L1774
	r_ConvertedE4PairAtPtx1777Rs38 = PublishE4(r_PackedHalf2AtPtx1384R470); // PTX L1777
	r_MmaAE4x4WordAtPtx1779R487 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1774Rs37, r_ConvertedE4PairAtPtx1777Rs38); // PTX L1779
	r_ConvertedE4PairAtPtx1781Rs39 = PublishE4(r_PackedHalf2AtPtx1357R471);			   // PTX L1781
	r_ConvertedE4PairAtPtx1784Rs40 = PublishE4(r_PackedHalf2AtPtx1411R472);			   // PTX L1784
	r_MmaAE4x4WordAtPtx1786R488 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1781Rs39, r_ConvertedE4PairAtPtx1784Rs40); // PTX L1786
	r_ConvertedE4PairAtPtx1788Rs41 = PublishE4(r_PackedHalf2AtPtx1438R473);			   // PTX L1788
	r_ConvertedE4PairAtPtx1791Rs42 = PublishE4(r_PackedHalf2AtPtx1492R474);			   // PTX L1791
	r_MmaAE4x4WordAtPtx1793R489 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1788Rs41, r_ConvertedE4PairAtPtx1791Rs42); // PTX L1793
	r_ConvertedE4PairAtPtx1795Rs43 = PublishE4(r_PackedHalf2AtPtx1465R475);			   // PTX L1795
	r_ConvertedE4PairAtPtx1798Rs44 = PublishE4(r_PackedHalf2AtPtx1519R476);			   // PTX L1798
	r_MmaAE4x4WordAtPtx1800R490 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1795Rs43, r_ConvertedE4PairAtPtx1798Rs44); // PTX L1800
	r_ConvertedE4PairAtPtx1802Rs45 = PublishE4(r_PackedHalf2AtPtx1546R477);			   // PTX L1802
	r_ConvertedE4PairAtPtx1805Rs46 = PublishE4(r_PackedHalf2AtPtx1600R478);			   // PTX L1805
	r_MmaAE4x4WordAtPtx1807R505 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1802Rs45, r_ConvertedE4PairAtPtx1805Rs46); // PTX L1807
	r_ConvertedE4PairAtPtx1809Rs47 = PublishE4(r_PackedHalf2AtPtx1573R479);			   // PTX L1809
	r_ConvertedE4PairAtPtx1812Rs48 = PublishE4(r_PackedHalf2AtPtx1627R480);			   // PTX L1812
	r_MmaAE4x4WordAtPtx1814R506 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1809Rs47, r_ConvertedE4PairAtPtx1812Rs48); // PTX L1814
	r_ConvertedE4PairAtPtx1816Rs49 = PublishE4(r_PackedHalf2AtPtx1654R481);			   // PTX L1816
	r_ConvertedE4PairAtPtx1819Rs50 = PublishE4(r_PackedHalf2AtPtx1708R482);			   // PTX L1819
	r_MmaAE4x4WordAtPtx1821R507 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1816Rs49, r_ConvertedE4PairAtPtx1819Rs50); // PTX L1821
	r_ConvertedE4PairAtPtx1823Rs51 = PublishE4(r_PackedHalf2AtPtx1681R483);			   // PTX L1823
	r_ConvertedE4PairAtPtx1826Rs52 = PublishE4(r_PackedHalf2AtPtx1735R484);			   // PTX L1826
	r_MmaAE4x4WordAtPtx1828R508 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1823Rs51, r_ConvertedE4PairAtPtx1826Rs52); // PTX L1828
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx980R600, r_MmaAccumulatorHalf2WordAtPtx981R601,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1745R485, r_MmaBE4x4WordAtPtx1745R486,
		  r_MmaAccumulatorHalf2WordAtPtx980R600, r_MmaAccumulatorHalf2WordAtPtx981R601); // PTX L1830
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx982R602, r_MmaAccumulatorHalf2WordAtPtx983R603,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1745R491, r_MmaBE4x4WordAtPtx1745R492,
		  r_MmaAccumulatorHalf2WordAtPtx982R602, r_MmaAccumulatorHalf2WordAtPtx983R603); // PTX L1837
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx984R604, r_MmaAccumulatorHalf2WordAtPtx985R605,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1754R493, r_MmaBE4x4WordAtPtx1754R494,
		  r_MmaAccumulatorHalf2WordAtPtx984R604, r_MmaAccumulatorHalf2WordAtPtx985R605); // PTX L1844
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx986R606, r_MmaAccumulatorHalf2WordAtPtx987R607,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1754R495, r_MmaBE4x4WordAtPtx1754R496,
		  r_MmaAccumulatorHalf2WordAtPtx986R606, r_MmaAccumulatorHalf2WordAtPtx987R607); // PTX L1851
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx988R608, r_MmaAccumulatorHalf2WordAtPtx989R609,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1763R497, r_MmaBE4x4WordAtPtx1763R498,
		  r_MmaAccumulatorHalf2WordAtPtx988R608, r_MmaAccumulatorHalf2WordAtPtx989R609); // PTX L1858
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx990R610, r_MmaAccumulatorHalf2WordAtPtx991R611,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1763R499, r_MmaBE4x4WordAtPtx1763R500,
		  r_MmaAccumulatorHalf2WordAtPtx990R610, r_MmaAccumulatorHalf2WordAtPtx991R611); // PTX L1865
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx992R612, r_MmaAccumulatorHalf2WordAtPtx993R613,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1771R501, r_MmaBE4x4WordAtPtx1771R502,
		  r_MmaAccumulatorHalf2WordAtPtx992R612, r_MmaAccumulatorHalf2WordAtPtx993R613); // PTX L1872
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx994R614, r_MmaAccumulatorHalf2WordAtPtx995R615,
		  r_MmaAE4x4WordAtPtx1779R487, r_MmaAE4x4WordAtPtx1786R488, r_MmaAE4x4WordAtPtx1793R489,
		  r_MmaAE4x4WordAtPtx1800R490, r_MmaBE4x4WordAtPtx1771R503, r_MmaBE4x4WordAtPtx1771R504,
		  r_MmaAccumulatorHalf2WordAtPtx994R614, r_MmaAccumulatorHalf2WordAtPtx995R615); // PTX L1879
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx996R616, r_MmaAccumulatorHalf2WordAtPtx997R617,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1745R485, r_MmaBE4x4WordAtPtx1745R486,
		  r_MmaAccumulatorHalf2WordAtPtx996R616, r_MmaAccumulatorHalf2WordAtPtx997R617); // PTX L1886
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx998R618, r_MmaAccumulatorHalf2WordAtPtx999R619,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1745R491, r_MmaBE4x4WordAtPtx1745R492,
		  r_MmaAccumulatorHalf2WordAtPtx998R618, r_MmaAccumulatorHalf2WordAtPtx999R619); // PTX L1893
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1000R620, r_MmaAccumulatorHalf2WordAtPtx1001R621,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1754R493, r_MmaBE4x4WordAtPtx1754R494,
		  r_MmaAccumulatorHalf2WordAtPtx1000R620,
		  r_MmaAccumulatorHalf2WordAtPtx1001R621); // PTX L1900
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1002R622, r_MmaAccumulatorHalf2WordAtPtx1003R623,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1754R495, r_MmaBE4x4WordAtPtx1754R496,
		  r_MmaAccumulatorHalf2WordAtPtx1002R622,
		  r_MmaAccumulatorHalf2WordAtPtx1003R623); // PTX L1907
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1004R624, r_MmaAccumulatorHalf2WordAtPtx1005R625,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1763R497, r_MmaBE4x4WordAtPtx1763R498,
		  r_MmaAccumulatorHalf2WordAtPtx1004R624,
		  r_MmaAccumulatorHalf2WordAtPtx1005R625); // PTX L1914
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1006R626, r_MmaAccumulatorHalf2WordAtPtx1007R627,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1763R499, r_MmaBE4x4WordAtPtx1763R500,
		  r_MmaAccumulatorHalf2WordAtPtx1006R626,
		  r_MmaAccumulatorHalf2WordAtPtx1007R627); // PTX L1921
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1008R628, r_MmaAccumulatorHalf2WordAtPtx1009R629,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1771R501, r_MmaBE4x4WordAtPtx1771R502,
		  r_MmaAccumulatorHalf2WordAtPtx1008R628,
		  r_MmaAccumulatorHalf2WordAtPtx1009R629); // PTX L1928
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1010R630, r_MmaAccumulatorHalf2WordAtPtx1011R631,
		  r_MmaAE4x4WordAtPtx1807R505, r_MmaAE4x4WordAtPtx1814R506, r_MmaAE4x4WordAtPtx1821R507,
		  r_MmaAE4x4WordAtPtx1828R508, r_MmaBE4x4WordAtPtx1771R503, r_MmaBE4x4WordAtPtx1771R504,
		  r_MmaAccumulatorHalf2WordAtPtx1010R630,
		  r_MmaAccumulatorHalf2WordAtPtx1011R631);						  // PTX L1935
	r_PtxRegister25 = uint32_t(r_PtxRegister632) + uint32_t(32);		  // PTX L1941
	r_PtxU64Register106 = uint64_t(r_PtxU64Register106) + uint64_t(1024); // PTX L1942
	r_PtxU64Register105 = uint64_t(r_PtxU64Register105) + uint64_t(2048); // PTX L1943
	r_PtxU64Register104 = uint64_t(r_PtxU64Register104) + uint64_t(1024); // PTX L1944
	r_bPtxPredicate26 = uint32_t(r_PtxRegister632) < uint32_t(224);		  // PTX L1945
	r_PtxRegister632 = uint32_t(r_PtxRegister25);						  // PTX L1946
	if (r_bPtxPredicate26)
	{
		goto L__BB1_22;
	} // PTX L1947
	r_bPtxPredicate27 = int32_t(r_PtxRegister59) >= int32_t(r_HeightDiv4Bits);					 // PTX L1948
	r_ConvertedE4PairAtPtx1950Rs53 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx980R600);			 // PTX L1950
	r_ConvertedE4PairAtPtx1953Rs54 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx982R602);			 // PTX L1953
	r_ConvertedE4PairAtPtx1956Rs55 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx981R601);			 // PTX L1956
	r_ConvertedE4PairAtPtx1959Rs56 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx983R603);			 // PTX L1959
	r_ConvertedE4PairAtPtx1962Rs57 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx984R604);			 // PTX L1962
	r_ConvertedE4PairAtPtx1965Rs58 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx986R606);			 // PTX L1965
	r_ConvertedE4PairAtPtx1968Rs59 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx985R605);			 // PTX L1968
	r_ConvertedE4PairAtPtx1971Rs60 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx987R607);			 // PTX L1971
	r_ConvertedE4PairAtPtx1974Rs61 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx988R608);			 // PTX L1974
	r_ConvertedE4PairAtPtx1977Rs62 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx990R610);			 // PTX L1977
	r_ConvertedE4PairAtPtx1980Rs63 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx989R609);			 // PTX L1980
	r_ConvertedE4PairAtPtx1983Rs64 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx991R611);			 // PTX L1983
	r_ConvertedE4PairAtPtx1986Rs65 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx992R612);			 // PTX L1986
	r_ConvertedE4PairAtPtx1989Rs66 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx994R614);			 // PTX L1989
	r_ConvertedE4PairAtPtx1992Rs67 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx993R613);			 // PTX L1992
	r_ConvertedE4PairAtPtx1995Rs68 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx995R615);			 // PTX L1995
	r_ConvertedE4PairAtPtx1998Rs69 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx996R616);			 // PTX L1998
	r_ConvertedE4PairAtPtx2001Rs70 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx998R618);			 // PTX L2001
	r_ConvertedE4PairAtPtx2004Rs71 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx997R617);			 // PTX L2004
	r_ConvertedE4PairAtPtx2007Rs72 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx999R619);			 // PTX L2007
	r_ConvertedE4PairAtPtx2010Rs73 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1000R620);			 // PTX L2010
	r_ConvertedE4PairAtPtx2013Rs74 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1002R622);			 // PTX L2013
	r_ConvertedE4PairAtPtx2016Rs75 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1001R621);			 // PTX L2016
	r_ConvertedE4PairAtPtx2019Rs76 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1003R623);			 // PTX L2019
	r_ConvertedE4PairAtPtx2022Rs77 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1004R624);			 // PTX L2022
	r_ConvertedE4PairAtPtx2025Rs78 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1006R626);			 // PTX L2025
	r_ConvertedE4PairAtPtx2028Rs79 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1005R625);			 // PTX L2028
	r_ConvertedE4PairAtPtx2031Rs80 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1007R627);			 // PTX L2031
	r_ConvertedE4PairAtPtx2034Rs81 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1008R628);			 // PTX L2034
	r_ConvertedE4PairAtPtx2037Rs82 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1010R630);			 // PTX L2037
	r_ConvertedE4PairAtPtx2040Rs83 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1009R629);			 // PTX L2040
	r_ConvertedE4PairAtPtx2043Rs84 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx1011R631);			 // PTX L2043
	r_bPtxPredicate28 = int32_t(r_PtxRegister4) >= int32_t(r_WidthDiv4Bits);					 // PTX L2045
	r_PtxRegister509 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister4);					 // PTX L2046
	r_PtxRegister510 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L2047
	r_PtxRegister511 = ShiftLeft(uint32_t(r_PtxRegister509), uint32_t(11));						 // PTX L2048
	r_PtxRegister512 = uint32_t(r_PtxRegister511) + uint32_t(r_PtxRegister510);					 // PTX L2049
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister512)) * int64_t(int32_t(4)));	 // PTX L2050
	g_OutputByteAddressAtPtx2051 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register91); // PTX L2051
	r_bPtxPredicate29 = r_bPtxPredicate27 | r_bPtxPredicate28;									 // PTX L2052
	if (r_bPtxPredicate29)
	{
		goto L__BB1_25;
	} // PTX L2053
	r_PackedE4WordAtPtx2054R522 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1992Rs67, r_ConvertedE4PairAtPtx1995Rs68); // PTX L2054
	r_PackedE4WordAtPtx2055R521 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1986Rs65, r_ConvertedE4PairAtPtx1989Rs66); // PTX L2055
	r_PackedE4WordAtPtx2056R520 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1980Rs63, r_ConvertedE4PairAtPtx1983Rs64); // PTX L2056
	r_PackedE4WordAtPtx2057R519 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1974Rs61, r_ConvertedE4PairAtPtx1977Rs62); // PTX L2057
	r_PackedE4WordAtPtx2058R517 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1968Rs59, r_ConvertedE4PairAtPtx1971Rs60); // PTX L2058
	r_PackedE4WordAtPtx2059R516 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1962Rs57, r_ConvertedE4PairAtPtx1965Rs58); // PTX L2059
	r_PackedE4WordAtPtx2060R515 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1956Rs55, r_ConvertedE4PairAtPtx1959Rs56); // PTX L2060
	r_PackedE4WordAtPtx2061R514 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1950Rs53, r_ConvertedE4PairAtPtx1953Rs54);			  // PTX L2061
	r_LaneIndexAtPtx2063 = uint32_t((threadIdx.x & 31u));										  // PTX L2063
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2063)) * int64_t(int32_t(16))); // PTX L2065
	g_OutputByteAddressAtPtx2066 =
		uint64_t(g_OutputByteAddressAtPtx2051) + uint64_t(r_PtxU64Register94); // PTX L2066
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx2066,
					make_uint4(r_PackedE4WordAtPtx2061R514, r_PackedE4WordAtPtx2060R515,
							   r_PackedE4WordAtPtx2059R516,
							   r_PackedE4WordAtPtx2058R517));									  // PTX L2068
	r_LaneIndexAtPtx2071 = uint32_t((threadIdx.x & 31u));										  // PTX L2071
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2071)) * int64_t(int32_t(16))); // PTX L2073
	g_OutputByteAddressAtPtx2074 =
		uint64_t(g_OutputByteAddressAtPtx2051) + uint64_t(r_PtxU64Register95);			   // PTX L2074
	g_OutputByteAddressAtPtx2075 = uint64_t(g_OutputByteAddressAtPtx2074) + uint64_t(512); // PTX L2075
	StoreNoAllocate(g_OutputByteAddressAtPtx2075,
					make_uint4(r_PackedE4WordAtPtx2057R519, r_PackedE4WordAtPtx2056R520,
							   r_PackedE4WordAtPtx2055R521,
							   r_PackedE4WordAtPtx2054R522));				   // PTX L2077
L__BB1_25:																	   // PTX L2079
	r_PtxRegister523 = uint32_t(r_PtxRegister4) + uint32_t(1);				   // PTX L2080
	r_bPtxPredicate30 = int32_t(r_PtxRegister523) >= int32_t(r_WidthDiv4Bits); // PTX L2081
	r_bPtxPredicate31 = r_bPtxPredicate27 | r_bPtxPredicate30;				   // PTX L2082
	if (r_bPtxPredicate31)
	{
		goto L__BB1_27;
	} // PTX L2083
	r_LaneIndexAtPtx2085 = uint32_t((threadIdx.x & 31u));										  // PTX L2085
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2085)) * int64_t(int32_t(16))); // PTX L2087
	g_OutputByteAddressAtPtx2088 =
		uint64_t(g_OutputByteAddressAtPtx2051) + uint64_t(r_PtxU64Register99);				// PTX L2088
	g_OutputByteAddressAtPtx2089 = uint64_t(g_OutputByteAddressAtPtx2088) + uint64_t(8192); // PTX L2089
	r_PackedE4WordAtPtx2090R528 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2016Rs75, r_ConvertedE4PairAtPtx2019Rs76); // PTX L2090
	r_PackedE4WordAtPtx2091R527 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2010Rs73, r_ConvertedE4PairAtPtx2013Rs74); // PTX L2091
	r_PackedE4WordAtPtx2092R526 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2004Rs71, r_ConvertedE4PairAtPtx2007Rs72); // PTX L2092
	r_PackedE4WordAtPtx2093R525 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1998Rs69, r_ConvertedE4PairAtPtx2001Rs70); // PTX L2093
	StoreNoAllocate(g_OutputByteAddressAtPtx2089,
					make_uint4(r_PackedE4WordAtPtx2093R525, r_PackedE4WordAtPtx2092R526,
							   r_PackedE4WordAtPtx2091R527,
							   r_PackedE4WordAtPtx2090R528)); // PTX L2095
	r_LaneIndexAtPtx2098 = uint32_t((threadIdx.x & 31u));	  // PTX L2098
	r_PtxU64Register101 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2098)) * int64_t(int32_t(16))); // PTX L2100
	g_OutputByteAddressAtPtx2101 =
		uint64_t(g_OutputByteAddressAtPtx2051) + uint64_t(r_PtxU64Register101);				// PTX L2101
	g_OutputByteAddressAtPtx2102 = uint64_t(g_OutputByteAddressAtPtx2101) + uint64_t(8704); // PTX L2102
	r_PackedE4WordAtPtx2103R533 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2040Rs83, r_ConvertedE4PairAtPtx2043Rs84); // PTX L2103
	r_PackedE4WordAtPtx2104R532 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2034Rs81, r_ConvertedE4PairAtPtx2037Rs82); // PTX L2104
	r_PackedE4WordAtPtx2105R531 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2028Rs79, r_ConvertedE4PairAtPtx2031Rs80); // PTX L2105
	r_PackedE4WordAtPtx2106R530 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2022Rs77, r_ConvertedE4PairAtPtx2025Rs78); // PTX L2106
	StoreNoAllocate(g_OutputByteAddressAtPtx2102,
					make_uint4(r_PackedE4WordAtPtx2106R530, r_PackedE4WordAtPtx2105R531,
							   r_PackedE4WordAtPtx2104R532,
							   r_PackedE4WordAtPtx2103R533)); // PTX L2108
L__BB1_27:													  // PTX L2110
	return;													  // PTX L2111
#endif
}
} // namespace dlssnr::reconstructed::window_ffn_c512_fp8
