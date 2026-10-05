// Readable equivalent of cc_vit_1d_ffn_expand_fp8; not the historical C++ file.
#pragma once
#include "global_ffn_expand_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8
{
__global__ __maxnreg__(168) void global_ffn_expand_c1024_fp8(Parameters r_Parameters)
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
		r_bPtxPredicate114, r_bPtxPredicate115, r_bPtxPredicate116, r_bPtxPredicate117;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_ConvertedE4PairAtPtx244Rs3, r_PtxU16Register4,
		r_ConvertedE4PairAtPtx297Rs5, r_PtxU16Register6, r_PtxU16Register7, r_ConvertedE4PairAtPtx404Rs8,
		r_PtxU16Register9, r_ConvertedE4PairAtPtx464Rs10, r_PtxU16Register11, r_PtxU16Register12;
	uint16_t r_ConvertedE4PairAtPtx577Rs13, r_PtxU16Register14, r_ConvertedE4PairAtPtx633Rs15,
		r_PtxU16Register16, r_PtxU16Register17, r_ConvertedE4PairAtPtx741Rs18, r_PtxU16Register19,
		r_ConvertedE4PairAtPtx797Rs20, r_PtxU16Register21, r_PtxU16Register22, r_ConvertedE4PairAtPtx905Rs23,
		r_PtxU16Register24;
	uint16_t r_ConvertedE4PairAtPtx961Rs25, r_PtxU16Register26, r_PtxU16Register27,
		r_ConvertedE4PairAtPtx1068Rs28, r_PtxU16Register29, r_ConvertedE4PairAtPtx1123Rs30,
		r_PtxU16Register31, r_PtxU16Register32, r_PtxU16Register33, r_PtxU16Register34, r_PtxU16Register35,
		r_PtxU16Register36;
	uint16_t r_PtxU16Register37, r_PtxU16Register38, r_PtxU16Register39, r_PtxU16Register40,
		r_PtxU16Register41, r_PtxU16Register42, r_PtxU16Register43, r_PtxU16Register44,
		r_ConvertedE4PairAtPtx1962Rs45, r_PtxU16Register46, r_ConvertedE4PairAtPtx2013Rs47,
		r_PtxU16Register48;
	uint16_t r_ConvertedE4PairAtPtx2108Rs49, r_PtxU16Register50, r_ConvertedE4PairAtPtx2159Rs51,
		r_ConvertedE4PairAtPtx3939Rs52, r_ConvertedE4PairAtPtx3942Rs53, r_ConvertedE4PairAtPtx3945Rs54,
		r_ConvertedE4PairAtPtx3948Rs55, r_ConvertedE4PairAtPtx3951Rs56, r_ConvertedE4PairAtPtx3954Rs57,
		r_ConvertedE4PairAtPtx3957Rs58, r_ConvertedE4PairAtPtx3960Rs59, r_ConvertedE4PairAtPtx3963Rs60;
	uint16_t r_ConvertedE4PairAtPtx3966Rs61, r_ConvertedE4PairAtPtx3969Rs62, r_ConvertedE4PairAtPtx3972Rs63,
		r_ConvertedE4PairAtPtx3975Rs64, r_ConvertedE4PairAtPtx3978Rs65, r_ConvertedE4PairAtPtx3981Rs66,
		r_ConvertedE4PairAtPtx3984Rs67, r_ConvertedE4PairAtPtx3987Rs68, r_ConvertedE4PairAtPtx3990Rs69,
		r_ConvertedE4PairAtPtx3993Rs70, r_ConvertedE4PairAtPtx3996Rs71, r_ConvertedE4PairAtPtx3999Rs72;
	uint16_t r_ConvertedE4PairAtPtx4002Rs73, r_ConvertedE4PairAtPtx4005Rs74, r_ConvertedE4PairAtPtx4008Rs75,
		r_ConvertedE4PairAtPtx4011Rs76, r_ConvertedE4PairAtPtx4014Rs77, r_ConvertedE4PairAtPtx4017Rs78,
		r_ConvertedE4PairAtPtx4020Rs79, r_ConvertedE4PairAtPtx4023Rs80, r_ConvertedE4PairAtPtx4026Rs81,
		r_ConvertedE4PairAtPtx4029Rs82, r_ConvertedE4PairAtPtx4032Rs83, r_ConvertedE4PairAtPtx4035Rs84;
	uint16_t r_ConvertedE4PairAtPtx4038Rs85, r_ConvertedE4PairAtPtx4041Rs86, r_ConvertedE4PairAtPtx4044Rs87,
		r_ConvertedE4PairAtPtx4047Rs88, r_ConvertedE4PairAtPtx4050Rs89, r_ConvertedE4PairAtPtx4053Rs90,
		r_ConvertedE4PairAtPtx4056Rs91, r_ConvertedE4PairAtPtx4059Rs92, r_ConvertedE4PairAtPtx4062Rs93,
		r_ConvertedE4PairAtPtx4065Rs94, r_ConvertedE4PairAtPtx4068Rs95, r_ConvertedE4PairAtPtx4071Rs96;
	uint16_t r_ConvertedE4PairAtPtx4074Rs97, r_ConvertedE4PairAtPtx4077Rs98, r_ConvertedE4PairAtPtx4080Rs99,
		r_ConvertedE4PairAtPtx4083Rs100, r_ConvertedE4PairAtPtx4086Rs101, r_ConvertedE4PairAtPtx4089Rs102,
		r_ConvertedE4PairAtPtx4092Rs103, r_ConvertedE4PairAtPtx4095Rs104, r_ConvertedE4PairAtPtx4098Rs105,
		r_ConvertedE4PairAtPtx4101Rs106, r_ConvertedE4PairAtPtx4104Rs107, r_ConvertedE4PairAtPtx4107Rs108;
	uint16_t r_ConvertedE4PairAtPtx4110Rs109, r_ConvertedE4PairAtPtx4113Rs110,
		r_ConvertedE4PairAtPtx4116Rs111, r_ConvertedE4PairAtPtx4119Rs112, r_ConvertedE4PairAtPtx4122Rs113,
		r_ConvertedE4PairAtPtx4125Rs114, r_ConvertedE4PairAtPtx4128Rs115, r_PtxU16Register116,
		r_PtxU16Register117, r_PtxU16Register118, r_PtxU16Register119, r_PtxU16Register120;
	uint16_t r_PtxU16Register121, r_PtxU16Register122, r_PtxU16Register123;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_ThreadY, r_PtxRegister6,
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
		r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_BlockSizeX, r_BlockSizeY;
	uint32_t r_Float32BitsAtPtx57R73, r_LaneIndexAtPtx74, r_LaneIndexAtPtx82, r_LaneIndexAtPtx91,
		r_LaneIndexAtPtx100, r_LaneIndexAtPtx109, r_LaneIndexAtPtx118, r_LaneIndexAtPtx127,
		r_LaneIndexAtPtx136, r_PtxRegister82, r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PackedHalf2AtPtx242R101,
		r_LaneIndexAtPtx248, r_PtxRegister103, r_PackedE4WordAtPtx246R104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PackedHalf2AtPtx295R114, r_LaneIndexAtPtx301, r_PtxRegister116, r_PackedE4WordAtPtx299R117,
		r_PtxRegister118, r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PackedHalf2AtPtx402R135, r_LaneIndexAtPtx408,
		r_PtxRegister137, r_PackedE4WordAtPtx406R138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141,
		r_PtxRegister142, r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PackedHalf2AtPtx462R154,
		r_LaneIndexAtPtx468, r_PtxRegister156;
	uint32_t r_PackedE4WordAtPtx466R157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160,
		r_PtxRegister161, r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165,
		r_PtxRegister166, r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PackedHalf2AtPtx575R186, r_LaneIndexAtPtx581, r_PtxRegister188, r_PackedE4WordAtPtx579R189,
		r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PackedHalf2AtPtx631R202,
		r_LaneIndexAtPtx637, r_PtxRegister204;
	uint32_t r_PackedE4WordAtPtx635R205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208,
		r_PtxRegister209, r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213,
		r_PtxRegister214, r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PackedHalf2AtPtx739R228;
	uint32_t r_LaneIndexAtPtx745, r_PtxRegister230, r_PackedE4WordAtPtx743R231, r_PtxRegister232,
		r_PtxRegister233, r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237,
		r_PtxRegister238, r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PackedHalf2AtPtx795R244,
		r_LaneIndexAtPtx801, r_PtxRegister246, r_PackedE4WordAtPtx799R247, r_PtxRegister248, r_PtxRegister249,
		r_PtxRegister250, r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PtxRegister268, r_PtxRegister269,
		r_PackedHalf2AtPtx903R270, r_LaneIndexAtPtx909, r_PtxRegister272, r_PackedE4WordAtPtx907R273,
		r_PtxRegister274, r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285, r_PackedHalf2AtPtx959R286,
		r_LaneIndexAtPtx965, r_PtxRegister288;
	uint32_t r_PackedE4WordAtPtx963R289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292,
		r_PtxRegister293, r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297,
		r_PtxRegister298, r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PtxRegister301, r_PtxRegister302, r_PtxRegister303, r_PtxRegister304, r_PtxRegister305,
		r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309, r_PtxRegister310,
		r_PtxRegister311, r_PackedHalf2AtPtx1066R312;
	uint32_t r_LaneIndexAtPtx1072, r_PtxRegister314, r_PackedE4WordAtPtx1070R315, r_PtxRegister316,
		r_PtxRegister317, r_PtxRegister318, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321,
		r_PtxRegister322, r_PtxRegister323, r_PtxRegister324;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_PtxRegister327, r_PackedHalf2AtPtx1121R328,
		r_LaneIndexAtPtx1127, r_PtxRegister330, r_PackedE4WordAtPtx1125R331, r_PtxRegister332,
		r_PtxRegister333, r_PtxRegister334, r_PtxRegister335, r_PtxRegister336;
	uint32_t r_PtxRegister337, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_PtxRegister341,
		r_PtxRegister342, r_PtxRegister343, r_PtxRegister344, r_PtxRegister345, r_PtxRegister346,
		r_LaneIndexAtPtx1240, r_PtxRegister348;
	uint32_t r_LaneIndexAtPtx1249, r_PtxRegister350, r_LaneIndexAtPtx1259, r_PtxRegister352,
		r_LaneIndexAtPtx1268, r_PtxRegister354, r_LaneIndexAtPtx1277, r_PtxRegister356, r_LaneIndexAtPtx1286,
		r_PtxRegister358, r_LaneIndexAtPtx1295, r_PtxRegister360;
	uint32_t r_LaneIndexAtPtx1304, r_PtxRegister362, r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364,
		r_MmaAE4x4WordAtPtx1246R365, r_MmaAE4x4WordAtPtx1246R366, r_MmaAE4x4WordAtPtx1256R367,
		r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369, r_MmaAE4x4WordAtPtx1256R370,
		r_MmaAccumulatorHalf2WordAtPtx1313R371, r_MmaAccumulatorHalf2WordAtPtx1313R372;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1320R373, r_MmaAccumulatorHalf2WordAtPtx1320R374,
		r_MmaAccumulatorHalf2WordAtPtx1341R375, r_MmaAccumulatorHalf2WordAtPtx1341R376,
		r_MmaAccumulatorHalf2WordAtPtx1348R377, r_MmaAccumulatorHalf2WordAtPtx1348R378,
		r_MmaAccumulatorHalf2WordAtPtx1369R379, r_MmaAccumulatorHalf2WordAtPtx1369R380,
		r_MmaAccumulatorHalf2WordAtPtx1376R381, r_MmaAccumulatorHalf2WordAtPtx1376R382,
		r_MmaAccumulatorHalf2WordAtPtx1397R383, r_MmaAccumulatorHalf2WordAtPtx1397R384;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1404R385, r_MmaAccumulatorHalf2WordAtPtx1404R386,
		r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		r_MmaAE4x4WordAtPtx1265R390, r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392,
		r_MmaAE4x4WordAtPtx1274R393, r_MmaAE4x4WordAtPtx1274R394, r_MmaAccumulatorHalf2WordAtPtx1425R395,
		r_MmaAccumulatorHalf2WordAtPtx1425R396;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1432R397, r_MmaAccumulatorHalf2WordAtPtx1432R398,
		r_MmaAccumulatorHalf2WordAtPtx1453R399, r_MmaAccumulatorHalf2WordAtPtx1453R400,
		r_MmaAccumulatorHalf2WordAtPtx1460R401, r_MmaAccumulatorHalf2WordAtPtx1460R402,
		r_MmaAccumulatorHalf2WordAtPtx1481R403, r_MmaAccumulatorHalf2WordAtPtx1481R404,
		r_MmaAccumulatorHalf2WordAtPtx1488R405, r_MmaAccumulatorHalf2WordAtPtx1488R406,
		r_MmaAccumulatorHalf2WordAtPtx1509R407, r_MmaAccumulatorHalf2WordAtPtx1509R408;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1516R409, r_MmaAccumulatorHalf2WordAtPtx1516R410,
		r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		r_MmaAE4x4WordAtPtx1283R414, r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416,
		r_MmaAE4x4WordAtPtx1292R417, r_MmaAE4x4WordAtPtx1292R418, r_MmaAccumulatorHalf2WordAtPtx1537R419,
		r_MmaAccumulatorHalf2WordAtPtx1537R420;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1544R421, r_MmaAccumulatorHalf2WordAtPtx1544R422,
		r_MmaAccumulatorHalf2WordAtPtx1565R423, r_MmaAccumulatorHalf2WordAtPtx1565R424,
		r_MmaAccumulatorHalf2WordAtPtx1572R425, r_MmaAccumulatorHalf2WordAtPtx1572R426,
		r_MmaAccumulatorHalf2WordAtPtx1593R427, r_MmaAccumulatorHalf2WordAtPtx1593R428,
		r_MmaAccumulatorHalf2WordAtPtx1600R429, r_MmaAccumulatorHalf2WordAtPtx1600R430,
		r_MmaAccumulatorHalf2WordAtPtx1621R431, r_MmaAccumulatorHalf2WordAtPtx1621R432;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1628R433, r_MmaAccumulatorHalf2WordAtPtx1628R434,
		r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		r_MmaAE4x4WordAtPtx1301R438, r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440,
		r_MmaAE4x4WordAtPtx1310R441, r_MmaAE4x4WordAtPtx1310R442, r_MmaAccumulatorHalf2WordAtPtx1649R443,
		r_MmaAccumulatorHalf2WordAtPtx1649R444;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1656R445, r_MmaAccumulatorHalf2WordAtPtx1656R446,
		r_MmaAccumulatorHalf2WordAtPtx1677R447, r_MmaAccumulatorHalf2WordAtPtx1677R448,
		r_MmaAccumulatorHalf2WordAtPtx1684R449, r_MmaAccumulatorHalf2WordAtPtx1684R450,
		r_MmaAccumulatorHalf2WordAtPtx1705R451, r_MmaAccumulatorHalf2WordAtPtx1705R452,
		r_MmaAccumulatorHalf2WordAtPtx1712R453, r_MmaAccumulatorHalf2WordAtPtx1712R454,
		r_MmaAccumulatorHalf2WordAtPtx1733R455, r_MmaAccumulatorHalf2WordAtPtx1733R456;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1740R457, r_MmaAccumulatorHalf2WordAtPtx1740R458, r_PtxRegister459,
		r_PtxRegister460, r_PtxRegister461, r_PtxRegister462, r_PtxRegister463, r_PtxRegister464,
		r_PtxRegister465, r_PtxRegister466, r_PtxRegister467, r_PtxRegister468;
	uint32_t r_PtxRegister469, r_PtxRegister470, r_PtxRegister471, r_PtxRegister472, r_PtxRegister473,
		r_PtxRegister474, r_PtxRegister475, r_PtxRegister476, r_PtxRegister477, r_PtxRegister478,
		r_PtxRegister479, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx1769, r_LaneIndexAtPtx1777, r_LaneIndexAtPtx1786, r_LaneIndexAtPtx1795,
		r_LaneIndexAtPtx1804, r_LaneIndexAtPtx1813, r_LaneIndexAtPtx1822, r_LaneIndexAtPtx1831,
		r_PtxRegister489, r_PtxRegister490, r_PtxRegister491, r_PtxRegister492;
	uint32_t r_PtxRegister493, r_PtxRegister494, r_PtxRegister495, r_PtxRegister496, r_PtxRegister497,
		r_PtxRegister498, r_PtxRegister499, r_PtxRegister500, r_PtxRegister501, r_PtxRegister502,
		r_PtxRegister503, r_PtxRegister504;
	uint32_t r_PtxRegister505, r_PtxRegister506, r_PtxRegister507, r_PtxRegister508, r_PtxRegister509,
		r_PtxRegister510, r_PackedHalf2AtPtx1960R511, r_LaneIndexAtPtx1966, r_PtxRegister513,
		r_PackedE4WordAtPtx1964R514, r_PtxRegister515, r_PtxRegister516;
	uint32_t r_PtxRegister517, r_PtxRegister518, r_PtxRegister519, r_PtxRegister520,
		r_PackedHalf2AtPtx2011R521, r_LaneIndexAtPtx2017, r_PtxRegister523, r_PackedE4WordAtPtx2015R524,
		r_PtxRegister525, r_PtxRegister526, r_PtxRegister527, r_PtxRegister528;
	uint32_t r_PtxRegister529, r_PtxRegister530, r_PtxRegister531, r_PtxRegister532, r_PtxRegister533,
		r_PtxRegister534, r_PtxRegister535, r_PtxRegister536, r_PtxRegister537, r_PackedHalf2AtPtx2106R538,
		r_LaneIndexAtPtx2112, r_PtxRegister540;
	uint32_t r_PackedE4WordAtPtx2110R541, r_PtxRegister542, r_PtxRegister543, r_PtxRegister544,
		r_PtxRegister545, r_PtxRegister546, r_PtxRegister547, r_PackedHalf2AtPtx2157R548,
		r_LaneIndexAtPtx2163, r_PtxRegister550, r_PackedE4WordAtPtx2161R551, r_PtxRegister552;
	uint32_t r_PtxRegister553, r_PtxRegister554, r_PtxRegister555, r_PtxRegister556, r_PtxRegister557,
		r_LaneIndexAtPtx2176, r_Float32BitsAtPtx2178R559, r_Float32BitsAtPtx2185R560,
		r_Float32BitsAtPtx2192R561, r_Float32BitsAtPtx2199R562, r_Float32BitsAtPtx2206R563,
		r_PackedHalf2AtPtx2187R564;
	uint32_t r_PackedHalf2AtPtx2214R565, r_PackedHalf2AtPtx2180R566, r_PackedHalf2AtPtx2218R567,
		r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2222R569, r_PackedHalf2AtPtx2201R570,
		r_PackedHalf2AtPtx2226R571, r_PackedHalf2AtPtx2194R572, r_PackedHalf2AtPtx2230R573,
		r_LaneIndexAtPtx2238, r_PackedHalf2AtPtx2241R575, r_PackedHalf2AtPtx2245R576;
	uint32_t r_PackedHalf2AtPtx2249R577, r_PackedHalf2AtPtx2253R578, r_PackedHalf2AtPtx2257R579,
		r_LaneIndexAtPtx2265, r_PackedHalf2AtPtx2268R581, r_PackedHalf2AtPtx2272R582,
		r_PackedHalf2AtPtx2276R583, r_PackedHalf2AtPtx2280R584, r_PackedHalf2AtPtx2284R585,
		r_LaneIndexAtPtx2292, r_PackedHalf2AtPtx2295R587, r_PackedHalf2AtPtx2299R588;
	uint32_t r_PackedHalf2AtPtx2303R589, r_PackedHalf2AtPtx2307R590, r_PackedHalf2AtPtx2311R591,
		r_LaneIndexAtPtx2319, r_PackedHalf2AtPtx2322R593, r_PackedHalf2AtPtx2326R594,
		r_PackedHalf2AtPtx2330R595, r_PackedHalf2AtPtx2334R596, r_PackedHalf2AtPtx2338R597,
		r_LaneIndexAtPtx2346, r_PackedHalf2AtPtx2349R599, r_PackedHalf2AtPtx2353R600;
	uint32_t r_PackedHalf2AtPtx2357R601, r_PackedHalf2AtPtx2361R602, r_PackedHalf2AtPtx2365R603,
		r_LaneIndexAtPtx2373, r_PackedHalf2AtPtx2376R605, r_PackedHalf2AtPtx2380R606,
		r_PackedHalf2AtPtx2384R607, r_PackedHalf2AtPtx2388R608, r_PackedHalf2AtPtx2392R609,
		r_LaneIndexAtPtx2400, r_PackedHalf2AtPtx2403R611, r_PackedHalf2AtPtx2407R612;
	uint32_t r_PackedHalf2AtPtx2411R613, r_PackedHalf2AtPtx2415R614, r_PackedHalf2AtPtx2419R615,
		r_LaneIndexAtPtx2427, r_PackedHalf2AtPtx2430R617, r_PackedHalf2AtPtx2434R618,
		r_PackedHalf2AtPtx2438R619, r_PackedHalf2AtPtx2442R620, r_PackedHalf2AtPtx2446R621,
		r_LaneIndexAtPtx2454, r_PackedHalf2AtPtx2457R623, r_PackedHalf2AtPtx2461R624;
	uint32_t r_PackedHalf2AtPtx2465R625, r_PackedHalf2AtPtx2469R626, r_PackedHalf2AtPtx2473R627,
		r_LaneIndexAtPtx2481, r_PackedHalf2AtPtx2484R629, r_PackedHalf2AtPtx2488R630,
		r_PackedHalf2AtPtx2492R631, r_PackedHalf2AtPtx2496R632, r_PackedHalf2AtPtx2500R633,
		r_LaneIndexAtPtx2508, r_PackedHalf2AtPtx2511R635, r_PackedHalf2AtPtx2515R636;
	uint32_t r_PackedHalf2AtPtx2519R637, r_PackedHalf2AtPtx2523R638, r_PackedHalf2AtPtx2527R639,
		r_LaneIndexAtPtx2535, r_PackedHalf2AtPtx2538R641, r_PackedHalf2AtPtx2542R642,
		r_PackedHalf2AtPtx2546R643, r_PackedHalf2AtPtx2550R644, r_PackedHalf2AtPtx2554R645,
		r_LaneIndexAtPtx2562, r_PackedHalf2AtPtx2565R647, r_PackedHalf2AtPtx2569R648;
	uint32_t r_PackedHalf2AtPtx2573R649, r_PackedHalf2AtPtx2577R650, r_PackedHalf2AtPtx2581R651,
		r_LaneIndexAtPtx2589, r_PackedHalf2AtPtx2592R653, r_PackedHalf2AtPtx2596R654,
		r_PackedHalf2AtPtx2600R655, r_PackedHalf2AtPtx2604R656, r_PackedHalf2AtPtx2608R657,
		r_LaneIndexAtPtx2616, r_PackedHalf2AtPtx2619R659, r_PackedHalf2AtPtx2623R660;
	uint32_t r_PackedHalf2AtPtx2627R661, r_PackedHalf2AtPtx2631R662, r_PackedHalf2AtPtx2635R663,
		r_LaneIndexAtPtx2643, r_PackedHalf2AtPtx2646R665, r_PackedHalf2AtPtx2650R666,
		r_PackedHalf2AtPtx2654R667, r_PackedHalf2AtPtx2658R668, r_PackedHalf2AtPtx2662R669,
		r_LaneIndexAtPtx2670, r_PackedHalf2AtPtx2673R671, r_PackedHalf2AtPtx2677R672;
	uint32_t r_PackedHalf2AtPtx2681R673, r_PackedHalf2AtPtx2685R674, r_PackedHalf2AtPtx2689R675,
		r_LaneIndexAtPtx2697, r_PackedHalf2AtPtx2700R677, r_PackedHalf2AtPtx2704R678,
		r_PackedHalf2AtPtx2708R679, r_PackedHalf2AtPtx2712R680, r_PackedHalf2AtPtx2716R681,
		r_LaneIndexAtPtx2724, r_PackedHalf2AtPtx2727R683, r_PackedHalf2AtPtx2731R684;
	uint32_t r_PackedHalf2AtPtx2735R685, r_PackedHalf2AtPtx2739R686, r_PackedHalf2AtPtx2743R687,
		r_LaneIndexAtPtx2751, r_PackedHalf2AtPtx2754R689, r_PackedHalf2AtPtx2758R690,
		r_PackedHalf2AtPtx2762R691, r_PackedHalf2AtPtx2766R692, r_PackedHalf2AtPtx2770R693,
		r_LaneIndexAtPtx2778, r_PackedHalf2AtPtx2781R695, r_PackedHalf2AtPtx2785R696;
	uint32_t r_PackedHalf2AtPtx2789R697, r_PackedHalf2AtPtx2793R698, r_PackedHalf2AtPtx2797R699,
		r_LaneIndexAtPtx2805, r_PackedHalf2AtPtx2808R701, r_PackedHalf2AtPtx2812R702,
		r_PackedHalf2AtPtx2816R703, r_PackedHalf2AtPtx2820R704, r_PackedHalf2AtPtx2824R705,
		r_LaneIndexAtPtx2832, r_PackedHalf2AtPtx2835R707, r_PackedHalf2AtPtx2839R708;
	uint32_t r_PackedHalf2AtPtx2843R709, r_PackedHalf2AtPtx2847R710, r_PackedHalf2AtPtx2851R711,
		r_LaneIndexAtPtx2859, r_PackedHalf2AtPtx2862R713, r_PackedHalf2AtPtx2866R714,
		r_PackedHalf2AtPtx2870R715, r_PackedHalf2AtPtx2874R716, r_PackedHalf2AtPtx2878R717,
		r_LaneIndexAtPtx2886, r_PackedHalf2AtPtx2889R719, r_PackedHalf2AtPtx2893R720;
	uint32_t r_PackedHalf2AtPtx2897R721, r_PackedHalf2AtPtx2901R722, r_PackedHalf2AtPtx2905R723,
		r_LaneIndexAtPtx2913, r_PackedHalf2AtPtx2916R725, r_PackedHalf2AtPtx2920R726,
		r_PackedHalf2AtPtx2924R727, r_PackedHalf2AtPtx2928R728, r_PackedHalf2AtPtx2932R729,
		r_LaneIndexAtPtx2940, r_PackedHalf2AtPtx2943R731, r_PackedHalf2AtPtx2947R732;
	uint32_t r_PackedHalf2AtPtx2951R733, r_PackedHalf2AtPtx2955R734, r_PackedHalf2AtPtx2959R735,
		r_LaneIndexAtPtx2967, r_PackedHalf2AtPtx2970R737, r_PackedHalf2AtPtx2974R738,
		r_PackedHalf2AtPtx2978R739, r_PackedHalf2AtPtx2982R740, r_PackedHalf2AtPtx2986R741,
		r_LaneIndexAtPtx2994, r_PackedHalf2AtPtx2997R743, r_PackedHalf2AtPtx3001R744;
	uint32_t r_PackedHalf2AtPtx3005R745, r_PackedHalf2AtPtx3009R746, r_PackedHalf2AtPtx3013R747,
		r_LaneIndexAtPtx3021, r_PackedHalf2AtPtx3024R749, r_PackedHalf2AtPtx3028R750,
		r_PackedHalf2AtPtx3032R751, r_PackedHalf2AtPtx3036R752, r_PackedHalf2AtPtx3040R753,
		r_LaneIndexAtPtx3048, r_PackedHalf2AtPtx3051R755, r_PackedHalf2AtPtx3055R756;
	uint32_t r_PackedHalf2AtPtx3059R757, r_PackedHalf2AtPtx3063R758, r_PackedHalf2AtPtx3067R759,
		r_LaneIndexAtPtx3075, r_PackedHalf2AtPtx3078R761, r_PackedHalf2AtPtx3082R762,
		r_PackedHalf2AtPtx3086R763, r_PackedHalf2AtPtx3090R764, r_PackedHalf2AtPtx3094R765,
		r_LaneIndexAtPtx3102, r_PackedHalf2AtPtx3105R767, r_PackedHalf2AtPtx3109R768;
	uint32_t r_PackedHalf2AtPtx3113R769, r_PackedHalf2AtPtx3117R770, r_PackedHalf2AtPtx3121R771,
		r_LaneIndexAtPtx3129, r_PackedHalf2AtPtx3132R773, r_PackedHalf2AtPtx3136R774,
		r_PackedHalf2AtPtx3140R775, r_PackedHalf2AtPtx3144R776, r_PackedHalf2AtPtx3148R777,
		r_LaneIndexAtPtx3156, r_PackedHalf2AtPtx3159R779, r_PackedHalf2AtPtx3163R780;
	uint32_t r_PackedHalf2AtPtx3167R781, r_PackedHalf2AtPtx3171R782, r_PackedHalf2AtPtx3175R783,
		r_LaneIndexAtPtx3183, r_PackedHalf2AtPtx3186R785, r_PackedHalf2AtPtx3190R786,
		r_PackedHalf2AtPtx3194R787, r_PackedHalf2AtPtx3198R788, r_PackedHalf2AtPtx3202R789,
		r_LaneIndexAtPtx3210, r_PackedHalf2AtPtx3213R791, r_PackedHalf2AtPtx3217R792;
	uint32_t r_PackedHalf2AtPtx3221R793, r_PackedHalf2AtPtx3225R794, r_PackedHalf2AtPtx3229R795,
		r_LaneIndexAtPtx3237, r_PackedHalf2AtPtx3240R797, r_PackedHalf2AtPtx3244R798,
		r_PackedHalf2AtPtx3248R799, r_PackedHalf2AtPtx3252R800, r_PackedHalf2AtPtx3256R801,
		r_LaneIndexAtPtx3264, r_PackedHalf2AtPtx3267R803, r_PackedHalf2AtPtx3271R804;
	uint32_t r_PackedHalf2AtPtx3275R805, r_PackedHalf2AtPtx3279R806, r_PackedHalf2AtPtx3283R807,
		r_LaneIndexAtPtx3291, r_PackedHalf2AtPtx3294R809, r_PackedHalf2AtPtx3298R810,
		r_PackedHalf2AtPtx3302R811, r_PackedHalf2AtPtx3306R812, r_PackedHalf2AtPtx3310R813,
		r_LaneIndexAtPtx3318, r_PackedHalf2AtPtx3321R815, r_PackedHalf2AtPtx3325R816;
	uint32_t r_PackedHalf2AtPtx3329R817, r_PackedHalf2AtPtx3333R818, r_PackedHalf2AtPtx3337R819,
		r_LaneIndexAtPtx3345, r_PackedHalf2AtPtx3348R821, r_PackedHalf2AtPtx3352R822,
		r_PackedHalf2AtPtx3356R823, r_PackedHalf2AtPtx3360R824, r_PackedHalf2AtPtx3364R825,
		r_LaneIndexAtPtx3372, r_PackedHalf2AtPtx3375R827, r_PackedHalf2AtPtx3379R828;
	uint32_t r_PackedHalf2AtPtx3383R829, r_PackedHalf2AtPtx3387R830, r_PackedHalf2AtPtx3391R831,
		r_LaneIndexAtPtx3399, r_PackedHalf2AtPtx3402R833, r_PackedHalf2AtPtx3406R834,
		r_PackedHalf2AtPtx3410R835, r_PackedHalf2AtPtx3414R836, r_PackedHalf2AtPtx3418R837,
		r_LaneIndexAtPtx3426, r_PackedHalf2AtPtx3429R839, r_PackedHalf2AtPtx3433R840;
	uint32_t r_PackedHalf2AtPtx3437R841, r_PackedHalf2AtPtx3441R842, r_PackedHalf2AtPtx3445R843,
		r_LaneIndexAtPtx3453, r_PackedHalf2AtPtx3456R845, r_PackedHalf2AtPtx3460R846,
		r_PackedHalf2AtPtx3464R847, r_PackedHalf2AtPtx3468R848, r_PackedHalf2AtPtx3472R849,
		r_LaneIndexAtPtx3480, r_PackedHalf2AtPtx3483R851, r_PackedHalf2AtPtx3487R852;
	uint32_t r_PackedHalf2AtPtx3491R853, r_PackedHalf2AtPtx3495R854, r_PackedHalf2AtPtx3499R855,
		r_LaneIndexAtPtx3507, r_PackedHalf2AtPtx3510R857, r_PackedHalf2AtPtx3514R858,
		r_PackedHalf2AtPtx3518R859, r_PackedHalf2AtPtx3522R860, r_PackedHalf2AtPtx3526R861,
		r_LaneIndexAtPtx3534, r_PackedHalf2AtPtx3537R863, r_PackedHalf2AtPtx3541R864;
	uint32_t r_PackedHalf2AtPtx3545R865, r_PackedHalf2AtPtx3549R866, r_PackedHalf2AtPtx3553R867,
		r_LaneIndexAtPtx3561, r_PackedHalf2AtPtx3564R869, r_PackedHalf2AtPtx3568R870,
		r_PackedHalf2AtPtx3572R871, r_PackedHalf2AtPtx3576R872, r_PackedHalf2AtPtx3580R873,
		r_LaneIndexAtPtx3588, r_PackedHalf2AtPtx3591R875, r_PackedHalf2AtPtx3595R876;
	uint32_t r_PackedHalf2AtPtx3599R877, r_PackedHalf2AtPtx3603R878, r_PackedHalf2AtPtx3607R879,
		r_LaneIndexAtPtx3615, r_PackedHalf2AtPtx3618R881, r_PackedHalf2AtPtx3622R882,
		r_PackedHalf2AtPtx3626R883, r_PackedHalf2AtPtx3630R884, r_PackedHalf2AtPtx3634R885,
		r_LaneIndexAtPtx3642, r_PackedHalf2AtPtx3645R887, r_PackedHalf2AtPtx3649R888;
	uint32_t r_PackedHalf2AtPtx3653R889, r_PackedHalf2AtPtx3657R890, r_PackedHalf2AtPtx3661R891,
		r_LaneIndexAtPtx3669, r_PackedHalf2AtPtx3672R893, r_PackedHalf2AtPtx3676R894,
		r_PackedHalf2AtPtx3680R895, r_PackedHalf2AtPtx3684R896, r_PackedHalf2AtPtx3688R897,
		r_LaneIndexAtPtx3696, r_PackedHalf2AtPtx3699R899, r_PackedHalf2AtPtx3703R900;
	uint32_t r_PackedHalf2AtPtx3707R901, r_PackedHalf2AtPtx3711R902, r_PackedHalf2AtPtx3715R903,
		r_LaneIndexAtPtx3723, r_PackedHalf2AtPtx3726R905, r_PackedHalf2AtPtx3730R906,
		r_PackedHalf2AtPtx3734R907, r_PackedHalf2AtPtx3738R908, r_PackedHalf2AtPtx3742R909,
		r_LaneIndexAtPtx3750, r_PackedHalf2AtPtx3753R911, r_PackedHalf2AtPtx3757R912;
	uint32_t r_PackedHalf2AtPtx3761R913, r_PackedHalf2AtPtx3765R914, r_PackedHalf2AtPtx3769R915,
		r_LaneIndexAtPtx3777, r_PackedHalf2AtPtx3780R917, r_PackedHalf2AtPtx3784R918,
		r_PackedHalf2AtPtx3788R919, r_PackedHalf2AtPtx3792R920, r_PackedHalf2AtPtx3796R921,
		r_LaneIndexAtPtx3804, r_PackedHalf2AtPtx3807R923, r_PackedHalf2AtPtx3811R924;
	uint32_t r_PackedHalf2AtPtx3815R925, r_PackedHalf2AtPtx3819R926, r_PackedHalf2AtPtx3823R927,
		r_LaneIndexAtPtx3831, r_PackedHalf2AtPtx3834R929, r_PackedHalf2AtPtx3838R930,
		r_PackedHalf2AtPtx3842R931, r_PackedHalf2AtPtx3846R932, r_PackedHalf2AtPtx3850R933,
		r_LaneIndexAtPtx3858, r_PackedHalf2AtPtx3861R935, r_PackedHalf2AtPtx3865R936;
	uint32_t r_PackedHalf2AtPtx3869R937, r_PackedHalf2AtPtx3873R938, r_PackedHalf2AtPtx3877R939,
		r_LaneIndexAtPtx3885, r_PackedHalf2AtPtx3888R941, r_PackedHalf2AtPtx3892R942,
		r_PackedHalf2AtPtx3896R943, r_PackedHalf2AtPtx3900R944, r_PackedHalf2AtPtx3904R945,
		r_LaneIndexAtPtx3912, r_PackedHalf2AtPtx3915R947, r_PackedHalf2AtPtx3919R948;
	uint32_t r_PackedHalf2AtPtx3923R949, r_PackedHalf2AtPtx3927R950, r_PackedHalf2AtPtx3931R951,
		r_PackedHalf2AtPtx2234R952, r_PackedHalf2AtPtx2288R953, r_PackedHalf2AtPtx2261R954,
		r_PackedHalf2AtPtx2315R955, r_PackedHalf2AtPtx2342R956, r_PackedHalf2AtPtx2396R957,
		r_PackedHalf2AtPtx2369R958, r_PackedHalf2AtPtx2423R959, r_PackedHalf2AtPtx2450R960;
	uint32_t r_PackedHalf2AtPtx2504R961, r_PackedHalf2AtPtx2477R962, r_PackedHalf2AtPtx2531R963,
		r_PackedHalf2AtPtx2558R964, r_PackedHalf2AtPtx2612R965, r_PackedHalf2AtPtx2585R966,
		r_PackedHalf2AtPtx2639R967, r_PackedHalf2AtPtx2666R968, r_PackedHalf2AtPtx2720R969,
		r_PackedHalf2AtPtx2693R970, r_PackedHalf2AtPtx2747R971, r_PackedHalf2AtPtx2774R972;
	uint32_t r_PackedHalf2AtPtx2828R973, r_PackedHalf2AtPtx2801R974, r_PackedHalf2AtPtx2855R975,
		r_PackedHalf2AtPtx2882R976, r_PackedHalf2AtPtx2936R977, r_PackedHalf2AtPtx2909R978,
		r_PackedHalf2AtPtx2963R979, r_PackedHalf2AtPtx2990R980, r_PackedHalf2AtPtx3044R981,
		r_PackedHalf2AtPtx3017R982, r_PackedHalf2AtPtx3071R983, r_PackedHalf2AtPtx3098R984;
	uint32_t r_PackedHalf2AtPtx3152R985, r_PackedHalf2AtPtx3125R986, r_PackedHalf2AtPtx3179R987,
		r_PackedHalf2AtPtx3206R988, r_PackedHalf2AtPtx3260R989, r_PackedHalf2AtPtx3233R990,
		r_PackedHalf2AtPtx3287R991, r_PackedHalf2AtPtx3314R992, r_PackedHalf2AtPtx3368R993,
		r_PackedHalf2AtPtx3341R994, r_PackedHalf2AtPtx3395R995, r_PackedHalf2AtPtx3422R996;
	uint32_t r_PackedHalf2AtPtx3476R997, r_PackedHalf2AtPtx3449R998, r_PackedHalf2AtPtx3503R999,
		r_PackedHalf2AtPtx3530R1000, r_PackedHalf2AtPtx3584R1001, r_PackedHalf2AtPtx3557R1002,
		r_PackedHalf2AtPtx3611R1003, r_PackedHalf2AtPtx3638R1004, r_PackedHalf2AtPtx3692R1005,
		r_PackedHalf2AtPtx3665R1006, r_PackedHalf2AtPtx3719R1007, r_PackedHalf2AtPtx3746R1008;
	uint32_t r_PackedHalf2AtPtx3800R1009, r_PackedHalf2AtPtx3773R1010, r_PackedHalf2AtPtx3827R1011,
		r_PackedHalf2AtPtx3854R1012, r_PackedHalf2AtPtx3908R1013, r_PackedHalf2AtPtx3881R1014,
		r_PackedHalf2AtPtx3935R1015, r_PtxRegister1016, r_PtxRegister1017, r_PtxRegister1018,
		r_LaneIndexAtPtx4147, r_PackedE4WordAtPtx4145R1020;
	uint32_t r_PackedE4WordAtPtx4144R1021, r_PackedE4WordAtPtx4143R1022, r_PackedE4WordAtPtx4142R1023,
		r_LaneIndexAtPtx4155, r_PackedE4WordAtPtx4141R1025, r_PackedE4WordAtPtx4140R1026,
		r_PackedE4WordAtPtx4139R1027, r_PackedE4WordAtPtx4138R1028, r_PtxRegister1029, r_LaneIndexAtPtx4169,
		r_PackedE4WordAtPtx4176R1031, r_PackedE4WordAtPtx4175R1032;
	uint32_t r_PackedE4WordAtPtx4174R1033, r_PackedE4WordAtPtx4173R1034, r_LaneIndexAtPtx4181,
		r_PackedE4WordAtPtx4189R1036, r_PackedE4WordAtPtx4188R1037, r_PackedE4WordAtPtx4187R1038,
		r_PackedE4WordAtPtx4186R1039, r_PtxRegister1040, r_LaneIndexAtPtx4199, r_PackedE4WordAtPtx4206R1042,
		r_PackedE4WordAtPtx4205R1043, r_PackedE4WordAtPtx4204R1044;
	uint32_t r_PackedE4WordAtPtx4203R1045, r_LaneIndexAtPtx4211, r_PackedE4WordAtPtx4219R1047,
		r_PackedE4WordAtPtx4218R1048, r_PackedE4WordAtPtx4217R1049, r_PackedE4WordAtPtx4216R1050,
		r_PtxRegister1051, r_LaneIndexAtPtx4228, r_PackedE4WordAtPtx4236R1053, r_PackedE4WordAtPtx4235R1054,
		r_PackedE4WordAtPtx4234R1055, r_PackedE4WordAtPtx4233R1056;
	uint32_t r_LaneIndexAtPtx4241, r_PackedE4WordAtPtx4249R1058, r_PackedE4WordAtPtx4248R1059,
		r_PackedE4WordAtPtx4247R1060, r_PackedE4WordAtPtx4246R1061, r_PtxRegister1062, r_PtxRegister1063,
		r_PtxRegister1064, r_PtxRegister1065, r_PtxRegister1066, r_PtxRegister1067, r_PtxRegister1068;
	uint32_t r_PtxRegister1069, r_PtxRegister1070, r_PtxRegister1071, r_PtxRegister1072, r_PtxRegister1073,
		r_PackedHalf2AtPtx59R1074, r_MmaAccumulatorHalf2WordAtPtx1162R1075,
		r_MmaAccumulatorHalf2WordAtPtx1163R1076, r_MmaAccumulatorHalf2WordAtPtx1164R1077,
		r_MmaAccumulatorHalf2WordAtPtx1165R1078, r_MmaAccumulatorHalf2WordAtPtx1166R1079,
		r_MmaAccumulatorHalf2WordAtPtx1167R1080;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1168R1081, r_MmaAccumulatorHalf2WordAtPtx1169R1082,
		r_MmaAccumulatorHalf2WordAtPtx1170R1083, r_MmaAccumulatorHalf2WordAtPtx1171R1084,
		r_MmaAccumulatorHalf2WordAtPtx1172R1085, r_MmaAccumulatorHalf2WordAtPtx1173R1086,
		r_MmaAccumulatorHalf2WordAtPtx1174R1087, r_MmaAccumulatorHalf2WordAtPtx1175R1088,
		r_MmaAccumulatorHalf2WordAtPtx1176R1089, r_MmaAccumulatorHalf2WordAtPtx1177R1090,
		r_MmaAccumulatorHalf2WordAtPtx1178R1091, r_MmaAccumulatorHalf2WordAtPtx1179R1092;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1180R1093, r_MmaAccumulatorHalf2WordAtPtx1181R1094,
		r_MmaAccumulatorHalf2WordAtPtx1182R1095, r_MmaAccumulatorHalf2WordAtPtx1183R1096,
		r_MmaAccumulatorHalf2WordAtPtx1184R1097, r_MmaAccumulatorHalf2WordAtPtx1185R1098,
		r_MmaAccumulatorHalf2WordAtPtx1186R1099, r_MmaAccumulatorHalf2WordAtPtx1187R1100,
		r_MmaAccumulatorHalf2WordAtPtx1188R1101, r_MmaAccumulatorHalf2WordAtPtx1189R1102,
		r_MmaAccumulatorHalf2WordAtPtx1190R1103, r_MmaAccumulatorHalf2WordAtPtx1191R1104;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1192R1105, r_MmaAccumulatorHalf2WordAtPtx1193R1106,
		r_MmaAccumulatorHalf2WordAtPtx1194R1107, r_MmaAccumulatorHalf2WordAtPtx1195R1108,
		r_MmaAccumulatorHalf2WordAtPtx1196R1109, r_MmaAccumulatorHalf2WordAtPtx1197R1110,
		r_MmaAccumulatorHalf2WordAtPtx1198R1111, r_MmaAccumulatorHalf2WordAtPtx1199R1112,
		r_MmaAccumulatorHalf2WordAtPtx1200R1113, r_MmaAccumulatorHalf2WordAtPtx1201R1114,
		r_MmaAccumulatorHalf2WordAtPtx1202R1115, r_MmaAccumulatorHalf2WordAtPtx1203R1116;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1204R1117, r_MmaAccumulatorHalf2WordAtPtx1205R1118,
		r_MmaAccumulatorHalf2WordAtPtx1206R1119, r_MmaAccumulatorHalf2WordAtPtx1207R1120,
		r_MmaAccumulatorHalf2WordAtPtx1208R1121, r_MmaAccumulatorHalf2WordAtPtx1209R1122,
		r_MmaAccumulatorHalf2WordAtPtx1210R1123, r_MmaAccumulatorHalf2WordAtPtx1211R1124,
		r_MmaAccumulatorHalf2WordAtPtx1212R1125, r_MmaAccumulatorHalf2WordAtPtx1213R1126,
		r_MmaAccumulatorHalf2WordAtPtx1214R1127, r_MmaAccumulatorHalf2WordAtPtx1215R1128;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1216R1129, r_MmaAccumulatorHalf2WordAtPtx1217R1130,
		r_MmaAccumulatorHalf2WordAtPtx1218R1131, r_MmaAccumulatorHalf2WordAtPtx1219R1132,
		r_MmaAccumulatorHalf2WordAtPtx1220R1133, r_MmaAccumulatorHalf2WordAtPtx1221R1134,
		r_MmaAccumulatorHalf2WordAtPtx1222R1135, r_MmaAccumulatorHalf2WordAtPtx1223R1136,
		r_MmaAccumulatorHalf2WordAtPtx1224R1137, r_PtxRegister1138, r_MmaBE4x4WordAtPtx133R1139,
		r_MmaBE4x4WordAtPtx133R1140;
	uint32_t r_MmaBE4x4WordAtPtx124R1141, r_MmaBE4x4WordAtPtx124R1142, r_MmaBE4x4WordAtPtx124R1143,
		r_MmaBE4x4WordAtPtx124R1144, r_MmaBE4x4WordAtPtx115R1145, r_MmaBE4x4WordAtPtx115R1146,
		r_MmaBE4x4WordAtPtx115R1147, r_MmaBE4x4WordAtPtx115R1148, r_MmaBE4x4WordAtPtx106R1149,
		r_MmaBE4x4WordAtPtx106R1150, r_MmaBE4x4WordAtPtx106R1151, r_MmaBE4x4WordAtPtx106R1152;
	uint32_t r_MmaBE4x4WordAtPtx97R1153, r_MmaBE4x4WordAtPtx97R1154, r_MmaBE4x4WordAtPtx97R1155,
		r_MmaBE4x4WordAtPtx97R1156, r_MmaBE4x4WordAtPtx88R1157, r_MmaBE4x4WordAtPtx88R1158,
		r_MmaBE4x4WordAtPtx88R1159, r_MmaBE4x4WordAtPtx88R1160, r_MmaBE4x4WordAtPtx79R1161,
		r_MmaBE4x4WordAtPtx79R1162, r_MmaBE4x4WordAtPtx79R1163, r_MmaBE4x4WordAtPtx79R1164;
	uint32_t r_MmaBE4x4WordAtPtx133R1165, r_MmaBE4x4WordAtPtx133R1166, r_MmaBE4x4WordAtPtx142R1167,
		r_MmaBE4x4WordAtPtx142R1168, r_MmaBE4x4WordAtPtx142R1169, r_MmaBE4x4WordAtPtx142R1170,
		r_PtxRegister1171, r_PtxRegister1172, r_PtxRegister1173;
	uint64_t g_StateBaseAddress, g_OutputBaseAddress, g_RecordBaseAddress, r_PtxU64Register4,
		r_PtxU64Register5, r_PtxU64Register6, g_OutputByteAddressAtPtx4136, g_OutputByteAddressAtPtx4166,
		g_OutputByteAddressAtPtx4196, g_RecordByteAddressAtPtx77, g_RecordByteAddressAtPtx86,
		g_RecordByteAddressAtPtx95;
	uint64_t g_RecordByteAddressAtPtx104, g_RecordByteAddressAtPtx113, g_RecordByteAddressAtPtx122,
		g_RecordByteAddressAtPtx131, g_RecordByteAddressAtPtx140, r_PtxU64Register18,
		g_RecordByteAddressAtPtx72, r_PtxU64Register20, r_PtxU64Register21, g_RecordByteAddressAtPtx85,
		r_PtxU64Register23, g_RecordByteAddressAtPtx94;
	uint64_t r_PtxU64Register25, g_RecordByteAddressAtPtx103, r_PtxU64Register27, g_RecordByteAddressAtPtx112,
		r_PtxU64Register29, g_RecordByteAddressAtPtx121, r_PtxU64Register31, g_RecordByteAddressAtPtx130,
		r_PtxU64Register33, g_RecordByteAddressAtPtx139, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		r_PtxU64Register46, r_PtxU64Register47, r_PtxU64Register48;
	uint64_t r_PtxU64Register49, r_PtxU64Register50, r_PtxU64Register51, r_PtxU64Register52,
		r_PtxU64Register53, r_PtxU64Register54, r_PtxU64Register55, r_PtxU64Register56, r_PtxU64Register57,
		r_PtxU64Register58, r_PtxU64Register59, r_PtxU64Register60;
	uint64_t r_PtxU64Register61, r_PtxU64Register62, r_PtxU64Register63, r_PtxU64Register64,
		r_PtxU64Register65, r_PtxU64Register66, r_PtxU64Register67, r_PtxU64Register68, r_PtxU64Register69,
		r_PtxU64Register70, r_PtxU64Register71, r_PtxU64Register72;
	uint64_t r_PtxU64Register73, r_PtxU64Register74, r_PtxU64Register75, r_PtxU64Register76,
		r_PtxU64Register77, r_PtxU64Register78, r_PtxU64Register79, r_PtxU64Register80,
		g_RecordByteAddressAtPtx1772, g_RecordByteAddressAtPtx1781, g_RecordByteAddressAtPtx1790,
		g_RecordByteAddressAtPtx1799;
	uint64_t g_RecordByteAddressAtPtx1808, g_RecordByteAddressAtPtx1817, g_RecordByteAddressAtPtx1826,
		g_RecordByteAddressAtPtx1835, r_PtxU64Register89, g_RecordByteAddressAtPtx1767, r_PtxU64Register91,
		r_PtxU64Register92, g_RecordByteAddressAtPtx1780, r_PtxU64Register94, g_RecordByteAddressAtPtx1789,
		r_PtxU64Register96;
	uint64_t g_RecordByteAddressAtPtx1798, r_PtxU64Register98, g_RecordByteAddressAtPtx1807,
		r_PtxU64Register100, g_RecordByteAddressAtPtx1816, r_PtxU64Register102, g_RecordByteAddressAtPtx1825,
		r_PtxU64Register104, g_RecordByteAddressAtPtx1834, r_PtxU64Register106, r_PtxU64Register107,
		r_PtxU64Register108;
	uint64_t r_PtxU64Register109, r_PtxU64Register110, r_PtxU64Register111, r_PtxU64Register112,
		r_PtxU64Register113, r_PtxU64Register114, r_PtxU64Register115, r_PtxU64Register116,
		r_PtxU64Register117, r_PtxU64Register118, r_PtxU64Register119, r_PtxU64Register120;
	uint64_t r_PtxU64Register121, r_PtxU64Register122, r_PtxU64Register123, r_PtxU64Register124,
		g_OutputByteAddressAtPtx4150, g_OutputByteAddressAtPtx4159, r_PtxU64Register127, r_PtxU64Register128,
		g_OutputByteAddressAtPtx4158, g_OutputByteAddressAtPtx4172, g_OutputByteAddressAtPtx4185,
		r_PtxU64Register132;
	uint64_t r_PtxU64Register133, g_OutputByteAddressAtPtx4184, g_OutputByteAddressAtPtx4202,
		g_OutputByteAddressAtPtx4215, r_PtxU64Register137, r_PtxU64Register138, g_OutputByteAddressAtPtx4214,
		g_OutputByteAddressAtPtx4232, g_OutputByteAddressAtPtx4245, r_PtxU64Register142,
		g_OutputByteAddressAtPtx4231, r_PtxU64Register144;
	uint64_t g_OutputByteAddressAtPtx4244, r_PtxU64Register146, r_PtxU64Register147, r_PtxU64Register148,
		r_PtxU64Register149, r_PtxU64Register150, r_PtxU64Register151, r_PtxU64Register152,
		r_PtxU64Register153, r_PtxU64Register154, r_PtxU64Register155, r_PtxU64Register156;
	uint64_t r_PtxU64Register157, r_PtxU64Register158, r_PtxU64Register159, r_PtxU64Register160,
		r_PtxU64Register161, r_PtxU64Register162, r_PtxU64Register163, r_PtxU64Register164,
		r_PtxU64Register165, r_PtxU64Register166, r_PtxU64Register167, r_PtxU64Register168;
	uint64_t r_PtxU64Register169, r_PtxU64Register170, r_PtxU64Register171, r_PtxU64Register172,
		r_PtxU64Register173, r_PtxU64Register174, r_PtxU64Register175, r_PtxU64Register176,
		r_PtxU64Register177;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);   // PTX L14
	g_OutputBaseAddress = uint64_t(r_Parameters.g_High);   // PTX L15
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record); // PTX L16
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);									 // PTX L17
	r_CtaX = uint32_t(blockIdx.x);													 // PTX L18
	r_CtaZ = uint32_t(blockIdx.z);													 // PTX L19
	r_PtxRegister53 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits) + uint32_t(-1); // PTX L20
	r_PtxRegister54 = ShiftRightSigned(int32_t(r_PtxRegister53), uint32_t(31));		 // PTX L21
	r_PtxRegister55 = ShiftRight(uint32_t(r_PtxRegister54), uint32_t(25));			 // PTX L22
	r_PtxRegister56 = uint32_t(r_PtxRegister53) + uint32_t(r_PtxRegister55);		 // PTX L23
	r_PtxRegister57 = ShiftRightSigned(int32_t(r_PtxRegister56), uint32_t(7));		 // PTX L24
	r_PtxRegister58 = uint32_t(r_PtxRegister57) + uint32_t(1);						 // PTX L25
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister58));			 // PTX L26
	r_PtxRegister59 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister57) + uint32_t(r_PtxRegister2); // PTX L27
	r_PtxRegister60 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister59);						 // PTX L28
	r_PtxRegister3 = ShiftLeft(uint32_t(r_PtxRegister60), uint32_t(3));					 // PTX L29
	r_PtxRegister61 = ShiftRight(uint32_t(r_PtxRegister54), uint32_t(27));				 // PTX L30
	r_PtxRegister62 = uint32_t(r_PtxRegister53) + uint32_t(r_PtxRegister61);			 // PTX L31
	r_PtxRegister63 = r_PtxRegister62 & -32;											 // PTX L32
	r_PtxRegister64 = uint32_t(r_PtxRegister63) + uint32_t(32);							 // PTX L33
	r_PtxRegister4 = ShiftRightSigned(int32_t(r_PtxRegister64), uint32_t(4));			 // PTX L34
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L35
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L36
	r_PtxRegister66 = r_ThreadX | r_ThreadY;											 // PTX L37
	r_bPtxPredicate1 = uint32_t(r_PtxRegister66) != uint32_t(0);						 // PTX L38
	if (r_bPtxPredicate1)
	{
		goto L__BB41_2;
	} // PTX L39
	r_BlockSizeX = uint32_t(blockDim.x);							   // PTX L40
	r_BlockSizeY = uint32_t(blockDim.y);							   // PTX L41
	r_PtxRegister68 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY); // PTX L42
	r_PtxRegister67 = uint32_t(24576u /* native mbarriers */);		   // PTX L43
	// Original staged-copy barrier initialization.
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister67, r_PtxRegister68); // PTX L45
	r_PtxRegister69 = uint32_t(r_PtxRegister67) + uint32_t(8);		// PTX L47
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister69, r_PtxRegister68); // PTX L49
	r_PtxRegister70 = uint32_t(r_PtxRegister67) + uint32_t(16);		// PTX L51
	// Original staged-copy barrier initialization.
	BarrierInit(s_SharedStorage, r_PtxRegister70, r_PtxRegister68); // PTX L53
