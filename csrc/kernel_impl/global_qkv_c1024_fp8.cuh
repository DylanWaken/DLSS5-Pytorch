// Readable CUDA C++ reconstruction of cc_vit_1d_qkv_fp8.
// Not historical source; original scalar/control identities are retained for audit.
#pragma once
#include "global_qkv_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::global_qkv_c1024_fp8
{
__global__ __maxnreg__(168) void global_qkv_c1024_fp8(Parameters r_Parameters)
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
		r_bPtxPredicate54, r_bPtxPredicate55, r_bPtxPredicate56, r_bPtxPredicate57, r_bPtxPredicate58,
		r_bPtxPredicate59, r_bPtxPredicate60;
	bool r_bPtxPredicate61, r_bPtxPredicate62, r_bPtxPredicate63, r_bPtxPredicate64, r_bPtxPredicate65,
		r_bPtxPredicate66, r_bPtxPredicate67, r_bPtxPredicate68;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx206Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx255Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx808Rs6, r_PtxU16Register7, r_ConvertedE4PairAtPtx854Rs8,
		r_ConvertedE4PairAtPtx3308Rs9, r_ConvertedE4PairAtPtx3311Rs10, r_ConvertedE4PairAtPtx3314Rs11,
		r_ConvertedE4PairAtPtx3317Rs12;
	uint16_t r_ConvertedE4PairAtPtx3320Rs13, r_ConvertedE4PairAtPtx3323Rs14, r_ConvertedE4PairAtPtx3326Rs15,
		r_ConvertedE4PairAtPtx3329Rs16, r_ConvertedE4PairAtPtx3332Rs17, r_ConvertedE4PairAtPtx3335Rs18,
		r_ConvertedE4PairAtPtx3338Rs19, r_ConvertedE4PairAtPtx3341Rs20, r_ConvertedE4PairAtPtx3344Rs21,
		r_ConvertedE4PairAtPtx3347Rs22, r_ConvertedE4PairAtPtx3350Rs23, r_ConvertedE4PairAtPtx3353Rs24;
	uint16_t r_ConvertedE4PairAtPtx3356Rs25, r_ConvertedE4PairAtPtx3359Rs26, r_ConvertedE4PairAtPtx3362Rs27,
		r_ConvertedE4PairAtPtx3365Rs28, r_ConvertedE4PairAtPtx3368Rs29, r_ConvertedE4PairAtPtx3371Rs30,
		r_ConvertedE4PairAtPtx3374Rs31, r_ConvertedE4PairAtPtx3377Rs32, r_ConvertedE4PairAtPtx3380Rs33,
		r_ConvertedE4PairAtPtx3383Rs34, r_ConvertedE4PairAtPtx3386Rs35, r_ConvertedE4PairAtPtx3389Rs36;
	uint16_t r_ConvertedE4PairAtPtx3392Rs37, r_ConvertedE4PairAtPtx3395Rs38, r_ConvertedE4PairAtPtx3398Rs39,
		r_ConvertedE4PairAtPtx3401Rs40, r_PtxU16Register41, r_PtxU16Register42, r_PtxU16Register43,
		r_PtxU16Register44, r_PtxU16Register45, r_PtxU16Register46, r_PtxU16Register47, r_PtxU16Register48;
	uint16_t r_PtxU16Register49, r_PtxU16Register50, r_PtxU16Register51, r_PtxU16Register52,
		r_PtxU16Register53, r_PtxU16Register54, r_PtxU16Register55, r_PtxU16Register56,
		r_ConvertedE4PairAtPtx4935Rs57, r_ConvertedE4PairAtPtx4938Rs58, r_ConvertedE4PairAtPtx4941Rs59,
		r_ConvertedE4PairAtPtx4944Rs60;
	uint16_t r_ConvertedE4PairAtPtx4947Rs61, r_ConvertedE4PairAtPtx4950Rs62, r_ConvertedE4PairAtPtx4953Rs63,
		r_ConvertedE4PairAtPtx4956Rs64, r_ConvertedE4PairAtPtx4959Rs65, r_ConvertedE4PairAtPtx4962Rs66,
		r_ConvertedE4PairAtPtx4965Rs67, r_ConvertedE4PairAtPtx4968Rs68, r_ConvertedE4PairAtPtx4971Rs69,
		r_ConvertedE4PairAtPtx4974Rs70, r_ConvertedE4PairAtPtx4977Rs71, r_ConvertedE4PairAtPtx4980Rs72;
	uint16_t r_ConvertedE4PairAtPtx4983Rs73, r_ConvertedE4PairAtPtx4986Rs74, r_ConvertedE4PairAtPtx4989Rs75,
		r_ConvertedE4PairAtPtx4992Rs76, r_ConvertedE4PairAtPtx4995Rs77, r_ConvertedE4PairAtPtx4998Rs78,
		r_ConvertedE4PairAtPtx5001Rs79, r_ConvertedE4PairAtPtx5004Rs80, r_ConvertedE4PairAtPtx5007Rs81,
		r_ConvertedE4PairAtPtx5010Rs82, r_ConvertedE4PairAtPtx5013Rs83, r_ConvertedE4PairAtPtx5016Rs84;
	uint16_t r_ConvertedE4PairAtPtx5019Rs85, r_ConvertedE4PairAtPtx5022Rs86, r_ConvertedE4PairAtPtx5025Rs87,
		r_ConvertedE4PairAtPtx5028Rs88, r_PtxU16Register89, r_PtxU16Register90, r_PtxU16Register91,
		r_PtxU16Register92, r_PtxU16Register93, r_PtxU16Register94, r_PtxU16Register95, r_PtxU16Register96;
	uint16_t r_PtxU16Register97, r_PtxU16Register98, r_PtxU16Register99, r_PtxU16Register100,
		r_PtxU16Register101, r_PtxU16Register102, r_PtxU16Register103, r_PtxU16Register104,
		r_ConvertedE4PairAtPtx5544Rs105, r_ConvertedE4PairAtPtx5547Rs106, r_ConvertedE4PairAtPtx5550Rs107,
		r_ConvertedE4PairAtPtx5553Rs108;
	uint16_t r_ConvertedE4PairAtPtx5556Rs109, r_ConvertedE4PairAtPtx5559Rs110,
		r_ConvertedE4PairAtPtx5562Rs111, r_ConvertedE4PairAtPtx5565Rs112, r_ConvertedE4PairAtPtx5568Rs113,
		r_ConvertedE4PairAtPtx5571Rs114, r_ConvertedE4PairAtPtx5574Rs115, r_ConvertedE4PairAtPtx5577Rs116,
		r_ConvertedE4PairAtPtx5580Rs117, r_ConvertedE4PairAtPtx5583Rs118, r_ConvertedE4PairAtPtx5586Rs119,
		r_ConvertedE4PairAtPtx5589Rs120;
	uint16_t r_ConvertedE4PairAtPtx5592Rs121, r_ConvertedE4PairAtPtx5595Rs122,
		r_ConvertedE4PairAtPtx5598Rs123, r_ConvertedE4PairAtPtx5601Rs124, r_ConvertedE4PairAtPtx5604Rs125,
		r_ConvertedE4PairAtPtx5607Rs126, r_ConvertedE4PairAtPtx5610Rs127, r_ConvertedE4PairAtPtx5613Rs128,
		r_ConvertedE4PairAtPtx5616Rs129, r_ConvertedE4PairAtPtx5619Rs130, r_ConvertedE4PairAtPtx5622Rs131,
		r_ConvertedE4PairAtPtx5625Rs132;
	uint16_t r_ConvertedE4PairAtPtx5628Rs133, r_ConvertedE4PairAtPtx5631Rs134,
		r_ConvertedE4PairAtPtx5634Rs135, r_ConvertedE4PairAtPtx5637Rs136;
	uint32_t r_CtaZ, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
		r_ThreadY, r_PtxRegister8, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_PtxRegister48;
	uint32_t r_PtxRegister49, r_BatchBits, r_TokensBits, r_PtxRegister52, r_PtxRegister53, r_PtxRegister54,
		r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_CtaX, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_ThreadX, r_PtxRegister66,
		r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_BlockSizeX, r_BlockSizeY,
		r_Float32BitsAtPtx64R72;
	uint32_t r_LaneIndexAtPtx82, r_LaneIndexAtPtx97, r_LaneIndexAtPtx112, r_LaneIndexAtPtx127,
		r_LaneIndexAtPtx142, r_LaneIndexAtPtx157, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81,
		r_PtxRegister82, r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PackedHalf2AtPtx204R104, r_LaneIndexAtPtx210, r_PtxRegister106,
		r_PackedE4WordAtPtx208R107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PackedHalf2AtPtx253R116, r_LaneIndexAtPtx259, r_PtxRegister118,
		r_PackedE4WordAtPtx257R119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_LaneIndexAtPtx396, r_PtxRegister134, r_LaneIndexAtPtx407, r_PtxRegister136,
		r_LaneIndexAtPtx416, r_PtxRegister138, r_LaneIndexAtPtx425, r_PtxRegister140,
		r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		r_MmaAE4x4WordAtPtx404R144;
	uint32_t r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		r_MmaAE4x4WordAtPtx413R148, r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150,
		r_MmaAE4x4WordAtPtx422R151, r_MmaAE4x4WordAtPtx422R152, r_MmaAE4x4WordAtPtx431R153,
		r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155, r_MmaAE4x4WordAtPtx431R156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PackedHalf2AtPtx806R176, r_LaneIndexAtPtx812, r_PtxRegister178,
		r_PackedE4WordAtPtx810R179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PackedHalf2AtPtx852R186, r_LaneIndexAtPtx858, r_PtxRegister188, r_PackedE4WordAtPtx856R189,
		r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_LaneIndexAtPtx874,
		r_LaneIndexAtPtx887, r_LaneIndexAtPtx900, r_LaneIndexAtPtx913, r_LaneIndexAtPtx926,
		r_LaneIndexAtPtx939, r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_LaneIndexAtPtx966, r_PtxRegister220, r_LaneIndexAtPtx977,
		r_PtxRegister222, r_LaneIndexAtPtx986, r_PtxRegister224, r_LaneIndexAtPtx995, r_PtxRegister226,
		r_MmaAccumulatorHalf2WordAtPtx1004R227, r_MmaAccumulatorHalf2WordAtPtx1004R228;
	uint32_t r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		r_MmaAE4x4WordAtPtx974R232, r_MmaAccumulatorHalf2WordAtPtx1011R233,
		r_MmaAccumulatorHalf2WordAtPtx1011R234, r_MmaAccumulatorHalf2WordAtPtx1018R235,
		r_MmaAccumulatorHalf2WordAtPtx1018R236, r_MmaAccumulatorHalf2WordAtPtx1025R237,
		r_MmaAccumulatorHalf2WordAtPtx1025R238, r_MmaAccumulatorHalf2WordAtPtx1032R239,
		r_MmaAccumulatorHalf2WordAtPtx1032R240;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1039R241, r_MmaAccumulatorHalf2WordAtPtx1039R242,
		r_MmaAccumulatorHalf2WordAtPtx1046R243, r_MmaAccumulatorHalf2WordAtPtx1046R244,
		r_MmaAccumulatorHalf2WordAtPtx1053R245, r_MmaAccumulatorHalf2WordAtPtx1053R246,
		r_MmaAccumulatorHalf2WordAtPtx1060R247, r_MmaAccumulatorHalf2WordAtPtx1060R248,
		r_MmaAccumulatorHalf2WordAtPtx1067R249, r_MmaAccumulatorHalf2WordAtPtx1067R250,
		r_MmaAccumulatorHalf2WordAtPtx1074R251, r_MmaAccumulatorHalf2WordAtPtx1074R252;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1081R253, r_MmaAccumulatorHalf2WordAtPtx1081R254,
		r_MmaAccumulatorHalf2WordAtPtx1088R255, r_MmaAccumulatorHalf2WordAtPtx1088R256,
		r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		r_MmaAE4x4WordAtPtx983R260, r_MmaAccumulatorHalf2WordAtPtx1095R261,
		r_MmaAccumulatorHalf2WordAtPtx1095R262, r_MmaAccumulatorHalf2WordAtPtx1102R263,
		r_MmaAccumulatorHalf2WordAtPtx1102R264;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1109R265, r_MmaAccumulatorHalf2WordAtPtx1109R266,
		r_MmaAccumulatorHalf2WordAtPtx1116R267, r_MmaAccumulatorHalf2WordAtPtx1116R268,
		r_MmaAccumulatorHalf2WordAtPtx1123R269, r_MmaAccumulatorHalf2WordAtPtx1123R270,
		r_MmaAccumulatorHalf2WordAtPtx1130R271, r_MmaAccumulatorHalf2WordAtPtx1130R272,
		r_MmaAccumulatorHalf2WordAtPtx1137R273, r_MmaAccumulatorHalf2WordAtPtx1137R274,
		r_MmaAccumulatorHalf2WordAtPtx1144R275, r_MmaAccumulatorHalf2WordAtPtx1144R276;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1151R277, r_MmaAccumulatorHalf2WordAtPtx1151R278,
		r_MmaAccumulatorHalf2WordAtPtx1158R279, r_MmaAccumulatorHalf2WordAtPtx1158R280,
		r_MmaAccumulatorHalf2WordAtPtx1165R281, r_MmaAccumulatorHalf2WordAtPtx1165R282,
		r_MmaAccumulatorHalf2WordAtPtx1172R283, r_MmaAccumulatorHalf2WordAtPtx1172R284,
		r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		r_MmaAE4x4WordAtPtx992R288;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1179R289, r_MmaAccumulatorHalf2WordAtPtx1179R290,
		r_MmaAccumulatorHalf2WordAtPtx1186R291, r_MmaAccumulatorHalf2WordAtPtx1186R292,
		r_MmaAccumulatorHalf2WordAtPtx1193R293, r_MmaAccumulatorHalf2WordAtPtx1193R294,
		r_MmaAccumulatorHalf2WordAtPtx1200R295, r_MmaAccumulatorHalf2WordAtPtx1200R296,
		r_MmaAccumulatorHalf2WordAtPtx1207R297, r_MmaAccumulatorHalf2WordAtPtx1207R298,
		r_MmaAccumulatorHalf2WordAtPtx1214R299, r_MmaAccumulatorHalf2WordAtPtx1214R300;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1221R301, r_MmaAccumulatorHalf2WordAtPtx1221R302,
		r_MmaAccumulatorHalf2WordAtPtx1228R303, r_MmaAccumulatorHalf2WordAtPtx1228R304,
		r_MmaAccumulatorHalf2WordAtPtx1235R305, r_MmaAccumulatorHalf2WordAtPtx1235R306,
		r_MmaAccumulatorHalf2WordAtPtx1242R307, r_MmaAccumulatorHalf2WordAtPtx1242R308,
		r_MmaAccumulatorHalf2WordAtPtx1249R309, r_MmaAccumulatorHalf2WordAtPtx1249R310,
		r_MmaAccumulatorHalf2WordAtPtx1256R311, r_MmaAccumulatorHalf2WordAtPtx1256R312;
	uint32_t r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		r_MmaAE4x4WordAtPtx1001R316, r_MmaAccumulatorHalf2WordAtPtx1263R317,
		r_MmaAccumulatorHalf2WordAtPtx1263R318, r_MmaAccumulatorHalf2WordAtPtx1270R319,
		r_MmaAccumulatorHalf2WordAtPtx1270R320, r_MmaAccumulatorHalf2WordAtPtx1277R321,
		r_MmaAccumulatorHalf2WordAtPtx1277R322, r_MmaAccumulatorHalf2WordAtPtx1284R323,
		r_MmaAccumulatorHalf2WordAtPtx1284R324;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1291R325, r_MmaAccumulatorHalf2WordAtPtx1291R326,
		r_MmaAccumulatorHalf2WordAtPtx1298R327, r_MmaAccumulatorHalf2WordAtPtx1298R328,
		r_MmaAccumulatorHalf2WordAtPtx1305R329, r_MmaAccumulatorHalf2WordAtPtx1305R330,
		r_MmaAccumulatorHalf2WordAtPtx1312R331, r_MmaAccumulatorHalf2WordAtPtx1312R332,
		r_MmaAccumulatorHalf2WordAtPtx1319R333, r_MmaAccumulatorHalf2WordAtPtx1319R334,
		r_MmaAccumulatorHalf2WordAtPtx1326R335, r_MmaAccumulatorHalf2WordAtPtx1326R336;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx1333R337, r_MmaAccumulatorHalf2WordAtPtx1333R338, r_PtxRegister339,
		r_PtxRegister340, r_PtxRegister341, r_PtxRegister342, r_PtxRegister343, r_PtxRegister344,
		r_PtxRegister345, r_PtxRegister346, r_PtxRegister347, r_PtxRegister348;
	uint32_t r_PtxRegister349, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_PtxRegister353,
		r_ThreadZAtPtx1356, r_PtxRegister355, r_PtxRegister356, r_PtxRegister357, r_PtxRegister358,
		r_PtxRegister359, r_PtxRegister360;
	uint32_t r_PtxRegister361, r_LaneIndexAtPtx1381, r_LaneIndexAtPtx1397, r_LaneIndexAtPtx1414,
		r_LaneIndexAtPtx1430, r_LaneIndexAtPtx1447, r_LaneIndexAtPtx1462, r_LaneIndexAtPtx1479,
		r_LaneIndexAtPtx1493, r_LaneIndexAtPtx1503, r_LaneIndexAtPtx1510, r_LaneIndexAtPtx1517;
	uint32_t r_LaneIndexAtPtx1524, r_LaneIndexAtPtx1531, r_LaneIndexAtPtx1538, r_LaneIndexAtPtx1545,
		r_LaneIndexAtPtx1552, r_LaneIndexAtPtx1559, r_LaneIndexAtPtx1566, r_LaneIndexAtPtx1573,
		r_LaneIndexAtPtx1580, r_LaneIndexAtPtx1587, r_LaneIndexAtPtx1594, r_LaneIndexAtPtx1601;
	uint32_t r_LaneIndexAtPtx1608, r_LaneIndexAtPtx1615, r_LaneIndexAtPtx1622, r_LaneIndexAtPtx1629,
		r_LaneIndexAtPtx1636, r_LaneIndexAtPtx1643, r_LaneIndexAtPtx1650, r_LaneIndexAtPtx1657,
		r_LaneIndexAtPtx1664, r_LaneIndexAtPtx1671, r_LaneIndexAtPtx1678, r_LaneIndexAtPtx1685;
	uint32_t r_LaneIndexAtPtx1692, r_LaneIndexAtPtx1699, r_LaneIndexAtPtx1706, r_LaneIndexAtPtx1713,
		r_LaneIndexAtPtx1720, r_LaneIndexAtPtx1727, r_PackedHalf2AtPtx1506R403, r_LaneIndexAtPtx1734,
		r_PackedHalf2AtPtx1513R405, r_LaneIndexAtPtx1741, r_PackedHalf2AtPtx1520R407, r_LaneIndexAtPtx1748;
	uint32_t r_PackedHalf2AtPtx1527R409, r_LaneIndexAtPtx1755, r_PackedHalf2AtPtx1534R411,
		r_LaneIndexAtPtx1762, r_PackedHalf2AtPtx1541R413, r_LaneIndexAtPtx1769, r_PackedHalf2AtPtx1548R415,
		r_LaneIndexAtPtx1776, r_PackedHalf2AtPtx1555R417, r_LaneIndexAtPtx1783, r_PackedHalf2AtPtx1562R419,
		r_LaneIndexAtPtx1790;
	uint32_t r_PackedHalf2AtPtx1569R421, r_LaneIndexAtPtx1797, r_PackedHalf2AtPtx1576R423,
		r_LaneIndexAtPtx1804, r_PackedHalf2AtPtx1583R425, r_LaneIndexAtPtx1811, r_PackedHalf2AtPtx1590R427,
		r_LaneIndexAtPtx1818, r_PackedHalf2AtPtx1597R429, r_LaneIndexAtPtx1825, r_PackedHalf2AtPtx1604R431,
		r_LaneIndexAtPtx1832;
	uint32_t r_PackedHalf2AtPtx1611R433, r_LaneIndexAtPtx1839, r_PackedHalf2AtPtx1618R435,
		r_LaneIndexAtPtx1846, r_PackedHalf2AtPtx1625R437, r_LaneIndexAtPtx1853, r_PackedHalf2AtPtx1632R439,
		r_LaneIndexAtPtx1860, r_PackedHalf2AtPtx1639R441, r_LaneIndexAtPtx1867, r_PackedHalf2AtPtx1646R443,
		r_LaneIndexAtPtx1874;
	uint32_t r_PackedHalf2AtPtx1653R445, r_LaneIndexAtPtx1881, r_PackedHalf2AtPtx1660R447,
		r_LaneIndexAtPtx1888, r_PackedHalf2AtPtx1667R449, r_LaneIndexAtPtx1895, r_PackedHalf2AtPtx1674R451,
		r_LaneIndexAtPtx1902, r_PackedHalf2AtPtx1681R453, r_LaneIndexAtPtx1909, r_PackedHalf2AtPtx1688R455,
		r_LaneIndexAtPtx1916;
	uint32_t r_PackedHalf2AtPtx1695R457, r_LaneIndexAtPtx1923, r_PackedHalf2AtPtx1702R459,
		r_LaneIndexAtPtx1930, r_PackedHalf2AtPtx1709R461, r_LaneIndexAtPtx1937, r_PackedHalf2AtPtx1716R463,
		r_LaneIndexAtPtx1944, r_PackedHalf2AtPtx1723R465, r_LaneIndexAtPtx1951, r_PackedHalf2AtPtx1730R467,
		r_PackedHalf2AtPtx1758R468;
	uint32_t r_LaneIndexAtPtx1958, r_PackedHalf2AtPtx1737R470, r_PackedHalf2AtPtx1765R471,
		r_LaneIndexAtPtx1965, r_PackedHalf2AtPtx1744R473, r_PackedHalf2AtPtx1772R474, r_LaneIndexAtPtx1972,
		r_PackedHalf2AtPtx1751R476, r_PackedHalf2AtPtx1779R477, r_LaneIndexAtPtx1979,
		r_PackedHalf2AtPtx1786R479, r_PackedHalf2AtPtx1814R480;
	uint32_t r_LaneIndexAtPtx1986, r_PackedHalf2AtPtx1793R482, r_PackedHalf2AtPtx1821R483,
		r_LaneIndexAtPtx1993, r_PackedHalf2AtPtx1800R485, r_PackedHalf2AtPtx1828R486, r_LaneIndexAtPtx2000,
		r_PackedHalf2AtPtx1807R488, r_PackedHalf2AtPtx1835R489, r_LaneIndexAtPtx2007,
		r_PackedHalf2AtPtx1842R491, r_PackedHalf2AtPtx1870R492;
	uint32_t r_LaneIndexAtPtx2014, r_PackedHalf2AtPtx1849R494, r_PackedHalf2AtPtx1877R495,
		r_LaneIndexAtPtx2021, r_PackedHalf2AtPtx1856R497, r_PackedHalf2AtPtx1884R498, r_LaneIndexAtPtx2028,
		r_PackedHalf2AtPtx1863R500, r_PackedHalf2AtPtx1891R501, r_LaneIndexAtPtx2035,
		r_PackedHalf2AtPtx1898R503, r_PackedHalf2AtPtx1926R504;
	uint32_t r_LaneIndexAtPtx2042, r_PackedHalf2AtPtx1905R506, r_PackedHalf2AtPtx1933R507,
		r_LaneIndexAtPtx2049, r_PackedHalf2AtPtx1912R509, r_PackedHalf2AtPtx1940R510, r_LaneIndexAtPtx2056,
		r_PackedHalf2AtPtx1919R512, r_PackedHalf2AtPtx1947R513, r_PackedHalf2AtPtx1968R514,
		r_PackedHalf2AtPtx1954R515, r_PackedHalf2AtPtx1975R516;
	uint32_t r_PackedHalf2AtPtx1961R517, r_PtxRegister518, r_PackedHalf2AtPtx2063R519, r_PtxRegister520,
		r_PtxRegister521, r_PackedHalf2AtPtx2079R522, r_PackedHalf2AtPtx2083R523, r_PtxRegister524,
		r_PackedHalf2AtPtx2088R525, r_PtxRegister526, r_PackedHalf2AtPtx2096R527, r_PackedHalf2AtPtx2067R528;
	uint32_t r_PackedHalf2AtPtx2102R529, r_PackedHalf2AtPtx2106R530, r_PackedHalf2AtPtx2110R531,
		r_PtxRegister532, r_PackedHalf2AtPtx2118R533, r_PackedHalf2AtPtx1996R534, r_PackedHalf2AtPtx1982R535,
		r_PackedHalf2AtPtx2003R536, r_PackedHalf2AtPtx1989R537, r_PackedHalf2AtPtx2124R538,
		r_PackedHalf2AtPtx2132R539, r_PackedHalf2AtPtx2136R540;
	uint32_t r_PackedHalf2AtPtx2140R541, r_PtxRegister542, r_PackedHalf2AtPtx2148R543,
		r_PackedHalf2AtPtx2128R544, r_PackedHalf2AtPtx2154R545, r_PackedHalf2AtPtx2158R546,
		r_PackedHalf2AtPtx2162R547, r_PtxRegister548, r_PackedHalf2AtPtx2170R549, r_PackedHalf2AtPtx2024R550,
		r_PackedHalf2AtPtx2010R551, r_PackedHalf2AtPtx2031R552;
	uint32_t r_PackedHalf2AtPtx2017R553, r_PackedHalf2AtPtx2176R554, r_PackedHalf2AtPtx2184R555,
		r_PackedHalf2AtPtx2188R556, r_PackedHalf2AtPtx2192R557, r_PtxRegister558, r_PackedHalf2AtPtx2200R559,
		r_PackedHalf2AtPtx2180R560, r_PackedHalf2AtPtx2206R561, r_PackedHalf2AtPtx2210R562,
		r_PackedHalf2AtPtx2214R563, r_PtxRegister564;
	uint32_t r_PackedHalf2AtPtx2222R565, r_PackedHalf2AtPtx2052R566, r_PackedHalf2AtPtx2038R567,
		r_PackedHalf2AtPtx2059R568, r_PackedHalf2AtPtx2045R569, r_PackedHalf2AtPtx2228R570,
		r_PackedHalf2AtPtx2236R571, r_PackedHalf2AtPtx2240R572, r_PackedHalf2AtPtx2244R573, r_PtxRegister574,
		r_PackedHalf2AtPtx2252R575, r_PackedHalf2AtPtx2232R576;
	uint32_t r_PackedHalf2AtPtx2258R577, r_PackedHalf2AtPtx2262R578, r_PackedHalf2AtPtx2266R579,
		r_PtxRegister580, r_PackedHalf2AtPtx2274R581, r_Float32BitsAtPtx2279R582, r_LaneIndexAtPtx2287,
		r_PackedHalf2AtPtx2098R584, r_LaneIndexAtPtx2294, r_PackedHalf2AtPtx2120R586, r_LaneIndexAtPtx2301,
		r_LaneIndexAtPtx2304;
	uint32_t r_LaneIndexAtPtx2307, r_LaneIndexAtPtx2310, r_LaneIndexAtPtx2313, r_LaneIndexAtPtx2316,
		r_LaneIndexAtPtx2319, r_PackedHalf2AtPtx2150R594, r_LaneIndexAtPtx2326, r_PackedHalf2AtPtx2172R596,
		r_LaneIndexAtPtx2333, r_LaneIndexAtPtx2336, r_LaneIndexAtPtx2339, r_LaneIndexAtPtx2342;
	uint32_t r_LaneIndexAtPtx2345, r_LaneIndexAtPtx2348, r_LaneIndexAtPtx2351, r_PackedHalf2AtPtx2202R604,
		r_LaneIndexAtPtx2358, r_PackedHalf2AtPtx2224R606, r_LaneIndexAtPtx2365, r_LaneIndexAtPtx2368,
		r_LaneIndexAtPtx2371, r_LaneIndexAtPtx2374, r_LaneIndexAtPtx2377, r_LaneIndexAtPtx2380;
	uint32_t r_LaneIndexAtPtx2383, r_PackedHalf2AtPtx2254R614, r_LaneIndexAtPtx2390,
		r_PackedHalf2AtPtx2276R616, r_LaneIndexAtPtx2397, r_LaneIndexAtPtx2400, r_LaneIndexAtPtx2403,
		r_LaneIndexAtPtx2406, r_LaneIndexAtPtx2409, r_LaneIndexAtPtx2412, r_LaneIndexAtPtx2415,
		r_PackedHalf2AtPtx2290R624;
	uint32_t r_LaneIndexAtPtx2431, r_PackedHalf2AtPtx2297R626, r_LaneIndexAtPtx2447, r_LaneIndexAtPtx2450,
		r_LaneIndexAtPtx2453, r_LaneIndexAtPtx2456, r_LaneIndexAtPtx2459, r_LaneIndexAtPtx2462,
		r_LaneIndexAtPtx2465, r_PackedHalf2AtPtx2322R634, r_LaneIndexAtPtx2481, r_PackedHalf2AtPtx2329R636;
	uint32_t r_LaneIndexAtPtx2497, r_LaneIndexAtPtx2500, r_LaneIndexAtPtx2503, r_LaneIndexAtPtx2506,
		r_LaneIndexAtPtx2509, r_LaneIndexAtPtx2512, r_LaneIndexAtPtx2515, r_PackedHalf2AtPtx2354R644,
		r_LaneIndexAtPtx2531, r_PackedHalf2AtPtx2361R646, r_LaneIndexAtPtx2547, r_LaneIndexAtPtx2550;
	uint32_t r_LaneIndexAtPtx2553, r_LaneIndexAtPtx2556, r_LaneIndexAtPtx2559, r_LaneIndexAtPtx2562,
		r_LaneIndexAtPtx2565, r_PackedHalf2AtPtx2386R654, r_LaneIndexAtPtx2581, r_PackedHalf2AtPtx2393R656,
		r_LaneIndexAtPtx2597, r_LaneIndexAtPtx2600, r_LaneIndexAtPtx2603, r_LaneIndexAtPtx2606;
	uint32_t r_LaneIndexAtPtx2609, r_LaneIndexAtPtx2612, r_LaneIndexAtPtx2615, r_PackedHalf2AtPtx2418R664,
		r_LaneIndexAtPtx2622, r_PackedHalf2AtPtx2434R666, r_LaneIndexAtPtx2629, r_LaneIndexAtPtx2636,
		r_LaneIndexAtPtx2643, r_LaneIndexAtPtx2650, r_LaneIndexAtPtx2657, r_LaneIndexAtPtx2664;
	uint32_t r_LaneIndexAtPtx2671, r_PackedHalf2AtPtx2468R674, r_LaneIndexAtPtx2678,
		r_PackedHalf2AtPtx2484R676, r_LaneIndexAtPtx2685, r_LaneIndexAtPtx2692, r_LaneIndexAtPtx2699,
		r_LaneIndexAtPtx2706, r_LaneIndexAtPtx2713, r_LaneIndexAtPtx2720, r_LaneIndexAtPtx2727,
		r_PackedHalf2AtPtx2518R684;
	uint32_t r_LaneIndexAtPtx2734, r_PackedHalf2AtPtx2534R686, r_LaneIndexAtPtx2741, r_LaneIndexAtPtx2748,
		r_LaneIndexAtPtx2755, r_LaneIndexAtPtx2762, r_LaneIndexAtPtx2769, r_LaneIndexAtPtx2776,
		r_LaneIndexAtPtx2783, r_PackedHalf2AtPtx2568R694, r_LaneIndexAtPtx2790, r_PackedHalf2AtPtx2584R696;
	uint32_t r_LaneIndexAtPtx2797, r_LaneIndexAtPtx2804, r_LaneIndexAtPtx2811, r_LaneIndexAtPtx2818,
		r_LaneIndexAtPtx2825, r_LaneIndexAtPtx2832, r_PtxRegister703, r_LaneIndexAtPtx2847,
		r_PackedHalf2AtPtx2618R705, r_PackedHalf2AtPtx2841R706, r_LaneIndexAtPtx2854,
		r_PackedHalf2AtPtx2625R708;
	uint32_t r_LaneIndexAtPtx2861, r_PackedHalf2AtPtx2632R710, r_LaneIndexAtPtx2868,
		r_PackedHalf2AtPtx2639R712, r_LaneIndexAtPtx2875, r_PackedHalf2AtPtx2646R714, r_LaneIndexAtPtx2882,
		r_PackedHalf2AtPtx2653R716, r_LaneIndexAtPtx2889, r_PackedHalf2AtPtx2660R718, r_LaneIndexAtPtx2896,
		r_PackedHalf2AtPtx2667R720;
	uint32_t r_LaneIndexAtPtx2903, r_PackedHalf2AtPtx2674R722, r_LaneIndexAtPtx2910,
		r_PackedHalf2AtPtx2681R724, r_LaneIndexAtPtx2917, r_PackedHalf2AtPtx2688R726, r_LaneIndexAtPtx2924,
		r_PackedHalf2AtPtx2695R728, r_LaneIndexAtPtx2931, r_PackedHalf2AtPtx2702R730, r_LaneIndexAtPtx2938,
		r_PackedHalf2AtPtx2709R732;
	uint32_t r_LaneIndexAtPtx2945, r_PackedHalf2AtPtx2716R734, r_LaneIndexAtPtx2952,
		r_PackedHalf2AtPtx2723R736, r_LaneIndexAtPtx2959, r_PackedHalf2AtPtx2730R738, r_LaneIndexAtPtx2966,
		r_PackedHalf2AtPtx2737R740, r_LaneIndexAtPtx2973, r_PackedHalf2AtPtx2744R742, r_LaneIndexAtPtx2980,
		r_PackedHalf2AtPtx2751R744;
	uint32_t r_LaneIndexAtPtx2987, r_PackedHalf2AtPtx2758R746, r_LaneIndexAtPtx2994,
		r_PackedHalf2AtPtx2765R748, r_LaneIndexAtPtx3001, r_PackedHalf2AtPtx2772R750, r_LaneIndexAtPtx3008,
		r_PackedHalf2AtPtx2779R752, r_LaneIndexAtPtx3015, r_PackedHalf2AtPtx2786R754, r_LaneIndexAtPtx3022,
		r_PackedHalf2AtPtx2793R756;
	uint32_t r_LaneIndexAtPtx3029, r_PackedHalf2AtPtx2800R758, r_LaneIndexAtPtx3036,
		r_PackedHalf2AtPtx2807R760, r_LaneIndexAtPtx3043, r_PackedHalf2AtPtx2814R762, r_LaneIndexAtPtx3050,
		r_PackedHalf2AtPtx2821R764, r_LaneIndexAtPtx3057, r_PackedHalf2AtPtx2828R766, r_LaneIndexAtPtx3064,
		r_PackedHalf2AtPtx2835R768;
	uint32_t r_PtxRegister769, r_LaneIndexAtPtx3084, r_PackedHalf2AtPtx2850R771, r_PackedHalf2AtPtx3078R772,
		r_LaneIndexAtPtx3091, r_PackedHalf2AtPtx2857R774, r_LaneIndexAtPtx3098, r_PackedHalf2AtPtx2864R776,
		r_LaneIndexAtPtx3105, r_PackedHalf2AtPtx2871R778, r_LaneIndexAtPtx3112, r_PackedHalf2AtPtx2878R780;
	uint32_t r_LaneIndexAtPtx3119, r_PackedHalf2AtPtx2885R782, r_LaneIndexAtPtx3126,
		r_PackedHalf2AtPtx2892R784, r_LaneIndexAtPtx3133, r_PackedHalf2AtPtx2899R786, r_LaneIndexAtPtx3140,
		r_PackedHalf2AtPtx2906R788, r_LaneIndexAtPtx3147, r_PackedHalf2AtPtx2913R790, r_LaneIndexAtPtx3154,
		r_PackedHalf2AtPtx2920R792;
	uint32_t r_LaneIndexAtPtx3161, r_PackedHalf2AtPtx2927R794, r_LaneIndexAtPtx3168,
		r_PackedHalf2AtPtx2934R796, r_LaneIndexAtPtx3175, r_PackedHalf2AtPtx2941R798, r_LaneIndexAtPtx3182,
		r_PackedHalf2AtPtx2948R800, r_LaneIndexAtPtx3189, r_PackedHalf2AtPtx2955R802, r_LaneIndexAtPtx3196,
		r_PackedHalf2AtPtx2962R804;
	uint32_t r_LaneIndexAtPtx3203, r_PackedHalf2AtPtx2969R806, r_LaneIndexAtPtx3210,
		r_PackedHalf2AtPtx2976R808, r_LaneIndexAtPtx3217, r_PackedHalf2AtPtx2983R810, r_LaneIndexAtPtx3224,
		r_PackedHalf2AtPtx2990R812, r_LaneIndexAtPtx3231, r_PackedHalf2AtPtx2997R814, r_LaneIndexAtPtx3238,
		r_PackedHalf2AtPtx3004R816;
	uint32_t r_LaneIndexAtPtx3245, r_PackedHalf2AtPtx3011R818, r_LaneIndexAtPtx3252,
		r_PackedHalf2AtPtx3018R820, r_LaneIndexAtPtx3259, r_PackedHalf2AtPtx3025R822, r_LaneIndexAtPtx3266,
		r_PackedHalf2AtPtx3032R824, r_LaneIndexAtPtx3273, r_PackedHalf2AtPtx3039R826, r_LaneIndexAtPtx3280,
		r_PackedHalf2AtPtx3046R828;
	uint32_t r_LaneIndexAtPtx3287, r_PackedHalf2AtPtx3053R830, r_LaneIndexAtPtx3294,
		r_PackedHalf2AtPtx3060R832, r_LaneIndexAtPtx3301, r_PackedHalf2AtPtx3067R834,
		r_PackedHalf2AtPtx3087R835, r_PackedHalf2AtPtx3101R836, r_PackedHalf2AtPtx3094R837,
		r_PackedHalf2AtPtx3108R838, r_PackedHalf2AtPtx3115R839, r_PackedHalf2AtPtx3129R840;
	uint32_t r_PackedHalf2AtPtx3122R841, r_PackedHalf2AtPtx3136R842, r_PackedHalf2AtPtx3143R843,
		r_PackedHalf2AtPtx3157R844, r_PackedHalf2AtPtx3150R845, r_PackedHalf2AtPtx3164R846,
		r_PackedHalf2AtPtx3171R847, r_PackedHalf2AtPtx3185R848, r_PackedHalf2AtPtx3178R849,
		r_PackedHalf2AtPtx3192R850, r_PackedHalf2AtPtx3199R851, r_PackedHalf2AtPtx3213R852;
	uint32_t r_PackedHalf2AtPtx3206R853, r_PackedHalf2AtPtx3220R854, r_PackedHalf2AtPtx3227R855,
		r_PackedHalf2AtPtx3241R856, r_PackedHalf2AtPtx3234R857, r_PackedHalf2AtPtx3248R858,
		r_PackedHalf2AtPtx3255R859, r_PackedHalf2AtPtx3269R860, r_PackedHalf2AtPtx3262R861,
		r_PackedHalf2AtPtx3276R862, r_PackedHalf2AtPtx3283R863, r_PackedHalf2AtPtx3297R864;
	uint32_t r_PackedHalf2AtPtx3290R865, r_PackedHalf2AtPtx3304R866, r_PtxRegister867, r_PtxRegister868,
		r_PtxRegister869, r_PtxRegister870, r_PtxRegister871, r_PtxRegister872, r_PtxRegister873,
		r_PtxRegister874, r_PtxRegister875, r_LaneIndexAtPtx3418;
	uint32_t r_PackedE4WordAtPtx3416R877, r_PackedE4WordAtPtx3415R878, r_PackedE4WordAtPtx3414R879,
		r_PackedE4WordAtPtx3413R880, r_LaneIndexAtPtx3430, r_PackedE4WordAtPtx3438R882,
		r_PackedE4WordAtPtx3437R883, r_PackedE4WordAtPtx3436R884, r_PackedE4WordAtPtx3435R885,
		r_LaneIndexAtPtx3447, r_PackedE4WordAtPtx3455R887, r_PackedE4WordAtPtx3454R888;
	uint32_t r_PackedE4WordAtPtx3453R889, r_PackedE4WordAtPtx3452R890, r_LaneIndexAtPtx3464,
		r_PackedE4WordAtPtx3472R892, r_PackedE4WordAtPtx3471R893, r_PackedE4WordAtPtx3470R894,
		r_PackedE4WordAtPtx3469R895, r_PtxRegister896, r_PtxRegister897, r_LaneIndexAtPtx3490,
		r_LaneIndexAtPtx3506, r_LaneIndexAtPtx3522;
	uint32_t r_LaneIndexAtPtx3538, r_LaneIndexAtPtx3554, r_LaneIndexAtPtx3570, r_LaneIndexAtPtx3586,
		r_LaneIndexAtPtx3601, r_LaneIndexAtPtx3612, r_LaneIndexAtPtx3619, r_LaneIndexAtPtx3626,
		r_LaneIndexAtPtx3633, r_LaneIndexAtPtx3640, r_LaneIndexAtPtx3647, r_LaneIndexAtPtx3654;
	uint32_t r_LaneIndexAtPtx3661, r_LaneIndexAtPtx3668, r_LaneIndexAtPtx3675, r_LaneIndexAtPtx3682,
		r_LaneIndexAtPtx3689, r_LaneIndexAtPtx3696, r_LaneIndexAtPtx3703, r_LaneIndexAtPtx3710,
		r_LaneIndexAtPtx3717, r_LaneIndexAtPtx3724, r_LaneIndexAtPtx3731, r_LaneIndexAtPtx3738;
	uint32_t r_LaneIndexAtPtx3745, r_LaneIndexAtPtx3752, r_LaneIndexAtPtx3759, r_LaneIndexAtPtx3766,
		r_LaneIndexAtPtx3773, r_LaneIndexAtPtx3780, r_LaneIndexAtPtx3787, r_LaneIndexAtPtx3794,
		r_LaneIndexAtPtx3801, r_LaneIndexAtPtx3808, r_LaneIndexAtPtx3815, r_LaneIndexAtPtx3822;
	uint32_t r_LaneIndexAtPtx3829, r_LaneIndexAtPtx3836, r_PackedHalf2AtPtx3615R939, r_LaneIndexAtPtx3843,
		r_PackedHalf2AtPtx3622R941, r_LaneIndexAtPtx3850, r_PackedHalf2AtPtx3629R943, r_LaneIndexAtPtx3857,
		r_PackedHalf2AtPtx3636R945, r_LaneIndexAtPtx3864, r_PackedHalf2AtPtx3643R947, r_LaneIndexAtPtx3871;
	uint32_t r_PackedHalf2AtPtx3650R949, r_LaneIndexAtPtx3878, r_PackedHalf2AtPtx3657R951,
		r_LaneIndexAtPtx3885, r_PackedHalf2AtPtx3664R953, r_LaneIndexAtPtx3892, r_PackedHalf2AtPtx3671R955,
		r_LaneIndexAtPtx3899, r_PackedHalf2AtPtx3678R957, r_LaneIndexAtPtx3906, r_PackedHalf2AtPtx3685R959,
		r_LaneIndexAtPtx3913;
	uint32_t r_PackedHalf2AtPtx3692R961, r_LaneIndexAtPtx3920, r_PackedHalf2AtPtx3699R963,
		r_LaneIndexAtPtx3927, r_PackedHalf2AtPtx3706R965, r_LaneIndexAtPtx3934, r_PackedHalf2AtPtx3713R967,
		r_LaneIndexAtPtx3941, r_PackedHalf2AtPtx3720R969, r_LaneIndexAtPtx3948, r_PackedHalf2AtPtx3727R971,
		r_LaneIndexAtPtx3955;
	uint32_t r_PackedHalf2AtPtx3734R973, r_LaneIndexAtPtx3962, r_PackedHalf2AtPtx3741R975,
		r_LaneIndexAtPtx3969, r_PackedHalf2AtPtx3748R977, r_LaneIndexAtPtx3976, r_PackedHalf2AtPtx3755R979,
		r_LaneIndexAtPtx3983, r_PackedHalf2AtPtx3762R981, r_LaneIndexAtPtx3990, r_PackedHalf2AtPtx3769R983,
		r_LaneIndexAtPtx3997;
	uint32_t r_PackedHalf2AtPtx3776R985, r_LaneIndexAtPtx4004, r_PackedHalf2AtPtx3783R987,
		r_LaneIndexAtPtx4011, r_PackedHalf2AtPtx3790R989, r_LaneIndexAtPtx4018, r_PackedHalf2AtPtx3797R991,
		r_LaneIndexAtPtx4025, r_PackedHalf2AtPtx3804R993, r_LaneIndexAtPtx4032, r_PackedHalf2AtPtx3811R995,
		r_LaneIndexAtPtx4039;
	uint32_t r_PackedHalf2AtPtx3818R997, r_LaneIndexAtPtx4046, r_PackedHalf2AtPtx3825R999,
		r_LaneIndexAtPtx4053, r_PackedHalf2AtPtx3832R1001, r_LaneIndexAtPtx4060, r_PackedHalf2AtPtx3839R1003,
		r_PackedHalf2AtPtx3867R1004, r_LaneIndexAtPtx4067, r_PackedHalf2AtPtx3846R1006,
		r_PackedHalf2AtPtx3874R1007, r_LaneIndexAtPtx4074;
	uint32_t r_PackedHalf2AtPtx3853R1009, r_PackedHalf2AtPtx3881R1010, r_LaneIndexAtPtx4081,
		r_PackedHalf2AtPtx3860R1012, r_PackedHalf2AtPtx3888R1013, r_LaneIndexAtPtx4088,
		r_PackedHalf2AtPtx3895R1015, r_PackedHalf2AtPtx3923R1016, r_LaneIndexAtPtx4095,
		r_PackedHalf2AtPtx3902R1018, r_PackedHalf2AtPtx3930R1019, r_LaneIndexAtPtx4102;
	uint32_t r_PackedHalf2AtPtx3909R1021, r_PackedHalf2AtPtx3937R1022, r_LaneIndexAtPtx4109,
		r_PackedHalf2AtPtx3916R1024, r_PackedHalf2AtPtx3944R1025, r_LaneIndexAtPtx4116,
		r_PackedHalf2AtPtx3951R1027, r_PackedHalf2AtPtx3979R1028, r_LaneIndexAtPtx4123,
		r_PackedHalf2AtPtx3958R1030, r_PackedHalf2AtPtx3986R1031, r_LaneIndexAtPtx4130;
	uint32_t r_PackedHalf2AtPtx3965R1033, r_PackedHalf2AtPtx3993R1034, r_LaneIndexAtPtx4137,
		r_PackedHalf2AtPtx3972R1036, r_PackedHalf2AtPtx4000R1037, r_LaneIndexAtPtx4144,
		r_PackedHalf2AtPtx4007R1039, r_PackedHalf2AtPtx4035R1040, r_LaneIndexAtPtx4151,
		r_PackedHalf2AtPtx4014R1042, r_PackedHalf2AtPtx4042R1043, r_LaneIndexAtPtx4158;
	uint32_t r_PackedHalf2AtPtx4021R1045, r_PackedHalf2AtPtx4049R1046, r_LaneIndexAtPtx4165,
		r_PackedHalf2AtPtx4028R1048, r_PackedHalf2AtPtx4056R1049, r_PackedHalf2AtPtx4077R1050,
		r_PackedHalf2AtPtx4063R1051, r_PackedHalf2AtPtx4084R1052, r_PackedHalf2AtPtx4070R1053,
		r_PackedHalf2AtPtx4172R1054, r_PtxRegister1055, r_PtxRegister1056;
	uint32_t r_PackedHalf2AtPtx4182R1057, r_PackedHalf2AtPtx4186R1058, r_PtxRegister1059,
		r_PackedHalf2AtPtx4191R1060, r_PtxRegister1061, r_PackedHalf2AtPtx4199R1062,
		r_PackedHalf2AtPtx4176R1063, r_PackedHalf2AtPtx4205R1064, r_PackedHalf2AtPtx4209R1065,
		r_PackedHalf2AtPtx4213R1066, r_PtxRegister1067, r_PackedHalf2AtPtx4221R1068;
	uint32_t r_PackedHalf2AtPtx4105R1069, r_PackedHalf2AtPtx4091R1070, r_PackedHalf2AtPtx4112R1071,
		r_PackedHalf2AtPtx4098R1072, r_PackedHalf2AtPtx4227R1073, r_PackedHalf2AtPtx4235R1074,
		r_PackedHalf2AtPtx4239R1075, r_PackedHalf2AtPtx4243R1076, r_PtxRegister1077,
		r_PackedHalf2AtPtx4251R1078, r_PackedHalf2AtPtx4231R1079, r_PackedHalf2AtPtx4257R1080;
	uint32_t r_PackedHalf2AtPtx4261R1081, r_PackedHalf2AtPtx4265R1082, r_PtxRegister1083,
		r_PackedHalf2AtPtx4273R1084, r_PackedHalf2AtPtx4133R1085, r_PackedHalf2AtPtx4119R1086,
		r_PackedHalf2AtPtx4140R1087, r_PackedHalf2AtPtx4126R1088, r_PackedHalf2AtPtx4279R1089,
		r_PackedHalf2AtPtx4287R1090, r_PackedHalf2AtPtx4291R1091, r_PackedHalf2AtPtx4295R1092;
	uint32_t r_PtxRegister1093, r_PackedHalf2AtPtx4303R1094, r_PackedHalf2AtPtx4283R1095,
		r_PackedHalf2AtPtx4309R1096, r_PackedHalf2AtPtx4313R1097, r_PackedHalf2AtPtx4317R1098,
		r_PtxRegister1099, r_PackedHalf2AtPtx4325R1100, r_PackedHalf2AtPtx4161R1101,
		r_PackedHalf2AtPtx4147R1102, r_PackedHalf2AtPtx4168R1103, r_PackedHalf2AtPtx4154R1104;
	uint32_t r_PackedHalf2AtPtx4331R1105, r_PackedHalf2AtPtx4339R1106, r_PackedHalf2AtPtx4343R1107,
		r_PackedHalf2AtPtx4347R1108, r_PtxRegister1109, r_PackedHalf2AtPtx4355R1110,
		r_PackedHalf2AtPtx4335R1111, r_PackedHalf2AtPtx4361R1112, r_PackedHalf2AtPtx4365R1113,
		r_PtxRegister1114, r_PackedHalf2AtPtx4369R1115, r_PtxRegister1116;
	uint32_t r_PackedHalf2AtPtx4377R1117, r_LaneIndexAtPtx4383, r_PackedHalf2AtPtx4201R1119,
		r_LaneIndexAtPtx4390, r_PackedHalf2AtPtx4223R1121, r_LaneIndexAtPtx4397, r_LaneIndexAtPtx4400,
		r_LaneIndexAtPtx4403, r_LaneIndexAtPtx4406, r_LaneIndexAtPtx4409, r_LaneIndexAtPtx4412,
		r_LaneIndexAtPtx4415;
	uint32_t r_PackedHalf2AtPtx4253R1129, r_LaneIndexAtPtx4422, r_PackedHalf2AtPtx4275R1131,
		r_LaneIndexAtPtx4429, r_LaneIndexAtPtx4432, r_LaneIndexAtPtx4435, r_LaneIndexAtPtx4438,
		r_LaneIndexAtPtx4441, r_LaneIndexAtPtx4444, r_LaneIndexAtPtx4447, r_PackedHalf2AtPtx4305R1139,
		r_LaneIndexAtPtx4454;
	uint32_t r_PackedHalf2AtPtx4327R1141, r_LaneIndexAtPtx4461, r_LaneIndexAtPtx4464, r_LaneIndexAtPtx4467,
		r_LaneIndexAtPtx4470, r_LaneIndexAtPtx4473, r_LaneIndexAtPtx4476, r_LaneIndexAtPtx4479,
		r_PackedHalf2AtPtx4357R1149, r_LaneIndexAtPtx4486, r_PackedHalf2AtPtx4379R1151,
		r_PackedHalf2AtPtx2281R1152;
	uint32_t r_LaneIndexAtPtx4493, r_LaneIndexAtPtx4496, r_LaneIndexAtPtx4499, r_LaneIndexAtPtx4502,
		r_LaneIndexAtPtx4505, r_LaneIndexAtPtx4508, r_LaneIndexAtPtx4511, r_PackedHalf2AtPtx4386R1160,
		r_LaneIndexAtPtx4527, r_PackedHalf2AtPtx4393R1162, r_LaneIndexAtPtx4543, r_LaneIndexAtPtx4546;
	uint32_t r_LaneIndexAtPtx4549, r_LaneIndexAtPtx4552, r_LaneIndexAtPtx4555, r_LaneIndexAtPtx4558,
		r_LaneIndexAtPtx4561, r_PackedHalf2AtPtx4418R1170, r_LaneIndexAtPtx4577, r_PackedHalf2AtPtx4425R1172,
		r_LaneIndexAtPtx4593, r_LaneIndexAtPtx4596, r_LaneIndexAtPtx4599, r_LaneIndexAtPtx4602;
	uint32_t r_LaneIndexAtPtx4605, r_LaneIndexAtPtx4608, r_LaneIndexAtPtx4611, r_PackedHalf2AtPtx4450R1180,
		r_LaneIndexAtPtx4627, r_PackedHalf2AtPtx4457R1182, r_LaneIndexAtPtx4643, r_LaneIndexAtPtx4646,
		r_LaneIndexAtPtx4649, r_LaneIndexAtPtx4652, r_LaneIndexAtPtx4655, r_LaneIndexAtPtx4658;
	uint32_t r_LaneIndexAtPtx4661, r_PackedHalf2AtPtx4482R1190, r_LaneIndexAtPtx4677,
		r_PackedHalf2AtPtx4489R1192, r_LaneIndexAtPtx4693, r_LaneIndexAtPtx4696, r_LaneIndexAtPtx4699,
		r_LaneIndexAtPtx4702, r_LaneIndexAtPtx4705, r_LaneIndexAtPtx4708, r_LaneIndexAtPtx4711,
		r_PackedHalf2AtPtx4514R1200;
	uint32_t r_LaneIndexAtPtx4718, r_PackedHalf2AtPtx4530R1202, r_LaneIndexAtPtx4725, r_LaneIndexAtPtx4732,
		r_LaneIndexAtPtx4739, r_LaneIndexAtPtx4746, r_LaneIndexAtPtx4753, r_LaneIndexAtPtx4760,
		r_LaneIndexAtPtx4767, r_PackedHalf2AtPtx4564R1210, r_LaneIndexAtPtx4774, r_PackedHalf2AtPtx4580R1212;
	uint32_t r_LaneIndexAtPtx4781, r_LaneIndexAtPtx4788, r_LaneIndexAtPtx4795, r_LaneIndexAtPtx4802,
		r_LaneIndexAtPtx4809, r_LaneIndexAtPtx4816, r_LaneIndexAtPtx4823, r_PackedHalf2AtPtx4614R1220,
		r_LaneIndexAtPtx4830, r_PackedHalf2AtPtx4630R1222, r_LaneIndexAtPtx4837, r_LaneIndexAtPtx4844;
	uint32_t r_LaneIndexAtPtx4851, r_LaneIndexAtPtx4858, r_LaneIndexAtPtx4865, r_LaneIndexAtPtx4872,
		r_LaneIndexAtPtx4879, r_PackedHalf2AtPtx4664R1230, r_LaneIndexAtPtx4886, r_PackedHalf2AtPtx4680R1232,
		r_LaneIndexAtPtx4893, r_LaneIndexAtPtx4900, r_LaneIndexAtPtx4907, r_LaneIndexAtPtx4914;
	uint32_t r_LaneIndexAtPtx4921, r_LaneIndexAtPtx4928, r_PackedHalf2AtPtx4714R1239,
		r_PackedHalf2AtPtx4728R1240, r_PackedHalf2AtPtx4742R1241, r_PackedHalf2AtPtx4756R1242,
		r_PackedHalf2AtPtx4721R1243, r_PackedHalf2AtPtx4735R1244, r_PackedHalf2AtPtx4749R1245,
		r_PackedHalf2AtPtx4763R1246, r_PackedHalf2AtPtx4770R1247, r_PackedHalf2AtPtx4784R1248;
	uint32_t r_PackedHalf2AtPtx4798R1249, r_PackedHalf2AtPtx4812R1250, r_PackedHalf2AtPtx4777R1251,
		r_PackedHalf2AtPtx4791R1252, r_PackedHalf2AtPtx4805R1253, r_PackedHalf2AtPtx4819R1254,
		r_PackedHalf2AtPtx4826R1255, r_PackedHalf2AtPtx4840R1256, r_PackedHalf2AtPtx4854R1257,
		r_PackedHalf2AtPtx4868R1258, r_PackedHalf2AtPtx4833R1259, r_PackedHalf2AtPtx4847R1260;
	uint32_t r_PackedHalf2AtPtx4861R1261, r_PackedHalf2AtPtx4875R1262, r_PackedHalf2AtPtx4882R1263,
		r_PackedHalf2AtPtx4896R1264, r_PackedHalf2AtPtx4910R1265, r_PackedHalf2AtPtx4924R1266,
		r_PackedHalf2AtPtx4889R1267, r_PackedHalf2AtPtx4903R1268, r_PackedHalf2AtPtx4917R1269,
		r_PackedHalf2AtPtx4931R1270, r_LaneIndexAtPtx5037, r_PackedE4WordAtPtx5035R1272;
	uint32_t r_PackedE4WordAtPtx5034R1273, r_PackedE4WordAtPtx5033R1274, r_PackedE4WordAtPtx5032R1275,
		r_LaneIndexAtPtx5048, r_PackedE4WordAtPtx5056R1277, r_PackedE4WordAtPtx5055R1278,
		r_PackedE4WordAtPtx5054R1279, r_PackedE4WordAtPtx5053R1280, r_LaneIndexAtPtx5064,
		r_PackedE4WordAtPtx5072R1282, r_PackedE4WordAtPtx5071R1283, r_PackedE4WordAtPtx5070R1284;
	uint32_t r_PackedE4WordAtPtx5069R1285, r_LaneIndexAtPtx5080, r_PackedE4WordAtPtx5088R1287,
		r_PackedE4WordAtPtx5087R1288, r_PackedE4WordAtPtx5086R1289, r_PackedE4WordAtPtx5085R1290,
		r_LaneIndexAtPtx5105, r_LaneIndexAtPtx5120, r_LaneIndexAtPtx5136, r_LaneIndexAtPtx5151,
		r_LaneIndexAtPtx5167, r_LaneIndexAtPtx5183;
	uint32_t r_LaneIndexAtPtx5199, r_LaneIndexAtPtx5213, r_LaneIndexAtPtx5223, r_LaneIndexAtPtx5230,
		r_LaneIndexAtPtx5237, r_LaneIndexAtPtx5244, r_LaneIndexAtPtx5251, r_LaneIndexAtPtx5258,
		r_LaneIndexAtPtx5265, r_LaneIndexAtPtx5272, r_LaneIndexAtPtx5279, r_LaneIndexAtPtx5286;
	uint32_t r_LaneIndexAtPtx5293, r_LaneIndexAtPtx5300, r_LaneIndexAtPtx5307, r_LaneIndexAtPtx5314,
		r_LaneIndexAtPtx5321, r_LaneIndexAtPtx5328, r_LaneIndexAtPtx5335, r_LaneIndexAtPtx5342,
		r_LaneIndexAtPtx5349, r_LaneIndexAtPtx5356, r_LaneIndexAtPtx5363, r_LaneIndexAtPtx5370;
	uint32_t r_LaneIndexAtPtx5377, r_LaneIndexAtPtx5384, r_LaneIndexAtPtx5391, r_LaneIndexAtPtx5398,
		r_LaneIndexAtPtx5405, r_LaneIndexAtPtx5412, r_LaneIndexAtPtx5419, r_LaneIndexAtPtx5426,
		r_LaneIndexAtPtx5433, r_LaneIndexAtPtx5440, r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_LaneIndexAtPtx5657, r_PackedE4WordAtPtx5655R1400, r_PackedE4WordAtPtx5654R1401,
		r_PackedE4WordAtPtx5653R1402, r_PackedE4WordAtPtx5652R1403, r_LaneIndexAtPtx5665;
	uint32_t r_PackedE4WordAtPtx5651R1405, r_PackedE4WordAtPtx5650R1406, r_PackedE4WordAtPtx5649R1407,
		r_PackedE4WordAtPtx5648R1408, r_PtxRegister1409, r_LaneIndexAtPtx5678, r_PackedE4WordAtPtx5686R1411,
		r_PackedE4WordAtPtx5685R1412, r_PackedE4WordAtPtx5684R1413, r_PackedE4WordAtPtx5683R1414,
		r_LaneIndexAtPtx5691, r_PackedE4WordAtPtx5699R1416;
	uint32_t r_PackedE4WordAtPtx5698R1417, r_PackedE4WordAtPtx5697R1418, r_PackedE4WordAtPtx5696R1419,
		r_PtxRegister1420, r_PtxRegister1421, r_PtxRegister1422, r_PtxRegister1423, r_PtxRegister1424,
		r_PtxRegister1425, r_LaneIndexAtPtx5717, r_LaneIndexAtPtx5728, r_LaneIndexAtPtx5742;
	uint32_t r_LaneIndexAtPtx5750, r_LaneIndexAtPtx5764, r_LaneIndexAtPtx5772, r_LaneIndexAtPtx5785,
		r_LaneIndexAtPtx5794, r_LaneIndexAtPtx5807, r_LaneIndexAtPtx5815, r_LaneIndexAtPtx5828,
		r_LaneIndexAtPtx5836, r_LaneIndexAtPtx5849, r_LaneIndexAtPtx5857, r_LaneIndexAtPtx5869;
	uint32_t r_LaneIndexAtPtx5878, r_LaneIndexAtPtx5891, r_LaneIndexAtPtx5899, r_LaneIndexAtPtx5912,
		r_LaneIndexAtPtx5920, r_LaneIndexAtPtx5933, r_LaneIndexAtPtx5941, r_LaneIndexAtPtx5952,
		r_LaneIndexAtPtx5961, r_ThreadZAtPtx5971, r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx291R1453, r_MmaAccumulatorHalf2WordAtPtx292R1454,
		r_MmaAccumulatorHalf2WordAtPtx293R1455, r_MmaAccumulatorHalf2WordAtPtx294R1456,
		r_MmaAccumulatorHalf2WordAtPtx295R1457, r_MmaAccumulatorHalf2WordAtPtx296R1458,
		r_MmaAccumulatorHalf2WordAtPtx297R1459, r_MmaAccumulatorHalf2WordAtPtx298R1460,
		r_MmaAccumulatorHalf2WordAtPtx299R1461, r_MmaAccumulatorHalf2WordAtPtx300R1462,
		r_MmaAccumulatorHalf2WordAtPtx301R1463, r_MmaAccumulatorHalf2WordAtPtx302R1464;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx303R1465, r_MmaAccumulatorHalf2WordAtPtx304R1466,
		r_MmaAccumulatorHalf2WordAtPtx305R1467, r_MmaAccumulatorHalf2WordAtPtx306R1468,
		r_MmaAccumulatorHalf2WordAtPtx307R1469, r_MmaAccumulatorHalf2WordAtPtx308R1470,
		r_MmaAccumulatorHalf2WordAtPtx309R1471, r_MmaAccumulatorHalf2WordAtPtx310R1472,
		r_MmaAccumulatorHalf2WordAtPtx311R1473, r_MmaAccumulatorHalf2WordAtPtx312R1474,
		r_MmaAccumulatorHalf2WordAtPtx313R1475, r_MmaAccumulatorHalf2WordAtPtx314R1476;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx315R1477, r_MmaAccumulatorHalf2WordAtPtx316R1478,
		r_MmaAccumulatorHalf2WordAtPtx317R1479, r_MmaAccumulatorHalf2WordAtPtx318R1480,
		r_MmaAccumulatorHalf2WordAtPtx319R1481, r_MmaAccumulatorHalf2WordAtPtx320R1482,
		r_MmaAccumulatorHalf2WordAtPtx321R1483, r_MmaAccumulatorHalf2WordAtPtx322R1484,
		r_MmaAccumulatorHalf2WordAtPtx323R1485, r_MmaAccumulatorHalf2WordAtPtx324R1486,
		r_MmaAccumulatorHalf2WordAtPtx325R1487, r_MmaAccumulatorHalf2WordAtPtx326R1488;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx327R1489, r_MmaAccumulatorHalf2WordAtPtx328R1490,
		r_MmaAccumulatorHalf2WordAtPtx329R1491, r_MmaAccumulatorHalf2WordAtPtx330R1492,
		r_MmaAccumulatorHalf2WordAtPtx331R1493, r_MmaAccumulatorHalf2WordAtPtx332R1494,
		r_MmaAccumulatorHalf2WordAtPtx333R1495, r_MmaAccumulatorHalf2WordAtPtx334R1496,
		r_MmaAccumulatorHalf2WordAtPtx335R1497, r_MmaAccumulatorHalf2WordAtPtx336R1498,
		r_MmaAccumulatorHalf2WordAtPtx337R1499, r_MmaAccumulatorHalf2WordAtPtx338R1500;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx339R1501, r_MmaAccumulatorHalf2WordAtPtx340R1502,
		r_MmaAccumulatorHalf2WordAtPtx341R1503, r_MmaAccumulatorHalf2WordAtPtx342R1504,
		r_MmaAccumulatorHalf2WordAtPtx343R1505, r_MmaAccumulatorHalf2WordAtPtx344R1506,
		r_MmaAccumulatorHalf2WordAtPtx345R1507, r_MmaAccumulatorHalf2WordAtPtx346R1508,
		r_MmaAccumulatorHalf2WordAtPtx347R1509, r_MmaAccumulatorHalf2WordAtPtx348R1510,
		r_MmaAccumulatorHalf2WordAtPtx349R1511, r_MmaAccumulatorHalf2WordAtPtx350R1512;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx351R1513, r_MmaAccumulatorHalf2WordAtPtx352R1514,
		r_MmaAccumulatorHalf2WordAtPtx353R1515, r_MmaAccumulatorHalf2WordAtPtx354R1516,
		r_MmaAccumulatorHalf2WordAtPtx355R1517, r_MmaAccumulatorHalf2WordAtPtx356R1518,
		r_MmaAccumulatorHalf2WordAtPtx357R1519, r_MmaAccumulatorHalf2WordAtPtx358R1520,
		r_MmaAccumulatorHalf2WordAtPtx359R1521, r_MmaAccumulatorHalf2WordAtPtx360R1522,
		r_MmaAccumulatorHalf2WordAtPtx361R1523, r_MmaAccumulatorHalf2WordAtPtx362R1524;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx363R1525, r_MmaAccumulatorHalf2WordAtPtx364R1526,
		r_MmaAccumulatorHalf2WordAtPtx365R1527, r_MmaAccumulatorHalf2WordAtPtx366R1528,
		r_MmaAccumulatorHalf2WordAtPtx367R1529, r_MmaAccumulatorHalf2WordAtPtx368R1530,
		r_MmaAccumulatorHalf2WordAtPtx369R1531, r_MmaAccumulatorHalf2WordAtPtx370R1532,
		r_MmaAccumulatorHalf2WordAtPtx371R1533, r_MmaAccumulatorHalf2WordAtPtx372R1534,
		r_MmaAccumulatorHalf2WordAtPtx373R1535, r_MmaAccumulatorHalf2WordAtPtx374R1536;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx375R1537, r_MmaAccumulatorHalf2WordAtPtx376R1538,
		r_MmaAccumulatorHalf2WordAtPtx377R1539, r_MmaAccumulatorHalf2WordAtPtx378R1540,
		r_MmaAccumulatorHalf2WordAtPtx379R1541, r_MmaAccumulatorHalf2WordAtPtx380R1542,
		r_MmaAccumulatorHalf2WordAtPtx381R1543, r_MmaAccumulatorHalf2WordAtPtx382R1544,
		r_MmaAccumulatorHalf2WordAtPtx383R1545, r_MmaAccumulatorHalf2WordAtPtx384R1546,
		r_MmaAccumulatorHalf2WordAtPtx385R1547, r_MmaAccumulatorHalf2WordAtPtx386R1548;
	uint32_t r_PtxRegister1549, r_MmaBE4x4WordAtPtx163R1550, r_MmaBE4x4WordAtPtx163R1551,
		r_MmaBE4x4WordAtPtx163R1552, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx148R1554,
		r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556, r_MmaBE4x4WordAtPtx88R1557,
		r_MmaBE4x4WordAtPtx88R1558, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560;
	uint32_t r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562, r_MmaBE4x4WordAtPtx118R1563,
		r_MmaBE4x4WordAtPtx118R1564, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568, r_MmaBE4x4WordAtPtx133R1569,
		r_MmaBE4x4WordAtPtx133R1570, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572;
	uint32_t r_MmaBE4x4WordAtPtx148R1573, r_PackedHalf2AtPtx1373R1574, r_PackedHalf2AtPtx1374R1575,
		r_PackedHalf2AtPtx1375R1576, r_PackedHalf2AtPtx1376R1577, r_PackedHalf2AtPtx1391R1578,
		r_PackedHalf2AtPtx1392R1579, r_PackedHalf2AtPtx1393R1580, r_PackedHalf2AtPtx1394R1581,
		r_PackedHalf2AtPtx1408R1582, r_PackedHalf2AtPtx1409R1583, r_PackedHalf2AtPtx1410R1584;
	uint32_t r_PackedHalf2AtPtx1411R1585, r_PackedHalf2AtPtx1424R1586, r_PackedHalf2AtPtx1425R1587,
		r_PackedHalf2AtPtx1426R1588, r_PackedHalf2AtPtx1427R1589, r_PackedHalf2AtPtx1441R1590,
		r_PackedHalf2AtPtx1442R1591, r_PackedHalf2AtPtx1443R1592, r_PackedHalf2AtPtx1444R1593,
		r_PackedHalf2AtPtx1456R1594, r_PackedHalf2AtPtx1457R1595, r_PackedHalf2AtPtx1458R1596;
	uint32_t r_PackedHalf2AtPtx1459R1597, r_PackedHalf2AtPtx1473R1598, r_PackedHalf2AtPtx1474R1599,
		r_PackedHalf2AtPtx1475R1600, r_PackedHalf2AtPtx1476R1601, r_PackedHalf2AtPtx1487R1602,
		r_PackedHalf2AtPtx1488R1603, r_PackedHalf2AtPtx1489R1604, r_PackedHalf2AtPtx1490R1605,
		r_PackedHalf2AtPtx3484R1606, r_PackedHalf2AtPtx3485R1607, r_PackedHalf2AtPtx3486R1608;
	uint32_t r_PackedHalf2AtPtx3487R1609, r_PackedHalf2AtPtx3500R1610, r_PackedHalf2AtPtx3501R1611,
		r_PackedHalf2AtPtx3502R1612, r_PackedHalf2AtPtx3503R1613, r_PackedHalf2AtPtx3516R1614,
		r_PackedHalf2AtPtx3517R1615, r_PackedHalf2AtPtx3518R1616, r_PackedHalf2AtPtx3519R1617,
		r_PackedHalf2AtPtx3532R1618, r_PackedHalf2AtPtx3533R1619, r_PackedHalf2AtPtx3534R1620;
	uint32_t r_PackedHalf2AtPtx3535R1621, r_PackedHalf2AtPtx3548R1622, r_PackedHalf2AtPtx3549R1623,
		r_PackedHalf2AtPtx3550R1624, r_PackedHalf2AtPtx3551R1625, r_PackedHalf2AtPtx3564R1626,
		r_PackedHalf2AtPtx3565R1627, r_PackedHalf2AtPtx3566R1628, r_PackedHalf2AtPtx3567R1629,
		r_PackedHalf2AtPtx3580R1630, r_PackedHalf2AtPtx3581R1631, r_PackedHalf2AtPtx3582R1632;
	uint32_t r_PackedHalf2AtPtx3583R1633, r_PackedHalf2AtPtx3595R1634, r_PackedHalf2AtPtx3596R1635,
		r_PackedHalf2AtPtx3597R1636, r_PackedHalf2AtPtx3598R1637, r_PackedHalf2AtPtx5099R1638,
		r_PackedHalf2AtPtx5100R1639, r_PackedHalf2AtPtx5101R1640, r_PackedHalf2AtPtx5102R1641,
		r_PackedHalf2AtPtx5114R1642, r_PackedHalf2AtPtx5115R1643, r_PackedHalf2AtPtx5116R1644;
	uint32_t r_PackedHalf2AtPtx5117R1645, r_PackedHalf2AtPtx5130R1646, r_PackedHalf2AtPtx5131R1647,
		r_PackedHalf2AtPtx5132R1648, r_PackedHalf2AtPtx5133R1649, r_PackedHalf2AtPtx5145R1650,
		r_PackedHalf2AtPtx5146R1651, r_PackedHalf2AtPtx5147R1652, r_PackedHalf2AtPtx5148R1653,
		r_PackedHalf2AtPtx5161R1654, r_PackedHalf2AtPtx5162R1655, r_PackedHalf2AtPtx5163R1656;
	uint32_t r_PackedHalf2AtPtx5164R1657, r_PackedHalf2AtPtx5177R1658, r_PackedHalf2AtPtx5178R1659,
		r_PackedHalf2AtPtx5179R1660, r_PackedHalf2AtPtx5180R1661, r_PackedHalf2AtPtx5193R1662,
		r_PackedHalf2AtPtx5194R1663, r_PackedHalf2AtPtx5195R1664, r_PackedHalf2AtPtx5196R1665,
		r_PackedHalf2AtPtx5219R1666, r_PackedHalf2AtPtx5208R1667, r_PackedHalf2AtPtx5209R1668;
	uint32_t r_PackedHalf2AtPtx5210R1669;
	uint64_t g_StateBaseAddress, g_ScratchBaseAddress, g_StateByteAddressAtPtx286, r_PtxU64Register4,
		r_PtxU64Register5, g_ScratchByteAddressAtPtx1372, g_ScratchByteAddressAtPtx5714,
		g_ScratchByteAddressAtPtx5739, g_ScratchByteAddressAtPtx5761, r_PtxU64Register10, r_PtxU64Register11,
		r_PtxU64Register12;
	uint64_t r_PtxU64Register13, r_PtxU64Register14, r_PtxU64Register15, g_ScratchByteAddressAtPtx1390,
		g_ScratchByteAddressAtPtx1407, g_ScratchByteAddressAtPtx1423, g_ScratchByteAddressAtPtx1440,
		g_ScratchByteAddressAtPtx1455, g_ScratchByteAddressAtPtx1472, r_PtxU64Register22, r_PtxU64Register23,
		r_PtxU64Register24;
	uint64_t r_PtxU64Register25, r_PtxU64Register26, r_PtxU64Register27, r_PtxU64Register28,
		r_PtxU64Register29, r_PtxU64Register30, r_PtxU64Register31, r_PtxU64Register32, r_PtxU64Register33,
		r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_QBits, r_KBits, r_VBits, g_RecordBaseAddress,
		g_CounterBaseAddress, g_RecordByteAddressAtPtx86, g_RecordByteAddressAtPtx101,
		g_RecordByteAddressAtPtx116, g_RecordByteAddressAtPtx131, g_RecordByteAddressAtPtx146;
	uint64_t g_RecordByteAddressAtPtx161, r_PtxU64Register50, g_RecordByteAddressAtPtx80, r_PtxU64Register52,
		g_RecordByteAddressAtPtx85, r_PtxU64Register54, g_RecordByteAddressAtPtx95, r_PtxU64Register56,
		g_RecordByteAddressAtPtx100, r_PtxU64Register58, g_RecordByteAddressAtPtx110, r_PtxU64Register60;
	uint64_t g_RecordByteAddressAtPtx115, r_PtxU64Register62, g_RecordByteAddressAtPtx125, r_PtxU64Register64,
		g_RecordByteAddressAtPtx130, r_PtxU64Register66, g_RecordByteAddressAtPtx140, r_PtxU64Register68,
		g_RecordByteAddressAtPtx145, r_PtxU64Register70, g_RecordByteAddressAtPtx155, r_PtxU64Register72;
	uint64_t g_RecordByteAddressAtPtx160, g_StateByteAddressAtPtx188, g_StateByteAddressAtPtx186,
		r_PtxU64Register76, g_StateByteAddressAtPtx237, g_StateByteAddressAtPtx235, r_PtxU64Register79,
		r_PtxU64Register80, g_StateByteAddressAtPtx791, r_PtxU64Register82, g_StateByteAddressAtPtx837,
		r_PtxU64Register84;
	uint64_t g_RecordByteAddressAtPtx878, g_RecordByteAddressAtPtx891, g_RecordByteAddressAtPtx904,
		g_RecordByteAddressAtPtx917, g_RecordByteAddressAtPtx930, g_RecordByteAddressAtPtx943,
		r_PtxU64Register91, g_RecordByteAddressAtPtx872, r_PtxU64Register93, g_RecordByteAddressAtPtx877,
		r_PtxU64Register95, g_RecordByteAddressAtPtx885;
	uint64_t r_PtxU64Register97, g_RecordByteAddressAtPtx890, r_PtxU64Register99, g_RecordByteAddressAtPtx898,
		r_PtxU64Register101, g_RecordByteAddressAtPtx903, r_PtxU64Register103, g_RecordByteAddressAtPtx911,
		r_PtxU64Register105, g_RecordByteAddressAtPtx916, r_PtxU64Register107, g_RecordByteAddressAtPtx924;
	uint64_t r_PtxU64Register109, g_RecordByteAddressAtPtx929, r_PtxU64Register111,
		g_RecordByteAddressAtPtx937, r_PtxU64Register113, g_RecordByteAddressAtPtx942, r_PtxU64Register115,
		r_PtxU64Register116, g_ScratchByteAddressAtPtx1346, r_PtxU64Register118, r_PtxU64Register119,
		r_PtxU64Register120;
	uint64_t g_ScratchByteAddressAtPtx1384, r_PtxU64Register122, g_ScratchByteAddressAtPtx1400,
		r_PtxU64Register124, g_ScratchByteAddressAtPtx1417, r_PtxU64Register126,
		g_ScratchByteAddressAtPtx1433, r_PtxU64Register128, g_ScratchByteAddressAtPtx1450,
		r_PtxU64Register130, g_ScratchByteAddressAtPtx1465, r_PtxU64Register132;
	uint64_t g_ScratchByteAddressAtPtx1482, r_PtxU64Register134, g_ScratchByteAddressAtPtx1497,
		r_PtxU64Register136, g_ScratchByteAddressAtPtx1496, g_RecordByteAddressAtPtx3073, r_PtxU64Register139,
		g_RecordByteAddressAtPtx3075, r_PtxU64Register141, r_PtxU64Register142, r_PtxU64Register143,
		r_PtxU64Register144;
	uint64_t r_PtxU64Register145, r_PtxU64Register146, r_PtxU64Register147, r_PtxU64Register148,
		r_PtxU64Register149, r_PtxU64Register150, r_PtxU64Register151, r_PtxU64Register152,
		r_PtxU64Register153, r_PtxU64Register154, r_PtxU64Register155, r_PtxU64Register156;
	uint64_t r_PtxU64Register157, r_PtxU64Register158, r_PtxU64Register159, r_PtxU64Register160,
		r_PtxU64Register161, r_PtxU64Register162, r_PtxU64Register163, r_PtxU64Register164,
		r_PtxU64Register165, r_PtxU64Register166, r_PtxU64Register167, r_PtxU64Register168;
	uint64_t r_PtxU64Register169, r_PtxU64Register170, r_PtxU64Register171, r_PtxU64Register172,
		r_PtxU64Register173, r_PtxU64Register174, r_PtxU64Register175, r_PtxU64Register176,
		r_PtxU64Register177, r_PtxU64Register178, r_PtxU64Register179, r_PtxU64Register180;
	uint64_t r_PtxU64Register181, r_PtxU64Register182, r_PtxU64Register183, r_PtxU64Register184,
		r_PtxU64Register185, r_PtxU64Register186, r_PtxU64Register187, r_PtxU64Register188,
		r_PtxU64Register189, r_PtxU64Register190, r_PtxU64Register191, r_PtxU64Register192;
	uint64_t r_PtxU64Register193, r_PtxU64Register194, r_PtxU64Register195, r_PtxU64Register196,
		r_PtxU64Register197, r_PtxU64Register198, r_PtxU64Register199, r_PtxU64Register200,
		r_PtxU64Register201, r_PtxU64Register202, r_PtxU64Register203, r_PtxU64Register204;
	uint64_t r_PtxU64Register205, r_PtxU64Register206, r_PtxU64Register207, r_PtxU64Register208,
		r_PtxU64Register209, r_PtxU64Register210, r_PtxU64Register211, r_PtxU64Register212,
		r_PtxU64Register213, r_PtxU64Register214, r_PtxU64Register215, g_ScratchByteAddressAtPtx5720;
	uint64_t r_PtxU64Register217, g_ScratchByteAddressAtPtx5732, r_PtxU64Register219,
		g_ScratchByteAddressAtPtx5731, g_ScratchByteAddressAtPtx5745, g_ScratchByteAddressAtPtx5754,
		r_PtxU64Register223, r_PtxU64Register224, g_ScratchByteAddressAtPtx5753,
		g_ScratchByteAddressAtPtx5767, g_ScratchByteAddressAtPtx5776, r_PtxU64Register228;
	uint64_t r_PtxU64Register229, g_ScratchByteAddressAtPtx5775, g_ScratchByteAddressAtPtx5789,
		g_ScratchByteAddressAtPtx5798, r_PtxU64Register233, g_ScratchByteAddressAtPtx5788,
		r_PtxU64Register235, g_ScratchByteAddressAtPtx5797, r_PtxU64Register237, r_PtxU64Register238,
		r_PtxU64Register239, r_PtxU64Register240;
	uint64_t r_PtxU64Register241, r_PtxU64Register242, r_PtxU64Register243, r_PtxU64Register244,
		r_PtxU64Register245, r_PtxU64Register246, r_PtxU64Register247, r_PtxU64Register248,
		r_PtxU64Register249, r_PtxU64Register250, r_PtxU64Register251, r_PtxU64Register252;
	uint64_t r_PtxU64Register253, r_PtxU64Register254, r_PtxU64Register255, r_PtxU64Register256,
		r_PtxU64Register257, r_PtxU64Register258, r_PtxU64Register259, r_PtxU64Register260,
		r_PtxU64Register261, r_PtxU64Register262, r_PtxU64Register263, r_PtxU64Register264;
	uint64_t r_PtxU64Register265, r_PtxU64Register266, r_PtxU64Register267, r_PtxU64Register268,
		r_PtxU64Register269, r_PtxU64Register270, r_PtxU64Register271, r_PtxU64Register272,
		r_PtxU64Register273, r_PtxU64Register274, r_PtxU64Register275, r_PtxU64Register276;
	uint64_t r_PtxU64Register277, r_PtxU64Register278, g_CounterByteAddress;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	g_ScratchBaseAddress = uint64_t(r_Parameters.g_Scratch); // PTX L14
	g_CounterBaseAddress = uint64_t(r_Parameters.g_Counter); // PTX L15
	g_RecordBaseAddress = uint64_t(r_Parameters.g_Record);	 // PTX L16
	r_VBits = uint64_t(r_Parameters.g_V);					 // PTX L17
	r_KBits = uint64_t(r_Parameters.g_K);					 // PTX L18
	r_QBits = uint64_t(r_Parameters.g_Q);					 // PTX L19
	g_StateBaseAddress = uint64_t(r_Parameters.g_State);	 // PTX L20
	r_BatchBits = uint32_t(r_Parameters.Batch);
	r_TokensBits = uint32_t(r_Parameters.Tokens);					 // PTX L21
	r_CtaZ = uint32_t(blockIdx.z);									 // PTX L22
	r_PtxRegister2 = uint32_t(r_TokensBits) * uint32_t(r_BatchBits); // PTX L23
	r_bPtxPredicate1 = uint32_t(r_PtxRegister2) == uint32_t(0);		 // PTX L24
	r_PtxRegister1452 = uint32_t(0);								 // PTX L25
	if (r_bPtxPredicate1)
	{
		goto L__BB50_2;
	} // PTX L26
	r_PtxRegister52 = uint32_t(r_PtxRegister2) + uint32_t(-1);					 // PTX L27
	r_PtxRegister53 = ShiftRightSigned(int32_t(r_PtxRegister52), uint32_t(31));	 // PTX L28
	r_PtxRegister54 = ShiftRight(uint32_t(r_PtxRegister53), uint32_t(27));		 // PTX L29
	r_PtxRegister55 = uint32_t(r_PtxRegister52) + uint32_t(r_PtxRegister54);	 // PTX L30
	r_PtxRegister56 = r_PtxRegister55 & -32;									 // PTX L31
	r_PtxRegister57 = uint32_t(r_PtxRegister56) + uint32_t(32);					 // PTX L32
	r_PtxRegister1452 = ShiftRightSigned(int32_t(r_PtxRegister57), uint32_t(4)); // PTX L33
L__BB50_2:																		 // PTX L34
	r_CtaX = uint32_t(blockIdx.x);												 // PTX L35
	r_PtxRegister3 = uint32_t(r_PtxRegister2) + uint32_t(-1);					 // PTX L36
	r_PtxRegister59 = ShiftRightSigned(int32_t(r_PtxRegister3), uint32_t(31));	 // PTX L37
	r_PtxRegister60 = ShiftRight(uint32_t(r_PtxRegister59), uint32_t(25));		 // PTX L38
	r_PtxRegister61 = uint32_t(r_PtxRegister3) + uint32_t(r_PtxRegister60);		 // PTX L39
	r_PtxRegister62 = ShiftRightSigned(int32_t(r_PtxRegister61), uint32_t(7));	 // PTX L40
	r_PtxRegister63 = uint32_t(r_PtxRegister62) + uint32_t(1);					 // PTX L41
	r_PtxRegister5 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister63));		 // PTX L42
	r_PtxRegister64 =
		uint32_t(r_PtxRegister5) * uint32_t(r_PtxRegister62) + uint32_t(r_PtxRegister5); // PTX L43
	r_PtxRegister4 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister64);						 // PTX L44
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister4), uint32_t(3));					 // PTX L45
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L46
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L47
	r_PtxRegister66 = r_ThreadX | r_ThreadY;											 // PTX L48
	r_bPtxPredicate2 = uint32_t(r_PtxRegister66) != uint32_t(0);						 // PTX L49
	if (r_bPtxPredicate2)
	{
		goto L__BB50_4;
	} // PTX L50
	r_BlockSizeX = uint32_t(blockDim.x);								// PTX L51
	r_BlockSizeY = uint32_t(blockDim.y);								// PTX L52
	r_PtxRegister68 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);	// PTX L53
	r_PtxRegister67 = uint32_t(8192u /* original named shared base */); // PTX L54
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister67, r_PtxRegister68); // PTX L56
	r_PtxRegister69 = uint32_t(r_PtxRegister67) + uint32_t(8);		// PTX L58
	BarrierInit(s_SharedStorage, r_PtxRegister69, r_PtxRegister68); // PTX L60
L__BB50_4:															// PTX L62
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L63
	r_Float32BitsAtPtx64R72 = uint32_t(0);														// PTX L64
	r_PackedHalf2AtPtx5219R1666 = FloatToHalf2(r_Float32BitsAtPtx64R72);						// PTX L66
	r_PtxRegister79 = r_ThreadY & 1;															// PTX L71
	r_bPtxPredicate3 = uint32_t(r_PtxRegister79) != uint32_t(0);								// PTX L72
	r_PtxRegister80 = r_bPtxPredicate3 ? 96 : 0;												// PTX L73
	r_PtxRegister81 = uint32_t(r_PtxRegister5) * uint32_t(192) + uint32_t(r_PtxRegister80);		// PTX L74
	r_PtxRegister8 = ShiftRightSigned(int32_t(r_PtxRegister81), uint32_t(4));					// PTX L75
	r_PtxRegister82 = uint32_t(r_CtaZ) * uint32_t(3072);										// PTX L76
	r_PtxRegister83 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister8);						// PTX L77
	r_PtxRegister84 = ShiftLeft(uint32_t(r_PtxRegister83), uint32_t(7));						// PTX L78
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_PtxRegister84)) * int64_t(int32_t(4)));		// PTX L79
	g_RecordByteAddressAtPtx80 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register50);	// PTX L80
	r_LaneIndexAtPtx82 = uint32_t((threadIdx.x & 31u));											// PTX L82
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx82)) * int64_t(int32_t(16))); // PTX L84
	g_RecordByteAddressAtPtx85 =
		uint64_t(g_RecordByteAddressAtPtx80) + uint64_t(r_PtxU64Register52);		   // PTX L85
	g_RecordByteAddressAtPtx86 = uint64_t(g_RecordByteAddressAtPtx85) + uint64_t(128); // PTX L86
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx86));
		r_MmaBE4x4WordAtPtx88R1555 = r_Value.x;
		r_MmaBE4x4WordAtPtx88R1556 = r_Value.y;
		r_MmaBE4x4WordAtPtx88R1557 = r_Value.z;
		r_MmaBE4x4WordAtPtx88R1558 = r_Value.w;
	} // PTX L88
	r_PtxRegister85 = r_PtxRegister81 | 16;														// PTX L90
	r_PtxRegister9 = ShiftRightSigned(int32_t(r_PtxRegister85), uint32_t(4));					// PTX L91
	r_PtxRegister86 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister9);						// PTX L92
	r_PtxRegister87 = ShiftLeft(uint32_t(r_PtxRegister86), uint32_t(7));						// PTX L93
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_PtxRegister87)) * int64_t(int32_t(4)));		// PTX L94
	g_RecordByteAddressAtPtx95 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register54);	// PTX L95
	r_LaneIndexAtPtx97 = uint32_t((threadIdx.x & 31u));											// PTX L97
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx97)) * int64_t(int32_t(16))); // PTX L99
	g_RecordByteAddressAtPtx100 =
		uint64_t(g_RecordByteAddressAtPtx95) + uint64_t(r_PtxU64Register56);			 // PTX L100
	g_RecordByteAddressAtPtx101 = uint64_t(g_RecordByteAddressAtPtx100) + uint64_t(128); // PTX L101
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx101));
		r_MmaBE4x4WordAtPtx103R1559 = r_Value.x;
		r_MmaBE4x4WordAtPtx103R1560 = r_Value.y;
		r_MmaBE4x4WordAtPtx103R1561 = r_Value.z;
		r_MmaBE4x4WordAtPtx103R1562 = r_Value.w;
	} // PTX L103
	r_PtxRegister88 = uint32_t(r_PtxRegister81) + uint32_t(32);									 // PTX L105
	r_PtxRegister10 = ShiftRightSigned(int32_t(r_PtxRegister88), uint32_t(4));					 // PTX L106
	r_PtxRegister89 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister10);					 // PTX L107
	r_PtxRegister90 = ShiftLeft(uint32_t(r_PtxRegister89), uint32_t(7));						 // PTX L108
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_PtxRegister90)) * int64_t(int32_t(4)));		 // PTX L109
	g_RecordByteAddressAtPtx110 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register58);	 // PTX L110
	r_LaneIndexAtPtx112 = uint32_t((threadIdx.x & 31u));										 // PTX L112
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx112)) * int64_t(int32_t(16))); // PTX L114
	g_RecordByteAddressAtPtx115 =
		uint64_t(g_RecordByteAddressAtPtx110) + uint64_t(r_PtxU64Register60);			 // PTX L115
	g_RecordByteAddressAtPtx116 = uint64_t(g_RecordByteAddressAtPtx115) + uint64_t(128); // PTX L116
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx116));
		r_MmaBE4x4WordAtPtx118R1563 = r_Value.x;
		r_MmaBE4x4WordAtPtx118R1564 = r_Value.y;
		r_MmaBE4x4WordAtPtx118R1565 = r_Value.z;
		r_MmaBE4x4WordAtPtx118R1566 = r_Value.w;
	} // PTX L118
	r_PtxRegister91 = uint32_t(r_PtxRegister81) + uint32_t(48);									 // PTX L120
	r_PtxRegister11 = ShiftRightSigned(int32_t(r_PtxRegister91), uint32_t(4));					 // PTX L121
	r_PtxRegister92 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister11);					 // PTX L122
	r_PtxRegister93 = ShiftLeft(uint32_t(r_PtxRegister92), uint32_t(7));						 // PTX L123
	r_PtxU64Register62 = uint64_t(int64_t(int32_t(r_PtxRegister93)) * int64_t(int32_t(4)));		 // PTX L124
	g_RecordByteAddressAtPtx125 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register62);	 // PTX L125
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register64 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	g_RecordByteAddressAtPtx130 =
		uint64_t(g_RecordByteAddressAtPtx125) + uint64_t(r_PtxU64Register64);			 // PTX L130
	g_RecordByteAddressAtPtx131 = uint64_t(g_RecordByteAddressAtPtx130) + uint64_t(128); // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx131));
		r_MmaBE4x4WordAtPtx133R1567 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R1568 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R1569 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R1570 = r_Value.w;
	} // PTX L133
	r_PtxRegister94 = uint32_t(r_PtxRegister81) + uint32_t(64);									 // PTX L135
	r_PtxRegister12 = ShiftRightSigned(int32_t(r_PtxRegister94), uint32_t(4));					 // PTX L136
	r_PtxRegister95 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister12);					 // PTX L137
	r_PtxRegister96 = ShiftLeft(uint32_t(r_PtxRegister95), uint32_t(7));						 // PTX L138
	r_PtxU64Register66 = uint64_t(int64_t(int32_t(r_PtxRegister96)) * int64_t(int32_t(4)));		 // PTX L139
	g_RecordByteAddressAtPtx140 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register66);	 // PTX L140
	r_LaneIndexAtPtx142 = uint32_t((threadIdx.x & 31u));										 // PTX L142
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx142)) * int64_t(int32_t(16))); // PTX L144
	g_RecordByteAddressAtPtx145 =
		uint64_t(g_RecordByteAddressAtPtx140) + uint64_t(r_PtxU64Register68);			 // PTX L145
	g_RecordByteAddressAtPtx146 = uint64_t(g_RecordByteAddressAtPtx145) + uint64_t(128); // PTX L146
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx146));
		r_MmaBE4x4WordAtPtx148R1571 = r_Value.x;
		r_MmaBE4x4WordAtPtx148R1572 = r_Value.y;
		r_MmaBE4x4WordAtPtx148R1573 = r_Value.z;
		r_MmaBE4x4WordAtPtx148R1554 = r_Value.w;
	} // PTX L148
	r_PtxRegister97 = uint32_t(r_PtxRegister81) + uint32_t(80);									 // PTX L150
	r_PtxRegister13 = ShiftRightSigned(int32_t(r_PtxRegister97), uint32_t(4));					 // PTX L151
	r_PtxRegister98 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister13);					 // PTX L152
	r_PtxRegister99 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(7));						 // PTX L153
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_PtxRegister99)) * int64_t(int32_t(4)));		 // PTX L154
	g_RecordByteAddressAtPtx155 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register70);	 // PTX L155
	r_LaneIndexAtPtx157 = uint32_t((threadIdx.x & 31u));										 // PTX L157
	r_PtxU64Register72 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx157)) * int64_t(int32_t(16))); // PTX L159
	g_RecordByteAddressAtPtx160 =
		uint64_t(g_RecordByteAddressAtPtx155) + uint64_t(r_PtxU64Register72);			 // PTX L160
	g_RecordByteAddressAtPtx161 = uint64_t(g_RecordByteAddressAtPtx160) + uint64_t(128); // PTX L161
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx161));
		r_MmaBE4x4WordAtPtx163R1553 = r_Value.x;
		r_MmaBE4x4WordAtPtx163R1552 = r_Value.y;
		r_MmaBE4x4WordAtPtx163R1551 = r_Value.z;
		r_MmaBE4x4WordAtPtx163R1550 = r_Value.w;
	} // PTX L163
	r_PtxRegister14 = uint32_t(r_ThreadY) + uint32_t(r_PtxRegister6);			// PTX L165
	r_bPtxPredicate4 = int32_t(r_PtxRegister14) >= int32_t(r_PtxRegister1452);	// PTX L166
	r_bPtxPredicate5 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister1452);	// PTX L167
	r_PtxRegister100 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(11));				// PTX L168
	r_PtxRegister15 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(12));		// PTX L169
	r_PtxRegister16 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister100);	// PTX L170
	r_PtxRegister17 = r_bPtxPredicate5 ? r_PtxRegister16 : 0;					// PTX L171
	r_PtxRegister101 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));				// PTX L172
	r_PtxRegister102 = uint32_t(0u /* original named shared base */);			// PTX L173
	r_PtxRegister111 = uint32_t(r_PtxRegister102) + uint32_t(r_PtxRegister101); // PTX L174
	if (r_bPtxPredicate4)
	{
		goto L__BB50_7;
	} // PTX L175
	r_PtxRegister110 = uint32_t(-1);							  // PTX L176
	r_PtxRegister109 = Elected(r_PtxRegister110);				  // PTX L178
	r_bPtxPredicate6 = uint32_t(r_PtxRegister109) == uint32_t(0); // PTX L184
	if (r_bPtxPredicate6)
	{
		goto L__BB50_8;
	} // PTX L185
	g_StateByteAddressAtPtx186 = g_StateBaseAddress;										// PTX L186
	r_PtxU64Register76 = uint64_t(int64_t(int32_t(r_PtxRegister17)) * int64_t(int32_t(4))); // PTX L187
	g_StateByteAddressAtPtx188 =
		uint64_t(g_StateByteAddressAtPtx186) + uint64_t(r_PtxU64Register76); // PTX L188
	r_PtxRegister113 = uint32_t(8192u /* original named shared base */);	 // PTX L189
	r_PtxRegister112 = uint32_t(512);										 // PTX L190
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister111, g_StateByteAddressAtPtx188, r_PtxRegister112,
			 r_PtxRegister113);																  // PTX L192
	BarrierExpect(s_SharedStorage, r_PtxRegister113, r_PtxRegister112);						  // PTX L195
	goto L__BB50_8;																			  // PTX L197
L__BB50_7:																					  // PTX L198
	r_PtxRegister103 = uint32_t(0);															  // PTX L199
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister103))); // PTX L201
	r_PackedHalf2AtPtx204R104 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);		  // PTX L204
	r_ConvertedE4PairAtPtx206Rs2 = PublishE4(r_PackedHalf2AtPtx204R104);					  // PTX L206
	r_PackedE4WordAtPtx208R107 =
		JoinHalfwords(r_ConvertedE4PairAtPtx206Rs2, r_ConvertedE4PairAtPtx206Rs2); // PTX L208
	r_LaneIndexAtPtx210 = uint32_t((threadIdx.x & 31u));						   // PTX L210
	r_PtxRegister108 = ShiftLeft(uint32_t(r_LaneIndexAtPtx210), uint32_t(4));	   // PTX L212
	r_PtxRegister106 = uint32_t(r_PtxRegister111) + uint32_t(r_PtxRegister108);	   // PTX L213
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister106)) =
		make_uint4(r_PackedE4WordAtPtx208R107, r_PackedE4WordAtPtx208R107, r_PackedE4WordAtPtx208R107,
				   r_PackedE4WordAtPtx208R107);								   // PTX L215
L__BB50_8:																	   // PTX L217
	r_PtxRegister18 = uint32_t(r_PtxRegister14) + uint32_t(4);				   // PTX L218
	r_bPtxPredicate7 = int32_t(r_PtxRegister18) >= int32_t(r_PtxRegister1452); // PTX L219
	r_bPtxPredicate8 = int32_t(r_PtxRegister18) < int32_t(r_PtxRegister1452);  // PTX L220
	r_PtxRegister114 = uint32_t(r_PtxRegister16) + uint32_t(16384);			   // PTX L221
	r_PtxRegister19 = r_bPtxPredicate8 ? r_PtxRegister114 : 0;				   // PTX L222
	if (r_bPtxPredicate7)
	{
		goto L__BB50_11;
	} // PTX L223
	r_PtxRegister123 = uint32_t(-1);							  // PTX L224
	r_PtxRegister122 = Elected(r_PtxRegister123);				  // PTX L226
	r_bPtxPredicate9 = uint32_t(r_PtxRegister122) == uint32_t(0); // PTX L232
	if (r_bPtxPredicate9)
	{
		goto L__BB50_12;
	} // PTX L233
	r_PtxRegister124 = uint32_t(r_PtxRegister111) + uint32_t(2048);							// PTX L234
	g_StateByteAddressAtPtx235 = g_StateBaseAddress;										// PTX L235
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister19)) * int64_t(int32_t(4))); // PTX L236
	g_StateByteAddressAtPtx237 =
		uint64_t(g_StateByteAddressAtPtx235) + uint64_t(r_PtxU64Register79); // PTX L237
	r_PtxRegister126 = uint32_t(8192u /* original named shared base */);	 // PTX L238
	r_PtxRegister125 = uint32_t(512);										 // PTX L239
	CopyBulk(s_SharedStorage, r_PtxRegister124, g_StateByteAddressAtPtx237, r_PtxRegister125,
			 r_PtxRegister126);																  // PTX L241
	BarrierExpect(s_SharedStorage, r_PtxRegister126, r_PtxRegister125);						  // PTX L244
	goto L__BB50_12;																		  // PTX L246
L__BB50_11:																					  // PTX L247
	r_PtxRegister115 = uint32_t(0);															  // PTX L248
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister115))); // PTX L250
	r_PackedHalf2AtPtx253R116 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		  // PTX L253
	r_ConvertedE4PairAtPtx255Rs4 = PublishE4(r_PackedHalf2AtPtx253R116);					  // PTX L255
	r_PackedE4WordAtPtx257R119 =
		JoinHalfwords(r_ConvertedE4PairAtPtx255Rs4, r_ConvertedE4PairAtPtx255Rs4); // PTX L257
	r_LaneIndexAtPtx259 = uint32_t((threadIdx.x & 31u));						   // PTX L259
	r_PtxRegister120 = ShiftLeft(uint32_t(r_LaneIndexAtPtx259), uint32_t(4));	   // PTX L261
	r_PtxRegister121 = uint32_t(r_PtxRegister111) + uint32_t(r_PtxRegister120);	   // PTX L262
	r_PtxRegister118 = uint32_t(r_PtxRegister121) + uint32_t(2048);				   // PTX L263
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister118)) =
		make_uint4(r_PackedE4WordAtPtx257R119, r_PackedE4WordAtPtx257R119, r_PackedE4WordAtPtx257R119,
				   r_PackedE4WordAtPtx257R119);							 // PTX L265
L__BB50_12:																 // PTX L267
	r_PtxRegister127 = uint32_t(8192u /* original named shared base */); // PTX L268
	r_PtxRegister128 = uint32_t(1);										 // PTX L269
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register80 = BarrierArrive(s_SharedStorage, r_PtxRegister127, r_PtxRegister128); // PTX L271
L__BB50_13:																					 // PTX L273
	r_PtxRegister130 = uint32_t(8192u /* original named shared base */);					 // PTX L274
	r_PtxRegister129 = BarrierReady(s_SharedStorage, r_PtxRegister130, r_PtxU64Register80);	 // PTX L276
	r_bPtxPredicate10 = uint32_t(r_PtxRegister129) == uint32_t(0);							 // PTX L282
	if (r_bPtxPredicate10)
	{
		goto L__BB50_13;
	} // PTX L283
	r_PtxRegister131 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));					// PTX L284
	r_PtxRegister20 = r_PtxRegister131 & 2044;										// PTX L285
	g_StateByteAddressAtPtx286 = g_StateBaseAddress;								// PTX L286
	r_PtxRegister132 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(10));				// PTX L287
	r_PtxRegister21 = r_PtxRegister132 & 1046528;									// PTX L288
	r_PtxRegister22 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));						// PTX L289
	r_PtxRegister1549 = uint32_t(0);												// PTX L290
	r_MmaAccumulatorHalf2WordAtPtx291R1453 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L291
	r_MmaAccumulatorHalf2WordAtPtx292R1454 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L292
	r_MmaAccumulatorHalf2WordAtPtx293R1455 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L293
	r_MmaAccumulatorHalf2WordAtPtx294R1456 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L294
	r_MmaAccumulatorHalf2WordAtPtx295R1457 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L295
	r_MmaAccumulatorHalf2WordAtPtx296R1458 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L296
	r_MmaAccumulatorHalf2WordAtPtx297R1459 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L297
	r_MmaAccumulatorHalf2WordAtPtx298R1460 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L298
	r_MmaAccumulatorHalf2WordAtPtx299R1461 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L299
	r_MmaAccumulatorHalf2WordAtPtx300R1462 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L300
	r_MmaAccumulatorHalf2WordAtPtx301R1463 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L301
	r_MmaAccumulatorHalf2WordAtPtx302R1464 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L302
	r_MmaAccumulatorHalf2WordAtPtx303R1465 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L303
	r_MmaAccumulatorHalf2WordAtPtx304R1466 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L304
	r_MmaAccumulatorHalf2WordAtPtx305R1467 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L305
	r_MmaAccumulatorHalf2WordAtPtx306R1468 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L306
	r_MmaAccumulatorHalf2WordAtPtx307R1469 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L307
	r_MmaAccumulatorHalf2WordAtPtx308R1470 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L308
	r_MmaAccumulatorHalf2WordAtPtx309R1471 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L309
	r_MmaAccumulatorHalf2WordAtPtx310R1472 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L310
	r_MmaAccumulatorHalf2WordAtPtx311R1473 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L311
	r_MmaAccumulatorHalf2WordAtPtx312R1474 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L312
	r_MmaAccumulatorHalf2WordAtPtx313R1475 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L313
	r_MmaAccumulatorHalf2WordAtPtx314R1476 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L314
	r_MmaAccumulatorHalf2WordAtPtx315R1477 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L315
	r_MmaAccumulatorHalf2WordAtPtx316R1478 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L316
	r_MmaAccumulatorHalf2WordAtPtx317R1479 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L317
	r_MmaAccumulatorHalf2WordAtPtx318R1480 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L318
	r_MmaAccumulatorHalf2WordAtPtx319R1481 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L319
	r_MmaAccumulatorHalf2WordAtPtx320R1482 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L320
	r_MmaAccumulatorHalf2WordAtPtx321R1483 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L321
	r_MmaAccumulatorHalf2WordAtPtx322R1484 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L322
	r_MmaAccumulatorHalf2WordAtPtx323R1485 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L323
	r_MmaAccumulatorHalf2WordAtPtx324R1486 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L324
	r_MmaAccumulatorHalf2WordAtPtx325R1487 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L325
	r_MmaAccumulatorHalf2WordAtPtx326R1488 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L326
	r_MmaAccumulatorHalf2WordAtPtx327R1489 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L327
	r_MmaAccumulatorHalf2WordAtPtx328R1490 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L328
	r_MmaAccumulatorHalf2WordAtPtx329R1491 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L329
	r_MmaAccumulatorHalf2WordAtPtx330R1492 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L330
	r_MmaAccumulatorHalf2WordAtPtx331R1493 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L331
	r_MmaAccumulatorHalf2WordAtPtx332R1494 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L332
	r_MmaAccumulatorHalf2WordAtPtx333R1495 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L333
	r_MmaAccumulatorHalf2WordAtPtx334R1496 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L334
	r_MmaAccumulatorHalf2WordAtPtx335R1497 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L335
	r_MmaAccumulatorHalf2WordAtPtx336R1498 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L336
	r_MmaAccumulatorHalf2WordAtPtx337R1499 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L337
	r_MmaAccumulatorHalf2WordAtPtx338R1500 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L338
	r_MmaAccumulatorHalf2WordAtPtx339R1501 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L339
	r_MmaAccumulatorHalf2WordAtPtx340R1502 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L340
	r_MmaAccumulatorHalf2WordAtPtx341R1503 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L341
	r_MmaAccumulatorHalf2WordAtPtx342R1504 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L342
	r_MmaAccumulatorHalf2WordAtPtx343R1505 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L343
	r_MmaAccumulatorHalf2WordAtPtx344R1506 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L344
	r_MmaAccumulatorHalf2WordAtPtx345R1507 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L345
	r_MmaAccumulatorHalf2WordAtPtx346R1508 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L346
	r_MmaAccumulatorHalf2WordAtPtx347R1509 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L347
	r_MmaAccumulatorHalf2WordAtPtx348R1510 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L348
	r_MmaAccumulatorHalf2WordAtPtx349R1511 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L349
	r_MmaAccumulatorHalf2WordAtPtx350R1512 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L350
	r_MmaAccumulatorHalf2WordAtPtx351R1513 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L351
	r_MmaAccumulatorHalf2WordAtPtx352R1514 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L352
	r_MmaAccumulatorHalf2WordAtPtx353R1515 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L353
	r_MmaAccumulatorHalf2WordAtPtx354R1516 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L354
	r_MmaAccumulatorHalf2WordAtPtx355R1517 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L355
	r_MmaAccumulatorHalf2WordAtPtx356R1518 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L356
	r_MmaAccumulatorHalf2WordAtPtx357R1519 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L357
	r_MmaAccumulatorHalf2WordAtPtx358R1520 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L358
	r_MmaAccumulatorHalf2WordAtPtx359R1521 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L359
	r_MmaAccumulatorHalf2WordAtPtx360R1522 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L360
	r_MmaAccumulatorHalf2WordAtPtx361R1523 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L361
	r_MmaAccumulatorHalf2WordAtPtx362R1524 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L362
	r_MmaAccumulatorHalf2WordAtPtx363R1525 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L363
	r_MmaAccumulatorHalf2WordAtPtx364R1526 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L364
	r_MmaAccumulatorHalf2WordAtPtx365R1527 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L365
	r_MmaAccumulatorHalf2WordAtPtx366R1528 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L366
	r_MmaAccumulatorHalf2WordAtPtx367R1529 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L367
	r_MmaAccumulatorHalf2WordAtPtx368R1530 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L368
	r_MmaAccumulatorHalf2WordAtPtx369R1531 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L369
	r_MmaAccumulatorHalf2WordAtPtx370R1532 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L370
	r_MmaAccumulatorHalf2WordAtPtx371R1533 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L371
	r_MmaAccumulatorHalf2WordAtPtx372R1534 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L372
	r_MmaAccumulatorHalf2WordAtPtx373R1535 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L373
	r_MmaAccumulatorHalf2WordAtPtx374R1536 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L374
	r_MmaAccumulatorHalf2WordAtPtx375R1537 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L375
	r_MmaAccumulatorHalf2WordAtPtx376R1538 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L376
	r_MmaAccumulatorHalf2WordAtPtx377R1539 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L377
	r_MmaAccumulatorHalf2WordAtPtx378R1540 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L378
	r_MmaAccumulatorHalf2WordAtPtx379R1541 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L379
	r_MmaAccumulatorHalf2WordAtPtx380R1542 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L380
	r_MmaAccumulatorHalf2WordAtPtx381R1543 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L381
	r_MmaAccumulatorHalf2WordAtPtx382R1544 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L382
	r_MmaAccumulatorHalf2WordAtPtx383R1545 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L383
	r_MmaAccumulatorHalf2WordAtPtx384R1546 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L384
	r_MmaAccumulatorHalf2WordAtPtx385R1547 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L385
	r_MmaAccumulatorHalf2WordAtPtx386R1548 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L386
L__BB50_15:																			// PTX L387
	r_bPtxPredicate11 = int32_t(r_PtxRegister14) >= int32_t(r_PtxRegister1452);		// PTX L388
	r_bPtxPredicate12 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister1452);		// PTX L389
	r_PtxRegister157 = ShiftRight(uint32_t(r_PtxRegister1549), uint32_t(5));		// PTX L390
	r_PtxRegister158 = r_PtxRegister157 & 1;										// PTX L391
	r_PtxRegister23 = uint32_t(r_PtxRegister1549) + uint32_t(32);					// PTX L392
	r_PtxRegister159 = ShiftLeft(uint32_t(r_PtxRegister1549), uint32_t(7));			// PTX L393
	r_PtxRegister160 = r_PtxRegister159 & 4096;										// PTX L394
	r_LaneIndexAtPtx396 = uint32_t((threadIdx.x & 31u));							// PTX L396
	r_PtxRegister161 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister21);		// PTX L398
	r_PtxRegister162 = uint32_t(0u /* original named shared base */);				// PTX L399
	r_PtxRegister163 = uint32_t(r_PtxRegister162) + uint32_t(r_PtxRegister161);		// PTX L400
	r_PtxRegister164 = ShiftLeft(uint32_t(r_LaneIndexAtPtx396), uint32_t(4));		// PTX L401
	r_PtxRegister134 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister164);		// PTX L402
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister134));
		r_MmaAE4x4WordAtPtx404R141 = r_Value.x;
		r_MmaAE4x4WordAtPtx404R142 = r_Value.y;
		r_MmaAE4x4WordAtPtx404R143 = r_Value.z;
		r_MmaAE4x4WordAtPtx404R144 = r_Value.w;
	} // PTX L404
	r_LaneIndexAtPtx407 = uint32_t((threadIdx.x & 31u));						// PTX L407
	r_PtxRegister165 = ShiftLeft(uint32_t(r_LaneIndexAtPtx407), uint32_t(4));	// PTX L409
	r_PtxRegister166 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister165); // PTX L410
	r_PtxRegister136 = uint32_t(r_PtxRegister166) + uint32_t(512);				// PTX L411
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister136));
		r_MmaAE4x4WordAtPtx413R145 = r_Value.x;
		r_MmaAE4x4WordAtPtx413R146 = r_Value.y;
		r_MmaAE4x4WordAtPtx413R147 = r_Value.z;
		r_MmaAE4x4WordAtPtx413R148 = r_Value.w;
	} // PTX L413
	r_LaneIndexAtPtx416 = uint32_t((threadIdx.x & 31u));						// PTX L416
	r_PtxRegister167 = ShiftLeft(uint32_t(r_LaneIndexAtPtx416), uint32_t(4));	// PTX L418
	r_PtxRegister168 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister167); // PTX L419
	r_PtxRegister138 = uint32_t(r_PtxRegister168) + uint32_t(1024);				// PTX L420
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister138));
		r_MmaAE4x4WordAtPtx422R149 = r_Value.x;
		r_MmaAE4x4WordAtPtx422R150 = r_Value.y;
		r_MmaAE4x4WordAtPtx422R151 = r_Value.z;
		r_MmaAE4x4WordAtPtx422R152 = r_Value.w;
	} // PTX L422
	r_LaneIndexAtPtx425 = uint32_t((threadIdx.x & 31u));						// PTX L425
	r_PtxRegister169 = ShiftLeft(uint32_t(r_LaneIndexAtPtx425), uint32_t(4));	// PTX L427
	r_PtxRegister170 = uint32_t(r_PtxRegister163) + uint32_t(r_PtxRegister169); // PTX L428
	r_PtxRegister140 = uint32_t(r_PtxRegister170) + uint32_t(1536);				// PTX L429
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister140));
		r_MmaAE4x4WordAtPtx431R153 = r_Value.x;
		r_MmaAE4x4WordAtPtx431R154 = r_Value.y;
		r_MmaAE4x4WordAtPtx431R155 = r_Value.z;
		r_MmaAE4x4WordAtPtx431R156 = r_Value.w;
	} // PTX L431
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx386R1548, r_MmaAccumulatorHalf2WordAtPtx385R1547,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx386R1548,
		  r_MmaAccumulatorHalf2WordAtPtx385R1547); // PTX L434
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx384R1546, r_MmaAccumulatorHalf2WordAtPtx383R1545,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx384R1546,
		  r_MmaAccumulatorHalf2WordAtPtx383R1545); // PTX L441
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx382R1544, r_MmaAccumulatorHalf2WordAtPtx381R1543,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx382R1544,
		  r_MmaAccumulatorHalf2WordAtPtx381R1543); // PTX L448
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx380R1542, r_MmaAccumulatorHalf2WordAtPtx379R1541,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx380R1542,
		  r_MmaAccumulatorHalf2WordAtPtx379R1541); // PTX L455
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx378R1540, r_MmaAccumulatorHalf2WordAtPtx377R1539,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx378R1540,
		  r_MmaAccumulatorHalf2WordAtPtx377R1539); // PTX L462
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx376R1538, r_MmaAccumulatorHalf2WordAtPtx375R1537,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx376R1538,
		  r_MmaAccumulatorHalf2WordAtPtx375R1537); // PTX L469
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx374R1536, r_MmaAccumulatorHalf2WordAtPtx373R1535,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx374R1536,
		  r_MmaAccumulatorHalf2WordAtPtx373R1535); // PTX L476
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx372R1534, r_MmaAccumulatorHalf2WordAtPtx371R1533,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx372R1534,
		  r_MmaAccumulatorHalf2WordAtPtx371R1533); // PTX L483
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx370R1532, r_MmaAccumulatorHalf2WordAtPtx369R1531,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx370R1532,
		  r_MmaAccumulatorHalf2WordAtPtx369R1531); // PTX L490
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx368R1530, r_MmaAccumulatorHalf2WordAtPtx367R1529,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx368R1530,
		  r_MmaAccumulatorHalf2WordAtPtx367R1529); // PTX L497
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx366R1528, r_MmaAccumulatorHalf2WordAtPtx365R1527,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx366R1528,
		  r_MmaAccumulatorHalf2WordAtPtx365R1527); // PTX L504
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx364R1526, r_MmaAccumulatorHalf2WordAtPtx363R1525,
		  r_MmaAE4x4WordAtPtx404R141, r_MmaAE4x4WordAtPtx404R142, r_MmaAE4x4WordAtPtx404R143,
		  r_MmaAE4x4WordAtPtx404R144, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx364R1526,
		  r_MmaAccumulatorHalf2WordAtPtx363R1525); // PTX L511
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx362R1524, r_MmaAccumulatorHalf2WordAtPtx361R1523,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx362R1524,
		  r_MmaAccumulatorHalf2WordAtPtx361R1523); // PTX L518
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx360R1522, r_MmaAccumulatorHalf2WordAtPtx359R1521,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx360R1522,
		  r_MmaAccumulatorHalf2WordAtPtx359R1521); // PTX L525
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx358R1520, r_MmaAccumulatorHalf2WordAtPtx357R1519,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx358R1520,
		  r_MmaAccumulatorHalf2WordAtPtx357R1519); // PTX L532
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx356R1518, r_MmaAccumulatorHalf2WordAtPtx355R1517,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx356R1518,
		  r_MmaAccumulatorHalf2WordAtPtx355R1517); // PTX L539
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx354R1516, r_MmaAccumulatorHalf2WordAtPtx353R1515,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx354R1516,
		  r_MmaAccumulatorHalf2WordAtPtx353R1515); // PTX L546
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx352R1514, r_MmaAccumulatorHalf2WordAtPtx351R1513,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx352R1514,
		  r_MmaAccumulatorHalf2WordAtPtx351R1513); // PTX L553
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx350R1512, r_MmaAccumulatorHalf2WordAtPtx349R1511,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx350R1512,
		  r_MmaAccumulatorHalf2WordAtPtx349R1511); // PTX L560
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx348R1510, r_MmaAccumulatorHalf2WordAtPtx347R1509,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx348R1510,
		  r_MmaAccumulatorHalf2WordAtPtx347R1509); // PTX L567
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx346R1508, r_MmaAccumulatorHalf2WordAtPtx345R1507,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx346R1508,
		  r_MmaAccumulatorHalf2WordAtPtx345R1507); // PTX L574
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx344R1506, r_MmaAccumulatorHalf2WordAtPtx343R1505,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx344R1506,
		  r_MmaAccumulatorHalf2WordAtPtx343R1505); // PTX L581
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx342R1504, r_MmaAccumulatorHalf2WordAtPtx341R1503,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx342R1504,
		  r_MmaAccumulatorHalf2WordAtPtx341R1503); // PTX L588
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx340R1502, r_MmaAccumulatorHalf2WordAtPtx339R1501,
		  r_MmaAE4x4WordAtPtx413R145, r_MmaAE4x4WordAtPtx413R146, r_MmaAE4x4WordAtPtx413R147,
		  r_MmaAE4x4WordAtPtx413R148, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx340R1502,
		  r_MmaAccumulatorHalf2WordAtPtx339R1501); // PTX L595
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx338R1500, r_MmaAccumulatorHalf2WordAtPtx337R1499,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx338R1500,
		  r_MmaAccumulatorHalf2WordAtPtx337R1499); // PTX L602
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx336R1498, r_MmaAccumulatorHalf2WordAtPtx335R1497,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx336R1498,
		  r_MmaAccumulatorHalf2WordAtPtx335R1497); // PTX L609
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx334R1496, r_MmaAccumulatorHalf2WordAtPtx333R1495,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx334R1496,
		  r_MmaAccumulatorHalf2WordAtPtx333R1495); // PTX L616
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx332R1494, r_MmaAccumulatorHalf2WordAtPtx331R1493,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx332R1494,
		  r_MmaAccumulatorHalf2WordAtPtx331R1493); // PTX L623
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx330R1492, r_MmaAccumulatorHalf2WordAtPtx329R1491,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx330R1492,
		  r_MmaAccumulatorHalf2WordAtPtx329R1491); // PTX L630
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx328R1490, r_MmaAccumulatorHalf2WordAtPtx327R1489,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx328R1490,
		  r_MmaAccumulatorHalf2WordAtPtx327R1489); // PTX L637
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx326R1488, r_MmaAccumulatorHalf2WordAtPtx325R1487,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx326R1488,
		  r_MmaAccumulatorHalf2WordAtPtx325R1487); // PTX L644
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx324R1486, r_MmaAccumulatorHalf2WordAtPtx323R1485,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx324R1486,
		  r_MmaAccumulatorHalf2WordAtPtx323R1485); // PTX L651
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx322R1484, r_MmaAccumulatorHalf2WordAtPtx321R1483,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx322R1484,
		  r_MmaAccumulatorHalf2WordAtPtx321R1483); // PTX L658
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx320R1482, r_MmaAccumulatorHalf2WordAtPtx319R1481,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx320R1482,
		  r_MmaAccumulatorHalf2WordAtPtx319R1481); // PTX L665
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx318R1480, r_MmaAccumulatorHalf2WordAtPtx317R1479,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx318R1480,
		  r_MmaAccumulatorHalf2WordAtPtx317R1479); // PTX L672
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx316R1478, r_MmaAccumulatorHalf2WordAtPtx315R1477,
		  r_MmaAE4x4WordAtPtx422R149, r_MmaAE4x4WordAtPtx422R150, r_MmaAE4x4WordAtPtx422R151,
		  r_MmaAE4x4WordAtPtx422R152, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx316R1478,
		  r_MmaAccumulatorHalf2WordAtPtx315R1477); // PTX L679
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx314R1476, r_MmaAccumulatorHalf2WordAtPtx313R1475,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx314R1476,
		  r_MmaAccumulatorHalf2WordAtPtx313R1475); // PTX L686
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx312R1474, r_MmaAccumulatorHalf2WordAtPtx311R1473,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx312R1474,
		  r_MmaAccumulatorHalf2WordAtPtx311R1473); // PTX L693
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx310R1472, r_MmaAccumulatorHalf2WordAtPtx309R1471,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx310R1472,
		  r_MmaAccumulatorHalf2WordAtPtx309R1471); // PTX L700
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx308R1470, r_MmaAccumulatorHalf2WordAtPtx307R1469,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx308R1470,
		  r_MmaAccumulatorHalf2WordAtPtx307R1469); // PTX L707
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx306R1468, r_MmaAccumulatorHalf2WordAtPtx305R1467,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx306R1468,
		  r_MmaAccumulatorHalf2WordAtPtx305R1467); // PTX L714
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx304R1466, r_MmaAccumulatorHalf2WordAtPtx303R1465,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx304R1466,
		  r_MmaAccumulatorHalf2WordAtPtx303R1465); // PTX L721
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx302R1464, r_MmaAccumulatorHalf2WordAtPtx301R1463,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx302R1464,
		  r_MmaAccumulatorHalf2WordAtPtx301R1463); // PTX L728
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx300R1462, r_MmaAccumulatorHalf2WordAtPtx299R1461,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx300R1462,
		  r_MmaAccumulatorHalf2WordAtPtx299R1461); // PTX L735
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx298R1460, r_MmaAccumulatorHalf2WordAtPtx297R1459,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx298R1460,
		  r_MmaAccumulatorHalf2WordAtPtx297R1459); // PTX L742
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx296R1458, r_MmaAccumulatorHalf2WordAtPtx295R1457,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx296R1458,
		  r_MmaAccumulatorHalf2WordAtPtx295R1457); // PTX L749
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx294R1456, r_MmaAccumulatorHalf2WordAtPtx293R1455,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx294R1456,
		  r_MmaAccumulatorHalf2WordAtPtx293R1455); // PTX L756
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx292R1454, r_MmaAccumulatorHalf2WordAtPtx291R1453,
		  r_MmaAE4x4WordAtPtx431R153, r_MmaAE4x4WordAtPtx431R154, r_MmaAE4x4WordAtPtx431R155,
		  r_MmaAE4x4WordAtPtx431R156, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx292R1454,
		  r_MmaAccumulatorHalf2WordAtPtx291R1453);								// PTX L763
	r_PtxRegister171 = r_PtxRegister160 ^ 4096;									// PTX L769
	r_PtxRegister24 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister22);	// PTX L770
	r_bPtxPredicate13 = uint32_t(r_PtxRegister158) == uint32_t(0);				// PTX L771
	r_PtxRegister172 = uint32_t(8192u /* original named shared base */);		// PTX L772
	r_PtxRegister173 = uint32_t(r_PtxRegister172) + uint32_t(8);				// PTX L773
	r_PtxRegister196 = r_bPtxPredicate13 ? r_PtxRegister173 : r_PtxRegister172; // PTX L774
	r_PtxRegister174 = ShiftLeft(uint32_t(r_PtxRegister24), uint32_t(2));		// PTX L775
	r_PtxRegister25 = uint32_t(r_PtxRegister15) + uint32_t(r_PtxRegister174);	// PTX L776
	r_PtxRegister26 = r_bPtxPredicate12 ? r_PtxRegister25 : 0;					// PTX L777
	r_PtxRegister27 = uint32_t(r_PtxRegister111) + uint32_t(r_PtxRegister171);	// PTX L778
	if (r_bPtxPredicate11)
	{
		goto L__BB50_18;
	} // PTX L779
	r_PtxRegister182 = uint32_t(-1);							   // PTX L780
	r_PtxRegister181 = Elected(r_PtxRegister182);				   // PTX L782
	r_bPtxPredicate14 = uint32_t(r_PtxRegister181) == uint32_t(0); // PTX L788
	if (r_bPtxPredicate14)
	{
		goto L__BB50_19;
	} // PTX L789
	r_PtxU64Register82 = uint64_t(int64_t(int32_t(r_PtxRegister26)) * int64_t(int32_t(4))); // PTX L790
	g_StateByteAddressAtPtx791 =
		uint64_t(g_StateByteAddressAtPtx286) + uint64_t(r_PtxU64Register82); // PTX L791
	r_PtxRegister183 = uint32_t(512);										 // PTX L792
	CopyBulk(s_SharedStorage, r_PtxRegister27, g_StateByteAddressAtPtx791, r_PtxRegister183,
			 r_PtxRegister196);																  // PTX L794
	BarrierExpect(s_SharedStorage, r_PtxRegister196, r_PtxRegister183);						  // PTX L797
	goto L__BB50_19;																		  // PTX L799
L__BB50_18:																					  // PTX L800
	r_PtxRegister175 = uint32_t(0);															  // PTX L801
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister175))); // PTX L803
	r_PackedHalf2AtPtx806R176 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);		  // PTX L806
	r_ConvertedE4PairAtPtx808Rs6 = PublishE4(r_PackedHalf2AtPtx806R176);					  // PTX L808
	r_PackedE4WordAtPtx810R179 =
		JoinHalfwords(r_ConvertedE4PairAtPtx808Rs6, r_ConvertedE4PairAtPtx808Rs6); // PTX L810
	r_LaneIndexAtPtx812 = uint32_t((threadIdx.x & 31u));						   // PTX L812
	r_PtxRegister180 = ShiftLeft(uint32_t(r_LaneIndexAtPtx812), uint32_t(4));	   // PTX L814
	r_PtxRegister178 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister180);	   // PTX L815
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister178)) =
		make_uint4(r_PackedE4WordAtPtx810R179, r_PackedE4WordAtPtx810R179, r_PackedE4WordAtPtx810R179,
				   r_PackedE4WordAtPtx810R179);									// PTX L817
L__BB50_19:																		// PTX L819
	r_bPtxPredicate15 = int32_t(r_PtxRegister18) >= int32_t(r_PtxRegister1452); // PTX L820
	r_bPtxPredicate16 = int32_t(r_PtxRegister18) < int32_t(r_PtxRegister1452);	// PTX L821
	r_PtxRegister184 = uint32_t(r_PtxRegister25) + uint32_t(16384);				// PTX L822
	r_PtxRegister28 = r_bPtxPredicate16 ? r_PtxRegister184 : 0;					// PTX L823
	if (r_bPtxPredicate15)
	{
		goto L__BB50_22;
	} // PTX L824
	r_PtxRegister193 = uint32_t(-1);							   // PTX L825
	r_PtxRegister192 = Elected(r_PtxRegister193);				   // PTX L827
	r_bPtxPredicate17 = uint32_t(r_PtxRegister192) == uint32_t(0); // PTX L833
	if (r_bPtxPredicate17)
	{
		goto L__BB50_23;
	} // PTX L834
	r_PtxRegister194 = uint32_t(r_PtxRegister27) + uint32_t(2048);							// PTX L835
	r_PtxU64Register84 = uint64_t(int64_t(int32_t(r_PtxRegister28)) * int64_t(int32_t(4))); // PTX L836
	g_StateByteAddressAtPtx837 =
		uint64_t(g_StateByteAddressAtPtx286) + uint64_t(r_PtxU64Register84); // PTX L837
	r_PtxRegister195 = uint32_t(512);										 // PTX L838
	CopyBulk(s_SharedStorage, r_PtxRegister194, g_StateByteAddressAtPtx837, r_PtxRegister195,
			 r_PtxRegister196);																  // PTX L840
	BarrierExpect(s_SharedStorage, r_PtxRegister196, r_PtxRegister195);						  // PTX L843
	goto L__BB50_23;																		  // PTX L845
L__BB50_22:																					  // PTX L846
	r_PtxRegister185 = uint32_t(0);															  // PTX L847
	r_PtxU16Register7 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister185))); // PTX L849
	r_PackedHalf2AtPtx852R186 = JoinHalfwords(r_PtxU16Register7, r_PtxU16Register7);		  // PTX L852
	r_ConvertedE4PairAtPtx854Rs8 = PublishE4(r_PackedHalf2AtPtx852R186);					  // PTX L854
	r_PackedE4WordAtPtx856R189 =
		JoinHalfwords(r_ConvertedE4PairAtPtx854Rs8, r_ConvertedE4PairAtPtx854Rs8); // PTX L856
	r_LaneIndexAtPtx858 = uint32_t((threadIdx.x & 31u));						   // PTX L858
	r_PtxRegister190 = ShiftLeft(uint32_t(r_LaneIndexAtPtx858), uint32_t(4));	   // PTX L860
	r_PtxRegister191 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister190);	   // PTX L861
	r_PtxRegister188 = uint32_t(r_PtxRegister191) + uint32_t(2048);				   // PTX L862
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister188)) =
		make_uint4(r_PackedE4WordAtPtx856R189, r_PackedE4WordAtPtx856R189, r_PackedE4WordAtPtx856R189,
				   r_PackedE4WordAtPtx856R189);													 // PTX L864
L__BB50_23:																						 // PTX L866
	r_PtxRegister204 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(5));						 // PTX L867
	r_PtxRegister205 = uint32_t(r_PtxRegister204) * uint32_t(192);								 // PTX L868
	r_PtxRegister206 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister8);					 // PTX L869
	r_PtxRegister207 = ShiftLeft(uint32_t(r_PtxRegister206), uint32_t(7));						 // PTX L870
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister207)) * int64_t(int32_t(4)));	 // PTX L871
	g_RecordByteAddressAtPtx872 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register91);	 // PTX L872
	r_LaneIndexAtPtx874 = uint32_t((threadIdx.x & 31u));										 // PTX L874
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx874)) * int64_t(int32_t(16))); // PTX L876
	g_RecordByteAddressAtPtx877 =
		uint64_t(g_RecordByteAddressAtPtx872) + uint64_t(r_PtxU64Register93);			 // PTX L877
	g_RecordByteAddressAtPtx878 = uint64_t(g_RecordByteAddressAtPtx877) + uint64_t(128); // PTX L878
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx878));
		r_MmaBE4x4WordAtPtx88R1555 = r_Value.x;
		r_MmaBE4x4WordAtPtx88R1556 = r_Value.y;
		r_MmaBE4x4WordAtPtx88R1557 = r_Value.z;
		r_MmaBE4x4WordAtPtx88R1558 = r_Value.w;
	} // PTX L880
	r_PtxRegister208 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister9);					 // PTX L882
	r_PtxRegister209 = ShiftLeft(uint32_t(r_PtxRegister208), uint32_t(7));						 // PTX L883
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister209)) * int64_t(int32_t(4)));	 // PTX L884
	g_RecordByteAddressAtPtx885 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register95);	 // PTX L885
	r_LaneIndexAtPtx887 = uint32_t((threadIdx.x & 31u));										 // PTX L887
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx887)) * int64_t(int32_t(16))); // PTX L889
	g_RecordByteAddressAtPtx890 =
		uint64_t(g_RecordByteAddressAtPtx885) + uint64_t(r_PtxU64Register97);			 // PTX L890
	g_RecordByteAddressAtPtx891 = uint64_t(g_RecordByteAddressAtPtx890) + uint64_t(128); // PTX L891
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx891));
		r_MmaBE4x4WordAtPtx103R1559 = r_Value.x;
		r_MmaBE4x4WordAtPtx103R1560 = r_Value.y;
		r_MmaBE4x4WordAtPtx103R1561 = r_Value.z;
		r_MmaBE4x4WordAtPtx103R1562 = r_Value.w;
	} // PTX L893
	r_PtxRegister210 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister10);					  // PTX L895
	r_PtxRegister211 = ShiftLeft(uint32_t(r_PtxRegister210), uint32_t(7));						  // PTX L896
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister211)) * int64_t(int32_t(4)));	  // PTX L897
	g_RecordByteAddressAtPtx898 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register99);	  // PTX L898
	r_LaneIndexAtPtx900 = uint32_t((threadIdx.x & 31u));										  // PTX L900
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx900)) * int64_t(int32_t(16))); // PTX L902
	g_RecordByteAddressAtPtx903 =
		uint64_t(g_RecordByteAddressAtPtx898) + uint64_t(r_PtxU64Register101);			 // PTX L903
	g_RecordByteAddressAtPtx904 = uint64_t(g_RecordByteAddressAtPtx903) + uint64_t(128); // PTX L904
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx904));
		r_MmaBE4x4WordAtPtx118R1563 = r_Value.x;
		r_MmaBE4x4WordAtPtx118R1564 = r_Value.y;
		r_MmaBE4x4WordAtPtx118R1565 = r_Value.z;
		r_MmaBE4x4WordAtPtx118R1566 = r_Value.w;
	} // PTX L906
	r_PtxRegister212 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister11);					  // PTX L908
	r_PtxRegister213 = ShiftLeft(uint32_t(r_PtxRegister212), uint32_t(7));						  // PTX L909
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister213)) * int64_t(int32_t(4)));	  // PTX L910
	g_RecordByteAddressAtPtx911 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register103);  // PTX L911
	r_LaneIndexAtPtx913 = uint32_t((threadIdx.x & 31u));										  // PTX L913
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx913)) * int64_t(int32_t(16))); // PTX L915
	g_RecordByteAddressAtPtx916 =
		uint64_t(g_RecordByteAddressAtPtx911) + uint64_t(r_PtxU64Register105);			 // PTX L916
	g_RecordByteAddressAtPtx917 = uint64_t(g_RecordByteAddressAtPtx916) + uint64_t(128); // PTX L917
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx917));
		r_MmaBE4x4WordAtPtx133R1567 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R1568 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R1569 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R1570 = r_Value.w;
	} // PTX L919
	r_PtxRegister214 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister12);					  // PTX L921
	r_PtxRegister215 = ShiftLeft(uint32_t(r_PtxRegister214), uint32_t(7));						  // PTX L922
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister215)) * int64_t(int32_t(4)));	  // PTX L923
	g_RecordByteAddressAtPtx924 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register107);  // PTX L924
	r_LaneIndexAtPtx926 = uint32_t((threadIdx.x & 31u));										  // PTX L926
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx926)) * int64_t(int32_t(16))); // PTX L928
	g_RecordByteAddressAtPtx929 =
		uint64_t(g_RecordByteAddressAtPtx924) + uint64_t(r_PtxU64Register109);			 // PTX L929
	g_RecordByteAddressAtPtx930 = uint64_t(g_RecordByteAddressAtPtx929) + uint64_t(128); // PTX L930
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx930));
		r_MmaBE4x4WordAtPtx148R1571 = r_Value.x;
		r_MmaBE4x4WordAtPtx148R1572 = r_Value.y;
		r_MmaBE4x4WordAtPtx148R1573 = r_Value.z;
		r_MmaBE4x4WordAtPtx148R1554 = r_Value.w;
	} // PTX L932
	r_PtxRegister216 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister13);					  // PTX L934
	r_PtxRegister217 = ShiftLeft(uint32_t(r_PtxRegister216), uint32_t(7));						  // PTX L935
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister217)) * int64_t(int32_t(4)));	  // PTX L936
	g_RecordByteAddressAtPtx937 = uint64_t(g_RecordBaseAddress) + uint64_t(r_PtxU64Register111);  // PTX L937
	r_LaneIndexAtPtx939 = uint32_t((threadIdx.x & 31u));										  // PTX L939
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx939)) * int64_t(int32_t(16))); // PTX L941
	g_RecordByteAddressAtPtx942 =
		uint64_t(g_RecordByteAddressAtPtx937) + uint64_t(r_PtxU64Register113);			 // PTX L942
	g_RecordByteAddressAtPtx943 = uint64_t(g_RecordByteAddressAtPtx942) + uint64_t(128); // PTX L943
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_RecordByteAddressAtPtx943));
		r_MmaBE4x4WordAtPtx163R1553 = r_Value.x;
		r_MmaBE4x4WordAtPtx163R1552 = r_Value.y;
		r_MmaBE4x4WordAtPtx163R1551 = r_Value.z;
		r_MmaBE4x4WordAtPtx163R1550 = r_Value.w;
	} // PTX L945
	r_PtxRegister203 = uint32_t(1);															  // PTX L947
	r_PtxU64Register115 = BarrierArrive(s_SharedStorage, r_PtxRegister196, r_PtxRegister203); // PTX L949
L__BB50_24:																					  // PTX L951
	r_PtxRegister218 = BarrierReady(s_SharedStorage, r_PtxRegister196, r_PtxU64Register115);  // PTX L953
	r_bPtxPredicate18 = uint32_t(r_PtxRegister218) == uint32_t(0);							  // PTX L959
	if (r_bPtxPredicate18)
	{
		goto L__BB50_24;
	} // PTX L960
	r_bPtxPredicate19 = uint32_t(r_PtxRegister1549) < uint32_t(448); // PTX L961
	r_PtxRegister1549 = uint32_t(r_PtxRegister23);					 // PTX L962
	if (r_bPtxPredicate19)
	{
		goto L__BB50_15;
	} // PTX L963
	r_PtxRegister29 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(6));			// PTX L964
	r_LaneIndexAtPtx966 = uint32_t((threadIdx.x & 31u));						// PTX L966
	r_PtxRegister339 = uint32_t(0u /* original named shared base */);			// PTX L968
	r_PtxRegister340 = uint32_t(r_PtxRegister339) + uint32_t(r_PtxRegister21);	// PTX L969
	r_PtxRegister341 = ShiftLeft(uint32_t(r_LaneIndexAtPtx966), uint32_t(4));	// PTX L970
	r_PtxRegister342 = uint32_t(r_PtxRegister340) + uint32_t(r_PtxRegister341); // PTX L971
	r_PtxRegister220 = uint32_t(r_PtxRegister342) + uint32_t(4096);				// PTX L972
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister220));
		r_MmaAE4x4WordAtPtx974R229 = r_Value.x;
		r_MmaAE4x4WordAtPtx974R230 = r_Value.y;
		r_MmaAE4x4WordAtPtx974R231 = r_Value.z;
		r_MmaAE4x4WordAtPtx974R232 = r_Value.w;
	} // PTX L974
	r_LaneIndexAtPtx977 = uint32_t((threadIdx.x & 31u));						// PTX L977
	r_PtxRegister343 = ShiftLeft(uint32_t(r_LaneIndexAtPtx977), uint32_t(4));	// PTX L979
	r_PtxRegister344 = uint32_t(r_PtxRegister340) + uint32_t(r_PtxRegister343); // PTX L980
	r_PtxRegister222 = uint32_t(r_PtxRegister344) + uint32_t(4608);				// PTX L981
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister222));
		r_MmaAE4x4WordAtPtx983R257 = r_Value.x;
		r_MmaAE4x4WordAtPtx983R258 = r_Value.y;
		r_MmaAE4x4WordAtPtx983R259 = r_Value.z;
		r_MmaAE4x4WordAtPtx983R260 = r_Value.w;
	} // PTX L983
	r_LaneIndexAtPtx986 = uint32_t((threadIdx.x & 31u));						// PTX L986
	r_PtxRegister345 = ShiftLeft(uint32_t(r_LaneIndexAtPtx986), uint32_t(4));	// PTX L988
	r_PtxRegister346 = uint32_t(r_PtxRegister340) + uint32_t(r_PtxRegister345); // PTX L989
	r_PtxRegister224 = uint32_t(r_PtxRegister346) + uint32_t(5120);				// PTX L990
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister224));
		r_MmaAE4x4WordAtPtx992R285 = r_Value.x;
		r_MmaAE4x4WordAtPtx992R286 = r_Value.y;
		r_MmaAE4x4WordAtPtx992R287 = r_Value.z;
		r_MmaAE4x4WordAtPtx992R288 = r_Value.w;
	} // PTX L992
	r_LaneIndexAtPtx995 = uint32_t((threadIdx.x & 31u));						// PTX L995
	r_PtxRegister347 = ShiftLeft(uint32_t(r_LaneIndexAtPtx995), uint32_t(4));	// PTX L997
	r_PtxRegister348 = uint32_t(r_PtxRegister340) + uint32_t(r_PtxRegister347); // PTX L998
	r_PtxRegister226 = uint32_t(r_PtxRegister348) + uint32_t(5632);				// PTX L999
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister226));
		r_MmaAE4x4WordAtPtx1001R313 = r_Value.x;
		r_MmaAE4x4WordAtPtx1001R314 = r_Value.y;
		r_MmaAE4x4WordAtPtx1001R315 = r_Value.z;
		r_MmaAE4x4WordAtPtx1001R316 = r_Value.w;
	} // PTX L1001
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1004R227, r_MmaAccumulatorHalf2WordAtPtx1004R228,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx386R1548,
		  r_MmaAccumulatorHalf2WordAtPtx385R1547); // PTX L1004
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1011R233, r_MmaAccumulatorHalf2WordAtPtx1011R234,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx384R1546,
		  r_MmaAccumulatorHalf2WordAtPtx383R1545); // PTX L1011
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1018R235, r_MmaAccumulatorHalf2WordAtPtx1018R236,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx382R1544,
		  r_MmaAccumulatorHalf2WordAtPtx381R1543); // PTX L1018
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1025R237, r_MmaAccumulatorHalf2WordAtPtx1025R238,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx380R1542,
		  r_MmaAccumulatorHalf2WordAtPtx379R1541); // PTX L1025
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1032R239, r_MmaAccumulatorHalf2WordAtPtx1032R240,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx378R1540,
		  r_MmaAccumulatorHalf2WordAtPtx377R1539); // PTX L1032
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1039R241, r_MmaAccumulatorHalf2WordAtPtx1039R242,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx376R1538,
		  r_MmaAccumulatorHalf2WordAtPtx375R1537); // PTX L1039
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1046R243, r_MmaAccumulatorHalf2WordAtPtx1046R244,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx374R1536,
		  r_MmaAccumulatorHalf2WordAtPtx373R1535); // PTX L1046
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1053R245, r_MmaAccumulatorHalf2WordAtPtx1053R246,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx372R1534,
		  r_MmaAccumulatorHalf2WordAtPtx371R1533); // PTX L1053
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1060R247, r_MmaAccumulatorHalf2WordAtPtx1060R248,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx370R1532,
		  r_MmaAccumulatorHalf2WordAtPtx369R1531); // PTX L1060
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1067R249, r_MmaAccumulatorHalf2WordAtPtx1067R250,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx368R1530,
		  r_MmaAccumulatorHalf2WordAtPtx367R1529); // PTX L1067
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1074R251, r_MmaAccumulatorHalf2WordAtPtx1074R252,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx366R1528,
		  r_MmaAccumulatorHalf2WordAtPtx365R1527); // PTX L1074
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1081R253, r_MmaAccumulatorHalf2WordAtPtx1081R254,
		  r_MmaAE4x4WordAtPtx974R229, r_MmaAE4x4WordAtPtx974R230, r_MmaAE4x4WordAtPtx974R231,
		  r_MmaAE4x4WordAtPtx974R232, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx364R1526,
		  r_MmaAccumulatorHalf2WordAtPtx363R1525); // PTX L1081
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1088R255, r_MmaAccumulatorHalf2WordAtPtx1088R256,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx362R1524,
		  r_MmaAccumulatorHalf2WordAtPtx361R1523); // PTX L1088
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1095R261, r_MmaAccumulatorHalf2WordAtPtx1095R262,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx360R1522,
		  r_MmaAccumulatorHalf2WordAtPtx359R1521); // PTX L1095
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1102R263, r_MmaAccumulatorHalf2WordAtPtx1102R264,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx358R1520,
		  r_MmaAccumulatorHalf2WordAtPtx357R1519); // PTX L1102
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1109R265, r_MmaAccumulatorHalf2WordAtPtx1109R266,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx356R1518,
		  r_MmaAccumulatorHalf2WordAtPtx355R1517); // PTX L1109
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1116R267, r_MmaAccumulatorHalf2WordAtPtx1116R268,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx354R1516,
		  r_MmaAccumulatorHalf2WordAtPtx353R1515); // PTX L1116
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1123R269, r_MmaAccumulatorHalf2WordAtPtx1123R270,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx352R1514,
		  r_MmaAccumulatorHalf2WordAtPtx351R1513); // PTX L1123
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1130R271, r_MmaAccumulatorHalf2WordAtPtx1130R272,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx350R1512,
		  r_MmaAccumulatorHalf2WordAtPtx349R1511); // PTX L1130
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1137R273, r_MmaAccumulatorHalf2WordAtPtx1137R274,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx348R1510,
		  r_MmaAccumulatorHalf2WordAtPtx347R1509); // PTX L1137
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1144R275, r_MmaAccumulatorHalf2WordAtPtx1144R276,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx346R1508,
		  r_MmaAccumulatorHalf2WordAtPtx345R1507); // PTX L1144
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1151R277, r_MmaAccumulatorHalf2WordAtPtx1151R278,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx344R1506,
		  r_MmaAccumulatorHalf2WordAtPtx343R1505); // PTX L1151
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1158R279, r_MmaAccumulatorHalf2WordAtPtx1158R280,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx342R1504,
		  r_MmaAccumulatorHalf2WordAtPtx341R1503); // PTX L1158
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1165R281, r_MmaAccumulatorHalf2WordAtPtx1165R282,
		  r_MmaAE4x4WordAtPtx983R257, r_MmaAE4x4WordAtPtx983R258, r_MmaAE4x4WordAtPtx983R259,
		  r_MmaAE4x4WordAtPtx983R260, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx340R1502,
		  r_MmaAccumulatorHalf2WordAtPtx339R1501); // PTX L1165
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1172R283, r_MmaAccumulatorHalf2WordAtPtx1172R284,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx338R1500,
		  r_MmaAccumulatorHalf2WordAtPtx337R1499); // PTX L1172
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1179R289, r_MmaAccumulatorHalf2WordAtPtx1179R290,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx336R1498,
		  r_MmaAccumulatorHalf2WordAtPtx335R1497); // PTX L1179
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1186R291, r_MmaAccumulatorHalf2WordAtPtx1186R292,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx334R1496,
		  r_MmaAccumulatorHalf2WordAtPtx333R1495); // PTX L1186
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1193R293, r_MmaAccumulatorHalf2WordAtPtx1193R294,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx332R1494,
		  r_MmaAccumulatorHalf2WordAtPtx331R1493); // PTX L1193
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1200R295, r_MmaAccumulatorHalf2WordAtPtx1200R296,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx330R1492,
		  r_MmaAccumulatorHalf2WordAtPtx329R1491); // PTX L1200
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1207R297, r_MmaAccumulatorHalf2WordAtPtx1207R298,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx328R1490,
		  r_MmaAccumulatorHalf2WordAtPtx327R1489); // PTX L1207
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1214R299, r_MmaAccumulatorHalf2WordAtPtx1214R300,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx326R1488,
		  r_MmaAccumulatorHalf2WordAtPtx325R1487); // PTX L1214
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1221R301, r_MmaAccumulatorHalf2WordAtPtx1221R302,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx324R1486,
		  r_MmaAccumulatorHalf2WordAtPtx323R1485); // PTX L1221
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1228R303, r_MmaAccumulatorHalf2WordAtPtx1228R304,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx322R1484,
		  r_MmaAccumulatorHalf2WordAtPtx321R1483); // PTX L1228
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1235R305, r_MmaAccumulatorHalf2WordAtPtx1235R306,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx320R1482,
		  r_MmaAccumulatorHalf2WordAtPtx319R1481); // PTX L1235
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1242R307, r_MmaAccumulatorHalf2WordAtPtx1242R308,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx318R1480,
		  r_MmaAccumulatorHalf2WordAtPtx317R1479); // PTX L1242
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1249R309, r_MmaAccumulatorHalf2WordAtPtx1249R310,
		  r_MmaAE4x4WordAtPtx992R285, r_MmaAE4x4WordAtPtx992R286, r_MmaAE4x4WordAtPtx992R287,
		  r_MmaAE4x4WordAtPtx992R288, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx316R1478,
		  r_MmaAccumulatorHalf2WordAtPtx315R1477); // PTX L1249
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1256R311, r_MmaAccumulatorHalf2WordAtPtx1256R312,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx88R1555, r_MmaBE4x4WordAtPtx88R1556,
		  r_MmaAccumulatorHalf2WordAtPtx314R1476,
		  r_MmaAccumulatorHalf2WordAtPtx313R1475); // PTX L1256
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1263R317, r_MmaAccumulatorHalf2WordAtPtx1263R318,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx88R1557, r_MmaBE4x4WordAtPtx88R1558,
		  r_MmaAccumulatorHalf2WordAtPtx312R1474,
		  r_MmaAccumulatorHalf2WordAtPtx311R1473); // PTX L1263
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1270R319, r_MmaAccumulatorHalf2WordAtPtx1270R320,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx103R1559, r_MmaBE4x4WordAtPtx103R1560,
		  r_MmaAccumulatorHalf2WordAtPtx310R1472,
		  r_MmaAccumulatorHalf2WordAtPtx309R1471); // PTX L1270
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1277R321, r_MmaAccumulatorHalf2WordAtPtx1277R322,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx103R1561, r_MmaBE4x4WordAtPtx103R1562,
		  r_MmaAccumulatorHalf2WordAtPtx308R1470,
		  r_MmaAccumulatorHalf2WordAtPtx307R1469); // PTX L1277
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1284R323, r_MmaAccumulatorHalf2WordAtPtx1284R324,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx118R1563, r_MmaBE4x4WordAtPtx118R1564,
		  r_MmaAccumulatorHalf2WordAtPtx306R1468,
		  r_MmaAccumulatorHalf2WordAtPtx305R1467); // PTX L1284
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1291R325, r_MmaAccumulatorHalf2WordAtPtx1291R326,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx118R1565, r_MmaBE4x4WordAtPtx118R1566,
		  r_MmaAccumulatorHalf2WordAtPtx304R1466,
		  r_MmaAccumulatorHalf2WordAtPtx303R1465); // PTX L1291
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1298R327, r_MmaAccumulatorHalf2WordAtPtx1298R328,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx133R1567, r_MmaBE4x4WordAtPtx133R1568,
		  r_MmaAccumulatorHalf2WordAtPtx302R1464,
		  r_MmaAccumulatorHalf2WordAtPtx301R1463); // PTX L1298
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1305R329, r_MmaAccumulatorHalf2WordAtPtx1305R330,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx133R1569, r_MmaBE4x4WordAtPtx133R1570,
		  r_MmaAccumulatorHalf2WordAtPtx300R1462,
		  r_MmaAccumulatorHalf2WordAtPtx299R1461); // PTX L1305
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1312R331, r_MmaAccumulatorHalf2WordAtPtx1312R332,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx148R1571, r_MmaBE4x4WordAtPtx148R1572,
		  r_MmaAccumulatorHalf2WordAtPtx298R1460,
		  r_MmaAccumulatorHalf2WordAtPtx297R1459); // PTX L1312
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1319R333, r_MmaAccumulatorHalf2WordAtPtx1319R334,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx148R1573, r_MmaBE4x4WordAtPtx148R1554,
		  r_MmaAccumulatorHalf2WordAtPtx296R1458,
		  r_MmaAccumulatorHalf2WordAtPtx295R1457); // PTX L1319
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1326R335, r_MmaAccumulatorHalf2WordAtPtx1326R336,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx163R1553, r_MmaBE4x4WordAtPtx163R1552,
		  r_MmaAccumulatorHalf2WordAtPtx294R1456,
		  r_MmaAccumulatorHalf2WordAtPtx293R1455); // PTX L1326
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx1333R337, r_MmaAccumulatorHalf2WordAtPtx1333R338,
		  r_MmaAE4x4WordAtPtx1001R313, r_MmaAE4x4WordAtPtx1001R314, r_MmaAE4x4WordAtPtx1001R315,
		  r_MmaAE4x4WordAtPtx1001R316, r_MmaBE4x4WordAtPtx163R1551, r_MmaBE4x4WordAtPtx163R1550,
		  r_MmaAccumulatorHalf2WordAtPtx292R1454,
		  r_MmaAccumulatorHalf2WordAtPtx291R1453);												 // PTX L1333
	r_PtxRegister349 = ShiftRight(uint32_t(r_PtxRegister59), uint32_t(27));						 // PTX L1339
	r_PtxRegister350 = uint32_t(r_PtxRegister3) + uint32_t(r_PtxRegister349);					 // PTX L1340
	r_PtxRegister351 = r_PtxRegister350 & -32;													 // PTX L1341
	r_PtxRegister30 = uint32_t(r_PtxRegister351) + uint32_t(32);								 // PTX L1342
	r_PtxRegister31 = ShiftRightSigned(int32_t(r_PtxRegister30), uint32_t(4));					 // PTX L1343
	r_bPtxPredicate20 = uint64_t(g_ScratchBaseAddress) == uint64_t(0);							 // PTX L1344
	r_PtxU64Register116 = uint64_t(int64_t(int32_t(r_PtxRegister31)) * int64_t(int32_t(32768))); // PTX L1345
	g_ScratchByteAddressAtPtx1346 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register116);						  // PTX L1346
	r_PtxU64Register4 = r_bPtxPredicate20 ? 0 : g_ScratchByteAddressAtPtx1346;				  // PTX L1347
	r_PtxU64Register118 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register116);		  // PTX L1348
	r_PtxU64Register5 = r_bPtxPredicate20 ? 0 : r_PtxU64Register118;						  // PTX L1349
	r_bPtxPredicate21 = uint32_t(r_CtaZ) == uint32_t(0);									  // PTX L1350
	r_PtxRegister352 = ShiftLeft(uint32_t(r_PtxRegister4), uint32_t(4));					  // PTX L1351
	r_PtxRegister353 = uint32_t(r_PtxRegister352) + uint32_t(r_PtxRegister5);				  // PTX L1352
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister353)) * int64_t(int32_t(4))); // PTX L1353
	g_CounterByteAddress = uint64_t(g_CounterBaseAddress) + uint64_t(r_PtxU64Register119);	  // PTX L1354
	if (r_bPtxPredicate21)
	{
		goto L__BB50_31;
	} // PTX L1355
	r_ThreadZAtPtx1356 = uint32_t(threadIdx.z);					   // PTX L1356
	r_PtxRegister355 = r_PtxRegister66 | r_ThreadZAtPtx1356;	   // PTX L1357
	r_bPtxPredicate22 = uint32_t(r_PtxRegister355) != uint32_t(0); // PTX L1358
	if (r_bPtxPredicate22)
	{
		goto L__BB50_57;
	} // PTX L1359
	goto L__BB50_28;																		  // PTX L1360
L__BB50_57:																					  // PTX L1361
	__syncthreads();																		  // PTX L1362
	r_PtxRegister357 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(5));							  // PTX L1363
	r_PtxRegister358 = r_PtxRegister357 & 32;												  // PTX L1364
	r_PtxRegister33 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister6);					  // PTX L1365
	r_PtxRegister359 = uint32_t(r_PtxRegister358) + uint32_t(r_PtxRegister29);				  // PTX L1366
	r_bPtxPredicate24 = int32_t(r_PtxRegister33) < int32_t(r_PtxRegister31);				  // PTX L1367
	r_PtxRegister34 = ShiftLeft(uint32_t(r_PtxRegister359), uint32_t(3));					  // PTX L1368
	r_PtxRegister360 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(13));					  // PTX L1369
	r_PtxRegister361 = uint32_t(r_PtxRegister360) + uint32_t(r_PtxRegister34);				  // PTX L1370
	r_PtxU64Register120 = uint64_t(int64_t(int32_t(r_PtxRegister361)) * int64_t(int32_t(4))); // PTX L1371
	g_ScratchByteAddressAtPtx1372 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register120);	 // PTX L1372
	r_PackedHalf2AtPtx1373R1574 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1373
	r_PackedHalf2AtPtx1374R1575 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1374
	r_PackedHalf2AtPtx1375R1576 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1375
	r_PackedHalf2AtPtx1376R1577 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1376
	if (r_bPtxPredicate24)
	{
		goto L__BB50_58;
	} // PTX L1377
	goto L__BB50_59;									  // PTX L1378
L__BB50_58:												  // PTX L1379
	r_LaneIndexAtPtx1381 = uint32_t((threadIdx.x & 31u)); // PTX L1381
	r_PtxU64Register122 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1381)) * int64_t(int32_t(16))); // PTX L1383
	g_ScratchByteAddressAtPtx1384 =
		uint64_t(g_ScratchByteAddressAtPtx1372) + uint64_t(r_PtxU64Register122); // PTX L1384
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1384));
		r_PackedHalf2AtPtx1373R1574 = r_Value.x;
		r_PackedHalf2AtPtx1374R1575 = r_Value.y;
		r_PackedHalf2AtPtx1375R1576 = r_Value.z;
		r_PackedHalf2AtPtx1376R1577 = r_Value.w;
	} // PTX L1386
L__BB50_59:																					 // PTX L1388
	r_bPtxPredicate25 = int32_t(r_PtxRegister33) >= int32_t(r_PtxRegister31);				 // PTX L1389
	g_ScratchByteAddressAtPtx1390 = uint64_t(g_ScratchByteAddressAtPtx1372) + uint64_t(512); // PTX L1390
	r_PackedHalf2AtPtx1391R1578 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1391
	r_PackedHalf2AtPtx1392R1579 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1392
	r_PackedHalf2AtPtx1393R1580 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1393
	r_PackedHalf2AtPtx1394R1581 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1394
	if (r_bPtxPredicate25)
	{
		goto L__BB50_61;
	} // PTX L1395
	r_LaneIndexAtPtx1397 = uint32_t((threadIdx.x & 31u)); // PTX L1397
	r_PtxU64Register124 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1397)) * int64_t(int32_t(16))); // PTX L1399
	g_ScratchByteAddressAtPtx1400 =
		uint64_t(g_ScratchByteAddressAtPtx1390) + uint64_t(r_PtxU64Register124); // PTX L1400
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1400));
		r_PackedHalf2AtPtx1391R1578 = r_Value.x;
		r_PackedHalf2AtPtx1392R1579 = r_Value.y;
		r_PackedHalf2AtPtx1393R1580 = r_Value.z;
		r_PackedHalf2AtPtx1394R1581 = r_Value.w;
	} // PTX L1402
L__BB50_61:																					   // PTX L1404
	r_PtxRegister40 = uint32_t(r_PtxRegister33) + uint32_t(1);								   // PTX L1405
	r_bPtxPredicate26 = int32_t(r_PtxRegister40) >= int32_t(r_PtxRegister31);				   // PTX L1406
	g_ScratchByteAddressAtPtx1407 = uint64_t(g_ScratchByteAddressAtPtx1390) + uint64_t(32256); // PTX L1407
	r_PackedHalf2AtPtx1408R1582 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1408
	r_PackedHalf2AtPtx1409R1583 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1409
	r_PackedHalf2AtPtx1410R1584 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1410
	r_PackedHalf2AtPtx1411R1585 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1411
	if (r_bPtxPredicate26)
	{
		goto L__BB50_63;
	} // PTX L1412
	r_LaneIndexAtPtx1414 = uint32_t((threadIdx.x & 31u)); // PTX L1414
	r_PtxU64Register126 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1414)) * int64_t(int32_t(16))); // PTX L1416
	g_ScratchByteAddressAtPtx1417 =
		uint64_t(g_ScratchByteAddressAtPtx1407) + uint64_t(r_PtxU64Register126); // PTX L1417
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1417));
		r_PackedHalf2AtPtx1408R1582 = r_Value.x;
		r_PackedHalf2AtPtx1409R1583 = r_Value.y;
		r_PackedHalf2AtPtx1410R1584 = r_Value.z;
		r_PackedHalf2AtPtx1411R1585 = r_Value.w;
	} // PTX L1419
L__BB50_63:																					 // PTX L1421
	r_bPtxPredicate27 = int32_t(r_PtxRegister40) >= int32_t(r_PtxRegister31);				 // PTX L1422
	g_ScratchByteAddressAtPtx1423 = uint64_t(g_ScratchByteAddressAtPtx1407) + uint64_t(512); // PTX L1423
	r_PackedHalf2AtPtx1424R1586 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1424
	r_PackedHalf2AtPtx1425R1587 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1425
	r_PackedHalf2AtPtx1426R1588 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1426
	r_PackedHalf2AtPtx1427R1589 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1427
	if (r_bPtxPredicate27)
	{
		goto L__BB50_65;
	} // PTX L1428
	r_LaneIndexAtPtx1430 = uint32_t((threadIdx.x & 31u)); // PTX L1430
	r_PtxU64Register128 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1430)) * int64_t(int32_t(16))); // PTX L1432
	g_ScratchByteAddressAtPtx1433 =
		uint64_t(g_ScratchByteAddressAtPtx1423) + uint64_t(r_PtxU64Register128); // PTX L1433
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1433));
		r_PackedHalf2AtPtx1424R1586 = r_Value.x;
		r_PackedHalf2AtPtx1425R1587 = r_Value.y;
		r_PackedHalf2AtPtx1426R1588 = r_Value.z;
		r_PackedHalf2AtPtx1427R1589 = r_Value.w;
	} // PTX L1435
L__BB50_65:																					   // PTX L1437
	r_PtxRegister41 = uint32_t(r_PtxRegister33) + uint32_t(2);								   // PTX L1438
	r_bPtxPredicate28 = int32_t(r_PtxRegister41) >= int32_t(r_PtxRegister31);				   // PTX L1439
	g_ScratchByteAddressAtPtx1440 = uint64_t(g_ScratchByteAddressAtPtx1423) + uint64_t(32256); // PTX L1440
	r_PackedHalf2AtPtx1441R1590 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1441
	r_PackedHalf2AtPtx1442R1591 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1442
	r_PackedHalf2AtPtx1443R1592 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1443
	r_PackedHalf2AtPtx1444R1593 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1444
	if (r_bPtxPredicate28)
	{
		goto L__BB50_67;
	} // PTX L1445
	r_LaneIndexAtPtx1447 = uint32_t((threadIdx.x & 31u)); // PTX L1447
	r_PtxU64Register130 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1447)) * int64_t(int32_t(16))); // PTX L1449
	g_ScratchByteAddressAtPtx1450 =
		uint64_t(g_ScratchByteAddressAtPtx1440) + uint64_t(r_PtxU64Register130); // PTX L1450
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1450));
		r_PackedHalf2AtPtx1441R1590 = r_Value.x;
		r_PackedHalf2AtPtx1442R1591 = r_Value.y;
		r_PackedHalf2AtPtx1443R1592 = r_Value.z;
		r_PackedHalf2AtPtx1444R1593 = r_Value.w;
	} // PTX L1452
L__BB50_67:																					 // PTX L1454
	g_ScratchByteAddressAtPtx1455 = uint64_t(g_ScratchByteAddressAtPtx1440) + uint64_t(512); // PTX L1455
	r_PackedHalf2AtPtx1456R1594 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1456
	r_PackedHalf2AtPtx1457R1595 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1457
	r_PackedHalf2AtPtx1458R1596 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1458
	r_PackedHalf2AtPtx1459R1597 = uint32_t(r_PackedHalf2AtPtx5219R1666);					 // PTX L1459
	if (r_bPtxPredicate28)
	{
		goto L__BB50_69;
	} // PTX L1460
	r_LaneIndexAtPtx1462 = uint32_t((threadIdx.x & 31u)); // PTX L1462
	r_PtxU64Register132 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1462)) * int64_t(int32_t(16))); // PTX L1464
	g_ScratchByteAddressAtPtx1465 =
		uint64_t(g_ScratchByteAddressAtPtx1455) + uint64_t(r_PtxU64Register132); // PTX L1465
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1465));
		r_PackedHalf2AtPtx1456R1594 = r_Value.x;
		r_PackedHalf2AtPtx1457R1595 = r_Value.y;
		r_PackedHalf2AtPtx1458R1596 = r_Value.z;
		r_PackedHalf2AtPtx1459R1597 = r_Value.w;
	} // PTX L1467
L__BB50_69:																					   // PTX L1469
	r_PtxRegister42 = uint32_t(r_PtxRegister33) + uint32_t(3);								   // PTX L1470
	r_bPtxPredicate29 = int32_t(r_PtxRegister42) >= int32_t(r_PtxRegister31);				   // PTX L1471
	g_ScratchByteAddressAtPtx1472 = uint64_t(g_ScratchByteAddressAtPtx1455) + uint64_t(32256); // PTX L1472
	r_PackedHalf2AtPtx1473R1598 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1473
	r_PackedHalf2AtPtx1474R1599 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1474
	r_PackedHalf2AtPtx1475R1600 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1475
	r_PackedHalf2AtPtx1476R1601 = uint32_t(r_PackedHalf2AtPtx5219R1666);					   // PTX L1476
	if (r_bPtxPredicate29)
	{
		goto L__BB50_71;
	} // PTX L1477
	r_LaneIndexAtPtx1479 = uint32_t((threadIdx.x & 31u)); // PTX L1479
	r_PtxU64Register134 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1479)) * int64_t(int32_t(16))); // PTX L1481
	g_ScratchByteAddressAtPtx1482 =
		uint64_t(g_ScratchByteAddressAtPtx1472) + uint64_t(r_PtxU64Register134); // PTX L1482
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1482));
		r_PackedHalf2AtPtx1473R1598 = r_Value.x;
		r_PackedHalf2AtPtx1474R1599 = r_Value.y;
		r_PackedHalf2AtPtx1475R1600 = r_Value.z;
		r_PackedHalf2AtPtx1476R1601 = r_Value.w;
	} // PTX L1484
L__BB50_71:																 // PTX L1486
	r_PackedHalf2AtPtx1487R1602 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1487
	r_PackedHalf2AtPtx1488R1603 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1488
	r_PackedHalf2AtPtx1489R1604 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1489
	r_PackedHalf2AtPtx1490R1605 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L1490
	if (r_bPtxPredicate29)
	{
		goto L__BB50_73;
	} // PTX L1491
	r_LaneIndexAtPtx1493 = uint32_t((threadIdx.x & 31u)); // PTX L1493
	r_PtxU64Register136 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1493)) * int64_t(int32_t(16))); // PTX L1495
	g_ScratchByteAddressAtPtx1496 =
		uint64_t(g_ScratchByteAddressAtPtx1472) + uint64_t(r_PtxU64Register136);			 // PTX L1496
	g_ScratchByteAddressAtPtx1497 = uint64_t(g_ScratchByteAddressAtPtx1496) + uint64_t(512); // PTX L1497
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(g_ScratchByteAddressAtPtx1497));
		r_PackedHalf2AtPtx1487R1602 = r_Value.x;
		r_PackedHalf2AtPtx1488R1603 = r_Value.y;
		r_PackedHalf2AtPtx1489R1604 = r_Value.z;
		r_PackedHalf2AtPtx1490R1605 = r_Value.w;
	} // PTX L1499
L__BB50_73:												  // PTX L1501
	r_LaneIndexAtPtx1503 = uint32_t((threadIdx.x & 31u)); // PTX L1503
	r_PackedHalf2AtPtx1506R403 =
		HalfAdd(r_PackedHalf2AtPtx1373R1574, r_MmaAccumulatorHalf2WordAtPtx1004R227); // PTX L1506
	r_LaneIndexAtPtx1510 = uint32_t((threadIdx.x & 31u));							  // PTX L1510
	r_PackedHalf2AtPtx1513R405 =
		HalfAdd(r_PackedHalf2AtPtx1374R1575, r_MmaAccumulatorHalf2WordAtPtx1004R228); // PTX L1513
	r_LaneIndexAtPtx1517 = uint32_t((threadIdx.x & 31u));							  // PTX L1517
	r_PackedHalf2AtPtx1520R407 =
		HalfAdd(r_PackedHalf2AtPtx1375R1576, r_MmaAccumulatorHalf2WordAtPtx1011R233); // PTX L1520
	r_LaneIndexAtPtx1524 = uint32_t((threadIdx.x & 31u));							  // PTX L1524
	r_PackedHalf2AtPtx1527R409 =
		HalfAdd(r_PackedHalf2AtPtx1376R1577, r_MmaAccumulatorHalf2WordAtPtx1011R234); // PTX L1527
	r_LaneIndexAtPtx1531 = uint32_t((threadIdx.x & 31u));							  // PTX L1531
	r_PackedHalf2AtPtx1534R411 =
		HalfAdd(r_PackedHalf2AtPtx1391R1578, r_MmaAccumulatorHalf2WordAtPtx1018R235); // PTX L1534
	r_LaneIndexAtPtx1538 = uint32_t((threadIdx.x & 31u));							  // PTX L1538
	r_PackedHalf2AtPtx1541R413 =
		HalfAdd(r_PackedHalf2AtPtx1392R1579, r_MmaAccumulatorHalf2WordAtPtx1018R236); // PTX L1541
	r_LaneIndexAtPtx1545 = uint32_t((threadIdx.x & 31u));							  // PTX L1545
	r_PackedHalf2AtPtx1548R415 =
		HalfAdd(r_PackedHalf2AtPtx1393R1580, r_MmaAccumulatorHalf2WordAtPtx1025R237); // PTX L1548
	r_LaneIndexAtPtx1552 = uint32_t((threadIdx.x & 31u));							  // PTX L1552
	r_PackedHalf2AtPtx1555R417 =
		HalfAdd(r_PackedHalf2AtPtx1394R1581, r_MmaAccumulatorHalf2WordAtPtx1025R238); // PTX L1555
	r_LaneIndexAtPtx1559 = uint32_t((threadIdx.x & 31u));							  // PTX L1559
	r_PackedHalf2AtPtx1562R419 =
		HalfAdd(r_PackedHalf2AtPtx1408R1582, r_MmaAccumulatorHalf2WordAtPtx1088R255); // PTX L1562
	r_LaneIndexAtPtx1566 = uint32_t((threadIdx.x & 31u));							  // PTX L1566
	r_PackedHalf2AtPtx1569R421 =
		HalfAdd(r_PackedHalf2AtPtx1409R1583, r_MmaAccumulatorHalf2WordAtPtx1088R256); // PTX L1569
	r_LaneIndexAtPtx1573 = uint32_t((threadIdx.x & 31u));							  // PTX L1573
	r_PackedHalf2AtPtx1576R423 =
		HalfAdd(r_PackedHalf2AtPtx1410R1584, r_MmaAccumulatorHalf2WordAtPtx1095R261); // PTX L1576
	r_LaneIndexAtPtx1580 = uint32_t((threadIdx.x & 31u));							  // PTX L1580
	r_PackedHalf2AtPtx1583R425 =
		HalfAdd(r_PackedHalf2AtPtx1411R1585, r_MmaAccumulatorHalf2WordAtPtx1095R262); // PTX L1583
	r_LaneIndexAtPtx1587 = uint32_t((threadIdx.x & 31u));							  // PTX L1587
	r_PackedHalf2AtPtx1590R427 =
		HalfAdd(r_PackedHalf2AtPtx1424R1586, r_MmaAccumulatorHalf2WordAtPtx1102R263); // PTX L1590
	r_LaneIndexAtPtx1594 = uint32_t((threadIdx.x & 31u));							  // PTX L1594
	r_PackedHalf2AtPtx1597R429 =
		HalfAdd(r_PackedHalf2AtPtx1425R1587, r_MmaAccumulatorHalf2WordAtPtx1102R264); // PTX L1597
	r_LaneIndexAtPtx1601 = uint32_t((threadIdx.x & 31u));							  // PTX L1601
	r_PackedHalf2AtPtx1604R431 =
		HalfAdd(r_PackedHalf2AtPtx1426R1588, r_MmaAccumulatorHalf2WordAtPtx1109R265); // PTX L1604
	r_LaneIndexAtPtx1608 = uint32_t((threadIdx.x & 31u));							  // PTX L1608
	r_PackedHalf2AtPtx1611R433 =
		HalfAdd(r_PackedHalf2AtPtx1427R1589, r_MmaAccumulatorHalf2WordAtPtx1109R266); // PTX L1611
	r_LaneIndexAtPtx1615 = uint32_t((threadIdx.x & 31u));							  // PTX L1615
	r_PackedHalf2AtPtx1618R435 =
		HalfAdd(r_PackedHalf2AtPtx1441R1590, r_MmaAccumulatorHalf2WordAtPtx1172R283); // PTX L1618
	r_LaneIndexAtPtx1622 = uint32_t((threadIdx.x & 31u));							  // PTX L1622
	r_PackedHalf2AtPtx1625R437 =
		HalfAdd(r_PackedHalf2AtPtx1442R1591, r_MmaAccumulatorHalf2WordAtPtx1172R284); // PTX L1625
	r_LaneIndexAtPtx1629 = uint32_t((threadIdx.x & 31u));							  // PTX L1629
	r_PackedHalf2AtPtx1632R439 =
		HalfAdd(r_PackedHalf2AtPtx1443R1592, r_MmaAccumulatorHalf2WordAtPtx1179R289); // PTX L1632
	r_LaneIndexAtPtx1636 = uint32_t((threadIdx.x & 31u));							  // PTX L1636
	r_PackedHalf2AtPtx1639R441 =
		HalfAdd(r_PackedHalf2AtPtx1444R1593, r_MmaAccumulatorHalf2WordAtPtx1179R290); // PTX L1639
	r_LaneIndexAtPtx1643 = uint32_t((threadIdx.x & 31u));							  // PTX L1643
	r_PackedHalf2AtPtx1646R443 =
		HalfAdd(r_PackedHalf2AtPtx1456R1594, r_MmaAccumulatorHalf2WordAtPtx1186R291); // PTX L1646
	r_LaneIndexAtPtx1650 = uint32_t((threadIdx.x & 31u));							  // PTX L1650
	r_PackedHalf2AtPtx1653R445 =
		HalfAdd(r_PackedHalf2AtPtx1457R1595, r_MmaAccumulatorHalf2WordAtPtx1186R292); // PTX L1653
	r_LaneIndexAtPtx1657 = uint32_t((threadIdx.x & 31u));							  // PTX L1657
	r_PackedHalf2AtPtx1660R447 =
		HalfAdd(r_PackedHalf2AtPtx1458R1596, r_MmaAccumulatorHalf2WordAtPtx1193R293); // PTX L1660
	r_LaneIndexAtPtx1664 = uint32_t((threadIdx.x & 31u));							  // PTX L1664
	r_PackedHalf2AtPtx1667R449 =
		HalfAdd(r_PackedHalf2AtPtx1459R1597, r_MmaAccumulatorHalf2WordAtPtx1193R294); // PTX L1667
	r_LaneIndexAtPtx1671 = uint32_t((threadIdx.x & 31u));							  // PTX L1671
	r_PackedHalf2AtPtx1674R451 =
		HalfAdd(r_PackedHalf2AtPtx1473R1598, r_MmaAccumulatorHalf2WordAtPtx1256R311); // PTX L1674
	r_LaneIndexAtPtx1678 = uint32_t((threadIdx.x & 31u));							  // PTX L1678
	r_PackedHalf2AtPtx1681R453 =
		HalfAdd(r_PackedHalf2AtPtx1474R1599, r_MmaAccumulatorHalf2WordAtPtx1256R312); // PTX L1681
	r_LaneIndexAtPtx1685 = uint32_t((threadIdx.x & 31u));							  // PTX L1685
	r_PackedHalf2AtPtx1688R455 =
		HalfAdd(r_PackedHalf2AtPtx1475R1600, r_MmaAccumulatorHalf2WordAtPtx1263R317); // PTX L1688
	r_LaneIndexAtPtx1692 = uint32_t((threadIdx.x & 31u));							  // PTX L1692
	r_PackedHalf2AtPtx1695R457 =
		HalfAdd(r_PackedHalf2AtPtx1476R1601, r_MmaAccumulatorHalf2WordAtPtx1263R318); // PTX L1695
	r_LaneIndexAtPtx1699 = uint32_t((threadIdx.x & 31u));							  // PTX L1699
	r_PackedHalf2AtPtx1702R459 =
		HalfAdd(r_PackedHalf2AtPtx1487R1602, r_MmaAccumulatorHalf2WordAtPtx1270R319); // PTX L1702
	r_LaneIndexAtPtx1706 = uint32_t((threadIdx.x & 31u));							  // PTX L1706
	r_PackedHalf2AtPtx1709R461 =
		HalfAdd(r_PackedHalf2AtPtx1488R1603, r_MmaAccumulatorHalf2WordAtPtx1270R320); // PTX L1709
	r_LaneIndexAtPtx1713 = uint32_t((threadIdx.x & 31u));							  // PTX L1713
	r_PackedHalf2AtPtx1716R463 =
		HalfAdd(r_PackedHalf2AtPtx1489R1604, r_MmaAccumulatorHalf2WordAtPtx1277R321); // PTX L1716
	r_LaneIndexAtPtx1720 = uint32_t((threadIdx.x & 31u));							  // PTX L1720
	r_PackedHalf2AtPtx1723R465 =
		HalfAdd(r_PackedHalf2AtPtx1490R1605, r_MmaAccumulatorHalf2WordAtPtx1277R322);			  // PTX L1723
	r_LaneIndexAtPtx1727 = uint32_t((threadIdx.x & 31u));										  // PTX L1727
	r_PackedHalf2AtPtx1730R467 = HalfMul(r_PackedHalf2AtPtx1506R403, r_PackedHalf2AtPtx1506R403); // PTX L1730
	r_LaneIndexAtPtx1734 = uint32_t((threadIdx.x & 31u));										  // PTX L1734
	r_PackedHalf2AtPtx1737R470 = HalfMul(r_PackedHalf2AtPtx1513R405, r_PackedHalf2AtPtx1513R405); // PTX L1737
	r_LaneIndexAtPtx1741 = uint32_t((threadIdx.x & 31u));										  // PTX L1741
	r_PackedHalf2AtPtx1744R473 = HalfMul(r_PackedHalf2AtPtx1520R407, r_PackedHalf2AtPtx1520R407); // PTX L1744
	r_LaneIndexAtPtx1748 = uint32_t((threadIdx.x & 31u));										  // PTX L1748
	r_PackedHalf2AtPtx1751R476 = HalfMul(r_PackedHalf2AtPtx1527R409, r_PackedHalf2AtPtx1527R409); // PTX L1751
	r_LaneIndexAtPtx1755 = uint32_t((threadIdx.x & 31u));										  // PTX L1755
	r_PackedHalf2AtPtx1758R468 = HalfMul(r_PackedHalf2AtPtx1534R411, r_PackedHalf2AtPtx1534R411); // PTX L1758
	r_LaneIndexAtPtx1762 = uint32_t((threadIdx.x & 31u));										  // PTX L1762
	r_PackedHalf2AtPtx1765R471 = HalfMul(r_PackedHalf2AtPtx1541R413, r_PackedHalf2AtPtx1541R413); // PTX L1765
	r_LaneIndexAtPtx1769 = uint32_t((threadIdx.x & 31u));										  // PTX L1769
	r_PackedHalf2AtPtx1772R474 = HalfMul(r_PackedHalf2AtPtx1548R415, r_PackedHalf2AtPtx1548R415); // PTX L1772
	r_LaneIndexAtPtx1776 = uint32_t((threadIdx.x & 31u));										  // PTX L1776
	r_PackedHalf2AtPtx1779R477 = HalfMul(r_PackedHalf2AtPtx1555R417, r_PackedHalf2AtPtx1555R417); // PTX L1779
	r_LaneIndexAtPtx1783 = uint32_t((threadIdx.x & 31u));										  // PTX L1783
	r_PackedHalf2AtPtx1786R479 = HalfMul(r_PackedHalf2AtPtx1562R419, r_PackedHalf2AtPtx1562R419); // PTX L1786
	r_LaneIndexAtPtx1790 = uint32_t((threadIdx.x & 31u));										  // PTX L1790
	r_PackedHalf2AtPtx1793R482 = HalfMul(r_PackedHalf2AtPtx1569R421, r_PackedHalf2AtPtx1569R421); // PTX L1793
	r_LaneIndexAtPtx1797 = uint32_t((threadIdx.x & 31u));										  // PTX L1797
	r_PackedHalf2AtPtx1800R485 = HalfMul(r_PackedHalf2AtPtx1576R423, r_PackedHalf2AtPtx1576R423); // PTX L1800
	r_LaneIndexAtPtx1804 = uint32_t((threadIdx.x & 31u));										  // PTX L1804
	r_PackedHalf2AtPtx1807R488 = HalfMul(r_PackedHalf2AtPtx1583R425, r_PackedHalf2AtPtx1583R425); // PTX L1807
	r_LaneIndexAtPtx1811 = uint32_t((threadIdx.x & 31u));										  // PTX L1811
	r_PackedHalf2AtPtx1814R480 = HalfMul(r_PackedHalf2AtPtx1590R427, r_PackedHalf2AtPtx1590R427); // PTX L1814
	r_LaneIndexAtPtx1818 = uint32_t((threadIdx.x & 31u));										  // PTX L1818
	r_PackedHalf2AtPtx1821R483 = HalfMul(r_PackedHalf2AtPtx1597R429, r_PackedHalf2AtPtx1597R429); // PTX L1821
	r_LaneIndexAtPtx1825 = uint32_t((threadIdx.x & 31u));										  // PTX L1825
	r_PackedHalf2AtPtx1828R486 = HalfMul(r_PackedHalf2AtPtx1604R431, r_PackedHalf2AtPtx1604R431); // PTX L1828
	r_LaneIndexAtPtx1832 = uint32_t((threadIdx.x & 31u));										  // PTX L1832
	r_PackedHalf2AtPtx1835R489 = HalfMul(r_PackedHalf2AtPtx1611R433, r_PackedHalf2AtPtx1611R433); // PTX L1835
	r_LaneIndexAtPtx1839 = uint32_t((threadIdx.x & 31u));										  // PTX L1839
	r_PackedHalf2AtPtx1842R491 = HalfMul(r_PackedHalf2AtPtx1618R435, r_PackedHalf2AtPtx1618R435); // PTX L1842
	r_LaneIndexAtPtx1846 = uint32_t((threadIdx.x & 31u));										  // PTX L1846
	r_PackedHalf2AtPtx1849R494 = HalfMul(r_PackedHalf2AtPtx1625R437, r_PackedHalf2AtPtx1625R437); // PTX L1849
	r_LaneIndexAtPtx1853 = uint32_t((threadIdx.x & 31u));										  // PTX L1853
	r_PackedHalf2AtPtx1856R497 = HalfMul(r_PackedHalf2AtPtx1632R439, r_PackedHalf2AtPtx1632R439); // PTX L1856
	r_LaneIndexAtPtx1860 = uint32_t((threadIdx.x & 31u));										  // PTX L1860
	r_PackedHalf2AtPtx1863R500 = HalfMul(r_PackedHalf2AtPtx1639R441, r_PackedHalf2AtPtx1639R441); // PTX L1863
	r_LaneIndexAtPtx1867 = uint32_t((threadIdx.x & 31u));										  // PTX L1867
	r_PackedHalf2AtPtx1870R492 = HalfMul(r_PackedHalf2AtPtx1646R443, r_PackedHalf2AtPtx1646R443); // PTX L1870
	r_LaneIndexAtPtx1874 = uint32_t((threadIdx.x & 31u));										  // PTX L1874
	r_PackedHalf2AtPtx1877R495 = HalfMul(r_PackedHalf2AtPtx1653R445, r_PackedHalf2AtPtx1653R445); // PTX L1877
	r_LaneIndexAtPtx1881 = uint32_t((threadIdx.x & 31u));										  // PTX L1881
	r_PackedHalf2AtPtx1884R498 = HalfMul(r_PackedHalf2AtPtx1660R447, r_PackedHalf2AtPtx1660R447); // PTX L1884
	r_LaneIndexAtPtx1888 = uint32_t((threadIdx.x & 31u));										  // PTX L1888
	r_PackedHalf2AtPtx1891R501 = HalfMul(r_PackedHalf2AtPtx1667R449, r_PackedHalf2AtPtx1667R449); // PTX L1891
	r_LaneIndexAtPtx1895 = uint32_t((threadIdx.x & 31u));										  // PTX L1895
	r_PackedHalf2AtPtx1898R503 = HalfMul(r_PackedHalf2AtPtx1674R451, r_PackedHalf2AtPtx1674R451); // PTX L1898
	r_LaneIndexAtPtx1902 = uint32_t((threadIdx.x & 31u));										  // PTX L1902
	r_PackedHalf2AtPtx1905R506 = HalfMul(r_PackedHalf2AtPtx1681R453, r_PackedHalf2AtPtx1681R453); // PTX L1905
	r_LaneIndexAtPtx1909 = uint32_t((threadIdx.x & 31u));										  // PTX L1909
	r_PackedHalf2AtPtx1912R509 = HalfMul(r_PackedHalf2AtPtx1688R455, r_PackedHalf2AtPtx1688R455); // PTX L1912
	r_LaneIndexAtPtx1916 = uint32_t((threadIdx.x & 31u));										  // PTX L1916
	r_PackedHalf2AtPtx1919R512 = HalfMul(r_PackedHalf2AtPtx1695R457, r_PackedHalf2AtPtx1695R457); // PTX L1919
	r_LaneIndexAtPtx1923 = uint32_t((threadIdx.x & 31u));										  // PTX L1923
	r_PackedHalf2AtPtx1926R504 = HalfMul(r_PackedHalf2AtPtx1702R459, r_PackedHalf2AtPtx1702R459); // PTX L1926
	r_LaneIndexAtPtx1930 = uint32_t((threadIdx.x & 31u));										  // PTX L1930
	r_PackedHalf2AtPtx1933R507 = HalfMul(r_PackedHalf2AtPtx1709R461, r_PackedHalf2AtPtx1709R461); // PTX L1933
	r_LaneIndexAtPtx1937 = uint32_t((threadIdx.x & 31u));										  // PTX L1937
	r_PackedHalf2AtPtx1940R510 = HalfMul(r_PackedHalf2AtPtx1716R463, r_PackedHalf2AtPtx1716R463); // PTX L1940
	r_LaneIndexAtPtx1944 = uint32_t((threadIdx.x & 31u));										  // PTX L1944
	r_PackedHalf2AtPtx1947R513 = HalfMul(r_PackedHalf2AtPtx1723R465, r_PackedHalf2AtPtx1723R465); // PTX L1947
	r_LaneIndexAtPtx1951 = uint32_t((threadIdx.x & 31u));										  // PTX L1951
	r_PackedHalf2AtPtx1954R515 = HalfAdd(r_PackedHalf2AtPtx1730R467, r_PackedHalf2AtPtx1758R468); // PTX L1954
	r_LaneIndexAtPtx1958 = uint32_t((threadIdx.x & 31u));										  // PTX L1958
	r_PackedHalf2AtPtx1961R517 = HalfAdd(r_PackedHalf2AtPtx1737R470, r_PackedHalf2AtPtx1765R471); // PTX L1961
	r_LaneIndexAtPtx1965 = uint32_t((threadIdx.x & 31u));										  // PTX L1965
	r_PackedHalf2AtPtx1968R514 = HalfAdd(r_PackedHalf2AtPtx1744R473, r_PackedHalf2AtPtx1772R474); // PTX L1968
	r_LaneIndexAtPtx1972 = uint32_t((threadIdx.x & 31u));										  // PTX L1972
	r_PackedHalf2AtPtx1975R516 = HalfAdd(r_PackedHalf2AtPtx1751R476, r_PackedHalf2AtPtx1779R477); // PTX L1975
	r_LaneIndexAtPtx1979 = uint32_t((threadIdx.x & 31u));										  // PTX L1979
	r_PackedHalf2AtPtx1982R535 = HalfAdd(r_PackedHalf2AtPtx1786R479, r_PackedHalf2AtPtx1814R480); // PTX L1982
	r_LaneIndexAtPtx1986 = uint32_t((threadIdx.x & 31u));										  // PTX L1986
	r_PackedHalf2AtPtx1989R537 = HalfAdd(r_PackedHalf2AtPtx1793R482, r_PackedHalf2AtPtx1821R483); // PTX L1989
	r_LaneIndexAtPtx1993 = uint32_t((threadIdx.x & 31u));										  // PTX L1993
	r_PackedHalf2AtPtx1996R534 = HalfAdd(r_PackedHalf2AtPtx1800R485, r_PackedHalf2AtPtx1828R486); // PTX L1996
	r_LaneIndexAtPtx2000 = uint32_t((threadIdx.x & 31u));										  // PTX L2000
	r_PackedHalf2AtPtx2003R536 = HalfAdd(r_PackedHalf2AtPtx1807R488, r_PackedHalf2AtPtx1835R489); // PTX L2003
	r_LaneIndexAtPtx2007 = uint32_t((threadIdx.x & 31u));										  // PTX L2007
	r_PackedHalf2AtPtx2010R551 = HalfAdd(r_PackedHalf2AtPtx1842R491, r_PackedHalf2AtPtx1870R492); // PTX L2010
	r_LaneIndexAtPtx2014 = uint32_t((threadIdx.x & 31u));										  // PTX L2014
	r_PackedHalf2AtPtx2017R553 = HalfAdd(r_PackedHalf2AtPtx1849R494, r_PackedHalf2AtPtx1877R495); // PTX L2017
	r_LaneIndexAtPtx2021 = uint32_t((threadIdx.x & 31u));										  // PTX L2021
	r_PackedHalf2AtPtx2024R550 = HalfAdd(r_PackedHalf2AtPtx1856R497, r_PackedHalf2AtPtx1884R498); // PTX L2024
	r_LaneIndexAtPtx2028 = uint32_t((threadIdx.x & 31u));										  // PTX L2028
	r_PackedHalf2AtPtx2031R552 = HalfAdd(r_PackedHalf2AtPtx1863R500, r_PackedHalf2AtPtx1891R501); // PTX L2031
	r_LaneIndexAtPtx2035 = uint32_t((threadIdx.x & 31u));										  // PTX L2035
	r_PackedHalf2AtPtx2038R567 = HalfAdd(r_PackedHalf2AtPtx1898R503, r_PackedHalf2AtPtx1926R504); // PTX L2038
	r_LaneIndexAtPtx2042 = uint32_t((threadIdx.x & 31u));										  // PTX L2042
	r_PackedHalf2AtPtx2045R569 = HalfAdd(r_PackedHalf2AtPtx1905R506, r_PackedHalf2AtPtx1933R507); // PTX L2045
	r_LaneIndexAtPtx2049 = uint32_t((threadIdx.x & 31u));										  // PTX L2049
	r_PackedHalf2AtPtx2052R566 = HalfAdd(r_PackedHalf2AtPtx1912R509, r_PackedHalf2AtPtx1940R510); // PTX L2052
	r_LaneIndexAtPtx2056 = uint32_t((threadIdx.x & 31u));										  // PTX L2056
	r_PackedHalf2AtPtx2059R568 = HalfAdd(r_PackedHalf2AtPtx1919R512, r_PackedHalf2AtPtx1947R513); // PTX L2059
	r_PackedHalf2AtPtx2063R519 = HalfAdd(r_PackedHalf2AtPtx1968R514, r_PackedHalf2AtPtx1954R515); // PTX L2063
	r_PackedHalf2AtPtx2067R528 = HalfAdd(r_PackedHalf2AtPtx1975R516, r_PackedHalf2AtPtx1961R517); // PTX L2067
	r_PtxRegister518 = uint32_t(32u);															  // PTX L2071
	r_PtxRegister867 = ShiftLeft(uint32_t(r_PtxRegister518), uint32_t(8));						  // PTX L2074
	r_PtxRegister1114 = uint32_t(r_PtxRegister867) + uint32_t(-8161);							  // PTX L2075
	r_PtxRegister520 = uint32_t(2);																  // PTX L2076
	r_PtxRegister521 = uint32_t(-1);															  // PTX L2077
	r_PackedHalf2AtPtx2079R522 = ShuffleBfly(r_PackedHalf2AtPtx2063R519, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2079
	r_PackedHalf2AtPtx2083R523 = HalfAdd(r_PackedHalf2AtPtx2063R519, r_PackedHalf2AtPtx2079R522); // PTX L2083
	r_PtxRegister524 = uint32_t(1);																  // PTX L2086
	r_PackedHalf2AtPtx2088R525 = ShuffleBfly(r_PackedHalf2AtPtx2083R523, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2088
	r_PtxRegister526 = HalfAdd(r_PackedHalf2AtPtx2083R523, r_PackedHalf2AtPtx2088R525); // PTX L2092
	r_PtxU16Register41 = uint16_t(r_PtxRegister526);
	r_PtxU16Register42 = uint16_t(r_PtxRegister526 >> 16);								// PTX L2095
	r_PackedHalf2AtPtx2096R527 = JoinHalfwords(r_PtxU16Register42, r_PtxU16Register41); // PTX L2096
	r_PackedHalf2AtPtx2098R584 = HalfAdd(r_PtxRegister526, r_PackedHalf2AtPtx2096R527); // PTX L2098
	r_PackedHalf2AtPtx2102R529 = ShuffleBfly(r_PackedHalf2AtPtx2067R528, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2102
	r_PackedHalf2AtPtx2106R530 = HalfAdd(r_PackedHalf2AtPtx2067R528, r_PackedHalf2AtPtx2102R529); // PTX L2106
	r_PackedHalf2AtPtx2110R531 = ShuffleBfly(r_PackedHalf2AtPtx2106R530, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2110
	r_PtxRegister532 = HalfAdd(r_PackedHalf2AtPtx2106R530, r_PackedHalf2AtPtx2110R531); // PTX L2114
	r_PtxU16Register43 = uint16_t(r_PtxRegister532);
	r_PtxU16Register44 = uint16_t(r_PtxRegister532 >> 16);										  // PTX L2117
	r_PackedHalf2AtPtx2118R533 = JoinHalfwords(r_PtxU16Register44, r_PtxU16Register43);			  // PTX L2118
	r_PackedHalf2AtPtx2120R586 = HalfAdd(r_PtxRegister532, r_PackedHalf2AtPtx2118R533);			  // PTX L2120
	r_PackedHalf2AtPtx2124R538 = HalfAdd(r_PackedHalf2AtPtx1996R534, r_PackedHalf2AtPtx1982R535); // PTX L2124
	r_PackedHalf2AtPtx2128R544 = HalfAdd(r_PackedHalf2AtPtx2003R536, r_PackedHalf2AtPtx1989R537); // PTX L2128
	r_PackedHalf2AtPtx2132R539 = ShuffleBfly(r_PackedHalf2AtPtx2124R538, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2132
	r_PackedHalf2AtPtx2136R540 = HalfAdd(r_PackedHalf2AtPtx2124R538, r_PackedHalf2AtPtx2132R539); // PTX L2136
	r_PackedHalf2AtPtx2140R541 = ShuffleBfly(r_PackedHalf2AtPtx2136R540, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2140
	r_PtxRegister542 = HalfAdd(r_PackedHalf2AtPtx2136R540, r_PackedHalf2AtPtx2140R541); // PTX L2144
	r_PtxU16Register45 = uint16_t(r_PtxRegister542);
	r_PtxU16Register46 = uint16_t(r_PtxRegister542 >> 16);								// PTX L2147
	r_PackedHalf2AtPtx2148R543 = JoinHalfwords(r_PtxU16Register46, r_PtxU16Register45); // PTX L2148
	r_PackedHalf2AtPtx2150R594 = HalfAdd(r_PtxRegister542, r_PackedHalf2AtPtx2148R543); // PTX L2150
	r_PackedHalf2AtPtx2154R545 = ShuffleBfly(r_PackedHalf2AtPtx2128R544, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2154
	r_PackedHalf2AtPtx2158R546 = HalfAdd(r_PackedHalf2AtPtx2128R544, r_PackedHalf2AtPtx2154R545); // PTX L2158
	r_PackedHalf2AtPtx2162R547 = ShuffleBfly(r_PackedHalf2AtPtx2158R546, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2162
	r_PtxRegister548 = HalfAdd(r_PackedHalf2AtPtx2158R546, r_PackedHalf2AtPtx2162R547); // PTX L2166
	r_PtxU16Register47 = uint16_t(r_PtxRegister548);
	r_PtxU16Register48 = uint16_t(r_PtxRegister548 >> 16);										  // PTX L2169
	r_PackedHalf2AtPtx2170R549 = JoinHalfwords(r_PtxU16Register48, r_PtxU16Register47);			  // PTX L2170
	r_PackedHalf2AtPtx2172R596 = HalfAdd(r_PtxRegister548, r_PackedHalf2AtPtx2170R549);			  // PTX L2172
	r_PackedHalf2AtPtx2176R554 = HalfAdd(r_PackedHalf2AtPtx2024R550, r_PackedHalf2AtPtx2010R551); // PTX L2176
	r_PackedHalf2AtPtx2180R560 = HalfAdd(r_PackedHalf2AtPtx2031R552, r_PackedHalf2AtPtx2017R553); // PTX L2180
	r_PackedHalf2AtPtx2184R555 = ShuffleBfly(r_PackedHalf2AtPtx2176R554, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2184
	r_PackedHalf2AtPtx2188R556 = HalfAdd(r_PackedHalf2AtPtx2176R554, r_PackedHalf2AtPtx2184R555); // PTX L2188
	r_PackedHalf2AtPtx2192R557 = ShuffleBfly(r_PackedHalf2AtPtx2188R556, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2192
	r_PtxRegister558 = HalfAdd(r_PackedHalf2AtPtx2188R556, r_PackedHalf2AtPtx2192R557); // PTX L2196
	r_PtxU16Register49 = uint16_t(r_PtxRegister558);
	r_PtxU16Register50 = uint16_t(r_PtxRegister558 >> 16);								// PTX L2199
	r_PackedHalf2AtPtx2200R559 = JoinHalfwords(r_PtxU16Register50, r_PtxU16Register49); // PTX L2200
	r_PackedHalf2AtPtx2202R604 = HalfAdd(r_PtxRegister558, r_PackedHalf2AtPtx2200R559); // PTX L2202
	r_PackedHalf2AtPtx2206R561 = ShuffleBfly(r_PackedHalf2AtPtx2180R560, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2206
	r_PackedHalf2AtPtx2210R562 = HalfAdd(r_PackedHalf2AtPtx2180R560, r_PackedHalf2AtPtx2206R561); // PTX L2210
	r_PackedHalf2AtPtx2214R563 = ShuffleBfly(r_PackedHalf2AtPtx2210R562, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2214
	r_PtxRegister564 = HalfAdd(r_PackedHalf2AtPtx2210R562, r_PackedHalf2AtPtx2214R563); // PTX L2218
	r_PtxU16Register51 = uint16_t(r_PtxRegister564);
	r_PtxU16Register52 = uint16_t(r_PtxRegister564 >> 16);										  // PTX L2221
	r_PackedHalf2AtPtx2222R565 = JoinHalfwords(r_PtxU16Register52, r_PtxU16Register51);			  // PTX L2222
	r_PackedHalf2AtPtx2224R606 = HalfAdd(r_PtxRegister564, r_PackedHalf2AtPtx2222R565);			  // PTX L2224
	r_PackedHalf2AtPtx2228R570 = HalfAdd(r_PackedHalf2AtPtx2052R566, r_PackedHalf2AtPtx2038R567); // PTX L2228
	r_PackedHalf2AtPtx2232R576 = HalfAdd(r_PackedHalf2AtPtx2059R568, r_PackedHalf2AtPtx2045R569); // PTX L2232
	r_PackedHalf2AtPtx2236R571 = ShuffleBfly(r_PackedHalf2AtPtx2228R570, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2236
	r_PackedHalf2AtPtx2240R572 = HalfAdd(r_PackedHalf2AtPtx2228R570, r_PackedHalf2AtPtx2236R571); // PTX L2240
	r_PackedHalf2AtPtx2244R573 = ShuffleBfly(r_PackedHalf2AtPtx2240R572, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2244
	r_PtxRegister574 = HalfAdd(r_PackedHalf2AtPtx2240R572, r_PackedHalf2AtPtx2244R573); // PTX L2248
	r_PtxU16Register53 = uint16_t(r_PtxRegister574);
	r_PtxU16Register54 = uint16_t(r_PtxRegister574 >> 16);								// PTX L2251
	r_PackedHalf2AtPtx2252R575 = JoinHalfwords(r_PtxU16Register54, r_PtxU16Register53); // PTX L2252
	r_PackedHalf2AtPtx2254R614 = HalfAdd(r_PtxRegister574, r_PackedHalf2AtPtx2252R575); // PTX L2254
	r_PackedHalf2AtPtx2258R577 = ShuffleBfly(r_PackedHalf2AtPtx2232R576, r_PtxRegister520, r_PtxRegister1114,
											 r_PtxRegister521);									  // PTX L2258
	r_PackedHalf2AtPtx2262R578 = HalfAdd(r_PackedHalf2AtPtx2232R576, r_PackedHalf2AtPtx2258R577); // PTX L2262
	r_PackedHalf2AtPtx2266R579 = ShuffleBfly(r_PackedHalf2AtPtx2262R578, r_PtxRegister524, r_PtxRegister1114,
											 r_PtxRegister521);							// PTX L2266
	r_PtxRegister580 = HalfAdd(r_PackedHalf2AtPtx2262R578, r_PackedHalf2AtPtx2266R579); // PTX L2270
	r_PtxU16Register55 = uint16_t(r_PtxRegister580);
	r_PtxU16Register56 = uint16_t(r_PtxRegister580 >> 16);								// PTX L2273
	r_PackedHalf2AtPtx2274R581 = JoinHalfwords(r_PtxU16Register56, r_PtxU16Register55); // PTX L2274
	r_PackedHalf2AtPtx2276R616 = HalfAdd(r_PtxRegister580, r_PackedHalf2AtPtx2274R581); // PTX L2276
	r_Float32BitsAtPtx2279R582 = uint32_t(948045311);									// PTX L2279
	r_PackedHalf2AtPtx2281R1152 = FloatToHalf2(r_Float32BitsAtPtx2279R582);				// PTX L2281
	r_LaneIndexAtPtx2287 = uint32_t((threadIdx.x & 31u));								// PTX L2287
	r_PackedHalf2AtPtx2290R624 =
		HalfMax(r_PackedHalf2AtPtx2098R584, r_PackedHalf2AtPtx2281R1152); // PTX L2290
	r_LaneIndexAtPtx2294 = uint32_t((threadIdx.x & 31u));				  // PTX L2294
	r_PackedHalf2AtPtx2297R626 =
		HalfMax(r_PackedHalf2AtPtx2120R586, r_PackedHalf2AtPtx2281R1152); // PTX L2297
	r_LaneIndexAtPtx2301 = uint32_t((threadIdx.x & 31u));				  // PTX L2301
	r_LaneIndexAtPtx2304 = uint32_t((threadIdx.x & 31u));				  // PTX L2304
	r_LaneIndexAtPtx2307 = uint32_t((threadIdx.x & 31u));				  // PTX L2307
	r_LaneIndexAtPtx2310 = uint32_t((threadIdx.x & 31u));				  // PTX L2310
	r_LaneIndexAtPtx2313 = uint32_t((threadIdx.x & 31u));				  // PTX L2313
	r_LaneIndexAtPtx2316 = uint32_t((threadIdx.x & 31u));				  // PTX L2316
	r_LaneIndexAtPtx2319 = uint32_t((threadIdx.x & 31u));				  // PTX L2319
	r_PackedHalf2AtPtx2322R634 =
		HalfMax(r_PackedHalf2AtPtx2150R594, r_PackedHalf2AtPtx2281R1152); // PTX L2322
	r_LaneIndexAtPtx2326 = uint32_t((threadIdx.x & 31u));				  // PTX L2326
	r_PackedHalf2AtPtx2329R636 =
		HalfMax(r_PackedHalf2AtPtx2172R596, r_PackedHalf2AtPtx2281R1152); // PTX L2329
	r_LaneIndexAtPtx2333 = uint32_t((threadIdx.x & 31u));				  // PTX L2333
	r_LaneIndexAtPtx2336 = uint32_t((threadIdx.x & 31u));				  // PTX L2336
	r_LaneIndexAtPtx2339 = uint32_t((threadIdx.x & 31u));				  // PTX L2339
	r_LaneIndexAtPtx2342 = uint32_t((threadIdx.x & 31u));				  // PTX L2342
	r_LaneIndexAtPtx2345 = uint32_t((threadIdx.x & 31u));				  // PTX L2345
	r_LaneIndexAtPtx2348 = uint32_t((threadIdx.x & 31u));				  // PTX L2348
	r_LaneIndexAtPtx2351 = uint32_t((threadIdx.x & 31u));				  // PTX L2351
	r_PackedHalf2AtPtx2354R644 =
		HalfMax(r_PackedHalf2AtPtx2202R604, r_PackedHalf2AtPtx2281R1152); // PTX L2354
	r_LaneIndexAtPtx2358 = uint32_t((threadIdx.x & 31u));				  // PTX L2358
	r_PackedHalf2AtPtx2361R646 =
		HalfMax(r_PackedHalf2AtPtx2224R606, r_PackedHalf2AtPtx2281R1152); // PTX L2361
	r_LaneIndexAtPtx2365 = uint32_t((threadIdx.x & 31u));				  // PTX L2365
	r_LaneIndexAtPtx2368 = uint32_t((threadIdx.x & 31u));				  // PTX L2368
	r_LaneIndexAtPtx2371 = uint32_t((threadIdx.x & 31u));				  // PTX L2371
	r_LaneIndexAtPtx2374 = uint32_t((threadIdx.x & 31u));				  // PTX L2374
	r_LaneIndexAtPtx2377 = uint32_t((threadIdx.x & 31u));				  // PTX L2377
	r_LaneIndexAtPtx2380 = uint32_t((threadIdx.x & 31u));				  // PTX L2380
	r_LaneIndexAtPtx2383 = uint32_t((threadIdx.x & 31u));				  // PTX L2383
	r_PackedHalf2AtPtx2386R654 =
		HalfMax(r_PackedHalf2AtPtx2254R614, r_PackedHalf2AtPtx2281R1152); // PTX L2386
	r_LaneIndexAtPtx2390 = uint32_t((threadIdx.x & 31u));				  // PTX L2390
	r_PackedHalf2AtPtx2393R656 =
		HalfMax(r_PackedHalf2AtPtx2276R616, r_PackedHalf2AtPtx2281R1152); // PTX L2393
	r_LaneIndexAtPtx2397 = uint32_t((threadIdx.x & 31u));				  // PTX L2397
	r_LaneIndexAtPtx2400 = uint32_t((threadIdx.x & 31u));				  // PTX L2400
	r_LaneIndexAtPtx2403 = uint32_t((threadIdx.x & 31u));				  // PTX L2403
	r_LaneIndexAtPtx2406 = uint32_t((threadIdx.x & 31u));				  // PTX L2406
	r_LaneIndexAtPtx2409 = uint32_t((threadIdx.x & 31u));				  // PTX L2409
	r_LaneIndexAtPtx2412 = uint32_t((threadIdx.x & 31u));				  // PTX L2412
	r_LaneIndexAtPtx2415 = uint32_t((threadIdx.x & 31u));				  // PTX L2415
	// Phase: reciprocal_square_root. Reciprocal-square-root stage: keep per-Half widening, FTZ approximation, rounding and surrounding arithmetic order.
	r_PackedHalf2AtPtx2418R664 = RsqrtHalf2(r_PackedHalf2AtPtx2290R624);						  // PTX L2418
	r_LaneIndexAtPtx2431 = uint32_t((threadIdx.x & 31u));										  // PTX L2431
	r_PackedHalf2AtPtx2434R666 = RsqrtHalf2(r_PackedHalf2AtPtx2297R626);						  // PTX L2434
	r_LaneIndexAtPtx2447 = uint32_t((threadIdx.x & 31u));										  // PTX L2447
	r_LaneIndexAtPtx2450 = uint32_t((threadIdx.x & 31u));										  // PTX L2450
	r_LaneIndexAtPtx2453 = uint32_t((threadIdx.x & 31u));										  // PTX L2453
	r_LaneIndexAtPtx2456 = uint32_t((threadIdx.x & 31u));										  // PTX L2456
	r_LaneIndexAtPtx2459 = uint32_t((threadIdx.x & 31u));										  // PTX L2459
	r_LaneIndexAtPtx2462 = uint32_t((threadIdx.x & 31u));										  // PTX L2462
	r_LaneIndexAtPtx2465 = uint32_t((threadIdx.x & 31u));										  // PTX L2465
	r_PackedHalf2AtPtx2468R674 = RsqrtHalf2(r_PackedHalf2AtPtx2322R634);						  // PTX L2468
	r_LaneIndexAtPtx2481 = uint32_t((threadIdx.x & 31u));										  // PTX L2481
	r_PackedHalf2AtPtx2484R676 = RsqrtHalf2(r_PackedHalf2AtPtx2329R636);						  // PTX L2484
	r_LaneIndexAtPtx2497 = uint32_t((threadIdx.x & 31u));										  // PTX L2497
	r_LaneIndexAtPtx2500 = uint32_t((threadIdx.x & 31u));										  // PTX L2500
	r_LaneIndexAtPtx2503 = uint32_t((threadIdx.x & 31u));										  // PTX L2503
	r_LaneIndexAtPtx2506 = uint32_t((threadIdx.x & 31u));										  // PTX L2506
	r_LaneIndexAtPtx2509 = uint32_t((threadIdx.x & 31u));										  // PTX L2509
	r_LaneIndexAtPtx2512 = uint32_t((threadIdx.x & 31u));										  // PTX L2512
	r_LaneIndexAtPtx2515 = uint32_t((threadIdx.x & 31u));										  // PTX L2515
	r_PackedHalf2AtPtx2518R684 = RsqrtHalf2(r_PackedHalf2AtPtx2354R644);						  // PTX L2518
	r_LaneIndexAtPtx2531 = uint32_t((threadIdx.x & 31u));										  // PTX L2531
	r_PackedHalf2AtPtx2534R686 = RsqrtHalf2(r_PackedHalf2AtPtx2361R646);						  // PTX L2534
	r_LaneIndexAtPtx2547 = uint32_t((threadIdx.x & 31u));										  // PTX L2547
	r_LaneIndexAtPtx2550 = uint32_t((threadIdx.x & 31u));										  // PTX L2550
	r_LaneIndexAtPtx2553 = uint32_t((threadIdx.x & 31u));										  // PTX L2553
	r_LaneIndexAtPtx2556 = uint32_t((threadIdx.x & 31u));										  // PTX L2556
	r_LaneIndexAtPtx2559 = uint32_t((threadIdx.x & 31u));										  // PTX L2559
	r_LaneIndexAtPtx2562 = uint32_t((threadIdx.x & 31u));										  // PTX L2562
	r_LaneIndexAtPtx2565 = uint32_t((threadIdx.x & 31u));										  // PTX L2565
	r_PackedHalf2AtPtx2568R694 = RsqrtHalf2(r_PackedHalf2AtPtx2386R654);						  // PTX L2568
	r_LaneIndexAtPtx2581 = uint32_t((threadIdx.x & 31u));										  // PTX L2581
	r_PackedHalf2AtPtx2584R696 = RsqrtHalf2(r_PackedHalf2AtPtx2393R656);						  // PTX L2584
	r_LaneIndexAtPtx2597 = uint32_t((threadIdx.x & 31u));										  // PTX L2597
	r_LaneIndexAtPtx2600 = uint32_t((threadIdx.x & 31u));										  // PTX L2600
	r_LaneIndexAtPtx2603 = uint32_t((threadIdx.x & 31u));										  // PTX L2603
	r_LaneIndexAtPtx2606 = uint32_t((threadIdx.x & 31u));										  // PTX L2606
	r_LaneIndexAtPtx2609 = uint32_t((threadIdx.x & 31u));										  // PTX L2609
	r_LaneIndexAtPtx2612 = uint32_t((threadIdx.x & 31u));										  // PTX L2612
	r_LaneIndexAtPtx2615 = uint32_t((threadIdx.x & 31u));										  // PTX L2615
	r_PackedHalf2AtPtx2618R705 = HalfMul(r_PackedHalf2AtPtx1506R403, r_PackedHalf2AtPtx2418R664); // PTX L2618
	r_LaneIndexAtPtx2622 = uint32_t((threadIdx.x & 31u));										  // PTX L2622
	r_PackedHalf2AtPtx2625R708 = HalfMul(r_PackedHalf2AtPtx1513R405, r_PackedHalf2AtPtx2434R666); // PTX L2625
	r_LaneIndexAtPtx2629 = uint32_t((threadIdx.x & 31u));										  // PTX L2629
	r_PackedHalf2AtPtx2632R710 = HalfMul(r_PackedHalf2AtPtx1520R407, r_PackedHalf2AtPtx2418R664); // PTX L2632
	r_LaneIndexAtPtx2636 = uint32_t((threadIdx.x & 31u));										  // PTX L2636
	r_PackedHalf2AtPtx2639R712 = HalfMul(r_PackedHalf2AtPtx1527R409, r_PackedHalf2AtPtx2434R666); // PTX L2639
	r_LaneIndexAtPtx2643 = uint32_t((threadIdx.x & 31u));										  // PTX L2643
	r_PackedHalf2AtPtx2646R714 = HalfMul(r_PackedHalf2AtPtx1534R411, r_PackedHalf2AtPtx2418R664); // PTX L2646
	r_LaneIndexAtPtx2650 = uint32_t((threadIdx.x & 31u));										  // PTX L2650
	r_PackedHalf2AtPtx2653R716 = HalfMul(r_PackedHalf2AtPtx1541R413, r_PackedHalf2AtPtx2434R666); // PTX L2653
	r_LaneIndexAtPtx2657 = uint32_t((threadIdx.x & 31u));										  // PTX L2657
	r_PackedHalf2AtPtx2660R718 = HalfMul(r_PackedHalf2AtPtx1548R415, r_PackedHalf2AtPtx2418R664); // PTX L2660
	r_LaneIndexAtPtx2664 = uint32_t((threadIdx.x & 31u));										  // PTX L2664
	r_PackedHalf2AtPtx2667R720 = HalfMul(r_PackedHalf2AtPtx1555R417, r_PackedHalf2AtPtx2434R666); // PTX L2667
	r_LaneIndexAtPtx2671 = uint32_t((threadIdx.x & 31u));										  // PTX L2671
	r_PackedHalf2AtPtx2674R722 = HalfMul(r_PackedHalf2AtPtx1562R419, r_PackedHalf2AtPtx2468R674); // PTX L2674
	r_LaneIndexAtPtx2678 = uint32_t((threadIdx.x & 31u));										  // PTX L2678
	r_PackedHalf2AtPtx2681R724 = HalfMul(r_PackedHalf2AtPtx1569R421, r_PackedHalf2AtPtx2484R676); // PTX L2681
	r_LaneIndexAtPtx2685 = uint32_t((threadIdx.x & 31u));										  // PTX L2685
	r_PackedHalf2AtPtx2688R726 = HalfMul(r_PackedHalf2AtPtx1576R423, r_PackedHalf2AtPtx2468R674); // PTX L2688
	r_LaneIndexAtPtx2692 = uint32_t((threadIdx.x & 31u));										  // PTX L2692
	r_PackedHalf2AtPtx2695R728 = HalfMul(r_PackedHalf2AtPtx1583R425, r_PackedHalf2AtPtx2484R676); // PTX L2695
	r_LaneIndexAtPtx2699 = uint32_t((threadIdx.x & 31u));										  // PTX L2699
	r_PackedHalf2AtPtx2702R730 = HalfMul(r_PackedHalf2AtPtx1590R427, r_PackedHalf2AtPtx2468R674); // PTX L2702
	r_LaneIndexAtPtx2706 = uint32_t((threadIdx.x & 31u));										  // PTX L2706
	r_PackedHalf2AtPtx2709R732 = HalfMul(r_PackedHalf2AtPtx1597R429, r_PackedHalf2AtPtx2484R676); // PTX L2709
	r_LaneIndexAtPtx2713 = uint32_t((threadIdx.x & 31u));										  // PTX L2713
	r_PackedHalf2AtPtx2716R734 = HalfMul(r_PackedHalf2AtPtx1604R431, r_PackedHalf2AtPtx2468R674); // PTX L2716
	r_LaneIndexAtPtx2720 = uint32_t((threadIdx.x & 31u));										  // PTX L2720
	r_PackedHalf2AtPtx2723R736 = HalfMul(r_PackedHalf2AtPtx1611R433, r_PackedHalf2AtPtx2484R676); // PTX L2723
	r_LaneIndexAtPtx2727 = uint32_t((threadIdx.x & 31u));										  // PTX L2727
	r_PackedHalf2AtPtx2730R738 = HalfMul(r_PackedHalf2AtPtx1618R435, r_PackedHalf2AtPtx2518R684); // PTX L2730
	r_LaneIndexAtPtx2734 = uint32_t((threadIdx.x & 31u));										  // PTX L2734
	r_PackedHalf2AtPtx2737R740 = HalfMul(r_PackedHalf2AtPtx1625R437, r_PackedHalf2AtPtx2534R686); // PTX L2737
	r_LaneIndexAtPtx2741 = uint32_t((threadIdx.x & 31u));										  // PTX L2741
	r_PackedHalf2AtPtx2744R742 = HalfMul(r_PackedHalf2AtPtx1632R439, r_PackedHalf2AtPtx2518R684); // PTX L2744
	r_LaneIndexAtPtx2748 = uint32_t((threadIdx.x & 31u));										  // PTX L2748
	r_PackedHalf2AtPtx2751R744 = HalfMul(r_PackedHalf2AtPtx1639R441, r_PackedHalf2AtPtx2534R686); // PTX L2751
	r_LaneIndexAtPtx2755 = uint32_t((threadIdx.x & 31u));										  // PTX L2755
	r_PackedHalf2AtPtx2758R746 = HalfMul(r_PackedHalf2AtPtx1646R443, r_PackedHalf2AtPtx2518R684); // PTX L2758
	r_LaneIndexAtPtx2762 = uint32_t((threadIdx.x & 31u));										  // PTX L2762
	r_PackedHalf2AtPtx2765R748 = HalfMul(r_PackedHalf2AtPtx1653R445, r_PackedHalf2AtPtx2534R686); // PTX L2765
	r_LaneIndexAtPtx2769 = uint32_t((threadIdx.x & 31u));										  // PTX L2769
	r_PackedHalf2AtPtx2772R750 = HalfMul(r_PackedHalf2AtPtx1660R447, r_PackedHalf2AtPtx2518R684); // PTX L2772
	r_LaneIndexAtPtx2776 = uint32_t((threadIdx.x & 31u));										  // PTX L2776
	r_PackedHalf2AtPtx2779R752 = HalfMul(r_PackedHalf2AtPtx1667R449, r_PackedHalf2AtPtx2534R686); // PTX L2779
	r_LaneIndexAtPtx2783 = uint32_t((threadIdx.x & 31u));										  // PTX L2783
	r_PackedHalf2AtPtx2786R754 = HalfMul(r_PackedHalf2AtPtx1674R451, r_PackedHalf2AtPtx2568R694); // PTX L2786
	r_LaneIndexAtPtx2790 = uint32_t((threadIdx.x & 31u));										  // PTX L2790
	r_PackedHalf2AtPtx2793R756 = HalfMul(r_PackedHalf2AtPtx1681R453, r_PackedHalf2AtPtx2584R696); // PTX L2793
	r_LaneIndexAtPtx2797 = uint32_t((threadIdx.x & 31u));										  // PTX L2797
	r_PackedHalf2AtPtx2800R758 = HalfMul(r_PackedHalf2AtPtx1688R455, r_PackedHalf2AtPtx2568R694); // PTX L2800
	r_LaneIndexAtPtx2804 = uint32_t((threadIdx.x & 31u));										  // PTX L2804
	r_PackedHalf2AtPtx2807R760 = HalfMul(r_PackedHalf2AtPtx1695R457, r_PackedHalf2AtPtx2584R696); // PTX L2807
	r_LaneIndexAtPtx2811 = uint32_t((threadIdx.x & 31u));										  // PTX L2811
	r_PackedHalf2AtPtx2814R762 = HalfMul(r_PackedHalf2AtPtx1702R459, r_PackedHalf2AtPtx2568R694); // PTX L2814
	r_LaneIndexAtPtx2818 = uint32_t((threadIdx.x & 31u));										  // PTX L2818
	r_PackedHalf2AtPtx2821R764 = HalfMul(r_PackedHalf2AtPtx1709R461, r_PackedHalf2AtPtx2584R696); // PTX L2821
	r_LaneIndexAtPtx2825 = uint32_t((threadIdx.x & 31u));										  // PTX L2825
	r_PackedHalf2AtPtx2828R766 = HalfMul(r_PackedHalf2AtPtx1716R463, r_PackedHalf2AtPtx2568R694); // PTX L2828
	r_LaneIndexAtPtx2832 = uint32_t((threadIdx.x & 31u));										  // PTX L2832
	r_PackedHalf2AtPtx2835R768 = HalfMul(r_PackedHalf2AtPtx1723R465, r_PackedHalf2AtPtx2584R696); // PTX L2835
	r_PtxRegister868 = uint32_t(0x42000000u /* exact PTX Float32 bits */);						  // PTX L2838
	r_PtxRegister703 = FloatSqrtApproxFtzBits(r_PtxRegister868);								  // PTX L2839
	r_PackedHalf2AtPtx2841R706 = FloatToHalf2(r_PtxRegister703);								  // PTX L2841
	r_LaneIndexAtPtx2847 = uint32_t((threadIdx.x & 31u));										  // PTX L2847
	r_PackedHalf2AtPtx2850R771 = HalfMul(r_PackedHalf2AtPtx2618R705, r_PackedHalf2AtPtx2841R706); // PTX L2850
	r_LaneIndexAtPtx2854 = uint32_t((threadIdx.x & 31u));										  // PTX L2854
	r_PackedHalf2AtPtx2857R774 = HalfMul(r_PackedHalf2AtPtx2625R708, r_PackedHalf2AtPtx2841R706); // PTX L2857
	r_LaneIndexAtPtx2861 = uint32_t((threadIdx.x & 31u));										  // PTX L2861
	r_PackedHalf2AtPtx2864R776 = HalfMul(r_PackedHalf2AtPtx2632R710, r_PackedHalf2AtPtx2841R706); // PTX L2864
	r_LaneIndexAtPtx2868 = uint32_t((threadIdx.x & 31u));										  // PTX L2868
	r_PackedHalf2AtPtx2871R778 = HalfMul(r_PackedHalf2AtPtx2639R712, r_PackedHalf2AtPtx2841R706); // PTX L2871
	r_LaneIndexAtPtx2875 = uint32_t((threadIdx.x & 31u));										  // PTX L2875
	r_PackedHalf2AtPtx2878R780 = HalfMul(r_PackedHalf2AtPtx2646R714, r_PackedHalf2AtPtx2841R706); // PTX L2878
	r_LaneIndexAtPtx2882 = uint32_t((threadIdx.x & 31u));										  // PTX L2882
	r_PackedHalf2AtPtx2885R782 = HalfMul(r_PackedHalf2AtPtx2653R716, r_PackedHalf2AtPtx2841R706); // PTX L2885
	r_LaneIndexAtPtx2889 = uint32_t((threadIdx.x & 31u));										  // PTX L2889
	r_PackedHalf2AtPtx2892R784 = HalfMul(r_PackedHalf2AtPtx2660R718, r_PackedHalf2AtPtx2841R706); // PTX L2892
	r_LaneIndexAtPtx2896 = uint32_t((threadIdx.x & 31u));										  // PTX L2896
	r_PackedHalf2AtPtx2899R786 = HalfMul(r_PackedHalf2AtPtx2667R720, r_PackedHalf2AtPtx2841R706); // PTX L2899
	r_LaneIndexAtPtx2903 = uint32_t((threadIdx.x & 31u));										  // PTX L2903
	r_PackedHalf2AtPtx2906R788 = HalfMul(r_PackedHalf2AtPtx2674R722, r_PackedHalf2AtPtx2841R706); // PTX L2906
	r_LaneIndexAtPtx2910 = uint32_t((threadIdx.x & 31u));										  // PTX L2910
	r_PackedHalf2AtPtx2913R790 = HalfMul(r_PackedHalf2AtPtx2681R724, r_PackedHalf2AtPtx2841R706); // PTX L2913
	r_LaneIndexAtPtx2917 = uint32_t((threadIdx.x & 31u));										  // PTX L2917
	r_PackedHalf2AtPtx2920R792 = HalfMul(r_PackedHalf2AtPtx2688R726, r_PackedHalf2AtPtx2841R706); // PTX L2920
	r_LaneIndexAtPtx2924 = uint32_t((threadIdx.x & 31u));										  // PTX L2924
	r_PackedHalf2AtPtx2927R794 = HalfMul(r_PackedHalf2AtPtx2695R728, r_PackedHalf2AtPtx2841R706); // PTX L2927
	r_LaneIndexAtPtx2931 = uint32_t((threadIdx.x & 31u));										  // PTX L2931
	r_PackedHalf2AtPtx2934R796 = HalfMul(r_PackedHalf2AtPtx2702R730, r_PackedHalf2AtPtx2841R706); // PTX L2934
	r_LaneIndexAtPtx2938 = uint32_t((threadIdx.x & 31u));										  // PTX L2938
	r_PackedHalf2AtPtx2941R798 = HalfMul(r_PackedHalf2AtPtx2709R732, r_PackedHalf2AtPtx2841R706); // PTX L2941
	r_LaneIndexAtPtx2945 = uint32_t((threadIdx.x & 31u));										  // PTX L2945
	r_PackedHalf2AtPtx2948R800 = HalfMul(r_PackedHalf2AtPtx2716R734, r_PackedHalf2AtPtx2841R706); // PTX L2948
	r_LaneIndexAtPtx2952 = uint32_t((threadIdx.x & 31u));										  // PTX L2952
	r_PackedHalf2AtPtx2955R802 = HalfMul(r_PackedHalf2AtPtx2723R736, r_PackedHalf2AtPtx2841R706); // PTX L2955
	r_LaneIndexAtPtx2959 = uint32_t((threadIdx.x & 31u));										  // PTX L2959
	r_PackedHalf2AtPtx2962R804 = HalfMul(r_PackedHalf2AtPtx2730R738, r_PackedHalf2AtPtx2841R706); // PTX L2962
	r_LaneIndexAtPtx2966 = uint32_t((threadIdx.x & 31u));										  // PTX L2966
	r_PackedHalf2AtPtx2969R806 = HalfMul(r_PackedHalf2AtPtx2737R740, r_PackedHalf2AtPtx2841R706); // PTX L2969
	r_LaneIndexAtPtx2973 = uint32_t((threadIdx.x & 31u));										  // PTX L2973
	r_PackedHalf2AtPtx2976R808 = HalfMul(r_PackedHalf2AtPtx2744R742, r_PackedHalf2AtPtx2841R706); // PTX L2976
	r_LaneIndexAtPtx2980 = uint32_t((threadIdx.x & 31u));										  // PTX L2980
	r_PackedHalf2AtPtx2983R810 = HalfMul(r_PackedHalf2AtPtx2751R744, r_PackedHalf2AtPtx2841R706); // PTX L2983
	r_LaneIndexAtPtx2987 = uint32_t((threadIdx.x & 31u));										  // PTX L2987
	r_PackedHalf2AtPtx2990R812 = HalfMul(r_PackedHalf2AtPtx2758R746, r_PackedHalf2AtPtx2841R706); // PTX L2990
	r_LaneIndexAtPtx2994 = uint32_t((threadIdx.x & 31u));										  // PTX L2994
	r_PackedHalf2AtPtx2997R814 = HalfMul(r_PackedHalf2AtPtx2765R748, r_PackedHalf2AtPtx2841R706); // PTX L2997
	r_LaneIndexAtPtx3001 = uint32_t((threadIdx.x & 31u));										  // PTX L3001
	r_PackedHalf2AtPtx3004R816 = HalfMul(r_PackedHalf2AtPtx2772R750, r_PackedHalf2AtPtx2841R706); // PTX L3004
	r_LaneIndexAtPtx3008 = uint32_t((threadIdx.x & 31u));										  // PTX L3008
	r_PackedHalf2AtPtx3011R818 = HalfMul(r_PackedHalf2AtPtx2779R752, r_PackedHalf2AtPtx2841R706); // PTX L3011
	r_LaneIndexAtPtx3015 = uint32_t((threadIdx.x & 31u));										  // PTX L3015
	r_PackedHalf2AtPtx3018R820 = HalfMul(r_PackedHalf2AtPtx2786R754, r_PackedHalf2AtPtx2841R706); // PTX L3018
	r_LaneIndexAtPtx3022 = uint32_t((threadIdx.x & 31u));										  // PTX L3022
	r_PackedHalf2AtPtx3025R822 = HalfMul(r_PackedHalf2AtPtx2793R756, r_PackedHalf2AtPtx2841R706); // PTX L3025
	r_LaneIndexAtPtx3029 = uint32_t((threadIdx.x & 31u));										  // PTX L3029
	r_PackedHalf2AtPtx3032R824 = HalfMul(r_PackedHalf2AtPtx2800R758, r_PackedHalf2AtPtx2841R706); // PTX L3032
	r_LaneIndexAtPtx3036 = uint32_t((threadIdx.x & 31u));										  // PTX L3036
	r_PackedHalf2AtPtx3039R826 = HalfMul(r_PackedHalf2AtPtx2807R760, r_PackedHalf2AtPtx2841R706); // PTX L3039
	r_LaneIndexAtPtx3043 = uint32_t((threadIdx.x & 31u));										  // PTX L3043
	r_PackedHalf2AtPtx3046R828 = HalfMul(r_PackedHalf2AtPtx2814R762, r_PackedHalf2AtPtx2841R706); // PTX L3046
	r_LaneIndexAtPtx3050 = uint32_t((threadIdx.x & 31u));										  // PTX L3050
	r_PackedHalf2AtPtx3053R830 = HalfMul(r_PackedHalf2AtPtx2821R764, r_PackedHalf2AtPtx2841R706); // PTX L3053
	r_LaneIndexAtPtx3057 = uint32_t((threadIdx.x & 31u));										  // PTX L3057
	r_PackedHalf2AtPtx3060R832 = HalfMul(r_PackedHalf2AtPtx2828R766, r_PackedHalf2AtPtx2841R706); // PTX L3060
	r_LaneIndexAtPtx3064 = uint32_t((threadIdx.x & 31u));										  // PTX L3064
	r_PackedHalf2AtPtx3067R834 = HalfMul(r_PackedHalf2AtPtx2835R768, r_PackedHalf2AtPtx2841R706); // PTX L3067
	r_PtxRegister869 = r_ThreadY & 1;															  // PTX L3070
	r_PtxRegister870 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(1));						  // PTX L3071
	r_PtxRegister871 = r_PtxRegister870 | r_PtxRegister869;										  // PTX L3072
	g_RecordByteAddressAtPtx3073 = g_RecordBaseAddress;											  // PTX L3073
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister871)) * int64_t(int32_t(4)));	  // PTX L3074
	g_RecordByteAddressAtPtx3075 =
		uint64_t(g_RecordByteAddressAtPtx3073) + uint64_t(r_PtxU64Register139);					  // PTX L3075
	r_PtxRegister769 = *reinterpret_cast<const uint32_t*>(g_RecordByteAddressAtPtx3075);		  // PTX L3076
	r_PackedHalf2AtPtx3078R772 = FloatToHalf2(r_PtxRegister769);								  // PTX L3078
	r_LaneIndexAtPtx3084 = uint32_t((threadIdx.x & 31u));										  // PTX L3084
	r_PackedHalf2AtPtx3087R835 = HalfMul(r_PackedHalf2AtPtx2850R771, r_PackedHalf2AtPtx3078R772); // PTX L3087
	r_LaneIndexAtPtx3091 = uint32_t((threadIdx.x & 31u));										  // PTX L3091
	r_PackedHalf2AtPtx3094R837 = HalfMul(r_PackedHalf2AtPtx2857R774, r_PackedHalf2AtPtx3078R772); // PTX L3094
	r_LaneIndexAtPtx3098 = uint32_t((threadIdx.x & 31u));										  // PTX L3098
	r_PackedHalf2AtPtx3101R836 = HalfMul(r_PackedHalf2AtPtx2864R776, r_PackedHalf2AtPtx3078R772); // PTX L3101
	r_LaneIndexAtPtx3105 = uint32_t((threadIdx.x & 31u));										  // PTX L3105
	r_PackedHalf2AtPtx3108R838 = HalfMul(r_PackedHalf2AtPtx2871R778, r_PackedHalf2AtPtx3078R772); // PTX L3108
	r_LaneIndexAtPtx3112 = uint32_t((threadIdx.x & 31u));										  // PTX L3112
	r_PackedHalf2AtPtx3115R839 = HalfMul(r_PackedHalf2AtPtx2878R780, r_PackedHalf2AtPtx3078R772); // PTX L3115
	r_LaneIndexAtPtx3119 = uint32_t((threadIdx.x & 31u));										  // PTX L3119
	r_PackedHalf2AtPtx3122R841 = HalfMul(r_PackedHalf2AtPtx2885R782, r_PackedHalf2AtPtx3078R772); // PTX L3122
	r_LaneIndexAtPtx3126 = uint32_t((threadIdx.x & 31u));										  // PTX L3126
	r_PackedHalf2AtPtx3129R840 = HalfMul(r_PackedHalf2AtPtx2892R784, r_PackedHalf2AtPtx3078R772); // PTX L3129
	r_LaneIndexAtPtx3133 = uint32_t((threadIdx.x & 31u));										  // PTX L3133
	r_PackedHalf2AtPtx3136R842 = HalfMul(r_PackedHalf2AtPtx2899R786, r_PackedHalf2AtPtx3078R772); // PTX L3136
	r_LaneIndexAtPtx3140 = uint32_t((threadIdx.x & 31u));										  // PTX L3140
	r_PackedHalf2AtPtx3143R843 = HalfMul(r_PackedHalf2AtPtx2906R788, r_PackedHalf2AtPtx3078R772); // PTX L3143
	r_LaneIndexAtPtx3147 = uint32_t((threadIdx.x & 31u));										  // PTX L3147
	r_PackedHalf2AtPtx3150R845 = HalfMul(r_PackedHalf2AtPtx2913R790, r_PackedHalf2AtPtx3078R772); // PTX L3150
	r_LaneIndexAtPtx3154 = uint32_t((threadIdx.x & 31u));										  // PTX L3154
	r_PackedHalf2AtPtx3157R844 = HalfMul(r_PackedHalf2AtPtx2920R792, r_PackedHalf2AtPtx3078R772); // PTX L3157
	r_LaneIndexAtPtx3161 = uint32_t((threadIdx.x & 31u));										  // PTX L3161
	r_PackedHalf2AtPtx3164R846 = HalfMul(r_PackedHalf2AtPtx2927R794, r_PackedHalf2AtPtx3078R772); // PTX L3164
	r_LaneIndexAtPtx3168 = uint32_t((threadIdx.x & 31u));										  // PTX L3168
	r_PackedHalf2AtPtx3171R847 = HalfMul(r_PackedHalf2AtPtx2934R796, r_PackedHalf2AtPtx3078R772); // PTX L3171
	r_LaneIndexAtPtx3175 = uint32_t((threadIdx.x & 31u));										  // PTX L3175
	r_PackedHalf2AtPtx3178R849 = HalfMul(r_PackedHalf2AtPtx2941R798, r_PackedHalf2AtPtx3078R772); // PTX L3178
	r_LaneIndexAtPtx3182 = uint32_t((threadIdx.x & 31u));										  // PTX L3182
	r_PackedHalf2AtPtx3185R848 = HalfMul(r_PackedHalf2AtPtx2948R800, r_PackedHalf2AtPtx3078R772); // PTX L3185
	r_LaneIndexAtPtx3189 = uint32_t((threadIdx.x & 31u));										  // PTX L3189
	r_PackedHalf2AtPtx3192R850 = HalfMul(r_PackedHalf2AtPtx2955R802, r_PackedHalf2AtPtx3078R772); // PTX L3192
	r_LaneIndexAtPtx3196 = uint32_t((threadIdx.x & 31u));										  // PTX L3196
	r_PackedHalf2AtPtx3199R851 = HalfMul(r_PackedHalf2AtPtx2962R804, r_PackedHalf2AtPtx3078R772); // PTX L3199
	r_LaneIndexAtPtx3203 = uint32_t((threadIdx.x & 31u));										  // PTX L3203
	r_PackedHalf2AtPtx3206R853 = HalfMul(r_PackedHalf2AtPtx2969R806, r_PackedHalf2AtPtx3078R772); // PTX L3206
	r_LaneIndexAtPtx3210 = uint32_t((threadIdx.x & 31u));										  // PTX L3210
	r_PackedHalf2AtPtx3213R852 = HalfMul(r_PackedHalf2AtPtx2976R808, r_PackedHalf2AtPtx3078R772); // PTX L3213
	r_LaneIndexAtPtx3217 = uint32_t((threadIdx.x & 31u));										  // PTX L3217
	r_PackedHalf2AtPtx3220R854 = HalfMul(r_PackedHalf2AtPtx2983R810, r_PackedHalf2AtPtx3078R772); // PTX L3220
	r_LaneIndexAtPtx3224 = uint32_t((threadIdx.x & 31u));										  // PTX L3224
	r_PackedHalf2AtPtx3227R855 = HalfMul(r_PackedHalf2AtPtx2990R812, r_PackedHalf2AtPtx3078R772); // PTX L3227
	r_LaneIndexAtPtx3231 = uint32_t((threadIdx.x & 31u));										  // PTX L3231
	r_PackedHalf2AtPtx3234R857 = HalfMul(r_PackedHalf2AtPtx2997R814, r_PackedHalf2AtPtx3078R772); // PTX L3234
	r_LaneIndexAtPtx3238 = uint32_t((threadIdx.x & 31u));										  // PTX L3238
	r_PackedHalf2AtPtx3241R856 = HalfMul(r_PackedHalf2AtPtx3004R816, r_PackedHalf2AtPtx3078R772); // PTX L3241
	r_LaneIndexAtPtx3245 = uint32_t((threadIdx.x & 31u));										  // PTX L3245
	r_PackedHalf2AtPtx3248R858 = HalfMul(r_PackedHalf2AtPtx3011R818, r_PackedHalf2AtPtx3078R772); // PTX L3248
	r_LaneIndexAtPtx3252 = uint32_t((threadIdx.x & 31u));										  // PTX L3252
	r_PackedHalf2AtPtx3255R859 = HalfMul(r_PackedHalf2AtPtx3018R820, r_PackedHalf2AtPtx3078R772); // PTX L3255
	r_LaneIndexAtPtx3259 = uint32_t((threadIdx.x & 31u));										  // PTX L3259
	r_PackedHalf2AtPtx3262R861 = HalfMul(r_PackedHalf2AtPtx3025R822, r_PackedHalf2AtPtx3078R772); // PTX L3262
	r_LaneIndexAtPtx3266 = uint32_t((threadIdx.x & 31u));										  // PTX L3266
	r_PackedHalf2AtPtx3269R860 = HalfMul(r_PackedHalf2AtPtx3032R824, r_PackedHalf2AtPtx3078R772); // PTX L3269
	r_LaneIndexAtPtx3273 = uint32_t((threadIdx.x & 31u));										  // PTX L3273
	r_PackedHalf2AtPtx3276R862 = HalfMul(r_PackedHalf2AtPtx3039R826, r_PackedHalf2AtPtx3078R772); // PTX L3276
	r_LaneIndexAtPtx3280 = uint32_t((threadIdx.x & 31u));										  // PTX L3280
	r_PackedHalf2AtPtx3283R863 = HalfMul(r_PackedHalf2AtPtx3046R828, r_PackedHalf2AtPtx3078R772); // PTX L3283
	r_LaneIndexAtPtx3287 = uint32_t((threadIdx.x & 31u));										  // PTX L3287
	r_PackedHalf2AtPtx3290R865 = HalfMul(r_PackedHalf2AtPtx3053R830, r_PackedHalf2AtPtx3078R772); // PTX L3290
	r_LaneIndexAtPtx3294 = uint32_t((threadIdx.x & 31u));										  // PTX L3294
	r_PackedHalf2AtPtx3297R864 = HalfMul(r_PackedHalf2AtPtx3060R832, r_PackedHalf2AtPtx3078R772); // PTX L3297
	r_LaneIndexAtPtx3301 = uint32_t((threadIdx.x & 31u));										  // PTX L3301
	r_PackedHalf2AtPtx3304R866 = HalfMul(r_PackedHalf2AtPtx3067R834, r_PackedHalf2AtPtx3078R772); // PTX L3304
	r_ConvertedE4PairAtPtx3308Rs9 = PublishE4(r_PackedHalf2AtPtx3087R835);						  // PTX L3308
	r_ConvertedE4PairAtPtx3311Rs10 = PublishE4(r_PackedHalf2AtPtx3101R836);						  // PTX L3311
	r_ConvertedE4PairAtPtx3314Rs11 = PublishE4(r_PackedHalf2AtPtx3094R837);						  // PTX L3314
	r_ConvertedE4PairAtPtx3317Rs12 = PublishE4(r_PackedHalf2AtPtx3108R838);						  // PTX L3317
	r_ConvertedE4PairAtPtx3320Rs13 = PublishE4(r_PackedHalf2AtPtx3115R839);						  // PTX L3320
	r_ConvertedE4PairAtPtx3323Rs14 = PublishE4(r_PackedHalf2AtPtx3129R840);						  // PTX L3323
	r_ConvertedE4PairAtPtx3326Rs15 = PublishE4(r_PackedHalf2AtPtx3122R841);						  // PTX L3326
	r_ConvertedE4PairAtPtx3329Rs16 = PublishE4(r_PackedHalf2AtPtx3136R842);						  // PTX L3329
	r_ConvertedE4PairAtPtx3332Rs17 = PublishE4(r_PackedHalf2AtPtx3143R843);						  // PTX L3332
	r_ConvertedE4PairAtPtx3335Rs18 = PublishE4(r_PackedHalf2AtPtx3157R844);						  // PTX L3335
	r_ConvertedE4PairAtPtx3338Rs19 = PublishE4(r_PackedHalf2AtPtx3150R845);						  // PTX L3338
	r_ConvertedE4PairAtPtx3341Rs20 = PublishE4(r_PackedHalf2AtPtx3164R846);						  // PTX L3341
	r_ConvertedE4PairAtPtx3344Rs21 = PublishE4(r_PackedHalf2AtPtx3171R847);						  // PTX L3344
	r_ConvertedE4PairAtPtx3347Rs22 = PublishE4(r_PackedHalf2AtPtx3185R848);						  // PTX L3347
	r_ConvertedE4PairAtPtx3350Rs23 = PublishE4(r_PackedHalf2AtPtx3178R849);						  // PTX L3350
	r_ConvertedE4PairAtPtx3353Rs24 = PublishE4(r_PackedHalf2AtPtx3192R850);						  // PTX L3353
	r_ConvertedE4PairAtPtx3356Rs25 = PublishE4(r_PackedHalf2AtPtx3199R851);						  // PTX L3356
	r_ConvertedE4PairAtPtx3359Rs26 = PublishE4(r_PackedHalf2AtPtx3213R852);						  // PTX L3359
	r_ConvertedE4PairAtPtx3362Rs27 = PublishE4(r_PackedHalf2AtPtx3206R853);						  // PTX L3362
	r_ConvertedE4PairAtPtx3365Rs28 = PublishE4(r_PackedHalf2AtPtx3220R854);						  // PTX L3365
	r_ConvertedE4PairAtPtx3368Rs29 = PublishE4(r_PackedHalf2AtPtx3227R855);						  // PTX L3368
	r_ConvertedE4PairAtPtx3371Rs30 = PublishE4(r_PackedHalf2AtPtx3241R856);						  // PTX L3371
	r_ConvertedE4PairAtPtx3374Rs31 = PublishE4(r_PackedHalf2AtPtx3234R857);						  // PTX L3374
	r_ConvertedE4PairAtPtx3377Rs32 = PublishE4(r_PackedHalf2AtPtx3248R858);						  // PTX L3377
	r_ConvertedE4PairAtPtx3380Rs33 = PublishE4(r_PackedHalf2AtPtx3255R859);						  // PTX L3380
	r_ConvertedE4PairAtPtx3383Rs34 = PublishE4(r_PackedHalf2AtPtx3269R860);						  // PTX L3383
	r_ConvertedE4PairAtPtx3386Rs35 = PublishE4(r_PackedHalf2AtPtx3262R861);						  // PTX L3386
	r_ConvertedE4PairAtPtx3389Rs36 = PublishE4(r_PackedHalf2AtPtx3276R862);						  // PTX L3389
	r_ConvertedE4PairAtPtx3392Rs37 = PublishE4(r_PackedHalf2AtPtx3283R863);						  // PTX L3392
	r_ConvertedE4PairAtPtx3395Rs38 = PublishE4(r_PackedHalf2AtPtx3297R864);						  // PTX L3395
	r_ConvertedE4PairAtPtx3398Rs39 = PublishE4(r_PackedHalf2AtPtx3290R865);						  // PTX L3398
	r_ConvertedE4PairAtPtx3401Rs40 = PublishE4(r_PackedHalf2AtPtx3304R866);						  // PTX L3401
	r_PtxRegister872 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(1));								  // PTX L3403
	r_PtxRegister873 = r_PtxRegister872 & 2044;													  // PTX L3404
	r_PtxRegister43 = uint32_t(r_PtxRegister873) + uint32_t(r_PtxRegister6);					  // PTX L3405
	r_bPtxPredicate30 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister1452);					  // PTX L3406
	r_PtxRegister874 = ShiftLeft(uint32_t(r_PtxRegister871), uint32_t(7));						  // PTX L3407
	r_PtxRegister875 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(12));						  // PTX L3408
	r_PtxRegister44 = uint32_t(r_PtxRegister875) + uint32_t(r_PtxRegister874);					  // PTX L3409
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister44)) * int64_t(int32_t(4)));	  // PTX L3410
	r_PtxU64Register22 = uint64_t(r_QBits) + uint64_t(r_PtxU64Register141);						  // PTX L3411
	if (r_bPtxPredicate30)
	{
		goto L__BB50_75;
	} // PTX L3412
	r_PackedE4WordAtPtx3413R880 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3326Rs15, r_ConvertedE4PairAtPtx3329Rs16); // PTX L3413
	r_PackedE4WordAtPtx3414R879 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3320Rs13, r_ConvertedE4PairAtPtx3323Rs14); // PTX L3414
	r_PackedE4WordAtPtx3415R878 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3314Rs11, r_ConvertedE4PairAtPtx3317Rs12); // PTX L3415
	r_PackedE4WordAtPtx3416R877 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3308Rs9, r_ConvertedE4PairAtPtx3311Rs10); // PTX L3416
	r_LaneIndexAtPtx3418 = uint32_t((threadIdx.x & 31u));							  // PTX L3418
	r_PtxU64Register143 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3418)) * int64_t(int32_t(16)));		// PTX L3420
	r_PtxU64Register142 = uint64_t(r_PtxU64Register22) + uint64_t(r_PtxU64Register143); // PTX L3421
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(r_PtxU64Register142, make_uint4(r_PackedE4WordAtPtx3416R877, r_PackedE4WordAtPtx3415R878,
													r_PackedE4WordAtPtx3414R879,
													r_PackedE4WordAtPtx3413R880)); // PTX L3423
L__BB50_75:																		   // PTX L3425
	r_PtxRegister45 = uint32_t(r_PtxRegister43) + uint32_t(1);					   // PTX L3426
	r_bPtxPredicate31 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister1452);	   // PTX L3427
	if (r_bPtxPredicate31)
	{
		goto L__BB50_77;
	} // PTX L3428
	r_LaneIndexAtPtx3430 = uint32_t((threadIdx.x & 31u)); // PTX L3430
	r_PtxU64Register145 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3430)) * int64_t(int32_t(16)));		// PTX L3432
	r_PtxU64Register146 = uint64_t(r_PtxU64Register22) + uint64_t(r_PtxU64Register145); // PTX L3433
	r_PtxU64Register144 = uint64_t(r_PtxU64Register146) + uint64_t(16384);				// PTX L3434
	r_PackedE4WordAtPtx3435R885 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3350Rs23, r_ConvertedE4PairAtPtx3353Rs24); // PTX L3435
	r_PackedE4WordAtPtx3436R884 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3344Rs21, r_ConvertedE4PairAtPtx3347Rs22); // PTX L3436
	r_PackedE4WordAtPtx3437R883 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3338Rs19, r_ConvertedE4PairAtPtx3341Rs20); // PTX L3437
	r_PackedE4WordAtPtx3438R882 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3332Rs17, r_ConvertedE4PairAtPtx3335Rs18); // PTX L3438
	StoreNoAllocate(r_PtxU64Register144, make_uint4(r_PackedE4WordAtPtx3438R882, r_PackedE4WordAtPtx3437R883,
													r_PackedE4WordAtPtx3436R884,
													r_PackedE4WordAtPtx3435R885)); // PTX L3440
L__BB50_77:																		   // PTX L3442
	r_PtxRegister46 = uint32_t(r_PtxRegister43) + uint32_t(2);					   // PTX L3443
	r_bPtxPredicate32 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister1452);	   // PTX L3444
	if (r_bPtxPredicate32)
	{
		goto L__BB50_79;
	} // PTX L3445
	r_LaneIndexAtPtx3447 = uint32_t((threadIdx.x & 31u)); // PTX L3447
	r_PtxU64Register148 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3447)) * int64_t(int32_t(16)));		// PTX L3449
	r_PtxU64Register149 = uint64_t(r_PtxU64Register22) + uint64_t(r_PtxU64Register148); // PTX L3450
	r_PtxU64Register147 = uint64_t(r_PtxU64Register149) + uint64_t(32768);				// PTX L3451
	r_PackedE4WordAtPtx3452R890 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3374Rs31, r_ConvertedE4PairAtPtx3377Rs32); // PTX L3452
	r_PackedE4WordAtPtx3453R889 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3368Rs29, r_ConvertedE4PairAtPtx3371Rs30); // PTX L3453
	r_PackedE4WordAtPtx3454R888 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3362Rs27, r_ConvertedE4PairAtPtx3365Rs28); // PTX L3454
	r_PackedE4WordAtPtx3455R887 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3356Rs25, r_ConvertedE4PairAtPtx3359Rs26); // PTX L3455
	StoreNoAllocate(r_PtxU64Register147, make_uint4(r_PackedE4WordAtPtx3455R887, r_PackedE4WordAtPtx3454R888,
													r_PackedE4WordAtPtx3453R889,
													r_PackedE4WordAtPtx3452R890)); // PTX L3457
L__BB50_79:																		   // PTX L3459
	r_PtxRegister47 = uint32_t(r_PtxRegister43) + uint32_t(3);					   // PTX L3460
	r_bPtxPredicate33 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister1452);	   // PTX L3461
	if (r_bPtxPredicate33)
	{
		goto L__BB50_81;
	} // PTX L3462
	r_LaneIndexAtPtx3464 = uint32_t((threadIdx.x & 31u)); // PTX L3464
	r_PtxU64Register151 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3464)) * int64_t(int32_t(16)));		// PTX L3466
	r_PtxU64Register152 = uint64_t(r_PtxU64Register22) + uint64_t(r_PtxU64Register151); // PTX L3467
	r_PtxU64Register150 = uint64_t(r_PtxU64Register152) + uint64_t(49152);				// PTX L3468
	r_PackedE4WordAtPtx3469R895 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3398Rs39, r_ConvertedE4PairAtPtx3401Rs40); // PTX L3469
	r_PackedE4WordAtPtx3470R894 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3392Rs37, r_ConvertedE4PairAtPtx3395Rs38); // PTX L3470
	r_PackedE4WordAtPtx3471R893 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3386Rs35, r_ConvertedE4PairAtPtx3389Rs36); // PTX L3471
	r_PackedE4WordAtPtx3472R892 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3380Rs33, r_ConvertedE4PairAtPtx3383Rs34); // PTX L3472
	StoreNoAllocate(r_PtxU64Register150, make_uint4(r_PackedE4WordAtPtx3472R892, r_PackedE4WordAtPtx3471R893,
													r_PackedE4WordAtPtx3470R894,
													r_PackedE4WordAtPtx3469R895));			  // PTX L3474
L__BB50_81:																					  // PTX L3476
	r_PtxRegister896 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(13));					  // PTX L3477
	r_PtxRegister897 = uint32_t(r_PtxRegister896) + uint32_t(r_PtxRegister34);				  // PTX L3478
	r_bPtxPredicate34 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister31);				  // PTX L3479
	r_bPtxPredicate35 = uint64_t(g_ScratchBaseAddress) == uint64_t(0);						  // PTX L3480
	r_PtxU64Register153 = r_bPtxPredicate35 ? 0 : g_ScratchByteAddressAtPtx1346;			  // PTX L3481
	r_PtxU64Register154 = uint64_t(int64_t(int32_t(r_PtxRegister897)) * int64_t(int32_t(4))); // PTX L3482
	r_PtxU64Register23 = uint64_t(r_PtxU64Register153) + uint64_t(r_PtxU64Register154);		  // PTX L3483
	r_PackedHalf2AtPtx3484R1606 = uint32_t(r_PackedHalf2AtPtx5219R1666);					  // PTX L3484
	r_PackedHalf2AtPtx3485R1607 = uint32_t(r_PackedHalf2AtPtx5219R1666);					  // PTX L3485
	r_PackedHalf2AtPtx3486R1608 = uint32_t(r_PackedHalf2AtPtx5219R1666);					  // PTX L3486
	r_PackedHalf2AtPtx3487R1609 = uint32_t(r_PackedHalf2AtPtx5219R1666);					  // PTX L3487
	if (r_bPtxPredicate34)
	{
		goto L__BB50_83;
	} // PTX L3488
	r_LaneIndexAtPtx3490 = uint32_t((threadIdx.x & 31u)); // PTX L3490
	r_PtxU64Register156 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3490)) * int64_t(int32_t(16)));		// PTX L3492
	r_PtxU64Register155 = uint64_t(r_PtxU64Register23) + uint64_t(r_PtxU64Register156); // PTX L3493
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register155));
		r_PackedHalf2AtPtx3484R1606 = r_Value.x;
		r_PackedHalf2AtPtx3485R1607 = r_Value.y;
		r_PackedHalf2AtPtx3486R1608 = r_Value.z;
		r_PackedHalf2AtPtx3487R1609 = r_Value.w;
	} // PTX L3495
L__BB50_83:																	  // PTX L3497
	r_bPtxPredicate36 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister31); // PTX L3498
	r_PtxU64Register24 = uint64_t(r_PtxU64Register23) + uint64_t(512);		  // PTX L3499
	r_PackedHalf2AtPtx3500R1610 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3500
	r_PackedHalf2AtPtx3501R1611 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3501
	r_PackedHalf2AtPtx3502R1612 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3502
	r_PackedHalf2AtPtx3503R1613 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3503
	if (r_bPtxPredicate36)
	{
		goto L__BB50_85;
	} // PTX L3504
	r_LaneIndexAtPtx3506 = uint32_t((threadIdx.x & 31u)); // PTX L3506
	r_PtxU64Register158 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3506)) * int64_t(int32_t(16)));		// PTX L3508
	r_PtxU64Register157 = uint64_t(r_PtxU64Register24) + uint64_t(r_PtxU64Register158); // PTX L3509
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register157));
		r_PackedHalf2AtPtx3500R1610 = r_Value.x;
		r_PackedHalf2AtPtx3501R1611 = r_Value.y;
		r_PackedHalf2AtPtx3502R1612 = r_Value.z;
		r_PackedHalf2AtPtx3503R1613 = r_Value.w;
	} // PTX L3511
L__BB50_85:																	  // PTX L3513
	r_bPtxPredicate37 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister31); // PTX L3514
	r_PtxU64Register25 = uint64_t(r_PtxU64Register24) + uint64_t(32256);	  // PTX L3515
	r_PackedHalf2AtPtx3516R1614 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3516
	r_PackedHalf2AtPtx3517R1615 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3517
	r_PackedHalf2AtPtx3518R1616 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3518
	r_PackedHalf2AtPtx3519R1617 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3519
	if (r_bPtxPredicate37)
	{
		goto L__BB50_87;
	} // PTX L3520
	r_LaneIndexAtPtx3522 = uint32_t((threadIdx.x & 31u)); // PTX L3522
	r_PtxU64Register160 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3522)) * int64_t(int32_t(16)));		// PTX L3524
	r_PtxU64Register159 = uint64_t(r_PtxU64Register25) + uint64_t(r_PtxU64Register160); // PTX L3525
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register159));
		r_PackedHalf2AtPtx3516R1614 = r_Value.x;
		r_PackedHalf2AtPtx3517R1615 = r_Value.y;
		r_PackedHalf2AtPtx3518R1616 = r_Value.z;
		r_PackedHalf2AtPtx3519R1617 = r_Value.w;
	} // PTX L3527
L__BB50_87:																	  // PTX L3529
	r_bPtxPredicate38 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister31); // PTX L3530
	r_PtxU64Register26 = uint64_t(r_PtxU64Register25) + uint64_t(512);		  // PTX L3531
	r_PackedHalf2AtPtx3532R1618 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3532
	r_PackedHalf2AtPtx3533R1619 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3533
	r_PackedHalf2AtPtx3534R1620 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3534
	r_PackedHalf2AtPtx3535R1621 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3535
	if (r_bPtxPredicate38)
	{
		goto L__BB50_89;
	} // PTX L3536
	r_LaneIndexAtPtx3538 = uint32_t((threadIdx.x & 31u)); // PTX L3538
	r_PtxU64Register162 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3538)) * int64_t(int32_t(16)));		// PTX L3540
	r_PtxU64Register161 = uint64_t(r_PtxU64Register26) + uint64_t(r_PtxU64Register162); // PTX L3541
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register161));
		r_PackedHalf2AtPtx3532R1618 = r_Value.x;
		r_PackedHalf2AtPtx3533R1619 = r_Value.y;
		r_PackedHalf2AtPtx3534R1620 = r_Value.z;
		r_PackedHalf2AtPtx3535R1621 = r_Value.w;
	} // PTX L3543
L__BB50_89:																	  // PTX L3545
	r_bPtxPredicate39 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister31); // PTX L3546
	r_PtxU64Register27 = uint64_t(r_PtxU64Register26) + uint64_t(32256);	  // PTX L3547
	r_PackedHalf2AtPtx3548R1622 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3548
	r_PackedHalf2AtPtx3549R1623 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3549
	r_PackedHalf2AtPtx3550R1624 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3550
	r_PackedHalf2AtPtx3551R1625 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3551
	if (r_bPtxPredicate39)
	{
		goto L__BB50_91;
	} // PTX L3552
	r_LaneIndexAtPtx3554 = uint32_t((threadIdx.x & 31u)); // PTX L3554
	r_PtxU64Register164 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3554)) * int64_t(int32_t(16)));		// PTX L3556
	r_PtxU64Register163 = uint64_t(r_PtxU64Register27) + uint64_t(r_PtxU64Register164); // PTX L3557
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register163));
		r_PackedHalf2AtPtx3548R1622 = r_Value.x;
		r_PackedHalf2AtPtx3549R1623 = r_Value.y;
		r_PackedHalf2AtPtx3550R1624 = r_Value.z;
		r_PackedHalf2AtPtx3551R1625 = r_Value.w;
	} // PTX L3559
L__BB50_91:																	  // PTX L3561
	r_bPtxPredicate40 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister31); // PTX L3562
	r_PtxU64Register28 = uint64_t(r_PtxU64Register27) + uint64_t(512);		  // PTX L3563
	r_PackedHalf2AtPtx3564R1626 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3564
	r_PackedHalf2AtPtx3565R1627 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3565
	r_PackedHalf2AtPtx3566R1628 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3566
	r_PackedHalf2AtPtx3567R1629 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3567
	if (r_bPtxPredicate40)
	{
		goto L__BB50_93;
	} // PTX L3568
	r_LaneIndexAtPtx3570 = uint32_t((threadIdx.x & 31u)); // PTX L3570
	r_PtxU64Register166 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3570)) * int64_t(int32_t(16)));		// PTX L3572
	r_PtxU64Register165 = uint64_t(r_PtxU64Register28) + uint64_t(r_PtxU64Register166); // PTX L3573
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register165));
		r_PackedHalf2AtPtx3564R1626 = r_Value.x;
		r_PackedHalf2AtPtx3565R1627 = r_Value.y;
		r_PackedHalf2AtPtx3566R1628 = r_Value.z;
		r_PackedHalf2AtPtx3567R1629 = r_Value.w;
	} // PTX L3575
L__BB50_93:																	  // PTX L3577
	r_bPtxPredicate41 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister31); // PTX L3578
	r_PtxU64Register29 = uint64_t(r_PtxU64Register28) + uint64_t(32256);	  // PTX L3579
	r_PackedHalf2AtPtx3580R1630 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3580
	r_PackedHalf2AtPtx3581R1631 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3581
	r_PackedHalf2AtPtx3582R1632 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3582
	r_PackedHalf2AtPtx3583R1633 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3583
	if (r_bPtxPredicate41)
	{
		goto L__BB50_95;
	} // PTX L3584
	r_LaneIndexAtPtx3586 = uint32_t((threadIdx.x & 31u)); // PTX L3586
	r_PtxU64Register168 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3586)) * int64_t(int32_t(16)));		// PTX L3588
	r_PtxU64Register167 = uint64_t(r_PtxU64Register29) + uint64_t(r_PtxU64Register168); // PTX L3589
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register167));
		r_PackedHalf2AtPtx3580R1630 = r_Value.x;
		r_PackedHalf2AtPtx3581R1631 = r_Value.y;
		r_PackedHalf2AtPtx3582R1632 = r_Value.z;
		r_PackedHalf2AtPtx3583R1633 = r_Value.w;
	} // PTX L3591
L__BB50_95:																	  // PTX L3593
	r_bPtxPredicate42 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister31); // PTX L3594
	r_PackedHalf2AtPtx3595R1634 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3595
	r_PackedHalf2AtPtx3596R1635 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3596
	r_PackedHalf2AtPtx3597R1636 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3597
	r_PackedHalf2AtPtx3598R1637 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L3598
	if (r_bPtxPredicate42)
	{
		goto L__BB50_97;
	} // PTX L3599
	r_LaneIndexAtPtx3601 = uint32_t((threadIdx.x & 31u)); // PTX L3601
	r_PtxU64Register170 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3601)) * int64_t(int32_t(16)));		// PTX L3603
	r_PtxU64Register171 = uint64_t(r_PtxU64Register29) + uint64_t(r_PtxU64Register170); // PTX L3604
	r_PtxU64Register169 = uint64_t(r_PtxU64Register171) + uint64_t(512);				// PTX L3605
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register169));
		r_PackedHalf2AtPtx3595R1634 = r_Value.x;
		r_PackedHalf2AtPtx3596R1635 = r_Value.y;
		r_PackedHalf2AtPtx3597R1636 = r_Value.z;
		r_PackedHalf2AtPtx3598R1637 = r_Value.w;
	} // PTX L3607
L__BB50_97:																		// PTX L3609
	r_bPtxPredicate43 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister1452); // PTX L3610
	r_LaneIndexAtPtx3612 = uint32_t((threadIdx.x & 31u));						// PTX L3612
	r_PackedHalf2AtPtx3615R939 =
		HalfAdd(r_PackedHalf2AtPtx3484R1606, r_MmaAccumulatorHalf2WordAtPtx1032R239); // PTX L3615
	r_LaneIndexAtPtx3619 = uint32_t((threadIdx.x & 31u));							  // PTX L3619
	r_PackedHalf2AtPtx3622R941 =
		HalfAdd(r_PackedHalf2AtPtx3485R1607, r_MmaAccumulatorHalf2WordAtPtx1032R240); // PTX L3622
	r_LaneIndexAtPtx3626 = uint32_t((threadIdx.x & 31u));							  // PTX L3626
	r_PackedHalf2AtPtx3629R943 =
		HalfAdd(r_PackedHalf2AtPtx3486R1608, r_MmaAccumulatorHalf2WordAtPtx1039R241); // PTX L3629
	r_LaneIndexAtPtx3633 = uint32_t((threadIdx.x & 31u));							  // PTX L3633
	r_PackedHalf2AtPtx3636R945 =
		HalfAdd(r_PackedHalf2AtPtx3487R1609, r_MmaAccumulatorHalf2WordAtPtx1039R242); // PTX L3636
	r_LaneIndexAtPtx3640 = uint32_t((threadIdx.x & 31u));							  // PTX L3640
	r_PackedHalf2AtPtx3643R947 =
		HalfAdd(r_PackedHalf2AtPtx3500R1610, r_MmaAccumulatorHalf2WordAtPtx1046R243); // PTX L3643
	r_LaneIndexAtPtx3647 = uint32_t((threadIdx.x & 31u));							  // PTX L3647
	r_PackedHalf2AtPtx3650R949 =
		HalfAdd(r_PackedHalf2AtPtx3501R1611, r_MmaAccumulatorHalf2WordAtPtx1046R244); // PTX L3650
	r_LaneIndexAtPtx3654 = uint32_t((threadIdx.x & 31u));							  // PTX L3654
	r_PackedHalf2AtPtx3657R951 =
		HalfAdd(r_PackedHalf2AtPtx3502R1612, r_MmaAccumulatorHalf2WordAtPtx1053R245); // PTX L3657
	r_LaneIndexAtPtx3661 = uint32_t((threadIdx.x & 31u));							  // PTX L3661
	r_PackedHalf2AtPtx3664R953 =
		HalfAdd(r_PackedHalf2AtPtx3503R1613, r_MmaAccumulatorHalf2WordAtPtx1053R246); // PTX L3664
	r_LaneIndexAtPtx3668 = uint32_t((threadIdx.x & 31u));							  // PTX L3668
	r_PackedHalf2AtPtx3671R955 =
		HalfAdd(r_PackedHalf2AtPtx3516R1614, r_MmaAccumulatorHalf2WordAtPtx1116R267); // PTX L3671
	r_LaneIndexAtPtx3675 = uint32_t((threadIdx.x & 31u));							  // PTX L3675
	r_PackedHalf2AtPtx3678R957 =
		HalfAdd(r_PackedHalf2AtPtx3517R1615, r_MmaAccumulatorHalf2WordAtPtx1116R268); // PTX L3678
	r_LaneIndexAtPtx3682 = uint32_t((threadIdx.x & 31u));							  // PTX L3682
	r_PackedHalf2AtPtx3685R959 =
		HalfAdd(r_PackedHalf2AtPtx3518R1616, r_MmaAccumulatorHalf2WordAtPtx1123R269); // PTX L3685
	r_LaneIndexAtPtx3689 = uint32_t((threadIdx.x & 31u));							  // PTX L3689
	r_PackedHalf2AtPtx3692R961 =
		HalfAdd(r_PackedHalf2AtPtx3519R1617, r_MmaAccumulatorHalf2WordAtPtx1123R270); // PTX L3692
	r_LaneIndexAtPtx3696 = uint32_t((threadIdx.x & 31u));							  // PTX L3696
	r_PackedHalf2AtPtx3699R963 =
		HalfAdd(r_PackedHalf2AtPtx3532R1618, r_MmaAccumulatorHalf2WordAtPtx1130R271); // PTX L3699
	r_LaneIndexAtPtx3703 = uint32_t((threadIdx.x & 31u));							  // PTX L3703
	r_PackedHalf2AtPtx3706R965 =
		HalfAdd(r_PackedHalf2AtPtx3533R1619, r_MmaAccumulatorHalf2WordAtPtx1130R272); // PTX L3706
	r_LaneIndexAtPtx3710 = uint32_t((threadIdx.x & 31u));							  // PTX L3710
	r_PackedHalf2AtPtx3713R967 =
		HalfAdd(r_PackedHalf2AtPtx3534R1620, r_MmaAccumulatorHalf2WordAtPtx1137R273); // PTX L3713
	r_LaneIndexAtPtx3717 = uint32_t((threadIdx.x & 31u));							  // PTX L3717
	r_PackedHalf2AtPtx3720R969 =
		HalfAdd(r_PackedHalf2AtPtx3535R1621, r_MmaAccumulatorHalf2WordAtPtx1137R274); // PTX L3720
	r_LaneIndexAtPtx3724 = uint32_t((threadIdx.x & 31u));							  // PTX L3724
	r_PackedHalf2AtPtx3727R971 =
		HalfAdd(r_PackedHalf2AtPtx3548R1622, r_MmaAccumulatorHalf2WordAtPtx1200R295); // PTX L3727
	r_LaneIndexAtPtx3731 = uint32_t((threadIdx.x & 31u));							  // PTX L3731
	r_PackedHalf2AtPtx3734R973 =
		HalfAdd(r_PackedHalf2AtPtx3549R1623, r_MmaAccumulatorHalf2WordAtPtx1200R296); // PTX L3734
	r_LaneIndexAtPtx3738 = uint32_t((threadIdx.x & 31u));							  // PTX L3738
	r_PackedHalf2AtPtx3741R975 =
		HalfAdd(r_PackedHalf2AtPtx3550R1624, r_MmaAccumulatorHalf2WordAtPtx1207R297); // PTX L3741
	r_LaneIndexAtPtx3745 = uint32_t((threadIdx.x & 31u));							  // PTX L3745
	r_PackedHalf2AtPtx3748R977 =
		HalfAdd(r_PackedHalf2AtPtx3551R1625, r_MmaAccumulatorHalf2WordAtPtx1207R298); // PTX L3748
	r_LaneIndexAtPtx3752 = uint32_t((threadIdx.x & 31u));							  // PTX L3752
	r_PackedHalf2AtPtx3755R979 =
		HalfAdd(r_PackedHalf2AtPtx3564R1626, r_MmaAccumulatorHalf2WordAtPtx1214R299); // PTX L3755
	r_LaneIndexAtPtx3759 = uint32_t((threadIdx.x & 31u));							  // PTX L3759
	r_PackedHalf2AtPtx3762R981 =
		HalfAdd(r_PackedHalf2AtPtx3565R1627, r_MmaAccumulatorHalf2WordAtPtx1214R300); // PTX L3762
	r_LaneIndexAtPtx3766 = uint32_t((threadIdx.x & 31u));							  // PTX L3766
	r_PackedHalf2AtPtx3769R983 =
		HalfAdd(r_PackedHalf2AtPtx3566R1628, r_MmaAccumulatorHalf2WordAtPtx1221R301); // PTX L3769
	r_LaneIndexAtPtx3773 = uint32_t((threadIdx.x & 31u));							  // PTX L3773
	r_PackedHalf2AtPtx3776R985 =
		HalfAdd(r_PackedHalf2AtPtx3567R1629, r_MmaAccumulatorHalf2WordAtPtx1221R302); // PTX L3776
	r_LaneIndexAtPtx3780 = uint32_t((threadIdx.x & 31u));							  // PTX L3780
	r_PackedHalf2AtPtx3783R987 =
		HalfAdd(r_PackedHalf2AtPtx3580R1630, r_MmaAccumulatorHalf2WordAtPtx1284R323); // PTX L3783
	r_LaneIndexAtPtx3787 = uint32_t((threadIdx.x & 31u));							  // PTX L3787
	r_PackedHalf2AtPtx3790R989 =
		HalfAdd(r_PackedHalf2AtPtx3581R1631, r_MmaAccumulatorHalf2WordAtPtx1284R324); // PTX L3790
	r_LaneIndexAtPtx3794 = uint32_t((threadIdx.x & 31u));							  // PTX L3794
	r_PackedHalf2AtPtx3797R991 =
		HalfAdd(r_PackedHalf2AtPtx3582R1632, r_MmaAccumulatorHalf2WordAtPtx1291R325); // PTX L3797
	r_LaneIndexAtPtx3801 = uint32_t((threadIdx.x & 31u));							  // PTX L3801
	r_PackedHalf2AtPtx3804R993 =
		HalfAdd(r_PackedHalf2AtPtx3583R1633, r_MmaAccumulatorHalf2WordAtPtx1291R326); // PTX L3804
	r_LaneIndexAtPtx3808 = uint32_t((threadIdx.x & 31u));							  // PTX L3808
	r_PackedHalf2AtPtx3811R995 =
		HalfAdd(r_PackedHalf2AtPtx3595R1634, r_MmaAccumulatorHalf2WordAtPtx1298R327); // PTX L3811
	r_LaneIndexAtPtx3815 = uint32_t((threadIdx.x & 31u));							  // PTX L3815
	r_PackedHalf2AtPtx3818R997 =
		HalfAdd(r_PackedHalf2AtPtx3596R1635, r_MmaAccumulatorHalf2WordAtPtx1298R328); // PTX L3818
	r_LaneIndexAtPtx3822 = uint32_t((threadIdx.x & 31u));							  // PTX L3822
	r_PackedHalf2AtPtx3825R999 =
		HalfAdd(r_PackedHalf2AtPtx3597R1636, r_MmaAccumulatorHalf2WordAtPtx1305R329); // PTX L3825
	r_LaneIndexAtPtx3829 = uint32_t((threadIdx.x & 31u));							  // PTX L3829
	r_PackedHalf2AtPtx3832R1001 =
		HalfAdd(r_PackedHalf2AtPtx3598R1637, r_MmaAccumulatorHalf2WordAtPtx1305R330); // PTX L3832
	r_LaneIndexAtPtx3836 = uint32_t((threadIdx.x & 31u));							  // PTX L3836
	r_PackedHalf2AtPtx3839R1003 =
		HalfMul(r_PackedHalf2AtPtx3615R939, r_PackedHalf2AtPtx3615R939); // PTX L3839
	r_LaneIndexAtPtx3843 = uint32_t((threadIdx.x & 31u));				 // PTX L3843
	r_PackedHalf2AtPtx3846R1006 =
		HalfMul(r_PackedHalf2AtPtx3622R941, r_PackedHalf2AtPtx3622R941); // PTX L3846
	r_LaneIndexAtPtx3850 = uint32_t((threadIdx.x & 31u));				 // PTX L3850
	r_PackedHalf2AtPtx3853R1009 =
		HalfMul(r_PackedHalf2AtPtx3629R943, r_PackedHalf2AtPtx3629R943); // PTX L3853
	r_LaneIndexAtPtx3857 = uint32_t((threadIdx.x & 31u));				 // PTX L3857
	r_PackedHalf2AtPtx3860R1012 =
		HalfMul(r_PackedHalf2AtPtx3636R945, r_PackedHalf2AtPtx3636R945); // PTX L3860
	r_LaneIndexAtPtx3864 = uint32_t((threadIdx.x & 31u));				 // PTX L3864
	r_PackedHalf2AtPtx3867R1004 =
		HalfMul(r_PackedHalf2AtPtx3643R947, r_PackedHalf2AtPtx3643R947); // PTX L3867
	r_LaneIndexAtPtx3871 = uint32_t((threadIdx.x & 31u));				 // PTX L3871
	r_PackedHalf2AtPtx3874R1007 =
		HalfMul(r_PackedHalf2AtPtx3650R949, r_PackedHalf2AtPtx3650R949); // PTX L3874
	r_LaneIndexAtPtx3878 = uint32_t((threadIdx.x & 31u));				 // PTX L3878
	r_PackedHalf2AtPtx3881R1010 =
		HalfMul(r_PackedHalf2AtPtx3657R951, r_PackedHalf2AtPtx3657R951); // PTX L3881
	r_LaneIndexAtPtx3885 = uint32_t((threadIdx.x & 31u));				 // PTX L3885
	r_PackedHalf2AtPtx3888R1013 =
		HalfMul(r_PackedHalf2AtPtx3664R953, r_PackedHalf2AtPtx3664R953); // PTX L3888
	r_LaneIndexAtPtx3892 = uint32_t((threadIdx.x & 31u));				 // PTX L3892
	r_PackedHalf2AtPtx3895R1015 =
		HalfMul(r_PackedHalf2AtPtx3671R955, r_PackedHalf2AtPtx3671R955); // PTX L3895
	r_LaneIndexAtPtx3899 = uint32_t((threadIdx.x & 31u));				 // PTX L3899
	r_PackedHalf2AtPtx3902R1018 =
		HalfMul(r_PackedHalf2AtPtx3678R957, r_PackedHalf2AtPtx3678R957); // PTX L3902
	r_LaneIndexAtPtx3906 = uint32_t((threadIdx.x & 31u));				 // PTX L3906
	r_PackedHalf2AtPtx3909R1021 =
		HalfMul(r_PackedHalf2AtPtx3685R959, r_PackedHalf2AtPtx3685R959); // PTX L3909
	r_LaneIndexAtPtx3913 = uint32_t((threadIdx.x & 31u));				 // PTX L3913
	r_PackedHalf2AtPtx3916R1024 =
		HalfMul(r_PackedHalf2AtPtx3692R961, r_PackedHalf2AtPtx3692R961); // PTX L3916
	r_LaneIndexAtPtx3920 = uint32_t((threadIdx.x & 31u));				 // PTX L3920
	r_PackedHalf2AtPtx3923R1016 =
		HalfMul(r_PackedHalf2AtPtx3699R963, r_PackedHalf2AtPtx3699R963); // PTX L3923
	r_LaneIndexAtPtx3927 = uint32_t((threadIdx.x & 31u));				 // PTX L3927
	r_PackedHalf2AtPtx3930R1019 =
		HalfMul(r_PackedHalf2AtPtx3706R965, r_PackedHalf2AtPtx3706R965); // PTX L3930
	r_LaneIndexAtPtx3934 = uint32_t((threadIdx.x & 31u));				 // PTX L3934
	r_PackedHalf2AtPtx3937R1022 =
		HalfMul(r_PackedHalf2AtPtx3713R967, r_PackedHalf2AtPtx3713R967); // PTX L3937
	r_LaneIndexAtPtx3941 = uint32_t((threadIdx.x & 31u));				 // PTX L3941
	r_PackedHalf2AtPtx3944R1025 =
		HalfMul(r_PackedHalf2AtPtx3720R969, r_PackedHalf2AtPtx3720R969); // PTX L3944
	r_LaneIndexAtPtx3948 = uint32_t((threadIdx.x & 31u));				 // PTX L3948
	r_PackedHalf2AtPtx3951R1027 =
		HalfMul(r_PackedHalf2AtPtx3727R971, r_PackedHalf2AtPtx3727R971); // PTX L3951
	r_LaneIndexAtPtx3955 = uint32_t((threadIdx.x & 31u));				 // PTX L3955
	r_PackedHalf2AtPtx3958R1030 =
		HalfMul(r_PackedHalf2AtPtx3734R973, r_PackedHalf2AtPtx3734R973); // PTX L3958
	r_LaneIndexAtPtx3962 = uint32_t((threadIdx.x & 31u));				 // PTX L3962
	r_PackedHalf2AtPtx3965R1033 =
		HalfMul(r_PackedHalf2AtPtx3741R975, r_PackedHalf2AtPtx3741R975); // PTX L3965
	r_LaneIndexAtPtx3969 = uint32_t((threadIdx.x & 31u));				 // PTX L3969
	r_PackedHalf2AtPtx3972R1036 =
		HalfMul(r_PackedHalf2AtPtx3748R977, r_PackedHalf2AtPtx3748R977); // PTX L3972
	r_LaneIndexAtPtx3976 = uint32_t((threadIdx.x & 31u));				 // PTX L3976
	r_PackedHalf2AtPtx3979R1028 =
		HalfMul(r_PackedHalf2AtPtx3755R979, r_PackedHalf2AtPtx3755R979); // PTX L3979
	r_LaneIndexAtPtx3983 = uint32_t((threadIdx.x & 31u));				 // PTX L3983
	r_PackedHalf2AtPtx3986R1031 =
		HalfMul(r_PackedHalf2AtPtx3762R981, r_PackedHalf2AtPtx3762R981); // PTX L3986
	r_LaneIndexAtPtx3990 = uint32_t((threadIdx.x & 31u));				 // PTX L3990
	r_PackedHalf2AtPtx3993R1034 =
		HalfMul(r_PackedHalf2AtPtx3769R983, r_PackedHalf2AtPtx3769R983); // PTX L3993
	r_LaneIndexAtPtx3997 = uint32_t((threadIdx.x & 31u));				 // PTX L3997
	r_PackedHalf2AtPtx4000R1037 =
		HalfMul(r_PackedHalf2AtPtx3776R985, r_PackedHalf2AtPtx3776R985); // PTX L4000
	r_LaneIndexAtPtx4004 = uint32_t((threadIdx.x & 31u));				 // PTX L4004
	r_PackedHalf2AtPtx4007R1039 =
		HalfMul(r_PackedHalf2AtPtx3783R987, r_PackedHalf2AtPtx3783R987); // PTX L4007
	r_LaneIndexAtPtx4011 = uint32_t((threadIdx.x & 31u));				 // PTX L4011
	r_PackedHalf2AtPtx4014R1042 =
		HalfMul(r_PackedHalf2AtPtx3790R989, r_PackedHalf2AtPtx3790R989); // PTX L4014
	r_LaneIndexAtPtx4018 = uint32_t((threadIdx.x & 31u));				 // PTX L4018
	r_PackedHalf2AtPtx4021R1045 =
		HalfMul(r_PackedHalf2AtPtx3797R991, r_PackedHalf2AtPtx3797R991); // PTX L4021
	r_LaneIndexAtPtx4025 = uint32_t((threadIdx.x & 31u));				 // PTX L4025
	r_PackedHalf2AtPtx4028R1048 =
		HalfMul(r_PackedHalf2AtPtx3804R993, r_PackedHalf2AtPtx3804R993); // PTX L4028
	r_LaneIndexAtPtx4032 = uint32_t((threadIdx.x & 31u));				 // PTX L4032
	r_PackedHalf2AtPtx4035R1040 =
		HalfMul(r_PackedHalf2AtPtx3811R995, r_PackedHalf2AtPtx3811R995); // PTX L4035
	r_LaneIndexAtPtx4039 = uint32_t((threadIdx.x & 31u));				 // PTX L4039
	r_PackedHalf2AtPtx4042R1043 =
		HalfMul(r_PackedHalf2AtPtx3818R997, r_PackedHalf2AtPtx3818R997); // PTX L4042
	r_LaneIndexAtPtx4046 = uint32_t((threadIdx.x & 31u));				 // PTX L4046
	r_PackedHalf2AtPtx4049R1046 =
		HalfMul(r_PackedHalf2AtPtx3825R999, r_PackedHalf2AtPtx3825R999); // PTX L4049
	r_LaneIndexAtPtx4053 = uint32_t((threadIdx.x & 31u));				 // PTX L4053
	r_PackedHalf2AtPtx4056R1049 =
		HalfMul(r_PackedHalf2AtPtx3832R1001, r_PackedHalf2AtPtx3832R1001); // PTX L4056
	r_LaneIndexAtPtx4060 = uint32_t((threadIdx.x & 31u));				   // PTX L4060
	r_PackedHalf2AtPtx4063R1051 =
		HalfAdd(r_PackedHalf2AtPtx3839R1003, r_PackedHalf2AtPtx3867R1004); // PTX L4063
	r_LaneIndexAtPtx4067 = uint32_t((threadIdx.x & 31u));				   // PTX L4067
	r_PackedHalf2AtPtx4070R1053 =
		HalfAdd(r_PackedHalf2AtPtx3846R1006, r_PackedHalf2AtPtx3874R1007); // PTX L4070
	r_LaneIndexAtPtx4074 = uint32_t((threadIdx.x & 31u));				   // PTX L4074
	r_PackedHalf2AtPtx4077R1050 =
		HalfAdd(r_PackedHalf2AtPtx3853R1009, r_PackedHalf2AtPtx3881R1010); // PTX L4077
	r_LaneIndexAtPtx4081 = uint32_t((threadIdx.x & 31u));				   // PTX L4081
	r_PackedHalf2AtPtx4084R1052 =
		HalfAdd(r_PackedHalf2AtPtx3860R1012, r_PackedHalf2AtPtx3888R1013); // PTX L4084
	r_LaneIndexAtPtx4088 = uint32_t((threadIdx.x & 31u));				   // PTX L4088
	r_PackedHalf2AtPtx4091R1070 =
		HalfAdd(r_PackedHalf2AtPtx3895R1015, r_PackedHalf2AtPtx3923R1016); // PTX L4091
	r_LaneIndexAtPtx4095 = uint32_t((threadIdx.x & 31u));				   // PTX L4095
	r_PackedHalf2AtPtx4098R1072 =
		HalfAdd(r_PackedHalf2AtPtx3902R1018, r_PackedHalf2AtPtx3930R1019); // PTX L4098
	r_LaneIndexAtPtx4102 = uint32_t((threadIdx.x & 31u));				   // PTX L4102
	r_PackedHalf2AtPtx4105R1069 =
		HalfAdd(r_PackedHalf2AtPtx3909R1021, r_PackedHalf2AtPtx3937R1022); // PTX L4105
	r_LaneIndexAtPtx4109 = uint32_t((threadIdx.x & 31u));				   // PTX L4109
	r_PackedHalf2AtPtx4112R1071 =
		HalfAdd(r_PackedHalf2AtPtx3916R1024, r_PackedHalf2AtPtx3944R1025); // PTX L4112
	r_LaneIndexAtPtx4116 = uint32_t((threadIdx.x & 31u));				   // PTX L4116
	r_PackedHalf2AtPtx4119R1086 =
		HalfAdd(r_PackedHalf2AtPtx3951R1027, r_PackedHalf2AtPtx3979R1028); // PTX L4119
	r_LaneIndexAtPtx4123 = uint32_t((threadIdx.x & 31u));				   // PTX L4123
	r_PackedHalf2AtPtx4126R1088 =
		HalfAdd(r_PackedHalf2AtPtx3958R1030, r_PackedHalf2AtPtx3986R1031); // PTX L4126
	r_LaneIndexAtPtx4130 = uint32_t((threadIdx.x & 31u));				   // PTX L4130
	r_PackedHalf2AtPtx4133R1085 =
		HalfAdd(r_PackedHalf2AtPtx3965R1033, r_PackedHalf2AtPtx3993R1034); // PTX L4133
	r_LaneIndexAtPtx4137 = uint32_t((threadIdx.x & 31u));				   // PTX L4137
	r_PackedHalf2AtPtx4140R1087 =
		HalfAdd(r_PackedHalf2AtPtx3972R1036, r_PackedHalf2AtPtx4000R1037); // PTX L4140
	r_LaneIndexAtPtx4144 = uint32_t((threadIdx.x & 31u));				   // PTX L4144
	r_PackedHalf2AtPtx4147R1102 =
		HalfAdd(r_PackedHalf2AtPtx4007R1039, r_PackedHalf2AtPtx4035R1040); // PTX L4147
	r_LaneIndexAtPtx4151 = uint32_t((threadIdx.x & 31u));				   // PTX L4151
	r_PackedHalf2AtPtx4154R1104 =
		HalfAdd(r_PackedHalf2AtPtx4014R1042, r_PackedHalf2AtPtx4042R1043); // PTX L4154
	r_LaneIndexAtPtx4158 = uint32_t((threadIdx.x & 31u));				   // PTX L4158
	r_PackedHalf2AtPtx4161R1101 =
		HalfAdd(r_PackedHalf2AtPtx4021R1045, r_PackedHalf2AtPtx4049R1046); // PTX L4161
	r_LaneIndexAtPtx4165 = uint32_t((threadIdx.x & 31u));				   // PTX L4165
	r_PackedHalf2AtPtx4168R1103 =
		HalfAdd(r_PackedHalf2AtPtx4028R1048, r_PackedHalf2AtPtx4056R1049); // PTX L4168
	r_PackedHalf2AtPtx4172R1054 =
		HalfAdd(r_PackedHalf2AtPtx4077R1050, r_PackedHalf2AtPtx4063R1051); // PTX L4172
	r_PackedHalf2AtPtx4176R1063 =
		HalfAdd(r_PackedHalf2AtPtx4084R1052, r_PackedHalf2AtPtx4070R1053); // PTX L4176
	r_PtxRegister1055 = uint32_t(2);									   // PTX L4179
	r_PtxRegister1056 = uint32_t(-1);									   // PTX L4180
	r_PackedHalf2AtPtx4182R1057 = ShuffleBfly(r_PackedHalf2AtPtx4172R1054, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4182
	r_PackedHalf2AtPtx4186R1058 =
		HalfAdd(r_PackedHalf2AtPtx4172R1054, r_PackedHalf2AtPtx4182R1057); // PTX L4186
	r_PtxRegister1059 = uint32_t(1);									   // PTX L4189
	r_PackedHalf2AtPtx4191R1060 = ShuffleBfly(r_PackedHalf2AtPtx4186R1058, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4191
	r_PtxRegister1061 = HalfAdd(r_PackedHalf2AtPtx4186R1058, r_PackedHalf2AtPtx4191R1060); // PTX L4195
	r_PtxU16Register89 = uint16_t(r_PtxRegister1061);
	r_PtxU16Register90 = uint16_t(r_PtxRegister1061 >> 16);								   // PTX L4198
	r_PackedHalf2AtPtx4199R1062 = JoinHalfwords(r_PtxU16Register90, r_PtxU16Register89);   // PTX L4199
	r_PackedHalf2AtPtx4201R1119 = HalfAdd(r_PtxRegister1061, r_PackedHalf2AtPtx4199R1062); // PTX L4201
	r_PackedHalf2AtPtx4205R1064 = ShuffleBfly(r_PackedHalf2AtPtx4176R1063, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4205
	r_PackedHalf2AtPtx4209R1065 =
		HalfAdd(r_PackedHalf2AtPtx4176R1063, r_PackedHalf2AtPtx4205R1064); // PTX L4209
	r_PackedHalf2AtPtx4213R1066 = ShuffleBfly(r_PackedHalf2AtPtx4209R1065, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4213
	r_PtxRegister1067 = HalfAdd(r_PackedHalf2AtPtx4209R1065, r_PackedHalf2AtPtx4213R1066); // PTX L4217
	r_PtxU16Register91 = uint16_t(r_PtxRegister1067);
	r_PtxU16Register92 = uint16_t(r_PtxRegister1067 >> 16);								   // PTX L4220
	r_PackedHalf2AtPtx4221R1068 = JoinHalfwords(r_PtxU16Register92, r_PtxU16Register91);   // PTX L4221
	r_PackedHalf2AtPtx4223R1121 = HalfAdd(r_PtxRegister1067, r_PackedHalf2AtPtx4221R1068); // PTX L4223
	r_PackedHalf2AtPtx4227R1073 =
		HalfAdd(r_PackedHalf2AtPtx4105R1069, r_PackedHalf2AtPtx4091R1070); // PTX L4227
	r_PackedHalf2AtPtx4231R1079 =
		HalfAdd(r_PackedHalf2AtPtx4112R1071, r_PackedHalf2AtPtx4098R1072); // PTX L4231
	r_PackedHalf2AtPtx4235R1074 = ShuffleBfly(r_PackedHalf2AtPtx4227R1073, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4235
	r_PackedHalf2AtPtx4239R1075 =
		HalfAdd(r_PackedHalf2AtPtx4227R1073, r_PackedHalf2AtPtx4235R1074); // PTX L4239
	r_PackedHalf2AtPtx4243R1076 = ShuffleBfly(r_PackedHalf2AtPtx4239R1075, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4243
	r_PtxRegister1077 = HalfAdd(r_PackedHalf2AtPtx4239R1075, r_PackedHalf2AtPtx4243R1076); // PTX L4247
	r_PtxU16Register93 = uint16_t(r_PtxRegister1077);
	r_PtxU16Register94 = uint16_t(r_PtxRegister1077 >> 16);								   // PTX L4250
	r_PackedHalf2AtPtx4251R1078 = JoinHalfwords(r_PtxU16Register94, r_PtxU16Register93);   // PTX L4251
	r_PackedHalf2AtPtx4253R1129 = HalfAdd(r_PtxRegister1077, r_PackedHalf2AtPtx4251R1078); // PTX L4253
	r_PackedHalf2AtPtx4257R1080 = ShuffleBfly(r_PackedHalf2AtPtx4231R1079, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4257
	r_PackedHalf2AtPtx4261R1081 =
		HalfAdd(r_PackedHalf2AtPtx4231R1079, r_PackedHalf2AtPtx4257R1080); // PTX L4261
	r_PackedHalf2AtPtx4265R1082 = ShuffleBfly(r_PackedHalf2AtPtx4261R1081, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4265
	r_PtxRegister1083 = HalfAdd(r_PackedHalf2AtPtx4261R1081, r_PackedHalf2AtPtx4265R1082); // PTX L4269
	r_PtxU16Register95 = uint16_t(r_PtxRegister1083);
	r_PtxU16Register96 = uint16_t(r_PtxRegister1083 >> 16);								   // PTX L4272
	r_PackedHalf2AtPtx4273R1084 = JoinHalfwords(r_PtxU16Register96, r_PtxU16Register95);   // PTX L4273
	r_PackedHalf2AtPtx4275R1131 = HalfAdd(r_PtxRegister1083, r_PackedHalf2AtPtx4273R1084); // PTX L4275
	r_PackedHalf2AtPtx4279R1089 =
		HalfAdd(r_PackedHalf2AtPtx4133R1085, r_PackedHalf2AtPtx4119R1086); // PTX L4279
	r_PackedHalf2AtPtx4283R1095 =
		HalfAdd(r_PackedHalf2AtPtx4140R1087, r_PackedHalf2AtPtx4126R1088); // PTX L4283
	r_PackedHalf2AtPtx4287R1090 = ShuffleBfly(r_PackedHalf2AtPtx4279R1089, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4287
	r_PackedHalf2AtPtx4291R1091 =
		HalfAdd(r_PackedHalf2AtPtx4279R1089, r_PackedHalf2AtPtx4287R1090); // PTX L4291
	r_PackedHalf2AtPtx4295R1092 = ShuffleBfly(r_PackedHalf2AtPtx4291R1091, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4295
	r_PtxRegister1093 = HalfAdd(r_PackedHalf2AtPtx4291R1091, r_PackedHalf2AtPtx4295R1092); // PTX L4299
	r_PtxU16Register97 = uint16_t(r_PtxRegister1093);
	r_PtxU16Register98 = uint16_t(r_PtxRegister1093 >> 16);								   // PTX L4302
	r_PackedHalf2AtPtx4303R1094 = JoinHalfwords(r_PtxU16Register98, r_PtxU16Register97);   // PTX L4303
	r_PackedHalf2AtPtx4305R1139 = HalfAdd(r_PtxRegister1093, r_PackedHalf2AtPtx4303R1094); // PTX L4305
	r_PackedHalf2AtPtx4309R1096 = ShuffleBfly(r_PackedHalf2AtPtx4283R1095, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4309
	r_PackedHalf2AtPtx4313R1097 =
		HalfAdd(r_PackedHalf2AtPtx4283R1095, r_PackedHalf2AtPtx4309R1096); // PTX L4313
	r_PackedHalf2AtPtx4317R1098 = ShuffleBfly(r_PackedHalf2AtPtx4313R1097, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4317
	r_PtxRegister1099 = HalfAdd(r_PackedHalf2AtPtx4313R1097, r_PackedHalf2AtPtx4317R1098); // PTX L4321
	r_PtxU16Register99 = uint16_t(r_PtxRegister1099);
	r_PtxU16Register100 = uint16_t(r_PtxRegister1099 >> 16);							   // PTX L4324
	r_PackedHalf2AtPtx4325R1100 = JoinHalfwords(r_PtxU16Register100, r_PtxU16Register99);  // PTX L4325
	r_PackedHalf2AtPtx4327R1141 = HalfAdd(r_PtxRegister1099, r_PackedHalf2AtPtx4325R1100); // PTX L4327
	r_PackedHalf2AtPtx4331R1105 =
		HalfAdd(r_PackedHalf2AtPtx4161R1101, r_PackedHalf2AtPtx4147R1102); // PTX L4331
	r_PackedHalf2AtPtx4335R1111 =
		HalfAdd(r_PackedHalf2AtPtx4168R1103, r_PackedHalf2AtPtx4154R1104); // PTX L4335
	r_PackedHalf2AtPtx4339R1106 = ShuffleBfly(r_PackedHalf2AtPtx4331R1105, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4339
	r_PackedHalf2AtPtx4343R1107 =
		HalfAdd(r_PackedHalf2AtPtx4331R1105, r_PackedHalf2AtPtx4339R1106); // PTX L4343
	r_PackedHalf2AtPtx4347R1108 = ShuffleBfly(r_PackedHalf2AtPtx4343R1107, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4347
	r_PtxRegister1109 = HalfAdd(r_PackedHalf2AtPtx4343R1107, r_PackedHalf2AtPtx4347R1108); // PTX L4351
	r_PtxU16Register101 = uint16_t(r_PtxRegister1109);
	r_PtxU16Register102 = uint16_t(r_PtxRegister1109 >> 16);							   // PTX L4354
	r_PackedHalf2AtPtx4355R1110 = JoinHalfwords(r_PtxU16Register102, r_PtxU16Register101); // PTX L4355
	r_PackedHalf2AtPtx4357R1149 = HalfAdd(r_PtxRegister1109, r_PackedHalf2AtPtx4355R1110); // PTX L4357
	r_PackedHalf2AtPtx4361R1112 = ShuffleBfly(r_PackedHalf2AtPtx4335R1111, r_PtxRegister1055,
											  r_PtxRegister1114, r_PtxRegister1056); // PTX L4361
	r_PackedHalf2AtPtx4365R1113 =
		HalfAdd(r_PackedHalf2AtPtx4335R1111, r_PackedHalf2AtPtx4361R1112); // PTX L4365
	r_PackedHalf2AtPtx4369R1115 = ShuffleBfly(r_PackedHalf2AtPtx4365R1113, r_PtxRegister1059,
											  r_PtxRegister1114, r_PtxRegister1056);	   // PTX L4369
	r_PtxRegister1116 = HalfAdd(r_PackedHalf2AtPtx4365R1113, r_PackedHalf2AtPtx4369R1115); // PTX L4373
	r_PtxU16Register103 = uint16_t(r_PtxRegister1116);
	r_PtxU16Register104 = uint16_t(r_PtxRegister1116 >> 16);							   // PTX L4376
	r_PackedHalf2AtPtx4377R1117 = JoinHalfwords(r_PtxU16Register104, r_PtxU16Register103); // PTX L4377
	r_PackedHalf2AtPtx4379R1151 = HalfAdd(r_PtxRegister1116, r_PackedHalf2AtPtx4377R1117); // PTX L4379
	r_LaneIndexAtPtx4383 = uint32_t((threadIdx.x & 31u));								   // PTX L4383
	r_PackedHalf2AtPtx4386R1160 =
		HalfMax(r_PackedHalf2AtPtx4201R1119, r_PackedHalf2AtPtx2281R1152); // PTX L4386
	r_LaneIndexAtPtx4390 = uint32_t((threadIdx.x & 31u));				   // PTX L4390
	r_PackedHalf2AtPtx4393R1162 =
		HalfMax(r_PackedHalf2AtPtx4223R1121, r_PackedHalf2AtPtx2281R1152); // PTX L4393
	r_LaneIndexAtPtx4397 = uint32_t((threadIdx.x & 31u));				   // PTX L4397
	r_LaneIndexAtPtx4400 = uint32_t((threadIdx.x & 31u));				   // PTX L4400
	r_LaneIndexAtPtx4403 = uint32_t((threadIdx.x & 31u));				   // PTX L4403
	r_LaneIndexAtPtx4406 = uint32_t((threadIdx.x & 31u));				   // PTX L4406
	r_LaneIndexAtPtx4409 = uint32_t((threadIdx.x & 31u));				   // PTX L4409
	r_LaneIndexAtPtx4412 = uint32_t((threadIdx.x & 31u));				   // PTX L4412
	r_LaneIndexAtPtx4415 = uint32_t((threadIdx.x & 31u));				   // PTX L4415
	r_PackedHalf2AtPtx4418R1170 =
		HalfMax(r_PackedHalf2AtPtx4253R1129, r_PackedHalf2AtPtx2281R1152); // PTX L4418
	r_LaneIndexAtPtx4422 = uint32_t((threadIdx.x & 31u));				   // PTX L4422
	r_PackedHalf2AtPtx4425R1172 =
		HalfMax(r_PackedHalf2AtPtx4275R1131, r_PackedHalf2AtPtx2281R1152); // PTX L4425
	r_LaneIndexAtPtx4429 = uint32_t((threadIdx.x & 31u));				   // PTX L4429
	r_LaneIndexAtPtx4432 = uint32_t((threadIdx.x & 31u));				   // PTX L4432
	r_LaneIndexAtPtx4435 = uint32_t((threadIdx.x & 31u));				   // PTX L4435
	r_LaneIndexAtPtx4438 = uint32_t((threadIdx.x & 31u));				   // PTX L4438
	r_LaneIndexAtPtx4441 = uint32_t((threadIdx.x & 31u));				   // PTX L4441
	r_LaneIndexAtPtx4444 = uint32_t((threadIdx.x & 31u));				   // PTX L4444
	r_LaneIndexAtPtx4447 = uint32_t((threadIdx.x & 31u));				   // PTX L4447
	r_PackedHalf2AtPtx4450R1180 =
		HalfMax(r_PackedHalf2AtPtx4305R1139, r_PackedHalf2AtPtx2281R1152); // PTX L4450
	r_LaneIndexAtPtx4454 = uint32_t((threadIdx.x & 31u));				   // PTX L4454
	r_PackedHalf2AtPtx4457R1182 =
		HalfMax(r_PackedHalf2AtPtx4327R1141, r_PackedHalf2AtPtx2281R1152); // PTX L4457
	r_LaneIndexAtPtx4461 = uint32_t((threadIdx.x & 31u));				   // PTX L4461
	r_LaneIndexAtPtx4464 = uint32_t((threadIdx.x & 31u));				   // PTX L4464
	r_LaneIndexAtPtx4467 = uint32_t((threadIdx.x & 31u));				   // PTX L4467
	r_LaneIndexAtPtx4470 = uint32_t((threadIdx.x & 31u));				   // PTX L4470
	r_LaneIndexAtPtx4473 = uint32_t((threadIdx.x & 31u));				   // PTX L4473
	r_LaneIndexAtPtx4476 = uint32_t((threadIdx.x & 31u));				   // PTX L4476
	r_LaneIndexAtPtx4479 = uint32_t((threadIdx.x & 31u));				   // PTX L4479
	r_PackedHalf2AtPtx4482R1190 =
		HalfMax(r_PackedHalf2AtPtx4357R1149, r_PackedHalf2AtPtx2281R1152); // PTX L4482
	r_LaneIndexAtPtx4486 = uint32_t((threadIdx.x & 31u));				   // PTX L4486
	r_PackedHalf2AtPtx4489R1192 =
		HalfMax(r_PackedHalf2AtPtx4379R1151, r_PackedHalf2AtPtx2281R1152); // PTX L4489
	r_LaneIndexAtPtx4493 = uint32_t((threadIdx.x & 31u));				   // PTX L4493
	r_LaneIndexAtPtx4496 = uint32_t((threadIdx.x & 31u));				   // PTX L4496
	r_LaneIndexAtPtx4499 = uint32_t((threadIdx.x & 31u));				   // PTX L4499
	r_LaneIndexAtPtx4502 = uint32_t((threadIdx.x & 31u));				   // PTX L4502
	r_LaneIndexAtPtx4505 = uint32_t((threadIdx.x & 31u));				   // PTX L4505
	r_LaneIndexAtPtx4508 = uint32_t((threadIdx.x & 31u));				   // PTX L4508
	r_LaneIndexAtPtx4511 = uint32_t((threadIdx.x & 31u));				   // PTX L4511
	r_PackedHalf2AtPtx4514R1200 = RsqrtHalf2(r_PackedHalf2AtPtx4386R1160); // PTX L4514
	r_LaneIndexAtPtx4527 = uint32_t((threadIdx.x & 31u));				   // PTX L4527
	r_PackedHalf2AtPtx4530R1202 = RsqrtHalf2(r_PackedHalf2AtPtx4393R1162); // PTX L4530
	r_LaneIndexAtPtx4543 = uint32_t((threadIdx.x & 31u));				   // PTX L4543
	r_LaneIndexAtPtx4546 = uint32_t((threadIdx.x & 31u));				   // PTX L4546
	r_LaneIndexAtPtx4549 = uint32_t((threadIdx.x & 31u));				   // PTX L4549
	r_LaneIndexAtPtx4552 = uint32_t((threadIdx.x & 31u));				   // PTX L4552
	r_LaneIndexAtPtx4555 = uint32_t((threadIdx.x & 31u));				   // PTX L4555
	r_LaneIndexAtPtx4558 = uint32_t((threadIdx.x & 31u));				   // PTX L4558
	r_LaneIndexAtPtx4561 = uint32_t((threadIdx.x & 31u));				   // PTX L4561
	r_PackedHalf2AtPtx4564R1210 = RsqrtHalf2(r_PackedHalf2AtPtx4418R1170); // PTX L4564
	r_LaneIndexAtPtx4577 = uint32_t((threadIdx.x & 31u));				   // PTX L4577
	r_PackedHalf2AtPtx4580R1212 = RsqrtHalf2(r_PackedHalf2AtPtx4425R1172); // PTX L4580
	r_LaneIndexAtPtx4593 = uint32_t((threadIdx.x & 31u));				   // PTX L4593
	r_LaneIndexAtPtx4596 = uint32_t((threadIdx.x & 31u));				   // PTX L4596
	r_LaneIndexAtPtx4599 = uint32_t((threadIdx.x & 31u));				   // PTX L4599
	r_LaneIndexAtPtx4602 = uint32_t((threadIdx.x & 31u));				   // PTX L4602
	r_LaneIndexAtPtx4605 = uint32_t((threadIdx.x & 31u));				   // PTX L4605
	r_LaneIndexAtPtx4608 = uint32_t((threadIdx.x & 31u));				   // PTX L4608
	r_LaneIndexAtPtx4611 = uint32_t((threadIdx.x & 31u));				   // PTX L4611
	r_PackedHalf2AtPtx4614R1220 = RsqrtHalf2(r_PackedHalf2AtPtx4450R1180); // PTX L4614
	r_LaneIndexAtPtx4627 = uint32_t((threadIdx.x & 31u));				   // PTX L4627
	r_PackedHalf2AtPtx4630R1222 = RsqrtHalf2(r_PackedHalf2AtPtx4457R1182); // PTX L4630
	r_LaneIndexAtPtx4643 = uint32_t((threadIdx.x & 31u));				   // PTX L4643
	r_LaneIndexAtPtx4646 = uint32_t((threadIdx.x & 31u));				   // PTX L4646
	r_LaneIndexAtPtx4649 = uint32_t((threadIdx.x & 31u));				   // PTX L4649
	r_LaneIndexAtPtx4652 = uint32_t((threadIdx.x & 31u));				   // PTX L4652
	r_LaneIndexAtPtx4655 = uint32_t((threadIdx.x & 31u));				   // PTX L4655
	r_LaneIndexAtPtx4658 = uint32_t((threadIdx.x & 31u));				   // PTX L4658
	r_LaneIndexAtPtx4661 = uint32_t((threadIdx.x & 31u));				   // PTX L4661
	r_PackedHalf2AtPtx4664R1230 = RsqrtHalf2(r_PackedHalf2AtPtx4482R1190); // PTX L4664
	r_LaneIndexAtPtx4677 = uint32_t((threadIdx.x & 31u));				   // PTX L4677
	r_PackedHalf2AtPtx4680R1232 = RsqrtHalf2(r_PackedHalf2AtPtx4489R1192); // PTX L4680
	r_LaneIndexAtPtx4693 = uint32_t((threadIdx.x & 31u));				   // PTX L4693
	r_LaneIndexAtPtx4696 = uint32_t((threadIdx.x & 31u));				   // PTX L4696
	r_LaneIndexAtPtx4699 = uint32_t((threadIdx.x & 31u));				   // PTX L4699
	r_LaneIndexAtPtx4702 = uint32_t((threadIdx.x & 31u));				   // PTX L4702
	r_LaneIndexAtPtx4705 = uint32_t((threadIdx.x & 31u));				   // PTX L4705
	r_LaneIndexAtPtx4708 = uint32_t((threadIdx.x & 31u));				   // PTX L4708
	r_LaneIndexAtPtx4711 = uint32_t((threadIdx.x & 31u));				   // PTX L4711
	r_PackedHalf2AtPtx4714R1239 =
		HalfMul(r_PackedHalf2AtPtx3615R939, r_PackedHalf2AtPtx4514R1200); // PTX L4714
	r_LaneIndexAtPtx4718 = uint32_t((threadIdx.x & 31u));				  // PTX L4718
	r_PackedHalf2AtPtx4721R1243 =
		HalfMul(r_PackedHalf2AtPtx3622R941, r_PackedHalf2AtPtx4530R1202); // PTX L4721
	r_LaneIndexAtPtx4725 = uint32_t((threadIdx.x & 31u));				  // PTX L4725
	r_PackedHalf2AtPtx4728R1240 =
		HalfMul(r_PackedHalf2AtPtx3629R943, r_PackedHalf2AtPtx4514R1200); // PTX L4728
	r_LaneIndexAtPtx4732 = uint32_t((threadIdx.x & 31u));				  // PTX L4732
	r_PackedHalf2AtPtx4735R1244 =
		HalfMul(r_PackedHalf2AtPtx3636R945, r_PackedHalf2AtPtx4530R1202); // PTX L4735
	r_LaneIndexAtPtx4739 = uint32_t((threadIdx.x & 31u));				  // PTX L4739
	r_PackedHalf2AtPtx4742R1241 =
		HalfMul(r_PackedHalf2AtPtx3643R947, r_PackedHalf2AtPtx4514R1200); // PTX L4742
	r_LaneIndexAtPtx4746 = uint32_t((threadIdx.x & 31u));				  // PTX L4746
	r_PackedHalf2AtPtx4749R1245 =
		HalfMul(r_PackedHalf2AtPtx3650R949, r_PackedHalf2AtPtx4530R1202); // PTX L4749
	r_LaneIndexAtPtx4753 = uint32_t((threadIdx.x & 31u));				  // PTX L4753
	r_PackedHalf2AtPtx4756R1242 =
		HalfMul(r_PackedHalf2AtPtx3657R951, r_PackedHalf2AtPtx4514R1200); // PTX L4756
	r_LaneIndexAtPtx4760 = uint32_t((threadIdx.x & 31u));				  // PTX L4760
	r_PackedHalf2AtPtx4763R1246 =
		HalfMul(r_PackedHalf2AtPtx3664R953, r_PackedHalf2AtPtx4530R1202); // PTX L4763
	r_LaneIndexAtPtx4767 = uint32_t((threadIdx.x & 31u));				  // PTX L4767
	r_PackedHalf2AtPtx4770R1247 =
		HalfMul(r_PackedHalf2AtPtx3671R955, r_PackedHalf2AtPtx4564R1210); // PTX L4770
	r_LaneIndexAtPtx4774 = uint32_t((threadIdx.x & 31u));				  // PTX L4774
	r_PackedHalf2AtPtx4777R1251 =
		HalfMul(r_PackedHalf2AtPtx3678R957, r_PackedHalf2AtPtx4580R1212); // PTX L4777
	r_LaneIndexAtPtx4781 = uint32_t((threadIdx.x & 31u));				  // PTX L4781
	r_PackedHalf2AtPtx4784R1248 =
		HalfMul(r_PackedHalf2AtPtx3685R959, r_PackedHalf2AtPtx4564R1210); // PTX L4784
	r_LaneIndexAtPtx4788 = uint32_t((threadIdx.x & 31u));				  // PTX L4788
	r_PackedHalf2AtPtx4791R1252 =
		HalfMul(r_PackedHalf2AtPtx3692R961, r_PackedHalf2AtPtx4580R1212); // PTX L4791
	r_LaneIndexAtPtx4795 = uint32_t((threadIdx.x & 31u));				  // PTX L4795
	r_PackedHalf2AtPtx4798R1249 =
		HalfMul(r_PackedHalf2AtPtx3699R963, r_PackedHalf2AtPtx4564R1210); // PTX L4798
	r_LaneIndexAtPtx4802 = uint32_t((threadIdx.x & 31u));				  // PTX L4802
	r_PackedHalf2AtPtx4805R1253 =
		HalfMul(r_PackedHalf2AtPtx3706R965, r_PackedHalf2AtPtx4580R1212); // PTX L4805
	r_LaneIndexAtPtx4809 = uint32_t((threadIdx.x & 31u));				  // PTX L4809
	r_PackedHalf2AtPtx4812R1250 =
		HalfMul(r_PackedHalf2AtPtx3713R967, r_PackedHalf2AtPtx4564R1210); // PTX L4812
	r_LaneIndexAtPtx4816 = uint32_t((threadIdx.x & 31u));				  // PTX L4816
	r_PackedHalf2AtPtx4819R1254 =
		HalfMul(r_PackedHalf2AtPtx3720R969, r_PackedHalf2AtPtx4580R1212); // PTX L4819
	r_LaneIndexAtPtx4823 = uint32_t((threadIdx.x & 31u));				  // PTX L4823
	r_PackedHalf2AtPtx4826R1255 =
		HalfMul(r_PackedHalf2AtPtx3727R971, r_PackedHalf2AtPtx4614R1220); // PTX L4826
	r_LaneIndexAtPtx4830 = uint32_t((threadIdx.x & 31u));				  // PTX L4830
	r_PackedHalf2AtPtx4833R1259 =
		HalfMul(r_PackedHalf2AtPtx3734R973, r_PackedHalf2AtPtx4630R1222); // PTX L4833
	r_LaneIndexAtPtx4837 = uint32_t((threadIdx.x & 31u));				  // PTX L4837
	r_PackedHalf2AtPtx4840R1256 =
		HalfMul(r_PackedHalf2AtPtx3741R975, r_PackedHalf2AtPtx4614R1220); // PTX L4840
	r_LaneIndexAtPtx4844 = uint32_t((threadIdx.x & 31u));				  // PTX L4844
	r_PackedHalf2AtPtx4847R1260 =
		HalfMul(r_PackedHalf2AtPtx3748R977, r_PackedHalf2AtPtx4630R1222); // PTX L4847
	r_LaneIndexAtPtx4851 = uint32_t((threadIdx.x & 31u));				  // PTX L4851
	r_PackedHalf2AtPtx4854R1257 =
		HalfMul(r_PackedHalf2AtPtx3755R979, r_PackedHalf2AtPtx4614R1220); // PTX L4854
	r_LaneIndexAtPtx4858 = uint32_t((threadIdx.x & 31u));				  // PTX L4858
	r_PackedHalf2AtPtx4861R1261 =
		HalfMul(r_PackedHalf2AtPtx3762R981, r_PackedHalf2AtPtx4630R1222); // PTX L4861
	r_LaneIndexAtPtx4865 = uint32_t((threadIdx.x & 31u));				  // PTX L4865
	r_PackedHalf2AtPtx4868R1258 =
		HalfMul(r_PackedHalf2AtPtx3769R983, r_PackedHalf2AtPtx4614R1220); // PTX L4868
	r_LaneIndexAtPtx4872 = uint32_t((threadIdx.x & 31u));				  // PTX L4872
	r_PackedHalf2AtPtx4875R1262 =
		HalfMul(r_PackedHalf2AtPtx3776R985, r_PackedHalf2AtPtx4630R1222); // PTX L4875
	r_LaneIndexAtPtx4879 = uint32_t((threadIdx.x & 31u));				  // PTX L4879
	r_PackedHalf2AtPtx4882R1263 =
		HalfMul(r_PackedHalf2AtPtx3783R987, r_PackedHalf2AtPtx4664R1230); // PTX L4882
	r_LaneIndexAtPtx4886 = uint32_t((threadIdx.x & 31u));				  // PTX L4886
	r_PackedHalf2AtPtx4889R1267 =
		HalfMul(r_PackedHalf2AtPtx3790R989, r_PackedHalf2AtPtx4680R1232); // PTX L4889
	r_LaneIndexAtPtx4893 = uint32_t((threadIdx.x & 31u));				  // PTX L4893
	r_PackedHalf2AtPtx4896R1264 =
		HalfMul(r_PackedHalf2AtPtx3797R991, r_PackedHalf2AtPtx4664R1230); // PTX L4896
	r_LaneIndexAtPtx4900 = uint32_t((threadIdx.x & 31u));				  // PTX L4900
	r_PackedHalf2AtPtx4903R1268 =
		HalfMul(r_PackedHalf2AtPtx3804R993, r_PackedHalf2AtPtx4680R1232); // PTX L4903
	r_LaneIndexAtPtx4907 = uint32_t((threadIdx.x & 31u));				  // PTX L4907
	r_PackedHalf2AtPtx4910R1265 =
		HalfMul(r_PackedHalf2AtPtx3811R995, r_PackedHalf2AtPtx4664R1230); // PTX L4910
	r_LaneIndexAtPtx4914 = uint32_t((threadIdx.x & 31u));				  // PTX L4914
	r_PackedHalf2AtPtx4917R1269 =
		HalfMul(r_PackedHalf2AtPtx3818R997, r_PackedHalf2AtPtx4680R1232); // PTX L4917
	r_LaneIndexAtPtx4921 = uint32_t((threadIdx.x & 31u));				  // PTX L4921
	r_PackedHalf2AtPtx4924R1266 =
		HalfMul(r_PackedHalf2AtPtx3825R999, r_PackedHalf2AtPtx4664R1230); // PTX L4924
	r_LaneIndexAtPtx4928 = uint32_t((threadIdx.x & 31u));				  // PTX L4928
	r_PackedHalf2AtPtx4931R1270 =
		HalfMul(r_PackedHalf2AtPtx3832R1001, r_PackedHalf2AtPtx4680R1232);	 // PTX L4931
	r_ConvertedE4PairAtPtx4935Rs57 = PublishE4(r_PackedHalf2AtPtx4714R1239); // PTX L4935
	r_ConvertedE4PairAtPtx4938Rs58 = PublishE4(r_PackedHalf2AtPtx4728R1240); // PTX L4938
	r_ConvertedE4PairAtPtx4941Rs59 = PublishE4(r_PackedHalf2AtPtx4742R1241); // PTX L4941
	r_ConvertedE4PairAtPtx4944Rs60 = PublishE4(r_PackedHalf2AtPtx4756R1242); // PTX L4944
	r_ConvertedE4PairAtPtx4947Rs61 = PublishE4(r_PackedHalf2AtPtx4721R1243); // PTX L4947
	r_ConvertedE4PairAtPtx4950Rs62 = PublishE4(r_PackedHalf2AtPtx4735R1244); // PTX L4950
	r_ConvertedE4PairAtPtx4953Rs63 = PublishE4(r_PackedHalf2AtPtx4749R1245); // PTX L4953
	r_ConvertedE4PairAtPtx4956Rs64 = PublishE4(r_PackedHalf2AtPtx4763R1246); // PTX L4956
	r_ConvertedE4PairAtPtx4959Rs65 = PublishE4(r_PackedHalf2AtPtx4770R1247); // PTX L4959
	r_ConvertedE4PairAtPtx4962Rs66 = PublishE4(r_PackedHalf2AtPtx4784R1248); // PTX L4962
	r_ConvertedE4PairAtPtx4965Rs67 = PublishE4(r_PackedHalf2AtPtx4798R1249); // PTX L4965
	r_ConvertedE4PairAtPtx4968Rs68 = PublishE4(r_PackedHalf2AtPtx4812R1250); // PTX L4968
	r_ConvertedE4PairAtPtx4971Rs69 = PublishE4(r_PackedHalf2AtPtx4777R1251); // PTX L4971
	r_ConvertedE4PairAtPtx4974Rs70 = PublishE4(r_PackedHalf2AtPtx4791R1252); // PTX L4974
	r_ConvertedE4PairAtPtx4977Rs71 = PublishE4(r_PackedHalf2AtPtx4805R1253); // PTX L4977
	r_ConvertedE4PairAtPtx4980Rs72 = PublishE4(r_PackedHalf2AtPtx4819R1254); // PTX L4980
	r_ConvertedE4PairAtPtx4983Rs73 = PublishE4(r_PackedHalf2AtPtx4826R1255); // PTX L4983
	r_ConvertedE4PairAtPtx4986Rs74 = PublishE4(r_PackedHalf2AtPtx4840R1256); // PTX L4986
	r_ConvertedE4PairAtPtx4989Rs75 = PublishE4(r_PackedHalf2AtPtx4854R1257); // PTX L4989
	r_ConvertedE4PairAtPtx4992Rs76 = PublishE4(r_PackedHalf2AtPtx4868R1258); // PTX L4992
	r_ConvertedE4PairAtPtx4995Rs77 = PublishE4(r_PackedHalf2AtPtx4833R1259); // PTX L4995
	r_ConvertedE4PairAtPtx4998Rs78 = PublishE4(r_PackedHalf2AtPtx4847R1260); // PTX L4998
	r_ConvertedE4PairAtPtx5001Rs79 = PublishE4(r_PackedHalf2AtPtx4861R1261); // PTX L5001
	r_ConvertedE4PairAtPtx5004Rs80 = PublishE4(r_PackedHalf2AtPtx4875R1262); // PTX L5004
	r_ConvertedE4PairAtPtx5007Rs81 = PublishE4(r_PackedHalf2AtPtx4882R1263); // PTX L5007
	r_ConvertedE4PairAtPtx5010Rs82 = PublishE4(r_PackedHalf2AtPtx4896R1264); // PTX L5010
	r_ConvertedE4PairAtPtx5013Rs83 = PublishE4(r_PackedHalf2AtPtx4910R1265); // PTX L5013
	r_ConvertedE4PairAtPtx5016Rs84 = PublishE4(r_PackedHalf2AtPtx4924R1266); // PTX L5016
	r_ConvertedE4PairAtPtx5019Rs85 = PublishE4(r_PackedHalf2AtPtx4889R1267); // PTX L5019
	r_ConvertedE4PairAtPtx5022Rs86 = PublishE4(r_PackedHalf2AtPtx4903R1268); // PTX L5022
	r_ConvertedE4PairAtPtx5025Rs87 = PublishE4(r_PackedHalf2AtPtx4917R1269); // PTX L5025
	r_ConvertedE4PairAtPtx5028Rs88 = PublishE4(r_PackedHalf2AtPtx4931R1270); // PTX L5028
	r_PtxU64Register30 = uint64_t(r_KBits) + uint64_t(r_PtxU64Register141);	 // PTX L5030
	if (r_bPtxPredicate43)
	{
		goto L__BB50_99;
	} // PTX L5031
	r_PackedE4WordAtPtx5032R1275 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4953Rs63, r_ConvertedE4PairAtPtx4956Rs64); // PTX L5032
	r_PackedE4WordAtPtx5033R1274 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4947Rs61, r_ConvertedE4PairAtPtx4950Rs62); // PTX L5033
	r_PackedE4WordAtPtx5034R1273 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4941Rs59, r_ConvertedE4PairAtPtx4944Rs60); // PTX L5034
	r_PackedE4WordAtPtx5035R1272 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4935Rs57, r_ConvertedE4PairAtPtx4938Rs58); // PTX L5035
	r_LaneIndexAtPtx5037 = uint32_t((threadIdx.x & 31u));							   // PTX L5037
	r_PtxU64Register173 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5037)) * int64_t(int32_t(16)));		// PTX L5039
	r_PtxU64Register172 = uint64_t(r_PtxU64Register30) + uint64_t(r_PtxU64Register173); // PTX L5040
	StoreNoAllocate(r_PtxU64Register172,
					make_uint4(r_PackedE4WordAtPtx5035R1272, r_PackedE4WordAtPtx5034R1273,
							   r_PackedE4WordAtPtx5033R1274,
							   r_PackedE4WordAtPtx5032R1275));					// PTX L5042
L__BB50_99:																		// PTX L5044
	r_bPtxPredicate44 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister1452); // PTX L5045
	if (r_bPtxPredicate44)
	{
		goto L__BB50_101;
	} // PTX L5046
	r_LaneIndexAtPtx5048 = uint32_t((threadIdx.x & 31u)); // PTX L5048
	r_PtxU64Register175 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5048)) * int64_t(int32_t(16)));		// PTX L5050
	r_PtxU64Register176 = uint64_t(r_PtxU64Register30) + uint64_t(r_PtxU64Register175); // PTX L5051
	r_PtxU64Register174 = uint64_t(r_PtxU64Register176) + uint64_t(16384);				// PTX L5052
	r_PackedE4WordAtPtx5053R1280 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4977Rs71, r_ConvertedE4PairAtPtx4980Rs72); // PTX L5053
	r_PackedE4WordAtPtx5054R1279 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4971Rs69, r_ConvertedE4PairAtPtx4974Rs70); // PTX L5054
	r_PackedE4WordAtPtx5055R1278 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4965Rs67, r_ConvertedE4PairAtPtx4968Rs68); // PTX L5055
	r_PackedE4WordAtPtx5056R1277 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4959Rs65, r_ConvertedE4PairAtPtx4962Rs66); // PTX L5056
	StoreNoAllocate(r_PtxU64Register174,
					make_uint4(r_PackedE4WordAtPtx5056R1277, r_PackedE4WordAtPtx5055R1278,
							   r_PackedE4WordAtPtx5054R1279,
							   r_PackedE4WordAtPtx5053R1280));					// PTX L5058
L__BB50_101:																	// PTX L5060
	r_bPtxPredicate45 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister1452); // PTX L5061
	if (r_bPtxPredicate45)
	{
		goto L__BB50_103;
	} // PTX L5062
	r_LaneIndexAtPtx5064 = uint32_t((threadIdx.x & 31u)); // PTX L5064
	r_PtxU64Register178 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5064)) * int64_t(int32_t(16)));		// PTX L5066
	r_PtxU64Register179 = uint64_t(r_PtxU64Register30) + uint64_t(r_PtxU64Register178); // PTX L5067
	r_PtxU64Register177 = uint64_t(r_PtxU64Register179) + uint64_t(32768);				// PTX L5068
	r_PackedE4WordAtPtx5069R1285 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5001Rs79, r_ConvertedE4PairAtPtx5004Rs80); // PTX L5069
	r_PackedE4WordAtPtx5070R1284 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4995Rs77, r_ConvertedE4PairAtPtx4998Rs78); // PTX L5070
	r_PackedE4WordAtPtx5071R1283 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4989Rs75, r_ConvertedE4PairAtPtx4992Rs76); // PTX L5071
	r_PackedE4WordAtPtx5072R1282 =
		JoinHalfwords(r_ConvertedE4PairAtPtx4983Rs73, r_ConvertedE4PairAtPtx4986Rs74); // PTX L5072
	StoreNoAllocate(r_PtxU64Register177,
					make_uint4(r_PackedE4WordAtPtx5072R1282, r_PackedE4WordAtPtx5071R1283,
							   r_PackedE4WordAtPtx5070R1284,
							   r_PackedE4WordAtPtx5069R1285));					// PTX L5074
L__BB50_103:																	// PTX L5076
	r_bPtxPredicate46 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister1452); // PTX L5077
	if (r_bPtxPredicate46)
	{
		goto L__BB50_105;
	} // PTX L5078
	r_LaneIndexAtPtx5080 = uint32_t((threadIdx.x & 31u)); // PTX L5080
	r_PtxU64Register181 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5080)) * int64_t(int32_t(16)));		// PTX L5082
	r_PtxU64Register182 = uint64_t(r_PtxU64Register30) + uint64_t(r_PtxU64Register181); // PTX L5083
	r_PtxU64Register180 = uint64_t(r_PtxU64Register182) + uint64_t(49152);				// PTX L5084
	r_PackedE4WordAtPtx5085R1290 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5025Rs87, r_ConvertedE4PairAtPtx5028Rs88); // PTX L5085
	r_PackedE4WordAtPtx5086R1289 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5019Rs85, r_ConvertedE4PairAtPtx5022Rs86); // PTX L5086
	r_PackedE4WordAtPtx5087R1288 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5013Rs83, r_ConvertedE4PairAtPtx5016Rs84); // PTX L5087
	r_PackedE4WordAtPtx5088R1287 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5007Rs81, r_ConvertedE4PairAtPtx5010Rs82); // PTX L5088
	StoreNoAllocate(r_PtxU64Register180,
					make_uint4(r_PackedE4WordAtPtx5088R1287, r_PackedE4WordAtPtx5087R1288,
							   r_PackedE4WordAtPtx5086R1289,
							   r_PackedE4WordAtPtx5085R1290));							 // PTX L5090
L__BB50_105:																			 // PTX L5092
	r_bPtxPredicate47 = int32_t(r_PtxRegister43) >= int32_t(r_PtxRegister31);			 // PTX L5093
	r_bPtxPredicate48 = uint64_t(g_ScratchBaseAddress) == uint64_t(0);					 // PTX L5094
	r_PtxU64Register183 = r_bPtxPredicate48 ? 0 : g_ScratchByteAddressAtPtx1346;		 // PTX L5095
	r_PtxU64Register184 = uint64_t(r_PtxU64Register183) + uint64_t(r_PtxU64Register116); // PTX L5096
	r_PtxU64Register185 = r_bPtxPredicate48 ? 0 : r_PtxU64Register184;					 // PTX L5097
	r_PtxU64Register31 = uint64_t(r_PtxU64Register185) + uint64_t(r_PtxU64Register154);	 // PTX L5098
	r_PackedHalf2AtPtx5099R1638 = uint32_t(r_PackedHalf2AtPtx5219R1666);				 // PTX L5099
	r_PackedHalf2AtPtx5100R1639 = uint32_t(r_PackedHalf2AtPtx5219R1666);				 // PTX L5100
	r_PackedHalf2AtPtx5101R1640 = uint32_t(r_PackedHalf2AtPtx5219R1666);				 // PTX L5101
	r_PackedHalf2AtPtx5102R1641 = uint32_t(r_PackedHalf2AtPtx5219R1666);				 // PTX L5102
	if (r_bPtxPredicate47)
	{
		goto L__BB50_107;
	} // PTX L5103
	r_LaneIndexAtPtx5105 = uint32_t((threadIdx.x & 31u)); // PTX L5105
	r_PtxU64Register187 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5105)) * int64_t(int32_t(16)));		// PTX L5107
	r_PtxU64Register186 = uint64_t(r_PtxU64Register31) + uint64_t(r_PtxU64Register187); // PTX L5108
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register186));
		r_PackedHalf2AtPtx5099R1638 = r_Value.x;
		r_PackedHalf2AtPtx5100R1639 = r_Value.y;
		r_PackedHalf2AtPtx5101R1640 = r_Value.z;
		r_PackedHalf2AtPtx5102R1641 = r_Value.w;
	} // PTX L5110
L__BB50_107:															 // PTX L5112
	r_PtxU64Register32 = uint64_t(r_PtxU64Register31) + uint64_t(512);	 // PTX L5113
	r_PackedHalf2AtPtx5114R1642 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5114
	r_PackedHalf2AtPtx5115R1643 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5115
	r_PackedHalf2AtPtx5116R1644 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5116
	r_PackedHalf2AtPtx5117R1645 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5117
	if (r_bPtxPredicate47)
	{
		goto L__BB50_109;
	} // PTX L5118
	r_LaneIndexAtPtx5120 = uint32_t((threadIdx.x & 31u)); // PTX L5120
	r_PtxU64Register189 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5120)) * int64_t(int32_t(16)));		// PTX L5122
	r_PtxU64Register188 = uint64_t(r_PtxU64Register32) + uint64_t(r_PtxU64Register189); // PTX L5123
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register188));
		r_PackedHalf2AtPtx5114R1642 = r_Value.x;
		r_PackedHalf2AtPtx5115R1643 = r_Value.y;
		r_PackedHalf2AtPtx5116R1644 = r_Value.z;
		r_PackedHalf2AtPtx5117R1645 = r_Value.w;
	} // PTX L5125
L__BB50_109:																  // PTX L5127
	r_bPtxPredicate49 = int32_t(r_PtxRegister45) >= int32_t(r_PtxRegister31); // PTX L5128
	r_PtxU64Register33 = uint64_t(r_PtxU64Register32) + uint64_t(32256);	  // PTX L5129
	r_PackedHalf2AtPtx5130R1646 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5130
	r_PackedHalf2AtPtx5131R1647 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5131
	r_PackedHalf2AtPtx5132R1648 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5132
	r_PackedHalf2AtPtx5133R1649 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5133
	if (r_bPtxPredicate49)
	{
		goto L__BB50_111;
	} // PTX L5134
	r_LaneIndexAtPtx5136 = uint32_t((threadIdx.x & 31u)); // PTX L5136
	r_PtxU64Register191 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5136)) * int64_t(int32_t(16)));		// PTX L5138
	r_PtxU64Register190 = uint64_t(r_PtxU64Register33) + uint64_t(r_PtxU64Register191); // PTX L5139
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register190));
		r_PackedHalf2AtPtx5130R1646 = r_Value.x;
		r_PackedHalf2AtPtx5131R1647 = r_Value.y;
		r_PackedHalf2AtPtx5132R1648 = r_Value.z;
		r_PackedHalf2AtPtx5133R1649 = r_Value.w;
	} // PTX L5141
L__BB50_111:															 // PTX L5143
	r_PtxU64Register34 = uint64_t(r_PtxU64Register33) + uint64_t(512);	 // PTX L5144
	r_PackedHalf2AtPtx5145R1650 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5145
	r_PackedHalf2AtPtx5146R1651 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5146
	r_PackedHalf2AtPtx5147R1652 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5147
	r_PackedHalf2AtPtx5148R1653 = uint32_t(r_PackedHalf2AtPtx5219R1666); // PTX L5148
	if (r_bPtxPredicate49)
	{
		goto L__BB50_113;
	} // PTX L5149
	r_LaneIndexAtPtx5151 = uint32_t((threadIdx.x & 31u)); // PTX L5151
	r_PtxU64Register193 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5151)) * int64_t(int32_t(16)));		// PTX L5153
	r_PtxU64Register192 = uint64_t(r_PtxU64Register34) + uint64_t(r_PtxU64Register193); // PTX L5154
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register192));
		r_PackedHalf2AtPtx5145R1650 = r_Value.x;
		r_PackedHalf2AtPtx5146R1651 = r_Value.y;
		r_PackedHalf2AtPtx5147R1652 = r_Value.z;
		r_PackedHalf2AtPtx5148R1653 = r_Value.w;
	} // PTX L5156
L__BB50_113:																  // PTX L5158
	r_bPtxPredicate50 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister31); // PTX L5159
	r_PtxU64Register35 = uint64_t(r_PtxU64Register34) + uint64_t(32256);	  // PTX L5160
	r_PackedHalf2AtPtx5161R1654 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5161
	r_PackedHalf2AtPtx5162R1655 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5162
	r_PackedHalf2AtPtx5163R1656 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5163
	r_PackedHalf2AtPtx5164R1657 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5164
	if (r_bPtxPredicate50)
	{
		goto L__BB50_115;
	} // PTX L5165
	r_LaneIndexAtPtx5167 = uint32_t((threadIdx.x & 31u)); // PTX L5167
	r_PtxU64Register195 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5167)) * int64_t(int32_t(16)));		// PTX L5169
	r_PtxU64Register194 = uint64_t(r_PtxU64Register35) + uint64_t(r_PtxU64Register195); // PTX L5170
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register194));
		r_PackedHalf2AtPtx5161R1654 = r_Value.x;
		r_PackedHalf2AtPtx5162R1655 = r_Value.y;
		r_PackedHalf2AtPtx5163R1656 = r_Value.z;
		r_PackedHalf2AtPtx5164R1657 = r_Value.w;
	} // PTX L5172
L__BB50_115:																  // PTX L5174
	r_bPtxPredicate51 = int32_t(r_PtxRegister46) >= int32_t(r_PtxRegister31); // PTX L5175
	r_PtxU64Register36 = uint64_t(r_PtxU64Register35) + uint64_t(512);		  // PTX L5176
	r_PackedHalf2AtPtx5177R1658 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5177
	r_PackedHalf2AtPtx5178R1659 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5178
	r_PackedHalf2AtPtx5179R1660 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5179
	r_PackedHalf2AtPtx5180R1661 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5180
	if (r_bPtxPredicate51)
	{
		goto L__BB50_117;
	} // PTX L5181
	r_LaneIndexAtPtx5183 = uint32_t((threadIdx.x & 31u)); // PTX L5183
	r_PtxU64Register197 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5183)) * int64_t(int32_t(16)));		// PTX L5185
	r_PtxU64Register196 = uint64_t(r_PtxU64Register36) + uint64_t(r_PtxU64Register197); // PTX L5186
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register196));
		r_PackedHalf2AtPtx5177R1658 = r_Value.x;
		r_PackedHalf2AtPtx5178R1659 = r_Value.y;
		r_PackedHalf2AtPtx5179R1660 = r_Value.z;
		r_PackedHalf2AtPtx5180R1661 = r_Value.w;
	} // PTX L5188
L__BB50_117:																  // PTX L5190
	r_bPtxPredicate52 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister31); // PTX L5191
	r_PtxU64Register37 = uint64_t(r_PtxU64Register36) + uint64_t(32256);	  // PTX L5192
	r_PackedHalf2AtPtx5193R1662 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5193
	r_PackedHalf2AtPtx5194R1663 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5194
	r_PackedHalf2AtPtx5195R1664 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5195
	r_PackedHalf2AtPtx5196R1665 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5196
	if (r_bPtxPredicate52)
	{
		goto L__BB50_119;
	} // PTX L5197
	r_LaneIndexAtPtx5199 = uint32_t((threadIdx.x & 31u)); // PTX L5199
	r_PtxU64Register199 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5199)) * int64_t(int32_t(16)));		// PTX L5201
	r_PtxU64Register198 = uint64_t(r_PtxU64Register37) + uint64_t(r_PtxU64Register199); // PTX L5202
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register198));
		r_PackedHalf2AtPtx5193R1662 = r_Value.x;
		r_PackedHalf2AtPtx5194R1663 = r_Value.y;
		r_PackedHalf2AtPtx5195R1664 = r_Value.z;
		r_PackedHalf2AtPtx5196R1665 = r_Value.w;
	} // PTX L5204
L__BB50_119:																  // PTX L5206
	r_bPtxPredicate53 = int32_t(r_PtxRegister47) >= int32_t(r_PtxRegister31); // PTX L5207
	r_PackedHalf2AtPtx5208R1667 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5208
	r_PackedHalf2AtPtx5209R1668 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5209
	r_PackedHalf2AtPtx5210R1669 = uint32_t(r_PackedHalf2AtPtx5219R1666);	  // PTX L5210
	if (r_bPtxPredicate53)
	{
		goto L__BB50_121;
	} // PTX L5211
	r_LaneIndexAtPtx5213 = uint32_t((threadIdx.x & 31u)); // PTX L5213
	r_PtxU64Register201 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5213)) * int64_t(int32_t(16)));		// PTX L5215
	r_PtxU64Register202 = uint64_t(r_PtxU64Register37) + uint64_t(r_PtxU64Register201); // PTX L5216
	r_PtxU64Register200 = uint64_t(r_PtxU64Register202) + uint64_t(512);				// PTX L5217
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register200));
		r_PackedHalf2AtPtx5219R1666 = r_Value.x;
		r_PackedHalf2AtPtx5208R1667 = r_Value.y;
		r_PackedHalf2AtPtx5209R1668 = r_Value.z;
		r_PackedHalf2AtPtx5210R1669 = r_Value.w;
	} // PTX L5219
L__BB50_121:											  // PTX L5221
	r_LaneIndexAtPtx5223 = uint32_t((threadIdx.x & 31u)); // PTX L5223
	r_PtxRegister1331 =
		HalfAdd(r_PackedHalf2AtPtx5099R1638, r_MmaAccumulatorHalf2WordAtPtx1060R247); // PTX L5226
	r_LaneIndexAtPtx5230 = uint32_t((threadIdx.x & 31u));							  // PTX L5230
	r_PtxRegister1332 =
		HalfAdd(r_PackedHalf2AtPtx5100R1639, r_MmaAccumulatorHalf2WordAtPtx1060R248); // PTX L5233
	r_LaneIndexAtPtx5237 = uint32_t((threadIdx.x & 31u));							  // PTX L5237
	r_PtxRegister1333 =
		HalfAdd(r_PackedHalf2AtPtx5101R1640, r_MmaAccumulatorHalf2WordAtPtx1067R249); // PTX L5240
	r_LaneIndexAtPtx5244 = uint32_t((threadIdx.x & 31u));							  // PTX L5244
	r_PtxRegister1334 =
		HalfAdd(r_PackedHalf2AtPtx5102R1641, r_MmaAccumulatorHalf2WordAtPtx1067R250); // PTX L5247
	r_LaneIndexAtPtx5251 = uint32_t((threadIdx.x & 31u));							  // PTX L5251
	r_PtxRegister1335 =
		HalfAdd(r_PackedHalf2AtPtx5114R1642, r_MmaAccumulatorHalf2WordAtPtx1074R251); // PTX L5254
	r_LaneIndexAtPtx5258 = uint32_t((threadIdx.x & 31u));							  // PTX L5258
	r_PtxRegister1336 =
		HalfAdd(r_PackedHalf2AtPtx5115R1643, r_MmaAccumulatorHalf2WordAtPtx1074R252); // PTX L5261
	r_LaneIndexAtPtx5265 = uint32_t((threadIdx.x & 31u));							  // PTX L5265
	r_PtxRegister1337 =
		HalfAdd(r_PackedHalf2AtPtx5116R1644, r_MmaAccumulatorHalf2WordAtPtx1081R253); // PTX L5268
	r_LaneIndexAtPtx5272 = uint32_t((threadIdx.x & 31u));							  // PTX L5272
	r_PtxRegister1338 =
		HalfAdd(r_PackedHalf2AtPtx5117R1645, r_MmaAccumulatorHalf2WordAtPtx1081R254); // PTX L5275
	r_LaneIndexAtPtx5279 = uint32_t((threadIdx.x & 31u));							  // PTX L5279
	r_PtxRegister1339 =
		HalfAdd(r_PackedHalf2AtPtx5130R1646, r_MmaAccumulatorHalf2WordAtPtx1144R275); // PTX L5282
	r_LaneIndexAtPtx5286 = uint32_t((threadIdx.x & 31u));							  // PTX L5286
	r_PtxRegister1340 =
		HalfAdd(r_PackedHalf2AtPtx5131R1647, r_MmaAccumulatorHalf2WordAtPtx1144R276); // PTX L5289
	r_LaneIndexAtPtx5293 = uint32_t((threadIdx.x & 31u));							  // PTX L5293
	r_PtxRegister1341 =
		HalfAdd(r_PackedHalf2AtPtx5132R1648, r_MmaAccumulatorHalf2WordAtPtx1151R277); // PTX L5296
	r_LaneIndexAtPtx5300 = uint32_t((threadIdx.x & 31u));							  // PTX L5300
	r_PtxRegister1342 =
		HalfAdd(r_PackedHalf2AtPtx5133R1649, r_MmaAccumulatorHalf2WordAtPtx1151R278); // PTX L5303
	r_LaneIndexAtPtx5307 = uint32_t((threadIdx.x & 31u));							  // PTX L5307
	r_PtxRegister1343 =
		HalfAdd(r_PackedHalf2AtPtx5145R1650, r_MmaAccumulatorHalf2WordAtPtx1158R279); // PTX L5310
	r_LaneIndexAtPtx5314 = uint32_t((threadIdx.x & 31u));							  // PTX L5314
	r_PtxRegister1344 =
		HalfAdd(r_PackedHalf2AtPtx5146R1651, r_MmaAccumulatorHalf2WordAtPtx1158R280); // PTX L5317
	r_LaneIndexAtPtx5321 = uint32_t((threadIdx.x & 31u));							  // PTX L5321
	r_PtxRegister1345 =
		HalfAdd(r_PackedHalf2AtPtx5147R1652, r_MmaAccumulatorHalf2WordAtPtx1165R281); // PTX L5324
	r_LaneIndexAtPtx5328 = uint32_t((threadIdx.x & 31u));							  // PTX L5328
	r_PtxRegister1346 =
		HalfAdd(r_PackedHalf2AtPtx5148R1653, r_MmaAccumulatorHalf2WordAtPtx1165R282); // PTX L5331
	r_LaneIndexAtPtx5335 = uint32_t((threadIdx.x & 31u));							  // PTX L5335
	r_PtxRegister1347 =
		HalfAdd(r_PackedHalf2AtPtx5161R1654, r_MmaAccumulatorHalf2WordAtPtx1228R303); // PTX L5338
	r_LaneIndexAtPtx5342 = uint32_t((threadIdx.x & 31u));							  // PTX L5342
	r_PtxRegister1348 =
		HalfAdd(r_PackedHalf2AtPtx5162R1655, r_MmaAccumulatorHalf2WordAtPtx1228R304); // PTX L5345
	r_LaneIndexAtPtx5349 = uint32_t((threadIdx.x & 31u));							  // PTX L5349
	r_PtxRegister1349 =
		HalfAdd(r_PackedHalf2AtPtx5163R1656, r_MmaAccumulatorHalf2WordAtPtx1235R305); // PTX L5352
	r_LaneIndexAtPtx5356 = uint32_t((threadIdx.x & 31u));							  // PTX L5356
	r_PtxRegister1350 =
		HalfAdd(r_PackedHalf2AtPtx5164R1657, r_MmaAccumulatorHalf2WordAtPtx1235R306); // PTX L5359
	r_LaneIndexAtPtx5363 = uint32_t((threadIdx.x & 31u));							  // PTX L5363
	r_PtxRegister1351 =
		HalfAdd(r_PackedHalf2AtPtx5177R1658, r_MmaAccumulatorHalf2WordAtPtx1242R307); // PTX L5366
	r_LaneIndexAtPtx5370 = uint32_t((threadIdx.x & 31u));							  // PTX L5370
	r_PtxRegister1352 =
		HalfAdd(r_PackedHalf2AtPtx5178R1659, r_MmaAccumulatorHalf2WordAtPtx1242R308); // PTX L5373
	r_LaneIndexAtPtx5377 = uint32_t((threadIdx.x & 31u));							  // PTX L5377
	r_PtxRegister1353 =
		HalfAdd(r_PackedHalf2AtPtx5179R1660, r_MmaAccumulatorHalf2WordAtPtx1249R309); // PTX L5380
	r_LaneIndexAtPtx5384 = uint32_t((threadIdx.x & 31u));							  // PTX L5384
	r_PtxRegister1354 =
		HalfAdd(r_PackedHalf2AtPtx5180R1661, r_MmaAccumulatorHalf2WordAtPtx1249R310); // PTX L5387
	r_LaneIndexAtPtx5391 = uint32_t((threadIdx.x & 31u));							  // PTX L5391
	r_PtxRegister1355 =
		HalfAdd(r_PackedHalf2AtPtx5193R1662, r_MmaAccumulatorHalf2WordAtPtx1312R331); // PTX L5394
	r_LaneIndexAtPtx5398 = uint32_t((threadIdx.x & 31u));							  // PTX L5398
	r_PtxRegister1356 =
		HalfAdd(r_PackedHalf2AtPtx5194R1663, r_MmaAccumulatorHalf2WordAtPtx1312R332); // PTX L5401
	r_LaneIndexAtPtx5405 = uint32_t((threadIdx.x & 31u));							  // PTX L5405
	r_PtxRegister1357 =
		HalfAdd(r_PackedHalf2AtPtx5195R1664, r_MmaAccumulatorHalf2WordAtPtx1319R333); // PTX L5408
	r_LaneIndexAtPtx5412 = uint32_t((threadIdx.x & 31u));							  // PTX L5412
	r_PtxRegister1358 =
		HalfAdd(r_PackedHalf2AtPtx5196R1665, r_MmaAccumulatorHalf2WordAtPtx1319R334); // PTX L5415
	r_LaneIndexAtPtx5419 = uint32_t((threadIdx.x & 31u));							  // PTX L5419
	r_PtxRegister1359 =
		HalfAdd(r_PackedHalf2AtPtx5219R1666, r_MmaAccumulatorHalf2WordAtPtx1326R335); // PTX L5422
	r_LaneIndexAtPtx5426 = uint32_t((threadIdx.x & 31u));							  // PTX L5426
	r_PtxRegister1360 =
		HalfAdd(r_PackedHalf2AtPtx5208R1667, r_MmaAccumulatorHalf2WordAtPtx1326R336); // PTX L5429
	r_LaneIndexAtPtx5433 = uint32_t((threadIdx.x & 31u));							  // PTX L5433
	r_PtxRegister1361 =
		HalfAdd(r_PackedHalf2AtPtx5209R1668, r_MmaAccumulatorHalf2WordAtPtx1333R337); // PTX L5436
	r_LaneIndexAtPtx5440 = uint32_t((threadIdx.x & 31u));							  // PTX L5440
	r_PtxRegister1362 =
		HalfAdd(r_PackedHalf2AtPtx5210R1669, r_MmaAccumulatorHalf2WordAtPtx1333R338);		   // PTX L5443
	r_PtxRegister1363 = TransposeM8n8(r_PtxRegister1331);									   // PTX L5447
	r_PtxRegister1364 = TransposeM8n8(r_PtxRegister1332);									   // PTX L5450
	r_PtxRegister1367 = TransposeM8n8(r_PtxRegister1333);									   // PTX L5453
	r_PtxRegister1368 = TransposeM8n8(r_PtxRegister1334);									   // PTX L5456
	r_PtxRegister1371 = TransposeM8n8(r_PtxRegister1335);									   // PTX L5459
	r_PtxRegister1372 = TransposeM8n8(r_PtxRegister1336);									   // PTX L5462
	r_PtxRegister1375 = TransposeM8n8(r_PtxRegister1337);									   // PTX L5465
	r_PtxRegister1376 = TransposeM8n8(r_PtxRegister1338);									   // PTX L5468
	r_PtxRegister1365 = TransposeM8n8(r_PtxRegister1339);									   // PTX L5471
	r_PtxRegister1366 = TransposeM8n8(r_PtxRegister1340);									   // PTX L5474
	r_PtxRegister1369 = TransposeM8n8(r_PtxRegister1341);									   // PTX L5477
	r_PtxRegister1370 = TransposeM8n8(r_PtxRegister1342);									   // PTX L5480
	r_PtxRegister1373 = TransposeM8n8(r_PtxRegister1343);									   // PTX L5483
	r_PtxRegister1374 = TransposeM8n8(r_PtxRegister1344);									   // PTX L5486
	r_PtxRegister1377 = TransposeM8n8(r_PtxRegister1345);									   // PTX L5489
	r_PtxRegister1378 = TransposeM8n8(r_PtxRegister1346);									   // PTX L5492
	r_PtxRegister1379 = TransposeM8n8(r_PtxRegister1347);									   // PTX L5495
	r_PtxRegister1380 = TransposeM8n8(r_PtxRegister1348);									   // PTX L5498
	r_PtxRegister1383 = TransposeM8n8(r_PtxRegister1349);									   // PTX L5501
	r_PtxRegister1384 = TransposeM8n8(r_PtxRegister1350);									   // PTX L5504
	r_PtxRegister1387 = TransposeM8n8(r_PtxRegister1351);									   // PTX L5507
	r_PtxRegister1388 = TransposeM8n8(r_PtxRegister1352);									   // PTX L5510
	r_PtxRegister1391 = TransposeM8n8(r_PtxRegister1353);									   // PTX L5513
	r_PtxRegister1392 = TransposeM8n8(r_PtxRegister1354);									   // PTX L5516
	r_PtxRegister1381 = TransposeM8n8(r_PtxRegister1355);									   // PTX L5519
	r_PtxRegister1382 = TransposeM8n8(r_PtxRegister1356);									   // PTX L5522
	r_PtxRegister1385 = TransposeM8n8(r_PtxRegister1357);									   // PTX L5525
	r_PtxRegister1386 = TransposeM8n8(r_PtxRegister1358);									   // PTX L5528
	r_PtxRegister1389 = TransposeM8n8(r_PtxRegister1359);									   // PTX L5531
	r_PtxRegister1390 = TransposeM8n8(r_PtxRegister1360);									   // PTX L5534
	r_PtxRegister1393 = TransposeM8n8(r_PtxRegister1361);									   // PTX L5537
	r_PtxRegister1394 = TransposeM8n8(r_PtxRegister1362);									   // PTX L5540
	r_PtxRegister48 = ShiftRightSigned(int32_t(r_PtxRegister30), uint32_t(5));				   // PTX L5542
	r_ConvertedE4PairAtPtx5544Rs105 = PublishE4(r_PtxRegister1363);							   // PTX L5544
	r_ConvertedE4PairAtPtx5547Rs106 = PublishE4(r_PtxRegister1364);							   // PTX L5547
	r_ConvertedE4PairAtPtx5550Rs107 = PublishE4(r_PtxRegister1365);							   // PTX L5550
	r_ConvertedE4PairAtPtx5553Rs108 = PublishE4(r_PtxRegister1366);							   // PTX L5553
	r_ConvertedE4PairAtPtx5556Rs109 = PublishE4(r_PtxRegister1367);							   // PTX L5556
	r_ConvertedE4PairAtPtx5559Rs110 = PublishE4(r_PtxRegister1368);							   // PTX L5559
	r_ConvertedE4PairAtPtx5562Rs111 = PublishE4(r_PtxRegister1369);							   // PTX L5562
	r_ConvertedE4PairAtPtx5565Rs112 = PublishE4(r_PtxRegister1370);							   // PTX L5565
	r_ConvertedE4PairAtPtx5568Rs113 = PublishE4(r_PtxRegister1371);							   // PTX L5568
	r_ConvertedE4PairAtPtx5571Rs114 = PublishE4(r_PtxRegister1372);							   // PTX L5571
	r_ConvertedE4PairAtPtx5574Rs115 = PublishE4(r_PtxRegister1373);							   // PTX L5574
	r_ConvertedE4PairAtPtx5577Rs116 = PublishE4(r_PtxRegister1374);							   // PTX L5577
	r_ConvertedE4PairAtPtx5580Rs117 = PublishE4(r_PtxRegister1375);							   // PTX L5580
	r_ConvertedE4PairAtPtx5583Rs118 = PublishE4(r_PtxRegister1376);							   // PTX L5583
	r_ConvertedE4PairAtPtx5586Rs119 = PublishE4(r_PtxRegister1377);							   // PTX L5586
	r_ConvertedE4PairAtPtx5589Rs120 = PublishE4(r_PtxRegister1378);							   // PTX L5589
	r_ConvertedE4PairAtPtx5592Rs121 = PublishE4(r_PtxRegister1379);							   // PTX L5592
	r_ConvertedE4PairAtPtx5595Rs122 = PublishE4(r_PtxRegister1380);							   // PTX L5595
	r_ConvertedE4PairAtPtx5598Rs123 = PublishE4(r_PtxRegister1381);							   // PTX L5598
	r_ConvertedE4PairAtPtx5601Rs124 = PublishE4(r_PtxRegister1382);							   // PTX L5601
	r_ConvertedE4PairAtPtx5604Rs125 = PublishE4(r_PtxRegister1383);							   // PTX L5604
	r_ConvertedE4PairAtPtx5607Rs126 = PublishE4(r_PtxRegister1384);							   // PTX L5607
	r_ConvertedE4PairAtPtx5610Rs127 = PublishE4(r_PtxRegister1385);							   // PTX L5610
	r_ConvertedE4PairAtPtx5613Rs128 = PublishE4(r_PtxRegister1386);							   // PTX L5613
	r_ConvertedE4PairAtPtx5616Rs129 = PublishE4(r_PtxRegister1387);							   // PTX L5616
	r_ConvertedE4PairAtPtx5619Rs130 = PublishE4(r_PtxRegister1388);							   // PTX L5619
	r_ConvertedE4PairAtPtx5622Rs131 = PublishE4(r_PtxRegister1389);							   // PTX L5622
	r_ConvertedE4PairAtPtx5625Rs132 = PublishE4(r_PtxRegister1390);							   // PTX L5625
	r_ConvertedE4PairAtPtx5628Rs133 = PublishE4(r_PtxRegister1391);							   // PTX L5628
	r_ConvertedE4PairAtPtx5631Rs134 = PublishE4(r_PtxRegister1392);							   // PTX L5631
	r_ConvertedE4PairAtPtx5634Rs135 = PublishE4(r_PtxRegister1393);							   // PTX L5634
	r_ConvertedE4PairAtPtx5637Rs136 = PublishE4(r_PtxRegister1394);							   // PTX L5637
	r_PtxRegister1395 = r_ThreadY & 1022;													   // PTX L5639
	r_PtxRegister1396 = ShiftLeft(uint32_t(r_PtxRegister4), uint32_t(2));					   // PTX L5640
	r_PtxRegister49 = uint32_t(r_PtxRegister1395) + uint32_t(r_PtxRegister1396);			   // PTX L5641
	r_bPtxPredicate54 = int32_t(r_PtxRegister49) >= int32_t(r_PtxRegister48);				   // PTX L5642
	r_PtxRegister1397 = ShiftLeft(uint32_t(r_PtxRegister49), uint32_t(13));					   // PTX L5643
	r_PtxRegister1398 = uint32_t(r_PtxRegister1397) + uint32_t(r_PtxRegister34);			   // PTX L5644
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister1398)) * int64_t(int32_t(4))); // PTX L5645
	r_PtxU64Register38 = uint64_t(r_VBits) + uint64_t(r_PtxU64Register203);					   // PTX L5646
	if (r_bPtxPredicate54)
	{
		goto L__BB50_123;
	} // PTX L5647
	r_PackedE4WordAtPtx5648R1408 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5586Rs119, r_ConvertedE4PairAtPtx5589Rs120); // PTX L5648
	r_PackedE4WordAtPtx5649R1407 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5580Rs117, r_ConvertedE4PairAtPtx5583Rs118); // PTX L5649
	r_PackedE4WordAtPtx5650R1406 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5574Rs115, r_ConvertedE4PairAtPtx5577Rs116); // PTX L5650
	r_PackedE4WordAtPtx5651R1405 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5568Rs113, r_ConvertedE4PairAtPtx5571Rs114); // PTX L5651
	r_PackedE4WordAtPtx5652R1403 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5562Rs111, r_ConvertedE4PairAtPtx5565Rs112); // PTX L5652
	r_PackedE4WordAtPtx5653R1402 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5556Rs109, r_ConvertedE4PairAtPtx5559Rs110); // PTX L5653
	r_PackedE4WordAtPtx5654R1401 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5550Rs107, r_ConvertedE4PairAtPtx5553Rs108); // PTX L5654
	r_PackedE4WordAtPtx5655R1400 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5544Rs105, r_ConvertedE4PairAtPtx5547Rs106); // PTX L5655
	r_LaneIndexAtPtx5657 = uint32_t((threadIdx.x & 31u));								 // PTX L5657
	r_PtxU64Register206 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5657)) * int64_t(int32_t(16)));		// PTX L5659
	r_PtxU64Register204 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register206); // PTX L5660
	StoreNoAllocate(r_PtxU64Register204,
					make_uint4(r_PackedE4WordAtPtx5655R1400, r_PackedE4WordAtPtx5654R1401,
							   r_PackedE4WordAtPtx5653R1402,
							   r_PackedE4WordAtPtx5652R1403)); // PTX L5662
	r_LaneIndexAtPtx5665 = uint32_t((threadIdx.x & 31u));	   // PTX L5665
	r_PtxU64Register207 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5665)) * int64_t(int32_t(16)));		// PTX L5667
	r_PtxU64Register208 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register207); // PTX L5668
	r_PtxU64Register205 = uint64_t(r_PtxU64Register208) + uint64_t(512);				// PTX L5669
	StoreNoAllocate(r_PtxU64Register205,
					make_uint4(r_PackedE4WordAtPtx5651R1405, r_PackedE4WordAtPtx5650R1406,
							   r_PackedE4WordAtPtx5649R1407,
							   r_PackedE4WordAtPtx5648R1408));					// PTX L5671
L__BB50_123:																	// PTX L5673
	r_PtxRegister1409 = uint32_t(r_PtxRegister49) + uint32_t(1);				// PTX L5674
	r_bPtxPredicate55 = int32_t(r_PtxRegister1409) >= int32_t(r_PtxRegister48); // PTX L5675
	if (r_bPtxPredicate55)
	{
		goto L__BB50_125;
	} // PTX L5676
	r_LaneIndexAtPtx5678 = uint32_t((threadIdx.x & 31u)); // PTX L5678
	r_PtxU64Register211 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5678)) * int64_t(int32_t(16)));		// PTX L5680
	r_PtxU64Register212 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register211); // PTX L5681
	r_PtxU64Register209 = uint64_t(r_PtxU64Register212) + uint64_t(32768);				// PTX L5682
	r_PackedE4WordAtPtx5683R1414 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5610Rs127, r_ConvertedE4PairAtPtx5613Rs128); // PTX L5683
	r_PackedE4WordAtPtx5684R1413 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5604Rs125, r_ConvertedE4PairAtPtx5607Rs126); // PTX L5684
	r_PackedE4WordAtPtx5685R1412 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5598Rs123, r_ConvertedE4PairAtPtx5601Rs124); // PTX L5685
	r_PackedE4WordAtPtx5686R1411 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5592Rs121, r_ConvertedE4PairAtPtx5595Rs122); // PTX L5686
	StoreNoAllocate(r_PtxU64Register209,
					make_uint4(r_PackedE4WordAtPtx5686R1411, r_PackedE4WordAtPtx5685R1412,
							   r_PackedE4WordAtPtx5684R1413,
							   r_PackedE4WordAtPtx5683R1414)); // PTX L5688
	r_LaneIndexAtPtx5691 = uint32_t((threadIdx.x & 31u));	   // PTX L5691
	r_PtxU64Register213 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5691)) * int64_t(int32_t(16)));		// PTX L5693
	r_PtxU64Register214 = uint64_t(r_PtxU64Register38) + uint64_t(r_PtxU64Register213); // PTX L5694
	r_PtxU64Register210 = uint64_t(r_PtxU64Register214) + uint64_t(33280);				// PTX L5695
	r_PackedE4WordAtPtx5696R1419 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5634Rs135, r_ConvertedE4PairAtPtx5637Rs136); // PTX L5696
	r_PackedE4WordAtPtx5697R1418 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5628Rs133, r_ConvertedE4PairAtPtx5631Rs134); // PTX L5697
	r_PackedE4WordAtPtx5698R1417 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5622Rs131, r_ConvertedE4PairAtPtx5625Rs132); // PTX L5698
	r_PackedE4WordAtPtx5699R1416 =
		JoinHalfwords(r_ConvertedE4PairAtPtx5616Rs129, r_ConvertedE4PairAtPtx5619Rs130); // PTX L5699
	StoreNoAllocate(r_PtxU64Register210,
					make_uint4(r_PackedE4WordAtPtx5699R1416, r_PackedE4WordAtPtx5698R1417,
							   r_PackedE4WordAtPtx5697R1418,
							   r_PackedE4WordAtPtx5696R1419));								 // PTX L5701
	goto L__BB50_125;																		 // PTX L5703
L__BB50_31:																					 // PTX L5704
	r_PtxRegister1421 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(5));						 // PTX L5705
	r_PtxRegister1422 = r_PtxRegister1421 & 32;												 // PTX L5706
	r_PtxRegister35 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister6);					 // PTX L5707
	r_PtxRegister1423 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister29);			 // PTX L5708
	r_bPtxPredicate56 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister31);				 // PTX L5709
	r_PtxRegister1424 = ShiftLeft(uint32_t(r_PtxRegister1423), uint32_t(3));				 // PTX L5710
	r_PtxRegister1425 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(13));					 // PTX L5711
	r_PtxRegister36 = uint32_t(r_PtxRegister1425) + uint32_t(r_PtxRegister1424);			 // PTX L5712
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister36)) * int64_t(int32_t(4))); // PTX L5713
	g_ScratchByteAddressAtPtx5714 =
		uint64_t(g_ScratchBaseAddress) + uint64_t(r_PtxU64Register215); // PTX L5714
	if (r_bPtxPredicate56)
	{
		goto L__BB50_33;
	} // PTX L5715
	r_LaneIndexAtPtx5717 = uint32_t((threadIdx.x & 31u)); // PTX L5717
	r_PtxU64Register217 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5717)) * int64_t(int32_t(16))); // PTX L5719
	g_ScratchByteAddressAtPtx5720 =
		uint64_t(g_ScratchByteAddressAtPtx5714) + uint64_t(r_PtxU64Register217); // PTX L5720
	StoreNoAllocate(g_ScratchByteAddressAtPtx5720,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1004R227, r_MmaAccumulatorHalf2WordAtPtx1004R228,
							   r_MmaAccumulatorHalf2WordAtPtx1011R233,
							   r_MmaAccumulatorHalf2WordAtPtx1011R234));	  // PTX L5722
L__BB50_33:																	  // PTX L5724
	r_bPtxPredicate57 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister31); // PTX L5725
	if (r_bPtxPredicate57)
	{
		goto L__BB50_35;
	} // PTX L5726
	r_LaneIndexAtPtx5728 = uint32_t((threadIdx.x & 31u)); // PTX L5728
	r_PtxU64Register219 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5728)) * int64_t(int32_t(16))); // PTX L5730
	g_ScratchByteAddressAtPtx5731 =
		uint64_t(g_ScratchByteAddressAtPtx5714) + uint64_t(r_PtxU64Register219);			 // PTX L5731
	g_ScratchByteAddressAtPtx5732 = uint64_t(g_ScratchByteAddressAtPtx5731) + uint64_t(512); // PTX L5732
	StoreNoAllocate(g_ScratchByteAddressAtPtx5732,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1018R235, r_MmaAccumulatorHalf2WordAtPtx1018R236,
							   r_MmaAccumulatorHalf2WordAtPtx1025R237,
							   r_MmaAccumulatorHalf2WordAtPtx1025R238));					   // PTX L5734
L__BB50_35:																					   // PTX L5736
	r_PtxRegister37 = uint32_t(r_PtxRegister35) + uint32_t(1);								   // PTX L5737
	r_bPtxPredicate58 = int32_t(r_PtxRegister37) >= int32_t(r_PtxRegister31);				   // PTX L5738
	g_ScratchByteAddressAtPtx5739 = uint64_t(g_ScratchByteAddressAtPtx5714) + uint64_t(32768); // PTX L5739
	if (r_bPtxPredicate58)
	{
		goto L__BB50_37;
	} // PTX L5740
	r_LaneIndexAtPtx5742 = uint32_t((threadIdx.x & 31u)); // PTX L5742
	r_PtxU64Register223 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5742)) * int64_t(int32_t(16))); // PTX L5744
	g_ScratchByteAddressAtPtx5745 =
		uint64_t(g_ScratchByteAddressAtPtx5739) + uint64_t(r_PtxU64Register223); // PTX L5745
	StoreNoAllocate(g_ScratchByteAddressAtPtx5745,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1088R255, r_MmaAccumulatorHalf2WordAtPtx1088R256,
							   r_MmaAccumulatorHalf2WordAtPtx1095R261,
							   r_MmaAccumulatorHalf2WordAtPtx1095R262)); // PTX L5747
	r_LaneIndexAtPtx5750 = uint32_t((threadIdx.x & 31u));				 // PTX L5750
	r_PtxU64Register224 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5750)) * int64_t(int32_t(16))); // PTX L5752
	g_ScratchByteAddressAtPtx5753 =
		uint64_t(g_ScratchByteAddressAtPtx5714) + uint64_t(r_PtxU64Register224);			   // PTX L5753
	g_ScratchByteAddressAtPtx5754 = uint64_t(g_ScratchByteAddressAtPtx5753) + uint64_t(33280); // PTX L5754
	StoreNoAllocate(g_ScratchByteAddressAtPtx5754,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1102R263, r_MmaAccumulatorHalf2WordAtPtx1102R264,
							   r_MmaAccumulatorHalf2WordAtPtx1109R265,
							   r_MmaAccumulatorHalf2WordAtPtx1109R266));					   // PTX L5756
L__BB50_37:																					   // PTX L5758
	r_PtxRegister38 = uint32_t(r_PtxRegister35) + uint32_t(2);								   // PTX L5759
	r_bPtxPredicate59 = int32_t(r_PtxRegister38) >= int32_t(r_PtxRegister31);				   // PTX L5760
	g_ScratchByteAddressAtPtx5761 = uint64_t(g_ScratchByteAddressAtPtx5739) + uint64_t(32768); // PTX L5761
	if (r_bPtxPredicate59)
	{
		goto L__BB50_39;
	} // PTX L5762
	r_LaneIndexAtPtx5764 = uint32_t((threadIdx.x & 31u)); // PTX L5764
	r_PtxU64Register228 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5764)) * int64_t(int32_t(16))); // PTX L5766
	g_ScratchByteAddressAtPtx5767 =
		uint64_t(g_ScratchByteAddressAtPtx5761) + uint64_t(r_PtxU64Register228); // PTX L5767
	StoreNoAllocate(g_ScratchByteAddressAtPtx5767,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1172R283, r_MmaAccumulatorHalf2WordAtPtx1172R284,
							   r_MmaAccumulatorHalf2WordAtPtx1179R289,
							   r_MmaAccumulatorHalf2WordAtPtx1179R290)); // PTX L5769
	r_LaneIndexAtPtx5772 = uint32_t((threadIdx.x & 31u));				 // PTX L5772
	r_PtxU64Register229 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5772)) * int64_t(int32_t(16))); // PTX L5774
	g_ScratchByteAddressAtPtx5775 =
		uint64_t(g_ScratchByteAddressAtPtx5739) + uint64_t(r_PtxU64Register229);			   // PTX L5775
	g_ScratchByteAddressAtPtx5776 = uint64_t(g_ScratchByteAddressAtPtx5775) + uint64_t(33280); // PTX L5776
	StoreNoAllocate(g_ScratchByteAddressAtPtx5776,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1186R291, r_MmaAccumulatorHalf2WordAtPtx1186R292,
							   r_MmaAccumulatorHalf2WordAtPtx1193R293,
							   r_MmaAccumulatorHalf2WordAtPtx1193R294));	  // PTX L5778
L__BB50_39:																	  // PTX L5780
	r_PtxRegister39 = uint32_t(r_PtxRegister35) + uint32_t(3);				  // PTX L5781
	r_bPtxPredicate60 = int32_t(r_PtxRegister39) >= int32_t(r_PtxRegister31); // PTX L5782
	if (r_bPtxPredicate60)
	{
		goto L__BB50_41;
	} // PTX L5783
	r_LaneIndexAtPtx5785 = uint32_t((threadIdx.x & 31u)); // PTX L5785
	r_PtxU64Register233 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5785)) * int64_t(int32_t(16))); // PTX L5787
	g_ScratchByteAddressAtPtx5788 =
		uint64_t(g_ScratchByteAddressAtPtx5761) + uint64_t(r_PtxU64Register233);			   // PTX L5788
	g_ScratchByteAddressAtPtx5789 = uint64_t(g_ScratchByteAddressAtPtx5788) + uint64_t(32768); // PTX L5789
	StoreNoAllocate(g_ScratchByteAddressAtPtx5789,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1256R311, r_MmaAccumulatorHalf2WordAtPtx1256R312,
							   r_MmaAccumulatorHalf2WordAtPtx1263R317,
							   r_MmaAccumulatorHalf2WordAtPtx1263R318)); // PTX L5791
	r_LaneIndexAtPtx5794 = uint32_t((threadIdx.x & 31u));				 // PTX L5794
	r_PtxU64Register235 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5794)) * int64_t(int32_t(16))); // PTX L5796
	g_ScratchByteAddressAtPtx5797 =
		uint64_t(g_ScratchByteAddressAtPtx5761) + uint64_t(r_PtxU64Register235);			   // PTX L5797
	g_ScratchByteAddressAtPtx5798 = uint64_t(g_ScratchByteAddressAtPtx5797) + uint64_t(33280); // PTX L5798
	StoreNoAllocate(g_ScratchByteAddressAtPtx5798,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1270R319, r_MmaAccumulatorHalf2WordAtPtx1270R320,
							   r_MmaAccumulatorHalf2WordAtPtx1277R321,
							   r_MmaAccumulatorHalf2WordAtPtx1277R322));			  // PTX L5800
L__BB50_41:																			  // PTX L5802
	r_bPtxPredicate61 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister31);		  // PTX L5803
	r_PtxU64Register10 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register215); // PTX L5804
	if (r_bPtxPredicate61)
	{
		goto L__BB50_43;
	} // PTX L5805
	r_LaneIndexAtPtx5807 = uint32_t((threadIdx.x & 31u)); // PTX L5807
	r_PtxU64Register239 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5807)) * int64_t(int32_t(16)));		// PTX L5809
	r_PtxU64Register237 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register239); // PTX L5810
	StoreNoAllocate(r_PtxU64Register237,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1032R239, r_MmaAccumulatorHalf2WordAtPtx1032R240,
							   r_MmaAccumulatorHalf2WordAtPtx1039R241,
							   r_MmaAccumulatorHalf2WordAtPtx1039R242)); // PTX L5812
	r_LaneIndexAtPtx5815 = uint32_t((threadIdx.x & 31u));				 // PTX L5815
	r_PtxU64Register240 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5815)) * int64_t(int32_t(16)));		// PTX L5817
	r_PtxU64Register241 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register240); // PTX L5818
	r_PtxU64Register238 = uint64_t(r_PtxU64Register241) + uint64_t(512);				// PTX L5819
	StoreNoAllocate(r_PtxU64Register238,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1046R243, r_MmaAccumulatorHalf2WordAtPtx1046R244,
							   r_MmaAccumulatorHalf2WordAtPtx1053R245,
							   r_MmaAccumulatorHalf2WordAtPtx1053R246));	  // PTX L5821
L__BB50_43:																	  // PTX L5823
	r_bPtxPredicate62 = int32_t(r_PtxRegister37) >= int32_t(r_PtxRegister31); // PTX L5824
	r_PtxU64Register11 = uint64_t(r_PtxU64Register10) + uint64_t(32768);	  // PTX L5825
	if (r_bPtxPredicate62)
	{
		goto L__BB50_45;
	} // PTX L5826
	r_LaneIndexAtPtx5828 = uint32_t((threadIdx.x & 31u)); // PTX L5828
	r_PtxU64Register244 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5828)) * int64_t(int32_t(16)));		// PTX L5830
	r_PtxU64Register242 = uint64_t(r_PtxU64Register11) + uint64_t(r_PtxU64Register244); // PTX L5831
	StoreNoAllocate(r_PtxU64Register242,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1116R267, r_MmaAccumulatorHalf2WordAtPtx1116R268,
							   r_MmaAccumulatorHalf2WordAtPtx1123R269,
							   r_MmaAccumulatorHalf2WordAtPtx1123R270)); // PTX L5833
	r_LaneIndexAtPtx5836 = uint32_t((threadIdx.x & 31u));				 // PTX L5836
	r_PtxU64Register245 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5836)) * int64_t(int32_t(16)));		// PTX L5838
	r_PtxU64Register246 = uint64_t(r_PtxU64Register10) + uint64_t(r_PtxU64Register245); // PTX L5839
	r_PtxU64Register243 = uint64_t(r_PtxU64Register246) + uint64_t(33280);				// PTX L5840
	StoreNoAllocate(r_PtxU64Register243,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1130R271, r_MmaAccumulatorHalf2WordAtPtx1130R272,
							   r_MmaAccumulatorHalf2WordAtPtx1137R273,
							   r_MmaAccumulatorHalf2WordAtPtx1137R274));	  // PTX L5842
L__BB50_45:																	  // PTX L5844
	r_bPtxPredicate63 = int32_t(r_PtxRegister38) >= int32_t(r_PtxRegister31); // PTX L5845
	r_PtxU64Register12 = uint64_t(r_PtxU64Register11) + uint64_t(32768);	  // PTX L5846
	if (r_bPtxPredicate63)
	{
		goto L__BB50_47;
	} // PTX L5847
	r_LaneIndexAtPtx5849 = uint32_t((threadIdx.x & 31u)); // PTX L5849
	r_PtxU64Register249 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5849)) * int64_t(int32_t(16)));		// PTX L5851
	r_PtxU64Register247 = uint64_t(r_PtxU64Register12) + uint64_t(r_PtxU64Register249); // PTX L5852
	StoreNoAllocate(r_PtxU64Register247,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1200R295, r_MmaAccumulatorHalf2WordAtPtx1200R296,
							   r_MmaAccumulatorHalf2WordAtPtx1207R297,
							   r_MmaAccumulatorHalf2WordAtPtx1207R298)); // PTX L5854
	r_LaneIndexAtPtx5857 = uint32_t((threadIdx.x & 31u));				 // PTX L5857
	r_PtxU64Register250 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5857)) * int64_t(int32_t(16)));		// PTX L5859
	r_PtxU64Register251 = uint64_t(r_PtxU64Register11) + uint64_t(r_PtxU64Register250); // PTX L5860
	r_PtxU64Register248 = uint64_t(r_PtxU64Register251) + uint64_t(33280);				// PTX L5861
	StoreNoAllocate(r_PtxU64Register248,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1214R299, r_MmaAccumulatorHalf2WordAtPtx1214R300,
							   r_MmaAccumulatorHalf2WordAtPtx1221R301,
							   r_MmaAccumulatorHalf2WordAtPtx1221R302));	  // PTX L5863
L__BB50_47:																	  // PTX L5865
	r_bPtxPredicate64 = int32_t(r_PtxRegister39) >= int32_t(r_PtxRegister31); // PTX L5866
	if (r_bPtxPredicate64)
	{
		goto L__BB50_49;
	} // PTX L5867
	r_LaneIndexAtPtx5869 = uint32_t((threadIdx.x & 31u)); // PTX L5869
	r_PtxU64Register254 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5869)) * int64_t(int32_t(16)));		// PTX L5871
	r_PtxU64Register255 = uint64_t(r_PtxU64Register12) + uint64_t(r_PtxU64Register254); // PTX L5872
	r_PtxU64Register252 = uint64_t(r_PtxU64Register255) + uint64_t(32768);				// PTX L5873
	StoreNoAllocate(r_PtxU64Register252,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1284R323, r_MmaAccumulatorHalf2WordAtPtx1284R324,
							   r_MmaAccumulatorHalf2WordAtPtx1291R325,
							   r_MmaAccumulatorHalf2WordAtPtx1291R326)); // PTX L5875
	r_LaneIndexAtPtx5878 = uint32_t((threadIdx.x & 31u));				 // PTX L5878
	r_PtxU64Register256 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5878)) * int64_t(int32_t(16)));		// PTX L5880
	r_PtxU64Register257 = uint64_t(r_PtxU64Register12) + uint64_t(r_PtxU64Register256); // PTX L5881
	r_PtxU64Register253 = uint64_t(r_PtxU64Register257) + uint64_t(33280);				// PTX L5882
	StoreNoAllocate(r_PtxU64Register253,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1298R327, r_MmaAccumulatorHalf2WordAtPtx1298R328,
							   r_MmaAccumulatorHalf2WordAtPtx1305R329,
							   r_MmaAccumulatorHalf2WordAtPtx1305R330));			  // PTX L5884
L__BB50_49:																			  // PTX L5886
	r_bPtxPredicate65 = int32_t(r_PtxRegister35) >= int32_t(r_PtxRegister31);		  // PTX L5887
	r_PtxU64Register13 = uint64_t(r_PtxU64Register5) + uint64_t(r_PtxU64Register215); // PTX L5888
	if (r_bPtxPredicate65)
	{
		goto L__BB50_51;
	} // PTX L5889
	r_LaneIndexAtPtx5891 = uint32_t((threadIdx.x & 31u)); // PTX L5891
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5891)) * int64_t(int32_t(16)));		// PTX L5893
	r_PtxU64Register258 = uint64_t(r_PtxU64Register13) + uint64_t(r_PtxU64Register260); // PTX L5894
	StoreNoAllocate(r_PtxU64Register258,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1060R247, r_MmaAccumulatorHalf2WordAtPtx1060R248,
							   r_MmaAccumulatorHalf2WordAtPtx1067R249,
							   r_MmaAccumulatorHalf2WordAtPtx1067R250)); // PTX L5896
	r_LaneIndexAtPtx5899 = uint32_t((threadIdx.x & 31u));				 // PTX L5899
	r_PtxU64Register261 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5899)) * int64_t(int32_t(16)));		// PTX L5901
	r_PtxU64Register262 = uint64_t(r_PtxU64Register13) + uint64_t(r_PtxU64Register261); // PTX L5902
	r_PtxU64Register259 = uint64_t(r_PtxU64Register262) + uint64_t(512);				// PTX L5903
	StoreNoAllocate(r_PtxU64Register259,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1074R251, r_MmaAccumulatorHalf2WordAtPtx1074R252,
							   r_MmaAccumulatorHalf2WordAtPtx1081R253,
							   r_MmaAccumulatorHalf2WordAtPtx1081R254));	  // PTX L5905
L__BB50_51:																	  // PTX L5907
	r_bPtxPredicate66 = int32_t(r_PtxRegister37) >= int32_t(r_PtxRegister31); // PTX L5908
	r_PtxU64Register14 = uint64_t(r_PtxU64Register13) + uint64_t(32768);	  // PTX L5909
	if (r_bPtxPredicate66)
	{
		goto L__BB50_53;
	} // PTX L5910
	r_LaneIndexAtPtx5912 = uint32_t((threadIdx.x & 31u)); // PTX L5912
	r_PtxU64Register265 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5912)) * int64_t(int32_t(16)));		// PTX L5914
	r_PtxU64Register263 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register265); // PTX L5915
	StoreNoAllocate(r_PtxU64Register263,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1144R275, r_MmaAccumulatorHalf2WordAtPtx1144R276,
							   r_MmaAccumulatorHalf2WordAtPtx1151R277,
							   r_MmaAccumulatorHalf2WordAtPtx1151R278)); // PTX L5917
	r_LaneIndexAtPtx5920 = uint32_t((threadIdx.x & 31u));				 // PTX L5920
	r_PtxU64Register266 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5920)) * int64_t(int32_t(16)));		// PTX L5922
	r_PtxU64Register267 = uint64_t(r_PtxU64Register13) + uint64_t(r_PtxU64Register266); // PTX L5923
	r_PtxU64Register264 = uint64_t(r_PtxU64Register267) + uint64_t(33280);				// PTX L5924
	StoreNoAllocate(r_PtxU64Register264,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1158R279, r_MmaAccumulatorHalf2WordAtPtx1158R280,
							   r_MmaAccumulatorHalf2WordAtPtx1165R281,
							   r_MmaAccumulatorHalf2WordAtPtx1165R282));	  // PTX L5926
L__BB50_53:																	  // PTX L5928
	r_bPtxPredicate67 = int32_t(r_PtxRegister38) >= int32_t(r_PtxRegister31); // PTX L5929
	r_PtxU64Register15 = uint64_t(r_PtxU64Register14) + uint64_t(32768);	  // PTX L5930
	if (r_bPtxPredicate67)
	{
		goto L__BB50_55;
	} // PTX L5931
	r_LaneIndexAtPtx5933 = uint32_t((threadIdx.x & 31u)); // PTX L5933
	r_PtxU64Register270 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5933)) * int64_t(int32_t(16)));		// PTX L5935
	r_PtxU64Register268 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register270); // PTX L5936
	StoreNoAllocate(r_PtxU64Register268,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1228R303, r_MmaAccumulatorHalf2WordAtPtx1228R304,
							   r_MmaAccumulatorHalf2WordAtPtx1235R305,
							   r_MmaAccumulatorHalf2WordAtPtx1235R306)); // PTX L5938
	r_LaneIndexAtPtx5941 = uint32_t((threadIdx.x & 31u));				 // PTX L5941
	r_PtxU64Register271 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5941)) * int64_t(int32_t(16)));		// PTX L5943
	r_PtxU64Register272 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register271); // PTX L5944
	r_PtxU64Register269 = uint64_t(r_PtxU64Register272) + uint64_t(33280);				// PTX L5945
	StoreNoAllocate(r_PtxU64Register269,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1242R307, r_MmaAccumulatorHalf2WordAtPtx1242R308,
							   r_MmaAccumulatorHalf2WordAtPtx1249R309,
							   r_MmaAccumulatorHalf2WordAtPtx1249R310)); // PTX L5947
L__BB50_55:																 // PTX L5949
	if (r_bPtxPredicate64)
	{
		goto L__BB50_125;
	} // PTX L5950
	r_LaneIndexAtPtx5952 = uint32_t((threadIdx.x & 31u)); // PTX L5952
	r_PtxU64Register275 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5952)) * int64_t(int32_t(16)));		// PTX L5954
	r_PtxU64Register276 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register275); // PTX L5955
	r_PtxU64Register273 = uint64_t(r_PtxU64Register276) + uint64_t(32768);				// PTX L5956
	StoreNoAllocate(r_PtxU64Register273,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1312R331, r_MmaAccumulatorHalf2WordAtPtx1312R332,
							   r_MmaAccumulatorHalf2WordAtPtx1319R333,
							   r_MmaAccumulatorHalf2WordAtPtx1319R334)); // PTX L5958
	r_LaneIndexAtPtx5961 = uint32_t((threadIdx.x & 31u));				 // PTX L5961
	r_PtxU64Register277 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx5961)) * int64_t(int32_t(16)));		// PTX L5963
	r_PtxU64Register278 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register277); // PTX L5964
	r_PtxU64Register274 = uint64_t(r_PtxU64Register278) + uint64_t(33280);				// PTX L5965
	StoreNoAllocate(r_PtxU64Register274,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx1326R335, r_MmaAccumulatorHalf2WordAtPtx1326R336,
							   r_MmaAccumulatorHalf2WordAtPtx1333R337,
							   r_MmaAccumulatorHalf2WordAtPtx1333R338)); // PTX L5967
L__BB50_125:															 // PTX L5969
	__syncthreads();													 // PTX L5970
	r_ThreadZAtPtx5971 = uint32_t(threadIdx.z);							 // PTX L5971
	r_PtxRegister1451 = r_PtxRegister66 | r_ThreadZAtPtx5971;			 // PTX L5972
	r_bPtxPredicate68 = uint32_t(r_PtxRegister1451) != uint32_t(0);		 // PTX L5973
	if (r_bPtxPredicate68)
	{
		goto L__BB50_127;
	} // PTX L5974
	// Phase: ordered_counter_publication. Global counter publication uses the original release operation. Do not move resets, waits or data writes across this boundary.
	CounterStoreRelease(g_CounterByteAddress, r_CtaZ);						   // PTX L5976
L__BB50_127:																   // PTX L5978
	return;																	   // PTX L5979
L__BB50_28:																	   // PTX L5980
	r_PtxRegister32 = uint32_t(r_CtaZ) + uint32_t(-1);						   // PTX L5981
L__BB50_29:																	   // PTX L5982
	r_PtxRegister356 = CounterLoadRelaxed(g_CounterByteAddress);			   // PTX L5984
	r_bPtxPredicate23 = int32_t(r_PtxRegister356) >= int32_t(r_PtxRegister32); // PTX L5986
	if (r_bPtxPredicate23)
	{
		goto L__BB50_57;
	} // PTX L5987
	r_PtxRegister1420 = uint32_t(64); // PTX L5988
	PollSleep(r_PtxRegister1420);	  // PTX L5990
	goto L__BB50_29;				  // PTX L5992
#endif
}
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp8