L__BB41_2:															// PTX L55
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L56
	r_Float32BitsAtPtx57R73 = uint32_t(0);														// PTX L57
	r_PackedHalf2AtPtx59R1074 = FloatToHalf2(r_Float32BitsAtPtx57R73);							// PTX L59
	r_PtxRegister82 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L64
	r_PtxRegister83 = r_PtxRegister82 & 64;														// PTX L65
	r_PtxRegister84 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(7));							// PTX L66
	r_PtxRegister6 = r_PtxRegister83 | r_PtxRegister84;											// PTX L67
	r_PtxRegister85 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(20));								// PTX L68
	r_PtxRegister7 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(3));							// PTX L69
	r_PtxRegister86 = uint32_t(r_PtxRegister85) + uint32_t(r_PtxRegister7);						// PTX L70
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_PtxRegister86)) * int64_t(int32_t(4)));		// PTX L71
	g_RecordByteAddressAtPtx72 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register18);	// PTX L72
	r_LaneIndexAtPtx74 = uint32_t((threadIdx.x & 31u));											// PTX L74
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx74)) * int64_t(int32_t(16))); // PTX L76
	g_RecordByteAddressAtPtx77 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register20); // PTX L77
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx77));
		r_MmaBE4x4WordAtPtx79R1164 = r_Value.x;
		r_MmaBE4x4WordAtPtx79R1163 = r_Value.y;
		r_MmaBE4x4WordAtPtx79R1162 = r_Value.z;
		r_MmaBE4x4WordAtPtx79R1161 = r_Value.w;
	} // PTX L79
	r_LaneIndexAtPtx82 = uint32_t((threadIdx.x & 31u));											// PTX L82
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx82)) * int64_t(int32_t(16))); // PTX L84
	g_RecordByteAddressAtPtx85 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register21);		   // PTX L85
	g_RecordByteAddressAtPtx86 = uint64_t(g_RecordByteAddressAtPtx85) + uint64_t(512); // PTX L86
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx86));
		r_MmaBE4x4WordAtPtx88R1160 = r_Value.x;
		r_MmaBE4x4WordAtPtx88R1159 = r_Value.y;
		r_MmaBE4x4WordAtPtx88R1158 = r_Value.z;
		r_MmaBE4x4WordAtPtx88R1157 = r_Value.w;
	} // PTX L88
	r_LaneIndexAtPtx91 = uint32_t((threadIdx.x & 31u));											// PTX L91
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx91)) * int64_t(int32_t(16))); // PTX L93
	g_RecordByteAddressAtPtx94 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register23);			// PTX L94
	g_RecordByteAddressAtPtx95 = uint64_t(g_RecordByteAddressAtPtx94) + uint64_t(1024); // PTX L95
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx95));
		r_MmaBE4x4WordAtPtx97R1156 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R1155 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R1154 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R1153 = r_Value.w;
	} // PTX L97
	r_LaneIndexAtPtx100 = uint32_t((threadIdx.x & 31u));										 // PTX L100
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx100)) * int64_t(int32_t(16))); // PTX L102
	g_RecordByteAddressAtPtx103 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register25);			  // PTX L103
	g_RecordByteAddressAtPtx104 = uint64_t(g_RecordByteAddressAtPtx103) + uint64_t(1536); // PTX L104
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx104));
		r_MmaBE4x4WordAtPtx106R1152 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R1151 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R1150 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R1149 = r_Value.w;
	} // PTX L106
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	g_RecordByteAddressAtPtx112 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register27);				// PTX L112
	g_RecordByteAddressAtPtx113 = uint64_t(g_RecordByteAddressAtPtx112) + uint64_t(131072); // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx113));
		r_MmaBE4x4WordAtPtx115R1148 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R1147 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R1146 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R1145 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	g_RecordByteAddressAtPtx121 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register29);				// PTX L121
	g_RecordByteAddressAtPtx122 = uint64_t(g_RecordByteAddressAtPtx121) + uint64_t(131584); // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx122));
		r_MmaBE4x4WordAtPtx124R1144 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R1143 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R1142 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R1141 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register31 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	g_RecordByteAddressAtPtx130 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register31);				// PTX L130
	g_RecordByteAddressAtPtx131 = uint64_t(g_RecordByteAddressAtPtx130) + uint64_t(132096); // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx131));
		r_MmaBE4x4WordAtPtx133R1140 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R1139 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R1165 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R1166 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register33 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	g_RecordByteAddressAtPtx139 =
		uint64_t(g_RecordByteAddressAtPtx72) + uint64_t(r_PtxU64Register33);				// PTX L139
	g_RecordByteAddressAtPtx140 = uint64_t(g_RecordByteAddressAtPtx139) + uint64_t(132608); // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx140));
		r_MmaBE4x4WordAtPtx142R1167 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R1168 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R1169 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R1170 = r_Value.w;
	} // PTX L142
	r_PtxRegister8 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(8));					 // PTX L144
	r_PtxRegister9 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister3);				 // PTX L145
	r_bPtxPredicate2 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);			 // PTX L146
	r_bPtxPredicate3 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);			 // PTX L147
	r_PtxRegister87 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(12));					 // PTX L148
	r_PtxRegister10 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(12));			 // PTX L149
	r_PtxRegister11 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister87);		 // PTX L150
	r_PtxRegister12 = r_bPtxPredicate3 ? r_PtxRegister11 : 0;						 // PTX L151
	r_PtxU64Register35 = uint64_t(uint32_t(r_PtxRegister8)) * uint64_t(uint32_t(4)); // PTX L152
	r_PtxRegister88 = uint32_t(0u /* native shared input */);						 // PTX L153
	r_PtxU64Register36 = uint64_t(r_PtxRegister88);									 // PTX L154
	r_PtxU64Register37 = SharedGeneric(s_SharedStorage, r_PtxU64Register36);		 // PTX L155
	r_PtxU64Register4 = uint64_t(r_PtxU64Register37) + uint64_t(r_PtxU64Register35); // PTX L156
	r_PtxU16Register116 = uint16_t(0);												 // PTX L157
	r_PtxU64Register146 = uint64_t(0);												 // PTX L158
	r_PtxRegister1062 = uint32_t(128);												 // PTX L159
	r_PtxRegister1063 = uint32_t(r_PtxRegister1062);								 // PTX L160
	r_PtxU64Register147 = uint64_t(r_PtxU64Register146);							 // PTX L161
	if (r_bPtxPredicate2)
	{
		goto L__BB41_4;
	} // PTX L162
	r_PtxU64Register38 = uint64_t(int64_t(int32_t(r_PtxRegister12)) * int64_t(int32_t(4))); // PTX L163
	r_PtxU64Register146 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register38);		// PTX L164
	r_PtxRegister1063 = uint32_t(r_PtxRegister8) + uint32_t(128);							// PTX L165
	r_PtxRegister1062 = uint32_t(r_PtxRegister12) + uint32_t(128);							// PTX L166
	r_PtxU16Register116 = uint16_t(1);														// PTX L167
	r_PtxU64Register147 = uint64_t(r_PtxU64Register4);										// PTX L168
L__BB41_4:																					// PTX L169
	r_bPtxPredicate4 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L170
	if (r_bPtxPredicate4)
	{
		goto L__BB41_6;
	} // PTX L171
	r_PtxRegister89 = uint32_t(r_PtxRegister8) + uint32_t(128);					 // PTX L172
	r_PtxRegister90 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);				 // PTX L173
	r_PtxRegister91 = ShiftLeft(uint32_t(r_PtxRegister90), uint32_t(12));		 // PTX L174
	r_PtxRegister92 = r_PtxRegister91 | 128;									 // PTX L175
	r_bPtxPredicate5 = uint32_t(r_PtxRegister89) == uint32_t(r_PtxRegister1063); // PTX L176
	r_bPtxPredicate6 = uint32_t(r_PtxRegister92) == uint32_t(r_PtxRegister1062); // PTX L177
	r_PtxU16Register1 = r_bPtxPredicate6 ? r_PtxU16Register116 : 0;				 // PTX L178
	r_PtxU16Register116 = r_bPtxPredicate5 ? r_PtxU16Register1 : 0;				 // PTX L179
L__BB41_6:																		 // PTX L180
	r_bPtxPredicate7 = uint16_t(r_PtxU16Register116) == uint16_t(0);			 // PTX L181
	if (r_bPtxPredicate7)
	{
		goto L__BB41_9;
	} // PTX L182
	r_PtxRegister94 = uint32_t(-1);								 // PTX L183
	r_PtxRegister93 = Elected(r_PtxRegister94);					 // PTX L185
	r_bPtxPredicate8 = uint32_t(r_PtxRegister93) == uint32_t(0); // PTX L191
	if (r_bPtxPredicate8)
	{
		goto L__BB41_21;
	} // PTX L192
	r_PtxU64Register40 = SharedOffset(s_SharedStorage, r_PtxU64Register147); // PTX L193
	r_PtxRegister95 = uint32_t(r_PtxU64Register40);							 // PTX L194
	r_PtxU64Register39 = r_PtxU64Register146;								 // PTX L195
	r_PtxRegister97 = uint32_t(24576u /* native mbarriers */);				 // PTX L196
	r_PtxRegister96 = uint32_t(1024);										 // PTX L197
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister95, r_PtxU64Register39, r_PtxRegister96,
			 r_PtxRegister97);											   // PTX L199
	BarrierExpect(s_SharedStorage, r_PtxRegister97, r_PtxRegister96);	   // PTX L202
	goto L__BB41_21;													   // PTX L204
L__BB41_9:																   // PTX L205
	r_bPtxPredicate9 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L206
	r_PtxU64Register148 = uint64_t(0);									   // PTX L207
	if (r_bPtxPredicate9)
	{
		goto L__BB41_11;
	} // PTX L208
	r_PtxU64Register41 = uint64_t(int64_t(int32_t(r_PtxRegister12)) * int64_t(int32_t(4))); // PTX L209
	r_PtxU64Register148 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register41);		// PTX L210
L__BB41_11:																					// PTX L211
	r_PtxRegister98 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));						// PTX L212
	r_PtxRegister99 = uint32_t(0u /* native shared input */);								// PTX L213
	r_PtxRegister13 = uint32_t(r_PtxRegister99) + uint32_t(r_PtxRegister98);				// PTX L214
	if (r_bPtxPredicate9)
	{
		goto L__BB41_14;
	} // PTX L215
	r_PtxRegister107 = uint32_t(-1);							   // PTX L216
	r_PtxRegister106 = Elected(r_PtxRegister107);				   // PTX L218
	r_bPtxPredicate10 = uint32_t(r_PtxRegister106) == uint32_t(0); // PTX L224
	if (r_bPtxPredicate10)
	{
		goto L__BB41_15;
	} // PTX L225
	r_PtxU64Register42 = r_PtxU64Register148;					// PTX L226
	r_PtxRegister109 = uint32_t(24576u /* native mbarriers */); // PTX L227
	r_PtxRegister108 = uint32_t(512);							// PTX L228
	CopyBulk(s_SharedStorage, r_PtxRegister13, r_PtxU64Register42, r_PtxRegister108,
			 r_PtxRegister109);																  // PTX L230
	BarrierExpect(s_SharedStorage, r_PtxRegister109, r_PtxRegister108);						  // PTX L233
	goto L__BB41_15;																		  // PTX L235
L__BB41_14:																					  // PTX L236
	r_PtxRegister100 = uint32_t(0);															  // PTX L237
	r_PtxU16Register2 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister100))); // PTX L239
	r_PackedHalf2AtPtx242R101 = JoinHalfwords(r_PtxU16Register2, r_PtxU16Register2);		  // PTX L242
	r_ConvertedE4PairAtPtx244Rs3 = PublishE4(r_PackedHalf2AtPtx242R101);					  // PTX L244
	r_PackedE4WordAtPtx246R104 =
		JoinHalfwords(r_ConvertedE4PairAtPtx244Rs3, r_ConvertedE4PairAtPtx244Rs3); // PTX L246
	r_LaneIndexAtPtx248 = uint32_t((threadIdx.x & 31u));						   // PTX L248
	r_PtxRegister105 = ShiftLeft(uint32_t(r_LaneIndexAtPtx248), uint32_t(4));	   // PTX L250
	r_PtxRegister103 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister105);	   // PTX L251
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister103)) =
		make_uint4(r_PackedE4WordAtPtx246R104, r_PackedE4WordAtPtx246R104, r_PackedE4WordAtPtx246R104,
				   r_PackedE4WordAtPtx246R104);								// PTX L253
L__BB41_15:																	// PTX L255
	r_bPtxPredicate11 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L256
	r_bPtxPredicate12 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L257
	r_PtxRegister110 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);			// PTX L258
	r_PtxRegister111 = ShiftLeft(uint32_t(r_PtxRegister110), uint32_t(12)); // PTX L259
	r_PtxRegister112 = r_PtxRegister111 | 128;								// PTX L260
	r_PtxRegister14 = r_bPtxPredicate12 ? r_PtxRegister112 : 0;				// PTX L261
	r_PtxU64Register149 = uint64_t(0);										// PTX L262
	if (r_bPtxPredicate11)
	{
		goto L__BB41_17;
	} // PTX L263
	r_PtxU64Register43 = uint64_t(int64_t(int32_t(r_PtxRegister14)) * int64_t(int32_t(4))); // PTX L264
	r_PtxU64Register149 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register43);		// PTX L265
L__BB41_17:																					// PTX L266
	if (r_bPtxPredicate11)
	{
		goto L__BB41_20;
	} // PTX L267
	r_PtxRegister121 = uint32_t(-1);							   // PTX L268
	r_PtxRegister120 = Elected(r_PtxRegister121);				   // PTX L270
	r_bPtxPredicate13 = uint32_t(r_PtxRegister120) == uint32_t(0); // PTX L276
	if (r_bPtxPredicate13)
	{
		goto L__BB41_21;
	} // PTX L277
	r_PtxRegister122 = uint32_t(r_PtxRegister13) + uint32_t(512); // PTX L278
	r_PtxU64Register44 = r_PtxU64Register149;					  // PTX L279
	r_PtxRegister124 = uint32_t(24576u /* native mbarriers */);	  // PTX L280
	r_PtxRegister123 = uint32_t(512);							  // PTX L281
	CopyBulk(s_SharedStorage, r_PtxRegister122, r_PtxU64Register44, r_PtxRegister123,
			 r_PtxRegister124);																  // PTX L283
	BarrierExpect(s_SharedStorage, r_PtxRegister124, r_PtxRegister123);						  // PTX L286
	goto L__BB41_21;																		  // PTX L288
L__BB41_20:																					  // PTX L289
	r_PtxRegister113 = uint32_t(0);															  // PTX L290
	r_PtxU16Register4 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister113))); // PTX L292
	r_PackedHalf2AtPtx295R114 = JoinHalfwords(r_PtxU16Register4, r_PtxU16Register4);		  // PTX L295
	r_ConvertedE4PairAtPtx297Rs5 = PublishE4(r_PackedHalf2AtPtx295R114);					  // PTX L297
	r_PackedE4WordAtPtx299R117 =
		JoinHalfwords(r_ConvertedE4PairAtPtx297Rs5, r_ConvertedE4PairAtPtx297Rs5); // PTX L299
	r_LaneIndexAtPtx301 = uint32_t((threadIdx.x & 31u));						   // PTX L301
	r_PtxRegister118 = ShiftLeft(uint32_t(r_LaneIndexAtPtx301), uint32_t(4));	   // PTX L303
	r_PtxRegister119 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister118);	   // PTX L304
	r_PtxRegister116 = uint32_t(r_PtxRegister119) + uint32_t(512);				   // PTX L305
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister116)) =
		make_uint4(r_PackedE4WordAtPtx299R117, r_PackedE4WordAtPtx299R117, r_PackedE4WordAtPtx299R117,
				   r_PackedE4WordAtPtx299R117);								 // PTX L307
L__BB41_21:																	 // PTX L309
	r_PtxRegister15 = uint32_t(r_PtxRegister8) + uint32_t(1024);			 // PTX L310
	r_PtxRegister16 = uint32_t(r_PtxRegister9) + uint32_t(4);				 // PTX L311
	r_bPtxPredicate14 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L312
	r_bPtxPredicate15 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L313
	r_PtxRegister17 = uint32_t(r_PtxRegister11) + uint32_t(16384);			 // PTX L314
	r_PtxRegister18 = r_bPtxPredicate15 ? r_PtxRegister17 : 0;				 // PTX L315
	r_PtxU16Register117 = uint16_t(0);										 // PTX L316
	r_PtxU64Register150 = uint64_t(0);										 // PTX L317
	r_PtxRegister1064 = uint32_t(128);										 // PTX L318
	r_PtxRegister1065 = uint32_t(r_PtxRegister1064);						 // PTX L319
	r_PtxU64Register151 = uint64_t(r_PtxU64Register150);					 // PTX L320
	if (r_bPtxPredicate14)
	{
		goto L__BB41_23;
	} // PTX L321
	r_PtxU64Register151 = uint64_t(r_PtxU64Register4) + uint64_t(4096);						// PTX L322
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister18)) * int64_t(int32_t(4))); // PTX L323
	r_PtxU64Register150 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register45);		// PTX L324
	r_PtxRegister1065 = uint32_t(r_PtxRegister15) + uint32_t(128);							// PTX L325
	r_PtxRegister1064 = uint32_t(r_PtxRegister18) + uint32_t(128);							// PTX L326
	r_PtxU16Register117 = uint16_t(1);														// PTX L327
L__BB41_23:																					// PTX L328
	r_bPtxPredicate16 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L329
	if (r_bPtxPredicate16)
	{
		goto L__BB41_25;
	} // PTX L330
	r_PtxRegister125 = uint32_t(r_PtxRegister15) + uint32_t(128);				   // PTX L331
	r_PtxRegister126 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);			   // PTX L332
	r_PtxRegister127 = ShiftLeft(uint32_t(r_PtxRegister126), uint32_t(12));		   // PTX L333
	r_PtxRegister128 = r_PtxRegister127 | 128;									   // PTX L334
	r_bPtxPredicate17 = uint32_t(r_PtxRegister125) == uint32_t(r_PtxRegister1065); // PTX L335
	r_bPtxPredicate18 = uint32_t(r_PtxRegister128) == uint32_t(r_PtxRegister1064); // PTX L336
	r_PtxU16Register6 = r_bPtxPredicate18 ? r_PtxU16Register117 : 0;			   // PTX L337
	r_PtxU16Register117 = r_bPtxPredicate17 ? r_PtxU16Register6 : 0;			   // PTX L338
L__BB41_25:																		   // PTX L339
	r_bPtxPredicate19 = uint16_t(r_PtxU16Register117) == uint16_t(0);			   // PTX L340
	if (r_bPtxPredicate19)
	{
		goto L__BB41_28;
	} // PTX L341
	r_PtxRegister130 = uint32_t(-1);							   // PTX L342
	r_PtxRegister129 = Elected(r_PtxRegister130);				   // PTX L344
	r_bPtxPredicate20 = uint32_t(r_PtxRegister129) == uint32_t(0); // PTX L350
	if (r_bPtxPredicate20)
	{
		goto L__BB41_40;
	} // PTX L351
	r_PtxU64Register47 = SharedOffset(s_SharedStorage, r_PtxU64Register151); // PTX L352
	r_PtxRegister131 = uint32_t(r_PtxU64Register47);						 // PTX L353
	r_PtxU64Register46 = r_PtxU64Register150;								 // PTX L354
	r_PtxRegister133 = uint32_t(24576u /* native mbarriers */);				 // PTX L355
	r_PtxRegister132 = uint32_t(1024);										 // PTX L356
	CopyBulk(s_SharedStorage, r_PtxRegister131, r_PtxU64Register46, r_PtxRegister132,
			 r_PtxRegister133);												 // PTX L358
	BarrierExpect(s_SharedStorage, r_PtxRegister133, r_PtxRegister132);		 // PTX L361
	goto L__BB41_40;														 // PTX L363
L__BB41_28:																	 // PTX L364
	r_bPtxPredicate21 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L365
	r_PtxU64Register152 = uint64_t(0);										 // PTX L366
	if (r_bPtxPredicate21)
	{
		goto L__BB41_30;
	} // PTX L367
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_PtxRegister18)) * int64_t(int32_t(4))); // PTX L368
	r_PtxU64Register152 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register48);		// PTX L369
L__BB41_30:																					// PTX L370
	r_bPtxPredicate22 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L371
	if (r_bPtxPredicate22)
	{
		goto L__BB41_33;
	} // PTX L372
	r_PtxRegister144 = uint32_t(-1);							   // PTX L373
	r_PtxRegister143 = Elected(r_PtxRegister144);				   // PTX L375
	r_bPtxPredicate23 = uint32_t(r_PtxRegister143) == uint32_t(0); // PTX L381
	if (r_bPtxPredicate23)
	{
		goto L__BB41_34;
	} // PTX L382
	r_PtxRegister148 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));		// PTX L383
	r_PtxRegister149 = uint32_t(0u /* native shared input */);					// PTX L384
	r_PtxRegister145 = uint32_t(r_PtxRegister149) + uint32_t(r_PtxRegister148); // PTX L385
	r_PtxU64Register49 = r_PtxU64Register152;									// PTX L386
	r_PtxRegister147 = uint32_t(24576u /* native mbarriers */);					// PTX L387
	r_PtxRegister146 = uint32_t(512);											// PTX L388
	CopyBulk(s_SharedStorage, r_PtxRegister145, r_PtxU64Register49, r_PtxRegister146,
			 r_PtxRegister147);																  // PTX L390
	BarrierExpect(s_SharedStorage, r_PtxRegister147, r_PtxRegister146);						  // PTX L393
	goto L__BB41_34;																		  // PTX L395
L__BB41_33:																					  // PTX L396
	r_PtxRegister134 = uint32_t(0);															  // PTX L397
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister134))); // PTX L399
	r_PackedHalf2AtPtx402R135 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L402
	r_ConvertedE4PairAtPtx404Rs8 = PublishE4(r_PackedHalf2AtPtx402R135);					  // PTX L404
	r_PackedE4WordAtPtx406R138 =
		JoinHalfwords(r_ConvertedE4PairAtPtx404Rs8, r_ConvertedE4PairAtPtx404Rs8); // PTX L406
	r_LaneIndexAtPtx408 = uint32_t((threadIdx.x & 31u));						   // PTX L408
	r_PtxRegister139 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));		   // PTX L410
	r_PtxRegister140 = uint32_t(0u /* native shared input */);					   // PTX L411
	r_PtxRegister141 = uint32_t(r_PtxRegister140) + uint32_t(r_PtxRegister139);	   // PTX L412
	r_PtxRegister142 = ShiftLeft(uint32_t(r_LaneIndexAtPtx408), uint32_t(4));	   // PTX L413
	r_PtxRegister137 = uint32_t(r_PtxRegister141) + uint32_t(r_PtxRegister142);	   // PTX L414
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister137)) =
		make_uint4(r_PackedE4WordAtPtx406R138, r_PackedE4WordAtPtx406R138, r_PackedE4WordAtPtx406R138,
				   r_PackedE4WordAtPtx406R138);								 // PTX L416
L__BB41_34:																	 // PTX L418
	r_bPtxPredicate24 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L419
	r_bPtxPredicate25 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L420
	r_PtxRegister150 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);		 // PTX L421
	r_PtxRegister151 = ShiftLeft(uint32_t(r_PtxRegister150), uint32_t(12));	 // PTX L422
	r_PtxRegister152 = r_PtxRegister151 | 128;								 // PTX L423
	r_PtxRegister19 = r_bPtxPredicate25 ? r_PtxRegister152 : 0;				 // PTX L424
	r_PtxU64Register153 = uint64_t(0);										 // PTX L425
	if (r_bPtxPredicate24)
	{
		goto L__BB41_36;
	} // PTX L426
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister19)) * int64_t(int32_t(4))); // PTX L427
	r_PtxU64Register153 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register50);		// PTX L428
L__BB41_36:																					// PTX L429
	r_bPtxPredicate26 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L430
	if (r_bPtxPredicate26)
	{
		goto L__BB41_39;
	} // PTX L431
	r_PtxRegister164 = uint32_t(-1);							   // PTX L432
	r_PtxRegister163 = Elected(r_PtxRegister164);				   // PTX L434
	r_bPtxPredicate27 = uint32_t(r_PtxRegister163) == uint32_t(0); // PTX L440
	if (r_bPtxPredicate27)
	{
		goto L__BB41_40;
	} // PTX L441
	r_PtxRegister168 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));		// PTX L442
	r_PtxRegister169 = uint32_t(0u /* native shared input */);					// PTX L443
	r_PtxRegister170 = uint32_t(r_PtxRegister169) + uint32_t(r_PtxRegister168); // PTX L444
	r_PtxRegister165 = uint32_t(r_PtxRegister170) + uint32_t(512);				// PTX L445
	r_PtxU64Register51 = r_PtxU64Register153;									// PTX L446
	r_PtxRegister167 = uint32_t(24576u /* native mbarriers */);					// PTX L447
	r_PtxRegister166 = uint32_t(512);											// PTX L448
	CopyBulk(s_SharedStorage, r_PtxRegister165, r_PtxU64Register51, r_PtxRegister166,
			 r_PtxRegister167);																  // PTX L450
	BarrierExpect(s_SharedStorage, r_PtxRegister167, r_PtxRegister166);						  // PTX L453
	goto L__BB41_40;																		  // PTX L455
L__BB41_39:																					  // PTX L456
	r_PtxRegister153 = uint32_t(0);															  // PTX L457
	r_PtxU16Register9 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister153))); // PTX L459
	r_PackedHalf2AtPtx462R154 = JoinHalfwords(r_PtxU16Register9, r_PtxU16Register9);		  // PTX L462
	r_ConvertedE4PairAtPtx464Rs10 = PublishE4(r_PackedHalf2AtPtx462R154);					  // PTX L464
	r_PackedE4WordAtPtx466R157 =
		JoinHalfwords(r_ConvertedE4PairAtPtx464Rs10, r_ConvertedE4PairAtPtx464Rs10); // PTX L466
	r_LaneIndexAtPtx468 = uint32_t((threadIdx.x & 31u));							 // PTX L468
	r_PtxRegister158 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));			 // PTX L470
	r_PtxRegister159 = uint32_t(0u /* native shared input */);						 // PTX L471
	r_PtxRegister160 = uint32_t(r_PtxRegister159) + uint32_t(r_PtxRegister158);		 // PTX L472
	r_PtxRegister161 = ShiftLeft(uint32_t(r_LaneIndexAtPtx468), uint32_t(4));		 // PTX L473
	r_PtxRegister162 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister161);		 // PTX L474
	r_PtxRegister156 = uint32_t(r_PtxRegister162) + uint32_t(512);					 // PTX L475
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister156)) =
		make_uint4(r_PackedE4WordAtPtx466R157, r_PackedE4WordAtPtx466R157, r_PackedE4WordAtPtx466R157,
				   r_PackedE4WordAtPtx466R157);								// PTX L477
L__BB41_40:																	// PTX L479
	r_bPtxPredicate28 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L480
	r_bPtxPredicate29 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L481
	r_PtxRegister171 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(10));			// PTX L482
	r_PtxRegister20 = r_PtxRegister171 | 64;								// PTX L483
	r_PtxRegister172 = uint32_t(r_PtxRegister11) + uint32_t(256);			// PTX L484
	r_PtxRegister21 = r_bPtxPredicate29 ? r_PtxRegister172 : 0;				// PTX L485
	r_PtxU16Register118 = uint16_t(0);										// PTX L486
	r_PtxU64Register154 = uint64_t(0);										// PTX L487
	r_PtxRegister1066 = uint32_t(128);										// PTX L488
	r_PtxRegister1067 = uint32_t(r_PtxRegister1066);						// PTX L489
	r_PtxU64Register155 = uint64_t(r_PtxU64Register154);					// PTX L490
	if (r_bPtxPredicate28)
	{
		goto L__BB41_42;
	} // PTX L491
	r_PtxU64Register155 = uint64_t(r_PtxU64Register4) + uint64_t(8192);						// PTX L492
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_PtxRegister21)) * int64_t(int32_t(4))); // PTX L493
	r_PtxU64Register154 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register52);		// PTX L494
	r_PtxRegister1067 = uint32_t(r_PtxRegister8) + uint32_t(128);							// PTX L495
	r_PtxRegister1066 = uint32_t(r_PtxRegister21) + uint32_t(128);							// PTX L496
	r_PtxU16Register118 = uint16_t(1);														// PTX L497
L__BB41_42:																					// PTX L498
	r_bPtxPredicate30 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L499
	if (r_bPtxPredicate30)
	{
		goto L__BB41_44;
	} // PTX L500
	r_PtxRegister173 = uint32_t(r_PtxRegister8) + uint32_t(128);				   // PTX L501
	r_PtxRegister174 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);				   // PTX L502
	r_PtxRegister175 = ShiftLeft(uint32_t(r_PtxRegister174), uint32_t(12));		   // PTX L503
	r_PtxRegister176 = r_PtxRegister175 | 384;									   // PTX L504
	r_bPtxPredicate31 = uint32_t(r_PtxRegister173) == uint32_t(r_PtxRegister1067); // PTX L505
	r_bPtxPredicate32 = uint32_t(r_PtxRegister176) == uint32_t(r_PtxRegister1066); // PTX L506
	r_PtxU16Register11 = r_bPtxPredicate32 ? r_PtxU16Register118 : 0;			   // PTX L507
	r_PtxU16Register118 = r_bPtxPredicate31 ? r_PtxU16Register11 : 0;			   // PTX L508
L__BB41_44:																		   // PTX L509
	r_bPtxPredicate33 = uint16_t(r_PtxU16Register118) == uint16_t(0);			   // PTX L510
	if (r_bPtxPredicate33)
	{
		goto L__BB41_47;
	} // PTX L511
	r_PtxRegister178 = uint32_t(-1);							   // PTX L512
	r_PtxRegister177 = Elected(r_PtxRegister178);				   // PTX L514
	r_bPtxPredicate34 = uint32_t(r_PtxRegister177) == uint32_t(0); // PTX L520
	if (r_bPtxPredicate34)
	{
		goto L__BB41_59;
	} // PTX L521
	r_PtxU64Register54 = SharedOffset(s_SharedStorage, r_PtxU64Register155); // PTX L522
	r_PtxRegister179 = uint32_t(r_PtxU64Register54);						 // PTX L523
	r_PtxU64Register53 = r_PtxU64Register154;								 // PTX L524
	r_PtxRegister182 = uint32_t(24576u /* native mbarriers */);				 // PTX L525
	r_PtxRegister181 = uint32_t(r_PtxRegister182) + uint32_t(8);			 // PTX L526
	r_PtxRegister180 = uint32_t(1024);										 // PTX L527
	CopyBulk(s_SharedStorage, r_PtxRegister179, r_PtxU64Register53, r_PtxRegister180,
			 r_PtxRegister181);												// PTX L529
	BarrierExpect(s_SharedStorage, r_PtxRegister181, r_PtxRegister180);		// PTX L532
	goto L__BB41_59;														// PTX L534
L__BB41_47:																	// PTX L535
	r_bPtxPredicate35 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L536
	r_PtxU64Register156 = uint64_t(0);										// PTX L537
	if (r_bPtxPredicate35)
	{
		goto L__BB41_49;
	} // PTX L538
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_PtxRegister21)) * int64_t(int32_t(4))); // PTX L539
	r_PtxU64Register156 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register55);		// PTX L540
L__BB41_49:																					// PTX L541
	r_bPtxPredicate36 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L542
	r_PtxRegister183 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					// PTX L543
	r_PtxRegister184 = uint32_t(0u /* native shared input */);								// PTX L544
	r_PtxRegister22 = uint32_t(r_PtxRegister184) + uint32_t(r_PtxRegister183);				// PTX L545
	if (r_bPtxPredicate36)
	{
		goto L__BB41_52;
	} // PTX L546
	r_PtxRegister193 = uint32_t(-1);							   // PTX L547
	r_PtxRegister192 = Elected(r_PtxRegister193);				   // PTX L549
	r_bPtxPredicate37 = uint32_t(r_PtxRegister192) == uint32_t(0); // PTX L555
	if (r_bPtxPredicate37)
	{
		goto L__BB41_53;
	} // PTX L556
	r_PtxRegister194 = uint32_t(r_PtxRegister22) + uint32_t(8192); // PTX L557
	r_PtxU64Register56 = r_PtxU64Register156;					   // PTX L558
	r_PtxRegister197 = uint32_t(24576u /* native mbarriers */);	   // PTX L559
	r_PtxRegister196 = uint32_t(r_PtxRegister197) + uint32_t(8);   // PTX L560
	r_PtxRegister195 = uint32_t(512);							   // PTX L561
	CopyBulk(s_SharedStorage, r_PtxRegister194, r_PtxU64Register56, r_PtxRegister195,
			 r_PtxRegister196);																   // PTX L563
	BarrierExpect(s_SharedStorage, r_PtxRegister196, r_PtxRegister195);						   // PTX L566
	goto L__BB41_53;																		   // PTX L568
L__BB41_52:																					   // PTX L569
	r_PtxRegister185 = uint32_t(0);															   // PTX L570
	r_PtxU16Register12 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister185))); // PTX L572
	r_PackedHalf2AtPtx575R186 = JoinHalfwords(r_PtxU16Register12, r_PtxU16Register12);		   // PTX L575
	r_ConvertedE4PairAtPtx577Rs13 = PublishE4(r_PackedHalf2AtPtx575R186);					   // PTX L577
	r_PackedE4WordAtPtx579R189 =
		JoinHalfwords(r_ConvertedE4PairAtPtx577Rs13, r_ConvertedE4PairAtPtx577Rs13); // PTX L579
	r_LaneIndexAtPtx581 = uint32_t((threadIdx.x & 31u));							 // PTX L581
	r_PtxRegister190 = ShiftLeft(uint32_t(r_LaneIndexAtPtx581), uint32_t(4));		 // PTX L583
	r_PtxRegister191 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister190);		 // PTX L584
	r_PtxRegister188 = uint32_t(r_PtxRegister191) + uint32_t(8192);					 // PTX L585
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister188)) =
		make_uint4(r_PackedE4WordAtPtx579R189, r_PackedE4WordAtPtx579R189, r_PackedE4WordAtPtx579R189,
				   r_PackedE4WordAtPtx579R189);								// PTX L587
L__BB41_53:																	// PTX L589
	r_bPtxPredicate38 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L590
	r_bPtxPredicate39 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L591
	r_PtxRegister198 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);			// PTX L592
	r_PtxRegister199 = ShiftLeft(uint32_t(r_PtxRegister198), uint32_t(12)); // PTX L593
	r_PtxRegister200 = r_PtxRegister199 | 384;								// PTX L594
	r_PtxRegister23 = r_bPtxPredicate39 ? r_PtxRegister200 : 0;				// PTX L595
	r_PtxU64Register157 = uint64_t(0);										// PTX L596
	if (r_bPtxPredicate38)
	{
		goto L__BB41_55;
	} // PTX L597
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_PtxRegister23)) * int64_t(int32_t(4))); // PTX L598
	r_PtxU64Register157 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register57);		// PTX L599
L__BB41_55:																					// PTX L600
	r_bPtxPredicate40 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L601
	if (r_bPtxPredicate40)
	{
		goto L__BB41_58;
	} // PTX L602
	r_PtxRegister209 = uint32_t(-1);							   // PTX L603
	r_PtxRegister208 = Elected(r_PtxRegister209);				   // PTX L605
	r_bPtxPredicate41 = uint32_t(r_PtxRegister208) == uint32_t(0); // PTX L611
	if (r_bPtxPredicate41)
	{
		goto L__BB41_59;
	} // PTX L612
	r_PtxRegister210 = uint32_t(r_PtxRegister22) + uint32_t(8704); // PTX L613
	r_PtxU64Register58 = r_PtxU64Register157;					   // PTX L614
	r_PtxRegister213 = uint32_t(24576u /* native mbarriers */);	   // PTX L615
	r_PtxRegister212 = uint32_t(r_PtxRegister213) + uint32_t(8);   // PTX L616
	r_PtxRegister211 = uint32_t(512);							   // PTX L617
	CopyBulk(s_SharedStorage, r_PtxRegister210, r_PtxU64Register58, r_PtxRegister211,
			 r_PtxRegister212);																   // PTX L619
	BarrierExpect(s_SharedStorage, r_PtxRegister212, r_PtxRegister211);						   // PTX L622
	goto L__BB41_59;																		   // PTX L624
L__BB41_58:																					   // PTX L625
	r_PtxRegister201 = uint32_t(0);															   // PTX L626
	r_PtxU16Register14 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister201))); // PTX L628
	r_PackedHalf2AtPtx631R202 = JoinHalfwords(r_PtxU16Register14, r_PtxU16Register14);		   // PTX L631
	r_ConvertedE4PairAtPtx633Rs15 = PublishE4(r_PackedHalf2AtPtx631R202);					   // PTX L633
	r_PackedE4WordAtPtx635R205 =
		JoinHalfwords(r_ConvertedE4PairAtPtx633Rs15, r_ConvertedE4PairAtPtx633Rs15); // PTX L635
	r_LaneIndexAtPtx637 = uint32_t((threadIdx.x & 31u));							 // PTX L637
	r_PtxRegister206 = ShiftLeft(uint32_t(r_LaneIndexAtPtx637), uint32_t(4));		 // PTX L639
	r_PtxRegister207 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister206);		 // PTX L640
	r_PtxRegister204 = uint32_t(r_PtxRegister207) + uint32_t(8704);					 // PTX L641
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister204)) =
		make_uint4(r_PackedE4WordAtPtx635R205, r_PackedE4WordAtPtx635R205, r_PackedE4WordAtPtx635R205,
				   r_PackedE4WordAtPtx635R205);								 // PTX L643
L__BB41_59:																	 // PTX L645
	r_bPtxPredicate42 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L646
	r_bPtxPredicate43 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L647
	r_PtxRegister214 = uint32_t(r_PtxRegister17) + uint32_t(256);			 // PTX L648
	r_PtxRegister24 = r_bPtxPredicate43 ? r_PtxRegister214 : 0;				 // PTX L649
	r_PtxU16Register119 = uint16_t(0);										 // PTX L650
	r_PtxU64Register158 = uint64_t(0);										 // PTX L651
	r_PtxRegister1068 = uint32_t(128);										 // PTX L652
	r_PtxRegister1069 = uint32_t(r_PtxRegister1068);						 // PTX L653
	r_PtxU64Register159 = uint64_t(r_PtxU64Register158);					 // PTX L654
	if (r_bPtxPredicate42)
	{
		goto L__BB41_61;
	} // PTX L655
	r_PtxU64Register159 = uint64_t(r_PtxU64Register4) + uint64_t(12288);					// PTX L656
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_PtxRegister24)) * int64_t(int32_t(4))); // PTX L657
	r_PtxU64Register158 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register59);		// PTX L658
	r_PtxRegister1069 = uint32_t(r_PtxRegister15) + uint32_t(128);							// PTX L659
	r_PtxRegister1068 = uint32_t(r_PtxRegister24) + uint32_t(128);							// PTX L660
	r_PtxU16Register119 = uint16_t(1);														// PTX L661
L__BB41_61:																					// PTX L662
	r_bPtxPredicate44 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L663
	if (r_bPtxPredicate44)
	{
		goto L__BB41_63;
	} // PTX L664
	r_PtxRegister215 = uint32_t(r_PtxRegister15) + uint32_t(128);				   // PTX L665
	r_PtxRegister216 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);			   // PTX L666
	r_PtxRegister217 = ShiftLeft(uint32_t(r_PtxRegister216), uint32_t(12));		   // PTX L667
	r_PtxRegister218 = r_PtxRegister217 | 384;									   // PTX L668
	r_bPtxPredicate45 = uint32_t(r_PtxRegister215) == uint32_t(r_PtxRegister1069); // PTX L669
	r_bPtxPredicate46 = uint32_t(r_PtxRegister218) == uint32_t(r_PtxRegister1068); // PTX L670
	r_PtxU16Register16 = r_bPtxPredicate46 ? r_PtxU16Register119 : 0;			   // PTX L671
	r_PtxU16Register119 = r_bPtxPredicate45 ? r_PtxU16Register16 : 0;			   // PTX L672
L__BB41_63:																		   // PTX L673
	r_bPtxPredicate47 = uint16_t(r_PtxU16Register119) == uint16_t(0);			   // PTX L674
	if (r_bPtxPredicate47)
	{
		goto L__BB41_66;
	} // PTX L675
	r_PtxRegister220 = uint32_t(-1);							   // PTX L676
	r_PtxRegister219 = Elected(r_PtxRegister220);				   // PTX L678
	r_bPtxPredicate48 = uint32_t(r_PtxRegister219) == uint32_t(0); // PTX L684
	if (r_bPtxPredicate48)
	{
		goto L__BB41_78;
	} // PTX L685
	r_PtxU64Register61 = SharedOffset(s_SharedStorage, r_PtxU64Register159); // PTX L686
	r_PtxRegister221 = uint32_t(r_PtxU64Register61);						 // PTX L687
	r_PtxU64Register60 = r_PtxU64Register158;								 // PTX L688
	r_PtxRegister224 = uint32_t(24576u /* native mbarriers */);				 // PTX L689
	r_PtxRegister223 = uint32_t(r_PtxRegister224) + uint32_t(8);			 // PTX L690
	r_PtxRegister222 = uint32_t(1024);										 // PTX L691
	CopyBulk(s_SharedStorage, r_PtxRegister221, r_PtxU64Register60, r_PtxRegister222,
			 r_PtxRegister223);												 // PTX L693
	BarrierExpect(s_SharedStorage, r_PtxRegister223, r_PtxRegister222);		 // PTX L696
	goto L__BB41_78;														 // PTX L698
L__BB41_66:																	 // PTX L699
	r_bPtxPredicate49 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L700
	r_PtxU64Register160 = uint64_t(0);										 // PTX L701
	if (r_bPtxPredicate49)
	{
		goto L__BB41_68;
	} // PTX L702
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister24)) * int64_t(int32_t(4))); // PTX L703
	r_PtxU64Register160 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register62);		// PTX L704
L__BB41_68:																					// PTX L705
	r_bPtxPredicate50 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L706
	r_PtxRegister225 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));					// PTX L707
	r_PtxRegister226 = uint32_t(0u /* native shared input */);								// PTX L708
	r_PtxRegister25 = uint32_t(r_PtxRegister226) + uint32_t(r_PtxRegister225);				// PTX L709
	if (r_bPtxPredicate50)
	{
		goto L__BB41_71;
	} // PTX L710
	r_PtxRegister235 = uint32_t(-1);							   // PTX L711
	r_PtxRegister234 = Elected(r_PtxRegister235);				   // PTX L713
	r_bPtxPredicate51 = uint32_t(r_PtxRegister234) == uint32_t(0); // PTX L719
	if (r_bPtxPredicate51)
	{
		goto L__BB41_72;
	} // PTX L720
	r_PtxRegister236 = uint32_t(r_PtxRegister25) + uint32_t(8192); // PTX L721
	r_PtxU64Register63 = r_PtxU64Register160;					   // PTX L722
	r_PtxRegister239 = uint32_t(24576u /* native mbarriers */);	   // PTX L723
	r_PtxRegister238 = uint32_t(r_PtxRegister239) + uint32_t(8);   // PTX L724
	r_PtxRegister237 = uint32_t(512);							   // PTX L725
	CopyBulk(s_SharedStorage, r_PtxRegister236, r_PtxU64Register63, r_PtxRegister237,
			 r_PtxRegister238);																   // PTX L727
	BarrierExpect(s_SharedStorage, r_PtxRegister238, r_PtxRegister237);						   // PTX L730
	goto L__BB41_72;																		   // PTX L732
L__BB41_71:																					   // PTX L733
	r_PtxRegister227 = uint32_t(0);															   // PTX L734
	r_PtxU16Register17 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister227))); // PTX L736
	r_PackedHalf2AtPtx739R228 = JoinHalfwords(r_PtxU16Register17, r_PtxU16Register17);		   // PTX L739
	r_ConvertedE4PairAtPtx741Rs18 = PublishE4(r_PackedHalf2AtPtx739R228);					   // PTX L741
	r_PackedE4WordAtPtx743R231 =
		JoinHalfwords(r_ConvertedE4PairAtPtx741Rs18, r_ConvertedE4PairAtPtx741Rs18); // PTX L743
	r_LaneIndexAtPtx745 = uint32_t((threadIdx.x & 31u));							 // PTX L745
	r_PtxRegister232 = ShiftLeft(uint32_t(r_LaneIndexAtPtx745), uint32_t(4));		 // PTX L747
	r_PtxRegister233 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister232);		 // PTX L748
	r_PtxRegister230 = uint32_t(r_PtxRegister233) + uint32_t(8192);					 // PTX L749
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister230)) =
		make_uint4(r_PackedE4WordAtPtx743R231, r_PackedE4WordAtPtx743R231, r_PackedE4WordAtPtx743R231,
				   r_PackedE4WordAtPtx743R231);								 // PTX L751
L__BB41_72:																	 // PTX L753
	r_bPtxPredicate52 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L754
	r_bPtxPredicate53 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L755
	r_PtxRegister240 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);		 // PTX L756
	r_PtxRegister241 = ShiftLeft(uint32_t(r_PtxRegister240), uint32_t(12));	 // PTX L757
	r_PtxRegister242 = r_PtxRegister241 | 384;								 // PTX L758
	r_PtxRegister26 = r_bPtxPredicate53 ? r_PtxRegister242 : 0;				 // PTX L759
	r_PtxU64Register161 = uint64_t(0);										 // PTX L760
	if (r_bPtxPredicate52)
	{
		goto L__BB41_74;
	} // PTX L761
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_PtxRegister26)) * int64_t(int32_t(4))); // PTX L762
	r_PtxU64Register161 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register64);		// PTX L763
L__BB41_74:																					// PTX L764
	r_bPtxPredicate54 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L765
	if (r_bPtxPredicate54)
	{
		goto L__BB41_77;
	} // PTX L766
	r_PtxRegister251 = uint32_t(-1);							   // PTX L767
	r_PtxRegister250 = Elected(r_PtxRegister251);				   // PTX L769
	r_bPtxPredicate55 = uint32_t(r_PtxRegister250) == uint32_t(0); // PTX L775
	if (r_bPtxPredicate55)
	{
		goto L__BB41_78;
	} // PTX L776
	r_PtxRegister252 = uint32_t(r_PtxRegister25) + uint32_t(8704); // PTX L777
	r_PtxU64Register65 = r_PtxU64Register161;					   // PTX L778
	r_PtxRegister255 = uint32_t(24576u /* native mbarriers */);	   // PTX L779
	r_PtxRegister254 = uint32_t(r_PtxRegister255) + uint32_t(8);   // PTX L780
	r_PtxRegister253 = uint32_t(512);							   // PTX L781
	CopyBulk(s_SharedStorage, r_PtxRegister252, r_PtxU64Register65, r_PtxRegister253,
			 r_PtxRegister254);																   // PTX L783
	BarrierExpect(s_SharedStorage, r_PtxRegister254, r_PtxRegister253);						   // PTX L786
	goto L__BB41_78;																		   // PTX L788
L__BB41_77:																					   // PTX L789
	r_PtxRegister243 = uint32_t(0);															   // PTX L790
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister243))); // PTX L792
	r_PackedHalf2AtPtx795R244 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L795
	r_ConvertedE4PairAtPtx797Rs20 = PublishE4(r_PackedHalf2AtPtx795R244);					   // PTX L797
	r_PackedE4WordAtPtx799R247 =
		JoinHalfwords(r_ConvertedE4PairAtPtx797Rs20, r_ConvertedE4PairAtPtx797Rs20); // PTX L799
	r_LaneIndexAtPtx801 = uint32_t((threadIdx.x & 31u));							 // PTX L801
	r_PtxRegister248 = ShiftLeft(uint32_t(r_LaneIndexAtPtx801), uint32_t(4));		 // PTX L803
	r_PtxRegister249 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister248);		 // PTX L804
	r_PtxRegister246 = uint32_t(r_PtxRegister249) + uint32_t(8704);					 // PTX L805
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister246)) =
		make_uint4(r_PackedE4WordAtPtx799R247, r_PackedE4WordAtPtx799R247, r_PackedE4WordAtPtx799R247,
				   r_PackedE4WordAtPtx799R247);								// PTX L807
L__BB41_78:																	// PTX L809
	r_bPtxPredicate56 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L810
	r_bPtxPredicate57 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L811
	r_PtxRegister256 = uint32_t(r_PtxRegister11) + uint32_t(512);			// PTX L812
	r_PtxRegister27 = r_bPtxPredicate57 ? r_PtxRegister256 : 0;				// PTX L813
	r_PtxU16Register120 = uint16_t(0);										// PTX L814
	r_PtxU64Register162 = uint64_t(0);										// PTX L815
	r_PtxRegister1070 = uint32_t(128);										// PTX L816
	r_PtxRegister1071 = uint32_t(r_PtxRegister1070);						// PTX L817
	r_PtxU64Register163 = uint64_t(r_PtxU64Register162);					// PTX L818
	if (r_bPtxPredicate56)
	{
		goto L__BB41_80;
	} // PTX L819
	r_PtxU64Register163 = uint64_t(r_PtxU64Register4) + uint64_t(16384);					// PTX L820
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister27)) * int64_t(int32_t(4))); // PTX L821
	r_PtxU64Register162 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register66);		// PTX L822
	r_PtxRegister1071 = uint32_t(r_PtxRegister8) + uint32_t(128);							// PTX L823
	r_PtxRegister1070 = uint32_t(r_PtxRegister27) + uint32_t(128);							// PTX L824
	r_PtxU16Register120 = uint16_t(1);														// PTX L825
L__BB41_80:																					// PTX L826
	r_bPtxPredicate58 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L827
	if (r_bPtxPredicate58)
	{
		goto L__BB41_82;
	} // PTX L828
	r_PtxRegister257 = uint32_t(r_PtxRegister8) + uint32_t(128);				   // PTX L829
	r_PtxRegister258 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);				   // PTX L830
	r_PtxRegister259 = ShiftLeft(uint32_t(r_PtxRegister258), uint32_t(12));		   // PTX L831
	r_PtxRegister260 = r_PtxRegister259 | 640;									   // PTX L832
	r_bPtxPredicate59 = uint32_t(r_PtxRegister257) == uint32_t(r_PtxRegister1071); // PTX L833
	r_bPtxPredicate60 = uint32_t(r_PtxRegister260) == uint32_t(r_PtxRegister1070); // PTX L834
	r_PtxU16Register21 = r_bPtxPredicate60 ? r_PtxU16Register120 : 0;			   // PTX L835
	r_PtxU16Register120 = r_bPtxPredicate59 ? r_PtxU16Register21 : 0;			   // PTX L836
L__BB41_82:																		   // PTX L837
	r_bPtxPredicate61 = uint16_t(r_PtxU16Register120) == uint16_t(0);			   // PTX L838
	if (r_bPtxPredicate61)
	{
		goto L__BB41_85;
	} // PTX L839
	r_PtxRegister262 = uint32_t(-1);							   // PTX L840
	r_PtxRegister261 = Elected(r_PtxRegister262);				   // PTX L842
	r_bPtxPredicate62 = uint32_t(r_PtxRegister261) == uint32_t(0); // PTX L848
	if (r_bPtxPredicate62)
	{
		goto L__BB41_97;
	} // PTX L849
	r_PtxU64Register68 = SharedOffset(s_SharedStorage, r_PtxU64Register163); // PTX L850
	r_PtxRegister263 = uint32_t(r_PtxU64Register68);						 // PTX L851
	r_PtxU64Register67 = r_PtxU64Register162;								 // PTX L852
	r_PtxRegister266 = uint32_t(24576u /* native mbarriers */);				 // PTX L853
	r_PtxRegister265 = uint32_t(r_PtxRegister266) + uint32_t(16);			 // PTX L854
	r_PtxRegister264 = uint32_t(1024);										 // PTX L855
	CopyBulk(s_SharedStorage, r_PtxRegister263, r_PtxU64Register67, r_PtxRegister264,
			 r_PtxRegister265);												// PTX L857
	BarrierExpect(s_SharedStorage, r_PtxRegister265, r_PtxRegister264);		// PTX L860
	goto L__BB41_97;														// PTX L862
L__BB41_85:																	// PTX L863
	r_bPtxPredicate63 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L864
	r_PtxU64Register164 = uint64_t(0);										// PTX L865
	if (r_bPtxPredicate63)
	{
		goto L__BB41_87;
	} // PTX L866
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister27)) * int64_t(int32_t(4))); // PTX L867
	r_PtxU64Register164 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register69);		// PTX L868
L__BB41_87:																					// PTX L869
	r_bPtxPredicate64 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L870
	r_PtxRegister267 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					// PTX L871
	r_PtxRegister268 = uint32_t(0u /* native shared input */);								// PTX L872
	r_PtxRegister28 = uint32_t(r_PtxRegister268) + uint32_t(r_PtxRegister267);				// PTX L873
	if (r_bPtxPredicate64)
	{
		goto L__BB41_90;
	} // PTX L874
	r_PtxRegister277 = uint32_t(-1);							   // PTX L875
	r_PtxRegister276 = Elected(r_PtxRegister277);				   // PTX L877
	r_bPtxPredicate65 = uint32_t(r_PtxRegister276) == uint32_t(0); // PTX L883
	if (r_bPtxPredicate65)
	{
		goto L__BB41_91;
	} // PTX L884
	r_PtxRegister278 = uint32_t(r_PtxRegister28) + uint32_t(16384); // PTX L885
	r_PtxU64Register70 = r_PtxU64Register164;						// PTX L886
	r_PtxRegister281 = uint32_t(24576u /* native mbarriers */);		// PTX L887
	r_PtxRegister280 = uint32_t(r_PtxRegister281) + uint32_t(16);	// PTX L888
	r_PtxRegister279 = uint32_t(512);								// PTX L889
	CopyBulk(s_SharedStorage, r_PtxRegister278, r_PtxU64Register70, r_PtxRegister279,
			 r_PtxRegister280);																   // PTX L891
	BarrierExpect(s_SharedStorage, r_PtxRegister280, r_PtxRegister279);						   // PTX L894
	goto L__BB41_91;																		   // PTX L896
L__BB41_90:																					   // PTX L897
	r_PtxRegister269 = uint32_t(0);															   // PTX L898
	r_PtxU16Register22 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister269))); // PTX L900
	r_PackedHalf2AtPtx903R270 = JoinHalfwords(r_PtxU16Register22, r_PtxU16Register22);		   // PTX L903
	r_ConvertedE4PairAtPtx905Rs23 = PublishE4(r_PackedHalf2AtPtx903R270);					   // PTX L905
	r_PackedE4WordAtPtx907R273 =
		JoinHalfwords(r_ConvertedE4PairAtPtx905Rs23, r_ConvertedE4PairAtPtx905Rs23); // PTX L907
	r_LaneIndexAtPtx909 = uint32_t((threadIdx.x & 31u));							 // PTX L909
	r_PtxRegister274 = ShiftLeft(uint32_t(r_LaneIndexAtPtx909), uint32_t(4));		 // PTX L911
	r_PtxRegister275 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister274);		 // PTX L912
	r_PtxRegister272 = uint32_t(r_PtxRegister275) + uint32_t(16384);				 // PTX L913
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister272)) =
		make_uint4(r_PackedE4WordAtPtx907R273, r_PackedE4WordAtPtx907R273, r_PackedE4WordAtPtx907R273,
				   r_PackedE4WordAtPtx907R273);								// PTX L915
L__BB41_91:																	// PTX L917
	r_bPtxPredicate66 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L918
	r_bPtxPredicate67 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L919
	r_PtxRegister282 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister9);			// PTX L920
	r_PtxRegister283 = ShiftLeft(uint32_t(r_PtxRegister282), uint32_t(12)); // PTX L921
	r_PtxRegister284 = r_PtxRegister283 | 640;								// PTX L922
	r_PtxRegister29 = r_bPtxPredicate67 ? r_PtxRegister284 : 0;				// PTX L923
	r_PtxU64Register165 = uint64_t(0);										// PTX L924
	if (r_bPtxPredicate66)
	{
		goto L__BB41_93;
	} // PTX L925
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_PtxRegister29)) * int64_t(int32_t(4))); // PTX L926
	r_PtxU64Register165 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register71);		// PTX L927
L__BB41_93:																					// PTX L928
	r_bPtxPredicate68 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					// PTX L929
	if (r_bPtxPredicate68)
	{
		goto L__BB41_96;
	} // PTX L930
	r_PtxRegister293 = uint32_t(-1);							   // PTX L931
	r_PtxRegister292 = Elected(r_PtxRegister293);				   // PTX L933
	r_bPtxPredicate69 = uint32_t(r_PtxRegister292) == uint32_t(0); // PTX L939
	if (r_bPtxPredicate69)
	{
		goto L__BB41_97;
	} // PTX L940
	r_PtxRegister294 = uint32_t(r_PtxRegister28) + uint32_t(16896); // PTX L941
	r_PtxU64Register72 = r_PtxU64Register165;						// PTX L942
	r_PtxRegister297 = uint32_t(24576u /* native mbarriers */);		// PTX L943
	r_PtxRegister296 = uint32_t(r_PtxRegister297) + uint32_t(16);	// PTX L944
	r_PtxRegister295 = uint32_t(512);								// PTX L945
	CopyBulk(s_SharedStorage, r_PtxRegister294, r_PtxU64Register72, r_PtxRegister295,
			 r_PtxRegister296);																   // PTX L947
	BarrierExpect(s_SharedStorage, r_PtxRegister296, r_PtxRegister295);						   // PTX L950
	goto L__BB41_97;																		   // PTX L952
L__BB41_96:																					   // PTX L953
	r_PtxRegister285 = uint32_t(0);															   // PTX L954
	r_PtxU16Register24 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister285))); // PTX L956
	r_PackedHalf2AtPtx959R286 = JoinHalfwords(r_PtxU16Register24, r_PtxU16Register24);		   // PTX L959
	r_ConvertedE4PairAtPtx961Rs25 = PublishE4(r_PackedHalf2AtPtx959R286);					   // PTX L961
	r_PackedE4WordAtPtx963R289 =
		JoinHalfwords(r_ConvertedE4PairAtPtx961Rs25, r_ConvertedE4PairAtPtx961Rs25); // PTX L963
	r_LaneIndexAtPtx965 = uint32_t((threadIdx.x & 31u));							 // PTX L965
	r_PtxRegister290 = ShiftLeft(uint32_t(r_LaneIndexAtPtx965), uint32_t(4));		 // PTX L967
	r_PtxRegister291 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister290);		 // PTX L968
	r_PtxRegister288 = uint32_t(r_PtxRegister291) + uint32_t(16896);				 // PTX L969
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister288)) =
		make_uint4(r_PackedE4WordAtPtx963R289, r_PackedE4WordAtPtx963R289, r_PackedE4WordAtPtx963R289,
				   r_PackedE4WordAtPtx963R289);								 // PTX L971
L__BB41_97:																	 // PTX L973
	r_bPtxPredicate70 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L974
	r_bPtxPredicate71 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L975
	r_PtxRegister298 = uint32_t(r_PtxRegister17) + uint32_t(512);			 // PTX L976
	r_PtxRegister30 = r_bPtxPredicate71 ? r_PtxRegister298 : 0;				 // PTX L977
	r_PtxU16Register121 = uint16_t(0);										 // PTX L978
	r_PtxU64Register166 = uint64_t(0);										 // PTX L979
	r_PtxRegister1072 = uint32_t(128);										 // PTX L980
	r_PtxRegister1073 = uint32_t(r_PtxRegister1072);						 // PTX L981
	r_PtxU64Register167 = uint64_t(r_PtxU64Register166);					 // PTX L982
	if (r_bPtxPredicate70)
	{
		goto L__BB41_99;
	} // PTX L983
	r_PtxU64Register167 = uint64_t(r_PtxU64Register4) + uint64_t(20480);					// PTX L984
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister30)) * int64_t(int32_t(4))); // PTX L985
	r_PtxU64Register166 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register73);		// PTX L986
	r_PtxRegister1073 = uint32_t(r_PtxRegister15) + uint32_t(128);							// PTX L987
	r_PtxRegister1072 = uint32_t(r_PtxRegister30) + uint32_t(128);							// PTX L988
	r_PtxU16Register121 = uint16_t(1);														// PTX L989
L__BB41_99:																					// PTX L990
	r_bPtxPredicate72 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				// PTX L991
	if (r_bPtxPredicate72)
	{
		goto L__BB41_101;
	} // PTX L992
	r_PtxRegister299 = uint32_t(r_PtxRegister15) + uint32_t(128);				   // PTX L993
	r_PtxRegister300 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);			   // PTX L994
	r_PtxRegister301 = ShiftLeft(uint32_t(r_PtxRegister300), uint32_t(12));		   // PTX L995
	r_PtxRegister302 = r_PtxRegister301 | 640;									   // PTX L996
	r_bPtxPredicate73 = uint32_t(r_PtxRegister299) == uint32_t(r_PtxRegister1073); // PTX L997
	r_bPtxPredicate74 = uint32_t(r_PtxRegister302) == uint32_t(r_PtxRegister1072); // PTX L998
	r_PtxU16Register26 = r_bPtxPredicate74 ? r_PtxU16Register121 : 0;			   // PTX L999
	r_PtxU16Register121 = r_bPtxPredicate73 ? r_PtxU16Register26 : 0;			   // PTX L1000
L__BB41_101:																	   // PTX L1001
	r_bPtxPredicate75 = uint16_t(r_PtxU16Register121) == uint16_t(0);			   // PTX L1002
	if (r_bPtxPredicate75)
	{
		goto L__BB41_104;
	} // PTX L1003
	r_PtxRegister304 = uint32_t(-1);							   // PTX L1004
	r_PtxRegister303 = Elected(r_PtxRegister304);				   // PTX L1006
	r_bPtxPredicate76 = uint32_t(r_PtxRegister303) == uint32_t(0); // PTX L1012
	if (r_bPtxPredicate76)
	{
		goto L__BB41_116;
	} // PTX L1013
	r_PtxU64Register75 = SharedOffset(s_SharedStorage, r_PtxU64Register167); // PTX L1014
	r_PtxRegister305 = uint32_t(r_PtxU64Register75);						 // PTX L1015
	r_PtxU64Register74 = r_PtxU64Register166;								 // PTX L1016
	r_PtxRegister308 = uint32_t(24576u /* native mbarriers */);				 // PTX L1017
	r_PtxRegister307 = uint32_t(r_PtxRegister308) + uint32_t(16);			 // PTX L1018
	r_PtxRegister306 = uint32_t(1024);										 // PTX L1019
	CopyBulk(s_SharedStorage, r_PtxRegister305, r_PtxU64Register74, r_PtxRegister306,
			 r_PtxRegister307);												 // PTX L1021
	BarrierExpect(s_SharedStorage, r_PtxRegister307, r_PtxRegister306);		 // PTX L1024
	goto L__BB41_116;														 // PTX L1026
L__BB41_104:																 // PTX L1027
	r_bPtxPredicate77 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L1028
	r_PtxU64Register168 = uint64_t(0);										 // PTX L1029
	if (r_bPtxPredicate77)
	{
		goto L__BB41_106;
	} // PTX L1030
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister30)) * int64_t(int32_t(4))); // PTX L1031
	r_PtxU64Register168 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register76);		// PTX L1032
L__BB41_106:																				// PTX L1033
	r_PtxRegister309 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));					// PTX L1034
	r_PtxRegister310 = uint32_t(0u /* native shared input */);								// PTX L1035
	r_PtxRegister31 = uint32_t(r_PtxRegister310) + uint32_t(r_PtxRegister309);				// PTX L1036
	if (r_bPtxPredicate77)
	{
		goto L__BB41_109;
	} // PTX L1037
	r_PtxRegister319 = uint32_t(-1);							   // PTX L1038
	r_PtxRegister318 = Elected(r_PtxRegister319);				   // PTX L1040
	r_bPtxPredicate78 = uint32_t(r_PtxRegister318) == uint32_t(0); // PTX L1046
	if (r_bPtxPredicate78)
	{
		goto L__BB41_110;
	} // PTX L1047
	r_PtxRegister320 = uint32_t(r_PtxRegister31) + uint32_t(16384); // PTX L1048
	r_PtxU64Register77 = r_PtxU64Register168;						// PTX L1049
	r_PtxRegister323 = uint32_t(24576u /* native mbarriers */);		// PTX L1050
	r_PtxRegister322 = uint32_t(r_PtxRegister323) + uint32_t(16);	// PTX L1051
	r_PtxRegister321 = uint32_t(512);								// PTX L1052
	CopyBulk(s_SharedStorage, r_PtxRegister320, r_PtxU64Register77, r_PtxRegister321,
			 r_PtxRegister322);																   // PTX L1054
	BarrierExpect(s_SharedStorage, r_PtxRegister322, r_PtxRegister321);						   // PTX L1057
	goto L__BB41_110;																		   // PTX L1059
L__BB41_109:																				   // PTX L1060
	r_PtxRegister311 = uint32_t(0);															   // PTX L1061
	r_PtxU16Register27 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister311))); // PTX L1063
	r_PackedHalf2AtPtx1066R312 = JoinHalfwords(r_PtxU16Register27, r_PtxU16Register27);		   // PTX L1066
	r_ConvertedE4PairAtPtx1068Rs28 = PublishE4(r_PackedHalf2AtPtx1066R312);					   // PTX L1068
	r_PackedE4WordAtPtx1070R315 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1068Rs28, r_ConvertedE4PairAtPtx1068Rs28); // PTX L1070
	r_LaneIndexAtPtx1072 = uint32_t((threadIdx.x & 31u));							   // PTX L1072
	r_PtxRegister316 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1072), uint32_t(4));		   // PTX L1074
	r_PtxRegister317 = uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister316);		   // PTX L1075
	r_PtxRegister314 = uint32_t(r_PtxRegister317) + uint32_t(16384);				   // PTX L1076
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister314)) =
		make_uint4(r_PackedE4WordAtPtx1070R315, r_PackedE4WordAtPtx1070R315, r_PackedE4WordAtPtx1070R315,
				   r_PackedE4WordAtPtx1070R315);							 // PTX L1078
L__BB41_110:																 // PTX L1080
	r_bPtxPredicate79 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L1081
	r_bPtxPredicate80 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);	 // PTX L1082
	r_PtxRegister324 = uint32_t(r_CtaZ) + uint32_t(r_PtxRegister16);		 // PTX L1083
	r_PtxRegister325 = ShiftLeft(uint32_t(r_PtxRegister324), uint32_t(12));	 // PTX L1084
	r_PtxRegister326 = r_PtxRegister325 | 640;								 // PTX L1085
	r_PtxRegister32 = r_bPtxPredicate80 ? r_PtxRegister326 : 0;				 // PTX L1086
	r_PtxU64Register169 = uint64_t(0);										 // PTX L1087
	if (r_bPtxPredicate79)
	{
		goto L__BB41_112;
	} // PTX L1088
	r_PtxU64Register78 = uint64_t(int64_t(int32_t(r_PtxRegister32)) * int64_t(int32_t(4))); // PTX L1089
	r_PtxU64Register169 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register78);		// PTX L1090
L__BB41_112:																				// PTX L1091
	if (r_bPtxPredicate79)
	{
		goto L__BB41_115;
	} // PTX L1092
	r_PtxRegister335 = uint32_t(-1);							   // PTX L1093
	r_PtxRegister334 = Elected(r_PtxRegister335);				   // PTX L1095
	r_bPtxPredicate81 = uint32_t(r_PtxRegister334) == uint32_t(0); // PTX L1101
	if (r_bPtxPredicate81)
	{
		goto L__BB41_116;
	} // PTX L1102
	r_PtxRegister336 = uint32_t(r_PtxRegister31) + uint32_t(16896); // PTX L1103
	r_PtxU64Register79 = r_PtxU64Register169;						// PTX L1104
	r_PtxRegister339 = uint32_t(24576u /* native mbarriers */);		// PTX L1105
	r_PtxRegister338 = uint32_t(r_PtxRegister339) + uint32_t(16);	// PTX L1106
	r_PtxRegister337 = uint32_t(512);								// PTX L1107
	CopyBulk(s_SharedStorage, r_PtxRegister336, r_PtxU64Register79, r_PtxRegister337,
			 r_PtxRegister338);																   // PTX L1109
	BarrierExpect(s_SharedStorage, r_PtxRegister338, r_PtxRegister337);						   // PTX L1112
	goto L__BB41_116;																		   // PTX L1114
L__BB41_115:																				   // PTX L1115
	r_PtxRegister327 = uint32_t(0);															   // PTX L1116
	r_PtxU16Register29 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister327))); // PTX L1118
	r_PackedHalf2AtPtx1121R328 = JoinHalfwords(r_PtxU16Register29, r_PtxU16Register29);		   // PTX L1121
	r_ConvertedE4PairAtPtx1123Rs30 = PublishE4(r_PackedHalf2AtPtx1121R328);					   // PTX L1123
	r_PackedE4WordAtPtx1125R331 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1123Rs30, r_ConvertedE4PairAtPtx1123Rs30); // PTX L1125
	r_LaneIndexAtPtx1127 = uint32_t((threadIdx.x & 31u));							   // PTX L1127
	r_PtxRegister332 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1127), uint32_t(4));		   // PTX L1129
	r_PtxRegister333 = uint32_t(r_PtxRegister31) + uint32_t(r_PtxRegister332);		   // PTX L1130
	r_PtxRegister330 = uint32_t(r_PtxRegister333) + uint32_t(16896);				   // PTX L1131
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister330)) =
		make_uint4(r_PackedE4WordAtPtx1125R331, r_PackedE4WordAtPtx1125R331, r_PackedE4WordAtPtx1125R331,
				   r_PackedE4WordAtPtx1125R331);				// PTX L1133
L__BB41_116:													// PTX L1135
	r_PtxRegister340 = uint32_t(24576u /* native mbarriers */); // PTX L1136
	r_PtxRegister341 = uint32_t(1);								// PTX L1137
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register80 = BarrierArrive(s_SharedStorage, r_PtxRegister340, r_PtxRegister341); // PTX L1139
L__BB41_117:																				 // PTX L1141
	r_PtxRegister343 = uint32_t(24576u /* native mbarriers */);								 // PTX L1142
	r_PtxRegister342 = BarrierReady(s_SharedStorage, r_PtxRegister343, r_PtxU64Register80);	 // PTX L1144
	r_bPtxPredicate82 = uint32_t(r_PtxRegister342) == uint32_t(0);							 // PTX L1150
	if (r_bPtxPredicate82)
	{
		goto L__BB41_117;
	} // PTX L1151
	r_PtxRegister344 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));				   // PTX L1152
	r_PtxRegister33 = r_PtxRegister344 & 2044;									   // PTX L1153
	r_PtxRegister34 = uint32_t(r_PtxRegister20) + uint32_t(128);				   // PTX L1154
	r_PtxRegister345 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(11));			   // PTX L1155
	r_PtxRegister35 = r_PtxRegister345 & 2093056;								   // PTX L1156
	r_PtxRegister346 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));				   // PTX L1157
	r_PtxRegister36 = r_PtxRegister346 & 523264;								   // PTX L1158
	r_PtxRegister37 = uint32_t(r_PtxRegister8) + uint32_t(128);					   // PTX L1159
	r_PtxRegister1138 = uint32_t(0);											   // PTX L1160
	r_PtxRegister465 = ShiftLeft(uint32_t(r_PtxRegister36), uint32_t(2));		   // PTX L1161
	r_MmaAccumulatorHalf2WordAtPtx1162R1075 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1162
	r_MmaAccumulatorHalf2WordAtPtx1163R1076 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1163
	r_MmaAccumulatorHalf2WordAtPtx1164R1077 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1164
	r_MmaAccumulatorHalf2WordAtPtx1165R1078 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1165
	r_MmaAccumulatorHalf2WordAtPtx1166R1079 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1166
	r_MmaAccumulatorHalf2WordAtPtx1167R1080 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1167
	r_MmaAccumulatorHalf2WordAtPtx1168R1081 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1168
	r_MmaAccumulatorHalf2WordAtPtx1169R1082 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1169
	r_MmaAccumulatorHalf2WordAtPtx1170R1083 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1170
	r_MmaAccumulatorHalf2WordAtPtx1171R1084 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1171
	r_MmaAccumulatorHalf2WordAtPtx1172R1085 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1172
	r_MmaAccumulatorHalf2WordAtPtx1173R1086 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1173
	r_MmaAccumulatorHalf2WordAtPtx1174R1087 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1174
	r_MmaAccumulatorHalf2WordAtPtx1175R1088 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1175
	r_MmaAccumulatorHalf2WordAtPtx1176R1089 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1176
	r_MmaAccumulatorHalf2WordAtPtx1177R1090 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1177
	r_MmaAccumulatorHalf2WordAtPtx1178R1091 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1178
	r_MmaAccumulatorHalf2WordAtPtx1179R1092 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1179
	r_MmaAccumulatorHalf2WordAtPtx1180R1093 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1180
	r_MmaAccumulatorHalf2WordAtPtx1181R1094 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1181
	r_MmaAccumulatorHalf2WordAtPtx1182R1095 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1182
	r_MmaAccumulatorHalf2WordAtPtx1183R1096 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1183
	r_MmaAccumulatorHalf2WordAtPtx1184R1097 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1184
	r_MmaAccumulatorHalf2WordAtPtx1185R1098 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1185
	r_MmaAccumulatorHalf2WordAtPtx1186R1099 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1186
	r_MmaAccumulatorHalf2WordAtPtx1187R1100 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1187
	r_MmaAccumulatorHalf2WordAtPtx1188R1101 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1188
	r_MmaAccumulatorHalf2WordAtPtx1189R1102 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1189
	r_MmaAccumulatorHalf2WordAtPtx1190R1103 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1190
	r_MmaAccumulatorHalf2WordAtPtx1191R1104 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1191
	r_MmaAccumulatorHalf2WordAtPtx1192R1105 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1192
	r_MmaAccumulatorHalf2WordAtPtx1193R1106 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1193
	r_MmaAccumulatorHalf2WordAtPtx1194R1107 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1194
	r_MmaAccumulatorHalf2WordAtPtx1195R1108 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1195
	r_MmaAccumulatorHalf2WordAtPtx1196R1109 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1196
	r_MmaAccumulatorHalf2WordAtPtx1197R1110 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1197
	r_MmaAccumulatorHalf2WordAtPtx1198R1111 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1198
	r_MmaAccumulatorHalf2WordAtPtx1199R1112 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1199
	r_MmaAccumulatorHalf2WordAtPtx1200R1113 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1200
	r_MmaAccumulatorHalf2WordAtPtx1201R1114 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1201
	r_MmaAccumulatorHalf2WordAtPtx1202R1115 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1202
	r_MmaAccumulatorHalf2WordAtPtx1203R1116 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1203
	r_MmaAccumulatorHalf2WordAtPtx1204R1117 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1204
	r_MmaAccumulatorHalf2WordAtPtx1205R1118 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1205
	r_MmaAccumulatorHalf2WordAtPtx1206R1119 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1206
	r_MmaAccumulatorHalf2WordAtPtx1207R1120 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1207
	r_MmaAccumulatorHalf2WordAtPtx1208R1121 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1208
	r_MmaAccumulatorHalf2WordAtPtx1209R1122 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1209
	r_MmaAccumulatorHalf2WordAtPtx1210R1123 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1210
	r_MmaAccumulatorHalf2WordAtPtx1211R1124 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1211
	r_MmaAccumulatorHalf2WordAtPtx1212R1125 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1212
	r_MmaAccumulatorHalf2WordAtPtx1213R1126 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1213
	r_MmaAccumulatorHalf2WordAtPtx1214R1127 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1214
	r_MmaAccumulatorHalf2WordAtPtx1215R1128 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1215
	r_MmaAccumulatorHalf2WordAtPtx1216R1129 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1216
	r_MmaAccumulatorHalf2WordAtPtx1217R1130 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1217
	r_MmaAccumulatorHalf2WordAtPtx1218R1131 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1218
	r_MmaAccumulatorHalf2WordAtPtx1219R1132 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1219
	r_MmaAccumulatorHalf2WordAtPtx1220R1133 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1220
	r_MmaAccumulatorHalf2WordAtPtx1221R1134 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1221
	r_MmaAccumulatorHalf2WordAtPtx1222R1135 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1222
	r_MmaAccumulatorHalf2WordAtPtx1223R1136 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1223
	r_MmaAccumulatorHalf2WordAtPtx1224R1137 = uint32_t(r_PackedHalf2AtPtx59R1074); // PTX L1224
L__BB41_119:																	   // PTX L1225
	r_PtxRegister459 = ShiftRight(uint32_t(r_PtxRegister1138), uint32_t(6));	   // PTX L1226
	r_PtxU16Register31 = uint16_t(r_PtxRegister459);							   // PTX L1227
	r_PtxU16Register32 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register31)) * uint32_t(uint16_t(171))); // PTX L1228
	r_PtxU16Register33 = ShiftRight(uint16_t(r_PtxU16Register32), uint32_t(9));		// PTX L1229
	r_PtxU16Register34 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register33)) * uint32_t(uint16_t(3)));		  // PTX L1230
	r_PtxU16Register35 = uint16_t(r_PtxU16Register31) - uint16_t(r_PtxU16Register34);	  // PTX L1231
	r_PtxRegister460 = uint32_t(r_PtxU16Register35);									  // PTX L1232
	r_PtxRegister38 = r_PtxRegister460 & 255;											  // PTX L1233
	r_PtxU16Register36 = r_PtxU16Register35 & 255;										  // PTX L1234
	r_PtxRegister461 = uint32_t(uint16_t(r_PtxU16Register36)) * uint32_t(uint16_t(8192)); // PTX L1235
	r_PtxU64Register5 = uint64_t(r_PtxRegister461);										  // PTX L1236
	r_PtxRegister462 = uint32_t(0u /* native shared input */);							  // PTX L1237
	r_PtxRegister39 = uint32_t(r_PtxRegister462) + uint32_t(r_PtxRegister461);			  // PTX L1238
	r_LaneIndexAtPtx1240 = uint32_t((threadIdx.x & 31u));								  // PTX L1240
	r_PtxRegister463 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister35);			  // PTX L1242
	r_PtxRegister464 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1240), uint32_t(4));			  // PTX L1243
	r_PtxRegister348 = uint32_t(r_PtxRegister463) + uint32_t(r_PtxRegister464);			  // PTX L1244
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister348));
		r_MmaAE4x4WordAtPtx1246R363 = r_Value.x;
		r_MmaAE4x4WordAtPtx1246R364 = r_Value.y;
		r_MmaAE4x4WordAtPtx1246R365 = r_Value.z;
		r_MmaAE4x4WordAtPtx1246R366 = r_Value.w;
	} // PTX L1246
	r_LaneIndexAtPtx1249 = uint32_t((threadIdx.x & 31u));						// PTX L1249
	r_PtxRegister466 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister465);	// PTX L1251
	r_PtxRegister467 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1249), uint32_t(4));	// PTX L1252
	r_PtxRegister468 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister467); // PTX L1253
	r_PtxRegister350 = uint32_t(r_PtxRegister468) + uint32_t(512);				// PTX L1254
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister350));
		r_MmaAE4x4WordAtPtx1256R367 = r_Value.x;
		r_MmaAE4x4WordAtPtx1256R368 = r_Value.y;
		r_MmaAE4x4WordAtPtx1256R369 = r_Value.z;
		r_MmaAE4x4WordAtPtx1256R370 = r_Value.w;
	} // PTX L1256
	r_LaneIndexAtPtx1259 = uint32_t((threadIdx.x & 31u));						// PTX L1259
	r_PtxRegister469 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1259), uint32_t(4));	// PTX L1261
	r_PtxRegister470 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister469); // PTX L1262
	r_PtxRegister352 = uint32_t(r_PtxRegister470) + uint32_t(1024);				// PTX L1263
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister352));
		r_MmaAE4x4WordAtPtx1265R387 = r_Value.x;
		r_MmaAE4x4WordAtPtx1265R388 = r_Value.y;
		r_MmaAE4x4WordAtPtx1265R389 = r_Value.z;
		r_MmaAE4x4WordAtPtx1265R390 = r_Value.w;
	} // PTX L1265
	r_LaneIndexAtPtx1268 = uint32_t((threadIdx.x & 31u));						// PTX L1268
	r_PtxRegister471 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1268), uint32_t(4));	// PTX L1270
	r_PtxRegister472 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister471); // PTX L1271
	r_PtxRegister354 = uint32_t(r_PtxRegister472) + uint32_t(1536);				// PTX L1272
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister354));
		r_MmaAE4x4WordAtPtx1274R391 = r_Value.x;
		r_MmaAE4x4WordAtPtx1274R392 = r_Value.y;
		r_MmaAE4x4WordAtPtx1274R393 = r_Value.z;
		r_MmaAE4x4WordAtPtx1274R394 = r_Value.w;
	} // PTX L1274
	r_LaneIndexAtPtx1277 = uint32_t((threadIdx.x & 31u));						// PTX L1277
	r_PtxRegister473 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1277), uint32_t(4));	// PTX L1279
	r_PtxRegister474 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister473); // PTX L1280
	r_PtxRegister356 = uint32_t(r_PtxRegister474) + uint32_t(2048);				// PTX L1281
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister356));
		r_MmaAE4x4WordAtPtx1283R411 = r_Value.x;
		r_MmaAE4x4WordAtPtx1283R412 = r_Value.y;
		r_MmaAE4x4WordAtPtx1283R413 = r_Value.z;
		r_MmaAE4x4WordAtPtx1283R414 = r_Value.w;
	} // PTX L1283
	r_LaneIndexAtPtx1286 = uint32_t((threadIdx.x & 31u));						// PTX L1286
	r_PtxRegister475 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1286), uint32_t(4));	// PTX L1288
	r_PtxRegister476 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister475); // PTX L1289
	r_PtxRegister358 = uint32_t(r_PtxRegister476) + uint32_t(2560);				// PTX L1290
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister358));
		r_MmaAE4x4WordAtPtx1292R415 = r_Value.x;
		r_MmaAE4x4WordAtPtx1292R416 = r_Value.y;
		r_MmaAE4x4WordAtPtx1292R417 = r_Value.z;
		r_MmaAE4x4WordAtPtx1292R418 = r_Value.w;
	} // PTX L1292
	r_LaneIndexAtPtx1295 = uint32_t((threadIdx.x & 31u));						// PTX L1295
	r_PtxRegister477 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1295), uint32_t(4));	// PTX L1297
	r_PtxRegister478 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister477); // PTX L1298
	r_PtxRegister360 = uint32_t(r_PtxRegister478) + uint32_t(3072);				// PTX L1299
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister360));
		r_MmaAE4x4WordAtPtx1301R435 = r_Value.x;
		r_MmaAE4x4WordAtPtx1301R436 = r_Value.y;
		r_MmaAE4x4WordAtPtx1301R437 = r_Value.z;
		r_MmaAE4x4WordAtPtx1301R438 = r_Value.w;
	} // PTX L1301
	r_LaneIndexAtPtx1304 = uint32_t((threadIdx.x & 31u));						// PTX L1304
	r_PtxRegister479 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1304), uint32_t(4));	// PTX L1306
	r_PtxRegister480 = uint32_t(r_PtxRegister466) + uint32_t(r_PtxRegister479); // PTX L1307
	r_PtxRegister362 = uint32_t(r_PtxRegister480) + uint32_t(3584);				// PTX L1308
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister362));
		r_MmaAE4x4WordAtPtx1310R439 = r_Value.x;
		r_MmaAE4x4WordAtPtx1310R440 = r_Value.y;
		r_MmaAE4x4WordAtPtx1310R441 = r_Value.z;
		r_MmaAE4x4WordAtPtx1310R442 = r_Value.w;
	} // PTX L1310
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1313R371, r_MmaAccumulatorHalf2WordAtPtx1313R372,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx79R1164, r_MmaBE4x4WordAtPtx79R1163,
		  r_MmaAccumulatorHalf2WordAtPtx1216R1129,
		  r_MmaAccumulatorHalf2WordAtPtx1215R1128); // PTX L1313
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1320R373, r_MmaAccumulatorHalf2WordAtPtx1320R374,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx79R1162, r_MmaBE4x4WordAtPtx79R1161,
		  r_MmaAccumulatorHalf2WordAtPtx1214R1127,
		  r_MmaAccumulatorHalf2WordAtPtx1213R1126); // PTX L1320
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1216R1129, r_MmaAccumulatorHalf2WordAtPtx1215R1128,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx115R1148, r_MmaBE4x4WordAtPtx115R1147,
		  r_MmaAccumulatorHalf2WordAtPtx1313R371,
		  r_MmaAccumulatorHalf2WordAtPtx1313R372); // PTX L1327
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1214R1127, r_MmaAccumulatorHalf2WordAtPtx1213R1126,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx115R1146, r_MmaBE4x4WordAtPtx115R1145,
		  r_MmaAccumulatorHalf2WordAtPtx1320R373,
		  r_MmaAccumulatorHalf2WordAtPtx1320R374); // PTX L1334
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1341R375, r_MmaAccumulatorHalf2WordAtPtx1341R376,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx88R1160, r_MmaBE4x4WordAtPtx88R1159,
		  r_MmaAccumulatorHalf2WordAtPtx1212R1125,
		  r_MmaAccumulatorHalf2WordAtPtx1211R1124); // PTX L1341
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1348R377, r_MmaAccumulatorHalf2WordAtPtx1348R378,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx88R1158, r_MmaBE4x4WordAtPtx88R1157,
		  r_MmaAccumulatorHalf2WordAtPtx1210R1123,
		  r_MmaAccumulatorHalf2WordAtPtx1209R1122); // PTX L1348
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1212R1125, r_MmaAccumulatorHalf2WordAtPtx1211R1124,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx124R1144, r_MmaBE4x4WordAtPtx124R1143,
		  r_MmaAccumulatorHalf2WordAtPtx1341R375,
		  r_MmaAccumulatorHalf2WordAtPtx1341R376); // PTX L1355
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1210R1123, r_MmaAccumulatorHalf2WordAtPtx1209R1122,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx124R1142, r_MmaBE4x4WordAtPtx124R1141,
		  r_MmaAccumulatorHalf2WordAtPtx1348R377,
		  r_MmaAccumulatorHalf2WordAtPtx1348R378); // PTX L1362
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1369R379, r_MmaAccumulatorHalf2WordAtPtx1369R380,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx97R1156, r_MmaBE4x4WordAtPtx97R1155,
		  r_MmaAccumulatorHalf2WordAtPtx1208R1121,
		  r_MmaAccumulatorHalf2WordAtPtx1207R1120); // PTX L1369
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1376R381, r_MmaAccumulatorHalf2WordAtPtx1376R382,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx97R1154, r_MmaBE4x4WordAtPtx97R1153,
		  r_MmaAccumulatorHalf2WordAtPtx1206R1119,
		  r_MmaAccumulatorHalf2WordAtPtx1205R1118); // PTX L1376
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1208R1121, r_MmaAccumulatorHalf2WordAtPtx1207R1120,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx133R1140, r_MmaBE4x4WordAtPtx133R1139,
		  r_MmaAccumulatorHalf2WordAtPtx1369R379,
		  r_MmaAccumulatorHalf2WordAtPtx1369R380); // PTX L1383
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1206R1119, r_MmaAccumulatorHalf2WordAtPtx1205R1118,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx133R1165, r_MmaBE4x4WordAtPtx133R1166,
		  r_MmaAccumulatorHalf2WordAtPtx1376R381,
		  r_MmaAccumulatorHalf2WordAtPtx1376R382); // PTX L1390
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1397R383, r_MmaAccumulatorHalf2WordAtPtx1397R384,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx106R1152, r_MmaBE4x4WordAtPtx106R1151,
		  r_MmaAccumulatorHalf2WordAtPtx1204R1117,
		  r_MmaAccumulatorHalf2WordAtPtx1203R1116); // PTX L1397
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1404R385, r_MmaAccumulatorHalf2WordAtPtx1404R386,
		  r_MmaAE4x4WordAtPtx1246R363, r_MmaAE4x4WordAtPtx1246R364, r_MmaAE4x4WordAtPtx1246R365,
		  r_MmaAE4x4WordAtPtx1246R366, r_MmaBE4x4WordAtPtx106R1150, r_MmaBE4x4WordAtPtx106R1149,
		  r_MmaAccumulatorHalf2WordAtPtx1202R1115,
		  r_MmaAccumulatorHalf2WordAtPtx1201R1114); // PTX L1404
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1204R1117, r_MmaAccumulatorHalf2WordAtPtx1203R1116,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx142R1167, r_MmaBE4x4WordAtPtx142R1168,
		  r_MmaAccumulatorHalf2WordAtPtx1397R383,
		  r_MmaAccumulatorHalf2WordAtPtx1397R384); // PTX L1411
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1202R1115, r_MmaAccumulatorHalf2WordAtPtx1201R1114,
		  r_MmaAE4x4WordAtPtx1256R367, r_MmaAE4x4WordAtPtx1256R368, r_MmaAE4x4WordAtPtx1256R369,
		  r_MmaAE4x4WordAtPtx1256R370, r_MmaBE4x4WordAtPtx142R1169, r_MmaBE4x4WordAtPtx142R1170,
		  r_MmaAccumulatorHalf2WordAtPtx1404R385,
		  r_MmaAccumulatorHalf2WordAtPtx1404R386); // PTX L1418
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1425R395, r_MmaAccumulatorHalf2WordAtPtx1425R396,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx79R1164, r_MmaBE4x4WordAtPtx79R1163,
		  r_MmaAccumulatorHalf2WordAtPtx1200R1113,
		  r_MmaAccumulatorHalf2WordAtPtx1199R1112); // PTX L1425
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1432R397, r_MmaAccumulatorHalf2WordAtPtx1432R398,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx79R1162, r_MmaBE4x4WordAtPtx79R1161,
		  r_MmaAccumulatorHalf2WordAtPtx1198R1111,
		  r_MmaAccumulatorHalf2WordAtPtx1197R1110); // PTX L1432
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1200R1113, r_MmaAccumulatorHalf2WordAtPtx1199R1112,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx115R1148, r_MmaBE4x4WordAtPtx115R1147,
		  r_MmaAccumulatorHalf2WordAtPtx1425R395,
		  r_MmaAccumulatorHalf2WordAtPtx1425R396); // PTX L1439
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1198R1111, r_MmaAccumulatorHalf2WordAtPtx1197R1110,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx115R1146, r_MmaBE4x4WordAtPtx115R1145,
		  r_MmaAccumulatorHalf2WordAtPtx1432R397,
		  r_MmaAccumulatorHalf2WordAtPtx1432R398); // PTX L1446
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1453R399, r_MmaAccumulatorHalf2WordAtPtx1453R400,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx88R1160, r_MmaBE4x4WordAtPtx88R1159,
		  r_MmaAccumulatorHalf2WordAtPtx1196R1109,
		  r_MmaAccumulatorHalf2WordAtPtx1195R1108); // PTX L1453
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1460R401, r_MmaAccumulatorHalf2WordAtPtx1460R402,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx88R1158, r_MmaBE4x4WordAtPtx88R1157,
		  r_MmaAccumulatorHalf2WordAtPtx1194R1107,
		  r_MmaAccumulatorHalf2WordAtPtx1193R1106); // PTX L1460
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1196R1109, r_MmaAccumulatorHalf2WordAtPtx1195R1108,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx124R1144, r_MmaBE4x4WordAtPtx124R1143,
		  r_MmaAccumulatorHalf2WordAtPtx1453R399,
		  r_MmaAccumulatorHalf2WordAtPtx1453R400); // PTX L1467
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1194R1107, r_MmaAccumulatorHalf2WordAtPtx1193R1106,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx124R1142, r_MmaBE4x4WordAtPtx124R1141,
		  r_MmaAccumulatorHalf2WordAtPtx1460R401,
		  r_MmaAccumulatorHalf2WordAtPtx1460R402); // PTX L1474
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1481R403, r_MmaAccumulatorHalf2WordAtPtx1481R404,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx97R1156, r_MmaBE4x4WordAtPtx97R1155,
		  r_MmaAccumulatorHalf2WordAtPtx1192R1105,
		  r_MmaAccumulatorHalf2WordAtPtx1191R1104); // PTX L1481
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1488R405, r_MmaAccumulatorHalf2WordAtPtx1488R406,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx97R1154, r_MmaBE4x4WordAtPtx97R1153,
		  r_MmaAccumulatorHalf2WordAtPtx1190R1103,
		  r_MmaAccumulatorHalf2WordAtPtx1189R1102); // PTX L1488
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1192R1105, r_MmaAccumulatorHalf2WordAtPtx1191R1104,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx133R1140, r_MmaBE4x4WordAtPtx133R1139,
		  r_MmaAccumulatorHalf2WordAtPtx1481R403,
		  r_MmaAccumulatorHalf2WordAtPtx1481R404); // PTX L1495
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1190R1103, r_MmaAccumulatorHalf2WordAtPtx1189R1102,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx133R1165, r_MmaBE4x4WordAtPtx133R1166,
		  r_MmaAccumulatorHalf2WordAtPtx1488R405,
		  r_MmaAccumulatorHalf2WordAtPtx1488R406); // PTX L1502
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1509R407, r_MmaAccumulatorHalf2WordAtPtx1509R408,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx106R1152, r_MmaBE4x4WordAtPtx106R1151,
		  r_MmaAccumulatorHalf2WordAtPtx1188R1101,
		  r_MmaAccumulatorHalf2WordAtPtx1187R1100); // PTX L1509
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1516R409, r_MmaAccumulatorHalf2WordAtPtx1516R410,
		  r_MmaAE4x4WordAtPtx1265R387, r_MmaAE4x4WordAtPtx1265R388, r_MmaAE4x4WordAtPtx1265R389,
		  r_MmaAE4x4WordAtPtx1265R390, r_MmaBE4x4WordAtPtx106R1150, r_MmaBE4x4WordAtPtx106R1149,
		  r_MmaAccumulatorHalf2WordAtPtx1186R1099,
		  r_MmaAccumulatorHalf2WordAtPtx1185R1098); // PTX L1516
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1188R1101, r_MmaAccumulatorHalf2WordAtPtx1187R1100,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx142R1167, r_MmaBE4x4WordAtPtx142R1168,
		  r_MmaAccumulatorHalf2WordAtPtx1509R407,
		  r_MmaAccumulatorHalf2WordAtPtx1509R408); // PTX L1523
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1186R1099, r_MmaAccumulatorHalf2WordAtPtx1185R1098,
		  r_MmaAE4x4WordAtPtx1274R391, r_MmaAE4x4WordAtPtx1274R392, r_MmaAE4x4WordAtPtx1274R393,
		  r_MmaAE4x4WordAtPtx1274R394, r_MmaBE4x4WordAtPtx142R1169, r_MmaBE4x4WordAtPtx142R1170,
		  r_MmaAccumulatorHalf2WordAtPtx1516R409,
		  r_MmaAccumulatorHalf2WordAtPtx1516R410); // PTX L1530
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1537R419, r_MmaAccumulatorHalf2WordAtPtx1537R420,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx79R1164, r_MmaBE4x4WordAtPtx79R1163,
		  r_MmaAccumulatorHalf2WordAtPtx1184R1097,
		  r_MmaAccumulatorHalf2WordAtPtx1183R1096); // PTX L1537
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1544R421, r_MmaAccumulatorHalf2WordAtPtx1544R422,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx79R1162, r_MmaBE4x4WordAtPtx79R1161,
		  r_MmaAccumulatorHalf2WordAtPtx1182R1095,
		  r_MmaAccumulatorHalf2WordAtPtx1181R1094); // PTX L1544
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1184R1097, r_MmaAccumulatorHalf2WordAtPtx1183R1096,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx115R1148, r_MmaBE4x4WordAtPtx115R1147,
		  r_MmaAccumulatorHalf2WordAtPtx1537R419,
		  r_MmaAccumulatorHalf2WordAtPtx1537R420); // PTX L1551
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1182R1095, r_MmaAccumulatorHalf2WordAtPtx1181R1094,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx115R1146, r_MmaBE4x4WordAtPtx115R1145,
		  r_MmaAccumulatorHalf2WordAtPtx1544R421,
		  r_MmaAccumulatorHalf2WordAtPtx1544R422); // PTX L1558
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1565R423, r_MmaAccumulatorHalf2WordAtPtx1565R424,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx88R1160, r_MmaBE4x4WordAtPtx88R1159,
		  r_MmaAccumulatorHalf2WordAtPtx1180R1093,
		  r_MmaAccumulatorHalf2WordAtPtx1179R1092); // PTX L1565
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1572R425, r_MmaAccumulatorHalf2WordAtPtx1572R426,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx88R1158, r_MmaBE4x4WordAtPtx88R1157,
		  r_MmaAccumulatorHalf2WordAtPtx1178R1091,
		  r_MmaAccumulatorHalf2WordAtPtx1177R1090); // PTX L1572
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1180R1093, r_MmaAccumulatorHalf2WordAtPtx1179R1092,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx124R1144, r_MmaBE4x4WordAtPtx124R1143,
		  r_MmaAccumulatorHalf2WordAtPtx1565R423,
		  r_MmaAccumulatorHalf2WordAtPtx1565R424); // PTX L1579
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1178R1091, r_MmaAccumulatorHalf2WordAtPtx1177R1090,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx124R1142, r_MmaBE4x4WordAtPtx124R1141,
		  r_MmaAccumulatorHalf2WordAtPtx1572R425,
		  r_MmaAccumulatorHalf2WordAtPtx1572R426); // PTX L1586
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1593R427, r_MmaAccumulatorHalf2WordAtPtx1593R428,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx97R1156, r_MmaBE4x4WordAtPtx97R1155,
		  r_MmaAccumulatorHalf2WordAtPtx1176R1089,
		  r_MmaAccumulatorHalf2WordAtPtx1175R1088); // PTX L1593
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1600R429, r_MmaAccumulatorHalf2WordAtPtx1600R430,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx97R1154, r_MmaBE4x4WordAtPtx97R1153,
		  r_MmaAccumulatorHalf2WordAtPtx1174R1087,
		  r_MmaAccumulatorHalf2WordAtPtx1173R1086); // PTX L1600
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1176R1089, r_MmaAccumulatorHalf2WordAtPtx1175R1088,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx133R1140, r_MmaBE4x4WordAtPtx133R1139,
		  r_MmaAccumulatorHalf2WordAtPtx1593R427,
		  r_MmaAccumulatorHalf2WordAtPtx1593R428); // PTX L1607
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1174R1087, r_MmaAccumulatorHalf2WordAtPtx1173R1086,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx133R1165, r_MmaBE4x4WordAtPtx133R1166,
		  r_MmaAccumulatorHalf2WordAtPtx1600R429,
		  r_MmaAccumulatorHalf2WordAtPtx1600R430); // PTX L1614
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1621R431, r_MmaAccumulatorHalf2WordAtPtx1621R432,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx106R1152, r_MmaBE4x4WordAtPtx106R1151,
		  r_MmaAccumulatorHalf2WordAtPtx1172R1085,
		  r_MmaAccumulatorHalf2WordAtPtx1171R1084); // PTX L1621
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1628R433, r_MmaAccumulatorHalf2WordAtPtx1628R434,
		  r_MmaAE4x4WordAtPtx1283R411, r_MmaAE4x4WordAtPtx1283R412, r_MmaAE4x4WordAtPtx1283R413,
		  r_MmaAE4x4WordAtPtx1283R414, r_MmaBE4x4WordAtPtx106R1150, r_MmaBE4x4WordAtPtx106R1149,
		  r_MmaAccumulatorHalf2WordAtPtx1170R1083,
		  r_MmaAccumulatorHalf2WordAtPtx1169R1082); // PTX L1628
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1172R1085, r_MmaAccumulatorHalf2WordAtPtx1171R1084,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx142R1167, r_MmaBE4x4WordAtPtx142R1168,
		  r_MmaAccumulatorHalf2WordAtPtx1621R431,
		  r_MmaAccumulatorHalf2WordAtPtx1621R432); // PTX L1635
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1170R1083, r_MmaAccumulatorHalf2WordAtPtx1169R1082,
		  r_MmaAE4x4WordAtPtx1292R415, r_MmaAE4x4WordAtPtx1292R416, r_MmaAE4x4WordAtPtx1292R417,
		  r_MmaAE4x4WordAtPtx1292R418, r_MmaBE4x4WordAtPtx142R1169, r_MmaBE4x4WordAtPtx142R1170,
		  r_MmaAccumulatorHalf2WordAtPtx1628R433,
		  r_MmaAccumulatorHalf2WordAtPtx1628R434); // PTX L1642
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1649R443, r_MmaAccumulatorHalf2WordAtPtx1649R444,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx79R1164, r_MmaBE4x4WordAtPtx79R1163,
		  r_MmaAccumulatorHalf2WordAtPtx1168R1081,
		  r_MmaAccumulatorHalf2WordAtPtx1167R1080); // PTX L1649
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1656R445, r_MmaAccumulatorHalf2WordAtPtx1656R446,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx79R1162, r_MmaBE4x4WordAtPtx79R1161,
		  r_MmaAccumulatorHalf2WordAtPtx1166R1079,
		  r_MmaAccumulatorHalf2WordAtPtx1165R1078); // PTX L1656
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1168R1081, r_MmaAccumulatorHalf2WordAtPtx1167R1080,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx115R1148, r_MmaBE4x4WordAtPtx115R1147,
		  r_MmaAccumulatorHalf2WordAtPtx1649R443,
		  r_MmaAccumulatorHalf2WordAtPtx1649R444); // PTX L1663
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1166R1079, r_MmaAccumulatorHalf2WordAtPtx1165R1078,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx115R1146, r_MmaBE4x4WordAtPtx115R1145,
		  r_MmaAccumulatorHalf2WordAtPtx1656R445,
		  r_MmaAccumulatorHalf2WordAtPtx1656R446); // PTX L1670
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1677R447, r_MmaAccumulatorHalf2WordAtPtx1677R448,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx88R1160, r_MmaBE4x4WordAtPtx88R1159,
		  r_MmaAccumulatorHalf2WordAtPtx1164R1077,
		  r_MmaAccumulatorHalf2WordAtPtx1163R1076); // PTX L1677
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1684R449, r_MmaAccumulatorHalf2WordAtPtx1684R450,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx88R1158, r_MmaBE4x4WordAtPtx88R1157,
		  r_MmaAccumulatorHalf2WordAtPtx1162R1075, r_PackedHalf2AtPtx59R1074); // PTX L1684
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1164R1077, r_MmaAccumulatorHalf2WordAtPtx1163R1076,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx124R1144, r_MmaBE4x4WordAtPtx124R1143,
		  r_MmaAccumulatorHalf2WordAtPtx1677R447,
		  r_MmaAccumulatorHalf2WordAtPtx1677R448); // PTX L1691
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1162R1075, r_PackedHalf2AtPtx59R1074, r_MmaAE4x4WordAtPtx1310R439,
		  r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441, r_MmaAE4x4WordAtPtx1310R442,
		  r_MmaBE4x4WordAtPtx124R1142, r_MmaBE4x4WordAtPtx124R1141, r_MmaAccumulatorHalf2WordAtPtx1684R449,
		  r_MmaAccumulatorHalf2WordAtPtx1684R450); // PTX L1698
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1705R451, r_MmaAccumulatorHalf2WordAtPtx1705R452,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx97R1156, r_MmaBE4x4WordAtPtx97R1155,
		  r_MmaAccumulatorHalf2WordAtPtx1217R1130,
		  r_MmaAccumulatorHalf2WordAtPtx1218R1131); // PTX L1705
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1712R453, r_MmaAccumulatorHalf2WordAtPtx1712R454,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx97R1154, r_MmaBE4x4WordAtPtx97R1153,
		  r_MmaAccumulatorHalf2WordAtPtx1219R1132,
		  r_MmaAccumulatorHalf2WordAtPtx1220R1133); // PTX L1712
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1217R1130, r_MmaAccumulatorHalf2WordAtPtx1218R1131,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx133R1140, r_MmaBE4x4WordAtPtx133R1139,
		  r_MmaAccumulatorHalf2WordAtPtx1705R451,
		  r_MmaAccumulatorHalf2WordAtPtx1705R452); // PTX L1719
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1219R1132, r_MmaAccumulatorHalf2WordAtPtx1220R1133,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx133R1165, r_MmaBE4x4WordAtPtx133R1166,
		  r_MmaAccumulatorHalf2WordAtPtx1712R453,
		  r_MmaAccumulatorHalf2WordAtPtx1712R454); // PTX L1726
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1733R455, r_MmaAccumulatorHalf2WordAtPtx1733R456,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx106R1152, r_MmaBE4x4WordAtPtx106R1151,
		  r_MmaAccumulatorHalf2WordAtPtx1221R1134,
		  r_MmaAccumulatorHalf2WordAtPtx1222R1135); // PTX L1733
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1740R457, r_MmaAccumulatorHalf2WordAtPtx1740R458,
		  r_MmaAE4x4WordAtPtx1301R435, r_MmaAE4x4WordAtPtx1301R436, r_MmaAE4x4WordAtPtx1301R437,
		  r_MmaAE4x4WordAtPtx1301R438, r_MmaBE4x4WordAtPtx106R1150, r_MmaBE4x4WordAtPtx106R1149,
		  r_MmaAccumulatorHalf2WordAtPtx1223R1136,
		  r_MmaAccumulatorHalf2WordAtPtx1224R1137); // PTX L1740
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1221R1134, r_MmaAccumulatorHalf2WordAtPtx1222R1135,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx142R1167, r_MmaBE4x4WordAtPtx142R1168,
		  r_MmaAccumulatorHalf2WordAtPtx1733R455,
		  r_MmaAccumulatorHalf2WordAtPtx1733R456); // PTX L1747
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1223R1136, r_MmaAccumulatorHalf2WordAtPtx1224R1137,
		  r_MmaAE4x4WordAtPtx1310R439, r_MmaAE4x4WordAtPtx1310R440, r_MmaAE4x4WordAtPtx1310R441,
		  r_MmaAE4x4WordAtPtx1310R442, r_MmaBE4x4WordAtPtx142R1169, r_MmaBE4x4WordAtPtx142R1170,
		  r_MmaAccumulatorHalf2WordAtPtx1740R457,
		  r_MmaAccumulatorHalf2WordAtPtx1740R458);					 // PTX L1754
	r_bPtxPredicate83 = uint32_t(r_PtxRegister1138) > uint32_t(959); // PTX L1760
	if (r_bPtxPredicate83)
	{
		goto L__BB41_122;
	} // PTX L1761
	r_PtxRegister490 = uint32_t(r_PtxRegister1138) + uint32_t(64);								  // PTX L1762
	r_PtxRegister491 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister1138);					  // PTX L1763
	r_PtxRegister492 = ShiftLeft(uint32_t(r_PtxRegister491), uint32_t(10));						  // PTX L1764
	r_PtxRegister493 = uint32_t(r_PtxRegister492) + uint32_t(r_PtxRegister7);					  // PTX L1765
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister493)) * int64_t(int32_t(4)));	  // PTX L1766
	g_RecordByteAddressAtPtx1767 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register89);  // PTX L1767
	r_LaneIndexAtPtx1769 = uint32_t((threadIdx.x & 31u));										  // PTX L1769
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1769)) * int64_t(int32_t(16))); // PTX L1771
	g_RecordByteAddressAtPtx1772 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register91); // PTX L1772
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1772));
		r_MmaBE4x4WordAtPtx79R1164 = r_Value.x;
		r_MmaBE4x4WordAtPtx79R1163 = r_Value.y;
		r_MmaBE4x4WordAtPtx79R1162 = r_Value.z;
		r_MmaBE4x4WordAtPtx79R1161 = r_Value.w;
	} // PTX L1774
	r_LaneIndexAtPtx1777 = uint32_t((threadIdx.x & 31u));										  // PTX L1777
	r_PtxU64Register92 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1777)) * int64_t(int32_t(16))); // PTX L1779
	g_RecordByteAddressAtPtx1780 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register92);			   // PTX L1780
	g_RecordByteAddressAtPtx1781 = uint64_t(g_RecordByteAddressAtPtx1780) + uint64_t(512); // PTX L1781
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1781));
		r_MmaBE4x4WordAtPtx88R1160 = r_Value.x;
		r_MmaBE4x4WordAtPtx88R1159 = r_Value.y;
		r_MmaBE4x4WordAtPtx88R1158 = r_Value.z;
		r_MmaBE4x4WordAtPtx88R1157 = r_Value.w;
	} // PTX L1783
	r_LaneIndexAtPtx1786 = uint32_t((threadIdx.x & 31u));										  // PTX L1786
	r_PtxU64Register94 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1786)) * int64_t(int32_t(16))); // PTX L1788
	g_RecordByteAddressAtPtx1789 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register94);				// PTX L1789
	g_RecordByteAddressAtPtx1790 = uint64_t(g_RecordByteAddressAtPtx1789) + uint64_t(1024); // PTX L1790
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1790));
		r_MmaBE4x4WordAtPtx97R1156 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R1155 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R1154 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R1153 = r_Value.w;
	} // PTX L1792
	r_LaneIndexAtPtx1795 = uint32_t((threadIdx.x & 31u));										  // PTX L1795
	r_PtxU64Register96 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1795)) * int64_t(int32_t(16))); // PTX L1797
	g_RecordByteAddressAtPtx1798 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register96);				// PTX L1798
	g_RecordByteAddressAtPtx1799 = uint64_t(g_RecordByteAddressAtPtx1798) + uint64_t(1536); // PTX L1799
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1799));
		r_MmaBE4x4WordAtPtx106R1152 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R1151 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R1150 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R1149 = r_Value.w;
	} // PTX L1801
	r_LaneIndexAtPtx1804 = uint32_t((threadIdx.x & 31u));										  // PTX L1804
	r_PtxU64Register98 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1804)) * int64_t(int32_t(16))); // PTX L1806
	g_RecordByteAddressAtPtx1807 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register98);				  // PTX L1807
	g_RecordByteAddressAtPtx1808 = uint64_t(g_RecordByteAddressAtPtx1807) + uint64_t(131072); // PTX L1808
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1808));
		r_MmaBE4x4WordAtPtx115R1148 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R1147 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R1146 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R1145 = r_Value.w;
	} // PTX L1810
	r_LaneIndexAtPtx1813 = uint32_t((threadIdx.x & 31u)); // PTX L1813
	r_PtxU64Register100 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1813)) * int64_t(int32_t(16))); // PTX L1815
	g_RecordByteAddressAtPtx1816 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register100);				  // PTX L1816
	g_RecordByteAddressAtPtx1817 = uint64_t(g_RecordByteAddressAtPtx1816) + uint64_t(131584); // PTX L1817
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1817));
		r_MmaBE4x4WordAtPtx124R1144 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R1143 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R1142 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R1141 = r_Value.w;
	} // PTX L1819
	r_LaneIndexAtPtx1822 = uint32_t((threadIdx.x & 31u)); // PTX L1822
	r_PtxU64Register102 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1822)) * int64_t(int32_t(16))); // PTX L1824
	g_RecordByteAddressAtPtx1825 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register102);				  // PTX L1825
	g_RecordByteAddressAtPtx1826 = uint64_t(g_RecordByteAddressAtPtx1825) + uint64_t(132096); // PTX L1826
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1826));
		r_MmaBE4x4WordAtPtx133R1140 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R1139 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R1165 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R1166 = r_Value.w;
	} // PTX L1828
	r_LaneIndexAtPtx1831 = uint32_t((threadIdx.x & 31u)); // PTX L1831
	r_PtxU64Register104 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1831)) * int64_t(int32_t(16))); // PTX L1833
	g_RecordByteAddressAtPtx1834 =
		uint64_t(g_RecordByteAddressAtPtx1767) + uint64_t(r_PtxU64Register104);				  // PTX L1834
	g_RecordByteAddressAtPtx1835 = uint64_t(g_RecordByteAddressAtPtx1834) + uint64_t(132608); // PTX L1835
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx1835));
		r_MmaBE4x4WordAtPtx142R1167 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R1168 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R1169 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R1170 = r_Value.w;
	} // PTX L1837
	r_PtxRegister494 = ShiftRight(uint32_t(r_PtxRegister490), uint32_t(6)); // PTX L1839
	r_PtxU16Register37 = uint16_t(r_PtxRegister494);						// PTX L1840
	r_PtxU16Register38 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register37)) * uint32_t(uint16_t(171))); // PTX L1841
	r_PtxU16Register39 = ShiftRight(uint16_t(r_PtxU16Register38), uint32_t(9));		// PTX L1842
	r_PtxU16Register40 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register39)) * uint32_t(uint16_t(3)));			  // PTX L1843
	r_PtxU16Register41 = uint16_t(r_PtxU16Register37) - uint16_t(r_PtxU16Register40);		  // PTX L1844
	r_PtxU16Register42 = r_PtxU16Register41 & 255;											  // PTX L1845
	r_PtxRegister495 = uint32_t(uint16_t(r_PtxU16Register42)) * uint32_t(uint16_t(8));		  // PTX L1846
	r_PtxRegister496 = uint32_t(24576u /* native mbarriers */);								  // PTX L1847
	r_PtxRegister498 = uint32_t(r_PtxRegister496) + uint32_t(r_PtxRegister495);				  // PTX L1848
	r_PtxRegister489 = uint32_t(1);															  // PTX L1849
	r_PtxU64Register106 = BarrierArrive(s_SharedStorage, r_PtxRegister498, r_PtxRegister489); // PTX L1851
L__BB41_121:																				  // PTX L1853
	r_PtxRegister497 = BarrierReady(s_SharedStorage, r_PtxRegister498, r_PtxU64Register106);  // PTX L1855
	r_bPtxPredicate84 = uint32_t(r_PtxRegister497) == uint32_t(0);							  // PTX L1861
	if (r_bPtxPredicate84)
	{
		goto L__BB41_121;
	} // PTX L1862
L__BB41_122:														 // PTX L1863
	r_bPtxPredicate85 = uint32_t(r_PtxRegister1138) > uint32_t(831); // PTX L1864
	if (r_bPtxPredicate85)
	{
		goto L__BB41_161;
	} // PTX L1865
	r_bPtxPredicate86 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);			   // PTX L1866
	r_bPtxPredicate87 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);			   // PTX L1867
	r_PtxRegister499 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1138);		   // PTX L1868
	r_PtxRegister500 = ShiftLeft(uint32_t(r_PtxRegister499), uint32_t(2));			   // PTX L1869
	r_PtxRegister40 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister500);		   // PTX L1870
	r_PtxRegister41 = r_bPtxPredicate87 ? r_PtxRegister40 : 0;						   // PTX L1871
	r_PtxRegister501 = uint32_t(0u /* native shared input */);						   // PTX L1872
	r_PtxU64Register107 = uint64_t(r_PtxRegister501);								   // PTX L1873
	r_PtxU64Register108 = SharedGeneric(s_SharedStorage, r_PtxU64Register107);		   // PTX L1874
	r_PtxU64Register109 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register5); // PTX L1875
	r_PtxU64Register6 = uint64_t(r_PtxU64Register109) + uint64_t(r_PtxU64Register35);  // PTX L1876
	r_PtxU16Register122 = uint16_t(0);												   // PTX L1877
	r_PtxU64Register170 = uint64_t(0);												   // PTX L1878
	r_PtxRegister1171 = uint32_t(128);												   // PTX L1879
	r_PtxRegister1172 = uint32_t(r_PtxRegister1171);								   // PTX L1880
	r_PtxU64Register171 = uint64_t(r_PtxU64Register170);							   // PTX L1881
	if (r_bPtxPredicate86)
	{
		goto L__BB41_125;
	} // PTX L1882
	r_PtxU64Register110 = uint64_t(int64_t(int32_t(r_PtxRegister41)) * int64_t(int32_t(4))); // PTX L1883
	r_PtxU64Register170 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register110);		 // PTX L1884
	r_PtxRegister1171 = uint32_t(r_PtxRegister41) + uint32_t(128);							 // PTX L1885
	r_PtxU16Register122 = uint16_t(1);														 // PTX L1886
	r_PtxRegister1172 = uint32_t(r_PtxRegister37);											 // PTX L1887
	r_PtxU64Register171 = uint64_t(r_PtxU64Register6);										 // PTX L1888
L__BB41_125:																				 // PTX L1889
	r_bPtxPredicate88 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					 // PTX L1890
	if (r_bPtxPredicate88)
	{
		goto L__BB41_127;
	} // PTX L1891
	r_PtxRegister502 = uint32_t(r_PtxRegister40) + uint32_t(128);				   // PTX L1892
	r_bPtxPredicate89 = uint32_t(r_PtxRegister37) == uint32_t(r_PtxRegister1172);  // PTX L1893
	r_bPtxPredicate90 = uint32_t(r_PtxRegister502) == uint32_t(r_PtxRegister1171); // PTX L1894
	r_PtxU16Register43 = r_bPtxPredicate90 ? r_PtxU16Register122 : 0;			   // PTX L1895
	r_PtxU16Register122 = r_bPtxPredicate89 ? r_PtxU16Register43 : 0;			   // PTX L1896
L__BB41_127:																	   // PTX L1897
	r_bPtxPredicate91 = uint16_t(r_PtxU16Register122) == uint16_t(0);			   // PTX L1898
	r_PtxRegister503 = ShiftLeft(uint32_t(r_PtxRegister38), uint32_t(3));		   // PTX L1899
	r_PtxRegister504 = uint32_t(24576u /* native mbarriers */);					   // PTX L1900
	r_PtxRegister42 = uint32_t(r_PtxRegister504) + uint32_t(r_PtxRegister503);	   // PTX L1901
	if (r_bPtxPredicate91)
	{
		goto L__BB41_130;
	} // PTX L1902
	r_PtxRegister506 = uint32_t(-1);							   // PTX L1903
	r_PtxRegister505 = Elected(r_PtxRegister506);				   // PTX L1905
	r_bPtxPredicate92 = uint32_t(r_PtxRegister505) == uint32_t(0); // PTX L1911
	if (r_bPtxPredicate92)
	{
		goto L__BB41_142;
	} // PTX L1912
	r_PtxU64Register112 = SharedOffset(s_SharedStorage, r_PtxU64Register171); // PTX L1913
	r_PtxRegister507 = uint32_t(r_PtxU64Register112);						  // PTX L1914
	r_PtxU64Register111 = r_PtxU64Register170;								  // PTX L1915
	r_PtxRegister508 = uint32_t(1024);										  // PTX L1916
	CopyBulk(s_SharedStorage, r_PtxRegister507, r_PtxU64Register111, r_PtxRegister508,
			 r_PtxRegister42);												// PTX L1918
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister508);		// PTX L1921
	goto L__BB41_142;														// PTX L1923
L__BB41_130:																// PTX L1924
	r_bPtxPredicate93 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L1925
	r_PtxU64Register172 = uint64_t(0);										// PTX L1926
	if (r_bPtxPredicate93)
	{
		goto L__BB41_132;
	} // PTX L1927
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister41)) * int64_t(int32_t(4))); // PTX L1928
	r_PtxU64Register172 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register113);		 // PTX L1929
L__BB41_132:																				 // PTX L1930
	r_bPtxPredicate94 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					 // PTX L1931
	r_PtxRegister509 = ShiftLeft(uint32_t(r_PtxRegister8), uint32_t(2));					 // PTX L1932
	r_PtxRegister43 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister509);				 // PTX L1933
	if (r_bPtxPredicate94)
	{
		goto L__BB41_135;
	} // PTX L1934
	r_PtxRegister517 = uint32_t(-1);							   // PTX L1935
	r_PtxRegister516 = Elected(r_PtxRegister517);				   // PTX L1937
	r_bPtxPredicate95 = uint32_t(r_PtxRegister516) == uint32_t(0); // PTX L1943
	if (r_bPtxPredicate95)
	{
		goto L__BB41_136;
	} // PTX L1944
	r_PtxU64Register114 = r_PtxU64Register172; // PTX L1945
	r_PtxRegister518 = uint32_t(512);		   // PTX L1946
	CopyBulk(s_SharedStorage, r_PtxRegister43, r_PtxU64Register114, r_PtxRegister518,
			 r_PtxRegister42);																   // PTX L1948
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister518);						   // PTX L1951
	goto L__BB41_136;																		   // PTX L1953
L__BB41_135:																				   // PTX L1954
	r_PtxRegister510 = uint32_t(0);															   // PTX L1955
	r_PtxU16Register44 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister510))); // PTX L1957
	r_PackedHalf2AtPtx1960R511 = JoinHalfwords(r_PtxU16Register44, r_PtxU16Register44);		   // PTX L1960
	r_ConvertedE4PairAtPtx1962Rs45 = PublishE4(r_PackedHalf2AtPtx1960R511);					   // PTX L1962
	r_PackedE4WordAtPtx1964R514 =
		JoinHalfwords(r_ConvertedE4PairAtPtx1962Rs45, r_ConvertedE4PairAtPtx1962Rs45); // PTX L1964
	r_LaneIndexAtPtx1966 = uint32_t((threadIdx.x & 31u));							   // PTX L1966
	r_PtxRegister515 = ShiftLeft(uint32_t(r_LaneIndexAtPtx1966), uint32_t(4));		   // PTX L1968
	r_PtxRegister513 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister515);		   // PTX L1969
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister513)) =
		make_uint4(r_PackedE4WordAtPtx1964R514, r_PackedE4WordAtPtx1964R514, r_PackedE4WordAtPtx1964R514,
				   r_PackedE4WordAtPtx1964R514);							// PTX L1971
L__BB41_136:																// PTX L1973
	r_bPtxPredicate96 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4); // PTX L1974
	r_bPtxPredicate97 = int32_t(r_PtxRegister9) < int32_t(r_PtxRegister4);	// PTX L1975
	r_PtxRegister519 = uint32_t(r_PtxRegister40) + uint32_t(128);			// PTX L1976
	r_PtxRegister44 = r_bPtxPredicate97 ? r_PtxRegister519 : 0;				// PTX L1977
	r_PtxU64Register173 = uint64_t(0);										// PTX L1978
	if (r_bPtxPredicate96)
	{
		goto L__BB41_138;
	} // PTX L1979
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister44)) * int64_t(int32_t(4))); // PTX L1980
	r_PtxU64Register173 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register115);		 // PTX L1981
L__BB41_138:																				 // PTX L1982
	r_bPtxPredicate98 = int32_t(r_PtxRegister9) >= int32_t(r_PtxRegister4);					 // PTX L1983
	if (r_bPtxPredicate98)
	{
		goto L__BB41_141;
	} // PTX L1984
	r_PtxRegister528 = uint32_t(-1);							   // PTX L1985
	r_PtxRegister527 = Elected(r_PtxRegister528);				   // PTX L1987
	r_bPtxPredicate99 = uint32_t(r_PtxRegister527) == uint32_t(0); // PTX L1993
	if (r_bPtxPredicate99)
	{
		goto L__BB41_142;
	} // PTX L1994
	r_PtxRegister529 = uint32_t(r_PtxRegister43) + uint32_t(512); // PTX L1995
	r_PtxU64Register116 = r_PtxU64Register173;					  // PTX L1996
	r_PtxRegister530 = uint32_t(512);							  // PTX L1997
	CopyBulk(s_SharedStorage, r_PtxRegister529, r_PtxU64Register116, r_PtxRegister530,
			 r_PtxRegister42);																   // PTX L1999
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister530);						   // PTX L2002
	goto L__BB41_142;																		   // PTX L2004
L__BB41_141:																				   // PTX L2005
	r_PtxRegister520 = uint32_t(0);															   // PTX L2006
	r_PtxU16Register46 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister520))); // PTX L2008
	r_PackedHalf2AtPtx2011R521 = JoinHalfwords(r_PtxU16Register46, r_PtxU16Register46);		   // PTX L2011
	r_ConvertedE4PairAtPtx2013Rs47 = PublishE4(r_PackedHalf2AtPtx2011R521);					   // PTX L2013
	r_PackedE4WordAtPtx2015R524 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2013Rs47, r_ConvertedE4PairAtPtx2013Rs47); // PTX L2015
	r_LaneIndexAtPtx2017 = uint32_t((threadIdx.x & 31u));							   // PTX L2017
	r_PtxRegister525 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2017), uint32_t(4));		   // PTX L2019
	r_PtxRegister526 = uint32_t(r_PtxRegister43) + uint32_t(r_PtxRegister525);		   // PTX L2020
	r_PtxRegister523 = uint32_t(r_PtxRegister526) + uint32_t(512);					   // PTX L2021
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister523)) =
		make_uint4(r_PackedE4WordAtPtx2015R524, r_PackedE4WordAtPtx2015R524, r_PackedE4WordAtPtx2015R524,
				   r_PackedE4WordAtPtx2015R524);							  // PTX L2023
L__BB41_142:																  // PTX L2025
	r_bPtxPredicate100 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L2026
	r_bPtxPredicate101 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);  // PTX L2027
	r_PtxRegister45 = uint32_t(r_PtxRegister40) + uint32_t(16384);			  // PTX L2028
	r_PtxRegister46 = r_bPtxPredicate101 ? r_PtxRegister45 : 0;				  // PTX L2029
	r_PtxU16Register123 = uint16_t(0);										  // PTX L2030
	r_PtxU64Register174 = uint64_t(0);										  // PTX L2031
	r_PtxRegister1173 = uint32_t(128);										  // PTX L2032
	r_PtxU64Register175 = uint64_t(r_PtxU64Register174);					  // PTX L2033
	if (r_bPtxPredicate100)
	{
		goto L__BB41_144;
	} // PTX L2034
	r_PtxU64Register175 = uint64_t(r_PtxU64Register6) + uint64_t(4096);						 // PTX L2035
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister46)) * int64_t(int32_t(4))); // PTX L2036
	r_PtxU64Register174 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register117);		 // PTX L2037
	r_PtxRegister1173 = uint32_t(r_PtxRegister46) + uint32_t(128);							 // PTX L2038
	r_PtxU16Register123 = uint16_t(1);														 // PTX L2039
L__BB41_144:																				 // PTX L2040
	r_bPtxPredicate102 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				 // PTX L2041
	if (r_bPtxPredicate102)
	{
		goto L__BB41_146;
	} // PTX L2042
	r_PtxRegister531 = uint32_t(r_PtxRegister45) + uint32_t(128);					// PTX L2043
	r_bPtxPredicate103 = uint32_t(r_PtxRegister531) == uint32_t(r_PtxRegister1173); // PTX L2044
	r_PtxU16Register123 = r_bPtxPredicate103 ? r_PtxU16Register123 : 0;				// PTX L2045
L__BB41_146:																		// PTX L2046
	r_bPtxPredicate104 = uint16_t(r_PtxU16Register123) == uint16_t(0);				// PTX L2047
	if (r_bPtxPredicate104)
	{
		goto L__BB41_149;
	} // PTX L2048
	r_PtxRegister533 = uint32_t(-1);								// PTX L2049
	r_PtxRegister532 = Elected(r_PtxRegister533);					// PTX L2051
	r_bPtxPredicate105 = uint32_t(r_PtxRegister532) == uint32_t(0); // PTX L2057
	if (r_bPtxPredicate105)
	{
		goto L__BB41_161;
	} // PTX L2058
	r_PtxU64Register119 = SharedOffset(s_SharedStorage, r_PtxU64Register175); // PTX L2059
	r_PtxRegister534 = uint32_t(r_PtxU64Register119);						  // PTX L2060
	r_PtxU64Register118 = r_PtxU64Register174;								  // PTX L2061
	r_PtxRegister535 = uint32_t(1024);										  // PTX L2062
	CopyBulk(s_SharedStorage, r_PtxRegister534, r_PtxU64Register118, r_PtxRegister535,
			 r_PtxRegister42);												  // PTX L2064
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister535);		  // PTX L2067
	goto L__BB41_161;														  // PTX L2069
L__BB41_149:																  // PTX L2070
	r_bPtxPredicate106 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L2071
	r_PtxU64Register176 = uint64_t(0);										  // PTX L2072
	if (r_bPtxPredicate106)
	{
		goto L__BB41_151;
	} // PTX L2073
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister46)) * int64_t(int32_t(4))); // PTX L2074
	r_PtxU64Register176 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register120);		 // PTX L2075
L__BB41_151:																				 // PTX L2076
	r_bPtxPredicate107 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				 // PTX L2077
	r_PtxRegister536 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(2));					 // PTX L2078
	r_PtxRegister47 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister536);				 // PTX L2079
	if (r_bPtxPredicate107)
	{
		goto L__BB41_154;
	} // PTX L2080
	r_PtxRegister544 = uint32_t(-1);								// PTX L2081
	r_PtxRegister543 = Elected(r_PtxRegister544);					// PTX L2083
	r_bPtxPredicate108 = uint32_t(r_PtxRegister543) == uint32_t(0); // PTX L2089
	if (r_bPtxPredicate108)
	{
		goto L__BB41_155;
	} // PTX L2090
	r_PtxU64Register121 = r_PtxU64Register176; // PTX L2091
	r_PtxRegister545 = uint32_t(512);		   // PTX L2092
	CopyBulk(s_SharedStorage, r_PtxRegister47, r_PtxU64Register121, r_PtxRegister545,
			 r_PtxRegister42);																   // PTX L2094
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister545);						   // PTX L2097
	goto L__BB41_155;																		   // PTX L2099
L__BB41_154:																				   // PTX L2100
	r_PtxRegister537 = uint32_t(0);															   // PTX L2101
	r_PtxU16Register48 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister537))); // PTX L2103
	r_PackedHalf2AtPtx2106R538 = JoinHalfwords(r_PtxU16Register48, r_PtxU16Register48);		   // PTX L2106
	r_ConvertedE4PairAtPtx2108Rs49 = PublishE4(r_PackedHalf2AtPtx2106R538);					   // PTX L2108
	r_PackedE4WordAtPtx2110R541 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2108Rs49, r_ConvertedE4PairAtPtx2108Rs49); // PTX L2110
	r_LaneIndexAtPtx2112 = uint32_t((threadIdx.x & 31u));							   // PTX L2112
	r_PtxRegister542 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2112), uint32_t(4));		   // PTX L2114
	r_PtxRegister540 = uint32_t(r_PtxRegister47) + uint32_t(r_PtxRegister542);		   // PTX L2115
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister540)) =
		make_uint4(r_PackedE4WordAtPtx2110R541, r_PackedE4WordAtPtx2110R541, r_PackedE4WordAtPtx2110R541,
				   r_PackedE4WordAtPtx2110R541);							  // PTX L2117
L__BB41_155:																  // PTX L2119
	r_bPtxPredicate109 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4); // PTX L2120
	r_bPtxPredicate110 = int32_t(r_PtxRegister16) < int32_t(r_PtxRegister4);  // PTX L2121
	r_PtxRegister546 = uint32_t(r_PtxRegister45) + uint32_t(128);			  // PTX L2122
	r_PtxRegister48 = r_bPtxPredicate110 ? r_PtxRegister546 : 0;			  // PTX L2123
	r_PtxU64Register177 = uint64_t(0);										  // PTX L2124
	if (r_bPtxPredicate109)
	{
		goto L__BB41_157;
	} // PTX L2125
	r_PtxU64Register122 = uint64_t(int64_t(int32_t(r_PtxRegister48)) * int64_t(int32_t(4))); // PTX L2126
	r_PtxU64Register177 = uint64_t(g_StateBaseAddress) + uint64_t(r_PtxU64Register122);		 // PTX L2127
L__BB41_157:																				 // PTX L2128
	r_bPtxPredicate111 = int32_t(r_PtxRegister16) >= int32_t(r_PtxRegister4);				 // PTX L2129
	if (r_bPtxPredicate111)
	{
		goto L__BB41_160;
	} // PTX L2130
	r_PtxRegister555 = uint32_t(-1);								// PTX L2131
	r_PtxRegister554 = Elected(r_PtxRegister555);					// PTX L2133
	r_bPtxPredicate112 = uint32_t(r_PtxRegister554) == uint32_t(0); // PTX L2139
	if (r_bPtxPredicate112)
	{
		goto L__BB41_161;
	} // PTX L2140
	r_PtxRegister556 = uint32_t(r_PtxRegister47) + uint32_t(512); // PTX L2141
	r_PtxU64Register123 = r_PtxU64Register177;					  // PTX L2142
	r_PtxRegister557 = uint32_t(512);							  // PTX L2143
	CopyBulk(s_SharedStorage, r_PtxRegister556, r_PtxU64Register123, r_PtxRegister557,
			 r_PtxRegister42);																   // PTX L2145
	BarrierExpect(s_SharedStorage, r_PtxRegister42, r_PtxRegister557);						   // PTX L2148
	goto L__BB41_161;																		   // PTX L2150
L__BB41_160:																				   // PTX L2151
	r_PtxRegister547 = uint32_t(0);															   // PTX L2152
	r_PtxU16Register50 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister547))); // PTX L2154
	r_PackedHalf2AtPtx2157R548 = JoinHalfwords(r_PtxU16Register50, r_PtxU16Register50);		   // PTX L2157
	r_ConvertedE4PairAtPtx2159Rs51 = PublishE4(r_PackedHalf2AtPtx2157R548);					   // PTX L2159
	r_PackedE4WordAtPtx2161R551 =
		JoinHalfwords(r_ConvertedE4PairAtPtx2159Rs51, r_ConvertedE4PairAtPtx2159Rs51); // PTX L2161
	r_LaneIndexAtPtx2163 = uint32_t((threadIdx.x & 31u));							   // PTX L2163
	r_PtxRegister552 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2163), uint32_t(4));		   // PTX L2165
	r_PtxRegister553 = uint32_t(r_PtxRegister47) + uint32_t(r_PtxRegister552);		   // PTX L2166
	r_PtxRegister550 = uint32_t(r_PtxRegister553) + uint32_t(512);					   // PTX L2167
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister550)) =
		make_uint4(r_PackedE4WordAtPtx2161R551, r_PackedE4WordAtPtx2161R551, r_PackedE4WordAtPtx2161R551,
				   r_PackedE4WordAtPtx2161R551);					  // PTX L2169
L__BB41_161:														  // PTX L2171
	r_bPtxPredicate113 = uint32_t(r_PtxRegister1138) < uint32_t(960); // PTX L2172
	r_PtxRegister1138 = uint32_t(r_PtxRegister1138) + uint32_t(64);	  // PTX L2173
	if (r_bPtxPredicate113)
	{
		goto L__BB41_119;
	} // PTX L2174
	r_LaneIndexAtPtx2176 = uint32_t((threadIdx.x & 31u));				   // PTX L2176
	r_Float32BitsAtPtx2178R559 = uint32_t(-1065353216);					   // PTX L2178
	r_PackedHalf2AtPtx2180R566 = FloatToHalf2(r_Float32BitsAtPtx2178R559); // PTX L2180
	r_Float32BitsAtPtx2185R560 = uint32_t(1082130432);					   // PTX L2185
	r_PackedHalf2AtPtx2187R564 = FloatToHalf2(r_Float32BitsAtPtx2185R560); // PTX L2187
	r_Float32BitsAtPtx2192R561 = uint32_t(1063583744);					   // PTX L2192
	r_PackedHalf2AtPtx2194R572 = FloatToHalf2(r_Float32BitsAtPtx2192R561); // PTX L2194
	r_Float32BitsAtPtx2199R562 = uint32_t(1055195136);					   // PTX L2199
	r_PackedHalf2AtPtx2201R570 = FloatToHalf2(r_Float32BitsAtPtx2199R562); // PTX L2201
	r_Float32BitsAtPtx2206R563 = uint32_t(-1117454336);					   // PTX L2206
	r_PackedHalf2AtPtx2208R568 = FloatToHalf2(r_Float32BitsAtPtx2206R563); // PTX L2208
	r_PackedHalf2AtPtx2214R565 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1216R1129, r_PackedHalf2AtPtx2187R564);			  // PTX L2214
	r_PackedHalf2AtPtx2218R567 = HalfMax(r_PackedHalf2AtPtx2214R565, r_PackedHalf2AtPtx2180R566); // PTX L2218
	r_PackedHalf2AtPtx2222R569 = HalfAbs(r_PackedHalf2AtPtx2218R567);							  // PTX L2222
	r_PackedHalf2AtPtx2226R571 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2222R569,
										 r_PackedHalf2AtPtx2201R570); // PTX L2226
	r_PackedHalf2AtPtx2230R573 = HalfFma(r_PackedHalf2AtPtx2218R567, r_PackedHalf2AtPtx2226R571,
										 r_PackedHalf2AtPtx2194R572); // PTX L2230
	r_PackedHalf2AtPtx2234R952 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1216R1129, r_PackedHalf2AtPtx2230R573); // PTX L2234
	r_LaneIndexAtPtx2238 = uint32_t((threadIdx.x & 31u));							  // PTX L2238
	r_PackedHalf2AtPtx2241R575 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1215R1128, r_PackedHalf2AtPtx2187R564);			  // PTX L2241
	r_PackedHalf2AtPtx2245R576 = HalfMax(r_PackedHalf2AtPtx2241R575, r_PackedHalf2AtPtx2180R566); // PTX L2245
	r_PackedHalf2AtPtx2249R577 = HalfAbs(r_PackedHalf2AtPtx2245R576);							  // PTX L2249
	r_PackedHalf2AtPtx2253R578 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2249R577,
										 r_PackedHalf2AtPtx2201R570); // PTX L2253
	r_PackedHalf2AtPtx2257R579 = HalfFma(r_PackedHalf2AtPtx2245R576, r_PackedHalf2AtPtx2253R578,
										 r_PackedHalf2AtPtx2194R572); // PTX L2257
	r_PackedHalf2AtPtx2261R954 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1215R1128, r_PackedHalf2AtPtx2257R579); // PTX L2261
	r_LaneIndexAtPtx2265 = uint32_t((threadIdx.x & 31u));							  // PTX L2265
	r_PackedHalf2AtPtx2268R581 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1214R1127, r_PackedHalf2AtPtx2187R564);			  // PTX L2268
	r_PackedHalf2AtPtx2272R582 = HalfMax(r_PackedHalf2AtPtx2268R581, r_PackedHalf2AtPtx2180R566); // PTX L2272
	r_PackedHalf2AtPtx2276R583 = HalfAbs(r_PackedHalf2AtPtx2272R582);							  // PTX L2276
	r_PackedHalf2AtPtx2280R584 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2276R583,
										 r_PackedHalf2AtPtx2201R570); // PTX L2280
	r_PackedHalf2AtPtx2284R585 = HalfFma(r_PackedHalf2AtPtx2272R582, r_PackedHalf2AtPtx2280R584,
										 r_PackedHalf2AtPtx2194R572); // PTX L2284
	r_PackedHalf2AtPtx2288R953 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1214R1127, r_PackedHalf2AtPtx2284R585); // PTX L2288
	r_LaneIndexAtPtx2292 = uint32_t((threadIdx.x & 31u));							  // PTX L2292
	r_PackedHalf2AtPtx2295R587 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1213R1126, r_PackedHalf2AtPtx2187R564);			  // PTX L2295
	r_PackedHalf2AtPtx2299R588 = HalfMax(r_PackedHalf2AtPtx2295R587, r_PackedHalf2AtPtx2180R566); // PTX L2299
	r_PackedHalf2AtPtx2303R589 = HalfAbs(r_PackedHalf2AtPtx2299R588);							  // PTX L2303
	r_PackedHalf2AtPtx2307R590 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2303R589,
										 r_PackedHalf2AtPtx2201R570); // PTX L2307
	r_PackedHalf2AtPtx2311R591 = HalfFma(r_PackedHalf2AtPtx2299R588, r_PackedHalf2AtPtx2307R590,
										 r_PackedHalf2AtPtx2194R572); // PTX L2311
	r_PackedHalf2AtPtx2315R955 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1213R1126, r_PackedHalf2AtPtx2311R591); // PTX L2315
	r_LaneIndexAtPtx2319 = uint32_t((threadIdx.x & 31u));							  // PTX L2319
	r_PackedHalf2AtPtx2322R593 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1212R1125, r_PackedHalf2AtPtx2187R564);			  // PTX L2322
	r_PackedHalf2AtPtx2326R594 = HalfMax(r_PackedHalf2AtPtx2322R593, r_PackedHalf2AtPtx2180R566); // PTX L2326
	r_PackedHalf2AtPtx2330R595 = HalfAbs(r_PackedHalf2AtPtx2326R594);							  // PTX L2330
	r_PackedHalf2AtPtx2334R596 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2330R595,
										 r_PackedHalf2AtPtx2201R570); // PTX L2334
	r_PackedHalf2AtPtx2338R597 = HalfFma(r_PackedHalf2AtPtx2326R594, r_PackedHalf2AtPtx2334R596,
										 r_PackedHalf2AtPtx2194R572); // PTX L2338
	r_PackedHalf2AtPtx2342R956 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1212R1125, r_PackedHalf2AtPtx2338R597); // PTX L2342
	r_LaneIndexAtPtx2346 = uint32_t((threadIdx.x & 31u));							  // PTX L2346
	r_PackedHalf2AtPtx2349R599 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1211R1124, r_PackedHalf2AtPtx2187R564);			  // PTX L2349
	r_PackedHalf2AtPtx2353R600 = HalfMax(r_PackedHalf2AtPtx2349R599, r_PackedHalf2AtPtx2180R566); // PTX L2353
	r_PackedHalf2AtPtx2357R601 = HalfAbs(r_PackedHalf2AtPtx2353R600);							  // PTX L2357
	r_PackedHalf2AtPtx2361R602 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2357R601,
										 r_PackedHalf2AtPtx2201R570); // PTX L2361
	r_PackedHalf2AtPtx2365R603 = HalfFma(r_PackedHalf2AtPtx2353R600, r_PackedHalf2AtPtx2361R602,
										 r_PackedHalf2AtPtx2194R572); // PTX L2365
	r_PackedHalf2AtPtx2369R958 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1211R1124, r_PackedHalf2AtPtx2365R603); // PTX L2369
	r_LaneIndexAtPtx2373 = uint32_t((threadIdx.x & 31u));							  // PTX L2373
	r_PackedHalf2AtPtx2376R605 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1210R1123, r_PackedHalf2AtPtx2187R564);			  // PTX L2376
	r_PackedHalf2AtPtx2380R606 = HalfMax(r_PackedHalf2AtPtx2376R605, r_PackedHalf2AtPtx2180R566); // PTX L2380
	r_PackedHalf2AtPtx2384R607 = HalfAbs(r_PackedHalf2AtPtx2380R606);							  // PTX L2384
	r_PackedHalf2AtPtx2388R608 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2384R607,
										 r_PackedHalf2AtPtx2201R570); // PTX L2388
	r_PackedHalf2AtPtx2392R609 = HalfFma(r_PackedHalf2AtPtx2380R606, r_PackedHalf2AtPtx2388R608,
										 r_PackedHalf2AtPtx2194R572); // PTX L2392
	r_PackedHalf2AtPtx2396R957 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1210R1123, r_PackedHalf2AtPtx2392R609); // PTX L2396
	r_LaneIndexAtPtx2400 = uint32_t((threadIdx.x & 31u));							  // PTX L2400
	r_PackedHalf2AtPtx2403R611 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1209R1122, r_PackedHalf2AtPtx2187R564);			  // PTX L2403
	r_PackedHalf2AtPtx2407R612 = HalfMax(r_PackedHalf2AtPtx2403R611, r_PackedHalf2AtPtx2180R566); // PTX L2407
	r_PackedHalf2AtPtx2411R613 = HalfAbs(r_PackedHalf2AtPtx2407R612);							  // PTX L2411
	r_PackedHalf2AtPtx2415R614 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2411R613,
										 r_PackedHalf2AtPtx2201R570); // PTX L2415
	r_PackedHalf2AtPtx2419R615 = HalfFma(r_PackedHalf2AtPtx2407R612, r_PackedHalf2AtPtx2415R614,
										 r_PackedHalf2AtPtx2194R572); // PTX L2419
	r_PackedHalf2AtPtx2423R959 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1209R1122, r_PackedHalf2AtPtx2419R615); // PTX L2423
	r_LaneIndexAtPtx2427 = uint32_t((threadIdx.x & 31u));							  // PTX L2427
	r_PackedHalf2AtPtx2430R617 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1208R1121, r_PackedHalf2AtPtx2187R564);			  // PTX L2430
	r_PackedHalf2AtPtx2434R618 = HalfMax(r_PackedHalf2AtPtx2430R617, r_PackedHalf2AtPtx2180R566); // PTX L2434
	r_PackedHalf2AtPtx2438R619 = HalfAbs(r_PackedHalf2AtPtx2434R618);							  // PTX L2438
	r_PackedHalf2AtPtx2442R620 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2438R619,
										 r_PackedHalf2AtPtx2201R570); // PTX L2442
	r_PackedHalf2AtPtx2446R621 = HalfFma(r_PackedHalf2AtPtx2434R618, r_PackedHalf2AtPtx2442R620,
										 r_PackedHalf2AtPtx2194R572); // PTX L2446
	r_PackedHalf2AtPtx2450R960 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1208R1121, r_PackedHalf2AtPtx2446R621); // PTX L2450
	r_LaneIndexAtPtx2454 = uint32_t((threadIdx.x & 31u));							  // PTX L2454
	r_PackedHalf2AtPtx2457R623 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1207R1120, r_PackedHalf2AtPtx2187R564);			  // PTX L2457
	r_PackedHalf2AtPtx2461R624 = HalfMax(r_PackedHalf2AtPtx2457R623, r_PackedHalf2AtPtx2180R566); // PTX L2461
	r_PackedHalf2AtPtx2465R625 = HalfAbs(r_PackedHalf2AtPtx2461R624);							  // PTX L2465
	r_PackedHalf2AtPtx2469R626 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2465R625,
										 r_PackedHalf2AtPtx2201R570); // PTX L2469
	r_PackedHalf2AtPtx2473R627 = HalfFma(r_PackedHalf2AtPtx2461R624, r_PackedHalf2AtPtx2469R626,
										 r_PackedHalf2AtPtx2194R572); // PTX L2473
	r_PackedHalf2AtPtx2477R962 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1207R1120, r_PackedHalf2AtPtx2473R627); // PTX L2477
	r_LaneIndexAtPtx2481 = uint32_t((threadIdx.x & 31u));							  // PTX L2481
	r_PackedHalf2AtPtx2484R629 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1206R1119, r_PackedHalf2AtPtx2187R564);			  // PTX L2484
	r_PackedHalf2AtPtx2488R630 = HalfMax(r_PackedHalf2AtPtx2484R629, r_PackedHalf2AtPtx2180R566); // PTX L2488
	r_PackedHalf2AtPtx2492R631 = HalfAbs(r_PackedHalf2AtPtx2488R630);							  // PTX L2492
	r_PackedHalf2AtPtx2496R632 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2492R631,
										 r_PackedHalf2AtPtx2201R570); // PTX L2496
	r_PackedHalf2AtPtx2500R633 = HalfFma(r_PackedHalf2AtPtx2488R630, r_PackedHalf2AtPtx2496R632,
										 r_PackedHalf2AtPtx2194R572); // PTX L2500
	r_PackedHalf2AtPtx2504R961 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1206R1119, r_PackedHalf2AtPtx2500R633); // PTX L2504
	r_LaneIndexAtPtx2508 = uint32_t((threadIdx.x & 31u));							  // PTX L2508
	r_PackedHalf2AtPtx2511R635 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1205R1118, r_PackedHalf2AtPtx2187R564);			  // PTX L2511
	r_PackedHalf2AtPtx2515R636 = HalfMax(r_PackedHalf2AtPtx2511R635, r_PackedHalf2AtPtx2180R566); // PTX L2515
	r_PackedHalf2AtPtx2519R637 = HalfAbs(r_PackedHalf2AtPtx2515R636);							  // PTX L2519
	r_PackedHalf2AtPtx2523R638 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2519R637,
										 r_PackedHalf2AtPtx2201R570); // PTX L2523
	r_PackedHalf2AtPtx2527R639 = HalfFma(r_PackedHalf2AtPtx2515R636, r_PackedHalf2AtPtx2523R638,
										 r_PackedHalf2AtPtx2194R572); // PTX L2527
	r_PackedHalf2AtPtx2531R963 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1205R1118, r_PackedHalf2AtPtx2527R639); // PTX L2531
	r_LaneIndexAtPtx2535 = uint32_t((threadIdx.x & 31u));							  // PTX L2535
	r_PackedHalf2AtPtx2538R641 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1204R1117, r_PackedHalf2AtPtx2187R564);			  // PTX L2538
	r_PackedHalf2AtPtx2542R642 = HalfMax(r_PackedHalf2AtPtx2538R641, r_PackedHalf2AtPtx2180R566); // PTX L2542
	r_PackedHalf2AtPtx2546R643 = HalfAbs(r_PackedHalf2AtPtx2542R642);							  // PTX L2546
	r_PackedHalf2AtPtx2550R644 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2546R643,
										 r_PackedHalf2AtPtx2201R570); // PTX L2550
	r_PackedHalf2AtPtx2554R645 = HalfFma(r_PackedHalf2AtPtx2542R642, r_PackedHalf2AtPtx2550R644,
										 r_PackedHalf2AtPtx2194R572); // PTX L2554
	r_PackedHalf2AtPtx2558R964 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1204R1117, r_PackedHalf2AtPtx2554R645); // PTX L2558
	r_LaneIndexAtPtx2562 = uint32_t((threadIdx.x & 31u));							  // PTX L2562
	r_PackedHalf2AtPtx2565R647 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1203R1116, r_PackedHalf2AtPtx2187R564);			  // PTX L2565
	r_PackedHalf2AtPtx2569R648 = HalfMax(r_PackedHalf2AtPtx2565R647, r_PackedHalf2AtPtx2180R566); // PTX L2569
	r_PackedHalf2AtPtx2573R649 = HalfAbs(r_PackedHalf2AtPtx2569R648);							  // PTX L2573
	r_PackedHalf2AtPtx2577R650 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2573R649,
										 r_PackedHalf2AtPtx2201R570); // PTX L2577
	r_PackedHalf2AtPtx2581R651 = HalfFma(r_PackedHalf2AtPtx2569R648, r_PackedHalf2AtPtx2577R650,
										 r_PackedHalf2AtPtx2194R572); // PTX L2581
	r_PackedHalf2AtPtx2585R966 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1203R1116, r_PackedHalf2AtPtx2581R651); // PTX L2585
	r_LaneIndexAtPtx2589 = uint32_t((threadIdx.x & 31u));							  // PTX L2589
	r_PackedHalf2AtPtx2592R653 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1202R1115, r_PackedHalf2AtPtx2187R564);			  // PTX L2592
	r_PackedHalf2AtPtx2596R654 = HalfMax(r_PackedHalf2AtPtx2592R653, r_PackedHalf2AtPtx2180R566); // PTX L2596
	r_PackedHalf2AtPtx2600R655 = HalfAbs(r_PackedHalf2AtPtx2596R654);							  // PTX L2600
	r_PackedHalf2AtPtx2604R656 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2600R655,
										 r_PackedHalf2AtPtx2201R570); // PTX L2604
	r_PackedHalf2AtPtx2608R657 = HalfFma(r_PackedHalf2AtPtx2596R654, r_PackedHalf2AtPtx2604R656,
										 r_PackedHalf2AtPtx2194R572); // PTX L2608
	r_PackedHalf2AtPtx2612R965 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1202R1115, r_PackedHalf2AtPtx2608R657); // PTX L2612
	r_LaneIndexAtPtx2616 = uint32_t((threadIdx.x & 31u));							  // PTX L2616
	r_PackedHalf2AtPtx2619R659 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1201R1114, r_PackedHalf2AtPtx2187R564);			  // PTX L2619
	r_PackedHalf2AtPtx2623R660 = HalfMax(r_PackedHalf2AtPtx2619R659, r_PackedHalf2AtPtx2180R566); // PTX L2623
	r_PackedHalf2AtPtx2627R661 = HalfAbs(r_PackedHalf2AtPtx2623R660);							  // PTX L2627
	r_PackedHalf2AtPtx2631R662 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2627R661,
										 r_PackedHalf2AtPtx2201R570); // PTX L2631
	r_PackedHalf2AtPtx2635R663 = HalfFma(r_PackedHalf2AtPtx2623R660, r_PackedHalf2AtPtx2631R662,
										 r_PackedHalf2AtPtx2194R572); // PTX L2635
	r_PackedHalf2AtPtx2639R967 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1201R1114, r_PackedHalf2AtPtx2635R663); // PTX L2639
	r_LaneIndexAtPtx2643 = uint32_t((threadIdx.x & 31u));							  // PTX L2643
	r_PackedHalf2AtPtx2646R665 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1200R1113, r_PackedHalf2AtPtx2187R564);			  // PTX L2646
	r_PackedHalf2AtPtx2650R666 = HalfMax(r_PackedHalf2AtPtx2646R665, r_PackedHalf2AtPtx2180R566); // PTX L2650
	r_PackedHalf2AtPtx2654R667 = HalfAbs(r_PackedHalf2AtPtx2650R666);							  // PTX L2654
	r_PackedHalf2AtPtx2658R668 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2654R667,
										 r_PackedHalf2AtPtx2201R570); // PTX L2658
	r_PackedHalf2AtPtx2662R669 = HalfFma(r_PackedHalf2AtPtx2650R666, r_PackedHalf2AtPtx2658R668,
										 r_PackedHalf2AtPtx2194R572); // PTX L2662
	r_PackedHalf2AtPtx2666R968 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1200R1113, r_PackedHalf2AtPtx2662R669); // PTX L2666
	r_LaneIndexAtPtx2670 = uint32_t((threadIdx.x & 31u));							  // PTX L2670
	r_PackedHalf2AtPtx2673R671 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1199R1112, r_PackedHalf2AtPtx2187R564);			  // PTX L2673
	r_PackedHalf2AtPtx2677R672 = HalfMax(r_PackedHalf2AtPtx2673R671, r_PackedHalf2AtPtx2180R566); // PTX L2677
	r_PackedHalf2AtPtx2681R673 = HalfAbs(r_PackedHalf2AtPtx2677R672);							  // PTX L2681
	r_PackedHalf2AtPtx2685R674 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2681R673,
										 r_PackedHalf2AtPtx2201R570); // PTX L2685
	r_PackedHalf2AtPtx2689R675 = HalfFma(r_PackedHalf2AtPtx2677R672, r_PackedHalf2AtPtx2685R674,
										 r_PackedHalf2AtPtx2194R572); // PTX L2689
	r_PackedHalf2AtPtx2693R970 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1199R1112, r_PackedHalf2AtPtx2689R675); // PTX L2693
	r_LaneIndexAtPtx2697 = uint32_t((threadIdx.x & 31u));							  // PTX L2697
	r_PackedHalf2AtPtx2700R677 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1198R1111, r_PackedHalf2AtPtx2187R564);			  // PTX L2700
	r_PackedHalf2AtPtx2704R678 = HalfMax(r_PackedHalf2AtPtx2700R677, r_PackedHalf2AtPtx2180R566); // PTX L2704
	r_PackedHalf2AtPtx2708R679 = HalfAbs(r_PackedHalf2AtPtx2704R678);							  // PTX L2708
	r_PackedHalf2AtPtx2712R680 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2708R679,
										 r_PackedHalf2AtPtx2201R570); // PTX L2712
	r_PackedHalf2AtPtx2716R681 = HalfFma(r_PackedHalf2AtPtx2704R678, r_PackedHalf2AtPtx2712R680,
										 r_PackedHalf2AtPtx2194R572); // PTX L2716
	r_PackedHalf2AtPtx2720R969 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1198R1111, r_PackedHalf2AtPtx2716R681); // PTX L2720
	r_LaneIndexAtPtx2724 = uint32_t((threadIdx.x & 31u));							  // PTX L2724
	r_PackedHalf2AtPtx2727R683 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1197R1110, r_PackedHalf2AtPtx2187R564);			  // PTX L2727
	r_PackedHalf2AtPtx2731R684 = HalfMax(r_PackedHalf2AtPtx2727R683, r_PackedHalf2AtPtx2180R566); // PTX L2731
	r_PackedHalf2AtPtx2735R685 = HalfAbs(r_PackedHalf2AtPtx2731R684);							  // PTX L2735
	r_PackedHalf2AtPtx2739R686 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2735R685,
										 r_PackedHalf2AtPtx2201R570); // PTX L2739
	r_PackedHalf2AtPtx2743R687 = HalfFma(r_PackedHalf2AtPtx2731R684, r_PackedHalf2AtPtx2739R686,
										 r_PackedHalf2AtPtx2194R572); // PTX L2743
	r_PackedHalf2AtPtx2747R971 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1197R1110, r_PackedHalf2AtPtx2743R687); // PTX L2747
	r_LaneIndexAtPtx2751 = uint32_t((threadIdx.x & 31u));							  // PTX L2751
	r_PackedHalf2AtPtx2754R689 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1196R1109, r_PackedHalf2AtPtx2187R564);			  // PTX L2754
	r_PackedHalf2AtPtx2758R690 = HalfMax(r_PackedHalf2AtPtx2754R689, r_PackedHalf2AtPtx2180R566); // PTX L2758
	r_PackedHalf2AtPtx2762R691 = HalfAbs(r_PackedHalf2AtPtx2758R690);							  // PTX L2762
	r_PackedHalf2AtPtx2766R692 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2762R691,
										 r_PackedHalf2AtPtx2201R570); // PTX L2766
	r_PackedHalf2AtPtx2770R693 = HalfFma(r_PackedHalf2AtPtx2758R690, r_PackedHalf2AtPtx2766R692,
										 r_PackedHalf2AtPtx2194R572); // PTX L2770
	r_PackedHalf2AtPtx2774R972 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1196R1109, r_PackedHalf2AtPtx2770R693); // PTX L2774
	r_LaneIndexAtPtx2778 = uint32_t((threadIdx.x & 31u));							  // PTX L2778
	r_PackedHalf2AtPtx2781R695 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1195R1108, r_PackedHalf2AtPtx2187R564);			  // PTX L2781
	r_PackedHalf2AtPtx2785R696 = HalfMax(r_PackedHalf2AtPtx2781R695, r_PackedHalf2AtPtx2180R566); // PTX L2785
	r_PackedHalf2AtPtx2789R697 = HalfAbs(r_PackedHalf2AtPtx2785R696);							  // PTX L2789
	r_PackedHalf2AtPtx2793R698 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2789R697,
										 r_PackedHalf2AtPtx2201R570); // PTX L2793
	r_PackedHalf2AtPtx2797R699 = HalfFma(r_PackedHalf2AtPtx2785R696, r_PackedHalf2AtPtx2793R698,
										 r_PackedHalf2AtPtx2194R572); // PTX L2797
	r_PackedHalf2AtPtx2801R974 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1195R1108, r_PackedHalf2AtPtx2797R699); // PTX L2801
	r_LaneIndexAtPtx2805 = uint32_t((threadIdx.x & 31u));							  // PTX L2805
	r_PackedHalf2AtPtx2808R701 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1194R1107, r_PackedHalf2AtPtx2187R564);			  // PTX L2808
	r_PackedHalf2AtPtx2812R702 = HalfMax(r_PackedHalf2AtPtx2808R701, r_PackedHalf2AtPtx2180R566); // PTX L2812
	r_PackedHalf2AtPtx2816R703 = HalfAbs(r_PackedHalf2AtPtx2812R702);							  // PTX L2816
	r_PackedHalf2AtPtx2820R704 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2816R703,
										 r_PackedHalf2AtPtx2201R570); // PTX L2820
	r_PackedHalf2AtPtx2824R705 = HalfFma(r_PackedHalf2AtPtx2812R702, r_PackedHalf2AtPtx2820R704,
										 r_PackedHalf2AtPtx2194R572); // PTX L2824
	r_PackedHalf2AtPtx2828R973 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1194R1107, r_PackedHalf2AtPtx2824R705); // PTX L2828
	r_LaneIndexAtPtx2832 = uint32_t((threadIdx.x & 31u));							  // PTX L2832
	r_PackedHalf2AtPtx2835R707 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1193R1106, r_PackedHalf2AtPtx2187R564);			  // PTX L2835
	r_PackedHalf2AtPtx2839R708 = HalfMax(r_PackedHalf2AtPtx2835R707, r_PackedHalf2AtPtx2180R566); // PTX L2839
	r_PackedHalf2AtPtx2843R709 = HalfAbs(r_PackedHalf2AtPtx2839R708);							  // PTX L2843
	r_PackedHalf2AtPtx2847R710 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2843R709,
										 r_PackedHalf2AtPtx2201R570); // PTX L2847
	r_PackedHalf2AtPtx2851R711 = HalfFma(r_PackedHalf2AtPtx2839R708, r_PackedHalf2AtPtx2847R710,
										 r_PackedHalf2AtPtx2194R572); // PTX L2851
	r_PackedHalf2AtPtx2855R975 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1193R1106, r_PackedHalf2AtPtx2851R711); // PTX L2855
	r_LaneIndexAtPtx2859 = uint32_t((threadIdx.x & 31u));							  // PTX L2859
	r_PackedHalf2AtPtx2862R713 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1192R1105, r_PackedHalf2AtPtx2187R564);			  // PTX L2862
	r_PackedHalf2AtPtx2866R714 = HalfMax(r_PackedHalf2AtPtx2862R713, r_PackedHalf2AtPtx2180R566); // PTX L2866
	r_PackedHalf2AtPtx2870R715 = HalfAbs(r_PackedHalf2AtPtx2866R714);							  // PTX L2870
	r_PackedHalf2AtPtx2874R716 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2870R715,
										 r_PackedHalf2AtPtx2201R570); // PTX L2874
	r_PackedHalf2AtPtx2878R717 = HalfFma(r_PackedHalf2AtPtx2866R714, r_PackedHalf2AtPtx2874R716,
										 r_PackedHalf2AtPtx2194R572); // PTX L2878
	r_PackedHalf2AtPtx2882R976 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1192R1105, r_PackedHalf2AtPtx2878R717); // PTX L2882
	r_LaneIndexAtPtx2886 = uint32_t((threadIdx.x & 31u));							  // PTX L2886
	r_PackedHalf2AtPtx2889R719 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1191R1104, r_PackedHalf2AtPtx2187R564);			  // PTX L2889
	r_PackedHalf2AtPtx2893R720 = HalfMax(r_PackedHalf2AtPtx2889R719, r_PackedHalf2AtPtx2180R566); // PTX L2893
	r_PackedHalf2AtPtx2897R721 = HalfAbs(r_PackedHalf2AtPtx2893R720);							  // PTX L2897
	r_PackedHalf2AtPtx2901R722 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2897R721,
										 r_PackedHalf2AtPtx2201R570); // PTX L2901
	r_PackedHalf2AtPtx2905R723 = HalfFma(r_PackedHalf2AtPtx2893R720, r_PackedHalf2AtPtx2901R722,
										 r_PackedHalf2AtPtx2194R572); // PTX L2905
	r_PackedHalf2AtPtx2909R978 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1191R1104, r_PackedHalf2AtPtx2905R723); // PTX L2909
	r_LaneIndexAtPtx2913 = uint32_t((threadIdx.x & 31u));							  // PTX L2913
	r_PackedHalf2AtPtx2916R725 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1190R1103, r_PackedHalf2AtPtx2187R564);			  // PTX L2916
	r_PackedHalf2AtPtx2920R726 = HalfMax(r_PackedHalf2AtPtx2916R725, r_PackedHalf2AtPtx2180R566); // PTX L2920
	r_PackedHalf2AtPtx2924R727 = HalfAbs(r_PackedHalf2AtPtx2920R726);							  // PTX L2924
	r_PackedHalf2AtPtx2928R728 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2924R727,
										 r_PackedHalf2AtPtx2201R570); // PTX L2928
	r_PackedHalf2AtPtx2932R729 = HalfFma(r_PackedHalf2AtPtx2920R726, r_PackedHalf2AtPtx2928R728,
										 r_PackedHalf2AtPtx2194R572); // PTX L2932
	r_PackedHalf2AtPtx2936R977 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1190R1103, r_PackedHalf2AtPtx2932R729); // PTX L2936
	r_LaneIndexAtPtx2940 = uint32_t((threadIdx.x & 31u));							  // PTX L2940
	r_PackedHalf2AtPtx2943R731 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1189R1102, r_PackedHalf2AtPtx2187R564);			  // PTX L2943
	r_PackedHalf2AtPtx2947R732 = HalfMax(r_PackedHalf2AtPtx2943R731, r_PackedHalf2AtPtx2180R566); // PTX L2947
	r_PackedHalf2AtPtx2951R733 = HalfAbs(r_PackedHalf2AtPtx2947R732);							  // PTX L2951
	r_PackedHalf2AtPtx2955R734 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2951R733,
										 r_PackedHalf2AtPtx2201R570); // PTX L2955
	r_PackedHalf2AtPtx2959R735 = HalfFma(r_PackedHalf2AtPtx2947R732, r_PackedHalf2AtPtx2955R734,
										 r_PackedHalf2AtPtx2194R572); // PTX L2959
	r_PackedHalf2AtPtx2963R979 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1189R1102, r_PackedHalf2AtPtx2959R735); // PTX L2963
	r_LaneIndexAtPtx2967 = uint32_t((threadIdx.x & 31u));							  // PTX L2967
	r_PackedHalf2AtPtx2970R737 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1188R1101, r_PackedHalf2AtPtx2187R564);			  // PTX L2970
	r_PackedHalf2AtPtx2974R738 = HalfMax(r_PackedHalf2AtPtx2970R737, r_PackedHalf2AtPtx2180R566); // PTX L2974
	r_PackedHalf2AtPtx2978R739 = HalfAbs(r_PackedHalf2AtPtx2974R738);							  // PTX L2978
	r_PackedHalf2AtPtx2982R740 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx2978R739,
										 r_PackedHalf2AtPtx2201R570); // PTX L2982
	r_PackedHalf2AtPtx2986R741 = HalfFma(r_PackedHalf2AtPtx2974R738, r_PackedHalf2AtPtx2982R740,
										 r_PackedHalf2AtPtx2194R572); // PTX L2986
	r_PackedHalf2AtPtx2990R980 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1188R1101, r_PackedHalf2AtPtx2986R741); // PTX L2990
	r_LaneIndexAtPtx2994 = uint32_t((threadIdx.x & 31u));							  // PTX L2994
	r_PackedHalf2AtPtx2997R743 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1187R1100, r_PackedHalf2AtPtx2187R564);			  // PTX L2997
	r_PackedHalf2AtPtx3001R744 = HalfMax(r_PackedHalf2AtPtx2997R743, r_PackedHalf2AtPtx2180R566); // PTX L3001
	r_PackedHalf2AtPtx3005R745 = HalfAbs(r_PackedHalf2AtPtx3001R744);							  // PTX L3005
	r_PackedHalf2AtPtx3009R746 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3005R745,
										 r_PackedHalf2AtPtx2201R570); // PTX L3009
	r_PackedHalf2AtPtx3013R747 = HalfFma(r_PackedHalf2AtPtx3001R744, r_PackedHalf2AtPtx3009R746,
										 r_PackedHalf2AtPtx2194R572); // PTX L3013
	r_PackedHalf2AtPtx3017R982 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1187R1100, r_PackedHalf2AtPtx3013R747); // PTX L3017
	r_LaneIndexAtPtx3021 = uint32_t((threadIdx.x & 31u));							  // PTX L3021
	r_PackedHalf2AtPtx3024R749 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1186R1099, r_PackedHalf2AtPtx2187R564);			  // PTX L3024
	r_PackedHalf2AtPtx3028R750 = HalfMax(r_PackedHalf2AtPtx3024R749, r_PackedHalf2AtPtx2180R566); // PTX L3028
	r_PackedHalf2AtPtx3032R751 = HalfAbs(r_PackedHalf2AtPtx3028R750);							  // PTX L3032
	r_PackedHalf2AtPtx3036R752 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3032R751,
										 r_PackedHalf2AtPtx2201R570); // PTX L3036
	r_PackedHalf2AtPtx3040R753 = HalfFma(r_PackedHalf2AtPtx3028R750, r_PackedHalf2AtPtx3036R752,
										 r_PackedHalf2AtPtx2194R572); // PTX L3040
	r_PackedHalf2AtPtx3044R981 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1186R1099, r_PackedHalf2AtPtx3040R753); // PTX L3044
	r_LaneIndexAtPtx3048 = uint32_t((threadIdx.x & 31u));							  // PTX L3048
	r_PackedHalf2AtPtx3051R755 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1185R1098, r_PackedHalf2AtPtx2187R564);			  // PTX L3051
	r_PackedHalf2AtPtx3055R756 = HalfMax(r_PackedHalf2AtPtx3051R755, r_PackedHalf2AtPtx2180R566); // PTX L3055
	r_PackedHalf2AtPtx3059R757 = HalfAbs(r_PackedHalf2AtPtx3055R756);							  // PTX L3059
	r_PackedHalf2AtPtx3063R758 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3059R757,
										 r_PackedHalf2AtPtx2201R570); // PTX L3063
	r_PackedHalf2AtPtx3067R759 = HalfFma(r_PackedHalf2AtPtx3055R756, r_PackedHalf2AtPtx3063R758,
										 r_PackedHalf2AtPtx2194R572); // PTX L3067
	r_PackedHalf2AtPtx3071R983 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1185R1098, r_PackedHalf2AtPtx3067R759); // PTX L3071
	r_LaneIndexAtPtx3075 = uint32_t((threadIdx.x & 31u));							  // PTX L3075
	r_PackedHalf2AtPtx3078R761 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1184R1097, r_PackedHalf2AtPtx2187R564);			  // PTX L3078
	r_PackedHalf2AtPtx3082R762 = HalfMax(r_PackedHalf2AtPtx3078R761, r_PackedHalf2AtPtx2180R566); // PTX L3082
	r_PackedHalf2AtPtx3086R763 = HalfAbs(r_PackedHalf2AtPtx3082R762);							  // PTX L3086
	r_PackedHalf2AtPtx3090R764 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3086R763,
										 r_PackedHalf2AtPtx2201R570); // PTX L3090
	r_PackedHalf2AtPtx3094R765 = HalfFma(r_PackedHalf2AtPtx3082R762, r_PackedHalf2AtPtx3090R764,
										 r_PackedHalf2AtPtx2194R572); // PTX L3094
	r_PackedHalf2AtPtx3098R984 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1184R1097, r_PackedHalf2AtPtx3094R765); // PTX L3098
	r_LaneIndexAtPtx3102 = uint32_t((threadIdx.x & 31u));							  // PTX L3102
	r_PackedHalf2AtPtx3105R767 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1183R1096, r_PackedHalf2AtPtx2187R564);			  // PTX L3105
	r_PackedHalf2AtPtx3109R768 = HalfMax(r_PackedHalf2AtPtx3105R767, r_PackedHalf2AtPtx2180R566); // PTX L3109
	r_PackedHalf2AtPtx3113R769 = HalfAbs(r_PackedHalf2AtPtx3109R768);							  // PTX L3113
	r_PackedHalf2AtPtx3117R770 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3113R769,
										 r_PackedHalf2AtPtx2201R570); // PTX L3117
	r_PackedHalf2AtPtx3121R771 = HalfFma(r_PackedHalf2AtPtx3109R768, r_PackedHalf2AtPtx3117R770,
										 r_PackedHalf2AtPtx2194R572); // PTX L3121
	r_PackedHalf2AtPtx3125R986 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1183R1096, r_PackedHalf2AtPtx3121R771); // PTX L3125
	r_LaneIndexAtPtx3129 = uint32_t((threadIdx.x & 31u));							  // PTX L3129
	r_PackedHalf2AtPtx3132R773 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1182R1095, r_PackedHalf2AtPtx2187R564);			  // PTX L3132
	r_PackedHalf2AtPtx3136R774 = HalfMax(r_PackedHalf2AtPtx3132R773, r_PackedHalf2AtPtx2180R566); // PTX L3136
	r_PackedHalf2AtPtx3140R775 = HalfAbs(r_PackedHalf2AtPtx3136R774);							  // PTX L3140
	r_PackedHalf2AtPtx3144R776 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3140R775,
										 r_PackedHalf2AtPtx2201R570); // PTX L3144
	r_PackedHalf2AtPtx3148R777 = HalfFma(r_PackedHalf2AtPtx3136R774, r_PackedHalf2AtPtx3144R776,
										 r_PackedHalf2AtPtx2194R572); // PTX L3148
	r_PackedHalf2AtPtx3152R985 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1182R1095, r_PackedHalf2AtPtx3148R777); // PTX L3152
	r_LaneIndexAtPtx3156 = uint32_t((threadIdx.x & 31u));							  // PTX L3156
	r_PackedHalf2AtPtx3159R779 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1181R1094, r_PackedHalf2AtPtx2187R564);			  // PTX L3159
	r_PackedHalf2AtPtx3163R780 = HalfMax(r_PackedHalf2AtPtx3159R779, r_PackedHalf2AtPtx2180R566); // PTX L3163
	r_PackedHalf2AtPtx3167R781 = HalfAbs(r_PackedHalf2AtPtx3163R780);							  // PTX L3167
	r_PackedHalf2AtPtx3171R782 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3167R781,
										 r_PackedHalf2AtPtx2201R570); // PTX L3171
	r_PackedHalf2AtPtx3175R783 = HalfFma(r_PackedHalf2AtPtx3163R780, r_PackedHalf2AtPtx3171R782,
										 r_PackedHalf2AtPtx2194R572); // PTX L3175
	r_PackedHalf2AtPtx3179R987 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1181R1094, r_PackedHalf2AtPtx3175R783); // PTX L3179
	r_LaneIndexAtPtx3183 = uint32_t((threadIdx.x & 31u));							  // PTX L3183
	r_PackedHalf2AtPtx3186R785 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1180R1093, r_PackedHalf2AtPtx2187R564);			  // PTX L3186
	r_PackedHalf2AtPtx3190R786 = HalfMax(r_PackedHalf2AtPtx3186R785, r_PackedHalf2AtPtx2180R566); // PTX L3190
	r_PackedHalf2AtPtx3194R787 = HalfAbs(r_PackedHalf2AtPtx3190R786);							  // PTX L3194
	r_PackedHalf2AtPtx3198R788 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3194R787,
										 r_PackedHalf2AtPtx2201R570); // PTX L3198
	r_PackedHalf2AtPtx3202R789 = HalfFma(r_PackedHalf2AtPtx3190R786, r_PackedHalf2AtPtx3198R788,
										 r_PackedHalf2AtPtx2194R572); // PTX L3202
	r_PackedHalf2AtPtx3206R988 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1180R1093, r_PackedHalf2AtPtx3202R789); // PTX L3206
	r_LaneIndexAtPtx3210 = uint32_t((threadIdx.x & 31u));							  // PTX L3210
	r_PackedHalf2AtPtx3213R791 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1179R1092, r_PackedHalf2AtPtx2187R564);			  // PTX L3213
	r_PackedHalf2AtPtx3217R792 = HalfMax(r_PackedHalf2AtPtx3213R791, r_PackedHalf2AtPtx2180R566); // PTX L3217
	r_PackedHalf2AtPtx3221R793 = HalfAbs(r_PackedHalf2AtPtx3217R792);							  // PTX L3221
	r_PackedHalf2AtPtx3225R794 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3221R793,
										 r_PackedHalf2AtPtx2201R570); // PTX L3225
	r_PackedHalf2AtPtx3229R795 = HalfFma(r_PackedHalf2AtPtx3217R792, r_PackedHalf2AtPtx3225R794,
										 r_PackedHalf2AtPtx2194R572); // PTX L3229
	r_PackedHalf2AtPtx3233R990 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1179R1092, r_PackedHalf2AtPtx3229R795); // PTX L3233
	r_LaneIndexAtPtx3237 = uint32_t((threadIdx.x & 31u));							  // PTX L3237
	r_PackedHalf2AtPtx3240R797 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1178R1091, r_PackedHalf2AtPtx2187R564);			  // PTX L3240
	r_PackedHalf2AtPtx3244R798 = HalfMax(r_PackedHalf2AtPtx3240R797, r_PackedHalf2AtPtx2180R566); // PTX L3244
	r_PackedHalf2AtPtx3248R799 = HalfAbs(r_PackedHalf2AtPtx3244R798);							  // PTX L3248
	r_PackedHalf2AtPtx3252R800 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3248R799,
										 r_PackedHalf2AtPtx2201R570); // PTX L3252
	r_PackedHalf2AtPtx3256R801 = HalfFma(r_PackedHalf2AtPtx3244R798, r_PackedHalf2AtPtx3252R800,
										 r_PackedHalf2AtPtx2194R572); // PTX L3256
	r_PackedHalf2AtPtx3260R989 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1178R1091, r_PackedHalf2AtPtx3256R801); // PTX L3260
	r_LaneIndexAtPtx3264 = uint32_t((threadIdx.x & 31u));							  // PTX L3264
	r_PackedHalf2AtPtx3267R803 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1177R1090, r_PackedHalf2AtPtx2187R564);			  // PTX L3267
	r_PackedHalf2AtPtx3271R804 = HalfMax(r_PackedHalf2AtPtx3267R803, r_PackedHalf2AtPtx2180R566); // PTX L3271
	r_PackedHalf2AtPtx3275R805 = HalfAbs(r_PackedHalf2AtPtx3271R804);							  // PTX L3275
	r_PackedHalf2AtPtx3279R806 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3275R805,
										 r_PackedHalf2AtPtx2201R570); // PTX L3279
	r_PackedHalf2AtPtx3283R807 = HalfFma(r_PackedHalf2AtPtx3271R804, r_PackedHalf2AtPtx3279R806,
										 r_PackedHalf2AtPtx2194R572); // PTX L3283
	r_PackedHalf2AtPtx3287R991 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1177R1090, r_PackedHalf2AtPtx3283R807); // PTX L3287
	r_LaneIndexAtPtx3291 = uint32_t((threadIdx.x & 31u));							  // PTX L3291
	r_PackedHalf2AtPtx3294R809 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1176R1089, r_PackedHalf2AtPtx2187R564);			  // PTX L3294
	r_PackedHalf2AtPtx3298R810 = HalfMax(r_PackedHalf2AtPtx3294R809, r_PackedHalf2AtPtx2180R566); // PTX L3298
	r_PackedHalf2AtPtx3302R811 = HalfAbs(r_PackedHalf2AtPtx3298R810);							  // PTX L3302
	r_PackedHalf2AtPtx3306R812 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3302R811,
										 r_PackedHalf2AtPtx2201R570); // PTX L3306
	r_PackedHalf2AtPtx3310R813 = HalfFma(r_PackedHalf2AtPtx3298R810, r_PackedHalf2AtPtx3306R812,
										 r_PackedHalf2AtPtx2194R572); // PTX L3310
	r_PackedHalf2AtPtx3314R992 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1176R1089, r_PackedHalf2AtPtx3310R813); // PTX L3314
	r_LaneIndexAtPtx3318 = uint32_t((threadIdx.x & 31u));							  // PTX L3318
	r_PackedHalf2AtPtx3321R815 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1175R1088, r_PackedHalf2AtPtx2187R564);			  // PTX L3321
	r_PackedHalf2AtPtx3325R816 = HalfMax(r_PackedHalf2AtPtx3321R815, r_PackedHalf2AtPtx2180R566); // PTX L3325
	r_PackedHalf2AtPtx3329R817 = HalfAbs(r_PackedHalf2AtPtx3325R816);							  // PTX L3329
	r_PackedHalf2AtPtx3333R818 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3329R817,
										 r_PackedHalf2AtPtx2201R570); // PTX L3333
	r_PackedHalf2AtPtx3337R819 = HalfFma(r_PackedHalf2AtPtx3325R816, r_PackedHalf2AtPtx3333R818,
										 r_PackedHalf2AtPtx2194R572); // PTX L3337
	r_PackedHalf2AtPtx3341R994 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1175R1088, r_PackedHalf2AtPtx3337R819); // PTX L3341
	r_LaneIndexAtPtx3345 = uint32_t((threadIdx.x & 31u));							  // PTX L3345
	r_PackedHalf2AtPtx3348R821 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1174R1087, r_PackedHalf2AtPtx2187R564);			  // PTX L3348
	r_PackedHalf2AtPtx3352R822 = HalfMax(r_PackedHalf2AtPtx3348R821, r_PackedHalf2AtPtx2180R566); // PTX L3352
	r_PackedHalf2AtPtx3356R823 = HalfAbs(r_PackedHalf2AtPtx3352R822);							  // PTX L3356
	r_PackedHalf2AtPtx3360R824 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3356R823,
										 r_PackedHalf2AtPtx2201R570); // PTX L3360
	r_PackedHalf2AtPtx3364R825 = HalfFma(r_PackedHalf2AtPtx3352R822, r_PackedHalf2AtPtx3360R824,
										 r_PackedHalf2AtPtx2194R572); // PTX L3364
	r_PackedHalf2AtPtx3368R993 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1174R1087, r_PackedHalf2AtPtx3364R825); // PTX L3368
	r_LaneIndexAtPtx3372 = uint32_t((threadIdx.x & 31u));							  // PTX L3372
	r_PackedHalf2AtPtx3375R827 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1173R1086, r_PackedHalf2AtPtx2187R564);			  // PTX L3375
	r_PackedHalf2AtPtx3379R828 = HalfMax(r_PackedHalf2AtPtx3375R827, r_PackedHalf2AtPtx2180R566); // PTX L3379
	r_PackedHalf2AtPtx3383R829 = HalfAbs(r_PackedHalf2AtPtx3379R828);							  // PTX L3383
	r_PackedHalf2AtPtx3387R830 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3383R829,
										 r_PackedHalf2AtPtx2201R570); // PTX L3387
	r_PackedHalf2AtPtx3391R831 = HalfFma(r_PackedHalf2AtPtx3379R828, r_PackedHalf2AtPtx3387R830,
										 r_PackedHalf2AtPtx2194R572); // PTX L3391
	r_PackedHalf2AtPtx3395R995 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1173R1086, r_PackedHalf2AtPtx3391R831); // PTX L3395
	r_LaneIndexAtPtx3399 = uint32_t((threadIdx.x & 31u));							  // PTX L3399
	r_PackedHalf2AtPtx3402R833 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1172R1085, r_PackedHalf2AtPtx2187R564);			  // PTX L3402
	r_PackedHalf2AtPtx3406R834 = HalfMax(r_PackedHalf2AtPtx3402R833, r_PackedHalf2AtPtx2180R566); // PTX L3406
	r_PackedHalf2AtPtx3410R835 = HalfAbs(r_PackedHalf2AtPtx3406R834);							  // PTX L3410
	r_PackedHalf2AtPtx3414R836 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3410R835,
										 r_PackedHalf2AtPtx2201R570); // PTX L3414
	r_PackedHalf2AtPtx3418R837 = HalfFma(r_PackedHalf2AtPtx3406R834, r_PackedHalf2AtPtx3414R836,
										 r_PackedHalf2AtPtx2194R572); // PTX L3418
	r_PackedHalf2AtPtx3422R996 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1172R1085, r_PackedHalf2AtPtx3418R837); // PTX L3422
	r_LaneIndexAtPtx3426 = uint32_t((threadIdx.x & 31u));							  // PTX L3426
	r_PackedHalf2AtPtx3429R839 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1171R1084, r_PackedHalf2AtPtx2187R564);			  // PTX L3429
	r_PackedHalf2AtPtx3433R840 = HalfMax(r_PackedHalf2AtPtx3429R839, r_PackedHalf2AtPtx2180R566); // PTX L3433
	r_PackedHalf2AtPtx3437R841 = HalfAbs(r_PackedHalf2AtPtx3433R840);							  // PTX L3437
	r_PackedHalf2AtPtx3441R842 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3437R841,
										 r_PackedHalf2AtPtx2201R570); // PTX L3441
	r_PackedHalf2AtPtx3445R843 = HalfFma(r_PackedHalf2AtPtx3433R840, r_PackedHalf2AtPtx3441R842,
										 r_PackedHalf2AtPtx2194R572); // PTX L3445
	r_PackedHalf2AtPtx3449R998 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1171R1084, r_PackedHalf2AtPtx3445R843); // PTX L3449
	r_LaneIndexAtPtx3453 = uint32_t((threadIdx.x & 31u));							  // PTX L3453
	r_PackedHalf2AtPtx3456R845 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1170R1083, r_PackedHalf2AtPtx2187R564);			  // PTX L3456
	r_PackedHalf2AtPtx3460R846 = HalfMax(r_PackedHalf2AtPtx3456R845, r_PackedHalf2AtPtx2180R566); // PTX L3460
	r_PackedHalf2AtPtx3464R847 = HalfAbs(r_PackedHalf2AtPtx3460R846);							  // PTX L3464
	r_PackedHalf2AtPtx3468R848 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3464R847,
										 r_PackedHalf2AtPtx2201R570); // PTX L3468
	r_PackedHalf2AtPtx3472R849 = HalfFma(r_PackedHalf2AtPtx3460R846, r_PackedHalf2AtPtx3468R848,
										 r_PackedHalf2AtPtx2194R572); // PTX L3472
	r_PackedHalf2AtPtx3476R997 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1170R1083, r_PackedHalf2AtPtx3472R849); // PTX L3476
	r_LaneIndexAtPtx3480 = uint32_t((threadIdx.x & 31u));							  // PTX L3480
	r_PackedHalf2AtPtx3483R851 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1169R1082, r_PackedHalf2AtPtx2187R564);			  // PTX L3483
	r_PackedHalf2AtPtx3487R852 = HalfMax(r_PackedHalf2AtPtx3483R851, r_PackedHalf2AtPtx2180R566); // PTX L3487
	r_PackedHalf2AtPtx3491R853 = HalfAbs(r_PackedHalf2AtPtx3487R852);							  // PTX L3491
	r_PackedHalf2AtPtx3495R854 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3491R853,
										 r_PackedHalf2AtPtx2201R570); // PTX L3495
	r_PackedHalf2AtPtx3499R855 = HalfFma(r_PackedHalf2AtPtx3487R852, r_PackedHalf2AtPtx3495R854,
										 r_PackedHalf2AtPtx2194R572); // PTX L3499
	r_PackedHalf2AtPtx3503R999 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1169R1082, r_PackedHalf2AtPtx3499R855); // PTX L3503
	r_LaneIndexAtPtx3507 = uint32_t((threadIdx.x & 31u));							  // PTX L3507
	r_PackedHalf2AtPtx3510R857 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1168R1081, r_PackedHalf2AtPtx2187R564);			  // PTX L3510
	r_PackedHalf2AtPtx3514R858 = HalfMax(r_PackedHalf2AtPtx3510R857, r_PackedHalf2AtPtx2180R566); // PTX L3514
	r_PackedHalf2AtPtx3518R859 = HalfAbs(r_PackedHalf2AtPtx3514R858);							  // PTX L3518
	r_PackedHalf2AtPtx3522R860 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3518R859,
										 r_PackedHalf2AtPtx2201R570); // PTX L3522
	r_PackedHalf2AtPtx3526R861 = HalfFma(r_PackedHalf2AtPtx3514R858, r_PackedHalf2AtPtx3522R860,
										 r_PackedHalf2AtPtx2194R572); // PTX L3526
	r_PackedHalf2AtPtx3530R1000 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1168R1081, r_PackedHalf2AtPtx3526R861); // PTX L3530
	r_LaneIndexAtPtx3534 = uint32_t((threadIdx.x & 31u));							  // PTX L3534
	r_PackedHalf2AtPtx3537R863 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1167R1080, r_PackedHalf2AtPtx2187R564);			  // PTX L3537
	r_PackedHalf2AtPtx3541R864 = HalfMax(r_PackedHalf2AtPtx3537R863, r_PackedHalf2AtPtx2180R566); // PTX L3541
	r_PackedHalf2AtPtx3545R865 = HalfAbs(r_PackedHalf2AtPtx3541R864);							  // PTX L3545
	r_PackedHalf2AtPtx3549R866 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3545R865,
										 r_PackedHalf2AtPtx2201R570); // PTX L3549
	r_PackedHalf2AtPtx3553R867 = HalfFma(r_PackedHalf2AtPtx3541R864, r_PackedHalf2AtPtx3549R866,
										 r_PackedHalf2AtPtx2194R572); // PTX L3553
	r_PackedHalf2AtPtx3557R1002 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1167R1080, r_PackedHalf2AtPtx3553R867); // PTX L3557
	r_LaneIndexAtPtx3561 = uint32_t((threadIdx.x & 31u));							  // PTX L3561
	r_PackedHalf2AtPtx3564R869 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1166R1079, r_PackedHalf2AtPtx2187R564);			  // PTX L3564
	r_PackedHalf2AtPtx3568R870 = HalfMax(r_PackedHalf2AtPtx3564R869, r_PackedHalf2AtPtx2180R566); // PTX L3568
	r_PackedHalf2AtPtx3572R871 = HalfAbs(r_PackedHalf2AtPtx3568R870);							  // PTX L3572
	r_PackedHalf2AtPtx3576R872 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3572R871,
										 r_PackedHalf2AtPtx2201R570); // PTX L3576
	r_PackedHalf2AtPtx3580R873 = HalfFma(r_PackedHalf2AtPtx3568R870, r_PackedHalf2AtPtx3576R872,
										 r_PackedHalf2AtPtx2194R572); // PTX L3580
	r_PackedHalf2AtPtx3584R1001 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1166R1079, r_PackedHalf2AtPtx3580R873); // PTX L3584
	r_LaneIndexAtPtx3588 = uint32_t((threadIdx.x & 31u));							  // PTX L3588
	r_PackedHalf2AtPtx3591R875 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1165R1078, r_PackedHalf2AtPtx2187R564);			  // PTX L3591
	r_PackedHalf2AtPtx3595R876 = HalfMax(r_PackedHalf2AtPtx3591R875, r_PackedHalf2AtPtx2180R566); // PTX L3595
	r_PackedHalf2AtPtx3599R877 = HalfAbs(r_PackedHalf2AtPtx3595R876);							  // PTX L3599
	r_PackedHalf2AtPtx3603R878 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3599R877,
										 r_PackedHalf2AtPtx2201R570); // PTX L3603
	r_PackedHalf2AtPtx3607R879 = HalfFma(r_PackedHalf2AtPtx3595R876, r_PackedHalf2AtPtx3603R878,
										 r_PackedHalf2AtPtx2194R572); // PTX L3607
	r_PackedHalf2AtPtx3611R1003 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1165R1078, r_PackedHalf2AtPtx3607R879); // PTX L3611
	r_LaneIndexAtPtx3615 = uint32_t((threadIdx.x & 31u));							  // PTX L3615
	r_PackedHalf2AtPtx3618R881 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1164R1077, r_PackedHalf2AtPtx2187R564);			  // PTX L3618
	r_PackedHalf2AtPtx3622R882 = HalfMax(r_PackedHalf2AtPtx3618R881, r_PackedHalf2AtPtx2180R566); // PTX L3622
	r_PackedHalf2AtPtx3626R883 = HalfAbs(r_PackedHalf2AtPtx3622R882);							  // PTX L3626
	r_PackedHalf2AtPtx3630R884 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3626R883,
										 r_PackedHalf2AtPtx2201R570); // PTX L3630
	r_PackedHalf2AtPtx3634R885 = HalfFma(r_PackedHalf2AtPtx3622R882, r_PackedHalf2AtPtx3630R884,
										 r_PackedHalf2AtPtx2194R572); // PTX L3634
	r_PackedHalf2AtPtx3638R1004 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1164R1077, r_PackedHalf2AtPtx3634R885); // PTX L3638
	r_LaneIndexAtPtx3642 = uint32_t((threadIdx.x & 31u));							  // PTX L3642
	r_PackedHalf2AtPtx3645R887 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1163R1076, r_PackedHalf2AtPtx2187R564);			  // PTX L3645
	r_PackedHalf2AtPtx3649R888 = HalfMax(r_PackedHalf2AtPtx3645R887, r_PackedHalf2AtPtx2180R566); // PTX L3649
	r_PackedHalf2AtPtx3653R889 = HalfAbs(r_PackedHalf2AtPtx3649R888);							  // PTX L3653
	r_PackedHalf2AtPtx3657R890 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3653R889,
										 r_PackedHalf2AtPtx2201R570); // PTX L3657
	r_PackedHalf2AtPtx3661R891 = HalfFma(r_PackedHalf2AtPtx3649R888, r_PackedHalf2AtPtx3657R890,
										 r_PackedHalf2AtPtx2194R572); // PTX L3661
	r_PackedHalf2AtPtx3665R1006 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1163R1076, r_PackedHalf2AtPtx3661R891); // PTX L3665
	r_LaneIndexAtPtx3669 = uint32_t((threadIdx.x & 31u));							  // PTX L3669
	r_PackedHalf2AtPtx3672R893 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1162R1075, r_PackedHalf2AtPtx2187R564);			  // PTX L3672
	r_PackedHalf2AtPtx3676R894 = HalfMax(r_PackedHalf2AtPtx3672R893, r_PackedHalf2AtPtx2180R566); // PTX L3676
	r_PackedHalf2AtPtx3680R895 = HalfAbs(r_PackedHalf2AtPtx3676R894);							  // PTX L3680
	r_PackedHalf2AtPtx3684R896 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3680R895,
										 r_PackedHalf2AtPtx2201R570); // PTX L3684
	r_PackedHalf2AtPtx3688R897 = HalfFma(r_PackedHalf2AtPtx3676R894, r_PackedHalf2AtPtx3684R896,
										 r_PackedHalf2AtPtx2194R572); // PTX L3688
	r_PackedHalf2AtPtx3692R1005 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1162R1075, r_PackedHalf2AtPtx3688R897);			  // PTX L3692
	r_LaneIndexAtPtx3696 = uint32_t((threadIdx.x & 31u));										  // PTX L3696
	r_PackedHalf2AtPtx3699R899 = HalfMin(r_PackedHalf2AtPtx59R1074, r_PackedHalf2AtPtx2187R564);  // PTX L3699
	r_PackedHalf2AtPtx3703R900 = HalfMax(r_PackedHalf2AtPtx3699R899, r_PackedHalf2AtPtx2180R566); // PTX L3703
	r_PackedHalf2AtPtx3707R901 = HalfAbs(r_PackedHalf2AtPtx3703R900);							  // PTX L3707
	r_PackedHalf2AtPtx3711R902 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3707R901,
										 r_PackedHalf2AtPtx2201R570); // PTX L3711
	r_PackedHalf2AtPtx3715R903 = HalfFma(r_PackedHalf2AtPtx3703R900, r_PackedHalf2AtPtx3711R902,
										 r_PackedHalf2AtPtx2194R572);							  // PTX L3715
	r_PackedHalf2AtPtx3719R1007 = HalfMul(r_PackedHalf2AtPtx59R1074, r_PackedHalf2AtPtx3715R903); // PTX L3719
	r_LaneIndexAtPtx3723 = uint32_t((threadIdx.x & 31u));										  // PTX L3723
	r_PackedHalf2AtPtx3726R905 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1217R1130, r_PackedHalf2AtPtx2187R564);			  // PTX L3726
	r_PackedHalf2AtPtx3730R906 = HalfMax(r_PackedHalf2AtPtx3726R905, r_PackedHalf2AtPtx2180R566); // PTX L3730
	r_PackedHalf2AtPtx3734R907 = HalfAbs(r_PackedHalf2AtPtx3730R906);							  // PTX L3734
	r_PackedHalf2AtPtx3738R908 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3734R907,
										 r_PackedHalf2AtPtx2201R570); // PTX L3738
	r_PackedHalf2AtPtx3742R909 = HalfFma(r_PackedHalf2AtPtx3730R906, r_PackedHalf2AtPtx3738R908,
										 r_PackedHalf2AtPtx2194R572); // PTX L3742
	r_PackedHalf2AtPtx3746R1008 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1217R1130, r_PackedHalf2AtPtx3742R909); // PTX L3746
	r_LaneIndexAtPtx3750 = uint32_t((threadIdx.x & 31u));							  // PTX L3750
	r_PackedHalf2AtPtx3753R911 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1218R1131, r_PackedHalf2AtPtx2187R564);			  // PTX L3753
	r_PackedHalf2AtPtx3757R912 = HalfMax(r_PackedHalf2AtPtx3753R911, r_PackedHalf2AtPtx2180R566); // PTX L3757
	r_PackedHalf2AtPtx3761R913 = HalfAbs(r_PackedHalf2AtPtx3757R912);							  // PTX L3761
	r_PackedHalf2AtPtx3765R914 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3761R913,
										 r_PackedHalf2AtPtx2201R570); // PTX L3765
	r_PackedHalf2AtPtx3769R915 = HalfFma(r_PackedHalf2AtPtx3757R912, r_PackedHalf2AtPtx3765R914,
										 r_PackedHalf2AtPtx2194R572); // PTX L3769
	r_PackedHalf2AtPtx3773R1010 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1218R1131, r_PackedHalf2AtPtx3769R915); // PTX L3773
	r_LaneIndexAtPtx3777 = uint32_t((threadIdx.x & 31u));							  // PTX L3777
	r_PackedHalf2AtPtx3780R917 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1219R1132, r_PackedHalf2AtPtx2187R564);			  // PTX L3780
	r_PackedHalf2AtPtx3784R918 = HalfMax(r_PackedHalf2AtPtx3780R917, r_PackedHalf2AtPtx2180R566); // PTX L3784
	r_PackedHalf2AtPtx3788R919 = HalfAbs(r_PackedHalf2AtPtx3784R918);							  // PTX L3788
	r_PackedHalf2AtPtx3792R920 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3788R919,
										 r_PackedHalf2AtPtx2201R570); // PTX L3792
	r_PackedHalf2AtPtx3796R921 = HalfFma(r_PackedHalf2AtPtx3784R918, r_PackedHalf2AtPtx3792R920,
										 r_PackedHalf2AtPtx2194R572); // PTX L3796
	r_PackedHalf2AtPtx3800R1009 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1219R1132, r_PackedHalf2AtPtx3796R921); // PTX L3800
	r_LaneIndexAtPtx3804 = uint32_t((threadIdx.x & 31u));							  // PTX L3804
	r_PackedHalf2AtPtx3807R923 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1220R1133, r_PackedHalf2AtPtx2187R564);			  // PTX L3807
	r_PackedHalf2AtPtx3811R924 = HalfMax(r_PackedHalf2AtPtx3807R923, r_PackedHalf2AtPtx2180R566); // PTX L3811
	r_PackedHalf2AtPtx3815R925 = HalfAbs(r_PackedHalf2AtPtx3811R924);							  // PTX L3815
	r_PackedHalf2AtPtx3819R926 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3815R925,
										 r_PackedHalf2AtPtx2201R570); // PTX L3819
	r_PackedHalf2AtPtx3823R927 = HalfFma(r_PackedHalf2AtPtx3811R924, r_PackedHalf2AtPtx3819R926,
										 r_PackedHalf2AtPtx2194R572); // PTX L3823
	r_PackedHalf2AtPtx3827R1011 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1220R1133, r_PackedHalf2AtPtx3823R927); // PTX L3827
	r_LaneIndexAtPtx3831 = uint32_t((threadIdx.x & 31u));							  // PTX L3831
	r_PackedHalf2AtPtx3834R929 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1221R1134, r_PackedHalf2AtPtx2187R564);			  // PTX L3834
	r_PackedHalf2AtPtx3838R930 = HalfMax(r_PackedHalf2AtPtx3834R929, r_PackedHalf2AtPtx2180R566); // PTX L3838
	r_PackedHalf2AtPtx3842R931 = HalfAbs(r_PackedHalf2AtPtx3838R930);							  // PTX L3842
	r_PackedHalf2AtPtx3846R932 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3842R931,
										 r_PackedHalf2AtPtx2201R570); // PTX L3846
	r_PackedHalf2AtPtx3850R933 = HalfFma(r_PackedHalf2AtPtx3838R930, r_PackedHalf2AtPtx3846R932,
										 r_PackedHalf2AtPtx2194R572); // PTX L3850
	r_PackedHalf2AtPtx3854R1012 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1221R1134, r_PackedHalf2AtPtx3850R933); // PTX L3854
	r_LaneIndexAtPtx3858 = uint32_t((threadIdx.x & 31u));							  // PTX L3858
	r_PackedHalf2AtPtx3861R935 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1222R1135, r_PackedHalf2AtPtx2187R564);			  // PTX L3861
	r_PackedHalf2AtPtx3865R936 = HalfMax(r_PackedHalf2AtPtx3861R935, r_PackedHalf2AtPtx2180R566); // PTX L3865
	r_PackedHalf2AtPtx3869R937 = HalfAbs(r_PackedHalf2AtPtx3865R936);							  // PTX L3869
	r_PackedHalf2AtPtx3873R938 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3869R937,
										 r_PackedHalf2AtPtx2201R570); // PTX L3873
	r_PackedHalf2AtPtx3877R939 = HalfFma(r_PackedHalf2AtPtx3865R936, r_PackedHalf2AtPtx3873R938,
										 r_PackedHalf2AtPtx2194R572); // PTX L3877
	r_PackedHalf2AtPtx3881R1014 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1222R1135, r_PackedHalf2AtPtx3877R939); // PTX L3881
	r_LaneIndexAtPtx3885 = uint32_t((threadIdx.x & 31u));							  // PTX L3885
	r_PackedHalf2AtPtx3888R941 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1223R1136, r_PackedHalf2AtPtx2187R564);			  // PTX L3888
	r_PackedHalf2AtPtx3892R942 = HalfMax(r_PackedHalf2AtPtx3888R941, r_PackedHalf2AtPtx2180R566); // PTX L3892
	r_PackedHalf2AtPtx3896R943 = HalfAbs(r_PackedHalf2AtPtx3892R942);							  // PTX L3896
	r_PackedHalf2AtPtx3900R944 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3896R943,
										 r_PackedHalf2AtPtx2201R570); // PTX L3900
	r_PackedHalf2AtPtx3904R945 = HalfFma(r_PackedHalf2AtPtx3892R942, r_PackedHalf2AtPtx3900R944,
										 r_PackedHalf2AtPtx2194R572); // PTX L3904
	r_PackedHalf2AtPtx3908R1013 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1223R1136, r_PackedHalf2AtPtx3904R945); // PTX L3908
	r_LaneIndexAtPtx3912 = uint32_t((threadIdx.x & 31u));							  // PTX L3912
	r_PackedHalf2AtPtx3915R947 =
		HalfMin(r_MmaAccumulatorHalf2WordAtPtx1224R1137, r_PackedHalf2AtPtx2187R564);			  // PTX L3915
	r_PackedHalf2AtPtx3919R948 = HalfMax(r_PackedHalf2AtPtx3915R947, r_PackedHalf2AtPtx2180R566); // PTX L3919
	r_PackedHalf2AtPtx3923R949 = HalfAbs(r_PackedHalf2AtPtx3919R948);							  // PTX L3923
	r_PackedHalf2AtPtx3927R950 = HalfFma(r_PackedHalf2AtPtx2208R568, r_PackedHalf2AtPtx3923R949,
										 r_PackedHalf2AtPtx2201R570); // PTX L3927
	r_PackedHalf2AtPtx3931R951 = HalfFma(r_PackedHalf2AtPtx3919R948, r_PackedHalf2AtPtx3927R950,
										 r_PackedHalf2AtPtx2194R572); // PTX L3931
	r_PackedHalf2AtPtx3935R1015 =
		HalfMul(r_MmaAccumulatorHalf2WordAtPtx1224R1137, r_PackedHalf2AtPtx3931R951);			  // PTX L3935
	r_ConvertedE4PairAtPtx3939Rs52 = PublishE4(r_PackedHalf2AtPtx2234R952);						  // PTX L3939
	r_ConvertedE4PairAtPtx3942Rs53 = PublishE4(r_PackedHalf2AtPtx2288R953);						  // PTX L3942
	r_ConvertedE4PairAtPtx3945Rs54 = PublishE4(r_PackedHalf2AtPtx2261R954);						  // PTX L3945
	r_ConvertedE4PairAtPtx3948Rs55 = PublishE4(r_PackedHalf2AtPtx2315R955);						  // PTX L3948
	r_ConvertedE4PairAtPtx3951Rs56 = PublishE4(r_PackedHalf2AtPtx2342R956);						  // PTX L3951
	r_ConvertedE4PairAtPtx3954Rs57 = PublishE4(r_PackedHalf2AtPtx2396R957);						  // PTX L3954
	r_ConvertedE4PairAtPtx3957Rs58 = PublishE4(r_PackedHalf2AtPtx2369R958);						  // PTX L3957
	r_ConvertedE4PairAtPtx3960Rs59 = PublishE4(r_PackedHalf2AtPtx2423R959);						  // PTX L3960
	r_ConvertedE4PairAtPtx3963Rs60 = PublishE4(r_PackedHalf2AtPtx2450R960);						  // PTX L3963
	r_ConvertedE4PairAtPtx3966Rs61 = PublishE4(r_PackedHalf2AtPtx2504R961);						  // PTX L3966
	r_ConvertedE4PairAtPtx3969Rs62 = PublishE4(r_PackedHalf2AtPtx2477R962);						  // PTX L3969
	r_ConvertedE4PairAtPtx3972Rs63 = PublishE4(r_PackedHalf2AtPtx2531R963);						  // PTX L3972
	r_ConvertedE4PairAtPtx3975Rs64 = PublishE4(r_PackedHalf2AtPtx2558R964);						  // PTX L3975
	r_ConvertedE4PairAtPtx3978Rs65 = PublishE4(r_PackedHalf2AtPtx2612R965);						  // PTX L3978
	r_ConvertedE4PairAtPtx3981Rs66 = PublishE4(r_PackedHalf2AtPtx2585R966);						  // PTX L3981
	r_ConvertedE4PairAtPtx3984Rs67 = PublishE4(r_PackedHalf2AtPtx2639R967);						  // PTX L3984
	r_ConvertedE4PairAtPtx3987Rs68 = PublishE4(r_PackedHalf2AtPtx2666R968);						  // PTX L3987
	r_ConvertedE4PairAtPtx3990Rs69 = PublishE4(r_PackedHalf2AtPtx2720R969);						  // PTX L3990
	r_ConvertedE4PairAtPtx3993Rs70 = PublishE4(r_PackedHalf2AtPtx2693R970);						  // PTX L3993
	r_ConvertedE4PairAtPtx3996Rs71 = PublishE4(r_PackedHalf2AtPtx2747R971);						  // PTX L3996
	r_ConvertedE4PairAtPtx3999Rs72 = PublishE4(r_PackedHalf2AtPtx2774R972);						  // PTX L3999
	r_ConvertedE4PairAtPtx4002Rs73 = PublishE4(r_PackedHalf2AtPtx2828R973);						  // PTX L4002
	r_ConvertedE4PairAtPtx4005Rs74 = PublishE4(r_PackedHalf2AtPtx2801R974);						  // PTX L4005
	r_ConvertedE4PairAtPtx4008Rs75 = PublishE4(r_PackedHalf2AtPtx2855R975);						  // PTX L4008
	r_ConvertedE4PairAtPtx4011Rs76 = PublishE4(r_PackedHalf2AtPtx2882R976);						  // PTX L4011
	r_ConvertedE4PairAtPtx4014Rs77 = PublishE4(r_PackedHalf2AtPtx2936R977);						  // PTX L4014
	r_ConvertedE4PairAtPtx4017Rs78 = PublishE4(r_PackedHalf2AtPtx2909R978);						  // PTX L4017
	r_ConvertedE4PairAtPtx4020Rs79 = PublishE4(r_PackedHalf2AtPtx2963R979);						  // PTX L4020
	r_ConvertedE4PairAtPtx4023Rs80 = PublishE4(r_PackedHalf2AtPtx2990R980);						  // PTX L4023
	r_ConvertedE4PairAtPtx4026Rs81 = PublishE4(r_PackedHalf2AtPtx3044R981);						  // PTX L4026
	r_ConvertedE4PairAtPtx4029Rs82 = PublishE4(r_PackedHalf2AtPtx3017R982);						  // PTX L4029
	r_ConvertedE4PairAtPtx4032Rs83 = PublishE4(r_PackedHalf2AtPtx3071R983);						  // PTX L4032
	r_ConvertedE4PairAtPtx4035Rs84 = PublishE4(r_PackedHalf2AtPtx3098R984);						  // PTX L4035
	r_ConvertedE4PairAtPtx4038Rs85 = PublishE4(r_PackedHalf2AtPtx3152R985);						  // PTX L4038
	r_ConvertedE4PairAtPtx4041Rs86 = PublishE4(r_PackedHalf2AtPtx3125R986);						  // PTX L4041
	r_ConvertedE4PairAtPtx4044Rs87 = PublishE4(r_PackedHalf2AtPtx3179R987);						  // PTX L4044
	r_ConvertedE4PairAtPtx4047Rs88 = PublishE4(r_PackedHalf2AtPtx3206R988);						  // PTX L4047
	r_ConvertedE4PairAtPtx4050Rs89 = PublishE4(r_PackedHalf2AtPtx3260R989);						  // PTX L4050
	r_ConvertedE4PairAtPtx4053Rs90 = PublishE4(r_PackedHalf2AtPtx3233R990);						  // PTX L4053
	r_ConvertedE4PairAtPtx4056Rs91 = PublishE4(r_PackedHalf2AtPtx3287R991);						  // PTX L4056
	r_ConvertedE4PairAtPtx4059Rs92 = PublishE4(r_PackedHalf2AtPtx3314R992);						  // PTX L4059
	r_ConvertedE4PairAtPtx4062Rs93 = PublishE4(r_PackedHalf2AtPtx3368R993);						  // PTX L4062
	r_ConvertedE4PairAtPtx4065Rs94 = PublishE4(r_PackedHalf2AtPtx3341R994);						  // PTX L4065
	r_ConvertedE4PairAtPtx4068Rs95 = PublishE4(r_PackedHalf2AtPtx3395R995);						  // PTX L4068
	r_ConvertedE4PairAtPtx4071Rs96 = PublishE4(r_PackedHalf2AtPtx3422R996);						  // PTX L4071
	r_ConvertedE4PairAtPtx4074Rs97 = PublishE4(r_PackedHalf2AtPtx3476R997);						  // PTX L4074
	r_ConvertedE4PairAtPtx4077Rs98 = PublishE4(r_PackedHalf2AtPtx3449R998);						  // PTX L4077
	r_ConvertedE4PairAtPtx4080Rs99 = PublishE4(r_PackedHalf2AtPtx3503R999);						  // PTX L4080
	r_ConvertedE4PairAtPtx4083Rs100 = PublishE4(r_PackedHalf2AtPtx3530R1000);					  // PTX L4083
	r_ConvertedE4PairAtPtx4086Rs101 = PublishE4(r_PackedHalf2AtPtx3584R1001);					  // PTX L4086
	r_ConvertedE4PairAtPtx4089Rs102 = PublishE4(r_PackedHalf2AtPtx3557R1002);					  // PTX L4089
	r_ConvertedE4PairAtPtx4092Rs103 = PublishE4(r_PackedHalf2AtPtx3611R1003);					  // PTX L4092
	r_ConvertedE4PairAtPtx4095Rs104 = PublishE4(r_PackedHalf2AtPtx3638R1004);					  // PTX L4095
	r_ConvertedE4PairAtPtx4098Rs105 = PublishE4(r_PackedHalf2AtPtx3692R1005);					  // PTX L4098
	r_ConvertedE4PairAtPtx4101Rs106 = PublishE4(r_PackedHalf2AtPtx3665R1006);					  // PTX L4101
	r_ConvertedE4PairAtPtx4104Rs107 = PublishE4(r_PackedHalf2AtPtx3719R1007);					  // PTX L4104
	r_ConvertedE4PairAtPtx4107Rs108 = PublishE4(r_PackedHalf2AtPtx3746R1008);					  // PTX L4107
	r_ConvertedE4PairAtPtx4110Rs109 = PublishE4(r_PackedHalf2AtPtx3800R1009);					  // PTX L4110
	r_ConvertedE4PairAtPtx4113Rs110 = PublishE4(r_PackedHalf2AtPtx3773R1010);					  // PTX L4113
	r_ConvertedE4PairAtPtx4116Rs111 = PublishE4(r_PackedHalf2AtPtx3827R1011);					  // PTX L4116
	r_ConvertedE4PairAtPtx4119Rs112 = PublishE4(r_PackedHalf2AtPtx3854R1012);					  // PTX L4119
	r_ConvertedE4PairAtPtx4122Rs113 = PublishE4(r_PackedHalf2AtPtx3908R1013);					  // PTX L4122
	r_ConvertedE4PairAtPtx4125Rs114 = PublishE4(r_PackedHalf2AtPtx3881R1014);					  // PTX L4125
	r_ConvertedE4PairAtPtx4128Rs115 = PublishE4(r_PackedHalf2AtPtx3935R1015);					  // PTX L4128
	r_PtxRegister49 = uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister3);						  // PTX L4130
	r_bPtxPredicate114 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister4);					  // PTX L4131
	r_PtxRegister1016 = ShiftLeft(uint32_t(r_PtxRegister6), uint32_t(2));						  // PTX L4132
	r_PtxRegister1017 = ShiftLeft(uint32_t(r_PtxRegister49), uint32_t(14));						  // PTX L4133
	r_PtxRegister1018 = uint32_t(r_PtxRegister1017) + uint32_t(r_PtxRegister1016);				  // PTX L4134
	r_PtxU64Register124 = uint64_t(int64_t(int32_t(r_PtxRegister1018)) * int64_t(int32_t(4)));	  // PTX L4135
	g_OutputByteAddressAtPtx4136 = uint64_t(g_OutputBaseAddress) + uint64_t(r_PtxU64Register124); // PTX L4136
	if (r_bPtxPredicate114)
	{
		goto L__BB41_164;
	} // PTX L4137
	r_PackedE4WordAtPtx4138R1028 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3981Rs66, r_ConvertedE4PairAtPtx3984Rs67); // PTX L4138
	r_PackedE4WordAtPtx4139R1027 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3975Rs64, r_ConvertedE4PairAtPtx3978Rs65); // PTX L4139
	r_PackedE4WordAtPtx4140R1026 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3969Rs62, r_ConvertedE4PairAtPtx3972Rs63); // PTX L4140
	r_PackedE4WordAtPtx4141R1025 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3963Rs60, r_ConvertedE4PairAtPtx3966Rs61); // PTX L4141
	r_PackedE4WordAtPtx4142R1023 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3957Rs58, r_ConvertedE4PairAtPtx3960Rs59); // PTX L4142
	r_PackedE4WordAtPtx4143R1022 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3951Rs56, r_ConvertedE4PairAtPtx3954Rs57); // PTX L4143
	r_PackedE4WordAtPtx4144R1021 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3945Rs54, r_ConvertedE4PairAtPtx3948Rs55); // PTX L4144
	r_PackedE4WordAtPtx4145R1020 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3939Rs52, r_ConvertedE4PairAtPtx3942Rs53); // PTX L4145
	r_LaneIndexAtPtx4147 = uint32_t((threadIdx.x & 31u));							   // PTX L4147
	r_PtxU64Register127 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4147)) * int64_t(int32_t(16))); // PTX L4149
	g_OutputByteAddressAtPtx4150 =
		uint64_t(g_OutputByteAddressAtPtx4136) + uint64_t(r_PtxU64Register127); // PTX L4150
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(g_OutputByteAddressAtPtx4150,
					make_uint4(r_PackedE4WordAtPtx4145R1020, r_PackedE4WordAtPtx4144R1021,
							   r_PackedE4WordAtPtx4143R1022,
							   r_PackedE4WordAtPtx4142R1023)); // PTX L4152
	r_LaneIndexAtPtx4155 = uint32_t((threadIdx.x & 31u));	   // PTX L4155
	r_PtxU64Register128 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4155)) * int64_t(int32_t(16))); // PTX L4157
	g_OutputByteAddressAtPtx4158 =
		uint64_t(g_OutputByteAddressAtPtx4136) + uint64_t(r_PtxU64Register128);			   // PTX L4158
	g_OutputByteAddressAtPtx4159 = uint64_t(g_OutputByteAddressAtPtx4158) + uint64_t(512); // PTX L4159
	StoreNoAllocate(g_OutputByteAddressAtPtx4159,
					make_uint4(r_PackedE4WordAtPtx4141R1025, r_PackedE4WordAtPtx4140R1026,
							   r_PackedE4WordAtPtx4139R1027,
							   r_PackedE4WordAtPtx4138R1028));								 // PTX L4161
L__BB41_164:																				 // PTX L4163
	r_PtxRegister1029 = uint32_t(r_PtxRegister49) + uint32_t(1);							 // PTX L4164
	r_bPtxPredicate115 = int32_t(r_PtxRegister1029) >= int32_t(r_PtxRegister4);				 // PTX L4165
	g_OutputByteAddressAtPtx4166 = uint64_t(g_OutputByteAddressAtPtx4136) + uint64_t(65536); // PTX L4166
	if (r_bPtxPredicate115)
	{
		goto L__BB41_166;
	} // PTX L4167
	r_LaneIndexAtPtx4169 = uint32_t((threadIdx.x & 31u)); // PTX L4169
	r_PtxU64Register132 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4169)) * int64_t(int32_t(16))); // PTX L4171
	g_OutputByteAddressAtPtx4172 =
		uint64_t(g_OutputByteAddressAtPtx4166) + uint64_t(r_PtxU64Register132); // PTX L4172
	r_PackedE4WordAtPtx4173R1034 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4005Rs74, r_ConvertedE4PairAtPtx4008Rs75); // PTX L4173
	r_PackedE4WordAtPtx4174R1033 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3999Rs72, r_ConvertedE4PairAtPtx4002Rs73); // PTX L4174
	r_PackedE4WordAtPtx4175R1032 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3993Rs70, r_ConvertedE4PairAtPtx3996Rs71); // PTX L4175
	r_PackedE4WordAtPtx4176R1031 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3987Rs68, r_ConvertedE4PairAtPtx3990Rs69); // PTX L4176
	StoreNoAllocate(g_OutputByteAddressAtPtx4172,
					make_uint4(r_PackedE4WordAtPtx4176R1031, r_PackedE4WordAtPtx4175R1032,
							   r_PackedE4WordAtPtx4174R1033,
							   r_PackedE4WordAtPtx4173R1034)); // PTX L4178
	r_LaneIndexAtPtx4181 = uint32_t((threadIdx.x & 31u));	   // PTX L4181
	r_PtxU64Register133 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4181)) * int64_t(int32_t(16))); // PTX L4183
	g_OutputByteAddressAtPtx4184 =
		uint64_t(g_OutputByteAddressAtPtx4136) + uint64_t(r_PtxU64Register133);				 // PTX L4184
	g_OutputByteAddressAtPtx4185 = uint64_t(g_OutputByteAddressAtPtx4184) + uint64_t(66048); // PTX L4185
	r_PackedE4WordAtPtx4186R1039 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4029Rs82, r_ConvertedE4PairAtPtx4032Rs83); // PTX L4186
	r_PackedE4WordAtPtx4187R1038 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4023Rs80, r_ConvertedE4PairAtPtx4026Rs81); // PTX L4187
	r_PackedE4WordAtPtx4188R1037 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4017Rs78, r_ConvertedE4PairAtPtx4020Rs79); // PTX L4188
	r_PackedE4WordAtPtx4189R1036 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4011Rs76, r_ConvertedE4PairAtPtx4014Rs77); // PTX L4189
	StoreNoAllocate(g_OutputByteAddressAtPtx4185,
					make_uint4(r_PackedE4WordAtPtx4189R1036, r_PackedE4WordAtPtx4188R1037,
							   r_PackedE4WordAtPtx4187R1038,
							   r_PackedE4WordAtPtx4186R1039));								 // PTX L4191
L__BB41_166:																				 // PTX L4193
	r_PtxRegister1040 = uint32_t(r_PtxRegister49) + uint32_t(2);							 // PTX L4194
	r_bPtxPredicate116 = int32_t(r_PtxRegister1040) >= int32_t(r_PtxRegister4);				 // PTX L4195
	g_OutputByteAddressAtPtx4196 = uint64_t(g_OutputByteAddressAtPtx4166) + uint64_t(65536); // PTX L4196
	if (r_bPtxPredicate116)
	{
		goto L__BB41_168;
	} // PTX L4197
	r_LaneIndexAtPtx4199 = uint32_t((threadIdx.x & 31u)); // PTX L4199
	r_PtxU64Register137 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4199)) * int64_t(int32_t(16))); // PTX L4201
	g_OutputByteAddressAtPtx4202 =
		uint64_t(g_OutputByteAddressAtPtx4196) + uint64_t(r_PtxU64Register137); // PTX L4202
	r_PackedE4WordAtPtx4203R1045 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4053Rs90, r_ConvertedE4PairAtPtx4056Rs91); // PTX L4203
	r_PackedE4WordAtPtx4204R1044 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4047Rs88, r_ConvertedE4PairAtPtx4050Rs89); // PTX L4204
	r_PackedE4WordAtPtx4205R1043 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4041Rs86, r_ConvertedE4PairAtPtx4044Rs87); // PTX L4205
	r_PackedE4WordAtPtx4206R1042 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4035Rs84, r_ConvertedE4PairAtPtx4038Rs85); // PTX L4206
	StoreNoAllocate(g_OutputByteAddressAtPtx4202,
					make_uint4(r_PackedE4WordAtPtx4206R1042, r_PackedE4WordAtPtx4205R1043,
							   r_PackedE4WordAtPtx4204R1044,
							   r_PackedE4WordAtPtx4203R1045)); // PTX L4208
	r_LaneIndexAtPtx4211 = uint32_t((threadIdx.x & 31u));	   // PTX L4211
	r_PtxU64Register138 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4211)) * int64_t(int32_t(16))); // PTX L4213
	g_OutputByteAddressAtPtx4214 =
		uint64_t(g_OutputByteAddressAtPtx4166) + uint64_t(r_PtxU64Register138);				 // PTX L4214
	g_OutputByteAddressAtPtx4215 = uint64_t(g_OutputByteAddressAtPtx4214) + uint64_t(66048); // PTX L4215
	r_PackedE4WordAtPtx4216R1050 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4077Rs98, r_ConvertedE4PairAtPtx4080Rs99); // PTX L4216
	r_PackedE4WordAtPtx4217R1049 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4071Rs96, r_ConvertedE4PairAtPtx4074Rs97); // PTX L4217
	r_PackedE4WordAtPtx4218R1048 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4065Rs94, r_ConvertedE4PairAtPtx4068Rs95); // PTX L4218
	r_PackedE4WordAtPtx4219R1047 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4059Rs92, r_ConvertedE4PairAtPtx4062Rs93); // PTX L4219
	StoreNoAllocate(g_OutputByteAddressAtPtx4215,
					make_uint4(r_PackedE4WordAtPtx4219R1047, r_PackedE4WordAtPtx4218R1048,
							   r_PackedE4WordAtPtx4217R1049,
							   r_PackedE4WordAtPtx4216R1050));					// PTX L4221
L__BB41_168:																	// PTX L4223
	r_PtxRegister1051 = uint32_t(r_PtxRegister49) + uint32_t(3);				// PTX L4224
	r_bPtxPredicate117 = int32_t(r_PtxRegister1051) >= int32_t(r_PtxRegister4); // PTX L4225
	if (r_bPtxPredicate117)
	{
		goto L__BB41_170;
	} // PTX L4226
	r_LaneIndexAtPtx4228 = uint32_t((threadIdx.x & 31u)); // PTX L4228
	r_PtxU64Register142 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4228)) * int64_t(int32_t(16))); // PTX L4230
	g_OutputByteAddressAtPtx4231 =
		uint64_t(g_OutputByteAddressAtPtx4196) + uint64_t(r_PtxU64Register142);				 // PTX L4231
	g_OutputByteAddressAtPtx4232 = uint64_t(g_OutputByteAddressAtPtx4231) + uint64_t(65536); // PTX L4232
	r_PackedE4WordAtPtx4233R1056 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4101Rs106, r_ConvertedE4PairAtPtx4104Rs107); // PTX L4233
	r_PackedE4WordAtPtx4234R1055 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4095Rs104, r_ConvertedE4PairAtPtx4098Rs105); // PTX L4234
	r_PackedE4WordAtPtx4235R1054 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4089Rs102, r_ConvertedE4PairAtPtx4092Rs103); // PTX L4235
	r_PackedE4WordAtPtx4236R1053 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4083Rs100, r_ConvertedE4PairAtPtx4086Rs101); // PTX L4236
	StoreNoAllocate(g_OutputByteAddressAtPtx4232,
					make_uint4(r_PackedE4WordAtPtx4236R1053, r_PackedE4WordAtPtx4235R1054,
							   r_PackedE4WordAtPtx4234R1055,
							   r_PackedE4WordAtPtx4233R1056)); // PTX L4238
	r_LaneIndexAtPtx4241 = uint32_t((threadIdx.x & 31u));	   // PTX L4241
	r_PtxU64Register144 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx4241)) * int64_t(int32_t(16))); // PTX L4243
	g_OutputByteAddressAtPtx4244 =
		uint64_t(g_OutputByteAddressAtPtx4196) + uint64_t(r_PtxU64Register144);				 // PTX L4244
	g_OutputByteAddressAtPtx4245 = uint64_t(g_OutputByteAddressAtPtx4244) + uint64_t(66048); // PTX L4245
	r_PackedE4WordAtPtx4246R1061 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4125Rs114, r_ConvertedE4PairAtPtx4128Rs115); // PTX L4246
	r_PackedE4WordAtPtx4247R1060 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4119Rs112, r_ConvertedE4PairAtPtx4122Rs113); // PTX L4247
	r_PackedE4WordAtPtx4248R1059 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4113Rs110, r_ConvertedE4PairAtPtx4116Rs111); // PTX L4248
	r_PackedE4WordAtPtx4249R1058 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4107Rs108, r_ConvertedE4PairAtPtx4110Rs109); // PTX L4249
	StoreNoAllocate(g_OutputByteAddressAtPtx4245,
					make_uint4(r_PackedE4WordAtPtx4249R1058, r_PackedE4WordAtPtx4248R1059,
							   r_PackedE4WordAtPtx4247R1060,
							   r_PackedE4WordAtPtx4246R1061)); // PTX L4251
L__BB41_170:												   // PTX L4253
	return;													   // PTX L4254
#endif
}
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8
